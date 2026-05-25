# IBM PC110 U6 M38223E4HP Firmware Disassembly

U6 is interpreted as the PC110 supervisory microcontroller for power-sense, LCD-related service, serial paths, and the resistive signature-pad interface. The firmware banner identifies the ROM as:

```text
M3822X POWER SENSE MICON FIRMWARE Rev 8 (C) 1995 RIOS SYSTEMS CO.,LTD.
```

## ROM metadata

| Field | Value |
|---|---|
| Input binary | `M38223E4HP@QFP80.BIN` |
| SHA-256 | `96c6e37cfa52f30b303db70c2036cbf21e6e1bb638c5eb11343ab161db3c9cc0` |
| Size | 16,254 bytes, `0x3F7E` |
| ROM mapping | File offset 0 maps to `$C080`; final byte maps to `$FFFD` |
| Reset vector | `$FFFC/$FFFD -> $E6B1` |
| ASCII banner | Starts at `$C080` |
| First executable stub | Starts at `$C0C6` |
| CPU family | Mitsubishi/Renesas 740-family core used by the M3822 group |

## High-level interpretation

The firmware appears to implement several U6 roles:

- **Power and reset supervision**: power-sense state logic, reset fallback paths, PWRGD-related handling, and periodic service routines.
- **LCD support**: LCD RAM and COM/SEG/VL/VREF related register use.
- **ADC service**: shared ADC interrupt handling for touch and other analog/power-sense channels.
- **Serial I/O**: transmit and receive interrupt handlers with RAM buffering.
- **Resistive signature-pad acquisition**: alternating drive of the X/Y rails, ADC sampling of the opposite rail, coordinate filtering, and packet delivery to the Bowman/ASIC side.

## Touch-pad hardware mapping

The touch-pad path is the highest-confidence part of the analysis because the pin mapping, ADC channel selection, and code behavior agree.

| Signal | Interpreted function |
|---|---|
| `P1.0 / P10` | `Touch_Y-` to GND switch, active high |
| `P1.1 / P11` | `Touch_Y+` to VCC/PWR switch, active low |
| `P1.2 / P12` | `Touch_X-` to GND switch, active high |
| `P1.3 / P13` | `Touch_X+` to VCC/PWR switch, active low |
| `P6.5 / AN5` | Second-phase touch analog readback |
| `P6.6 / AN6` | First-phase touch analog readback |
| `P0.0-P0.7` | Byte-wide data bus toward Bowman/ASIC |
| `P1.5` | Byte strobe toward Bowman/ASIC |

## Touch acquisition flow

The firmware alternates between the two resistive axes:

1. Drive the X rail by setting `P1.2` high and clearing `P1.3`.
2. Select ADC channel `AN6 / P6.6`.
3. Discard eight ADC conversions for settling.
4. Store the first-axis raw sample.
5. Drive the Y rail by setting `P1.0` high and clearing `P1.1`.
6. Select ADC channel `AN5 / P6.5`.
7. Discard eight ADC conversions for settling.
8. Normalize and filter the coordinates.
9. Pack a three-byte packet in `$D5-$D7`.
10. Transmit packet bytes over `P0` with a `P1.5` strobe when requested by `INT1`.

## Key RAM variables

| Address | Meaning |
|---|---|
| `$80` | `ADC_State` |
| `$81` | `ADC_Global_State`; bit 5 is touch X phase, bit 6 is touch Y phase |
| `$CE` | First-axis normalized coordinate, likely X |
| `$CF` | Second-axis normalized coordinate, likely Y, inverted |
| `$D0` | Raw first-axis sample during touch processing |
| `$D1/$D2` | Previous accepted coordinate baseline |
| `$D3` | Touch control/state flags |
| `$D5` | Touch packet header/status |
| `$D6` | X low 7 bits |
| `$D7` | Y low 7 bits |
| `$D8` | Packet transmit countdown |
| `$D9` | Packet byte index |
| `$DA` | ADC settle countdown |

## Important routine map

| Address | Label | Role |
|---|---|---|
| `$C080` | `firmware_banner` | ROM banner string |
| `$C0C6` | `post_banner_startup` | Executable stub after banner |
| `$C0D8` | `main_service_loop` | Main polling/service loop |
| `$CD17` | `state_dispatch` | Power/mode state-machine dispatcher |
| `$D612` | `isr_adc_complete` | ADC completion interrupt and ADC-state dispatch |
| `$D7CD` | `adc_start_channel_vref` | Starts ADC conversion with VREF enabled |
| `$D849` | `touch_setup_x_phase_drive_x_read_an6` | Drives X rail and reads `AN6 / P6.6` after settling |
| `$D862` | `touch_setup_y_phase_drive_y_read_an5` | Drives Y rail and reads `AN5 / P6.5` after settling |
| `$D877` | `touch_x_adc_tick` | Handles first-axis ADC settling and final sample |
| `$D897` | `touch_y_adc_tick` | Handles second-axis ADC settling, normalization, and filtering |
| `$DB94` | `touch_gate_validate_and_pack` | Gates touch packet generation |
| `$DBD6` | `touch_pack_coordinate_packet` | Builds the three-byte touch packet |
| `$DC61` | `isr_bowman_touch_request` | INT1 handler for Bowman/ASIC byte requests |
| `$DC6F` | `bowman_touch_tx_next_byte` | Writes packet byte to `P0` and pulses `P1.5` |
| `$D8D4` | `isr_timer_y_scheduler` | Main periodic scheduler |
| `$E2AA` | `isr_serial_tx` | Serial transmit interrupt |
| `$E2CF` | `isr_serial_rx` | Serial receive interrupt |
| `$E307` | `isr_timer3_p4_sampler` | Timer 3 P4.0 sampling/history path |
| `$E6B1` | `reset_entry` | Reset vector target and MCU initialization |
| `$E8FC` | `isr_unused_default` | Default/unused interrupt target |

## Vector table summary

| Vector | Target | Current interpretation |
|---|---:|---|
| `BRK` | `$E8FC` | Unused/default |
| `ADT_ADC` | `$D612` | ADC completion interrupt |
| `KEY_WAKEUP` | `$E8FC` | Unused/default |
| `INT3` | `$D190` | External interrupt 3 |
| `INT2` | `$D177` | External interrupt 2 |
| `TIMER1` | `$E8FC` | Unused/default |
| `CNTR1` | `$E8FC` | Unused/default |
| `CNTR0` | `$E8FC` | Unused/default |
| `TIMER3` | `$E307` | P4.0 sampling/history path |
| `TIMER2` | `$E366` | Periodic service |
| `TIMER_Y` | `$D8D4` | Main periodic scheduler |
| `TIMER_X` | `$E8FC` | Unused/default |
| `SERIAL_TX` | `$E2AA` | Serial transmit |
| `SERIAL_RX` | `$E2CF` | Serial receive |
| `INT1` | `$DC61` | Bowman/ASIC touch-byte request |
| `INT0` | `$D1AF` | External power/LCD related path |
| `RESET` | `$E6B1` | Reset entry |

## Packet format notes

The current interpretation is that the touch packet is three bytes:

| Byte | Source | Interpretation |
|---|---|---|
| `$D5` | Header/status | Valid/status bits plus high bits from X/Y |
| `$D6` | X payload | X low 7 bits |
| `$D7` | Y payload | Y low 7 bits |

At `touch_pack_coordinate_packet`, the high bit of each coordinate is shifted into the header, while the low 7 bits are stored in `$D6` and `$D7`. `bowman_touch_tx_next_byte` then writes the selected byte to `P0` and pulses `P1.5`.

## Known anomaly to verify

The uploaded binary contains bytes `3C 03 D0` at `$DBFE`, decoded as:

```asm
LDM #$03,$D0
```

In a previous disassembly effort the equivalent point as a write to `$D8`, which would match the packet transmit countdown used at `$DC6F`. Because the uploaded binary is treated as authoritative, the cleaned ASM preserves the uploaded bytes and flags this as a hardware-validation target.

## Suggested hardware validation

Recommended probes while drawing on the pad:

- `P1.0-P1.3`: confirm resistive-axis drive phases.
- `P6.5 / AN5` and `P6.6 / AN6`: log raw ADC values at known pad corners.
- `INT1`: confirm Bowman/ASIC byte request behavior.
- `P0.0-P0.7`: capture packet bytes.
- `P1.5`: capture packet-byte strobe.
- `PWRGD`, `RESET`, and LCD `COM/SEG` pins: correlate power/LCD state transitions with firmware behavior.

Validation questions:

1. Does the `$DBFE` path arm `$D8` elsewhere, or is the uploaded ROM using a different packet/countdown convention?
2. Do `$CE` and `$CF` correspond physically to X and Y after coordinate inversion?
3. Is the eight-conversion ADC settling cadence visible on the analog nodes?
4. Do `D5/D6/D7` decode to expected physical motion over the pad?
5. Do touch enable/disable states track power and LCD state changes?

## Limitations

- This is a static reverse-engineering pass, not an emulator trace or live hardware trace.
- Some computed jumps, RAM state bits, and table boundaries remain provisional.
- The older HTML pass was used only as advisory context; the uploaded ROM bytes are treated as authoritative.
- Axis naming is inferred. Physical corner tests should confirm final X/Y orientation.
- Some untraced regions may be data tables decoded as instructions.


## Provenance

The cleaned ASM was generated from the uploaded ROM image and is intended to keep every decoded ROM byte visible while improving comment quality around reset, ADC, touch, serial, LCD, and vector paths. The PDF is a readable engineering description and should be treated as a companion to the ASM rather than a formal proof.
