// m740.h — Mitsubishi MELPS-740 (6502-superset) CPU core, C++.
// Implements the full NMOS 6502 set plus the 740 extensions used by the IBM
// PC110 power-sense MCU (M38223): BBS/BBC, SEB/CLB (zp & A), LDM, CLT/SET (T),
// TST, RRF, MUL, DIV, STP, WIT, plus the T-flag memory-operation mode.
//
// Opcodes verified against the project disassembly:
//   BBS b: 0x07+0x20*b (zp,rel)     BBC b: 0x17+0x20*b (zp,rel)
//   SEB b: 0x0B+0x20*b (A) / 0x0F+0x20*b (zp)
//   CLB b: 0x1B+0x20*b (A) / 0x1F+0x20*b (zp)
//   LDM 0x3C (#imm,zp)  CLT 0x12  SET 0x32  TST 0x64  RRF 0x92
//   MUL 0x62 (zp,X)     DIV 0xE2 (zp,X)     STP 0x42  WIT 0xC2
#pragma once
#include <cstdint>
#include <functional>

class M740 {
public:
    using Read  = std::function<uint8_t(uint16_t)>;
    using Write = std::function<void(uint16_t, uint8_t)>;
    Read  read;
    Write write;

    // registers
    uint8_t  A=0, X=0, Y=0, S=0xFF;
    uint16_t PC=0;
    // flags
    bool C=false,Z=false,I=true,D=false,B=false,V=false,N=false,T=false;
    bool stopped=false, waiting=false;
    uint64_t cycles=0, insns=0;

    explicit M740(Read r, Write w): read(r), write(w) {}

    void reset() {
        S=0xFF; I=true; D=false; T=false; stopped=waiting=false;
        PC = (uint16_t)(read(0xFFFC) | (read(0xFFFD)<<8));
    }
    void irq() {
        if (I) return;
        push16(PC); push(pack(false)); I=true; waiting=false;
        PC = (uint16_t)(read(0xFFFE) | (read(0xFFFF)<<8));
    }
    void nmi() {
        push16(PC); push(pack(false)); I=true; waiting=false;
        PC = (uint16_t)(read(0xFFFA) | (read(0xFFFB)<<8));
    }
    // enter an interrupt handler at an explicit vector (used to drive on-chip
    // timer/serial interrupts whose vectors live in the $FFDC-$FFFB table)
    void interrupt(uint16_t vec) {
        push16(PC); push(pack(false)); I=true; waiting=false; PC=vec;
    }

    // execute one instruction; returns cycles consumed (approx)
    int step();

private:
    // --- helpers ---
    uint8_t  fetch(){ return read(PC++); }
    uint16_t fetch16(){ uint16_t v=read(PC)|(read((uint16_t)(PC+1))<<8); PC+=2; return v; }
    void push(uint8_t v){ write((uint16_t)(0x100+S), v); S--; }
    uint8_t pull(){ S++; return read((uint16_t)(0x100+S)); }
    void push16(uint16_t v){ push((uint8_t)(v>>8)); push((uint8_t)v); }
    uint16_t pull16(){ uint8_t lo=pull(), hi=pull(); return (uint16_t)(lo|(hi<<8)); }
    uint8_t pack(bool brk){ return (C?1:0)|(Z?2:0)|(I?4:0)|(D?8:0)|(brk?0x10:0)|0x20|(V?0x40:0)|(N?0x80:0); }
    void unpack(uint8_t p){ C=p&1;Z=p&2;I=p&4;D=p&8;B=p&0x10;V=p&0x40;N=p&0x80; }
    void setZN(uint8_t v){ Z=(v==0); N=(v&0x80)!=0; }

    // addressing
    uint16_t a_zp(){ return fetch(); }
    uint16_t a_zpx(){ return (uint8_t)(fetch()+X); }
    uint16_t a_zpy(){ return (uint8_t)(fetch()+Y); }
    uint16_t a_abs(){ return fetch16(); }
    uint16_t a_absx(){ return (uint16_t)(fetch16()+X); }
    uint16_t a_absy(){ return (uint16_t)(fetch16()+Y); }
    uint16_t a_indx(){ uint8_t zp=(uint8_t)(fetch()+X); return read(zp)|(read((uint8_t)(zp+1))<<8); }
    uint16_t a_indy(){ uint8_t zp=fetch(); uint16_t b=read(zp)|(read((uint8_t)(zp+1))<<8); return (uint16_t)(b+Y); }

    // ALU (honours 740 T flag: when T, result goes to M[X] not A)
    void adc(uint8_t m);
    void sbc(uint8_t m);
    void cmpreg(uint8_t reg, uint8_t m){ uint16_t t=reg-m; C=reg>=m; setZN((uint8_t)t); }
    void ora(uint8_t m); void andv(uint8_t m); void eorv(uint8_t m);
};
