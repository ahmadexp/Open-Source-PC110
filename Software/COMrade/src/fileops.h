/* fileops.h - out-of-band file read/write for the DOS agent. */
#ifndef FILEOPS_H
#define FILEOPS_H
#include "types.h"

/* Remember our own PSP so file handles use our JFT, not the foreground's. */
void fileops_set_psp( unsigned psp );

/* Read up to maxlen bytes of `path` from `offset` into out.
   Returns bytes read; sets *total to the file size and *status to ST_*. */
unsigned fileops_read( const char *path, uint32_t offset, unsigned maxlen,
                       uint8_t *out, uint32_t *total, uint8_t *status );

/* Write len bytes to `path`.  flags: WF_TRUNC (create/truncate first chunk),
   WF_APPEND (append at end, offset ignored), else seek to offset.
   Returns bytes written; sets *status to ST_*. */
unsigned fileops_write( const char *path, uint8_t flags, uint32_t offset,
                        const uint8_t *data, unsigned len, uint8_t *status );

/* Get (doSet=0) or set (doSet=1) a file's DOS attribute byte via INT 21h AH=43h.
   On set, only the settable bits (read-only/hidden/system/archive) are applied.
   Always reports the resulting attribute in *outAttr; sets *status to ST_*. */
void fileops_attr( const char *path, int doSet, uint8_t newAttr,
                   uint8_t *outAttr, uint8_t *status );

/* CRC-32 (zlib-compatible) and byte length of an entire file, for end-to-end
   transfer verification.  Returns 1 on success; sets *status to ST_*. */
unsigned fileops_crc32( const char *path, uint32_t *out_crc, uint32_t *out_len,
                        uint8_t *status );

#endif
