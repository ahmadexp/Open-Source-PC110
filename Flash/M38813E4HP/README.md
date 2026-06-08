# M38813E4HP@QFP64.bin

**Likely role:** Keyboard controller firmware Version 1.1, RIOS Systems
**Confidence:** High

## Files
- Analysis report: `M38813E4HP_keyboard_mcu_analysis_report.txt`
- Strings: `strings/M38813E4HP_keyboard_mcu.strings.txt`
- Hexdumps: `hexdumps/M38813E4HP_keyboard_mcu_selected_hexdumps.txt`
- Supplement: `disassembly/M38813E4HP_keyboard_mcu_reachable_melps740_approx_disasm.txt`
- Supplement: `disassembly/M38813E4HP_keyboard_mcu_linear_melps740_approx_disasm.txt`

## Hashes
- SHA-256: `b29761a2fd39abd9c9419ca73b03beb6c41bc52102e2a7429d1f023f82a2a2b8`
- MD5: `835fc971bf700ddcc834ef5ba904aaa2`

## Quick evidence
- Chip/dump size: Mitsubishi M38813E4HP, MELPS 740-family 8-bit MCU with OTPROM; file size 16,255 bytes / 0x3F7F.
- Likely role: Keyboard controller firmware Version 1.1, RIOS Systems.
- Confidence: High.
- SHA-256: `b29761a2fd39abd9c9419ca73b03beb6c41bc52102e2a7429d1f023f82a2a2b8`
- MD5: `835fc971bf700ddcc834ef5ba904aaa2`
- Byte entropy: 5.1603 bits/byte.
- Offset 0x00001 contains `MELPS 740 Series Keyboard Firmware Version 1.1(C) Copyright 1992-1995 RIOS Systems Co.,Ltd.`.
- The contents decode plausibly as Mitsubishi 740-family / 65C02-like MCU code.
- If the image tail is aligned to address 0xFFFF, the inferred base is 0xC081. The probable 6502-style reset vector at 0xFFFC points to 0xC208, and 0xFFFE points to 0xE49E.
- Many vectors point to 0xE62C, which looks like a shared default/unused handler area rather than independently meaningful code.
- Active 4 KiB ranges (heuristic, excludes mostly 0x00/0xFF blocks): 0x00000-0x02FFF
- Longest 0xFF runs: 0x25AE len 6575, 0x2388 len 6, 0xDE len 1, 0x234 len 1, 0x30A len 1
- Longest 0x00 runs: 0x22E9 len 76, 0x235D len 14, 0x2374 len 12, 0x236C len 7, 0x217F len 6
