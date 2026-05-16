# PC110 BIOS image inspection

Uploaded file: E28F002BXT@TSOP40.BIN
Installed as: Roms/pc110_bios.bin

Size: 262144 bytes / 256 KiB
MD5: 6de4281a58509438a2773365ba6b1371
SHA-256: 232101c88466f311bcc32fbc215a4d7569f695ce19f9c07ca67ce2aee5232312

Top-of-ROM reset vector bytes at offset 0x3FFF0:
EA 5B E0 00 F0 31 31 2F 30 38 2F 39 35 00 FC B0

Decoded first reset instruction:
EA 5B E0 00 F0  =>  JMP FAR F000:E05B

With a 256 KiB ROM mapped at the top of the 1 MiB BIOS region:
- ROM low base: 0x000C0000
- Conventional reset-vector address: 0x000FFFF0
- 486 reset alias address: 0xFFFFFFF0
- Target F000:E05B linear address: 0x000FE05B
- Target offset inside ROM image: 0x3E05B

Selected ASCII strings found:
- 0x00006: 09/19/95'(C) Copyright IBM Corp. 1994, All Rights Reserved.
- 0x2001E: IBM VGA Compatible BIOS. 4
- 0x2008B: a8Chips 65535 VGA 32KB BIOS
- 0x200A8: Version 2.0.2
- 0x2012B: Copyright (C) 1994 Chips and Technologies, Inc.  All Rights Reserved.
- 0x21FDF: %$&U&CHIPS 65535 Flat Panel VGA
- 0x2901E: APM BIOS 1.00.27
- 0x29030: (C) COPYRIGHT RIOS SYSTEMS, 1993, 1994. ALL RIGHTS RESERVED.
- 0x30000: 39H4551 (C) COPYRIGHT IBM CORPORATION 1981, 1995 ALL RIGHTS RESERVED 11/08/953
- 0x3713C: IBM Corp.
- 0x3E000:         COPR. IBM 1981, 1995

ROM signature offsets where bytes 55 AA appear on 16-byte boundaries:
- 0x00000
- 0x20000
- 0x26F90
- 0x27B20
- 0x28750
- 0x2E740
- 0x35FC0
