; ============================================================================
;  lba13.asm -- IBM PC110 BIOS: LBA / EDD (INT 13h extensions) patch payload
; ----------------------------------------------------------------------------
;  Target   : IBM PC110 (2431), 486SX-33, Intel 28F002BXT BIOS flash
;  Stock ROM: E28F002BXT@TSOP40.BIN, 262144 B, sha1 ffadd0d7c0ec619a3cd34c1d030299e1a9da1c58
;  Runs at  : F000:0080  (file offset 0x30080) -- inside the 7808-byte 0xCC hole
;             0x30080..0x31EFF, which lies inside the flasher's safe window
;             0x20000..0x37FFF (PCPATCH.ASM erases/programs exactly that range).
;  Hook     : F000:52BD  (file 0x352BD), the end-of-POST `int 19h`, replaced by
;             a 3-byte near JMP to F000:0080. We re-emit `int 19h` ourselves.
;
;  Assemble : nasm -f bin lba13.asm -o lba13.bin
;             (the builder make_lba_patch.py does this and splices the result)
;
; ----------------------------------------------------------------------------
;  WHAT THIS ADDS
;    * INT 13h AH=41h  EDD installation check          (reports EDD 1.1)
;    * INT 13h AH=42h  extended read   (LBA28, 0x1F0 task file, PIO)
;    * INT 13h AH=43h  extended write  (LBA28, 0x1F0 task file, PIO)
;    * INT 13h AH=48h  extended get drive parameters (+ DPTE)
;    * optional 1024/255/63 CHS translation for AH=02/03/04/08/15 when, and
;      ONLY when, the stock BIOS geometry cannot already reach the whole card.
;
;  WHAT IT DOES NOT DO
;    * No LBA48. LBA28 reaches 2^28 sectors = 128 GiB; a larger card is
;      clamped to 128 GiB-1 and the tail is silently unreachable.
;    * No ATAPI, no slave device (0x1F6=0xB0), no DMA, no multi-sector mode.
;    * Real-mode CHS is still capped at 1024*255*63*512 = 8.4 GB. That is an
;      encoding limit of the INT 13h register fields, not a translation choice.
;
; ----------------------------------------------------------------------------
;  DESIGN NOTES THAT DIFFER FROM THE ORIGINAL DESIGN DOC
;  (each one is a direct consequence of a verification verdict; see README.md)
;
;  [V1] The hook at F000:52BD runs BEFORE the PARAM1 code at F000:8067 that
;       installs F000:BAFE, because 8067 lives inside the INT 19h bootstrap
;       (F000:E6F2 -> F000:7DE4 -> ...), i.e. downstream of our own `int 19h`.
;       So we are installed first and BAFE may end up layered ON TOP of us.
;       => We must NOT replicate BAFE's DL remap. Proof it is unnecessary:
;          F000:8043 `mov al,0x80 / cmp al,[es:0xEC] / jz 0x806B` skips the
;          BAFE install entirely when EBDA:00EC == 0x80, and with [EC]==0x80
;          BAFE's rotation is the identity. Therefore:
;            - BAFE not installed  => EBDA:00EC == 0x80 => DL is already physical
;            - BAFE installed      => BAFE already converted DL to physical
;          Either way the DL we see is the physical drive number. We compare it
;          straight against V_OURDL. (The original design's own remap would have
;          double-remapped in the second case and serviced the wrong device.)
;
;  [V2] F000:BAFE is a transparent pass-through, not a filter; the AH>=0x21
;       clamp lives in the unrelated module at F000:BB78. But no handler in the
;       whole uncompressed ROM implements AH=41/42/43/48 (verified: no
;       `80 FC 42/43/48`, no `81 FB AA 55` anywhere in 0x20000-0x3FFFF), and all
;       three INT 13h dispatchers reject AH >= 0x26. So EDD must be ours, and
;       being outermost is still correct.
;
;  [V3] The 0xCC hole is this BIOS's *advertised* free-scratch pool: the APM
;       installer at E000:955B searches F000 for >=0x356 bytes of 0x0000 and
;       then of 0xCCCC. In the stock image its first search hits the zero run at
;       F000:F100 (0x741 bytes, boot block, which the flasher never erases), so
;       the 0xCC hole is not used today. To stay safe we emit ALL of our code
;       contiguously with no internal 0xCC gaps, so that if the allocator ever
;       falls through to the 0xCCCC search it lands on the untouched spare tail
;       (>= ~F000:0B00) and not on live code. Do not "pretty up" this file by
;       ALIGNing routines onto 0x80 boundaries with 0xCC fill.
;
;  [V4] Base-memory reservation must be gated on the RESERVATION STATE, not on
;       the presence of our signature. POST rebuilds 0040:0013 from scratch on
;       every boot (warm included: POST 1D writes it, POST 40 recreates the
;       EBDA), while the RAM contents at 0x9F80 survive a Ctrl-Alt-Del. A
;       signature-based idempotency check would therefore skip the decrement on
;       a warm boot and leave our live variables inside DOS-allocatable memory.
;       We test  ([0040:000E] - ([0040:0013] << 6)) :
;           == 0     -> not reserved yet, reserve now
;           == 0x40  -> already reserved (defensive; does not happen in stock)
;           else     -> unexpected layout, refuse to install
;
; ============================================================================

                cpu     486
                bits    16
                org     0x0080                  ; F000:0080

; ---------------------------------------------------------------- constants
SIG             equ     0x30313150              ; 'P110' little-endian

OURDL_DEFAULT   equ     0x80                    ; BIOS drive number of the ATA
                                                ; master at 0x1F0 (the PC110's
                                                ; internal PC-Card ATA slot).
                                                ; See README "OURDL".

FALLBACK13_OFF  equ     0xD2D7                  ; boot-block base INT 13h handler
FALLBACK13_SEG  equ     0xF000                  ; (never erased) - chain target of
                                                ; last resort if our RAM block is gone

FLG_PRESENT     equ     0x01
FLG_LBA         equ     0x02
FLG_XLAT        equ     0x04                    ; we own AH=02/03/04/08/15

; ------------------------------------------------- RAM block layout (1 KiB)
; Located at ([0040:000E] - 0x40) == 0x9F80 in the stock configuration.
V_SIG           equ     0x000                   ; dd 'P110'
V_OLD13         equ     0x004                   ; dd  displaced INT 13h vector
V_OURDL         equ     0x008                   ; db  physical drive we own
V_FLAGS         equ     0x009                   ; db  FLG_*
V_TOTSEC        equ     0x00A                   ; dd  LBA28 sectors (clamped)
V_C             equ     0x00E                   ; dw  reported cylinders
V_H             equ     0x010                   ; dw  reported heads
V_S             equ     0x012                   ; dw  reported sectors/track
V_CHSTOT        equ     0x014                   ; dd  C*H*S
V_IDW1          equ     0x018                   ; dw  IDENTIFY word 1
V_IDW3          equ     0x01A                   ; dw  IDENTIFY word 3
V_IDW6          equ     0x01C                   ; dw  IDENTIFY word 6
V_IDW49         equ     0x01E                   ; dw  IDENTIFY word 49
V_FDPT          equ     0x020                   ; 16  our fixed disk param table
V_DPTE          equ     0x030                   ; 16  EDD 1.1 device param table ext
V_LBA           equ     0x040                   ; dd  working LBA
V_CNT           equ     0x044                   ; dw  sectors requested
V_DONE          equ     0x046                   ; dw  sectors transferred
V_BUFOFF        equ     0x048                   ; dw
V_BUFSEG        equ     0x04A                   ; dw
V_CMD           equ     0x04C                   ; db  0x20 read / 0x30 write
V_ATAERR        equ     0x04D                   ; db  raw ATA error register
V_SVSS          equ     0x04E                   ; dw  POST stack save
V_SVSP          equ     0x050                   ; dw
V_SCC           equ     0x052                   ; dw  stock-geometry cylinders
V_SCH           equ     0x054                   ; dw  stock-geometry heads
V_SCS           equ     0x056                   ; dw  stock-geometry sectors
V_TMP           equ     0x058                   ; dw  scratch
IDBUF           equ     0x100                   ; 512 IDENTIFY landing area
STACKTOP        equ     0x400                   ; INIT-private stack 0x300..0x3FF

; ------------------------------------------------ INT 13h stack frame (BP)
; entry sequence: sub sp,4 / push bp / push ds / push es / pusha / mov bp,sp
F_DI            equ     0
F_SI            equ     2
F_BP            equ     4
F_SP            equ     6
F_BX            equ     8
F_DX            equ     10
F_CX            equ     12
F_AX            equ     14
F_ES            equ     16
F_DS            equ     18
F_OBP           equ     20
F_SC            equ     22                      ; 4-byte chain scratch
F_IP            equ     26
F_CS            equ     28
F_FL            equ     30

; --------------------------------------------------------------- I/O macro
; Every ATA register write in this ROM is followed by `out 0x4F,al` as the
; I/O recovery delay (verified at F000:D674/D675, D6CB, D479, D488).
%macro  ATAOUT 0
                out     dx, al
                out     0x4f, al
%endmacro

; ============================================================================
;  INIT -- entered by the displaced JMP at F000:52BD (POST, SS=0000 SP=0400)
; ============================================================================
INIT:
                pusha
                push    ds
                push    es
                cld

                xor     ax, ax
                mov     ds, ax
                mov     ax, [0x040E]            ; EBDA segment
                test    ax, ax
                jz      .out                    ; no EBDA -> refuse
                mov     bx, [0x0413]            ; conventional KB
                shl     bx, 6                   ; top-of-memory segment
                mov     dx, ax
                sub     dx, bx                  ; EBDA - top
                jz      .reserve                ; == 0 : not reserved yet   [V4]
                cmp     dx, 0x40
                jne     .out                    ; unexpected layout -> refuse
                jmp     .initblk                ; already reserved, bx = block
.reserve:
                dec     word [0x0413]           ; 639 -> 638
                sub     bx, 0x40                ; block segment (0x9F80)
.initblk:
                mov     es, bx
                xor     di, di
                mov     cx, 512
                xor     ax, ax
                rep     stosw                   ; wipe the whole 1 KiB
                mov     dword [es:V_SIG], SIG

                ; ---- switch to a private stack ----------------------------
                ; The POST stack is SS=0000 SP=0400, i.e. it grows down into
                ; the top of the IVT. Keep our footprint out of it.
                mov     ax, ss
                mov     [es:V_SVSS], ax
                mov     [es:V_SVSP], sp
                cli
                mov     ss, bx
                mov     sp, STACKTOP
                sti

                call    ATA_IDENT
                jc      .restore
                call    GEOMCALC
                jc      .restore
                call    INSTALL
.restore:
                mov     ax, [es:V_SVSP]
                cli
                mov     ss, [es:V_SVSS]
                mov     sp, ax
                sti
                ; If we did not install (no card, no LBA support, POST saw no
                ; drive) give the kilobyte back, so a card-less PC110 boots
                ; byte-identically to stock with 639 KB, not 638 KB.
                test    byte [es:V_FLAGS], FLG_PRESENT
                jnz     .out
                mov     dword [es:V_SIG], 0
                xor     ax, ax
                mov     ds, ax
                mov     bx, [0x0413]
                shl     bx, 6
                mov     ax, [0x040E]
                sub     ax, bx
                cmp     ax, 0x40                ; is the KB really ours?
                jne     .out
                inc     word [0x0413]
.out:
                pop     es
                pop     ds
                popa
                sti
                int     0x19                    ; displaced bootstrap call
                hlt
                jmp     short $-1

; ----------------------------------------------------------------- INSTALL
; ES = block. Takes over INT 13h and (in translate mode) INT 41h/46h.
INSTALL:
                xor     ax, ax
                mov     ds, ax
                cli
                mov     eax, [0x004C]           ; whatever is outermost now
                mov     [es:V_OLD13], eax       ; (F000:952A on a stock cold boot)
                mov     word [0x004C], OURINT13
                mov     [0x004E], cs            ; = F000
                test    byte [es:V_FLAGS], FLG_XLAT
                jz      .nofdpt
                mov     di, 0x0104              ; INT 41h  = drive 0x80 FDPT
                cmp     byte [es:V_OURDL], 0x80
                je      .setfdpt
                mov     di, 0x0118              ; INT 46h  = drive 0x81 FDPT
.setfdpt:
                mov     word [di], V_FDPT
                mov     [di+2], es
.nofdpt:
                sti
                ret

; ============================================================================
;  ATA_IDENT -- one bounded IDENTIFY DEVICE at POST time.  ES = block.
;  CF=1 on any failure (no card, floating bus, ATAPI, timeout, zero capacity).
; ============================================================================
ATA_IDENT:
                mov     dx, 0x3F6               ; device control: nIEN=1, SRST=0
                mov     al, 0x0A
                ATAOUT
                mov     dx, 0x1F6               ; select master, CHS bit pattern
                mov     al, 0xA0
                ATAOUT
                mov     cx, 10                  ; settle (as E000:C66F does)
.settle:        loop    .settle

                ; ---- presence sniff: costs nothing on a card-less machine --
                mov     dx, 0x1F7
                in      al, dx
                cmp     al, 0xFF                ; floating bus / window down
                je      .fail
                test    al, al                  ; nothing there
                jz      .fail

                call    WAIT_NOT_BSY
                jc      .fail

                xor     al, al                  ; clear the task file
                mov     dx, 0x1F1
                ATAOUT
                inc     dx                      ; 1F2 sector count
                ATAOUT
                inc     dx                      ; 1F3
                ATAOUT
                inc     dx                      ; 1F4
                ATAOUT
                inc     dx                      ; 1F5
                ATAOUT
                inc     dx                      ; 1F6 device/head
                mov     al, 0xA0
                ATAOUT
                inc     dx                      ; 1F7 command
                mov     al, 0xEC                ; IDENTIFY DEVICE
                ATAOUT

                call    WAIT_DRQ                ; ATAPI answers with ERR -> CF=1
                jc      .fail

                mov     di, IDBUF
                mov     dx, 0x1F0
                mov     cx, 256
                cld
                rep     insw                    ; -> ES:DI
                mov     dx, 0x3F6
                in      al, dx                  ; settle

                ; ---- extract the words we keep ----------------------------
                mov     ax, [es:IDBUF + 0*2]
                test    ah, 0x80                ; bit 15 set -> not ATA
                jnz     .fail
                mov     ax, [es:IDBUF + 1*2]
                mov     [es:V_IDW1], ax
                mov     ax, [es:IDBUF + 3*2]
                mov     [es:V_IDW3], ax
                mov     ax, [es:IDBUF + 6*2]
                mov     [es:V_IDW6], ax
                mov     ax, [es:IDBUF + 49*2]
                mov     [es:V_IDW49], ax

                mov     eax, [es:IDBUF + 60*2]  ; words 60..61 = LBA28 sectors
                test    eax, eax
                jz      .fail
                cmp     eax, 0x0FFFFFFF         ; clamp so bits 28..31 are always 0
                jbe     .store
                mov     eax, 0x0FFFFFFF
.store:
                mov     [es:V_TOTSEC], eax
                clc
                ret
.fail:
                stc
                ret

; ============================================================================
;  WAIT_NOT_BSY / WAIT_DRQ
;  Timing comes from the ISA refresh bit (port 0x61 bit 4, toggles every
;  15.085 us) exactly as the stock boot-block loop at F000:D92B does, so the
;  timeout is independent of CPU clock, cache and emulation speed.
;  0x8C outer * 0x40 refresh transitions ~= 2 s.
;  Clobbers AX, CX, DX.  CF=1 on timeout / error.
; ============================================================================
WAIT_NOT_BSY:
                push    bx
                mov     dx, 0x1F7
                mov     bh, 0x8C
.outer:         mov     cx, 0x40
                xor     ah, ah
.poll:          in      al, dx
                test    al, 0x80                ; BSY
                jz      .ok
                in      al, 0x61
                and     al, 0x10
                cmp     al, ah
                je      .poll                   ; refresh bit unchanged
                mov     ah, al
                loop    .poll
                dec     bh
                jnz     .outer
                pop     bx
                stc
                ret
.ok:            pop     bx
                clc
                ret

WAIT_DRQ:
                push    bx
                mov     dx, 0x1F7
                mov     bh, 0x8C
.outer:         mov     cx, 0x40
                xor     ah, ah
.poll:          in      al, dx
                test    al, 0x80                ; BSY set -> keep waiting
                jnz     .tick
                test    al, 0x21                ; ERR | DF -> fail fast
                jnz     .err
                test    al, 0x08                ; DRQ
                jnz     .ok
.tick:          in      al, 0x61
                and     al, 0x10
                cmp     al, ah
                je      .poll
                mov     ah, al
                loop    .poll
                dec     bh
                jnz     .outer
.err:           pop     bx
                stc
                ret
.ok:            pop     bx
                clc
                ret

; ============================================================================
;  GEOMCALC -- decide the operating mode and build FDPT/DPTE.  ES = block.
;  CF=1 -> do not install at all.
; ============================================================================
GEOMCALC:
                xor     ax, ax
                mov     ds, ax
                cmp     byte [0x0475], 0        ; POST hard-disk count
                je      .fail                   ; POST saw no drive -> stay out
                mov     byte [es:V_OURDL], OURDL_DEFAULT
                test    byte [es:V_IDW49+1], 0x02   ; word 49 bit 9 = LBA
                jz      .fail                   ; non-LBA drive is < 8.4 GB;
                                                ; the stock path already works

                ; ---- 1024/255/63-style translated geometry ----------------
                mov     eax, [es:V_TOTSEC]
                mov     cx, 16
                cmp     eax, 1024*16*63
                jbe     .haveh
                mov     cx, 32
                cmp     eax, 1024*32*63
                jbe     .haveh
                mov     cx, 64
                cmp     eax, 1024*64*63
                jbe     .haveh
                mov     cx, 128
                cmp     eax, 1024*128*63
                jbe     .haveh
                mov     cx, 255
.haveh:
                mov     [es:V_H], cx
                mov     word [es:V_S], 63
                movzx   ebx, cx
                imul    ebx, ebx, 63            ; ebx = H * 63
                xor     edx, edx
                div     ebx                     ; eax = C
                cmp     eax, 1024
                jbe     .cok
                mov     eax, 1024
.cok:
                test    eax, eax
                jz      .fail
                mov     [es:V_C], ax
                movzx   eax, word [es:V_C]
                mul     ebx                     ; C * H * 63
                mov     [es:V_CHSTOT], eax

                ; ---- can the STOCK geometry already reach the whole card? --
                ; Stock FDPT: EBDA:003D (drive 0x80) / EBDA:004D (0x81).
                ;   reported C = ([+0] >> [+4]) - 2
                ;   reported H = ((byte [+2] << [+4]) & 0xFF), 0 meaning 256
                ;   reported S = byte [+0x0E]
                ; (byte-for-byte the arithmetic of the stock AH=08 at F000:D5A0)
                mov     ax, [0x040E]
                mov     ds, ax
                mov     si, 0x3D
                cmp     byte [es:V_OURDL], 0x80
                je      .haveptr
                mov     si, 0x4D
.haveptr:
                mov     cl, [si+4]              ; shift count
                mov     ax, [si+0]              ; physical cylinders
                shr     ax, cl
                sub     ax, 2
                jbe     .xlat                   ; nonsense -> translate
                mov     [es:V_SCC], ax
                mov     al, [si+2]              ; physical heads
                xor     ah, ah
                shl     ax, cl
                and     ax, 0x00FF
                jnz     .haveheads
                mov     ax, 256
.haveheads:
                mov     [es:V_SCH], ax
                mov     al, [si+0x0E]           ; sectors per track
                xor     ah, ah
                test    ax, ax
                jz      .xlat
                mov     [es:V_SCS], ax

                movzx   eax, word [es:V_SCC]
                movzx   ebx, word [es:V_SCH]
                mul     ebx
                movzx   ebx, word [es:V_SCS]
                mul     ebx                     ; eax = stock CHS reach
                cmp     eax, [es:V_TOTSEC]
                jb      .xlat                   ; stock cannot reach it all

                ; ---- EDD-ONLY mode ----------------------------------------
                ; The stock geometry already covers the device. Do not touch
                ; AH=02/03/04/08/15 (that would invalidate existing partition
                ; CHS fields for no gain). Just add the EDD functions, and
                ; report the STOCK geometry through AH=48 so the two agree.
                mov     [es:V_CHSTOT], eax
                mov     ax, [es:V_SCC]
                mov     [es:V_C], ax
                mov     ax, [es:V_SCH]
                mov     [es:V_H], ax
                mov     ax, [es:V_SCS]
                mov     [es:V_S], ax
                mov     byte [es:V_FLAGS], FLG_PRESENT | FLG_LBA
                jmp     .tables
.xlat:
                mov     byte [es:V_FLAGS], FLG_PRESENT | FLG_LBA | FLG_XLAT
.tables:
                ; ---- FDPT (block was zeroed, only non-zero fields written) --
                ; +0 cylinders, +2 heads, +3..4 rwc/SHIFT (0 -> no bit-shift
                ; translation for anyone reading this table raw), +8 control
                ; byte bit3 "more than 8 heads", +0x0C landing zone, +0x0E spt.
                mov     ax, [es:V_C]
                mov     [es:V_FDPT+0x00], ax
                mov     [es:V_FDPT+0x0C], ax
                mov     al, [es:V_H]
                mov     [es:V_FDPT+0x02], al
                mov     byte [es:V_FDPT+0x08], 0x08
                mov     al, [es:V_S]
                mov     [es:V_FDPT+0x0E], al

                ; ---- DPTE (EDD 1.1) ---------------------------------------
                mov     word [es:V_DPTE+0x00], 0x01F0   ; I/O base
                mov     word [es:V_DPTE+0x02], 0x03F6   ; control port
                mov     byte [es:V_DPTE+0x04], 0xA0     ; head reg upper bits
                mov     byte [es:V_DPTE+0x06], 0x0E     ; IRQ 14
                mov     word [es:V_DPTE+0x0A], 0x0030   ; CHS + LBA translation
                mov     byte [es:V_DPTE+0x0E], 0x11     ; revision 1.1
                xor     ax, ax
                mov     cx, 15
                mov     si, V_DPTE
.sum:           add     al, [es:si]
                inc     si
                loop    .sum
                neg     al
                mov     [es:V_DPTE+0x0F], al    ; 16 bytes sum to 0 mod 256
                clc
                ret
.fail:
                stc
                ret

; ============================================================================
;  OURINT13 -- the outermost INT 13h handler
; ============================================================================
OURINT13:
                sti
                sub     sp, 4                   ; chain scratch (see CHAIN)
                push    bp
                push    ds
                push    es
                pusha
                mov     bp, sp

                cmp     dl, 0x80
                jb      CHAIN_FB                ; floppy: never ours

                call    FINDBLK                 ; -> ES = block
                jc      CHAIN_FB

                cmp     dl, [es:V_OURDL]        ; DL is already physical  [V1]
                jne     CHAIN
                test    byte [es:V_FLAGS], FLG_PRESENT
                jz      CHAIN

                mov     al, [bp+F_AX+1]         ; AH
                cmp     al, 0x41
                je      EDD41
                cmp     al, 0x42
                je      EDD42
                cmp     al, 0x43
                je      EDD43
                cmp     al, 0x48
                je      EDD48
                ; everything below is only ours in translate mode
                test    byte [es:V_FLAGS], FLG_XLAT
                jz      CHAIN
                cmp     al, 0x02
                je      RW
                cmp     al, 0x03
                je      RW
                cmp     al, 0x04
                je      RW
                cmp     al, 0x08
                je      GETPARM
                cmp     al, 0x15
                je      GETTYPE
                ; AH=00 reset and AH=01 last-status stay with the stock code:
                ; we keep 0040:0041 / 0040:0074 in sync on every call we own,
                ; so the stock AH=01 answer is still correct.
                jmp     CHAIN

; ---------------------------------------------------------------- FINDBLK
; -> ES = RAM block, CF=0.  CF=1 if the block cannot be located.
; Bounded downward scan in 1 KiB steps in case a later option ROM shrinks
; base memory under us.  Clobbers AX, CX, DS, ES.
FINDBLK:
                xor     ax, ax
                mov     ds, ax
                mov     ax, [0x040E]
                test    ax, ax
                jz      .no
                sub     ax, 0x40
                mov     cx, 8
.loop:          mov     es, ax
                cmp     dword [es:V_SIG], SIG
                je      .yes
                sub     ax, 0x40
                loop    .loop
.no:            stc
                ret
.yes:           clc
                ret

; ------------------------------------------------------------------ CHAIN
; True tail transfer: every register and every flag exactly as at entry.
; The saved vector lives in RAM so `jmp far [cs:..]` is impossible; we use the
; frame-rewrite + RETF idiom the stock shim at F000:BB59 uses.
; The 4-byte scratch we reserved with `sub sp,4` is what RETF consumes, so the
; caller's IP/CS/FLAGS frame reaches the downstream handler untouched.
CHAIN:                                          ; ES = block
                mov     ax, [es:V_OLD13]
                mov     [bp+F_SC], ax
                mov     ax, [es:V_OLD13+2]
                mov     [bp+F_SC+2], ax
                jmp     short CHAIN_GO
CHAIN_FB:                                       ; block unavailable / floppy
                ; A floppy call has ES=block only after FINDBLK; for the fast
                ; floppy path we have not located the block yet, so read the
                ; vector if we can, else fall back to the boot-block handler
                ; at F000:D2D7, which is in the never-erased boot block and is
                ; a complete INT 13h implementation (it forwards floppies to
                ; INT 40h exactly like the stock chain).
                push    es
                push    ds
                call    FINDBLK
                jc      .hard
                mov     ax, [es:V_OLD13]
                mov     dx, [es:V_OLD13+2]
                pop     ds
                pop     es
                mov     [bp+F_SC], ax
                mov     [bp+F_SC+2], dx
                jmp     short CHAIN_GO
.hard:
                pop     ds
                pop     es
                mov     word [bp+F_SC], FALLBACK13_OFF
                mov     word [bp+F_SC+2], FALLBACK13_SEG
CHAIN_GO:
                popa
                pop     es
                pop     ds
                pop     bp
                retf                            ; consumes the scratch only

; ------------------------------------------------------- returns we own
; `retf 2` is mandatory: IRET would reload FLAGS from the stack and destroy the
; CF we just computed. Every stock handler here does the same (`CA 02 00` at
; F000:D2DE, D331, BB56, 9562).
SETBDA:                                         ; AL = status byte
                push    ds
                push    bx
                xor     bx, bx
                mov     ds, bx
                mov     [0x0441], al
                mov     [0x0474], al
                pop     bx
                pop     ds
                ret

RETOK:                                          ; force AH=0, CF=0
                mov     byte [bp+F_AX+1], 0
RETOKX:                                         ; keep frame AH as-is, CF=0
                xor     al, al
                call    SETBDA
                popa
                pop     es
                pop     ds
                pop     bp
                add     sp, 4
                clc
                retf    2

RETERR:                                         ; AL = INT 13h status, CF=1
                mov     [bp+F_AX+1], al
                call    SETBDA
                popa
                pop     es
                pop     ds
                pop     bp
                add     sp, 4
                stc
                retf    2

ERR_PARM:       mov     al, 0x01
                jmp     RETERR
ERR_RANGE:      mov     al, 0x04
                jmp     RETERR
ERR_BOUND:      mov     al, 0x09
                jmp     RETERR

; ============================================================================
;  AH=02 read / AH=03 write / AH=04 verify  (translate mode only)
; ============================================================================
RW:
                mov     cx, [bp+F_CX]
                mov     bl, cl
                and     bl, 0x3F                ; sector, 1-based
                jz      ERR_PARM
                mov     al, ch
                mov     ah, cl
                shr     ah, 6
                cmp     ax, [es:V_C]            ; AX = cylinder
                jae     ERR_RANGE
                mov     dl, [bp+F_DX+1]         ; head
                xor     dh, dh
                cmp     dx, [es:V_H]
                jae     ERR_RANGE
                mov     [es:V_TMP], dx

                movzx   eax, ax
                movzx   ecx, word [es:V_H]
                mul     ecx                     ; cyl * H
                movzx   ecx, word [es:V_TMP]
                add     eax, ecx                ; + head
                movzx   ecx, word [es:V_S]
                mul     ecx                     ; * S
                movzx   ecx, bl
                dec     ecx
                add     eax, ecx                ; + sector-1  => LBA
                mov     [es:V_LBA], eax

                mov     al, [bp+F_AX]           ; sector count
                xor     ah, ah
                test    ax, ax
                jz      RETOK                   ; 0 sectors: no-op success
                cmp     ax, 128
                ja      ERR_PARM
                mov     [es:V_CNT], ax

                movzx   ecx, ax
                mov     eax, [es:V_LBA]
                add     eax, ecx
                jc      ERR_RANGE
                cmp     eax, [es:V_TOTSEC]
                ja      ERR_RANGE

                cmp     byte [bp+F_AX+1], 0x04  ; AH=04 verify: range check only
                jne     .doio
                mov     al, [es:V_CNT]
                mov     [bp+F_AX], al
                jmp     RETOK
.doio:
                mov     ax, [bp+F_BX]
                mov     [es:V_BUFOFF], ax
                mov     ax, [bp+F_ES]
                mov     [es:V_BUFSEG], ax
                movzx   eax, word [es:V_BUFOFF]
                movzx   ecx, word [es:V_CNT]
                shl     ecx, 9
                add     eax, ecx
                cmp     eax, 0x10000            ; would `rep insw` wrap DI?
                ja      ERR_BOUND

                mov     al, 0x20                ; READ SECTOR(S)
                cmp     byte [bp+F_AX+1], 0x02
                je      .cmd
                mov     al, 0x30                ; WRITE SECTOR(S)
.cmd:           mov     [es:V_CMD], al
                call    ATA_RW
                push    ax
                mov     al, [es:V_DONE]
                mov     [bp+F_AX], al           ; AL = sectors actually done
                pop     ax
                test    al, al
                jz      RETOK
                jmp     RETERR

; ============================================================================
;  AH=08 get drive parameters (translate mode only)
; ============================================================================
GETPARM:
                mov     ax, [es:V_C]
                dec     ax                      ; max cylinder
                mov     ch, al
                mov     cl, ah
                shl     cl, 6
                or      cl, [es:V_S]
                mov     [bp+F_CX], cx
                mov     ax, [es:V_H]
                dec     ax
                mov     dh, al                  ; max head
                push    ds
                xor     bx, bx
                mov     ds, bx
                mov     dl, [0x0475]            ; number of hard drives
                pop     ds
                mov     [bp+F_DX], dx
                mov     word [bp+F_ES], 0       ; no DPT pointer from AH=08
                mov     word [bp+F_DI], 0
                mov     word [bp+F_AX], 0
                jmp     RETOK

; ============================================================================
;  AH=15 read DASD type (translate mode only)
; ============================================================================
GETTYPE:
                mov     eax, [es:V_CHSTOT]      ; CHS-addressable sectors, so
                mov     [bp+F_DX], ax           ; AH=15 agrees with AH=08
                shr     eax, 16
                mov     [bp+F_CX], ax
                mov     word [bp+F_AX], 0x0300  ; AH=03 fixed disk
                jmp     RETOKX

; ============================================================================
;  AH=41 EDD installation check
; ============================================================================
EDD41:
                cmp     word [bp+F_BX], 0x55AA
                jne     CHAIN                   ; not an EDD probe -> not ours
                mov     word [bp+F_BX], 0xAA55
                mov     word [bp+F_CX], 0x0005  ; b0 ext access, b2 EDD/DPTE
                                                ; b1 removable = 0 on purpose:
                                                ; we do not implement 45/46/49
                mov     word [bp+F_AX], 0x2100  ; AH=0x21 -> EDD 1.1 exactly
                mov     byte [bp+F_DX+1], 0
                jmp     RETOKX

; ============================================================================
;  AH=42 extended read / AH=43 extended write
; ============================================================================
EDD42:
                mov     byte [es:V_CMD], 0x20
                jmp     short EDDRW
EDD43:
                mov     al, [bp+F_AX]           ; AL bit0 = write-with-verify;
                test    al, 0xFE                ; accepted and ignored (no ATA
                jnz     ERR_PARM                ; write-verify on CF). Others bad.
                mov     byte [es:V_CMD], 0x30
EDDRW:
                mov     ds, [bp+F_DS]           ; caller's DS:SI -> DAP
                mov     si, [bp+F_SI]
                mov     al, [si]                ; packet size
                cmp     al, 0x10
                jb      ERR_PARM
                cmp     byte [si+1], 0
                jne     ERR_PARM
                mov     cx, [si+2]              ; block count
                test    cx, cx
                jz      RETOK                   ; nothing to do
                cmp     cx, 127
                ja      ERR_PARM
                cmp     al, 0x18
                jb      .noflat
                cmp     dword [si+4], 0xFFFFFFFF
                je      ERR_PARM                ; 64-bit flat buffer: refused,
                                                ; we advertise 1.1 real-mode only
.noflat:
                mov     [es:V_CNT], cx
                cmp     dword [si+0x0C], 0      ; LBA high dword must be 0
                jne     ERR_RANGE
                mov     eax, [si+8]
                mov     [es:V_LBA], eax
                movzx   ecx, cx
                add     eax, ecx
                jc      ERR_RANGE
                cmp     eax, [es:V_TOTSEC]
                ja      ERR_RANGE
                mov     ax, [si+4]
                mov     [es:V_BUFOFF], ax
                mov     ax, [si+6]
                mov     [es:V_BUFSEG], ax
                movzx   eax, word [es:V_BUFOFF]
                movzx   ecx, word [es:V_CNT]
                shl     ecx, 9
                add     eax, ecx
                cmp     eax, 0x10000
                ja      ERR_BOUND

                call    ATA_RW
                push    ax
                mov     ax, [es:V_DONE]
                mov     [si+2], ax              ; blocks actually transferred
                pop     ax
                test    al, al
                jz      RETOK
                jmp     RETERR

; ============================================================================
;  AH=48 extended get drive parameters
; ============================================================================
EDD48:
                mov     ds, [bp+F_DS]
                mov     si, [bp+F_SI]
                mov     ax, [si]                ; caller's buffer size
                cmp     ax, 0x1A
                jb      ERR_PARM
                mov     bx, 0x1A
                cmp     ax, 0x1E
                jb      .size
                mov     bx, 0x1E
.size:
                mov     [si], bx
                mov     word [si+0x02], 0x0002  ; bit1: CHS information valid
                movzx   eax, word [es:V_C]
                mov     [si+0x04], eax
                movzx   eax, word [es:V_H]
                mov     [si+0x08], eax
                movzx   eax, word [es:V_S]
                mov     [si+0x0C], eax
                mov     eax, [es:V_TOTSEC]      ; FULL LBA capacity, even though
                mov     [si+0x10], eax          ; the CHS fields above cover less
                xor     eax, eax
                mov     [si+0x14], eax
                mov     word [si+0x18], 512
                cmp     bx, 0x1E
                jb      .done
                mov     word [si+0x1A], V_DPTE  ; DPTE far pointer (off:seg)
                mov     [si+0x1C], es
.done:
                jmp     RETOK

; ============================================================================
;  ATA_RW -- LBA28 PIO transfer core.  ES = block.
;  In : V_LBA, V_CNT, V_BUFSEG:V_BUFOFF, V_CMD (0x20 read / 0x30 write)
;  Out: AL = INT 13h status (0 = success), V_DONE = sectors transferred.
;  V_BUFOFF is advanced as it goes; callers must not rely on it afterwards.
; ============================================================================
ATA_RW:
                mov     word [es:V_DONE], 0
                call    WAIT_NOT_BSY
                jc      .timeout

                ; The device/head register is written FIRST and allowed to
                ; settle, because its meaning changes (0xA0 CHS -> 0xE0 LBA).
                ; This is the one bit the stock BIOS never sets: F000:D430
                ; does `or al,0xA0`, i.e. CHS mode forever.
                mov     dx, 0x1F6
                mov     al, [es:V_LBA+3]
                and     al, 0x0F
                or      al, 0xE0                ; LBA mode, master
                ATAOUT
                call    WAIT_NOT_BSY
                jc      .timeout

                mov     dx, 0x1F1               ; features
                xor     al, al
                ATAOUT
                inc     dx                      ; 1F2 sector count
                mov     al, [es:V_CNT]
                ATAOUT
                inc     dx                      ; 1F3 LBA 7:0
                mov     al, [es:V_LBA+0]
                ATAOUT
                inc     dx                      ; 1F4 LBA 15:8
                mov     al, [es:V_LBA+1]
                ATAOUT
                inc     dx                      ; 1F5 LBA 23:16
                mov     al, [es:V_LBA+2]
                ATAOUT
                inc     dx                      ; 1F6 - skipped, already written
                inc     dx                      ; 1F7 command
                mov     al, [es:V_CMD]
                ATAOUT

.sector:
                call    WAIT_DRQ                ; per-sector handshake: slower
                jc      .aterr                  ; than the stock single-burst
                                                ; `rep insw` at F000:D745 but
                                                ; spec-correct
                mov     di, [es:V_BUFOFF]
                mov     si, di
                mov     bx, [es:V_BUFSEG]
                mov     dx, 0x1F0
                mov     cx, 256
                cld
                cmp     byte [es:V_CMD], 0x30
                je      .write
                push    es
                mov     es, bx
                rep     insw                    ; -> ES:DI
                pop     es
                jmp     short .advance
.write:
                push    ds
                mov     ds, bx
                rep     outsw                   ; <- DS:SI
                pop     ds
.advance:
                add     word [es:V_BUFOFF], 512
                inc     word [es:V_DONE]
                mov     dx, 0x3F6
                in      al, dx                  ; alternate status: 400 ns settle
                mov     ax, [es:V_DONE]
                cmp     ax, [es:V_CNT]
                jb      .sector

                call    WAIT_NOT_BSY
                jc      .timeout
                mov     dx, 0x1F7
                in      al, dx
                test    al, 0x21                ; ERR | DF
                jnz     .aterr

                cmp     byte [es:V_CMD], 0x30
                jne     .ok
                mov     dx, 0x1F7               ; FLUSH CACHE; many CF cards
                mov     al, 0xE7                ; abort it - that is not an
                ATAOUT                          ; error, so ignore the result
                call    WAIT_NOT_BSY
.ok:
                call    .restorectl
                xor     al, al
                ret
.timeout:
                call    .restorectl
                mov     al, 0x80                ; timeout, drive not ready
                ret
.aterr:
                mov     dx, 0x1F1               ; error register
                in      al, dx
                mov     [es:V_ATAERR], al
                call    .restorectl
                mov     ah, al
                mov     al, 0x20                ; default: controller failure
                test    ah, 0x10                ; IDNF
                jz      .e1
                mov     al, 0x04
                ret
.e1:            test    ah, 0x40                ; UNC
                jz      .e2
                mov     al, 0x0A
                ret
.e2:            test    ah, 0x80                ; BBK
                jz      .e3
                mov     al, 0x0A
                ret
.e3:            ret

; Restore 0x3F6 the way the stock code does at F000:D481-D488, so a chained
; stock-path call afterwards finds the control register as it expects.
.restorectl:
                push    ax
                push    ds
                push    dx
                xor     ax, ax
                mov     ds, ax
                mov     al, [0x0476]
                and     al, 0x0F
                or      al, 0x08
                mov     dx, 0x3F6
                ATAOUT
                pop     dx
                pop     ds
                pop     ax
                ret

; ============================================================================
;  Build stamp -- lets a diagnostic tool confirm which payload is resident.
;  Keep it immediately after the code so the whole used region is contiguous
;  and contains no 0xCC run the APM allocator could claim.            [V3]
; ============================================================================
STAMP:          db      'PC110-LBA13 v1.0 2026-08-02', 0

PAYLOAD_END:
%if (PAYLOAD_END - INIT) > 7808
  %error "payload does not fit in the 7808-byte hole at F000:0080"
%endif
