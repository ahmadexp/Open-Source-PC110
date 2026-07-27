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
>
> **Partial answer from the field (taka's 32 MB write‑up, see §7):** his appendix lists the jumper settings observed on real IBM modules — `ID0` fitted / `ID1` open → module built from "16160" (1M×16) chips; `ID0` open / `ID1` fitted → "18160" chips; **both fitted (`00`) → the 16 MB module (KM48V2100C ×8, i.e. 2M×8 — exactly this board)**; both open (`11`) = no module. So `00`=16 MB is confirmed twice over; the two mixed codes are the smaller (4/8 MB) modules, distinguished by chip type. He also notes one report that the 16 MB module "works without the setting" — hinting the BIOS may probe as well as read the ID. **[H]**
>
> **2026‑07‑27 update:** the "works without the setting" hint is now fully explained — the BIOS **sizes memory by hardware probe and never consults the ID straps** (§7.4). The straps go to Pluto pins 31/32 [C], but no readable Pluto register has been found that exposes them (the `0x35EA/EB` reg `0x05` candidate was tested live and falsified, §7.4), so on this BIOS revision they appear to be **wired but unused** — provisioned by IBM, made redundant by the probe.

## 6. Recreation notes

- **DRAM:** any pin‑compatible **2M × 8 / 16 Mbit** DRAM in **SOJ‑28** (`HM51(W)17800`‑class); use **EDO** to match the mainboard's `M5M4V16160B` timing **[H]**. Eight required.
- **Topology is fixed by nets:** two banks (`RAS2`←U5–U8, `RAS3`←U1–U4); byte lanes `LCASU#`=D0‑7, `UCASU#`=D8‑15, `LCASL#`=D16‑23, `UCASL#`=D24‑31; `RAM_A0–A11`, `WE#`, `CPU_D0–31` bussed to all eight. Tie **every `OE#` (pin 22) to GND**.
- **ID straps:** fit `R1` (ID0→GND) and `R2` (ID1→GND) as 0 Ω to declare 16 MB (`ID=00`); change these to emulate other sizes once the ID→size table is known.
- **Decoupling:** 10 × 100 nF 0805 on VCC.
- **Connector:** 64‑pos fine‑pitch SMD board‑to‑board (60 used + 61–64 N/C); the mechanical mate to the mainboard's RAM socket is the critical unknown for a physical rebuild (measure the original). **[H]** exact connector part.
- **Verify `PNET1` voltage** (3.3 V vs 5 V) against the mainboard rail before building — assumed 3.3 V. **[H]**

## 7. Beyond 16 MB — the 32 MB ceiling and the "taka hack"

How far can the PC110's memory go, and why does more than 20 MB need tricks? Combining the mainboard netlist, the VL82C420 RE (`Discovery/Chipset` §7), and the classic Japanese 32 MB upgrade write‑up (taka's "PC110 32Mb Upgrade Hack", mirrored at [web.archive.org — mwillis PC11032M.Htm](https://web.archive.org/web/20010309234321/http://web3.foxinternet.net/mwillis/PC11032M.Htm)):

### 7.1 The bank topology (from the mainboard netlist) **[C]**

| VL82C420 bank | Net | What hangs on it | Size (stock) |
|---|---|---|---|
| RAS0 | `U61_RAM_RAS0` | onboard soldered **U28 + U33** (2× M5M4V16160, 1M×16 EDO → 1M×32) | **4 MB** |
| RAS1 | — | **not connected — the pin has no net on the PC110** | 0 |
| RAS2 | `U61_RAM_RAS2` → J15.11 | module bank A (U5–U8) | 8 MB |
| RAS3 | `U61_RAM_RAS3` → J15.49 | module bank B (U1–U4) | 8 MB |

Stock maximum = 4 + 16 = **20 MB**, with **all usable RAS lines already spoken for** (RAS1 is stranded at the chip). The VL82C420's DRAM controller itself tops out at **32 MB total** (4 banks, `MA0–11`) — the same ceiling MPR and TheRetroWeb quote for SCAMP IV. **[C]**

### 7.2 taka's 32 MB hack (decoded) 

Since RAS2/RAS3 are the only expandable banks, the only way up is **denser banks**: taka rebuilt the module with **64 Mbit 4M×16 parts** (µPD42S65160 FP‑mode preferred; EDO µPD42S65165 works if you feed **`UCAS#` into the DRAM `OE#` pin** — note the stock module simply grounds `OE#`, §3). Two 4M×16 per bank → 4M×32 = **16 MB per RAS bank**, i.e. a 32 MB module → 4 + 16 + 16 = **36 MB physical, which is over the chipset's 32 MB ceiling.**

That is why it cannot just boot — and §7.4 below now pins the mechanism to exact BIOS code:

1. **Cold boot sizes memory by probing** and programs the chipset bank‑geometry registers; with the oversize (36 MB) array present, the destructive top‑down memory *count* walks past the 32 MB ceiling, the wrapped addresses alias low RAM, POST corrupts itself and dies — **warm boot works because the whole sizing+count is skipped/preserved**.
2. taka's fix: an **RC‑delayed OR gate (74AC32 + 0.33 µF + 1 MΩ)** masks the second bank's RAS for the first moments of power‑on, so **cold boot completes seeing 20 MB**;
3. then **`DARK2301.COM 03 DD`** (32 MB) or **`03 CD`** (28 MB) rewrites the DRAM bank‑geometry register — **confirmed: EC/ED window (ports `0xEC`/`0xED`), index `0x03`** (§7.4);
4. **soft reset** → the sizer is skipped, the poked geometry survives, the memory count re‑runs over the newly mapped space and rewrites CMOS `0x30/0x31` — the machine comes up at 28/32 MB with no CMOS hand‑editing.
5. Caveat: at "32 MB" (really 36 MB mapped, wrapping at the ceiling) Windows 3.1/95 **256‑colour modes fail** (16‑colour only) — consistent with the top 4 MB aliasing low RAM **[H]** — so **28 MB (`03 CD`) is the known‑stable setting**.

### 7.4 The BIOS memory‑sizing code, disassembled ✅ **[RE 2026‑07‑27]**

Full trace of `E28F002BXT@TSOP40.BIN` (four independent disassembly passes over both 64 KB banks; flash `0x20000+off` = segment E000, `0x30000+off` = F000). Everything below is read from verbatim code.

**The sizer (flash `0x33836–0x3397C`, F000:3836).** Cold boot enters it from `F000:411B`. It is **purely empirical — there is no module‑ID table**:

- Zeroes **EC/ED index `0x02` and `0x03`**, then for each of 4 banks writes a **trial 4‑bit geometry code** into one nibble and probes with `0xAA55` write/read‑back alias tests at +1 KB / +2 KB / +4 KB, then +4 MB / +8 MB.
- Geometry codes → bank size = `2^((code&7)−1)` MB: `0`=empty, `0xA`=2 MB, `0xB`/`0x3`=4 MB, `0xC`=8 MB, `0x5`/`0xD`=**16 MB**. The nibble layout: **reg `0x02` = banks 0 (low) / 2 (high); reg `0x03` = banks 1 (low) / 3 (high)**; banks stack contiguously in index order, empty banks skipped.
- Returns total KB; POST later counts extended memory destructively in 64 KB steps from 1 MB and stores it in **CMOS `0x30/0x31`** (write at flash `0x360B2`). Base 640 KB → BDA `0040:0013`.
- **Warm‑boot gates:** the sizer returns immediately if **port `0x64` bit 2** (8042 System Flag) is set — and a CPU warm reset does not reset the chipset, so EC/ED `02/03` survive. With `0040:0072 = 0x1234` (Ctrl‑Alt‑Del) the *count* re‑runs over the preserved bank config and refreshes CMOS `0x30/0x31`; with `0x4321` even the count is skipped.
- **No BIOS code ever reads EC/ED `02/03` back**, and nothing else writes them. `0xDD`/`0xCD` never appear as immediates — DARK2301 writes a value the BIOS only ever composes nibble‑by‑nibble: **`0xDD` = 16+16 MB, `0xCD` = 8+16 MB** in the two nibbles of reg `0x03`.
- Matching taka's arithmetic (`CD` → 4+16+8 = 28 MB) requires **reg `0x03`'s two nibbles to be the two module RAS lines** (nets `RAS2`/`RAS3`), i.e. the chipset's internal bank order is RAS0, RAS2, RAS1, RAS3 relative to IBM's net names — **hardware‑confirmed, see next bullet [C]**.
- **Live confirmation (2026‑07‑27, two units × three configurations — [`eced-dram-regs-live.md`](eced-dram-regs-live.md)):** read with a CRC‑verified read‑only `.COM` (gate `out 0xFB` → read `0xEC/0xED` idx 0x00–0x0F → `out 0xF9`), cold boot per configuration:

  | Module | Total | `eced[02]` | `eced[03]` |
  |---|---|---|---|
  | none | 4 MB | `0x0B` | `0x00` |
  | 4 MB | 8 MB | `0x0B` | **`0x0B`** (one 4 MB bank, first module RAS) |
  | 16 MB | 20 MB | `0x0B` | **`0xCC`** (two 8 MB banks) |

  The geometry registers **read back** sizer‑written values; index `0x03` tracks the module exactly; both module RAS lines live in reg `0x03` ✓; every other EC/ED byte is identical across both physical units. The earlier July‑20 dump that read `03=0x00` was from a unit with **no module installed** — positively explained. Untested: the 8 MB module (expected `0x0C` or `0xBB`).
- **Pluto strap hypothesis RETIRED [falsified 2026‑07‑27]:** the BIOS latches **Pluto window `0x35EA/EB` reg `0x05` bits 3:2 → SCAMP reg `0x82` bits 5:4** at POST (flash `0x33AF2`), which looked like the module ID straps being recorded — but a plain post‑boot read of Pluto reg `0x05` returns **`0xF3` (bits 3:2 = `00`) in all three configurations on both units**, including no‑module (where pull‑ups should read `11`). Whatever those bits are, they carry no RAM‑module information post‑boot. Where (if anywhere) the ID straps on Pluto pins 31/32 surface in a readable register is unknown — and since sizing is probe‑based, **this BIOS revision may simply never consume them.**

### 7.5 What this means for >20 MB builds (corrects §7.3 of the previous revision)

An earlier revision argued "the BIOS has no 32 MB module configuration" — **wrong**: sizing is probe‑based, and the probe already knows 16 MB‑per‑bank geometry (code `0xD`). The real cold‑boot killer is only the **>32 MB wrap** during the destructive memory count. Hence, in order of increasing ambition:

1. **28 MB module (16 MB + 8 MB decks) — should "just work" on a bone‑stock BIOS.** Total 4+16+8 = 28 MB ≤ 32 MB: the probe sizes both decks natively (16 MB deck → no alias at +4 M/+8 M → code `D`; 8 MB deck → alias at +8 M → code `C`), no RC circuit, no DARK, no warm‑boot dance, no BIOS patch. Same end state as taka's `03 CD` but native. Keep taka's EDO timing bodge (`UCAS#`→`OE#`) if using EDO 64 Mbit parts. **[H — logic traced, not yet bench‑tested]**
2. **32 MB exact (16+16 module, onboard RAS0 bank disabled):** the probe handles an empty bank 0 (code 0, banks stack from the module), total = 32 MB, no wrap. Risks: trace surgery on the soldered bank; behaviour of the count at exactly 32 MB depends on whether >32 MB reads wrap (alias → possible corruption) or float (clean stop); taka's 256‑colour conflict may or may not persist. **[H]**
3. **taka classic (36 MB physical + RC gate + `DARK2301 03 CD`)** — proven working at 28 MB, keeps the onboard 4 MB.
4. **BIOS patch:** with the sizer now located (flash `0x33868`), a ~25‑byte patch at its tail could clamp totals >28 MB (downgrade bank 3 `D`→`C`, adjust the returned KB) and make even the 36 MB build boot cold, no circuit — needs flash‑image checksum handling before attempting. Open item.
