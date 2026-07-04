from PIL import Image, ImageDraw, ImageFont
SRC="/Users/ahmadbyagowi/git/qemu-personaware/pc110-easy-setup.png"
im=Image.open(SRC).convert("RGB")
d=ImageDraw.Draw(im)
MAUVE=(184,145,131); WHITE=(249,249,249); RED=(112,5,7)
# find a bold font close to the Easy-Setup labels
fp=None
for c in ["/System/Library/Fonts/Supplemental/Arial Bold.ttf",
          "/System/Library/Fonts/Supplemental/Arial.ttf",
          "/Library/Fonts/Arial Bold.ttf"]:
    import os
    if os.path.exists(c): fp=c; break
font=ImageFont.truetype(fp,15) if fp else ImageFont.load_default()
def label(cx,y,text):
    w=d.textbbox((0,0),text,font=font)[2]
    d.text((cx-w//2,y),text,fill=RED,font=font)
# ---- tile 2 (was Password) -> BATTERY  (tile x288..351 y160..223) ----
d.rectangle([288,160,351,223],fill=WHITE)
d.rectangle([302,181,333,201],outline=RED,width=2)          # battery body
d.rectangle([333,187,338,195],fill=RED)                     # terminal nub
for bx in (306,315,324):                                    # charge bars
    d.rectangle([bx,185,bx+5,197],fill=RED)
d.rectangle([285,225,354,246],fill=MAUVE)                   # clear old label
label(319,227,"Battery")
# ---- tile 3 (was Start up) -> BACKUP (diskette) (tile x392..455) ----
d.rectangle([392,160,455,223],fill=WHITE)
d.rectangle([406,173,440,208],outline=RED,width=2)          # floppy body
d.rectangle([420,175,431,185],fill=RED)                     # shutter
d.rectangle([412,191,434,205],outline=RED,width=2)          # label area
d.rectangle([388,225,459,246],fill=MAUVE)                   # clear old label
label(423,227,"Backup")
im.save("/tmp/es_new.png")

# ---- extract to 4 planes + palette + hardcoded icon boxes ----
W,H=im.size; px=im.load()
pal=[(184,145,131),(249,249,249),(112,5,7),(10,5,51),(0,0,0)]
def nearest(c):
    return min(range(len(pal)),key=lambda i:sum((a-b)**2 for a,b in zip(c,pal[i])))
idx=[[nearest(px[x,y]) for x in range(W)] for y in range(H)]
rb=W//8; planes=[bytearray(rb*H) for _ in range(4)]
for y in range(H):
    for xb in range(rb):
        b=[0,0,0,0]
        for bit in range(8):
            i=idx[y][xb*8+bit]
            for p in range(4):
                if (i>>p)&1: b[p]|=(0x80>>bit)
        for p in range(4): planes[p][y*rb+xb]=b[p]
def rle(data):
    out=bytearray(); i=0; n=len(data)
    while i<n:
        v=data[i]; run=1
        while i+run<n and data[i+run]==v and run<255: run+=1
        out.append(run); out.append(v); i+=run
    return out
rles=[rle(p) for p in planes]
print("plane RLE sizes:",[len(r) for r in rles],"total",sum(len(r) for r in rles))
boxes=[(80,160,143,223),(184,160,247,223),(288,160,351,223),
       (392,160,455,223),(496,160,559,223),(80,272,143,335)]
names=["Config","Date/Time","Battery","Backup","Test","Restart"]
with open("/Users/ahmadbyagowi/git/PS2GUI/ESDATA.INC","w") as f:
    f.write("; Auto-generated Easy-Setup graphics (Password/Start up repurposed to Battery/Backup)\n")
    f.write("; 640x480 mode 12h, 4 bit-planes, RLE (count,val) pairs.\n\n")
    f.write("PAL_N equ 5\nespal:\n")
    for (r,g,b) in pal: f.write("  db %d,%d,%d\n"%(r//4,g//4,b//4))
    for p in range(4):
        f.write("\nesplane%d:\n"%p); dchunk=rles[p]
        for i in range(0,len(dchunk),24):
            f.write("  db "+",".join(str(x) for x in dchunk[i:i+24])+"\n")
        f.write("esplane%d_end:\n"%p)
    f.write("\nesplanes: dw esplane0, esplane1, esplane2, esplane3\n")
    f.write("esplanelen: dw esplane0_end-esplane0, esplane1_end-esplane1, esplane2_end-esplane2, esplane3_end-esplane3\n")
    f.write("\nICON_N equ %d\nicons:\n"%len(boxes))
    for (x0,y0,x1,y1),nm in zip(boxes,names):
        f.write("  dw %d,%d,%d,%d   ; %s\n"%(x0,y0,x1,y1,nm))
print("wrote ESDATA.INC + /tmp/es_new.png")
