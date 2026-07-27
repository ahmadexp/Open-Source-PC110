# Docking Station (`PCB/DockingStation/`)

The **PC110 Docking Station** — the desktop port-replicator the palmtop drops into. It takes the machine's high-density dock/expansion bus and fans it out to full-size, EMI-filtered rear-panel ports (VGA, parallel, floppy, serial, dual PS/2) while accepting and conditioning external DC power that is passed back to the palmtop.

**Sources:** `PCB/DockingStation/DockingStation.kicad_sch`, `DockingStation_Schematic.pdf`, `Fab/DockingStation.kicad_pcb_bom.csv`, `README.md`. Board is KiCad 9, A1, single sheet, **4-layer** (Top / GND / Power / Bottom), "Recreated by: Ahmad Byagowi." Tags **[C]** confirmed / **[H]** inferred (per-pin numbers on J1–J4 were read from the PDF render — net labels are authoritative, pin numbers **[H]**).

## 1. What it is / architecture — overwhelmingly passive

A **passive, EMI-filtered port replicator plus a passively-conditioned power pass-through.** Only three active devices exist, and only one handles a signal path that genuinely needs conversion:

| Active part | Ref | Role |
|---|---|---|
| DS14C535MSA RS-232 transceiver | **U3** | Level-translates the palmtop's TTL UART ↔ RS-232 for the DE-9 (the only true active signal conversion) |
| 74VHCT244 octal buffer | **U1** | Buffers the VGA sync lines (`VGA_Hsync`/`VGA_Vsync`); powered from `DS_VCC` |
| NPN "8C" | **Q2** | Generates the dock/power-present sense (`M38_P46_PC110`) fed back to the palmtop's M38 controller |

Everything else — VGA RGB, the entire parallel port, the entire floppy port, both PS/2 ports — is **pure passive filtering**: a series **680 nH** ferrite bead + shunt-cap π/LC filter on every line, with ESD/TVS clamps and pull-ups. No data mux, no bus switch, no MCU, no voltage regulator IC.

- **Signal path:** dock bus (J1–J4) → per-line 680 nH bead + shunt cap (+ optional 10 Ω series / 0 Ω jumper) → rear port. Serial additionally through U3; VGA sync through U1.
- **Power path:** barrel jack CN8 → fuses (F1 + SSFC) → common-mode choke L68 → TVS/reverse-polarity clamp (ZD1 + Q1) → Schottkys D2/D3 → `PWR_IN+_D` back to the palmtop via J4; return `PWR_IN−` via J1. Q2/ZD4 derive power-present sense.

## 2. Host dock connector (J1–J4)

The host interface is the **PC110 dock connector**: **four 25-pin, 0.5 mm-pitch horizontal banks** — J1, J2, J3, J4, value `25-1MP_P0.5mm_Horizontal`, footprint `25-1MP_P0.5mm_Horizontal_PC110_dock` (100 contacts). Pin numbering runs 25→1.

**J1** — video / power return / mainboard refs
| Pin | Net | Pin | Net |
|--:|---|--:|---|
| 22/21/20 | **PWR_IN−** (3 pins bridged) | 11 | VGA_BLUE |
| 18 | MN195_S11 | 10 | VGA_GREEN |
| 15 | M38_P67_PC110 | 8 | VGA_RED |
| 6 | FDC_ACK# | 5 | FDC_INIT# |
| 3 | FDC_AUTOFD# | 2 | FDC_SLCTIIN# |
| 25,17,16,14,13 | MN195_VPDA# / MN195_ADCK# / MN195_IRQ1# / M38_P16_PC110 / R269_1_PC110 — *NC flags; mainboard cross-refs* | | |

**J2** — parallel status / serial handshake / floppy
| Pin | Net | Pin | Net |
|--:|---|--:|---|
| 25 | PD6 | 24 | FDC_ERROR# |
| 23 | FDC_PE | 22 | EN_RS232 |
| 21 | PNET2 | 20 | RI2# |
| 19 | CTS2# | 18 | RTS2# |
| 17 | DSR2# | 15 | KB_INIT3 |
| 14 | KB_INIT4 | 13 | FDD_PWR |
| 11 | FDD_Bowman | 10 | FDC_RDATA# |
| 9 | FDD_Pluto4 | 8 | FDC_WGATE# |
| 7 | FDC_STEP# | 6 | FDC_Pluto3 |
| 5 | FDC_DRATE0# | 4 | FDC_Pluto2 |
| 3 | FDC_Pluto1 | 2 | Pluto_Dock2 |
| 1 | GND (via R80 0 Ω) | | |

**J3** — parallel data / serial data / floppy control
| Pin | Net | Pin | Net |
|--:|---|--:|---|
| 25 | PD5 | 24 | PD7 |
| 23 | FDC_SLCT | 22 | FDC_BUSY |
| 21 | PNET2 | 20 | DTR2# |
| 19 | TXD2 | 18 | RXD2 |
| 17 | FDC_DCD2# | 16 | PNET5_Q1 |
| 15 | KB_INIT2 | 14 | KB_INIT1 |
| 13 | FDD_PWR | 12 | FDC_DSKCHG# |
| 11 | FDC_HDSEL# | 10 | FDC_WRTPRT# |
| 9 | FDC_TRK0 | 8 | FDC_WDATA# |
| 7 | FDC_DIR# | 6 | FDD_MOTEN |
| 5 | FDD_DRSEL | 4 | FDC_INDEX# |
| 3 | FDC_DRATE1# | 2 | Pluto_Dock1 |
| 1 | GND (via R70 0 Ω) | | |

**J4** — power in / video sync / parallel data / mainboard refs
| Pin | Net | Pin | Net |
|--:|---|--:|---|
| 22/21/20 | **PWR_IN+_D** (3 pins bridged) | 17 | Modem_RSRVD1 |
| 16 | Modem_RSRVD2 | 15 | PNET5 |
| 11 | VGA_Hsync | 8 | VGA_Vsync |
| 6 | FDC_STROBE# | 5 | PD0 |
| 4 | PD1 | 3 | PD2 |
| 2 | PD3 | 1 | PD4 |
| 25,18,13,10,9,7 | J13_49 / J13_43 / J13_37 / J13_35 / J13_34 / J13_32 `_PC110` — *NC flags; mainboard cross-refs* | | |

**Reading the labels:** the palmtop muxes its parallel port with the floppy controller ("Pluto"/"Bowman"), so many `FDC_*` names are actually **parallel-port** control lines (SLCT, PE, BUSY, ACK, INIT, SLCTIN, AUTOFD, STROBE, ERROR); `FDD_*` and `FDC_RDATA#/WDATA#/STEP#/…` are the true floppy signals. Pins carrying `MN195_*`, `M38_*`, `J13_*_PC110`, `R269_1`, `Modem_RSRVD*` are **documentation/pass-through** mainboard cross-refs mostly on KiCad no-connect flags — the dock does nothing active with them. `M38_P46_PC110` (power-present sense from Q2) also routes to J4.

## 3. Rear-panel ports

| Ref | Connector | Port |
|---|---|---|
| **CN8** | Barrel jack | DC power in |
| **CN1** | DSUB-15-HD socket | VGA (RGB passive + buffered sync via U1) |
| **CN4** | DSUB-25 socket | Parallel / LPT (680 nH + 200 pF per line, some 10 Ω series) |
| **CN2** | `FDC_Connector` 26-pin | External floppy (680 nH + 82/280 nF, 47k/470k pull-ups) |
| **CN5** | DSUB-9 pins | RS-232 serial (680 nH + 200 pF → 0 Ω jumpers → U3) |
| **CN6, CN7** | Mini-DIN-6 (PS/2) | Keyboard + mouse (`KB_INIT1..4`; 680 nH signal, 300 nH power) |

## 4. Key components (from `Fab/DockingStation.kicad_pcb_bom.csv`)

| Ref(s) | Value / Part | Function |
|---|---|---|
| **U3** | DS14C535MSA (SSOP-28) | RS-232 transceiver (5 drv / 5 rcv) → DE-9 |
| **U1** | 74VHCT244 (SSOP-20) | Octal buffer → VGA sync |
| U2 | **DNP** LT1237CS | Alternative RS-232 driver (not fitted) |
| U4 | **DNP** 74AHC1G14 | Schmitt inverter (not fitted) |
| L11–L67 (×51) | **680 nH** (0805) | Series EMI bead on signal lines |
| L1–L3, L34, L37, L38 (×6) | **300 nH** (0805) | Series bead on PS/2 `PNET5_Q1` power |
| **L68** | `Device:Filter_EMI_CommonMode` | Common-mode choke, power input |
| Q1 | "3P4J" (TO-252-2) | Series power-path device, drawn as thermistor — likely PTC/inrush or clamp [H] |
| Q2 | "8C" NPN (SOT-323) | Power-present sense → `M38_P46_PC110` |
| D2, D3 | Schottky (2010) | Power-path rectifiers / OR-ing |
| ZD1 / ZD4 | 18 V / 5.1 V zener | TVS clamp power-in / sense rail |
| DA1–DA8 | dual-series diodes (SOT-323) | ESD clamp arrays on port lines |
| F1 / SSFC | THT fuse / SMD fuse | Power-input over-current protection |
| R1–R4 | 33 Ω | VGA RGB series |
| R12–R28 | 10 Ω | Series damping on parallel/floppy |
| R5,R7,R8,R39,R52–R59,R68–R75 | 0 Ω | Serial-routing jumper links (select U3 path) |

## 5. Recreation notes

- **Transceiver is a build option.** Stuff **either** the fitted **DS14C535 (U3)** path (selected by 0 Ω links R68–R75 etc.) **or** the **LT1237 (U2)** path (its own DNP links R60–R67 + `LT_*` nets) — never both.
- **Heavy DNP set** (~35 parts: U2, U4, DA9/DA11/DA12, C68–C74, C83, R10/R11/R29/R40–R51/R60–R67, RA7/RA8) — optional/alternative filter+protection footprints; leaving them empty is the default populated config.
- **EMI parts dominate:** 51× 680 nH + 6× 300 nH beads + L68 choke + hundreds of shunt caps form per-line π filters; substitute only with equal/better ratings — the bead value and shunt caps set emissions compliance.
- **Keep the power chain intact** (CN8 → F1/SSFC → L68 → ZD1/Q1 → D2/D3) — it is the only thing between a wall adapter and the palmtop.
- **Q1 identity uncertain** — TO-252-2 marked "3P4J" drawn as a thermistor; confirm PTC vs MOSFET vs TVS against a real board [H].
- **Dock-connector pin map:** trust the labeled J1–J4 nets for the active ports; treat `MN195_*`, `M38_*`, `J13_*_PC110`, `R269_1`, `Modem_RSRVD*` as pass-through/no-connect. Re-derive exact pin numbers from `DockingStation.kicad_sch` before fab (labels authoritative; numbers here read from the PDF render [H]).
