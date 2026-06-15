# PC110 Components

Reverse-engineering notes, dumps, and die-level analysis for the custom and programmable chips of the **IBM Palm Top PC110**. Each chip has its own subfolder with detailed findings; this page is the index.

## PROM Dump

Here is a list of microcontrollers used on the PC110.
You can find the binary used on them with the disassembler approach.

|Designator|Part#  |Functions           |Notes                             |
|----------|-------|--------------------|----------------------------------|
|U6        |M38223*|Power Control, Front LCD & More|[Notes](U6-M38224M6HP/)|
|U67       |M38813*|Keyboard Controller|[Notes](U67-M38813E4HP/)           |

## Die level investigation

This part is a collaboration with [John McMaster](https://siliconpr0n.org/archive/doku.php?id=ibm:pc110)

|Designator|Part#      |Functions           |Images | Notes        | Website             |
|----------|-----------|--------------------|-------|--------------|---------------------|
|U75       |D17137AGT  |Trackpoint          |[5xGD](https://drive.google.com/file/d/1EE6j3h4mEOhPfLDLAEExwAHJqD0_PFLj/view?usp=drive_link),[20xGD](https://drive.google.com/file/d/1Xc_IJKjsbYY3XHMr5j5v9E7vedCPRL-F/view?usp=drive_link),[5xWM](https://commons.wikimedia.org/wiki/File:Nec_d17137agt_mcmaster_mz_mit5x.jpg#/media/File:Nec_d17137agt_mcmaster_mz_mit5x.jpg),[20xWM](https://commons.wikimedia.org/wiki/File:Nec_d17137agt_mcmaster_mz_mit20x.jpg#/media/File:Nec_d17137agt_mcmaster_mz_mit20x.jpg)|[Notes](U75-D17137AGT/)|[Website](https://siliconpr0n.org/archive/doku.php?id=mcmaster:nec:d17137agt)|
|U35       |Pluto      |Gate Array          |[20xGD](https://drive.google.com/file/d/16nTeFpWaqCU_uP1OttQEfiKk1-7hUZvT/view?usp=drive_link),[20xMW](https://commons.wikimedia.org/wiki/File:Rios_z10s10922-00_mcmaster_mz_mit20x.jpg#/media/File:Rios_z10s10922-00_mcmaster_mz_mit20x.jpg)|[Notes](U35-Pluto/)|[Website](https://siliconpr0n.org/archive/doku.php?id=mcmaster:rios:z10s10922-00)|
|U21       |Bowman     |Gate Array          |[5xGD](https://drive.google.com/file/d/15munQB8WwZSGBSpy0LVSyx55qNzXb98V/view?usp=drive_link),[20xGD](https://drive.google.com/file/d/12qelLQHVYzxfumq-ZQlpCILzFbJNt_VQ/view?usp=drive_link),[5xMW](https://commons.wikimedia.org/wiki/File:Rios_63g33f1017_mcmaster_mz_mit5x.jpg#/media/File:Rios_63g33f1017_mcmaster_mz_mit5x.jpg),[20xWM](https://commons.wikimedia.org/wiki/File:Rios_63g33f1017_mcmaster_mz_mit20x_center.jpg#/media/File:Rios_63g33f1017_mcmaster_mz_mit20x_center.jpg)|[Notes](U21-Bowman/)|[Website](https://siliconpr0n.org/archive/doku.php?id=mcmaster:rios:63g33f1017)|
|U61       |VL82C420FC5|Chipset, RTC, DMA, Intrupt Controller, Timer             |[5xGD](https://drive.google.com/file/d/1y4FRPca-DhSshr4XKD2mkIxmg6dxaimA/view?usp=drive_link),[20xGD](https://drive.google.com/file/d/14JYFDLd_2Uh4-ClQ5DVPtTTlHIYsGfvz/view?usp=drive_link),[5xWM](https://commons.wikimedia.org/wiki/File:Rios_vl82c420fc5-c_mcmaster_mz_mit5x.jpg#/media/File:Rios_vl82c420fc5-c_mcmaster_mz_mit5x.jpg),[20xMW](https://commons.wikimedia.org/wiki/File:Rios_vl82c420fc5-c_mcmaster_mz_mit20x_wonky.jpg#/media/File:Rios_vl82c420fc5-c_mcmaster_mz_mit20x_wonky.jpg)|[Notes](U61-VL82C420FC5/)|[Website](https://siliconpr0n.org/archive/doku.php?id=mcmaster:rios:vl82c420fc5-c)|

## Flash & ROM Dumps

Raw readouts and reverse-engineering analysis of the flash, OTPROM, and mask-ROM chips found in the PC110 and its peripheral boards. Each chip has its own subfolder under [`Flash/`](Flash/) containing the raw dump (`.BIN`/`.HEX`), an analysis report, extracted strings, selected hexdumps, and — where applicable — disassembly seeded from the chip's reset/vector table. See [`Flash/README.md`](Flash/) for full details.

| Folder | Chip | Size | Role | Confidence |
|---|---|---|---|---|
| [`E28F002BXT`](Flash/E28F002BXT/) | Intel E28F002BXT (2-Mbit boot-block flash) | 256 KiB | Main/system **BIOS** (IBM VGA-compatible, APM, RIOS); x86 real-mode | Very high |
| [`OKI-MSM538032E`](Flash/OKI-MSM538032E/) | OKI / LAPIS MSM538032E (8-Mbit mask ROM) | 1 MiB | Japanese/System **font mask ROM**; first 8 KiB is a valid PC option-ROM font window | Very high |
| [`EN29F040A`](Flash/EN29F040A/) | Eon EN29F040A (4-Mbit flash) | 512 KiB | **Modem/fax board** flash (RIOS Ver 1.04, Panasonic MN195001) | High (role) |
| [`M38813E4HP`](Flash/M38813E4HP/) | Mitsubishi M38813E4HP (MELPS 740 8-bit MCU, OTPROM) | ~16 KiB | **Keyboard controller** firmware v1.1 (RIOS) — see [U67 notes](U67-M38813E4HP/) | High |
| [`M38223E4HP`](Flash/M38223E4HP/) | Mitsubishi M38223E4HP (3822-group MELPS 740 MCU) | ~16 KiB | **Power-sense** MCU firmware Rev 8 (RIOS) — see [U6 notes](U6-M38224M6HP/) | High (role) |
| [`AT29LV512`](Flash/AT29LV512/) | Atmel AT29LV512 (64-Kbit flash) | 64 KiB | **SanDisk SDP3B PCMCIA ATA FlashDisk** controller firmware (Motorola 68000) | High |

## Internal Disk Image

Images of the PC110's internal 4 MB solid-state drive, in [`Internal-Disk-Image/`](Internal-Disk-Image/):

| File | Format | Notes |
|---|---|---|
| [`Personaware.img`](Internal-Disk-Image/) | Raw disk image | Modern disk image format |
| [`Personaware.PQI`](Internal-Disk-Image/) | PowerQuest Drive Image | Captured with PowerQuest Drive Image |

