"""
End-to-end test of the bridge against the in-process DOS double (no QEMU):
MockDos runs a loopback serial socket (like QEMU's COM1<->socket bridge), the
ConnectionManager connects to it, and we drive every high-level operation plus
the MCP tools.
"""

import asyncio

import pytest
import pytest_asyncio

from comrade import keymap, screen, server
from comrade.connection import ConnectionManager
from mock_dos import MockDos


@pytest_asyncio.fixture
async def linked():
    dos = MockDos(chunk_max=512)
    await dos.start_server()
    cm = ConnectionManager(op_timeout=5, chunk_max=512)
    await cm.start(dos.open_stream)
    await asyncio.wait_for(cm.connected.wait(), 5)
    try:
        yield cm, dos
    finally:
        await cm.stop()
        await dos.close()


@pytest.mark.asyncio
async def test_hello_and_ping(linked):
    cm, dos = linked
    assert cm.hello["machine"].startswith("MOCK DOS")
    assert cm.hello["cols"] == 80 and cm.hello["rows"] == 25
    rtt = await cm.ping()
    assert rtt >= 0


@pytest.mark.asyncio
async def test_screen_read(linked):
    cm, dos = linked
    dos.set_screen(["HELLO DOS", "second line"])
    view = screen.render(await cm.get_screen())
    assert view.text.split("\n")[0] == "HELLO DOS"
    assert view.text.split("\n")[1] == "second line"


@pytest.mark.asyncio
async def test_keys_send(linked):
    cm, dos = linked
    injected = await cm.send_keys(keymap.parse("dir{Enter}"))
    assert injected == 4
    assert dos.injected[-1] == (0x1C, 0x0D)


@pytest.mark.asyncio
async def test_file_write_read_roundtrip(linked):
    cm, dos = linked
    blob = bytes(range(256)) * 8         # 2048 bytes -> spans multiple 512B chunks
    blob = bytes(b if b not in (0,) else 1 for b in blob)  # avoid NUL ambiguity in fs
    written = await cm.write_file("C:\\BIG.DAT", blob, mode="overwrite")
    assert written == len(blob)
    data, total, eof = await cm.read_file("C:\\BIG.DAT")
    assert data == blob and total == len(blob) and eof


@pytest.mark.asyncio
async def test_file_append(linked):
    cm, dos = linked
    await cm.write_file("C:\\LOG.TXT", b"one\r\n", mode="overwrite")
    await cm.write_file("C:\\LOG.TXT", b"two\r\n", mode="append")
    data, _total, _eof = await cm.read_file("C:\\LOG.TXT")
    assert data == b"one\r\ntwo\r\n"


@pytest.mark.asyncio
async def test_file_not_found(linked):
    cm, dos = linked
    from comrade.protocol import DosError
    with pytest.raises(DosError):
        await cm.read_file("C:\\NOPE.TXT")


@pytest.mark.asyncio
async def test_console_fast_scroll_lossless(linked):
    cm, dos = linked
    # Simulate a fast, long scroll: 60 KB pushed at once.
    big = "".join(f"line {i:05d} of fast scrolling output\r\n" for i in range(1500))
    dos.push_console(big)
    seq = 0
    collected = []
    while True:
        chunk = await cm.read_console(seq, 512)
        if not chunk["data"]:
            seq = chunk["next_seq"]
            break
        collected.append(chunk["data"])
        seq = chunk["next_seq"]
    joined = b"".join(collected).decode("cp437")
    assert joined == big                 # nothing lost across chunk boundaries
    assert "line 00000" in joined and "line 01499" in joined


@pytest.mark.asyncio
async def test_mcp_tools_via_server(linked):
    cm, dos = linked
    server._state["cm"] = cm
    try:
        st = await server.dos_status()
        assert st["connected"] and st["dos"]["machine"].startswith("MOCK DOS")

        await server.file_write(path="C:\\T.TXT", data="hello world")
        rd = await server.file_read(path="C:\\T.TXT")
        assert rd["data"] == "hello world" and rd["eof"]

        dos.set_screen(["EDITOR VIEW"])
        sr = await server.screen_read()
        assert sr["text"].split("\n")[0] == "EDITOR VIEW"

        res = await server.run_command("dir", timeout=5, idle_ms=300)
        assert "[ran dir]" in res["text"]
        assert "A.TXT" in res["text"]
        assert res["idle"] is True
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_dir_list_and_file_stat(linked):
    cm, dos = linked
    await cm.write_file("C:\\AAA.TXT", b"hello", mode="overwrite")
    await cm.write_file("C:\\BBB.DAT", b"x" * 100, mode="overwrite")
    entries = await cm.list_dir("C:\\*.*")
    names = {e["name"]: e for e in entries}
    assert "AAA.TXT" in names and "BBB.DAT" in names
    assert names["AAA.TXT"]["size"] == 5 and names["BBB.DAT"]["size"] == 100

    server._state["cm"] = cm
    try:
        dl = await server.dir_list("C:\\")          # 'C:\' -> wildcard
        assert dl["count"] >= 2
        st = await server.file_stat("C:\\AAA.TXT")
        assert st["exists"] and st["entry"]["size"] == 5
        miss = await server.file_stat("C:\\NOPE.XXX")
        assert miss["exists"] is False and miss["entry"] is None
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_file_setattr(linked):
    cm, dos = linked
    await cm.write_file("C:\\SECRET.TXT", b"shh", mode="overwrite")
    # default attribute is archive only
    assert await cm.file_attr("C:\\SECRET.TXT") == 0x20

    server._state["cm"] = cm
    try:
        r = await server.file_setattr("C:\\SECRET.TXT", hidden=True, readonly=True)
        assert r["is_hidden"] and r["is_readonly"] and r["attr"] == 0x23
        # visible+flagged through dir_list too
        ents = {e["name"]: e for e in await cm.list_dir("C:\\*.*")}
        assert ents["SECRET.TXT"]["is_hidden"] and ents["SECRET.TXT"]["is_readonly"]
        # clearing one flag preserves the others
        r2 = await server.file_setattr("C:\\SECRET.TXT", readonly=False)
        assert r2["is_hidden"] and not r2["is_readonly"] and r2["attr"] == 0x22
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_start_tolerates_unreachable_box_then_reconnects():
    # The MCP server must come up even if the DOS box / relay is unreachable at
    # startup (the "Failed to connect" bug), and reconnect once it appears.
    dos = MockDos(chunk_max=512)
    await dos.start_server()
    cm = ConnectionManager(op_timeout=2, chunk_max=512)
    calls = {"n": 0}

    async def flaky_open():
        calls["n"] += 1
        if calls["n"] <= 1:                      # first attempt: nothing there yet
            raise ConnectionRefusedError("relay down")
        return await dos.open_stream()

    await cm.start(flaky_open)                    # must NOT raise
    assert not cm.connected.is_set()             # server up, link still down

    server._state["cm"] = cm
    try:
        st = await server.dos_status()           # status works while disconnected
        assert st["connected"] is False
        await asyncio.wait_for(cm.connected.wait(), 6)   # auto-reconnects
        assert cm.hello["machine"].startswith("MOCK DOS")
        assert (await server.dos_status())["connected"] is True
    finally:
        server._state["cm"] = None
        await cm.stop()
        await dos.close()


@pytest.mark.asyncio
async def test_mem_and_io_access(linked):
    cm, dos = linked
    # memory write/read round-trip
    await cm.mem_write(0x4F0, bytes(range(32)))
    assert await cm.mem_read(0x4F0, 32) == bytes(range(32))
    # large (chunked) memory round-trip
    blob = bytes((i * 7) & 0xFF for i in range(2000))
    await cm.mem_write(0x10000, blob)
    assert await cm.mem_read(0x10000, len(blob)) == blob
    # I/O port round-trip (byte + word)
    await cm.io_out(0x80, 0x5A, width=1)
    assert await cm.io_in(0x80, width=1) == 0x5A
    await cm.io_out(0x60, 0xBEEF, width=2)
    assert await cm.io_in(0x60, width=2) == 0xBEEF
    # unsupported width -> error
    from comrade.protocol import DosError
    with pytest.raises(DosError):
        await cm.io_in(0x60, width=4)

    server._state["cm"] = cm
    try:
        r = await server.mem_read("B800:0010", 4)           # SEG:OFF addressing
        assert r["address"] == 0xB8010 and r["encoding"] == "hex"
        await server.mem_write(0xB8000, "4869", encoding="hex")   # hex 'Hi'
        assert (await server.mem_read(0xB8000, 2))["data"] == "4869"
        v = await server.io_in(port=0x80, width=1)
        assert v["value"] == 0x5A and v["hex"] == "0x5a"
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_mem_dump(linked):
    cm, dos = linked
    for i, b in enumerate(b"DEBUG-style\x00\xFF dump!"):
        dos.mem[0xB8000 + i] = b
    server._state["cm"] = cm
    try:
        d = await server.mem_dump("B800:0000", 32)
        assert d["address"] == 0xB8000 and d["length"] == 32
        first = d["text"].splitlines()[0]
        assert first.startswith("B8000  ")          # linear address label
        assert "44 45 42 55 47 2D 73 74-79 6C 65" in first  # 'DEBUG-style' hex, dash mid-row
        assert "DEBUG-style." in first               # ASCII column (NUL -> '.')
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_hardware_key_injection(linked):
    cm, dos = linked
    from comrade import keymap
    # raw stream reaches the agent intact
    n = await cm.send_keys_raw(bytes([0x39, 0xB9]))      # space down, space up
    assert n == 2 and bytes(dos.raw_injected) == bytes([0x39, 0xB9])

    server._state["cm"] = cm
    try:
        dos.raw_injected.clear()
        r = await server.keys_send("Hi", method="hardware")
        assert r["method"] == "hardware"
        assert bytes(dos.raw_injected) == keymap.to_scancodes("Hi")
        # hold + release a key (games)
        dos.raw_injected.clear()
        await server.key_down("up")
        await server.key_up("up")
        assert bytes(dos.raw_injected) == bytes([0xE0, 0x48, 0xE0, 0xC8])
        # bios method still works (default)
        bios = await server.keys_send("x")
        assert bios["method"] == "bios"
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_update_agent_and_reboot(linked, tmp_path):
    cm, dos = linked
    await cm.write_file("C:\\COMRADE.EXE", b"OLD-AGENT-BYTES")   # current on-disk agent
    new = b"NEW-AGENT-v2-" * 80
    exe = tmp_path / "COMRADE.EXE"
    exe.write_bytes(new)
    server._state["cm"] = cm
    try:
        r = await server.update_agent(host_path=str(exe), dos_path="C:\\COMRADE.EXE", timeout=15)
        assert r["ok"] and r["rebooted"]
        assert bytes(dos.fs["C:\\COMRADE.EXE"]) == new          # new binary written
        assert bytes(dos.fs["C:\\COMRADE.BAK"]) == b"OLD-AGENT-BYTES"   # backup kept
        assert r["bytes_written"] == len(new)
        assert "reboot#" in (r["new_version"] or "")           # came back, new version
    finally:
        server._state["cm"] = None


def test_exe_version_extraction(tmp_path):
    from comrade.server import _exe_version
    f = tmp_path / "x.exe"
    f.write_bytes(b"\x00\x01junk COMRADE/a1b2c3d4-dirty-101010\x00more")
    assert _exe_version(str(f)) == "COMRADE/a1b2c3d4-dirty-101010"
    assert _exe_version(str(tmp_path / "nope")) is None


@pytest.mark.asyncio
async def test_check_update(linked, tmp_path):
    cm, dos = linked
    dos.machine = "COMRADE/run111"
    await cm.probe()                               # refresh HELLO -> running version
    server._state["cm"] = cm
    try:
        same = tmp_path / "same.exe"; same.write_bytes(b"x COMRADE/run111\x00")
        diff = tmp_path / "diff.exe"; diff.write_bytes(b"x COMRADE/avail222\x00")
        r1 = await server.check_update(host_path=str(same))
        assert r1["running"] == "COMRADE/run111" and not r1["update_available"]
        r2 = await server.check_update(host_path=str(diff))
        assert r2["available"] == "COMRADE/avail222" and r2["update_available"]
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_read_file_retries_dropped_chunk(linked):
    """A lost/corrupt FILE_READ reply (real-link byte loss) must be re-requested
    and yield the correct file, not a silently-truncated one."""
    cm, dos = linked
    content = b"the quick brown fox jumps over the lazy dog -- distinct tail!\xFE"
    dos.fs["C:\\T.TXT"] = bytearray(content)
    dos.drop_file_reads = 1                       # drop the first reply -> force a retry
    data, total, eof = await cm.read_file("C:\\T.TXT", timeout=0.4)
    assert data == content and total == len(content) and eof
    assert dos.drop_file_reads == 0


@pytest.mark.asyncio
async def test_file_hash(linked):
    cm, dos = linked
    import zlib
    content = b"hash me \xFE\x00\x01" * 50
    dos.fs["C:\\H.BIN"] = bytearray(content)
    h = await cm.file_hash("C:\\H.BIN")
    assert h["status"] == 0 and h["length"] == len(content)
    assert h["crc32"] == zlib.crc32(content) & 0xFFFFFFFF


@pytest.mark.asyncio
async def test_read_file_to_direct(linked, tmp_path):
    cm, dos = linked
    import zlib, hashlib
    content = bytes(range(256)) * 5 + b"\xFE"      # > 1 chunk, distinct tail
    dos.fs["C:\\BIG.BIN"] = bytearray(content)
    dest = tmp_path / "out.bin"
    meta = await cm.read_file_to("C:\\BIG.BIN", str(dest))
    assert dest.read_bytes() == content
    assert meta["verified"] is True and meta["bytes"] == len(content)
    assert meta["crc32"] == zlib.crc32(content) & 0xFFFFFFFF
    assert meta["sha256"] == hashlib.sha256(content).hexdigest()


@pytest.mark.asyncio
async def test_write_file_from_direct(linked, tmp_path):
    cm, dos = linked
    content = b"upload this to the box\xFE" * 60
    src = tmp_path / "in.bin"; src.write_bytes(content)
    meta = await cm.write_file_from("C:\\UP.BIN", str(src))
    assert bytes(dos.fs["C:\\UP.BIN"]) == content
    assert meta["verified"] is True and meta["bytes"] == len(content)


@pytest.mark.asyncio
async def test_direct_tools_and_host_path_security(linked, tmp_path, monkeypatch):
    cm, dos = linked
    import os
    server._state["cm"] = cm
    monkeypatch.setattr(server, "_HOST_FS_ROOT", os.path.realpath(str(tmp_path)))
    try:
        dos.fs["C:\\T.BIN"] = bytearray(b"roundtrip\xFE")
        dest = tmp_path / "got.bin"
        r = await server.file_read("C:\\T.BIN", dest_path=str(dest))
        assert r["mode"] == "direct" and r["verified"] is True
        assert dest.read_bytes() == b"roundtrip\xFE" and "data" not in r   # no content in result
        src = tmp_path / "send.bin"; src.write_bytes(b"sent from host\x01")
        w = await server.file_write("C:\\S.BIN", src_path=str(src))
        assert w["mode"] == "direct" and w["verified"] is True
        assert bytes(dos.fs["C:\\S.BIN"]) == b"sent from host\x01"
        with pytest.raises(ValueError):                  # path outside the allow-root
            await server.file_read("C:\\T.BIN", dest_path="/etc/passwd")
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_file_hash_tool(linked, tmp_path, monkeypatch):
    cm, dos = linked
    import os, zlib
    server._state["cm"] = cm
    monkeypatch.setattr(server, "_HOST_FS_ROOT", os.path.realpath(str(tmp_path)))
    try:
        content = b"in-sync check \xFE" * 30
        dos.fs["C:\\SYNC.BIN"] = bytearray(content)
        # bare hash of the box file
        r = await server.file_hash("C:\\SYNC.BIN")
        assert r["length"] == len(content)
        assert r["crc32"] == zlib.crc32(content) & 0xFFFFFFFF
        assert r["crc32_hex"] == f"{zlib.crc32(content) & 0xFFFFFFFF:08x}"
        # compare against an identical host file -> match
        same = tmp_path / "same.bin"; same.write_bytes(content)
        assert (await server.file_hash("C:\\SYNC.BIN", host_path=str(same)))["match"] is True
        # compare against a different host file -> no match
        diff = tmp_path / "diff.bin"; diff.write_bytes(content + b"x")
        assert (await server.file_hash("C:\\SYNC.BIN", host_path=str(diff)))["match"] is False
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_type_pairs_batches_under_buffer(linked):
    cm, dos = linked
    sizes = []
    orig = cm.send_keys
    async def spy(pairs, timeout=None):
        sizes.append(len(pairs))
        return await orig(pairs, timeout)
    cm.send_keys = spy
    n = await cm.type_pairs([(0x1E, 0x61)] * 10, delay_ms=1, batch=4)
    assert n == 10 and sizes == [4, 4, 2]          # 10 keys -> batches of 4,4,2 (each <15)


@pytest.mark.asyncio
async def test_keys_send_paced_preserves_order_bios(linked):
    cm, dos = linked
    server._state["cm"] = cm
    try:
        text = "abcdefghijklmnopqrstuvwxyz0123456789"   # 36 chars >> buffer
        r = await server.keys_send(text, delay_ms=1)
        assert r["pairs_injected"] == len(text)
        got = "".join(chr(a) for _s, a in dos.injected)
        assert got == text                              # nothing lost or reordered
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_keys_send_paced_hardware(linked):
    cm, dos = linked
    from comrade import keymap
    server._state["cm"] = cm
    try:
        text = "Hello, World! 12345"
        await server.keys_send(text, method="hardware", delay_ms=1)
        assert bytes(dos.raw_injected) == keymap.to_scancodes(text)   # identical stream, just paced
    finally:
        server._state["cm"] = None


@pytest.mark.asyncio
async def test_keys_send_delay_zero_single_frame(linked):
    cm, dos = linked
    calls = []
    orig = cm.send_keys
    async def spy(pairs, timeout=None):
        calls.append(len(pairs))
        return await orig(pairs, timeout)
    cm.send_keys = spy
    server._state["cm"] = cm
    try:
        await server.keys_send("abcdefghij", delay_ms=0)   # opt out of pacing
        assert calls == [10]                                # one frame, no batching
    finally:
        server._state["cm"] = None
