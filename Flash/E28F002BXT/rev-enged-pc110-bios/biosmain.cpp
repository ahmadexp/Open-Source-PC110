// biosmain.cpp — PC110 replacement BIOS, freestanding C++ core.
// Builds with ia16-elf-g++ (or Open Watcom) as 16-bit real-mode code; NO STL,
// NO exceptions, NO RTTI. Linked below the reset stub in the F000 image.
//
//   ia16-elf-g++ -std=c++17 -ffreestanding -fno-exceptions -fno-rtti \
//                -mcmodel=tiny -Os -c biosmain.cpp -o biosmain.o
//
// The hardware init sequences here are the ones recovered from the real IBM
// 39H4551 BIOS by disassembly. This is a *bring-up* core: it programs the
// VL82C420 + standard cores, runs a skeletal POST, installs the IVT, and calls
// the bootstrap. Implementing full DRAM sizing and the INT services is the
// remaining work — develop it under PC110-EMU before flashing.
#include <stdint.h>
using u8  = uint8_t;
using u16 = uint16_t;

// ---- port I/O (inline asm; the only way to reach hardware in freestanding) -
static inline void  outb(u16 p, u8 v){ __asm__ __volatile__("outb %0,%1"::"a"(v),"Nd"(p)); }
static inline u8    inb (u16 p){ u8 v; __asm__ __volatile__("inb %1,%0":"=a"(v):"Nd"(p)); return v; }
static inline void  cli (){ __asm__ __volatile__("cli"); }
static inline void  sti (){ __asm__ __volatile__("sti"); }
static inline void  post(u8 c){ outb(0x80, c); }   // POST checkpoint port

// ===========================================================================
// VL82C420 system controller programming (recovered from 39H4551 POST).
// Ports kept identical to PC110-EMU so the two cross-check 1:1.
// ===========================================================================
namespace vl82c420 {
    // 0x4F config-latch indices the real BIOS writes during POST:
    static const u8 CFG4F[] = {0x11,0x66,0x70,0x0A,0x1E,0xB6,0x8F,0x65,0xBF,0xFF};

    void init() {
        for (u8 i : CFG4F) outb(0x4F, i);   // select/initialise chipset fields
        outb(0x22, 0x80); outb(0x23, 0x80); // config-space unlock
        outb(0x8B, 0x6F); outb(0x8B, 0x0A); // 0x8B config byte sequence
        outb(0x8B, 0x80); outb(0x8B, 0x70); outb(0x8B, 0x71);
        outb(0x98, 0xBF);
        outb(0xF1, 0x65);
        (void)inb(0x76);                    // SCAMP 0x74/0x76 probe (idx 0x80 set elsewhere)
    }
}

// ---- 8259 PIC pair, 8254 PIT, 146818 RTC, 8042 KBC (integrated cores) ------
static void pic_init() {
    outb(0x20,0x11); outb(0xA0,0x11);       // ICW1
    outb(0x21,0x08); outb(0xA1,0x70);       // ICW2 vector bases
    outb(0x21,0x04); outb(0xA1,0x02);       // ICW3 cascade
    outb(0x21,0x01); outb(0xA1,0x01);       // ICW4 8086 mode
    outb(0x21,0xFF); outb(0xA1,0xFF);       // mask all during POST
}
static void pit_init() {
    outb(0x43,0x36); outb(0x40,0x00); outb(0x40,0x00);   // timer0 square wave
}
static u8   cmos_read(u8 i){ outb(0x70,i); return inb(0x71); }
static void kbc_selftest(){ outb(0x64,0xAA); /* poll 0x64 status, read 0x60 */ }
static void a20_enable(){ u8 v=inb(0x92); outb(0x92,(u8)(v|0x02)); }

// ---- POST stages -----------------------------------------------------------
static void memory_sizing() {
    // TODO(bring-up): walk DRAM via VL82C420 RAS/CAS config and size detection.
    // This is the gating step for running the rest of POST from RAM.
}
static void install_ivt() {
    // TODO(bring-up): write far pointers for INT 08-0F, 10, 13, 15, 16, 19, 1A
    // into 0000:0000.. pointing at the handlers below.
}

// ---- BIOS service handlers (installed in the IVT; called via INT) ----------
extern "C" void int10_video();      // -> Chips 65535 VGA BIOS at C000:3
extern "C" void int13_disk();       // PCMCIA-ATA / floppy
extern "C" void int15_misc();       // APM 1.00.27 + extended memory
extern "C" void int16_kbd();        // 8042 keyboard
extern "C" void int1a_rtc();        // 146818 time
extern "C" void int19_boot();       // bootstrap

// ===========================================================================
// bios_main — called from reset.asm _entry16. Must not return.
// ===========================================================================
extern "C" void bios_main() {
    cli();
    post(0x02); vl82c420::init();       // chipset first (clocks, refresh, decode)
    post(0x03); pic_init(); pit_init(); // interrupt + timer cores
    post(0x04); a20_enable(); memory_sizing();
    post(0x05); (void)cmos_read(0x0D);  // RTC battery/validity (146818 Reg D)
    kbc_selftest();
    post(0x06); install_ivt();
    post(0xFF);                         // POST complete checkpoint
    sti();
    int19_boot();                       // load boot sector / ROM image
    for(;;) __asm__ __volatile__("hlt");
}

// Minimal service stubs so the image links; flesh out under the emulator.
extern "C" void int10_video(){}
extern "C" void int13_disk (){}
extern "C" void int15_misc (){}
extern "C" void int16_kbd  (){}
extern "C" void int1a_rtc  (){}
extern "C" void int19_boot (){}
