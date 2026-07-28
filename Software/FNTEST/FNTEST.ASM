; FNTEST.COM - PC110 raw-scancode monitor. Hooks INT 9 and shows every byte the
; keyboard controller delivers, so you can see exactly what (if anything) the Fn
; key produces. Read-only w.r.t. hardware: it only reads port 0x60 in the hook.
; ESC ESC ESC (three in a row) exits.
        org 0x100
start:
        mov     dx, msg
        mov     ah, 0x09
        int     0x21
        xor     ax, ax                  ; save old INT 9
        mov     es, ax
        mov     ax, [es:9*4]
        mov     [oldo], ax
        mov     ax, [es:9*4+2]
        mov     [olds], ax
        cli
        mov     word [es:9*4], hook
        mov     [es:9*4+2], cs
        sti
.wait:  cmp     byte [escs], 3          ; three ESCs -> quit
        jb      .wait
        cli                             ; restore INT 9
        xor     ax, ax
        mov     es, ax
        mov     ax, [oldo]
        mov     [es:9*4], ax
        mov     ax, [olds]
        mov     [es:9*4+2], ax
        sti
        mov     dx, bye
        mov     ah, 0x09
        int     0x21
        mov     ax, 0x4C00
        int     0x21

hook:                                   ; INT 9 handler: print the raw byte
        push    ax
        push    bx
        push    dx
        in      al, 0x60
        mov     [last], al
        cmp     al, 0x01                ; ESC make (set 1) -> count for exit
        jne     .nesc
        inc     byte [escs]
        jmp     .show
.nesc:  cmp     al, 0x81                ; ignore ESC break for the counter
        je      .show
        mov     byte [escs], 0
.show:  mov     al, [last]              ; print as 2 hex digits + space
        mov     bl, al
        shr     al, 4
        call    nib
        mov     al, bl
        call    nib
        mov     dl, ' '
        mov     ah, 0x0E
        mov     al, dl
        mov     bx, 0x0007
        int     0x10
        pop     dx
        pop     bx
        pop     ax
        ; chain to the original handler so DOS still works
        jmp     far [cs:oldo]
nib:    and     al, 0x0F
        cmp     al, 10
        jb      .d
        add     al, 'A'-10
        jmp     .o
.d:     add     al, '0'
.o:     mov     ah, 0x0E
        mov     bx, 0x0007
        int     0x10
        ret
oldo    dw 0
olds    dw 0
last    db 0
escs    db 0
msg     db "FNTEST - raw keyboard scancode monitor",13,10
        db "Every byte the KBC sends is shown in hex.",13,10
        db "Press Fn (alone) and watch: if nothing appears, the KBC swallows it.",13,10
        db "Then try Fn+Up etc. to see whether the CODE changes instead.",13,10
        db "Press ESC three times to exit.",13,10,13,10,"$"
bye     db 13,10,"FNTEST done.",13,10,"$"
