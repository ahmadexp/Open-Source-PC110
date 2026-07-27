# BIOS Flash — write-enable, VPP, and the in-system reprogram sequence

How the PC110 reprograms its own BIOS flash (**U59, Intel 28F002BXT**, 256 KB, 12 V-VPP,
top-boot). This is the piece the **stock BIOS does not contain** — the reflash driver ships only in
an external DOS utility, gated by the board's hardware write-enable/VPP logic. This chapter
reconstructs both halves: the **board-level VPP/WE# switch** (from the mainboard netlist) and the
**register/port control + 28F002 command sequence** (decoded from a genuine working updater).

> ⚠️ **Reflashing U59 can permanently brick the machine.** Everything here is documented for
> repair/upgrade RE. Do not write flash without stable power and a recovery path. Tags: **[C]**
> confirmed, **[H]** inferred.

## 1. Sources

- **Board topology:** `PCB/Mainboard/ROM.kicad_sch`, traced net-by-net (deterministic union-find over
  wires + labels, rotation/mirror-correct pin transforms).
- **Control sequence:** `vpatch.exe` — Kevin Moonlight's (yyzkevin) *TFT Video BIOS Update v1.0*
  (2021), a 2082-byte real-mode DOS tool. Being a **working updater**, its port sequence is
  ground-truth for how to drive U59. Full disassembly decoded 2026-07-27.
- **Chipset registers:** cross-ref [`../Chipset/readme.md`](../Chipset/readme.md) §13 (block2 `0x24/0x25`,
  EC/ED `0xEC/0xED` windows) and §13k.
- **Negative result:** the main BIOS (`E28F002BXT@TSOP40.BIN`) contains **no** U59 program/erase
  driver — exhaustively scanned; `Pluto_BIOS_WR_EN` and the VPP-enable are never asserted anywhere in
  the ROM (§5).

## 2. Board-level: the VPP switch and WE# gate (from `ROM.kicad_sch`) **[C]**

U59 is not free to write on its own — two board circuits gate it, plus a power-down pin:

### 2.1 VPP (pin 11) — a logic-switched ~12 V rail
```
 D28_1 rail (~12V) ──E── Q36 (7C, PNP) ──C── U59.VPP (pin 11)
                          │B                    ├─ C246 150nF (decouple)
                    R320 10k                    └─ R327 470k → GND (pulldown)
                          │
                     Q35 (8C) ──C
                       E=GND, B ── R321 100k ── U60 (E3) logic output
```
VPP is **switched, not hardwired**: U60 (a logic gate) → Q35 → Q36 gates the D28_1 rail onto U59.VPP.
So 12 V programming voltage is available in-system, under logic control. Idle, R327 holds VPP low.

### 2.2 WE# (pin 9) — gated by a Pluto write-enable
```
 ISA MEMW# ─┐
            ├─ U24 (E4 gate) ── U59.WE# (pin 9)
 Pluto_BIOS_WR_EN ─(D19 + R112 47k)─┘
```
A flash **write strobe only reaches U59 when Pluto asserts `Pluto_BIOS_WR_EN`** *and* a memory-write
cycle hits the ROM window. `Pluto_BIOS_WR_EN` is a Pluto (U35) output (global label on the ASIC sheet).
This is the hardware write-protect.

### 2.3 RP# (pin 10) — power-down / reset
D20 (triple diode) ties RP# to **PWRGD** and to **VPP**, with R113 470 k pulldown. The flash is held in
power-down until PWRGD, and RP# follows VPP up (RP# must be high to program — satisfied when the VPP
switch is on).

## 3. Register/port control — the enable sequence (from `vpatch.exe`) **[C]**

To make CPU writes actually erase/program U59, the updater runs this exact sequence (all decoded from
vpatch; `[H]` marks the net↔register mapping inference):

| Step | Ports | Effect |
|---|---|---|
| block2 unlock | `in` from DX = `0xFC23,0xF023,0xC023,0x0023` | four-read unlock of the block2 (`0x24/0x25`) config window (see Chipset §13h) |
| WP release | `block2[0xFE] &= ~1` (out 0x24/0x25) | **BIOS write-protect off** — prime candidate for the register behind `Pluto_BIOS_WR_EN` **[H]** |
| — | `block2[0xFA] = 1` | supporting block2 state (same bit BIOS boot-init sets) |
| open EC/ED | `out 0xFB` | enable the EC/ED (`0xEC/0xED`) config window |
| decode open | `EC/ED[0x0C] &= 0x8F` | **route CPU writes in the E000/F000 window through to flash** (clears the shadow/ROM-decode bits 4–6) |
| — | `EC/ED 0x11=0, 0x12=0, 0x17=0x55, 0x18=0x55` | supporting shadow/decode setup |
| close EC/ED | `out 0xF9` | close the EC/ED window |
| caches off | `CR0 |= 0x60000000; invd` | CD+NW, so writes/reads hit the device, not cache |
| **VPP enable** | **`port 0x98 |= 0x08`** | **the VPP-enable — drives U60 → Q35 → Q36 → VPP up** (§2.1) **[H, strongest single candidate]** |
| — | `port 0x61 &= 0x10` | refresh-only (mask speaker/etc.) during the write window |

**Answer to the long-open question:** the flash **VPP-enable is `port 0x98` bit 3**, and the **write
path is opened by `block2[0xFE]` bit 0 (write-protect) + `EC/ED[0x0C] &= 0x8F` (decode)** — none of
which are Pluto `0x15EA/0x35EA` register writes. That is why the strap-window hunt (Chipset §13k,
RAM-Module §7.4) found nothing: the write-enable was never in the Pluto index windows at all.

## 4. The 28F002 program/erase sequence (from `vpatch.exe`) **[C]**

With the enables set, standard Intel 28F002 commands are written into the ROM window and status-polled:

- **Block erase:** write `0x20` then `0x20`/`0xD0`… actually `0x20` (setup) then `0xD0` (confirm) to any
  address in the block; write `0x70` (read-status); poll data bit **0x80** (WSMS) until set.
- **Byte program:** write `0x40` (setup) then the data byte to the target; write `0x70`; poll bit 0x80.
  vpatch programs high→low across the window.
- **Read-array reset:** write `0xFF` to return the array to normal read mode.

**Block layout (28F002BXT, top-boot):** 128 KB main (`0x00000`) · **96 KB main (`0x20000–0x37FFF`)** ·
2× 8 KB param (`0x38000–0x3BFFF`) · 16 KB boot (`0x3C000–0x3FFFF`, holds the reset vector). vpatch (and
the tools in §6) erase+program **only the 96 KB main block** = CPU window `E0000–F7FFF` (E-bank 64 KB +
F-lower 32 KB, one erase block). The boot block is left untouched, so a bad main-block write stays
recoverable via the boot block.

**Running while erasing:** the updater executes from **conventional memory** (a `.COM`), not from the
flash it is erasing, and holds `cli` with **no INT calls** across the whole erase/program window — so
the running code never faults on the in-flux ROM.

**Power gate:** vpatch requires **A/C online and battery ≥ 20 %** (`INT 15h AH=53h AL=0Ah BX=1` →
BH=AC, CL=battery%) before touching the flash — a brown-out mid-erase is a brick.

## 5. Why the stock BIOS has none of this **[C]**

An exhaustive scan of `E28F002BXT@TSOP40.BIN` (raw + LZW-decompressed region-0) for the 28F002 command
protocol found **zero** erase/program sequences targeting U59, and `Pluto_BIOS_WR_EN` / the VPP-enable
are **never asserted** in the ROM. The only flash engine present drives the **PC-Card** linear-flash
socket (window `0xCC00`, commands `0x80/0x41`, VPP via the `0x3E0/0x3E1` PCIC) — a different device.
IBM shipped the U59 reflash path only in external utilities, gated by the §2 hardware.

## 6. Open-source in-system flasher

The §3–§4 recipe is implemented as a **BIOS-update feature** in the PS2 system tools
([`Software/PS2GUI`](../../Software/PS2GUI/), [`Software/PS2TUI`](../../Software/PS2TUI/)) under
*Dumps & ROM → "Flash BIOS"*. It reflashes the 96 KB main block from `C:\PC110ROM.BIN` (the raw
`0x20000–0x37FFF` slice of a 256 KB image), reproducing vpatch's sequence byte-for-byte, with the same
power/confirmation safeguards and boot-block protection. This enables, e.g., flashing the 28 MB
memory-map patch (RAM-Module §7.5) or a TFT video-BIOS — see those chapters for the payloads.

*Net↔register mappings in §3 tagged [H] (`block2[0xFE]`↔`Pluto_BIOS_WR_EN`, `port 0x98 bit3`↔U60
VPP-enable) are inferred from combining the working tool's ports with the netlist; a live bus capture
during a real flash would confirm them directly.*
