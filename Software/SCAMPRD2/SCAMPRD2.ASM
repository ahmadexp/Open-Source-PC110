; SCAMPRD.COM - read-only PC110 EC/ED geometry regs + Pluto[0x05] strap.
; Gated EC/ED (out 0xFB enable / out 0xF9 disable) under CLI; reads only.
        org 0x100
start:
        cli
        out     0xFB, al            ; open EC/ED config window (value irrelevant)
        xor     bl, bl
        mov     di, buf
.rd:    mov     al, bl
        out     0xEC, al            ; index
        in      al, 0xED            ; data
        mov     [di], al
        inc     di
        inc     bl
        cmp     bl, 16
        jb      .rd
        out     0xF9, al            ; close EC/ED window
        mov     al, 0x05            ; Pluto 0x35EA idx 5 (strap read, ungated)
        mov     dx, 0x35EA
        out     dx, al
        mov     dx, 0x35EB
        in      al, dx
        mov     [di], al            ; 17th byte = Pluto[5]
        sti
        mov     si, buf             ; print 17 bytes as space-separated hex
        mov     cx, 17
.pl:    mov     al, [si]
        call    phex
        mov     dl, ' '
        mov     ah, 2
        int     0x21
        inc     si
        loop    .pl
        mov     dl, 13
        mov     ah, 2
        int     0x21
        mov     dl, 10
        mov     ah, 2
        int     0x21
        mov     ax, 0x4C00
        int     0x21
phex:                               ; AL -> two hex chars
        push    cx
        mov     cl, al
        mov     al, cl
        shr     al, 4
        call    nib
        mov     al, cl
        call    nib
        pop     cx
        ret
nib:    and     al, 0x0F
        cmp     al, 10
        jb      .d
        add     al, 'A'-10
        jmp     .o
.d:     add     al, '0'
.o:     mov     dl, al
        mov     ah, 2
        int     0x21
        ret
buf:    times 17 db 0
