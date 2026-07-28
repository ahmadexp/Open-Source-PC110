/* screen.h - text-mode video snapshot (B800/B000). Pure memory; ISR-safe. */
#ifndef SCREEN_H
#define SCREEN_H
#include "types.h"

/* Build a SCREEN_DATA payload (header + char/attr cells) into out[cap].
   Returns the payload length, or 0 if it would not fit. */
unsigned screen_build( uint8_t *out, unsigned cap );

#endif
