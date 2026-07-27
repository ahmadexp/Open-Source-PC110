## 32 MB Memory-Expansion BIOS Patch

> # ⚠️ VALIDATION REQUIRED — UNTESTED ON HARDWARE
> This patch has been **verified by disassembly and in an emulator only**. It has **never been
> flashed to a real PC110.** Reflashing the BIOS can permanently **brick** the machine. Do not use
> this on any unit you are not prepared to recover with an external programmer. Treat the images
> here as a **candidate for validation**, not a finished mod.

A firmware companion to the hardware [`RAS4`](../RAS4) / denser-module memory upgrades: it lets a
PC110 populated with **more than the stock 20 MB** (e.g. a 16 + 16 MB module = 36 MB physical) boot
cleanly, without the RC-delay circuit and `DARK2301` warm-boot dance of the classic *taka* hack.

### What it does

Cold-boot POST counts extended memory with a destructive write/read-back test
(`F000:5FBC`/`6076`). On a machine with more than 32 MB physical, that count walks **past the
VL82C420's 32 MB address ceiling**, the top addresses **wrap** onto low RAM, and POST corrupts itself
and dies. (That is taka's cold-boot failure — hence his RC circuit to hide the extra bank at power-on.)

This patch **caps the count** at a chosen total (default **28 MB**). POST then never touches memory
above the cap, so it never wraps — the machine boots to the cap on a plain cold boot, no circuit, no
`DARK2301`. The DRAM geometry is left alone; the physical memory above the cap is simply unused.

> **Why cap the count, not the geometry:** the count is a data-integrity test, not an alias detector.
> Downgrading a bank's geometry register would just let the physical DRAM alias and pass the test, so
> the count would wrap anyway. Capping the count is the provably-safe fix. Full reasoning:
> [`Discovery/RAM-Module`](../../Discovery/RAM-Module/readme.md) §7.4–7.5 and
> [`Discovery/Chipset`](../../Discovery/Chipset/readme.md) §13k.

Default cap is **28 MB** — taka's proven-stable value (256-colour Windows works). 32 MB is the full
non-wrapping ceiling but rides the exact-32 MB boundary and may re-introduce taka's 256-colour issue;
rebuild with `--mb 32` if you want it.

### The patch (17 bytes, all inside the 96 KB main flash block)

```
hook @ flash 0x36095 (F000:6095, in the ext-mem count loop):
   83 C3 40                add bx,0x40          ->   E9 36 C5   jmp 0x25CE
stub @ flash 0x325CE (F000:25CE, a verified-unreferenced dead slot):
   83 C3 40                add bx,0x40
   81 FB 00 6C             cmp bx,0x6C00        ; 0x6C00 = 27648 KB ext = 28 MB total
   73 03                   jnc  0x25DA          ; at/over cap -> done
   E9 BE 3A                jmp  0x6098          ; under cap  -> continue loop
   E9 CC 3A                jmp  0x60A9          ; done
```

It touches only the **96 KB main block** (flash `0x20000–0x37FFF`). The two 8 KB parameter blocks and
the 16 KB **boot block** (which holds the reset vector) are untouched — so a bad main-block write is
still recoverable, and the patch is flashable by the in-system flasher (below).

### Files

| File | What |
|---|---|
| `make_patch.py` | reproducible builder: stock 256 KB BIOS + `--mb N` → the two images below |
| `PC110_BIOS_patched.BIN` | full **256 KB** patched image (28 MB cap) — sha1 `4458513e…` |
| `PC110ROM.BIN` | the **96 KB** main-block slice (`0x20000–0x37FFF`) the flasher consumes — sha1 `55afcc07…` |

Rebuild from the archived stock ROM at any cap:
```
python3 make_patch.py --mb 28      # default; use --mb 32 for the full ceiling
```

### Flashing it (once validated)

Use the **Flash BIOS** item in [`PS2GUI`](https://github.com/ahmadexp/PS2GUI) /
[`PS2TUI`](https://github.com/ahmadexp/PS2TUI) (*Dumps & ROM → Flash BIOS*): copy `PC110ROM.BIN` to
`C:\PC110ROM.BIN` on the PC110 and run it (A/C + battery ≥ 20 % required). The flash mechanism —
chipset unlock, VPP-enable (`port 0x98`), 28F002 erase/program — is documented in
[`Discovery/BIOS-Flash`](../../Discovery/BIOS-Flash/readme.md).

### Validation checklist (what "validated" would mean)

1. Flash onto a **recoverable** unit (external programmer / clip on hand) — ideally a spare, not a
   reference machine.
2. Confirm a **stock/20 MB** unit still boots unchanged (the patch is inert below the cap).
3. On a **>28 MB** unit, confirm it cold-boots to 28 MB with no RC circuit / no `DARK2301`, and that
   DOS + Windows are stable (esp. 256-colour).
4. Confirm no other POST step touches memory above the cap.

Until all four are done on real hardware, this stays **VALIDATION REQUIRED**.
