import sys
sys.path.insert(0, '/tmp/m740dasm')
from m740dasm.disasm import disassemble
from m740dasm.trace import Tracer
from m740dasm.memory import Memory
from m740dasm.listing import Printer
from m740dasm.symbols import SymbolTable
from m740dasm.devices import Devices

ROM_PATH = '/sessions/brave-blissful-hopper/mnt/uploads/M38223E4HP@QFP80 (1).BIN'
with open(ROM_PATH, 'rb') as f:
    rom = bytearray(f.read())

TARGET = 0x4000
pad = TARGET - len(rom)
rom = rom + bytearray([0xFF]) * pad
start_address = 0x10000 - len(rom)
sys.stderr.write(";; base=0x%04X len=0x%04X pad=%d\n" % (start_address, len(rom), pad))

memory = Memory(rom)
entry_points = [0xC046]
vectors = [a for a in range(0xFF5A, 0xFF7E, 2)]
traceable_range = range(start_address, start_address + len(rom) + 1)
tracer = Tracer(memory, entry_points, vectors, traceable_range)
tracer.trace(disassemble)
symbol_table = SymbolTable(Devices["M3802"]["symbol_table"])
symbol_table.analyze_symbols(memory)
printer = Printer(memory, start_address, symbol_table)
printer.print_listing()
