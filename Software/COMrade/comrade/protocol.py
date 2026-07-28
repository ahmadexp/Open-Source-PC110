"""
protocol.py - wire protocol codec for the DOS agent control channel.

The codec for the binary protocol spoken with the DOS resident agent
(COMRADE.EXE) over a SERIAL byte stream (COM1; a TCP socket stands in for the
COM port under QEMU).  doc/PROTOCOL.md is the authoritative human-readable spec;
this file and src/proto.h are the two codecs that must match it.

Serial wire frame: [0xAA SYNC][type:1][reqId:2 LE][len:2 LE][payload][cksum:1],
cksum = 8-bit additive sum over type..end-of-payload (see encode_serial /
SerialFramer below).  The inner 5-byte header is:

    offset  size  field
      0      1    type     opcode (see Op); reply = request | 0x80; |0x40 = compressed
      1      2    reqId    request id; 0 == unsolicited DOS->host event
      3      2    len      payload length
      5     len   payload  opcode-specific

Strings (paths, machine info, error text) are a u16 length prefix followed by
raw CP437 bytes (DOS text is CP437, not UTF-8).  All multi-byte fields are
little-endian (x86-native -> no byteswap).  Both directions are implemented here
so the test double (tests/mock_dos.py) can speak the DOS side with the same
codec.
"""

from __future__ import annotations

import struct
from enum import IntEnum

PROTO_VER = 1

_HDR = struct.Struct("<BHH")          # type, reqId, len
HDR_LEN = _HDR.size                   # 5
MAX_PAYLOAD = 0xFFFF                   # width of the on-wire length field
# The agent never emits a payload larger than its output buffer (~4.3 KB). On a
# noisy real serial line a stray SYNC byte can be followed by a bogus length up
# to MAX_PAYLOAD; treating that as a real frame makes the de-framer stall waiting
# for ~64 KB. So the framer resyncs past any SYNC whose length exceeds this sane
# bound instead of waiting (mirrors src/proto.h PROTO_MAX_PAYLOAD = 8192).
MAX_FRAME_PAYLOAD = 8192
DEFAULT_CHUNK_MAX = 1024


class Op(IntEnum):
    # host -> DOS (requests)
    PING = 0x01
    SCREEN_GET = 0x02
    KEYS_SEND = 0x03
    FILE_READ = 0x04
    FILE_WRITE = 0x05
    DIR_LIST = 0x06
    FILE_ATTR = 0x07
    MEM_READ = 0x08
    MEM_WRITE = 0x09
    CONSOLE_GET = 0x0A
    IO_IN = 0x0B
    IO_OUT = 0x0C
    KEYS_RAW = 0x0D
    REBOOT = 0x0E
    FILE_HASH = 0x10
    BUS_STIM = 0x11
    IDX = 0x12
    IO_RMW = 0x13
    PIC = 0x14
    SAFE = 0x15
    # Win32 agent extensions (implemented by win95/COMR95.EXE)
    WIN_SCREENSHOT = 0x30
    # DOS -> host (replies / events)
    HELLO = 0x80
    PONG = 0x81
    SCREEN_DATA = 0x82
    KEYS_ACK = 0x83
    FILE_DATA = 0x84
    FILE_WROK = 0x85
    DIR_DATA = 0x86
    FILE_ATTR_OK = 0x87
    MEM_DATA = 0x88
    MEM_WROK = 0x89
    CONSOLE_DATA = 0x8A
    IO_DATA = 0x8B
    IO_OK = 0x8C
    KEYS_RAW_OK = 0x8D
    ERROR = 0x8F
    FILE_HASH_OK = 0x90
    BUS_STIM_OK = 0x91
    IDX_DATA = 0x92
    RMW_OK = 0x93
    PIC_OK = 0x94
    SAFE_OK = 0x95
    WIN_SCREENSHOT_DATA = 0xB0


class Status(IntEnum):
    OK = 0
    NOT_FOUND = 1
    ACCESS_DENIED = 2
    EOF = 3
    BAD_ARGS = 4
    BUSY = 5
    OTHER = 0xFF


# FILE_WRITE flag bits
WF_TRUNC = 0x01    # create / truncate before writing this (first) chunk
WF_APPEND = 0x02   # open for append

# Write-guard override bit (flags byte of BUS_STIM write kinds / IDX write / RMW).
# Set to write a deny-listed port anyway; see src/proto.h GF_UNSAFE.
GF_UNSAFE = 0x01

# BUS_STIM kinds
BS_IO_IN = 0      # repeat io_in on a port (read, always allowed)
BS_MEM_READ = 1   # repeat mem_read at a linear addr (read)
BS_IO_OUT = 2     # repeat io_out on a port (write, deny-list-gated)
BS_MEM_WRITE = 3  # repeat mem_write at a linear addr (write, deny-list-gated)


SYNC = 0xAA       # legacy frame start byte: 8-bit additive checksum trailer (1 byte)
SYNC_CRC = 0xAB   # CRC-16 era frame start byte: CRC-16-CCITT trailer (2 bytes LE)


def crc16(data) -> int:
    """CRC-16-CCITT (poly 0x1021, init 0xFFFF, MSB-first, no reflection / final
    XOR). Must match src/resident.cpp crc16(). Replaces the old 8-bit additive
    checksum, which missed transpositions and ~1/256 of random corruption."""
    crc = 0xFFFF
    for byte in data:
        crc ^= (byte << 8) & 0xFFFF
        for _ in range(8):
            crc = ((crc << 1) ^ 0x1021) & 0xFFFF if (crc & 0x8000) else (crc << 1) & 0xFFFF
    return crc

# Per-frame payload compression. The 115200-baud link is the bottleneck (~11.5
# KB/s) while the DOS box can capture far faster, so the agent LZSS-compresses a
# reply payload when it helps and sets COMPRESSED_FLAG in the opcode byte. The
# payload is then [origLen:2 LE][lzss bytes]. Requests (host->DOS) are never
# compressed. Old/raw frames simply don't set the flag -> fully back-compatible.
COMPRESSED_FLAG = 0x40
LZSS_WINDOW = 4096        # max match distance
LZSS_MIN = 3              # min match length (shorter -> emit literals)
LZSS_MAX = 18             # max match length (4-bit length field, +MIN)


def lzss_decompress(data: bytes, orig_len: int) -> bytes:
    """Decode the agent's LZSS stream. Format: groups of [flagbyte][8 tokens];
    flag bit (LSB first) 1=literal (1 byte), 0=match (2 bytes: d&0xFF, (d>>8<<4)|
    (len-MIN)) where distance=d+1."""
    out = bytearray()
    i, n = 0, len(data)
    while i < n and len(out) < orig_len:
        flags = data[i]; i += 1
        for bit in range(8):
            if len(out) >= orig_len or i >= n:
                break
            if flags & (1 << bit):                       # literal
                out.append(data[i]); i += 1
            else:                                        # match
                if i + 1 >= n:
                    break                                # truncated match token
                b0, b1 = data[i], data[i + 1]; i += 2
                dist = (b0 | ((b1 >> 4) << 8)) + 1
                length = (b1 & 0x0F) + LZSS_MIN
                start = len(out) - dist
                if start < 0:                            # corrupt: points before output
                    raise ValueError("lzss: match distance past start of output")
                for _ in range(length):
                    out.append(out[start]); start += 1
    if len(out) != orig_len:
        # A truncated/corrupt compressed stream decodes short (or long). Never
        # return it silently -- that is exactly how a file_read loses its last
        # byte(s). Raise so the framer drops the frame and the read retries.
        raise ValueError(f"lzss: decoded {len(out)} bytes, expected {orig_len}")
    return bytes(out)


def lzss_compress(src: bytes) -> bytes:
    """Reference LZSS encoder (greedy, brute-force search). The DOS agent has its
    own faster encoder; both emit the same format that lzss_decompress reads."""
    out = bytearray()
    i, n = 0, len(src)
    while i < n:
        flag_at = len(out); out.append(0); flags = 0
        for bit in range(8):
            if i >= n:
                break
            best_len, best_dist = 0, 0
            lo = max(0, i - LZSS_WINDOW)
            for j in range(i - 1, lo - 1, -1):
                l = 0
                while l < LZSS_MAX and i + l < n and src[j + l] == src[i + l]:
                    l += 1
                if l > best_len:
                    best_len, best_dist = l, i - j
                    if l == LZSS_MAX:
                        break
            if best_len >= LZSS_MIN:
                d = best_dist - 1
                out.append(d & 0xFF)
                out.append(((d >> 8) << 4) | (best_len - LZSS_MIN))
                i += best_len
            else:
                flags |= (1 << bit)
                out.append(src[i]); i += 1
        out[flag_at] = flags
    return bytes(out)


class ProtocolError(Exception):
    """Malformed frame or value not representable on the wire."""


class DosError(Exception):
    """A DOS-side ERROR reply (status code + message)."""

    def __init__(self, code: int, msg: str = ""):
        super().__init__(f"DOS error {code}" + (f": {msg}" if msg else ""))
        self.code = code
        self.msg = msg


# --------------------------------------------------------------- CP437 strings

def enc_cp437(s: str) -> bytes:
    try:
        return s.encode("cp437")
    except UnicodeEncodeError as exc:
        raise ProtocolError(f"value not representable in CP437: {s!r}") from exc


def dec_cp437(b: bytes) -> str:
    return b.decode("cp437")


def _pack_str(s: str) -> bytes:
    raw = enc_cp437(s)
    if len(raw) > MAX_PAYLOAD:
        raise ProtocolError("string too long")
    return struct.pack("<H", len(raw)) + raw


def _unpack_str(buf: bytes, off: int):
    (n,) = struct.unpack_from("<H", buf, off)
    off += 2
    if off + n > len(buf):
        raise ProtocolError("string runs past end of payload")
    return dec_cp437(buf[off:off + n]), off + n


# ------------------------------------------------------------- frame framing

def encode_frame(op: int, req_id: int, payload: bytes = b"") -> bytes:
    if len(payload) > MAX_PAYLOAD:
        raise ProtocolError("payload too large for one frame")
    return _HDR.pack(int(op), req_id & 0xFFFF, len(payload)) + payload


def encode_serial(op: int, req_id: int, payload: bytes = b"", crc: bool = False) -> bytes:
    """Wrap a frame for the serial wire. crc=False: legacy 0xAA + 8-bit additive
    checksum. crc=True: 0xAB + CRC-16-CCITT (2 bytes LE) -- the integrity-hardened
    format. The host emits whichever the box speaks (auto-detected)."""
    inner = encode_frame(op, req_id, payload)        # type, reqId, len, payload
    if crc:
        c = crc16(inner)
        return bytes([SYNC_CRC]) + inner + bytes([c & 0xFF, (c >> 8) & 0xFF])
    return bytes([SYNC]) + inner + bytes([sum(inner) & 0xFF])


class SerialFramer:
    """Stateful de-framer for the serial byte stream.

    Feed it bytes; it yields (op, reqId, payload) for each valid frame and
    resynchronises past noise / bad checksums.
    """

    def __init__(self):
        self.buf = bytearray()
        # Last validated frame's format: True=CRC-16 (0xAB), False=additive (0xAA),
        # None=undetermined. The connection mirrors its TX format from this, so the
        # host auto-speaks whichever the box uses.
        self.peer_crc = None

    def feed(self, data: bytes):
        self.buf += data

    def frames(self):
        b = self.buf
        i = 0
        out = []
        while i < len(b):
            sb = b[i]
            if sb == SYNC:
                trailer = 1                  # additive: 1-byte checksum
            elif sb == SYNC_CRC:
                trailer = 2                  # CRC-16: 2-byte trailer
            else:
                i += 1
                continue
            if len(b) - i < 6 + trailer:     # SYNC + 5-hdr + trailer minimum
                break
            plen = b[i + 4] | (b[i + 5] << 8)
            if plen > MAX_FRAME_PAYLOAD:     # implausible length -> sync byte was noise
                i += 1
                continue
            total = 6 + plen + trailer       # SYNC(1) + hdr(5) + payload + trailer
            if len(b) - i < total:           # wait for the rest of the frame
                break
            inner = b[i + 1:i + 6 + plen]    # op, reqId, len, payload
            if trailer == 2:
                got = b[i + 6 + plen] | (b[i + 7 + plen] << 8)
                if crc16(inner) != got:
                    i += 1                   # bad CRC -> resync
                    continue
            else:
                if (sum(inner) & 0xFF) != b[i + 6 + plen]:
                    i += 1                   # bad checksum -> resync
                    continue
            op = b[i + 1]
            req_id = b[i + 2] | (b[i + 3] << 8)
            payload = bytes(b[i + 6:i + 6 + plen])
            if op & COMPRESSED_FLAG:                      # [origLen:2][lzss]
                try:
                    orig = payload[0] | (payload[1] << 8)
                    payload = lzss_decompress(payload[2:], orig)
                except (IndexError, ValueError):
                    # A checksum/CRC-passing but corrupt/short compressed frame must
                    # not kill the reader and must not be delivered truncated. Its
                    # length is known (it passed the trailer), so skip the WHOLE
                    # frame -> the request gets no reply -> it times out and retries,
                    # rather than us silently emitting a short payload.
                    i += total
                    continue
                op &= ~COMPRESSED_FLAG
            self.peer_crc = (trailer == 2)   # remember the box's wire format
            out.append((op, req_id, payload))
            i += total
        del self.buf[:i]
        return out


async def read_frame(reader):
    """Read one INNER frame ([type][reqId][len][payload], no SYNC/checksum) from
    a StreamReader.  NOTE: the live serial link is de-framed by SerialFramer
    (SYNC + checksum + resync); this helper does NOT parse the serial wrapper and
    is kept only for the unit test / a clean length-prefixed stream.

    Uses readexactly so a partial/packed read is handled correctly -- never
    assume one recv() == one frame.  Raises IncompleteReadError on EOF mid-frame.
    """
    hdr = await reader.readexactly(HDR_LEN)
    op, req_id, n = _HDR.unpack(hdr)
    payload = await reader.readexactly(n) if n else b""
    return op, req_id, payload


# ------------------------------------------------- host -> DOS payload builders

def pack_keys(pairs) -> bytes:
    """pairs: iterable of (scancode, ascii) byte tuples."""
    pairs = list(pairs)
    out = bytearray(struct.pack("<H", len(pairs)))
    for scan, ascii_ in pairs:
        out.append(scan & 0xFF)
        out.append(ascii_ & 0xFF)
    return bytes(out)


def pack_keys_raw(scancodes: bytes) -> bytes:
    """Raw make/break scancode stream for hardware (8042) injection."""
    return struct.pack("<H", len(scancodes)) + bytes(scancodes)


def unpack_keys_raw_ok(p: bytes) -> int:
    return struct.unpack_from("<H", p, 0)[0]


def pack_file_read(path: str, offset: int, max_len: int) -> bytes:
    return _pack_str(path) + struct.pack("<IH", offset, max_len)


def pack_file_hash(path: str) -> bytes:
    return _pack_str(path)


def unpack_file_hash_ok(p: bytes) -> dict:
    status, length, crc32 = struct.unpack_from("<BII", p, 0)
    return {"status": status, "length": length, "crc32": crc32}


def pack_file_write(path: str, flags: int, offset: int, data: bytes) -> bytes:
    if len(data) > MAX_PAYLOAD:
        raise ProtocolError("write chunk too large")
    return _pack_str(path) + struct.pack("<BIH", flags, offset, len(data)) + data


def pack_console_get(since_seq: int, max_len: int) -> bytes:
    return struct.pack("<IH", since_seq, max_len)


def pack_dir_list(path: str, start: int = 0) -> bytes:
    return _pack_str(path) + struct.pack("<H", start & 0xFFFF)


def pack_file_attr(path: str, do_set: bool, attr: int = 0) -> bytes:
    return _pack_str(path) + struct.pack("<BB", 1 if do_set else 0, attr & 0xFF)


def unpack_file_attr_ok(p: bytes) -> dict:
    return {"status": p[0], "attr": p[1]}


def pack_win_screenshot(width: int = 80, height: int = 60) -> bytes:
    """Request a small grayscale desktop thumbnail from the Win95 agent."""
    return struct.pack("<HH", max(0, min(width, 0xFFFF)), max(0, min(height, 0xFFFF)))


# --- direct memory- and I/O-space access ---

def pack_mem_read(addr: int, length: int) -> bytes:
    return struct.pack("<IH", addr & 0xFFFFFFFF, length & 0xFFFF)


def pack_mem_data(status: int, addr: int, data: bytes) -> bytes:
    return struct.pack("<BIH", status, addr & 0xFFFFFFFF, len(data)) + data


def unpack_mem_data(p: bytes) -> dict:
    status = p[0]
    addr = p[1] | (p[2] << 8) | (p[3] << 16) | (p[4] << 24)
    n = p[5] | (p[6] << 8)
    return {"status": status, "addr": addr, "len": n, "data": p[7:7 + n]}


def pack_mem_write(addr: int, data: bytes) -> bytes:
    return struct.pack("<IH", addr & 0xFFFFFFFF, len(data)) + data


def unpack_mem_wrok(p: bytes) -> dict:
    return {"status": p[0], "written": p[1] | (p[2] << 8)}


def pack_io_in(port: int, width: int) -> bytes:
    return struct.pack("<HB", port & 0xFFFF, width & 0xFF)


def unpack_io_data(p: bytes) -> dict:
    value = p[2] | (p[3] << 8) | (p[4] << 16) | (p[5] << 24)
    return {"status": p[0], "width": p[1], "value": value}


def pack_io_out(port: int, width: int, value: int) -> bytes:
    return struct.pack("<HBI", port & 0xFFFF, width & 0xFF, value & 0xFFFFFFFF)


def unpack_io_ok(p: bytes) -> dict:
    return {"status": p[0]}


def pack_bus_stim(kind: int, target: int, width: int, count: int,
                  value: int = 0, flags: int = 0, max_ticks: int = 0) -> bytes:
    """kind: 0=io_in, 1=mem_read, 2=io_out, 3=mem_write (see BS_*). Always emits
    the 17-byte format [kind][target:4][width][count:4][value:4][flags][ticks:2];
    old firmware reads only the first 10 bytes (read kinds), so this stays
    back-compatible. `value` is the written byte/word (write kinds); `max_ticks`
    caps wall-clock (~55 ms/tick, 0 = uncapped); flags GF_UNSAFE overrides the
    write deny-list."""
    return struct.pack("<BIBIIBH", kind & 0xFF, target & 0xFFFFFFFF, width & 0xFF,
                       count & 0xFFFFFFFF, value & 0xFFFFFFFF, flags & 0xFF,
                       max_ticks & 0xFFFF)


def unpack_bus_stim_ok(p: bytes) -> dict:
    status = p[0]
    iters = p[1] | (p[2] << 8) | (p[3] << 16) | (p[4] << 24)
    last = p[5] | (p[6] << 8) | (p[7] << 16) | (p[8] << 24)
    # 'iterations' = cycles actually executed (may be < requested if ticks-capped);
    # 'count' kept as an alias for back-compat with older callers.
    return {"status": status, "iterations": iters, "count": iters, "last": last}


# --- indexed-register access (OP_IDX) ---

def pack_idx(subop: int, idx_port: int, data_port: int, width: int,
             first_index: int, count: int, flags: int = 0, value: int = 0) -> bytes:
    """subop 0 = read bank (count regs from first_index; count 0 => 256),
    subop 1 = write one reg (first_index<-value). width applies to the data port."""
    return struct.pack("<BHHBBBBB", subop & 0xFF, idx_port & 0xFFFF,
                       data_port & 0xFFFF, width & 0xFF, first_index & 0xFF,
                       count & 0xFF, flags & 0xFF, value & 0xFF)


def unpack_idx_data(p: bytes) -> dict:
    status = p[0]
    count = p[1]
    return {"status": status, "count": count, "data": bytes(p[2:])}


# --- reversible probe write (OP_IO_RMW) ---

def pack_io_rmw(port: int, width: int, value: int,
                restore_ms: int = 0, flags: int = 0) -> bytes:
    return struct.pack("<HBIHB", port & 0xFFFF, width & 0xFF, value & 0xFFFFFFFF,
                       restore_ms & 0xFFFF, flags & 0xFF)


def unpack_rmw_ok(p: bytes) -> dict:
    old = p[2] | (p[3] << 8) | (p[4] << 16) | (p[5] << 24)
    return {"status": p[0], "width": p[1], "old": old}


# --- PIC snapshot (OP_PIC) ---

def unpack_pic_ok(p: bytes) -> dict:
    return {"status": p[0],
            "master": {"irr": p[1], "isr": p[2], "imr": p[3]},
            "slave":  {"irr": p[4], "isr": p[5], "imr": p[6]}}


# --- write-guard deny-list query (OP_SAFE) ---

def unpack_safe_ok(p: bytes) -> dict:
    status = p[0]
    n = p[1]
    ranges = []
    for i in range(n):
        lo, hi = struct.unpack_from("<HH", p, 2 + i * 4)
        ranges.append((lo, hi))
    return {"status": status, "ranges": ranges}


# DOS file-attribute bits
A_RDONLY = 0x01
A_HIDDEN = 0x02
A_SYSTEM = 0x04
A_VOLID = 0x08
A_SUBDIR = 0x10
A_ARCH = 0x20


def _dos_datetime(date: int, time: int) -> str:
    """Decode the packed DOS wr_date/wr_time words to 'YYYY-MM-DD HH:MM:SS'."""
    day = date & 0x1F
    month = (date >> 5) & 0x0F
    year = 1980 + ((date >> 9) & 0x7F)
    sec = (time & 0x1F) * 2
    minute = (time >> 5) & 0x3F
    hour = (time >> 11) & 0x1F
    if not (1 <= month <= 12 and 1 <= day <= 31):
        return ""
    return f"{year:04d}-{month:02d}-{day:02d} {hour:02d}:{minute:02d}:{sec:02d}"


def unpack_dir_data(p: bytes) -> dict:
    """DIR_DATA: [count:2][more:1][entries], each entry
       [attr:1][wr_time:2][wr_date:2][size:4][namelen:1][name]."""
    count = p[0] | (p[1] << 8)
    more = bool(p[2])
    entries = []
    off = 3
    for _ in range(count):
        attr = p[off]
        wtime = p[off + 1] | (p[off + 2] << 8)
        wdate = p[off + 3] | (p[off + 4] << 8)
        size = p[off + 5] | (p[off + 6] << 8) | (p[off + 7] << 16) | (p[off + 8] << 24)
        nl = p[off + 9]
        off += 10
        name = dec_cp437(p[off:off + nl])
        off += nl
        entries.append({
            "name": name, "size": size, "attr": attr,
            "is_dir": bool(attr & A_SUBDIR),
            "is_hidden": bool(attr & A_HIDDEN),
            "is_system": bool(attr & A_SYSTEM),
            "is_readonly": bool(attr & A_RDONLY),
            "mtime": _dos_datetime(wdate, wtime),
        })
    return {"count": count, "more": more, "entries": entries}


# --------------------------------------------- host -> DOS payload parsers (DOS side)

def unpack_keys(p: bytes):
    (n,) = struct.unpack_from("<H", p, 0)
    out = []
    off = 2
    for _ in range(n):
        out.append((p[off], p[off + 1]))
        off += 2
    return out


def unpack_file_read(p: bytes):
    path, off = _unpack_str(p, 0)
    offset, max_len = struct.unpack_from("<IH", p, off)
    return path, offset, max_len


def unpack_file_write(p: bytes):
    path, off = _unpack_str(p, 0)
    flags, offset, dlen = struct.unpack_from("<BIH", p, off)
    off += 7
    return path, flags, offset, p[off:off + dlen]


def unpack_console_get(p: bytes):
    return struct.unpack("<IH", p)


def unpack_dir_list(p: bytes):
    """DOS-side parse of DIR_LIST: [path:str][start:2]. Returns (path, start)."""
    path, off = _unpack_str(p, 0)
    (start,) = struct.unpack_from("<H", p, off)
    return path, start


# ----------------------------------------------- DOS -> host payload builders (DOS side)

def pack_hello(cols: int, rows: int, chunk_max: int, machine: str,
               ver: int = PROTO_VER) -> bytes:
    return struct.pack("<BBBH", ver, cols, rows, chunk_max) + _pack_str(machine)


def pack_pong(uptime_ticks: int = 0) -> bytes:
    return struct.pack("<I", uptime_ticks)


def pack_screen_data(mode: int, cols: int, rows: int, cur_col: int,
                     cur_row: int, cur_vis: int, cells: bytes) -> bytes:
    return struct.pack("<BBBBBB", mode, cols, rows, cur_col, cur_row, cur_vis) + cells


def pack_keys_ack(injected: int) -> bytes:
    return struct.pack("<H", injected)


def pack_file_data(status: int, total: int, offset: int, data: bytes) -> bytes:
    return struct.pack("<BIIH", status, total, offset, len(data)) + data


def pack_file_wrok(status: int, written: int) -> bytes:
    return struct.pack("<BI", status, written)


def pack_console_data(base_seq: int, next_seq: int, overflow: int,
                      data: bytes) -> bytes:
    return struct.pack("<IIBH", base_seq, next_seq, overflow, len(data)) + data


def pack_error(code: int, msg: str = "") -> bytes:
    return struct.pack("<B", code) + _pack_str(msg)


# -------------------------------------------------- DOS -> host payload parsers (host side)

def unpack_hello(p: bytes):
    ver, cols, rows, chunk_max = struct.unpack_from("<BBBH", p, 0)
    machine, _ = _unpack_str(p, 5)
    return {"proto_ver": ver, "cols": cols, "rows": rows,
            "chunk_max": chunk_max, "machine": machine}


def unpack_pong(p: bytes):
    return struct.unpack_from("<I", p, 0)[0] if len(p) >= 4 else 0


def unpack_screen_data(p: bytes):
    mode, cols, rows, cur_col, cur_row, cur_vis = struct.unpack_from("<BBBBBB", p, 0)
    cells = p[6:]
    return {"mode": mode, "cols": cols, "rows": rows,
            "cursor": {"col": cur_col, "row": cur_row, "visible": bool(cur_vis)},
            "cells": cells}


def unpack_win_screenshot(p: bytes) -> dict:
    """Decode WIN_SCREENSHOT_DATA: status, dimensions, format, and gray8 bytes."""
    if len(p) < 8:
        raise ProtocolError("WIN_SCREENSHOT_DATA short")
    status, width, height, fmt, dlen = struct.unpack_from("<BHHBH", p, 0)
    if len(p) < 8 + dlen:
        raise ProtocolError("WIN_SCREENSHOT_DATA truncated")
    return {"status": status, "width": width, "height": height,
            "format": fmt, "data": p[8:8 + dlen]}


def unpack_keys_ack(p: bytes):
    return struct.unpack_from("<H", p, 0)[0]


def unpack_file_data(p: bytes):
    status, total, offset, dlen = struct.unpack_from("<BIIH", p, 0)
    if len(p) < 11 + dlen:                # short payload -> corrupt frame, don't
        raise ProtocolError(             # silently return a truncated tail
            f"FILE_DATA short: have {len(p)} bytes, header claims {11 + dlen}")
    data = p[11:11 + dlen]
    return {"status": status, "total": total, "offset": offset, "data": data}


def unpack_file_wrok(p: bytes):
    status, written = struct.unpack_from("<BI", p, 0)
    return {"status": status, "written": written}


def unpack_console_data(p: bytes):
    base_seq, next_seq, overflow, dlen = struct.unpack_from("<IIBH", p, 0)
    data = p[11:11 + dlen]
    return {"base_seq": base_seq, "next_seq": next_seq,
            "overflow": bool(overflow), "data": data}


def unpack_error(p: bytes):
    (code,) = struct.unpack_from("<B", p, 0)
    msg, _ = _unpack_str(p, 1)
    return code, msg
