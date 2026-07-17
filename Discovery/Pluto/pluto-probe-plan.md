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

## Force-multiplier (optional, build first)
A proposed COMrade **bus-stimulus burst op** — `BUS_STIM(kind, port, width, count)` that loops the
access K times in a tight DOS-side CPU loop from one serial round-trip — would let driven `io_in` bursts
**dominate the bus** (vs the ~130 ops/s serial limit that hampered the ML-bus decode). Worth adding to
COMrade before a serious Pluto register sweep. ~30 lines across
`hwaccess.cpp`/`resident.cpp`/`protocol.py`/`connection.py`/`server.py`; build with OpenWatcom on the NUC
(`/opt/watcom`), deploy via `update_agent` (backs up + reboots).

---

*Plan written 2026-07-16. Next session: wire Pass 1, run the read-only `io_in` sweep, bucket by port.*
