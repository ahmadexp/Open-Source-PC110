# IBM PC110 — U6 Power-Sense MCU & the J5 / J3 Inter-Board Connector

*Reverse-engineering of the firmware of U6 (Mitsubishi M38223E4HP) together with the
Mainboard (J5) and PSU daughter-board (J3) schematics.*

---

## 1. Executive summary

- **U6 is a Mitsubishi M38223E4HP** — an 8-bit, 740-core single-chip micro (3822 group,
  80-pin QFP), running as the machine's **power-management / power-sense controller**.
- Its ROM contains the banner **`M3822X POWER SENSE MICON FIRMWARE Rev 8 (C) 1995 RIOS SYSTEMS CO.,LTD.`**
  RIOS Systems is the Japanese design house that engineered the PC110 for IBM.
- **J5 (mainboard) and J3 (PSU board) are the same 40-pin board-to-board connector**, mated pin-for-pin.
  They carry three classes of signal between the two boards:
  1. **4 analog sense lines + VREF** going *into* U6's A-D converter (battery / charger sensing),
  2. **4 digital control / handshake lines** between U6 and the system,
  3. **power rails and grounds** (PNET1/4/5, 10.5 V, 5 V, VCC, GND, dock return).
- The "unknown" pins are the `M38_Pxx` nets. Decoded from the firmware + datasheet they are:

  | Net | MCU pin (alt fn) | Direction | Function |
  |-----|------------------|-----------|----------|
  | M38_P60 | P60 / **AN0** | analog in | A-D channel 0 — battery/PSU analog sense (via PSU op-amp U6C) |
  | M38_P61 | P61 / **AN1** | analog in | A-D channel 1 — battery/PSU analog sense (via PSU op-amp U6D) |
  | M38_P63 | P63 / **AN3** | analog in | A-D channel 3 — analog sense (via PSU op-amp U6A, near 5 W shunt) |
  | M38_P64 | P64 / **AN4** | analog in | A-D channel 4 — analog sense (via PSU op-amp U6B) |
  | M38_VREF | VREF | analog ref | A-D converter reference voltage |
  | M38_P52 | P52 / RTP0 | **output** | **Main power enable** — drives Q4 → switches PWR_IN_10v5 rail |
  | M38_P53 | P53 / RTP1 | output | Control output — drives transistor Q31/Q33 ("BLR") |
  | M38_P20 | P20 | I/O (bidir) | Handshake line with the system (read + driven low) |
  | M38_P21 | P21 | output | Handshake / control output (driven high in response) |

---

## 2. The firmware (U6 = M38223E4HP)

### 2.1 Identity & part
- **Core:** Mitsubishi 740 family (6502-compatible + bit instructions SEB/CLB/BBS/BBC, MUL, STP/WIT).
- **Group:** 3822 — LCD drive controller, **8-channel 8-bit A-D**, serial I/O, 3×8-bit + 2×16-bit timers,
  17 interrupt sources / 16 vectors. Package 80-pin QFP (matches `@QFP80`).
- The pin names on the schematic (`M38_P60` = port P6 bit 0, etc.) map exactly to the datasheet's
  alternate-function pins (`P60/AN0 … P67/AN7`, `VREF`, `P52/RTP0`, `P53/RTP1`, `P20–P27`).

### 2.2 ROM image & memory map
- Dump size **16 254 bytes (0x3F7E)**. The ROM is mapped at the **top of the address space**:
  base **0xC000**, i.e. file offset *N* = address 0xC000 + *N*. (Confirmed by internal JMP/JSR
  targets such as `JMP $C0EB`, `JMP $CD17`.)
- Layout:
  - `0xC000–0xC045` : ASCII copyright banner.
  - `0xC046` : **reset / start of code** (`78` = SEI).
  - `0xC046–0xE8FB` : program code (~10.4 KB used).
  - `0xE8FC–0xFF59` : **blank** (0xFF, unprogrammed EPROM).
  - `0xFF5A–0xFF7D` : **interrupt vector table** (16 little-endian pointers; unused entries → `$E8FC`).
  - `0xFF7E–0xFFFF` : **missing from this dump** (130 bytes were truncated — this is the CPU's
    hardware reset/IRQ vector area at 0xFFDC–0xFFFF; not present in the supplied file).

### 2.3 What the firmware does
A classic battery/power state-machine:
- **Initialises ports** (table-driven direction/pull-up setup), clears interrupt
  controllers, configures the A-D.
- **Main loop** repeatedly polls the **A-D converter** (`bbc 3,ADCON` = wait for the
  conversion-complete flag, `lda AD` = read the 8-bit result) and dispatches to handlers based on
  RAM state flags (heavy use of `seb`/`clb`/`bbs`/`bbc` on bit-flag bytes at 0x44, 0x50, 0x51, 0x80,
  0x95, 0xBF …).
- **A-D sensing** is the heart of the "power sense" job: it digitises the four analog lines that come
  across the connector from the PSU board's op-amp front-end.
- **Low-power modes:** three `stp` (STOP — oscillator off, deepest sleep/suspend) entry points and
  several `wit` (WAIT — CPU clock halted) instances. Before `stp` it masks interrupts and re-enables
  only the wake sources (`seb 3,ICON2`, `seb 4,ICON2`), so the system can be woken from suspend.
- **Serial I/O (SIO1):** the MCU also uses its UART (`sta TB_RB` to transmit, `bbc 6,TB_RB` to test
  receive) — but the serial pins are on **port P4**, which is *not* on J5/J3, so that link runs to a
  chip on the mainboard, not across this connector.
- **P2.0/P2.1 handshake:** the firmware reads `P2.0` as an input request, validates a sync value
  (`cmp #0x5A`), then drives `P2.0` low and `P2.1` high to acknowledge — a simple two-wire
  request/acknowledge handshake with the system across the connector.

---

## 3. The J5 / J3 connector

### 3.1 Numbering note (important)
J5 and J3 are the **same 40-pin connector mated together**, but the two schematics number the
**second row differently**:
- Pins **1–20** (first row): **identical** numbering on both boards.
- Pins **21–40** (second row): J3 counts **top→bottom 21→40**, J5 counts **top→bottom 40→21**.
- So a second-row signal has **J5 pin = 61 − (J3 pin)**. (e.g. P63 = J3-21 = J5-40.)

The net **names** are the ground truth and match across the gap, so the table below is keyed by the
physical signal. J3 (PSU side) labels every pin and is used as the authoritative net name.

### 3.2 Full reconciled pin map

| J3 pin | J5 pin | Net (PSU side) | Class | Function |
|:--:|:--:|---|---|---|
| 1  | 1  | M38_P60 / AN0 | **MCU analog** | A-D ch0 sense (PSU op-amp U6C output) |
| 2  | 2  | M38_P61 / AN1 | **MCU analog** | A-D ch1 sense (PSU op-amp U6D output) |
| 3  | 3  | PNET4 | power | inter-board power net |
| 4  | 4  | PNET4 | power | inter-board power net |
| 5  | 5  | GND  (J5: Dock_PWR_IN−) | power | ground / dock-power return |
| 6  | 6  | J5_6 | spare | generic pass-through (no dedicated PSU function) |
| 7  | 7  | GND  (J5: YellowWire2_3, no-connect) | power | ground / rework ("yellow") wire |
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
| 18 | 18 | M38_P52 / RTP0 | **MCU digital out** | **Main power enable** → Q4 → PWR_IN_10v5 |
| 19 | 19 | M38_P20 | **MCU digital I/O** | request/handshake line (bidirectional) |
| 20 | 20 | R412_1 | component | resistor net |
| 21 | 40 | M38_P63 / AN3 | **MCU analog** | A-D ch3 sense (PSU op-amp U6A; near 5 W shunt) |
| 22 | 39 | Q49_1 | component | transistor net |
| 23 | 38 | PNET4 | power | inter-board power net |
| 24 | 37 | GND | power | ground |
| 25 | 36 | GND | power | ground |
| 26 | 35 | D2_3 | component | diode net |
| 27 | 34 | M38_P64 / AN4 | **MCU analog** | A-D ch4 sense (PSU op-amp U6B output) |
| 28 | 33 | PNET1 | power | inter-board power net |
| 29 | 32 | GND | power | ground |
| 30 | 31 | M38_VREF | **MCU analog ref** | A-D reference voltage |
| 31 | 30 | PNET5 | power | inter-board power net |
| 32 | 29 | GND | power | ground |
| 33 | 28 | J5_33 | spare | generic pass-through |
| 34 | 27 | U21_131 | logic | control/status to system controller U21 |
| 35 | 26 | F65_ENAVEE | logic | **Enable VEE** (LCD negative-bias supply enable) |
| 36 | 25 | U54_1Q | logic | 74HC74 Q-output (power-state latch) |
| 37 | 24 | GND | power | ground |
| 38 | 23 | M38_P53 / RTP1 | **MCU digital out** | control output → Q31/Q33 ("BLR") |
| 39 | 22 | M38_P21 | **MCU digital out** | handshake / control output |
| 40 | 21 | D18_2_3 | component | diode net |

*(Pins 5/7/16/17 carry slightly different local names on the J5 side; the J3 names are used above as
they are fully labelled. All `M38_*` MCU pins are cross-confirmed identical on both boards.)*

---

## 4. The PSU analog front-end (what the sense pins actually measure)

On the PSU board the four analog pins originate at a **quad op-amp, U6 = "7064"** (note: this is the
PSU board's own U6, *not* the MCU). Each op-amp channel conditions a battery/charger signal and feeds
it across the connector to a different A-D channel of the MCU:

- **AN0 (P60) ← U6C pin 8** — buffer/divider near the **Main Battery (JX1)** input (R63 10k, R49 300k, R62 200k).
- **AN1 (P61) ← U6D pin 14** — second battery-rail divider/buffer (R69 200k, R64 10k, R89 1M, R22 100k).
- **AN3 (P63) ← U6A pin 1** — sense amp near a **5 W power element ("5W01")** ⇒ most likely a **current shunt** (charge/discharge current).
- **AN4 (P64) ← U6B pin 7** — divider/buffer (R78 300k, R77 100k, R53 300k, R54 100k) ⇒ a higher-voltage rail (adapter/charger input).

The large 300k/100k/200k divider ratios are consistent with **voltage scaling** (battery / adapter
voltages divided down into the 0–VREF A-D window); the 5 W element on AN3 points to **current**
sensing. Exact physical assignment (which is main-battery V, backup/bridge V, adapter V, current)
would require fully tracing the PSU analog nets, but the *category* — battery/charger voltage &
current monitoring — is unambiguous.

**Signal direction:** Battery/shunt (PSU) → PSU op-amps (U6 7064) → J3 → J5 → MCU A-D inputs.
The MCU (mainboard U6) reaches across the connector to read the PSU's conditioned analog signals,
then makes power-management decisions and drives **P52 (main power enable)**, **P53**, and the
**P20/P21 handshake** back across the connector.

---

## 5. Method & caveats
- Disassembly: `m740dasm` (Mitsubishi 740 core) with a custom loader (ROM based at 0xC000, entry
  0xC046, vector table at 0xFF5A). Output: `disasm_full.asm`.
- SFR map used: standard 740 layout (P2=0x04, P5=0x0A, ADCON=0x34, AD=0x35, ICON1/2=0x3E/0x3F),
  confirmed against the Renesas/Mitsubishi 3822-group datasheet.
- The CPU hardware vector table (0xFFDC–0xFFFF) is **absent** from the supplied dump (last 130 bytes
  truncated); reset/IRQ entry was recovered from code structure instead.
- Schematic pin reading is from the vector PDFs (text + high-DPI render). Component-reference nets
  (Dxx_y, Qxx_y, Rxx_y) are named after the part pin they attach to and were not each traced to a
  function; the MCU, power, and control nets — the subject of the question — were.
