.model small
.486p
.stack 100h
.data
msg_banner1     db      "IBM PalmTop PC110 TFT Upgrade",13,10
msg_banner2     db      "-----------------------------",13,10
msg_banner3     db      "Video BIOS Update v1.0 - 2021/02/19",13,10
msg_banner4     db      "Written By Kevin Moonlight (www.yyzkevin.com)",13,10,13,10,13,10,"$"

msg_power       db      "Getting power supply status...","$"
msg_done        db      "Done.",13,10,"$"
msg_ac          db      "Plug in the A/C power adapter and restart to continue.",13,10,"$"
msg_battery     db      "Insert a charged battery (at least 20%) and restart to continue.",13,10,"$"

msg_warning     db      13,10,13,10,"***DISCLAIMER***",13,10
                db      "THIS SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND.",13,10,13,10
                db      "This program should never be run manually or copied.",13,10  
                db      "Misuse can result in corrupted and unrecoverable flash memory.",13,10
                db      "This program will modify the video bios for use with the TFT Upgrade Kit.",13,10  
                db      "Use of the factory display module will no longer be possible.",13,10
                db      "If this process is interrupted your machine could be rendered unusable.",13,10,13,10
                
                
                db      "To Continue press Y.  Any other key to abort...","$"


msg_flash       db      13,10,13,10,"Flashing....","$"
msg_flash_done  db      "Done.",13,10,13,10,"Remove floppy and reboot system.",13,10,"$"
msg_abort       db      13,10,13,10,13,10,"Aborting, no action has been taken.",13,10,"You can safely turn your computer off now.",13,10,"$"

.code

        main proc
                mov     ax, @data
                mov     ds,ax
                lea     dx,msg_banner1
                mov     ah,09h
                int     21h


                lea     dx,msg_power
                mov     ah,09h
                int     21h
                ; http://www.intel.com/IAL/powermgm/apmv12.pdf
                mov     ah,53h          ; APM
                mov     al,0ah          ; Get Power Status
                mov     bx,01h          ; Power ID (1=APM Bios)
                int     15h             ;
                ;cl = battery charge
                ;ch = battery flags
                ;bh = a/c state 0=offline 1=online 2=backup
                ;bl = battery status 0=high 1=low 2=critical 3=charging
                
                lea     dx,msg_done
                mov     ah,09h
                int     21h

                ; Check A/C Power
                cmp     bh,1                
                je      ac_good
                lea     dx,msg_ac
                mov     ah, 09h
                int     21h
                jmp     exit_program
ac_good:
                ; Check Battery                
                cmp     cl, 19
                jg      battery_good
                lea     dx,msg_battery
                mov     ah, 09h
                int 21h
                jmp     exit_program
battery_good:
                lea     dx,msg_warning
                mov     ah, 09h
                int 21h

                mov     ah, 07h
                int     21h
                cmp     al,59h
                je      flash
                lea     dx,msg_abort
                mov     ah,09h
                int     21h
                jmp exit_program

flash:
        lea     dx,msg_flash
        mov     ah, 09h
        int     21h
        

        mov     al, 8Eh ; 'Ä'
        out     70h, al         ; CMOS Memory:
                        ;
        jmp     short $+2
        in      al, 71h         ; CMOS Memory
        cli
        mov     dx, 0FC23h
        in      al, dx
        mov     dx, 0F023h
        in      al, dx
        mov     dx, 0C023h
        in      al, dx
        mov     dx, 23h ; '#'
        in      al, dx
        jmp     short $+2
        mov     al, 0FEh ; '¦'
        out     24h, al
        jmp     short $+2
        in      al, 25h
;        mov     byte_10607, al
        and     al, 0FEh
        mov     ah, al
        jmp     short $+2
        mov     al, 0FEh ; '¦'
        out     24h, al
        jmp     short $+2
        mov     al, ah
        out     25h, al
        jmp     short $+2
        mov     al, 0FAh ; '·'
        out     24h, al
        jmp     short $+2
        mov     al, 1
        out     25h, al
        jmp     short $+2
        out     0FBh, al        ; AT 80287 data.
                                ; 286 sends opcodes & operands and receives results.
        mov     al, 11h
        out     0ECh, al
        jmp     short $+2
        in      al, 0EDh
        jmp     short $+2
;        mov     byte_10608, al
        mov     al, 11h
        out     0ECh, al
        jmp     short $+2
        mov     al, 0
        out     0EDh, al
        jmp     short $+2
        mov     al, 12h
        out     0ECh, al
        jmp     short $+2
        in      al, 0EDh
        jmp     short $+2
;        mov     byte_10609, al
        mov     al, 12h
        out     0ECh, al
        jmp     short $+2
        mov     al, 0
        out     0EDh, al
        jmp     short $+2
        mov     al, 17h
        out     0ECh, al
        jmp     short $+2
        in      al, 0EDh
        jmp     short $+2
;        mov     byte_1060A, al
        mov     al, 17h
        out     0ECh, al
        jmp     short $+2
        mov     al, 55h ; 'U'
        out     0EDh, al
        jmp     short $+2
        mov     al, 18h
        out     0ECh, al
        jmp     short $+2
        in      al, 0EDh
        jmp     short $+2
;        mov     byte_1060B, al
        mov     al, 18h
        out     0ECh, al
        jmp     short $+2
        mov     al, 55h ; 'U'
        out     0EDh, al
        jmp     short $+2
        mov     al, 0Ch
        out     0ECh, al
        jmp     short $+2
        in      al, 0EDh
        jmp     short $+2
;        mov     byte_1060C, al
        and     al, 8Fh
        mov     ah, al
        mov     al, 0Ch
        out     0ECh, al
        jmp     short $+2
        mov     al, ah
        out     0EDh, al
        jmp     short $+2
        out     0F9h, al        ; AT 80287 data.
                                ; 286 sends opcodes & operands and receives results.
        mov     eax, cr0
        mov     eax, cr0
        or      eax, 60000000h
        mov     cr0, eax
        invd
        invd
       
        in      al, 98h
        or      al, 8
        out     98h, al

        in      al, 61h
        and     al, 10h
        out     61h, al
        


;;        mov     ax, 0e000h
;;        mov     es, ax       
;;        mov     al, 40h
;;        mov     di, 7c70h
;;        mov     es:[di], al
        
;;        mov     ax, 0e000h
;;        mov     es, ax       
;;        mov     al, 65
;;        mov     di, 7c70h
;;        mov     es:[di], al
        
;;        mov     al, 70h
;;        mov     es:[di],al

;        
;        mov     al, 0ffh
;        mov     es:[di], al

        ; backup videobios to 3000h
        mov     bx,0e000h
        mov     ds,bx
        mov     esi,0h
        mov     bx,03000h
        mov     es,bx
        mov     edi,0h
        mov     cx,0FFFFh
        rep     movsb

        mov ah,01Fh
        mov es:[01cbh],ah        ;0x1CB 0x1F      ; Linear Start
                                                  ; Windows 256 Color Fix

        mov ah,0c0h
        mov es:[0a9ch],ah        ;0xA9C 0xC0      ;XR6
        
        mov ah,056h
        mov es:[0ae6h],ah        ;0xAE6 0x56      ;XR19
        
        mov ah,013h
        mov es:[0ae8h],ah        ;0xAE8 0x13      ;XR1A
        
        mov ah,05fh
        mov es:[0aeah],ah        ;0xAEA 0x5F      ;XR1B
        
        mov ah,000h
        mov es:[0af6h],ah        ;0xAF6 0x00      ;XR50
        
        mov ah,0c4h
        mov es:[0aa4h],ah        ;0xAA4 0xC4      ;XR51
        
        mov ah,042h
        mov es:[0a9ah],ah        ;0xA9A 0x42      ;XR52
        
        mov ah,00ch
        mov es:[0af7h],ah        ;0xAF7 0x0C      ;XR53
        
        mov ah,0c0h
        mov es:[0aa6h],ah        ;0xAA6 0xC0      ;XR54 C0=25mhz c8=15mhz
        
        mov ah,0c5h
        mov es:[0aa0h],ah        ;0xAA0 0xC5      ;XR4F
        
        mov ah,001h
        mov es:[0afah],ah        ;0xAFA 0x01      ;XR64
        
        mov ah,026h
        mov es:[0afch],ah        ;0xAFC 0x26      ;XR65
        
        mov ah,0dfh
        mov es:[0afeh],ah        ;0xAFE 0xDF      ;XR66
        
        mov ah,005h
        mov es:[0b00h],ah        ;0xB00 0x05      ;XR67
        
        mov ah,000h
        mov es:[0ab8h],ah        ;0xAB8 0x00      ;XR6F
        
        mov ah,000h
        mov es:[0b04h],ah        ;0xB04 0x00      ;XR6F
        
        mov ah,01ch
        mov es:[0ab4h],ah        ;0xAB4 0x1C      ;XR6C 18

        mov     bx,0f000h
        mov     ds,bx
        mov     esi,0h
        mov     bx,04000h
        mov     es,bx
        mov     edi,0h
        mov     cx,7fffh
        rep     movsb



;       Erase Block
        mov     ax, 0e000h
        mov     es, ax       
        mov     al, 20h
        mov     es:[di], al
        mov     al, 0D0h
        mov     es:[di],al

;       Check Wait Machine
         mov    al, 70h
         mov    es:[di],al
stat2:   mov    al,es:[di]
         and   al,80h
         jz    stat2


; reprogram        
        mov     bx,03000h
        mov     ds,bx
        mov     bx,0e000h
        mov     es,bx
        mov     cx,0ffffh
loop1:  mov     di,cx
        sub     di,1
        mov     al, 40h
        mov     es:[di],al
        mov     al,ds:[di]
        mov     es:[di],al
         

;       Check Wait Machine
         mov    al, 70h
         mov    es:[di],al
stat1:   mov    al,es:[di]
         and   al,80h
         jz    stat1

         loop loop1



; reprogram        
        mov     bx,04000h
        mov     ds,bx
        mov     bx,0f000h
        mov     es,bx
        mov     cx,7fffh
loop3:  mov     di,cx
        sub     di,1
        mov     al, 40h
        mov     es:[di],al
        mov     al,ds:[di]
        mov     es:[di],al
         

;       Check Wait Machine
         mov    al, 70h
         mov    es:[di],al
stat3:   mov    al,es:[di]
         and   al,80h
         jz    stat3

         loop loop3







;       Switch back to read array
        mov     al, 0ffh
        mov     es:[di],al

        mov     ax, @data
         mov     ds,ax
                lea     dx,msg_flash_done
                mov     ah,09h
                int     21h
        




exit_program:
                mov     ax,4c00h        ;       
                int     21h             ;
        main endp
end main

