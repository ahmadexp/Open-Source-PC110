# E28F002BXT@TSOP40(1).BIN

**Likely role:** IBM Palm Top PC110 main/system BIOS flash image
**Confidence:** Very high

## Files
- Analysis report: `E28F002BXT_PC110_BIOS_analysis_report.txt`
- Strings: `strings/E28F002BXT_PC110_BIOS.strings.txt`
- Hexdumps: `hexdumps/E28F002BXT_PC110_BIOS_selected_hexdumps.txt`
- Supplement: `disassembly/E28F002BXT_PC110_BIOS_key_regions_i8086_disasm.txt`

## Hashes
- SHA-256: `232101c88466f311bcc32fbc215a4d7569f695ce19f9c07ca67ce2aee5232312`
- MD5: `6de4281a58509438a2773365ba6b1371`

## Quick evidence
- Chip/dump size: Intel E28F002BXT, 2-Mbit / 256 KiB boot-block flash; file size 262,144 bytes / 0x40000.
- Likely role: IBM Palm Top PC110 main/system BIOS flash image.
- Confidence: Very high.
- SHA-256: `232101c88466f311bcc32fbc215a4d7569f695ce19f9c07ca67ce2aee5232312`
- MD5: `6de4281a58509438a2773365ba6b1371`
- Byte entropy: 6.8383 bits/byte.
- Starts with a PC-style 0x55 0xAA ROM signature and an IBM copyright/date string.
- Contains embedded strings: "IBM VGA Compatible BIOS", "Chips 65535 VGA 32KB BIOS", "Version 2.0.2", "APM BIOS 1.00.27", "RIOS", "39H4551", and IBM copyright/date strings.
- Offset 0x3FFF0 contains the real-mode reset tail `EA 5B E0 00 F0`, a far jump to F000:E05B when mapped at the top of the PC BIOS address space.
- Hashes match a public PC110 BIOS dump inventory, which makes the identification very strong.
- Structure is mixed: code, headers, strings, blank fill, and probably compressed/packed or table-heavy blocks. It should not be treated as one linear x86 program.
- Active 4 KiB ranges (heuristic, excludes mostly 0x00/0xFF blocks): 0x00000-0x17FFF, 0x20000-0x3FFFF
- Longest 0xFF runs: 0x17721 len 35038, 0x2FB0C len 20, 0x2FB2C len 20, 0x325AC len 20, 0x27224 len 16
- Longest 0x00 runs: 0x3F0FC len 1861, 0x3EC63 len 756, 0x3E067 len 604, 0x3F85C len 538, 0x3E838 len 335
