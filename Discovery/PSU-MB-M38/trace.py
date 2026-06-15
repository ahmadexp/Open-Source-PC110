import pdfplumber, warnings, math
warnings.filterwarnings("ignore")
doc=pdfplumber.open("/sessions/brave-blissful-hopper/mnt/uploads/PSU.pdf")
pg=doc.pages[0]
TOL=2.2
# --- wires: long-ish horizontal/vertical lines ---
wires=[]
for ln in pg.lines:
    x0,y0,x1,y1=ln['x0'],ln['top'],ln['x1'],ln['bottom']
    L=math.hypot(x1-x0,y1-y0)
    if L<5: continue
    if abs(y1-y0)<=1.5:   # horizontal
        wires.append((min(x0,x1),(y0+y1)/2,max(x0,x1),(y0+y1)/2))
    elif abs(x1-x0)<=1.5: # vertical
        wires.append(((x0+x1)/2,min(y0,y1),(x0+x1)/2,max(y0,y1)))
# merge near-duplicate/collinear is skipped; redundancy is harmless for union-find
# --- junction dots: small square-ish filled curves ---
dots=[]
for c in pg.curves:
    w=c['x1']-c['x0']; h=c['bottom']-c['top']
    if 3<=w<=12 and 3<=h<=12 and abs(w-h)<=4:
        dots.append(((c['x0']+c['x1'])/2,(c['top']+c['bottom'])/2))

# union-find over quantized points
parent={}
def key(p): return (round(p[0]),round(p[1]))
def find(k):
    parent.setdefault(k,k)
    while parent[k]!=k:
        parent[k]=parent[parent[k]]; k=parent[k]
    return k
def union(a,b):
    ra,rb=find(key(a)),find(key(b))
    if ra!=rb: parent[ra]=rb

def on_seg(px,py,w,tol=TOL):
    x0,y0,x1,y1=w
    if abs(y0-y1)<=1.5:  # horizontal
        return (y0-tol<=py<=y0+tol) and (min(x0,x1)-tol<=px<=max(x0,x1)+tol)
    else:                # vertical
        return (x0-tol<=px<=x0+tol) and (min(y0,y1)-tol<=py<=max(y0,y1)+tol)

# endpoints of all wires
eps=[]
for w in wires:
    eps.append((w[0],w[1])); eps.append((w[2],w[3]))
# 1) union each wire's own endpoints
for w in wires:
    union((w[0],w[1]),(w[2],w[3]))
# 2) T-junctions: any wire endpoint lying on another wire -> union
# spatial bucket by x for speed
import collections
for w in wires:
    a=(w[0],w[1]); b=(w[2],w[3])
    for ep in (a,b):
        pass
# brute force endpoints-on-wires
for ep in eps:
    for w in wires:
        if (abs(ep[0]-w[0])<0.1 and abs(ep[1]-w[1])<0.1): continue
        if on_seg(ep[0],ep[1],w):
            union(ep,(w[0],w[1]))
# 3) dots: union the two wires (their endpoints) passing through a dot
for d in dots:
    touch=[w for w in wires if on_seg(d[0],d[1],w,tol=4)]
    for w in touch:
        union(d,(w[0],w[1]))

# net labels (underscored names) -> anchor near a wire
def labels():
    out=[]
    for wd in pg.extract_words():
        t=wd['text']
        if ('_' in t) or t in ("GND","VCC","JRC_VCC","PNET1_PC110","PNET4_PC110","PNET5_PC110"):
            out.append((t,wd['x0'],wd['top'],wd['x1'],wd['bottom']))
    return out
labs=labels()
def comp_of_point(px,py,tol=4):
    # nearest wire endpoint within tol
    best=None;bd=1e9
    for ep in eps:
        d=math.hypot(ep[0]-px,ep[1]-py)
        if d<bd:bd=d;best=ep
    if best and bd<=tol: return find(key(best)),bd
    return None,bd

def net_members(root):
    names=[]
    for (t,x0,t0,x1,b) in labs:
        # label anchor: try both ends of underline (x0 and x1) at baseline b and top
        for ax,ay in [(x0,b),(x1,b),(x0,t0),(x1,t0),((x0+x1)/2,b)]:
            r,d=comp_of_point(ax,ay,tol=6)
            if r==root:
                names.append(t);break
    return sorted(set(names))

# QUERY POINTS
queries={
 "U6C_out_pin8(~1362,377)":(1362,377),
 "M38_P60_label(1381,377)":(1386,377),
 "x1444_vertical(1444,380)":(1444,380),
 "R52_left(~1489,377)":(1489,377),
 "R52_right(~1538,377)":(1538,377),
 "U6D_+in_pin12(~1612,363)":(1612,363),
 "MainBattery_JX1(~1455,318)":(1455,318),
 "R89_1M_top(~1530,415)":(1530,415),
 "R88_1M(~1545,452)":(1545,452),
}
for nm,(px,py) in queries.items():
    root,bd=comp_of_point(px,py,tol=8)
    if root is None:
        print("%-30s -> no wire endpoint within tol (nearest %.1f)"%(nm,bd)); continue
    mem=net_members(root)
    print("%-30s -> net#%s  labels=%s"%(nm,hash(root)%10000,mem))
