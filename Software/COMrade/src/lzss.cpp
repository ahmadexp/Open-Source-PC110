/*
   lzss.cpp - LZSS compressor for the serial output.

   The 115200-baud link (~11.5 KB/s) is the bottleneck; the DOS box captures far
   faster than it can ship bytes.  DOS console output is very repetitive (spaces,
   padding, table columns, repeated glyphs, the B800 [char][attr] pattern), so a
   small sliding-window LZ compresses it 5-8x -- multiplying effective
   throughput.  The decoder lives in comrade/protocol.py; this is the encoder.

   Match finding uses a 4096-entry hash of 3 bytes with per-position chains and a
   bounded chain depth, so it is O(input) -- trivially within a 486SX33's budget
   relative to the serial rate.  Greedy parse, 12-bit distance, 4-bit length.
*/

#include "lzss.h"

#define WIN       4096u           /* max match distance (12-bit offset)      */
#define MINM      3u              /* min match length                        */
#define MAXM      18u             /* max match length (4-bit field + MINM)   */
#define HSIZE     1024u           /* hash buckets (10-bit); smaller table, ~same ratio */
#define MAXCHAIN  16              /* candidates examined per position        */
#define MAXIN     4300u           /* largest payload we compress (one frame) */

static int g_head[ HSIZE ];       /* last position with a given 3-byte hash  */
static int g_prev[ MAXIN ];       /* chain: previous position with same hash */

static unsigned h3( const uint8_t *p )
{
  return ( ( (unsigned)p[0] << 8 ) ^ ( (unsigned)p[1] << 4 ) ^ (unsigned)p[2] ) & ( HSIZE - 1u );
}

unsigned lzss_compress( const uint8_t *src, unsigned slen, uint8_t *dst, unsigned dcap )
{
  unsigned di = 0, i = 0, k;

  if ( slen > MAXIN ) return 0;                  /* tables can't index it -> raw */
  for ( k = 0; k < HSIZE; k++ ) g_head[k] = -1;

  while ( i < slen ) {
    unsigned flagPos, flags = 0;
    int bit;

    if ( di >= dcap ) return 0;
    flagPos = di; dst[ di++ ] = 0;

    for ( bit = 0; bit < 8 && i < slen; bit++ ) {
      unsigned bestLen = 0, bestDist = 0;

      if ( i + MINM <= slen ) {
        int      cand  = g_head[ h3( src + i ) ];
        int      chain = MAXCHAIN;
        unsigned lo    = ( i > WIN ) ? ( i - WIN ) : 0;
        while ( cand >= 0 && (unsigned)cand >= lo && chain-- > 0 ) {
          if ( src[ cand + bestLen ] == src[ i + bestLen ] ) {   /* quick reject */
            unsigned l = 0;
            while ( l < MAXM && i + l < slen && src[ cand + l ] == src[ i + l ] ) l++;
            if ( l > bestLen ) {
              bestLen = l; bestDist = i - (unsigned)cand;
              if ( l == MAXM ) break;
            }
          }
          cand = g_prev[ cand ];
        }
      }

      if ( bestLen >= MINM ) {                    /* emit a match (flag bit 0) */
        unsigned d = bestDist - 1, e = i + bestLen;
        if ( di + 2 > dcap ) return 0;
        dst[ di++ ] = (uint8_t)( d & 0xFF );
        dst[ di++ ] = (uint8_t)( ( ( d >> 8 ) << 4 ) | ( bestLen - MINM ) );
        while ( i < e ) {                         /* index every covered position */
          if ( i + MINM <= slen ) {
            unsigned h = h3( src + i );
            g_prev[ i ] = g_head[ h ]; g_head[ h ] = (int)i;
          }
          i++;
        }
      } else {                                    /* emit a literal (flag bit 1) */
        if ( di + 1 > dcap ) return 0;
        flags |= ( 1u << bit );
        dst[ di++ ] = src[ i ];
        if ( i + MINM <= slen ) {
          unsigned h = h3( src + i );
          g_prev[ i ] = g_head[ h ]; g_head[ h ] = (int)i;
        }
        i++;
      }
    }
    dst[ flagPos ] = (uint8_t)flags;
  }
  return di;
}
