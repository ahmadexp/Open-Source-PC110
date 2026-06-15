# IBM Palm Top PC110

<img width="709" height="945" alt="PHOTO-2026-05-27-13-02-38" src="https://github.com/user-attachments/assets/a9495e3b-ffd1-410e-bfda-8d170861e6be" />

<img width="630" alt="Screenshot 2025-04-17 at 7 04 40 PM" src="https://github.com/user-attachments/assets/035395bb-da18-442e-9486-4e40237b8320" />

A complete, open-source reverse engineering of the **IBM Palm Top PC110** (type 2431, 1995) — a Japanese-market, 486-class subnotebook co-developed by IBM Japan and Ricoh / RIOS Systems. This repository gathers everything needed to understand, repair, recreate, and modernize the machine: recreated schematics and PCB layouts, die-level chip analysis, firmware and BIOS dumps with disassembly, high-resolution optical and X-ray scans, datasheets, and hardware mods.

> 🛠️ **Goal:** preserve the PC110 in full — signal-for-signal — so it can be rebuilt, repaired, emulated, and reimagined long after the last original board has corroded away.

---

## 📦 What's in this repository

| Folder | What you'll find |
|--------|------------------|
| [**`PCB/`**](PCB/) | Recreated **KiCad schematics and PCB layouts** for the mainboard, PSU, keyboard membrane, docking station, modem, and 16 MB RAM module. Includes a [combined schematic PDF](PCB/PC110-Schematics-Combined.pdf), fab files, BOMs, and 3D renders. |
| [**`Components/`**](Components/) | **Chip-level reverse engineering**: die-level analysis (with John McMaster), firmware/BIOS/ROM dumps for six chips, disassembly, emulators, and the internal 4 MB disk image. |
| [**`Discovery/`**](Discovery/) | **Deep-dive subsystem notes** for each major chip and bus, plus an unofficial, comprehensive **service & technical reference manual**. Start here to understand how it all fits together. |
| [**`Mods/`**](Mods/) | **Hardware modifications and redesigns**: ITX-form-factor recreations, a CPU upgrade adapter, a new docking station, a +4 MB RAM mod, a TFT display swap, and Altium ports. |
| [**`Optical/`**](Optical/) | **High-resolution optical scans, X-ray captures, and individual copper-layer images** of every board and the custom chips. |
| [**`Datasheets/`**](Datasheets/) | Datasheets, pinouts, and connector maps for the chips and connectors across the motherboard and peripheral boards. |
| [**`Docs/`**](Docs/) | The project's story — ["A Tribute to the IBM PC110"](Docs/) — covering the sanding, scanning, decapping, and schematic-extraction journey. |

---

## 🔧 Recreated PCBs ([`PCB/`](PCB/))

All boards are recreated in **KiCad 9.0** (requires the [Alternate KiCad Library](https://alternatekicadlibrary.com/)), with fab files and BOMs.

| Board | Description | Layers |
|-------|-------------|--------|
| Mainboard | Motherboard | 10 |
| PSU | Power supply | 4 |
| Keyboard | Keyboard membrane | 2 + 2 |
| Docking Station | Port expansion | 4 |
| Modem | 14.4 kbps internal modem | 6 |
| RAM-16MB | 16 MB RAM module | 4 |

📄 **[Combined schematic PDF →](PCB/PC110-Schematics-Combined.pdf)**

### Mother Board
- Schematic

<img width="756" alt="Mainboard schematic" src="https://github.com/user-attachments/assets/9c982810-b3e1-4d82-ad55-4d1de2c18353" />

- Layout

<img width="753" alt="Mainboard layout" src="https://github.com/user-attachments/assets/24e71d16-02dd-4cf2-a335-273538d7219c" />

### Power Supply
- Schematic

<img width="727" alt="PSU schematic" src="https://github.com/user-attachments/assets/f9e14b88-f7f9-4c00-bfa1-00295bc050f9" />

- Layout

<img width="766" alt="PSU layout" src="https://github.com/user-attachments/assets/467c653b-4416-476a-ba74-c6799add9fb2" />

### Keyboard Membrane
- Schematic

<img width="675" alt="Keyboard schematic" src="https://github.com/user-attachments/assets/98c4f22a-432f-49ea-99f2-28a8ce58fc91" />

- Layout

<img width="895" alt="Keyboard layout" src="https://github.com/user-attachments/assets/28b69eb5-7d7e-4dd0-a96d-93a32787889b" />

### Port Expansion (Docking Station)
- Schematic

<img width="754" alt="Dock schematic" src="https://github.com/user-attachments/assets/e7c5dda2-cd30-4ed0-bb2a-d4e0f0acf984" />

- Layout

<img width="856" alt="Dock layout" src="https://github.com/user-attachments/assets/54e36843-14c5-4dc8-8dfd-77612298fb27" />

### 14.4 kbps Internal Modem
- Schematic

<img width="638" alt="Modem schematic" src="https://github.com/user-attachments/assets/727293b9-b339-4447-a33d-4b19658e620c" />

- Layout

<img width="659" alt="Modem layout" src="https://github.com/user-attachments/assets/9f466b57-1cae-421f-9bf0-a55499aed11d" />

### 16 MB RAM Module
- Schematic

<img width="747" alt="RAM schematic" src="https://github.com/user-attachments/assets/29b935ec-0abb-413a-bb73-6f45181ac445" />

- Layout

<img width="326" alt="RAM layout front" src="https://github.com/user-attachments/assets/63ea09f8-2a62-4767-a2ea-7ffe4497582d" />
<img width="296" alt="RAM layout back" src="https://github.com/user-attachments/assets/5574484b-f86c-4c51-978d-42033861f85c" />

---

## 🧬 Component Reverse Engineering ([`Components/`](Components/))

### Die-level investigation

A collaboration with [John McMaster](https://siliconpr0n.org/archive/doku.php?id=ibm:pc110) — laser-decapped chips with high-resolution die imaging.

| Designator | Part | Function | Notes |
|------------|------|----------|-------|
| U61 | VL82C420FC5 | "SCAMP IV" chipset (DMA, PIC, PIT, RTC) | [Notes](Components/U61-VL82C420FC5/) |
| U35 | Pluto | Custom I/O gate array | [Notes](Components/U35-Pluto/) |
| U21 | Bowman | Custom system-controller gate array | [Notes](Components/U21-Bowman/) |
| U75 | D17137AGT | TrackPoint controller | [Notes](Components/U75-D17137AGT/) |

### Flash & ROM dumps

Raw readouts plus reverse-engineering analysis (reports, extracted strings, hexdumps, disassembly, and in some cases emulators) for the programmable chips. See [`Components/Flash/`](Components/Flash/).

| Chip | Size | Role |
|------|------|------|
| [Intel E28F002BXT](Components/Flash/E28F002BXT/) | 256 KiB | Main/system **BIOS** (IBM VGA-compatible, APM) — includes BIOS disassembly project |
| [OKI MSM538032E](Components/Flash/OKI-MSM538032E/) | 1 MiB | Japanese/system **font mask ROM** |
| [Eon EN29F040A](Components/Flash/EN29F040A/) | 512 KiB | **Modem/fax board** flash |
| [Mitsubishi M38813E4HP](Components/Flash/M38813E4HP/) | ~16 KiB | **Keyboard controller** firmware (U67) |
| [Mitsubishi M38223E4HP](Components/Flash/M38223E4HP/) | ~16 KiB | **Power-sense** MCU firmware (U6) — includes an emulator |
| [Atmel AT29LV512](Components/Flash/AT29LV512/) | 64 KiB | SanDisk PCMCIA ATA FlashDisk controller (68000) |

### Internal disk image

Images of the PC110's internal 4 MB solid-state drive in [`Components/Internal-Disk-Image/`](Components/Internal-Disk-Image/) (raw `.img` and PowerQuest `.PQI`).

---

## 📚 Discovery — subsystem deep-dives ([`Discovery/`](Discovery/))

Reconstructed from schematic recreations, firmware disassembly, die scans, and the datasheets of architectural-twin parts.

| Folder | Subject |
|--------|---------|
| [**Service-Manual**](Discovery/Service-Manual/) | Unofficial comprehensive service & technical reference manual — **start here** |
| [Chipset](Discovery/Chipset/) | VLSI VL82C420 "SCAMP IV" system controller, full pin map |
| [Bowman](Discovery/Bowman/) | U21 main system-controller ASIC |
| [Pluto](Discovery/Pluto/) | U35 I/O gate array (with 6502 disassembler) |
| [65535](Discovery/65535/) | C&T F65535 flat-panel/CRT VGA controller |
| [ES488](Discovery/ES488/) | ESS ES488F "AudioDrive" + YM3812 (OPL2) FM chain |
| [Modem](Discovery/Modem/) | MN195001 single-chip fax engine |
| [PSU-MB-M38](Discovery/PSU-MB-M38/) | U6 M38223E4HP power-sense MCU + connector map |
| [Power-Sequence](Discovery/Power-Sequence/) | Power-on sequence & "won't power on" repair guide |
| [Trackpoint](Discovery/Trackpoint/) | U75 µPD17137A pointing-device controller |
| [Debug](Discovery/Debug/) | 80486SX debug / JTAG headers + a homebrew debug pod |

---

## 🚀 Modifications & redesigns ([`Mods/`](Mods/))

| Project | Description |
|---------|-------------|
| [PC110-ITX](Mods/PC110-ITX/) | An ITX-form-factor motherboard reimplementing the PC110, with original BGA parts converted to QFP for easier assembly |
| [PC110-ITX-all-in-one](Mods/PC110-ITX-all-in-one/) | ITX variant that merges the motherboard and docking-station PSU into one board |
| [CPU Upgrade](Mods/CPU%20Upgrade/) | BGA-to-socket adapter work toward a faster CPU (shares the VL82C420 with Taka's 230cs upgrade) |
| [NewDock](Mods/NewDock/) | A redesigned docking station as a standalone KiCad project |
| [RAS4](Mods/RAS4/) | Enables an extra 4 MB of internal RAM by repurposing `VL_D12` as `RAS#4` |
| [TFT](Mods/TFT/) | TFT display replacement, including a BIOS patch image |
| [Altium](Mods/Altium/) | The PCB projects ported from KiCad to Altium |

---

## 🔬 Optical scans & X-rays ([`Optical/`](Optical/))

High-resolution optical scans, X-ray captures, and individual copper-layer images of every board and the custom chips — including the full 10-layer copper stack of the mainboard, x-rays of the BGA/QFN packages, and corner-stitch die photos for the 486SX, VL82C420, F65535, Bowman, and Pluto. See [`Optical/README.md`](Optical/).

---

## 💬 Community

Join the discussion, ask questions, and share your work:

- 💬 **Discord:** [discord.gg/WvRh6C6WT](https://discord.gg/WvRh6C6WT)
- 👥 **Facebook group:** [IBM PC110 community](https://www.facebook.com/groups/985746629171739)

---

## 🤝 How can you help?

- **Review** the schematics and PCB layouts to spot bugs, errors, and issues.
- **Verify** the layout against the schematic and against real hardware.
- **Find** missing datasheets for the custom and undocumented parts.
- **Contribute** firmware / ROM analysis and disassembly.
- 💛 **[Fund the next iteration of PCBA](https://gofund.me/716b7dae)** so we can fabricate and test the recreated motherboard.

---

## 📰 Press

Featured on **Hackaday**:
- [Reverse Engineering The IBM PC110, One PCB At A Time](https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/)

Featured on **Taka's blog**:
- [PC110 New PSU](https://garakutaen.sakura.ne.jp/misc2/MlogmP3.html#e0318)
- [PC110 PCB Pattern](https://garakutaen.sakura.ne.jp/misc2/MlogmP1.html#e0130)
- [PC110 PCB Layout creation](https://garakutaen.sakura.ne.jp/misc2/MlogmP2.html#e0208)
- [PC110 New Docking Station PCB](https://garakutaen.sakura.ne.jp/misc2/MlogmP3.html#e0324)
- [X-ray photos of the inside of the PC110's LSI](https://garakutaen.sakura.ne.jp/misc2/MlogmP2.html#e0225)

**Jeff Geerling's YouTube Channel**:
- [Reverse engineering Episode](https://youtu.be/p7IvioiveOo?si=PUlHSzOhwXYEpZJ3&t=217)

**LGR YouTube Channel**:
- [LGR Vlog: VCFMW20](https://www.youtube.com/watch?v=yIwXQicYClw&t=7595s)

**VCFMW20 YouTube Channel**:
- [Archaeology of the IBM PC110](https://www.youtube.com/watch?v=8Uja7g9hQlo)

---

## 🙏 Acknowledgements

This project would not have been possible without **Kevin Moonlight** (microcontroller ROM extraction), **Mike Lycett** (fundraiser & coordination), **Nick Rogers** (debugging & verification), **John McMaster** (high-resolution die imaging), **CLC / Fred Nielsen** (decapping & silicon prep), and the wider **open hardware & retrocomputing community**.

---

## 🕹️ PC110 Emulator

The reverse-engineering work in this repo has a companion project: **[PC110-EMU](https://github.com/ahmadexp/PC110-EMU)** — an experimental emulator built around the *real* machine artifacts documented here. It boots the actual PC110 BIOS, runs PC DOS and Personaware, and loads the power-sense and keyboard-controller MCU firmware and the Japanese font flash — the very dumps that live in this repository's [`Components/Flash/`](Components/Flash/) folder.

Highlights:

- Boots the real PC110 BIOS and runs **PC DOS** and supported **Personaware** disk images, including the ROM-backed graphical **Easy-Setup** screen.
- Renders the Personaware launcher with **Japanese DBCS glyphs** pulled from the PC110 font flash ([`MSM538032E`](Components/Flash/OKI-MSM538032E/)).
- Loads the **M38223** power-sense MCU and **M38813** MELPS 740 keyboard-controller firmware for diagnostics and controller responses.
- Models the **front LCD status strip** (the startup `IBM` segment display, time, disk, PMCU, KBC, speaker, and setup state).
- Two frontends: a native **macOS SwiftUI** app for bring-up and diagnostics, and a **portable CMake** build (Linux / Windows / macOS) with a headless runner and an optional SDL2 GUI.
- Rich diagnostics: copy-ready CPU state, traces, memory, and text-screen dumps.

> ℹ️ The emulator ships **no copyrighted ROMs** — use the legally obtained dumps from hardware you own. This repo documents where those dumps come from and what each one does.

The macOS frontend running **Personaware**, with live diagnostics and the modeled front LCD:

<img width="900" alt="PC110 EMU running Personaware with diagnostics and front LCD" src="https://github.com/ahmadexp/PC110-EMU/raw/main/Docs/images/pc110-emu-personaware-dashboard.png" />

The ROM-backed graphical **BIOS Easy-Setup** screen:

<img width="640" alt="PC110 BIOS Easy-Setup screen" src="https://github.com/ahmadexp/PC110-EMU/raw/main/Docs/images/easy-setup-bios.png" />

👉 **[Get the emulator → ahmadexp/PC110-EMU](https://github.com/ahmadexp/PC110-EMU)**

---

## 📄 License

This project is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0).

You are free to:
- Share — copy and redistribute the material in any medium or format
- Adapt — remix, transform, and build upon the material

Under the following terms:
- Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
- NonCommercial — You may not use the material for commercial purposes.

For full details, see: https://creativecommons.org/licenses/by-nc/4.0/

As the project creator, I reserve the right to use this material commercially or under any other terms.
