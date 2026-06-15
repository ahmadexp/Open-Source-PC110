# IBM PC110 — Optical Scans

This directory holds high-resolution optical scans, X-ray images, and PCB layer
captures of the IBM PC110 palmtop and its peripheral boards. The images are
intended to support reverse-engineering, repair, and re-creation of the original
hardware.

## Root images

- `top.png` / `top.jpg` — Optical scan of the top (component) side of the main board.
- `bottom.png` / `bottom.jpg` — Optical scan of the bottom side of the main board.
- `PC110 keyboard.png` — Scan of the keyboard.
- `PSU_BC.png`, `PSU_BC_2.png`, `PSU_BC_parts.jpg` — Power supply board scans (back/component side and part annotations).

## Folders

### `layers/`
Individual copper-layer images of the main board, extracted from the optical
stack. The layer order, from top to bottom, is:

`FC2` (top) → `FC1` → `IP1` (power) → `IC1` → `IC2` → `IC3` → `IC4` → `IP2` (ground) → `BC1` → `BC2` (bottom)

Also includes `top-parts.png` / `bottom-parts.png` part-annotation overlays.
See `layers/README.md` for the layer stack and a link to full-resolution files.

### `x-ray/`
X-ray captures of individual chips and the overall board, used to trace internal
bonding and routing. Includes the `82C420` (BGA and QFN packages), `82c144`,
`486`, `f65535`, `bowman`, and `pluto` devices.

### `Chip Diagnostic/`
Close-up die / package photos of the main ICs (`486sx`, `80486dx2`, `VL82C420`,
`F65535`, `Bowman`, `Pluto`) taken from multiple corners (TL/TR/BL/BR/center)
for stitching, plus board diagnostic shots (`BRD*`) and extracted layers.

### `VL82C420FC5/`
Detailed imagery of the VL82C420 system controller chip, including a
`04 Sample 4 ECO Green.pptx` reference deck.

### `Bowman/` and `Pluto/`
Sequential scan images (`Picture1`–`Picture12`) of the Bowman and Pluto
custom chips.

### `Modem/`
Scans of the modem board: component side (`FC`) and back (`BC`), with variants
showing parts, part values, mask-removed copper, and internal layers (`In1`–`In4`).

### `PSU/`
Scans of the power-supply board: front/back component sides with parts, plus
PCB copper layers (`FC`, `BC`, `IC`, `IP`) including mask-removed versions.

### `DockingStation/`
Scans of the docking-station board: front/back sides with and without parts,
ribbon cables (top/back), and internal layers.

### `16MB-RAM/`
Scans of the different layers of the 16 MB RAM module (front, back, and
multiple scan passes).
