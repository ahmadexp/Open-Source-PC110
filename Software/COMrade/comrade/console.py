"""
console.py - decode the captured console output stream (CONSOLE_DATA) into
text for the console.read tool.

The DOS side hooks INT 29h ("Fast Console Output") and appends every emitted
character to a resident scrollback ring, sequence-numbered.  We pull bytes by
sequence number, so fast scrolling output is never lost.  This module just
turns the raw CP437 byte stream into readable text and tracks gaps.
"""

from __future__ import annotations

# Control bytes we keep as-is in the transcript.
_KEEP = {0x09, 0x0A, 0x0D}   # TAB, LF, CR


def to_text(data: bytes, normalize_newlines: bool = True,
            strip_other_controls: bool = True) -> str:
    """Decode a CONSOLE_DATA byte run to a Unicode transcript."""
    if normalize_newlines:
        data = data.replace(b"\r\n", b"\n").replace(b"\r", b"\n")
    if strip_other_controls:
        # Keep printable bytes (>=0x20), the kept controls, and the DEL/high
        # range (CP437 box drawing etc.).  Drop BEL, form feed, etc.
        data = bytes(b for b in data if b >= 0x20 or b in _KEEP)
    return data.decode("cp437")


def format_chunk(chunk: dict) -> dict:
    """Turn an unpacked CONSOLE_DATA dict into the console.read return shape."""
    text = to_text(chunk["data"])
    out = {
        "base_seq": chunk["base_seq"],
        "next_seq": chunk["next_seq"],
        "overflow": chunk["overflow"],
        "text": text,
    }
    if chunk["overflow"]:
        out["note"] = ("output was dropped before base_seq (resident ring "
                       "overflowed); some console text is missing")
    return out
