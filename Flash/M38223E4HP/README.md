# M38223E4HP@QFP80(1).BIN

**Likely role:** Power-sense microcontroller firmware, Rev 8, RIOS Systems
**Confidence:** High for role; medium for exact vector names

## Files
- Analysis report: `M38223E4HP_power_sense_mcu_analysis_report.txt`
- Strings: `strings/M38223E4HP_power_sense_mcu.strings.txt`
- Hexdumps: `hexdumps/M38223E4HP_power_sense_mcu_selected_hexdumps.txt`
- Supplement: `disassembly/M38223E4HP_power_sense_mcu_reachable_melps740_approx_disasm.txt`
- Supplement: `disassembly/M38223E4HP_power_sense_mcu_linear_melps740_approx_disasm.txt`

## Hashes
- SHA-256: `96c6e37cfa52f30b303db70c2036cbf21e6e1bb638c5eb11343ab161db3c9cc0`
- MD5: `f9a32ab6985b5cc71100b789b98fb10a`

## Quick evidence
- Chip/dump size: Mitsubishi M38223E4HP, 3822 group 8-bit MCU, MELPS 740 family; file size 16,254 bytes / 0x3F7E.
- Likely role: Power-sense microcontroller firmware, Rev 8, RIOS Systems.
- Confidence: High for role; medium for exact vector names.
- SHA-256: `96c6e37cfa52f30b303db70c2036cbf21e6e1bb638c5eb11343ab161db3c9cc0`
- MD5: `f9a32ab6985b5cc71100b789b98fb10a`
- Byte entropy: 5.3790 bits/byte.
- Starts with the banner `M3822X POWER SENSE MICON FIRMWARE Rev 8 (C) 1995 RIOS SYSTEMS CO.,LTD.`.
- The contents decode plausibly as Mitsubishi 740-family / 65C02-like MCU code after the banner.
- If the image tail is aligned to address 0xFFFF, the inferred base is 0xC082 and the tail contains little-endian vector-like words from about 0xFFE0 to 0xFFFF.
- Several vectors point to common stubs or handlers. The exact vector names are tentative because the dump length is slightly under 16 KiB and family-specific vector layout matters.
- Active 4 KiB ranges (heuristic, excludes mostly 0x00/0xFF blocks): 0x00000-0x02FFF
- Longest 0xFF runs: 0x287E len 5854, 0x23A1 len 51, 0x24C8 len 5, 0x51B len 4, 0xE4E len 2
- Longest 0x00 runs: 0x2555 len 60, 0x245B len 37, 0x2481 len 32, 0x24CD len 17, 0x13D7 len 8
