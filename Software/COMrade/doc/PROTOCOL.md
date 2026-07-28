# COMrade wire protocol

The single human-readable spec for the binary protocol spoken over the serial
line between the DOS resident agent (`COMRADE.EXE`) and the Python bridge
(`comrade`). The two codecs that must match this doc:

- **DOS side:** `src/proto.h` (opcodes/constants) + the emit/parse code in
  `src/resident.cpp`, `src/fileops.cpp`, `src/dirlist.cpp`, `src/capture.cpp`,
  `src/lzss.cpp`.
- **Host side:** `comrade/protocol.py` (the full codec; also used by the test
  double `tests/mock_dos.py`).

All multi-byte integers are **little-endian** (x86-native, no byteswap).
Strings are a `u16` length prefix followed by raw **CP437** bytes (DOS text is
CP437, not UTF-8).

## Transport & framing

The link is a **serial byte stream** (COM1 / 16550 UART on hardware; a TCP
socket standing in for the COM port under QEMU). It is **not** TCP/IP — there is
no network stack on the DOS side. The bridge is the client; it opens the stream.

Each frame on the wire:

```
  +------+--------+----------+--------+-----------+----------+
  | 0xAB | type:1 | reqId:2  | len:2  | payload   | crc16:2  |
  | SYNC |        | (LE)     | (LE)   | (len B)   | (LE)     |
  +------+--------+----------+--------+-----------+----------+
```

- `SYNC` = `0xAB` marks a CRC-16 frame; the de-framer hunts for it and resyncs
  past line noise. (`0xAA` marks a legacy frame with a 1-byte additive-checksum
  trailer; the host de-framer accepts **both** and auto-detects which the box
  speaks, so a CRC-era agent and a legacy one are both supported on one bridge.)
- `crc16` = CRC-16-CCITT (poly `0x1021`, init `0xFFFF`, no reflection / final
  XOR) over the **inner** bytes `type, reqId, len, payload` (everything between
  SYNC and the trailer), little-endian. A bad CRC is dropped and the de-framer
  resyncs. CRC-16 replaced the old 8-bit additive sum, which was blind to byte
  transpositions and ~1/256 of random corruption — letting real-link errors pass
  as silently-wrong data (notably file_read losing its last byte).
- `reqId` correlates a reply to its request. `reqId == 0` marks an **unsolicited
  DOS→host event** (only `HELLO` today).
- **Reply opcode = request opcode `| 0x80`.**
- A reply may also set bit **`0x40` (COMP_FLAG)** to mark a compressed payload
  (see *Compression*). The host clears `0x40` before dispatching.

The agent never emits a payload larger than its output buffer (~4300 bytes); the
host de-framer (`MAX_PAYLOAD`) accepts up to 65535. File/console transfers are
chunked to `chunk_max` (HELLO-negotiated, default 1024) so each op fits one
frame and one brief DOS-safe window.

## Opcodes

| Code | Name | Dir | Reply |
|------|------|-----|-------|
| 0x01 | PING        | host→DOS | HELLO |
| 0x02 | SCREEN_GET  | host→DOS | SCREEN_DATA |
| 0x03 | KEYS_SEND   | host→DOS | KEYS_ACK |
| 0x04 | FILE_READ   | host→DOS | FILE_DATA |
| 0x05 | FILE_WRITE  | host→DOS | FILE_WROK |
| 0x06 | DIR_LIST    | host→DOS | DIR_DATA |
| 0x07 | FILE_ATTR   | host→DOS | FILE_ATTR_OK |
| 0x08 | MEM_READ    | host→DOS | MEM_DATA |
| 0x09 | MEM_WRITE   | host→DOS | MEM_WROK |
| 0x0A | CONSOLE_GET | host→DOS | CONSOLE_DATA |
| 0x0B | IO_IN       | host→DOS | IO_DATA |
| 0x0C | IO_OUT      | host→DOS | IO_OK |
| 0x0D | KEYS_RAW    | host→DOS | KEYS_RAW_OK |
| 0x0E | REBOOT      | host→DOS | *(none — the box warm-boots; no reply)* |
| 0x10 | FILE_HASH   | host→DOS | FILE_HASH_OK |
| 0x11 | BUS_STIM    | host→DOS | BUS_STIM_OK |
| 0x12 | IDX         | host→DOS | IDX_DATA |
| 0x13 | IO_RMW      | host→DOS | RMW_OK |
| 0x14 | PIC         | host→DOS | PIC_OK |
| 0x15 | SAFE        | host→DOS | SAFE_OK |
| 0x30 | WIN_SCREENSHOT | host→Win95 | WIN_SCREENSHOT_DATA |
| 0x80 | HELLO       | DOS→host | (reply to PING; also unsolicited reqId 0 on connect) |
| 0x81 | PONG        | DOS→host | (reserved) |
| 0x82 | SCREEN_DATA | DOS→host | |
| 0x83 | KEYS_ACK    | DOS→host | |
| 0x84 | FILE_DATA   | DOS→host | |
| 0x85 | FILE_WROK   | DOS→host | |
| 0x86 | DIR_DATA    | DOS→host | |
| 0x87 | FILE_ATTR_OK| DOS→host | |
| 0x88 | MEM_DATA    | DOS→host | |
| 0x89 | MEM_WROK    | DOS→host | |
| 0x8A | CONSOLE_DATA| DOS→host | |
| 0x8B | IO_DATA     | DOS→host | |
| 0x8C | IO_OK       | DOS→host | |
| 0x8D | KEYS_RAW_OK | DOS→host | |
| 0x8F | ERROR       | DOS→host | (any request can fail with this) |
| 0x90 | FILE_HASH_OK| DOS→host | |
| 0x91 | BUS_STIM_OK | DOS→host | |
| 0x92 | IDX_DATA    | DOS→host | |
| 0x93 | RMW_OK      | DOS→host | |
| 0x94 | PIC_OK      | DOS→host | |
| 0x95 | SAFE_OK     | DOS→host | |
| 0xB0 | WIN_SCREENSHOT_DATA | Win95→host | |

## Status codes (in FILE_DATA / FILE_WROK / FILE_ATTR_OK / ERROR)

| Code | Name | Meaning |
|------|------|---------|
| 0 | OK | success |
| 1 | NOT_FOUND | file/path not found (DOS err 2/3) |
| 2 | ACCESS | access denied (DOS err 5) |
| 3 | EOF | at/after end of file |
| 4 | BAD_ARGS | malformed request / unknown opcode |
| 5 | BUSY | DOS not in a safe window for this op — **retry** (see *DOS-safe window*) |
| 0xFF | OTHER | other DOS error |

## Payload layouts

Notation: `name:N` = N little-endian bytes; `str` = `u16 len` + CP437 bytes.

- **PING** → *(empty)*. Agent answers with **HELLO**.
- **HELLO** `ver:1 | cols:1 | rows:1 | chunk_max:2 | machine:str`. Sent
  unsolicited (reqId 0) on every connect, and as the reply to PING. `machine` is
  the build tag `COMRADE/<git-hash>[-dirty].<UTC>` (stamped by `build.sh`); the
  host's `check_update` extracts the same string from a `COMRADE.EXE` on disk to
  decide whether the running agent is up to date.
- **SCREEN_GET** → *(empty)*.
- **SCREEN_DATA** `mode:1 | cols:1 | rows:1 | curCol:1 | curRow:1 | curVis:1 |
  cells[cols*rows × (char:1, attr:1)]` — a B800 snapshot of the live screen.
- **WIN_SCREENSHOT** `width:2 | height:2` — request a small desktop thumbnail.
  The Win95 agent clips requests to 96×72 so the grayscale result fits in one
  serial frame. DOS agents return `ERROR` for this Win32-only extension.
- **WIN_SCREENSHOT_DATA** `status:1 | width:2 | height:2 | format:1 | dlen:2 |
  data[dlen]` — `format=1` is an 8-bit grayscale thumbnail suitable for a PGM
  image. The Win95 agent captures the desktop through GDI.
- **KEYS_SEND** `count:2 | count × (scancode:1, ascii:1)` — cooked keys into the
  BIOS type-ahead buffer (read by INT 16h / DOS input).
- **KEYS_ACK** `injected:2` — pairs accepted into the BIOS type-ahead path.
- **KEYS_RAW** `count:2 | count × scancode:1` — raw Set-1 make/break scancodes
  (0xE0 prefix for grey keys; break = make|0x80) fed to the 8042 controller via
  command 0xD2, so each raises a real INT 9 — reaches INT 9-hookers (games,
  full-screen apps) the BIOS buffer can't.
- **KEYS_RAW_OK** `injected:2` — scancode bytes written.
- **REBOOT** *(empty)* — warm-boots the box (BDA reset flag + 8042 `0xFE`). No
  reply (the machine resets); the bridge auto-reconnects when the agent reloads.
- **FILE_READ** `path:str | offset:4 | maxlen:2`.
- **FILE_DATA** `status:1 | total:4 | offset:4 | dlen:2 | data[dlen]` — `total`
  is the file size; `eof` when `offset+dlen >= total`.
- **FILE_WRITE** `path:str | flags:1 | offset:4 | dlen:2 | data[dlen]`. Flags:
  `WF_TRUNC 0x01` (create/truncate — set on the first chunk), `WF_APPEND 0x02`
  (append at EOF, offset ignored). Both clear ⇒ seek to `offset`.
- **FILE_WROK** `status:1 | written:4`.
- **DIR_LIST** `path:str | start:2` — wildcard path (e.g. `A:\*.*`); `start` is
  the continuation index (see below). An exact name is a stat.
- **DIR_DATA** `count:2 | more:1 | count × entry`, where
  `entry = attr:1 | wr_time:2 | wr_date:2 | size:4 | namelen:1 | name[namelen]`.
  `more=1` means the buffer filled — re-request with `start += count` until
  `more=0`. `wr_time`/`wr_date` are packed DOS fields (see below).
- **FILE_ATTR** `path:str | set:1 | attr:1` — `set=1` writes `attr` (masked to
  the settable bits), `set=0` just reads. Always replies with the resulting attr.
- **FILE_ATTR_OK** `status:1 | attr:1`.
- **FILE_HASH** `path:str` — compute a whole-file digest.
- **FILE_HASH_OK** `status:1 | length:4 | crc32:4` — CRC-32 (IEEE/zlib:
  reflected poly `0xEDB88320`, init/final `0xFFFFFFFF`) and byte length of the
  whole file. Used to verify a direct disk↔disk transfer end-to-end with retry
  (`file_read dest_path` / `file_write src_path`). The agent reads the file once
  in a DOS-safe window; a large file holds that window for the duration of the read.
- **MEM_READ** `addr:4 | len:2` — `addr` is a 20-bit linear address (0..0xFFFFF).
- **MEM_DATA** `status:1 | addr:4 | len:2 | data[len]`.
- **MEM_WRITE** `addr:4 | len:2 | data[len]`.
- **MEM_WROK** `status:1 | written:2`.
- **IO_IN** `port:2 | width:1` — `width` 1 (byte) or 2 (word); else `BAD_ARGS`.
- **IO_DATA** `status:1 | width:1 | value:4` (value uses the low `width` bytes).
- **IO_OUT** `port:2 | width:1 | value:4`.
- **IO_OK** `status:1`.

### Hardware reverse-engineering ops

These repeat/compose bus cycles for logic-analyzer work and register mapping.
Writes go through a compiled-in **write-guard** (deny-list of ports where a stray
write can hang/reset/power-off the box); set `GF_UNSAFE` (0x01) in the `flags`
byte to override. Single-shot IO_OUT/MEM_WRITE stay unguarded by design.

- **BUS_STIM** — repeat one bus cycle `count` times back-to-back from one
  round-trip so the driven cycles dominate the bus. Legacy request (10 bytes):
  `kind:1 | target:4 | width:1 | count:4`. Full request (17 bytes): appends
  `value:4 | flags:1 | max_ticks:2`. `kind` 0=io_in, 1=mem_read (reads, always
  allowed), 2=io_out, 3=mem_write (writes, guarded). `value` is the written
  byte/word (write kinds). `max_ticks` bounds wall-clock (~55 ms/tick; 0 =
  uncapped) — a runaway guard, since the loop runs to completion on the box and
  outlives a host-side cancel.
- **BUS_STIM_OK** `status:1 | iterations:4 | last_value:4` — `iterations` = cycles
  actually executed (< requested if the `max_ticks` cap fired).
- **IDX** — indexed-register access. Request `subop:1 | idx_port:2 | data_port:2
  | width:1 | first_index:1 | count:1 | flags:1 | value:1`. `subop` 0 = read bank
  (for i in [first, first+count): `out(idx_port, i); read data_port`; count 0 ⇒
  256; only the index is written, so **not** guarded — the standard way to read
  index/data pairs). `subop` 1 = write one reg (`out(idx_port, first_index);
  out(data_port, value)`; guarded). `width` applies to the data port.
- **IDX_DATA** — read: `status:1 | count:1 | data[count*width]`; write:
  `status:1 | count:1(=1)`.
- **IO_RMW** `port:2 | width:1 | value:4 | restore_ms:2 | flags:1` — read the old
  value, write `value` (guarded), and if `restore_ms`>0 spin ~that long then
  write the old value back (a reversible probe write).
- **RMW_OK** `status:1 | width:1 | old_value:4` — old value is reported even when
  the write is refused (`ACCESS`).
- **PIC** → *(empty)*. Snapshot both 8259s (IMR direct; IRR/ISR via OCW3 select —
  side-effect-safe).
- **PIC_OK** `status:1 | m_irr:1 | m_isr:1 | m_imr:1 | s_irr:1 | s_isr:1 |
  s_imr:1`.
- **SAFE** → *(empty)*. Report the write-guard deny-list.
- **SAFE_OK** `status:1 | nranges:1 | nranges × (lo:2, hi:2)` — inclusive denied
  port ranges.
- **CONSOLE_GET** `sinceSeq:4 | maxLen:2` — `maxLen=0` is a cheap "where's the
  head?" query (returns 0 bytes).
- **CONSOLE_DATA** `baseSeq:4 | nextSeq:4 | overflow:1 | dlen:2 | data[dlen]`.
- **ERROR** `code:1 | msg:str`.

MEM_* and IO_* are pure CPU operations (real-mode far-pointer load/store, IN/OUT)
— no DOS calls, so the agent serves them immediately (no `BUSY`/safe-window).
Memory covers the real-mode space only (extended memory >1 MB is unreachable from
real mode). 32-bit port I/O is not supported (no use on a 16-bit ISA bus).

### DOS attribute byte

`RDONLY 0x01 · HIDDEN 0x02 · SYSTEM 0x04 · VOLID 0x08 · SUBDIR 0x10 · ARCH 0x20`.
`FILE_ATTR` set masks to the settable bits `RDONLY|HIDDEN|SYSTEM|ARCH` (0x27);
DOS owns the dir/volume bits. `DIR_LIST` includes hidden/system/subdir entries.

### DOS packed date/time (`wr_date` / `wr_time`)

`date`: bits 0-4 day(1-31), 5-8 month(1-12), 9-15 year-1980.
`time`: bits 0-4 seconds/2, 5-10 minutes, 11-15 hours.

## Console capture cursor model

The agent keeps an 8 KB ring of every console byte ever emitted (INT 29h hook).
`seq` is a **monotonic count of total bytes ever captured** (the ring head), not
a ring offset. To pull losslessly:

1. Send `CONSOLE_GET sinceSeq=<last next_seq>` (start at 0, or use `maxLen=0` to
   read the current head).
2. The reply's `baseSeq` is the first seq actually returned; **`nextSeq` is what
   you pass as the next `sinceSeq`.**
3. `overflow=1` means data between your `sinceSeq` and `baseSeq` fell off the
   ring before you read it (you fell >8 KB behind) — a gap, not silent loss.

## Compression (COMP_FLAG = 0x40)

The 115200-baud link (~11.2 KB/s) is the bottleneck. When a reply payload
compresses smaller, the agent LZSS-compresses it and sets bit `0x40` in the type
byte; the payload then becomes `origLen:2 | lzss[...]`. Requests are never
compressed; if compression wouldn't help, the payload is sent raw (flag clear) —
so old/raw frames stay fully compatible. The host de-framer transparently
decompresses and clears the flag before dispatch.

**LZSS stream format** (stateless per frame): groups of `flagByte:1` + up to 8
tokens. Flag bit (LSB first): `1` = literal (next 1 byte), `0` = match (next 2
bytes `b0,b1`): `distance = (b0 | ((b1>>4)<<8)) + 1`, `length = (b1 & 0x0F) + 3`.
Window 4096, min match 3, max match 18. Copy `length` bytes from `distance` back
in the output. Encoder: `src/lzss.cpp`; decoder: `lzss_decompress` in
`comrade/protocol.py`.
