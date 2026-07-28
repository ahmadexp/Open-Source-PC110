"""
screen.py - decode a SCREEN_DATA payload (raw CP437 char/attr cells) into a
text rendering plus structured cells and cursor, for the screen.read tool.

This is the inverse of the DOS side's B800 snapshot: video memory stores each
cell as [char byte, attribute byte].  The attribute byte is
blink(7) bg(6-4) fg(3-0).
"""

from __future__ import annotations

from dataclasses import dataclass

from . import protocol


@dataclass
class ScreenView:
    mode: int
    cols: int
    rows: int
    cursor: dict          # {"col", "row", "visible"}
    text: str             # rows joined by "\n"
    cells: list           # rows x cols of {"ch","fg","bg","blink"}

    def to_dict(self, include_cells: bool = False, annotate_cursor: bool = False):
        out = {
            "mode": self.mode,
            "cols": self.cols,
            "rows": self.rows,
            "cursor": self.cursor,
            "text": self.text_with_cursor() if annotate_cursor else self.text,
        }
        if include_cells:
            out["cells"] = self.cells
        return out

    def text_with_cursor(self) -> str:
        """Same text but with a U+2588 block marker at the cursor cell."""
        lines = self.text.split("\n")
        r, c = self.cursor["row"], self.cursor["col"]
        if 0 <= r < len(lines):
            line = lines[r]
            if len(line) < self.cols:
                line = line.ljust(self.cols)
            if 0 <= c < len(line):
                line = line[:c] + "█" + line[c + 1:]
            lines[r] = line
        return "\n".join(lines)


def render(payload: bytes, rstrip: bool = True) -> ScreenView:
    info = protocol.unpack_screen_data(payload)
    cols, rows = info["cols"], info["rows"]
    cells_raw = info["cells"]
    text_rows = []
    cell_rows = []
    for r in range(rows):
        chars = []
        cell_row = []
        for c in range(cols):
            idx = 2 * (r * cols + c)
            if idx + 1 >= len(cells_raw):
                ch_byte, attr = 0x20, 0x07
            else:
                ch_byte, attr = cells_raw[idx], cells_raw[idx + 1]
            if ch_byte == 0x00:
                ch_byte = 0x20  # unwritten cells read as NUL -> space
            chars.append(bytes([ch_byte]).decode("cp437"))
            cell_row.append({
                "ch": bytes([ch_byte]).decode("cp437"),
                "fg": attr & 0x0F,
                "bg": (attr >> 4) & 0x07,
                "blink": bool((attr >> 7) & 1),
            })
        line = "".join(chars)
        text_rows.append(line.rstrip() if rstrip else line)
        cell_rows.append(cell_row)
    return ScreenView(
        mode=info["mode"], cols=cols, rows=rows,
        cursor=info["cursor"], text="\n".join(text_rows), cells=cell_rows,
    )
