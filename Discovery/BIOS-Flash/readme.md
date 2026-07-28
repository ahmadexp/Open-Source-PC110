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
  ground-truth for how to drive U59. Full disassembly decoded 2026-07-27, then **confirmed against the
  original [`vpatch.asm`](vpatch.asm) source** (provided by the project owner) — a byte-for-byte match (§8).
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

## 7. VPP is the shared 12 V rail — and why flashing needs the IBM floppy drive  ✅ **[C/H] (2026-07-27)**

The **`D28_1` rail that Q36 switches onto U59 VPP is the machine's 12 V rail** — traced net-by-net
across the sheets:

- **PCMCIA** (`PCMCIA.kicad_sch`): `D28_1` = the **`12V`** input pins of **U70 (TPS2201)**, the PC-Card
  power-interface switch (pins 7 and 24 both named `12V`). So the flash VPP and the PCMCIA-card VPP are
  the **same 12 V rail**.
- **Power** (`Power.kicad_sch`): `D28_1` reaches **J5 (PSU connector) pin 12** and diode **D50** — i.e.
  the 12 V is supplied from the **PSU board** (steered via D50), not generated on the mainboard.
- **ROM** (`ROM.kicad_sch`): `D28_1` = Q36 emitter → Q36 collector = U59 VPP (§2.1).

**Consequence — a hardware interlock on flashing [C, reported by the project owner]:** to reflash U59
you must **boot from a floppy in an IBM-marked floppy drive**. The `vpatch` *software* contains **no**
floppy/drive check (see the confirmed source in §8) — so the requirement is **hardware**: the 12 V VPP
rail is a **switched supply that is only up under the right power/dock/floppy conditions**, and the IBM
FDD setup is what brings it up (the floppy drive itself needs 12 V). Without it, `port 0x98` bit 3 can
close the Q35/Q36 switch but there is **no 12 V at `D28_1` to pass** → no VPP → the 28F002 cannot
erase/program. Attempting a flash without VPP present risks a **partial/indeterminate erase** (do not).

> **Implication for the §6 tool features and any COMrade-driven flash:** they only actually write when
> run on a machine **booted from the IBM floppy** (VPP present). Run from a hard-disk (`C:`) boot, the
> flash sequence executes but the write cannot take.

### 7.1 Live proof — the software enable alone is NOT enough  ✅ **[RE 2026-07-27]**

Tested directly on the C:-booted unit over COMrade (read-only-then-restore `.COM`s, CRC-verified). Ran
`vpatch`'s **exact** full enable — block2 four-read unlock, `block2[0xFE]&=~1`, `block2[0xFA]=1`, EC/ED
decode-open, **`port 0x98` bit 3**, cache-off — then probed the flash:

1. **Program one padding bit** (`F000:25AC`, a confirmed 20-byte `0xFF` run): `0xFF`→`0xFE`. Result:
   **byte unchanged (`0xFF`)**, status read returned `0xFF` — the flash never entered program mode.
2. **Read-ID (`0x90`)**: the flash returned **`55 AA`** (its video-BIOS array bytes), not Intel's
   manufacturer ID `0x89` — i.e. it stayed in read-array mode and never entered ID mode.

So from a C: boot the flash accepts **no command writes whatsoever**. (The decode *does* open for
**reads** — E000 correctly reads bank 2 — but command writes are inert.)

> **Correction to an earlier claim in this section.** An earlier revision argued read-ID "needs no VPP"
> and therefore isolated the write-enable path from VPP. That is **wrong**: on Intel 28F-series parts,
> when `VPP` is below the lockout threshold **all writes to the command interface are inhibited** —
> including the `0x90` read-ID command write — so the device simply stays in read-array mode and returns
> array data. The observed symptom is therefore **equally consistent with (a) VPP low or (b) WE#/
> `Pluto_BIOS_WR_EN` not asserted**, and does *not* discriminate between them. What the test *does*
> prove is the headline conclusion: **the software enable sequence alone cannot flash from a C: boot.**

**Conclusion:** the flash-write path is gated by a **hardware condition the software cannot satisfy
from a C: boot** — the switched 12 V VPP rail (§7), which the IBM-floppy boot brings up. A community
annotation labels the `block2[0xFE]` write "VPP COMES ALIVE"; `block2[0xFE]` *is* in the write-enable
path, but this test asserted it (and `port 0x98` bit 3) and the flash still rejected every command — so
**it is not sufficient without the floppy/12 V.** VPP does **not** come up from a C: boot by software
alone. *Open avenue (untested): whether merely **powering** an IBM FDD (12 V rail up) without booting
from it also suffices — that would need the FDD physically attached and its motor enabled, then a re-test.*

### 7.2 POST *does* arm a flash write-protect — and it is not the blocker  ✅ **[RE 2026-07-27]**

A community suggestion was that the BIOS deliberately disables flash writes during a normal boot as an
**anti-virus safety mechanism**. That intuition is **correct in substance** — and the code is now located:

**Early POST arms a write-protect bit.** In the chipset-preset routine that runs *before RAM is even
up* (`F000:36AB`, flash `0x336AB`), the BIOS does a read-modify-write of **block2 `0xFE`**:

```
mov al,0xFE -> blk2_read      ; read block2[0xFE]
and ah,0xF7                   ; clear bit 3
or  ah,0x01                   ; <-- SET bit 0
or  ah,0x20                   ; set bit 5
mov al,0xFE -> blk2_write     ; write back
```

Bit 0 is **exactly the bit `vpatch` clears** (`in 0x25 / and al,0xFE / out 0x25`, §3). So the machine
boots with the BIOS-flash write-protect **armed**, and an updater must explicitly disarm it — a textbook
flash-protect latch.

**But it is not a sticky lock.** Tested live on the C:-booted unit (read → clear bit 0 → **read back** →
restore): `block2[0xFE]` reads **`0x3F`** as POST leaves it (bit 0 set ✓), and clearing it yields
**`0x3E`**, which **persists** across a re-read and a second write. So the protect bit is plain
read/write from software; it is **not** write-once-until-reset, and disarming it is *not* what blocks
flashing from a C: boot. (For context, the same read gave `block2[0xFA] = 0xFF`, `block2[0xB8] = 0x00`.)

**And the BIOS does not treat Pluto differently per boot device.** An exhaustive scan of the F000 bank
finds only **four** Pluto write sites — `0x33783` and `0x33796` (the two *blind* boot-preset tables),
`0x33B19` (the strap-latch routine) and `0x33F7D` (video init) — all in **early POST**, and **none** in
the `INT 19h`/bootstrap region or downstream of the boot-order CMOS reads (`0x1D`/`0x1E`). So there is
no "floppy boot vs hard-disk boot" branch that programs Pluto differently.

**Also ruled out:** spinning the floppy motor from DOS (FDC DOR `0x3F2` ← `0x1C`, ~1 s settle) then
retrying the enable + read-ID — **no change**. Either no FDD was attached to the test unit, or the motor
line alone does not bring the 12 V up.

**Net:** the write-protect latch is real (and worth knowing about — any flasher must clear
`block2[0xFE]` bit 0), but the residual blocker is one of the two **hardware** gates, and the tests so
far cannot separate them:

| Candidate gate | Status |
|---|---|
| **12 V VPP rail** (`D28_1` → Q36 → U59 VPP; shared with PCMCIA VPP, from PSU `J5.12`) | not proven present or absent from software |
| **`Pluto_BIOS_WR_EN`** (Pluto **pin 53**) gating WE# through U24 | never asserted anywhere in the BIOS; the controlling Pluto register bit is **unidentified** |

**The two decisive next tests** (both need the bench, not the wire): (1) **measure** U59 VPP (pin 11)
with a meter on a C:-booted machine and again on a floppy-booted one — that settles the 12 V question
outright; (2) if VPP *is* present on a C: boot, then `Pluto_BIOS_WR_EN` is the blocker, and the hunt
moves to finding which Pluto register bit drives pin 53 (candidates: the blind boot-preset writes
Pluto35 `[0x0B] = 0xFE` and Pluto15 `[0x25] = 0xFD`, both of which *clear* a bit).

### 7.3 A charged battery is mandatory — bench units on AC alone are refused  ✅ **[RE 2026-07-28]**

Attempting the 32 MB flash through `PCPATCH` on the live test unit aborted with
**"battery < 20%"** — the power gate firing correctly (its first hardware validation). Reading APM
`INT 15h AH=53h AL=0Ah BX=1` on that machine gives:

```
BH = 0x01  AC line ONLINE
BL = 0x02  battery status = critical
CL = 0x00  battery charge = 0 %
```

i.e. it runs on **AC with no charged battery installed** — the normal state of a bench/serial-console
unit. Because `vpatch` enforces the *same* `CL > 19` test (§8), **the original IBM-kit updater would
refuse on such a machine too.** This is a practical prerequisite worth stating plainly:

> **To flash a PC110 you need *both* A/C **and** a battery charged to ≥ 20 % installed**, *and* (§7) a
> floppy boot from an IBM-marked drive. A bench unit on AC alone cannot be flashed by `vpatch` or by any
> tool that copies its safety gate.

The check is not red tape: the erase+reprogram of the 96 KB main block takes appreciable time with the
BIOS in flux, and a brown-out midway leaves an unbootable machine. The battery is the hold-up supply.
**Do not bypass it** — on a unit with no battery, a momentary AC glitch during the write is exactly the
brick scenario.

**Consequence for testing:** the two independent reasons flashing could not be exercised on the live
unit are now known and separable — (1) it is C:-booted, so the flash command interface is inhibited
(§7.1), and (2) it has no charged battery, so the tool's own gate refuses before it even tries (this
section). Both must be resolved on the bench: charged battery **in**, boot from an IBM-FDD floppy.

## 8. `vpatch` source obtained — RE confirmed byte-for-byte  ✅ **[C] (2026-07-27)**

The project owner provided the original **`VPATCH.ASM`** source (Kevin Moonlight, v1.0 2021-02-19). It
**confirms the reverse-engineering in §3–§4 exactly** — identical CMOS touch, block2 four-read unlock,
`block2[0xFE]&=~1` / `[0xFA]=1`, `out 0xFB`, EC/ED `0x11/0x12=0`, `0x17/0x18=0x55`, `0x0C&=0x8F`,
`out 0xF9`, `CR0|=0x60000000`+`invd`, **`in 0x98 / or 8 / out 0x98`** (VPP-enable), `0x61&=0x10`, then
the copy→patch→erase→byte-program→`0xFF` read-array sequence over the 96 KB main block. No floppy/drive
check exists in the code, corroborating §7 (the floppy requirement is hardware VPP, not software).

## 9. Flash chip bank map & runtime read access  ✅ **[RE 2026-07-27]**

The 28F002BXT (256 KB) is **four 64 KB banks**, identified from the archived chip dump:

| Bank | Chip addr | Contents |
|---|---|---|
| 0 | `0x00000` | **LZW loader + compressed image (start).** Option-ROM header `55 AA 00 EB 45` ("(C) Copyright IBM Corp. 1994"), then a small uncompressed loader, then the head of the compressed stream. |
| 1 | `0x10000` | **compressed image (tail).** Compressed data runs to ~`0x16000`, a short tail to `0x17FFF`, then erased (`0xFF`) `0x18000–0x1FFFF`. |
| 2 | `0x20000` | **video BIOS** ("Chips 65535 … VIDEO … 11/08/95") |
| 3 | `0x30000` | **system BIOS** ("39H4551 (C) COPYRIGHT IBM … 11/08/95"); reset vector at `0x3FFF0` |

Banks 0+1 together are the **~88 KB LZW-compressed lower 128 KB** (a self-relocating loader at
`0x00000`, code-width 9→12 bits, CLEAR/END `0x100`/`0x101`). At boot the F000 POST decompresses it to
`0x143 KB` in RAM — the full **Easy-Setup UI** + the relocated main BIOS body. Both the raw compressed
region and the decompressed output (`region0_decompressed.bin`) are in
[`../../Components/Flash/E28F002BXT`](../../Components/Flash/E28F002BXT).

**From a running machine**, live-probed over COMrade (read-only, `cli`, save/restore): with vpatch's
read-decode open, **the E000 window reads bank 2 and F000 reads bank 3** (upper 128 KB) — confirmed by
signature (`E000 = 55 AA 47…`, `F000 = "39H4551"`). **Banks 0 and 1 are not mapped into any CPU window
at runtime**, and a full 256 KB live dump is **not achievable from a running machine**. This was
pursued exhaustively and settled conclusively (2026-07-27):

- **Netlist:** flash `A16 = Chipset_SA16`, `A17 = BIOS_SA17` — the two bank-select lines are
  **chipset-driven** (not raw CPU address), so the chipset's ROM decode picks the bank.
- **Four live EC/ED register sweeps** — `[0x11]`, `[0x12]`, `[0x17]`, `[0x18]` over `{0,1,2,3}` and the
  packed `{00,55,AA,FF}` bank patterns, decode open: E000 stayed locked to bank 2, F000 to bank 3,
  `C000` to a fixed shadowed ROM, `D000` to `FF`. **Banks 0/1 never appeared at any window.**
- **Chipset shadowing:** at runtime the BIOS is shadowed to DRAM (§13i in the Chipset chapter); only
  banks 2/3 (video + system BIOS) are decoded into accessible windows.
- **Decompressor analysis:** banks 0/1 are the **LZW-compressed lower 128 KB**, read only during the
  **early-boot option-ROM scan** via a CS-relative window — a boot-only decode gone by runtime.
- **UMB scan (C0000–DFFFF):** the bank-0 loader signature `55 AA 00 EB` is **absent everywhere**
  post-boot; only the video-BIOS shadow (`C0000`) and the font-ROM window (`DE000`) are present.

The complete 256 KB is the physical chip read in
[`../../Components/Flash/E28F002BXT`](../../Components/Flash/E28F002BXT); the lower 128 KB is
additionally available **decompressed** as that folder's `region0_decompressed.bin`. Reading banks 0/1
live would require finding *and* re-asserting the boot option-ROM-scan decode on a shadowed running
machine — deep RE plus real risk, for content already fully in hand. (A bus capture during a cold boot
is the only other route.)
