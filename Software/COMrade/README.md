# COMrade

COMrade is the serial control bridge for the IBM PC110. It lets a modern host
inspect and drive a PC110 running DOS, or a Windows 95 installation running the
Win32 companion agent.

This PC110 copy includes the upstream COMrade sources plus the PC110-tested
prebuilt agents:

- `dist/COMRADE.EXE` is the DOS TSR for a PC110 or other real-mode DOS box.
- `dist/COMR95.EXE` is the Windows 95 Win32 agent.
- `comrade/` is the Python MCP bridge.
- `doc/PROTOCOL.md` describes the serial wire protocol.

The project started as [yyzkevin/COMrade](https://github.com/yyzkevin/COMrade),
with the Win95 agent and PC110 integration maintained here alongside the other
PC110 software.

## Windows 95

Place `COMR95.EXE` on the Windows 95 machine and run:

```text
COMR95 /com1 /baud 115200
```

The agent provides serial HELLO/status, the text screen, a small GDI desktop
thumbnail, file read/write, directory listing, DOS attributes, CRC-32 hashing,
and keyboard injection. The host bridge exposes the desktop thumbnail through
`desktop_screenshot`.

## DOS

Load the TSR from `AUTOEXEC.BAT` or a DOS prompt:

```text
COMRADE /com1 /baud 115200
```

The DOS agent additionally supports real-mode memory access, port I/O, raw
keyboard injection, console capture, and PC110 hardware bring-up probes.

## Host bridge

From this directory, install the bridge and connect it to a USB serial adapter:

```bash
python3 -m venv .venv
.venv/bin/pip install -e .
.venv/bin/python -m comrade --serial /dev/ttyUSB0 --baud 115200
```

For a remote serial adapter, use `tools/pi-relay.py` or a raw serial-to-TCP
relay and start the bridge with `--tcp HOST:PORT`.

## Builds

The DOS build needs Open Watcom:

```bash
. ./env.sh
./build.sh
```

The Win95 build prefers Open Watcom's Win32 target and falls back to a 32-bit
MinGW build with the C runtime removed so it imports only Win95-era system
DLLs:

```bash
./build-win95.sh
```

The Python protocol tests can be run with:

```bash
.venv/bin/pytest tests/
```

COMrade is MIT licensed; see `COMRADE-LICENSE.txt`. The surrounding PC110
repository retains its own project license.
