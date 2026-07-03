# U51 — Chips & Technologies F65535 Display Controller

### Deep-dive analysis of U51 and its associated chips on the PC110 Motherboard recreation

*Source schematic: `Mainboard.pdf` — "PC110 Motherboard", KiCad 9.0.0, recreated by Ahmad Byagowi. Single-sheet design.*

---

## 1. Executive summary

**U51 is a Chips & Technologies F65535**, a single-chip flat-panel / CRT VGA controller, drawn here in a **BGA169** package (the symbol value reads `CHIPS65535`, footprint `BGA169`). It is the graphics engine of a from-scratch recreation of the **IBM Palm Top PC110 (1995)**, a 486-class palmtop. The original PC110 used this exact display controller, so the recreation faithfully keeps it.

The F65535 is special because it is almost a complete graphics card on one die: a 32-bit CPU bus interface, an **integrated DRAM controller** that owns its own framebuffer, an **integrated RAMDAC** that drives an analog CRT, and a **flat-panel formatter** that drives an LCD — all simultaneously. On this board U51 therefore sits at the crossroads of five different buses, which is why so many other chips "associate" with it.

In one sentence: **U51 takes pixel commands from the 486 over the local bus, stores them in its own DRAM (U28), and paints them onto both the internal LCD panel and an external VGA monitor, clocked by U63 and orchestrated by the custom glue logic in U21 ("Bowman").**

---

## 2. What the F65535 is

| Attribute | Value |
|---|---|
| Manufacturer | Chips & Technologies (later acquired by Intel) |
| Part | F65535 (flat-panel / CRT VGA / GUI controller) |
| Generation | 655xx "Wingine / flat-panel VGA" family (siblings: 65530, 65540, 65545, 65550, 65554) |
| Introduced | ~1993 |
| Internal core | 32-bit, ~65 MHz core clock |
| Memory | Integrated DRAM controller, 32-bit-capable memory path, up to ~1 MB framebuffer (this board fits more — see §6) |
| Display out | Simultaneous CRT (integrated RAMDAC) **and** STN/TFT flat panel |
| Silicon ID quirk | Shares its chip ID with the 65530 — drivers probe it as a "65530" |
| Package here | BGA169 |

In the real PC110 this chip drove a **640 × 480, 256-colour dual-scan passive (DSTN) LCD** internally and up to **800 × 600 / 16 colours** on an external monitor, and it shipped alongside a Japanese font ROM. The recreation reproduces that subsystem.

---

## 3. U51 complete pin map (by function)

Extracted directly from the schematic (pin name → BGA ball → connected net). Active-low signals are written with a trailing `#`.

### 3a. CPU local-bus interface (to the 486 / SCAMP / Bowman)

This is the "front door": U51 behaves as a device on the 80486 local bus.

| Signal | Ball | Net | Meaning |
|---|---|---|---|
| D0–D15 | D13,F10,E13,F11,F9,F12,F13,G9,G13,G12,H13,H9,H12,H11,J13,J12 | `CPU_D0…CPU_D15` | lower 16 data bits |
| D16–D31 | B2,B1,C2,E5,C1,D2,E3,D1,F4,E2,E1,F3,F2,F5,F1,G4 | `CPU_D16…CPU_D31` | upper 16 data bits |
| A2–A23 | L6,M6,J6,N6,M7,N7,J7,N8,M8,J8,L8,N9,M9,K8,N10,L9,M10,N13,M12,K11,M13,L12 | `CPU_A2…CPU_A23` | address bus |
| BE0#–BE3# | M5,L13,N5,J9 | `CPU_BE0#…CPU_BE3#` | byte enables (32-bit 486-style) |
| BS16# | C11 | `CPU_BS16#` | dynamic 16-bit bus sizing |
| ADS# | K12 | `CPU_ADS#` | address strobe |
| MIO# | J11 | `CPU_MIO#` | memory / IO cycle select |
| LDEV# | D11 | `CPU_LDEV#` | "local device" — U51 claims its address range |
| RDY# | (C12 area) | `CPU_RDY#` | cycle-ready handshake |
| CCLK | E10 | `Chipset_CPU_CLK` | CPU clock in |
| RESET | K10 | `RESET` | system reset |
| RSET | A13 | reset-related | |

### 3b. ISA / peripheral-side control

U51 also watches the slower peripheral bus so it can be programmed via I/O and decode legacy VGA memory.

| Signal | Ball | Meaning |
|---|---|---|
| SA0–SA15 | (G/H/J group) | peripheral address bus (`SA[0..15]`) |
| MEMR# / MEMW# | D12 / C12 | memory read / write |
| IOWR# | C13 | I/O write |
| ADDHI | J10 | high-address qualifier (`VGA_ADDHI`) |
| OEH# / OEL# | D10 / B13 | data-buffer output enables (high/low byte) |

### 3c. Framebuffer DRAM interface (to U28, the VRAM)

This is U51's private video memory port — a second, dedicated memory bus that the CPU never touches directly.

| Signal | Ball | Net role |
|---|---|---|
| IO0–IO15 | L1,K3,L2,K4,L3,N1,M2,L4,N2,M3,K5,J5,N3,M4,L5,N4 | 16-bit VRAM data |
| SA0–SA8 | G2,G1,G3,G5,H1,H2,H5,H3,J1 | multiplexed VRAM row/column address |
| RASA# / RASB# | H4 / A2 | row-address strobe, **two banks** |
| CASAL#/CASAH#/CASBL#/CASBH# | K2/J3/A1/C3 | column strobes, per byte, per bank |
| WEA# / WEB# | K1 / D4 | write enables per bank |
| 32kHz | J2 | refresh / low-speed timebase |

### 3d. Flat-panel (LCD) interface

| Signal | Ball | Net | Meaning |
|---|---|---|---|
| P0–P15 | E8,A8,B7,A7,E7,A6,B6,E6,C6,A5,B5,D6,A4,C5,B4,A3 | `LCD_B0..B4, LCD_G0..G4, LCD_R0..R4, LCD_24` | panel pixel data (R/G/B sub-fields) |
| SHFCLK | B8 | shift / pixel clock | clocks pixels into the panel |
| LP | A9 | line pulse (latch) | end-of-line |
| FLM | B9 | first-line marker | frame sync |
| M | C8 | AC modulation | STN polarity inversion drive |
| STNDBY# | K13 | `LCD_STNDBY#` | panel power-down |
| ENABKL | C4 | backlight enable |
| ENAVDD / ENAVEE | A11 / E9 | panel logic-supply / bias-supply enables |

### 3e. CRT / analog VGA output (integrated RAMDAC)

| Signal | Ball | Net |
|---|---|---|
| VGA_Red | D9 | `VGA_Red` |
| VGA_Green | A12 | `VGA_Green` |
| VGA_Blue | C10 | `VGA_Blue` |
| HSYNC | A10 | `VGA_HSync` |
| VSYNC | C9 | `VGA_VSync` |

### 3f. Clocks

| Signal | Ball | Net |
|---|---|---|
| XTAL0 | L10 | `VGA_CLK` (dot-clock reference, from U63) |
| XTALI | K9 | oscillator input |

### 3g. Power & no-connect

Multiple `VCC` / `VCC2` / `CVCC` / `CVCC2` and a large `GND` ball field (H10, J4, B10, E11, G11, D7, D3, N11, L11, L7, B12, B3, …). Balls **F6, F7, F8, G6, G7, G8, H6, H7, H8** are left unconnected (NC) on this layout.

---

## 4. The chips associated with U51

The board has ~80 ICs. The ones that **directly share nets with U51** — its true neighbours — are below, in order of how tightly they couple to it.

| Ref | Part | Role | How it connects to U51 |
|---|---|---|---|
| **U21** | **"Bowman"** (custom FPGA / gate-array) | Central glue logic / bus controller. Recreates the PC110's custom IBM gate arrays. | Generates/uses `CPU_LDEV#`, `RESET`, `MEMW#/IOWR#`, `ADDHI`, `Chipset_CPU_CLK`, `CPU_MIO#`, `CPU_ADS#`; also drives the ROM (`ROMA*`, `ROMCE#`), floppy, IRQs and address decode. The hub U51 talks through. |
| **U76** | **Intel 80486SX-33** (BGA256) | Main CPU, local-bus master. | Shares the full local bus: `CPU_D0..31`, `CPU_A2..23`, `CPU_BE0..3#`, `CPU_ADS#`, `CPU_MIO#`, `CPU_BS16#`, `CPU_RDY#`, clock. |
| **U61** | **VLSI VL82C420 "SCAMP IV"** (BGA256) | System controller chipset (the AT-compatible core: memory, ISA bridge, clocks, reset, power management). | Sits on the same CPU data/address bus; supplies the `SA[0..15]` peripheral bus and reset/clock domain U51 uses. |
| **U28** | **Mitsubishi M5M4V16160** (16 Mbit, 1M × 16 fast-page DRAM) | U51's dedicated **video framebuffer (VRAM)**. | Wired to `IO0..15`, `RAS#`, upper/lower `CAS#`, `W#`, `OE#` and the multiplexed address — i.e. U51's §3c port. |
| **U63** | **ICS AV9154A-27** | Clock generator / frequency synthesizer (reference inputs 14.318 MHz, 24 MHz, etc.). | Feeds `VGA_CLK` (dot clock at XTAL0) and `Chipset_CPU_CLK` (CCLK). |
| **U36** | **OKI MSM538032E** mask ROM | **Japanese font / Kanji character ROM** of the display subsystem. | A0–A19 / D0–D15 ROM, addressed via Bowman (`OKI_SA*` nets); read by the display/BIOS path that U51 serves. |
| **LCD connector** | 640×480 DSTN panel | Internal display. | `LCD_R*/G*/B*`, `FLM`, `LP`, `M`, `SHFCLK`, `STNDBY#`, backlight/supply enables (§3d). |
| **VGA connector** | External CRT | Second display. | `VGA_Red/Green/Blue`, `VGA_HSync`, `VGA_VSync` (§3e). |

### Wider board context (not on U51's bus, but part of the same machine)

| Ref | Part | Role |
|---|---|---|
| U35 | "Pluto" (custom FPGA/gate-array) | Keyboard / power-management / PS-2 controller (`KB_*`, `PWRGD`, `STPCLK#`, FDD, volume). |
| — | Mitsubishi **M38223E4HP** (740-family MCU) | Keyboard-controller microcontroller. |
| — | **M38813M4** (740-family MCU) | Secondary embedded controller. |
| U75 | NEC **µPD17137** (4-bit MCU) | Housekeeping / ADC (battery & analog monitoring). |
| U74 | Ricoh **RB5C396** (BGA256) | PCMCIA / PC-Card controller (`VCCSLOT`, `AVCC/BVCC`, `IRQ3..15`). |
| various | ESS / Yamaha (YMF) audio, 74-series logic, CompactFlash/CF slot (J11) | sound and I/O subsystems |

---

## 5. How the data flows through U51

1. **CPU writes graphics** — The 80486SX (U76), gated by the SCAMP chipset (U61) and the Bowman glue (U21), runs a local-bus cycle. U51 decodes its address range and asserts **LDEV#** to claim the cycle, accepting data on `CPU_D0..31`.
2. **U51 stores pixels** — Internally, U51's DRAM controller writes that data into its **own framebuffer in U28** over the `IO0..15` + RAS/CAS port. The CPU never sees this memory bus directly; it is private to the graphics chip.
3. **U51 scans out, twice, in parallel:**
   - To the **CRT**, U51's integrated RAMDAC produces analog **VGA_Red/Green/Blue** plus **HSync/VSync** to the external monitor.
   - To the **LCD**, U51's panel formatter produces digital **P0–P15** pixel data with **SHFCLK / LP / FLM / M** timing and the panel-power enables.
4. **Timing** — The dot clock and CPU clock both originate at the **AV9154 (U63)** synthesizer.
5. **Fonts** — Character/Kanji glyphs live in the **OKI mask ROM (U36)** and are fetched through the bus/Bowman path to support the PC110's Japanese text modes.

---

## 6. Observations & notes specific to this design

- **More VRAM than stock.** The original PC110 listed 512 KB of video RAM. Here **U28 is a 1M × 16 (2 MB) part** — the recreation gives the F65535 substantially more framebuffer than the factory machine.
- **Two DRAM banks wired.** U51 exposes `RASA#/RASB#` and four `CAS` lines (two banks × two byte lanes). The board appears to populate one bank, with the second available (note the `R131 DNP` / `DNP` resistor options near the memory).
- **Custom logic replaces IBM ASICs.** The PC110's proprietary gate arrays are re-implemented as the codenamed **"Bowman" (U21)** and **"Pluto" (U35)** devices, with off-the-shelf MCUs (M38223, M38813, µPD17137) handling keyboard, power and analog housekeeping.
- **Genuine VL local bus.** The presence of `BE0..3#`, `ADS#`, `BS16#`, `MIO#`, `LDEV#` confirms U51 is wired as a true 486 **VESA/VL local-bus** graphics device, not an ISA card — which is how it achieves usable graphics performance on a palmtop.
- **NC balls F6–H8** on U51 are intentionally unconnected in this layout.

---

## 6a. Live register state — real hardware (2026)  ✅ **[RE]**

Everything above is from the schematic. Reading U51's registers on a **running PC110** (over
[COMrade](../Live-Dump/), read-only) confirms the part and captures its live programming.

**Chip identity confirmed in silicon.** The C&T **extended registers (XR)** are read via I/O index
`0x3D6` / data `0x3D7`. `XR00` (Chip Version) reads **`0xC1`** → chipcode (bits 7-4) = **`0xC` = F65535**
and revision (bits 2-0) = **1**. This is the first *software* confirmation of the F65535 — previously
known only from the schematic symbol/package.

Live C&T extension registers (decoded against the VGADOC C&T reference):

| XR | Value | Register | Note |
|---|---|---|---|
| `00` | `C1` | Chip Version | **chipcode 0xC = 65535**, rev 1 |
| `01` | `DE` | DIP-switch / bus & clock source | memory-bus type + pixel/mem-clock select |
| `04` | `81` | Memory mapping/config | DRAM config / wait-state |
| `0A` | `00` | Cursor addr top | unused here |
| `0B` | `00` | Memory paging | extended paging off |
| `50` | `00` | Panel format | frame-rate/PWM/dither (text mode, defaults) |
| `51` | `C4` | **Panel type** | CRT-vs-FP + 8/16-bit FP video interface config |
| `60` | `88` | Blink rate | char/cursor blink |
| `61` | `2E` | Smartmap | CLUT bypass / enhanced-text thresholds |
| `70` | `00` | Setup/disable | `3C3`/`46E8` access enabled (bit7=0) |

**Current display mode (standard VGA side).** The machine was in **text mode 3** (`BDA 40:49 = 0x03`,
80×25, page 0):

- **Misc output** `0x3CC = 0x67` → colour I/O at `3Dx`, RAM enable, **dot clock select 1 (28.322 MHz)**,
  sync polarities for a 400-line mode.
- **Sequencer** `01=00` (9-dot characters), `02=03` / `04=02` → planar text, odd/even.
- **CRTC** decodes to **720×400**: horizontal display-end `4F`→80 chars, `09=4F`→16-line char cells,
  vertical display-end `12=8F` + overflow `07=1F` → 400 lines. Cursor/start regs at `0`.
- **Graphics ctlr** `06=0E` → memory map `B8000–BFFFF`, alpha/odd-even → colour text framebuffer at
  `B8000` (matches §5's data-flow description).

So on real silicon U51 is an **F65535 rev 1** driving standard VGA mode 3, with its C&T flat-panel
(`XR50/XR51`) and clock (`XR01`) extension registers live and readable — the software-visible
counterpart to the pin map in §3.

## 6b. Configuring the panel type (STN / DSTN / TFT / CRT)  ✅ **[RE] / 🟡 [H]**

**Yes — the panel is entirely software-configured** through the F65535's **flat-panel extended
registers** (the "XR" set at index port `0x3D6` / data `0x3D7`). The video BIOS loads a per-panel
parameter block into these at boot; a different panel is a matter of different XR values (that is
exactly how one C&T video-BIOS image supports many panels, and how flat-panel utilities retarget the
chip). The registers that matter:

| XR | Name | What it configures |
|---|---|---|
| `XR50` | **Panel Format** | grey-scale / colour **frame-rate control (FRC)** depth (bits 0-1), **dither** (bits 2-3), **shift-clock divide** = DotClk ÷1/2/4/8 (bits 4-5), FRC algorithm (bits 6-7) |
| `XR51` | **Panel Type** | **bit2 = Display Type (0 = CRT, 1 = Flat Panel)**; **bit3 = FP video interface width (set = 16-bit, clear = "8"/lower)**; bit4 = video skew; bit5 = shift-clock mask; bit6 = FP-compatibility enable; bit7 = text output polarity |
| `XR52` | Power-down control | panel power sequencing |
| `XR54` | **FP Interface** | flat-panel interface timing / data formatting |
| `XR55` | Horizontal compensation | panel H centring / stretch |
| `XR16–XR1F` | FP timing | flat-panel H/V total, panel size and sync widths (the 640×480 geometry) |

**Live on this PC110** (its factory **640×480 colour DSTN** panel):

```
XR50 = 0x00   XR51 = 0xC4   XR52 = 0x42   XR54 = 0xC0   XR55 = 0xE5   XR57 = 0x23
```

- `XR51 = 0xC4` → **Flat-Panel mode** (bit2=1), **FP-compatibility on** (bit6=1), text polarity set
  (bit7=1); interface-width bit3=0 and skew/mask off. So the chip is driving the internal LCD, not the
  CRT path.
- `XR50 = 0x00` → base FRC/dither/clock-divide state for that panel.
- The `XR16–XR1F` block holds the 640×480 flat-panel timing.

**Retargeting to another panel** (STN mono/colour, single- vs dual-scan **DSTN**, or **TFT**): set
`XR51` bit2 = 1 for a panel (or 0 to fall back to the CRT/RAMDAC path), pick the interface width
(bit3), and program the FRC/dither/clock-divide in `XR50` plus the H/V timing in `XR16–XR1F` to match
the new panel — the same fields the BIOS panel-table writes. **[H]:** the public VGADOC summary for
the 655x0 documents CRT-vs-FP, interface width, FRC, dither, skew and timing, but does **not** expose
a single clean "STN-vs-TFT" or "single-vs-dual-scan" selector bit — those are encoded across
`XR50/XR51/XR54` + the panel-size registers, and the authoritative bit map is the C&T **65530/65535
flat-panel/CRT VGA datasheet** (see Sources). The 65530/65535 generation is a passive-STN-oriented
flat-panel controller (it drives this DSTN panel natively via the 15-bit `LCD_R/G/B` data bus of §3d);
full active-matrix **TFT** timing is better supported on the later 6554x parts, so a TFT swap on the
*65535* would need panel timing that fits its FP interface, verified against that datasheet.

> ⚠️ **Do not reprogram these live and blind.** Changing `XR50/XR51/XR16-1F` on a running machine
> reprograms the LCD timing and will garble or blank the panel until the display driver / BIOS
> re-initialises it. Panel retargeting is a video-BIOS / bench task (change the values, reboot, and
> watch the panel), not a safe remote poke — which is why the values above were **read only**.

## 7. Sources

- [IBM Palm Top PC 110 — Wikipedia](https://en.wikipedia.org/wiki/IBM_Palm_Top_PC_110)
- [IBM PalmTop PC110 Wiki (Miraheze)](https://pc110.miraheze.org/wiki/Main_Page)
- [Dan's IBM PalmTop PC110 pages](https://www.basterfield.com/pc110/pc110idx.htm)
- [VGA Legacy MKIII — Chips & Technologies F65535](https://www.vgamuseum.info/index.php/cpu/item/183-chips-technologies-f65535)
- [Chips & Technologies Super VGA chip sets (VGADOC)](https://cs.nyu.edu/~mwalfish/classes/ut/f09-cs395t/ref/hardware/vgadoc/CHIPS.TXT)
- [VLSI VL82C420 / 144 / 146 (SCAMP IV) — The Retro Web](https://theretroweb.com/chipsets/568)
- [Ricoh RF5C396 / RB5C396 PC-Card controller datasheet](https://www.digchip.com/datasheets/parts/datasheet/404/RF5C396.php)
- [ICS AV9154A frequency generator datasheet](https://www.alldatasheet.com/datasheet-pdf/pdf/65379/ICST/AV9154A.html)
- [Mitsubishi VLSI MOS Memory (DRAM/Video RAM) catalog](https://archive.org/stream/bitsavers_mitsubishimoryRAMROMandMemoryCardsJan91_10549185/Mitsubishi_VLSI_MOS_Memory_RAM_ROM_and_Memory_Cards_Jan91_djvu.txt)

*Pin/net data extracted directly from the uploaded `Mainboard.pdf` schematic; part-role descriptions corroborated with the public sources above.*
