/*
   dirlist.cpp - out-of-band directory listing (INT 21h find-first/find-next).

   Like the file read/write path, this is real DOS I/O done from the resident
   agent, so the caller only invokes it in a DOS-safe window (InDOS==0 or the
   INT 28h idle hook).  find-first/next deliver results through the DTA, so we
   save the foreground's DTA, point it at our own find_t, enumerate, and restore
   it -- the foreground's own find state is never disturbed.  (No PSP swap: these
   calls allocate no handles, and using the foreground PSP means relative paths
   resolve against the box's current drive/directory, which is what you want.)
*/

#include <dos.h>           /* _dos_findfirst, _dos_findnext, struct find_t */
#include <string.h>
#include "dirlist.h"
#include "dossafe.h"

unsigned dir_list( const char *pat, unsigned start, uint8_t *out, unsigned cap,
                   unsigned *count, uint8_t *more )
{
  struct find_t fb;
  void far *oldDta = getDtaPtr( );
  unsigned di = 0, n = 0, i;
  unsigned rc;

  *more = 0;
  rc = _dos_findfirst( pat, _A_HIDDEN | _A_SYSTEM | _A_SUBDIR, &fb );
  for ( i = 0; rc == 0 && i < start; i++ ) rc = _dos_findnext( &fb );

  while ( rc == 0 ) {
    unsigned nl = (unsigned)strlen( fb.name );
    if ( di + 10 + nl > cap ) { *more = 1; break; }   /* 10 header bytes + name */
    out[ di++ ] = (uint8_t)fb.attrib;
    out[ di++ ] = (uint8_t)( fb.wr_time & 0xFF );
    out[ di++ ] = (uint8_t)( fb.wr_time >> 8 );
    out[ di++ ] = (uint8_t)( fb.wr_date & 0xFF );
    out[ di++ ] = (uint8_t)( fb.wr_date >> 8 );
    out[ di++ ] = (uint8_t)( fb.size & 0xFF );
    out[ di++ ] = (uint8_t)( ( fb.size >> 8 ) & 0xFF );
    out[ di++ ] = (uint8_t)( ( fb.size >> 16 ) & 0xFF );
    out[ di++ ] = (uint8_t)( ( fb.size >> 24 ) & 0xFF );
    out[ di++ ] = (uint8_t)nl;
    memcpy( out + di, fb.name, nl ); di += nl;
    n++;
    rc = _dos_findnext( &fb );
  }

  setDtaPtr( FP_SEG( oldDta ), FP_OFF( oldDta ) );
  *count = n;
  return di;
}
