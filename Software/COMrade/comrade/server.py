"""
server.py - the FastMCP stdio server exposing the DOS box as MCP tools.

Claude Code launches this over stdio; it opens (as a client) the serial stream
to the DOS resident agent -- a real serial port on hardware, or a TCP socket
standing in for the COM port under QEMU.  Tools map onto the control protocol:

  screen_read   -> SCREEN_GET     (current painted 80x25 screen + cursor)
  console_read  -> CONSOLE_GET    (lossless output stream, pull by seq)
  keys_send     -> KEYS_SEND      (inject keystrokes)
  file_read     -> FILE_READ      (out-of-band file read, chunked)
  file_write    -> FILE_WRITE     (out-of-band file write, chunked)
  dir_list      -> DIR_LIST       (out-of-band directory listing, continuation)
  file_stat     -> DIR_LIST       (find-first of an exact name)
  file_setattr  -> FILE_ATTR      (out-of-band get-modify-set of DOS attributes)
  run_command   -> KEYS_SEND + CONSOLE_GET poll loop
  dos_status    -> connection + HELLO info / ping

All logging is forced to stderr (stdout is the MCP JSON-RPC channel).
"""

from __future__ import annotations

import asyncio
import base64
import logging
import os
from contextlib import asynccontextmanager

from mcp.server.fastmcp import FastMCP

from . import console as console_mod
from . import keymap, protocol, screen
from .connection import ConnectionManager, port_name

log = logging.getLogger("comrade.server")

# Set by __main__ before mcp.run().
CONFIG = {"transport": "tcp", "host": "127.0.0.1", "port": 7777,
          "device": "/dev/ttyUSB0", "baud": 115200,
          "op_timeout": 8.0, "chunk_max": 1024}

# Single shared connection manager (one DOS box per bridge).
_state: dict = {"cm": None}


def _cm() -> ConnectionManager:
    cm = _state["cm"]
    if cm is None:
        raise RuntimeError("bridge not started")
    return cm


async def _open_stream():
    if CONFIG["transport"] == "tcp":
        return await asyncio.open_connection(CONFIG["host"], CONFIG["port"])
    try:
        import serial_asyncio  # pyserial-asyncio, only needed for real hardware
    except ImportError as exc:
        raise RuntimeError(
            "the --serial transport needs pyserial-asyncio: "
            "`pip install pyserial-asyncio` (or `pip install -e .`)") from exc
    dev = CONFIG["device"]
    try:
        return await serial_asyncio.open_serial_connection(
            url=dev, baudrate=CONFIG["baud"])
    except Exception as exc:  # noqa: BLE001 — surface a usable message, not a raw traceback
        raise RuntimeError(
            f"cannot open serial device {dev!r} at {CONFIG['baud']} baud: {exc}. "
            f"Check the node exists (`dmesg | grep tty`) and you are in the "
            f"`dialout` group.") from exc


@asynccontextmanager
async def _lifespan(_server: FastMCP):
    cm = ConnectionManager(op_timeout=CONFIG["op_timeout"], chunk_max=CONFIG["chunk_max"])
    await cm.start(_open_stream)
    _state["cm"] = cm
    try:
        yield {"cm": cm}
    finally:
        await cm.stop()
        _state["cm"] = None


mcp = FastMCP("comrade", lifespan=_lifespan)


@mcp.tool(name="dos_status",
          description="Connection status to the DOS box plus its HELLO info "
                      "(screen size, protocol version, machine). Includes a "
                      "round-trip ping when connected.")
async def dos_status() -> dict:
    cm = _cm()
    st = cm.status()
    if st["connected"]:
        try:
            st["rtt_ms"] = round(await cm.ping(timeout=5), 1)
        except Exception as exc:  # noqa: BLE001
            st["rtt_ms"] = None
            st["ping_error"] = str(exc)
    return st


@mcp.tool(name="screen_read",
          description="Read the current DOS text screen (the painted 80x25 "
                      "window) and cursor. Use this for full-screen / TUI "
                      "programs (editors). For scrolling command output use "
                      "console_read instead.")
async def screen_read(annotate_cursor: bool = False, include_cells: bool = False) -> dict:
    cm = _cm()
    payload = await cm.get_screen()
    view = screen.render(payload)
    return view.to_dict(include_cells=include_cells, annotate_cursor=annotate_cursor)


@mcp.tool(name="desktop_screenshot",
          description="Capture a small grayscale thumbnail of the Windows 95 desktop. "
                      "This is available when COMR95.EXE is running; DOS TSRs return "
                      "an unsupported-operation error. Set dest_path to write a PGM "
                      "image on the bridge host instead of returning base64 data.")
async def desktop_screenshot(width: int = 80, height: int = 60,
                             dest_path: str | None = None) -> dict:
    cm = _cm()
    info = await cm.get_win_screenshot(width, height)
    if info["status"] != protocol.Status.OK:
        raise protocol.DosError(info["status"], "desktop screenshot failed")
    w, h, data = info["width"], info["height"], info["data"]
    if dest_path is not None:
        target = _host_path(dest_path)
        with open(target, "wb") as fh:
            fh.write(f"P5\n{w} {h}\n255\n".encode("ascii"))
            fh.write(data)
        return {"ok": True, "path": dest_path, "width": w, "height": h,
                "format": "pgm", "bytes": len(data)}
    return {"ok": True, "width": w, "height": h, "format": "gray8",
            "data_base64": base64.b64encode(data).decode("ascii")}


@mcp.tool(name="console_read",
          description="Read newly captured console output as a lossless text "
                      "stream. Pass since=next_seq from the previous call to "
                      "get only new output (start with since=0). This captures "
                      "fast-scrolling output (compilers, DIR, build logs) that "
                      "a screen snapshot would miss.")
async def console_read(since: int = 0, max_bytes: int = 0) -> dict:
    cm = _cm()
    max_len = max_bytes if max_bytes > 0 else (cm.chunk_max or 1024)
    chunk = await cm.read_console(since, max_len)
    return console_mod.format_chunk(chunk)


# Keystrokes are injected in small, buffer-respecting batches at roughly a human
# typing rate, so we never dump more than the ~15-slot BIOS type-ahead buffer can
# hold (which silently drops keys, especially in hardware mode where INT 9 fills
# the buffer) and never outrun programs that process input per keypress. Tune via
# COMRADE_KEY_DELAY_MS (per-key ms) / COMRADE_KEY_BATCH (keys per frame).
_KEY_DELAY_MS = float(os.environ.get("COMRADE_KEY_DELAY_MS", "40"))
_KEY_BATCH = int(os.environ.get("COMRADE_KEY_BATCH", "4"))


@mcp.tool(name="keys_send",
          description="Inject keystrokes into the foreground DOS program. "
                      "Plain text is typed literally; use brace tokens for "
                      "special keys, e.g. {Enter} {Esc} {Tab} {Up} {F1} "
                      "{Ctrl+C}. Newlines map to Enter. method='bios' (default) "
                      "stuffs the BIOS type-ahead buffer (works for DOS/INT 16h "
                      "input); method='hardware' feeds raw make/break scancodes "
                      "to the keyboard controller (a real INT 9) so it also "
                      "reaches games and full-screen apps that bypass the BIOS. "
                      "Keys are paced at ~human speed in buffer-safe batches; pass "
                      "delay_ms to change the per-key rate (0 = send all at once).")
async def keys_send(keys: str, method: str = "bios",
                    delay_ms: float | None = None) -> dict:
    cm = _cm()
    d = _KEY_DELAY_MS if delay_ms is None else float(delay_ms)
    if method == "hardware":
        key_seqs = keymap.to_scancode_keys(keys)
        sent = await cm.type_scancode_keys(key_seqs, d, _KEY_BATCH)
        return {"ok": True, "method": "hardware", "keys": len(key_seqs),
                "scancodes_sent": sent, "delay_ms": d}
    pairs = keymap.parse(keys)
    sent = await cm.type_pairs(pairs, d, _KEY_BATCH)
    return {"ok": True, "method": "bios", "pairs_parsed": len(pairs),
            "pairs_injected": sent, "delay_ms": d}


@mcp.tool(name="key_down",
          description="Press and HOLD a key down (hardware injection, no release) "
                      "-- for games / held keys. key is a name like 'Up', 'Left', "
                      "'Space', 'Ctrl', or a single character. Release it with "
                      "key_up. (8042 controller; needs the box to accept cmd 0xD2.)")
async def key_down(key: str) -> dict:
    cm = _cm()
    n = await cm.send_keys_raw(keymap.key_make(key))
    return {"ok": True, "key": key, "event": "down", "scancodes_sent": n}


@mcp.tool(name="key_up",
          description="Release a key previously held with key_down (hardware "
                      "injection). key as in key_down.")
async def key_up(key: str) -> dict:
    cm = _cm()
    n = await cm.send_keys_raw(keymap.key_break(key))
    return {"ok": True, "key": key, "event": "up", "scancodes_sent": n}


# Direct disk<->disk transfers read/write the BRIDGE HOST's filesystem, so the
# model-chosen path is confined to an allow-root (default: the bridge's working
# dir; widen via COMRADE_HOST_FS_ROOT, set it to "/" to disable confinement).
_HOST_FS_ROOT = os.path.realpath(os.environ.get("COMRADE_HOST_FS_ROOT", os.getcwd()))


def _host_path(p: str, must_exist: bool = False) -> str:
    rp = os.path.realpath(p)
    try:
        inside = os.path.commonpath([_HOST_FS_ROOT, rp]) == _HOST_FS_ROOT
    except ValueError:                      # different drive / unrelated root
        inside = False
    if not inside:
        raise ValueError(f"host path {p!r} is outside the allowed root "
                         f"{_HOST_FS_ROOT!r} (set COMRADE_HOST_FS_ROOT to widen it)")
    if must_exist and not os.path.isfile(rp):
        raise ValueError(f"host file not found: {p!r}")
    return rp


@mcp.tool(name="file_read",
          description="Read a file from the DOS filesystem out-of-band (fast, no "
                      "screen capture). path is a DOS path e.g. C:\\\\SRC\\\\X.C. "
                      "By default returns CP437 text (or base64 if encoding='base64'). "
                      "Set dest_path to stream the file straight to a file on the "
                      "BRIDGE HOST instead -- bytes bypass the model context and the "
                      "transfer is verified end-to-end (CRC-32) with retry; the "
                      "result is metadata only (size, crc32, sha256), no content.")
async def file_read(path: str, offset: int = 0, length: int = -1,
                    encoding: str = "text", dest_path: str | None = None) -> dict:
    cm = _cm()
    if dest_path is not None:
        meta = await cm.read_file_to(path, _host_path(dest_path),
                                     offset, None if length < 0 else length)
        return {"ok": True, "mode": "direct", "path": path, **meta}
    data, total, eof = await cm.read_file(path, offset, length)
    if encoding == "base64":
        payload = base64.b64encode(data).decode("ascii")
    else:
        payload = data.decode("cp437")
    return {"path": path, "total_size": total, "offset": offset,
            "bytes_returned": len(data), "eof": eof,
            "encoding": encoding, "data": payload}


@mcp.tool(name="file_write",
          description="Write a file on the DOS filesystem out-of-band. "
                      "mode='overwrite' (default) or 'append'. data is CP437 text, "
                      "or base64 when encoding='base64'. Set src_path to stream a "
                      "file from the BRIDGE HOST straight to the box instead "
                      "(overwrites; bytes bypass the model context; verified "
                      "end-to-end with CRC-32 + retry); data is then ignored.")
async def file_write(path: str, data: str = "", mode: str = "overwrite",
                     encoding: str = "text", src_path: str | None = None) -> dict:
    cm = _cm()
    if src_path is not None:
        meta = await cm.write_file_from(path, _host_path(src_path, must_exist=True))
        return {"ok": True, "mode": "direct", "path": path, **meta}
    raw = base64.b64decode(data) if encoding == "base64" else data.encode("cp437")
    written = await cm.write_file(path, raw, mode)
    return {"path": path, "bytes_written": written, "ok": True, "mode": mode}


@mcp.tool(name="file_hash",
          description="Checksum a file ON THE DOS BOX (CRC-32 + length) without "
                      "transferring it -- a fast way to verify integrity or that "
                      "two copies are in sync. Returns {length, crc32, crc32_hex}. "
                      "Optionally pass host_path (a file on the bridge host): it's "
                      "hashed too and {match: bool} is returned, so you can confirm "
                      "a DOS file and a host file are byte-identical. The agent "
                      "reads the whole file in a DOS-safe window.")
async def file_hash(path: str, host_path: str | None = None) -> dict:
    cm = _cm()
    h = await cm.file_hash(path)
    if h["status"] != protocol.Status.OK:
        raise protocol.DosError(h["status"], f"file_hash failed for {path}")
    out = {"path": path, "length": h["length"], "crc32": h["crc32"],
           "crc32_hex": f"{h['crc32']:08x}"}
    if host_path is not None:
        import zlib
        with open(_host_path(host_path, must_exist=True), "rb") as fh:
            data = fh.read()
        hc = zlib.crc32(data) & 0xFFFFFFFF
        out.update(host_path=host_path, host_length=len(data), host_crc32=hc,
                   host_crc32_hex=f"{hc:08x}",
                   match=(hc == h["crc32"] and len(data) == h["length"]))
    return out


@mcp.tool(name="dir_list",
          description="List a directory on the DOS filesystem out-of-band (no "
                      "console/keystrokes). path is a DOS wildcard, e.g. "
                      "'A:\\\\*.*', 'C:\\\\DOS\\\\*.EXE', or a drive root 'C:\\\\'. "
                      "Returns entries with name, size, attributes and mtime. "
                      "Hidden, system and subdirectory entries are included.")
async def dir_list(path: str) -> dict:
    cm = _cm()
    if path.endswith("\\") or path.endswith(":"):
        path = path + "*.*"                          # 'C:\' -> 'C:\*.*'
    entries = await cm.list_dir(path)
    return {"path": path, "count": len(entries), "entries": entries}


@mcp.tool(name="file_stat",
          description="Stat a single file or directory on the DOS filesystem "
                      "out-of-band. Give an exact path (e.g. 'C:\\\\FOO.TXT'). "
                      "Returns {exists, entry:{name,size,attr,mtime,is_dir,...}}.")
async def file_stat(path: str) -> dict:
    cm = _cm()
    entries = await cm.list_dir(path)
    match = entries[0] if entries else None
    return {"path": path, "exists": match is not None, "entry": match}


@mcp.tool(name="file_setattr",
          description="Change a file's DOS attributes out-of-band (like ATTRIB). "
                      "Pass hidden/system/readonly/archive as true to set, false "
                      "to clear, or omit to leave unchanged. Returns the resulting "
                      "attributes.")
async def file_setattr(path: str, hidden: bool | None = None,
                       system: bool | None = None, readonly: bool | None = None,
                       archive: bool | None = None) -> dict:
    cm = _cm()
    attr = await cm.file_attr(path, do_set=False)        # current, to preserve unset flags

    def apply(bit, val):
        nonlocal attr
        if val is True:
            attr |= bit
        elif val is False:
            attr &= ~bit

    apply(protocol.A_HIDDEN, hidden)
    apply(protocol.A_SYSTEM, system)
    apply(protocol.A_RDONLY, readonly)
    apply(protocol.A_ARCH, archive)
    new = await cm.file_attr(path, do_set=True, attr=attr)
    return {"path": path, "attr": new,
            "is_hidden": bool(new & protocol.A_HIDDEN),
            "is_system": bool(new & protocol.A_SYSTEM),
            "is_readonly": bool(new & protocol.A_RDONLY),
            "is_archive": bool(new & protocol.A_ARCH)}


def _parse_addr(a) -> int:
    """Linear 20-bit address from an int, a 'SEG:OFF' hex string, or a hex
    string ('0xB8000' / 'B8000'). String forms are HEX; pass an int for decimal."""
    if isinstance(a, int):
        addr = a
    else:
        s = str(a).strip()
        if ":" in s:
            seg, off = s.split(":", 1)
            addr = (int(seg, 16) << 4) + int(off, 16)
        else:
            addr = int(s, 16)
    if not (0 <= addr <= 0xFFFFF):
        raise ValueError(f"address {addr:#x} out of real-mode range (0..0xFFFFF)")
    return addr


def _hexdump(data: bytes, base: int) -> str:
    """DEBUG-style hex+ASCII dump: 16 bytes/row, dash after the 8th, linear addr."""
    lines = []
    for off in range(0, len(data), 16):
        row = data[off:off + 16]
        cells = [f"{row[i]:02X}" if i < len(row) else "  " for i in range(16)]
        hexpart = " ".join(cells[:8]) + "-" + " ".join(cells[8:])
        ascii_part = "".join(chr(b) if 32 <= b < 127 else "." for b in row)
        lines.append(f"{base + off:05X}  {hexpart}  {ascii_part}")
    return "\n".join(lines)


@mcp.tool(name="mem_read",
          description="Read raw bytes from the DOS box's memory (real-mode space "
                      "0..0xFFFFF). address is a linear int (0xB8000), a SEG:OFF "
                      "hex string ('B800:0000'), or a hex string. Returns the bytes "
                      "as hex (or base64 if encoding='base64'). E.g. read the BIOS "
                      "data area, video RAM, or ROMs.")
async def mem_read(address, length: int, encoding: str = "hex") -> dict:
    cm = _cm()
    addr = _parse_addr(address)
    if not (0 < length <= 0x10000) or addr + length > 0x100000:
        raise ValueError("length must be 1..65536 and stay within 0..0xFFFFF")
    data = await cm.mem_read(addr, length)
    payload = data.hex() if encoding == "hex" else base64.b64encode(data).decode("ascii")
    return {"address": addr, "length": len(data), "encoding": encoding, "data": payload}


@mcp.tool(name="mem_write",
          description="Write raw bytes into the DOS box's memory. DANGER: this can "
                      "corrupt DOS/the agent or crash the box -- it is an unguarded "
                      "hardware/debug poke. address as in mem_read; data is hex "
                      "(or base64 if encoding='base64').")
async def mem_write(address, data: str, encoding: str = "hex") -> dict:
    cm = _cm()
    addr = _parse_addr(address)
    raw = bytes.fromhex(data) if encoding == "hex" else base64.b64decode(data)
    if addr + len(raw) > 0x100000:
        raise ValueError("write would run past 0xFFFFF")
    written = await cm.mem_write(addr, raw)
    return {"address": addr, "bytes_written": written, "ok": True}


@mcp.tool(name="mem_dump",
          description="Hex + ASCII dump of DOS memory, DEBUG 'D'-style (16 bytes "
                      "per row). address as in mem_read; length defaults to 128. "
                      "Returns {text} ready to read, plus the raw hex.")
async def mem_dump(address, length: int = 128) -> dict:
    cm = _cm()
    addr = _parse_addr(address)
    if not (0 < length <= 0x10000) or addr + length > 0x100000:
        raise ValueError("length must be 1..65536 and stay within 0..0xFFFFF")
    data = await cm.mem_read(addr, length)
    return {"address": addr, "length": len(data),
            "text": _hexdump(data, addr), "hex": data.hex()}


@mcp.tool(name="io_in",
          description="Read an I/O port (IN instruction). width 1 (byte) or 2 "
                      "(word). Returns the value. Reading some ports has side "
                      "effects -- know the hardware.")
async def io_in(port: int, width: int = 1) -> dict:
    cm = _cm()
    val = await cm.io_in(port, width)
    return {"port": port, "width": width, "value": val, "hex": f"0x{val:0{width * 2}x}",
            "name": port_name(port)}


@mcp.tool(name="io_out",
          description="Write an I/O port (OUT instruction). width 1 (byte) or 2 "
                      "(word). DANGER: writing ports reprograms hardware (PIC, "
                      "PIT, disk, video, ...) and can hang/damage the box.")
async def io_out(port: int, value: int, width: int = 1) -> dict:
    cm = _cm()
    await cm.io_out(port, value, width)
    return {"port": port, "value": value, "width": width, "ok": True,
            "name": port_name(port)}


@mcp.tool(name="bus_stim",
          description="Tight-loop bus stimulus for reverse-engineering / logic-"
                      "analyzer work: repeat one bus cycle 'count' times back-to-"
                      "back on the box from one round-trip, so the driven cycles "
                      "dominate the bus. kind: 'io'/'mem' (reads, safe) or "
                      "'io_out'/'mem_write' (writes -- pass 'value'). WRITE kinds "
                      "to deny-listed ports (see safe_policy) are refused unless "
                      "unsafe=True. max_ticks caps wall-clock (~55 ms/tick, 0=off) "
                      "so a big count can't pin the box. Blocks for the burst.")
async def bus_stim(kind: str, target: int, width: int = 1, count: int = 100000,
                   value: int = 0, unsafe: bool = False, max_ticks: int = 0) -> dict:
    cm = _cm()
    info = await cm.bus_stim(kind, target, width, count, value=value,
                             unsafe=unsafe, max_ticks=max_ticks)
    return {"kind": kind, "target": target, "hex_target": f"0x{target:x}",
            "name": port_name(target), "width": width,
            "iterations": info["iterations"], "last_value": info["last"],
            "hex_last": f"0x{info['last']:0{width * 2}x}"}


@mcp.tool(name="idx_read",
          description="Read an indexed-register bank in one round-trip: for each "
                      "index in [first, first+count), write it to idx_port then "
                      "read data_port. The safe, standard way to read the PC110's "
                      "index/data pairs (SCAMP 0x74/0x76, 0x24/0x25, RTC 0x70/71, "
                      "EC mailboxes). count 1..256. Returns bytes as hex.")
async def idx_read(idx_port: int, data_port: int, first: int = 0,
                   count: int = 256, width: int = 1) -> dict:
    cm = _cm()
    data = await cm.idx_read(idx_port, data_port, first, count, width)
    return {"idx_port": idx_port, "data_port": data_port, "first": first,
            "count": count, "width": width, "data": data.hex(),
            "name": port_name(idx_port)}


@mcp.tool(name="idx_write",
          description="Write one indexed register: out(idx_port, index); "
                      "out(data_port, value). DANGER: writing chipset config can "
                      "hang the box; deny-listed data/index ports are refused "
                      "unless unsafe=True (see safe_policy).")
async def idx_write(idx_port: int, data_port: int, index: int, value: int,
                    width: int = 1, unsafe: bool = False) -> dict:
    cm = _cm()
    await cm.idx_write(idx_port, data_port, index, value, width, unsafe=unsafe)
    return {"idx_port": idx_port, "data_port": data_port, "index": index,
            "value": value, "ok": True}


@mcp.tool(name="io_rmw",
          description="Reversible probe write: read the OLD value of a port, write "
                      "'value', and (if restore_ms>0) write the old value back "
                      "after ~restore_ms. Returns the old value. Deny-listed ports "
                      "are refused (no write) unless unsafe=True. Use to pulse a "
                      "register for the logic analyzer without leaving it changed.")
async def io_rmw(port: int, value: int, width: int = 1, restore_ms: int = 0,
                 unsafe: bool = False) -> dict:
    cm = _cm()
    old = await cm.io_rmw(port, value, width, restore_ms, unsafe=unsafe)
    return {"port": port, "name": port_name(port), "wrote": value,
            "old_value": old, "hex_old": f"0x{old:0{width * 2}x}",
            "restored": restore_ms > 0}


@mcp.tool(name="pic_snapshot",
          description="Snapshot both 8259 interrupt controllers: IRR (pending), "
                      "ISR (in-service) and IMR (masked) for master (IRQ0-7) and "
                      "slave (IRQ8-15). Read-only. Handy for 'which IRQ is active/"
                      "masked' questions.")
async def pic_snapshot() -> dict:
    cm = _cm()
    return await cm.pic_snapshot()


@mcp.tool(name="safe_policy",
          description="List the compiled-in write-guard deny-list (I/O port ranges "
                      "that scripted writes -- bus_stim/idx_write/io_rmw -- refuse "
                      "without unsafe=True). These are the PC110 ports where a "
                      "stray write can hang/reset/power-off the box.")
async def safe_policy() -> dict:
    cm = _cm()
    ranges = await cm.safe_policy()
    return {"denied_ranges": [{"lo": lo, "hi": hi,
                               "hex": f"0x{lo:X}-0x{hi:X}"} for lo, hi in ranges]}


@mcp.tool(name="config_snapshot",
          description="Dump the PC110 config surface (SCAMP 0x74/76, cfg block2 "
                      "0x24/25, CMOS, EC mailboxes, plus key status ports) to a "
                      "snapshot for diffing. Read-only. Pair two snapshots around "
                      "a change (toggle a setting, press a key) with config_diff "
                      "to attribute registers to functions.")
async def config_snapshot() -> dict:
    cm = _cm()
    return await cm.config_snapshot()


@mcp.tool(name="config_diff",
          description="Diff two config_snapshot() results (pass them as 'before' "
                      "and 'after' objects) -> only the changed registers/ports.")
async def config_diff(before: dict, after: dict) -> dict:
    return ConnectionManager.config_diff(before, after)


@mcp.tool(name="banked_dump",
          description="Dump a bank-switched memory window: for each value in "
                      "bank_values, write it to bank_port then read length bytes "
                      "at mem_addr. Returns {bank_value: hex}. (How the PC110 "
                      "kanji font ROM is read via its 0x1160 bank register.) "
                      "DANGER: writes bank_port -- know the hardware.")
async def banked_dump(bank_port: int, bank_values: list, mem_addr: int,
                      length: int, width: int = 1) -> dict:
    cm = _cm()
    return await cm.banked_dump(bank_port, bank_values, mem_addr, length, width)


@mcp.tool(name="reboot",
          description="Warm-boot the DOS box; it reloads COMRADE.EXE from "
                      "AUTOEXEC and the bridge auto-reconnects. Running programs "
                      "are lost.")
async def reboot() -> dict:
    cm = _cm()
    await cm.reboot()
    return {"ok": True, "rebooting": True,
            "note": "box is restarting; the bridge will auto-reconnect"}


async def _wait_for_reboot(cm, timeout: float):
    """After a reboot, wait for the agent to go silent then come back. Returns
    (went_down, new_machine | None)."""
    loop = asyncio.get_event_loop()
    went_down = False
    t0 = loop.time()
    while loop.time() - t0 < 12:                  # phase 1: agent stops answering
        try:
            await cm.probe(timeout=2)
            await asyncio.sleep(0.5)
        except Exception:                         # ConnectionError (drop) or timeout (silent)
            went_down = True
            break
    t1 = loop.time()
    while loop.time() - t1 < timeout:             # phase 2: agent comes back
        try:
            h = await cm.probe(timeout=3)
            if h.get("machine"):
                return went_down, h["machine"]
        except Exception:
            pass
        await asyncio.sleep(1)
    return went_down, None


@mcp.tool(name="update_agent",
          description="Push a new COMRADE.EXE to the DOS box and reboot into it. "
                      "Reads host_path (default dist/COMRADE.EXE on the bridge "
                      "host), backs up the on-disk copy to a .BAK, writes + "
                      "verifies the new binary, reboots, and waits for the new "
                      "agent to come back -- reporting old vs new version. DANGER: "
                      "a broken build leaves the box needing physical recovery "
                      "(the .BAK helps); test the build under QEMU first.")
async def update_agent(host_path: str = "dist/COMRADE.EXE",
                       dos_path: str = "C:\\COMRADE.EXE", backup: bool = True,
                       timeout: float = 90.0) -> dict:
    cm = _cm()
    with open(host_path, "rb") as f:
        new_bytes = f.read()
    old_version = (cm.hello or {}).get("machine")
    bak = None
    if backup:
        try:
            cur, _t, _e = await cm.read_file(dos_path)
            bak = dos_path.rsplit(".", 1)[0] + ".BAK"
            await cm.write_file(bak, cur)
        except Exception as exc:                  # noqa: BLE001
            bak = f"(skipped: {exc})"
    await cm.write_file(dos_path, new_bytes)
    back, _t, _e = await cm.read_file(dos_path)
    if back != new_bytes:
        raise RuntimeError("write verification failed; did NOT reboot")
    await cm.reboot()
    went_down, new_version = await _wait_for_reboot(cm, timeout)
    return {"ok": new_version is not None, "old_version": old_version,
            "new_version": new_version, "rebooted": went_down,
            "bytes_written": len(new_bytes), "backup": bak,
            "dos_path": dos_path}


def _exe_version(path: str):
    """Extract the 'COMRADE/<git-hash>' build tag embedded in a COMRADE.EXE."""
    try:
        with open(path, "rb") as f:
            data = f.read()
    except OSError:
        return None
    i = data.find(b"COMRADE/")
    if i < 0:
        return None
    end = i
    while end < len(data) and 32 <= data[end] < 127:
        end += 1
    return data[i:end].decode("ascii", "replace")


@mcp.tool(name="check_update",
          description="Is the agent running on the DOS box up to date? Compares "
                      "the version it reports in HELLO against the build version "
                      "embedded in the binary on the bridge host (default "
                      "dist/COMRADE.EXE). Returns {running, available, "
                      "update_available}. Apply with update_agent.")
async def check_update(host_path: str = "dist/COMRADE.EXE") -> dict:
    cm = _cm()
    running = (cm.hello or {}).get("machine")
    available = _exe_version(host_path)
    return {"running": running, "available": available,
            "update_available": (available is not None and running is not None
                                 and running != available),
            "host_path": host_path}


@mcp.tool(name="run_command",
          description="Type a command at the DOS prompt, run it, and return "
                      "its console output. Polls the output stream until it "
                      "goes idle or the timeout elapses. Requires a shell "
                      "prompt (COMMAND.COM) to be the foreground program.")
async def run_command(command: str, timeout: float = 30.0,
                      idle_ms: int = 700) -> dict:
    cm = _cm()
    loop = asyncio.get_event_loop()
    # Learn the current head of the capture stream (max_bytes=0 -> probe only).
    head = (await cm.read_console(0xFFFFFFFF, 0))["next_seq"]
    await cm.type_pairs(keymap.parse(command + "{Enter}"), _KEY_DELAY_MS, _KEY_BATCH)

    seq = head
    collected: list[str] = []
    overflow = False
    deadline = loop.time() + timeout
    last_change = loop.time()
    idle = False
    while loop.time() < deadline:
        await asyncio.sleep(0.2)
        # Drain everything available this round.
        got_any = False
        while True:
            chunk = await cm.read_console(seq, cm.chunk_max or 1024)
            overflow = overflow or chunk["overflow"]
            if not chunk["data"]:
                seq = chunk["next_seq"]
                break
            collected.append(console_mod.to_text(chunk["data"]))
            seq = chunk["next_seq"]
            got_any = True
        if got_any:
            last_change = loop.time()
        elif (loop.time() - last_change) * 1000 >= idle_ms:
            idle = True
            break

    return {
        "command": command,
        "idle": idle,
        "timed_out": not idle,
        "elapsed_ms": round((loop.time() - (deadline - timeout)) * 1000),
        "overflow": overflow,
        "text": "".join(collected),
    }
