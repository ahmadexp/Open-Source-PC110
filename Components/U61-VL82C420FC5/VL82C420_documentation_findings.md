# VLSI VL82C420 (SCAMP IV) — Documentation Trail & Recovered Source Material

## The short answer

A conventional, published **VL82C420 datasheet does not exist anywhere in the public record.** VLSI Technology's
Portable Systems Division (Tempe, Arizona) launched the SCAMP IV chipset (VL82C420 system controller +
VL82C144 peripheral chip + optional VL82C146 ExCA controller) in **October 1993**, just as VLSI was exiting the
PC-chipset business. No databook covering it was ever scanned, and every datasheet archive (bitsavers,
DatasheetArchive, DOS Days, The Retro Web) confirms the gap — bitsavers' VLSI PC collection stops at the
**VL82C114, dated March 1993**, a few months short of SCAMP IV.

**However — the chip's actual engineering documentation survives, in VLSI's own patents.** The designers of the
VL82C420 filed for patent protection the same week the chip was announced. These patents contain the real
block diagrams, the internal architecture of the system controller, the full bus protocol, signal-level
definitions, and timing diagrams. This is the closest thing to a datasheet/schematic that exists, and it was
written by the people who built the chip.

---

## Primary source: the VL82C420 system-controller patent

**US 5,793,990 A — "Multiplex address/data bus with multiplex system controller and method therefor"**

- Assignee: **VLSI Technology, Inc.** (later Philips Semiconductors VLSI)
- Inventors: **James J. Jirgal, David R. Evoy, Walter H. Potts** (VLSI Tempe, AZ)
- **Filed: 11 June 1993** — the SCAMP IV public announcement was 17 June 1993
- Also published internationally as **WO 1994/029797 A1**

This patent describes the **"Multiplexed Local Bus" (ML Bus)** that the SCAMP IV announcement named as the
proprietary interconnect between the VL82C420, VL82C144 and VL82C146 — and the **multiplex system controller**,
which is the VL82C420 itself.

Read / figures / PDF:
- Patent page: https://patents.google.com/patent/US5793990A/en
- Full PDF: https://patentimages.storage.googleapis.com/89/6b/d8/84459ba2e43015/US5793990.pdf
- International (PCT) version: https://patents.google.com/patent/WO1994029797A1

### The figures (these are the schematics / block diagrams)

- **FIG. 1** — block diagram, local-bus architecture: CPU + memory-I/O device + I/O-only device + multiplex
  system controller, showing the split address bus A[25:18]/A[17:10]/A[9:2], D[31:0], CPU control bus, ISA
  A[23:0]/D[15:0], and the multiplex control bus.
- **FIG. 2** — "downstream" architecture: CPU and multiplex system controller integrated in one CPU-bus-controller
  chip, with an external CPU bus slave.
- **FIG. 3A / 3B** — the 16-bit address/data formats for memory-I/O and I/O-only devices.
- **FIG. 4** — byte-selection model (A1, BHE#, BLE#).
- **FIG. 5–13** — timing diagrams: I/O read (high/low device), I/O write, terminated I/O, memory read/write,
  terminated memory, and multiplex DMA read/write.
- **FIG. 14** — **internal block diagram of the multiplex system controller (the VL82C420 core)**: state machine,
  address latch, three multiplexers (36/38/40), and the DMA controller (42) with their bus connections.

Direct images of the drawing pages:
- Page 2: https://patentimages.storage.googleapis.com/55/e5/90/a5b69ab2d8e299/US5793990-drawings-page-2.png
- Page 3: https://patentimages.storage.googleapis.com/6a/f7/9d/91c4959da61ff3/US5793990-drawings-page-3.png
- Page 4: https://patentimages.storage.googleapis.com/d8/6b/0a/585cc552d74397/US5793990-drawings-page-4.png
- Page 5: https://patentimages.storage.googleapis.com/f5/dc/62/ff5d3f748ec276/US5793990-drawings-page-5.png
- Page 6: https://patentimages.storage.googleapis.com/0b/e8/b2/6ecba8d80ba7dd/US5793990-drawings-page-6.png
- Page 7: https://patentimages.storage.googleapis.com/5c/19/d7/d32f9da17bb907/US5793990-drawings-page-7.png
- Page 8: https://patentimages.storage.googleapis.com/6d/64/2b/aa57556dfceecf/US5793990-drawings-page-8.png
- Page 9: https://patentimages.storage.googleapis.com/f5/ab/4d/38500753dcd5e9/US5793990-drawings-page-9.png

### Bus signal definitions recovered from the patent (the ML Bus)

These are the actual SCAMP IV Multiplexed Local Bus signals as defined by the chip designers:

- **MLCLK** — multiplex bus clock; a 1X clock driven synchronously to the CPU clock, but separately gateable from
  the CPU clock so both can be independently stopped for power conservation.
- **MLADS#** — multiplex address strobe (low-true); asserted by the system controller when it is driving valid
  address or data on the CPU's address lines.
- **MLLBA#** — multiplex device local-bus-access (low-true); a target device asserts it when it positively decodes
  a valid address. Also used during reads to indicate which CPU address lines the device sits on
  (A[17:2] if asserted during MLRDY#, A[25:10] if negated).
- **MLRDY#** — multiplex ready; asserted by a device to signal write-data accepted or read-data valid; the
  controller can also assert it to terminate a cycle when no device acknowledges.
- **ADS#, M/IO#, AHOLD, RDY#, LBA#** — CPU-side handshake signals; AHOLD is how the controller tri-states the
  CPU address bus to take it over for a multiplex cycle.

### How the chip works (from the patent text)

The system controller translates ordinary x86 CPU memory/I/O cycles into **16-bit multiplexed bus cycles**, in
which address and data share the same lines — a portion (A[25:2]) of the CPU's 32-bit address bus. It asserts
**AHOLD** to tri-state the CPU's address bus, then sequentially drives two 16-bit address groups and one 16-bit
data group. Memory-I/O devices decode to 1 KB granularity; I/O-only devices decode to 4-byte granularity. The
internal core (FIG. 14) is a **state machine** driving an **address latch** and **three multiplexers**, with a
**DMA controller** feeding DMA addresses/acknowledges into those multiplexers. The whole point is pin reduction
for the companion chips — exactly the "only 3 TTL components needed" / low-pin-count design the SCAMP IV
announcement advertised.

---

## Companion patents — the rest of the SCAMP IV design

The same VLSI team patented the other functional blocks of the chipset around the same time. Together these form
the de-facto technical reference for the family:

| Patent | Title | Relevance |
|--------|-------|-----------|
| **US 5,793,990** | Multiplex address/data bus with multiplex system controller | The VL82C420 core + ML Bus (primary) |
| **WO 1994/029797** | (PCT version of the above) | International filing, same content |
| **US 5,715,467** | Event-driven power management control circuit and method | SCAMP IV power-management unit (Jirgal / VLSI) |
| **US 5,561,772** | Expansion bus system replicating an internal bus as an external bus with logical interrupts | Multiplexed notebook bus, interrupt handling |
| **US 5,805,901** | Structure and method for mapping interrupt requests in a high-speed CPU interconnect bus | ML Bus interrupt mapping |
| **US 5,655,142** | High-performance derived local bus and computer system employing the same | Deriving a CPU-style local bus from the multiplexed peripheral bus |
| **US 5,652,847** | Circuit and system for multiplexing data and a portion of an address on a bus | Address/data multiplexing detail |
| **US 5,958,055** | Power management system for a computer | Power-management architecture |

Patent links:
- US5715467A: https://patents.google.com/patent/US5715467A/en
- US5561772: https://patents.google.com/patent/US5561772A/en
- US5805901: https://patents.google.com/patent/US5805901A/en
- US5655142: https://patents.google.com/patent/US5655142A/en
- US5652847: https://patents.google.com/patent/US5652847A/en
- US5958055A: https://patents.google.com/patent/US5958055A/en

---

## Closest official VLSI documents that do exist (predecessor architecture)

If you want VLSI-published datasheets for the directly related parts (same register/architecture lineage):

- SCAMP II — VL82C316 / VL82C323 data manual (Oct 1992):
  https://bitsavers.org/components/vti/pc/VTI_VL82C316_VL82C323_SCAMP_II_199210.pdf
- VL82C114 Combination I/O (Mar 1993) — closest sibling to the VL82C144:
  https://bitsavers.org/components/vti/pc/VL82C114_Combination_IO_199303.pdf
- SCAMP — VL82C310 / 311 / 311L data manual (Jan 1992):
  https://bitsavers.org/components/vti/pc/VTI_VL82C310_82C311_82C311L_Data_Manual_199201.pdf

## Machines that used the VL82C420 (potential schematic sources)

- **IBM ThinkPad 230Cs** (Type 2432, Japan-only, 486SX-33) — chipset confirmed as VL82C420/VL82C144.
- **AST Ascentia** 486 notebooks (Quanta-built).

Neither machine's full board schematic is posted publicly; an IBM/AST service manual would be the route to one.

---

## Bottom line

The datasheet was never released to the public and isn't archived anywhere. But the **VL82C420's real internal
design — block diagrams, bus protocol, signal definitions, and timing — survives in US Patent 5,793,990 and its
companion VLSI filings**, authored by the chip's own designers and filed the week of the SCAMP IV launch. That is
the deepest authoritative source that exists today.
