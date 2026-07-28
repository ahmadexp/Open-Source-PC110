/* dirlist.h - out-of-band directory enumeration for the resident agent. */
#ifndef DIRLIST_H
#define DIRLIST_H
#include "types.h"

/* Enumerate entries matching `pat` (e.g. "A:\\*.*", "C:\\DOS\\*.EXE", or an exact
   name for stat), skipping the first `start` matches, packing as many as fit
   into out[0..cap) as:
     [attr:1][wr_time:2 LE][wr_date:2 LE][size:4 LE][namelen:1][name]
   Returns the packed byte length; sets *count (entries packed) and *more (1 if
   it stopped because the buffer filled -- caller should re-request from
   start+count).  Runs find-first/next with the DTA swapped to our own buffer
   and restored, so the foreground program's find state is untouched. */
unsigned dir_list( const char *pat, unsigned start, uint8_t *out, unsigned cap,
                   unsigned *count, uint8_t *more );

#endif
