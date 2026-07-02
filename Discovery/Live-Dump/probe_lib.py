"""PC110 live-discovery helper over COMrade (ser2net TCP bridge).

Read-only by default. Connects to the real IBM PC110 palmtop, probes chipset
I/O ports, dumps memory regions, and collects DOS/software inventory.
"""
import asyncio
import sys
import json
import os

# Point these at your setup (env vars override the defaults):
#   COMRADE_PATH  path to a checkout of the COMrade client (github.com/ahmadexp)
#   PC110_HOST    host running the ser2net serial bridge (or the box directly)
#   PC110_PORT    TCP port the bridge exposes
#   PC110_OUT     directory to write dumps into
sys.path.insert(0, os.environ.get("COMRADE_PATH", os.path.expanduser("~/git/COMrade")))
from comrade.connection import ConnectionManager
from comrade.protocol import DosError

HOST = os.environ.get("PC110_HOST", "192.168.10.183")
PORT = int(os.environ.get("PC110_PORT", "2010"))
OUT = os.environ.get("PC110_OUT", os.path.join(os.path.dirname(__file__), "raw"))
os.makedirs(OUT, exist_ok=True)


async def connect(timeout=40):
    cm = ConnectionManager(op_timeout=20)
    await cm.start(lambda: asyncio.open_connection(HOST, PORT))
    for _ in range(timeout * 2):
        if cm.status()["connected"]:
            return cm
        await asyncio.sleep(0.5)
    raise TimeoutError("PC110 not connected via COMrade")


async def safe_in(cm, port, width=1):
    try:
        return await cm.io_in(port, width)
    except Exception as e:
        return f"ERR:{e}"


async def indexed_dump(cm, idx_port, data_port, indexes, restore=None):
    """out idx_port,i ; in data_port -> value, for each i. Restore index after."""
    out = {}
    for i in indexes:
        try:
            await cm.io_out(idx_port, i)
            v = await cm.io_in(data_port)
            out[i] = v
        except Exception as e:
            out[i] = f"ERR:{e}"
    if restore is not None:
        try:
            await cm.io_out(idx_port, restore)
        except Exception:
            pass
    return out
