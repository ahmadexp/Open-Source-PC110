# Datasheets

A collection of datasheets, pinouts, and reference material for the chips and connectors found on the IBM PC110 (PalmTop PC) board and its peripherals.

Files are organized by board area or subsystem. PDFs are the original component datasheets; `.png`/`.jpg`/`.tif` files are pinouts, connector maps, and board photos used to identify parts. Where a part is marked with only a short SMD code on the silkscreen, the filename uses that code and the relevant README maps it to a full part number.

## Folder structure

| Folder | Contents |
|--------|----------|
| [`top/`](top/) | Components on the **top** layer of the motherboard, plus connector pinouts (RAM, LCD, docking, power). |
| [`bottom/`](bottom/) | Components on the **bottom** layer, including the i486SX CPU, VL82C420 chipset, CHIPS 65535 LCD controller, and BGA ball maps. |
| [`generic/`](generic/) | Small generic parts (transistors, regulators, logic) identified by SMD marking code. See the code→part-number table in the folder README. |
| [`Modem/`](Modem/) | Components on the modem board, including the modem connector and scanner pinout. |
| [`PSU/`](PSU/) | Power supply parts (regulators, controllers such as MAX786). |
| [`LCD/`](LCD/) | LCD panel datasheets, backlight, and the L6481L driver pinout. |
| [`DockingStation/`](DockingStation/) | Components on the docking station (LT1237, DS14C535). |
| [`VL82C420/`](VL82C420/) | Datasheets for the VL82C420 chipset's integrated peripheral cores (82C37 DMA, 82C54 timer, 82C59 interrupt controller, 82C018). |
| [`16MB-RAM/`](16MB-RAM/) | RAM chip datasheet (HM51W1788) used on the 16MB memory module. |

## Notable parts

- **CPU:** Intel i486SX-33 (`bottom/4-486SX-33.pdf`), with bond/die and BGA ball-map diagrams.
- **Chipset:** VL82C420 single-chip AT controller (`bottom/3-VL82C420.pdf`).
- **Video:** Chips & Technologies 65535 LCD/CRT controller (`bottom/2-CHIPS65535.pdf`).
- **Sound:** Yamaha YM3812 (OPL2) with Y3014 DAC (`top/7-YM3812.pdf`, `bottom/9-Y3014.pdf`).
- **I/O:** SMC FDC37C665IR super-I/O controller (`top/5-FDC37C665IR.pdf`).
- **Flash/BIOS:** Intel 28F002 / 28F200BX flash (`bottom/7-28F200BX-TB.PDF`).
- **IrDA:** HP HSDL-1000 infrared transceiver (`top/HSDL-1000.PDF`).

## Connector references

Connector pinouts are kept alongside the boards they belong to: RAM, LCD, docking, and power connectors in `top/`; the modem and scanner connectors in `Modem/`.

## Naming conventions

- Numeric prefixes (e.g. `4-486SX-33.pdf`, `2-CHIPS65535.pdf`) correspond to the part reference numbers marked on the board diagrams (`top-parts.tif`, `bottom-parts-complete.tif`).
- Single-letter prefixes (e.g. `a-sn74ls123.pdf`, `b-v74.pdf`) mark smaller logic/glue parts.
- Files in `generic/` are named by their SMD marking code; the folder README contains the code-to-part-number lookup table.
