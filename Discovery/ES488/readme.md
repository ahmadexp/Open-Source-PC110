# U4 (ES488F) and the PC110 Audio Subsystem — Detailed Analysis

*Source: `Mainboard.pdf` — "PC110 Motherboard", KiCad / Eeschema export. Part of the Open‑Source‑PC110 reverse‑engineering effort to recreate the IBM Palm Top PC 110.*

---

## 1. Executive summary

**U4 is an ESS Technology `ES488F` "AudioDrive"** — a single‑chip, ISA‑bus, Sound Blaster (Pro)–compatible audio controller in a **52‑pin QFP** package. It is the centerpiece of the board's audio section. Everything else in the audio block exists to (a) connect U4 to the system bus, (b) give it a clock and a reset, (c) feed it FM (OPL2) music from a discrete Yamaha synthesizer, and (d) take its analog output to a speaker amplifier with volume control.

The ES488 family is notoriously undocumented — ESS never released a public datasheet and treated it as obsolete within a few years, which is one of the reasons this board had to be reverse‑engineered rather than copied from reference material.

**Signal chain:**

```
            YM3812 (U10, OPL2 FM)
                 │  digital
                 ▼
            YM3014B (U46, serial DAC)
                 │  analog FM
                 ▼
   ┌─────────────────────────────────────┐
   │ ES488F  (U4)  — mixer / codec / SB  │ ◄── ISA data/addr bus (via HD151015 + 74LV buffers)
   └─────────────────────────────────────┘
                 │  LineOut  → net "ESS_Sound"
                 ▼
            LM4861 (U12, ~1 W speaker amp)   ◄── volume set by DS1669 (U48)
                 │
                 ▼
              Speaker
```

---

## 2. What the ES488 is

| Attribute | Detail |
|---|---|
| Manufacturer | ESS Technology, Inc. |
| Part marking | `ES488F` (the "F" suffix = QFP‑52 package variant) |
| Family | ESS **AudioDrive** (one of the earliest members, alongside ES688/ES1488) |
| Function | Single‑chip ISA sound controller: Sound Blaster / SB Pro–compatible digital audio (ADC/DAC codec), mixer, ISA bus interface, DMA + IRQ handling, joystick/MIDI (game) port |
| Package | 52‑pin QFP (confirmed by the schematic's highest pin number, 52, and by period sources describing the ES488/ES1488 as a QFP52 part) |
| Era | ~1994–1995, used in early notebooks/palmtops because of its high integration and low part count |
| FM synthesis | Provided **externally** on this board by a discrete Yamaha YM3812 (OPL2) + YM3014B DAC, rather than the integrated "ESFM" found on later ESS parts |

---

## 3. Complete U4 pinout (as wired on this board)

Extracted directly from the schematic symbol. Pin numbers in parentheses.

### Digital / ISA‑bus interface (left side)

| Pins | Signal group | Notes |
|---|---|---|
| 23, 24, 25, 28, 29, 30, 31, 32 | **D0–D7** | 8‑bit data bus |
| 41, 42, 43, 45, 46, 47, 48, 49, 50, 51 | **A0–A9** | Address inputs (board's `SA1…SA9` system‑address nets) |
| 16 | **IRQ1** | Interrupt request (net `ESS_IRQ1`) |
| 18 | **IRQ2** | Interrupt request (net `ESS_IRQ2`) |
| 21 | **DRDY** | Data ready / DMA (net `ESS_DRDY`) |
| 40 | **AEN** | Address enable (net `ESS_AEN`) |
| 14 | **DIR** | Bus direction control |
| 36 | **DACK1#** | DMA acknowledge (fed by `Bowman_ESS_DACK1#`) |
| 37 | **IOR** | I/O read |
| 38 | **IOW** | I/O write |
| 39 | **RESET** | Reset (driven by `FCS_RESET`) |

### Power, clock, reference

| Pins | Signal | Notes |
|---|---|---|
| 20, 27 | **VCC** | Core supply; decoupled by C150 (10 nF) and C19 (150 nF) |
| 44 | **VCC_Bus** | Bus‑side supply |
| 34 / 35 | **Xin / Xout** | Crystal **X2** + load cap C53 (22 pF) — audio reference clock |
| 52 | **REF** | Analog voltage reference |
| (multiple) | **GND** | Ground pins along bottom edge |
| 3, 5, 12, 15, 17, 19, 22, 26, 33 | **NC** | Not connected |

### Analog audio interface (right side)

| Pin | Signal | Function |
|---|---|---|
| 4 | **MIC** | Microphone input (via `MIC_in_pin`, L13 1.5 µH, R221/R222/R225) |
| 9 | **LineOut** | Main analog output → net `ESS_Sound` → power amp |
| 11, 10 | **ByPass** | Mixer bypass / decoupling nodes |
| 6 | **CMR** | Common‑mode reference |
| 13 | **GamePad** | Joystick / game‑port analog sense |
| 2 / 1 | **CinR / FoutR** | Right channel cap‑in / filter‑out (C12 250 nF) |
| 8 / 7 | **CinL / FoutL** | Left channel cap‑in / filter‑out |
| — | (coupling) | C20 1.5 nF, C21 270 nF, C22 270 nF set the analog filtering |

---

## 4. Chips directly associated with U4

### 4.1 FM synthesis (music) — feeds into the ES488 mixer

| Ref | Part | Role |
|---|---|---|
| **U10** | **Yamaha YM3812 (OPL2)** | FM synthesizer generating AdLib / SB‑Pro music. Has VCC/GND, IRQ#, WR#, RD#, CS#, A0, D0–D7. Its chip‑select is the buffered `YMF_CS#_Buf`. |
| **U46** | **Yamaha YM3014B** | Serial floating‑point DAC that converts the YM3812's digital stream to analog (LOAD, Clock, SD pins). |
| **U11A** | **NJM2904** | Dual op‑amp buffering / level‑setting the FM analog output before it reaches the mixer. |
| **U34 (A/B/D)** | **74LV126** | Quad tri‑state buffers gating the data bus and `YMF_SA0_A0` decode to the YM3812. |

### 4.2 Bus interface / level translation

| Ref | Part | Role |
|---|---|---|
| **U7, U49, U72** | **Hitachi HD151015** | Bidirectional bus transceivers / 5 V↔3.3 V level translators (VCCA/VCCB, DIR, G#, A0–Ax ↔ B0–Bx) bridging the ISA system bus to the audio/peripheral chips. |
| **U58** | **Single‑gate Schmitt inverter** (SOT‑23‑5, e.g. 74LVC1G14‑class) | Generates the `FCS_RESET` line that drives U4 pin 39 (RESET). |
| **U69A / U69B** | **SN74LVC2G32** (dual 2‑input OR) | Address/decode logic: `FDC_DS3` OR `Pluto_ESS_AEN` (U69A) then OR `AEN` (U69B) → forms the ESS reset/decode strobe alongside `FCS_RESET`. |

### 4.3 Output amplification & volume

| Ref | Part | Role |
|---|---|---|
| **U12** | **National LM4861** | Mono ~1 W audio power amplifier. Takes `ESS_Sound` and drives the speaker (IN+, IN−, OUT+, OUT−, Bypass; C203 150 nF, C204 10 µF). |
| **U48** | **Dallas DS1669** | Digital "Dallastat" potentiometer for volume control (UpC/DnC up‑down inputs, RH/RW/RL wiper; C13 270 nF, C147/C153 1 µF). |

### 4.4 Clock

| Ref | Part | Role |
|---|---|---|
| **X2** | Crystal + C53 (22 pF) | Reference crystal on U4 Xin/Xout (pins 34/35). |
| **U17** | Oscillator can (4‑pin module) | Provides a buffered clock in the ESS area; output conditioned through a 7W14‑class Schmitt buffer. |

---

## 5. How U4 is decoded, reset, and DMA‑served

A notable detail revealed by the net names: U4's control signals are not driven by a generic ISA chipset but routed through the **PC110's custom gate arrays**, which carry internal codenames in the schematic:

- **`Pluto_ESS_AEN`** — the address‑enable for the ESS comes from the gate array codenamed **Pluto** (U35).
- **`Bowman_ESS_DACK1#`** — the DMA acknowledge to U4 pin 36 originates from the array codenamed **Bowman**.
- **`FCS_RESET`** — synthesized locally by the Schmitt inverter U58 and the SN74LVC2G32 OR gates (U69), combining `FDC_DS3`, `Pluto_ESS_AEN` and `AEN`.
- **`YMF_CS#_Buf`** — the FM (YM3812) chip‑select, buffered before reaching the OPL2 chip.

So the ES488 behaves like an ISA‑mapped sound device, but its bus‑arbitration, AEN and DMA handshakes are produced by the palmtop's bespoke chipset rather than a standard 82C206/ISA controller.

---

## 6. Board context (where U4 lives)

This is a faithful KiCad reconstruction of the **IBM Palm Top PC 110** mainboard — a 486‑based Japanese‑market subnotebook (1995, built with Ricoh). U4 shares the board with:

| Ref | Part | Function |
|---|---|---|
| U76 | 486SX‑33 | CPU |
| U61 | VLSI **VL82C420** | System chipset |
| U51 | Chips & Technologies **65535** | VGA / LCD controller |
| U22 | SMC **FDC37C665IR** | Super‑I/O (FDC, serial, parallel) |
| U6 | Mitsubishi **M38223E4HP** | Keyboard / embedded controller |
| U28, U33 | **M5M4V16160BTP** | DRAM |
| U59 | **28F002** | Flash BIOS |
| U42 | **SC414281PU4** | Memory device |
| U63 | **AV9154A** | Clock generator |
| U35 | "Pluto" | Custom gate array (drives ESS AEN) |
| U21 / U60 | "Bowman" | Custom gate array (drives ESS DACK1#) |

---

## 6a. Live probe — real hardware (2026)  ✅ **[RE]**

The analysis above is from the schematic; the audio chip was also probed on a **running PC110** (over
[COMrade](../Live-Dump/)):

- **Sound Blaster DSP present at I/O base `0x220`.** The standard reset handshake succeeded — write
  `1`→`0` to `0x226`, then the DSP read-data port `0x22A` returned **`0xAA`** (reset acknowledge). The
  "get DSP version" command (`0xE1` → `0x22C`) returned **major = 2, minor = 1 → DSP v2.01**, i.e. the
  ES488 answers in **Sound Blaster 2.0-compatible** mode at `0x220`. This matches the undocumented
  `ADDAUdio 0220` command found in `PS2.EXE` (see [Discovery/PS2](../PS2/)).
- **OPL2 FM responds at `0x388`.** The FM status port `0x388` reads `0x00` (not `0xFF` — undecoded
  ports read `0xFF` on this unit), so the discrete **YM3812 (U10)** decodes there, consistent with the
  external-OPL2 signal chain in §1.

So the audio block is live: the ESS ES488 codec/mixer/SB core at `0x220` and the Yamaha OPL2 FM at
`0x388`, exactly as wired in the schematic. (The digitized-audio DMA/IRQ resources are set by
`PS2.EXE`'s `IRQAudio`/`DMAAudio`; the base address by `ADDAUdio`.)

## 7. Reverse‑engineering note

Because ESS never published an ES488 datasheet and the part is long obsolete, the pin functions above are taken **from how the chip is actually wired on this board**, not from a manufacturer document. Period enthusiast threads confirm only the broad facts (QFP‑52, SB‑compatible AudioDrive), so this schematic is itself one of the better surviving references for the part.

---

## Sources

- [Reverse Engineering The IBM PC110, One PCB At A Time — Hackaday](https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/)
- [ahmadexp/Open-Source-PC110 — GitHub](https://github.com/ahmadexp/Open-Source-PC110)
- [IBM Palm Top PC 110 — Wikipedia](https://en.wikipedia.org/wiki/IBM_Palm_Top_PC_110)
- [ES1488 ("AudioDrive") / ES488 QFP‑52 SoundBlaster‑compatible IC — Electronics Forums](https://www.electronics-lab.com/forums/threads/es1488-audiodrive-soundcard-ic-info-wanted-qfp52-package-isa-bus-signals.68594/)
- [ESS AudioDrive ES1868 Data Sheet (family reference) — bitsavers.org](https://bitsavers.org/components/ess/ESS_ES1868_Data_Sheet_1996.pdf)
- Primary source: `Mainboard.pdf` (this project's KiCad schematic export)

---

## 8. The complete audio signal path — traced end to end  ✅ **[RE 2026-07-28]**

Every net on `PCB/Mainboard/Audio.kicad_sch` was extracted (union-find over wires + labels, with
rotation/mirror-correct pin transforms) to reconstruct the actual chain. The key structural insight:
**sound is mixed twice** — once *inside* the ES488, and again in a **discrete op-amp summing mixer**
that combines the ES488's line output with the OPL2's DAC output.

```
 ISA bus ──DMA──> [ES488F  U4]  PCM codec ─┐            (mix #1: inside the ES488)
                        │ LineOut (pin 9)  │
                        │ = net ESS_Sound  │
                        ▼                  │
                   C18 270nF ── R34 1k ────┤
                                           ├──> [NJM3414A U47]  2-stage op-amp
 ISA bus ──I/O──> [YM3812 U10] OPL2 FM     │      SUMMING MIXER  (mix #2)
                        │ serial SD/SY/SH  │            │
                        ▼                  │            ▼
                   [YM3014B U46] DAC       │      [DS1669 U48] volume (push-button pot)
                        │ MP (pin 16)      │            │
                        ▼                  │            ▼
                   [NJM2904 U11] buffer ───┘      [LM4861 U12] 1 W BTL amp
                     (unity, 0R fb)                  │      │
                                                 OUT+ │      │ OUT-
                                                      ▼      ▼
                                                   [J7 internal speaker]
                                                   [J3 headphone jack] + mute logic
```

### 8.1 Source 1 — PCM (the ES488's own codec)
Digital audio arrives over the ISA bus by **DMA** (`DRDY` pin 21 → gate array, `DACK1#` pin 36 from
Bowman) and is converted inside the ES488. Its analogue output leaves on **pin 9 `LineOut`**, carried by
the global label **`ESS_Sound`**, and enters the external mixer through **`C18` (270 nF)** DC-blocking
into **`R34` (1 kΩ)**. The chip's own analogue support pins are `FoutL/R` (1/7), `CinL/R` (2/8) for the
reconstruction filter, `ByPass` (10/11), `REF` (52, via `R23`), `CMR` (6, via `R226` 120 Ω) and
**`MIC` (4)** for the microphone input.

### 8.2 Source 2 — FM synthesis (a *discrete* OPL2)
The PC110 does **not** use integrated FM. It has a real **Yamaha YM3812 (OPL2, `U10`)**:

- **Data bus** `D0–D7` is *shared* with the ES488 and the `HD151015` transceiver (`R47`–`R65` are all
  **DNP** — unpopulated optional series resistors).
- **Control comes from the ES488.** Pin **14 `DIR`** drives net `YMF_CS#_Buf`, combined with `IOR#` in
  **`U66` (SN74LV02 NOR)** and buffered by **`U34` (74LV126)** to produce the OPL2's `CS#`, `RD#`, `WR#`
  and `A0` (`YMF_SA0_A0`, shared with ES488 pin 41). **The ES488 performs the FM address decode.**
- **Clock:** `U18` (a '74-type flip-flop) is wired `D ← ~Q` with `C` clocked — a **divide-by-two** — and
  feeds the YM3812's master clock pin 24 through **`R92` (47 Ω)** series damping. **[C]**
- **Reset:** `IC#` (pin 3) from `U31` + `U5` (74HC14 Schmitt), with `R147` 470 k.
- **Audio out is serial**, as the OPL2 requires: `MO`→`SD`, `SY`→`Clock`, `SH`→`LOAD` into
  **`U46` = YM3014B**, Yamaha's floating-point serial DAC.
- The YM3014B's analogue output `MP` (pin 16) is buffered by **`U11` (NJM2904)** as a **unity-gain
  follower** (`R67` 0 Ω in the feedback path), then joins the summing node through a 2.2 kΩ leg.

### 8.3 The mixer — discrete, and it sets the balance
**`U47` (NJM3414A, dual op-amp)** is a two-stage inverting mixer. Its first-stage summing node carries:

| Leg | Part | Role |
|---|---|---|
| input | **`R34` 1 kΩ** | **PCM** from `ESS_Sound` (via `C18`) |
| input | **`R26` 2.2 kΩ**, **`R32` 2.2 kΩ** | FM from the YM3014B buffer, and a second source **[H]** |
| feedback | **`R25` 1 kΩ** (with `R35` 100 kΩ) | sets stage gain |
| bias | `R27`/`R33` 470 kΩ into `+` | mid-rail reference |

With a 1 kΩ feedback, the **1 kΩ PCM leg mixes at ≈ unity while the 2.2 kΩ legs mix at ≈ 0.45** — i.e.
**digital audio is deliberately mixed ~7 dB hotter than FM.** Stage 2 is a unity-gain inverter
(`R227` 10 kΩ in, `R220` 10 kΩ feedback, `R217`/`R218` 470 kΩ bias).

### 8.4 Volume — a push-button digital pot
**`U48` = DS1669 "Dallastat"** (`V+` = `PNET6`, `V−` = GND, `RL` = GND). This is not a mixer register —
it is a **hardware up/down potentiometer**, matching the PC110's physical volume buttons. Because `RL`
is grounded it acts as a variable divider in the signal path between the mixer and the amplifier. **[C]**

### 8.5 Power amp and outputs
**`U12` = LM4861**, a 1 W **bridged (BTL)** amplifier: input through **`R24` 4.7 kΩ** with **`R121`
100 kΩ** feedback (≈ 21× single-ended, doubled differentially), `Bypass` tied to `IN+`. `OUT+` and
`OUT−` drive the internal speaker **`J7`** differentially — there is no ground-referenced speaker node.

**Headphone jack `J3`** plus a small discrete network — `Q6` (NPN, emitter grounded), `D5` (triple
diode), `R71`/`R74`/`R78` 10 kΩ, and `D40` into the LM4861's **`~SD` (shutdown, pin 1, `R247` 470 kΩ
pull)** — implements **speaker muting on headphone insertion**: jack detect switches `Q6`, which pulls
`~SD` and shuts the bridge amp down. **[H — the exact detect polarity was not traced; `J3`'s pins did
not resolve cleanly.]**

### 8.6 Where the mixing actually happens — and why it matters
- **Mix #1 is inside the ES488** (its own PCM/mic/line mixer), reachable only through the chip's
  registers.
- **Mix #2 is discrete and fixed in hardware** — resistor-weighted, with the PCM:FM balance set by
  `R34` vs the 2.2 kΩ legs. **No software can change it.**

Two consequences worth knowing: FM volume relative to digital audio is a **hardware** property of this
board, and the only *software* volume control is whatever the ES488's own mixer offers — the master
volume the user feels is the **DS1669**, a physical part.

## 9. Live chip identification  ✅ **[C 2026-07-28]**

Probed on a running PC110 with [`Software/ESSPROBE`](../../Software/ESSPROBE/) (read-only):

```
DSP reset: OK (0xAA)
DSP version: 02.01          -> Sound Blaster 2.0 class
ESS chip ID (0xE7): 48 82   -> first byte 0x48 = ES488 family
Mixer 0x00-0x7F: all FF     -> no SB Pro mixer decoded
```

- **`0x48` is the chip self-identifying as an ES488-family part** — confirmation independent of the
  silkscreen.
- **DSP `2.01` means it runs as a Sound Blaster 2.0** — mono, 8-bit — matching the `ADDAUdio 0220`
  configuration applied by `PS2.EXE`/Pluto.
- **All-`FF` mixer reads are expected in SB 2.0 mode** (the base+4/+5 mixer arrived with SB Pro), so
  nothing is faulty — the feature is simply not enabled.

*Open, and the cheapest possible audio upgrade:* whether the part will enter **ESS extended mode** (DSP
command `0xC6`) and expose stereo / extended registers. If it does, better audio is a **driver**
question with zero hardware work. Note this is a **mode change**, not a read — it may confuse a loaded
audio driver until reboot, so probe it deliberately.

## 10. Replacing the ES488 (e.g. with an ES1488) — feasibility  ⚠️ **[assessment]**

**Verdict: this is a board redesign, not a chip swap.** No ESS datasheet exists in this repo, so the
decisive fact — *is the ES1488 a 52-pin, pin-compatible superset?* — is unknown here. If it is a larger
package (as the later AudioDrive parts typically are), the footprint alone ends it. **Do not guess at a
pin mapping.**

### 10.1 What the board demands of anything in that socket
| Group | Pins | Constraint |
|---|---|---|
| ISA address | 41–43, 45–51 | `A0–A9` only → 8-bit I/O device |
| ISA data | 23–25, 28–32 | bus **shared with the YM3812** and the HD151015 |
| Strobes | 37 `IOR`, 38 `IOW` | **gated through `U71` (SN74LV32 OR)** — not raw ISA strobes |
| Arbitration | 40 `AEN`, 21 `DRDY`, 36 `DACK1#` | `AEN` from **Pluto**, `DACK1#` from **Bowman** |
| IRQ | 16, 18 | via `R29` |
| Reset | 39 | local, from `U20` (7W14 Schmitt) |
| Clock | 34/35 | crystal **`X2` = IBM P/N 89G6821**, 22 pF loads (frequency **not** recorded) |
| Power | 20, 27, 44 | all **`PNET5`** (shared with HD151015 `VCC`) — voltage **not** documented, measure it |
| Analogue | 1,2,4,6,7,8,9,10,11,13,52 | a large tuned filter/bias network depends on this exact pinout |

### 10.2 Four PC110-specific landmines
1. **The ES488 generates the OPL2's chip select** (§8.2). A replacement with *integrated* FM will not
   drive `YMF_CS#_Buf` the same way — you would orphan the YM3812, or have two FM synths contending for
   the same I/O range.
2. **The decode envelope lives in gate arrays you cannot reprogram** — gated `IOR`/`IOW`,
   `Pluto_ESS_AEN`, `Bowman_ESS_DACK1#`, and a reset/decode strobe synthesised from
   `FDC_DS3`/`Pluto_ESS_AEN`/`AEN`. This is not a standard 82C206 environment.
3. **Nothing in the machine will initialise a new chip.** Configuration comes from `PS2.EXE`/Pluto
   (`ADDAUdio`, `IRQAudio`, `DMAAudio`); there is no PnP, no config EEPROM, no BIOS audio init to
   retarget. A part needing its own init sequence comes up dead without a custom TSR.
4. **The analogue network and crystal are tuned to this part** (§8.1, §8.3). Any analogue pin remap
   invalidates the filter/bias design.

### 10.3 If you pursue it anyway — order of work
1. **Obtain the ES1488 datasheet.** It answers package/pinout, supply voltage, clock, whether FM is
   integrated, and how it is configured. The project cannot be scoped without it.
2. **Measure `PNET5`** (3.3 V vs 5 V changes everything).
3. **Prove the part in a desktop ISA slot first**, on a donor card, to learn its init and FM behaviour
   in a debuggable environment.
4. **Only then** attempt board work: footprint adaptation, the OPL2 decode problem, and an init TSR.

### 10.4 Recommendation
**Not worth it.** The gain is modest (8-bit → 16-bit playback, possibly better FM) while three of the
four landmines require re-solving problems the original designers solved *inside custom gate arrays*.
Better audio targets, in order: (a) find out whether the fitted ES488 has unused capability (§9), and
(b) improve the **analogue output path** — the LM4861, DS1669 and speaker are more likely to limit
perceived quality than the digital core is.
