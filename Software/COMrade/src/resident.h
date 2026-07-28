/* resident.h - serial-driven control core for COMRADE. */
#ifndef RESIDENT_H
#define RESIDENT_H
#include "types.h"

void resident_setup( unsigned psp );   /* record our PSP + InDOS, send HELLO */
void serial_on_rx( void );             /* called by the serial ISR to process frames */

#endif
