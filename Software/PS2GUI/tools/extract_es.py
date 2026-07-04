from PIL import Image
im=Image.open("/Users/ahmadbyagowi/git/qemu-personaware/pc110-easy-setup.png").convert("RGB")
W,H=im.size; px=im.load()
pal=[(184,145,131),(249,249,249),(112,5,7),(10,5,51),(0,0,0)]  # 0 mauve,1 white,2 red,3 navy,4 black
def nearest(c):
    best,bi=1e9,0
    for i,p in enumerate(pal):
        d=sum((a-b)**2 for a,b in zip(c,p))
        if d<best: best,bi=d,i
    return bi
idx=[[nearest(px[x,y]) for x in range(W)] for y in range(H)]
# build 4 bitplanes, each row = W/8 bytes
rowbytes=W//8
planes=[bytearray(rowbytes*H) for _ in range(4)]
for y in range(H):
    for xb in range(rowbytes):
        b=[0,0,0,0]
        for bit in range(8):
            x=xb*8+bit
            i=idx[y][x]
            for p in range(4):
                if (i>>p)&1: b[p]|=(0x80>>bit)
        for p in range(4):
            planes[p][y*rowbytes+xb]=b[p]
def rle(data):
    out=bytearray(); i=0; n=len(data)
    while i<n:
        v=data[i]; run=1
        while i+run<n and data[i+run]==v and run<255: run+=1
        out.append(run); out.append(v); i+=run
    return out
rles=[rle(p) for p in planes]
print("plane RLE sizes:", [len(r) for r in rles], "total", sum(len(r) for r in rles))
# detect 6 icon tiles = big white (idx1) connected components
seen=[[False]*W for _ in range(H)]
boxes=[]
from collections import deque
for y in range(H):
    for x in range(W):
        if idx[y][x]==1 and not seen[y][x]:
            q=deque([(x,y)]); seen[y][x]=True; minx=maxx=x; miny=maxy=y; area=0
            while q:
                cx,cy=q.popleft(); area+=1
                minx=min(minx,cx);maxx=max(maxx,cx);miny=min(miny,cy);maxy=max(maxy,cy)
                for dx,dy in((1,0),(-1,0),(0,1),(0,-1)):
                    nx,ny=cx+dx,cy+dy
                    if 0<=nx<W and 0<=ny<H and idx[ny][nx]==1 and not seen[ny][nx]:
                        seen[ny][nx]=True; q.append((nx,ny))
            if area>1500 and (maxx-minx)>30 and (maxy-miny)>30:
                boxes.append((minx,miny,maxx,maxy,area))
boxes.sort(key=lambda b:(b[1]//40, b[0]))
print("icon tiles:",len(boxes))
for b in boxes: print("  box x%d..%d y%d..%d area%d"%b)
# emit NASM include
with open("/Users/ahmadbyagowi/git/PS2GUI/ESDATA.INC","w") as f:
    f.write("; Auto-generated from pc110-easy-setup.png (exact Easy-Setup graphics)\n")
    f.write("; 640x480 mode 12h, 4 bit-planes, RLE (count,val) pairs.\n\n")
    f.write("PAL_N equ 5\nespal:  ; r,g,b 6-bit per entry (index 0..4)\n")
    for (r,g,b) in pal:
        f.write("  db %d,%d,%d\n"%(r//4,g//4,b//4))
    for p in range(4):
        f.write("\nesplane%d:\n"%p)
        d=rles[p]
        for i in range(0,len(d),24):
            f.write("  db "+",".join(str(x) for x in d[i:i+24])+"\n")
        f.write("esplane%d_end:\n"%p)
    f.write("\nesplanes: dw esplane0, esplane1, esplane2, esplane3\n")
    f.write("esplanelen: dw esplane0_end-esplane0, esplane1_end-esplane1, esplane2_end-esplane2, esplane3_end-esplane3\n")
    # icon boxes
    f.write("\nICON_N equ %d\nicons:  ; x0,y0,x1,y1 (words)\n"%len(boxes))
    for (x0,y0,x1,y1,a) in boxes:
        f.write("  dw %d,%d,%d,%d\n"%(x0,y0,x1,y1))
print("wrote ESDATA.INC")
