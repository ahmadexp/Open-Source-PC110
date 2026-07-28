# Software

DOS tools for the IBM PalmTop PC110, plus the host-side bridge used to drive one over a serial link.
All are small, dependency-free real-mode `.COM` programs (except COMrade, which runs on the host),
hand-written in assembly and built with NASM.

| Tool | What it is |
|---|---|
| **[PS2TUI](PS2TUI/)** | Full-screen text-UI **system manager** — replaces IBM's cryptic `PS2.EXE` switches with a two-level menu, reads live battery/settings natively (APM + CMOS), and adds ROM/CMOS dumps, hardware diagnostics, system tests, and the BIOS-flash features. |
| **[PS2GUI](PS2GUI/)** | A **graphical** fork of PS2TUI that reproduces IBM's *Easy-Setup* skin in VGA mode 12h — icon grid, exact palette, mouse support with the authentic duck cursor. Same engine and features. |
| **[SCAMPRD2](SCAMPRD2/)** | **Read-only** chipset probe: dumps the VL82C420 EC/ED config window (`0x00–0x0F`) + a Pluto strap byte. This is how a PC110's **installed RAM module is identified** (`eced[0x03]`). Produced the live data behind `Discovery/RAM-Module` §7.4. |
| **[FNTEST](FNTEST/)** | **Read-only** raw-scancode monitor (`INT 9` hook). Built to settle empirically whether pressing **`Fn`** produces anything the host can see — see `Discovery/Keyboard` §6.4. |
| **[COMrade](COMrade/)** | Host-side **serial bridge / MCP server** to a resident DOS agent on the PC110: screen and console capture, keystroke injection, file transfer with CRC verification, and memory/I-O access. Used for most of the live reverse-engineering in `Discovery`. |

## Related

BIOS-patching tools live under [`Mods/`](../Mods/) rather than here, because they carry the
brick-risk warnings and the hardware prerequisites:

- **[`Mods/BIOS-Multi-Patcher`](../Mods/BIOS-Multi-Patcher/)** — `PCPATCH.COM`, one menu for every known
  BIOS mod (DSTN↔TFT, Windows 256-colour, 32 MB memory patch enable/remove) plus a **read-only
  diagnosis** of which patches a machine currently has.
- **[`Mods/32MB-Memory-BIOS-Patch`](../Mods/32MB-Memory-BIOS-Patch/)** — the standalone 17-byte
  memory-cap patch and a reproducible builder.
- **[`Mods/TFT/bios-patch`](../Mods/TFT/bios-patch/)** — the reproducible DSTN→TFT video-BIOS patch.

> ⚠️ Anything that **writes** the BIOS flash needs A/C **and** a battery ≥ 20 % installed, **and** a boot
> from a floppy in an IBM-marked drive (the 12 V VPP interlock). See
> [`Discovery/BIOS-Flash`](../Discovery/BIOS-Flash/readme.md) §7. The read-only tools above have no such
> requirement.
