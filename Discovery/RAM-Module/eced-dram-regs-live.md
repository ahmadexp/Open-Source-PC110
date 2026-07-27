# IBM PC110 — SCAMP IV (VL82C420) DRAM Geometry Register Read-Back

**Date:** 2026-07-27
**Machine:** IBM PC110 palmtop, live over COMrade serial link (fresh boot, MS-DOS)
**Closes:** [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110) — Discovery/RAM-Module §7.4 and Discovery/Chipset §13k

## Summary

The VL82C420 (SCAMP IV) EC/ED config-window DRAM bank-geometry registers are **not write-only** — they read back the values the BIOS cold-boot sizer wrote. On this 20 MB unit, index 0x02 = `0x0B` (onboard 4 MB) and index 0x03 = `0xCC` (16 MB expansion module, mapped as two 8 MB banks). The previously dumped 20 MB-believed unit that read index 0x03 = `0x00` therefore most likely had no module installed at dump time.

## Method

A 142-byte DOS .COM program (`SCAMPRD.COM`) was assembled locally with NASM 3.02, streamed to the PC110, and verified byte-identical on both ends (CRC-32 `E42317B1`) before execution. It performs reads only, using the proven-safe sequence, entirely inside a `cli`/`sti` window:

1. `out 0xFB, al` — open the EC/ED config window (BIOS gate)
2. For each index 0x00–0x0F: `out 0xEC, index`, then `in al, 0xED`
3. `out 0xF9, al` — close the gate

No writes to the 0xED data port; no other ports touched; CPU speed settings untouched.

## Register dump (indices 0x00–0x0F)

| Index | 00 | 01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 0A | 0B | 0C | 0D | 0E | 0F |
|-------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
| Value | 42 | D5 | **0B** | **CC** | 06 | A8 | 1A | EC | 38 | 00 | 03 | 00 | 29 | 00 | 00 | 2A |

## Decode of the bank-geometry registers

Size code per nibble: size = 2^((code & 7) − 1) MB → D = 16 MB, C = 8 MB, B/3 = 4 MB, A = 2 MB, 0 = empty.

- **Index 0x02 = `0x0B`** — low nibble `B` = onboard 4 MB bank; high nibble `0` = empty. Matches the predicted value exactly.
- **Index 0x03 = `0xCC`** — two `C` nibbles = two 8 MB banks = the 16 MB expansion module. Matches the predicted module-present signature exactly; the module is mapped as 2 × 8 MB rather than a single `D` (16 MB) nibble.

## Reported RAM (DOS `MEM`)

| Memory type | Total |
|---|---|
| Conventional | 639 K |
| Extended (XMS) | 19,456 K |
| **Total** | **20,095 K (20 MB)** |

The POST count was not captured (no reboot performed; the machine was left at a clean prompt).

## Expansion module status

**Present, 16 MB** (electrically): 20 MB total minus the 4 MB onboard, corroborated by the `0xCC` geometry nibbles at index 0x03. The physical card was not visually inspected.

## Conclusion

Indices 0x02/0x03 read back real sizer-written values, so these registers are readable, not write-only. Suggested follow-up for a clean confirmation: pull the module and re-run `SCAMPRD.COM` (still at `C:\SCAMPRD.COM` on the unit) — index 0x03 should drop to `0x00`.
