# Modernization roadmap — pushing the PC110 to the next level

An opinionated, ranked list of hardware (and firmware) mods that make a PC110 genuinely nicer to use
with today's parts — each one grounded in what this project's reverse engineering has already
established, so you know what is de-risked and what is still a research problem.

Three things recently changed what is realistic:

1. **A working in-system BIOS flasher** with patch / undo / diagnose ([`Mods/BIOS-Multi-Patcher`](BIOS-Multi-Patcher/)).
2. **Net-level schematics** for every board ([`PCB/`](../PCB/)), traced pin-by-pin.
3. **Firmware disassemblies** for the power MCU, the keyboard controller, and the BIOS memory sizer
   ([`Discovery/`](../Discovery/)).

That turns several "someday" ideas into weekend projects.

Effort/risk key: 🟢 low · 🟡 moderate · 🔴 high (irreversible or needs BGA/SMD rework)

---

## Tier 1 — do these first (high reward, low risk, mostly solved)

### 1. 28 MB RAM 🟢
The single biggest usability jump; Windows 95 on 28 MB vs 20 MB is a different machine. Two routes,
both now understood:

- **16 + 8 MB module = 28 MB on a bone-stock BIOS.** The POST sizer is **probe-based**, not table-based,
  and natively produces geometry codes `D` (16 MB) + `C` (8 MB) — no patch, no RC circuit, no
  `DARK2301`.
- **16 + 16 MB module + our count-cap patch** ([`Mods/32MB-Memory-BIOS-Patch`](32MB-Memory-BIOS-Patch/)).

**What we have:** the DRAM geometry decode (`eced[0x02]`/`[0x03]`, confirmed on 3 units), the patch, its
undo, and a detector. → [`Discovery/RAM-Module`](../Discovery/RAM-Module/readme.md) §7, [`Software/SCAMPRD2`](../Software/SCAMPRD2/)

### 2. TFT panel conversion (+ Windows 256-colour fix) 🟢
The DSTN is the worst thing about using a PC110 — viewing angle, ghosting, contrast. Now fully
**bidirectional**: the 18-byte XR patch, the **confirmed stock DSTN baseline**, the reverse patch, and a
detector that reports which state a machine is in. Flash the 256-colour fix (`0x1CB = 0x1F`) in the same
pass. → [`Discovery/65535`](../Discovery/65535/readme.md) §6c/§6c.1, [`Mods/TFT`](TFT/)

### 3. Internal ESP32 "WiFi modem" 🟢
Cheapest modern win by far. An ESP32 speaking Hayes-AT over the internal serial gives telnet/BBS
immediately, and with SLIP/PPP real TCP/IP under mTCP. Mount it **inside**, wired at **TTL** (skip the
RS-232 transceivers), powered from 3.3 V. Pluto muxes COM1/COM2 and the internal modem already sits at
COM2/`0x2F8`, so there is a free port to claim. → [`Discovery/Pluto`](../Discovery/Pluto/readme.md), [`Discovery/Modem`](../Discovery/Modem/readme.md)

### 4. CF / SD storage 🟢
Largely solved via the card slot, but worth doing deliberately: a modern CF gives a big FAT16 volume and
removes the original flash-disk wear risk. → [`Discovery/Live-Dump`](../Discovery/Live-Dump/) (ATA/CHS findings)

---

## Tier 2 — real projects with big payoff

### 5. Li-ion + USB-C PD conversion 🟡
Runtime and convenience, and we are unusually well armed: full PSU schematic, the J5/J3 connector map
**both sides**, MAX786 details (incl. ESR-critical caps), `ULTRACHG`'s charge logic, and the M38223
power-MCU firmware.

> **Two constraints our RE exposes — plan around them:**
> - The power MCU's battery sense feeds **both** the front-LCD gauge (rendered from `$70/$71`) **and**
>   the APM `530A` charge percentage. A bogus percentage has real consequences: the BIOS flasher
>   **refuses to run below 20 %** — we hit exactly this on a bench unit reporting 0 %.
> - **Keep the 12 V rail alive.** It feeds PCMCIA VPP *and* the BIOS-flash VPP. A naive 5 V-only USB-C
>   conversion silently destroys your ability to reflash.

→ [`Discovery/PSU-MB-M38`](../Discovery/PSU-MB-M38/readme.md), [`Discovery/Power-Sequence`](../Discovery/Power-Sequence/), [`Discovery/BIOS-Flash`](../Discovery/BIOS-Flash/readme.md) §7

### 6. Modern IPS panel via a parallel-RGB bridge 🟡
Potentially the best-looking result of any mod. The F65535 flat-panel port is 15-bit RGB
(`LCD_R0-4/G0-4/B0-4`) plus `SHFCLK`, `LP`, `FLM`, `M`, `STNDBY#` — and after the TFT patch it runs a
**25 MHz dot clock at 640×480**, essentially standard VGA timing. Many small IPS panels accept 24-bit
parallel RGB in that range, so the "bridge" may reduce to **level shifting and padding 5:5:5 → 8:8:8**
— no FPGA required. A CPLD is only needed for scaling or a different native resolution.
→ [`Discovery/65535`](../Discovery/65535/readme.md) §3d (pinout) + §6b (timing registers)

### 7. RP2040 replacing the M38813 keyboard controller 🟡
Feasible now because the original firmware is disassembled: **19 rows × 8 columns**, key index =
`row*8 + bit`, three scancode-set tables, the `E0`-prefix attribute table, and the 8042-style host
interface through Pluto (`KB_CCS`, `KB_CNTR#`, `KB_RESET#`). Payoff: full remapping, a **sane Fn layer**,
macros — and since the trackpad is a standard PS/2 mouse, pointer handling could fold in too. Doubles as
the repair path if a KBC dies. → [`Discovery/Keyboard`](../Discovery/Keyboard/readme.md) §6, [`Discovery/Pluto`](../Discovery/Pluto/readme.md), [`Discovery/Trackpoint`](../Discovery/Trackpoint/)

### 8. CPU upgrade — 486DX / DX2 / DX4 / Am5x86 🔴
Biggest raw-performance mod, and you gain an **FPU** over the SX. Adapter groundwork exists in
[`Mods/CPU Upgrade`](CPU%20Upgrade/), with taka's 230cs as precedent. Be clear-eyed: BGA rework, a new
VRM, 3.3 V vs 5 V, SCAMP IV clocking, and thermals in a fanless palmtop.

---

## Tier 3 — moonshots

### 9. FPGA/CPLD replacements for Bowman and Pluto 🔴
The project that matters most to the *community* rather than to one machine: today a dead gate array
means a **permanently** dead PC110 — they are custom RIOS parts with no source. We have extensive
pinouts for both (Pluto 100-pin, Bowman ~144-pin) plus a decoded register surface. Multi-month effort,
but it is the difference between the platform being repairable and not — and it opens the door to
enhancements like wiring up spare RAS lines or faster ROM decode.
→ [`Discovery/Bowman`](../Discovery/Bowman/readme.md), [`Discovery/Pluto`](../Discovery/Pluto/readme.md)

### 10. Custom BIOS 🟡
We can flash, the sizer and the memory count are located, and the 96 KB main block is safe to rewrite
with the boot block intact as recovery. That makes real features tractable: faster POST, skip the
destructive memory test, larger-disk support, custom splash, patches baked in permanently.
→ [`Discovery/BIOS-Flash`](../Discovery/BIOS-Flash/readme.md), [`Discovery/RAM-Module`](../Discovery/RAM-Module/readme.md) §7.4

### 11. Custom front-panel display 🟢
Niche but a lovely showcase: the 14-pin LCD is fully decoded (SEG0-9 + COM3-0, 1/4 duty, 1/3 bias), as
are the U6 font table and render state machine. Decode the multiplexed segment drive with a small MCU
and mirror it to an OLED, or drive a replacement directly.
→ [`Discovery/PSU-MB-M38`](../Discovery/PSU-MB-M38/readme.md) §7/§8

---

## Traps and hard limits — read before planning

- **32 MB is a hard chipset ceiling**, not a BIOS limit. Past it, addresses wrap onto low memory and
  corrupt POST — which is exactly why taka's 36 MB build needs the RC circuit. **28 MB is the sweet
  spot.** ([`Discovery/RAM-Module`](../Discovery/RAM-Module/readme.md) §7.5)
- **Flashing needs A/C *and* a ≥20 % battery *and* a floppy boot from an IBM-marked drive.** The 12 V
  VPP interlock is hardware; software cannot work around it. POST *does* arm a write-protect bit
  (`block2[0xFE]` bit 0), but clearing it is **not** sufficient — proven live.
  ([`Discovery/BIOS-Flash`](../Discovery/BIOS-Flash/readme.md) §7.1–§7.3)
- **`RAS1` is stranded** — the chipset pin has **no net** on the PC110. That is a free bank select
  sitting unused, arguably a cleaner path to extra memory than [`Mods/RAS4`](RAS4/)'s repurposing of
  `VL_D12`. Needs the bank↔RAS ordering question settled first; our live captures partially answer it.
- **A full 256 KB live BIOS dump is impossible** from a running machine — banks 0/1 are boot-decompressor
  only. Use the physical chip read. ([`Discovery/BIOS-Flash`](../Discovery/BIOS-Flash/readme.md) §9)
- **Don't bother with:** IrDA modernization (dead end), audio upgrades (the ES488F is already SB Pro
  compatible — low ceiling), PCMCIA USB cards (slow, poor DOS support).

---

## Suggested sequence

**28 MB RAM → TFT + 256-colour → internal ESP32 WiFi → Li-ion/USB-C.**

Four mods, each independently rewarding, **no BGA rework**, all within territory this project's
documentation already covers. The result: usable memory, a screen you enjoy looking at, real network
access, and modern power.

The most *exciting* one to build is arguably **#7, the RP2040 keyboard controller** — it is where the
firmware RE gives the biggest unfair advantage, it fixes a real daily annoyance (the Fn layout), and it
doubles as a repair path for a part nobody can buy.

## Two habits worth adopting

1. **Before any flash:** run the flasher's **Diagnose** option, and keep both `PANEL.SAV` and a full BIOS
   backup. ([`Mods/BIOS-Multi-Patcher`](BIOS-Multi-Patcher/))
2. **After a battery mod:** verify APM still reports a sane charge percentage — otherwise you quietly
   lose the ability to reflash.

---

*Rankings and effort estimates are engineering judgement, not measurements. Items are cross-referenced
to the `Discovery/` chapter that supports them; where a mod depends on something we have **not** proven,
it is called out inline.*
