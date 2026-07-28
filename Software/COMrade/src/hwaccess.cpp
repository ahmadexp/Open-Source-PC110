/*
   hwaccess.cpp - direct memory-space and I/O-space access.

   memory: a 20-bit linear address is split into a normalised far pointer
   MK_FP(addr>>4, addr&0x0F) so the offset is always 0..15; since the bridge
   bounds each request to one chunk (<= ~1 KB), offset+len never wraps the 64 KB
   segment, so a contiguous physical range reads/writes correctly.  Covers the
   whole real-mode space (IVT, BIOS data area, video B000/B800/A000, option/BIOS
   ROMs C000-F000, RAM/UMBs).  Extended memory (>1 MB) is not reachable from real
   mode and is out of scope.

   I/O: byte (inp/outp) and word (inpw/outpw) -- the ISA widths.  32-bit port I/O
   (inpd/outpd) needs a 386+ build and has no use on a 16-bit ISA bus, so it is
   not supported.
*/

#include <conio.h>          /* inp, inpw, outp, outpw */
#include <i86.h>            /* MK_FP */
#include "hwaccess.h"

static uint8_t far *farptr( uint32_t addr )
{
  return (uint8_t far *)MK_FP( (unsigned)( addr >> 4 ), (unsigned)( addr & 0x0F ) );
}

void mem_read( uint32_t addr, unsigned len, uint8_t *out )
{
  uint8_t far *p = farptr( addr );
  unsigned i;
  for ( i = 0; i < len; i++ ) out[i] = p[i];
}

void mem_write( uint32_t addr, unsigned len, const uint8_t *data )
{
  uint8_t far *p = farptr( addr );
  unsigned i;
  for ( i = 0; i < len; i++ ) p[i] = data[i];
}

uint32_t io_in( unsigned port, unsigned width )
{
  if ( width == 2 ) return (uint32_t)inpw( port );
  return (uint32_t)inp( port );                  /* width 1 */
}

void io_out( unsigned port, unsigned width, uint32_t value )
{
  if ( width == 2 ) outpw( port, (unsigned)( value & 0xFFFFu ) );
  else outp( port, (int)( value & 0xFFu ) );     /* width 1 */
}

/* BIOS timer tick counter at 0040:006C (increments ~18.2 Hz, ~55 ms/tick).
   Read as a 32-bit word for the wall-clock cap. */
static uint32_t bios_ticks( void )
{
  volatile uint32_t far *t = (volatile uint32_t far *)MK_FP( 0x0040, 0x006C );
  return *t;
}

/* How often (in loop iterations) to poll the tick counter. Reading the BDA every
   iteration would add a memory cycle to each stimulus cycle and blur the burst;
   checking every 4096 keeps the loop tight while still bounding wall-clock to
   ~4096 cycles of overrun past the deadline. */
#define TICK_POLL_MASK  0x0FFFu

/* Tight bursts for RE/LA stimulus. inp/inpw/outp/outpw have real I/O side
   effects (never elided); mem accesses go through a volatile far pointer so each
   load/store is emitted. `max_ticks`==0 disables the wall-clock cap. */
uint32_t io_in_burst( unsigned port, unsigned width, uint32_t count,
                      uint16_t max_ticks, uint32_t *iters_done )
{
  volatile uint32_t v = 0;
  uint32_t i, t0 = bios_ticks( );
  for ( i = 0; i < count; i++ ) {
    v = ( width == 2 ) ? (uint32_t)inpw( port ) : (uint32_t)inp( port );
    if ( max_ticks && !( i & TICK_POLL_MASK ) && ( bios_ticks( ) - t0 ) >= max_ticks ) { i++; break; }
  }
  if ( iters_done ) *iters_done = i;
  return (uint32_t)v;
}

uint32_t mem_read_burst( uint32_t addr, unsigned width, uint32_t count,
                         uint16_t max_ticks, uint32_t *iters_done )
{
  volatile uint8_t  far *pb = farptr( addr );
  volatile uint16_t far *pw = (volatile uint16_t far *)pb;
  volatile uint32_t v = 0;
  uint32_t i, t0 = bios_ticks( );
  for ( i = 0; i < count; i++ ) {
    v = ( width == 2 ) ? (uint32_t)( *pw ) : (uint32_t)( *pb );
    if ( max_ticks && !( i & TICK_POLL_MASK ) && ( bios_ticks( ) - t0 ) >= max_ticks ) { i++; break; }
  }
  if ( iters_done ) *iters_done = i;
  return (uint32_t)v;
}

uint32_t io_out_burst( unsigned port, unsigned width, uint32_t value,
                       uint32_t count, uint16_t max_ticks, uint32_t *iters_done )
{
  uint32_t i, t0 = bios_ticks( );
  for ( i = 0; i < count; i++ ) {
    if ( width == 2 ) outpw( port, (unsigned)( value & 0xFFFFu ) );
    else              outp( port, (int)( value & 0xFFu ) );
    if ( max_ticks && !( i & TICK_POLL_MASK ) && ( bios_ticks( ) - t0 ) >= max_ticks ) { i++; break; }
  }
  if ( iters_done ) *iters_done = i;
  return value;
}

uint32_t mem_write_burst( uint32_t addr, unsigned width, uint32_t value,
                          uint32_t count, uint16_t max_ticks, uint32_t *iters_done )
{
  volatile uint8_t  far *pb = farptr( addr );
  volatile uint16_t far *pw = (volatile uint16_t far *)pb;
  uint32_t i, t0 = bios_ticks( );
  for ( i = 0; i < count; i++ ) {
    if ( width == 2 ) *pw = (uint16_t)( value & 0xFFFFu );
    else              *pb = (uint8_t)( value & 0xFFu );
    if ( max_ticks && !( i & TICK_POLL_MASK ) && ( bios_ticks( ) - t0 ) >= max_ticks ) { i++; break; }
  }
  if ( iters_done ) *iters_done = i;
  return value;
}
