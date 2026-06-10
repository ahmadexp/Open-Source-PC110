# PC110 schematic expansion — VL82C420 (U61) analysis

Scope: crack the `UNKNOWN1–4` balls, consolidate the VL82C420 pinout, and cross-check against
the patent-derived reference and companion datasheets. Source: your `PC110-Singlesheet-Schematic.pdf`
(KiCad, "PC110 Motherboard"), read directly. Confidence is tagged **[C]** confirmed-from-sheet,
**[H]** hypothesis, **[?]** uncertain/needs probing.

---

## 1. Chip identities (corrected)

Two distinct large chips were being conflated. They are **not** the same part:

| Ref | Part | Package | Role |
|-----|------|---------|------|
| **U21** | **"Bowman"** — IBM custom **gate-array ASIC** | QFP (pins 1–~144) | ROM addressing (`ROMA12–19`, `ROMCE#`), M38 keyboard-MCU interface (`M38_IO1–12`), VGA address-high, 5-bit chipset link (`Chipset_IO1–5`), `CPUCLK`, `LDEV#` |
| **U61** | **VLSI VL82C420FC5** — SCAMP IV system controller | **BGA256** (A–T × 1–16) | 486 local bus, DRAM control, ISA bridge, RTC, clocks, power management, PCMCIA glue. **Carries `UNKNOWN1–4`.** |

So every unknown ball is on the **VL82C420** — the one chip we have patent data for (US 5,793,990).
The nets `Bowman1–5` are the **inter-chip link** between VL82C420 balls `N9/P9/R9/T9/T13`
(pin-named `Chipset_IO1–5` on the ASIC side, U21 pins 45/40/39/52/130). See §4.

---

## 2. Confirmed VL82C420 (U61) pinout — high-confidence balls

Read directly off the sheet. This is, as far as I can tell, the first consolidated public
VL82C420 ball map. (Full 256-ball transcription is feasible but bulk text extraction collides
with neighbouring BGAs; the groups below were visually verified.)

### 486 local-bus interface  [C]
| Ball | Pin name | Net |
|------|----------|-----|
| N2 | CPU_ADS# | CPU_ADS# |
| L1 | CPUBE0# | CPU_BE0# |
| L4 | CPUBE1# | CPU_BE1# |
| K3 | CPUBE2# | CPU_BE2# |
| K2 | CPUBE3# | CPU_BE3# |
| L2 | CPUWR# | (W/R#) |
| L6 | CPURDY# | CPU_RDY# |
| M2 | CPUKEN# | CPU_KEN# |
| M3 | CPUBRDY# | CPU_BRDY# |
| L5 | CPU_AHOLD | CPU_AHOLD |
| M4 | CPU_LDEV# | CPU_LDEV# |
| T7 | CPU_DC# | CPU_DC# |
| H3 | CPU_A20M# | CPU_A20M# |
| E1 | CPU_STPCLK# | CPU_STPCLK# |
| F2 | CPU_SMI# | CPU_SMI# |
| G3 | CPU_NMI | CPU_NMI |

(Plus the full CPU_A[2..31] / CPU_D[0..31] busses on the A/B/C-row balls.)

### Clocks, RTC, reset, power  [C]
| Ball | Pin name | Net |
|------|----------|-----|
| K1 | Chipset_CPU_CLK | CPUCLK out |
| R2 | CPU2XCLK | Chipset_2XCPU_CLK |
| R15 | CLOCK_IN | Chipset_CLK |
| H16 | PCMCIA_CLK | PCMCIA_CLK |
| T11 | RTCBAT | RTC battery |
| P10 | RTCBAT_Sense | RTC battery sense |
| R11 | RTCOSCI | 32.768 kHz xtal in |
| P11 | RTCOSCO | 32.768 kHz xtal out |
| M11 | PS/RCLR# | power-supply / RAM-clear |
| N13 | RESET | system reset |
| R10 | PWRGD | power-good |
| P13 | PWRGD_P13 | power-good (2nd) |
| T14 | TP1 | test point |

### ISA / peripheral control  [C]
| Ball | Pin name | Net |
|------|----------|-----|
| J14 | IOW# | IOW# |
| J15 | IOR# | IOR# |
| F13 | MEMR# | MEMR# |
| G14 | MEMW# | MEMW# |
| J16 | IOCS16# | IOCS16# |
| F12 | SBHE# | PCMCIA_SBHE# |
| G16 | AEN | AEN |
| E14 | REFRESH# | PCMCIA_REFRESH |
| N11 | FDCTC / FDC_TC | Chipset_FDC_TC |
| G15 | BIOS_CE# | Chipset_BIOS_CE# |

### Inter-chip link to Bowman ASIC  [C]
| Ball | Pin name | Net | → U21 (Bowman) |
|------|----------|-----|----------------|
| N9 | Chipset I/O 1 | Bowman1 | pin 45 |
| P9 | Chipset I/O 2 | Bowman2 | pin 40 |
| R9 | Chipset I/O 3 | Bowman3 | pin 39 (via R149 33Ω) |
| T9 | Chipset I/O 4 | Bowman4 | pin 52 |
| T13 | Chipset I/O 5 | Bowman5 | pin 130 |

---

## 3. Cracking UNKNOWN1–4

The four unknowns split into **two pairs** that behave very differently on the sheet:

### UNKNOWN1 = ball **R13**, UNKNOWN2 = ball **N12**  — *connected, real signals*
Both route off-chip through **U7 (HD151015 bus switch)** onto the shared "Device_Address_BUS"
that also carries the link to the Bowman ASIC. On U7's A-side they sit in this group:

```
U7.A0 = UNKNOWN1   U7.A3 = KB_SRDY#    U7.A6 = Pluto_EN_IRDA
U7.A1 = UNKNOWN2   U7.A4 = KB_SCLK#    U7.A7 = SA0
U7.A2 = (Bowman5)  U7.A5 = PWRGD       U7.A8 = GND
```
Physical neighbours on the BGA: `M11 PS/RCLR#`, `N13 RESET`, `N11 FDCTC`, `R10 PWRGD`,
`P10/P11/R11/T11` (RTC). So R13/N12 are in the **system-control / power / device-select corner**,
and they are switched onto a bus alongside keyboard-serial and chip-select-like signals.

**Ranked hypotheses**
1. **[H, high]** General-purpose I/O / programmable device-select (GPIO / GPCS) from the VL82C420,
   muxed by the HD151015 onto the device-address/select bus shared with the ASIC. The company they
   keep (KB serial, IrDA-enable, SA0, a chip-select bus) fits SCAMP-family GPIO/GPCS pins.
2. **[H, med]** A second low-speed serial / strobe pair extending the keyboard-MCU interface
   (immediate neighbours of `KB_SRDY#`/`KB_SCLK#`).
3. **[H, med]** Power-management discretes (suspend/resume handshake) — adjacency to `PS/RCLR#`,
   `RESET`, `PWRGD`; SCAMP IV advertised "3.3 V/5 V suspend with modem and ring-resume."

**Fastest way to confirm:** with the board off, buzz `R13`/`N12` to the HD151015 A0/A1 (already
shown), then trace the matching **B-side** pins to their destination on the Bowman ASIC / keyboard
section — that destination names the function. Powered, scope them against `KB_SCLK#`: if they
toggle in lock-step they're part of the serial/scan group; if static they're selects/PM.

### UNKNOWN3 = ball **R8**, UNKNOWN4 = ball **N8**  — *no external connection traced*
These appear **only at U61** (no net endpoint elsewhere) — i.e. currently floating / no-connect /
untraced. Critically, they sit one column inboard of the inter-chip link balls
`N9/P9/R9/T9` (the `Bowman1–5` group).

**Ranked hypotheses**
1. **[H, high]** Additional inter-chip (VL82C420 ↔ Bowman) link lines that are **unused in the PC110**
   — i.e. the chip's `Chipset_IO` / ML-bus group is wider than 5, and `R8/N8` are the next lines,
   left unconnected on this board. Their position immediately beside `N9/R9` is the main evidence.
2. **[H, med]** Reserved / factory-test / NC balls.
3. **[?]** If powered measurement shows them tied to a rail internally, they could be unrouted
   power/ground (less likely — VCC/VSS balls are labelled elsewhere).

**Fastest way to confirm:** continuity-check `R8`/`N8` to every nearby net and to VCC/VSS; if truly
isolated, mark as **NC/reserved**. On a known-good board, a quick scope during boot will show
whether they ever switch (→ active link line) or stay static (→ NC/reserved).

---

## 4. The `Bowman1–5` bus and the ML-Bus cross-reference  [H]

`Chipset_IO1–5` (VL82C420) ↔ `Bowman1–5` ↔ ASIC is a **5-line control link** between the system
controller and the IBM gate-array. US 5,793,990 (the VL82C420 designers' patent) defines the
**Multiplexed Local (ML) Bus** control set as exactly: `MLCLK, MLADS#, MLLBA#, MLRDY#` + a
**priority** line = **five signals**, with address/data multiplexed onto the CPU's `A[25:2]`.

That the inter-chip link is precisely 5 lines is suggestive: **`Bowman1–5` may be the ML-bus control
group**, with the Bowman ASIC acting as an ML "memory-I/O / I/O-only device" per the patent, and the
multiplexed address/data riding the shared CPU bus (which the ASIC also taps — note U21's
`VGA_ADDHI`, `ROMA*`, and CPU-derived signals). Worth testing by checking whether one of
`Bowman1–5` is a free-running clock (→ `MLCLK`) and another strobes at cycle starts (→ `MLADS#`).
If so, `R8/N8` (UNKNOWN3/4) being adjacent could be spare ML handshake lines (§3, hypothesis 1).

See `VL82C420_Technical_Reference.pdf` (built earlier) for the full ML-bus signal definitions and
the redrawn FIG.1/FIG.14 block diagrams.

---

## 5. Cross-check vs references — observations & flags

**Consistent with the patent / SCAMP IV (good signs):**
- `CPU_AHOLD` (L5) and `CPU_LDEV#` (M4) map directly to the patent's **AHOLD** (tri-state the CPU
  address bus to take an ML cycle) and **LBA#/local-device-access** concept. Strong corroboration
  that U61 is the multiplex system controller.
- Full 486 control set present (BE0–3#, WR#, RDY#, BRDY#, KEN#, ADS#, A20M#, STPCLK#, SMI#) — matches
  "power-managed Intel 486-class up to 33 MHz."
- Integrated RTC (RTCBAT/RTCOSCI/RTCOSCO/RTCBAT_Sense) and DRAM control (`U61_RAM_RAS0/2`,
  `U61_RAM_UCASL#/LCASU#`, `RAM_A[0..11]`, `U61_RAM_RAMWE#`) — matches a SCAMP single-chip system
  controller. Up-to-32 MB memory claim is consistent.

**Auto-named / unresolved nets to resolve (these are net *numbers*, not functions):**
`IOW#113`, `ADDHI124`, `FDRQ115`, `PWRGD_IN141`, `ROMCE#142`, `CPU_INTR133`, `PDRQ117`, `FDD_IO125`,
`KB_TP139`, plus the `U21_97/98/101…139` group on the Bowman ASIC and `U61_RAM_*`. These are pins the
tracer left with placeholder names — each is a candidate for a real-function rename once verified.

**Things to double-check on U61 (possible mis-reads in my bulk pass, verify against your symbol):**
- Several `FDC_*` names (`FDC_RTS2#`, `FDC_DTR2#`, `FDC_DSR2#`, `FDC_RDATA#`, etc.) appeared paired
  with U61 balls in the noisy extraction. The SCAMP IV *peripheral* chip (VL82C144) is what carries
  FDC/UART — so confirm whether these are truly VL82C420 balls or bled in from the adjacent
  FDC37C665 / VL82C144 symbol. If real, it means this VL82C420 variant integrates more peripheral
  glue than the SCAMP IV press specs implied.
- `J14=IOW#` / `J15=IOR#` vs the separate `IOW#`/`IOR#` 33Ω series resistors (R-numbers near J13–J16):
  confirm series-termination placement.

---

## 6. Suggested next steps (highest value first)
1. **Buzz out R13/N12 → HD151015 B-side → destination** to name UNKNOWN1/2 functionally.
2. **Continuity/scope R8/N8** to classify as spare-link vs NC/reserved.
3. **Scope `Bowman1–5`** to test the ML-bus hypothesis (look for a clock + an address strobe).
4. **Resolve the placeholder nets** (`*113/115/124/133/141/142`, `U21_9x`, `U61_RAM_*`) into real
   function names; many are inferable from the chip they land on.
5. Fold the confirmed VL82C420 ball map (§2) into the repo as the start of an open VL82C420 pinout —
   it would be the first public one.

*Prepared from the uploaded schematic + the VL82C420 patent reconstruction. Confidence tags reflect
what is provable from the sheet alone vs. what needs a meter/scope on hardware.*
