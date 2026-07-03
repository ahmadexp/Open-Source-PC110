# Live Hardware Dump — a running PC110, captured over the wire

*A ground-truth snapshot of an actual, powered-on IBM PalmTop PC110 (type 2431), read live over
a serial bridge on **2026-07-02**. Where the rest of `Discovery/` reconstructs the machine from
schematics, decap and BIOS disassembly, this folder is the machine **telling us about itself**:
raw I/O-port reads, memory dumps, RTC/CMOS contents, and the on-disk software inventory of a
real unit.*

> **Provenance & confidence.** Everything here is tagged:
> - ✅ **Verified** — read directly from the live hardware in this capture.
> - 🟡 **Strongly inferred** — a standard-register decode of a verified raw value.
> - ⚠️ **Assumption** — plausible, not independently confirmed on this unit.
>
> Raw evidence for every claim is in [`raw/`](raw/). Nothing here was hand-edited; the byte
> dumps and JSON are exactly what the machine returned.

---

## 1. How this was captured

The unit runs a small resident serial agent (**COMRADE.EXE**) started from `AUTOEXEC.BAT` on
COM1 at 115200 8N1. A host bridge exposes that link as a byte stream; a Python client speaks the
agent's framed protocol to do `io_in` / `io_out` (port I/O), `mem_read` (physical memory),
`read_file` / `list_dir` (DOS filesystem) and console capture.

```
[macOS host] --TCP--> [ser2net on a NUC] --USB-serial 115200--> [PC110 COM1] --> COMRADE.EXE (TSR)
```

- All chipset reads below are **live port I/O on the running machine** (Windows 95 at a DOS
  prompt). Nothing was flashed or written persistently.
- Indexed register banks were read *index-select → data-read* and the index restored afterward.
- The capture tooling is in [`probe_lib.py`](probe_lib.py); see [§17](#17-reproducing-this).

---

## 2. Machine identity at a glance ✅

| Property | Value | Source |
|---|---|---|
| CPU | **Intel 486SX** — live CPUID vendor `GenuineIntel`, signature **0x0432B → family 4, model 2 (486SX), stepping 11 (0xB)**; no FPU (equipment word bit 1 = 0) | `raw/cpuid.txt`, [§11](#11-cpu--live-cpuid) |
| System BIOS | **IBM FRU 39H4551**, `(C) COPYRIGHT IBM CORPORATION 1981, 1995`, dated **11/08/95** | `raw/bios_F0000.bin` |
| BIOS reset vector | `EA 5B E0 00 F0` → **`JMP F000:E05B`** | `raw/bios_F0000.bin` @ FFF0 |
| Video BIOS | **Chips 65535 VGA 32KB BIOS**, `Copyright (C) 1994 Chips and Technologies` / `CHIPS 65535 Flat Panel VGA` / `IBM VGA Compatible BIOS.` | `raw/vbios_C0000.bin` |
| Operating system | **Windows 95 OSR2** — `ver` → `Windows 95. [Version 4.00.1111]`; `IO.SYS` / `COMMAND.COM` dated **08-24-96** (MS-DOS 7.10 underneath) | `raw/dos_commands.txt` |
| Total RAM | **~20 MB** (640 KB conventional + 19,922,944 B XMS) = **4 MB on-board + 16 MB expansion card** | `mem /c` |
| Base memory | 639 KB reported in the BDA (`0x413` = 0x027F) | `raw/bda.bin` |
| Display state | VGA text mode 3 (80×25), C&T F65535 driving the DSTN panel | CRTC + BDA |
| Boot media | CompactFlash in the internal PCMCIA/CF slot, ~89 MB free on C: | `dir` |

The live system BIOS is the **same revision** as the archived ROM image used by the
[PC110-EMU](https://github.com/ahmadexp/PC110-EMU) project — see [§8](#8-bios--rom-cross-check).

---

## 3. Chip roster confirmed live

Every custom part the reverse-engineering chapters describe was pinged directly:

| Subsystem | Chip (per `Discovery/`) | Live evidence | Confidence |
|---|---|---|---|
| System controller | VLSI **VL82C420** "SCAMP IV" | index/data port pair `0x74/0x76` responds; config space locked (see below) | ✅ present, ⚠️ config not readable |
| Display | Chips & Technologies **F65535** | video-BIOS strings + live CRTC + extension regs `0x3D6/0x3D7` | ✅ |
| Power / battery MCU | Mitsubishi **M382xx** (U6) | register file `0x00–0x1F` at `0xEC/0xED` returns live telemetry | ✅ |
| PCMCIA / CF host | Intel **82365SL-compatible** dual-socket (PCIC) | ID reg = `0x83` on **two** sockets at `0x3E0/0x3E1` | ✅ |
| Kanji font ROM | 1 MB banked flash (IBM FRU 84G7940) | window at `0xDE000` shows sig `55 AA` + `"FONT"`, banking live at `0x1160–0x1163` | ✅ |
| Serial UART | 16550-class (COM1) | FIFO-enabled IIR at `0x3F8` (the COMrade link itself) | ✅ |

---

## 4. Live I/O-port map

Raw values: [`raw/ports_direct.json`](raw/ports_direct.json) (single reads),
[`raw/ports_indexed.json`](raw/ports_indexed.json) (index/data banks).

### 4.1 Standard AT peripherals ✅

| Port(s) | Function | Live value | Decode 🟡 |
|---|---|---|---|
| `0x21` | 8259 **PIC1** interrupt mask | `0xA8` | Enabled: IRQ0 timer, IRQ1 kbd, IRQ2 cascade, **IRQ4 COM1**, IRQ6 FDC. Masked: 3, 5, 7 |
| `0xA1` | 8259 **PIC2** interrupt mask | `0xAC` | Enabled: IRQ8 RTC, IRQ9, IRQ12 (pointing device), IRQ14 (IDE/ATA). Masked: 10, 11, 13, 15 |
| `0x40–0x43` | 8254 **PIT** | `f6 02 3e / ctrl 80` | System timer running |
| `0x60/0x64` | 8042 **KBC** | `0x9C` / status `0x1C` | Keyboard controller alive |
| `0x61` | Port B (PPI) | `0x20` | — |
| `0x00–0x0F`, `0xC0–0xDF`, `0x80–0x8F` | dual 8237 **DMA** + page regs | current regs `0xAA`, page `0x80=70 0x81=FE` | Both DMA controllers present |
| `0x3F8–0x3FF` | **COM1 UART** | IER `01`, IIR `C1`, MCR `0B`, LSR `60`, MSR `BB` | **16550A, FIFO on**; MCR **OUT2=1 gates IRQ4**; MSR CTS/DSR/DCD asserted — this is the live COMrade link |
| `0x1F0–0x1F7` | **ATA/IDE** (internal CF boot storage) | status `0x50` | DRDY set, ready — drive present; **IRQ 14** |
| `0x220–0x22F` | **ESS ES488** SoundBlaster | DSP reset `0xAA`, version `2.01` | SB 2.0-compat audio present (`ADDAUdio 0220`) |
| `0x388` | **YM3812 OPL2** FM | status `0x00` | FM synth responds (discrete Yamaha) |
| `0x2F8`, `0x378`, `0x278` | COM2 / LPT1 / LPT2 | all `0xFF` | Not populated / no external port |
| `0x3C0–0x3DA`, `0x3D6/0x3D7` | VGA std + C&T extension | mode-3 text; `XR00=C1` | **C&T F65535 rev 1** (chipcode 0xC), 720×400 text — see [65535 §6a](../65535/) |

### 4.2 PC110-specific ports ✅ (raw), 🟡 (interpretation)

These are the "weird" ports the EZPLAY driver stack and BIOS use — and the live values line up
with the factory `D:\CONFIG.110` driver options (see [§6](#6-pc110-specific-ports-vs-the-factory-config)).

| Port(s) | Role (per `Discovery/`) | Live value |
|---|---|---|
| `0x4F` | SCAMP config latch / index | `0xFF` |
| `0x74 / 0x76` | **VL82C420 SCAMP** config index/data | reads all-`FF` at rest, but **now unlockable** via the `0x22/0x23` gate → full config dumped live, see [Chipset §13a](../Chipset/) |
| `0xEC / 0xED` | **Power MCU** index/data | see §5 |
| `0xEE / 0xEF` | VL82C420 / power glue | `0xFF / 0xFF` |
| `0x1160–0x1163` | **Font-ROM bank window** | bank `0x00`, seg-hi `0xDE`, enable `0x01` — **8 KB window @`0xDE000`, 7-bit bank = 128×8 KB = 1 MB**; bank 0 = `55AA`/`FONT` header (see [Chipset §13e](../Chipset/)) |
| `0x15E8–0x15EC` | PCMCIA/ATA status window (`RMUDOSAT /PX=15E0-15EF`) | `00 FF FF FF 40` |
| `0x35EA / 0x35EB` | second PCMCIA/ATA window (`/PX=35E0-35EF`) | `08 / FF` |
| `0x3E0 / 0x3E1` | **PCIC** PCMCIA host index/data | see §5 |
| `0x3D6 / 0x3D7` | **C&T F65535** extension registers | live bank captured in `ports_indexed.json` |

---

## 5. The custom silicon, live

### 5.1 Power / battery MCU (U6) — `0xEC/0xED` ✅

Register indices **`0x00–0x1F` return live data**; `0xF0–0xFF` read back `0xFF`. This is the
Mitsubishi power-sense micro's register file exposed to the host — a live snapshot of the
machine's power/thermal/battery state:

```
idx: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
val: 42 d5 0b cc 06 a8 1a ec 38 00 03 00 29 00 00 2a
idx: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
val: 00 00 aa 55 55 6a 55 55 aa 1a 04 08 74 00 00 00
```

The `AA 55 … AA` pattern at `0x12/0x13/0x18` looks like a fixed signature/handshake field; the
remaining bytes are live sensor/state values. A firmware cross-reference of this window (mechanism +
hypothesis-tagged field map) is in [`Discovery/PSU-MB-M38 §6`](../PSU-MB-M38/) — the MCU streams a
counted status block over SIO1 (`sub_e241`) that the gate array bridges to `0xEC/0xED`; the framing
bytes are confirmed, the payload is A-D power telemetry, but a per-index map awaits bench correlation.
See also [`Components/U6-M38224M6HP`](../../Components/U6-M38224M6HP/).

### 5.2 PCMCIA host controller — `0x3E0/0x3E1` ✅

Reads as an **Intel 82365SL-compatible dual-socket PCIC**:

| Socket | Chip-ID reg (`0x00`/`0x40`) | Interface-status reg (`0x01`/`0x41`) |
|---|---|---|
| 0 | `0x83` (82365SL-class) | `0x3F` — card present & ready 🟡 |
| 1 | `0x83` | `0x33` 🟡 |

Full 0x00–0x7F register space (both sockets) is in `ports_indexed.json`. Socket 0 shows a card
present, powered, configured as an **I/O card on IRQ 9** with an I/O window at `0x530` (two windows
enabled, no memory windows); socket 1 is empty/unpowered. Later per-chip decode is in
[Pluto §6c](../Pluto/).

> **Socket 0 = the Windows 95 boot CF (`C:`, ~90 MB)** — a SanDisk-class CompactFlash run as a
> PC-Card **ATA device in I/O mode** (I/O window `0x530`, IRQ 9), via the `SNSCCARD` + Card Services
> stack. It is a **separate** device from the soldered **SanDisk SDP3B-4 (~4 MB) on the standard ATA
> channel `0x1F0`/IRQ 14 = `D:`** (factory PC DOS/EZPLAY). Both are real; see the ATA `IDENTIFY` and
> filesystem analysis in [§14a](#14a-storage-hardware-identity--direct-ata-identify-2026-07).

### 5.3 Font ROM window — `0xDE000` ✅

With bank 0 selected (`0x1160=0`, window seg `0xDE`, enabled), the 8 KB window reads:

```
DE000: 55 AA 10 CB 00 00 00 00 00 00 00 00 00 00 46 4F   U......... ...FO
DE010: 4E 54 20 20 ...                                    NT
```

Signature `55 AA` and the `"FONT"` tag at `+0x0E` confirm the banked 1 MB kanji font flash is
live and addressable exactly as the `$FONT.SYS` mechanism expects. Bank-0 header captured in
`raw/fontrom_window_bank0_DE000.bin`. (The full 1 MB font ROM is already archived in PC110-EMU /
`qemu-personaware`.)

---

## 6. PC110-specific ports vs. the factory config

The clean confirmation that the live ports are what we think they are comes from the machine's
own **original factory `D:\CONFIG.110`** (the pristine PC110 DOS/Personaware boot config), read
off the unit ([`raw/config_files_D.txt`](raw/config_files_D.txt)):

```
DEVICEHIGH=C:\EZPLAY\RMUDOSAT.SYS /MA=DC00-DDFF /IX=5,10 /PX=15E0-15EF,35E0-35EF,102
```

- `/PX=15E0-15EF,35E0-35EF` — the exact I/O windows probed live at `0x15E8` and `0x35EA`. ✅
- `/IX=5,10` — PCMCIA/ATA interrupts on **IRQ5 and IRQ10** (both masked in the live Win95 PIC,
  which uses its own VxD card services). ✅
- `/MA=DC00-DDFF` — the memory window, in the `0xD0000` UMB region that reads mostly `0xFF` at
  runtime (unmapped/idle). ✅

The full EZPLAY stack (`SSDPCIC1`, `IBMDOSCS`, `RMUDOSAT`, `$ICPMDOS`, `PAWATAS`, `AUTODRV`) is
present in `D:\EZPLAY\` and archived in the directory listings.

---

## 7. Notable findings

- **SCAMP config space is locked at runtime.** ⚠️→✅ Reading the VL82C420 configuration registers
  via the `0x74`(index)/`0x76`(data) pair returns **`0xFF` for every index 0x00–0xFF** on the
  running machine. The BIOS uses this pair during POST, but post-boot the space is not
  host-readable (locked, access-gated, or write-mostly). This is a concrete open question for the
  [Chipset chapter](../Chipset/readme.md): the config register values in that doc are "observed"
  from BIOS traces, and cannot be re-read live without an unlock sequence we did not attempt (to
  avoid writing to the system controller of a live unit).
- **E-segment ROM is unmapped at runtime.** ✅ `0xE0000–0xEFFFF` reads **100% `0xFF`**. During
  POST the full 256 KB ROM maps across `C0000–FFFFF` (putting the C&T video BIOS at `E0000`), but
  once Windows 95 is up the video BIOS lives relocated at `C0000` and the E-segment is freed for
  the EMS page frame (`FRAME=E000` in `CONFIG.110`). Emulators that assume a live video BIOS at
  `E0000` are modelling the POST-time map, not the running map.
- **16550 UART with FIFO.** ✅ COM1's IIR reads `0xC1` (FIFO enabled) — the PC110 serial port is
  16550-class, not a plain 16450.
- **Interrupt routing, live.** ✅ IRQ4→COM1, IRQ12→pointing device, IRQ14→internal ATA/CF,
  IRQ8→RTC are all unmasked; the PCMCIA IRQs (5, 10) are masked under Win95.

---

## 8. BIOS / ROM cross-check ✅

The `F000` system-BIOS segment was dumped from the live shadow RAM and compared to the archived
256 KB ROM image (`pc110_bios.bin`, the top 64 KB = the F-segment):

| | |
|---|---|
| Live `F0000` shadow (`raw/bios_F0000.bin`) | 65,536 B, md5 `66b31f56ea777ef58469831ac409f7db` |
| Archived ROM F-segment | md5 `1c2464358ba40b72bed01b5f9e25d282` |
| **Bytes differing** | **749 of 65,536 (1.1%)** |

The 749 differences are POST/runtime scratch the BIOS writes into its own shadow (detected
config, checksums, timer/BDA-linked values). The remaining **98.9% is byte-identical** — the
archived ROM used by PC110-EMU is authenticated against real 2026 hardware. Reset vector, FRU
number (`39H4551`) and date (`11/08/95`) all match.

The runtime video BIOS at `C0000` (`raw/vbios_C0000.bin`, md5
`c468ea3cc07a78739dc5bf51887d1936`) carries the C&T 65535 identity strings.

---

## 9. Software inventory (as-shipped state of this unit)

This particular unit is a **dual-boot** machine — a nice demonstration of what a PC110 can hold:

- **D: — original IBM PC DOS 7 J / Personaware pen environment.** `IBMBIO.COM`, `IBMDOS.COM`,
  Japanese handwriting dictionaries (`IBMSMALL.DCT` 600 KB, `$USRDICT.DCT`), `INKDRV.COM`, DBCS
  fonts (`$SYS1Z16.FNT` / `$SYS1Z24.FNT`), the `EZPLAY` PCMCIA stack, and the factory
  `CONFIG.110`/`AUTOEXEC.110` (COUNTRY=081/932 Japan, KEYB JP, `IBMMKKV` kana-kanji, POWER
  ADV:MAX).
- **C: — Windows 95 OSR2** with Chips & Tech display driver (`SYSTEM.INI` →
  `display.drv=Chips & Tech. Accelerator`), CHECKIT diagnostics, Norton Commander, Turbo C, RAR,
  the SNSCCARD SCSI/CD PCMCIA stack, CF/ATA tooling (`CBATA`/`UNATA`/`ATAENAB`), and a large
  `GAMES\` tree (DOOM/DOOM II/95, Wolfenstein, Prince of Persia 1&2, Lemmings, …).

Full listings: [`raw/listings.json`](raw/listings.json), [`raw/dir_root.txt`](raw/dir_root.txt).
Config files: [`raw/config_files.txt`](raw/config_files.txt) (C:),
[`raw/config_files_D.txt`](raw/config_files_D.txt) (D:).

---

## 10. RTC / CMOS ✅

Full 128-byte CMOS in `ports_indexed.json` under `CMOS_RTC_70_71`. Decoded highlights 🟡:

| Reg | Meaning | Value | Note |
|---|---|---|---|
| `0x0B` | Status B | `0x02` | 24-hour mode, BCD |
| `0x0D` | Status D | `0x80` | RTC power/battery **valid** (VRT set) |
| `0x0E` | Diagnostic | `0x00` | **No POST errors** |
| `0x10` | Floppy type | `0x40` | Drive A = 1.44 MB 3.5" (external FDD config) |
| `0x15–0x16` | Base memory | `0x0280` | 640 KB |
| `0x17–0x18` | Extended memory | `≈0x4C00` | ~19 MB (matches the 16 MB card + 4 MB) |

Extended CMOS (`0x40–0x7F`) holds a populated table (checksum/DAC-like), preserved verbatim in
the JSON.

A **clean UIP-synchronised RTC read** (`raw/safe_probe.json`) returned **`2026-07-02 12:07:16`,
day-of-week 4** — i.e. the coin-cell-backed clock is still keeping accurate time three decades on.

---

# Deeper dive (2026-07-02, session 2)

*A second pass added CPU identification, the live OS structures (DOS version, driver chain,
resident programs), the interrupt-vector map, and BIOS disk geometry. These use `mem_read` and a
handful of guarded real-mode probes run through DEBUG (`debug < script > out`), all read-only.*

## 11. CPU — live CPUID

Executed a guarded CPUID sequence (skips the `cpuid` opcode entirely if the ID flag can't be
toggled, so it's safe on a pre-CPUID part). Raw dump in `raw/cpuid.txt`:

```
d 300: 00 00 20 00  47 65 6E 75 69 6E 65 49 6E 74 65 6C   ".. .GenuineIntel"
d 310: 2B 04 00 00                                        (leaf-1 EAX = 0x0000042B)
```

| Field | Value | Meaning |
|---|---|---|
| ID-flag toggle | `0x00200000` | **CPUID supported** |
| Vendor (leaf 0) | `GenuineIntel` | **Intel** |
| Signature (leaf 1 EAX) | **`0x0432B`** → `0x042B` | family **4**, model **2**, stepping **11 (0xB)** |

Intel 486 CPUID model **2 = 486SX** (model 0/1 = DX, 3 = DX2, 8 = DX4). So the PC110's processor
is confirmed at the silicon level as an **Intel 486SX, stepping B** — consistent with the
equipment-word "no coprocessor" bit. ✅

## 12. Operating system internals ✅

- **DOS version** via INT 21h AH=30h → **7.10** (the MS-DOS layer under Windows 95 OSR2).
- **DOS "List of Lists" (SysVars)** via INT 21h AH=52h → **`00C9:0026`**.

### 12.1 Resident programs (MCB arena chain) — `raw/chains.json`

Walked the memory-control-block chain from the first arena:

| MCB seg | Owner | Size | Program |
|---|---|---|---|
| `0x020D` | DOS (0008) | 24.4 KB | DOS system data (`SD` — buffers, etc.) |
| `0x0836` | DOS (0008) | 50.0 KB | DOS / IO.SYS working set |
| `0x14B7` | 14B8 | 8.4 KB | `COMMAND.COM` |
| `0x172C` | 172D | **92.4 KB** | **`COMRADE`** (the resident serial agent) |
| `0x3089` (Z) | 14B8 | **444.8 KB** | free |

### 12.2 Device-driver chain ✅

Walked from the NUL device header (SysVars+22h). The chain is **exactly the stock Windows 95
IO.SYS built-in set** — no third-party drivers are resident in this DOS-mode boot:

```
NUL  CON  AUX  PRN  CLOCK$  [block: 4 units A–D]  COM1  LPT1  LPT2  LPT3  CONFIG$  COM2  COM3  COM4
```

That's why `MSCDEX` fails at boot ("Device driver not found: PSSC_CD"): the SNSCCARD CD stack in
`C:\CONFIG.SYS` isn't loaded in this real-mode DOS boot. The internal CF is reached through
Windows 95's own PCMCIA/IDE layer, not the DOS EZPLAY drivers.

## 13. Interrupt-vector map ✅ — `raw/safe_probe.json`

Several vectors are hooked by resident TSRs (segments well above the BIOS), confirming active
low-level drivers:

| INT | Vector | Notes |
|---|---|---|
| 08h (timer), 70h (RTC/IRQ8), 74h (IRQ12 pointer), 76h (IRQ14 IDE) | `135C:xxxx` | one TSR owns all four — a low-level power/pointer/timer driver |
| 09h (kbd), 16h (kbd svc), 1Bh (break) | `6A86:xxxx` | a keyboard/hotkey TSR |
| 10h (video) | `C000:3860` | C&T video BIOS |
| 13h (disk) | `0070:03EE` | IO.SYS |
| 21h (DOS) | `0D3E:04A0` | DOS kernel |
| **67h (EMS)** | **`0000:0000`** | **no EMS** — expanded memory not installed |
| 41h / 46h | `F000:…` | BIOS fixed-disk parameter tables |

## 14. BIOS disk geometry ✅

The BDA reports **2 BIOS hard disks** (`0040:0075` = 2). The INT 41h fixed-disk parameter table
for drive 0x80 decodes to **123 cyl × 2 heads × 32 spt ≈ 4 MB** — a small legacy CHS stub. Since
the CF card actually holds a ~90 MB FAT (≈85 MB free), real storage is addressed via **LBA**
through the PCMCIA-ATA + Windows 95 driver stack, bypassing this BIOS CHS geometry. The INT 46h
"drive 1" pointer lands in BIOS code (no valid second table).

### 14a. Storage hardware identity — direct ATA IDENTIFY (2026-07) ✅

The `123×2×32` device is **not just a BIOS stub** — an **ATA `IDENTIFY DEVICE` (0xEC)** issued
straight to the primary channel (`0x1F0–0x1F7`, master) returns a real part:

| Field | Value |
|---|---|
| Model | **`SunDisk SDP3B-4`** (SanDisk — "SunDisk" was its pre-1995 name) |
| Serial | `MZX00050880` |
| Firmware | `Rev 1.20` |
| Geometry | 123 cyl × 2 heads × 32 spt = **7872 sectors ≈ 3.8 MB** |
| LBA / config | `word49 = 0x0200` (LBA), `word0 = 0x848A` (removable/flash class) |

So the machine has **two independent ATA-class flash devices**:
- **`0x1F0` primary ATA = the SanDisk SDP3B-4 (~4 MB) = drive `D:`** — the *factory* IBM PC110
  environment (PC DOS `IBMBIO/IBMDOS`, EZPLAY, `PS2.EXE`, the Japanese dictionary/fonts,
  `CONFIG.110`). This is the soldered internal flash.
- **A larger (~90 MB) CompactFlash in the PCMCIA slot (PCIC socket A) = drive `C:`** — holds
  **Windows 95** (`WINDOWS\`, `IO.SYS`, `PROGRA~1`), games, Turbo C, and the ATA/CF tools
  (`ATAENAB/CBATA/UNATA`, `SNSCCARD`). It is enabled as an ATA device *in I/O mode* on **IRQ 9**
  (see the socket-A dump in [Pluto §6c](../Pluto/)) via the SanDisk `SNSCCARD` + IBM Card Services
  stack in `C:\CONFIG.SYS`.

**Boot/driver architecture (from the live config files):**
- `C:\AUTOEXEC.BAT` runs `ULTRACHG.COM enable`, `MSCDEX` (a PCMCIA **CD-ROM**, `PSSC_CD`), and
  **`COMRADE.EXE /com1 /baud 115200`** — i.e. the serial-console link this whole capture runs over is
  launched from the Win95 (C:) boot.
- `D:\CONFIG.SYS` (factory) loads `RMUDOSAT.SYS /PX=15E0-15EF,35E0-35EF,102` — **the named driver that
  owns the embedded-controller I/O windows** reverse-engineered elsewhere (the `0x15E8` ULTRACHG
  mailbox and the `0x35EA` bank; see [Pluto §6c](../Pluto/)) — plus `EMM386 … FRAME=E000`, the
  `$FONT/$DISP` Japanese subsystem, and the EZPLAY PCIC card services.

*(I deliberately did **not** issue raw ATA commands to the socket-A CF: it is the **live boot drive
`C:`** hosting the running COMRADE agent, so poking its controller behind the OS's card-services
driver risks a command collision. Its identity as the SanDisk-class Win95 CF is taken from the
`SNSCCARD` driver stack and the `C:` contents, not a direct IDENTIFY.)*

**Raw boot sector, read straight off the flash (ATA PIO `READ SECTORS` 0x20, LBA 0):** the SanDisk
`D:` has a valid **MBR** (`FA 33 C0 8E D0 …` bootstrap, `55 AA` at offset 0x1FE) with **one active
(`0x80`) FAT12 partition** (type `0x01`), LBA start 32, size 7776 sectors ≈ 3.8 MB — the factory
boot volume, confirmed at the hardware level independent of DOS.

### 14b. Windows 95's own device enumeration (`C:\DETLOG.TXT`) ✅

The Win95 hardware-detection log independently corroborates the whole reverse-engineered device map
and pins down two resource assignments not seen in the raw port sweep:

| Win95 PnP ID | Device | Resource |
|---|---|---|
| `*ESS4881` | **ESS ES488 AudioDrive** | **IRQ 5** |
| `*PNP0F0E` | Standard PS/2 Port Mouse (= trackpad **U75**) | **IRQ 12** |
| `*PNP0931` | **Chips & Tech. Accelerator** (= F65535) | — |
| `*PNP0500` | **Communications Port (COM2)** | **IRQ 3** |
| `*PNP0400` | Printer Port (LPT1) | — |
| `*PNP0C05` | Advanced Power Management (APM) | — |
| `*PNP0000/0200/0B00/0100/0800` | PIC / DMA / CMOS-RTC / timer / speaker | IRQ 2/–/8/0/– |
| `*PNP0303` | Keyboard | IRQ 1 |
| `*PNPB02F` | Gameport Joystick | — |

So Win95 sees exactly the chipset cores + peripherals decoded here — and adds that the **ES488 audio
is on IRQ 5** and there is a **COM2 on IRQ 3** (a second UART beyond the COM1 console — the
IrDA/modem serial path). This is the OS's-eye view matching the bare-metal probes.

## 15. Battery-charge utility ✅

`ULTRACHG.COM`, run from `AUTOEXEC.BAT`, identifies itself at boot as:

```
PT-110 Operation Charge Enable / Disable Program  Version 1.00
Copyright (C) 1996 HA/BMF.
```

— a small utility that toggles the PC110's battery-charge circuit (note the internal codename
**"PT-110"**).

---

## 16. What's in `raw/`

| File | Contents |
|---|---|
| `ports_direct.json` | Single-read sweep of standard + PC110 ports |
| `ports_indexed.json` | SCAMP, power MCU, PCIC, CMOS/RTC, and full VGA/C&T index banks |
| `bios_F0000.bin` | Live 64 KB system-BIOS shadow (F000 segment) |
| `vbios_C0000.bin` | Live 32 KB C&T 65535 video BIOS (C000 segment) |
| `fontrom_window_bank0_DE000.bin` | 8 KB font-ROM window, bank 0 (signature proof) |
| `bda.bin` / `ivt.bin` | BIOS Data Area (0x400) / interrupt vector table (0x000) |
| `config_files.txt` / `config_files_D.txt` | CONFIG.SYS, AUTOEXEC.BAT, MSDOS.SYS, factory CONFIG.110 … |
| `dir_root.txt` / `listings.json` | Directory inventory of C: and D: and key subdirs |
| `dos_commands.txt` | `ver` and `mem /c` output |
| `cpuid.txt` | Guarded CPUID DEBUG dump (vendor + signature) — §11 |
| `safe_probe.json` | Clean RTC, BDA/equipment decode, IVT map, BIOS FDPT — §10, §11–14 |
| `chains.json` | MCB (resident-program) chain + device-driver chain — §12 |

## 17. Reproducing this

`probe_lib.py` holds the connection + probe helpers (point it at your bridge host/port). It reuses
the COMrade client, so with a PC110 running `COMRADE.EXE` on COM1 you can re-run any of the
sweeps: `io_in`/`io_out` for ports, `mem_read` for memory, `read_file`/`list_dir` for the
filesystem. **Read-only by default** — `io_out`/`mem_write` are unguarded on real hardware and can
crash or reprogram the machine; only index-select writes (immediately followed by a data read,
with the index restored) were used here.

---

*Captured 2026-07-02 from a live unit via [COMrade](https://github.com/ahmadexp) over ser2net.
Unofficial; part of [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110).*
