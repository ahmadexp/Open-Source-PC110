# U35 — "Pluto" Gate Array

**Source:** `PC110.kicad_sch` (KiCad EDA R6.0) — *PC110 Motherboard*, "Recreated by: Ahmad"
**Project:** [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110) — reverse-engineering documentation of the IBM PalmTop PC110
**Reference designator:** U35  **Value/name:** Pluto  **Pin count:** 100 (QFP-style)

---

## 1. What U35 is

U35 ("Pluto") is one of the **custom IBM gate-array ASICs** in the PC110. The PC110 was built around a BGA-packaged 486SX-33 plus a handful of undocumented custom LSIs that IBM gave informal code names (Pluto, Bowman, Rios, etc.). There are no public datasheets for these parts — their behaviour is being reconstructed from optical/X-ray scans and net tracing, which is exactly what this schematic represents.

Functionally, Pluto is the **system I/O glue / peripheral controller**. It hangs off the ISA-style local bus (8-bit data `SD0–SD7`, address `SA0–SA15`, `IOR#`, `IOW#`, `AEN`) and fans that bus out to the laptop's subsystems: keyboard controller, floppy, PCMCIA/CompactFlash card detect, IrDA, RS-232, the LCD/power-management rails, docking detect, the modem, and the external BIOS flash. It also drives/receives several lines through **external 74-series flip-flops** rather than handling them all internally.

> Note: pin *names* below are the symbol labels in the schematic; some are best-guesses from the reverse-engineering effort (e.g. `Pluto_50`, `Pluto_55..57`, `PNET7_SENSE`) and are not yet functionally confirmed.

---

## 2. Package & power

100 pins total. Power and unused pins:

| Function | Pins |
|---|---|
| **VCC** (7) | 7, 14, 38, 64, 88, 95, 97 |
| **GND** (5) | 4, 13, 37, 63, 87 |
| **NC / unused** (14) | 47, 49, 59, 80, 82, 84, 85, 91, 92, 94, 96, 98, 99, 100 |

**Decoupling** (clustered directly above U35 on VCC):
C111 (1 nF), C117 (100 nF), C280 (100 nF), C78 (1 nF), C71 (1 nF), C74 (180 nF).

---

## 3. Bus interface (left side)

| Signal | Pins |
|---|---|
| Data bus `SD0–SD7` | 33, 34, 35, 36, 39, 40, 41, 42 |
| Address bus `SA0–SA15` | 8, 9, 10, 11, 12, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 |
| `AEN` (address enable) | 6 |
| `IOR#` (I/O read) | 86 |
| `IOW#` (I/O write) | 89 |

The address bus arrives via `Device_Address_BUS` (`SA[0..15]`); the data bus via `Device_Data_BUS` (`SD[0..15]`). Note address pins skip 13/14 (GND/VCC) and data pins skip 37/38 (GND/VCC), which is why the numbering has gaps.

---

## 4. Functional / peripheral pins

### Keyboard & speaker
| Pin | Pin name | Net | Goes to |
|---|---|---|---|
| 30 | PS2_IO | PS2_L1_Pluto | PS/2 line (near R228) |
| 43 | KB_SPKDN | KB_SPKDN | speaker down |
| 44 | KB_SPKUP | KB_SPKUP | speaker up |
| 60 | KB_CCS | KBCCS# | keyboard-controller chip select |
| 61 | KB_CNTR# | KB_CNTR# | keyboard control |
| 66 | KB_RESET# | KB_RESET# | keyboard reset |

### CPU / clock / power
| Pin | Pin name | Net | Notes |
|---|---|---|---|
| 62 | CPU_STPCLK# | CPU_STPCLK# | CPU stop-clock (power mgmt) |
| 65 | CLK | Pluto_CLK | clock in (near R348) |
| 67 | PWRGD | PWRGD | power-good (near R104) |
| 50 | PWR_ON_SENSE | Pluto_50 | power-on sense (near R276) |

### Floppy (FDD)
| Pin | Pin name | Net |
|---|---|---|
| 68 | FDD_IO1 | FDD_Pluto1 |
| 69 | FDD_IO2 | FDD_Pluto2 |
| 70 | FDD_IO3 | FDD_Pluto3 |
| 71 | FDD_IO4 | FDD_Pluto4 |
| 58 | Pluto_IOW | FDC_IOW (to U23) |

### External flip-flop / latch logic
Pluto offloads some latching to discrete 74-series flip-flops (e.g. U30, U40, U45, U53). These pins are the interface to that logic.

| Pin | Pin name | Net | Goes to |
|---|---|---|---|
| 1 | FF_D0 | U30_D0 | flip-flop U30 (near R90) |
| 2 | FF_2D | — | flip-flop data |
| 3 | FF_2CLK | — | flip-flop clock |
| 45 | FF_1CLK | — | flip-flop clock |
| 46 | FF_1A | — | |
| 78 | FF_1A | — | |
| 72 | FF_1Q | Pluto_72 | near D30 |
| 73 | FF_2Q | Pluto_73 | near D31 |
| 90 | FF_2Q# | — | |

### PCMCIA / CompactFlash & docking
| Pin | Pin name | Net | Goes to |
|---|---|---|---|
| 26 | CF_CD2 | CF_CD2_Pluto | CF card detect 2 (R361) |
| 27 | CF_CD1 | CF_CD1_Pluto | CF card detect 1 (R361) |
| 28 | Dock_Detect1 | Pluto_Dock_IO1 | dock detect (R139) |
| 29 | Dock_Detect2 | Pluto_Dock_IO2 | dock detect (R139) |

### Serial / IrDA / modem
| Pin | Pin name | Net | Goes to |
|---|---|---|---|
| 77 | EN_RS232 | EN_RS232 | RS-232 transceiver enable (drives Q38; R144) |
| 81 | IRDA_O | Pluto_IRDA_OUT | IrDA transmit (U2B) |
| 48 | IRDA_EN | Pluto_EN_IRDA | IrDA enable (R57) |
| 75 | NM192_VSDA (likely **MN195_VSDA**) | Modem_VSDA# | → internal modem MN195001 codec (see §6.5) |
| 79 | FDC_O | Pluto_ESS_AEN | ESS / audio address enable (U69A) |

### "Bowman" chip interface
| Pin | Pin name | Net | Goes to |
|---|---|---|---|
| 51 | Bowman_IO1 | Pluto_51 | another custom chip "Bowman" (R104) |
| 52 | Bowman_IO2 | Pluto_52 | "Bowman" (R85) |

### BIOS flash control
| Pin | Pin name | Net | Goes to |
|---|---|---|---|
| 53 | BIOS_WR_EN | Pluto_BIOS_WR_EN | BIOS flash write-enable (near D19) |
| 54 | BIOS_SA17 | BIOS_SA17 | BIOS address bit 17 / bank select (R333) |

### LCD / display power
| Pin | Pin name | Net | Goes to |
|---|---|---|---|
| 83 | PSU_IO | EN_LCD_VAA | LCD bias-rail enable (R397) |
| 5 | LCD_IO | LCD_NC_L11 | LCD line (R229) |
| 93 | LCD_IO | LCD_STNDBY | LCD standby; pulled up by R393 (47k) → LCD_STNDBY# |

### Misc / unconfirmed
| Pin | Pin name | Net |
|---|---|---|
| 31 | RAM_ID0 | RAM_ID0 — reads module ID0 strap (J15.60, see §6b) |
| 32 | RAM_ID1 | RAM_ID1 — reads module ID1 strap (J15.31, see §6b) |
| 55 | Pluto_55 | — |
| 56 | Pluto_56 | — |
| 57 | Pluto_57 | — |
| 74 | PNET7_SENSE | — |
| 76 | Dev_OE | device output enable |

---

## 5. Complete pin map (by number)

| # | Name | | # | Name | | # | Name | | # | Name |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | FF_D0 | | 26 | CF_CD2 | | 51 | Bowman_IO1 | | 76 | Dev_OE |
| 2 | FF_2D | | 27 | CF_CD1 | | 52 | Bowman_IO2 | | 77 | EN_RS232 |
| 3 | FF_2CLK | | 28 | Dock_Detect1 | | 53 | BIOS_WR_EN | | 78 | FF_1A |
| 4 | GND | | 29 | Dock_Detect2 | | 54 | BIOS_SA17 | | 79 | FDC_O |
| 5 | LCD_IO | | 30 | PS2_IO | | 55 | Pluto_55 | | 80 | NC |
| 6 | AEN | | 31 | RAM_ID0 | | 56 | Pluto_56 | | 81 | IRDA_O |
| 7 | VCC | | 32 | RAM_ID1 | | 57 | Pluto_57 | | 82 | NC |
| 8 | SA0 | | 33 | SD0 | | 58 | Pluto_IOW | | 83 | PSU_IO |
| 9 | SA1 | | 34 | SD1 | | 59 | NC | | 84 | NC |
| 10 | SA2 | | 35 | SD2 | | 60 | KB_CCS | | 85 | NC |
| 11 | SA3 | | 36 | SD3 | | 61 | KB_CNTR# | | 86 | IOR# |
| 12 | SA4 | | 37 | GND | | 62 | CPU_STPCLK# | | 87 | GND |
| 13 | GND | | 38 | VCC | | 63 | GND | | 88 | VCC |
| 14 | VCC | | 39 | SD4 | | 64 | VCC | | 89 | IOW# |
| 15 | SA5 | | 40 | SD5 | | 65 | CLK | | 90 | FF_2Q# |
| 16 | SA6 | | 41 | SD6 | | 66 | KB_RESET# | | 91 | NC |
| 17 | SA7 | | 42 | SD7 | | 67 | PWRGD | | 92 | NC |
| 18 | SA8 | | 43 | KB_SPKDN | | 68 | FDD_IO1 | | 93 | LCD_IO |
| 19 | SA9 | | 44 | KB_SPKUP | | 69 | FDD_IO2 | | 94 | NC |
| 20 | SA10 | | 45 | FF_1CLK | | 70 | FDD_IO3 | | 95 | VCC |
| 21 | SA11 | | 46 | FF_1A | | 71 | FDD_IO4 | | 96 | NC |
| 22 | SA12 | | 47 | NC | | 72 | FF_1Q | | 97 | VCC |
| 23 | SA13 | | 48 | IRDA_EN | | 73 | FF_2Q | | 98 | NC |
| 24 | SA14 | | 49 | NC | | 74 | PNET7_SENSE | | 99 | NC |
| 25 | SA15 | | 50 | PWR_ON_SENSE | | 75 | NM192_VSDA | | 100 | NC |

---

## 6. Functional summary

Pluto sits between the CPU/chipset local bus and nearly every "slow" peripheral in the machine. Grouping the pins by what they touch:

- **Local bus slave:** `SD0–7`, `SA0–15`, `IOR#`, `IOW#`, `AEN` — the CPU reads/writes Pluto's internal registers and routes I/O through it.
- **Keyboard subsystem:** chip-select, control, reset and the two speaker drive lines to the keyboard controller MCU.
- **Floppy:** four FDD I/O lines plus an FDC write strobe.
- **Removable storage / docking:** CompactFlash card-detect (×2), dock-detect (×2).
- **Comms:** RS-232 enable, IrDA out + enable, modem data line.
- **Display & power management:** CPU stop-clock, power-good, power-on sense, LCD bias enable and LCD standby.
- **BIOS:** write-enable gating and an extra high address bit (`BIOS_SA17`) — i.e. Pluto controls flashing/banking of the BIOS ROM.
- **Inter-ASIC:** dedicated lines to the "Bowman" gate array, and offloaded latching via external 74-series flip-flops (U30/U40/U45/U53).

---

## 6b. Cross-module confirmation (Docking Station + Modem)

Comparing the Pluto nets against `DockingStation.kicad_sch` and `Modem.kicad_sch` confirms several pins whose function was previously a guess, and shows that Pluto reaches well beyond the motherboard.

### Floppy → lives in the Docking Station
Pluto is the **floppy disk controller**, but the drive itself is in the dock. The dock's `CN2 (FDC_Connector)` carries the full classic floppy interface — `FDC_RDATA#`, `FDC_WDATA#`, `FDC_STEP#`, `FDC_DIR#`, `FDC_TRK0`, `FDC_INDEX#`, `FDC_WGATE#`, `FDC_WRTPRT#`, `FDC_DSKCHG#`, `FDD_MOTEN`, `FDD_DRSEL`, `FDC_DRATE0/1#` — and the Pluto-side lines route in as `FDC_Pluto1/2/3` and `FDD_Pluto4`. These correspond to Pluto pins **68–71** (FDD_IO1–4) plus the `FDC_IOW` strobe on **pin 58**. Note the floppy work is **split with the "Bowman" gate array** (`FDD_Bowman` appears alongside the Pluto lines).

### RS-232 enable → drives dock serial transceivers
Pluto **pin 77 `EN_RS232`** appears repeatedly in the dock, where it gates the RS-232 line drivers (`U3 DS14C535MSA`, `LT1237`, and the `74HCT244` buffer `U1`). So this pin powers up / enables the docked serial port (`CN5 Serial Port`) and related level shifters — Pluto controls when the dock's serial I/O is live.

### Dock detect / dock I/O
Pluto **pins 28/29** (`Pluto_Dock_IO1/2`) line up with the dock's `Pluto_Dock1` / `Pluto_Dock2` nets routed to the `J1–J4 Dock Connectors` — the dock-presence / handshake lines.

### Modem → MN195001 codec
Pluto **pin 75** (net `Modem_VSDA#`, symbol label `NM192_VSDA`) connects to the internal modem module. In `Modem.kicad_sch` the main modem chip is the **Panasonic MN195001** DSP/codec (128-pin), with a companion **Line Module 681000**, an **EN29F040A** flash (IC11) and SRAM (IC12). The MN195001 exposes a 4-wire control bus `VSEN# / VSDA# / VPCK# / VPDA#` (Voice Serial Enable/Data/Clock/PData) on connector `CNP4`, and `VSDA#` is the data line Pluto taps. The symbol name `NM192` is almost certainly a transcription of **MN195** — worth renaming in the schematic. The modem also brings out UART-style lines (`U1RD`, `IRQ1#`, `ADCK#`, `DSR1`, `DCD1`, `RI1`) and runs partly on `VCC_STNDBY`.

### RAM module → Pluto reads the module ID straps
Pluto **pins 31/32 (`RAM_ID0` / `RAM_ID1`)** are confirmed by `RAM-Module.kicad_sch` as a **memory-module detect** mechanism. The 16 MB expansion module (connector `J15`, eight `HM51W1788` DRAMs wired 32-bit-wide as `CPU_D0–D31`, with `RAM_A0–A11`, `RAS2/RAS3`, `LCASU#/LCASL#/UCASU#/UCASL#`, `WE#`) brings out two identity pins: `ID0` (J15 pin 60) and `ID1` (J15 pin 31). On this module both are tied **low to GND through 0 Ω jumpers `R1` and `R2`** — i.e. ID = `00`. By populating/omitting those 0 Ω links a module encodes its size/type, and with mainboard pull-ups an *absent* module reads `11`. Pluto samples these two bits so firmware can size installed RAM. (The actual DRAM RAS/CAS/address muxing is done by the chipset, not Pluto — only the ID detect touches U35.)

**Net-up takeaways for Pluto:** it is confirmed as the machine's **floppy controller + serial/dock power manager + modem control-bus master + RAM-module ID reader**, not just a generic bus buffer. The dock, modem and RAM module are essentially extensions of Pluto's I/O fan-out.

## 6c. Keyboard controller firmware — and who built the custom silicon

The other end of Pluto's keyboard interface (pins 60 `KB_CCS`, 61 `KB_CNTR#`, 66 `KB_RESET#`, 43/44 speaker) is the on-board keyboard MCU, **Mitsubishi M38813E4HP** (3813 group, MELPS 740 core — a 6502-compatible 8-bit micro in a QFP-64). Analysis of its mask-ROM dump (`M38813E4HP@QFP64.bin`):

**Headline:** the ROM contains a plain-text banner —

> `MELPS 740 Series Keyboard Firmware Version 1.1  (C) Copyright 1992-1995 RIOS Systems Co.,Ltd.`

This is a concrete attribution. **RIOS Systems Co., Ltd.** (a Japanese design house) wrote the keyboard firmware — and *"Rios"* is one of the very PC110 custom-chip codenames noted in the existing reverse-engineering literature, alongside Pluto and Bowman. That strongly suggests the whole PC110 custom-ASIC + firmware family (Pluto / Bowman / Rios) originated at RIOS Systems, not IBM's own gate-array group. This is the best lead so far on *who* designed Pluto.

**Firmware facts (reliable, read from the image):**

| Item | Value |
|---|---|
| Part | M38813E4HP, MELPS 740 (6502-compatible) |
| Image size | 16,255 bytes, mapped **0xC081–0xFFFF** (16 KB mask ROM, top of 64 K space) |
| MD5 | `835fc971bf700ddcc834ef5ba904aaa2` |
| RESET vector (FFFC) | **0xC208** |
| IRQ/BRK vector (FFFE) | **0xE49E** |
| NMI (FFFA) | 0xE62C (→ an `RTI` stub; most unused sources point here) |
| Active peripheral vectors | FFF0 → 0xC0DB, FFF6 → 0xD088 (two live interrupt sources — likely the host/serial and a timer) |
| Opcode profile | Dominated by `JSR`/`RTS`/`PHA`/`PLA` — classic 740/6502 |

A best-effort disassembly (`kbc_disasm.txt`) is included. **Caveat:** it was produced with a stock-6502 decoder, so it desyncs on 740-only opcodes (e.g. `0x80 = BRA`, the `SEB/CLB/BBS/BBC` bit ops) and shows `.byte` gaps there — an accurate listing needs a 740-aware disassembler. Even so, the MCU clearly works through its zero-page port SFRs (`$00 = P0`, `$04 = P2`, `$06 = P3`, `$08 = P4` …) with state/buffer variables in RAM (`$60–$6A`, and buffers around `$0113`/`$0126`/`$0200–$023C`).

**Relevance to Pluto:** Pluto presents this MCU to the CPU as an 8042-style keyboard controller — Pluto decodes the I/O port, asserts `KB_CCS` (chip select), and exchanges bytes over `SD0–7`, while `KB_CNTR#`/`KB_RESET#` and the IRQ lines handle handshaking. Mapping the firmware's exact host-interface port to Pluto's `KB_*` pins is the natural next step, but needs the M38813 QFP-64 pinout cross-referenced with the mainboard netlist.

## 6c. Live host-register probe (2026) ✅ **[RE]**

Reading Pluto's host-visible I/O directly on a running unit (over [COMrade](../Live-Dump/)) starts to
fill in the "register map" gap. Pluto is the **floppy controller** and owns the PC110-specific I/O
windows; all values below are live reads:

| Ports | Pluto function | Live |
|---|---|---|
| `0x3F0–0x3F7` | **Floppy (FDC)** — Pluto *is* the FDC | `3F2` DOR=`0C` (DMA+IRQ enabled), `3F4` MSR=`80` (RQM ready), `3F7` DIR=`AD` → controller alive |
| `0x3F8–0x3FF` | **COM1 UART** — Pluto gates the RS-232 (pin 77 `EN_RS232`) | `IIR C1` → **16550A, FIFO on**; `MCR 0B` (DTR/RTS/**OUT2**) → OUT2 gates the interrupt, i.e. why **IRQ4 is live** (see [Chipset §13c](../Chipset/)); `MSR BB` → CTS/DSR/DCD all asserted (this is the live COMrade link) |
| `0x1F0–0x1F7` | **ATA/IDE** — internal CompactFlash boot storage | `1F7` status = `0x50` (DRDY, ready, not busy) → drive present; uses **IRQ 14** (enabled in PIC2) |
| `0x3E0 / 0x3E1` | **PCMCIA PCIC** (82365/ExCA-class) | chip ID `0x83`; socket 0 = card present (`0x7D`), socket 1 = empty (`0x33`) — full dump below |
| `0x15E8–0x15EF` | **embedded-controller mailbox** (EC block A) | `+0`(`15E8`)=`64` data, `+4`(`15EC`)=`48` cmd/status, `+6`=`80`, `+7`=`00`; this is the `Zn10`/`Zn00` mailbox, see [ULTRACHG](../ULTRACHG/) |
| `0x35E8–0x35EF` | **indexed register bank** (EC block B) | only `+2`/`+3` active → `35EA`=index, `35EB`=data; a **32-entry** file (idx masked to 5 bits, so `0x20–0x3F` re-reads `0x00–0x1F` byte-for-byte) |

### PCMCIA/CF controller — full PCIC dump (read-only, 2026-07-02)

The card controller presents a standard **82365SL / ExCA** programming model at `0x3E0` (index) /
`0x3E1` (data), two sockets (socket B at index base `+0x40`). (On the schematic recreation this
function is the Ricoh **RB5C396**, which is register-compatible; the real unit reports the same
ExCA interface.) Full live dump:

| Reg | Socket A (0) | Socket B (1) | Meaning |
|---|---|---|---|
| `00` ID/rev | `0x83` | `0x83` | 82365SL-class, revision code `3` |
| `01` iface status | `0x7D` | `0x33` | A: **card present, powered, ready**; B: **empty** |
| `02` power ctrl | `0xF1` | `0x40` | A: **VCC on, outputs enabled**; B: off |
| `03` int/gen ctrl | `0xE9` | `0x00` | A: **I/O card, card-IRQ = 9**, out of reset |
| `04` card-status-change | `0x00` | `0x00` | no pending change events |
| `05` mgmt-int config | `0x00` | `0x00` | — |
| `06` window enable | `0xE0` | `0x20` | A: **two I/O windows enabled**, no memory windows |
| `07` I/O window ctrl | `0x2B` | `0x00` | A: 16-bit / timing for the I/O windows |

Socket A's card is configured as an **I/O card on IRQ 9** with two I/O windows enabled and *no*
memory windows. The IRQ-9 routing here **cross-checks** the chipset's PIC state: IRQ 9 is one of the
enabled lines in PIC2's mask (see [Chipset §13c](../Chipset/)). The window bounds read back as
I/O-win0 `0x0530–0x054F` and I/O-win1 `0x0388–0x038B`; probing those addresses live, `0x530` returns
structured data (`04 04 04 04 13 02 cc 80`) so a real device decodes there, while `0x388` is the
OPL2/FM port. The card's exact identity isn't determinable from the PCIC registers alone.

> **Correction:** this socket A card is **not** the boot storage. The PC110's internal
> CompactFlash/IDE is on the **standard ATA channel** (`0x1F0–0x1F7`, IRQ 14) — probed live, ATA
> status `0x1F7 = 0x50` (DRDY set, not busy) → a drive present and ready, and IRQ 14 is enabled in
> PIC2. So storage = ATA/IRQ14; the PCIC socket A card is a separate I/O device (IRQ 9).

Socket B is idle and unpowered. This is a live, self-consistent picture of the PC110's PCMCIA
subsystem.

### The `0x35EA` bank, characterised (read-only, 2026-07-02)

Writing an index to `0x35EA` then reading `0x35EB` returns values that **vary deterministically by
index** (idx `00→00`, `01→ff`, `02→f5`, `04→84`, `06→6c` …) and are **repeatable** across
snapshots — so this is a genuine index-selected register file, not a floating bus. That last point
is nailed down by a control: three deliberately **undecoded** high ports (`0x2E0`, `0x2E8`, `0x35F8`)
all read `0xFF`, so on this machine "no device" = `0xFF` and every non-`FF` byte above is a real
decode.

Full bank (`idx 0x00–0x1F`, live):

```
00: 00 ff f5 ff 84 f3 6c fd ff f7 ff fc ff ff ff ff
10: ff ff ff e8 35 04 ff ff ff ff ff ff ff ff ff ff
```

Notable: the only populated span in the upper half is idx `0x13/0x14 = e8 35` — the little-endian
word **`0x35E8`** — i.e. the bank stores **its own EC-block base address** (a self-referential I/O
resource descriptor), with `0x15` = `04` (likely a length/count). The sparse, mostly-`FF` layout
built around an embedded I/O-window pointer is characteristic of a **configuration/resource
descriptor** block rather than dense live telemetry — though note this is *not* proven by dynamism:
over a ~2.4 s window neither this bank **nor** the power MCU (`0xEC/0xED`) changed a byte (battery is
on AC at 100 %, so its telemetry is also flat on that timescale).

So Pluto's host side is: the standard **FDC** register file, the **PCIC** PCMCIA controller, and
**two 8-port EC blocks** — block A at `0x15E8` (the live `Zn` command mailbox) and block B at
`0x35E8` (an indexed descriptor bank that names block A's sibling window). The BIOS reaches all of
these through the same helper table as the chipset (`F000:DB60–DC90`; see [Chipset §13a](../Chipset/)).
Assigning a function to each individual non-`FF` `0x35EA` index (which needs safe host-state
correlation, done at a physical console — CPU-speed changes are unsafe over the serial link) is the
remaining step.

## 7. Open questions / things still to confirm

- Exact pin *names* for pins 50, 55–57, 74 are placeholders from the reverse-engineering effort, not confirmed silicon function.
- **Pin 75 label `NM192_VSDA` should almost certainly read `MN195_VSDA`** (the modem chip is the MN195001) — a likely schematic typo now caught by the cross-check.
- The register map (what each `SD`/`SA` access actually does inside Pluto) is not derivable from the schematic alone — it needs bus-trace capture or BIOS disassembly.
- The external flip-flop network (FF_* pins) implements some timed/latched behaviour; worth a dedicated sub-sheet diagram.
- The floppy split between Pluto and "Bowman" (`FDD_Bowman`) is worth mapping precisely — which drive signals each ASIC owns.
- Cross-checking against the X-ray die shots in the repo could confirm the true package (pin 1 location, die size) and internal block count.
- **Authorship lead:** the KBC firmware is copyright **RIOS Systems Co., Ltd. (1992–1995)**; since "Rios" is also a custom-chip codename, it's worth confirming whether RIOS Systems designed Pluto/Bowman/Rios as a set.
- Re-run the KBC disassembly with a **740-aware** disassembler (BRA, SEB/CLB/BBS/BBC) for an accurate listing, then map the host-interface port to Pluto's `KB_CCS`/`KB_CNTR#`/`SD` lines.

---

## 8. Sources

- Schematic: `PC110.kicad_sch` (this file), extracted pin-by-pin.
- [Open-Source-PC110 — GitHub repo](https://github.com/ahmadexp/Open-Source-PC110)
- [Hackaday: Reverse Engineering The IBM PC110, One PCB At A Time](https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/)
- [Archaeology of the IBM PC110 — VCFMW20 talk](https://www.youtube.com/watch?v=8Uja7g9hQlo)
