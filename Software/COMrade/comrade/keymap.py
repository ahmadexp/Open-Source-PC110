"""
keymap.py - translate a human-friendly key string into BIOS keyboard-buffer
word pairs (scancode high byte, ASCII low byte) for KEYS_SEND.

Grammar accepted by parse():
  * Literal printable characters -> (physical scancode, ascii).
  * Newlines/tabs in the input map to {Enter}/{Tab}.
  * Brace tokens for named / special keys, case-insensitive:
      {Enter} {Esc} {Tab} {Backspace} {Space} {Del} {Ins}
      {Up} {Down} {Left} {Right} {Home} {End} {PgUp} {PgDn}
      {F1}..{F12}
      {Ctrl+C} (any letter); shorthand ^C outside braces.
  * {{ and }} are literal braces.

Special keys carry ASCII 0x00, so the scancode high byte is what the DOS
program reads -- those entries are the load-bearing ones.
"""

from __future__ import annotations

# Physical scancode for the base (unshifted) character on a US keyboard.
_SCAN_FOR_CHAR = {
    "a": 0x1E, "b": 0x30, "c": 0x2E, "d": 0x20, "e": 0x12, "f": 0x21,
    "g": 0x22, "h": 0x23, "i": 0x17, "j": 0x24, "k": 0x25, "l": 0x26,
    "m": 0x32, "n": 0x31, "o": 0x18, "p": 0x19, "q": 0x10, "r": 0x13,
    "s": 0x1F, "t": 0x14, "u": 0x16, "v": 0x2F, "w": 0x11, "x": 0x2D,
    "y": 0x15, "z": 0x2C,
    "1": 0x02, "2": 0x03, "3": 0x04, "4": 0x05, "5": 0x06,
    "6": 0x07, "7": 0x08, "8": 0x09, "9": 0x0A, "0": 0x0B,
    "-": 0x0C, "=": 0x0D, "[": 0x1A, "]": 0x1B, ";": 0x27,
    "'": 0x28, "`": 0x29, "\\": 0x2B, ",": 0x33, ".": 0x34, "/": 0x35,
    " ": 0x39,
}
# Shifted symbols share the scancode of the unshifted key on the same cap.
_SHIFT_SCAN = {
    "!": 0x02, "@": 0x03, "#": 0x04, "$": 0x05, "%": 0x06, "^": 0x07,
    "&": 0x08, "*": 0x09, "(": 0x0A, ")": 0x0B, "_": 0x0C, "+": 0x0D,
    "{": 0x1A, "}": 0x1B, ":": 0x27, '"': 0x28, "~": 0x29, "|": 0x2B,
    "<": 0x33, ">": 0x34, "?": 0x35,
}

# Named keys -> (scancode, ascii).
_NAMED = {
    "enter": (0x1C, 0x0D), "return": (0x1C, 0x0D), "cr": (0x1C, 0x0D),
    "esc": (0x01, 0x1B), "escape": (0x01, 0x1B),
    "tab": (0x0F, 0x09),
    "backspace": (0x0E, 0x08), "bksp": (0x0E, 0x08), "bs": (0x0E, 0x08),
    "space": (0x39, 0x20),
    "up": (0x48, 0x00), "down": (0x50, 0x00),
    "left": (0x4B, 0x00), "right": (0x4D, 0x00),
    "home": (0x47, 0x00), "end": (0x4F, 0x00),
    "pgup": (0x49, 0x00), "pgdn": (0x51, 0x00),
    "ins": (0x52, 0x00), "insert": (0x52, 0x00),
    "del": (0x53, 0x00), "delete": (0x53, 0x00),
    "f1": (0x3B, 0x00), "f2": (0x3C, 0x00), "f3": (0x3D, 0x00),
    "f4": (0x3E, 0x00), "f5": (0x3F, 0x00), "f6": (0x40, 0x00),
    "f7": (0x41, 0x00), "f8": (0x42, 0x00), "f9": (0x43, 0x00),
    "f10": (0x44, 0x00), "f11": (0x85, 0x00), "f12": (0x86, 0x00),
}


class KeyParseError(ValueError):
    pass


def _scan_for(ch: str) -> int:
    if ch in _SCAN_FOR_CHAR:
        return _SCAN_FOR_CHAR[ch]
    low = ch.lower()
    if low in _SCAN_FOR_CHAR:           # uppercase letter -> base key scancode
        return _SCAN_FOR_CHAR[low]
    if ch in _SHIFT_SCAN:
        return _SHIFT_SCAN[ch]
    return 0x00


def _ctrl(letter: str):
    letter = letter.lower()
    if len(letter) != 1 or not ("a" <= letter <= "z"):
        raise KeyParseError(f"Ctrl+{letter!r}: expected a single letter")
    return (_SCAN_FOR_CHAR[letter], ord(letter) - 0x60)


def _token(name: str):
    key = name.strip().lower()
    if key in _NAMED:
        return _NAMED[key]
    if key.startswith("ctrl+"):
        return _ctrl(key[5:])
    if key.startswith("^") and len(key) == 2:
        return _ctrl(key[1])
    raise KeyParseError(f"unknown key token: {{{name}}}")


# ----------------------------------------------------------------------------
# Hardware (8042) injection: raw Set-1 make/break scancodes. Unlike the BIOS
# scancodes above, the grey navigation keys carry an 0xE0 prefix, F11/F12 differ,
# and a break code = make | 0x80 (0xE0 stays in front). The host emits this raw
# stream and the agent feeds it to the keyboard controller (a real INT 9 each),
# so it reaches programs that bypass the BIOS buffer (games, full-screen apps).
_HW_NAMED = {
    "enter": (0x1C,), "return": (0x1C,), "cr": (0x1C,),
    "esc": (0x01,), "escape": (0x01,), "tab": (0x0F,),
    "backspace": (0x0E,), "bksp": (0x0E,), "bs": (0x0E,), "space": (0x39,),
    "shift": (0x2A,), "lshift": (0x2A,), "rshift": (0x36,),
    "ctrl": (0x1D,), "lctrl": (0x1D,), "alt": (0x38,), "lalt": (0x38,),
    "caps": (0x3A,), "capslock": (0x3A,),
    "f1": (0x3B,), "f2": (0x3C,), "f3": (0x3D,), "f4": (0x3E,), "f5": (0x3F,),
    "f6": (0x40,), "f7": (0x41,), "f8": (0x42,), "f9": (0x43,), "f10": (0x44,),
    "f11": (0x57,), "f12": (0x58,),
    "up": (0xE0, 0x48), "down": (0xE0, 0x50), "left": (0xE0, 0x4B), "right": (0xE0, 0x4D),
    "home": (0xE0, 0x47), "end": (0xE0, 0x4F), "pgup": (0xE0, 0x49), "pgdn": (0xE0, 0x51),
    "ins": (0xE0, 0x52), "insert": (0xE0, 0x52), "del": (0xE0, 0x53), "delete": (0xE0, 0x53),
    "rctrl": (0xE0, 0x1D), "ralt": (0xE0, 0x38),
}
_LSHIFT_MAKE, _LSHIFT_BREAK = 0x2A, 0xAA


def _hw_make(key: str):
    """Make-code tuple for a key name or a single character."""
    if len(key) == 1:
        ch = key
        if ch in _SCAN_FOR_CHAR:
            return (_SCAN_FOR_CHAR[ch],)
        if ch.lower() in _SCAN_FOR_CHAR:          # letter -> base key (shift added by caller)
            return (_SCAN_FOR_CHAR[ch.lower()],)
        if ch in _SHIFT_SCAN:
            return (_SHIFT_SCAN[ch],)
        raise KeyParseError(f"no scancode for character {ch!r}")
    k = key.strip().lower()
    if k in _HW_NAMED:
        return _HW_NAMED[k]
    raise KeyParseError(f"unknown key: {key!r}")


def _break(make):
    return make[:-1] + (make[-1] | 0x80,)


def key_make(key: str) -> bytes:
    """Raw scancodes for pressing (and holding) a key DOWN."""
    return bytes(_hw_make(key))


def key_break(key: str) -> bytes:
    """Raw scancodes for releasing a key (UP)."""
    return bytes(_break(_hw_make(key)))


def to_scancodes(s: str) -> bytes:
    """Raw make/break stream that *types* string `s` on the hardware keyboard,
    wrapping capitals and shifted symbols with Left-Shift."""
    out = bytearray()
    for ch in s:
        if ch in ("\n", "\r"):
            out += bytes((0x1C, 0x9C)); continue
        if ch == "\t":
            out += bytes((0x0F, 0x8F)); continue
        make = _hw_make(ch)
        shifted = ch.isupper() or ch in _SHIFT_SCAN
        if shifted:
            out.append(_LSHIFT_MAKE)
        out += bytes(make) + bytes(_break(make))
        if shifted:
            out.append(_LSHIFT_BREAK)
    return bytes(out)


def to_scancode_keys(s: str) -> list:
    """Like to_scancodes(), but as a LIST of per-character raw make/break byte
    sequences (each = one keypress, shift-wrapped as needed). Lets the host pace
    and batch hardware injection so it never overruns the ~15-slot BIOS buffer."""
    return [to_scancodes(ch) for ch in s]


def parse(s: str):
    """Return a list of (scancode, ascii) byte pairs."""
    pairs = []
    i = 0
    n = len(s)
    while i < n:
        ch = s[i]
        if ch == "{":
            if i + 1 < n and s[i + 1] == "{":
                pairs.append((_scan_for("{"), ord("{")))
                i += 2
                continue
            end = s.find("}", i + 1)
            if end == -1:
                raise KeyParseError("unterminated '{' token")
            pairs.append(_token(s[i + 1:end]))
            i = end + 1
            continue
        if ch == "}":
            if i + 1 < n and s[i + 1] == "}":
                pairs.append((_scan_for("}"), ord("}")))
                i += 2
                continue
            raise KeyParseError("unbalanced '}'")
        if ch == "^" and i + 1 < n and s[i + 1].isalpha():
            pairs.append(_ctrl(s[i + 1]))
            i += 2
            continue
        if ch == "\n":
            pairs.append(_NAMED["enter"])
        elif ch == "\r":
            pass  # fold CR into the following LF / ignore lone CR
        elif ch == "\t":
            pairs.append(_NAMED["tab"])
        else:
            pairs.append((_scan_for(ch), ord(ch) & 0xFF))
        i += 1
    return pairs
