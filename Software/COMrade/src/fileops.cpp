/*
   fileops.cpp - out-of-band file I/O, run only in a DOS-safe window.

   DOS (INT 21h) is not reentrant, so the resident calls these only in a DOS-safe
   window: inline when InDOS==0, otherwise deferred to the INT 28h idle hook (see
   file_safe_now / defer_file in resident.cpp).  NOTE: that gate checks the InDOS
   flag only -- it does NOT check the DOS critical-error flag (a known gap).
   Around every operation we swap the current PSP to our own so the file handles
   we open use OUR job file table and never collide with the foreground program's
   open handles, then restore the caller's PSP.

   Each request is already bounded to one chunk by the bridge, so a single
   open/seek/read-or-write/close keeps the safe window brief.
*/

#include <dos.h>           /* _dos_open, _dos_creat, _dos_read, _dos_write, _dos_close */
#include "fileops.h"
#include "proto.h"
#include "dossafe.h"

#define SEEK_BEG  0
#define SEEK_END  2

/* INT 21h AH=42h LSEEK -> 32-bit position in DX:AX (here ax=low, dx=high). */
extern uint32_t dosSeek( unsigned handle, unsigned char whence, uint32_t offset );
#pragma aux dosSeek =        \
  "mov ah,0x42"              \
  "int 0x21"                 \
  "jnc seekok"               \
  "xor ax,ax"                \
  "cwd"                      \
  "seekok:"                  \
  parm [bx] [al] [dx cx]     \
  modify [ax cx dx]          \
  value [ax dx];

static unsigned g_ourPsp = 0;

void fileops_set_psp( unsigned psp ) { g_ourPsp = psp; }

static uint8_t map_err( unsigned dos_err ) {
  /* DOS error 2 = file not found, 3 = path not found, 5 = access denied. */
  if ( dos_err == 2 || dos_err == 3 ) return ST_NOT_FOUND;
  if ( dos_err == 5 ) return ST_ACCESS;
  return ST_OTHER;
}

unsigned fileops_read( const char *path, uint32_t offset, unsigned maxlen,
                       uint8_t *out, uint32_t *total, uint8_t *status )
{
  unsigned callerPsp = getCurrentPSP( );
  int      handle;
  unsigned rc, done = 0;

  *total = 0;
  if ( g_ourPsp ) setCurrentPSP( g_ourPsp );

  rc = _dos_open( path, 0 /* read */, &handle );
  if ( rc != 0 ) {
    *status = map_err( rc );
    if ( g_ourPsp ) setCurrentPSP( callerPsp );
    return 0;
  }

  *total = dosSeek( handle, SEEK_END, 0 );      /* file size */
  dosSeek( handle, SEEK_BEG, offset );          /* back to requested offset */

  if ( offset >= *total ) {
    *status = ST_OK;                            /* at/after EOF -> 0 bytes */
  } else {
    rc = _dos_read( handle, out, maxlen, &done );
    *status = ( rc == 0 ) ? ST_OK : map_err( rc );
  }

  _dos_close( handle );
  if ( g_ourPsp ) setCurrentPSP( callerPsp );
  return done;
}

/* Get/set the DOS attribute byte.  No handle and no DTA -- just a path -- so (like
   the directory listing) we don't swap the PSP: relative paths then resolve in
   the foreground's current drive/dir.  Settable bits only on a set. */
void fileops_attr( const char *path, int doSet, uint8_t newAttr,
                   uint8_t *outAttr, uint8_t *status )
{
  unsigned attr = 0, rc;
  *outAttr = 0;
  if ( doSet ) {
    rc = _dos_setfileattr( path,
           (unsigned)( newAttr & ( _A_RDONLY | _A_HIDDEN | _A_SYSTEM | _A_ARCH ) ) );
    if ( rc != 0 ) { *status = map_err( rc ); return; }
  }
  rc = _dos_getfileattr( path, &attr );
  if ( rc != 0 ) { *status = map_err( rc ); return; }
  *outAttr = (uint8_t)attr;
  *status = ST_OK;
}

unsigned fileops_write( const char *path, uint8_t flags, uint32_t offset,
                        const uint8_t *data, unsigned len, uint8_t *status )
{
  unsigned callerPsp = getCurrentPSP( );
  int      handle;
  unsigned rc, done = 0;

  if ( g_ourPsp ) setCurrentPSP( g_ourPsp );

  if ( flags & WF_TRUNC ) {
    rc = _dos_creat( path, 0 /* _A_NORMAL */, &handle );
  } else {
    rc = _dos_open( path, 2 /* read/write */, &handle );
    if ( rc != 0 ) {                            /* not there yet -> create it */
      rc = _dos_creat( path, 0, &handle );
    }
  }
  if ( rc != 0 ) {
    *status = map_err( rc );
    if ( g_ourPsp ) setCurrentPSP( callerPsp );
    return 0;
  }

  if ( flags & WF_APPEND ) {
    dosSeek( handle, SEEK_END, 0 );
  } else {
    dosSeek( handle, SEEK_BEG, offset );
  }

  if ( len > 0 ) {
    rc = _dos_write( handle, (void *)data, len, &done );
    *status = ( rc == 0 ) ? ST_OK : map_err( rc );
  } else {
    *status = ST_OK;                            /* empty write = create/truncate */
  }

  _dos_close( handle );
  if ( g_ourPsp ) setCurrentPSP( callerPsp );
  return done;
}

/* CRC-32 (IEEE/zlib: reflected poly 0xEDB88320, init 0xFFFFFFFF, final XOR
   0xFFFFFFFF) via a 16-entry nibble table -- small + fast.  Matches Python
   zlib.crc32().  Used to verify a whole-file transfer end-to-end. */
static const uint32_t crc32_tab[16] = {
  0x00000000UL, 0x1DB71064UL, 0x3B6E20C8UL, 0x26D930ACUL,
  0x76DC4190UL, 0x6B6B51F4UL, 0x4DB26158UL, 0x5005713CUL,
  0xEDB88320UL, 0xF00F9344UL, 0xD6D6A3E8UL, 0xCB61B38CUL,
  0x9B64C2B0UL, 0x86D3D2D4UL, 0xA00AE278UL, 0xBDBDF21CUL
};

#define HASH_BUF 1024u
static uint8_t hashbuf[ HASH_BUF ];

/* CRC-32 + byte length of an ENTIRE file, read in chunks in the DOS-safe window
   (PSP swapped like the other ops).  Returns 1 on success, 0 on error. */
unsigned fileops_crc32( const char *path, uint32_t *out_crc, uint32_t *out_len,
                        uint8_t *status )
{
  unsigned callerPsp = getCurrentPSP( );
  int      handle;
  unsigned rc, done, k;
  uint32_t crc = 0xFFFFFFFFUL, total = 0;

  *out_crc = 0;
  *out_len = 0;
  if ( g_ourPsp ) setCurrentPSP( g_ourPsp );

  rc = _dos_open( path, 0 /* read */, &handle );
  if ( rc != 0 ) {
    *status = map_err( rc );
    if ( g_ourPsp ) setCurrentPSP( callerPsp );
    return 0;
  }
  do {
    rc = _dos_read( handle, hashbuf, HASH_BUF, &done );
    if ( rc != 0 ) {
      *status = map_err( rc );
      _dos_close( handle );
      if ( g_ourPsp ) setCurrentPSP( callerPsp );
      return 0;
    }
    for ( k = 0; k < done; k++ ) {
      crc ^= hashbuf[k];
      crc = ( crc >> 4 ) ^ crc32_tab[ crc & 0x0F ];
      crc = ( crc >> 4 ) ^ crc32_tab[ crc & 0x0F ];
    }
    total += done;
  } while ( done == HASH_BUF );          /* short read => EOF */

  _dos_close( handle );
  if ( g_ourPsp ) setCurrentPSP( callerPsp );
  *out_crc = crc ^ 0xFFFFFFFFUL;
  *out_len = total;
  *status  = ST_OK;
  return 1;
}
