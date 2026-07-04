#!/usr/bin/env python3
# Generate TILES.INC : Easy-Setup-style tile artwork for PS2GUI.
#  - 10 category icons + several item-type icons, 48x48, red line-art on a white
#    tile (stored monochrome: set bit = draw pixel in the current colour).
#  - the "PS2-GUI" title bitmap and the little duck.
# Bit packing: row = ceil(W/16) words, MSB = leftmost pixel.
from PIL import Image, ImageDraw, ImageFont

S = 48
LW = 3   # line width

def new(w=S, h=S):
    im = Image.new("L", (w, h), 255)
    return im, ImageDraw.Draw(im)

def words_of(im):
    w, h = im.size
    ww = (w + 15) // 16
    px = im.load()
    out = []
    for r in range(h):
        row = [0] * ww
        for c in range(w):
            if px[c, r] < 128:
                row[c // 16] |= (1 << (15 - (c % 16)))
        out.extend(row)
    return out, ww, h

icons = {}   # name -> 48x48 image

# ---- battery (Power & Battery) ----
im, d = new()
d.rectangle([6, 15, 36, 36], outline=0, width=LW)
d.rectangle([36, 21, 41, 30], fill=0)
for x in (13, 21, 29):
    d.rectangle([x, 20, x + 3, 31], fill=0)
icons["batt"] = im

# ---- monitor (Display) ----
im, d = new()
d.rectangle([5, 6, 42, 32], outline=0, width=LW)
d.rectangle([11, 12, 36, 26], outline=0, width=1)
d.rectangle([20, 32, 27, 38], fill=0)
d.rectangle([13, 38, 34, 42], fill=0)
icons["disp"] = im

# ---- plug (Devices) ----
im, d = new()
d.line([17, 4, 17, 14], fill=0, width=LW)
d.line([30, 4, 30, 14], fill=0, width=LW)
d.rectangle([11, 14, 36, 28], outline=0, width=LW)
d.line([23, 28, 23, 44], fill=0, width=LW)
icons["dev"] = im

# ---- keyboard + pointer (Keyboard & Pointer) ----
im, d = new()
d.rectangle([3, 14, 38, 34], outline=0, width=LW)
for yy in (19, 25):
    for xx in (9, 15, 21, 27, 33):
        d.rectangle([xx, yy, xx + 2, yy + 2], fill=0)
d.polygon([(33, 28), (33, 45), (37, 40), (41, 45), (44, 42), (40, 38), (45, 37)], outline=0)
icons["kbd"] = im

# ---- gear (Advanced) ----
im, d = new()
d.ellipse([12, 12, 36, 36], outline=0, width=LW)
d.ellipse([20, 20, 28, 28], outline=0, width=1)
for ang, pt in [(0, (40, 24)), (1, (24, 40)), (2, (8, 24)), (3, (24, 8)),
                (4, (36, 36)), (5, (12, 36)), (6, (12, 12)), (7, (36, 12))]:
    d.rectangle([pt[0] - 3, pt[1] - 3, pt[0] + 3, pt[1] + 3], fill=0)
d.ellipse([16, 16, 32, 32], fill=255)
d.ellipse([16, 16, 32, 32], outline=0, width=LW)
icons["adv"] = im

# ---- chip / ROM (Dumps & ROM) ----
im, d = new()
d.rectangle([12, 12, 36, 36], outline=0, width=LW)
d.rectangle([19, 19, 29, 29], outline=0, width=1)
for x in (16, 24, 32):
    d.line([x, 4, x, 11], fill=0, width=2)
    d.line([x, 37, x, 44], fill=0, width=2)
for y in (16, 24, 32):
    d.line([4, y, 11, y], fill=0, width=2)
    d.line([37, y, 44, y], fill=0, width=2)
icons["chip"] = im

# ---- clipboard + check (System Test) ----
im, d = new()
d.rectangle([9, 6, 39, 43], outline=0, width=LW)
d.rectangle([18, 3, 30, 9], fill=0)
d.line([14, 26, 21, 33], fill=0, width=LW)
d.line([21, 33, 35, 16], fill=0, width=LW)
icons["check"] = im

# ---- magnifier (Diagnostics) ----
im, d = new()
d.ellipse([6, 6, 30, 30], outline=0, width=LW)
d.line([28, 28, 43, 43], fill=0, width=4)
icons["mag"] = im

# ---- floppy + restore arrow (Backup & Restore) ----
im, d = new()
d.rectangle([6, 6, 40, 40], outline=0, width=LW)
d.rectangle([14, 6, 30, 16], fill=0)          # shutter
d.rectangle([14, 24, 32, 38], outline=0, width=1)  # label
icons["floppy"] = im

# ---- info circle (Information) ----
im, d = new()
d.ellipse([6, 6, 42, 42], outline=0, width=LW)
d.ellipse([21, 13, 27, 19], fill=0)           # dot
d.rectangle([21, 22, 27, 36], fill=0)         # stem
icons["info"] = im

# ---- sliders (a setting: R_ITEM) ----
im, d = new()
for i, y in enumerate((12, 24, 36)):
    d.line([6, y, 42, y], fill=0, width=2)
    kx = (30, 14, 34)[i]
    d.rectangle([kx - 4, y - 5, kx + 4, y + 5], fill=0)
icons["set"] = im

# ---- play triangle (an action: R_ACT) ----
im, d = new()
d.polygon([(14, 8), (14, 40), (40, 24)], outline=0)
d.polygon([(16, 12), (16, 36), (36, 24)], fill=255)
d.polygon([(16, 12), (16, 36), (36, 24)], outline=0, width=1)
icons["run"] = im

order = ["batt", "disp", "dev", "kbd", "adv", "chip", "check", "mag",
         "floppy", "info", "set", "run"]

# ---- title "PS2-GUI" ----
def load_font(sz):
    for p in ["/System/Library/Fonts/Supplemental/Arial Bold.ttf",
              "/Library/Fonts/Arial Bold.ttf",
              "/System/Library/Fonts/Helvetica.ttc"]:
        try:
            return ImageFont.truetype(p, sz)
        except Exception:
            pass
    return ImageFont.load_default()

f = load_font(34)
tmp = Image.new("L", (400, 60), 255)
td = ImageDraw.Draw(tmp)
td.text((2, 2), "PS2-GUI", font=f, fill=0)
bb = tmp.point(lambda v: 255 if v < 128 else 0).getbbox()   # bbox of dark pixels
title = tmp.crop(bb)
tw = ((title.width + 15) // 16) * 16
canvas = Image.new("L", (tw, title.height), 255)
canvas.paste(title, (0, 0))
title = canvas

# ---- duck (filled silhouette, drawn in white on the mauve desktop) ----
duck, dd = new(48, 32)
dd.ellipse([6, 14, 34, 30], fill=0)      # body
dd.ellipse([26, 4, 40, 18], fill=0)      # head
dd.polygon([(38, 9), (47, 11), (38, 14)], fill=0)  # beak

# ---- emit ----
lines = ["; TILES.INC  -  auto-generated by tools/make_tiles.py",
         "; Easy-Setup tile artwork: 48x48 icons + PS2-GUI title + duck.", ""]

def emit(name, im):
    w, ww, h = words_of(im)
    lines.append("%s:" % name)
    for r in range(h):
        base = r * ww
        lines.append("        dw " + ", ".join("0x%04X" % x for x in w[base:base + ww]))
    return ww, h

for nm in order:
    emit("tile_%s" % nm, icons[nm])
lines.append("")
tw_ww, tw_h = emit("tile_title", title)
lines.append("TITLE_WW equ %d" % tw_ww)
lines.append("TITLE_H  equ %d" % tw_h)
lines.append("")
dk_ww, dk_h = emit("tile_duck", duck)
lines.append("DUCK_WW equ %d" % dk_ww)
lines.append("DUCK_H  equ %d" % dk_h)
lines.append("")
lines.append("; category index -> icon (main-menu order, 10 categories)")
lines.append("cat_tile: dw tile_batt, tile_disp, tile_dev, tile_kbd, tile_adv, "
             "tile_chip, tile_check, tile_mag, tile_floppy, tile_info")
lines.append("")

open("/Users/ahmadbyagowi/git/PS2GUI/TILES.INC", "w").write("\n".join(lines) + "\n")
print("wrote TILES.INC : %d icons, title %dx%d, duck %dx%d"
      % (len(order), title.width, title.height, duck.width, duck.height))
