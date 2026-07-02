# PS2TUI — a text-UI front-end for the PC110 `PS2.EXE`

A full-screen, keyboard-driven menu for configuring the IBM PalmTop PC110, replacing the ~50
cryptic `PS2.EXE` command-line switches with a navigable list. It does **not** re-implement any
hardware access: every change is applied by running the real IBM `PS2.EXE`, so all the actual
APM / SCAMP / power-MCU / CMOS work is done by IBM's tested tool. See the reverse-engineering of
`PS2.EXE` in [`Discovery/PS2`](../../Discovery/PS2/).

Built and **tested on real PC110 hardware** (over [COMrade](../../Discovery/Live-Dump/),
2026-07-02): rendering, navigation, the option picker, and applying settings all verified live.

```
  PS2TUI  -  IBM PalmTop PC110 System Manager

  == POWER ==
    Battery power-saving mode
    Auto-suspend after idle          +-------------------+
    Screen off after idle            | Choose value:     |
    CPU speed                 <------ | Fast              |
    Suspend when cover closes        | Medium            |
    Wake on phone ring               | Slow              |
    Reset basic settings to defaults +-------------------+
  == DISPLAY ==
    Display output
    ...
   UP/DN move   ENTER change   R revisions   ESC quit
```

## Using it

Copy `PS2TUI.COM` onto the PC110 (it is already installed at `C:\PS2TUI\PS2TUI.COM` on the unit
this was developed on) and run it:

```
PS2TUI
```

| Key | Action |
|---|---|
| ↑ / ↓ | Move between settings (category headers are skipped) |
| Enter | On a setting: open the value picker. On an action: confirm and run |
| (in picker) ↑/↓ + Enter | Choose a value → shows a confirm box → **Y** runs it, **N** cancels |
| R | Show the firmware revision manifest (`PS2 _@REVision`) |
| ESC | Quit back to DOS |

Every apply shows the exact command (e.g. `PS2 CLICK OFF`) and asks for confirmation before
running it. Dangerous items (suspend / power-off / reset-all) are marked with a leading `!`.

> ⚠️ Reassigning the **Serial port / IR / modem** or choosing **Suspend/Power-off** can drop a
> remote (COMrade) session or change power behaviour — exactly as the raw `PS2.EXE` would.

## How it works

`PS2TUI` is a ~3.5 KB DOS `.COM` written in assembly:

- A data-driven table of settings (category, label, `PS2` command word, option list) drives the
  whole UI, so adding/adjusting settings is a one-line table edit.
- Rendering is direct-to-`B800` text output; input is `INT 16h`; the child is launched with the
  DOS EXEC call (`INT 21h/4Bh`) after shrinking the memory block (`INT 21h/4Ah`).
- Applying a setting builds `PS2 <cmd> [value]` and executes `C:\PS2.EXE` with that tail.

Covered settings: PMode, POwer, LCd, SPeed, Cover, RI, DEFAULT, SCreen, VEXP, IRQAudio, DMAAudio,
IRQINKing, ADDINKing, IR, SErial, IMODEM, PMODEM, CLick, `_@Keyboard` (Speed/Response/Device),
`_@LPT`, `_@ATA`, `_@PCIC`, `_@PCCD3v`, `_@STATus`, `_@BATTery`, `_@FDDPM`, `_@REVision`, OFF,
`_@OFF`, `_@DEFAULT`.

## Building

Host (any OS with NASM) — produces the ready-to-run `.COM`:

```sh
nasm -f bin PS2TUI.ASM -o PS2TUI.COM
```

There is no linker step; the source assembles to a flat DOS `.COM`. `PS2TUI.COM` in this folder is
the prebuilt, hardware-tested binary.

*(Note: on-device compilation via the PC110's own Turbo C++ `TCC.EXE` was attempted but its DPMI
host hangs under the bare DOS boot, so the tool is built with NASM on a host instead.)*

## Files
| File | |
|---|---|
| `PS2TUI.ASM` | NASM source (data-driven; edit the `rows` table to change the menu) |
| `PS2TUI.COM` | Prebuilt DOS binary (3,453 bytes), tested on real PC110 hardware |
