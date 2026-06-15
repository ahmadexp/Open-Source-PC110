# Makefile — PC110 replacement BIOS (F000 system-BIOS image)
# Toolchain: ia16-elf-gcc + nasm  (16-bit real-mode x86)
#   ia16-elf-gcc:  https://github.com/tkchia/build-ia16  (or your distro pkg)
#   alt: Open Watcom (wcc/wasm) with equivalent flags
#
# Targets:
#   make            -> bios_sys.bin  (64 KiB, the F000 system BIOS)
#   make flash      -> pc110_bios_new.bin (full 256 KiB: stitches in stock
#                      VGA BIOS + packed region so only F000 is replaced)
#   make clean

CXX     := ia16-elf-g++
LD      := ia16-elf-ld
OBJCOPY := ia16-elf-objcopy
ASM     := nasm

CXXFLAGS := -std=c++17 -ffreestanding -fno-exceptions -fno-rtti \
            -mcmodel=tiny -Os -Wall -Wextra -fno-stack-protector
ASMFLAGS := -f elf

STOCK   := pc110_bios.bin            # original 256 KiB dump (for VGA + packed)

all: bios_sys.bin

reset.o: reset.asm
	$(ASM) $(ASMFLAGS) $< -o $@

biosmain.o: biosmain.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

bios.elf: reset.o biosmain.o bios.ld
	$(LD) -T bios.ld -o $@ reset.o biosmain.o

bios_sys.bin: bios.elf
	$(OBJCOPY) -O binary --gap-fill 0xFF --pad-to 0x10000 $< $@
	@echo "built $@ (64 KiB F000 image); reset vector:"
	@xxd -s 0xFFF0 -l 5 $@

# Replace ONLY the system BIOS (0x30000-0x3FFFF); keep stock VGA + packed region.
flash: bios_sys.bin
	@test -f $(STOCK) || (echo "need $(STOCK) (original dump)"; exit 1)
	cp $(STOCK) pc110_bios_new.bin
	dd if=bios_sys.bin of=pc110_bios_new.bin bs=1 seek=$$((0x30000)) conv=notrunc
	@echo "wrote pc110_bios_new.bin (256 KiB) — flash to E28F002BX"

clean:
	rm -f *.o bios.elf bios_sys.bin pc110_bios_new.bin

.PHONY: all flash clean
