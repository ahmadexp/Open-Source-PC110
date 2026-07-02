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
- The capture tooling is in [`probe_lib.py`](probe_lib.py); see [§9](#9-reproducing-this).

---

## 2. Machine identity at a glance ✅

| Property | Value | Source |
|---|---|---|
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
| `0x3F8–0x3FF` | **COM1 UART** | IER `01`, IIR `C1`, LCR `03`, MCR `0B`, LSR `60`, MSR `BB` | **16550 FIFO enabled**, 8N1, DTR/RTS asserted — this is the live COMrade link |
| `0x2F8`, `0x378`, `0x278` | COM2 / LPT1 / LPT2 | all `0xFF` | Not populated / no external port |
| `0x3C0–0x3DA` | VGA sequencer / CRTC / attribute | mode-3 text values | C&T F65535 in 80×25 text |

### 4.2 PC110-specific ports ✅ (raw), 🟡 (interpretation)

These are the "weird" ports the EZPLAY driver stack and BIOS use — and the live values line up
with the factory `D:\CONFIG.110` driver options (see [§6](#6-pc110-specific-ports-vs-the-factory-config)).

| Port(s) | Role (per `Discovery/`) | Live value |
|---|---|---|
| `0x4F` | SCAMP config latch / index | `0xFF` |
| `0x74 / 0x76` | **VL82C420 SCAMP** config index/data | idx `0x0F`, data `0xFF` (space reads all-`FF`, see §7) |
| `0xEC / 0xED` | **Power MCU** index/data | see §5 |
| `0xEE / 0xEF` | VL82C420 / power glue | `0xFF / 0xFF` |
| `0x1160–0x1163` | **Font-ROM bank window** | bank `0x00`, seg-hi `0xDE`, enable `0x01` |
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
remaining bytes are live sensor/state values. Cross-reference with the U6 firmware disassembly in
[`Discovery/PSU-MB-M38`](../PSU-MB-M38/) and [`Components/U6-M38224M6HP`](../../Components/U6-M38224M6HP/).

### 5.2 PCMCIA host controller — `0x3E0/0x3E1` ✅

Reads as an **Intel 82365SL-compatible dual-socket PCIC**:

| Socket | Chip-ID reg (`0x00`/`0x40`) | Interface-status reg (`0x01`/`0x41`) |
|---|---|---|
| 0 | `0x83` (82365SL-class) | `0x3F` — card present & ready 🟡 |
| 1 | `0x83` | `0x33` 🟡 |

Full 0x00–0x7F register space (both sockets) is in `ports_indexed.json`. The socket-0 status of
`0x3F` (card-detect + BVD + ready bits asserted) is consistent with the boot CF card living in
that slot.

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

---

## 11. What's in `raw/`

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

## 12. Reproducing this

`probe_lib.py` holds the connection + probe helpers (point it at your bridge host/port). It reuses
the COMrade client, so with a PC110 running `COMRADE.EXE` on COM1 you can re-run any of the
sweeps: `io_in`/`io_out` for ports, `mem_read` for memory, `read_file`/`list_dir` for the
filesystem. **Read-only by default** — `io_out`/`mem_write` are unguarded on real hardware and can
crash or reprogram the machine; only index-select writes (immediately followed by a data read,
with the index restored) were used here.

---

*Captured 2026-07-02 from a live unit via [COMrade](https://github.com/ahmadexp) over ser2net.
Unofficial; part of [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110).*
