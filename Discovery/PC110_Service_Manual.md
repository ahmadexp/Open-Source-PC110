# IBM PalmTop PC110 — Comprehensive Service & Technical Reference Manual

*An unofficial service manual reconstructed from the [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110) reverse-engineering project: KiCad schematic recreations of the mainboard, PSU, RAM module, modem and docking station, plus firmware disassemblies of the power-sense and keyboard microcontrollers and several mask/flash ROM dumps.*

**Document revision:** 1.0 · **Compiled:** June 2026
**Subject machine:** IBM PalmTop PC110 (type 2431), Japanese-market 486-class subnotebook, 1995, co-developed by IBM Japan and Ricoh / RIOS Systems.

---

> ### ⚠️ Read this first — what this manual is, and is not
>
> This is **not** an official IBM service manual. IBM never published full board-level schematics or chip
> datasheets for the PC110's custom silicon. Everything here was **reverse-engineered** from physical
> boards, optical/X-ray scans, schematic recreations, and ROM disassembly. It is offered as the best
> surviving technical reference for repairing and understanding the machine — but it has gaps and
> assumptions, all flagged with the confidence key below.
>
> Work on these boards at your own risk. The PC110 runs from Li-ion and adapter sources; observe ESD
> precautions, and never assume a board is "off" (see §4 — it never fully is while powered).

### Confidence key

Used throughout this manual to mark how certain each claim is:

- ✅ **Verified** — read directly from firmware, a ROM dump, or a fully traced schematic net.
- 🟡 **Strongly inferred** — consistent with the evidence and standard practice, but not independently confirmed.
- ⚠️ **Assumption** — plausible but unverified; **confirm on the bench** against a known-good unit before relying on it.

---

## Table of contents

1. [Machine overview](#1-machine-overview)
2. [System architecture](#2-system-architecture)
3. [Chip roster / bill of materials](#3-chip-roster--bill-of-materials)
4. [Power subsystem — the U6 power-sense MCU](#4-power-subsystem--the-u6-power-sense-mcu)
5. [The J5 / J3 inter-board connector](#5-the-j5--j3-inter-board-connector)
6. [The PSU analog front-end (battery sensing)](#6-the-psu-analog-front-end-battery-sensing)
7. [Power-on sequence, step by step](#7-power-on-sequence-step-by-step)
8. [Bowman (U21) — system controller ASIC](#8-bowman-u21--system-controller-asic)
9. [Pluto (U35) — I/O gate array](#9-pluto-u35--io-gate-array)
10. [Audio subsystem — ES488 / OPL2](#10-audio-subsystem--es488--opl2)
11. [Memory, ROMs & expansion](#11-memory-roms--expansion)
12. [Modem, docking station & keyboard controller](#12-modem-docking-station--keyboard-controller)
13. [CPU debug headers & JTAG](#13-cpu-debug-headers--jtag)
14. [Troubleshooting guide](#14-troubleshooting-guide)
15. [Quick test-point reference](#15-quick-test-point-reference)
16. [Firmware anchors](#16-firmware-anchors-for-deep-debug)
17. [Glossary](#17-glossary)
18. [Sources & credits](#18-sources--credits)

---

## 1. Machine overview

The IBM PalmTop PC110 (type 2431, "PC110") is a 1995 clamshell subnotebook roughly the size of a VHS
cassette, sold primarily in Japan. It was co-developed by **IBM Japan** and **Ricoh**, with much of the
custom silicon and firmware engineered by the Japanese design house **RIOS Systems Co., Ltd.** — whose
name survives both as firmware copyright banners and as one of the internal chip code-names.

Rather than an off-the-shelf chipset, the PC110 is built around a small set of **custom RIOS gate-array
ASICs** (code-named *Bowman*, *Pluto*, *Rios*) surrounding a BGA-packaged 486SX-class CPU. Two
8-bit Mitsubishi 740-family microcontrollers handle the keyboard and the power/battery management. Audio
is an ESS AudioDrive plus a discrete Yamaha OPL2. Because almost none of these parts were ever publicly
documented, this manual exists.

| Attribute | Value |
|---|---|
| Model | IBM PalmTop PC110, type 2431 |
| Year | 1995 |
| Developers | IBM Japan + Ricoh; custom silicon & firmware by RIOS Systems Co., Ltd. |
| CPU | 80486SX-class, ~33 MHz, BGA-256 (U76), RIOS-marked |
| Graphics | Chips & Technologies 65535 (a.k.a. F65535) VGA/LCD controller (U51) |
| System chipset | VLSI VL82C420 (U61) + custom RIOS ASICs *Bowman* (U21) and *Pluto* (U35) |
| Audio | ESS **ES488F** AudioDrive (U4) + Yamaha **YM3812** (OPL2) / **YM3014B** DAC |
| Super-I/O | SMC **FDC37C665IR** (U22) |
| Keyboard/EC MCU | Mitsubishi **M38813** (3813 group, 740 core) — KBC firmware by RIOS |
| Power-sense MCU | Mitsubishi **M38223E4HP** (3822 group, 740 core) — "POWER SENSE MICON" firmware by RIOS |
| Memory | On-board DRAM (M5M4V16160BTP) + optional 16 MB expansion module |
| Storage | CompactFlash + PCMCIA; floppy via docking station |
| Display font | IBM DOS/V font ROM (OKI MSM538032E, P/N 84G7940) for software kanji rendering |
| BIOS | Flash (28F002) |

---

## 2. System architecture

The CPU talks **only** to the *Bowman* system-controller ASIC on its fast 486 local bus. Bowman
translates those cycles into a 16-bit ISA-style system bus, aggregates interrupts and DMA, decodes the
ROM, and links to the keyboard/PM MCU. The companion *Pluto* ASIC fans the system bus out to all the
"slow" peripherals (keyboard controller, floppy, CF/PCMCIA detect, IrDA, RS-232, LCD/power rails, dock
detect, modem, BIOS flash control, RAM-module ID). The two custom chips coordinate over dedicated
`Bowman_IO` / `Pluto_IO` lines. Power is managed off to the side by the U6 power-sense MCU on its own
PSU daughterboard, joined to the mainboard through the J5/J3 connector.

```
                         ┌───────────────────────────────┐
                         │  80486SX-33  (U76, BGA-256)    │
                         └───────────────┬───────────────┘
              486 local bus: A2..A31, ADS#/MIO#/DC#/WR#/RDY#/INTR/RESET, CPUCLK
                                         │
                                         ▼
   ┌──────────────────┐         ┌───────────────────┐        ┌────────────────────┐
   │ U67  M38813       │◄M38_IO►│  U21  BOWMAN      │◄ROMA/CE►│ U59 Flash BIOS     │
   │ keyboard / PM MCU │        │  system controller │        │ (28F002)           │
   └──────────────────┘        │  (CPU↔16-bit ISA)  │        └────────────────────┘
                               │                   │
   ┌──────────────────┐  ESS   │                   │  Pluto_IO / Chipset_IO
   │ ES488F audio (U4) │◄IRQ/───┤                   ├───────────────┐
   │  + YM3812 OPL2    │  DACK  │                   │               ▼
   └──────────────────┘        └─────────┬─────────┘     ┌────────────────────┐
                                          │               │  U35  PLUTO        │
            16-bit ISA-style system bus   │               │  I/O controller    │
        SA0..15 / SD0..15 / IOR#/IOW#/AEN │◄─────────────►│  KBC,FDD,CF,dock,  │
        IRQ2..15 / DRQ / DACK             │               │  IrDA,RS232,LCD,   │
                                          │               │  modem,BIOS-WE,    │
                                          ▼               │  RAM-ID            │
   ┌──────────────────────────────────────────────┐      └─────────┬──────────┘
   │ CompactFlash · PCMCIA · C&T 65535 video (U51) │                │
   │ VL82C420 (U61) · Super-I/O FDC37C665 (U22)    │     peripherals: floppy (dock),
   │ DRAM (U28/U33) · font ROM (U36)               │     CF/PCMCIA, IrDA, serial,
   └──────────────────────────────────────────────┘     modem, LCD bias, RAM module

                           ── PSU daughterboard (via J5/J3) ──
   ┌──────────────────────────────────────────────────────────────────────────┐
   │ U6 M38223E4HP "POWER SENSE MICON"  ─  watches battery & button, enables    │
   │ the main 10.5 V rail, gauges current via PSU op-amp front-end (JRC 7064).  │
   └──────────────────────────────────────────────────────────────────────────┘
```

A few architectural notes worth keeping in mind while servicing:

The split between Bowman and Pluto is real and matters for fault isolation. Bowman owns CPU-side timing,
interrupts, DMA and ROM; Pluto owns the slow peripheral fan-out. The floppy is split between them — Pluto
carries most of the FDD data lines while Bowman handles floppy interrupt/DMA — so a floppy fault can sit
on either chip. Audio decode similarly straddles both: Pluto produces the ESS address-enable
(`Pluto_ESS_AEN`) while Bowman produces the ESS DMA-acknowledge (`Bowman_ESS_DACK1#`).

The power MCU (U6) is electrically and logically separate from the rest of the machine. It lives on the
PSU board and reaches the mainboard only through J5/J3. It can be alive and running while the rest of the
machine is dead — that distinction drives most "won't power on" diagnosis (§7, §14).

---

## 3. Chip roster / bill of materials

Major active devices, with the manual section that covers each in depth. "Custom" parts have no public
datasheet; their behaviour was reverse-engineered.

| Ref | Part / marking | Package | Function | Detail |
|---|---|---|---|---|
| **U76** | 80486SX-33 (RIOS-marked) | BGA-256 | Main CPU | §2, §13 |
| **U21** | **Bowman** (custom RIOS gate array) | ~144-pin QFP | System controller / CPU↔16-bit-ISA bridge | §8 |
| **U35** | **Pluto** (custom RIOS gate array) | 100-pin QFP | Peripheral I/O controller | §9 |
| **U60** | **Bowman** (second instance / companion) | — | Part of the Bowman complex | §8 |
| **U61** | VLSI **VL82C420** | QFP | System chipset (DRAM/ISA support) | §11 |
| **U51** | Chips & Technologies **65535** (F65535) | QFP | VGA / LCD graphics controller | — |
| **U22** | SMC **FDC37C665IR** | QFP | Super-I/O (FDC, serial, parallel) | §12 |
| **U4** | ESS **ES488F** AudioDrive | 52-pin QFP | Sound-Blaster-compatible audio codec/mixer | §10 |
| **U10** | Yamaha **YM3812** (OPL2) | DIP/QFP | FM synthesizer | §10 |
| **U46** | Yamaha **YM3014B** | — | Serial DAC for the OPL2 | §10 |
| **U12** | National **LM4861** | — | ~1 W mono speaker amplifier | §10 |
| **U48** | Dallas **DS1669** | — | Digital "Dallastat" volume pot | §10 |
| **U6** (mainboard) | Mitsubishi **M38223E4HP** | 80-pin QFP | Power-sense / battery-management MCU | §4 |
| **U6** (PSU board) | JRC **7064** quad op-amp (+ U7A) | — | Battery voltage/current sense front-end | §6 |
| **U67** | Mitsubishi **M38813 / M38813M4** | 64-pin QFP | Keyboard & power-management MCU | §12 |
| **U54** | **74HC74** dual D flip-flop | — | Power-state latch | §4, §7 |
| **U36** | OKI **MSM538032E** (M538032C) | SOP-44 | IBM DOS/V font ROM (P/N 84G7940) | §11 |
| **U59** | Intel **28F002** | — | Flash BIOS | §8, §11 |
| **U28, U33** | **M5M4V16160BTP** | — | On-board DRAM | §11 |
| **U63** | **AV9154A** | — | Clock generator | — |
| **U70** | TI **TPS2201** | — | PCMCIA dual-slot power switch | §8 |
| **U7/U49/U72** | Hitachi **HD151015** | — | Bus transceivers / 5 V↔3.3 V level translators | §10 |
| — (modem) | Panasonic **MN195001** | 128-pin | Modem DSP / codec | §12 |

> **Note on the two "U6"s.** The schematics reuse the reference designator `U6` on two different boards:
> on the **mainboard** U6 is the M38223E4HP power MCU (the brain), and on the **PSU daughterboard** U6 is
> the JRC 7064 quad op-amp (its analog senses). This manual always says which board it means. Likewise
> "Bowman" appears as both U21 and U60.

---

## 4. Power subsystem — the U6 power-sense MCU

### 4.1 The 30-second mental model

The PC110 is **never fully "off"** while a charged battery or adapter is attached. A tiny **standby
supply** keeps the **U6 power MCU** (mainboard M38223E4HP) alive in STOP (sleep) mode. U6 watches the
**power button** and the **battery via its A-D converter**. When you press power, U6 wakes, checks that
the battery is healthy, and only then drives its **enable outputs (P52/P53)** across J5→J3 to switch on
the main **~10.5 V rail (PWR_IN_10v5)**, which feeds all the downstream regulators (5 V, VCC, VEE, etc.).
A **74HC74 latch (U54)** holds the power state, and U6 **handshakes with the system (P20/P21)**.

If any link in that chain is broken, the machine appears dead or powers up partially. §7 walks the chain
in order; §14 turns it into a fault tree.

### 4.2 Identity of U6 (the power MCU)

- **U6 is a Mitsubishi M38223E4HP** — an 8-bit, 740-core single-chip microcontroller (3822 group,
  80-pin QFP), running as the machine's **power-management / power-sense controller**. ✅
- Its mask ROM contains the banner
  **`M3822X POWER SENSE MICON FIRMWARE Rev 8 (C) 1995 RIOS SYSTEMS CO.,LTD.`** ✅
- The 740 core is 6502-compatible plus bit instructions (`SEB`/`CLB`/`BBS`/`BBC`), `MUL`, and the
  low-power `STP`/`WIT` instructions. The 3822 group adds an LCD drive controller, an **8-channel 8-bit
  A-D converter**, serial I/O, timers, and a 16-vector interrupt controller. ✅

**ROM image & memory map** (from the supplied dump):

| Region | Address | Contents |
|---|---|---|
| Banner | `0xC000–0xC045` | ASCII copyright string |
| Reset / start of code | `0xC046` | first opcode `78` = `SEI` |
| Program code | `0xC046–0xE8FB` | ~10.4 KB used |
| Blank | `0xE8FC–0xFF59` | `0xFF`, unprogrammed |
| Interrupt vector table | `0xFF5A–0xFF7D` | 16 little-endian pointers |
| **Missing from dump** | `0xFF7E–0xFFFF` | last 130 bytes truncated — includes CPU hardware reset/IRQ vectors (0xFFDC–0xFFFF) ✅ |

ROM is mapped at the top of the address space: file offset *N* = address `0xC000 + N`. Dump size
16 254 bytes (`0x3F7E`). The firmware is a classic battery/power state machine: it initialises ports,
configures the A-D, then loops polling the A-D and dispatching on RAM state flags, with three `STP`
(deep-sleep) entry points used for suspend. ✅

### 4.3 Power domains / rails

| Rail / net | Approx. | Source | When present | Notes |
|---|---|---|---|---|
| **Battery B+** (JX1) | ~7–9 V Li-ion (or alkaline pack) | Main battery → **F5 2.5 A** fuse → **L1** → **U13 (J421 FET)** | Whenever battery fitted | Current sensed by **0.1 Ω shunt R7/R8** |
| **PWR_IN_10v5** | ~10.5 V | Battery boost **or** AC adapter / dock (`Dock_PWR_IN−`) | When a source is attached | The main pre-regulation bus |
| **Standby / VCC (U6)** | ~5 V (3–5 V) ⚠️ | Always-on micro-regulator off the bus | **Always** (source attached) | **Keeps U6 alive in STOP** |
| **5 V** | 5 V | DC-DC from PWR_IN_10v5 | After power-on (P52 asserted) | Logic/system rail (J5/J3 "5v") |
| **VEE** | negative LCD bias | VEE generator, gated by **F65_ENAVEE** | After display enable | LCD contrast/bias |
| **PNET1 / PNET4 / PNET5** | — | inter-board power distribution | with bus | Carried on multiple J5/J3 pins |
| **JRC_VCC** | op-amp supply | from bus near VREF network | with bus | Powers the PSU sense op-amps (U6 7064 + U7A) |

> ⚠️ The exact standby-rail voltage and which regulator makes it were not fully traced. Verify against a
> known-good board. Likewise the downstream DC-DC topology (which converter makes 5 V / VEE) is only
> partially traced.

### 4.4 The actors (who does what during power-up)

| Ref | Part | Role in power-up |
|---|---|---|
| **U6** (mainboard) | M38223E4HP 740 MCU | The brain. Sleeps in STOP, wakes on button, checks battery, drives enables, handshakes. |
| **U6** (PSU board) | JRC 7064 quad op-amp (+ **U7A**) | Conditions battery voltage/current into U6's A-D channels (AN0/AN1/AN3/AN4, VREF). |
| **U54** (mainboard) | 74HC74 dual D flip-flop | Latches the power-on state (`U54_1D`, `U54_1Q`, `U54_VCC`, `U54_1PRE#`). |
| **Q4** ("8LR") | NPN | Driven by **M38_P52** via **R2 470k** → gates the main-rail switch. |
| **Q5/Q22** ("8C") | switches | High-side switching of **PWR_IN_10v5**. |
| **Q31/Q33** ("BLR/BLB") | transistors | Driven by **M38_P53** path. |
| **F5** | 2.5 A fuse | In the battery current path (after the shunt). **Prime suspect on a dead board.** |
| **U13** | J421 FET | Battery path switch / ideal-diode. |
| **U3, U60, …** | regulators | Downstream DC-DC (5 V, etc.) ⚠️ not fully traced. |

---

## 5. The J5 / J3 inter-board connector

J5 (mainboard) and J3 (PSU daughterboard) are the **same 40-pin board-to-board connector**, mated
pin-for-pin. They carry three classes of signal between the two boards:

1. **4 analog sense lines + VREF** going *into* U6's A-D converter (battery / charger sensing);
2. **4 digital control / handshake lines** between U6 and the system;
3. **power rails and grounds** (PNET1/4/5, 10.5 V, 5 V, VCC, GND, dock return).

![J3 connector on the PSU schematic — the authoritative pin labelling](PSU-MB-M38/J3_full.png)

### 5.1 Numbering note (important — read before probing pins)

The two schematics number the **second row differently**:

- Pins **1–20** (first row): **identical** numbering on both boards.
- Pins **21–40** (second row): **J3** counts top→bottom `21→40`; **J5** counts top→bottom `40→21`.
- So a second-row signal has **J5 pin = 61 − (J3 pin)**. (e.g. P63 = J3-21 = J5-40.)

The net **names** are the ground truth and match across the gap. J3 (PSU side) labels every pin and is
used as the authoritative net name throughout this manual.

![J5 side of the connector on the mainboard schematic](PSU-MB-M38/J5_main.png)

### 5.2 Full reconciled pin map

| J3 pin | J5 pin | Net (PSU side) | Class | Function |
|:--:|:--:|---|---|---|
| 1  | 1  | M38_P60 / AN0 | **MCU analog** | A-D ch0 sense (PSU op-amp U6C output) |
| 2  | 2  | M38_P61 / AN1 | **MCU analog** | A-D ch1 sense (PSU op-amp U6D output) |
| 3  | 3  | PNET4 | power | inter-board power net |
| 4  | 4  | PNET4 | power | inter-board power net |
| 5  | 5  | GND (J5: Dock_PWR_IN−) | power | ground / dock-power return |
| 6  | 6  | J5_6 | spare | generic pass-through |
| 7  | 7  | GND (J5: YellowWire2_3, NC) | power | ground / rework ("yellow") wire |
| 8  | 8  | PNET1 | power | inter-board power net |
| 9  | 9  | GND | power | ground |
| 10 | 10 | PNET5 | power | inter-board power net |
| 11 | 11 | PNET5 | power | inter-board power net |
| 12 | 12 | D28_1 | component | diode net |
| 13 | 13 | Q43_2 | component | transistor net |
| 14 | 14 | R284_2 | component | resistor net |
| 15 | 15 | R73_2 | component | resistor net |
| 16 | 16 | U54_VCC (VCC) | power | supply to U54 (74HC74 power-state latch) |
| 17 | 17 | U54_1D | logic | 74HC74 D-input (power-state latch) |
| 18 | 18 | **M38_P52 / RTP0** | **MCU digital out** | **Main power enable** → Q4 → PWR_IN_10v5 |
| 19 | 19 | M38_P20 | **MCU digital I/O** | request/handshake line (bidirectional) |
| 20 | 20 | R412_1 | component | resistor net |
| 21 | 40 | M38_P63 / AN3 | **MCU analog** | A-D ch3 sense (PSU op-amp U6A; near 5 W shunt) |
| 22 | 39 | Q49_1 | component | transistor net |
| 23 | 38 | PNET4 | power | inter-board power net |
| 24 | 37 | GND | power | ground |
| 25 | 36 | GND | power | ground |
| 26 | 35 | D2_3 | component | diode net |
| 27 | 34 | M38_P64 / AN4 | **MCU analog** | A-D ch4 sense (PSU op-amp U6B output) — **bus voltage** |
| 28 | 33 | PNET1 | power | inter-board power net |
| 29 | 32 | GND | power | ground |
| 30 | 31 | M38_VREF | **MCU analog ref** | A-D reference voltage |
| 31 | 30 | PNET5 | power | inter-board power net |
| 32 | 29 | GND | power | ground |
| 33 | 28 | J5_33 | spare | generic pass-through |
| 34 | 27 | U21_131 | logic | control/status to system controller (Bowman U21 pin 131) |
| 35 | 26 | F65_ENAVEE | logic | **Enable VEE** (LCD negative-bias supply enable) |
| 36 | 25 | U54_1Q | logic | 74HC74 Q-output (power-state latch) |
| 37 | 24 | GND | power | ground |
| 38 | 23 | **M38_P53 / RTP1** | **MCU digital out** | control output → Q31/Q33 ("BLR") |
| 39 | 22 | M38_P21 | **MCU digital out** | handshake / control output |
| 40 | 21 | D18_2_3 | component | diode net |

The `M38_Pxx` MCU pins map exactly to the M38223 datasheet's alternate-function pins
(`P60/AN0 … P67/AN7`, `VREF`, `P52/RTP0`, `P53/RTP1`, `P20–P27`) and are cross-confirmed identical on
both boards. ✅

---

## 6. The PSU analog front-end (battery sensing)

The four analog pins are conditioned by a **JRC quad op-amp on the PSU board (its own "U6" = 7064,
powered by `JRC_VCC`)** plus a fifth section **U7A**. Signal direction is:

> Battery / shunt (PSU) → op-amps (PSU U6 7064 + U7A) → J3 → J5 → MCU A-D inputs.

### 6.1 The main current path (where the shunt lives)

`Main Battery JX1` is a 2-terminal pack (B+, B−; **no thermistor pin**, so there is **no battery-
temperature sense**). It feeds:

```
JX1 B+ ── 0.1 Ω shunt (R7 ‖ R8) ── F5 (2.5 A fuse) ── L1 (10 µH) ── U13 (J421 FET) ── system rails
```

The **0.1 Ω shunt pair R7/R8** is the current-sense element; the 2.5 A fuse sets the full-scale current.
A high-impedance **1 MΩ/1 MΩ divider (R89/R88)** also hangs off the battery node.

![Main battery JX1 path with the shunt and fuse](PSU-MB-M38/batt_JX1.png)

### 6.2 Channel-by-channel

| Ch | MCU pin | Op-amp | What it measures | Confidence |
|----|---------|--------|------------------|------------|
| **AN4** | P64 (J5-34/J3-27) | **U6B**, non-inverting | **Bus voltage** of PWR_IN_10v5: divider **R78 300k / R77 100k** (÷4) × gain (1 + R54 100k/R53 300k ≈ 1.33) ⇒ ~3.5 V at 10.5 V in. | ✅ fully traced |
| **AN3** | P63 (J5-40/J3-21) | **U7A + U6A** diff-amp | **Battery current** — instrumentation amp across the 0.1 Ω shunt (R67 47k, R57 100k, R102 300k, R105 100k, R109 200k, R103 10k, R113 20k; C20/C43/C46 filtering). | ✅ (current) |
| **AN0** | P60 (J5-1/J3-1) | **U6C**, gain ≈ ×20 | **Battery current, higher gain/offset** — inverting stage (R63 10k in, R62 200k fb) fed from the shunt network, with R45 200k/R44 10k offset bias on the + input ⇒ bidirectional (charge vs discharge) reading. | ✅ (current) |
| **AN1** | P61 (J5-22/J3-39) | **U6D**, matched ×20 diff-amp | **Independent battery-rail current sense.** + input fed via **R52 10k from the rail node above F5** (not from AN0); R52/R69 = R64/R101 = 10k/200k is a textbook difference amplifier (×20). | 🟡 netlist-verified topology |
| **VREF** | (J5-31/J3-30) | — | A-D reference, RC-filtered (R6 470 Ω + C1 150 nF), tied to PNET5 / JRC_VCC. | ✅ |

![AN4 bus-voltage sense (PSU op-amp U6B)](PSU-MB-M38/an_U6B.png)

![AN0 current sense (PSU op-amp U6C)](PSU-MB-M38/an_U6C.png)

![AN1 independent battery-rail current sense (PSU op-amp U6D)](PSU-MB-M38/an_U6D.png)

![AN3 shunt instrumentation amp (U7A + U6A, near the 5 W shunt)](PSU-MB-M38/shunt_U6A.png)

So the front end is a classic **battery fuel-gauge / charge-control sensor set**: one **bus-voltage**
channel (AN4) plus a precision **current-sense** chain on the 0.1 Ω shunt feeding two-to-three A-D
channels at different gains/offsets, so the MCU can resolve both large discharge currents (up to the
2.5 A fuse limit) and small charge/standby currents — exactly what's needed for coulomb counting and
charge-termination on a Li-ion + bridge-battery system.

### 6.3 Firmware corroboration

The firmware confirms a **multi-channel, filtered scan**: a single channel-select write `sta ADCON`
(`$D74F`), the conversion-complete poll `bbc 3,ADCON`, and **11× `lda AD`** reads (`$D5FD–$D831`) stored
into dedicated RAM variables and kept as **paired samples** (0x7A/0x7B, 0x7C/0x7D, 0x76/0x77, 0x78/0x79)
for averaging/debounce before the power state-machine acts on them. ✅

### 6.4 Net-result reading

The four channels are best read as **AN4 = main bus voltage** (battery *or* adapter, since they share
the PWR_IN_10v5 node — so no separate pack-voltage channel is needed) and **AN0/AN3/AN1 = battery
current** sensed at different points/gains (low-side shunt R7/R8 at two gains, plus a high-side
battery-rail diff-amp). Other PSU-side details:

- **P20 / P21** have back-to-back diode clamps (**Q28, "W6"**) at the connector — ESD/level protection on
  the handshake lines.
- **P53** drives **Q31 (W6) → R87 → Q33 ("BLR")**; **P52** drives **Q4 ("8LR") via R2 470k**, whose
  collector gates the **PWR_IN_10v5** transistor bank (Q5/Q22, "8C"). P52 is the hard main-power enable.
- The op-amps are JRC "7064" parts, supplied from `JRC_VCC` derived near the VREF network (D-clamp, Q2
  "K", R3 1k, PNET5).

> **Residual uncertainty:** ground is drawn as many separate GND symbols, so wire-only tracing cannot
> prove where U6D's − reference (R64) ultimately returns. The *topology* (AN1 = independent battery-rail
> current via a ×20 diff-amp) is netlist-verified, but a 2-minute continuity check on a real board would
> settle that last hop. 🟡

---

## 7. Power-on sequence, step by step

This is the chain §14 turns into a fault tree. Stop at the first broken link.

### Phase A — Standby (machine "off")

1. A source (battery or adapter) is attached → **PWR_IN bus** live → **standby regulator** powers **U6
   VCC**. ✅ (U6 must have VCC or nothing below happens.)
2. After reset, U6 firmware configures ports and **enters STOP mode** (`STP` at `$CD00`; it sits in
   `STP / bra $CD00`). Only the wake interrupts are armed (`seb 3,ICON2`, `seb 4,ICON2`). ✅
3. In this state the **main rail is OFF**: `M38_P52`/`M38_P53` are **low**, Q4 off, Q5/Q22 off. ✅

### Phase B — Wake (you press the power button)

4. The **power button** pulls **U6's INT3 input (port P5.1)** → wakes U6 from STOP. ✅ that P5.1/INT3 is
   a polled wake/startup trigger; 🟡 that the physical button sits on this line (it is **not** on J5/J3 —
   it's a mainboard signal straight to U6).
5. Firmware **classifies the wake reason** (routines `$CCFC/$CD03/$CD0D`) by reading P5.1 (INT3) and a P7
   input, producing a startup-mode code (0–5). ✅ This is why a brief vs. held press, or
   adapter-insert vs. button, can behave differently.

### Phase C — Battery / source health check (the big gatekeeper)

6. U6 runs an **A-D scan** of the PSU front end (`sta ADCON` channel select at `$D74F`, then repeated
   `lda AD`, paired-sample averaging). It reads AN4 (bus voltage ÷4), AN0/AN3 (shunt current), and AN1
   (high-side rail current). ✅
7. **If the measured voltage/health is below threshold, U6 refuses to assert the enables** and returns to
   STOP. 🟡 → *This is the #1 reason a PC110 with a flat/dead battery won't turn on even though it
   "should."*

### Phase D — Turn the main rail on

8. U6 executes its **power-enable routine** (`$D056`): `seb 2,P5` + `seb 3,P5` → drives **M38_P52 = HIGH**
   and **M38_P53 = HIGH**. ✅
9. **M38_P52 (J5-18 / J3-18)** → R2 470k → **Q4 base** → Q4 conducts → gates the **Q5/Q22 bank** →
   **PWR_IN_10v5 main rail switches ON**. ✅
10. **U54 (74HC74)** latches the power-on state (`U54_1D` clocked to `U54_1Q`) — holds power up after the
    button is released. 🟡
11. Downstream **regulators come up** (5 V, VCC rails) → the system/CPU side begins to boot. 🟡

![P52 → Q4 → main-rail switch detail (PSU schematic)](PSU-MB-M38/psu_p52.png)

### Phase E — Handshake & housekeeping

12. U6 **handshakes with the system controller** on **P2.0 / P2.1** (J5-19/J3-19 and J5-22/J3-39): it
    reads P2.0 as a request, validates a **`0x5A` sync byte**, then drives P2.0 low and P2.1 high to
    acknowledge (`$CAD3…$CAE4`, and the `$C983–$CBF2` state machine). U6 also has a **UART** (TXD/RXD on
    port **P4**, mainboard-side) for fuller comms. ✅
13. Later in bring-up, **F65_ENAVEE (J5-26 / J3-35)** is asserted to enable the **LCD VEE** bias so the
    display can light. 🟡
14. U6 stays awake running its monitor loop (battery gauging, charge control, suspend/resume). On
    power-off or critical battery it runs the **`$D05B` power-down** (`clb 2,P5` / `clb 3,P5` → P52/P53
    low → main rail off) and re-enters STOP. ✅

### 7.1 Signal state cheat-sheet (off vs. on)

| Signal (pin) | Standby/off | After power-on | How to read |
|---|---|---|---|
| U6 VCC (standby) | **present** ⚠️ | present | Must be present even when "off". If 0 V → dead micro. |
| **M38_P52** (J5-18/J3-18) | low | **high** | Goes high on button press = "U6 decided to turn on". |
| **M38_P53** (J5-23/J3-38) | low | **high** | Driven together with P52. |
| **PWR_IN_10v5** | off* | **~10.5 V** | *Present if adapter feeds it directly; switched for battery. |
| **5 V** | off | **5 V** | Downstream of the main rail. |
| **M38_P20/P21** (J5-19,22 / J3-19,39) | idle | toggling handshake | Activity = U6 talking to the system. |
| **AN4/P64** (J5-34/J3-27) | tracks bus | tracks bus | DC analog ≈ Vbus/4. |
| **VREF** (J5-31/J3-30) | steady ref | steady ref | If 0 V, A-D reads garbage → U6 may refuse to start. |
| **F65_ENAVEE** (J5-26/J3-35) | low | high (at display-on) | LCD bias enable. |

*Pin numbers: J3 (PSU) numbering is authoritative; for J5 second-row pins use **J5 = 61 − J3**.*

![The "crux" of the enable path across the connector](PSU-MB-M38/crux.png)

---

## 8. Bowman (U21) — system controller ASIC

**U21 (value field `Bowman`)** is the PC110's **main system-controller ASIC** — a ~144-pin custom RIOS
gate array that bridges the 80486SX local bus to a 16-bit ISA-style system bus and absorbs nearly all of
the machine's glue logic: ROM decode, interrupt aggregation, DMA handshaking, floppy, the keyboard-MCU
link, audio glue and power sequencing. It corresponds to the documented custom RIOS chip that
"controlled the ISA bus and expanded the bus width to 16 bits." There is no public datasheet; `Bowman` is
the schematic code-name.

| Attribute | Value |
|---|---|
| Reference designator | **U21** (a companion instance is **U60**) |
| Code-name | **Bowman** |
| Function | System controller / CPU→ISA bridge ("chipset") |
| Pin count | 144 (QFP-class custom gate array) |
| CPU interface | 80486SX local bus (U76, BGA-256) |
| Companion controller | U35 **Pluto** (linked via `Bowman_IO1/2`, `Pluto_IO`) |

### 8.1 Pinout by function

**CPU local bus (80486SX interface):**

| Signal | Pin | Notes |
|---|---|---|
| `CPUA2`–`CPUA25` | 10–17, 19–27, 29–35 | CPU address bus (A0/A1 handled as byte-enables, not exposed) |
| `CPU_ADS#` | 49 | Address strobe |
| `CPU_MIO#` | 50 | Memory / IO# |
| `CPU_DC#` | 41 | Data / Control# |
| `CPU_WR#` | 42 | Write / Read# |
| `CPU_RDY#` | 134 | Ready / cycle complete |
| `CPU_INTR` | 133 | Maskable interrupt to CPU (8259 INTR equivalent) |
| `CPU_RESET` | 46 | CPU reset |
| `CPUCLK` | 38 | CPU clock |

**16-bit ISA-style system bus:**

| Signal | Pin | Notes |
|---|---|---|
| `SA0`–`SA15` | 55–63, 65–71 | System address bus |
| `SD0`–`SD7` | 96,95,94,93,92,91,89,88 | System data, low byte on Bowman (high byte routed elsewhere) |
| `IOR#` / `IOW#` | 112 / 113 | I/O read / write |
| `AEN` | 114 | Address enable (DMA in progress) |
| `MEMCS16#` | 119 | 16-bit memory chip-select |
| `LDEV#` | 43 | Local device select |
| `ADDHI` | 124 | High-address qualifier |
| `DS3#` | 123 | Decode / strobe |

**Interrupt controller (8259-class aggregation):** `IRQ2`=87, `IRQ3`=85, `IRQ4`=84, `IRQ5`=83, `IRQ7`=81,
`IRQ9`=79, `IRQ10`=78, `IRQ11`=77, `IRQ12`=76, `IRQ14`=75, `IRQ15`=74, `KB_IRQ1`=86, `ESS_IRQ1`=118.

**DMA & floppy:** `FINTR`=82, `FDRQ`=115, `PDRQ`=117, `DACK#`=120, `PDACK#`=121, `ESS_DACK#`=122,
`FDD_IO`=125.

**ROM / BIOS decode:** `ROMA12`–`ROMA19` = 9,7,6,5,4,3,2,143; `ROMCE#`=142. (Bowman controls the Flash
BIOS path — distinct from the OKI font ROM in §11.)

**Keyboard / PM MCU link (to M38813):** `M38_IO1`–`M38_IO12` = 97,98,101,102,103,104,105,106,107,110,111,
139; `KB_RESET#`=48; `KB_SCRLED#`=53.

**Power, clocks & housekeeping:** `PWRGD_IN`=141, `PWRGD`=47, `PSU_IO1`=131, `PSU_IO2`=138, `24MHz`=40,
`32kHz`=51, `VolUP`=127, `VolDN`=128, `Pluto_IO`=129, `Chipset_IO1`–`5` = 45,140,39,52,130.

**Power rails:** `VCC`/`VCC2` = 1,18,36,37,54,72,73,90,99,108,109,126,144; `GND` =
8,28,44,64,80,100,116,136; `NC` = 132,135,137.

### 8.2 Service notes & open questions

Local support around U21 includes pull-ups R98 (4.7k) / R99 (470 Ω), transistors Q9/Q13, and the
`PNET`/`PSU_IO` power-sequencing network shared with the PCMCIA power switch (U70 TPS2201) — consistent
with Bowman also overseeing card-slot power-up and reset timing.

- **No `CPUA0`/`CPUA1`** — the address bus to Bowman starts at A2; byte selection uses byte-enables
  (standard 486 practice). 🟡
- **8-bit data on Bowman, 16-bit elsewhere.** Bowman exposes only `SD0..7`, yet its documented job is the
  16-bit bus expansion (CompactFlash uses `SD0..15`). The high-byte / `MEMCS16#` steering likely happens
  through `ADDHI`, `Chipset_IO*`, or in concert with Pluto. ⚠️ worth tracing against the X-rays.
- **Bowman ↔ Pluto coupling.** Pluto carries `Bowman_IO1` (pin 51) / `Bowman_IO2` (pin 52); Bowman
  carries `Pluto_IO` (pin 129). What exactly passes over these lines is not yet decoded.

---

## 9. Pluto (U35) — I/O gate array

U35 ("Pluto") is the **system I/O glue / peripheral controller** — a 100-pin custom RIOS gate array. It
hangs off the ISA-style local bus (`SD0–7`, `SA0–15`, `IOR#`, `IOW#`, `AEN`) and fans it out to the
keyboard controller, floppy, PCMCIA/CompactFlash detect, IrDA, RS-232, LCD/power-management rails,
docking detect, modem and external BIOS flash. It also offloads some latching to discrete 74-series
flip-flops (U30/U40/U45/U53).

![U35 "Pluto" gate array — schematic symbol with pin labels](Pluto/u35_crop.png)

### 9.1 Package & power

100 pins total. **VCC (7):** 7, 14, 38, 64, 88, 95, 97. **GND (5):** 4, 13, 37, 63, 87.
**NC / unused (14):** 47, 49, 59, 80, 82, 84, 85, 91, 92, 94, 96, 98, 99, 100. Decoupling clustered
directly above U35: C111 (1 nF), C117 (100 nF), C280 (100 nF), C78 (1 nF), C71 (1 nF), C74 (180 nF).

### 9.2 Bus interface

`SD0–SD7` = 33,34,35,36,39,40,41,42. `SA0–SA15` = 8,9,10,11,12,15,16,17,18,19,20,21,22,23,24,25.
`AEN`=6, `IOR#`=86, `IOW#`=89. (Address pins skip 13/14 = GND/VCC and data pins skip 37/38 = GND/VCC,
which is why the numbering has gaps.)

### 9.3 Functional / peripheral pins

| Group | Pins (name) |
|---|---|
| **Keyboard & speaker** | 30 PS2_IO, 43 KB_SPKDN, 44 KB_SPKUP, 60 KB_CCS (KBC chip-select), 61 KB_CNTR#, 66 KB_RESET# |
| **CPU / clock / power** | 62 CPU_STPCLK#, 65 CLK, 67 PWRGD, 50 PWR_ON_SENSE |
| **Floppy (FDD)** | 68–71 FDD_IO1–4, 58 Pluto_IOW (FDC write strobe) |
| **External flip-flops** | 1 FF_D0, 2 FF_2D, 3 FF_2CLK, 45 FF_1CLK, 46/78 FF_1A, 72 FF_1Q, 73 FF_2Q, 90 FF_2Q# |
| **PCMCIA/CF & docking** | 26 CF_CD2, 27 CF_CD1, 28 Dock_Detect1, 29 Dock_Detect2 |
| **Serial / IrDA / modem** | 77 EN_RS232, 81 IRDA_O, 48 IRDA_EN, 75 MN195_VSDA (modem codec, see §12), 79 FDC_O (ESS AEN) |
| **Bowman link** | 51 Bowman_IO1, 52 Bowman_IO2 |
| **BIOS flash control** | 53 BIOS_WR_EN, 54 BIOS_SA17 (address bit 17 / bank select) |
| **LCD / display power** | 83 PSU_IO (EN_LCD_VAA), 5 LCD_IO (LCD_NC_L11), 93 LCD_IO (LCD_STNDBY, pulled up by R393 47k) |
| **Misc / unconfirmed** | 31 RAM_ID0, 32 RAM_ID1, 55–57 Pluto_55..57 ⚠️, 74 PNET7_SENSE ⚠️, 76 Dev_OE, 50 PWR_ON_SENSE ⚠️ |

### 9.4 What cross-module checks confirmed

Comparing Pluto's nets against the dock, modem and RAM-module schematics confirmed several previously-
guessed pins and showed Pluto reaches well beyond the mainboard:

- **Floppy lives in the docking station.** Pluto is the FDC, but the drive is in the dock; `CN2` there
  carries the full classic floppy interface (`FDC_RDATA#`, `FDC_WDATA#`, `FDC_STEP#`, `FDC_DIR#`,
  `FDC_TRK0`, `FDC_INDEX#`, `FDC_WGATE#`, `FDC_WRTPRT#`, `FDC_DSKCHG#`, `FDD_MOTEN`, `FDD_DRSEL`,
  `FDC_DRATE0/1#`). These route to Pluto pins 68–71 plus the strobe on pin 58. The floppy work is
  **split with Bowman** (`FDD_Bowman` appears alongside). ✅
- **RS-232 enable (pin 77)** gates the dock's serial line drivers (`U3 DS14C535`, `LT1237`, `74HCT244`
  U1) — Pluto controls when the dock's serial port is live. ✅
- **Dock detect (pins 28/29)** line up with the dock's `Pluto_Dock1/2` nets to the J1–J4 dock
  connectors. ✅
- **Modem control (pin 75)** taps the MN195001 codec's `VSDA#` line. ✅
- **RAM-module ID (pins 31/32)** read the expansion module's two identity straps (see §11). ✅

**Takeaway:** Pluto is the floppy controller + serial/dock power manager + modem control-bus master +
RAM-module ID reader — not just a generic bus buffer.

> ⚠️ Pin *names* for 50, 55–57, 74 are placeholders from the reverse-engineering effort, not confirmed
> silicon function. Pin 75's symbol label reads `NM192_VSDA` but is almost certainly `MN195_VSDA` (a
> schematic typo — the modem chip is the MN195001).

---

## 10. Audio subsystem — ES488 / OPL2

**U4 is an ESS Technology `ES488F` "AudioDrive"** — a single-chip, ISA-bus, Sound-Blaster-(Pro)-
compatible audio controller in a **52-pin QFP**. ESS never released a public datasheet, so the pin
functions below come from how the chip is actually wired on this board. The signal chain:

```
   YM3812 (U10, OPL2 FM) ──digital──► YM3014B (U46, serial DAC) ──analog FM──►
   ┌─────────────────────────────────────┐
   │ ES488F (U4) — mixer / codec / SB     │ ◄── ISA data/addr (via HD151015 + 74LV buffers)
   └─────────────────────────────────────┘
        │ LineOut → net "ESS_Sound"
        ▼
   LM4861 (U12, ~1 W speaker amp)  ◄── volume set by DS1669 (U48)  →  Speaker
```

![ES488F (U4) region of the mainboard](ES488/u4_tight.png)

### 10.1 U4 pinout (as wired)

**Digital / ISA-bus interface:** `D0–D7` = 23,24,25,28,29,30,31,32; `A0–A9` = 41,42,43,45,46,47,48,49,50,
51 (board nets `SA1…SA9`); `IRQ1`=16 (`ESS_IRQ1`), `IRQ2`=18 (`ESS_IRQ2`), `DRDY`=21 (`ESS_DRDY`),
`AEN`=40 (`ESS_AEN`), `DIR`=14, `DACK1#`=36 (`Bowman_ESS_DACK1#`), `IOR`=37, `IOW`=38, `RESET`=39
(`FCS_RESET`).

**Power / clock / reference:** `VCC`=20,27 (decoupled by C150 10 nF, C19 150 nF); `VCC_Bus`=44;
`Xin/Xout`=34/35 (crystal X2 + C53 22 pF); `REF`=52; NC = 3,5,12,15,17,19,22,26,33.

**Analog audio:** `MIC`=4, `LineOut`=9 (→ `ESS_Sound`), `ByPass`=10/11, `CMR`=6, `GamePad`=13,
`CinR/FoutR`=2/1 (C12 250 nF), `CinL/FoutL`=8/7; analog filtering C20 1.5 nF, C21/C22 270 nF.

### 10.2 Associated chips

| Ref | Part | Role |
|---|---|---|
| **U10** | Yamaha **YM3812** (OPL2) | FM synthesizer (AdLib / SB-Pro music). CS via `YMF_CS#_Buf`. |
| **U46** | Yamaha **YM3014B** | Serial floating-point DAC for the YM3812 stream. |
| **U11A** | **NJM2904** | Dual op-amp buffering the FM analog output into the mixer. |
| **U34 (A/B/D)** | **74LV126** | Quad tri-state buffers gating the data bus / `YMF_SA0_A0` decode. |
| **U7, U49, U72** | Hitachi **HD151015** | Bidirectional transceivers / 5 V↔3.3 V level translators. |
| **U58** | single-gate Schmitt inverter (74LVC1G14-class) | Generates `FCS_RESET` → U4 pin 39. |
| **U69A/B** | **SN74LVC2G32** (dual OR) | Decode: (`FDC_DS3` OR `Pluto_ESS_AEN`) OR `AEN` → ESS reset/decode strobe. |
| **U12** | National **LM4861** | ~1 W mono speaker amp (C203 150 nF, C204 10 µF). |
| **U48** | Dallas **DS1669** | Digital "Dallastat" volume pot (UpC/DnC, RH/RW/RL; C13 270 nF, C147/C153 1 µF). |
| **X2** | crystal + C53 22 pF | Reference on U4 Xin/Xout. |
| **U17** | oscillator can (4-pin) | Buffered clock in the ESS area (via a 7W14-class Schmitt buffer). |

![FM synthesis area — YM3812 / YM3014B](ES488/fm_area.png)

![ESS chip-select / reset decode logic](ES488/cs_reset.png)

![Oscillator U17 in the ESS area](ES488/u17_osc.png)

### 10.3 Service note

U4 looks like a standard ISA sound device, but its bus arbitration, AEN and DMA handshakes are produced
by the **custom gate arrays**, not a generic ISA controller: `Pluto_ESS_AEN` (address-enable) comes from
Pluto (U35) and `Bowman_ESS_DACK1#` (DMA-acknowledge to U4 pin 36) comes from Bowman (U21). So an audio
fault that looks like "the sound chip is dead" can actually be a missing decode/DMA strobe from a custom
ASIC — check `FCS_RESET` (U58/U69), `Pluto_ESS_AEN` and `Bowman_ESS_DACK1#` before condemning U4.

---

## 11. Memory, ROMs & expansion

### 11.1 On-board DRAM & chipset

On-board DRAM is **M5M4V16160BTP** (U28, U33). The **VLSI VL82C420** (U61) provides system-chipset
support (DRAM/ISA), and the actual DRAM RAS/CAS/address muxing is done by the chipset — not by Pluto.

### 11.2 16 MB RAM expansion module

The optional expansion module (connector **J15**) carries eight **HM51W1788** DRAMs wired 32-bit-wide as
`CPU_D0–D31`, with `RAM_A0–A11`, `RAS2/RAS3`, `LCASU#/LCASL#/UCASU#/UCASL#`, and `WE#`. It brings out two
identity straps: `ID0` (J15 pin 60) and `ID1` (J15 pin 31). On this 16 MB module both are tied **low to
GND through 0 Ω jumpers R1/R2** → ID = `00`. By populating/omitting those links a module encodes its
size/type; with mainboard pull-ups an **absent** module reads `11`. **Pluto pins 31/32 (`RAM_ID0/1`)**
sample these bits so firmware can size installed RAM. ✅

### 11.3 Flash BIOS

System firmware lives in a **28F002 flash** (U59), decoded by Bowman over `ROMA12–ROMA19` / `ROMCE#`.
Pluto additionally gates flashing/banking via **pin 53 `BIOS_WR_EN`** (write-enable) and **pin 54
`BIOS_SA17`** (extra high address bit / bank select). So in-system BIOS reflashing depends on Pluto
asserting the write-enable.

### 11.4 Font ROM (U36) — software kanji

A separate, CPU-addressable **font ROM** sits on the system data bus: **U36, OKI `MSM538032E`** (alt.
marking `M538032C`, SOP-44, 16-bit `D0..D15`, `A0..A19`, on the `OKI_SA*` / `SD[0..15]` nets). It is
**not** the BIOS — it is the **IBM DOS/V display font ROM**.

- **Header:** magic `55 AA 10 CB`, label `FONT`, string
  `84G7940 (C) Copyright IBM Corporation 1990, 1995 All Rights Reserved`, dated **03/23/95**. ✅
- **IBM part number 84G7940**, size **1 MiB**, fully populated.

Font directory (parsed from offset `0x210`, 48-byte entries):

| Font set | Glyph size | Bytes/glyph | Data offset | Glyphs |
|---|---|---|---|---|
| System SBCS 12 | 6 × 12 | 12 | 0x0D8000 | 256 |
| System SBCS 16 | 8 × 16 | 16 | 0x002000 | 256 |
| System SBCS 19 | 8 × 19 | 19 | 0x000400 | ~256 |
| System SBCS 24 | 12 × 24 | 48 | 0x044000 | 256 |
| System DBCS 12 | 12 × 12 | 18 | 0x0D8C00 | ~8,900 |
| System DBCS 16 | 16 × 16 | 32 | 0x003000 | ~8,300 |
| System DBCS 24 | 24 × 24 | 72 | 0x047000 | ~8,200 |

SBCS = single-byte (JIS X 0201): ASCII (with `¥` at 0x5C) plus half-width katakana at 0xA1–0xDF. DBCS =
double-byte (JIS X 0208): hiragana, full-width katakana, Greek, Cyrillic, symbols and the ~6,800 kanji of
JIS levels 1 & 2. The PC110 has **no hardware kanji video** — IBM DOS/V renders Japanese text in software
by reading bitmaps from this ROM. Relevant for service: a corrupt or failed U36 manifests as garbled
Japanese glyphs (not a total video failure), since ASCII can be drawn from the smaller sets.

> ⚠️ The dump is 1 MB but the device's `A0..A19` × 16-bit organisation implies up to ~2 MB. Confirm
> whether a second 1 MB bank exists (8 Mbit read as bytes vs. 16 Mbit single bank).

---

## 12. Modem, docking station & keyboard controller

### 12.1 Internal modem (MN195001)

The internal modem module (`Modem.kicad_sch`) is built around the **Panasonic MN195001** DSP/codec
(128-pin), with a companion **Line Module 681000**, an **EN29F040A** flash (IC11) and SRAM (IC12). The
MN195001 exposes a 4-wire control bus — `VSEN# / VSDA# / VPCK# / VPDA#` (Voice Serial Enable / Data /
Clock / PData) — on connector `CNP4`. **Pluto pin 75** taps the `VSDA#` data line. The modem also brings
out UART-style lines (`U1RD`, `IRQ1#`, `ADCK#`, `DSR1`, `DCD1`, `RI1`) and runs partly on `VCC_STNDBY`.
(The symbol label `NM192` is a transcription of **MN195** — worth correcting in the schematic.)

### 12.2 Docking station

The dock extends Pluto's I/O fan-out:

- **Floppy** — `CN2 (FDC_Connector)` carries the full classic floppy interface; the drive physically
  lives in the dock (§9.4).
- **Serial** — `CN5 Serial Port` with line drivers `U3 (DS14C535MSA)`, `LT1237`, and `74HCT244` buffer
  `U1`, all enabled by Pluto's `EN_RS232` (pin 77).
- **Dock connectors** — `J1–J4` carry the `Pluto_Dock1/2` presence/handshake lines (Pluto pins 28/29)
  plus dock power (`Dock_PWR_IN−`, which appears on J5/J3 pin 5).

### 12.3 Keyboard controller (U67, M38813)

The keyboard subsystem MCU is a **Mitsubishi M38813E4HP** (3813 group, MELPS 740 core, 6502-compatible,
QFP-64). Pluto presents it to the CPU as an 8042-style keyboard controller: Pluto decodes the I/O port,
asserts `KB_CCS` (chip-select), and exchanges bytes over `SD0–7`, while `KB_CNTR#`/`KB_RESET#` and the
IRQ lines handle handshaking. Bowman also links to this MCU over `M38_IO1..12`.

From the mask-ROM dump (`M38813E4HP@QFP64.bin`):

| Item | Value |
|---|---|
| Banner | `MELPS 740 Series Keyboard Firmware Version 1.1 (C) Copyright 1992-1995 RIOS Systems Co.,Ltd.` ✅ |
| Image size | 16,255 bytes, mapped `0xC081–0xFFFF` (16 KB mask ROM) |
| MD5 | `835fc971bf700ddcc834ef5ba904aaa2` |
| RESET vector (FFFC) | `0xC208` |
| IRQ/BRK vector (FFFE) | `0xE49E` |
| NMI vector (FFFA) | `0xE62C` (→ an `RTI` stub) |
| Active peripheral vectors | FFF0 → `0xC0DB`, FFF6 → `0xD088` (two live sources — likely host/serial + a timer) |

> The banner is a concrete attribution: **RIOS Systems Co., Ltd.** wrote the keyboard firmware. Since
> "Rios" is also one of the PC110 custom-chip code-names (alongside Pluto and Bowman), this is strong
> evidence the whole custom-ASIC + firmware family originated at RIOS Systems.
>
> ⚠️ The included disassembly (`kbc_disasm.txt`) was produced with a stock-6502 decoder, so it desyncs on
> 740-only opcodes (`0x80 = BRA`, the `SEB/CLB/BBS/BBC` bit ops) and shows `.byte` gaps there. An accurate
> listing needs a 740-aware disassembler.

---

## 13. CPU debug headers & JTAG

The PC110 exposes two CPU debug headers plus a JTAG TAP, all tied to the **80486SX** (not the VL82C420
chipset), buffered through `74LVT125` with 33 Ω series resistors. This is a **HOLD-method 486
in-circuit-emulator / debug interface** — the standard way to ICE a *soldered* (BGA) CPU.

![Debug-header detail from the schematic](Debug/debug_hdr_zoom.png)

### 13.1 Pinouts (as drawn)

**J9 — "Debug-10" (2×5, 0.1″):**

| Pin | Signal | 486 dir | Pin | Signal | 486 dir |
|----:|--------|:------:|----:|--------|:------:|
| 1 | CPU_HOLD | **in** | 2 | CPU_BRDY# | **in** |
| 3 | CPU_BE1# | out | 4 | CPU_HLDA | out |
| 5 | CPU_BE3# | out | 6 | CPU_BE0# | out |
| 7 | CPU_A20M# | **in** | 8 | CPU_BE2# | out |
| 9 | CPU_SRESET | **in** | 10 | CPU_NMI | **in** |

**J12 — "Debug-6" (1×6, 0.1″):**

| Pin | Signal | 486 dir |
|----:|--------|:------:|
| 1 | CPU_BLAST# | out |
| 2 | CPU_FLUSH# | **in** |
| 3 | CPU_KEN# | **in** |
| 4 | CPU_EADS# | **in** |
| 5 | CPU_AHOLD | **in** |
| 6 | CPU_A31 | out (`CPU_A[2..31]` runs alongside) |

**JTAG TAP (separate):** `TCK`, `TDI`, `TMS`, `TDO` (IEEE 1149.1 boundary scan on the 486). `TRST#` is
not separately broken out.

*("in" = CPU input → a pod **drives** it; "out" = CPU output → a pod **senses** it.)*

### 13.2 What the headers are for

The signal selection gives it away: bus takeover (`HOLD`/`HLDA`/`AHOLD`) to float the 486 so an emulator
can own the local bus; cycle control (`BRDY#`/`BLAST#`); cache coherency (`EADS#` + `FLUSH#` + `KEN#` —
the tell, for a tool that modifies memory behind the running CPU); control (`SRESET`, `NMI`, `A20M#`,
byte enables); and a JTAG TAP for boundary scan.

**Honest limitation:** J9/J12 expose control + byte-enables + the address bus but **not the data bus**.
By themselves they let you halt, reset, interrupt, manage the cache, and observe cycles — but a full
RAM-override (read/write memory behind the CPU) also needs the data bus (tap it at the DRAM/ROM, or use
JTAG boundary-scan EXTEST).

### 13.3 Building a homebrew debug pod

Two practical paths; do JTAG first (cleanest), then add the J9/J12 controller for run-control. A
reference C implementation is in `Debug/pc110_debug_pod.c`.

**Path A — JTAG boundary scan (recommended, lowest-risk).** Use an **FT2232H** mini-module (or any
OpenOCD-supported dongle). Wire `TCK/TMS/TDI/TDO` (+ GND; tie `TRST#` inactive); 3.3 V LVTTL via the
existing `74LVT125` buffers is level-safe. With **OpenOCD** and the 486's **BSDL**, you can `SAMPLE`
every pin live and `EXTEST`-drive pins for board test — even do slow memory peeks by walking the boundary
register. No high-speed bus mastering needed. A safe first milestone is **JTAG `SAMPLE` to watch the CPU
pins live during POST** — zero risk, immediately useful for bring-up.

**Path B — J9/J12 run-control pod (MCU or small FPGA).** A 3.3 V MCU (RP2040, for fast GPIO + PIO) or a
small FPGA drives CPU-input signals and samples CPU-output signals. **Use level shifting** — the 486 side
may be 5 V; the `74LVT125` buffers are 5 V-tolerant in / 3.3 V out, with 33 Ω series Rs, but put proper
translation between pod and header. Core operations:

| Pod role | Drive | Sense |
|---|---|---|
| Halt/run | `HOLD`, `AHOLD` | `HLDA`, `BLAST#` |
| Reset/IRQ | `SRESET`, `NMI`, `A20M#` | — |
| Cache | `FLUSH#`, `EADS#`, `KEN#` | — |
| Cycle | `BRDY#` | `BLAST#`, `BE0-3#`, `A31`/`A[2..31]` |

1. **Halt:** drive `HOLD`=1 → wait `HLDA`=1 → CPU bus floated.
2. **Resume:** `HOLD`=0 → wait `HLDA`=0.
3. **Flush cache:** pulse `FLUSH#` low.
4. **Snoop-invalidate a line:** `AHOLD`=1 → present line address on `A[2..31]` → pulse `EADS#` low →
   `AHOLD`=0.
5. **Soft reset:** pulse `SRESET`. **Inject NMI:** pulse `NMI`.
6. **Single-cycle stepping** (if you also drive data/addr): use `BRDY#` to terminate each cycle.

**Caveats:** respect 5 V vs 3.3 V per net; the 486 internal cache is write-through, so after any pod write
to memory, `FLUSH#` (or per-line `EADS#`) before resuming or the CPU may read stale data; and don't fight
the chipset — the VL82C420 also issues `AHOLD`/`HOLD`/refresh, so coordinate or only take the bus while it
is idle.

---

## 14. Troubleshooting guide

> Safety first: a source attached means rails are live and the standby supply is running even when the
> machine looks off. Observe ESD precautions. Pin numbers below use the J3 (PSU) convention; for J5
> second-row pins, **J5 = 61 − J3**.

### 14.1 Completely dead — no reaction to the power button

Work the power-on chain (§7) in order; stop when you find the break.

**Step 1 — Source & standby.**
Confirm the battery/adapter actually delivers voltage to the board. Check **F5 (2.5 A fuse)** for
continuity — a blown F5 kills the battery path and is a prime suspect. Then measure **U6 VCC (standby)**:
no standby supply means U6 cannot run and the machine is totally dead. Trace the always-on regulator from
the bus. ⚠️

**Step 2 — Is U6 alive?**
With standby present, U6 should be oscillating (check XIN/XOUT) and sitting in STOP. No clock → bad
crystal or dead U6.

**Step 3 — Does the button reach U6?**
Press the button while monitoring **U6 P5.1 / INT3**; you should see the line move. No edge → the button,
its pull, or the trace is open. (The button is mainboard-side, not on J5/J3.)

**Step 4 — Does U6 try to turn on?**
Watch **M38_P52 (J3-18 / J5-18)** on button press:

- **P52 never goes high** → U6 woke but **refused** (battery/health gate, §7 Phase C) *or* a U6/firmware
  fault. Check the A-D inputs: is **VREF** present (J3-30/J5-31)? Is **AN4 ≈ Vbus/4** (J3-27/J5-34)? A
  dead VREF or a shorted sense op-amp makes U6 read "battery bad" and abort. ✅ logic / 🟡 threshold.
- **P52 goes high but nothing else happens** → fault is downstream (Step 5).

**Step 5 — Main-rail switch.**
With P52 high, verify **Q4** turns on and the **Q5/Q22** bank passes **PWR_IN_10v5**. A failed Q4 / R2
(470k) / Q5 / Q22 leaves the rail off despite a good enable.

**Step 6 — The J5↔J3 connector.**
Re-seat it; check continuity of P52, P53, GND and PWR/PNET pins. A dirty or cracked board-to-board
connector breaks the enable or sense path and mimics a dead board.

### 14.2 Partial power / powers then dies / no display

| Symptom | Likely area | Checks |
|---|---|---|
| Main rail comes up then **drops after ~1 s** | U54 latch not holding, or U6 read a fault and ran power-down (`$D05B`) | Scope **P52** — if it pulses high then low, U6 aborted. Check **AN4/VREF** and battery current sense; check **U54 (74HC74)** `1D/1Q/PRE#`. |
| Runs on **adapter only**, not battery | Battery path | **F5**, **U13 (J421)**, shunt **R7/R8**, battery contacts; U6 sees "battery absent/low". |
| Runs on **battery only**, not adapter | Adapter / dock input | `Dock_PWR_IN−`, dock/adapter steering diodes (D2/D4/D7/D8 area), bus OR-ing. |
| Powers up but **no display** | LCD bias | **F65_ENAVEE (J3-35/J5-26)** should go high; check the **VEE** generator and **EN_LCD_VAA** (Pluto pin 83). |
| **Garbled Japanese text** (ASCII OK) | Font ROM | Suspect **U36 (OKI MSM538032E)** or its decode — not a total video fault. |
| Powers up, **won't talk / hangs early** | Handshake | Activity on **P2.0/P2.1**; UART on U6 port **P4**. No handshake → system-controller side (Bowman). |
| **No sound** | Audio decode/DMA | Check `FCS_RESET` (U58/U69) to U4 pin 39, `Pluto_ESS_AEN` (Pluto pin 79), `Bowman_ESS_DACK1#` (U4 pin 36) before condemning U4; for FM-only loss check YM3812 (U10) and `YMF_CS#_Buf`. |
| **Won't charge / bad gauge** | Current sensing | **R7/R8 shunt**, PSU op-amps (7064 U6A–D / U7A), AN0/AN1/AN3; VREF. |
| **No floppy** (with dock) | Split Pluto/Bowman FDC | Dock `CN2` lines; Pluto pins 68–71 + 58; Bowman floppy IRQ/DMA (`FINTR`/`FDRQ`/`DACK#`). |
| **Serial port dead** (dock) | RS-232 enable | Pluto **pin 77 `EN_RS232`** must be asserted; check dock drivers U3/LT1237/U1. |
| **RAM mis-sized** | Module ID straps | Pluto pins 31/32 (`RAM_ID0/1`); confirm module R1/R2 0 Ω links and mainboard pull-ups. |
| **Random no-boot, intermittent** | Connector / standby | Re-seat **J5/J3**; verify the standby rail is solid under load. |

### 14.3 Fault-isolation flow (quick mental map)

```
   Power button pressed
          │
   U6 VCC present? ──no──► standby regulator / F5 / source  (§14.1 step 1)
          │yes
   U6 clocked & in STOP? ──no──► crystal / U6 dead          (§14.1 step 2)
          │yes
   P5.1/INT3 moves on press? ──no──► button / trace         (§14.1 step 3)
          │yes
   P52 goes high? ──no──► A-D gate: VREF, AN4, sense op-amps (§14.1 step 4)
          │yes
   PWR_IN_10v5 on? ──no──► Q4 / R2 / Q5 / Q22 switch bank    (§14.1 step 5)
          │yes
   Stays on >1 s? ──no──► U54 latch / U6 abort (AN4,current) (§14.2)
          │yes
   System boots / handshake on P2.0/P2.1? ──no──► Bowman side
          │yes
   Display? Audio? Floppy? Serial? ──► peripheral tables (§14.2)
```

---

## 15. Quick test-point reference

| Test point | Where | Expect | Confidence |
|---|---|---|---|
| **F5** (2.5 A) | battery current path | continuity; **check first** | ✅ |
| **U6 VCC / standby** | mainboard U6 supply | live even when "off" | ⚠️ |
| **U6 P5.1 / INT3** | mainboard (power button) | edge on button press | ✅ |
| **M38_P52** | J3-18 / J5-18 | low→**high** to turn on | ✅ |
| **M38_P53** | J3-38 / J5-23 | driven high with P52 | ✅ |
| **PWR_IN_10v5** | after Q4/Q5/Q22 | ~10.5 V when on | ✅ |
| **5 V** | downstream rail | 5 V when on | 🟡 |
| **VREF** | J3-30 / J5-31 | steady A-D reference | ✅ |
| **AN4 / P64** | J3-27 / J5-34 | ≈ Vbus/4 (~3.5 V at 10.5 V) | ✅ |
| **P2.0 / P2.1** | J3-19,39 / J5-19,22 | toggling handshake when booting | ✅ |
| **F65_ENAVEE** | J3-35 / J5-26 | high at display-on | 🟡 |
| **U54 (74HC74)** | mainboard | power-state latch holds 1Q | 🟡 |
| **FCS_RESET** | U58 → U4 pin 39 | released (high) for audio | ✅ |

---

## 16. Firmware anchors (for deep debug)

Addresses in the **U6 power-sense MCU** (M38223E4HP) ROM, mapped at `0xC000`:

| Anchor | Address | Meaning |
|---|---|---|
| Reset / entry | `$C046` | `SEI; jsr $CC5E …`; A-D-ready wait at `$C055` (`bbc 3,ADCON`) ✅ |
| STOP / sleep | `$CD00` | `STP; bra $CD00`; deep-sleep setup at `$D0D6` (masks IRQs, arms ICON2 b3/b4) ✅ |
| Power **ON** | `$D056` | `seb 2,P5; seb 3,P5` → P52/P53 high ✅ |
| Power **OFF** | `$D05B` | `… clb 2,P5; clb 3,P5` → P52/P53 low ✅ |
| Wake-reason classify | `$CCFC / $CD03 / $CD0D` | read P5.1/INT3 + P7 ✅ |
| A-D scan / channel select | `$D74F` | `sta ADCON`; reads `$D5FD–$D831` ✅ |
| P2.0/P2.1 handshake + `0x5A` sync | `$CAD3`, `$C983–$CBF2` | request/acknowledge state machine ✅ |
| Vector table | `0xFF5A–0xFF7D` | 16 little-endian pointers; CPU reset/IRQ vectors at `0xFFDC–0xFFFF` **missing from dump** ✅ |

SFR map used (standard 740 layout, confirmed against the 3822-group datasheet): `P2`=0x04, `P5`=0x0A,
`ADCON`=0x34, `AD`=0x35, `ICON1/2`=0x3E/0x3F. Disassembly via `m740dasm` (ROM based at 0xC000, entry
0xC046, vectors at 0xFF5A) → `PSU-MB-M38/disasm_full.asm`.

> Some firmware paths run through indirect jump tables a static trace can't fully follow; the control
> flow documented here reflects the routines that *were* decoded.

---

## 17. Glossary

- **740 core / MELPS 740** — Mitsubishi's 8-bit CPU core, 6502-compatible with added bit-manipulation
  (`SEB`/`CLB`/`BBS`/`BBC`), `MUL`, and low-power `STP`/`WIT` instructions. Used by both the power MCU
  (M38223) and the keyboard MCU (M38813).
- **AudioDrive** — ESS Technology's family of single-chip ISA sound controllers (here, the ES488F).
- **Bowman** — schematic code-name for the custom RIOS system-controller ASIC (U21 / U60).
- **DBCS / SBCS** — double-byte / single-byte character set (Japanese vs. ASCII+katakana), as stored in
  the font ROM.
- **DOS/V** — IBM's PC-DOS variant that renders Japanese on standard VGA hardware in software.
- **J5 / J3** — the 40-pin board-to-board connector joining mainboard (J5) and PSU board (J3).
- **JRC 7064** — the quad op-amp (PSU-board "U6") forming the battery sense front-end.
- **Pluto** — schematic code-name for the custom RIOS peripheral I/O gate array (U35).
- **PWR_IN_10v5** — the ~10.5 V main pre-regulation bus, switched on by U6 via P52.
- **RIOS Systems Co., Ltd.** — Japanese design house behind the PC110's custom silicon and firmware.
- **STOP / STP** — the 740's deepest sleep (oscillator off); how U6 idles while the machine is "off".
- **VEE** — the negative LCD bias rail, enabled by `F65_ENAVEE`.

---

## 18. Sources & credits

This manual is a synthesis of the Open-Source-PC110 reverse-engineering project's per-subsystem analyses
(the `readme.md` files under each subfolder), firmware disassemblies, and ROM dumps, cross-checked against
public references.

**Primary (project) sources**

- Open-Source-PC110 — GitHub: https://github.com/ahmadexp/Open-Source-PC110
- KiCad schematic recreations: `PC110.kicad_sch` / `Mainboard.pdf`, `DockingStation.kicad_sch`,
  `Modem.kicad_sch`, `RAM-Module.kicad_sch` (recreated by Ahmad Byagowi).
- Firmware/ROM dumps: U6 power MCU `M38223E4HP` ("POWER SENSE MICON Rev 8", RIOS 1995); keyboard MCU
  `M38813E4HP@QFP64.bin` (RIOS KBC firmware v1.1, MD5 `835fc971bf700ddcc834ef5ba904aaa2`); font ROM
  `MSM538032E@SOP44.BIN` (IBM P/N 84G7940, 1995).
- In-repo analyses: `Power-Sequence/readme.md`, `PSU-MB-M38/readme.md`, `Pluto/readme.md`,
  `Bowman/readme.md`, `ES488/readme.md`, `Debug/readme.md` (+ `pc110_debug_pod.c`).

**Public references**

- Hackaday — *Reverse Engineering The IBM PC110, One PCB At A Time*:
  https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/
- *Archaeology of the IBM PC110* — VCFMW20 talk: https://www.youtube.com/watch?v=8Uja7g9hQlo
- ThinkWiki — PC110: https://www.thinkwiki.org/wiki/PC110
- Wikipedia — IBM Palm Top PC 110: https://en.wikipedia.org/wiki/IBM_Palm_Top_PC_110
- ESS AudioDrive ES1868 data sheet (family reference), bitsavers.org:
  https://bitsavers.org/components/ess/ESS_ES1868_Data_Sheet_1996.pdf

**Methods & caveats**

Schematic pins were read from vector PDFs (text + high-DPI render). Net connectivity for the PSU analog
front end was reconstructed with a union-find pass over wire segments honouring junction dots. Firmware
was disassembled with `m740dasm` (U6) and a stock-6502 decoder (KBC — note the 740-opcode desync). Custom
ASIC pin *functions* are inferred from board wiring, not manufacturer datasheets (none exist publicly).
Items marked 🟡 / ⚠️ should be confirmed against a known-good unit before relying on them for repair.

*End of manual — revision 1.0.*
