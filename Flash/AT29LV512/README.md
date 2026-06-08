# AT29LV512@TSOP32.BIN Firmware Analysis

This repository/folder contains a first-pass analysis of the binary dump named `AT29LV512@TSOP32.BIN`.

The dump appears to be **SanDisk/SunDisk SDP3B PCMCIA ATA FlashDisk controller firmware**, stored in a 64 KiB AT29LV512 flash ROM. The image is not a filesystem or standard host executable. It has a Motorola 68000-style vector table, embedded PCMCIA CIS data, an ATA Identify Drive template, and command-dispatch logic for ATA-style flash-disk operations.

## Files

| File | Purpose |
|---|---|
| `AT29LV512@TSOP32.BIN` | Original 64 KiB ROM dump. |
| `AT29LV512_analysis_report.txt` | Plain-text firmware analysis notes. |
| `AT29LV512_analysis_report.pdf` | PDF version of the analysis report. |
| `AT29LV512_reachable_68k_disasm.txt` | Capstone-assisted Motorola 68000 reachable-code disassembly seeded from reset/vector-table targets. |
| `README.md` | This summary and usage guide. |

## High-confidence identification

Evidence found inside the ROM:

- Motorola 68000-style big-endian vector table at the beginning of the image.
- Reset PC: `0x0000042C`.
- Initial supervisor stack pointer: `0x00FF95FE`.
- Product/vendor strings:
  - `SunDisk`
  - `SDP3B`
  - `Rev 1.21`
  - `COPYRIGHT (C) 1993,1994,1995 SUNDISK CORPORATION`
- PCMCIA Card Information Structure-like tuples beginning around offset `0x5242`.
- ATA Identify Drive template beginning around offset `0x53A6`.
- ATA command dispatch and handlers for read, write, erase, identify, set-features, diagnostic, translate-sector, and wear-level style commands.

## Binary metadata

| Field | Value |
|---|---|
| Size | `65,536` bytes / `0x10000` |
| Chip type implied by filename | AT29LV512, 64 KiB flash |
| MD5 | `5b71767d855e07ee49049b5afd27b7cd` |
| SHA1 | `ab42eb6aa914cb70dbfa378f5ef5d46fdbad6557` |
| SHA256 | `5afcad8a361404bd7da0cf13b64e343876991442ac045a309f76781bbfc84610` |
| CRC32 | `db8ac5b6` |
| Last non-`0xFF` byte | `0xAAEB` |
| Blank/fill region | `0xAAEC-0xFFFF` |

## Inferred architecture and memory map

Recommended reverse-engineering setup:

- Architecture: Motorola 68000 / M68K
- Endianness: Big-endian
- Load address/base: `0x00000000`
- ROM/vector table: `0x0000-0x03FF`
- Reset/startup code: starts at `0x042C`

Inferred regions:

| Range | Meaning |
|---|---|
| `0x0000-0x03FF` | 68k vector table |
| `0x042C+` | Reset/startup and main dispatcher code |
| `0x4F3C-0x51FF` | ATA command handler tables |
| `0x5242-0x52D9` | PCMCIA CIS tuple block |
| `0x53A6-0x55A5` | ATA Identify Drive template |
| `0x566A` | Copyright string |
| `0x8000-0x805D` | Memory-mapped hardware/ASIC/ATA/PCMCIA registers inferred from code references |
| `0x9000-0x9AFF` | RAM/global state cleared by reset routine |
| `0x9600` | Sector/data buffer used by Identify Drive and transfer operations |
| `0xAAEC-0xFFFF` | Unused `0xFF` fill |

## Startup behavior

The reset routine at `0x042C` masks interrupts, initializes stack pointers, clears RAM/global state from approximately `0x9000` through `0x9AFF`, calls several hardware/setup routines, and then jumps into the main loop/command dispatcher at `0x0542`.

Most exception vectors route to handlers around `0x6C02-0x6E9A`. These handlers save registers, store a vector number in `D6`, and jump to an infinite loop at `0x6C00`. This looks like a deliberate firmware halt/panic path for unhandled exceptions.

## ATA/PCMCIA behavior

The firmware appears to present a PCMCIA ATA/IDE-style flash disk interface. The main dispatcher reads a host command register around `0x8044` and routes commands through handler tables around `0x4F3C-0x51FF`.

Recognized command behavior includes:

- `0x03` - Request Sense
- `0x20/0x21` - Read Sector(s)
- `0x22/0x23` - Read Long Sector
- `0x30/0x31` - Write Sector(s)
- `0x32/0x33` - Write Long Sector
- `0x38` - Write Sector(s) without Erase
- `0x3C` - Write Verify
- `0x40/0x41` - Read Verify
- `0x50` - Format Track
- `0x7X` - Seek
- `0x87` - Translate Sector
- `0x90` - Execute Drive Diagnostic
- `0x91` - Initialize Drive Parameters
- `0xC0` - Erase Sector(s)
- `0xC4` - Read Multiple
- `0xC5` - Write Multiple
- `0xC6` - Set Multiple Mode
- `0xCD` - Write Multiple without Erase
- `0xEC` - Identify Drive
- `0xEF` - Set Features
- `0xF5` - Wear Level

## Recommended next steps

1. Load `AT29LV512@TSOP32.BIN` into Ghidra, IDA, or radare2 as raw M68K big-endian code at base `0x00000000`.
2. Mark the reset vector target `0x042C` as code.
3. Mark vector table targets around `0x6C02-0x6E9A` as code.
4. Define the command handler tables around `0x4F3C-0x51FF` as pointer/jump-table data.
5. Define the PCMCIA CIS tuple block at `0x5242` as data.
6. Define the 512-byte ATA Identify Drive template at `0x53A6` as data.
7. Treat `0x8000-0x805D` as memory-mapped I/O registers rather than normal RAM.
8. Name likely RAM globals in the `0x9000-0x9AFF` range as their purposes become clear.

## Limitations

This is an initial firmware triage, not a full decompilation. The provided disassembly is reachable-code oriented and automated, so some code/data boundaries may require manual correction. Hardware register meanings are inferred from usage patterns and should be validated against the actual SDP3B controller hardware or service documentation where possible.
