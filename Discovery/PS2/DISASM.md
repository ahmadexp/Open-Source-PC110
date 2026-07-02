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

See `ps2_keycode.dis` and `ps2_handlers.dis` for the raw disassembly.

#### 2a. The bitfield helper architecture 🟡→✅
Most vendor registers are **packed bitfields**, and PS2 accesses them through a small set of
generic get-modify-write helpers. The setting handlers just call a helper with
`AL`=value and `CX`=`(CH=mask, CL=shift)`:

```asm
; generic SET helper (function 83), @0x4F97 :  reg83[mask] = (value << shift)
set83:  xchg ah,ch          ; AH := mask (from CH)
        shl  al,cl          ; AL := value << shift
        and  al,ah          ; AL := (value<<shift) & mask
        not  ah             ; AH := ~mask
        push ax
        mov  ax,0x5380 / mov bx,0x8300 / int 0x15   ; GET  -> CL = current reg
        pop  ax
        and  cl,ah          ; clear the field
        or   cl,al          ; insert the new value
        mov  ax,0x5380 / mov bx,0x8301 / int 0x15   ; SET
        ret
```

There are parallel helpers hardcoded to other functions: **`0x4F84`** = matching GET (returns
`AL` = extracted field), **`0x4FB6`/`0x4FC9`** = GET/SET for function **88** (inking). The
per-setting handlers add value remapping on top, e.g.:

| Handler | Op | Meaning |
|---|---|---|
| `0x4FE8` | SET `8A01` `CH=1`, `CL`=value | raw byte write |
| `0x500F` | GET `8A00 CH=3`, remap 2-bit field, SET `8A01 CH=4` | multi-state (mask `0x03`) |
| `0x5074` | GET `8A00 CH=7`, SET `8A01 CH=8` (val 0→bits `7`, else→`2`) | two-state (mask `0x07`) |
| `0x50AE` | GET `8600 CH=1`, `(CL & 0xFC)\|value`, SET `8601 CH=1` | audio 2-bit field |
| `0x4FFA` | **INT 16h AX=0305** (`BX=0x0104`/`0`) | keyboard typematic — *not* APM |

So the full recipe to set any option natively is: *GET function `BH:00`, clear its bitfield with
the mask, OR in `(value<<shift)`, SET function `BH:01`* — and you can immediately GET again to
**verify** (read-back), which is how a safe native port confirms each write.

#### 2b. Live register values (read natively, read-only) ✅
Calling the GET functions on the running unit (via the same `AX=5380` path PS2TUI now uses)
returns `CL` = the field byte. Snapshot 2026-07-02:

```
8A00 CH=3/4: 0x50    8A00 CH=5/6: 0x21    8A00 CH=7/8: 0x02
8600 CH=1:   0x00    8800: 0x00           8300: 0x00
```

These are the live config-register contents behind the menu settings.

#### 2c. Command→handler dispatch
`PS2.EXE` matches `argv[1]` against a keyword table (parallel string-pointer arrays at file
`~0x9B1E`, pointing at the command words `PMode`, `POwer`, … at `~0x5F1E`) using capital-letter
abbreviation matching, then dispatches to the handlers above. Completing the exact
keyword→handler index map (a switch, not a pointer table) is the last step before **every** setter
can be re-implemented natively; the read path and the helper mechanics are already decoded.

> **Status:** the mechanism is fully decoded and PS2TUI performs the **read** path natively
> ([§ power screen](../../Software/PS2TUI/)). Native **setters** follow the recipe in §2a with
> read-back verification; until each is individually verified on hardware, PS2TUI applies settings
> via the real `PS2.EXE` (which issues exactly these calls). This is deliberate — a mis-transcribed
> bitfield write to a power/serial register on a remote-only unit could sever access.

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

### 5. Where settings persist: **extended CMOS** ✅ (major finding)
Many PS2 settings are stored in the RTC/CMOS **extended bank (0x40–0x7F)**, readable via the
standard `0x70/0x71` port pair — so their current value can be read **natively with no APM call
and no risk** (reading CMOS is side-effect-free). Confirmed empirically by toggling each setting
with the real `PS2.EXE` and diffing all 128 CMOS bytes:

| Setting | CMOS location | Encoding (verified live) |
|---|---|---|
| `CLick` | `0x44` bit `0x10` | set = ON, clear = OFF |
| `_@STATus` | `0x70` low nibble | `0`=Auto, `4`=Time, else=Battery |
| `PMode` | `0x72` bit `0x20` | set = High |
| `VEXPansion` | `0x72` bit `0x04` (+ `0x78` bit `0x08`) | set = ON |
| — checksum — | `0x40` / `0x41` | 16-bit checksum PS2 rewrites on every change |

Not every setting lives here: `SPeed`, `Cover`, `RI`, `IRQAudio`, `DMAAUdio`, `_@BATTery` showed
**no** change in the 0x00–0x7F CMOS bank — they are applied as **runtime APM state** (the vendor
`5380` calls) without a simple host-readable CMOS mirror.

Live-validated 2026-07-02: toggling `IRQAudio`/`DMAAUdio`/`ADDAUdio` also produces **no** change in
the readable vendor function-`86` (audio) `5380` GET registers (`ch=1`, `ch=0x0A`) — confirming the
audio group is written straight to the ESS488 with no host-readable read-back. So these settings
(and the two commands the docs call "unknown" — `_@IRQClear`, `_@FNkey`) cannot be verified by
read-back, and the ones that touch the serial UART / IRQs / Fn keys are **not safe to blind-test
over the COMrade serial link** (they could mask COM1's IRQ or suspend the unit). `ADDAUdio 0220`
executes cleanly (audio I/O base) and is the audio counterpart of `ADDINKing`.

**Native reads vs. writes.** PS2TUI now **reads** these CMOS bytes directly for its live
"current settings" screen (key `C`) — verified: setting `_@STATUS BATTERY` with `PS2.EXE` then
reading via PS2TUI shows *Battery*. Native **writes** are *not* done yet: a raw CMOS write would
also have to recompute the `0x40/0x41` checksum (algorithm not yet cracked) **and** issue the APM
`5380` "set" so the change takes effect before reboot. Until both are solved, PS2TUI applies
changes via the real `PS2.EXE` (which does all three correctly).

## What PS2TUI ingests today
- ✅ **Native**: APM install + power status (screen `B`); live current-settings read from CMOS
  (screen `C`) — no `PS2.EXE` call.
- 🟡 **Documented, still delegated**: the vendor `5380` setters and the revision reader (PS2TUI
  runs `PS2.EXE` for these). Native writes are blocked only on the `0x40/0x41` checksum algorithm
  plus the paired APM "set"; the read/decode side is done.
