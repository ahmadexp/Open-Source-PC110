# IBM PC110 — SCAMP IV DRAM Geometry Registers & Pluto[0x05] Module-Strap Test

**Date:** 2026-07-27
**Machines:** two IBM PC110 palmtops ("unit A", "unit B"), tested live over a serial link, same boot drive (MS-DOS) moved between units, cold boot before every capture
**Addresses:** [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110) — Discovery/RAM-Module §7.4 and Discovery/Chipset §13k

## Summary

1. The VL82C420 (SCAMP IV) EC/ED config-window DRAM bank-geometry registers are **readable, not write-only**: index 0x03 tracks the installed RAM expansion module exactly — `0x00` with no module, `0x0B` with the 4 MB module, `0xCC` with the 16 MB module — and index 0x02 reads `0x0B` (onboard 4 MB) in every configuration. A historical dump that read index 0x03 = `0x00` on a "20 MB-believed" unit is therefore positively explained: that machine had no module installed at dump time.
2. **Negative result:** Pluto indexed register 0x05 reads **`0xF3` in all three configurations** (bits 3:2 = `00` always). The hypothesis that bits 3:2 are RAM-module ID straps is falsified as read here (ungated, post-boot). If module straps exist at this index, they are not visible to a plain post-boot read.

## Method

A 193-byte DOS .COM program (`SCAMPRD2.COM`) was assembled locally with NASM 3.02, streamed to the PC110, and verified byte-identical (CRC-32 `6CF9358E`) before every run, including after the boot drive moved between units. It performs **reads only** — no writes to either data port, no other ports touched:

1. Gated EC/ED dump, inside a `cli`/`sti` window: `out 0xFB, al` (open the BIOS gate), then for each index 0x00–0x0F `out 0xEC, index` / `in al, 0xED`, then `out 0xF9, al` (close the gate).
2. One ungated Pluto read, index/data pair kept atomic under `cli`: `out 0x35EA ← 0x05`, then `in al, 0x35EB`.

Each configuration was captured on a fresh cold boot (power off to swap modules). RAM totals were taken from DOS `MEM` in the same session.

## Results

| Config (total RAM) | Unit | EC/ED idx 0x02 | EC/ED idx 0x03 | Pluto[0x05] | bits 3:2 | MEM total |
|---|---|---|---|---|---|---|
| No module (4 MB) | B | `0B` | `00` | `F3` | `00` | 3,711 K |
| 4 MB module (8 MB) | B | `0B` | `0B` | `F3` | `00` | 7,807 K |
| 16 MB module (20 MB) | A | `0B` | `CC` | `F3` | `00` | 20,095 K |

Full EC/ED dump, identical in every configuration except index 0x03 (shown as `xx`):

```
idx:  00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
val:  42 D5 0B xx 06 A8 1A EC 38 00 03 00 29 00 00 2A
```

Consistency checks: unit A was dumped on two separate cold boots and returned byte-identical values; every EC/ED byte other than index 0x03 is identical across both physical units and all three configurations.

## Decode of the bank-geometry registers

Size code per nibble: size = 2^((code & 7) − 1) MB → `D` = 16 MB, `C` = 8 MB, `B`/`3` = 4 MB, `A` = 2 MB, `0` = empty.

- **Index 0x02 = `0x0B` always** — low nibble `B` = the onboard 4 MB bank; high nibble `0` = empty.
- **Index 0x03 = `0x00` / `0x0B` / `0xCC`** — empty slot; one 4 MB bank; two 8 MB banks. Note the 16 MB module is mapped as **2 × 8 MB banks** (`CC`), not a single `D` (16 MB) nibble, while the 4 MB module maps as a single bank.
- Untested: the 8 MB module (none on hand). By the observed pattern it would be expected to read `0x0C` (one 8 MB bank) or `0xBB` (two 4 MB banks).

## Pluto[0x05] — module-strap hypothesis test

Prediction under test: bits 3:2 of Pluto indexed register 0x05 encode the module ID — `11` with no module, `00` with 16 MB, `01`/`10` for the smaller sizes.

Observed: **`0xF3` (`1111 0011`) in all three configurations, on both units** — bits 3:2 = `00` with no module, with the 4 MB module, and with the 16 MB module. The prediction fails at the first discriminating test (no-module should have read `11`).

Interpretation options consistent with the data: the readable value at this index does not reflect module straps at all; or straps are only exposed under some gate/unlock not applied here; or they are latched at reset and the BIOS reads them before the value seen post-boot is established. What is established: **a plain post-boot read of Pluto[0x05] carries no RAM-module information.**

## Conclusions

- Open-Source-PC110 §7.4 loose end closed: the SCAMP IV DRAM geometry registers read back the sizer's values, and the module is identified by index 0x03 (`00`/`0B`/`CC` for none/4 MB/16 MB).
- The Pluto[0x05] bits-3:2 strap theory should be retired or reformulated for a pre-boot/gated context.
- Remaining gap: an 8 MB module capture, if one turns up.

## Tooling

`SCAMPRD2.COM` (193 bytes, CRC-32 `6CF9358E`, NASM source) remains at `C:\SCAMPRD2.COM` on the shared boot drive; run it at a DOS prompt to reproduce a capture. Its predecessor `SCAMPRD.COM` (EC/ED only, 142 bytes, CRC-32 `E42317B1`) is also present. Both are reads-only by construction and safe on a live system.
