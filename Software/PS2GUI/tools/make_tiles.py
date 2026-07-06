#!/usr/bin/env python3
# Generate TILES.INC : Easy-Setup-style tile artwork for PS2GUI.
#  - detailed 48x48 category icons (10) + a rich library of item icons,
#    red pixel-art on a white tile (monochrome: set bit = draw in current colour)
#  - the "PS2-GUI" title bitmap and the duck
#  - cat_tile[10] and row_icon[57] lookup tables (per-item icons, by meaning)
# Bit packing: row = ceil(W/16) words, MSB = leftmost pixel.
from PIL import Image, ImageDraw, ImageFont

S = 48

def canvas():
    im = Image.new("L", (S, S), 255)
    return im, ImageDraw.Draw(im)

# ---------- reusable primitives (draw onto a given ImageDraw) ----------
def p_battery(d, x=6, y=16, w=30, h=18, bolt=False, level=3):
    d.rectangle([x, y, x + w, y + h], outline=0, width=2)
    d.rectangle([x + w, y + 6, x + w + 4, y + h - 6], fill=0)
    for i in range(level):
        bx = x + 4 + i * 8
        d.rectangle([bx, y + 4, bx + 4, y + h - 4], fill=0)
    if bolt:
        cx = x + w // 2
        d.polygon([(cx + 3, y - 6), (cx - 5, y + 8), (cx, y + 8),
                   (cx - 3, y + 22), (cx + 6, y + 6), (cx + 1, y + 6)], fill=0)

def p_monitor(d, x=5, y=6, w=38, h=27, pic=True):
    d.rectangle([x, y, x + w, y + h], outline=0, width=2)
    if pic:
        d.line([x + 6, y + h - 5, x + 15, y + 9, x + 22, y + h - 9,
                x + 32, y + 6, x + w - 4, y + h - 5], fill=0, width=1)
    cx = x + w // 2
    d.rectangle([cx - 3, y + h, cx + 3, y + h + 5], fill=0)
    d.rectangle([x + 7, y + h + 5, x + w - 7, y + h + 8], fill=0)

def p_chip(d, x=12, y=12, w=24):
    d.rectangle([x, y, x + w, y + w], outline=0, width=2)
    d.rectangle([x + 6, y + 6, x + w - 6, y + w - 6], outline=0, width=1)
    for i in range(3):
        c = x + 5 + i * 7
        d.line([c, y - 8, c, y], fill=0, width=2)
        d.line([c, y + w, c, y + w + 8], fill=0, width=2)
        d.line([x - 8, c, x, c], fill=0, width=2)
        d.line([x + w, c, x + w + 8, c], fill=0, width=2)

def p_hdd(d):
    d.rectangle([6, 12, 42, 36], outline=0, width=2)
    d.ellipse([12, 18, 30, 30], outline=0, width=2)
    d.ellipse([19, 23, 23, 27], fill=0)
    d.line([21, 25, 34, 16], fill=0, width=2)
    d.ellipse([33, 29, 39, 33], fill=0)

def p_speaker(d):
    d.polygon([(8, 20), (18, 20), (28, 10), (28, 40), (18, 30), (8, 30)], outline=0, width=2)
    d.arc([26, 12, 40, 38], -60, 60, fill=0, width=2)
    d.arc([30, 16, 48, 34], -55, 55, fill=0, width=2)

def p_floppy(d):
    d.polygon([(6, 6), (36, 6), (42, 12), (42, 42), (6, 42)], outline=0, width=2)
    d.rectangle([14, 6, 30, 16], fill=0)
    d.rectangle([25, 8, 29, 14], fill=255)
    d.rectangle([13, 24, 35, 40], outline=0, width=2)

def p_pccard(d):
    d.rectangle([6, 10, 42, 38], outline=0, width=2)
    d.rectangle([10, 14, 38, 22], outline=0, width=1)
    d.line([12, 34, 36, 34], fill=0, width=2)

def p_keyboard(d):
    d.rectangle([3, 16, 45, 38], outline=0, width=2)
    for yy in (21, 28):
        for xx in range(8, 40, 6):
            d.rectangle([xx, yy, xx + 3, yy + 3], fill=0)
    d.rectangle([15, 33, 33, 36], fill=0)

def p_mouse(d):
    d.rounded_rectangle([16, 8, 34, 40], radius=9, outline=0, width=2)
    d.line([25, 8, 25, 22], fill=0, width=2)
    d.line([20, 14, 30, 14], fill=0, width=1)

def p_gear(d, cx=24, cy=24, r=11):
    d.ellipse([cx - r, cy - r, cx + r, cy + r], outline=0, width=3)
    d.ellipse([cx - 4, cy - 4, cx + 4, cy + 4], fill=0)
    import math
    for k in range(8):
        a = k * math.pi / 4
        x1 = cx + int((r + 1) * math.cos(a)); y1 = cy + int((r + 1) * math.sin(a))
        d.rectangle([x1 - 3, y1 - 3, x1 + 3, y1 + 3], fill=0)

def p_clock(d, cx=24, cy=24, r=17):
    d.ellipse([cx - r, cy - r, cx + r, cy + r], outline=0, width=2)
    d.line([cx, cy, cx, cy - r + 5], fill=0, width=2)
    d.line([cx, cy, cx + r - 8, cy + 3], fill=0, width=2)

def p_phone(d):
    d.arc([8, 8, 40, 40], 90, 250, fill=0, width=4)
    d.ellipse([9, 26, 19, 36], fill=0)
    d.ellipse([29, 9, 39, 19], fill=0)

def p_magbadge(d):
    d.ellipse([28, 28, 40, 40], outline=0, width=2)
    d.line([38, 38, 45, 45], fill=0, width=3)

def p_infobadge(d):
    d.ellipse([30, 30, 46, 46], fill=0)
    d.ellipse([36, 33, 39, 36], fill=255)
    d.rectangle([36, 38, 39, 44], fill=255)

def p_arrow(d, up=True):
    if up:
        d.polygon([(37, 26), (30, 34), (44, 34)], fill=0)
        d.rectangle([35, 34, 39, 44], fill=0)
    else:
        d.polygon([(37, 44), (30, 36), (44, 36)], fill=0)
        d.rectangle([35, 26, 39, 36], fill=0)

# ---------- build the icon dictionary ----------
art = {}
def mk(name, fn):
    im, d = canvas(); fn(d); art[name] = im

# category icons (detailed)
mk("cat_power",  lambda d: p_battery(d, bolt=True, level=3))
mk("cat_disp",   lambda d: p_monitor(d, pic=True))
def _dev(d):
    d.line([17, 4, 17, 15], fill=0, width=3); d.line([31, 4, 31, 15], fill=0, width=3)
    d.rectangle([10, 15, 38, 30], outline=0, width=2)
    d.line([24, 30, 24, 40], fill=0, width=3)
    d.arc([16, 36, 32, 50], 180, 360, fill=0, width=2)
mk("cat_dev", _dev)
def _kbd(d):
    p_keyboard(d)
    d.polygon([(34, 4), (34, 16), (38, 12), (42, 18), (44, 16), (40, 11), (45, 10)], outline=0)
mk("cat_kbd", _kbd)
def _adv(d):
    p_gear(d, cx=19, cy=20, r=9); p_gear(d, cx=33, cy=32, r=7)
mk("cat_adv", _adv)
def _dump(d):
    p_chip(d)
    d.line([18, 20, 30, 20], fill=0, width=1); d.line([18, 24, 30, 24], fill=0, width=1)
mk("cat_dump", _dump)
def _test(d):
    d.rectangle([9, 6, 39, 43], outline=0, width=2)
    d.rectangle([18, 3, 30, 9], fill=0)
    d.line([14, 25, 21, 33], fill=0, width=3); d.line([21, 33, 36, 14], fill=0, width=3)
mk("cat_test", _test)
def _diag(d):
    d.ellipse([6, 6, 30, 30], outline=0, width=3); d.line([28, 28, 44, 44], fill=0, width=4)
    d.line([11, 18, 15, 18, 18, 12, 22, 24, 25, 18], fill=0, width=1)
mk("cat_diag", _diag)
def _backup(d):
    p_floppy(d)
    d.arc([26, 24, 46, 44], 270, 210, fill=0, width=2)
    d.polygon([(44, 30), (40, 24), (48, 26)], fill=0)
mk("cat_backup", _backup)
def _info(d):
    d.ellipse([6, 6, 42, 42], outline=0, width=3)
    d.ellipse([21, 13, 27, 19], fill=0); d.rectangle([21, 22, 27, 37], fill=0)
mk("cat_info", _info)

# item library
mk("leaf", lambda d: (d.pieslice([8, 8, 40, 40], 90, 270, fill=0),
                      d.line([24, 40, 24, 12], fill=255, width=2)))
mk("moon", lambda d: (d.ellipse([8, 8, 40, 40], fill=0),
                      d.ellipse([18, 4, 46, 32], fill=255)))
def _monoff(d):
    p_monitor(d, pic=False); d.line([10, 10, 38, 30], fill=0, width=2)
mk("mon_off", _monoff)
def _gauge(d):
    d.arc([6, 10, 42, 46], 180, 360, fill=0, width=3)
    d.line([24, 42, 36, 18], fill=0, width=3); d.ellipse([21, 39, 27, 45], fill=0)
mk("gauge", _gauge)
def _clam(d):
    d.polygon([(6, 34), (42, 34), (38, 20), (10, 20)], outline=0, width=2)
    d.line([4, 40, 44, 40], fill=0, width=3)
mk("clam", _clam)
mk("phone", p_phone)
mk("bat_bolt", lambda d: p_battery(d, bolt=True, level=2))
mk("battery", lambda d: p_battery(d, level=3))
def _reset(d):
    d.arc([10, 10, 38, 38], 40, 300, fill=0, width=3)
    d.polygon([(34, 6), (40, 16), (28, 15)], fill=0)
mk("reset", _reset)
def _dualmon(d):
    d.rectangle([3, 8, 26, 26], outline=0, width=2)
    d.rectangle([22, 16, 45, 38], outline=0, width=2)
mk("dualmon", _dualmon)
def _expand(d):
    d.polygon([(24, 4), (16, 14), (32, 14)], fill=0)
    d.polygon([(24, 44), (16, 34), (32, 34)], fill=0)
    d.line([24, 14, 24, 34], fill=0, width=2)
mk("expand", _expand)
mk("speaker", p_speaker)
def _wave(d):
    pts = []
    import math
    for x in range(6, 43):
        pts.append((x, 24 - int(14 * math.sin((x - 6) / 5.0))))
    d.line(pts, fill=0, width=2)
mk("wave", _wave)
def _pen(d):
    d.polygon([(8, 40), (12, 30), (34, 8), (40, 14), (18, 36)], outline=0, width=2)
    d.polygon([(8, 40), (12, 34), (14, 38)], fill=0)
mk("pen", _pen)
def _ir(d):
    d.rectangle([6, 18, 14, 30], fill=0)
    for i, r in enumerate((10, 18, 26)):
        d.arc([14, 24 - r, 14 + 2 * r, 24 + r], -55, 55, fill=0, width=2)
mk("ir", _ir)
def _serial(d):
    d.polygon([(8, 16), (40, 16), (36, 32), (12, 32)], outline=0, width=2)
    for xx in (16, 22, 28, 34):
        d.ellipse([xx - 1, 21, xx + 1, 23], fill=0)
    for xx in (19, 25, 31):
        d.ellipse([xx - 1, 26, xx + 1, 28], fill=0)
mk("serial", _serial)
def _modem(d):
    d.rectangle([6, 26, 42, 40], outline=0, width=2)
    d.ellipse([10, 30, 16, 36], fill=0)
    d.rectangle([22, 31, 38, 34], fill=0)
    p_phone_small = d.arc([24, 4, 44, 24], 90, 250, fill=0, width=3)
mk("modem", _modem)
mk("pccard", p_pccard)
mk("keyboard", p_keyboard)
mk("mouse", p_mouse)
def _mouse_mag(d):
    p_mouse(d); p_magbadge(d)
mk("mouse_mag", _mouse_mag)
def _printer(d):
    d.rectangle([8, 20, 40, 34], outline=0, width=2)
    d.rectangle([14, 8, 34, 20], outline=0, width=2)
    d.rectangle([14, 32, 34, 44], outline=0, width=2)
    d.ellipse([34, 24, 37, 27], fill=0)
mk("printer", _printer)
mk("hdd", p_hdd)
def _bolt(d):
    d.polygon([(28, 4), (12, 26), (22, 26), (18, 44), (36, 20), (26, 20)], fill=0)
mk("bolt", _bolt)
def _netring(d):
    d.ellipse([10, 10, 38, 38], outline=0, width=2)
    import math
    for k in range(4):
        a = k * math.pi / 2 + math.pi / 4
        cx = 24 + int(14 * math.cos(a)); cy = 24 + int(14 * math.sin(a))
        d.rectangle([cx - 4, cy - 4, cx + 4, cy + 4], fill=0)
mk("netring", _netring)
def _link(d):
    d.arc([8, 16, 28, 32], 40, 320, fill=0, width=3)
    d.arc([20, 16, 40, 32], -140, 140, fill=0, width=3)
mk("link", _link)
def _chip_dl(d):
    p_chip(d, x=10, y=6, w=20)
    p_arrow(d, up=False)
mk("chip_dl", _chip_dl)
mk("chip", lambda d: p_chip(d))
def _fontA(d):
    try:
        ff = ImageFont.truetype("/System/Library/Fonts/Supplemental/Arial Bold.ttf", 40)
    except Exception:
        ff = ImageFont.load_default()
    d.text((12, 2), "A", font=ff, fill=0)
mk("fontA", _fontA)
def _ram(d):
    d.rectangle([6, 14, 42, 34], outline=0, width=2)
    for xx in (13, 21, 29, 37):
        d.rectangle([xx - 2, 18, xx + 2, 30], outline=0, width=1)
    for xx in range(9, 40, 4):
        d.line([xx, 34, xx, 38], fill=0, width=1)
mk("ram", _ram)
def _mon_color(d):
    p_monitor(d, pic=False)
    for i, xx in enumerate((12, 20, 28)):
        d.rectangle([xx, 12, xx + 6, 26], fill=0 if i != 1 else 255)
        d.rectangle([xx, 12, xx + 6, 26], outline=0, width=1)
mk("mon_color", _mon_color)
mk("clock", p_clock)
def _timer(d):
    p_clock(d, cx=24, cy=26, r=16)
    d.rectangle([20, 4, 28, 9], fill=0)
    d.line([24, 9, 24, 12], fill=0, width=2)
mk("timer", _timer)
def _mag_list(d):
    d.ellipse([6, 6, 30, 30], outline=0, width=3); d.line([28, 28, 44, 44], fill=0, width=4)
    for yy in (13, 19, 25):
        d.line([11, yy, 25, yy], fill=0, width=1)
mk("mag_list", _mag_list)
def _hdd_mag(d):
    p_hdd(d); p_magbadge(d)
mk("hdd_mag", _hdd_mag)
def _bat_mag(d):
    p_battery(d, x=4, y=12, w=26, h=16, level=2); p_magbadge(d)
mk("bat_mag", _bat_mag)
def _card_mag(d):
    p_pccard(d); p_magbadge(d)
mk("card_mag", _card_mag)
def _chip_mag(d):
    p_chip(d, x=8, y=6, w=22); p_magbadge(d)
mk("chip_mag", _chip_mag)
def _save_up(d):
    p_floppy(d); p_arrow(d, up=True)
mk("save_up", _save_up)
def _save_dn(d):
    p_floppy(d); p_arrow(d, up=False)
mk("save_dn", _save_dn)
def _bat_info(d):
    p_battery(d, x=4, y=12, w=26, h=16, level=3); p_infobadge(d)
mk("bat_info", _bat_info)
def _gear_info(d):
    p_gear(d, cx=20, cy=20, r=10); p_infobadge(d)
mk("gear_info", _gear_info)
def _tag(d):
    d.polygon([(6, 14), (28, 14), (42, 24), (28, 34), (6, 34)], outline=0, width=2)
    d.ellipse([11, 21, 17, 27], fill=0)
mk("tag", _tag)
def _power(d):
    d.arc([12, 12, 36, 36], -60, 240, fill=0, width=3)
    d.line([24, 6, 24, 22], fill=0, width=3)
mk("power", _power)

# ---------- per-row icon mapping (57 rows, in rows[] order) ----------
row_icons = [
    # Power & Battery 0..7
    "leaf", "moon", "mon_off", "gauge", "clam", "phone", "bat_bolt", "reset",
    # Display 8..9
    "dualmon", "expand",
    # Devices 10..18
    "speaker", "wave", "speaker", "pen", "pen", "ir", "serial", "modem", "pccard",
    # Keyboard & Pointer 19..23
    "speaker", "keyboard", "clock", "mouse", "mouse_mag",
    # Advanced 24..33
    "printer", "hdd", "pccard", "pccard", "gauge", "battery", "floppy", "bolt", "netring", "link",
    # Dumps & ROM 34..37
    "chip_dl", "chip_dl", "fontA", "chip_dl",
    # System Test 38..45
    "ram", "mon_color", "keyboard", "speaker", "clock", "timer", "mouse", "pen",
    # Diagnostics 46..50
    "mag_list", "hdd_mag", "bat_mag", "card_mag", "chip_mag",
    # Backup & Restore 51..52
    "save_up", "save_dn",
    # Information 53..58
    "bat_info", "gear_info", "tag", "power", "power", "reset",
]
# 'floppy' used above but not yet in art -> add it
mk("floppy", p_floppy)

cat_names = ["cat_power", "cat_disp", "cat_dev", "cat_kbd", "cat_adv",
             "cat_dump", "cat_test", "cat_diag", "cat_backup", "cat_info"]

# ---------- title + duck ----------
def load_font(sz):
    for p in ["/System/Library/Fonts/Supplemental/Arial Bold.ttf",
              "/Library/Fonts/Arial Bold.ttf", "/System/Library/Fonts/Helvetica.ttc"]:
        try:
            return ImageFont.truetype(p, sz)
        except Exception:
            pass
    return ImageFont.load_default()

# the Easy-Setup title is a heavy, condensed, slightly right-leaning face -> Impact + a small shear
def load_title_font(sz):
    for p in ["/System/Library/Fonts/Supplemental/Impact.ttf",
              "/Library/Fonts/Impact.ttf",
              "/System/Library/Fonts/Supplemental/Arial Narrow Bold.ttf"]:
        try:
            return ImageFont.truetype(p, sz)
        except Exception:
            pass
    return load_font(sz)

f = load_title_font(46)
tmp = Image.new("L", (460, 74), 255); td = ImageDraw.Draw(tmp)
td.text((6, 6), "PS2-GUI", font=f, fill=0)      # upright heavy condensed (no italic)
bb = tmp.point(lambda v: 255 if v < 128 else 0).getbbox()
title = tmp.crop(bb)
tw = ((title.width + 15) // 16) * 16
c = Image.new("L", (tw, title.height), 255); c.paste(title, (0, 0)); title = c

# mouse cursor: the ACTUAL Easy-Setup duck, TWO real animation frames captured
# pixel-exact from the BIOS Easy-Setup cursor in motion (booted under the pc110
# emulator, moved with QMP, and flood-fill reconstructed from clean 640x480
# screendumps).  frame 0 = wing DOWN (glide), frame 1 = wing UP (flap); both are
# aligned by the eye so only the wing moves.  hotspot = top-left (beak/streak tip).
# Cell values: 0 = transparent, 1 = white body, 2 = dark outline.
_DUCK0 = [
    "00000000000000000000000000000000",
    "22000000000000000000000000000000",
    "22200000000000000000000000000000",
    "02222002222200000000000000000000",
    "21222222222222000000000000000000",
    "02122222111122000000000000000000",
    "21212221122112200000000000000000",
    "02121221122112200000000000000000",
    "00212221111112200000000000000000",
    "00021221111112200000000000000000",
    "00002122111122000000000000000000",
    "00000222222221220000000000000000",
    "00000021222221222000000000000000",
    "02220212122111122000000000000000",
    "02222222222111112200000000000000",
    "02212222222222111220000000000000",
    "02211111112222222122000000000000",
    "02221111111122222212200000000000",
    "02221111111111111112200000000000",
    "00221111111111111111220000000000",
    "00222111111111111111220000000000",
    "00022211111111112211122000000000",
    "00002222211111222211122000000000",
    "00002122221122221111112200000000",
    "00000212222222111111111220000000",
    "00002121212221111111111220000000",
    "00000212121222222111111122200000",
    "00000021212122222222222222222000",
    "00000002121212121222222222222000",
    "00000000202020202020202020202000",
    "00000000000000000000000000000000",
    "00000000000000000000000000000000",
]
_DUCK1 = [
    "00000000000000000000000000000000",
    "22000000000000000000000000000000",
    "22200000000000000000000000000000",
    "02222002222200000000000000000000",
    "21222222222222000000000000000000",
    "02122222111122000000000000000000",
    "21212221122112200000000000000000",
    "02121221122112200000000000000000",
    "00212221111112200000000000000000",
    "00021221111112200000000000000000",
    "00002122111122000000000000000000",
    "00000222222222200000000000022200",
    "00002021222212220000002222222200",
    "00000002221111220222222222212200",
    "00000002221112222222221111112200",
    "00000002211112222111111111112200",
    "00000002211111111111111111122000",
    "00000002211111111111111111122000",
    "00000002211111111111111111220000",
    "00000002211112211111111112220000",
    "00000002221112222111111222200000",
    "00000002221111122222222220000000",
    "00000000222111111222222000000000",
    "00000002122211111111122000000000",
    "00000000212221111111112200000000",
    "00000002121222221111112222000000",
    "00000000212122222211111112200000",
    "00000000021212122222222222220000",
    "00000000002121212222222222220000",
    "00000000000202020202020202020000",
    "00000000000000000000000000000000",
    "00000000000000000000000000000000",
]
CUR_H = len(_DUCK0)
CUR_W = len(_DUCK0[0])
CUR_WW = (CUR_W + 15) // 16
_g0 = [[int(c) for c in row] for row in _DUCK0]
_g1 = [[int(c) for c in row] for row in _DUCK1]

def _emit_cursor(grid):
    blk, wht = [], []
    for _y in range(CUR_H):
        brow = [0] * CUR_WW
        wrow = [0] * CUR_WW
        for _c in range(CUR_W):
            v = grid[_y][_c]
            if v == 0:
                continue
            bit = 1 << (15 - (_c % 16))
            if v == 1:
                wrow[_c // 16] |= bit
            else:
                brow[_c // 16] |= bit
        blk.extend(brow); wht.extend(wrow)
    return blk, wht

cur_blk0, cur_wht0 = _emit_cursor(_g0)
cur_blk1, cur_wht1 = _emit_cursor(_g1)
# keep the old names pointing at frame 0 for any other reference
cur_blk, cur_wht = cur_blk0, cur_wht0

# credit line as a bitmap (it sits on the WHITE margin; BIOS teletype would paint
# an index-0 mauve cell background there, so we draw it glyph-only like the title)
def load_mono(sz):
    for p in ["/System/Library/Fonts/Menlo.ttc",
              "/System/Library/Fonts/Supplemental/Courier New.ttf",
              "/System/Library/Fonts/Monaco.ttf"]:
        try:
            return ImageFont.truetype(p, sz)
        except Exception:
            pass
    return ImageFont.load_default()

cf = load_mono(15)
ctext = "(C) 2026 Ahmad Byagowi    -    github.com/ahmadexp/PS2GUI"
tmp2 = Image.new("L", (760, 30), 255); ImageDraw.Draw(tmp2).text((2, 3), ctext, font=cf, fill=0)
bb2 = tmp2.point(lambda v: 255 if v < 128 else 0).getbbox()
copy = tmp2.crop(bb2)
cw = ((copy.width + 15) // 16) * 16
c2 = Image.new("L", (cw, copy.height), 255); c2.paste(copy, (0, 0)); copy = c2

# ---------- emit ----------
def words_of(im):
    w, h = im.size; ww = (w + 15) // 16; px = im.load(); out = []
    for r in range(h):
        row = [0] * ww
        for cc in range(w):
            if px[cc, r] < 128:
                row[cc // 16] |= (1 << (15 - (cc % 16)))
        out.extend(row)
    return out, ww, h

lines = ["; TILES.INC  -  auto-generated by tools/make_tiles.py",
         "; Easy-Setup tile artwork: detailed 48x48 icons + PS2-GUI title + duck.", ""]

emitted = set()
def emit(label, im):
    w, ww, h = words_of(im)
    lines.append("%s:" % label)
    for r in range(h):
        base = r * ww
        lines.append("        dw " + ", ".join("0x%04X" % x for x in w[base:base + ww]))
    return ww, h

# emit every icon used (categories + row icons), dedup by name
for nm in cat_names + row_icons:
    if nm in emitted:
        continue
    emitted.add(nm)
    emit("tile_" + nm, art[nm])
lines.append("")
tw_ww, tw_h = emit("tile_title", title)
lines += ["TITLE_WW equ %d" % tw_ww, "TITLE_H  equ %d" % tw_h, ""]
cp_ww, cp_h = emit("tile_copy", copy)
lines += ["COPY_WW equ %d" % cp_ww, "COPY_H  equ %d" % cp_h, ""]
def emit_words(label, words, per_row):
    lines.append("%s:" % label)
    for i in range(0, len(words), per_row):
        lines.append("        dw " + ", ".join("0x%04X" % x for x in words[i:i+per_row]))
emit_words("cur_blk0", cur_blk0, CUR_WW)
emit_words("cur_wht0", cur_wht0, CUR_WW)
emit_words("cur_blk1", cur_blk1, CUR_WW)
emit_words("cur_wht1", cur_wht1, CUR_WW)
# combined silhouette (any pixel either frame ever paints) -> save/restore only these
cur_silh = [a | b | c | d for a, b, c, d in zip(cur_blk0, cur_wht0, cur_blk1, cur_wht1)]
emit_words("cur_silh", cur_silh, CUR_WW)
lines += ["CUR_W   equ %d" % CUR_W, "CUR_H   equ %d" % CUR_H,
          "CUR_WW  equ %d" % CUR_WW, ""]
lines.append("; category -> icon (main-menu order)")
lines.append("cat_tile: dw " + ", ".join("tile_" + n for n in cat_names))
lines.append("")
lines.append("; per-item icon, indexed by global row number (rows[] order)")
lines.append("row_icon: dw " + ", ".join("tile_" + n for n in row_icons))
lines.append("")

open("/Users/ahmadbyagowi/git/PS2GUI/TILES.INC", "w").write("\n".join(lines) + "\n")
print("wrote TILES.INC : %d icons, %d rows, title %dx%d"
      % (len(emitted), len(row_icons), title.width, title.height))
