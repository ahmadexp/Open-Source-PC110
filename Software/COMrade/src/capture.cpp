/*
   capture.cpp - capture every character DOS writes to the console (INT 29h).

   DOS routes console output through INT 29h "Fast Console Output", one call per
   character with the char in AL -- this includes AH=02h/06h/09h AND block writes
   via AH=40h to stdout/CON (verified on MS-DOS 6.22).  We hook INT 29h with a
   MINIMAL assembly stub (isr.asm) that appends AL to a circular scrollback ring
   and then TAIL-CHAINS to the original handler for native-speed display.

   The stub is deliberately tiny: no private-stack switch, no per-char BIOS
   teletype of our own.  An earlier version did the display itself (INT 10h
   teletype + scroll on a private stack) which was far too heavy per character --
   a big `type` (15 KB, 15000 INT 29h calls) starved the serial channel.  By
   capturing one byte and letting the ORIGINAL handler display (exactly as it
   would natively, on DOS's own stack), large outputs stay fast and the bridge
   keeps getting serviced, while nothing is lost.
*/

#include <dos.h>
#include "capture.h"

#define RING_SZ    32768u          /* room for bursty compiler/type output between pulls */
#define RING_MASK  (RING_SZ - 1u)

typedef void ( __interrupt __far *INTVEC )( );

/* ring + ringHead are __far so cap_ring_write() reaches them via baked-in
   segments, not DS -- the INT 29h stub runs with the caller's DS (large model
   does NOT keep DS=DGROUP), so a DS-relative access would hit the wrong byte. */
static uint8_t __far  ring[ RING_SZ ];
static volatile uint32_t __far ringHead = 0;    /* total bytes ever captured */
static INTVEC oldInt29 = 0;

/* From isr.asm. */
extern "C" void __far int29_stub( void );
extern "C" void cap_set_old29( unsigned seg, unsigned off );

/* Called by int29_stub (on DOS's stack) before it tail-chains to display. */
extern "C" void cap_ring_write( unsigned char c )
{
  ring[ (unsigned)( ringHead & RING_MASK ) ] = c;
  ringHead++;
}

void capture_install( void )
{
  oldInt29 = _dos_getvect( 0x29 );
  cap_set_old29( FP_SEG( (void __far *)oldInt29 ), FP_OFF( (void __far *)oldInt29 ) );
  _dos_setvect( 0x29, (INTVEC)int29_stub );
}

void capture_uninstall( void )
{
  if ( oldInt29 ) _dos_setvect( 0x29, oldInt29 );
}

uint32_t capture_head( void )
{
  return ringHead;
}

unsigned capture_read( uint32_t since, unsigned maxlen, uint8_t *out,
                       uint32_t *base, uint32_t *next, uint8_t *overflow )
{
  uint32_t head = ringHead;                      /* snapshot */
  uint32_t lo   = ( head > RING_SZ ) ? ( head - RING_SZ ) : 0;
  uint32_t start = since;
  uint32_t avail;
  unsigned n, i;
  uint8_t  ov = 0;

  if ( start > head ) start = head;              /* probe / future seq */
  if ( start < lo ) { start = lo; ov = 1; }      /* fell off the ring */

  avail = head - start;
  n = ( avail > (uint32_t)maxlen ) ? maxlen : (unsigned)avail;
  for ( i = 0; i < n; i++ ) {
    out[i] = ring[ (unsigned)( ( start + i ) & RING_MASK ) ];
  }

  *base = start;
  *next = start + n;
  *overflow = ov;
  return n;
}
