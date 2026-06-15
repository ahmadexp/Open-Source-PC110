import sys
data=open('/sessions/gifted-admiring-hawking/mnt/uploads/M38813E4HP@QFP64.bin','rb').read()
base=0xC081
# 6502 opcode table: name, addr-mode, length
IMP,ACC,IMM,ZP,ZPX,ZPY,ABS,ABX,ABY,IND,IZX,IZY,REL='imp','acc','imm','zp','zpx','zpy','abs','abx','aby','ind','izx','izy','rel'
T={}
def d(op,nm,m,ln): T[op]=(nm,m,ln)
# minimal standard table
tbl={
0x00:('BRK',IMP,1),0x01:('ORA',IZX,2),0x05:('ORA',ZP,2),0x06:('ASL',ZP,2),0x08:('PHP',IMP,1),0x09:('ORA',IMM,2),0x0A:('ASL',ACC,1),0x0D:('ORA',ABS,3),0x0E:('ASL',ABS,3),
0x10:('BPL',REL,2),0x11:('ORA',IZY,2),0x15:('ORA',ZPX,2),0x16:('ASL',ZPX,2),0x18:('CLC',IMP,1),0x19:('ORA',ABY,3),0x1D:('ORA',ABX,3),0x1E:('ASL',ABX,3),
0x20:('JSR',ABS,3),0x21:('AND',IZX,2),0x24:('BIT',ZP,2),0x25:('AND',ZP,2),0x26:('ROL',ZP,2),0x28:('PLP',IMP,1),0x29:('AND',IMM,2),0x2A:('ROL',ACC,1),0x2C:('BIT',ABS,3),0x2D:('AND',ABS,3),0x2E:('ROL',ABS,3),
0x30:('BMI',REL,2),0x31:('AND',IZY,2),0x35:('AND',ZPX,2),0x36:('ROL',ZPX,2),0x38:('SEC',IMP,1),0x39:('AND',ABY,3),0x3D:('AND',ABX,3),0x3E:('ROL',ABX,3),
0x40:('RTI',IMP,1),0x41:('EOR',IZX,2),0x45:('EOR',ZP,2),0x46:('LSR',ZP,2),0x48:('PHA',IMP,1),0x49:('EOR',IMM,2),0x4A:('LSR',ACC,1),0x4C:('JMP',ABS,3),0x4D:('EOR',ABS,3),0x4E:('LSR',ABS,3),
0x50:('BVC',REL,2),0x51:('EOR',IZY,2),0x55:('EOR',ZPX,2),0x56:('LSR',ZPX,2),0x58:('CLI',IMP,1),0x59:('EOR',ABY,3),0x5D:('EOR',ABX,3),0x5E:('LSR',ABX,3),
0x60:('RTS',IMP,1),0x61:('ADC',IZX,2),0x65:('ADC',ZP,2),0x66:('ROR',ZP,2),0x68:('PLA',IMP,1),0x69:('ADC',IMM,2),0x6A:('ROR',ACC,1),0x6C:('JMP',IND,3),0x6D:('ADC',ABS,3),0x6E:('ROR',ABS,3),
0x70:('BVS',REL,2),0x71:('ADC',IZY,2),0x75:('ADC',ZPX,2),0x76:('ROR',ZPX,2),0x78:('SEI',IMP,1),0x79:('ADC',ABY,3),0x7D:('ADC',ABX,3),0x7E:('ROR',ABX,3),
0x81:('STA',IZX,2),0x84:('STY',ZP,2),0x85:('STA',ZP,2),0x86:('STX',ZP,2),0x88:('DEY',IMP,1),0x8A:('TXA',IMP,1),0x8C:('STY',ABS,3),0x8D:('STA',ABS,3),0x8E:('STX',ABS,3),
0x90:('BCC',REL,2),0x91:('STA',IZY,2),0x94:('STY',ZPX,2),0x95:('STA',ZPX,2),0x96:('STX',ZPY,2),0x98:('TYA',IMP,1),0x99:('STA',ABY,3),0x9A:('TXS',IMP,1),0x9D:('STA',ABX,3),
0xA0:('LDY',IMM,2),0xA1:('LDA',IZX,2),0xA2:('LDX',IMM,2),0xA4:('LDY',ZP,2),0xA5:('LDA',ZP,2),0xA6:('LDX',ZP,2),0xA8:('TAY',IMP,1),0xA9:('LDA',IMM,2),0xAA:('TAX',IMP,1),0xAC:('LDY',ABS,3),0xAD:('LDA',ABS,3),0xAE:('LDX',ABS,3),
0xB0:('BCS',REL,2),0xB1:('LDA',IZY,2),0xB4:('LDY',ZPX,2),0xB5:('LDA',ZPX,2),0xB6:('LDX',ZPY,2),0xB8:('CLV',IMP,1),0xB9:('LDA',ABY,3),0xBA:('TSX',IMP,1),0xBC:('LDY',ABX,3),0xBD:('LDA',ABX,3),0xBE:('LDX',ABY,3),
0xC0:('CPY',IMM,2),0xC1:('CMP',IZX,2),0xC4:('CPY',ZP,2),0xC5:('CMP',ZP,2),0xC6:('DEC',ZP,2),0xC8:('INY',IMP,1),0xC9:('CMP',IMM,2),0xCA:('DEX',IMP,1),0xCC:('CPY',ABS,3),0xCD:('CMP',ABS,3),0xCE:('DEC',ABS,3),
0xD0:('BNE',REL,2),0xD1:('CMP',IZY,2),0xD5:('CMP',ZPX,2),0xD6:('DEC',ZPX,2),0xD8:('CLD',IMP,1),0xD9:('CMP',ABY,3),0xDD:('CMP',ABX,3),0xDE:('DEC',ABX,3),
0xE0:('CPX',IMM,2),0xE1:('SBC',IZX,2),0xE4:('CPX',ZP,2),0xE5:('SBC',ZP,2),0xE6:('INC',ZP,2),0xE8:('INX',IMP,1),0xE9:('SBC',IMM,2),0xEA:('NOP',IMP,1),0xEC:('CPX',ABS,3),0xED:('SBC',ABS,3),0xEE:('INC',ABS,3),
0xF0:('BEQ',REL,2),0xF1:('SBC',IZY,2),0xF5:('SBC',ZPX,2),0xF6:('INC',ZPX,2),0xF8:('SED',IMP,1),0xF9:('SBC',ABY,3),0xFD:('SBC',ABX,3),0xFE:('INC',ABX,3),
}
from collections import Counter
zp=Counter(); ab=Counter()
def operand(pc):
    op=data[pc-base]
    if op not in tbl: return None
    nm,m,ln=tbl[op]
    if pc-base+ln>len(data): return None
    b1=data[pc-base+1] if ln>=2 else None
    b2=data[pc-base+2] if ln>=3 else None
    val=None;txt=''
    if m==IMM: txt='#$%02X'%b1
    elif m in(ZP,):  val=b1; txt='$%02X'%b1
    elif m==ZPX: val=b1; txt='$%02X,X'%b1
    elif m==ZPY: val=b1; txt='$%02X,Y'%b1
    elif m in(ABS,): val=b1|(b2<<8); txt='$%04X'%val
    elif m==ABX: val=b1|(b2<<8); txt='$%04X,X'%val
    elif m==ABY: val=b1|(b2<<8); txt='$%04X,Y'%val
    elif m==IND: val=b1|(b2<<8); txt='($%04X)'%val
    elif m==IZX: txt='($%02X,X)'%b1
    elif m==IZY: txt='($%02X),Y'%b1
    elif m==REL: tgt=pc+2+((b1^0x80)-0x80); txt='$%04X'%tgt
    elif m==ACC: txt='A'
    return nm,m,ln,txt,val
# linear sweep
out=[]
pc=base
while pc<=0xFFFF:
    r=operand(pc)
    if r is None:
        out.append('%04X: .byte $%02X'%(pc,data[pc-base])); pc+=1; continue
    nm,m,ln,txt,val=r
    bys=' '.join('%02X'%data[pc-base+i] for i in range(ln))
    out.append('%04X: %-8s %s %s'%(pc,bys,nm,txt))
    if nm in('LDA','STA','LDX','STX','LDY','STY','INC','DEC','BIT','CMP','AND','ORA','EOR','ADC','SBC','ASL','LSR','ROL','ROR'):
        if m in(ZP,ZPX,ZPY) and val is not None: zp[val]+=1
        if m in(ABS,ABX,ABY) and val is not None and val<0x0400: ab[val]+=1
    pc+=ln
open('kbc_disasm.txt','w').write('\n'.join(out))
print('disasm lines',len(out),'-> kbc_disasm.txt')
print()
print('=== Most-accessed zero-page SFR/RAM addresses ===')
for a,c in zp.most_common(25): print('  $%02X : %d'%(a,c))
print()
print('=== Low absolute addresses accessed (<0x400) ===')
for a,c in ab.most_common(20): print('  $%04X : %d'%(a,c))
