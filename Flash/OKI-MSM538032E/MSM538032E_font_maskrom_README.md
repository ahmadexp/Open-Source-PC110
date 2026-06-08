# MSM538032E@SOP44.BIN

**Likely role:** IBM PC110 Japanese/System font mask ROM; first 8 KiB is a valid PC option-ROM font window
**Confidence:** Very high

## Files
- Analysis report: `MSM538032E_font_maskrom_analysis_report.txt`
- Strings: `strings/MSM538032E_font_maskrom.strings.txt`
- Hexdumps: `hexdumps/MSM538032E_font_maskrom_selected_hexdumps.txt`
- Supplement: `disassembly/MSM538032E_font_maskrom_font_window_catalog.txt`

## Hashes
- SHA-256: `9829fdb8281c12022dc3b77686044ed1a5213ab526ce4329f2841cd64171784c`
- MD5: `8a160b1ad6dc7a64c086456eaa4e54a6`

## Quick evidence
- Chip/dump size: OKI / LAPIS MSM538032E, 8-Mbit mask ROM, 1 MiB as x8; file size 1,048,576 bytes / 0x100000.
- Likely role: IBM PC110 Japanese/System font mask ROM; first 8 KiB is a valid PC option-ROM font window.
- Confidence: Very high.
- SHA-256: `9829fdb8281c12022dc3b77686044ed1a5213ab526ce4329f2841cd64171784c`
- MD5: `8a160b1ad6dc7a64c086456eaa4e54a6`
- Byte entropy: 5.9395 bits/byte.
- Starts with `55 AA 10 CB`; byte 2 is 0x10, so the option-ROM window length is 16 * 512 = 8192 bytes.
- Checksum over the first 8192 bytes is 0 modulo 256, so the first-window option-ROM header is valid.
- Header/catalog strings include `FONT`, `84G7940`, IBM copyright, `03/23/95`, and System SBCS/DBCS font size descriptors.
- Most of the remaining 1 MiB image is bitmap-like data with repeated glyph patterns, not executable code.
- Active 4 KiB ranges (heuristic, excludes mostly 0x00/0xFF blocks): 0x00000-0x09FFF, 0x0B000-0x55FFF, 0x59000-0xCAFFF, 0xCC000-0xD2FFF, 0xD6000-0xFFFFF
- Longest 0xFF runs: 0x3080 len 256, 0x47080 len 256, 0xD8C80 len 256, 0x31AC len 60, 0x471AC len 60
- Longest 0x00 runs: 0x562C1 len 13764, 0xD2FF0 len 12744, 0xCA97F len 6344, 0x9E1C len 6118, 0x415C0 len 5664
- PC option-ROM signatures found:
