# PC110 LBA / EDD BIOS patch (`lba13`)

> # ⚠️ VALIDATION REQUIRED — NEVER FLASHED TO HARDWARE
> This patch has **never been run on a real PC110**, in an emulator, or anywhere else. It is a
> byte-verified static construction against one known BIOS image. Every claim below about ROM
> contents was re-derived from the bytes; **no claim below about runtime behaviour has been
> observed**. Reflashing U59 can brick the machine. Do not flash a unit you cannot recover with an
> external programmer. See [Validation plan](#validation-plan) for the minimum set of tests that
> would have to pass before anyone should trust this.

Adds **INT 13h Extensions (EDD 1.1)** — `AH=41h/42h/43h/48h` — plus optional 1024/255/63 CHS
translation, to the IBM PC110 BIOS, so the machine can address a CF card far larger than the stock
firmware can reach.

---

## 1. Files

| File | What it is |
|---|---|
| `lba13.asm` | NASM source for the patch payload. Assembles to run at `F000:0080`. |
| `make_lba_patch.py` | Reproducible builder. Asserts every byte it depends on, assembles, splices, verifies, emits the images. |
| `lba13.bin`, `lba13.lst` | Build artifacts (payload binary + listing). |
| `PC110_BIOS_lba.BIN` | Full 256 KB patched image — for an **external programmer**. |
| `PC110ROM_lba.BIN` | The 96 KB main-block slice `0x20000..0x37FFF` — the region an in-system flasher erases and programs. |

```
python3 make_lba_patch.py            # needs nasm on PATH
```

Inputs it verifies before doing anything:

```
Components/Flash/E28F002BXT/E28F002BXT@TSOP40.BIN
  262144 bytes, sha1 ffadd0d7c0ec619a3cd34c1d030299e1a9da1c58
```

The builder **fails loudly** if the stock image, the hook bytes, the free-space hole, or any of the
seven code invariants the design depends on differ by a single byte.

---

## 2. What it adds

| INT 13h | Behaviour |
|---|---|
| `AH=41h` | EDD installation check. Requires `BX=55AAh`, returns `BX=AA55h`, `AH=21h` (EDD **1.1**), `CX=0005h` (extended access + DPTE; *not* removable-media functions). |
| `AH=42h` | Extended read. 16-bit DAP, LBA28, PIO, per-sector DRQ handshake. |
| `AH=43h` | Extended write. `AL` bit 0 (write-with-verify) is accepted and ignored; `FLUSH CACHE` (`E7h`) is issued afterwards and an ABRT from it is tolerated. |
| `AH=48h` | Extended get drive parameters, 1Ah or 1Eh buffer, with a 16-byte DPTE (checksummed at init). |
| `AH=02/03/04/08/15h` | Taken over **only in translate mode** (see §4). Otherwise chained to the stock handler untouched. |
| everything else | Chained downstream with all registers and flags exactly as at entry. |

Deliberately **not** implemented: LBA48, ATAPI, the ATA slave (`1F6h = B0h`), DMA, READ/WRITE
MULTIPLE, `AH=44/45/46/47/49/4E`, and the EDD 3.0 42h-byte result buffer. We report EDD **1.1**
because 1.1 is exactly what we deliver; claiming 3.0 would make Win95 and GRUB take code paths we
do not support.

---

## 3. Exact patch sites

Address map: `F000:xxxx` → file `0x30000+xxxx`; `E000:xxxx` → file `0x20000+xxxx`.

### 3.1 Hook — 3 bytes at file `0x352BD` (`F000:52BD`)

```
before   F000:52B8  2A C0        sub al,al
         F000:52BA  E6 8B        out 8Bh,al
         F000:52BC  FB           sti                <- kept
         F000:52BD  CD 19        int 19h            <- replaced
         F000:52BF  F4           hlt                <- replaced
         F000:52C0  E8 3C 97     call E9FFh         <- must not move (EBDA allocator)

after    F000:52BD  E9 C0 AD     jmp near F000:0080
```

`rel16 = 0080h - 52C0h = ADC0h`. This is the end-of-POST bootstrap call — the only `CD 19` byte
pair anywhere in the safe window. A **JMP**, not a CALL: our stub re-emits `int 19h` / `hlt`
itself, so with no card present the observable behaviour is byte-identical to stock.

### 3.2 Payload — 2056 bytes at file `0x30080` (`F000:0080`)

The 7808-byte `0xCC` fill run `0x30080..0x31EFF`. First live byte after it is `0x31F00 = E9 8F 7E`.
**26.3 % used, 5752 bytes spare** — left as `0xCC` on purpose (see §7, APM allocator).

### 3.3 Change summary produced by the builder

```
0x30080..0x304F9  ( 1146 bytes)  F000:0080
0x304FB..0x30887  (  909 bytes)  F000:04FB      (the 1-byte gap is a payload
0x352BD..0x352BF  (    3 bytes)  F000:52BD       byte that happens to be 0xCC)
3 change range(s), 2058 bytes total
```

Everything else is bit-identical to stock. Verified against the produced file, not assumed:

```
banks 0/1  0x00000..0x1FFFF  UNCHANGED   (LZW-compressed)
PARAM1     0x38000..0x39FFF  UNCHANGED
PARAM2     0x3A000..0x3BFFF  UNCHANGED
boot block 0x3C000..0x3FFFF  UNCHANGED   (reset vector — recovery path)
```

All changes are inside `0x20000..0x37FFF`, the range
[`Mods/BIOS-Multi-Patcher/PCPATCH.ASM`](../BIOS-Multi-Patcher/) erases and programs.

**No checksum fixup is applied, and none must be.** Independently recomputed: E000 block `0x69`,
F000 low 32 K `0x9A`, PARAM1 `0xCF`, PARAM2 `0x95`, boot block `0xC7`, whole image `0x2E` — nothing
sums to zero, so nothing is validated.

---

## 4. How it decides what to take over

At the end of POST the installer runs one bounded `IDENTIFY DEVICE`, then picks one of two modes.

**EDD-only mode** — the stock BIOS geometry already reaches the whole card
(`stock_C × stock_H × stock_S ≥ total_sectors`, where the stock values are derived from the EBDA
FDPT exactly the way `F000:D5A0` does it, including its `[+4]` bit-shift field). We add the four
EDD functions and touch nothing else. This is the zero-regression path for the small internal card:
changing reported geometry would invalidate the CHS fields of partitions that already exist.

**Translate mode** — the stock geometry cannot reach the whole card. We additionally take over
`AH=02/03/04/08/15h` and report `C × 255 × 63` with `C ≤ 1024`, publish our own FDPT (shift field =
0) and repoint `INT 41h` (or `INT 46h` for drive `81h`) at it. The stock tables at `EBDA:003D/004D`
are left alone.

It installs **nothing at all** if: there is no EBDA; the reservation arithmetic looks wrong;
`0040:0075` (POST hard-disk count) is 0; the ATA status port reads `00h` or `FFh`; `IDENTIFY` times
out, errors, or reports a non-ATA device; IDENTIFY word 49 bit 9 (LBA support) is clear; or the
capacity is 0. On every one of those paths the reserved kilobyte is given back and the machine
boots exactly like stock.

### RAM

1 KB is reserved **below** the EBDA by decrementing `0040:0013` — the same mechanism the stock BIOS
itself uses at `F000:52C0`. With the stock EBDA at `9FC0h`, our block is at `9F80h:0000`, signed
`'P110'`, and the EBDA is not touched. The handler re-locates it every call from
`[0040:000E] − 40h` with a bounded 8-step downward rescan, so it self-heals if base memory shrinks
under it.

---

## 5. Reach: 8.4 GB CHS vs 128 GiB EDD

Real-mode CHS is out of **bits**, not out of translation cleverness:

```
cylinder  10 bits   CH = 0..7, CL bits 7:6 = 9:8   1024 values
head       8 bits   DH                              256 (255 in practice)
sector     6 bits   CL bits 5:0, 1-based             63
1024 × 255 × 63 × 512 = 8,422,686,720 B = 8.4 GB
```

No translation scheme — bit-shift, LBA-assist, Ontrack — can create more addressable units; it can
only redistribute those `1024×255×63` across the medium. Everything past 8.4 GB needs the packet
interface, `AH=42h/43h` with an LBA in the Disk Address Packet. Our LBA28 path reaches
`2^28 − 1` sectors = **128 GiB − 512 B**, four times the 32 GB target.

Practical consequences for a MS-DOS 6.22 + Win95 OSR2 + FreeDOS multiboot on a 32 GB card:

* Every bootable partition, and every file the boot path touches before a protected-mode disk
  driver loads, must lie **entirely within the first 8.4 GB**. MS-DOS 6.22 `IO.SYS`, the Win95 OSR2
  real-mode `IO.SYS`, and the FreeDOS kernel loader all enter through CHS.
* MS-DOS 6.22 cannot read FAT32 at all → its partition must be FAT16 and ≤ 2 GB.
* Use LBA partition types (`0Ch` FAT32-LBA, `0Eh` FAT16-LBA) so the truncated CHS fields in the MBR
  are ignored by anything that understands them.
* Suggested layout: DOS 6.22 FAT16 2 GB · Win95 OSR2 FAT32 3 GB · FreeDOS FAT32 2 GB (all inside
  the first 8 GB) · remainder one FAT32 data partition reachable from Win95 protected mode and from
  FreeDOS (which uses EDD).
* **Repartition under the patched BIOS.** In translate mode the reported geometry changes, which
  invalidates the CHS fields of any partition table written under the stock BIOS.

### A card larger than 128 GiB

IDENTIFY words 60/61 return the sentinel `0FFFFFFFh` and we accept the clamp, reporting 128 GiB − 1
and silently truncating the tail. Documented limitation, not a silent bug — but do not drop a
256 GB card in and expect the top half to exist.

---

## 6. What this does **NOT** fix

* **A running Windows 95 session.** Once Win95 OSR2 loads `ESDI_506.PDR` it talks to the `1F0h`
  task file directly in protected mode and **never calls INT 13h again**. This patch changes
  nothing for steady-state Win95 disk I/O. It matters for: the boot path, real-mode DOS, MS-DOS
  mode, FreeDOS, boot loaders (GRUB, LILO, Syslinux), and DOS partitioning/imaging tools.
  The one Win95-relevant thing we do supply is the **DPTE** through `AH=48h`, because
  `ESDI_506.PDR` reads it to decide whether it can take the drive over at all — a `FFFFFFFFh` there
  drops Win95 into MS-DOS Compatibility Mode, which on a PC110 is a serious performance and
  battery hit. Whether our DPTE is accepted is **unverified** (§8).
* **The 8.4 GB CHS ceiling.** Unfixable; see §5.
* **The ATA slave.** POST does probe it (`E000:C6AC`), but we only ever drive the master, so a
  second PC-Card ATA device stays on the stock path.
* **Hot-swap across suspend/resume.** The resume path (`0040:0072 = 4321h` → `F000:46CD`) bypasses
  our installer entirely, so the channel is not re-probed. Swapping the CF across a suspend leaves
  stale geometry cached in our block. Stock has the same class of problem; we make the consequences
  worse because we cache the sector count. **Do not swap cards across a suspend.**
* **Throughput.** Our per-sector DRQ handshake is spec-correct but slower than the stock
  single-burst `rep insw` at `F000:D745`. If that ever matters, the fix is SET MULTIPLE (`C6h`) +
  READ/WRITE MULTIPLE (`C4h`/`C5h`) — there are 5752 spare bytes for it — not reverting to the
  unsafe single burst.

---

## 7. Corrections to the original design (verification verdicts honoured)

Four independent byte-level verifications were run against the design before implementation. Three
came back REFUTED or PARTLY-refuted. Each one changed the code:

### V1 — the hook runs *before* the `F000:BAFE` install, not after (REFUTED)

The design assumed our installer would run after PARAM1 installs `[0x4C] = F000:BAFE` at
`F000:8067`, and therefore replicated BAFE's DL remap. Wrong: `8067` lives **inside** the INT 19h
bootstrap (`INT 19h → F000:E6F2 → F000:7DE4 → …`), i.e. downstream of the `int 19h` our own stub
re-emits. So we install first and BAFE may end up layered **on top of** us. Replicating its remap
would have remapped DL a second time and serviced the wrong physical device.

**Fix: we do not remap DL at all**, and it is provably unnecessary:

```
F000:8041   B0 80              mov al,0x80
F000:8043   26 3A 06 EC 00     cmp al,[es:0xEC]
F000:8048   74 21              jz 0x806B          <- skip the BAFE install
```

BAFE is installed **only** when `EBDA:00EC != 80h`, and with `[EC] == 80h` its rotation is the
identity. Therefore: BAFE not installed ⇒ DL is already physical; BAFE installed ⇒ BAFE already
made DL physical. Either way we compare the incoming DL straight against our drive number.

### V2 — `F000:BAFE` does not clamp AH (PARTLY refuted)

BAFE (`0x3BAFE`) is a pure DL-remap shim that passes **every** AH through to the vector saved at
`EBDA:00E8`. The `cmp ah,21h / mov ah,14h` clamp at `F000:BB85` belongs to the separate module
entered at `F000:BB78`. The design's stated *reason* for being outermost was wrong; the
*conclusion* stands, and by stronger evidence: an exhaustive scan of `0x20000..0x3FFFF` finds **no**
`80 FC 42`, `80 FC 43`, `80 FC 48` or `81 FB AA 55` anywhere, and all three INT 13h dispatchers
(`F000:D437`, `F000:96EA`, `F000:BB85`) reject `AH ≥ 26h`. EDD has to be ours.

### V3 — the `0xCC` hole is this BIOS's advertised scratch pool (PARTLY refuted)

`E000:955B` (called from `E000:90C3`) is an APM runtime installer that needs `0x356` bytes and
searches **segment F000** for them: first a `0000h` run in `F000:E000-FFFF`, then a `0000h` run in
`F000:0000-DFFF`, then a **`CCCCh` run** in `F000:0000-DFFF`. Emulating the finder against the real
bytes: search #1 hits `F000:F100` (a `0x741`-byte zero run). Search #3 would return **exactly
`(0x0080, 0x1E80)` — our payload's home**. It also unlocks ROM writes (`E000:F7D0`, chipset index
`0x12 ← FFh`) and `rep movsb` into F000, so F000 is demonstrably writable at runtime.

Search #1 wins in the stock image, and `F000:F100` is in the **boot block**, which no in-system
flasher erases — so the hole is not claimed today. Mitigations applied anyway:

* The payload is emitted **contiguously**, no `ALIGN`, no internal padding. The builder asserts the
  longest internal `0xCC` run is `< 0x356` (it is 1 byte).
* The 5752-byte tail is deliberately left as `0xCC`, so if the allocator ever does fall through it
  lands on the decoy tail, not on live code.
* The builder asserts the `F000:F100` zero run is still ≥ `0x356` bytes and aborts if not.
* **Do not** reflash the boot block with anything that consumes the `F000:F100..F840` zero run.

### V4 — base-memory reservation must be gated on state, not on the signature (PARTLY refuted)

The design made the installer idempotent by checking for its own `'P110'` signature. That is a real
bug. POST rebuilds `0040:0013` from scratch on **every** boot including warm — POST 1C zeroes
`0040:000E` (`F000:5F26`), POST 1D writes `0040:0013` (`F000:6069`), POST 40 recreates the EBDA
(`F000:4C45 → F000:52C0`) — while the RAM contents at `9F80h` survive a Ctrl-Alt-Del. A
signature-based check would therefore take the "already installed" branch on a warm boot, skip the
decrement, and leave live variables (including the chain far pointer) inside DOS-allocatable memory.

**Fix:** gate on the reservation state.

```
d = [0040:000E] − ([0040:0013] << 6)
d == 0     → not reserved, reserve now
d == 0x40  → already reserved (defensive; does not occur in stock)
otherwise  → unexpected layout, refuse to install
```

Two related items from the same verdict, **documented but not fixed** because they are outside the
safe flash window or outside our control:

* `F000:9D5E` / `F000:9D8D` (EBDA grow/relocate) derive the old EBDA base as `[0040:0013] << 6`
  rather than reading `[0040:000E]`, so they depend on an invariant our reservation breaks. It is
  POST-only (single call chain `F000:4F32 → 70B1 → 70BE → 9D0A`, POST 0x64, before our hook) and
  unreachable in stock with a 1 KB EBDA and a single 208-byte request, so it is latent. It lives at
  file `0x39D5E`, in PARAM1, which the flasher must not touch.
* Suspend/resume forces `0040:0013` back to `280h` at `F000:4D26`, dropping both the EBDA's KB and
  ours. Stock loses the EBDA the same way; we double the exposed window to 2 KB.

### Other deviations from the design document

* **`OURDL` is a constant, not a heuristic.** The design picked the drive number by matching the
  EBDA FDPTs against the IDENTIFY default CHS. That heuristic is untestable here and adds a failure
  mode, so the ATA master at `1F0h` is assumed to be BIOS drive `80h` — on a PC110 that is the
  internal PC-Card ATA slot, and the stock `123×2×32` (3.85 MB) stub geometry is exactly a 4 MB
  card in that slot. Change `OURDL_DEFAULT` in `lba13.asm` if hardware proves otherwise.
* **The two-mode split (§4)** is new. The design always translated; always translating would
  needlessly invalidate existing partitions on a small card.
* **INIT switches to a private stack.** At `F000:52BD` the POST stack is `SS=0000 SP=0400`
  (`F000:527D  B8 00 00 / 8E D0 / BC 00 04`), i.e. it grows down into the top of the IVT. INIT
  moves `SS:SP` into its own block for the duration and restores it before `int 19h`.
* **`AH=00h`/`01h` are chained**, not handled. We keep `0040:0041` and `0040:0074` in sync on every
  call we own, so the stock `AH=01h` answer stays correct, and the stock `AH=00h` reset is better
  tested than ours would be.
* **A card-less machine loses no memory.** If we end up not installing, the reserved kilobyte is
  returned (`inc word [0040:0013]`) and the signature wiped, so a PC110 with no card still reports
  639 KB.

### Known unmitigated hazard

`F000:94D9` unconditionally rewrites `[0x4C]` from `EBDA:0093` (`0x394F1`:
`xor ax,ax / mov es,ax / mov di,0x4C / mov eax,[0x93] / mov [es:di],eax`) and is reachable from the
bootstrap walk — a card-removal/uninstall path. If it fires after we install, our vector is
silently discarded with no signature check to recover. It is at file `0x394D9`, inside PARAM1,
outside the safe window, so it cannot be corrected by this patch. Symptom would be: EDD works right
after boot and stops working after a PC-Card event.

---

## 8. Correctness caveats (read before trusting output)

* Everything in §7's *reason* columns is byte-verified. **Nothing about runtime behaviour is.**
* The **DPTE field encoding** is the least-verified part. If `ESDI_506.PDR` rejects it, Win95
  silently falls back to MS-DOS Compatibility Mode — a big performance and battery hit that is easy
  to miss. Check Device Manager → Performance on the first boot.
* `rep insw` on `1F0h` assumes the RF5C396 PCIC window is configured for 16-bit I/O. The stock boot
  block does exactly this at `F000:D752`, so it is proven for the configuration POST leaves behind.
  The presence sniff (`1F7h == FFh` → abort) is the guard. **Do not remove it.**
* Every return path we own uses `retf 2`, never `iret` — an `iret` would reload FLAGS from the
  stack and destroy the CF we just set, turning every error into a silent success. All four stock
  handlers here do the same (`CA 02 00` at `F000:D2DE`, `D331`, `BB56`, `9562`).
* Timeouts are counted off the ISA refresh bit (port `61h` bit 4, ~15.085 µs) exactly as
  `F000:D92B` does, so they do not depend on CPU clock, cache state, or emulation speed.
* If the RAM block cannot be located at handler entry, we chain to `F000:D2D7` — the boot-block
  base INT 13h handler, in the never-erased block. That is a genuine fallback, not a guess, but it
  has never been exercised.

---

## 9. Flashing

> Read [`Discovery/BIOS-Flash`](../../Discovery/BIOS-Flash/readme.md) in full first.

**The safe route is an external programmer.** Pull U59 (or clip it), write
`PC110_BIOS_lba.BIN`, and keep a dump of the stock part. That is the only path with a guaranteed
recovery story.

**In-system, via the flasher:**

1. `PC110ROM_lba.BIN` is the 96 KB main block `0x20000..0x37FFF` — `E000:0000..FFFF` followed by
   `F000:0000..7FFF`, exactly the layout of `PCPATCH`'s staging buffer and the only region it
   erases and programs. The boot block and both parameter blocks are never written, so a bad
   main-block write stays recoverable.
   Note that `PCPATCH.COM` as shipped **stages from the running E000/F000 shadows** and applies its
   own byte deltas; it does not read a `.BIN`. Consuming `PC110ROM_lba.BIN` needs either a new menu
   entry that applies the two deltas in §3, or a variant that loads the file. Do not hand-wave this
   step.
2. **12 V VPP interlock.** VPP for U59 is the machine's switched 12 V rail (`D28_1`, shared with
   the PCMCIA `TPS2201`). It is only up under the right power/dock/floppy conditions, and in
   practice that means **booting from a floppy in an IBM-marked floppy drive**. `Discovery/BIOS-Flash`
   §7.1 proves live that from a C: boot the flash accepts *no* command writes at all — the software
   enable sequence alone cannot do it. Attempting a flash without VPP present risks a partial or
   indeterminate erase.
3. **Battery gate.** `PCPATCH` checks AC present / battery ≥ 20 % via `INT 15h/530A` before it will
   write. Do not defeat that check. A power loss mid-erase is the classic way to brick this part.
4. Reboot to take effect.

---

## Validation plan

Nothing below has been done. In rough order of increasing risk:

1. **Static** — disassemble `PC110_BIOS_lba.BIN` at `F000:0080` and `F000:52BD` with `ndisasm` and
   read it. (The builder does the byte-range safety proof; it cannot review the logic.)
2. **Emulator** — run the patched image under [`PC110-EMU`](../../../PC110-EMU) with an ATA-backed
   disk image. Check: it still reaches `int 19h`; `AH=41h` with `BX=55AAh` returns `AA55h/21h/0005h`;
   `AH=48h` returns sane C/H/S and total sectors; `AH=42h` of LBA 0 returns the MBR.
3. **Read-only on hardware, without flashing** — the interesting parts of the logic (`IDENTIFY`,
   geometry maths, LBA task-file program) can be lifted into a DOS `.COM` and run on a real PC110
   over COMrade against a real 32 GB card, before anything is written to flash. **Do this.**
4. **`0040:0013` after ten warm boots** — must stay at 638 (or 639 with no card). This is the
   V4 regression test.
5. **DL remap** — set a non-default boot device in Easy-Setup so `EBDA:00EC != 80h`, forcing BAFE
   to layer on top of us, and confirm `AH=42h` still hits the right physical device.
6. **`AH=08h` routing** — with DEBUG, confirm `AH=08h` for `DL=80h` (and `81h`) goes through our
   handler in every boot configuration, not the stock `F000:D589`.
7. Only then flash, from an IBM floppy, on a unit with an external programmer standing by.
