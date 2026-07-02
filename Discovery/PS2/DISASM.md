# PS2.EXE disassembly — the hardware interface, decoded

*This decodes **how `PS2.EXE` actually talks to the machine**, from a disassembly of the binary
(`ndisasm -b 16`) plus live probing of the same BIOS calls over [COMrade](../Live-Dump/). It is the
basis for re-implementing PS2's functions natively — see [`Software/PS2TUI`](../../Software/PS2TUI/),
which now performs the read paths itself with no `PS2.EXE` dependency.*

Raw excerpts: [`ps2_keycode.dis`](ps2_keycode.dis). Full string dump: [`ps2_strings.txt`](ps2_strings.txt).

## Binary layout
- 16-bit real-mode MS-DOS `MZ`, 40,860 bytes, **0 relocations**, header 0x200 bytes, entry
  `CS:IP = 09C4:0010`. Microsoft C runtime; IBM © 1991,1995.

## The three hardware channels

### 1. Standard APM (INT 15h, AH=53h) — ✅ fully decoded & re-implemented
`PS2.EXE` is an APM client. Two standard calls are used, and both are now re-implemented natively
in PS2TUI's "power" screen:

| Call | In | Out (verified live) |
|---|---|---|
| **Install check** `AX=5300` | `BX=0` | `AH:AL`=APM ver (`01:00` → 1.0), `BX="PM"` (0x504D), `CX`=flags (0x0003 = 16+32-bit) |
| **Get power status** `AX=530A` | `BX=1` | `BH`=AC (0=off,1=on,2=backup), `BL`=battery (0=high,1=low,2=crit,3=charging), `CL`=charge %, `DX`=time. Live: `BH=1, BL=0, CL=0x64` → **On-line, High, 100%** |

### 2. IBM PC110 vendor APM extension (INT 15h, AX=5380) — 🟡 convention decoded
Every PS2 *setting* goes through a private System-Management service. The call shape (from the
disassembly) is:

```asm
mov ax, 0x5380        ; AH=53h (APM), AL=80h (IBM vendor extension)
mov bh, <function>    ; function group
mov bl, <sub>         ; sub-function; the LOW BIT selects get(0) / set(1)
mov cx, <value>       ; value for 'set', or returned value for 'get'
int 0x15
jc  error
cmp bh, 0x53          ; success signature: BH must return 0x53 ('S')
jnz error
cmp bl, 0x4C          ;                    BL must return 0x4C ('L')  -> "SL"
jnz error
```

**Function codes observed at the 38 vendor call sites** (`BX` value = `BH:BL`; even BL = read,
odd BL = write; `CX` carries the value):

| BX (func:sub) | Pairing | Used for (from surrounding code / command strings) |
|---|---|---|
| `80xx` | get/set | device enable/route (serial / IR / modem group) |
| `81xx` | get/set | " |
| `8300 / 8301` | get / set | display path (SCreen / VEXP) |
| `8302`, `83FE` | — | display sub-state / query |
| `8600 / 8601` | get / set | audio (IRQ/DMA) group; `CX` carries IRQ/DMA |
| `8700` | — | power / speed group |
| `8800 / 8801` | get / set | inking (digitizer) group |
| `8A00 / 8A01` | get / set | keyboard / misc, selected by `CH` (1,3,4,7,8…) |

> These are transcribed from the call sites (see `ps2_keycode.dis`). Mapping each *menu command*
> to its exact `(BX,CX)` and value encoding requires tracing each command handler; that decoding
> is the remaining work before the **setters** can be re-implemented natively and safely. Until
> then PS2TUI applies settings by invoking the real `PS2.EXE` (which uses exactly these calls).

### 3. Firmware-revision reader — 🟡 decoded
`_@REVision` fills a struct via vendor functions `BH=06h` (capability gate: `test bl,2`), `BH=08h`
and `BH=0Ah` (return version bytes in `CH/CX/SI/DI`), formatted `0.NN`. All the PC110 firmwares
share **major version 0**, so each is a single minor byte. Result (live):

```
BIOS 0.33  APM 0.27  VGA 0.15  SETUP/DIAG 0.27  KBFIRM 0.21  PSMC 0.38  PS2 0.22
```

### 4. Direct port I/O — ✅ decoded
For the lowest-level items PS2 pokes the chipset directly (matching [Live-Dump §5](../Live-Dump/)):
- `_@CMOS` → `out 0x70`/`in 0x71`/`out 0x71` (RTC/CMOS)
- SCAMP VL82C420 → `out 0x74` (index) / `in`,`out 0x76` (data)
- power MCU → `out 0xEC` (index) / `in`,`out 0xED` (data)

## What PS2TUI ingests today
- ✅ **Native**: APM install + power status (screen "B") — no `PS2.EXE` call.
- 🟡 **Documented, still delegated**: the vendor `5380` setters and the revision reader (PS2TUI
  runs `PS2.EXE` for these). The convention above is what a full native port would use.
