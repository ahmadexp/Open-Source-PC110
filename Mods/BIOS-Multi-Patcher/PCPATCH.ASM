; PCPATCH.COM - IBM PC110 BIOS multi-patcher (enhanced vpatch, "one tool").
; Menu: DSTN->TFT, TFT->DSTN, Windows 256-colour, 32MB patch, 32MB undo.
; Runs from a floppy boot (where the 12V VPP rail is up). Flash sequence is
; byte-identical to vpatch. Staging is CS-relative so it never collides with
; resident code or its own stack. Reflashes only the 96KB main block; the boot
; block (reset vector) is never touched.
        org 0x100
;=================================== MENU ===================================
start:
        mov     dx, msg_banner
        call    puts
.menu:  mov     dx, msg_menu
        call    puts
        mov     ah, 0
        int     0x16                    ; wait key
        cmp     al, 27
        je      .quit
        cmp     al, '1'
        je      .op1
        cmp     al, '2'
        je      .op2
        cmp     al, '3'
        je      .op3
        cmp     al, '4'
        je      .op4
        cmp     al, '5'
        je      .op5
        cmp     al, '6'
        je      .op6
        jmp     .menu
.op6:   call    diag
        jmp     .menu
.quit:  mov     dx, msg_bye
        call    puts
        mov     ax, 0x4C00
        int     0x21
.op1:   mov     byte [op], 1
        jmp     confirm
.op2:   mov     byte [op], 2
        jmp     confirm
.op3:   mov     byte [op], 3
        jmp     confirm
.op4:   mov     byte [op], 4
        jmp     confirm
.op5:   mov     byte [op], 5
        jmp     confirm

;================================ CONFIRM/RUN ================================
confirm:
        mov     dx, msg_warn
        call    puts
        mov     ah, 0
        int     0x16
        cmp     al, 'Y'
        je      .ok
        cmp     al, 'y'
        je      .ok
        mov     dx, msg_abort
        call    puts
        jmp     start.menu
.ok:
        ; ---- power check: INT 15h 530A (AC + battery >= 20%) ----
        mov     ah, 0x53
        mov     al, 0x0A
        mov     bx, 0x0001
        int     0x15
        cmp     bh, 0x01
        jne     .noac
        cmp     cl, 0x13
        jle     .nobatt
        ; ---- compute CS-relative staging; check it fits below video RAM ----
        mov     ax, cs
        add     ax, 0x1000
        mov     [eseg], ax
        mov     bx, ax
        add     bx, 0x1000
        mov     [fseg], bx
        add     bx, 0x0800
        cmp     bx, 0xA000
        jae     .nomem
        ; ---- per-op precondition + (for ops that save/load) file I/O first ----
        mov     al, [op]
        cmp     al, 1
        je      .pre_tft
        cmp     al, 2
        je      .pre_dstn
        cmp     al, 4
        je      .pre_m32on
        cmp     al, 5
        je      .pre_m32off
        jmp     .doflash                ; op3 (256-colour): no precondition
.pre_tft:
        ; capture current 18 video-BIOS bytes from the C000 shadow -> panel_sav,
        ; then write them to A:\PANEL.SAV (backup, so op2 can restore them)
        call    cap_vbios
        call    save_panel
        jc      .savefail
        jmp     .doflash
.pre_dstn:
        call    load_panel              ; prefer this machine's own backup
        jnc     .doflash
        mov     si, dstn_val            ; no backup: use the confirmed stock DSTN set
        mov     di, panel_sav
        mov     cx, 18
.cpd:   mov     al, [cs:si]
        mov     [cs:di], al
        inc     si
        inc     di
        loop    .cpd
        mov     dx, m_usedef
        call    puts
        jmp     .doflash
.pre_m32on:
        mov     ax, 0xF000              ; F000:6095 must be stock 83 C3 40
        mov     es, ax
        cmp     byte [es:0x6095], 0x83
        jne     .m32bad
        cmp     byte [es:0x6096], 0xC3
        jne     .m32bad
        cmp     byte [es:0x6097], 0x40
        jne     .m32bad
        jmp     .doflash
.pre_m32off:
        mov     ax, 0xF000              ; F000:6095 must be patched E9 36 C5
        mov     es, ax
        cmp     byte [es:0x6095], 0xE9
        jne     .m32bad
        cmp     byte [es:0x6096], 0x36
        jne     .m32bad
        cmp     byte [es:0x6097], 0xC5
        jne     .m32bad
        jmp     .doflash
.doflash:
        mov     dx, msg_flash
        call    puts
        call    flash_enable
        call    flash_copy_current
        call    apply_op                ; op-specific staging edits
        call    flash_program
        mov     dx, msg_done
        call    puts
        jmp     start.menu
.noac:    mov     dx, msg_ac
        call    puts
        jmp     start.menu
.nobatt:  mov     dx, msg_batt
        call    puts
        jmp     start.menu
.nomem:   mov     dx, msg_nomem
        call    puts
        jmp     start.menu
.nosave:  mov     dx, msg_nosave
        call    puts
        jmp     start.menu
.savefail:mov     dx, msg_sverr
        call    puts
        jmp     start.menu
.m32bad:  mov     dx, msg_m32bad
        call    puts
        jmp     start.menu

;=========================== OP-SPECIFIC STAGING ============================
; apply_op: edit the staging buffers per [op]. eseg=video BIOS, fseg=F-lower.
apply_op:
        mov     al, [op]
        cmp     al, 1
        je      .tft
        cmp     al, 2
        je      .dstn
        cmp     al, 3
        je      .w256
        cmp     al, 4
        je      .m32on
        cmp     al, 5
        je      .m32off
        ret
.tft:   mov     bx, tft_val             ; write 18 TFT values into eseg
        call    write18
        ret
.dstn:  mov     bx, panel_sav           ; write the 18 saved DSTN values into eseg
        call    write18
        ret
.w256:  mov     es, [cs:eseg]           ; just the Windows 256-colour byte
        mov     byte [es:0x1CB], 0x1F
        ret
.m32on: mov     es, [cs:fseg]
        mov     byte [es:0x6095], 0xE9
        mov     byte [es:0x6096], 0x36
        mov     byte [es:0x6097], 0xC5
        mov     si, mem_stub_p
        mov     di, 0x25CE
        jmp     .stub15
.m32off:mov     es, [cs:fseg]
        mov     byte [es:0x6095], 0x83
        mov     byte [es:0x6096], 0xC3
        mov     byte [es:0x6097], 0x40
        mov     si, mem_stub_o
        mov     di, 0x25CE
.stub15:mov     cx, 15
.sl:    mov     al, [cs:si]
        mov     [es:di], al
        inc     si
        inc     di
        loop    .sl
        ret

; write18: write 18 bytes [cs:bx] into eseg at offsets tft_off[]
write18:
        mov     es, [cs:eseg]
        xor     si, si
.w:     mov     di, si
        add     di, di
        mov     di, [cs:tft_off+di]
        mov     al, [cs:bx+si]
        mov     [es:di], al
        inc     si
        cmp     si, 18
        jb      .w
        ret

; cap_vbios: read current 18 video-BIOS bytes from the C000 shadow -> panel_sav
cap_vbios:
        push    ds
        mov     ax, 0xC000
        mov     ds, ax
        xor     si, si
.c:     mov     di, si
        add     di, di
        mov     di, [cs:tft_off+di]
        mov     al, [di]
        mov     [cs:panel_sav+si], al
        inc     si
        cmp     si, 18
        jb      .c
        pop     ds
        ret

;============================== FILE I/O (A:) ==============================
save_panel:                             ; panel_sav(18) -> A:\PANEL.SAV ; CF=err
        push    cs
        pop     ds
        mov     ah, 0x3C
        xor     cx, cx
        mov     dx, fn_panel
        int     0x21
        jc      .e
        mov     bx, ax
        mov     ah, 0x40
        mov     cx, 18
        mov     dx, panel_sav
        int     0x21
        mov     ah, 0x3E
        int     0x21
        clc
        ret
.e:     stc
        ret
load_panel:                             ; A:\PANEL.SAV -> panel_sav(18) ; CF=err
        push    cs
        pop     ds
        mov     ax, 0x3D00
        mov     dx, fn_panel
        int     0x21
        jc      .e
        mov     bx, ax
        mov     ah, 0x3F
        mov     cx, 18
        mov     dx, panel_sav
        int     0x21
        pushf
        mov     ah, 0x3E
        int     0x21
        popf
        jc      .e
        cmp     ax, 18
        jne     .e
        clc
        ret
.e:     stc
        ret

;================================ HELPERS ================================
puts:   push    cs
        pop     ds
        mov     ah, 0x09
        int     0x21
        ret


;================================ DIAGNOSE ================================
; diag: READ-ONLY report of which BIOS patches are present. Reads the C000
; video-BIOS shadow and the F000 system-BIOS shadow only -- no port I/O and no
; flash commands, so it is safe from any boot device (no floppy/VPP needed).
;   panel  : XR54 @ vbios 0x0AA6 -- C0 = TFT (25 MHz dot clock)
;                                   C8 = DSTN (15 MHz)   [vpatch source]
;   win256 : vbios 0x01CB == 0x1F  (the "linear start" fix)
;   32 MB  : F000:6095 == E9 36 C5 (patched) vs 83 C3 40 (stock)
diag:
        mov     dx, m_dhdr
        call    puts
        ; ---- read the video-BIOS shadow at C000 ----
        mov     ax, 0xC000
        mov     es, ax
        mov     al, [es:0x0AA6]
        mov     [d_xr54], al
        mov     al, [es:0x01CB]
        mov     [d_1cb], al
        xor     bl, bl                  ; BL = TFT matches, BH = DSTN matches
        xor     bh, bh
        xor     si, si
.cnt:   mov     di, si
        add     di, di
        mov     di, [cs:tft_off+di]
        mov     al, [es:di]
        cmp     al, [cs:tft_val+si]
        jne     .n1
        inc     bl
.n1:    cmp     al, [cs:dstn_val+si]
        jne     .n2
        inc     bh
.n2:    inc     si
        cmp     si, 18
        jb      .cnt
        mov     [d_nm], bl
        mov     [d_nd], bh
        ; ---- panel verdict ----
        mov     dx, m_dpan
        call    puts
        mov     al, [d_nm]              ; verdict from the 18-byte tables
        cmp     al, 18
        je      .ptft
        mov     al, [d_nd]
        cmp     al, 18
        je      .pdstn
        mov     dx, m_pmix
        jmp     .pp
.ptft:  mov     dx, m_ptft
        jmp     .pp
.pdstn: mov     dx, m_pdstn
.pp:    call    puts
        mov     dx, m_dxr
        call    puts
        mov     al, [d_xr54]
        call    phex
        mov     dx, m_dmt
        call    puts
        mov     al, [d_nm]
        call    pdec
        mov     dx, m_dmt2
        call    puts
        mov     al, [d_nd]
        call    pdec
        mov     dx, m_d18
        call    puts
        ; ---- Windows 256-colour ----
        mov     dx, m_dw256
        call    puts
        mov     al, [d_1cb]
        cmp     al, 0x1F
        je      .w1
        mov     dx, m_absent
        jmp     .w2
.w1:    mov     dx, m_present
.w2:    call    puts
        mov     dx, m_dat
        call    puts
        mov     al, [d_1cb]
        call    phex
        mov     dx, m_crlf2
        call    puts
        ; ---- 32 MB memory patch (F000 system-BIOS shadow) ----
        mov     ax, 0xF000
        mov     es, ax
        mov     dx, m_d32
        call    puts
        cmp     byte [es:0x6095], 0xE9
        jne     .m_chk_stock
        cmp     byte [es:0x6096], 0x36
        jne     .m_unk
        cmp     byte [es:0x6097], 0xC5
        jne     .m_unk
        mov     dx, m_present
        jmp     .m_pr
.m_chk_stock:
        cmp     byte [es:0x6095], 0x83
        jne     .m_unk
        cmp     byte [es:0x6096], 0xC3
        jne     .m_unk
        cmp     byte [es:0x6097], 0x40
        jne     .m_unk
        mov     dx, m_absent
        jmp     .m_pr
.m_unk: mov     dx, m_dunk
.m_pr:  call    puts
        mov     dx, m_dat
        call    puts
        mov     al, [es:0x6095]
        call    phex
        mov     al, ' '
        call    pchr
        mov     al, [es:0x6096]
        call    phex
        mov     al, ' '
        call    pchr
        mov     al, [es:0x6097]
        call    phex
        mov     dx, m_crlf2
        call    puts
        ret

pchr:   mov     dl, al
        mov     ah, 0x02
        int     0x21
        ret
phex:                                   ; AL -> two hex chars
        push    cx
        mov     cl, al
        mov     al, cl
        shr     al, 4
        call    .nib
        mov     al, cl
        call    .nib
        pop     cx
        ret
.nib:   and     al, 0x0F
        cmp     al, 10
        jb      .d
        add     al, 'A'-10
        jmp     .o
.d:     add     al, '0'
.o:     mov     dl, al
        mov     ah, 0x02
        int     0x21
        ret
pdec:                                   ; AL = 0..99 -> two decimal digits
        aam
        add     ax, 0x3030
        push    ax
        mov     dl, ah
        mov     ah, 0x02
        int     0x21
        pop     ax
        mov     dl, al
        mov     ah, 0x02
        int     0x21
        ret

;=========================== FLASH ENGINE (= vpatch) ===========================
flash_enable:
        mov     al, 0x8E
        out     0x70, al
        jmp     $+2
        in      al, 0x71
        cli
        mov     dx, 0xFC23
        in      al, dx
        mov     dx, 0xF023
        in      al, dx
        mov     dx, 0xC023
        in      al, dx
        mov     dx, 0x23
        in      al, dx
        jmp     $+2
        mov     al, 0xFE
        out     0x24, al
        jmp     $+2
        in      al, 0x25
        and     al, 0xFE
        mov     ah, al
        mov     al, 0xFE
        out     0x24, al
        jmp     $+2
        mov     al, ah
        out     0x25, al
        jmp     $+2
        mov     al, 0xFA
        out     0x24, al
        jmp     $+2
        mov     al, 0x01
        out     0x25, al
        jmp     $+2
        out     0xFB, al
        mov     al, 0x11
        out     0xEC, al
        jmp     $+2
        in      al, 0xED
        jmp     $+2
        mov     al, 0x11
        out     0xEC, al
        jmp     $+2
        xor     al, al
        out     0xED, al
        jmp     $+2
        mov     al, 0x12
        out     0xEC, al
        jmp     $+2
        in      al, 0xED
        jmp     $+2
        mov     al, 0x12
        out     0xEC, al
        jmp     $+2
        xor     al, al
        out     0xED, al
        jmp     $+2
        mov     al, 0x17
        out     0xEC, al
        jmp     $+2
        in      al, 0xED
        jmp     $+2
        mov     al, 0x17
        out     0xEC, al
        jmp     $+2
        mov     al, 0x55
        out     0xED, al
        jmp     $+2
        mov     al, 0x18
        out     0xEC, al
        jmp     $+2
        in      al, 0xED
        jmp     $+2
        mov     al, 0x18
        out     0xEC, al
        jmp     $+2
        mov     al, 0x55
        out     0xED, al
        jmp     $+2
        mov     al, 0x0C
        out     0xEC, al
        jmp     $+2
        in      al, 0xED
        and     al, 0x8F
        mov     ah, al
        mov     al, 0x0C
        out     0xEC, al
        jmp     $+2
        mov     al, ah
        out     0xED, al
        jmp     $+2
        out     0xF9, al
        mov     eax, cr0
        or      eax, 0x60000000
        mov     cr0, eax
        invd
        in      al, 0x98
        or      al, 0x08
        out     0x98, al
        in      al, 0x61
        and     al, 0x10
        out     0x61, al
        ret

flash_copy_current:
        push    ds
        push    es
        mov     ax, 0xE000
        mov     ds, ax
        xor     si, si
        mov     es, [cs:eseg]
        xor     di, di
        mov     cx, 0xFFFF
        rep     movsb
        mov     ax, 0xF000
        mov     ds, ax
        xor     si, si
        mov     es, [cs:fseg]
        xor     di, di
        mov     cx, 0x7FFF
        rep     movsb
        pop     es
        pop     ds
        ret

flash_program:
        mov     ax, 0xE000
        mov     es, ax
        xor     di, di
        mov     al, 0x20
        mov     [es:di], al
        mov     al, 0xD0
        mov     [es:di], al
        mov     al, 0x70
        mov     [es:di], al
.ew:    mov     al, [es:di]
        and     al, 0x80
        jz      .ew
        mov     ds, [cs:eseg]
        mov     ax, 0xE000
        mov     es, ax
        mov     cx, 0xFFFF
        mov     di, cx
.ep:    dec     di
        mov     al, 0x40
        mov     [es:di], al
        mov     al, [di]
        mov     [es:di], al
        mov     al, 0x70
        mov     [es:di], al
.epw:   mov     al, [es:di]
        and     al, 0x80
        jz      .epw
        loop    .ep
        mov     ds, [cs:fseg]
        mov     ax, 0xF000
        mov     es, ax
        mov     cx, 0x7FFF
        mov     di, cx
.fp:    dec     di
        mov     al, 0x40
        mov     [es:di], al
        mov     al, [di]
        mov     [es:di], al
        mov     al, 0x70
        mov     [es:di], al
.fpw:   mov     al, [es:di]
        and     al, 0x80
        jz      .fpw
        loop    .fp
        mov     al, 0xFF
        mov     [es:di], al
        sti
        push    cs
        pop     ds
        ret

;================================== DATA ==================================
op        db 0
eseg      dw 0
fseg      dw 0
fn_panel  db "A:\PANEL.SAV",0
tft_off   dw 0x01CB,0x0A9A,0x0A9C,0x0AA0,0x0AA4,0x0AA6,0x0AB4,0x0AB8,0x0AE6
          dw 0x0AE8,0x0AEA,0x0AF6,0x0AF7,0x0AFA,0x0AFC,0x0AFE,0x0B00,0x0B04
tft_val   db 0x1F,0x42,0xC0,0xC5,0xC4,0xC0,0x1C,0x00,0x56
          db 0x13,0x5F,0x00,0x0C,0x01,0x26,0xDF,0x05,0x00
; stock DSTN values -- captured live from an unmodified DSTN PC110 (2026-07-27);
; all 18 differ from the TFT set. Lets TFT->DSTN work without a PANEL.SAV.
dstn_val  db 0x0C,0x44,0xC2,0x04,0x63,0x3A,0x18,0x1B,0x57
          db 0x19,0x59,0x15,0x53,0xE4,0x07,0xE0,0x01,0x1B
panel_sav db 18 dup(0)
mem_stub_p db 0x83,0xC3,0x40,0x81,0xFB,0x00,0x6C,0x73,0x03,0xE9,0xBE,0x3A,0xE9,0xCC,0x3A
mem_stub_o db 15 dup(0)
msg_banner db 13,10,"IBM PC110 BIOS Multi-Patcher",13,10
           db "(flash sequence = vpatch; boot from an IBM floppy so VPP is present)",13,10,"$"
msg_menu   db 13,10,"  1) Display: DSTN -> TFT",13,10
           db "  2) Display: TFT -> DSTN (restore A:\PANEL.SAV)",13,10
           db "  3) Windows 256-colour fix",13,10
           db "  4) Memory: enable 32 MB patch",13,10
           db "  5) Memory: remove 32 MB patch",13,10
           db "  6) Diagnose current BIOS (read-only)",13,10
           db "  ESC) Quit",13,10,"  Choice: $"
msg_warn   db 13,10,13,10,"*** REFLASHES THE BIOS 96KB main block. Interrupt = UNBOOTABLE. ***",13,10
           db "A/C + charged battery required. Press Y to proceed, any other key aborts: $"
msg_flash  db 13,10,"Flashing... do NOT power off.",13,10,"$"
msg_done   db "Done. Reboot to take effect.",13,10,"$"
msg_abort  db 13,10,"Aborted, nothing written.",13,10,"$"
msg_ac     db 13,10,"Aborted: plug in A/C.",13,10,"$"
msg_batt   db 13,10,"Aborted: battery < 20%.",13,10,"$"
msg_nomem  db 13,10,"Aborted: not enough conventional memory.",13,10,"$"
msg_nosave db 13,10,"Aborted: A:\PANEL.SAV not found (run DSTN->TFT first).",13,10,"$"
msg_sverr  db 13,10,"Aborted: cannot write A:\PANEL.SAV.",13,10,"$"
msg_m32bad db 13,10,"Aborted: BIOS not in the expected state at the hook.",13,10,"$"
msg_bye    db 13,10,"Bye.",13,10,"$"
m_usedef   db 13,10,"(no A:\PANEL.SAV -- using the built-in stock DSTN values)",13,10,"$"
d_xr54     db 0
d_1cb      db 0
d_nm       db 0
d_nd       db 0
m_dhdr     db 13,10,"--- BIOS patch status (read-only) ---",13,10,"$"
m_dpan     db "Display panel  : $"
m_ptft     db "TFT (patched)$"
m_pdstn    db "DSTN (stock)$"
m_pmix     db "MIXED / unknown revision$"
m_dxr      db "   XR54=$"
m_dmt      db "  match TFT $"
m_dmt2     db "/18  DSTN $"
m_d18      db "/18",13,10,"$"
m_dw256    db "Win 256-colour : $"
m_d32      db "32 MB mem patch: $"
m_present  db "PRESENT$"
m_absent   db "absent$"
m_dunk     db "UNKNOWN (unexpected bytes)$"
m_dat      db "   (bytes: $"
m_crlf2    db ")",13,10,"$"
