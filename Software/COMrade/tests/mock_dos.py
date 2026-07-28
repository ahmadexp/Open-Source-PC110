"""
mock_dos.py - an in-process test double for the serial DOS resident agent.

It listens on a loopback TCP socket (standing in for the QEMU COM1<->socket
bridge), speaks the serial-framed control protocol, sends an unsolicited HELLO
on connect, and answers over a synthetic 80x25 screen, a virtual filesystem, and
a console capture ring.  A PING is answered with HELLO, exactly like COMRADE.
Typed characters echo to the console and Enter "runs" a command, so run_command
can be exercised without QEMU.
"""

from __future__ import annotations

import asyncio

from comrade import protocol
from comrade.protocol import Op, Status, WF_TRUNC, WF_APPEND


class MockDos:
    def __init__(self, cols: int = 80, rows: int = 25,
                 machine: str = "MOCK DOS 6.22 / 640K", chunk_max: int = 512):
        self.cols = cols
        self.rows = rows
        self.machine = machine
        self.chunk_max = chunk_max
        self.screen = bytearray()
        self._init_screen()
        self.cursor = (0, 0)         # (col, row)
        self.fs: dict[str, bytearray] = {}
        self.attrs: dict[str, int] = {}   # path -> DOS attribute byte
        self.mem: dict[int, int] = {}     # sparse memory space (addr -> byte)
        self.ports: dict[int, int] = {}   # sparse I/O space (port -> value)
        self.cap = bytearray()       # console capture stream (all bytes ever)
        self.injected: list[tuple[int, int]] = []
        self.raw_injected = bytearray()   # hardware (8042) make/break scancodes
        self.reboots = 0
        self.drop_file_reads = 0          # test hook: drop the next N FILE_READ replies
        self._line = bytearray()
        self.commands: dict[str, str] = {}   # cmd (lower) -> canned output
        self.default_output = "[ran {cmd}]\r\nA.TXT\r\nB.TXT\r\n\r\nC:\\>"
        self._writer: asyncio.StreamWriter | None = None
        self._server: asyncio.AbstractServer | None = None
        self.host = "127.0.0.1"
        self.port = 0

    # ----------------------------------------------------------- screen helpers

    def _init_screen(self):
        cell = bytes([0x20, 0x07])
        self.screen = bytearray(cell * (self.cols * self.rows))

    def set_screen(self, lines, attr: int = 0x07):
        self._init_screen()
        for r, text in enumerate(lines[:self.rows]):
            for c, ch in enumerate(text[:self.cols]):
                idx = 2 * (r * self.cols + c)
                self.screen[idx] = ord(ch.encode("cp437"))
                self.screen[idx + 1] = attr
        self.cursor = (0, min(len(lines), self.rows - 1))

    def push_console(self, text: str):
        self.cap.extend(text.encode("cp437"))

    # ----------------------------------------------------------- shell sim

    def _feed(self, ascii_: int):
        if ascii_ == 0x0D:                 # Enter -> run the line
            cmd = bytes(self._line).decode("cp437")
            self._line.clear()
            out = self.commands.get(cmd.strip().lower(),
                                    self.default_output).format(cmd=cmd.strip())
            self.push_console("\r\n" + out)
        elif ascii_ == 0x08:               # Backspace
            if self._line:
                self._line.pop()
        elif ascii_ >= 0x20:               # printable -> echo + buffer
            self.cap.append(ascii_)
            self._line.append(ascii_)

    # ----------------------------------------------------------- serve

    async def start_server(self):
        self._server = await asyncio.start_server(self._on_client, self.host, 0)
        self.host, self.port = self._server.sockets[0].getsockname()[:2]
        return self

    def open_stream(self):
        """Coroutine factory for ConnectionManager.start()."""
        return asyncio.open_connection(self.host, self.port)

    async def close(self):
        if self._writer:
            try:
                self._writer.close()
            except Exception:
                pass
        if self._server:
            self._server.close()
            try:
                await asyncio.wait_for(self._server.wait_closed(), 1.0)
            except Exception:
                pass

    async def _on_client(self, reader: asyncio.StreamReader, writer: asyncio.StreamWriter):
        self._writer = writer
        await self._send(Op.HELLO, 0,
                         protocol.pack_hello(self.cols, self.rows, self.chunk_max, self.machine))
        framer = protocol.SerialFramer()
        try:
            while True:
                data = await reader.read(4096)
                if not data:
                    break
                framer.feed(data)
                for op, rid, payload in framer.frames():
                    await self._dispatch(op, rid, payload)
        except (ConnectionError, asyncio.CancelledError):
            pass

    async def _send(self, op, rid, payload=b""):
        self._writer.write(protocol.encode_serial(op, rid, payload))
        await self._writer.drain()

    async def _dispatch(self, op, rid, p):
        if op == Op.PING:                          # PING -> HELLO, like COMRADE
            await self._send(Op.HELLO, rid,
                             protocol.pack_hello(self.cols, self.rows, self.chunk_max, self.machine))
        elif op == Op.SCREEN_GET:
            col, row = self.cursor
            await self._send(Op.SCREEN_DATA, rid, protocol.pack_screen_data(
                3, self.cols, self.rows, col, row, 1, bytes(self.screen)))
        elif op == Op.KEYS_SEND:
            pairs = protocol.unpack_keys(p)
            self.injected.extend(pairs)
            for _scan, ascii_ in pairs:
                self._feed(ascii_)
            await self._send(Op.KEYS_ACK, rid, protocol.pack_keys_ack(len(pairs)))
        elif op == Op.KEYS_RAW:
            n = p[0] | (p[1] << 8)
            self.raw_injected.extend(p[2:2 + n])     # captured make/break scancodes
            await self._send(Op.KEYS_RAW_OK, rid, protocol.pack_keys_ack(n))
        elif op == Op.REBOOT:
            # simulate a warm-boot: come back as a "new" version, drop the link so
            # the bridge auto-reconnects (no reply -- the real box just resets).
            self.reboots += 1
            self.machine = f"MOCK COMRADE reboot#{self.reboots}"
            try:
                self._writer.close()
            except Exception:
                pass
            return
        elif op == Op.FILE_READ:
            path, off, maxlen = protocol.unpack_file_read(p)
            data = self.fs.get(path.upper())
            if data is None:
                await self._send(Op.ERROR, rid, protocol.pack_error(Status.NOT_FOUND, "no such file"))
                return
            if self.drop_file_reads > 0:          # test hook: simulate a lost/corrupt reply
                self.drop_file_reads -= 1
                return                            # send nothing -> request times out -> retry
            chunk = bytes(data[off:off + maxlen])
            await self._send(Op.FILE_DATA, rid,
                             protocol.pack_file_data(Status.OK, len(data), off, chunk))
        elif op == Op.FILE_WRITE:
            path, flags, off, data = protocol.unpack_file_write(p)
            key = path.upper()
            if flags & WF_TRUNC:
                self.fs[key] = bytearray()
            buf = self.fs.setdefault(key, bytearray())
            if flags & WF_APPEND:
                buf.extend(data)
            else:
                if len(buf) < off:
                    buf.extend(b"\x00" * (off - len(buf)))
                buf[off:off + len(data)] = data
            await self._send(Op.FILE_WROK, rid, protocol.pack_file_wrok(Status.OK, len(data)))
        elif op == Op.FILE_HASH:
            import struct
            import zlib
            name, _ = protocol._unpack_str(p, 0)
            data = self.fs.get(name.upper())
            if data is None:
                await self._send(Op.ERROR, rid, protocol.pack_error(Status.NOT_FOUND, "no such file"))
            else:
                crc = zlib.crc32(bytes(data)) & 0xFFFFFFFF
                await self._send(Op.FILE_HASH_OK, rid,
                                 struct.pack("<BII", Status.OK, len(data), crc))
        elif op == Op.CONSOLE_GET:
            since, maxlen = protocol.unpack_console_get(p)
            head = len(self.cap)
            start = min(since, head)
            data = b"" if maxlen == 0 else bytes(self.cap[start:start + maxlen])
            await self._send(Op.CONSOLE_DATA, rid,
                             protocol.pack_console_data(start, start + len(data), 0, data))
        elif op == Op.DIR_LIST:
            import fnmatch
            pl = p[0] | (p[1] << 8)
            pattern = protocol.dec_cp437(p[2:2 + pl])
            start = p[2 + pl] | (p[2 + pl + 1] << 8)
            base = pattern.replace("/", "\\").split("\\")[-1].upper() or "*.*"
            items = []
            for key in sorted(self.fs):
                name = key.split("\\")[-1].upper()
                if base in ("*.*", "*") or fnmatch.fnmatch(name, base):
                    items.append((name, len(self.fs[key]), self.attrs.get(key, 0x20)))
            items = items[start:]
            body = bytearray([len(items) & 0xFF, len(items) >> 8, 0])   # count, more=0
            for name, size, attr in items:
                nb = name.encode("cp437")
                body += bytes([attr, 0x00, 0x59, 0x53, 0x4D])           # attr, time(2), date(2)
                body += bytes([size & 0xFF, (size >> 8) & 0xFF,
                               (size >> 16) & 0xFF, (size >> 24) & 0xFF])
                body += bytes([len(nb)]) + nb
            await self._send(Op.DIR_DATA, rid, bytes(body))
        elif op == Op.FILE_ATTR:
            pl = p[0] | (p[1] << 8)
            path = protocol.dec_cp437(p[2:2 + pl])
            do_set, attr = p[2 + pl], p[2 + pl + 1]
            key = path.upper()
            if key not in self.fs:
                await self._send(Op.ERROR, rid, protocol.pack_error(Status.NOT_FOUND, "no such file"))
                return
            if do_set:
                self.attrs[key] = attr & 0x27        # settable bits only
            cur = self.attrs.get(key, 0x20)          # default: archive
            await self._send(Op.FILE_ATTR_OK, rid, bytes([Status.OK, cur]))
        elif op == Op.MEM_READ:
            addr = p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24)
            n = p[4] | (p[5] << 8)
            data = bytes(self.mem.get(addr + i, 0) for i in range(n))
            await self._send(Op.MEM_DATA, rid, protocol.pack_mem_data(Status.OK, addr, data))
        elif op == Op.MEM_WRITE:
            addr = p[0] | (p[1] << 8) | (p[2] << 16) | (p[3] << 24)
            n = p[4] | (p[5] << 8)
            for i in range(n):
                self.mem[addr + i] = p[6 + i]
            await self._send(Op.MEM_WROK, rid, bytes([Status.OK, n & 0xFF, n >> 8]))
        elif op == Op.IO_IN:
            port = p[0] | (p[1] << 8)
            width = p[2]
            val = self.ports.get(port, 0) if width in (1, 2) else 0
            st = Status.OK if width in (1, 2) else Status.BAD_ARGS
            await self._send(Op.IO_DATA, rid,
                             bytes([st, width]) + val.to_bytes(4, "little"))
        elif op == Op.IO_OUT:
            port = p[0] | (p[1] << 8)
            width = p[2]
            value = int.from_bytes(p[3:7], "little")
            if width in (1, 2):
                self.ports[port] = value & (0xFF if width == 1 else 0xFFFF)
                await self._send(Op.IO_OK, rid, bytes([Status.OK]))
            else:
                await self._send(Op.IO_OK, rid, bytes([Status.BAD_ARGS]))
        else:
            await self._send(Op.ERROR, rid, protocol.pack_error(Status.BAD_ARGS, "unknown op"))
