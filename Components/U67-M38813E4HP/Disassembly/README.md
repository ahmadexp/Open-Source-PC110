# U67 M38813M4 Firmware Analysis

- **Device role:** U67 is best interpreted as the PC110 keyboard-controller microcontroller, not the main PC BIOS.
- **Schematic identity:** U67 is labeled `M38813M4` and is connected to keyboard matrix nets, host data/control lines, LED/speaker signals, reset, clock, and auxiliary serial/interruption-style lines.
- **Firmware banner:** The binary contains the embedded string:

  ```text
  MELPS 740 Series Keyboard Firmware Version 1.1(C) Copyright 1992-1995 RIOS Systems Co.,Ltd.
  ```

- **Instruction family:** The code was disassembled as Mitsubishi / Renesas MELPS 740-family code.
- **Binary size:** 16,255 bytes, or `0x3F7F`.
- **Inferred ROM mapping:** `$C081..$FFFF`, top-aligned to the 64 KiB address space.
- **Reset vector:** `$FFFC -> $C208`.
- **Timer-Y vector:** `$FFF0 -> $C0DB`.
- **SIO1 receive vector:** `$FFF6 -> $D088`.
- **Default interrupt stub:** Most unused vectors point to `$E62C`, which decodes as a default `BRK, BRK, RTI` style stub followed by erased padding.
- **Important oddity:** `$C0DB-$C0DC` is both the final two ASCII bytes of the banner, `d.`, and valid code bytes for the Timer-Y ISR entry, `tst PCTL1`.

## File integrity

| File | Size | SHA-256 |
|---|---:|---|
| `M38813E4HP@QFP64.bin` | 16,255 bytes | `b29761a2fd39abd9c9419ca73b03beb6c41bc52102e2a7429d1f023f82a2a2b8` |
| `PC110-Singlesheet-Schematic.pdf` | 7,259,077 bytes | `4c1b041feb1c0b7703f2a5c3fbd88e0aaed0157725ed00aebb2dbf98ca702194` |
| `U67_M38813_commented.asm` | 156,426 bytes | `73c3ed96350c602a3fb31a71d95d069a7e22713557ed0570d13f3daf7c8ad655` |
| `U67_M38813_firmware_facts.pdf` | 359,081 bytes | `ca71ee80e6e28277e9ed61873fcbbb9d4fe956233f06396737760babc4b4d33b` |

To verify locally:

```sh
sha256sum M38813E4HP@QFP64.bin PC110-Singlesheet-Schematic.pdf U67_M38813_commented.asm U67_M38813_firmware_facts.pdf
```

## How to read the assembly

The commented assembly is a static disassembly, not recovered vendor source code.

Conventions used in `U67_M38813_commented.asm`:

- `.org $C081` marks the inferred mapped start address of the dumped ROM image.
- `RESET_C208`, `TIMER_Y_ISR_C0DB`, and similar names identify vector targets or high-confidence entry points.
- `SUB_xxxx` labels are auto-generated function labels for direct call targets.
- `L_xxxx` labels are local branch targets.
- Comments marked `INFERRED` are based on static analysis and schematic correlation, not source symbols.
- SFR aliases such as `DBB0`, `DBB1`, `DBBSTS0`, `DBBSTS1`, `DBBCON`, `SIO1STS`, and `TB_RB` use nearby 740-family public documentation as a reference model.
- `.byte` regions are intentionally preserved where the bytes may be inline tables, computed-dispatch data, mixed code/data, or unreachable code.

## Interpreted firmware behavior

### Keyboard matrix scanning

The schematic places U67 on keyboard matrix-style nets, including `KB1_*` and `KB2_*`. The firmware uses port and RAM state heavily and has timer-driven paths, which is consistent with keyboard scan scheduling and debounce behavior.

### Host keyboard-controller interface

U67 has DQ-style data pins and control pins connected to host bus signals such as `SD0..SD7`, `IOR#`, `IOW#`, `KBCCS#`, and `SA2`. The firmware repeatedly accesses double-bus interface registers, including `DBB0`, `DBB1`, `DBBSTS0`, `DBBSTS1`, and `DBBCON`. This is the strongest static evidence that the firmware participates in host-visible keyboard-controller traffic.

### Auxiliary serial path

The active SIO1 receive vector points to a routine that reads `SIO1STS` and `TB_RB`. Combined with schematic labels such as `KB_RXD`, `KB_TXD`, `KB_IRQ1`, `KB_IRQ12`, and nearby pointing-device style signals, this suggests an auxiliary serial input path. Static analysis alone does not prove the higher-layer protocol.

### LEDs and speaker

The schematic maps U67 pins to `KB_NUMLED#`, `KB_CAPLED#`, `KB_SCRLED#`, `KB_PADLED#`, `KB_SPKUP`, and `KB_SPKDN`. The firmware likely implements host commands that affect keyboard LEDs, pad LED state, and speaker or keyclick behavior.

## Practical repair and debug checkpoints

For a faulty PC110 motherboard where U67 is suspected:

1. Verify U67 power, ground, and reset:
   - VCC present at U67.
   - `CNVSS` held low for normal single-chip operation.
   - `KB_RESET#` releases cleanly.

2. Verify the U67 clock:
   - Check the 4.00 MHz crystal path around X5 and U67 `Xin` / `Xout`.

3. Verify host interface activity:
   - Probe `KBCCS#`, `IOR#`, `IOW#`, `SA2`, and `SD0..SD7` during host keyboard-controller I/O cycles.
   - If these lines are active but U67 does not respond, focus on U67 reset, clock, and DQ/control pin continuity.

4. Verify keyboard matrix activity:
   - Probe the `KB1_*` and `KB2_*` nets.
   - If host traffic works but no key events appear, the matrix side, flex, connector, or scan pins may be failing.

5. Verify LED and speaker outputs:
   - Probe `KB_NUMLED#`, `KB_CAPLED#`, `KB_SCRLED#`, `KB_PADLED#`, `KB_SPKUP`, and `KB_SPKDN` when toggling host commands.

6. Verify auxiliary input path:
   - Probe `KB_RXD`, `KB_TXD`, `KB_IRQ1`, `KB_IRQ12`, `D171_GPDATA`, and `D171_GPCLK` if trackpoint, pointing-device, or auxiliary keyboard behavior is suspect.

## Suggested next reverse-engineering steps

- Obtain the original M38813M4 hardware manual or mask-ROM documentation if possible.
- Build an emulator harness for the 740 core and stub the M38813 SFRs, especially DBB and SIO1.
- Instrument live hardware for reset, timer interrupt cadence, DBB transactions, and SIO1 receive events.
- Recover the key matrix by correlating U67 pin labels with physical keyboard rows and columns.
- Create named command handlers by tracing host writes to `DBB0` / `DBB1` and comparing responses.
- Compare this firmware with other RIOS Systems keyboard-controller ROMs from the same 1992-1995 period, if dumps can be found.

## Limitations

- This is a static pass. It does not prove all runtime paths.
- The original M38813 manual was not available during this analysis. Some SFR and vector names are mapped from nearby 740-family documentation.
- The dump is one byte shorter than a nominal 16 KiB `$C080..$FFFF` window. Top alignment to `$C081..$FFFF` is strongly supported by the vector table, but the missing leading byte remains unknown.
- Several regions include code/data overlap, computed dispatch, or inline tables. These are deliberately left as bytes rather than forced into unreliable labels.
- Label names are analysis aids, not official source names.

## Recommended citation in notes

When referring to this analysis, cite it as:

```text
U67 M38813M4 firmware static analysis for IBM PC110 motherboard, based on M38813E4HP@QFP64.bin and PC110-Singlesheet-Schematic.pdf.
```
