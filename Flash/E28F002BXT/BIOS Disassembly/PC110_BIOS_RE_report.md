# IBM PC110 system BIOS — reverse-engineering report

**Image:** `E28F002BXT@TSOP40.BIN`, 262,144 B (256 KiB Intel boot-block flash).
SHA-256 `232101c8…32312`, MD5 `6de4281a…b1371` — exact match to the repo dump.
**BIOS:** IBM p/n **39H4551**, RIOS Systems 1993–1994, dated 11/08/95; APM 1.00.27.

## 1. Image layout

| File range | Maps to | Contents |
|------------|---------|----------|
| `0x00000–0x1FFFF` | — | flash **boot block / header** (`55 AA`, IBM `09/19/95` date string) + packed/`FF`-filled region (35 KB `FF` run at 0x17721) |
| `0x20000–0x2FFFF` | C000:0 | **Chips 65535 VGA BIOS** option ROM (`55 AA`, 36,352 B, "Version 2.0.2") |
| `0x30000–0x3FFFF` | **F000:0** | **IBM 39H4551 system BIOS** (64 KiB) |
| `0x3FFF0` | FFFF:0 | reset tail `EA 5B E0 00 F0` = **JMP F000:E05B** |

The system BIOS proper is the 64 KiB at `0x30000` (segment F000). The work below targets it.

## 2. Disassembly

Recursive-descent 16-bit disassembly (capstone) from the reset entry `F000:E05B`
plus standard fixed BIOS entry points, following all direct calls/jumps:

- **4,919 instructions** reached as executable code; **169 call-target subroutines**.
- Output: `pc110_bios_F000.asm` — annotated (port names, BIOS-service `INT`s, string xrefs).
- Note: capstone prints near-branch targets unmasked (e.g. `0xffffdc16`); the real
  16-bit target is the low word (`0xDC16`). Sub-labels use the masked value.
- The remainder of the 64 KiB (data tables, the VGA BIOS, the packed 0x00000 region,
  and code only reached via run-time-installed IVT vectors) is not in the reachable set;
  a full trace needs the emulator's runtime dispatch.

## 3. I/O port / chipset register map (validated against PC110-EMU)

Cross-checked against `PC110-EMU/Sources/PC110Core/pc110_core.c`. Two tiers:

### Standard integrated cores — confirmed (BIOS drives them, emulator models them)
| Ports | Block | Emulator handler | Decap core |
|-------|-------|------------------|------------|
| `0x20/0x21`, `0xA0/0xA1` | 8259 PIC pair | `pic_read/write` | 82C59 |
| `0x40–0x43` | 8254 PIT (timer0 tick, timer2 speaker) | `pit_read/write` | 82C54 |
| `0x60/0x61/0x64` | 8042-class KBC + Port B | `kbc_system_*` | — |
| `0x70/0x71` | MC146818 RTC/CMOS | `rtc_read/write` | MC146818 |
| `0x00–0x0F, 0xC0–0xDF` | 8237 DMA (primary/secondary) | `dma_*` | 82C37 |
| `0x80–0x8F` | DMA page registers | `dma_page_*` | — |
| `0x92` | PS/2 system control A (A20, fast reset) | — | — |

This independently re-confirms the decap finding that the VL82C420 integrates
82C37 + 82C54 + 82C59 + MC146818 cores.

### VL82C420-specific registers — the emulator currently STUBS these
`pc110_core.c` handles these as placeholders ("*until the VL82C420 register map is
known*"). **The BIOS is the reference that exercises them** — values recovered below.

| Port(s) | Emulator name | BIOS usage observed |
|---------|---------------|---------------------|
| `0x4F` | `pc110_config` latch/index | OUT-only index latch; POST writes indices **0x11, 0x66, 0x70, 0x0A, 0x1E, 0xB6, 0x8F, 0x65, 0xBF, 0xFF** |
| `0x22/0x23` | config index/data | unlock/config: OUT 0x22←0x80, OUT 0x23←0x80 |
| `0x74/0x76` | SCAMP/VLSI index/data | OUT 0x74←0x80 then IN 0x76 (probe) |
| `0x8B` | config byte | OUT 0x8B ← 0x6F, 0x0A, 0x80, 0x70, 0x71; IN 0x8B ×12 |
| `0x98` | config | OUT 0x98←0xBF; IN 0x98 |
| `0xF1` | chipset/MCU | OUT 0xF1←0x65 |
| `0x88/0x89/0x8A/0x8C, 0x94` | config bytes | read/written during POST |
| `0x15EA/0x15EB`, `0x35EA/0x35EB` | extended indexed blocks | index/data probes (DX-addressed) |

**This table is the actionable new data for PC110-EMU:** replacing the `vl82c420_write`
placeholder with these index/value semantics will let the emulator track real chipset
state through POST instead of returning `0xFF`.

## 4. BIOS services & strings

- `INT` services invoked from the reachable code: **10h** (video, ×21 — hands to the
  Chips 65535 VGA BIOS), **13h** (disk), **15h** (misc/APM, ×21), **16h** (keyboard),
  **18h/19h/1Bh** (bootstrap/break), **05h** (print-screen), **4Bh**.
- Recovered strings include the IBM build string `39H4551 (C) COPYRIGHT IBM CORPORATION
  1981, 1995 … 11/08/95`, `COPR. IBM 1981, 1995`, `Device I/O Error`, `Device Timeout`.
  The Easy-Setup menu text lives outside the F000 segment (packed 0x00000 region / VGA).

## 5. Deliverables

| File | What |
|------|------|
| `pc110_bios_F000.asm` | annotated recursive-descent disassembly (4,919 insns, 169 subs) |
| `pc110_bios.cpp` | **compilable** C++ reconstruction scaffold — HW I/O layer (port names matched to PC110-EMU), memory map, VL82C420 register interface with the recovered POST sequence, reset/POST staging, ISR entry points |
| `PC110_BIOS_portmap.md` | the port/register map alone, for quick reference |
| `bios_strings_notable.txt` | filtered strings |

## 6. Honest scope & next steps

- The C++ is a **structural reconstruction**, not a line-for-line decompile. Real-mode
  segment arithmetic, self-modifying POST code, packed tables, and the run-time IVT
  dispatch mean a faithful full decompile needs hardware/emulator instrumentation, not
  static analysis alone.
- **Highest-value next step:** run the BIOS under PC110-EMU with I/O tracing and capture
  the *ordered* `0x4F`/`0x22`/`0x8B`/`0x74` index→data transactions with surrounding
  context. That converts the value histograms above into a precise VL82C420 register
  spec — and feeds straight back into both the emulator and the chip documentation.
- Disassembling the embedded **Chips 65535 VGA BIOS** (0x20000) and unpacking the
  **0x00000 region** (Easy-Setup UI / ROM-DOS) would complete the picture.
