import pytest

from comrade import keymap


def test_plain_text():
    assert keymap.parse("ab") == [(0x1E, ord("a")), (0x30, ord("b"))]


def test_uppercase_shares_scancode():
    assert keymap.parse("A") == [(0x1E, ord("A"))]


def test_named_keys():
    assert keymap.parse("{Enter}") == [(0x1C, 0x0D)]
    assert keymap.parse("{Esc}") == [(0x01, 0x1B)]
    assert keymap.parse("{Tab}") == [(0x0F, 0x09)]
    assert keymap.parse("{Up}{Down}{Left}{Right}") == [
        (0x48, 0x00), (0x50, 0x00), (0x4B, 0x00), (0x4D, 0x00)]
    assert keymap.parse("{F1}{F10}{F12}") == [(0x3B, 0x00), (0x44, 0x00), (0x86, 0x00)]


def test_ctrl_combos():
    assert keymap.parse("{Ctrl+C}") == [(0x2E, 0x03)]
    assert keymap.parse("^Z") == [(0x2C, 0x1A)]


def test_newline_becomes_enter():
    assert keymap.parse("x\n") == [(0x2D, ord("x")), (0x1C, 0x0D)]


def test_escaped_braces():
    assert keymap.parse("{{") == [(0x1A, ord("{"))]
    assert keymap.parse("}}") == [(0x1B, ord("}"))]


def test_command_line():
    pairs = keymap.parse("dir{Enter}")
    assert pairs[-1] == (0x1C, 0x0D)
    assert [a for _s, a in pairs[:3]] == [ord("d"), ord("i"), ord("r")]


def test_unknown_token_raises():
    with pytest.raises(keymap.KeyParseError):
        keymap.parse("{Wat}")
    with pytest.raises(keymap.KeyParseError):
        keymap.parse("{unterminated")


def test_hardware_scancodes():
    from comrade import keymap as K
    # single keys: make / break (break = make | 0x80; 0xE0 stays in front)
    assert K.key_make("a") == bytes([0x1E]) and K.key_break("a") == bytes([0x9E])
    assert K.key_make("space") == bytes([0x39]) and K.key_break("space") == bytes([0xB9])
    assert K.key_make("up") == bytes([0xE0, 0x48]) and K.key_break("up") == bytes([0xE0, 0xC8])
    assert K.key_make("left") == bytes([0xE0, 0x4B])
    # typing: lowercase -> make+break; capital/symbol -> wrapped in Left-Shift
    assert K.to_scancodes("a") == bytes([0x1E, 0x9E])
    assert K.to_scancodes("A") == bytes([0x2A, 0x1E, 0x9E, 0xAA])
    assert K.to_scancodes("!") == bytes([0x2A, 0x02, 0x82, 0xAA])   # shift+1
    assert K.to_scancodes("hi") == bytes([0x23, 0xA3, 0x17, 0x97])
    assert K.to_scancodes("\n") == bytes([0x1C, 0x9C])
