## SCAMPRD2 — read-only chipset DRAM-geometry / strap reader

A 130-byte DOS `.COM` that dumps the **VL82C420 (SCAMP IV) EC/ED configuration window**
(indices `0x00`–`0x0F`) plus the **Pluto `0x35EA` register `0x05`** strap byte, and prints them as hex.

This is the tool that produced the live data behind
[`Discovery/RAM-Module`](../../Discovery/RAM-Module/readme.md) §7.4 and
[`Discovery/Chipset`](../../Discovery/Chipset/readme.md) §13k — in particular the **DRAM bank-geometry
registers `eced[0x02]`/`eced[0x03]`**, which is how the PC110's installed memory is identified.

### What it reads

| Register | Meaning |
|---|---|
| `EC/ED 0x02` | DRAM geometry, banks 0 & 2 (low/high nibble) — onboard bank reads `0x0B` = 4 MB |
| `EC/ED 0x03` | DRAM geometry, banks 1 & 3 — **this is the RAM-module identifier** |
| `EC/ED 0x00–0x0F` | the whole low config row, for cross-unit comparison |
| `Pluto 0x35EA[0x05]` | strap byte (bits 3:2 were tested as a RAM-module-ID candidate — falsified, see §7.4) |

**Decoding `0x03`** — one 4-bit geometry code per bank, size = `2^((code & 7) − 1)` MB:

| Module | `eced[0x03]` | Meaning |
|---|---|---|
| none | `0x00` | empty |
| 4 MB | `0x0B` | one 4 MB bank |
| 8 MB | `0x0C` | one 8 MB bank |
| 16 MB | `0xCC` | two 8 MB banks |

(All four confirmed live across three physical units — see
[`Discovery/RAM-Module/eced-dram-regs-live.md`](../../Discovery/RAM-Module/eced-dram-regs-live.md).)

### Safety

**Read-only and safe.** It opens the EC/ED window with the BIOS gate (`out 0xFB`), reads indices
`0x00`–`0x0F` (`out 0xEC` index / `in 0xED` data), closes the gate (`out 0xF9`), then does one ungated
Pluto read — all inside a single `cli`/`sti` window with **no writes to any data port** and no INT calls
in the critical section. Nothing is modified; a power-cycle is not even needed afterwards.

### Usage

```
SCAMPRD2
```
Prints 17 hex bytes: `EC/ED[00..0F]` followed by `Pluto35[05]`. Example from a 12 MB unit
(4 MB onboard + 8 MB module):

```
42 D5 0B 0C 06 A8 1A EC 38 00 03 00 29 00 00 2A F3
         ^^ ^^                                   ^^
         |  eced[03]=0C -> 8 MB module           Pluto35[05]
         eced[02]=0B -> 4 MB onboard
```

### Provenance

Functionally equivalent to the `SCAMPRD2.COM` a project contributor used to capture the 4 MB / 16 MB /
no-module data; this is an independent implementation of the same read sequence, hardware-validated
over COMrade on the 12 MB unit (the run that supplied the 8 MB-module row and completed the table).

### Build

```
nasm -f bin SCAMPRD2.ASM -o SCAMPRD2.COM
```
