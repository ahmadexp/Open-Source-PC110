/*
   dossafe.h - low-level DOS/BIOS helpers used by the resident agent.

   These wrap the handful of INT 21h calls that need register-level control:
   getting the InDOS flag address, and swapping the PSP / DTA around our
   out-of-band file I/O so our file handles never collide with the foreground
   program's.  We use #pragma aux intrinsics (the same style mTCP uses in
   inlines.h) to keep these off the C runtime.

   BIOS data area and video memory are just reached with MK_FP far pointers.
*/

#ifndef DOSSAFE_H
#define DOSSAFE_H

#include <i86.h>          /* MK_FP, FP_SEG, FP_OFF, INTPACK */
#include "types.h"

/* INT 21h AH=34h: returns the InDOS flag address in ES:BX (far ptr DX:AX). */
extern uint8_t far *getInDosPtr( void );
#pragma aux getInDosPtr =   \
  "mov ah,0x34"             \
  "int 0x21"                \
  "mov dx,es"               \
  "mov ax,bx"               \
  modify [ax bx]            \
  value [dx ax];

/* INT 21h AH=51h: get current PSP segment (BX). */
extern unsigned getCurrentPSP( void );
#pragma aux getCurrentPSP = \
  "mov ah,0x51"             \
  "int 0x21"                \
  "mov ax,bx"               \
  modify [ax bx]            \
  value [ax];

/* INT 21h AH=50h: set current PSP segment. */
extern void setCurrentPSP( unsigned psp );
#pragma aux setCurrentPSP = \
  "mov ah,0x50"             \
  "int 0x21"                \
  parm [bx]                 \
  modify [ax];

/* INT 21h AH=2Fh: get current DTA (ES:BX -> far ptr DX:AX). */
extern void far *getDtaPtr( void );
#pragma aux getDtaPtr =     \
  "mov ah,0x2f"             \
  "int 0x21"                \
  "mov dx,es"               \
  "mov ax,bx"               \
  modify [ax bx]            \
  value [dx ax];

/* INT 21h AH=1Ah: set current DTA (seg, off). */
extern void setDtaPtr( unsigned seg, unsigned off );
#pragma aux setDtaPtr =     \
  "push ds"                 \
  "mov ds,ax"               \
  "mov dx,bx"               \
  "mov ah,0x1a"             \
  "int 0x21"                \
  "pop ds"                  \
  parm [ax] [bx]            \
  modify [ax dx];

/* Far byte/word peek+poke into the BIOS data area / video RAM. */
#define PEEKB(seg,off)      (*(volatile uint8_t  far *)MK_FP((seg),(off)))
#define PEEKW(seg,off)      (*(volatile uint16_t far *)MK_FP((seg),(off)))
#define POKEB(seg,off,v)    (*(volatile uint8_t  far *)MK_FP((seg),(off)) = (uint8_t)(v))
#define POKEW(seg,off,v)    (*(volatile uint16_t far *)MK_FP((seg),(off)) = (uint16_t)(v))

#endif
