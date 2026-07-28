/*
   screen.cpp - snapshot the text-mode screen straight from video memory.

   This is a pure memory read (no BIOS / DOS calls), so it is safe to run from
   any context including an interrupt handler.  It captures whatever is on the
   screen *right now*, including programs that paint directly to video memory
   (editors, TUIs) which never go through INT 21h/29h.  For scrolling output
   that would otherwise be lost, see capture.cpp (the INT 29h stream).
*/

#include "screen.h"
#include "dossafe.h"

#define BDA            0x0040
#define BDA_MODE       0x49     /* current video mode (byte)            */
#define BDA_COLS       0x4A     /* columns on screen (word)             */
#define BDA_PAGE_OFF   0x4E     /* offset of active page in video (word)*/
#define BDA_CUR_POS    0x50     /* cursor pos page 0: low=col high=row  */
#define BDA_ROWS       0x84     /* rows on screen minus 1 (EGA+; byte)  */

unsigned screen_build( uint8_t *out, unsigned cap )
{
  uint8_t  mode  = PEEKB( BDA, BDA_MODE );
  unsigned cols  = PEEKW( BDA, BDA_COLS );
  unsigned rows  = (unsigned)PEEKB( BDA, BDA_ROWS ) + 1;
  unsigned pgoff = PEEKW( BDA, BDA_PAGE_OFF );
  unsigned curpos = PEEKW( BDA, BDA_CUR_POS );
  unsigned vbase;
  unsigned cells, nbytes, i;
  uint16_t far *vid;
  uint8_t  *p;

  if ( cols == 0 || cols > 132 ) cols = 80;
  if ( rows == 0 || rows > 60  ) rows = 25;

  /* Mono text mode (7) lives at B000; everything else at B800. */
  vbase = ( mode == 7 ) ? 0xB000 : 0xB800;

  cells  = cols * rows;
  nbytes = 6 + cells * 2;
  if ( nbytes > cap ) return 0;

  out[0] = mode;
  out[1] = (uint8_t)cols;
  out[2] = (uint8_t)rows;
  out[3] = (uint8_t)( curpos & 0xFF );          /* cursor col */
  out[4] = (uint8_t)( ( curpos >> 8 ) & 0xFF ); /* cursor row */
  out[5] = 1;                                    /* cursor visible (assume on) */

  vid = (uint16_t far *)MK_FP( vbase, pgoff );
  p   = out + 6;
  for ( i = 0; i < cells; i++ ) {
    uint16_t cell = vid[i];                      /* low=char, high=attr */
    *p++ = (uint8_t)( cell & 0xFF );
    *p++ = (uint8_t)( cell >> 8 );
  }
  return nbytes;
}
