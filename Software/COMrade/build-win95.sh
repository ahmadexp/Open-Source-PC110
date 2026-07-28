#!/bin/sh
# build-win95.sh - cross-compile the Win32 agent for Windows 95.
#
# Open Watcom's Win32 PE target is used here.  The resulting console program
# uses only Win9x-era Win32 APIs and runs beside (or instead of) the DOS TSR.
set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
DIST="$ROOT/dist"

mkdir -p "$DIST"
WCL="${WATCOM:-}/binl64/wcl386"
if [ -x "$WCL" ]; then
  "$WCL" -q -bt=nt -l=nt -w4 -dWINVER=0x0400 \
    -fe="$DIST/COMR95.EXE" "$ROOT/win95/comr95.c" user32.lib gdi32.lib
else
  CC="$(command -v i686-w64-mingw32-gcc || true)"
  if [ -z "$CC" ]; then
    echo "Need Open Watcom wcl386 or i686-w64-mingw32-gcc" >&2
    exit 1
  fi
  # No CRT: modern MinGW defaults import api-ms-win-crt-*, absent on Win95.
  "$CC" -DCOMR95_NO_CRT_MAIN -DWINVER=0x0400 -D_WIN32_WINNT=0x0400 -march=i386 -Os \
    -fno-builtin -fno-stack-protector -fno-asynchronous-unwind-tables \
    -mno-stack-arg-probe -nostdlib -nodefaultlibs \
    -Wl,--entry,_start -Wl,--subsystem,console \
    -o "$DIST/COMR95.EXE" "$ROOT/win95/comr95.c" \
    -lkernel32 -luser32 -lgdi32
fi

echo "Built: $DIST/COMR95.EXE"
ls -l "$DIST/COMR95.EXE"
