; ============================================================================
; PS2TUI.COM  -  Text-UI front-end for the IBM PalmTop PC110 "PS2.EXE" tool
; A menu-driven replacement for the ~50 cryptic PS2 command-line options.
; Navigates categories/settings; applies a change by running the real PS2.EXE
; via COMMAND.COM, so all the actual hardware/BIOS work is done by IBM's tool.
;
; Build (host):  nasm -f bin PS2TUI.ASM -o PS2TUI.COM
; Target: MS-DOS / PC DOS 7 (real mode). Assemble as a .COM (org 100h).
; ============================================================================
        cpu     586             ; allow CPUID (the PC110 486SX supports it); 16-bit real mode
        bits    16
        org     0x100

; ---- colour attributes -----------------------------------------------------
A_TITLE   equ 0x1F        ; bright white on blue
A_BODY    equ 0x0F        ; bright white on black (crisp on the DSTN LCD)
A_HEAD    equ 0x0E        ; yellow on black
A_SEL     equ 0x70        ; black on light-grey (reverse-video highlight)
A_FOOT    equ 0x70        ; black on light-grey
A_BOX     equ 0x1F        ; popup: white on blue
A_WARN    equ 0x4F        ; white on red

; ---- row types -------------------------------------------------------------
R_HEAD    equ 0           ; category header (not selectable)
R_ITEM    equ 1           ; setting with an option list
R_ACT     equ 2           ; action (no options, just run "PS2 <cmd>")
R_INFO    equ 3           ; runs "PS2 _@REVision"
R_CALL    equ 4           ; calls the internal routine at the record's "cmd" field
R_UITEM   equ 5           ; like R_ITEM but runs C:\ULTRACHG.COM <option> (no cmd word)

VIS_TOP   equ 3           ; first screen row used by the list
VIS_ROWS  equ 19          ; number of list rows on screen

; ============================================================================
start:
        ; free memory above us so EXEC has room for the child
        mov     ax, cs
        mov     ds, ax
        mov     es, ax
        mov     bx, 0x1000        ; keep 64 KB
        mov     ah, 0x4A
        int     0x21

        call    first_item        ; sel -> first selectable row
        mov     word [top], 0
        call    draw_all

.loop:
        call    getkey            ; AL=ascii AH=scan
        cmp     al, 0x1B          ; ESC -> quit
        je      .quit
        cmp     al, 0             ; extended (arrow) key?
        jne     .ascii
        cmp     ah, 0x48          ; up
        je      .up
        cmp     ah, 0x50          ; down
        je      .down
        jmp     .loop
.ascii:
        cmp     al, 0x0D          ; Enter -> activate
        je      .activate
        cmp     al, 'r'
        je      .rev
        cmp     al, 'R'
        je      .rev
        cmp     al, 'b'
        je      .pwr
        cmp     al, 'B'
        je      .pwr
        cmp     al, 'c'
        je      .cfg
        cmp     al, 'C'
        je      .cfg
        cmp     al, 'q'
        je      .quit
        cmp     al, 'Q'
        je      .quit
        jmp     .loop

.up:    call    prev_item
        call    draw_list
        jmp     .loop
.down:  call    next_item
        call    draw_list
        jmp     .loop
.rev:   call    run_revision
        call    draw_all
        jmp     .loop
.pwr:   call    show_power
        call    draw_all
        jmp     .loop
.cfg:   call    show_config
        call    draw_all
        jmp     .loop
.activate:
        call    activate_sel
        call    draw_all
        jmp     .loop

.quit:
        ; clear screen, restore a normal cursor, exit
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     ax, 0x4C00
        int     0x21

; ============================================================================
;  activate_sel : act on the currently selected row
; ============================================================================
activate_sel:
        mov     bx, [sel]
        call    row_ptr           ; ES:BX invalid; use DS. returns SI=record
        mov     al, [si+6]        ; type
        cmp     al, R_INFO
        je      run_revision
        cmp     al, R_ACT
        je      .action
        cmp     al, R_CALL
        je      .call
        cmp     al, R_UITEM
        je      .uitem
        ; R_ITEM : open the option picker
        jmp     pick_option
.uitem:
        ; charging item: exec C:\ULTRACHG.COM <option> instead of PS2.EXE
        mov     word [exec_prog], ultra_prog
        mov     word [show_pfx], pfx_ultra
        mov     byte [ultra_mode], 1
        jmp     pick_option
.action:
        ; build "PS2 <cmd>" and confirm
        mov     si, [si+2]        ; cmd ptr
        call    build_cmd_noopt
        call    confirm_run
        ret
.call:
        ; internal routine: cmd field = its offset
        mov     ax, [si+2]
        call    ax
        ret

; ============================================================================
;  pick_option : popup list of options for the selected item, run PS2 <cmd> opt
; ============================================================================
pick_option:
        mov     bx, [sel]
        call    row_ptr           ; SI=record
        mov     ax, [si+2]
        mov     [cur_cmd], ax     ; save cmd ptr
        mov     ax, [si+4]
        mov     [opt_base], ax    ; options list base
        mov     word [opt_sel], 0

.redraw:
        call    draw_picker
.pk:
        call    getkey
        cmp     al, 0x1B
        je      .cancel
        cmp     al, 0
        jne     .pk_ascii
        cmp     ah, 0x48
        je      .pk_up
        cmp     ah, 0x50
        je      .pk_down
        jmp     .pk
.pk_ascii:
        cmp     al, 0x0D
        je      .choose
        jmp     .pk
.pk_up:
        cmp     word [opt_sel], 0
        je      .pk
        dec     word [opt_sel]
        jmp     .redraw
.pk_down:
        mov     ax, [opt_sel]
        inc     ax
        push    ax
        call    opt_count         ; -> CX
        pop     ax
        cmp     ax, cx
        jae     .pk
        mov     [opt_sel], ax
        jmp     .redraw
.cancel:
        jmp     .reset
.choose:
        ; SI -> chosen option string
        call    opt_ptr           ; -> SI = chosen option text
        mov     [cur_opt], si
        cmp     byte [ultra_mode], 0
        jne     .uchoose
        mov     si, [cur_cmd]
        call    build_cmd_opt     ; builds "PS2 <cmd> <opt>"
        jmp     .runit
.uchoose:
        call    build_cmd_ultraopt ; builds "ULTRACHG <opt>"
.runit:
        call    confirm_run
.reset:
        ; restore the default exec target / display prefix
        mov     word [exec_prog], progname
        mov     word [show_pfx], pfx_ps2
        mov     byte [ultra_mode], 0
        ret

; ============================================================================
;  confirm_run : show the command, ask Y/N, run it, pause
; ============================================================================
confirm_run:
        call    draw_confirm
.c:
        call    getkey
        cmp     al, 'y'
        je      .yes
        cmp     al, 'Y'
        je      .yes
        cmp     al, 'n'
        je      .no
        cmp     al, 'N'
        je      .no
        cmp     al, 0x1B
        je      .no
        jmp     .c
.no:
        ret
.yes:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        ; announce
        mov     dx, 0x0000
        call    gotoxy
        mov     si, msg_running
        call    puts_tty
        mov     si, cmdshow
        call    puts_tty
        mov     si, crlf
        call    puts_tty
        mov     si, crlf
        call    puts_tty
        call    do_exec
        mov     si, crlf
        call    puts_tty
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  run_revision : run PS2 _@REVision full-screen, pause
; ============================================================================
run_revision:
        mov     si, cmd_rev
        call    build_cmd_raw
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        call    do_exec
        mov     si, crlf
        call    puts_tty
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  show_power : NATIVE live battery / AC status via the APM BIOS (INT 15h).
;  This is code ingested from PS2.EXE: it uses APM 5300 (install check) and
;  530A (get power status) directly, with no call to PS2.EXE.  Read-only.
; ============================================================================
show_power:
        ; APM installation check
        mov     ax, 0x5300
        xor     bx, bx
        int     0x15
        mov     byte [pw_ok], 1
        jnc     .have
        mov     byte [pw_ok], 0
        jmp     .status
.have:
        mov     [pw_ver], ax      ; AH=major AL=minor (APM spec version)
        mov     [pw_flags], cx
.status:
        ; APM get power status (device 1 = all batteries)
        mov     byte [pw_stat], 0
        mov     ax, 0x530A
        mov     bx, 1
        int     0x15
        jc      .draw
        mov     byte [pw_stat], 1
        mov     [pw_ac], bh
        mov     [pw_bat], bl
        mov     [pw_pct], cl
        mov     [pw_time], dx
.draw:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, pw_hdr
        call    puts_tty
        ; APM present?
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, pw_l_apm
        call    puts_tty
        cmp     byte [pw_ok], 0
        je      .noapm
        mov     si, pw_yes
        call    puts_tty
        ; version A.B
        mov     si, pw_l_ver
        call    puts_tty
        mov     al, [pw_ver+1]    ; major
        call    print_dec_al
        mov     al, '.'
        call    putc_tty
        mov     al, [pw_ver]      ; minor
        call    print_dec_al
        mov     al, ')'
        call    putc_tty
        jmp     .powerlines
.noapm:
        mov     si, pw_no
        call    puts_tty
        jmp     .wait
.powerlines:
        cmp     byte [pw_stat], 0
        je      .nostat
        ; AC line
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, pw_l_ac
        call    puts_tty
        mov     al, [pw_ac]
        mov     si, pw_ac_off
        cmp     al, 0
        je      .pac
        mov     si, pw_ac_on
        cmp     al, 1
        je      .pac
        mov     si, pw_ac_bak
        cmp     al, 2
        je      .pac
        mov     si, pw_unk
.pac:   call    puts_tty
        ; Battery status
        mov     dh, 6
        mov     dl, 2
        call    gotoxy
        mov     si, pw_l_bat
        call    puts_tty
        mov     al, [pw_bat]
        mov     si, pw_b_high
        cmp     al, 0
        je      .pbat
        mov     si, pw_b_low
        cmp     al, 1
        je      .pbat
        mov     si, pw_b_crit
        cmp     al, 2
        je      .pbat
        mov     si, pw_b_chg
        cmp     al, 3
        je      .pbat
        mov     si, pw_unk
.pbat:  call    puts_tty
        ; Charge %
        mov     dh, 7
        mov     dl, 2
        call    gotoxy
        mov     si, pw_l_pct
        call    puts_tty
        mov     al, [pw_pct]
        cmp     al, 0xFF
        je      .pctunk
        call    print_dec_al
        mov     al, '%'
        call    putc_tty
        jmp     .wait
.pctunk:
        mov     si, pw_unk
        call    puts_tty
        jmp     .wait
.nostat:
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, pw_nostat
        call    puts_tty
.wait:
        mov     dh, 10
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  show_config : NATIVE current-settings read, straight from CMOS (ports 70/71).
;  PS2 stores these in extended CMOS; reading is safe & needs no checksum.
;  Verified mappings: CLICK=0x44 bit0x10, _@STATUS=0x70, PMODE/VEXP=0x72.
; ============================================================================
show_config:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, cf_hdr
        call    puts_tty
        ; --- Keyboard click : CMOS 0x44 bit 0x10 ---
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, cf_click
        call    puts_tty
        mov     al, 0x44
        call    read_cmos
        test    al, 0x10
        mov     si, cf_on
        jnz     .c1
        mov     si, cf_off
.c1:    call    puts_tty
        ; --- LCD status panel : CMOS 0x70 (0=Auto 4=Time else Battery) ---
        mov     dh, 4
        mov     dl, 2
        call    gotoxy
        mov     si, cf_stat
        call    puts_tty
        mov     al, 0x70
        call    read_cmos
        and     al, 0x0F
        mov     si, cf_auto
        cmp     al, 0
        je      .c2
        mov     si, cf_time
        cmp     al, 4
        je      .c2
        mov     si, cf_batt
.c2:    call    puts_tty
        ; --- Power-saving mode : CMOS 0x72 bit 0x20 (set=High) ---
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, cf_pmode
        call    puts_tty
        mov     al, 0x72
        call    read_cmos
        test    al, 0x20
        mov     si, cf_high
        jnz     .c3
        mov     si, cf_lowmed
.c3:    call    puts_tty
        ; --- Vertical expand : CMOS 0x72 bit 0x04 ---
        mov     dh, 6
        mov     dl, 2
        call    gotoxy
        mov     si, cf_vexp
        call    puts_tty
        mov     al, 0x72
        call    read_cmos
        test    al, 0x04
        mov     si, cf_on
        jnz     .c4
        mov     si, cf_off
.c4:    call    puts_tty
        ; footer note
        mov     dh, 9
        mov     dl, 2
        call    gotoxy
        mov     si, cf_note
        call    puts_tty
        mov     dh, 11
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; read_cmos : AL = index (0..0x7F) -> AL = value.  Restores index to 0x0D.
read_cmos:
        push    cx
        cli
        out     0x70, al
        in      al, 0x71
        mov     cl, al
        mov     al, 0x0D
        out     0x70, al
        sti
        mov     al, cl
        pop     cx
        ret

; ============================================================================
;  BACKUP / RESTORE all settings via the CMOS config region (0x10-0x7F).
;  PS2/BIOS settings persist in CMOS, so a byte image of 0x10-0x7F captures
;  them all (incl. both CMOS checksums), self-consistently.  Restore writes it
;  back; the settings take effect on the next boot.
; ============================================================================
backup_settings:
        ; read CMOS 0x10..0x7F into the scratch buffer
        mov     di, MEMBUF
        mov     cl, 0x10
.rd:    mov     al, cl
        call    read_cmos
        mov     [di], al
        inc     di
        inc     cl
        cmp     cl, 0x80
        jb      .rd
        mov     si, msg_backup
        call    dump_header
        mov     dx, fn_set
        call    open_out
        jc      .err
        mov     bx, [fhandle]
        mov     dx, MEMBUF
        mov     cx, 0x70                ; 112 bytes (0x10..0x7F)
        mov     ah, 0x40
        int     0x21
        call    close_out
        mov     si, msg_bdone
        jmp     dump_finish
.err:   mov     si, msg_derr
        jmp     dump_finish

restore_settings:
        mov     si, msg_restore
        call    dump_header
        ; read the backup file into the scratch buffer
        mov     dx, fn_set
        mov     ax, 0x3D00              ; open for read
        int     0x21
        jc      .err
        mov     [fhandle], ax
        mov     bx, ax
        mov     dx, MEMBUF
        mov     cx, 0x70
        mov     ah, 0x3F
        int     0x21                    ; AX = bytes read
        push    ax
        call    close_out
        pop     ax
        cmp     ax, 0x70
        jne     .err                    ; not a valid full backup
        ; confirm before overwriting CMOS
        mov     dh, 3
        mov     dl, 0
        call    gotoxy
        mov     si, msg_rconf
        call    puts_tty
        call    getkey
        push    ax
        call    cls_body_full           ; clear the confirm prompt before the result
        mov     dx, 0x0000
        call    gotoxy
        mov     si, msg_restore
        call    puts_tty
        pop     ax
        cmp     al, 'y'
        je      .go
        cmp     al, 'Y'
        je      .go
        mov     si, msg_rcancel
        jmp     dump_finish
.go:
        mov     si, MEMBUF
        mov     cl, 0x10
.wr:    cli
        mov     al, cl
        out     0x70, al
        lodsb
        out     0x71, al
        sti
        inc     cl
        cmp     cl, 0x80
        jb      .wr
        mov     al, 0x0D
        out     0x70, al
        mov     si, msg_rdone
        jmp     dump_finish
.err:   mov     si, msg_derr
        jmp     dump_finish

; print_dec_al : print AL (0..255) as decimal via BIOS teletype, no leading zeros
print_dec_al:
        push    ax
        push    bx
        push    cx
        push    dx
        xor     ah, ah
        mov     bl, 100
        div     bl                ; AL=hundreds AH=rem
        mov     ch, al
        mov     al, ah
        xor     ah, ah
        mov     bl, 10
        div     bl                ; AL=tens AH=units
        mov     cl, al
        mov     dh, ah
        mov     byte [pd_go], 0
        mov     al, ch
        call    .dig
        mov     al, cl
        call    .dig
        mov     al, dh
        add     al, '0'
        call    putc_tty
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret
.dig:   test    al, al
        jnz     .pr
        cmp     byte [pd_go], 0
        je      .skip
.pr:    mov     byte [pd_go], 1
        add     al, '0'
        call    putc_tty
.skip:  ret

; putc_tty : print AL via BIOS teletype
putc_tty:
        push    ax
        push    bx
        mov     ah, 0x0E
        mov     bx, 0x0007
        int     0x10
        pop     bx
        pop     ax
        ret

; print_dec_ax : print AX (0..65535) decimal
print_dec_ax:
        push    ax
        push    bx
        push    cx
        push    dx
        mov     bx, 10
        xor     cx, cx
.d1:    xor     dx, dx
        div     bx
        push    dx
        inc     cx
        test    ax, ax
        jnz     .d1
.d2:    pop     dx
        mov     al, dl
        add     al, '0'
        call    putc_tty
        loop    .d2
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

; print_hex_al : print AL as two hex digits
print_hex_al:
        push    ax
        push    cx
        mov     ah, al
        mov     cl, 4
        shr     al, cl
        call    .nib
        mov     al, ah
        call    .nib
        pop     cx
        pop     ax
        ret
.nib:   and     al, 0x0F
        cmp     al, 10
        jb      .dig
        add     al, 'A'-10
        jmp     .pc
.dig:   add     al, '0'
.pc:    call    putc_tty
        ret

; ============================================================================
;  DUMPS : write ROM / BIOS / font images to files on the boot drive (DOS I/O).
; ============================================================================
open_out:                          ; DS:DX -> ASCIIZ name ; -> [fhandle], CF=err
        push    cx
        mov     ah, 0x3C
        xor     cx, cx
        int     0x21
        mov     [fhandle], ax
        pop     cx
        ret
close_out:
        mov     bx, [fhandle]
        mov     ah, 0x3E
        int     0x21
        ret
write_seg:                         ; BX=srcseg, CX=count -> file [fhandle]
        push    ds
        mov     ds, bx
        xor     dx, dx
        mov     bx, [cs:fhandle]
        mov     ah, 0x40
        int     0x21
        pop     ds
        ret
dump_region:                       ; [dseg]=start seg, [dchunks]=# of 4 KB chunks
.l:     cmp     word [dchunks], 0
        je      .done
        mov     bx, [dseg]
        mov     cx, 0x1000
        call    write_seg
        add     word [dseg], 0x100
        dec     word [dchunks]
        jmp     .l
.done:  ret

dump_header:                       ; SI = title
        push    si
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        pop     si
        call    puts_tty
        ret
dump_finish:                       ; SI = result msg
        push    si
        mov     dh, 3
        mov     dl, 0
        call    gotoxy
        pop     si
        call    puts_tty
        mov     dh, 5
        mov     dl, 0
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

dump_bios:
        mov     si, msg_dbios
        call    dump_header
        mov     dx, fn_bios
        call    open_out
        jc      .err
        mov     word [dseg], 0xF000
        mov     word [dchunks], 16      ; 64 KB
        call    dump_region
        call    close_out
        mov     si, msg_ddone
        jmp     dump_finish
.err:   mov     si, msg_derr
        jmp     dump_finish

dump_vbios:
        mov     si, msg_dvbios
        call    dump_header
        mov     dx, fn_vbios
        call    open_out
        jc      .err
        mov     word [dseg], 0xC000
        mov     word [dchunks], 8       ; 32 KB
        call    dump_region
        call    close_out
        mov     si, msg_ddone
        jmp     dump_finish
.err:   mov     si, msg_derr
        jmp     dump_finish

dump_font:
        mov     si, msg_dfont
        call    dump_header
        mov     dx, fn_font
        call    open_out
        jc      .err
        push    bp
        xor     bp, bp                  ; bank 0..127
.bl:    mov     ax, bp
        mov     dx, 0x1160
        out     dx, al                  ; bank select
        mov     al, 0xDE
        mov     dx, 0x1162
        out     dx, al                  ; window segment high
        mov     al, 0x01
        mov     dx, 0x1163
        out     dx, al                  ; enable window
        mov     bx, 0xDE00
        mov     cx, 0x2000              ; 8 KB window
        call    write_seg
        inc     bp
        cmp     bp, 128
        jb      .bl
        xor     al, al
        mov     dx, 0x1160
        out     dx, al                  ; restore bank 0
        pop     bp
        call    close_out
        mov     si, msg_ddone
        jmp     dump_finish
.err:   mov     si, msg_derr
        jmp     dump_finish

; ============================================================================
;  SYSTEM TEST : memory / video / keyboard / speaker  (Easy-Setup style)
; ============================================================================
MEMBUF  equ 0x8000                 ; 16 KB scratch inside our own 64 KB segment

test_mem:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, msg_tmem
        call    puts_tty
        mov     dh, 2
        mov     dl, 2
        call    gotoxy
        mov     si, tm_base
        call    puts_tty
        int     0x12                    ; AX = conventional KB
        call    print_dec_ax
        mov     si, tm_kb
        call    puts_tty
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, tm_ext
        call    puts_tty
        mov     al, 0x30                ; CMOS 0x30/0x31 = extended KB above 1 MB
        call    read_cmos               ; (INT 15h/88 is masked by HIMEM; CMOS is physical)
        mov     bl, al
        mov     al, 0x31
        call    read_cmos
        mov     ah, al
        mov     al, bl
        call    print_dec_ax
        mov     si, tm_kb
        call    puts_tty
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, tm_run
        call    puts_tty
        call    memtest_buf             ; AL=0 pass / 1 fail
        mov     si, tm_pass
        test    al, al
        jz      .r
        mov     si, tm_fail
.r:     call    puts_tty
        mov     dh, 8
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret
memtest_buf:                            ; -> AL=0 pass / 1 fail
        push    si
        push    di
        push    cx
        mov     si, patterns
.pl:    lodsb
        cmp     al, 0xFE
        je      .pass
        mov     ah, al
        mov     di, MEMBUF
        mov     cx, 0x4000
.f:     mov     [di], ah
        inc     di
        loop    .f
        mov     di, MEMBUF
        mov     cx, 0x4000
.v:     mov     al, [di]
        cmp     al, ah
        jne     .fail
        inc     di
        loop    .v
        jmp     .pl
.pass:  xor     al, al
        jmp     .done
.fail:  mov     al, 1
.done:  pop     cx
        pop     di
        pop     si
        ret

test_vid:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, tv_title
        call    puts_tty
        push    es
        mov     ax, 0xB800
        mov     es, ax
        mov     di, (3*80+2)*2          ; 16 foreground colours
        xor     bx, bx
.fg:    mov     al, 0xDB
        mov     ah, bl
        mov     [es:di], al
        mov     [es:di+1], ah
        mov     [es:di+2], al
        mov     [es:di+3], ah
        add     di, 4
        inc     bx
        cmp     bx, 16
        jb      .fg
        mov     di, (5*80+2)*2          ; 8 background colours
        xor     bx, bx
.bg:    mov     al, ' '
        mov     ah, bl
        mov     cl, 4
        shl     ah, cl
        or      ah, 0x0F
        mov     [es:di], al
        mov     [es:di+1], ah
        mov     [es:di+2], al
        mov     [es:di+3], ah
        mov     [es:di+4], al
        mov     [es:di+5], ah
        add     di, 6
        inc     bx
        cmp     bx, 8
        jb      .bg
        mov     di, (7*80+2)*2          ; full 256-char set
        xor     bl, bl
        mov     cx, 256
.cs:    mov     al, bl
        mov     ah, 0x0F
        mov     [es:di], al
        mov     [es:di+1], ah
        add     di, 2
        inc     bl
        loop    .cs
        pop     es
        mov     dh, 14
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

test_kbd:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, tk_title
        call    puts_tty
.kl:    call    getkey                  ; AL=ascii AH=scan
        cmp     al, 0x1B
        je      .done
        push    ax
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, tk_scan
        call    puts_tty
        pop     ax
        push    ax
        mov     al, ah
        call    print_hex_al
        mov     si, tk_ascii
        call    puts_tty
        pop     ax
        push    ax
        call    print_hex_al
        mov     si, tk_char
        call    puts_tty
        pop     ax
        call    putc_tty
        mov     al, ' '
        call    putc_tty
        call    putc_tty
        jmp     .kl
.done:  ret

test_spk:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, ts_title
        call    puts_tty
        mov     al, 0xB6
        out     0x43, al                ; PIT ch2, mode 3
        mov     al, 0xA9
        out     0x42, al                ; divisor 0x04A9 (~1 kHz)
        mov     al, 0x04
        out     0x42, al
        in      al, 0x61
        or      al, 0x03
        out     0x61, al                ; speaker on
        mov     ax, 8
        call    delay_ticks             ; ~0.44 s
        in      al, 0x61
        and     al, 0xFC
        out     0x61, al                ; speaker off
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret
delay_ticks:                            ; AX = BIOS timer ticks (~18.2/s)
        push    es
        push    bx
        push    cx
        mov     bx, ax
        mov     cx, 0x40
        mov     es, cx
        mov     ax, [es:0x6C]
.w:     mov     cx, [es:0x6C]
        sub     cx, ax
        cmp     cx, bx
        jb      .w
        pop     cx
        pop     bx
        pop     es
        ret

; ============================================================================
;  diag_scan : live hardware diagnostics — probe every PC110 subsystem read-only
;  (index-select writes only; all values read back).  Reuses the RE from the
;  Discovery/Live-Dump chapter.
; ============================================================================
; has_cpuid : ZF=1 (jz) if CPUID is NOT supported
has_cpuid:
        pushfd
        pop     eax
        mov     ecx, eax
        xor     eax, 0x200000
        push    eax
        popfd
        pushfd
        pop     eax
        push    ecx
        popfd
        xor     eax, ecx
        and     eax, 0x200000
        ret
; pr_ff : AL -> print "present" (AL!=0xFF) or "absent" (AL==0xFF)
pr_ff:
        push    si
        cmp     al, 0xFF
        je      .a
        mov     si, dg_present
        jmp     .p
.a:     mov     si, dg_absent
.p:     call    puts_tty
        pop     si
        ret

diag_scan:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, dg_hdr
        call    puts_tty
        ; ---- CPU via CPUID ----
        mov     dh, 2
        mov     dl, 2
        call    gotoxy
        mov     si, dg_cpu
        call    puts_tty
        call    has_cpuid
        jz      .nocpu
        xor     eax, eax
        cpuid
        mov     [cpu_v], ebx
        mov     [cpu_v+4], edx
        mov     [cpu_v+8], ecx
        mov     byte [cpu_v+12], 0
        mov     eax, 1
        cpuid
        mov     [cpu_feat], dx
        mov     [cpu_sig], ax
        mov     si, cpu_v
        call    puts_tty
        mov     si, dg_fam
        call    puts_tty
        mov     ax, [cpu_sig]
        mov     cl, 8
        shr     ax, cl
        and     al, 0x0F
        call    print_dec_al
        mov     si, dg_mdl
        call    puts_tty
        mov     ax, [cpu_sig]
        mov     cl, 4
        shr     ax, cl
        and     al, 0x0F
        call    print_dec_al
        mov     si, dg_stp
        call    puts_tty
        mov     al, [cpu_sig]
        and     al, 0x0F
        call    print_dec_al
        mov     si, dg_fpu
        call    puts_tty
        mov     al, [cpu_feat]
        test    al, 1
        mov     si, dg_no
        jz      .fpup
        mov     si, dg_yes
.fpup:  call    puts_tty
        jmp     .mem
.nocpu:
        mov     si, dg_486
        call    puts_tty
.mem:
        ; ---- Memory ----
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, dg_mem
        call    puts_tty
        int     0x12
        call    print_dec_ax
        mov     si, dg_kb
        call    puts_tty
        mov     si, dg_ext
        call    puts_tty
        mov     al, 0x30
        call    read_cmos
        mov     bl, al
        mov     al, 0x31
        call    read_cmos
        mov     ah, al
        mov     al, bl
        call    print_dec_ax
        mov     si, dg_kb
        call    puts_tty
        ; ---- APM ----
        mov     dh, 4
        mov     dl, 2
        call    gotoxy
        mov     si, dg_apm
        call    puts_tty
        mov     ax, 0x5300
        xor     bx, bx
        int     0x15
        jc      .apmno
        mov     ax, 0x530A
        mov     bx, 1
        int     0x15
        jc      .apmp
        mov     [pw_ac], bh
        mov     [pw_pct], cl
        mov     si, dg_present
        call    puts_tty
        mov     si, dg_bat
        call    puts_tty
        mov     al, [pw_pct]
        cmp     al, 0xFF
        je      .scamp
        call    print_dec_al
        mov     al, '%'
        call    putc_tty
        jmp     .scamp
.apmp:  mov     si, dg_present
        call    puts_tty
        jmp     .scamp
.apmno: mov     si, dg_absent
        call    puts_tty
.scamp:
        ; ---- SCAMP VL82C420 (read index port 0x74) ----
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, dg_scamp
        call    puts_tty
        mov     dx, 0x74
        in      al, dx
        call    pr_ff
        ; ---- Power MCU (0xEC index / 0xED data, reg 0) ----
        mov     dh, 6
        mov     dl, 2
        call    gotoxy
        mov     si, dg_pmcu
        call    puts_tty
        mov     dx, 0x00EC
        xor     al, al
        out     dx, al
        mov     dx, 0x00ED
        in      al, dx
        call    pr_ff
        ; ---- PCMCIA PCIC (0x3E0 index / 0x3E1 data) ----
        mov     dh, 7
        mov     dl, 2
        call    gotoxy
        mov     si, dg_pcic
        call    puts_tty
        mov     dx, 0x3E0
        xor     al, al
        out     dx, al
        mov     dx, 0x3E1
        in      al, dx                  ; chip ID
        mov     [tmp_base], ax          ; stash ID
        call    pr_ff
        mov     al, [tmp_base]
        cmp     al, 0xFF
        je      .font
        mov     si, dg_id
        call    puts_tty
        mov     al, [tmp_base]
        call    print_hex_al            ; PCIC chip ID (0x83 on PC110)
.font:
        ; ---- Font ROM window @0xDE000, bank 0 ----
        mov     dh, 8
        mov     dl, 2
        call    gotoxy
        mov     si, dg_font
        call    puts_tty
        mov     dx, 0x1160
        xor     al, al
        out     dx, al
        mov     dx, 0x1162
        mov     al, 0xDE
        out     dx, al
        mov     dx, 0x1163
        mov     al, 1
        out     dx, al
        push    es
        mov     ax, 0xDE00
        mov     es, ax
        mov     ax, [es:0]
        pop     es
        cmp     ax, 0xAA55
        mov     si, dg_sigok
        je      .fontp
        mov     si, dg_signo
.fontp: call    puts_tty
        ; ---- COM1 UART (IIR 0x3FA) ----
        mov     dh, 9
        mov     dl, 2
        call    gotoxy
        mov     si, dg_com1
        call    puts_tty
        mov     dx, 0x3FA
        in      al, dx
        call    pr_ff
        ; ---- RTC / CMOS status ----
        mov     dh, 10
        mov     dl, 2
        call    gotoxy
        mov     si, dg_rtc
        call    puts_tty
        mov     al, 0x0D
        call    read_cmos
        test    al, 0x80                ; VRT: RTC battery valid
        mov     si, dg_batok
        jnz     .rtcb
        mov     si, dg_batlo
.rtcb:  call    puts_tty
        mov     al, 0x0E
        call    read_cmos               ; POST diagnostic byte (0 = OK)
        test    al, al
        mov     si, dg_posterr
        jnz     .rtcp
        mov     si, dg_postok
.rtcp:  call    puts_tty
        ; footer
        mov     dh, 12
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; print_bcd : print AL as two BCD digits
print_bcd:
        push    ax
        push    cx
        mov     ah, al
        mov     cl, 4
        shr     al, cl
        add     al, '0'
        call    putc_tty
        mov     al, ah
        and     al, 0x0F
        add     al, '0'
        call    putc_tty
        pop     cx
        pop     ax
        ret

; ============================================================================
;  test_clock : live RTC date/time (BCD) until a key is pressed
; ============================================================================
test_clock:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, tc_title
        call    puts_tty
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, tc_hint
        call    puts_tty
.loop:
.uip:   mov     al, 0x0A
        call    read_cmos
        test    al, 0x80
        jnz     .uip
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, tc_lbl
        call    puts_tty
        mov     al, 0x32
        call    read_cmos
        call    print_bcd
        mov     al, 0x09
        call    read_cmos
        call    print_bcd
        mov     al, '-'
        call    putc_tty
        mov     al, 0x08
        call    read_cmos
        call    print_bcd
        mov     al, '-'
        call    putc_tty
        mov     al, 0x07
        call    read_cmos
        call    print_bcd
        mov     al, ' '
        call    putc_tty
        mov     al, 0x04
        call    read_cmos
        call    print_bcd
        mov     al, ':'
        call    putc_tty
        mov     al, 0x02
        call    read_cmos
        call    print_bcd
        mov     al, ':'
        call    putc_tty
        mov     al, 0x00
        call    read_cmos
        call    print_bcd
        mov     ah, 1
        int     0x16
        jz      .loop
        xor     ah, ah
        int     0x16
        ret

; ============================================================================
;  test_timer : measure the PIT tick counter over ~1 second
; ============================================================================
test_timer:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, tt_title
        call    puts_tty
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, tt_meas
        call    puts_tty
        push    es
        mov     ax, 0x40
        mov     es, ax
        mov     bp, [es:0x6C]
        pop     es
        mov     ax, 18
        call    delay_ticks
        push    es
        mov     ax, 0x40
        mov     es, ax
        mov     ax, [es:0x6C]
        pop     es
        sub     ax, bp
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, tt_res
        call    puts_tty
        call    print_dec_ax
        mov     si, tt_exp
        call    puts_tty
        mov     dh, 7
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  test_mouse : pointing-device (INT 33h) test, guarded by the vector
; ============================================================================
test_mouse:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, ms_title
        call    puts_tty
        push    es
        xor     ax, ax
        mov     es, ax
        mov     ax, [es:0x00CC]
        mov     dx, [es:0x00CE]
        pop     es
        or      ax, dx
        jz      .none
        xor     ax, ax
        int     0x33
        cmp     ax, 0xFFFF
        jne     .none
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, ms_inst
        call    puts_tty
.mloop: mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, ms_pos
        call    puts_tty
        mov     ax, 3
        int     0x33
        push    bx
        push    dx
        mov     ax, cx
        call    print_dec_ax
        mov     al, ','
        call    putc_tty
        pop     dx
        mov     ax, dx
        call    print_dec_ax
        mov     si, ms_btn
        call    puts_tty
        pop     bx
        mov     al, bl
        and     al, 7
        add     al, '0'
        call    putc_tty
        mov     si, ms_pad
        call    puts_tty
        mov     ah, 1
        int     0x16
        jz      .mloop
        xor     ah, ah
        int     0x16
        ret
.none:
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, ms_none
        call    puts_tty
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  diag_disk : storage geometry + sector-0 read test (INT 13h, drive 80h)
; ============================================================================
diag_disk:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, dk_title
        call    puts_tty
        mov     ah, 0x08
        mov     dl, 0x80
        int     0x13
        jc      .err
        mov     [dk_cx], cx
        mov     [dk_dx], dx
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, dk_cyl
        call    puts_tty
        mov     al, [dk_cx+1]       ; CH = cyl low 8 bits
        xor     ah, ah
        mov     bl, [dk_cx]         ; CL: bits 6-7 = cyl high
        and     bl, 0xC0
        mov     cl, 6
        shr     bl, cl
        mov     bh, bl
        xor     bl, bl             ; bx = high<<8
        add     ax, bx
        inc     ax
        call    print_dec_ax
        mov     si, dk_hd
        call    puts_tty
        mov     al, [dk_dx+1]      ; DH = max head
        xor     ah, ah
        inc     ax
        call    print_dec_ax
        mov     si, dk_spt
        call    puts_tty
        mov     al, [dk_cx]        ; CL & 0x3F = sectors/track
        and     al, 0x3F
        xor     ah, ah
        call    print_dec_ax
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, dk_rd
        call    puts_tty
        mov     ax, 0x0201
        mov     cx, 0x0001
        xor     dh, dh
        mov     dl, 0x80
        push    es
        mov     bx, cs
        mov     es, bx
        mov     bx, MEMBUF
        int     0x13
        pop     es
        mov     si, dk_ok
        jnc     .rok
        mov     si, dk_fail
.rok:   call    puts_tty
        jmp     .fin
.err:
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, dk_nodrv
        call    puts_tty
.fin:
        mov     dh, 7
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  diag_power : dump the power-MCU register file (0xEC/0xED, 0x00-0x1F)
; ============================================================================
diag_power:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, pm_title
        call    puts_tty
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        xor     bl, bl
.r0:    mov     dx, 0x00EC
        mov     al, bl
        out     dx, al
        mov     dx, 0x00ED
        in      al, dx
        call    print_hex_al
        mov     al, ' '
        call    putc_tty
        inc     bl
        cmp     bl, 0x10
        jb      .r0
        mov     dh, 4
        mov     dl, 2
        call    gotoxy
        mov     bl, 0x10
.r1:    mov     dx, 0x00EC
        mov     al, bl
        out     dx, al
        mov     dx, 0x00ED
        in      al, dx
        call    print_hex_al
        mov     al, ' '
        call    putc_tty
        inc     bl
        cmp     bl, 0x20
        jb      .r1
        mov     dh, 6
        mov     dl, 2
        call    gotoxy
        mov     si, pm_note
        call    puts_tty
        mov     dh, 8
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  diag_pcmcia : PCMCIA PCIC socket status (0x3E0/0x3E1)
; ============================================================================
diag_pcmcia:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, pc_title
        call    puts_tty
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, pc_id
        call    puts_tty
        mov     dx, 0x3E0
        xor     al, al
        out     dx, al
        mov     dx, 0x3E1
        in      al, dx
        call    print_hex_al
        mov     dh, 4
        mov     dl, 2
        call    gotoxy
        mov     si, pc_s0
        call    puts_tty
        mov     dx, 0x3E0
        mov     al, 0x01
        out     dx, al
        mov     dx, 0x3E1
        in      al, dx
        mov     bl, al
        call    print_hex_al
        mov     si, pc_arrow
        call    puts_tty
        mov     al, bl
        and     al, 0x0C
        cmp     al, 0x0C
        mov     si, pc_card
        je      .s0
        mov     si, pc_empty
.s0:    call    puts_tty
        mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, pc_s1
        call    puts_tty
        mov     dx, 0x3E0
        mov     al, 0x41
        out     dx, al
        mov     dx, 0x3E1
        in      al, dx
        mov     bl, al
        call    print_hex_al
        mov     si, pc_arrow
        call    puts_tty
        mov     al, bl
        and     al, 0x0C
        cmp     al, 0x0C
        mov     si, pc_card
        je      .s1
        mov     si, pc_empty
.s1:    call    puts_tty
        mov     dh, 7
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  diag_scamp : unlock + read + display the VL82C420 SCAMP config space.
;  The config is gated by port 0x22/0x23; it re-locks between bus cycles, so the
;  enable->read->disable is done atomically (interrupts off).  Read-only.
; ============================================================================
diag_scamp:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, cs_title
        call    puts_tty
        ; --- atomic unlock -> read 0x74/0x76 idx 0x00-0x7F -> MEMBUF -> relock ---
        cli
        mov     dx, 0x23
        xor     al, al
        out     dx, al                  ; 0x23 <- 0
        mov     ax, 0x80
        mov     dx, 0x22
        out     dx, al                  ; 0x22 <- 0x80
        out     dx, ax                  ; 0x22 <- word 0x0080  (config access enabled)
        mov     di, MEMBUF
        xor     cl, cl
.rd:    mov     al, cl
        and     al, 0x7F
        mov     dx, 0x74
        out     dx, al
        mov     dx, 0x76
        in      al, dx
        mov     [di], al
        inc     di
        inc     cl
        cmp     cl, 0x80
        jb      .rd
        mov     dx, 0x22
        in      ax, dx
        and     ax, 0xFFFD
        or      ax, 0x100               ; bit8 = locked
        out     dx, ax                  ; config access disabled again
        sti
        ; --- display MEMBUF[0..0x7F] as 8 rows of 16 hex ---
        xor     bx, bx
.dl:    mov     ax, bx
        and     al, 0x0F
        jnz     .noNL
        mov     ax, bx
        mov     cl, 4
        shr     ax, cl
        add     al, 2                   ; screen row = 2 + (offset/16)
        mov     dh, al
        mov     dl, 2
        call    gotoxy
        mov     al, bl
        call    print_hex_al            ; offset label
        mov     al, ':'
        call    putc_tty
        mov     al, ' '
        call    putc_tty
.noNL:  mov     si, MEMBUF
        add     si, bx
        mov     al, [si]
        call    print_hex_al
        mov     al, ' '
        call    putc_tty
        inc     bx
        cmp     bx, 0x80
        jb      .dl
        mov     dh, 11
        mov     dl, 2
        call    gotoxy
        mov     si, cs_note
        call    puts_tty
        mov     dh, 13
        mov     dl, 2
        call    gotoxy
        mov     si, msg_donekey
        call    puts_tty
        call    getkey
        ret

; ============================================================================
;  diag_ptr : pointing-device (trackpad U75, NEC uPD17137A) identify + settings.
;  U75's only host interface is the PS/2 aux channel via the 8042 KBC, so this
;  talks raw 8042: enable aux, reset/identify, read status (resolution + sample
;  rate), and let the user change them live.  Restores the 8042 command byte on
;  exit.  (A loaded mouse driver re-inits the device, so changes are for testing.)
; ============================================================================
; aux_wait_ibf : spin until the 8042 input buffer is empty (status bit1=0)
aux_wait_ibf:
        push    ax
        push    cx
        xor     cx, cx
.w:     in      al, 0x64
        test    al, 0x02
        jz      .ok
        loop    .w
.ok:    pop     cx
        pop     ax
        ret
; aux_get : read one byte from the 8042 output buffer -> AL, CF=1 on timeout
aux_get:
        push    cx
        xor     cx, cx
.w:     in      al, 0x64
        test    al, 0x01
        jnz     .got
        loop    .w
        pop     cx
        stc
        ret
.got:   in      al, 0x60
        pop     cx
        clc
        ret
; aux_write : send AL to the aux device (0xD4 gate byte, then the data)
aux_write:
        push    ax
        call    aux_wait_ibf
        mov     al, 0xD4
        out     0x64, al
        call    aux_wait_ibf
        pop     ax
        out     0x60, al
        ret
; rd_cmdb : read the 8042 command byte -> AL (0x65 fallback on timeout)
rd_cmdb:
        call    aux_wait_ibf
        mov     al, 0x20
        out     0x64, al
        call    aux_get
        jnc     .ok
        mov     al, 0x65
.ok:    ret

ptr_status:                             ; query resolution + sample rate (0xE9)
        mov     al, 0xE9
        call    aux_write
        call    aux_get                 ; FA (ack)
        jc      .d
        call    aux_get                 ; status flags
        jc      .d
        call    aux_get                 ; resolution code
        jc      .d
        mov     [ptr_res], al
        call    aux_get                 ; sample rate
        jc      .d
        mov     [ptr_rate], al
.d:     ret

ptr_reset:                              ; reset (0xFF): FA, AA (BAT), device id
        mov     byte [ptr_ok], 0
        mov     byte [ptr_ridx], 5      ; reset -> default rate 100/s
        mov     al, 0xFF
        call    aux_write
        call    aux_get                 ; FA
        jc      .fail
        call    aux_get                 ; AA = self-test passed
        jc      .fail
        mov     [ptr_bat], al
        call    aux_get                 ; device id
        jc      .fail
        mov     [ptr_id], al
        mov     byte [ptr_ok], 1
        call    ptr_status
.fail:  ret

ptr_cycle_res:                          ; 0xE8 set-resolution, cycle 0..3
        mov     al, [ptr_res]
        inc     al
        and     al, 3
        mov     [ptr_res], al
        mov     al, 0xE8
        call    aux_write
        call    aux_get                 ; FA
        mov     al, [ptr_res]
        call    aux_write
        call    aux_get                 ; FA
        call    ptr_status
        ret

ptr_cycle_rate:                         ; 0xF3 set-sample-rate from pt_rates[]
        mov     al, [ptr_ridx]
        inc     al
        cmp     al, PT_NRATES
        jb      .ok
        xor     al, al
.ok:    mov     [ptr_ridx], al
        xor     ah, ah
        mov     bx, pt_rates
        add     bx, ax
        mov     al, [bx]
        push    ax
        mov     al, 0xF3
        call    aux_write
        call    aux_get                 ; FA
        pop     ax
        call    aux_write               ; rate value
        call    aux_get                 ; FA
        call    ptr_status
        ret

pt_print_res:                           ; AL = resolution code -> "N counts/mm"
        push    cx
        push    si
        mov     cl, al
        mov     al, 1
        shl     al, cl                  ; 0->1 1->2 2->4 3->8 counts/mm
        xor     ah, ah
        call    print_dec_ax
        mov     si, pt_cpermm
        call    puts_tty
        pop     si
        pop     cx
        ret

ptr_draw:
        call    cls_body_full
        mov     dx, 0x0000
        call    gotoxy
        mov     si, pt_title
        call    puts_tty
        cmp     byte [ptr_ok], 0
        je      .noresp
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, pt_bat
        call    puts_tty
        mov     al, [ptr_bat]
        cmp     al, 0xAA
        mov     si, pt_pass
        je      .b1
        mov     si, pt_fail
.b1:    call    puts_tty
        mov     dh, 4
        mov     dl, 2
        call    gotoxy
        mov     si, pt_id
        call    puts_tty
        mov     al, [ptr_id]
        call    print_hex_al
        cmp     byte [ptr_id], 0
        jne     .res
        mov     si, pt_idstd
        call    puts_tty
.res:   mov     dh, 5
        mov     dl, 2
        call    gotoxy
        mov     si, pt_res
        call    puts_tty
        mov     al, [ptr_res]
        call    pt_print_res
        mov     dh, 6
        mov     dl, 2
        call    gotoxy
        mov     si, pt_rate
        call    puts_tty
        mov     al, [ptr_rate]
        xor     ah, ah
        call    print_dec_ax
        mov     si, pt_persec
        call    puts_tty
        jmp     .keys
.noresp:
        mov     dh, 3
        mov     dl, 2
        call    gotoxy
        mov     si, pt_nodev
        call    puts_tty
.keys:
        mov     dh, 9
        mov     dl, 2
        call    gotoxy
        mov     si, pt_keys1
        call    puts_tty
        mov     dh, 10
        mov     dl, 2
        call    gotoxy
        mov     si, pt_keys2
        call    puts_tty
        mov     dh, 12
        mov     dl, 2
        call    gotoxy
        mov     si, pt_note
        call    puts_tty
        ret

diag_ptr:
        call    rd_cmdb                 ; save current 8042 command byte
        mov     [ptr_cmdb], al
        call    aux_wait_ibf
        mov     al, 0xA8               ; enable aux device (mouse clock)
        out     0x64, al
        call    ptr_reset
.redraw:
        call    ptr_draw
.k:     call    getkey
        cmp     al, 0x1B
        je      .exit
        cmp     al, 'r'
        je      .cres
        cmp     al, 'R'
        je      .cres
        cmp     al, 's'
        je      .crate
        cmp     al, 'S'
        je      .crate
        cmp     al, 't'
        je      .ret
        cmp     al, 'T'
        je      .ret
        jmp     .k
.cres:  call    ptr_cycle_res
        jmp     .redraw
.crate: call    ptr_cycle_rate
        jmp     .redraw
.ret:   call    ptr_reset
        jmp     .redraw
.exit:
        ; restore the original 8042 command byte (re-disables aux)
        call    aux_wait_ibf
        mov     al, 0x60
        out     0x64, al
        call    aux_wait_ibf
        mov     al, [ptr_cmdb]
        out     0x60, al
        ret

; ============================================================================
;  Command builders. All produce:
;   - cmdtail (DOS EXEC command tail: count,"/C PS2 ...",CR)
;   - cmdshow (ASCIIZ "PS2 ..." for display)
; ============================================================================
; build_cmd_noopt: SI=cmd ptr -> "PS2 <cmd>"
build_cmd_noopt:
        mov     [bld_ptr], si     ; cmd_begin clobbers SI, so stash it
        call    cmd_begin
        mov     si, [bld_ptr]
        call    app_cmdptr
        jmp     cmd_end

; build_cmd_opt: SI=cmd ptr, [cur_opt]=opt ptr -> "PS2 <cmd> <opt>"
build_cmd_opt:
        mov     [bld_ptr], si
        call    cmd_begin
        mov     si, [bld_ptr]
        call    app_cmdptr
        mov     al, ' '
        call    app_char
        mov     si, [cur_opt]
        call    app_optval        ; append value part (after '=' if the option has one)
        jmp     cmd_end

; build_cmd_ultraopt: [cur_opt]=opt -> "<opt>" (for C:\ULTRACHG.COM <opt>)
build_cmd_ultraopt:
        call    cmd_begin
        mov     si, [cur_opt]
        call    app_optval
        jmp     cmd_end

; build_cmd_raw: SI=full arg string (e.g. "_@REVision") -> "PS2 <arg>"
build_cmd_raw:
        mov     [bld_ptr], si
        call    cmd_begin
        mov     si, [bld_ptr]
        call    app_cmdptr
        jmp     cmd_end

; helpers that build both the exec tail and the display string simultaneously
cmd_begin:
        ; display string starts with the show prefix ("PS2 " by default)
        mov     di, cmdshow
        mov     si, [show_pfx]
.cs:    lodsb
        mov     [di], al
        inc     di
        test    al, al
        jnz     .cs
        dec     di                ; back over the NUL
        mov     [show_ptr], di
        ; exec tail starts "/C PS2 "
        mov     di, cmdtail+1     ; leave room for count byte
        mov     si, pfx_cc
.ct:    lodsb
        test    al, al
        jz      .done
        mov     [di], al
        inc     di
        jmp     .ct
.done:
        mov     [tail_ptr], di
        ret

app_cmdptr:                       ; append ASCIIZ at SI to both buffers
.a:     lodsb
        test    al, al
        jz      .done
        call    app_char
        jmp     .a
.done:  ret

; app_optval : append an option's VALUE part to both buffers.  If the option
;              string contains '=', the value is what follows it; else the whole
;              string (SI = option string).
app_optval:
        push    bx
        mov     bx, si
.scan:  mov     al, [bx]
        test    al, al
        jz      .use              ; no '=' found -> use whole string (SI unchanged)
        cmp     al, '='
        je      .after
        inc     bx
        jmp     .scan
.after: inc     bx                ; skip '='
        mov     si, bx
.use:   pop     bx
        call    app_cmdptr
        ret

app_char:                         ; AL -> both buffers
        push    si
        mov     si, [show_ptr]
        mov     [si], al
        inc     si
        mov     [show_ptr], si
        mov     si, [tail_ptr]
        mov     [si], al
        inc     si
        mov     [tail_ptr], si
        pop     si
        ret

cmd_end:
        ; terminate display string
        mov     si, [show_ptr]
        mov     byte [si], 0
        ; terminate tail with CR and set count byte
        mov     si, [tail_ptr]
        mov     byte [si], 0x0D
        ; count = tail_ptr - (cmdtail+1)
        mov     ax, [tail_ptr]
        sub     ax, cmdtail+1
        mov     bx, cmdtail
        mov     [bx], al
        ret

; ============================================================================
;  do_exec : run COMMAND.COM with the built cmdtail
; ============================================================================
do_exec:
        push    ds
        push    es
        mov     [save_sp], sp
        mov     [save_ss], ss
        mov     ax, cs
        mov     ds, ax
        mov     es, ax
        mov     word [pb_env], 0
        mov     word [pb_tail_off], cmdtail
        mov     [pb_tail_seg], cs
        mov     word [pb_f1_off], 0x5C
        mov     [pb_f1_seg], cs
        mov     word [pb_f2_off], 0x6C
        mov     [pb_f2_seg], cs
        mov     dx, [exec_prog]
        mov     bx, parblk
        mov     ax, 0x4B00
        int     0x21
        cli
        mov     ss, [cs:save_ss]
        mov     sp, [cs:save_sp]
        sti
        pop     es
        pop     ds
        ret

; ============================================================================
;  Selection navigation over the rows[] table
; ============================================================================
; row_ptr: BX=row index -> SI = record address (7 bytes each)
row_ptr:
        mov     ax, bx
        mov     cx, 7
        mul     cx
        add     ax, rows
        mov     si, ax
        ret

first_item:
        mov     word [sel], 0
.f:     mov     bx, [sel]
        call    row_ptr
        cmp     byte [si+6], R_HEAD
        jne     .done
        inc     word [sel]
        jmp     .f
.done:  ret

next_item:
        mov     ax, [sel]
.n:     inc     ax
        cmp     ax, ROWCOUNT
        jae     .stop
        mov     bx, ax
        push    ax
        call    row_ptr
        pop     ax
        cmp     byte [si+6], R_HEAD
        je      .n
        mov     [sel], ax
        call    fix_scroll
        ret
.stop:  ret

prev_item:
        mov     ax, [sel]
.p:     cmp     ax, 0
        je      .stop
        dec     ax
        mov     bx, ax
        push    ax
        call    row_ptr
        pop     ax
        cmp     byte [si+6], R_HEAD
        je      .p
        mov     [sel], ax
        call    fix_scroll
        ret
.stop:  ret

; keep [sel] within the visible window [top, top+VIS_ROWS)
fix_scroll:
        mov     ax, [sel]
        mov     bx, [top]
        cmp     ax, bx
        jae     .below
        mov     [top], ax         ; scrolled above -> move top up
        ret
.below:
        sub     ax, bx
        cmp     ax, VIS_ROWS
        jb      .ok
        ; sel >= top+VIS_ROWS -> top = sel-VIS_ROWS+1
        mov     ax, [sel]
        sub     ax, VIS_ROWS-1
        mov     [top], ax
.ok:    ret

; ============================================================================
;  Options list iteration ( [opt_base] = base, options are ASCIIZ, 0-terminated
;  list ends at an empty string )
; ============================================================================
; opt_count -> CX = number of options
opt_count:
        mov     si, [opt_base]
        xor     cx, cx
.c:     cmp     byte [si], 0
        je      .done
        inc     cx
.skip:  lodsb
        test    al, al
        jnz     .skip
        jmp     .c
.done:  ret

; opt_ptr -> SI = pointer to option number [opt_sel]
opt_ptr:
        mov     si, [opt_base]
        mov     cx, [opt_sel]
.l:     jcxz    .done
.skip:  lodsb
        test    al, al
        jnz     .skip
        dec     cx
        jmp     .l
.done:  ret

; ============================================================================
;  Drawing
; ============================================================================
draw_all:
        call    cls_body_full
        ; title bar
        mov     dh, 0
        mov     dl, 0
        mov     ah, A_TITLE
        call    fill_row
        mov     di, 0             ; row 0
        mov     si, t_title
        mov     ah, A_TITLE
        mov     bx, (0*80+2)*2
        call    puts_at
        ; footer
        mov     dh, 24
        mov     ah, A_FOOT
        call    fill_row
        mov     si, t_foot
        mov     ah, A_FOOT
        mov     bx, (24*80+2)*2
        call    puts_at
        call    draw_list
        ret

draw_list:
        ; clear list area rows VIS_TOP..VIS_TOP+VIS_ROWS-1
        mov     cx, VIS_ROWS
        mov     dh, VIS_TOP
.clr:   push    cx
        mov     ah, A_BODY
        call    fill_row
        inc     dh
        pop     cx
        loop    .clr
        ; render rows[top .. top+VIS_ROWS)
        mov     word [ri], 0
.next:
        mov     ax, [ri]
        cmp     ax, VIS_ROWS
        jae     .done
        mov     bx, [top]
        add     bx, ax
        cmp     bx, ROWCOUNT
        jae     .done
        push    bx
        call    row_ptr           ; SI=record
        pop     bx
        ; screen row = VIS_TOP + ri
        mov     ax, [ri]
        add     ax, VIS_TOP
        ; compute B800 offset = (ax*80 + col)*2
        mov     cx, ax
        imul    cx, 160
        ; choose attribute + column by type
        mov     dl, [si+6]        ; type
        cmp     dl, R_HEAD
        jne     .item
        ; header
        mov     ah, A_HEAD
        mov     bp, [si]          ; label ptr
        mov     di, cx
        add     di, 2*2           ; col 2
        push    si
        mov     si, bp
        call    puts_di
        pop     si
        jmp     .adv
.item:
        ; is this row the selected one?  (compute in BX to preserve AH later)
        mov     bx, [top]
        add     bx, [ri]
        cmp     bx, [sel]
        jne     .notsel
        ; selected: highlight the whole row, draw label in A_SEL
        mov     ah, A_SEL
        push    cx
        push    si
        mov     dh, byte [ri]
        add     dh, VIS_TOP
        call    fill_row_attr     ; fills current row with AH attr (AX preserved)
        pop     si
        pop     cx
        jmp     .drawitem
.notsel:
        mov     ah, A_BODY
.drawitem:
        mov     bp, [si]          ; label
        mov     di, cx
        add     di, 4*2           ; col 4 (indent items)
        push    si
        mov     si, bp
        call    puts_di
        pop     si
.adv:
        inc     word [ri]
        jmp     .next
.done:
        ret

; draw_picker: popup box listing options of the current item
draw_picker:
        ; box at row 6..(6+n+2), col 25..55
        call    opt_count
        mov     [pk_n], cx
        ; frame background
        mov     word [pk_row], 0
.bg:
        mov     ax, [pk_row]
        mov     cx, [pk_n]
        add     cx, 2
        cmp     ax, cx
        jae     .bgd
        mov     dh, al
        add     dh, 6
        mov     dl, 24
        mov     bx, 30
        mov     ah, A_BOX
        call    fill_box_row
        inc     word [pk_row]
        jmp     .bg
.bgd:
        ; title
        mov     si, pk_title
        mov     ah, A_BOX
        mov     bx, (6*80+26)*2
        call    puts_at
        ; options
        mov     word [pk_i], 0
.op:
        mov     ax, [pk_i]
        cmp     ax, [pk_n]
        jae     .opd
        mov     [opt_sel_tmp], ax
        ; row = 7 + i
        mov     cx, ax
        add     cx, 7
        imul    cx, 160
        add     cx, 26*2
        mov     di, cx
        ; attr: selected option highlighted
        mov     ah, A_BOX
        mov     bx, [pk_i]
        cmp     bx, [opt_sel]
        jne     .noh
        mov     ah, A_SEL
.noh:
        ; get option ptr #i
        push    ax
        mov     ax, [opt_base]
        mov     [tmp_base], ax
        pop     ax
        call    ptr_to_opt        ; SI = option #[pk_i]
        call    puts_opt          ; display part only (stops at '=')
        inc     word [pk_i]
        jmp     .op
.opd:
        ret

; ptr_to_opt: uses [pk_i] index into [opt_base] -> SI
ptr_to_opt:
        mov     si, [opt_base]
        mov     cx, [pk_i]
.l:     jcxz    .done
.s:     lodsb
        test    al, al
        jnz     .s
        dec     cx
        jmp     .l
.done:  ret

; draw_confirm: box showing the command, Y/N
draw_confirm:
        mov     word [pk_row], 0
.bg:    mov     ax, [pk_row]
        cmp     ax, 5
        jae     .bgd
        mov     dh, al
        add     dh, 9
        mov     dl, 12
        mov     bx, 56
        mov     ah, A_BOX
        call    fill_box_row
        inc     word [pk_row]
        jmp     .bg
.bgd:
        mov     si, cf_title
        mov     ah, A_BOX
        mov     bx, (9*80+14)*2
        call    puts_at
        mov     si, cmdshow
        mov     ah, 0x1E          ; yellow on blue
        mov     bx, (11*80+14)*2
        call    puts_at
        mov     si, cf_prompt
        mov     ah, A_BOX
        mov     bx, (12*80+14)*2
        call    puts_at
        ret

; ============================================================================
;  Low-level screen helpers  (direct write to B800)
; ============================================================================
; puts_at: SI=string, AH=attr, BX=byte offset in B800
puts_at:
        mov     di, bx
puts_di:
        push    es
        push    ax
        mov     ax, 0xB800
        mov     es, ax
        pop     ax
.n:     lodsb
        test    al, al
        jz      .d
        mov     [es:di], al
        mov     [es:di+1], ah
        add     di, 2
        jmp     .n
.d:     pop     es
        ret

; puts_opt : like puts_di, but a "display=value" option prints only the display
;            part (stops at NUL or '=').  SI=string, AH=attr, DI=offset.
puts_opt:
        push    es
        push    ax
        mov     ax, 0xB800
        mov     es, ax
        pop     ax
.n:     lodsb
        test    al, al
        jz      .d
        cmp     al, '='
        je      .d
        mov     [es:di], al
        mov     [es:di+1], ah
        add     di, 2
        jmp     .n
.d:     pop     es
        ret

; fill_row: fill row DH with spaces, attr AH  (whole 80 cols)
fill_row:
        push    es
        push    ax
        mov     al, dh
        mov     ah, 160
        mul     ah
        mov     di, ax
        mov     ax, 0xB800
        mov     es, ax
        pop     ax
        mov     cx, 80
        mov     al, ' '
.f:     mov     [es:di], al
        mov     [es:di+1], ah
        add     di, 2
        loop    .f
        pop     es
        ret

; fill_row_attr: like fill_row but keeps existing chars, sets attr AH on row DH
fill_row_attr:
        push    es
        push    ax
        mov     al, dh
        mov     bl, 160
        mul     bl
        mov     di, ax
        mov     ax, 0xB800
        mov     es, ax
        pop     ax
        mov     cx, 80
.f:     mov     [es:di+1], ah
        add     di, 2
        loop    .f
        pop     es
        ret

; fill_box_row: row DH, start col DL, width BX, attr AH -> spaces
fill_box_row:
        push    es
        push    ax
        mov     al, dh
        mov     ah, 160
        mul     ah
        mov     di, ax            ; row base
        xor     ah, ah
        mov     al, dl
        shl     ax, 1
        add     di, ax            ; + col*2
        mov     ax, 0xB800
        mov     es, ax
        pop     ax
        mov     cx, bx
        mov     al, ' '
.f:     mov     [es:di], al
        mov     [es:di+1], ah
        add     di, 2
        loop    .f
        pop     es
        ret

cls_body_full:
        push    es
        mov     ax, 0xB800
        mov     es, ax
        xor     di, di
        mov     cx, 80*25
        mov     ax, 0x0F20        ; bright white on black, space
        rep     stosw
        pop     es
        ret

; gotoxy: DL=col DH=row  (BIOS)
gotoxy:
        push    ax
        push    bx
        mov     ah, 2
        xor     bh, bh
        int     0x10
        pop     bx
        pop     ax
        ret

; puts_tty: SI=ASCIIZ via BIOS teletype (for child-run screens)
puts_tty:
        push    ax
        push    bx
.n:     lodsb
        test    al, al
        jz      .d
        mov     ah, 0x0E
        mov     bx, 0x0007
        int     0x10
        jmp     .n
.d:     pop     bx
        pop     ax
        ret

; getkey -> AL=ascii AH=scan
getkey:
        mov     ah, 0
        int     0x16
        ret

; ============================================================================
;  DATA
; ============================================================================
sel        dw 0
top        dw 0
ri         dw 0
opt_base   dw 0
opt_sel    dw 0
opt_sel_tmp dw 0
cur_cmd    dw 0
cur_opt    dw 0
show_ptr   dw 0
tail_ptr   dw 0
bld_ptr    dw 0
pw_ok      db 0
pw_stat    db 0
pw_ac      db 0
pw_bat     db 0
pw_pct     db 0
pw_ver     dw 0
pw_flags   dw 0
pw_time    dw 0
pd_go      db 0
save_sp    dw 0
save_ss    dw 0
pk_n       dw 0
pk_row     dw 0
pk_i       dw 0
tmp_base   dw 0
fhandle    dw 0
dseg       dw 0
dchunks    dw 0
exec_prog  dw progname            ; program EXEC'd by do_exec (default PS2.EXE)
show_pfx   dw pfx_ps2             ; confirm-dialog display prefix (default "PS2 ")
ultra_mode db 0                   ; 1 while an ULTRACHG (charging) item is active
cpu_v      times 13 db 0          ; CPUID vendor string
cpu_sig    dw 0                   ; CPUID leaf-1 signature (low word)
cpu_feat   dw 0                   ; CPUID leaf-1 feature flags (low word of EDX)
dk_cx      dw 0                   ; INT 13h/08 returned CX (cyl/sectors)
dk_dx      dw 0                   ; INT 13h/08 returned DX (heads/#drives)
ptr_res    db 0                   ; pointing device: resolution code 0..3
ptr_rate   db 0                   ; pointing device: sample rate (reports/sec)
ptr_id     db 0                   ; pointing device: PS/2 device id
ptr_bat    db 0                   ; pointing device: reset self-test byte (AA=ok)
ptr_ok     db 0                   ; 1 if the aux device answered
ptr_cmdb   db 0                   ; saved 8042 command byte (restored on exit)
ptr_ridx   db 5                   ; index into pt_rates[] (5 = 100/s default)

; EXEC parameter block
parblk:
pb_env      dw 0
pb_tail_off dw 0
pb_tail_seg dw 0
pb_f1_off   dw 0
pb_f1_seg   dw 0
pb_f2_off   dw 0
pb_f2_seg   dw 0

progname   db "C:\PS2.EXE",0
ultra_prog db "C:\ULTRACHG.COM",0
pfx_cc     db " ",0                 ; child tail is just " <args>"
pfx_ps2    db "PS2 ",0
pfx_ultra  db "ULTRACHG ",0
fn_set     db "C:\PC110SET.BIN",0
cmd_rev    db "_@REVision",0

t_title    db "PS2TUI  -  IBM PalmTop PC110 System Manager  -  by Ahmad Byagowi",0
t_foot     db " UP/DN  ENTER change  C current  B power  R revisions  ESC quit ",0
cf_hdr     db "Current settings  (read live from CMOS)",0
cf_click   db "Keyboard click ...... ",0
cf_stat    db "LCD status panel .... ",0
cf_pmode   db "Power-saving mode ... ",0
cf_vexp    db "Vertical expand ..... ",0
cf_on      db "ON",0
cf_off     db "OFF",0
cf_auto    db "Auto",0
cf_time    db "Time",0
cf_batt    db "Battery",0
cf_high    db "High",0
cf_lowmed  db "Low/Medium",0
cf_note    db "(these read straight from CMOS 44/70/72 - no PS2.EXE)",0
pw_hdr     db "Power / Battery status  (live, via APM BIOS)",0
pw_l_apm   db "APM BIOS ....... ",0
pw_l_ver   db "   (APM spec ver ",0
pw_l_ac    db "AC line ........ ",0
pw_l_bat   db "Battery ........ ",0
pw_l_pct   db "Charge ......... ",0
pw_yes     db "present",0
pw_no      db "not present",0
pw_nostat  db "power status unavailable",0
pw_ac_off  db "Off-line (on battery)",0
pw_ac_on   db "On-line (AC adapter)",0
pw_ac_bak  db "On backup power",0
pw_b_high  db "High",0
pw_b_low   db "Low",0
pw_b_crit  db "Critical",0
pw_b_chg   db "Charging",0
pw_unk     db "Unknown",0
pk_title   db "Choose value:",0
cf_title   db "Run this command?",0
cf_prompt  db "Press Y to run, N to cancel",0
msg_running db "Running: ",0
msg_donekey db "--- done.  Press any key to return to PS2TUI ---",0
crlf       db 13,10,0

; ---- buffers ----
cmdshow    times 96 db 0        ; "PS2 ..." display
cmdtail    times 96 db 0        ; count,"/C PS2 ...",CR

; ============================================================================
;  ROWS TABLE  (each record: dw label, dw cmd, dw opts, db type)  = 7 bytes
; ============================================================================
%macro ROW 4
  dw %1, %2, %3
  db %4
%endmacro
rows:
  ROW c_power,0,0,R_HEAD
  ROW l_pmode, k_pmode, o_pmode, R_ITEM
  ROW l_susp,  k_power, o_min,   R_ITEM
  ROW l_lcdoff,k_lcd,   o_lcd,   R_ITEM
  ROW l_speed, k_speed, o_speed, R_ITEM
  ROW l_cover, k_cover, o_endis, R_ITEM
  ROW l_ring,  k_ri,    o_endis, R_ITEM
  ROW l_charge,0,       o_endis, R_UITEM
  ROW l_pdef,  k_default,0,      R_ACT

  ROW c_disp,0,0,R_HEAD
  ROW l_screen,k_screen,o_screen,R_ITEM
  ROW l_vexp,  k_vexp,  o_onoff, R_ITEM

  ROW c_dev,0,0,R_HEAD
  ROW l_airq,  k_airq,  o_irq,   R_ITEM
  ROW l_adma,  k_adma,  o_dma,   R_ITEM
  ROW l_aadd,  k_aadd,  o_aadd,  R_ITEM
  ROW l_iirq,  k_iirq,  o_irq,   R_ITEM
  ROW l_iadd,  k_iadd,  o_iadd,  R_ITEM
  ROW l_ir,    k_ir,    o_com,   R_ITEM
  ROW l_ser,   k_ser,   o_com,   R_ITEM
  ROW l_imod,  k_imod,  o_com,   R_ITEM
  ROW l_pmod,  k_pmod,  o_com,   R_ITEM

  ROW c_kbd,0,0,R_HEAD
  ROW l_click, k_click, o_onoff, R_ITEM
  ROW l_kspd,  k_kspd,  o_kspd,  R_ITEM
  ROW l_kdel,  k_kdel,  o_kdel,  R_ITEM
  ROW l_kdev,  k_kdev,  o_kdev,  R_ITEM

  ROW c_adv,0,0,R_HEAD
  ROW l_lpt,   k_lpt,   o_lpt,   R_ITEM
  ROW l_ata,   k_ata,   o_ata,   R_ITEM
  ROW l_pcic,  k_pcic,  o_endis, R_ITEM
  ROW l_pccd,  k_pccd,  o_endis, R_ITEM
  ROW l_stat,  k_stat,  o_stat,  R_ITEM
  ROW l_batt,  k_batt,  o_batt,  R_ITEM
  ROW l_fddpm, k_fddpm, o_endis, R_ITEM
  ROW l_irqc,  k_irqc,  o_endis, R_ITEM
  ROW l_tokn,  k_tokn,  o_tokn,  R_ITEM
  ROW l_comb,  k_comb,  o_comb,  R_ITEM

  ROW c_dump,0,0,R_HEAD
  ROW l_dbios,  dump_bios,  0, R_CALL
  ROW l_dvbios, dump_vbios, 0, R_CALL
  ROW l_dfont,  dump_font,  0, R_CALL

  ROW c_test,0,0,R_HEAD
  ROW l_tmem,   test_mem,   0, R_CALL
  ROW l_tvid,   test_vid,   0, R_CALL
  ROW l_tkbd,   test_kbd,   0, R_CALL
  ROW l_tspk,   test_spk,   0, R_CALL
  ROW l_tclk,   test_clock, 0, R_CALL
  ROW l_ttmr,   test_timer, 0, R_CALL
  ROW l_tmouse, test_mouse, 0, R_CALL

  ROW c_diag,0,0,R_HEAD
  ROW l_diag,   diag_scan,  0, R_CALL
  ROW l_ddisk,  diag_disk,  0, R_CALL
  ROW l_dpwr,   diag_power, 0, R_CALL
  ROW l_dpcm,   diag_pcmcia,0, R_CALL
  ROW l_dcfg,   diag_scamp, 0, R_CALL
  ROW l_dptr,   diag_ptr,   0, R_CALL

  ROW c_backup,0,0,R_HEAD
  ROW l_bkup,   backup_settings,  0, R_CALL
  ROW l_rest,   restore_settings, 0, R_CALL

  ROW c_act,0,0,R_HEAD
  ROW l_rev,   0,0,             R_INFO
  ROW l_off,   k_off,   0,      R_ACT
  ROW l_hoff,  k_hoff,  0,      R_ACT
  ROW l_adef,  k_adef,  0,      R_ACT
rows_end:
ROWCOUNT equ (rows_end-rows)/7

; ---- category labels ----
c_power  db "== POWER ==",0
c_disp   db "== DISPLAY ==",0
c_dev    db "== DEVICES ==",0
c_kbd    db "== KEYBOARD ==",0
c_adv    db "== ADVANCED ==",0
c_dump   db "== DUMPS (to C:) ==",0
c_test   db "== SYSTEM TEST ==",0
c_diag   db "== DIAGNOSTICS ==",0
c_backup db "== BACKUP ==",0
c_act    db "== INFO / ACTIONS ==",0

; ---- item labels ----
l_pmode  db "Battery power-saving mode",0
l_susp   db "Auto-suspend after idle",0
l_lcdoff db "Screen off after idle",0
l_speed  db "CPU speed",0
l_cover  db "Suspend when cover closes",0
l_ring   db "Wake on phone ring",0
l_pdef   db "Reset basic settings to defaults",0
l_screen db "Display output",0
l_vexp   db "Stretch display (vertical expand)",0
l_airq   db "SoundBlaster IRQ",0
l_adma   db "SoundBlaster DMA",0
l_iirq   db "Digitizer (inking) IRQ",0
l_iadd   db "Digitizer (inking) I/O address",0
l_ir     db "Infrared port",0
l_ser    db "Serial port",0
l_imod   db "Internal modem port",0
l_pmod   db "PCMCIA modem port",0
l_click  db "Keyboard click sound",0
l_kspd   db "Keyboard typematic rate",0
l_kdel   db "Keyboard typematic delay",0
l_kdev   db "Keyboard device select",0
l_lpt    db "Parallel port mode",0
l_ata    db "IDE/ATA controller order",0
l_pcic   db "PCMCIA controller",0
l_pccd   db "Support 3V PCMCIA cards",0
l_stat   db "LCD status panel shows",0
l_batt   db "Battery charge profile",0
l_fddpm  db "Floppy power management",0
l_irqc   db "IRQ clear",0
l_tokn   db "Token-ring RIPL speed",0
l_comb   db "! COMB serial-mux device",0
l_aadd   db "SoundBlaster I/O address",0
l_dbios  db "Dump system BIOS  -> PC110BIO.BIN",0
l_dvbios db "Dump video BIOS   -> PC110VID.BIN",0
l_dfont  db "Dump font ROM     -> PC110FNT.BIN",0
l_tmem   db "Memory info + RAM test",0
l_tvid   db "Video / colour test",0
l_tkbd   db "Keyboard test",0
l_tspk   db "Speaker test (beep)",0
l_tclk   db "Real-time clock test (live)",0
l_ttmr   db "Timer (PIT) test",0
l_tmouse db "Pointing device test",0
l_diag   db "Hardware scan / report",0
l_ddisk  db "Storage / disk info + read test",0
l_dpwr   db "Power / battery MCU detail",0
l_dpcm   db "PCMCIA socket status",0
l_dcfg   db "Chipset config (VL82C420)",0
l_dptr   db "Pointing device (identify + settings)",0
l_charge db "Operation charging (charge while running)",0
l_bkup   db "Backup all settings  -> PC110SET.BIN",0
l_rest   db "Restore all settings <- PC110SET.BIN",0
l_rev    db "Show firmware revisions",0
l_off    db "! Suspend the PC110 now",0
l_hoff   db "! Power OFF the PC110 now",0
l_adef   db "! Reset ALL advanced settings",0

; ---- PS2 command words ----
k_pmode  db "PMODE",0
k_power  db "POWER",0
k_lcd    db "LCD",0
k_speed  db "SPEED",0
k_cover  db "COVER",0
k_ri     db "RI",0
k_default db "DEFAULT",0
k_screen db "SCREEN",0
k_vexp   db "VEXP",0
k_airq   db "IRQAUDIO",0
k_adma   db "DMAAUDIO",0
k_aadd   db "ADDAUdio",0
k_iirq   db "IRQINKING",0
k_iadd   db "ADDINKING",0
k_ir     db "IR",0
k_ser    db "SERIAL",0
k_imod   db "IMODEM",0
k_pmod   db "PMODEM",0
k_click  db "CLICK",0
k_kspd   db "_@KEYBOARD SPEED",0
k_kdel   db "_@KEYBOARD RESPONSE",0
k_kdev   db "_@KEYBOARD DEVICE",0
k_lpt    db "_@LPT",0
k_ata    db "_@ATA",0
k_pcic   db "_@PCIC",0
k_pccd   db "_@PCCD3V",0
k_stat   db "_@STATUS",0
k_batt   db "_@BATTERY",0
k_fddpm  db "_@FDDPM",0
k_irqc   db "_@IRQClear",0
k_tokn   db "_@Token ring",0
k_comb   db "_@COMB",0
k_off    db "OFF",0
k_hoff   db "_@OFF",0
k_adef   db "_@DEFAULT",0

; ---- option lists (ASCIIZ each, empty string terminates) ----
o_pmode  db "High",0,"Medium",0,"Low",0,0
o_min    db "0",0,"1",0,"3",0,"5",0,"10",0,"15",0,"30",0,"60",0,"99",0,0
o_lcd    db "0",0,"1",0,"3",0,"5",0,"10",0,"15",0,"17",0,0
o_speed  db "Fast",0,"Medium",0,"Slow",0,0
o_endis  db "Enable",0,"Disable",0,0
o_screen db "LCD",0,"CRT",0,0
o_onoff  db "ON",0,"OFF",0,0
o_irq    db "5",0,"10",0,"Disable",0,0
o_dma    db "1",0,"3",0,0
o_iadd   db "15E0",0,"25E0",0,"35E0",0,0
o_com    db "COM1=1",0,"COM2=2",0,"Off=Disable",0,0
o_kspd   db "Med",0,"Fast",0,0
o_kdel   db "Normal",0,"Long",0,0
o_kdev   db "Auto",0,"Both",0,0
o_lpt    db "BI",0,"UNI",0,"ECP",0,"EPP",0,0
o_ata    db "Primary",0,"Secondary",0,0
o_stat   db "Auto",0,"Time",0,"Battery",0,0
o_tokn   db "4Mbps",0,"16Mbps",0,0
o_comb   db "RS232",0,"IRda",0,"MIDI",0,"ASK",0,0
o_aadd   db "0220",0,0

; ---- dump / test strings ----
fn_bios   db "C:\PC110BIO.BIN",0
fn_vbios  db "C:\PC110VID.BIN",0
fn_font   db "C:\PC110FNT.BIN",0
msg_dbios  db "Dumping system BIOS (F000, 64 KB) -> C:\PC110BIO.BIN ...",0
msg_dvbios db "Dumping video BIOS (C000, 32 KB) -> C:\PC110VID.BIN ...",0
msg_dfont  db "Dumping font ROM (1 MB, 128 banks) -> C:\PC110FNT.BIN ...",0
msg_ddone  db "Done.",0
msg_backup db "Backing up CMOS settings (0x10-0x7F) -> C:\PC110SET.BIN ...",0
msg_bdone  db "Done.  All CMOS-stored settings saved.",0
msg_restore db "Restore CMOS settings from C:\PC110SET.BIN",0
msg_rconf  db "Overwrite CMOS from backup?  Y = yes (reboot needed), any other key = cancel",0
msg_rcancel db "Cancelled.  CMOS not changed.",0
msg_rdone  db "Restored.  Reboot the PC110 for the settings to take effect.",0
msg_derr   db "ERROR: could not create the output file.",0
msg_tmem   db "Memory information and RAM test",0
tm_base    db "Conventional memory : ",0
tm_ext     db "Extended memory     : ",0
tm_kb      db " KB",0
tm_run     db "RAM pattern test (16 KB scratch) : ",0
tm_pass    db "PASS",0
tm_fail    db "*** FAIL ***",0
tv_title   db "Video / colour test  (16 fg blocks, 8 bg bars, char set)",0
tk_title   db "Keyboard test - press any key; ESC to exit",0
tk_scan    db "scancode = ",0
tk_ascii   db "   ascii = ",0
tk_char    db "   char = ",0
ts_title   db "Speaker test - you should hear a ~1 kHz beep",0
; ---- diagnostics strings ----
dg_hdr     db "Hardware diagnostics  (live probe)",0
dg_cpu     db "CPU ............ ",0
dg_486     db "486-class (pre-CPUID)",0
dg_fam     db "  fam ",0
dg_mdl     db " mdl ",0
dg_stp     db " stp ",0
dg_fpu     db "  FPU: ",0
dg_yes     db "yes",0
dg_no      db "no",0
dg_mem     db "Memory ......... ",0
dg_kb      db " KB",0
dg_ext     db "  ext ",0
dg_apm     db "APM BIOS ....... ",0
dg_bat     db "  batt ",0
dg_scamp   db "SCAMP VL82C420 . ",0
dg_pmcu    db "Power MCU (U6) . ",0
dg_pcic    db "PCMCIA PCIC .... ",0
dg_id      db "  id 0x",0
dg_font    db "Font ROM ....... ",0
dg_sigok   db "signature OK (55AA/FONT)",0
dg_signo   db "signature NOT found",0
dg_com1    db "COM1 UART ...... ",0
dg_rtc     db "RTC / CMOS ..... ",0
dg_present db "present",0
dg_absent  db "absent",0
dg_batok   db "battery OK",0
dg_batlo   db "battery LOW/dead",0
dg_postok  db ", no POST errors",0
dg_posterr db ", POST error flagged",0
; ---- clock / timer / mouse / disk / power-mcu / pcmcia strings ----
tc_title   db "Real-time clock test  (live, from the RTC)",0
tc_lbl     db "Now: ",0
tc_hint    db "(watch the seconds advance; press any key to exit)",0
tt_title   db "Timer (PIT) test",0
tt_meas    db "Measuring ~1 second via the BIOS tick counter ...",0
tt_res     db "PIT ticks in ~1 s: ",0
tt_exp     db "  (expected ~18)  - timer OK",0
ms_title   db "Pointing-device test",0
ms_inst    db "Mouse driver present.  Move the pointer / click:",0
ms_pos     db "  x,y = ",0
ms_btn     db "   buttons = ",0
ms_pad     db "    ",0
ms_none    db "No pointing-device driver loaded (INT 33h not installed).",0
dk_title   db "Storage / disk diagnostics  (INT 13h, drive 80h)",0
dk_cyl     db "Cylinders: ",0
dk_hd      db "   Heads: ",0
dk_spt     db "   Sectors/track: ",0
dk_rd      db "Sector 0 read test: ",0
dk_ok      db "OK",0
dk_fail    db "FAILED",0
dk_nodrv   db "drive 80h not present / INT 13h error",0
pm_title   db "Power / battery MCU register file  (ports 0xEC/0xED)",0
pm_note    db "(live power/battery/thermal telemetry - regs 0x00-0x1F)",0
pc_title   db "PCMCIA sockets  (Intel 82365 PCIC, ports 0x3E0/0x3E1)",0
pc_id      db "Controller chip ID: 0x",0
pc_s0      db "Socket 0 status 0x",0
pc_s1      db "Socket 1 status 0x",0
pc_arrow   db "  ->  ",0
pc_card    db "card present",0
pc_empty   db "empty",0
cs_title   db "VL82C420 (SCAMP) config space  (0x74/0x76, unlocked live)",0
cs_note    db "idx 7A/7B = 'SL' signature.  Gate 0x22/0x23; read atomically.",0
patterns   db 0x55,0xAA,0xFF,0x00,0xFE
o_batt   db "Standard",0,"Other",0,0

; ---- pointing-device (trackpad U75) screen ----
pt_title   db "Pointing device  (trackpad U75, NEC uPD17137A - PS/2 aux)",0
pt_bat     db "Self-test ...... ",0
pt_pass    db "PASS (BAT OK)",0
pt_fail    db "unexpected reset code",0
pt_id      db "Device ID ...... 0x",0
pt_idstd   db "  (standard PS/2 mouse)",0
pt_res     db "Resolution ..... ",0
pt_cpermm  db " counts/mm",0
pt_rate    db "Sample rate .... ",0
pt_persec  db " reports/sec",0
pt_nodev   db "No response on the aux channel (trackpad absent/held off).",0
pt_keys1   db "R = cycle resolution     S = cycle sample rate",0
pt_keys2   db "T = reset / re-identify   ESC = back",0
pt_note    db "(live over the 8042 mouse aux; a mouse driver re-inits U75 on load)",0
pt_rates   db 10,20,40,60,80,100,200
PT_NRATES  equ 7
