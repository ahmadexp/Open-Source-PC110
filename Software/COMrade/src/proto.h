/*
   proto.h - control protocol opcodes and framing for COMRADE.

   The full human-readable spec is doc/PROTOCOL.md; this header and
   comrade/protocol.py are the two codecs that must match it.

   On the serial wire each frame is:

     [u8 0xAA SYNC][u8 type][u16 reqId][u16 len][payload...][u8 cksum]

   cksum = 8-bit additive sum of the inner bytes (type..end-of-payload). The
   5-byte inner header [type][reqId][len] is little-endian (x86-native), so we
   read/write words directly. Replies echo reqId; reqId 0 marks an unsolicited
   DOS->host event. A reply may set bit 0x40 (COMP_FLAG) to mark a compressed
   payload [u16 origLen][lzss...]; see doc/PROTOCOL.md and lzss.cpp.
*/

#ifndef PROTO_H
#define PROTO_H

#include "types.h"

#define PROTO_VER       1
#define PROTO_HDR_LEN   5
#define PROTO_MAX_PAYLOAD 8192   /* we never emit a single payload larger */

#define SYNC_BYTE       0xAA     /* serial frame start byte */
#define COMP_FLAG       0x40     /* type-byte bit: payload is [u16 origLen][lzss] */

/* host -> DOS */
#define OP_PING         0x01
#define OP_SCREEN_GET   0x02
#define OP_KEYS_SEND    0x03
#define OP_FILE_READ    0x04
#define OP_FILE_WRITE   0x05
#define OP_DIR_LIST     0x06
#define OP_FILE_ATTR    0x07
#define OP_MEM_READ     0x08
#define OP_MEM_WRITE    0x09
#define OP_CONSOLE_GET  0x0A
#define OP_IO_IN        0x0B
#define OP_IO_OUT       0x0C
#define OP_KEYS_RAW     0x0D     /* raw make/break scancodes via the 8042 controller */
#define OP_REBOOT       0x0E     /* warm-boot the box (no reply; used for self-update) */
#define OP_FILE_HASH    0x10     /* CRC-32 of a whole file (end-to-end transfer verify) */
#define OP_BUS_STIM     0x11     /* tight-loop bus stimulus: repeat io/mem read OR write K times (RE/LA) */
#define OP_IDX          0x12     /* indexed-register access: write index->A, read/write data<->B */
#define OP_IO_RMW       0x13     /* read-modify-(auto-restore) a port: reversible probe write */
#define OP_PIC          0x14     /* snapshot both 8259 PICs (IRR/ISR/IMR) */
#define OP_SAFE         0x15     /* query the write-guard deny-list */
/* DOS -> host */
#define OP_HELLO        0x80
#define OP_PONG         0x81
#define OP_SCREEN_DATA  0x82
#define OP_KEYS_ACK     0x83
#define OP_FILE_DATA    0x84
#define OP_FILE_WROK    0x85
#define OP_DIR_DATA     0x86
#define OP_FILE_ATTR_OK 0x87
#define OP_MEM_DATA     0x88
#define OP_MEM_WROK     0x89
#define OP_CONSOLE_DATA 0x8A
#define OP_IO_DATA      0x8B
#define OP_IO_OK        0x8C
#define OP_KEYS_RAW_OK  0x8D
#define OP_ERROR        0x8F
#define OP_FILE_HASH_OK 0x90     /* [status:1][length:4][crc32:4] */
#define OP_BUS_STIM_OK  0x91     /* [status:1][iterations:4][last_value:4] */
#define OP_IDX_DATA     0x92     /* read: [status:1][count:1][data...]; write: [status:1][count:1] */
#define OP_RMW_OK       0x93     /* [status:1][width:1][old_value:4] */
#define OP_PIC_OK       0x94     /* [status:1][m_irr][m_isr][m_imr][s_irr][s_isr][s_imr] (6 bytes) */
#define OP_SAFE_OK      0x95     /* [status:1][nranges:1] then nranges*[lo:2][hi:2] denied port ranges */

/* Write-guard: bit in the flags byte of every WRITE-capable op (BUS_STIM write
   kinds, IDX write, IO_RMW). Set it to override the compiled-in deny-list for a
   port you have decided is safe. Cleared = the guard rejects denied ports with
   ST_ACCESS. Single-shot IO_OUT / MEM_WRITE stay intentionally unguarded (the
   explicit "I know what I'm doing" pokes); the guard covers the dense/scripted
   write paths, which are the dangerous-at-scale ones. */
#define GF_UNSAFE  0x01

/* status codes */
#define ST_OK            0
#define ST_NOT_FOUND     1
#define ST_ACCESS        2
#define ST_EOF           3
#define ST_BAD_ARGS      4
#define ST_BUSY          5
#define ST_OTHER       0xFF

/* FILE_WRITE flag bits */
#define WF_TRUNC   0x01
#define WF_APPEND  0x02

#endif
