# PC110 BIOS decompressor — located, identified, and reproduced

## Result
The compressed `0x00000` flash region is **LZW-compressed**, and the decompressor is
**in the ROM itself**. I located it, read its parameters out of the machine code,
reimplemented it, and **successfully decompressed the region** — 143,335 bytes of
valid x86 + the complete Easy-Setup UI. The standalone unpacker
(`pc110_lzw_unpack.py`) reproduces the output bit-for-bit.

## Where it is
- The head of the `0x00000` region is **not** compressed — it's an uncompressed loader.
  Option-ROM header `55 AA 00`, then `EB 45` jumps to the loader at file offset **0x4A**.
- The loader (0x4A–0x092):
  - sets up far source pointers from `cs` and `cs+0x2000` (`[0x2AB]:[0x2A9]` start = `cs:0x2BF`),
  - sets destination `es = 0x9000`, moves the stack to `9000:0`,
  - `rep movsb` copies the first 0x1000 bytes to `9000:0`, then `retf` to `9000:0x93`
    to continue executing the decoder **from RAM** (self-relocation),
  - calls the LZW decoder at `0xA3`, then `ljmp FFFF:0000`-style handoff to the unpacked image.
- The **LZW decoder** is at file offset **0xA3**, with helpers:
  `0x16A` get_code, `0x1C7` reset-dictionary, `0x1DA` output-byte, `0x205` dict-entry-address,
  `0x210` add-dict-entry, `0x227` refill-input-window, `0x260` flush-output-window.

## Algorithm (read from the code)
| Property | Value | Source |
|----------|-------|--------|
| Method | LZW (compress-style) | dict = {prev_code, char} chain walk |
| Bit order | **LSB-first** | `lodsw`/`lodsb` + `shr al,1; rcr bx,1` by bit-offset |
| Code width | **9 → 12 bits** | `[0x299]` init 9, `cmp …,0x0C` cap |
| CLEAR / END | **0x100 / 0x101** | `cmp ax,0x100` / `cmp ax,0x101` |
| First free code | **0x102** | `[0x295]` init 0x102 |
| Width-bump | threshold `[0x29B]` init **0x200**, doubles | `shl word[0x29b],1` |
| Width masks | 0x1FF,0x3FF,0x7FF,0xFFF | table at `[0x29D]` |
| Dict entry | 3 bytes `{u16 prev, u8 char}` | base `0xABF`, `bx*3+0xABF` (`0x205`) |
| Output | reversing stack → 0x400 buffer @ `0x6BF` | KwKwK handled (`code==free`) |
| Stream start | file **0x2BF** | `[0x2A9]=0x2BF` |
| Source span | up to `cs+0x2000` (0x20000 B) | `[0x2B1]` limit |
| Dest | `0x5000:0` … `0x9800:0` | `[0x2AF]` init 0x5000, `cmp …,0x9800` |

## What was inside
`region0_decompressed.bin` (143,335 B) — the decompressed Setup/BIOS body. Strings in
`region0_strings.txt` (520 lines) include the full **Easy-Setup** menu and diagnostics:

- Menu: `Config`, `Date/Time`, `Password`, `Start up`, `Test`, `Restart`, `OK`, `Cancel`, `Exit`
- Devices: `SystemBoard`, `Memory`, `Keyboard`, `Parallel_1/2/3`, `Serial 1/2`, `Modem 1/2`,
  `PCMCIA-1/2`, `Infrared 1/2`, `Mouse`, `Pointing Device`, `Font Window`
- Diagnostics: `Device ID : … Error No : … FRU No :`, `Power management version`, `Setup version`,
  `Power-on`, `Test All`, `Typematic Normal/Fast`
- `(C) Copyright IBM Corp. 1992, 1995 All Rights Reserved.`

## Reproduce
```
python3 pc110_lzw_unpack.py pc110_bios.bin region0_decompressed.bin
# -> decompressed 143335 bytes
```

## Why this matters
- Unlocks the Easy-Setup UI text/code for the emulator and documentation.
- The same loader maps the payload to `0x50000+`, so the decompressed image can now be
  disassembled directly (it's the graphical Setup app + supporting code).
- Closes the last "packed/unknown" region of the flash: the 256 KB image is now fully
  accounted for — boot block + LZW loader/payload (0x00000), Chips 65535 VGA BIOS (0x20000),
  IBM 39H4551 system BIOS (0x30000).
