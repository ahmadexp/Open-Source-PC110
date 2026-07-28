#!/usr/bin/env python3
"""
pi-relay.py - transparent serial <-> TCP relay.

Run this on the machine the DOS box is physically cabled to (e.g. a Raspberry Pi
that is too old / wrong-arch to run Claude Code itself).  It exposes the local
serial port as a raw TCP socket so a comrade running elsewhere can reach the
DOS box with its existing --tcp transport:

    # on the Pi (next to the 486):
    python3 pi-relay.py --serial /dev/ttyUSB0 --baud 38400 --listen 0.0.0.0:7777

    # on the Windows/Mac/Linux machine running Claude Code:
    comrade --tcp <pi-ip>:7777        # (claude mcp add ... -- ... --tcp <pi-ip>:7777)

It is a dumb byte pump: whatever bytes arrive on the serial port are sent to the
TCP client and vice-versa, with no framing/telnet/RFC2217 interpretation (the
comrade protocol's own SYNC+checksum framing rides on top untouched).  One
client at a time; it re-accepts when the bridge reconnects.

ONLY dependency: pyserial (`pip install pyserial`) -- pure Python, installs fine
on armv6l where the full bridge (mcp/pydantic) will not.  The serial line
parameters (baud, 8N1) are owned HERE; match them to the agent's /baud.
"""

import argparse
import socket
import sys
import threading

import serial


def _serial_to_sock(ser, conn, stop):
    """Forward bytes from the serial port to the TCP client until disconnect.
    read() returns whatever arrived within the port timeout (or b'' when idle, so
    we keep polling `stop`); we avoid in_waiting/TIOCINQ, which varies by driver."""
    try:
        while not stop.is_set():
            data = ser.read(4096)
            if data:
                conn.sendall(data)
    except OSError:
        pass
    finally:
        stop.set()


def _sock_to_serial(ser, conn, stop):
    """Forward bytes from the TCP client to the serial port until disconnect."""
    conn.settimeout(0.5)
    try:
        while not stop.is_set():
            try:
                data = conn.recv(4096)
            except socket.timeout:
                continue
            if not data:                         # client closed
                break
            ser.write(data)
    except OSError:
        pass
    finally:
        stop.set()


def serve(ser, host, port):
    srv = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    srv.bind((host, port))
    srv.listen(1)
    print(f"pi-relay: {ser.port} @ {ser.baudrate} 8N1  <->  tcp {host}:{port}",
          file=sys.stderr, flush=True)
    while True:
        conn, addr = srv.accept()
        print(f"pi-relay: client {addr[0]}:{addr[1]} connected", file=sys.stderr, flush=True)
        conn.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
        ser.reset_input_buffer()
        ser.reset_output_buffer()
        stop = threading.Event()
        threads = [
            threading.Thread(target=_serial_to_sock, args=(ser, conn, stop), daemon=True),
            threading.Thread(target=_sock_to_serial, args=(ser, conn, stop), daemon=True),
        ]
        for t in threads:
            t.start()
        stop.wait()
        try:
            conn.close()
        except OSError:
            pass
        # Wait for BOTH pumps to fully exit before accepting the next client --
        # otherwise the old serial reader, still blocked in ser.read(), can wake
        # up and steal the first bytes of the next session (e.g. a bridge that
        # disconnects and immediately reconnects).
        for t in threads:
            t.join()
        print("pi-relay: client disconnected; waiting for the next", file=sys.stderr, flush=True)


def main():
    ap = argparse.ArgumentParser(description="serial <-> TCP relay for a remote comrade")
    ap.add_argument("--serial", required=True, metavar="DEV", help="serial device, e.g. /dev/ttyUSB0")
    ap.add_argument("--baud", type=int, default=38400, help="baud (match the agent's /baud)")
    ap.add_argument("--listen", default="0.0.0.0:7777", metavar="HOST:PORT")
    args = ap.parse_args()

    host, _, port = args.listen.rpartition(":")
    try:
        ser = serial.Serial(args.serial, args.baud, timeout=0.05)
    except serial.SerialException as exc:
        sys.exit(f"pi-relay: cannot open {args.serial!r}: {exc}\n"
                 f"  check the node (`ls /dev/ttyUSB*`) and dialout-group membership")
    try:
        serve(ser, host or "0.0.0.0", int(port))
    except KeyboardInterrupt:
        pass
    finally:
        ser.close()


if __name__ == "__main__":
    main()
