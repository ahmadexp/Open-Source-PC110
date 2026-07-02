# ULTRACHG — "operation charge" enable/disable, reverse-engineered

`ULTRACHG.COM` (*PT-110 Operation Charge Enable / Disable Program v1.00, © 1996 HA/BMF*) is a
third-party DOS utility that lets the PC110 **charge its battery while the machine is running**
("operation charge"). On many PC110s it is invoked from `AUTOEXEC.BAT` as `ultrachg enable`.

This is a clean-room analysis of the ~1.1 KB `.COM` (disassembly only; the binary is not
redistributed here). It's interesting because it reveals the PC110's **embedded-controller (EC)
mailbox** — and reclassifies the `0x15E8 / 0x15EC` I/O window that the
[live dump](../Live-Dump/) had tentatively labelled "PCMCIA/ATA status".

## Usage
```
ULTRACHG Enable | Disable
```
"This selection will be effective from next charge."

## How it works ✅ (from disassembly)

### 1. Machine check — the IBM PC110 APM vendor call
Same private interface `PS2.EXE` uses (see [`Discovery/PS2`](../PS2/)):
```asm
mov ax,0x5380      ; AH=53h APM, AL=80h IBM vendor extension
mov bh,0x7F        ; function 7F = identify
int 0x15
; success requires the returned signature BH=0x53 ('S'), BL=0x4C ('L'), CL=0x4F ('O')
mov ax,0x5380
mov bh,0xFF
int 0x15           ; and AH must return 0x02
```
If the signature doesn't match → *"This program cannot be run on this machine."*

### 2. The action — a text command to the embedded controller
`Enable` sends the string **`Zn10`**; `Disable` sends **`Zn00`**. Each character is written to the
EC through a mailbox at ports **`0x15E8` (data)** and **`0x15EC` (command/status)**, with a
busy-handshake:

```
for each char C in ("Zn10" | "Zn00"):
    wait_ec():                       ; until EC ready
        loop up to 0x67A times:
            in  al, 0x15EC           ; status
            test al, 3               ; bits 0-1 clear  => ready
            jz  ready
            in  al, 0x61 ; and al,0x10   ; else spin on the port-61 refresh bit (bit 4)
    out 0x15EC, 0x31                 ; write "command" byte 0x31
    wait_ec()
    out 0x15E8, C                    ; write the data byte
```
The whole sequence runs with interrupts off (`cli`/`sti`) and is bracketed by two more APM vendor
calls (`AX=5380, BH=80`, `BL=0xFF` then `BL=1`) — evidently EC-access arbitration.

So `0x15E8/0x15EC` is the **PC110 embedded-controller command mailbox** (the EC being the
power/keyboard micro), and `Zn` is a short text command language the EC understands. The
`RMUDOSAT /PX=15E0-15EF` exclusion seen in the factory `CONFIG.110` is there precisely to keep the
PCMCIA/ATA driver off this EC window.

## Confidence
- ✅ **Verified from disassembly**: the APM machine check, the `Zn10`/`Zn00` strings, the
  `0x15E8`/`0x15EC`/`0x61` port sequence, the handshake, and the `5380/BH=80` bracketing.
- 🟡 **Inferred**: that `0x31` is a generic "write" opcode to the EC and that the target micro is
  the power-sense MCU (U6). The exact `Zn`-command grammar beyond `Zn10`/`Zn00` is not explored.

## In PS2TUI
[`Software/PS2TUI`](../../Software/PS2TUI/) exposes this as **Power → "Operation charging"**
(Enable/Disable). Rather than re-implement the EC handshake, it invokes the proven `C:\ULTRACHG.COM`
(the same way it drives `PS2.EXE`), so the tested tool does the actual EC work.
