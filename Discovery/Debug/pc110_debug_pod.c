/* pc110_debug_pod.c — minimal 486 run-control debug pod for the PC110
 * J9/J12 headers (HOLD-method). Target: any 3.3V MCU (RP2040 recommended);
 * GPIO is abstracted below — fill in pin_* for your board. NOT timing-critical
 * for run-control (HOLD/FLUSH/SRESET/NMI); for real bus mastering use an FPGA.
 *
 * Level note: the 486 side may be 5V. Put proper level translation between the
 * MCU and the J9/J12 pins (the on-board 74LVT125 buffers are 3.3V/5V-tolerant,
 * but don't rely on that for your own wiring).
 *
 * Signal directions (CPU's perspective; pod drives CPU inputs, senses outputs):
 *   DRIVE : HOLD, AHOLD, BRDY#, FLUSH#, EADS#, KEN#, SRESET, NMI, A20M#
 *   SENSE : HLDA, BLAST#, BE0-3#, A31 (+ A[2..31] if wired)
 */
#include <stdint.h>
#include <stdbool.h>

/* ---- GPIO abstraction: implement these for your MCU ---------------------- */
typedef enum {                  /* logical pins -> header pins */
    /* J9 "Debug-10" */
    P_HOLD, P_BRDY_N, P_BE1_N, P_HLDA, P_BE3_N, P_BE0_N,
    P_A20M_N, P_BE2_N, P_SRESET, P_NMI,
    /* J12 "Debug-6" */
    P_BLAST_N, P_FLUSH_N, P_KEN_N, P_EADS_N, P_AHOLD, P_A31,
    PIN_COUNT
} pin_t;

extern void    gpio_drive(pin_t p, bool level); /* set output level (active drive) */
extern void    gpio_float(pin_t p);             /* tri-state (release) */
extern bool    gpio_read (pin_t p);             /* sample input level */
extern void    delay_clks(uint32_t cpu_clks);   /* ~busy-wait N CPU clocks */

/* active-low helpers */
static inline void assert_l(pin_t p){ gpio_drive(p,false); }
static inline void deassert_l(pin_t p){ gpio_drive(p,true); }
static inline void assert_h(pin_t p){ gpio_drive(p,true); }
static inline void deassert_h(pin_t p){ gpio_drive(p,false); }

/* ---- pod state ----------------------------------------------------------- */
void pod_init(void){
    /* park all CPU-input controls inactive */
    deassert_h(P_HOLD); deassert_h(P_AHOLD);
    deassert_l(P_BRDY_N); deassert_l(P_FLUSH_N); deassert_l(P_EADS_N);
    deassert_l(P_KEN_N);  deassert_l(P_SRESET);  /* SRESET active-high on 486: see note */
    deassert_l(P_NMI);    deassert_l(P_A20M_N);
}

/* 1. Halt: take the local bus (CPU floats bus, asserts HLDA) ---------------- */
bool pod_halt(uint32_t timeout_clks){
    assert_h(P_HOLD);
    while(timeout_clks--){ if(gpio_read(P_HLDA)) return true; delay_clks(1); }
    return false;                 /* CPU never acknowledged HOLD */
}
void pod_resume(void){
    deassert_h(P_HOLD);
    while(gpio_read(P_HLDA)) {}    /* wait until CPU reclaims the bus */
}

/* 2. Flush the entire on-chip cache (write-through 486: invalidate) --------- */
void pod_cache_flush(void){
    assert_l(P_FLUSH_N);
    delay_clks(4);                 /* hold a few clocks */
    deassert_l(P_FLUSH_N);
}

/* 3. Snoop-invalidate ONE cache line at 'phys_addr' (needs A[2..31] wired) -- */
extern void drive_addr(uint32_t addr);   /* drive CPU_A[2..31]; impl per board */
extern void float_addr(void);
void pod_invalidate_line(uint32_t phys_addr){
    assert_h(P_AHOLD);             /* float only the address bus */
    delay_clks(1);
    drive_addr(phys_addr);
    assert_l(P_EADS_N);            /* CPU samples addr, invalidates matching line */
    delay_clks(1);
    deassert_l(P_EADS_N);
    float_addr();
    deassert_h(P_AHOLD);
}

/* 4. Soft reset / restart (keeps SMM state; faster than full reset) --------- *
 * NOTE: on the i486, SRESET is ACTIVE-HIGH. Adjust polarity if your buffer
 * inverts. Pulse width must meet the CPU's reset spec (>= 15 CLK typical).    */
void pod_soft_reset(void){
    gpio_drive(P_SRESET,true);  delay_clks(20);  gpio_drive(P_SRESET,false);
}

/* 5. Inject NMI (active-high, edge) ----------------------------------------- */
void pod_nmi(void){
    gpio_drive(P_NMI,true);  delay_clks(4);  gpio_drive(P_NMI,false);
}

/* 6. A20 mask control (active-low input) ------------------------------------ */
void pod_a20_mask(bool mask_on){ gpio_drive(P_A20M_N, !mask_on); }

/* ---- example session ----------------------------------------------------- *
 * Typical bring-up use:
 *   pod_init();
 *   if (pod_halt(100000)) {            // freeze the 486
 *       // ... external hardware (FPGA / DRAM tap) reads or patches memory ...
 *       pod_cache_flush();             // keep cache coherent after writes
 *       pod_resume();                  // let the CPU continue
 *   }
 *   pod_nmi();                          // or force an NMI handler entry
 *   pod_soft_reset();                   // warm restart for a new test run
 *
 * For memory access itself, wire the data bus (tap at DRAM/ROM) or use the
 * JTAG TAP (TCK/TDI/TMS/TDO) with OpenOCD + the 486 BSDL for EXTEST/SAMPLE.
 */
