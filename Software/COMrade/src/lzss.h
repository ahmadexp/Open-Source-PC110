/* lzss.h - LZSS compressor for serial payloads (matches comrade decoder). */
#ifndef LZSS_H
#define LZSS_H
#include "types.h"

/* Compress src[0..slen) into dst (capacity dcap).  Returns the compressed
   length, or 0 if it did not fit within dcap (i.e. not worth it -- caller sends
   the payload raw).  Format: groups of [flag byte][up to 8 tokens]; flag bit
   (LSB first) 1=literal (1 byte), 0=match (2 bytes: d&0xFF, (d>>8<<4)|(len-3))
   with distance=d+1, length 3..18, window 4096. */
unsigned lzss_compress( const uint8_t *src, unsigned slen, uint8_t *dst, unsigned dcap );

#endif
