## FNTEST — raw keyboard scancode monitor

A 433-byte DOS `.COM` that hooks `INT 9` and prints **every raw byte the keyboard controller
delivers**, in hex. Built to answer one question empirically: **does pressing `Fn` on the PC110
produce anything the system can see?**

### Why it exists

The M38813 KBC firmware was reverse-engineered (see
[`Discovery/Keyboard`](../../Discovery/Keyboard/readme.md) §6) and it contains **no Fn overlay** —
just the three standard scancode-set tables. All the Fn-legended functions (Ins/Del/Home/End/PgUp/
PgDn, arrows, keypad) have their **own matrix positions** with the `E0`-prefix attribute. So the KBC
never composes an "Fn + key" combination, which leaves two possibilities that the ROM alone cannot
separate:

1. `Fn` is a matrix key whose scancode-table entry is `0x00` → the KBC **swallows it** and the host
   sees nothing; or
2. `Fn` gates the **membrane** electrically, so affected keys simply present their alternate matrix
   position — again no separate "Fn" code ever reaches the host.

Both predict **no scancode for Fn alone**. They differ in what `Fn`+key does, which this tool shows.

### Usage

```
FNTEST
```
Then:

1. **Press `Fn` alone.** If nothing appears, the KBC emits nothing for it (both hypotheses).
2. **Press `↑` alone** — expect `E0 75` (set 1: `E0 48`).
3. **Press `Fn`+`↑`** — if you now see the **PgUp** code (`E0 7D`, set 1 `E0 49`) with **no extra
   byte** for Fn, hypothesis 2 is confirmed: the key's *code changes* and Fn itself is invisible.
4. Repeat for `Fn`+`↓` (PgDn), `Fn`+`←` (Home), `Fn`+`→` (End), `Fn`+`NumLk`, etc.

Press **ESC three times** to exit (it restores the original `INT 9` vector).

### Notes

- Hardware-wise it only **reads** port `0x60` inside the hook and chains to the original handler, so
  DOS keeps working normally while it runs.
- Codes are shown exactly as delivered, so `E0`/`E1` prefixes and break codes (`F0 xx` in set 2,
  `0x80|make` in set 1) are visible — useful for confirming which scancode set is active.
- Please report findings back to the project; the result closes §6.4 of the Keyboard chapter.

### Build

```
nasm -f bin FNTEST.ASM -o FNTEST.COM
```
