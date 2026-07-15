# U21 "Bowman" — Detailed Analysis

*Source: `Mainboard.pdf` ("PC110 Motherboard", KiCad / Eeschema‑PDF, created 2025‑07‑20), part of the [Open‑Source‑PC110](https://github.com/ahmadexp/Open-Source-PC110) reverse‑engineering project.*

---

## 1. Summary

**U21 (value field: `Bowman`)** is the IBM PC110's **main system‑controller ASIC** — a ~144‑pin custom gate array that bridges the 80486SX CPU local bus to a 16‑bit ISA‑style system bus and absorbs nearly all of the machine's glue logic (ROM decode, interrupt aggregation, DMA handshaking, floppy, keyboard‑MCU link, audio glue and power sequencing).

This corresponds to the documented **custom RIOS chip that "controlled the ISA bus and expanded the bus width to 16 bits."** The PC110 was co‑developed by **IBM Japan and Ricoh (RIOS)** in 1995; its 486SX‑33 CPU and several support chips carry RIOS markings. `Bowman` is the project/codename used on the schematic — there is no public datasheet for the part.

| Attribute | Value |
|---|---|
| Reference designator | **U21** |
| Value / codename | **Bowman** |
| Function | System controller / CPU‑to‑ISA bridge ("chipset") |
| Pin count | 144 (highest pin = 144; QFP‑class custom gate array) |
| CPU interface | 80486SX local bus (U76, 80486SX‑33, BGA256) |
| Companion controller | U35 **"Pluto"** (linked via `Bowman_IO1/2`, `Pluto_IO`) |

---

## 2. Role in the system architecture

The PC110 is built around a small set of custom RIOS chips rather than an off‑the‑shelf chipset. Bowman is the heart of that arrangement:

```
   80486SX-33 (U76, BGA256)
        │  CPUA2..25, CPU_ADS#/MIO#/DC#/WR#/RDY#/INTR/RESET, CPUCLK
        ▼
   ┌─────────────┐    M38_IO1..12     ┌──────────────┐
   │  U21 BOWMAN │◄──────────────────►│ U67 M38813M4 │ keyboard / PM MCU
   │  (system    │                    └──────────────┘
   │  controller)│    ESS_IRQ/DACK    ┌──────────────┐
   │             │◄──────────────────►│ ES488 audio  │ (Sound Blaster)
   │             │    ROMA/ROMCE#     ┌──────────────┐
   │             │◄──────────────────►│ Flash BIOS   │
   │             │    Pluto_IO,       └──────────────┘
   │             │    Chipset_IO      ┌──────────────┐
   │             │◄──────────────────►│ U35 PLUTO    │ I/O controller
   └─────┬───────┘                    └──────────────┘
         │ SA0..15 / SD0..7 / IOR#/IOW#/AEN / IRQ2..15 / DRQ/DACK
         ▼
   16-bit ISA-style system bus  → CompactFlash, PCMCIA, YM3812 (OPL2), etc.
```

In short, the CPU talks only to Bowman on its fast local bus; Bowman translates those cycles into 16‑bit ISA bus cycles and routes interrupts, DMA, ROM and peripheral chip‑selects. The companion chip **Pluto (U35)** handles the lower‑speed/peripheral I/O (CF/dock detect, LCD, IrDA, RS‑232 enable, floppy data lines, keyboard speaker, RAM ID, BIOS write‑enable), and the two custom chips exchange status over dedicated `Bowman_IO`/`Pluto_IO` lines.

---

## 3. Complete pinout (by function)

### 3.1 CPU local bus — 80486SX interface (left side of symbol)

| Signal | Pin | Notes |
|---|---|---|
| `CPUA2`–`CPUA25` | 10‑17, 19‑27, 29‑35 | CPU address bus (A0/A1 handled as byte‑enables, not exposed here) |
| `CPU_ADS#` | 49 | Address strobe (486 ADS#) |
| `CPU_MIO#` | 50 | Memory / IO# (486 M/IO#) |
| `CPU_DC#` | 41 | Data / Control# (486 D/C#) |
| `CPU_WR#` | 42 | Write / Read# (486 W/R#) |
| `CPU_RDY#` | 134 | Ready / cycle complete (486 RDY#) |
| `CPU_INTR` | 133 | Maskable interrupt to CPU (8259 INTR equivalent) |
| `CPU_RESET` | 46 | CPU reset |
| `CPUCLK` | 38 | CPU clock |

### 3.2 16‑bit ISA‑style system bus

| Signal | Pin | Notes |
|---|---|---|
| `SA0`–`SA15` | 55‑63, 65‑71 | System address bus |
| `SD0`–`SD7` | 96,95,94,93,92,91,89,88 | System data (low byte on Bowman; high byte routed elsewhere) |
| `IOR#` | 112 | I/O read |
| `IOW#` | 113 | I/O write |
| `AEN` | 114 | Address enable (DMA in progress) |
| `MEMCS16#` | 119 | 16‑bit memory chip‑select |
| `LDEV#` | 43 | Local device select |
| `ADDHI` | 124 | High‑address qualifier |
| `DS3#` | 123 | Decode/strobe |

### 3.3 Interrupt controller (8259‑class aggregation)

| Signal | Pin | | Signal | Pin |
|---|---|---|---|---|
| `IRQ2` | 87 | | `IRQ10` | 78 |
| `IRQ3` | 85 | | `IRQ11` | 77 |
| `IRQ4` | 84 | | `IRQ12` | 76 |
| `IRQ5` | 83 | | `IRQ14` | 75 |
| `IRQ7` | 81 | | `IRQ15` | 74 |
| `IRQ9` | 79 | | `KB_IRQ1` | 86 (keyboard IRQ1) |
| `ESS_IRQ1` | 118 | | | |

### 3.4 DMA & floppy

| Signal | Pin | Notes |
|---|---|---|
| `FINTR` | 82 | Floppy interrupt |
| `FDRQ` | 115 | Floppy DMA request |
| `PDRQ` | 117 | Peripheral DMA request |
| `DACK#` | 120 | DMA acknowledge |
| `PDACK#` | 121 | Peripheral DMA acknowledge |
| `ESS_DACK#` | 122 | Audio (ESS) DMA acknowledge |
| `FDD_IO` | 125 | Floppy control I/O |

### 3.5 ROM / BIOS decode

| Signal | Pin | Notes |
|---|---|---|
| `ROMA12`–`ROMA19` | 9,7,6,5,4,3,2,143 | ROM high address lines |
| `ROMCE#` | 142 | ROM chip‑enable |

### 3.6 Keyboard / power‑management MCU link (Mitsubishi M38813)

| Signal | Pin | Notes |
|---|---|---|
| `M38_IO1`–`M38_IO12` | 97,98,101,102,103,104,105,106,107,110,111,139 | Parallel link to U67 (M38813M4 keyboard/PM microcontroller) |
| `KB_RESET#` | 48 | Keyboard reset |
| `KB_SCRLED#` | 53 | Scroll‑lock LED |

### 3.7 Power, clocks & housekeeping

| Signal | Pin | Notes |
|---|---|---|
| `PWRGD_IN` | 141 | Power‑good input from PSU |
| `PWRGD` | 47 | Power‑good output / system ready |
| `PSU_IO1` / `PSU_IO2` | 131 / 138 | Power‑supply control I/O |
| `24MHz` | 40 | 24 MHz reference clock |
| `32kHz` | 51 | 32.768 kHz timekeeping clock |
| `VolUP` / `VolDN` | 127 / 128 | Volume button inputs |
| `Pluto_IO` | 129 | Link to U35 (Pluto) |
| `Chipset_IO1`–`5` | 45,140,39,52,130 | **VL82C420↔Bowman ML bus** (measured live 2026-07-06, pin IDs corrected 2026-07-14, see [Chipset §11b](../Chipset/readme.md)): `Chipset_IO3`/pin 39 = **MLCLK** (~22.7 MHz), `Chipset_IO4`/pin 52 = **MLADS#**; `Chipset_IO1/2/5` (45/140/130) idle = MLLBA#/MLRDY#/Mpriority (cache-less / fixed-timing) |

### 3.8 Power rails

| Rail | Pins |
|---|---|
| `VCC` / `VCC2` | 1, 18, 36, 37, 54, 72, 73, 90, 99, 108, 109, 126, 144 |
| `GND` | 8, 28, 44, 64, 80, 100, 116, 136 |
| `NC` (no connect) | 132, 135, 137 |

---

## 4. Surrounding components and the chips Bowman talks to

| Ref | Part | Role | Link to Bowman |
|---|---|---|---|
| **U76** | 80486SX‑33 (BGA256) | Main CPU (Intel SL‑Enhanced, RIOS‑marked) | CPU local bus + control |
| **U35** | **Pluto** (custom, ~100‑pin) | Peripheral I/O controller (CF/dock/LCD/IrDA/RS‑232, FDD data, KB speaker, RAM ID, BIOS WE) | `Bowman_IO1/2`, `Pluto_IO`, shared SA/SD bus |
| **U67** | M38813 / M38813M4 | Mitsubishi 740‑family keyboard & power‑management MCU | `M38_IO1..12`, `KB_*` |
| **U10** | YM3812 (OPL2) + YM3014B DAC | Yamaha FM synthesis | via ISA bus |
| — | ES488 / ES488F | ESS AudioDrive (Sound‑Blaster‑compatible) | `ESS_IRQ1`, `ESS_DACK#` |
| — | Flash BIOS ROM | System firmware | `ROMA*`, `ROMCE#` |
| **J11** | CompactFlash | Mass storage (16‑bit `SD0..15`) | via ISA bus |
| **U70** | TPS2201 | PCMCIA dual‑slot power switch (near U21) | PSU / PNET nets |
| **U30A** | 74LVT74 | Flip‑flop / reset timing near U21 | PNET nets |

Local support around U21 on the sheet includes pull‑ups `R98` (4.7k) / `R99` (470Ω), transistors `Q9` / `Q13`, and the `PNET`/`PSU_IO` power‑sequencing network shared with the PCMCIA power switch — consistent with Bowman also overseeing card‑slot power‑up and reset timing.

---

## 5. Observations & open questions for the project

1. **No `CPUA0`/`CPUA1`.** The CPU address bus to Bowman starts at A2; byte selection is presumably handled via byte‑enable signals (standard for the 486 bus). Worth confirming which pins carry BE# if any.
2. **8‑bit data on Bowman, 16‑bit elsewhere.** Bowman exposes only `SD0..7`, yet the documented job of the RIOS chip is the **16‑bit** bus expansion (CompactFlash uses `SD0..15`). The high byte / `MEMCS16#` steering likely happens through `ADDHI`, `Chipset_IO*`, or in concert with Pluto — a good thing to trace against the X‑rays.
3. **Bowman ↔ Pluto coupling.** Pluto carries `Bowman_IO1` (pin 51) and `Bowman_IO2` (pin 52); Bowman carries `Pluto_IO` (pin 129). Mapping exactly what passes over these lines would clarify the division of labour between the two custom chips.
4. **Codenames.** `Bowman` and `Pluto` appear to be project codenames rather than IBM/RIOS part markings. If die photos or X‑rays reveal silk/laser markings, cross‑referencing them would let the BOM cite the true RIOS part numbers.

### Live probe (2026) — Bowman has no host-readable config bank ✅ **[RE]**
Bowman is the **transparent 486↔ISA bridge**: unlike the VL82C420 (which has an indexed config space
now dumped — see [Chipset §13a](../Chipset/)) and Pluto (whose FDC/PCIC/EC windows are readable — see
[Pluto §6c](../Pluto/)), Bowman does **not** expose a host-visible register bank. Live probing on a
running unit found the two candidate config-pair banks the BIOS helper table can reach —
`0x24/0x25` and `0xD00/0xD01` — read back **all-`0xFF`** on this machine (even with the `0x22/0x23`
config gate open), and the `0x4F` config latch Bowman/SCAMP shares is **write-only** (147 POST writes,
zero reads; indices `0x11,0x66,0x70,0x0A,0x1E,0xB6,0x8F,0x65,0xBF,0xFF`). So Bowman's bridge/decode
behaviour is configured at POST and is not read-back-able at runtime — consistent with a hard-wired
gate array rather than a programmable controller with a live register file.

---

---

## 6. Discovery from the ROM dump — U36 font ROM (`MSM538032E@SOP44.BIN`)

A binary dump was supplied as "from U28," but U28 in the schematic is DRAM (`M5M4V16160BTP`). The dump actually belongs to **U36**, the OKI **`MSM538032E`** mask ROM (alt. marking `M538032C`, SOP‑44, 16‑bit `D0..D15`, `A0..A19`, `CE#`/`OE#`/`BHE`, on the `OKI_SA*` / `SD[0..15]` nets). It is **not** related to Bowman's BIOS path (`ROMA*`/`ROMCE#` → Flash); it's a separate, CPU‑addressable **font ROM** sitting on the system data bus.

### What the dump contains

- **Header:** magic `55 AA 10 CB`, label `FONT`, and the string
  `84G7940 (C) Copyright IBM Corporation 1990, 1995 All Rights Reserved`, dated **03/23/95**.
- **IBM part number 84G7940** — the PC110 **DOS/V display font ROM**.
- Size **1 MiB**; the file is fully populated (the seven font regions account for ~1 MB).

### Font directory (parsed from offset 0x210; 48‑byte entries)

| Font set | Glyph size | Bytes/glyph | Data offset | Glyphs |
|---|---|---|---|---|
| System SBCS 12 | 6 × 12 | 12 | 0x0D8000 | 256 |
| System SBCS 16 | 8 × 16 | 16 | 0x002000 | 256 |
| System SBCS 19 | 8 × 19 | 19 | 0x000400 | ~256 |
| System SBCS 24 | 12 × 24 | 48 | 0x044000 | 256 |
| System DBCS 12 | 12 × 12 | 18 | 0x0D8C00 | ~8,900 |
| System DBCS 16 | 16 × 16 | 32 | 0x003000 | ~8,300 |
| System DBCS 24 | 24 × 24 | 72 | 0x047000 | ~8,200 |

- **SBCS = single‑byte (ANK), JIS X 0201:** ASCII (with `¥` at 0x5C instead of backslash) plus half‑width katakana at 0xA1–0xDF. Rendering glyph 0x41/0x42 produces a clean "A"/"B" — confirmed.
- **DBCS = double‑byte, JIS X 0208:** hiragana, full‑width katakana, Greek, Cyrillic, symbols, and the ~6,800 kanji of JIS levels 1 & 2. Rendered glyph blocks show correct kana/Greek/Cyrillic.

### Why it matters

The PC110 has no hardware kanji video; **IBM DOS/V renders Japanese text in software by reading bitmaps from this ROM.** Four pixel heights (12/16/19/24) supply screen text, larger UI, and print‑quality glyphs. Decoding the directory format means the entire glyph set can now be extracted, documented, and cross‑checked — useful for a full BOM entry on U36 and for anyone re‑implementing the font path (e.g., in an FPGA or emulator).

Render proofs: `font_SBCS16_ascii.png` (single‑byte set) and `font_DBCS16_kanji.png` (double‑byte kana/Greek/Cyrillic block).

### Open items
- The chip's `A0..A19` × 16‑bit organization implies up to ~2 MB; this dump is 1 MB. Confirm whether the device is 8 Mbit (1 M × 8 / read as bytes) or a 16 Mbit part read as a single bank — i.e. whether a second 1 MB bank exists.
- Map the `OKI_SA*` high‑address latch and `OKI_CE#` decode (Bowman vs. Pluto) to document exactly how the CPU pages this ROM into its I/O or memory window.

---

## Sources

- Uploaded schematic: `Mainboard.pdf` ("PC110 Motherboard", KiCad).
- Uploaded ROM dump: `MSM538032E@SOP44.BIN` (IBM font ROM P/N 84G7940, 1995).
- [Open‑Source‑PC110 (GitHub) — ahmadexp](https://github.com/ahmadexp/Open-Source-PC110)
- [Reverse Engineering The IBM PC110, One PCB At A Time — Hackaday](https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/)
- [IBM PalmTop PC110 teardown — iPhone Wired](https://iphonewired.com/news/11094/) (CPU 486SX‑33 BGA with RIOS markings; C&T 65535A graphics; ESS + Yamaha audio; IBM Japan + Ricoh)
- [PC110 — ThinkWiki](https://www.thinkwiki.org/wiki/PC110)
