#!/usr/bin/env python3
"""
PC110 DSTN -> TFT video-BIOS patch  ---  *** VALIDATION REQUIRED (untested by us on HW) ***

Reproduces, as a reproducible tool, the exact 18-byte edit that Kevin Moonlight's
`vpatch.exe` (the TFT Upgrade Kit's BIOS updater; == Mods/TFT/BIOS_Patch.img)
makes to the Chips & Technologies F65535 video BIOS to drive an active-matrix
TFT panel instead of the stock passive dual-scan DSTN.

The edits are ABSOLUTE writes into the F65535 flat-panel XR init tables, at
offsets within the video BIOS (which lives at chip 0x20000 = the CPU E000
window). Decoded + interpreted in Discovery/65535/readme.md 6c. Registers:
  XR50 (panel format: FRC/dither/shift-clock -- a TFT is true-colour, no FRC),
  XR51/XR54/XR4F (panel type / FP interface), XR19-1C + XR64-6F (FP H/V timing).

  *** IMPORTANT: on the archived reference BIOS
  (Components/Flash/E28F002BXT/E28F002BXT@TSOP40.BIN) these 18 bytes ALREADY
  hold these values -- so this patch is a NO-OP against that image. It only
  changes anything on a BIOS whose video-BIOS panel tables actually differ
  (the DSTN revision vpatch was authored against). See README. ***

Accepts a full 256 KB BIOS, a 96 KB main-block slice (chip 0x20000-0x37FFF),
or a 64 KB raw video-BIOS dump (chip 0x20000-0x2FFFF); it auto-detects by size
and writes at the right base. For 256 KB / 96 KB inputs it also emits a 96 KB
PC110ROM.BIN slice for the PS2GUI/PS2TUI "Flash BIOS" feature.
"""
import argparse, hashlib, os, sys

# (video-BIOS offset -> value) ; offset is relative to the video BIOS start
# (chip 0x20000 = CPU E000). Extracted from vpatch's `mov ah,vv; mov [es:off],ah`
# writes (es = the E000 RAM copy).
PATCH = {
    0x1CB: 0x1F,
    0xA9A: 0x42, 0xA9C: 0xC0, 0xAA0: 0xC5, 0xAA4: 0xC4, 0xAA6: 0xC0,
    0xAB4: 0x1C, 0xAB8: 0x00,
    0xAE6: 0x56, 0xAE8: 0x13, 0xAEA: 0x5F, 0xAF6: 0x00, 0xAF7: 0x0C,
    0xAFA: 0x01, 0xAFC: 0x26, 0xAFE: 0xDF, 0xB00: 0x05, 0xB04: 0x00,
}
VBIOS_BASE_IN_FULL = 0x20000   # chip offset of the video BIOS in a 256 KB image

def detect_base(n):
    if n == 0x40000: return VBIOS_BASE_IN_FULL, "256 KB full BIOS"
    if n == 0x18000: return 0x0,               "96 KB main-block slice (chip 0x20000-0x37FFF)"
    if n == 0x10000: return 0x0,               "64 KB raw video-BIOS dump (chip 0x20000-0x2FFFF)"
    sys.exit(f"unrecognised input size 0x{n:X}; expected 256 KB, 96 KB, or 64 KB")

def main():
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description="Apply the DSTN->TFT video-BIOS patch")
    ap.add_argument("input", nargs="?", default=os.path.join(
        here, "..", "..", "..", "Components", "Flash", "E28F002BXT", "E28F002BXT@TSOP40.BIN"))
    ap.add_argument("--out", default=here)
    a = ap.parse_args()
    src = bytearray(open(a.input, "rb").read())
    base, kind = detect_base(len(src))
    print(f"input: {kind}, sha1 {hashlib.sha1(src).hexdigest()}")
    changed, already = [], []
    for off, val in sorted(PATCH.items()):
        i = base + off
        if src[i] == val:
            already.append((off, val))
        else:
            changed.append((off, src[i], val))
            src[i] = val
    print(f"\n{len(changed)} byte(s) changed, {len(already)} already at target:")
    for off, old, new in changed:
        print(f"  vbios 0x{off:04X}: {old:02X} -> {new:02X}")
    if not changed:
        print("  (none -- this input already carries the TFT values: NO-OP)")
    out_full = os.path.join(a.out, "TFT_" + os.path.basename(a.input))
    open(out_full, "wb").write(src)
    print(f"\nwrote {out_full}  (sha1 {hashlib.sha1(src).hexdigest()})")
    if len(src) == 0x40000:
        slice_ = os.path.join(a.out, "PC110ROM.BIN")
        open(slice_, "wb").write(bytes(src[0x20000:0x38000]))
        print(f"wrote {slice_}  (96 KB flasher slice)")

if __name__ == "__main__":
    main()
