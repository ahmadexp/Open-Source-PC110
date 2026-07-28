/* keys.h - inject keystrokes into the BIOS keyboard buffer (40:1E ring). */
#ifndef KEYS_H
#define KEYS_H
#include "types.h"

/* Queue npairs of [scancode,ascii] bytes for injection.  Returns how many
   pairs were accepted (limited by our deferred-queue capacity). */
unsigned keys_inject( const uint8_t *pairs, unsigned npairs );

/* Push as many queued keys into the BIOS buffer as currently fit.  Called
   each pump as the foreground program drains the buffer via INT 16h. */
void keys_pump( void );

/* Number of keys still waiting in our deferred queue. */
unsigned keys_pending( void );

/* Inject n raw make/break scancodes through the 8042 controller (a real INT 9
   per byte) -- reaches programs that bypass the BIOS buffer. Returns n. */
unsigned keys_raw_inject( const uint8_t *codes, unsigned n );

#endif
