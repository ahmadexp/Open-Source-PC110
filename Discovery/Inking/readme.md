# Inking / signature pad — the PC110 digitizer, reverse-engineered

The IBM PC110 has a **resistive inking pad** (a pen/handwriting/signature digitizer)
distinct from the trackpad. It is what the Japanese handwriting stack (`INKDRV.COM`,
the `IBMSMALL.DCT` / `$USRDICT.DCT` dictionaries seen in the [Live-Dump](../Live-Dump/))
draws on. Easy-Setup exposes it as **`PS2 ADDINKing`** (I/O base `15E0|25E0|35E0`) and
**`PS2 IRQINKing`** (`5|10`); the factory `D:\CONFIG.SYS` sets it up with
`RMUDOSAT.SYS /IX=5,10 /PX=15E0-15EF,35E0-35EF` (note `IX=5,10` == the two `IRQINKing`
options). See [PS2 §4](../PS2/README.md).

Physically the pad is a resistive touch panel read by the **M38223 "power-sense" MCU**
(`touch panel on P1/P6 ADC`, see [`Components/Flash/M38223E4HP`](../../Components/Flash/M38223E4HP/)),
which strobes digitized samples over a byte bus to the **Bowman** ASIC; Bowman presents
them to the CPU at the inking I/O window.

## Where it lives (this unit)

Read live over [COMrade](../../) (2026-07): CMOS `0x68` low-2 bits select the base from
`{15E0, 25E0, 35E0}`; here it is **`0x15E0`** (the `0x35E0` window reads all-`FF`).
Idle window at `0x15E0`: `00 FF C0 FF FF FF FF FF 00 FF FF FF 40 FF 80 00`, so control
(`base+2`) idles at `0xC0`, status (`base+1`) at `0xFF`. Config is persisted in CMOS
`0x68..0x6F` (standard bank via `0x70/0x71`; the driver uses the `0x74/0x76` extended
bank only for indices with bit7 set).

## Register model (base = 0x15E0)

| Port | Dir | Meaning |
|------|-----|---------|
| `base+0` (`15E0`) | R | data byte (one byte of a 3-byte packet) |
| `base+1` (`15E1`) | R | status; **bit7 = a data byte is waiting** |
| `base+2` (`15E2`) | R/W | control; write `0x38` = enable reporting; pulse **bit0** to ack a byte |

**Enable → status flips.** Verified live: writing `0x38` to `base+2` changes status from
`0xFF` (disabled/floating) to `0x7F` (enabled, bit7 clear = no data). Restoring the saved
control byte disables it.

## Packet format (3 bytes)

`INKDRV.COM`'s IRQ handler reads one byte per interrupt from `base+0`, acks (`base+2`
read-modify-write: `|1` then `&~1`), and assembles **3-byte packets**:

```
byte0 = flags   (bit7 = 1, packet sync/first byte)
                 bit4 = rawX bit8
                 bit3 = rawY bit8
                 bit0 = pen-down (tip switch)
byte1 = rawX low 7 bits
byte2 = rawY low 7 bits

rawX = byte1[0..6] | (flags.bit4 << 7)      ; 0..255
rawY = byte2[0..6] | (flags.bit3 << 7)      ; 0..255
```

Only `byte0` has bit7 set, so `byte1/byte2` carry 7 bits each and the 8th bit rides in the
flags byte. `INKDRV` then maps raw → screen with a **4-point calibration** ("Touch the
left-up / right-up / left-down / right-down corner of inking pad") stored in CMOS; its
uncalibrated defaults are X range `0xF9` (249), Y range `0x81` (129), origins 0.

## Driver interface (`INKDRV.COM`, "Inking Low Level Driver v1.00, (C) 1995 RIOS Systems")

- Reads base/IRQ via the PC110 APM vendor call `INT 15h AX=5380, BX=8300` → `CL`:
  `CL & 3` indexes the base table `{05E0, 15E0, 25E0, 35E0}`; `(CL & 0x70) >> 4` indexes
  the IRQ table `{3,4,10,11,12,15,5,7}` (vector = IRQ+8, +0x60 more for the slave PIC).
- Hooks the inking IRQ vector directly (ISR at its own `+0xF8`), rings incoming bytes,
  and delivers assembled samples to an app callback registered via `INT 15h AX=5403`
  (with `5402/5407` for arbitration). Also usable through its **INT 51h** entry.
- `INKDRV /C` recalibrates; `INKDRV /R` removes.

## In PS2GUI

[`Software/PS2GUI`](../../Software/PS2GUI/) adds a **System Test → "Signature pad test"**
that drives the pad directly and polled (no driver needed): save `base+2`, enable (`0x38`),
then while status bit7 is set read `base+0` and ack, assemble packets, and draw the pen
strokes in a signing box (VGA mode 12h) with a live raw X/Y/pen/packet readout. The saved
control byte is restored on exit. This is the same window/handshake `INKDRV`/`INT 51h` use,
so it works whether or not the resident driver is loaded.

## Confidence

- ✅ **Verified**: base `0x15E0` on this unit, the `0x38` enable flipping status
  `0xFF→0x7F`, restore, and the CMOS `0x68` base selector (live over COMrade).
- ✅ **From disassembly** of the unit's `D:\INKDRV.COM`: the register handshake, the
  3-byte packet + flag-bit layout, calibration scaling, base/IRQ tables, and the
  `INT 15h 53/54xx` + `INT 51h` interfaces.
- 🟡 **Not yet hardware-confirmed by us**: live pen coordinates (needs a human touching
  the pad) — the PS2GUI test is the vehicle for that. Orientation/range may need a scale
  tweak once real strokes are observed.
