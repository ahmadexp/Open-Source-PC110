# Pluto (U35) probe plan — mapping the peripheral-I/O register set

**Goal:** build **Pluto's I/O register map** — which ports it decodes, what each read/write does, and
which subsystem each register drives. This is the main open item in [Pluto §7](readme.md) ("the register
map … is not derivable from the schematic alone — needs bus-trace capture or BIOS disassembly").

**Why Pluto is the tractable target:** unlike the proprietary VL82C420↔Bowman **ML bus** (which took
§11a–i to partially decode and whose data payload is unreachable at the QFP), **Pluto speaks a plain
ISA-style local bus** — `SA[0:15]` address, `SD[0:7]` data, `IOR#`/`IOW#`/`AEN` — all on an accessible
~96-pin QFP with the pinout already mapped ([Pluto §3](readme.md)). Every cycle is directly decodable.

Rig: same as the ML-bus work — Saleae Logic Pro 16 on the NUC (`user@100.66.96.126` over Tailscale,
`user@192.168.10.183` on-LAN), driven by COMrade (`:2010`) for stimulus and the Lantronix KVM for the
console. See [[saleae-pc110-mlbus]] / [Chipset/ML-bus-payload-probe.md](../Chipset/ML-bus-payload-probe.md)
for rig mechanics (solder taps at 0.5 mm pitch; **clean the NUC `/tmp` between raw exports — it's a 7.4 G
tmpfs that silently fills and yields 0-byte CSVs**).

---

## ⚠️ Safety — read this first
Pluto controls **BIOS write-enable, power-management rails, and the LCD**. A careless `io_out` to the
wrong Pluto register could **enable BIOS-flash writes** or disturb power. Therefore:

- **Map with `io_in` (reads) only.** Reads are side-effect-free enough for decode.
- For **write** behaviour, **observe BIOS/driver-driven writes** (capture while the machine does its own
  thing) rather than driving blind `io_out`.
- COMrade's `io_out` is **unguarded** on real hardware. Never drive writes to unknown Pluto ports.
- Standing rule: **never** issue CPU-speed changes over COMrade; restore any port you do touch.

---

## Method
1. **Bus-trace Pluto's ISA interface** while driving known `io_in` over COMrade → decode `SA`→port,
   `IOR#`/`IOW#`→direction, `SD`→data. Reveals **which ports Pluto owns and their register values**.
2. **Function-map** by probing a Pluto **subsystem output** pin (KB_CCS, speaker KB_SPKUP/DN, LCD_IO,
   IRDA_O, RS-232 enable) alongside the port access → ties a register to what it *does*.
3. **KBC path:** probe `KB_CCS` (pin 60) + `SD` while driving `0x60/0x64` → maps the 8042-style keyboard
   interface and the µPD/M38xx MCU behind it (ties into the KBC-firmware disasm, Pluto §7).
4. **Complement with BIOS/driver disassembly** for the exact programming sequences (as was done for the
   inking pad's `INKDRV.COM`).

---

## Pass 1 — which ports does Pluto decode? (16 Saleae channels)
Full I/O port address (0–0x3FF) + direction + 3 data bits.

| CH | Signal | Pluto pin | | CH | Signal | Pluto pin |
|---:|--------|----------:|---|---:|--------|----------:|
| 0 | IOR# | 86 | | 8 | SA5 | 15 |
| 1 | IOW# | 89 | | 9 | SA6 | 16 |
| 2 | AEN | 6  | | 10 | SA7 | 17 |
| 3 | SA0 | 8  | | 11 | SA8 | 18 |
| 4 | SA1 | 9  | | 12 | SA9 | 19 |
| 5 | SA2 | 10 | | 13 | SD0 | 33 |
| 6 | SA3 | 11 | | 14 | SD1 | 34 |
| 7 | SA4 | 12 | | 15 | SD2 | 35 |

*Note: address pins skip 13/14 (GND/VCC); data pins skip 37/38 (GND/VCC).* `AEN` low qualifies a real CPU
I/O cycle (vs DMA). Trigger on `IOR#` (or `IOW#`) falling; or timed-capture while sweeping `io_in`.

**Run:** drive a read-only `io_in` sweep across the I/O space over COMrade; bucket the cycles by `SA`
(port) to see which ports Pluto actually responds on, with their low data bits.

## Pass 2 — full register data on the ports of interest
Keep `IOR#`(86)/`IOW#`(89)/`AEN`(6); move CH3–CH10 to the **full data byte** `SD0–SD7`
(33,34,35,36,39,40,41,42); keep a few `SA` on CH11–15 to identify the port. Re-drive `io_in` to the
Pluto-owned ports found in Pass 1 → read the full register values.

## Pass 3 — function mapping (register → subsystem)
Keep the ISA framing; add a **subsystem output** pin and toggle it via its port:

| Subsystem | Pluto pin(s) |
|---|---|
| Keyboard-controller chip select | KB_CCS 60, KB_CNTR# 61, KB_RESET# 66 |
| Speaker | KB_SPKUP 44, KB_SPKDN 43 |
| Floppy | FDD_IO1–4 68–71, Pluto_IOW 58 |
| LCD / power | LCD_IO 93, PSU_IO 83, PWRGD 67, CPU_STPCLK# 62 |
| IrDA | IRDA_O 81 |
| Modem codec | MN195_VSDA 75 (likely; schematic typo `NM192`) |
| BIOS bank | BIOS_SA17 54 |
| Bowman↔Pluto link | Bowman_IO1 51 / Bowman_IO2 52 / Pluto_IO 129 (on Bowman) |

---

## Known Pluto facts to anchor against ([Pluto readme](readme.md))
- SMC-fabbed peripheral controller (~96-pin QFP), marked `…PLUTO … JAPAN` (visible in the bench photo,
  [Chipset/images](../Chipset/images/ml-bus-probe-bench.jpg)).
- Presents an **8042-style keyboard controller** to the CPU (`KB_CCS`/`KB_CNTR#`/`SD0–7`).
- Fans the ISA bus out to: keyboard, floppy, PCMCIA/CF card-detect, IrDA, RS-232, LCD/PM rails, dock
  detect, modem, external BIOS flash. Uses external 74-series flip-flops (`FF_*`) for some lines.
- Already-RE'd port hints elsewhere in the project: inking/signature pad at I/O base `0x15E0`
  (INKDRV.COM); trackpad µPD17137A as std PS/2 on the KBC path.

## Open questions this campaign should close (Pluto §7)
- The `SD`/`SA` register map (**this plan's primary target**).
- Exact names for placeholder pins 50, 55–57, 74.
- The `FF_*` external flip-flop network behaviour.
- The FDD signal split between Pluto and Bowman (`FDD_Bowman`).
- Host-interface port ↔ `KB_CCS`/`KB_CNTR#`/`SD` mapping; re-disassemble the KBC firmware with a
  **740-aware** disassembler.
- Whether `Pluto` is laser-marked on U35 (as `RIOS BOWMAN` turned out to be on U21).

## Force-multiplier — `BUS_STIM` (BUILT & DEPLOYED 2026-07-16)
COMrade now has the **bus-stimulus burst op** — `cm.bus_stim(kind, target, width, count)` /
MCP `bus_stim` (kind `'io'`=io_in on a port, `'mem'`=mem_read at a linear addr) — which loops the READ
K times in a tight DOS-side CPU loop from one serial round-trip. Measured ~**0.34 M io/s** and
~**0.79 M mem/s**; a burst took its target from **0.003 %→19.3 %** of bus ADS# cycles (~7,800×), so driven
stimulus **dominates the bus**. **Use it for the Pluto sweep:** `bus_stim('io', <port>, 1, ~5_000_000)`
to a candidate port while capturing → that port's cycles dominate, making `IOR#`/`SA`/`SD` decode trivial
even against background. (Reads only — safe. New agent version `COMRADE/…20260717…`; source committed in
the COMrade repo, `COMRADE.EXE` on `C:\`, old build in `C:\COMRADE.BAK`.)

---

## Pass 1 results — runtime I/O activity map  **[MEASURED 2026-07-17]**
Wiring validated (`io_in(0x1EB)` burst → `SA=0x1EB` on 100% of IOR# cycles; SA/IOR#/AEN/burst all correct;
an SA5/pin-15 reseat was needed). AEN = 0 on all cycles (pure CPU I/O, no DMA). Passive capture (50 ms)
of natural traffic — the running system's I/O working set, all **index/data register pairs**:

| Port (SA0–9, may alias mod 0x400) | R/W | count | note |
|---|---|---|---|
| `0x074` w / `0x076` r | idx/data | 864/864 | **VL82C420 SCAMP config pair** (Chipset §13) — actively driven |
| `0x070` w | RTC index | 433 | RTC/CMOS |
| `0x024` w / `0x023`,`0x025` r/w | idx/data | 3028 / ~1.3–1.7k | second indexed config block at `0x22–0x25` |
| `0x1EA`,`0x1EB`,`0x1EE` r/w | idx/data | ~0.4–1.7k | `0x1Ex` block — possibly the inking pad (`0x15E0` base, aliased) or a real `0x1Ex` reg; needs SA10+ to de-alias |
| `0x020` w | PIC EOI | 2 | 8259 |

**Limits hit:** only SD0–2 wired (can't read register *contents*); SA0–9 aliases mod `0x400`.

**Next wiring (Pass 2 — full data byte):** CH0 IOR#(86), CH1 IOW#(89), CH2 AEN(6), CH3–10 = **SD0–SD7**
(33,34,35,36,39,40,41,42), CH11–15 = **SA0–SA4** (8,9,10,11,12). Then burst-drive a target port
(`0x074`/`0x024`/`0x1EA`) and read its full register value; SA0–4 gives the offset. Later: SA10–13 to
de-alias, KB_CCS(60) for Pluto attribution.

*Plan written 2026-07-16; Pass 1 run 2026-07-17.*

---

## Pass 2 results — full 8-bit data byte  **[MEASURED 2026-07-17]**
Rewired to **IOR#(86) / IOW#(89) / AEN(6) / SD0–SD7(33,34,35,36,39,40,41,42) / SA0–SA4(8,9,10,11,12)**.
Wiring re-validated end-to-end: `bus_stim('io', 0x1EB)` → capture shows `SA0-4 = 0x0B` (= `0x1EB & 0x1F`)
and full byte `SD = 0xFF` on 100 % of 6894 IOR# cycles. Swept every Pass-1 data port with a dominant
burst (each burst's `SA0-4` matched its port exactly — address wiring correct across the range).

> ⚠️ **Rig gotcha found:** a `BUS_STIM` burst runs a tight loop **on the DOS side** for its full count
> (~88 s at 30 M). Killing the *Mac-side* `comrade_bg.py` does **not** stop the DOS loop, so back-to-back
> captures get contaminated by the prior port. Fix: size the burst to ~4 M (~12 s), start capture ~3 s in,
> then **block until the burst process returns** (DOS loop done) before the next port.

**Idle single-port reads (burst each port, read its byte):** every data port returns `0xFF` at idle
**except `0x074` = `0x0F`** — i.e. `0x074` is an **index register that reads back the last-written index**
(0x0F), confirming `0x074/0x076` = the **VL82C420 SCAMP config index/data pair** (Chipset §13). The `0xFF`
elsewhere is open-bus / "index points at an unused reg" at idle.

**Live transaction capture (passive, IOW#-triggered, full byte) — the real payoff.** With the running
system's own I/O reconstructed cycle-by-cycle we can read **actual indexed-register contents off the bus**
(read-only, safe). Two indexed register files are active plus a status-poll loop:

| Block | Index port | Data port | Observed registers (idx → value) |
|---|---|---|---|
| **VL82C420 SCAMP** | `0x074` | `0x076` | `0x7E → 0x15`, `0x7F → 0xEE` |
| **Block 2** (8-bit index space) | `0x024` | `0x025` | `0x2E → 0x0F`, `0xB7 → 0x20` (then written `0x5F`), `0xBD ← 0x00`, `0xF9 ← 0x00`, `0xFA ← 0x01` |

Direct (non-indexed) ports seen live: `0x1EA` (W `0x01`/`0x08`) ↔ `0x1EB` (R `0xFF`) — a **~50 µs
status-poll loop** (the `0x1Ex` block, base `0x15E0` aliased → likely the inking pad); `0x1EE ← 0x80`;
`0x070 ← 0x0F` (RTC/CMOS index); `0x023` R `0xFF`; and a **`0x?1F` status port** returning *varying*
values (`0x20,0x28,0xAA,0xEA,0xFB,…`) — a live register worth de-aliasing.

**What this wiring fundamentally cannot resolve (→ next wiring):**
1. **Owner attribution.** `SD`/`IOR#`/`IOW#` are the *shared ISA bus* fanned out by Pluto, so every cycle
   appears on Pluto's pins whether Pluto or the VL82C420 decodes it. We know `0x74/0x76` = chipset (§13),
   but **who owns `0x24/0x25`, `0x1Ex`, `0x070`?** Needs a Pluto **chip-select / subsystem-output** wire.
2. **Full port de-alias.** `SA0–4` only gives offset mod `0x20`; the real 10-bit ports come from Pass-1's
   `SA0–9`, and bits above `SA9` are still aliased.

### → Recommended next wiring (Pass 3 — attribution / function map)
Drop the data byte (contents already captured); anchor the offset and add a **fan of Pluto output/select
pins**, then `bus_stim` each mystery port so its cycles dominate and watch which Pluto pin moves in lockstep:

| CH | Signal | Pluto pin | | CH | Signal | Pluto pin |
|---:|---|---:|---|---:|---|---:|
| 0 | IOR# | 86 | | 8 | KB_CCS | 60 |
| 1 | IOW# | 89 | | 9 | KB_CNTR# | 61 |
| 2 | AEN | 6 | | 10 | LCD_IO | 93 |
| 3 | SA0 | 8 | | 11 | IRDA_O | 81 |
| 4 | SA1 | 9 | | 12 | KB_SPKUP | 44 |
| 5 | SA2 | 10 | | 13 | FDD_IO1 | 68 |
| 6 | SA3 | 11 | | 14 | BIOS_SA17 | 54 |
| 7 | SA4 | 12 | | 15 | PSU_IO | 83 |

Then `bus_stim('io', 0x24)`, `0x1EA`, `0x070` in turn: a Pluto pin that toggles synchronously with the
bursted port ⇒ **Pluto decodes/drives that port** and ties it to that subsystem; if *no* Pluto pin moves,
the port is the **VL82C420 chipset** (like `0x74/0x76`). That closes Pluto §7's "which ports does Pluto
own, and what does each drive."

*Pass 2 run 2026-07-17.*

### Pass 2b — two more things this wiring settled (no rewire)  **[2026-07-17]**
Before rewiring, exhausted the rest of what IOR#/IOW#/AEN + SD0-7 + SA0-4 can measure:

**Cycle timing / wait-state signature.** Measured IOR# low-width per port under a dominant burst: **every
port is identical — 536 ns IOR# low, 2888 ns fall→fall period** (the 2888 ns is the DOS burst-loop rate;
the 536 ns is the ISA cycle). So the VL82C420 issues **one uniform standard 8-bit-ISA I/O cycle for all
these ports, with no differential wait states** → *timing cannot attribute owner* (a slow external
peripheral would stretch IOR#/IOCHRDY; none here do). This confirms attribution needs the Pass-3 select
pins, not timing.

**Aliasing resolved via full-address `io_in` (COMrade returns the byte the CPU sees) — the `0x1Ex` block
is the inking/signature pad.** `SA0–9` can't see bits above bit 9, but COMrade can drive the *full* 16-bit
port and read the data back:

| port | byte | port | byte |
|---|---|---|---|
| `0x01E0` | `0xFF` (open bus) | `0x15E0` | **`0x00`** (real) |
| `0x01EE` | `0xFF` (open bus) | `0x15EE` | **`0x80`** (real) |
| `0x0074` | `0x0F` (real idx) | `0x0474` | `0xFF` (open bus) |

The pad **decodes its full address at base `0x15E0`** (checks `SA10–12`); the low `0x1Ex` aliases are
undecoded open-bus. So the passive **`0x1Ex` ~50 µs poll loop is `INKDRV` polling the pad at `0x15EA/EB/EE`**
([[pc110-inking-pad]], 3-byte `[flags,rawX,rawY]`) — not a mystery register. And `0x0074` reads back its
index while `0x0474` is open bus, re-confirming `0x74/0x76` is a real full-decoded chipset port.

**Verdict: this wiring is now fully exhausted.** Remaining unknowns (owner of `0x24/0x25` and `0x070`;
what each Pluto subsystem port drives) require the **Pass-3 select-pin wiring** above — they are not
obtainable from the shared ISA data/address bus alone.

*Pass 2b run 2026-07-17.*
