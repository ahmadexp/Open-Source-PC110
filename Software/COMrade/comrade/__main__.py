"""
comrade entry point - MCP stdio server bridged to a DOS serial agent.

Real hardware (DOS box on a serial cable / USB-serial):
    python3 -m comrade --serial /dev/ttyUSB0 --baud 115200
QEMU (guest COM port bridged to a host socket):
    python3 -m comrade --tcp 127.0.0.1:7777

Register with Claude Code:
    claude mcp add comrade -- python3 -m comrade --serial /dev/ttyUSB0
"""

from __future__ import annotations

import argparse
import logging
import sys

from . import server


def main() -> int:
    ap = argparse.ArgumentParser(description="MCP bridge to a serial MS-DOS agent")
    g = ap.add_mutually_exclusive_group()
    g.add_argument("--serial", metavar="DEVICE",
                   help="serial device to the DOS box, e.g. /dev/ttyUSB0 or COM3")
    g.add_argument("--tcp", metavar="HOST:PORT",
                   help="TCP socket carrying the serial stream (QEMU -serial tcp:...)")
    ap.add_argument("--baud", type=int, default=115200, help="serial baud (default 115200)")
    ap.add_argument("--op-timeout", type=float, default=8.0)
    ap.add_argument("--chunk-max", type=int, default=1024)
    ap.add_argument("--log-level", default="INFO")
    args = ap.parse_args()

    logging.basicConfig(level=getattr(logging, args.log_level.upper(), logging.INFO),
                        stream=sys.stderr,
                        format="%(asctime)s %(name)s %(levelname)s %(message)s")

    if args.tcp:
        host, port = args.tcp.rsplit(":", 1)
        server.CONFIG.update(transport="tcp", host=host, port=int(port))
    else:
        server.CONFIG.update(transport="serial",
                             device=args.serial or "/dev/ttyUSB0", baud=args.baud)
    server.CONFIG.update(op_timeout=args.op_timeout, chunk_max=args.chunk_max)

    server.mcp.run(transport="stdio")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
