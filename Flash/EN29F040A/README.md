# EN29F040A@TSOP32.BIN

**Likely role:** IBM PC110 modem/fax board flash, RIOS Ver 1.04, with Panasonic MN195001 references
**Confidence:** High for board role; low/medium for CPU architecture

## Files
- Analysis report: `EN29F040A_modem_board_analysis_report.txt`
- Strings: `strings/EN29F040A_modem_board.strings.txt`
- Hexdumps: `hexdumps/EN29F040A_modem_board_selected_hexdumps.txt`
- Supplement: `disassembly/EN29F040A_modem_board_tentative_8051_probe_disasm.txt`

## Hashes
- SHA-256: `add4cb4a3d17f2216ea97e7078f0ce820d25e07a4fadf2103d565f8c95f6ecb4`
- MD5: `a9f38ef86fba9d31285308fd71a6072b`

## Quick evidence
- Chip/dump size: Eon EN29F040A, 4-Mbit / 512 KiB x8 flash; file size 524,288 bytes / 0x80000.
- Likely role: IBM PC110 modem/fax board flash, RIOS Ver 1.04, with Panasonic MN195001 references.
- Confidence: High for board role; low/medium for CPU architecture.
- SHA-256: `add4cb4a3d17f2216ea97e7078f0ce820d25e07a4fadf2103d565f8c95f6ecb4`
- MD5: `a9f38ef86fba9d31285308fd71a6072b`
- Byte entropy: 4.3080 bits/byte.
- Offset 0x00000 is the ASCII banner `RIOS Ver 1.04` followed by erased 0xFF space.
- Sparse but useful embedded strings include `RIOS SYSTEMS Co.,Ltd.`, `PANASONIC MN195001`, many `Ver ...` strings, and `PROGRAM LOADER  Ver.1.00` near the top end.
- No PC 0x55AA option-ROM signature, FAT boot sector, DOS executable marker, or obvious filesystem signature was found.
- The file name and public PC110 dump notes identify it as the modem-board flash. The internal MN195001 string also fits a modem/fax function.
- The CPU architecture of this external flash image is not confirmed. The package includes a tentative 8051-like probe only as a way to inspect selected active regions, not as a claim of architecture.
- Active 4 KiB ranges (heuristic, excludes mostly 0x00/0xFF blocks): 0x20000-0x27FFF, 0x30000-0x66FFF, 0x6E000-0x6EFFF, 0x70000-0x71FFF
- Longest 0xFF runs: 0x14 len 131052, 0x71547 len 59801, 0x27264 len 36252, 0x66B64 len 30940, 0x6F000 len 3824
- Longest 0x00 runs: 0x46E5F len 247, 0x4750B len 201, 0x46077 len 63, 0x46217 len 63, 0x463B7 len 63
