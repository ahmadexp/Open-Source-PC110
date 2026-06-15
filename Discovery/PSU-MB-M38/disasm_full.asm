    .area CODE1 (ABS)
    .org 0xc000

    P0 = 0x00               ;Port P0
    P0D = 0x01              ;Port P0 direction register
    P1 = 0x02               ;Port P1
    P1D = 0x03              ;Port P1 direction register
    P2 = 0x04               ;Port P2
    P2D = 0x05              ;Port P2 direction register
    P3 = 0x06               ;Port P3
    P5 = 0x0a               ;Port P5
    mem_000e = 0x0e         
    mem_0014 = 0x14         
    mem_0015 = 0x15         
    mem_0017 = 0x17         
    TB_RB = 0x18            ;Transmit/Receive buffer register
    SIO1CON = 0x1a          ;Serial I/O1 control register
    SIO2 = 0x1f             ;Serial I/O2 register
    PRE12 = 0x20            ;Prescaler 12
    ADCON = 0x34            ;AD/DA control register
    AD = 0x35               ;A-D conversion register
    DA2 = 0x37              ;D-A2 conversion register
    IREQ1 = 0x3c            ;Interrupt request register 1
    IREQ2 = 0x3d            ;Interrupt request register 2
    ICON1 = 0x3e            ;Interrupt control register 1
    ICON2 = 0x3f            ;Interrupt control register 2
    mem_0040 = 0x40         
    mem_0041 = 0x41         
    mem_0042 = 0x42         
    mem_0043 = 0x43         
    mem_0044 = 0x44         
    mem_0045 = 0x45         
    mem_0046 = 0x46         
    mem_004a = 0x4a         
    mem_004c = 0x4c         
    mem_004f = 0x4f         
    mem_0050 = 0x50         
    mem_0051 = 0x51         
    mem_005c = 0x5c         
    mem_005d = 0x5d         
    mem_005e = 0x5e         
    mem_005f = 0x5f         
    mem_0060 = 0x60         
    mem_0061 = 0x61         
    mem_0062 = 0x62         
    mem_0063 = 0x63         
    mem_0064 = 0x64         
    mem_0065 = 0x65         
    mem_0066 = 0x66         
    mem_0067 = 0x67         
    mem_0068 = 0x68         
    mem_0069 = 0x69         
    mem_006a = 0x6a         
    mem_006b = 0x6b         
    mem_006c = 0x6c         
    mem_006d = 0x6d         
    mem_006e = 0x6e         
    mem_0070 = 0x70         
    mem_0071 = 0x71         
    mem_0072 = 0x72         
    mem_0073 = 0x73         
    mem_0076 = 0x76         
    mem_0077 = 0x77         
    mem_0078 = 0x78         
    mem_0079 = 0x79         
    mem_007a = 0x7a         
    mem_007b = 0x7b         
    mem_007c = 0x7c         
    mem_007d = 0x7d         
    mem_007e = 0x7e         
    mem_007f = 0x7f         
    mem_0080 = 0x80         
    mem_0081 = 0x81         
    mem_0082 = 0x82         
    mem_0083 = 0x83         
    mem_0084 = 0x84         
    mem_0085 = 0x85         
    mem_0086 = 0x86         
    mem_0087 = 0x87         
    mem_0088 = 0x88         
    mem_0089 = 0x89         
    mem_008b = 0x8b         
    mem_008c = 0x8c         
    mem_008d = 0x8d         
    mem_0092 = 0x92         
    mem_0093 = 0x93         
    mem_0094 = 0x94         
    mem_0095 = 0x95         
    mem_0098 = 0x98         
    mem_0099 = 0x99         
    mem_009d = 0x9d         
    mem_009e = 0x9e         
    mem_009f = 0x9f         
    mem_00a1 = 0xa1         
    mem_00a2 = 0xa2         
    mem_00a3 = 0xa3         
    mem_00a4 = 0xa4         
    mem_00a5 = 0xa5         
    mem_00a6 = 0xa6         
    mem_00a9 = 0xa9         
    mem_00bb = 0xbb         
    mem_00bc = 0xbc         
    mem_00bf = 0xbf         
    mem_00c0 = 0xc0         
    mem_00c1 = 0xc1         
    mem_00c2 = 0xc2         
    mem_00c3 = 0xc3         
    mem_00c4 = 0xc4         
    mem_00c6 = 0xc6         
    mem_00c7 = 0xc7         
    mem_00c8 = 0xc8         
    mem_00c9 = 0xc9         
    mem_00cd = 0xcd         
    mem_00ce = 0xce         
    mem_00cf = 0xcf         
    mem_00d0 = 0xd0         
    mem_00d1 = 0xd1         
    mem_00d2 = 0xd2         
    mem_00d3 = 0xd3         
    mem_00d4 = 0xd4         
    mem_00d5 = 0xd5         
    mem_00d6 = 0xd6         
    mem_00d7 = 0xd7         
    mem_00d8 = 0xd8         
    mem_00d9 = 0xd9         
    mem_00e1 = 0xe1         
    mem_00e2 = 0xe2         
    mem_00e3 = 0xe3         
    mem_00e6 = 0xe6         
    mem_00e9 = 0xe9         
    mem_00ea = 0xea         
    mem_00ec = 0xec         
    mem_00ed = 0xed         
    mem_00ee = 0xee         
    mem_00f0 = 0xf0         
    mem_00f4 = 0xf4         
    mem_00f5 = 0xf5         
    mem_00f6 = 0xf6         
    mem_00f7 = 0xf7         
    mem_00f8 = 0xf8         
    mem_00f9 = 0xf9         
    mem_00fa = 0xfa         
    mem_00fb = 0xfb         
    mem_00ff = 0xff         
    mem_0100 = 0x100        
    mem_0101 = 0x101        
    mem_0102 = 0x102        
    mem_0103 = 0x103        
    mem_0104 = 0x104        
    mem_0106 = 0x106        
    mem_0107 = 0x107        
    mem_0109 = 0x109        
    mem_0116 = 0x116        
    mem_0117 = 0x117        
    mem_0118 = 0x118        
    mem_0119 = 0x119        
    mem_013c = 0x13c        
    mem_0153 = 0x153        
    mem_083c = 0x83c        
    mem_1400 = 0x1400       
    mem_1919 = 0x1919       
    mem_2068 = 0x2068       
    mem_40f0 = 0x40f0       
    mem_5e20 = 0x5e20       
    mem_6018 = 0x6018       
    mem_800b = 0x800b       
    mem_a99a = 0xa99a       

    .byte 0x4d              ;c000  4d          UNKNOWN 0x4d 'M' 
    .byte 0x33              ;c001  33          UNKNOWN 0x33 '3' 
    .byte 0x38              ;c002  38          UNKNOWN 0x38 '8' 
    .byte 0x32              ;c003  32          UNKNOWN 0x32 '2' 
    .byte 0x32              ;c004  32          UNKNOWN 0x32 '2' 
    .byte 0x58              ;c005  58          UNKNOWN 0x58 'X' 
    .byte 0x20              ;c006  20          UNKNOWN 0x20 ' ' 
    .byte 0x50              ;c007  50          UNKNOWN 0x50 'P' 
    .byte 0x4f              ;c008  4f          UNKNOWN 0x4f 'O' 
    .byte 0x57              ;c009  57          UNKNOWN 0x57 'W' 
    .byte 0x45              ;c00a  45          UNKNOWN 0x45 'E' 
    .byte 0x52              ;c00b  52          UNKNOWN 0x52 'R' 
    .byte 0x20              ;c00c  20          UNKNOWN 0x20 ' ' 
    .byte 0x53              ;c00d  53          UNKNOWN 0x53 'S' 
    .byte 0x45              ;c00e  45          UNKNOWN 0x45 'E' 
    .byte 0x4e              ;c00f  4e          UNKNOWN 0x4e 'N' 
    .byte 0x53              ;c010  53          UNKNOWN 0x53 'S' 
    .byte 0x45              ;c011  45          UNKNOWN 0x45 'E' 
    .byte 0x20              ;c012  20          UNKNOWN 0x20 ' ' 
    .byte 0x4d              ;c013  4d          UNKNOWN 0x4d 'M' 
    .byte 0x49              ;c014  49          UNKNOWN 0x49 'I' 
    .byte 0x43              ;c015  43          UNKNOWN 0x43 'C' 
    .byte 0x4f              ;c016  4f          UNKNOWN 0x4f 'O' 
    .byte 0x4e              ;c017  4e          UNKNOWN 0x4e 'N' 
    .byte 0x20              ;c018  20          UNKNOWN 0x20 ' ' 
    .byte 0x46              ;c019  46          UNKNOWN 0x46 'F' 
    .byte 0x49              ;c01a  49          UNKNOWN 0x49 'I' 
    .byte 0x52              ;c01b  52          UNKNOWN 0x52 'R' 
    .byte 0x4d              ;c01c  4d          UNKNOWN 0x4d 'M' 
    .byte 0x57              ;c01d  57          UNKNOWN 0x57 'W' 
    .byte 0x41              ;c01e  41          UNKNOWN 0x41 'A' 
    .byte 0x52              ;c01f  52          UNKNOWN 0x52 'R' 
    .byte 0x45              ;c020  45          UNKNOWN 0x45 'E' 
    .byte 0x20              ;c021  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c022  52          UNKNOWN 0x52 'R' 
    .byte 0x65              ;c023  65          UNKNOWN 0x65 'e' 
    .byte 0x76              ;c024  76          UNKNOWN 0x76 'v' 
    .byte 0x20              ;c025  20          UNKNOWN 0x20 ' ' 
    .byte 0x38              ;c026  38          UNKNOWN 0x38 '8' 
    .byte 0x20              ;c027  20          UNKNOWN 0x20 ' ' 
    .byte 0x28              ;c028  28          UNKNOWN 0x28 '(' 
    .byte 0x43              ;c029  43          UNKNOWN 0x43 'C' 
    .byte 0x29              ;c02a  29          UNKNOWN 0x29 ')' 
    .byte 0x20              ;c02b  20          UNKNOWN 0x20 ' ' 
    .byte 0x31              ;c02c  31          UNKNOWN 0x31 '1' 
    .byte 0x39              ;c02d  39          UNKNOWN 0x39 '9' 
    .byte 0x39              ;c02e  39          UNKNOWN 0x39 '9' 
    .byte 0x35              ;c02f  35          UNKNOWN 0x35 '5' 
    .byte 0x20              ;c030  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c031  52          UNKNOWN 0x52 'R' 
    .byte 0x49              ;c032  49          UNKNOWN 0x49 'I' 
    .byte 0x4f              ;c033  4f          UNKNOWN 0x4f 'O' 
    .byte 0x53              ;c034  53          UNKNOWN 0x53 'S' 
    .byte 0x20              ;c035  20          UNKNOWN 0x20 ' ' 
    .byte 0x53              ;c036  53          UNKNOWN 0x53 'S' 
    .byte 0x59              ;c037  59          UNKNOWN 0x59 'Y' 
    .byte 0x53              ;c038  53          UNKNOWN 0x53 'S' 
    .byte 0x54              ;c039  54          UNKNOWN 0x54 'T' 
    .byte 0x45              ;c03a  45          UNKNOWN 0x45 'E' 
    .byte 0x4d              ;c03b  4d          UNKNOWN 0x4d 'M' 
    .byte 0x53              ;c03c  53          UNKNOWN 0x53 'S' 
    .byte 0x20              ;c03d  20          UNKNOWN 0x20 ' ' 
    .byte 0x43              ;c03e  43          UNKNOWN 0x43 'C' 
    .byte 0x4f              ;c03f  4f          UNKNOWN 0x4f 'O' 
    .byte 0x2e              ;c040  2e          UNKNOWN 0x2e '.' 
    .byte 0x2c              ;c041  2c          UNKNOWN 0x2c ',' 
    .byte 0x4c              ;c042  4c          UNKNOWN 0x4c 'L' 
    .byte 0x54              ;c043  54          UNKNOWN 0x54 'T' 
    .byte 0x44              ;c044  44          UNKNOWN 0x44 'D' 
    .byte 0x2e              ;c045  2e          UNKNOWN 0x2e '.' 

lab_c046:
    sei                     ;c046  78       
    jsr sub_cc5e            ;c047  20 5e cc 
    bcc lab_c04f            ;c04a  90 03    
    jsr sub_cc98            ;c04c  20 98 cc 

lab_c04f:
    jsr sub_ce4a            ;c04f  20 4a ce 
    cli                     ;c052  58       
    nop                     ;c053  ea       

lab_c054:
    nop                     ;c054  ea       
    bbc 3,ADCON,lab_c054    ;c055  77 34 fc 
    sei                     ;c058  78       
    jsr sub_c1dd            ;c059  20 dd c1 
    jsr sub_ccfc            ;c05c  20 fc cc 
    jsr sub_cd03            ;c05f  20 03 cd 
    jsr sub_cd0d            ;c062  20 0d cd 
    seb 7,mem_0080          ;c065  ef 80    
    clb 7,mem_0051          ;c067  ff 51    
    clb 7,mem_0095          ;c069  ff 95    

lab_c06b:
    cli                     ;c06b  58       
    jsr sub_cd77            ;c06c  20 77 cd 
    bcc lab_c074            ;c06f  90 03    
    jmp lab_cd17            ;c071  4c 17 cd 

lab_c074:
    jsr sub_cda8            ;c074  20 a8 cd 
    jsr sub_cddd            ;c077  20 dd cd 
    bbc 6,mem_0095,lab_c082 ;c07a  d7 95 05 
    jsr sub_dce6            ;c07d  20 e6 dc 
    clb 6,mem_0095          ;c080  df 95    

lab_c082:
    jsr sub_dd63            ;c082  20 63 dd 
    bbc 6,mem_00bf,lab_c08b ;c085  d7 bf 03 
    jsr sub_e200            ;c088  20 00 e2 

lab_c08b:
    jsr sub_e3e3            ;c08b  20 e3 e3 
    jsr sub_c1a3            ;c08e  20 a3 c1 
    bcc lab_c06b            ;c091  90 d8    
    bbc 7,mem_0051,lab_c09c ;c093  f7 51 06 
    bbc 7,mem_0095,lab_c06b ;c096  f7 95 d2 
    jmp lab_c0d8            ;c099  4c d8 c0 

lab_c09c:
    ldm #0x28,mem_00e9      ;c09c  3c 28 e9 
    inc mem_007e            ;c09f  e6 7e    
    jsr sub_c27d            ;c0a1  20 7d c2 
    seb 7,mem_0051          ;c0a4  ef 51    
    jmp 0xc0eb              ;c0a6  4c eb c0 

    .byte 0x78              ;c0a9  78          UNKNOWN 0x78 'x' 
    .byte 0x20              ;c0aa  20          UNKNOWN 0x20 ' ' 
    .byte 0x5e              ;c0ab  5e          UNKNOWN 0x5e '^' 
    .byte 0xcc              ;c0ac  cc          UNKNOWN 0xcc 

lab_c0ad:
    bcc lab_c0b2            ;c0ad  90 03    
    jsr sub_cc98            ;c0af  20 98 cc 

lab_c0b2:
    jsr sub_ce4a            ;c0b2  20 4a ce 
    cli                     ;c0b5  58       

lab_c0b6:
    nop                     ;c0b6  ea       
    bbc 3,ADCON,lab_c0b6    ;c0b7  77 34 fc 
    sei                     ;c0ba  78       
    jsr sub_c1dd            ;c0bb  20 dd c1 
    jsr sub_ccfc            ;c0be  20 fc cc 
    jsr sub_cd03            ;c0c1  20 03 cd 
    jsr sub_cd0d            ;c0c4  20 0d cd 
    seb 7,mem_0080          ;c0c7  ef 80    
    clb 7,mem_0051          ;c0c9  ff 51    
    clb 7,mem_0095          ;c0cb  ff 95    

lab_c0cd:
    cli                     ;c0cd  58       
    jsr sub_cd77            ;c0ce  20 77 cd 
    bcc 0xc0d6              ;c0d1  90 03    
    jmp lab_cd17            ;c0d3  4c 17 cd 

    .byte 0xf7              ;c0d6  f7          UNKNOWN 0xf7 
    .byte 0x51              ;c0d7  51          UNKNOWN 0x51 'Q' 

lab_c0d8:
    bbs 0,a,0xc0fa          ;c0d8  03 20    
    bmi lab_c0ad            ;c0da  30 d1    
    jsr sub_cda8            ;c0dc  20 a8 cd 
    jsr sub_cddd            ;c0df  20 dd cd 
    bbc 6,mem_0095,lab_c0ea ;c0e2  d7 95 05 
    jsr sub_dce6            ;c0e5  20 e6 dc 
    clb 6,mem_0095          ;c0e8  df 95    

lab_c0ea:
    jsr sub_dd63            ;c0ea  20 63 dd 
    bbc 6,mem_00bf,lab_c0f3 ;c0ed  d7 bf 03 
    jsr sub_e200            ;c0f0  20 00 e2 

lab_c0f3:
    jsr sub_e3e3            ;c0f3  20 e3 e3 
    jsr sub_c1a3            ;c0f6  20 a3 c1 
    bcc lab_c0cd            ;c0f9  90 d2    
    bbc 7,mem_0051,lab_c104 ;c0fb  f7 51 06 
    bbc 7,mem_0095,lab_c0cd ;c0fe  f7 95 cc 
    jmp lab_c13a            ;c101  4c 3a c1 

lab_c104:
    ldm #0x28,mem_00e9      ;c104  3c 28 e9 
    bbs 7,mem_006c,lab_c118 ;c107  e7 6c 0e 
    jsr sub_c26b            ;c10a  20 6b c2 
    seb 7,mem_0051          ;c10d  ef 51    
    jsr sub_ca20            ;c10f  20 20 ca 
    jsr sub_d11c            ;c112  20 1c d1 
    jmp 0xc14d              ;c115  4c 4d c1 

lab_c118:
    jsr sub_c396            ;c118  20 96 c3 
    seb 7,mem_0051          ;c11b  ef 51    
    jsr 0xcaca              ;c11d  20 ca ca 
    jmp 0xc14d              ;c120  4c 4d c1 

    .byte 0xa7              ;c123  a7          UNKNOWN 0xa7 
    .byte 0xbf              ;c124  bf          UNKNOWN 0xbf 
    .byte 0x0f              ;c125  0f          UNKNOWN 0x0f 
    .byte 0xa5              ;c126  a5          UNKNOWN 0xa5 
    .byte 0x9d              ;c127  9d          UNKNOWN 0x9d 
    .byte 0xd0              ;c128  d0          UNKNOWN 0xd0 
    .byte 0x0b              ;c129  0b          UNKNOWN 0x0b 
    .byte 0xa5              ;c12a  a5          UNKNOWN 0xa5 
    .byte 0x9e              ;c12b  9e          UNKNOWN 0x9e 
    .byte 0xd0              ;c12c  d0          UNKNOWN 0xd0 
    .byte 0x07              ;c12d  07          UNKNOWN 0x07 
    .byte 0xa5              ;c12e  a5          UNKNOWN 0xa5 
    .byte 0x9f              ;c12f  9f          UNKNOWN 0x9f 
    .byte 0xd0              ;c130  d0          UNKNOWN 0xd0 
    .byte 0x03              ;c131  03          UNKNOWN 0x03 
    .byte 0x08              ;c132  08          UNKNOWN 0x08 
    .byte 0x80              ;c133  80          UNKNOWN 0x80 
    .byte 0x24              ;c134  24          UNKNOWN 0x24 '$' 
    .byte 0x08              ;c135  08          UNKNOWN 0x08 
    .byte 0x78              ;c136  78          UNKNOWN 0x78 'x' 
    .byte 0xe7              ;c137  e7          UNKNOWN 0xe7 
    .byte 0x80              ;c138  80          UNKNOWN 0x80 
    .byte 0x1f              ;c139  1f          UNKNOWN 0x1f 

lab_c13a:
    bbs 0,mem_0080,lab_c159 ;c13a  07 80 1c 
    bbs 5,mem_0080,lab_c159 ;c13d  a7 80 19 
    bbs 4,mem_0080,lab_c159 ;c140  87 80 16 
    bbs 4,mem_0081,lab_c159 ;c143  87 81 13 
    bbs 3,mem_0081,lab_c159 ;c146  67 81 10 
    bbs 2,mem_0081,lab_c159 ;c149  47 81 0d 
    bbs 1,mem_0081,lab_c159 ;c14c  27 81 0a 
    bbs 0,mem_0081,lab_c159 ;c14f  07 81 07 
    bbs 7,mem_0081,lab_c159 ;c152  e7 81 04 
    plp                     ;c155  28       
    nop                     ;c156  ea       
    sec                     ;c157  38       
    rts                     ;c158  60       

lab_c159:
    plp                     ;c159  28       
    nop                     ;c15a  ea       
    clc                     ;c15b  18       
    rts                     ;c15c  60       

    .byte 0xa9              ;c15d  a9          UNKNOWN 0xa9 
    .byte 0x08              ;c15e  08          UNKNOWN 0x08 
    .byte 0xe7              ;c15f  e7          UNKNOWN 0xe7 
    .byte 0x50              ;c160  50          UNKNOWN 0x50 'P' 
    .byte 0x07              ;c161  07          UNKNOWN 0x07 
    .byte 0xa9              ;c162  a9          UNKNOWN 0xa9 
    .byte 0x04              ;c163  04          UNKNOWN 0x04 
    .byte 0xc7              ;c164  c7          UNKNOWN 0xc7 
    .byte 0x50              ;c165  50          UNKNOWN 0x50 'P' 
    .byte 0x02              ;c166  02          UNKNOWN 0x02 
    .byte 0xa9              ;c167  a9          UNKNOWN 0xa9 
    .byte 0x00              ;c168  00          UNKNOWN 0x00 
    .byte 0xf7              ;c169  f7          UNKNOWN 0xf7 
    .byte 0x6c              ;c16a  6c          UNKNOWN 0x6c 'l' 
    .byte 0x05              ;c16b  05          UNKNOWN 0x05 
    .byte 0x18              ;c16c  18          UNKNOWN 0x18 
    .byte 0x69              ;c16d  69          UNKNOWN 0x69 'i' 
    .byte 0x03              ;c16e  03          UNKNOWN 0x03 
    .byte 0x80              ;c16f  80          UNKNOWN 0x80 
    .byte 0x13              ;c170  13          UNKNOWN 0x13 
    .byte 0x48              ;c171  48          UNKNOWN 0x48 'H' 
    .byte 0x20              ;c172  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c173  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;c174  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;c175  d0          UNKNOWN 0xd0 
    .byte 0x06              ;c176  06          UNKNOWN 0x06 
    .byte 0x68              ;c177  68          UNKNOWN 0x68 'h' 
    .byte 0x18              ;c178  18          UNKNOWN 0x18 
    .byte 0x69              ;c179  69          UNKNOWN 0x69 'i' 
    .byte 0x01              ;c17a  01          UNKNOWN 0x01 
    .byte 0x80              ;c17b  80          UNKNOWN 0x80 
    .byte 0x07              ;c17c  07          UNKNOWN 0x07 
    .byte 0x68              ;c17d  68          UNKNOWN 0x68 'h' 
    .byte 0x17              ;c17e  17          UNKNOWN 0x17 
    .byte 0x6d              ;c17f  6d          UNKNOWN 0x6d 'm' 
    .byte 0x03              ;c180  03          UNKNOWN 0x03 
    .byte 0x18              ;c181  18          UNKNOWN 0x18 
    .byte 0x69              ;c182  69          UNKNOWN 0x69 'i' 
    .byte 0x02              ;c183  02          UNKNOWN 0x02 
    .byte 0x0a              ;c184  0a          UNKNOWN 0x0a 
    .byte 0xaa              ;c185  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;c186  bd          UNKNOWN 0xbd 
    .byte 0x13              ;c187  13          UNKNOWN 0x13 
    .byte 0xc2              ;c188  c2          UNKNOWN 0xc2 
    .byte 0x85              ;c189  85          UNKNOWN 0x85 
    .byte 0xf5              ;c18a  f5          UNKNOWN 0xf5 
    .byte 0xbd              ;c18b  bd          UNKNOWN 0xbd 
    .byte 0x14              ;c18c  14          UNKNOWN 0x14 
    .byte 0xc2              ;c18d  c2          UNKNOWN 0xc2 
    .byte 0x85              ;c18e  85          UNKNOWN 0x85 
    .byte 0xf6              ;c18f  f6          UNKNOWN 0xf6 
    .byte 0x02              ;c190  02          UNKNOWN 0x02 
    .byte 0xf5              ;c191  f5          UNKNOWN 0xf5 
    .byte 0x60              ;c192  60          UNKNOWN 0x60 '`' 
    .byte 0x4b              ;c193  4b          UNKNOWN 0x4b 'K' 
    .byte 0xc2              ;c194  c2          UNKNOWN 0xc2 
    .byte 0x3b              ;c195  3b          UNKNOWN 0x3b ';' 
    .byte 0xc2              ;c196  c2          UNKNOWN 0xc2 
    .byte 0x4b              ;c197  4b          UNKNOWN 0x4b 'K' 
    .byte 0xc2              ;c198  c2          UNKNOWN 0xc2 
    .byte 0x5b              ;c199  5b          UNKNOWN 0x5b '[' 
    .byte 0xc2              ;c19a  c2          UNKNOWN 0xc2 
    .byte 0x4b              ;c19b  4b          UNKNOWN 0x4b 'K' 
    .byte 0xc2              ;c19c  c2          UNKNOWN 0xc2 
    .byte 0x3b              ;c19d  3b          UNKNOWN 0x3b ';' 
    .byte 0xc2              ;c19e  c2          UNKNOWN 0xc2 
    .byte 0x4b              ;c19f  4b          UNKNOWN 0x4b 'K' 
    .byte 0xc2              ;c1a0  c2          UNKNOWN 0xc2 
    .byte 0x5b              ;c1a1  5b          UNKNOWN 0x5b '[' 
    .byte 0xc2              ;c1a2  c2          UNKNOWN 0xc2 

sub_c1a3:
    seb 2,a                 ;c1a3  4b       
    wit                     ;c1a4  c2       
    clb 1,a                 ;c1a5  3b       
    wit                     ;c1a6  c2       
    seb 1,a                 ;c1a7  2b       
    wit                     ;c1a8  c2       
    clb 2,a                 ;c1a9  5b       
    wit                     ;c1aa  c2       
    ldm #0x01,mem_005d      ;c1ab  3c 01 5d 
    ldm #0x00,mem_005e      ;c1ae  3c 00 5e 
    ldm #0x00,mem_005f      ;c1b1  3c 00 5f 
    ldm #0x04,mem_0060      ;c1b4  3c 04 60 
    ldm #0x02,mem_0061      ;c1b7  3c 02 61 
    rts                     ;c1ba  60       

    .byte 0x3c              ;c1bb  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c1bc  00          UNKNOWN 0x00 
    .byte 0x5d              ;c1bd  5d          UNKNOWN 0x5d ']' 
    .byte 0x3c              ;c1be  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c1bf  00          UNKNOWN 0x00 
    .byte 0x5e              ;c1c0  5e          UNKNOWN 0x5e '^' 
    .byte 0x3c              ;c1c1  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c1c2  00          UNKNOWN 0x00 
    .byte 0x5f              ;c1c3  5f          UNKNOWN 0x5f '_' 
    .byte 0x3c              ;c1c4  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c1c5  00          UNKNOWN 0x00 
    .byte 0x60              ;c1c6  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c1c7  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;c1c8  02          UNKNOWN 0x02 
    .byte 0x61              ;c1c9  61          UNKNOWN 0x61 'a' 
    .byte 0x60              ;c1ca  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c1cb  3c          UNKNOWN 0x3c '<' 
    .byte 0x01              ;c1cc  01          UNKNOWN 0x01 
    .byte 0x5d              ;c1cd  5d          UNKNOWN 0x5d ']' 
    .byte 0x3c              ;c1ce  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c1cf  00          UNKNOWN 0x00 
    .byte 0x5e              ;c1d0  5e          UNKNOWN 0x5e '^' 
    .byte 0x3c              ;c1d1  3c          UNKNOWN 0x3c '<' 
    .byte 0x01              ;c1d2  01          UNKNOWN 0x01 
    .byte 0x5f              ;c1d3  5f          UNKNOWN 0x5f '_' 
    .byte 0x3c              ;c1d4  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c1d5  00          UNKNOWN 0x00 
    .byte 0x60              ;c1d6  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c1d7  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;c1d8  02          UNKNOWN 0x02 
    .byte 0x61              ;c1d9  61          UNKNOWN 0x61 'a' 
    .byte 0x60              ;c1da  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c1db  3c          UNKNOWN 0x3c '<' 
    .byte 0x7f              ;c1dc  7f          UNKNOWN 0x7f 

sub_c1dd:
    eor IREQ1,x             ;c1dd  5d 3c 00 
    lsr mem_013c,x          ;c1e0  5e 3c 01 
    clb 2,IREQ1             ;c1e3  5f 3c    
    brk                     ;c1e5  00       

    .byte 0x60              ;c1e6  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c1e7  3c          UNKNOWN 0x3c '<' 
    .byte 0x7f              ;c1e8  7f          UNKNOWN 0x7f 
    .byte 0x61              ;c1e9  61          UNKNOWN 0x61 'a' 
    .byte 0x60              ;c1ea  60          UNKNOWN 0x60 '`' 
    .byte 0xe7              ;c1eb  e7          UNKNOWN 0xe7 
    .byte 0x6c              ;c1ec  6c          UNKNOWN 0x6c 'l' 
    .byte 0x0b              ;c1ed  0b          UNKNOWN 0x0b 
    .byte 0xf7              ;c1ee  f7          UNKNOWN 0xf7 
    .byte 0x50              ;c1ef  50          UNKNOWN 0x50 'P' 
    .byte 0x04              ;c1f0  04          UNKNOWN 0x04 
    .byte 0x20              ;c1f1  20          UNKNOWN 0x20 ' ' 
    .byte 0x7d              ;c1f2  7d          UNKNOWN 0x7d '}' 
    .byte 0xc2              ;c1f3  c2          UNKNOWN 0xc2 
    .byte 0x60              ;c1f4  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;c1f5  20          UNKNOWN 0x20 ' ' 
    .byte 0x49              ;c1f6  49          UNKNOWN 0x49 'I' 
    .byte 0xc3              ;c1f7  c3          UNKNOWN 0xc3 
    .byte 0x60              ;c1f8  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;c1f9  20          UNKNOWN 0x20 ' ' 
    .byte 0x96              ;c1fa  96          UNKNOWN 0x96 
    .byte 0xc3              ;c1fb  c3          UNKNOWN 0xc3 
    .byte 0x60              ;c1fc  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;c1fd  20          UNKNOWN 0x20 ' ' 
    .byte 0x06              ;c1fe  06          UNKNOWN 0x06 
    .byte 0xc4              ;c1ff  c4          UNKNOWN 0xc4 
    .byte 0xa5              ;c200  a5          UNKNOWN 0xa5 
    .byte 0x65              ;c201  65          UNKNOWN 0x65 'e' 
    .byte 0x17              ;c202  17          UNKNOWN 0x17 
    .byte 0x6d              ;c203  6d          UNKNOWN 0x6d 'm' 
    .byte 0x1c              ;c204  1c          UNKNOWN 0x1c 
    .byte 0x20              ;c205  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c206  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;c207  d0          UNKNOWN 0xd0 
    .byte 0x08              ;c208  08          UNKNOWN 0x08 
    .byte 0xa9              ;c209  a9          UNKNOWN 0xa9 
    .byte 0x00              ;c20a  00          UNKNOWN 0x00 
    .byte 0x28              ;c20b  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c20c  ea          UNKNOWN 0xea 
    .byte 0xf0              ;c20d  f0          UNKNOWN 0xf0 
    .byte 0x12              ;c20e  12          UNKNOWN 0x12 
    .byte 0xa0              ;c20f  a0          UNKNOWN 0xa0 
    .byte 0x04              ;c210  04          UNKNOWN 0x04 
    .byte 0xf0              ;c211  f0          UNKNOWN 0xf0 
    .byte 0x0e              ;c212  0e          UNKNOWN 0x0e 
    .byte 0x98              ;c213  98          UNKNOWN 0x98 
    .byte 0x4a              ;c214  4a          UNKNOWN 0x4a 'J' 
    .byte 0xa8              ;c215  a8          UNKNOWN 0xa8 
    .byte 0xf0              ;c216  f0          UNKNOWN 0xf0 
    .byte 0x07              ;c217  07          UNKNOWN 0x07 
    .byte 0x46              ;c218  46          UNKNOWN 0x46 'F' 
    .byte 0x67              ;c219  67          UNKNOWN 0x67 'g' 
    .byte 0x66              ;c21a  66          UNKNOWN 0x66 'f' 
    .byte 0x66              ;c21b  66          UNKNOWN 0x66 'f' 
    .byte 0x88              ;c21c  88          UNKNOWN 0x88 
    .byte 0xd0              ;c21d  d0          UNKNOWN 0xd0 
    .byte 0xf9              ;c21e  f9          UNKNOWN 0xf9 
    .byte 0xa5              ;c21f  a5          UNKNOWN 0xa5 
    .byte 0x66              ;c220  66          UNKNOWN 0x66 'f' 
    .byte 0x85              ;c221  85          UNKNOWN 0x85 
    .byte 0x70              ;c222  70          UNKNOWN 0x70 'p' 
    .byte 0x20              ;c223  20          UNKNOWN 0x20 ' ' 
    .byte 0xa5              ;c224  a5          UNKNOWN 0xa5 
    .byte 0xcc              ;c225  cc          UNKNOWN 0xcc 
    .byte 0x90              ;c226  90          UNKNOWN 0x90 
    .byte 0x02              ;c227  02          UNKNOWN 0x02 
    .byte 0x80              ;c228  80          UNKNOWN 0x80 
    .byte 0x3c              ;c229  3c          UNKNOWN 0x3c '<' 
    .byte 0x20              ;c22a  20          UNKNOWN 0x20 ' ' 
    .byte 0x10              ;c22b  10          UNKNOWN 0x10 
    .byte 0xc4              ;c22c  c4          UNKNOWN 0xc4 
    .byte 0xb0              ;c22d  b0          UNKNOWN 0xb0 
    .byte 0x37              ;c22e  37          UNKNOWN 0x37 '7' 
    .byte 0x07              ;c22f  07          UNKNOWN 0x07 
    .byte 0x6d              ;c230  6d          UNKNOWN 0x6d 'm' 
    .byte 0x16              ;c231  16          UNKNOWN 0x16 
    .byte 0xa5              ;c232  a5          UNKNOWN 0xa5 
    .byte 0x70              ;c233  70          UNKNOWN 0x70 'p' 
    .byte 0xc9              ;c234  c9          UNKNOWN 0xc9 
    .byte 0x04              ;c235  04          UNKNOWN 0x04 
    .byte 0xb0              ;c236  b0          UNKNOWN 0xb0 
    .byte 0x10              ;c237  10          UNKNOWN 0x10 
    .byte 0xa5              ;c238  a5          UNKNOWN 0xa5 
    .byte 0x5a              ;c239  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x18              ;c23a  18          UNKNOWN 0x18 
    .byte 0x69              ;c23b  69          UNKNOWN 0x69 'i' 
    .byte 0x01              ;c23c  01          UNKNOWN 0x01 
    .byte 0x85              ;c23d  85          UNKNOWN 0x85 
    .byte 0x5a              ;c23e  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x90              ;c23f  90          UNKNOWN 0x90 
    .byte 0x25              ;c240  25          UNKNOWN 0x25 '%' 
    .byte 0xa9              ;c241  a9          UNKNOWN 0xa9 
    .byte 0x00              ;c242  00          UNKNOWN 0x00 
    .byte 0x48              ;c243  48          UNKNOWN 0x48 'H' 
    .byte 0xa9              ;c244  a9          UNKNOWN 0xa9 
    .byte 0x01              ;c245  01          UNKNOWN 0x01 
    .byte 0x80              ;c246  80          UNKNOWN 0x80 
    .byte 0x06              ;c247  06          UNKNOWN 0x06 
    .byte 0xa2              ;c248  a2          UNKNOWN 0xa2 
    .byte 0x00              ;c249  00          UNKNOWN 0x00 
    .byte 0xa9              ;c24a  a9          UNKNOWN 0xa9 
    .byte 0x10              ;c24b  10          UNKNOWN 0x10 
    .byte 0x62              ;c24c  62          UNKNOWN 0x62 'b' 
    .byte 0x70              ;c24d  70          UNKNOWN 0x70 'p' 
    .byte 0xa0              ;c24e  a0          UNKNOWN 0xa0 
    .byte 0x5b              ;c24f  5b          UNKNOWN 0x5b '[' 
    .byte 0x20              ;c250  20          UNKNOWN 0x20 ' ' 
    .byte 0x9d              ;c251  9d          UNKNOWN 0x9d 
    .byte 0xe6              ;c252  e6          UNKNOWN 0xe6 
    .byte 0xb0              ;c253  b0          UNKNOWN 0xb0 
    .byte 0x03              ;c254  03          UNKNOWN 0x03 
    .byte 0x20              ;c255  20          UNKNOWN 0x20 ' ' 
    .byte 0xea              ;c256  ea          UNKNOWN 0xea 
    .byte 0xc2              ;c257  c2          UNKNOWN 0xc2 
    .byte 0x68              ;c258  68          UNKNOWN 0x68 'h' 
    .byte 0x85              ;c259  85          UNKNOWN 0x85 
    .byte 0xf7              ;c25a  f7          UNKNOWN 0xf7 
    .byte 0xa5              ;c25b  a5          UNKNOWN 0xa5 
    .byte 0x5c              ;c25c  5c          UNKNOWN 0x5c '\' 
    .byte 0xe5              ;c25d  e5          UNKNOWN 0xe5 
    .byte 0xf7              ;c25e  f7          UNKNOWN 0xf7 
    .byte 0x85              ;c25f  85          UNKNOWN 0x85 
    .byte 0x5c              ;c260  5c          UNKNOWN 0x5c '\' 
    .byte 0xb0              ;c261  b0          UNKNOWN 0xb0 
    .byte 0x03              ;c262  03          UNKNOWN 0x03 
    .byte 0x20              ;c263  20          UNKNOWN 0x20 ' ' 
    .byte 0xea              ;c264  ea          UNKNOWN 0xea 
    .byte 0xc2              ;c265  c2          UNKNOWN 0xc2 
    .byte 0x20              ;c266  20          UNKNOWN 0x20 ' ' 
    .byte 0xa1              ;c267  a1          UNKNOWN 0xa1 
    .byte 0xc7              ;c268  c7          UNKNOWN 0xc7 
    .byte 0x60              ;c269  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;c26a  20          UNKNOWN 0x20 ' ' 

sub_c26b:
    ora [mem_00c3],y        ;c26b  11 c3    
    ldy #0x5b               ;c26d  a0 5b    
    jsr 0xe669              ;c26f  20 69 e6 
    jsr sub_c31d            ;c272  20 1d c3 
    adc mem_005c            ;c275  65 5c    
    sta mem_005c            ;c277  85 5c    
    lda mem_006e            ;c279  a5 6e    
    beq lab_c280            ;c27b  f0 03    

sub_c27d:
    dec a                   ;c27d  1a       
    sta mem_006e            ;c27e  85 6e    

lab_c280:
    bbs 3,a,lab_c2a2        ;c280  63 20    
    .byte 0x52              ;c282  52       Illegal instruction

    .byte 0xd0              ;c283  d0          UNKNOWN 0xd0 
    .byte 0x0a              ;c284  0a          UNKNOWN 0x0a 
    .byte 0xaa              ;c285  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;c286  bd          UNKNOWN 0xbd 
    .byte 0x29              ;c287  29          UNKNOWN 0x29 ')' 
    .byte 0xc3              ;c288  c3          UNKNOWN 0xc3 
    .byte 0x85              ;c289  85          UNKNOWN 0x85 
    .byte 0x5b              ;c28a  5b          UNKNOWN 0x5b '[' 
    .byte 0xbd              ;c28b  bd          UNKNOWN 0xbd 
    .byte 0x2a              ;c28c  2a          UNKNOWN 0x2a '*' 
    .byte 0xc3              ;c28d  c3          UNKNOWN 0xc3 
    .byte 0x85              ;c28e  85          UNKNOWN 0x85 
    .byte 0x5c              ;c28f  5c          UNKNOWN 0x5c '\' 
    .byte 0x62              ;c290  62          UNKNOWN 0x62 'b' 
    .byte 0x08              ;c291  08          UNKNOWN 0x08 
    .byte 0x20              ;c292  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c293  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;c294  d0          UNKNOWN 0xd0 
    .byte 0x0a              ;c295  0a          UNKNOWN 0x0a 
    .byte 0xaa              ;c296  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;c297  bd          UNKNOWN 0xbd 
    .byte 0x29              ;c298  29          UNKNOWN 0x29 ')' 
    .byte 0xc3              ;c299  c3          UNKNOWN 0xc3 
    .byte 0x28              ;c29a  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c29b  ea          UNKNOWN 0xea 
    .byte 0x60              ;c29c  60          UNKNOWN 0x60 '`' 
    .byte 0x08              ;c29d  08          UNKNOWN 0x08 
    .byte 0x20              ;c29e  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c29f  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;c2a0  d0          UNKNOWN 0xd0 
    .byte 0x0a              ;c2a1  0a          UNKNOWN 0x0a 

lab_c2a2:
    tax                     ;c2a2  aa       
    lda mem_c32a,x          ;c2a3  bd 2a c3 
    plp                     ;c2a6  28       
    nop                     ;c2a7  ea       
    rts                     ;c2a8  60       

    .byte 0x28              ;c2a9  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2aa  a0          UNKNOWN 0xa0 
    .byte 0x28              ;c2ab  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2ac  a0          UNKNOWN 0xa0 
    .byte 0x28              ;c2ad  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2ae  a0          UNKNOWN 0xa0 
    .byte 0x28              ;c2af  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2b0  a0          UNKNOWN 0xa0 
    .byte 0x28              ;c2b1  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2b2  a0          UNKNOWN 0xa0 
    .byte 0xa0              ;c2b3  a0          UNKNOWN 0xa0 
    .byte 0x8c              ;c2b4  8c          UNKNOWN 0x8c 
    .byte 0x28              ;c2b5  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2b6  a0          UNKNOWN 0xa0 
    .byte 0x28              ;c2b7  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2b8  a0          UNKNOWN 0xa0 
    .byte 0x28              ;c2b9  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2ba  a0          UNKNOWN 0xa0 
    .byte 0x58              ;c2bb  58          UNKNOWN 0x58 'X' 
    .byte 0x98              ;c2bc  98          UNKNOWN 0x98 
    .byte 0xfa              ;c2bd  fa          UNKNOWN 0xfa 
    .byte 0xff              ;c2be  ff          UNKNOWN 0xff 
    .byte 0xc0              ;c2bf  c0          UNKNOWN 0xc0 
    .byte 0xa8              ;c2c0  a8          UNKNOWN 0xa8 
    .byte 0x28              ;c2c1  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2c2  a0          UNKNOWN 0xa0 
    .byte 0x80              ;c2c3  80          UNKNOWN 0x80 
    .byte 0x70              ;c2c4  70          UNKNOWN 0x70 'p' 
    .byte 0x28              ;c2c5  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2c6  a0          UNKNOWN 0xa0 
    .byte 0x28              ;c2c7  28          UNKNOWN 0x28 '(' 
    .byte 0xa0              ;c2c8  a0          UNKNOWN 0xa0 
    .byte 0x20              ;c2c9  20          UNKNOWN 0x20 ' ' 
    .byte 0x06              ;c2ca  06          UNKNOWN 0x06 
    .byte 0xc4              ;c2cb  c4          UNKNOWN 0xc4 
    .byte 0x20              ;c2cc  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c2cd  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;c2ce  d0          UNKNOWN 0xd0 
    .byte 0x08              ;c2cf  08          UNKNOWN 0x08 
    .byte 0xa9              ;c2d0  a9          UNKNOWN 0xa9 
    .byte 0x00              ;c2d1  00          UNKNOWN 0x00 
    .byte 0x28              ;c2d2  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c2d3  ea          UNKNOWN 0xea 
    .byte 0xf0              ;c2d4  f0          UNKNOWN 0xf0 
    .byte 0x02              ;c2d5  02          UNKNOWN 0x02 
    .byte 0xa5              ;c2d6  a5          UNKNOWN 0xa5 
    .byte 0x65              ;c2d7  65          UNKNOWN 0x65 'e' 
    .byte 0x85              ;c2d8  85          UNKNOWN 0x85 
    .byte 0x70              ;c2d9  70          UNKNOWN 0x70 'p' 
    .byte 0x20              ;c2da  20          UNKNOWN 0x20 ' ' 
    .byte 0xa5              ;c2db  a5          UNKNOWN 0xa5 
    .byte 0xcc              ;c2dc  cc          UNKNOWN 0xcc 
    .byte 0x90              ;c2dd  90          UNKNOWN 0x90 
    .byte 0x02              ;c2de  02          UNKNOWN 0x02 
    .byte 0x80              ;c2df  80          UNKNOWN 0x80 
    .byte 0x31              ;c2e0  31          UNKNOWN 0x31 '1' 
    .byte 0x20              ;c2e1  20          UNKNOWN 0x20 ' ' 
    .byte 0x10              ;c2e2  10          UNKNOWN 0x10 
    .byte 0xc4              ;c2e3  c4          UNKNOWN 0xc4 
    .byte 0xb0              ;c2e4  b0          UNKNOWN 0xb0 
    .byte 0x80              ;c2e5  80          UNKNOWN 0x80 
    .byte 0xa5              ;c2e6  a5          UNKNOWN 0xa5 
    .byte 0x70              ;c2e7  70          UNKNOWN 0x70 'p' 
    .byte 0xc9              ;c2e8  c9          UNKNOWN 0xc9 
    .byte 0x04              ;c2e9  04          UNKNOWN 0x04 
    .byte 0x90              ;c2ea  90          UNKNOWN 0x90 
    .byte 0x03              ;c2eb  03          UNKNOWN 0x03 
    .byte 0x4c              ;c2ec  4c          UNKNOWN 0x4c 'L' 
    .byte 0xc8              ;c2ed  c8          UNKNOWN 0xc8 
    .byte 0xc2              ;c2ee  c2          UNKNOWN 0xc2 
    .byte 0x07              ;c2ef  07          UNKNOWN 0x07 
    .byte 0x6d              ;c2f0  6d          UNKNOWN 0x6d 'm' 
    .byte 0x0d              ;c2f1  0d          UNKNOWN 0x0d 
    .byte 0xa5              ;c2f2  a5          UNKNOWN 0xa5 
    .byte 0x5a              ;c2f3  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x18              ;c2f4  18          UNKNOWN 0x18 
    .byte 0x69              ;c2f5  69          UNKNOWN 0x69 'i' 
    .byte 0x01              ;c2f6  01          UNKNOWN 0x01 
    .byte 0x85              ;c2f7  85          UNKNOWN 0x85 
    .byte 0x5a              ;c2f8  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x90              ;c2f9  90          UNKNOWN 0x90 
    .byte 0x17              ;c2fa  17          UNKNOWN 0x17 
    .byte 0xa9              ;c2fb  a9          UNKNOWN 0xa9 
    .byte 0x01              ;c2fc  01          UNKNOWN 0x01 
    .byte 0x80              ;c2fd  80          UNKNOWN 0x80 
    .byte 0x09              ;c2fe  09          UNKNOWN 0x09 
    .byte 0xa2              ;c2ff  a2          UNKNOWN 0xa2 
    .byte 0x00              ;c300  00          UNKNOWN 0x00 

sub_c301:
    lda #0x13               ;c301  a9 13    
    bbs 6,mem_0050,lab_c308 ;c303  c7 50 02 
    lda #0x02               ;c306  a9 02    

lab_c308:
    ldy #0x5b               ;c308  a0 5b    
    jsr sub_e69d            ;c30a  20 9d e6 
    bcs lab_c312            ;c30d  b0 03    

    .byte 0x20              ;c30f  20          UNKNOWN 0x20 ' ' 
    .byte 0xea              ;c310  ea          UNKNOWN 0xea 

sub_c311:
    wit                     ;c311  c2       

lab_c312:
    jsr sub_c7a1            ;c312  20 a1 c7 
    rts                     ;c315  60       

    .byte 0x20              ;c316  20          UNKNOWN 0x20 ' ' 
    .byte 0x06              ;c317  06          UNKNOWN 0x06 
    .byte 0xc4              ;c318  c4          UNKNOWN 0xc4 
    .byte 0xa5              ;c319  a5          UNKNOWN 0xa5 
    .byte 0x62              ;c31a  62          UNKNOWN 0x62 'b' 
    .byte 0xd0              ;c31b  d0          UNKNOWN 0xd0 
    .byte 0x09              ;c31c  09          UNKNOWN 0x09 

sub_c31d:
    lda mem_0063            ;c31d  a5 63    
    bne lab_c326            ;c31f  d0 05    
    lda #0x01               ;c321  a9 01    
    pha                     ;c323  48       
    bra lab_c32c            ;c324  80 06    

lab_c326:
    ldx #0x00               ;c326  a2 00    
    lda #0x7f               ;c328  a9 7f    

mem_c32a:
    div mem_0062,x          ;c32a  e2 62    

lab_c32c:
    sta mem_0070            ;c32c  85 70    
    pla                     ;c32e  68       
    lda mem_0068            ;c32f  a5 68    
    bne lab_c33c            ;c331  d0 09    
    lda mem_0069            ;c333  a5 69    
    bne lab_c33c            ;c335  d0 05    
    lda #0x01               ;c337  a9 01    
    pha                     ;c339  48       
    bra lab_c342            ;c33a  80 06    

lab_c33c:
    ldx #0x00               ;c33c  a2 00    
    lda #0x7f               ;c33e  a9 7f    
    div mem_0068,x          ;c340  e2 68    

lab_c342:
    sta mem_0071            ;c342  85 71    
    pla                     ;c344  68       
    jsr sub_cca5            ;c345  20 a5 cc 
    bcs lab_c382            ;c348  b0 38    
    lda mem_0070            ;c34a  a5 70    
    cmp #0x03               ;c34c  c9 03    
    bcc lab_c382            ;c34e  90 32    
    ldx #0x00               ;c350  a2 00    
    lda #0x0f               ;c352  a9 0f    
    bbs 6,mem_006c,lab_c359 ;c354  c7 6c 02 
    lda #0x10               ;c357  a9 10    

lab_c359:
    mul mem_0070,x          ;c359  62 70    
    ldy #0x5b               ;c35b  a0 5b    
    jsr 0xe669              ;c35d  20 69 e6 
    pla                     ;c360  68       
    adc mem_005c            ;c361  65 5c    
    sta mem_005c            ;c363  85 5c    
    jsr sub_c31d            ;c365  20 1d c3 
    inc a                   ;c368  3a       
    cmp mem_005c            ;c369  c5 5c    
    bcs lab_c382            ;c36b  b0 15    
    inc mem_006e            ;c36d  e6 6e    
    jsr sub_c311            ;c36f  20 11 c3 
    ldy #0x5b               ;c372  a0 5b    
    jsr sub_e69d            ;c374  20 9d e6 
    jsr sub_c31d            ;c377  20 1d c3 
    sta mem_00f9            ;c37a  85 f9    
    lda mem_005c            ;c37c  a5 5c    
    sbc mem_00f9            ;c37e  e5 f9    
    sta mem_005c            ;c380  85 5c    

lab_c382:
    jsr sub_c7a1            ;c382  20 a1 c7 
    rts                     ;c385  60       

    .byte 0x20              ;c386  20          UNKNOWN 0x20 ' ' 
    .byte 0x9e              ;c387  9e          UNKNOWN 0x9e 
    .byte 0xe3              ;c388  e3          UNKNOWN 0xe3 
    .byte 0x20              ;c389  20          UNKNOWN 0x20 ' ' 
    .byte 0x80              ;c38a  80          UNKNOWN 0x80 
    .byte 0xc6              ;c38b  c6          UNKNOWN 0xc6 
    .byte 0x20              ;c38c  20          UNKNOWN 0x20 ' ' 
    .byte 0xef              ;c38d  ef          UNKNOWN 0xef 
    .byte 0xc6              ;c38e  c6          UNKNOWN 0xc6 
    .byte 0x60              ;c38f  60          UNKNOWN 0x60 '`' 
    .byte 0x37              ;c390  37          UNKNOWN 0x37 '7' 
    .byte 0xc0              ;c391  c0          UNKNOWN 0xc0 
    .byte 0x03              ;c392  03          UNKNOWN 0x03 

lab_c393:
    jmp lab_c4ff            ;c393  4c ff c4 

sub_c396:
    jsr sub_c5f9            ;c396  20 f9 c5 
    bcs lab_c393            ;c399  b0 f8    
    jsr sub_d052            ;c39b  20 52 d0 
    pha                     ;c39e  48       
    jsr sub_e589            ;c39f  20 89 e5 
    sta mem_00fb            ;c3a2  85 fb    
    pla                     ;c3a4  68       
    cmp #0x09               ;c3a5  c9 09    
    beq lab_c3ed            ;c3a7  f0 44    
    cmp #0x0a               ;c3a9  c9 0a    
    beq lab_c3ed            ;c3ab  f0 40    
    cmp #0x08               ;c3ad  c9 08    
    beq lab_c3bf            ;c3af  f0 0e    
    cmp #0x05               ;c3b1  c9 05    
    bne lab_c3bf            ;c3b3  d0 0a    
    lda mem_00c8            ;c3b5  a5 c8    
    beq lab_c3e5            ;c3b7  f0 2c    
    cmp #0x01               ;c3b9  c9 01    
    beq lab_c3dd            ;c3bb  f0 20    
    bra lab_c3e5            ;c3bd  80 26    

lab_c3bf:
    bbs 7,mem_00c2,lab_c3cd ;c3bf  e7 c2 0b 
    bbs 6,mem_00c2,lab_c3d5 ;c3c2  c7 c2 10 
    ldm #0x0d,mem_00f5      ;c3c5  3c 0d f5 
    ldm #0xc5,mem_00f6      ;c3c8  3c c5 f6 
    bra lab_c40b            ;c3cb  80 3e    

lab_c3cd:
    ldm #0x23,mem_00f5      ;c3cd  3c 23 f5 
    ldm #0xc5,mem_00f6      ;c3d0  3c c5 f6 
    bra lab_c40b            ;c3d3  80 36    

lab_c3d5:
    ldm #0x16,mem_00f5      ;c3d5  3c 16 f5 
    ldm #0xc5,mem_00f6      ;c3d8  3c c5 f6 
    bra lab_c40b            ;c3db  80 2e    

lab_c3dd:
    ldm #0x74,mem_00f5      ;c3dd  3c 74 f5 
    ldm #0xc5,mem_00f6      ;c3e0  3c c5 f6 
    bra lab_c40b            ;c3e3  80 26    

lab_c3e5:
    ldm #0x6b,mem_00f5      ;c3e5  3c 6b f5 
    ldm #0xc5,mem_00f6      ;c3e8  3c c5 f6 
    bra lab_c40b            ;c3eb  80 1e    

lab_c3ed:
    bbs 7,mem_00c2,lab_c3fb ;c3ed  e7 c2 0b 
    bbs 6,mem_00c2,lab_c403 ;c3f0  c7 c2 10 
    ldm #0x52,mem_00f5      ;c3f3  3c 52 f5 
    ldm #0xc5,mem_00f6      ;c3f6  3c c5 f6 
    bra lab_c40b            ;c3f9  80 10    

lab_c3fb:
    ldm #0x3c,mem_00f5      ;c3fb  3c 3c f5 
    ldm #0xc5,mem_00f6      ;c3fe  3c c5 f6 
    bra lab_c40b            ;c401  80 08    

lab_c403:
    ldm #0x45,mem_00f5      ;c403  3c 45 f5 
    ldm #0xc5,mem_00f6      ;c406  3c c5 f6 
    bra lab_c40b            ;c409  80 00    

lab_c40b:
    ldy #0x00               ;c40b  a0 00    
    ldm #0x06,mem_00f9      ;c40d  3c 06 f9 
    bbc 0,mem_006d,lab_c429 ;c410  17 6d 16 
    ldx #0x00               ;c413  a2 00    
    lda mem_006b            ;c415  a5 6b    
    mul mem_006a,x          ;c417  62 6a    
    pla                     ;c419  68       
    cmp #0x7c               ;c41a  c9 7c    
    bcc lab_c420            ;c41c  90 02    
    lda #0x7b               ;c41e  a9 7b    

lab_c420:
    tax                     ;c420  aa       
    lda mem_c57d,x          ;c421  bd 7d c5 
    clc                     ;c424  18       
    adc mem_00fb            ;c425  65 fb    
    sta mem_00f9            ;c427  85 f9    

lab_c429:
    lda [mem_00f5],y        ;c429  b1 f5    
    tax                     ;c42b  aa       
    beq lab_c47f            ;c42c  f0 51    
    lda mem_006e            ;c42e  a5 6e    
    cmp [mem_00f5],y        ;c430  d1 f5    
    beq lab_c471            ;c432  f0 3d    
    bcs lab_c43a            ;c434  b0 04    
    iny                     ;c436  c8       
    iny                     ;c437  c8       
    bra lab_c429            ;c438  80 ef    

lab_c43a:
    lda mem_0071            ;c43a  a5 71    
    sec                     ;c43c  38       
    sbc mem_00f9            ;c43d  e5 f9    
    iny                     ;c43f  c8       
    cmp [mem_00f5],y        ;c440  d1 f5    

lab_c442:
    php                     ;c442  08       
    iny                     ;c443  c8       
    plp                     ;c444  28       
    nop                     ;c445  ea       
    beq lab_c44a            ;c446  f0 02    
    bcs lab_c47f            ;c448  b0 35    

lab_c44a:
    dex                     ;c44a  ca       
    lda mem_0103            ;c44b  ad 03 01 
    beq lab_c456            ;c44e  f0 06    
    dec a                   ;c450  1a       
    sta mem_0103            ;c451  8d 03 01 
    bne lab_c484            ;c454  d0 2e    

lab_c456:
    stx mem_00f8            ;c456  86 f8    
    lda mem_006e            ;c458  a5 6e    
    sec                     ;c45a  38       
    sbc mem_00f8            ;c45b  e5 f8    
    cmp #0x03               ;c45d  c9 03    
    bcc lab_c468            ;c45f  90 07    
    lda mem_006e            ;c461  a5 6e    
    sbc #0x02               ;c463  e9 02    
    tax                     ;c465  aa       
    bra lab_c46a            ;c466  80 02    

lab_c468:
    ldx mem_00f8            ;c468  a6 f8    

lab_c46a:
    stx mem_006e            ;c46a  86 6e    
    jsr sub_c301            ;c46c  20 01 c3 
    bra lab_c47f            ;c46f  80 0e    

lab_c471:
    lda mem_0071            ;c471  a5 71    
    sec                     ;c473  38       
    sbc mem_00f9            ;c474  e5 f9    
    iny                     ;c476  c8       
    cmp [mem_00f5],y        ;c477  d1 f5    
    beq lab_c47f            ;c479  f0 04    
    bcs lab_c486            ;c47b  b0 09    
    bra lab_c442            ;c47d  80 c3    

lab_c47f:
    lda #0x03               ;c47f  a9 03    
    sta mem_0103            ;c481  8d 03 01 

lab_c484:
    clc                     ;c484  18       
    rts                     ;c485  60       

lab_c486:
    lda #0x03               ;c486  a9 03    
    sta mem_0103            ;c488  8d 03 01 
    sec                     ;c48b  38       
    rts                     ;c48c  60       

    .byte 0x15              ;c48d  15          UNKNOWN 0x15 
    .byte 0x90              ;c48e  90          UNKNOWN 0x90 
    .byte 0x0b              ;c48f  0b          UNKNOWN 0x0b 
    .byte 0x8e              ;c490  8e          UNKNOWN 0x8e 
    .byte 0x06              ;c491  06          UNKNOWN 0x06 
    .byte 0x8b              ;c492  8b          UNKNOWN 0x8b 
    .byte 0x01              ;c493  01          UNKNOWN 0x01 
    .byte 0x70              ;c494  70          UNKNOWN 0x70 'p' 
    .byte 0x00              ;c495  00          UNKNOWN 0x00 
    .byte 0x50              ;c496  50          UNKNOWN 0x50 'P' 
    .byte 0x9c              ;c497  9c          UNKNOWN 0x9c 
    .byte 0x32              ;c498  32          UNKNOWN 0x32 '2' 
    .byte 0x95              ;c499  95          UNKNOWN 0x95 
    .byte 0x15              ;c49a  15          UNKNOWN 0x15 
    .byte 0x90              ;c49b  90          UNKNOWN 0x90 
    .byte 0x0b              ;c49c  0b          UNKNOWN 0x0b 
    .byte 0x8e              ;c49d  8e          UNKNOWN 0x8e 
    .byte 0x06              ;c49e  06          UNKNOWN 0x06 
    .byte 0x8b              ;c49f  8b          UNKNOWN 0x8b 
    .byte 0x01              ;c4a0  01          UNKNOWN 0x01 
    .byte 0x70              ;c4a1  70          UNKNOWN 0x70 'p' 
    .byte 0x00              ;c4a2  00          UNKNOWN 0x00 
    .byte 0x64              ;c4a3  64          UNKNOWN 0x64 'd' 
    .byte 0xa2              ;c4a4  a2          UNKNOWN 0xa2 
    .byte 0x5a              ;c4a5  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x9f              ;c4a6  9f          UNKNOWN 0x9f 
    .byte 0x50              ;c4a7  50          UNKNOWN 0x50 'P' 
    .byte 0x9c              ;c4a8  9c          UNKNOWN 0x9c 
    .byte 0x46              ;c4a9  46          UNKNOWN 0x46 'F' 
    .byte 0x99              ;c4aa  99          UNKNOWN 0x99 
    .byte 0x3c              ;c4ab  3c          UNKNOWN 0x3c '<' 
    .byte 0x97              ;c4ac  97          UNKNOWN 0x97 
    .byte 0x32              ;c4ad  32          UNKNOWN 0x32 '2' 
    .byte 0x95              ;c4ae  95          UNKNOWN 0x95 
    .byte 0x28              ;c4af  28          UNKNOWN 0x28 '(' 
    .byte 0x94              ;c4b0  94          UNKNOWN 0x94 
    .byte 0x1e              ;c4b1  1e          UNKNOWN 0x1e 
    .byte 0x92              ;c4b2  92          UNKNOWN 0x92 
    .byte 0x15              ;c4b3  15          UNKNOWN 0x15 
    .byte 0x90              ;c4b4  90          UNKNOWN 0x90 
    .byte 0x0b              ;c4b5  0b          UNKNOWN 0x0b 
    .byte 0x8e              ;c4b6  8e          UNKNOWN 0x8e 
    .byte 0x06              ;c4b7  06          UNKNOWN 0x06 
    .byte 0x8b              ;c4b8  8b          UNKNOWN 0x8b 
    .byte 0x01              ;c4b9  01          UNKNOWN 0x01 
    .byte 0x70              ;c4ba  70          UNKNOWN 0x70 'p' 
    .byte 0x00              ;c4bb  00          UNKNOWN 0x00 
    .byte 0x14              ;c4bc  14          UNKNOWN 0x14 
    .byte 0x88              ;c4bd  88          UNKNOWN 0x88 
    .byte 0x0a              ;c4be  0a          UNKNOWN 0x0a 
    .byte 0x7e              ;c4bf  7e          UNKNOWN 0x7e '~' 
    .byte 0x06              ;c4c0  06          UNKNOWN 0x06 
    .byte 0x77              ;c4c1  77          UNKNOWN 0x77 'w' 
    .byte 0x01              ;c4c2  01          UNKNOWN 0x01 
    .byte 0x6a              ;c4c3  6a          UNKNOWN 0x6a 'j' 
    .byte 0x00              ;c4c4  00          UNKNOWN 0x00 
    .byte 0x50              ;c4c5  50          UNKNOWN 0x50 'P' 
    .byte 0x9d              ;c4c6  9d          UNKNOWN 0x9d 
    .byte 0x32              ;c4c7  32          UNKNOWN 0x32 '2' 
    .byte 0x97              ;c4c8  97          UNKNOWN 0x97 
    .byte 0x14              ;c4c9  14          UNKNOWN 0x14 
    .byte 0x88              ;c4ca  88          UNKNOWN 0x88 
    .byte 0x0a              ;c4cb  0a          UNKNOWN 0x0a 
    .byte 0x7e              ;c4cc  7e          UNKNOWN 0x7e '~' 
    .byte 0x06              ;c4cd  06          UNKNOWN 0x06 
    .byte 0x77              ;c4ce  77          UNKNOWN 0x77 'w' 
    .byte 0x01              ;c4cf  01          UNKNOWN 0x01 
    .byte 0x6a              ;c4d0  6a          UNKNOWN 0x6a 'j' 
    .byte 0x00              ;c4d1  00          UNKNOWN 0x00 
    .byte 0x64              ;c4d2  64          UNKNOWN 0x64 'd' 
    .byte 0xa2              ;c4d3  a2          UNKNOWN 0xa2 
    .byte 0x5a              ;c4d4  5a          UNKNOWN 0x5a 'Z' 
    .byte 0xa0              ;c4d5  a0          UNKNOWN 0xa0 
    .byte 0x50              ;c4d6  50          UNKNOWN 0x50 'P' 
    .byte 0x9d              ;c4d7  9d          UNKNOWN 0x9d 
    .byte 0x46              ;c4d8  46          UNKNOWN 0x46 'F' 
    .byte 0x9b              ;c4d9  9b          UNKNOWN 0x9b 
    .byte 0x3c              ;c4da  3c          UNKNOWN 0x3c '<' 
    .byte 0x99              ;c4db  99          UNKNOWN 0x99 
    .byte 0x32              ;c4dc  32          UNKNOWN 0x32 '2' 
    .byte 0x97              ;c4dd  97          UNKNOWN 0x97 
    .byte 0x28              ;c4de  28          UNKNOWN 0x28 '(' 
    .byte 0x95              ;c4df  95          UNKNOWN 0x95 
    .byte 0x1e              ;c4e0  1e          UNKNOWN 0x1e 
    .byte 0x8f              ;c4e1  8f          UNKNOWN 0x8f 
    .byte 0x14              ;c4e2  14          UNKNOWN 0x14 
    .byte 0x88              ;c4e3  88          UNKNOWN 0x88 
    .byte 0x0a              ;c4e4  0a          UNKNOWN 0x0a 
    .byte 0x7e              ;c4e5  7e          UNKNOWN 0x7e '~' 
    .byte 0x06              ;c4e6  06          UNKNOWN 0x06 
    .byte 0x77              ;c4e7  77          UNKNOWN 0x77 'w' 
    .byte 0x01              ;c4e8  01          UNKNOWN 0x01 
    .byte 0x6a              ;c4e9  6a          UNKNOWN 0x6a 'j' 
    .byte 0x00              ;c4ea  00          UNKNOWN 0x00 
    .byte 0x15              ;c4eb  15          UNKNOWN 0x15 
    .byte 0x96              ;c4ec  96          UNKNOWN 0x96 
    .byte 0x0b              ;c4ed  0b          UNKNOWN 0x0b 
    .byte 0x8a              ;c4ee  8a          UNKNOWN 0x8a 
    .byte 0x06              ;c4ef  06          UNKNOWN 0x06 
    .byte 0x81              ;c4f0  81          UNKNOWN 0x81 
    .byte 0x01              ;c4f1  01          UNKNOWN 0x01 
    .byte 0x77              ;c4f2  77          UNKNOWN 0x77 'w' 
    .byte 0x00              ;c4f3  00          UNKNOWN 0x00 
    .byte 0x15              ;c4f4  15          UNKNOWN 0x15 
    .byte 0x9a              ;c4f5  9a          UNKNOWN 0x9a 
    .byte 0x0b              ;c4f6  0b          UNKNOWN 0x0b 
    .byte 0x90              ;c4f7  90          UNKNOWN 0x90 
    .byte 0x06              ;c4f8  06          UNKNOWN 0x06 
    .byte 0x87              ;c4f9  87          UNKNOWN 0x87 
    .byte 0x01              ;c4fa  01          UNKNOWN 0x01 
    .byte 0x7d              ;c4fb  7d          UNKNOWN 0x7d '}' 
    .byte 0x00              ;c4fc  00          UNKNOWN 0x00 
    .byte 0x06              ;c4fd  06          UNKNOWN 0x06 
    .byte 0x06              ;c4fe  06          UNKNOWN 0x06 

lab_c4ff:
    asl P3                  ;c4ff  06 06    
    ora P2D                 ;c501  05 05    
    ora P2D                 ;c503  05 05    
    ora P2D                 ;c505  05 05    
    .byte 0x04              ;c507  04       Illegal instruction

    .byte 0x04              ;c508  04          UNKNOWN 0x04 
    .byte 0x04              ;c509  04          UNKNOWN 0x04 
    .byte 0x04              ;c50a  04          UNKNOWN 0x04 
    .byte 0x04              ;c50b  04          UNKNOWN 0x04 
    .byte 0x03              ;c50c  03          UNKNOWN 0x03 
    .byte 0x03              ;c50d  03          UNKNOWN 0x03 
    .byte 0x03              ;c50e  03          UNKNOWN 0x03 
    .byte 0x03              ;c50f  03          UNKNOWN 0x03 
    .byte 0x03              ;c510  03          UNKNOWN 0x03 
    .byte 0x02              ;c511  02          UNKNOWN 0x02 
    .byte 0x02              ;c512  02          UNKNOWN 0x02 
    .byte 0x02              ;c513  02          UNKNOWN 0x02 
    .byte 0x01              ;c514  01          UNKNOWN 0x01 
    .byte 0x01              ;c515  01          UNKNOWN 0x01 
    .byte 0x01              ;c516  01          UNKNOWN 0x01 
    .byte 0x00              ;c517  00          UNKNOWN 0x00 
    .byte 0x00              ;c518  00          UNKNOWN 0x00 
    .byte 0x00              ;c519  00          UNKNOWN 0x00 
    .byte 0x00              ;c51a  00          UNKNOWN 0x00 
    .byte 0xff              ;c51b  ff          UNKNOWN 0xff 
    .byte 0xff              ;c51c  ff          UNKNOWN 0xff 
    .byte 0xff              ;c51d  ff          UNKNOWN 0xff 
    .byte 0xff              ;c51e  ff          UNKNOWN 0xff 
    .byte 0xfe              ;c51f  fe          UNKNOWN 0xfe 
    .byte 0xfe              ;c520  fe          UNKNOWN 0xfe 
    .byte 0xfe              ;c521  fe          UNKNOWN 0xfe 
    .byte 0xfe              ;c522  fe          UNKNOWN 0xfe 
    .byte 0xfd              ;c523  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c524  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c525  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c526  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c527  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c528  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c529  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c52a  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c52b  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c52c  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c52d  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c52e  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c52f  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c530  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c531  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c532  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c533  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c534  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c535  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c536  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c537  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c538  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c539  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c53a  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c53b  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c53c  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c53d  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c53e  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c53f  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c540  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c541  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c542  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c543  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c544  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c545  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c546  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c547  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c548  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c549  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c54a  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c54b  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c54c  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c54d  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c54e  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c54f  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c550  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c551  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c552  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c553  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c554  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c555  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c556  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c557  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c558  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c559  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c55a  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c55b  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c55c  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c55d  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c55e  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c55f  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c560  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c561  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c562  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c563  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c564  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c565  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c566  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c567  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c568  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c569  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c56a  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c56b  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c56c  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c56d  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c56e  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c56f  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c570  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c571  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c572  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c573  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c574  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c575  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c576  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c577  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;c578  fd          UNKNOWN 0xfd 
    .byte 0xa7              ;c579  a7          UNKNOWN 0xa7 
    .byte 0xc2              ;c57a  c2          UNKNOWN 0xc2 
    .byte 0x72              ;c57b  72          UNKNOWN 0x72 'r' 
    .byte 0x17              ;c57c  17          UNKNOWN 0x17 

mem_c57d:
    .byte 0x6d              ;c57d  6d          DATA 0x6d 'm' 
    .byte 0x6f              ;c57e  6f          DATA 0x6f 'o' 
    .byte 0xc7              ;c57f  c7          DATA 0xc7 
    .byte 0x53              ;c580  53          DATA 0x53 'S' 
    .byte 0x6c              ;c581  6c          DATA 0x6c 'l' 
    .byte 0xa7              ;c582  a7          DATA 0xa7 
    .byte 0x50              ;c583  50          DATA 0x50 'P' 
    .byte 0x69              ;c584  69          DATA 0x69 'i' 
    .byte 0x20              ;c585  20          DATA 0x20 ' ' 
    .byte 0x52              ;c586  52          DATA 0x52 'R' 
    .byte 0xd0              ;c587  d0          DATA 0xd0 
    .byte 0xf0              ;c588  f0          DATA 0xf0 
    .byte 0x64              ;c589  64          DATA 0x64 'd' 
    .byte 0xaa              ;c58a  aa          DATA 0xaa 
    .byte 0xa5              ;c58b  a5          DATA 0xa5 
    .byte 0x6e              ;c58c  6e          DATA 0x6e 'n' 
    .byte 0xa4              ;c58d  a4          DATA 0xa4 
    .byte 0x71              ;c58e  71          DATA 0x71 'q' 
    .byte 0x20              ;c58f  20          DATA 0x20 ' ' 
    .byte 0x59              ;c590  59          DATA 0x59 'Y' 
    .byte 0xc6              ;c591  c6          DATA 0xc6 
    .byte 0x90              ;c592  90          DATA 0x90 
    .byte 0x5a              ;c593  5a          DATA 0x5a 'Z' 
    .byte 0x85              ;c594  85          DATA 0x85 
    .byte 0x6e              ;c595  6e          DATA 0x6e 'n' 
    .byte 0x60              ;c596  60          DATA 0x60 '`' 
    .byte 0xa7              ;c597  a7          DATA 0xa7 
    .byte 0xc2              ;c598  c2          DATA 0xc2 
    .byte 0x54              ;c599  54          DATA 0x54 'T' 
    .byte 0x17              ;c59a  17          DATA 0x17 
    .byte 0x6d              ;c59b  6d          DATA 0x6d 'm' 
    .byte 0x51              ;c59c  51          DATA 0x51 'Q' 
    .byte 0xc7              ;c59d  c7          DATA 0xc7 
    .byte 0x50              ;c59e  50          DATA 0x50 'P' 
    .byte 0x4e              ;c59f  4e          DATA 0x4e 'N' 
    .byte 0xa7              ;c5a0  a7          DATA 0xa7 
    .byte 0x50              ;c5a1  50          DATA 0x50 'P' 
    .byte 0x4b              ;c5a2  4b          DATA 0x4b 'K' 
    .byte 0x20              ;c5a3  20          DATA 0x20 ' ' 
    .byte 0x57              ;c5a4  57          DATA 0x57 'W' 
    .byte 0xd0              ;c5a5  d0          DATA 0xd0 
    .byte 0xf0              ;c5a6  f0          DATA 0xf0 
    .byte 0x46              ;c5a7  46          DATA 0x46 'F' 
    .byte 0xaa              ;c5a8  aa          DATA 0xaa 
    .byte 0xad              ;c5a9  ad          DATA 0xad 
    .byte 0x06              ;c5aa  06          DATA 0x06 
    .byte 0x01              ;c5ab  01          DATA 0x01 
    .byte 0xac              ;c5ac  ac          DATA 0xac 
    .byte 0x0a              ;c5ad  0a          DATA 0x0a 
    .byte 0x01              ;c5ae  01          DATA 0x01 
    .byte 0x20              ;c5af  20          DATA 0x20 ' ' 
    .byte 0x59              ;c5b0  59          DATA 0x59 'Y' 
    .byte 0xc6              ;c5b1  c6          DATA 0xc6 
    .byte 0x90              ;c5b2  90          DATA 0x90 
    .byte 0x3a              ;c5b3  3a          DATA 0x3a ':' 
    .byte 0x8d              ;c5b4  8d          DATA 0x8d 
    .byte 0x06              ;c5b5  06          DATA 0x06 
    .byte 0x01              ;c5b6  01          DATA 0x01 
    .byte 0x60              ;c5b7  60          DATA 0x60 '`' 
    .byte 0xa7              ;c5b8  a7          DATA 0xa7 
    .byte 0xc2              ;c5b9  c2          DATA 0xc2 
    .byte 0x33              ;c5ba  33          DATA 0x33 '3' 
    .byte 0x17              ;c5bb  17          DATA 0x17 
    .byte 0x6d              ;c5bc  6d          DATA 0x6d 'm' 
    .byte 0x30              ;c5bd  30          DATA 0x30 '0' 
    .byte 0xc7              ;c5be  c7          DATA 0xc7 
    .byte 0x50              ;c5bf  50          DATA 0x50 'P' 
    .byte 0x2d              ;c5c0  2d          DATA 0x2d '-' 
    .byte 0xa7              ;c5c1  a7          DATA 0xa7 
    .byte 0x50              ;c5c2  50          DATA 0x50 'P' 
    .byte 0x2a              ;c5c3  2a          DATA 0x2a '*' 
    .byte 0x20              ;c5c4  20          DATA 0x20 ' ' 
    .byte 0x5d              ;c5c5  5d          DATA 0x5d ']' 
    .byte 0xd0              ;c5c6  d0          DATA 0xd0 
    .byte 0xf0              ;c5c7  f0          DATA 0xf0 
    .byte 0x25              ;c5c8  25          DATA 0x25 '%' 
    .byte 0xaa              ;c5c9  aa          DATA 0xaa 
    .byte 0xad              ;c5ca  ad          DATA 0xad 
    .byte 0x07              ;c5cb  07          DATA 0x07 
    .byte 0x01              ;c5cc  01          DATA 0x01 
    .byte 0xac              ;c5cd  ac          DATA 0xac 
    .byte 0x0b              ;c5ce  0b          DATA 0x0b 
    .byte 0x01              ;c5cf  01          DATA 0x01 
    .byte 0x20              ;c5d0  20          DATA 0x20 ' ' 
    .byte 0x59              ;c5d1  59          DATA 0x59 'Y' 
    .byte 0xc6              ;c5d2  c6          DATA 0xc6 
    .byte 0x90              ;c5d3  90          DATA 0x90 
    .byte 0x19              ;c5d4  19          DATA 0x19 
    .byte 0x8d              ;c5d5  8d          DATA 0x8d 
    .byte 0x07              ;c5d6  07          DATA 0x07 
    .byte 0x01              ;c5d7  01          DATA 0x01 
    .byte 0x60              ;c5d8  60          DATA 0x60 '`' 
    .byte 0xc9              ;c5d9  c9          DATA 0xc9 
    .byte 0xff              ;c5da  ff          DATA 0xff 
    .byte 0xf0              ;c5db  f0          DATA 0xf0 
    .byte 0x11              ;c5dc  11          DATA 0x11 
    .byte 0xc9              ;c5dd  c9          DATA 0xc9 
    .byte 0x04              ;c5de  04          DATA 0x04 
    .byte 0x90              ;c5df  90          DATA 0x90 
    .byte 0x0d              ;c5e0  0d          DATA 0x0d 
    .byte 0x98              ;c5e1  98          DATA 0x98 
    .byte 0xdd              ;c5e2  dd          DATA 0xdd 
    .byte 0x70              ;c5e3  70          DATA 0x70 'p' 
    .byte 0xc6              ;c5e4  c6          DATA 0xc6 
    .byte 0xb0              ;c5e5  b0          DATA 0xb0 
    .byte 0x07              ;c5e6  07          DATA 0x07 
    .byte 0x20              ;c5e7  20          DATA 0x20 ' ' 
    .byte 0x01              ;c5e8  01          DATA 0x01 
    .byte 0xc3              ;c5e9  c3          DATA 0xc3 
    .byte 0xa9              ;c5ea  a9          DATA 0xa9 
    .byte 0x03              ;c5eb  03          DATA 0x03 
    .byte 0x38              ;c5ec  38          DATA 0x38 '8' 
    .byte 0x60              ;c5ed  60          DATA 0x60 '`' 
    .byte 0x18              ;c5ee  18          DATA 0x18 
    .byte 0x60              ;c5ef  60          DATA 0x60 '`' 
    .byte 0x7c              ;c5f0  7c          DATA 0x7c '|' 
    .byte 0x7c              ;c5f1  7c          DATA 0x7c '|' 
    .byte 0x7c              ;c5f2  7c          DATA 0x7c '|' 
    .byte 0x7c              ;c5f3  7c          DATA 0x7c '|' 
    .byte 0x7c              ;c5f4  7c          DATA 0x7c '|' 
    .byte 0x78              ;c5f5  78          DATA 0x78 'x' 
    .byte 0x7c              ;c5f6  7c          DATA 0x7c '|' 
    .byte 0x7c              ;c5f7  7c          DATA 0x7c '|' 
    .byte 0x7c              ;c5f8  7c          DATA 0x7c '|' 

sub_c5f9:
    bbc 3,mem_0077,lab_c676 ;c5f9  77 77 7a 
    .byte 0x7c              ;c5fc  7c       Illegal instruction

    .byte 0x78              ;c5fd  78          UNKNOWN 0x78 'x' 
    .byte 0x7c              ;c5fe  7c          UNKNOWN 0x7c '|' 
    .byte 0x7c              ;c5ff  7c          UNKNOWN 0x7c '|' 
    .byte 0x20              ;c600  20          UNKNOWN 0x20 ' ' 
    .byte 0x17              ;c601  17          UNKNOWN 0x17 
    .byte 0xc6              ;c602  c6          UNKNOWN 0xc6 
    .byte 0xb0              ;c603  b0          UNKNOWN 0xb0 
    .byte 0x69              ;c604  69          UNKNOWN 0x69 'i' 
    .byte 0x20              ;c605  20          UNKNOWN 0x20 ' ' 
    .byte 0x57              ;c606  57          UNKNOWN 0x57 'W' 
    .byte 0xd0              ;c607  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;c608  d0          UNKNOWN 0xd0 
    .byte 0x15              ;c609  15          UNKNOWN 0x15 
    .byte 0x20              ;c60a  20          UNKNOWN 0x20 ' ' 
    .byte 0x9a              ;c60b  9a          UNKNOWN 0x9a 
    .byte 0xd0              ;c60c  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;c60d  d0          UNKNOWN 0xd0 
    .byte 0x02              ;c60e  02          UNKNOWN 0x02 
    .byte 0x80              ;c60f  80          UNKNOWN 0x80 
    .byte 0x5d              ;c610  5d          UNKNOWN 0x5d ']' 
    .byte 0x08              ;c611  08          UNKNOWN 0x08 
    .byte 0x78              ;c612  78          UNKNOWN 0x78 'x' 
    .byte 0x8d              ;c613  8d          UNKNOWN 0x8d 
    .byte 0x08              ;c614  08          UNKNOWN 0x08 
    .byte 0x01              ;c615  01          UNKNOWN 0x01 
    .byte 0xa9              ;c616  a9          UNKNOWN 0xa9 
    .byte 0xff              ;c617  ff          UNKNOWN 0xff 
    .byte 0x8d              ;c618  8d          UNKNOWN 0x8d 
    .byte 0x06              ;c619  06          UNKNOWN 0x06 
    .byte 0x01              ;c61a  01          UNKNOWN 0x01 
    .byte 0x28              ;c61b  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c61c  ea          UNKNOWN 0xea 
    .byte 0x80              ;c61d  80          UNKNOWN 0x80 
    .byte 0x4f              ;c61e  4f          UNKNOWN 0x4f 'O' 
    .byte 0x20              ;c61f  20          UNKNOWN 0x20 ' ' 
    .byte 0x9a              ;c620  9a          UNKNOWN 0x9a 
    .byte 0xd0              ;c621  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;c622  f0          UNKNOWN 0xf0 
    .byte 0x42              ;c623  42          UNKNOWN 0x42 'B' 
    .byte 0x85              ;c624  85          UNKNOWN 0x85 
    .byte 0xf8              ;c625  f8          UNKNOWN 0xf8 
    .byte 0xad              ;c626  ad          UNKNOWN 0xad 
    .byte 0x06              ;c627  06          UNKNOWN 0x06 
    .byte 0x01              ;c628  01          UNKNOWN 0x01 
    .byte 0x85              ;c629  85          UNKNOWN 0x85 
    .byte 0xfa              ;c62a  fa          UNKNOWN 0xfa 
    .byte 0xad              ;c62b  ad          UNKNOWN 0xad 
    .byte 0x0a              ;c62c  0a          UNKNOWN 0x0a 
    .byte 0x01              ;c62d  01          UNKNOWN 0x01 
    .byte 0x85              ;c62e  85          UNKNOWN 0x85 
    .byte 0xf9              ;c62f  f9          UNKNOWN 0xf9 
    .byte 0x20              ;c630  20          UNKNOWN 0x20 ' ' 
    .byte 0x5e              ;c631  5e          UNKNOWN 0x5e '^' 
    .byte 0xc7              ;c632  c7          UNKNOWN 0xc7 
    .byte 0xb0              ;c633  b0          UNKNOWN 0xb0 
    .byte 0x27              ;c634  27          UNKNOWN 0x27 ''' 
    .byte 0xae              ;c635  ae          UNKNOWN 0xae 
    .byte 0x06              ;c636  06          UNKNOWN 0x06 
    .byte 0x01              ;c637  01          UNKNOWN 0x01 
    .byte 0xe0              ;c638  e0          UNKNOWN 0xe0 
    .byte 0xff              ;c639  ff          UNKNOWN 0xff 
    .byte 0xf0              ;c63a  f0          UNKNOWN 0xf0 
    .byte 0x20              ;c63b  20          UNKNOWN 0x20 ' ' 
    .byte 0xae              ;c63c  ae          UNKNOWN 0xae 
    .byte 0x04              ;c63d  04          UNKNOWN 0x04 
    .byte 0x01              ;c63e  01          UNKNOWN 0x01 
    .byte 0xf0              ;c63f  f0          UNKNOWN 0xf0 
    .byte 0x06              ;c640  06          UNKNOWN 0x06 
    .byte 0xca              ;c641  ca          UNKNOWN 0xca 
    .byte 0x8e              ;c642  8e          UNKNOWN 0x8e 
    .byte 0x04              ;c643  04          UNKNOWN 0x04 
    .byte 0x01              ;c644  01          UNKNOWN 0x01 
    .byte 0xd0              ;c645  d0          UNKNOWN 0xd0 
    .byte 0x27              ;c646  27          UNKNOWN 0x27 ''' 
    .byte 0x85              ;c647  85          UNKNOWN 0x85 

lab_c648:
    sed                     ;c648  f8       
    lda mem_0106            ;c649  ad 06 01 
    sec                     ;c64c  38       
    sbc mem_00f8            ;c64d  e5 f8    
    cmp #0x03               ;c64f  c9 03    
    bcc lab_c65a            ;c651  90 07    
    lda mem_0106            ;c653  ad 06 01 
    sbc #0x02               ;c656  e9 02    
    bra lab_c65c            ;c658  80 02    

lab_c65a:
    lda mem_00f8            ;c65a  a5 f8    

lab_c65c:
    sta mem_0106            ;c65c  8d 06 01 
    lda #0x03               ;c65f  a9 03    
    sta mem_0104            ;c661  8d 04 01 
    bra lab_c66e            ;c664  80 08    

    .byte 0xa9              ;c666  a9          UNKNOWN 0xa9 
    .byte 0x00              ;c667  00          UNKNOWN 0x00 
    .byte 0x8d              ;c668  8d          UNKNOWN 0x8d 
    .byte 0x06              ;c669  06          UNKNOWN 0x06 
    .byte 0x01              ;c66a  01          UNKNOWN 0x01 
    .byte 0x8d              ;c66b  8d          UNKNOWN 0x8d 
    .byte 0x08              ;c66c  08          UNKNOWN 0x08 
    .byte 0x01              ;c66d  01          UNKNOWN 0x01 

lab_c66e:
    rts                     ;c66e  60       

    .byte 0x20              ;c66f  20          UNKNOWN 0x20 ' ' 
    .byte 0x38              ;c670  38          UNKNOWN 0x38 '8' 
    .byte 0xc6              ;c671  c6          UNKNOWN 0xc6 
    .byte 0xb0              ;c672  b0          UNKNOWN 0xb0 
    .byte 0x69              ;c673  69          UNKNOWN 0x69 'i' 
    .byte 0x20              ;c674  20          UNKNOWN 0x20 ' ' 
    .byte 0x5d              ;c675  5d          UNKNOWN 0x5d ']' 

lab_c676:
    bne lab_c648            ;c676  d0 d0    
    ora PRE12,x             ;c678  15 20    
    rrf mem_00d0            ;c67a  82 d0    
    bne lab_c680            ;c67c  d0 02    
    bra lab_c6dd            ;c67e  80 5d    

lab_c680:
    php                     ;c680  08       
    sei                     ;c681  78       
    sta mem_0109            ;c682  8d 09 01 
    lda #0xff               ;c685  a9 ff    
    sta mem_0107            ;c687  8d 07 01 
    plp                     ;c68a  28       
    nop                     ;c68b  ea       
    bra lab_c6dd            ;c68c  80 4f    

    .byte 0x20              ;c68e  20          UNKNOWN 0x20 ' ' 
    .byte 0x82              ;c68f  82          UNKNOWN 0x82 
    .byte 0xd0              ;c690  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;c691  f0          UNKNOWN 0xf0 
    .byte 0x42              ;c692  42          UNKNOWN 0x42 'B' 
    .byte 0x85              ;c693  85          UNKNOWN 0x85 
    .byte 0xf8              ;c694  f8          UNKNOWN 0xf8 
    .byte 0xad              ;c695  ad          UNKNOWN 0xad 
    .byte 0x07              ;c696  07          UNKNOWN 0x07 
    .byte 0x01              ;c697  01          UNKNOWN 0x01 
    .byte 0x85              ;c698  85          UNKNOWN 0x85 
    .byte 0xfa              ;c699  fa          UNKNOWN 0xfa 
    .byte 0xad              ;c69a  ad          UNKNOWN 0xad 
    .byte 0x0b              ;c69b  0b          UNKNOWN 0x0b 
    .byte 0x01              ;c69c  01          UNKNOWN 0x01 
    .byte 0x85              ;c69d  85          UNKNOWN 0x85 
    .byte 0xf9              ;c69e  f9          UNKNOWN 0xf9 
    .byte 0x20              ;c69f  20          UNKNOWN 0x20 ' ' 
    .byte 0x5e              ;c6a0  5e          UNKNOWN 0x5e '^' 
    .byte 0xc7              ;c6a1  c7          UNKNOWN 0xc7 
    .byte 0xb0              ;c6a2  b0          UNKNOWN 0xb0 
    .byte 0x27              ;c6a3  27          UNKNOWN 0x27 ''' 
    .byte 0xae              ;c6a4  ae          UNKNOWN 0xae 
    .byte 0x07              ;c6a5  07          UNKNOWN 0x07 
    .byte 0x01              ;c6a6  01          UNKNOWN 0x01 
    .byte 0xe0              ;c6a7  e0          UNKNOWN 0xe0 
    .byte 0xff              ;c6a8  ff          UNKNOWN 0xff 
    .byte 0xf0              ;c6a9  f0          UNKNOWN 0xf0 
    .byte 0x20              ;c6aa  20          UNKNOWN 0x20 ' ' 
    .byte 0xae              ;c6ab  ae          UNKNOWN 0xae 
    .byte 0x05              ;c6ac  05          UNKNOWN 0x05 
    .byte 0x01              ;c6ad  01          UNKNOWN 0x01 
    .byte 0xf0              ;c6ae  f0          UNKNOWN 0xf0 
    .byte 0x06              ;c6af  06          UNKNOWN 0x06 
    .byte 0xca              ;c6b0  ca          UNKNOWN 0xca 
    .byte 0x8e              ;c6b1  8e          UNKNOWN 0x8e 
    .byte 0x05              ;c6b2  05          UNKNOWN 0x05 
    .byte 0x01              ;c6b3  01          UNKNOWN 0x01 
    .byte 0xd0              ;c6b4  d0          UNKNOWN 0xd0 
    .byte 0x27              ;c6b5  27          UNKNOWN 0x27 ''' 
    .byte 0x85              ;c6b6  85          UNKNOWN 0x85 
    .byte 0xf8              ;c6b7  f8          UNKNOWN 0xf8 
    .byte 0xad              ;c6b8  ad          UNKNOWN 0xad 
    .byte 0x07              ;c6b9  07          UNKNOWN 0x07 
    .byte 0x01              ;c6ba  01          UNKNOWN 0x01 
    .byte 0x38              ;c6bb  38          UNKNOWN 0x38 '8' 
    .byte 0xe5              ;c6bc  e5          UNKNOWN 0xe5 
    .byte 0xf8              ;c6bd  f8          UNKNOWN 0xf8 
    .byte 0xc9              ;c6be  c9          UNKNOWN 0xc9 
    .byte 0x03              ;c6bf  03          UNKNOWN 0x03 
    .byte 0x90              ;c6c0  90          UNKNOWN 0x90 
    .byte 0x07              ;c6c1  07          UNKNOWN 0x07 
    .byte 0xad              ;c6c2  ad          UNKNOWN 0xad 
    .byte 0x07              ;c6c3  07          UNKNOWN 0x07 
    .byte 0x01              ;c6c4  01          UNKNOWN 0x01 
    .byte 0xe9              ;c6c5  e9          UNKNOWN 0xe9 
    .byte 0x02              ;c6c6  02          UNKNOWN 0x02 
    .byte 0x80              ;c6c7  80          UNKNOWN 0x80 
    .byte 0x02              ;c6c8  02          UNKNOWN 0x02 
    .byte 0xa5              ;c6c9  a5          UNKNOWN 0xa5 
    .byte 0xf8              ;c6ca  f8          UNKNOWN 0xf8 
    .byte 0x8d              ;c6cb  8d          UNKNOWN 0x8d 
    .byte 0x07              ;c6cc  07          UNKNOWN 0x07 
    .byte 0x01              ;c6cd  01          UNKNOWN 0x01 
    .byte 0xa9              ;c6ce  a9          UNKNOWN 0xa9 
    .byte 0x03              ;c6cf  03          UNKNOWN 0x03 
    .byte 0x8d              ;c6d0  8d          UNKNOWN 0x8d 
    .byte 0x05              ;c6d1  05          UNKNOWN 0x05 
    .byte 0x01              ;c6d2  01          UNKNOWN 0x01 
    .byte 0x80              ;c6d3  80          UNKNOWN 0x80 
    .byte 0x08              ;c6d4  08          UNKNOWN 0x08 
    .byte 0xa9              ;c6d5  a9          UNKNOWN 0xa9 
    .byte 0x00              ;c6d6  00          UNKNOWN 0x00 
    .byte 0x8d              ;c6d7  8d          UNKNOWN 0x8d 
    .byte 0x07              ;c6d8  07          UNKNOWN 0x07 
    .byte 0x01              ;c6d9  01          UNKNOWN 0x01 
    .byte 0x8d              ;c6da  8d          UNKNOWN 0x8d 
    .byte 0x09              ;c6db  09          UNKNOWN 0x09 
    .byte 0x01              ;c6dc  01          UNKNOWN 0x01 

lab_c6dd:
    rts                     ;c6dd  60       

    .byte 0xa5              ;c6de  a5          UNKNOWN 0xa5 
    .byte 0xf8              ;c6df  f8          UNKNOWN 0xf8 
    .byte 0x20              ;c6e0  20          UNKNOWN 0x20 ' ' 
    .byte 0x21              ;c6e1  21          UNKNOWN 0x21 '!' 
    .byte 0xe5              ;c6e2  e5          UNKNOWN 0xe5 
    .byte 0x85              ;c6e3  85          UNKNOWN 0x85 
    .byte 0xfb              ;c6e4  fb          UNKNOWN 0xfb 
    .byte 0xa5              ;c6e5  a5          UNKNOWN 0xa5 
    .byte 0xf8              ;c6e6  f8          UNKNOWN 0xf8 
    .byte 0x20              ;c6e7  20          UNKNOWN 0x20 ' ' 
    .byte 0x19              ;c6e8  19          UNKNOWN 0x19 
    .byte 0xd0              ;c6e9  d0          UNKNOWN 0xd0 
    .byte 0xa0              ;c6ea  a0          UNKNOWN 0xa0 
    .byte 0x00              ;c6eb  00          UNKNOWN 0x00 
    .byte 0x3c              ;c6ec  3c          UNKNOWN 0x3c '<' 
    .byte 0x06              ;c6ed  06          UNKNOWN 0x06 
    .byte 0xf7              ;c6ee  f7          UNKNOWN 0xf7 
    .byte 0x17              ;c6ef  17          UNKNOWN 0x17 
    .byte 0x6d              ;c6f0  6d          UNKNOWN 0x6d 'm' 
    .byte 0x13              ;c6f1  13          UNKNOWN 0x13 
    .byte 0x3c              ;c6f2  3c          UNKNOWN 0x3c '<' 
    .byte 0x06              ;c6f3  06          UNKNOWN 0x06 
    .byte 0xf7              ;c6f4  f7          UNKNOWN 0xf7 
    .byte 0xa7              ;c6f5  a7          UNKNOWN 0xa7 
    .byte 0x50              ;c6f6  50          UNKNOWN 0x50 'P' 
    .byte 0x0d              ;c6f7  0d          UNKNOWN 0x0d 
    .byte 0x3c              ;c6f8  3c          UNKNOWN 0x3c '<' 
    .byte 0x06              ;c6f9  06          UNKNOWN 0x06 
    .byte 0xf7              ;c6fa  f7          UNKNOWN 0xf7 
    .byte 0xc7              ;c6fb  c7          UNKNOWN 0xc7 
    .byte 0x50              ;c6fc  50          UNKNOWN 0x50 'P' 
    .byte 0x07              ;c6fd  07          UNKNOWN 0x07 
    .byte 0x18              ;c6fe  18          UNKNOWN 0x18 
    .byte 0xa5              ;c6ff  a5          UNKNOWN 0xa5 
    .byte 0xfb              ;c700  fb          UNKNOWN 0xfb 
    .byte 0x65              ;c701  65          UNKNOWN 0x65 'e' 
    .byte 0xc5              ;c702  c5          UNKNOWN 0xc5 
    .byte 0x85              ;c703  85          UNKNOWN 0x85 
    .byte 0xf7              ;c704  f7          UNKNOWN 0xf7 
    .byte 0xb1              ;c705  b1          UNKNOWN 0xb1 
    .byte 0xf5              ;c706  f5          UNKNOWN 0xf5 
    .byte 0xc9              ;c707  c9          UNKNOWN 0xc9 
    .byte 0xff              ;c708  ff          UNKNOWN 0xff 
    .byte 0xf0              ;c709  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;c70a  0c          UNKNOWN 0x0c 
    .byte 0x18              ;c70b  18          UNKNOWN 0x18 
    .byte 0x65              ;c70c  65          UNKNOWN 0x65 'e' 
    .byte 0xf7              ;c70d  f7          UNKNOWN 0xf7 
    .byte 0xc5              ;c70e  c5          UNKNOWN 0xc5 
    .byte 0xf9              ;c70f  f9          UNKNOWN 0xf9 
    .byte 0xb0              ;c710  b0          UNKNOWN 0xb0 
    .byte 0x05              ;c711  05          UNKNOWN 0x05 
    .byte 0xc8              ;c712  c8          UNKNOWN 0xc8 
    .byte 0xc8              ;c713  c8          UNKNOWN 0xc8 
    .byte 0xc8              ;c714  c8          UNKNOWN 0xc8 
    .byte 0x80              ;c715  80          UNKNOWN 0x80 
    .byte 0xee              ;c716  ee          UNKNOWN 0xee 
    .byte 0xc8              ;c717  c8          UNKNOWN 0xc8 
    .byte 0xb1              ;c718  b1          UNKNOWN 0xb1 
    .byte 0xf5              ;c719  f5          UNKNOWN 0xf5 
    .byte 0xc5              ;c71a  c5          UNKNOWN 0xc5 
    .byte 0xfa              ;c71b  fa          UNKNOWN 0xfa 
    .byte 0x90              ;c71c  90          UNKNOWN 0x90 
    .byte 0x02              ;c71d  02          UNKNOWN 0x02 
    .byte 0xa5              ;c71e  a5          UNKNOWN 0xa5 
    .byte 0xfa              ;c71f  fa          UNKNOWN 0xfa 
    .byte 0x60              ;c720  60          UNKNOWN 0x60 '`' 
    .byte 0x17              ;c721  17          UNKNOWN 0x17 
    .byte 0xc0              ;c722  c0          UNKNOWN 0xc0 
    .byte 0x01              ;c723  01          UNKNOWN 0x01 
    .byte 0x60              ;c724  60          UNKNOWN 0x60 '`' 
    .byte 0xa7              ;c725  a7          UNKNOWN 0xa7 
    .byte 0x6c              ;c726  6c          UNKNOWN 0x6c 'l' 
    .byte 0x73              ;c727  73          UNKNOWN 0x73 's' 
    .byte 0x20              ;c728  20          UNKNOWN 0x20 ' ' 
    .byte 0x63              ;c729  63          UNKNOWN 0x63 'c' 
    .byte 0xd0              ;c72a  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;c72b  f0          UNKNOWN 0xf0 
    .byte 0x32              ;c72c  32          UNKNOWN 0x32 '2' 
    .byte 0x20              ;c72d  20          UNKNOWN 0x20 ' ' 
    .byte 0xe6              ;c72e  e6          UNKNOWN 0xe6 
    .byte 0xd0              ;c72f  d0          UNKNOWN 0xd0 
    .byte 0xc9              ;c730  c9          UNKNOWN 0xc9 
    .byte 0xff              ;c731  ff          UNKNOWN 0xff 
    .byte 0xf0              ;c732  f0          UNKNOWN 0xf0 
    .byte 0x2b              ;c733  2b          UNKNOWN 0x2b '+' 
    .byte 0xc9              ;c734  c9          UNKNOWN 0xc9 
    .byte 0x33              ;c735  33          UNKNOWN 0x33 '3' 
    .byte 0x90              ;c736  90          UNKNOWN 0x90 
    .byte 0x03              ;c737  03          UNKNOWN 0x03 
    .byte 0x4c              ;c738  4c          UNKNOWN 0x4c 'L' 
    .byte 0xc5              ;c739  c5          UNKNOWN 0xc5 
    .byte 0xc8              ;c73a  c8          UNKNOWN 0xc8 
    .byte 0xc9              ;c73b  c9          UNKNOWN 0xc9 
    .byte 0x15              ;c73c  15          UNKNOWN 0x15 
    .byte 0x90              ;c73d  90          UNKNOWN 0x90 
    .byte 0x03              ;c73e  03          UNKNOWN 0x03 
    .byte 0x4c              ;c73f  4c          UNKNOWN 0x4c 'L' 
    .byte 0xa7              ;c740  a7          UNKNOWN 0xa7 
    .byte 0xc8              ;c741  c8          UNKNOWN 0xc8 
    .byte 0xc9              ;c742  c9          UNKNOWN 0xc9 
    .byte 0x0b              ;c743  0b          UNKNOWN 0x0b 
    .byte 0x90              ;c744  90          UNKNOWN 0x90 
    .byte 0x03              ;c745  03          UNKNOWN 0x03 
    .byte 0x4c              ;c746  4c          UNKNOWN 0x4c 'L' 
    .byte 0x77              ;c747  77          UNKNOWN 0x77 'w' 
    .byte 0xc8              ;c748  c8          UNKNOWN 0xc8 
    .byte 0xc9              ;c749  c9          UNKNOWN 0xc9 
    .byte 0x06              ;c74a  06          UNKNOWN 0x06 
    .byte 0x90              ;c74b  90          UNKNOWN 0x90 
    .byte 0x03              ;c74c  03          UNKNOWN 0x03 
    .byte 0x4c              ;c74d  4c          UNKNOWN 0x4c 'L' 
    .byte 0x3a              ;c74e  3a          UNKNOWN 0x3a ':' 
    .byte 0xc8              ;c74f  c8          UNKNOWN 0xc8 
    .byte 0xc9              ;c750  c9          UNKNOWN 0xc9 
    .byte 0x00              ;c751  00          UNKNOWN 0x00 
    .byte 0x90              ;c752  90          UNKNOWN 0x90 
    .byte 0x03              ;c753  03          UNKNOWN 0x03 
    .byte 0x4c              ;c754  4c          UNKNOWN 0x4c 'L' 
    .byte 0x1c              ;c755  1c          UNKNOWN 0x1c 
    .byte 0xc8              ;c756  c8          UNKNOWN 0xc8 
    .byte 0x20              ;c757  20          UNKNOWN 0x20 ' ' 
    .byte 0x74              ;c758  74          UNKNOWN 0x74 't' 
    .byte 0xc9              ;c759  c9          UNKNOWN 0xc9 
    .byte 0xb0              ;c75a  b0          UNKNOWN 0xb0 
    .byte 0x21              ;c75b  21          UNKNOWN 0x21 '!' 
    .byte 0x4c              ;c75c  4c          UNKNOWN 0x4c 'L' 
    .byte 0x1c              ;c75d  1c          UNKNOWN 0x1c 
    .byte 0xc8              ;c75e  c8          UNKNOWN 0xc8 
    .byte 0x3c              ;c75f  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c760  00          UNKNOWN 0x00 
    .byte 0x8c              ;c761  8c          UNKNOWN 0x8c 
    .byte 0x20              ;c762  20          UNKNOWN 0x20 ' ' 
    .byte 0xe3              ;c763  e3          UNKNOWN 0xe3 
    .byte 0xc8              ;c764  c8          UNKNOWN 0xc8 
    .byte 0xaa              ;c765  aa          UNKNOWN 0xaa 
    .byte 0x08              ;c766  08          UNKNOWN 0x08 
    .byte 0x78              ;c767  78          UNKNOWN 0x78 'x' 
    .byte 0xa5              ;c768  a5          UNKNOWN 0xa5 
    .byte 0x04              ;c769  04          UNKNOWN 0x04 
    .byte 0x29              ;c76a  29          UNKNOWN 0x29 ')' 
    .byte 0x03              ;c76b  03          UNKNOWN 0x03 
    .byte 0x1d              ;c76c  1d          UNKNOWN 0x1d 
    .byte 0x62              ;c76d  62          UNKNOWN 0x62 'b' 
    .byte 0xc9              ;c76e  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c76f  85          UNKNOWN 0x85 
    .byte 0x04              ;c770  04          UNKNOWN 0x04 
    .byte 0x28              ;c771  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c772  ea          UNKNOWN 0xea 
    .byte 0xa5              ;c773  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c774  6d          UNKNOWN 0x6d 'm' 
    .byte 0x29              ;c775  29          UNKNOWN 0x29 ')' 
    .byte 0x81              ;c776  81          UNKNOWN 0x81 
    .byte 0x1d              ;c777  1d          UNKNOWN 0x1d 
    .byte 0x63              ;c778  63          UNKNOWN 0x63 'c' 
    .byte 0xc9              ;c779  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c77a  85          UNKNOWN 0x85 
    .byte 0x6d              ;c77b  6d          UNKNOWN 0x6d 'm' 
    .byte 0x60              ;c77c  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c77d  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c77e  00          UNKNOWN 0x00 
    .byte 0x8c              ;c77f  8c          UNKNOWN 0x8c 
    .byte 0x20              ;c780  20          UNKNOWN 0x20 ' ' 
    .byte 0xe3              ;c781  e3          UNKNOWN 0xe3 
    .byte 0xc8              ;c782  c8          UNKNOWN 0xc8 
    .byte 0xaa              ;c783  aa          UNKNOWN 0xaa 
    .byte 0x08              ;c784  08          UNKNOWN 0x08 
    .byte 0x78              ;c785  78          UNKNOWN 0x78 'x' 
    .byte 0xa5              ;c786  a5          UNKNOWN 0xa5 
    .byte 0x04              ;c787  04          UNKNOWN 0x04 
    .byte 0x29              ;c788  29          UNKNOWN 0x29 ')' 
    .byte 0x03              ;c789  03          UNKNOWN 0x03 
    .byte 0x1d              ;c78a  1d          UNKNOWN 0x1d 
    .byte 0x50              ;c78b  50          UNKNOWN 0x50 'P' 
    .byte 0xc9              ;c78c  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c78d  85          UNKNOWN 0x85 
    .byte 0x04              ;c78e  04          UNKNOWN 0x04 
    .byte 0x28              ;c78f  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c790  ea          UNKNOWN 0xea 
    .byte 0xa5              ;c791  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c792  6d          UNKNOWN 0x6d 'm' 
    .byte 0x29              ;c793  29          UNKNOWN 0x29 ')' 
    .byte 0x81              ;c794  81          UNKNOWN 0x81 
    .byte 0x1d              ;c795  1d          UNKNOWN 0x1d 
    .byte 0x51              ;c796  51          UNKNOWN 0x51 'Q' 
    .byte 0xc9              ;c797  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c798  85          UNKNOWN 0x85 
    .byte 0x6d              ;c799  6d          UNKNOWN 0x6d 'm' 
    .byte 0x60              ;c79a  60          UNKNOWN 0x60 '`' 
    .byte 0x60              ;c79b  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c79c  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c79d  00          UNKNOWN 0x00 
    .byte 0x8c              ;c79e  8c          UNKNOWN 0x8c 
    .byte 0x20              ;c79f  20          UNKNOWN 0x20 ' ' 
    .byte 0xe3              ;c7a0  e3          UNKNOWN 0xe3 

sub_c7a1:
    iny                     ;c7a1  c8       
    tax                     ;c7a2  aa       
    php                     ;c7a3  08       
    sei                     ;c7a4  78       
    lda P2                  ;c7a5  a5 04    
    and #0x03               ;c7a7  29 03    
    ora mem_c93e,x          ;c7a9  1d 3e c9 
    sta P2                  ;c7ac  85 04    
    plp                     ;c7ae  28       
    nop                     ;c7af  ea       
    lda mem_006d            ;c7b0  a5 6d    
    and #0x81               ;c7b2  29 81    
    ora mem_c93f,x          ;c7b4  1d 3f c9 
    sta mem_006d            ;c7b7  85 6d    
    rts                     ;c7b9  60       

    .byte 0xa5              ;c7ba  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c7bb  6d          UNKNOWN 0x6d 'm' 
    .byte 0x48              ;c7bc  48          UNKNOWN 0x48 'H' 
    .byte 0x20              ;c7bd  20          UNKNOWN 0x20 ' ' 
    .byte 0xe3              ;c7be  e3          UNKNOWN 0xe3 
    .byte 0xc8              ;c7bf  c8          UNKNOWN 0xc8 
    .byte 0xaa              ;c7c0  aa          UNKNOWN 0xaa 
    .byte 0x08              ;c7c1  08          UNKNOWN 0x08 
    .byte 0x78              ;c7c2  78          UNKNOWN 0x78 'x' 
    .byte 0xa5              ;c7c3  a5          UNKNOWN 0xa5 
    .byte 0x04              ;c7c4  04          UNKNOWN 0x04 
    .byte 0x29              ;c7c5  29          UNKNOWN 0x29 ')' 
    .byte 0x13              ;c7c6  13          UNKNOWN 0x13 
    .byte 0x1d              ;c7c7  1d          UNKNOWN 0x1d 
    .byte 0x2c              ;c7c8  2c          UNKNOWN 0x2c ',' 
    .byte 0xc9              ;c7c9  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c7ca  85          UNKNOWN 0x85 
    .byte 0x04              ;c7cb  04          UNKNOWN 0x04 
    .byte 0x28              ;c7cc  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c7cd  ea          UNKNOWN 0xea 
    .byte 0xa5              ;c7ce  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c7cf  6d          UNKNOWN 0x6d 'm' 
    .byte 0x29              ;c7d0  29          UNKNOWN 0x29 ')' 
    .byte 0x81              ;c7d1  81          UNKNOWN 0x81 
    .byte 0x1d              ;c7d2  1d          UNKNOWN 0x1d 
    .byte 0x2d              ;c7d3  2d          UNKNOWN 0x2d '-' 
    .byte 0xc9              ;c7d4  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c7d5  85          UNKNOWN 0x85 
    .byte 0x6d              ;c7d6  6d          UNKNOWN 0x6d 'm' 
    .byte 0x68              ;c7d7  68          UNKNOWN 0x68 'h' 
    .byte 0x29              ;c7d8  29          UNKNOWN 0x29 ')' 
    .byte 0x40              ;c7d9  40          UNKNOWN 0x40 '@' 
    .byte 0xc9              ;c7da  c9          UNKNOWN 0xc9 
    .byte 0x40              ;c7db  40          UNKNOWN 0x40 '@' 
    .byte 0xf0              ;c7dc  f0          UNKNOWN 0xf0 
    .byte 0x08              ;c7dd  08          UNKNOWN 0x08 
    .byte 0xbd              ;c7de  bd          UNKNOWN 0xbd 
    .byte 0x2e              ;c7df  2e          UNKNOWN 0x2e '.' 
    .byte 0xc9              ;c7e0  c9          UNKNOWN 0xc9 
    .byte 0x73              ;c7e1  73          UNKNOWN 0x73 's' 
    .byte 0x0f              ;c7e2  0f          UNKNOWN 0x0f 
    .byte 0x20              ;c7e3  20          UNKNOWN 0x20 ' ' 
    .byte 0xb5              ;c7e4  b5          UNKNOWN 0xb5 
    .byte 0xce              ;c7e5  ce          UNKNOWN 0xce 
    .byte 0xbd              ;c7e6  bd          UNKNOWN 0xbd 
    .byte 0x2e              ;c7e7  2e          UNKNOWN 0x2e '.' 
    .byte 0xc9              ;c7e8  c9          UNKNOWN 0xc9 
    .byte 0x93              ;c7e9  93          UNKNOWN 0x93 
    .byte 0x08              ;c7ea  08          UNKNOWN 0x08 
    .byte 0xa5              ;c7eb  a5          UNKNOWN 0xa5 
    .byte 0x8c              ;c7ec  8c          UNKNOWN 0x8c 
    .byte 0xd0              ;c7ed  d0          UNKNOWN 0xd0 
    .byte 0x03              ;c7ee  03          UNKNOWN 0x03 
    .byte 0x20              ;c7ef  20          UNKNOWN 0x20 ' ' 
    .byte 0x82              ;c7f0  82          UNKNOWN 0x82 
    .byte 0xce              ;c7f1  ce          UNKNOWN 0xce 
    .byte 0x60              ;c7f2  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c7f3  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c7f4  00          UNKNOWN 0x00 
    .byte 0x8c              ;c7f5  8c          UNKNOWN 0x8c 
    .byte 0x60              ;c7f6  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c7f7  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c7f8  00          UNKNOWN 0x00 
    .byte 0x8c              ;c7f9  8c          UNKNOWN 0x8c 
    .byte 0xa5              ;c7fa  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c7fb  6d          UNKNOWN 0x6d 'm' 
    .byte 0x48              ;c7fc  48          UNKNOWN 0x48 'H' 
    .byte 0x20              ;c7fd  20          UNKNOWN 0x20 ' ' 
    .byte 0xe3              ;c7fe  e3          UNKNOWN 0xe3 
    .byte 0xc8              ;c7ff  c8          UNKNOWN 0xc8 
    .byte 0xaa              ;c800  aa          UNKNOWN 0xaa 
    .byte 0x08              ;c801  08          UNKNOWN 0x08 
    .byte 0x78              ;c802  78          UNKNOWN 0x78 'x' 
    .byte 0xa5              ;c803  a5          UNKNOWN 0xa5 
    .byte 0x04              ;c804  04          UNKNOWN 0x04 
    .byte 0x29              ;c805  29          UNKNOWN 0x29 ')' 
    .byte 0x03              ;c806  03          UNKNOWN 0x03 
    .byte 0x1d              ;c807  1d          UNKNOWN 0x1d 
    .byte 0x1a              ;c808  1a          UNKNOWN 0x1a 
    .byte 0xc9              ;c809  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c80a  85          UNKNOWN 0x85 
    .byte 0x04              ;c80b  04          UNKNOWN 0x04 
    .byte 0x28              ;c80c  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c80d  ea          UNKNOWN 0xea 
    .byte 0xa5              ;c80e  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c80f  6d          UNKNOWN 0x6d 'm' 
    .byte 0x29              ;c810  29          UNKNOWN 0x29 ')' 
    .byte 0x81              ;c811  81          UNKNOWN 0x81 
    .byte 0x1d              ;c812  1d          UNKNOWN 0x1d 
    .byte 0x1b              ;c813  1b          UNKNOWN 0x1b 
    .byte 0xc9              ;c814  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c815  85          UNKNOWN 0x85 
    .byte 0x6d              ;c816  6d          UNKNOWN 0x6d 'm' 
    .byte 0x68              ;c817  68          UNKNOWN 0x68 'h' 
    .byte 0x29              ;c818  29          UNKNOWN 0x29 ')' 
    .byte 0x70              ;c819  70          UNKNOWN 0x70 'p' 
    .byte 0xc9              ;c81a  c9          UNKNOWN 0xc9 
    .byte 0x20              ;c81b  20          UNKNOWN 0x20 ' ' 
    .byte 0xf0              ;c81c  f0          UNKNOWN 0xf0 
    .byte 0x08              ;c81d  08          UNKNOWN 0x08 
    .byte 0xbd              ;c81e  bd          UNKNOWN 0xbd 
    .byte 0x1c              ;c81f  1c          UNKNOWN 0x1c 
    .byte 0xc9              ;c820  c9          UNKNOWN 0xc9 
    .byte 0x53              ;c821  53          UNKNOWN 0x53 'S' 
    .byte 0xcf              ;c822  cf          UNKNOWN 0xcf 
    .byte 0x20              ;c823  20          UNKNOWN 0x20 ' ' 
    .byte 0xa5              ;c824  a5          UNKNOWN 0xa5 
    .byte 0xce              ;c825  ce          UNKNOWN 0xce 
    .byte 0x60              ;c826  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c827  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c828  00          UNKNOWN 0x00 
    .byte 0x8c              ;c829  8c          UNKNOWN 0x8c 
    .byte 0x20              ;c82a  20          UNKNOWN 0x20 ' ' 
    .byte 0xe3              ;c82b  e3          UNKNOWN 0xe3 
    .byte 0xc8              ;c82c  c8          UNKNOWN 0xc8 
    .byte 0xaa              ;c82d  aa          UNKNOWN 0xaa 
    .byte 0x08              ;c82e  08          UNKNOWN 0x08 
    .byte 0x78              ;c82f  78          UNKNOWN 0x78 'x' 
    .byte 0xa5              ;c830  a5          UNKNOWN 0xa5 
    .byte 0x04              ;c831  04          UNKNOWN 0x04 
    .byte 0x29              ;c832  29          UNKNOWN 0x29 ')' 
    .byte 0x03              ;c833  03          UNKNOWN 0x03 
    .byte 0x1d              ;c834  1d          UNKNOWN 0x1d 
    .byte 0x08              ;c835  08          UNKNOWN 0x08 
    .byte 0xc9              ;c836  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c837  85          UNKNOWN 0x85 
    .byte 0x04              ;c838  04          UNKNOWN 0x04 
    .byte 0x28              ;c839  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c83a  ea          UNKNOWN 0xea 
    .byte 0xa5              ;c83b  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c83c  6d          UNKNOWN 0x6d 'm' 
    .byte 0x29              ;c83d  29          UNKNOWN 0x29 ')' 
    .byte 0x81              ;c83e  81          UNKNOWN 0x81 
    .byte 0x1d              ;c83f  1d          UNKNOWN 0x1d 
    .byte 0x09              ;c840  09          UNKNOWN 0x09 
    .byte 0xc9              ;c841  c9          UNKNOWN 0xc9 
    .byte 0x85              ;c842  85          UNKNOWN 0x85 
    .byte 0x6d              ;c843  6d          UNKNOWN 0x6d 'm' 
    .byte 0x60              ;c844  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;c845  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;c846  00          UNKNOWN 0x00 
    .byte 0x8c              ;c847  8c          UNKNOWN 0x8c 
    .byte 0x20              ;c848  20          UNKNOWN 0x20 ' ' 
    .byte 0xe3              ;c849  e3          UNKNOWN 0xe3 
    .byte 0xc8              ;c84a  c8          UNKNOWN 0xc8 
    .byte 0xaa              ;c84b  aa          UNKNOWN 0xaa 
    .byte 0x08              ;c84c  08          UNKNOWN 0x08 
    .byte 0x78              ;c84d  78          UNKNOWN 0x78 'x' 
    .byte 0xa5              ;c84e  a5          UNKNOWN 0xa5 
    .byte 0x04              ;c84f  04          UNKNOWN 0x04 
    .byte 0x29              ;c850  29          UNKNOWN 0x29 ')' 
    .byte 0x03              ;c851  03          UNKNOWN 0x03 
    .byte 0x1d              ;c852  1d          UNKNOWN 0x1d 
    .byte 0xf6              ;c853  f6          UNKNOWN 0xf6 
    .byte 0xc8              ;c854  c8          UNKNOWN 0xc8 
    .byte 0x85              ;c855  85          UNKNOWN 0x85 
    .byte 0x04              ;c856  04          UNKNOWN 0x04 
    .byte 0x28              ;c857  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;c858  ea          UNKNOWN 0xea 
    .byte 0xa5              ;c859  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;c85a  6d          UNKNOWN 0x6d 'm' 
    .byte 0x29              ;c85b  29          UNKNOWN 0x29 ')' 
    .byte 0x81              ;c85c  81          UNKNOWN 0x81 
    .byte 0x1d              ;c85d  1d          UNKNOWN 0x1d 
    .byte 0xf7              ;c85e  f7          UNKNOWN 0xf7 
    .byte 0xc8              ;c85f  c8          UNKNOWN 0xc8 
    .byte 0x85              ;c860  85          UNKNOWN 0x85 
    .byte 0x6d              ;c861  6d          UNKNOWN 0x6d 'm' 
    .byte 0x60              ;c862  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;c863  a9          UNKNOWN 0xa9 
    .byte 0x00              ;c864  00          UNKNOWN 0x00 
    .byte 0xa7              ;c865  a7          UNKNOWN 0xa7 
    .byte 0x50              ;c866  50          UNKNOWN 0x50 'P' 
    .byte 0x07              ;c867  07          UNKNOWN 0x07 
    .byte 0xa9              ;c868  a9          UNKNOWN 0xa9 
    .byte 0x06              ;c869  06          UNKNOWN 0x06 
    .byte 0xc7              ;c86a  c7          UNKNOWN 0xc7 
    .byte 0x50              ;c86b  50          UNKNOWN 0x50 'P' 
    .byte 0x02              ;c86c  02          UNKNOWN 0x02 
    .byte 0xa9              ;c86d  a9          UNKNOWN 0xa9 
    .byte 0x0c              ;c86e  0c          UNKNOWN 0x0c 
    .byte 0x07              ;c86f  07          UNKNOWN 0x07 
    .byte 0x6d              ;c870  6d          UNKNOWN 0x6d 'm' 
    .byte 0x03              ;c871  03          UNKNOWN 0x03 
    .byte 0x18              ;c872  18          UNKNOWN 0x18 
    .byte 0x69              ;c873  69          UNKNOWN 0x69 'i' 
    .byte 0x03              ;c874  03          UNKNOWN 0x03 
    .byte 0x60              ;c875  60          UNKNOWN 0x60 '`' 
    .byte 0x30              ;c876  30          UNKNOWN 0x30 '0' 
    .byte 0x10              ;c877  10          UNKNOWN 0x10 
    .byte 0x02              ;c878  02          UNKNOWN 0x02 
    .byte 0x10              ;c879  10          UNKNOWN 0x10 
    .byte 0x10              ;c87a  10          UNKNOWN 0x10 
    .byte 0x02              ;c87b  02          UNKNOWN 0x02 
    .byte 0xbc              ;c87c  bc          UNKNOWN 0xbc 
    .byte 0x10              ;c87d  10          UNKNOWN 0x10 
    .byte 0x00              ;c87e  00          UNKNOWN 0x00 
    .byte 0x9c              ;c87f  9c          UNKNOWN 0x9c 
    .byte 0x30              ;c880  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c881  00          UNKNOWN 0x00 
    .byte 0x9c              ;c882  9c          UNKNOWN 0x9c 
    .byte 0x10              ;c883  10          UNKNOWN 0x10 
    .byte 0x00              ;c884  00          UNKNOWN 0x00 
    .byte 0x9c              ;c885  9c          UNKNOWN 0x9c 
    .byte 0x10              ;c886  10          UNKNOWN 0x10 
    .byte 0x00              ;c887  00          UNKNOWN 0x00 
    .byte 0x30              ;c888  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c889  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c88a  02          UNKNOWN 0x02 
    .byte 0x00              ;c88b  00          UNKNOWN 0x00 
    .byte 0x30              ;c88c  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c88d  02          UNKNOWN 0x02 
    .byte 0xb8              ;c88e  b8          UNKNOWN 0xb8 
    .byte 0x30              ;c88f  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c890  00          UNKNOWN 0x00 
    .byte 0x88              ;c891  88          UNKNOWN 0x88 
    .byte 0x30              ;c892  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c893  00          UNKNOWN 0x00 
    .byte 0x88              ;c894  88          UNKNOWN 0x88 
    .byte 0x30              ;c895  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c896  00          UNKNOWN 0x00 
    .byte 0x88              ;c897  88          UNKNOWN 0x88 
    .byte 0x30              ;c898  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c899  00          UNKNOWN 0x00 
    .byte 0x30              ;c89a  30          UNKNOWN 0x30 '0' 
    .byte 0x20              ;c89b  20          UNKNOWN 0x20 ' ' 
    .byte 0x02              ;c89c  02          UNKNOWN 0x02 
    .byte 0x20              ;c89d  20          UNKNOWN 0x20 ' ' 
    .byte 0x20              ;c89e  20          UNKNOWN 0x20 ' ' 
    .byte 0x02              ;c89f  02          UNKNOWN 0x02 
    .byte 0xb4              ;c8a0  b4          UNKNOWN 0xb4 
    .byte 0x20              ;c8a1  20          UNKNOWN 0x20 ' ' 
    .byte 0x00              ;c8a2  00          UNKNOWN 0x00 
    .byte 0xa4              ;c8a3  a4          UNKNOWN 0xa4 
    .byte 0x20              ;c8a4  20          UNKNOWN 0x20 ' ' 
    .byte 0x00              ;c8a5  00          UNKNOWN 0x00 
    .byte 0xa4              ;c8a6  a4          UNKNOWN 0xa4 
    .byte 0x20              ;c8a7  20          UNKNOWN 0x20 ' ' 
    .byte 0x04              ;c8a8  04          UNKNOWN 0x04 
    .byte 0xa4              ;c8a9  a4          UNKNOWN 0xa4 
    .byte 0x20              ;c8aa  20          UNKNOWN 0x20 ' ' 
    .byte 0x00              ;c8ab  00          UNKNOWN 0x00 
    .byte 0x30              ;c8ac  30          UNKNOWN 0x30 '0' 
    .byte 0x70              ;c8ad  70          UNKNOWN 0x70 'p' 
    .byte 0x02              ;c8ae  02          UNKNOWN 0x02 
    .byte 0x20              ;c8af  20          UNKNOWN 0x20 ' ' 
    .byte 0x70              ;c8b0  70          UNKNOWN 0x70 'p' 
    .byte 0x12              ;c8b1  12          UNKNOWN 0x12 
    .byte 0xb0              ;c8b2  b0          UNKNOWN 0xb0 
    .byte 0x70              ;c8b3  70          UNKNOWN 0x70 'p' 
    .byte 0x02              ;c8b4  02          UNKNOWN 0x02 
    .byte 0xa0              ;c8b5  a0          UNKNOWN 0xa0 
    .byte 0x70              ;c8b6  70          UNKNOWN 0x70 'p' 
    .byte 0x12              ;c8b7  12          UNKNOWN 0x12 
    .byte 0xa0              ;c8b8  a0          UNKNOWN 0xa0 
    .byte 0x70              ;c8b9  70          UNKNOWN 0x70 'p' 
    .byte 0x1a              ;c8ba  1a          UNKNOWN 0x1a 
    .byte 0xa0              ;c8bb  a0          UNKNOWN 0xa0 
    .byte 0x70              ;c8bc  70          UNKNOWN 0x70 'p' 
    .byte 0x12              ;c8bd  12          UNKNOWN 0x12 
    .byte 0x30              ;c8be  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c8bf  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8c0  02          UNKNOWN 0x02 
    .byte 0x30              ;c8c1  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c8c2  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8c3  02          UNKNOWN 0x02 
    .byte 0x30              ;c8c4  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c8c5  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8c6  02          UNKNOWN 0x02 
    .byte 0xb0              ;c8c7  b0          UNKNOWN 0xb0 
    .byte 0x30              ;c8c8  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8c9  02          UNKNOWN 0x02 
    .byte 0x30              ;c8ca  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c8cb  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8cc  02          UNKNOWN 0x02 
    .byte 0xb0              ;c8cd  b0          UNKNOWN 0xb0 
    .byte 0x30              ;c8ce  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8cf  02          UNKNOWN 0x02 
    .byte 0x70              ;c8d0  70          UNKNOWN 0x70 'p' 
    .byte 0x30              ;c8d1  30          UNKNOWN 0x30 '0' 
    .byte 0x03              ;c8d2  03          UNKNOWN 0x03 
    .byte 0x70              ;c8d3  70          UNKNOWN 0x70 'p' 
    .byte 0x30              ;c8d4  30          UNKNOWN 0x30 '0' 
    .byte 0x03              ;c8d5  03          UNKNOWN 0x03 
    .byte 0x70              ;c8d6  70          UNKNOWN 0x70 'p' 
    .byte 0x30              ;c8d7  30          UNKNOWN 0x30 '0' 
    .byte 0x03              ;c8d8  03          UNKNOWN 0x03 
    .byte 0xf0              ;c8d9  f0          UNKNOWN 0xf0 
    .byte 0x30              ;c8da  30          UNKNOWN 0x30 '0' 
    .byte 0x03              ;c8db  03          UNKNOWN 0x03 
    .byte 0x30              ;c8dc  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c8dd  30          UNKNOWN 0x30 '0' 
    .byte 0x03              ;c8de  03          UNKNOWN 0x03 
    .byte 0xb0              ;c8df  b0          UNKNOWN 0xb0 
    .byte 0x30              ;c8e0  30          UNKNOWN 0x30 '0' 
    .byte 0x03              ;c8e1  03          UNKNOWN 0x03 
    .byte 0x30              ;c8e2  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c8e3  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8e4  02          UNKNOWN 0x02 
    .byte 0x30              ;c8e5  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;c8e6  30          UNKNOWN 0x30 '0' 
    .byte 0x02              ;c8e7  02          UNKNOWN 0x02 
    .byte 0xbc              ;c8e8  bc          UNKNOWN 0xbc 
    .byte 0x30              ;c8e9  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c8ea  00          UNKNOWN 0x00 
    .byte 0xbc              ;c8eb  bc          UNKNOWN 0xbc 
    .byte 0x30              ;c8ec  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c8ed  00          UNKNOWN 0x00 
    .byte 0xbc              ;c8ee  bc          UNKNOWN 0xbc 
    .byte 0x30              ;c8ef  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c8f0  00          UNKNOWN 0x00 
    .byte 0xbc              ;c8f1  bc          UNKNOWN 0xbc 
    .byte 0x30              ;c8f2  30          UNKNOWN 0x30 '0' 
    .byte 0x00              ;c8f3  00          UNKNOWN 0x00 
    .byte 0x17              ;c8f4  17          UNKNOWN 0x17 
    .byte 0x6d              ;c8f5  6d          UNKNOWN 0x6d 'm' 
    .byte 0x32              ;c8f6  32          UNKNOWN 0x32 '2' 
    .byte 0x20              ;c8f7  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;c8f8  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;c8f9  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;c8fa  f0          UNKNOWN 0xf0 
    .byte 0x0b              ;c8fb  0b          UNKNOWN 0x0b 
    .byte 0x85              ;c8fc  85          UNKNOWN 0x85 
    .byte 0xf8              ;c8fd  f8          UNKNOWN 0xf8 
    .byte 0xa5              ;c8fe  a5          UNKNOWN 0xa5 
    .byte 0x71              ;c8ff  71          UNKNOWN 0x71 'q' 
    .byte 0x87              ;c900  87          UNKNOWN 0x87 
    .byte 0xf7              ;c901  f7          UNKNOWN 0xf7 
    .byte 0x20              ;c902  20          UNKNOWN 0x20 ' ' 
    .byte 0xab              ;c903  ab          UNKNOWN 0xab 
    .byte 0xc9              ;c904  c9          UNKNOWN 0xc9 
    .byte 0xb0              ;c905  b0          UNKNOWN 0xb0 
    .byte 0x23              ;c906  23          UNKNOWN 0x23 '#' 
    .byte 0x20              ;c907  20          UNKNOWN 0x20 ' ' 
    .byte 0x57              ;c908  57          UNKNOWN 0x57 'W' 
    .byte 0xd0              ;c909  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;c90a  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;c90b  0c          UNKNOWN 0x0c 
    .byte 0x85              ;c90c  85          UNKNOWN 0x85 
    .byte 0xf8              ;c90d  f8          UNKNOWN 0xf8 
    .byte 0xad              ;c90e  ad          UNKNOWN 0xad 
    .byte 0x0a              ;c90f  0a          UNKNOWN 0x0a 
    .byte 0x01              ;c910  01          UNKNOWN 0x01 
    .byte 0x85              ;c911  85          UNKNOWN 0x85 
    .byte 0xf7              ;c912  f7          UNKNOWN 0xf7 
    .byte 0x20              ;c913  20          UNKNOWN 0x20 ' ' 
    .byte 0xab              ;c914  ab          UNKNOWN 0xab 
    .byte 0xc9              ;c915  c9          UNKNOWN 0xc9 
    .byte 0xb0              ;c916  b0          UNKNOWN 0xb0 
    .byte 0x12              ;c917  12          UNKNOWN 0x12 
    .byte 0x20              ;c918  20          UNKNOWN 0x20 ' ' 
    .byte 0x5d              ;c919  5d          UNKNOWN 0x5d ']' 
    .byte 0xd0              ;c91a  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;c91b  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;c91c  0c          UNKNOWN 0x0c 
    .byte 0x85              ;c91d  85          UNKNOWN 0x85 
    .byte 0xf8              ;c91e  f8          UNKNOWN 0xf8 
    .byte 0xad              ;c91f  ad          UNKNOWN 0xad 
    .byte 0x0b              ;c920  0b          UNKNOWN 0x0b 
    .byte 0x01              ;c921  01          UNKNOWN 0x01 
    .byte 0x85              ;c922  85          UNKNOWN 0x85 
    .byte 0xf7              ;c923  f7          UNKNOWN 0xf7 
    .byte 0x20              ;c924  20          UNKNOWN 0x20 ' ' 
    .byte 0xab              ;c925  ab          UNKNOWN 0xab 
    .byte 0xc9              ;c926  c9          UNKNOWN 0xc9 
    .byte 0xb0              ;c927  b0          UNKNOWN 0xb0 
    .byte 0x01              ;c928  01          UNKNOWN 0x01 
    .byte 0x18              ;c929  18          UNKNOWN 0x18 
    .byte 0x60              ;c92a  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;c92b  a5          UNKNOWN 0xa5 
    .byte 0xf8              ;c92c  f8          UNKNOWN 0xf8 
    .byte 0xa2              ;c92d  a2          UNKNOWN 0xa2 
    .byte 0x74              ;c92e  74          UNKNOWN 0x74 't' 
    .byte 0xc9              ;c92f  c9          UNKNOWN 0xc9 
    .byte 0x08              ;c930  08          UNKNOWN 0x08 
    .byte 0xf0              ;c931  f0          UNKNOWN 0xf0 
    .byte 0x16              ;c932  16          UNKNOWN 0x16 
    .byte 0xa2              ;c933  a2          UNKNOWN 0xa2 
    .byte 0x64              ;c934  64          UNKNOWN 0x64 'd' 
    .byte 0xc9              ;c935  c9          UNKNOWN 0xc9 
    .byte 0x09              ;c936  09          UNKNOWN 0x09 
    .byte 0xf0              ;c937  f0          UNKNOWN 0xf0 
    .byte 0x10              ;c938  10          UNKNOWN 0x10 
    .byte 0xc9              ;c939  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;c93a  0a          UNKNOWN 0x0a 
    .byte 0xf0              ;c93b  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;c93c  0c          UNKNOWN 0x0c 
    .byte 0xa2              ;c93d  a2          UNKNOWN 0xa2 

mem_c93e:
    .byte 0x64              ;c93e  64          DATA 0x64 'd' 

mem_c93f:
    .byte 0xc9              ;c93f  c9          DATA 0xc9 
    .byte 0x05              ;c940  05          DATA 0x05 
    .byte 0xf0              ;c941  f0          DATA 0xf0 
    .byte 0x06              ;c942  06          DATA 0x06 
    .byte 0xa2              ;c943  a2          DATA 0xa2 
    .byte 0x64              ;c944  64          DATA 0x64 'd' 
    .byte 0xc9              ;c945  c9          DATA 0xc9 
    .byte 0x0d              ;c946  0d          DATA 0x0d 
    .byte 0xf0              ;c947  f0          DATA 0xf0 
    .byte 0x00              ;c948  00          DATA 0x00 
    .byte 0x8a              ;c949  8a          DATA 0x8a 
    .byte 0xc5              ;c94a  c5          DATA 0xc5 
    .byte 0xf7              ;c94b  f7          DATA 0xf7 
    .byte 0x60              ;c94c  60          DATA 0x60 '`' 
    .byte 0xa9              ;c94d  a9          DATA 0xa9 
    .byte 0x00              ;c94e  00          DATA 0x00 
    .byte 0x85              ;c94f  85          DATA 0x85 
    .byte 0xea              ;c950  ea          DATA 0xea 
    .byte 0xf7              ;c951  f7          DATA 0xf7 
    .byte 0x50              ;c952  50          DATA 0x50 'P' 
    .byte 0x1d              ;c953  1d          DATA 0x1d 
    .byte 0x97              ;c954  97          DATA 0x97 
    .byte 0xc1              ;c955  c1          DATA 0xc1 
    .byte 0x1c              ;c956  1c          DATA 0x1c 
    .byte 0x07              ;c957  07          DATA 0x07 
    .byte 0x6d              ;c958  6d          DATA 0x6d 'm' 
    .byte 0x19              ;c959  19          DATA 0x19 
    .byte 0x07              ;c95a  07          DATA 0x07 
    .byte 0x08              ;c95b  08          DATA 0x08 
    .byte 0x10              ;c95c  10          DATA 0x10 
    .byte 0x27              ;c95d  27          DATA 0x27 ''' 
    .byte 0x0e              ;c95e  0e          DATA 0x0e 
    .byte 0x0d              ;c95f  0d          DATA 0x0d 
    .byte 0x20              ;c960  20          DATA 0x20 ' ' 
    .byte 0x9a              ;c961  9a          DATA 0x9a 
    .byte 0xd0              ;c962  d0          DATA 0xd0 
    .byte 0xe0              ;c963  e0          DATA 0xe0 
    .byte 0x00              ;c964  00          DATA 0x00 
    .byte 0xd0              ;c965  d0          DATA 0xd0 
    .byte 0x06              ;c966  06          DATA 0x06 
    .byte 0xa9              ;c967  a9          DATA 0xa9 
    .byte 0x00              ;c968  00          DATA 0x00 
    .byte 0x85              ;c969  85          DATA 0x85 
    .byte 0xea              ;c96a  ea          DATA 0xea 
    .byte 0x80              ;c96b  80          DATA 0x80 
    .byte 0x04              ;c96c  04          DATA 0x04 
    .byte 0xa9              ;c96d  a9          DATA 0xa9 
    .byte 0xff              ;c96e  ff          DATA 0xff 
    .byte 0x85              ;c96f  85          DATA 0x85 
    .byte 0xea              ;c970  ea          DATA 0xea 
    .byte 0x18              ;c971  18          DATA 0x18 
    .byte 0x60              ;c972  60          DATA 0x60 '`' 
    .byte 0x38              ;c973  38          DATA 0x38 '8' 
    .byte 0x60              ;c974  60          DATA 0x60 '`' 
    .byte 0x20              ;c975  20          DATA 0x20 ' ' 
    .byte 0xfc              ;c976  fc          DATA 0xfc 
    .byte 0xc9              ;c977  c9          DATA 0xc9 
    .byte 0x20              ;c978  20          DATA 0x20 ' ' 
    .byte 0xfc              ;c979  fc          DATA 0xfc 
    .byte 0xc9              ;c97a  c9          DATA 0xc9 
    .byte 0x60              ;c97b  60          DATA 0x60 '`' 
    .byte 0x60              ;c97c  60          DATA 0x60 '`' 
    .byte 0xe7              ;c97d  e7          DATA 0xe7 
    .byte 0x50              ;c97e  50          DATA 0x50 'P' 
    .byte 0x1f              ;c97f  1f          DATA 0x1f 
    .byte 0x07              ;c980  07          DATA 0x07 
    .byte 0x6d              ;c981  6d          DATA 0x6d 'm' 
    .byte 0x1c              ;c982  1c          DATA 0x1c 
    .byte 0x0f              ;c983  0f          DATA 0x0f 
    .byte 0x04              ;c984  04          DATA 0x04 
    .byte 0x3c              ;c985  3c          DATA 0x3c '<' 
    .byte 0x04              ;c986  04          DATA 0x04 
    .byte 0xa7              ;c987  a7          DATA 0xa7 
    .byte 0xa9              ;c988  a9          DATA 0xa9 
    .byte 0xc8              ;c989  c8          DATA 0xc8 
    .byte 0x20              ;c98a  20          DATA 0x20 ' ' 
    .byte 0x77              ;c98b  77          DATA 0x77 'w' 
    .byte 0xcd              ;c98c  cd          DATA 0xcd 
    .byte 0xb0              ;c98d  b0          DATA 0xb0 
    .byte 0x04              ;c98e  04          DATA 0x04 
    .byte 0xa5              ;c98f  a5          DATA 0xa5 
    .byte 0xa7              ;c990  a7          DATA 0xa7 
    .byte 0xd0              ;c991  d0          DATA 0xd0 
    .byte 0xf7              ;c992  f7          DATA 0xf7 
    .byte 0x1f              ;c993  1f          DATA 0x1f 
    .byte 0x04              ;c994  04          DATA 0x04 
    .byte 0x3c              ;c995  3c          DATA 0x3c '<' 
    .byte 0x02              ;c996  02          DATA 0x02 
    .byte 0xa7              ;c997  a7          DATA 0xa7 
    .byte 0xea              ;c998  ea          DATA 0xea 
    .byte 0xa5              ;c999  a5          DATA 0xa5 
    .byte 0xa7              ;c99a  a7          DATA 0xa7 
    .byte 0xd0              ;c99b  d0          DATA 0xd0 
    .byte 0xfb              ;c99c  fb          DATA 0xfb 
    .byte 0xff              ;c99d  ff          DATA 0xff 
    .byte 0x95              ;c99e  95          DATA 0x95 
    .byte 0x60              ;c99f  60          DATA 0x60 '`' 
    .byte 0x1f              ;c9a0  1f          DATA 0x1f 
    .byte 0xc4              ;c9a1  c4          DATA 0xc4 
    .byte 0x20              ;c9a2  20          DATA 0x20 ' ' 
    .byte 0x52              ;c9a3  52          DATA 0x52 'R' 
    .byte 0xd0              ;c9a4  d0          DATA 0xd0 
    .byte 0xf0              ;c9a5  f0          DATA 0xf0 
    .byte 0xd6              ;c9a6  d6          DATA 0xd6 

lab_c9a7:
    cmp #0x08               ;c9a7  c9 08    
    beq lab_c9b5            ;c9a9  f0 0a    
    cmp #0x09               ;c9ab  c9 09    
    beq lab_c9b5            ;c9ad  f0 06    
    cmp #0x0a               ;c9af  c9 0a    
    beq lab_c9b5            ;c9b1  f0 02    
    bra lab_ca0c            ;c9b3  80 57    

lab_c9b5:
    bbs 0,mem_0050,lab_ca0c ;c9b5  07 50 54 
    jsr 0xc9cd              ;c9b8  20 cd c9 
    bcs lab_ca0c            ;c9bb  b0 4f    
    bbs 2,mem_00c0,lab_c9c3 ;c9bd  47 c0 03 
    bbs 5,mem_0050,lab_ca0c ;c9c0  a7 50 49 

lab_c9c3:
    bbs 5,mem_006c,lab_ca0c ;c9c3  a7 6c 46 
    lda mem_0073            ;c9c6  a5 73    
    bne lab_ca0c            ;c9c8  d0 42    
    clb 5,mem_006c          ;c9ca  bf 6c    
    bbs 0,mem_006d,lab_ca0c ;c9cc  07 6d 3d 
    lda mem_0071            ;c9cf  a5 71    
    cmp #0xa9               ;c9d1  c9 a9    
    beq lab_c9d7            ;c9d3  f0 02    
    bcs lab_ca0c            ;c9d5  b0 35    

lab_c9d7:
    lda mem_006e            ;c9d7  a5 6e    
    cmp #0xff               ;c9d9  c9 ff    
    beq lab_ca0c            ;c9db  f0 2f    
    cmp #0x5f               ;c9dd  c9 5f    
    bcc lab_c9e3            ;c9df  90 02    
    bra lab_ca0c            ;c9e1  80 29    

lab_c9e3:
    lda mem_0072            ;c9e3  a5 72    
    cmp mem_00ed            ;c9e5  c5 ed    
    bcs lab_ca0c            ;c9e7  b0 23    
    cmp mem_00f0            ;c9e9  c5 f0    
    bcc lab_ca0c            ;c9eb  90 1f    
    cmp mem_00ee            ;c9ed  c5 ee    
    bcs lab_c9fd            ;c9ef  b0 0c    

lab_c9f1:
    bbs 7,mem_00c1,lab_ca04 ;c9f1  e7 c1 10 
    lda mem_00ea            ;c9f4  a5 ea    
    bne lab_ca04            ;c9f6  d0 0c    
    jsr sub_ca8d            ;c9f8  20 8d ca 
    bra lab_ca07            ;c9fb  80 0a    

lab_c9fd:
    jsr sub_d052            ;c9fd  20 52 d0 
    cmp #0x08               ;ca00  c9 08    
    bne lab_c9f1            ;ca02  d0 ed    

lab_ca04:
    jsr sub_caa9            ;ca04  20 a9 ca 

lab_ca07:
    lda #0xc8               ;ca07  a9 c8    
    sta mem_0102            ;ca09  8d 02 01 

lab_ca0c:
    rts                     ;ca0c  60       

    .byte 0xef              ;ca0d  ef          UNKNOWN 0xef 
    .byte 0x6c              ;ca0e  6c          UNKNOWN 0x6c 'l' 
    .byte 0xcf              ;ca0f  cf          UNKNOWN 0xcf 
    .byte 0x6c              ;ca10  6c          UNKNOWN 0x6c 'l' 
    .byte 0xdf              ;ca11  df          UNKNOWN 0xdf 
    .byte 0x0a              ;ca12  0a          UNKNOWN 0x0a 
    .byte 0x3f              ;ca13  3f          UNKNOWN 0x3f '?' 
    .byte 0x04              ;ca14  04          UNKNOWN 0x04 
    .byte 0x0f              ;ca15  0f          UNKNOWN 0x0f 
    .byte 0x04              ;ca16  04          UNKNOWN 0x04 
    .byte 0x3c              ;ca17  3c          UNKNOWN 0x3c '<' 
    .byte 0x3c              ;ca18  3c          UNKNOWN 0x3c '<' 
    .byte 0xa6              ;ca19  a6          UNKNOWN 0xa6 
    .byte 0x3c              ;ca1a  3c          UNKNOWN 0x3c '<' 
    .byte 0xd2              ;ca1b  d2          UNKNOWN 0xd2 
    .byte 0x9c              ;ca1c  9c          UNKNOWN 0x9c 
    .byte 0x1f              ;ca1d  1f          UNKNOWN 0x1f 
    .byte 0x95              ;ca1e  95          UNKNOWN 0x95 
    .byte 0xa5              ;ca1f  a5          UNKNOWN 0xa5 

sub_ca20:
    bbc 7,a,lab_c9a7        ;ca20  f3 85    
    .byte 0xf4              ;ca22  f4       Illegal instruction

    .byte 0x3c              ;ca23  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;ca24  0a          UNKNOWN 0x0a 
    .byte 0x98              ;ca25  98          UNKNOWN 0x98 
    .byte 0x9f              ;ca26  9f          UNKNOWN 0x9f 
    .byte 0x95              ;ca27  95          UNKNOWN 0x95 
    .byte 0x60              ;ca28  60          UNKNOWN 0x60 '`' 
    .byte 0xef              ;ca29  ef          UNKNOWN 0xef 
    .byte 0x6c              ;ca2a  6c          UNKNOWN 0x6c 'l' 
    .byte 0xdf              ;ca2b  df          UNKNOWN 0xdf 
    .byte 0x6c              ;ca2c  6c          UNKNOWN 0x6c 'l' 
    .byte 0xdf              ;ca2d  df          UNKNOWN 0xdf 
    .byte 0x0a              ;ca2e  0a          UNKNOWN 0x0a 
    .byte 0x0f              ;ca2f  0f          UNKNOWN 0x0f 
    .byte 0x04              ;ca30  04          UNKNOWN 0x04 
    .byte 0x3f              ;ca31  3f          UNKNOWN 0x3f '?' 
    .byte 0x04              ;ca32  04          UNKNOWN 0x04 
    .byte 0x3c              ;ca33  3c          UNKNOWN 0x3c '<' 
    .byte 0x3c              ;ca34  3c          UNKNOWN 0x3c '<' 
    .byte 0xa6              ;ca35  a6          UNKNOWN 0xa6 
    .byte 0x3c              ;ca36  3c          UNKNOWN 0x3c '<' 
    .byte 0xd2              ;ca37  d2          UNKNOWN 0xd2 
    .byte 0x9c              ;ca38  9c          UNKNOWN 0x9c 
    .byte 0x1f              ;ca39  1f          UNKNOWN 0x1f 
    .byte 0x95              ;ca3a  95          UNKNOWN 0x95 
    .byte 0x3c              ;ca3b  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;ca3c  0a          UNKNOWN 0x0a 
    .byte 0x98              ;ca3d  98          UNKNOWN 0x98 
    .byte 0x3c              ;ca3e  3c          UNKNOWN 0x3c '<' 
    .byte 0x30              ;ca3f  30          UNKNOWN 0x30 '0' 
    .byte 0xe8              ;ca40  e8          UNKNOWN 0xe8 
    .byte 0x9f              ;ca41  9f          UNKNOWN 0x9f 
    .byte 0x95              ;ca42  95          UNKNOWN 0x95 
    .byte 0x60              ;ca43  60          UNKNOWN 0x60 '`' 
    .byte 0x4c              ;ca44  4c          UNKNOWN 0x4c 'L' 
    .byte 0x9b              ;ca45  9b          UNKNOWN 0x9b 
    .byte 0xcb              ;ca46  cb          UNKNOWN 0xcb 
    .byte 0x4c              ;ca47  4c          UNKNOWN 0x4c 'L' 
    .byte 0xa4              ;ca48  a4          UNKNOWN 0xa4 
    .byte 0xcb              ;ca49  cb          UNKNOWN 0xcb 
    .byte 0xa5              ;ca4a  a5          UNKNOWN 0xa5 
    .byte 0xeb              ;ca4b  eb          UNKNOWN 0xeb 
    .byte 0x85              ;ca4c  85          UNKNOWN 0x85 
    .byte 0xec              ;ca4d  ec          UNKNOWN 0xec 
    .byte 0xa5              ;ca4e  a5          UNKNOWN 0xa5 
    .byte 0x70              ;ca4f  70          UNKNOWN 0x70 'p' 
    .byte 0x85              ;ca50  85          UNKNOWN 0x85 
    .byte 0xeb              ;ca51  eb          UNKNOWN 0xeb 
    .byte 0x3c              ;ca52  3c          UNKNOWN 0x3c '<' 
    .byte 0x05              ;ca53  05          UNKNOWN 0x05 
    .byte 0xe6              ;ca54  e6          UNKNOWN 0xe6 
    .byte 0x20              ;ca55  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;ca56  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;ca57  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;ca58  d0          UNKNOWN 0xd0 
    .byte 0x03              ;ca59  03          UNKNOWN 0x03 
    .byte 0x4c              ;ca5a  4c          UNKNOWN 0x4c 'L' 
    .byte 0x9d              ;ca5b  9d          UNKNOWN 0x9d 
    .byte 0xcb              ;ca5c  cb          UNKNOWN 0xcb 
    .byte 0xa9              ;ca5d  a9          UNKNOWN 0xa9 
    .byte 0x60              ;ca5e  60          UNKNOWN 0x60 '`' 
    .byte 0x07              ;ca5f  07          UNKNOWN 0x07 
    .byte 0x6d              ;ca60  6d          UNKNOWN 0x6d 'm' 
    .byte 0xe2              ;ca61  e2          UNKNOWN 0xe2 
    .byte 0xa5              ;ca62  a5          UNKNOWN 0xa5 
    .byte 0x72              ;ca63  72          UNKNOWN 0x72 'r' 
    .byte 0xc5              ;ca64  c5          UNKNOWN 0xc5 
    .byte 0xf1              ;ca65  f1          UNKNOWN 0xf1 
    .byte 0xa9              ;ca66  a9          UNKNOWN 0xa9 
    .byte 0x20              ;ca67  20          UNKNOWN 0x20 ' ' 
    .byte 0xb0              ;ca68  b0          UNKNOWN 0xb0 
    .byte 0xda              ;ca69  da          UNKNOWN 0xda 
    .byte 0xa5              ;ca6a  a5          UNKNOWN 0xa5 
    .byte 0x72              ;ca6b  72          UNKNOWN 0x72 'r' 
    .byte 0xc5              ;ca6c  c5          UNKNOWN 0xc5 
    .byte 0xf2              ;ca6d  f2          UNKNOWN 0xf2 
    .byte 0xa9              ;ca6e  a9          UNKNOWN 0xa9 
    .byte 0x21              ;ca6f  21          UNKNOWN 0x21 '!' 
    .byte 0x90              ;ca70  90          UNKNOWN 0x90 
    .byte 0xd2              ;ca71  d2          UNKNOWN 0xd2 
    .byte 0xa5              ;ca72  a5          UNKNOWN 0xa5 
    .byte 0x71              ;ca73  71          UNKNOWN 0x71 'q' 
    .byte 0xc9              ;ca74  c9          UNKNOWN 0xc9 
    .byte 0x3e              ;ca75  3e          UNKNOWN 0x3e '>' 
    .byte 0xa9              ;ca76  a9          UNKNOWN 0xa9 
    .byte 0x01              ;ca77  01          UNKNOWN 0x01 
    .byte 0x90              ;ca78  90          UNKNOWN 0x90 
    .byte 0xcd              ;ca79  cd          UNKNOWN 0xcd 
    .byte 0xa5              ;ca7a  a5          UNKNOWN 0xa5 
    .byte 0x71              ;ca7b  71          UNKNOWN 0x71 'q' 
    .byte 0xc9              ;ca7c  c9          UNKNOWN 0xc9 
    .byte 0xb4              ;ca7d  b4          UNKNOWN 0xb4 
    .byte 0x90              ;ca7e  90          UNKNOWN 0x90 
    .byte 0x10              ;ca7f  10          UNKNOWN 0x10 
    .byte 0xa5              ;ca80  a5          UNKNOWN 0xa5 
    .byte 0xe7              ;ca81  e7          UNKNOWN 0xe7 
    .byte 0xf0              ;ca82  f0          UNKNOWN 0xf0 
    .byte 0x07              ;ca83  07          UNKNOWN 0x07 
    .byte 0x1a              ;ca84  1a          UNKNOWN 0x1a 
    .byte 0xf0              ;ca85  f0          UNKNOWN 0xf0 
    .byte 0x04              ;ca86  04          UNKNOWN 0x04 
    .byte 0x85              ;ca87  85          UNKNOWN 0x85 
    .byte 0xe7              ;ca88  e7          UNKNOWN 0xe7 
    .byte 0x80              ;ca89  80          UNKNOWN 0x80 
    .byte 0x08              ;ca8a  08          UNKNOWN 0x08 
    .byte 0xa9              ;ca8b  a9          UNKNOWN 0xa9 
    .byte 0x02              ;ca8c  02          UNKNOWN 0x02 

sub_ca8d:
    jmp lab_cba4            ;ca8d  4c a4 cb 

    .byte 0x3c              ;ca90  3c          UNKNOWN 0x3c '<' 
    .byte 0x03              ;ca91  03          UNKNOWN 0x03 
    .byte 0xe7              ;ca92  e7          UNKNOWN 0xe7 
    .byte 0xa5              ;ca93  a5          UNKNOWN 0xa5 
    .byte 0x70              ;ca94  70          UNKNOWN 0x70 'p' 
    .byte 0xc9              ;ca95  c9          UNKNOWN 0xc9 
    .byte 0x07              ;ca96  07          UNKNOWN 0x07 
    .byte 0xb0              ;ca97  b0          UNKNOWN 0xb0 
    .byte 0x02              ;ca98  02          UNKNOWN 0x02 
    .byte 0x0f              ;ca99  0f          UNKNOWN 0x0f 
    .byte 0xc4              ;ca9a  c4          UNKNOWN 0xc4 
    .byte 0xc9              ;ca9b  c9          UNKNOWN 0xc9 
    .byte 0x7b              ;ca9c  7b          UNKNOWN 0x7b '{' 
    .byte 0xa9              ;ca9d  a9          UNKNOWN 0xa9 
    .byte 0x11              ;ca9e  11          UNKNOWN 0x11 
    .byte 0x90              ;ca9f  90          UNKNOWN 0x90 
    .byte 0x03              ;caa0  03          UNKNOWN 0x03 
    .byte 0x4c              ;caa1  4c          UNKNOWN 0x4c 'L' 
    .byte 0xa4              ;caa2  a4          UNKNOWN 0xa4 
    .byte 0xcb              ;caa3  cb          UNKNOWN 0xcb 
    .byte 0xa9              ;caa4  a9          UNKNOWN 0xa9 
    .byte 0x70              ;caa5  70          UNKNOWN 0x70 'p' 
    .byte 0x07              ;caa6  07          UNKNOWN 0x07 
    .byte 0x95              ;caa7  95          UNKNOWN 0x95 
    .byte 0x72              ;caa8  72          UNKNOWN 0x72 'r' 

sub_caa9:
    lda mem_0070            ;caa9  a5 70    
    cmp #0x03               ;caab  c9 03    
    bcs lab_cab4            ;caad  b0 05    
    ldm #0x10,mem_0073      ;caaf  3c 10 73 
    bra lab_cb32            ;cab2  80 7e    

lab_cab4:
    bbs 6,mem_006c,lab_cabe ;cab4  c7 6c 07 
    jsr sub_cbda            ;cab7  20 da cb 
    bcc lab_cae9            ;caba  90 2d    
    bra lab_cb24            ;cabc  80 66    

lab_cabe:
    lda mem_00a6            ;cabe  a5 a6    
    cmp #0x05               ;cac0  c9 05    
    bcc lab_cac5            ;cac2  90 01    
    rts                     ;cac4  60       

lab_cac5:
    ldx mem_0071            ;cac5  a6 71    
    cpx #0x68               ;cac7  e0 68    
    bcs lab_cacf            ;cac9  b0 04    
    lda #0x03               ;cacb  a9 03    
    bra lab_cb24            ;cacd  80 55    

lab_cacf:
    lda mem_00f4            ;cacf  a5 f4    
    bne lab_cae9            ;cad1  d0 16    
    bbc 0,P2,lab_cae9       ;cad3  17 04 13 
    lda mem_006e            ;cad6  a5 6e    
    cmp #0x5a               ;cad8  c9 5a    
    bcs lab_cae9            ;cada  b0 0d    
    lda mem_0070            ;cadc  a5 70    
    cmp #0x0a               ;cade  c9 0a    
    bcc lab_cae9            ;cae0  90 07    
    clb 0,P2                ;cae2  1f 04    
    seb 1,P2                ;cae4  2f 04    
    ldm #0x04,mem_00a6      ;cae6  3c 04 a6 

lab_cae9:
    lda mem_0102            ;cae9  ad 02 01 
    cmp #0xff               ;caec  c9 ff    
    beq lab_cb16            ;caee  f0 26    
    lda mem_0070            ;caf0  a5 70    
    cmp #0x06               ;caf2  c9 06    
    bcc lab_cafc            ;caf4  90 06    

lab_caf6:
    lda #0x09               ;caf6  a9 09    
    sta mem_0102            ;caf8  8d 02 01 
    rts                     ;cafb  60       

lab_cafc:
    lda mem_0102            ;cafc  ad 02 01 
    beq lab_cb06            ;caff  f0 05    
    dec a                   ;cb01  1a       
    sta mem_0102            ;cb02  8d 02 01 
    rts                     ;cb05  60       

lab_cb06:
    lda mem_0071            ;cb06  a5 71    
    cmp #0xa9               ;cb08  c9 a9    
    bcc lab_caf6            ;cb0a  90 ea    
    lda #0xff               ;cb0c  a9 ff    
    sta mem_0102            ;cb0e  8d 02 01 
    lda #0x28               ;cb11  a9 28    
    sta mem_0098            ;cb13  85 98    
    rts                     ;cb15  60       

lab_cb16:
    lda mem_0098            ;cb16  a5 98    
    beq lab_cb32            ;cb18  f0 18    
    rts                     ;cb1a  60       

    .byte 0x85              ;cb1b  85          UNKNOWN 0x85 
    .byte 0x73              ;cb1c  73          UNKNOWN 0x73 's' 

lab_cb1d:
    jsr sub_cc98            ;cb1d  20 98 cc 
    jsr sub_cc5e            ;cb20  20 5e cc 
    rts                     ;cb23  60       

lab_cb24:
    seb 5,mem_006c          ;cb24  af 6c    
    sta mem_0073            ;cb26  85 73    
    jsr sub_cc98            ;cb28  20 98 cc 
    jsr sub_cc5e            ;cb2b  20 5e cc 
    jsr sub_ce67            ;cb2e  20 67 ce 
    rts                     ;cb31  60       

lab_cb32:
    ldx #0x04               ;cb32  a2 04    
    lda mem_0071            ;cb34  a5 71    
    cmp #0xa2               ;cb36  c9 a2    
    bcc lab_cb56            ;cb38  90 1c    
    lda mem_00a6            ;cb3a  a5 a6    
    bne lab_cb1d            ;cb3c  d0 df    
    lda mem_00ec            ;cb3e  a5 ec    
    cmp #0x05               ;cb40  c9 05    
    bcs lab_cb1d            ;cb42  b0 d9    
    jsr sub_cc5e            ;cb44  20 5e cc 
    jsr sub_cc81            ;cb47  20 81 cc 
    bcc lab_cb55            ;cb4a  90 09    
    cmp #0x32               ;cb4c  c9 32    
    ldx #0x40               ;cb4e  a2 40    
    bcc lab_cb24            ;cb50  90 d2    
    ldm #0x48,mem_0073      ;cb52  3c 48 73 

lab_cb55:
    rts                     ;cb55  60       

lab_cb56:
    txa                     ;cb56  8a       
    jmp lab_cba4            ;cb57  4c a4 cb 

    .byte 0xa5              ;cb5a  a5          UNKNOWN 0xa5 
    .byte 0xa6              ;cb5b  a6          UNKNOWN 0xa6 
    .byte 0xd0              ;cb5c  d0          UNKNOWN 0xd0 
    .byte 0x4d              ;cb5d  4d          UNKNOWN 0x4d 'M' 
    .byte 0xa2              ;cb5e  a2          UNKNOWN 0xa2 
    .byte 0x03              ;cb5f  03          UNKNOWN 0x03 
    .byte 0xa5              ;cb60  a5          UNKNOWN 0xa5 
    .byte 0x71              ;cb61  71          UNKNOWN 0x71 'q' 
    .byte 0xc9              ;cb62  c9          UNKNOWN 0xc9 
    .byte 0x68              ;cb63  68          UNKNOWN 0x68 'h' 
    .byte 0x90              ;cb64  90          UNKNOWN 0x90 
    .byte 0x47              ;cb65  47          UNKNOWN 0x47 'G' 
    .byte 0xa5              ;cb66  a5          UNKNOWN 0xa5 
    .byte 0x98              ;cb67  98          UNKNOWN 0x98 
    .byte 0xd0              ;cb68  d0          UNKNOWN 0xd0 
    .byte 0x41              ;cb69  41          UNKNOWN 0x41 'A' 
    .byte 0xad              ;cb6a  ad          UNKNOWN 0xad 
    .byte 0x02              ;cb6b  02          UNKNOWN 0x02 
    .byte 0x01              ;cb6c  01          UNKNOWN 0x01 
    .byte 0xc9              ;cb6d  c9          UNKNOWN 0xc9 
    .byte 0xff              ;cb6e  ff          UNKNOWN 0xff 
    .byte 0xf0              ;cb6f  f0          UNKNOWN 0xf0 
    .byte 0x3a              ;cb70  3a          UNKNOWN 0x3a ':' 
    .byte 0xc6              ;cb71  c6          UNKNOWN 0xc6 
    .byte 0xe8              ;cb72  e8          UNKNOWN 0xe8 
    .byte 0xf0              ;cb73  f0          UNKNOWN 0xf0 
    .byte 0x2c              ;cb74  2c          UNKNOWN 0x2c ',' 
    .byte 0x3c              ;cb75  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;cb76  0a          UNKNOWN 0x0a 
    .byte 0x98              ;cb77  98          UNKNOWN 0x98 
    .byte 0x9f              ;cb78  9f          UNKNOWN 0x9f 
    .byte 0x95              ;cb79  95          UNKNOWN 0x95 
    .byte 0x3c              ;cb7a  3c          UNKNOWN 0x3c '<' 
    .byte 0xd2              ;cb7b  d2          UNKNOWN 0xd2 
    .byte 0x9c              ;cb7c  9c          UNKNOWN 0x9c 
    .byte 0xa5              ;cb7d  a5          UNKNOWN 0xa5 
    .byte 0x72              ;cb7e  72          UNKNOWN 0x72 'r' 
    .byte 0xc5              ;cb7f  c5          UNKNOWN 0xc5 
    .byte 0xef              ;cb80  ef          UNKNOWN 0xef 
    .byte 0xb0              ;cb81  b0          UNKNOWN 0xb0 
    .byte 0x28              ;cb82  28          UNKNOWN 0x28 '(' 
    .byte 0xa5              ;cb83  a5          UNKNOWN 0xa5 
    .byte 0x6e              ;cb84  6e          UNKNOWN 0x6e 'n' 
    .byte 0xc9              ;cb85  c9          UNKNOWN 0xc9 
    .byte 0x5a              ;cb86  5a          UNKNOWN 0x5a 'Z' 
    .byte 0xb0              ;cb87  b0          UNKNOWN 0xb0 
    .byte 0x22              ;cb88  22          UNKNOWN 0x22 '"' 
    .byte 0xa5              ;cb89  a5          UNKNOWN 0xa5 
    .byte 0x70              ;cb8a  70          UNKNOWN 0x70 'p' 
    .byte 0xc9              ;cb8b  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;cb8c  0a          UNKNOWN 0x0a 
    .byte 0x90              ;cb8d  90          UNKNOWN 0x90 
    .byte 0x1c              ;cb8e  1c          UNKNOWN 0x1c 
    .byte 0xe7              ;cb8f  e7          UNKNOWN 0xe7 
    .byte 0xc1              ;cb90  c1          UNKNOWN 0xc1 
    .byte 0x19              ;cb91  19          UNKNOWN 0x19 
    .byte 0xa5              ;cb92  a5          UNKNOWN 0xa5 
    .byte 0xea              ;cb93  ea          UNKNOWN 0xea 
    .byte 0xd0              ;cb94  d0          UNKNOWN 0xd0 
    .byte 0x15              ;cb95  15          UNKNOWN 0x15 
    .byte 0xcf              ;cb96  cf          UNKNOWN 0xcf 
    .byte 0x6c              ;cb97  6c          UNKNOWN 0x6c 'l' 
    .byte 0x3c              ;cb98  3c          UNKNOWN 0x3c '<' 
    .byte 0x07              ;cb99  07          UNKNOWN 0x07 
    .byte 0xa6              ;cb9a  a6          UNKNOWN 0xa6 
    .byte 0xa5              ;cb9b  a5          UNKNOWN 0xa5 
    .byte 0xf3              ;cb9c  f3          UNKNOWN 0xf3 
    .byte 0x85              ;cb9d  85          UNKNOWN 0x85 
    .byte 0xf4              ;cb9e  f4          UNKNOWN 0xf4 
    .byte 0x80              ;cb9f  80          UNKNOWN 0x80 
    .byte 0x0a              ;cba0  0a          UNKNOWN 0x0a 
    .byte 0xa9              ;cba1  a9          UNKNOWN 0xa9 
    .byte 0x70              ;cba2  70          UNKNOWN 0x70 'p' 
    .byte 0x85              ;cba3  85          UNKNOWN 0x85 

lab_cba4:
    bbc 3,a,lab_cbc6        ;cba4  73 20    
    tya                     ;cba6  98       
    cpy mem_5e20            ;cba7  cc 20 5e 
    cpy mem_6018            ;cbaa  cc 18 60 
    txa                     ;cbad  8a       
    sec                     ;cbae  38       
    rts                     ;cbaf  60       

    .byte 0x4c              ;cbb0  4c          UNKNOWN 0x4c 'L' 
    .byte 0xa4              ;cbb1  a4          UNKNOWN 0xa4 
    .byte 0xcb              ;cbb2  cb          UNKNOWN 0xcb 
    .byte 0x60              ;cbb3  60          UNKNOWN 0x60 '`' 
    .byte 0x07              ;cbb4  07          UNKNOWN 0x07 
    .byte 0x04              ;cbb5  04          UNKNOWN 0x04 
    .byte 0x04              ;cbb6  04          UNKNOWN 0x04 
    .byte 0x0f              ;cbb7  0f          UNKNOWN 0x0f 
    .byte 0x04              ;cbb8  04          UNKNOWN 0x04 
    .byte 0x80              ;cbb9  80          UNKNOWN 0x80 
    .byte 0x0e              ;cbba  0e          UNKNOWN 0x0e 
    .byte 0xa5              ;cbbb  a5          UNKNOWN 0xa5 
    .byte 0xa6              ;cbbc  a6          UNKNOWN 0xa6 
    .byte 0xc9              ;cbbd  c9          UNKNOWN 0xc9 
    .byte 0x04              ;cbbe  04          UNKNOWN 0x04 
    .byte 0x90              ;cbbf  90          UNKNOWN 0x90 
    .byte 0x08              ;cbc0  08          UNKNOWN 0x08 
    .byte 0xa5              ;cbc1  a5          UNKNOWN 0xa5 
    .byte 0x70              ;cbc2  70          UNKNOWN 0x70 'p' 
    .byte 0xc9              ;cbc3  c9          UNKNOWN 0xc9 
    .byte 0x04              ;cbc4  04          UNKNOWN 0x04 
    .byte 0xb0              ;cbc5  b0          UNKNOWN 0xb0 

lab_cbc6:
    jsr [SIO2]              ;cbc6  02 1f    
    .byte 0x04              ;cbc8  04       Illegal instruction

    .byte 0x60              ;cbc9  60          UNKNOWN 0x60 '`' 
    .byte 0x60              ;cbca  60          UNKNOWN 0x60 '`' 
    .byte 0x07              ;cbcb  07          UNKNOWN 0x07 
    .byte 0x04              ;cbcc  04          UNKNOWN 0x04 
    .byte 0x0f              ;cbcd  0f          UNKNOWN 0x0f 
    .byte 0x27              ;cbce  27          UNKNOWN 0x27 ''' 
    .byte 0x04              ;cbcf  04          UNKNOWN 0x04 
    .byte 0x04              ;cbd0  04          UNKNOWN 0x04 
    .byte 0x2f              ;cbd1  2f          UNKNOWN 0x2f '/' 
    .byte 0x04              ;cbd2  04          UNKNOWN 0x04 
    .byte 0x80              ;cbd3  80          UNKNOWN 0x80 
    .byte 0x08              ;cbd4  08          UNKNOWN 0x08 
    .byte 0xa5              ;cbd5  a5          UNKNOWN 0xa5 
    .byte 0x70              ;cbd6  70          UNKNOWN 0x70 'p' 
    .byte 0xc9              ;cbd7  c9          UNKNOWN 0xc9 
    .byte 0x04              ;cbd8  04          UNKNOWN 0x04 
    .byte 0xb0              ;cbd9  b0          UNKNOWN 0xb0 

sub_cbda:
    jsr [ICON2]             ;cbda  02 3f    
    .byte 0x04              ;cbdc  04       Illegal instruction

    .byte 0x60              ;cbdd  60          UNKNOWN 0x60 '`' 
    .byte 0xe7              ;cbde  e7          UNKNOWN 0xe7 
    .byte 0x6c              ;cbdf  6c          UNKNOWN 0x6c 'l' 
    .byte 0x09              ;cbe0  09          UNKNOWN 0x09 
    .byte 0x27              ;cbe1  27          UNKNOWN 0x27 ''' 
    .byte 0x04              ;cbe2  04          UNKNOWN 0x04 
    .byte 0x06              ;cbe3  06          UNKNOWN 0x06 
    .byte 0x07              ;cbe4  07          UNKNOWN 0x07 
    .byte 0x04              ;cbe5  04          UNKNOWN 0x04 
    .byte 0x03              ;cbe6  03          UNKNOWN 0x03 
    .byte 0x18              ;cbe7  18          UNKNOWN 0x18 
    .byte 0x80              ;cbe8  80          UNKNOWN 0x80 
    .byte 0x01              ;cbe9  01          UNKNOWN 0x01 
    .byte 0x38              ;cbea  38          UNKNOWN 0x38 '8' 
    .byte 0x08              ;cbeb  08          UNKNOWN 0x08 
    .byte 0xff              ;cbec  ff          UNKNOWN 0xff 
    .byte 0x6c              ;cbed  6c          UNKNOWN 0x6c 'l' 
    .byte 0xcf              ;cbee  cf          UNKNOWN 0xcf 
    .byte 0x0a              ;cbef  0a          UNKNOWN 0x0a 
    .byte 0x3f              ;cbf0  3f          UNKNOWN 0x3f '?' 
    .byte 0x04              ;cbf1  04          UNKNOWN 0x04 
    .byte 0x1f              ;cbf2  1f          UNKNOWN 0x1f 
    .byte 0x04              ;cbf3  04          UNKNOWN 0x04 
    .byte 0x3c              ;cbf4  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cbf5  00          UNKNOWN 0x00 
    .byte 0x9c              ;cbf6  9c          UNKNOWN 0x9c 
    .byte 0x3c              ;cbf7  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cbf8  00          UNKNOWN 0x00 
    .byte 0x98              ;cbf9  98          UNKNOWN 0x98 
    .byte 0x1f              ;cbfa  1f          UNKNOWN 0x1f 
    .byte 0x95              ;cbfb  95          UNKNOWN 0x95 
    .byte 0x9f              ;cbfc  9f          UNKNOWN 0x9f 
    .byte 0x95              ;cbfd  95          UNKNOWN 0x95 
    .byte 0x28              ;cbfe  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;cbff  ea          UNKNOWN 0xea 
    .byte 0x60              ;cc00  60          UNKNOWN 0x60 '`' 
    .byte 0x37              ;cc01  37          UNKNOWN 0x37 '7' 
    .byte 0xc0              ;cc02  c0          UNKNOWN 0xc0 
    .byte 0x02              ;cc03  02          UNKNOWN 0x02 
    .byte 0x18              ;cc04  18          UNKNOWN 0x18 
    .byte 0x60              ;cc05  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;cc06  a5          UNKNOWN 0xa5 
    .byte 0x6e              ;cc07  6e          UNKNOWN 0x6e 'n' 
    .byte 0x85              ;cc08  85          UNKNOWN 0x85 
    .byte 0x6f              ;cc09  6f          UNKNOWN 0x6f 'o' 
    .byte 0xc9              ;cc0a  c9          UNKNOWN 0xc9 
    .byte 0x4b              ;cc0b  4b          UNKNOWN 0x4b 'K' 
    .byte 0xb0              ;cc0c  b0          UNKNOWN 0xb0 
    .byte 0x02              ;cc0d  02          UNKNOWN 0x02 
    .byte 0x38              ;cc0e  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;cc0f  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;cc10  3c          UNKNOWN 0x3c '<' 
    .byte 0x64              ;cc11  64          UNKNOWN 0x64 'd' 
    .byte 0x6e              ;cc12  6e          UNKNOWN 0x6e 'n' 
    .byte 0x20              ;cc13  20          UNKNOWN 0x20 ' ' 
    .byte 0x01              ;cc14  01          UNKNOWN 0x01 
    .byte 0xc3              ;cc15  c3          UNKNOWN 0xc3 
    .byte 0x18              ;cc16  18          UNKNOWN 0x18 
    .byte 0x60              ;cc17  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;cc18  a5          UNKNOWN 0xa5 
    .byte 0x6e              ;cc19  6e          UNKNOWN 0x6e 'n' 
    .byte 0xc9              ;cc1a  c9          UNKNOWN 0xc9 
    .byte 0x64              ;cc1b  64          UNKNOWN 0x64 'd' 
    .byte 0xf0              ;cc1c  f0          UNKNOWN 0xf0 
    .byte 0x05              ;cc1d  05          UNKNOWN 0x05 
    .byte 0x90              ;cc1e  90          UNKNOWN 0x90 
    .byte 0x03              ;cc1f  03          UNKNOWN 0x03 
    .byte 0x20              ;cc20  20          UNKNOWN 0x20 ' ' 
    .byte 0x81              ;cc21  81          UNKNOWN 0x81 
    .byte 0xcc              ;cc22  cc          UNKNOWN 0xcc 
    .byte 0x18              ;cc23  18          UNKNOWN 0x18 
    .byte 0x60              ;cc24  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;cc25  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;cc26  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;cc27  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;cc28  d0          UNKNOWN 0xd0 
    .byte 0x14              ;cc29  14          UNKNOWN 0x14 
    .byte 0x20              ;cc2a  20          UNKNOWN 0x20 ' ' 
    .byte 0x75              ;cc2b  75          UNKNOWN 0x75 'u' 
    .byte 0xd0              ;cc2c  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;cc2d  f0          UNKNOWN 0xf0 
    .byte 0x4b              ;cc2e  4b          UNKNOWN 0x4b 'K' 
    .byte 0x05              ;cc2f  05          UNKNOWN 0x05 
    .byte 0x6c              ;cc30  6c          UNKNOWN 0x6c 'l' 
    .byte 0x85              ;cc31  85          UNKNOWN 0x85 
    .byte 0x6c              ;cc32  6c          UNKNOWN 0x6c 'l' 
    .byte 0x3c              ;cc33  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;cc34  ff          UNKNOWN 0xff 
    .byte 0x6e              ;cc35  6e          UNKNOWN 0x6e 'n' 
    .byte 0x3c              ;cc36  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;cc37  ff          UNKNOWN 0xff 
    .byte 0x6f              ;cc38  6f          UNKNOWN 0x6f 'o' 
    .byte 0xff              ;cc39  ff          UNKNOWN 0xff 
    .byte 0x08              ;cc3a  08          UNKNOWN 0x08 
    .byte 0x4c              ;cc3b  4c          UNKNOWN 0x4c 'L' 
    .byte 0xfa              ;cc3c  fa          UNKNOWN 0xfa 
    .byte 0xcc              ;cc3d  cc          UNKNOWN 0xcc 
    .byte 0x20              ;cc3e  20          UNKNOWN 0x20 ' ' 
    .byte 0x75              ;cc3f  75          UNKNOWN 0x75 'u' 
    .byte 0xd0              ;cc40  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;cc41  f0          UNKNOWN 0xf0 
    .byte 0x22              ;cc42  22          UNKNOWN 0x22 '"' 
    .byte 0xa5              ;cc43  a5          UNKNOWN 0xa5 
    .byte 0x6e              ;cc44  6e          UNKNOWN 0x6e 'n' 
    .byte 0xc9              ;cc45  c9          UNKNOWN 0xc9 
    .byte 0xff              ;cc46  ff          UNKNOWN 0xff 
    .byte 0xf0              ;cc47  f0          UNKNOWN 0xf0 
    .byte 0x02              ;cc48  02          UNKNOWN 0x02 
    .byte 0x18              ;cc49  18          UNKNOWN 0x18 
    .byte 0x60              ;cc4a  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;cc4b  20          UNKNOWN 0x20 ' ' 
    .byte 0xd7              ;cc4c  d7          UNKNOWN 0xd7 
    .byte 0xcf              ;cc4d  cf          UNKNOWN 0xcf 
    .byte 0xfb              ;cc4e  fb          UNKNOWN 0xfb 
    .byte 0x85              ;cc4f  85          UNKNOWN 0x85 
    .byte 0x6f              ;cc50  6f          UNKNOWN 0x6f 'o' 
    .byte 0xc9              ;cc51  c9          UNKNOWN 0xc9 
    .byte 0xff              ;cc52  ff          UNKNOWN 0xff 
    .byte 0xf0              ;cc53  f0          UNKNOWN 0xf0 
    .byte 0x04              ;cc54  04          UNKNOWN 0x04 
    .byte 0x85              ;cc55  85          UNKNOWN 0x85 
    .byte 0x6e              ;cc56  6e          UNKNOWN 0x6e 'n' 
    .byte 0x80              ;cc57  80          UNKNOWN 0x80 
    .byte 0x07              ;cc58  07          UNKNOWN 0x07 
    .byte 0xc5              ;cc59  c5          UNKNOWN 0xc5 
    .byte 0x6e              ;cc5a  6e          UNKNOWN 0x6e 'n' 
    .byte 0xd0              ;cc5b  d0          UNKNOWN 0xd0 
    .byte 0x06              ;cc5c  06          UNKNOWN 0x06 
    .byte 0x3c              ;cc5d  3c          UNKNOWN 0x3c '<' 

sub_cc5e:
    .byte 0x34              ;cc5e  34       Illegal instruction

    .byte 0x6e              ;cc5f  6e          UNKNOWN 0x6e 'n' 
    .byte 0x20              ;cc60  20          UNKNOWN 0x20 ' ' 
    .byte 0x01              ;cc61  01          UNKNOWN 0x01 
    .byte 0xc3              ;cc62  c3          UNKNOWN 0xc3 
    .byte 0x18              ;cc63  18          UNKNOWN 0x18 
    .byte 0x60              ;cc64  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;cc65  a5          UNKNOWN 0xa5 
    .byte 0x6c              ;cc66  6c          UNKNOWN 0x6c 'l' 
    .byte 0x29              ;cc67  29          UNKNOWN 0x29 ')' 
    .byte 0xf0              ;cc68  f0          UNKNOWN 0xf0 
    .byte 0x85              ;cc69  85          UNKNOWN 0x85 
    .byte 0x6c              ;cc6a  6c          UNKNOWN 0x6c 'l' 
    .byte 0x20              ;cc6b  20          UNKNOWN 0x20 ' ' 
    .byte 0x4a              ;cc6c  4a          UNKNOWN 0x4a 'J' 
    .byte 0xce              ;cc6d  ce          UNKNOWN 0xce 
    .byte 0x3c              ;cc6e  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc6f  00          UNKNOWN 0x00 
    .byte 0x6e              ;cc70  6e          UNKNOWN 0x6e 'n' 
    .byte 0x3c              ;cc71  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc72  00          UNKNOWN 0x00 
    .byte 0x6f              ;cc73  6f          UNKNOWN 0x6f 'o' 
    .byte 0x3c              ;cc74  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc75  00          UNKNOWN 0x00 
    .byte 0x5b              ;cc76  5b          UNKNOWN 0x5b '[' 
    .byte 0x3c              ;cc77  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc78  00          UNKNOWN 0x00 
    .byte 0x5c              ;cc79  5c          UNKNOWN 0x5c '\' 
    .byte 0x38              ;cc7a  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;cc7b  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;cc7c  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc7d  00          UNKNOWN 0x00 
    .byte 0x68              ;cc7e  68          UNKNOWN 0x68 'h' 
    .byte 0x3c              ;cc7f  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc80  00          UNKNOWN 0x00 

sub_cc81:
    adc #0x60               ;cc81  69 60    
    ldm #0x00,mem_0062      ;cc83  3c 00 62 
    ldm #0x00,mem_0063      ;cc86  3c 00 63 
    ldm #0x00,mem_0064      ;cc89  3c 00 64 
    rts                     ;cc8c  60       

    .byte 0x3c              ;cc8d  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc8e  00          UNKNOWN 0x00 
    .byte 0x65              ;cc8f  65          UNKNOWN 0x65 'e' 
    .byte 0x3c              ;cc90  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc91  00          UNKNOWN 0x00 
    .byte 0x66              ;cc92  66          UNKNOWN 0x66 'f' 
    .byte 0x3c              ;cc93  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cc94  00          UNKNOWN 0x00 
    .byte 0x67              ;cc95  67          UNKNOWN 0x67 'g' 
    .byte 0x60              ;cc96  60          UNKNOWN 0x60 '`' 
    .byte 0x0a              ;cc97  0a          UNKNOWN 0x0a 

sub_cc98:
    asl a                   ;cc98  0a       
    asl a                   ;cc99  0a       
    pha                     ;cc9a  48       
    pha                     ;cc9b  48       
    tax                     ;cc9c  aa       
    lda mem_cd47,x          ;cc9d  bd 47 cd 
    sta mem_00f5            ;cca0  85 f5    
    lda mem_cd48,x          ;cca2  bd 48 cd 

sub_cca5:
    sta mem_00f6            ;cca5  85 f6    
    sei                     ;cca7  78       
    jsr sub_e6f9            ;cca8  20 f9 e6 
    pla                     ;ccab  68       
    tax                     ;ccac  aa       
    lda mem_cd49,x          ;ccad  bd 49 cd 
    sta mem_00f5            ;ccb0  85 f5    
    lda mem_cd4a,x          ;ccb2  bd 4a cd 
    sta mem_00f6            ;ccb5  85 f6    
    jsr [mem_00f5]          ;ccb7  02 f5    
    pla                     ;ccb9  68       
    tax                     ;ccba  aa       
    lda mem_cd4b,x          ;ccbb  bd 4b cd 
    sta mem_00f5            ;ccbe  85 f5    
    lda mem_cd4c,x          ;ccc0  bd 4c cd 
    sta mem_00f6            ;ccc3  85 f6    
    jmp [mem_00f5]          ;ccc5  b2 f5    

    .byte 0x66              ;ccc7  66          UNKNOWN 0x66 'f' 
    .byte 0xe7              ;ccc8  e7          UNKNOWN 0xe7 
    .byte 0x43              ;ccc9  43          UNKNOWN 0x43 'C' 
    .byte 0xe8              ;ccca  e8          UNKNOWN 0xe8 
    .byte 0x29              ;cccb  29          UNKNOWN 0x29 ')' 
    .byte 0xc1              ;cccc  c1          UNKNOWN 0xc1 
    .byte 0x00              ;cccd  00          UNKNOWN 0x00 
    .byte 0x00              ;ccce  00          UNKNOWN 0x00 
    .byte 0x87              ;cccf  87          UNKNOWN 0x87 
    .byte 0xe7              ;ccd0  e7          UNKNOWN 0xe7 
    .byte 0x77              ;ccd1  77          UNKNOWN 0x77 'w' 
    .byte 0xe8              ;ccd2  e8          UNKNOWN 0xe8 
    .byte 0x29              ;ccd3  29          UNKNOWN 0x29 ')' 
    .byte 0xc1              ;ccd4  c1          UNKNOWN 0xc1 
    .byte 0x00              ;ccd5  00          UNKNOWN 0x00 
    .byte 0x00              ;ccd6  00          UNKNOWN 0x00 
    .byte 0xb4              ;ccd7  b4          UNKNOWN 0xb4 
    .byte 0xe7              ;ccd8  e7          UNKNOWN 0xe7 
    .byte 0xb0              ;ccd9  b0          UNKNOWN 0xb0 
    .byte 0xe8              ;ccda  e8          UNKNOWN 0xe8 
    .byte 0x29              ;ccdb  29          UNKNOWN 0x29 ')' 
    .byte 0xc1              ;ccdc  c1          UNKNOWN 0xc1 
    .byte 0x00              ;ccdd  00          UNKNOWN 0x00 
    .byte 0x00              ;ccde  00          UNKNOWN 0x00 
    .byte 0x87              ;ccdf  87          UNKNOWN 0x87 
    .byte 0xe7              ;cce0  e7          UNKNOWN 0xe7 
    .byte 0x77              ;cce1  77          UNKNOWN 0x77 'w' 
    .byte 0xe8              ;cce2  e8          UNKNOWN 0xe8 
    .byte 0x29              ;cce3  29          UNKNOWN 0x29 ')' 
    .byte 0xc1              ;cce4  c1          UNKNOWN 0xc1 
    .byte 0x00              ;cce5  00          UNKNOWN 0x00 
    .byte 0x00              ;cce6  00          UNKNOWN 0x00 
    .byte 0xb4              ;cce7  b4          UNKNOWN 0xb4 
    .byte 0xe7              ;cce8  e7          UNKNOWN 0xe7 
    .byte 0xa8              ;cce9  a8          UNKNOWN 0xa8 
    .byte 0xe8              ;ccea  e8          UNKNOWN 0xe8 
    .byte 0x29              ;cceb  29          UNKNOWN 0x29 ')' 
    .byte 0xc1              ;ccec  c1          UNKNOWN 0xc1 
    .byte 0x00              ;cced  00          UNKNOWN 0x00 
    .byte 0x00              ;ccee  00          UNKNOWN 0x00 
    .byte 0x66              ;ccef  66          UNKNOWN 0x66 'f' 
    .byte 0xe7              ;ccf0  e7          UNKNOWN 0xe7 
    .byte 0x43              ;ccf1  43          UNKNOWN 0x43 'C' 
    .byte 0xe8              ;ccf2  e8          UNKNOWN 0xe8 
    .byte 0x29              ;ccf3  29          UNKNOWN 0x29 ')' 
    .byte 0xc1              ;ccf4  c1          UNKNOWN 0xc1 
    .byte 0x00              ;ccf5  00          UNKNOWN 0x00 
    .byte 0x00              ;ccf6  00          UNKNOWN 0x00 
    .byte 0xe7              ;ccf7  e7          UNKNOWN 0xe7 
    .byte 0x50              ;ccf8  50          UNKNOWN 0x50 'P' 
    .byte 0x09              ;ccf9  09          UNKNOWN 0x09 
    .byte 0xc7              ;ccfa  c7          UNKNOWN 0xc7 
    .byte 0x50              ;ccfb  50          UNKNOWN 0x50 'P' 

sub_ccfc:
    clt                     ;ccfc  12       
    bbs 5,mem_0050,lab_cd1b ;ccfd  a7 50 1b 
    stp                     ;cd00  42       

    .byte 0x80              ;cd01  80          UNKNOWN 0x80 
    .byte 0xfd              ;cd02  fd          UNKNOWN 0xfd 

sub_cd03:
    lda #0x00               ;cd03  a9 00    
    bbs 0,mem_000e,lab_cd24 ;cd05  07 0e 1c 
    lda #0x01               ;cd08  a9 01    
    bbc 1,P5,lab_cd24       ;cd0a  37 0a 17 

sub_cd0d:
    bra lab_cd26            ;cd0d  80 17    

    .byte 0xa9              ;cd0f  a9          UNKNOWN 0xa9 
    .byte 0x03              ;cd10  03          UNKNOWN 0x03 
    .byte 0x37              ;cd11  37          UNKNOWN 0x37 '7' 
    .byte 0x0a              ;cd12  0a          UNKNOWN 0x0a 
    .byte 0x10              ;cd13  10          UNKNOWN 0x10 
    .byte 0xa9              ;cd14  a9          UNKNOWN 0xa9 
    .byte 0x02              ;cd15  02          UNKNOWN 0x02 
    .byte 0x17              ;cd16  17          UNKNOWN 0x17 

lab_cd17:
    asl mem_800b            ;cd17  0e 0b 80 
    seb 0,a                 ;cd1a  0b       

lab_cd1b:
    lda #0x04               ;cd1b  a9 04    
    bbs 1,P5,lab_cd24       ;cd1d  27 0a 04 
    lda #0x05               ;cd20  a9 05    
    bra lab_cd26            ;cd22  80 02    

lab_cd24:
    sec                     ;cd24  38       
    rts                     ;cd25  60       

lab_cd26:
    clc                     ;cd26  18       
    rts                     ;cd27  60       

    .byte 0x07              ;cd28  07          UNKNOWN 0x07 
    .byte 0x82              ;cd29  82          UNKNOWN 0x82 
    .byte 0x30              ;cd2a  30          UNKNOWN 0x30 '0' 
    .byte 0xa5              ;cd2b  a5          UNKNOWN 0xa5 
    .byte 0x8f              ;cd2c  8f          UNKNOWN 0x8f 
    .byte 0xd0              ;cd2d  d0          UNKNOWN 0xd0 
    .byte 0x2c              ;cd2e  2c          UNKNOWN 0x2c ',' 
    .byte 0x07              ;cd2f  07          UNKNOWN 0x07 
    .byte 0x08              ;cd30  08          UNKNOWN 0x08 
    .byte 0x03              ;cd31  03          UNKNOWN 0x03 
    .byte 0x37              ;cd32  37          UNKNOWN 0x37 '7' 
    .byte 0x0e              ;cd33  0e          UNKNOWN 0x0e 
    .byte 0x15              ;cd34  15          UNKNOWN 0x15 
    .byte 0x20              ;cd35  20          UNKNOWN 0x20 ' ' 
    .byte 0x9a              ;cd36  9a          UNKNOWN 0x9a 
    .byte 0xd0              ;cd37  d0          UNKNOWN 0xd0 
    .byte 0x8a              ;cd38  8a          UNKNOWN 0x8a 
    .byte 0xf0              ;cd39  f0          UNKNOWN 0xf0 
    .byte 0x0f              ;cd3a  0f          UNKNOWN 0x0f 
    .byte 0x07              ;cd3b  07          UNKNOWN 0x07 
    .byte 0x6d              ;cd3c  6d          UNKNOWN 0x6d 'm' 
    .byte 0x1d              ;cd3d  1d          UNKNOWN 0x1d 
    .byte 0x20              ;cd3e  20          UNKNOWN 0x20 ' ' 
    .byte 0x95              ;cd3f  95          UNKNOWN 0x95 
    .byte 0xce              ;cd40  ce          UNKNOWN 0xce 
    .byte 0x0f              ;cd41  0f          UNKNOWN 0x0f 
    .byte 0x6d              ;cd42  6d          UNKNOWN 0x6d 'm' 
    .byte 0x20              ;cd43  20          UNKNOWN 0x20 ' ' 
    .byte 0x4a              ;cd44  4a          UNKNOWN 0x4a 'J' 
    .byte 0xce              ;cd45  ce          UNKNOWN 0xce 
    .byte 0xa9              ;cd46  a9          UNKNOWN 0xa9 

mem_cd47:
    .byte 0x00              ;cd47  00          DATA 0x00 

mem_cd48:
    .byte 0x38              ;cd48  38          DATA 0x38 '8' 

mem_cd49:
    .byte 0x60              ;cd49  60          DATA 0x60 '`' 

mem_cd4a:
    .byte 0x17              ;cd4a  17          DATA 0x17 

mem_cd4b:
    .byte 0x6d              ;cd4b  6d          DATA 0x6d 'm' 

mem_cd4c:
    .byte 0x0e              ;cd4c  0e          DATA 0x0e 
    .byte 0x20              ;cd4d  20          DATA 0x20 ' ' 
    .byte 0x95              ;cd4e  95          DATA 0x95 
    .byte 0xce              ;cd4f  ce          DATA 0xce 
    .byte 0x1f              ;cd50  1f          DATA 0x1f 
    .byte 0x6d              ;cd51  6d          DATA 0x6d 'm' 
    .byte 0xff              ;cd52  ff          DATA 0xff 
    .byte 0x08              ;cd53  08          DATA 0x08 
    .byte 0x20              ;cd54  20          DATA 0x20 ' ' 
    .byte 0x4a              ;cd55  4a          DATA 0x4a 'J' 
    .byte 0xce              ;cd56  ce          DATA 0xce 
    .byte 0xa9              ;cd57  a9          DATA 0xa9 
    .byte 0x01              ;cd58  01          DATA 0x01 
    .byte 0x38              ;cd59  38          DATA 0x38 '8' 
    .byte 0x60              ;cd5a  60          DATA 0x60 '`' 
    .byte 0x18              ;cd5b  18          DATA 0x18 
    .byte 0x60              ;cd5c  60          DATA 0x60 '`' 
    .byte 0xe7              ;cd5d  e7          DATA 0xe7 
    .byte 0xcc              ;cd5e  cc          DATA 0xcc 
    .byte 0x68              ;cd5f  68          DATA 0x68 'h' 
    .byte 0x37              ;cd60  37          DATA 0x37 '7' 
    .byte 0x08              ;cd61  08          DATA 0x08 
    .byte 0x25              ;cd62  25          DATA 0x25 '%' 
    .byte 0xf7              ;cd63  f7          DATA 0xf7 
    .byte 0xd3              ;cd64  d3          DATA 0xd3 
    .byte 0x62              ;cd65  62          DATA 0x62 'b' 
    .byte 0x08              ;cd66  08          DATA 0x08 
    .byte 0x78              ;cd67  78          DATA 0x78 'x' 
    .byte 0xff              ;cd68  ff          DATA 0xff 
    .byte 0xd3              ;cd69  d3          DATA 0xd3 
    .byte 0x1f              ;cd6a  1f          DATA 0x1f 
    .byte 0xd3              ;cd6b  d3          DATA 0xd3 
    .byte 0x9f              ;cd6c  9f          DATA 0x9f 
    .byte 0x02              ;cd6d  02          DATA 0x02 
    .byte 0x3c              ;cd6e  3c          DATA 0x3c '<' 
    .byte 0x00              ;cd6f  00          DATA 0x00 
    .byte 0x00              ;cd70  00          DATA 0x00 
    .byte 0x3c              ;cd71  3c          DATA 0x3c '<' 
    .byte 0x00              ;cd72  00          DATA 0x00 
    .byte 0x01              ;cd73  01          DATA 0x01 
    .byte 0x3c              ;cd74  3c          DATA 0x3c '<' 
    .byte 0x00              ;cd75  00          DATA 0x00 
    .byte 0xd3              ;cd76  d3          DATA 0xd3 

sub_cd77:
    ldm #0x00,mem_00d8      ;cd77  3c 00 d8 
    seb 7,P1                ;cd7a  ef 02    
    clb 1,ICON1             ;cd7c  3f 3e    
    clb 3,P1                ;cd7e  7f 02    
    clb 1,P1                ;cd80  3f 02    
    plp                     ;cd82  28       
    nop                     ;cd83  ea       
    lda #0x00               ;cd84  a9 00    
    sec                     ;cd86  38       
    rts                     ;cd87  60       

    .byte 0xf7              ;cd88  f7          UNKNOWN 0xf7 
    .byte 0x50              ;cd89  50          UNKNOWN 0x50 'P' 
    .byte 0x3d              ;cd8a  3d          UNKNOWN 0x3d '=' 
    .byte 0x37              ;cd8b  37          UNKNOWN 0x37 '7' 
    .byte 0x0a              ;cd8c  0a          UNKNOWN 0x0a 
    .byte 0x3a              ;cd8d  3a          UNKNOWN 0x3a ':' 
    .byte 0x07              ;cd8e  07          UNKNOWN 0x07 
    .byte 0x0e              ;cd8f  0e          UNKNOWN 0x0e 
    .byte 0x37              ;cd90  37          UNKNOWN 0x37 '7' 
    .byte 0xe7              ;cd91  e7          UNKNOWN 0xe7 
    .byte 0xd3              ;cd92  d3          UNKNOWN 0xd3 
    .byte 0x34              ;cd93  34          UNKNOWN 0x34 '4' 
    .byte 0x08              ;cd94  08          UNKNOWN 0x08 
    .byte 0x78              ;cd95  78          UNKNOWN 0x78 'x' 
    .byte 0x3f              ;cd96  3f          UNKNOWN 0x3f '?' 
    .byte 0x3c              ;cd97  3c          UNKNOWN 0x3c '<' 
    .byte 0x2f              ;cd98  2f          UNKNOWN 0x2f '/' 
    .byte 0x3e              ;cd99  3e          UNKNOWN 0x3e '>' 
    .byte 0x6f              ;cd9a  6f          UNKNOWN 0x6f 'o' 
    .byte 0x02              ;cd9b  02          UNKNOWN 0x02 
    .byte 0x2f              ;cd9c  2f          UNKNOWN 0x2f '/' 
    .byte 0x02              ;cd9d  02          UNKNOWN 0x02 
    .byte 0xff              ;cd9e  ff          UNKNOWN 0xff 
    .byte 0x02              ;cd9f  02          UNKNOWN 0x02 
    .byte 0x8f              ;cda0  8f          UNKNOWN 0x8f 
    .byte 0x02              ;cda1  02          UNKNOWN 0x02 
    .byte 0x3c              ;cda2  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cda3  00          UNKNOWN 0x00 
    .byte 0x00              ;cda4  00          UNKNOWN 0x00 
    .byte 0x3c              ;cda5  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;cda6  ff          UNKNOWN 0xff 
    .byte 0x01              ;cda7  01          UNKNOWN 0x01 

sub_cda8:
    ldm #0x00,mem_00ce      ;cda8  3c 00 ce 
    ldm #0x00,mem_00cf      ;cdab  3c 00 cf 
    ldm #0x00,mem_00d0      ;cdae  3c 00 d0 
    ldm #0xc1,mem_00d3      ;cdb1  3c c1 d3 
    ldm #0x80,mem_00d5      ;cdb4  3c 80 d5 
    ldm #0x00,mem_00d8      ;cdb7  3c 00 d8 
    ldm #0x00,mem_00d9      ;cdba  3c 00 d9 
    clb 3,mem_0095          ;cdbd  7f 95    
    ldm #0x00,mem_0099      ;cdbf  3c 00 99 
    plp                     ;cdc2  28       
    nop                     ;cdc3  ea       
    lda #0x01               ;cdc4  a9 01    
    sec                     ;cdc6  38       
    rts                     ;cdc7  60       

    .byte 0x18              ;cdc8  18          UNKNOWN 0x18 
    .byte 0x60              ;cdc9  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;cdca  a5          UNKNOWN 0xa5 
    .byte 0x73              ;cdcb  73          UNKNOWN 0x73 's' 
    .byte 0x8d              ;cdcc  8d          UNKNOWN 0x8d 
    .byte 0x00              ;cdcd  00          UNKNOWN 0x00 
    .byte 0x01              ;cdce  01          UNKNOWN 0x01 
    .byte 0xa9              ;cdcf  a9          UNKNOWN 0xa9 
    .byte 0x00              ;cdd0  00          UNKNOWN 0x00 
    .byte 0x85              ;cdd1  85          UNKNOWN 0x85 
    .byte 0x73              ;cdd2  73          UNKNOWN 0x73 's' 
    .byte 0xb7              ;cdd3  b7          UNKNOWN 0xb7 
    .byte 0x6c              ;cdd4  6c          UNKNOWN 0x6c 'l' 
    .byte 0x10              ;cdd5  10          UNKNOWN 0x10 
    .byte 0xbf              ;cdd6  bf          UNKNOWN 0xbf 
    .byte 0x6c              ;cdd7  6c          UNKNOWN 0x6c 'l' 
    .byte 0x08              ;cdd8  08          UNKNOWN 0x08 
    .byte 0x78              ;cdd9  78          UNKNOWN 0x78 'x' 
    .byte 0x3c              ;cdda  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cddb  00          UNKNOWN 0x00 
    .byte 0x88              ;cddc  88          UNKNOWN 0x88 

sub_cddd:
    ldm #0x00,mem_008c      ;cddd  3c 00 8c 
    clb 6,mem_0082          ;cde0  df 82    
    clb 5,mem_0082          ;cde2  bf 82    
    plp                     ;cde4  28       
    nop                     ;cde5  ea       
    rts                     ;cde6  60       

    .byte 0x08              ;cde7  08          UNKNOWN 0x08 
    .byte 0x78              ;cde8  78          UNKNOWN 0x78 'x' 
    .byte 0x3c              ;cde9  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cdea  00          UNKNOWN 0x00 
    .byte 0x87              ;cdeb  87          UNKNOWN 0x87 
    .byte 0x3c              ;cdec  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;cded  02          UNKNOWN 0x02 
    .byte 0x89              ;cdee  89          UNKNOWN 0x89 
    .byte 0x3c              ;cdef  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;cdf0  02          UNKNOWN 0x02 
    .byte 0x8a              ;cdf1  8a          UNKNOWN 0x8a 
    .byte 0x3c              ;cdf2  3c          UNKNOWN 0x3c '<' 
    .byte 0x01              ;cdf3  01          UNKNOWN 0x01 
    .byte 0x8b              ;cdf4  8b          UNKNOWN 0x8b 
    .byte 0x3c              ;cdf5  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;cdf6  02          UNKNOWN 0x02 
    .byte 0x8d              ;cdf7  8d          UNKNOWN 0x8d 
    .byte 0x3c              ;cdf8  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;cdf9  02          UNKNOWN 0x02 
    .byte 0x8e              ;cdfa  8e          UNKNOWN 0x8e 
    .byte 0xcf              ;cdfb  cf          UNKNOWN 0xcf 
    .byte 0x82              ;cdfc  82          UNKNOWN 0x82 
    .byte 0xaf              ;cdfd  af          UNKNOWN 0xaf 
    .byte 0x82              ;cdfe  82          UNKNOWN 0x82 
    .byte 0x28              ;cdff  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;ce00  ea          UNKNOWN 0xea 
    .byte 0x60              ;ce01  60          UNKNOWN 0x60 '`' 
    .byte 0xe7              ;ce02  e7          UNKNOWN 0xe7 
    .byte 0x6c              ;ce03  6c          UNKNOWN 0x6c 'l' 
    .byte 0x0f              ;ce04  0f          UNKNOWN 0x0f 
    .byte 0x08              ;ce05  08          UNKNOWN 0x08 
    .byte 0x78              ;ce06  78          UNKNOWN 0x78 'x' 
    .byte 0x3c              ;ce07  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;ce08  00          UNKNOWN 0x00 
    .byte 0x8b              ;ce09  8b          UNKNOWN 0x8b 
    .byte 0x3c              ;ce0a  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;ce0b  02          UNKNOWN 0x02 
    .byte 0x8d              ;ce0c  8d          UNKNOWN 0x8d 
    .byte 0x3c              ;ce0d  3c          UNKNOWN 0x3c '<' 
    .byte 0x02              ;ce0e  02          UNKNOWN 0x02 
    .byte 0x8e              ;ce0f  8e          UNKNOWN 0x8e 
    .byte 0xaf              ;ce10  af          UNKNOWN 0xaf 
    .byte 0x82              ;ce11  82          UNKNOWN 0x82 
    .byte 0x28              ;ce12  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;ce13  ea          UNKNOWN 0xea 
    .byte 0x60              ;ce14  60          UNKNOWN 0x60 '`' 
    .byte 0xf7              ;ce15  f7          UNKNOWN 0xf7 
    .byte 0x50              ;ce16  50          UNKNOWN 0x50 'P' 
    .byte 0x0c              ;ce17  0c          UNKNOWN 0x0c 
    .byte 0x08              ;ce18  08          UNKNOWN 0x08 
    .byte 0x78              ;ce19  78          UNKNOWN 0x78 'x' 
    .byte 0x3c              ;ce1a  3c          UNKNOWN 0x3c '<' 
    .byte 0xc5              ;ce1b  c5          UNKNOWN 0xc5 
    .byte 0x90              ;ce1c  90          UNKNOWN 0x90 
    .byte 0x3c              ;ce1d  3c          UNKNOWN 0x3c '<' 
    .byte 0xce              ;ce1e  ce          UNKNOWN 0xce 
    .byte 0x91              ;ce1f  91          UNKNOWN 0x91 
    .byte 0x0f              ;ce20  0f          UNKNOWN 0x0f 
    .byte 0x82              ;ce21  82          UNKNOWN 0x82 
    .byte 0x28              ;ce22  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;ce23  ea          UNKNOWN 0xea 
    .byte 0x60              ;ce24  60          UNKNOWN 0x60 '`' 
    .byte 0xf7              ;ce25  f7          UNKNOWN 0xf7 
    .byte 0x50              ;ce26  50          UNKNOWN 0x50 'P' 
    .byte 0x0c              ;ce27  0c          UNKNOWN 0x0c 
    .byte 0x08              ;ce28  08          UNKNOWN 0x08 
    .byte 0x78              ;ce29  78          UNKNOWN 0x78 'x' 
    .byte 0x3c              ;ce2a  3c          UNKNOWN 0x3c '<' 
    .byte 0xd0              ;ce2b  d0          UNKNOWN 0xd0 
    .byte 0x90              ;ce2c  90          UNKNOWN 0x90 
    .byte 0x3c              ;ce2d  3c          UNKNOWN 0x3c '<' 
    .byte 0xce              ;ce2e  ce          UNKNOWN 0xce 
    .byte 0x91              ;ce2f  91          UNKNOWN 0x91 
    .byte 0x0f              ;ce30  0f          UNKNOWN 0x0f 
    .byte 0x82              ;ce31  82          UNKNOWN 0x82 
    .byte 0x28              ;ce32  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;ce33  ea          UNKNOWN 0xea 
    .byte 0x60              ;ce34  60          UNKNOWN 0x60 '`' 
    .byte 0xf7              ;ce35  f7          UNKNOWN 0xf7 
    .byte 0x50              ;ce36  50          UNKNOWN 0x50 'P' 
    .byte 0x0c              ;ce37  0c          UNKNOWN 0x0c 
    .byte 0x08              ;ce38  08          UNKNOWN 0x08 
    .byte 0x78              ;ce39  78          UNKNOWN 0x78 'x' 
    .byte 0x3c              ;ce3a  3c          UNKNOWN 0x3c '<' 
    .byte 0xde              ;ce3b  de          UNKNOWN 0xde 
    .byte 0x90              ;ce3c  90          UNKNOWN 0x90 
    .byte 0x3c              ;ce3d  3c          UNKNOWN 0x3c '<' 
    .byte 0xce              ;ce3e  ce          UNKNOWN 0xce 
    .byte 0x91              ;ce3f  91          UNKNOWN 0x91 
    .byte 0x0f              ;ce40  0f          UNKNOWN 0x0f 
    .byte 0x82              ;ce41  82          UNKNOWN 0x82 
    .byte 0x28              ;ce42  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;ce43  ea          UNKNOWN 0xea 
    .byte 0x60              ;ce44  60          UNKNOWN 0x60 '`' 
    .byte 0x00              ;ce45  00          UNKNOWN 0x00 
    .byte 0x00              ;ce46  00          UNKNOWN 0x00 
    .byte 0x01              ;ce47  01          UNKNOWN 0x01 
    .byte 0x15              ;ce48  15          UNKNOWN 0x15 
    .byte 0x00              ;ce49  00          UNKNOWN 0x00 

sub_ce4a:
    ora SIO1CON             ;ce4a  05 1a    
    brk                     ;ce4c  00       

    .byte 0x05              ;ce4d  05          UNKNOWN 0x05 
    .byte 0xff              ;ce4e  ff          UNKNOWN 0xff 
    .byte 0xff              ;ce4f  ff          UNKNOWN 0xff 
    .byte 0x00              ;ce50  00          UNKNOWN 0x00 
    .byte 0x00              ;ce51  00          UNKNOWN 0x00 
    .byte 0x01              ;ce52  01          UNKNOWN 0x01 
    .byte 0x1e              ;ce53  1e          UNKNOWN 0x1e 
    .byte 0x00              ;ce54  00          UNKNOWN 0x00 
    .byte 0x05              ;ce55  05          UNKNOWN 0x05 
    .byte 0x00              ;ce56  00          UNKNOWN 0x00 
    .byte 0x00              ;ce57  00          UNKNOWN 0x00 
    .byte 0x05              ;ce58  05          UNKNOWN 0x05 
    .byte 0x1e              ;ce59  1e          UNKNOWN 0x1e 
    .byte 0x00              ;ce5a  00          UNKNOWN 0x00 
    .byte 0x05              ;ce5b  05          UNKNOWN 0x05 
    .byte 0xff              ;ce5c  ff          UNKNOWN 0xff 
    .byte 0xff              ;ce5d  ff          UNKNOWN 0xff 
    .byte 0x00              ;ce5e  00          UNKNOWN 0x00 
    .byte 0x00              ;ce5f  00          UNKNOWN 0x00 
    .byte 0x01              ;ce60  01          UNKNOWN 0x01 
    .byte 0x1e              ;ce61  1e          UNKNOWN 0x1e 
    .byte 0x00              ;ce62  00          UNKNOWN 0x00 
    .byte 0x14              ;ce63  14          UNKNOWN 0x14 
    .byte 0x7a              ;ce64  7a          UNKNOWN 0x7a 'z' 
    .byte 0x00              ;ce65  00          UNKNOWN 0x00 
    .byte 0x14              ;ce66  14          UNKNOWN 0x14 

sub_ce67:
    asl mem_1400,x          ;ce67  1e 00 14 
    .byte 0x7a              ;ce6a  7a       Illegal instruction

    .byte 0x00              ;ce6b  00          UNKNOWN 0x00 
    .byte 0x14              ;ce6c  14          UNKNOWN 0x14 
    .byte 0x1e              ;ce6d  1e          UNKNOWN 0x1e 
    .byte 0x00              ;ce6e  00          UNKNOWN 0x00 
    .byte 0x14              ;ce6f  14          UNKNOWN 0x14 
    .byte 0x7a              ;ce70  7a          UNKNOWN 0x7a 'z' 
    .byte 0x00              ;ce71  00          UNKNOWN 0x00 
    .byte 0x14              ;ce72  14          UNKNOWN 0x14 
    .byte 0x00              ;ce73  00          UNKNOWN 0x00 
    .byte 0x00              ;ce74  00          UNKNOWN 0x00 
    .byte 0x0a              ;ce75  0a          UNKNOWN 0x0a 
    .byte 0x1e              ;ce76  1e          UNKNOWN 0x1e 
    .byte 0x00              ;ce77  00          UNKNOWN 0x00 
    .byte 0x14              ;ce78  14          UNKNOWN 0x14 
    .byte 0x7a              ;ce79  7a          UNKNOWN 0x7a 'z' 
    .byte 0x00              ;ce7a  00          UNKNOWN 0x00 
    .byte 0x14              ;ce7b  14          UNKNOWN 0x14 
    .byte 0x1e              ;ce7c  1e          UNKNOWN 0x1e 
    .byte 0x00              ;ce7d  00          UNKNOWN 0x00 
    .byte 0x14              ;ce7e  14          UNKNOWN 0x14 
    .byte 0x7a              ;ce7f  7a          UNKNOWN 0x7a 'z' 
    .byte 0x00              ;ce80  00          UNKNOWN 0x00 
    .byte 0x14              ;ce81  14          UNKNOWN 0x14 
    .byte 0x1e              ;ce82  1e          UNKNOWN 0x1e 
    .byte 0x00              ;ce83  00          UNKNOWN 0x00 
    .byte 0x14              ;ce84  14          UNKNOWN 0x14 
    .byte 0x7a              ;ce85  7a          UNKNOWN 0x7a 'z' 
    .byte 0x00              ;ce86  00          UNKNOWN 0x00 
    .byte 0x14              ;ce87  14          UNKNOWN 0x14 
    .byte 0xff              ;ce88  ff          UNKNOWN 0xff 
    .byte 0xff              ;ce89  ff          UNKNOWN 0xff 
    .byte 0x3c              ;ce8a  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;ce8b  00          UNKNOWN 0x00 
    .byte 0x74              ;ce8c  74          UNKNOWN 0x74 't' 
    .byte 0x3c              ;ce8d  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;ce8e  00          UNKNOWN 0x00 
    .byte 0x7a              ;ce8f  7a          UNKNOWN 0x7a 'z' 
    .byte 0x3c              ;ce90  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;ce91  00          UNKNOWN 0x00 
    .byte 0x7b              ;ce92  7b          UNKNOWN 0x7b '{' 
    .byte 0x3c              ;ce93  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;ce94  ff          UNKNOWN 0xff 
    .byte 0x75              ;ce95  75          UNKNOWN 0x75 'u' 
    .byte 0x3c              ;ce96  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;ce97  ff          UNKNOWN 0xff 
    .byte 0x7c              ;ce98  7c          UNKNOWN 0x7c '|' 
    .byte 0x3c              ;ce99  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;ce9a  ff          UNKNOWN 0xff 
    .byte 0x7d              ;ce9b  7d          UNKNOWN 0x7d '}' 
    .byte 0x60              ;ce9c  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;ce9d  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;ce9e  00          UNKNOWN 0x00 
    .byte 0x76              ;ce9f  76          UNKNOWN 0x76 'v' 
    .byte 0x3c              ;cea0  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;cea1  00          UNKNOWN 0x00 
    .byte 0x77              ;cea2  77          UNKNOWN 0x77 'w' 
    .byte 0x3c              ;cea3  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;cea4  ff          UNKNOWN 0xff 
    .byte 0x78              ;cea5  78          UNKNOWN 0x78 'x' 
    .byte 0x3c              ;cea6  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;cea7  ff          UNKNOWN 0xff 
    .byte 0x79              ;cea8  79          UNKNOWN 0x79 'y' 
    .byte 0x60              ;cea9  60          UNKNOWN 0x60 '`' 
    .byte 0x78              ;ceaa  78          UNKNOWN 0x78 'x' 
    .byte 0x00              ;ceab  00          UNKNOWN 0x00 
    .byte 0x00              ;ceac  00          UNKNOWN 0x00 
    .byte 0x83              ;cead  83          UNKNOWN 0x83 
    .byte 0x01              ;ceae  01          UNKNOWN 0x01 
    .byte 0x00              ;ceaf  00          UNKNOWN 0x00 
    .byte 0x8c              ;ceb0  8c          UNKNOWN 0x8c 
    .byte 0x05              ;ceb1  05          UNKNOWN 0x05 
    .byte 0x03              ;ceb2  03          UNKNOWN 0x03 
    .byte 0x8e              ;ceb3  8e          UNKNOWN 0x8e 
    .byte 0x0a              ;ceb4  0a          UNKNOWN 0x0a 
    .byte 0x04              ;ceb5  04          UNKNOWN 0x04 
    .byte 0x90              ;ceb6  90          UNKNOWN 0x90 
    .byte 0x14              ;ceb7  14          UNKNOWN 0x14 
    .byte 0x07              ;ceb8  07          UNKNOWN 0x07 
    .byte 0x92              ;ceb9  92          UNKNOWN 0x92 
    .byte 0x1e              ;ceba  1e          UNKNOWN 0x1e 
    .byte 0x07              ;cebb  07          UNKNOWN 0x07 
    .byte 0x94              ;cebc  94          UNKNOWN 0x94 
    .byte 0x28              ;cebd  28          UNKNOWN 0x28 '(' 
    .byte 0x07              ;cebe  07          UNKNOWN 0x07 
    .byte 0x95              ;cebf  95          UNKNOWN 0x95 
    .byte 0x32              ;cec0  32          UNKNOWN 0x32 '2' 
    .byte 0x07              ;cec1  07          UNKNOWN 0x07 
    .byte 0x97              ;cec2  97          UNKNOWN 0x97 
    .byte 0x3c              ;cec3  3c          UNKNOWN 0x3c '<' 
    .byte 0x07              ;cec4  07          UNKNOWN 0x07 
    .byte 0x99              ;cec5  99          UNKNOWN 0x99 
    .byte 0x46              ;cec6  46          UNKNOWN 0x46 'F' 
    .byte 0x07              ;cec7  07          UNKNOWN 0x07 
    .byte 0x9c              ;cec8  9c          UNKNOWN 0x9c 
    .byte 0x50              ;cec9  50          UNKNOWN 0x50 'P' 
    .byte 0x07              ;ceca  07          UNKNOWN 0x07 
    .byte 0x9f              ;cecb  9f          UNKNOWN 0x9f 
    .byte 0x5a              ;cecc  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x07              ;cecd  07          UNKNOWN 0x07 
    .byte 0xa2              ;cece  a2          UNKNOWN 0xa2 
    .byte 0x64              ;cecf  64          UNKNOWN 0x64 'd' 
    .byte 0x07              ;ced0  07          UNKNOWN 0x07 
    .byte 0xff              ;ced1  ff          UNKNOWN 0xff 
    .byte 0x64              ;ced2  64          UNKNOWN 0x64 'd' 
    .byte 0x00              ;ced3  00          UNKNOWN 0x00 
    .byte 0x6c              ;ced4  6c          UNKNOWN 0x6c 'l' 
    .byte 0x00              ;ced5  00          UNKNOWN 0x00 
    .byte 0x00              ;ced6  00          UNKNOWN 0x00 
    .byte 0x70              ;ced7  70          UNKNOWN 0x70 'p' 
    .byte 0x01              ;ced8  01          UNKNOWN 0x01 
    .byte 0x00              ;ced9  00          UNKNOWN 0x00 
    .byte 0x77              ;ceda  77          UNKNOWN 0x77 'w' 
    .byte 0x05              ;cedb  05          UNKNOWN 0x05 
    .byte 0x03              ;cedc  03          UNKNOWN 0x03 
    .byte 0x7e              ;cedd  7e          UNKNOWN 0x7e '~' 
    .byte 0x0a              ;cede  0a          UNKNOWN 0x0a 
    .byte 0x04              ;cedf  04          UNKNOWN 0x04 
    .byte 0x88              ;cee0  88          UNKNOWN 0x88 
    .byte 0x14              ;cee1  14          UNKNOWN 0x14 
    .byte 0x07              ;cee2  07          UNKNOWN 0x07 
    .byte 0x8f              ;cee3  8f          UNKNOWN 0x8f 
    .byte 0x1e              ;cee4  1e          UNKNOWN 0x1e 
    .byte 0x07              ;cee5  07          UNKNOWN 0x07 
    .byte 0x95              ;cee6  95          UNKNOWN 0x95 
    .byte 0x28              ;cee7  28          UNKNOWN 0x28 '(' 
    .byte 0x07              ;cee8  07          UNKNOWN 0x07 
    .byte 0x97              ;cee9  97          UNKNOWN 0x97 
    .byte 0x32              ;ceea  32          UNKNOWN 0x32 '2' 
    .byte 0x07              ;ceeb  07          UNKNOWN 0x07 
    .byte 0x99              ;ceec  99          UNKNOWN 0x99 
    .byte 0x3c              ;ceed  3c          UNKNOWN 0x3c '<' 
    .byte 0x07              ;ceee  07          UNKNOWN 0x07 
    .byte 0x9b              ;ceef  9b          UNKNOWN 0x9b 
    .byte 0x46              ;cef0  46          UNKNOWN 0x46 'F' 
    .byte 0x07              ;cef1  07          UNKNOWN 0x07 
    .byte 0x9d              ;cef2  9d          UNKNOWN 0x9d 
    .byte 0x50              ;cef3  50          UNKNOWN 0x50 'P' 
    .byte 0x07              ;cef4  07          UNKNOWN 0x07 
    .byte 0xa0              ;cef5  a0          UNKNOWN 0xa0 
    .byte 0x5a              ;cef6  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x07              ;cef7  07          UNKNOWN 0x07 
    .byte 0xa2              ;cef8  a2          UNKNOWN 0xa2 
    .byte 0x64              ;cef9  64          UNKNOWN 0x64 'd' 
    .byte 0x07              ;cefa  07          UNKNOWN 0x07 
    .byte 0xff              ;cefb  ff          UNKNOWN 0xff 
    .byte 0x64              ;cefc  64          UNKNOWN 0x64 'd' 
    .byte 0x00              ;cefd  00          UNKNOWN 0x00 
    .byte 0x74              ;cefe  74          UNKNOWN 0x74 't' 
    .byte 0x00              ;ceff  00          UNKNOWN 0x00 
    .byte 0x00              ;cf00  00          UNKNOWN 0x00 
    .byte 0x7d              ;cf01  7d          UNKNOWN 0x7d '}' 
    .byte 0x01              ;cf02  01          UNKNOWN 0x01 
    .byte 0x00              ;cf03  00          UNKNOWN 0x00 
    .byte 0x81              ;cf04  81          UNKNOWN 0x81 
    .byte 0x05              ;cf05  05          UNKNOWN 0x05 
    .byte 0x03              ;cf06  03          UNKNOWN 0x03 
    .byte 0x8a              ;cf07  8a          UNKNOWN 0x8a 
    .byte 0x0a              ;cf08  0a          UNKNOWN 0x0a 
    .byte 0x04              ;cf09  04          UNKNOWN 0x04 
    .byte 0x96              ;cf0a  96          UNKNOWN 0x96 
    .byte 0x14              ;cf0b  14          UNKNOWN 0x14 
    .byte 0x07              ;cf0c  07          UNKNOWN 0x07 
    .byte 0x9f              ;cf0d  9f          UNKNOWN 0x9f 
    .byte 0x1e              ;cf0e  1e          UNKNOWN 0x1e 
    .byte 0x07              ;cf0f  07          UNKNOWN 0x07 
    .byte 0xa9              ;cf10  a9          UNKNOWN 0xa9 
    .byte 0x28              ;cf11  28          UNKNOWN 0x28 '(' 
    .byte 0x07              ;cf12  07          UNKNOWN 0x07 
    .byte 0xb3              ;cf13  b3          UNKNOWN 0xb3 
    .byte 0x32              ;cf14  32          UNKNOWN 0x32 '2' 
    .byte 0x07              ;cf15  07          UNKNOWN 0x07 
    .byte 0xbd              ;cf16  bd          UNKNOWN 0xbd 
    .byte 0x3c              ;cf17  3c          UNKNOWN 0x3c '<' 
    .byte 0x07              ;cf18  07          UNKNOWN 0x07 
    .byte 0xc7              ;cf19  c7          UNKNOWN 0xc7 
    .byte 0x46              ;cf1a  46          UNKNOWN 0x46 'F' 
    .byte 0x07              ;cf1b  07          UNKNOWN 0x07 
    .byte 0xd1              ;cf1c  d1          UNKNOWN 0xd1 
    .byte 0x50              ;cf1d  50          UNKNOWN 0x50 'P' 
    .byte 0x07              ;cf1e  07          UNKNOWN 0x07 
    .byte 0xdb              ;cf1f  db          UNKNOWN 0xdb 
    .byte 0x5a              ;cf20  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x07              ;cf21  07          UNKNOWN 0x07 
    .byte 0xdb              ;cf22  db          UNKNOWN 0xdb 
    .byte 0x64              ;cf23  64          UNKNOWN 0x64 'd' 
    .byte 0x07              ;cf24  07          UNKNOWN 0x07 
    .byte 0xff              ;cf25  ff          UNKNOWN 0xff 
    .byte 0x64              ;cf26  64          UNKNOWN 0x64 'd' 
    .byte 0x00              ;cf27  00          UNKNOWN 0x00 
    .byte 0x74              ;cf28  74          UNKNOWN 0x74 't' 
    .byte 0x00              ;cf29  00          UNKNOWN 0x00 
    .byte 0x00              ;cf2a  00          UNKNOWN 0x00 
    .byte 0x83              ;cf2b  83          UNKNOWN 0x83 
    .byte 0x01              ;cf2c  01          UNKNOWN 0x01 
    .byte 0x00              ;cf2d  00          UNKNOWN 0x00 
    .byte 0x87              ;cf2e  87          UNKNOWN 0x87 
    .byte 0x05              ;cf2f  05          UNKNOWN 0x05 
    .byte 0x03              ;cf30  03          UNKNOWN 0x03 
    .byte 0x90              ;cf31  90          UNKNOWN 0x90 
    .byte 0x0a              ;cf32  0a          UNKNOWN 0x0a 
    .byte 0x04              ;cf33  04          UNKNOWN 0x04 
    .byte 0x9a              ;cf34  9a          UNKNOWN 0x9a 
    .byte 0x14              ;cf35  14          UNKNOWN 0x14 
    .byte 0x07              ;cf36  07          UNKNOWN 0x07 
    .byte 0xa4              ;cf37  a4          UNKNOWN 0xa4 
    .byte 0x1e              ;cf38  1e          UNKNOWN 0x1e 
    .byte 0x07              ;cf39  07          UNKNOWN 0x07 
    .byte 0xae              ;cf3a  ae          UNKNOWN 0xae 
    .byte 0x28              ;cf3b  28          UNKNOWN 0x28 '(' 
    .byte 0x07              ;cf3c  07          UNKNOWN 0x07 
    .byte 0xb7              ;cf3d  b7          UNKNOWN 0xb7 
    .byte 0x32              ;cf3e  32          UNKNOWN 0x32 '2' 
    .byte 0x07              ;cf3f  07          UNKNOWN 0x07 
    .byte 0xc1              ;cf40  c1          UNKNOWN 0xc1 
    .byte 0x3c              ;cf41  3c          UNKNOWN 0x3c '<' 
    .byte 0x07              ;cf42  07          UNKNOWN 0x07 
    .byte 0xcb              ;cf43  cb          UNKNOWN 0xcb 
    .byte 0x46              ;cf44  46          UNKNOWN 0x46 'F' 
    .byte 0x07              ;cf45  07          UNKNOWN 0x07 
    .byte 0xd5              ;cf46  d5          UNKNOWN 0xd5 
    .byte 0x50              ;cf47  50          UNKNOWN 0x50 'P' 
    .byte 0x07              ;cf48  07          UNKNOWN 0x07 
    .byte 0xdf              ;cf49  df          UNKNOWN 0xdf 
    .byte 0x5a              ;cf4a  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x07              ;cf4b  07          UNKNOWN 0x07 
    .byte 0xdf              ;cf4c  df          UNKNOWN 0xdf 
    .byte 0x64              ;cf4d  64          UNKNOWN 0x64 'd' 
    .byte 0x07              ;cf4e  07          UNKNOWN 0x07 
    .byte 0xff              ;cf4f  ff          UNKNOWN 0xff 
    .byte 0x64              ;cf50  64          UNKNOWN 0x64 'd' 
    .byte 0x00              ;cf51  00          UNKNOWN 0x00 
    .byte 0x34              ;cf52  34          UNKNOWN 0x34 '4' 
    .byte 0x00              ;cf53  00          UNKNOWN 0x00 
    .byte 0x22              ;cf54  22          UNKNOWN 0x22 '"' 
    .byte 0x47              ;cf55  47          UNKNOWN 0x47 'G' 
    .byte 0x00              ;cf56  00          UNKNOWN 0x00 
    .byte 0x20              ;cf57  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;cf58  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;cf59  d0          UNKNOWN 0xd0 
    .byte 0x20              ;cf5a  20          UNKNOWN 0x20 ' ' 
    .byte 0x19              ;cf5b  19          UNKNOWN 0x19 
    .byte 0xd0              ;cf5c  d0          UNKNOWN 0xd0 
    .byte 0xa0              ;cf5d  a0          UNKNOWN 0xa0 
    .byte 0x00              ;cf5e  00          UNKNOWN 0x00 
    .byte 0x3c              ;cf5f  3c          UNKNOWN 0x3c '<' 
    .byte 0x07              ;cf60  07          UNKNOWN 0x07 
    .byte 0xf9              ;cf61  f9          UNKNOWN 0xf9 
    .byte 0x17              ;cf62  17          UNKNOWN 0x17 
    .byte 0x6d              ;cf63  6d          UNKNOWN 0x6d 'm' 
    .byte 0x14              ;cf64  14          UNKNOWN 0x14 
    .byte 0xa2              ;cf65  a2          UNKNOWN 0xa2 
    .byte 0x00              ;cf66  00          UNKNOWN 0x00 
    .byte 0xa5              ;cf67  a5          UNKNOWN 0xa5 
    .byte 0x6b              ;cf68  6b          UNKNOWN 0x6b 'k' 
    .byte 0x62              ;cf69  62          UNKNOWN 0x62 'b' 
    .byte 0x6a              ;cf6a  6a          UNKNOWN 0x6a 'j' 
    .byte 0x68              ;cf6b  68          UNKNOWN 0x68 'h' 
    .byte 0xc9              ;cf6c  c9          UNKNOWN 0xc9 
    .byte 0x1c              ;cf6d  1c          UNKNOWN 0x1c 
    .byte 0x90              ;cf6e  90          UNKNOWN 0x90 
    .byte 0x02              ;cf6f  02          UNKNOWN 0x02 
    .byte 0xa9              ;cf70  a9          UNKNOWN 0xa9 
    .byte 0x1b              ;cf71  1b          UNKNOWN 0x1b 
    .byte 0xaa              ;cf72  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;cf73  bd          UNKNOWN 0xbd 
    .byte 0x7d              ;cf74  7d          UNKNOWN 0x7d '}' 
    .byte 0xc5              ;cf75  c5          UNKNOWN 0xc5 
    .byte 0x3a              ;cf76  3a          UNKNOWN 0x3a ':' 
    .byte 0x85              ;cf77  85          UNKNOWN 0x85 
    .byte 0xf9              ;cf78  f9          UNKNOWN 0xf9 
    .byte 0xb1              ;cf79  b1          UNKNOWN 0xb1 
    .byte 0xf5              ;cf7a  f5          UNKNOWN 0xf5 
    .byte 0xc9              ;cf7b  c9          UNKNOWN 0xc9 
    .byte 0xff              ;cf7c  ff          UNKNOWN 0xff 
    .byte 0xf0              ;cf7d  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;cf7e  0c          UNKNOWN 0x0c 
    .byte 0x18              ;cf7f  18          UNKNOWN 0x18 
    .byte 0xe9              ;cf80  e9          UNKNOWN 0xe9 
    .byte 0xf9              ;cf81  f9          UNKNOWN 0xf9 
    .byte 0xc5              ;cf82  c5          UNKNOWN 0xc5 
    .byte 0x6a              ;cf83  6a          UNKNOWN 0x6a 'j' 
    .byte 0xb0              ;cf84  b0          UNKNOWN 0xb0 
    .byte 0x05              ;cf85  05          UNKNOWN 0x05 
    .byte 0xc8              ;cf86  c8          UNKNOWN 0xc8 
    .byte 0xc8              ;cf87  c8          UNKNOWN 0xc8 
    .byte 0xc8              ;cf88  c8          UNKNOWN 0xc8 
    .byte 0x80              ;cf89  80          UNKNOWN 0x80 
    .byte 0xee              ;cf8a  ee          UNKNOWN 0xee 
    .byte 0xc8              ;cf8b  c8          UNKNOWN 0xc8 
    .byte 0xb1              ;cf8c  b1          UNKNOWN 0xb1 
    .byte 0xf5              ;cf8d  f5          UNKNOWN 0xf5 
    .byte 0xc8              ;cf8e  c8          UNKNOWN 0xc8 
    .byte 0x38              ;cf8f  38          UNKNOWN 0x38 '8' 
    .byte 0xf1              ;cf90  f1          UNKNOWN 0xf1 
    .byte 0xf5              ;cf91  f5          UNKNOWN 0xf5 
    .byte 0x60              ;cf92  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;cf93  a9          UNKNOWN 0xa9 
    .byte 0xff              ;cf94  ff          UNKNOWN 0xff 
    .byte 0x60              ;cf95  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;cf96  a9          UNKNOWN 0xa9 
    .byte 0xff              ;cf97  ff          UNKNOWN 0xff 
    .byte 0x60              ;cf98  60          UNKNOWN 0x60 '`' 
    .byte 0xc9              ;cf99  c9          UNKNOWN 0xc9 
    .byte 0x09              ;cf9a  09          UNKNOWN 0x09 
    .byte 0xf0              ;cf9b  f0          UNKNOWN 0xf0 
    .byte 0x2c              ;cf9c  2c          UNKNOWN 0x2c ',' 
    .byte 0xc9              ;cf9d  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;cf9e  0a          UNKNOWN 0x0a 
    .byte 0xf0              ;cf9f  f0          UNKNOWN 0xf0 
    .byte 0x28              ;cfa0  28          UNKNOWN 0x28 '(' 
    .byte 0xc9              ;cfa1  c9          UNKNOWN 0xc9 
    .byte 0x08              ;cfa2  08          UNKNOWN 0x08 
    .byte 0xf0              ;cfa3  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;cfa4  0c          UNKNOWN 0x0c 
    .byte 0xc9              ;cfa5  c9          UNKNOWN 0xc9 
    .byte 0x05              ;cfa6  05          UNKNOWN 0x05 
    .byte 0xd0              ;cfa7  d0          UNKNOWN 0xd0 
    .byte 0x08              ;cfa8  08          UNKNOWN 0x08 
    .byte 0xa5              ;cfa9  a5          UNKNOWN 0xa5 
    .byte 0xc8              ;cfaa  c8          UNKNOWN 0xc8 
    .byte 0xc9              ;cfab  c9          UNKNOWN 0xc9 
    .byte 0x01              ;cfac  01          UNKNOWN 0x01 
    .byte 0xf0              ;cfad  f0          UNKNOWN 0xf0 
    .byte 0x0a              ;cfae  0a          UNKNOWN 0x0a 
    .byte 0x80              ;cfaf  80          UNKNOWN 0x80 
    .byte 0x10              ;cfb0  10          UNKNOWN 0x10 
    .byte 0x3c              ;cfb1  3c          UNKNOWN 0x3c '<' 
    .byte 0x2a              ;cfb2  2a          UNKNOWN 0x2a '*' 
    .byte 0xf5              ;cfb3  f5          UNKNOWN 0xf5 
    .byte 0x3c              ;cfb4  3c          UNKNOWN 0x3c '<' 
    .byte 0xcf              ;cfb5  cf          UNKNOWN 0xcf 
    .byte 0xf6              ;cfb6  f6          UNKNOWN 0xf6 
    .byte 0x80              ;cfb7  80          UNKNOWN 0x80 
    .byte 0x18              ;cfb8  18          UNKNOWN 0x18 
    .byte 0x3c              ;cfb9  3c          UNKNOWN 0x3c '<' 
    .byte 0xa8              ;cfba  a8          UNKNOWN 0xa8 
    .byte 0xf5              ;cfbb  f5          UNKNOWN 0xf5 
    .byte 0x3c              ;cfbc  3c          UNKNOWN 0x3c '<' 
    .byte 0xcf              ;cfbd  cf          UNKNOWN 0xcf 
    .byte 0xf6              ;cfbe  f6          UNKNOWN 0xf6 
    .byte 0x80              ;cfbf  80          UNKNOWN 0x80 
    .byte 0x10              ;cfc0  10          UNKNOWN 0x10 
    .byte 0x3c              ;cfc1  3c          UNKNOWN 0x3c '<' 
    .byte 0x7e              ;cfc2  7e          UNKNOWN 0x7e '~' 
    .byte 0xf5              ;cfc3  f5          UNKNOWN 0xf5 
    .byte 0x3c              ;cfc4  3c          UNKNOWN 0x3c '<' 
    .byte 0xcf              ;cfc5  cf          UNKNOWN 0xcf 
    .byte 0xf6              ;cfc6  f6          UNKNOWN 0xf6 
    .byte 0x80              ;cfc7  80          UNKNOWN 0x80 
    .byte 0x08              ;cfc8  08          UNKNOWN 0x08 
    .byte 0x3c              ;cfc9  3c          UNKNOWN 0x3c '<' 
    .byte 0x54              ;cfca  54          UNKNOWN 0x54 'T' 
    .byte 0xf5              ;cfcb  f5          UNKNOWN 0xf5 
    .byte 0x3c              ;cfcc  3c          UNKNOWN 0x3c '<' 
    .byte 0xcf              ;cfcd  cf          UNKNOWN 0xcf 
    .byte 0xf6              ;cfce  f6          UNKNOWN 0xf6 
    .byte 0x80              ;cfcf  80          UNKNOWN 0x80 
    .byte 0x00              ;cfd0  00          UNKNOWN 0x00 
    .byte 0x60              ;cfd1  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;cfd2  a5          UNKNOWN 0xa5 
    .byte 0x6c              ;cfd3  6c          UNKNOWN 0x6c 'l' 
    .byte 0x29              ;cfd4  29          UNKNOWN 0x29 ')' 
    .byte 0x0f              ;cfd5  0f          UNKNOWN 0x0f 
    .byte 0x60              ;cfd6  60          UNKNOWN 0x60 '`' 
    .byte 0xad              ;cfd7  ad          UNKNOWN 0xad 
    .byte 0x08              ;cfd8  08          UNKNOWN 0x08 
    .byte 0x01              ;cfd9  01          UNKNOWN 0x01 
    .byte 0x29              ;cfda  29          UNKNOWN 0x29 ')' 
    .byte 0x0f              ;cfdb  0f          UNKNOWN 0x0f 
    .byte 0x60              ;cfdc  60          UNKNOWN 0x60 '`' 
    .byte 0xad              ;cfdd  ad          UNKNOWN 0xad 
    .byte 0x09              ;cfde  09          UNKNOWN 0x09 
    .byte 0x01              ;cfdf  01          UNKNOWN 0x01 
    .byte 0x29              ;cfe0  29          UNKNOWN 0x29 ')' 
    .byte 0x0f              ;cfe1  0f          UNKNOWN 0x0f 
    .byte 0x60              ;cfe2  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;cfe3  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;cfe4  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;cfe5  d0          UNKNOWN 0xd0 
    .byte 0x85              ;cfe6  85          UNKNOWN 0x85 
    .byte 0xf7              ;cfe7  f7          UNKNOWN 0xf7 
    .byte 0x20              ;cfe8  20          UNKNOWN 0x20 ' ' 
    .byte 0x57              ;cfe9  57          UNKNOWN 0x57 'W' 
    .byte 0xd0              ;cfea  d0          UNKNOWN 0xd0 
    .byte 0x05              ;cfeb  05          UNKNOWN 0x05 
    .byte 0xf7              ;cfec  f7          UNKNOWN 0xf7 
    .byte 0x85              ;cfed  85          UNKNOWN 0x85 
    .byte 0xf7              ;cfee  f7          UNKNOWN 0xf7 
    .byte 0x20              ;cfef  20          UNKNOWN 0x20 ' ' 
    .byte 0x5d              ;cff0  5d          UNKNOWN 0x5d ']' 
    .byte 0xd0              ;cff1  d0          UNKNOWN 0xd0 
    .byte 0x05              ;cff2  05          UNKNOWN 0x05 
    .byte 0xf7              ;cff3  f7          UNKNOWN 0xf7 
    .byte 0x60              ;cff4  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;cff5  a5          UNKNOWN 0xa5 
    .byte 0x71              ;cff6  71          UNKNOWN 0x71 'q' 
    .byte 0xc9              ;cff7  c9          UNKNOWN 0xc9 
    .byte 0x2a              ;cff8  2a          UNKNOWN 0x2a '*' 
    .byte 0x90              ;cff9  90          UNKNOWN 0x90 
    .byte 0x04              ;cffa  04          UNKNOWN 0x04 
    .byte 0x20              ;cffb  20          UNKNOWN 0x20 ' ' 
    .byte 0xc3              ;cffc  c3          UNKNOWN 0xc3 
    .byte 0xd0              ;cffd  d0          UNKNOWN 0xd0 
    .byte 0x60              ;cffe  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;cfff  a9          UNKNOWN 0xa9 
    .byte 0x00              ;d000  00          UNKNOWN 0x00 
    .byte 0x60              ;d001  60          UNKNOWN 0x60 '`' 
    .byte 0x17              ;d002  17          UNKNOWN 0x17 
    .byte 0x08              ;d003  08          UNKNOWN 0x08 
    .byte 0xfa              ;d004  fa          UNKNOWN 0xfa 
    .byte 0xad              ;d005  ad          UNKNOWN 0xad 
    .byte 0x0b              ;d006  0b          UNKNOWN 0x0b 
    .byte 0x01              ;d007  01          UNKNOWN 0x01 
    .byte 0xc9              ;d008  c9          UNKNOWN 0xc9 
    .byte 0x2a              ;d009  2a          UNKNOWN 0x2a '*' 
    .byte 0x90              ;d00a  90          UNKNOWN 0x90 
    .byte 0xf3              ;d00b  f3          UNKNOWN 0xf3 
    .byte 0xa6              ;d00c  a6          UNKNOWN 0xa6 
    .byte 0xc8              ;d00d  c8          UNKNOWN 0xc8 
    .byte 0xbd              ;d00e  bd          UNKNOWN 0xbd 
    .byte 0x93              ;d00f  93          UNKNOWN 0x93 
    .byte 0xd0              ;d010  d0          UNKNOWN 0xd0 
    .byte 0x80              ;d011  80          UNKNOWN 0x80 
    .byte 0x1a              ;d012  1a          UNKNOWN 0x1a 
    .byte 0x01              ;d013  01          UNKNOWN 0x01 
    .byte 0x02              ;d014  02          UNKNOWN 0x02 
    .byte 0x02              ;d015  02          UNKNOWN 0x02 
    .byte 0x04              ;d016  04          UNKNOWN 0x04 
    .byte 0x05              ;d017  05          UNKNOWN 0x05 
    .byte 0x06              ;d018  06          UNKNOWN 0x06 
    .byte 0x07              ;d019  07          UNKNOWN 0x07 
    .byte 0xa2              ;d01a  a2          UNKNOWN 0xa2 
    .byte 0xff              ;d01b  ff          UNKNOWN 0xff 
    .byte 0xad              ;d01c  ad          UNKNOWN 0xad 
    .byte 0x0a              ;d01d  0a          UNKNOWN 0x0a 
    .byte 0x01              ;d01e  01          UNKNOWN 0x01 
    .byte 0xc9              ;d01f  c9          UNKNOWN 0xc9 
    .byte 0x2a              ;d020  2a          UNKNOWN 0x2a '*' 
    .byte 0x90              ;d021  90          UNKNOWN 0x90 
    .byte 0xdc              ;d022  dc          UNKNOWN 0xdc 
    .byte 0xa9              ;d023  a9          UNKNOWN 0xa9 
    .byte 0x00              ;d024  00          UNKNOWN 0x00 
    .byte 0xd7              ;d025  d7          UNKNOWN 0xd7 
    .byte 0x08              ;d026  08          UNKNOWN 0x08 
    .byte 0x01              ;d027  01          UNKNOWN 0x01 
    .byte 0x2b              ;d028  2b          UNKNOWN 0x2b '+' 
    .byte 0x97              ;d029  97          UNKNOWN 0x97 
    .byte 0x06              ;d02a  06          UNKNOWN 0x06 
    .byte 0x01              ;d02b  01          UNKNOWN 0x01 
    .byte 0x0b              ;d02c  0b          UNKNOWN 0x0b 
    .byte 0xaa              ;d02d  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;d02e  bd          UNKNOWN 0xbd 
    .byte 0xbb              ;d02f  bb          UNKNOWN 0xbb 
    .byte 0xd0              ;d030  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;d031  f0          UNKNOWN 0xf0 
    .byte 0x07              ;d032  07          UNKNOWN 0x07 
    .byte 0xc9              ;d033  c9          UNKNOWN 0xc9 
    .byte 0xff              ;d034  ff          UNKNOWN 0xff 
    .byte 0xd0              ;d035  d0          UNKNOWN 0xd0 
    .byte 0x03              ;d036  03          UNKNOWN 0x03 
    .byte 0x20              ;d037  20          UNKNOWN 0x20 ' ' 
    .byte 0xc3              ;d038  c3          UNKNOWN 0xc3 
    .byte 0xd0              ;d039  d0          UNKNOWN 0xd0 
    .byte 0x60              ;d03a  60          UNKNOWN 0x60 '`' 
    .byte 0x00              ;d03b  00          UNKNOWN 0x00 
    .byte 0xff              ;d03c  ff          UNKNOWN 0xff 
    .byte 0x05              ;d03d  05          UNKNOWN 0x05 
    .byte 0x00              ;d03e  00          UNKNOWN 0x00 
    .byte 0x09              ;d03f  09          UNKNOWN 0x09 
    .byte 0x08              ;d040  08          UNKNOWN 0x08 
    .byte 0x09              ;d041  09          UNKNOWN 0x09 
    .byte 0x08              ;d042  08          UNKNOWN 0x08 
    .byte 0xa5              ;d043  a5          UNKNOWN 0xa5 
    .byte 0xc7              ;d044  c7          UNKNOWN 0xc7 
    .byte 0xc9              ;d045  c9          UNKNOWN 0xc9 
    .byte 0x73              ;d046  73          UNKNOWN 0x73 's' 
    .byte 0xf0              ;d047  f0          UNKNOWN 0xf0 
    .byte 0x07              ;d048  07          UNKNOWN 0x07 
    .byte 0xc9              ;d049  c9          UNKNOWN 0xc9 
    .byte 0x70              ;d04a  70          UNKNOWN 0x70 'p' 
    .byte 0xf0              ;d04b  f0          UNKNOWN 0xf0 
    .byte 0x06              ;d04c  06          UNKNOWN 0x06 
    .byte 0xa9              ;d04d  a9          UNKNOWN 0xa9 
    .byte 0x08              ;d04e  08          UNKNOWN 0x08 
    .byte 0x60              ;d04f  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;d050  a9          UNKNOWN 0xa9 
    .byte 0x09              ;d051  09          UNKNOWN 0x09 

sub_d052:
    rts                     ;d052  60       

    .byte 0xa9              ;d053  a9          UNKNOWN 0xa9 
    .byte 0x08              ;d054  08          UNKNOWN 0x08 
    .byte 0x60              ;d055  60          UNKNOWN 0x60 '`' 
    .byte 0x4f              ;d056  4f          UNKNOWN 0x4f 'O' 
    .byte 0x0a              ;d057  0a          UNKNOWN 0x0a 
    .byte 0x6f              ;d058  6f          UNKNOWN 0x6f 'o' 
    .byte 0x0a              ;d059  0a          UNKNOWN 0x0a 
    .byte 0x60              ;d05a  60          UNKNOWN 0x60 '`' 
    .byte 0x57              ;d05b  57          UNKNOWN 0x57 'W' 
    .byte 0xc0              ;d05c  c0          UNKNOWN 0xc0 
    .byte 0x03              ;d05d  03          UNKNOWN 0x03 
    .byte 0x17              ;d05e  17          UNKNOWN 0x17 
    .byte 0x6d              ;d05f  6d          UNKNOWN 0x6d 'm' 
    .byte 0x04              ;d060  04          UNKNOWN 0x04 
    .byte 0x5f              ;d061  5f          UNKNOWN 0x5f '_' 
    .byte 0x0a              ;d062  0a          UNKNOWN 0x0a 
    .byte 0x7f              ;d063  7f          UNKNOWN 0x7f 
    .byte 0x0a              ;d064  0a          UNKNOWN 0x0a 
    .byte 0x60              ;d065  60          UNKNOWN 0x60 '`' 
    .byte 0xa0              ;d066  a0          UNKNOWN 0xa0 
    .byte 0x00              ;d067  00          UNKNOWN 0x00 
    .byte 0x20              ;d068  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;d069  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;d06a  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;d06b  d0          UNKNOWN 0xd0 
    .byte 0x0b              ;d06c  0b          UNKNOWN 0x0b 
    .byte 0x20              ;d06d  20          UNKNOWN 0x20 ' ' 
    .byte 0x57              ;d06e  57          UNKNOWN 0x57 'W' 
    .byte 0xd0              ;d06f  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;d070  d0          UNKNOWN 0xd0 
    .byte 0x14              ;d071  14          UNKNOWN 0x14 
    .byte 0x20              ;d072  20          UNKNOWN 0x20 ' ' 
    .byte 0x5d              ;d073  5d          UNKNOWN 0x5d ']' 
    .byte 0xd0              ;d074  d0          UNKNOWN 0xd0 

sub_d075:
    bne lab_d095            ;d075  d0 1e    
    rts                     ;d077  60       

    .byte 0xa5              ;d078  a5          UNKNOWN 0xa5 
    .byte 0x6e              ;d079  6e          UNKNOWN 0x6e 'n' 
    .byte 0xae              ;d07a  ae          UNKNOWN 0xae 
    .byte 0x06              ;d07b  06          UNKNOWN 0x06 
    .byte 0x01              ;d07c  01          UNKNOWN 0x01 
    .byte 0xe0              ;d07d  e0          UNKNOWN 0xe0 
    .byte 0xff              ;d07e  ff          UNKNOWN 0xff 
    .byte 0xf0              ;d07f  f0          UNKNOWN 0xf0 
    .byte 0x08              ;d080  08          UNKNOWN 0x08 
    .byte 0xcd              ;d081  cd          UNKNOWN 0xcd 
    .byte 0x06              ;d082  06          UNKNOWN 0x06 
    .byte 0x01              ;d083  01          UNKNOWN 0x01 
    .byte 0xb0              ;d084  b0          UNKNOWN 0xb0 
    .byte 0x03              ;d085  03          UNKNOWN 0x03 
    .byte 0xad              ;d086  ad          UNKNOWN 0xad 
    .byte 0x06              ;d087  06          UNKNOWN 0x06 
    .byte 0x01              ;d088  01          UNKNOWN 0x01 
    .byte 0xae              ;d089  ae          UNKNOWN 0xae 
    .byte 0x07              ;d08a  07          UNKNOWN 0x07 
    .byte 0x01              ;d08b  01          UNKNOWN 0x01 
    .byte 0xe0              ;d08c  e0          UNKNOWN 0xe0 
    .byte 0xff              ;d08d  ff          UNKNOWN 0xff 
    .byte 0xf0              ;d08e  f0          UNKNOWN 0xf0 
    .byte 0x08              ;d08f  08          UNKNOWN 0x08 
    .byte 0xcd              ;d090  cd          UNKNOWN 0xcd 
    .byte 0x07              ;d091  07          UNKNOWN 0x07 
    .byte 0x01              ;d092  01          UNKNOWN 0x01 
    .byte 0xb0              ;d093  b0          UNKNOWN 0xb0 
    .byte 0x03              ;d094  03          UNKNOWN 0x03 

lab_d095:
    lda mem_0107            ;d095  ad 07 01 
    tax                     ;d098  aa       
    ldx #0xff               ;d099  a2 ff    
    rts                     ;d09b  60       

    .byte 0x67              ;d09c  67          UNKNOWN 0x67 'g' 
    .byte 0x3f              ;d09d  3f          UNKNOWN 0x3f '?' 
    .byte 0x10              ;d09e  10          UNKNOWN 0x10 
    .byte 0x77              ;d09f  77          UNKNOWN 0x77 'w' 
    .byte 0x3d              ;d0a0  3d          UNKNOWN 0x3d '=' 
    .byte 0x0d              ;d0a1  0d          UNKNOWN 0x0d 
    .byte 0xad              ;d0a2  ad          UNKNOWN 0xad 
    .byte 0x1a              ;d0a3  1a          UNKNOWN 0x1a 
    .byte 0x01              ;d0a4  01          UNKNOWN 0x01 
    .byte 0xc9              ;d0a5  c9          UNKNOWN 0xc9 
    .byte 0xff              ;d0a6  ff          UNKNOWN 0xff 
    .byte 0xf0              ;d0a7  f0          UNKNOWN 0xf0 
    .byte 0x06              ;d0a8  06          UNKNOWN 0x06 
    .byte 0x3a              ;d0a9  3a          UNKNOWN 0x3a ':' 
    .byte 0x8d              ;d0aa  8d          UNKNOWN 0x8d 
    .byte 0x1a              ;d0ab  1a          UNKNOWN 0x1a 
    .byte 0x01              ;d0ac  01          UNKNOWN 0x01 
    .byte 0x7f              ;d0ad  7f          UNKNOWN 0x7f 
    .byte 0x3d              ;d0ae  3d          UNKNOWN 0x3d '=' 
    .byte 0x60              ;d0af  60          UNKNOWN 0x60 '`' 
    .byte 0xe7              ;d0b0  e7          UNKNOWN 0xe7 
    .byte 0x50              ;d0b1  50          UNKNOWN 0x50 'P' 
    .byte 0x0b              ;d0b2  0b          UNKNOWN 0x0b 
    .byte 0x77              ;d0b3  77          UNKNOWN 0x77 'w' 
    .byte 0x39              ;d0b4  39          UNKNOWN 0x39 '9' 
    .byte 0x09              ;d0b5  09          UNKNOWN 0x09 
    .byte 0x17              ;d0b6  17          UNKNOWN 0x17 
    .byte 0x6d              ;d0b7  6d          UNKNOWN 0x6d 'm' 
    .byte 0x05              ;d0b8  05          UNKNOWN 0x05 
    .byte 0xa7              ;d0b9  a7          UNKNOWN 0xa7 
    .byte 0x50              ;d0ba  50          UNKNOWN 0x50 'P' 
    .byte 0x03              ;d0bb  03          UNKNOWN 0x03 

lab_d0bc:
    cli                     ;d0bc  58       
    wit                     ;d0bd  c2       
    rts                     ;d0be  60       

    .byte 0x20              ;d0bf  20          UNKNOWN 0x20 ' ' 
    .byte 0xe6              ;d0c0  e6          UNKNOWN 0xe6 
    .byte 0xd0              ;d0c1  d0          UNKNOWN 0xd0 
    .byte 0xc9              ;d0c2  c9          UNKNOWN 0xc9 
    .byte 0xff              ;d0c3  ff          UNKNOWN 0xff 
    .byte 0xf0              ;d0c4  f0          UNKNOWN 0xf0 
    .byte 0xf6              ;d0c5  f6          UNKNOWN 0xf6 
    .byte 0xa5              ;d0c6  a5          UNKNOWN 0xa5 
    .byte 0xc0              ;d0c7  c0          UNKNOWN 0xc0 
    .byte 0xd0              ;d0c8  d0          UNKNOWN 0xd0 
    .byte 0xf2              ;d0c9  f2          UNKNOWN 0xf2 
    .byte 0xa5              ;d0ca  a5          UNKNOWN 0xa5 
    .byte 0xc1              ;d0cb  c1          UNKNOWN 0xc1 
    .byte 0xd0              ;d0cc  d0          UNKNOWN 0xd0 
    .byte 0xee              ;d0cd  ee          UNKNOWN 0xee 
    .byte 0x27              ;d0ce  27          UNKNOWN 0x27 ''' 
    .byte 0xbf              ;d0cf  bf          UNKNOWN 0xbf 
    .byte 0xeb              ;d0d0  eb          UNKNOWN 0xeb 
    .byte 0xad              ;d0d1  ad          UNKNOWN 0xad 
    .byte 0x1a              ;d0d2  1a          UNKNOWN 0x1a 
    .byte 0x01              ;d0d3  01          UNKNOWN 0x01 
    .byte 0xc9              ;d0d4  c9          UNKNOWN 0xc9 
    .byte 0xff              ;d0d5  ff          UNKNOWN 0xff 

sub_d0d6:
    bne lab_d0bc            ;d0d6  d0 e4    
    lda mem_00c6            ;d0d8  a5 c6    
    cmp #0x03               ;d0da  c9 03    
    bne lab_d0bc            ;d0dc  d0 de    
    sei                     ;d0de  78       
    jsr sub_d1bb            ;d0df  20 bb d1 
    ldm #0x00,ICON1         ;d0e2  3c 00 3e 
    ldm #0x00,ICON2         ;d0e5  3c 00 3f 
    ldm #0x00,IREQ1         ;d0e8  3c 00 3c 
    ldm #0x00,IREQ2         ;d0eb  3c 00 3d 
    seb 3,ICON2             ;d0ee  6f 3f    
    seb 4,ICON2             ;d0f0  8f 3f    
    cli                     ;d0f2  58       
    nop                     ;d0f3  ea       
    stp                     ;d0f4  42       

    .byte 0xea              ;d0f5  ea          UNKNOWN 0xea 
    .byte 0x60              ;d0f6  60          UNKNOWN 0x60 '`' 
    .byte 0x48              ;d0f7  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;d0f8  8a          UNKNOWN 0x8a 
    .byte 0x48              ;d0f9  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;d0fa  98          UNKNOWN 0x98 
    .byte 0x48              ;d0fb  48          UNKNOWN 0x48 'H' 
    .byte 0x7f              ;d0fc  7f          UNKNOWN 0x7f 
    .byte 0x3f              ;d0fd  3f          UNKNOWN 0x3f '?' 
    .byte 0x20              ;d0fe  20          UNKNOWN 0x20 ' ' 
    .byte 0x11              ;d0ff  11          UNKNOWN 0x11 
    .byte 0xda              ;d100  da          UNKNOWN 0xda 
    .byte 0x3c              ;d101  3c          UNKNOWN 0x3c '<' 
    .byte 0x04              ;d102  04          UNKNOWN 0x04 
    .byte 0xa2              ;d103  a2          UNKNOWN 0xa2 
    .byte 0xef              ;d104  ef          UNKNOWN 0xef 
    .byte 0x95              ;d105  95          UNKNOWN 0x95 
    .byte 0xcf              ;d106  cf          UNKNOWN 0xcf 
    .byte 0x3f              ;d107  3f          UNKNOWN 0x3f '?' 
    .byte 0xaf              ;d108  af          UNKNOWN 0xaf 
    .byte 0x3e              ;d109  3e          UNKNOWN 0x3e '>' 
    .byte 0x68              ;d10a  68          UNKNOWN 0x68 'h' 
    .byte 0xa8              ;d10b  a8          UNKNOWN 0xa8 
    .byte 0x68              ;d10c  68          UNKNOWN 0x68 'h' 
    .byte 0xaa              ;d10d  aa          UNKNOWN 0xaa 
    .byte 0x68              ;d10e  68          UNKNOWN 0x68 'h' 
    .byte 0x40              ;d10f  40          UNKNOWN 0x40 '@' 
    .byte 0x48              ;d110  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;d111  8a          UNKNOWN 0x8a 
    .byte 0x48              ;d112  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;d113  98          UNKNOWN 0x98 
    .byte 0x48              ;d114  48          UNKNOWN 0x48 'H' 
    .byte 0x3c              ;d115  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;d116  00          UNKNOWN 0x00 
    .byte 0x3c              ;d117  3c          UNKNOWN 0x3c '<' 
    .byte 0x3c              ;d118  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;d119  00          UNKNOWN 0x00 
    .byte 0x3d              ;d11a  3d          UNKNOWN 0x3d '=' 
    .byte 0xcf              ;d11b  cf          UNKNOWN 0xcf 

sub_d11c:
    clb 1,mem_007f          ;d11c  3f 7f    
    clb 1,mem_009f          ;d11e  3f 9f    
    clb 1,mem_00a2          ;d120  3f a2    
    ldx mem_a99a,y          ;d122  be 9a a9 
    .byte 0x04              ;d125  04       Illegal instruction

    .byte 0x4c              ;d126  4c          UNKNOWN 0x4c 'L' 
    .byte 0x17              ;d127  17          UNKNOWN 0x17 
    .byte 0xcd              ;d128  cd          UNKNOWN 0xcd 
    .byte 0x68              ;d129  68          UNKNOWN 0x68 'h' 
    .byte 0xa8              ;d12a  a8          UNKNOWN 0xa8 
    .byte 0x68              ;d12b  68          UNKNOWN 0x68 'h' 
    .byte 0xaa              ;d12c  aa          UNKNOWN 0xaa 
    .byte 0x68              ;d12d  68          UNKNOWN 0x68 'h' 
    .byte 0x40              ;d12e  40          UNKNOWN 0x40 '@' 
    .byte 0xd7              ;d12f  d7          UNKNOWN 0xd7 
    .byte 0x50              ;d130  50          UNKNOWN 0x50 'P' 
    .byte 0x08              ;d131  08          UNKNOWN 0x08 
    .byte 0x57              ;d132  57          UNKNOWN 0x57 'W' 
    .byte 0x08              ;d133  08          UNKNOWN 0x08 
    .byte 0x05              ;d134  05          UNKNOWN 0x05 
    .byte 0x37              ;d135  37          UNKNOWN 0x37 '7' 
    .byte 0x0e              ;d136  0e          UNKNOWN 0x0e 
    .byte 0x02              ;d137  02          UNKNOWN 0x02 
    .byte 0xef              ;d138  ef          UNKNOWN 0xef 
    .byte 0x08              ;d139  08          UNKNOWN 0x08 
    .byte 0x40              ;d13a  40          UNKNOWN 0x40 '@' 
    .byte 0xa5              ;d13b  a5          UNKNOWN 0xa5 
    .byte 0x39              ;d13c  39          UNKNOWN 0x39 '9' 
    .byte 0x29              ;d13d  29          UNKNOWN 0x29 ')' 
    .byte 0xe7              ;d13e  e7          UNKNOWN 0xe7 
    .byte 0x85              ;d13f  85          UNKNOWN 0x85 
    .byte 0x39              ;d140  39          UNKNOWN 0x39 '9' 
    .byte 0x18              ;d141  18          UNKNOWN 0x18 
    .byte 0x60              ;d142  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d143  a5          UNKNOWN 0xa5 
    .byte 0x39              ;d144  39          UNKNOWN 0x39 '9' 
    .byte 0x29              ;d145  29          UNKNOWN 0x29 ')' 
    .byte 0xef              ;d146  ef          UNKNOWN 0xef 
    .byte 0x09              ;d147  09          UNKNOWN 0x09 
    .byte 0x08              ;d148  08          UNKNOWN 0x08 
    .byte 0x85              ;d149  85          UNKNOWN 0x85 
    .byte 0x39              ;d14a  39          UNKNOWN 0x39 '9' 
    .byte 0x38              ;d14b  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;d14c  60          UNKNOWN 0x60 '`' 
    .byte 0x97              ;d14d  97          UNKNOWN 0x97 
    .byte 0xbf              ;d14e  bf          UNKNOWN 0xbf 
    .byte 0x01              ;d14f  01          UNKNOWN 0x01 
    .byte 0x60              ;d150  60          UNKNOWN 0x60 '`' 
    .byte 0x37              ;d151  37          UNKNOWN 0x37 '7' 
    .byte 0x0a              ;d152  0a          UNKNOWN 0x0a 
    .byte 0x03              ;d153  03          UNKNOWN 0x03 
    .byte 0xe7              ;d154  e7          UNKNOWN 0xe7 
    .byte 0x50              ;d155  50          UNKNOWN 0x50 'P' 
    .byte 0x09              ;d156  09          UNKNOWN 0x09 
    .byte 0x9f              ;d157  9f          UNKNOWN 0x9f 
    .byte 0x44              ;d158  44          UNKNOWN 0x44 'D' 
    .byte 0xbf              ;d159  bf          UNKNOWN 0xbf 
    .byte 0x44              ;d15a  44          UNKNOWN 0x44 'D' 
    .byte 0xdf              ;d15b  df          UNKNOWN 0xdf 
    .byte 0x44              ;d15c  44          UNKNOWN 0x44 'D' 
    .byte 0x4c              ;d15d  4c          UNKNOWN 0x4c 'L' 
    .byte 0x06              ;d15e  06          UNKNOWN 0x06 
    .byte 0xd2              ;d15f  d2          UNKNOWN 0xd2 
    .byte 0x77              ;d160  77          UNKNOWN 0x77 'w' 
    .byte 0xbf              ;d161  bf          UNKNOWN 0xbf 
    .byte 0x08              ;d162  08          UNKNOWN 0x08 
    .byte 0x20              ;d163  20          UNKNOWN 0x20 ' ' 
    .byte 0xe2              ;d164  e2          UNKNOWN 0xe2 
    .byte 0xd4              ;d165  d4          UNKNOWN 0xd4 
    .byte 0x90              ;d166  90          UNKNOWN 0x90 
    .byte 0x03              ;d167  03          UNKNOWN 0x03 
    .byte 0x4c              ;d168  4c          UNKNOWN 0x4c 'L' 
    .byte 0x06              ;d169  06          UNKNOWN 0x06 
    .byte 0xd2              ;d16a  d2          UNKNOWN 0xd2 
    .byte 0xf7              ;d16b  f7          UNKNOWN 0xf7 
    .byte 0x06              ;d16c  06          UNKNOWN 0x06 
    .byte 0x04              ;d16d  04          UNKNOWN 0x04 
    .byte 0x9f              ;d16e  9f          UNKNOWN 0x9f 
    .byte 0x44              ;d16f  44          UNKNOWN 0x44 'D' 
    .byte 0x80              ;d170  80          UNKNOWN 0x80 
    .byte 0x02              ;d171  02          UNKNOWN 0x02 
    .byte 0x8f              ;d172  8f          UNKNOWN 0x8f 
    .byte 0x44              ;d173  44          UNKNOWN 0x44 'D' 
    .byte 0xd7              ;d174  d7          UNKNOWN 0xd7 
    .byte 0x06              ;d175  06          UNKNOWN 0x06 
    .byte 0x04              ;d176  04          UNKNOWN 0x04 

lab_d177:
    clb 5,mem_0044          ;d177  bf 44    
    bra lab_d17d            ;d179  80 02    

    .byte 0xaf              ;d17b  af          UNKNOWN 0xaf 
    .byte 0x44              ;d17c  44          UNKNOWN 0x44 'D' 

lab_d17d:
    bbc 5,P3,lab_d184       ;d17d  b7 06 04 
    clb 6,mem_0044          ;d180  df 44    
    bra lab_d186            ;d182  80 02    

lab_d184:
    seb 6,mem_0044          ;d184  cf 44    

lab_d186:
    lda mem_00cd            ;d186  a5 cd    
    cmp #0x01               ;d188  c9 01    
    bne lab_d197            ;d18a  d0 0b    
    bbc 3,mem_00bf,lab_d197 ;d18c  77 bf 08 
    bbc 7,mem_0050,lab_d197 ;d18f  f7 50 05 
    bbs 0,mem_0044,lab_d1a3 ;d192  07 44 0e 
    bra lab_d1a7            ;d195  80 10    

lab_d197:
    bbs 7,mem_006c,lab_d1a9 ;d197  e7 6c 0f 
    bbs 5,mem_006c,lab_d1a9 ;d19a  a7 6c 0c 
    bbs 7,mem_0050,lab_d1a7 ;d19d  e7 50 07 
    bbs 6,mem_0050,lab_d1a7 ;d1a0  c7 50 04 

lab_d1a3:
    clb 0,mem_0044          ;d1a3  1f 44    
    bra lab_d1a9            ;d1a5  80 02    

lab_d1a7:
    seb 0,mem_0044          ;d1a7  0f 44    

lab_d1a9:
    bbc 5,mem_006c,sub_d1bb ;d1a9  b7 6c 0f 
    bbs 1,mem_0044,lab_d1b5 ;d1ac  27 44 06 

lab_d1af:
    seb 1,mem_0044          ;d1af  2f 44    
    clb 0,mem_0044          ;d1b1  1f 44    
    bra lab_d1d6            ;d1b3  80 21    

lab_d1b5:
    clb 1,mem_0044          ;d1b5  3f 44    
    seb 0,mem_0044          ;d1b7  0f 44    
    bra lab_d1d6            ;d1b9  80 1b    

sub_d1bb:
    bbs 7,mem_006c,lab_d1c2 ;d1bb  e7 6c 04 
    clb 1,mem_0044          ;d1be  3f 44    
    bra lab_d1d6            ;d1c0  80 14    

lab_d1c2:
    seb 0,mem_0044          ;d1c2  0f 44    
    bbs 6,mem_006c,lab_d1ca ;d1c4  c7 6c 03 
    bbs 1,mem_0044,lab_d1d4 ;d1c7  27 44 0a 

lab_d1ca:
    bbc 0,mem_00c4,lab_d1d0 ;d1ca  17 c4 03 

sub_d1cd:
    bbs 7,mem_00c4,lab_d1d4 ;d1cd  e7 c4 04 

lab_d1d0:
    seb 1,mem_0044          ;d1d0  2f 44    
    bra lab_d1d6            ;d1d2  80 02    

lab_d1d4:
    clb 1,mem_0044          ;d1d4  3f 44    

lab_d1d6:
    jsr sub_d497            ;d1d6  20 97 d4 
    cmp #0x01               ;d1d9  c9 01    
    bne lab_d1ef            ;d1db  d0 12    
    jsr sub_d293            ;d1dd  20 93 d2 
    lda mem_00cd            ;d1e0  a5 cd    
    cmp #0x02               ;d1e2  c9 02    
    bne lab_d1ee            ;d1e4  d0 08    
    bbc 3,mem_00bf,lab_d1ee ;d1e6  77 bf 05 
    bbc 7,mem_0050,lab_d1ee ;d1e9  f7 50 02 
    seb 3,mem_0041          ;d1ec  6f 41    

lab_d1ee:
    rts                     ;d1ee  60       

lab_d1ef:
    cmp #0x02               ;d1ef  c9 02    
    bne lab_d1f7            ;d1f1  d0 04    
    jsr sub_d2f7            ;d1f3  20 f7 d2 
    rts                     ;d1f6  60       

lab_d1f7:
    cmp #0x03               ;d1f7  c9 03    
    bne lab_d1ff            ;d1f9  d0 04    
    jsr sub_d33f            ;d1fb  20 3f d3 
    rts                     ;d1fe  60       

lab_d1ff:
    cmp #0x86               ;d1ff  c9 86    
    bne lab_d207            ;d201  d0 04    
    jsr sub_d3be            ;d203  20 be d3 
    rts                     ;d206  60       

lab_d207:
    cmp #0x05               ;d207  c9 05    
    bne lab_d20f            ;d209  d0 04    
    jsr sub_d3ff            ;d20b  20 ff d3 
    rts                     ;d20e  60       

lab_d20f:
    jsr sub_d576            ;d20f  20 76 d5 
    rts                     ;d212  60       

    .byte 0xa7              ;d213  a7          UNKNOWN 0xa7 
    .byte 0xbf              ;d214  bf          UNKNOWN 0xbf 
    .byte 0x04              ;d215  04          UNKNOWN 0x04 
    .byte 0x20              ;d216  20          UNKNOWN 0x20 ' ' 
    .byte 0x76              ;d217  76          UNKNOWN 0x76 'v' 
    .byte 0xd5              ;d218  d5          UNKNOWN 0xd5 
    .byte 0x60              ;d219  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d21a  a5          UNKNOWN 0xa5 
    .byte 0x9d              ;d21b  9d          UNKNOWN 0x9d 
    .byte 0xa2              ;d21c  a2          UNKNOWN 0xa2 
    .byte 0x02              ;d21d  02          UNKNOWN 0x02 
    .byte 0xc9              ;d21e  c9          UNKNOWN 0xc9 
    .byte 0x14              ;d21f  14          UNKNOWN 0x14 
    .byte 0xb0              ;d220  b0          UNKNOWN 0xb0 
    .byte 0x0a              ;d221  0a          UNKNOWN 0x0a 
    .byte 0xa2              ;d222  a2          UNKNOWN 0xa2 
    .byte 0x01              ;d223  01          UNKNOWN 0x01 
    .byte 0xc9              ;d224  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;d225  0a          UNKNOWN 0x0a 
    .byte 0xb0              ;d226  b0          UNKNOWN 0xb0 
    .byte 0x04              ;d227  04          UNKNOWN 0x04 
    .byte 0xa9              ;d228  a9          UNKNOWN 0xa9 
    .byte 0x00              ;d229  00          UNKNOWN 0x00 
    .byte 0x80              ;d22a  80          UNKNOWN 0x80 
    .byte 0x04              ;d22b  04          UNKNOWN 0x04 
    .byte 0x8a              ;d22c  8a          UNKNOWN 0x8a 
    .byte 0x20              ;d22d  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d22e  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d22f  d4          UNKNOWN 0xd4 
    .byte 0x85              ;d230  85          UNKNOWN 0x85 
    .byte 0x40              ;d231  40          UNKNOWN 0x40 '@' 
    .byte 0xa5              ;d232  a5          UNKNOWN 0xa5 
    .byte 0x9d              ;d233  9d          UNKNOWN 0x9d 
    .byte 0xaa              ;d234  aa          UNKNOWN 0xaa 
    .byte 0xc9              ;d235  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;d236  0a          UNKNOWN 0x0a 
    .byte 0x90              ;d237  90          UNKNOWN 0x90 
    .byte 0x0a              ;d238  0a          UNKNOWN 0x0a 
    .byte 0xe9              ;d239  e9          UNKNOWN 0xe9 
    .byte 0x0a              ;d23a  0a          UNKNOWN 0x0a 
    .byte 0xaa              ;d23b  aa          UNKNOWN 0xaa 
    .byte 0xc9              ;d23c  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;d23d  0a          UNKNOWN 0x0a 
    .byte 0x90              ;d23e  90          UNKNOWN 0x90 
    .byte 0x03              ;d23f  03          UNKNOWN 0x03 
    .byte 0xe9              ;d240  e9          UNKNOWN 0xe9 
    .byte 0x0a              ;d241  0a          UNKNOWN 0x0a 
    .byte 0xaa              ;d242  aa          UNKNOWN 0xaa 
    .byte 0x8a              ;d243  8a          UNKNOWN 0x8a 
    .byte 0x20              ;d244  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d245  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d246  d4          UNKNOWN 0xd4 
    .byte 0x67              ;d247  67          UNKNOWN 0x67 'g' 
    .byte 0x41              ;d248  41          UNKNOWN 0x41 'A' 
    .byte 0x06              ;d249  06          UNKNOWN 0x06 
    .byte 0x85              ;d24a  85          UNKNOWN 0x85 
    .byte 0x41              ;d24b  41          UNKNOWN 0x41 'A' 
    .byte 0x6f              ;d24c  6f          UNKNOWN 0x6f 'o' 
    .byte 0x41              ;d24d  41          UNKNOWN 0x41 'A' 
    .byte 0x80              ;d24e  80          UNKNOWN 0x80 
    .byte 0x02              ;d24f  02          UNKNOWN 0x02 
    .byte 0x85              ;d250  85          UNKNOWN 0x85 
    .byte 0x41              ;d251  41          UNKNOWN 0x41 'A' 
    .byte 0xa5              ;d252  a5          UNKNOWN 0xa5 
    .byte 0x9e              ;d253  9e          UNKNOWN 0x9e 
    .byte 0xa2              ;d254  a2          UNKNOWN 0xa2 
    .byte 0x00              ;d255  00          UNKNOWN 0x00 
    .byte 0xc9              ;d256  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;d257  0a          UNKNOWN 0x0a 
    .byte 0x90              ;d258  90          UNKNOWN 0x90 
    .byte 0x05              ;d259  05          UNKNOWN 0x05 
    .byte 0xe9              ;d25a  e9          UNKNOWN 0xe9 
    .byte 0x0a              ;d25b  0a          UNKNOWN 0x0a 
    .byte 0xe8              ;d25c  e8          UNKNOWN 0xe8 
    .byte 0x80              ;d25d  80          UNKNOWN 0x80 
    .byte 0xf7              ;d25e  f7          UNKNOWN 0xf7 
    .byte 0x8a              ;d25f  8a          UNKNOWN 0x8a 
    .byte 0x20              ;d260  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d261  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d262  d4          UNKNOWN 0xd4 
    .byte 0x85              ;d263  85          UNKNOWN 0x85 
    .byte 0x42              ;d264  42          UNKNOWN 0x42 'B' 
    .byte 0xa5              ;d265  a5          UNKNOWN 0xa5 
    .byte 0x9e              ;d266  9e          UNKNOWN 0x9e 
    .byte 0xaa              ;d267  aa          UNKNOWN 0xaa 
    .byte 0xc9              ;d268  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;d269  0a          UNKNOWN 0x0a 
    .byte 0x90              ;d26a  90          UNKNOWN 0x90 
    .byte 0x04              ;d26b  04          UNKNOWN 0x04 
    .byte 0xe9              ;d26c  e9          UNKNOWN 0xe9 
    .byte 0x0a              ;d26d  0a          UNKNOWN 0x0a 
    .byte 0x80              ;d26e  80          UNKNOWN 0x80 
    .byte 0xf7              ;d26f  f7          UNKNOWN 0xf7 
    .byte 0x8a              ;d270  8a          UNKNOWN 0x8a 
    .byte 0x20              ;d271  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d272  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d273  d4          UNKNOWN 0xd4 
    .byte 0x85              ;d274  85          UNKNOWN 0x85 
    .byte 0x43              ;d275  43          UNKNOWN 0x43 'C' 
    .byte 0x60              ;d276  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;d277  20          UNKNOWN 0x20 ' ' 
    .byte 0xe6              ;d278  e6          UNKNOWN 0xe6 
    .byte 0xd0              ;d279  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;d27a  f0          UNKNOWN 0xf0 
    .byte 0x06              ;d27b  06          UNKNOWN 0x06 
    .byte 0xc7              ;d27c  c7          UNKNOWN 0xc7 
    .byte 0x50              ;d27d  50          UNKNOWN 0x50 'P' 
    .byte 0x0e              ;d27e  0e          UNKNOWN 0x0e 
    .byte 0x07              ;d27f  07          UNKNOWN 0x07 
    .byte 0x6d              ;d280  6d          UNKNOWN 0x6d 'm' 
    .byte 0x0b              ;d281  0b          UNKNOWN 0x0b 
    .byte 0x07              ;d282  07          UNKNOWN 0x07 
    .byte 0x6d              ;d283  6d          UNKNOWN 0x6d 'm' 
    .byte 0x04              ;d284  04          UNKNOWN 0x04 
    .byte 0x20              ;d285  20          UNKNOWN 0x20 ' ' 
    .byte 0x81              ;d286  81          UNKNOWN 0x81 
    .byte 0xd5              ;d287  d5          UNKNOWN 0xd5 
    .byte 0x60              ;d288  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;d289  20          UNKNOWN 0x20 ' ' 
    .byte 0x76              ;d28a  76          UNKNOWN 0x76 'v' 
    .byte 0xd5              ;d28b  d5          UNKNOWN 0xd5 
    .byte 0x60              ;d28c  60          UNKNOWN 0x60 '`' 
    .byte 0xc9              ;d28d  c9          UNKNOWN 0xc9 
    .byte 0xff              ;d28e  ff          UNKNOWN 0xff 
    .byte 0xf0              ;d28f  f0          UNKNOWN 0xf0 
    .byte 0x2d              ;d290  2d          UNKNOWN 0x2d '-' 
    .byte 0xf7              ;d291  f7          UNKNOWN 0xf7 
    .byte 0x6c              ;d292  6c          UNKNOWN 0x6c 'l' 

sub_d293:
    php                     ;d293  08       
    lda mem_006e            ;d294  a5 6e    
    cmp #0x64               ;d296  c9 64    
    bcc lab_d29c            ;d298  90 02    
    lda #0x64               ;d29a  a9 64    

lab_d29c:
    tax                     ;d29c  aa       
    lda mem_d5ad,x          ;d29d  bd ad d5 
    bbc 7,mem_006c,lab_d2bb ;d2a0  f7 6c 18 
    cmp #0x5f               ;d2a3  c9 5f    
    bcc lab_d2bb            ;d2a5  90 14    
    lda #0x5f               ;d2a7  a9 5f    
    bbc 0,mem_00c4,lab_d2bb ;d2a9  17 c4 0f 
    lda #0x63               ;d2ac  a9 63    
    bbs 6,mem_00c4,lab_d2bb ;d2ae  c7 c4 0a 
    lda #0x64               ;d2b1  a9 64    
    bbs 7,mem_00c4,lab_d2bb ;d2b3  e7 c4 05 
    bbs 5,mem_00c4,lab_d2bb ;d2b6  a7 c4 02 
    lda #0x5f               ;d2b9  a9 5f    

lab_d2bb:
    jsr 0xd36e              ;d2bb  20 6e d3 
    rts                     ;d2be  60       

    .byte 0xa5              ;d2bf  a5          UNKNOWN 0xa5 
    .byte 0x6e              ;d2c0  6e          UNKNOWN 0x6e 'n' 
    .byte 0xc7              ;d2c1  c7          UNKNOWN 0xc7 
    .byte 0xc0              ;d2c2  c0          UNKNOWN 0xc0 
    .byte 0x1e              ;d2c3  1e          UNKNOWN 0x1e 
    .byte 0xad              ;d2c4  ad          UNKNOWN 0xad 
    .byte 0x06              ;d2c5  06          UNKNOWN 0x06 
    .byte 0x01              ;d2c6  01          UNKNOWN 0x01 
    .byte 0xa7              ;d2c7  a7          UNKNOWN 0xa7 
    .byte 0xc0              ;d2c8  c0          UNKNOWN 0xc0 
    .byte 0x18              ;d2c9  18          UNKNOWN 0x18 
    .byte 0xad              ;d2ca  ad          UNKNOWN 0xad 
    .byte 0x07              ;d2cb  07          UNKNOWN 0x07 
    .byte 0x01              ;d2cc  01          UNKNOWN 0x01 
    .byte 0x87              ;d2cd  87          UNKNOWN 0x87 
    .byte 0xc0              ;d2ce  c0          UNKNOWN 0xc0 
    .byte 0x12              ;d2cf  12          UNKNOWN 0x12 
    .byte 0x20              ;d2d0  20          UNKNOWN 0x20 ' ' 
    .byte 0xe6              ;d2d1  e6          UNKNOWN 0xe6 
    .byte 0xd0              ;d2d2  d0          UNKNOWN 0xd0 
    .byte 0xd0              ;d2d3  d0          UNKNOWN 0xd0 
    .byte 0x0d              ;d2d4  0d          UNKNOWN 0x0d 
    .byte 0x07              ;d2d5  07          UNKNOWN 0x07 
    .byte 0x6d              ;d2d6  6d          UNKNOWN 0x6d 'm' 
    .byte 0x05              ;d2d7  05          UNKNOWN 0x05 
    .byte 0x20              ;d2d8  20          UNKNOWN 0x20 ' ' 
    .byte 0x81              ;d2d9  81          UNKNOWN 0x81 
    .byte 0xd5              ;d2da  d5          UNKNOWN 0xd5 
    .byte 0x80              ;d2db  80          UNKNOWN 0x80 
    .byte 0x0c              ;d2dc  0c          UNKNOWN 0x0c 
    .byte 0x20              ;d2dd  20          UNKNOWN 0x20 ' ' 
    .byte 0x76              ;d2de  76          UNKNOWN 0x76 'v' 
    .byte 0xd5              ;d2df  d5          UNKNOWN 0xd5 
    .byte 0x80              ;d2e0  80          UNKNOWN 0x80 
    .byte 0x07              ;d2e1  07          UNKNOWN 0x07 
    .byte 0xc9              ;d2e2  c9          UNKNOWN 0xc9 
    .byte 0xff              ;d2e3  ff          UNKNOWN 0xff 
    .byte 0xf0              ;d2e4  f0          UNKNOWN 0xf0 
    .byte 0x07              ;d2e5  07          UNKNOWN 0x07 
    .byte 0x20              ;d2e6  20          UNKNOWN 0x20 ' ' 
    .byte 0x6e              ;d2e7  6e          UNKNOWN 0x6e 'n' 
    .byte 0xd3              ;d2e8  d3          UNKNOWN 0xd3 
    .byte 0xa5              ;d2e9  a5          UNKNOWN 0xa5 
    .byte 0xc0              ;d2ea  c0          UNKNOWN 0xc0 
    .byte 0x85              ;d2eb  85          UNKNOWN 0x85 
    .byte 0x40              ;d2ec  40          UNKNOWN 0x40 '@' 
    .byte 0x60              ;d2ed  60          UNKNOWN 0x60 '`' 
    .byte 0x48              ;d2ee  48          UNKNOWN 0x48 'H' 
    .byte 0xc9              ;d2ef  c9          UNKNOWN 0xc9 
    .byte 0x64              ;d2f0  64          UNKNOWN 0x64 'd' 
    .byte 0x90              ;d2f1  90          UNKNOWN 0x90 
    .byte 0x11              ;d2f2  11          UNKNOWN 0x11 
    .byte 0xc9              ;d2f3  c9          UNKNOWN 0xc9 
    .byte 0xc8              ;d2f4  c8          UNKNOWN 0xc8 
    .byte 0x90              ;d2f5  90          UNKNOWN 0x90 
    .byte 0x04              ;d2f6  04          UNKNOWN 0x04 

sub_d2f7:
    lda #0x02               ;d2f7  a9 02    
    bra lab_d2fd            ;d2f9  80 02    

    .byte 0xa9              ;d2fb  a9          UNKNOWN 0xa9 
    .byte 0x01              ;d2fc  01          UNKNOWN 0x01 

lab_d2fd:
    jsr sub_d441            ;d2fd  20 41 d4 
    sta mem_0041            ;d300  85 41    
    bra lab_d308            ;d302  80 04    

    .byte 0xa9              ;d304  a9          UNKNOWN 0xa9 
    .byte 0x00              ;d305  00          UNKNOWN 0x00 
    .byte 0x85              ;d306  85          UNKNOWN 0x85 
    .byte 0x41              ;d307  41          UNKNOWN 0x41 'A' 

lab_d308:
    pla                     ;d308  68       
    ldy #0x00               ;d309  a0 00    

lab_d30b:
    cmp #0x0a               ;d30b  c9 0a    
    bcc lab_d314            ;d30d  90 05    
    sbc #0x0a               ;d30f  e9 0a    
    iny                     ;d311  c8       
    bra lab_d30b            ;d312  80 f7    

lab_d314:
    pha                     ;d314  48       
    tya                     ;d315  98       
    cmp #0x14               ;d316  c9 14    
    bcs lab_d324            ;d318  b0 0a    
    cmp #0x0a               ;d31a  c9 0a    
    bcs lab_d328            ;d31c  b0 0a    
    cmp #0x00               ;d31e  c9 00    
    bne lab_d32c            ;d320  d0 0a    
    bra lab_d32f            ;d322  80 0b    

lab_d324:
    sbc #0x14               ;d324  e9 14    
    bra lab_d32c            ;d326  80 04    

lab_d328:
    sbc #0x0a               ;d328  e9 0a    
    bra lab_d32c            ;d32a  80 00    

lab_d32c:
    jsr sub_d441            ;d32c  20 41 d4 

lab_d32f:
    sta mem_0042            ;d32f  85 42    
    pla                     ;d331  68       
    jsr sub_d441            ;d332  20 41 d4 
    sta mem_0043            ;d335  85 43    
    seb 3,mem_0043          ;d337  6f 43    
    lda #0x00               ;d339  a9 00    
    sta mem_0040            ;d33b  85 40    
    rts                     ;d33d  60       

    .byte 0xa5              ;d33e  a5          UNKNOWN 0xa5 

sub_d33f:
    adc [mem_004a],y        ;d33f  71 4a    
    lsr a                   ;d341  4a       
    lsr a                   ;d342  4a       
    lsr a                   ;d343  4a       
    cmp #0x0a               ;d344  c9 0a    
    bcc lab_d34a            ;d346  90 02    
    adc #0x36               ;d348  69 36    

lab_d34a:
    jsr sub_d441            ;d34a  20 41 d4 
    sta mem_0040            ;d34d  85 40    
    lda mem_0071            ;d34f  a5 71    
    and #0x0f               ;d351  29 0f    
    cmp #0x0a               ;d353  c9 0a    
    bcc lab_d359            ;d355  90 02    
    adc #0x36               ;d357  69 36    

lab_d359:
    jsr sub_d441            ;d359  20 41 d4 
    sta mem_0041            ;d35c  85 41    
    lda mem_0070            ;d35e  a5 70    
    lsr a                   ;d360  4a       
    lsr a                   ;d361  4a       
    lsr a                   ;d362  4a       
    lsr a                   ;d363  4a       
    cmp #0x0a               ;d364  c9 0a    
    bcc lab_d36a            ;d366  90 02    
    adc #0x36               ;d368  69 36    

lab_d36a:
    jsr sub_d441            ;d36a  20 41 d4 
    sta mem_0042            ;d36d  85 42    
    lda mem_0070            ;d36f  a5 70    
    and #0x0f               ;d371  29 0f    
    cmp #0x0a               ;d373  c9 0a    
    bcc lab_d379            ;d375  90 02    
    adc #0x36               ;d377  69 36    

lab_d379:
    jsr sub_d441            ;d379  20 41 d4 
    sta mem_0043            ;d37c  85 43    
    rts                     ;d37e  60       

    .byte 0xa5              ;d37f  a5          UNKNOWN 0xa5 
    .byte 0x72              ;d380  72          UNKNOWN 0x72 'r' 
    .byte 0x4a              ;d381  4a          UNKNOWN 0x4a 'J' 
    .byte 0x4a              ;d382  4a          UNKNOWN 0x4a 'J' 
    .byte 0x4a              ;d383  4a          UNKNOWN 0x4a 'J' 
    .byte 0x4a              ;d384  4a          UNKNOWN 0x4a 'J' 
    .byte 0xc9              ;d385  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;d386  0a          UNKNOWN 0x0a 
    .byte 0x90              ;d387  90          UNKNOWN 0x90 
    .byte 0x02              ;d388  02          UNKNOWN 0x02 
    .byte 0x69              ;d389  69          UNKNOWN 0x69 'i' 
    .byte 0x36              ;d38a  36          UNKNOWN 0x36 '6' 
    .byte 0x20              ;d38b  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d38c  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d38d  d4          UNKNOWN 0xd4 
    .byte 0x85              ;d38e  85          UNKNOWN 0x85 
    .byte 0x40              ;d38f  40          UNKNOWN 0x40 '@' 
    .byte 0xa5              ;d390  a5          UNKNOWN 0xa5 
    .byte 0x72              ;d391  72          UNKNOWN 0x72 'r' 
    .byte 0x29              ;d392  29          UNKNOWN 0x29 ')' 
    .byte 0x0f              ;d393  0f          UNKNOWN 0x0f 
    .byte 0xc9              ;d394  c9          UNKNOWN 0xc9 
    .byte 0x0a              ;d395  0a          UNKNOWN 0x0a 
    .byte 0x90              ;d396  90          UNKNOWN 0x90 
    .byte 0x02              ;d397  02          UNKNOWN 0x02 
    .byte 0x69              ;d398  69          UNKNOWN 0x69 'i' 
    .byte 0x36              ;d399  36          UNKNOWN 0x36 '6' 
    .byte 0x20              ;d39a  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d39b  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d39c  d4          UNKNOWN 0xd4 
    .byte 0x85              ;d39d  85          UNKNOWN 0x85 
    .byte 0x41              ;d39e  41          UNKNOWN 0x41 'A' 
    .byte 0xa9              ;d39f  a9          UNKNOWN 0xa9 
    .byte 0x00              ;d3a0  00          UNKNOWN 0x00 
    .byte 0x85              ;d3a1  85          UNKNOWN 0x85 
    .byte 0x42              ;d3a2  42          UNKNOWN 0x42 'B' 
    .byte 0xa5              ;d3a3  a5          UNKNOWN 0xa5 
    .byte 0x6c              ;d3a4  6c          UNKNOWN 0x6c 'l' 
    .byte 0x29              ;d3a5  29          UNKNOWN 0x29 ')' 
    .byte 0x0f              ;d3a6  0f          UNKNOWN 0x0f 
    .byte 0xa8              ;d3a7  a8          UNKNOWN 0xa8 
    .byte 0xb9              ;d3a8  b9          UNKNOWN 0xb9 
    .byte 0x31              ;d3a9  31          UNKNOWN 0x31 '1' 
    .byte 0xd4              ;d3aa  d4          UNKNOWN 0xd4 
    .byte 0x20              ;d3ab  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d3ac  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d3ad  d4          UNKNOWN 0xd4 
    .byte 0x85              ;d3ae  85          UNKNOWN 0x85 
    .byte 0x43              ;d3af  43          UNKNOWN 0x43 'C' 
    .byte 0x60              ;d3b0  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;d3b1  20          UNKNOWN 0x20 ' ' 
    .byte 0x31              ;d3b2  31          UNKNOWN 0x31 '1' 
    .byte 0x32              ;d3b3  32          UNKNOWN 0x32 '2' 
    .byte 0x33              ;d3b4  33          UNKNOWN 0x33 '3' 
    .byte 0x34              ;d3b5  34          UNKNOWN 0x34 '4' 
    .byte 0x35              ;d3b6  35          UNKNOWN 0x35 '5' 
    .byte 0x36              ;d3b7  36          UNKNOWN 0x36 '6' 
    .byte 0x37              ;d3b8  37          UNKNOWN 0x37 '7' 
    .byte 0x38              ;d3b9  38          UNKNOWN 0x38 '8' 
    .byte 0x39              ;d3ba  39          UNKNOWN 0x39 '9' 
    .byte 0x41              ;d3bb  41          UNKNOWN 0x41 'A' 
    .byte 0x42              ;d3bc  42          UNKNOWN 0x42 'B' 
    .byte 0x43              ;d3bd  43          UNKNOWN 0x43 'C' 

sub_d3be:
    com mem_0045            ;d3be  44 45    
    lsr mem_00c9            ;d3c0  46 c9    
    asl a                   ;d3c2  0a       
    bcs lab_d3c9            ;d3c3  b0 04    
    adc #0x30               ;d3c5  69 30    
    bra lab_d3cf            ;d3c7  80 06    

lab_d3c9:
    cmp #0x60               ;d3c9  c9 60    
    bcc lab_d3cf            ;d3cb  90 02    
    sbc #0x20               ;d3cd  e9 20    

lab_d3cf:
    sec                     ;d3cf  38       
    sbc #0x20               ;d3d0  e9 20    
    tay                     ;d3d2  a8       
    lda mem_d457,y          ;d3d3  b9 57 d4 
    rts                     ;d3d6  60       

    .byte 0x00              ;d3d7  00          UNKNOWN 0x00 
    .byte 0x00              ;d3d8  00          UNKNOWN 0x00 
    .byte 0x00              ;d3d9  00          UNKNOWN 0x00 
    .byte 0x00              ;d3da  00          UNKNOWN 0x00 
    .byte 0x00              ;d3db  00          UNKNOWN 0x00 
    .byte 0x00              ;d3dc  00          UNKNOWN 0x00 
    .byte 0x00              ;d3dd  00          UNKNOWN 0x00 
    .byte 0x00              ;d3de  00          UNKNOWN 0x00 
    .byte 0xf0              ;d3df  f0          UNKNOWN 0xf0 
    .byte 0x95              ;d3e0  95          UNKNOWN 0x95 
    .byte 0x00              ;d3e1  00          UNKNOWN 0x00 
    .byte 0x00              ;d3e2  00          UNKNOWN 0x00 
    .byte 0x00              ;d3e3  00          UNKNOWN 0x00 
    .byte 0x02              ;d3e4  02          UNKNOWN 0x02 
    .byte 0x00              ;d3e5  00          UNKNOWN 0x00 

lab_d3e6:
    brk                     ;d3e6  00       

    .byte 0xf5              ;d3e7  f5          UNKNOWN 0xf5 
    .byte 0x60              ;d3e8  60          UNKNOWN 0x60 '`' 
    .byte 0xb6              ;d3e9  b6          UNKNOWN 0xb6 
    .byte 0xf2              ;d3ea  f2          UNKNOWN 0xf2 
    .byte 0x63              ;d3eb  63          UNKNOWN 0x63 'c' 
    .byte 0xd3              ;d3ec  d3          UNKNOWN 0xd3 
    .byte 0xd7              ;d3ed  d7          UNKNOWN 0xd7 
    .byte 0x71              ;d3ee  71          UNKNOWN 0x71 'q' 
    .byte 0xf7              ;d3ef  f7          UNKNOWN 0xf7 
    .byte 0xf3              ;d3f0  f3          UNKNOWN 0xf3 
    .byte 0x00              ;d3f1  00          UNKNOWN 0x00 
    .byte 0x00              ;d3f2  00          UNKNOWN 0x00 
    .byte 0x00              ;d3f3  00          UNKNOWN 0x00 
    .byte 0x12              ;d3f4  12          UNKNOWN 0x12 
    .byte 0x00              ;d3f5  00          UNKNOWN 0x00 
    .byte 0x00              ;d3f6  00          UNKNOWN 0x00 
    .byte 0x00              ;d3f7  00          UNKNOWN 0x00 
    .byte 0x77              ;d3f8  77          UNKNOWN 0x77 'w' 
    .byte 0xc7              ;d3f9  c7          UNKNOWN 0xc7 
    .byte 0x95              ;d3fa  95          UNKNOWN 0x95 
    .byte 0xe6              ;d3fb  e6          UNKNOWN 0xe6 
    .byte 0x97              ;d3fc  97          UNKNOWN 0x97 
    .byte 0x17              ;d3fd  17          UNKNOWN 0x17 
    .byte 0xd5              ;d3fe  d5          UNKNOWN 0xd5 

sub_d3ff:
    bbs 3,mem_0040,lab_d3e6 ;d3ff  67 40 e4 
    brk                     ;d402  00       

    .byte 0x85              ;d403  85          UNKNOWN 0x85 
    .byte 0x75              ;d404  75          UNKNOWN 0x75 'u' 
    .byte 0x00              ;d405  00          UNKNOWN 0x00 
    .byte 0x00              ;d406  00          UNKNOWN 0x00 
    .byte 0x00              ;d407  00          UNKNOWN 0x00 
    .byte 0x00              ;d408  00          UNKNOWN 0x00 
    .byte 0x35              ;d409  35          UNKNOWN 0x35 '5' 
    .byte 0x00              ;d40a  00          UNKNOWN 0x00 
    .byte 0x00              ;d40b  00          UNKNOWN 0x00 
    .byte 0x00              ;d40c  00          UNKNOWN 0x00 
    .byte 0x00              ;d40d  00          UNKNOWN 0x00 
    .byte 0x00              ;d40e  00          UNKNOWN 0x00 
    .byte 0x00              ;d40f  00          UNKNOWN 0x00 
    .byte 0x00              ;d410  00          UNKNOWN 0x00 
    .byte 0x00              ;d411  00          UNKNOWN 0x00 
    .byte 0x95              ;d412  95          UNKNOWN 0x95 

lab_d413:
    brk                     ;d413  00       

    .byte 0xf0              ;d414  f0          UNKNOWN 0xf0 
    .byte 0x10              ;d415  10          UNKNOWN 0x10 
    .byte 0x80              ;d416  80          UNKNOWN 0x80 
    .byte 0xa2              ;d417  a2          UNKNOWN 0xa2 
    .byte 0x04              ;d418  04          UNKNOWN 0x04 
    .byte 0x77              ;d419  77          UNKNOWN 0x77 'w' 
    .byte 0xc0              ;d41a  c0          UNKNOWN 0xc0 
    .byte 0x0e              ;d41b  0e          UNKNOWN 0x0e 
    .byte 0xa5              ;d41c  a5          UNKNOWN 0xa5 
    .byte 0x9f              ;d41d  9f          UNKNOWN 0x9f 
    .byte 0x4a              ;d41e  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;d41f  b0          UNKNOWN 0xb0 
    .byte 0x3f              ;d420  3f          UNKNOWN 0x3f '?' 
    .byte 0xa2              ;d421  a2          UNKNOWN 0xa2 
    .byte 0x03              ;d422  03          UNKNOWN 0x03 
    .byte 0x4a              ;d423  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;d424  b0          UNKNOWN 0xb0 
    .byte 0x3a              ;d425  3a          UNKNOWN 0x3a ':' 
    .byte 0xa2              ;d426  a2          UNKNOWN 0xa2 
    .byte 0x05              ;d427  05          UNKNOWN 0x05 
    .byte 0x80              ;d428  80          UNKNOWN 0x80 
    .byte 0x36              ;d429  36          UNKNOWN 0x36 '6' 
    .byte 0xa2              ;d42a  a2          UNKNOWN 0xa2 
    .byte 0x03              ;d42b  03          UNKNOWN 0x03 
    .byte 0xe7              ;d42c  e7          UNKNOWN 0xe7 
    .byte 0xc0              ;d42d  c0          UNKNOWN 0xc0 
    .byte 0x31              ;d42e  31          UNKNOWN 0x31 '1' 
    .byte 0xa5              ;d42f  a5          UNKNOWN 0xa5 
    .byte 0xc6              ;d430  c6          UNKNOWN 0xc6 
    .byte 0xc9              ;d431  c9          UNKNOWN 0xc9 
    .byte 0x00              ;d432  00          UNKNOWN 0x00 
    .byte 0xd0              ;d433  d0          UNKNOWN 0xd0 
    .byte 0x03              ;d434  03          UNKNOWN 0x03 
    .byte 0xc7              ;d435  c7          UNKNOWN 0xc7 
    .byte 0x50              ;d436  50          UNKNOWN 0x50 'P' 
    .byte 0x04              ;d437  04          UNKNOWN 0x04 
    .byte 0xc9              ;d438  c9          UNKNOWN 0xc9 
    .byte 0x04              ;d439  04          UNKNOWN 0x04 
    .byte 0xd0              ;d43a  d0          UNKNOWN 0xd0 
    .byte 0x1a              ;d43b  1a          UNKNOWN 0x1a 
    .byte 0xa5              ;d43c  a5          UNKNOWN 0xa5 
    .byte 0x9f              ;d43d  9f          UNKNOWN 0x9f 
    .byte 0xf0              ;d43e  f0          UNKNOWN 0xf0 
    .byte 0x12              ;d43f  12          UNKNOWN 0x12 
    .byte 0xa5              ;d440  a5          UNKNOWN 0xa5 

sub_d441:
    bbs 6,a,lab_d413        ;d441  c3 d0    
    jsr [mem_00a9]          ;d443  02 a9    
    ora mem_00a2            ;d445  05 a2    
    brk                     ;d447  00       

    .byte 0xe2              ;d448  e2          UNKNOWN 0xe2 
    .byte 0x9f              ;d449  9f          UNKNOWN 0x9f 
    .byte 0x4a              ;d44a  4a          UNKNOWN 0x4a 'J' 
    .byte 0x68              ;d44b  68          UNKNOWN 0x68 'h' 
    .byte 0x90              ;d44c  90          UNKNOWN 0x90 
    .byte 0x04              ;d44d  04          UNKNOWN 0x04 
    .byte 0xa9              ;d44e  a9          UNKNOWN 0xa9 
    .byte 0x02              ;d44f  02          UNKNOWN 0x02 
    .byte 0x80              ;d450  80          UNKNOWN 0x80 
    .byte 0x0f              ;d451  0f          UNKNOWN 0x0f 
    .byte 0xa9              ;d452  a9          UNKNOWN 0xa9 
    .byte 0x01              ;d453  01          UNKNOWN 0x01 
    .byte 0x80              ;d454  80          UNKNOWN 0x80 
    .byte 0x0b              ;d455  0b          UNKNOWN 0x0b 
    .byte 0xaa              ;d456  aa          UNKNOWN 0xaa 

mem_d457:
    .byte 0xd0              ;d457  d0          DATA 0xd0 
    .byte 0x07              ;d458  07          DATA 0x07 
    .byte 0xa2              ;d459  a2          DATA 0xa2 
    .byte 0x02              ;d45a  02          DATA 0x02 
    .byte 0xb7              ;d45b  b7          DATA 0xb7 
    .byte 0x50              ;d45c  50          DATA 0x50 'P' 
    .byte 0x02              ;d45d  02          DATA 0x02 
    .byte 0xa2              ;d45e  a2          DATA 0xa2 
    .byte 0x01              ;d45f  01          DATA 0x01 
    .byte 0x8a              ;d460  8a          DATA 0x8a 
    .byte 0x60              ;d461  60          DATA 0x60 '`' 
    .byte 0xa5              ;d462  a5          DATA 0xa5 
    .byte 0xcd              ;d463  cd          DATA 0xcd 
    .byte 0xc9              ;d464  c9          DATA 0xc9 
    .byte 0x03              ;d465  03          DATA 0x03 
    .byte 0xd0              ;d466  d0          DATA 0xd0 
    .byte 0x0d              ;d467  0d          DATA 0x0d 
    .byte 0x97              ;d468  97          DATA 0x97 
    .byte 0x44              ;d469  44          DATA 0x44 'D' 
    .byte 0x05              ;d46a  05          DATA 0x05 
    .byte 0x20              ;d46b  20          DATA 0x20 ' ' 
    .byte 0x5a              ;d46c  5a          DATA 0x5a 'Z' 
    .byte 0xd5              ;d46d  d5          DATA 0xd5 
    .byte 0x80              ;d46e  80          DATA 0x80 
    .byte 0x61              ;d46f  61          DATA 0x61 'a' 
    .byte 0x20              ;d470  20          DATA 0x20 ' ' 
    .byte 0x61              ;d471  61          DATA 0x61 'a' 
    .byte 0xd5              ;d472  d5          DATA 0xd5 
    .byte 0x80              ;d473  80          DATA 0x80 
    .byte 0x5c              ;d474  5c          DATA 0x5c '\' 
    .byte 0xc9              ;d475  c9          DATA 0xc9 
    .byte 0x04              ;d476  04          DATA 0x04 
    .byte 0xd0              ;d477  d0          DATA 0xd0 
    .byte 0x0d              ;d478  0d          DATA 0x0d 
    .byte 0xb7              ;d479  b7          DATA 0xb7 
    .byte 0x44              ;d47a  44          DATA 0x44 'D' 
    .byte 0x05              ;d47b  05          DATA 0x05 
    .byte 0x20              ;d47c  20          DATA 0x20 ' ' 
    .byte 0x5a              ;d47d  5a          DATA 0x5a 'Z' 
    .byte 0xd5              ;d47e  d5          DATA 0xd5 
    .byte 0x80              ;d47f  80          DATA 0x80 
    .byte 0x50              ;d480  50          DATA 0x50 'P' 
    .byte 0x20              ;d481  20          DATA 0x20 ' ' 
    .byte 0x68              ;d482  68          DATA 0x68 'h' 
    .byte 0xd5              ;d483  d5          DATA 0xd5 
    .byte 0x80              ;d484  80          DATA 0x80 
    .byte 0x4b              ;d485  4b          DATA 0x4b 'K' 
    .byte 0xc9              ;d486  c9          DATA 0xc9 
    .byte 0x05              ;d487  05          DATA 0x05 
    .byte 0xd0              ;d488  d0          DATA 0xd0 
    .byte 0x0d              ;d489  0d          DATA 0x0d 
    .byte 0xd7              ;d48a  d7          DATA 0xd7 
    .byte 0x44              ;d48b  44          DATA 0x44 'D' 
    .byte 0x05              ;d48c  05          DATA 0x05 
    .byte 0x20              ;d48d  20          DATA 0x20 ' ' 
    .byte 0x5a              ;d48e  5a          DATA 0x5a 'Z' 
    .byte 0xd5              ;d48f  d5          DATA 0xd5 
    .byte 0x80              ;d490  80          DATA 0x80 
    .byte 0x3f              ;d491  3f          DATA 0x3f '?' 
    .byte 0x20              ;d492  20          DATA 0x20 ' ' 
    .byte 0x6f              ;d493  6f          DATA 0x6f 'o' 
    .byte 0xd5              ;d494  d5          DATA 0xd5 
    .byte 0x80              ;d495  80          DATA 0x80 
    .byte 0x3a              ;d496  3a          DATA 0x3a ':' 

sub_d497:
    cmp #0x06               ;d497  c9 06    
    bne lab_d4a8            ;d499  d0 0d    
    bbc 4,mem_0044,lab_d4a3 ;d49b  97 44 05 
    jsr sub_d55a            ;d49e  20 5a d5 
    bra lab_d4d1            ;d4a1  80 2e    

lab_d4a3:
    jsr sub_d553            ;d4a3  20 53 d5 
    bra lab_d4d1            ;d4a6  80 29    

lab_d4a8:
    cmp #0x07               ;d4a8  c9 07    
    bne lab_d4c3            ;d4aa  d0 17    
    bbs 4,mem_0044,lab_d4b4 ;d4ac  87 44 05 
    bbs 5,mem_0044,lab_d4b9 ;d4af  a7 44 07 
    bra lab_d4be            ;d4b2  80 0a    

lab_d4b4:
    jsr sub_d568            ;d4b4  20 68 d5 
    bra lab_d4d1            ;d4b7  80 18    

lab_d4b9:
    jsr 0xd56f              ;d4b9  20 6f d5 
    bra lab_d4d1            ;d4bc  80 13    

lab_d4be:
    jsr sub_d561            ;d4be  20 61 d5 
    bra lab_d4d1            ;d4c1  80 0e    

lab_d4c3:
    cmp #0x08               ;d4c3  c9 08    
    bne lab_d4cf            ;d4c5  d0 08    
    bbs 6,mem_0044,lab_d4b4 ;d4c7  c7 44 ea 
    bbs 5,mem_0044,lab_d4be ;d4ca  a7 44 f1 
    bra lab_d4b9            ;d4cd  80 ea    

lab_d4cf:
    clc                     ;d4cf  18       
    rts                     ;d4d0  60       

lab_d4d1:
    sec                     ;d4d1  38       
    rts                     ;d4d2  60       

    .byte 0x8f              ;d4d3  8f          UNKNOWN 0x8f 
    .byte 0x44              ;d4d4  44          UNKNOWN 0x44 'D' 
    .byte 0xaf              ;d4d5  af          UNKNOWN 0xaf 
    .byte 0x44              ;d4d6  44          UNKNOWN 0x44 'D' 
    .byte 0xcf              ;d4d7  cf          UNKNOWN 0xcf 
    .byte 0x44              ;d4d8  44          UNKNOWN 0x44 'D' 
    .byte 0x60              ;d4d9  60          UNKNOWN 0x60 '`' 
    .byte 0x9f              ;d4da  9f          UNKNOWN 0x9f 
    .byte 0x44              ;d4db  44          UNKNOWN 0x44 'D' 
    .byte 0xbf              ;d4dc  bf          UNKNOWN 0xbf 
    .byte 0x44              ;d4dd  44          UNKNOWN 0x44 'D' 
    .byte 0xdf              ;d4de  df          UNKNOWN 0xdf 
    .byte 0x44              ;d4df  44          UNKNOWN 0x44 'D' 
    .byte 0x60              ;d4e0  60          UNKNOWN 0x60 '`' 
    .byte 0x8f              ;d4e1  8f          UNKNOWN 0x8f 
    .byte 0x44              ;d4e2  44          UNKNOWN 0x44 'D' 
    .byte 0xbf              ;d4e3  bf          UNKNOWN 0xbf 
    .byte 0x44              ;d4e4  44          UNKNOWN 0x44 'D' 
    .byte 0xdf              ;d4e5  df          UNKNOWN 0xdf 
    .byte 0x44              ;d4e6  44          UNKNOWN 0x44 'D' 
    .byte 0x60              ;d4e7  60          UNKNOWN 0x60 '`' 
    .byte 0x9f              ;d4e8  9f          UNKNOWN 0x9f 
    .byte 0x44              ;d4e9  44          UNKNOWN 0x44 'D' 
    .byte 0xaf              ;d4ea  af          UNKNOWN 0xaf 
    .byte 0x44              ;d4eb  44          UNKNOWN 0x44 'D' 
    .byte 0xdf              ;d4ec  df          UNKNOWN 0xdf 
    .byte 0x44              ;d4ed  44          UNKNOWN 0x44 'D' 
    .byte 0x60              ;d4ee  60          UNKNOWN 0x60 '`' 
    .byte 0x9f              ;d4ef  9f          UNKNOWN 0x9f 
    .byte 0x44              ;d4f0  44          UNKNOWN 0x44 'D' 
    .byte 0xbf              ;d4f1  bf          UNKNOWN 0xbf 
    .byte 0x44              ;d4f2  44          UNKNOWN 0x44 'D' 
    .byte 0xcf              ;d4f3  cf          UNKNOWN 0xcf 
    .byte 0x44              ;d4f4  44          UNKNOWN 0x44 'D' 
    .byte 0x60              ;d4f5  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;d4f6  a9          UNKNOWN 0xa9 
    .byte 0x00              ;d4f7  00          UNKNOWN 0x00 
    .byte 0x85              ;d4f8  85          UNKNOWN 0x85 
    .byte 0x40              ;d4f9  40          UNKNOWN 0x40 '@' 
    .byte 0x85              ;d4fa  85          UNKNOWN 0x85 
    .byte 0x41              ;d4fb  41          UNKNOWN 0x41 'A' 
    .byte 0x85              ;d4fc  85          UNKNOWN 0x85 
    .byte 0x42              ;d4fd  42          UNKNOWN 0x42 'B' 
    .byte 0x85              ;d4fe  85          UNKNOWN 0x85 
    .byte 0x43              ;d4ff  43          UNKNOWN 0x43 'C' 
    .byte 0x60              ;d500  60          UNKNOWN 0x60 '`' 
    .byte 0xa2              ;d501  a2          UNKNOWN 0xa2 
    .byte 0x00              ;d502  00          UNKNOWN 0x00 
    .byte 0xbd              ;d503  bd          UNKNOWN 0xbd 
    .byte 0x91              ;d504  91          UNKNOWN 0x91 
    .byte 0xd5              ;d505  d5          UNKNOWN 0xd5 
    .byte 0xf0              ;d506  f0          UNKNOWN 0xf0 
    .byte 0x08              ;d507  08          UNKNOWN 0x08 
    .byte 0x20              ;d508  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d509  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d50a  d4          UNKNOWN 0xd4 
    .byte 0x95              ;d50b  95          UNKNOWN 0x95 
    .byte 0x40              ;d50c  40          UNKNOWN 0x40 '@' 
    .byte 0xe8              ;d50d  e8          UNKNOWN 0xe8 
    .byte 0x80              ;d50e  80          UNKNOWN 0x80 
    .byte 0xf3              ;d50f  f3          UNKNOWN 0xf3 
    .byte 0x60              ;d510  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;d511  20          UNKNOWN 0x20 ' ' 
    .byte 0x20              ;d512  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d513  41          UNKNOWN 0x41 'A' 
    .byte 0x43              ;d514  43          UNKNOWN 0x43 'C' 
    .byte 0x00              ;d515  00          UNKNOWN 0x00 
    .byte 0x3f              ;d516  3f          UNKNOWN 0x3f '?' 
    .byte 0x44              ;d517  44          UNKNOWN 0x44 'D' 
    .byte 0xa2              ;d518  a2          UNKNOWN 0xa2 
    .byte 0x00              ;d519  00          UNKNOWN 0x00 
    .byte 0xbd              ;d51a  bd          UNKNOWN 0xbd 
    .byte 0xa8              ;d51b  a8          UNKNOWN 0xa8 
    .byte 0xd5              ;d51c  d5          UNKNOWN 0xd5 
    .byte 0xf0              ;d51d  f0          UNKNOWN 0xf0 
    .byte 0x08              ;d51e  08          UNKNOWN 0x08 
    .byte 0x20              ;d51f  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;d520  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;d521  d4          UNKNOWN 0xd4 
    .byte 0x95              ;d522  95          UNKNOWN 0x95 
    .byte 0x40              ;d523  40          UNKNOWN 0x40 '@' 
    .byte 0xe8              ;d524  e8          UNKNOWN 0xe8 
    .byte 0x80              ;d525  80          UNKNOWN 0x80 
    .byte 0xf3              ;d526  f3          UNKNOWN 0xf3 
    .byte 0x60              ;d527  60          UNKNOWN 0x60 '`' 
    .byte 0x31              ;d528  31          UNKNOWN 0x31 '1' 
    .byte 0x38              ;d529  38          UNKNOWN 0x38 '8' 
    .byte 0x72              ;d52a  72          UNKNOWN 0x72 'r' 
    .byte 0x37              ;d52b  37          UNKNOWN 0x37 '7' 
    .byte 0x00              ;d52c  00          UNKNOWN 0x00 
    .byte 0x00              ;d52d  00          UNKNOWN 0x00 
    .byte 0x05              ;d52e  05          UNKNOWN 0x05 
    .byte 0x05              ;d52f  05          UNKNOWN 0x05 
    .byte 0x05              ;d530  05          UNKNOWN 0x05 
    .byte 0x05              ;d531  05          UNKNOWN 0x05 
    .byte 0x05              ;d532  05          UNKNOWN 0x05 
    .byte 0x0a              ;d533  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;d534  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;d535  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;d536  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;d537  0a          UNKNOWN 0x0a 
    .byte 0x14              ;d538  14          UNKNOWN 0x14 
    .byte 0x14              ;d539  14          UNKNOWN 0x14 
    .byte 0x14              ;d53a  14          UNKNOWN 0x14 
    .byte 0x14              ;d53b  14          UNKNOWN 0x14 
    .byte 0x14              ;d53c  14          UNKNOWN 0x14 
    .byte 0x14              ;d53d  14          UNKNOWN 0x14 
    .byte 0x14              ;d53e  14          UNKNOWN 0x14 
    .byte 0x14              ;d53f  14          UNKNOWN 0x14 
    .byte 0x14              ;d540  14          UNKNOWN 0x14 
    .byte 0x14              ;d541  14          UNKNOWN 0x14 
    .byte 0x1e              ;d542  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d543  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d544  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d545  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d546  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d547  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d548  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d549  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d54a  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d54b  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;d54c  1e          UNKNOWN 0x1e 
    .byte 0x28              ;d54d  28          UNKNOWN 0x28 '(' 
    .byte 0x28              ;d54e  28          UNKNOWN 0x28 '(' 
    .byte 0x28              ;d54f  28          UNKNOWN 0x28 '(' 
    .byte 0x28              ;d550  28          UNKNOWN 0x28 '(' 
    .byte 0x28              ;d551  28          UNKNOWN 0x28 '(' 
    .byte 0x28              ;d552  28          UNKNOWN 0x28 '(' 

sub_d553:
    plp                     ;d553  28       
    plp                     ;d554  28       
    plp                     ;d555  28       
    plp                     ;d556  28       
    plp                     ;d557  28       
    set                     ;d558  32       
    set                     ;d559  32       

sub_d55a:
    set                     ;d55a  32       
    set                     ;d55b  32       
    set                     ;d55c  32       
    set                     ;d55d  32       
    set                     ;d55e  32       
    set                     ;d55f  32       
    set                     ;d560  32       

sub_d561:
    set                     ;d561  32       
    ldm #0x3c,IREQ1         ;d562  3c 3c 3c 
    ldm #0x3c,IREQ1         ;d565  3c 3c 3c 

sub_d568:
    ldm #0x3c,IREQ1         ;d568  3c 3c 3c 
    ldm #0x46,mem_0046      ;d56b  3c 46 46 
    lsr mem_0046            ;d56e  46 46    
    lsr mem_0046            ;d570  46 46    
    lsr mem_0046            ;d572  46 46    
    lsr mem_0046            ;d574  46 46    

sub_d576:
    bvc lab_d5c8            ;d576  50 50    
    bvc 0xd5ca              ;d578  50 50    
    bvc 0xd5cc              ;d57a  50 50    
    bvc lab_d5ce            ;d57c  50 50    
    bvc 0xd5d0              ;d57e  50 50    
    .byte 0x5a              ;d580  5a       Illegal instruction

    .byte 0x5a              ;d581  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d582  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d583  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d584  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d585  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d586  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d587  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d588  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x5a              ;d589  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x64              ;d58a  64          UNKNOWN 0x64 'd' 
    .byte 0x64              ;d58b  64          UNKNOWN 0x64 'd' 
    .byte 0x64              ;d58c  64          UNKNOWN 0x64 'd' 
    .byte 0x64              ;d58d  64          UNKNOWN 0x64 'd' 
    .byte 0x64              ;d58e  64          UNKNOWN 0x64 'd' 
    .byte 0x64              ;d58f  64          UNKNOWN 0x64 'd' 
    .byte 0x64              ;d590  64          UNKNOWN 0x64 'd' 
    .byte 0x64              ;d591  64          UNKNOWN 0x64 'd' 
    .byte 0x48              ;d592  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;d593  8a          UNKNOWN 0x8a 
    .byte 0x48              ;d594  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;d595  98          UNKNOWN 0x98 
    .byte 0x48              ;d596  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d597  a5          UNKNOWN 0xa5 
    .byte 0xf7              ;d598  f7          UNKNOWN 0xf7 
    .byte 0x48              ;d599  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d59a  a5          UNKNOWN 0xa5 
    .byte 0xf8              ;d59b  f8          UNKNOWN 0xf8 
    .byte 0x48              ;d59c  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d59d  a5          UNKNOWN 0xa5 
    .byte 0xf9              ;d59e  f9          UNKNOWN 0xf9 
    .byte 0x48              ;d59f  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d5a0  a5          UNKNOWN 0xa5 
    .byte 0xfa              ;d5a1  fa          UNKNOWN 0xfa 
    .byte 0x48              ;d5a2  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d5a3  a5          UNKNOWN 0xa5 
    .byte 0x81              ;d5a4  81          UNKNOWN 0x81 
    .byte 0xf0              ;d5a5  f0          UNKNOWN 0xf0 
    .byte 0x0f              ;d5a6  0f          UNKNOWN 0x0f 
    .byte 0xa7              ;d5a7  a7          UNKNOWN 0xa7 
    .byte 0x81              ;d5a8  81          UNKNOWN 0x81 
    .byte 0x1e              ;d5a9  1e          UNKNOWN 0x1e 
    .byte 0xc7              ;d5aa  c7          UNKNOWN 0xc7 
    .byte 0x81              ;d5ab  81          UNKNOWN 0x81 
    .byte 0x21              ;d5ac  21          UNKNOWN 0x21 '!' 

mem_d5ad:
    .byte 0x20              ;d5ad  20          DATA 0x20 ' ' 
    .byte 0x68              ;d5ae  68          DATA 0x68 'h' 
    .byte 0xd6              ;d5af  d6          DATA 0xd6 
    .byte 0xa5              ;d5b0  a5          DATA 0xa5 
    .byte 0x81              ;d5b1  81          DATA 0x81 
    .byte 0xd0              ;d5b2  d0          DATA 0xd0 
    .byte 0x02              ;d5b3  02          DATA 0x02 
    .byte 0x9f              ;d5b4  9f          DATA 0x9f 
    .byte 0x34              ;d5b5  34          DATA 0x34 '4' 
    .byte 0x68              ;d5b6  68          DATA 0x68 'h' 
    .byte 0x85              ;d5b7  85          DATA 0x85 
    .byte 0xfa              ;d5b8  fa          DATA 0xfa 
    .byte 0x68              ;d5b9  68          DATA 0x68 'h' 
    .byte 0x85              ;d5ba  85          DATA 0x85 
    .byte 0xf9              ;d5bb  f9          DATA 0xf9 
    .byte 0x68              ;d5bc  68          DATA 0x68 'h' 
    .byte 0x85              ;d5bd  85          DATA 0x85 
    .byte 0xf8              ;d5be  f8          DATA 0xf8 
    .byte 0x68              ;d5bf  68          DATA 0x68 'h' 
    .byte 0x85              ;d5c0  85          DATA 0x85 
    .byte 0xf7              ;d5c1  f7          DATA 0xf7 
    .byte 0x68              ;d5c2  68          DATA 0x68 'h' 
    .byte 0xa8              ;d5c3  a8          DATA 0xa8 
    .byte 0x68              ;d5c4  68          DATA 0x68 'h' 
    .byte 0xaa              ;d5c5  aa          DATA 0xaa 
    .byte 0x68              ;d5c6  68          DATA 0x68 'h' 
    .byte 0x40              ;d5c7  40          DATA 0x40 '@' 

lab_d5c8:
    jsr 0xd877              ;d5c8  20 77 d8 
    jmp lab_d630            ;d5cb  4c 30 d6 

lab_d5ce:
    jsr sub_d897            ;d5ce  20 97 d8 
    bbs 6,mem_0081,lab_d5e5 ;d5d1  c7 81 11 
    bbs 5,mem_0080,lab_d5e2 ;d5d4  a7 80 0b 
    bbs 4,mem_0080,lab_d5e2 ;d5d7  87 80 08 
    bbc 0,mem_0080,lab_d5e5 ;d5da  17 80 08 
    jsr sub_d754            ;d5dd  20 54 d7 
    bra lab_d5e5            ;d5e0  80 03    

lab_d5e2:
    jsr sub_d74e            ;d5e2  20 4e d7 

lab_d5e5:
    jmp lab_d630            ;d5e5  4c 30 d6 

    .byte 0xe7              ;d5e8  e7          UNKNOWN 0xe7 
    .byte 0x81              ;d5e9  81          UNKNOWN 0x81 
    .byte 0x12              ;d5ea  12          UNKNOWN 0x12 
    .byte 0x97              ;d5eb  97          UNKNOWN 0x97 
    .byte 0x81              ;d5ec  81          UNKNOWN 0x81 
    .byte 0x03              ;d5ed  03          UNKNOWN 0x03 
    .byte 0x4c              ;d5ee  4c          UNKNOWN 0x4c 'L' 
    .byte 0x24              ;d5ef  24          UNKNOWN 0x24 '$' 
    .byte 0xd7              ;d5f0  d7          UNKNOWN 0xd7 
    .byte 0x07              ;d5f1  07          UNKNOWN 0x07 
    .byte 0x81              ;d5f2  81          UNKNOWN 0x81 
    .byte 0x36              ;d5f3  36          UNKNOWN 0x36 '6' 
    .byte 0x27              ;d5f4  27          UNKNOWN 0x27 ''' 
    .byte 0x81              ;d5f5  81          UNKNOWN 0x81 
    .byte 0x4e              ;d5f6  4e          UNKNOWN 0x4e 'N' 
    .byte 0x47              ;d5f7  47          UNKNOWN 0x47 'G' 
    .byte 0x81              ;d5f8  81          UNKNOWN 0x81 
    .byte 0x26              ;d5f9  26          UNKNOWN 0x26 '&' 
    .byte 0x4c              ;d5fa  4c          UNKNOWN 0x4c 'L' 
    .byte 0xfb              ;d5fb  fb          UNKNOWN 0xfb 
    .byte 0xd6              ;d5fc  d6          UNKNOWN 0xd6 
    .byte 0xa5              ;d5fd  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d5fe  35          UNKNOWN 0x35 '5' 
    .byte 0xff              ;d5ff  ff          UNKNOWN 0xff 
    .byte 0x81              ;d600  81          UNKNOWN 0x81 
    .byte 0xad              ;d601  ad          UNKNOWN 0xad 
    .byte 0x01              ;d602  01          UNKNOWN 0x01 
    .byte 0x01              ;d603  01          UNKNOWN 0x01 
    .byte 0xf0              ;d604  f0          UNKNOWN 0xf0 
    .byte 0x07              ;d605  07          UNKNOWN 0x07 
    .byte 0x1a              ;d606  1a          UNKNOWN 0x1a 
    .byte 0x8d              ;d607  8d          UNKNOWN 0x8d 
    .byte 0x01              ;d608  01          UNKNOWN 0x01 
    .byte 0x01              ;d609  01          UNKNOWN 0x01 
    .byte 0x4c              ;d60a  4c          UNKNOWN 0x4c 'L' 
    .byte 0x77              ;d60b  77          UNKNOWN 0x77 'w' 
    .byte 0xd7              ;d60c  d7          UNKNOWN 0xd7 
    .byte 0x20              ;d60d  20          UNKNOWN 0x20 ' ' 
    .byte 0xbb              ;d60e  bb          UNKNOWN 0xbb 
    .byte 0xd7              ;d60f  d7          UNKNOWN 0xd7 
    .byte 0x90              ;d610  90          UNKNOWN 0x90 
    .byte 0x0d              ;d611  0d          UNKNOWN 0x0d 

lab_d612:
    jsr 0xd77f              ;d612  20 7f d7 
    bcc lab_d61f            ;d615  90 08    
    jsr sub_d791            ;d617  20 91 d7 
    bcc lab_d61f            ;d61a  90 03    
    jsr sub_d7a3            ;d61c  20 a3 d7 

lab_d61f:
    rts                     ;d61f  60       

    .byte 0x5f              ;d620  5f          UNKNOWN 0x5f '_' 
    .byte 0x81              ;d621  81          UNKNOWN 0x81 
    .byte 0xa5              ;d622  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d623  35          UNKNOWN 0x35 '5' 
    .byte 0x85              ;d624  85          UNKNOWN 0x85 
    .byte 0x72              ;d625  72          UNKNOWN 0x72 'r' 
    .byte 0x20              ;d626  20          UNKNOWN 0x20 ' ' 
    .byte 0xac              ;d627  ac          UNKNOWN 0xac 
    .byte 0xd7              ;d628  d7          UNKNOWN 0xd7 
    .byte 0x60              ;d629  60          UNKNOWN 0x60 '`' 
    .byte 0x1f              ;d62a  1f          UNKNOWN 0x1f 
    .byte 0x81              ;d62b  81          UNKNOWN 0x81 
    .byte 0xa0              ;d62c  a0          UNKNOWN 0xa0 
    .byte 0x65              ;d62d  65          UNKNOWN 0x65 'e' 
    .byte 0xa5              ;d62e  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d62f  35          UNKNOWN 0x35 '5' 

lab_d630:
    sta mem_006b            ;d630  85 6b    
    pha                     ;d632  48       
    jsr sub_e651            ;d633  20 51 e6 
    pla                     ;d636  68       
    jsr sub_d804            ;d637  20 04 d8 
    ldy #0x5f               ;d63a  a0 5f    
    jsr sub_e61d            ;d63c  20 1d e6 

lab_d63f:
    jsr sub_d791            ;d63f  20 91 d7 
    bcs lab_d658            ;d642  b0 14    
    rts                     ;d644  60       

    .byte 0x3f              ;d645  3f          UNKNOWN 0x3f '?' 
    .byte 0x81              ;d646  81          UNKNOWN 0x81 
    .byte 0xa0              ;d647  a0          UNKNOWN 0xa0 
    .byte 0x62              ;d648  62          UNKNOWN 0x62 'b' 
    .byte 0xa5              ;d649  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d64a  35          UNKNOWN 0x35 '5' 
    .byte 0x48              ;d64b  48          UNKNOWN 0x48 'H' 
    .byte 0x20              ;d64c  20          UNKNOWN 0x20 ' ' 
    .byte 0x51              ;d64d  51          UNKNOWN 0x51 'Q' 
    .byte 0xe6              ;d64e  e6          UNKNOWN 0xe6 
    .byte 0x68              ;d64f  68          UNKNOWN 0x68 'h' 
    .byte 0x20              ;d650  20          UNKNOWN 0x20 ' ' 
    .byte 0x30              ;d651  30          UNKNOWN 0x30 '0' 
    .byte 0xd8              ;d652  d8          UNKNOWN 0xd8 
    .byte 0xa0              ;d653  a0          UNKNOWN 0xa0 
    .byte 0x5d              ;d654  5d          UNKNOWN 0x5d ']' 
    .byte 0x20              ;d655  20          UNKNOWN 0x20 ' ' 
    .byte 0x1d              ;d656  1d          UNKNOWN 0x1d 
    .byte 0xe6              ;d657  e6          UNKNOWN 0xe6 

lab_d658:
    bbc 6,mem_0080,lab_d661 ;d658  d7 80 06 
    seb 5,mem_0080          ;d65b  af 80    
    jsr sub_d849            ;d65d  20 49 d8 
    rts                     ;d660  60       

lab_d661:
    clb 5,mem_0080          ;d661  bf 80    
    ldy #0x5f               ;d663  a0 5f    
    jsr sub_e611            ;d665  20 11 e6 
    bne lab_d675            ;d668  d0 0b    
    ldy #0x5d               ;d66a  a0 5d    
    jsr sub_e611            ;d66c  20 11 e6 
    bne lab_d675            ;d66f  d0 04    
    jsr sub_d7a3            ;d671  20 a3 d7 
    rts                     ;d674  60       

lab_d675:
    jsr 0xd77f              ;d675  20 7f d7 
    bcs lab_d63f            ;d678  b0 c5    
    rts                     ;d67a  60       

    .byte 0x7f              ;d67b  7f          UNKNOWN 0x7f 
    .byte 0x81              ;d67c  81          UNKNOWN 0x81 
    .byte 0xa5              ;d67d  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d67e  35          UNKNOWN 0x35 '5' 
    .byte 0x85              ;d67f  85          UNKNOWN 0x85 
    .byte 0x6a              ;d680  6a          UNKNOWN 0x6a 'j' 
    .byte 0x85              ;d681  85          UNKNOWN 0x85 
    .byte 0x71              ;d682  71          UNKNOWN 0x71 'q' 
    .byte 0x20              ;d683  20          UNKNOWN 0x20 ' ' 
    .byte 0xd4              ;d684  d4          UNKNOWN 0xd4 
    .byte 0xd7              ;d685  d7          UNKNOWN 0xd7 
    .byte 0xa5              ;d686  a5          UNKNOWN 0xa5 
    .byte 0x71              ;d687  71          UNKNOWN 0x71 'q' 
    .byte 0xa0              ;d688  a0          UNKNOWN 0xa0 
    .byte 0x68              ;d689  68          UNKNOWN 0x68 'h' 
    .byte 0x20              ;d68a  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;d68b  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;d68c  e6          UNKNOWN 0xe6 
    .byte 0xc6              ;d68d  c6          UNKNOWN 0xc6 
    .byte 0x61              ;d68e  61          UNKNOWN 0x61 'a' 
    .byte 0xd7              ;d68f  d7          UNKNOWN 0xd7 
    .byte 0x80              ;d690  80          UNKNOWN 0x80 
    .byte 0x06              ;d691  06          UNKNOWN 0x06 
    .byte 0x8f              ;d692  8f          UNKNOWN 0x8f 
    .byte 0x80              ;d693  80          UNKNOWN 0x80 
    .byte 0x20              ;d694  20          UNKNOWN 0x20 ' ' 
    .byte 0x49              ;d695  49          UNKNOWN 0x49 'I' 
    .byte 0xd8              ;d696  d8          UNKNOWN 0xd8 
    .byte 0x60              ;d697  60          UNKNOWN 0x60 '`' 
    .byte 0x9f              ;d698  9f          UNKNOWN 0x9f 
    .byte 0x80              ;d699  80          UNKNOWN 0x80 
    .byte 0x20              ;d69a  20          UNKNOWN 0x20 ' ' 
    .byte 0xac              ;d69b  ac          UNKNOWN 0xac 
    .byte 0xd7              ;d69c  d7          UNKNOWN 0xd7 
    .byte 0xb0              ;d69d  b0          UNKNOWN 0xb0 
    .byte 0x01              ;d69e  01          UNKNOWN 0x01 
    .byte 0x60              ;d69f  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;d6a0  20          UNKNOWN 0x20 ' ' 
    .byte 0xdb              ;d6a1  db          UNKNOWN 0xdb 
    .byte 0xd0              ;d6a2  d0          UNKNOWN 0xd0 
    .byte 0x60              ;d6a3  60          UNKNOWN 0x60 '`' 
    .byte 0x9f              ;d6a4  9f          UNKNOWN 0x9f 
    .byte 0x81              ;d6a5  81          UNKNOWN 0x81 
    .byte 0xa5              ;d6a6  a5          UNKNOWN 0xa5 
    .byte 0x34              ;d6a7  34          UNKNOWN 0x34 '4' 
    .byte 0x29              ;d6a8  29          UNKNOWN 0x29 ')' 
    .byte 0x07              ;d6a9  07          UNKNOWN 0x07 
    .byte 0xc9              ;d6aa  c9          UNKNOWN 0xc9 
    .byte 0x04              ;d6ab  04          UNKNOWN 0x04 
    .byte 0xf0              ;d6ac  f0          UNKNOWN 0xf0 
    .byte 0x09              ;d6ad  09          UNKNOWN 0x09 
    .byte 0xa5              ;d6ae  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d6af  35          UNKNOWN 0x35 '5' 
    .byte 0x8d              ;d6b0  8d          UNKNOWN 0x8d 
    .byte 0x0a              ;d6b1  0a          UNKNOWN 0x0a 
    .byte 0x01              ;d6b2  01          UNKNOWN 0x01 
    .byte 0x20              ;d6b3  20          UNKNOWN 0x20 ' ' 
    .byte 0xc4              ;d6b4  c4          UNKNOWN 0xc4 
    .byte 0xd7              ;d6b5  d7          UNKNOWN 0xd7 
    .byte 0x60              ;d6b6  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d6b7  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d6b8  35          UNKNOWN 0x35 '5' 
    .byte 0x8d              ;d6b9  8d          UNKNOWN 0x8d 
    .byte 0x0b              ;d6ba  0b          UNKNOWN 0x0b 
    .byte 0x01              ;d6bb  01          UNKNOWN 0x01 
    .byte 0x20              ;d6bc  20          UNKNOWN 0x20 ' ' 
    .byte 0x7f              ;d6bd  7f          UNKNOWN 0x7f 
    .byte 0xd7              ;d6be  d7          UNKNOWN 0xd7 
    .byte 0x90              ;d6bf  90          UNKNOWN 0x90 
    .byte 0x08              ;d6c0  08          UNKNOWN 0x08 
    .byte 0x20              ;d6c1  20          UNKNOWN 0x20 ' ' 
    .byte 0x91              ;d6c2  91          UNKNOWN 0x91 
    .byte 0xd7              ;d6c3  d7          UNKNOWN 0xd7 
    .byte 0x90              ;d6c4  90          UNKNOWN 0x90 
    .byte 0x03              ;d6c5  03          UNKNOWN 0x03 
    .byte 0x20              ;d6c6  20          UNKNOWN 0x20 ' ' 
    .byte 0xa3              ;d6c7  a3          UNKNOWN 0xa3 
    .byte 0xd7              ;d6c8  d7          UNKNOWN 0xd7 
    .byte 0x60              ;d6c9  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d6ca  a5          UNKNOWN 0xa5 
    .byte 0x81              ;d6cb  81          UNKNOWN 0x81 
    .byte 0xd0              ;d6cc  d0          UNKNOWN 0xd0 
    .byte 0x09              ;d6cd  09          UNKNOWN 0x09 
    .byte 0xa7              ;d6ce  a7          UNKNOWN 0xa7 
    .byte 0x80              ;d6cf  80          UNKNOWN 0x80 
    .byte 0x90              ;d6d0  90          UNKNOWN 0x90 
    .byte 0x87              ;d6d1  87          UNKNOWN 0x87 
    .byte 0x80              ;d6d2  80          UNKNOWN 0x80 
    .byte 0xc4              ;d6d3  c4          UNKNOWN 0xc4 
    .byte 0x07              ;d6d4  07          UNKNOWN 0x07 

lab_d6d5:
    bra lab_d6d8            ;d6d5  80 01    

    .byte 0x60              ;d6d7  60          UNKNOWN 0x60 '`' 

lab_d6d8:
    clb 0,mem_0080          ;d6d8  1f 80    
    ldm #0x00,mem_0062      ;d6da  3c 00 62 
    ldm #0x00,mem_0063      ;d6dd  3c 00 63 
    ldm #0x00,mem_0064      ;d6e0  3c 00 64 
    ldm #0x00,mem_0065      ;d6e3  3c 00 65 
    ldm #0x00,mem_0066      ;d6e6  3c 00 66 
    ldm #0x00,mem_0067      ;d6e9  3c 00 67 
    ldm #0x00,mem_0068      ;d6ec  3c 00 68 
    ldm #0x00,mem_0069      ;d6ef  3c 00 69 
    lda #0x08               ;d6f2  a9 08    
    sta mem_0101            ;d6f4  8d 01 01 
    seb 7,mem_0081          ;d6f7  ef 81    
    lda #0x02               ;d6f9  a9 02    
    jsr sub_d7cd            ;d6fb  20 cd d7 
    rts                     ;d6fe  60       

    .byte 0xa0              ;d6ff  a0          UNKNOWN 0xa0 
    .byte 0x5f              ;d700  5f          UNKNOWN 0x5f '_' 
    .byte 0x20              ;d701  20          UNKNOWN 0x20 ' ' 
    .byte 0x11              ;d702  11          UNKNOWN 0x11 
    .byte 0xe6              ;d703  e6          UNKNOWN 0xe6 
    .byte 0xd0              ;d704  d0          UNKNOWN 0xd0 
    .byte 0x02              ;d705  02          UNKNOWN 0x02 
    .byte 0x38              ;d706  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;d707  60          UNKNOWN 0x60 '`' 
    .byte 0x0f              ;d708  0f          UNKNOWN 0x0f 
    .byte 0x81              ;d709  81          UNKNOWN 0x81 
    .byte 0xa9              ;d70a  a9          UNKNOWN 0xa9 
    .byte 0x00              ;d70b  00          UNKNOWN 0x00 
    .byte 0x20              ;d70c  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d70d  cd          UNKNOWN 0xcd 
    .byte 0xd7              ;d70e  d7          UNKNOWN 0xd7 
    .byte 0x18              ;d70f  18          UNKNOWN 0x18 
    .byte 0x60              ;d710  60          UNKNOWN 0x60 '`' 
    .byte 0xa0              ;d711  a0          UNKNOWN 0xa0 
    .byte 0x5d              ;d712  5d          UNKNOWN 0x5d ']' 
    .byte 0x20              ;d713  20          UNKNOWN 0x20 ' ' 
    .byte 0x11              ;d714  11          UNKNOWN 0x11 
    .byte 0xe6              ;d715  e6          UNKNOWN 0xe6 
    .byte 0xd0              ;d716  d0          UNKNOWN 0xd0 
    .byte 0x02              ;d717  02          UNKNOWN 0x02 
    .byte 0x38              ;d718  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;d719  60          UNKNOWN 0x60 '`' 
    .byte 0x2f              ;d71a  2f          UNKNOWN 0x2f '/' 
    .byte 0x81              ;d71b  81          UNKNOWN 0x81 
    .byte 0xa9              ;d71c  a9          UNKNOWN 0xa9 
    .byte 0x01              ;d71d  01          UNKNOWN 0x01 
    .byte 0x20              ;d71e  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d71f  cd          UNKNOWN 0xcd 
    .byte 0xd7              ;d720  d7          UNKNOWN 0xd7 
    .byte 0x18              ;d721  18          UNKNOWN 0x18 
    .byte 0x60              ;d722  60          UNKNOWN 0x60 '`' 
    .byte 0x4f              ;d723  4f          UNKNOWN 0x4f 'O' 
    .byte 0x81              ;d724  81          UNKNOWN 0x81 
    .byte 0xa9              ;d725  a9          UNKNOWN 0xa9 
    .byte 0x02              ;d726  02          UNKNOWN 0x02 
    .byte 0x20              ;d727  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d728  cd          UNKNOWN 0xcd 
    .byte 0xd7              ;d729  d7          UNKNOWN 0xd7 
    .byte 0x18              ;d72a  18          UNKNOWN 0x18 
    .byte 0x60              ;d72b  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d72c  a5          UNKNOWN 0xa5 
    .byte 0x61              ;d72d  61          UNKNOWN 0x61 'a' 
    .byte 0xd0              ;d72e  d0          UNKNOWN 0xd0 
    .byte 0x02              ;d72f  02          UNKNOWN 0x02 
    .byte 0x38              ;d730  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;d731  60          UNKNOWN 0x60 '`' 
    .byte 0x6f              ;d732  6f          UNKNOWN 0x6f 'o' 
    .byte 0x81              ;d733  81          UNKNOWN 0x81 
    .byte 0xa9              ;d734  a9          UNKNOWN 0xa9 
    .byte 0x03              ;d735  03          UNKNOWN 0x03 
    .byte 0x20              ;d736  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d737  cd          UNKNOWN 0xcd 
    .byte 0xd7              ;d738  d7          UNKNOWN 0xd7 
    .byte 0x18              ;d739  18          UNKNOWN 0x18 
    .byte 0x60              ;d73a  60          UNKNOWN 0x60 '`' 
    .byte 0x8f              ;d73b  8f          UNKNOWN 0x8f 
    .byte 0x81              ;d73c  81          UNKNOWN 0x81 
    .byte 0xa9              ;d73d  a9          UNKNOWN 0xa9 
    .byte 0x07              ;d73e  07          UNKNOWN 0x07 
    .byte 0x20              ;d73f  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d740  cd          UNKNOWN 0xcd 
    .byte 0xd7              ;d741  d7          UNKNOWN 0xd7 
    .byte 0x18              ;d742  18          UNKNOWN 0x18 
    .byte 0x60              ;d743  60          UNKNOWN 0x60 '`' 
    .byte 0x8f              ;d744  8f          UNKNOWN 0x8f 
    .byte 0x81              ;d745  81          UNKNOWN 0x81 
    .byte 0xa9              ;d746  a9          UNKNOWN 0xa9 
    .byte 0x04              ;d747  04          UNKNOWN 0x04 
    .byte 0x20              ;d748  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d749  cd          UNKNOWN 0xcd 

sub_d74a:
    bbc 6,TB_RB,lab_d7ad    ;d74a  d7 18 60 

    .byte 0x09              ;d74d  09          UNKNOWN 0x09 

sub_d74e:
    bpl lab_d6d5            ;d74e  10 85    
    .byte 0x34              ;d750  34       Illegal instruction

    .byte 0xdf              ;d751  df          UNKNOWN 0xdf 
    .byte 0x3d              ;d752  3d          UNKNOWN 0x3d '=' 
    .byte 0x60              ;d753  60          UNKNOWN 0x60 '`' 

sub_d754:
    bbs 7,mem_006c,lab_d758 ;d754  e7 6c 01 
    rts                     ;d757  60       

lab_d758:
    cmp mem_007b            ;d758  c5 7b    
    beq lab_d75e            ;d75a  f0 02    
    bcc lab_d76e            ;d75c  90 10    

lab_d75e:
    cmp mem_007a            ;d75e  c5 7a    
    beq lab_d76b            ;d760  f0 09    
    bcc lab_d76b            ;d762  90 07    
    ldx mem_007a            ;d764  a6 7a    
    stx mem_007b            ;d766  86 7b    
    sta mem_007a            ;d768  85 7a    
    rts                     ;d76a  60       

lab_d76b:
    sta mem_007b            ;d76b  85 7b    
    rts                     ;d76d  60       

lab_d76e:
    cmp mem_007d            ;d76e  c5 7d    
    beq lab_d774            ;d770  f0 02    
    bcs lab_d783            ;d772  b0 0f    

lab_d774:
    cmp mem_007c            ;d774  c5 7c    
    beq lab_d781            ;d776  f0 09    
    bcs lab_d781            ;d778  b0 07    
    ldx mem_007c            ;d77a  a6 7c    
    stx mem_007d            ;d77c  86 7d    
    sta mem_007c            ;d77e  85 7c    
    rts                     ;d780  60       

lab_d781:
    sta mem_007d            ;d781  85 7d    

lab_d783:
    rts                     ;d783  60       

lab_d784:
    cmp mem_0077            ;d784  c5 77    
    beq lab_d78a            ;d786  f0 02    

lab_d788:
    bcc lab_d79a            ;d788  90 10    

lab_d78a:
    cmp mem_0076            ;d78a  c5 76    
    beq lab_d797            ;d78c  f0 09    
    bcc lab_d797            ;d78e  90 07    

    .byte 0xa6              ;d790  a6          UNKNOWN 0xa6 

sub_d791:
    ror mem_0086,x          ;d791  76 86    
    bbc 3,mem_0085,0xd80c   ;d793  77 85 76 
    rts                     ;d796  60       

lab_d797:
    sta mem_0077            ;d797  85 77    
    rts                     ;d799  60       

lab_d79a:
    cmp mem_0079            ;d79a  c5 79    
    beq lab_d7a0            ;d79c  f0 02    
    bcs lab_d7af            ;d79e  b0 0f    

lab_d7a0:
    cmp mem_0078            ;d7a0  c5 78    

    .byte 0xf0              ;d7a2  f0          UNKNOWN 0xf0 

sub_d7a3:
    ora #0xb0               ;d7a3  09 b0    
    bbs 0,mem_00a6,lab_d820 ;d7a5  07 a6 78 
    stx mem_0079            ;d7a8  86 79    
    sta mem_0078            ;d7aa  85 78    
    rts                     ;d7ac  60       

lab_d7ad:
    sta mem_0079            ;d7ad  85 79    

lab_d7af:
    rts                     ;d7af  60       

    .byte 0xc5              ;d7b0  c5          UNKNOWN 0xc5 
    .byte 0x74              ;d7b1  74          UNKNOWN 0x74 't' 
    .byte 0x90              ;d7b2  90          UNKNOWN 0x90 
    .byte 0x03              ;d7b3  03          UNKNOWN 0x03 
    .byte 0x85              ;d7b4  85          UNKNOWN 0x85 
    .byte 0x74              ;d7b5  74          UNKNOWN 0x74 't' 

lab_d7b6:
    rts                     ;d7b6  60       

    .byte 0xc5              ;d7b7  c5          UNKNOWN 0xc5 
    .byte 0x75              ;d7b8  75          UNKNOWN 0x75 'u' 
    .byte 0xb0              ;d7b9  b0          UNKNOWN 0xb0 
    .byte 0x02              ;d7ba  02          UNKNOWN 0x02 
    .byte 0x85              ;d7bb  85          UNKNOWN 0x85 
    .byte 0x75              ;d7bc  75          UNKNOWN 0x75 'u' 
    .byte 0x60              ;d7bd  60          UNKNOWN 0x60 '`' 
    .byte 0xc7              ;d7be  c7          UNKNOWN 0xc7 
    .byte 0xd3              ;d7bf  d3          UNKNOWN 0xd3 
    .byte 0x03              ;d7c0  03          UNKNOWN 0x03 
    .byte 0xdf              ;d7c1  df          UNKNOWN 0xdf 
    .byte 0x80              ;d7c2  80          UNKNOWN 0x80 
    .byte 0x60              ;d7c3  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d7c4  a5          UNKNOWN 0xa5 
    .byte 0x81              ;d7c5  81          UNKNOWN 0x81 
    .byte 0xf0              ;d7c6  f0          UNKNOWN 0xf0 
    .byte 0x01              ;d7c7  01          UNKNOWN 0x01 
    .byte 0x60              ;d7c8  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;d7c9  3c          UNKNOWN 0x3c '<' 
    .byte 0x08              ;d7ca  08          UNKNOWN 0x08 
    .byte 0xda              ;d7cb  da          UNKNOWN 0xda 
    .byte 0xdf              ;d7cc  df          UNKNOWN 0xdf 

sub_d7cd:
    bbc 6,a,lab_d81e        ;d7cd  d3 4f    
    jsr [mem_007f]          ;d7cf  02 7f    
    jsr [mem_004f]          ;d7d1  02 4f    
    bbc 6,a,lab_d784        ;d7d3  d3 af    
    bbc 6,a,lab_d7b6        ;d7d5  d3 df    
    bra lab_d788            ;d7d7  80 af    

    .byte 0x81              ;d7d9  81          UNKNOWN 0x81 
    .byte 0x6f              ;d7da  6f          UNKNOWN 0x6f 'o' 
    .byte 0xd3              ;d7db  d3          UNKNOWN 0xd3 
    .byte 0xa9              ;d7dc  a9          UNKNOWN 0xa9 
    .byte 0x06              ;d7dd  06          UNKNOWN 0x06 
    .byte 0x20              ;d7de  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d7df  cd          UNKNOWN 0xcd 
    .byte 0xd7              ;d7e0  d7          UNKNOWN 0xd7 
    .byte 0x60              ;d7e1  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;d7e2  3c          UNKNOWN 0x3c '<' 
    .byte 0x08              ;d7e3  08          UNKNOWN 0x08 
    .byte 0xda              ;d7e4  da          UNKNOWN 0xda 
    .byte 0x0f              ;d7e5  0f          UNKNOWN 0x0f 
    .byte 0x02              ;d7e6  02          UNKNOWN 0x02 
    .byte 0x3f              ;d7e7  3f          UNKNOWN 0x3f '?' 
    .byte 0x02              ;d7e8  02          UNKNOWN 0x02 
    .byte 0x2f              ;d7e9  2f          UNKNOWN 0x2f '/' 
    .byte 0xd3              ;d7ea  d3          UNKNOWN 0xd3 
    .byte 0x8f              ;d7eb  8f          UNKNOWN 0x8f 
    .byte 0xd3              ;d7ec  d3          UNKNOWN 0xd3 
    .byte 0xcf              ;d7ed  cf          UNKNOWN 0xcf 
    .byte 0x81              ;d7ee  81          UNKNOWN 0x81 
    .byte 0x6f              ;d7ef  6f          UNKNOWN 0x6f 'o' 
    .byte 0xd3              ;d7f0  d3          UNKNOWN 0xd3 
    .byte 0xa9              ;d7f1  a9          UNKNOWN 0xa9 
    .byte 0x05              ;d7f2  05          UNKNOWN 0x05 
    .byte 0x20              ;d7f3  20          UNKNOWN 0x20 ' ' 
    .byte 0xcd              ;d7f4  cd          UNKNOWN 0xcd 
    .byte 0xd7              ;d7f5  d7          UNKNOWN 0xd7 
    .byte 0x60              ;d7f6  60          UNKNOWN 0x60 '`' 
    .byte 0x77              ;d7f7  77          UNKNOWN 0x77 'w' 
    .byte 0xd3              ;d7f8  d3          UNKNOWN 0xd3 
    .byte 0x0b              ;d7f9  0b          UNKNOWN 0x0b 
    .byte 0xa5              ;d7fa  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d7fb  35          UNKNOWN 0x35 '5' 
    .byte 0xc6              ;d7fc  c6          UNKNOWN 0xc6 
    .byte 0xda              ;d7fd  da          UNKNOWN 0xda 
    .byte 0xd0              ;d7fe  d0          UNKNOWN 0xd0 
    .byte 0x02              ;d7ff  02          UNKNOWN 0x02 
    .byte 0x7f              ;d800  7f          UNKNOWN 0x7f 
    .byte 0xd3              ;d801  d3          UNKNOWN 0xd3 
    .byte 0x4c              ;d802  4c          UNKNOWN 0x4c 'L' 
    .byte 0x5c              ;d803  5c          UNKNOWN 0x5c '\' 

sub_d804:
    cld                     ;d804  d8       
    seb 3,P1                ;d805  6f 02    
    clb 2,P1                ;d807  5f 02    
    clb 2,mem_00d3          ;d809  5f d3    
    clb 5,mem_00d3          ;d80b  bf d3    
    clb 5,mem_0081          ;d80d  bf 81    
    lda AD                  ;d80f  a5 35    
    sta mem_00d0            ;d811  85 d0    
    jsr sub_d862            ;d813  20 62 d8 
    rts                     ;d816  60       

    .byte 0x77              ;d817  77          UNKNOWN 0x77 'w' 
    .byte 0xd3              ;d818  d3          UNKNOWN 0xd3 
    .byte 0x0b              ;d819  0b          UNKNOWN 0x0b 
    .byte 0xa5              ;d81a  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d81b  35          UNKNOWN 0x35 '5' 
    .byte 0xc6              ;d81c  c6          UNKNOWN 0xc6 
    .byte 0xda              ;d81d  da          UNKNOWN 0xda 

lab_d81e:
    bne lab_d822            ;d81e  d0 02    

lab_d820:
    clb 3,mem_00d3          ;d820  7f d3    

lab_d822:
    jmp lab_d871            ;d822  4c 71 d8 

    .byte 0xcf              ;d825  cf          UNKNOWN 0xcf 
    .byte 0xd3              ;d826  d3          UNKNOWN 0xd3 
    .byte 0x2f              ;d827  2f          UNKNOWN 0x2f '/' 
    .byte 0x02              ;d828  02          UNKNOWN 0x02 
    .byte 0x1f              ;d829  1f          UNKNOWN 0x1f 
    .byte 0x02              ;d82a  02          UNKNOWN 0x02 
    .byte 0x3f              ;d82b  3f          UNKNOWN 0x3f '?' 
    .byte 0xd3              ;d82c  d3          UNKNOWN 0xd3 
    .byte 0x9f              ;d82d  9f          UNKNOWN 0x9f 
    .byte 0xd3              ;d82e  d3          UNKNOWN 0xd3 
    .byte 0xdf              ;d82f  df          UNKNOWN 0xdf 
    .byte 0x81              ;d830  81          UNKNOWN 0x81 
    .byte 0xa5              ;d831  a5          UNKNOWN 0xa5 
    .byte 0x35              ;d832  35          UNKNOWN 0x35 '5' 
    .byte 0xc9              ;d833  c9          UNKNOWN 0xc9 
    .byte 0x05              ;d834  05          UNKNOWN 0x05 
    .byte 0xb0              ;d835  b0          UNKNOWN 0xb0 
    .byte 0x02              ;d836  02          UNKNOWN 0x02 
    .byte 0xa9              ;d837  a9          UNKNOWN 0xa9 
    .byte 0xff              ;d838  ff          UNKNOWN 0xff 
    .byte 0xc9              ;d839  c9          UNKNOWN 0xc9 
    .byte 0xe4              ;d83a  e4          UNKNOWN 0xe4 
    .byte 0x90              ;d83b  90          UNKNOWN 0x90 
    .byte 0x02              ;d83c  02          UNKNOWN 0x02 
    .byte 0xa9              ;d83d  a9          UNKNOWN 0xa9 
    .byte 0xff              ;d83e  ff          UNKNOWN 0xff 
    .byte 0x85              ;d83f  85          UNKNOWN 0x85 
    .byte 0xcf              ;d840  cf          UNKNOWN 0xcf 
    .byte 0x44              ;d841  44          UNKNOWN 0x44 'D' 
    .byte 0xcf              ;d842  cf          UNKNOWN 0xcf 
    .byte 0xa5              ;d843  a5          UNKNOWN 0xa5 
    .byte 0xd0              ;d844  d0          UNKNOWN 0xd0 
    .byte 0xc9              ;d845  c9          UNKNOWN 0xc9 
    .byte 0xe4              ;d846  e4          UNKNOWN 0xe4 
    .byte 0x90              ;d847  90          UNKNOWN 0x90 
    .byte 0x02              ;d848  02          UNKNOWN 0x02 

sub_d849:
    lda #0x00               ;d849  a9 00    
    cmp #0x05               ;d84b  c9 05    
    bcs lab_d851            ;d84d  b0 02    
    lda #0x00               ;d84f  a9 00    

lab_d851:
    sta mem_00ce            ;d851  85 ce    
    rts                     ;d853  60       

    .byte 0x48              ;d854  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;d855  8a          UNKNOWN 0x8a 
    .byte 0x48              ;d856  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;d857  98          UNKNOWN 0x98 
    .byte 0x48              ;d858  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d859  a5          UNKNOWN 0xa5 
    .byte 0xf7              ;d85a  f7          UNKNOWN 0xf7 
    .byte 0x48              ;d85b  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d85c  a5          UNKNOWN 0xa5 
    .byte 0xf8              ;d85d  f8          UNKNOWN 0xf8 
    .byte 0x48              ;d85e  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;d85f  a5          UNKNOWN 0xa5 
    .byte 0xf9              ;d860  f9          UNKNOWN 0xf9 
    .byte 0x48              ;d861  48          UNKNOWN 0x48 'H' 

sub_d862:
    lda mem_00fa            ;d862  a5 fa    
    pha                     ;d864  48       
    jsr 0xd978              ;d865  20 78 d9 
    jsr 0xdae1              ;d868  20 e1 da 
    jsr sub_d971            ;d86b  20 71 d9 
    bbc 7,mem_0080,lab_d876 ;d86e  f7 80 05 

lab_d871:
    jsr sub_d0d6            ;d871  20 d6 d0 
    seb 4,ADCON             ;d874  8f 34    

lab_d876:
    bbc 7,mem_0050,lab_d889 ;d876  f7 50 10 
    bbc 7,mem_00d3,lab_d880 ;d879  f7 d3 04 
    seb 4,ADCON             ;d87c  8f 34    
    seb 6,mem_0080          ;d87e  cf 80    

lab_d880:
    dec mem_00a1            ;d880  c6 a1    
    lda mem_00a1            ;d882  a5 a1    
    bne lab_d8cf            ;d884  d0 49    
    ldm #0x0a,mem_00a1      ;d886  3c 0a a1 

lab_d889:
    jsr sub_d9b5            ;d889  20 b5 d9 
    jsr sub_db2f            ;d88c  20 2f db 
    jsr 0xd9c0              ;d88f  20 c0 d9 
    jsr sub_d9cb            ;d892  20 cb d9 
    lda mem_00a2            ;d895  a5 a2    

sub_d897:
    dec a                   ;d897  1a       
    sta mem_00a2            ;d898  85 a2    
    beq lab_d8a9            ;d89a  f0 0d    
    cmp #0x02               ;d89c  c9 02    
    beq lab_d8cf            ;d89e  f0 2f    
    lda mem_00a4            ;d8a0  a5 a4    
    bne lab_d8cf            ;d8a2  d0 2b    
    jsr sub_d1cd            ;d8a4  20 cd d1 
    bra lab_d8cf            ;d8a7  80 26    

lab_d8a9:
    ldm #0x04,mem_00a2      ;d8a9  3c 04 a2 
    seb 7,mem_0095          ;d8ac  ef 95    
    jsr sub_d9e8            ;d8ae  20 e8 d9 
    jsr 0xd9f1              ;d8b1  20 f1 d9 
    jsr sub_d9fc            ;d8b4  20 fc d9 
    jsr sub_da07            ;d8b7  20 07 da 
    jsr 0xda11              ;d8ba  20 11 da 
    dec mem_00a3            ;d8bd  c6 a3    
    lda mem_00a3            ;d8bf  a5 a3    
    bne lab_d8cf            ;d8c1  d0 0c    
    ldm #0x3c,mem_00a3      ;d8c3  3c 3c a3 
    jsr 0xdabc              ;d8c6  20 bc da 
    jsr 0xdac5              ;d8c9  20 c5 da 
    jsr 0xdad0              ;d8cc  20 d0 da 

lab_d8cf:
    bbc 6,mem_0080,lab_d8d5 ;d8cf  d7 80 03 
    jsr sub_db94            ;d8d2  20 94 db 

lab_d8d5:
    bbc 7,mem_0080,lab_d8df ;d8d5  f7 80 07 
    clb 7,mem_0080          ;d8d8  ff 80    
    seb 0,mem_0080          ;d8da  0f 80    
    jsr sub_d74a            ;d8dc  20 4a d7 

lab_d8df:
    pla                     ;d8df  68       
    sta mem_00fa            ;d8e0  85 fa    
    pla                     ;d8e2  68       
    sta mem_00f9            ;d8e3  85 f9    
    pla                     ;d8e5  68       
    sta mem_00f8            ;d8e6  85 f8    
    pla                     ;d8e8  68       
    sta mem_00f7            ;d8e9  85 f7    
    pla                     ;d8eb  68       
    tay                     ;d8ec  a8       
    pla                     ;d8ed  68       
    tax                     ;d8ee  aa       
    pla                     ;d8ef  68       
    rti                     ;d8f0  40       

    .byte 0xa5              ;d8f1  a5          UNKNOWN 0xa5 
    .byte 0xa9              ;d8f2  a9          UNKNOWN 0xa9 
    .byte 0xf0              ;d8f3  f0          UNKNOWN 0xf0 
    .byte 0x02              ;d8f4  02          UNKNOWN 0x02 
    .byte 0xc6              ;d8f5  c6          UNKNOWN 0xc6 
    .byte 0xa9              ;d8f6  a9          UNKNOWN 0xa9 
    .byte 0x60              ;d8f7  60          UNKNOWN 0x60 '`' 
    .byte 0xf7              ;d8f8  f7          UNKNOWN 0xf7 
    .byte 0x50              ;d8f9  50          UNKNOWN 0x50 'P' 
    .byte 0x24              ;d8fa  24          UNKNOWN 0x24 '$' 
    .byte 0xc7              ;d8fb  c7          UNKNOWN 0xc7 
    .byte 0x19              ;d8fc  19          UNKNOWN 0x19 
    .byte 0x0b              ;d8fd  0b          UNKNOWN 0x0b 
    .byte 0xa7              ;d8fe  a7          UNKNOWN 0xa7 
    .byte 0x19              ;d8ff  19          UNKNOWN 0x19 
    .byte 0x08              ;d900  08          UNKNOWN 0x08 
    .byte 0x87              ;d901  87          UNKNOWN 0x87 
    .byte 0x19              ;d902  19          UNKNOWN 0x19 
    .byte 0x05              ;d903  05          UNKNOWN 0x05 
    .byte 0x67              ;d904  67          UNKNOWN 0x67 'g' 
    .byte 0x19              ;d905  19          UNKNOWN 0x19 
    .byte 0x02              ;d906  02          UNKNOWN 0x02 
    .byte 0x80              ;d907  80          UNKNOWN 0x80 
    .byte 0x16              ;d908  16          UNKNOWN 0x16 
    .byte 0xff              ;d909  ff          UNKNOWN 0xff 
    .byte 0x1a              ;d90a  1a          UNKNOWN 0x1a 
    .byte 0x9f              ;d90b  9f          UNKNOWN 0x9f 
    .byte 0x1a              ;d90c  1a          UNKNOWN 0x1a 
    .byte 0xbf              ;d90d  bf          UNKNOWN 0xbf 
    .byte 0x1a              ;d90e  1a          UNKNOWN 0x1a 
    .byte 0xdf              ;d90f  df          UNKNOWN 0xdf 
    .byte 0x19              ;d910  19          UNKNOWN 0x19 
    .byte 0xbf              ;d911  bf          UNKNOWN 0xbf 
    .byte 0x19              ;d912  19          UNKNOWN 0x19 
    .byte 0x9f              ;d913  9f          UNKNOWN 0x9f 
    .byte 0x19              ;d914  19          UNKNOWN 0x19 
    .byte 0x7f              ;d915  7f          UNKNOWN 0x7f 
    .byte 0x19              ;d916  19          UNKNOWN 0x19 
    .byte 0xef              ;d917  ef          UNKNOWN 0xef 
    .byte 0x1a              ;d918  1a          UNKNOWN 0x1a 
    .byte 0x8f              ;d919  8f          UNKNOWN 0x8f 
    .byte 0x1a              ;d91a  1a          UNKNOWN 0x1a 
    .byte 0xaf              ;d91b  af          UNKNOWN 0xaf 
    .byte 0x1a              ;d91c  1a          UNKNOWN 0x1a 
    .byte 0x80              ;d91d  80          UNKNOWN 0x80 
    .byte 0x00              ;d91e  00          UNKNOWN 0x00 
    .byte 0xad              ;d91f  ad          UNKNOWN 0xad 
    .byte 0x3b              ;d920  3b          UNKNOWN 0x3b ';' 
    .byte 0x01              ;d921  01          UNKNOWN 0x01 
    .byte 0xd0              ;d922  d0          UNKNOWN 0xd0 
    .byte 0x19              ;d923  19          UNKNOWN 0x19 
    .byte 0xad              ;d924  ad          UNKNOWN 0xad 
    .byte 0x3c              ;d925  3c          UNKNOWN 0x3c '<' 
    .byte 0x01              ;d926  01          UNKNOWN 0x01 
    .byte 0xd0              ;d927  d0          UNKNOWN 0xd0 
    .byte 0x14              ;d928  14          UNKNOWN 0x14 
    .byte 0xba              ;d929  ba          UNKNOWN 0xba 
    .byte 0xe0              ;d92a  e0          UNKNOWN 0xe0 
    .byte 0x3b              ;d92b  3b          UNKNOWN 0x3b ';' 
    .byte 0xb0              ;d92c  b0          UNKNOWN 0xb0 
    .byte 0x02              ;d92d  02          UNKNOWN 0x02 
    .byte 0x80              ;d92e  80          UNKNOWN 0x80 
    .byte 0x0d              ;d92f  0d          UNKNOWN 0x0d 
    .byte 0xa5              ;d930  a5          UNKNOWN 0xa5 
    .byte 0xa0              ;d931  a0          UNKNOWN 0xa0 
    .byte 0xd0              ;d932  d0          UNKNOWN 0xd0 
    .byte 0x09              ;d933  09          UNKNOWN 0x09 
    .byte 0x60              ;d934  60          UNKNOWN 0x60 '`' 
    .byte 0xc7              ;d935  c7          UNKNOWN 0xc7 
    .byte 0xc1              ;d936  c1          UNKNOWN 0xc1 
    .byte 0x04              ;d937  04          UNKNOWN 0x04 
    .byte 0xc6              ;d938  c6          UNKNOWN 0xc6 
    .byte 0xe9              ;d939  e9          UNKNOWN 0xe9 
    .byte 0xf0              ;d93a  f0          UNKNOWN 0xf0 
    .byte 0x01              ;d93b  01          UNKNOWN 0x01 
    .byte 0x60              ;d93c  60          UNKNOWN 0x60 '`' 
    .byte 0x4c              ;d93d  4c          UNKNOWN 0x4c 'L' 
    .byte 0xb1              ;d93e  b1          UNKNOWN 0xb1 
    .byte 0xe6              ;d93f  e6          UNKNOWN 0xe6 
    .byte 0xc6              ;d940  c6          UNKNOWN 0xc6 
    .byte 0x96              ;d941  96          UNKNOWN 0x96 
    .byte 0xf0              ;d942  f0          UNKNOWN 0xf0 
    .byte 0x01              ;d943  01          UNKNOWN 0x01 
    .byte 0x60              ;d944  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;d945  3c          UNKNOWN 0x3c '<' 
    .byte 0x08              ;d946  08          UNKNOWN 0x08 
    .byte 0x96              ;d947  96          UNKNOWN 0x96 
    .byte 0xcf              ;d948  cf          UNKNOWN 0xcf 
    .byte 0x95              ;d949  95          UNKNOWN 0x95 
    .byte 0x60              ;d94a  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d94b  a5          UNKNOWN 0xa5 
    .byte 0x9b              ;d94c  9b          UNKNOWN 0x9b 
    .byte 0xf0              ;d94d  f0          UNKNOWN 0xf0 
    .byte 0x06              ;d94e  06          UNKNOWN 0x06 
    .byte 0xc6              ;d94f  c6          UNKNOWN 0xc6 
    .byte 0x9b              ;d950  9b          UNKNOWN 0x9b 
    .byte 0xd0              ;d951  d0          UNKNOWN 0xd0 
    .byte 0x02              ;d952  02          UNKNOWN 0x02 
    .byte 0x2f              ;d953  2f          UNKNOWN 0x2f '/' 
    .byte 0x95              ;d954  95          UNKNOWN 0x95 
    .byte 0xa5              ;d955  a5          UNKNOWN 0xa5 
    .byte 0xa7              ;d956  a7          UNKNOWN 0xa7 
    .byte 0xf0              ;d957  f0          UNKNOWN 0xf0 
    .byte 0x02              ;d958  02          UNKNOWN 0x02 
    .byte 0xc6              ;d959  c6          UNKNOWN 0xc6 
    .byte 0xa7              ;d95a  a7          UNKNOWN 0xa7 
    .byte 0xa5              ;d95b  a5          UNKNOWN 0xa5 
    .byte 0xa8              ;d95c  a8          UNKNOWN 0xa8 
    .byte 0xf0              ;d95d  f0          UNKNOWN 0xf0 
    .byte 0x02              ;d95e  02          UNKNOWN 0x02 
    .byte 0xc6              ;d95f  c6          UNKNOWN 0xc6 
    .byte 0xa8              ;d960  a8          UNKNOWN 0xa8 
    .byte 0xa5              ;d961  a5          UNKNOWN 0xa5 
    .byte 0xa4              ;d962  a4          UNKNOWN 0xa4 
    .byte 0xf0              ;d963  f0          UNKNOWN 0xf0 
    .byte 0x02              ;d964  02          UNKNOWN 0x02 
    .byte 0xc6              ;d965  c6          UNKNOWN 0xc6 
    .byte 0xa4              ;d966  a4          UNKNOWN 0xa4 
    .byte 0x60              ;d967  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;d968  a5          UNKNOWN 0xa5 
    .byte 0xa6              ;d969  a6          UNKNOWN 0xa6 
    .byte 0xf0              ;d96a  f0          UNKNOWN 0xf0 
    .byte 0x04              ;d96b  04          UNKNOWN 0x04 
    .byte 0xc6              ;d96c  c6          UNKNOWN 0xc6 
    .byte 0xa6              ;d96d  a6          UNKNOWN 0xa6 
    .byte 0xd0              ;d96e  d0          UNKNOWN 0xd0 
    .byte 0x00              ;d96f  00          UNKNOWN 0x00 
    .byte 0x60              ;d970  60          UNKNOWN 0x60 '`' 

sub_d971:
    lda mem_0099            ;d971  a5 99    
    beq lab_d97b            ;d973  f0 06    
    dec mem_0099            ;d975  c6 99    
    bne lab_d97b            ;d977  d0 02    
    seb 3,mem_0095          ;d979  6f 95    

lab_d97b:
    rts                     ;d97b  60       

    .byte 0xa5              ;d97c  a5          UNKNOWN 0xa5 
    .byte 0x9a              ;d97d  9a          UNKNOWN 0x9a 
    .byte 0xf0              ;d97e  f0          UNKNOWN 0xf0 
    .byte 0x06              ;d97f  06          UNKNOWN 0x06 
    .byte 0xc6              ;d980  c6          UNKNOWN 0xc6 
    .byte 0x9a              ;d981  9a          UNKNOWN 0x9a 
    .byte 0xd0              ;d982  d0          UNKNOWN 0xd0 
    .byte 0x02              ;d983  02          UNKNOWN 0x02 
    .byte 0x4f              ;d984  4f          UNKNOWN 0x4f 'O' 
    .byte 0x95              ;d985  95          UNKNOWN 0x95 
    .byte 0x60              ;d986  60          UNKNOWN 0x60 '`' 
    .byte 0xc6              ;d987  c6          UNKNOWN 0xc6 
    .byte 0x97              ;d988  97          UNKNOWN 0x97 
    .byte 0xd0              ;d989  d0          UNKNOWN 0xd0 
    .byte 0x05              ;d98a  05          UNKNOWN 0x05 
    .byte 0xaf              ;d98b  af          UNKNOWN 0xaf 
    .byte 0x95              ;d98c  95          UNKNOWN 0x95 
    .byte 0x3c              ;d98d  3c          UNKNOWN 0x3c '<' 
    .byte 0x3c              ;d98e  3c          UNKNOWN 0x3c '<' 
    .byte 0x97              ;d98f  97          UNKNOWN 0x97 
    .byte 0x60              ;d990  60          UNKNOWN 0x60 '`' 
    .byte 0xe6              ;d991  e6          UNKNOWN 0xe6 
    .byte 0x9f              ;d992  9f          UNKNOWN 0x9f 
    .byte 0xa5              ;d993  a5          UNKNOWN 0xa5 
    .byte 0x9f              ;d994  9f          UNKNOWN 0x9f 
    .byte 0xc9              ;d995  c9          UNKNOWN 0xc9 
    .byte 0x3c              ;d996  3c          UNKNOWN 0x3c '<' 
    .byte 0xd0              ;d997  d0          UNKNOWN 0xd0 
    .byte 0x33              ;d998  33          UNKNOWN 0x33 '3' 
    .byte 0x3c              ;d999  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;d99a  00          UNKNOWN 0x00 
    .byte 0x9f              ;d99b  9f          UNKNOWN 0x9f 
    .byte 0xe6              ;d99c  e6          UNKNOWN 0xe6 
    .byte 0x9e              ;d99d  9e          UNKNOWN 0x9e 
    .byte 0xa5              ;d99e  a5          UNKNOWN 0xa5 
    .byte 0x9e              ;d99f  9e          UNKNOWN 0x9e 
    .byte 0xc9              ;d9a0  c9          UNKNOWN 0xc9 
    .byte 0x3c              ;d9a1  3c          UNKNOWN 0x3c '<' 
    .byte 0xd0              ;d9a2  d0          UNKNOWN 0xd0 
    .byte 0x28              ;d9a3  28          UNKNOWN 0x28 '(' 
    .byte 0x3c              ;d9a4  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;d9a5  00          UNKNOWN 0x00 
    .byte 0x9e              ;d9a6  9e          UNKNOWN 0x9e 
    .byte 0xe6              ;d9a7  e6          UNKNOWN 0xe6 
    .byte 0x9d              ;d9a8  9d          UNKNOWN 0x9d 
    .byte 0xa5              ;d9a9  a5          UNKNOWN 0xa5 
    .byte 0x9d              ;d9aa  9d          UNKNOWN 0x9d 
    .byte 0xc9              ;d9ab  c9          UNKNOWN 0xc9 
    .byte 0x18              ;d9ac  18          UNKNOWN 0x18 
    .byte 0xd0              ;d9ad  d0          UNKNOWN 0xd0 
    .byte 0x1d              ;d9ae  1d          UNKNOWN 0x1d 
    .byte 0x3c              ;d9af  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;d9b0  00          UNKNOWN 0x00 
    .byte 0x9d              ;d9b1  9d          UNKNOWN 0x9d 
    .byte 0x08              ;d9b2  08          UNKNOWN 0x08 
    .byte 0xa5              ;d9b3  a5          UNKNOWN 0xa5 
    .byte 0xe6              ;d9b4  e6          UNKNOWN 0xe6 

sub_d9b5:
    beq lab_d9ca            ;d9b5  f0 13    
    dec mem_00e6            ;d9b7  c6 e6    
    bne lab_d9ca            ;d9b9  d0 0f    
    lda mem_0073            ;d9bb  a5 73    
    cmp #0x10               ;d9bd  c9 10    
    beq lab_d9c7            ;d9bf  f0 06    
    cmp #0x20               ;d9c1  c9 20    
    bcs lab_d9c7            ;d9c3  b0 02    
    bra lab_d9ca            ;d9c5  80 03    

lab_d9c7:
    jsr sub_ce4a            ;d9c7  20 4a ce 

lab_d9ca:
    plp                     ;d9ca  28       

sub_d9cb:
    nop                     ;d9cb  ea       
    bbc 1,mem_00bf,lab_da3b ;d9cc  37 bf 6c 
    bbc 5,mem_00bf,lab_da3b ;d9cf  b7 bf 69 
    bbs 0,mem_00bf,lab_da16 ;d9d2  07 bf 41 
    lda mem_009f            ;d9d5  a5 9f    
    bne lab_da3b            ;d9d7  d0 62    
    lda mem_0119            ;d9d9  ad 19 01 
    clc                     ;d9dc  18       
    sbc #0x00               ;d9dd  e9 00    
    bcs lab_d9e3            ;d9df  b0 02    
    lda #0x3b               ;d9e1  a9 3b    

lab_d9e3:
    sta mem_0119            ;d9e3  8d 19 01 
    bcs lab_da3b            ;d9e6  b0 53    

sub_d9e8:
    lda mem_0118            ;d9e8  ad 18 01 
    clc                     ;d9eb  18       
    sbc #0x00               ;d9ec  e9 00    
    bcs lab_d9f2            ;d9ee  b0 02    
    lda #0x17               ;d9f0  a9 17    

lab_d9f2:
    sta mem_0118            ;d9f2  8d 18 01 
    bcs lab_da3b            ;d9f5  b0 44    
    lda mem_0116            ;d9f7  ad 16 01 
    bne lab_da01            ;d9fa  d0 05    

sub_d9fc:
    ldx mem_0117            ;d9fc  ae 17 01 
    beq lab_da12            ;d9ff  f0 11    

lab_da01:
    clc                     ;da01  18       
    sbc #0x00               ;da02  e9 00    
    sta mem_0116            ;da04  8d 16 01 

sub_da07:
    lda mem_0117            ;da07  ad 17 01 
    sbc #0x00               ;da0a  e9 00    
    lda mem_0117            ;da0c  ad 17 01 
    jmp lab_dabb            ;da0f  4c bb da 

lab_da12:
    clb 1,mem_00bf          ;da12  3f bf    
    bra lab_da2d            ;da14  80 17    

lab_da16:
    lda mem_0118            ;da16  ad 18 01 
    cmp mem_009d            ;da19  c5 9d    
    bne lab_da3b            ;da1b  d0 1e    
    lda mem_0119            ;da1d  ad 19 01 
    cmp mem_009e            ;da20  c5 9e    
    bne lab_da3b            ;da22  d0 17    
    lda mem_009f            ;da24  a5 9f    
    bne lab_da3b            ;da26  d0 13    
    bbs 0,mem_00bf,lab_da2d ;da28  07 bf 02 
    clb 1,mem_00bf          ;da2b  3f bf    

lab_da2d:
    bbs 5,mem_0050,lab_da37 ;da2d  a7 50 07 
    clb 7,P5                ;da30  ff 0a    
    nop                     ;da32  ea       
    seb 7,P5                ;da33  ef 0a    
    bra lab_da3b            ;da35  80 04    

lab_da37:
    seb 5,P5                ;da37  af 0a    
    clb 5,P5                ;da39  bf 0a    

lab_da3b:
    rts                     ;da3b  60       

    .byte 0xa5              ;da3c  a5          UNKNOWN 0xa5 
    .byte 0xa5              ;da3d  a5          UNKNOWN 0xa5 
    .byte 0xf0              ;da3e  f0          UNKNOWN 0xf0 
    .byte 0x04              ;da3f  04          UNKNOWN 0x04 
    .byte 0xc6              ;da40  c6          UNKNOWN 0xc6 
    .byte 0xa5              ;da41  a5          UNKNOWN 0xa5 
    .byte 0xd0              ;da42  d0          UNKNOWN 0xd0 
    .byte 0x00              ;da43  00          UNKNOWN 0x00 
    .byte 0x60              ;da44  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;da45  a5          UNKNOWN 0xa5 
    .byte 0x9c              ;da46  9c          UNKNOWN 0x9c 
    .byte 0xf0              ;da47  f0          UNKNOWN 0xf0 
    .byte 0x06              ;da48  06          UNKNOWN 0x06 
    .byte 0xc6              ;da49  c6          UNKNOWN 0xc6 
    .byte 0x9c              ;da4a  9c          UNKNOWN 0x9c 
    .byte 0xd0              ;da4b  d0          UNKNOWN 0xd0 
    .byte 0x02              ;da4c  02          UNKNOWN 0x02 
    .byte 0x0f              ;da4d  0f          UNKNOWN 0x0f 
    .byte 0x95              ;da4e  95          UNKNOWN 0x95 
    .byte 0x60              ;da4f  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;da50  a5          UNKNOWN 0xa5 
    .byte 0x98              ;da51  98          UNKNOWN 0x98 
    .byte 0xf0              ;da52  f0          UNKNOWN 0xf0 
    .byte 0x06              ;da53  06          UNKNOWN 0x06 
    .byte 0xc6              ;da54  c6          UNKNOWN 0xc6 
    .byte 0x98              ;da55  98          UNKNOWN 0x98 
    .byte 0xd0              ;da56  d0          UNKNOWN 0xd0 
    .byte 0x02              ;da57  02          UNKNOWN 0x02 
    .byte 0x8f              ;da58  8f          UNKNOWN 0x8f 
    .byte 0x95              ;da59  95          UNKNOWN 0x95 
    .byte 0xa5              ;da5a  a5          UNKNOWN 0xa5 
    .byte 0xf4              ;da5b  f4          UNKNOWN 0xf4 
    .byte 0xf0              ;da5c  f0          UNKNOWN 0xf0 
    .byte 0x02              ;da5d  02          UNKNOWN 0x02 
    .byte 0xc6              ;da5e  c6          UNKNOWN 0xc6 
    .byte 0xf4              ;da5f  f4          UNKNOWN 0xf4 
    .byte 0x60              ;da60  60          UNKNOWN 0x60 '`' 
    .byte 0x17              ;da61  17          UNKNOWN 0x17 
    .byte 0x82              ;da62  82          UNKNOWN 0x82 
    .byte 0x04              ;da63  04          UNKNOWN 0x04 
    .byte 0x1f              ;da64  1f          UNKNOWN 0x1f 
    .byte 0x82              ;da65  82          UNKNOWN 0x82 
    .byte 0x80              ;da66  80          UNKNOWN 0x80 
    .byte 0x08              ;da67  08          UNKNOWN 0x08 
    .byte 0xa5              ;da68  a5          UNKNOWN 0xa5 
    .byte 0x8f              ;da69  8f          UNKNOWN 0x8f 
    .byte 0xf0              ;da6a  f0          UNKNOWN 0xf0 
    .byte 0x42              ;da6b  42          UNKNOWN 0x42 'B' 
    .byte 0xc6              ;da6c  c6          UNKNOWN 0xc6 
    .byte 0x8f              ;da6d  8f          UNKNOWN 0x8f 
    .byte 0xd0              ;da6e  d0          UNKNOWN 0xd0 
    .byte 0x3e              ;da6f  3e          UNKNOWN 0x3e '>' 
    .byte 0xa0              ;da70  a0          UNKNOWN 0xa0 
    .byte 0x00              ;da71  00          UNKNOWN 0x00 
    .byte 0xb1              ;da72  b1          UNKNOWN 0xb1 
    .byte 0x90              ;da73  90          UNKNOWN 0x90 
    .byte 0x85              ;da74  85          UNKNOWN 0x85 
    .byte 0x20              ;da75  20          UNKNOWN 0x20 ' ' 
    .byte 0xc8              ;da76  c8          UNKNOWN 0xc8 
    .byte 0xd1              ;da77  d1          UNKNOWN 0xd1 
    .byte 0x90              ;da78  90          UNKNOWN 0x90 
    .byte 0xd0              ;da79  d0          UNKNOWN 0xd0 
    .byte 0x08              ;da7a  08          UNKNOWN 0x08 
    .byte 0xc9              ;da7b  c9          UNKNOWN 0xc9 
    .byte 0xff              ;da7c  ff          UNKNOWN 0xff 
    .byte 0xf0              ;da7d  f0          UNKNOWN 0xf0 
    .byte 0x11              ;da7e  11          UNKNOWN 0x11 
    .byte 0xc9              ;da7f  c9          UNKNOWN 0xc9 
    .byte 0x00              ;da80  00          UNKNOWN 0x00 
    .byte 0xf0              ;da81  f0          UNKNOWN 0xf0 
    .byte 0x14              ;da82  14          UNKNOWN 0x14 
    .byte 0xb1              ;da83  b1          UNKNOWN 0xb1 
    .byte 0x90              ;da84  90          UNKNOWN 0x90 
    .byte 0x85              ;da85  85          UNKNOWN 0x85 
    .byte 0x21              ;da86  21          UNKNOWN 0x21 '!' 
    .byte 0xc8              ;da87  c8          UNKNOWN 0xc8 
    .byte 0xb1              ;da88  b1          UNKNOWN 0xb1 
    .byte 0x90              ;da89  90          UNKNOWN 0x90 
    .byte 0x85              ;da8a  85          UNKNOWN 0x85 
    .byte 0x8f              ;da8b  8f          UNKNOWN 0x8f 
    .byte 0xff              ;da8c  ff          UNKNOWN 0xff 
    .byte 0x27              ;da8d  27          UNKNOWN 0x27 ''' 
    .byte 0x80              ;da8e  80          UNKNOWN 0x80 
    .byte 0x11              ;da8f  11          UNKNOWN 0x11 
    .byte 0x3c              ;da90  3c          UNKNOWN 0x3c '<' 
    .byte 0xee              ;da91  ee          UNKNOWN 0xee 
    .byte 0x21              ;da92  21          UNKNOWN 0x21 '!' 
    .byte 0xef              ;da93  ef          UNKNOWN 0xef 
    .byte 0x27              ;da94  27          UNKNOWN 0x27 ''' 
    .byte 0x80              ;da95  80          UNKNOWN 0x80 
    .byte 0x17              ;da96  17          UNKNOWN 0x17 
    .byte 0x3c              ;da97  3c          UNKNOWN 0x3c '<' 
    .byte 0xee              ;da98  ee          UNKNOWN 0xee 
    .byte 0x21              ;da99  21          UNKNOWN 0x21 '!' 
    .byte 0xc8              ;da9a  c8          UNKNOWN 0xc8 
    .byte 0xb1              ;da9b  b1          UNKNOWN 0xb1 
    .byte 0x90              ;da9c  90          UNKNOWN 0x90 
    .byte 0x85              ;da9d  85          UNKNOWN 0x85 
    .byte 0x8f              ;da9e  8f          UNKNOWN 0x8f 
    .byte 0xef              ;da9f  ef          UNKNOWN 0xef 
    .byte 0x27              ;daa0  27          UNKNOWN 0x27 ''' 
    .byte 0xc8              ;daa1  c8          UNKNOWN 0xc8 
    .byte 0x98              ;daa2  98          UNKNOWN 0x98 
    .byte 0x18              ;daa3  18          UNKNOWN 0x18 
    .byte 0x65              ;daa4  65          UNKNOWN 0x65 'e' 
    .byte 0x90              ;daa5  90          UNKNOWN 0x90 
    .byte 0x85              ;daa6  85          UNKNOWN 0x85 
    .byte 0x90              ;daa7  90          UNKNOWN 0x90 
    .byte 0xa9              ;daa8  a9          UNKNOWN 0xa9 
    .byte 0x00              ;daa9  00          UNKNOWN 0x00 
    .byte 0x65              ;daaa  65          UNKNOWN 0x65 'e' 
    .byte 0x91              ;daab  91          UNKNOWN 0x91 
    .byte 0x85              ;daac  85          UNKNOWN 0x85 
    .byte 0x91              ;daad  91          UNKNOWN 0x91 
    .byte 0x60              ;daae  60          UNKNOWN 0x60 '`' 
    .byte 0xd7              ;daaf  d7          UNKNOWN 0xd7 
    .byte 0xbf              ;dab0  bf          UNKNOWN 0xbf 
    .byte 0x01              ;dab1  01          UNKNOWN 0x01 
    .byte 0x60              ;dab2  60          UNKNOWN 0x60 '`' 
    .byte 0xf7              ;dab3  f7          UNKNOWN 0xf7 
    .byte 0x82              ;dab4  82          UNKNOWN 0x82 
    .byte 0x04              ;dab5  04          UNKNOWN 0x04 
    .byte 0xff              ;dab6  ff          UNKNOWN 0xff 
    .byte 0x82              ;dab7  82          UNKNOWN 0x82 
    .byte 0x80              ;dab8  80          UNKNOWN 0x80 
    .byte 0x08              ;dab9  08          UNKNOWN 0x08 
    .byte 0xa5              ;daba  a5          UNKNOWN 0xa5 

lab_dabb:
    sty mem_00f0            ;dabb  84 f0    
    ora mem_00c6,x          ;dabd  15 c6    
    sty mem_00d0            ;dabf  84 d0    
    ora [mem_00cf],y        ;dac1  11 cf    
    asl a                   ;dac3  0a       
    ldx mem_0083            ;dac4  a6 83    
    beq lab_daca            ;dac6  f0 02    
    clb 6,P5                ;dac8  df 0a    

lab_daca:
    lda mem_0085,x          ;daca  b5 85    
    sta mem_0084            ;dacc  85 84    
    txa                     ;dace  8a       
    eor #0x01               ;dacf  49 01    
    sta mem_0083            ;dad1  85 83    
    bbc 6,mem_0082,lab_dada ;dad3  d7 82 04 
    clb 6,mem_0082          ;dad6  df 82    
    bra lab_dae2            ;dad8  80 08    

lab_dada:
    lda mem_0088            ;dada  a5 88    
    beq lab_daf3            ;dadc  f0 15    
    dec mem_0088            ;dade  c6 88    
    bne lab_daf3            ;dae0  d0 11    

lab_dae2:
    seb 5,P2                ;dae2  af 04    
    ldx mem_0087            ;dae4  a6 87    
    beq lab_daea            ;dae6  f0 02    
    clb 5,P2                ;dae8  bf 04    

lab_daea:
    lda mem_0089,x          ;daea  b5 89    
    sta mem_0088            ;daec  85 88    
    txa                     ;daee  8a       
    eor #0x01               ;daef  49 01    
    sta mem_0087            ;daf1  85 87    

lab_daf3:
    bbc 5,mem_0082,lab_dafa ;daf3  b7 82 04 
    clb 5,mem_0082          ;daf6  bf 82    
    bra lab_db02            ;daf8  80 08    

lab_dafa:
    lda mem_008c            ;dafa  a5 8c    
    beq lab_db13            ;dafc  f0 15    
    dec mem_008c            ;dafe  c6 8c    
    bne lab_db13            ;db00  d0 11    

lab_db02:
    seb 4,P2                ;db02  8f 04    
    ldx mem_008b            ;db04  a6 8b    
    beq lab_db0a            ;db06  f0 02    
    clb 4,P2                ;db08  9f 04    

lab_db0a:
    lda mem_008d,x          ;db0a  b5 8d    
    sta mem_008c            ;db0c  85 8c    
    txa                     ;db0e  8a       
    eor #0x01               ;db0f  49 01    
    sta mem_008b            ;db11  85 8b    

lab_db13:
    rts                     ;db13  60       

    .byte 0xe7              ;db14  e7          UNKNOWN 0xe7 
    .byte 0xcc              ;db15  cc          UNKNOWN 0xcc 
    .byte 0x06              ;db16  06          UNKNOWN 0x06 
    .byte 0xf7              ;db17  f7          UNKNOWN 0xf7 
    .byte 0xd3              ;db18  d3          UNKNOWN 0xd3 
    .byte 0x03              ;db19  03          UNKNOWN 0x03 
    .byte 0x37              ;db1a  37          UNKNOWN 0x37 '7' 
    .byte 0x08              ;db1b  08          UNKNOWN 0x08 
    .byte 0x01              ;db1c  01          UNKNOWN 0x01 

lab_db1d:
    rts                     ;db1d  60       

    .byte 0x20              ;db1e  20          UNKNOWN 0x20 ' ' 
    .byte 0x3e              ;db1f  3e          UNKNOWN 0x3e '>' 
    .byte 0xd8              ;db20  d8          UNKNOWN 0xd8 
    .byte 0xa5              ;db21  a5          UNKNOWN 0xa5 
    .byte 0xd8              ;db22  d8          UNKNOWN 0xd8 
    .byte 0xd0              ;db23  d0          UNKNOWN 0xd0 
    .byte 0x04              ;db24  04          UNKNOWN 0x04 
    .byte 0xa5              ;db25  a5          UNKNOWN 0xa5 
    .byte 0xd9              ;db26  d9          UNKNOWN 0xd9 
    .byte 0xf0              ;db27  f0          UNKNOWN 0xf0 
    .byte 0x03              ;db28  03          UNKNOWN 0x03 
    .byte 0x77              ;db29  77          UNKNOWN 0x77 'w' 
    .byte 0x95              ;db2a  95          UNKNOWN 0x95 
    .byte 0xf1              ;db2b  f1          UNKNOWN 0xf1 
    .byte 0x27              ;db2c  27          UNKNOWN 0x27 ''' 
    .byte 0xc2              ;db2d  c2          UNKNOWN 0xc2 
    .byte 0x09              ;db2e  09          UNKNOWN 0x09 

sub_db2f:
    jsr sub_dc0d            ;db2f  20 0d dc 
    lda mem_00ce            ;db32  a5 ce    
    bcs lab_db56            ;db34  b0 20    
    bra lab_db48            ;db36  80 10    

    .byte 0xa5              ;db38  a5          UNKNOWN 0xa5 
    .byte 0xcf              ;db39  cf          UNKNOWN 0xcf 
    .byte 0xf0              ;db3a  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;db3b  0c          UNKNOWN 0x0c 
    .byte 0xc9              ;db3c  c9          UNKNOWN 0xc9 
    .byte 0xff              ;db3d  ff          UNKNOWN 0xff 
    .byte 0xf0              ;db3e  f0          UNKNOWN 0xf0 
    .byte 0x08              ;db3f  08          UNKNOWN 0x08 
    .byte 0xa5              ;db40  a5          UNKNOWN 0xa5 
    .byte 0xce              ;db41  ce          UNKNOWN 0xce 
    .byte 0xf0              ;db42  f0          UNKNOWN 0xf0 
    .byte 0x04              ;db43  04          UNKNOWN 0x04 
    .byte 0xc9              ;db44  c9          UNKNOWN 0xc9 
    .byte 0xff              ;db45  ff          UNKNOWN 0xff 
    .byte 0xd0              ;db46  d0          UNKNOWN 0xd0 
    .byte 0x0e              ;db47  0e          UNKNOWN 0x0e 

lab_db48:
    bbc 0,mem_00d5,lab_db1d ;db48  17 d5 d2 
    bbc 0,mem_00c2,lab_db52 ;db4b  17 c2 04 
    dec mem_00d4            ;db4e  c6 d4    
    bne lab_db1d            ;db50  d0 cb    

lab_db52:
    clb 0,mem_00d5          ;db52  1f d5    
    bra lab_db7a            ;db54  80 24    

lab_db56:
    ldm #0x00,mem_00d5      ;db56  3c 00 d5 
    asl a                   ;db59  0a       
    rol mem_00d5            ;db5a  26 d5    
    lsr a                   ;db5c  4a       
    sta mem_00d6            ;db5d  85 d6    
    lda mem_00cf            ;db5f  a5 cf    
    asl a                   ;db61  0a       
    rol mem_00d5            ;db62  26 d5    
    lsr a                   ;db64  4a       
    sta mem_00d7            ;db65  85 d7    
    rol mem_00d5            ;db67  26 d5    
    rol mem_00d5            ;db69  26 d5    
    rol mem_00d5            ;db6b  26 d5    
    seb 7,mem_00d5          ;db6d  ef d5    
    seb 0,mem_00d5          ;db6f  0f d5    
    ldm #0x04,mem_00d4      ;db71  3c 04 d4 
    ldm #0x00,mem_00ce      ;db74  3c 00 ce 
    ldm #0x00,mem_00cf      ;db77  3c 00 cf 

lab_db7a:
    clb 1,IREQ1             ;db7a  3f 3c    
    seb 1,ICON1             ;db7c  2f 3e    
    ldm #0x03,mem_00d0      ;db7e  3c 03 d0 
    ldm #0x00,mem_00d9      ;db81  3c 00 d9 
    ldm #0x04,mem_0099      ;db84  3c 04 99 
    clb 3,mem_0095          ;db87  7f 95    
    jsr sub_dc6f            ;db89  20 6f dc 
    rts                     ;db8c  60       

    .byte 0xa5              ;db8d  a5          UNKNOWN 0xa5 
    .byte 0xcf              ;db8e  cf          UNKNOWN 0xcf 
    .byte 0xf0              ;db8f  f0          UNKNOWN 0xf0 
    .byte 0x48              ;db90  48          UNKNOWN 0x48 'H' 
    .byte 0xc9              ;db91  c9          UNKNOWN 0xc9 
    .byte 0xff              ;db92  ff          UNKNOWN 0xff 
    .byte 0xf0              ;db93  f0          UNKNOWN 0xf0 

sub_db94:
    com mem_00a5            ;db94  44 a5    
    dec mem_40f0            ;db96  ce f0 40 
    cmp #0xff               ;db99  c9 ff    
    beq lab_dbd9            ;db9b  f0 3c    
    lda mem_00d1            ;db9d  a5 d1    
    beq lab_dbcf            ;db9f  f0 2e    
    sec                     ;dba1  38       
    sbc mem_00ce            ;dba2  e5 ce    
    beq lab_dbb2            ;dba4  f0 0c    
    bcc lab_dbae            ;dba6  90 06    
    cmp #0x1e               ;dba8  c9 1e    
    bcs lab_dbcf            ;dbaa  b0 23    
    bra lab_dbb2            ;dbac  80 04    

lab_dbae:
    cmp #0xe1               ;dbae  c9 e1    
    bcc lab_dbcf            ;dbb0  90 1d    

lab_dbb2:
    lda mem_00d2            ;dbb2  a5 d2    
    sec                     ;dbb4  38       
    sbc mem_00cf            ;dbb5  e5 cf    
    beq lab_dbc5            ;dbb7  f0 0c    
    bcc lab_dbc1            ;dbb9  90 06    
    cmp #0x28               ;dbbb  c9 28    
    bcs lab_dbcf            ;dbbd  b0 10    
    bra lab_dbc5            ;dbbf  80 04    

lab_dbc1:
    cmp #0xd7               ;dbc1  c9 d7    
    bcc lab_dbcf            ;dbc3  90 0a    

lab_dbc5:
    lda mem_00cf            ;dbc5  a5 cf    
    sta mem_00d2            ;dbc7  85 d2    
    lda mem_00ce            ;dbc9  a5 ce    
    sta mem_00d1            ;dbcb  85 d1    
    sec                     ;dbcd  38       
    rts                     ;dbce  60       

lab_dbcf:
    lda mem_00cf            ;dbcf  a5 cf    
    sta mem_00d2            ;dbd1  85 d2    
    lda mem_00ce            ;dbd3  a5 ce    
    sta mem_00d1            ;dbd5  85 d1    
    clc                     ;dbd7  18       
    rts                     ;dbd8  60       

lab_dbd9:
    lda #0x00               ;dbd9  a9 00    
    sta mem_00d1            ;dbdb  85 d1    
    sta mem_00d2            ;dbdd  85 d2    
    clc                     ;dbdf  18       
    rts                     ;dbe0  60       

    .byte 0x48              ;dbe1  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;dbe2  8a          UNKNOWN 0x8a 
    .byte 0x48              ;dbe3  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;dbe4  98          UNKNOWN 0x98 
    .byte 0x48              ;dbe5  48          UNKNOWN 0x48 'H' 
    .byte 0x20              ;dbe6  20          UNKNOWN 0x20 ' ' 
    .byte 0x6f              ;dbe7  6f          UNKNOWN 0x6f 'o' 
    .byte 0xdc              ;dbe8  dc          UNKNOWN 0xdc 
    .byte 0x68              ;dbe9  68          UNKNOWN 0x68 'h' 
    .byte 0xa8              ;dbea  a8          UNKNOWN 0xa8 
    .byte 0x68              ;dbeb  68          UNKNOWN 0x68 'h' 
    .byte 0xaa              ;dbec  aa          UNKNOWN 0xaa 
    .byte 0x68              ;dbed  68          UNKNOWN 0x68 'h' 
    .byte 0x40              ;dbee  40          UNKNOWN 0x40 '@' 
    .byte 0xa5              ;dbef  a5          UNKNOWN 0xa5 
    .byte 0xd8              ;dbf0  d8          UNKNOWN 0xd8 
    .byte 0xf0              ;dbf1  f0          UNKNOWN 0xf0 
    .byte 0x0f              ;dbf2  0f          UNKNOWN 0x0f 
    .byte 0xc6              ;dbf3  c6          UNKNOWN 0xc6 
    .byte 0xd8              ;dbf4  d8          UNKNOWN 0xd8 
    .byte 0xa6              ;dbf5  a6          UNKNOWN 0xa6 
    .byte 0xd9              ;dbf6  d9          UNKNOWN 0xd9 
    .byte 0xb5              ;dbf7  b5          UNKNOWN 0xb5 
    .byte 0xd5              ;dbf8  d5          UNKNOWN 0xd5 
    .byte 0x85              ;dbf9  85          UNKNOWN 0x85 
    .byte 0x00              ;dbfa  00          UNKNOWN 0x00 
    .byte 0xbf              ;dbfb  bf          UNKNOWN 0xbf 
    .byte 0x02              ;dbfc  02          UNKNOWN 0x02 
    .byte 0xaf              ;dbfd  af          UNKNOWN 0xaf 
    .byte 0x02              ;dbfe  02          UNKNOWN 0x02 
    .byte 0xe6              ;dbff  e6          UNKNOWN 0xe6 
    .byte 0xd9              ;dc00  d9          UNKNOWN 0xd9 
    .byte 0x60              ;dc01  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;dc02  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;dc03  00          UNKNOWN 0x00 
    .byte 0x00              ;dc04  00          UNKNOWN 0x00 
    .byte 0x3c              ;dc05  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;dc06  00          UNKNOWN 0x00 
    .byte 0xd9              ;dc07  d9          UNKNOWN 0xd9 
    .byte 0x60              ;dc08  60          UNKNOWN 0x60 '`' 
    .byte 0x4c              ;dc09  4c          UNKNOWN 0x4c 'L' 
    .byte 0x01              ;dc0a  01          UNKNOWN 0x01 
    .byte 0xf7              ;dc0b  f7          UNKNOWN 0xf7 
    .byte 0xe1              ;dc0c  e1          UNKNOWN 0xe1 

sub_dc0d:
    cli                     ;dc0d  58       
    ora [mem_00d2,x]        ;dc0e  01 d2    
    cmp mem_0153,x          ;dc10  dd 53 01 
    cmp #0xdd               ;dc13  c9 dd    
    stp                     ;dc15  42       

    .byte 0x02              ;dc16  02          UNKNOWN 0x02 
    .byte 0xdb              ;dc17  db          UNKNOWN 0xdb 
    .byte 0xdd              ;dc18  dd          UNKNOWN 0xdd 
    .byte 0x54              ;dc19  54          UNKNOWN 0x54 'T' 
    .byte 0x07              ;dc1a  07          UNKNOWN 0x07 
    .byte 0x29              ;dc1b  29          UNKNOWN 0x29 ')' 
    .byte 0xde              ;dc1c  de          UNKNOWN 0xde 
    .byte 0x57              ;dc1d  57          UNKNOWN 0x57 'W' 
    .byte 0x08              ;dc1e  08          UNKNOWN 0x08 
    .byte 0x9a              ;dc1f  9a          UNKNOWN 0x9a 
    .byte 0xde              ;dc20  de          UNKNOWN 0xde 
    .byte 0x44              ;dc21  44          UNKNOWN 0x44 'D' 
    .byte 0x04              ;dc22  04          UNKNOWN 0x04 
    .byte 0x5f              ;dc23  5f          UNKNOWN 0x5f '_' 
    .byte 0xdf              ;dc24  df          UNKNOWN 0xdf 
    .byte 0x47              ;dc25  47          UNKNOWN 0x47 'G' 
    .byte 0x02              ;dc26  02          UNKNOWN 0x02 
    .byte 0x92              ;dc27  92          UNKNOWN 0x92 
    .byte 0xdf              ;dc28  df          UNKNOWN 0xdf 
    .byte 0x4d              ;dc29  4d          UNKNOWN 0x4d 'M' 
    .byte 0x02              ;dc2a  02          UNKNOWN 0x02 
    .byte 0xa7              ;dc2b  a7          UNKNOWN 0xa7 
    .byte 0xdf              ;dc2c  df          UNKNOWN 0xdf 
    .byte 0x45              ;dc2d  45          UNKNOWN 0x45 'E' 
    .byte 0x04              ;dc2e  04          UNKNOWN 0x04 
    .byte 0xce              ;dc2f  ce          UNKNOWN 0xce 
    .byte 0xdf              ;dc30  df          UNKNOWN 0xdf 
    .byte 0x46              ;dc31  46          UNKNOWN 0x46 'F' 
    .byte 0x05              ;dc32  05          UNKNOWN 0x05 
    .byte 0x21              ;dc33  21          UNKNOWN 0x21 '!' 
    .byte 0xe0              ;dc34  e0          UNKNOWN 0xe0 
    .byte 0x4b              ;dc35  4b          UNKNOWN 0x4b 'K' 
    .byte 0x01              ;dc36  01          UNKNOWN 0x01 
    .byte 0x54              ;dc37  54          UNKNOWN 0x54 'T' 
    .byte 0xe0              ;dc38  e0          UNKNOWN 0xe0 
    .byte 0x5a              ;dc39  5a          UNKNOWN 0x5a 'Z' 
    .byte 0x04              ;dc3a  04          UNKNOWN 0x04 
    .byte 0x24              ;dc3b  24          UNKNOWN 0x24 '$' 
    .byte 0xe1              ;dc3c  e1          UNKNOWN 0xe1 
    .byte 0x52              ;dc3d  52          UNKNOWN 0x52 'R' 
    .byte 0x07              ;dc3e  07          UNKNOWN 0x07 
    .byte 0xa9              ;dc3f  a9          UNKNOWN 0xa9 
    .byte 0xe1              ;dc40  e1          UNKNOWN 0xe1 
    .byte 0x43              ;dc41  43          UNKNOWN 0x43 'C' 
    .byte 0x08              ;dc42  08          UNKNOWN 0x08 
    .byte 0xaf              ;dc43  af          UNKNOWN 0xaf 
    .byte 0xe0              ;dc44  e0          UNKNOWN 0xe0 
    .byte 0xa0              ;dc45  a0          UNKNOWN 0xa0 
    .byte 0x00              ;dc46  00          UNKNOWN 0x00 
    .byte 0xa5              ;dc47  a5          UNKNOWN 0xa5 
    .byte 0xab              ;dc48  ab          UNKNOWN 0xab 
    .byte 0x1a              ;dc49  1a          UNKNOWN 0x1a 
    .byte 0x1a              ;dc4a  1a          UNKNOWN 0x1a 
    .byte 0x85              ;dc4b  85          UNKNOWN 0x85 
    .byte 0xf9              ;dc4c  f9          UNKNOWN 0xf9 
    .byte 0xb1              ;dc4d  b1          UNKNOWN 0xb1 
    .byte 0xca              ;dc4e  ca          UNKNOWN 0xca 
    .byte 0x99              ;dc4f  99          UNKNOWN 0x99 
    .byte 0xad              ;dc50  ad          UNKNOWN 0xad 
    .byte 0x00              ;dc51  00          UNKNOWN 0x00 
    .byte 0xc8              ;dc52  c8          UNKNOWN 0xc8 
    .byte 0xc6              ;dc53  c6          UNKNOWN 0xc6 
    .byte 0xf9              ;dc54  f9          UNKNOWN 0xf9 
    .byte 0xd0              ;dc55  d0          UNKNOWN 0xd0 
    .byte 0xf6              ;dc56  f6          UNKNOWN 0xf6 
    .byte 0x5f              ;dc57  5f          UNKNOWN 0x5f '_' 
    .byte 0xbf              ;dc58  bf          UNKNOWN 0xbf 
    .byte 0x60              ;dc59  60          UNKNOWN 0x60 '`' 
    .byte 0x57              ;dc5a  57          UNKNOWN 0x57 'W' 
    .byte 0xbf              ;dc5b  bf          UNKNOWN 0xbf 
    .byte 0x08              ;dc5c  08          UNKNOWN 0x08 
    .byte 0x08              ;dc5d  08          UNKNOWN 0x08 
    .byte 0x78              ;dc5e  78          UNKNOWN 0x78 'x' 
    .byte 0x20              ;dc5f  20          UNKNOWN 0x20 ' ' 
    .byte 0xc5              ;dc60  c5          UNKNOWN 0xc5 

lab_dc61:
    .byte 0xdc              ;dc61  dc       Illegal instruction

    .byte 0x4c              ;dc62  4c          UNKNOWN 0x4c 'L' 
    .byte 0x3d              ;dc63  3d          UNKNOWN 0x3d '=' 
    .byte 0xdd              ;dc64  dd          UNKNOWN 0xdd 

lab_dc65:
    rts                     ;dc65  60       

    .byte 0xe7              ;dc66  e7          UNKNOWN 0xe7 
    .byte 0x50              ;dc67  50          UNKNOWN 0x50 'P' 
    .byte 0x12              ;dc68  12          UNKNOWN 0x12 
    .byte 0xc7              ;dc69  c7          UNKNOWN 0xc7 
    .byte 0x50              ;dc6a  50          UNKNOWN 0x50 'P' 
    .byte 0x0a              ;dc6b  0a          UNKNOWN 0x0a 
    .byte 0xa7              ;dc6c  a7          UNKNOWN 0xa7 
    .byte 0x50              ;dc6d  50          UNKNOWN 0x50 'P' 
    .byte 0x02              ;dc6e  02          UNKNOWN 0x02 

sub_dc6f:
    bra lab_dc65            ;dc6f  80 f4    

    .byte 0x27              ;dc71  27          UNKNOWN 0x27 ''' 
    .byte 0xc1              ;dc72  c1          UNKNOWN 0xc1 
    .byte 0x07              ;dc73  07          UNKNOWN 0x07 
    .byte 0x80              ;dc74  80          UNKNOWN 0x80 
    .byte 0xef              ;dc75  ef          UNKNOWN 0xef 
    .byte 0x07              ;dc76  07          UNKNOWN 0x07 
    .byte 0xc1              ;dc77  c1          UNKNOWN 0xc1 
    .byte 0x02              ;dc78  02          UNKNOWN 0x02 
    .byte 0x80              ;dc79  80          UNKNOWN 0x80 
    .byte 0xea              ;dc7a  ea          UNKNOWN 0xea 
    .byte 0xe7              ;dc7b  e7          UNKNOWN 0xe7 
    .byte 0xbf              ;dc7c  bf          UNKNOWN 0xbf 
    .byte 0xdc              ;dc7d  dc          UNKNOWN 0xdc 
    .byte 0x08              ;dc7e  08          UNKNOWN 0x08 
    .byte 0x78              ;dc7f  78          UNKNOWN 0x78 'x' 
    .byte 0xa5              ;dc80  a5          UNKNOWN 0xa5 
    .byte 0x6c              ;dc81  6c          UNKNOWN 0x6c 'l' 
    .byte 0x85              ;dc82  85          UNKNOWN 0x85 
    .byte 0xad              ;dc83  ad          UNKNOWN 0xad 
    .byte 0xad              ;dc84  ad          UNKNOWN 0xad 
    .byte 0x08              ;dc85  08          UNKNOWN 0x08 
    .byte 0x01              ;dc86  01          UNKNOWN 0x01 
    .byte 0x85              ;dc87  85          UNKNOWN 0x85 
    .byte 0xb4              ;dc88  b4          UNKNOWN 0xb4 
    .byte 0xad              ;dc89  ad          UNKNOWN 0xad 
    .byte 0x09              ;dc8a  09          UNKNOWN 0x09 
    .byte 0x01              ;dc8b  01          UNKNOWN 0x01 
    .byte 0x85              ;dc8c  85          UNKNOWN 0x85 
    .byte 0xb7              ;dc8d  b7          UNKNOWN 0xb7 
    .byte 0xa5              ;dc8e  a5          UNKNOWN 0xa5 
    .byte 0x6d              ;dc8f  6d          UNKNOWN 0x6d 'm' 
    .byte 0x85              ;dc90  85          UNKNOWN 0x85 
    .byte 0xae              ;dc91  ae          UNKNOWN 0xae 
    .byte 0x20              ;dc92  20          UNKNOWN 0x20 ' ' 
    .byte 0xe6              ;dc93  e6          UNKNOWN 0xe6 
    .byte 0xd0              ;dc94  d0          UNKNOWN 0xd0 
    .byte 0x85              ;dc95  85          UNKNOWN 0x85 
    .byte 0xaf              ;dc96  af          UNKNOWN 0xaf 
    .byte 0xa5              ;dc97  a5          UNKNOWN 0xa5 
    .byte 0x6e              ;dc98  6e          UNKNOWN 0x6e 'n' 
    .byte 0x85              ;dc99  85          UNKNOWN 0x85 
    .byte 0xb3              ;dc9a  b3          UNKNOWN 0xb3 
    .byte 0xad              ;dc9b  ad          UNKNOWN 0xad 
    .byte 0x06              ;dc9c  06          UNKNOWN 0x06 
    .byte 0x01              ;dc9d  01          UNKNOWN 0x01 
    .byte 0x85              ;dc9e  85          UNKNOWN 0x85 
    .byte 0xb5              ;dc9f  b5          UNKNOWN 0xb5 
    .byte 0xad              ;dca0  ad          UNKNOWN 0xad 
    .byte 0x07              ;dca1  07          UNKNOWN 0x07 
    .byte 0x01              ;dca2  01          UNKNOWN 0x01 
    .byte 0x85              ;dca3  85          UNKNOWN 0x85 
    .byte 0xb8              ;dca4  b8          UNKNOWN 0xb8 
    .byte 0xa5              ;dca5  a5          UNKNOWN 0xa5 
    .byte 0x70              ;dca6  70          UNKNOWN 0x70 'p' 
    .byte 0x85              ;dca7  85          UNKNOWN 0x85 
    .byte 0xb0              ;dca8  b0          UNKNOWN 0xb0 
    .byte 0xa5              ;dca9  a5          UNKNOWN 0xa5 
    .byte 0x71              ;dcaa  71          UNKNOWN 0x71 'q' 
    .byte 0x85              ;dcab  85          UNKNOWN 0x85 
    .byte 0xb1              ;dcac  b1          UNKNOWN 0xb1 
    .byte 0xad              ;dcad  ad          UNKNOWN 0xad 
    .byte 0x0a              ;dcae  0a          UNKNOWN 0x0a 
    .byte 0x01              ;dcaf  01          UNKNOWN 0x01 
    .byte 0x85              ;dcb0  85          UNKNOWN 0x85 
    .byte 0xb6              ;dcb1  b6          UNKNOWN 0xb6 
    .byte 0xad              ;dcb2  ad          UNKNOWN 0xad 
    .byte 0x0b              ;dcb3  0b          UNKNOWN 0x0b 
    .byte 0x01              ;dcb4  01          UNKNOWN 0x01 
    .byte 0x85              ;dcb5  85          UNKNOWN 0x85 
    .byte 0xb9              ;dcb6  b9          UNKNOWN 0xb9 
    .byte 0xa5              ;dcb7  a5          UNKNOWN 0xa5 
    .byte 0x72              ;dcb8  72          UNKNOWN 0x72 'r' 
    .byte 0x85              ;dcb9  85          UNKNOWN 0x85 
    .byte 0xb2              ;dcba  b2          UNKNOWN 0xb2 
    .byte 0xef              ;dcbb  ef          UNKNOWN 0xef 
    .byte 0xae              ;dcbc  ae          UNKNOWN 0xae 
    .byte 0xa2              ;dcbd  a2          UNKNOWN 0xa2 
    .byte 0x00              ;dcbe  00          UNKNOWN 0x00 
    .byte 0xa5              ;dcbf  a5          UNKNOWN 0xa5 
    .byte 0xab              ;dcc0  ab          UNKNOWN 0xab 
    .byte 0x3a              ;dcc1  3a          UNKNOWN 0x3a ':' 
    .byte 0x85              ;dcc2  85          UNKNOWN 0x85 
    .byte 0xf9              ;dcc3  f9          UNKNOWN 0xf9 
    .byte 0xa9              ;dcc4  a9          UNKNOWN 0xa9 
    .byte 0x00              ;dcc5  00          UNKNOWN 0x00 
    .byte 0x18              ;dcc6  18          UNKNOWN 0x18 
    .byte 0x75              ;dcc7  75          UNKNOWN 0x75 'u' 
    .byte 0xaa              ;dcc8  aa          UNKNOWN 0xaa 
    .byte 0xe8              ;dcc9  e8          UNKNOWN 0xe8 
    .byte 0xc6              ;dcca  c6          UNKNOWN 0xc6 
    .byte 0xf9              ;dccb  f9          UNKNOWN 0xf9 
    .byte 0xd0              ;dccc  d0          UNKNOWN 0xd0 
    .byte 0xf8              ;dccd  f8          UNKNOWN 0xf8 
    .byte 0x85              ;dcce  85          UNKNOWN 0x85 
    .byte 0xba              ;dccf  ba          UNKNOWN 0xba 
    .byte 0xa5              ;dcd0  a5          UNKNOWN 0xa5 
    .byte 0xab              ;dcd1  ab          UNKNOWN 0xab 
    .byte 0x3a              ;dcd2  3a          UNKNOWN 0x3a ':' 
    .byte 0x3a              ;dcd3  3a          UNKNOWN 0x3a ':' 
    .byte 0x85              ;dcd4  85          UNKNOWN 0x85 
    .byte 0xbb              ;dcd5  bb          UNKNOWN 0xbb 
    .byte 0x3c              ;dcd6  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;dcd7  00          UNKNOWN 0x00 
    .byte 0xbc              ;dcd8  bc          UNKNOWN 0xbc 
    .byte 0x7f              ;dcd9  7f          UNKNOWN 0x7f 
    .byte 0x3c              ;dcda  3c          UNKNOWN 0x3c '<' 
    .byte 0x6f              ;dcdb  6f          UNKNOWN 0x6f 'o' 
    .byte 0x3e              ;dcdc  3e          UNKNOWN 0x3e '>' 
    .byte 0x20              ;dcdd  20          UNKNOWN 0x20 ' ' 
    .byte 0xb8              ;dcde  b8          UNKNOWN 0xb8 
    .byte 0xe2              ;dcdf  e2          UNKNOWN 0xe2 
    .byte 0x28              ;dce0  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;dce1  ea          UNKNOWN 0xea 
    .byte 0x60              ;dce2  60          UNKNOWN 0x60 '`' 
    .byte 0x57              ;dce3  57          UNKNOWN 0x57 'W' 
    .byte 0x95              ;dce4  95          UNKNOWN 0x95 
    .byte 0x03              ;dce5  03          UNKNOWN 0x03 

sub_dce6:
    jsr sub_ddc1            ;dce6  20 c1 dd 
    ldx #0x00               ;dce9  a2 00    
    jsr sub_e283            ;dceb  20 83 e2 
    beq lab_dcf3            ;dcee  f0 03    
    jsr 0xdd74              ;dcf0  20 74 dd 

lab_dcf3:
    rts                     ;dcf3  60       

    .byte 0xa2              ;dcf4  a2          UNKNOWN 0xa2 
    .byte 0x00              ;dcf5  00          UNKNOWN 0x00 
    .byte 0xc9              ;dcf6  c9          UNKNOWN 0xc9 
    .byte 0x20              ;dcf7  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;dcf8  90          UNKNOWN 0x90 
    .byte 0x43              ;dcf9  43          UNKNOWN 0x43 'C' 
    .byte 0xc9              ;dcfa  c9          UNKNOWN 0xc9 
    .byte 0x80              ;dcfb  80          UNKNOWN 0x80 
    .byte 0xb0              ;dcfc  b0          UNKNOWN 0xb0 
    .byte 0x3f              ;dcfd  3f          UNKNOWN 0x3f '?' 
    .byte 0x85              ;dcfe  85          UNKNOWN 0x85 
    .byte 0xf7              ;dcff  f7          UNKNOWN 0xf7 
    .byte 0x3c              ;dd00  3c          UNKNOWN 0x3c '<' 
    .byte 0x0f              ;dd01  0f          UNKNOWN 0x0f 
    .byte 0xf9              ;dd02  f9          UNKNOWN 0xf9 
    .byte 0xbd              ;dd03  bd          UNKNOWN 0xbd 
    .byte 0x89              ;dd04  89          UNKNOWN 0x89 
    .byte 0xdc              ;dd05  dc          UNKNOWN 0xdc 
    .byte 0xc5              ;dd06  c5          UNKNOWN 0xc5 
    .byte 0xf7              ;dd07  f7          UNKNOWN 0xf7 
    .byte 0xf0              ;dd08  f0          UNKNOWN 0xf0 
    .byte 0x0a              ;dd09  0a          UNKNOWN 0x0a 
    .byte 0xe8              ;dd0a  e8          UNKNOWN 0xe8 
    .byte 0xe8              ;dd0b  e8          UNKNOWN 0xe8 
    .byte 0xe8              ;dd0c  e8          UNKNOWN 0xe8 
    .byte 0xe8              ;dd0d  e8          UNKNOWN 0xe8 
    .byte 0xc6              ;dd0e  c6          UNKNOWN 0xc6 
    .byte 0xf9              ;dd0f  f9          UNKNOWN 0xf9 
    .byte 0xd0              ;dd10  d0          UNKNOWN 0xd0 
    .byte 0xf1              ;dd11  f1          UNKNOWN 0xf1 
    .byte 0x80              ;dd12  80          UNKNOWN 0x80 
    .byte 0x29              ;dd13  29          UNKNOWN 0x29 ')' 
    .byte 0xbd              ;dd14  bd          UNKNOWN 0xbd 
    .byte 0x8a              ;dd15  8a          UNKNOWN 0x8a 
    .byte 0xdc              ;dd16  dc          UNKNOWN 0xdc 
    .byte 0x85              ;dd17  85          UNKNOWN 0x85 
    .byte 0xfa              ;dd18  fa          UNKNOWN 0xfa 
    .byte 0x20              ;dd19  20          UNKNOWN 0x20 ' ' 
    .byte 0x97              ;dd1a  97          UNKNOWN 0x97 
    .byte 0xe2              ;dd1b  e2          UNKNOWN 0xe2 
    .byte 0xc5              ;dd1c  c5          UNKNOWN 0xc5 
    .byte 0xfa              ;dd1d  fa          UNKNOWN 0xfa 
    .byte 0x90              ;dd1e  90          UNKNOWN 0x90 
    .byte 0x20              ;dd1f  20          UNKNOWN 0x20 ' ' 
    .byte 0xbd              ;dd20  bd          UNKNOWN 0xbd 
    .byte 0x8b              ;dd21  8b          UNKNOWN 0x8b 
    .byte 0xdc              ;dd22  dc          UNKNOWN 0xdc 
    .byte 0x85              ;dd23  85          UNKNOWN 0x85 
    .byte 0xf5              ;dd24  f5          UNKNOWN 0xf5 
    .byte 0xbd              ;dd25  bd          UNKNOWN 0xbd 
    .byte 0x8c              ;dd26  8c          UNKNOWN 0x8c 
    .byte 0xdc              ;dd27  dc          UNKNOWN 0xdc 
    .byte 0x85              ;dd28  85          UNKNOWN 0x85 
    .byte 0xf6              ;dd29  f6          UNKNOWN 0xf6 
    .byte 0xc6              ;dd2a  c6          UNKNOWN 0xc6 
    .byte 0xfa              ;dd2b  fa          UNKNOWN 0xfa 
    .byte 0xa6              ;dd2c  a6          UNKNOWN 0xa6 
    .byte 0xfa              ;dd2d  fa          UNKNOWN 0xfa 
    .byte 0xf0              ;dd2e  f0          UNKNOWN 0xf0 
    .byte 0x0b              ;dd2f  0b          UNKNOWN 0x0b 
    .byte 0x20              ;dd30  20          UNKNOWN 0x20 ' ' 
    .byte 0x83              ;dd31  83          UNKNOWN 0x83 
    .byte 0xe2              ;dd32  e2          UNKNOWN 0xe2 
    .byte 0xc9              ;dd33  c9          UNKNOWN 0xc9 
    .byte 0x20              ;dd34  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;dd35  90          UNKNOWN 0x90 
    .byte 0x06              ;dd36  06          UNKNOWN 0x06 
    .byte 0xc9              ;dd37  c9          UNKNOWN 0xc9 
    .byte 0x80              ;dd38  80          UNKNOWN 0x80 
    .byte 0xb0              ;dd39  b0          UNKNOWN 0xb0 
    .byte 0x02              ;dd3a  02          UNKNOWN 0x02 
    .byte 0xb2              ;dd3b  b2          UNKNOWN 0xb2 
    .byte 0xf5              ;dd3c  f5          UNKNOWN 0xf5 
    .byte 0x20              ;dd3d  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dd3e  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dd3f  e2          UNKNOWN 0xe2 
    .byte 0x60              ;dd40  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;dd41  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;dd42  00          UNKNOWN 0x00 
    .byte 0x9a              ;dd43  9a          UNKNOWN 0x9a 
    .byte 0x5f              ;dd44  5f          UNKNOWN 0x5f '_' 
    .byte 0x95              ;dd45  95          UNKNOWN 0x95 
    .byte 0x9f              ;dd46  9f          UNKNOWN 0x9f 
    .byte 0xbf              ;dd47  bf          UNKNOWN 0xbf 
    .byte 0x60              ;dd48  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;dd49  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dd4a  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dd4b  e2          UNKNOWN 0xe2 
    .byte 0xff              ;dd4c  ff          UNKNOWN 0xff 
    .byte 0xbf              ;dd4d  bf          UNKNOWN 0xbf 
    .byte 0x20              ;dd4e  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;dd4f  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;dd50  dd          UNKNOWN 0xdd 
    .byte 0x60              ;dd51  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;dd52  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dd53  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dd54  e2          UNKNOWN 0xe2 
    .byte 0xef              ;dd55  ef          UNKNOWN 0xef 
    .byte 0xbf              ;dd56  bf          UNKNOWN 0xbf 
    .byte 0x20              ;dd57  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;dd58  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;dd59  dd          UNKNOWN 0xdd 
    .byte 0x60              ;dd5a  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;dd5b  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;dd5c  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;dd5d  d0          UNKNOWN 0xd0 
    .byte 0x85              ;dd5e  85          UNKNOWN 0x85 
    .byte 0xf7              ;dd5f  f7          UNKNOWN 0xf7 
    .byte 0x20              ;dd60  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dd61  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dd62  e2          UNKNOWN 0xe2 

sub_dd63:
    jsr sub_e271            ;dd63  20 71 e2 
    cmp #0x73               ;dd66  c9 73    
    beq lab_dd6e            ;dd68  f0 04    
    cmp #0x70               ;dd6a  c9 70    
    bne lab_dd8a            ;dd6c  d0 1c    

lab_dd6e:
    sta mem_00c7            ;dd6e  85 c7    
    jsr sub_d075            ;dd70  20 75 d0 
    sta mem_00f8            ;dd73  85 f8    
    beq lab_dda5            ;dd75  f0 2e    
    lda mem_006c            ;dd77  a5 6c    
    and #0xf0               ;dd79  29 f0    
    ora mem_00f8            ;dd7b  05 f8    
    sta mem_006c            ;dd7d  85 6c    
    and #0x0f               ;dd7f  29 0f    
    cmp mem_00f7            ;dd81  c5 f7    
    beq lab_dda5            ;dd83  f0 20    
    ldm #0xff,mem_006e      ;dd85  3c ff 6e 
    bra lab_dda5            ;dd88  80 1b    

lab_dd8a:
    cmp #0x30               ;dd8a  c9 30    
    bcc lab_dda8            ;dd8c  90 1a    
    cmp #0x37               ;dd8e  c9 37    
    bcs lab_dda8            ;dd90  b0 16    
    sec                     ;dd92  38       
    sbc #0x30               ;dd93  e9 30    
    cmp mem_00c8            ;dd95  c5 c8    
    beq lab_dda5            ;dd97  f0 0c    
    sta mem_00c8            ;dd99  85 c8    
    lda #0x00               ;dd9b  a9 00    
    sta mem_0109            ;dd9d  8d 09 01 
    sta mem_0107            ;dda0  8d 07 01 
    beq lab_dda5            ;dda3  f0 00    

lab_dda5:
    jsr sub_ddc1            ;dda5  20 c1 dd 

lab_dda8:
    rts                     ;dda8  60       

    .byte 0x20              ;dda9  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;ddaa  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;ddab  e2          UNKNOWN 0xe2 
    .byte 0xbf              ;ddac  bf          UNKNOWN 0xbf 
    .byte 0xbf              ;ddad  bf          UNKNOWN 0xbf 
    .byte 0x3c              ;ddae  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;ddaf  00          UNKNOWN 0x00 
    .byte 0x9f              ;ddb0  9f          UNKNOWN 0x9f 
    .byte 0x3c              ;ddb1  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;ddb2  0a          UNKNOWN 0x0a 
    .byte 0xf7              ;ddb3  f7          UNKNOWN 0xf7 
    .byte 0x20              ;ddb4  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;ddb5  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;ddb6  e2          UNKNOWN 0xe2 
    .byte 0x20              ;ddb7  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;ddb8  41          UNKNOWN 0x41 'A' 
    .byte 0xe2              ;ddb9  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;ddba  b0          UNKNOWN 0xb0 
    .byte 0x5d              ;ddbb  5d          UNKNOWN 0x5d ']' 
    .byte 0xa2              ;ddbc  a2          UNKNOWN 0xa2 
    .byte 0x00              ;ddbd  00          UNKNOWN 0x00 
    .byte 0x62              ;ddbe  62          UNKNOWN 0x62 'b' 
    .byte 0xf7              ;ddbf  f7          UNKNOWN 0xf7 
    .byte 0x85              ;ddc0  85          UNKNOWN 0x85 

sub_ddc1:
    sta mem_2068,x          ;ddc1  9d 68 20 
    adc [mem_00e2],y        ;ddc4  71 e2    
    jsr sub_e241            ;ddc6  20 41 e2 
    bcs lab_de19            ;ddc9  b0 4e    
    clc                     ;ddcb  18       
    adc mem_009d            ;ddcc  65 9d    
    cmp #0x18               ;ddce  c9 18    
    bcs lab_de19            ;ddd0  b0 47    
    sta mem_009d            ;ddd2  85 9d    
    jsr sub_e271            ;ddd4  20 71 e2 
    jsr sub_e241            ;ddd7  20 41 e2 
    bcs lab_de19            ;ddda  b0 3d    
    ldx #0x00               ;dddc  a2 00    
    mul mem_00f7,x          ;ddde  62 f7    
    sta mem_009e            ;dde0  85 9e    
    pla                     ;dde2  68       
    jsr sub_e271            ;dde3  20 71 e2 
    jsr sub_e241            ;dde6  20 41 e2 
    bcs lab_de19            ;dde9  b0 2e    
    clc                     ;ddeb  18       
    adc mem_009e            ;ddec  65 9e    
    cmp #0x3c               ;ddee  c9 3c    
    bcs lab_de19            ;ddf0  b0 27    
    sta mem_009e            ;ddf2  85 9e    
    jsr sub_e271            ;ddf4  20 71 e2 
    jsr sub_e241            ;ddf7  20 41 e2 
    bcs lab_de19            ;ddfa  b0 1d    
    ldx #0x00               ;ddfc  a2 00    
    mul mem_00f7,x          ;ddfe  62 f7    
    sta mem_00f8            ;de00  85 f8    
    pla                     ;de02  68       
    jsr sub_e271            ;de03  20 71 e2 
    jsr sub_e241            ;de06  20 41 e2 
    bcs lab_de19            ;de09  b0 0e    
    clc                     ;de0b  18       
    adc mem_00f8            ;de0c  65 f8    
    cmp #0x3c               ;de0e  c9 3c    
    bcs lab_de19            ;de10  b0 07    
    sta mem_009f            ;de12  85 9f    
    seb 5,mem_00bf          ;de14  af bf    
    jsr sub_ddc1            ;de16  20 c1 dd 

lab_de19:
    rts                     ;de19  60       

    .byte 0x20              ;de1a  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;de1b  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;de1c  e2          UNKNOWN 0xe2 
    .byte 0x3f              ;de1d  3f          UNKNOWN 0x3f '?' 
    .byte 0xbf              ;de1e  bf          UNKNOWN 0xbf 
    .byte 0x1f              ;de1f  1f          UNKNOWN 0x1f 
    .byte 0xbf              ;de20  bf          UNKNOWN 0xbf 
    .byte 0xa9              ;de21  a9          UNKNOWN 0xa9 
    .byte 0x00              ;de22  00          UNKNOWN 0x00 
    .byte 0x8d              ;de23  8d          UNKNOWN 0x8d 
    .byte 0x16              ;de24  16          UNKNOWN 0x16 
    .byte 0x01              ;de25  01          UNKNOWN 0x01 
    .byte 0x8d              ;de26  8d          UNKNOWN 0x8d 
    .byte 0x17              ;de27  17          UNKNOWN 0x17 
    .byte 0x01              ;de28  01          UNKNOWN 0x01 
    .byte 0x8d              ;de29  8d          UNKNOWN 0x8d 
    .byte 0x18              ;de2a  18          UNKNOWN 0x18 
    .byte 0x01              ;de2b  01          UNKNOWN 0x01 
    .byte 0x8d              ;de2c  8d          UNKNOWN 0x8d 
    .byte 0x19              ;de2d  19          UNKNOWN 0x19 
    .byte 0x01              ;de2e  01          UNKNOWN 0x01 
    .byte 0x85              ;de2f  85          UNKNOWN 0x85 
    .byte 0xf9              ;de30  f9          UNKNOWN 0xf9 
    .byte 0x85              ;de31  85          UNKNOWN 0x85 
    .byte 0xfa              ;de32  fa          UNKNOWN 0xfa 
    .byte 0x3c              ;de33  3c          UNKNOWN 0x3c '<' 
    .byte 0x64              ;de34  64          UNKNOWN 0x64 'd' 
    .byte 0xf7              ;de35  f7          UNKNOWN 0xf7 
    .byte 0x20              ;de36  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;de37  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;de38  e2          UNKNOWN 0xe2 
    .byte 0x20              ;de39  20          UNKNOWN 0x20 ' ' 
    .byte 0x55              ;de3a  55          UNKNOWN 0x55 'U' 
    .byte 0xe2              ;de3b  e2          UNKNOWN 0xe2 
    .byte 0x90              ;de3c  90          UNKNOWN 0x90 
    .byte 0x03              ;de3d  03          UNKNOWN 0x03 
    .byte 0x4c              ;de3e  4c          UNKNOWN 0x4c 'L' 
    .byte 0x5e              ;de3f  5e          UNKNOWN 0x5e '^' 
    .byte 0xdf              ;de40  df          UNKNOWN 0xdf 
    .byte 0x85              ;de41  85          UNKNOWN 0x85 
    .byte 0xf7              ;de42  f7          UNKNOWN 0xf7 
    .byte 0xc9              ;de43  c9          UNKNOWN 0xc9 
    .byte 0x00              ;de44  00          UNKNOWN 0x00 
    .byte 0xf0              ;de45  f0          UNKNOWN 0xf0 
    .byte 0x11              ;de46  11          UNKNOWN 0x11 
    .byte 0xa9              ;de47  a9          UNKNOWN 0xa9 
    .byte 0x10              ;de48  10          UNKNOWN 0x10 
    .byte 0xa0              ;de49  a0          UNKNOWN 0xa0 
    .byte 0xf9              ;de4a  f9          UNKNOWN 0xf9 
    .byte 0x20              ;de4b  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;de4c  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;de4d  e6          UNKNOWN 0xe6 
    .byte 0xa5              ;de4e  a5          UNKNOWN 0xa5 
    .byte 0xfa              ;de4f  fa          UNKNOWN 0xfa 
    .byte 0x69              ;de50  69          UNKNOWN 0x69 'i' 
    .byte 0x05              ;de51  05          UNKNOWN 0x05 
    .byte 0x85              ;de52  85          UNKNOWN 0x85 
    .byte 0xfa              ;de53  fa          UNKNOWN 0xfa 
    .byte 0xc6              ;de54  c6          UNKNOWN 0xc6 
    .byte 0xf7              ;de55  f7          UNKNOWN 0xf7 
    .byte 0xd0              ;de56  d0          UNKNOWN 0xd0 
    .byte 0xef              ;de57  ef          UNKNOWN 0xef 
    .byte 0x3c              ;de58  3c          UNKNOWN 0x3c '<' 
    .byte 0x24              ;de59  24          UNKNOWN 0x24 '$' 
    .byte 0xf7              ;de5a  f7          UNKNOWN 0xf7 
    .byte 0x20              ;de5b  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;de5c  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;de5d  e2          UNKNOWN 0xe2 
    .byte 0x20              ;de5e  20          UNKNOWN 0x20 ' ' 
    .byte 0x55              ;de5f  55          UNKNOWN 0x55 'U' 
    .byte 0xe2              ;de60  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;de61  b0          UNKNOWN 0xb0 
    .byte 0x7b              ;de62  7b          UNKNOWN 0x7b '{' 
    .byte 0xa2              ;de63  a2          UNKNOWN 0xa2 
    .byte 0x00              ;de64  00          UNKNOWN 0x00 
    .byte 0x62              ;de65  62          UNKNOWN 0x62 'b' 
    .byte 0xf7              ;de66  f7          UNKNOWN 0xf7 
    .byte 0xa0              ;de67  a0          UNKNOWN 0xa0 
    .byte 0xf9              ;de68  f9          UNKNOWN 0xf9 
    .byte 0x20              ;de69  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;de6a  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;de6b  e6          UNKNOWN 0xe6 
    .byte 0x68              ;de6c  68          UNKNOWN 0x68 'h' 
    .byte 0x65              ;de6d  65          UNKNOWN 0x65 'e' 
    .byte 0xfa              ;de6e  fa          UNKNOWN 0xfa 
    .byte 0x85              ;de6f  85          UNKNOWN 0x85 
    .byte 0xfa              ;de70  fa          UNKNOWN 0xfa 
    .byte 0x20              ;de71  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;de72  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;de73  e2          UNKNOWN 0xe2 
    .byte 0x20              ;de74  20          UNKNOWN 0x20 ' ' 
    .byte 0x55              ;de75  55          UNKNOWN 0x55 'U' 
    .byte 0xe2              ;de76  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;de77  b0          UNKNOWN 0xb0 
    .byte 0x65              ;de78  65          UNKNOWN 0x65 'e' 
    .byte 0xa0              ;de79  a0          UNKNOWN 0xa0 
    .byte 0xf9              ;de7a  f9          UNKNOWN 0xf9 
    .byte 0x20              ;de7b  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;de7c  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;de7d  e6          UNKNOWN 0xe6 
    .byte 0xa5              ;de7e  a5          UNKNOWN 0xa5 
    .byte 0xfa              ;de7f  fa          UNKNOWN 0xfa 
    .byte 0x8d              ;de80  8d          UNKNOWN 0x8d 
    .byte 0x17              ;de81  17          UNKNOWN 0x17 
    .byte 0x01              ;de82  01          UNKNOWN 0x01 
    .byte 0xa5              ;de83  a5          UNKNOWN 0xa5 
    .byte 0xf9              ;de84  f9          UNKNOWN 0xf9 
    .byte 0x8d              ;de85  8d          UNKNOWN 0x8d 
    .byte 0x16              ;de86  16          UNKNOWN 0x16 
    .byte 0x01              ;de87  01          UNKNOWN 0x01 
    .byte 0xc9              ;de88  c9          UNKNOWN 0xc9 
    .byte 0x3f              ;de89  3f          UNKNOWN 0x3f '?' 
    .byte 0xd0              ;de8a  d0          UNKNOWN 0xd0 
    .byte 0x08              ;de8b  08          UNKNOWN 0x08 
    .byte 0xa5              ;de8c  a5          UNKNOWN 0xa5 
    .byte 0xfa              ;de8d  fa          UNKNOWN 0xfa 
    .byte 0xc9              ;de8e  c9          UNKNOWN 0xc9 
    .byte 0xb6              ;de8f  b6          UNKNOWN 0xb6 
    .byte 0xd0              ;de90  d0          UNKNOWN 0xd0 
    .byte 0x02              ;de91  02          UNKNOWN 0x02 
    .byte 0x0f              ;de92  0f          UNKNOWN 0x0f 
    .byte 0xbf              ;de93  bf          UNKNOWN 0xbf 
    .byte 0x3c              ;de94  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;de95  0a          UNKNOWN 0x0a 
    .byte 0xf7              ;de96  f7          UNKNOWN 0xf7 
    .byte 0x20              ;de97  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;de98  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;de99  e2          UNKNOWN 0xe2 
    .byte 0x20              ;de9a  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;de9b  41          UNKNOWN 0x41 'A' 
    .byte 0xe2              ;de9c  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;de9d  b0          UNKNOWN 0xb0 
    .byte 0x3f              ;de9e  3f          UNKNOWN 0x3f '?' 
    .byte 0xa2              ;de9f  a2          UNKNOWN 0xa2 
    .byte 0x00              ;dea0  00          UNKNOWN 0x00 
    .byte 0x62              ;dea1  62          UNKNOWN 0x62 'b' 
    .byte 0xf7              ;dea2  f7          UNKNOWN 0xf7 
    .byte 0x85              ;dea3  85          UNKNOWN 0x85 
    .byte 0xf9              ;dea4  f9          UNKNOWN 0xf9 
    .byte 0x68              ;dea5  68          UNKNOWN 0x68 'h' 
    .byte 0x20              ;dea6  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dea7  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dea8  e2          UNKNOWN 0xe2 
    .byte 0x20              ;dea9  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;deaa  41          UNKNOWN 0x41 'A' 
    .byte 0xe2              ;deab  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;deac  b0          UNKNOWN 0xb0 
    .byte 0x30              ;dead  30          UNKNOWN 0x30 '0' 
    .byte 0x18              ;deae  18          UNKNOWN 0x18 
    .byte 0x65              ;deaf  65          UNKNOWN 0x65 'e' 
    .byte 0xf9              ;deb0  f9          UNKNOWN 0xf9 
    .byte 0xc9              ;deb1  c9          UNKNOWN 0xc9 
    .byte 0x18              ;deb2  18          UNKNOWN 0x18 
    .byte 0xb0              ;deb3  b0          UNKNOWN 0xb0 
    .byte 0x29              ;deb4  29          UNKNOWN 0x29 ')' 
    .byte 0x8d              ;deb5  8d          UNKNOWN 0x8d 
    .byte 0x18              ;deb6  18          UNKNOWN 0x18 
    .byte 0x01              ;deb7  01          UNKNOWN 0x01 
    .byte 0x20              ;deb8  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;deb9  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;deba  e2          UNKNOWN 0xe2 
    .byte 0x20              ;debb  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;debc  41          UNKNOWN 0x41 'A' 
    .byte 0xe2              ;debd  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;debe  b0          UNKNOWN 0xb0 
    .byte 0x1e              ;debf  1e          UNKNOWN 0x1e 
    .byte 0xa2              ;dec0  a2          UNKNOWN 0xa2 
    .byte 0x00              ;dec1  00          UNKNOWN 0x00 
    .byte 0x62              ;dec2  62          UNKNOWN 0x62 'b' 
    .byte 0xf7              ;dec3  f7          UNKNOWN 0xf7 
    .byte 0x85              ;dec4  85          UNKNOWN 0x85 
    .byte 0xf9              ;dec5  f9          UNKNOWN 0xf9 
    .byte 0x68              ;dec6  68          UNKNOWN 0x68 'h' 
    .byte 0x20              ;dec7  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dec8  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dec9  e2          UNKNOWN 0xe2 
    .byte 0x20              ;deca  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;decb  41          UNKNOWN 0x41 'A' 
    .byte 0xe2              ;decc  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;decd  b0          UNKNOWN 0xb0 
    .byte 0x0f              ;dece  0f          UNKNOWN 0x0f 
    .byte 0x18              ;decf  18          UNKNOWN 0x18 
    .byte 0x65              ;ded0  65          UNKNOWN 0x65 'e' 
    .byte 0xf9              ;ded1  f9          UNKNOWN 0xf9 
    .byte 0xc9              ;ded2  c9          UNKNOWN 0xc9 
    .byte 0x3c              ;ded3  3c          UNKNOWN 0x3c '<' 
    .byte 0xb0              ;ded4  b0          UNKNOWN 0xb0 
    .byte 0x08              ;ded5  08          UNKNOWN 0x08 
    .byte 0x8d              ;ded6  8d          UNKNOWN 0x8d 
    .byte 0x19              ;ded7  19          UNKNOWN 0x19 
    .byte 0x01              ;ded8  01          UNKNOWN 0x01 
    .byte 0x2f              ;ded9  2f          UNKNOWN 0x2f '/' 
    .byte 0xbf              ;deda  bf          UNKNOWN 0xbf 
    .byte 0x20              ;dedb  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;dedc  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;dedd  dd          UNKNOWN 0xdd 
    .byte 0x60              ;dede  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;dedf  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dee0  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dee1  e2          UNKNOWN 0xe2 
    .byte 0x3c              ;dee2  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;dee3  0a          UNKNOWN 0x0a 
    .byte 0xf7              ;dee4  f7          UNKNOWN 0xf7 
    .byte 0x20              ;dee5  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dee6  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dee7  e2          UNKNOWN 0xe2 
    .byte 0x20              ;dee8  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;dee9  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;deea  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;deeb  b0          UNKNOWN 0xb0 
    .byte 0x24              ;deec  24          UNKNOWN 0x24 '$' 
    .byte 0x85              ;deed  85          UNKNOWN 0x85 
    .byte 0xcb              ;deee  cb          UNKNOWN 0xcb 
    .byte 0x20              ;deef  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;def0  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;def1  e2          UNKNOWN 0xe2 
    .byte 0x20              ;def2  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;def3  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;def4  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;def5  b0          UNKNOWN 0xb0 
    .byte 0x1a              ;def6  1a          UNKNOWN 0x1a 
    .byte 0x0a              ;def7  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;def8  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;def9  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;defa  0a          UNKNOWN 0x0a 
    .byte 0x85              ;defb  85          UNKNOWN 0x85 
    .byte 0xca              ;defc  ca          UNKNOWN 0xca 
    .byte 0x20              ;defd  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;defe  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;deff  e2          UNKNOWN 0xe2 
    .byte 0x20              ;df00  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;df01  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;df02  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;df03  b0          UNKNOWN 0xb0 
    .byte 0x0c              ;df04  0c          UNKNOWN 0x0c 
    .byte 0x05              ;df05  05          UNKNOWN 0x05 
    .byte 0xca              ;df06  ca          UNKNOWN 0xca 
    .byte 0x85              ;df07  85          UNKNOWN 0x85 
    .byte 0xca              ;df08  ca          UNKNOWN 0xca 
    .byte 0xf7              ;df09  f7          UNKNOWN 0xf7 
    .byte 0xbf              ;df0a  bf          UNKNOWN 0xbf 
    .byte 0x02              ;df0b  02          UNKNOWN 0x02 
    .byte 0x4f              ;df0c  4f          UNKNOWN 0x4f 'O' 
    .byte 0xbf              ;df0d  bf          UNKNOWN 0xbf 
    .byte 0x20              ;df0e  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;df0f  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;df10  dd          UNKNOWN 0xdd 
    .byte 0x60              ;df11  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;df12  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df13  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df14  e2          UNKNOWN 0xe2 
    .byte 0x20              ;df15  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df16  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df17  e2          UNKNOWN 0xe2 
    .byte 0x20              ;df18  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;df19  41          UNKNOWN 0x41 'A' 
    .byte 0xe2              ;df1a  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;df1b  b0          UNKNOWN 0xb0 
    .byte 0x09              ;df1c  09          UNKNOWN 0x09 
    .byte 0xc9              ;df1d  c9          UNKNOWN 0xc9 
    .byte 0x05              ;df1e  05          UNKNOWN 0x05 
    .byte 0xb0              ;df1f  b0          UNKNOWN 0xb0 
    .byte 0x05              ;df20  05          UNKNOWN 0x05 
    .byte 0x85              ;df21  85          UNKNOWN 0x85 
    .byte 0xc6              ;df22  c6          UNKNOWN 0xc6 
    .byte 0x20              ;df23  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;df24  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;df25  dd          UNKNOWN 0xdd 
    .byte 0x60              ;df26  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;df27  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df28  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df29  e2          UNKNOWN 0xe2 
    .byte 0x20              ;df2a  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df2b  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df2c  e2          UNKNOWN 0xe2 
    .byte 0x20              ;df2d  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;df2e  41          UNKNOWN 0x41 'A' 
    .byte 0xe2              ;df2f  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;df30  b0          UNKNOWN 0xb0 
    .byte 0x1b              ;df31  1b          UNKNOWN 0x1b 
    .byte 0xc9              ;df32  c9          UNKNOWN 0xc9 
    .byte 0x00              ;df33  00          UNKNOWN 0x00 
    .byte 0xf0              ;df34  f0          UNKNOWN 0xf0 
    .byte 0x0e              ;df35  0e          UNKNOWN 0x0e 
    .byte 0xc9              ;df36  c9          UNKNOWN 0xc9 
    .byte 0x09              ;df37  09          UNKNOWN 0x09 
    .byte 0xb0              ;df38  b0          UNKNOWN 0xb0 
    .byte 0x0a              ;df39  0a          UNKNOWN 0x0a 
    .byte 0x08              ;df3a  08          UNKNOWN 0x08 
    .byte 0x78              ;df3b  78          UNKNOWN 0x78 'x' 
    .byte 0x6f              ;df3c  6f          UNKNOWN 0x6f 'o' 
    .byte 0xbf              ;df3d  bf          UNKNOWN 0xbf 
    .byte 0x85              ;df3e  85          UNKNOWN 0x85 
    .byte 0xcd              ;df3f  cd          UNKNOWN 0xcd 
    .byte 0x28              ;df40  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;df41  ea          UNKNOWN 0xea 
    .byte 0x80              ;df42  80          UNKNOWN 0x80 
    .byte 0x06              ;df43  06          UNKNOWN 0x06 
    .byte 0x7f              ;df44  7f          UNKNOWN 0x7f 
    .byte 0xbf              ;df45  bf          UNKNOWN 0xbf 
    .byte 0xa9              ;df46  a9          UNKNOWN 0xa9 
    .byte 0x00              ;df47  00          UNKNOWN 0x00 
    .byte 0x85              ;df48  85          UNKNOWN 0x85 
    .byte 0xcd              ;df49  cd          UNKNOWN 0xcd 
    .byte 0x20              ;df4a  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;df4b  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;df4c  dd          UNKNOWN 0xdd 
    .byte 0x60              ;df4d  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;df4e  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;df4f  0a          UNKNOWN 0x0a 
    .byte 0x9a              ;df50  9a          UNKNOWN 0x9a 
    .byte 0x5f              ;df51  5f          UNKNOWN 0x5f '_' 
    .byte 0x95              ;df52  95          UNKNOWN 0x95 
    .byte 0x8f              ;df53  8f          UNKNOWN 0x8f 
    .byte 0xbf              ;df54  bf          UNKNOWN 0xbf 
    .byte 0x20              ;df55  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df56  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df57  e2          UNKNOWN 0xe2 
    .byte 0x20              ;df58  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df59  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df5a  e2          UNKNOWN 0xe2 
    .byte 0x4a              ;df5b  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;df5c  b0          UNKNOWN 0xb0 
    .byte 0x04              ;df5d  04          UNKNOWN 0x04 
    .byte 0x9f              ;df5e  9f          UNKNOWN 0x9f 
    .byte 0x44              ;df5f  44          UNKNOWN 0x44 'D' 
    .byte 0x80              ;df60  80          UNKNOWN 0x80 
    .byte 0x02              ;df61  02          UNKNOWN 0x02 
    .byte 0x8f              ;df62  8f          UNKNOWN 0x8f 
    .byte 0x44              ;df63  44          UNKNOWN 0x44 'D' 
    .byte 0x4a              ;df64  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;df65  b0          UNKNOWN 0xb0 
    .byte 0x04              ;df66  04          UNKNOWN 0x04 
    .byte 0xbf              ;df67  bf          UNKNOWN 0xbf 
    .byte 0x44              ;df68  44          UNKNOWN 0x44 'D' 
    .byte 0x80              ;df69  80          UNKNOWN 0x80 
    .byte 0x02              ;df6a  02          UNKNOWN 0x02 
    .byte 0xaf              ;df6b  af          UNKNOWN 0xaf 
    .byte 0x44              ;df6c  44          UNKNOWN 0x44 'D' 
    .byte 0x4a              ;df6d  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;df6e  b0          UNKNOWN 0xb0 
    .byte 0x04              ;df6f  04          UNKNOWN 0x04 
    .byte 0xdf              ;df70  df          UNKNOWN 0xdf 
    .byte 0x44              ;df71  44          UNKNOWN 0x44 'D' 
    .byte 0x80              ;df72  80          UNKNOWN 0x80 
    .byte 0x02              ;df73  02          UNKNOWN 0x02 
    .byte 0xcf              ;df74  cf          UNKNOWN 0xcf 
    .byte 0x44              ;df75  44          UNKNOWN 0x44 'D' 
    .byte 0x20              ;df76  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df77  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df78  e2          UNKNOWN 0xe2 
    .byte 0x4a              ;df79  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;df7a  b0          UNKNOWN 0xb0 
    .byte 0x04              ;df7b  04          UNKNOWN 0x04 
    .byte 0x1f              ;df7c  1f          UNKNOWN 0x1f 
    .byte 0x44              ;df7d  44          UNKNOWN 0x44 'D' 
    .byte 0x80              ;df7e  80          UNKNOWN 0x80 
    .byte 0x02              ;df7f  02          UNKNOWN 0x02 
    .byte 0x0f              ;df80  0f          UNKNOWN 0x0f 
    .byte 0x44              ;df81  44          UNKNOWN 0x44 'D' 
    .byte 0x4a              ;df82  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;df83  b0          UNKNOWN 0xb0 
    .byte 0x04              ;df84  04          UNKNOWN 0x04 
    .byte 0x3f              ;df85  3f          UNKNOWN 0x3f '?' 
    .byte 0x44              ;df86  44          UNKNOWN 0x44 'D' 
    .byte 0x80              ;df87  80          UNKNOWN 0x80 
    .byte 0x02              ;df88  02          UNKNOWN 0x02 
    .byte 0x2f              ;df89  2f          UNKNOWN 0x2f '/' 
    .byte 0x44              ;df8a  44          UNKNOWN 0x44 'D' 
    .byte 0x20              ;df8b  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;df8c  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;df8d  e2          UNKNOWN 0xe2 
    .byte 0x4a              ;df8e  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;df8f  b0          UNKNOWN 0xb0 
    .byte 0x04              ;df90  04          UNKNOWN 0x04 
    .byte 0x7f              ;df91  7f          UNKNOWN 0x7f 
    .byte 0x43              ;df92  43          UNKNOWN 0x43 'C' 
    .byte 0x80              ;df93  80          UNKNOWN 0x80 
    .byte 0x02              ;df94  02          UNKNOWN 0x02 
    .byte 0x6f              ;df95  6f          UNKNOWN 0x6f 'o' 
    .byte 0x43              ;df96  43          UNKNOWN 0x43 'C' 
    .byte 0x4a              ;df97  4a          UNKNOWN 0x4a 'J' 
    .byte 0xb0              ;df98  b0          UNKNOWN 0xb0 
    .byte 0x04              ;df99  04          UNKNOWN 0x04 
    .byte 0x7f              ;df9a  7f          UNKNOWN 0x7f 
    .byte 0x41              ;df9b  41          UNKNOWN 0x41 'A' 
    .byte 0x80              ;df9c  80          UNKNOWN 0x80 
    .byte 0x02              ;df9d  02          UNKNOWN 0x02 
    .byte 0x6f              ;df9e  6f          UNKNOWN 0x6f 'o' 
    .byte 0x41              ;df9f  41          UNKNOWN 0x41 'A' 
    .byte 0x60              ;dfa0  60          UNKNOWN 0x60 '`' 
    .byte 0x3c              ;dfa1  3c          UNKNOWN 0x3c '<' 
    .byte 0x0a              ;dfa2  0a          UNKNOWN 0x0a 
    .byte 0x9a              ;dfa3  9a          UNKNOWN 0x9a 
    .byte 0x5f              ;dfa4  5f          UNKNOWN 0x5f '_' 
    .byte 0x95              ;dfa5  95          UNKNOWN 0x95 
    .byte 0x8f              ;dfa6  8f          UNKNOWN 0x8f 
    .byte 0xbf              ;dfa7  bf          UNKNOWN 0xbf 
    .byte 0x20              ;dfa8  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dfa9  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dfaa  e2          UNKNOWN 0xe2 
    .byte 0x20              ;dfab  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dfac  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dfad  e2          UNKNOWN 0xe2 
    .byte 0x20              ;dfae  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;dfaf  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;dfb0  d4          UNKNOWN 0xd4 
    .byte 0x85              ;dfb1  85          UNKNOWN 0x85 
    .byte 0x40              ;dfb2  40          UNKNOWN 0x40 '@' 
    .byte 0x20              ;dfb3  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dfb4  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dfb5  e2          UNKNOWN 0xe2 
    .byte 0x20              ;dfb6  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;dfb7  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;dfb8  d4          UNKNOWN 0xd4 
    .byte 0x77              ;dfb9  77          UNKNOWN 0x77 'w' 
    .byte 0x41              ;dfba  41          UNKNOWN 0x41 'A' 
    .byte 0x01              ;dfbb  01          UNKNOWN 0x01 
    .byte 0x6b              ;dfbc  6b          UNKNOWN 0x6b 'k' 
    .byte 0x85              ;dfbd  85          UNKNOWN 0x85 
    .byte 0x41              ;dfbe  41          UNKNOWN 0x41 'A' 
    .byte 0x20              ;dfbf  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dfc0  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dfc1  e2          UNKNOWN 0xe2 
    .byte 0x20              ;dfc2  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;dfc3  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;dfc4  d4          UNKNOWN 0xd4 
    .byte 0x85              ;dfc5  85          UNKNOWN 0x85 
    .byte 0x42              ;dfc6  42          UNKNOWN 0x42 'B' 
    .byte 0x20              ;dfc7  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dfc8  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dfc9  e2          UNKNOWN 0xe2 
    .byte 0x20              ;dfca  20          UNKNOWN 0x20 ' ' 
    .byte 0x41              ;dfcb  41          UNKNOWN 0x41 'A' 
    .byte 0xd4              ;dfcc  d4          UNKNOWN 0xd4 
    .byte 0x77              ;dfcd  77          UNKNOWN 0x77 'w' 
    .byte 0x43              ;dfce  43          UNKNOWN 0x43 'C' 
    .byte 0x01              ;dfcf  01          UNKNOWN 0x01 
    .byte 0x6b              ;dfd0  6b          UNKNOWN 0x6b 'k' 
    .byte 0x85              ;dfd1  85          UNKNOWN 0x85 
    .byte 0x43              ;dfd2  43          UNKNOWN 0x43 'C' 
    .byte 0x60              ;dfd3  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;dfd4  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;dfd5  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;dfd6  e2          UNKNOWN 0xe2 
    .byte 0xef              ;dfd7  ef          UNKNOWN 0xef 
    .byte 0xcc              ;dfd8  cc          UNKNOWN 0xcc 
    .byte 0xa5              ;dfd9  a5          UNKNOWN 0xa5 
    .byte 0x99              ;dfda  99          UNKNOWN 0x99 
    .byte 0xf0              ;dfdb  f0          UNKNOWN 0xf0 
    .byte 0x08              ;dfdc  08          UNKNOWN 0x08 
    .byte 0xa5              ;dfdd  a5          UNKNOWN 0xa5 
    .byte 0xd8              ;dfde  d8          UNKNOWN 0xd8 
    .byte 0xd0              ;dfdf  d0          UNKNOWN 0xd0 
    .byte 0xf8              ;dfe0  f8          UNKNOWN 0xf8 
    .byte 0xa5              ;dfe1  a5          UNKNOWN 0xa5 
    .byte 0xd9              ;dfe2  d9          UNKNOWN 0xd9 
    .byte 0xd0              ;dfe3  d0          UNKNOWN 0xd0 
    .byte 0xf4              ;dfe4  f4          UNKNOWN 0xf4 
    .byte 0x08              ;dfe5  08          UNKNOWN 0x08 
    .byte 0x78              ;dfe6  78          UNKNOWN 0x78 'x' 
    .byte 0x3f              ;dfe7  3f          UNKNOWN 0x3f '?' 
    .byte 0x3c              ;dfe8  3c          UNKNOWN 0x3c '<' 
    .byte 0x2f              ;dfe9  2f          UNKNOWN 0x2f '/' 
    .byte 0x3e              ;dfea  3e          UNKNOWN 0x3e '>' 
    .byte 0x8f              ;dfeb  8f          UNKNOWN 0x8f 
    .byte 0x02              ;dfec  02          UNKNOWN 0x02 
    .byte 0x3c              ;dfed  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;dfee  00          UNKNOWN 0x00 
    .byte 0x00              ;dfef  00          UNKNOWN 0x00 
    .byte 0x3c              ;dff0  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;dff1  ff          UNKNOWN 0xff 
    .byte 0x01              ;dff2  01          UNKNOWN 0x01 
    .byte 0x3c              ;dff3  3c          UNKNOWN 0x3c '<' 
    .byte 0x55              ;dff4  55          UNKNOWN 0x55 'U' 
    .byte 0xd5              ;dff5  d5          UNKNOWN 0xd5 
    .byte 0x3c              ;dff6  3c          UNKNOWN 0x3c '<' 
    .byte 0xaa              ;dff7  aa          UNKNOWN 0xaa 
    .byte 0xd6              ;dff8  d6          UNKNOWN 0xd6 
    .byte 0x3c              ;dff9  3c          UNKNOWN 0x3c '<' 
    .byte 0xff              ;dffa  ff          UNKNOWN 0xff 
    .byte 0xd7              ;dffb  d7          UNKNOWN 0xd7 
    .byte 0x3c              ;dffc  3c          UNKNOWN 0x3c '<' 
    .byte 0x03              ;dffd  03          UNKNOWN 0x03 
    .byte 0xd8              ;dffe  d8          UNKNOWN 0xd8 
    .byte 0x3c              ;dfff  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e000  00          UNKNOWN 0x00 
    .byte 0xd9              ;e001  d9          UNKNOWN 0xd9 
    .byte 0x3c              ;e002  3c          UNKNOWN 0x3c '<' 
    .byte 0x03              ;e003  03          UNKNOWN 0x03 
    .byte 0x99              ;e004  99          UNKNOWN 0x99 
    .byte 0x7f              ;e005  7f          UNKNOWN 0x7f 
    .byte 0x95              ;e006  95          UNKNOWN 0x95 
    .byte 0x20              ;e007  20          UNKNOWN 0x20 ' ' 
    .byte 0x6f              ;e008  6f          UNKNOWN 0x6f 'o' 
    .byte 0xdc              ;e009  dc          UNKNOWN 0xdc 
    .byte 0x58              ;e00a  58          UNKNOWN 0x58 'X' 
    .byte 0x67              ;e00b  67          UNKNOWN 0x67 'g' 
    .byte 0x95              ;e00c  95          UNKNOWN 0x95 
    .byte 0x08              ;e00d  08          UNKNOWN 0x08 
    .byte 0xa5              ;e00e  a5          UNKNOWN 0xa5 
    .byte 0xd8              ;e00f  d8          UNKNOWN 0xd8 
    .byte 0xd0              ;e010  d0          UNKNOWN 0xd0 
    .byte 0xf9              ;e011  f9          UNKNOWN 0xf9 
    .byte 0xa5              ;e012  a5          UNKNOWN 0xa5 
    .byte 0xd9              ;e013  d9          UNKNOWN 0xd9 
    .byte 0xd0              ;e014  d0          UNKNOWN 0xd0 
    .byte 0xf5              ;e015  f5          UNKNOWN 0xf5 
    .byte 0x78              ;e016  78          UNKNOWN 0x78 'x' 
    .byte 0x9f              ;e017  9f          UNKNOWN 0x9f 
    .byte 0x02              ;e018  02          UNKNOWN 0x02 
    .byte 0x3c              ;e019  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e01a  00          UNKNOWN 0x00 
    .byte 0x00              ;e01b  00          UNKNOWN 0x00 
    .byte 0x3c              ;e01c  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e01d  00          UNKNOWN 0x00 
    .byte 0x01              ;e01e  01          UNKNOWN 0x01 
    .byte 0x3c              ;e01f  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e020  00          UNKNOWN 0x00 
    .byte 0xd3              ;e021  d3          UNKNOWN 0xd3 
    .byte 0x3c              ;e022  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e023  00          UNKNOWN 0x00 
    .byte 0xd8              ;e024  d8          UNKNOWN 0xd8 
    .byte 0x3f              ;e025  3f          UNKNOWN 0x3f '?' 
    .byte 0x3e              ;e026  3e          UNKNOWN 0x3e '>' 
    .byte 0x28              ;e027  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;e028  ea          UNKNOWN 0xea 
    .byte 0xff              ;e029  ff          UNKNOWN 0xff 
    .byte 0xcc              ;e02a  cc          UNKNOWN 0xcc 
    .byte 0x20              ;e02b  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;e02c  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;e02d  dd          UNKNOWN 0xdd 
    .byte 0x60              ;e02e  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;e02f  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e030  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e031  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e032  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e033  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e034  e2          UNKNOWN 0xe2 
    .byte 0xc9              ;e035  c9          UNKNOWN 0xc9 
    .byte 0x61              ;e036  61          UNKNOWN 0x61 'a' 
    .byte 0xf0              ;e037  f0          UNKNOWN 0xf0 
    .byte 0x06              ;e038  06          UNKNOWN 0x06 
    .byte 0xc9              ;e039  c9          UNKNOWN 0xc9 
    .byte 0x62              ;e03a  62          UNKNOWN 0x62 'b' 
    .byte 0xf0              ;e03b  f0          UNKNOWN 0xf0 
    .byte 0x27              ;e03c  27          UNKNOWN 0x27 ''' 
    .byte 0x80              ;e03d  80          UNKNOWN 0x80 
    .byte 0x64              ;e03e  64          UNKNOWN 0x64 'd' 
    .byte 0x20              ;e03f  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e040  90          UNKNOWN 0x90 
    .byte 0xe1              ;e041  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e042  b0          UNKNOWN 0xb0 
    .byte 0x12              ;e043  12          UNKNOWN 0x12 
    .byte 0x85              ;e044  85          UNKNOWN 0x85 
    .byte 0xed              ;e045  ed          UNKNOWN 0xed 
    .byte 0x20              ;e046  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e047  90          UNKNOWN 0x90 
    .byte 0xe1              ;e048  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e049  b0          UNKNOWN 0xb0 
    .byte 0x0b              ;e04a  0b          UNKNOWN 0x0b 
    .byte 0x85              ;e04b  85          UNKNOWN 0x85 
    .byte 0xee              ;e04c  ee          UNKNOWN 0xee 
    .byte 0x20              ;e04d  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e04e  90          UNKNOWN 0x90 
    .byte 0xe1              ;e04f  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e050  b0          UNKNOWN 0xb0 
    .byte 0x04              ;e051  04          UNKNOWN 0x04 
    .byte 0x85              ;e052  85          UNKNOWN 0x85 
    .byte 0xef              ;e053  ef          UNKNOWN 0xef 
    .byte 0x80              ;e054  80          UNKNOWN 0x80 
    .byte 0x4a              ;e055  4a          UNKNOWN 0x4a 'J' 
    .byte 0xa9              ;e056  a9          UNKNOWN 0xa9 
    .byte 0xb6              ;e057  b6          UNKNOWN 0xb6 
    .byte 0x85              ;e058  85          UNKNOWN 0x85 
    .byte 0xed              ;e059  ed          UNKNOWN 0xed 
    .byte 0xa9              ;e05a  a9          UNKNOWN 0xa9 
    .byte 0x9f              ;e05b  9f          UNKNOWN 0x9f 
    .byte 0x85              ;e05c  85          UNKNOWN 0x85 
    .byte 0xee              ;e05d  ee          UNKNOWN 0xee 
    .byte 0xa9              ;e05e  a9          UNKNOWN 0xa9 
    .byte 0xa3              ;e05f  a3          UNKNOWN 0xa3 
    .byte 0x85              ;e060  85          UNKNOWN 0x85 
    .byte 0xef              ;e061  ef          UNKNOWN 0xef 
    .byte 0x80              ;e062  80          UNKNOWN 0x80 
    .byte 0x3c              ;e063  3c          UNKNOWN 0x3c '<' 
    .byte 0x20              ;e064  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e065  90          UNKNOWN 0x90 
    .byte 0xe1              ;e066  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e067  b0          UNKNOWN 0xb0 
    .byte 0x12              ;e068  12          UNKNOWN 0x12 
    .byte 0x85              ;e069  85          UNKNOWN 0x85 
    .byte 0xf0              ;e06a  f0          UNKNOWN 0xf0 
    .byte 0x20              ;e06b  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e06c  90          UNKNOWN 0x90 
    .byte 0xe1              ;e06d  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e06e  b0          UNKNOWN 0xb0 
    .byte 0x0b              ;e06f  0b          UNKNOWN 0x0b 
    .byte 0x85              ;e070  85          UNKNOWN 0x85 
    .byte 0xf1              ;e071  f1          UNKNOWN 0xf1 
    .byte 0x20              ;e072  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e073  90          UNKNOWN 0x90 
    .byte 0xe1              ;e074  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e075  b0          UNKNOWN 0xb0 
    .byte 0x04              ;e076  04          UNKNOWN 0x04 
    .byte 0x85              ;e077  85          UNKNOWN 0x85 
    .byte 0xf2              ;e078  f2          UNKNOWN 0xf2 
    .byte 0x80              ;e079  80          UNKNOWN 0x80 
    .byte 0x25              ;e07a  25          UNKNOWN 0x25 '%' 
    .byte 0xa9              ;e07b  a9          UNKNOWN 0xa9 
    .byte 0x53              ;e07c  53          UNKNOWN 0x53 'S' 
    .byte 0x85              ;e07d  85          UNKNOWN 0x85 
    .byte 0xf0              ;e07e  f0          UNKNOWN 0xf0 
    .byte 0xa9              ;e07f  a9          UNKNOWN 0xa9 
    .byte 0xba              ;e080  ba          UNKNOWN 0xba 
    .byte 0x85              ;e081  85          UNKNOWN 0x85 
    .byte 0xf1              ;e082  f1          UNKNOWN 0xf1 
    .byte 0xa9              ;e083  a9          UNKNOWN 0xa9 
    .byte 0x42              ;e084  42          UNKNOWN 0x42 'B' 
    .byte 0x85              ;e085  85          UNKNOWN 0x85 
    .byte 0xf2              ;e086  f2          UNKNOWN 0xf2 
    .byte 0x80              ;e087  80          UNKNOWN 0x80 
    .byte 0x17              ;e088  17          UNKNOWN 0x17 
    .byte 0x20              ;e089  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e08a  90          UNKNOWN 0x90 
    .byte 0xe1              ;e08b  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e08c  b0          UNKNOWN 0xb0 
    .byte 0x0c              ;e08d  0c          UNKNOWN 0x0c 
    .byte 0xc9              ;e08e  c9          UNKNOWN 0xc9 
    .byte 0x02              ;e08f  02          UNKNOWN 0x02 
    .byte 0x90              ;e090  90          UNKNOWN 0x90 
    .byte 0x08              ;e091  08          UNKNOWN 0x08 
    .byte 0xc9              ;e092  c9          UNKNOWN 0xc9 
    .byte 0x1f              ;e093  1f          UNKNOWN 0x1f 
    .byte 0xb0              ;e094  b0          UNKNOWN 0xb0 
    .byte 0x04              ;e095  04          UNKNOWN 0x04 
    .byte 0x85              ;e096  85          UNKNOWN 0x85 
    .byte 0xf3              ;e097  f3          UNKNOWN 0xf3 
    .byte 0x80              ;e098  80          UNKNOWN 0x80 
    .byte 0x06              ;e099  06          UNKNOWN 0x06 
    .byte 0xa9              ;e09a  a9          UNKNOWN 0xa9 
    .byte 0x02              ;e09b  02          UNKNOWN 0x02 
    .byte 0x85              ;e09c  85          UNKNOWN 0x85 
    .byte 0xf3              ;e09d  f3          UNKNOWN 0xf3 
    .byte 0x80              ;e09e  80          UNKNOWN 0x80 
    .byte 0x00              ;e09f  00          UNKNOWN 0x00 
    .byte 0x20              ;e0a0  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;e0a1  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;e0a2  dd          UNKNOWN 0xdd 
    .byte 0x60              ;e0a3  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;e0a4  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e0a5  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e0a6  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e0a7  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e0a8  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e0a9  e2          UNKNOWN 0xe2 
    .byte 0xc9              ;e0aa  c9          UNKNOWN 0xc9 
    .byte 0x74              ;e0ab  74          UNKNOWN 0x74 't' 
    .byte 0xf0              ;e0ac  f0          UNKNOWN 0xf0 
    .byte 0xdb              ;e0ad  db          UNKNOWN 0xdb 
    .byte 0xc9              ;e0ae  c9          UNKNOWN 0xc9 
    .byte 0x6d              ;e0af  6d          UNKNOWN 0x6d 'm' 
    .byte 0xf0              ;e0b0  f0          UNKNOWN 0xf0 
    .byte 0x16              ;e0b1  16          UNKNOWN 0x16 
    .byte 0xc9              ;e0b2  c9          UNKNOWN 0xc9 
    .byte 0x6e              ;e0b3  6e          UNKNOWN 0x6e 'n' 
    .byte 0xf0              ;e0b4  f0          UNKNOWN 0xf0 
    .byte 0x1b              ;e0b5  1b          UNKNOWN 0x1b 
    .byte 0xc9              ;e0b6  c9          UNKNOWN 0xc9 
    .byte 0x61              ;e0b7  61          UNKNOWN 0x61 'a' 
    .byte 0xf0              ;e0b8  f0          UNKNOWN 0xf0 
    .byte 0x20              ;e0b9  20          UNKNOWN 0x20 ' ' 
    .byte 0xc9              ;e0ba  c9          UNKNOWN 0xc9 
    .byte 0x62              ;e0bb  62          UNKNOWN 0x62 'b' 
    .byte 0xf0              ;e0bc  f0          UNKNOWN 0xf0 
    .byte 0x25              ;e0bd  25          UNKNOWN 0x25 '%' 
    .byte 0xc9              ;e0be  c9          UNKNOWN 0xc9 
    .byte 0x63              ;e0bf  63          UNKNOWN 0x63 'c' 
    .byte 0xf0              ;e0c0  f0          UNKNOWN 0xf0 
    .byte 0x2c              ;e0c1  2c          UNKNOWN 0x2c ',' 
    .byte 0xc9              ;e0c2  c9          UNKNOWN 0xc9 
    .byte 0x64              ;e0c3  64          UNKNOWN 0x64 'd' 
    .byte 0xf0              ;e0c4  f0          UNKNOWN 0xf0 
    .byte 0x33              ;e0c5  33          UNKNOWN 0x33 '3' 
    .byte 0x80              ;e0c6  80          UNKNOWN 0x80 
    .byte 0x47              ;e0c7  47          UNKNOWN 0x47 'G' 
    .byte 0x20              ;e0c8  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e0c9  90          UNKNOWN 0x90 
    .byte 0xe1              ;e0ca  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e0cb  b0          UNKNOWN 0xb0 
    .byte 0x42              ;e0cc  42          UNKNOWN 0x42 'B' 
    .byte 0x85              ;e0cd  85          UNKNOWN 0x85 
    .byte 0xc0              ;e0ce  c0          UNKNOWN 0xc0 
    .byte 0x80              ;e0cf  80          UNKNOWN 0x80 
    .byte 0x3b              ;e0d0  3b          UNKNOWN 0x3b ';' 
    .byte 0x20              ;e0d1  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e0d2  90          UNKNOWN 0x90 
    .byte 0xe1              ;e0d3  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e0d4  b0          UNKNOWN 0xb0 
    .byte 0x39              ;e0d5  39          UNKNOWN 0x39 '9' 
    .byte 0x85              ;e0d6  85          UNKNOWN 0x85 
    .byte 0xc1              ;e0d7  c1          UNKNOWN 0xc1 
    .byte 0x80              ;e0d8  80          UNKNOWN 0x80 
    .byte 0x32              ;e0d9  32          UNKNOWN 0x32 '2' 
    .byte 0x20              ;e0da  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e0db  90          UNKNOWN 0x90 
    .byte 0xe1              ;e0dc  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e0dd  b0          UNKNOWN 0xb0 
    .byte 0x30              ;e0de  30          UNKNOWN 0x30 '0' 
    .byte 0x85              ;e0df  85          UNKNOWN 0x85 
    .byte 0xc2              ;e0e0  c2          UNKNOWN 0xc2 
    .byte 0x80              ;e0e1  80          UNKNOWN 0x80 
    .byte 0x29              ;e0e2  29          UNKNOWN 0x29 ')' 
    .byte 0x20              ;e0e3  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e0e4  90          UNKNOWN 0x90 
    .byte 0xe1              ;e0e5  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e0e6  b0          UNKNOWN 0xb0 
    .byte 0x27              ;e0e7  27          UNKNOWN 0x27 ''' 
    .byte 0x29              ;e0e8  29          UNKNOWN 0x29 ')' 
    .byte 0x03              ;e0e9  03          UNKNOWN 0x03 
    .byte 0x85              ;e0ea  85          UNKNOWN 0x85 
    .byte 0xc3              ;e0eb  c3          UNKNOWN 0xc3 
    .byte 0x80              ;e0ec  80          UNKNOWN 0x80 
    .byte 0x1e              ;e0ed  1e          UNKNOWN 0x1e 
    .byte 0x20              ;e0ee  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e0ef  90          UNKNOWN 0x90 
    .byte 0xe1              ;e0f0  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e0f1  b0          UNKNOWN 0xb0 
    .byte 0x1c              ;e0f2  1c          UNKNOWN 0x1c 
    .byte 0x29              ;e0f3  29          UNKNOWN 0x29 ')' 
    .byte 0xfe              ;e0f4  fe          UNKNOWN 0xfe 
    .byte 0x85              ;e0f5  85          UNKNOWN 0x85 
    .byte 0xc4              ;e0f6  c4          UNKNOWN 0xc4 
    .byte 0x80              ;e0f7  80          UNKNOWN 0x80 
    .byte 0x13              ;e0f8  13          UNKNOWN 0x13 
    .byte 0x20              ;e0f9  20          UNKNOWN 0x20 ' ' 
    .byte 0x90              ;e0fa  90          UNKNOWN 0x90 
    .byte 0xe1              ;e0fb  e1          UNKNOWN 0xe1 
    .byte 0xb0              ;e0fc  b0          UNKNOWN 0xb0 
    .byte 0x11              ;e0fd  11          UNKNOWN 0x11 
    .byte 0xc9              ;e0fe  c9          UNKNOWN 0xc9 
    .byte 0x00              ;e0ff  00          UNKNOWN 0x00 
    .byte 0xf0              ;e100  f0          UNKNOWN 0xf0 
    .byte 0x06              ;e101  06          UNKNOWN 0x06 
    .byte 0xc9              ;e102  c9          UNKNOWN 0xc9 
    .byte 0xf8              ;e103  f8          UNKNOWN 0xf8 
    .byte 0xb0              ;e104  b0          UNKNOWN 0xb0 
    .byte 0x02              ;e105  02          UNKNOWN 0x02 
    .byte 0xf0              ;e106  f0          UNKNOWN 0xf0 
    .byte 0x04              ;e107  04          UNKNOWN 0x04 
    .byte 0x85              ;e108  85          UNKNOWN 0x85 
    .byte 0xc5              ;e109  c5          UNKNOWN 0xc5 
    .byte 0x80              ;e10a  80          UNKNOWN 0x80 
    .byte 0x00              ;e10b  00          UNKNOWN 0x00 
    .byte 0x20              ;e10c  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;e10d  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;e10e  dd          UNKNOWN 0xdd 
    .byte 0x60              ;e10f  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;e110  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e111  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e112  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e113  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;e114  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;e115  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;e116  b0          UNKNOWN 0xb0 
    .byte 0x10              ;e117  10          UNKNOWN 0x10 
    .byte 0x0a              ;e118  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e119  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e11a  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e11b  0a          UNKNOWN 0x0a 
    .byte 0x85              ;e11c  85          UNKNOWN 0x85 
    .byte 0xf7              ;e11d  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e11e  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e11f  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e120  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e121  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;e122  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;e123  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;e124  b0          UNKNOWN 0xb0 
    .byte 0x02              ;e125  02          UNKNOWN 0x02 
    .byte 0x05              ;e126  05          UNKNOWN 0x05 
    .byte 0xf7              ;e127  f7          UNKNOWN 0xf7 
    .byte 0x60              ;e128  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;e129  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e12a  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e12b  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e12c  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e12d  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e12e  e2          UNKNOWN 0xe2 
    .byte 0xc9              ;e12f  c9          UNKNOWN 0xc9 
    .byte 0x73              ;e130  73          UNKNOWN 0x73 's' 
    .byte 0xd0              ;e131  d0          UNKNOWN 0xd0 
    .byte 0x43              ;e132  43          UNKNOWN 0x43 'C' 
    .byte 0x20              ;e133  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e134  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e135  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e136  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;e137  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;e138  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;e139  b0          UNKNOWN 0xb0 
    .byte 0x3b              ;e13a  3b          UNKNOWN 0x3b ';' 
    .byte 0x85              ;e13b  85          UNKNOWN 0x85 
    .byte 0xf8              ;e13c  f8          UNKNOWN 0xf8 
    .byte 0x20              ;e13d  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e13e  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e13f  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e140  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;e141  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;e142  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;e143  b0          UNKNOWN 0xb0 
    .byte 0x31              ;e144  31          UNKNOWN 0x31 '1' 
    .byte 0x0a              ;e145  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e146  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e147  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e148  0a          UNKNOWN 0x0a 
    .byte 0x85              ;e149  85          UNKNOWN 0x85 
    .byte 0xf7              ;e14a  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e14b  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e14c  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e14d  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e14e  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;e14f  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;e150  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;e151  b0          UNKNOWN 0xb0 
    .byte 0x23              ;e152  23          UNKNOWN 0x23 '#' 
    .byte 0x05              ;e153  05          UNKNOWN 0x05 
    .byte 0xf7              ;e154  f7          UNKNOWN 0xf7 
    .byte 0x85              ;e155  85          UNKNOWN 0x85 
    .byte 0xf7              ;e156  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e157  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e158  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e159  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e15a  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;e15b  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;e15c  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;e15d  b0          UNKNOWN 0xb0 
    .byte 0x17              ;e15e  17          UNKNOWN 0x17 
    .byte 0x0a              ;e15f  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e160  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e161  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e162  0a          UNKNOWN 0x0a 
    .byte 0x85              ;e163  85          UNKNOWN 0x85 
    .byte 0xf9              ;e164  f9          UNKNOWN 0xf9 
    .byte 0x20              ;e165  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e166  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e167  e2          UNKNOWN 0xe2 
    .byte 0x20              ;e168  20          UNKNOWN 0x20 ' ' 
    .byte 0x39              ;e169  39          UNKNOWN 0x39 '9' 
    .byte 0xe2              ;e16a  e2          UNKNOWN 0xe2 
    .byte 0xb0              ;e16b  b0          UNKNOWN 0xb0 
    .byte 0x09              ;e16c  09          UNKNOWN 0x09 
    .byte 0x05              ;e16d  05          UNKNOWN 0x05 
    .byte 0xf9              ;e16e  f9          UNKNOWN 0xf9 
    .byte 0xa0              ;e16f  a0          UNKNOWN 0xa0 
    .byte 0x00              ;e170  00          UNKNOWN 0x00 
    .byte 0x91              ;e171  91          UNKNOWN 0x91 
    .byte 0xf7              ;e172  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e173  20          UNKNOWN 0x20 ' ' 
    .byte 0xc1              ;e174  c1          UNKNOWN 0xc1 
    .byte 0xdd              ;e175  dd          UNKNOWN 0xdd 
    .byte 0x60              ;e176  60          UNKNOWN 0x60 '`' 
    .byte 0x20              ;e177  20          UNKNOWN 0x20 ' ' 
    .byte 0x71              ;e178  71          UNKNOWN 0x71 'q' 
    .byte 0xe2              ;e179  e2          UNKNOWN 0xe2 
    .byte 0xcf              ;e17a  cf          UNKNOWN 0xcf 
    .byte 0xbf              ;e17b  bf          UNKNOWN 0xbf 
    .byte 0x3c              ;e17c  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e17d  00          UNKNOWN 0x00 
    .byte 0xc9              ;e17e  c9          UNKNOWN 0xc9 
    .byte 0x60              ;e17f  60          UNKNOWN 0x60 '`' 
    .byte 0xea              ;e180  ea          UNKNOWN 0xea 
    .byte 0xf7              ;e181  f7          UNKNOWN 0xf7 
    .byte 0x95              ;e182  95          UNKNOWN 0x95 
    .byte 0xfc              ;e183  fc          UNKNOWN 0xfc 
    .byte 0xa2              ;e184  a2          UNKNOWN 0xa2 
    .byte 0x00              ;e185  00          UNKNOWN 0x00 
    .byte 0xff              ;e186  ff          UNKNOWN 0xff 
    .byte 0x95              ;e187  95          UNKNOWN 0x95 
    .byte 0xbd              ;e188  bd          UNKNOWN 0xbd 
    .byte 0x31              ;e189  31          UNKNOWN 0x31 '1' 
    .byte 0xe2              ;e18a  e2          UNKNOWN 0xe2 
    .byte 0xc9              ;e18b  c9          UNKNOWN 0xc9 
    .byte 0xff              ;e18c  ff          UNKNOWN 0xff 
    .byte 0xf0              ;e18d  f0          UNKNOWN 0xf0 
    .byte 0x1f              ;e18e  1f          UNKNOWN 0x1f 
    .byte 0x03              ;e18f  03          UNKNOWN 0x03 
    .byte 0x04              ;e190  04          UNKNOWN 0x04 
    .byte 0xaf              ;e191  af          UNKNOWN 0xaf 
    .byte 0x04              ;e192  04          UNKNOWN 0x04 
    .byte 0x80              ;e193  80          UNKNOWN 0x80 
    .byte 0x02              ;e194  02          UNKNOWN 0x02 
    .byte 0xbf              ;e195  bf          UNKNOWN 0xbf 
    .byte 0x04              ;e196  04          UNKNOWN 0x04 
    .byte 0x23              ;e197  23          UNKNOWN 0x23 '#' 
    .byte 0x04              ;e198  04          UNKNOWN 0x04 
    .byte 0x8f              ;e199  8f          UNKNOWN 0x8f 
    .byte 0x04              ;e19a  04          UNKNOWN 0x04 
    .byte 0x80              ;e19b  80          UNKNOWN 0x80 
    .byte 0x02              ;e19c  02          UNKNOWN 0x02 
    .byte 0x9f              ;e19d  9f          UNKNOWN 0x9f 
    .byte 0x04              ;e19e  04          UNKNOWN 0x04 
    .byte 0x43              ;e19f  43          UNKNOWN 0x43 'C' 
    .byte 0x04              ;e1a0  04          UNKNOWN 0x04 
    .byte 0xcf              ;e1a1  cf          UNKNOWN 0xcf 
    .byte 0x0a              ;e1a2  0a          UNKNOWN 0x0a 
    .byte 0x80              ;e1a3  80          UNKNOWN 0x80 
    .byte 0x02              ;e1a4  02          UNKNOWN 0x02 
    .byte 0xdf              ;e1a5  df          UNKNOWN 0xdf 
    .byte 0x0a              ;e1a6  0a          UNKNOWN 0x0a 
    .byte 0xe8              ;e1a7  e8          UNKNOWN 0xe8 
    .byte 0xea              ;e1a8  ea          UNKNOWN 0xea 
    .byte 0xf7              ;e1a9  f7          UNKNOWN 0xf7 
    .byte 0x95              ;e1aa  95          UNKNOWN 0x95 
    .byte 0xfc              ;e1ab  fc          UNKNOWN 0xfc 
    .byte 0x80              ;e1ac  80          UNKNOWN 0x80 
    .byte 0xd8              ;e1ad  d8          UNKNOWN 0xd8 
    .byte 0xdf              ;e1ae  df          UNKNOWN 0xdf 
    .byte 0xbf              ;e1af  bf          UNKNOWN 0xbf 
    .byte 0x64              ;e1b0  64          UNKNOWN 0x64 'd' 
    .byte 0x00              ;e1b1  00          UNKNOWN 0x00 
    .byte 0x01              ;e1b2  01          UNKNOWN 0x01 
    .byte 0x03              ;e1b3  03          UNKNOWN 0x03 
    .byte 0x02              ;e1b4  02          UNKNOWN 0x02 
    .byte 0x00              ;e1b5  00          UNKNOWN 0x00 
    .byte 0x02              ;e1b6  02          UNKNOWN 0x02 
    .byte 0x00              ;e1b7  00          UNKNOWN 0x00 
    .byte 0xff              ;e1b8  ff          UNKNOWN 0xff 
    .byte 0xc9              ;e1b9  c9          UNKNOWN 0xc9 
    .byte 0x67              ;e1ba  67          UNKNOWN 0x67 'g' 
    .byte 0xb0              ;e1bb  b0          UNKNOWN 0xb0 
    .byte 0x16              ;e1bc  16          UNKNOWN 0x16 
    .byte 0xc9              ;e1bd  c9          UNKNOWN 0xc9 
    .byte 0x61              ;e1be  61          UNKNOWN 0x61 'a' 
    .byte 0xb0              ;e1bf  b0          UNKNOWN 0xb0 
    .byte 0x0d              ;e1c0  0d          UNKNOWN 0x0d 
    .byte 0xc9              ;e1c1  c9          UNKNOWN 0xc9 
    .byte 0x30              ;e1c2  30          UNKNOWN 0x30 '0' 
    .byte 0x90              ;e1c3  90          UNKNOWN 0x90 
    .byte 0x0e              ;e1c4  0e          UNKNOWN 0x0e 
    .byte 0xc9              ;e1c5  c9          UNKNOWN 0xc9 
    .byte 0x3a              ;e1c6  3a          UNKNOWN 0x3a ':' 
    .byte 0xb0              ;e1c7  b0          UNKNOWN 0xb0 
    .byte 0x0a              ;e1c8  0a          UNKNOWN 0x0a 
    .byte 0x38              ;e1c9  38          UNKNOWN 0x38 '8' 
    .byte 0xe9              ;e1ca  e9          UNKNOWN 0xe9 
    .byte 0x30              ;e1cb  30          UNKNOWN 0x30 '0' 
    .byte 0x18              ;e1cc  18          UNKNOWN 0x18 
    .byte 0x60              ;e1cd  60          UNKNOWN 0x60 '`' 
    .byte 0x38              ;e1ce  38          UNKNOWN 0x38 '8' 
    .byte 0xe9              ;e1cf  e9          UNKNOWN 0xe9 
    .byte 0x57              ;e1d0  57          UNKNOWN 0x57 'W' 
    .byte 0x18              ;e1d1  18          UNKNOWN 0x18 
    .byte 0x60              ;e1d2  60          UNKNOWN 0x60 '`' 
    .byte 0x38              ;e1d3  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;e1d4  60          UNKNOWN 0x60 '`' 
    .byte 0xc9              ;e1d5  c9          UNKNOWN 0xc9 
    .byte 0x7b              ;e1d6  7b          UNKNOWN 0x7b '{' 
    .byte 0xb0              ;e1d7  b0          UNKNOWN 0xb0 
    .byte 0x16              ;e1d8  16          UNKNOWN 0x16 
    .byte 0xc9              ;e1d9  c9          UNKNOWN 0xc9 
    .byte 0x61              ;e1da  61          UNKNOWN 0x61 'a' 
    .byte 0xb0              ;e1db  b0          UNKNOWN 0xb0 
    .byte 0x0d              ;e1dc  0d          UNKNOWN 0x0d 
    .byte 0xc9              ;e1dd  c9          UNKNOWN 0xc9 
    .byte 0x30              ;e1de  30          UNKNOWN 0x30 '0' 
    .byte 0x90              ;e1df  90          UNKNOWN 0x90 
    .byte 0x0e              ;e1e0  0e          UNKNOWN 0x0e 
    .byte 0xc9              ;e1e1  c9          UNKNOWN 0xc9 
    .byte 0x3a              ;e1e2  3a          UNKNOWN 0x3a ':' 
    .byte 0xb0              ;e1e3  b0          UNKNOWN 0xb0 
    .byte 0x0a              ;e1e4  0a          UNKNOWN 0x0a 
    .byte 0x38              ;e1e5  38          UNKNOWN 0x38 '8' 
    .byte 0xe9              ;e1e6  e9          UNKNOWN 0xe9 
    .byte 0x30              ;e1e7  30          UNKNOWN 0x30 '0' 
    .byte 0x18              ;e1e8  18          UNKNOWN 0x18 
    .byte 0x60              ;e1e9  60          UNKNOWN 0x60 '`' 
    .byte 0x38              ;e1ea  38          UNKNOWN 0x38 '8' 
    .byte 0xe9              ;e1eb  e9          UNKNOWN 0xe9 
    .byte 0x57              ;e1ec  57          UNKNOWN 0x57 'W' 
    .byte 0x18              ;e1ed  18          UNKNOWN 0x18 
    .byte 0x60              ;e1ee  60          UNKNOWN 0x60 '`' 
    .byte 0x38              ;e1ef  38          UNKNOWN 0x38 '8' 
    .byte 0x60              ;e1f0  60          UNKNOWN 0x60 '`' 
    .byte 0xa4              ;e1f1  a4          UNKNOWN 0xa4 
    .byte 0xbe              ;e1f2  be          UNKNOWN 0xbe 
    .byte 0xc4              ;e1f3  c4          UNKNOWN 0xc4 
    .byte 0xbd              ;e1f4  bd          UNKNOWN 0xbd 
    .byte 0xf0              ;e1f5  f0          UNKNOWN 0xf0 
    .byte 0x0b              ;e1f6  0b          UNKNOWN 0x0b 
    .byte 0x08              ;e1f7  08          UNKNOWN 0x08 
    .byte 0x78              ;e1f8  78          UNKNOWN 0x78 'x' 
    .byte 0xb9              ;e1f9  b9          UNKNOWN 0xb9 
    .byte 0x1b              ;e1fa  1b          UNKNOWN 0x1b 
    .byte 0x01              ;e1fb  01          UNKNOWN 0x01 
    .byte 0xe6              ;e1fc  e6          UNKNOWN 0xe6 
    .byte 0xbe              ;e1fd  be          UNKNOWN 0xbe 
    .byte 0xbf              ;e1fe  bf          UNKNOWN 0xbf 
    .byte 0xbe              ;e1ff  be          UNKNOWN 0xbe 

sub_e200:
    plp                     ;e200  28       
    nop                     ;e201  ea       
    rts                     ;e202  60       

    .byte 0xa4              ;e203  a4          UNKNOWN 0xa4 
    .byte 0xbe              ;e204  be          UNKNOWN 0xbe 
    .byte 0xc4              ;e205  c4          UNKNOWN 0xc4 
    .byte 0xbd              ;e206  bd          UNKNOWN 0xbd 
    .byte 0xf0              ;e207  f0          UNKNOWN 0xf0 
    .byte 0x0d              ;e208  0d          UNKNOWN 0x0d 
    .byte 0x08              ;e209  08          UNKNOWN 0x08 
    .byte 0x8a              ;e20a  8a          UNKNOWN 0x8a 
    .byte 0x18              ;e20b  18          UNKNOWN 0x18 
    .byte 0x65              ;e20c  65          UNKNOWN 0x65 'e' 
    .byte 0xbe              ;e20d  be          UNKNOWN 0xbe 
    .byte 0x29              ;e20e  29          UNKNOWN 0x29 ')' 
    .byte 0x1f              ;e20f  1f          UNKNOWN 0x1f 
    .byte 0xa8              ;e210  a8          UNKNOWN 0xa8 
    .byte 0xb9              ;e211  b9          UNKNOWN 0xb9 
    .byte 0x1b              ;e212  1b          UNKNOWN 0x1b 
    .byte 0x01              ;e213  01          UNKNOWN 0x01 
    .byte 0x28              ;e214  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;e215  ea          UNKNOWN 0xea 
    .byte 0x60              ;e216  60          UNKNOWN 0x60 '`' 
    .byte 0xa4              ;e217  a4          UNKNOWN 0xa4 
    .byte 0xbd              ;e218  bd          UNKNOWN 0xbd 
    .byte 0x98              ;e219  98          UNKNOWN 0x98 
    .byte 0xc4              ;e21a  c4          UNKNOWN 0xc4 
    .byte 0xbe              ;e21b  be          UNKNOWN 0xbe 
    .byte 0xf0              ;e21c  f0          UNKNOWN 0xf0 
    .byte 0x0b              ;e21d  0b          UNKNOWN 0x0b 
    .byte 0x08              ;e21e  08          UNKNOWN 0x08 
    .byte 0x78              ;e21f  78          UNKNOWN 0x78 'x' 
    .byte 0xb0              ;e220  b0          UNKNOWN 0xb0 
    .byte 0x02              ;e221  02          UNKNOWN 0x02 
    .byte 0x69              ;e222  69          UNKNOWN 0x69 'i' 
    .byte 0x20              ;e223  20          UNKNOWN 0x20 ' ' 
    .byte 0x38              ;e224  38          UNKNOWN 0x38 '8' 
    .byte 0xe5              ;e225  e5          UNKNOWN 0xe5 
    .byte 0xbe              ;e226  be          UNKNOWN 0xbe 
    .byte 0x28              ;e227  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;e228  ea          UNKNOWN 0xea 
    .byte 0x60              ;e229  60          UNKNOWN 0x60 '`' 
    .byte 0x48              ;e22a  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;e22b  8a          UNKNOWN 0x8a 
    .byte 0x48              ;e22c  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;e22d  98          UNKNOWN 0x98 
    .byte 0x48              ;e22e  48          UNKNOWN 0x48 'H' 
    .byte 0x20              ;e22f  20          UNKNOWN 0x20 ' ' 
    .byte 0xb8              ;e230  b8          UNKNOWN 0xb8 
    .byte 0xe2              ;e231  e2          UNKNOWN 0xe2 
    .byte 0x68              ;e232  68          UNKNOWN 0x68 'h' 
    .byte 0xa8              ;e233  a8          UNKNOWN 0xa8 
    .byte 0x68              ;e234  68          UNKNOWN 0x68 'h' 
    .byte 0xaa              ;e235  aa          UNKNOWN 0xaa 
    .byte 0x68              ;e236  68          UNKNOWN 0x68 'h' 
    .byte 0x40              ;e237  40          UNKNOWN 0x40 '@' 
    .byte 0xa9              ;e238  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e239  00          UNKNOWN 0x00 
    .byte 0xc5              ;e23a  c5          UNKNOWN 0xc5 
    .byte 0xbb              ;e23b  bb          UNKNOWN 0xbb 
    .byte 0xf0              ;e23c  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;e23d  0c          UNKNOWN 0x0c 
    .byte 0xa6              ;e23e  a6          UNKNOWN 0xa6 
    .byte 0xbc              ;e23f  bc          UNKNOWN 0xbc 
    .byte 0xb5              ;e240  b5          UNKNOWN 0xb5 

sub_e241:
    tax                     ;e241  aa       
    sta TB_RB               ;e242  85 18    
    inc mem_00bc            ;e244  e6 bc    
    dec mem_00bb            ;e246  c6 bb    
    bne lab_e24e            ;e248  d0 04    
    clb 3,ICON1             ;e24a  7f 3e    
    clb 3,IREQ1             ;e24c  7f 3c    

lab_e24e:
    rts                     ;e24e  60       

    .byte 0x48              ;e24f  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;e250  8a          UNKNOWN 0x8a 
    .byte 0x48              ;e251  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;e252  98          UNKNOWN 0x98 
    .byte 0x48              ;e253  48          UNKNOWN 0x48 'H' 
    .byte 0xa6              ;e254  a6          UNKNOWN 0xa6 
    .byte 0xbd              ;e255  bd          UNKNOWN 0xbd 
    .byte 0xa5              ;e256  a5          UNKNOWN 0xa5 
    .byte 0x18              ;e257  18          UNKNOWN 0x18 
    .byte 0x9d              ;e258  9d          UNKNOWN 0x9d 
    .byte 0x1b              ;e259  1b          UNKNOWN 0x1b 
    .byte 0x01              ;e25a  01          UNKNOWN 0x01 
    .byte 0x8a              ;e25b  8a          UNKNOWN 0x8a 
    .byte 0x3a              ;e25c  3a          UNKNOWN 0x3a ':' 
    .byte 0x29              ;e25d  29          UNKNOWN 0x29 ')' 
    .byte 0x1f              ;e25e  1f          UNKNOWN 0x1f 
    .byte 0xc5              ;e25f  c5          UNKNOWN 0xc5 
    .byte 0xbe              ;e260  be          UNKNOWN 0xbe 
    .byte 0xf0              ;e261  f0          UNKNOWN 0xf0 
    .byte 0x02              ;e262  02          UNKNOWN 0x02 
    .byte 0x85              ;e263  85          UNKNOWN 0x85 
    .byte 0xbd              ;e264  bd          UNKNOWN 0xbd 
    .byte 0x68              ;e265  68          UNKNOWN 0x68 'h' 
    .byte 0xa8              ;e266  a8          UNKNOWN 0xa8 
    .byte 0x68              ;e267  68          UNKNOWN 0x68 'h' 
    .byte 0xaa              ;e268  aa          UNKNOWN 0xaa 
    .byte 0x68              ;e269  68          UNKNOWN 0x68 'h' 
    .byte 0x40              ;e26a  40          UNKNOWN 0x40 '@' 
    .byte 0x48              ;e26b  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;e26c  8a          UNKNOWN 0x8a 
    .byte 0x48              ;e26d  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;e26e  98          UNKNOWN 0x98 
    .byte 0x48              ;e26f  48          UNKNOWN 0x48 'H' 
    .byte 0x07              ;e270  07          UNKNOWN 0x07 

sub_e271:
    php                     ;e271  08       
    asl mem_083c            ;e272  0e 3c 08 
    .byte 0xdc              ;e275  dc       Illegal instruction

    .byte 0x7f              ;e276  7f          UNKNOWN 0x7f 
    .byte 0x3f              ;e277  3f          UNKNOWN 0x3f '?' 
    .byte 0x3c              ;e278  3c          UNKNOWN 0x3c '<' 
    .byte 0x53              ;e279  53          UNKNOWN 0x53 'S' 
    .byte 0x25              ;e27a  25          UNKNOWN 0x25 '%' 
    .byte 0xea              ;e27b  ea          UNKNOWN 0xea 
    .byte 0xea              ;e27c  ea          UNKNOWN 0xea 
    .byte 0xdf              ;e27d  df          UNKNOWN 0xdf 
    .byte 0x3c              ;e27e  3c          UNKNOWN 0x3c '<' 
    .byte 0xcf              ;e27f  cf          UNKNOWN 0xcf 
    .byte 0x3e              ;e280  3e          UNKNOWN 0x3e '>' 
    .byte 0x68              ;e281  68          UNKNOWN 0x68 'h' 
    .byte 0xa8              ;e282  a8          UNKNOWN 0xa8 

sub_e283:
    pla                     ;e283  68       
    tax                     ;e284  aa       
    pla                     ;e285  68       
    rti                     ;e286  40       

    .byte 0x48              ;e287  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;e288  8a          UNKNOWN 0x8a 
    .byte 0x48              ;e289  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;e28a  98          UNKNOWN 0x98 
    .byte 0x48              ;e28b  48          UNKNOWN 0x48 'H' 
    .byte 0xc6              ;e28c  c6          UNKNOWN 0xc6 
    .byte 0xdc              ;e28d  dc          UNKNOWN 0xdc 
    .byte 0xd0              ;e28e  d0          UNKNOWN 0xd0 
    .byte 0x10              ;e28f  10          UNKNOWN 0x10 
    .byte 0x7f              ;e290  7f          UNKNOWN 0x7f 
    .byte 0x3d              ;e291  3d          UNKNOWN 0x3d '=' 
    .byte 0x6f              ;e292  6f          UNKNOWN 0x6f 'o' 
    .byte 0x3f              ;e293  3f          UNKNOWN 0x3f '?' 
    .byte 0xdf              ;e294  df          UNKNOWN 0xdf 
    .byte 0x3c              ;e295  3c          UNKNOWN 0x3c '<' 
    .byte 0xdf              ;e296  df          UNKNOWN 0xdf 
    .byte 0x3e              ;e297  3e          UNKNOWN 0x3e '>' 
    .byte 0xa5              ;e298  a5          UNKNOWN 0xa5 
    .byte 0xde              ;e299  de          UNKNOWN 0xde 
    .byte 0x85              ;e29a  85          UNKNOWN 0x85 
    .byte 0xdd              ;e29b  dd          UNKNOWN 0xdd 
    .byte 0x0f              ;e29c  0f          UNKNOWN 0x0f 
    .byte 0xdb              ;e29d  db          UNKNOWN 0xdb 
    .byte 0x80              ;e29e  80          UNKNOWN 0x80 
    .byte 0x0a              ;e29f  0a          UNKNOWN 0x0a 
    .byte 0x3c              ;e2a0  3c          UNKNOWN 0x3c '<' 
    .byte 0x3f              ;e2a1  3f          UNKNOWN 0x3f '?' 
    .byte 0x25              ;e2a2  25          UNKNOWN 0x25 '%' 
    .byte 0x38              ;e2a3  38          UNKNOWN 0x38 '8' 
    .byte 0x07              ;e2a4  07          UNKNOWN 0x07 
    .byte 0x08              ;e2a5  08          UNKNOWN 0x08 
    .byte 0x01              ;e2a6  01          UNKNOWN 0x01 
    .byte 0x18              ;e2a7  18          UNKNOWN 0x18 
    .byte 0x66              ;e2a8  66          UNKNOWN 0x66 'f' 
    .byte 0xde              ;e2a9  de          UNKNOWN 0xde 

lab_e2aa:
    pla                     ;e2aa  68       
    tay                     ;e2ab  a8       
    pla                     ;e2ac  68       
    tax                     ;e2ad  aa       
    pla                     ;e2ae  68       
    rti                     ;e2af  40       

    .byte 0x20              ;e2b0  20          UNKNOWN 0x20 ' ' 
    .byte 0x5f              ;e2b1  5f          UNKNOWN 0x5f '_' 
    .byte 0xe3              ;e2b2  e3          UNKNOWN 0xe3 
    .byte 0x08              ;e2b3  08          UNKNOWN 0x08 
    .byte 0x78              ;e2b4  78          UNKNOWN 0x78 'x' 
    .byte 0x86              ;e2b5  86          UNKNOWN 0x86 
    .byte 0xe2              ;e2b6  e2          UNKNOWN 0xe2 
    .byte 0x84              ;e2b7  84          UNKNOWN 0x84 
    .byte 0xe3              ;e2b8  e3          UNKNOWN 0xe3 
    .byte 0x3c              ;e2b9  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e2ba  00          UNKNOWN 0x00 
    .byte 0xe1              ;e2bb  e1          UNKNOWN 0xe1 
    .byte 0xff              ;e2bc  ff          UNKNOWN 0xff 
    .byte 0x3c              ;e2bd  3c          UNKNOWN 0x3c '<' 
    .byte 0xef              ;e2be  ef          UNKNOWN 0xef 
    .byte 0x3e              ;e2bf  3e          UNKNOWN 0x3e '>' 
    .byte 0x28              ;e2c0  28          UNKNOWN 0x28 '(' 
    .byte 0xea              ;e2c1  ea          UNKNOWN 0xea 
    .byte 0x60              ;e2c2  60          UNKNOWN 0x60 '`' 
    .byte 0x48              ;e2c3  48          UNKNOWN 0x48 'H' 
    .byte 0x20              ;e2c4  20          UNKNOWN 0x20 ' ' 
    .byte 0x5f              ;e2c5  5f          UNKNOWN 0x5f '_' 
    .byte 0xe3              ;e2c6  e3          UNKNOWN 0xe3 
    .byte 0x68              ;e2c7  68          UNKNOWN 0x68 'h' 
    .byte 0x08              ;e2c8  08          UNKNOWN 0x08 
    .byte 0x78              ;e2c9  78          UNKNOWN 0x78 'x' 
    .byte 0x85              ;e2ca  85          UNKNOWN 0x85 
    .byte 0xe4              ;e2cb  e4          UNKNOWN 0xe4 
    .byte 0x3c              ;e2cc  3c          UNKNOWN 0x3c '<' 
    .byte 0x24              ;e2cd  24          UNKNOWN 0x24 '$' 
    .byte 0xe5              ;e2ce  e5          UNKNOWN 0xe5 

lab_e2cf:
    ldm #0xe4,mem_00e2      ;e2cf  3c e4 e2 
    ldm #0x00,mem_00e3      ;e2d2  3c 00 e3 
    ldm #0x00,mem_00e1      ;e2d5  3c 00 e1 
    clb 7,IREQ1             ;e2d8  ff 3c    
    seb 7,ICON1             ;e2da  ef 3e    
    plp                     ;e2dc  28       
    nop                     ;e2dd  ea       
    rts                     ;e2de  60       

    .byte 0xea              ;e2df  ea          UNKNOWN 0xea 
    .byte 0xe7              ;e2e0  e7          UNKNOWN 0xe7 
    .byte 0x3e              ;e2e1  3e          UNKNOWN 0x3e '>' 
    .byte 0xfc              ;e2e2  fc          UNKNOWN 0xfc 
    .byte 0xa5              ;e2e3  a5          UNKNOWN 0xa5 
    .byte 0xe1              ;e2e4  e1          UNKNOWN 0xe1 
    .byte 0x60              ;e2e5  60          UNKNOWN 0x60 '`' 
    .byte 0x48              ;e2e6  48          UNKNOWN 0x48 'H' 
    .byte 0x8a              ;e2e7  8a          UNKNOWN 0x8a 
    .byte 0x48              ;e2e8  48          UNKNOWN 0x48 'H' 
    .byte 0x98              ;e2e9  98          UNKNOWN 0x98 
    .byte 0x48              ;e2ea  48          UNKNOWN 0x48 'H' 
    .byte 0xa5              ;e2eb  a5          UNKNOWN 0xa5 
    .byte 0xdf              ;e2ec  df          UNKNOWN 0xdf 
    .byte 0xd0              ;e2ed  d0          UNKNOWN 0xd0 
    .byte 0x17              ;e2ee  17          UNKNOWN 0x17 
    .byte 0xa4              ;e2ef  a4          UNKNOWN 0xa4 
    .byte 0xe1              ;e2f0  e1          UNKNOWN 0xe1 
    .byte 0xb1              ;e2f1  b1          UNKNOWN 0xb1 
    .byte 0xe2              ;e2f2  e2          UNKNOWN 0xe2 
    .byte 0xe6              ;e2f3  e6          UNKNOWN 0xe6 
    .byte 0xe1              ;e2f4  e1          UNKNOWN 0xe1 
    .byte 0xc9              ;e2f5  c9          UNKNOWN 0xc9 
    .byte 0x24              ;e2f6  24          UNKNOWN 0x24 '$' 
    .byte 0xd0              ;e2f7  d0          UNKNOWN 0xd0 
    .byte 0x04              ;e2f8  04          UNKNOWN 0x04 
    .byte 0xff              ;e2f9  ff          UNKNOWN 0xff 
    .byte 0x3e              ;e2fa  3e          UNKNOWN 0x3e '>' 
    .byte 0x80              ;e2fb  80          UNKNOWN 0x80 
    .byte 0x1b              ;e2fc  1b          UNKNOWN 0x1b 
    .byte 0x85              ;e2fd  85          UNKNOWN 0x85 
    .byte 0xe0              ;e2fe  e0          UNKNOWN 0xe0 
    .byte 0xdf              ;e2ff  df          UNKNOWN 0xdf 
    .byte 0x08              ;e300  08          UNKNOWN 0x08 
    .byte 0x3c              ;e301  3c          UNKNOWN 0x3c '<' 
    .byte 0x09              ;e302  09          UNKNOWN 0x09 
    .byte 0xdf              ;e303  df          UNKNOWN 0xdf 
    .byte 0x80              ;e304  80          UNKNOWN 0x80 
    .byte 0x12              ;e305  12          UNKNOWN 0x12 
    .byte 0xc6              ;e306  c6          UNKNOWN 0xc6 

lab_e307:
    clb 6,mem_00d0          ;e307  df d0    
    .byte 0x04              ;e309  04       Illegal instruction

    .byte 0xcf              ;e30a  cf          UNKNOWN 0xcf 
    .byte 0x08              ;e30b  08          UNKNOWN 0x08 
    .byte 0x80              ;e30c  80          UNKNOWN 0x80 
    .byte 0x0a              ;e30d  0a          UNKNOWN 0x0a 
    .byte 0x66              ;e30e  66          UNKNOWN 0x66 'f' 
    .byte 0xe0              ;e30f  e0          UNKNOWN 0xe0 
    .byte 0xb0              ;e310  b0          UNKNOWN 0xb0 
    .byte 0x04              ;e311  04          UNKNOWN 0x04 
    .byte 0xdf              ;e312  df          UNKNOWN 0xdf 
    .byte 0x08              ;e313  08          UNKNOWN 0x08 
    .byte 0x80              ;e314  80          UNKNOWN 0x80 
    .byte 0x02              ;e315  02          UNKNOWN 0x02 
    .byte 0xcf              ;e316  cf          UNKNOWN 0xcf 
    .byte 0x08              ;e317  08          UNKNOWN 0x08 
    .byte 0x68              ;e318  68          UNKNOWN 0x68 'h' 
    .byte 0xa8              ;e319  a8          UNKNOWN 0xa8 
    .byte 0x68              ;e31a  68          UNKNOWN 0x68 'h' 
    .byte 0xaa              ;e31b  aa          UNKNOWN 0xaa 
    .byte 0x68              ;e31c  68          UNKNOWN 0x68 'h' 
    .byte 0x40              ;e31d  40          UNKNOWN 0x40 '@' 
    .byte 0xa9              ;e31e  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e31f  00          UNKNOWN 0x00 
    .byte 0x85              ;e320  85          UNKNOWN 0x85 
    .byte 0xf8              ;e321  f8          UNKNOWN 0xf8 
    .byte 0x85              ;e322  85          UNKNOWN 0x85 
    .byte 0xf7              ;e323  f7          UNKNOWN 0xf7 
    .byte 0xad              ;e324  ad          UNKNOWN 0xad 
    .byte 0x14              ;e325  14          UNKNOWN 0x14 
    .byte 0x01              ;e326  01          UNKNOWN 0x01 
    .byte 0x8d              ;e327  8d          UNKNOWN 0x8d 
    .byte 0x15              ;e328  15          UNKNOWN 0x15 
    .byte 0x01              ;e329  01          UNKNOWN 0x01 
    .byte 0xa0              ;e32a  a0          UNKNOWN 0xa0 
    .byte 0xf7              ;e32b  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e32c  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;e32d  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;e32e  e6          UNKNOWN 0xe6 
    .byte 0xad              ;e32f  ad          UNKNOWN 0xad 
    .byte 0x13              ;e330  13          UNKNOWN 0x13 
    .byte 0x01              ;e331  01          UNKNOWN 0x01 
    .byte 0x8d              ;e332  8d          UNKNOWN 0x8d 
    .byte 0x14              ;e333  14          UNKNOWN 0x14 
    .byte 0x01              ;e334  01          UNKNOWN 0x01 
    .byte 0xa0              ;e335  a0          UNKNOWN 0xa0 
    .byte 0xf7              ;e336  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e337  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;e338  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;e339  e6          UNKNOWN 0xe6 
    .byte 0xad              ;e33a  ad          UNKNOWN 0xad 
    .byte 0x12              ;e33b  12          UNKNOWN 0x12 
    .byte 0x01              ;e33c  01          UNKNOWN 0x01 
    .byte 0x8d              ;e33d  8d          UNKNOWN 0x8d 
    .byte 0x13              ;e33e  13          UNKNOWN 0x13 
    .byte 0x01              ;e33f  01          UNKNOWN 0x01 
    .byte 0xa0              ;e340  a0          UNKNOWN 0xa0 
    .byte 0xf7              ;e341  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e342  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;e343  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;e344  e6          UNKNOWN 0xe6 
    .byte 0xa5              ;e345  a5          UNKNOWN 0xa5 
    .byte 0x72              ;e346  72          UNKNOWN 0x72 'r' 
    .byte 0x8d              ;e347  8d          UNKNOWN 0x8d 
    .byte 0x12              ;e348  12          UNKNOWN 0x12 
    .byte 0x01              ;e349  01          UNKNOWN 0x01 
    .byte 0xa0              ;e34a  a0          UNKNOWN 0xa0 
    .byte 0xf7              ;e34b  f7          UNKNOWN 0xf7 
    .byte 0x20              ;e34c  20          UNKNOWN 0x20 ' ' 
    .byte 0x69              ;e34d  69          UNKNOWN 0x69 'i' 
    .byte 0xe6              ;e34e  e6          UNKNOWN 0xe6 
    .byte 0x46              ;e34f  46          UNKNOWN 0x46 'F' 
    .byte 0xf8              ;e350  f8          UNKNOWN 0xf8 
    .byte 0x66              ;e351  66          UNKNOWN 0x66 'f' 
    .byte 0xf7              ;e352  f7          UNKNOWN 0xf7 
    .byte 0x46              ;e353  46          UNKNOWN 0x46 'F' 
    .byte 0xf8              ;e354  f8          UNKNOWN 0xf8 
    .byte 0x66              ;e355  66          UNKNOWN 0x66 'f' 
    .byte 0xf7              ;e356  f7          UNKNOWN 0xf7 
    .byte 0xa5              ;e357  a5          UNKNOWN 0xa5 
    .byte 0xf7              ;e358  f7          UNKNOWN 0xf7 
    .byte 0x8d              ;e359  8d          UNKNOWN 0x8d 
    .byte 0x11              ;e35a  11          UNKNOWN 0x11 
    .byte 0x01              ;e35b  01          UNKNOWN 0x01 
    .byte 0x20              ;e35c  20          UNKNOWN 0x20 ' ' 
    .byte 0x19              ;e35d  19          UNKNOWN 0x19 
    .byte 0xe4              ;e35e  e4          UNKNOWN 0xe4 
    .byte 0x8d              ;e35f  8d          UNKNOWN 0x8d 
    .byte 0x10              ;e360  10          UNKNOWN 0x10 
    .byte 0x01              ;e361  01          UNKNOWN 0x01 
    .byte 0x60              ;e362  60          UNKNOWN 0x60 '`' 
    .byte 0xb7              ;e363  b7          UNKNOWN 0xb7 
    .byte 0x95              ;e364  95          UNKNOWN 0x95 
    .byte 0x19              ;e365  19          UNKNOWN 0x19 

lab_e366:
    lda mem_006c            ;e366  a5 6c    
    and #0x0f               ;e368  29 0f    
    beq lab_e37f            ;e36a  f0 13    
    clb 5,mem_0095          ;e36c  bf 95    
    lda mem_0093            ;e36e  a5 93    
    sta mem_0092            ;e370  85 92    
    lda mem_0094            ;e372  a5 94    
    sta mem_0093            ;e374  85 93    
    lda mem_0072            ;e376  a5 72    
    sta mem_0094            ;e378  85 94    
    sec                     ;e37a  38       
    sbc mem_0092            ;e37b  e5 92    
    sec                     ;e37d  38       
    rts                     ;e37e  60       

lab_e37f:
    clc                     ;e37f  18       
    rts                     ;e380  60       

    .byte 0x20              ;e381  20          UNKNOWN 0x20 ' ' 
    .byte 0x52              ;e382  52          UNKNOWN 0x52 'R' 
    .byte 0xd0              ;e383  d0          UNKNOWN 0xd0 
    .byte 0xf0              ;e384  f0          UNKNOWN 0xf0 
    .byte 0x10              ;e385  10          UNKNOWN 0x10 
    .byte 0xa5              ;e386  a5          UNKNOWN 0xa5 
    .byte 0x92              ;e387  92          UNKNOWN 0x92 
    .byte 0x20              ;e388  20          UNKNOWN 0x20 ' ' 
    .byte 0x19              ;e389  19          UNKNOWN 0x19 
    .byte 0xe4              ;e38a  e4          UNKNOWN 0xe4 
    .byte 0x85              ;e38b  85          UNKNOWN 0x85 
    .byte 0xfa              ;e38c  fa          UNKNOWN 0xfa 
    .byte 0xa5              ;e38d  a5          UNKNOWN 0xa5 
    .byte 0x94              ;e38e  94          UNKNOWN 0x94 
    .byte 0x20              ;e38f  20          UNKNOWN 0x20 ' ' 
    .byte 0x19              ;e390  19          UNKNOWN 0x19 
    .byte 0xe4              ;e391  e4          UNKNOWN 0xe4 
    .byte 0x38              ;e392  38          UNKNOWN 0x38 '8' 
    .byte 0xe5              ;e393  e5          UNKNOWN 0xe5 
    .byte 0xf9              ;e394  f9          UNKNOWN 0xf9 
    .byte 0x60              ;e395  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;e396  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e397  00          UNKNOWN 0x00 
    .byte 0x60              ;e398  60          UNKNOWN 0x60 '`' 
    .byte 0x18              ;e399  18          UNKNOWN 0x18 
    .byte 0x69              ;e39a  69          UNKNOWN 0x69 'i' 
    .byte 0x00              ;e39b  00          UNKNOWN 0x00 
    .byte 0xaa              ;e39c  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;e39d  bd          UNKNOWN 0xbd 
    .byte 0x21              ;e39e  21          UNKNOWN 0x21 '!' 
    .byte 0xe4              ;e39f  e4          UNKNOWN 0xe4 
    .byte 0x60              ;e3a0  60          UNKNOWN 0x60 '`' 
    .byte 0xff              ;e3a1  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a2  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a3  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a4  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a5  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a6  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a7  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a8  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3a9  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3aa  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3ab  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3ac  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3ad  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3ae  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3af  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b0  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b1  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b2  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b3  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b4  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b5  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b6  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b7  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b8  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3b9  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3ba  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3bb  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3bc  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3bd  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3be  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3bf  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c0  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c1  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c2  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c3  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c4  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c5  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c6  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c7  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c8  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3c9  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3ca  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3cb  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3cc  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3cd  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3ce  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3cf  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3d0  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3d1  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3d2  ff          UNKNOWN 0xff 
    .byte 0xff              ;e3d3  ff          UNKNOWN 0xff 
    .byte 0x41              ;e3d4  41          UNKNOWN 0x41 'A' 
    .byte 0x40              ;e3d5  40          UNKNOWN 0x40 '@' 
    .byte 0x40              ;e3d6  40          UNKNOWN 0x40 '@' 
    .byte 0x3f              ;e3d7  3f          UNKNOWN 0x3f '?' 
    .byte 0x3e              ;e3d8  3e          UNKNOWN 0x3e '>' 
    .byte 0x3e              ;e3d9  3e          UNKNOWN 0x3e '>' 
    .byte 0x3d              ;e3da  3d          UNKNOWN 0x3d '=' 
    .byte 0x3c              ;e3db  3c          UNKNOWN 0x3c '<' 
    .byte 0x3c              ;e3dc  3c          UNKNOWN 0x3c '<' 
    .byte 0x3b              ;e3dd  3b          UNKNOWN 0x3b ';' 
    .byte 0x3b              ;e3de  3b          UNKNOWN 0x3b ';' 
    .byte 0x3a              ;e3df  3a          UNKNOWN 0x3a ':' 
    .byte 0x39              ;e3e0  39          UNKNOWN 0x39 '9' 
    .byte 0x39              ;e3e1  39          UNKNOWN 0x39 '9' 
    .byte 0x38              ;e3e2  38          UNKNOWN 0x38 '8' 

sub_e3e3:
    bbc 1,DA2,lab_e41c      ;e3e3  37 37 36 
    and AD,x                ;e3e6  35 35    
    .byte 0x34              ;e3e8  34       Illegal instruction

    .byte 0x34              ;e3e9  34          UNKNOWN 0x34 '4' 
    .byte 0x33              ;e3ea  33          UNKNOWN 0x33 '3' 
    .byte 0x33              ;e3eb  33          UNKNOWN 0x33 '3' 
    .byte 0x32              ;e3ec  32          UNKNOWN 0x32 '2' 
    .byte 0x32              ;e3ed  32          UNKNOWN 0x32 '2' 
    .byte 0x31              ;e3ee  31          UNKNOWN 0x31 '1' 
    .byte 0x31              ;e3ef  31          UNKNOWN 0x31 '1' 
    .byte 0x30              ;e3f0  30          UNKNOWN 0x30 '0' 
    .byte 0x30              ;e3f1  30          UNKNOWN 0x30 '0' 
    .byte 0x2f              ;e3f2  2f          UNKNOWN 0x2f '/' 
    .byte 0x2f              ;e3f3  2f          UNKNOWN 0x2f '/' 
    .byte 0x2e              ;e3f4  2e          UNKNOWN 0x2e '.' 
    .byte 0x2e              ;e3f5  2e          UNKNOWN 0x2e '.' 
    .byte 0x2d              ;e3f6  2d          UNKNOWN 0x2d '-' 
    .byte 0x2d              ;e3f7  2d          UNKNOWN 0x2d '-' 
    .byte 0x2c              ;e3f8  2c          UNKNOWN 0x2c ',' 
    .byte 0x2c              ;e3f9  2c          UNKNOWN 0x2c ',' 
    .byte 0x2b              ;e3fa  2b          UNKNOWN 0x2b '+' 
    .byte 0x2b              ;e3fb  2b          UNKNOWN 0x2b '+' 
    .byte 0x2a              ;e3fc  2a          UNKNOWN 0x2a '*' 
    .byte 0x2a              ;e3fd  2a          UNKNOWN 0x2a '*' 
    .byte 0x29              ;e3fe  29          UNKNOWN 0x29 ')' 
    .byte 0x29              ;e3ff  29          UNKNOWN 0x29 ')' 
    .byte 0x28              ;e400  28          UNKNOWN 0x28 '(' 
    .byte 0x28              ;e401  28          UNKNOWN 0x28 '(' 
    .byte 0x27              ;e402  27          UNKNOWN 0x27 ''' 
    .byte 0x27              ;e403  27          UNKNOWN 0x27 ''' 
    .byte 0x26              ;e404  26          UNKNOWN 0x26 '&' 
    .byte 0x26              ;e405  26          UNKNOWN 0x26 '&' 
    .byte 0x25              ;e406  25          UNKNOWN 0x25 '%' 
    .byte 0x25              ;e407  25          UNKNOWN 0x25 '%' 
    .byte 0x24              ;e408  24          UNKNOWN 0x24 '$' 
    .byte 0x24              ;e409  24          UNKNOWN 0x24 '$' 
    .byte 0x23              ;e40a  23          UNKNOWN 0x23 '#' 
    .byte 0x23              ;e40b  23          UNKNOWN 0x23 '#' 
    .byte 0x22              ;e40c  22          UNKNOWN 0x22 '"' 
    .byte 0x22              ;e40d  22          UNKNOWN 0x22 '"' 
    .byte 0x21              ;e40e  21          UNKNOWN 0x21 '!' 
    .byte 0x21              ;e40f  21          UNKNOWN 0x21 '!' 
    .byte 0x20              ;e410  20          UNKNOWN 0x20 ' ' 
    .byte 0x20              ;e411  20          UNKNOWN 0x20 ' ' 
    .byte 0x1f              ;e412  1f          UNKNOWN 0x1f 
    .byte 0x1f              ;e413  1f          UNKNOWN 0x1f 
    .byte 0x1e              ;e414  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;e415  1e          UNKNOWN 0x1e 
    .byte 0x1e              ;e416  1e          UNKNOWN 0x1e 
    .byte 0x1d              ;e417  1d          UNKNOWN 0x1d 
    .byte 0x1d              ;e418  1d          UNKNOWN 0x1d 
    .byte 0x1c              ;e419  1c          UNKNOWN 0x1c 
    .byte 0x1c              ;e41a  1c          UNKNOWN 0x1c 
    .byte 0x1b              ;e41b  1b          UNKNOWN 0x1b 

lab_e41c:
    clb 0,a                 ;e41c  1b       
    dec a                   ;e41d  1a       
    dec a                   ;e41e  1a       
    dec a                   ;e41f  1a       
    ora mem_1919,y          ;e420  19 19 19 
    clc                     ;e423  18       
    clc                     ;e424  18       
    clc                     ;e425  18       
    bbc 0,mem_0017,lab_e43f ;e426  17 17 16 
    asl mem_0015,x          ;e429  16 15    
    ora mem_0014,x          ;e42b  15 14    
    .byte 0x14              ;e42d  14       Illegal instruction

    .byte 0x14              ;e42e  14          UNKNOWN 0x14 
    .byte 0x13              ;e42f  13          UNKNOWN 0x13 
    .byte 0x13              ;e430  13          UNKNOWN 0x13 
    .byte 0x12              ;e431  12          UNKNOWN 0x12 
    .byte 0x12              ;e432  12          UNKNOWN 0x12 
    .byte 0x12              ;e433  12          UNKNOWN 0x12 
    .byte 0x11              ;e434  11          UNKNOWN 0x11 
    .byte 0x11              ;e435  11          UNKNOWN 0x11 
    .byte 0x10              ;e436  10          UNKNOWN 0x10 
    .byte 0x10              ;e437  10          UNKNOWN 0x10 
    .byte 0x0f              ;e438  0f          UNKNOWN 0x0f 
    .byte 0x0f              ;e439  0f          UNKNOWN 0x0f 
    .byte 0x0e              ;e43a  0e          UNKNOWN 0x0e 
    .byte 0x0e              ;e43b  0e          UNKNOWN 0x0e 
    .byte 0x0e              ;e43c  0e          UNKNOWN 0x0e 
    .byte 0x0d              ;e43d  0d          UNKNOWN 0x0d 
    .byte 0x0d              ;e43e  0d          UNKNOWN 0x0d 

lab_e43f:
    .byte 0x0c              ;e43f  0c       Illegal instruction

    .byte 0x0c              ;e440  0c          UNKNOWN 0x0c 
    .byte 0x0c              ;e441  0c          UNKNOWN 0x0c 
    .byte 0x0b              ;e442  0b          UNKNOWN 0x0b 
    .byte 0x0b              ;e443  0b          UNKNOWN 0x0b 
    .byte 0x0a              ;e444  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e445  0a          UNKNOWN 0x0a 
    .byte 0x0a              ;e446  0a          UNKNOWN 0x0a 
    .byte 0x09              ;e447  09          UNKNOWN 0x09 
    .byte 0x09              ;e448  09          UNKNOWN 0x09 
    .byte 0x09              ;e449  09          UNKNOWN 0x09 
    .byte 0x08              ;e44a  08          UNKNOWN 0x08 
    .byte 0x08              ;e44b  08          UNKNOWN 0x08 
    .byte 0x07              ;e44c  07          UNKNOWN 0x07 
    .byte 0x07              ;e44d  07          UNKNOWN 0x07 
    .byte 0x07              ;e44e  07          UNKNOWN 0x07 
    .byte 0x06              ;e44f  06          UNKNOWN 0x06 
    .byte 0x06              ;e450  06          UNKNOWN 0x06 
    .byte 0x05              ;e451  05          UNKNOWN 0x05 
    .byte 0x05              ;e452  05          UNKNOWN 0x05 
    .byte 0x04              ;e453  04          UNKNOWN 0x04 
    .byte 0x04              ;e454  04          UNKNOWN 0x04 
    .byte 0x03              ;e455  03          UNKNOWN 0x03 
    .byte 0x03              ;e456  03          UNKNOWN 0x03 
    .byte 0x02              ;e457  02          UNKNOWN 0x02 
    .byte 0x02              ;e458  02          UNKNOWN 0x02 
    .byte 0x01              ;e459  01          UNKNOWN 0x01 
    .byte 0x01              ;e45a  01          UNKNOWN 0x01 
    .byte 0x00              ;e45b  00          UNKNOWN 0x00 
    .byte 0x00              ;e45c  00          UNKNOWN 0x00 
    .byte 0x00              ;e45d  00          UNKNOWN 0x00 
    .byte 0x00              ;e45e  00          UNKNOWN 0x00 
    .byte 0x00              ;e45f  00          UNKNOWN 0x00 
    .byte 0x00              ;e460  00          UNKNOWN 0x00 
    .byte 0x00              ;e461  00          UNKNOWN 0x00 
    .byte 0x00              ;e462  00          UNKNOWN 0x00 
    .byte 0x00              ;e463  00          UNKNOWN 0x00 
    .byte 0x00              ;e464  00          UNKNOWN 0x00 
    .byte 0x00              ;e465  00          UNKNOWN 0x00 
    .byte 0x00              ;e466  00          UNKNOWN 0x00 
    .byte 0x00              ;e467  00          UNKNOWN 0x00 
    .byte 0x00              ;e468  00          UNKNOWN 0x00 
    .byte 0x00              ;e469  00          UNKNOWN 0x00 
    .byte 0x00              ;e46a  00          UNKNOWN 0x00 
    .byte 0x00              ;e46b  00          UNKNOWN 0x00 
    .byte 0x00              ;e46c  00          UNKNOWN 0x00 
    .byte 0x00              ;e46d  00          UNKNOWN 0x00 
    .byte 0x00              ;e46e  00          UNKNOWN 0x00 
    .byte 0x00              ;e46f  00          UNKNOWN 0x00 
    .byte 0x00              ;e470  00          UNKNOWN 0x00 
    .byte 0x00              ;e471  00          UNKNOWN 0x00 
    .byte 0x00              ;e472  00          UNKNOWN 0x00 
    .byte 0x00              ;e473  00          UNKNOWN 0x00 
    .byte 0x00              ;e474  00          UNKNOWN 0x00 
    .byte 0x00              ;e475  00          UNKNOWN 0x00 
    .byte 0x00              ;e476  00          UNKNOWN 0x00 
    .byte 0x00              ;e477  00          UNKNOWN 0x00 
    .byte 0x00              ;e478  00          UNKNOWN 0x00 
    .byte 0x00              ;e479  00          UNKNOWN 0x00 
    .byte 0x00              ;e47a  00          UNKNOWN 0x00 
    .byte 0x00              ;e47b  00          UNKNOWN 0x00 
    .byte 0x00              ;e47c  00          UNKNOWN 0x00 
    .byte 0x00              ;e47d  00          UNKNOWN 0x00 
    .byte 0x00              ;e47e  00          UNKNOWN 0x00 
    .byte 0x00              ;e47f  00          UNKNOWN 0x00 
    .byte 0x60              ;e480  60          UNKNOWN 0x60 '`' 
    .byte 0x00              ;e481  00          UNKNOWN 0x00 
    .byte 0x00              ;e482  00          UNKNOWN 0x00 
    .byte 0x00              ;e483  00          UNKNOWN 0x00 
    .byte 0x00              ;e484  00          UNKNOWN 0x00 
    .byte 0x00              ;e485  00          UNKNOWN 0x00 
    .byte 0x00              ;e486  00          UNKNOWN 0x00 
    .byte 0x00              ;e487  00          UNKNOWN 0x00 
    .byte 0x00              ;e488  00          UNKNOWN 0x00 
    .byte 0x00              ;e489  00          UNKNOWN 0x00 
    .byte 0x00              ;e48a  00          UNKNOWN 0x00 
    .byte 0x00              ;e48b  00          UNKNOWN 0x00 
    .byte 0x00              ;e48c  00          UNKNOWN 0x00 
    .byte 0x00              ;e48d  00          UNKNOWN 0x00 
    .byte 0x00              ;e48e  00          UNKNOWN 0x00 
    .byte 0x00              ;e48f  00          UNKNOWN 0x00 
    .byte 0x00              ;e490  00          UNKNOWN 0x00 
    .byte 0x00              ;e491  00          UNKNOWN 0x00 
    .byte 0x00              ;e492  00          UNKNOWN 0x00 
    .byte 0x00              ;e493  00          UNKNOWN 0x00 
    .byte 0x00              ;e494  00          UNKNOWN 0x00 
    .byte 0x00              ;e495  00          UNKNOWN 0x00 
    .byte 0x00              ;e496  00          UNKNOWN 0x00 
    .byte 0x00              ;e497  00          UNKNOWN 0x00 
    .byte 0x00              ;e498  00          UNKNOWN 0x00 
    .byte 0x00              ;e499  00          UNKNOWN 0x00 
    .byte 0x00              ;e49a  00          UNKNOWN 0x00 
    .byte 0x00              ;e49b  00          UNKNOWN 0x00 
    .byte 0x00              ;e49c  00          UNKNOWN 0x00 
    .byte 0x00              ;e49d  00          UNKNOWN 0x00 
    .byte 0x00              ;e49e  00          UNKNOWN 0x00 
    .byte 0x00              ;e49f  00          UNKNOWN 0x00 
    .byte 0x00              ;e4a0  00          UNKNOWN 0x00 
    .byte 0x87              ;e4a1  87          UNKNOWN 0x87 
    .byte 0xc2              ;e4a2  c2          UNKNOWN 0xc2 
    .byte 0x12              ;e4a3  12          UNKNOWN 0x12 
    .byte 0xa5              ;e4a4  a5          UNKNOWN 0xa5 
    .byte 0x72              ;e4a5  72          UNKNOWN 0x72 'r' 
    .byte 0xc9              ;e4a6  c9          UNKNOWN 0xc9 
    .byte 0xd2              ;e4a7  d2          UNKNOWN 0xd2 
    .byte 0xb0              ;e4a8  b0          UNKNOWN 0xb0 
    .byte 0x0c              ;e4a9  0c          UNKNOWN 0x0c 
    .byte 0x20              ;e4aa  20          UNKNOWN 0x20 ' ' 
    .byte 0x19              ;e4ab  19          UNKNOWN 0x19 
    .byte 0xe4              ;e4ac  e4          UNKNOWN 0xe4 
    .byte 0xc9              ;e4ad  c9          UNKNOWN 0xc9 
    .byte 0xff              ;e4ae  ff          UNKNOWN 0xff 
    .byte 0xf0              ;e4af  f0          UNKNOWN 0xf0 
    .byte 0x0d              ;e4b0  0d          UNKNOWN 0x0d 
    .byte 0xaa              ;e4b1  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;e4b2  bd          UNKNOWN 0xbd 
    .byte 0x39              ;e4b3  39          UNKNOWN 0x39 '9' 
    .byte 0xe5              ;e4b4  e5          UNKNOWN 0xe5 
    .byte 0x60              ;e4b5  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;e4b6  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e4b7  00          UNKNOWN 0x00 
    .byte 0x60              ;e4b8  60          UNKNOWN 0x60 '`' 
    .byte 0xfc              ;e4b9  fc          UNKNOWN 0xfc 
    .byte 0xfc              ;e4ba  fc          UNKNOWN 0xfc 
    .byte 0xfc              ;e4bb  fc          UNKNOWN 0xfc 
    .byte 0xfc              ;e4bc  fc          UNKNOWN 0xfc 
    .byte 0xfc              ;e4bd  fc          UNKNOWN 0xfc 
    .byte 0xfd              ;e4be  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;e4bf  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;e4c0  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;e4c1  fd          UNKNOWN 0xfd 
    .byte 0xfd              ;e4c2  fd          UNKNOWN 0xfd 
    .byte 0xfe              ;e4c3  fe          UNKNOWN 0xfe 
    .byte 0xfe              ;e4c4  fe          UNKNOWN 0xfe 
    .byte 0xfe              ;e4c5  fe          UNKNOWN 0xfe 
    .byte 0xfe              ;e4c6  fe          UNKNOWN 0xfe 
    .byte 0xfe              ;e4c7  fe          UNKNOWN 0xfe 
    .byte 0xff              ;e4c8  ff          UNKNOWN 0xff 
    .byte 0xff              ;e4c9  ff          UNKNOWN 0xff 
    .byte 0xff              ;e4ca  ff          UNKNOWN 0xff 
    .byte 0xff              ;e4cb  ff          UNKNOWN 0xff 
    .byte 0xff              ;e4cc  ff          UNKNOWN 0xff 
    .byte 0x00              ;e4cd  00          UNKNOWN 0x00 
    .byte 0x00              ;e4ce  00          UNKNOWN 0x00 
    .byte 0x00              ;e4cf  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d0  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d1  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d2  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d3  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d4  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d5  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d6  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d7  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d8  00          UNKNOWN 0x00 
    .byte 0x00              ;e4d9  00          UNKNOWN 0x00 
    .byte 0x00              ;e4da  00          UNKNOWN 0x00 
    .byte 0x00              ;e4db  00          UNKNOWN 0x00 
    .byte 0x00              ;e4dc  00          UNKNOWN 0x00 
    .byte 0x00              ;e4dd  00          UNKNOWN 0x00 
    .byte 0x01              ;e4de  01          UNKNOWN 0x01 
    .byte 0x01              ;e4df  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e0  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e1  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e2  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e3  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e4  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e5  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e6  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e7  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e8  01          UNKNOWN 0x01 
    .byte 0x01              ;e4e9  01          UNKNOWN 0x01 
    .byte 0x01              ;e4ea  01          UNKNOWN 0x01 
    .byte 0x01              ;e4eb  01          UNKNOWN 0x01 
    .byte 0x01              ;e4ec  01          UNKNOWN 0x01 
    .byte 0x01              ;e4ed  01          UNKNOWN 0x01 
    .byte 0x01              ;e4ee  01          UNKNOWN 0x01 
    .byte 0x01              ;e4ef  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f0  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f1  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f2  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f3  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f4  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f5  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f6  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f7  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f8  01          UNKNOWN 0x01 
    .byte 0x01              ;e4f9  01          UNKNOWN 0x01 
    .byte 0x01              ;e4fa  01          UNKNOWN 0x01 
    .byte 0x01              ;e4fb  01          UNKNOWN 0x01 
    .byte 0x01              ;e4fc  01          UNKNOWN 0x01 
    .byte 0x01              ;e4fd  01          UNKNOWN 0x01 
    .byte 0x01              ;e4fe  01          UNKNOWN 0x01 
    .byte 0x01              ;e4ff  01          UNKNOWN 0x01 
    .byte 0x01              ;e500  01          UNKNOWN 0x01 
    .byte 0x01              ;e501  01          UNKNOWN 0x01 
    .byte 0x01              ;e502  01          UNKNOWN 0x01 
    .byte 0x00              ;e503  00          UNKNOWN 0x00 
    .byte 0x00              ;e504  00          UNKNOWN 0x00 
    .byte 0x00              ;e505  00          UNKNOWN 0x00 
    .byte 0x00              ;e506  00          UNKNOWN 0x00 
    .byte 0x00              ;e507  00          UNKNOWN 0x00 
    .byte 0x00              ;e508  00          UNKNOWN 0x00 
    .byte 0x20              ;e509  20          UNKNOWN 0x20 ' ' 
    .byte 0x21              ;e50a  21          UNKNOWN 0x21 '!' 
    .byte 0xe5              ;e50b  e5          UNKNOWN 0xe5 
    .byte 0xf0              ;e50c  f0          UNKNOWN 0xf0 
    .byte 0x3f              ;e50d  3f          UNKNOWN 0x3f '?' 
    .byte 0x30              ;e50e  30          UNKNOWN 0x30 '0' 
    .byte 0x16              ;e50f  16          UNKNOWN 0x16 
    .byte 0x85              ;e510  85          UNKNOWN 0x85 
    .byte 0xfc              ;e511  fc          UNKNOWN 0xfc 
    .byte 0xa5              ;e512  a5          UNKNOWN 0xa5 
    .byte 0x70              ;e513  70          UNKNOWN 0x70 'p' 
    .byte 0x4a              ;e514  4a          UNKNOWN 0x4a 'J' 
    .byte 0x4a              ;e515  4a          UNKNOWN 0x4a 'J' 
    .byte 0xaa              ;e516  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;e517  bd          UNKNOWN 0xbd 
    .byte 0xd0              ;e518  d0          UNKNOWN 0xd0 
    .byte 0xe5              ;e519  e5          UNKNOWN 0xe5 
    .byte 0xf0              ;e51a  f0          UNKNOWN 0xf0 
    .byte 0x2e              ;e51b  2e          UNKNOWN 0x2e '.' 
    .byte 0x85              ;e51c  85          UNKNOWN 0x85 
    .byte 0xfb              ;e51d  fb          UNKNOWN 0xfb 
    .byte 0xa5              ;e51e  a5          UNKNOWN 0xa5 
    .byte 0xfc              ;e51f  fc          UNKNOWN 0xfc 
    .byte 0x4a              ;e520  4a          UNKNOWN 0x4a 'J' 
    .byte 0xc6              ;e521  c6          UNKNOWN 0xc6 
    .byte 0xfb              ;e522  fb          UNKNOWN 0xfb 
    .byte 0xd0              ;e523  d0          UNKNOWN 0xd0 
    .byte 0xfb              ;e524  fb          UNKNOWN 0xfb 
    .byte 0x60              ;e525  60          UNKNOWN 0x60 '`' 
    .byte 0x85              ;e526  85          UNKNOWN 0x85 
    .byte 0xfc              ;e527  fc          UNKNOWN 0xfc 
    .byte 0xa5              ;e528  a5          UNKNOWN 0xa5 
    .byte 0x70              ;e529  70          UNKNOWN 0x70 'p' 
    .byte 0x4a              ;e52a  4a          UNKNOWN 0x4a 'J' 
    .byte 0x4a              ;e52b  4a          UNKNOWN 0x4a 'J' 
    .byte 0xaa              ;e52c  aa          UNKNOWN 0xaa 
    .byte 0xbd              ;e52d  bd          UNKNOWN 0xbd 
    .byte 0xd0              ;e52e  d0          UNKNOWN 0xd0 
    .byte 0xe5              ;e52f  e5          UNKNOWN 0xe5 
    .byte 0xf0              ;e530  f0          UNKNOWN 0xf0 
    .byte 0x18              ;e531  18          UNKNOWN 0x18 
    .byte 0x85              ;e532  85          UNKNOWN 0x85 
    .byte 0xfb              ;e533  fb          UNKNOWN 0xfb 
    .byte 0x44              ;e534  44          UNKNOWN 0x44 'D' 
    .byte 0xfc              ;e535  fc          UNKNOWN 0xfc 
    .byte 0xa5              ;e536  a5          UNKNOWN 0xa5 
    .byte 0xfc              ;e537  fc          UNKNOWN 0xfc 
    .byte 0x3a              ;e538  3a          UNKNOWN 0x3a ':' 
    .byte 0x4a              ;e539  4a          UNKNOWN 0x4a 'J' 
    .byte 0xc6              ;e53a  c6          UNKNOWN 0xc6 
    .byte 0xfb              ;e53b  fb          UNKNOWN 0xfb 
    .byte 0xd0              ;e53c  d0          UNKNOWN 0xd0 
    .byte 0xfb              ;e53d  fb          UNKNOWN 0xfb 
    .byte 0xc9              ;e53e  c9          UNKNOWN 0xc9 
    .byte 0x00              ;e53f  00          UNKNOWN 0x00 
    .byte 0xf0              ;e540  f0          UNKNOWN 0xf0 
    .byte 0x0b              ;e541  0b          UNKNOWN 0x0b 
    .byte 0x1a              ;e542  1a          UNKNOWN 0x1a 
    .byte 0x85              ;e543  85          UNKNOWN 0x85 
    .byte 0xfc              ;e544  fc          UNKNOWN 0xfc 
    .byte 0x44              ;e545  44          UNKNOWN 0x44 'D' 
    .byte 0xfc              ;e546  fc          UNKNOWN 0xfc 
    .byte 0xa5              ;e547  a5          UNKNOWN 0xa5 
    .byte 0xfc              ;e548  fc          UNKNOWN 0xfc 
    .byte 0x60              ;e549  60          UNKNOWN 0x60 '`' 
    .byte 0xa5              ;e54a  a5          UNKNOWN 0xa5 
    .byte 0xfc              ;e54b  fc          UNKNOWN 0xfc 
    .byte 0x60              ;e54c  60          UNKNOWN 0x60 '`' 
    .byte 0xa9              ;e54d  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e54e  00          UNKNOWN 0x00 
    .byte 0x60              ;e54f  60          UNKNOWN 0x60 '`' 
    .byte 0x03              ;e550  03          UNKNOWN 0x03 
    .byte 0x02              ;e551  02          UNKNOWN 0x02 
    .byte 0x01              ;e552  01          UNKNOWN 0x01 
    .byte 0x01              ;e553  01          UNKNOWN 0x01 
    .byte 0x01              ;e554  01          UNKNOWN 0x01 
    .byte 0x00              ;e555  00          UNKNOWN 0x00 
    .byte 0x00              ;e556  00          UNKNOWN 0x00 
    .byte 0x00              ;e557  00          UNKNOWN 0x00 
    .byte 0x00              ;e558  00          UNKNOWN 0x00 
    .byte 0x00              ;e559  00          UNKNOWN 0x00 
    .byte 0x00              ;e55a  00          UNKNOWN 0x00 
    .byte 0x00              ;e55b  00          UNKNOWN 0x00 
    .byte 0x00              ;e55c  00          UNKNOWN 0x00 
    .byte 0x00              ;e55d  00          UNKNOWN 0x00 
    .byte 0x00              ;e55e  00          UNKNOWN 0x00 
    .byte 0x00              ;e55f  00          UNKNOWN 0x00 
    .byte 0x00              ;e560  00          UNKNOWN 0x00 
    .byte 0x00              ;e561  00          UNKNOWN 0x00 
    .byte 0x00              ;e562  00          UNKNOWN 0x00 
    .byte 0x00              ;e563  00          UNKNOWN 0x00 
    .byte 0x00              ;e564  00          UNKNOWN 0x00 
    .byte 0x00              ;e565  00          UNKNOWN 0x00 
    .byte 0x00              ;e566  00          UNKNOWN 0x00 
    .byte 0x00              ;e567  00          UNKNOWN 0x00 
    .byte 0x00              ;e568  00          UNKNOWN 0x00 
    .byte 0x00              ;e569  00          UNKNOWN 0x00 
    .byte 0x00              ;e56a  00          UNKNOWN 0x00 
    .byte 0x00              ;e56b  00          UNKNOWN 0x00 
    .byte 0x00              ;e56c  00          UNKNOWN 0x00 
    .byte 0x00              ;e56d  00          UNKNOWN 0x00 
    .byte 0x00              ;e56e  00          UNKNOWN 0x00 
    .byte 0x00              ;e56f  00          UNKNOWN 0x00 
    .byte 0x00              ;e570  00          UNKNOWN 0x00 
    .byte 0x00              ;e571  00          UNKNOWN 0x00 
    .byte 0x00              ;e572  00          UNKNOWN 0x00 
    .byte 0x00              ;e573  00          UNKNOWN 0x00 
    .byte 0x00              ;e574  00          UNKNOWN 0x00 
    .byte 0x00              ;e575  00          UNKNOWN 0x00 
    .byte 0x00              ;e576  00          UNKNOWN 0x00 
    .byte 0x00              ;e577  00          UNKNOWN 0x00 
    .byte 0x00              ;e578  00          UNKNOWN 0x00 
    .byte 0x00              ;e579  00          UNKNOWN 0x00 
    .byte 0x00              ;e57a  00          UNKNOWN 0x00 
    .byte 0x00              ;e57b  00          UNKNOWN 0x00 
    .byte 0x00              ;e57c  00          UNKNOWN 0x00 
    .byte 0x00              ;e57d  00          UNKNOWN 0x00 
    .byte 0x00              ;e57e  00          UNKNOWN 0x00 
    .byte 0x00              ;e57f  00          UNKNOWN 0x00 
    .byte 0x00              ;e580  00          UNKNOWN 0x00 
    .byte 0x00              ;e581  00          UNKNOWN 0x00 
    .byte 0x00              ;e582  00          UNKNOWN 0x00 
    .byte 0x00              ;e583  00          UNKNOWN 0x00 
    .byte 0x00              ;e584  00          UNKNOWN 0x00 
    .byte 0x00              ;e585  00          UNKNOWN 0x00 
    .byte 0x00              ;e586  00          UNKNOWN 0x00 
    .byte 0x00              ;e587  00          UNKNOWN 0x00 
    .byte 0x00              ;e588  00          UNKNOWN 0x00 

sub_e589:
    brk                     ;e589  00       

    .byte 0x00              ;e58a  00          UNKNOWN 0x00 
    .byte 0x00              ;e58b  00          UNKNOWN 0x00 
    .byte 0x00              ;e58c  00          UNKNOWN 0x00 
    .byte 0x00              ;e58d  00          UNKNOWN 0x00 
    .byte 0x00              ;e58e  00          UNKNOWN 0x00 
    .byte 0x00              ;e58f  00          UNKNOWN 0x00 
    .byte 0x00              ;e590  00          UNKNOWN 0x00 
    .byte 0xb9              ;e591  b9          UNKNOWN 0xb9 
    .byte 0x00              ;e592  00          UNKNOWN 0x00 
    .byte 0x00              ;e593  00          UNKNOWN 0x00 
    .byte 0xd0              ;e594  d0          UNKNOWN 0xd0 
    .byte 0x06              ;e595  06          UNKNOWN 0x06 
    .byte 0xb9              ;e596  b9          UNKNOWN 0xb9 
    .byte 0x01              ;e597  01          UNKNOWN 0x01 
    .byte 0x00              ;e598  00          UNKNOWN 0x00 
    .byte 0xd0              ;e599  d0          UNKNOWN 0xd0 
    .byte 0x01              ;e59a  01          UNKNOWN 0x01 
    .byte 0x60              ;e59b  60          UNKNOWN 0x60 '`' 
    .byte 0x60              ;e59c  60          UNKNOWN 0x60 '`' 
    .byte 0x48              ;e59d  48          UNKNOWN 0x48 'H' 
    .byte 0xb9              ;e59e  b9          UNKNOWN 0xb9 
    .byte 0x00              ;e59f  00          UNKNOWN 0x00 
    .byte 0x00              ;e5a0  00          UNKNOWN 0x00 
    .byte 0x38              ;e5a1  38          UNKNOWN 0x38 '8' 
    .byte 0xe9              ;e5a2  e9          UNKNOWN 0xe9 
    .byte 0x01              ;e5a3  01          UNKNOWN 0x01 
    .byte 0x99              ;e5a4  99          UNKNOWN 0x99 
    .byte 0x00              ;e5a5  00          UNKNOWN 0x00 
    .byte 0x00              ;e5a6  00          UNKNOWN 0x00 
    .byte 0xb9              ;e5a7  b9          UNKNOWN 0xb9 
    .byte 0x01              ;e5a8  01          UNKNOWN 0x01 
    .byte 0x00              ;e5a9  00          UNKNOWN 0x00 
    .byte 0xe9              ;e5aa  e9          UNKNOWN 0xe9 
    .byte 0x00              ;e5ab  00          UNKNOWN 0x00 
    .byte 0x99              ;e5ac  99          UNKNOWN 0x99 
    .byte 0x01              ;e5ad  01          UNKNOWN 0x01 
    .byte 0x00              ;e5ae  00          UNKNOWN 0x00 
    .byte 0x68              ;e5af  68          UNKNOWN 0x68 'h' 
    .byte 0x61              ;e5b0  61          UNKNOWN 0x61 'a' 
    .byte 0x18              ;e5b1  18          UNKNOWN 0x18 
    .byte 0x79              ;e5b2  79          UNKNOWN 0x79 'y' 
    .byte 0x00              ;e5b3  00          UNKNOWN 0x00 
    .byte 0x00              ;e5b4  00          UNKNOWN 0x00 
    .byte 0x99              ;e5b5  99          UNKNOWN 0x99 
    .byte 0x00              ;e5b6  00          UNKNOWN 0x00 
    .byte 0x00              ;e5b7  00          UNKNOWN 0x00 
    .byte 0xa9              ;e5b8  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e5b9  00          UNKNOWN 0x00 
    .byte 0x79              ;e5ba  79          UNKNOWN 0x79 'y' 
    .byte 0x01              ;e5bb  01          UNKNOWN 0x01 
    .byte 0x00              ;e5bc  00          UNKNOWN 0x00 
    .byte 0x99              ;e5bd  99          UNKNOWN 0x99 
    .byte 0x01              ;e5be  01          UNKNOWN 0x01 
    .byte 0x00              ;e5bf  00          UNKNOWN 0x00 
    .byte 0xa9              ;e5c0  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e5c1  00          UNKNOWN 0x00 
    .byte 0x79              ;e5c2  79          UNKNOWN 0x79 'y' 
    .byte 0x02              ;e5c3  02          UNKNOWN 0x02 
    .byte 0x00              ;e5c4  00          UNKNOWN 0x00 
    .byte 0x99              ;e5c5  99          UNKNOWN 0x99 
    .byte 0x02              ;e5c6  02          UNKNOWN 0x02 
    .byte 0x00              ;e5c7  00          UNKNOWN 0x00 
    .byte 0xa9              ;e5c8  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e5c9  00          UNKNOWN 0x00 
    .byte 0x79              ;e5ca  79          UNKNOWN 0x79 'y' 
    .byte 0x03              ;e5cb  03          UNKNOWN 0x03 
    .byte 0x00              ;e5cc  00          UNKNOWN 0x00 
    .byte 0x99              ;e5cd  99          UNKNOWN 0x99 
    .byte 0x03              ;e5ce  03          UNKNOWN 0x03 
    .byte 0x00              ;e5cf  00          UNKNOWN 0x00 
    .byte 0x60              ;e5d0  60          UNKNOWN 0x60 '`' 
    .byte 0x18              ;e5d1  18          UNKNOWN 0x18 
    .byte 0x79              ;e5d2  79          UNKNOWN 0x79 'y' 
    .byte 0x00              ;e5d3  00          UNKNOWN 0x00 
    .byte 0x00              ;e5d4  00          UNKNOWN 0x00 
    .byte 0x99              ;e5d5  99          UNKNOWN 0x99 
    .byte 0x00              ;e5d6  00          UNKNOWN 0x00 
    .byte 0x00              ;e5d7  00          UNKNOWN 0x00 
    .byte 0xa9              ;e5d8  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e5d9  00          UNKNOWN 0x00 
    .byte 0x79              ;e5da  79          UNKNOWN 0x79 'y' 
    .byte 0x01              ;e5db  01          UNKNOWN 0x01 
    .byte 0x00              ;e5dc  00          UNKNOWN 0x00 
    .byte 0x99              ;e5dd  99          UNKNOWN 0x99 
    .byte 0x01              ;e5de  01          UNKNOWN 0x01 
    .byte 0x00              ;e5df  00          UNKNOWN 0x00 
    .byte 0xa9              ;e5e0  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e5e1  00          UNKNOWN 0x00 
    .byte 0x79              ;e5e2  79          UNKNOWN 0x79 'y' 
    .byte 0x02              ;e5e3  02          UNKNOWN 0x02 
    .byte 0x00              ;e5e4  00          UNKNOWN 0x00 
    .byte 0x99              ;e5e5  99          UNKNOWN 0x99 
    .byte 0x02              ;e5e6  02          UNKNOWN 0x02 
    .byte 0x00              ;e5e7  00          UNKNOWN 0x00 
    .byte 0x60              ;e5e8  60          UNKNOWN 0x60 '`' 
    .byte 0x18              ;e5e9  18          UNKNOWN 0x18 
    .byte 0x79              ;e5ea  79          UNKNOWN 0x79 'y' 
    .byte 0x00              ;e5eb  00          UNKNOWN 0x00 
    .byte 0x00              ;e5ec  00          UNKNOWN 0x00 
    .byte 0x99              ;e5ed  99          UNKNOWN 0x99 
    .byte 0x00              ;e5ee  00          UNKNOWN 0x00 
    .byte 0x00              ;e5ef  00          UNKNOWN 0x00 
    .byte 0xa9              ;e5f0  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e5f1  00          UNKNOWN 0x00 
    .byte 0x79              ;e5f2  79          UNKNOWN 0x79 'y' 
    .byte 0x01              ;e5f3  01          UNKNOWN 0x01 
    .byte 0x00              ;e5f4  00          UNKNOWN 0x00 
    .byte 0x99              ;e5f5  99          UNKNOWN 0x99 
    .byte 0x01              ;e5f6  01          UNKNOWN 0x01 
    .byte 0x00              ;e5f7  00          UNKNOWN 0x00 
    .byte 0x60              ;e5f8  60          UNKNOWN 0x60 '`' 
    .byte 0x85              ;e5f9  85          UNKNOWN 0x85 
    .byte 0xf7              ;e5fa  f7          UNKNOWN 0xf7 
    .byte 0x38              ;e5fb  38          UNKNOWN 0x38 '8' 
    .byte 0xb9              ;e5fc  b9          UNKNOWN 0xb9 
    .byte 0x00              ;e5fd  00          UNKNOWN 0x00 
    .byte 0x00              ;e5fe  00          UNKNOWN 0x00 
    .byte 0xe5              ;e5ff  e5          UNKNOWN 0xe5 
    .byte 0xf7              ;e600  f7          UNKNOWN 0xf7 
    .byte 0x99              ;e601  99          UNKNOWN 0x99 
    .byte 0x00              ;e602  00          UNKNOWN 0x00 
    .byte 0x00              ;e603  00          UNKNOWN 0x00 
    .byte 0xb9              ;e604  b9          UNKNOWN 0xb9 
    .byte 0x01              ;e605  01          UNKNOWN 0x01 
    .byte 0x00              ;e606  00          UNKNOWN 0x00 
    .byte 0xe9              ;e607  e9          UNKNOWN 0xe9 
    .byte 0x00              ;e608  00          UNKNOWN 0x00 
    .byte 0x99              ;e609  99          UNKNOWN 0x99 
    .byte 0x01              ;e60a  01          UNKNOWN 0x01 
    .byte 0x00              ;e60b  00          UNKNOWN 0x00 
    .byte 0xb9              ;e60c  b9          UNKNOWN 0xb9 
    .byte 0x02              ;e60d  02          UNKNOWN 0x02 
    .byte 0x00              ;e60e  00          UNKNOWN 0x00 
    .byte 0xe9              ;e60f  e9          UNKNOWN 0xe9 
    .byte 0x00              ;e610  00          UNKNOWN 0x00 

sub_e611:
    sta P1,y                ;e611  99 02 00 
    lda P1D,y               ;e614  b9 03 00 
    sbc #0x00               ;e617  e9 00    
    sta P1D,y               ;e619  99 03 00 
    rts                     ;e61c  60       

sub_e61d:
    sta mem_00f7            ;e61d  85 f7    
    sec                     ;e61f  38       
    lda P0,y                ;e620  b9 00 00 
    sbc mem_00f7            ;e623  e5 f7    
    sta P0,y                ;e625  99 00 00 
    lda P0D,y               ;e628  b9 01 00 
    sbc #0x00               ;e62b  e9 00    
    sta P0D,y               ;e62d  99 01 00 
    rts                     ;e630  60       

    .byte 0x78              ;e631  78          UNKNOWN 0x78 'x' 
    .byte 0xd8              ;e632  d8          UNKNOWN 0xd8 
    .byte 0x12              ;e633  12          UNKNOWN 0x12 
    .byte 0xb8              ;e634  b8          UNKNOWN 0xb8 
    .byte 0x4c              ;e635  4c          UNKNOWN 0x4c 'L' 
    .byte 0xcc              ;e636  cc          UNKNOWN 0xcc 
    .byte 0xe6              ;e637  e6          UNKNOWN 0xe6 
    .byte 0x20              ;e638  20          UNKNOWN 0x20 ' ' 
    .byte 0xe9              ;e639  e9          UNKNOWN 0xe9 
    .byte 0xe7              ;e63a  e7          UNKNOWN 0xe7 
    .byte 0xa0              ;e63b  a0          UNKNOWN 0xa0 
    .byte 0x55              ;e63c  55          UNKNOWN 0x55 'U' 
    .byte 0xa9              ;e63d  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e63e  00          UNKNOWN 0x00 
    .byte 0x20              ;e63f  20          UNKNOWN 0x20 ' ' 
    .byte 0x77              ;e640  77          UNKNOWN 0x77 'w' 
    .byte 0xcd              ;e641  cd          UNKNOWN 0xcd 
    .byte 0x90              ;e642  90          UNKNOWN 0x90 
    .byte 0x03              ;e643  03          UNKNOWN 0x03 
    .byte 0x4c              ;e644  4c          UNKNOWN 0x4c 'L' 
    .byte 0x17              ;e645  17          UNKNOWN 0x17 
    .byte 0xcd              ;e646  cd          UNKNOWN 0xcd 
    .byte 0xa9              ;e647  a9          UNKNOWN 0xa9 
    .byte 0x01              ;e648  01          UNKNOWN 0x01 
    .byte 0x4c              ;e649  4c          UNKNOWN 0x4c 'L' 
    .byte 0x17              ;e64a  17          UNKNOWN 0x17 
    .byte 0xcd              ;e64b  cd          UNKNOWN 0xcd 
    .byte 0xa2              ;e64c  a2          UNKNOWN 0xa2 
    .byte 0x00              ;e64d  00          UNKNOWN 0x00 

lab_e64e:
    ldy mem_e71d,x          ;e64e  bc 1d e7 

sub_e651:
    cpy #0x40               ;e651  c0 40    
    beq lab_e65f            ;e653  f0 0a    
    inx                     ;e655  e8       
    lda mem_e71d,x          ;e656  bd 1d e7 
    sta P0,y                ;e659  99 00 00 
    inx                     ;e65c  e8       
    bra lab_e64e            ;e65d  80 ef    

lab_e65f:
    lda #0x00               ;e65f  a9 00    
    ldx #0x40               ;e661  a2 40    

lab_e663:
    sta P0,x                ;e663  95 00    
    inx                     ;e665  e8       
    cpx #0x00               ;e666  e0 00    
    bne lab_e663            ;e668  d0 f9    
    tax                     ;e66a  aa       

lab_e66b:
    sta mem_0100,x          ;e66b  9d 00 01 
    inx                     ;e66e  e8       
    cpx #0xc0               ;e66f  e0 c0    
    bne lab_e66b            ;e671  d0 f8    
    ldx #0xbe               ;e673  a2 be    
    txs                     ;e675  9a       
    jmp lab_e6b8            ;e676  4c b8 e6 

    .byte 0xa0              ;e679  a0          UNKNOWN 0xa0 
    .byte 0x00              ;e67a  00          UNKNOWN 0x00 
    .byte 0xb1              ;e67b  b1          UNKNOWN 0xb1 
    .byte 0xf5              ;e67c  f5          UNKNOWN 0xf5 
    .byte 0xf0              ;e67d  f0          UNKNOWN 0xf0 
    .byte 0x0c              ;e67e  0c          UNKNOWN 0x0c 
    .byte 0xc9              ;e67f  c9          UNKNOWN 0xc9 
    .byte 0x40              ;e680  40          UNKNOWN 0x40 '@' 
    .byte 0xf0              ;e681  f0          UNKNOWN 0xf0 
    .byte 0x19              ;e682  19          UNKNOWN 0x19 
    .byte 0xc8              ;e683  c8          UNKNOWN 0xc8 
    .byte 0xb1              ;e684  b1          UNKNOWN 0xb1 
    .byte 0xf5              ;e685  f5          UNKNOWN 0xf5 
    .byte 0xaa              ;e686  aa          UNKNOWN 0xaa 
    .byte 0xb5              ;e687  b5          UNKNOWN 0xb5 
    .byte 0x00              ;e688  00          UNKNOWN 0x00 
    .byte 0x80              ;e689  80          UNKNOWN 0x80 
    .byte 0x06              ;e68a  06          UNKNOWN 0x06 
    .byte 0xc8              ;e68b  c8          UNKNOWN 0xc8 
    .byte 0xb1              ;e68c  b1          UNKNOWN 0xb1 
    .byte 0xf5              ;e68d  f5          UNKNOWN 0xf5 
    .byte 0xaa              ;e68e  aa          UNKNOWN 0xaa 
    .byte 0xa9              ;e68f  a9          UNKNOWN 0xa9 
    .byte 0x00              ;e690  00          UNKNOWN 0x00 
    .byte 0xc8              ;e691  c8          UNKNOWN 0xc8 
    .byte 0x31              ;e692  31          UNKNOWN 0x31 '1' 
    .byte 0xf5              ;e693  f5          UNKNOWN 0xf5 
    .byte 0xc8              ;e694  c8          UNKNOWN 0xc8 
    .byte 0x11              ;e695  11          UNKNOWN 0x11 

lab_e696:
    sbc mem_0095,x          ;e696  f5 95    
    brk                     ;e698  00       

    .byte 0xc8              ;e699  c8          UNKNOWN 0xc8 
    .byte 0x80              ;e69a  80          UNKNOWN 0x80 
    .byte 0xdf              ;e69b  df          UNKNOWN 0xdf 
    .byte 0x60              ;e69c  60          UNKNOWN 0x60 '`' 

sub_e69d:
    brk                     ;e69d  00       

    .byte 0x00              ;e69e  00          UNKNOWN 0x00 
    .byte 0x01              ;e69f  01          UNKNOWN 0x01 
    .byte 0x00              ;e6a0  00          UNKNOWN 0x00 
    .byte 0x02              ;e6a1  02          UNKNOWN 0x02 
    .byte 0xa0              ;e6a2  a0          UNKNOWN 0xa0 
    .byte 0x03              ;e6a3  03          UNKNOWN 0x03 
    .byte 0xff              ;e6a4  ff          UNKNOWN 0xff 
    .byte 0x04              ;e6a5  04          UNKNOWN 0x04 
    .byte 0xbc              ;e6a6  bc          UNKNOWN 0xbc 
    .byte 0x05              ;e6a7  05          UNKNOWN 0x05 
    .byte 0xff              ;e6a8  ff          UNKNOWN 0xff 
    .byte 0x08              ;e6a9  08          UNKNOWN 0x08 
    .byte 0x40              ;e6aa  40          UNKNOWN 0x40 '@' 
    .byte 0x09              ;e6ab  09          UNKNOWN 0x09 
    .byte 0xa4              ;e6ac  a4          UNKNOWN 0xa4 
    .byte 0x0a              ;e6ad  0a          UNKNOWN 0x0a 
    .byte 0xc0              ;e6ae  c0          UNKNOWN 0xc0 
    .byte 0x0b              ;e6af  0b          UNKNOWN 0x0b 
    .byte 0xfc              ;e6b0  fc          UNKNOWN 0xfc 

lab_e6b1:
    .byte 0x0c              ;e6b1  0c       Illegal instruction

    .byte 0x00              ;e6b2  00          UNKNOWN 0x00 
    .byte 0x0d              ;e6b3  0d          UNKNOWN 0x0d 
    .byte 0x00              ;e6b4  00          UNKNOWN 0x00 
    .byte 0x0e              ;e6b5  0e          UNKNOWN 0x0e 
    .byte 0x00              ;e6b6  00          UNKNOWN 0x00 
    .byte 0x0f              ;e6b7  0f          UNKNOWN 0x0f 

lab_e6b8:
    brk                     ;e6b8  00       

    .byte 0x16              ;e6b9  16          UNKNOWN 0x16 
    .byte 0x01              ;e6ba  01          UNKNOWN 0x01 
    .byte 0x17              ;e6bb  17          UNKNOWN 0x17 
    .byte 0x00              ;e6bc  00          UNKNOWN 0x00 
    .byte 0x1a              ;e6bd  1a          UNKNOWN 0x1a 
    .byte 0x01              ;e6be  01          UNKNOWN 0x01 
    .byte 0x1b              ;e6bf  1b          UNKNOWN 0x1b 
    .byte 0x00              ;e6c0  00          UNKNOWN 0x00 
    .byte 0x1c              ;e6c1  1c          UNKNOWN 0x1c 
    .byte 0x1f              ;e6c2  1f          UNKNOWN 0x1f 
    .byte 0x27              ;e6c3  27          UNKNOWN 0x27 ''' 
    .byte 0xd0              ;e6c4  d0          UNKNOWN 0xd0 
    .byte 0x28              ;e6c5  28          UNKNOWN 0x28 '(' 
    .byte 0x00              ;e6c6  00          UNKNOWN 0x00 
    .byte 0x22              ;e6c7  22          UNKNOWN 0x22 '"' 
    .byte 0xff              ;e6c8  ff          UNKNOWN 0xff 
    .byte 0x23              ;e6c9  23          UNKNOWN 0x23 '#' 
    .byte 0x95              ;e6ca  95          UNKNOWN 0x95 
    .byte 0x29              ;e6cb  29          UNKNOWN 0x29 ')' 
    .byte 0x18              ;e6cc  18          UNKNOWN 0x18 
    .byte 0x25              ;e6cd  25          UNKNOWN 0x25 '%' 
    .byte 0x7f              ;e6ce  7f          UNKNOWN 0x7f 
    .byte 0x26              ;e6cf  26          UNKNOWN 0x26 '&' 
    .byte 0x7f              ;e6d0  7f          UNKNOWN 0x7f 
    .byte 0x2a              ;e6d1  2a          UNKNOWN 0x2a '*' 
    .byte 0x00              ;e6d2  00          UNKNOWN 0x00 
    .byte 0x34              ;e6d3  34          UNKNOWN 0x34 '4' 
    .byte 0x08              ;e6d4  08          UNKNOWN 0x08 
    .byte 0x38              ;e6d5  38          UNKNOWN 0x38 '8' 
    .byte 0x00              ;e6d6  00          UNKNOWN 0x00 
    .byte 0x39              ;e6d7  39          UNKNOWN 0x39 '9' 
    .byte 0x83              ;e6d8  83          UNKNOWN 0x83 
    .byte 0x3a              ;e6d9  3a          UNKNOWN 0x3a ':' 
    .byte 0x09              ;e6da  09          UNKNOWN 0x09 
    .byte 0x3b              ;e6db  3b          UNKNOWN 0x3b ';' 
    .byte 0x0c              ;e6dc  0c          UNKNOWN 0x0c 
    .byte 0x3e              ;e6dd  3e          UNKNOWN 0x3e '>' 
    .byte 0x20              ;e6de  20          UNKNOWN 0x20 ' ' 
    .byte 0x3f              ;e6df  3f          UNKNOWN 0x3f '?' 
    .byte 0x40              ;e6e0  40          UNKNOWN 0x40 '@' 
    .byte 0x3c              ;e6e1  3c          UNKNOWN 0x3c '<' 
    .byte 0x00              ;e6e2  00          UNKNOWN 0x00 
    .byte 0x3d              ;e6e3  3d          UNKNOWN 0x3d '=' 
    .byte 0x00              ;e6e4  00          UNKNOWN 0x00 
    .byte 0x40              ;e6e5  40          UNKNOWN 0x40 '@' 
    .byte 0x01              ;e6e6  01          UNKNOWN 0x01 
    .byte 0x3e              ;e6e7  3e          UNKNOWN 0x3e '>' 
    .byte 0x2c              ;e6e8  2c          UNKNOWN 0x2c ',' 
    .byte 0x00              ;e6e9  00          UNKNOWN 0x00 
    .byte 0x01              ;e6ea  01          UNKNOWN 0x01 
    .byte 0x3f              ;e6eb  3f          UNKNOWN 0x3f '?' 
    .byte 0xc0              ;e6ec  c0          UNKNOWN 0xc0 
    .byte 0x00              ;e6ed  00          UNKNOWN 0x00 
    .byte 0x00              ;e6ee  00          UNKNOWN 0x00 
    .byte 0x01              ;e6ef  01          UNKNOWN 0x01 
    .byte 0x00              ;e6f0  00          UNKNOWN 0x00 
    .byte 0x00              ;e6f1  00          UNKNOWN 0x00 
    .byte 0x01              ;e6f2  01          UNKNOWN 0x01 
    .byte 0x02              ;e6f3  02          UNKNOWN 0x02 
    .byte 0x00              ;e6f4  00          UNKNOWN 0x00 
    .byte 0xa0              ;e6f5  a0          UNKNOWN 0xa0 
    .byte 0x01              ;e6f6  01          UNKNOWN 0x01 
    .byte 0x27              ;e6f7  27          UNKNOWN 0x27 ''' 
    .byte 0xff              ;e6f8  ff          UNKNOWN 0xff 

sub_e6f9:
    bra lab_e6fb            ;e6f9  80 00    

lab_e6fb:
    jsr \0xffff             ;e6fb  22 ff    
    clb 7,P0                ;e6fd  ff 00    
    bbs 1,a,lab_e696        ;e6ff  23 95    
    sta P0D,x               ;e701  95 01    
    clb 1,a                 ;e703  3b       
    seb 2,mem_004c          ;e704  4f 4c    
    rti                     ;e706  40       

    .byte 0x01              ;e707  01          UNKNOWN 0x01 
    .byte 0x3e              ;e708  3e          UNKNOWN 0x3e '>' 
    .byte 0x20              ;e709  20          UNKNOWN 0x20 ' ' 
    .byte 0x00              ;e70a  00          UNKNOWN 0x00 
    .byte 0x01              ;e70b  01          UNKNOWN 0x01 
    .byte 0x3f              ;e70c  3f          UNKNOWN 0x3f '?' 
    .byte 0xc0              ;e70d  c0          UNKNOWN 0xc0 
    .byte 0x00              ;e70e  00          UNKNOWN 0x00 
    .byte 0x01              ;e70f  01          UNKNOWN 0x01 
    .byte 0x1a              ;e710  1a          UNKNOWN 0x1a 
    .byte 0x4b              ;e711  4b          UNKNOWN 0x4b 'K' 
    .byte 0x00              ;e712  00          UNKNOWN 0x00 
    .byte 0x00              ;e713  00          UNKNOWN 0x00 
    .byte 0x01              ;e714  01          UNKNOWN 0x01 
    .byte 0x00              ;e715  00          UNKNOWN 0x00 
    .byte 0x00              ;e716  00          UNKNOWN 0x00 
    .byte 0x01              ;e717  01          UNKNOWN 0x01 
    .byte 0x02              ;e718  02          UNKNOWN 0x02 
    .byte 0x00              ;e719  00          UNKNOWN 0x00 
    .byte 0x80              ;e71a  80          UNKNOWN 0x80 
    .byte 0x01              ;e71b  01          UNKNOWN 0x01 
    .byte 0x04              ;e71c  04          UNKNOWN 0x04 

mem_e71d:
    .byte 0xf3              ;e71d  f3          DATA 0xf3 
    .byte 0x00              ;e71e  00          DATA 0x00 
    .byte 0x01              ;e71f  01          DATA 0x01 
    .byte 0x08              ;e720  08          DATA 0x08 
    .byte 0xc0              ;e721  c0          DATA 0xc0 
    .byte 0x00              ;e722  00          DATA 0x00 
    .byte 0x01              ;e723  01          DATA 0x01 
    .byte 0x27              ;e724  27          DATA 0x27 ''' 
    .byte 0xff              ;e725  ff          DATA 0xff 
    .byte 0x80              ;e726  80          DATA 0x80 
    .byte 0x00              ;e727  00          DATA 0x00 
    .byte 0x22              ;e728  22          DATA 0x22 '"' 
    .byte 0xff              ;e729  ff          DATA 0xff 
    .byte 0xff              ;e72a  ff          DATA 0xff 
    .byte 0x00              ;e72b  00          DATA 0x00 
    .byte 0x23              ;e72c  23          DATA 0x23 '#' 
    .byte 0x95              ;e72d  95          DATA 0x95 
    .byte 0x95              ;e72e  95          DATA 0x95 
    .byte 0x01              ;e72f  01          DATA 0x01 
    .byte 0x3b              ;e730  3b          DATA 0x3b ';' 
    .byte 0x4f              ;e731  4f          DATA 0x4f 'O' 
    .byte 0x4c              ;e732  4c          DATA 0x4c 'L' 
    .byte 0x40              ;e733  40          DATA 0x40 '@' 
    .byte 0x00              ;e734  00          DATA 0x00 
    .byte 0x01              ;e735  01          DATA 0x01 
    .byte 0x00              ;e736  00          DATA 0x00 
    .byte 0x00              ;e737  00          DATA 0x00 
    .byte 0x01              ;e738  01          DATA 0x01 
    .byte 0x02              ;e739  02          DATA 0x02 
    .byte 0x00              ;e73a  00          DATA 0x00 
    .byte 0xa0              ;e73b  a0          DATA 0xa0 
    .byte 0x00              ;e73c  00          DATA 0x00 
    .byte 0x1a              ;e73d  1a          DATA 0x1a 
    .byte 0x01              ;e73e  01          DATA 0x01 
    .byte 0x01              ;e73f  01          DATA 0x01 
    .byte 0x00              ;e740  00          DATA 0x00 
    .byte 0x1c              ;e741  1c          DATA 0x1c 
    .byte 0x1f              ;e742  1f          DATA 0x1f 
    .byte 0x1f              ;e743  1f          DATA 0x1f 
    .byte 0x00              ;e744  00          DATA 0x00 
    .byte 0x1b              ;e745  1b          DATA 0x1b 
    .byte 0x00              ;e746  00          DATA 0x00 
    .byte 0x00              ;e747  00          DATA 0x00 
    .byte 0x00              ;e748  00          DATA 0x00 
    .byte 0x19              ;e749  19          DATA 0x19 
    .byte 0x05              ;e74a  05          DATA 0x05 
    .byte 0x05              ;e74b  05          DATA 0x05 
    .byte 0x00              ;e74c  00          DATA 0x00 
    .byte 0x1a              ;e74d  1a          DATA 0x1a 
    .byte 0xb1              ;e74e  b1          DATA 0xb1 
    .byte 0xb1              ;e74f  b1          DATA 0xb1 
    .byte 0x01              ;e750  01          DATA 0x01 
    .byte 0x27              ;e751  27          DATA 0x27 ''' 
    .byte 0xff              ;e752  ff          DATA 0xff 
    .byte 0x80              ;e753  80          DATA 0x80 
    .byte 0x00              ;e754  00          DATA 0x00 
    .byte 0x22              ;e755  22          DATA 0x22 '"' 
    .byte 0xff              ;e756  ff          DATA 0xff 
    .byte 0xff              ;e757  ff          DATA 0xff 
    .byte 0x00              ;e758  00          DATA 0x00 
    .byte 0x23              ;e759  23          DATA 0x23 '#' 
    .byte 0x0e              ;e75a  0e          DATA 0x0e 
    .byte 0x0e              ;e75b  0e          DATA 0x0e 
    .byte 0x01              ;e75c  01          DATA 0x01 
    .byte 0x3b              ;e75d  3b          DATA 0x3b ';' 
    .byte 0x0f              ;e75e  0f          DATA 0x0f 
    .byte 0x0c              ;e75f  0c          DATA 0x0c 
    .byte 0x01              ;e760  01          DATA 0x01 
    .byte 0x3e              ;e761  3e          DATA 0x3e '>' 
    .byte 0xff              ;e762  ff          DATA 0xff 
    .byte 0x24              ;e763  24          DATA 0x24 '$' 
    .byte 0x01              ;e764  01          DATA 0x01 
    .byte 0x3f              ;e765  3f          DATA 0x3f '?' 
    .byte 0xc0              ;e766  c0          DATA 0xc0 
    .byte 0x00              ;e767  00          DATA 0x00 
    .byte 0x40              ;e768  40          DATA 0x40 '@' 
    .byte 0xa2              ;e769  a2          DATA 0xa2 
    .byte 0x00              ;e76a  00          DATA 0x00 
    .byte 0xbc              ;e76b  bc          DATA 0xbc 
    .byte 0x30              ;e76c  30          DATA 0x30 '0' 
    .byte 0xe8              ;e76d  e8          DATA 0xe8 
    .byte 0xc0              ;e76e  c0          DATA 0xc0 
    .byte 0x00              ;e76f  00          DATA 0x00 
    .byte 0xf0              ;e770  f0          DATA 0xf0 
    .byte 0x0a              ;e771  0a          DATA 0x0a 
    .byte 0xe8              ;e772  e8          DATA 0xe8 
    .byte 0xbd              ;e773  bd          DATA 0xbd 
    .byte 0x30              ;e774  30          DATA 0x30 '0' 
    .byte 0xe8              ;e775  e8          DATA 0xe8 
    .byte 0x99              ;e776  99          DATA 0x99 
    .byte 0x00              ;e777  00          DATA 0x00 
    .byte 0x00              ;e778  00          DATA 0x00 
    .byte 0xe8              ;e779  e8          DATA 0xe8 
    .byte 0x80              ;e77a  80          DATA 0x80 
    .byte 0xef              ;e77b  ef          DATA 0xef 
    .byte 0x20              ;e77c  20          DATA 0x20 ' ' 
    .byte 0x9a              ;e77d  9a          DATA 0x9a 
    .byte 0xd0              ;e77e  d0          DATA 0xd0 
    .byte 0x8a              ;e77f  8a          DATA 0x8a 
    .byte 0xf0              ;e780  f0          DATA 0xf0 
    .byte 0x08              ;e781  08          DATA 0x08 
    .byte 0x07              ;e782  07          DATA 0x07 
    .byte 0x08              ;e783  08          DATA 0x08 
    .byte 0x03              ;e784  03          DATA 0x03 
    .byte 0x37              ;e785  37          DATA 0x37 '7' 
    .byte 0x0e              ;e786  0e          DATA 0x0e 
    .byte 0x02              ;e787  02          DATA 0x02 
    .byte 0x0f              ;e788  0f          DATA 0x0f 
    .byte 0x6d              ;e789  6d          DATA 0x6d 'm' 
    .byte 0x20              ;e78a  20          DATA 0x20 ' ' 
    .byte 0x0a              ;e78b  0a          DATA 0x0a 
    .byte 0xcf              ;e78c  cf          DATA 0xcf 
    .byte 0x20              ;e78d  20          DATA 0x20 ' ' 
    .byte 0x1d              ;e78e  1d          DATA 0x1d 
    .byte 0xcf              ;e78f  cf          DATA 0xcf 
    .byte 0x3c              ;e790  3c          DATA 0x3c '<' 
    .byte 0xfe              ;e791  fe          DATA 0xfe 
    .byte 0xc5              ;e792  c5          DATA 0xc5 
    .byte 0xa9              ;e793  a9          DATA 0xa9 
    .byte 0xb6              ;e794  b6          DATA 0xb6 
    .byte 0x85              ;e795  85          DATA 0x85 
    .byte 0xed              ;e796  ed          DATA 0xed 
    .byte 0xa9              ;e797  a9          DATA 0xa9 
    .byte 0x9f              ;e798  9f          DATA 0x9f 
    .byte 0x85              ;e799  85          DATA 0x85 
    .byte 0xee              ;e79a  ee          DATA 0xee 
    .byte 0xa9              ;e79b  a9          DATA 0xa9 
    .byte 0xa3              ;e79c  a3          DATA 0xa3 
    .byte 0x85              ;e79d  85          DATA 0x85 
    .byte 0xef              ;e79e  ef          DATA 0xef 
    .byte 0xa9              ;e79f  a9          DATA 0xa9 
    .byte 0x53              ;e7a0  53          DATA 0x53 'S' 
    .byte 0x85              ;e7a1  85          DATA 0x85 
    .byte 0xf0              ;e7a2  f0          DATA 0xf0 
    .byte 0xa9              ;e7a3  a9          DATA 0xa9 
    .byte 0xba              ;e7a4  ba          DATA 0xba 
    .byte 0x85              ;e7a5  85          DATA 0x85 
    .byte 0xf1              ;e7a6  f1          DATA 0xf1 
    .byte 0xa9              ;e7a7  a9          DATA 0xa9 
    .byte 0x42              ;e7a8  42          DATA 0x42 'B' 
    .byte 0x85              ;e7a9  85          DATA 0x85 
    .byte 0xf2              ;e7aa  f2          DATA 0xf2 
    .byte 0xa9              ;e7ab  a9          DATA 0xa9 
    .byte 0x02              ;e7ac  02          DATA 0x02 
    .byte 0x85              ;e7ad  85          DATA 0x85 
    .byte 0xf3              ;e7ae  f3          DATA 0xf3 
    .byte 0x60              ;e7af  60          DATA 0x60 '`' 
    .byte 0x50              ;e7b0  50          DATA 0x50 'P' 
    .byte 0x20              ;e7b1  20          DATA 0x20 ' ' 
    .byte 0x96              ;e7b2  96          DATA 0x96 
    .byte 0x28              ;e7b3  28          DATA 0x28 '(' 
    .byte 0xa1              ;e7b4  a1          DATA 0xa1 
    .byte 0x0a              ;e7b5  0a          DATA 0x0a 
    .byte 0xa2              ;e7b6  a2          DATA 0xa2 
    .byte 0x04              ;e7b7  04          DATA 0x04 
    .byte 0xa3              ;e7b8  a3          DATA 0xa3 
    .byte 0x3c              ;e7b9  3c          DATA 0x3c '<' 
    .byte 0xaa              ;e7ba  aa          DATA 0xaa 
    .byte 0xff              ;e7bb  ff          DATA 0xff 
    .byte 0xab              ;e7bc  ab          DATA 0xab 
    .byte 0x0f              ;e7bd  0f          DATA 0x0f 
    .byte 0xac              ;e7be  ac          DATA 0xac 
    .byte 0x38              ;e7bf  38          DATA 0x38 '8' 
    .byte 0x6d              ;e7c0  6d          DATA 0x6d 'm' 
    .byte 0x30              ;e7c1  30          DATA 0x30 '0' 
    .byte 0x00              ;e7c2  00          DATA 0x00 
    .byte 0x3c              ;e7c3  3c          DATA 0x3c '<' 
    .byte 0x40              ;e7c4  40          DATA 0x40 '@' 
    .byte 0x50              ;e7c5  50          DATA 0x50 'P' 
    .byte 0x1f              ;e7c6  1f          DATA 0x1f 
    .byte 0x82              ;e7c7  82          DATA 0x82 
    .byte 0x3c              ;e7c8  3c          DATA 0x3c '<' 
    .byte 0x00              ;e7c9  00          DATA 0x00 
    .byte 0x8f              ;e7ca  8f          DATA 0x8f 
    .byte 0xff              ;e7cb  ff          DATA 0xff 
    .byte 0xd3              ;e7cc  d3          DATA 0xd3 
    .byte 0xdf              ;e7cd  df          DATA 0xdf 
    .byte 0x80              ;e7ce  80          DATA 0x80 
    .byte 0xff              ;e7cf  ff          DATA 0xff 
    .byte 0x80              ;e7d0  80          DATA 0x80 
    .byte 0x1f              ;e7d1  1f          DATA 0x1f 
    .byte 0x80              ;e7d2  80          DATA 0x80 
    .byte 0xbf              ;e7d3  bf          DATA 0xbf 
    .byte 0x80              ;e7d4  80          DATA 0x80 
    .byte 0x9f              ;e7d5  9f          DATA 0x9f 
    .byte 0x80              ;e7d6  80          DATA 0x80 
    .byte 0x3c              ;e7d7  3c          DATA 0x3c '<' 
    .byte 0x00              ;e7d8  00          DATA 0x00 
    .byte 0x81              ;e7d9  81          DATA 0x81 
    .byte 0x07              ;e7da  07          DATA 0x07 
    .byte 0xc1              ;e7db  c1          DATA 0xc1 
    .byte 0x04              ;e7dc  04          DATA 0x04 
    .byte 0x7f              ;e7dd  7f          DATA 0x7f 
    .byte 0x3c              ;e7de  3c          DATA 0x3c '<' 
    .byte 0x5f              ;e7df  5f          DATA 0x5f '_' 
    .byte 0x3c              ;e7e0  3c          DATA 0x3c '<' 
    .byte 0x3f              ;e7e1  3f          DATA 0x3f '?' 
    .byte 0x3c              ;e7e2  3c          DATA 0x3c '<' 
    .byte 0x20              ;e7e3  20          DATA 0x20 ' ' 
    .byte 0x0a              ;e7e4  0a          DATA 0x0a 
    .byte 0xcf              ;e7e5  cf          DATA 0xcf 
    .byte 0x20              ;e7e6  20          DATA 0x20 ' ' 
    .byte 0x1d              ;e7e7  1d          DATA 0x1d 
    .byte 0xcf              ;e7e8  cf          DATA 0xcf 
    .byte 0xdf              ;e7e9  df          DATA 0xdf 
    .byte 0xbf              ;e7ea  bf          DATA 0xbf 
    .byte 0x9f              ;e7eb  9f          DATA 0x9f 
    .byte 0xbf              ;e7ec  bf          DATA 0xbf 
    .byte 0x7f              ;e7ed  7f          DATA 0x7f 
    .byte 0xbf              ;e7ee  bf          DATA 0xbf 
    .byte 0xa9              ;e7ef  a9          DATA 0xa9 
    .byte 0x00              ;e7f0  00          DATA 0x00 
    .byte 0x85              ;e7f1  85          DATA 0x85 
    .byte 0xcd              ;e7f2  cd          DATA 0xcd 
    .byte 0x20              ;e7f3  20          DATA 0x20 ' ' 
    .byte 0xc3              ;e7f4  c3          DATA 0xc3 
    .byte 0xd1              ;e7f5  d1          DATA 0xd1 
    .byte 0x60              ;e7f6  60          DATA 0x60 '`' 
    .byte 0x3c              ;e7f7  3c          DATA 0x3c '<' 
    .byte 0x20              ;e7f8  20          DATA 0x20 ' ' 
    .byte 0x50              ;e7f9  50          DATA 0x50 'P' 
    .byte 0x1f              ;e7fa  1f          DATA 0x1f 
    .byte 0x82              ;e7fb  82          DATA 0x82 
    .byte 0x3c              ;e7fc  3c          DATA 0x3c '<' 
    .byte 0x00              ;e7fd  00          DATA 0x00 
    .byte 0x8f              ;e7fe  8f          DATA 0x8f 
    .byte 0xff              ;e7ff  ff          DATA 0xff 
    .byte 0xdf              ;e800  df          DATA 0xdf 
    .byte 0xdf              ;e801  df          DATA 0xdf 
    .byte 0x80              ;e802  80          DATA 0x80 
    .byte 0xff              ;e803  ff          DATA 0xff 
    .byte 0x80              ;e804  80          DATA 0x80 
    .byte 0x1f              ;e805  1f          DATA 0x1f 
    .byte 0x80              ;e806  80          DATA 0x80 
    .byte 0xbf              ;e807  bf          DATA 0xbf 
    .byte 0x80              ;e808  80          DATA 0x80 
    .byte 0x9f              ;e809  9f          DATA 0x9f 
    .byte 0x80              ;e80a  80          DATA 0x80 
    .byte 0x3c              ;e80b  3c          DATA 0x3c '<' 
    .byte 0x00              ;e80c  00          DATA 0x00 
    .byte 0x81              ;e80d  81          DATA 0x81 
    .byte 0x7f              ;e80e  7f          DATA 0x7f 
    .byte 0x3c              ;e80f  3c          DATA 0x3c '<' 
    .byte 0x5f              ;e810  5f          DATA 0x5f '_' 
    .byte 0x3c              ;e811  3c          DATA 0x3c '<' 
    .byte 0x3f              ;e812  3f          DATA 0x3f '?' 
    .byte 0x3c              ;e813  3c          DATA 0x3c '<' 
    .byte 0x20              ;e814  20          DATA 0x20 ' ' 
    .byte 0x0a              ;e815  0a          DATA 0x0a 
    .byte 0xcf              ;e816  cf          DATA 0xcf 
    .byte 0x20              ;e817  20          DATA 0x20 ' ' 
    .byte 0x1d              ;e818  1d          DATA 0x1d 
    .byte 0xcf              ;e819  cf          DATA 0xcf 
    .byte 0xdf              ;e81a  df          DATA 0xdf 
    .byte 0xbf              ;e81b  bf          DATA 0xbf 
    .byte 0x9f              ;e81c  9f          DATA 0x9f 
    .byte 0xbf              ;e81d  bf          DATA 0xbf 
    .byte 0x7f              ;e81e  7f          DATA 0x7f 
    .byte 0xbf              ;e81f  bf          DATA 0xbf 
    .byte 0xa9              ;e820  a9          DATA 0xa9 
    .byte 0x00              ;e821  00          DATA 0x00 
    .byte 0x85              ;e822  85          DATA 0x85 
    .byte 0xcd              ;e823  cd          DATA 0xcd 
    .byte 0x20              ;e824  20          DATA 0x20 ' ' 
    .byte 0xc3              ;e825  c3          DATA 0xc3 
    .byte 0xd1              ;e826  d1          DATA 0xd1 
    .byte 0x60              ;e827  60          DATA 0x60 '`' 
    .byte 0xff              ;e828  ff          DATA 0xff 
    .byte 0xbf              ;e829  bf          DATA 0xbf 
    .byte 0x3c              ;e82a  3c          DATA 0x3c '<' 
    .byte 0x08              ;e82b  08          DATA 0x08 
    .byte 0xa4              ;e82c  a4          DATA 0xa4 
    .byte 0x20              ;e82d  20          DATA 0x20 ' ' 
    .byte 0x96              ;e82e  96          DATA 0x96 
    .byte 0xd5              ;e82f  d5          DATA 0xd5 
    .byte 0x3c              ;e830  3c          DATA 0x3c '<' 
    .byte 0x80              ;e831  80          DATA 0x80 
    .byte 0x50              ;e832  50          DATA 0x50 'P' 
    .byte 0x3c              ;e833  3c          DATA 0x3c '<' 
    .byte 0x00              ;e834  00          DATA 0x00 
    .byte 0x8f              ;e835  8f          DATA 0x8f 
    .byte 0xdf              ;e836  df          DATA 0xdf 
    .byte 0x95              ;e837  95          DATA 0x95 
    .byte 0x3c              ;e838  3c          DATA 0x3c '<' 
    .byte 0x03              ;e839  03          DATA 0x03 
    .byte 0x96              ;e83a  96          DATA 0x96 
    .byte 0x3c              ;e83b  3c          DATA 0x3c '<' 
    .byte 0x00              ;e83c  00          DATA 0x00 
    .byte 0xbb              ;e83d  bb          DATA 0xbb 
    .byte 0x3c              ;e83e  3c          DATA 0x3c '<' 
    .byte 0x00              ;e83f  00          DATA 0x00 
    .byte 0xbd              ;e840  bd          DATA 0xbd 
    .byte 0x3c              ;e841  3c          DATA 0x3c '<' 
    .byte 0x00              ;e842  00          DATA 0x00 
    .byte 0xbe              ;e843  be          DATA 0xbe 
    .byte 0x7f              ;e844  7f          DATA 0x7f 
    .byte 0xbf              ;e845  bf          DATA 0xbf 
    .byte 0xa9              ;e846  a9          DATA 0xa9 
    .byte 0x00              ;e847  00          DATA 0x00 
    .byte 0x85              ;e848  85          DATA 0x85 
    .byte 0xcd              ;e849  cd          DATA 0xcd 
    .byte 0xdf              ;e84a  df          DATA 0xdf 
    .byte 0x80              ;e84b  80          DATA 0x80 
    .byte 0x3c              ;e84c  3c          DATA 0x3c '<' 
    .byte 0x00              ;e84d  00          DATA 0x00 
    .byte 0xce              ;e84e  ce          DATA 0xce 
    .byte 0x3c              ;e84f  3c          DATA 0x3c '<' 
    .byte 0x00              ;e850  00          DATA 0x00 
    .byte 0xcf              ;e851  cf          DATA 0xcf 
    .byte 0x3c              ;e852  3c          DATA 0x3c '<' 
    .byte 0x00              ;e853  00          DATA 0x00 
    .byte 0xd0              ;e854  d0          DATA 0xd0 
    .byte 0x3c              ;e855  3c          DATA 0x3c '<' 
    .byte 0x40              ;e856  40          DATA 0x40 '@' 
    .byte 0xd3              ;e857  d3          DATA 0xd3 
    .byte 0x3c              ;e858  3c          DATA 0x3c '<' 
    .byte 0x80              ;e859  80          DATA 0x80 
    .byte 0xd5              ;e85a  d5          DATA 0xd5 
    .byte 0x3c              ;e85b  3c          DATA 0x3c '<' 
    .byte 0x00              ;e85c  00          DATA 0x00 
    .byte 0xd6              ;e85d  d6          DATA 0xd6 
    .byte 0x3c              ;e85e  3c          DATA 0x3c '<' 
    .byte 0x00              ;e85f  00          DATA 0x00 
    .byte 0xd7              ;e860  d7          DATA 0xd7 
    .byte 0x3c              ;e861  3c          DATA 0x3c '<' 
    .byte 0x00              ;e862  00          DATA 0x00 
    .byte 0xd8              ;e863  d8          DATA 0xd8 
    .byte 0x3c              ;e864  3c          DATA 0x3c '<' 
    .byte 0x00              ;e865  00          DATA 0x00 
    .byte 0xd9              ;e866  d9          DATA 0xd9 
    .byte 0xff              ;e867  ff          DATA 0xff 
    .byte 0x80              ;e868  80          DATA 0x80 
    .byte 0x1f              ;e869  1f          DATA 0x1f 
    .byte 0x80              ;e86a  80          DATA 0x80 
    .byte 0xbf              ;e86b  bf          DATA 0xbf 
    .byte 0x80              ;e86c  80          DATA 0x80 
    .byte 0x9f              ;e86d  9f          DATA 0x9f 
    .byte 0x80              ;e86e  80          DATA 0x80 
    .byte 0x3c              ;e86f  3c          DATA 0x3c '<' 
    .byte 0x00              ;e870  00          DATA 0x00 
    .byte 0x81              ;e871  81          DATA 0x81 
    .byte 0x7f              ;e872  7f          DATA 0x7f 
    .byte 0x3c              ;e873  3c          DATA 0x3c '<' 
    .byte 0x5f              ;e874  5f          DATA 0x5f '_' 
    .byte 0x3c              ;e875  3c          DATA 0x3c '<' 
    .byte 0x3f              ;e876  3f          DATA 0x3f '?' 
    .byte 0x3c              ;e877  3c          DATA 0x3c '<' 
    .byte 0x20              ;e878  20          DATA 0x20 ' ' 
    .byte 0xc3              ;e879  c3          DATA 0xc3 
    .byte 0xd1              ;e87a  d1          DATA 0xd1 
    .byte 0x60              ;e87b  60          DATA 0x60 '`' 
    .byte 0x40              ;e87c  40          DATA 0x40 '@' 
    .byte 0x60              ;e87d  60          DATA 0x60 '`' 
    .byte 0xff              ;e87e  ff          DATA 0xff 
    .byte 0xff              ;e87f  ff          DATA 0xff 
    .byte 0xff              ;e880  ff          DATA 0xff 
    .byte 0xff              ;e881  ff          DATA 0xff 
    .byte 0xff              ;e882  ff          DATA 0xff 
    .byte 0xff              ;e883  ff          DATA 0xff 
    .byte 0xff              ;e884  ff          DATA 0xff 
    .byte 0xff              ;e885  ff          DATA 0xff 
    .byte 0xff              ;e886  ff          DATA 0xff 
    .byte 0xff              ;e887  ff          DATA 0xff 
    .byte 0xff              ;e888  ff          DATA 0xff 
    .byte 0xff              ;e889  ff          DATA 0xff 
    .byte 0xff              ;e88a  ff          DATA 0xff 
    .byte 0xff              ;e88b  ff          DATA 0xff 
    .byte 0xff              ;e88c  ff          DATA 0xff 
    .byte 0xff              ;e88d  ff          DATA 0xff 
    .byte 0xff              ;e88e  ff          DATA 0xff 
    .byte 0xff              ;e88f  ff          DATA 0xff 
    .byte 0xff              ;e890  ff          DATA 0xff 
    .byte 0xff              ;e891  ff          DATA 0xff 
    .byte 0xff              ;e892  ff          DATA 0xff 
    .byte 0xff              ;e893  ff          DATA 0xff 
    .byte 0xff              ;e894  ff          DATA 0xff 
    .byte 0xff              ;e895  ff          DATA 0xff 
    .byte 0xff              ;e896  ff          DATA 0xff 
    .byte 0xff              ;e897  ff          DATA 0xff 
    .byte 0xff              ;e898  ff          DATA 0xff 
    .byte 0xff              ;e899  ff          DATA 0xff 
    .byte 0xff              ;e89a  ff          DATA 0xff 
    .byte 0xff              ;e89b  ff          DATA 0xff 
    .byte 0xff              ;e89c  ff          DATA 0xff 
    .byte 0xff              ;e89d  ff          DATA 0xff 
    .byte 0xff              ;e89e  ff          DATA 0xff 
    .byte 0xff              ;e89f  ff          DATA 0xff 
    .byte 0xff              ;e8a0  ff          DATA 0xff 
    .byte 0xff              ;e8a1  ff          DATA 0xff 
    .byte 0xff              ;e8a2  ff          DATA 0xff 
    .byte 0xff              ;e8a3  ff          DATA 0xff 
    .byte 0xff              ;e8a4  ff          DATA 0xff 
    .byte 0xff              ;e8a5  ff          DATA 0xff 
    .byte 0xff              ;e8a6  ff          DATA 0xff 
    .byte 0xff              ;e8a7  ff          DATA 0xff 
    .byte 0xff              ;e8a8  ff          DATA 0xff 
    .byte 0xff              ;e8a9  ff          DATA 0xff 
    .byte 0xff              ;e8aa  ff          DATA 0xff 
    .byte 0xff              ;e8ab  ff          DATA 0xff 
    .byte 0xff              ;e8ac  ff          DATA 0xff 
    .byte 0xff              ;e8ad  ff          DATA 0xff 
    .byte 0xff              ;e8ae  ff          DATA 0xff 
    .byte 0xff              ;e8af  ff          DATA 0xff 
    .byte 0xff              ;e8b0  ff          DATA 0xff 
    .byte 0xff              ;e8b1  ff          DATA 0xff 
    .byte 0xff              ;e8b2  ff          DATA 0xff 
    .byte 0xff              ;e8b3  ff          DATA 0xff 
    .byte 0xff              ;e8b4  ff          DATA 0xff 
    .byte 0xff              ;e8b5  ff          DATA 0xff 
    .byte 0xff              ;e8b6  ff          DATA 0xff 
    .byte 0xff              ;e8b7  ff          DATA 0xff 
    .byte 0xff              ;e8b8  ff          DATA 0xff 
    .byte 0xff              ;e8b9  ff          DATA 0xff 
    .byte 0xff              ;e8ba  ff          DATA 0xff 
    .byte 0xff              ;e8bb  ff          DATA 0xff 
    .byte 0xff              ;e8bc  ff          DATA 0xff 
    .byte 0xff              ;e8bd  ff          DATA 0xff 
    .byte 0xff              ;e8be  ff          DATA 0xff 
    .byte 0xff              ;e8bf  ff          DATA 0xff 
    .byte 0xff              ;e8c0  ff          DATA 0xff 
    .byte 0xff              ;e8c1  ff          DATA 0xff 
    .byte 0xff              ;e8c2  ff          DATA 0xff 
    .byte 0xff              ;e8c3  ff          DATA 0xff 
    .byte 0xff              ;e8c4  ff          DATA 0xff 
    .byte 0xff              ;e8c5  ff          DATA 0xff 
    .byte 0xff              ;e8c6  ff          DATA 0xff 
    .byte 0xff              ;e8c7  ff          DATA 0xff 
    .byte 0xff              ;e8c8  ff          DATA 0xff 
    .byte 0xff              ;e8c9  ff          DATA 0xff 
    .byte 0xff              ;e8ca  ff          DATA 0xff 
    .byte 0xff              ;e8cb  ff          DATA 0xff 
    .byte 0xff              ;e8cc  ff          DATA 0xff 
    .byte 0xff              ;e8cd  ff          DATA 0xff 
    .byte 0xff              ;e8ce  ff          DATA 0xff 
    .byte 0xff              ;e8cf  ff          DATA 0xff 
    .byte 0xff              ;e8d0  ff          DATA 0xff 
    .byte 0xff              ;e8d1  ff          DATA 0xff 
    .byte 0xff              ;e8d2  ff          DATA 0xff 
    .byte 0xff              ;e8d3  ff          DATA 0xff 
    .byte 0xff              ;e8d4  ff          DATA 0xff 
    .byte 0xff              ;e8d5  ff          DATA 0xff 
    .byte 0xff              ;e8d6  ff          DATA 0xff 
    .byte 0xff              ;e8d7  ff          DATA 0xff 
    .byte 0xff              ;e8d8  ff          DATA 0xff 
    .byte 0xff              ;e8d9  ff          DATA 0xff 
    .byte 0xff              ;e8da  ff          DATA 0xff 
    .byte 0xff              ;e8db  ff          DATA 0xff 
    .byte 0xff              ;e8dc  ff          DATA 0xff 
    .byte 0xff              ;e8dd  ff          DATA 0xff 
    .byte 0xff              ;e8de  ff          DATA 0xff 
    .byte 0xff              ;e8df  ff          DATA 0xff 
    .byte 0xff              ;e8e0  ff          DATA 0xff 
    .byte 0xff              ;e8e1  ff          DATA 0xff 
    .byte 0xff              ;e8e2  ff          DATA 0xff 
    .byte 0xff              ;e8e3  ff          DATA 0xff 
    .byte 0xff              ;e8e4  ff          DATA 0xff 
    .byte 0xff              ;e8e5  ff          DATA 0xff 
    .byte 0xff              ;e8e6  ff          DATA 0xff 
    .byte 0xff              ;e8e7  ff          DATA 0xff 
    .byte 0xff              ;e8e8  ff          DATA 0xff 
    .byte 0xff              ;e8e9  ff          DATA 0xff 
    .byte 0xff              ;e8ea  ff          DATA 0xff 
    .byte 0xff              ;e8eb  ff          DATA 0xff 
    .byte 0xff              ;e8ec  ff          DATA 0xff 
    .byte 0xff              ;e8ed  ff          DATA 0xff 
    .byte 0xff              ;e8ee  ff          DATA 0xff 
    .byte 0xff              ;e8ef  ff          DATA 0xff 
    .byte 0xff              ;e8f0  ff          DATA 0xff 
    .byte 0xff              ;e8f1  ff          DATA 0xff 
    .byte 0xff              ;e8f2  ff          DATA 0xff 
    .byte 0xff              ;e8f3  ff          DATA 0xff 
    .byte 0xff              ;e8f4  ff          DATA 0xff 
    .byte 0xff              ;e8f5  ff          DATA 0xff 
    .byte 0xff              ;e8f6  ff          DATA 0xff 
    .byte 0xff              ;e8f7  ff          DATA 0xff 
    .byte 0xff              ;e8f8  ff          DATA 0xff 
    .byte 0xff              ;e8f9  ff          DATA 0xff 
    .byte 0xff              ;e8fa  ff          DATA 0xff 
    .byte 0xff              ;e8fb  ff          DATA 0xff 

lab_e8fc:
    clb 7,mem_00ff          ;e8fc  ff ff    
    clb 7,mem_00ff          ;e8fe  ff ff    
    clb 7,mem_00ff          ;e900  ff ff    
    clb 7,mem_00ff          ;e902  ff ff    
    clb 7,mem_00ff          ;e904  ff ff    
    clb 7,mem_00ff          ;e906  ff ff    
    clb 7,mem_00ff          ;e908  ff ff    
    clb 7,mem_00ff          ;e90a  ff ff    
    clb 7,mem_00ff          ;e90c  ff ff    
    clb 7,mem_00ff          ;e90e  ff ff    
    clb 7,mem_00ff          ;e910  ff ff    
    clb 7,mem_00ff          ;e912  ff ff    
    clb 7,mem_00ff          ;e914  ff ff    
    clb 7,mem_00ff          ;e916  ff ff    
    clb 7,mem_00ff          ;e918  ff ff    
    clb 7,mem_00ff          ;e91a  ff ff    
    clb 7,mem_00ff          ;e91c  ff ff    
    clb 7,mem_00ff          ;e91e  ff ff    
    clb 7,mem_00ff          ;e920  ff ff    
    clb 7,mem_00ff          ;e922  ff ff    
    clb 7,mem_00ff          ;e924  ff ff    
    clb 7,mem_00ff          ;e926  ff ff    
    clb 7,mem_00ff          ;e928  ff ff    
    clb 7,mem_00ff          ;e92a  ff ff    
    clb 7,mem_00ff          ;e92c  ff ff    
    clb 7,mem_00ff          ;e92e  ff ff    
    clb 7,mem_00ff          ;e930  ff ff    
    clb 7,mem_00ff          ;e932  ff ff    
    clb 7,mem_00ff          ;e934  ff ff    
    clb 7,mem_00ff          ;e936  ff ff    
    clb 7,mem_00ff          ;e938  ff ff    
    clb 7,mem_00ff          ;e93a  ff ff    
    clb 7,mem_00ff          ;e93c  ff ff    
    clb 7,mem_00ff          ;e93e  ff ff    
    clb 7,mem_00ff          ;e940  ff ff    
    clb 7,mem_00ff          ;e942  ff ff    
    clb 7,mem_00ff          ;e944  ff ff    
    clb 7,mem_00ff          ;e946  ff ff    
    clb 7,mem_00ff          ;e948  ff ff    
    clb 7,mem_00ff          ;e94a  ff ff    
    clb 7,mem_00ff          ;e94c  ff ff    
    clb 7,mem_00ff          ;e94e  ff ff    
    clb 7,mem_00ff          ;e950  ff ff    
    clb 7,mem_00ff          ;e952  ff ff    
    clb 7,mem_00ff          ;e954  ff ff    
    clb 7,mem_00ff          ;e956  ff ff    
    clb 7,mem_00ff          ;e958  ff ff    
    clb 7,mem_00ff          ;e95a  ff ff    
    clb 7,mem_00ff          ;e95c  ff ff    
    clb 7,mem_00ff          ;e95e  ff ff    
    clb 7,mem_00ff          ;e960  ff ff    
    clb 7,mem_00ff          ;e962  ff ff    
    clb 7,mem_00ff          ;e964  ff ff    
    clb 7,mem_00ff          ;e966  ff ff    
    clb 7,mem_00ff          ;e968  ff ff    
    clb 7,mem_00ff          ;e96a  ff ff    
    clb 7,mem_00ff          ;e96c  ff ff    
    clb 7,mem_00ff          ;e96e  ff ff    
    clb 7,mem_00ff          ;e970  ff ff    
    clb 7,mem_00ff          ;e972  ff ff    
    clb 7,mem_00ff          ;e974  ff ff    
    clb 7,mem_00ff          ;e976  ff ff    
    clb 7,mem_00ff          ;e978  ff ff    
    clb 7,mem_00ff          ;e97a  ff ff    
    clb 7,mem_00ff          ;e97c  ff ff    
    clb 7,mem_00ff          ;e97e  ff ff    
    clb 7,mem_00ff          ;e980  ff ff    
    clb 7,mem_00ff          ;e982  ff ff    
    clb 7,mem_00ff          ;e984  ff ff    
    clb 7,mem_00ff          ;e986  ff ff    
    clb 7,mem_00ff          ;e988  ff ff    
    clb 7,mem_00ff          ;e98a  ff ff    
    clb 7,mem_00ff          ;e98c  ff ff    
    clb 7,mem_00ff          ;e98e  ff ff    
    clb 7,mem_00ff          ;e990  ff ff    
    clb 7,mem_00ff          ;e992  ff ff    
    clb 7,mem_00ff          ;e994  ff ff    
    clb 7,mem_00ff          ;e996  ff ff    
    clb 7,mem_00ff          ;e998  ff ff    
    clb 7,mem_00ff          ;e99a  ff ff    
    clb 7,mem_00ff          ;e99c  ff ff    
    clb 7,mem_00ff          ;e99e  ff ff    
    clb 7,mem_00ff          ;e9a0  ff ff    
    clb 7,mem_00ff          ;e9a2  ff ff    
    clb 7,mem_00ff          ;e9a4  ff ff    
    clb 7,mem_00ff          ;e9a6  ff ff    
    clb 7,mem_00ff          ;e9a8  ff ff    
    clb 7,mem_00ff          ;e9aa  ff ff    
    clb 7,mem_00ff          ;e9ac  ff ff    
    clb 7,mem_00ff          ;e9ae  ff ff    
    clb 7,mem_00ff          ;e9b0  ff ff    
    clb 7,mem_00ff          ;e9b2  ff ff    
    clb 7,mem_00ff          ;e9b4  ff ff    
    clb 7,mem_00ff          ;e9b6  ff ff    
    clb 7,mem_00ff          ;e9b8  ff ff    
    clb 7,mem_00ff          ;e9ba  ff ff    
    clb 7,mem_00ff          ;e9bc  ff ff    
    clb 7,mem_00ff          ;e9be  ff ff    
    clb 7,mem_00ff          ;e9c0  ff ff    
    clb 7,mem_00ff          ;e9c2  ff ff    
    clb 7,mem_00ff          ;e9c4  ff ff    
    clb 7,mem_00ff          ;e9c6  ff ff    
    clb 7,mem_00ff          ;e9c8  ff ff    
    clb 7,mem_00ff          ;e9ca  ff ff    
    clb 7,mem_00ff          ;e9cc  ff ff    
    clb 7,mem_00ff          ;e9ce  ff ff    
    clb 7,mem_00ff          ;e9d0  ff ff    
    clb 7,mem_00ff          ;e9d2  ff ff    
    clb 7,mem_00ff          ;e9d4  ff ff    
    clb 7,mem_00ff          ;e9d6  ff ff    
    clb 7,mem_00ff          ;e9d8  ff ff    
    clb 7,mem_00ff          ;e9da  ff ff    
    clb 7,mem_00ff          ;e9dc  ff ff    
    clb 7,mem_00ff          ;e9de  ff ff    
    clb 7,mem_00ff          ;e9e0  ff ff    
    clb 7,mem_00ff          ;e9e2  ff ff    
    clb 7,mem_00ff          ;e9e4  ff ff    
    clb 7,mem_00ff          ;e9e6  ff ff    
    clb 7,mem_00ff          ;e9e8  ff ff    
    clb 7,mem_00ff          ;e9ea  ff ff    
    clb 7,mem_00ff          ;e9ec  ff ff    
    clb 7,mem_00ff          ;e9ee  ff ff    
    clb 7,mem_00ff          ;e9f0  ff ff    
    clb 7,mem_00ff          ;e9f2  ff ff    
    clb 7,mem_00ff          ;e9f4  ff ff    
    clb 7,mem_00ff          ;e9f6  ff ff    
    clb 7,mem_00ff          ;e9f8  ff ff    
    clb 7,mem_00ff          ;e9fa  ff ff    
    clb 7,mem_00ff          ;e9fc  ff ff    
    clb 7,mem_00ff          ;e9fe  ff ff    
    clb 7,mem_00ff          ;ea00  ff ff    
    clb 7,mem_00ff          ;ea02  ff ff    
    clb 7,mem_00ff          ;ea04  ff ff    
    clb 7,mem_00ff          ;ea06  ff ff    
    clb 7,mem_00ff          ;ea08  ff ff    
    clb 7,mem_00ff          ;ea0a  ff ff    
    clb 7,mem_00ff          ;ea0c  ff ff    
    clb 7,mem_00ff          ;ea0e  ff ff    
    clb 7,mem_00ff          ;ea10  ff ff    
    clb 7,mem_00ff          ;ea12  ff ff    
    clb 7,mem_00ff          ;ea14  ff ff    
    clb 7,mem_00ff          ;ea16  ff ff    
    clb 7,mem_00ff          ;ea18  ff ff    
    clb 7,mem_00ff          ;ea1a  ff ff    
    clb 7,mem_00ff          ;ea1c  ff ff    
    clb 7,mem_00ff          ;ea1e  ff ff    
    clb 7,mem_00ff          ;ea20  ff ff    
    clb 7,mem_00ff          ;ea22  ff ff    
    clb 7,mem_00ff          ;ea24  ff ff    
    clb 7,mem_00ff          ;ea26  ff ff    
    clb 7,mem_00ff          ;ea28  ff ff    
    clb 7,mem_00ff          ;ea2a  ff ff    
    clb 7,mem_00ff          ;ea2c  ff ff    
    clb 7,mem_00ff          ;ea2e  ff ff    
    clb 7,mem_00ff          ;ea30  ff ff    
    clb 7,mem_00ff          ;ea32  ff ff    
    clb 7,mem_00ff          ;ea34  ff ff    
    clb 7,mem_00ff          ;ea36  ff ff    
    clb 7,mem_00ff          ;ea38  ff ff    
    clb 7,mem_00ff          ;ea3a  ff ff    
    clb 7,mem_00ff          ;ea3c  ff ff    
    clb 7,mem_00ff          ;ea3e  ff ff    
    clb 7,mem_00ff          ;ea40  ff ff    
    clb 7,mem_00ff          ;ea42  ff ff    
    clb 7,mem_00ff          ;ea44  ff ff    
    clb 7,mem_00ff          ;ea46  ff ff    
    clb 7,mem_00ff          ;ea48  ff ff    
    clb 7,mem_00ff          ;ea4a  ff ff    
    clb 7,mem_00ff          ;ea4c  ff ff    
    clb 7,mem_00ff          ;ea4e  ff ff    
    clb 7,mem_00ff          ;ea50  ff ff    
    clb 7,mem_00ff          ;ea52  ff ff    
    clb 7,mem_00ff          ;ea54  ff ff    
    clb 7,mem_00ff          ;ea56  ff ff    
    clb 7,mem_00ff          ;ea58  ff ff    
    clb 7,mem_00ff          ;ea5a  ff ff    
    clb 7,mem_00ff          ;ea5c  ff ff    
    clb 7,mem_00ff          ;ea5e  ff ff    
    clb 7,mem_00ff          ;ea60  ff ff    
    clb 7,mem_00ff          ;ea62  ff ff    
    clb 7,mem_00ff          ;ea64  ff ff    
    clb 7,mem_00ff          ;ea66  ff ff    
    clb 7,mem_00ff          ;ea68  ff ff    
    clb 7,mem_00ff          ;ea6a  ff ff    
    clb 7,mem_00ff          ;ea6c  ff ff    
    clb 7,mem_00ff          ;ea6e  ff ff    
    clb 7,mem_00ff          ;ea70  ff ff    
    clb 7,mem_00ff          ;ea72  ff ff    
    clb 7,mem_00ff          ;ea74  ff ff    
    clb 7,mem_00ff          ;ea76  ff ff    
    clb 7,mem_00ff          ;ea78  ff ff    
    clb 7,mem_00ff          ;ea7a  ff ff    
    clb 7,mem_00ff          ;ea7c  ff ff    
    clb 7,mem_00ff          ;ea7e  ff ff    
    clb 7,mem_00ff          ;ea80  ff ff    
    clb 7,mem_00ff          ;ea82  ff ff    
    clb 7,mem_00ff          ;ea84  ff ff    
    clb 7,mem_00ff          ;ea86  ff ff    
    clb 7,mem_00ff          ;ea88  ff ff    
    clb 7,mem_00ff          ;ea8a  ff ff    
    clb 7,mem_00ff          ;ea8c  ff ff    
    clb 7,mem_00ff          ;ea8e  ff ff    
    clb 7,mem_00ff          ;ea90  ff ff    
    clb 7,mem_00ff          ;ea92  ff ff    
    clb 7,mem_00ff          ;ea94  ff ff    
    clb 7,mem_00ff          ;ea96  ff ff    
    clb 7,mem_00ff          ;ea98  ff ff    
    clb 7,mem_00ff          ;ea9a  ff ff    
    clb 7,mem_00ff          ;ea9c  ff ff    
    clb 7,mem_00ff          ;ea9e  ff ff    
    clb 7,mem_00ff          ;eaa0  ff ff    
    clb 7,mem_00ff          ;eaa2  ff ff    
    clb 7,mem_00ff          ;eaa4  ff ff    
    clb 7,mem_00ff          ;eaa6  ff ff    
    clb 7,mem_00ff          ;eaa8  ff ff    
    clb 7,mem_00ff          ;eaaa  ff ff    
    clb 7,mem_00ff          ;eaac  ff ff    
    clb 7,mem_00ff          ;eaae  ff ff    
    clb 7,mem_00ff          ;eab0  ff ff    
    clb 7,mem_00ff          ;eab2  ff ff    
    clb 7,mem_00ff          ;eab4  ff ff    
    clb 7,mem_00ff          ;eab6  ff ff    
    clb 7,mem_00ff          ;eab8  ff ff    
    clb 7,mem_00ff          ;eaba  ff ff    
    clb 7,mem_00ff          ;eabc  ff ff    
    clb 7,mem_00ff          ;eabe  ff ff    
    clb 7,mem_00ff          ;eac0  ff ff    
    clb 7,mem_00ff          ;eac2  ff ff    
    clb 7,mem_00ff          ;eac4  ff ff    
    clb 7,mem_00ff          ;eac6  ff ff    
    clb 7,mem_00ff          ;eac8  ff ff    
    clb 7,mem_00ff          ;eaca  ff ff    
    clb 7,mem_00ff          ;eacc  ff ff    
    clb 7,mem_00ff          ;eace  ff ff    
    clb 7,mem_00ff          ;ead0  ff ff    
    clb 7,mem_00ff          ;ead2  ff ff    
    clb 7,mem_00ff          ;ead4  ff ff    
    clb 7,mem_00ff          ;ead6  ff ff    
    clb 7,mem_00ff          ;ead8  ff ff    
    clb 7,mem_00ff          ;eada  ff ff    
    clb 7,mem_00ff          ;eadc  ff ff    
    clb 7,mem_00ff          ;eade  ff ff    
    clb 7,mem_00ff          ;eae0  ff ff    
    clb 7,mem_00ff          ;eae2  ff ff    
    clb 7,mem_00ff          ;eae4  ff ff    
    clb 7,mem_00ff          ;eae6  ff ff    
    clb 7,mem_00ff          ;eae8  ff ff    
    clb 7,mem_00ff          ;eaea  ff ff    
    clb 7,mem_00ff          ;eaec  ff ff    
    clb 7,mem_00ff          ;eaee  ff ff    
    clb 7,mem_00ff          ;eaf0  ff ff    
    clb 7,mem_00ff          ;eaf2  ff ff    
    clb 7,mem_00ff          ;eaf4  ff ff    
    clb 7,mem_00ff          ;eaf6  ff ff    
    clb 7,mem_00ff          ;eaf8  ff ff    
    clb 7,mem_00ff          ;eafa  ff ff    
    clb 7,mem_00ff          ;eafc  ff ff    
    clb 7,mem_00ff          ;eafe  ff ff    
    clb 7,mem_00ff          ;eb00  ff ff    
    clb 7,mem_00ff          ;eb02  ff ff    
    clb 7,mem_00ff          ;eb04  ff ff    
    clb 7,mem_00ff          ;eb06  ff ff    
    clb 7,mem_00ff          ;eb08  ff ff    
    clb 7,mem_00ff          ;eb0a  ff ff    
    clb 7,mem_00ff          ;eb0c  ff ff    
    clb 7,mem_00ff          ;eb0e  ff ff    
    clb 7,mem_00ff          ;eb10  ff ff    
    clb 7,mem_00ff          ;eb12  ff ff    
    clb 7,mem_00ff          ;eb14  ff ff    
    clb 7,mem_00ff          ;eb16  ff ff    
    clb 7,mem_00ff          ;eb18  ff ff    
    clb 7,mem_00ff          ;eb1a  ff ff    
    clb 7,mem_00ff          ;eb1c  ff ff    
    clb 7,mem_00ff          ;eb1e  ff ff    
    clb 7,mem_00ff          ;eb20  ff ff    
    clb 7,mem_00ff          ;eb22  ff ff    
    clb 7,mem_00ff          ;eb24  ff ff    
    clb 7,mem_00ff          ;eb26  ff ff    
    clb 7,mem_00ff          ;eb28  ff ff    
    clb 7,mem_00ff          ;eb2a  ff ff    
    clb 7,mem_00ff          ;eb2c  ff ff    
    clb 7,mem_00ff          ;eb2e  ff ff    
    clb 7,mem_00ff          ;eb30  ff ff    
    clb 7,mem_00ff          ;eb32  ff ff    
    clb 7,mem_00ff          ;eb34  ff ff    
    clb 7,mem_00ff          ;eb36  ff ff    
    clb 7,mem_00ff          ;eb38  ff ff    
    clb 7,mem_00ff          ;eb3a  ff ff    
    clb 7,mem_00ff          ;eb3c  ff ff    
    clb 7,mem_00ff          ;eb3e  ff ff    
    clb 7,mem_00ff          ;eb40  ff ff    
    clb 7,mem_00ff          ;eb42  ff ff    
    clb 7,mem_00ff          ;eb44  ff ff    
    clb 7,mem_00ff          ;eb46  ff ff    
    clb 7,mem_00ff          ;eb48  ff ff    
    clb 7,mem_00ff          ;eb4a  ff ff    
    clb 7,mem_00ff          ;eb4c  ff ff    
    clb 7,mem_00ff          ;eb4e  ff ff    
    clb 7,mem_00ff          ;eb50  ff ff    
    clb 7,mem_00ff          ;eb52  ff ff    
    clb 7,mem_00ff          ;eb54  ff ff    
    clb 7,mem_00ff          ;eb56  ff ff    
    clb 7,mem_00ff          ;eb58  ff ff    
    clb 7,mem_00ff          ;eb5a  ff ff    
    clb 7,mem_00ff          ;eb5c  ff ff    
    clb 7,mem_00ff          ;eb5e  ff ff    
    clb 7,mem_00ff          ;eb60  ff ff    
    clb 7,mem_00ff          ;eb62  ff ff    
    clb 7,mem_00ff          ;eb64  ff ff    
    clb 7,mem_00ff          ;eb66  ff ff    
    clb 7,mem_00ff          ;eb68  ff ff    
    clb 7,mem_00ff          ;eb6a  ff ff    
    clb 7,mem_00ff          ;eb6c  ff ff    
    clb 7,mem_00ff          ;eb6e  ff ff    
    clb 7,mem_00ff          ;eb70  ff ff    
    clb 7,mem_00ff          ;eb72  ff ff    
    clb 7,mem_00ff          ;eb74  ff ff    
    clb 7,mem_00ff          ;eb76  ff ff    
    clb 7,mem_00ff          ;eb78  ff ff    
    clb 7,mem_00ff          ;eb7a  ff ff    
    clb 7,mem_00ff          ;eb7c  ff ff    
    clb 7,mem_00ff          ;eb7e  ff ff    
    clb 7,mem_00ff          ;eb80  ff ff    
    clb 7,mem_00ff          ;eb82  ff ff    
    clb 7,mem_00ff          ;eb84  ff ff    
    clb 7,mem_00ff          ;eb86  ff ff    
    clb 7,mem_00ff          ;eb88  ff ff    
    clb 7,mem_00ff          ;eb8a  ff ff    
    clb 7,mem_00ff          ;eb8c  ff ff    
    clb 7,mem_00ff          ;eb8e  ff ff    
    clb 7,mem_00ff          ;eb90  ff ff    
    clb 7,mem_00ff          ;eb92  ff ff    
    clb 7,mem_00ff          ;eb94  ff ff    
    clb 7,mem_00ff          ;eb96  ff ff    
    clb 7,mem_00ff          ;eb98  ff ff    
    clb 7,mem_00ff          ;eb9a  ff ff    
    clb 7,mem_00ff          ;eb9c  ff ff    
    clb 7,mem_00ff          ;eb9e  ff ff    
    clb 7,mem_00ff          ;eba0  ff ff    
    clb 7,mem_00ff          ;eba2  ff ff    
    clb 7,mem_00ff          ;eba4  ff ff    
    clb 7,mem_00ff          ;eba6  ff ff    
    clb 7,mem_00ff          ;eba8  ff ff    
    clb 7,mem_00ff          ;ebaa  ff ff    
    clb 7,mem_00ff          ;ebac  ff ff    
    clb 7,mem_00ff          ;ebae  ff ff    
    clb 7,mem_00ff          ;ebb0  ff ff    
    clb 7,mem_00ff          ;ebb2  ff ff    
    clb 7,mem_00ff          ;ebb4  ff ff    
    clb 7,mem_00ff          ;ebb6  ff ff    
    clb 7,mem_00ff          ;ebb8  ff ff    
    clb 7,mem_00ff          ;ebba  ff ff    
    clb 7,mem_00ff          ;ebbc  ff ff    
    clb 7,mem_00ff          ;ebbe  ff ff    
    clb 7,mem_00ff          ;ebc0  ff ff    
    clb 7,mem_00ff          ;ebc2  ff ff    
    clb 7,mem_00ff          ;ebc4  ff ff    
    clb 7,mem_00ff          ;ebc6  ff ff    
    clb 7,mem_00ff          ;ebc8  ff ff    
    clb 7,mem_00ff          ;ebca  ff ff    
    clb 7,mem_00ff          ;ebcc  ff ff    
    clb 7,mem_00ff          ;ebce  ff ff    
    clb 7,mem_00ff          ;ebd0  ff ff    
    clb 7,mem_00ff          ;ebd2  ff ff    
    clb 7,mem_00ff          ;ebd4  ff ff    
    clb 7,mem_00ff          ;ebd6  ff ff    
    clb 7,mem_00ff          ;ebd8  ff ff    
    clb 7,mem_00ff          ;ebda  ff ff    
    clb 7,mem_00ff          ;ebdc  ff ff    
    clb 7,mem_00ff          ;ebde  ff ff    
    clb 7,mem_00ff          ;ebe0  ff ff    
    clb 7,mem_00ff          ;ebe2  ff ff    
    clb 7,mem_00ff          ;ebe4  ff ff    
    clb 7,mem_00ff          ;ebe6  ff ff    
    clb 7,mem_00ff          ;ebe8  ff ff    
    clb 7,mem_00ff          ;ebea  ff ff    
    clb 7,mem_00ff          ;ebec  ff ff    
    clb 7,mem_00ff          ;ebee  ff ff    
    clb 7,mem_00ff          ;ebf0  ff ff    
    clb 7,mem_00ff          ;ebf2  ff ff    
    clb 7,mem_00ff          ;ebf4  ff ff    
    clb 7,mem_00ff          ;ebf6  ff ff    
    clb 7,mem_00ff          ;ebf8  ff ff    
    clb 7,mem_00ff          ;ebfa  ff ff    
    clb 7,mem_00ff          ;ebfc  ff ff    
    clb 7,mem_00ff          ;ebfe  ff ff    
    clb 7,mem_00ff          ;ec00  ff ff    
    clb 7,mem_00ff          ;ec02  ff ff    
    clb 7,mem_00ff          ;ec04  ff ff    
    clb 7,mem_00ff          ;ec06  ff ff    
    clb 7,mem_00ff          ;ec08  ff ff    
    clb 7,mem_00ff          ;ec0a  ff ff    
    clb 7,mem_00ff          ;ec0c  ff ff    
    clb 7,mem_00ff          ;ec0e  ff ff    
    clb 7,mem_00ff          ;ec10  ff ff    
    clb 7,mem_00ff          ;ec12  ff ff    
    clb 7,mem_00ff          ;ec14  ff ff    
    clb 7,mem_00ff          ;ec16  ff ff    
    clb 7,mem_00ff          ;ec18  ff ff    
    clb 7,mem_00ff          ;ec1a  ff ff    
    clb 7,mem_00ff          ;ec1c  ff ff    
    clb 7,mem_00ff          ;ec1e  ff ff    
    clb 7,mem_00ff          ;ec20  ff ff    
    clb 7,mem_00ff          ;ec22  ff ff    
    clb 7,mem_00ff          ;ec24  ff ff    
    clb 7,mem_00ff          ;ec26  ff ff    
    clb 7,mem_00ff          ;ec28  ff ff    
    clb 7,mem_00ff          ;ec2a  ff ff    
    clb 7,mem_00ff          ;ec2c  ff ff    
    clb 7,mem_00ff          ;ec2e  ff ff    
    clb 7,mem_00ff          ;ec30  ff ff    
    clb 7,mem_00ff          ;ec32  ff ff    
    clb 7,mem_00ff          ;ec34  ff ff    
    clb 7,mem_00ff          ;ec36  ff ff    
    clb 7,mem_00ff          ;ec38  ff ff    
    clb 7,mem_00ff          ;ec3a  ff ff    
    clb 7,mem_00ff          ;ec3c  ff ff    
    clb 7,mem_00ff          ;ec3e  ff ff    
    clb 7,mem_00ff          ;ec40  ff ff    
    clb 7,mem_00ff          ;ec42  ff ff    
    clb 7,mem_00ff          ;ec44  ff ff    
    clb 7,mem_00ff          ;ec46  ff ff    
    clb 7,mem_00ff          ;ec48  ff ff    
    clb 7,mem_00ff          ;ec4a  ff ff    
    clb 7,mem_00ff          ;ec4c  ff ff    
    clb 7,mem_00ff          ;ec4e  ff ff    
    clb 7,mem_00ff          ;ec50  ff ff    
    clb 7,mem_00ff          ;ec52  ff ff    
    clb 7,mem_00ff          ;ec54  ff ff    
    clb 7,mem_00ff          ;ec56  ff ff    
    clb 7,mem_00ff          ;ec58  ff ff    
    clb 7,mem_00ff          ;ec5a  ff ff    
    clb 7,mem_00ff          ;ec5c  ff ff    
    clb 7,mem_00ff          ;ec5e  ff ff    
    clb 7,mem_00ff          ;ec60  ff ff    
    clb 7,mem_00ff          ;ec62  ff ff    
    clb 7,mem_00ff          ;ec64  ff ff    
    clb 7,mem_00ff          ;ec66  ff ff    
    clb 7,mem_00ff          ;ec68  ff ff    
    clb 7,mem_00ff          ;ec6a  ff ff    
    clb 7,mem_00ff          ;ec6c  ff ff    
    clb 7,mem_00ff          ;ec6e  ff ff    
    clb 7,mem_00ff          ;ec70  ff ff    
    clb 7,mem_00ff          ;ec72  ff ff    
    clb 7,mem_00ff          ;ec74  ff ff    
    clb 7,mem_00ff          ;ec76  ff ff    
    clb 7,mem_00ff          ;ec78  ff ff    
    clb 7,mem_00ff          ;ec7a  ff ff    
    clb 7,mem_00ff          ;ec7c  ff ff    
    clb 7,mem_00ff          ;ec7e  ff ff    
    clb 7,mem_00ff          ;ec80  ff ff    
    clb 7,mem_00ff          ;ec82  ff ff    
    clb 7,mem_00ff          ;ec84  ff ff    
    clb 7,mem_00ff          ;ec86  ff ff    
    clb 7,mem_00ff          ;ec88  ff ff    
    clb 7,mem_00ff          ;ec8a  ff ff    
    clb 7,mem_00ff          ;ec8c  ff ff    
    clb 7,mem_00ff          ;ec8e  ff ff    
    clb 7,mem_00ff          ;ec90  ff ff    
    clb 7,mem_00ff          ;ec92  ff ff    
    clb 7,mem_00ff          ;ec94  ff ff    
    clb 7,mem_00ff          ;ec96  ff ff    
    clb 7,mem_00ff          ;ec98  ff ff    
    clb 7,mem_00ff          ;ec9a  ff ff    
    clb 7,mem_00ff          ;ec9c  ff ff    
    clb 7,mem_00ff          ;ec9e  ff ff    
    clb 7,mem_00ff          ;eca0  ff ff    
    clb 7,mem_00ff          ;eca2  ff ff    
    clb 7,mem_00ff          ;eca4  ff ff    
    clb 7,mem_00ff          ;eca6  ff ff    
    clb 7,mem_00ff          ;eca8  ff ff    
    clb 7,mem_00ff          ;ecaa  ff ff    
    clb 7,mem_00ff          ;ecac  ff ff    
    clb 7,mem_00ff          ;ecae  ff ff    
    clb 7,mem_00ff          ;ecb0  ff ff    
    clb 7,mem_00ff          ;ecb2  ff ff    
    clb 7,mem_00ff          ;ecb4  ff ff    
    clb 7,mem_00ff          ;ecb6  ff ff    
    clb 7,mem_00ff          ;ecb8  ff ff    
    clb 7,mem_00ff          ;ecba  ff ff    
    clb 7,mem_00ff          ;ecbc  ff ff    
    clb 7,mem_00ff          ;ecbe  ff ff    
    clb 7,mem_00ff          ;ecc0  ff ff    
    clb 7,mem_00ff          ;ecc2  ff ff    
    clb 7,mem_00ff          ;ecc4  ff ff    
    clb 7,mem_00ff          ;ecc6  ff ff    
    clb 7,mem_00ff          ;ecc8  ff ff    
    clb 7,mem_00ff          ;ecca  ff ff    
    clb 7,mem_00ff          ;eccc  ff ff    
    clb 7,mem_00ff          ;ecce  ff ff    
    clb 7,mem_00ff          ;ecd0  ff ff    
    clb 7,mem_00ff          ;ecd2  ff ff    
    clb 7,mem_00ff          ;ecd4  ff ff    
    clb 7,mem_00ff          ;ecd6  ff ff    
    clb 7,mem_00ff          ;ecd8  ff ff    
    clb 7,mem_00ff          ;ecda  ff ff    
    clb 7,mem_00ff          ;ecdc  ff ff    
    clb 7,mem_00ff          ;ecde  ff ff    
    clb 7,mem_00ff          ;ece0  ff ff    
    clb 7,mem_00ff          ;ece2  ff ff    
    clb 7,mem_00ff          ;ece4  ff ff    
    clb 7,mem_00ff          ;ece6  ff ff    
    clb 7,mem_00ff          ;ece8  ff ff    
    clb 7,mem_00ff          ;ecea  ff ff    
    clb 7,mem_00ff          ;ecec  ff ff    
    clb 7,mem_00ff          ;ecee  ff ff    
    clb 7,mem_00ff          ;ecf0  ff ff    
    clb 7,mem_00ff          ;ecf2  ff ff    
    clb 7,mem_00ff          ;ecf4  ff ff    
    clb 7,mem_00ff          ;ecf6  ff ff    
    clb 7,mem_00ff          ;ecf8  ff ff    
    clb 7,mem_00ff          ;ecfa  ff ff    
    clb 7,mem_00ff          ;ecfc  ff ff    
    clb 7,mem_00ff          ;ecfe  ff ff    
    clb 7,mem_00ff          ;ed00  ff ff    
    clb 7,mem_00ff          ;ed02  ff ff    
    clb 7,mem_00ff          ;ed04  ff ff    
    clb 7,mem_00ff          ;ed06  ff ff    
    clb 7,mem_00ff          ;ed08  ff ff    
    clb 7,mem_00ff          ;ed0a  ff ff    
    clb 7,mem_00ff          ;ed0c  ff ff    
    clb 7,mem_00ff          ;ed0e  ff ff    
    clb 7,mem_00ff          ;ed10  ff ff    
    clb 7,mem_00ff          ;ed12  ff ff    
    clb 7,mem_00ff          ;ed14  ff ff    
    clb 7,mem_00ff          ;ed16  ff ff    
    clb 7,mem_00ff          ;ed18  ff ff    
    clb 7,mem_00ff          ;ed1a  ff ff    
    clb 7,mem_00ff          ;ed1c  ff ff    
    clb 7,mem_00ff          ;ed1e  ff ff    
    clb 7,mem_00ff          ;ed20  ff ff    
    clb 7,mem_00ff          ;ed22  ff ff    
    clb 7,mem_00ff          ;ed24  ff ff    
    clb 7,mem_00ff          ;ed26  ff ff    
    clb 7,mem_00ff          ;ed28  ff ff    
    clb 7,mem_00ff          ;ed2a  ff ff    
    clb 7,mem_00ff          ;ed2c  ff ff    
    clb 7,mem_00ff          ;ed2e  ff ff    
    clb 7,mem_00ff          ;ed30  ff ff    
    clb 7,mem_00ff          ;ed32  ff ff    
    clb 7,mem_00ff          ;ed34  ff ff    
    clb 7,mem_00ff          ;ed36  ff ff    
    clb 7,mem_00ff          ;ed38  ff ff    
    clb 7,mem_00ff          ;ed3a  ff ff    
    clb 7,mem_00ff          ;ed3c  ff ff    
    clb 7,mem_00ff          ;ed3e  ff ff    
    clb 7,mem_00ff          ;ed40  ff ff    
    clb 7,mem_00ff          ;ed42  ff ff    
    clb 7,mem_00ff          ;ed44  ff ff    
    clb 7,mem_00ff          ;ed46  ff ff    
    clb 7,mem_00ff          ;ed48  ff ff    
    clb 7,mem_00ff          ;ed4a  ff ff    
    clb 7,mem_00ff          ;ed4c  ff ff    
    clb 7,mem_00ff          ;ed4e  ff ff    
    clb 7,mem_00ff          ;ed50  ff ff    
    clb 7,mem_00ff          ;ed52  ff ff    
    clb 7,mem_00ff          ;ed54  ff ff    
    clb 7,mem_00ff          ;ed56  ff ff    
    clb 7,mem_00ff          ;ed58  ff ff    
    clb 7,mem_00ff          ;ed5a  ff ff    
    clb 7,mem_00ff          ;ed5c  ff ff    
    clb 7,mem_00ff          ;ed5e  ff ff    
    clb 7,mem_00ff          ;ed60  ff ff    
    clb 7,mem_00ff          ;ed62  ff ff    
    clb 7,mem_00ff          ;ed64  ff ff    
    clb 7,mem_00ff          ;ed66  ff ff    
    clb 7,mem_00ff          ;ed68  ff ff    
    clb 7,mem_00ff          ;ed6a  ff ff    
    clb 7,mem_00ff          ;ed6c  ff ff    
    clb 7,mem_00ff          ;ed6e  ff ff    
    clb 7,mem_00ff          ;ed70  ff ff    
    clb 7,mem_00ff          ;ed72  ff ff    
    clb 7,mem_00ff          ;ed74  ff ff    
    clb 7,mem_00ff          ;ed76  ff ff    
    clb 7,mem_00ff          ;ed78  ff ff    
    clb 7,mem_00ff          ;ed7a  ff ff    
    clb 7,mem_00ff          ;ed7c  ff ff    
    clb 7,mem_00ff          ;ed7e  ff ff    
    clb 7,mem_00ff          ;ed80  ff ff    
    clb 7,mem_00ff          ;ed82  ff ff    
    clb 7,mem_00ff          ;ed84  ff ff    
    clb 7,mem_00ff          ;ed86  ff ff    
    clb 7,mem_00ff          ;ed88  ff ff    
    clb 7,mem_00ff          ;ed8a  ff ff    
    clb 7,mem_00ff          ;ed8c  ff ff    
    clb 7,mem_00ff          ;ed8e  ff ff    
    clb 7,mem_00ff          ;ed90  ff ff    
    clb 7,mem_00ff          ;ed92  ff ff    
    clb 7,mem_00ff          ;ed94  ff ff    
    clb 7,mem_00ff          ;ed96  ff ff    
    clb 7,mem_00ff          ;ed98  ff ff    
    clb 7,mem_00ff          ;ed9a  ff ff    
    clb 7,mem_00ff          ;ed9c  ff ff    
    clb 7,mem_00ff          ;ed9e  ff ff    
    clb 7,mem_00ff          ;eda0  ff ff    
    clb 7,mem_00ff          ;eda2  ff ff    
    clb 7,mem_00ff          ;eda4  ff ff    
    clb 7,mem_00ff          ;eda6  ff ff    
    clb 7,mem_00ff          ;eda8  ff ff    
    clb 7,mem_00ff          ;edaa  ff ff    
    clb 7,mem_00ff          ;edac  ff ff    
    clb 7,mem_00ff          ;edae  ff ff    
    clb 7,mem_00ff          ;edb0  ff ff    
    clb 7,mem_00ff          ;edb2  ff ff    
    clb 7,mem_00ff          ;edb4  ff ff    
    clb 7,mem_00ff          ;edb6  ff ff    
    clb 7,mem_00ff          ;edb8  ff ff    
    clb 7,mem_00ff          ;edba  ff ff    
    clb 7,mem_00ff          ;edbc  ff ff    
    clb 7,mem_00ff          ;edbe  ff ff    
    clb 7,mem_00ff          ;edc0  ff ff    
    clb 7,mem_00ff          ;edc2  ff ff    
    clb 7,mem_00ff          ;edc4  ff ff    
    clb 7,mem_00ff          ;edc6  ff ff    
    clb 7,mem_00ff          ;edc8  ff ff    
    clb 7,mem_00ff          ;edca  ff ff    
    clb 7,mem_00ff          ;edcc  ff ff    
    clb 7,mem_00ff          ;edce  ff ff    
    clb 7,mem_00ff          ;edd0  ff ff    
    clb 7,mem_00ff          ;edd2  ff ff    
    clb 7,mem_00ff          ;edd4  ff ff    
    clb 7,mem_00ff          ;edd6  ff ff    
    clb 7,mem_00ff          ;edd8  ff ff    
    clb 7,mem_00ff          ;edda  ff ff    
    clb 7,mem_00ff          ;eddc  ff ff    
    clb 7,mem_00ff          ;edde  ff ff    
    clb 7,mem_00ff          ;ede0  ff ff    
    clb 7,mem_00ff          ;ede2  ff ff    
    clb 7,mem_00ff          ;ede4  ff ff    
    clb 7,mem_00ff          ;ede6  ff ff    
    clb 7,mem_00ff          ;ede8  ff ff    
    clb 7,mem_00ff          ;edea  ff ff    
    clb 7,mem_00ff          ;edec  ff ff    
    clb 7,mem_00ff          ;edee  ff ff    
    clb 7,mem_00ff          ;edf0  ff ff    
    clb 7,mem_00ff          ;edf2  ff ff    
    clb 7,mem_00ff          ;edf4  ff ff    
    clb 7,mem_00ff          ;edf6  ff ff    
    clb 7,mem_00ff          ;edf8  ff ff    
    clb 7,mem_00ff          ;edfa  ff ff    
    clb 7,mem_00ff          ;edfc  ff ff    
    clb 7,mem_00ff          ;edfe  ff ff    
    clb 7,mem_00ff          ;ee00  ff ff    
    clb 7,mem_00ff          ;ee02  ff ff    
    clb 7,mem_00ff          ;ee04  ff ff    
    clb 7,mem_00ff          ;ee06  ff ff    
    clb 7,mem_00ff          ;ee08  ff ff    
    clb 7,mem_00ff          ;ee0a  ff ff    
    clb 7,mem_00ff          ;ee0c  ff ff    
    clb 7,mem_00ff          ;ee0e  ff ff    
    clb 7,mem_00ff          ;ee10  ff ff    
    clb 7,mem_00ff          ;ee12  ff ff    
    clb 7,mem_00ff          ;ee14  ff ff    
    clb 7,mem_00ff          ;ee16  ff ff    
    clb 7,mem_00ff          ;ee18  ff ff    
    clb 7,mem_00ff          ;ee1a  ff ff    
    clb 7,mem_00ff          ;ee1c  ff ff    
    clb 7,mem_00ff          ;ee1e  ff ff    
    clb 7,mem_00ff          ;ee20  ff ff    
    clb 7,mem_00ff          ;ee22  ff ff    
    clb 7,mem_00ff          ;ee24  ff ff    
    clb 7,mem_00ff          ;ee26  ff ff    
    clb 7,mem_00ff          ;ee28  ff ff    
    clb 7,mem_00ff          ;ee2a  ff ff    
    clb 7,mem_00ff          ;ee2c  ff ff    
    clb 7,mem_00ff          ;ee2e  ff ff    
    clb 7,mem_00ff          ;ee30  ff ff    
    clb 7,mem_00ff          ;ee32  ff ff    
    clb 7,mem_00ff          ;ee34  ff ff    
    clb 7,mem_00ff          ;ee36  ff ff    
    clb 7,mem_00ff          ;ee38  ff ff    
    clb 7,mem_00ff          ;ee3a  ff ff    
    clb 7,mem_00ff          ;ee3c  ff ff    
    clb 7,mem_00ff          ;ee3e  ff ff    
    clb 7,mem_00ff          ;ee40  ff ff    
    clb 7,mem_00ff          ;ee42  ff ff    
    clb 7,mem_00ff          ;ee44  ff ff    
    clb 7,mem_00ff          ;ee46  ff ff    
    clb 7,mem_00ff          ;ee48  ff ff    
    clb 7,mem_00ff          ;ee4a  ff ff    
    clb 7,mem_00ff          ;ee4c  ff ff    
    clb 7,mem_00ff          ;ee4e  ff ff    
    clb 7,mem_00ff          ;ee50  ff ff    
    clb 7,mem_00ff          ;ee52  ff ff    
    clb 7,mem_00ff          ;ee54  ff ff    
    clb 7,mem_00ff          ;ee56  ff ff    
    clb 7,mem_00ff          ;ee58  ff ff    
    clb 7,mem_00ff          ;ee5a  ff ff    
    clb 7,mem_00ff          ;ee5c  ff ff    
    clb 7,mem_00ff          ;ee5e  ff ff    
    clb 7,mem_00ff          ;ee60  ff ff    
    clb 7,mem_00ff          ;ee62  ff ff    
    clb 7,mem_00ff          ;ee64  ff ff    
    clb 7,mem_00ff          ;ee66  ff ff    
    clb 7,mem_00ff          ;ee68  ff ff    
    clb 7,mem_00ff          ;ee6a  ff ff    
    clb 7,mem_00ff          ;ee6c  ff ff    
    clb 7,mem_00ff          ;ee6e  ff ff    
    clb 7,mem_00ff          ;ee70  ff ff    
    clb 7,mem_00ff          ;ee72  ff ff    
    clb 7,mem_00ff          ;ee74  ff ff    
    clb 7,mem_00ff          ;ee76  ff ff    
    clb 7,mem_00ff          ;ee78  ff ff    
    clb 7,mem_00ff          ;ee7a  ff ff    
    clb 7,mem_00ff          ;ee7c  ff ff    
    clb 7,mem_00ff          ;ee7e  ff ff    
    clb 7,mem_00ff          ;ee80  ff ff    
    clb 7,mem_00ff          ;ee82  ff ff    
    clb 7,mem_00ff          ;ee84  ff ff    
    clb 7,mem_00ff          ;ee86  ff ff    
    clb 7,mem_00ff          ;ee88  ff ff    
    clb 7,mem_00ff          ;ee8a  ff ff    
    clb 7,mem_00ff          ;ee8c  ff ff    
    clb 7,mem_00ff          ;ee8e  ff ff    
    clb 7,mem_00ff          ;ee90  ff ff    
    clb 7,mem_00ff          ;ee92  ff ff    
    clb 7,mem_00ff          ;ee94  ff ff    
    clb 7,mem_00ff          ;ee96  ff ff    
    clb 7,mem_00ff          ;ee98  ff ff    
    clb 7,mem_00ff          ;ee9a  ff ff    
    clb 7,mem_00ff          ;ee9c  ff ff    
    clb 7,mem_00ff          ;ee9e  ff ff    
    clb 7,mem_00ff          ;eea0  ff ff    
    clb 7,mem_00ff          ;eea2  ff ff    
    clb 7,mem_00ff          ;eea4  ff ff    
    clb 7,mem_00ff          ;eea6  ff ff    
    clb 7,mem_00ff          ;eea8  ff ff    
    clb 7,mem_00ff          ;eeaa  ff ff    
    clb 7,mem_00ff          ;eeac  ff ff    
    clb 7,mem_00ff          ;eeae  ff ff    
    clb 7,mem_00ff          ;eeb0  ff ff    
    clb 7,mem_00ff          ;eeb2  ff ff    
    clb 7,mem_00ff          ;eeb4  ff ff    
    clb 7,mem_00ff          ;eeb6  ff ff    
    clb 7,mem_00ff          ;eeb8  ff ff    
    clb 7,mem_00ff          ;eeba  ff ff    
    clb 7,mem_00ff          ;eebc  ff ff    
    clb 7,mem_00ff          ;eebe  ff ff    
    clb 7,mem_00ff          ;eec0  ff ff    
    clb 7,mem_00ff          ;eec2  ff ff    
    clb 7,mem_00ff          ;eec4  ff ff    
    clb 7,mem_00ff          ;eec6  ff ff    
    clb 7,mem_00ff          ;eec8  ff ff    
    clb 7,mem_00ff          ;eeca  ff ff    
    clb 7,mem_00ff          ;eecc  ff ff    
    clb 7,mem_00ff          ;eece  ff ff    
    clb 7,mem_00ff          ;eed0  ff ff    
    clb 7,mem_00ff          ;eed2  ff ff    
    clb 7,mem_00ff          ;eed4  ff ff    
    clb 7,mem_00ff          ;eed6  ff ff    
    clb 7,mem_00ff          ;eed8  ff ff    
    clb 7,mem_00ff          ;eeda  ff ff    
    clb 7,mem_00ff          ;eedc  ff ff    
    clb 7,mem_00ff          ;eede  ff ff    
    clb 7,mem_00ff          ;eee0  ff ff    
    clb 7,mem_00ff          ;eee2  ff ff    
    clb 7,mem_00ff          ;eee4  ff ff    
    clb 7,mem_00ff          ;eee6  ff ff    
    clb 7,mem_00ff          ;eee8  ff ff    
    clb 7,mem_00ff          ;eeea  ff ff    
    clb 7,mem_00ff          ;eeec  ff ff    
    clb 7,mem_00ff          ;eeee  ff ff    
    clb 7,mem_00ff          ;eef0  ff ff    
    clb 7,mem_00ff          ;eef2  ff ff    
    clb 7,mem_00ff          ;eef4  ff ff    
    clb 7,mem_00ff          ;eef6  ff ff    
    clb 7,mem_00ff          ;eef8  ff ff    
    clb 7,mem_00ff          ;eefa  ff ff    
    clb 7,mem_00ff          ;eefc  ff ff    
    clb 7,mem_00ff          ;eefe  ff ff    
    clb 7,mem_00ff          ;ef00  ff ff    
    clb 7,mem_00ff          ;ef02  ff ff    
    clb 7,mem_00ff          ;ef04  ff ff    
    clb 7,mem_00ff          ;ef06  ff ff    
    clb 7,mem_00ff          ;ef08  ff ff    
    clb 7,mem_00ff          ;ef0a  ff ff    
    clb 7,mem_00ff          ;ef0c  ff ff    
    clb 7,mem_00ff          ;ef0e  ff ff    
    clb 7,mem_00ff          ;ef10  ff ff    
    clb 7,mem_00ff          ;ef12  ff ff    
    clb 7,mem_00ff          ;ef14  ff ff    
    clb 7,mem_00ff          ;ef16  ff ff    
    clb 7,mem_00ff          ;ef18  ff ff    
    clb 7,mem_00ff          ;ef1a  ff ff    
    clb 7,mem_00ff          ;ef1c  ff ff    
    clb 7,mem_00ff          ;ef1e  ff ff    
    clb 7,mem_00ff          ;ef20  ff ff    
    clb 7,mem_00ff          ;ef22  ff ff    
    clb 7,mem_00ff          ;ef24  ff ff    
    clb 7,mem_00ff          ;ef26  ff ff    
    clb 7,mem_00ff          ;ef28  ff ff    
    clb 7,mem_00ff          ;ef2a  ff ff    
    clb 7,mem_00ff          ;ef2c  ff ff    
    clb 7,mem_00ff          ;ef2e  ff ff    
    clb 7,mem_00ff          ;ef30  ff ff    
    clb 7,mem_00ff          ;ef32  ff ff    
    clb 7,mem_00ff          ;ef34  ff ff    
    clb 7,mem_00ff          ;ef36  ff ff    
    clb 7,mem_00ff          ;ef38  ff ff    
    clb 7,mem_00ff          ;ef3a  ff ff    
    clb 7,mem_00ff          ;ef3c  ff ff    
    clb 7,mem_00ff          ;ef3e  ff ff    
    clb 7,mem_00ff          ;ef40  ff ff    
    clb 7,mem_00ff          ;ef42  ff ff    
    clb 7,mem_00ff          ;ef44  ff ff    
    clb 7,mem_00ff          ;ef46  ff ff    
    clb 7,mem_00ff          ;ef48  ff ff    
    clb 7,mem_00ff          ;ef4a  ff ff    
    clb 7,mem_00ff          ;ef4c  ff ff    
    clb 7,mem_00ff          ;ef4e  ff ff    
    clb 7,mem_00ff          ;ef50  ff ff    
    clb 7,mem_00ff          ;ef52  ff ff    
    clb 7,mem_00ff          ;ef54  ff ff    
    clb 7,mem_00ff          ;ef56  ff ff    
    clb 7,mem_00ff          ;ef58  ff ff    
    clb 7,mem_00ff          ;ef5a  ff ff    
    clb 7,mem_00ff          ;ef5c  ff ff    
    clb 7,mem_00ff          ;ef5e  ff ff    
    clb 7,mem_00ff          ;ef60  ff ff    
    clb 7,mem_00ff          ;ef62  ff ff    
    clb 7,mem_00ff          ;ef64  ff ff    
    clb 7,mem_00ff          ;ef66  ff ff    
    clb 7,mem_00ff          ;ef68  ff ff    
    clb 7,mem_00ff          ;ef6a  ff ff    
    clb 7,mem_00ff          ;ef6c  ff ff    
    clb 7,mem_00ff          ;ef6e  ff ff    
    clb 7,mem_00ff          ;ef70  ff ff    
    clb 7,mem_00ff          ;ef72  ff ff    
    clb 7,mem_00ff          ;ef74  ff ff    
    clb 7,mem_00ff          ;ef76  ff ff    
    clb 7,mem_00ff          ;ef78  ff ff    
    clb 7,mem_00ff          ;ef7a  ff ff    
    clb 7,mem_00ff          ;ef7c  ff ff    
    clb 7,mem_00ff          ;ef7e  ff ff    
    clb 7,mem_00ff          ;ef80  ff ff    
    clb 7,mem_00ff          ;ef82  ff ff    
    clb 7,mem_00ff          ;ef84  ff ff    
    clb 7,mem_00ff          ;ef86  ff ff    
    clb 7,mem_00ff          ;ef88  ff ff    
    clb 7,mem_00ff          ;ef8a  ff ff    
    clb 7,mem_00ff          ;ef8c  ff ff    
    clb 7,mem_00ff          ;ef8e  ff ff    
    clb 7,mem_00ff          ;ef90  ff ff    
    clb 7,mem_00ff          ;ef92  ff ff    
    clb 7,mem_00ff          ;ef94  ff ff    
    clb 7,mem_00ff          ;ef96  ff ff    
    clb 7,mem_00ff          ;ef98  ff ff    
    clb 7,mem_00ff          ;ef9a  ff ff    
    clb 7,mem_00ff          ;ef9c  ff ff    
    clb 7,mem_00ff          ;ef9e  ff ff    
    clb 7,mem_00ff          ;efa0  ff ff    
    clb 7,mem_00ff          ;efa2  ff ff    
    clb 7,mem_00ff          ;efa4  ff ff    
    clb 7,mem_00ff          ;efa6  ff ff    
    clb 7,mem_00ff          ;efa8  ff ff    
    clb 7,mem_00ff          ;efaa  ff ff    
    clb 7,mem_00ff          ;efac  ff ff    
    clb 7,mem_00ff          ;efae  ff ff    
    clb 7,mem_00ff          ;efb0  ff ff    
    clb 7,mem_00ff          ;efb2  ff ff    
    clb 7,mem_00ff          ;efb4  ff ff    
    clb 7,mem_00ff          ;efb6  ff ff    
    clb 7,mem_00ff          ;efb8  ff ff    
    clb 7,mem_00ff          ;efba  ff ff    
    clb 7,mem_00ff          ;efbc  ff ff    
    clb 7,mem_00ff          ;efbe  ff ff    
    clb 7,mem_00ff          ;efc0  ff ff    
    clb 7,mem_00ff          ;efc2  ff ff    
    clb 7,mem_00ff          ;efc4  ff ff    
    clb 7,mem_00ff          ;efc6  ff ff    
    clb 7,mem_00ff          ;efc8  ff ff    
    clb 7,mem_00ff          ;efca  ff ff    
    clb 7,mem_00ff          ;efcc  ff ff    
    clb 7,mem_00ff          ;efce  ff ff    
    clb 7,mem_00ff          ;efd0  ff ff    
    clb 7,mem_00ff          ;efd2  ff ff    
    clb 7,mem_00ff          ;efd4  ff ff    
    clb 7,mem_00ff          ;efd6  ff ff    
    clb 7,mem_00ff          ;efd8  ff ff    
    clb 7,mem_00ff          ;efda  ff ff    
    clb 7,mem_00ff          ;efdc  ff ff    
    clb 7,mem_00ff          ;efde  ff ff    
    clb 7,mem_00ff          ;efe0  ff ff    
    clb 7,mem_00ff          ;efe2  ff ff    
    clb 7,mem_00ff          ;efe4  ff ff    
    clb 7,mem_00ff          ;efe6  ff ff    
    clb 7,mem_00ff          ;efe8  ff ff    
    clb 7,mem_00ff          ;efea  ff ff    
    clb 7,mem_00ff          ;efec  ff ff    
    clb 7,mem_00ff          ;efee  ff ff    
    clb 7,mem_00ff          ;eff0  ff ff    
    clb 7,mem_00ff          ;eff2  ff ff    
    clb 7,mem_00ff          ;eff4  ff ff    
    clb 7,mem_00ff          ;eff6  ff ff    
    clb 7,mem_00ff          ;eff8  ff ff    
    clb 7,mem_00ff          ;effa  ff ff    
    clb 7,mem_00ff          ;effc  ff ff    
    clb 7,mem_00ff          ;effe  ff ff    
    clb 7,mem_00ff          ;f000  ff ff    
    clb 7,mem_00ff          ;f002  ff ff    
    clb 7,mem_00ff          ;f004  ff ff    
    clb 7,mem_00ff          ;f006  ff ff    
    clb 7,mem_00ff          ;f008  ff ff    
    clb 7,mem_00ff          ;f00a  ff ff    
    clb 7,mem_00ff          ;f00c  ff ff    
    clb 7,mem_00ff          ;f00e  ff ff    
    clb 7,mem_00ff          ;f010  ff ff    
    clb 7,mem_00ff          ;f012  ff ff    
    clb 7,mem_00ff          ;f014  ff ff    
    clb 7,mem_00ff          ;f016  ff ff    
    clb 7,mem_00ff          ;f018  ff ff    
    clb 7,mem_00ff          ;f01a  ff ff    
    clb 7,mem_00ff          ;f01c  ff ff    
    clb 7,mem_00ff          ;f01e  ff ff    
    clb 7,mem_00ff          ;f020  ff ff    
    clb 7,mem_00ff          ;f022  ff ff    
    clb 7,mem_00ff          ;f024  ff ff    
    clb 7,mem_00ff          ;f026  ff ff    
    clb 7,mem_00ff          ;f028  ff ff    
    clb 7,mem_00ff          ;f02a  ff ff    
    clb 7,mem_00ff          ;f02c  ff ff    
    clb 7,mem_00ff          ;f02e  ff ff    
    clb 7,mem_00ff          ;f030  ff ff    
    clb 7,mem_00ff          ;f032  ff ff    
    clb 7,mem_00ff          ;f034  ff ff    
    clb 7,mem_00ff          ;f036  ff ff    
    clb 7,mem_00ff          ;f038  ff ff    
    clb 7,mem_00ff          ;f03a  ff ff    
    clb 7,mem_00ff          ;f03c  ff ff    
    clb 7,mem_00ff          ;f03e  ff ff    
    clb 7,mem_00ff          ;f040  ff ff    
    clb 7,mem_00ff          ;f042  ff ff    
    clb 7,mem_00ff          ;f044  ff ff    
    clb 7,mem_00ff          ;f046  ff ff    
    clb 7,mem_00ff          ;f048  ff ff    
    clb 7,mem_00ff          ;f04a  ff ff    
    clb 7,mem_00ff          ;f04c  ff ff    
    clb 7,mem_00ff          ;f04e  ff ff    
    clb 7,mem_00ff          ;f050  ff ff    
    clb 7,mem_00ff          ;f052  ff ff    
    clb 7,mem_00ff          ;f054  ff ff    
    clb 7,mem_00ff          ;f056  ff ff    
    clb 7,mem_00ff          ;f058  ff ff    
    clb 7,mem_00ff          ;f05a  ff ff    
    clb 7,mem_00ff          ;f05c  ff ff    
    clb 7,mem_00ff          ;f05e  ff ff    
    clb 7,mem_00ff          ;f060  ff ff    
    clb 7,mem_00ff          ;f062  ff ff    
    clb 7,mem_00ff          ;f064  ff ff    
    clb 7,mem_00ff          ;f066  ff ff    
    clb 7,mem_00ff          ;f068  ff ff    
    clb 7,mem_00ff          ;f06a  ff ff    
    clb 7,mem_00ff          ;f06c  ff ff    
    clb 7,mem_00ff          ;f06e  ff ff    
    clb 7,mem_00ff          ;f070  ff ff    
    clb 7,mem_00ff          ;f072  ff ff    
    clb 7,mem_00ff          ;f074  ff ff    
    clb 7,mem_00ff          ;f076  ff ff    
    clb 7,mem_00ff          ;f078  ff ff    
    clb 7,mem_00ff          ;f07a  ff ff    
    clb 7,mem_00ff          ;f07c  ff ff    
    clb 7,mem_00ff          ;f07e  ff ff    
    clb 7,mem_00ff          ;f080  ff ff    
    clb 7,mem_00ff          ;f082  ff ff    
    clb 7,mem_00ff          ;f084  ff ff    
    clb 7,mem_00ff          ;f086  ff ff    
    clb 7,mem_00ff          ;f088  ff ff    
    clb 7,mem_00ff          ;f08a  ff ff    
    clb 7,mem_00ff          ;f08c  ff ff    
    clb 7,mem_00ff          ;f08e  ff ff    
    clb 7,mem_00ff          ;f090  ff ff    
    clb 7,mem_00ff          ;f092  ff ff    
    clb 7,mem_00ff          ;f094  ff ff    
    clb 7,mem_00ff          ;f096  ff ff    
    clb 7,mem_00ff          ;f098  ff ff    
    clb 7,mem_00ff          ;f09a  ff ff    
    clb 7,mem_00ff          ;f09c  ff ff    
    clb 7,mem_00ff          ;f09e  ff ff    
    clb 7,mem_00ff          ;f0a0  ff ff    
    clb 7,mem_00ff          ;f0a2  ff ff    
    clb 7,mem_00ff          ;f0a4  ff ff    
    clb 7,mem_00ff          ;f0a6  ff ff    
    clb 7,mem_00ff          ;f0a8  ff ff    
    clb 7,mem_00ff          ;f0aa  ff ff    
    clb 7,mem_00ff          ;f0ac  ff ff    
    clb 7,mem_00ff          ;f0ae  ff ff    
    clb 7,mem_00ff          ;f0b0  ff ff    
    clb 7,mem_00ff          ;f0b2  ff ff    
    clb 7,mem_00ff          ;f0b4  ff ff    
    clb 7,mem_00ff          ;f0b6  ff ff    
    clb 7,mem_00ff          ;f0b8  ff ff    
    clb 7,mem_00ff          ;f0ba  ff ff    
    clb 7,mem_00ff          ;f0bc  ff ff    
    clb 7,mem_00ff          ;f0be  ff ff    
    clb 7,mem_00ff          ;f0c0  ff ff    
    clb 7,mem_00ff          ;f0c2  ff ff    
    clb 7,mem_00ff          ;f0c4  ff ff    
    clb 7,mem_00ff          ;f0c6  ff ff    
    clb 7,mem_00ff          ;f0c8  ff ff    
    clb 7,mem_00ff          ;f0ca  ff ff    
    clb 7,mem_00ff          ;f0cc  ff ff    
    clb 7,mem_00ff          ;f0ce  ff ff    
    clb 7,mem_00ff          ;f0d0  ff ff    
    clb 7,mem_00ff          ;f0d2  ff ff    
    clb 7,mem_00ff          ;f0d4  ff ff    
    clb 7,mem_00ff          ;f0d6  ff ff    
    clb 7,mem_00ff          ;f0d8  ff ff    
    clb 7,mem_00ff          ;f0da  ff ff    
    clb 7,mem_00ff          ;f0dc  ff ff    
    clb 7,mem_00ff          ;f0de  ff ff    
    clb 7,mem_00ff          ;f0e0  ff ff    
    clb 7,mem_00ff          ;f0e2  ff ff    
    clb 7,mem_00ff          ;f0e4  ff ff    
    clb 7,mem_00ff          ;f0e6  ff ff    
    clb 7,mem_00ff          ;f0e8  ff ff    
    clb 7,mem_00ff          ;f0ea  ff ff    
    clb 7,mem_00ff          ;f0ec  ff ff    
    clb 7,mem_00ff          ;f0ee  ff ff    
    clb 7,mem_00ff          ;f0f0  ff ff    
    clb 7,mem_00ff          ;f0f2  ff ff    
    clb 7,mem_00ff          ;f0f4  ff ff    
    clb 7,mem_00ff          ;f0f6  ff ff    
    clb 7,mem_00ff          ;f0f8  ff ff    
    clb 7,mem_00ff          ;f0fa  ff ff    
    clb 7,mem_00ff          ;f0fc  ff ff    
    clb 7,mem_00ff          ;f0fe  ff ff    
    clb 7,mem_00ff          ;f100  ff ff    
    clb 7,mem_00ff          ;f102  ff ff    
    clb 7,mem_00ff          ;f104  ff ff    
    clb 7,mem_00ff          ;f106  ff ff    
    clb 7,mem_00ff          ;f108  ff ff    
    clb 7,mem_00ff          ;f10a  ff ff    
    clb 7,mem_00ff          ;f10c  ff ff    
    clb 7,mem_00ff          ;f10e  ff ff    
    clb 7,mem_00ff          ;f110  ff ff    
    clb 7,mem_00ff          ;f112  ff ff    
    clb 7,mem_00ff          ;f114  ff ff    
    clb 7,mem_00ff          ;f116  ff ff    
    clb 7,mem_00ff          ;f118  ff ff    
    clb 7,mem_00ff          ;f11a  ff ff    
    clb 7,mem_00ff          ;f11c  ff ff    
    clb 7,mem_00ff          ;f11e  ff ff    
    clb 7,mem_00ff          ;f120  ff ff    
    clb 7,mem_00ff          ;f122  ff ff    
    clb 7,mem_00ff          ;f124  ff ff    
    clb 7,mem_00ff          ;f126  ff ff    
    clb 7,mem_00ff          ;f128  ff ff    
    clb 7,mem_00ff          ;f12a  ff ff    
    clb 7,mem_00ff          ;f12c  ff ff    
    clb 7,mem_00ff          ;f12e  ff ff    
    clb 7,mem_00ff          ;f130  ff ff    
    clb 7,mem_00ff          ;f132  ff ff    
    clb 7,mem_00ff          ;f134  ff ff    
    clb 7,mem_00ff          ;f136  ff ff    
    clb 7,mem_00ff          ;f138  ff ff    
    clb 7,mem_00ff          ;f13a  ff ff    
    clb 7,mem_00ff          ;f13c  ff ff    
    clb 7,mem_00ff          ;f13e  ff ff    
    clb 7,mem_00ff          ;f140  ff ff    
    clb 7,mem_00ff          ;f142  ff ff    
    clb 7,mem_00ff          ;f144  ff ff    
    clb 7,mem_00ff          ;f146  ff ff    
    clb 7,mem_00ff          ;f148  ff ff    
    clb 7,mem_00ff          ;f14a  ff ff    
    clb 7,mem_00ff          ;f14c  ff ff    
    clb 7,mem_00ff          ;f14e  ff ff    
    clb 7,mem_00ff          ;f150  ff ff    
    clb 7,mem_00ff          ;f152  ff ff    
    clb 7,mem_00ff          ;f154  ff ff    
    clb 7,mem_00ff          ;f156  ff ff    
    clb 7,mem_00ff          ;f158  ff ff    
    clb 7,mem_00ff          ;f15a  ff ff    
    clb 7,mem_00ff          ;f15c  ff ff    
    clb 7,mem_00ff          ;f15e  ff ff    
    clb 7,mem_00ff          ;f160  ff ff    
    clb 7,mem_00ff          ;f162  ff ff    
    clb 7,mem_00ff          ;f164  ff ff    
    clb 7,mem_00ff          ;f166  ff ff    
    clb 7,mem_00ff          ;f168  ff ff    
    clb 7,mem_00ff          ;f16a  ff ff    
    clb 7,mem_00ff          ;f16c  ff ff    
    clb 7,mem_00ff          ;f16e  ff ff    
    clb 7,mem_00ff          ;f170  ff ff    
    clb 7,mem_00ff          ;f172  ff ff    
    clb 7,mem_00ff          ;f174  ff ff    
    clb 7,mem_00ff          ;f176  ff ff    
    clb 7,mem_00ff          ;f178  ff ff    
    clb 7,mem_00ff          ;f17a  ff ff    
    clb 7,mem_00ff          ;f17c  ff ff    
    clb 7,mem_00ff          ;f17e  ff ff    
    clb 7,mem_00ff          ;f180  ff ff    
    clb 7,mem_00ff          ;f182  ff ff    
    clb 7,mem_00ff          ;f184  ff ff    
    clb 7,mem_00ff          ;f186  ff ff    
    clb 7,mem_00ff          ;f188  ff ff    
    clb 7,mem_00ff          ;f18a  ff ff    
    clb 7,mem_00ff          ;f18c  ff ff    
    clb 7,mem_00ff          ;f18e  ff ff    
    clb 7,mem_00ff          ;f190  ff ff    
    clb 7,mem_00ff          ;f192  ff ff    
    clb 7,mem_00ff          ;f194  ff ff    
    clb 7,mem_00ff          ;f196  ff ff    
    clb 7,mem_00ff          ;f198  ff ff    
    clb 7,mem_00ff          ;f19a  ff ff    
    clb 7,mem_00ff          ;f19c  ff ff    
    clb 7,mem_00ff          ;f19e  ff ff    
    clb 7,mem_00ff          ;f1a0  ff ff    
    clb 7,mem_00ff          ;f1a2  ff ff    
    clb 7,mem_00ff          ;f1a4  ff ff    
    clb 7,mem_00ff          ;f1a6  ff ff    
    clb 7,mem_00ff          ;f1a8  ff ff    
    clb 7,mem_00ff          ;f1aa  ff ff    
    clb 7,mem_00ff          ;f1ac  ff ff    
    clb 7,mem_00ff          ;f1ae  ff ff    
    clb 7,mem_00ff          ;f1b0  ff ff    
    clb 7,mem_00ff          ;f1b2  ff ff    
    clb 7,mem_00ff          ;f1b4  ff ff    
    clb 7,mem_00ff          ;f1b6  ff ff    
    clb 7,mem_00ff          ;f1b8  ff ff    
    clb 7,mem_00ff          ;f1ba  ff ff    
    clb 7,mem_00ff          ;f1bc  ff ff    
    clb 7,mem_00ff          ;f1be  ff ff    
    clb 7,mem_00ff          ;f1c0  ff ff    
    clb 7,mem_00ff          ;f1c2  ff ff    
    clb 7,mem_00ff          ;f1c4  ff ff    
    clb 7,mem_00ff          ;f1c6  ff ff    
    clb 7,mem_00ff          ;f1c8  ff ff    
    clb 7,mem_00ff          ;f1ca  ff ff    
    clb 7,mem_00ff          ;f1cc  ff ff    
    clb 7,mem_00ff          ;f1ce  ff ff    
    clb 7,mem_00ff          ;f1d0  ff ff    
    clb 7,mem_00ff          ;f1d2  ff ff    
    clb 7,mem_00ff          ;f1d4  ff ff    
    clb 7,mem_00ff          ;f1d6  ff ff    
    clb 7,mem_00ff          ;f1d8  ff ff    
    clb 7,mem_00ff          ;f1da  ff ff    
    clb 7,mem_00ff          ;f1dc  ff ff    
    clb 7,mem_00ff          ;f1de  ff ff    
    clb 7,mem_00ff          ;f1e0  ff ff    
    clb 7,mem_00ff          ;f1e2  ff ff    
    clb 7,mem_00ff          ;f1e4  ff ff    
    clb 7,mem_00ff          ;f1e6  ff ff    
    clb 7,mem_00ff          ;f1e8  ff ff    
    clb 7,mem_00ff          ;f1ea  ff ff    
    clb 7,mem_00ff          ;f1ec  ff ff    
    clb 7,mem_00ff          ;f1ee  ff ff    
    clb 7,mem_00ff          ;f1f0  ff ff    
    clb 7,mem_00ff          ;f1f2  ff ff    
    clb 7,mem_00ff          ;f1f4  ff ff    
    clb 7,mem_00ff          ;f1f6  ff ff    
    clb 7,mem_00ff          ;f1f8  ff ff    
    clb 7,mem_00ff          ;f1fa  ff ff    
    clb 7,mem_00ff          ;f1fc  ff ff    
    clb 7,mem_00ff          ;f1fe  ff ff    
    clb 7,mem_00ff          ;f200  ff ff    
    clb 7,mem_00ff          ;f202  ff ff    
    clb 7,mem_00ff          ;f204  ff ff    
    clb 7,mem_00ff          ;f206  ff ff    
    clb 7,mem_00ff          ;f208  ff ff    
    clb 7,mem_00ff          ;f20a  ff ff    
    clb 7,mem_00ff          ;f20c  ff ff    
    clb 7,mem_00ff          ;f20e  ff ff    
    clb 7,mem_00ff          ;f210  ff ff    
    clb 7,mem_00ff          ;f212  ff ff    
    clb 7,mem_00ff          ;f214  ff ff    
    clb 7,mem_00ff          ;f216  ff ff    
    clb 7,mem_00ff          ;f218  ff ff    
    clb 7,mem_00ff          ;f21a  ff ff    
    clb 7,mem_00ff          ;f21c  ff ff    
    clb 7,mem_00ff          ;f21e  ff ff    
    clb 7,mem_00ff          ;f220  ff ff    
    clb 7,mem_00ff          ;f222  ff ff    
    clb 7,mem_00ff          ;f224  ff ff    
    clb 7,mem_00ff          ;f226  ff ff    
    clb 7,mem_00ff          ;f228  ff ff    
    clb 7,mem_00ff          ;f22a  ff ff    
    clb 7,mem_00ff          ;f22c  ff ff    
    clb 7,mem_00ff          ;f22e  ff ff    
    clb 7,mem_00ff          ;f230  ff ff    
    clb 7,mem_00ff          ;f232  ff ff    
    clb 7,mem_00ff          ;f234  ff ff    
    clb 7,mem_00ff          ;f236  ff ff    
    clb 7,mem_00ff          ;f238  ff ff    
    clb 7,mem_00ff          ;f23a  ff ff    
    clb 7,mem_00ff          ;f23c  ff ff    
    clb 7,mem_00ff          ;f23e  ff ff    
    clb 7,mem_00ff          ;f240  ff ff    
    clb 7,mem_00ff          ;f242  ff ff    
    clb 7,mem_00ff          ;f244  ff ff    
    clb 7,mem_00ff          ;f246  ff ff    
    clb 7,mem_00ff          ;f248  ff ff    
    clb 7,mem_00ff          ;f24a  ff ff    
    clb 7,mem_00ff          ;f24c  ff ff    
    clb 7,mem_00ff          ;f24e  ff ff    
    clb 7,mem_00ff          ;f250  ff ff    
    clb 7,mem_00ff          ;f252  ff ff    
    clb 7,mem_00ff          ;f254  ff ff    
    clb 7,mem_00ff          ;f256  ff ff    
    clb 7,mem_00ff          ;f258  ff ff    
    clb 7,mem_00ff          ;f25a  ff ff    
    clb 7,mem_00ff          ;f25c  ff ff    
    clb 7,mem_00ff          ;f25e  ff ff    
    clb 7,mem_00ff          ;f260  ff ff    
    clb 7,mem_00ff          ;f262  ff ff    
    clb 7,mem_00ff          ;f264  ff ff    
    clb 7,mem_00ff          ;f266  ff ff    
    clb 7,mem_00ff          ;f268  ff ff    
    clb 7,mem_00ff          ;f26a  ff ff    
    clb 7,mem_00ff          ;f26c  ff ff    
    clb 7,mem_00ff          ;f26e  ff ff    
    clb 7,mem_00ff          ;f270  ff ff    
    clb 7,mem_00ff          ;f272  ff ff    
    clb 7,mem_00ff          ;f274  ff ff    
    clb 7,mem_00ff          ;f276  ff ff    
    clb 7,mem_00ff          ;f278  ff ff    
    clb 7,mem_00ff          ;f27a  ff ff    
    clb 7,mem_00ff          ;f27c  ff ff    
    clb 7,mem_00ff          ;f27e  ff ff    
    clb 7,mem_00ff          ;f280  ff ff    
    clb 7,mem_00ff          ;f282  ff ff    
    clb 7,mem_00ff          ;f284  ff ff    
    clb 7,mem_00ff          ;f286  ff ff    
    clb 7,mem_00ff          ;f288  ff ff    
    clb 7,mem_00ff          ;f28a  ff ff    
    clb 7,mem_00ff          ;f28c  ff ff    
    clb 7,mem_00ff          ;f28e  ff ff    
    clb 7,mem_00ff          ;f290  ff ff    
    clb 7,mem_00ff          ;f292  ff ff    
    clb 7,mem_00ff          ;f294  ff ff    
    clb 7,mem_00ff          ;f296  ff ff    
    clb 7,mem_00ff          ;f298  ff ff    
    clb 7,mem_00ff          ;f29a  ff ff    
    clb 7,mem_00ff          ;f29c  ff ff    
    clb 7,mem_00ff          ;f29e  ff ff    
    clb 7,mem_00ff          ;f2a0  ff ff    
    clb 7,mem_00ff          ;f2a2  ff ff    
    clb 7,mem_00ff          ;f2a4  ff ff    
    clb 7,mem_00ff          ;f2a6  ff ff    
    clb 7,mem_00ff          ;f2a8  ff ff    
    clb 7,mem_00ff          ;f2aa  ff ff    
    clb 7,mem_00ff          ;f2ac  ff ff    
    clb 7,mem_00ff          ;f2ae  ff ff    
    clb 7,mem_00ff          ;f2b0  ff ff    
    clb 7,mem_00ff          ;f2b2  ff ff    
    clb 7,mem_00ff          ;f2b4  ff ff    
    clb 7,mem_00ff          ;f2b6  ff ff    
    clb 7,mem_00ff          ;f2b8  ff ff    
    clb 7,mem_00ff          ;f2ba  ff ff    
    clb 7,mem_00ff          ;f2bc  ff ff    
    clb 7,mem_00ff          ;f2be  ff ff    
    clb 7,mem_00ff          ;f2c0  ff ff    
    clb 7,mem_00ff          ;f2c2  ff ff    
    clb 7,mem_00ff          ;f2c4  ff ff    
    clb 7,mem_00ff          ;f2c6  ff ff    
    clb 7,mem_00ff          ;f2c8  ff ff    
    clb 7,mem_00ff          ;f2ca  ff ff    
    clb 7,mem_00ff          ;f2cc  ff ff    
    clb 7,mem_00ff          ;f2ce  ff ff    
    clb 7,mem_00ff          ;f2d0  ff ff    
    clb 7,mem_00ff          ;f2d2  ff ff    
    clb 7,mem_00ff          ;f2d4  ff ff    
    clb 7,mem_00ff          ;f2d6  ff ff    
    clb 7,mem_00ff          ;f2d8  ff ff    
    clb 7,mem_00ff          ;f2da  ff ff    
    clb 7,mem_00ff          ;f2dc  ff ff    
    clb 7,mem_00ff          ;f2de  ff ff    
    clb 7,mem_00ff          ;f2e0  ff ff    
    clb 7,mem_00ff          ;f2e2  ff ff    
    clb 7,mem_00ff          ;f2e4  ff ff    
    clb 7,mem_00ff          ;f2e6  ff ff    
    clb 7,mem_00ff          ;f2e8  ff ff    
    clb 7,mem_00ff          ;f2ea  ff ff    
    clb 7,mem_00ff          ;f2ec  ff ff    
    clb 7,mem_00ff          ;f2ee  ff ff    
    clb 7,mem_00ff          ;f2f0  ff ff    
    clb 7,mem_00ff          ;f2f2  ff ff    
    clb 7,mem_00ff          ;f2f4  ff ff    
    clb 7,mem_00ff          ;f2f6  ff ff    
    clb 7,mem_00ff          ;f2f8  ff ff    
    clb 7,mem_00ff          ;f2fa  ff ff    
    clb 7,mem_00ff          ;f2fc  ff ff    
    clb 7,mem_00ff          ;f2fe  ff ff    
    clb 7,mem_00ff          ;f300  ff ff    
    clb 7,mem_00ff          ;f302  ff ff    
    clb 7,mem_00ff          ;f304  ff ff    
    clb 7,mem_00ff          ;f306  ff ff    
    clb 7,mem_00ff          ;f308  ff ff    
    clb 7,mem_00ff          ;f30a  ff ff    
    clb 7,mem_00ff          ;f30c  ff ff    
    clb 7,mem_00ff          ;f30e  ff ff    
    clb 7,mem_00ff          ;f310  ff ff    
    clb 7,mem_00ff          ;f312  ff ff    
    clb 7,mem_00ff          ;f314  ff ff    
    clb 7,mem_00ff          ;f316  ff ff    
    clb 7,mem_00ff          ;f318  ff ff    
    clb 7,mem_00ff          ;f31a  ff ff    
    clb 7,mem_00ff          ;f31c  ff ff    
    clb 7,mem_00ff          ;f31e  ff ff    
    clb 7,mem_00ff          ;f320  ff ff    
    clb 7,mem_00ff          ;f322  ff ff    
    clb 7,mem_00ff          ;f324  ff ff    
    clb 7,mem_00ff          ;f326  ff ff    
    clb 7,mem_00ff          ;f328  ff ff    
    clb 7,mem_00ff          ;f32a  ff ff    
    clb 7,mem_00ff          ;f32c  ff ff    
    clb 7,mem_00ff          ;f32e  ff ff    
    clb 7,mem_00ff          ;f330  ff ff    
    clb 7,mem_00ff          ;f332  ff ff    
    clb 7,mem_00ff          ;f334  ff ff    
    clb 7,mem_00ff          ;f336  ff ff    
    clb 7,mem_00ff          ;f338  ff ff    
    clb 7,mem_00ff          ;f33a  ff ff    
    clb 7,mem_00ff          ;f33c  ff ff    
    clb 7,mem_00ff          ;f33e  ff ff    
    clb 7,mem_00ff          ;f340  ff ff    
    clb 7,mem_00ff          ;f342  ff ff    
    clb 7,mem_00ff          ;f344  ff ff    
    clb 7,mem_00ff          ;f346  ff ff    
    clb 7,mem_00ff          ;f348  ff ff    
    clb 7,mem_00ff          ;f34a  ff ff    
    clb 7,mem_00ff          ;f34c  ff ff    
    clb 7,mem_00ff          ;f34e  ff ff    
    clb 7,mem_00ff          ;f350  ff ff    
    clb 7,mem_00ff          ;f352  ff ff    
    clb 7,mem_00ff          ;f354  ff ff    
    clb 7,mem_00ff          ;f356  ff ff    
    clb 7,mem_00ff          ;f358  ff ff    
    clb 7,mem_00ff          ;f35a  ff ff    
    clb 7,mem_00ff          ;f35c  ff ff    
    clb 7,mem_00ff          ;f35e  ff ff    
    clb 7,mem_00ff          ;f360  ff ff    
    clb 7,mem_00ff          ;f362  ff ff    
    clb 7,mem_00ff          ;f364  ff ff    
    clb 7,mem_00ff          ;f366  ff ff    
    clb 7,mem_00ff          ;f368  ff ff    
    clb 7,mem_00ff          ;f36a  ff ff    
    clb 7,mem_00ff          ;f36c  ff ff    
    clb 7,mem_00ff          ;f36e  ff ff    
    clb 7,mem_00ff          ;f370  ff ff    
    clb 7,mem_00ff          ;f372  ff ff    
    clb 7,mem_00ff          ;f374  ff ff    
    clb 7,mem_00ff          ;f376  ff ff    
    clb 7,mem_00ff          ;f378  ff ff    
    clb 7,mem_00ff          ;f37a  ff ff    
    clb 7,mem_00ff          ;f37c  ff ff    
    clb 7,mem_00ff          ;f37e  ff ff    
    clb 7,mem_00ff          ;f380  ff ff    
    clb 7,mem_00ff          ;f382  ff ff    
    clb 7,mem_00ff          ;f384  ff ff    
    clb 7,mem_00ff          ;f386  ff ff    
    clb 7,mem_00ff          ;f388  ff ff    
    clb 7,mem_00ff          ;f38a  ff ff    
    clb 7,mem_00ff          ;f38c  ff ff    
    clb 7,mem_00ff          ;f38e  ff ff    
    clb 7,mem_00ff          ;f390  ff ff    
    clb 7,mem_00ff          ;f392  ff ff    
    clb 7,mem_00ff          ;f394  ff ff    
    clb 7,mem_00ff          ;f396  ff ff    
    clb 7,mem_00ff          ;f398  ff ff    
    clb 7,mem_00ff          ;f39a  ff ff    
    clb 7,mem_00ff          ;f39c  ff ff    
    clb 7,mem_00ff          ;f39e  ff ff    
    clb 7,mem_00ff          ;f3a0  ff ff    
    clb 7,mem_00ff          ;f3a2  ff ff    
    clb 7,mem_00ff          ;f3a4  ff ff    
    clb 7,mem_00ff          ;f3a6  ff ff    
    clb 7,mem_00ff          ;f3a8  ff ff    
    clb 7,mem_00ff          ;f3aa  ff ff    
    clb 7,mem_00ff          ;f3ac  ff ff    
    clb 7,mem_00ff          ;f3ae  ff ff    
    clb 7,mem_00ff          ;f3b0  ff ff    
    clb 7,mem_00ff          ;f3b2  ff ff    
    clb 7,mem_00ff          ;f3b4  ff ff    
    clb 7,mem_00ff          ;f3b6  ff ff    
    clb 7,mem_00ff          ;f3b8  ff ff    
    clb 7,mem_00ff          ;f3ba  ff ff    
    clb 7,mem_00ff          ;f3bc  ff ff    
    clb 7,mem_00ff          ;f3be  ff ff    
    clb 7,mem_00ff          ;f3c0  ff ff    
    clb 7,mem_00ff          ;f3c2  ff ff    
    clb 7,mem_00ff          ;f3c4  ff ff    
    clb 7,mem_00ff          ;f3c6  ff ff    
    clb 7,mem_00ff          ;f3c8  ff ff    
    clb 7,mem_00ff          ;f3ca  ff ff    
    clb 7,mem_00ff          ;f3cc  ff ff    
    clb 7,mem_00ff          ;f3ce  ff ff    
    clb 7,mem_00ff          ;f3d0  ff ff    
    clb 7,mem_00ff          ;f3d2  ff ff    
    clb 7,mem_00ff          ;f3d4  ff ff    
    clb 7,mem_00ff          ;f3d6  ff ff    
    clb 7,mem_00ff          ;f3d8  ff ff    
    clb 7,mem_00ff          ;f3da  ff ff    
    clb 7,mem_00ff          ;f3dc  ff ff    
    clb 7,mem_00ff          ;f3de  ff ff    
    clb 7,mem_00ff          ;f3e0  ff ff    
    clb 7,mem_00ff          ;f3e2  ff ff    
    clb 7,mem_00ff          ;f3e4  ff ff    
    clb 7,mem_00ff          ;f3e6  ff ff    
    clb 7,mem_00ff          ;f3e8  ff ff    
    clb 7,mem_00ff          ;f3ea  ff ff    
    clb 7,mem_00ff          ;f3ec  ff ff    
    clb 7,mem_00ff          ;f3ee  ff ff    
    clb 7,mem_00ff          ;f3f0  ff ff    
    clb 7,mem_00ff          ;f3f2  ff ff    
    clb 7,mem_00ff          ;f3f4  ff ff    
    clb 7,mem_00ff          ;f3f6  ff ff    
    clb 7,mem_00ff          ;f3f8  ff ff    
    clb 7,mem_00ff          ;f3fa  ff ff    
    clb 7,mem_00ff          ;f3fc  ff ff    
    clb 7,mem_00ff          ;f3fe  ff ff    
    clb 7,mem_00ff          ;f400  ff ff    
    clb 7,mem_00ff          ;f402  ff ff    
    clb 7,mem_00ff          ;f404  ff ff    
    clb 7,mem_00ff          ;f406  ff ff    
    clb 7,mem_00ff          ;f408  ff ff    
    clb 7,mem_00ff          ;f40a  ff ff    
    clb 7,mem_00ff          ;f40c  ff ff    
    clb 7,mem_00ff          ;f40e  ff ff    
    clb 7,mem_00ff          ;f410  ff ff    
    clb 7,mem_00ff          ;f412  ff ff    
    clb 7,mem_00ff          ;f414  ff ff    
    clb 7,mem_00ff          ;f416  ff ff    
    clb 7,mem_00ff          ;f418  ff ff    
    clb 7,mem_00ff          ;f41a  ff ff    
    clb 7,mem_00ff          ;f41c  ff ff    
    clb 7,mem_00ff          ;f41e  ff ff    
    clb 7,mem_00ff          ;f420  ff ff    
    clb 7,mem_00ff          ;f422  ff ff    
    clb 7,mem_00ff          ;f424  ff ff    
    clb 7,mem_00ff          ;f426  ff ff    
    clb 7,mem_00ff          ;f428  ff ff    
    clb 7,mem_00ff          ;f42a  ff ff    
    clb 7,mem_00ff          ;f42c  ff ff    
    clb 7,mem_00ff          ;f42e  ff ff    
    clb 7,mem_00ff          ;f430  ff ff    
    clb 7,mem_00ff          ;f432  ff ff    
    clb 7,mem_00ff          ;f434  ff ff    
    clb 7,mem_00ff          ;f436  ff ff    
    clb 7,mem_00ff          ;f438  ff ff    
    clb 7,mem_00ff          ;f43a  ff ff    
    clb 7,mem_00ff          ;f43c  ff ff    
    clb 7,mem_00ff          ;f43e  ff ff    
    clb 7,mem_00ff          ;f440  ff ff    
    clb 7,mem_00ff          ;f442  ff ff    
    clb 7,mem_00ff          ;f444  ff ff    
    clb 7,mem_00ff          ;f446  ff ff    
    clb 7,mem_00ff          ;f448  ff ff    
    clb 7,mem_00ff          ;f44a  ff ff    
    clb 7,mem_00ff          ;f44c  ff ff    
    clb 7,mem_00ff          ;f44e  ff ff    
    clb 7,mem_00ff          ;f450  ff ff    
    clb 7,mem_00ff          ;f452  ff ff    
    clb 7,mem_00ff          ;f454  ff ff    
    clb 7,mem_00ff          ;f456  ff ff    
    clb 7,mem_00ff          ;f458  ff ff    
    clb 7,mem_00ff          ;f45a  ff ff    
    clb 7,mem_00ff          ;f45c  ff ff    
    clb 7,mem_00ff          ;f45e  ff ff    
    clb 7,mem_00ff          ;f460  ff ff    
    clb 7,mem_00ff          ;f462  ff ff    
    clb 7,mem_00ff          ;f464  ff ff    
    clb 7,mem_00ff          ;f466  ff ff    
    clb 7,mem_00ff          ;f468  ff ff    
    clb 7,mem_00ff          ;f46a  ff ff    
    clb 7,mem_00ff          ;f46c  ff ff    
    clb 7,mem_00ff          ;f46e  ff ff    
    clb 7,mem_00ff          ;f470  ff ff    
    clb 7,mem_00ff          ;f472  ff ff    
    clb 7,mem_00ff          ;f474  ff ff    
    clb 7,mem_00ff          ;f476  ff ff    
    clb 7,mem_00ff          ;f478  ff ff    
    clb 7,mem_00ff          ;f47a  ff ff    
    clb 7,mem_00ff          ;f47c  ff ff    
    clb 7,mem_00ff          ;f47e  ff ff    
    clb 7,mem_00ff          ;f480  ff ff    
    clb 7,mem_00ff          ;f482  ff ff    
    clb 7,mem_00ff          ;f484  ff ff    
    clb 7,mem_00ff          ;f486  ff ff    
    clb 7,mem_00ff          ;f488  ff ff    
    clb 7,mem_00ff          ;f48a  ff ff    
    clb 7,mem_00ff          ;f48c  ff ff    
    clb 7,mem_00ff          ;f48e  ff ff    
    clb 7,mem_00ff          ;f490  ff ff    
    clb 7,mem_00ff          ;f492  ff ff    
    clb 7,mem_00ff          ;f494  ff ff    
    clb 7,mem_00ff          ;f496  ff ff    
    clb 7,mem_00ff          ;f498  ff ff    
    clb 7,mem_00ff          ;f49a  ff ff    
    clb 7,mem_00ff          ;f49c  ff ff    
    clb 7,mem_00ff          ;f49e  ff ff    
    clb 7,mem_00ff          ;f4a0  ff ff    
    clb 7,mem_00ff          ;f4a2  ff ff    
    clb 7,mem_00ff          ;f4a4  ff ff    
    clb 7,mem_00ff          ;f4a6  ff ff    
    clb 7,mem_00ff          ;f4a8  ff ff    
    clb 7,mem_00ff          ;f4aa  ff ff    
    clb 7,mem_00ff          ;f4ac  ff ff    
    clb 7,mem_00ff          ;f4ae  ff ff    
    clb 7,mem_00ff          ;f4b0  ff ff    
    clb 7,mem_00ff          ;f4b2  ff ff    
    clb 7,mem_00ff          ;f4b4  ff ff    
    clb 7,mem_00ff          ;f4b6  ff ff    
    clb 7,mem_00ff          ;f4b8  ff ff    
    clb 7,mem_00ff          ;f4ba  ff ff    
    clb 7,mem_00ff          ;f4bc  ff ff    
    clb 7,mem_00ff          ;f4be  ff ff    
    clb 7,mem_00ff          ;f4c0  ff ff    
    clb 7,mem_00ff          ;f4c2  ff ff    
    clb 7,mem_00ff          ;f4c4  ff ff    
    clb 7,mem_00ff          ;f4c6  ff ff    
    clb 7,mem_00ff          ;f4c8  ff ff    
    clb 7,mem_00ff          ;f4ca  ff ff    
    clb 7,mem_00ff          ;f4cc  ff ff    
    clb 7,mem_00ff          ;f4ce  ff ff    
    clb 7,mem_00ff          ;f4d0  ff ff    
    clb 7,mem_00ff          ;f4d2  ff ff    
    clb 7,mem_00ff          ;f4d4  ff ff    
    clb 7,mem_00ff          ;f4d6  ff ff    
    clb 7,mem_00ff          ;f4d8  ff ff    
    clb 7,mem_00ff          ;f4da  ff ff    
    clb 7,mem_00ff          ;f4dc  ff ff    
    clb 7,mem_00ff          ;f4de  ff ff    
    clb 7,mem_00ff          ;f4e0  ff ff    
    clb 7,mem_00ff          ;f4e2  ff ff    
    clb 7,mem_00ff          ;f4e4  ff ff    
    clb 7,mem_00ff          ;f4e6  ff ff    
    clb 7,mem_00ff          ;f4e8  ff ff    
    clb 7,mem_00ff          ;f4ea  ff ff    
    clb 7,mem_00ff          ;f4ec  ff ff    
    clb 7,mem_00ff          ;f4ee  ff ff    
    clb 7,mem_00ff          ;f4f0  ff ff    
    clb 7,mem_00ff          ;f4f2  ff ff    
    clb 7,mem_00ff          ;f4f4  ff ff    
    clb 7,mem_00ff          ;f4f6  ff ff    
    clb 7,mem_00ff          ;f4f8  ff ff    
    clb 7,mem_00ff          ;f4fa  ff ff    
    clb 7,mem_00ff          ;f4fc  ff ff    
    clb 7,mem_00ff          ;f4fe  ff ff    
    clb 7,mem_00ff          ;f500  ff ff    
    clb 7,mem_00ff          ;f502  ff ff    
    clb 7,mem_00ff          ;f504  ff ff    
    clb 7,mem_00ff          ;f506  ff ff    
    clb 7,mem_00ff          ;f508  ff ff    
    clb 7,mem_00ff          ;f50a  ff ff    
    clb 7,mem_00ff          ;f50c  ff ff    
    clb 7,mem_00ff          ;f50e  ff ff    
    clb 7,mem_00ff          ;f510  ff ff    
    clb 7,mem_00ff          ;f512  ff ff    
    clb 7,mem_00ff          ;f514  ff ff    
    clb 7,mem_00ff          ;f516  ff ff    
    clb 7,mem_00ff          ;f518  ff ff    
    clb 7,mem_00ff          ;f51a  ff ff    
    clb 7,mem_00ff          ;f51c  ff ff    
    clb 7,mem_00ff          ;f51e  ff ff    
    clb 7,mem_00ff          ;f520  ff ff    
    clb 7,mem_00ff          ;f522  ff ff    
    clb 7,mem_00ff          ;f524  ff ff    
    clb 7,mem_00ff          ;f526  ff ff    
    clb 7,mem_00ff          ;f528  ff ff    
    clb 7,mem_00ff          ;f52a  ff ff    
    clb 7,mem_00ff          ;f52c  ff ff    
    clb 7,mem_00ff          ;f52e  ff ff    
    clb 7,mem_00ff          ;f530  ff ff    
    clb 7,mem_00ff          ;f532  ff ff    
    clb 7,mem_00ff          ;f534  ff ff    
    clb 7,mem_00ff          ;f536  ff ff    
    clb 7,mem_00ff          ;f538  ff ff    
    clb 7,mem_00ff          ;f53a  ff ff    
    clb 7,mem_00ff          ;f53c  ff ff    
    clb 7,mem_00ff          ;f53e  ff ff    
    clb 7,mem_00ff          ;f540  ff ff    
    clb 7,mem_00ff          ;f542  ff ff    
    clb 7,mem_00ff          ;f544  ff ff    
    clb 7,mem_00ff          ;f546  ff ff    
    clb 7,mem_00ff          ;f548  ff ff    
    clb 7,mem_00ff          ;f54a  ff ff    
    clb 7,mem_00ff          ;f54c  ff ff    
    clb 7,mem_00ff          ;f54e  ff ff    
    clb 7,mem_00ff          ;f550  ff ff    
    clb 7,mem_00ff          ;f552  ff ff    
    clb 7,mem_00ff          ;f554  ff ff    
    clb 7,mem_00ff          ;f556  ff ff    
    clb 7,mem_00ff          ;f558  ff ff    
    clb 7,mem_00ff          ;f55a  ff ff    
    clb 7,mem_00ff          ;f55c  ff ff    
    clb 7,mem_00ff          ;f55e  ff ff    
    clb 7,mem_00ff          ;f560  ff ff    
    clb 7,mem_00ff          ;f562  ff ff    
    clb 7,mem_00ff          ;f564  ff ff    
    clb 7,mem_00ff          ;f566  ff ff    
    clb 7,mem_00ff          ;f568  ff ff    
    clb 7,mem_00ff          ;f56a  ff ff    
    clb 7,mem_00ff          ;f56c  ff ff    
    clb 7,mem_00ff          ;f56e  ff ff    
    clb 7,mem_00ff          ;f570  ff ff    
    clb 7,mem_00ff          ;f572  ff ff    
    clb 7,mem_00ff          ;f574  ff ff    
    clb 7,mem_00ff          ;f576  ff ff    
    clb 7,mem_00ff          ;f578  ff ff    
    clb 7,mem_00ff          ;f57a  ff ff    
    clb 7,mem_00ff          ;f57c  ff ff    
    clb 7,mem_00ff          ;f57e  ff ff    
    clb 7,mem_00ff          ;f580  ff ff    
    clb 7,mem_00ff          ;f582  ff ff    
    clb 7,mem_00ff          ;f584  ff ff    
    clb 7,mem_00ff          ;f586  ff ff    
    clb 7,mem_00ff          ;f588  ff ff    
    clb 7,mem_00ff          ;f58a  ff ff    
    clb 7,mem_00ff          ;f58c  ff ff    
    clb 7,mem_00ff          ;f58e  ff ff    
    clb 7,mem_00ff          ;f590  ff ff    
    clb 7,mem_00ff          ;f592  ff ff    
    clb 7,mem_00ff          ;f594  ff ff    
    clb 7,mem_00ff          ;f596  ff ff    
    clb 7,mem_00ff          ;f598  ff ff    
    clb 7,mem_00ff          ;f59a  ff ff    
    clb 7,mem_00ff          ;f59c  ff ff    
    clb 7,mem_00ff          ;f59e  ff ff    
    clb 7,mem_00ff          ;f5a0  ff ff    
    clb 7,mem_00ff          ;f5a2  ff ff    
    clb 7,mem_00ff          ;f5a4  ff ff    
    clb 7,mem_00ff          ;f5a6  ff ff    
    clb 7,mem_00ff          ;f5a8  ff ff    
    clb 7,mem_00ff          ;f5aa  ff ff    
    clb 7,mem_00ff          ;f5ac  ff ff    
    clb 7,mem_00ff          ;f5ae  ff ff    
    clb 7,mem_00ff          ;f5b0  ff ff    
    clb 7,mem_00ff          ;f5b2  ff ff    
    clb 7,mem_00ff          ;f5b4  ff ff    
    clb 7,mem_00ff          ;f5b6  ff ff    
    clb 7,mem_00ff          ;f5b8  ff ff    
    clb 7,mem_00ff          ;f5ba  ff ff    
    clb 7,mem_00ff          ;f5bc  ff ff    
    clb 7,mem_00ff          ;f5be  ff ff    
    clb 7,mem_00ff          ;f5c0  ff ff    
    clb 7,mem_00ff          ;f5c2  ff ff    
    clb 7,mem_00ff          ;f5c4  ff ff    
    clb 7,mem_00ff          ;f5c6  ff ff    
    clb 7,mem_00ff          ;f5c8  ff ff    
    clb 7,mem_00ff          ;f5ca  ff ff    
    clb 7,mem_00ff          ;f5cc  ff ff    
    clb 7,mem_00ff          ;f5ce  ff ff    
    clb 7,mem_00ff          ;f5d0  ff ff    
    clb 7,mem_00ff          ;f5d2  ff ff    
    clb 7,mem_00ff          ;f5d4  ff ff    
    clb 7,mem_00ff          ;f5d6  ff ff    
    clb 7,mem_00ff          ;f5d8  ff ff    
    clb 7,mem_00ff          ;f5da  ff ff    
    clb 7,mem_00ff          ;f5dc  ff ff    
    clb 7,mem_00ff          ;f5de  ff ff    
    clb 7,mem_00ff          ;f5e0  ff ff    
    clb 7,mem_00ff          ;f5e2  ff ff    
    clb 7,mem_00ff          ;f5e4  ff ff    
    clb 7,mem_00ff          ;f5e6  ff ff    
    clb 7,mem_00ff          ;f5e8  ff ff    
    clb 7,mem_00ff          ;f5ea  ff ff    
    clb 7,mem_00ff          ;f5ec  ff ff    
    clb 7,mem_00ff          ;f5ee  ff ff    
    clb 7,mem_00ff          ;f5f0  ff ff    
    clb 7,mem_00ff          ;f5f2  ff ff    
    clb 7,mem_00ff          ;f5f4  ff ff    
    clb 7,mem_00ff          ;f5f6  ff ff    
    clb 7,mem_00ff          ;f5f8  ff ff    
    clb 7,mem_00ff          ;f5fa  ff ff    
    clb 7,mem_00ff          ;f5fc  ff ff    
    clb 7,mem_00ff          ;f5fe  ff ff    
    clb 7,mem_00ff          ;f600  ff ff    
    clb 7,mem_00ff          ;f602  ff ff    
    clb 7,mem_00ff          ;f604  ff ff    
    clb 7,mem_00ff          ;f606  ff ff    
    clb 7,mem_00ff          ;f608  ff ff    
    clb 7,mem_00ff          ;f60a  ff ff    
    clb 7,mem_00ff          ;f60c  ff ff    
    clb 7,mem_00ff          ;f60e  ff ff    
    clb 7,mem_00ff          ;f610  ff ff    
    clb 7,mem_00ff          ;f612  ff ff    
    clb 7,mem_00ff          ;f614  ff ff    
    clb 7,mem_00ff          ;f616  ff ff    
    clb 7,mem_00ff          ;f618  ff ff    
    clb 7,mem_00ff          ;f61a  ff ff    
    clb 7,mem_00ff          ;f61c  ff ff    
    clb 7,mem_00ff          ;f61e  ff ff    
    clb 7,mem_00ff          ;f620  ff ff    
    clb 7,mem_00ff          ;f622  ff ff    
    clb 7,mem_00ff          ;f624  ff ff    
    clb 7,mem_00ff          ;f626  ff ff    
    clb 7,mem_00ff          ;f628  ff ff    
    clb 7,mem_00ff          ;f62a  ff ff    
    clb 7,mem_00ff          ;f62c  ff ff    
    clb 7,mem_00ff          ;f62e  ff ff    
    clb 7,mem_00ff          ;f630  ff ff    
    clb 7,mem_00ff          ;f632  ff ff    
    clb 7,mem_00ff          ;f634  ff ff    
    clb 7,mem_00ff          ;f636  ff ff    
    clb 7,mem_00ff          ;f638  ff ff    
    clb 7,mem_00ff          ;f63a  ff ff    
    clb 7,mem_00ff          ;f63c  ff ff    
    clb 7,mem_00ff          ;f63e  ff ff    
    clb 7,mem_00ff          ;f640  ff ff    
    clb 7,mem_00ff          ;f642  ff ff    
    clb 7,mem_00ff          ;f644  ff ff    
    clb 7,mem_00ff          ;f646  ff ff    
    clb 7,mem_00ff          ;f648  ff ff    
    clb 7,mem_00ff          ;f64a  ff ff    
    clb 7,mem_00ff          ;f64c  ff ff    
    clb 7,mem_00ff          ;f64e  ff ff    
    clb 7,mem_00ff          ;f650  ff ff    
    clb 7,mem_00ff          ;f652  ff ff    
    clb 7,mem_00ff          ;f654  ff ff    
    clb 7,mem_00ff          ;f656  ff ff    
    clb 7,mem_00ff          ;f658  ff ff    
    clb 7,mem_00ff          ;f65a  ff ff    
    clb 7,mem_00ff          ;f65c  ff ff    
    clb 7,mem_00ff          ;f65e  ff ff    
    clb 7,mem_00ff          ;f660  ff ff    
    clb 7,mem_00ff          ;f662  ff ff    
    clb 7,mem_00ff          ;f664  ff ff    
    clb 7,mem_00ff          ;f666  ff ff    
    clb 7,mem_00ff          ;f668  ff ff    
    clb 7,mem_00ff          ;f66a  ff ff    
    clb 7,mem_00ff          ;f66c  ff ff    
    clb 7,mem_00ff          ;f66e  ff ff    
    clb 7,mem_00ff          ;f670  ff ff    
    clb 7,mem_00ff          ;f672  ff ff    
    clb 7,mem_00ff          ;f674  ff ff    
    clb 7,mem_00ff          ;f676  ff ff    
    clb 7,mem_00ff          ;f678  ff ff    
    clb 7,mem_00ff          ;f67a  ff ff    
    clb 7,mem_00ff          ;f67c  ff ff    
    clb 7,mem_00ff          ;f67e  ff ff    
    clb 7,mem_00ff          ;f680  ff ff    
    clb 7,mem_00ff          ;f682  ff ff    
    clb 7,mem_00ff          ;f684  ff ff    
    clb 7,mem_00ff          ;f686  ff ff    
    clb 7,mem_00ff          ;f688  ff ff    
    clb 7,mem_00ff          ;f68a  ff ff    
    clb 7,mem_00ff          ;f68c  ff ff    
    clb 7,mem_00ff          ;f68e  ff ff    
    clb 7,mem_00ff          ;f690  ff ff    
    clb 7,mem_00ff          ;f692  ff ff    
    clb 7,mem_00ff          ;f694  ff ff    
    clb 7,mem_00ff          ;f696  ff ff    
    clb 7,mem_00ff          ;f698  ff ff    
    clb 7,mem_00ff          ;f69a  ff ff    
    clb 7,mem_00ff          ;f69c  ff ff    
    clb 7,mem_00ff          ;f69e  ff ff    
    clb 7,mem_00ff          ;f6a0  ff ff    
    clb 7,mem_00ff          ;f6a2  ff ff    
    clb 7,mem_00ff          ;f6a4  ff ff    
    clb 7,mem_00ff          ;f6a6  ff ff    
    clb 7,mem_00ff          ;f6a8  ff ff    
    clb 7,mem_00ff          ;f6aa  ff ff    
    clb 7,mem_00ff          ;f6ac  ff ff    
    clb 7,mem_00ff          ;f6ae  ff ff    
    clb 7,mem_00ff          ;f6b0  ff ff    
    clb 7,mem_00ff          ;f6b2  ff ff    
    clb 7,mem_00ff          ;f6b4  ff ff    
    clb 7,mem_00ff          ;f6b6  ff ff    
    clb 7,mem_00ff          ;f6b8  ff ff    
    clb 7,mem_00ff          ;f6ba  ff ff    
    clb 7,mem_00ff          ;f6bc  ff ff    
    clb 7,mem_00ff          ;f6be  ff ff    
    clb 7,mem_00ff          ;f6c0  ff ff    
    clb 7,mem_00ff          ;f6c2  ff ff    
    clb 7,mem_00ff          ;f6c4  ff ff    
    clb 7,mem_00ff          ;f6c6  ff ff    
    clb 7,mem_00ff          ;f6c8  ff ff    
    clb 7,mem_00ff          ;f6ca  ff ff    
    clb 7,mem_00ff          ;f6cc  ff ff    
    clb 7,mem_00ff          ;f6ce  ff ff    
    clb 7,mem_00ff          ;f6d0  ff ff    
    clb 7,mem_00ff          ;f6d2  ff ff    
    clb 7,mem_00ff          ;f6d4  ff ff    
    clb 7,mem_00ff          ;f6d6  ff ff    
    clb 7,mem_00ff          ;f6d8  ff ff    
    clb 7,mem_00ff          ;f6da  ff ff    
    clb 7,mem_00ff          ;f6dc  ff ff    
    clb 7,mem_00ff          ;f6de  ff ff    
    clb 7,mem_00ff          ;f6e0  ff ff    
    clb 7,mem_00ff          ;f6e2  ff ff    
    clb 7,mem_00ff          ;f6e4  ff ff    
    clb 7,mem_00ff          ;f6e6  ff ff    
    clb 7,mem_00ff          ;f6e8  ff ff    
    clb 7,mem_00ff          ;f6ea  ff ff    
    clb 7,mem_00ff          ;f6ec  ff ff    
    clb 7,mem_00ff          ;f6ee  ff ff    
    clb 7,mem_00ff          ;f6f0  ff ff    
    clb 7,mem_00ff          ;f6f2  ff ff    
    clb 7,mem_00ff          ;f6f4  ff ff    
    clb 7,mem_00ff          ;f6f6  ff ff    
    clb 7,mem_00ff          ;f6f8  ff ff    
    clb 7,mem_00ff          ;f6fa  ff ff    
    clb 7,mem_00ff          ;f6fc  ff ff    
    clb 7,mem_00ff          ;f6fe  ff ff    
    clb 7,mem_00ff          ;f700  ff ff    
    clb 7,mem_00ff          ;f702  ff ff    
    clb 7,mem_00ff          ;f704  ff ff    
    clb 7,mem_00ff          ;f706  ff ff    
    clb 7,mem_00ff          ;f708  ff ff    
    clb 7,mem_00ff          ;f70a  ff ff    
    clb 7,mem_00ff          ;f70c  ff ff    
    clb 7,mem_00ff          ;f70e  ff ff    
    clb 7,mem_00ff          ;f710  ff ff    
    clb 7,mem_00ff          ;f712  ff ff    
    clb 7,mem_00ff          ;f714  ff ff    
    clb 7,mem_00ff          ;f716  ff ff    
    clb 7,mem_00ff          ;f718  ff ff    
    clb 7,mem_00ff          ;f71a  ff ff    
    clb 7,mem_00ff          ;f71c  ff ff    
    clb 7,mem_00ff          ;f71e  ff ff    
    clb 7,mem_00ff          ;f720  ff ff    
    clb 7,mem_00ff          ;f722  ff ff    
    clb 7,mem_00ff          ;f724  ff ff    
    clb 7,mem_00ff          ;f726  ff ff    
    clb 7,mem_00ff          ;f728  ff ff    
    clb 7,mem_00ff          ;f72a  ff ff    
    clb 7,mem_00ff          ;f72c  ff ff    
    clb 7,mem_00ff          ;f72e  ff ff    
    clb 7,mem_00ff          ;f730  ff ff    
    clb 7,mem_00ff          ;f732  ff ff    
    clb 7,mem_00ff          ;f734  ff ff    
    clb 7,mem_00ff          ;f736  ff ff    
    clb 7,mem_00ff          ;f738  ff ff    
    clb 7,mem_00ff          ;f73a  ff ff    
    clb 7,mem_00ff          ;f73c  ff ff    
    clb 7,mem_00ff          ;f73e  ff ff    
    clb 7,mem_00ff          ;f740  ff ff    
    clb 7,mem_00ff          ;f742  ff ff    
    clb 7,mem_00ff          ;f744  ff ff    
    clb 7,mem_00ff          ;f746  ff ff    
    clb 7,mem_00ff          ;f748  ff ff    
    clb 7,mem_00ff          ;f74a  ff ff    
    clb 7,mem_00ff          ;f74c  ff ff    
    clb 7,mem_00ff          ;f74e  ff ff    
    clb 7,mem_00ff          ;f750  ff ff    
    clb 7,mem_00ff          ;f752  ff ff    
    clb 7,mem_00ff          ;f754  ff ff    
    clb 7,mem_00ff          ;f756  ff ff    
    clb 7,mem_00ff          ;f758  ff ff    
    clb 7,mem_00ff          ;f75a  ff ff    
    clb 7,mem_00ff          ;f75c  ff ff    
    clb 7,mem_00ff          ;f75e  ff ff    
    clb 7,mem_00ff          ;f760  ff ff    
    clb 7,mem_00ff          ;f762  ff ff    
    clb 7,mem_00ff          ;f764  ff ff    
    clb 7,mem_00ff          ;f766  ff ff    
    clb 7,mem_00ff          ;f768  ff ff    
    clb 7,mem_00ff          ;f76a  ff ff    
    clb 7,mem_00ff          ;f76c  ff ff    
    clb 7,mem_00ff          ;f76e  ff ff    
    clb 7,mem_00ff          ;f770  ff ff    
    clb 7,mem_00ff          ;f772  ff ff    
    clb 7,mem_00ff          ;f774  ff ff    
    clb 7,mem_00ff          ;f776  ff ff    
    clb 7,mem_00ff          ;f778  ff ff    
    clb 7,mem_00ff          ;f77a  ff ff    
    clb 7,mem_00ff          ;f77c  ff ff    
    clb 7,mem_00ff          ;f77e  ff ff    
    clb 7,mem_00ff          ;f780  ff ff    
    clb 7,mem_00ff          ;f782  ff ff    
    clb 7,mem_00ff          ;f784  ff ff    
    clb 7,mem_00ff          ;f786  ff ff    
    clb 7,mem_00ff          ;f788  ff ff    
    clb 7,mem_00ff          ;f78a  ff ff    
    clb 7,mem_00ff          ;f78c  ff ff    
    clb 7,mem_00ff          ;f78e  ff ff    
    clb 7,mem_00ff          ;f790  ff ff    
    clb 7,mem_00ff          ;f792  ff ff    
    clb 7,mem_00ff          ;f794  ff ff    
    clb 7,mem_00ff          ;f796  ff ff    
    clb 7,mem_00ff          ;f798  ff ff    
    clb 7,mem_00ff          ;f79a  ff ff    
    clb 7,mem_00ff          ;f79c  ff ff    
    clb 7,mem_00ff          ;f79e  ff ff    
    clb 7,mem_00ff          ;f7a0  ff ff    
    clb 7,mem_00ff          ;f7a2  ff ff    
    clb 7,mem_00ff          ;f7a4  ff ff    
    clb 7,mem_00ff          ;f7a6  ff ff    
    clb 7,mem_00ff          ;f7a8  ff ff    
    clb 7,mem_00ff          ;f7aa  ff ff    
    clb 7,mem_00ff          ;f7ac  ff ff    
    clb 7,mem_00ff          ;f7ae  ff ff    
    clb 7,mem_00ff          ;f7b0  ff ff    
    clb 7,mem_00ff          ;f7b2  ff ff    
    clb 7,mem_00ff          ;f7b4  ff ff    
    clb 7,mem_00ff          ;f7b6  ff ff    
    clb 7,mem_00ff          ;f7b8  ff ff    
    clb 7,mem_00ff          ;f7ba  ff ff    
    clb 7,mem_00ff          ;f7bc  ff ff    
    clb 7,mem_00ff          ;f7be  ff ff    
    clb 7,mem_00ff          ;f7c0  ff ff    
    clb 7,mem_00ff          ;f7c2  ff ff    
    clb 7,mem_00ff          ;f7c4  ff ff    
    clb 7,mem_00ff          ;f7c6  ff ff    
    clb 7,mem_00ff          ;f7c8  ff ff    
    clb 7,mem_00ff          ;f7ca  ff ff    
    clb 7,mem_00ff          ;f7cc  ff ff    
    clb 7,mem_00ff          ;f7ce  ff ff    
    clb 7,mem_00ff          ;f7d0  ff ff    
    clb 7,mem_00ff          ;f7d2  ff ff    
    clb 7,mem_00ff          ;f7d4  ff ff    
    clb 7,mem_00ff          ;f7d6  ff ff    
    clb 7,mem_00ff          ;f7d8  ff ff    
    clb 7,mem_00ff          ;f7da  ff ff    
    clb 7,mem_00ff          ;f7dc  ff ff    
    clb 7,mem_00ff          ;f7de  ff ff    
    clb 7,mem_00ff          ;f7e0  ff ff    
    clb 7,mem_00ff          ;f7e2  ff ff    
    clb 7,mem_00ff          ;f7e4  ff ff    
    clb 7,mem_00ff          ;f7e6  ff ff    
    clb 7,mem_00ff          ;f7e8  ff ff    
    clb 7,mem_00ff          ;f7ea  ff ff    
    clb 7,mem_00ff          ;f7ec  ff ff    
    clb 7,mem_00ff          ;f7ee  ff ff    
    clb 7,mem_00ff          ;f7f0  ff ff    
    clb 7,mem_00ff          ;f7f2  ff ff    
    clb 7,mem_00ff          ;f7f4  ff ff    
    clb 7,mem_00ff          ;f7f6  ff ff    
    clb 7,mem_00ff          ;f7f8  ff ff    
    clb 7,mem_00ff          ;f7fa  ff ff    
    clb 7,mem_00ff          ;f7fc  ff ff    
    clb 7,mem_00ff          ;f7fe  ff ff    
    clb 7,mem_00ff          ;f800  ff ff    
    clb 7,mem_00ff          ;f802  ff ff    
    clb 7,mem_00ff          ;f804  ff ff    
    clb 7,mem_00ff          ;f806  ff ff    
    clb 7,mem_00ff          ;f808  ff ff    
    clb 7,mem_00ff          ;f80a  ff ff    
    clb 7,mem_00ff          ;f80c  ff ff    
    clb 7,mem_00ff          ;f80e  ff ff    
    clb 7,mem_00ff          ;f810  ff ff    
    clb 7,mem_00ff          ;f812  ff ff    
    clb 7,mem_00ff          ;f814  ff ff    
    clb 7,mem_00ff          ;f816  ff ff    
    clb 7,mem_00ff          ;f818  ff ff    
    clb 7,mem_00ff          ;f81a  ff ff    
    clb 7,mem_00ff          ;f81c  ff ff    
    clb 7,mem_00ff          ;f81e  ff ff    
    clb 7,mem_00ff          ;f820  ff ff    
    clb 7,mem_00ff          ;f822  ff ff    
    clb 7,mem_00ff          ;f824  ff ff    
    clb 7,mem_00ff          ;f826  ff ff    
    clb 7,mem_00ff          ;f828  ff ff    
    clb 7,mem_00ff          ;f82a  ff ff    
    clb 7,mem_00ff          ;f82c  ff ff    
    clb 7,mem_00ff          ;f82e  ff ff    
    clb 7,mem_00ff          ;f830  ff ff    
    clb 7,mem_00ff          ;f832  ff ff    
    clb 7,mem_00ff          ;f834  ff ff    
    clb 7,mem_00ff          ;f836  ff ff    
    clb 7,mem_00ff          ;f838  ff ff    
    clb 7,mem_00ff          ;f83a  ff ff    
    clb 7,mem_00ff          ;f83c  ff ff    
    clb 7,mem_00ff          ;f83e  ff ff    
    clb 7,mem_00ff          ;f840  ff ff    
    clb 7,mem_00ff          ;f842  ff ff    
    clb 7,mem_00ff          ;f844  ff ff    
    clb 7,mem_00ff          ;f846  ff ff    
    clb 7,mem_00ff          ;f848  ff ff    
    clb 7,mem_00ff          ;f84a  ff ff    
    clb 7,mem_00ff          ;f84c  ff ff    
    clb 7,mem_00ff          ;f84e  ff ff    
    clb 7,mem_00ff          ;f850  ff ff    
    clb 7,mem_00ff          ;f852  ff ff    
    clb 7,mem_00ff          ;f854  ff ff    
    clb 7,mem_00ff          ;f856  ff ff    
    clb 7,mem_00ff          ;f858  ff ff    
    clb 7,mem_00ff          ;f85a  ff ff    
    clb 7,mem_00ff          ;f85c  ff ff    
    clb 7,mem_00ff          ;f85e  ff ff    
    clb 7,mem_00ff          ;f860  ff ff    
    clb 7,mem_00ff          ;f862  ff ff    
    clb 7,mem_00ff          ;f864  ff ff    
    clb 7,mem_00ff          ;f866  ff ff    
    clb 7,mem_00ff          ;f868  ff ff    
    clb 7,mem_00ff          ;f86a  ff ff    
    clb 7,mem_00ff          ;f86c  ff ff    
    clb 7,mem_00ff          ;f86e  ff ff    
    clb 7,mem_00ff          ;f870  ff ff    
    clb 7,mem_00ff          ;f872  ff ff    
    clb 7,mem_00ff          ;f874  ff ff    
    clb 7,mem_00ff          ;f876  ff ff    
    clb 7,mem_00ff          ;f878  ff ff    
    clb 7,mem_00ff          ;f87a  ff ff    
    clb 7,mem_00ff          ;f87c  ff ff    
    clb 7,mem_00ff          ;f87e  ff ff    
    clb 7,mem_00ff          ;f880  ff ff    
    clb 7,mem_00ff          ;f882  ff ff    
    clb 7,mem_00ff          ;f884  ff ff    
    clb 7,mem_00ff          ;f886  ff ff    
    clb 7,mem_00ff          ;f888  ff ff    
    clb 7,mem_00ff          ;f88a  ff ff    
    clb 7,mem_00ff          ;f88c  ff ff    
    clb 7,mem_00ff          ;f88e  ff ff    
    clb 7,mem_00ff          ;f890  ff ff    
    clb 7,mem_00ff          ;f892  ff ff    
    clb 7,mem_00ff          ;f894  ff ff    
    clb 7,mem_00ff          ;f896  ff ff    
    clb 7,mem_00ff          ;f898  ff ff    
    clb 7,mem_00ff          ;f89a  ff ff    
    clb 7,mem_00ff          ;f89c  ff ff    
    clb 7,mem_00ff          ;f89e  ff ff    
    clb 7,mem_00ff          ;f8a0  ff ff    
    clb 7,mem_00ff          ;f8a2  ff ff    
    clb 7,mem_00ff          ;f8a4  ff ff    
    clb 7,mem_00ff          ;f8a6  ff ff    
    clb 7,mem_00ff          ;f8a8  ff ff    
    clb 7,mem_00ff          ;f8aa  ff ff    
    clb 7,mem_00ff          ;f8ac  ff ff    
    clb 7,mem_00ff          ;f8ae  ff ff    
    clb 7,mem_00ff          ;f8b0  ff ff    
    clb 7,mem_00ff          ;f8b2  ff ff    
    clb 7,mem_00ff          ;f8b4  ff ff    
    clb 7,mem_00ff          ;f8b6  ff ff    
    clb 7,mem_00ff          ;f8b8  ff ff    
    clb 7,mem_00ff          ;f8ba  ff ff    
    clb 7,mem_00ff          ;f8bc  ff ff    
    clb 7,mem_00ff          ;f8be  ff ff    
    clb 7,mem_00ff          ;f8c0  ff ff    
    clb 7,mem_00ff          ;f8c2  ff ff    
    clb 7,mem_00ff          ;f8c4  ff ff    
    clb 7,mem_00ff          ;f8c6  ff ff    
    clb 7,mem_00ff          ;f8c8  ff ff    
    clb 7,mem_00ff          ;f8ca  ff ff    
    clb 7,mem_00ff          ;f8cc  ff ff    
    clb 7,mem_00ff          ;f8ce  ff ff    
    clb 7,mem_00ff          ;f8d0  ff ff    
    clb 7,mem_00ff          ;f8d2  ff ff    
    clb 7,mem_00ff          ;f8d4  ff ff    
    clb 7,mem_00ff          ;f8d6  ff ff    
    clb 7,mem_00ff          ;f8d8  ff ff    
    clb 7,mem_00ff          ;f8da  ff ff    
    clb 7,mem_00ff          ;f8dc  ff ff    
    clb 7,mem_00ff          ;f8de  ff ff    
    clb 7,mem_00ff          ;f8e0  ff ff    
    clb 7,mem_00ff          ;f8e2  ff ff    
    clb 7,mem_00ff          ;f8e4  ff ff    
    clb 7,mem_00ff          ;f8e6  ff ff    
    clb 7,mem_00ff          ;f8e8  ff ff    
    clb 7,mem_00ff          ;f8ea  ff ff    
    clb 7,mem_00ff          ;f8ec  ff ff    
    clb 7,mem_00ff          ;f8ee  ff ff    
    clb 7,mem_00ff          ;f8f0  ff ff    
    clb 7,mem_00ff          ;f8f2  ff ff    
    clb 7,mem_00ff          ;f8f4  ff ff    
    clb 7,mem_00ff          ;f8f6  ff ff    
    clb 7,mem_00ff          ;f8f8  ff ff    
    clb 7,mem_00ff          ;f8fa  ff ff    
    clb 7,mem_00ff          ;f8fc  ff ff    
    clb 7,mem_00ff          ;f8fe  ff ff    
    clb 7,mem_00ff          ;f900  ff ff    
    clb 7,mem_00ff          ;f902  ff ff    
    clb 7,mem_00ff          ;f904  ff ff    
    clb 7,mem_00ff          ;f906  ff ff    
    clb 7,mem_00ff          ;f908  ff ff    
    clb 7,mem_00ff          ;f90a  ff ff    
    clb 7,mem_00ff          ;f90c  ff ff    
    clb 7,mem_00ff          ;f90e  ff ff    
    clb 7,mem_00ff          ;f910  ff ff    
    clb 7,mem_00ff          ;f912  ff ff    
    clb 7,mem_00ff          ;f914  ff ff    
    clb 7,mem_00ff          ;f916  ff ff    
    clb 7,mem_00ff          ;f918  ff ff    
    clb 7,mem_00ff          ;f91a  ff ff    
    clb 7,mem_00ff          ;f91c  ff ff    
    clb 7,mem_00ff          ;f91e  ff ff    
    clb 7,mem_00ff          ;f920  ff ff    
    clb 7,mem_00ff          ;f922  ff ff    
    clb 7,mem_00ff          ;f924  ff ff    
    clb 7,mem_00ff          ;f926  ff ff    
    clb 7,mem_00ff          ;f928  ff ff    
    clb 7,mem_00ff          ;f92a  ff ff    
    clb 7,mem_00ff          ;f92c  ff ff    
    clb 7,mem_00ff          ;f92e  ff ff    
    clb 7,mem_00ff          ;f930  ff ff    
    clb 7,mem_00ff          ;f932  ff ff    
    clb 7,mem_00ff          ;f934  ff ff    
    clb 7,mem_00ff          ;f936  ff ff    
    clb 7,mem_00ff          ;f938  ff ff    
    clb 7,mem_00ff          ;f93a  ff ff    
    clb 7,mem_00ff          ;f93c  ff ff    
    clb 7,mem_00ff          ;f93e  ff ff    
    clb 7,mem_00ff          ;f940  ff ff    
    clb 7,mem_00ff          ;f942  ff ff    
    clb 7,mem_00ff          ;f944  ff ff    
    clb 7,mem_00ff          ;f946  ff ff    
    clb 7,mem_00ff          ;f948  ff ff    
    clb 7,mem_00ff          ;f94a  ff ff    
    clb 7,mem_00ff          ;f94c  ff ff    
    clb 7,mem_00ff          ;f94e  ff ff    
    clb 7,mem_00ff          ;f950  ff ff    
    clb 7,mem_00ff          ;f952  ff ff    
    clb 7,mem_00ff          ;f954  ff ff    
    clb 7,mem_00ff          ;f956  ff ff    
    clb 7,mem_00ff          ;f958  ff ff    
    clb 7,mem_00ff          ;f95a  ff ff    
    clb 7,mem_00ff          ;f95c  ff ff    
    clb 7,mem_00ff          ;f95e  ff ff    
    clb 7,mem_00ff          ;f960  ff ff    
    clb 7,mem_00ff          ;f962  ff ff    
    clb 7,mem_00ff          ;f964  ff ff    
    clb 7,mem_00ff          ;f966  ff ff    
    clb 7,mem_00ff          ;f968  ff ff    
    clb 7,mem_00ff          ;f96a  ff ff    
    clb 7,mem_00ff          ;f96c  ff ff    
    clb 7,mem_00ff          ;f96e  ff ff    
    clb 7,mem_00ff          ;f970  ff ff    
    clb 7,mem_00ff          ;f972  ff ff    
    clb 7,mem_00ff          ;f974  ff ff    
    clb 7,mem_00ff          ;f976  ff ff    
    clb 7,mem_00ff          ;f978  ff ff    
    clb 7,mem_00ff          ;f97a  ff ff    
    clb 7,mem_00ff          ;f97c  ff ff    
    clb 7,mem_00ff          ;f97e  ff ff    
    clb 7,mem_00ff          ;f980  ff ff    
    clb 7,mem_00ff          ;f982  ff ff    
    clb 7,mem_00ff          ;f984  ff ff    
    clb 7,mem_00ff          ;f986  ff ff    
    clb 7,mem_00ff          ;f988  ff ff    
    clb 7,mem_00ff          ;f98a  ff ff    
    clb 7,mem_00ff          ;f98c  ff ff    
    clb 7,mem_00ff          ;f98e  ff ff    
    clb 7,mem_00ff          ;f990  ff ff    
    clb 7,mem_00ff          ;f992  ff ff    
    clb 7,mem_00ff          ;f994  ff ff    
    clb 7,mem_00ff          ;f996  ff ff    
    clb 7,mem_00ff          ;f998  ff ff    
    clb 7,mem_00ff          ;f99a  ff ff    
    clb 7,mem_00ff          ;f99c  ff ff    
    clb 7,mem_00ff          ;f99e  ff ff    
    clb 7,mem_00ff          ;f9a0  ff ff    
    clb 7,mem_00ff          ;f9a2  ff ff    
    clb 7,mem_00ff          ;f9a4  ff ff    
    clb 7,mem_00ff          ;f9a6  ff ff    
    clb 7,mem_00ff          ;f9a8  ff ff    
    clb 7,mem_00ff          ;f9aa  ff ff    
    clb 7,mem_00ff          ;f9ac  ff ff    
    clb 7,mem_00ff          ;f9ae  ff ff    
    clb 7,mem_00ff          ;f9b0  ff ff    
    clb 7,mem_00ff          ;f9b2  ff ff    
    clb 7,mem_00ff          ;f9b4  ff ff    
    clb 7,mem_00ff          ;f9b6  ff ff    
    clb 7,mem_00ff          ;f9b8  ff ff    
    clb 7,mem_00ff          ;f9ba  ff ff    
    clb 7,mem_00ff          ;f9bc  ff ff    
    clb 7,mem_00ff          ;f9be  ff ff    
    clb 7,mem_00ff          ;f9c0  ff ff    
    clb 7,mem_00ff          ;f9c2  ff ff    
    clb 7,mem_00ff          ;f9c4  ff ff    
    clb 7,mem_00ff          ;f9c6  ff ff    
    clb 7,mem_00ff          ;f9c8  ff ff    
    clb 7,mem_00ff          ;f9ca  ff ff    
    clb 7,mem_00ff          ;f9cc  ff ff    
    clb 7,mem_00ff          ;f9ce  ff ff    
    clb 7,mem_00ff          ;f9d0  ff ff    
    clb 7,mem_00ff          ;f9d2  ff ff    
    clb 7,mem_00ff          ;f9d4  ff ff    
    clb 7,mem_00ff          ;f9d6  ff ff    
    clb 7,mem_00ff          ;f9d8  ff ff    
    clb 7,mem_00ff          ;f9da  ff ff    
    clb 7,mem_00ff          ;f9dc  ff ff    
    clb 7,mem_00ff          ;f9de  ff ff    
    clb 7,mem_00ff          ;f9e0  ff ff    
    clb 7,mem_00ff          ;f9e2  ff ff    
    clb 7,mem_00ff          ;f9e4  ff ff    
    clb 7,mem_00ff          ;f9e6  ff ff    
    clb 7,mem_00ff          ;f9e8  ff ff    
    clb 7,mem_00ff          ;f9ea  ff ff    
    clb 7,mem_00ff          ;f9ec  ff ff    
    clb 7,mem_00ff          ;f9ee  ff ff    
    clb 7,mem_00ff          ;f9f0  ff ff    
    clb 7,mem_00ff          ;f9f2  ff ff    
    clb 7,mem_00ff          ;f9f4  ff ff    
    clb 7,mem_00ff          ;f9f6  ff ff    
    clb 7,mem_00ff          ;f9f8  ff ff    
    clb 7,mem_00ff          ;f9fa  ff ff    
    clb 7,mem_00ff          ;f9fc  ff ff    
    clb 7,mem_00ff          ;f9fe  ff ff    
    clb 7,mem_00ff          ;fa00  ff ff    
    clb 7,mem_00ff          ;fa02  ff ff    
    clb 7,mem_00ff          ;fa04  ff ff    
    clb 7,mem_00ff          ;fa06  ff ff    
    clb 7,mem_00ff          ;fa08  ff ff    
    clb 7,mem_00ff          ;fa0a  ff ff    
    clb 7,mem_00ff          ;fa0c  ff ff    
    clb 7,mem_00ff          ;fa0e  ff ff    
    clb 7,mem_00ff          ;fa10  ff ff    
    clb 7,mem_00ff          ;fa12  ff ff    
    clb 7,mem_00ff          ;fa14  ff ff    
    clb 7,mem_00ff          ;fa16  ff ff    
    clb 7,mem_00ff          ;fa18  ff ff    
    clb 7,mem_00ff          ;fa1a  ff ff    
    clb 7,mem_00ff          ;fa1c  ff ff    
    clb 7,mem_00ff          ;fa1e  ff ff    
    clb 7,mem_00ff          ;fa20  ff ff    
    clb 7,mem_00ff          ;fa22  ff ff    
    clb 7,mem_00ff          ;fa24  ff ff    
    clb 7,mem_00ff          ;fa26  ff ff    
    clb 7,mem_00ff          ;fa28  ff ff    
    clb 7,mem_00ff          ;fa2a  ff ff    
    clb 7,mem_00ff          ;fa2c  ff ff    
    clb 7,mem_00ff          ;fa2e  ff ff    
    clb 7,mem_00ff          ;fa30  ff ff    
    clb 7,mem_00ff          ;fa32  ff ff    
    clb 7,mem_00ff          ;fa34  ff ff    
    clb 7,mem_00ff          ;fa36  ff ff    
    clb 7,mem_00ff          ;fa38  ff ff    
    clb 7,mem_00ff          ;fa3a  ff ff    
    clb 7,mem_00ff          ;fa3c  ff ff    
    clb 7,mem_00ff          ;fa3e  ff ff    
    clb 7,mem_00ff          ;fa40  ff ff    
    clb 7,mem_00ff          ;fa42  ff ff    
    clb 7,mem_00ff          ;fa44  ff ff    
    clb 7,mem_00ff          ;fa46  ff ff    
    clb 7,mem_00ff          ;fa48  ff ff    
    clb 7,mem_00ff          ;fa4a  ff ff    
    clb 7,mem_00ff          ;fa4c  ff ff    
    clb 7,mem_00ff          ;fa4e  ff ff    
    clb 7,mem_00ff          ;fa50  ff ff    
    clb 7,mem_00ff          ;fa52  ff ff    
    clb 7,mem_00ff          ;fa54  ff ff    
    clb 7,mem_00ff          ;fa56  ff ff    
    clb 7,mem_00ff          ;fa58  ff ff    
    clb 7,mem_00ff          ;fa5a  ff ff    
    clb 7,mem_00ff          ;fa5c  ff ff    
    clb 7,mem_00ff          ;fa5e  ff ff    
    clb 7,mem_00ff          ;fa60  ff ff    
    clb 7,mem_00ff          ;fa62  ff ff    
    clb 7,mem_00ff          ;fa64  ff ff    
    clb 7,mem_00ff          ;fa66  ff ff    
    clb 7,mem_00ff          ;fa68  ff ff    
    clb 7,mem_00ff          ;fa6a  ff ff    
    clb 7,mem_00ff          ;fa6c  ff ff    
    clb 7,mem_00ff          ;fa6e  ff ff    
    clb 7,mem_00ff          ;fa70  ff ff    
    clb 7,mem_00ff          ;fa72  ff ff    
    clb 7,mem_00ff          ;fa74  ff ff    
    clb 7,mem_00ff          ;fa76  ff ff    
    clb 7,mem_00ff          ;fa78  ff ff    
    clb 7,mem_00ff          ;fa7a  ff ff    
    clb 7,mem_00ff          ;fa7c  ff ff    
    clb 7,mem_00ff          ;fa7e  ff ff    
    clb 7,mem_00ff          ;fa80  ff ff    
    clb 7,mem_00ff          ;fa82  ff ff    
    clb 7,mem_00ff          ;fa84  ff ff    
    clb 7,mem_00ff          ;fa86  ff ff    
    clb 7,mem_00ff          ;fa88  ff ff    
    clb 7,mem_00ff          ;fa8a  ff ff    
    clb 7,mem_00ff          ;fa8c  ff ff    
    clb 7,mem_00ff          ;fa8e  ff ff    
    clb 7,mem_00ff          ;fa90  ff ff    
    clb 7,mem_00ff          ;fa92  ff ff    
    clb 7,mem_00ff          ;fa94  ff ff    
    clb 7,mem_00ff          ;fa96  ff ff    
    clb 7,mem_00ff          ;fa98  ff ff    
    clb 7,mem_00ff          ;fa9a  ff ff    
    clb 7,mem_00ff          ;fa9c  ff ff    
    clb 7,mem_00ff          ;fa9e  ff ff    
    clb 7,mem_00ff          ;faa0  ff ff    
    clb 7,mem_00ff          ;faa2  ff ff    
    clb 7,mem_00ff          ;faa4  ff ff    
    clb 7,mem_00ff          ;faa6  ff ff    
    clb 7,mem_00ff          ;faa8  ff ff    
    clb 7,mem_00ff          ;faaa  ff ff    
    clb 7,mem_00ff          ;faac  ff ff    
    clb 7,mem_00ff          ;faae  ff ff    
    clb 7,mem_00ff          ;fab0  ff ff    
    clb 7,mem_00ff          ;fab2  ff ff    
    clb 7,mem_00ff          ;fab4  ff ff    
    clb 7,mem_00ff          ;fab6  ff ff    
    clb 7,mem_00ff          ;fab8  ff ff    
    clb 7,mem_00ff          ;faba  ff ff    
    clb 7,mem_00ff          ;fabc  ff ff    
    clb 7,mem_00ff          ;fabe  ff ff    
    clb 7,mem_00ff          ;fac0  ff ff    
    clb 7,mem_00ff          ;fac2  ff ff    
    clb 7,mem_00ff          ;fac4  ff ff    
    clb 7,mem_00ff          ;fac6  ff ff    
    clb 7,mem_00ff          ;fac8  ff ff    
    clb 7,mem_00ff          ;faca  ff ff    
    clb 7,mem_00ff          ;facc  ff ff    
    clb 7,mem_00ff          ;face  ff ff    
    clb 7,mem_00ff          ;fad0  ff ff    
    clb 7,mem_00ff          ;fad2  ff ff    
    clb 7,mem_00ff          ;fad4  ff ff    
    clb 7,mem_00ff          ;fad6  ff ff    
    clb 7,mem_00ff          ;fad8  ff ff    
    clb 7,mem_00ff          ;fada  ff ff    
    clb 7,mem_00ff          ;fadc  ff ff    
    clb 7,mem_00ff          ;fade  ff ff    
    clb 7,mem_00ff          ;fae0  ff ff    
    clb 7,mem_00ff          ;fae2  ff ff    
    clb 7,mem_00ff          ;fae4  ff ff    
    clb 7,mem_00ff          ;fae6  ff ff    
    clb 7,mem_00ff          ;fae8  ff ff    
    clb 7,mem_00ff          ;faea  ff ff    
    clb 7,mem_00ff          ;faec  ff ff    
    clb 7,mem_00ff          ;faee  ff ff    
    clb 7,mem_00ff          ;faf0  ff ff    
    clb 7,mem_00ff          ;faf2  ff ff    
    clb 7,mem_00ff          ;faf4  ff ff    
    clb 7,mem_00ff          ;faf6  ff ff    
    clb 7,mem_00ff          ;faf8  ff ff    
    clb 7,mem_00ff          ;fafa  ff ff    
    clb 7,mem_00ff          ;fafc  ff ff    
    clb 7,mem_00ff          ;fafe  ff ff    
    clb 7,mem_00ff          ;fb00  ff ff    
    clb 7,mem_00ff          ;fb02  ff ff    
    clb 7,mem_00ff          ;fb04  ff ff    
    clb 7,mem_00ff          ;fb06  ff ff    
    clb 7,mem_00ff          ;fb08  ff ff    
    clb 7,mem_00ff          ;fb0a  ff ff    
    clb 7,mem_00ff          ;fb0c  ff ff    
    clb 7,mem_00ff          ;fb0e  ff ff    
    clb 7,mem_00ff          ;fb10  ff ff    
    clb 7,mem_00ff          ;fb12  ff ff    
    clb 7,mem_00ff          ;fb14  ff ff    
    clb 7,mem_00ff          ;fb16  ff ff    
    clb 7,mem_00ff          ;fb18  ff ff    
    clb 7,mem_00ff          ;fb1a  ff ff    
    clb 7,mem_00ff          ;fb1c  ff ff    
    clb 7,mem_00ff          ;fb1e  ff ff    
    clb 7,mem_00ff          ;fb20  ff ff    
    clb 7,mem_00ff          ;fb22  ff ff    
    clb 7,mem_00ff          ;fb24  ff ff    
    clb 7,mem_00ff          ;fb26  ff ff    
    clb 7,mem_00ff          ;fb28  ff ff    
    clb 7,mem_00ff          ;fb2a  ff ff    
    clb 7,mem_00ff          ;fb2c  ff ff    
    clb 7,mem_00ff          ;fb2e  ff ff    
    clb 7,mem_00ff          ;fb30  ff ff    
    clb 7,mem_00ff          ;fb32  ff ff    
    clb 7,mem_00ff          ;fb34  ff ff    
    clb 7,mem_00ff          ;fb36  ff ff    
    clb 7,mem_00ff          ;fb38  ff ff    
    clb 7,mem_00ff          ;fb3a  ff ff    
    clb 7,mem_00ff          ;fb3c  ff ff    
    clb 7,mem_00ff          ;fb3e  ff ff    
    clb 7,mem_00ff          ;fb40  ff ff    
    clb 7,mem_00ff          ;fb42  ff ff    
    clb 7,mem_00ff          ;fb44  ff ff    
    clb 7,mem_00ff          ;fb46  ff ff    
    clb 7,mem_00ff          ;fb48  ff ff    
    clb 7,mem_00ff          ;fb4a  ff ff    
    clb 7,mem_00ff          ;fb4c  ff ff    
    clb 7,mem_00ff          ;fb4e  ff ff    
    clb 7,mem_00ff          ;fb50  ff ff    
    clb 7,mem_00ff          ;fb52  ff ff    
    clb 7,mem_00ff          ;fb54  ff ff    
    clb 7,mem_00ff          ;fb56  ff ff    
    clb 7,mem_00ff          ;fb58  ff ff    
    clb 7,mem_00ff          ;fb5a  ff ff    
    clb 7,mem_00ff          ;fb5c  ff ff    
    clb 7,mem_00ff          ;fb5e  ff ff    
    clb 7,mem_00ff          ;fb60  ff ff    
    clb 7,mem_00ff          ;fb62  ff ff    
    clb 7,mem_00ff          ;fb64  ff ff    
    clb 7,mem_00ff          ;fb66  ff ff    
    clb 7,mem_00ff          ;fb68  ff ff    
    clb 7,mem_00ff          ;fb6a  ff ff    
    clb 7,mem_00ff          ;fb6c  ff ff    
    clb 7,mem_00ff          ;fb6e  ff ff    
    clb 7,mem_00ff          ;fb70  ff ff    
    clb 7,mem_00ff          ;fb72  ff ff    
    clb 7,mem_00ff          ;fb74  ff ff    
    clb 7,mem_00ff          ;fb76  ff ff    
    clb 7,mem_00ff          ;fb78  ff ff    
    clb 7,mem_00ff          ;fb7a  ff ff    
    clb 7,mem_00ff          ;fb7c  ff ff    
    clb 7,mem_00ff          ;fb7e  ff ff    
    clb 7,mem_00ff          ;fb80  ff ff    
    clb 7,mem_00ff          ;fb82  ff ff    
    clb 7,mem_00ff          ;fb84  ff ff    
    clb 7,mem_00ff          ;fb86  ff ff    
    clb 7,mem_00ff          ;fb88  ff ff    
    clb 7,mem_00ff          ;fb8a  ff ff    
    clb 7,mem_00ff          ;fb8c  ff ff    
    clb 7,mem_00ff          ;fb8e  ff ff    
    clb 7,mem_00ff          ;fb90  ff ff    
    clb 7,mem_00ff          ;fb92  ff ff    
    clb 7,mem_00ff          ;fb94  ff ff    
    clb 7,mem_00ff          ;fb96  ff ff    
    clb 7,mem_00ff          ;fb98  ff ff    
    clb 7,mem_00ff          ;fb9a  ff ff    
    clb 7,mem_00ff          ;fb9c  ff ff    
    clb 7,mem_00ff          ;fb9e  ff ff    
    clb 7,mem_00ff          ;fba0  ff ff    
    clb 7,mem_00ff          ;fba2  ff ff    
    clb 7,mem_00ff          ;fba4  ff ff    
    clb 7,mem_00ff          ;fba6  ff ff    
    clb 7,mem_00ff          ;fba8  ff ff    
    clb 7,mem_00ff          ;fbaa  ff ff    
    clb 7,mem_00ff          ;fbac  ff ff    
    clb 7,mem_00ff          ;fbae  ff ff    
    clb 7,mem_00ff          ;fbb0  ff ff    
    clb 7,mem_00ff          ;fbb2  ff ff    
    clb 7,mem_00ff          ;fbb4  ff ff    
    clb 7,mem_00ff          ;fbb6  ff ff    
    clb 7,mem_00ff          ;fbb8  ff ff    
    clb 7,mem_00ff          ;fbba  ff ff    
    clb 7,mem_00ff          ;fbbc  ff ff    
    clb 7,mem_00ff          ;fbbe  ff ff    
    clb 7,mem_00ff          ;fbc0  ff ff    
    clb 7,mem_00ff          ;fbc2  ff ff    
    clb 7,mem_00ff          ;fbc4  ff ff    
    clb 7,mem_00ff          ;fbc6  ff ff    
    clb 7,mem_00ff          ;fbc8  ff ff    
    clb 7,mem_00ff          ;fbca  ff ff    
    clb 7,mem_00ff          ;fbcc  ff ff    
    clb 7,mem_00ff          ;fbce  ff ff    
    clb 7,mem_00ff          ;fbd0  ff ff    
    clb 7,mem_00ff          ;fbd2  ff ff    
    clb 7,mem_00ff          ;fbd4  ff ff    
    clb 7,mem_00ff          ;fbd6  ff ff    
    clb 7,mem_00ff          ;fbd8  ff ff    
    clb 7,mem_00ff          ;fbda  ff ff    
    clb 7,mem_00ff          ;fbdc  ff ff    
    clb 7,mem_00ff          ;fbde  ff ff    
    clb 7,mem_00ff          ;fbe0  ff ff    
    clb 7,mem_00ff          ;fbe2  ff ff    
    clb 7,mem_00ff          ;fbe4  ff ff    
    clb 7,mem_00ff          ;fbe6  ff ff    
    clb 7,mem_00ff          ;fbe8  ff ff    
    clb 7,mem_00ff          ;fbea  ff ff    
    clb 7,mem_00ff          ;fbec  ff ff    
    clb 7,mem_00ff          ;fbee  ff ff    
    clb 7,mem_00ff          ;fbf0  ff ff    
    clb 7,mem_00ff          ;fbf2  ff ff    
    clb 7,mem_00ff          ;fbf4  ff ff    
    clb 7,mem_00ff          ;fbf6  ff ff    
    clb 7,mem_00ff          ;fbf8  ff ff    
    clb 7,mem_00ff          ;fbfa  ff ff    
    clb 7,mem_00ff          ;fbfc  ff ff    
    clb 7,mem_00ff          ;fbfe  ff ff    
    clb 7,mem_00ff          ;fc00  ff ff    
    clb 7,mem_00ff          ;fc02  ff ff    
    clb 7,mem_00ff          ;fc04  ff ff    
    clb 7,mem_00ff          ;fc06  ff ff    
    clb 7,mem_00ff          ;fc08  ff ff    
    clb 7,mem_00ff          ;fc0a  ff ff    
    clb 7,mem_00ff          ;fc0c  ff ff    
    clb 7,mem_00ff          ;fc0e  ff ff    
    clb 7,mem_00ff          ;fc10  ff ff    
    clb 7,mem_00ff          ;fc12  ff ff    
    clb 7,mem_00ff          ;fc14  ff ff    
    clb 7,mem_00ff          ;fc16  ff ff    
    clb 7,mem_00ff          ;fc18  ff ff    
    clb 7,mem_00ff          ;fc1a  ff ff    
    clb 7,mem_00ff          ;fc1c  ff ff    
    clb 7,mem_00ff          ;fc1e  ff ff    
    clb 7,mem_00ff          ;fc20  ff ff    
    clb 7,mem_00ff          ;fc22  ff ff    
    clb 7,mem_00ff          ;fc24  ff ff    
    clb 7,mem_00ff          ;fc26  ff ff    
    clb 7,mem_00ff          ;fc28  ff ff    
    clb 7,mem_00ff          ;fc2a  ff ff    
    clb 7,mem_00ff          ;fc2c  ff ff    
    clb 7,mem_00ff          ;fc2e  ff ff    
    clb 7,mem_00ff          ;fc30  ff ff    
    clb 7,mem_00ff          ;fc32  ff ff    
    clb 7,mem_00ff          ;fc34  ff ff    
    clb 7,mem_00ff          ;fc36  ff ff    
    clb 7,mem_00ff          ;fc38  ff ff    
    clb 7,mem_00ff          ;fc3a  ff ff    
    clb 7,mem_00ff          ;fc3c  ff ff    
    clb 7,mem_00ff          ;fc3e  ff ff    
    clb 7,mem_00ff          ;fc40  ff ff    
    clb 7,mem_00ff          ;fc42  ff ff    
    clb 7,mem_00ff          ;fc44  ff ff    
    clb 7,mem_00ff          ;fc46  ff ff    
    clb 7,mem_00ff          ;fc48  ff ff    
    clb 7,mem_00ff          ;fc4a  ff ff    
    clb 7,mem_00ff          ;fc4c  ff ff    
    clb 7,mem_00ff          ;fc4e  ff ff    
    clb 7,mem_00ff          ;fc50  ff ff    
    clb 7,mem_00ff          ;fc52  ff ff    
    clb 7,mem_00ff          ;fc54  ff ff    
    clb 7,mem_00ff          ;fc56  ff ff    
    clb 7,mem_00ff          ;fc58  ff ff    
    clb 7,mem_00ff          ;fc5a  ff ff    
    clb 7,mem_00ff          ;fc5c  ff ff    
    clb 7,mem_00ff          ;fc5e  ff ff    
    clb 7,mem_00ff          ;fc60  ff ff    
    clb 7,mem_00ff          ;fc62  ff ff    
    clb 7,mem_00ff          ;fc64  ff ff    
    clb 7,mem_00ff          ;fc66  ff ff    
    clb 7,mem_00ff          ;fc68  ff ff    
    clb 7,mem_00ff          ;fc6a  ff ff    
    clb 7,mem_00ff          ;fc6c  ff ff    
    clb 7,mem_00ff          ;fc6e  ff ff    
    clb 7,mem_00ff          ;fc70  ff ff    
    clb 7,mem_00ff          ;fc72  ff ff    
    clb 7,mem_00ff          ;fc74  ff ff    
    clb 7,mem_00ff          ;fc76  ff ff    
    clb 7,mem_00ff          ;fc78  ff ff    
    clb 7,mem_00ff          ;fc7a  ff ff    
    clb 7,mem_00ff          ;fc7c  ff ff    
    clb 7,mem_00ff          ;fc7e  ff ff    
    clb 7,mem_00ff          ;fc80  ff ff    
    clb 7,mem_00ff          ;fc82  ff ff    
    clb 7,mem_00ff          ;fc84  ff ff    
    clb 7,mem_00ff          ;fc86  ff ff    
    clb 7,mem_00ff          ;fc88  ff ff    
    clb 7,mem_00ff          ;fc8a  ff ff    
    clb 7,mem_00ff          ;fc8c  ff ff    
    clb 7,mem_00ff          ;fc8e  ff ff    
    clb 7,mem_00ff          ;fc90  ff ff    
    clb 7,mem_00ff          ;fc92  ff ff    
    clb 7,mem_00ff          ;fc94  ff ff    
    clb 7,mem_00ff          ;fc96  ff ff    
    clb 7,mem_00ff          ;fc98  ff ff    
    clb 7,mem_00ff          ;fc9a  ff ff    
    clb 7,mem_00ff          ;fc9c  ff ff    
    clb 7,mem_00ff          ;fc9e  ff ff    
    clb 7,mem_00ff          ;fca0  ff ff    
    clb 7,mem_00ff          ;fca2  ff ff    
    clb 7,mem_00ff          ;fca4  ff ff    
    clb 7,mem_00ff          ;fca6  ff ff    
    clb 7,mem_00ff          ;fca8  ff ff    
    clb 7,mem_00ff          ;fcaa  ff ff    
    clb 7,mem_00ff          ;fcac  ff ff    
    clb 7,mem_00ff          ;fcae  ff ff    
    clb 7,mem_00ff          ;fcb0  ff ff    
    clb 7,mem_00ff          ;fcb2  ff ff    
    clb 7,mem_00ff          ;fcb4  ff ff    
    clb 7,mem_00ff          ;fcb6  ff ff    
    clb 7,mem_00ff          ;fcb8  ff ff    
    clb 7,mem_00ff          ;fcba  ff ff    
    clb 7,mem_00ff          ;fcbc  ff ff    
    clb 7,mem_00ff          ;fcbe  ff ff    
    clb 7,mem_00ff          ;fcc0  ff ff    
    clb 7,mem_00ff          ;fcc2  ff ff    
    clb 7,mem_00ff          ;fcc4  ff ff    
    clb 7,mem_00ff          ;fcc6  ff ff    
    clb 7,mem_00ff          ;fcc8  ff ff    
    clb 7,mem_00ff          ;fcca  ff ff    
    clb 7,mem_00ff          ;fccc  ff ff    
    clb 7,mem_00ff          ;fcce  ff ff    
    clb 7,mem_00ff          ;fcd0  ff ff    
    clb 7,mem_00ff          ;fcd2  ff ff    
    clb 7,mem_00ff          ;fcd4  ff ff    
    clb 7,mem_00ff          ;fcd6  ff ff    
    clb 7,mem_00ff          ;fcd8  ff ff    
    clb 7,mem_00ff          ;fcda  ff ff    
    clb 7,mem_00ff          ;fcdc  ff ff    
    clb 7,mem_00ff          ;fcde  ff ff    
    clb 7,mem_00ff          ;fce0  ff ff    
    clb 7,mem_00ff          ;fce2  ff ff    
    clb 7,mem_00ff          ;fce4  ff ff    
    clb 7,mem_00ff          ;fce6  ff ff    
    clb 7,mem_00ff          ;fce8  ff ff    
    clb 7,mem_00ff          ;fcea  ff ff    
    clb 7,mem_00ff          ;fcec  ff ff    
    clb 7,mem_00ff          ;fcee  ff ff    
    clb 7,mem_00ff          ;fcf0  ff ff    
    clb 7,mem_00ff          ;fcf2  ff ff    
    clb 7,mem_00ff          ;fcf4  ff ff    
    clb 7,mem_00ff          ;fcf6  ff ff    
    clb 7,mem_00ff          ;fcf8  ff ff    
    clb 7,mem_00ff          ;fcfa  ff ff    
    clb 7,mem_00ff          ;fcfc  ff ff    
    clb 7,mem_00ff          ;fcfe  ff ff    
    clb 7,mem_00ff          ;fd00  ff ff    
    clb 7,mem_00ff          ;fd02  ff ff    
    clb 7,mem_00ff          ;fd04  ff ff    
    clb 7,mem_00ff          ;fd06  ff ff    
    clb 7,mem_00ff          ;fd08  ff ff    
    clb 7,mem_00ff          ;fd0a  ff ff    
    clb 7,mem_00ff          ;fd0c  ff ff    
    clb 7,mem_00ff          ;fd0e  ff ff    
    clb 7,mem_00ff          ;fd10  ff ff    
    clb 7,mem_00ff          ;fd12  ff ff    
    clb 7,mem_00ff          ;fd14  ff ff    
    clb 7,mem_00ff          ;fd16  ff ff    
    clb 7,mem_00ff          ;fd18  ff ff    
    clb 7,mem_00ff          ;fd1a  ff ff    
    clb 7,mem_00ff          ;fd1c  ff ff    
    clb 7,mem_00ff          ;fd1e  ff ff    
    clb 7,mem_00ff          ;fd20  ff ff    
    clb 7,mem_00ff          ;fd22  ff ff    
    clb 7,mem_00ff          ;fd24  ff ff    
    clb 7,mem_00ff          ;fd26  ff ff    
    clb 7,mem_00ff          ;fd28  ff ff    
    clb 7,mem_00ff          ;fd2a  ff ff    
    clb 7,mem_00ff          ;fd2c  ff ff    
    clb 7,mem_00ff          ;fd2e  ff ff    
    clb 7,mem_00ff          ;fd30  ff ff    
    clb 7,mem_00ff          ;fd32  ff ff    
    clb 7,mem_00ff          ;fd34  ff ff    
    clb 7,mem_00ff          ;fd36  ff ff    
    clb 7,mem_00ff          ;fd38  ff ff    
    clb 7,mem_00ff          ;fd3a  ff ff    
    clb 7,mem_00ff          ;fd3c  ff ff    
    clb 7,mem_00ff          ;fd3e  ff ff    
    clb 7,mem_00ff          ;fd40  ff ff    
    clb 7,mem_00ff          ;fd42  ff ff    
    clb 7,mem_00ff          ;fd44  ff ff    
    clb 7,mem_00ff          ;fd46  ff ff    
    clb 7,mem_00ff          ;fd48  ff ff    
    clb 7,mem_00ff          ;fd4a  ff ff    
    clb 7,mem_00ff          ;fd4c  ff ff    
    clb 7,mem_00ff          ;fd4e  ff ff    
    clb 7,mem_00ff          ;fd50  ff ff    
    clb 7,mem_00ff          ;fd52  ff ff    
    clb 7,mem_00ff          ;fd54  ff ff    
    clb 7,mem_00ff          ;fd56  ff ff    
    clb 7,mem_00ff          ;fd58  ff ff    
    clb 7,mem_00ff          ;fd5a  ff ff    
    clb 7,mem_00ff          ;fd5c  ff ff    
    clb 7,mem_00ff          ;fd5e  ff ff    
    clb 7,mem_00ff          ;fd60  ff ff    
    clb 7,mem_00ff          ;fd62  ff ff    
    clb 7,mem_00ff          ;fd64  ff ff    
    clb 7,mem_00ff          ;fd66  ff ff    
    clb 7,mem_00ff          ;fd68  ff ff    
    clb 7,mem_00ff          ;fd6a  ff ff    
    clb 7,mem_00ff          ;fd6c  ff ff    
    clb 7,mem_00ff          ;fd6e  ff ff    
    clb 7,mem_00ff          ;fd70  ff ff    
    clb 7,mem_00ff          ;fd72  ff ff    
    clb 7,mem_00ff          ;fd74  ff ff    
    clb 7,mem_00ff          ;fd76  ff ff    
    clb 7,mem_00ff          ;fd78  ff ff    
    clb 7,mem_00ff          ;fd7a  ff ff    
    clb 7,mem_00ff          ;fd7c  ff ff    
    clb 7,mem_00ff          ;fd7e  ff ff    
    clb 7,mem_00ff          ;fd80  ff ff    
    clb 7,mem_00ff          ;fd82  ff ff    
    clb 7,mem_00ff          ;fd84  ff ff    
    clb 7,mem_00ff          ;fd86  ff ff    
    clb 7,mem_00ff          ;fd88  ff ff    
    clb 7,mem_00ff          ;fd8a  ff ff    
    clb 7,mem_00ff          ;fd8c  ff ff    
    clb 7,mem_00ff          ;fd8e  ff ff    
    clb 7,mem_00ff          ;fd90  ff ff    
    clb 7,mem_00ff          ;fd92  ff ff    
    clb 7,mem_00ff          ;fd94  ff ff    
    clb 7,mem_00ff          ;fd96  ff ff    
    clb 7,mem_00ff          ;fd98  ff ff    
    clb 7,mem_00ff          ;fd9a  ff ff    
    clb 7,mem_00ff          ;fd9c  ff ff    
    clb 7,mem_00ff          ;fd9e  ff ff    
    clb 7,mem_00ff          ;fda0  ff ff    
    clb 7,mem_00ff          ;fda2  ff ff    
    clb 7,mem_00ff          ;fda4  ff ff    
    clb 7,mem_00ff          ;fda6  ff ff    
    clb 7,mem_00ff          ;fda8  ff ff    
    clb 7,mem_00ff          ;fdaa  ff ff    
    clb 7,mem_00ff          ;fdac  ff ff    
    clb 7,mem_00ff          ;fdae  ff ff    
    clb 7,mem_00ff          ;fdb0  ff ff    
    clb 7,mem_00ff          ;fdb2  ff ff    
    clb 7,mem_00ff          ;fdb4  ff ff    
    clb 7,mem_00ff          ;fdb6  ff ff    
    clb 7,mem_00ff          ;fdb8  ff ff    
    clb 7,mem_00ff          ;fdba  ff ff    
    clb 7,mem_00ff          ;fdbc  ff ff    
    clb 7,mem_00ff          ;fdbe  ff ff    
    clb 7,mem_00ff          ;fdc0  ff ff    
    clb 7,mem_00ff          ;fdc2  ff ff    
    clb 7,mem_00ff          ;fdc4  ff ff    
    clb 7,mem_00ff          ;fdc6  ff ff    
    clb 7,mem_00ff          ;fdc8  ff ff    
    clb 7,mem_00ff          ;fdca  ff ff    
    clb 7,mem_00ff          ;fdcc  ff ff    
    clb 7,mem_00ff          ;fdce  ff ff    
    clb 7,mem_00ff          ;fdd0  ff ff    
    clb 7,mem_00ff          ;fdd2  ff ff    
    clb 7,mem_00ff          ;fdd4  ff ff    
    clb 7,mem_00ff          ;fdd6  ff ff    
    clb 7,mem_00ff          ;fdd8  ff ff    
    clb 7,mem_00ff          ;fdda  ff ff    
    clb 7,mem_00ff          ;fddc  ff ff    
    clb 7,mem_00ff          ;fdde  ff ff    
    clb 7,mem_00ff          ;fde0  ff ff    
    clb 7,mem_00ff          ;fde2  ff ff    
    clb 7,mem_00ff          ;fde4  ff ff    
    clb 7,mem_00ff          ;fde6  ff ff    
    clb 7,mem_00ff          ;fde8  ff ff    
    clb 7,mem_00ff          ;fdea  ff ff    
    clb 7,mem_00ff          ;fdec  ff ff    
    clb 7,mem_00ff          ;fdee  ff ff    
    clb 7,mem_00ff          ;fdf0  ff ff    
    clb 7,mem_00ff          ;fdf2  ff ff    
    clb 7,mem_00ff          ;fdf4  ff ff    
    clb 7,mem_00ff          ;fdf6  ff ff    
    clb 7,mem_00ff          ;fdf8  ff ff    
    clb 7,mem_00ff          ;fdfa  ff ff    
    clb 7,mem_00ff          ;fdfc  ff ff    
    clb 7,mem_00ff          ;fdfe  ff ff    
    clb 7,mem_00ff          ;fe00  ff ff    
    clb 7,mem_00ff          ;fe02  ff ff    
    clb 7,mem_00ff          ;fe04  ff ff    
    clb 7,mem_00ff          ;fe06  ff ff    
    clb 7,mem_00ff          ;fe08  ff ff    
    clb 7,mem_00ff          ;fe0a  ff ff    
    clb 7,mem_00ff          ;fe0c  ff ff    
    clb 7,mem_00ff          ;fe0e  ff ff    
    clb 7,mem_00ff          ;fe10  ff ff    
    clb 7,mem_00ff          ;fe12  ff ff    
    clb 7,mem_00ff          ;fe14  ff ff    
    clb 7,mem_00ff          ;fe16  ff ff    
    clb 7,mem_00ff          ;fe18  ff ff    
    clb 7,mem_00ff          ;fe1a  ff ff    
    clb 7,mem_00ff          ;fe1c  ff ff    
    clb 7,mem_00ff          ;fe1e  ff ff    
    clb 7,mem_00ff          ;fe20  ff ff    
    clb 7,mem_00ff          ;fe22  ff ff    
    clb 7,mem_00ff          ;fe24  ff ff    
    clb 7,mem_00ff          ;fe26  ff ff    
    clb 7,mem_00ff          ;fe28  ff ff    
    clb 7,mem_00ff          ;fe2a  ff ff    
    clb 7,mem_00ff          ;fe2c  ff ff    
    clb 7,mem_00ff          ;fe2e  ff ff    
    clb 7,mem_00ff          ;fe30  ff ff    
    clb 7,mem_00ff          ;fe32  ff ff    
    clb 7,mem_00ff          ;fe34  ff ff    
    clb 7,mem_00ff          ;fe36  ff ff    
    clb 7,mem_00ff          ;fe38  ff ff    
    clb 7,mem_00ff          ;fe3a  ff ff    
    clb 7,mem_00ff          ;fe3c  ff ff    
    clb 7,mem_00ff          ;fe3e  ff ff    
    clb 7,mem_00ff          ;fe40  ff ff    
    clb 7,mem_00ff          ;fe42  ff ff    
    clb 7,mem_00ff          ;fe44  ff ff    
    clb 7,mem_00ff          ;fe46  ff ff    
    clb 7,mem_00ff          ;fe48  ff ff    
    clb 7,mem_00ff          ;fe4a  ff ff    
    clb 7,mem_00ff          ;fe4c  ff ff    
    clb 7,mem_00ff          ;fe4e  ff ff    
    clb 7,mem_00ff          ;fe50  ff ff    
    clb 7,mem_00ff          ;fe52  ff ff    
    clb 7,mem_00ff          ;fe54  ff ff    
    clb 7,mem_00ff          ;fe56  ff ff    
    clb 7,mem_00ff          ;fe58  ff ff    
    clb 7,mem_00ff          ;fe5a  ff ff    
    clb 7,mem_00ff          ;fe5c  ff ff    
    clb 7,mem_00ff          ;fe5e  ff ff    
    clb 7,mem_00ff          ;fe60  ff ff    
    clb 7,mem_00ff          ;fe62  ff ff    
    clb 7,mem_00ff          ;fe64  ff ff    
    clb 7,mem_00ff          ;fe66  ff ff    
    clb 7,mem_00ff          ;fe68  ff ff    
    clb 7,mem_00ff          ;fe6a  ff ff    
    clb 7,mem_00ff          ;fe6c  ff ff    
    clb 7,mem_00ff          ;fe6e  ff ff    
    clb 7,mem_00ff          ;fe70  ff ff    
    clb 7,mem_00ff          ;fe72  ff ff    
    clb 7,mem_00ff          ;fe74  ff ff    
    clb 7,mem_00ff          ;fe76  ff ff    
    clb 7,mem_00ff          ;fe78  ff ff    
    clb 7,mem_00ff          ;fe7a  ff ff    
    clb 7,mem_00ff          ;fe7c  ff ff    
    clb 7,mem_00ff          ;fe7e  ff ff    
    clb 7,mem_00ff          ;fe80  ff ff    
    clb 7,mem_00ff          ;fe82  ff ff    
    clb 7,mem_00ff          ;fe84  ff ff    
    clb 7,mem_00ff          ;fe86  ff ff    
    clb 7,mem_00ff          ;fe88  ff ff    
    clb 7,mem_00ff          ;fe8a  ff ff    
    clb 7,mem_00ff          ;fe8c  ff ff    
    clb 7,mem_00ff          ;fe8e  ff ff    
    clb 7,mem_00ff          ;fe90  ff ff    
    clb 7,mem_00ff          ;fe92  ff ff    
    clb 7,mem_00ff          ;fe94  ff ff    
    clb 7,mem_00ff          ;fe96  ff ff    
    clb 7,mem_00ff          ;fe98  ff ff    
    clb 7,mem_00ff          ;fe9a  ff ff    
    clb 7,mem_00ff          ;fe9c  ff ff    
    clb 7,mem_00ff          ;fe9e  ff ff    
    clb 7,mem_00ff          ;fea0  ff ff    
    clb 7,mem_00ff          ;fea2  ff ff    
    clb 7,mem_00ff          ;fea4  ff ff    
    clb 7,mem_00ff          ;fea6  ff ff    
    clb 7,mem_00ff          ;fea8  ff ff    
    clb 7,mem_00ff          ;feaa  ff ff    
    clb 7,mem_00ff          ;feac  ff ff    
    clb 7,mem_00ff          ;feae  ff ff    
    clb 7,mem_00ff          ;feb0  ff ff    
    clb 7,mem_00ff          ;feb2  ff ff    
    clb 7,mem_00ff          ;feb4  ff ff    
    clb 7,mem_00ff          ;feb6  ff ff    
    clb 7,mem_00ff          ;feb8  ff ff    
    clb 7,mem_00ff          ;feba  ff ff    
    clb 7,mem_00ff          ;febc  ff ff    
    clb 7,mem_00ff          ;febe  ff ff    
    clb 7,mem_00ff          ;fec0  ff ff    
    clb 7,mem_00ff          ;fec2  ff ff    
    clb 7,mem_00ff          ;fec4  ff ff    
    clb 7,mem_00ff          ;fec6  ff ff    
    clb 7,mem_00ff          ;fec8  ff ff    
    clb 7,mem_00ff          ;feca  ff ff    
    clb 7,mem_00ff          ;fecc  ff ff    
    clb 7,mem_00ff          ;fece  ff ff    
    clb 7,mem_00ff          ;fed0  ff ff    
    clb 7,mem_00ff          ;fed2  ff ff    
    clb 7,mem_00ff          ;fed4  ff ff    
    clb 7,mem_00ff          ;fed6  ff ff    
    clb 7,mem_00ff          ;fed8  ff ff    
    clb 7,mem_00ff          ;feda  ff ff    
    clb 7,mem_00ff          ;fedc  ff ff    
    clb 7,mem_00ff          ;fede  ff ff    
    clb 7,mem_00ff          ;fee0  ff ff    
    clb 7,mem_00ff          ;fee2  ff ff    
    clb 7,mem_00ff          ;fee4  ff ff    
    clb 7,mem_00ff          ;fee6  ff ff    
    clb 7,mem_00ff          ;fee8  ff ff    
    clb 7,mem_00ff          ;feea  ff ff    
    clb 7,mem_00ff          ;feec  ff ff    
    clb 7,mem_00ff          ;feee  ff ff    
    clb 7,mem_00ff          ;fef0  ff ff    
    clb 7,mem_00ff          ;fef2  ff ff    
    clb 7,mem_00ff          ;fef4  ff ff    
    clb 7,mem_00ff          ;fef6  ff ff    
    clb 7,mem_00ff          ;fef8  ff ff    
    clb 7,mem_00ff          ;fefa  ff ff    
    clb 7,mem_00ff          ;fefc  ff ff    
    clb 7,mem_00ff          ;fefe  ff ff    
    clb 7,mem_00ff          ;ff00  ff ff    
    clb 7,mem_00ff          ;ff02  ff ff    
    clb 7,mem_00ff          ;ff04  ff ff    
    clb 7,mem_00ff          ;ff06  ff ff    
    clb 7,mem_00ff          ;ff08  ff ff    
    clb 7,mem_00ff          ;ff0a  ff ff    
    clb 7,mem_00ff          ;ff0c  ff ff    
    clb 7,mem_00ff          ;ff0e  ff ff    
    clb 7,mem_00ff          ;ff10  ff ff    
    clb 7,mem_00ff          ;ff12  ff ff    
    clb 7,mem_00ff          ;ff14  ff ff    
    clb 7,mem_00ff          ;ff16  ff ff    
    clb 7,mem_00ff          ;ff18  ff ff    
    clb 7,mem_00ff          ;ff1a  ff ff    
    clb 7,mem_00ff          ;ff1c  ff ff    
    clb 7,mem_00ff          ;ff1e  ff ff    
    clb 7,mem_00ff          ;ff20  ff ff    
    clb 7,mem_00ff          ;ff22  ff ff    
    clb 7,mem_00ff          ;ff24  ff ff    
    clb 7,mem_00ff          ;ff26  ff ff    
    clb 7,mem_00ff          ;ff28  ff ff    
    clb 7,mem_00ff          ;ff2a  ff ff    
    clb 7,mem_00ff          ;ff2c  ff ff    
    clb 7,mem_00ff          ;ff2e  ff ff    
    clb 7,mem_00ff          ;ff30  ff ff    
    clb 7,mem_00ff          ;ff32  ff ff    
    clb 7,mem_00ff          ;ff34  ff ff    
    clb 7,mem_00ff          ;ff36  ff ff    
    clb 7,mem_00ff          ;ff38  ff ff    
    clb 7,mem_00ff          ;ff3a  ff ff    
    clb 7,mem_00ff          ;ff3c  ff ff    
    clb 7,mem_00ff          ;ff3e  ff ff    
    clb 7,mem_00ff          ;ff40  ff ff    
    clb 7,mem_00ff          ;ff42  ff ff    
    clb 7,mem_00ff          ;ff44  ff ff    
    clb 7,mem_00ff          ;ff46  ff ff    
    clb 7,mem_00ff          ;ff48  ff ff    
    clb 7,mem_00ff          ;ff4a  ff ff    
    clb 7,mem_00ff          ;ff4c  ff ff    
    clb 7,mem_00ff          ;ff4e  ff ff    
    clb 7,mem_00ff          ;ff50  ff ff    
    clb 7,mem_00ff          ;ff52  ff ff    
    clb 7,mem_00ff          ;ff54  ff ff    
    clb 7,mem_00ff          ;ff56  ff ff    
    clb 7,mem_00ff          ;ff58  ff ff    

    .word 0xffff            ;ff5a  ff ff       VECTOR
    .word lab_e8fc          ;ff5c  fc e8       VECTOR
    .word lab_d612          ;ff5e  12 d6       VECTOR
    .word lab_e8fc          ;ff60  fc e8       VECTOR
    .word 0xd190            ;ff62  90 d1       VECTOR
    .word lab_d177          ;ff64  77 d1       VECTOR
    .word lab_e8fc          ;ff66  fc e8       VECTOR
    .word lab_e8fc          ;ff68  fc e8       VECTOR
    .word lab_e8fc          ;ff6a  fc e8       VECTOR
    .word lab_e307          ;ff6c  07 e3       VECTOR
    .word lab_e366          ;ff6e  66 e3       VECTOR
    .word 0xd8d4            ;ff70  d4 d8       VECTOR
    .word lab_e8fc          ;ff72  fc e8       VECTOR
    .word lab_e2aa          ;ff74  aa e2       VECTOR
    .word lab_e2cf          ;ff76  cf e2       VECTOR
    .word lab_dc61          ;ff78  61 dc       VECTOR
    .word lab_d1af          ;ff7a  af d1       VECTOR
    .word lab_e6b1          ;ff7c  b1 e6       VECTOR

    .byte 0xff              ;ff7e  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff7f  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff80  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff81  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff82  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff83  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff84  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff85  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff86  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff87  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff88  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff89  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff8a  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff8b  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff8c  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff8d  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff8e  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff8f  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff90  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff91  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff92  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff93  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff94  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff95  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff96  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff97  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff98  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff99  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff9a  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff9b  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff9c  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff9d  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff9e  ff          UNKNOWN 0xff 
    .byte 0xff              ;ff9f  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa0  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa1  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa2  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa3  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa4  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa5  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa6  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa7  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa8  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffa9  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffaa  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffab  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffac  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffad  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffae  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffaf  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb0  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb1  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb2  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb3  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb4  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb5  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb6  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb7  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb8  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffb9  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffba  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffbb  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffbc  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffbd  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffbe  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffbf  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc0  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc1  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc2  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc3  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc4  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc5  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc6  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc7  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc8  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffc9  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffca  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffcb  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffcc  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffcd  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffce  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffcf  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd0  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd1  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd2  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd3  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd4  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd5  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd6  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd7  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd8  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffd9  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffda  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffdb  ff          UNKNOWN 0xff 

INT_BRK:
    .byte 0xff              ;ffdc  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffdd  ff          UNKNOWN 0xff 

INT_FFDE:
    .byte 0xff              ;ffde  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffdf  ff          UNKNOWN 0xff 

INT_FFE0:
    .byte 0xff              ;ffe0  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffe1  ff          UNKNOWN 0xff 

INT_FFE2:
    .byte 0xff              ;ffe2  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffe3  ff          UNKNOWN 0xff 

INT_FFE4:
    .byte 0xff              ;ffe4  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffe5  ff          UNKNOWN 0xff 

INT_FFE6:
    .byte 0xff              ;ffe6  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffe7  ff          UNKNOWN 0xff 

INT_FFE8:
    .byte 0xff              ;ffe8  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffe9  ff          UNKNOWN 0xff 

INT_FFEA:
    .byte 0xff              ;ffea  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffeb  ff          UNKNOWN 0xff 

INT_FFEC:
    .byte 0xff              ;ffec  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffed  ff          UNKNOWN 0xff 

INT_FFEE:
    .byte 0xff              ;ffee  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffef  ff          UNKNOWN 0xff 

INT_FFF0:
    .byte 0xff              ;fff0  ff          UNKNOWN 0xff 
    .byte 0xff              ;fff1  ff          UNKNOWN 0xff 

INT_FFF2:
    .byte 0xff              ;fff2  ff          UNKNOWN 0xff 
    .byte 0xff              ;fff3  ff          UNKNOWN 0xff 

INT_FFF4:
    .byte 0xff              ;fff4  ff          UNKNOWN 0xff 
    .byte 0xff              ;fff5  ff          UNKNOWN 0xff 

INT_FFF6:
    .byte 0xff              ;fff6  ff          UNKNOWN 0xff 
    .byte 0xff              ;fff7  ff          UNKNOWN 0xff 

INT_FFF8:
    .byte 0xff              ;fff8  ff          UNKNOWN 0xff 
    .byte 0xff              ;fff9  ff          UNKNOWN 0xff 

INT_FFFA:
    .byte 0xff              ;fffa  ff          UNKNOWN 0xff 
    .byte 0xff              ;fffb  ff          UNKNOWN 0xff 

RESET:
    .byte 0xff              ;fffc  ff          UNKNOWN 0xff 
    .byte 0xff              ;fffd  ff          UNKNOWN 0xff 
    .byte 0xff              ;fffe  ff          UNKNOWN 0xff 
    .byte 0xff              ;ffff  ff          UNKNOWN 0xff 
