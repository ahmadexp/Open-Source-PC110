# The PC110 Modem: From the MN195001 to the Docking Station

*An analysis of how the internal fax/modem module connects through the motherboard to the docking station, what the "extra" pins on that path actually are, and — new in this revision — what the IC11 firmware ROM dump reveals about the chip.*

Sources: `Modem.kicad_sch` (Modem.pdf), `PC110 Motherboard` (Mainboard.pdf), `DockingStation.kicad_sch` (DockingStation.pdf), the **MN195001 Single-Chip Fax Engine LSI** datasheet (Matsushita/Panasonic), and the **IC11 firmware ROM dump** (`EN29F040A@TSOP32.BIN`, 512 KB).

> **Board-level companion:** [`board-teardown.md`](board-teardown.md) documents the modem **PCB itself** — the memory bus (IC11 flash + IC12 SRAM), the discrete DAA/telephone-line front end, the handset/answering-machine audio path (IC8), and the exact CNP4 (26-pin host) pinout from the fab netlist.

---

## 1. Summary

The PC110's internal modem is built around a single chip, the **MN195001** — which is not a plain modem but a complete **single-chip fax engine**: a DSP modem core *plus* an on-chip fax-machine peripheral controller (document scanner, thermal print head, paper-feed motors, and a diagnostic eye-pattern monitor).

In the PC110 the chip is used **only as a data/fax modem over the telephone line**. None of the fax mechanical peripherals exist in the machine, so a large block of the chip's pins is idle. IBM brought a handful of those idle/auxiliary lines — plus two reserved connector pins — out through the motherboard to the **docking-station connector**.

These are the "extra pins": signals that have nothing to do with normal modem operation and instead expose spare fax-engine I/O, an interrupt, and a diagnostic clock at the dock.

The full path is:

```
MN195001 chip  →  J8 "Modem-Connector" (motherboard)  →  J13 Docking Station Connector  →  J1–J4 Dock Connectors (docking station)
```

The MN195001 has no internal program store — it boots from an external parallel flash. On this board that flash is **IC11**, and its dump is analyzed in **Section 10**. The firmware is a third-party product, **"RIOS Ver 1.04" by RIOS SYSTEMS Co.,Ltd.**, and it carries an internal `PANASONIC MN195001` chip-ID string — independent confirmation that the dump belongs to the MN195001.

---

## 2. The MN195001 — a fax engine, not just a modem

From the datasheet overview:

> *"The MN195001 reduces to a single chip CPU functions related to facsimile control, peripheral device control functions, and modem functions. The last include complete fax/modem support for the ITU-T G3 recommendations V.29, V.27ter, and V.21 Channels 1 and 2."*

It is a 128-pin QFP (QFH128-P-1818) organized into these functional blocks:

| Block | What it does | Used in PC110? |
|---|---|---|
| Digital signal processor (DSP) + CPU core | Runs the modem/fax algorithms | **Yes** — the modem |
| Analog front-end (AFP) | Line interface: A/D, D/A, filters, AGC | **Yes** — phone line |
| DTE interface (USART + 8-bit I/O) | Serial link to the host | **Yes** — host serial |
| Memory interface | External ROM/RAM bus (A0–23, MD0–7) | **Yes** — firmware ROM (**IC11**) |
| **Facsimile peripheral controller** | Scanner, plotter/thermal head, motors | **No mechanism present** |
| **Eye-pattern monitor (EYE I/F)** | Modem constellation diagnostics | Exposed, not used |

The blocks the PC110 *doesn't* use are precisely where the "extra" dock pins come from. The "Memory interface" row is what the IC11 flash hangs off — see Section 10.

### 2.1 Relevant pin groups (from the datasheet)

**Fax peripheral control signals** — the document path of a fax machine:

| Symbol | Pin | I/O | Function |
|---|---|---|---|
| VPST | 86 | O | Plotter data clock |
| VPCK | 87 | O | Plotter synchronization burst clock |
| **VPDA** | **88** | **O** | **Plotter data** (thermal print-head data) |
| V8CK | 94 | O | Scanner clock |
| VSCK | 95 | I | Scanner data input clock |
| VSDA | 96 | I | Scanner data |
| VIR | 97 | O | Scanner input ready |
| VSEN | 98 | I | Scanner data input enable |
| SH1–4 | 85–82 | O | Thermal head control |
| MTA1–4 | 92–89 | O | Motor A control |
| MTB1–4 | 81–78 | O | Motor B control |
| MOT | 93 | O | Motor synchronization |

> **Correction to an earlier reading:** the `V*` prefix here means *video/fax document path* (scanner + plotter), **not** "voice codec." There is no voice/audio function on these pins.

**Eye-pattern monitor (EYE I/F)** — modem signal-quality diagnostics:

| Symbol | Pin | I/O | Function |
|---|---|---|---|
| **ADCK** | **21** | **O** | Eye pattern data clock |
| EYSY | 22 | O | Eye pattern data synchronization |
| EQMD | 20 | O | Eye pattern data |

**General-purpose I/O and interrupts:**

| Symbol | Pin | I/O | Function |
|---|---|---|---|
| S0–S15 | 46–61 | I/O | General-purpose I/O port (**S11 = pin 57**) |
| **IRQ1**–4 | **67**–70 | I | External interrupts |

**Analog line interface (the actual modem)** — for completeness: TXOUT (34), RXL (32), RXLPIN (30), HPOUT (29), AGCIN/AGCOUT (28/27), SHIN (26), VREFH/L (40/41), IREF0–2, HVDD (33). These stay on the modem module and connect to the telephone line via the isolation transformer.

---

## 3. Stage 1 — Modem module → J8 "Modem-Connector"

The modem module plugs into a 26-pin connector, **J8 "Modem-Connector"**, on the motherboard. Its pins split cleanly into two groups.

### 3.1 Normal modem interface (right side of J8)

These are the standard host-facing signals the system needs to operate the modem — the USART/RS-232 serial channel and the telephone-line handshake lines:

| J8 pin | Signal | Motherboard net |
|---|---|---|
| 3 | U1RD# | MN195_U1RD# |
| 4 | DCD1# | FDC_DCD1 |
| 5 | RI1# | FDC_RI1 |
| 6 | DTR1# | — |
| 7 | DSR1 | FDC_DSR… |
| 8 | CTS1# | FDC_CTS1 |
| 9 | RTS1# | — |
| 10 | RXD1 | FDC_RXD |
| 11 | TXD1 | — |
| 2, 25 | VCC | — |
| 1, 13, 14, 26 | GND | — |

### 3.2 The "extra" group (left side of J8)

These are fax-peripheral, diagnostic, GPIO, interrupt and reserved lines — **not** needed for modem operation:

| J8 pin | Signal | MN195001 pin & meaning | Goes to dock? |
|---|---|---|---|
| 23 | RSRVD1 | Reserved (connector pin) | **Yes** |
| 24 | RSRVD2 | Reserved (connector pin) | **Yes** |
| 22 | S11 | Pin 57 — GPIO | **Yes** |
| 21 | ADCK# | Pin 21 — eye-pattern data clock | **Yes** |
| 20 | IRQ1# | Pin 67 — external interrupt | **Yes** |
| 19 | VPDA# | Pin 88 — plotter (print-head) data | **Yes** |
| 18 | VPCK# | Pin 87 — plotter sync clock | No (local) |
| 17 | VSDA# | Pin 96 — scanner data | No (local) |
| 16 | VSEN# | Pin 98 — scanner enable | No (local) |
| 12, 15 | PNET5_Pluto | Power/net switch | No |

---

## 4. Stage 2 — Motherboard → J13 Docking Station Connector

On the motherboard, six of the J8 "extra" pins are carried across to **J13, the Docking Station Connector**. Confirmed by reading J13 directly in the motherboard schematic:

| Motherboard net | J13 pin |
|---|---|
| Modem_RSRVD2 | 41 |
| Modem_RSRVD1 | 42 |
| Modem_VPDA# | 52 |
| Modem_S11 | 58 |
| Modem_ADCK# | 59 |
| Modem_IRQ1# | 60 |

(For context, neighboring J13 pins carry VGA, keyboard-controller `KB_INIT`/`KB_INT`, floppy `FDD_*`, and `M38_P*` microcontroller lines — the modem signals sit in their own block.)

---

## 5. Stage 3 — J13 → Docking Station

Inside the docking station, the same signals appear on the **Dock Connectors (J1–J4)**, named with the modem/chip prefixes:

- `MN195_S11`
- `MN195_ADCK#`
- `MN195_IRQ1#`
- `MN195_VPDA#`
- `Modem_RSRVD1`
- `Modem_RSRVD2`

This closes the loop: the same six signals leave the chip, cross J8 and J13, and terminate on the dock connectors.

---

## 6. End-to-end signal map

| Signal | MN195001 pin / function | J8 pin | Motherboard net | J13 pin | Dock net |
|---|---|---|---|---|---|
| Reserved 1 | (connector reserved) | 23 | Modem_RSRVD1 | 42 | Modem_RSRVD1 |
| Reserved 2 | (connector reserved) | 24 | Modem_RSRVD2 | 41 | Modem_RSRVD2 |
| GPIO | 57 — S11 (general-purpose I/O) | 22 | Modem_S11 | 58 | MN195_S11 |
| Eye clock | 21 — ADCK (eye-pattern data clock) | 21 | Modem_ADCK# | 59 | MN195_ADCK# |
| Interrupt | 67 — IRQ1 (external interrupt) | 20 | Modem_IRQ1# | 60 | MN195_IRQ1# |
| Plotter data | 88 — VPDA (thermal print-head data) | 19 | Modem_VPDA# | 52 | MN195_VPDA# |

---

## 7. Interpretation — why do these pins exist?

Because the MN195001 is a fax engine, it carries a full set of pins for driving a physical fax machine — a document scanner, a thermal print head, two motor channels, and an eye-pattern diagnostic monitor. The PC110 has **none** of that hardware; it uses the chip strictly as a phone-line data/fax modem.

That leaves those peripheral pins idle. IBM repurposed a small selection of them — a spare GPIO bit (S11), an interrupt (IRQ1), an eye-pattern clock (ADCK), and a plotter-data line (VPDA) — plus two explicitly reserved connector pins, and routed them out to the docking connector.

The most plausible intent is **spare / expansion / diagnostic access** at the dock: extra I/O headroom, a hook for a possible dock-side fax or test fixture, or factory test points — rather than anything the modem requires to function. They are genuinely "extra" in the sense that the modem works completely without them.

---

## 8. Was anything ever built for these pins?

Short answer: **no.** No shipping peripheral — from IBM or any third party — is documented as using the fax-engine peripheral lines (S11, ADCK#, IRQ1#, VPDA#) or the two reserved pins exposed at the dock. A search of English and Japanese sources supports this:

- **The MN195001 is confirmed a Panasonic/Matsushita single-chip fax engine** — a fax-machine controller with built-in scanner, plotter (thermal head), and motor interfaces.
- **In the PC110 it was used only as a telephone-line modem.** Japanese launch coverage and community references all describe the same communication features, and every one runs over the phone line, not over a scanner/printer bus:
  - The internal modem was catalogued as a *"2400/9600 bps data/FAX modem,"* and *"with the right software it functions as a data, voice and FAX modem"* (voice/fax features required add-on software such as PersonaWare).
  - The PC110 could be used as an actual **telephone** — built-in earpiece and microphone on the front, "WingJack" for the phone line — and did answering-machine duty (four canned ROM voice messages, wake-on-ring), again purely over the line.
- **The dock IBM actually shipped added only standard PC ports**: external floppy drive, VGA, PS/2 keyboard and mouse, serial, and parallel. No fax scanner, thermal printer, or any accessory that taps the dock's modem/fax-engine pins is documented.

This matches the schematic evidence: IBM used a fax-machine chip as a plain modem, left the scanner/plotter/motor side idle, and routed a few spare lines plus two reserved pins to the dock connector — but nothing was ever built to use them. They are best understood as **unused spare/expansion/test points**.

---

## 9. Errata noted during the trace

- **`MN192_VSEN#` is a typo.** The modem sheet labels pin 16's net `MN192_VSEN#`, but VSEN is **pin 98 of the MN195001** (confirmed in the datasheet). It should read `MN195_VSEN#`. The chip part number is MN195001 throughout — and the ROM dump's own embedded `PANASONIC MN195001` string (Section 10) settles it.
- The `S0–S15` lines are confirmed **general-purpose I/O**, so routing S11 to the dock is a genuine spare-GPIO use, consistent with the expansion-headroom interpretation.

---

## 10. The IC11 firmware ROM — what the dump reveals

The dump `EN29F040A@TSOP32.BIN` is the contents of **IC11**, the modem module's program flash. The MN195001 has no on-chip program store; it fetches code and data over its external memory bus (the A0–23 / MD0–7 "Memory interface" block of Section 2). IC11 is that store.

### 10.1 The part and the image

| Property | Value |
|---|---|
| Designator | **IC11** (modem module) |
| Device | **EON EN29F040A** — 4 Mbit (512 KB) parallel NOR flash, TSOP-32, 8-bit bus |
| Image size | 524,288 bytes (exactly 512 KB) |
| MD5 | `a9f38ef86fba9d31285308fd71a6072b` |
| SHA-1 | `90f681f2af63310d49cbaa9ec15b3f7965fbe79a` |
| Programmed | ~259 KB of 512 KB (**≈ 49.5 %**); the remainder is erased `0xFF` |

The EN29F040A is a modern, drop-in-compatible replacement for the original Am29F040/equivalent — i.e. the dump comes from a re-flashed or replacement chip in the IC11 socket, not necessarily the factory part, but the firmware image itself is the original.

### 10.2 Identity strings — who wrote it, and for what

Four human-readable strings pin down the firmware's identity:

| File offset | String | Meaning |
|---|---|---|
| `0x00000` | `RIOS Ver 1.04` | Image header / firmware name + version, at the very first byte |
| `0x4A68A` | `RIOS SYSTEMS Co.,Ltd.` | Firmware author / vendor |
| `0x4A6A0` | `PANASONIC MN195001` | Embedded chip-ID — the firmware names its own target silicon |
| `0x7FEE2` | `PROGRAM LOADER  Ver.1.00` | Boot-loader banner (with a duplicate `Ver. 1.04` at `0x6FEF0`) |

So the MN195001 in the PC110 modem runs a third-party firmware product called **RIOS, version 1.04, written by RIOS SYSTEMS Co., Ltd.** The embedded `PANASONIC MN195001` literal is independent, on-chip confirmation that this dump really does belong to the MN195001 (and corroborates the part number throughout this document). Note: public web sources document the MN195001 datasheet but turn up nothing on "RIOS SYSTEMS Co., Ltd." — the attribution rests on the ROM image itself.

### 10.3 Memory map of the image

The flash is sparse — code and data sit in a few islands separated by large erased (`0xFF`) gaps:

| File offset | Size | Contents |
|---|---|---|
| `0x00000`–`0x000FF` | 256 B | Header `RIOS Ver 1.04` (rest of block erased) |
| `0x00100`–`0x1FFFF` | ~128 KB | Erased (`0xFF`) |
| `0x20000`–`0x272FF` | ~29 KB | High-entropy DSP data — modem waveform / symbol tables |
| `0x27300`–`0x2FFFF` | ~36 KB | Erased |
| `0x30000`–`0x66BFF` | ~224 KB | **Main CPU/DSP firmware** — code, strings, per-module version tags |
| `0x66C00`–`0x6E3FF` | ~30 KB | Erased |
| `0x6E400`–`0x6EFFF` | 3 KB | Lookup / scaling tables (linear ramps, gain curves) |
| `0x6F000`–`0x6FDFF` | ~3.5 KB | Erased |
| `0x6FE00`–`0x715FF` | ~6 KB | Boot / banner code + reset-entry code (maps to address `0xFF00xx`) |
| `0x71600`–`0x7FDFF` | ~59 KB | Erased |
| `0x7FE00`–`0x7FFFF` | 512 B | `PROGRAM LOADER Ver.1.00` banner + **CPU vector table** |

### 10.4 CPU, address mapping and boot flow

The firmware is **big-endian**, with a recurring `0xA2` load-immediate-style opcode dominating the byte histogram — consistent with a Panasonic MN-series microcontroller core embedded in the fax engine.

The top 256 bytes (`0x7FF00`–`0x7FFFF`) are a **64-entry interrupt/exception vector table** of 32-bit big-endian pointers into the chip's 24-bit (16 MB) address space:

- The flash is mapped at the **top of the address space, `0xF80000`–`0xFFFFFF`** (the last 512 KB of 16 MB).
- **Reset vector** at `0xFFFFFC` = `0x00FF0001`, which maps to file offset `0x70001` — exactly the boot/banner code that emits the `RIOS` / `Ver. 1.04` strings. (This is the proof of the mapping: the reset target lands precisely on the banner code.)
- **One other live vector** at `0xFFFFD0` = `0x00FF0044` (file `0x70044`) — a single implemented interrupt/trap handler.
- The remaining **62 vectors all point at a self-referential stub address `0x00FEFFxx`** (an erased, unimplemented region) — i.e. they are deliberately parked "do-nothing" placeholders. Only the reset path and one interrupt are actually used.

In short: power-on → reset vector → loader at `0x70001` → prints the RIOS banner → runs the main firmware in the `0x30000` block.

### 10.5 Modular version stamps

The main firmware block is stamped with roughly **eighteen** independent three-character `Ver xx` markers, one per functional sub-module — strong evidence the RIOS firmware is built from many small, separately-versioned DSP/protocol routines (the V.29 / V.27ter / V.21 modulators, demodulators, HDLC framer, tone handling, etc.):

```
F55  V08  R17  V09  T28  Z12  Z08  V14  V20
V06  V19  D28  V05  V04  R29  931n  RRR  JJ2
```

(The recurring `V…` prefix is the most common family; `R`, `F`, `T`, `Z`, `D` prefix other module classes.) These sit alongside the high-entropy waveform tables at `0x20000` and the ramp/gain lookup tables at `0x6E440` — i.e. the actual modulation mathematics for the G3 fax/data modes the datasheet advertises.

### 10.6 What is *not* in the ROM

There are **no ASCII "AT" command strings** anywhere in the image (no `ATDT`, `CONNECT`, `RING`, etc.). The Hayes/AT command interpreter is therefore **not** in this firmware — it lives host-side (in DOS modem software / the BIOS), and this ROM speaks to the host over the MN195001's USART/serial DTE interface in a binary, table-driven protocol. This is consistent with the chip's role: it is the low-level fax/modem signal engine, not the user-facing AT modem personality.

### 10.7 Takeaways for the schematic story

- IC11 being only ~50 % full, with a single live interrupt vector and the bulk of the chip's fax-peripheral firmware paths unused, reinforces Sections 7–8: the silicon is a full fax engine, but this product configuration drives only the phone-line modem. The spare flash capacity and idle peripheral firmware mirror the idle peripheral *pins* routed to the dock.
- The dump independently confirms the **MN195001** part number (settling the `MN192_VSEN#` typo) and adds the firmware provenance — **RIOS Ver 1.04 by RIOS SYSTEMS Co., Ltd.** — that the schematics alone could not give.

---

**Sources:**
- IBM Palm Top PC 110 — Wikipedia: <https://en.wikipedia.org/wiki/IBM_Palm_Top_PC_110>
- 世界最軽量のPC/AT互換機はウルトラマン — マイナビニュース: <https://news.mynavi.jp/article/history-10/>
- Using the internal modem — basterfield.com: <http://www.basterfield.com/pc110/modem.htm>
- MN195001 Datasheet (Single-Chip Fax Engine LSI, Panasonic) — datasheetcatalog: <http://www.datasheetcatalog.com/datasheets_pdf/M/N/1/9/MN195001.shtml>
- Open-Source-PC110 — GitHub: <https://github.com/ahmadexp/Open-Source-PC110>
- IC11 firmware ROM dump — `EN29F040A@TSOP32.BIN` (SHA-1 `90f681f2af63310d49cbaa9ec15b3f7965fbe79a`), analyzed in Section 10.

---

*Recreated schematics by Ahmad Byagowi (KiCad 9.0.0). Datasheet: MN195001 Single-Chip Fax Engine LSI, "For Communications Equipment." ROM analysis: IC11 EN29F040A dump (RIOS Ver 1.04, RIOS SYSTEMS Co., Ltd.).*
