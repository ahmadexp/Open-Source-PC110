from comrade import console


def test_crlf_normalized():
    assert console.to_text(b"a\r\nb\rc\n") == "a\nb\nc\n"


def test_control_bytes_stripped_but_tabs_kept():
    assert console.to_text(b"x\x07y\tz") == "xy\tz"   # BEL dropped, TAB kept


def test_cp437_box_chars_preserved():
    # 0xC9 is a CP437 box-drawing char; should decode, not be dropped.
    assert console.to_text(b"\xc9") == "╔"


def test_format_chunk_overflow_note():
    out = console.format_chunk({"base_seq": 10, "next_seq": 13,
                                "overflow": True, "data": b"abc"})
    assert out["text"] == "abc"
    assert out["base_seq"] == 10 and out["next_seq"] == 13
    assert "note" in out and "dropped" in out["note"]
