;  isr.asm - assembly interrupt stubs.
;
;  INT 29h (console output, very hot): a MINIMAL stub that appends AL to the
;  capture ring and then TAIL-CHAINS to the original handler for native-speed
;  display.  It runs on whatever stack DOS issued INT 29h on -- it only needs a
;  few register saves plus a tiny C call, far less than DOS's native INT 29h
;  handler already uses, and it pops everything before chaining so the original
;  handler sees the full stack and the original registers.  Keeping this tiny is
;  what lets big block writes (a 15 KB `type`) stay fast and not starve serial.
;
;  INT 28h (DOS idle, for deferred file I/O): switches SS:SP to a private stack
;  before any work, because DOS issues it from deep inside itself on a stack
;  with no headroom (Watcom's __interrupt prologue would overflow it).
;
;  Built with `wasm -0 -ml`.  Explicit 'segment ... CODE' + 'assume cs:' so the
;  scratch words below are addressed CS-relative (DS is not valid on entry).

        .8086

        extrn   cap_ring_write_ : far   ; void cap_ring_write(unsigned char al)
        extrn   idle_isr_c_     : far   ; void idle_isr_c(void)

ISR_TEXT segment byte public 'CODE'
        assume  cs:ISR_TEXT

cap_old29_off   dw      0               ; original INT 29h vector (off, then seg)
cap_old29_seg   dw      0

idle_ss_save    dw      0
idle_sp_save    dw      0
idle_ss_priv    dw      0
idle_sp_priv    dw      0

;-----------------------------------------------------------------------
; INT 29h: AL = character.  Capture it, then jump to the original handler.
        public  int29_stub_
int29_stub_     proc    far
        push    ax                     ; AL = char; keep it for the native handler
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        push    ds
        push    es
        call    cap_ring_write_        ; cap_ring_write(AL) -- ring/ringHead are far
        pop     es
        pop     ds
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax                     ; restore caller's AX (= char)
        jmp     dword ptr cs:cap_old29_off    ; native display + IRET to caller
int29_stub_     endp

;-----------------------------------------------------------------------
; INT 28h: drain a deferred file op on a private stack.
        public  int28_stub_
int28_stub_     proc    far
        mov     cs:idle_ss_save, ss
        mov     cs:idle_sp_save, sp
        cli
        mov     ss, cs:idle_ss_priv
        mov     sp, cs:idle_sp_priv
        sti
        push    ax
        push    ds
        push    es
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    bp
        mov     ax, ss
        mov     ds, ax
        call    idle_isr_c_
        pop     bp
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     es
        pop     ds
        pop     ax
        cli
        mov     ss, cs:idle_ss_save
        mov     sp, cs:idle_sp_save
        sti
        iret
int28_stub_     endp

;-----------------------------------------------------------------------
; Setters (watcall: 1st arg in AX, 2nd in DX).
        public  cap_set_old29_         ; (uint16 seg, uint16 off)
cap_set_old29_  proc    far
        mov     cs:cap_old29_off, dx
        mov     cs:cap_old29_seg, ax
        ret
cap_set_old29_  endp

        public  idle_set_stack_        ; (uint16 ss, uint16 sp)
idle_set_stack_ proc    far
        mov     cs:idle_ss_priv, ax
        mov     cs:idle_sp_priv, dx
        ret
idle_set_stack_ endp

ISR_TEXT ends
        end
