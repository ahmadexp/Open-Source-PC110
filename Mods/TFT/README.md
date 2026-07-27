## TFT Replacement

Replacing the PC110's stock passive **DSTN** LCD with an active-matrix **TFT** panel.

- **`BIOS_Patch.img`** — the TFT Upgrade Kit's bootable DOS floppy (Kevin Moonlight's `vpatch`), which
  reflashes the video BIOS to drive the TFT panel.
- **[`bios-patch/`](bios-patch/)** — a reproducible form of that same BIOS change: a builder script,
  the exact 18-byte patch spec (`tft_patch.txt`), and docs. The edit reconfigures the F65535
  flat-panel registers (panel format / type / timing) — decoded in
  [`Discovery/65535`](../../Discovery/65535/readme.md) §6c, flashable via the PS2GUI/PS2TUI *Flash BIOS*
  feature ([`Discovery/BIOS-Flash`](../../Discovery/BIOS-Flash/readme.md)). **⚠️ VALIDATION REQUIRED.**
  A reverse (TFT→DSTN) patch is pending a confirmed unpatched-DSTN video-BIOS dump — see that folder.
