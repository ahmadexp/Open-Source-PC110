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
| 31 | RAM_ID0 | RAM_ID0 (RAM size/type strap) |
| 32 | RAM_ID1 | RAM_ID1 |
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

**Net-up takeaways for Pluto:** it is confirmed as the machine's **floppy controller + serial/dock power manager + modem control-bus master**, not just a generic bus buffer. The dock and modem are essentially extensions of Pluto's I/O fan-out.

## 7. Open questions / things still to confirm

- Exact pin *names* for pins 50, 55–57, 74 are placeholders from the reverse-engineering effort, not confirmed silicon function.
- **Pin 75 label `NM192_VSDA` should almost certainly read `MN195_VSDA`** (the modem chip is the MN195001) — a likely schematic typo now caught by the cross-check.
- The register map (what each `SD`/`SA` access actually does inside Pluto) is not derivable from the schematic alone — it needs bus-trace capture or BIOS disassembly.
- The external flip-flop network (FF_* pins) implements some timed/latched behaviour; worth a dedicated sub-sheet diagram.
- The floppy split between Pluto and "Bowman" (`FDD_Bowman`) is worth mapping precisely — which drive signals each ASIC owns.
- Cross-checking against the X-ray die shots in the repo could confirm the true package (pin 1 location, die size) and internal block count.

---

## 8. Sources

- Schematic: `PC110.kicad_sch` (this file), extracted pin-by-pin.
- [Open-Source-PC110 — GitHub repo](https://github.com/ahmadexp/Open-Source-PC110)
- [Hackaday: Reverse Engineering The IBM PC110, One PCB At A Time](https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/)
- [Archaeology of the IBM PC110 — VCFMW20 talk](https://www.youtube.com/watch?v=8Uja7g9hQlo)
