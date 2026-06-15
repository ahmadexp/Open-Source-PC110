/* bios.ld — link a 64 KiB F000 system-BIOS image for the PC110.
 * Use with ia16-elf-ld. The .reset section is forced to offset 0xFFF0 so the
 * CPU's reset far-jump (physical 0xFFFF0) lands on _reset16.
 */
OUTPUT_FORMAT("elf32-i386")
ENTRY(_reset16)

SECTIONS
{
  . = 0x0000;

  .entry  : { *(.entry) }            /* _entry16 startup */
  .text   : { *(.text) *(.text.*) }  /* bios_main + handlers */
  .rodata : { *(.rodata) *(.rodata.*) }
  .data   : { *(.data) *(.data.*) }
  .bss    : { *(.bss) *(.bss.*) *(COMMON) }

  /* CPU reset vector: physical 0xFFFF0 == F000:FFF0 == image offset 0xFFF0 */
  . = 0xFFF0;
  .reset  : { *(.reset) }

  /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame*) }
}
