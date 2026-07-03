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
