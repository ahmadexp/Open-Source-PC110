# Keyboard Membrane (`PCB/Keyboard/Membrane/`)

The internal **key-matrix membrane** for the PC110 clamshell keyboard — a two-layer flex circuit carrying the switch grid for every key plus the two pointing-device click buttons. It is a passive interconnect: no ICs, just the printed conductor matrix and two ribbon tails that mate to the mainboard, where the scan is done by the **M38813 keyboard/PM MCU (U67)**.

**Sources:** `PC110_membrance.kicad_sch`, `PC110_membrance_Schematic.pdf`, `PC110_membrance.kicad_pcb`, `README.md`. Cross-ref: `Discovery/Pluto/readme.md` ("M38813 keyboard/PM MCU — full pinout"). Tags **[C]** confirmed / **[H]** inferred.

## 1. What the board is / role

- Passive **flex key-matrix** for the built-in keyboard. All active elements are momentary push switches (`SW_Push_45deg`), one per key.
- Two ribbon connectors carry the matrix back to the mainboard KBC — **no scanning logic on the membrane itself**.
- Also routes the **two TrackPoint/pointing-stick click buttons** (`Left ClicK`, `Right Clock` — spellings verbatim from the source), which are *not* part of the scan matrix.

## 2. Matrix organization and KBC mapping

**92 push switches = 90 scanned keys + 2 pointer buttons** (`SW91`/`SW92` connect to `TRKPD_*`/`GND`, not to matrix nets).

The scan matrix uses **8 column/drive lines** `KB1_0 … KB1_7` and **16 return/sense lines** `KB2_1 … KB2_16` — the **8 × 16 = 128-key grid** the KBC is wired for. Only **90 intersections are populated**, and **`KB2_1` carries no key** (appears only at the connector), so the effective grid as drawn is **8 × 15**. Whether `KB2_1` is truly unused on the original or is a gap in this recreation is **[H]**.

Correspondence to the decoded KBC (`Discovery/Pluto/readme.md`):

| Membrane net | KBC port (M38813) | Pluto pin | Function |
|---|---|---|---|
| `KB1_0 … KB1_7` | `P30 … P37` | 56 … 49 | matrix **column drive** (strobe) |
| `KB2_1 … KB2_16` | `P00–P07` / `P10–P17` | 33 … 48 | matrix **sense** (return; `KB2_16` has RA32 pull-ups) |

So **`KB1` = columns (driven by the KBC)** and **`KB2` = rows/returns (sensed)** — matching the Pluto pinout exactly.

**Key-count per line** (each cross-checked two independent ways — bijective label→switch assignment and raw label-occurrence count — both agree):

| Column | keys | Return | keys | Return | keys |
|---|---|---|---|---|---|
| KB1_0 | 14 | KB2_1 | **0** | KB2_9 | 8 |
| KB1_1 | 14 | KB2_2 | 3 | KB2_10 | 10 |
| KB1_2 | 10 | KB2_3 | 4 | KB2_11 | 8 |
| KB1_3 | 10 | KB2_4 | 5 | KB2_12 | 8 |
| KB1_4 | 8 | KB2_5 | 3 | KB2_13 | 8 |
| KB1_5 | 10 | KB2_6 | 3 | KB2_14 | 7 |
| KB1_6 | 12 | KB2_7 | 2 | KB2_15 | 6 |
| KB1_7 | 12 | KB2_8 | 7 | KB2_16 | 8 |
| **Σ** | **90** | | | **Σ** | **90** |

**Key legend set** (Japanese layout, from the switch `Value` fields): `ESC F1–F12`, digit row, `Q…P`, `A…L ; '`, `Z…M , . /`, `Tab CapsLk Shift Ctrl Alt Fn Space Enter BkSp Del Ins Home End PgUp PgDn PrtScn Pause NmLk`, arrows, and the JP IME keys `半/全` (Hankaku/Zenkaku), `カタカナ`, `無変換`, `前候補` — confirming a **JP-layout PC110 keyboard**.

> **[H] Exact per-key (column,row) map — not asserted.** Each switch does carry an explicit `KB1_x`+`KB2_y` label pair in the schematic, so the map *is* present in the source — but the labels sit on short wire stubs, and coordinate-proximity extraction produced matrix collisions. A reliable per-key map needs a proper netlist/wire trace (or a clean KiCad netlist export), not geometry. The aggregate structure and per-line counts above are solid; individual key coordinates are deliberately **not** reproduced to avoid fabricating a map.

## 3. Connectors to the host (mainboard/KBC)

Two single-row ribbon tails (net order traced from `(label …)` positions along each connector).

**J1 — "Keyboard Conn 1"** (`Conn_01x08`, 8-pin) → the **column/drive** tail:

| Pin | Net | Pin | Net |
|---|---|---|---|
| 1 | KB1_2 | 5 | KB1_5 |
| 2 | KB1_4 | 6 | KB1_3 |
| 3 | KB1_6 | 7 | KB1_1 |
| 4 | KB1_7 | 8 | KB1_0 |

**J2 — "Keyboard Conn 2"** (`Conn_01x20`, 20-pin) → the **return/sense + pointer-button** tail:

| Pin | Net | Pin | Net |
|---|---|---|---|
| 1 | **NC** | 11 | KB2_10 |
| 2 | GND | 12 | KB2_12 |
| 3 | TRKPD_Rclick | 13 | KB2_13 |
| 4 | TRKPD_Lclick | 14 | KB2_4 |
| 5 | KB2_7 | 15 | KB2_14 |
| 6 | KB2_2 | 16 | KB2_5 |
| 7 | KB2_11 | 17 | KB2_3 |
| 8 | KB2_9 | 18 | KB2_1 |
| 9 | KB2_6 | 19 | KB2_16 |
| 10 | KB2_8 | 20 | KB2_15 |

Notes: the 16 return lines are **deliberately scrambled** across J2 pins 5–20 (physical flex routing, not logical order). **Pointer buttons:** `SW91` (`Left ClicK`) ties `TRKPD_Lclick`→GND; `SW92` (`Right Clock`) ties `TRKPD_Rclick`→GND — SPST-to-ground on J2 pins 4/3, independent of the matrix. Pin 1 = the only no-connect; pin 2 = the single membrane GND.

## 4. Construction (flex / PET)

- **2 copper layers only** (`F.Cu`/`FC` top, `B.Cu`/`BC` bottom); no inner layers.
- Flexible substrate. The **original IBM membrane is PET (polyester)** — the classic printed-conductor membrane process (per `README.md`).
- Switch symbols are `SW_Push_45deg` (45° footprint), consistent with the diagonal contact-pad pattern of a membrane snap-dome/carbon-contact site.

## 5. Recreation notes

- The KiCad files can be fabricated directly as a **Flex PCB** (polyimide) — fastest route to a working replacement, though the feel differs from the original.
- To reproduce the original, use **PET membrane manufacturing** (the README cites a PCBWay PET service).
- Wire J1 as the 8 column lines and J2 as the 16 return lines + 2 pointer buttons + GND per the tables; the KBC (`U67 M38813`) expects `KB1_0..7` on `P30–P37` (drive) and `KB2_1..16` on `P00–P07/P10–P17` (sense) — see `Discovery/Pluto/readme.md`.

## 6. KBC firmware — how the matrix becomes scancodes  ✅ **[RE 2026-07-28]**

Reverse-engineered from the **M38813E4HP KBC ROM** (`PC110-EMU/Roms/M38813E4HP@QFP64.bin`, 16,255 B,
*"MELPS 740 Series Keyboard Firmware Version 1.1 (C) 1992-1995 RIOS Systems"*, ROM base **`0xC081`**,
reset `0xC208`) with a purpose-written MELPS-740 disassembler.

### 6.1 The scan loop
The matrix scan/change-detect loop (around **`0xDE37`–`0xDF80`**, four near-identical copies) does:

```
LDY #$00                  ; row counter, 0..0x12  (19 rows)
LDA $0126,Y / EOR $60     ; current scan byte  vs previous  -> change mask
LDA $0113,Y / EOR $61     ; (two 19-byte debounce buffers at $0113 and $0126)
TYA / ASL / ASL / ASL     ; X = row*8
TAX
LDY $E2D4,X               ; <- look up this key's scancode
BEQ  skip                 ; **a table entry of 0x00 emits NOTHING**
JSR $E034                 ; queue/emit the code to the host
```

So the KBC scans **19 rows × 8 bits = 152 positions**, the key index is **`row*8 + bit`**, and
**a zero table entry means the key is swallowed** — it produces nothing the system can see.

### 6.2 Three scancode-set tables (not an Fn layer)
The emit path selects the code table through a zero-page pointer `$60/$61` (`LDA ($60),Y`), set at
**`0xC5AE`–`0xC5D8`** from a mode variable **`$93`** plus per-key attribute bits. There are **three**
152-byte tables, and decoding them identifies each as a **standard scancode set**:

| Table | Set | Proof (Esc / `1` / Q / Tab / A / Z / F1) |
|---|---|---|
| **`$E1A4`** | **Set 1** | `01 02 10 0F 1E 2C 3B` |
| **`$E23C`** | **Set 2** | `76 16 15 0D 1C 1A 05` |
| **`$E2D4`** | **Set 3** | `08 16 15 0D 1C 1A 07` |

`$93` is the active set (the standard 8042 *"select scancode set"*, command `0xF0`). **113 of the 152
positions carry a code; 39 are zero.**

### 6.3 Per-key attribute table `$E36C`
A parallel 152-byte table of per-key flags (`LDA $E36C,Y / STA $A8`, then `BBS`/`BBC` bit tests):

- **`0x68` (bits 6+5+3) — exactly 10 keys** (idx 74, 81, 82, 89, 90, 91, 98, 99, 103, 105). In the
  Set-2 table these are precisely the **keypad** codes (`70 74 71 72 7D 7A 6C 69 75 6B`), so this flag
  means **"emit the `E0` prefix"** — turning keypad codes into **Ins, →, Del, ↓, PgUp, PgDn, Home,
  End, ↑, ←**. That is the classic laptop navigation/keypad overlay, resolved in the KBC.
- **`0x08`** on 17 keys, plus single/rare values `0x80`, `0x88`, `0x48`, `0x28`, `0x11` — other
  per-key handling (make/break suppression, `E1`-prefix, etc.); not individually decoded yet **[H]**.

### 6.4 Does pressing **Fn** produce anything the system can see?
**The KBC firmware contains no Fn overlay.** There are exactly three code tables and they are the
three *scancode sets* — there is **no fourth table, and no code path that substitutes one key's code
for another based on a held modifier**. All the Fn-legended functions (Ins/Del/Home/End/PgUp/PgDn,
arrows, NumLk, ScrLk, keypad) already have **their own matrix positions** with their own codes plus the
`E0`-prefix flag. So the KBC never *composes* an "Fn + key" combination.

That leaves two possibilities, and the firmware alone cannot separate them **[H]**:

1. **Fn is a matrix key whose table entry is `0x00`** — one of the 39 zero positions. Then the KBC
   swallows it and **the host sees nothing at all** when Fn is pressed (it would exist only to be
   sensed... by nothing, which makes this unlikely on its own unless the membrane also re-routes).
2. **Fn switches the membrane electrically** — the keycap gates which intersections close, so the
   affected keys simply present their *alternate* matrix position to the KBC. This fits the firmware
   evidence well: it explains why the alternate functions need their own populated positions and why
   no firmware Fn logic exists.

Deciding between them needs the one thing neither the ROM nor the recreation's netlist settles: **the
per-key (column,row) map** (§2 notes why it was not reproduced), or simply **watching the wire while
someone presses Fn**. A ready-made monitor for the latter ships as
[`Software/FNTEST`](../../Software/FNTEST/) — hook `INT 9`, press Fn, and see whether *any* scancode
arrives.

> **Prediction to test:** if hypothesis 2 holds, pressing **Fn alone produces no scancode at all**, but
> **Fn + ↑** produces the `E0 7D` (PgUp) sequence rather than `E0 75` (↑) — i.e. the code changes with
> no separate "Fn" code ever appearing on the wire.
