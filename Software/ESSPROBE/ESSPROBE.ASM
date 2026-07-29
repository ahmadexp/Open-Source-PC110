; ESSPROBE.COM - identify the PC110's audio chip and dump its mixer.
; Read-only by construction: it resets the SB DSP (harmless, standard), issues
; two QUERY commands (0xE1 get-version, 0xE7 get-ESS-ID), and reads the mixer by
; writing only the mixer INDEX register and reading DATA back. It never writes a
; mixer data byte, so no setting is changed.
;
; Purpose: find out what silicon is actually fitted and whether it has capability
; the machine is not using -- the PC110 configures its ES488 as Sound Blaster 2.0
; at 0x220 (see Discovery/ES488), which may be below what the part supports.
        org 0x100
BASE    equ 0x220               ; PC110 audio base (PS2.EXE 'ADDAUdio 0220')
RESET   equ BASE+0x6
RDATA   equ BASE+0xA
WDATA   equ BASE+0xC            ; bit7=0 -> ready for a command/data write
RSTAT   equ BASE+0xE            ; bit7=1 -> read data available
MIXIDX  equ BASE+0x4
MIXDAT  equ BASE+0x5
start:
        mov     dx, m_hdr
        call    puts
        ; ---------- DSP reset handshake ----------
        mov     dx, RESET
        mov     al, 1
        out     dx, al
        mov     cx, 0x0400              ; >3us delay
.d1:    in      al, 0x80
        loop    .d1
        mov     dx, RESET
        xor     al, al
        out     dx, al
        call    rd_dsp                  ; expect 0xAA
        jc      .nodsp
        cmp     al, 0xAA
        jne     .nodsp
        mov     dx, m_ok
        call    puts
        ; ---------- DSP version (0xE1) ----------
        mov     al, 0xE1
        call    wr_dsp
        call    rd_dsp
        mov     [vmaj], al
        call    rd_dsp
        mov     [vmin], al
        mov     dx, m_ver
        call    puts
        mov     al, [vmaj]
        call    pdec
        mov     al, '.'
        call    pchr
        mov     al, [vmin]
        call    pdec
        ; interpret
        mov     al, [vmaj]
        cmp     al, 4
        jae     .sb16
        cmp     al, 3
        je      .sbpro
        mov     dx, m_sb2
        jmp     .vp
.sbpro: mov     dx, m_pro
        jmp     .vp
.sb16:  mov     dx, m_sb16
.vp:    call    puts
        ; ---------- ESS chip ID (0xE7) ----------
        mov     al, 0xE7
        call    wr_dsp
        call    rd_dsp
        jc      .noess
        mov     [eid1], al
        call    rd_dsp
        jc      .noess
        mov     [eid2], al
        mov     dx, m_eid
        call    puts
        mov     al, [eid1]
        call    phex
        mov     al, ' '
        call    pchr
        mov     al, [eid2]
        call    phex
        mov     dx, m_eidn
        call    puts
        jmp     .mixer
.noess: mov     dx, m_noess
        call    puts
.mixer:
        ; ---------- mixer dump (index writes only) ----------
        mov     dx, m_mix
        call    puts
        xor     bl, bl                  ; index 0x00..0x7F
.ml:    test    bl, 0x0F
        jnz     .nonl
        call    crlf
        mov     al, bl                  ; row label
        call    phex
        mov     al, ':'
        call    pchr
        mov     al, ' '
        call    pchr
.nonl:  mov     al, bl
        mov     dx, MIXIDX
        out     dx, al
        in      al, 0x80                ; settle
        mov     dx, MIXDAT
        in      al, dx
        call    phex
        mov     al, ' '
        call    pchr
        inc     bl
        cmp     bl, 0x80
        jb      .ml
        call    crlf
        mov     dx, m_note
        call    puts
        mov     ax, 0x4C00
        int     0x21
.nodsp: mov     dx, m_nodsp
        call    puts
        mov     ax, 0x4C01
        int     0x21

; wr_dsp: AL = byte -> DSP write port (waits for bit7 clear)
wr_dsp: push    dx
        push    ax
        mov     dx, WDATA
        mov     cx, 0xFFFF
.w:     in      al, dx
        test    al, 0x80
        jz      .rdy
        dec     cx
        jnz     .w
.rdy:   pop     ax
        out     dx, al
        pop     dx
        ret
; rd_dsp: -> AL, CF=1 on timeout
rd_dsp: push    dx
        mov     dx, RSTAT
        mov     cx, 0xFFFF
.w:     in      al, dx
        test    al, 0x80
        jnz     .got
        dec     cx
        jnz     .w
        pop     dx
        stc
        ret
.got:   mov     dx, RDATA
        in      al, dx
        pop     dx
        clc
        ret
puts:   mov     ah, 0x09
        int     0x21
        ret
pchr:   push    dx
        mov     dl, al
        mov     ah, 0x02
        int     0x21
        pop     dx
        ret
phex:   push    cx
        mov     cl, al
        mov     al, cl
        shr     al, 4
        call    .n
        mov     al, cl
        call    .n
        pop     cx
        ret
.n:     and     al, 0x0F
        cmp     al, 10
        jb      .d
        add     al, 'A'-10
        jmp     .o
.d:     add     al, '0'
.o:     call    pchr
        ret
pdec:   aam
        add     ax, 0x3030
        push    ax
        mov     al, ah
        call    pchr
        pop     ax
        call    pchr
        ret
crlf:   mov     al, 13
        call    pchr
        mov     al, 10
        call    pchr
        ret
vmaj    db 0
vmin    db 0
eid1    db 0
eid2    db 0
m_hdr   db 13,10,"ESSPROBE - PC110 audio chip identification (read-only)",13,10
        db "base 0x220",13,10,"$"
m_ok    db "DSP reset: OK (0xAA)",13,10,"$"
m_nodsp db "DSP did NOT respond at 0x220 -- audio disabled in setup, or a",13,10
        db "different base. Check PS2.EXE ADDAUdio / IRQAudio / DMAAudio.",13,10,"$"
m_ver   db "DSP version: $"
m_sb2   db "   -> Sound Blaster 2.0 class",13,10,"$"
m_pro   db "   -> Sound Blaster Pro class (stereo capable)",13,10,"$"
m_sb16  db "   -> SB16 class",13,10,"$"
m_eid   db "ESS chip ID (0xE7): $"
m_eidn  db "   (first byte = family: 0x48 = ES488, 0x68 = ES688/ES1688)",13,10,"$"
m_noess db "No response to 0xE7 -- not an ESS part, or the query was refused.",13,10,"$"
m_mix   db "Mixer registers 0x00-0x7F (index writes only, data read-only):",13,10,"$"
m_note  db 13,10,"Note: DSP 2.x + an ESS ID = the part is running in SB 2.0 mode. All-FF",13,10
        db "mixer reads mean no SB Pro mixer is decoded (expected in SB 2.0 mode).",13,10,"$"
