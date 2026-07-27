## DSTN → TFT video-BIOS patch (reproducible)

> # ⚠️ VALIDATION REQUIRED
> Reflashing the BIOS can **brick** the machine. This tooling reproduces a known-working patch but has
> **not** been re-validated by this project on hardware. Only flash a unit you can recover externally,
> on A/C power. See [`Discovery/BIOS-Flash`](../../../Discovery/BIOS-Flash/readme.md).

A reproducible form of the **TFT Upgrade Kit's BIOS change** — the same edit as
Kevin Moonlight's `vpatch` / the [`../BIOS_Patch.img`](../BIOS_Patch.img) floppy — that reconfigures
the Chips & Technologies **F65535** video BIOS to drive an **active-matrix TFT** panel instead of the
stock **passive dual-scan DSTN**.

### What it changes

**18 absolute byte writes** into the F65535 flat-panel XR init tables inside the video BIOS (which
lives at chip `0x20000` = the CPU `E000` window). Full offset/register list in
[`tft_patch.txt`](tft_patch.txt); decoded and interpreted in
[`Discovery/65535`](../../../Discovery/65535/readme.md) §6c. In summary the conversion reprograms:

- **`XR50` panel format** — FRC / dither / shift-clock divide (a TFT is true-colour and needs **no**
  frame-rate-control greyscale/dithering that a passive DSTN requires);
- **`XR51` / `XR54` / `XR4F`** — panel type + flat-panel interface timing/format;
- **`XR19–1C` and `XR64–6F`** — flat-panel H/V timing and panel size.

Nothing else in the machine changes — the DSTN→TFT swap is **video-BIOS-only** (plus the physical TFT
panel of the upgrade kit).

### Usage

```
python3 make_tft_patch.py [input.bin] [--out DIR]
```
Accepts a **256 KB** full BIOS, a **96 KB** main-block slice (chip `0x20000–0x37FFF`), or a **64 KB**
raw video-BIOS dump (chip `0x20000–0x2FFFF`); it auto-detects and patches at the right base. For a
256 KB input it also emits a **96 KB `PC110ROM.BIN`** slice for the PS2GUI/PS2TUI *Flash BIOS* feature.

### ⚠️ No-op against the archived reference BIOS

Run against this repo's [`E28F002BXT@TSOP40.BIN`](../../../Components/Flash/E28F002BXT), the tool
reports **0 bytes changed** — that image **already carries the TFT values at all 18 offsets** (verified
against the live `vbios_C0000.bin` too). So either the archived unit is already TFT-converted, or these
18 bytes are not the DSTN/TFT differentiator on *this* BIOS revision and `vpatch` was authored against a
different (DSTN) revision. Because of this, **no pre-built patched image is committed here** (it would be
byte-identical to stock). Apply the tool to a BIOS whose panel tables actually differ, and validate on
hardware.

### Reverse (TFT → DSTN) — not yet possible from our data

`vpatch` writes **absolute** bytes, so reversing it needs the **original DSTN values** at these 18
offsets — and the archived BIOS does not contain them (it already holds the TFT values; see above). A
correct TFT→DSTN undo therefore requires a **confirmed unpatched DSTN** video-BIOS dump to diff against.
Provide one (raw chip `0x20000–0x2FFFF`, or a full 256 KB from a known-DSTN machine) and the undo is a
one-line diff of these 18 offsets. We will **not** ship a guessed reverse patch. *(Open item.)*
