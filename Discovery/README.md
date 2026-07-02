# PC110 Discovery

Reverse-engineering notes for the **IBM PalmTop PC110** (type 2431, 1995 — a Japanese-market, 486-class subnotebook co-developed by IBM Japan and Ricoh / RIOS Systems). Part of the [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110) project.

Each folder below is a deep-dive into one chip or subsystem, reconstructed from KiCad schematic recreations, ROM/firmware disassembly, die scans, and the datasheets of architectural-twin parts. Most folders contain a `readme.md` with the full analysis; several also include schematic crops, ROM dumps, and disassembly scripts.

## Folders

| Folder | Subject | What's inside |
|---|---|---|
| **Service-Manual** | Unofficial, comprehensive service & technical reference manual (rev 2.0, June 2026) | The umbrella document tying every subsystem together — machine overview, system architecture, chip roster, power, troubleshooting, and a glossary. Start here. |
| **Live-Dump** | Ground-truth capture from a **running** PC110 (2026) | Live I/O-port reads, BIOS/video-BIOS/CMOS/font-ROM dumps, power-MCU and PCMCIA-controller state, and the on-disk software inventory — read over the wire and cross-checked against the reverse-engineering chapters (incl. a live authentication of the archived BIOS ROM). |
| **PS2** | IBM's **`PS2.EXE`** system-management tool, reverse-engineered | How the tool drives the hardware (APM `INT 15h/53h` + direct CMOS/SCAMP/power-MCU port pokes), the live firmware-revision manifest, and a command↔subsystem cross-reference. A friendlier menu front-end lives in [`Software/PS2TUI`](../Software/PS2TUI/). |
| **ULTRACHG** | The **"operation charge"** utility, reverse-engineered | How `ULTRACHG.COM` lets the PC110 charge while running — it drives the **embedded-controller mailbox** at `0x15E8/0x15EC` with `Zn10`/`Zn00` commands (reclassifying that I/O window). |
| **Chipset** | VLSI **VL82C420** "SCAMP IV" system controller | Full technical reference: CPU local bus, DRAM controller, ISA bridge, integrated DMA/PIT/PIC/RTC, power management, and the reverse-engineered 208-signal pin map. |
| **Bowman** | **U21 "Bowman"** — main system-controller ASIC | The custom ~144-pin RIOS gate array bridging the 80486SX local bus to the 16-bit ISA bus; ROM decode, interrupts, DMA, floppy, keyboard-MCU link, audio glue. |
| **Pluto** | **U35 "Pluto"** — I/O gate array | The 100-pin custom ASIC handling peripheral I/O glue: keyboard, floppy, PCMCIA/CF detect, IrDA, RS-232, LCD/power rails, docking, modem, BIOS flash. Includes a 6502 disassembler and KBC/RAM/dock notes. |
| **65535** | **U51** — Chips & Technologies **F65535** display controller | Deep-dive on the single-chip flat-panel/CRT VGA controller (BGA169): CPU bus interface, integrated DRAM controller and RAMDAC, LCD formatter, full pin map. |
| **ES488** | **U4** — ESS **ES488F** "AudioDrive" audio subsystem | Sound Blaster (Pro)-compatible ISA codec plus the discrete YM3812 (OPL2) FM chain and speaker amp. Includes schematic crops and a mainboard net dump. |
| **Modem** | **MN195001** single-chip fax engine | How the internal fax/modem module connects through the motherboard to the docking station, the "extra" dock pins, and analysis of the IC11 firmware ROM ("RIOS Ver 1.04"). |
| **PSU-MB-M38** | **U6** — Mitsubishi **M38223E4HP** power-sense MCU | Firmware reverse-engineering of the power-management micro plus the J5/J3 inter-board connector map. Includes the disassembly (`disasm_full.asm`), tracing scripts, and connector crops. |
| **Power-Sequence** | Power-on sequence & "won't power on" repair guide | Step-by-step power-up chain derived from the U6 firmware and PSU schematics, with what to measure at each stage. |
| **Trackpoint** | **U75** — NEC **µPD17137A** trackpad controller | The 4-bit MCU (SSOP-28) that scans the pointing-device pad and reports over a PS/2-style interface; part, net map, and pinout. |
| **Debug** | CPU debug headers (J9 / J12 / JTAG) | Pinouts of the 80486SX debug/ICE headers and JTAG TAP, what they're for, and a homebrew modern debug-pod design. Includes pod source (`pc110_debug_pod.c`). |

## Conventions

Analyses use a confidence key throughout:

- ✅ **Verified** — read directly from firmware, a ROM dump, or a fully traced schematic net.
- 🟡 **Strongly inferred** — consistent with evidence and standard practice, not independently confirmed.
- ⚠️ **Assumption** — plausible but unverified; confirm on the bench against a known-good unit.

Some chapters also tag provenance: **[DS]** datasheet of an architectural twin, **[PAT]** patents, **[DECAP]** die analysis, **[RE]** reverse-engineered pin map / board, **[BIOS]** BIOS disassembly, **[H]** hypothesis.

> These materials are **unofficial**. IBM never published board-level schematics or datasheets for the PC110's custom silicon. Work on these boards at your own risk, observe ESD precautions, and never assume a board is fully "off" while powered.
