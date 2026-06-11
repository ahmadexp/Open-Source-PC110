// m38223.cpp — IBM PC110 power-sense MCU (Mitsubishi M38223E4HP, MELPS-740).
// Loads the firmware ROM, models the on-chip peripherals enough to execute,
// resets, and runs with an optional instruction trace.
//
//   ROM:  $C080..$FFFF  (from M38223E4HP@QFP80.BIN)
//   RAM:  $0000..$00FF zero page, $0100..$01FF page-1 (stack + I/O mirror),
//         internal RAM working area
//   SFR:  $00..$3F on-chip special-function registers (ports P0..P6, ADC, timers,
//         serial). Modeled minimally; ADCON ($34) bit3 (conversion complete) is
//         auto-asserted so the firmware's A-D wait loops make progress.
//
// Build:  see CMakeLists.txt / Makefile.   Run: ./m38223 M38223E4HP@QFP80.BIN
#include "m740.h"
#include <cstdio>
#include <cstdint>
#include <cstring>
#include <vector>
#include <string>

struct M38223 {
    uint8_t mem[0x10000];
    M740 cpu;
    bool  trace=false;
    // peripheral shadow
    uint8_t adcon=0x08;          // $34 ADCON, bit3=conversion complete
    uint8_t adc_result=0x80;     // mid-scale dummy A-D reading

    M38223()
      : cpu([this](uint16_t a){ return rd(a); },
            [this](uint16_t a, uint8_t v){ wr(a,v); }) {
        std::memset(mem,0,sizeof mem);
    }

    bool load_rom(const char* path){
        FILE* f=std::fopen(path,"rb"); if(!f) return false;
        std::fseek(f,0,SEEK_END); long n=std::ftell(f); std::fseek(f,0,SEEK_SET);
        std::vector<uint8_t> buf(n); if(std::fread(buf.data(),1,n,f)!=(size_t)n){std::fclose(f);return false;}
        std::fclose(f);
        // Firmware .org is $C080 (banner at $C080). The dump is a few bytes
        // short at the very top ($FFFE-$FFFF), so bottom-align at $C080 rather
        // than top-align; then $FFFC (reset vector) reads $E6B1 as documented.
        uint16_t base = 0xC080;
        for(long i=0;i<n && (base+i)<=0xFFFF;i++) mem[(base+i)&0xFFFF]=buf[i];
        std::printf("loaded %ld bytes at $%04X (covers $C080..$%04X)\n", n, base, (unsigned)(base+n-1));
        return true;
    }

    // --- on-chip SFR read/write ($00..$3F) ---
    uint8_t sfr_read(uint16_t a){
        switch(a){
            case 0x34: return adcon | 0x08;       // ADCON: force conversion-complete bit
            case 0x35: return adc_result;         // A-D conversion result register
            default:   return mem[a];             // ports/timers: last written
        }
    }
    void sfr_write(uint16_t a, uint8_t v){
        mem[a]=v;
        if(a==0x34){ adcon = v; /* starting a conversion still reads complete next */ }
    }

    uint8_t rd(uint16_t a){ if(a<0x40) return sfr_read(a); return mem[a]; }
    void    wr(uint16_t a, uint8_t v){
        if(a>=0xC080){ /* ROM write ignored */ return; }
        if(a<0x40){ sfr_write(a,v); return; }
        mem[a]=v;
    }

    void run(uint64_t max_insns){
        cpu.reset();
        std::printf("reset -> PC=$%04X (vector $FFFC)\n", cpu.PC);
        uint64_t in_main=0;
        for(uint64_t i=0;i<max_insns && !cpu.stopped;i++){
            if(trace && i<40)
                std::printf("  PC=%04X A=%02X X=%02X Y=%02X S=%02X P=%c%c%c%c%c%c\n",
                    cpu.PC,cpu.A,cpu.X,cpu.Y,cpu.S,
                    cpu.N?'N':'-',cpu.V?'V':'-',cpu.D?'D':'-',cpu.I?'I':'-',cpu.Z?'Z':'-',cpu.C?'C':'-');
            if(cpu.PC>=0xC0C6 && cpu.PC<=0xC200) in_main++;   // reached main service loop
            cpu.step();
            // periodic timer interrupt through a PRESENT handler (TIMER2 = $E366,
            // vector $FFF0) — exercises the firmware's ISR path and wakes WIT.
            if((i & 0x1FFF)==0x1FFF){
                cpu.waiting=false;
                uint16_t v = mem[0xFFF0] | (mem[0xFFF1]<<8);
                if(v && !cpu.I) cpu.interrupt(v);
            }
        }
        std::printf("reached main service loop region: %s (%llu hits)\n",
                    in_main? "yes":"no", (unsigned long long)in_main);
        std::printf("ran %llu instructions, %llu cycles; PC=$%04X stopped=%d\n",
            (unsigned long long)cpu.insns,(unsigned long long)cpu.cycles,cpu.PC,(int)cpu.stopped);
    }
};

int main(int argc, char** argv){
    const char* rom = (argc>1)? argv[1] : "M38223E4HP@QFP80.BIN";
    uint64_t budget = (argc>2)? std::strtoull(argv[2],nullptr,0) : 200000ull;
    M38223 m;
    if(!m.load_rom(rom)){ std::fprintf(stderr,"cannot open ROM '%s'\n",rom); return 1; }
    m.trace = true;
    std::printf("M38223 (MELPS-740) power-sense MCU emulator\n");
    m.run(budget);
    return 0;
}
