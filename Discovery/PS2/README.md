# PS2.EXE — the PC110 system-management tool, reverse-engineered

*`PS2.EXE` is IBM's command-line configuration utility for the PalmTop PC110 — the DOS front-end
to the machine's power management, device I/O assignment, display, keyboard and low-level chipset
settings. It is present on this unit at both `C:\PS2.EXE` and `D:\PS2.EXE` (40,860 bytes,
sha256 `6b6a9dfd…`). This chapter documents **how it works** and shows that its command set maps
almost one-to-one onto the silicon reverse-engineered elsewhere in `Discovery/`.*

> Provenance: static analysis of the binary + live runs on the physical unit over
> [COMrade](../Live-Dump/) (2026-07-02). Confidence: ✅ verified from the binary/live runs,
> 🟡 inferred.

---

## 1. What it is

- **Toolchain:** Microsoft C (`MS Run-Time Library - Copyright (c) 1990, Microsoft Corp`),
  16-bit real-mode MS-DOS `MZ` executable, unpacked. ✅
- **Copyright:** `(C) Copyright IBM Corp. 1991,1995. All rights reserved.` ✅
- **Version (this ROM):** PS2 Revision **0.22** (see the live manifest below).

Running `PS2 ?` prints the basic syntax; `PS2 _@???` prints the "hidden" advanced syntax. A full,
annotated command reference is in [§5](#5-command-reference).

## 2. How it talks to the hardware ✅

Disassembly shows PS2.EXE reaches the hardware two ways:

### 2.1 APM BIOS (INT 15h, AH=53h) — the main path
45 `INT 15h` call sites. The immediate `AX` values loaded before them are:

| AX | Count | Meaning |
|---|---|---|
| `530A` | 1 | **APM "Get Power Status"** (standard APM 1.x function 0Ah) |
| `5380` | 38 | **IBM PC110 vendor APM extension** (AH=53h, AL=80h) — the private "system management" service that carries almost every PS2 setting in the other registers |

So PS2.EXE is essentially a thin wrapper over the PC110's **APM / System-Management BIOS**. This is
consistent with the earlier `FPROBE.OUT` on the unit (an `INT 15h AX=5000` APM probe) and with the
live IVT showing an APM-capable BIOS. The **APM Revision 0.27** is reported by `_@REVision`.

### 2.2 Direct port I/O — the low-level path
For the settings that have no APM service, PS2.EXE pokes the chipset directly — **the exact ports
mapped in [`Discovery/Live-Dump`](../Live-Dump/) and [`Discovery/Chipset`](../Chipset/):**

| Ports | Device | PS2 use |
|---|---|---|
| `0x70 / 0x71` | RTC / **CMOS** | `_@CMOS [OR\|AND\|XOR] XX=YY` reads/writes CMOS directly |
| `0x74 / 0x76` | **VL82C420 "SCAMP"** config index/data | low-level chipset settings |
| `0xEC / 0xED` | **power MCU (PSMC / U6)** index/data | battery / power settings |

This is the strongest possible confirmation of the discovery work: the official IBM tool drives
the *same* register pairs this project reverse-engineered from the outside.

## 3. Live firmware manifest ✅

`PS2 _@REVision`, run on the physical unit (full capture in
[`ps2_revision_live.txt`](ps2_revision_live.txt)):

```
ROM Parts Number:     39H4551
ROM Release Date:     11/08/95
BIOS Revision:        0.33  11/08/95
APM Revision:         0.27  11/08/95
VGA Revision:         0.15  09/07/95      <- Chips&Tech F65535 video BIOS
SETUP/DIAG Revision:  0.27  09/19/95      <- the "Easy-Setup" program
KBFIRM Revision:      0.21                <- keyboard MCU (U67) firmware
PSMC Revision:        0.38                <- Power-System-Management Controller (U6) firmware
PS2 Revision:         0.22                <- this tool
```

This single command is a complete firmware version dump of the machine. Notably it explains the
**two dates** seen in the ROM image: the BIOS is **11/08/95** while the embedded **SETUP/DIAG
(Easy-Setup) is 09/19/95** — both are packed into the one 256 KB ROM. It also exposes the
otherwise-invisible **keyboard-MCU (KBFIRM 0.21)** and **power-MCU (PSMC 0.38)** firmware
revisions, tying back to [`Components/U67`](../../Components/U67-M38813E4HP/) and
[`Components/U6`](../../Components/U6-M38224M6HP/).

## 4. Command → subsystem cross-reference

How each PS2 setting lines up with the reverse-engineered hardware:

| PS2 command | Subsystem | Where in this repo |
|---|---|---|
| `SPeed Fast\|Medium\|Slow` (33/15/6 MHz) | CPU clock throttle in the SCAMP power manager | [Chipset](../Chipset/) — confirms the 33 MHz max of the 486SX |
| `PMode`, `POwer`, `LCd`, `Cover`, `RI`, `OFF`, `_@OFF` | APM power states / suspend / wake | APM BIOS (INT 15h/53h) |
| `ON AT …` | RTC wake **alarm** | CMOS alarm regs `0x01/0x03/0x05` (see [Live-Dump §10](../Live-Dump/)) |
| `IRQAudio`, `DMAAUdio` | **ESS ES488** SoundBlaster | [ES488](../ES488/) |
| `IRQINKing`, `ADDINKing 15E0\|25E0\|35E0` | **digitizer / inking tablet** | explains the live `0x15E8`/`0x35EA` port reads — those windows are the **inking** ports (`RMUDOSAT /PX=15E0-15EF,35E0-35EF` *excludes* them) |
| `IR`, `SErial`, `IMODEM`, `PMODEM` | COM-port routing (IrDA / RS-232 / int. modem / PCMCIA modem) | [Pluto](../Pluto/), [Modem](../Modem/) |
| `SCreen LCD\|CRT`, `VEXPansion` | **C&T F65535** display path | [65535](../65535/) |
| `CLick`, `_@Keyboard …` | **keyboard MCU (U67)** | [Components/U67](../../Components/U67-M38813E4HP/) |
| `_@LPT BI\|UNI\|ECP\|EPP` | parallel port mode | LPT at `0x3BC` (Live-Dump §4) |
| `_@ATA Primary\|Secondary` | IDE/ATA controller order | the internal CF / PCMCIA-ATA |
| `_@PCIC`, `_@PCCD3v` | **PCMCIA controller** | the 82365SL-class PCIC at `0x3E0/0x3E1` (Live-Dump §5.2) |
| `_@BATTery`, `_@STATus` | **power MCU (PSMC/U6)** | [PSU-MB-M38](../PSU-MB-M38/); ports `0xEC/0xED` |
| `_@CMOS …` | direct **CMOS** poke | ports `0x70/0x71` |
| `_@FNkey`, `_@Keyboard Device` | keyboard MCU Fn/dual-keyboard | [Components/U67](../../Components/U67-M38813E4HP/) |
| `_@Token ring`, `_@COMB` | PCMCIA token-ring RIPL / COMB device muxing | — |

## 5. Command reference

### Basic (`PS2 ?`)
| Command | Args | Description |
|---|---|---|
| `PMode` | `High\|Medium\|Low` | Power-saving mode on battery |
| `POwer` | `0-99` | Idle minutes → auto-suspend |
| `LCd` | `0-17` | Idle minutes → screen off |
| `SPeed` | `Fast\|Medium\|Slow` | CPU at 33 / 15 / 6 MHz |
| `Cover` | `Enable\|Disable` | Suspend when the cover closes |
| `ON AT` | `yyyy-MM-DD HH:mm:ss` / `HH:mm:ss` / `Clear` | Auto-resume alarm |
| `RI` | `Enable\|Disable` | Wake on modem ring |
| `SCreen` | `LCD\|CRT` | Internal panel or external monitor |
| `VEXPansion` | `ON\|OFF` | Stretch display to fill the panel |
| `IRQAudio` | `5\|10\|Disable` | SoundBlaster IRQ |
| `DMAAUdio` | `1\|3` | SoundBlaster DMA |
| `IRQINKing` | `5\|10\|Disable` | Digitizer IRQ |
| `ADDINKing` | `15E0\|25E0\|35E0` | Digitizer I/O address |
| `IR` / `SErial` / `IMODEM` / `PMODEM` | `1\|2\|Disable` | COM routing for IrDA / serial / int. modem / PCMCIA modem |
| `CLick` | `ON\|OFF` | Keyboard click sound |
| `DEFAULT` | — | Reset basic settings |
| `OFF` | — | Suspend now |

### Advanced (`PS2 _@???`)
| Command | Args | Description |
|---|---|---|
| `_@Keyboard Speed` | `Med\|Fast` | Typematic rate |
| `_@Keyboard Response` | `Normal\|Long` | Typematic delay |
| `_@Keyboard Device` | `Auto\|Both` | Internal only vs. internal+external |
| `_@BATTery` | `Standard\|Other` | Charge profile (IBM vs. 3rd-party pack) |
| `_@STATus` | `Auto\|Time\|Battery` | LCD status-panel content |
| `_@LPT` | `BI\|UNI\|ECP\|EPP` | Parallel-port mode |
| `_@ATA` | `Primary\|Secondary` | IDE controller order |
| `_@PCIC` | `Enable\|Disable` | PCMCIA controller |
| `_@PCCD3v` | `Enable\|Disable` | 3 V PCMCIA card support |
| `_@FDDPM` | `Enable\|Disable` | Floppy power management |
| `_@Token ring` | `4Mbps\|16Mbps` | RIPL token-ring speed |
| `_@COMB` | `RS232\|IRda\|MIDI\|ASK` | COMB device selection |
| `_@IRQClear` | `Enable\|Disable` | (IRQ handling) |
| `_@FNkey` | `NO[=YYH]` | Inject an Fn key-combo code |
| `_@CMOS` | `[OR\|AND\|XOR] XXH[=YYH]` | **Direct CMOS write** — dangerous |
| `_@DEFAULT` | — | Reset **all** advanced settings |
| `_@OFF` | — | Power **off** (vs. `OFF` = suspend) |

> ⚠️ `_@CMOS`, `_@DEFAULT`, `OFF`/`_@OFF`, and reassigning `SErial`/`IR`/modem ports can lock you
> out of a remote session or change boot behaviour. Handle with care.

## 6. A friendlier front-end

Because memorising ~50 cryptic switches is unpleasant, this repo also ships **[PS2TUI](../../Software/PS2TUI/)**
— a full-screen text-UI menu that presents every one of these settings and applies changes by
invoking the real `PS2.EXE` (so all the actual APM/chipset work is still done by IBM's tool).

## 7. Disassembly

For the decoded hardware interface — the standard-APM calls (`5300`/`530A`), the IBM vendor
extension (`AX=5380`, `BH`=function, get/set via BL low bit, success signature `BH=53h/BL=4Ch`),
the firmware-revision reader, and the direct CMOS/SCAMP/MCU port routines — see
**[`DISASM.md`](DISASM.md)**. [`Software/PS2TUI`](../../Software/PS2TUI/) re-implements the APM read
path from this natively.

## 8. Files here
| File | Contents |
|---|---|
| `DISASM.md` | The decoded hardware interface (APM + vendor + ports) |
| `ps2_keycode.dis` | Disassembly excerpts of the key call sites |
| `ps2_revision_live.txt` | `PS2 _@REVision` captured from the live unit |
| `ps2_strings.txt` | Full printable-string dump of `PS2.EXE` |
