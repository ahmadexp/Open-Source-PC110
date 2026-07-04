from PIL import Image, ImageDraw, ImageFont
import os
im=Image.open("/Users/ahmadbyagowi/git/qemu-personaware/pc110-easy-setup.png").convert("RGB")
d=ImageDraw.Draw(im); px=im.load(); W,H=im.size
MAUVE=(184,145,131); WHITE=(249,249,249); RED=(112,5,7); BLACK=(0,0,0); NAVY=(10,5,51)
def font(paths,size):
    for p in paths:
        if os.path.exists(p): return ImageFont.truetype(p,size)
    return ImageFont.load_default()
# CRISP (no-AA) text: render to a mask, threshold to binary, paste solid colour.
def paste_text(x,y,text,f,color,center=False,thresh=110,xscale=1.0):
    b=f.getbbox(text); tw=b[2]-b[0]; th=b[3]-b[1]
    m=Image.new("L",(tw+2,th+2),0)
    ImageDraw.Draw(m).text((-b[0]+1,-b[1]+1),text,fill=255,font=f)
    if xscale!=1.0:
        m=m.resize((max(1,int((tw+2)*xscale)), th+2), Image.LANCZOS)
    m=m.point(lambda v:255 if v>=thresh else 0)
    if center: x=x-m.width//2
    im.paste(Image.new("RGB",(m.width,m.height),color),(x,y),m)
    return m.width,m.height
def darkbbox(x0,y0,x1,y1):
    mnx=mny=10**9;mxx=mxy=-1
    for yy in range(y0,y1):
        for xx in range(x0,x1):
            p=px[xx,yy]
            if max(p)<150 and not(abs(p[0]-184)<40 and abs(p[1]-145)<40 and abs(p[2]-131)<40):
                mnx=min(mnx,xx);mxx=max(mxx,xx);mny=min(mny,yy);mxy=max(mxy,yy)
    return mnx,mny,mxx,mxy
# --- title: Easy-Setup -> PS2-GUI (narrow, skinnier bold, black, crisp) ---
tx0,ty0,tx1,ty1=darkbbox(40,50,380,140)
d.rectangle([tx0-8,ty0-10,tx1+12,ty1+12],fill=MAUVE)
target=ty1-ty0                      # match original title height
tf=font(["/System/Library/Fonts/Supplemental/Arial Narrow Bold.ttf",
         "/System/Library/Fonts/Supplemental/Arial Narrow.ttf",
         "/System/Library/Fonts/Supplemental/Arial Bold.ttf"], 10)
sz=10
while True:
    tf=font(["/System/Library/Fonts/Supplemental/Arial Narrow Bold.ttf",
             "/System/Library/Fonts/Supplemental/Arial Narrow.ttf",
             "/System/Library/Fonts/Supplemental/Arial Bold.ttf"], sz)
    b=tf.getbbox("PS2-GUI")
    if (b[3]-b[1])>=target or sz>90: break
    sz+=1
w,h=paste_text(tx0,ty0,"PS2-GUI",tf,BLACK,xscale=0.64)
print("title size",sz,"-> w",w,"h",h,"(orig w",tx1-tx0,"h",target,")")
# --- credits (navy, crisp, centred) ---
cx0,cy0,cx1,cy1=darkbbox(0,420,W,H)
d.rectangle([0,cy0-4,W,cy1+8],fill=MAUVE)
cf=font(["/System/Library/Fonts/Supplemental/Arial.ttf",
         "/System/Library/Fonts/Supplemental/Arial Bold.ttf"],14)
paste_text(W//2,cy0-1,"(C) 2026 Ahmad Byagowi      -      github.com/ahmadexp/PS2GUI",cf,NAVY,center=True)
# --- Battery / Backup icons + crisp red labels ---
lab=font(["/System/Library/Fonts/Supplemental/Arial Bold.ttf"],15)
d.rectangle([288,160,351,223],fill=WHITE)
d.rectangle([302,181,333,201],outline=RED,width=2); d.rectangle([333,187,338,195],fill=RED)
for bx in (306,315,324): d.rectangle([bx,185,bx+5,197],fill=RED)
d.rectangle([285,225,354,246],fill=MAUVE); paste_text(319,227,"Battery",lab,RED,center=True)
d.rectangle([392,160,455,223],fill=WHITE)
d.rectangle([406,173,440,208],outline=RED,width=2); d.rectangle([420,175,431,185],fill=RED)
d.rectangle([412,191,434,205],outline=RED,width=2)
d.rectangle([388,225,459,246],fill=MAUVE); paste_text(423,227,"Backup",lab,RED,center=True)
im.save("/tmp/es_brand.png")
# --- extract to planes ---
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
rles=[rle(p) for p in planes]; print("RLE total",sum(len(r) for r in rles))
boxes=[(80,160,143,223),(184,160,247,223),(288,160,351,223),(392,160,455,223),(496,160,559,223),(80,272,143,335)]
names=["Config","Date/Time","Battery","Backup","Test","Restart"]
with open("/Users/ahmadbyagowi/git/PS2GUI/ESDATA.INC","w") as f:
    f.write("; Auto-generated PS2-GUI graphics (crisp narrow title, own credits)\n\nPAL_N equ 5\nespal:\n")
    for (r,g,b) in pal: f.write("  db %d,%d,%d\n"%(r//4,g//4,b//4))
    for p in range(4):
        f.write("\nesplane%d:\n"%p); c=rles[p]
        for i in range(0,len(c),24): f.write("  db "+",".join(str(x) for x in c[i:i+24])+"\n")
        f.write("esplane%d_end:\n"%p)
    f.write("\nesplanes: dw esplane0, esplane1, esplane2, esplane3\n")
    f.write("esplanelen: dw esplane0_end-esplane0, esplane1_end-esplane1, esplane2_end-esplane2, esplane3_end-esplane3\n")
    f.write("\nICON_N equ %d\nicons:\n"%len(boxes))
    for (x0,y0,x1,y1),nm in zip(boxes,names): f.write("  dw %d,%d,%d,%d   ; %s\n"%(x0,y0,x1,y1,nm))
print("done")
