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

### TFT
TFT display replacement work, including a BIOS patch image (`BIOS_Patch.img`).

### Altium
The PCB projects converted from KiCad to Altium, to add versatility and make Altium's tooling available to the project.
