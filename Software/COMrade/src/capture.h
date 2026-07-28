/* capture.h - INT 29h console-output stream capture into a scrollback ring. */
#ifndef CAPTURE_H
#define CAPTURE_H
#include "types.h"

void     capture_install( void );      /* hook INT 29h */
void     capture_uninstall( void );    /* restore INT 29h */
uint32_t capture_head( void );         /* total bytes captured so far */

/* Copy bytes [since .. min(since+maxlen, head)) into out.  Sets *base to the
   seq of the first byte returned, *next to the seq just past the last, and
   *overflow=1 if `since` had already scrolled out of the ring (data lost).
   Returns the number of bytes copied. */
unsigned capture_read( uint32_t since, unsigned maxlen, uint8_t *out,
                       uint32_t *base, uint32_t *next, uint8_t *overflow );

#endif
