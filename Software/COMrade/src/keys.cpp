/*
   keys.cpp - inject keystrokes into the BIOS type-ahead buffer.

   The 16-word circular buffer lives at 0040:001E..0040:003D, with the head
   pointer at 0040:001A and the tail at 0040:001C (both offsets relative to
   segment 0x40).  Writing a (scancode<<8 | ascii) word at the tail and
   advancing it makes the foreground program read it via INT 16h as if typed.

   The buffer only holds 15 keys, so anything that does not fit is parked in a
   local deferred queue and drained by keys_pump() as the foreground consumes.
   All buffer-pointer manipulation is done with interrupts disabled.

   CALL-SITE DISCIPLINE (load-bearing -- this is the injected-long-command crash
   fix): keys_pump() pokes the BIOS head/tail, which races COMMAND.COM's own
   INT 16h read of the same pointers.  Drain deferred keys ONLY from the INT 28h
   idle hook (DOS idle = foreground not mid-read), NEVER from the serial / TX-
   complete ISR.  Calling it from the serial ISR while the shell read the buffer
   corrupted the pointers -> jump-to-~null #UD.  The one keys_pump() inside
   keys_inject() below is safe because it runs as KEYS_SEND is dispatched, before
   the shell starts reading this command's keys.
*/

#include <dos.h>           /* _disable / _enable */
#include <conio.h>         /* inp / outp */
#include "keys.h"
#include "dossafe.h"

#define KB_SEG    0x40
#define KB_HEAD   0x1A
#define KB_TAIL   0x1C
#define KB_START  0x1E
#define KB_END    0x3E     /* one past the last word slot */

#define KBC_DATA  0x60     /* 8042 data port      */
#define KBC_CMD   0x64     /* 8042 command/status */

#define DEFER_CAP 128      /* deferred key words */
static uint16_t deferBuf[ DEFER_CAP ];
static unsigned deferHead = 0, deferTail = 0;   /* circular indices */

static unsigned defer_count( void ) {
  return ( deferTail - deferHead ) & (DEFER_CAP - 1);
}

static int defer_push( uint16_t w ) {
  unsigned next = ( deferTail + 1 ) & (DEFER_CAP - 1);
  if ( next == deferHead ) return 0;            /* full */
  deferBuf[ deferTail ] = w;
  deferTail = next;
  return 1;
}

/* Try to place one word into the BIOS buffer.  Returns 1 on success, 0 full. */
static int kb_put( uint16_t w ) {
  unsigned head, tail, next;
  int ok = 0;
  _disable();
  head = PEEKW( KB_SEG, KB_HEAD );
  tail = PEEKW( KB_SEG, KB_TAIL );
  next = tail + 2;
  if ( next >= KB_END ) next = KB_START;
  if ( next != head ) {                         /* not full */
    POKEW( KB_SEG, tail, w );
    POKEW( KB_SEG, KB_TAIL, next );
    ok = 1;
  }
  _enable();
  return ok;
}

void keys_pump( void ) {
  while ( deferHead != deferTail ) {
    if ( !kb_put( deferBuf[ deferHead ] ) ) break;   /* BIOS buffer full */
    deferHead = ( deferHead + 1 ) & (DEFER_CAP - 1);
  }
}

unsigned keys_inject( const uint8_t *pairs, unsigned npairs ) {
  unsigned accepted = 0;
  unsigned i;
  for ( i = 0; i < npairs; i++ ) {
    uint16_t w = (uint16_t)( ( (uint16_t)pairs[2*i] << 8 ) | pairs[2*i + 1] );
    if ( !defer_push( w ) ) break;              /* deferred queue full */
    accepted++;
  }
  keys_pump( );                                 /* place what fits right now */
  return accepted;
}

unsigned keys_pending( void ) {
  return defer_count( );
}

/* Wait until the 8042 input AND output buffers are both empty (status bits 1,0),
   so we can write a command and the previous injected scancode has been consumed
   by INT 9.  Bounded so a wedged/absent controller can't hang us. */
static void kbc_ready( void ) {
  unsigned t = 0xFFFFu;
  while ( ( inp( KBC_CMD ) & 0x03 ) && --t ) ;
}

/* Hardware-level keystrokes: feed raw make/break scancodes to the keyboard
   controller (command 0xD2 = "write to the kbd output buffer"), so each byte
   raises a real IRQ1/INT 9 and looks identical to a physical keypress -- it
   reaches programs that hook INT 9 and read port 0x60 directly (games, full-
   screen editors), which the BIOS type-ahead buffer cannot.  The host composes
   the scancode stream (make codes, 0xE0 prefixes for the grey keys, break =
   make|0x80, shift wrapping for capitals/symbols). */
unsigned keys_raw_inject( const uint8_t *codes, unsigned n ) {
  unsigned i;
  for ( i = 0; i < n; i++ ) {
    kbc_ready( );
    outp( KBC_CMD, 0xD2 );        /* next data byte -> appears as a keystroke */
    kbc_ready( );
    outp( KBC_DATA, codes[i] );
  }
  return n;
}
