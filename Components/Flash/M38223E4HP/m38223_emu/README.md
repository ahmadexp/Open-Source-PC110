# M38223 power-sense MCU — disassembly + C++ emulator

Complete MELPS-740 disassembly of the IBM PC110 power-sense microcontroller
firmware (`M38223E4HP@QFP80.BIN`), plus a compilable C++ project that loads and
executes that ROM.

## Files
| File | What |
|------|------|
| `m740.h` / `m740.cpp` | MELPS-740 CPU core: full NMOS 6502 + the 740 extensions used by this firmware (BRA, BBS/BBC, SEB/CLB acc+zp, LDM, CLT/SET with T-flag memory mode, TST, RRF, MUL, DIV, STP, WIT) |
| `m38223.cpp` | M38223 machine: 64 KiB map, ROM at `$C080`, on-chip SFR model (ports, ADC `$34`/`$35`, timers), reset + run loop with trace and a periodic timer interrupt |
| `disasm740.py` | standalone complete 740 disassembler |
| `m38223_full_disasm.asm` | full static disassembly ($C080..$FFFD, ~8.2k lines), incl. reset/ISR regions |
| `CMakeLists.txt` / `Makefile` | build |

## Build & run
```
make                       # -> ./m38223      (or: cmake -S . -B build && cmake --build build)
cp /path/to/M38223E4HP@QFP80.BIN .
make run                   # executes the firmware (3M instructions, with trace)
make disasm                # regenerate m38223_full_disasm.asm
```
Hosted C++ (g++/clang) — builds on any platform; no cross-toolchain needed.

## ROM layout (verified)
- `.org $C080`; banner `"M3822X POWER SENSE MICON FIRMWARE Rev 8 (C) 1995 RIOS SYSTEMS"`.
- Reset = `$E6B1` (vector `$FFFC`); NMI/INT1 = `$DC61`; the 740 multi-source vector
  table is at `$FFDC..$FFFB` (ADC=`$D612`, INT3=`$D190`, INT2=`$D177`, TIMER3=`$E307`,
  TIMER2=`$E366`, TIMER_Y=`$D8D4`, SERIAL_TX=`$E2AA`, SERIAL_RX=`$E2CF`; unused=`$E8FC`).
- Hardware (from disasm + schematic): touch panel on P1/P6 ADC, byte bus to the Bowman
  ASIC on P0 with P1.5 strobe, ADC control at `$34<ADCON>` (bit3 = conversion complete).

## Status (honest)
- **CPU core: complete & correct** for this firmware's instruction set — it resets at the
  right vector and executes millions of instructions of real init/ISR code without
  derailing.
- **Disassembly: complete** — every byte decoded, including the reset/ISR regions a
  trace-only disassembly omits.
- **Full functional fidelity is partial:** reaching the steady-state main service loop and
  producing real touch/power packets needs accurate modeling of the on-chip peripherals
  (timer counters, ADC handshake, serial, port I/O). The SFR model here is deliberately
  minimal (enough to execute). Two caveats from the dump itself: it is 2 bytes short at the
  top, so `$FFFE-$FFFF` (the BRK/IRQ vector) is absent — BRK is therefore treated as a
  trap-skip; and this firmware uses BRK as a software trap, so those paths need the real
  vector to be meaningful.
- To drive it to full behavior, wire the `read`/`write` hooks (or the SFR model) to the
  peripheral models in PC110-EMU, which already loads this firmware for the power MCU.
