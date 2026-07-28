/*
   agent.cpp - COMRADE (serial) installer / entry point.

   Sets up a COM port, hooks its interrupt, and stays resident.  All the work
   then happens in the serial ISR -> serial_on_rx() (resident.cpp).  No mTCP, no
   packet driver: the agent is a small serial TSR that the modern host drives
   over a null-modem cable (or USB-serial), exposed via the comrade MCP server.

   Usage:
     COMRADE [/com1|/com2] [/baud N]    install + stay resident
     COMRADE /?                          help
   Defaults: COM1, 115200 baud, 8N1.
*/

#include <dos.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "serial.h"
#include "resident.h"
#include "dossafe.h"

static void usage( void )
{
  printf( "COMRADE - serial remote-control agent for MS-DOS\n"
          "  COMRADE [/com1|/com2] [/baud N]   install + stay resident\n"
          "  defaults: COM1, 115200 baud, 8N1\n" );
}

int main( int argc, char **argv )
{
  unsigned      base = 0x3F8;
  uint8_t       irq  = 4;
  int           com  = 1;
  unsigned long baud = 115200UL;
  unsigned      psp, paras;
  uint16_t      divisor;
  int           i;

  for ( i = 1; i < argc; i++ ) {
    if ( !stricmp( argv[i], "/com1" ) )      { base = 0x3F8; irq = 4; com = 1; }
    else if ( !stricmp( argv[i], "/com2" ) ) { base = 0x2F8; irq = 3; com = 2; }
    else if ( !stricmp( argv[i], "/baud" ) && i + 1 < argc ) baud = strtoul( argv[++i], 0, 10 );
    else if ( !stricmp( argv[i], "/?" ) || !stricmp( argv[i], "-h" ) ) { usage( ); return 0; }
  }
  if ( baud == 0 ) baud = 115200UL;
  divisor = (uint16_t)( 115200UL / baud );
  if ( divisor == 0 ) divisor = 1;

  printf( "COMRADE (serial) starting on COM%d, %lu baud...\n", com, baud );

  psp = getCurrentPSP( );
  serial_install( base, irq, divisor );
  resident_setup( psp );

  paras = PEEKW( psp - 1, 3 );                     /* program block size (paragraphs) */
  printf( "COMRADE resident (~%u KB). Listening on COM%d.\n",
          (unsigned)( ( paras + 63 ) / 64 ), com );
  fflush( stdout );
  _dos_keep( 0, paras );
  return 0;   /* not reached */
}
