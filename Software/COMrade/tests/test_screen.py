from comrade import protocol as p
from comrade import screen


def _payload(lines, cols=20, rows=3, cur=(0, 0), attr=0x07):
    cells = bytearray()
    for r in range(rows):
        text = lines[r] if r < len(lines) else ""
        for c in range(cols):
            ch = ord(text[c].encode("cp437")) if c < len(text) else 0x20
            cells.append(ch)
            cells.append(attr)
    return p.pack_screen_data(3, cols, rows, cur[0], cur[1], 1, bytes(cells))


def test_render_text_and_cursor():
    view = screen.render(_payload(["HELLO DOS", "line two"], cur=(3, 1)))
    lines = view.text.split("\n")
    assert lines[0] == "HELLO DOS"      # trailing spaces stripped
    assert lines[1] == "line two"
    assert view.cursor == {"col": 3, "row": 1, "visible": True}
    assert view.cols == 20 and view.rows == 3


def test_attribute_decoding():
    cells = bytes([ord("X"), 0x1E])      # fg=0x0E, bg=0x01, blink=0
    view = screen.render(p.pack_screen_data(3, 1, 1, 0, 0, 1, cells))
    cell = view.cells[0][0]
    assert cell["ch"] == "X"
    assert cell["fg"] == 0x0E and cell["bg"] == 0x01 and cell["blink"] is False


def test_cursor_annotation():
    view = screen.render(_payload(["ABCD"], cur=(2, 0)))
    annotated = view.text_with_cursor().split("\n")[0]
    assert annotated[2] == "█"
