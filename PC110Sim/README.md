# PC110Sim

Experimental macOS simulator for the IBM Palm Top PC 110.

## Milestone 16.2

This milestone fixes the next copied-thunk blocker after 16.1.

16.1 reached:

```text
Build:     16.1
Copied 0F11 thunk skips: 1
Linear PC: 000D5BB9
Last op:   000D5BB7  8F
Last bytes: 8F 8F 4C E6 37 24
Run state: halted/stopped
```

Interpretation:

- The ISO-derived boot image is attached correctly.
- The previous `0F 11` copied-thunk skip worked.
- Execution is still before `INT 19h`.
- The next copied-thunk blocker is an invalid-looking `8F` POP-group form.

## New in 16.2

CPU/copied-thunk tolerance:

- Normal `8F /0 POP r/m16` behavior is retained.
- For invalid `8F` group sub-ops in the copied thunk range `000D5000..000D6FFF`:
  - Consume ModR/M effective-address displacement bytes to keep IP aligned.
  - Do not pop the stack.
  - Do not write memory.
  - Continue execution.

New diagnostic:

```text
Copied 8F thunk skips: N
```

This specifically covers:

```asm
8F 8F 4C E6    copied-thunk invalid POP group, skipped
```

## Boot image remains active

The ISO-derived MS-DOS boot image is still bundled and attached:

```text
Disks/MS-DOS 6.22.iso
Disks/MSDOS622_ElTorito_Boot.img
Disks/Disk1.img
```

## Recommended workflow

```text
Start+Copy
Next25+Copy
```

Watch for:

```text
Copied 0F11 thunk skips:
Copied 8F thunk skips:
INT19: bootstrap=1
Boot IMG: ... int19_loads=1
Linear PC: 00007C00 or boot-sector continuation
```
