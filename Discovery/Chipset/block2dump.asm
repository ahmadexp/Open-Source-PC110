        org 0x100
        bits 16
        cli
        mov dx,0x70          ; disable NMI + select CMOS reg 0
        mov al,0x80
        out dx,al
        mov dx,0xFC23        ; four-read config enable (per BIOS 0x2973C / US5630052)
        in  al,dx
        mov dx,0xF023
        in  al,dx
        mov dx,0xC023
        in  al,dx
        mov dx,0x0023
        in  al,dx
        mov di,buf           ; read block2[0x00..0xFF] -> buf
        xor bl,bl
.rd:    mov dx,0x24
        mov al,bl
        out dx,al
        mov dx,0x25
        in  al,dx
        mov [di],al
        inc di
        inc bl
        jnz .rd
        mov dx,0x22          ; re-lock config (set lock bit8)
        in  ax,dx
        and ax,0xFFFD
        or  ax,0x0100
        out dx,ax
        mov dx,0x70          ; re-enable NMI
        xor al,al
        out dx,al
        sti
        mov ah,0x3C          ; create C:\BLK2.BIN
        xor cx,cx
        mov dx,fname
        int 0x21
        jc  .done
        mov bx,ax
        mov ah,0x40          ; write 256 bytes
        mov cx,256
        mov dx,buf
        int 0x21
        mov ah,0x3E          ; close
        int 0x21
.done:  mov ah,0x4C
        int 0x21
fname:  db "C:\BLK2.BIN",0
buf:    times 256 db 0
