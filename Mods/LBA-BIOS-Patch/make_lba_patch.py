#!/usr/bin/env python3
"""
make_lba_patch.py -- reproducible builder for the PC110 LBA/EDD BIOS patch.

Reads the stock 256 KB flash image, asserts the expected bytes at every patch
site (and refuses to continue if anything differs), assembles lba13.asm with
nasm, splices the payload into the 0xCC hole at file offset 0x30080, rewrites
the 3 hook bytes at file offset 0x352BD, and emits:

    PC110_BIOS_lba.BIN    full 256 KB image (for an external programmer)
    PC110ROM_lba.BIN      the 96 KB main-block slice 0x20000..0x37FFF
                          (exactly the region PCPATCH.ASM erases + programs)

The single most important safety property -- that nothing outside
0x20000..0x37FFF changed -- is re-verified from the produced bytes, not
assumed, and the run aborts if it is violated.

    usage: python3 make_lba_patch.py [--rom PATH] [--outdir DIR]
"""

import argparse
import hashlib
import os
import subprocess
import sys

# ---------------------------------------------------------------- constants

STOCK_SHA1 = "ffadd0d7c0ec619a3cd34c1d030299e1a9da1c58"
STOCK_SIZE = 262144

DEFAULT_ROM = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    "..", "..", "Components", "Flash", "E28F002BXT", "E28F002BXT@TSOP40.BIN",
)

# The flasher (Mods/BIOS-Multi-Patcher/PCPATCH.ASM) erases and programs exactly
# this range and preserves everything else.  Every byte we change must be here.
SAFE_LO = 0x20000
SAFE_HI = 0x38000                       # exclusive

# The 0xCC fill hole that hosts the payload.  F000:0080 == file 0x30080.
HOLE_OFF = 0x30080
HOLE_END = 0x31F00                      # exclusive; 0x31F00 is `E9 8F 7E`
HOLE_LEN = HOLE_END - HOLE_OFF          # 7808
PAYLOAD_SEG_ORG = 0x0080                # the ORG in lba13.asm

# The end-of-POST bootstrap call.  F000:52BC..52BF == `FB CD 19 F4`.
# We keep the `sti` and replace `CD 19 F4` with a 3-byte near JMP to F000:0080.
HOOK_OFF = 0x352BD
HOOK_OLD = bytes([0xCD, 0x19, 0xF4])            # int 19h ; hlt
HOOK_CONTEXT_OFF = 0x352B8
HOOK_CONTEXT = bytes([0x2A, 0xC0,               # sub al,al
                      0xE6, 0x8B,               # out 0x8B,al
                      0xFB,                     # sti          <- kept
                      0xCD, 0x19,               # int 19h      <- replaced
                      0xF4,                     # hlt          <- replaced
                      0xE8, 0x3C, 0x97])        # call 0xE9FF  <- must survive

# Sites we do not patch but whose bytes the payload's correctness depends on.
# If any of these moved, the analysis behind the patch no longer holds.
INVARIANTS = [
    (0x3D2D7, bytes([0x80, 0xFA, 0x80, 0x73, 0x05, 0xCD, 0x40, 0xCA, 0x02, 0x00]),
     "F000:D2D7 boot-block base INT 13h handler (our last-resort chain target)"),
    (0x352C0, bytes([0xE8, 0x3C, 0x97, 0x83, 0x3E, 0x0E, 0x00, 0x00, 0x75, 0x1D,
                     0x8B, 0x1E, 0x13, 0x00, 0x4B, 0xC1, 0xE3, 0x06, 0x89, 0x1E,
                     0x0E, 0x00]),
     "F000:52C0 stock EBDA allocator (defines 0040:000E == 0040:0013<<6)"),
    (0x3527D, bytes([0xB8, 0x00, 0x00, 0x8E, 0xD0, 0xBC, 0x00, 0x04]),
     "F000:527D POST stack setup SS=0000 SP=0400 (why INIT switches stacks)"),
    (0x38041, bytes([0xB0, 0x80, 0x26, 0x3A, 0x06, 0xEC, 0x00, 0x74, 0x21]),
     "F000:8041 BAFE install guard: skipped when EBDA:00EC == 0x80"),
    (0x3BAFE, bytes([0x83, 0xEC, 0x0E, 0x55, 0x8B, 0xEC]),
     "F000:BAFE DL-remap shim prologue"),
    (0x3DA8D, bytes([0x1E, 0xE8, 0x6E, 0x0F, 0xA1, 0x0E, 0x00, 0x8E, 0xC0]),
     "F000:DA8D FDPT locator -> EBDA:003D / EBDA:004D"),
    (0x3D5A0, bytes([0x26, 0x8B, 0x07, 0x26, 0x8A, 0x4F, 0x04, 0xD3, 0xE8]),
     "F000:D5A0 stock AH=08 (FDPT +0 cyl, +4 shift) -- our stock-reach maths"),
]


def die(msg):
    print("FATAL: " + msg, file=sys.stderr)
    sys.exit(1)


def hexs(b):
    return " ".join("%02X" % x for x in b)


# ------------------------------------------------------------------- checks

def load_stock(path):
    if not os.path.isfile(path):
        die("stock image not found: %s" % path)
    data = bytearray(open(path, "rb").read())
    if len(data) != STOCK_SIZE:
        die("stock image is %d bytes, expected %d" % (len(data), STOCK_SIZE))
    got = hashlib.sha1(data).hexdigest()
    if got != STOCK_SHA1:
        die("stock image sha1 %s != expected %s" % (got, STOCK_SHA1))
    print("stock image  : %s" % os.path.normpath(path))
    print("               %d bytes, sha1 %s  OK" % (len(data), got))
    return data


def assert_sites(d):
    print("\n--- pre-flight byte assertions -------------------------------")

    got = bytes(d[HOOK_CONTEXT_OFF:HOOK_CONTEXT_OFF + len(HOOK_CONTEXT)])
    if got != HOOK_CONTEXT:
        die("hook context at 0x%05X differs\n  want %s\n  got  %s"
            % (HOOK_CONTEXT_OFF, hexs(HOOK_CONTEXT), hexs(got)))
    print("  0x%05X hook context  %s  OK" % (HOOK_CONTEXT_OFF, hexs(HOOK_CONTEXT)))

    got = bytes(d[HOOK_OFF:HOOK_OFF + 3])
    if got != HOOK_OLD:
        die("hook bytes at 0x%05X are %s, expected %s"
            % (HOOK_OFF, hexs(got), hexs(HOOK_OLD)))
    print("  0x%05X hook bytes    %s  OK" % (HOOK_OFF, hexs(HOOK_OLD)))

    # `CD 19` must be unique inside the safe window, else we picked the wrong one
    hits = [i for i in range(SAFE_LO, SAFE_HI - 1)
            if d[i] == 0xCD and d[i + 1] == 0x19]
    if hits != [HOOK_OFF]:
        die("expected exactly one `CD 19` in 0x%05X..0x%05X, found %s"
            % (SAFE_LO, SAFE_HI, [hex(h) for h in hits]))
    print("  `CD 19` is unique in the safe window            OK")

    hole = d[HOLE_OFF:HOLE_END]
    if set(hole) != {0xCC}:
        bad = next(i for i, v in enumerate(hole) if v != 0xCC)
        die("hole 0x%05X..0x%05X is not all 0xCC (first exception at 0x%05X = 0x%02X)"
            % (HOLE_OFF, HOLE_END - 1, HOLE_OFF + bad, hole[bad]))
    print("  0x%05X..0x%05X  %d bytes of 0xCC fill        OK"
          % (HOLE_OFF, HOLE_END - 1, HOLE_LEN))

    if bytes(d[HOLE_END:HOLE_END + 3]) != bytes([0xE9, 0x8F, 0x7E]):
        die("byte after the hole at 0x%05X is not `E9 8F 7E`" % HOLE_END)
    print("  0x%05X first live byte after the hole is E9 8F 7E OK" % HOLE_END)

    for off, want, what in INVARIANTS:
        got = bytes(d[off:off + len(want)])
        if got != want:
            die("invariant at 0x%05X (%s) differs\n  want %s\n  got  %s"
                % (off, what, hexs(want), hexs(got)))
        print("  0x%05X %-46s OK" % (off, what[:46]))

    # The APM installer at E000:955B claims the first >= 0x356-byte run of
    # 0x0000 in F000:E000-FFFF, else in F000:0000-DFFF, else the first 0xCCCC
    # run.  In the stock image search #1 hits the zero run at F000:F100, which
    # lives in the never-erased boot block, so the 0xCC hole is never taken.
    # If that zero run ever shrank, our payload could be overwritten at
    # runtime -- so assert it.
    z = 0
    while d[0x3F100 + z] == 0 and 0x3F100 + z < 0x40000:
        z += 1
    if z < 0x356:
        die("the zero run at F000:F100 is only %d bytes (< 0x356); the APM "
            "allocator at E000:955B could fall through to the 0xCCCC search "
            "and overwrite the payload" % z)
    print("  F000:F100 zero run = %d bytes (>= 0x356)         OK" % z)


# -------------------------------------------------------------------- build

def assemble(srcdir, outdir):
    src = os.path.join(srcdir, "lba13.asm")
    obj = os.path.join(outdir, "lba13.bin")
    lst = os.path.join(outdir, "lba13.lst")
    cmd = ["nasm", "-f", "bin", "-l", lst, src, "-o", obj]
    print("\n--- assembling -----------------------------------------------")
    print("  " + " ".join(cmd))
    r = subprocess.run(cmd, capture_output=True, text=True)
    if r.stdout.strip():
        print(r.stdout.strip())
    if r.stderr.strip():
        print(r.stderr.strip())
    if r.returncode != 0:
        die("nasm failed (exit %d)" % r.returncode)
    payload = open(obj, "rb").read()
    print("  payload      : %d bytes  (hole is %d, %.1f%% used, %d spare)"
          % (len(payload), HOLE_LEN, 100.0 * len(payload) / HOLE_LEN,
             HOLE_LEN - len(payload)))
    if len(payload) > HOLE_LEN:
        die("payload does not fit in the hole")
    if not payload:
        die("payload is empty")

    # The APM allocator hazard again: keep the *used* region free of any
    # internal 0xCC run long enough to be claimed.  Only the untouched tail
    # after the payload may be 0xCC.
    run = best = 0
    for b in payload:
        run = run + 1 if b == 0xCC else 0
        best = max(best, run)
    if best >= 0x356:
        die("payload contains a %d-byte internal 0xCC run; the APM allocator "
            "could claim it" % best)
    print("  longest internal 0xCC run in payload: %d (< 0x356)  OK" % best)
    return payload


def build(d, payload):
    out = bytearray(d)
    changes = []

    out[HOLE_OFF:HOLE_OFF + len(payload)] = payload
    changes.append((HOLE_OFF, len(payload), "payload (lba13.bin) at F000:%04X"
                    % PAYLOAD_SEG_ORG))

    # near JMP from the next-IP (F000:52C0) to F000:0080
    rel = (PAYLOAD_SEG_ORG - 0x52C0) & 0xFFFF
    hook = bytes([0xE9, rel & 0xFF, (rel >> 8) & 0xFF])
    out[HOOK_OFF:HOOK_OFF + 3] = hook
    changes.append((HOOK_OFF, 3, "hook: %s -> %s  (jmp near F000:%04X)"
                    % (hexs(HOOK_OLD), hexs(hook), PAYLOAD_SEG_ORG)))
    return bytes(out), changes, hook


# ------------------------------------------------------------------- verify

def diff_ranges(a, b):
    """Return coalesced [start, end) ranges where a and b differ."""
    out = []
    i, n = 0, len(a)
    while i < n:
        if a[i] != b[i]:
            j = i
            while j < n and a[j] != b[j]:
                j += 1
            out.append((i, j))
            i = j
        else:
            i += 1
    return out


def verify(stock, patched, payload):
    print("\n--- change report --------------------------------------------")
    if len(stock) != len(patched):
        die("output size changed")
    rngs = diff_ranges(stock, patched)
    total = 0
    for lo, hi in rngs:
        total += hi - lo
        seg = "F000:%04X" % (lo - 0x30000) if 0x30000 <= lo < 0x38000 else \
              "E000:%04X" % (lo - 0x20000) if 0x20000 <= lo < 0x30000 else "?"
        print("  0x%05X..0x%05X  (%5d bytes)  %s" % (lo, hi - 1, hi - lo, seg))
    print("  %d change range(s), %d bytes total" % (len(rngs), total))

    print("\n--- SAFETY: only 0x%05X..0x%05X may change --------------------"
          % (SAFE_LO, SAFE_HI - 1))
    bad = [(lo, hi) for lo, hi in rngs if lo < SAFE_LO or hi > SAFE_HI]
    if bad:
        die("changes OUTSIDE the safe window: %s"
            % ["0x%05X..0x%05X" % (l, h - 1) for l, h in bad])
    print("  boot block   0x3C000..0x3FFFF : %s"
          % ("UNCHANGED" if stock[0x3C000:0x40000] == patched[0x3C000:0x40000]
             else "CHANGED -- ABORT"))
    print("  PARAM1       0x38000..0x39FFF : %s"
          % ("UNCHANGED" if stock[0x38000:0x3A000] == patched[0x38000:0x3A000]
             else "CHANGED -- ABORT"))
    print("  PARAM2       0x3A000..0x3BFFF : %s"
          % ("UNCHANGED" if stock[0x3A000:0x3C000] == patched[0x3A000:0x3C000]
             else "CHANGED -- ABORT"))
    print("  banks 0/1    0x00000..0x1FFFF : %s"
          % ("UNCHANGED" if stock[0:0x20000] == patched[0:0x20000]
             else "CHANGED -- ABORT"))
    for lo, hi, name in ((0x3C000, 0x40000, "boot block"),
                         (0x38000, 0x3A000, "PARAM1"),
                         (0x3A000, 0x3C000, "PARAM2"),
                         (0, 0x20000, "banks 0/1")):
        if stock[lo:hi] != patched[lo:hi]:
            die("%s changed" % name)
    print("  ALL CLEAR")

    # spot-check the spliced bytes
    if patched[HOLE_OFF:HOLE_OFF + len(payload)] != payload:
        die("payload not present in output")
    tail = patched[HOLE_OFF + len(payload):HOLE_END]
    if set(tail) not in ({0xCC}, set()):
        die("hole tail is no longer pure 0xCC fill")
    print("  hole tail 0x%05X..0x%05X still pure 0xCC (%d bytes) -- left as a "
          "legal target for the APM allocator"
          % (HOLE_OFF + len(payload), HOLE_END - 1, len(tail)))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--rom", default=DEFAULT_ROM)
    ap.add_argument("--outdir", default=os.path.dirname(os.path.abspath(__file__)))
    a = ap.parse_args()

    here = os.path.dirname(os.path.abspath(__file__))
    os.makedirs(a.outdir, exist_ok=True)

    print("=== PC110 LBA/EDD BIOS patch builder =========================\n")
    stock = load_stock(a.rom)
    assert_sites(stock)
    payload = assemble(here, a.outdir)
    patched, changes, hook = build(stock, payload)

    print("\n--- patch sites ----------------------------------------------")
    for off, ln, what in changes:
        print("  0x%05X  +%-5d  %s" % (off, ln, what))

    verify(stock, patched, payload)

    full = os.path.join(a.outdir, "PC110_BIOS_lba.BIN")
    slic = os.path.join(a.outdir, "PC110ROM_lba.BIN")
    open(full, "wb").write(patched)
    open(slic, "wb").write(patched[SAFE_LO:SAFE_HI])

    print("\n--- output ---------------------------------------------------")
    for p in (full, slic):
        b = open(p, "rb").read()
        print("  %-22s %7d bytes  sha1 %s"
              % (os.path.basename(p), len(b), hashlib.sha1(b).hexdigest()))
    print("\n  PC110_BIOS_lba.BIN : full 256 KB image, for an external programmer.")
    print("  PC110ROM_lba.BIN   : the 96 KB main block 0x20000..0x37FFF, i.e.")
    print("                       E000:0000..FFFF followed by F000:0000..7FFF --")
    print("                       exactly what PCPATCH's staging buffer holds.")
    print("\ndone.")


if __name__ == "__main__":
    main()
