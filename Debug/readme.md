# PC110 CPU debug headers (J9 / J12 / JTAG) — reference + homebrew pod

From the PC110 schematic: two CPU debug headers and a JTAG TAP, all tied to the **80486SX**
(not the VL82C420 chipset), buffered through `74LVT125` with 33 Ω series resistors.

## 1. Pinouts (as drawn)

### J9 — "Debug-10" (2×5, 0.1″)
| Pin | Signal | 486 dir | Pin | Signal | 486 dir |
|----:|--------|:------:|----:|--------|:------:|
| 1 | CPU_HOLD | **in** | 2 | CPU_BRDY# | **in** |
| 3 | CPU_BE1# | out | 4 | CPU_HLDA | out |
| 5 | CPU_BE3# | out | 6 | CPU_BE0# | out |
| 7 | CPU_A20M# | **in** | 8 | CPU_BE2# | out |
| 9 | CPU_SRESET | **in** | 10 | CPU_NMI | **in** |

### J12 — "Debug-6" (1×6, 0.1″)
| Pin | Signal | 486 dir |
|----:|--------|:------:|
| 1 | CPU_BLAST# | out |
| 2 | CPU_FLUSH# | **in** |
| 3 | CPU_KEN# | **in** |
| 4 | CPU_EADS# | **in** |
| 5 | CPU_AHOLD | **in** |
| 6 | CPU_A31 | out (and `CPU_A[2..31]` runs alongside) |

### JTAG TAP (separate)
`TCK`, `TDI`, `TMS`, `TDO` (IEEE 1149.1 boundary scan on the 486). `TRST#` not separately broken out.

*("in" = CPU input → a pod **drives** it; "out" = CPU output → a pod **senses** it.)*

## 2. What the headers are for
This is the **HOLD-method 486 in-circuit-emulator / debug-pod control interface**. The signal
selection is the giveaway:
- **Bus takeover:** `HOLD`/`HLDA` (and `AHOLD`) float the 486 so an emulator can own the local bus —
  the standard way to ICE a *soldered* CPU (the PC110's 486 is BGA; no socket pod possible).
- **Cycle control:** `BRDY#` / `BLAST#` to drive/observe bus-cycle termination.
- **Cache coherency:** `EADS#` + `FLUSH#` + `KEN#` — the tell. A tool that modifies memory behind the
  running CPU uses `EADS#` (snoop-invalidate one line during `AHOLD`) and `FLUSH#` (flush the whole
  on-chip cache) so the 486's cache stays consistent. You only break these out for a debug tool.
- **Control:** `SRESET` (soft restart without power cycle), `NMI`, `A20M#`, byte enables for qualifying.
- **JTAG TAP:** IEEE-1149.1 boundary scan for board test (and pin-level debug via EXTEST/SAMPLE).

It was a development/bring-up interface (RIOS Systems / IBM, 1994-95). No public doc names a specific
commercial emulator model; the *class* is unambiguous from the pinout.

## 3. Honest limitation
J9/J12 expose **control + byte-enables + the address bus** but **not the data bus**. So by themselves
they let you *halt, reset, interrupt, and manage the cache* — and observe cycles — but a full
RAM-override (read/write memory behind the CPU) also needs the **data bus** (tap it at the DRAM/ROM,
or use JTAG boundary-scan EXTEST). Plan the pod accordingly.

## 4. Homebrew modern debug pod

Two practical paths; do JTAG first (cleanest), add the J9/J12 controller for run-control.

### Path A — JTAG boundary scan (recommended, lowest-risk)
- Adapter: **FT2232H** mini-module (or any OpenOCD-supported JTAG dongle).
- Wire `TCK/TMS/TDI/TDO` (+ GND, and tie/strap `TRST#` inactive). 3.3 V LVTTL via the existing
  `74LVT125` buffers — level-safe.
- Software: **OpenOCD** with a generic IEEE-1149.1 tap; once you have the 486's **BSDL** (boundary-scan
  description), you can `SAMPLE` every pin live and `EXTEST`-drive pins for board test — even do slow
  memory peeks by walking the boundary register. This needs *no* high-speed bus mastering.

### Path B — J9/J12 run-control pod (MCU or small FPGA)
A 3.3 V MCU (RP2040 is ideal — fast GPIO + PIO) or a small FPGA drives the CPU-input signals and
samples the CPU-output signals. **Use level shifting**: the 486 side may be 5 V; the board's `74LVT125`
buffers are 5 V-tolerant inputs / 3.3 V outputs, and there are 33 Ω series Rs — still, put proper level
translation between your pod and the header.

Pod ↔ header mapping:
| Pod role | Signals (drive) | Signals (sense) |
|----------|-----------------|-----------------|
| Halt/run | `HOLD`, `AHOLD` | `HLDA`, `BLAST#` |
| Reset/IRQ | `SRESET`, `NMI`, `A20M#` | — |
| Cache | `FLUSH#`, `EADS#`, `KEN#` | — |
| Cycle | `BRDY#` | `BLAST#`, `BE0-3#`, `A31`/`A[2..31]` |

Core operations the pod can implement (see `pc110_debug_pod.c`):
1. **Halt:** drive `HOLD`=1 → wait `HLDA`=1 → CPU bus floated.
2. **Resume:** `HOLD`=0 → wait `HLDA`=0.
3. **Flush cache:** pulse `FLUSH#` low (≥ required clocks).
4. **Snoop-invalidate a line:** `AHOLD`=1 → present the line address on `A[2..31]` → pulse `EADS#` low
   → `AHOLD`=0. (Requires address-bus access.)
5. **Soft reset / restart:** pulse `SRESET`.
6. **Inject NMI:** pulse `NMI`.
7. **Single-cycle stepping** (if you also drive data/addr): use `BRDY#` to terminate each cycle.

### Caveats
- **Voltage/timing:** respect 5 V vs 3.3 V on each net; the 486 bus is fast — for real bus *mastering*
  (driving memory) prefer an FPGA. Run-control (HOLD/FLUSH/SRESET/NMI) is slow and fine on an MCU.
- **Cache:** the 486 internal cache is write-through; after any pod write to memory, `FLUSH#` (or
  per-line `EADS#`) before resuming, or the CPU may read stale cached data.
- **Don't fight the chipset:** the VL82C420 also issues `AHOLD`/`HOLD`/refresh; coordinate or only take
  the bus while the chipset is idle.
- A safe, high-value first milestone: **JTAG `SAMPLE`** to watch the CPU pins live during POST — no
  risk, immediately useful for bring-up.
