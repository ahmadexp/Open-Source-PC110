# PC110 Flash & ROM Dumps

Readouts and reverse-engineering analysis of the various flash, OTPROM, and mask-ROM chips found in the **IBM Palm Top PC110** and its peripheral boards.

Each subfolder corresponds to one physical chip and contains the raw dump (`.BIN`/`.HEX`), an analysis report (plain text + PDF), extracted strings, selected hexdumps, and — where applicable — disassembly seeded from the chip's reset/vector table. Every chip folder has its own `README.md` with hashes and detailed findings.

## Chips in this collection

| Folder | Chip | Size | Role | Confidence |
|---|---|---|---|---|
| [`E28F002BXT`](E28F002BXT/) | Intel E28F002BXT (2-Mbit boot-block flash) | 256 KiB | Main/system **BIOS** (IBM VGA-compatible, APM, RIOS); x86 real-mode | Very high |
| [`OKI-MSM538032E`](OKI-MSM538032E/) | OKI / LAPIS MSM538032E (8-Mbit mask ROM) | 1 MiB | Japanese/System **font mask ROM**; first 8 KiB is a valid PC option-ROM font window | Very high |
| [`EN29F040A`](EN29F040A/) | Eon EN29F040A (4-Mbit flash) | 512 KiB | **Modem/fax board** flash (RIOS Ver 1.04, Panasonic MN195001) | High (role) |
| [`M38813E4HP`](M38813E4HP/) | Mitsubishi M38813E4HP (MELPS 740 8-bit MCU, OTPROM) | ~16 KiB | **Keyboard controller** firmware v1.1 (RIOS) | High |
| [`M38223E4HP`](M38223E4HP/) | Mitsubishi M38223E4HP (3822-group MELPS 740 MCU) | ~16 KiB | **Power-sense** MCU firmware Rev 8 (RIOS) | High (role) |
| [`AT29LV512`](AT29LV512/) | Atmel AT29LV512 (64-Kbit flash) | 64 KiB | **SanDisk SDP3B PCMCIA ATA FlashDisk** controller firmware (Motorola 68000) | High |

## What's in each folder

A typical chip folder contains:

- The raw dump — `CHIP@PACKAGE.BIN` and/or `.HEX`
- `*_analysis_report.txt` / `.pdf` — analysis notes, identification evidence, and metadata
- `*.strings.txt` — extracted ASCII strings
- `*_selected_hexdumps.txt` — annotated hexdumps of interesting regions
- `*_disasm.txt` — architecture-appropriate disassembly (68000, i8086, MELPS 740, etc.), where attempted
- `README.md` — per-chip summary with SHA-256/MD5 hashes and quick evidence

## CPU architectures involved

The dumps span several instruction sets: **x86 (i8086)** for the system BIOS, **Motorola 68000** for the PCMCIA FlashDisk controller, **Mitsubishi MELPS 740 / 65C02-like** for the keyboard and power-sense MCUs, and a font-bitmap mask ROM that is mostly glyph data rather than code.

## Tools

Useful for inspecting these binaries: [binvis.io](https://binvis.io/) for visual structure, and [binxelview](https://github.com/bbbradsmith/binxelview) for the bitmap/font data.
