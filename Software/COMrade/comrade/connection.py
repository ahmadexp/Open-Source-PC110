"""
connection.py - serial transport to the DOS resident agent.

The DOS agent is a serial TSR; we open a byte stream to it (a TCP socket when
the guest runs under QEMU with its COM port bridged to a host socket, or a real
serial port via pyserial on hardware) and speak the framed protocol.  Requests
are correlated to replies by reqId.  Unsolicited frames (reqId 0: HELLO) go to
an event cache.  A PING elicits a HELLO from the agent, which we use to probe.

All logging goes to stderr -- stdout is the MCP JSON-RPC channel.
"""

from __future__ import annotations

import asyncio
import logging

from . import protocol
from .protocol import Op, Status, DosError

log = logging.getLogger("comrade.connection")


# --- IBM PC110 I/O profile (from the Open-Source-PC110 reverse-engineering) ---
# Human-readable names for annotating io_in/io_out, and the config surface that
# config_snapshot() dumps by default. Ports are the measured/attributed set:
# keyboard & pad = Pluto (U35); FDC/UART/IDE = U22 (FDC37C665IR); PCIC = U74
# (RB5C396); config/RTC = VL82C420 (U61). See Discovery/Service-Manual 10.5.
PC110_PORTS = {
    0x0020: "PIC1 cmd", 0x0021: "PIC1 data/IMR",
    0x0022: "VL82C420 cfg unlock", 0x0023: "VL82C420 cfg data",
    0x0024: "VL82C420 cfg index(2)", 0x0025: "VL82C420 cfg data(2)",
    0x0040: "PIT ch0", 0x0043: "PIT ctrl",
    0x0060: "KBC data (Pluto)", 0x0064: "KBC cmd/status (Pluto)",
    0x0070: "RTC/CMOS index", 0x0071: "RTC/CMOS data",
    0x0074: "SCAMP cfg index", 0x0076: "SCAMP cfg data",
    0x0092: "port A (A20/fast reset)",
    0x00A0: "PIC2 cmd", 0x00A1: "PIC2 data/IMR",
    0x00EC: "VL82C420 shadow/cache/ROM cfg index", 0x00ED: "VL82C420 shadow/cache/ROM cfg data",
    0x01F0: "IDE data (U22)", 0x01F7: "IDE status (U22)",
    0x02F8: "COM2 UART (U22)",
    0x03E0: "PCIC index (U74)", 0x03E1: "PCIC data (U74)",
    0x03F2: "FDC DOR (U22)", 0x03F4: "FDC MSR (U22)", 0x03F5: "FDC data (U22)",
    0x03F8: "COM1 UART (U22)",
    0x15E0: "inking pad base (Pluto/KBC)",
    0x15E8: "EC mailbox A", 0x35E8: "EC mailbox B",
}
# Indexed register banks: name -> (index_port, data_port[, count]).
PC110_BANKS = {
    "scamp_cfg":  (0x74, 0x76, 256),   # VL82C420 SCAMP config
    "cfg_block2": (0x24, 0x25, 256),   # VL82C420 second config window
    "cmos":       (0x70, 0x71, 128),   # RTC/CMOS (0x00-0x7F)
    "ec_a":       (0x15E8, 0x15EA, 32),
    "ec_b":       (0x35EA, 0x35EB, 32),
}
# Single direct ports worth snapshotting.
PC110_PORTS_SINGLE = {
    "fdc_msr": 0x3F4, "ide_status": 0x1F7, "pcic_id": 0x3E1,
}


def port_name(port: int) -> str:
    """Friendly PC110 name for an I/O port, or '' if unknown."""
    return PC110_PORTS.get(port, "")


class ConnectionManager:
    def __init__(self, op_timeout: float = 8.0, chunk_max: int = protocol.DEFAULT_CHUNK_MAX):
        self.op_timeout = op_timeout
        self.chunk_max = chunk_max
        self._reader: asyncio.StreamReader | None = None
        self._writer: asyncio.StreamWriter | None = None
        self._reader_task: asyncio.Task | None = None
        self._framer = protocol.SerialFramer()
        self._tx_crc = None        # box's wire format: None=unknown, True=CRC-16, False=additive
        self._pending: dict[int, asyncio.Future] = {}
        self._next_req = 1
        self.connected = asyncio.Event()
        self.hello: dict | None = None
        self._open_stream = None
        self._closing = False
        self._reconnect_task: asyncio.Task | None = None

    # ------------------------------------------------------------- lifecycle

    async def start(self, open_stream):
        """Bring the link up. open_stream() -> (StreamReader, StreamWriter).

        TOLERANT: if the box/relay isn't reachable yet, this does NOT raise -- it
        logs and keeps retrying in the background, so the MCP server still starts
        and `dos_status` reports the (dis)connected state.  The link also
        auto-reconnects if it later drops.
        """
        self._open_stream = open_stream
        self._closing = False
        if not await self._connect_attempt():
            self._schedule_reconnect()

    async def _connect_attempt(self) -> bool:
        """Ensure the stream is open, then (re)probe. Returns True iff a HELLO
        came back (fully connected). Opens a fresh stream only when none is live,
        so it re-probes harmlessly when the socket is up but the box is silent
        (e.g. ser2net accepts the TCP connection before the 486 is powered)."""
        if self._reader_task is None or self._reader_task.done():
            try:
                self._reader, self._writer = await asyncio.wait_for(
                    self._open_stream(), timeout=10.0)
            except Exception as exc:  # noqa: BLE001 — unreachable box must not kill us
                log.warning("DOS link not up yet (%s)", exc)
                return False
            self._framer = protocol.SerialFramer()   # fresh framer for the new stream
            self._tx_crc = None                      # re-detect the box's format on this link
            self._reader_task = asyncio.create_task(self._reader_loop())
            log.info("serial stream open; probing the DOS agent")
        try:
            await self.probe(timeout=max(self.op_timeout, 6.0))
        except Exception as exc:  # noqa: BLE001
            log.warning("probe failed (%s); will keep trying", exc)
        return self.connected.is_set()

    def _schedule_reconnect(self):
        if self._closing or self._open_stream is None:
            return
        if self._reconnect_task is None or self._reconnect_task.done():
            self._reconnect_task = asyncio.create_task(self._reconnect_loop())

    async def _reconnect_loop(self):
        delay = 1.0
        while not self._closing and not self.connected.is_set():
            await asyncio.sleep(delay)
            delay = min(delay * 2, 15.0)
            if self._closing or self.connected.is_set():
                return
            if await self._connect_attempt():
                return

    async def stop(self):
        self._closing = True
        for task in (self._reconnect_task, self._reader_task):
            if task:
                task.cancel()
                try:
                    await task
                except (asyncio.CancelledError, Exception):  # cleanup: swallow either
                    pass
        if self._writer:
            try:
                self._writer.close()
            except Exception:
                pass

    async def _reader_loop(self):
        try:
            while True:
                data = await self._reader.read(4096)
                if not data:
                    break
                self._framer.feed(data)
                try:
                    frames = self._framer.frames()
                except Exception:  # noqa: BLE001 — a parse bug must not kill the reader
                    log.exception("frame parse error; dropping buffered input")
                    self._framer.buf.clear()
                    frames = []
                if self._framer.peer_crc is not None:    # mirror the box's wire format
                    self._tx_crc = self._framer.peer_crc
                for op, req_id, payload in frames:
                    log.debug("rx frame op=%#x reqId=%d len=%d", op, req_id, len(payload))
                    if req_id == 0:
                        self._handle_event(op, payload)
                        continue
                    fut = self._pending.pop(req_id, None)
                    if fut is None or fut.done():
                        continue
                    if op == Op.ERROR:
                        code, msg = protocol.unpack_error(payload)
                        fut.set_exception(DosError(code, msg))
                    else:
                        fut.set_result((op, payload))
        except (asyncio.CancelledError, ConnectionError, OSError):
            pass
        finally:
            self.connected.clear()
            self.hello = None
            for fut in self._pending.values():
                if not fut.done():
                    fut.set_exception(ConnectionError("serial stream closed"))
            self._pending.clear()
            self._schedule_reconnect()        # the link dropped -> try to bring it back

    def _handle_event(self, op: int, payload: bytes):
        if op == Op.HELLO:
            self.hello = protocol.unpack_hello(payload)
            if self.hello.get("chunk_max"):
                self.chunk_max = self.hello["chunk_max"]
            self.connected.set()
            log.info("HELLO: %s", self.hello)

    # ------------------------------------------------------------- request core

    def _alloc_req(self) -> int:
        for _ in range(0x10000):
            rid = self._next_req
            self._next_req = 1 if self._next_req >= 0xFFFF else self._next_req + 1
            if rid not in self._pending:
                return rid
        raise RuntimeError("no free request ids")

    def _wire(self, op: int, rid: int, payload: bytes) -> bytes:
        """Encode a frame in the box's wire format. Until we've decoded a reply
        and learned which checksum the box uses, send BOTH encodings: the box
        validates the one it understands and drops the other (different SYNC +
        trailer), so a single round-trip auto-detects the format."""
        if self._tx_crc is None:
            return (protocol.encode_serial(op, rid, payload, crc=False) +
                    protocol.encode_serial(op, rid, payload, crc=True))
        return protocol.encode_serial(op, rid, payload, crc=self._tx_crc)

    async def send_oneway(self, op: int, payload: bytes = b""):
        """Send a frame and do NOT await a reply (e.g. REBOOT, where the box
        resets before it could answer)."""
        if self._writer is None:
            raise ConnectionError("serial stream not open")
        self._writer.write(self._wire(op, self._alloc_req(), payload))
        await self._writer.drain()

    async def reboot(self):
        """Warm-boot the DOS box (it will reload COMRADE.EXE from AUTOEXEC)."""
        await self.send_oneway(Op.REBOOT)

    async def request(self, op: int, payload: bytes = b"", timeout: float | None = None):
        timeout = self.op_timeout if timeout is None else timeout
        if self._writer is None:
            raise ConnectionError("serial stream not open")
        rid = self._alloc_req()
        fut: asyncio.Future = asyncio.get_event_loop().create_future()
        self._pending[rid] = fut
        try:
            self._writer.write(self._wire(op, rid, payload))
            await self._writer.drain()
            return await asyncio.wait_for(fut, timeout=timeout)
        except asyncio.TimeoutError:
            self._pending.pop(rid, None)
            raise TimeoutError(f"DOS request op={op:#x} timed out after {timeout}s")
        finally:
            self._pending.pop(rid, None)

    async def probe(self, timeout: float | None = None) -> dict:
        op, payload = await self.request(Op.PING, b"", timeout)   # agent replies HELLO
        if op == Op.HELLO:
            self.hello = protocol.unpack_hello(payload)
            if self.hello.get("chunk_max"):
                self.chunk_max = self.hello["chunk_max"]
            self.connected.set()
        return self.hello or {}

    # ------------------------------------------------------------- high-level ops

    async def ping(self, timeout: float | None = None) -> float:
        loop = asyncio.get_event_loop()
        t0 = loop.time()
        await self.probe(timeout)
        return (loop.time() - t0) * 1000.0

    async def get_screen(self, timeout: float | None = None) -> bytes:
        _op, payload = await self.request(Op.SCREEN_GET, b"", timeout)
        return payload

    async def get_win_screenshot(self, width: int = 80, height: int = 60,
                                 timeout: float | None = None) -> dict:
        op, payload = await self.request(
            Op.WIN_SCREENSHOT, protocol.pack_win_screenshot(width, height), timeout)
        if op == Op.ERROR:
            code, msg = protocol.unpack_error(payload)
            raise DosError(code, msg or "desktop screenshot unsupported")
        return protocol.unpack_win_screenshot(payload)

    async def send_keys(self, pairs, timeout: float | None = None) -> int:
        _op, payload = await self.request(Op.KEYS_SEND, protocol.pack_keys(pairs), timeout)
        return protocol.unpack_keys_ack(payload)

    async def send_keys_raw(self, scancodes: bytes, timeout: float | None = None) -> int:
        """Inject raw make/break scancodes via the 8042 controller (hardware-level
        keystrokes that reach INT 9-hookers). Returns the byte count injected."""
        _op, payload = await self.request(
            Op.KEYS_RAW, protocol.pack_keys_raw(scancodes), timeout)
        return protocol.unpack_keys_raw_ok(payload)

    async def type_pairs(self, pairs, delay_ms: float, batch: int = 4,
                         timeout: float | None = None) -> int:
        """Inject (scancode,ascii) pairs in small batches with a per-key delay, so
        we never dump more than the ~15-slot BIOS buffer can hold at once and never
        type faster than a human. delay_ms<=0 or a short input sends in one frame."""
        pairs = list(pairs)
        if delay_ms <= 0 or len(pairs) <= batch:
            return await self.send_keys(pairs, timeout)
        total = 0
        for i in range(0, len(pairs), batch):
            grp = pairs[i:i + batch]
            total += await self.send_keys(grp, timeout)
            if i + batch < len(pairs):
                await asyncio.sleep(delay_ms * len(grp) / 1000.0)
        return total

    async def type_scancode_keys(self, key_seqs, delay_ms: float, batch: int = 4,
                                 timeout: float | None = None) -> int:
        """Hardware-inject a list of per-key make/break byte sequences, batched +
        paced like type_pairs so the BIOS buffer (filled via INT 9) is drained
        between batches instead of overflowing."""
        key_seqs = list(key_seqs)
        if delay_ms <= 0 or len(key_seqs) <= batch:
            return await self.send_keys_raw(b"".join(key_seqs), timeout)
        total = 0
        for i in range(0, len(key_seqs), batch):
            grp = key_seqs[i:i + batch]
            total += await self.send_keys_raw(b"".join(grp), timeout)
            if i + batch < len(key_seqs):
                await asyncio.sleep(delay_ms * len(grp) / 1000.0)
        return total

    async def read_console(self, since_seq: int, max_len: int | None = None,
                           timeout: float | None = None) -> dict:
        if max_len is None:
            max_len = self.chunk_max or protocol.DEFAULT_CHUNK_MAX
        _op, payload = await self.request(
            Op.CONSOLE_GET, protocol.pack_console_get(since_seq, max_len), timeout)
        return protocol.unpack_console_data(payload)

    async def _request_retry_busy(self, op, payload, timeout, tries=20):
        """Retry while the agent reports BUSY (DOS not safe for file I/O yet)."""
        for _ in range(tries):
            try:
                return await self.request(op, payload, timeout)
            except DosError as exc:
                if exc.code != Status.BUSY:
                    raise
                await asyncio.sleep(0.1)
        raise TimeoutError("DOS stayed busy (no safe window for file I/O)")

    async def _read_chunk(self, path, off, want, timeout, tries=3):
        """Fetch one FILE_READ chunk, retrying a corrupt/dropped reply. A frame
        damaged on a real serial link is rejected by the framer (-> request
        timeout) or by unpack (-> ProtocolError); FILE_READ is idempotent, so we
        simply re-request the same offset rather than ever returning a chunk that
        is silently short its last byte(s)."""
        last = None
        for attempt in range(tries):
            try:
                _op, payload = await self._request_retry_busy(
                    Op.FILE_READ, protocol.pack_file_read(path, off, want), timeout)
                return protocol.unpack_file_data(payload)
            except (TimeoutError, protocol.ProtocolError) as exc:
                last = exc
                log.warning("file_read chunk @%d failed (attempt %d/%d): %s",
                            off, attempt + 1, tries, exc)
        raise last

    async def read_file(self, path: str, offset: int = 0, length: int | None = None,
                        timeout: float | None = None):
        """Read a file (length<0 = to EOF), reassembling chunk_max-sized FILE_READ
        replies. Retries on BUSY (DOS not in a safe window). Returns
        (data, total_size, eof)."""
        chunk = self.chunk_max or protocol.DEFAULT_CHUNK_MAX
        buf = bytearray()
        off = offset
        remaining = -1 if (length is None or length < 0) else length
        total = 0
        while remaining != 0:
            want = chunk if remaining < 0 else min(chunk, remaining)
            info = await self._read_chunk(path, off, want, timeout)
            if info["status"] not in (Status.OK, Status.EOF):
                raise DosError(info["status"], "file read failed")
            total = info["total"]
            data = info["data"]
            if not data:
                break
            buf += data
            off += len(data)
            if remaining > 0:
                remaining -= len(data)
            if off >= total:
                break
        return bytes(buf), total, off >= total

    async def write_file(self, path: str, data: bytes, mode: str = "overwrite",
                         timeout: float | None = None) -> int:
        """Write data in chunk_max-sized FILE_WRITE chunks. mode='overwrite' sets
        WF_TRUNC on the FIRST chunk only (truncate, then plain seeked writes for
        the rest); mode='append' sets WF_APPEND on every chunk. Retries on BUSY."""
        chunk = self.chunk_max or protocol.DEFAULT_CHUNK_MAX
        append = (mode == "append")
        written = 0
        off = 0
        first = True
        while first or off < len(data):
            first = False
            piece = data[off:off + chunk]
            flags = protocol.WF_APPEND if append else (protocol.WF_TRUNC if off == 0 else 0)
            _op, payload = await self._request_retry_busy(
                Op.FILE_WRITE, protocol.pack_file_write(path, flags, off, piece), timeout)
            info = protocol.unpack_file_wrok(payload)
            if info["status"] != Status.OK:
                raise DosError(info["status"], "file write failed")
            written += info["written"]
            off += len(piece)
            if not piece:
                break
        return written

    async def file_hash(self, path: str, timeout: float | None = None) -> dict:
        """Ask the agent for the CRC-32 + length of a whole file on the box."""
        _op, payload = await self._request_retry_busy(
            Op.FILE_HASH, protocol.pack_file_hash(path), timeout)
        return protocol.unpack_file_hash_ok(payload)

    async def read_file_to(self, path: str, dest_path: str, offset: int = 0,
                           length: int | None = None, timeout: float | None = None,
                           attempts: int = 3) -> dict:
        """Stream a DOS file straight to a host file (no model context). For a
        full-file read (offset 0, to EOF) the bytes are verified end-to-end against
        the agent's CRC-32 and the whole transfer is retried on mismatch."""
        import hashlib
        import zlib
        full = (offset == 0 and (length is None or length < 0))
        last = None
        for attempt in range(1, attempts + 1):
            crc = 0
            sha = hashlib.sha256()
            written = total = 0
            chunk = self.chunk_max or protocol.DEFAULT_CHUNK_MAX
            off = offset
            remaining = -1 if (length is None or length < 0) else length
            with open(dest_path, "wb") as fh:
                while remaining != 0:
                    want = chunk if remaining < 0 else min(chunk, remaining)
                    info = await self._read_chunk(path, off, want, timeout)
                    if info["status"] not in (Status.OK, Status.EOF):
                        raise DosError(info["status"], "file read failed")
                    total = info["total"]
                    data = info["data"]
                    if not data:
                        break
                    fh.write(data)
                    crc = zlib.crc32(data, crc)
                    sha.update(data)
                    written += len(data)
                    off += len(data)
                    if remaining > 0:
                        remaining -= len(data)
                    if off >= total:
                        break
            crc &= 0xFFFFFFFF
            meta = {"dest_path": dest_path, "bytes": written, "total": total,
                    "crc32": crc, "sha256": sha.hexdigest(), "attempts": attempt}
            if not full:
                meta["verified"] = None      # can't whole-file-verify a partial read
                return meta
            dh = await self.file_hash(path, timeout)
            if dh["status"] == Status.OK and dh["length"] == written and dh["crc32"] == crc:
                meta["verified"] = True
                return meta
            last = (f"integrity mismatch: host crc={crc:08x} len={written} vs "
                    f"agent crc={dh.get('crc32'):08x} len={dh.get('length')}")
            log.warning("read_file_to %s attempt %d/%d: %s", path, attempt, attempts, last)
        raise IOError(f"read_file_to {path}: {last} (after {attempts} attempts)")

    async def write_file_from(self, path: str, src_path: str,
                              timeout: float | None = None, attempts: int = 3) -> dict:
        """Stream a host file straight to the DOS box (no model context), verified
        end-to-end against the agent's CRC-32 with retry. Always overwrites."""
        import hashlib
        import zlib
        with open(src_path, "rb") as fh:
            data = fh.read()
        crc = zlib.crc32(data) & 0xFFFFFFFF
        sha = hashlib.sha256(data).hexdigest()
        last = None
        for attempt in range(1, attempts + 1):
            written = await self.write_file(path, data, mode="overwrite", timeout=timeout)
            dh = await self.file_hash(path, timeout)
            if dh["status"] == Status.OK and dh["length"] == len(data) and dh["crc32"] == crc:
                return {"src_path": src_path, "bytes": written, "crc32": crc,
                        "sha256": sha, "verified": True, "attempts": attempt}
            last = (f"integrity mismatch: src crc={crc:08x} len={len(data)} vs "
                    f"agent crc={dh.get('crc32'):08x} len={dh.get('length')}")
            log.warning("write_file_from %s attempt %d/%d: %s", path, attempt, attempts, last)
        raise IOError(f"write_file_from {path}: {last} (after {attempts} attempts)")

    async def list_dir(self, path: str, timeout: float | None = None) -> list:
        """Enumerate a directory on the DOS box (wildcard path), following the
        agent's continuation if the listing spans multiple frames."""
        entries = []
        start = 0
        for _ in range(4096):                       # safety bound
            _op, payload = await self._request_retry_busy(
                Op.DIR_LIST, protocol.pack_dir_list(path, start), timeout)
            info = protocol.unpack_dir_data(payload)
            entries.extend(info["entries"])
            if not info["more"] or info["count"] == 0:
                break
            start += info["count"]
        return entries

    async def file_attr(self, path: str, do_set: bool = False, attr: int = 0,
                        timeout: float | None = None) -> int:
        """Get (do_set=False) or set a file's DOS attribute byte; returns the
        resulting attribute."""
        _op, payload = await self._request_retry_busy(
            Op.FILE_ATTR, protocol.pack_file_attr(path, do_set, attr), timeout)
        info = protocol.unpack_file_attr_ok(payload)
        if info["status"] != Status.OK:
            raise DosError(info["status"], "file attr failed")
        return info["attr"]

    async def mem_read(self, addr: int, length: int, timeout: float | None = None) -> bytes:
        """Read `length` bytes from linear address `addr`, reassembling chunks."""
        chunk = self.chunk_max or protocol.DEFAULT_CHUNK_MAX
        buf = bytearray()
        while len(buf) < length:
            want = min(chunk, length - len(buf))
            _op, payload = await self.request(
                Op.MEM_READ, protocol.pack_mem_read(addr + len(buf), want), timeout)
            info = protocol.unpack_mem_data(payload)
            if info["status"] != Status.OK:
                raise DosError(info["status"], "mem read failed")
            if not info["data"]:
                break
            buf += info["data"]
        return bytes(buf)

    async def mem_write(self, addr: int, data: bytes, timeout: float | None = None) -> int:
        """Write `data` to linear address `addr`, chunked."""
        chunk = self.chunk_max or protocol.DEFAULT_CHUNK_MAX
        off = 0
        while off < len(data):
            piece = data[off:off + chunk]
            _op, payload = await self.request(
                Op.MEM_WRITE, protocol.pack_mem_write(addr + off, piece), timeout)
            if protocol.unpack_mem_wrok(payload)["status"] != Status.OK:
                raise DosError(Status.OTHER, "mem write failed")
            off += len(piece)
        return off

    async def io_in(self, port: int, width: int = 1, timeout: float | None = None) -> int:
        _op, payload = await self.request(Op.IO_IN, protocol.pack_io_in(port, width), timeout)
        info = protocol.unpack_io_data(payload)
        if info["status"] != Status.OK:
            raise DosError(info["status"], f"io_in width {width} unsupported")
        return info["value"]

    async def io_out(self, port: int, value: int, width: int = 1,
                     timeout: float | None = None) -> None:
        _op, payload = await self.request(
            Op.IO_OUT, protocol.pack_io_out(port, width, value), timeout)
        if protocol.unpack_io_ok(payload)["status"] != Status.OK:
            raise DosError(Status.BAD_ARGS, f"io_out width {width} unsupported")

    _BS_KINDS = {"io": 0, "io_in": 0, "port": 0, 0: 0,
                 "mem": 1, "mem_read": 1, 1: 1,
                 "io_out": 2, "out": 2, 2: 2,
                 "mem_write": 3, "write": 3, 3: 3}

    async def bus_stim(self, kind, target: int, width: int = 1,
                       count: int = 100000, value: int = 0, unsafe: bool = False,
                       max_ticks: int = 0, timeout: float | None = None) -> dict:
        """Tight-loop bus stimulus for RE/logic-analyzer work: repeat one bus
        cycle `count` times back-to-back on the DOS box from a single round-trip,
        so the driven cycles dominate the bus. `kind`: 'io'/'mem' (reads) or
        'io_out'/'mem_write' (writes -- `value` is the byte/word written). Write
        kinds are refused for deny-listed ports unless `unsafe=True`. `max_ticks`
        bounds wall-clock (~55 ms/tick, 0 = uncapped) so a huge `count` can't pin
        the box. Blocks until the burst finishes; timeout scales with `count`.
        Returns {'iterations', 'last', ...}."""
        k = self._BS_KINDS.get(kind, 1)
        flags = protocol.GF_UNSAFE if unsafe else 0
        if timeout is None:
            timeout = max(15.0, count / 200000.0 + 5.0)   # generous; box does the loop
        _op, payload = await self.request(
            Op.BUS_STIM,
            protocol.pack_bus_stim(k, target, width, count, value, flags, max_ticks),
            timeout)
        info = protocol.unpack_bus_stim_ok(payload)
        if info["status"] == Status.ACCESS_DENIED:
            raise DosError(info["status"],
                           f"port 0x{target:X} is on the write deny-list; pass unsafe=True to override")
        if info["status"] != Status.OK:
            raise DosError(info["status"], "bus_stim bad args (kind/width)")
        return info

    async def idx_read(self, idx_port: int, data_port: int, first: int = 0,
                       count: int = 256, width: int = 1,
                       timeout: float | None = None) -> bytes:
        """Read an indexed register bank in one round-trip: for each index in
        [first, first+count) write it to `idx_port` then read `data_port`. This is
        the safe, standard way the PC110's index/data register pairs are read
        (SCAMP 0x74/0x76, 0x24/0x25, RTC 0x70/0x71, the EC mailboxes...). count
        1..256 (256 = full 8-bit bank). Returns `count`*width bytes."""
        if not (1 <= count <= 256):
            raise ValueError("count must be 1..256")
        _op, payload = await self.request(
            Op.IDX, protocol.pack_idx(0, idx_port, data_port, width, first,
                                      count & 0xFF), timeout)
        info = protocol.unpack_idx_data(payload)
        if info["status"] != Status.OK:
            raise DosError(info["status"], "idx_read failed")
        return info["data"]

    async def idx_write(self, idx_port: int, data_port: int, index: int,
                        value: int, width: int = 1, unsafe: bool = False,
                        timeout: float | None = None) -> None:
        """Write one indexed register: out(idx_port, index); out(data_port, value).
        Refused for deny-listed data/index ports unless unsafe=True."""
        flags = protocol.GF_UNSAFE if unsafe else 0
        _op, payload = await self.request(
            Op.IDX, protocol.pack_idx(1, idx_port, data_port, width, index, 0,
                                      flags, value), timeout)
        info = protocol.unpack_idx_data(payload)
        if info["status"] == Status.ACCESS_DENIED:
            raise DosError(info["status"],
                           f"idx write to 0x{data_port:X}/0x{idx_port:X} is deny-listed; pass unsafe=True")
        if info["status"] != Status.OK:
            raise DosError(info["status"], "idx_write failed")

    async def io_rmw(self, port: int, value: int, width: int = 1,
                     restore_ms: int = 0, unsafe: bool = False,
                     timeout: float | None = None) -> int:
        """Reversible probe write: read the old value, write `value`, and (if
        restore_ms>0) write the old value back after ~restore_ms. Returns the OLD
        value (also returned when the write is refused by the deny-list). Refused
        (no write) for deny-listed ports unless unsafe=True."""
        flags = protocol.GF_UNSAFE if unsafe else 0
        if timeout is None:
            timeout = max(10.0, restore_ms / 1000.0 + 5.0)
        _op, payload = await self.request(
            Op.IO_RMW, protocol.pack_io_rmw(port, width, value, restore_ms, flags),
            timeout)
        info = protocol.unpack_rmw_ok(payload)
        if info["status"] == Status.ACCESS_DENIED:
            raise DosError(info["status"],
                           f"port 0x{port:X} is on the write deny-list (old=0x{info['old']:X}); pass unsafe=True")
        if info["status"] != Status.OK:
            raise DosError(info["status"], "io_rmw bad args")
        return info["old"]

    async def pic_snapshot(self, timeout: float | None = None) -> dict:
        """Snapshot both 8259 PICs: IRR (pending), ISR (in-service), IMR (masked)
        for master (IRQ0-7) and slave (IRQ8-15). Read-only (OCW3 select)."""
        _op, payload = await self.request(Op.PIC, b"", timeout)
        info = protocol.unpack_pic_ok(payload)
        if info["status"] != Status.OK:
            raise DosError(info["status"], "pic_snapshot failed")
        return info

    async def safe_policy(self, timeout: float | None = None) -> list:
        """The compiled-in write-guard deny-list, as [(lo, hi), ...] port ranges."""
        _op, payload = await self.request(Op.SAFE, b"", timeout)
        info = protocol.unpack_safe_ok(payload)
        if info["status"] != Status.OK:
            raise DosError(info["status"], "safe_policy failed")
        return info["ranges"]

    # ---- composed helpers (client-side; built on the primitives above) ----

    async def config_snapshot(self, banks=None, ports=None) -> dict:
        """Dump a labelled set of indexed banks and direct ports to a snapshot
        dict for later diffing (map register semantics by snapshotting around a
        change). `banks`: {name: (idx_port, data_port[, count])}. `ports`: {name:
        port} single reads. Defaults to the PC110 config surface."""
        if banks is None and ports is None:
            banks = dict(PC110_BANKS)
            ports = dict(PC110_PORTS_SINGLE)
        out = {"banks": {}, "ports": {}}
        for name, spec in (banks or {}).items():
            iport, dport = spec[0], spec[1]
            cnt = spec[2] if len(spec) > 2 else 256
            out["banks"][name] = (await self.idx_read(iport, dport, 0, cnt)).hex()
        for name, port in (ports or {}).items():
            out["ports"][name] = await self.io_in(port)
        return out

    @staticmethod
    def config_diff(before: dict, after: dict) -> dict:
        """Diff two config_snapshot() results -> only the changed registers."""
        di: dict = {"banks": {}, "ports": {}}
        for name, hexb in after.get("banks", {}).items():
            a = bytes.fromhex(before.get("banks", {}).get(name, ""))
            b = bytes.fromhex(hexb)
            changes = [{"index": i, "before": a[i], "after": b[i]}
                       for i in range(min(len(a), len(b))) if a[i] != b[i]]
            if changes:
                di["banks"][name] = changes
        for name, bv in after.get("ports", {}).items():
            av = before.get("ports", {}).get(name)
            if av != bv:
                di["ports"][name] = {"before": av, "after": bv}
        return di

    async def banked_dump(self, bank_port: int, bank_values, mem_addr: int,
                          length: int, width: int = 1) -> dict:
        """Read a bank-switched memory window: for each value in `bank_values`,
        write it to `bank_port` (the bank/select register) then read `length`
        bytes at `mem_addr`. Returns {bank_value: hex}. (How the kanji font ROM
        was dumped via the 0x1160 bank register.)"""
        out = {}
        for bv in bank_values:
            await self.io_out(bank_port, bv, width)
            out[bv] = (await self.mem_read(mem_addr, length)).hex()
        return out

    def status(self) -> dict:
        return {"connected": self.connected.is_set(), "dos": self.hello,
                "chunk_max": self.chunk_max}
