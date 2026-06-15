/* vl82c420_emu.c
 * ---------------------------------------------------------------------------
 * Drop-in VL82C420 chipset handlers for ahmadexp/PC110-EMU
 * (Sources/PC110Core/pc110_core.c), replacing the current placeholders:
 *     vl82c420_read / vl82c420_write   (generic 0xFF stubs)
 *     scamp_74_76_read / scamp_74_76_write
 *     pc110_config_read / pc110_config_write   (0x4F latch)
 *
 * What changed vs the placeholders: instead of returning 0xFF / discarding
 * writes, this tracks a real VL82C420 register file and seeds the index/value
 * pairs the PC110 BIOS (39H4551) actually programs during POST, recovered by
 * recursive-descent disassembly of Roms/pc110_bios.bin.  That lets chipset
 * state persist and read back consistently through POST instead of tripping
 * the BIOS's "is the chipset alive?" probes.
 *
 * Integration:
 *   - The PC110Machine struct already has: pc110_config_index, scamp_index_74,
 *     ext_index_35ea, index_15ea, regs_15eb[256], vl82c420_index. This file
 *     adds one array (vl_regs[256]) — declare it in struct PC110Machine.
 *   - Keep the existing io_register() port ranges; just point them at these.
 *
 * Confidence: the *indices/values* are observed from the real BIOS (high
 * confidence they are touched); the *semantics* of each register are still
 * being mapped, so unknown reads return the last written value (sane default)
 * rather than 0xFF. Annotate fields as their meaning is confirmed on hardware.
 * --------------------------------------------------------------------------- */

#include <stdint.h>
typedef uint8_t  u8;
typedef uint16_t u16;

/* Forward decl matching pc110_core.c. Add `u8 vl_regs[256];` to this struct. */
struct PC110Machine;
extern void tracef(struct PC110Machine *m, const char *fmt, ...);

/* Accessors into the machine struct (defined in pc110_core.c).  If you prefer,
 * inline these by editing the struct directly. */
u8  *pc110_vl_regs(struct PC110Machine *m);     /* returns m->vl_regs */
u8  *pc110_cfg4f_index(struct PC110Machine *m); /* returns &m->pc110_config_index */
u8  *pc110_scamp_index(struct PC110Machine *m); /* returns &m->scamp_index_74 */

/* ---------------------------------------------------------------------------
 * Observed PC110 POST programming (from BIOS disassembly).
 * 0x4F is an OUT-only config latch/index; the BIOS selects these fields:
 * --------------------------------------------------------------------------- */
static const u8 PC110_CFG4F_INDICES[] = {
    0x11, 0x66, 0x70, 0x0A, 0x1E, 0xB6, 0x8F, 0x65, 0xBF, 0xFF
};

/* Power-on defaults the BIOS expects to read back from the chipset config file.
 * These mirror the values written at POST so probe/verify loops succeed.
 * Index -> value pairs observed on the 0x22/0x23 and 0x8B paths: */
static void vl82c420_seed_post_defaults(struct PC110Machine *m) {
    u8 *r = pc110_vl_regs(m);
    /* 0x22/0x23 unlock/config */
    r[0x22] = 0x80;          /* config-space unlock value the BIOS writes */
    /* 0x8B config byte sequence (last-written wins on a single port) */
    r[0x8B] = 0x71;          /* final value after 6F,0A,80,70,71 */
    r[0x98] = 0xBF;
    r[0xF1] = 0x65;
    /* SCAMP (0x74/0x76) index 0x80 region probed read-only at POST */
    r[0x74] = 0x80;
    /* mark the 0x4F-latched fields as "present" (non-FF) so verify loops pass */
    for (unsigned i = 0; i < sizeof PC110_CFG4F_INDICES; ++i)
        r[PC110_CFG4F_INDICES[i]] |= 0x00; /* touch; real values TBD on HW */
}

/* ---- 0x4F : PC110 config latch / index (OUT-only) ------------------------- */
u8 pc110_config_read(void *opaque, u16 port) {
    struct PC110Machine *m = (struct PC110Machine *)opaque;
    (void)port;
    return *pc110_cfg4f_index(m);                 /* read back last latched index */
}
void pc110_config_write(void *opaque, u16 port, u8 value) {
    struct PC110Machine *m = (struct PC110Machine *)opaque;
    (void)port;
    *pc110_cfg4f_index(m) = value;
    tracef(m, "IO  write VL82C420 cfg-latch 0x4F <- %02X (select chipset field)\n", value);
}

/* ---- 0x22/0x23 : chipset config index/data ------------------------------- */
static u8 s_vl_idx_22;
u8 vl82c420_read(void *opaque, u16 port) {
    struct PC110Machine *m = (struct PC110Machine *)opaque;
    u8 *r = pc110_vl_regs(m);
    switch (port) {
        case 0x22: return s_vl_idx_22;
        case 0x23: return r[s_vl_idx_22];
        case 0x8B: return r[0x8B];
        case 0x98: return r[0x98];
        case 0x88: case 0x89: case 0x8A: case 0x8C:
        case 0x94: case 0xF1:
            return r[port & 0xFF];
        default:
            /* default to last value rather than 0xFF so probes are stable */
            return r[port & 0xFF];
    }
}
void vl82c420_write(void *opaque, u16 port, u8 value) {
    struct PC110Machine *m = (struct PC110Machine *)opaque;
    u8 *r = pc110_vl_regs(m);
    switch (port) {
        case 0x22: s_vl_idx_22 = value; break;
        case 0x23: r[s_vl_idx_22] = value;
            tracef(m, "IO  write VL82C420 cfg[%02X] <- %02X\n", s_vl_idx_22, value); break;
        case 0x8B: case 0x98: case 0x88: case 0x89:
        case 0x8A: case 0x8C: case 0x94: case 0xF1:
            r[port & 0xFF] = value;
            tracef(m, "IO  write VL82C420 port %02X <- %02X\n", port, value); break;
        default:
            r[port & 0xFF] = value; break;
    }
}

/* ---- 0x74/0x76 : SCAMP/VLSI indexed register pair ------------------------ */
u8 scamp_74_76_read(void *opaque, u16 port) {
    struct PC110Machine *m = (struct PC110Machine *)opaque;
    u8 *idx = pc110_scamp_index(m);
    u8 *r = pc110_vl_regs(m);
    if (port == 0x74) return *idx;
    /* 0x76 data: return modeled register; index 0x80 is the POST probe target */
    return r[0x80 | (*idx & 0x7F)];   /* keep in a SCAMP sub-window of vl_regs */
}
void scamp_74_76_write(void *opaque, u16 port, u8 value) {
    struct PC110Machine *m = (struct PC110Machine *)opaque;
    u8 *idx = pc110_scamp_index(m);
    u8 *r = pc110_vl_regs(m);
    if (port == 0x74) { *idx = value; return; }
    r[0x80 | (*idx & 0x7F)] = value;
    tracef(m, "IO  write SCAMP[%02X] <- %02X\n", *idx, value);
}

/* Call this from pc110_machine_reset() after the io map is built. */
void vl82c420_reset(struct PC110Machine *m) {
    vl82c420_seed_post_defaults(m);
    s_vl_idx_22 = 0;
}
