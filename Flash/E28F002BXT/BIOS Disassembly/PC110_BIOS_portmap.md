# PC110 I/O port map — BIOS-observed vs PC110-EMU model

Standard integrated cores (BIOS drives, emulator models, decap-confirmed):

| Ports | Block | Emu handler | Core |
|-------|-------|-------------|------|
| 0x20/21, 0xA0/A1 | 8259 PIC pair | pic_* | 82C59 |
| 0x40–43 | 8254 PIT (tick + speaker) | pit_* | 82C54 |
| 0x60/61/64 | KBC + Port B | kbc_system_* | — |
| 0x70/71 | MC146818 RTC/CMOS | rtc_* | MC146818 |
| 0x00–0F, 0xC0–DF | 8237 DMA ×2 | dma_* | 82C37 |
| 0x80–8F | DMA page regs | dma_page_* | — |
| 0x92 | PS/2 sysctrl A (A20) | — | — |

VL82C420-specific registers (emulator placeholders — fill from BIOS):

| Port | Role | BIOS-observed values (POST) |
|------|------|------------------------------|
| 0x4F | config latch/index | idx 0x11,0x66,0x70,0x0A,0x1E,0xB6,0x8F,0x65,0xBF,0xFF |
| 0x22/0x23 | cfg index/data | 0x22←80, 0x23←80 (unlock) |
| 0x74/0x76 | SCAMP idx/data | 0x74←80, IN 0x76 |
| 0x8B | config byte | ←6F,0A,80,70,71 ; IN ×12 |
| 0x98 | config | ←BF ; IN |
| 0xF1 | chipset/MCU | ←65 |
| 0x88/89/8A/8C, 0x94 | config bytes | r/w at POST |
| 0x15EA/EB, 0x35EA/EB | extended indexed blocks | index/data probes (DX) |

Action for PC110-EMU: replace the `vl82c420_write` / `scamp_74_76` placeholders with
the index/value semantics above so chipset state tracks through POST.
