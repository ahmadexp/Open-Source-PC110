# Source this to put OpenWatcom (DOS 16-bit cross target) on PATH.
#   . ./env.sh
if [ -z "${WATCOM:-}" ]; then
  if [ -d /opt/watcom ]; then
    export WATCOM=/opt/watcom
  else
    export WATCOM=/root/watcom
  fi
fi
export PATH="$WATCOM/binl64:$PATH"
export INCLUDE="$WATCOM/h"
export EDPATH="$WATCOM/eddat"
export WIPFC="$WATCOM/wipfc"
