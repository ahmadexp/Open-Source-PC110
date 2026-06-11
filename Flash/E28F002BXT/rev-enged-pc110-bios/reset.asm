; reset.asm — PC110 replacement BIOS, 16-bit real-mode reset stub (NASM)
; Assembled by nasm -f elf, linked by ia16-elf-ld with bios.ld so that:
;   _reset16  lands at physical 0xFFFF0 (F000:FFF0)  -> CPU reset entry
;   _entry16  is the post-reset startup that hands off to C++ bios_main()
;
; Build target: 64 KiB image mapped at F000 (0xF0000..0xFFFFF).

bits 16

; ---------------------------------------------------------------------------
section .entry                      ; placed low in the F000 segment by bios.ld
global _entry16
extern bios_main                    ; freestanding C++ entry (biosmain.cpp)

_entry16:
    cli
    cld
    ; establish a known segment state (real mode)
    mov     ax, 0xF000
    mov     ds, ax                  ; DS = BIOS segment (our own data/rodata)
    xor     ax, ax
    mov     es, ax                  ; ES = 0000 (IVT / BDA)
    ; temporary stack high in (assumed-present) low RAM; real DRAM sizing in C
    mov     ax, 0x0000
    mov     ss, ax
    mov     sp, 0x7000
    ; checkpoint 0x01 to POST port before touching anything else
    mov     al, 0x01
    out     0x80, al
    ; hand off to C++; bios_main() must not return (it ends in INT 19h boot)
    call    bios_main
.hang:
    hlt
    jmp     .hang

; ---------------------------------------------------------------------------
section .reset                      ; bios.ld forces this to offset 0xFFF0
global _reset16
_reset16:
    jmp     0xF000:_entry16         ; far jump to startup (EA xx xx 00 F0)
    times 11 db 0xFF                ; pad; date/checksum bytes can live here
