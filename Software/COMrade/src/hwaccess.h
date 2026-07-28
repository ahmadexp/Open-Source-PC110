/* hwaccess.h - direct memory-space and I/O-space access for the resident agent.

   These are pure CPU operations (real-mode far-pointer load/store, IN/OUT) that
   never touch DOS, so they run immediately in the dispatch -- no DOS-safe window
   needed.  Powerful and unguarded by design (a hardware bring-up/debug tool):
   writing memory or ports can alter device state or crash the box. */
#ifndef HWACCESS_H
#define HWACCESS_H
#include "types.h"

/* Read/write `len` bytes at the 20-bit linear address `addr` (0..0xFFFFF).
   Addressed via a normalised far pointer; len is bounded to one chunk by the
   bridge so the segment offset never wraps. */
void mem_read( uint32_t addr, unsigned len, uint8_t *out );
void mem_write( uint32_t addr, unsigned len, const uint8_t *data );

/* IN/OUT on an I/O port.  width is 1 (byte) or 2 (word); other widths are
   rejected by the caller. */
uint32_t io_in( unsigned port, unsigned width );
void     io_out( unsigned port, unsigned width, uint32_t value );

/* Tight-loop bus stimulus for RE / logic-analyzer work: repeat one bus cycle
   `count` times back-to-back in a CPU loop, so one serial round-trip generates a
   dense burst of identical cycles that dominates the bus (the ~130 ops/s serial
   rate otherwise buries driven cycles under the CPU's millions/s).

   `max_ticks` bounds wall-clock: if non-zero, the loop stops once the BIOS tick
   counter (0040:006C, ~55 ms/tick) advances by that many ticks -- a runaway
   guard so a huge `count` cannot pin the box indefinitely (the loop otherwise
   runs to completion on the DOS side and outlives a host-side cancel). The loop
   writes `*iters_done` with the number of cycles actually executed and returns
   the last value read (reads) or the value written (writes). `volatile` so the
   accesses are emitted, not optimised away. Interrupts stay enabled (serial RX
   ISR keeps working); the agent just doesn't service the next request until the
   burst finishes. Write bursts are gated by the caller's deny-list. */
uint32_t io_in_burst( unsigned port, unsigned width, uint32_t count,
                      uint16_t max_ticks, uint32_t *iters_done );
uint32_t mem_read_burst( uint32_t addr, unsigned width, uint32_t count,
                         uint16_t max_ticks, uint32_t *iters_done );
uint32_t io_out_burst( unsigned port, unsigned width, uint32_t value,
                       uint32_t count, uint16_t max_ticks, uint32_t *iters_done );
uint32_t mem_write_burst( uint32_t addr, unsigned width, uint32_t value,
                          uint32_t count, uint16_t max_ticks, uint32_t *iters_done );

#endif
