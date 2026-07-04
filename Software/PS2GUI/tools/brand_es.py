from PIL import Image, ImageDraw, ImageFont
import os
from collections import Counter
im=Image.open("/Users/ahmadbyagowi/git/qemu-personaware/pc110-easy-setup.png").convert("RGB")
d=ImageDraw.Draw(im); px=im.load(); W,H=im.size
MAUVE=(184,145,131); WHITE=(249,249,249); RED=(112,5,7); BLACK=(0,0,0); NAVY=(10,5,51)
def font(paths,size):
    for p in paths:
        if os.path.exists(p): return ImageFont.truetype(p,size)
    return ImageFont.load_default()
def dark_region(x0,y0,x1,y1):
    minx=miny=10**9;maxx=maxy=-1; c=Counter()
    for y in range(y0,y1):
        for x in range(x0,x1):
            p=px[x,y]
            if max(p)<150 and not (abs(p[0]-184)<40 and abs(p[1]-145)<40 and abs(p[2]-131)<40):
                minx=min(minx,x);maxx=max(maxx,x);miny=min(miny,y);maxy=max(maxy,y);c[p]+=1
    return minx,miny,maxx,maxy,(c.most_common(1)[0][0] if c else BLACK)
def ctext(cx,y,text,f,col):
    w=d.textbbox((0,0),text,font=f)[2]; d.text((cx-w//2,y),text,fill=col,font=f)
# --- title: Easy-Setup -> PS2-GUI (same colour = black, Impact font) ---
tx0,ty0,tx1,ty1,tcol=dark_region(40,50,380,140)
print("title bbox",tx0,ty0,tx1,ty1,"col",tcol)
d.rectangle([tx0-6,ty0-8,tx1+10,ty1+10],fill=MAUVE)
th=ty1-ty0
tf=font(["/System/Library/Fonts/Supplemental/Impact.ttf","/System/Library/Fonts/Supplemental/Arial Bold.ttf"], int(th*1.5))
off=d.textbbox((0,0),"PS2-GUI",font=tf)
d.text((tx0, ty0-off[1]), "PS2-GUI", fill=tcol, font=tf)
# --- credits (navy) ---
cx0,cy0,cx1,cy1,ccol=dark_region(0,420,W,H)
print("credits bbox",cx0,cy0,cx1,cy1,"col",ccol)
d.rectangle([0,cy0-4,W,cy1+8],fill=MAUVE)
ctext(W//2, cy0-1, "(C) 2026 Ahmad Byagowi      -      github.com/ahmadexp/PS2GUI",
      font(["/System/Library/Fonts/Supplemental/Arial Bold.ttf"],14), ccol)
# --- Battery / Backup icons ---
lab=font(["/System/Library/Fonts/Supplemental/Arial Bold.ttf"],15)
d.rectangle([288,160,351,223],fill=WHITE)
d.rectangle([302,181,333,201],outline=RED,width=2); d.rectangle([333,187,338,195],fill=RED)
for bx in (306,315,324): d.rectangle([bx,185,bx+5,197],fill=RED)
d.rectangle([285,225,354,246],fill=MAUVE); ctext(319,227,"Battery",lab,RED)
d.rectangle([392,160,455,223],fill=WHITE)
d.rectangle([406,173,440,208],outline=RED,width=2); d.rectangle([420,175,431,185],fill=RED)
d.rectangle([412,191,434,205],outline=RED,width=2)
d.rectangle([388,225,459,246],fill=MAUVE); ctext(423,227,"Backup",lab,RED)
im.save("/tmp/es_brand.png")
# --- extract ---
pal=[MAUVE,WHITE,RED,NAVY,BLACK]
def nearest(c): return min(range(5),key=lambda i:sum((a-b)**2 for a,b in zip(c,pal[i])))
idx=[[nearest(px[x,y]) for x in range(W)] for y in range(H)]
rb=W//8; planes=[bytearray(rb*H) for _ in range(4)]
for y in range(H):
    for xb in range(rb):
        bb=[0,0,0,0]
        for bit in range(8):
            i=idx[y][xb*8+bit]
            for p in range(4):
                if (i>>p)&1: bb[p]|=(0x80>>bit)
        for p in range(4): planes[p][y*rb+xb]=bb[p]
def rle(dta):
    o=bytearray(); i=0; n=len(dta)
    while i<n:
        v=dta[i]; run=1
        while i+run<n and dta[i+run]==v and run<255: run+=1
        o.append(run); o.append(v); i+=run
    return o
rles=[rle(p) for p in planes]; print("plane RLE total",sum(len(r) for r in rles))
boxes=[(80,160,143,223),(184,160,247,223),(288,160,351,223),(392,160,455,223),(496,160,559,223),(80,272,143,335)]
names=["Config","Date/Time","Battery","Backup","Test","Restart"]
with open("/Users/ahmadbyagowi/git/PS2GUI/ESDATA.INC","w") as f:
    f.write("; Auto-generated PS2-GUI graphics (PS2-GUI title, own credits, Battery/Backup tiles)\n\n")
    f.write("PAL_N equ 5\nespal:\n")
    for (r,g,b) in pal: f.write("  db %d,%d,%d\n"%(r//4,g//4,b//4))
    for p in range(4):
        f.write("\nesplane%d:\n"%p); c=rles[p]
        for i in range(0,len(c),24): f.write("  db "+",".join(str(x) for x in c[i:i+24])+"\n")
        f.write("esplane%d_end:\n"%p)
    f.write("\nesplanes: dw esplane0, esplane1, esplane2, esplane3\n")
    f.write("esplanelen: dw esplane0_end-esplane0, esplane1_end-esplane1, esplane2_end-esplane2, esplane3_end-esplane3\n")
    f.write("\nICON_N equ %d\nicons:\n"%len(boxes))
    for (x0,y0,x1,y1),nm in zip(boxes,names): f.write("  dw %d,%d,%d,%d   ; %s\n"%(x0,y0,x1,y1,nm))
print("wrote ESDATA.INC")
