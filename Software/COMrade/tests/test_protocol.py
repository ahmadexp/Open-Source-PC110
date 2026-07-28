import asyncio

import pytest

from comrade import protocol as p
from comrade.protocol import Op


def test_frame_header_layout():
    fr = p.encode_frame(Op.KEYS_SEND, 0x1234, b"\xaa\xbb")
    assert fr[0] == int(Op.KEYS_SEND)
    assert fr[1:3] == b"\x34\x12"        # reqId LE
    assert fr[3:5] == b"\x02\x00"        # len LE
    assert fr[5:] == b"\xaa\xbb"


def test_cp437_roundtrip_and_error():
    assert p.dec_cp437(p.enc_cp437("café")) == "café"   # é is in CP437
    with pytest.raises(p.ProtocolError):
        p.enc_cp437("日本")                              # not representable


def test_keys_roundtrip():
    pairs = [(0x1C, 0x0D), (0x1E, 0x61), (0x48, 0x00)]
    assert p.unpack_keys(p.pack_keys(pairs)) == pairs


def test_file_read_roundtrip():
    assert p.unpack_file_read(p.pack_file_read("C:\\X.C", 4096, 1024)) == ("C:\\X.C", 4096, 1024)


def test_file_write_roundtrip():
    path, flags, off, data = p.unpack_file_write(
        p.pack_file_write("A:\\T.TXT", p.WF_TRUNC, 0, b"hello"))
    assert (path, flags, off, data) == ("A:\\T.TXT", p.WF_TRUNC, 0, b"hello")


def test_console_get_roundtrip():
    assert p.unpack_console_get(p.pack_console_get(123456, 1024)) == (123456, 1024)


def test_hello_roundtrip():
    h = p.unpack_hello(p.pack_hello(80, 25, 512, "MOCK 6.22"))
    assert h == {"proto_ver": p.PROTO_VER, "cols": 80, "rows": 25,
                 "chunk_max": 512, "machine": "MOCK 6.22"}


def test_screen_data_roundtrip():
    cells = bytes([0x41, 0x07, 0x42, 0x70])
    sd = p.unpack_screen_data(p.pack_screen_data(3, 2, 1, 1, 0, 1, cells))
    assert sd["mode"] == 3 and sd["cols"] == 2 and sd["rows"] == 1
    assert sd["cursor"] == {"col": 1, "row": 0, "visible": True}
    assert sd["cells"] == cells


def test_file_data_and_wrok_roundtrip():
    fd = p.unpack_file_data(p.pack_file_data(p.Status.OK, 5000, 1024, b"abc"))
    assert fd == {"status": 0, "total": 5000, "offset": 1024, "data": b"abc"}
    assert p.unpack_file_wrok(p.pack_file_wrok(p.Status.OK, 42)) == {"status": 0, "written": 42}


def test_console_data_roundtrip():
    cd = p.unpack_console_data(p.pack_console_data(10, 13, 1, b"abc"))
    assert cd == {"base_seq": 10, "next_seq": 13, "overflow": True, "data": b"abc"}


def test_error_roundtrip():
    assert p.unpack_error(p.pack_error(p.Status.NOT_FOUND, "nope")) == (1, "nope")


@pytest.mark.asyncio
async def test_read_frame_handles_partial_and_packed():
    reader = asyncio.StreamReader()
    f1 = p.encode_frame(Op.PING, 5, b"")
    f2 = p.encode_frame(Op.KEYS_ACK, 9, p.pack_keys_ack(3))
    blob = f1 + f2
    for i in range(0, len(blob), 3):          # feed in awkward 3-byte pieces
        reader.feed_data(blob[i:i + 3])
    reader.feed_eof()
    op, rid, _ = await p.read_frame(reader)
    assert (op, rid) == (int(Op.PING), 5)
    op, rid, payload = await p.read_frame(reader)
    assert (op, rid) == (int(Op.KEYS_ACK), 9)
    assert p.unpack_keys_ack(payload) == 3


def test_lzss_roundtrip():
    import os
    from comrade import protocol as P
    cases = [
        b"",
        b"hi",
        (b"LINE %04d " % 7 + b"." * 40 + b"\r\n") * 80,     # console-like
        bytes([0x20, 0x07] * 2000),                          # B800 screen
        b"=" * 300 + b"text\r\n" * 50,
        os.urandom(777),                                     # incompressible
        bytes(range(256)) * 4,
    ]
    for data in cases:
        comp = P.lzss_compress(data)
        assert P.lzss_decompress(comp, len(data)) == data


def test_lzss_compressed_frame_via_framer():
    from comrade import protocol as P
    payload = (b"DIRECTORY LISTING " + b" " * 20 + b"\r\n") * 30
    comp = P.lzss_compress(payload)
    assert len(comp) + 2 < len(payload)                      # worth compressing
    body = bytes([len(payload) & 0xFF, len(payload) >> 8]) + comp
    op = int(P.Op.CONSOLE_DATA) | P.COMPRESSED_FLAG
    wire = P.encode_serial(op, 0x1234, body)
    fr = P.SerialFramer()
    fr.feed(wire)
    frames = fr.frames()
    assert len(frames) == 1
    rop, rid, rpayload = frames[0]
    assert rop == int(P.Op.CONSOLE_DATA) and rid == 0x1234   # flag stripped
    assert rpayload == payload                               # decompressed


def test_dir_data_roundtrip():
    from comrade import protocol as P
    # build a DIR_DATA payload by hand and decode it
    def entry(attr, time, date, size, name):
        nb = name.encode("cp437")
        return bytes([attr, time & 0xFF, time >> 8, date & 0xFF, date >> 8,
                      size & 0xFF, (size >> 8) & 0xFF, (size >> 16) & 0xFF,
                      (size >> 24) & 0xFF, len(nb)]) + nb
    # 2018-10-19 11:26:00 -> date=(38<<9)|(10<<5)|19, time=(11<<11)|(26<<5)|0
    d = (38 << 9) | (10 << 5) | 19
    t = (11 << 11) | (26 << 5) | 0
    body = bytes([2, 0, 0]) + entry(0x20, t, d, 12345, "README.TXT") \
                            + entry(0x10, t, d, 0, "SUB1")
    info = P.unpack_dir_data(body)
    assert info["count"] == 2 and info["more"] is False
    a, b = info["entries"]
    assert a["name"] == "README.TXT" and a["size"] == 12345 and not a["is_dir"]
    assert a["mtime"] == "2018-10-19 11:26:00"
    assert b["name"] == "SUB1" and b["is_dir"] and b["size"] == 0


def test_file_attr_codec():
    from comrade import protocol as P
    req = P.pack_file_attr("C:\\FOO.TXT", do_set=True, attr=0x22)
    # [len:2]["C:\FOO.TXT"][set:1][attr:1]
    assert req[-2] == 1 and req[-1] == 0x22
    assert P.unpack_file_attr_ok(bytes([P.Status.OK, 0x27])) == {"status": 0, "attr": 0x27}


def test_framer_resyncs_past_bogus_length():
    # A stray SYNC + a huge bogus length must NOT make the de-framer wait for
    # ~64 KB (real-serial head-of-line stall); it resyncs and finds the good frame.
    from comrade import protocol as P
    good = P.encode_serial(P.Op.PONG, 5, b"hi")
    noise = bytes([P.SYNC, 0x99, 0x00, 0x00, 0xFF, 0xFF, 0x00])   # len=0xFFFF > MAX_FRAME_PAYLOAD
    fr = P.SerialFramer(); fr.feed(noise + good)
    assert (int(P.Op.PONG), 5, b"hi") in fr.frames()


def test_framer_survives_corrupt_compressed_frame():
    # A checksum-passing but corrupt compressed frame must be dropped, not crash
    # the reader; a following good frame must still parse.
    from comrade import protocol as P
    bad_payload = bytes([10, 0]) + bytes([0x00, 0x00, 0x10])   # match dist past start -> ValueError
    bad = P.encode_serial(int(P.Op.CONSOLE_DATA) | P.COMPRESSED_FLAG, 7, bad_payload)
    good = P.encode_serial(P.Op.PONG, 8, b"ok")
    fr = P.SerialFramer(); fr.feed(bad + good)
    frames = fr.frames()                                       # must not raise
    assert (int(P.Op.PONG), 8, b"ok") in frames


def test_mem_and_io_codecs():
    from comrade import protocol as P
    # mem read
    assert P.unpack_mem_data(P.pack_mem_data(P.Status.OK, 0xB8000, b"hi")) == \
        {"status": 0, "addr": 0xB8000, "len": 2, "data": b"hi"}
    rd = P.pack_mem_read(0x400, 16)
    assert rd == bytes([0x00, 0x04, 0x00, 0x00, 16, 0x00])
    wr = P.pack_mem_write(0x4F0, b"\xAA\xBB")
    assert wr[-2:] == b"\xAA\xBB" and P.unpack_mem_wrok(bytes([0, 2, 0]))["written"] == 2
    # io
    assert P.pack_io_in(0x21, 1) == bytes([0x21, 0x00, 0x01])
    assert P.unpack_io_data(bytes([0, 2, 0x34, 0x12, 0, 0])) == {"status": 0, "width": 2, "value": 0x1234}
    assert P.pack_io_out(0x43, 1, 0x36) == bytes([0x43, 0x00, 0x01, 0x36, 0, 0, 0])


def test_lzss_decompress_rejects_truncated():
    """A truncated compressed stream must RAISE, not silently return short bytes
    (that silent-short path is how file_read lost its last character)."""
    import pytest
    from comrade import protocol
    payload = b"\x20" * 200 + b"\xFE"            # repetitive body, distinct tail
    comp = protocol.lzss_compress(payload)
    # full stream decodes exactly
    assert protocol.lzss_decompress(comp, len(payload)) == payload
    # dropping the last compressed byte must now raise, not return payload[:-1]
    with pytest.raises(ValueError):
        protocol.lzss_decompress(comp[:-1], len(payload))


def test_unpack_file_data_rejects_short():
    import pytest, struct
    from comrade import protocol
    good = protocol.pack_file_data(0, 10, 0, b"0123456789")
    assert protocol.unpack_file_data(good)["data"] == b"0123456789"
    # header claims dlen=10 but only 3 data bytes present -> reject
    short = struct.pack("<BIIH", 0, 10, 0, 10) + b"abc"
    with pytest.raises(protocol.ProtocolError):
        protocol.unpack_file_data(short)


def test_framer_drops_truncated_compressed_frame():
    """A checksum-valid compressed frame whose LZSS stream decodes short is
    SKIPPED whole (not delivered truncated); a following good frame still parses."""
    import struct
    from comrade import protocol
    from comrade.protocol import Op, COMPRESSED_FLAG, SerialFramer
    data = b"\x20" * 200 + b"\xFE"
    payload = protocol.pack_file_data(0, len(data), 0, data)
    comp = struct.pack("<H", len(payload)) + protocol.lzss_compress(payload)
    bad = protocol.encode_serial(Op.FILE_DATA | COMPRESSED_FLAG, 5, comp[:-1])  # truncated
    good = protocol.encode_serial(Op.FILE_DATA, 6, payload)                     # raw, valid
    fr = SerialFramer()
    fr.feed(bad)
    assert fr.frames() == []                     # corrupt-short frame dropped, nothing emitted
    fr.feed(good)
    out = fr.frames()
    assert len(out) == 1 and out[0][1] == 6
    assert protocol.unpack_file_data(out[0][2])["data"] == data


def test_crc16_matches_standard():
    """CRC-16/CCITT-FALSE check value -- locks the algorithm so the Python and C
    (src/resident.cpp) implementations agree on the wire."""
    from comrade import protocol
    assert protocol.crc16(b"123456789") == 0x29B1


def test_crc_frame_roundtrip_and_autodetect():
    from comrade import protocol
    from comrade.protocol import Op, SerialFramer
    # CRC frame decodes, and the framer detects the box speaks CRC.
    fr = SerialFramer()
    fr.feed(protocol.encode_serial(Op.PONG, 7, b"hello", crc=True))
    out = fr.frames()
    assert out == [(int(Op.PONG), 7, b"hello")] and fr.peer_crc is True
    # legacy additive frame decodes, and peer_crc flips back to additive.
    fr.feed(protocol.encode_serial(Op.PONG, 8, b"hi", crc=False))
    assert fr.frames() == [(int(Op.PONG), 8, b"hi")] and fr.peer_crc is False


def test_crc_frame_rejects_corruption():
    """A single-byte corruption in a CRC frame is reliably rejected (the additive
    checksum's blind spots are what let the file_read corruption through)."""
    from comrade import protocol
    from comrade.protocol import Op, SerialFramer
    frame = bytearray(protocol.encode_serial(Op.PONG, 1, b"ABCDEFGH", crc=True))
    frame[8] ^= 0x01                       # flip a payload bit
    fr = SerialFramer(); fr.feed(bytes(frame))
    assert fr.frames() == []               # corrupt frame dropped, nothing delivered


def test_win95_screenshot_codec():
    from comrade import protocol as P
    request = P.pack_win_screenshot(80, 60)
    assert request == bytes([80, 0, 60, 0])
    payload = bytes([P.Status.OK, 2, 0, 1, 0, 1, 2, 0, 10, 20])
    assert P.unpack_win_screenshot(payload) == {
        "status": 0, "width": 2, "height": 1, "format": 1,
        "data": b"\x0a\x14",
    }
