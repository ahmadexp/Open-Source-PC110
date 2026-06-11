# PC110 replacement BIOS — buildable C++ skeleton

A freestanding **C++ + asm** system BIOS for the IBM PC110 that compiles to a
flashable F000 image, built on the knowledge recovered by disassembling the
stock IBM 39H4551 BIOS. **Develop and verify under PC110-EMU before flashing.**

## What this is (and isn't)
- **Is:** a correctly-structured, buildable BIOS skeleton — reset stub at the CPU
  reset vector, the *recovered* VL82C420 + PIC/PIT/RTC/KBC init, a staged POST,
  IVT install, and INT-service entry points — that links into a 64 KiB F000 image
  with a valid reset vector.
- **Isn't (yet):** a fully booting BIOS. The gating work is **DRAM controller
  sizing/refresh** init (so POST can run from RAM) and fleshing out the INT
  services. Those are incremental and must be debugged on the emulator first.

## Files
| File | Role |
|------|------|
| `reset.asm` | 16-bit reset stub: `_reset16` at 0xFFF0 → `_entry16` (segments/stack) → `bios_main()` |
| `biosmain.cpp` | freestanding C++ core: `vl82c420::init()` (recovered), PIC/PIT/RTC/KBC, POST, IVT, ISR stubs |
| `bios.ld` | linker script — 64 KiB image, `.reset` forced to offset 0xFFF0 |
| `Makefile` | ia16-elf-gcc + nasm build; `make flash` stitches into a full 256 KiB image |

## Toolchain
- **ia16-elf-gcc** (tkchia/build-ia16) — 16-bit real-mode GCC/G++. Or **Open Watcom**
  (`wcc`/`wasm`) with equivalent freestanding flags.
- **nasm** for the reset stub.
- The proof-of-concept init image in the parent folder (`bios_stub_F000.bin`) was
  hand-assembled and verified to show the binary path; this tree is the real,
  maintainable source for it.

## Build
```
make                 # -> bios_sys.bin (64 KiB F000 system BIOS)
```
`make` prints the reset vector bytes (expect `EA xx xx 00 F0` at offset 0xFFF0).

## Test on the emulator FIRST
1. `make` to get `bios_sys.bin`.
2. `make flash` (with the stock `pc110_bios.bin` present) → `pc110_bios_new.bin`
   (256 KiB; only the F000 system BIOS is replaced, stock VGA BIOS + packed region kept).
3. Drop `pc110_bios_new.bin` in `PC110-EMU/Roms/pc110_bios.bin` and run the headless
   frontend with I/O tracing. Watch the POST checkpoints on port 0x80 (0x01→0xFF) and
   the chipset writes. Iterate on `memory_sizing()` and the services until it boots.

## Flash to hardware (only after the emulator boots it)
- Target part: **Intel E28F002BX** (256 KiB boot-block flash) on the PC110 board.
- Program `pc110_bios_new.bin` with your flash tool. Keep a verified copy of the
  **stock** dump and a recovery path (external programmer / clip) — a bad system
  BIOS image will not POST.

## Bring-up roadmap (in priority order)
1. **DRAM sizing/refresh** via the VL82C420 — decode the `0x4F`/`0x22`/`0x8B` register
   semantics (use the emulator I/O trace of the *stock* BIOS as the reference).
2. **INT 10h** hand-off to the Chips 65535 VGA BIOS (far-call C000:0003) for output.
3. **INT 16h / 13h / 1Ah / 15h(APM)** services.
4. **INT 19h** bootstrap; then Easy-Setup (reuse the LZW-unpacked Setup image).

Each step is testable in isolation under PC110-EMU.
