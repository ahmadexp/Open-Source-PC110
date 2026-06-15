#!/usr/bin/env python3
"""disasm740.py — complete MELPS-740 disassembler for the M38223 power MCU ROM.

Linear sweep over the whole ROM ($C080..$FFFD) with full 740 decoding
(6502 + BRA + BBS/BBC/SEB/CLB/LDM/CLT/SET/TST/RRF/MUL/DIV/STP/WIT). Emits a
self-contained listing including the reset/ISR regions.

Usage:  python3 disasm740.py M38223E4HP@QFP80.BIN > m38223_full_disasm.asm
"""
import sys

BASE = 0xC080

# addressing-mode formatters and operand lengths
def imm(b):  return ("#$%02X"%b[0], 1)
def zp(b):   return ("$%02X"%b[0], 1)
def zpx(b):  return ("$%02X,X"%b[0], 1)
def zpy(b):  return ("$%02X,Y"%b[0], 1)
def absa(b): return ("$%04X"%(b[0]|(b[1]<<8)), 2)
def absx(b): return ("$%04X,X"%(b[0]|(b[1]<<8)), 2)
def absy(b): return ("$%04X,Y"%(b[0]|(b[1]<<8)), 2)
def indx(b): return ("($%02X,X)"%b[0], 1)
def indy(b): return ("($%02X),Y"%b[0], 1)
def ind(b):  return ("($%04X)"%(b[0]|(b[1]<<8)), 2)
def acc(b):  return ("A", 0)
def imp(b):  return ("", 0)
def rel(addr,b): d=b[0]; t=(addr+2+(d-256 if d>127 else d))&0xFFFF; return ("$%04X"%t,1)

# base 6502 table: opcode -> (mnemonic, mode)
T = {
 0x00:("brk",imp),0x08:("php",imp),0x28:("plp",imp),0x48:("pha",imp),0x68:("pla",imp),
 0x18:("clc",imp),0x38:("sec",imp),0x58:("cli",imp),0x78:("sei",imp),0xB8:("clv",imp),
 0xD8:("cld",imp),0xF8:("sed",imp),0xEA:("nop",imp),0xAA:("tax",imp),0x8A:("txa",imp),
 0xA8:("tay",imp),0x98:("tya",imp),0xBA:("tsx",imp),0x9A:("txs",imp),0xCA:("dex",imp),
 0xE8:("inx",imp),0x88:("dey",imp),0xC8:("iny",imp),0x40:("rti",imp),0x60:("rts",imp),
 0x4C:("jmp",absa),0x6C:("jmp",ind),0x20:("jsr",absa),
 0x80:("bra","rel"),0x90:("bcc","rel"),0xB0:("bcs","rel"),0xD0:("bne","rel"),0xF0:("beq","rel"),
 0x10:("bpl","rel"),0x30:("bmi","rel"),0x50:("bvc","rel"),0x70:("bvs","rel"),
 0xA9:("lda",imm),0xA5:("lda",zp),0xB5:("lda",zpx),0xAD:("lda",absa),0xBD:("lda",absx),0xB9:("lda",absy),0xA1:("lda",indx),0xB1:("lda",indy),
 0xA2:("ldx",imm),0xA6:("ldx",zp),0xB6:("ldx",zpy),0xAE:("ldx",absa),0xBE:("ldx",absy),
 0xA0:("ldy",imm),0xA4:("ldy",zp),0xB4:("ldy",zpx),0xAC:("ldy",absa),0xBC:("ldy",absx),
 0x85:("sta",zp),0x95:("sta",zpx),0x8D:("sta",absa),0x9D:("sta",absx),0x99:("sta",absy),0x81:("sta",indx),0x91:("sta",indy),
 0x86:("stx",zp),0x96:("stx",zpy),0x8E:("stx",absa),0x84:("sty",zp),0x94:("sty",zpx),0x8C:("sty",absa),
 0x09:("ora",imm),0x05:("ora",zp),0x15:("ora",zpx),0x0D:("ora",absa),0x1D:("ora",absx),0x19:("ora",absy),0x01:("ora",indx),0x11:("ora",indy),
 0x29:("and",imm),0x25:("and",zp),0x35:("and",zpx),0x2D:("and",absa),0x3D:("and",absx),0x39:("and",absy),0x21:("and",indx),0x31:("and",indy),
 0x49:("eor",imm),0x45:("eor",zp),0x55:("eor",zpx),0x4D:("eor",absa),0x5D:("eor",absx),0x59:("eor",absy),0x41:("eor",indx),0x51:("eor",indy),
 0x69:("adc",imm),0x65:("adc",zp),0x75:("adc",zpx),0x6D:("adc",absa),0x7D:("adc",absx),0x79:("adc",absy),0x61:("adc",indx),0x71:("adc",indy),
 0xE9:("sbc",imm),0xE5:("sbc",zp),0xF5:("sbc",zpx),0xED:("sbc",absa),0xFD:("sbc",absx),0xF9:("sbc",absy),0xE1:("sbc",indx),0xF1:("sbc",indy),
 0xC9:("cmp",imm),0xC5:("cmp",zp),0xD5:("cmp",zpx),0xCD:("cmp",absa),0xDD:("cmp",absx),0xD9:("cmp",absy),0xC1:("cmp",indx),0xD1:("cmp",indy),
 0xE0:("cpx",imm),0xE4:("cpx",zp),0xEC:("cpx",absa),0xC0:("cpy",imm),0xC4:("cpy",zp),0xCC:("cpy",absa),
 0x24:("bit",zp),0x2C:("bit",absa),
 0xE6:("inc",zp),0xF6:("inc",zpx),0xEE:("inc",absa),0xFE:("inc",absx),0xC6:("dec",zp),0xD6:("dec",zpx),0xCE:("dec",absa),0xDE:("dec",absx),
 0x0A:("asl",acc),0x06:("asl",zp),0x16:("asl",zpx),0x0E:("asl",absa),0x1E:("asl",absx),
 0x4A:("lsr",acc),0x46:("lsr",zp),0x56:("lsr",zpx),0x4E:("lsr",absa),0x5E:("lsr",absx),
 0x2A:("rol",acc),0x26:("rol",zp),0x36:("rol",zpx),0x2E:("rol",absa),0x3E:("rol",absx),
 0x6A:("ror",acc),0x66:("ror",zp),0x76:("ror",zpx),0x6E:("ror",absa),0x7E:("ror",absx),
 # 740 extensions
 0x12:("clt",imp),0x32:("set",imp),0x42:("stp",imp),0xC2:("wit",imp),
 0x3C:("ldm","ldm"),0x64:("tst",zp),0x92:("rrf",zp),0x62:("mul",zpx),0xE2:("div",zpx),
}
# bit-addressed 740 ops
def bitop(op):
    bit=(op>>5)&7; lo=op&0x1F
    if lo==0x07: return ("bbs%d"%bit,"bbr")   # zp,rel
    if lo==0x17: return ("bbc%d"%bit,"bbr")
    if lo==0x0B: return ("seb%d"%bit,acc)
    if lo==0x1B: return ("clb%d"%bit,acc)
    if lo==0x0F: return ("seb%d"%bit,zp)
    if lo==0x1F: return ("clb%d"%bit,zp)
    return None

def main():
    rom=open(sys.argv[1],"rb").read()
    end=BASE+len(rom)
    print("; M38223E4HP power-sense MCU — complete MELPS-740 disassembly")
    print("; .org $%04X   (%d bytes, $%04X..$%04X)\n"%(BASE,len(rom),BASE,end-1))
    a=BASE
    while a<end:
        off=a-BASE; op=rom[off]; b=rom[off+1:off+4]
        ent=T.get(op) or bitop(op)
        if ent is None:
            print("%04X: %02X        .byte $%02X"%(a,op,op)); a+=1; continue
        mn,mode=ent
        if mode=="rel": ops,n=rel(a,b)
        elif mode=="bbr":
            zpb=b[0]; ops,_=rel(a+1,b[1:]); ops="$%02X,%s"%(zpb,ops); n=2
        elif mode=="ldm": ops="#$%02X,$%02X"%(b[0],b[1]); n=2
        elif callable(mode): ops,n=mode(b)
        else: ops,n=("",0)
        raw=rom[off:off+1+n]
        print("%04X: %-10s %-5s %s"%(a," ".join("%02X"%x for x in raw),mn,ops))
        a+=1+n

if __name__=="__main__": main()
