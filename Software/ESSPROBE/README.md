## ESSPROBE — identify the audio chip and dump its mixer

A ~1 KB DOS `.COM` that interrogates the PC110's audio controller and reports what silicon is fitted,
which Sound Blaster class it is emulating, and whether a mixer is decoded.

Written to answer a practical question before anyone considers swapping the chip: **is the ES488 already
being run below its capability?** (See [`Discovery/ES488`](../../Discovery/ES488/readme.md) §8–§9.)

### What it does

1. **SB DSP reset handshake** at `0x226` → expects `0xAA` (proves the chip is alive and decoded).
2. **DSP version** — command `0xE1`. `2.x` = SB 2.0 class, `3.x` = SB Pro (stereo), `4.x` = SB16.
3. **ESS chip ID** — command `0xE7`. The **first byte identifies the family**: `0x48` = ES488,
   `0x68` = ES688/ES1688.
4. **Mixer dump**, registers `0x00–0x7F` via index `0x224` / data `0x225`.

**Read-only by construction:** the DSP reset is the standard, harmless handshake; `0xE1`/`0xE7` are
query commands; and the mixer is read by writing only the **index** register — no mixer *data* byte is
ever written, so no setting is changed.

### Verified result on a real PC110 (2026-07-28)

```
DSP reset: OK (0xAA)
DSP version: 02.01   -> Sound Blaster 2.0 class
ESS chip ID (0xE7): 48 82   (first byte = family: 0x48 = ES488)
Mixer registers 0x00-0x7F : all FF
```

Interpretation, all mutually consistent:

- **`0x48` confirms an ES488-family part** — the chip self-identifies, independent of the silkscreen.
- **DSP `2.01` = Sound Blaster 2.0 mode** — mono, 8-bit. This matches the `ADDAUdio 0220` configuration
  the BIOS/`PS2.EXE` applies.
- **All-`FF` mixer reads = no SB Pro mixer decoded**, which is *expected* in SB 2.0 mode (the mixer at
  base+4/+5 arrived with SB Pro). Nothing is broken; the feature simply isn't enabled.

### Usage

```
ESSPROBE
```
If the DSP does not answer, audio is probably disabled in setup or at a different base — check
`PS2.EXE`'s `ADDAUdio` / `IRQAudio` / `DMAAudio` (exposed as menu items in
[`PS2TUI`](../PS2TUI/) / [`PS2GUI`](../PS2GUI/)).

### Build

```
nasm -f bin ESSPROBE.ASM -o ESSPROBE.COM
```
