/*
   serial.cpp - interrupt-driven 16550 UART driver.

   This replaces the mTCP networking entirely.  A serial UART is hardware
   interrupt-driven and byte-oriented, so there is no cooperative polling to do
   and the ISR is tiny: on each interrupt we drain received bytes into an RX
   ring and push queued bytes from a TX ring into the transmit register.  This
   is safe to fire at any time, including during command execution, because it
   touches no DOS and no packet driver -- which is exactly what made mTCP-from-
   interrupt unworkable.

   After servicing the hardware we call serial_on_rx() (in resident.cpp) to turn
   complete frames into responses.  Heavy work (a screen snapshot) just fills
   the TX ring; the bytes leave gradually under the transmit interrupt.
*/

#include <dos.h>
#include <conio.h>
#include "serial.h"

#define RX_SZ  2048u
#define RX_MASK (RX_SZ - 1u)
#define TX_SZ  8192u
#define TX_MASK (TX_SZ - 1u)

static volatile uint8_t  rxbuf[ RX_SZ ];
static volatile unsigned rxHead = 0, rxTail = 0;   /* head=ISR writes, tail=consumer */
static volatile uint8_t  txbuf[ TX_SZ ];
static volatile unsigned txHead = 0, txTail = 0;   /* head=producer, tail=ISR writes */

static unsigned uartBase = 0x3F8;
static uint8_t  uartIrq  = 4;
static unsigned uartVec  = 0x0C;

typedef void ( __interrupt __far *INTVEC )( );
static INTVEC oldUartVec;

#define R_RBR (uartBase + 0)
#define R_THR (uartBase + 0)
#define R_IER (uartBase + 1)
#define R_DLL (uartBase + 0)
#define R_DLM (uartBase + 1)
#define R_FCR (uartBase + 2)
#define R_LCR (uartBase + 3)
#define R_MCR (uartBase + 4)
#define R_LSR (uartBase + 5)

#define IER_RX   0x01
#define IER_TX   0x02

/* Implemented in resident.cpp. */
extern void serial_on_rx( void );                /* process the RX ring */
extern void resident_idle( void );               /* drain a deferred file op */
extern volatile uint8_t g_pend_op;               /* nonzero: a file op is waiting */
extern void keys_pump( void );                   /* drain deferred keystrokes (keys.cpp) */

static INTVEC oldInt28 = 0;
static unsigned char idle_stack[ 3072 ];         /* private stack for the INT 28h stub */
static volatile uint8_t idle_busy = 0;

/* From isr.asm: the INT 28h stub switches to a private stack before any work
   (DOS issues INT 28h on a stack too small for Watcom's __interrupt prologue,
   which crashes the box on heavy command output). */
extern "C" void __far int28_stub( void );
extern "C" void idle_set_stack( unsigned ss, unsigned sp );

static unsigned get_ds_seg( void );
#pragma aux get_ds_seg = "mov ax,ds" value [ax];

/* A would-be "chain to the previous INT 28h handler" thunk -- retained but
   NOT invoked: idle_isr_c references it only as `(void)call_old28;` and
   int28_stub just IRETs.  We do not chain INT 28h; the e2e passes (incl. heavy
   output) on both MS-DOS 6.22 and FreeDOS without it.  (_chain_intr faults in
   this build anyway.)  Kept in case another resident's INT 28h hook must be
   chained on real hardware. */
extern void call_old28( void );
#pragma aux call_old28 =      \
    "pushf"                   \
    "call dword ptr oldInt28" \
    modify [ax bx cx dx si di es];

/* Called by int28_stub on the private stack.  INT 28h fires while DOS waits on
   console input -- the safe window to feed the BIOS type-ahead buffer (the
   foreground is idle, not mid buffer-read) and to do deferred file I/O. */
extern "C" void idle_isr_c( void )
{
  keys_pump( );                                  /* drain deferred keystrokes safely */
  if ( g_pend_op && !idle_busy ) {
    idle_busy = 1;
    resident_idle( );                            /* drain a deferred file op */
    idle_busy = 0;
  }
  (void)call_old28;
}

/* The byte-level ISR is tiny, but serial_on_rx() parses frames, builds screen
   snapshots, etc. -- far more stack than the random foreground code we may have
   interrupted can spare.  So we run it on a private stack, guarded so a nested
   serial interrupt only buffers bytes (it never re-enters the heavy path). */
static unsigned char priv_stack[ 4096 ];
static void ( __far *g_fn )( void ) = 0;
static unsigned g_new_sp = 0, g_sv_ss = 0, g_sv_sp = 0;
static volatile uint8_t g_busy = 0;

static void pump_priv( void );
#pragma aux pump_priv =              \
    "cli"                            \
    "mov  word ptr g_sv_ss, ss"      \
    "mov  word ptr g_sv_sp, sp"      \
    "mov  ax, ds"                    \
    "mov  ss, ax"                    \
    "mov  sp, word ptr g_new_sp"     \
    "sti"                            \
    "call dword ptr g_fn"            \
    "cli"                            \
    "mov  ss, word ptr g_sv_ss"      \
    "mov  sp, word ptr g_sv_sp"      \
    "sti"                            \
    modify [ax bx cx dx si di es];

static void __interrupt __far uart_isr( void )
{
  for ( ;; ) {
    uint8_t lsr = (uint8_t)inp( R_LSR );
    if ( lsr & 0x01 ) {                          /* received data available */
      uint8_t c = (uint8_t)inp( R_RBR );         /* read RBR to clear DR + line errors */
      if ( !( lsr & 0x1E ) ) {                   /* no Overrun/Parity/Framing/Break -> keep */
        unsigned n = ( rxHead + 1 ) & RX_MASK;
        if ( n != rxTail ) { rxbuf[ rxHead ] = c; rxHead = n; }   /* else drop (full) */
      }                                          /* else: corrupt byte -> drop; CRC -> retry */
      continue;
    }
    if ( ( lsr & 0x20 ) && ( txTail != txHead ) ) {  /* THR empty + data queued */
      outp( R_THR, txbuf[ txTail ] );
      txTail = ( txTail + 1 ) & TX_MASK;
      continue;
    }
    break;
  }
  outp( R_IER, ( txTail != txHead ) ? ( IER_RX | IER_TX ) : IER_RX );
  outp( 0x20, 0x20 );                            /* EOI to the master PIC */
  if ( !g_busy ) {                               /* guard BEFORE the stack switch */
    g_busy = 1;
    g_fn = serial_on_rx;
    pump_priv( );                                /* MUST be called directly from an ISR */
    g_busy = 0;
  }
}

/* INT 28h: DOS issues this while idle/waiting for console input -- the one safe
   window to call the file functions.  Drain any deferred file op here, on the
   private stack.  pump_priv() must be invoked directly from this __interrupt
   handler (routing it through a normal function corrupts the stack switch). */
void serial_hook_idle( void )
{
  idle_set_stack( get_ds_seg( ), (unsigned)( idle_stack + sizeof( idle_stack ) - 2 ) );
  oldInt28 = _dos_getvect( 0x28 );
  _dos_setvect( 0x28, (INTVEC)int28_stub );
}

void serial_install( unsigned base, uint8_t irq, uint16_t divisor )
{
  uint8_t mask;
  uartBase = base;
  uartIrq  = irq;
  uartVec  = ( irq < 8 ) ? ( 0x08 + irq ) : ( 0x70 + irq - 8 );

  outp( R_IER, 0x00 );                           /* interrupts off while we set up */
  outp( R_LCR, 0x80 );                           /* DLAB=1 */
  outp( R_DLL, (uint8_t)( divisor & 0xFF ) );
  outp( R_DLM, (uint8_t)( divisor >> 8 ) );
  outp( R_LCR, 0x03 );                           /* 8N1, DLAB=0 */
  outp( R_FCR, 0x07 );                           /* enable + clear FIFOs, 1-byte trigger */
  outp( R_MCR, 0x0B );                           /* DTR+RTS+OUT2 (OUT2 gates IRQ to PIC) */
  (void)inp( R_LSR ); (void)inp( R_RBR );        /* clear any pending state */
  (void)inp( uartBase + 2 ); (void)inp( uartBase + 6 );

  g_new_sp = (unsigned)( priv_stack + sizeof( priv_stack ) - 2 );

  oldUartVec = _dos_getvect( uartVec );
  _dos_setvect( uartVec, (INTVEC)uart_isr );

  _disable( );
  mask = (uint8_t)inp( 0x21 );
  outp( 0x21, (uint8_t)( mask & ~( 1 << uartIrq ) ) );  /* unmask our IRQ */
  _enable( );

  outp( R_IER, IER_RX );                          /* enable RX interrupts */
}

void serial_uninstall( void )
{
  uint8_t mask;
  outp( R_IER, 0x00 );
  _disable( );
  mask = (uint8_t)inp( 0x21 );
  outp( 0x21, (uint8_t)( mask | ( 1 << uartIrq ) ) );
  _enable( );
  if ( oldUartVec ) _dos_setvect( uartVec, oldUartVec );
}

unsigned serial_rx_count( void )
{
  return ( rxHead - rxTail ) & RX_MASK;
}

int serial_rx_get( void )
{
  int c;
  if ( rxTail == rxHead ) return -1;
  c = rxbuf[ rxTail ];
  rxTail = ( rxTail + 1 ) & RX_MASK;
  return c;
}

unsigned serial_tx( const uint8_t *buf, unsigned len )
{
  unsigned i;
  for ( i = 0; i < len; i++ ) {
    unsigned n = ( txHead + 1 ) & TX_MASK;
    if ( n == txTail ) break;                     /* TX ring full -> drop rest */
    txbuf[ txHead ] = buf[i];
    txHead = n;
  }
  outp( R_IER, IER_RX | IER_TX );                 /* (re)enable transmit interrupt */
  return i;
}
