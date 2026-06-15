// m740.cpp — MELPS-740 core implementation.
#include "m740.h"

// --- 740 T-flag mode: when T=1, ALU result is stored to zero-page M[X], not A.
static inline uint8_t aluLoad(M740& c){ return c.T ? c.read((uint8_t)c.X) : c.A; }
static inline void    aluStore(M740& c, uint8_t v){ if (c.T) c.write((uint8_t)c.X, v); else c.A=v; }
// (read/write/X/A/T are public in M740 for this helper.)

void M740::ora(uint8_t m){ uint8_t r=aluLoad(*this)|m; setZN(r); aluStore(*this,r); }
void M740::andv(uint8_t m){ uint8_t r=aluLoad(*this)&m; setZN(r); aluStore(*this,r); }
void M740::eorv(uint8_t m){ uint8_t r=aluLoad(*this)^m; setZN(r); aluStore(*this,r); }
void M740::adc(uint8_t m){
    uint8_t a=aluLoad(*this); uint16_t s=a+m+(C?1:0);
    if (D){ // BCD
        uint16_t lo=(a&0x0F)+(m&0x0F)+(C?1:0);
        uint16_t hi=(a>>4)+(m>>4)+(lo>9?1:0);
        if(lo>9)lo+=6; if(hi>9)hi+=6;
        s=((hi<<4)|(lo&0x0F)); C=hi>9; uint8_t r=(uint8_t)s; setZN(r); aluStore(*this,r); return;
    }
    C=s>0xFF; V=(~(a^m)&(a^s)&0x80)!=0; uint8_t r=(uint8_t)s; setZN(r); aluStore(*this,r);
}
void M740::sbc(uint8_t m){
    uint8_t a=aluLoad(*this); uint16_t s=a-m-(C?0:1);
    C=s<0x100; V=((a^m)&(a^s)&0x80)!=0; uint8_t r=(uint8_t)s; setZN(r); aluStore(*this,r);
}

int M740::step(){
    if (stopped) return 0;
    if (waiting) { /* WIT: idle until interrupt; emulate as spin */ cycles+=1; return 1; }
    insns++;
    uint8_t op=fetch();
    auto RMW=[&](uint16_t addr, uint8_t(*f)(M740&,uint8_t)){ uint8_t v=read(addr); v=f(*this,v); write(addr,v); };
    switch(op){
    // ---- 740 extensions ----
    case 0x12: T=false; break;                          // CLT
    case 0x32: T=true;  break;                          // SET
    case 0x42: stopped=true; break;                     // STP
    case 0xC2: waiting=true; break;                     // WIT
    case 0x3C: { uint8_t imm=fetch(); uint16_t a=a_zp(); write(a,imm); } break; // LDM #imm,zp
    case 0x64: { uint16_t a=a_zp(); setZN(read(a)); } break;                    // TST zp
    case 0x92: { uint16_t a=a_zp(); uint8_t v=read(a); v=(uint8_t)((v>>4)|(v<<4)); write(a,v); } break; // RRF (nibble swap)
    case 0x62: { uint16_t a=(uint8_t)(fetch()+X); uint16_t p=A*read(a);          // MUL zp,X
                 push((uint8_t)(p>>8)); A=(uint8_t)p; setZN(A); } break;
    case 0xE2: { uint16_t a=(uint8_t)(fetch()+X); uint8_t d=read(a);             // DIV zp,X
                 uint16_t num=(pull()<<8)|A; if(d){ A=(uint8_t)(num/d); X=(uint8_t)(num%d);} setZN(A);} break;
    default: break;
    }
    // BBS/BBC (0x07/0x17 + 0x20*bit), SEB/CLB (0x0B/0x1B acc, 0x0F/0x1F zp)
    if ((op&0x0F)==0x07){ int bit=(op>>5)&7; bool set=((op>>4)&1)==0; // 0x_7 even hi=BBS, odd=BBC
        uint16_t a=a_zp(); int8_t rel=(int8_t)fetch(); bool b=(read(a)>>bit)&1;
        if (set? b : !b) PC=(uint16_t)(PC+rel); return 3; }
    if ((op&0x0F)==0x0B){ int bit=(op>>5)&7; bool clr=((op>>4)&1)!=0;            // SEB/CLB A
        if(clr) A&=~(1<<bit); else A|=(1<<bit); return 2; }
    if ((op&0x0F)==0x0F){ int bit=(op>>5)&7; bool clr=((op>>4)&1)!=0;            // SEB/CLB zp
        uint16_t a=a_zp(); uint8_t v=read(a); if(clr)v&=~(1<<bit); else v|=(1<<bit); write(a,v); return 2; }

    switch(op){
    // ---- loads/stores ----
    case 0xA9: A=fetch(); setZN(A); break;
    case 0xA5: A=read(a_zp()); setZN(A); break;
    case 0xB5: A=read(a_zpx()); setZN(A); break;
    case 0xAD: A=read(a_abs()); setZN(A); break;
    case 0xBD: A=read(a_absx()); setZN(A); break;
    case 0xB9: A=read(a_absy()); setZN(A); break;
    case 0xA1: A=read(a_indx()); setZN(A); break;
    case 0xB1: A=read(a_indy()); setZN(A); break;
    case 0xA2: X=fetch(); setZN(X); break;
    case 0xA6: X=read(a_zp()); setZN(X); break;
    case 0xB6: X=read(a_zpy()); setZN(X); break;
    case 0xAE: X=read(a_abs()); setZN(X); break;
    case 0xBE: X=read(a_absy()); setZN(X); break;
    case 0xA0: Y=fetch(); setZN(Y); break;
    case 0xA4: Y=read(a_zp()); setZN(Y); break;
    case 0xB4: Y=read(a_zpx()); setZN(Y); break;
    case 0xAC: Y=read(a_abs()); setZN(Y); break;
    case 0xBC: Y=read(a_absx()); setZN(Y); break;
    case 0x85: write(a_zp(),A); break;
    case 0x95: write(a_zpx(),A); break;
    case 0x8D: write(a_abs(),A); break;
    case 0x9D: write(a_absx(),A); break;
    case 0x99: write(a_absy(),A); break;
    case 0x81: write(a_indx(),A); break;
    case 0x91: write(a_indy(),A); break;
    case 0x86: write(a_zp(),X); break;
    case 0x96: write(a_zpy(),X); break;
    case 0x8E: write(a_abs(),X); break;
    case 0x84: write(a_zp(),Y); break;
    case 0x94: write(a_zpx(),Y); break;
    case 0x8C: write(a_abs(),Y); break;
    // ---- transfers ----
    case 0xAA: X=A; setZN(X); break;  case 0x8A: A=X; setZN(A); break;
    case 0xA8: Y=A; setZN(Y); break;  case 0x98: A=Y; setZN(A); break;
    case 0xBA: X=S; setZN(X); break;  case 0x9A: S=X; break;
    // ---- stack ----
    case 0x48: push(A); break;        case 0x68: A=pull(); setZN(A); break;
    case 0x08: push(pack(true)); break; case 0x28: unpack(pull()); break;
    // ---- ALU ----
    case 0x09: ora(fetch()); break;   case 0x05: ora(read(a_zp())); break;
    case 0x15: /*handled above? no, 0x15 low nibble 5*/ ora(read(a_zpx())); break;
    case 0x0D: ora(read(a_abs())); break; case 0x1D: ora(read(a_absx())); break;
    case 0x19: ora(read(a_absy())); break; case 0x01: ora(read(a_indx())); break;
    case 0x11: ora(read(a_indy())); break;
    case 0x29: andv(fetch()); break;  case 0x25: andv(read(a_zp())); break;
    case 0x35: andv(read(a_zpx())); break; case 0x2D: andv(read(a_abs())); break;
    case 0x3D: andv(read(a_absx())); break; case 0x39: andv(read(a_absy())); break;
    case 0x21: andv(read(a_indx())); break; case 0x31: andv(read(a_indy())); break;
    case 0x49: eorv(fetch()); break;  case 0x45: eorv(read(a_zp())); break;
    case 0x55: eorv(read(a_zpx())); break; case 0x4D: eorv(read(a_abs())); break;
    case 0x5D: eorv(read(a_absx())); break; case 0x59: eorv(read(a_absy())); break;
    case 0x41: eorv(read(a_indx())); break; case 0x51: eorv(read(a_indy())); break;
    case 0x69: adc(fetch()); break;   case 0x65: adc(read(a_zp())); break;
    case 0x75: adc(read(a_zpx())); break; case 0x6D: adc(read(a_abs())); break;
    case 0x7D: adc(read(a_absx())); break; case 0x79: adc(read(a_absy())); break;
    case 0x61: adc(read(a_indx())); break; case 0x71: adc(read(a_indy())); break;
    case 0xE9: sbc(fetch()); break;   case 0xE5: sbc(read(a_zp())); break;
    case 0xF5: sbc(read(a_zpx())); break; case 0xED: sbc(read(a_abs())); break;
    case 0xFD: sbc(read(a_absx())); break; case 0xF9: sbc(read(a_absy())); break;
    case 0xE1: sbc(read(a_indx())); break; case 0xF1: sbc(read(a_indy())); break;
    case 0xC9: cmpreg(A,fetch()); break; case 0xC5: cmpreg(A,read(a_zp())); break;
    case 0xD5: cmpreg(A,read(a_zpx())); break; case 0xCD: cmpreg(A,read(a_abs())); break;
    case 0xDD: cmpreg(A,read(a_absx())); break; case 0xD9: cmpreg(A,read(a_absy())); break;
    case 0xC1: cmpreg(A,read(a_indx())); break; case 0xD1: cmpreg(A,read(a_indy())); break;
    case 0xE0: cmpreg(X,fetch()); break; case 0xE4: cmpreg(X,read(a_zp())); break; case 0xEC: cmpreg(X,read(a_abs())); break;
    case 0xC0: cmpreg(Y,fetch()); break; case 0xC4: cmpreg(Y,read(a_zp())); break; case 0xCC: cmpreg(Y,read(a_abs())); break;
    case 0x24: { uint8_t m=read(a_zp()); Z=((A&m)==0); N=m&0x80; V=m&0x40; } break;
    case 0x2C: { uint8_t m=read(a_abs()); Z=((A&m)==0); N=m&0x80; V=m&0x40; } break;
    // ---- inc/dec ----
    case 0xE6: { uint16_t a=a_zp(); uint8_t v=read(a)+1; write(a,v); setZN(v);} break;
    case 0xF6: { uint16_t a=a_zpx(); uint8_t v=read(a)+1; write(a,v); setZN(v);} break;
    case 0xEE: { uint16_t a=a_abs(); uint8_t v=read(a)+1; write(a,v); setZN(v);} break;
    case 0xFE: { uint16_t a=a_absx(); uint8_t v=read(a)+1; write(a,v); setZN(v);} break;
    case 0xC6: { uint16_t a=a_zp(); uint8_t v=read(a)-1; write(a,v); setZN(v);} break;
    case 0xD6: { uint16_t a=a_zpx(); uint8_t v=read(a)-1; write(a,v); setZN(v);} break;
    case 0xCE: { uint16_t a=a_abs(); uint8_t v=read(a)-1; write(a,v); setZN(v);} break;
    case 0xDE: { uint16_t a=a_absx(); uint8_t v=read(a)-1; write(a,v); setZN(v);} break;
    case 0xE8: X++; setZN(X); break;  case 0xCA: X--; setZN(X); break;
    case 0xC8: Y++; setZN(Y); break;  case 0x88: Y--; setZN(Y); break;
    // ---- shifts ----
    case 0x0A: { C=A&0x80; A<<=1; setZN(A);} break;
    case 0x06: { uint16_t a=a_zp(); uint8_t v=read(a); C=v&0x80; v<<=1; write(a,v); setZN(v);} break;
    case 0x16: { uint16_t a=a_zpx(); uint8_t v=read(a); C=v&0x80; v<<=1; write(a,v); setZN(v);} break;
    case 0x0E: { uint16_t a=a_abs(); uint8_t v=read(a); C=v&0x80; v<<=1; write(a,v); setZN(v);} break;
    case 0x1E: { uint16_t a=a_absx(); uint8_t v=read(a); C=v&0x80; v<<=1; write(a,v); setZN(v);} break;
    case 0x4A: { C=A&1; A>>=1; setZN(A);} break;
    case 0x46: { uint16_t a=a_zp(); uint8_t v=read(a); C=v&1; v>>=1; write(a,v); setZN(v);} break;
    case 0x56: { uint16_t a=a_zpx(); uint8_t v=read(a); C=v&1; v>>=1; write(a,v); setZN(v);} break;
    case 0x4E: { uint16_t a=a_abs(); uint8_t v=read(a); C=v&1; v>>=1; write(a,v); setZN(v);} break;
    case 0x5E: { uint16_t a=a_absx(); uint8_t v=read(a); C=v&1; v>>=1; write(a,v); setZN(v);} break;
    case 0x2A: { bool c=C; C=A&0x80; A=(A<<1)|(c?1:0); setZN(A);} break;
    case 0x26: { uint16_t a=a_zp(); uint8_t v=read(a); bool c=C; C=v&0x80; v=(v<<1)|(c?1:0); write(a,v); setZN(v);} break;
    case 0x36: { uint16_t a=a_zpx(); uint8_t v=read(a); bool c=C; C=v&0x80; v=(v<<1)|(c?1:0); write(a,v); setZN(v);} break;
    case 0x2E: { uint16_t a=a_abs(); uint8_t v=read(a); bool c=C; C=v&0x80; v=(v<<1)|(c?1:0); write(a,v); setZN(v);} break;
    case 0x3E: { uint16_t a=a_absx(); uint8_t v=read(a); bool c=C; C=v&0x80; v=(v<<1)|(c?1:0); write(a,v); setZN(v);} break;
    case 0x6A: { bool c=C; C=A&1; A=(A>>1)|(c?0x80:0); setZN(A);} break;
    case 0x66: { uint16_t a=a_zp(); uint8_t v=read(a); bool c=C; C=v&1; v=(v>>1)|(c?0x80:0); write(a,v); setZN(v);} break;
    case 0x76: { uint16_t a=a_zpx(); uint8_t v=read(a); bool c=C; C=v&1; v=(v>>1)|(c?0x80:0); write(a,v); setZN(v);} break;
    case 0x6E: { uint16_t a=a_abs(); uint8_t v=read(a); bool c=C; C=v&1; v=(v>>1)|(c?0x80:0); write(a,v); setZN(v);} break;
    case 0x7E: { uint16_t a=a_absx(); uint8_t v=read(a); bool c=C; C=v&1; v=(v>>1)|(c?0x80:0); write(a,v); setZN(v);} break;
    // ---- branches ----
    case 0x80: { int8_t r=(int8_t)fetch(); PC+=r; } break;   // BRA (740/65C02)
    case 0x90: { int8_t r=(int8_t)fetch(); if(!C) PC+=r; } break;
    case 0xB0: { int8_t r=(int8_t)fetch(); if(C) PC+=r; } break;
    case 0xD0: { int8_t r=(int8_t)fetch(); if(!Z) PC+=r; } break;
    case 0xF0: { int8_t r=(int8_t)fetch(); if(Z) PC+=r; } break;
    case 0x10: { int8_t r=(int8_t)fetch(); if(!N) PC+=r; } break;
    case 0x30: { int8_t r=(int8_t)fetch(); if(N) PC+=r; } break;
    case 0x50: { int8_t r=(int8_t)fetch(); if(!V) PC+=r; } break;
    case 0x70: { int8_t r=(int8_t)fetch(); if(V) PC+=r; } break;
    // ---- jumps/calls ----
    case 0x4C: PC=a_abs(); break;
    case 0x6C: { uint16_t p=a_abs(); uint16_t lo=read(p); uint16_t hi=read((uint16_t)((p&0xFF00)|((p+1)&0xFF))); PC=lo|(hi<<8);} break;
    case 0x20: { uint16_t t=a_abs(); push16((uint16_t)(PC-1)); PC=t; } break;
    case 0x60: PC=(uint16_t)(pull16()+1); break;
    case 0x40: unpack(pull()); PC=pull16(); break;
    case 0x00: { PC++; uint16_t v=read(0xFFFE)|(read(0xFFFF)<<8);   // BRK
                 if(v){ push16(PC); push(pack(true)); I=true; PC=v; }
                 /* else: $FFFE-$FFFF absent from this dump — treat as trap-skip */ } break;
    // ---- flags ----
    case 0x18: C=false; break; case 0x38: C=true; break;
    case 0x58: I=false; break; case 0x78: I=true; break;
    case 0xB8: V=false; break; case 0xD8: D=false; break; case 0xF8: D=true; break;
    case 0xEA: break; // NOP
    default: /* extension handled earlier, or unknown -> NOP */ break;
    }
    cycles += 2;
    return 2;
}
