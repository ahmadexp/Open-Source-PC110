# Bowman (U21) — The IBM PC110 System Controller

<img width="5094" height="5121" alt="bowman" src="https://github.com/user-attachments/assets/18ac4789-1bc2-4f4a-a374-e041f34c04fb" />

## Overview

**Bowman** is the codename, carried in the value field of reference designator **U21**, for the IBM PC110 palmtop's main system-controller ASIC. It is a roughly 144-pin custom gate array (QFP-class) that sits at the center of the machine, bridging the 80486SX CPU's fast local bus to a slower 16-bit ISA-style system bus while soaking up nearly all of the computer's glue logic. In a desktop PC of the era this work would have been spread across a multi-chip chipset and a board full of discrete logic; in the PC110 it is consolidated into one part.

Bowman corresponds to the documented custom **RIOS** chip that "controlled the ISA bus and expanded the bus width to 16 bits." The PC110 was co-developed in 1995 by IBM Japan and Ricoh (the RIOS partnership), and its 486SX-33 CPU and several support chips carry RIOS markings. "Bowman" is the project/schematic codename — there is no public datasheet for the part, and the name is almost certainly an internal codename rather than an IBM or RIOS part marking.

## What it does

The CPU never talks directly to the peripheral bus. Instead, the 80486SX (U76, a BGA256 part) communicates only with Bowman over its local bus, and Bowman translates those CPU cycles into 16-bit ISA bus cycles. From that central position Bowman performs the full set of "chipset" jobs:

- **CPU bus interface** — accepts the 486 address bus (A2–A25, with A0/A1 implied by byte-enables) and the control signals ADS#, M/IO#, D/C#, W/R#, RDY#, INTR, RESET and the CPU clock.
- **ISA bus generation** — drives the system address bus (SA0–SA15), the low byte of system data (SD0–SD7), and the I/O control strobes (IOR#, IOW#, AEN, MEMCS16#).
- **Interrupt aggregation** — collects roughly fifteen interrupt sources (IRQ2–IRQ15 plus the keyboard's IRQ1 and the audio chip's ESS_IRQ1) in the manner of a pair of cascaded 8259 controllers and presents a single INTR to the CPU.
- **DMA handshaking** — manages floppy and peripheral DMA requests and acknowledges (FDRQ, PDRQ, DACK#, PDACK#) including a dedicated channel for the ESS audio device.
- **ROM/BIOS decode** — generates the high ROM address lines (ROMA12–ROMA19) and the chip-enable (ROMCE#) for the system Flash BIOS.
- **Keyboard / power-management link** — a 12-line parallel bus (M38_IO1–12) connects Bowman to U67, the Mitsubishi M38813M4 microcontroller that handles the keyboard and power management, plus dedicated keyboard reset and scroll-lock-LED lines.
- **Power sequencing and housekeeping** — power-good in/out, PSU control I/O, the 24 MHz reference and 32.768 kHz timekeeping clocks, and the volume up/down button inputs.

## Bowman and Pluto

Bowman does not work alone. A companion custom chip, **Pluto (U35)**, a roughly 100-pin ASIC, handles the lower-speed peripheral I/O: CompactFlash and dock detection, the LCD, IrDA, RS-232 enable, floppy data lines, the keyboard speaker, RAM identification, and BIOS write-enable. The two custom chips share the SA/SD bus and coordinate over dedicated status lines — Bowman exposes a `Pluto_IO` pin, while Pluto carries `Bowman_IO1` and `Bowman_IO2`. The exact division of labour passing over those lines is one of the open questions in the reverse-engineering effort. Together, Bowman and Pluto replace what would otherwise be a conventional chipset plus an embedded controller.

## The peripherals on the far side

Through the 16-bit ISA-style bus that Bowman creates, the system reaches its peripherals: CompactFlash mass storage, PCMCIA slots, the Yamaha YM3812 (OPL2) FM synthesizer with its YM3014B DAC, and the ESS AudioDrive (ES488) Sound Blaster-compatible audio. Local support components clustered around U21 on the board — pull-up resistors, a couple of transistors, a flip-flop for reset timing (74LVT74), and a TPS2201 PCMCIA power switch — and a shared power-sequencing network suggest Bowman also oversees card-slot power-up and reset timing.

## Pin summary

| Attribute | Value |
|---|---|
| Reference designator | U21 |
| Value / codename | Bowman |
| Function | System controller / CPU-to-ISA bridge ("chipset") |
| Pin count | ~144 (QFP-class custom gate array) |
| CPU interface | 80486SX-33 local bus (U76, BGA256) |
| Companion controller | U35 "Pluto" |
| Power rails | VCC/VCC2 on 13 pins; GND on 8 pins; 3 no-connects |

## Notable open questions

A few details remain unresolved in the project. The CPU address bus to Bowman starts at A2, so it is worth confirming how byte-enables (BE#) are routed, if at all. More intriguingly, Bowman exposes only the low data byte (SD0–SD7) even though its documented job is the *16-bit* bus expansion that CompactFlash relies on (SD0–SD15) — the high-byte steering is presumably handled via the `ADDHI` qualifier, the internal `Chipset_IO` lines, or in concert with Pluto, and tracing that against board X-rays would settle it. Finally, if die photos or X-rays ever reveal the laser/silk markings on the package, the true RIOS part number could replace the "Bowman" codename in the bill of materials.

---

*Source: schematic `Mainboard.pdf` ("PC110 Motherboard", KiCad), part of the [Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110) reverse-engineering project, with corroborating teardown reporting from Hackaday, iPhone Wired, and ThinkWiki.*
