; ============================================================================
; PS2GUI.COM  -  Graphical (VGA) system manager for the IBM PalmTop PC110
; A GUI fork of PS2TUI that reproduces the IBM *Easy-Setup* screen pixel-exact:
; the mauve desktop, the white icon tiles with dark-red line art (Config,
; Date/Time, Password, Start up, Test, Restart), the "Easy-Setup" title, the
; duck and the copyright line -- lifted straight from the real Easy-Setup
; graphics (640x480 mode 12h, 4 bit-planes; see ESDATA.INC, auto-generated
; from a pixel-exact Easy-Setup capture).
;
; Version 0.1  (c) Ahmad Byagowi
; Build (host):  nasm -f bin PS2GUI.ASM -o PS2GUI.COM
; Target: MS-DOS / PC DOS 7 (real mode), VGA mode 12h. Assemble as a .COM.
; ============================================================================
        cpu     386
        bits    16
        org     0x100

HL_COLOR  equ 2                 ; selection-box colour (dark red, palette idx 2)

start:
        ; --- remember the current video mode ---
        mov     ah, 0x0F
        int     0x10
        mov     [savemode], al
        ; --- enter VGA mode 12h (640x480x16) ---
        mov     ax, 0x0012
        int     0x10
        call    set_palette      ; load the exact Easy-Setup colours
        call    blit_screen      ; paint the whole Easy-Setup screen
        mov     word [sel], 0
        mov     al, HL_COLOR
        call    draw_ring        ; highlight the first icon

.loop:
        call    getkey           ; AL=ascii AH=scan
        cmp     al, 0x1B         ; ESC -> quit
        je      .quit
        cmp     al, 0x0D         ; Enter -> activate
        je      .enter
        cmp     al, 0
        jne     .loop
        cmp     ah, 0x4B         ; left
        je      .prev
        cmp     ah, 0x48         ; up
        je      .prev
        cmp     ah, 0x4D         ; right
        je      .next
        cmp     ah, 0x50         ; down
        je      .next
        jmp     .loop

.prev:
        call    hl_erase
        mov     ax, [sel]
        dec     ax
        jns     .ps
        mov     ax, ICON_N-1
.ps:    mov     [sel], ax
        jmp     .redraw
.next:
        call    hl_erase
        mov     ax, [sel]
        inc     ax
        cmp     ax, ICON_N
        jb      .ns
        xor     ax, ax
.ns:    mov     [sel], ax
.redraw:
        mov     al, HL_COLOR
        call    draw_ring
        jmp     .loop

.enter:
        cmp     word [sel], 5    ; Restart tile -> warm reboot
        je      .reboot
        jmp     .quit            ; (other tiles: wiring to the PS2 functions is next)
.reboot:
        call    restore_mode
        mov     ax, 0x40
        mov     es, ax
        mov     word [es:0x72], 0x1234   ; warm-boot flag
        jmp     0xFFFF:0x0000
.quit:
        call    restore_mode
        mov     ax, 0x4C00
        int     0x21

; ----------------------------------------------------------------------------
restore_mode:
        mov     ah, 0x00
        mov     al, [savemode]
        int     0x10
        ret

getkey:
        mov     ah, 0
        int     0x16
        ret

; set DAC entries 0..PAL_N-1 from the espal table (r,g,b 6-bit)
set_palette:
        mov     si, espal
        xor     bx, bx
.pl:    mov     dh, [si]         ; red
        mov     ch, [si+1]       ; green
        mov     cl, [si+2]       ; blue
        mov     ax, 0x1010
        int     0x10             ; set DAC register BX
        add     si, 3
        inc     bx
        cmp     bx, PAL_N
        jb      .pl
        ret

; blit the 4 RLE-compressed bit-planes into A000 (map-mask per plane)
blit_screen:
        push    es
        mov     ax, 0xA000
        mov     es, ax
        xor     bp, bp                   ; plane 0..3
.pl:
        mov     dx, 0x3C4                ; Sequencer: Map Mask = 1<<plane
        mov     al, 0x02
        out     dx, al
        inc     dx
        mov     bx, bp
        mov     al, [mm_tab+bx]
        out     dx, al
        mov     bx, bp
        shl     bx, 1
        mov     si, [esplanes+bx]        ; RLE stream for this plane
        xor     di, di
.dec:   lodsb                            ; count
        mov     ah, al
        lodsb                            ; value
        mov     cl, ah
        xor     ch, ch
        rep     stosb                    ; write CX copies of AL
        cmp     di, 38400                ; 80 bytes/row * 480 rows
        jb      .dec
        inc     bp
        cmp     bp, 4
        jb      .pl
        ; restore all planes enabled
        mov     dx, 0x3C4
        mov     al, 0x02
        out     dx, al
        inc     dx
        mov     al, 0x0F
        out     dx, al
        pop     es
        ret

; erase the current selection box (redraw the ring in mauve)
hl_erase:
        xor     al, al                   ; palette idx 0 = mauve background
        ; fall through
; draw_ring : AL = colour ; draws a 3-px box in the mauve gap around icon [sel]
draw_ring:
        mov     [ringcol], al
        mov     bx, [sel]
        shl     bx, 3                     ; *8 bytes per icon record
        mov     ax, [icons+bx]
        mov     [bx0], ax
        mov     ax, [icons+bx+2]
        mov     [by0], ax
        mov     ax, [icons+bx+4]
        mov     [bx1], ax
        mov     ax, [icons+bx+6]
        mov     [by1], ax
        mov     byte [ringm], 3
.ring:
        ; expand box by the current margin into (rx0,ry0)-(rx1,ry1)
        mov     al, [ringm]
        cbw
        mov     cx, ax
        mov     ax, [bx0]
        sub     ax, cx
        mov     [rx0], ax
        mov     ax, [by0]
        sub     ax, cx
        mov     [ry0], ax
        mov     ax, [bx1]
        add     ax, cx
        mov     [rx1], ax
        mov     ax, [by1]
        add     ax, cx
        mov     [ry1], ax
        ; top + bottom edges
        mov     dx, [ry0]
        call    hline
        mov     dx, [ry1]
        call    hline
        ; left + right edges
        mov     cx, [rx0]
        call    vline
        mov     cx, [rx1]
        call    vline
        inc     byte [ringm]
        cmp     byte [ringm], 6
        jb      .ring
        ret

; hline : draw from rx0..rx1 at row DX in [ringcol]
hline:
        push    dx
        mov     cx, [rx0]
.h:     mov     al, [ringcol]
        call    putpixel
        inc     cx
        cmp     cx, [rx1]
        jbe     .h
        pop     dx
        ret

; vline : draw from ry0..ry1 at col CX in [ringcol]
vline:
        push    cx
        mov     dx, [ry0]
.v:     mov     al, [ringcol]
        call    putpixel
        inc     dx
        cmp     dx, [ry1]
        jbe     .v
        pop     cx
        ret

; putpixel : CX=x DX=y AL=colour
putpixel:
        push    ax
        push    bx
        mov     ah, 0x0C
        xor     bh, bh
        int     0x10
        pop     bx
        pop     ax
        ret

; ============================================================================
;  DATA
; ============================================================================
savemode  db 0
sel       dw 0
ringcol   db 0
ringm     db 0
bx0       dw 0
by0       dw 0
bx1       dw 0
by1       dw 0
rx0       dw 0
ry0       dw 0
rx1       dw 0
ry1       dw 0
mm_tab    db 1, 2, 4, 8

%include "ESDATA.INC"
