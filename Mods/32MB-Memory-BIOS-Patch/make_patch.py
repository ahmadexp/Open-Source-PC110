#!/usr/bin/env python3
"""
PC110 memory-expansion BIOS patch  ---  *** VALIDATION REQUIRED (untested on HW) ***

Patches the stock PC110 BIOS so a machine populated with MORE than the stock
20 MB (e.g. a 16+16 MB module giving 36 MB physical) boots cleanly by CAPPING
the POST extended-memory count at a chosen total, instead of walking past the
VL82C420's 32 MB address ceiling and wrapping/corrupting low RAM during POST.

Why cap the *count* and not the geometry:  the count routine (F000:5FBC) is a
write/read-back DATA-INTEGRITY test, not an alias detector -- downgrading a
bank's geometry register just lets the physical DRAM alias and pass the test,
so the count would wrap anyway.  Capping the count is the provably-safe fix:
POST never touches memory above the cap, so it never wraps.  See
Discovery/RAM-Module/readme.md 7.4-7.5 and Discovery/Chipset/readme.md 13k.

The patch is 17 bytes, entirely inside the 96 KB main flash block (so it is
flashable by the PS2GUI/PS2TUI "Flash BIOS" feature and leaves the boot block
-- the reset vector -- untouched and recoverable).

  hook  @ flash 0x36095 (F000:6095, in the ext-mem count loop):
        replace `add bx,0x40` (83 C3 40) with `jmp 0x25CE` (E9 rr rr)
  stub  @ flash 0x325CE (F000:25CE, a verified-unreferenced dead slot):
        add bx,0x40
        cmp bx,<CAP>          ; CAP = extended-KB for the target total
        jnc  done             ; reached cap -> stop counting
        jmp  continue         ; else resume the loop
        jmp  done

Default target = 28 MB (taka's proven-stable value; 256-colour Windows works).
Pass --mb 32 to use the full non-wrapping ceiling (see README caveats).
"""
import argparse, hashlib, os, sys

STOCK_SHA1 = "ffadd0d7c0ec619a3cd34c1d030299e1a9da1c58"   # E28F002BXT@TSOP40.BIN, 256 KB
HOOK   = 0x6095      # F-segment offset of `add bx,0x40` in the count loop
STUB   = 0x25CE      # F-segment offset of the out-of-line stub (dead, 0 refs)
RESUME = 0x6098      # loop continue target (inc byte[0x4c])
DONE   = 0x60A9      # loop exit target
FBASE  = 0x30000     # flash offset of F-segment (CPU F0000)

def rel16(next_ip, target):
    return (target - next_ip) & 0xFFFF

def build(stock: bytes, total_mb: int) -> bytes:
    if len(stock) != 0x40000:
        sys.exit("stock image must be 256 KB (0x40000 bytes)")
    got = hashlib.sha1(stock).hexdigest()
    if got != STOCK_SHA1:
        print(f"WARNING: stock sha1 {got} != known {STOCK_SHA1} (patching anyway)")
    if not (1 < total_mb <= 32):
        sys.exit("target total must be 2..32 MB")
    cap = (total_mb - 1) * 1024            # extended KB counted from the 1st MB
    if cap > 0xFFFF:
        sys.exit("cap does not fit in the 16-bit count")
    d = bytearray(stock)
    # hook: E9 rel16 -> STUB
    hr = rel16(HOOK + 3, STUB)
    d[FBASE+HOOK:FBASE+HOOK+3] = bytes([0xE9, hr & 0xFF, hr >> 8])
    # stub
    stub  = bytes([0x83, 0xC3, 0x40])                      # add bx,0x40
    stub += bytes([0x81, 0xFB, cap & 0xFF, cap >> 8])      # cmp bx,cap
    stub += bytes([0x73, 0x03])                            # jnc +3 (-> done jmp)
    cr = rel16(STUB + 12, RESUME); stub += bytes([0xE9, cr & 0xFF, cr >> 8])
    dr = rel16(STUB + 15, DONE);   stub += bytes([0xE9, dr & 0xFF, dr >> 8])
    d[FBASE+STUB:FBASE+STUB+len(stub)] = stub
    # sanity: nothing outside the 96 KB main block (0x20000-0x37FFF) changed
    for i, (a, b) in enumerate(zip(stock, d)):
        if a != b and not (0x20000 <= i < 0x38000):
            sys.exit(f"patch touched a byte outside the main block at 0x{i:05x}")
    return bytes(d)

def main():
    here = os.path.dirname(os.path.abspath(__file__))
    ap = argparse.ArgumentParser(description="Build the PC110 memory-cap BIOS patch")
    ap.add_argument("--stock", default=os.path.join(
        here, "..", "..", "Components", "Flash", "E28F002BXT", "E28F002BXT@TSOP40.BIN"))
    ap.add_argument("--mb", type=int, default=28, help="target total RAM cap in MB (default 28)")
    ap.add_argument("--out", default=here, help="output directory")
    a = ap.parse_args()
    stock = open(a.stock, "rb").read()
    patched = build(stock, a.mb)
    full = os.path.join(a.out, "PC110_BIOS_patched.BIN")
    slice_ = os.path.join(a.out, "PC110ROM.BIN")           # 96 KB main block for the flasher
    open(full, "wb").write(patched)
    open(slice_, "wb").write(patched[0x20000:0x38000])
    diffs = [(i, stock[i], patched[i]) for i in range(len(patched)) if stock[i] != patched[i]]
    print(f"target cap: {a.mb} MB  ({(a.mb-1)*1024} KB extended = 0x{(a.mb-1)*1024:04X})")
    print(f"changed {len(diffs)} bytes:")
    for i, x, y in diffs:
        print(f"  0x{i:05x}: {x:02x} -> {y:02x}")
    print(f"wrote {full}  (256 KB, sha1 {hashlib.sha1(patched).hexdigest()})")
    print(f"wrote {slice_}  (96 KB flasher slice, sha1 {hashlib.sha1(patched[0x20000:0x38000]).hexdigest()})")

if __name__ == "__main__":
    main()
