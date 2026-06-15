import pdfplumber, warnings, math, collections
warnings.filterwarnings("ignore")
doc=pdfplumber.open("/sessions/brave-blissful-hopper/mnt/uploads/PSU.pdf")
pg=doc.pages[0]
TOL=2.5
wires=[]
for ln in pg.lines:
    x0,y0,x1,y1=ln['x0'],ln['top'],ln['x1'],ln['bottom']
    if math.hypot(x1-x0,y1-y0)<4: continue
    if abs(y1-y0)<=1.5: wires.append((min(x0,x1),(y0+y1)/2,max(x0,x1),(y0+y1)/2))
    elif abs(x1-x0)<=1.5: wires.append(((x0+x1)/2,min(y0,y1),(x0+x1)/2,max(y0,y1)))
dots=[]
for c in pg.curves:
    w=c['x1']-c['x0']; h=c['bottom']-c['top']
    if 3<=w<=12 and 3<=h<=12 and abs(w-h)<=4: dots.append(((c['x0']+c['x1'])/2,(c['top']+c['bottom'])/2))
parent={}
def find(k):
    parent.setdefault(k,k)
    while parent[k]!=k: parent[k]=parent[parent[k]]; k=parent[k]
    return k
def union(a,b):
    ra,rb=find(a),find(b)
    if ra!=rb: parent[ra]=rb
def K(p): return (round(p[0]),round(p[1]))
def on_seg(px,py,w,tol=TOL):
    x0,y0,x1,y1=w
    if abs(y0-y1)<=1.5: return (abs(py-y0)<=tol) and (min(x0,x1)-tol<=px<=max(x0,x1)+tol)
    return (abs(px-x0)<=tol) and (min(y0,y1)-tol<=py<=max(y0,y1)+tol)
for w in wires: union(K((w[0],w[1])),K((w[2],w[3])))
eps=[]
for w in wires: eps+=[(w[0],w[1]),(w[2],w[3])]
# T-junctions
for ep in eps:
    for w in wires:
        if on_seg(ep[0],ep[1],w): union(K(ep),K((w[0],w[1])))
# dots
for d in dots:
    t=[w for w in wires if on_seg(d[0],d[1],w,tol=4.5)]
    for w in t: union(K((w[0],w[1])),K(t[0][0:2]))
def comp_through(px,py,tol=3.0):
    for w in wires:
        if on_seg(px,py,w,tol): return find(K((w[0],w[1])))
    return None
# attach labels
labs=[]
for wd in pg.extract_words():
    t=wd['text']
    if '_' in t or t in ("GND","VCC"):
        labs.append((t,(wd['x0']+wd['x1'])/2,(wd['top']+wd['bottom'])/2,wd['x0'],wd['top'],wd['x1'],wd['bottom']))
def labels_in(root,tol=8):
    found=collections.Counter()
    for (t,cx,cy,x0,y0,x1,y1) in labs:
        for ax,ay in [(x0,(y0+y1)/2),(x1,(y0+y1)/2),(cx,cy),(x0,y1),(x1,y1)]:
            r=comp_through(ax,ay,tol)
            if r==root: found[t]+=1;break
    return sorted(found)
# Queries by net-label anchor (exact coords from extract_words)
def anchor(name):
    for (t,cx,cy,x0,y0,x1,y1) in labs:
        if t==name: return (x0,(y0+y1)/2),(x1,(y0+y1)/2),(x0,y0),(x1,y0)
    return None
for net in ["M38_P60_PC110","M38_P61_PC110","M38_P63_PC110","M38_P64_PC110","M38_VREF_PC110"]:
    a=anchor(net)
    root=None
    if a:
        for p in a:
            root=comp_through(p[0],p[1],tol=5)
            if root: break
    if not root:
        print("%-16s : NOT FOUND on a wire"%net); continue
    mem=labels_in(root)
    print("%-16s : same-net labels = %s"%(net,mem))
# Also: what is at the battery vertical x1444 and does it share net with M38_P60?
for nm,(px,py) in {"batt_vert_above_F5(1444,385)":(1444,385),"batt_vert_below_F5(1444,420)":(1444,420),"MainBatt_pin(1452,322)":(1452,322)}.items():
    r=comp_through(px,py,tol=3.5)
    print("%-28s -> %s"%(nm, labels_in(r) if r else "no wire"))

print("\n=== REGION DUMP: wires (with root) in box, + dots, + R/C labels ===")
def dumpbox(x0,x1,y0,y1):
    seen={}
    for w in wires:
        mx=(w[0]+w[2])/2; my=(w[1]+w[3])/2
        if x0<=mx<=x1 and y0<=my<=y1:
            r=find(K((w[0],w[1]))); seen.setdefault(r,[]).append(w)
    for r,ws in seen.items():
        labs_here=labels_in(r,tol=7)
        print(" net%5d labels=%s"%(hash(r)%10000,labs_here))
        for w in ws[:8]:
            print("     (%4.0f,%4.0f)-(%4.0f,%4.0f)"%(w[0],w[1],w[2],w[3]))
# component reference designators in box
def refs(x0,x1,y0,y1):
    out=[]
    for wd in pg.extract_words():
        t=wd['text']
        if len(t)>=2 and t[0] in "RCQDLUF" and t[1:].isdigit():
            cx=(wd['x0']+wd['x1'])/2; cy=(wd['top']+wd['bottom'])/2
            if x0<=cx<=x1 and y0<=cy<=y1: out.append((t,round(cx),round(cy)))
    return out
print("\n-- U6D + input / R52 / R69 / battery divider region x1470..1720 y350..470 --")
print("refs:",refs(1470,1720,350,470))
dumpbox(1470,1720,350,470)

print("\n=== DECISIVE: R52-left vs M38_P60 vs battery-vertical ===")
def root_at(px,py,tol=3.0):
    for w in wires:
        if on_seg(px,py,w,tol): return find(K((w[0],w[1])))
    return None
r_r52L = root_at(1470,374)          # R52 left horizontal (net 8070)
r_p60  = None
a=anchor("M38_P60_PC110")
for p in a:
    r_p60=root_at(p[0],p[1],5);  
    if r_p60: break
r_batt_up = root_at(1444,360)       # battery vertical above y374
r_batt_dn = root_at(1444,430)       # battery vertical below F5
print("root R52-left      :",hash(r_r52L)%10000 if r_r52L else None)
print("root M38_P60 label :",hash(r_p60)%10000 if r_p60 else None)
print("root batt-vert(up) :",hash(r_batt_up)%10000 if r_batt_up else None)
print("root batt-vert(dn) :",hash(r_batt_dn)%10000 if r_batt_dn else None)
print("R52-left == M38_P60 ?", r_r52L==r_p60)
print("R52-left == batt-vert(up) ?", r_r52L==r_batt_up)
print("M38_P60  == batt-vert(up) ?", r_p60==r_batt_up)
# dots near x1444 at the y374/377 crossing and elsewhere on this line
print("dots near (1444,374):",[ (round(d[0]),round(d[1])) for d in dots if abs(d[0]-1444)<6 and 360<=d[1]<=395])
print("dots near (1506,374) R52L:",[ (round(d[0]),round(d[1])) for d in dots if abs(d[0]-1506)<8 and 365<=d[1]<=383])
# what does M38_P60 net actually contain (wire list) - is U6C output(~1360,377) on it?
print("U6C-out(1360,377) root:",hash(root_at(1360,377,4))%10000 if root_at(1360,377,4) else None)
print("   == M38_P60 ?", root_at(1360,377,4)==r_p60)
# trace full extent of M38_P60 net
if r_p60:
    xs=[];ys=[]
    for w in wires:
        if find(K((w[0],w[1])))==r_p60:
            xs+=[w[0],w[2]]; ys+=[w[1],w[3]]
    print("M38_P60 net bbox: x %.0f..%.0f  y %.0f..%.0f  (#wires=%d)"%(min(xs),max(xs),min(ys),max(ys),sum(1 for w in wires if find(K((w[0],w[1])))==r_p60)))

print("\n=== net 8070 (R52-left / batt rail) full trace ===")
def netbbox_and_refs(root):
    xs=[];ys=[];segs=[]
    for w in wires:
        if find(K((w[0],w[1])))==root:
            xs+=[w[0],w[2]];ys+=[w[1],w[3]];segs.append(w)
    if not xs: return
    print(" bbox x %.0f..%.0f y %.0f..%.0f  #wires=%d"%(min(xs),max(xs),min(ys),max(ys),len(segs)))
    # refs whose body-center is within ~14px of any seg of this net
    near=[]
    for wd in pg.extract_words():
        t=wd['text']
        if len(t)>=2 and t[0] in "RCQDLUF" and (t[1:].isdigit() or t[1:].rstrip('AB').isdigit()):
            cx=(wd['x0']+wd['x1'])/2; cy=(wd['top']+wd['bottom'])/2
            for w in segs:
                if on_seg(cx,cy,w,tol=16): near.append(t);break
    print(" nearby component refs:",sorted(set(near)))
    return segs
r=None
for w in wires:
    if on_seg(1470,374,w,3): r=find(K((w[0],w[1])));break
netbbox_and_refs(r)

print("\n=== U6D - input (pin13) net: via R64/R101 ===")
# pin13 is just below pin12(y374); find horizontal near y389 left of opamp ~x1645
for q in [(1645,389),(1620,389),(1613,389)]:
    rr=None
    for w in wires:
        if on_seg(q[0],q[1],w,3): rr=find(K((w[0],w[1])));break
    if rr: 
        print("U6D-in(-) query",q,"->"); netbbox_and_refs(rr); break

print("\n=== locate shunt R7,R8 and divider R88,R89,R44,R45 ===")
for ref in ["R7","R8","R88","R89","R44","R45","R78","R77","R52","R64","R69","R101"]:
    for wd in pg.extract_words():
        if wd['text']==ref:
            print(" %-5s at (%.0f,%.0f)"%(ref,(wd['x0']+wd['x1'])/2,(wd['top']+wd['bottom'])/2));break

print("\n=== FINAL: net8070 top connection, R69/R64 returns, GND identification ===")
# Identify GND net: the big component containing many "GND" labels
gnd_roots=collections.Counter()
for (t,cx,cy,x0,y0,x1,y1) in labs:
    if t=="GND":
        r=comp_through(x0,(y0+y1)/2,8) or comp_through(cx,cy,8)
        if r: gnd_roots[r]+=1
gnd_root=gnd_roots.most_common(1)[0][0] if gnd_roots else None
def is_gnd(r): return r==gnd_root
def root_at(px,py,tol=3.0):
    for w in wires:
        if on_seg(px,py,w,tol): return find(K((w[0],w[1])))
    return None
# net8070 top: query just above y306 along x1444 and around
r8070=root_at(1470,374)
# find topmost wire of net8070 and what connects beyond it
tops=[w for w in wires if find(K((w[0],w[1])))==r8070]
miny=min(min(w[1],w[3]) for w in tops); 
print("net8070 top y=%.0f ; is it GND? %s"%(miny, is_gnd(r8070)))
# what is just above net8070 top (continuation through a component/dot)?
for dy in [2,4,6,8,12,16,20,28,40]:
    r=root_at(1444,miny-dy,3)
    if r and r!=r8070:
        print("  above by %d -> net%4d  isGND=%s labels=%s"%(dy,hash(r)%10000,is_gnd(r),labels_in(r)));break
# R69 bottom (R69 at 1567,414 vertical) -> check ~y446
for q,label in [((1580,446),"R69-bottom"),((1613,446),"R64-bottom")]:
    r=root_at(q[0],q[1],4)
    print("%-12s net%4s isGND=%s"%(label, (hash(r)%10000) if r else None, is_gnd(r) if r else "?"))
# Does net8070 connect to Main Battery JX1 area / shunt? check refs again across whole net incl. via diodes
# Check connection of net8070 to shunt cluster (R7/R8 ~1168,304) and JX1
print("net8070 reaches x<1300?", any(min(w[0],w[2])<1300 for w in tops))
# What feeds AN3 (M38_P63=U6A out) and is U6A input on the shunt? trace shunt node
rshunt=root_at(1168,304,6) or root_at(1168,290,6) or root_at(1168,318,6)
if rshunt:
    print("shunt(R7/R8) node net%4d isGND=%s labels=%s"%(hash(rshunt)%10000,is_gnd(rshunt),labels_in(rshunt)))
