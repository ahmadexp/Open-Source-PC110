# Storage — the ATA/CF disk path, and why big CF cards don't work

What the PC110 does (and conspicuously does *not* do) to talk to its disk, reverse-engineered from the
BIOS flash image plus live captures. The headline: **the BIOS is essentially geometry-blind**, which
explains a lot about card-compatibility folklore. Tags **[C]** confirmed / **[H]** inferred.

**Sources:** `Components/Flash/E28F002BXT/E28F002BXT@TSOP40.BIN` (disassembled),
[`../Live-Dump`](../Live-Dump/) (live `INT 13h`/ATA captures), `PCB/Mainboard/Storage.kicad_sch`.

## 1. The hardware path

Storage is a standard **ATA task file at `0x1F0–0x1F7`** on **IRQ 14** — confirmed live and in the ROM.
The internal CompactFlash / PC-Card slot reaches it through the Ricoh **RF5C396 PCIC** (chip ID `0x83`,
see [`../Pluto`](../Pluto/readme.md)); the card is configured as an ATA/IDE device rather than as a
PCMCIA memory window.

## 2. What the BIOS actually implements  ✅ **[C — RE 2026-07-28]**

Three findings, each from an exhaustive scan of the 256 KB image:

### 2.1 No `INT 13h` extensions — no LBA
There is **no `cmp ah,0x42`** (extended read) and **no `cmp ah,0x48`** (extended get-parameters)
anywhere in the image. Without those the EDD/extension API cannot exist, so **all real-mode disk access
is CHS-only**. (A `cmp ah,0x41` does appear at flash `0x22ECA` / `0x3A378`, but with `0x42`/`0x48` absent
it is not an extensions installation-check.)

### 2.2 The BIOS never issues ATA `IDENTIFY DEVICE`
Checking **every** command write to `0x1F7`, the only commands the BIOS ever sends are:

| Command | Meaning | Example site |
|---|---|---|
| `0x90` | Execute Device Diagnostic | flash `0x3D6CD` — `mov dx,0x1F7 / mov al,0x90 / out dx,al` |
| `0x70` | Seek | flash `0x2C7AB` — `mov dx,0x1F7 / mov al,0x70 / out dx,al` |
| `0x20` | Read Sector(s) | several |

**`0xEC` (IDENTIFY DEVICE) is never issued.** The BIOS therefore **never asks the drive how big it is**
— geometry comes from CMOS/fixed tables, not from the device.

### 2.3 The reported geometry is a tiny legacy stub
`INT 13h AH=08` for drive `0x80` returns **123 cylinders × 2 heads × 32 sectors ≈ 3.85 MB**
([`../Live-Dump`](../Live-Dump/)) — sized for the machine's original small internal flash disk, not for
any modern card.

### 2.4 How a modern OS gets around it
Windows 95 OSR2 does **not** use the BIOS for disk I/O: its protected-mode driver `ESDI_506.PDR`
drives the ATA task file directly and does its own `IDENTIFY` + LBA. That is why a live PC110 happily
shows a ~90 MB FAT volume while the BIOS still reports ~3.85 MB. **[C]**

## 3. So why won't a CF larger than ~4 GB work?

**It is almost certainly not the BIOS.** A BIOS that never reads capacity, and reports a ~3.85 MB
geometry, cannot be the thing that specifically breaks at 4 GB — if the BIOS were the wall, *no* large
card would work at all. The 4 GB boundary is downstream. Ranked candidates **[H]**:

1. **The card itself.** ATA CHS tops out at 16383 × 16 × 63 ≈ **8.4 GB**, and CF cards above ~4 GB very
   commonly drop usable CHS translation or become effectively **LBA-only**. A CHS-only host then cannot
   address or boot them. *Prime suspect.*
2. **Filesystem / partitioning.** FAT16 caps at **2 GB**; FAT32 needs OSR2 and cooperating tools.
3. **Windows 95 driver limits**, rather than the firmware.

### 3.1 Practical workarounds (cheapest first)
- Use a large card but **partition only the first ≤ 2 GB as FAT16**.
- Prefer **industrial CF cards that still advertise CHS translation**.
- Install a **Dynamic Drive Overlay** — the classic 1990s answer to BIOS size limits; it hooks
  `INT 13h` and supplies LBA in software.

### 3.2 The proper fix
Add **`INT 13h` extensions (LBA)**. Two routes, both now open to us:

- **Patch the system BIOS.** We can reflash the 96 KB main block with the boot block intact as recovery
  ([`../BIOS-Flash`](../BIOS-Flash/readme.md)), and the disk code is located.
- **Provide them from an option ROM** — e.g. an "XT-IDE for PC110" on an RP2040 sitting on the internal
  ISA bus ([`Mods/ROADMAP.md`](../../Mods/ROADMAP.md) §8).

## 4. Open item — settle the card question empirically

The claim in §3 that the wall is the *card's* CHS support is **inference, not measurement**. To confirm
it: run ATA `IDENTIFY DEVICE` (`0xEC`) against a >4 GB card and read

- **words 1 / 3 / 6** → the advertised CHS cylinders / heads / sectors, and
- **words 60–61** → the 32-bit LBA total sector count.

If a >4 GB card returns clipped or absent CHS while reporting a valid LBA count, hypothesis 1 is
confirmed and the only real fix is LBA support (§3.2). This is a **read-only** probe and safe to run on
a live machine — the same pattern as [`../../Software/SCAMPRD2`](../../Software/SCAMPRD2/).
