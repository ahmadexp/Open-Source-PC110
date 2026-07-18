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

---

## Pass 3 results — owner attribution  **[MEASURED 2026-07-17]**
Rewired to **IOR#(86)/IOW#(89)/AEN(6)/SA0–4(8,9,10,11,12)** + a fan of Pluto outputs: **KB_CCS(60),
KB_CNTR#(61), LCD_IO(93), IRDA_O(81), KB_SPKUP(44), FDD_IO1(68), BIOS_SA17(54), PSU_IO(83)**. Method:
`bus_stim('io', port)` so the target dominates the bus, then per Pluto pin count transitions and its level
during each IOR#-low → a **per-cycle chip-select** shows ~100 % assert + ~2 transitions/cycle.

**Validation (known truth):** bursting the keyboard ports drives **KB_CCS low on 100 % of cycles**
(`0x64`: 7913 transitions; `0x60`: 7715) — Pluto's keyboard decode, exactly as expected. Every other pin
static. Method confirmed.

**Attribution sweep:**

| Port(s) | Pluto pin that fires | Verdict |
|---|---|---|
| `0x60`, `0x64` | **KB_CCS** (100 %/cycle) | **Pluto** decodes the 8042-style keyboard interface |
| `0x74`/`0x076` (SCAMP cfg) | *none* | **VL82C420 chipset** (known-good negative control — §13) |
| `0x24`/`0x25` (2nd index/data block) | *none* | **VL82C420 chipset** — a second on-chip indexed config window, **not Pluto** |
| `0x70` (RTC index) | *none* | **VL82C420 chipset** (integrated RTC) |
| `0x15EA`, `0x15EE` (inking pad) | **KB_CNTR#** (~212–214 edges, deterministic; **not** per-cycle) | pad data/trigger regs **coupled to the KBC control path** |
| `0x15E0` (pad base) / `0x2E2` (null) | *none* | (base reg / undecoded → clean baseline) |

**Findings:**
1. **Pluto owns the keyboard controller** (`0x60/0x64` → KB_CCS, hard per-cycle select).
2. **The config/RTC ports are chipset, not Pluto.** `0x24/0x25`, `0x70`, `0x74/0x76` fire **none** of the
   8 monitored Pluto outputs. `0x74/0x76` is independently known-chipset (§13) and serves as the negative
   control; `0x24/0x25` behaves identically (indexed pair, no Pluto output) ⇒ a **second VL82C420 config
   window**. *Caveat:* 8 of Pluto's ~96 pins were watched, so "not Pluto" = "drives none of
   KB_CCS/KB_CNTR#/LCD_IO/IRDA_O/KB_SPKUP/FDD_IO1/BIOS_SA17/PSU_IO."
3. **The inking pad is serviced through the KBC path.** Reads of the pad's *higher* registers
   (`0x15EA/0x15EE`) deterministically induce **KB_CNTR#** toggling (~212 edges/8 ms) while the pad base
   `0x15E0` and a null port induce none — i.e. touching a pad data/trigger reg kicks the
   keyboard-controller-serviced digitizer. KB_CCS never asserts for the pad, so it's a **functional
   side-effect on the KBC control line, not an address chip-select**. Ties to [[pc110-inking-pad]] /
   [[pc110-u75-trackpad]] (digitizer + trackpad both on the KBC MCU).

This closes Pluto §7's core question: **among the CPU-visible I/O, Pluto decodes the keyboard/KBC
interface; the chipset owns the config-register and RTC ports.** Remaining refinements (optional next
wiring): watch Pluto's *other* peripheral outputs (modem/PCMCIA/dock/FDD2–4/Bowman-link) to make the
`0x24/0x25`=chipset claim exhaustive, and probe the KBC-MCU data lines while reading `0x15EA` to watch the
digitizer conversion directly.

*Pass 3 run 2026-07-17.*

---

## Pass 4 results — extended pin fan (partial / method limit reached)  **[MEASURED 2026-07-17]**
Rewired to **IOR#(86)** as an IOR#-only trigger (anchor CH1–5 dropped — for a dominant single-port burst
the port is already known) + 10 probe pins: the 5 unknown placeholder pins **50, 55, 56, 57, 74** and
Pluto peripheral outputs **MN195_VSDA/modem(75), Bowman_IO1(51), Bowman_IO2(52), FDD_IO2(69),
FDD_IO3(70)**. Bursted `0x24/0x25/0x70/0x15EA` (mystery ports), `0x60/0x64` (known-Pluto keyboard control),
`0x3F4/0x3F5` (floppy).

> ⚠️ **Rig notes this session:** the NUC power-cycled mid-session → ttyUSB re-enumerated and ser2net came
> back on the wrong port; **fixed `/etc/ser2net.yaml` to bind `0.0.0.0:2010` durably** (was `2001`).
> The Pass-4 rewire also left **IOR#(CH0/pin 86) intermittent** — it caught only 3–4 of ~6800 burst
> strobes (all clean 536 ns, so signal-good/contact-bad); reseating pin 86 restored it (65 k clean pulses).
> Method to catch this: timed capture + IOR# low-width histogram — real strobes cluster at 500–550 ns.

**Result: every one of the 10 probe pins stayed static (0 transitions) for every port, including the
keyboard ports.** The pins read stable **mixed** DC levels (pin50=L, pin55=H, pin56=L, pin57=L, pin74=H,
MN195/Bowman/FDD=H), so they are **connected but never toggle under a safe `io_in` read**.

**Interpretation — this pin set can't advance attribution, and here's the (real) reason:** these are
**subsystem-output / status lines**, which only move when the subsystem is *actively exercised* (LCD paint,
IR TX, modem, floppy seek/motor) — a passive port read never stirs them — and the only proven *per-access
select* line, **KB_CCS**, was dropped this pass, so there is **no positive control**. A null therefore
can't separate "chipset owns `0x24/0x25`" from "these lines simply don't respond to reads."

**What Pass 4 *does* establish (small but real):** the 5 previously-unknown pins **50/55/56/57/74 are not
bus-cycle signals** — they hold static DC (idle 50=L, 55=H, 56=L, 57=L, 74=H) through thousands of I/O
cycles, so they are **straps / config / slow-status**, not per-cycle I/O selects. That trims Pluto §7's
"unknown pin" list.

**Attribution conclusion stands from Pass 3:** `0x24/0x25` = VL82C420 chipset **by behavioral identity**
with the known-chipset `0x74/0x76` (indexed pair, no reaction on KB_CCS/KB_CNTR# — the two Pluto lines
that *do* respond to reads). Making that *provable* rather than *inferred* needs a Pluto line that asserts
on any Pluto I/O decode (e.g. **Pluto_IOW pin 58** or a data-buffer-enable), which in turn needs
write-stimulus to Pluto-owned ports — outside the read-only safety envelope — so it is deferred. A cheaper
next step is a **KB_CCS(60) positive-control rewire** to confirm harness+method, but KB_CCS only fires for
keyboard ports and so cannot itself attribute `0x24/0x25`.

*Pass 4 run 2026-07-17. Attribution limit of output-pin probing reached; Pass-3 result is the standing answer.*

---

## Pass 5 results — Pluto_IOW + full strobe fan  **[MEASURED 2026-07-17]**
Rewired to **IOR#(86)** trigger + **IOW#(89)** + the two stars **KB_CCS(60)** (positive control) and
**Pluto_IOW(58)** (Pluto's own I/O write strobe — the generic-decode candidate), plus every remaining
Pluto strobe/link: **KB_CNTR#(61), KB_RESET#(66), FDD_IO1(68), FDD_IO4(71), CPU_STPCLK#(62), PWRGD(67),
Bowman_IO1(51), Bowman_IO2(52)**. (CH6/7/12/15 = KB_SPKUP/KB_SPKDN/SD0/LCD_IO were not landed this pass —
all low-value/known-static.)

**Method validated:** read-burst `0x64`/`0x60` → **KB_CCS asserts low on 100 % of cycles** (5941
transitions). IOR# trigger + harness confirmed.

**Reads still don't attribute:** read-burst `0x24`/`0x25`/`0x70` → **none** of the 10 wired Pluto lines
move. Consistent with Pass 3/4.

**Pluto_IOW characterised:** it is **write-only** (did not move on any read, incl. the keyboard reads that
fire KB_CCS). A passive capture of **1802 of the machine's own write cycles** showed Pluto_IOW asserting on
**zero** of them — expected, because at idle every write targets a chipset port (`0x24/0x25/0x74/0x70`,
per Pass 2), so a quiet Pluto_IOW is consistent with those being chipset. **But** it also means there is
**no positive control** yet proving Pluto_IOW *can* assert — the machine writes no Pluto-owned port at idle
(even the KBC-coupled pad writes to `0x15EA` left it quiet, so Pluto_IOW is a *narrow* strobe, not a
generic decode flag).

**Where this leaves it:** every read-only avenue is exhausted. `0x24/0x25/0x70 = VL82C420 chipset` stands
as a **strong inference** (behavioural identity with known-chipset `0x74/0x76`; no response on ~20 probed
Pluto lines incl. the KB_CCS control; no Pluto_IOW on the machine's own writes to them). Turning inference
into **proof** requires *write* stimulus: (a) a positive control — write a **Pluto-owned** port to show
Pluto_IOW *can* fire, and (b) a no-op write to `0x24` to see if it does. That crosses the read-only safety
envelope, so it is gated on an explicit go-ahead and a chosen safe port/value.

**Bonus read-only result — keyboard and pad use *different* KBC lines.** With KB_CNTR#(61) and the
Bowman↔Pluto link (Bowman_IO1/2) wired for the first time, re-ran the KBC path read-only:
- **Keyboard `0x60`/`0x64`:** only **KB_CCS** asserts (100 %/cycle); KB_CNTR#, Bowman link, all else quiet
  → keyboard reads go through the 8042 chip-select alone.
- **Pad `0x15EA`/`0x15EE`:** **KB_CCS quiet, KB_CNTR# = 212** (deterministic) → the inking pad is **not**
  behind the 8042 chip-select; it is tied specifically to **KB_CNTR#**. So keyboard and pad are distinct
  branches of Pluto's KBC subsystem.
- **Bowman_IO1/2** stayed static through every I/O read *and* a memory-read burst → the Bowman↔Pluto link
  carries neither I/O nor memory cycles in these tests (function still open, but it is not the I/O path).

*Pass 5 run 2026-07-17.*

### Pass 5 write-test — Pluto_IOW positive control (approved, keyboard-safe)  **[MEASURED 2026-07-17]**
With explicit go-ahead for a keyboard-safe write, drove `io_out(0x64, 0xAE)` ("enable keyboard" — a no-op
on an already-enabled KBC; the only value written, benign, nothing to restore) while triggering on
**IOW# falling + KB_CCS low** (a keyboard write) and watching **Pluto_IOW**.

**Result across ~17 confirmed keyboard writes (5 captures):** KB_CCS asserted on **every** one (so the
write reaches Pluto — and note KB_CCS asserts on writes as well as reads), but **Pluto_IOW asserted on
zero**. Therefore **Pluto_IOW is a narrow device strobe, NOT a generic "Pluto decoded this I/O" flag** —
it does not fire even for a confirmed Pluto (keyboard) write. (Likely the external-BIOS-flash or a single
peripheral's write strobe.)

**Consequence:** the planned write #2 (a no-op write to `0x24` watching Pluto_IOW) is **moot and was not
performed** — a null Pluto_IOW on `0x24` would be meaningless when it is already null on confirmed Pluto
writes. The write path cannot attribute `0x24/0x25` either.

### Final attribution verdict
`0x24/0x25/0x70 = VL82C420 chipset` — **strong inference, and now the standing final answer.** Every
available method has been run: behavioural identity with known-chipset `0x74/0x76`; no response across
~20 probed Pluto lines on reads; Pluto_IOW quiet on the machine's own writes to them; and the one Pluto
decode indicator that *could* have proven it (Pluto_IOW) shown to be a narrow strobe that doesn't flag
generic Pluto decodes. **Proof beyond this inference would require a VL82C420 BGA interposer** (watch the
chipset's own I/O-decode/chip-select at the balls) — out of scope for the QFP-probe rig.

**Pluto map — closed:** Pluto owns the **keyboard/KBC interface** (`0x60/0x64` → KB_CCS, reads *and*
writes); the **inking pad** is a distinct KBC branch on **KB_CNTR#** (`0x15EA/EE`, not the 8042 select);
the **config-register and RTC ports** (`0x24/0x25`, `0x70`, `0x74/0x76`) are the **VL82C420 chipset**; the
**Bowman↔Pluto link** carries neither I/O nor memory cycles in these tests (function still open). Pins
50/55/56/57/74 are static straps. Remaining open items need an interposer or the KBC-MCU pinout.

*Pass 5 write-test run 2026-07-17. Pluto I/O-attribution campaign complete.*
