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
  | `0xEC` / `0xED` | **VL82C420 shadow/cache/ROM config** (§13j.5; *not* the power MCU — that label is retired) | real config regs |
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

### Datasheet hunt — exhaustive verdict + patent-sourced architecture (2026-07-20)  **[RE]**
A full web/patent/bitsavers/archive sweep confirms: **no VL82C420, VL82C144, VL82C146, or VL82C410
databook is publicly obtainable anywhere** — so there is no index-level `0x74/0x76` map to be had. But
patents pin down the *architecture* and give usable cross-references:

- **Indexed-register model — patent US5659680** (SCAMP-family diagnostic patent): the extension
  registers are *"indexed and accessible … after setting the index register,"* **all one byte wide**,
  and control *"the memory controller, power management, clock controls, etc."* — and it states the
  SCAMP data manual carries **~100 pages** of register detail (exists on paper, never digitised).
- **Programmable index base — patent US6021498A** (AMD PM-unit): the index/data **port base is
  software-settable**, which is exactly why the same SCAMP register architecture appears at **0xEC/0xED**
  (SCAMP II), **0x24/0x25** (VL82C480 lineage) and **0x74/0x76** (our VL82C420). Same design, relocated
  window — so sibling maps transfer by *function class*, not by index number.
- **The `0x22/0x23` unlock is Intel, not VLSI — patent US5630052** ("system development and debug tools
  for power management"): the three-write/four-read `0x22/0x23`(+`FC23/F023/C023`) gate is a generic
  Intel PM-debug mechanism. (Corrects the earlier "SCAMP unlock" attribution — it's the 386SL/486SL PM
  lineage, matching the "SL" signature at idx `0x7A/0x7B`.)

**Best cross-references to OCR-and-map against the live dump** (all image-only, no text layer):
| Source | bitsavers/URL | Maps to |
|---|---|---|
| **VL82C480** 486 sys/cache/ISA controller datasheet | `components/vti/pc/VL82C480.pdf` | **the `0x24/0x25` second window** — same `22/23`-unlock + `24h/25h` index/data; DRAM/interleave/RAS-CAS timing/parity/384 KB shadow A0000–FFFFF |
| **Intel 386SL Data Book / 82360SL** | `components/intel/80386/240814-005_386SL_Data_Book_Jul92.pdf` | **`0x74/0x76` PM indices** — SMI/STPCLK/suspend-resume/DMA/PIC/PIT/RTC (the 82360SL cores the VL82C420 absorbs) |
| VLSI **SCAMP II** (VL82C316/323) manual | `components/vti/pc/VTI_VL82C316_VL82C323_SCAMP_II_199210.pdf` | register *functions* (DRAM/refresh/clock/ISA/shadow); index numbers differ (that gen bases at 0xEC/0xED) |

yyzkevin's PC110 RE independently corroborates the **`0x24/0x25` second window** (`22/23`-unlock +
`24h/25h`, from disassembling `xpatch.exe`) but likewise reaches no index semantics. **Net:** the safe
route to `0x24/0x25` (block2) meaning is the **VL82C480 datasheet** (function-class mapping, marked
`[H]` until poked), *not* live hardware — see §13g for why the live unlock is not viable.

### VL82C480 datasheet — OCR'd, mapped against our dump (2026-07-20)  **[RE]/[H]**
Fetched the image-only VL82C480 datasheet (bitsavers, 40 pp) and OCR'd it. Its **Table 3 — Indexed
Configuration Registers Map** is the SCAMP-family register vocabulary we lacked (VL82C480 accesses these
via **`ECh` index / `EDh` data**, per its Table 4 — *not* 24/25; the earlier note was imprecise):

| idx | reg | function |
|---|---|---|
| `00h` | VER | product code / device version |
| `01h` | RAMTMG | DRAM timing — `TRP`/`TRCD`/`TCAS` |
| `02/03h` | RAMCFG0/1 | DRAM bank 0–3 type (static/dynamic, size) |
| `04h` | RAMSET | interleave `INTLV`, parity, `RAMDRV`, page-mode |
| `05h` | NTBREF | turbo + refresh mode/speed |
| `06h` | CLKCTL | clock dividers (`CLKDIV`/`FCLKDIV`/`SCLKDIV`) |
| `07h`/`19h` | MISCSET/CACHCTL | cache enable/tag/size, parity |
| `08h` | DMACTL | DMA wait-states/clock |
| `09h` | BUSCTL | ISA cmd-delay/wait-states; MSB disables the fixed I/O decodes |
| `0Ch` | ROMSET | ROM width/relocate/`MBIOS`/wait-states |
| `0Dh–12h` | AAXS–FAXS | **per-16 KB shadow-access** for `A0000–FFFFF` (4 nibble-fields each) |
| `13h–18h` | ACBL–FCBL | per-16 KB **cacheable** enables for the same regions |
| `20h–23h` | PMRA/PMRE | programmable memory regions (`LBA_ISA`, `NCBL`, addr, region-enable) |

Table 4 dedicated ports: `61h` Port B, `70h` NMI-enable, **`92h` Port A (fast A20/reset — the port our
write-guard deny-lists)**, `EC/ED` config index/data, `EE/EF` fast-A20/CPU-reset, `F9h/FBh` **config-enable
(dummy write disables config access)**.

**Cross-check against our live `0x74/0x76` dump — functions map, indices do NOT:** idx `00`=`00`(VER),
`01`=`BB`(RAMTMG), `02`=`80`(RAMCFG0) *plausibly* line up, but at `04h` the VL82C480 has RAMSET while
**ours reads `FF` (an unimplemented gap `0x04–0x0C`)** — so the layouts diverge immediately, and block2's
observed indices (`0x2E/0xB7/0xBD/0xF9/0xFA`, Pass 2) fall **outside** the VL82C480's `00–23h` range. The
VL82C420 is a different part (SCAMP-IV notebook, PM/SMI added, config at `0x74/0x76`; software-relocatable
base per US6021498), so the databook supplies the **register categories/names as an `[H]` template** —
useful to reason about the dump's dense DRAM/shadow/cache-shaped regions — but **not a confirmed
per-index decode**. A confirmed decode still needs the (non-existent) VL82C420 databook or live pokes,
and live pokes hang the box (§13g). This closes the datasheet avenue: **best-achievable is a
function-class `[H]` annotation, not a byte-level map.**

**386SL Data Book — also checked, no register map (2026-07-20).** Fetched the Intel 386SL SuperSet Data
Book (bitsavers, 258 pp, `240814-005`) for the `0x74/0x76` PM/SMI indices. Its **82360SL section (4.0) is
pin assignments, signal descriptions, D.C./timing/crystal specs only — there is no configuration- or
PM-register map**; the register-level programming reference lived in a separate 386SL *System Design
Guide / Programmer's Reference* that is not on bitsavers or elsewhere found. So it confirms the PM
architecture (SMM, `SMI#`, `STPCLK#`) but supplies nothing to annotate our PM indices. **Both datasheet
routes are therefore exhausted:** VL82C480 gives the SCAMP-family register *vocabulary* (function-class
`[H]` template above); the 386SL book gives no register detail at all. Net final verdict for the
VL82C420 config space: **no public source yields a byte-level decode** — it needs the non-existent
VL82C420 databook, and live confirmation hangs the box (§13g).

## 13g. Block2 (`0x24/0x25`) live-unlock — safe after all; block2 is write-only  **[RE 2026-07-20]**
**First attempt HUNG the box** — a DEBUG routine that did `cli`; enable (`out 0x23,0`; `out 0x22,0x80`;
`out 0x22,w 0x0080`); read `0x24`→`0x25`; re-lock; `sti`, loaded via DEBUG's `e 100 <~50 hex bytes>`
typed over the console. Needed a physical power-cycle.

**Re-attempt (2026-07-20) with two fixes — no hang:** (1) loaded via **interactive `a 100` assembly**
(reliable; the long `e`-command hex was almost certainly corrupted by a dropped console keystroke →
CPU ran garbage), and (2) **no `cli`** (so a soft stall can't freeze COMRADE's ISR). The identical gate
sequence then **ran to completion, box stayed alive.** So the hang was our *method* — the corrupted
byte-load plus `cli` — **not** block2 being inherently fatal. (§13g's original "not safely readable"
conclusion is overturned; the deny-list still fences these ports as a sane default, override with
`unsafe`/a DEBUG routine.)

**But block2 (`0x24/0x25`) is not READABLE** — reads return `0xFF` under every condition tried:
- plain `out 0x24,idx; in 0x25` → `FF`; with the §13a `0x22/0x23` gate enabled → still `FF`;
- swept idx `0x00–0x1F` (gate on) → all `FF`; specific idx `0x2E`/`0xB7` (which Pass-2 saw the *machine*
  read as `0x0F`/`0x20`) → `FF`;
- wrote idx `0x55` to `0x24` then read `0x24` back → `FF` (unlike `0x74`, which **does** read back its
  last index). So `0x24` is not even an index-readback port.

Conclusion: **block2 is write-only / its read path is not decoded** on this unit — the BIOS *writes*
config there (Pass-2 showed `0x24←idx`, `0x25←val`) but nothing reads back. The §13a `0x22/0x23` gate
unlocks the `0x74/0x76` SCAMP window (already readable), **not** the `0x24/0x25` window. So block2's
*contents* can't be obtained by reading at all — the only window into it is **watching the BIOS write
it**, which the earlier logic-analyzer effort already did.

**What the BIOS writes to block2 — from the Pass-2 live capture** ([Pluto probe-plan, Pass 2]
(../Pluto/pluto-probe-plan.md)), the only view we have of a write-only port:

| `0x24` index | `0x25` value(s) seen |
|---|---|
| `0x2E` | `0x0F` |
| `0xB7` | `0x20`, then written `0x5F` |
| `0xBD` | `0x00` |
| `0xF9` | `0x00` |
| `0xFA` | `0x01` |

**Cross-check refines the research guess:** every block2 index the BIOS touches is **high
(`0x2E–0xFA`)** — *outside* the VL82C480 Table 3 range (`00–23h`, §13b). So **block2 is NOT the
VL82C480-style config window** the datasheet hunt tentatively mapped it to; it is a distinct
**high-8-bit-indexed write-only space** (candidate: VL82C420 PM/SMI or a device-specific config the
486SL-class part adds over the desktop VL82C480). A fuller decode now needs a **static disassembly of the
main PC110 BIOS's block2-write routines** — which does *not* exist yet (only the M38 power-MCU
[PSU-MB-M38](../PSU-MB-M38/), the KBC MCU [U67](../../Components/U67-M38813E4HP/), `PS2.EXE`
[PS2](../PS2/) and `ULTRACHG.COM` [ULTRACHG](../ULTRACHG/) are disassembled; the system BIOS's chipset-init
code is not). That is the concrete next step for block2 — and it is offline/safe (no hardware).

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

## 13f. Controlled-change register attribution (live, 2026-07-19)  ✅ **[RE]**
Using COMrade's `config_snapshot`/`config_diff` (new toolkit) around **physical changes made at the
box** — snapshot, act, re-snapshot, diff — to attribute registers by cause and effect. RTC-tick
registers filtered as noise. Findings so far:

| Change made | Register that moved | Attribution |
|---|---|---|
| **Caps Lock LED on** | BDA `0040:0017` bit 6 only | (method validation) — Caps state is BDA/KBC only; **no** chipset/EC register |
| **AC adapter unplug/replug** | EC-B (`0x35EA`/`0x35EB`) idx `0x06` bit 1 + idx `0x09` bit 3 | **AC-present** (set = on battery); reversible — see [Pluto §"0x35EA bank"](../Pluto/readme.md) |
| **Volume up/down** (hardware buttons) | **CMOS `0x73`** (via `0x70`/`0x71`) | **volume level** — high nibble = 0..7 (min `0x08`, mid `0x48`, max `0x78`; bit 3 a constant flag), reversible/monotonic |
| **Cover close** | *(box suspends)* | `PS2 Cover=Enable` on this unit → **closing the cover suspends** the CPU (COMRADE freezes, link drops; clean resume on reopen). Behavioural, not a latched register. |
| **`PS2 VEXPANSION ON/OFF`** | **CMOS `0x72` bit 2 + `0x78` bit 3** | vertical-display-expansion setting; redundant storage, reversible. (Display is the C&T 65535, not the VL82C420 — this is CMOS *storage*.) |
| **`PS2 PMODE`** | *(nothing in surface)* | "effective only after you disconnect the AC adapter" → stored in the power-MCU / applied on battery, **not** live in SCAMP config. |

**Why controlled-change does *not* crack the SCAMP config (`0x74/0x76`) semantics:** `PS2.EXE` settings
are written to **CMOS or the power-MCU and applied at boot/on-battery**, so they do not live-reprogram the
SCAMP config space (verified: VEXP → CMOS only; PMode → boot-applied, no live register). So the method
maps *setting storage*, not chipset-register meaning. Per-index SCAMP-config semantics remain blocked on
the absent VL82C420 databook (§13b) — controlled-change cannot substitute for it here.

Negatives worth noting: the **inking pad** (`0x15E0`) can't be mapped this way while idle — its digitizer
needs `INKDRV` loaded (not present on this unit) to produce data. The `0x15E8` EC-A data byte wiggles on
its own (EC command traffic) and is treated as noise. The method is proven; remaining EC-B non-`FF`
indices (`0x02/0x04/0x05/0x07/0x0B`) are candidate battery-gauge/thermal readings — but a **sustained ~11-min battery drain (2026-07-19) left them
completely static**, so they are **not** passively-readable telemetry either: the battery gauge is
**command-driven** via the EC "Zn" mailbox (`0x15E8`/`0x15EC`, [Pluto §6c](../Pluto/)) — you must issue
an EC command and read the reply, not just read the register (same pattern as the inking pad needing its
driver). The only passively-visible EC-B state remains the AC-present bits (`0x06`/`0x09`).

## 13h. BIOS chipset-config code — disassembled: block2 uses a *four-read* unlock  ✅ **[RE 2026-07-20]**
Disassembled the block2 (`0x24/0x25`) config routine straight from the BIOS flash
(`Components/Flash/E28F002BXT/E28F002BXT@TSOP40.BIN`, offset `0x2973C` — it is **banked out of the
runtime `F000` shadow**, which is why §13a/§13g never saw it). The routine:

```
2973C  cli                          ; NMI/IRQ off for the whole gated window
2973D  cld
2973E  mov dx,70 ; mov al,80 ; out  ; out 0x70,0x80 — disable NMI before touching chipset config
29744  mov dx,FC23 ; in al,dx       ; ┐
29748  mov dx,F023 ; in al,dx       ; │ FOUR-READ config-enable
2974C  mov dx,C023 ; in al,dx       ; │ (matches Intel PM-debug patent US5630052)
29750  mov dx,0023 ; in al,dx       ; ┘
29758  mov dx,24 ; mov al,B8 ; out  ; block2 index 0xB8
29760  mov dx,25 ; in al,dx ; mov bl,al   ; read block2[0xB8] -> BL   (a real read!)
29768  mov dx,24/25 ; block2[0xB6] = 0x00
29776  test bl,8 ; jnz ...          ; branch on block2[0xB8] bit3 (a strap/status bit)
2977D  block2[0xFA] = 0x01          ; (bit3 clear path)   [979E path: block2[0xB8]=0x00]
2978F  mov dx,22 ; in ax,dx ; and FFFD ; or 0100 ; out dx,ax   ; RE-LOCK (set the config-lock bit8)
```

**This solves the §13g mystery — the two config windows have DIFFERENT unlock gates:**
- **`0x74/0x76` (SCAMP, runtime)** → the *write-based* gate at `F000:DB6F` (`out 0x23,0`; `out 0x22,0x80`;
  … ; §13a). Already effectively open at runtime, which is why plain `idx_read(0x74,0x76)` returns real
  data.
- **`0x24/0x25` (block2, POST/banked)** → a *read-based* enable: **four reads of `FC23/F023/C023/0023`**
  (preceded by `cli` + NMI-disable). My live attempts (§13g) used the *write* gate — the wrong one — so
  block2 stayed `0xFF`. With the four-read enable block2 becomes readable (the BIOS reads `block2[0xB8]`
  here). So block2 is **not** write-only after all — it just needs the correct gate.

**Block2 registers the BIOS touches** (disasm + Pass-2 live capture, reconciled): `0xB8` (read; bit3 = a
strap that steers the config path), `0xB6 ← 0`, `0xB7` (Pass-2: `0x20`→`0x5F`), `0xBD ← 0`, `0xF9 ← 0`,
`0xFA ← 1`, `0x2E` (Pass-2: `0x0F`). All high indices — consistent with block2 being a distinct
high-index config bank (not the VL82C480 `00–23h` map, §13b/§13g), likely the SCAMP-IV PM/init set.

*Live re-read note:* reproducing the four-read enable over the flaky console-DEBUG path is error-prone
(one mistyped `a`-mode line ran garbage and needed a warm-boot); the **authoritative source is the BIOS
code above**. A reliable live dump would deliver the routine as a CRC-verified `.COM` via COMrade
`write_file` (not console typing) — noted as the clean follow-up. The gate math is now understood either
way.

## 13i. Block2 (`0x24/0x25`) — FULLY READ LIVE with the four-read enable  ✅ **[RE 2026-07-20]**
Confirmed §13h on hardware. Assembled a small CRC-verified `.COM` (`blk2dump.com`) that faithfully
replicates the BIOS gate — `cli`; `out 0x70,0x80` (NMI off); **`in FC23/F023/C023/0023`** (four-read
enable); read `0x24`→`0x25` for all 256 indices into a buffer; re-lock (`0x22` bit8); re-enable NMI; then
write the buffer to a file — delivered it via COMrade `write_file` (no console-typing corruption), ran it,
and read back the result. **Block2 read cleanly — 119 of 256 indices non-`FF` — and the box stayed
alive.** So **block2 is fully readable** (the §13g "write-only" reading is overturned; it was the *wrong
gate*, not a write-only port). Full dump in [`block2_config.txt`](block2_config.txt):

```
 idx  0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
 00: aa aa aa aa aa aa aa aa 40 41 42 43 ff ff 00 0f
 10: 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff
 20: ff ff 11 08 04 01 00 20 0b 0c 00 08 ff ff 80 ff
 40: 00 00 12 00 50 05 ff ff ff ff ff ff ff ff 00 ff
 60: 00 01 00 ff ff 00 00 ff ff ff ff ff ff ff ff ff
 70: 02 ff ...
 80: ff ff ff ff ee 15 ff ...                      (idx 0x84/85 = ee 15 -> 0x15EE, an EC I/O-window ptr)
 90: aa aa aa aa aa aa aa aa c0 41 42 43 aa aa 00 0e
 a0: ff ff 11 70 02 01 00 20 0b ff ...
 b0: ba 9e f0 5a 50 f5 da 00 00 40 00 00 02 ff 10 14   (DRAM-timing block)
 c0: 00 00 00 ff ff ff ff ff f2 03 a1 02 ff ...        (c8: f2 03 a1 02)
 d0: 60 00 24 00 ff ff ff ff 00 00 20 00 ff ...
 e0: 00 00 00 ff ff ff ff ff f4 03 a1 02 ff ...        (e8: f4 03 a1 02)
 f0: 80 00 00 00 10 20 08 07 0e ff ff 18 e0 ff 3f 00
```

**Structure observed:**
- **~`0x80`-stride mirror/banking:** `0x00–0x0F` ≈ `0x90–0x9F` (both `AA×8`, `4x 41 42 43`, `…00 0F/0E`),
  echoing the SCAMP window's 7-bit aliasing — block2 is likely a **two-bank** space.
- **DRAM-timing overlap with the SCAMP `0x74/0x76` window:** block2 `0xB0` = `BA 9E … 5A 50 … 10 14` — the
  same DRAM-timing bytes as SCAMP row `0x30` (`10 14 … BA 9E F1 5A 50 …`). So `0x24/0x25` and `0x74/0x76`
  are **overlapping/related views of the VL82C420 config** (block2 = the banked POST view; SCAMP = the
  runtime view), not two unrelated banks.
- **EC-window pointers:** block2 `0x84/0x85` = `EE 15` → little-endian `0x15EE`, landing in the EC block-A
  page (`0x15E8–0x15EF`, [Pluto §6c](../Pluto/)) — the same self-referential I/O-window-descriptor scheme
  seen in the SCAMP tail (§13b) and the Pluto `0x35EA` bank. Cross-validates that hypothesis.
- The Pass-2 indices are all present and live (`0x2E`,`0xB6`,`0xB7`,`0xBD`,`0xF9`(=FF here),`0xFA`); values
  differ from Pass-2 (state/time-dependent), as expected for live config.

Method note: reproducing the four-read enable via **console DEBUG was unreliable** (a mistyped assemble
line ran garbage → warm-boot); the **`.COM`-via-`write_file`** path (CRC-verified delivery + DOS file I/O
for the result) is the robust way to run privileged probe code on the box, and is the recommended pattern
for any future gated-register work.

## 13j. VL82C420 "SCAMP IV" Config-Register Map — Consolidated & Annotated
> **Integration note (2026-07-20).** This map is the output of a 6-group, adversarially-verified static-analysis workflow over the BIOS flash + the two live dumps. Where it conflicts with earlier sections it is the newer, code-traced evidence: most notably **`0xEC/0xED`**, tentatively labelled "power-MCU mailbox" in §13/the portmap and COMrade's port profile, is here **code-shown to be the chipset shadow/cache/ROM config bank** (a *third* config window; §13j.5, with three internal anchors incl. the F-seg self-shadow patch). Live confirmation of `0xEC/0xED` (read-safe registers only, via the gated `.COM` method) is the recommended next step before treating that revision as final.


### 13j.1 Method & confidence policy

Static analysis only — no hardware was touched to produce this map. All six contributing register-group studies (DRAM/timing, shadow/decode, power-mgmt/SMI, clock/cache/ROM/ISA, misc direct-I/O ports, block2 high-index structure) were independently re-disassembled with `ndisasm -b16` over `E28F002BXT@TSOP40.BIN`, byte-sliced with `dd`/hex where `ndisasm -e` header-skip mislabels operands, and cross-checked against the two live captures:

- **SCAMP window dump** — `Discovery/Chipset/scamp_config.txt` (I/O `0x74` index / `0x76` data, 7-bit mirror, captured 2026-07-02)
- **block2 window dump** — `Discovery/Chipset/block2_config.txt` (I/O `0x24` index / `0x25` data, 256 regs, captured 2026-07-20)

BIOS build **39H4551, 11/08/95**.

**Confidence policy**

- **CONFIRMED** — traced in BIOS code (an `out`/helper write or read+branch to a specific index with known value), *or* a decoded live value that matches known hardware (e.g. a real trapped I/O port, a DRAM-timing signature echoed across both windows).
- **INFERRED [H]** — VL82C480 (sibling 486 chipset) Table-3 category analogy only, or a value-shape guess with no isolated per-index BIOS access. VL82C420 index *numbers* do not transfer from the VL82C480 — functions transfer, indices do not.
- Where a field is not recoverable from code (e.g. the per-bit TRP/TRCD/TCAS split of a timing byte), it is explicitly marked opaque. Nothing here is fabricated.

**Segment / offset caveat.** Flash offsets are authoritative. The SMM-banked config code is SMBASE-relocated: relative branches are self-consistent with `seg:0 = file 0x20000`, but absolute data operands resolve 0x8000 lower (e.g. the SMI dispatch table's `lea si,[0x5D07]` points at file `0x2ED07`). Any "runtime `0xE___`" label in the evidence is a flash-minus-0x20000 display value, not a live segment offset. Two independent reviewers disagree by ~6 bytes on the *flash base* of the SCAMP default image (0x2A076 vs 0x2A07C) — see 13j.9; the image **content** and its byte-exact match to the live dump are not in dispute.

### 13j.2 Config-access mechanism — four concurrent windows

The chipset config space is reached through **four independent indexed windows**, all live at once (proven by single routines that touch two of them — e.g. the C-segment shadow routine at flash `0x33C52` uses `scamp_get/set` for `0x80/0x81` *and* `eced_get/set` for `0x0C/0x0F/0x15`). block2 (`0x24/0x25`) is the window the BIOS **programs**; SCAMP (`0x74/0x76`) is a **runtime read-back view** of the same DRAM/PM state; EC/ED (`0xEC/0xED`) is a **separate bank** holding the shadow/cache/ROM-decode registers.

| Window | Index / data | Role | Access helper (flash) |
|---|---|---|---|
| block2 | `0x24` / `0x25` | 8-bit index (256 regs); POST/init programming view | get `0x2F3BD` (dup `0x3DBC4`); set `0x2F3CA` (dup `0x3DBCF`) |
| SCAMP | `0x74` / `0x76` | 7-bit index (masked `& 0x7F`, 128 regs); runtime read-back | get `0x2F43D` (mirror `0x3DC3E`); set `0x2F44C` (mirror `0x3DC51`) |
| EC/ED | `0xEC` / `0xED` | shadow / cacheable / ROM-decode (VL82C480 Table-3 layout) | get `0x3DBDE`; set `0x3DBEB` |
| Pluto/EC | `0x35EA` / `0x35EB` | embedded-controller indexed window (save/restore across SMM) | `0x2F461` |

**Gating / unlock:**

- **block2 unlock (POST):** routine `0x2973C` — `cli; cld; out 0x70,0x80` (NMI off); **four reads** `FC23/F023/C023/0023` (config-enable, standalone at `0x2F397`); then reads `block2[0xB8]`, tests bit3; re-locks via port `0x22` (`and 0xFFFD; or 0x100`, relock helper `0x2F387`).
- **EC/ED gate:** `out 0xFB` before / `out 0xF9` after a block of accesses (VL82C480 F9h/FBh config-enable convention; observed `out 0xFB@0x33FCA` … `out 0xF9@0x33FDA` around MISCSET, `out 0xF9@0x33BE9` after ROMSET). Gating wraps blocks, not strictly every access.
- **Commit strobe:** `set block2[0xFA]=1` helper (`0x2F3AA`, dup `0x3DBB1`) — asserted last on the normal path.

The helper library at flash `0x2F389` and its runtime duplicate at `0x3DB8E` are byte-identical over 152 bytes (constant bank delta 0xE805).

### 13j.3 SCAMP window (0x74 / 0x76) — runtime read-back view

7-bit index; BIOS reaches these via `0x80`-based indices (`and al,0x7F`). Live values from `scamp_config.txt` (2026-07-02).

| Idx | Name | Function | Live | Decoded | Conf. | Evidence (flash) |
|---|---|---|---|---|---|---|
| 0x00 | SYSCTL / PM state-ctrl | Live system/PM control-status; RMW keyed to CMOS[0x0E] shutdown/diag state (not a timing byte, not a clock divider) | 0x00 | `read; and bh,0x2F; [or bh,0x80]; or bh,0x50; write`; alt reset path writes 0x40; at rest all set-bits clear → 0x00 | **CONFIRMED** | RMW `0x33A22–0x33A4F`; alt `0x3348A` (via idx 0x80) |
| 0x02 | RAMCFG-class header | SCAMP header / RAM-config byte (VL82C480 02h analogy) | 0x80 | bank-type class [H] | INFERRED [H] | no per-index write; default image only |
| 0x03 | RAMCFG-class header | as 0x02 | 0x00 | [H] | INFERRED [H] | default image only |
| 0x0D/0x0E/0x10 | ID / descriptor bytes | Read via idx 0x8D/0x8E/0x90 as ID/signature/descriptor (NOT the EC/ED AAXS/BAXS/DAXS registers) | 0D=6F | ID/descriptor readback | CONFIRMED (read) | SCAMP-code touch set incl. 0x0D/0x0E/0x10 |
| 0x13–0x16 | DRAM bank/size config (runtime-computed) | Values DIFFER from ROM default image ⇒ patched by memory-sizing; candidate SCAMP bank/size fields | 13=90 14=f0 15=e4 16=a1 | size-dependent bank/size fields [H] (ROM default `…90 85 f0 e0 a1…`; live differs at 0x12,0x13,0x15,0x17) | INFERRED [H] | default-image diff; no isolated write |
| 0x30–0x3F | DRAM-timing block (read-back) | Runtime view of DRAM timing; byte-exact ROM default image, reflected from block2 programming | `10 14 10 20 08 ba 9e f1 5a 50 f1 3c 0a 1e 2c 01` | 0x30/31→blk2 0xBE/BF; 0x32–34→blk2 0xF4–F6; 0x35–3A→blk2 0xB0–B5 (0x37,0x3A differ by 1 bit); 0x3B–3F SCAMP-only ext. | **CONFIRMED** | default image (see 13j.9); accessed via `0x2F43D/0x2F44C` |
| 0x40–0x5F | Decode/region descriptors (4× 8-byte) | Structured records, common ctrl byte `0x88` at +3 — structural analog of a VL82C480 PMR/decode-window record; never read/written by code | `40:02 05 01 88 …`  `48:00 0a 03 88 …`  `50:08 1e 11 88 …`  `58:0c 00 00 88 …` | base/limit/attr + enable 0x88 [H] | INFERRED [H] | values from POST init image; no code access |
| 0x77 | (ID/signature) | Read via idx 0xF7 | — | signature read | CONFIRMED (read) | SCAMP-code touch set |
| 0x7A/0x7B | "SL" signature | Chipset ID string, read by BIOS via idx 0xFA/0xFB | 53 4C ("SL") | fixed signature | **CONFIRMED** | live dump + BIOS ID reads |
| 0x7C–0x7F | EC I/O-window pointer | 0x7E(hi)/0x7F(lo) hold an EC mailbox port that BIOS dereferences (`mov dx,ax; out dx,al`); 0x7C/0x7D not read | `00 10 15 EE` | port = 0x15EE (EC-A mailbox) | **CONFIRMED** | deref helper `0x3DCFC`; caller `0x3DD1C` |

### 13j.4 block2 window (0x24 / 0x25) — POST/init programming view

Genuinely 8-bit (both halves hold distinct non-FF values → not a 7-bit alias). 119/256 indices non-FF. Live values from `block2_config.txt` (2026-07-20).

| Idx | Name | Function | Live | Decoded | Conf. | Evidence (flash) |
|---|---|---|---|---|---|---|
| 0x00–0x07 | Identity AA-fill | Hardware power-on/default readback (never programmed; no `AA×8` run in ROM) | `aa×8` | 0xAA = alternating-bit default | INFERRED [H] | no ROM source; not in write set |
| 0x08–0x0B | "@ABC" ID pattern | Hardware ID/scratch readback; bit7 of index reflected into byte 0 | `40 41 42 43` | (idx bit7 → value bit7; cf. 0x98 = `c0 41 42 43`) | INFERRED [H] | only ascending-table hit at `0x3AC98`, not an initializer |
| 0x0E/0x0F | Identity-header tail | Part of hardware default block | `00 0f` | bank-bit reflection vs 0x9E/0x9F | INFERRED [H] | not in write set |
| 0x22–0x2B | ISA/ROM/decode timing (bank0) | Timing-shaped strap row; best structural candidate for ISA wait-state / ROM width (VL82C480 09h/0Ch analog); **never accessed** | `11 08 04 01 00 20 0b 0c 00 08` | per-bank/mode timing set; deltas vs 0xA2 row at +3/+4 | INFERRED [H] | full-flash scan: never read/written |
| 0x2E | P70SHAD | Read-back shadow of write-only NMI-mask/CMOS-index port 0x70; SMM saves on entry, restores to 0x70 on exit | 0x80 | 0x80 = NMI off, CMOS idx 0 (matches `out 0x70,0x80` in `0x2973C`) | **CONFIRMED** | save `0x2EB43`; restore `0x2EBA9` |
| 0xB0 | RAMTMG0 (RAS/CAS low) | Core DRAM timing, low byte; programmed via ED81 dispatch; save/mask/restore in self-refresh handler | 0xBA | =SCAMP 0x35; per-bit TRP/TRCD/TCAS [H] | **CONFIRMED** | dispatch `0x29C3E`; handler `0x2A50B/0x2A566` |
| 0xB1 | RAMTMG1 (RAS/CAS high) | Core DRAM timing, high byte | 0x9E | =SCAMP 0x36 | **CONFIRMED** | dispatch; handler `0x2A504/0x2A570` |
| 0xB2 | RAMTMG2 / refresh-trigger + speed-probe | Timing byte; **bit0 set/cleared in self-refresh handler = refresh trigger**; also toggled by two speed/DRAM-calibration probes that then read status 0xFD | 0xF0 | bit0 = refresh/self-refresh trigger (CONFIRMED); upper bits timing [H] | **CONFIRMED** | handler `0x2A53F–0x2A54A`; probes `0x29A80`, `0x2A544`→read `0xFD` |
| 0xB3 | RAMTMG3 | DRAM timing (2nd word, low) | 0x5A | =SCAMP 0x38 | **CONFIRMED** | dispatch `0x29C3E` |
| 0xB4 | RAMTMG4 | DRAM timing (2nd word, high) | 0x50 | =SCAMP 0x39 | **CONFIRMED** | dispatch `0x29C3E` |
| 0xB5 | RAMTMG5 / control | Timing/control; **bit0 cleared+restored in self-refresh handler**; NOT a clean SCAMP mirror | 0xF5 | bit0 = control latch (CONFIRMED); vs SCAMP 0x3A=0xF1 differs bit2 | **CONFIRMED** | handler `0x2A531–0x2A53C` |
| 0xB6 | DRAM refresh/power + clock/PM mode | Cleared at init; set 0x80 to enter self-refresh on suspend; also a computed clock/PM mode word (`and 0x22 / or 0x40 / cond or 0x01 / or 0x90`) reprogrammed per operating mode | 0xDA | bit7 = self-refresh/suspend enable (CONFIRMED); exact 0xDA path-dependent on selector [0x08] [H] | **CONFIRMED** | init `0x29B71`; suspend `0x2A23C`; RMW mode `0x2F1FA–0x2F235` |
| 0xB7 | SMISRC/SMISTS + self-refresh latch | PM control/status. As SMI source: 7 bits (mask 0x7F), handler reads pending sources, dispatches per-source, clears each by `~mask & 0x7F`. In self-refresh: bit7 set-then-clear latch, bit1 polled as status; init 0x40 | 0x00 | no SMI pending / idle | **CONFIRMED** (dual role — see note) | SMI read `0x2EB4B`, clear `0x2EB5B`; self-refresh `0x2A4D0/0x2A591/0x2A5A2`; init `0x29B86` |
| 0xB8 | Resume/config strap (bit3) | Read at POST entry; bit3 steers cold-boot vs resume-from-suspend path; force-cleared to 0 on both branches | 0x00 | bit3 = resume-from-suspend flag; 0 = cold boot | **CONFIRMED** | read+`test bl,8` `0x29758/0x29776`; clears `0x297A0`, `0x2A2EA` |
| 0xB9 | DRAM control (bit7 latch) | ED81-dispatched; bit7 cleared in suspend path | 0x40 | bit7 cleared at suspend (CONFIRMED); others [H] | **CONFIRMED** | dispatch `0x29C3E`; suspend `0x2A26E` |
| 0xBA | DRAM config | Cleared by init; ED81-dispatched | 0x00 | init=0 [H] | **CONFIRMED** | init `0x29B94`; handler `0x2A5D5` |
| 0xBB | DRAM config | Cleared by init | 0x00 | init=0 [H] | **CONFIRMED** | init `0x29B9B`; handler `0x2A5EA` |
| 0xBC | Refresh / self-refresh ctrl | bit0 set at suspend entry (saved for resume); bit1 cleared later in suspend | 0x02 | bit0=self-refresh enable, bit1 toggled (both CONFIRMED) | **CONFIRMED** | `0x2A201` (\|=1), `0x2A27C` (&=0xFD), save `0x2A1BC` |
| 0xBD | SMICTL1 / DRAM cfg (clear-on-exit) | Written 0 by SMM exit and suspend/POST preamble | 0xff | write behavior CONFIRMED; function [H] | **CONFIRMED** | SMM exit `0x2EBB7`; POST `0x2A2DA` |
| 0xBE | Total-memory / bank-layout code | Written by memory-sizing via ED81 layer after reading bank descriptors | 0x10 | =SCAMP 0x30; size-derived (CONFIRMED); field split [H] | **CONFIRMED** | sizing `0x29CBD`; descriptor reads `0x29CD7` |
| 0xBF | DRAM timing (saved across suspend) | Saved/restored across suspend; written 0x20 at config time | 0x14 | =SCAMP 0x31; timing/precharge [H] | **CONFIRMED** | suspend save `0x2A1DB`; config write `0x29850` |
| 0xC0–C3 | RAMCFG bank0 **/** IOTRAP0 (SMI src 0x01) | Descriptor slot for source/bank bit0 — **empty/disabled** | `00 00 00 ff` | +3=0xFF = empty slot | **CONFIRMED** (struct) | table `0x2ED07`; writer `0x29BFD` |
| 0xC8–CB | RAMCFG bank1 **/** IOTRAP1 (SMI src 0x02) | **Populated** — decodes to real trapped port | `f2 03 a1 02` | base = **0x03F2 (FDC DOR)** CONFIRMED; attr 0x02A1 [H] | **CONFIRMED** | table `0x2ED0E`; port in POST tbl `0x2F95C` |
| 0xD0–D3 | RAMCFG bank2 **/** IOTRAP2 (SMI src 0x04) | **Populated** | `60 00 24 00` | base = **0x0060 (KBC data)** CONFIRMED; +2=0x24 (self-ref config port) | **CONFIRMED** | table `0x2ED15`; POST tbl `0x2F99D` |
| 0xD8–DB | RAMCFG bank3 **/** IOTRAP3 (SMI src 0x08) | slot; base 0 | `00 00 20 00` | base 0; +2=0x20 (PIC1 cmd?) [H] | **CONFIRMED** (struct) | table `0x2ED1C` |
| 0xE0–E3 | RAMCFG bank4 **/** IOTRAP4 (SMI src 0x10) | **empty/disabled** | `00 00 00 ff` | +3=0xFF = empty slot | **CONFIRMED** (struct) | table `0x2ED23` |
| 0xE8–EB | RAMCFG bank5 **/** IOTRAP5 (SMI src 0x20) | **Populated** | `f4 03 a1 02` | base = **0x03F4 (FDC MSR)** CONFIRMED; attr 0x02A1 [H] | **CONFIRMED** | table `0x2ED2A`; POST tbl `0x2F97C` |
| 0x84/0x85 | EC block-A I/O-window ptr | LE word into EC mailbox page (parallels SCAMP 0x7E/0x7F) | `EE 15` | = 0x15EE | INFERRED [H] | live dump; no traced consumer |
| 0x90–0x9F | bank1 copy of identity header | Second hardware-readback identity block (offset +0x90, not +0x80) | `aa×8 c0 41 42 43 aa aa 00 0e` | hardware default readback | INFERRED [H] | not in ROM/write set |
| 0xA2–0xA8 | Alt profile of 0x22 row | Partial +0x80 mirror: `0x22/25/26/27/28` identical, `0x23/0x24` differ ⇒ two related timing profiles | `11 70 02 01 00 20 0b` | deltas at +3 (08→70), +4 (04→02) [H] | INFERRED [H] | never accessed |
| 0xF0 | DRAM mode control | init 0x80; bit7 tested to gate the self-refresh sequence | 0x80 | bit7 = self-refresh mode enable (CONFIRMED) | **CONFIRMED** | init `0x29BC5`; gate `0x2A4C7` |
| 0xF1 | DRAM config | Cleared by init | 0x00 | init=0 | **CONFIRMED** | init `0x29BCC` |
| 0xF2/0xF3 | Top-of-memory / size (hi/lo) | Written from computed 16-bit size (BH→F2, BL→F3) | 00 / 00 | size-derived (CONFIRMED) | **CONFIRMED** | `0x29C55`; size calc `0x29CD0` |
| 0xF4/F5/F6 | DRAM timing | Byte-identical to SCAMP 0x32/33/34; 0xF6 saved + forced 0xFF at suspend | `10 20 08` | =SCAMP 0x32/33/34; 0xF6 live-reg proven | **CONFIRMED** | overlap; suspend `0x2A1E3/0x2A243` |
| 0xF7/0xF8 | Timing/wait-state counts (opaque) | Candidate wait-state counts; **never accessed** | `07 0e` | counts [H]/opaque | INFERRED [H] | full-flash scan: no access |
| 0xF9 | SMICTL2 (clear-on-exit) | Written 0 at SMM exit | 0xff | write CONFIRMED; bit function [H] | **CONFIRMED** | SMM exit `0x2EBC0` |
| 0xFA | EOSMI / SMI re-arm / config-commit | Written 0x01 as the last action before RSM and on config commit | 0xff | write-0x01 strobe (CONFIRMED); reads back FF | **CONFIRMED** | `0x2EBC5` (1 instr before RSM), `0x2977D`, `0x29870`, `0x2F3AC` |
| 0xFB | SMI/PM ctrl (FB) | Cleared 0 in POST; later read-back, **bit3 tested** to steer a far branch | 0x18 | bit3 = PM control/status flag (meaningful); exact meaning [H] | INFERRED [H] (write CONFIRMED) | clear `0x2A2CA`; test `0x2A34F` |
| 0xFC | DRAM/refresh config | Written 0xE0 by init | 0xE0 | init=0xE0; role [H] | **CONFIRMED** | init `0x29BB0` |
| 0xFD | PM/speed status (read-only) | Read as status after 0xB2 speed/DRAM knob toggled; never written | 0xff | status/handshake readback | **CONFIRMED** | `0x29A8A`, `0x2A54D` (read w/ NOP settle) |
| 0xFE | (accessed, opaque) | Touched by BIOS; function not determined | — | opaque | INFERRED [H] | access `0x336C0` |
| 0xFF | PMCTL / suspend command | Power-state trigger: write 0x82 then HLT (enter suspend); 0x00 = running/clear | 0x00 | 0x82 = suspend+HLT (bit7+bit1); 0x00 = active | **CONFIRMED** | `0x2A325`→HLT `0x2A333`; clear `0x297DB` |

**Note on 0xB7 (dual role).** Two independent traces both hit `block2[0xB7]` via the helper: the SMI dispatcher (source/status, `0x2EB4B`) and the DRAM self-refresh sequence (bit7 latch + bit1 status, `0x2A4Dx`). Both accesses are code-confirmed; the register is a power-management control/status byte serving SMI *and* self-refresh duties. The "SMISRC" vs "DRAM control/status" labels are two views of the same PM register.

### 13j.5 EC/ED window (0xEC / 0xED) — shadow / cacheable / ROM-decode

A **third** config bank, distinct from the two the live dumps cover (neither dump captures EC/ED — all live values below are genuinely uncaptured). The PC110 BIOS drives it with the VL82C480 Table-3 shadow/cache/ROM layout, upgrading readme §13b's "[H] template" to a **confirmed per-index decode** for the shadow/cache/ROM group. The complete set of EC/ED indices the BIOS actually touches is exactly `{0x07, 0x0C, 0x0D–0x12, 0x15, 0x18, 0x1A}`.

Segment ordering is self-proving via three internal anchors (no reliance on VL82C480 numbers): **CAXS(0x0F)=C-seg** (programs 0x2A = 3 low 16 KB blocks, matching the measured UMA map §13d and the 48 KB=3-block VGA-BIOS copy), **EAXS(0x11)=E-seg** (transient 0xAA around `call far E900:0006`), **FAXS(0x12)=F-seg** (drives the F000 self-shadow patch §11i). Consecutive indices then fix A/B/D; the CBL base is pinned by parallel offsets (CCBL 0x15=0x13+2 mirrors CAXS 0x0F=0x0D+2).

| Idx | Name | Function | Programmed value | Conf. | Evidence (flash) |
|---|---|---|---|---|---|
| 0x07 | MISCSET / CACHCTL | L1-cache enable: `\|= 0x08` (bit3), then clear CR0.CD/NW + `INVD` | (old \| 0x08) | **CONFIRMED** | `0x33FCA–0x33FEA` |
| 0x0C | ROMSET | ROM/shadow decode: open = `(old & 0x8F)`; relock = `(old & 0x8F) \| 0x20`; wraps the C-seg fill/copy | open 0x00 / relock 0x20 | **CONFIRMED** | open `0x33C77`; relock `0x33CF4`; also `0x33427…0x33CFF` |
| 0x0D | AAXS | A0000–AFFFF shadow-access | group `bh` (0x00/0xFF) | **CONFIRMED** | `0x33C03` |
| 0x0E | BAXS | B0000–BFFFF shadow-access | group `bh` | **CONFIRMED** | `0x33C0A` |
| 0x0F | CAXS | C0000–CFFFF shadow — pins VGA-BIOS C-seg | `(old & 0xC0) \| 0x2A` | **CONFIRMED** | `0x33D22`; group `0x33C13` |
| 0x10 | DAXS | D0000–DFFFF shadow (EMS frame area) | group `bh` | **CONFIRMED** | `0x33C18` |
| 0x11 | EAXS | E0000–EFFFF shadow — E-seg | save → 0xAA transient → restore | **CONFIRMED** | `0x3343A`; group `0x33C21` |
| 0x12 | FAXS | F0000–FFFFF shadow — system BIOS | 0xFF unlock (patch) / 0xAA lock | **CONFIRMED** | setter `0x335A0/0x335A5`; runtime patch `0x3EAB5` |
| 0x13 | ACBL | A-seg per-16 KB cacheable | — (never written) | INFERRED [H] | zero EC/ED sites |
| 0x14 | BCBL | B-seg cacheable | — | INFERRED [H] | zero EC/ED sites |
| 0x15 | CCBL | C-seg cacheable — set in lockstep with CAXS | `(old & 0xC0) \| 0x2A` | **CONFIRMED** | `0x33D12` (falls through to CAXS) |
| 0x16 | DCBL | D-seg cacheable | — | INFERRED [H] | zero EC/ED sites |
| 0x17 | ECBL | E-seg cacheable | — | INFERRED [H] | zero EC/ED sites |
| 0x18 | FCBL | F-seg cacheable (shadowed BIOS) | 0xAA | **CONFIRMED** | `0x33BF8` |
| 0x1A | (misc/status) | Read during memory config; `& 0x07` compared to 3 | read-only | INFERRED [H] | `0x3DF8F` (EC/ED read confirmed; semantics not) |

#> **HARDWARE-CONFIRMED (2026-07-20).** The EC/ED bank was read live via the BIOS gate (`out 0xFB`;
> `out 0xEC,idx`/`in 0xED`; `out 0xF9`) with a CRC-verified `.COM` (dump: [`eced_config.txt`](eced_config.txt);
> box stayed alive). The shadow decode matches exactly: **CAXS(0x0F)=0x2A, FAXS(0x12)=0xAA (F-BIOS
> shadowed+locked), FCBL(0x18)=0xAA, MISCSET(0x07)=0xEC (bit3 L1-enable set), CCBL(0x15)=0x6A=(0x40|0x2A)**,
> ROMSET(0x0C)=0x29 (relock bit5 set). So **0xEC/0xED is definitively the chipset shadow/cache/ROM config
> bank** — the earlier "power-MCU mailbox" label (§13/portmap/COMrade profile) is **retired**. Low-index
> note: the values `00=42 01=D5 02=0B 03=00 04=06 05=A8 06=1A` *superficially* resemble the VL82C480
> `VER/RAMTMG/RAMCFG/...` order, but this was **tested and does NOT hold** (§13j.10) — treat EC/ED
> `0x00–0x06` as opaque, not the DRAM config.

## 13j.6 Cross-window overlap reconciliation

block2 and SCAMP are **distinct banks** (block2 = 8-bit/256, distinct halves; SCAMP = 7-bit/128) presenting overlapping DRAM/timing state. The SCAMP window **de-interleaves** several block2 regions into one contiguous read-back block — the mapping is *not* row-aligned:

| block2 idx | SCAMP idx | Live (blk2 / SCAMP) | Relationship |
|---|---|---|---|
| 0xBE | 0x30 | 10 / 10 | identical mirror (bank-layout / refresh head) |
| 0xBF | 0x31 | 14 / 14 | identical mirror (timing/precharge) |
| 0xF4 | 0x32 | 10 / 10 | identical mirror |
| 0xF5 | 0x33 | 20 / 20 | identical mirror |
| 0xF6 | 0x34 | 08 / 08 | identical mirror |
| 0xB0 | 0x35 | BA / BA | identical mirror (RAMTMG0) |
| 0xB1 | 0x36 | 9E / 9E | identical mirror (RAMTMG1) |
| 0xB2 | 0x37 | **F0 / F1** | differ in **bit0** = refresh trigger (block2 dump 2026-07-20 vs SCAMP dump 2026-07-02; bit0 is set inside the self-refresh handler) |
| 0xB3 | 0x38 | 5A / 5A | identical mirror |
| 0xB4 | 0x39 | 50 / 50 | identical mirror |
| 0xB5 | 0x3A | **F5 / F1** | differ in **bit2** — NOT a byte-identical mirror |
| — | 0x3B–0x3F | (`3c 0a 1e 2c 01`) | SCAMP-window-only timing/refresh extension; no block2 mirror in the dump |

The 1-bit differences at 0x37/0x3A are consistent (a) with the two dumps being from different dates and (b) with those exact bits being live control/refresh bits toggled by the self-refresh handler — i.e. the divergence is expected, not a contradiction. Within block2 itself, the low-half `0x22–0x2B` row partially mirrors `0xA2–0xA8` (+0x80, two related profiles). The EC/ED bank does **not** overlap either dumped window (its live values remain uncaptured).

### 13j.7 DRAM configuration decoded

> **PC110 DRAM controller — confirmed timing & refresh surface**
>
> The DRAM-timing word is captured live and confirmed identical across both config windows:
>
> - **RAMTMG signature:** `block2[0xB0..0xB4] = BA 9E F0 5A 50` ( = `SCAMP[0x35..0x39] = BA 9E F1 5A 50`, differing only in the live refresh-trigger bit of 0xB2/0x37).
> - **Timing pair / counts:** `0xBE/0xBF = 10 14` (=SCAMP 0x30/0x31); `0xF4/F5/F6 = 10 20 08` (=SCAMP 0x32/33/34); 0xF6 is a proven live controller register (forced 0xFF at suspend).
>
> **Self-refresh / refresh control (all CONFIRMED by code):**
> - `0xF0` bit7 = self-refresh **mode enable** (init 0x80; gates the sequence at `0x2A4C7`).
> - `0xB2` bit0 = refresh / self-refresh **trigger** (set/cleared in handler).
> - `0xB6` bit7 = enter self-refresh on **suspend** (set 0x80); live 0xDA.
> - `0xB7` bit7 = self-refresh-**sequence latch**; bit1 = status poll.
> - `0xB5` bit0, `0xBC` bit0 = self-refresh control/latch bits set across the suspend transition.
>
> **Memory sizing (CONFIRMED size-derived):** `0xBE = 0x10` (total-memory / bank-layout code, written after reading bank descriptors); `0xF2/0xF3 = 00 00` (top-of-memory / size word).
>
> **What is NOT determinable:**
> - The **per-bit split** of the RAS/CAS timing bytes (TRP / TRCD / TCAS boundaries) is not recoverable from code — VL82C480 RAMTMG is analogy only, and VL82C420 timing indices differ (VL82C480 timing at 0x01; here at block2 0xB0+/SCAMP 0x30+). Marked [H].
> - **Per-bank population is contested.** The registers at `0xC0/0xC8/0xD0/0xD8/0xE0/0xE8` were read by the DRAM study as per-bank RAMCFG (populated from bank descriptors by the writer at `0x29BFD`), but the same live values decode to **exact real I/O-port addresses** (0x03F2 FDC DOR, 0x0060 KBC, 0x03F4 FDC MSR) that also appear literally in the POST setup table — strongly favoring the **SMI I/O-trap-descriptor** reading (13j.4). These are almost certainly SMI I/O-trap descriptors, not DRAM bank config. Actual per-bank size/geometry is therefore *not* reliably decodable from these registers. (Populated slots decode to FDC/KBC ports; "empty" slots C0/E0 carry the `+3 = 0xFF` disabled pattern.)

### 13j.8 Direct I/O ports touched by BIOS — NOT chipset config

These appear in older port maps but are confirmed to be standard AT/PS-2 integrated-core ports or repurposed DMA-page latches — **no VL82C420 config register lives here**. Not covered by either live dump (write-only or POST-scratch).

| Port | Name | Function | Conf. | Evidence (flash) |
|---|---|---|---|---|
| 0x4F | IODLY | I/O bus-settling **delay / dummy write** (AL is leftover from prior real write); 147 sites, all in F000 | **CONFIRMED (not config)** | `0x3465A`, `0x36885`, `0x3EA3E`, delay loop `0x3BCCB` |
| 0xF1 | NPU reset | 287/387 reset (legacy no-op on FPU-less 486SX); paired with `out 0xF0,0` | **CONFIRMED (not config)** | `0x36883`; region0 `0x16D3C` |
| 0x94 | PS/2 planar/video setup-enable | Gates POS regs 0x100–0x107; `0xDF` unlocks POS 0x102 (VGA enable), `0xFF` locks | **CONFIRMED (not config)** | init `0x3475A`; disable `0x34C6A`; enable `0x34CAF` |
| 0x98 | Planar system-control | `in; or al,3; out` — executes when board-ID **≠ 0x21** (gate `0x3DF56` sets CF iff ==0x21; caller JNC). Bit meaning opaque | INFERRED [H] | `0x38B39`; gate `0x3DF56/0x3DF85` |
| 0x8B | Boot/IPL flag latch | DMA ch5 page reg, repurposed as passive R-M-W boot/feature-flag byte | **CONFIRMED (not config)** | `0x37E5F–0x37F79` |
| 0x88 | POST checkpoint scratch | Spare DMA-page addr; nibble/bit-coded POST state (feeds diagnostic dump) | INFERRED [H] | dump routine `0x34D80`, reads `0x34E1E…` |
| 0x8C | Diagnostic scratch | Spare DMA-page addr; holds status char, stashes byte during option-ROM scan | INFERRED [H] | `0x35A94`; reads `0x34DA2/0x34E6A` |
| 0x8A | POST error-flag latch | DMA ch7 page reg; bits gate IBM POST error strings ("110"/"111" at `0x3E2C6/0x3E2CB`) | **CONFIRMED (not config)** | read `0x34DB8` |
| 0x89 | DMA ch6 page reg | Unused on PC110; read-only in diagnostic dump | **CONFIRMED (not config)** | `0x34D8E` |

### 13j.9 Remaining opaque registers & confirmed absences

**Opaque / [H] only:**
- **Per-bit RAS/CAS timing split** of the RAMTMG bytes (block2 0xB0–B5 / SCAMP 0x35–0x3A) — VL82C480 analogy only; no VL82C420 databook exists.
- **SCAMP 0x3B–0x3F** (`3c 0a 1e 2c 01`) — SCAMP-only, no block2 mirror; timing/refresh counters [H].
- **SCAMP 0x02/0x03** (RAMCFG-class) and **0x13–0x16** (runtime size-patched bank/size fields) — INFERRED.
- **SCAMP 0x40–0x5F** — 4× 8-byte decode/region descriptors (common ctrl 0x88); never accessed by code [H].
- **block2 0x22–0x2B / 0xA2–0xA8** — ISA/ROM timing strap candidates; never accessed [H].
- **block2 0xF7/0xF8** — opaque timing counts (`07 0e`); never accessed.
- **block2 low-half non-FF bytes** 0x40–0x45, 0x60–0x66, 0x70 — reached only via generic helpers with call-site-computed indices; functions unknown.
- **block2 0xBA/0xBB/0xF1** (init=0), **0xBD/0xFB/0xFE** (accessed, function [H]).
- **block2 identity blocks** 0x00–0x0F and 0x90–0x9F — hardware power-on readback patterns (AA-fill, "@ABC", bank-bit reflection), not programmed [H].
- **block2 I/O-window descriptors** 0x84 (0x15EE EC-A), and the C8/D0/E8 port bases — port recognition is strong but no BIOS *consumer* was traced for these as descriptors [H].
- **EC/ED 0x13/0x14/0x16/0x17** (ACBL/BCBL/DCBL/ECBL) — confirmed *never written* (template-fill); **0x1A** — status, semantics unknown.

**Confirmed absences (VL82C480 categories with no VL82C420 register):**
- **No software-writable clock divider (CLKCTL 06h).** Dynamic clock control = the STPCLK/clock-stop power path only: `block2[0xFA] ← 0x01` then HLT/`jmp $`, with ports 0x22/0x23, 0x302 bit3, 0x704 bit0. CPU speed is held in the power-MCU; ML clock (~22.7 MHz) and ISA SYSCLK (8 MHz) are hardware-fixed.
- **No cache config registers (07h/19h/13h–18h in config space).** The PC110 is a cache-less 486SX; the only cache control is the EC/ED MISCSET(0x07) bit3 L1-enable + INVD.
- **No traced ROMSET/BUSCTL programming in config space.** ROM is fetched over the ML/Bowman companion path (fixed timing) then shadowed into DRAM; ISA timing is hardware-fixed 8 MHz.

**Unresolved offset discrepancy (flagged, not fabricated):** two independent reviewers place the flash base of the linear SCAMP default image differently — 0x2A076 (idx N → 0x2A076+N; puts the `10 14 10 20 08 BA 9E…` block at 0x2A0A6) vs 0x2A07C (block at 0x2A0AC). The image *content* and its byte-exact match to live SCAMP 0x30–0x5F are agreed; only the base offset differs by ~6 bytes. Resolve by direct byte inspection of the flash before citing a per-register default offset.

## 13j.10 EC/ED low-index DRAM decode — attempted & falsified  **[RE 2026-07-20]**

Followed the §13j.5 lead that EC/ED `0x00–0x06` might follow the VL82C480 `VER/RAMTMG/RAMCFG/RAMSET/NTBREF/CLKCTL` layout, to get a datasheet-grade DRAM-timing decode. **It does not hold** — two independent problems, either fatal:

1. **The VL82C480 datasheet has no per-value tables.** Page 23/24 give Table 3 (field *layout*) + Table 4 (ports); pages 25+ are AC electrical characteristics. The only value hints anywhere are `TCAS[1:0] ∈ {1T,1.5T,2T}` and `TSTRT[1:0] ∈ {00,01,10}` — there is no `TRP=xx → N clocks` table to decode against.
2. **The BIOS never accesses EC/ED `0x00–0x06`** (traced touch-set `{0x07,0x0C,0x0D–0x12,0x15,0x18,0x1A}`), so there is *zero code evidence* those indices are RAMTMG/RAMCFG at all.

And the field-slice under the assumed layout is **hardware-inconsistent**, clinching the mismatch:

```
0x01 RAMTMG=0xD5 -> TSTRT[7:6]=11   INVALID (datasheet defines only 00/01/10)
0x02 RAMCFG0=0x0B -> bank0 only, banks 1-3 empty   WRONG (this unit has 20 MB across banks)
0x04/05/06 (RAMSET/NTBREF/CLKCTL) slice cleanly but are unverifiable
```

The `RAMCFG0 → single bank` reading contradicts the machine's known 20 MB, and `TSTRT=11` is undefined, so EC/ED `0x00–0x06` are **not** the VL82C480 DRAM layout — the resemblance was coincidental. **The real BIOS-programmed DRAM timing stays block2 `0xB0–0xB5` / SCAMP `0x30–0x3A`** (§13j.4/§13j.7); its per-bit RAS/CAS split remains `[H]` and is **genuinely not datasheet-decodable** (no VL82C420 databook; VL82C480 gives field boundaries only). Net: for VL82C420 config, **field names are recoverable, bit-value semantics are not.** This closes the DRAM-decode avenue.

> **Flash write-enable / VPP:** the block2 (`0x24/0x25`) and EC/ED (`0xEC/0xED`) windows also gate
> BIOS-flash reprogramming — `block2[0xFE]` bit 0 (write-protect), `EC/ED[0x0C] &= 0x8F` (route CPU
> writes to flash), and `port 0x98` bit 3 (VPP-enable). Decoded from a working updater; see
> [`../BIOS-Flash/readme.md`](../BIOS-Flash/readme.md).

## 13k. DRAM bank geometry & memory sizing — RESOLVED  ✅ **[RE 2026-07-27]**

Four independent full-disassembly passes over `E28F002BXT@TSOP40.BIN` (prompted by the taka 32 MB
hack / `DARK2301.COM 03 DD|CD` question — full story in [`../RAM-Module/readme.md`](../RAM-Module/readme.md) §7.4)
settle where the VL82C420 keeps its DRAM bank configuration, and correct three §13j attributions:

- **EC/ED (`0xEC/0xED`) indices `0x02`/`0x03` are the DRAM bank-geometry registers.** One 4-bit
  code per bank (low/high nibble): `0`=empty, `0xA`=2 MB, `0xB`/`3`=4 MB, `0xC`=8 MB, `5`/`0xD`=16 MB
  (size = `2^((code&7)−1)` MB). Written ONLY by the cold-boot sizer at flash `0x33836–0x3397C`
  (F000:3836), which probes each bank empirically with `0xAA55` alias tests (+1/2/4 KB, +4/8 MB).
  The POST EC/ED preset table (26 pairs at flash `0x3372A`) deliberately skips `02/03`. Nothing ever
  reads them back — the DRAM controller consumes them directly. `DARK2301.COM 03 DD` is a raw poke
  of EC/ED index `0x03`.
- The sizer is **skipped on warm boot** (port `0x64` bit 2, 8042 System Flag — flash `0x33846`); a
  CPU warm reset leaves the chipset unreset, so poked geometry survives, and the destructive
  extended-memory *count* re-runs over it and rewrites **CMOS `0x30/0x31`** (store at flash `0x360B2`).
- **Corrections to §13j:** (1) the "SCAMP `0x13–0x16` runtime-computed bank/size fields" reading is
  **withdrawn** — an exhaustive scan finds no writer of SCAMP indices `0x13–0x16` anywhere in the
  image; the live values are hardware/reset state. (2) block2 `0xBE` "total-memory/bank-layout code
  written by memory-sizing" is **withdrawn** — the `0x29Bxx` code region is the SMI/PM I/O-trap and
  timer machinery (§13j.4's I/O-trap reading was right); real sizing is the EC/ED `02/03` path above.
  (3) §13j.10's falsification of a VL82C480-style EC/ED `0x00–0x06` decode is revised: `02=0x0B`
  was in fact **correct** (bank0 = 4 MB onboard) — the July-20 dump unit simply had **no RAM module
  installed**. **Live-confirmed 2026-07-27 across two units × three module configurations**
  (CRC-verified read-only `.COM`, cold boot each): `02 = 0x0B` always; `03` tracks the module —
  **`0x00` (none) / `0x0B` (4 MB module, one bank) / `0xCC` (16 MB module, two 8 MB banks)**; every
  other EC/ED byte identical across both physical units. The geometry registers read back
  sizer-written values (not write-only). Full report:
  [`../RAM-Module/eced-dram-regs-live.md`](../RAM-Module/eced-dram-regs-live.md).
- Boot-block I/O helper library (F000:DB6F–DD30, byte-identical twin at E000:F3AC–F4D5) covers
  every window: SCAMP `0x74/0x76`, block2 `0x24/0x25` (four-read unlock §13h), EC/ED, SIO `0x3F0/1`,
  CMOS, PCMCIA `0x3E0/1`, and **two Pluto indexed windows `0x15EA/0x15EB` and `0x35EA/0x35EB`**
  (previously undocumented; full access census in the RAM-Module/Pluto notes). The only strap→chipset
  transfer near memory init: Pluto35 reg `0x05` bits 3:2 → SCAMP reg `0x82` bits 5:4 (flash `0x33AF2`).
  The "these are the RAM-module ID straps" hypothesis was **tested live and falsified (2026-07-27)**:
  Pluto35 reg `0x05` reads `0xF3` (bits 3:2 = `00`) in every module configuration on both test units,
  including no-module where strap pull-ups should read `11`. The bits' identity is unknown; the ID
  straps (Pluto pins 31/32) surface in no known readable register, and the probe-based sizer never
  needs them.

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
