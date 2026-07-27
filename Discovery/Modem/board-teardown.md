# PC110 Modem — Board-Level Teardown (PCB companion)

*A physical, component-level companion to [`readme.md`](readme.md), which traces the modem's signal path to the docking station. That document covers the MN195001's fax-engine pins and the dock connector; this one documents the **modem PCB itself** — the parts placed, the two memory chips, the DAA/telephone-line front end, and the handset/answering audio path.*

**Sources:** `PCB/Modem/Modem-Schematic.pdf` (fuller capture) / `Modem_Schematic.pdf`; `Modem.kicad_sch`; BOM `Fab/Modem.kicad_pcb_bom.csv`; IPC‑D‑356 netlist `Fab/Modem.kicad_pcb_netlist.ipc` (exact pin→net). Board title: *"PC110 Internal Modem Module."* Tags **[C]** confirmed / **[H]** inferred.

## 1. What the board is

A single ~64.6 × 58.9 mm 6‑layer module — the PC110's **internal data/fax modem**, plus the analog hardware for the machine's **built-in telephone / answering‑machine** feature. It plugs into the motherboard through one 26‑pin connector (**CNP4 "Modem‑Connector"**, the module side of the motherboard's **J8**) and terminates the phone line at its own **RJ11 jack (CNP1 "Tel Line")**. ~211 components, essentially all SMD.

```
                       CNP4 (26-pin host / J8)          CNP1 (RJ11 phone line)
                                 │                              │
   host COM2 serial ─────────────┤                        ┌─────┴─────┐  telephone-line
   + dock spare lines            │                        │  DAA /    │  front end
   ┌──────────────┐   mem bus ┌──┴──────────┐  Line-Module│  line I/F │ (T1,VA1,RL1,
   │ IC11 flash   │◄─────────►│  IC5         │◄──IC3──────►│  PC2,     │  bridges)
   │ IC12 SRAM    │  A0-18/D0-7│  MN195001   │  connector  └─────┬─────┘
   └──────────────┘           │ fax/modem DSP│                   │
                              └──────┬───────┘            IC8 TA31033F audio
                                     │                    → CNP2/CNP3 headset, CNP5 speaker
```

## 2. Architecture — controller + datapump + memory + DAA

The controller + datapump are fused into the single **MN195001 fax engine (IC5)** (see `readme.md` §2 for the on‑chip block breakdown). What the *board* adds:

| Function | Realized by | Notes |
|---|---|---|
| Modem controller + DSP datapump | **IC5 MN195001** | 128‑pin QFP; no on‑chip program store |
| Program store (firmware) | **IC11 EN29F040A** | 512 KB NOR flash — "RIOS Ver 1.04" (`readme.md` §10) |
| Working RAM | **IC12 KM681000BLT‑7** | 128K×8 (1 Mbit) fast SRAM |
| Master clock | **OSC1 41.472 MHz** | sole oscillator |
| Reset / supervisor | **IC18 (3L01)** → `MN195_HDRES#` (IC5 pin 12) | **[H]** |
| Line interface (DAA) | T1, VA1, RL1, PC2, D1/D7/D9, DA1 | via **IC3 "Line Module"** connector |
| Telephone/handset audio | **IC8 TA31033F** + CNP2/CNP3/CNP5 | earpiece/mic/speaker, answering‑machine **[H]** |

### 2.1 External memory bus (new detail)
IC11 (flash) and IC12 (SRAM) share an 8‑bit data bus + address bus off the MN195001's external memory interface: address `29F_A0…A18` (flash A0–18 = 512 KB, SRAM A0–16 = 128 KB); data `29F_DQ0…DQ7`; strobes `29F_OE#`/`29F_WE#`; chip selects `29F_CE#`→IC11 (via R101), `68_CS1#`→IC12 (via R112), from the MN195001's `UC00`/`UC01` outputs. Reset net `MN195_HDRES#` = {IC5 pin 12, IC18 pin 1, R51}.

## 3. Main components (from `Fab/Modem.kicad_pcb_bom.csv`)

| Ref | Part / Value | Package | Role |
|---|---|---|---|
| **IC5** | MN195001 | QFP‑128 | Fax/modem engine (controller + DSP datapump) |
| **IC11** | EN29F040A | TSOP‑32 | 512 KB NOR flash — firmware "RIOS Ver 1.04" |
| **IC12** | KM681000BLT‑7 | TSOP‑32 | 128K×8 (1 Mbit) SRAM |
| **IC8** | TA31033F | SOIC‑16 | Handset/speech audio amplifier **[H]** |
| IC10 | AT32 (74×32) | TSSOP‑14 | Quad OR — line‑control / pulse‑dial gating |
| IC2/7/9/13/14/16/4/6 | single‑gate logic | SOT‑353 | buffers/inverters in ring‑detect & enable chains |
| IC18 | "3L01" | TSOT‑23‑5 | reset / supervisor → `HDRES#` **[H]** |
| **OSC1** | 41.472 MHz | 4‑pin SMD | modem master/sample clock |
| **T1** | Iso Transformer | — | telephone‑line isolation/coupling |
| **VA1** | Varistor | 2512 | tip–ring surge clamp |
| **RL1** | Relay | 8‑pin | line‑seize / off‑hook |
| **PC2** | TLP124 | opto | ring‑detect isolation |
| D1/D7/D9 | TO‑269AA arrays | — | line polarity‑guard / bridge & protection |
| DA1 | "M1T" | — | DAA line coupling **[H]** |
| CNP1 | Line_Connector | RJ11 | telephone line jack |
| CNP4 | Modem‑Connector | 26‑pin | host interface (= motherboard J8) |
| CNP2/CNP3 | headset jack / JST‑8 | — | handset (earpiece + mic) |
| CNP5 | JST‑2 | — | answering‑machine / call‑progress speaker |

## 4. Host interface — CNP4 (26‑pin) = module side of motherboard J8

Exact pinout from `Fab/…_netlist.ipc` (matches `readme.md` §3 pin‑for‑pin):

| Pin | Net | Meaning | Pin | Net | Meaning |
|--:|---|---|--:|---|---|
| 1,13,14,26 | GND | ground | 14 | (GND) | |
| 2,25 | VCC_PC110 | power | 3 | MN195_U1RD#_R | USART RX |
| 4 | FDC_DCD1 | carrier detect | 5 | FDC_RI1 | ring indicator |
| 6 | DC_DIR1# | DTR1# | 7 | FDC_DSR1 | DSR1 |
| 8 | FDC_CTS1# | CTS1# | 9 | DC_RTS1# | RTS1# |
| 10 | FDC_RXD1 | RXD1 (rx) | 11 | FDC_TXD1 | TXD1 (tx) |
| 12,15 | _ENABLED_PNET5 | Pluto power/enable | 16 | MN195_VSEN# | scanner enable → dock |
| 17 | MN195_VSDA# | scanner data → dock | 18 | MN195_VPCK# | plotter clock |
| 19 | MN195_VPDA# | plotter data → dock | 20 | MN195_IRQ1# | ext interrupt → dock |
| 21 | MN195_ADCK# | eye‑pattern clk → dock | 22 | **MN192_S11_BUF** | GPIO S11, buffered by Q4 |
| 23 | J13_41 | → dock J13 pin 41 | 24 | J13_42 | → dock J13 pin 42 |

- The serial group carries `FDC_*`/`DC_*` prefixes — the modem's DTE channel is the motherboard's second UART, i.e. **COM2 (0x2F8)**, routed through the FDC/serial block (physical confirmation of "modem uses COM2").
- Pin 22's net `MN192_S11_BUF` vs pin 16 `MN195_VSEN#` — the **MN192/MN195 naming inconsistency** flagged in `readme.md` §9; S11 is buffered through transistor Q4.

## 5. Phone‑line / DAA side (new)

The line front end reaches the MN195001 only through the **IC3 "Line Module"** connector — never the digital bus. From the netlist:

- **Line entry/protection:** CNP1 (RJ11) pin 1 `TEL_LINE` → **L1 (1.2 µH)** → net = {D1‑4, D9‑4, D7‑4, **VA1** (surge clamp), **T1**}; the TO‑269AA arrays (D1/D7/D9) form the polarity‑guard/bridge. The other leg goes through the **line‑seize relay RL1**, R75, L2.
- **Isolation/coupling:** **T1 (IsoTransformer)** couples line↔modem; **PC2 (TLP124)** isolates **ring detection**, feeding buffer chain IC2→IC7→IC9 → `MN195_S3#`. **DA1 (M1T)** + C70–C74 + IC17 form the TX/RX hybrid. **[H]** exact DA1 function.
- **Off‑hook / power control:** **`_ENABLED_PNET5`** is the master enable from **Pluto** — net = {RL1‑1 coil, buffer enable pins, PC2‑2, CNP4‑12/15, …}. Asserting it powers the front‑end, energizes the relay (off‑hook), and lights the ring opto. This is the switch that connects the modem to the line.

**IC3 "Line Module" connector (18 pins):** brings out the MN195001's analog front end — `RXL`, `TXOUT`, `TXLPIN`, `HPOUT`, `SHIN`, `AGCIN/AGCOUT`, `HVDD`, `PLSD` (pulse dial), `S1/S4` — terminated by the T1/VA1/RL1/PC2/DA1 DAA network.

### 5.1 Telephone / answering‑machine audio (separate path)
Distinct from the modem DAA, **IC8 (TA31033F)** is the **handset speech/audio amplifier** for the built‑in telephone + answering‑machine. Its I/O fans out to **CNP3 (JST‑8 headset)**, filter L/C, bias Q9, **CNP2** headset jack, **CNP5** speaker, **SW2** mode switch — realizing the earpiece/mic and the "canned ROM voice / wake‑on‑ring" answering‑machine behavior (`readme.md` §8) through IC8's audio path rather than the datapump. **[H]** TA31033F exact part.

## 6. Recreation notes

- **The MN195001 needs an external boot flash** (IC11 EN29F040A, RIOS Ver 1.04); without a valid image it does nothing. IC12 (KM681000) is the working SRAM. Both share A0–18 / D0–7 with `OE#`/`WE#` and two chip selects from IC5 `UC00`/`UC01`.
- **Clock = a single 41.472 MHz can (OSC1)** — preserve this reference.
- **The DAA is fully discrete** (T1 + VA1 + RL1 + TLP124 + D1/D7/D9 + DA1), gated on by the Pluto `_ENABLED_PNET5` line — not a packaged DAA module. Line compliance = reproducing this network.
- **Two interfaces define the board:** CNP4 (26‑pin host/J8) and CNP1 (RJ11 line). CNP2/CNP3/CNP5 are the optional telephone‑audio path (IC8) and can be omitted for data/fax‑only.
- **Naming caveat:** several nets use `MN192_*` where the silicon is the **MN195001** — treat `MN192_*` and `MN195_*` as the same device (`readme.md` §9).

*All connectivity taken directly from `Fab/Modem.kicad_pcb_netlist.ipc`; uncertain small‑signal part functions (IC8, IC15, IC18, DA1) tagged **[H]**.*
