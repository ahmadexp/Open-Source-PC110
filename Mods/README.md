# Modifications

Hardware modifications and redesigns for the IBM PC110 palmtop. Each folder is a self-contained project, mostly KiCad/Altium PCB designs, with its own `README.md` and screenshots.

## Projects

### PC110-ITX
An ITX form factor motherboard that reimplements all of the PC110 components, with the original BGA parts converted to QFP alternatives for easier assembly. Full KiCad project with per-block schematics (Processor, Chipset, ASIC, Memory, ROM, VGA, Audio, PCMCIA, Storage, Power, Clock, Super I/O, Keyboard, Dock). Includes netlist, placement, and 3D render views.

### PC110-ITX-all-in-one
A variant of the ITX board that blends the motherboard and the docking station's PSU board into a single all-in-one design. Same KiCad block structure as PC110-ITX, plus the docking station ports and footprints.

### CPU Upgrade
Work toward upgrading the PC110 CPU using a BGA-to-socket adapter board (`pcb-bga-adapter`, plus dual-connector variants). Includes KiCad adapter projects, datasheets, and 3D models. References Taka's 230cs CPU upgrade, which shares the VL82C420 design with the PC110.

### NewDock
A redesigned docking station as a standalone KiCad project (`DockingStation`).

### RAS4
A modification that enables an extra 4MB of internal RAM by repurposing the `VL_D12` line as `RAS#4` on the schematic. Documented with annotated schematic captures.

### BIOS-Multi-Patcher
`PCPATCH.COM` — one DOS tool that applies (and where possible reverses) every known PC110 BIOS mod from a single menu: **DSTN↔TFT** display, **Windows 256-colour** fix, and **32 MB memory patch enable/remove**. Flash sequence byte-identical to `vpatch`; reflashes only the 96 KB main block (boot block preserved); CS-relative staging + pre-flash verification. **⚠️ VALIDATION REQUIRED** and requires booting from an IBM-marked floppy (12 V VPP interlock — see `Discovery/BIOS-Flash` §7).

### 32MB-Memory-BIOS-Patch
A **firmware** memory-expansion mod: a 17-byte BIOS patch that caps POST's extended-memory count so a PC110 populated beyond the stock 20 MB (e.g. a 16+16 MB module) cold-boots cleanly, without the RC circuit / `DARK2301` warm-boot dance of the classic taka 32 MB hack. Includes a reproducible build script and pre-built 256 KB / 96 KB images, flashable via the PS2GUI/PS2TUI "Flash BIOS" feature. **⚠️ VALIDATION REQUIRED — verified by disassembly + emulator only, never flashed to real hardware.**

### TFT
TFT display replacement work, including the TFT Upgrade Kit's BIOS patch floppy (`BIOS_Patch.img`) and a reproducible form of the same DSTN→TFT video-BIOS patch in [`TFT/bios-patch`](TFT/bios-patch) (builder + 18-byte patch spec, decoded in `Discovery/65535` §6c). **⚠️ VALIDATION REQUIRED**; a reverse TFT→DSTN patch is pending a confirmed unpatched-DSTN dump.

### Altium
The PCB projects converted from KiCad to Altium, to add versatility and make Altium's tooling available to the project.
