/* serial.h - interrupt-driven 16550 UART driver for COMRADE. */
#ifndef SERIAL_H
#define SERIAL_H
#include "types.h"

/* Initialize a COM port (8N1) at the given divisor and hook its IRQ.
   base: 0x3F8 (COM1) / 0x2F8 (COM2).  irq: 4 (COM1) / 3 (COM2).
   divisor: 115200/baud (1=115200, 6=19200, 12=9600). */
void serial_install( unsigned base, uint8_t irq, uint16_t divisor );
void serial_uninstall( void );

/* Consumer side (called from frame processing). */
unsigned serial_rx_count( void );     /* bytes available in the RX ring */
int      serial_rx_get( void );       /* next byte, or -1 if empty */

/* Queue bytes for transmission (drained by the TX interrupt).
   Returns bytes accepted (may be < len if the TX ring is full). */
unsigned serial_tx( const uint8_t *buf, unsigned len );

/* Hook INT 28h (DOS idle) so deferred file ops drain in a DOS-safe window. */
void serial_hook_idle( void );

#endif
