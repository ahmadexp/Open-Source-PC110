# IBM PC110 — Power-On Sequence & "Won't Power On" Repair Guide

*Derived from the U6 power-sense MCU firmware (M38223E4HP, "RIOS POWER SENSE MICON Rev 8")
and the Mainboard (J5) + PSU (J3) schematics. Use alongside `PC110_U6_J5-J3_analysis.md`.*

> **Confidence key:** ✅ verified from firmware/schematic · 🟡 strongly inferred · ⚠️ assumption — verify on the bench.

---

## 0. The 30-second mental model

The PC110 is **never fully "off"** while a charged battery or adapter is attached. A tiny
**standby supply** keeps the **U6 power MCU** alive in STOP (sleep) mode. U6 watches the **power
button** and the **battery via its A-D converter**. When you press power, U6 wakes, checks the battery
is healthy, and only then drives its **enable outputs (P52/P53)** across J5→J3 to switch on the main
**~10.5 V rail (PWR_IN_10v5)**, which feeds all the downstream regulators (5 V, VCC, VEE, etc.).
A **74HC74 latch (U54)** holds the power state, and U6 **handshakes with the system (P20/P21)**.

If any link in that chain is broken, the machine appears dead or powers up partially. The rest of
this document is that chain, in order, with what to measure.

---

## 1. Power domains / rails

| Rail / net | Approx. | Source | When present | Notes |
|---|---|---|---|---|
| **Battery B+** (JX1) | ~7–9 V Li-ion (or alkaline pack) | Main battery via **F5 2.5 A** fuse → **L1** → **U13 (J421 FET)** | Whenever battery fitted | Current sensed by **0.1 Ω shunt R7/R8** |
| **PWR_IN_10v5** | ~10.5 V | Battery boost **or** AC adapter / dock (`Dock_PWR_IN−`) | When a source is attached | The main pre-regulation bus |
| **Standby / VCC (U6)** | ~5 V (or 3–5 V) ⚠️ | Always-on micro-regulator off the bus | **Always** (source attached) | **Keeps U6 alive in STOP** — see §6 |
| **5 V** | 5 V | DC-DC from PWR_IN_10v5 | After power-on (P52 asserted) | Logic/system rail (J5/J3 "5v") |
| **VEE** | negative LCD bias | VEE generator, gated by **F65_ENAVEE** | After display enable | LCD contrast/bias |
| **PNET1 / PNET4 / PNET5** | — | inter-board power distribution | with bus | Carried on multiple J5/J3 pins |
| **JRC_VCC** | op-amp supply | from bus near VREF network | with bus | Powers the PSU sense op-amps (U6 7064 + U7A) |

⚠️ Exact standby-rail voltage and which regulator makes it were not fully traced; verify against a
known-good board.

---

## 2. The actors (who does what)

| Ref | Part | Role in power-up |
|---|---|---|
| **U6** (mainboard) | M38223E4HP 740-core MCU | The brain. Sleeps in STOP, wakes on power button, checks battery, drives enables, handshakes. |
| **U6** (PSU board) | JRC "7064" quad op-amp (+ **U7A**) | Conditions battery **voltage/current** into U6's A-D channels (AN0/AN1/AN3/AN4, VREF). |
| **U54** (mainboard) | 74HC74 dual D flip-flop | Latches the power-on state (`U54_1D`, `U54_1Q`, `U54_VCC`, `U54_1PRE#`). |
| **Q4** ("8LR") | NPN | Driven by **M38_P52** via **R2 470k** → gates the main-rail switch. |
| **Q5/Q22** ("8C") | switches | High-side switching of **PWR_IN_10v5**. |
| **Q31/Q33** ("BLR/BLB") | transistors | Driven by **M38_P53** path. |
| **F5** | 2.5 A fuse | In the battery current path (after the shunt). |
| **U13** | J421 FET | Battery path switch / ideal-diode. |
| **U3, U60, …** | regulators | Downstream DC-DC (5 V, etc.) ⚠️ not fully traced. |

---

## 3. The power-on sequence (step by step)

### Phase A — Standby (machine "off")
1. A source (battery or adapter) is attached → **PWR_IN bus** live → **standby regulator** powers
   **U6 VCC**. ✅ (U6 must have VCC or nothing below happens.)
2. U6's firmware, after reset, configures ports and **enters STOP mode** (`STP` at `$CD00`; it sits in
   `STP / bra $CD00`). ✅ Only the wake interrupts are armed (`seb 3,ICON2`, `seb 4,ICON2`). ✅
3. In this state the **main rail is OFF**: `M38_P52`/`M38_P53` are **low**, Q4 off, Q5/Q22 off. ✅

### Phase B — Wake (you press the power button)
4. The **power button** pulls **U6's INT3 input (port P5.1)** → wakes U6 from STOP. ✅ that P5.1/INT3 is
   an input that the firmware polls and uses as a wake/startup trigger; 🟡 that the physical button is
   on this line (it is *not* on J5/J3 — it's a mainboard signal straight to U6).
5. Firmware **classifies the wake reason** (routines `$CCFC/$CD03/$CD0D`) by reading **P5.1 (INT3)** and
   a P7 input, producing a startup-mode code (0–5). ✅ This is why a brief vs. held press, or
   adapter-insert vs. button, can behave differently.

### Phase C — Battery / source health check (the big gatekeeper)
6. U6 runs an **A-D scan** of the PSU front end (single `sta ADCON` channel select at `$D74F`, then
   repeated `lda AD`, paired-sample averaging). ✅ It reads:
   - **AN4 / P64** = main **bus voltage** (PWR_IN_10v5 ÷4). ✅
   - **AN0, AN3 / P60, P63** = **battery current** (low-side shunt R7/R8). ✅
   - **AN1 / P61** = **battery current** (high-side rail, ×20 diff-amp). ✅ topology
7. **If the measured voltage/health is below threshold, U6 refuses to assert the enables** and goes
   back to STOP. 🟡 (The main loop gates the power-up path on these readings and internal flags.)
   → *This is the #1 reason a PC110 with a flat/!dead battery won't turn on even though it "should."*

### Phase D — Turn the main rail on
8. U6 executes its **power-enable routine** (`$D056`): **`seb 2,P5` + `seb 3,P5`** → drives
   **M38_P52 = HIGH** and **M38_P53 = HIGH**. ✅
9. **M38_P52 (J5-18 / J3-18)** → R2 470k → **Q4 base** → Q4 conducts → gates the **Q5/Q22 bank** →
   **PWR_IN_10v5 main rail switches ON**. ✅
10. **U54 (74HC74)** latches the power-on state (`U54_1D` clocked to `U54_1Q`). 🟡 — this holds power
    up after the button is released.
11. Downstream **regulators come up** (5 V, VCC rails, etc.) → the system/CPU side begins to boot. 🟡

### Phase E — Handshake & housekeeping
12. U6 **handshakes with the system controller** on **P2.0 / P2.1** (J5-19/J3-19 and J5-22/J3-39):
    it reads **P2.0** as a request, validates a **`0x5A` sync byte**, then **drives P2.0 low and P2.1
    high** to acknowledge (`$CAD3…$CAE4`, and the `$C983–$CBF2` state machine). ✅ U6 also has a
    **UART** (TXD/RXD on port **P4**, mainboard-side) for fuller comms. ✅
13. Later in the bring-up, **F65_ENAVEE (J5-26 / J3-35)** is asserted to enable the **LCD VEE** bias so
    the display can light. 🟡
14. U6 stays awake running its monitor loop (battery gauging via the current channels, charge control,
    suspend/resume). On power-off or critical battery it runs the **`$D05B` power-down** (`clb 2,P5` /
    `clb 3,P5` → P52/P53 low → main rail off) and re-enters STOP. ✅

---

## 4. Signal state cheat-sheet (off vs. on)

| Signal (pin) | Standby/off | After power-on | How to read |
|---|---|---|---|
| U6 VCC (standby) | **present** ⚠️ | present | Must be present even when "off". If 0 V → dead micro. |
| **M38_P52** (J5-18/J3-18) | low | **high** | Goes high on button press = "U6 decided to turn on". |
| **M38_P53** (J5-23?/J3-38) | low | **high** | Driven together with P52. |
| **PWR_IN_10v5** | off* | **~10.5 V** | *Present if adapter feeds it directly; switched for battery. |
| **5 V** | off | **5 V** | Downstream of the main rail. |
| **M38_P20/P21** (J5-19,22 / J3-19,39) | idle | toggling handshake | Activity = U6 talking to system. |
| **AN4/P64** (J5-34/J3-27) | tracks bus | tracks bus | DC analog ≈ Vbus/4. |
| **VREF** (J5-31/J3-30) | steady ref | steady ref | If 0 V, A-D reads garbage → U6 may refuse to start. |
| **F65_ENAVEE** (J5-26/J3-35) | low | high (at display-on) | LCD bias enable. |

*Pin numbers: J3 (PSU) numbering is authoritative; for J5 second-row pins use **J5 = 61 − J3**.*

---

## 5. Troubleshooting — completely dead (no reaction to power button)

Work the chain in order; stop when you find the break.

1. **Source & standby first.**
   - Confirm battery/adapter actually delivers voltage to the board; check **F5 (2.5 A fuse)** for
     continuity (a blown F5 kills the battery path). ✅ F5 is a prime suspect.
   - Measure **U6 VCC (standby)**. **No standby supply = U6 can't run = totally dead.** Trace the
     always-on regulator from the bus. ⚠️
2. **Is U6 alive?** With standby present, U6 should be oscillating (XIN/XOUT) and sitting in STOP.
   - No clock → bad crystal/U6. Check XIN/XOUT.
3. **Power button reaches U6?** Press button while monitoring **U6 P5.1/INT3**: you should see the
   line move. ✅ No edge → button, its pull, or the trace is open. (Button is mainboard-side, not on
   J5/J3.)
4. **Does U6 try to turn on?** Watch **M38_P52 (J5-18/J3-18)** on button press:
   - **P52 never goes high** → U6 woke but **refused** (battery/health gate, §3-7) **or** U6/firmware
     fault. Check the **A-D inputs**: **VREF present?** **AN4 ≈ Vbus/4?** A dead VREF or a shorted
     sense op-amp makes U6 read "battery bad" and abort. ✅ logic / 🟡 exact threshold.
   - **P52 goes high but nothing else happens** → fault is *downstream* (go to §5-5).
5. **Main-rail switch.** With P52 high, check **Q4** turns on and the **Q5/Q22** bank passes
   **PWR_IN_10v5**. A failed Q4 / R2 (470k) / Q5 / Q22 leaves the rail off despite a good enable. ✅
6. **The J5↔J3 connector itself.** Re-seat it; check continuity of **P52, P53, GND, PWR/PNET** pins.
   A dirty/cracked board-to-board connector breaks the enable or sense path and mimics a dead board.

---

## 6. Troubleshooting — partial power / powers then dies / no display

| Symptom | Likely area | Checks |
|---|---|---|
| Main rail comes up then **drops after ~1 s** | U54 latch not holding, or U6 reads fault & runs power-down (`$D05B`) | Scope **P52** — if it pulses high then low, U6 aborted; check **AN4/VREF** and battery current sense. Check **U54 (74HC74)** `1D/1Q/PRE#`. |
| Runs on **adapter only**, not battery | Battery path | **F5**, **U13 (J421)**, shunt **R7/R8**, battery contacts; U6 sees "battery absent/low". |
| Runs on **battery only**, not adapter | Adapter/dock input | `Dock_PWR_IN−`, dock/adapter steering diodes (D2/D4/D7/D8 area), bus OR-ing. |
| Powers up but **no display** | LCD bias | **F65_ENAVEE (J5-26/J3-35)** should go high; check **VEE** generator. |
| Powers up, **won't talk / hangs early** | Handshake | Activity on **P2.0/P2.1**; UART on U6 port **P4**. No handshake → system controller side. |
| **Won't charge / bad gauge** | Current sensing | **R7/R8 shunt**, PSU op-amps (**7064 U6A–D / U7A**), AN0/AN1/AN3; VREF. |
| **Random no-boot, intermittent** | Connector / standby | Re-seat **J5/J3**; verify standby rail is solid under load. |

---

## 7. Key test points (quick reference)

- **F5** (2.5 A) — battery path fuse. *Check first.* ✅
- **U6 VCC / standby rail** — must be live when "off". ⚠️
- **U6 P5.1 / INT3** — power-button input (mainboard). ✅
- **M38_P52 = J5-18 / J3-18** — main power-enable from U6 (goes high to turn on). ✅
- **M38_P53 = J5-23 / J3-38** — second enable, driven with P52. ✅
- **PWR_IN_10v5** — main bus after the Q4/Q5/Q22 switch. ✅
- **VREF = J5-31 / J3-30**, **AN4/P64 = J5-34 / J3-27** — A-D reference & bus-voltage sense; bad values make U6 abort. ✅
- **P2.0/P2.1 = J5-19,22 / J3-19,39** — system handshake. ✅
- **F65_ENAVEE = J5-26 / J3-35** — LCD VEE enable. 🟡
- **U54 (74HC74)** — power-state latch. 🟡

---

## 8. Firmware anchors (for the curious / deeper debug)
- Reset/entry: **`$C046`** (`SEI; jsr $CC5E …`); A-D-ready wait at `$C055` (`bbc 3,ADCON`). ✅
- STOP/sleep: **`$CD00`** (`STP; bra $CD00`); deep-sleep setup at `$D0D6` (masks IRQs, arms ICON2 b3/b4). ✅
- Power **ON**: **`$D056`** (`seb 2,P5; seb 3,P5`). ✅
- Power **OFF**: **`$D05B`** (`… clb 2,P5; clb 3,P5`). ✅
- Wake-reason classify: **`$CCFC / $CD03 / $CD0D`** (read P5.1/INT3 + P7). ✅
- A-D scan / channel select: **`$D74F`** (`sta ADCON`) + reads `$D5FD–$D831`. ✅
- P2.0/P2.1 handshake + `0x5A` sync: **`$CAD3`, `$C983–$CBF2`**. ✅
- ROM maps at **0xC000**; CPU vector table (0xFFDC–0xFFFF) is **missing from the dump** (last 130 bytes truncated). ✅

---

## 9. Caveats
- Downstream regulator topology (which DC-DC makes 5 V / standby / VEE) and exact thresholds were not
  fully traced from the two sheets provided — items marked ⚠️/🟡 should be confirmed against a
  known-good unit or the full service schematic.
- Some firmware paths run through indirect jump tables that a static trace can't fully follow; the
  control flow above reflects the routines that *were* decoded.
