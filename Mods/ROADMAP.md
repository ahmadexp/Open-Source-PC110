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

### 8. RP2040 on the internal ISA bus — emulate new devices 🟡
The PC110 has a **real internal ISA bus** (not just Bowman's ML/companion path): `SA`/`LA`/`SD`,
`MEMR#`/`MEMW#`, `IOR#`/`IOW#`, `BALE`, `SBHE#`, `MEMCS16#`, `IOCS16#`, `REFRESH#` and an 8 MHz
`ISA_SYSCLK`. RP2040-on-ISA device emulation is proven art on desktops (**PicoGUS**), and one PC110
detail makes it much easier than expected:

> **`IOCHRDY` is present** ([`Discovery/Chipset`](../Discovery/Chipset/readme.md) §6). You can **stretch
> bus cycles**, so the RP2040 does not have to meet hard ISA setup times — it can hold the CPU until
> ready. That turns the timing problem from "tight" into "comfortable."

**Best tap point: the ES488F audio chip (U4).** It is a 52-pin QFP ISA device carrying `A0–A9`
(= `SA1–SA9`), `IOR`, `IOW`, `AEN`, `IRQ1`, `IRQ2` and `DACK1#`, with data through HD151015
transceivers — **a complete 8-bit ISA I/O interface in one physical location**, and we have the
schematic crops plus a mainboard net dump for exactly that block.
→ [`Discovery/ES488`](../Discovery/ES488/readme.md)

**Two constraints our RE surfaces — design around them:**

- Those **HD151015s are documented as 5 V↔3.3 V level translators**, so *which side you tap decides your
  level-shifting bill*. The peripheral side may already be 3.3 V (RP2040-friendly). **Measure first.**
- **Skip DMA.** `AEN` comes from Pluto (`Pluto_ESS_AEN`) and `DACK1#` from Bowman
  (`Bowman_ESS_DACK1#`) — bus arbitration is produced by the custom gate arrays, not a standard
  82C206, and those cannot be reprogrammed. Target **8-bit, I/O-mapped, IRQ-driven** devices only.

Scoped that way it is ~22 signals rather than 40. Free I/O windows are pickable from the live port map,
and **IRQ 10/11 look available** (5 = audio, 9 = PC Card, 12 = pointer, 14 = ATA).
→ [`Discovery/Live-Dump`](../Discovery/Live-Dump/)

**What is worth emulating, ranked:**

1. **NE2000 + WiFi** — strictly better than the serial-modem route (#3): standard DOS packet drivers,
   mTCP, real throughput. Needs a Pico W/CYW43 or an ESP32 companion for the radio.
2. **Option ROM + SD-backed disk** — an "XT-IDE for PC110". This is also **the fix for the CF size
   limit**, because it supplies the `INT 13h` extensions the stock BIOS lacks.
   → [`Discovery/Storage`](../Discovery/Storage/readme.md)
3. **Not sound** — the machine already has SB Pro + OPL2; no ceiling worth raising.

**Space:** removing the internal modem module frees a whole bay. (Its 26-pin connector carries serial,
not ISA — space only, not a bus tap.) → [`Discovery/Modem`](../Discovery/Modem/readme.md)

### 9. CPU upgrade — 486DX / DX2 / DX4 / Am5x86 🔴
Biggest raw-performance mod, and you gain an **FPU** over the SX. Adapter groundwork exists in
[`Mods/CPU Upgrade`](CPU%20Upgrade/), with taka's 230cs as precedent. Be clear-eyed: BGA rework, a new
VRM, 3.3 V vs 5 V, SCAMP IV clocking, and thermals in a fanless palmtop.

---

## Tier 3 — moonshots

### 10. FPGA/CPLD replacements for Bowman and Pluto 🔴
The project that matters most to the *community* rather than to one machine: today a dead gate array
means a **permanently** dead PC110 — they are custom RIOS parts with no source. We have extensive
pinouts for both (Pluto 100-pin, Bowman ~144-pin) plus a decoded register surface. Multi-month effort,
but it is the difference between the platform being repairable and not — and it opens the door to
enhancements like wiring up spare RAS lines or faster ROM decode.
→ [`Discovery/Bowman`](../Discovery/Bowman/readme.md), [`Discovery/Pluto`](../Discovery/Pluto/readme.md)

### 11. Custom BIOS 🟡
We can flash, the sizer and the memory count are located, and the 96 KB main block is safe to rewrite
with the boot block intact as recovery. That makes real features tractable: faster POST, skip the
destructive memory test, larger-disk support, custom splash, patches baked in permanently.
→ [`Discovery/BIOS-Flash`](../Discovery/BIOS-Flash/readme.md), [`Discovery/RAM-Module`](../Discovery/RAM-Module/readme.md) §7.4

### 12. Custom front-panel display 🟢
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
- **The BIOS has no `INT 13h` extensions and never issues ATA `IDENTIFY`** — real-mode disk access is
  CHS-only and the reported geometry is a ~3.85 MB stub. That is *not* what causes the ~4 GB CF wall
  (a capacity-blind BIOS cannot break at 4 GB), but it does mean large cards need LBA from somewhere:
  a BIOS patch, an option ROM (#8), or a Dynamic Drive Overlay.
  ([`Discovery/Storage`](../Discovery/Storage/readme.md))
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
