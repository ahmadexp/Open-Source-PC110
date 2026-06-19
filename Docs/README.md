# A Tribute to the IBM PC110

<img width="1280" height="1600" alt="WhatsApp Image 2026-06-18 at 18 43 05" src="https://github.com/user-attachments/assets/5e1d9a83-6021-4830-a98e-69c5e73e1ffb" />

Here is a picture of Kevin Moonlight and Ahmad Byagowi showcasing the recreated schematic of the PC110 during VCF2025. 

## A Deep Dive into Silicon, Sandpaper, and Secrets of the IBM PC110

**Reverse engineering the beloved IBM PC110, a 486SX-based subnotebook from the 90s, released exclusively in Japan with custom repackaged BGA chips, custom ASICs, and an attractive form factor.**

---

## Introduction: A Palm-Sized Powerhouse

The **IBM PC110**, released exclusively in **Japan in 1995**, was one of the smallest fully functional x86 systems ever made by IBM. This palmtop computer crammed a 486SX CPU, a CHIPS 65535 VGA chip, two PCMCIA slots, a CF card, and more great features into something that fits on top of your palm.

Despite rumors of an **English-language or U.S. release**, no such version ever reached the market. The project was reportedly in development but was quietly shelved, making the IBM PC110 unique and **regionally rare and historically mysterious**.

What fascinated me wasn’t just the size—it was the story under the keyboard: repackaged BGA packages and chips with no public documentation, the usage of camcorder batteries instead of a proprietary battery, and a CF card slot which made the machine sort of future proof and relevant to be "practical", even today. 

Unfortunately, most of the IBM PC110s ended up breaking down over time due to the leak of the bridge battery, causing corrosion and destroying the circuit board. It was heartbreaking to see those laptops end up in the landfill helplessly.  

So I decided to **reverse engineer the entire machine**. That journey involved **sandpaper**, **ROM dumps**, **laser decapping**, **high-resolution die photos**, and the help of some brilliant hardware and software hackers. What I found includes rare chipsets, custom logic arrays, and design decisions that were both *visionary* and *tragically destructive*.

---

## A Design Ahead of Its Time and One Fatal Flaw

The PC110 had forward-thinking design features, including:

- A **standard camcorder battery** (still sold on Amazon today)
- A **CompactFlash card slot**, used as its primary storage drive

These were remarkable decisions in 1995, long before CF replaced spinning disks in industrial systems.

But the system had a fatal flaw:  
A small **NiMH-based bridge battery**, placed internally, which was designed to maintain power between main battery swaps.
This was mainly because the internal PSU was unable to charge the battery while the machine was operating (things we take for granted with today's laptops). Therefore, the bridge battery was placed there to keep the machine running for about 2 minutes while you perform a battery swap.

Over time, that battery becomes a **ticking time bomb**.  
As it fails, it **leaks potassium hydroxide (KOH)**, a highly corrosive chemical that **destroys PCB traces**, **eats through components**, and **wrecks solder joints**.  
It’s the leading cause of death for otherwise restorable PC110 units today.

---

## Sanding a 10-Layer PCB — With a Flatbed Scanner

To begin understanding the system, I took the hard and destructive, yet necessary route:  
I **sanded the motherboard** down layer by layer.

The board is just **1.0mm thick**, with **10 copper layers**, each ~**70 microns**. I used **ultra-fine grit sandpaper** to remove layers delicately, scanning the exposed surface after each pass with a **high-resolution flatbed scanner**.

It was slow, imperfect, and occasionally damaging—but it worked. By the end, I had a full stack of perfectly aligned copper layers. Because I made several mistakes during the sanding and went too far, especially as I progressed through the layers, I had to sacrifice a second PCB, this time by sanding it from the other side.

---

## Reconstructing the Board in KiCad

With the scanned layers imported into **KiCad**, I aligned them and manually traced:

- Every net  
- Every via (through and blind)  
- Every component pad  
- Every trace/track  
- Every power polygon  
- Many more details  

Bit by bit, the **entire circuit** came together. I gave up many times in the middle due to some complexity or unresolved issues, but each time, I returned and continued. Some traces were incomplete or degraded, but logic and redundancy allowed me to **reconstruct the full schematic** of the system. Some tracks even appeared to go nowhere—perhaps used for debugging or cut later by the manufacturer. Who knows what software IBM used in the mid-90s; certainly not KiCad.

---

## Schematic Extraction and Deep System Insight

After the layout was reconstructed and the parts were identified, I began to **extract the schematic**, piece by piece.  
I organized different **subsystems** into separate schematic sheets, including:

- Clock Tree  
- CPU and debug port  
- Chipset and RTC  
- VGA controller  
- RAM interface  
- ROM and BIOS  
- ASICs  
- Super IO (FDD, Serial, LPT)  
- Power and charging logic  
- PCMCIA controller  
- Audio and FM Synthesizer  
- Storage and CF slot  
- Keyboard/PS2  
- IRDA and Docking station connector  

This gave me exceptional insight into **how IBM and RIOS Systems engineered this device**. After extracting the full schematic, I linked it back to the layout to identify and resolve discrepancies.  

The result is a schematic that **perfectly reflects the physical PCB** — signal-for-signal.

---

## Why This Schematic Unlocks the Future

With a fully accurate schematic and layout, this project now enables:

- **Redesigning the motherboard** with modern components  
- **Changing the form factor** entirely (e.g., vertical/landscape designs)  
- **Creating a Raspberry Pi-based recreation**  
- **Hardware diagnostics and repair**  
- **Upgrades and mods**, including custom RAM cards, new docks, and embedded devices

---

## The Known and Unknown Silicon

Identified components:

- **Intel 80486SX** CPU  
- **CHIPS65535** VGA controller  
- **Ricoh RB5C396** PCMCIA bridge  
- **FDC37C665IR** for FDD, Serial, LPT  
- **SC414281PU4** Storage Controller  
- Various logic ICs

Mysterious components:

- **VL82C420** – part of the SCAMP IV chipset, no datasheet available  
- **ES488** – no datasheet found; To recover the pinout, we purchased an old ISA sound card based on the ES488 and carefully traced all the connections from the ISA bus to the chip. This revealed almost the entire pinout and, in turn, helped us determine the ISA bus pinout of the PC110 motherboard.
- **IBM “Pluto” and “Bowman” ASICs**

The VL82C420 integrates 6 known chips (VL82C59s, VL82C37s, VL82C54, VL82C018) and a custom gate array.

---

## Decapping Chips with CLC and John McMaster

With Fred Nielsen from **CLC**, we decapped the VL82C420, Pluto, and Bowman using a laser-driven photo-chemical process.  
**John McMaster** provided high-resolution die imaging.

### Inside the VL82C420

- 2× VL82C59 (Interrupt Controller)  
- 2× VL82C37 (DMA Controller)  
- 1× VL82C54 (Timer)  
- 1× VL82C018 (RTC)  
- Integrated gate array  
- BGA packaging custom-made by RIOS

### Pluto and Bowman

IBM-designed gate arrays responsible for:

- Power sequencing  
- Interrupt control  
- ISA and docking logic  
- System glue logic

---

## PSU, Modem, and Docking Station Reverse Engineering

Reverse-engineering the PSU, modem, and docking station enabled:

- Full **pinout mapping**  
- Verification of unknown connector functions  
- Potential for **custom modern docks**

---

## Embedded Microcontrollers and ROM Extraction

| Chip           | Function                  |
|----------------|---------------------------|
| **M38223**     | Power sequencing          |
| **M3881**      | Keyboard & PS/2           |
| **D17137AGT**  | TrackPoint controller     |

ROMs for M38223 and M3881 were extracted (thanks to **Kevin Moonlight**).  
**D17137AGT** was imaged optically but not visually decoded.

---

## Everything is Open-Source

GitHub Repo: [https://github.com/ahmadexp/Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110)

### Contents

- `/scans/` — 10-layer PCB scans  
- `/kicad/` — Full KiCad schematic/layout  
- `/rom_dumps/` — ROM binaries  
- `/die_images/` — Die photographs  
- `/pinouts/` — Pin mappings  
- `/notes/` — Research notes

---

## What You Can Do

- Rebuild or modify the hardware  
- Use for emulation or form factor experiments  
- Study VL82C420 and ES488  
- Build docks, RAM, and CF replacements  
- Contribute firmware or ROM analysis

---

## Thanks and Acknowledgements

This project would not have been possible without:

- **Kevin Moonlight** — for microcontroller ROM extraction  
- **Mike Lycett** — for organizing the fundraiser, coordinating the effort, and promoting the project  
- **Nick Rogers** — for debugging and verification  
- **John McMaster** — for high-resolution die imaging and technical consultation  
- **CLC** — for decapping services and silicon prep  
- The **open hardware & retrocomputing community** — for encouragement, contributions, and documentation support

---

## Featured on Hackaday

Read the article: [https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/](https://hackaday.com/2025/04/06/reverse-engineering-the-ibm-pc110-one-pcb-at-a-time/)

> “The kind of project that goes beyond repair — it preserves design history, reveals hidden hardware, and makes future restoration possible.”

---

## Stay Updated

- GitHub: [ahmadexp/Open-Source-PC110](https://github.com/ahmadexp/Open-Source-PC110)  
- Contact: Ahmad Byagowi / [@ahmadexp](https://github.com/ahmadexp)  
- YouTube video coming soon!
