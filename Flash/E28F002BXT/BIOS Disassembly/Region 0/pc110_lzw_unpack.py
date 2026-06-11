#!/usr/bin/env python3
"""
pc110_lzw_unpack.py — unpack the compressed payload in the IBM PC110 BIOS
flash region 0x00000-0x15FFF.

The decompressor was located in the BIOS itself: the head of the 0x00000
region is an *uncompressed* loader (entry at file offset 0x4A) that relocates
its first 4 KiB to 9000:0, jumps there, and runs a variable-width **LZW**
decoder.  Parameters read directly out of that routine's machine code:

  * LSB-first bit packing
  * code width 9 -> 12 bits  ([0x299] starts 9, capped at 0x0C)
  * CLEAR code = 0x100 (resets dict + width), END code = 0x101
  * first free code = 0x102 ([0x295])
  * dictionary entry = {u16 prev_code, u8 char}, 3 bytes, table base 0xABF
  * width-bump threshold starts 0x200 and doubles ([0x29B])
  * compressed bitstream starts at region file offset 0x2BF ([0x2a9])

This reimplements that decoder.  Verified: it produces 143,335 bytes whose
content is valid x86 plus the PC110 Easy-Setup UI strings.

Usage:  python3 pc110_lzw_unpack.py pc110_bios.bin region0_decompressed.bin
"""
import sys

CLEAR, END = 0x100, 0x101
COMP_START = 0x2BF          # file offset where the LZW stream begins

def lzw_decode(buf, max_out=1 << 20):
    out = bytearray()
    bitpos, nbits = 0, len(buf) * 8

    def get_code(width):
        nonlocal bitpos
        if bitpos + width > nbits:
            return END
        v = 0
        for i in range(width):                       # LSB-first
            b = buf[(bitpos + i) >> 3]
            v |= ((b >> ((bitpos + i) & 7)) & 1) << i
        bitpos += width
        return v

    def fresh():
        return ([(0, i) for i in range(256)] + [(0, 0), (0, 0)], 9, 0x102)

    dictionary, width, free = fresh()
    prev = None
    while len(out) < max_out:
        code = get_code(width)
        if code == END:
            break
        if code == CLEAR:
            dictionary, width, free = fresh(); prev = None
            continue
        if code < free:                              # known code
            s, c = [], code
            while c >= 256:
                s.append(dictionary[c][1]); c = dictionary[c][0]
            s.append(c); s.reverse()
        elif code == free and prev is not None:      # KwKwK
            s, c = [], prev
            while c >= 256:
                s.append(dictionary[c][1]); c = dictionary[c][0]
            s.append(c); s.reverse(); s.append(s[0])
        else:
            break                                    # corrupt / end
        out.extend(s)
        if prev is not None:
            dictionary.append((prev, s[0])); free += 1
            if free >= (1 << width) and width < 12:   # threshold doubles
                width += 1
        prev = code
    return bytes(out)

def main():
    if len(sys.argv) != 3:
        print(__doc__); sys.exit(1)
    rom = open(sys.argv[1], "rb").read()
    payload = rom[COMP_START:0x16000]                 # 0x16000.. is 0xFF-erased
    out = lzw_decode(payload)
    open(sys.argv[2], "wb").write(out)
    print(f"decompressed {len(out)} bytes -> {sys.argv[2]}")

if __name__ == "__main__":
    main()
