# RAM Module — 16 MB DRAM Expansion (`PCB/RAM-16MB/`)

**Sources:** `PCB/RAM-16MB/RAM-Module_Schematic.pdf` · `RAM-Module.kicad_sch` · `Fab/RAM-Module.kicad_pcb_bom.csv` · `Fab/RAM-Module.kicad_pcb_netlist.ipc` (IPC‑D‑356, authoritative for pin↔net). Cross‑ref: `Discovery/Pluto/readme.md` §6b (RAM‑ID). Tags: **[C]** confirmed from netlist/schematic, **[H]** inferred.

## 1. What the board is

The PC110's proprietary **16 MB RAM expansion module** — a small 4‑layer daughtercard that plugs onto the mainboard via a single fine‑pitch board‑to‑board connector (`J15`) and hangs eight DRAMs directly on the CPU/chipset DRAM bus. It is **passive memory only**: no buffers, no PLD, no controller. All RAS/CAS/address multiplexing is done by the mainboard chipset (VL82C‑class); the module just presents the DRAM array plus two identity straps that let firmware (via Pluto) size it.

**Board (`README.md`):** 41.46 × 41.60 mm, 0.6 mm thick, 4 layers — `FC` (top) / `IP1` power / `IP2` ground / `BC` (bottom). SMD‑only, 0 through‑hole.

**BOM (`Fab/…_bom.csv`):**

| Qty | Ref | Value / MPN | Package | Role |
|---|---|---|---|---|
| 8 | U1–U8 | `51W17800TT6` (sym. `HM51W1788`) | SOJ‑28, 1.27 mm pitch | DRAM |
| 1 | J15 | "RAM Module" connector | 64‑pad SMD, dual‑row fine pitch | host interface |
| 10 | C1–C10 | 100 nF | 0805 | VCC decoupling |
| 2 | R1, R2 | 0 Ω | 0805 | RAM‑ID straps |

## 2. DRAM devices → how 16 MB is built

Eight identical DRAMs, symbol `HM51W1788` / BOM MPN `51W17800TT6`, in **SOJ‑28**. Each device is an **×8, 16 Mbit (2M × 8)** DRAM **[C, from pinout]** — a Hitachi `HM51(W)17800`‑class part; the `W` suffix and the mainboard's EDO DRAM (`M5M4V16160B`) point to an **EDO / hyper‑page‑mode** device **[H]**.

Per‑chip signals (from the symbol/netlist): Address `A0–A11` (12), Data `DQ0–DQ7` (8), `RAS#`/`CAS#`/`WE#`/`OE#`, `VCC`/`GND`.

**Capacity math:** 8 × 16 Mbit = 128 Mbit = **16 MB [C]** (each ×8 device: 2¹² row × 2⁹ col = 2M × 8 = 2 MB).

## 3. Bank / organization

The 16 MB is presented as **two 32‑bit‑wide banks of 2M × 32 (8 MB each)**, selected by the two RAS lines (from `Fab/…_netlist.ipc`):

| Bank | RAS (J15) | Chips | Data |
|---|---|---|---|
| A | `RAS2` (pin 11) | U5, U6, U7, U8 | `CPU_D0–D31` |
| B | `RAS3` (pin 49) | U1, U2, U3, U4 | `CPU_D0–D31` |

Within each bank, four ×8 devices form the 32‑bit word, gated by **four byte‑lane CAS strobes** (each CAS fans out to one chip per bank):

| CAS strobe (J15) | Byte lane | Chips |
|---|---|---|
| `LCASU#` (12) | `D0–D7` | U1, U5 |
| `UCASU#` (13) | `D8–D15` | U3, U7 |
| `LCASL#` (48) | `D16–D23` | U2, U6 |
| `UCASL#` (47) | `D24–D31` | U4, U8 |

`RAM_A0–A11`, `WE#`, and `CPU_D0–D31` are **bussed to all eight chips**; RAS picks the bank, CAS picks the byte lane. (The `L/U` CAS naming is the mainboard's; the empirical CAS→byte map is from the netlist — the exact upper/lower semantics are the chipset's **[H]**.)

**OE# / termination:** every DRAM's `OE#` (pin 22) is **tied to GND on‑module** — output permanently enabled, direction governed by `WE#`/`CAS#` **[C]**; `OE#` is not brought out to J15. Decoupling is 10 × 100 nF (C1–C10) on `VCC` (`PNET1`); no other termination.

## 4. Host connector `J15` — full pinout

64‑position fine‑pitch SMD board‑to‑board (dual row 1–30 / 31–60); **pins 61–64 N/C**. From `Fab/…_netlist.ipc` (`PNET1` = module `VCC`, likely 3.3 V **[H]**):

| Pin | Net | Pin | Net | Pin | Net | Pin | Net |
|--:|---|--:|---|--:|---|--:|---|
| 1 | CPU_D0 | 17 | RAM_A0 | 33 | CPU_D25 | 49 | **RAS3** |
| 2 | CPU_D1 | 18 | RAM_A1 | 34 | CPU_D26 | 50 | **WE#** |
| 3 | CPU_D2 | 19 | RAM_A2 | 35 | CPU_D27 | 51 | CPU_D8 |
| 4 | CPU_D3 | 20 | RAM_A3 | 36 | GND | 52 | CPU_D9 |
| 5 | VCC | 21 | VCC | 37 | CPU_D28 | 53 | CPU_D10 |
| 6 | CPU_D4 | 22 | CPU_D16 | 38 | CPU_D29 | 54 | CPU_D11 |
| 7 | CPU_D5 | 23 | CPU_D17 | 39 | CPU_D30 | 55 | GND |
| 8 | CPU_D6 | 24 | CPU_D18 | 40 | CPU_D31 | 56 | CPU_D12 |
| 9 | CPU_D7 | 25 | CPU_D19 | 41 | RAM_A4 | 57 | CPU_D13 |
| 10 | GND | 26 | GND | 42 | RAM_A5 | 58 | CPU_D14 |
| 11 | **RAS2** | 27 | CPU_D20 | 43 | RAM_A6 | 59 | CPU_D15 |
| 12 | **LCASU#** | 28 | CPU_D21 | 44 | RAM_A7 | 60 | **RAM_ID0** |
| 13 | **UCASU#** | 29 | CPU_D22 | 45 | RAM_A8 | 61 | N/C |
| 14 | VCC | 30 | CPU_D23 | 46 | RAM_A9 | 62 | N/C |
| 15 | RAM_A11 | 31 | **RAM_ID1** | 47 | **UCASL#** | 63 | N/C |
| 16 | RAM_A10 | 32 | CPU_D24 | 48 | **LCASL#** | 64 | N/C |

**Groups:** 32 data · 12 address · 2 RAS · 4 CAS · 1 WE# · 2 ID · 3 VCC + 4 GND · 4 N/C. No `OE#`, no parity — a **non‑parity, chipset‑multiplexed** interface.

## 5. RAM_ID strap encoding (size signaling to Pluto)

The module encodes its size with two identity pins read by **Pluto** (U35 pins **31 = `RAM_ID1`**, **32 = `RAM_ID0`**; see `Discovery/Pluto/readme.md` §6b). Verified from the IPC netlist:

| Strap | J15 pin | On‑module wiring | Level |
|---|---|---|---|
| `RAM_ID0` | 60 | `R1` 0 Ω → GND (`R1‑1`=RAM_ID0, `R1‑2`=GND) | **0** |
| `RAM_ID1` | 31 | `R2` 0 Ω → GND (`R2‑2`=RAM_ID1, `R2‑1`=GND) | **0** |

So this **16 MB module presents `ID[1:0] = 00`** **[C]**. Both straps are 0 Ω links to ground; populating/omitting R1/R2 sets each bit, and — with mainboard pull‑ups — an **absent module reads `11`** (per Pluto §6b). Pluto samples the two bits so BIOS can size installed RAM; the IDs touch **only** Pluto, while DRAM RAS/CAS/address muxing is the chipset's job.

> Which of the other three codes (`01`/`10`/`11`) maps to which capacity is not derivable from this board alone — needs a second module or the BIOS RAM‑sizing routine. **[H]**

## 6. Recreation notes

- **DRAM:** any pin‑compatible **2M × 8 / 16 Mbit** DRAM in **SOJ‑28** (`HM51(W)17800`‑class); use **EDO** to match the mainboard's `M5M4V16160B` timing **[H]**. Eight required.
- **Topology is fixed by nets:** two banks (`RAS2`←U5–U8, `RAS3`←U1–U4); byte lanes `LCASU#`=D0‑7, `UCASU#`=D8‑15, `LCASL#`=D16‑23, `UCASL#`=D24‑31; `RAM_A0–A11`, `WE#`, `CPU_D0–31` bussed to all eight. Tie **every `OE#` (pin 22) to GND**.
- **ID straps:** fit `R1` (ID0→GND) and `R2` (ID1→GND) as 0 Ω to declare 16 MB (`ID=00`); change these to emulate other sizes once the ID→size table is known.
- **Decoupling:** 10 × 100 nF 0805 on VCC.
- **Connector:** 64‑pos fine‑pitch SMD board‑to‑board (60 used + 61–64 N/C); the mechanical mate to the mainboard's RAM socket is the critical unknown for a physical rebuild (measure the original). **[H]** exact connector part.
- **Verify `PNET1` voltage** (3.3 V vs 5 V) against the mainboard rail before building — assumed 3.3 V. **[H]**
