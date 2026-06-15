# M38223 (MELPS-740) power-sense MCU emulator
CXX      ?= g++
CXXFLAGS ?= -std=c++17 -O2 -Wall
ROM      ?= M38223E4HP@QFP80.BIN

all: m38223

m38223: m740.cpp m38223.cpp m740.h
	$(CXX) $(CXXFLAGS) m740.cpp m38223.cpp -o $@

# run the firmware (place the ROM dump next to the binary)
run: m38223
	./m38223 "$(ROM)" 3000000

# complete static disassembly of the ROM
disasm: disasm740.py
	python3 disasm740.py "$(ROM)" > m38223_full_disasm.asm
	@echo "wrote m38223_full_disasm.asm"

clean:
	rm -f m38223

.PHONY: all run disasm clean
