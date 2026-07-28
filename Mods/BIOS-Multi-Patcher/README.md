## PC110 BIOS Multi-Patcher (`PCPATCH.COM`)

> # ⚠️ VALIDATION REQUIRED — UNTESTED ON HARDWARE, and REQUIRES an IBM-floppy boot
> Reflashing the BIOS can **brick** the machine. This tool has **not** been run on real hardware.
> It only actually writes when the **12 V VPP rail is present**, which on the PC110 means you must
> **boot from a floppy in an IBM-marked floppy drive** (see [`Discovery/BIOS-Flash`](../../Discovery/BIOS-Flash/readme.md)
> §7). Run it only on a unit you can recover with an external programmer.

One DOS tool that applies (and where possible reverses) every known PC110 BIOS mod, from a single
menu. The flash sequence is **byte-identical to `vpatch`** (Discovery/BIOS-Flash §8); it reflashes
only the **96 KB main block** and never touches the boot block (reset vector), so a bad main-block
write stays recoverable.

### Menu

```
  1) Display: DSTN -> TFT
  2) Display: TFT -> DSTN (restore A:\PANEL.SAV)
  3) Windows 256-colour fix
  4) Memory: enable 32 MB patch
  5) Memory: remove 32 MB patch
  6) Diagnose current BIOS (read-only)
  ESC) Quit
```

| # | What it does |
|---|---|
| 1 | Applies the 18 F65535 flat-panel XR writes for an active-matrix **TFT** panel (== vpatch). First saves the machine's **current** 18 video-BIOS bytes to `A:\PANEL.SAV` so #2 can undo it. See [`Discovery/65535`](../../Discovery/65535/readme.md) §6c. |
| 2 | Restores the video-BIOS bytes from `A:\PANEL.SAV` (the backup #1 made). |
| 3 | Applies just the **Windows 256-colour fix** (video-BIOS `0x1CB = 0x1F`, the "linear start" byte). |
| 4 | Applies the **28 MB memory count-cap patch** so a >20 MB machine cold-boots cleanly (== [`Mods/32MB-Memory-BIOS-Patch`](../32MB-Memory-BIOS-Patch)). Verifies the BIOS is stock at the hook first. |
| 5 | Removes the 32 MB patch (restores the stock bytes). Verifies it is patched first. |
| 6 | **Diagnose** — reports which patches are present: display panel (TFT vs stock DSTN, by matching the 18 panel bytes against both tables), the Windows 256-colour fix, and the 32 MB patch, with the raw bytes. **Read-only** (reads the C000/F000 shadows; no port I/O, no flash commands), so it is safe from **any** boot device — no floppy/VPP needed. **Hardware-verified** on a stock DSTN unit (reported `DSTN (stock) 0/18 TFT, 18/18 DSTN`, Win-256 absent, 32 MB absent). |

Every option: **confirms** (Y), **checks A/C + battery ≥ 20 %** (`INT 15h/530A`), then flashes. Reboot
to take effect.

### Safety / robustness

- **CS-relative staging** — the 96 KB flash-image buffer is placed at `CS+0x1000 / CS+0x2000`, so it
  can never collide with a resident agent (e.g. a serial monitor) or the program's own stack, whatever
  segment DOS loads the `.COM` at. (Aborts if it would run past conventional memory.)
- **Pre-flash verification** — the 32 MB enable/remove refuse to run unless the BIOS is in the exact
  expected state (stock `83 C3 40` / patched `E9 36 C5` at the hook), so it won't double-patch or run
  on an unexpected image.
- **Boot-block preserved** — only the 96 KB main block is erased/programmed.

### TFT↔DSTN restore

TFT→DSTN (#2) prefers `A:\PANEL.SAV` — the backup #1 makes from **that** machine. If no backup exists
it falls back to the **confirmed stock DSTN table** captured live from an unmodified DSTN PC110
(`Discovery/65535` §6c.1), so the reverse works even on a machine that was already converted before you
had this tool. Use **#6 Diagnose** first to see which state the BIOS is actually in.

*Caveat:* the built-in DSTN set comes from one unmodified unit; a different factory video-BIOS revision
could differ, which is why a machine's own `PANEL.SAV` takes precedence and why #6 reports
"MIXED / unknown revision" instead of guessing.

### Build

```
nasm -f bin PCPATCH.ASM -o PCPATCH.COM
```
Put `PCPATCH.COM` on a bootable IBM-DOS floppy, boot the PC110 from it (IBM FDD), and run it.
