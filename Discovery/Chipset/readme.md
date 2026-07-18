# VLSI VL82C420 — Comprehensive Technical Reference

*The SCAMP IV system controller. A synthesis of everything recoverable from patents, decap
evidence, the Intel 486 SL datasheet, the IBM PC110 hardware/BIOS, and the reverse-engineered
208-pin map — since no official VL82C420 datasheet was ever published.*

> **Provenance & confidence.** No VLSI datasheet for this part exists publicly. Items below are
> tagged where useful: **[DS]** from the Intel 486 SL datasheet (architectural twin), **[PAT]** from
> VLSI patents, **[DECAP]** from die analysis, **[RE]** from the reverse-engineered pin map / PC110
> board, **[BIOS]** from PC110 BIOS disassembly, **[H]** hypothesis.

---

## Table of contents
1. Identity & summary
2. Part numbers & packages
3. Place in the SCAMP family (and the QuadNote sibling)
4. Internal architecture
5. The Multiplexed Local (ML) Bus
6. CPU interface (486 SL local bus)
7. DRAM controller
8. ISA bridge & ROM/flash
9. Integrated peripherals (DMA / PIT / PIC / RTC)
10. Power management
11. The patent family (de-facto documentation)
12. Pinout — the 208-signal map
13. Configuration registers (observed)
14. IBM PC110 implementation
15. Documentation status & how to learn more
16. Open questions
17. Sources

---

## 1. Identity & summary
The **VL82C420** is the **system controller** of VLSI Technology's **SCAMP IV** chipset, a three-chip
80486SL-class notebook/subnotebook solution announced by VLSI's **Portable Systems Division (Tempe,
Arizona)** in **June 1993** (samples August, volume October 1993). It integrates almost the entire
"motherboard" of a portable PC into one device.

| | |
|---|---|
| Family | SCAMP IV (VL82C420 + VL82C144 peripheral chip + optional VL82C146 ExCA) |
| Role | system controller: CPU local bus, DRAM controller, ISA bridge, integrated DMA/PIT/PIC/RTC, power management, ML-bus host |
| Process | 0.8 µm CMOS, **mixed 3.3 V / 5 V** |
| CPU | power-managed Intel 486SL-class, **up to 33 MHz**, incl. clock-doublers |
| Memory | up to **32 MB** DRAM |
| Interconnect | VLSI-proprietary **Multiplexed Local (ML) Bus** to the companion chips |
| Board cost | a full design needs **as few as 3 TTL parts**; up to **four** VL82C146s per system |
| 1k price (1993) | **$32.50** (VL82C144 $25.00, VL82C146 $8.50) |

## 2. Part numbers & packages
- **VL82C420FC4** — appears at brokers as new-old-stock; package/revision variant.
- **VL82C420FC5** — the variant used in the IBM PC110: a **256-ball BGA (16×16, rows A–T skipping
  I/O/Q, cols 1–16)**. **[RE]** Of 256 balls, **~208 are active signals** and the rest power/ground/NC.
- "FC" is VLSI's package/grade code; FC4 vs FC5 are minor variants/steppings.

## 3. Place in the SCAMP family
VLSI's "SCAMP" = **S**ingle-**C**hip **A**T, **M**id-range **P**erformance single-chip controllers:

| Gen | Parts | Year | CPU class |
|-----|-------|------|-----------|
| SCAMP | VL82C310/311/311L | Jan 1992 | 286 / 386SX |
| SCAMP II | VL82C315 / VL82C316 / VL82C323 | late 1992 | 386 / 486, ≤33 MHz |
| **SCAMP IV** | **VL82C420** / VL82C144 / VL82C146 | **1993** | **486SL notebook** |

*(No publicly released "SCAMP III" is known — the numbering jumps from II to IV.)*

> **Sibling, not the same:** **QuadNote** (Feb 1994) = **VL82C410 + VL82C142** + the same VL82C146,
> from VLSI's *Personal Computer Division (San Jose)*, co-developed with **Compaq** and used in the
> **Contura Aero 4/25 and 4/33C**. QuadNote (410/142) is a close cousin of SCAMP IV (420/144) but a
> different chipset; the Contura Aero is **not** a VL82C420 machine.

## 4. Internal architecture
Decap of the PC110's VL82C420 die identifies its sub-blocks as licensed cores of standard parts,
matching the integrated-peripheral model and the patent block diagram:

| Block | Core | **[DECAP]** | Function |
|-------|------|:-----------:|----------|
| DMA | **82C37** (×2 cascaded) | ✓ | 7-channel ISA/floppy DMA |
| Timer | **82C54** | ✓ | system tick, refresh, speaker |
| Interrupts | **82C59** (×2) | ✓ | 15-level PIC |
| RTC/CMOS | **MC146818** | ✓ | clock/calendar + battery CMOS RAM |
| Memory ctlr | (VLSI) | — | DRAM RAS/CAS, up to 32 MB |
| ISA bridge | (VLSI) | — | full ISA bus |
| ML engine | (VLSI) **[PAT]** | — | multiplex system controller (US 5,793,990) |
| Power mgmt | (VLSI/Intel-licensed) | — | SMI/STPCLK#/suspend/resume |

Licensed technology: **Intel** 386SL/486SL power-management architecture, the **Intel 80C51**
core (embedded for keyboard control), **Intel 82365SL**-compatible ExCA logic (in the VL82C146), and
**Hewlett-Packard** infra-red comms (for the VL82C144 UART's IR mode).

## 5. The Multiplexed Local (ML) Bus  **[PAT: US 5,793,990]**
The proprietary interconnect between the VL82C420 and its companion chips. It exists to cut companion
pin count: the controller **tri-states the CPU's 32-bit address bus (via AHOLD)** and time-shares a
portion (A[25:2]) to send two 16-bit address groups then one 16-bit data group over the same wires.

**Control signals (5):**
| Signal | Dir (from controller) | Function |
|--------|------|----------|
| `MLCLK` | out | 1× bus clock, synchronous to CPU clock but separately gateable for power saving |
| `MLADS#` | out | address strobe — controller is driving valid addr/data on the CPU lines |
| `MLLBA#` | in | device asserts when it positively decodes its address; also indicates which CPU lines carry read data |
| `MLRDY#` | in/out | transfer complete / data valid; controller can assert it to terminate an unacked cycle |
| `Mpriority` | in | a higher-priority device can pre-empt/terminate an ML cycle |

Memory-I/O devices decode to **1 KB** granularity (first 16-bit group = A25–A10); I/O-only devices
decode to **4-byte** granularity. Cycle types documented in the patent: I/O read (high/low device),
I/O write, terminated I/O, memory read/write, terminated memory, and multiplex-DMA read/write. In the
PC110 these five lines are the `Bowman1–5` net group linking the VL82C420 to the IBM "Bowman" gate
array. **[RE]**

## 6. CPU interface (486 SL local bus)  **[RE + DS]**
Full 486 local bus with SL power-management extensions (matches the Intel 486 SL signal set):
`A[2..31]`, `D[0..31]`, `ADS#`, `BLAST#`, `BRDY#`, `RDY#`, `KEN#`, `HOLD`, `AHOLD`, `HLDA`, `W/R#`,
`D/C#`, `M/IO#`, `BE0-3#`, `EADS#`, `A20M#/A20GATE`, `RESET`, `SRESET`, `FLUSH#`, `INTR`, `NMI`,
`SMI#`, `SMIACT#`, `STPCLK#`, plus `LDEV#` (local-device-access, the patent's LBA# concept).
Clocking: `CPU_CLK`, `CPU_CLK_33`, `2XCPU_CLK` (for clock-doubled CPUs), `CPU_CLK_SENS`.

## 7. DRAM controller  **[RE]**
Up to 32 MB. Pins: `RAM_A[0..11]` (multiplexed row/col address), `RAM_RAS0-3` (four bank selects),
`RAM_UCASU#/UCASL#/LCASU#/LCASL#` (per-byte/upper-lower CAS), `RAM_WE#`. Standard FPM-DRAM controller
behavior; refresh driven by the integrated timer (`REFREQ`-style internal refresh).

## 8. ISA bridge & ROM/flash  **[RE + DS]**
ISA: `SA0/SA1/SA16`, `LA17–23`, `SD0–15`, `BALE`, `AEN`, `SBHE#`, `MEMR#/MEMW#`, `IOR#/IOW#`,
`MEMCS16#`, `IOCS16#`, `IOCHRDY`, `ZEROWS#`, `REFRESH#`, `ISA_SYSCLK`, `ISACLK2` (16 MHz osc in → 8 MHz
SYSCLK). Mid SA lines (SA2–SA15) are generated internally and not all bonded out (PCMCIA-only boards
have no ISA slots). ROM/flash: `ROMCS0#`, `ROMCS1#`, `BIOS_CE#`/`FLSHCS#`, `ROM16/8#`, `FDC_TC`.

## 9. Integrated peripherals  **[DECAP + BIOS]**
- **DMA** — 82C37 ×2 at ports `0x00–0x0F` / `0xC0–0xDF`, page regs `0x80–0x8F`; floppy uses a channel
  (`FDC_TC`).
- **Timer** — 82C54 at `0x40–0x43`; timer-2 → `SPKR`.
- **PIC** — 82C59 ×2 at `0x20/0x21` and `0xA0/0xA1` (15 IRQs).
- **RTC** — MC146818 at `0x70/0x71` with `RTCOSCI/RTCOSCO` (32.768 kHz), `RTCBAT`, `RTCBAT_RES/Sense`,
  `PS/RCLR#` (power-sense / RAM-clear), `RTC-SQW` (square-wave out) and `RTC-IRQ#` (alarm).

## 10. Power management  **[PAT + DS]**
SL-compatible. Key signals: `SMI#`/`SMIACT#` (System Management Mode), `STPCLK#` (stop CPU clock),
`SUS_STAT#` (suspend state), `PWRGD`. Features (per the announcement): socket power control, **3.3 V/5 V
suspend** with **modem & ring-resume** detection, and power-down on Windows inactivity. The embedded
80C51 keyboard controller lets OEMs reuse existing 386SL/486SL power firmware.
**US 5,715,467** details the event-driven scheme: it modifies `STPCLK#` so the CPU returns to full
speed to service "break events." A modem/ring-resume **wake input** is a VLSI addition beyond the stock
SL pin set. **[H: this is the still-unidentified `VL_F5` ball, between `SUS_STAT#` and `STPCLK#`]**

## 11. The patent family (de-facto documentation)
Filed by VLSI Tempe engineers (Jirgal, Evoy, Potts) around the 1993 launch:

| Patent | Title | Topic |
|--------|-------|-------|
| **US 5,793,990** (WO 1994/029797) | Multiplex address/data bus with multiplex system controller | the ML bus + VL82C420 block diagram & timing |
| **US 5,715,467** | Event-driven power management control circuit | STPCLK#-based PM |
| **US 5,561,772** | Expansion bus replicating an internal bus as an external bus with logical interrupts | the "HCI" pin-count-reducing portable bus |
| **US 5,805,901** | Mapping interrupt requests in a high-speed CPU interconnect bus | interrupt mapping — but for the 32-bit **HCI** bus (US 5,561,772 family), **not** the 5-wire ML bus; see §11a |
| **US 5,655,142** | High-performance derived local bus | deriving a CPU-style bus from the multiplexed peripheral bus |
| **US 5,652,847** | Multiplexing data and a portion of an address on a bus | address/data muxing detail (companion to US 5,793,990) |
| **US 5,958,055** | Power management system for a computer | PM architecture |

## 11a. ML-bus cycle protocol — decoded from US 5,793,990  **[PAT]**
The ML bus had no cycle-level description in this repo — only the 5-signal list. Reading the primary
patent (**US 5,793,990**, VLSI Technology, inventors Jirgal/Evoy/Potts, filed 1993-06-11, granted
1998-08-11) yields the actual protocol. The trick: the "multiplex system controller" (VL82C420) drives
its companion over almost no dedicated pins by **time-multiplexing the CPU's own local address bus**.

**Signals** (the PC110's `Bowman1–5` net group):

| Signal | Dir (at VL82C420) | Role |
|--------|-------------------|------|
| `MLCLK`     | out | 1× bus clock, synchronous to the CPU clock; gateable to save power |
| `MLADS#`    | out | multiplex address strobe — asserted while the controller drives a valid address/data group onto the CPU lines |
| `MLLBA#`    | in  | companion asserts it when it **positively decodes** its address (claims the cycle) |
| `MLRDY#`    | in  | transfer complete / read-data valid; companion holds it **de-asserted to insert wait states** |
| `Mpriority` | in  | a higher-priority (VL-bus) device can **pre-empt** the multiplex cycle |

**The multiplex = three 16-bit groups over CPU `A[25:2]`.** Rather than dedicated wires, the controller
tri-states the CPU address bus with **`AHOLD`** and sends each transaction as three successive 16-bit
groups on the CPU's `A[25:2]` lines, each strobed by `MLADS#`:

| Group | Memory cycle | I/O cycle |
|------:|--------------|-----------|
| 1 | `A[25:10]` — high address, 1 KB granularity | address bits, 4-byte granularity |
| 2 | `A[9:2]` + control: `A1`, `BHE#`, `BLE#`, `W/R#`, `D/C#` | same control set |
| 3 | `D[15:0]` — the 16-bit data payload | `D[15:0]` |

The 16-bit data width is exactly Bowman's documented job of "expanding the bus to 16 bits."

**Read cycle:** ① CPU asserts `ADS#` with group 1 on `A[25:10]`; controller mirrors with `MLADS#`; the
companion starts decoding. ② Controller negates `MLADS#` and asserts `AHOLD`; the CPU tri-states its
address bus. ③ Controller drives group 2 and re-strobes `MLADS#`; the companion, recognizing its
address, asserts `MLLBA#`. ④ Companion returns read data on the (now controller-owned) address lines and
asserts `MLRDY#`. ⑤ Controller samples `MLRDY#`, forwards data to the CPU with `RDY#`, negates `AHOLD`;
the CPU regains its bus.

**Write cycle:** identical groups 1–2, then the controller drives **`D[15:0]` on the address lines** and
holds `MLADS#` asserted until the companion asserts `MLLBA#` (ownership) then `MLRDY#` (data accepted).

**Wait states:** the companion just holds `MLRDY#` de-asserted; the controller re-samples every `MLCLK`.

**Pre-emption (`Mpriority`):** if a higher-priority VL-bus device decodes the address (via its own
`LBA#`), the state machine terminates the multiplex cycle early and returns the bus — that is what
`Mpriority` carries.

**What this means for the PC110.** `Bowman1–5` are these five lines, and **Bowman (U21) is the ML-bus
companion** — IBM dropped their custom RIOS gate array into the socket VLSI's stock **VL82C144**
peripheral-combo chip occupies in a standard **SCAMP IV** set (VL82C420 + VL82C144 + VL82C146; see
[The Retro Web #568](https://theretroweb.com/chipsets/568)). The FDC/UART/IR that VLSI put in the
VL82C144 live in the PC110's **Pluto (U35)** instead. So *every* ISA/CF/PCMCIA/Bowman access the CPU
issues is physically carried as one of these 3-group multiplexed ML-bus transactions.

**Caveat on ML-bus interrupts.** US 5,805,901 (previously tagged here as "ML-bus interrupt mapping")
actually describes a *different* VLSI portable bus — a 42-line, **32-bit "HCI" bus** (the US 5,561,772
family) where peripherals raise interrupts by **bus-master memory writes to a reserved high block
(`FFFE'0000…`)**, one address per `IRQ0–15`, decoded by a built-in interrupt controller. That is **not**
the 5-wire ML bus, so how Bowman's interrupts reach the VL82C420's integrated 8259 pair over the ML bus
remains open (candidates: a sideband on an as-yet-unmapped Bowman ball, or an encoded field in group 2).

## 11b. ML bus — live logic-analyzer capture  **[MEASURED 2026-07-06]**
A Saleae Logic Pro 16 was wired to the running PC110 while I drove bus cycles from the host over COMrade
(`io_in`/`mem_read` bursts to force I/O, ROM and companion — FDC/PCIC/VGA — accesses; COMRADE's own UART
polling adds continuous companion traffic). Captured at 250 MS/s. Two rounds of probing settled the
long-standing mapping:

**Correction 1 — `Bowman1–5` ARE the ML-bus wires, seen from the U61 side.** *(Re-corrected 2026-07-18:
the first version of this correction claimed `Bowman1–5` was "the Bowman↔Pluto link, NOT the ML bus",
based on a netlist misread that put balls N9/P9/R9/T9/T13 on "Pluto (U35)". Pluto is a 100-QFP with
numeric pads — it has no ball designators. Re-checking `main.txt` shows those balls are inside the
**VL82C420FC5 (U61)** section, and the KiCad PCB confirms the connectivity.)* The five nets named
`Bowman1–5` run from **U61 balls N9/P9/R9/T9/T13** directly to **Bowman U21 pins 45/140/39/52/130** —
the pins whose symbol names are `Chipset_IO1–5`. Same five wires, two naming conventions: the U61 side
says "these go to Bowman", the U21 side says "these go to the chipset". `Bowman3` (MLCLK) runs through a
series resistor **R149** (clock termination); `Bowman5` also touches R57/U7 (HD151015). Probing round 1
(at the U61 side) showed a continuous ~22 MHz clock on **Bowman3 (U61 R9)** and a per-cycle strobe on
**Bowman4 (U61 T9)**; round 2 (at Bowman pins 39/52) saw the same clock and strobe — the two rounds
measured the **same copper**, and together they confirm the ML bus **at both ends**, including at the
VL82C420 balls (R9 = MLCLK, T9 = MLADS#). The earlier inference that this "begins to answer what passes
over `Bowman_IO`/`Pluto_IO`" is **retracted** — the real Bowman↔Pluto link (Pluto pins 51/52 ↔ Bowman
129) was probed during the Pluto campaign and stayed static through every I/O and memory test.

**Correction 2 — the VL82C420↔Bowman ML bus is the `Chipset_IO` group.** Re-probing **Bowman (U21,
144-QFP) pins 45/140/39/52/130 = `Chipset_IO1–5`** gave, live:

| Signal | Net | Bowman U21 pin | Measured |
|---|---|---|---|
| **MLCLK**  | `Chipset_IO3` | **39**  | continuous **~22.7 MHz** clock (free-running) |
| **MLADS#** | `Chipset_IO4` | **52**  | per-cycle strobe, low ≈ 1 MLCLK (~24 ns) at cycle start |
| **MLRDY# / MLLBA# / MPriority** | `Chipset_IO1/2/5` | 45 / 140 / 130 | **static high** through thousands of cycles (naming adopted 2026-07-18, applied in KiCad) |

> **Pin-ID correction (2026-07-14).** The pin numbers above were re-checked against the schematic and
> re-confirmed live: **MLCLK = pin 39 (`Chipset_IO3`)**, **MLADS# = pin 52 (`Chipset_IO4`)**. The earlier
> IDs in this table (MLCLK=52 / MLADS#=140) were a 0.5 mm-pitch miscount. A 2026-07-14 payload capture
> ([ML-bus-payload-probe.md](ML-bus-payload-probe.md)) with CH1 on pin 39 and CH0 on pin 52 showed the
> continuous 22.7 MHz clock on pin 39 and the per-cycle strobe on pin 52, confirming the swap. The idle
> trio is therefore `Chipset_IO1/2/5` (45/140/130).

**Why three control lines stay idle (inference):** the PC110 is a **cache-less 486SX with a single ML
companion (Bowman)**. On this `ML local/cache bus`, **MLLBA#** (local/cache-device decode) never
asserts — there is no cache/local-bus device to claim a cycle; **MLRDY#** (ready / wait-state) never
asserts — Bowman uses fixed-timing cycles and inserts no wait states; **Mpriority** stays idle — no
competing master. So in this machine the ML bus effectively runs on **MLCLK + MLADS# + the address/data
multiplexed onto the CPU's own A[25:2] lines** (exactly the US 5,793,990 scheme, §11a — the mux rides
the CPU bus, not the control lines). *Update 2026-07-18: now confirmed at the VL82C420 balls too — the
round-1 probe was in fact at the U61 side of these nets (see re-corrected Correction 1): **U61 R9 =
MLCLK, T9 = MLADS#** measured directly; **N9 = MLRDY#, P9 = MLLBA#, T13 = MPriority** (static trio;
naming adopted 2026-07-18 and applied in KiCad).*

## 11c. ML bus — payload capture  **[MEASURED 2026-07-14]**
Second probe round on **Bowman (U21)** with all 16 Saleae channels: MLADS# (pin 52), MLCLK (pin 39),
CPU_ADS# (49), CPU_MIO# (50), CPU_WR# (42), and CPU address lines. Cycles driven over COMrade
(`mem_read`/`io_in`) and triggered on MLADS# or MIO#. Method + pin map in
[ML-bus-payload-probe.md](ML-bus-payload-probe.md). Findings:

- **Multi-strobe MLADS# sequence.** Memory/companion transactions show ≈3 MLADS# strobes/cycle
  (~40–120 ns apart). *First read as the US 5,793,990 three-group multiplex — but §11d shows these are
  Bowman decode/handshake phases, **not** address re-multiplexing.*
- **The high address lines `A[25:10]` are static within a transaction** — they hold the cycle's address
  and are *not* re-multiplexed (confirmed for the low lines too in §11d).
- ~~The dynamic content is on the low lines `A[9:2]`.~~ *Superseded by §11d: the low lines only appeared
  to "change" because consecutive **different** cycles have different (sequential) addresses; within a
  single fixed-address cycle they are static. There is no address-line data multiplex — see §11d.*
- **MLADS# frames *memory*/companion (Bowman) cycles, not ISA I/O.** An isolated `io_in 0x3F4` shows
  **MIO# low for ~4 µs with MLADS# never asserting** — plain ISA I/O ports take a separate, wait-stated
  ISA path with no ML multiplex strobe. MLADS# is specifically the ML memory-transaction strobe (e.g.
  VGA `0xB8000` accesses, which *do* strobe it).
- **All probes validated**, incl. CPU_MIO# reading correctly (≈97 % high = memory, dipping low on I/O).
  Raw captures saved (`pc110_mlbus_pass1_20260714.sal`, `pc110_mlbus_iocycle_20260714.sal`).

## 11d. The PC110 does *not* multiplex addr/data on `A[25:2]`  **[MEASURED 2026-07-14]**
> **Note (2026-07-16):** the core finding here — *the address is static on `A[25:2]`, no addr/data
> multiplex* — still stands. But the assumption that the MLADS# strobes seen in this capture *belonged to
> the `0xB8000` write* is now **wrong**: §11h shows `0xB8000` writes are internal, so those strobes were
> coincident background companion cycles. Read §11d for the (valid) no-multiplex conclusion, but see §11h
> for the corrected companion attribution.

A decisive write experiment settles how the address/data actually travel. Driving repeated **memory
writes to a fixed VGA address `0xB8000`** over COMrade (`mem_write`, a safe target — VGA text RAM), the
Saleae was armed with a tight trigger: **MLADS# falling *and* WR#=low *and* the VGA high-address region
*and* all of `A[9:2]` low** — i.e. it fires only on our `0xB8000` write, whose low address bits are 0.
Writing the all-ones pattern `0xFFFF`:

- **`A[9:2]` stays `0x000` for the entire ~700 ns cycle, through all five MLADS# strobes.** The data
  byte `0xFF` (which would read `0x3FC` on these lines) **never appears** — and the transition-based
  export would have caught even a single-sample glitch.

Combined with §11c (high lines `A[25:10]` also static within a cycle), the conclusion is:

- **The CPU address is presented *statically* on the full `A[25:2]` for the whole ML transaction**
  (held via `AHOLD`) — it is **not** time-multiplexed.
- **The 16-bit data does not ride the address lines at all.** It travels on a **separate data bus**
  (CPU `D[15:0]` / the `SD` path), which this probe set does not tap.
- **The multiple MLADS# strobes are Bowman's decode/handshake phases, not multiplex groups.**

**Cycle-timing signature** (tight-triggered isolated read/write cycles to `0xB8000`, 2026-07-14): a
companion (ML) memory cycle spans **~128 ns ≈ 3 MLCLK periods** (at 22.7 MHz), within which MLADS#
re-strobes **2–3×** (one at cycle start, one near the end, occasionally an extra early one). This is the
fixed-length handshake framing — *not* re-multiplexing. Read vs write showed **no robust difference**
here (both ~128 ns / 2–3 strobes; capture-to-capture variability dominates), so no read/write distinction
is claimed. *Side note:* COMrade's own serial/UART traffic itself generates companion MLADS# cycles
(UART access rides the ML bus), so a clean memory-**decode-window** map needs the target reads isolated
from that background (a quieter driver or trigger-on-exact-signature) — attempted 2026-07-14 but too
noisy with the current `A2–A9`/`A18–A20` address visibility to resolve.

So the US 5,793,990 "three 16-bit groups over `A[25:2]`" scheme (§11a) is a *generic capability* of the
VL82C420 controller family that **this Bowman-companion implementation does not use** — there is no
group-2/3 bitmap to recover on the address lines. Capturing the ML **data** is a separate experiment:
probe the data bus (Bowman's `SD`/`D[15:0]` pins), then drive known writes and read the value directly.
(0xFFFF-to-`0xB8000` write experiment, 2026-07-14.)

## 11e. ML companion-cycle characterization  **[MEASURED 2026-07-14]**
A battery of captures with the same probe set (MLADS#, MLCLK, ADS#, MIO#, WR#, `A2–A9`, `A18–A20`),
cycles driven over COMrade. These exhaust what's resolvable without moving probes:

- **The ML bus is essentially memory-only.** Sweeping 11 I/O ports with `io_in` over 150 ms gave **72
  memory-cycle MLADS# strobes but only 3 I/O-cycle strobes — all at port `0x3F8`** (COM1 UART, which is
  COMrade's own link port). FDC `0x3F4`, VGA-I/O `0x3C1`/`0x3DA`, PCIC `0x3E1`, KBC `0x60`/`0x64`, PIT
  `0x41`, PIC `0x21`, RTC `0x71`, sysctl `0x92` produced **none**. So I/O runs on the direct ISA path;
  only the UART shows any (rare) companion strobes — suggestive, not conclusive.
- **ADS# → MLADS# latency ≈ 80 ns (~2 MLCLK).** Triggering on a VGA-read MLADS# and looking back, the
  CPU's `ADS#` precedes the first `MLADS#` by ~80 ns — Bowman's address-decode / cycle-setup latency.
- **Companion-cycle framing:** within the cycle, MLADS# strobes at ~**0 / 128 / 248 ns** (≈128 ns
  spacing, 2–3 strobes) — consistent with §11c/§11d.
- **MLCLK ≈ 23.8 MHz** — median period **42 ns** measured at 500 MS/s (2 ns resolution; edge jitter down
  to ~10 ns from ground-lead ringing). Refines the "~22.7 MHz" estimate in §11b.
- **Decode boundary (partial):** reads to **`0x80000–0x9FFFF` are internal DRAM** (no MLADS#, ~368 ns
  observed), while **VGA `0xA0000–0xBFFFF` strobes MLADS#** (companion). Finer decode-window mapping
  needs `A10–A17` visibility, which this probe set does not have.

**Hard limits of the current probe set:** everything beyond this — the fine decode-window map, and any
ML **data** capture — requires either probing `A10–A17` or the data bus (`SD`/`D[15:0]`), i.e. moving
grabbers. Not possible remotely; queued for the next bench session.

## 11f. ML companion-memory data is NOT reachable at Bowman  **[MEASURED 2026-07-15]**
Rewired CH5–CH12 to Bowman's **`SD0–SD7`** (pins 96,95,94,93,92,91,89,88) to try to read the ML data
payload directly (the §11d/§8-A plan). Result — a hard architectural boundary:

- **VGA (`0xB8000`) write data never appears on `SD0–SD7`.** Drove `mem_write(0xB8000, …)` with three
  distinct low bytes (`0xFF`, `0x55`, `0xA5`); `0xA5` showed **0 samples out of 7 M**, and the bus stayed
  at its idle value through the whole triggered write cycle. The SD tap is *live* (see next point), so
  this is a real negative, not a probe miss.
- **`SD0–SD7` does carry ISA-peripheral data.** During `io_in(0x3F4)` the FDC Main Status Register shows
  up (bit7-set bytes `0x81/0x89/0x8B/0x8D/0x8F…`, RQM=1). So Bowman's `SD` is the **ISA-side peripheral
  data bus** (FDC/UART/CF), *not* the ML companion path.
- **Conclusion:** the ML companion-**memory** data (VGA and friends) rides the **CPU-local `D[15:0]`**
  bus, which exists only on the **BGA parts (CPU U76 / chipset U61)** — it is **not** exposed on Bowman's
  QFP pins. So ML memory *data* cannot be captured at Bowman by any rewire; it needs a BGA/interposer tap.
  What *is* reachable at Bowman for data is ISA-peripheral traffic (e.g. CompactFlash/IDE on `SD0–15`).

*(Aside: `SD6`/pin 89 read stuck-low across the session even after reseats — a flaky tap; it corrupts
bit 6 only and doesn't affect the above conclusion.)*

This closes the "read ML data at Bowman" thread: **companion address = statically on `A[25:2]` (§11d);
companion data = on `D[15:0]` at the BGA, unreachable here.**

## 11g. Decode-window map — which regions route to the companion  **[MEASURED 2026-07-16]**
Rewired CH5–CH15 to the **full `A10–A20`** (pins 19–27,29,30) — validated correct (a driven `0xB8000`
read shows `A[20:10]=0xB8000` at CPU_ADS# exactly as predicted). Bucketing MLADS# strobes (companion)
vs CPU_ADS# cycles (all) by region, with COMrade driving reads and the box at/near idle:

- **DRAM → internal.** The heavy `ADS#` regions (low mem, `0x001C00`, `0x03FC00`, `0x032000`, …) carry
  huge cycle counts but **no MLADS#** → the VL82C420 services DRAM itself, off the ML bus.
- **BIOS/ROM (F-segment) → companion.** `0x0FA000`/`0x0FA800` (and `0x0E0000`) **strobe MLADS#**
  consistently across captures → ROM reads route over ML to the Flash behind Bowman (BIOS is *not*
  shadowed to DRAM here — it runs from Flash via the companion path).
- ~~**VGA text `0xB8000`: reads internal, writes companion.**~~ **[SUPERSEDED by §11h]** The precise
  ADS#-region method later showed `0xB8000` **writes are also internal** — the apparent write-companion
  behaviour here was a loose-trigger artifact. VGA (text+gfx, read+write) is **internal**. See §11h.

*Caveats:* (a) COMrade's serial read rate (~130/s) is dwarfed by the CPU's ~4.5 M cycles/s when the box
is busy, so driven targets only stand out at true idle or via ADS#-triggered per-region capture; (b) a
few low-mem MLADS# strobes (`0x000400`, `0x001C00`) have uncertain attribution — the address at the
companion strobe may be Bowman-driven, not the CPU target — so treat sub-`0x2000` companion hits with
caution. Full per-region certainty wants the ADS#-triggered method (trigger on ADS# + region signature,
check MLADS# in-cycle).

> **Rig gotcha (cost hours 2026-07-16):** the NUC's `/tmp` is a **7.4 G tmpfs**; each 300 ms×16-ch raw
> CSV export is ~0.5 GB, so a session's exports silently fill it and `export_raw_data_csv` then writes
> **0-byte files** (looks like "empty/flaky captures"). **Clean `/tmp/exp_*` between runs** (`df -h /tmp`).

## 11h. Precise per-region test — VGA is INTERNAL; the "VGA writes are companion" claim is RETRACTED  **[MEASURED 2026-07-16]**
The definitive method (now that A10–A20 are pinned and validated — a driven `0xB8000` read shows
`A[20:10]=0xB8000` at CPU_ADS# exactly): **trigger on CPU_ADS# + the exact region `A[20:10]` signature
(+ WR#), then check whether MLADS# fires *inside that cycle*.** This isolates one region regardless of how
busy the box is. Results:

| Cycle (driven) | in-cycle MLADS#? | verdict |
|---|---|---|
| VGA gfx `0xA0000` read | none | **internal** |
| VGA text `0xB8000` read | none | **internal** |
| VGA text `0xB8000` **write** | none | **internal** |
| DRAM (natural, 500 ms) | 0 across **1.39 M** ADS# | **internal** |

- **VGA memory (text + gfx, read *and* write) and DRAM are serviced internally by the VL82C420 — not over
  the ML/Bowman companion bus.**
- **⚠️ Retraction:** this **overturns §11d/§11g's "0xB8000 writes are companion."** That earlier result
  came from a *loose* trigger (A10–A17 weren't pinned yet, so it matched background companion cycles
  anywhere in `0x80000–0xBFFFF`, not the actual `0xB8000` write). The precise ADS#-region method does not
  reproduce it. Treat §11d's write-companion claim and §11g's VGA "read-shadow/write-through" line as
  **superseded by this section.**
- **Honesty caveat:** during this session's precise runs the PC110 happened to be running a **pure-DRAM
  workload with zero companion cycles**, so there was **no same-session positive-control** companion cycle
  to prove the detector can register a "companion" verdict. DRAM's 1.39 M-ADS#/0-MLADS# is conclusive on
  its own, and the region decode is validated, so the VGA-internal reads are strong — but a positive
  control is still owed. The earlier **natural** F-segment strobes (`0xFA000/0xFA800`, idle BIOS
  execution, §11g) remain the best evidence that **ROM-code fetch is the genuine companion traffic**;
  re-confirming that with the precise method (box parked at the idle BIOS prompt) is the clean next step.

## 11i. Positive control — BIOS ROM fetch IS the companion traffic  **[MEASURED 2026-07-16]**
The positive control §11h owed. Armed an **MLADS#-falling trigger, sent a COMrade reboot, and caught
POST** (BIOS runs from Flash before it shadows itself). Boot window: 180 MLADS# strobes / 30 ms — so
companion cycles **are** detectable (the detector isn't broken; §11h's VGA/DRAM "internal" verdicts hold).
Correlating each MLADS# with the ADS# that caused it, in the **tight ~72 ns latency window**:

- **Companion = ROM/BIOS fetch.** The clean hits are **F-segment `0xFA000`/`0xFA800` and E-segment
  `0xE0000`** — BIOS executing from Flash over the ML/Bowman path. Confirmed against the raw strobe
  buckets and the natural idle strobes (§11g). **This is the answer to "what is companion."**
- **ADS#→MLADS# latency: median 72 ns** (56–120) — confirms §11e (~80 ns).
- **At runtime the companion path is ~idle** (§11h: 1.39 M DRAM ADS#, 0 MLADS#). So the ML/Bowman
  companion bus serves **ROM (and boot-time memory)** — not runtime DRAM/VGA, which the VL82C420 handles
  internally.
- *Uncertain:* some low/mid-DRAM addresses (`0x001C00`, `0x038C00`) also show companion-latency
  correlation **during POST only** — plausibly **early-POST accesses before the DRAM controller is
  configured** (routed over companion until DRAM is set up), or residual correlation noise. Not claimed.

**Corrected & positive-controlled decode map:** *companion (ML/Bowman) = ROM/BIOS fetch; internal
(VL82C420) = DRAM + VGA (text+gfx, read+write).* Data payload (§11f) and interrupt signalling remain
unreachable with this probe access.

### 11i-follow — BIOS is shadowed; runtime companion path is idle  **[MEASURED 2026-07-16]**
Enabled by a new COMrade **`BUS_STIM`** op (tight DOS-side read-loop stimulus — see the COMrade repo)
that drives ~0.3–0.8 M cycles/s to one target from a single round-trip, so driven cycles finally
**dominate** the bus (a `0xB8000` burst went from 0.003 %→**19.3 %** of ADS# — ~7,800×). With that:

- A dominant `mem_read` burst to **`0xB8000`** — 102 k driven reads, **0 MLADS#** → VGA reads are
  *definitively* internal (firms up §11h; not a small-sample false-negative).
- A `mem_read` burst to **`0xFA000`** (F-seg BIOS) — 5.8 k driven reads, **0 MLADS#** → **BIOS is
  shadowed to DRAM**; runtime reads of ROM addresses come from shadow, not Flash.

So the companion (ML/Bowman) path is **effectively boot-time-only**: the §11i companion ROM fetches were
POST accesses *before* shadowing; once BIOS shadows itself, DRAM + VGA + shadowed-BIOS are all internal
and the companion bus goes quiet. This is the coherent explanation for the recurring "0 companion at
runtime" observations. Positively confirming a *runtime* companion access would need a genuinely
non-shadowed ISA/CF memory-mapped device to target.

### 11i-follow-2 — upper-memory + I/O companion scan: nothing companion at runtime  **[MEASURED 2026-07-16]**
Using `BUS_STIM` to make each target dominate, scanned upper memory and key I/O ports (drive burst →
capture → check MLADS#). **Total MLADS# = 0 in every window** — the companion bus stayed idle throughout:

| Target | Verdict |
|---|---|
| mem `0xD0000` (UMB), `0xE0000` (BIOS ext) — dominant bursts (53k/63k ADS#) | **internal** |
| I/O `0x3F8` (UART), `0x1F0` (CF/IDE), `0x3F4` (FDC) — dominant bursts (350–450k ADS#) | **direct ISA** (no companion) |
| mem `0xC0000`/`0xC8000`/`0xF0000` — burst under-ran (orchestrator connect-timing), not a dominant test | no companion observed |

- **Resolves the §11e UART caveat:** `0x3F8` I/O is **direct ISA**, not ML (the earlier 3 strobes were
  coincidence). CF/IDE and FDC likewise direct ISA. → **the ML bus carries no I/O at all.**
- **No runtime companion region found** anywhere tested → reinforces that the VL82C420↔Bowman companion
  path is **boot-ROM-only**; at runtime DRAM + VGA + UMB + shadowed-BIOS are all internal and I/O is
  direct ISA.

## 12. Pinout — the 208-signal map  **[RE]**
The reverse-engineered map (256-ball BGA, ~208 active) breaks down as:

| Group | Count | Examples |
|-------|------:|----------|
| CPU address + control | ~33 | A[2..31], ADS#, BLAST#, BRDY#, RDY#, KEN#, HOLD/AHOLD/HLDA, BE0-3#, etc. |
| CPU data | 32 | D[0..31] |
| CPU power-mgmt | ~6 | SMI#, SMIACT#, STPCLK#, SUS_STAT#, SRESET, A20GATE |
| ISA bus | ~30 | SA/LA/SD, MEMR#/W#, IOR#/W#, BALE, SBHE#, MEMCS16#, IOCS16#, IOCHRDY, ZEROWS#, REFRESH# |
| DRAM | 20 | RAS0-3, UCAS/LCAS ×, MA0-11, WE# |
| RTC | 6 | RTCOSCI/O, RTCBAT, RTCBAT_RES, RTC-SQW, RTC-IRQ# |
| ML bus | 5 | MLCLK, MLADS#, MLLBA#, MLRDY#, Mpriority |
| Clocks | ~5 | CPU_CLK, CPU_CLK_33, 2XCPU_CLK, ISA_SYSCLK, ISACLK2, 32KHz |
| ROM/misc | ~6 | ROMCS0#, ROMCS1#, FDC_TC, SPKR, KB_RESET, RESET |
| Power/ground | ~20 | VCC (main), VCC2 (3.3 V), VSS/GND |

**~95% identified** by cross-referencing the **Intel 486 SL** datasheet (architectural twin). The only
group with **no** external analog is the ML bus (VLSI-proprietary). Remaining unknown balls and best
candidates: `VL_K16`→`ISACLK2` [H-high]; `VL_F5`→ring/EXTSMI wake [H]; `VL_F15/F16`→`MASTER#`/`ROM16/8#`
[H]; `VL_T8`→test/config strap (Turbo/SELFTEST/ONCE# class) [H]; `VL_A14/B14/C14/A15`→likely VCC corner
balls [H]; `VL_P13/L11/R12/N10`→board-specific. `TP1` (ball T14) → a test pad, likely an `ONCE#`-class
test/tri-state control. **Probed live 2026-07-18:** TP1 reads a **clean static HIGH** (0 transitions
over the capture — solidly driven/pulled high, not floating; carries no dynamic bus activity). This is
consistent with an `ONCE#`-class test strap held **inactive** (idle-high = normal operation), but a
non-destructive read can't distinguish which test function it is — all such straps sit idle-high, and
confirming the exact one would need active driving (which would tri-state/hang the chipset). So: confirmed
a static test/config strap, not a functional signal; precise ID remains `[H]`.

## 13. Configuration registers (observed)  **[BIOS]**
The PC110 BIOS programs the chipset largely through a `0x4F` config-latch/index plus direct config
ports. POST writes these `0x4F` indices: **0x11, 0x66, 0x70, 0x0A, 0x1E, 0xB6, 0x8F, 0x65, 0xBF, 0xFF**.
Other config writes: `0x22/0x23` unlock (`←0x80`), `0x8B` (`←6F,0A,80,70,71`), `0x98←BF`, `0xF1←65`,
SCAMP indexed pair `0x74/0x76` (index `0x80`). Exact register *semantics* remain to be mapped (the
emulator path: trace these index→data transactions live).

## 13a. Configuration space — UNLOCKED and dumped live (2026)  ✅ **[RE]**
The SCAMP config registers are accessed through the indexed pair **`0x74` (index) / `0x76` (data)**,
with the index masked to 7 bits (`and al,0x7F`). They read **all-`0xFF` after POST** because the BIOS
*locks* config access on the way out. The lock is the **`0x22/0x23` config gate** — decoded from the
BIOS helper table at `F000:DB60–DC90`:

```
enable  (F000:DB6F):  out 0x23,0x00 ; out 0x22,0x80 ; out 0x22,word 0x0080
disable (F000:DB8E):  in ax,0x22 ; and ax,0xFFFD ; or ax,0x100 ; out 0x22,ax   (bit8 = locked)
```

With access enabled, `0x74/0x76` returns the real config. **It must be done atomically** — the gate
re-locks between separate bus transactions (a serial round-trip per access shows `0xFF`; a single
code run reads it). Full dump captured live (`scamp_config.txt`):

```
 idx  0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
 00: 00 bb 80 00 ff ff ff ff ff ff ff ff ff 6f 7e 50
 10: 80 00 00 90 f0 e4 a1 00 00 00 00 00 00 00 00 00
 20: 8e 02 00 00 00 00 00 00 00 00 00 00 00 00 98 8a
 30: 10 14 10 20 08 ba 9e f1 5a 50 f1 3c 0a 1e 2c 01
 40: 02 05 01 88 03 00 00 00 00 0a 03 88 05 00 00 00
 50: 08 1e 11 88 11 00 00 00 0c 00 00 88 00 00 00 00
 70: 00 00 00 00 00 00 10 4f 0f 10 53 4c 00 10 15 ee
```
- **idx `0x7A/0x7B` = `53 4C` = "SL"** — the SCAMP signature (the same `BH='S'/BL='L'` the APM
  machine-check in `PS2.EXE`/`ULTRACHG.COM` verifies), confirming the read is genuine config data.
- The BIOS's low-level register-access helpers (all in `F000:DB60–DC90`) reach a **family of indexed
  banks**, each a get(index→read)/set(index→write) pair:

  | Index / Data ports | Bank | Live |
  |---|---|---|
  | `0x74` / `0x76` | **SCAMP (VL82C420) config** | real (with `0x22/0x23` enabled) |
  | `0x24` / `0x25` | config bank (init'd `←0xFA,0x01`) | reads `FF` on this unit |
  | `0xD00` / `0xD01` | config bank | reads `FF` |
  | `0x35EA` / `0x35EB` | Pluto/EC bank (32 regs, wraps) | **real** — see [Pluto](../Pluto/) |
  | `0xEC` / `0xED` | power MCU (U6) | real telemetry |
  | `0x70` / `0x71` | RTC/CMOS (with NMI bit) | real |
  | `0x3F0` / `0x3F1` | FDC config (Pluto) | real |

Exact per-index *semantics* (DRAM timing, shadow-RAM enables, decode windows, PM) still need the
absent VLSI datasheet, but the values are now **readable ground truth** to map against the SCAMP-II
manual / Intel 486SL twin. This resolves Open Question #1's "config not readable" blocker.

## 13b. Config-space structure & the datasheet-cross-reference attempt (2026)  **[RE]/[H]**

Before assigning meanings we can read *structure* straight off the dump — this part is
datasheet-free and defensible:

| Region | Bytes | Character |
|---|---|---|
| `0x00–0x0F` | `00 bb 80 00` then `FF`… then `6f 7e 50` | header / ID + a small descriptor tail; the `FF` gap (`0x04–0x0C`) is *unimplemented*, not zeroed |
| `0x10–0x5F` | dense, mostly non-zero (`80 00 00 90 f0 e4 a1 …`, `8e 02 …`, the `0x30`/`0x40`/`0x50` rows) | the **programmed** register block — DRAM/decode/PM control words the BIOS actually writes |
| `0x60–0x6F` | (absent from dump / all-zero) | unused window |
| `0x70–0x7F` | `00…10 4f 0f 10` · `53 4c` · `00 10 15 ee` | **signature + I/O-descriptor tail** |

The tail is the interesting part. idx `0x7A/0x7B` = **`53 4c` = "SL"** (confirmed signature), and it
is immediately followed by idx `0x7C–0x7F` = `00 10 15 ee`. The bytes **`15 ee`** land squarely
inside the **EC block A** I/O page (`0x15E8–0x15EF`) documented in [Pluto §6c](../Pluto/). This
mirrors the Pluto `0x35EA` bank, which stores its own block base **`0x35E8`** at idx `0x13`. So
*both* on-chip descriptor banks appear to carry **embedded-controller I/O-window addresses**
(`0x15xx` here, `0x35E8` in Pluto) — a cross-validated hypothesis **[H]** that the SCAMP config tail
and the Pluto bank are two views of the same resource-descriptor scheme naming the EC mailbox
windows.

**Datasheet cross-reference — attempted, and why it's deliberately *not* used for a per-index
decode.** The only surviving SCAMP-family databook is the **VLSI `VL82C310/82C311/82C311L` Data
Manual (Jan 1992)** — the original **SCAMP-LT** (286 / 386SX) generation — on
[bitsavers](https://bitsavers.org/components/vti/pc/VTI_VL82C310_82C311_82C311L_Data_Manual_199201.pdf)
and [dosdays](https://www.dosdays.co.uk/media/vlsi/VL82C310.pdf). It was fetched (6.5 MB) but is a
**scanned image PDF with no text layer**, and — more decisively — it is **a full generation older**
than our part: the VL82C420 is **SCAMP-IV** (486SL-class, 1993), which integrates DMA/PIT/PIC/RTC
and a power-management SMI engine the VL82C310 does not have. Its configuration index map does **not**
transfer register-for-register. Cross-mapping VL82C310 indices onto this dump would produce
confidently-wrong annotations, so we intentionally record only the **structure** and the **[H]**
EC-descriptor finding above. A trustworthy per-index decode needs either the (apparently non-extant)
VL82C420 databook or **safe host-state correlation at a physical console** — the obvious lever, CPU
speed via `PS2 SPEED`, is *unsafe over the serial link* (it starves the 115200-baud console) and so
is deferred to on-device work.

## 13c. Integrated peripheral cores — live state (2026)  ✅ **[RE]**

§4/§13 list the standard peripheral cores the VL82C420 absorbs (from the 486SL/82360SL twin). Those
cores are now **verified live** on the running unit with read-only probes (pure `in`, plus standard
OCW3 / PIT read-back sequences — no config writes, no CPU-speed change):

**Dual 82C59A PICs — and the real PC110 IRQ map.** Interrupt-mask registers read `0x21 = 0xA8`,
`0xA1 = 0xAC`; IRR/ISR on both were `0x00` (idle, no interrupts in service at sample time). Decoding
the masks gives the machine's actual live IRQ allocation:

| IRQ | Owner | State | | IRQ | Owner | State |
|---|---|---|---|---|---|---|
| 0 | system timer (PIT) | **enabled** | | 8 | RTC | **enabled** |
| 1 | keyboard (M38813) | **enabled** | | 9 | (free/PCIC) | enabled |
| 2 | cascade → PIC2 | **enabled** | | 10 | — | masked |
| 3 | COM2 | masked | | 11 | — | masked |
| 4 | **COM1** (COMrade link) | **enabled** | | 12 | aux / pointing | enabled |
| 5 | (free) | masked | | 13 | FPU | **masked (no FPU — 486SX)** |
| 6 | floppy (Pluto FDC) | **enabled** | | 14 | ATA / IDE | **enabled** |
| 7 | LPT | masked | | 15 | — | masked |

IRQ13 masked is a direct corollary of the FPU-less 486SX; IRQ4 live is the serial console this probe
runs over; IRQ6/IRQ14 match the floppy + ATA subsystems.

**82C54 PIT, channel 0.** Read-back status = `0x36` → **mode 3** (square-wave), **binary**, LSB-then-MSB
access; the counter read `0xE854` then `0x0DC8` on successive samples (**decrementing**), and the BIOS
tick at `40:6C` advanced — i.e. the live ~18.2 Hz system tick (reload 0 = 65536, 1.193 MHz/65536).

**Dual 82C37 DMA.** Both status registers (`0x08`, `0xD0`) read `0x00` (idle, no TC/requests). Page
registers `0x80–0x8F` are mostly `0x00` with ch2 (floppy) page `0x81 = 0xFE` and the refresh page
`0x8F = 0xFF` — both controllers present and initialised.

**System-control ports.** `0x92 = 0x02` → the PS/2-style **fast-A20 gate is implemented and A20 is
enabled** (bit1), fast-reset (bit0) idle. `0x61 = 0x20` → speaker/timer-2 idle, timer-2 OUT high.
`0x64 = 0x1C` → the 8042-style KBC (Pluto + M38813) reports **SYSFLAG set** (POST completed),
keyboard not inhibited.

**MC146818 RTC core.** CMOS control registers read live: **reg A** `0x26` → 32.768 kHz oscillator
running, periodic-interrupt rate 1024 Hz; **reg B** `0x02` → 24-hour / BCD, no RTC interrupts armed;
**reg D** `0x80` → **VRT = 1 (CMOS backup battery good, RAM/time valid)**; **reg E** (POST diagnostic
status) `0x00` → **no POST errors** (checksum/config/memory all OK); floppy-type byte `0x10 = 0x40` →
drive 0 = 1.44 MB 3.5″; equipment byte `0x14 = 0x25` matches the BDA equipment word. The RTC date read
back as the correct current date, so the integrated MC146818 keeps time on the coin-cell.

**BIOS equipment word** (`40:10`) = `0x4225` → 1 diskette drive, **no math coprocessor**, 80×25
colour, 1 serial + 1 parallel port; base memory `40:13` = **640 KB**. Every field matches the PC110's
known configuration, confirming the integrated cores are the ones enumerated to DOS.

Net: the VL82C420's integrated **8259A×2 / 8254 / 8237×2 / MC146818 / port-92 / 8042-interface** cores
are all present and behave exactly as the 486SL-twin documentation predicts — and the probe pins down the
board's concrete IRQ/DMA assignments, which the datasheet alone can't give.

## 13d. Upper-memory decode & shadow map (2026)  ✅ **[RE]**

The VL82C420 is also the **address decoder** for the upper 384 KB (`C0000–FFFFF`). A read-only scan
(16 KB granularity) of a running unit shows how the SCAMP currently maps that space:

| Region | Size | Decode | Contents (live) |
|---|---|---|---|
| `C0000–C7FFF` | 32 KB | ROM | **VGA BIOS** — `55 AA` header, "IBM VGA Compatible BIOS" (the C&T F65535's option ROM) |
| `C8000–CBFFF` | 16 KB | sparse | VGA-BIOS tail / scratch (mostly zero) |
| `CC000–EFFFF` | 144 KB | **open** | reads all-`FF` at rest — **free UMA** |
| `F0000–FFFFF` | 64 KB | ROM | **system BIOS** |

Two PC110-specific windows live inside the "open" span but are **unmapped at rest**, which is why the
scan sees `FF` there:
- **`D0000` EMS page-frame** — only mapped when an expanded-memory manager is loaded (matches the
  `EMS FRAME=D000` requirement noted for the DOS/PM software); no EMM in this boot → `FF`.
- **`E0000` (`0xDE000`) font-ROM window** — the 1 MB banked font ROM is only visible when a bank is
  selected via ports `0x1160–0x1163`; deselected → `FF`. (Dumped separately; see the font-ROM notes.)

So at rest the SCAMP presents ~144 KB of contiguous free upper memory (good for UMBs), with the two
private windows paged in on demand.

**Firmware IDs captured in passing** (from the ROM banners):
- **System BIOS:** IBM part number **`39H4551`**, "© COPYRIGHT IBM CORPORATION 1981, 1995", build
  date **`11/08/95`** (also at the `F000:FFF5` BIOS date stamp).
- **VGA BIOS:** "IBM VGA Compatible BIOS" at `C0000`.

## 13e. Font-ROM banking window — live geometry (2026)  ✅ **[RE]**

The PC110's **1 MB font ROM** (OKI **MSM538032E**, U36 — see [65535 §4](../65535/)) is not memory-mapped
in full; it is paged into a small window in the upper-memory area. Exercising the control ports live
(and restoring them after) pins down the exact mechanism and geometry:

| Port | Role | Live |
|---|---|---|
| `0x1160` | **bank select** | `0x00` at rest; **7-bit** (see below) |
| `0x1161` | (unused / `0xFF`) | `0xFF` |
| `0x1162` | window **segment** high | `0xDE` → window at **`0xDE000`** |
| `0x1163` | window **enable** | `0x01` (on) |

- **Window is 8 KB at `0xDE000`** and the bank register is **7 bits** → **128 banks × 8 KB = 1 MB**,
  exactly the ROM size. The 7-bit width is proven by aliasing: bank `0x80` reads identical to bank
  `0x00`, and `0xC0` identical to `0x40` (bit 7 is ignored). This is why a plain UMA scan sees `0xDC000`
  as `FF` — only the top 8 KB of that 16 KB block is the live font window.
- **Bank contents** (window `0xDE000`, first 16 bytes per bank):

  | Bank | Sample | Meaning |
  |---|---|---|
  | `0x00` | `55 aa 10 cb … 46 4f` | **directory/header** — `55 AA` signature + `"FO…"` (`FONT`) tag |
  | `0x01` | `00 00 00 …` | reserved / gap |
  | `0x02` | `00 00 00 00 3f fc 20 04 20 04 …` | **glyph bitmaps** (character cells) |
  | `0x08` | `10 0e 10 70 20 10 3e ff …` | glyph bitmaps |
  | `0x10` | `04 20 09 fc 08 24 17 ff …` | glyph bitmaps |
  | `0x20` | `22 40 14 40 08 40 18 40 …` | glyph bitmaps |
  | `0x7F` | `cc cc cc …` | top bank (filler/last region) |

The `55 AA`/`FONT` header at bank 0 is the same signature the diagnostics check (see PS2TUI's font-ROM
test). The full 1 MB was dumped earlier (font-ROM CRC-32 `e283a043`); this section documents the
*addressing* — a host writes a bank to `0x1160` and reads the glyph data at `0xDE000`. The ROM silicon
is fed to the display path via "Bowman" (`OKI_SA*` nets, see [Bowman](../Bowman/) / [65535 §4](../65535/)).

## 14. IBM PC110 implementation  **[RE]**
- The VL82C420FC5 is **U61** (BGA256); it pairs with the IBM custom gate-array ASIC **"Bowman" (U21)**
  over the 5-line ML bus (`Bowman1–5`).
- Integrated-RTC outputs `RTC-SQW`/`RTC-IRQ#` route (via an HD151015 bus switch) to the **M38223
  power-sense MCU**.
- Two pulled-up strap inputs (`PullDN1/2`, balls R8/N8) set chipset config/test mode.
- Board CPU debug: headers **J9 (Debug-10)** and **J12 (Debug-6)** expose the 486's HOLD/AHOLD/cache/
  reset control signals + a JTAG TAP — a HOLD-method ICE/debug interface.

## 15. Documentation status & how to learn more
- **No datasheet/databook** for the VL82C420 exists on bitsavers, DatasheetArchive, DOS Days, or
  The Retro Web (bitsavers' VLSI PC collection stops at the VL82C114, March 1993).
- **Best authoritative sources:** the patents above (esp. US 5,793,990); the **Intel 486 SL** /
  **82360SL** datasheets (architectural twin) for ~95% of the pins; standalone **82C37/82C54/82C59A/
  MC146818** datasheets for the integrated cores; and the predecessor **SCAMP / SCAMP II** data manuals
  on bitsavers.

## 16. Open questions
1. Per-index *semantics* of the config space (DRAM timing, decode windows, PM). The registers are
   now **readable** and their **structure** is mapped (§13a/§13b): header/ID, a dense programmed
   block `0x10–0x5F`, and a signature+I/O-descriptor tail. Remaining gap is the value→function map;
   the SCAMP-LT (VL82C310) databook is a generation older and does **not** transfer, so this needs a
   VL82C420 databook (none known) or safe on-device host-state correlation (not CPU-speed, which
   breaks the serial link).
2. `VL_F5` — the ring/modem-resume wake input (VLSI-specific, not in the Intel datasheet).
3. `VL_A14/B14/C14/A15` — confirm as VCC vs extra DRAM `MA12`.
4. ~~The exact ML-bus 1:1 mapping of `Bowman1–5`.~~ **RESOLVED by live logic-analyzer capture
   (2026-07-06, Saleae Logic Pro 16; re-corrected 2026-07-18) — see §11b.** The `Bowman1–5` nets (U61
   balls N9/P9/R9/T9/T13) and the `Chipset_IO1–5` pins (Bowman U21 45/140/39/52/130) are the **same five
   wires — the ML bus** (an earlier note here calling `Bowman1–5` a "Bowman↔Pluto link" was a netlist
   misread; Pluto has no ball designators). Adopted mapping, applied in KiCad: **MLCLK = Bowman3/R9/pin 39**
   (~22.7 MHz, measured), **MLADS# = Bowman4/T9/pin 52** (per-cycle strobe, measured), **MLRDY# =
   Bowman1/N9/pin 45, MLLBA# = Bowman2/P9/pin 140, MPriority = Bowman5/T13/pin 130** (static trio).
5. How Bowman raises interrupts to the VL82C420's 8259 pair over the ML bus (§11a caveat — the
   memory-mapped scheme of US 5,805,901 is the HCI bus, not this one).

## 17. Sources
- Patents: [US 5,793,990](https://patents.google.com/patent/US5793990A/en),
  [US 5,715,467](https://patents.google.com/patent/US5715467A/en),
  [US 5,561,772](https://patents.google.com/patent/US5561772A/en),
  [US 5,805,901](https://patents.google.com/patent/US5805901A/en),
  [US 5,655,142](https://patents.google.com/patent/US5655142A/en).
- Trade press: [Tech Monitor, "VLSI Technology has 80486SL notebook chip set," 17 Jun 1993](https://www.techmonitor.ai/technology/vlsi_technology_has_80486sl_notebook_chip_set);
  [QuadNote/Compaq, 10 Feb 1994](https://www.techmonitor.ai/technology/vlsi_technology_offers_compaqs_80486_sub_notebook_chip_set).
- [The Retro Web — SCAMP IV](https://theretroweb.com/chipsets/568).
- [DOS Days — VLSI Technology](https://www.dosdays.co.uk/topics/Manufacturers/vlsi.php).
- Intel 486 SL datasheet (Intel 241325 / "KU82360" scan) — architectural twin.
- IBM PC110 schematic, BIOS dump, and the reverse-engineered `vl82c420_pinmap.xlsx` (Open-Source-PC110).
- Companion reconstructed docs in this project: `VL82C420_Technical_Reference.pdf`,
  `VL82C420_vs_486SL_reconciliation.md`, `PC110_VL82C420_analysis.md`, `SCAMP_IV_dossier.md`.

*Compiled from the full Open-Source-PC110 investigation. Where the chip's behavior is inferred rather
than documented, it is tagged. Two former unknowns are now resolved: the **ML-bus cycle protocol** is
decoded from US 5,793,990 (§11a), and **`0x4F` is the CMOS/RTC extended-index port** (written in lockstep
with `0x70`, data at `0x71`), not a chipset-config latch — see the correction in Service-Manual §8.4. The
part still lacking official documentation is the per-index *semantics* of the `0x74/0x76` SCAMP config
space (§16.1) and the physical `Bowman1–5`→ML-signal pairing (§16.4).*
