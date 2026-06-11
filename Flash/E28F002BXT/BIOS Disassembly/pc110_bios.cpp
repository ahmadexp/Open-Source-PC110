// pc110_bios.cpp
// -----------------------------------------------------------------------------
// IBM Palm Top PC110 system BIOS (IBM p/n 39H4551, RIOS Systems 1993-1994)
// **Compilable C++ reconstruction scaffold** derived from recursive-descent
// disassembly of Roms/pc110_bios.bin (E28F002BXT, 256 KiB; system BIOS = the
// F000 segment, file 0x30000-0x3FFFF; reset entry F000:E05B).
//
// This is NOT a byte-faithful decompile. A 64 KiB hand-written real-mode BIOS
// (plus an embedded Chips-65535 VGA BIOS and a packed region) cannot be turned
// into idiomatic C++ automatically. Instead this models the *structure* the
// disassembly recovered: the hardware I/O interface (named to match the
// PC110-EMU core), the memory map, the reset/POST flow, the ISR entry points,
// and the observed VL82C420 chipset programming sequence.
//
// Pairs with ahmadexp/PC110-EMU Sources/PC110Core/pc110_core.c: the emulator
// models the hardware side (rtc_*, pic_*, pit_*, kbc_*, dma_*, vl82c420_*),
// this models the firmware side that drives it. Port numbers below are kept
// identical to the emulator so the two can be cross-checked 1:1.
//
// Build:  g++ -std=c++17 -Wall -Wextra -O2 pc110_bios.cpp -o pc110_bios
// -----------------------------------------------------------------------------
#include <cstdint>
#include <cstdio>
#include <array>

namespace pc110 {

using u8  = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;

// ---------------------------------------------------------------------------
// Memory map (real-mode segments / physical)
// ---------------------------------------------------------------------------
namespace mem {
    constexpr u32 IVT_BASE      = 0x00000;   // interrupt vector table
    constexpr u32 BDA_BASE      = 0x00400;   // BIOS data area (40:00)
    constexpr u32 EBDA_HINT     = 0x9FC00;   // extended BDA (top of base RAM)
    constexpr u32 VGA_TEXT      = 0xB8000;   // CGA/VGA text framebuffer
    constexpr u32 VGA_GRAPH     = 0xA0000;   // VGA graphics framebuffer
    constexpr u32 VGA_BIOS      = 0xC0000;   // Chips 65535 option ROM (file 0x20000)
    constexpr u32 SYS_BIOS      = 0xF0000;   // system BIOS, F000 (file 0x30000)
    constexpr u32 RESET_VECTOR  = 0xFFFF0;   // F000:FFF0 -> JMP F000:E05B
    // PC110 ROM image regions (file offsets within the 256 KiB flash):
    constexpr u32 ROM_BOOTBLK   = 0x00000;   // flash boot block / header + date
    constexpr u32 ROM_VGABIOS   = 0x20000;   // Chips 65535 VGA BIOS (36352 B)
    constexpr u32 ROM_SYSBIOS   = 0x30000;   // IBM 39H4551 system BIOS (64 KiB)
}

// ---------------------------------------------------------------------------
// Hardware I/O layer.  Replace these two with real port I/O on metal, or wire
// them to the PC110-EMU core (pc110_io_read8 / pc110_io_write8).
// ---------------------------------------------------------------------------
struct IoBus {
    virtual u8   in8 (u16 port) = 0;
    virtual void out8(u16 port, u8 v) = 0;
    virtual ~IoBus() = default;
};

// ---------------------------------------------------------------------------
// I/O port map.  Names/addresses kept identical to PC110-EMU pc110_core.c.
//   Standard cores (confirmed present in the BIOS and modeled by the emulator):
//     0x20/0x21,0xA0/0xA1  82C59 PIC pair          (integrated in VL82C420)
//     0x40-0x43            82C54 PIT               (integrated)
//     0x60/0x61/0x64       8042-class KBC + Port B
//     0x70/0x71            MC146818 RTC/CMOS       (integrated)
//     0x00-0x0F,0xC0-0xDF  8237 DMA (primary/secondary)
//     0x80-0x8F            DMA page registers
//     0x92                 PS/2 system control port A (A20 / fast reset)
//   VL82C420-specific indexed register files (emulator stubs these out):
//     0x4F                 PC110 config latch / index
//     0x22/0x23            chipset config index/data
//     0x74/0x76            SCAMP/VLSI index/data pair
//     0x88-0x8C, 0x94,0x98 chipset config bytes
//     0x15EA/0x15EB, 0x35EA/0x35EB  extended indexed register blocks
// ---------------------------------------------------------------------------
namespace port {
    constexpr u16 PIC1=0x20, PIC1_MASK=0x21, PIC2=0xA0, PIC2_MASK=0xA1;
    constexpr u16 PIT0=0x40, PIT1=0x41, PIT2=0x42, PIT_CTL=0x43;
    constexpr u16 KBC_DATA=0x60, PORT_B=0x61, KBC_CMD=0x64;
    constexpr u16 RTC_INDEX=0x70, RTC_DATA=0x71;
    constexpr u16 A20_SYSCTL=0x92, POST_CARD=0x80;
    // VL82C420 chipset
    constexpr u16 VL_CFG_IDX=0x22, VL_CFG_DATA=0x23;   // config index/data
    constexpr u16 VL_CFG_LATCH=0x4F;                    // PC110 config latch/index
    constexpr u16 SCAMP_IDX=0x74, SCAMP_DATA=0x76;      // SCAMP indexed pair
    constexpr u16 VL_8B=0x8B, VL_94=0x94, VL_98=0x98, VL_F1=0xF1;
    constexpr u16 EXT15_IDX=0x15EA, EXT15_DATA=0x15EB;
    constexpr u16 EXT35_IDX=0x35EA, EXT35_DATA=0x35EB;
}

// ---------------------------------------------------------------------------
// MC146818 RTC/CMOS register indices (integrated RTC core; ports 0x70/0x71).
// ---------------------------------------------------------------------------
namespace cmos {
    constexpr u8 SEC=0x00, MIN=0x02, HOUR=0x04, DOW=0x06, DAY=0x07, MONTH=0x08, YEAR=0x09;
    constexpr u8 REG_A=0x0A, REG_B=0x0B, REG_C=0x0C, REG_D=0x0D;   // SQWE/RS in A/B; IRQ flags in C
    constexpr u8 SHUTDOWN=0x0F, CENTURY=0x32;
}

// ===========================================================================
// VL82C420 system controller — firmware-side register interface.
// The BIOS programs the chipset almost entirely through the 0x4F config latch
// and a handful of direct config ports.  The register *indices* below were
// recovered from POST (the actual values the BIOS writes); their *meaning* is
// still being mapped — this is the new data point for PC110-EMU's currently
// stubbed vl82c420_write().
// ===========================================================================
class VL82C420 {
public:
    explicit VL82C420(IoBus& io) : io_(io) {}

    // 0x4F is an index/latch: OUT 0x4F,idx selects a chipset config field; the
    // associated data is then accessed via the RTC/CMOS data path (0x70/0x71)
    // in the PC110 "config routing" mode the emulator models, or applied
    // directly depending on the field.
    void cfg_latch(u8 index)              { io_.out8(port::VL_CFG_LATCH, index); }

    // 0x22/0x23 classic chipset config index/data (BIOS unlocks with 0x80).
    void cfg_write(u8 index, u8 value)    { io_.out8(port::VL_CFG_IDX,index); io_.out8(port::VL_CFG_DATA,value); }
    u8   cfg_read (u8 index)              { io_.out8(port::VL_CFG_IDX,index); return io_.in8(port::VL_CFG_DATA); }

    // 0x74/0x76 SCAMP/VLSI indexed register pair.
    void scamp_write(u8 index, u8 value)  { io_.out8(port::SCAMP_IDX,index); io_.out8(port::SCAMP_DATA,value); }
    u8   scamp_read (u8 index)            { io_.out8(port::SCAMP_IDX,index); return io_.in8(port::SCAMP_DATA); }

    // ---- Observed POST programming (recovered from the BIOS) ----------------
    // The 0x4F config-latch indices the PC110 BIOS writes during POST, with the
    // multiplicity seen in the reachable code.  Treat this as the set of
    // VL82C420 config fields the PC110 actually uses; exact semantics TBD.
    void post_program_observed() {
        static constexpr u8 cfg4f_indices[] = {
            0x11, 0x66, 0x70, 0x0A, 0x1E, 0xB6, 0x8F, 0x65, 0xBF, 0xFF
        };
        for (u8 idx : cfg4f_indices) cfg_latch(idx);

        // 0x22/0x23 unlock + 0x8B config bytes observed at POST:
        cfg_write(0x80, 0x80);                 // OUT 0x22,80 / OUT 0x23,80
        io_.out8(port::VL_8B, 0x6F);
        io_.out8(port::VL_8B, 0x0A);
        io_.out8(port::VL_8B, 0x80);
        io_.out8(port::VL_8B, 0x70);
        io_.out8(port::VL_8B, 0x71);
        io_.out8(port::VL_98, 0xBF);
        io_.out8(port::VL_F1, 0x65);
        scamp_read(0x80);                      // OUT 0x74,80 ; IN 0x76
    }
private:
    IoBus& io_;
};

// ===========================================================================
// 8259 PIC, 8254 PIT, KBC, RTC convenience wrappers (integrated cores).
// ===========================================================================
class Chipset {
public:
    explicit Chipset(IoBus& io) : io_(io), vl_(io) {}

    void pic_init() {                              // ICW1..ICW4, master+slave
        io_.out8(port::PIC1,0x11);  io_.out8(port::PIC2,0x11);
        io_.out8(port::PIC1_MASK,0x08); io_.out8(port::PIC2_MASK,0x70); // vector bases
        io_.out8(port::PIC1_MASK,0x04); io_.out8(port::PIC2_MASK,0x02); // cascade
        io_.out8(port::PIC1_MASK,0x01); io_.out8(port::PIC2_MASK,0x01); // 8086 mode
        io_.out8(port::PIC1_MASK,0xFF); io_.out8(port::PIC2_MASK,0xFF); // mask all (POST)
    }
    void pit_init() {                              // timer0 = system tick
        io_.out8(port::PIT_CTL,0x36);
        io_.out8(port::PIT0,0x00); io_.out8(port::PIT0,0x00);
    }
    u8   cmos_read (u8 idx){ io_.out8(port::RTC_INDEX, idx); return io_.in8(port::RTC_DATA); }
    void cmos_write(u8 idx,u8 v){ io_.out8(port::RTC_INDEX, idx); io_.out8(port::RTC_DATA, v); }

    void enable_a20() { u8 v=io_.in8(port::A20_SYSCTL); io_.out8(port::A20_SYSCTL,(u8)(v|0x02)); }

    VL82C420& vl() { return vl_; }
private:
    IoBus& io_; VL82C420 vl_;
};

// ===========================================================================
// POST / reset flow.  Mirrors the staged structure the disassembly recovers
// from the reset entry at F000:E05B (sub_E05B) onward.  Each stage maps to one
// or more sub_XXXX routines in pc110_bios_F000.asm.
// ===========================================================================
class Bios {
public:
    explicit Bios(IoBus& io) : io_(io), cs_(io) {}

    // F000:FFF0 reset -> JMP F000:E05B
    [[noreturn]] void reset_vector() {
        post();
        boot();
        for(;;) {}                 // INT 19h never returns in this model
    }

private:
    void post() {
        // --- early CPU/chipset bring-up (sub_E05B region) ---
        // CLI; set up segments; disable NMI; checkpoint to POST card 0x80
        checkpoint(0x01);
        cs_.vl().post_program_observed();   // VL82C420 config (recovered sequence)

        checkpoint(0x02);
        cs_.pic_init();                     // 82C59 pair
        cs_.pit_init();                     // 82C54 timer0

        checkpoint(0x03);
        cs_.enable_a20();                   // PS/2 sysctrl port A
        memory_sizing();                    // DRAM controller + size walk

        checkpoint(0x04);
        kbc_selftest();                     // 8042-class controller
        rtc_validate();                     // 146818: check Reg D / battery

        checkpoint(0x05);
        video_init();                       // hand to Chips 65535 VGA BIOS (INT 10h)
        checkpoint(0x06);
        install_ivt();                      // point INT 10/13/15/16/19/1A at handlers
    }

    void boot() {
        // INT 19h bootstrap (sub for F000 boot path) -> load boot sector / ROM DOS
        service_int19();
    }

    // ---- POST sub-stages (each ~ one or more sub_XXXX in the .asm) ----------
    void memory_sizing() { /* walk DRAM via VL82C420 RAS/CAS config + sizing reads */ }
    void kbc_selftest()  { io_.out8(port::KBC_CMD,0xAA); (void)io_.in8(port::KBC_DATA); }
    void rtc_validate()  { (void)cs_.cmos_read(cmos::REG_D); }
    void video_init()    { /* far-call C000:0003 (VGA option ROM init) */ }
    void install_ivt()   { /* fill 0000:0000.. with handler far pointers */ }

    void checkpoint(u8 code){ io_.out8(port::POST_CARD, code); }

    // ---- BIOS service entry points (installed in the IVT) -------------------
public:
    void service_int10(u8 ah);   // video
    void service_int13(u8 ah);   // disk
    void service_int15(u8 ah);   // misc + APM (1.00.27)
    void service_int16(u8 ah);   // keyboard
    void service_int19();        // bootstrap
    void service_int1A(u8 ah);   // RTC/time

private:
    IoBus& io_;
    Chipset cs_;
};

// Minimal service-routine stubs (dispatch shape matches the BIOS jump tables).
void Bios::service_int10(u8 ah){ (void)ah; /* -> Chips 65535 VGA BIOS */ }
void Bios::service_int13(u8 ah){ (void)ah; /* PCMCIA-ATA / floppy path */ }
void Bios::service_int15(u8 ah){
    switch(ah){
        case 0x53: /* APM BIOS 1.00.27 */ break;
        case 0x88: /* extended memory size */ break;
        default: break;
    }
}
void Bios::service_int16(u8 ah){ (void)ah; /* KBC via 0x60/0x64 */ }
void Bios::service_int19(){ /* load bootstrap */ }
void Bios::service_int1A(u8 ah){ (void)ah; /* 146818 RTC */ }

} // namespace pc110

// ===========================================================================
// Demo IoBus so the scaffold compiles and "runs" standalone. Swap for the
// PC110-EMU core or real hardware.
// ===========================================================================
namespace {
struct TraceBus : pc110::IoBus {
    pc110::u8 in8(pc110::u16 p) override { std::printf("  IN  %04X\n", p); return 0xFF; }
    void out8(pc110::u16 p, pc110::u8 v) override { std::printf("  OUT %04X <- %02X\n", p, v); }
};
}

int main() {
    std::printf("PC110 BIOS reconstruction scaffold — POST trace:\n");
    TraceBus bus;
    pc110::Bios bios(bus);
    // We don't call reset_vector() (it loops forever); drive POST visibly instead:
    // (reset_vector -> post() -> boot()); here we just show the chipset program.
    pc110::Chipset cs(bus);
    cs.vl().post_program_observed();
    cs.pic_init();
    cs.pit_init();
    cs.enable_a20();
    std::printf("done.\n");
    return 0;
}
