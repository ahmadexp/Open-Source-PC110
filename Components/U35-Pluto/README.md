# Pluto - Central I/O hub

<img width="3844" height="3872" alt="Pluto" src="https://github.com/user-attachments/assets/8703f31e-6c16-41bc-96b5-4a1ce5dafe73" />

## In one sentence

Pluto is a custom, undocumented IBM gate-array chip (a 100-pin QFP ASIC, reference designator U35) that acts as the central I/O hub of the IBM PalmTop PC110 — the part that sits between the CPU and almost every "slow" device in the machine and decides what talks to what.

## What it actually is

The PC110 was a mid-1990s subnotebook built around a BGA-packaged 486SX-33 plus a small set of custom large-scale-integration chips that IBM (or its design partner) gave informal code names: Pluto, Bowman, and Rios. None of these parts ever had a public datasheet. Everything known about Pluto today comes from reverse engineering — optical and X-ray scans of the silicon, plus painstaking net-by-net tracing of the motherboard schematic. The description here is the picture that emerges from that work, so some pin names are confirmed function and others are still educated guesses.

In the language of the schematic, Pluto is the system's **I/O glue and peripheral controller**. It behaves as a slave on an ISA-style local bus: it receives an 8-bit data bus (SD0–SD7), a 16-bit address bus (SA0–SA15), and the standard bus control strobes — I/O read (IOR#), I/O write (IOW#), and address enable (AEN). The CPU reads and writes Pluto's internal registers over that bus, and Pluto in turn fans the bus out to the rest of the laptop. Where it makes sense, Pluto doesn't do all the latching itself; it offloads some timed/latched logic to a handful of ordinary external 74-series flip-flops (U30, U40, U45, U53).

## What it connects to

Think of Pluto as a switchboard. On one side is the CPU's local bus; on the other side is essentially every peripheral subsystem in the machine:

The **keyboard subsystem** is one of the biggest. Pluto presents the keyboard to the CPU like a classic 8042-style controller: it provides the chip-select (KB_CCS), control and reset lines (KB_CNTR#, KB_RESET#), and two speaker drive lines (volume up/down). The other end of those wires is a separate on-board keyboard microcontroller (more on that below).

For **storage and expansion**, Pluto handles the floppy interface (four FDD I/O lines plus a write strobe), CompactFlash/PCMCIA card-detect, and docking-station detect. For **communications**, it gates the RS-232 serial transceivers, drives the IrDA infrared transmitter and its enable, and carries a control line to the internal modem. For **display and power management**, it deals with the CPU stop-clock line, power-good and power-on sense, the LCD bias-rail enable, and LCD standby.

Pluto also has a direct hand in the **BIOS**: it controls the flash write-enable and supplies an extra high address bit (BIOS_SA17), meaning it governs how the BIOS ROM is banked and reflashed. It even reads two **RAM module identity straps** so firmware can tell what memory is installed. And it has dedicated lines to its sibling ASIC, **Bowman**, with which it shares some of the workload.

## How far it reaches (cross-module findings)

Cross-checking Pluto's nets against the docking-station, modem, and RAM-module schematics confirmed several things that had been guesses, and showed Pluto reaches well beyond the motherboard:

- **It is the floppy controller** — but the drive lives in the docking station. Pluto's FDD lines (pins 68–71) and write strobe (pin 58) route out to the dock's floppy connector, which carries the full classic floppy interface. This job is split with Bowman.
- **It is the serial/dock power manager.** Pluto's RS-232 enable (pin 77) appears all over the dock, switching on the serial line drivers and level shifters — so Pluto decides when the docked serial port is actually live.
- **It is the modem's control-bus master.** Pin 75 connects to the internal modem's Panasonic MN195001 DSP/codec, tapping its voice-serial data line. (The schematic label "NM192" is almost certainly a transcription error for "MN195.")
- **It is the RAM-module ID reader.** Pins 31/32 sample two identity bits from the memory module so firmware can size installed RAM. (The actual DRAM timing is done by the chipset, not Pluto — only the ID detect touches Pluto.)

So Pluto is much more than a generic bus buffer: it is simultaneously the floppy controller, the serial/dock power manager, the modem control-bus master, and the RAM-module ID reader. The dock, modem, and RAM module are effectively extensions of Pluto's I/O fan-out.

## Who built it — the authorship lead

The on-board keyboard microcontroller on the other end of Pluto's keyboard pins is a Mitsubishi M38813E4HP (a 6502-compatible 8-bit MELPS 740 micro). Its mask-ROM dump contains a plain-text banner:

> "MELPS 740 Series Keyboard Firmware Version 1.1 (C) Copyright 1992-1995 RIOS Systems Co., Ltd."

That is a concrete attribution. The Japanese design house **RIOS Systems Co., Ltd.** wrote the keyboard firmware — and "Rios" is itself one of the PC110 custom-chip codenames, alongside Pluto and Bowman. That strongly suggests the whole custom-silicon family (Pluto / Bowman / Rios) plus its firmware originated at RIOS Systems rather than IBM's in-house gate-array group. It's currently the best lead on who actually designed Pluto.

## What's still unknown

The reverse-engineering picture is solid on connectivity but incomplete on internal behavior. The biggest open item is Pluto's **register map** — exactly what each bus read/write does inside the chip — which can't be recovered from the schematic alone and needs bus-trace capture or BIOS disassembly. A few pin names (notably pins 50, 55–57, and 74) are still placeholders, the external flip-flop network deserves its own diagram, the precise floppy split between Pluto and Bowman needs mapping, and the X-ray die shots could still confirm the true package details. The pin-75 "NM192" label should almost certainly be corrected to "MN195."

---

*Source: reverse-engineering documentation of the IBM PC110 (Open-Source-PC110 project), derived from the PC110 motherboard schematic and cross-referenced docking-station, modem, and RAM-module sheets.*

