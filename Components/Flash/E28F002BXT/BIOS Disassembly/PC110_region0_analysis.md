# PC110 flash region 0x00000–0x1FFFF — analysis

## What it is
- `0x00000`: option-ROM-style header `55 AA 00 EB 45 90` (JMP +0x45) followed immediately by
  `09/19/95 (C) Copyright IBM Corp. 1994` — a small real-mode stub + copyright, then payload.
- `0x00000–0x15FFF`: **~88 KB of uniform high-entropy data (H ≈ 7.6–7.8 bits/byte)** with almost
  no plaintext (108 short strings total, essentially only the copyright). That entropy profile =
  **compressed**, not code/tables.
- `0x16000–0x17FFF`: tail (27% `0xFF`).
- `0x18000–0x1FFFF`: erased (`0xFF`).

## Compression
- No standard container signature (not gzip/zip/bzip2/LZH). First bytes are the ROM stub, not a
  codec header. → a **custom LZ/LZSS/RLE** scheme, which was normal for IBM/RIOS-era BIOS bodies.
- This region is **not executed in place**. It is the packed payload (the graphical **Easy-Setup**
  UI and/or the relocated main BIOS body / ROM-DOS) that the **F000 POST code decompresses into RAM**
  at boot. It is reached through the chipset **ROM bank control** — the `ROMCE#`/`ROMA12–19` lines
  we mapped on the Bowman ASIC select these flash pages.

## Why it can't just be dumped to text here
Decompressing requires the exact codec. The decompressor lives in the F000 system BIOS POST path.
Statically guessing a custom LZ variant is unreliable and I won't fabricate output.

## Concrete next step (highest yield)
Locate the decompressor in `pc110_bios_F000.asm`: look for the routine that
(1) sets up `ds:si` into the C000/D000 bank (the 0x00000 region) and `es:di` into low RAM, and
(2) runs a copy loop with bit-tests / back-references (LZSS signature: a control byte whose bits
select literal vs. (offset,length) copy). Re-implement that loop in C, point it at this region, and
the Easy-Setup strings/bitmaps fall out. The PC110-EMU core is the easiest place to instrument this:
log the source window the BIOS reads and the destination it writes during early POST.

## VGA BIOS (companion, 0x20000) — done
Disassembled to `pc110_vgabios_C000.asm` (5,144 insns, 135 subs). Confirmed
**"Chips 65535 VGA 32KB BIOS, Version 2.0.2, Copyright (C) 1994 Chips and Technologies"**,
"CHIPS 65535 Flat Panel VGA". Entry C000:0003; uses 0x42/0x43 (timing delays), 0x61, 0x70/0x71,
and DX-addressed C&T extended CRTC registers (3Dx) for the 640×480 flat-panel path.
