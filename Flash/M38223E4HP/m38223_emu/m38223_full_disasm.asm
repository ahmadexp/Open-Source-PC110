; M38223E4HP power-sense MCU — complete MELPS-740 disassembly
; .org $C080   (16254 bytes, $C080..$FFFD)

C080: 4D 33 38   eor   $3833
C083: 32         set   
C084: 32         set   
C085: 58         cli   
C086: 20 50 4F   jsr   $4F50
C089: 57 45 52   bbc2  $45,$C0DE
C08C: 20 53 45   jsr   $4553
C08F: 4E 53 45   lsr   $4553
C092: 20 4D 49   jsr   $494D
C095: 43        .byte $43
C096: 4F 4E      seb2  $4E
C098: 20 46 49   jsr   $4946
C09B: 52        .byte $52
C09C: 4D 57 41   eor   $4157
C09F: 52        .byte $52
C0A0: 45 20      eor   $20
C0A2: 52        .byte $52
C0A3: 65 76      adc   $76
C0A5: 20 38 20   jsr   $2038
C0A8: 28         plp   
C0A9: 43        .byte $43
C0AA: 29 20      and   #$20
C0AC: 31 39      and   ($39),Y
C0AE: 39 35 20   and   $2035,Y
C0B1: 52        .byte $52
C0B2: 49 4F      eor   #$4F
C0B4: 53        .byte $53
C0B5: 20 53 59   jsr   $5953
C0B8: 53        .byte $53
C0B9: 54        .byte $54
C0BA: 45 4D      eor   $4D
C0BC: 53        .byte $53
C0BD: 20 43 4F   jsr   $4F43
C0C0: 2E 2C 4C   rol   $4C2C
C0C3: 54        .byte $54
C0C4: 44        .byte $44
C0C5: 2E 78 20   rol   $2078
C0C8: 5E CC 90   lsr   $90CC,X
C0CB: 03        .byte $03
C0CC: 20 98 CC   jsr   $CC98
C0CF: 20 4A CE   jsr   $CE4A
C0D2: 58         cli   
C0D3: EA         nop   
C0D4: EA         nop   
C0D5: 77 34 FC   bbc3  $34,$C0D4
C0D8: 78         sei   
C0D9: 20 DD C1   jsr   $C1DD
C0DC: 20 FC CC   jsr   $CCFC
C0DF: 20 03 CD   jsr   $CD03
C0E2: 20 0D CD   jsr   $CD0D
C0E5: EF 80      seb7  $80
C0E7: FF 51      clb7  $51
C0E9: FF 95      clb7  $95
C0EB: 58         cli   
C0EC: 20 77 CD   jsr   $CD77
C0EF: 90 03      bcc   $C0F4
C0F1: 4C 17 CD   jmp   $CD17
C0F4: 20 A8 CD   jsr   $CDA8
C0F7: 20 DD CD   jsr   $CDDD
C0FA: D7 95 05   bbc6  $95,$C102
C0FD: 20 E6 DC   jsr   $DCE6
C100: DF 95      clb6  $95
C102: 20 63 DD   jsr   $DD63
C105: D7 BF 03   bbc6  $BF,$C10B
C108: 20 00 E2   jsr   $E200
C10B: 20 E3 E3   jsr   $E3E3
C10E: 20 A3 C1   jsr   $C1A3
C111: 90 D8      bcc   $C0EB
C113: F7 51 06   bbc7  $51,$C11C
C116: F7 95 D2   bbc7  $95,$C0EB
C119: 4C D8 C0   jmp   $C0D8
C11C: 3C 28 E9   ldm   #$28,$E9
C11F: E6 7E      inc   $7E
C121: 20 7D C2   jsr   $C27D
C124: EF 51      seb7  $51
C126: 4C EB C0   jmp   $C0EB
C129: 78         sei   
C12A: 20 5E CC   jsr   $CC5E
C12D: 90 03      bcc   $C132
C12F: 20 98 CC   jsr   $CC98
C132: 20 4A CE   jsr   $CE4A
C135: 58         cli   
C136: EA         nop   
C137: 77 34 FC   bbc3  $34,$C136
C13A: 78         sei   
C13B: 20 DD C1   jsr   $C1DD
C13E: 20 FC CC   jsr   $CCFC
C141: 20 03 CD   jsr   $CD03
C144: 20 0D CD   jsr   $CD0D
C147: EF 80      seb7  $80
C149: FF 51      clb7  $51
C14B: FF 95      clb7  $95
C14D: 58         cli   
C14E: 20 77 CD   jsr   $CD77
C151: 90 03      bcc   $C156
C153: 4C 17 CD   jmp   $CD17
C156: F7 51 03   bbc7  $51,$C15C
C159: 20 30 D1   jsr   $D130
C15C: 20 A8 CD   jsr   $CDA8
C15F: 20 DD CD   jsr   $CDDD
C162: D7 95 05   bbc6  $95,$C16A
C165: 20 E6 DC   jsr   $DCE6
C168: DF 95      clb6  $95
C16A: 20 63 DD   jsr   $DD63
C16D: D7 BF 03   bbc6  $BF,$C173
C170: 20 00 E2   jsr   $E200
C173: 20 E3 E3   jsr   $E3E3
C176: 20 A3 C1   jsr   $C1A3
C179: 90 D2      bcc   $C14D
C17B: F7 51 06   bbc7  $51,$C184
C17E: F7 95 CC   bbc7  $95,$C14D
C181: 4C 3A C1   jmp   $C13A
C184: 3C 28 E9   ldm   #$28,$E9
C187: E7 6C 0E   bbs7  $6C,$C198
C18A: 20 6B C2   jsr   $C26B
C18D: EF 51      seb7  $51
C18F: 20 20 CA   jsr   $CA20
C192: 20 1C D1   jsr   $D11C
C195: 4C 4D C1   jmp   $C14D
C198: 20 96 C3   jsr   $C396
C19B: EF 51      seb7  $51
C19D: 20 CA CA   jsr   $CACA
C1A0: 4C 4D C1   jmp   $C14D
C1A3: A7 BF 0F   bbs5  $BF,$C1B5
C1A6: A5 9D      lda   $9D
C1A8: D0 0B      bne   $C1B5
C1AA: A5 9E      lda   $9E
C1AC: D0 07      bne   $C1B5
C1AE: A5 9F      lda   $9F
C1B0: D0 03      bne   $C1B5
C1B2: 08         php   
C1B3: 80 24      bra   $C1D9
C1B5: 08         php   
C1B6: 78         sei   
C1B7: E7 80 1F   bbs7  $80,$C1D9
C1BA: 07 80 1C   bbs0  $80,$C1D9
C1BD: A7 80 19   bbs5  $80,$C1D9
C1C0: 87 80 16   bbs4  $80,$C1D9
C1C3: 87 81 13   bbs4  $81,$C1D9
C1C6: 67 81 10   bbs3  $81,$C1D9
C1C9: 47 81 0D   bbs2  $81,$C1D9
C1CC: 27 81 0A   bbs1  $81,$C1D9
C1CF: 07 81 07   bbs0  $81,$C1D9
C1D2: E7 81 04   bbs7  $81,$C1D9
C1D5: 28         plp   
C1D6: EA         nop   
C1D7: 38         sec   
C1D8: 60         rts   
C1D9: 28         plp   
C1DA: EA         nop   
C1DB: 18         clc   
C1DC: 60         rts   
C1DD: A9 08      lda   #$08
C1DF: E7 50 07   bbs7  $50,$C1E9
C1E2: A9 04      lda   #$04
C1E4: C7 50 02   bbs6  $50,$C1E9
C1E7: A9 00      lda   #$00
C1E9: F7 6C 05   bbc7  $6C,$C1F1
C1EC: 18         clc   
C1ED: 69 03      adc   #$03
C1EF: 80 13      bra   $C204
C1F1: 48         pha   
C1F2: 20 52 D0   jsr   $D052
C1F5: D0 06      bne   $C1FD
C1F7: 68         pla   
C1F8: 18         clc   
C1F9: 69 01      adc   #$01
C1FB: 80 07      bra   $C204
C1FD: 68         pla   
C1FE: 17 6D 03   bbc0  $6D,$C204
C201: 18         clc   
C202: 69 02      adc   #$02
C204: 0A         asl   A
C205: AA         tax   
C206: BD 13 C2   lda   $C213,X
C209: 85 F5      sta   $F5
C20B: BD 14 C2   lda   $C214,X
C20E: 85 F6      sta   $F6
C210: 02        .byte $02
C211: F5 60      sbc   $60,X
C213: 4B         seb2  A
C214: C2         wit   
C215: 3B         clb1  A
C216: C2         wit   
C217: 4B         seb2  A
C218: C2         wit   
C219: 5B         clb2  A
C21A: C2         wit   
C21B: 4B         seb2  A
C21C: C2         wit   
C21D: 3B         clb1  A
C21E: C2         wit   
C21F: 4B         seb2  A
C220: C2         wit   
C221: 5B         clb2  A
C222: C2         wit   
C223: 4B         seb2  A
C224: C2         wit   
C225: 3B         clb1  A
C226: C2         wit   
C227: 2B         seb1  A
C228: C2         wit   
C229: 5B         clb2  A
C22A: C2         wit   
C22B: 3C 01 5D   ldm   #$01,$5D
C22E: 3C 00 5E   ldm   #$00,$5E
C231: 3C 00 5F   ldm   #$00,$5F
C234: 3C 04 60   ldm   #$04,$60
C237: 3C 02 61   ldm   #$02,$61
C23A: 60         rts   
C23B: 3C 00 5D   ldm   #$00,$5D
C23E: 3C 00 5E   ldm   #$00,$5E
C241: 3C 00 5F   ldm   #$00,$5F
C244: 3C 00 60   ldm   #$00,$60
C247: 3C 02 61   ldm   #$02,$61
C24A: 60         rts   
C24B: 3C 01 5D   ldm   #$01,$5D
C24E: 3C 00 5E   ldm   #$00,$5E
C251: 3C 01 5F   ldm   #$01,$5F
C254: 3C 00 60   ldm   #$00,$60
C257: 3C 02 61   ldm   #$02,$61
C25A: 60         rts   
C25B: 3C 7F 5D   ldm   #$7F,$5D
C25E: 3C 00 5E   ldm   #$00,$5E
C261: 3C 01 5F   ldm   #$01,$5F
C264: 3C 00 60   ldm   #$00,$60
C267: 3C 7F 61   ldm   #$7F,$61
C26A: 60         rts   
C26B: E7 6C 0B   bbs7  $6C,$C279
C26E: F7 50 04   bbc7  $50,$C275
C271: 20 7D C2   jsr   $C27D
C274: 60         rts   
C275: 20 49 C3   jsr   $C349
C278: 60         rts   
C279: 20 96 C3   jsr   $C396
C27C: 60         rts   
C27D: 20 06 C4   jsr   $C406
C280: A5 65      lda   $65
C282: 17 6D 1C   bbc0  $6D,$C2A1
C285: 20 52 D0   jsr   $D052
C288: 08         php   
C289: A9 00      lda   #$00
C28B: 28         plp   
C28C: EA         nop   
C28D: F0 12      beq   $C2A1
C28F: A0 04      ldy   #$04
C291: F0 0E      beq   $C2A1
C293: 98         tya   
C294: 4A         lsr   A
C295: A8         tay   
C296: F0 07      beq   $C29F
C298: 46 67      lsr   $67
C29A: 66 66      ror   $66
C29C: 88         dey   
C29D: D0 F9      bne   $C298
C29F: A5 66      lda   $66
C2A1: 85 70      sta   $70
C2A3: 20 A5 CC   jsr   $CCA5
C2A6: 90 02      bcc   $C2AA
C2A8: 80 3C      bra   $C2E6
C2AA: 20 10 C4   jsr   $C410
C2AD: B0 37      bcs   $C2E6
C2AF: 07 6D 16   bbs0  $6D,$C2C8
C2B2: A5 70      lda   $70
C2B4: C9 04      cmp   #$04
C2B6: B0 10      bcs   $C2C8
C2B8: A5 5A      lda   $5A
C2BA: 18         clc   
C2BB: 69 01      adc   #$01
C2BD: 85 5A      sta   $5A
C2BF: 90 25      bcc   $C2E6
C2C1: A9 00      lda   #$00
C2C3: 48         pha   
C2C4: A9 01      lda   #$01
C2C6: 80 06      bra   $C2CE
C2C8: A2 00      ldx   #$00
C2CA: A9 10      lda   #$10
C2CC: 62 70      mul   $70,X
C2CE: A0 5B      ldy   #$5B
C2D0: 20 9D E6   jsr   $E69D
C2D3: B0 03      bcs   $C2D8
C2D5: 20 EA C2   jsr   $C2EA
C2D8: 68         pla   
C2D9: 85 F7      sta   $F7
C2DB: A5 5C      lda   $5C
C2DD: E5 F7      sbc   $F7
C2DF: 85 5C      sta   $5C
C2E1: B0 03      bcs   $C2E6
C2E3: 20 EA C2   jsr   $C2EA
C2E6: 20 A1 C7   jsr   $C7A1
C2E9: 60         rts   
C2EA: 20 11 C3   jsr   $C311
C2ED: A0 5B      ldy   #$5B
C2EF: 20 69 E6   jsr   $E669
C2F2: 20 1D C3   jsr   $C31D
C2F5: 65 5C      adc   $5C
C2F7: 85 5C      sta   $5C
C2F9: A5 6E      lda   $6E
C2FB: F0 03      beq   $C300
C2FD: 1A        .byte $1A
C2FE: 85 6E      sta   $6E
C300: 63        .byte $63
C301: 20 52 D0   jsr   $D052
C304: 0A         asl   A
C305: AA         tax   
C306: BD 29 C3   lda   $C329,X
C309: 85 5B      sta   $5B
C30B: BD 2A C3   lda   $C32A,X
C30E: 85 5C      sta   $5C
C310: 62 08      mul   $08,X
C312: 20 52 D0   jsr   $D052
C315: 0A         asl   A
C316: AA         tax   
C317: BD 29 C3   lda   $C329,X
C31A: 28         plp   
C31B: EA         nop   
C31C: 60         rts   
C31D: 08         php   
C31E: 20 52 D0   jsr   $D052
C321: 0A         asl   A
C322: AA         tax   
C323: BD 2A C3   lda   $C32A,X
C326: 28         plp   
C327: EA         nop   
C328: 60         rts   
C329: 28         plp   
C32A: A0 28      ldy   #$28
C32C: A0 28      ldy   #$28
C32E: A0 28      ldy   #$28
C330: A0 28      ldy   #$28
C332: A0 A0      ldy   #$A0
C334: 8C 28 A0   sty   $A028
C337: 28         plp   
C338: A0 28      ldy   #$28
C33A: A0 58      ldy   #$58
C33C: 98         tya   
C33D: FA        .byte $FA
C33E: FF C0      clb7  $C0
C340: A8         tay   
C341: 28         plp   
C342: A0 80      ldy   #$80
C344: 70 28      bvs   $C36E
C346: A0 28      ldy   #$28
C348: A0 20      ldy   #$20
C34A: 06 C4      asl   $C4
C34C: 20 52 D0   jsr   $D052
C34F: 08         php   
C350: A9 00      lda   #$00
C352: 28         plp   
C353: EA         nop   
C354: F0 02      beq   $C358
C356: A5 65      lda   $65
C358: 85 70      sta   $70
C35A: 20 A5 CC   jsr   $CCA5
C35D: 90 02      bcc   $C361
C35F: 80 31      bra   $C392
C361: 20 10 C4   jsr   $C410
C364: B0 80      bcs   $C2E6
C366: A5 70      lda   $70
C368: C9 04      cmp   #$04
C36A: 90 03      bcc   $C36F
C36C: 4C C8 C2   jmp   $C2C8
C36F: 07 6D 0D   bbs0  $6D,$C37F
C372: A5 5A      lda   $5A
C374: 18         clc   
C375: 69 01      adc   #$01
C377: 85 5A      sta   $5A
C379: 90 17      bcc   $C392
C37B: A9 01      lda   #$01
C37D: 80 09      bra   $C388
C37F: A2 00      ldx   #$00
C381: A9 13      lda   #$13
C383: C7 50 02   bbs6  $50,$C388
C386: A9 02      lda   #$02
C388: A0 5B      ldy   #$5B
C38A: 20 9D E6   jsr   $E69D
C38D: B0 03      bcs   $C392
C38F: 20 EA C2   jsr   $C2EA
C392: 20 A1 C7   jsr   $C7A1
C395: 60         rts   
C396: 20 06 C4   jsr   $C406
C399: A5 62      lda   $62
C39B: D0 09      bne   $C3A6
C39D: A5 63      lda   $63
C39F: D0 05      bne   $C3A6
C3A1: A9 01      lda   #$01
C3A3: 48         pha   
C3A4: 80 06      bra   $C3AC
C3A6: A2 00      ldx   #$00
C3A8: A9 7F      lda   #$7F
C3AA: E2 62      div   $62,X
C3AC: 85 70      sta   $70
C3AE: 68         pla   
C3AF: A5 68      lda   $68
C3B1: D0 09      bne   $C3BC
C3B3: A5 69      lda   $69
C3B5: D0 05      bne   $C3BC
C3B7: A9 01      lda   #$01
C3B9: 48         pha   
C3BA: 80 06      bra   $C3C2
C3BC: A2 00      ldx   #$00
C3BE: A9 7F      lda   #$7F
C3C0: E2 68      div   $68,X
C3C2: 85 71      sta   $71
C3C4: 68         pla   
C3C5: 20 A5 CC   jsr   $CCA5
C3C8: B0 38      bcs   $C402
C3CA: A5 70      lda   $70
C3CC: C9 03      cmp   #$03
C3CE: 90 32      bcc   $C402
C3D0: A2 00      ldx   #$00
C3D2: A9 0F      lda   #$0F
C3D4: C7 6C 02   bbs6  $6C,$C3D9
C3D7: A9 10      lda   #$10
C3D9: 62 70      mul   $70,X
C3DB: A0 5B      ldy   #$5B
C3DD: 20 69 E6   jsr   $E669
C3E0: 68         pla   
C3E1: 65 5C      adc   $5C
C3E3: 85 5C      sta   $5C
C3E5: 20 1D C3   jsr   $C31D
C3E8: 3A        .byte $3A
C3E9: C5 5C      cmp   $5C
C3EB: B0 15      bcs   $C402
C3ED: E6 6E      inc   $6E
C3EF: 20 11 C3   jsr   $C311
C3F2: A0 5B      ldy   #$5B
C3F4: 20 9D E6   jsr   $E69D
C3F7: 20 1D C3   jsr   $C31D
C3FA: 85 F9      sta   $F9
C3FC: A5 5C      lda   $5C
C3FE: E5 F9      sbc   $F9
C400: 85 5C      sta   $5C
C402: 20 A1 C7   jsr   $C7A1
C405: 60         rts   
C406: 20 9E E3   jsr   $E39E
C409: 20 80 C6   jsr   $C680
C40C: 20 EF C6   jsr   $C6EF
C40F: 60         rts   
C410: 37 C0 03   bbc1  $C0,$C416
C413: 4C FF C4   jmp   $C4FF
C416: 20 F9 C5   jsr   $C5F9
C419: B0 F8      bcs   $C413
C41B: 20 52 D0   jsr   $D052
C41E: 48         pha   
C41F: 20 89 E5   jsr   $E589
C422: 85 FB      sta   $FB
C424: 68         pla   
C425: C9 09      cmp   #$09
C427: F0 44      beq   $C46D
C429: C9 0A      cmp   #$0A
C42B: F0 40      beq   $C46D
C42D: C9 08      cmp   #$08
C42F: F0 0E      beq   $C43F
C431: C9 05      cmp   #$05
C433: D0 0A      bne   $C43F
C435: A5 C8      lda   $C8
C437: F0 2C      beq   $C465
C439: C9 01      cmp   #$01
C43B: F0 20      beq   $C45D
C43D: 80 26      bra   $C465
C43F: E7 C2 0B   bbs7  $C2,$C44D
C442: C7 C2 10   bbs6  $C2,$C455
C445: 3C 0D F5   ldm   #$0D,$F5
C448: 3C C5 F6   ldm   #$C5,$F6
C44B: 80 3E      bra   $C48B
C44D: 3C 23 F5   ldm   #$23,$F5
C450: 3C C5 F6   ldm   #$C5,$F6
C453: 80 36      bra   $C48B
C455: 3C 16 F5   ldm   #$16,$F5
C458: 3C C5 F6   ldm   #$C5,$F6
C45B: 80 2E      bra   $C48B
C45D: 3C 74 F5   ldm   #$74,$F5
C460: 3C C5 F6   ldm   #$C5,$F6
C463: 80 26      bra   $C48B
C465: 3C 6B F5   ldm   #$6B,$F5
C468: 3C C5 F6   ldm   #$C5,$F6
C46B: 80 1E      bra   $C48B
C46D: E7 C2 0B   bbs7  $C2,$C47B
C470: C7 C2 10   bbs6  $C2,$C483
C473: 3C 52 F5   ldm   #$52,$F5
C476: 3C C5 F6   ldm   #$C5,$F6
C479: 80 10      bra   $C48B
C47B: 3C 3C F5   ldm   #$3C,$F5
C47E: 3C C5 F6   ldm   #$C5,$F6
C481: 80 08      bra   $C48B
C483: 3C 45 F5   ldm   #$45,$F5
C486: 3C C5 F6   ldm   #$C5,$F6
C489: 80 00      bra   $C48B
C48B: A0 00      ldy   #$00
C48D: 3C 06 F9   ldm   #$06,$F9
C490: 17 6D 16   bbc0  $6D,$C4A9
C493: A2 00      ldx   #$00
C495: A5 6B      lda   $6B
C497: 62 6A      mul   $6A,X
C499: 68         pla   
C49A: C9 7C      cmp   #$7C
C49C: 90 02      bcc   $C4A0
C49E: A9 7B      lda   #$7B
C4A0: AA         tax   
C4A1: BD 7D C5   lda   $C57D,X
C4A4: 18         clc   
C4A5: 65 FB      adc   $FB
C4A7: 85 F9      sta   $F9
C4A9: B1 F5      lda   ($F5),Y
C4AB: AA         tax   
C4AC: F0 51      beq   $C4FF
C4AE: A5 6E      lda   $6E
C4B0: D1 F5      cmp   ($F5),Y
C4B2: F0 3D      beq   $C4F1
C4B4: B0 04      bcs   $C4BA
C4B6: C8         iny   
C4B7: C8         iny   
C4B8: 80 EF      bra   $C4A9
C4BA: A5 71      lda   $71
C4BC: 38         sec   
C4BD: E5 F9      sbc   $F9
C4BF: C8         iny   
C4C0: D1 F5      cmp   ($F5),Y
C4C2: 08         php   
C4C3: C8         iny   
C4C4: 28         plp   
C4C5: EA         nop   
C4C6: F0 02      beq   $C4CA
C4C8: B0 35      bcs   $C4FF
C4CA: CA         dex   
C4CB: AD 03 01   lda   $0103
C4CE: F0 06      beq   $C4D6
C4D0: 1A        .byte $1A
C4D1: 8D 03 01   sta   $0103
C4D4: D0 2E      bne   $C504
C4D6: 86 F8      stx   $F8
C4D8: A5 6E      lda   $6E
C4DA: 38         sec   
C4DB: E5 F8      sbc   $F8
C4DD: C9 03      cmp   #$03
C4DF: 90 07      bcc   $C4E8
C4E1: A5 6E      lda   $6E
C4E3: E9 02      sbc   #$02
C4E5: AA         tax   
C4E6: 80 02      bra   $C4EA
C4E8: A6 F8      ldx   $F8
C4EA: 86 6E      stx   $6E
C4EC: 20 01 C3   jsr   $C301
C4EF: 80 0E      bra   $C4FF
C4F1: A5 71      lda   $71
C4F3: 38         sec   
C4F4: E5 F9      sbc   $F9
C4F6: C8         iny   
C4F7: D1 F5      cmp   ($F5),Y
C4F9: F0 04      beq   $C4FF
C4FB: B0 09      bcs   $C506
C4FD: 80 C3      bra   $C4C2
C4FF: A9 03      lda   #$03
C501: 8D 03 01   sta   $0103
C504: 18         clc   
C505: 60         rts   
C506: A9 03      lda   #$03
C508: 8D 03 01   sta   $0103
C50B: 38         sec   
C50C: 60         rts   
C50D: 15 90      ora   $90,X
C50F: 0B         seb0  A
C510: 8E 06 8B   stx   $8B06
C513: 01 70      ora   ($70,X)
C515: 00         brk   
C516: 50 9C      bvc   $C4B4
C518: 32         set   
C519: 95 15      sta   $15,X
C51B: 90 0B      bcc   $C528
C51D: 8E 06 8B   stx   $8B06
C520: 01 70      ora   ($70,X)
C522: 00         brk   
C523: 64 A2      tst   $A2
C525: 5A        .byte $5A
C526: 9F 50      clb4  $50
C528: 9C        .byte $9C
C529: 46 99      lsr   $99
C52B: 3C 97 32   ldm   #$97,$32
C52E: 95 28      sta   $28,X
C530: 94 1E      sty   $1E,X
C532: 92 15      rrf   $15
C534: 90 0B      bcc   $C541
C536: 8E 06 8B   stx   $8B06
C539: 01 70      ora   ($70,X)
C53B: 00         brk   
C53C: 14        .byte $14
C53D: 88         dey   
C53E: 0A         asl   A
C53F: 7E 06 77   ror   $7706,X
C542: 01 6A      ora   ($6A,X)
C544: 00         brk   
C545: 50 9D      bvc   $C4E4
C547: 32         set   
C548: 97 14 88   bbc4  $14,$C4D3
C54B: 0A         asl   A
C54C: 7E 06 77   ror   $7706,X
C54F: 01 6A      ora   ($6A,X)
C551: 00         brk   
C552: 64 A2      tst   $A2
C554: 5A        .byte $5A
C555: A0 50      ldy   #$50
C557: 9D 46 9B   sta   $9B46,X
C55A: 3C 99 32   ldm   #$99,$32
C55D: 97 28 95   bbc4  $28,$C4F5
C560: 1E 8F 14   asl   $148F,X
C563: 88         dey   
C564: 0A         asl   A
C565: 7E 06 77   ror   $7706,X
C568: 01 6A      ora   ($6A,X)
C56A: 00         brk   
C56B: 15 96      ora   $96,X
C56D: 0B         seb0  A
C56E: 8A         txa   
C56F: 06 81      asl   $81
C571: 01 77      ora   ($77,X)
C573: 00         brk   
C574: 15 9A      ora   $9A,X
C576: 0B         seb0  A
C577: 90 06      bcc   $C57F
C579: 87 01 7D   bbs4  $01,$C5F9
C57C: 00         brk   
C57D: 06 06      asl   $06
C57F: 06 06      asl   $06
C581: 05 05      ora   $05
C583: 05 05      ora   $05
C585: 05 05      ora   $05
C587: 04        .byte $04
C588: 04        .byte $04
C589: 04        .byte $04
C58A: 04        .byte $04
C58B: 04        .byte $04
C58C: 03        .byte $03
C58D: 03        .byte $03
C58E: 03        .byte $03
C58F: 03        .byte $03
C590: 03        .byte $03
C591: 02        .byte $02
C592: 02        .byte $02
C593: 02        .byte $02
C594: 01 01      ora   ($01,X)
C596: 01 00      ora   ($00,X)
C598: 00         brk   
C599: 00         brk   
C59A: 00         brk   
C59B: FF FF      clb7  $FF
C59D: FF FF      clb7  $FF
C59F: FE FE FE   inc   $FEFE,X
C5A2: FE FD FD   inc   $FDFD,X
C5A5: FD FD FD   sbc   $FDFD,X
C5A8: FD FD FD   sbc   $FDFD,X
C5AB: FD FD FD   sbc   $FDFD,X
C5AE: FD FD FD   sbc   $FDFD,X
C5B1: FD FD FD   sbc   $FDFD,X
C5B4: FD FD FD   sbc   $FDFD,X
C5B7: FD FD FD   sbc   $FDFD,X
C5BA: FD FD FD   sbc   $FDFD,X
C5BD: FD FD FD   sbc   $FDFD,X
C5C0: FD FD FD   sbc   $FDFD,X
C5C3: FD FD FD   sbc   $FDFD,X
C5C6: FD FD FD   sbc   $FDFD,X
C5C9: FD FD FD   sbc   $FDFD,X
C5CC: FD FD FD   sbc   $FDFD,X
C5CF: FD FD FD   sbc   $FDFD,X
C5D2: FD FD FD   sbc   $FDFD,X
C5D5: FD FD FD   sbc   $FDFD,X
C5D8: FD FD FD   sbc   $FDFD,X
C5DB: FD FD FD   sbc   $FDFD,X
C5DE: FD FD FD   sbc   $FDFD,X
C5E1: FD FD FD   sbc   $FDFD,X
C5E4: FD FD FD   sbc   $FDFD,X
C5E7: FD FD FD   sbc   $FDFD,X
C5EA: FD FD FD   sbc   $FDFD,X
C5ED: FD FD FD   sbc   $FDFD,X
C5F0: FD FD FD   sbc   $FDFD,X
C5F3: FD FD FD   sbc   $FDFD,X
C5F6: FD FD FD   sbc   $FDFD,X
C5F9: A7 C2 72   bbs5  $C2,$C66E
C5FC: 17 6D 6F   bbc0  $6D,$C66E
C5FF: C7 53 6C   bbs6  $53,$C66E
C602: A7 50 69   bbs5  $50,$C66E
C605: 20 52 D0   jsr   $D052
C608: F0 64      beq   $C66E
C60A: AA         tax   
C60B: A5 6E      lda   $6E
C60D: A4 71      ldy   $71
C60F: 20 59 C6   jsr   $C659
C612: 90 5A      bcc   $C66E
C614: 85 6E      sta   $6E
C616: 60         rts   
C617: A7 C2 54   bbs5  $C2,$C66E
C61A: 17 6D 51   bbc0  $6D,$C66E
C61D: C7 50 4E   bbs6  $50,$C66E
C620: A7 50 4B   bbs5  $50,$C66E
C623: 20 57 D0   jsr   $D057
C626: F0 46      beq   $C66E
C628: AA         tax   
C629: AD 06 01   lda   $0106
C62C: AC 0A 01   ldy   $010A
C62F: 20 59 C6   jsr   $C659
C632: 90 3A      bcc   $C66E
C634: 8D 06 01   sta   $0106
C637: 60         rts   
C638: A7 C2 33   bbs5  $C2,$C66E
C63B: 17 6D 30   bbc0  $6D,$C66E
C63E: C7 50 2D   bbs6  $50,$C66E
C641: A7 50 2A   bbs5  $50,$C66E
C644: 20 5D D0   jsr   $D05D
C647: F0 25      beq   $C66E
C649: AA         tax   
C64A: AD 07 01   lda   $0107
C64D: AC 0B 01   ldy   $010B
C650: 20 59 C6   jsr   $C659
C653: 90 19      bcc   $C66E
C655: 8D 07 01   sta   $0107
C658: 60         rts   
C659: C9 FF      cmp   #$FF
C65B: F0 11      beq   $C66E
C65D: C9 04      cmp   #$04
C65F: 90 0D      bcc   $C66E
C661: 98         tya   
C662: DD 70 C6   cmp   $C670,X
C665: B0 07      bcs   $C66E
C667: 20 01 C3   jsr   $C301
C66A: A9 03      lda   #$03
C66C: 38         sec   
C66D: 60         rts   
C66E: 18         clc   
C66F: 60         rts   
C670: 7C        .byte $7C
C671: 7C        .byte $7C
C672: 7C        .byte $7C
C673: 7C        .byte $7C
C674: 7C        .byte $7C
C675: 78         sei   
C676: 7C        .byte $7C
C677: 7C        .byte $7C
C678: 7C        .byte $7C
C679: 77 77 7A   bbc3  $77,$C6F6
C67C: 7C        .byte $7C
C67D: 78         sei   
C67E: 7C        .byte $7C
C67F: 7C        .byte $7C
C680: 20 17 C6   jsr   $C617
C683: B0 69      bcs   $C6EE
C685: 20 57 D0   jsr   $D057
C688: D0 15      bne   $C69F
C68A: 20 9A D0   jsr   $D09A
C68D: D0 02      bne   $C691
C68F: 80 5D      bra   $C6EE
C691: 08         php   
C692: 78         sei   
C693: 8D 08 01   sta   $0108
C696: A9 FF      lda   #$FF
C698: 8D 06 01   sta   $0106
C69B: 28         plp   
C69C: EA         nop   
C69D: 80 4F      bra   $C6EE
C69F: 20 9A D0   jsr   $D09A
C6A2: F0 42      beq   $C6E6
C6A4: 85 F8      sta   $F8
C6A6: AD 06 01   lda   $0106
C6A9: 85 FA      sta   $FA
C6AB: AD 0A 01   lda   $010A
C6AE: 85 F9      sta   $F9
C6B0: 20 5E C7   jsr   $C75E
C6B3: B0 27      bcs   $C6DC
C6B5: AE 06 01   ldx   $0106
C6B8: E0 FF      cpx   #$FF
C6BA: F0 20      beq   $C6DC
C6BC: AE 04 01   ldx   $0104
C6BF: F0 06      beq   $C6C7
C6C1: CA         dex   
C6C2: 8E 04 01   stx   $0104
C6C5: D0 27      bne   $C6EE
C6C7: 85 F8      sta   $F8
C6C9: AD 06 01   lda   $0106
C6CC: 38         sec   
C6CD: E5 F8      sbc   $F8
C6CF: C9 03      cmp   #$03
C6D1: 90 07      bcc   $C6DA
C6D3: AD 06 01   lda   $0106
C6D6: E9 02      sbc   #$02
C6D8: 80 02      bra   $C6DC
C6DA: A5 F8      lda   $F8
C6DC: 8D 06 01   sta   $0106
C6DF: A9 03      lda   #$03
C6E1: 8D 04 01   sta   $0104
C6E4: 80 08      bra   $C6EE
C6E6: A9 00      lda   #$00
C6E8: 8D 06 01   sta   $0106
C6EB: 8D 08 01   sta   $0108
C6EE: 60         rts   
C6EF: 20 38 C6   jsr   $C638
C6F2: B0 69      bcs   $C75D
C6F4: 20 5D D0   jsr   $D05D
C6F7: D0 15      bne   $C70E
C6F9: 20 82 D0   jsr   $D082
C6FC: D0 02      bne   $C700
C6FE: 80 5D      bra   $C75D
C700: 08         php   
C701: 78         sei   
C702: 8D 09 01   sta   $0109
C705: A9 FF      lda   #$FF
C707: 8D 07 01   sta   $0107
C70A: 28         plp   
C70B: EA         nop   
C70C: 80 4F      bra   $C75D
C70E: 20 82 D0   jsr   $D082
C711: F0 42      beq   $C755
C713: 85 F8      sta   $F8
C715: AD 07 01   lda   $0107
C718: 85 FA      sta   $FA
C71A: AD 0B 01   lda   $010B
C71D: 85 F9      sta   $F9
C71F: 20 5E C7   jsr   $C75E
C722: B0 27      bcs   $C74B
C724: AE 07 01   ldx   $0107
C727: E0 FF      cpx   #$FF
C729: F0 20      beq   $C74B
C72B: AE 05 01   ldx   $0105
C72E: F0 06      beq   $C736
C730: CA         dex   
C731: 8E 05 01   stx   $0105
C734: D0 27      bne   $C75D
C736: 85 F8      sta   $F8
C738: AD 07 01   lda   $0107
C73B: 38         sec   
C73C: E5 F8      sbc   $F8
C73E: C9 03      cmp   #$03
C740: 90 07      bcc   $C749
C742: AD 07 01   lda   $0107
C745: E9 02      sbc   #$02
C747: 80 02      bra   $C74B
C749: A5 F8      lda   $F8
C74B: 8D 07 01   sta   $0107
C74E: A9 03      lda   #$03
C750: 8D 05 01   sta   $0105
C753: 80 08      bra   $C75D
C755: A9 00      lda   #$00
C757: 8D 07 01   sta   $0107
C75A: 8D 09 01   sta   $0109
C75D: 60         rts   
C75E: A5 F8      lda   $F8
C760: 20 21 E5   jsr   $E521
C763: 85 FB      sta   $FB
C765: A5 F8      lda   $F8
C767: 20 19 D0   jsr   $D019
C76A: A0 00      ldy   #$00
C76C: 3C 06 F7   ldm   #$06,$F7
C76F: 17 6D 13   bbc0  $6D,$C785
C772: 3C 06 F7   ldm   #$06,$F7
C775: A7 50 0D   bbs5  $50,$C785
C778: 3C 06 F7   ldm   #$06,$F7
C77B: C7 50 07   bbs6  $50,$C785
C77E: 18         clc   
C77F: A5 FB      lda   $FB
C781: 65 C5      adc   $C5
C783: 85 F7      sta   $F7
C785: B1 F5      lda   ($F5),Y
C787: C9 FF      cmp   #$FF
C789: F0 0C      beq   $C797
C78B: 18         clc   
C78C: 65 F7      adc   $F7
C78E: C5 F9      cmp   $F9
C790: B0 05      bcs   $C797
C792: C8         iny   
C793: C8         iny   
C794: C8         iny   
C795: 80 EE      bra   $C785
C797: C8         iny   
C798: B1 F5      lda   ($F5),Y
C79A: C5 FA      cmp   $FA
C79C: 90 02      bcc   $C7A0
C79E: A5 FA      lda   $FA
C7A0: 60         rts   
C7A1: 17 C0 01   bbc0  $C0,$C7A5
C7A4: 60         rts   
C7A5: A7 6C 73   bbs5  $6C,$C81B
C7A8: 20 63 D0   jsr   $D063
C7AB: F0 32      beq   $C7DF
C7AD: 20 E6 D0   jsr   $D0E6
C7B0: C9 FF      cmp   #$FF
C7B2: F0 2B      beq   $C7DF
C7B4: C9 33      cmp   #$33
C7B6: 90 03      bcc   $C7BB
C7B8: 4C C5 C8   jmp   $C8C5
C7BB: C9 15      cmp   #$15
C7BD: 90 03      bcc   $C7C2
C7BF: 4C A7 C8   jmp   $C8A7
C7C2: C9 0B      cmp   #$0B
C7C4: 90 03      bcc   $C7C9
C7C6: 4C 77 C8   jmp   $C877
C7C9: C9 06      cmp   #$06
C7CB: 90 03      bcc   $C7D0
C7CD: 4C 3A C8   jmp   $C83A
C7D0: C9 00      cmp   #$00
C7D2: 90 03      bcc   $C7D7
C7D4: 4C 1C C8   jmp   $C81C
C7D7: 20 74 C9   jsr   $C974
C7DA: B0 21      bcs   $C7FD
C7DC: 4C 1C C8   jmp   $C81C
C7DF: 3C 00 8C   ldm   #$00,$8C
C7E2: 20 E3 C8   jsr   $C8E3
C7E5: AA         tax   
C7E6: 08         php   
C7E7: 78         sei   
C7E8: A5 04      lda   $04
C7EA: 29 03      and   #$03
C7EC: 1D 62 C9   ora   $C962,X
C7EF: 85 04      sta   $04
C7F1: 28         plp   
C7F2: EA         nop   
C7F3: A5 6D      lda   $6D
C7F5: 29 81      and   #$81
C7F7: 1D 63 C9   ora   $C963,X
C7FA: 85 6D      sta   $6D
C7FC: 60         rts   
C7FD: 3C 00 8C   ldm   #$00,$8C
C800: 20 E3 C8   jsr   $C8E3
C803: AA         tax   
C804: 08         php   
C805: 78         sei   
C806: A5 04      lda   $04
C808: 29 03      and   #$03
C80A: 1D 50 C9   ora   $C950,X
C80D: 85 04      sta   $04
C80F: 28         plp   
C810: EA         nop   
C811: A5 6D      lda   $6D
C813: 29 81      and   #$81
C815: 1D 51 C9   ora   $C951,X
C818: 85 6D      sta   $6D
C81A: 60         rts   
C81B: 60         rts   
C81C: 3C 00 8C   ldm   #$00,$8C
C81F: 20 E3 C8   jsr   $C8E3
C822: AA         tax   
C823: 08         php   
C824: 78         sei   
C825: A5 04      lda   $04
C827: 29 03      and   #$03
C829: 1D 3E C9   ora   $C93E,X
C82C: 85 04      sta   $04
C82E: 28         plp   
C82F: EA         nop   
C830: A5 6D      lda   $6D
C832: 29 81      and   #$81
C834: 1D 3F C9   ora   $C93F,X
C837: 85 6D      sta   $6D
C839: 60         rts   
C83A: A5 6D      lda   $6D
C83C: 48         pha   
C83D: 20 E3 C8   jsr   $C8E3
C840: AA         tax   
C841: 08         php   
C842: 78         sei   
C843: A5 04      lda   $04
C845: 29 13      and   #$13
C847: 1D 2C C9   ora   $C92C,X
C84A: 85 04      sta   $04
C84C: 28         plp   
C84D: EA         nop   
C84E: A5 6D      lda   $6D
C850: 29 81      and   #$81
C852: 1D 2D C9   ora   $C92D,X
C855: 85 6D      sta   $6D
C857: 68         pla   
C858: 29 40      and   #$40
C85A: C9 40      cmp   #$40
C85C: F0 08      beq   $C866
C85E: BD 2E C9   lda   $C92E,X
C861: 73        .byte $73
C862: 0F 20      seb0  $20
C864: B5 CE      lda   $CE,X
C866: BD 2E C9   lda   $C92E,X
C869: 93        .byte $93
C86A: 08         php   
C86B: A5 8C      lda   $8C
C86D: D0 03      bne   $C872
C86F: 20 82 CE   jsr   $CE82
C872: 60         rts   
C873: 3C 00 8C   ldm   #$00,$8C
C876: 60         rts   
C877: 3C 00 8C   ldm   #$00,$8C
C87A: A5 6D      lda   $6D
C87C: 48         pha   
C87D: 20 E3 C8   jsr   $C8E3
C880: AA         tax   
C881: 08         php   
C882: 78         sei   
C883: A5 04      lda   $04
C885: 29 03      and   #$03
C887: 1D 1A C9   ora   $C91A,X
C88A: 85 04      sta   $04
C88C: 28         plp   
C88D: EA         nop   
C88E: A5 6D      lda   $6D
C890: 29 81      and   #$81
C892: 1D 1B C9   ora   $C91B,X
C895: 85 6D      sta   $6D
C897: 68         pla   
C898: 29 70      and   #$70
C89A: C9 20      cmp   #$20
C89C: F0 08      beq   $C8A6
C89E: BD 1C C9   lda   $C91C,X
C8A1: 53        .byte $53
C8A2: CF 20      seb6  $20
C8A4: A5 CE      lda   $CE
C8A6: 60         rts   
C8A7: 3C 00 8C   ldm   #$00,$8C
C8AA: 20 E3 C8   jsr   $C8E3
C8AD: AA         tax   
C8AE: 08         php   
C8AF: 78         sei   
C8B0: A5 04      lda   $04
C8B2: 29 03      and   #$03
C8B4: 1D 08 C9   ora   $C908,X
C8B7: 85 04      sta   $04
C8B9: 28         plp   
C8BA: EA         nop   
C8BB: A5 6D      lda   $6D
C8BD: 29 81      and   #$81
C8BF: 1D 09 C9   ora   $C909,X
C8C2: 85 6D      sta   $6D
C8C4: 60         rts   
C8C5: 3C 00 8C   ldm   #$00,$8C
C8C8: 20 E3 C8   jsr   $C8E3
C8CB: AA         tax   
C8CC: 08         php   
C8CD: 78         sei   
C8CE: A5 04      lda   $04
C8D0: 29 03      and   #$03
C8D2: 1D F6 C8   ora   $C8F6,X
C8D5: 85 04      sta   $04
C8D7: 28         plp   
C8D8: EA         nop   
C8D9: A5 6D      lda   $6D
C8DB: 29 81      and   #$81
C8DD: 1D F7 C8   ora   $C8F7,X
C8E0: 85 6D      sta   $6D
C8E2: 60         rts   
C8E3: A9 00      lda   #$00
C8E5: A7 50 07   bbs5  $50,$C8EF
C8E8: A9 06      lda   #$06
C8EA: C7 50 02   bbs6  $50,$C8EF
C8ED: A9 0C      lda   #$0C
C8EF: 07 6D 03   bbs0  $6D,$C8F5
C8F2: 18         clc   
C8F3: 69 03      adc   #$03
C8F5: 60         rts   
C8F6: 30 10      bmi   $C908
C8F8: 02        .byte $02
C8F9: 10 10      bpl   $C90B
C8FB: 02        .byte $02
C8FC: BC 10 00   ldy   $0010,X
C8FF: 9C        .byte $9C
C900: 30 00      bmi   $C902
C902: 9C        .byte $9C
C903: 10 00      bpl   $C905
C905: 9C        .byte $9C
C906: 10 00      bpl   $C908
C908: 30 30      bmi   $C93A
C90A: 02        .byte $02
C90B: 00         brk   
C90C: 30 02      bmi   $C910
C90E: B8         clv   
C90F: 30 00      bmi   $C911
C911: 88         dey   
C912: 30 00      bmi   $C914
C914: 88         dey   
C915: 30 00      bmi   $C917
C917: 88         dey   
C918: 30 00      bmi   $C91A
C91A: 30 20      bmi   $C93C
C91C: 02        .byte $02
C91D: 20 20 02   jsr   $0220
C920: B4 20      ldy   $20,X
C922: 00         brk   
C923: A4 20      ldy   $20
C925: 00         brk   
C926: A4 20      ldy   $20
C928: 04        .byte $04
C929: A4 20      ldy   $20
C92B: 00         brk   
C92C: 30 70      bmi   $C99E
C92E: 02        .byte $02
C92F: 20 70 12   jsr   $1270
C932: B0 70      bcs   $C9A4
C934: 02        .byte $02
C935: A0 70      ldy   #$70
C937: 12         clt   
C938: A0 70      ldy   #$70
C93A: 1A        .byte $1A
C93B: A0 70      ldy   #$70
C93D: 12         clt   
C93E: 30 30      bmi   $C970
C940: 02        .byte $02
C941: 30 30      bmi   $C973
C943: 02        .byte $02
C944: 30 30      bmi   $C976
C946: 02        .byte $02
C947: B0 30      bcs   $C979
C949: 02        .byte $02
C94A: 30 30      bmi   $C97C
C94C: 02        .byte $02
C94D: B0 30      bcs   $C97F
C94F: 02        .byte $02
C950: 70 30      bvs   $C982
C952: 03        .byte $03
C953: 70 30      bvs   $C985
C955: 03        .byte $03
C956: 70 30      bvs   $C988
C958: 03        .byte $03
C959: F0 30      beq   $C98B
C95B: 03        .byte $03
C95C: 30 30      bmi   $C98E
C95E: 03        .byte $03
C95F: B0 30      bcs   $C991
C961: 03        .byte $03
C962: 30 30      bmi   $C994
C964: 02        .byte $02
C965: 30 30      bmi   $C997
C967: 02        .byte $02
C968: BC 30 00   ldy   $0030,X
C96B: BC 30 00   ldy   $0030,X
C96E: BC 30 00   ldy   $0030,X
C971: BC 30 00   ldy   $0030,X
C974: 17 6D 32   bbc0  $6D,$C9A9
C977: 20 52 D0   jsr   $D052
C97A: F0 0B      beq   $C987
C97C: 85 F8      sta   $F8
C97E: A5 71      lda   $71
C980: 87 F7 20   bbs4  $F7,$C9A3
C983: AB         seb5  A
C984: C9 B0      cmp   #$B0
C986: 23        .byte $23
C987: 20 57 D0   jsr   $D057
C98A: F0 0C      beq   $C998
C98C: 85 F8      sta   $F8
C98E: AD 0A 01   lda   $010A
C991: 85 F7      sta   $F7
C993: 20 AB C9   jsr   $C9AB
C996: B0 12      bcs   $C9AA
C998: 20 5D D0   jsr   $D05D
C99B: F0 0C      beq   $C9A9
C99D: 85 F8      sta   $F8
C99F: AD 0B 01   lda   $010B
C9A2: 85 F7      sta   $F7
C9A4: 20 AB C9   jsr   $C9AB
C9A7: B0 01      bcs   $C9AA
C9A9: 18         clc   
C9AA: 60         rts   
C9AB: A5 F8      lda   $F8
C9AD: A2 74      ldx   #$74
C9AF: C9 08      cmp   #$08
C9B1: F0 16      beq   $C9C9
C9B3: A2 64      ldx   #$64
C9B5: C9 09      cmp   #$09
C9B7: F0 10      beq   $C9C9
C9B9: C9 0A      cmp   #$0A
C9BB: F0 0C      beq   $C9C9
C9BD: A2 64      ldx   #$64
C9BF: C9 05      cmp   #$05
C9C1: F0 06      beq   $C9C9
C9C3: A2 64      ldx   #$64
C9C5: C9 0D      cmp   #$0D
C9C7: F0 00      beq   $C9C9
C9C9: 8A         txa   
C9CA: C5 F7      cmp   $F7
C9CC: 60         rts   
C9CD: A9 00      lda   #$00
C9CF: 85 EA      sta   $EA
C9D1: F7 50 1D   bbc7  $50,$C9F1
C9D4: 97 C1 1C   bbc4  $C1,$C9F3
C9D7: 07 6D 19   bbs0  $6D,$C9F3
C9DA: 07 08 10   bbs0  $08,$C9ED
C9DD: 27 0E 0D   bbs1  $0E,$C9ED
C9E0: 20 9A D0   jsr   $D09A
C9E3: E0 00      cpx   #$00
C9E5: D0 06      bne   $C9ED
C9E7: A9 00      lda   #$00
C9E9: 85 EA      sta   $EA
C9EB: 80 04      bra   $C9F1
C9ED: A9 FF      lda   #$FF
C9EF: 85 EA      sta   $EA
C9F1: 18         clc   
C9F2: 60         rts   
C9F3: 38         sec   
C9F4: 60         rts   
C9F5: 20 FC C9   jsr   $C9FC
C9F8: 20 FC C9   jsr   $C9FC
C9FB: 60         rts   
C9FC: 60         rts   
C9FD: E7 50 1F   bbs7  $50,$CA1F
CA00: 07 6D 1C   bbs0  $6D,$CA1F
CA03: 0F 04      seb0  $04
CA05: 3C 04 A7   ldm   #$04,$A7
CA08: A9 C8      lda   #$C8
CA0A: 20 77 CD   jsr   $CD77
CA0D: B0 04      bcs   $CA13
CA0F: A5 A7      lda   $A7
CA11: D0 F7      bne   $CA0A
CA13: 1F 04      clb0  $04
CA15: 3C 02 A7   ldm   #$02,$A7
CA18: EA         nop   
CA19: A5 A7      lda   $A7
CA1B: D0 FB      bne   $CA18
CA1D: FF 95      clb7  $95
CA1F: 60         rts   
CA20: 1F C4      clb0  $C4
CA22: 20 52 D0   jsr   $D052
CA25: F0 D6      beq   $C9FD
CA27: C9 08      cmp   #$08
CA29: F0 0A      beq   $CA35
CA2B: C9 09      cmp   #$09
CA2D: F0 06      beq   $CA35
CA2F: C9 0A      cmp   #$0A
CA31: F0 02      beq   $CA35
CA33: 80 57      bra   $CA8C
CA35: 07 50 54   bbs0  $50,$CA8C
CA38: 20 CD C9   jsr   $C9CD
CA3B: B0 4F      bcs   $CA8C
CA3D: 47 C0 03   bbs2  $C0,$CA43
CA40: A7 50 49   bbs5  $50,$CA8C
CA43: A7 6C 46   bbs5  $6C,$CA8C
CA46: A5 73      lda   $73
CA48: D0 42      bne   $CA8C
CA4A: BF 6C      clb5  $6C
CA4C: 07 6D 3D   bbs0  $6D,$CA8C
CA4F: A5 71      lda   $71
CA51: C9 A9      cmp   #$A9
CA53: F0 02      beq   $CA57
CA55: B0 35      bcs   $CA8C
CA57: A5 6E      lda   $6E
CA59: C9 FF      cmp   #$FF
CA5B: F0 2F      beq   $CA8C
CA5D: C9 5F      cmp   #$5F
CA5F: 90 02      bcc   $CA63
CA61: 80 29      bra   $CA8C
CA63: A5 72      lda   $72
CA65: C5 ED      cmp   $ED
CA67: B0 23      bcs   $CA8C
CA69: C5 F0      cmp   $F0
CA6B: 90 1F      bcc   $CA8C
CA6D: C5 EE      cmp   $EE
CA6F: B0 0C      bcs   $CA7D
CA71: E7 C1 10   bbs7  $C1,$CA84
CA74: A5 EA      lda   $EA
CA76: D0 0C      bne   $CA84
CA78: 20 8D CA   jsr   $CA8D
CA7B: 80 0A      bra   $CA87
CA7D: 20 52 D0   jsr   $D052
CA80: C9 08      cmp   #$08
CA82: D0 ED      bne   $CA71
CA84: 20 A9 CA   jsr   $CAA9
CA87: A9 C8      lda   #$C8
CA89: 8D 02 01   sta   $0102
CA8C: 60         rts   
CA8D: EF 6C      seb7  $6C
CA8F: CF 6C      seb6  $6C
CA91: DF 0A      clb6  $0A
CA93: 3F 04      clb1  $04
CA95: 0F 04      seb0  $04
CA97: 3C 3C A6   ldm   #$3C,$A6
CA9A: 3C D2 9C   ldm   #$D2,$9C
CA9D: 1F 95      clb0  $95
CA9F: A5 F3      lda   $F3
CAA1: 85 F4      sta   $F4
CAA3: 3C 0A 98   ldm   #$0A,$98
CAA6: 9F 95      clb4  $95
CAA8: 60         rts   
CAA9: EF 6C      seb7  $6C
CAAB: DF 6C      clb6  $6C
CAAD: DF 0A      clb6  $0A
CAAF: 0F 04      seb0  $04
CAB1: 3F 04      clb1  $04
CAB3: 3C 3C A6   ldm   #$3C,$A6
CAB6: 3C D2 9C   ldm   #$D2,$9C
CAB9: 1F 95      clb0  $95
CABB: 3C 0A 98   ldm   #$0A,$98
CABE: 3C 30 E8   ldm   #$30,$E8
CAC1: 9F 95      clb4  $95
CAC3: 60         rts   
CAC4: 4C 9B CB   jmp   $CB9B
CAC7: 4C A4 CB   jmp   $CBA4
CACA: A5 EB      lda   $EB
CACC: 85 EC      sta   $EC
CACE: A5 70      lda   $70
CAD0: 85 EB      sta   $EB
CAD2: 3C 05 E6   ldm   #$05,$E6
CAD5: 20 52 D0   jsr   $D052
CAD8: D0 03      bne   $CADD
CADA: 4C 9D CB   jmp   $CB9D
CADD: A9 60      lda   #$60
CADF: 07 6D E2   bbs0  $6D,$CAC4
CAE2: A5 72      lda   $72
CAE4: C5 F1      cmp   $F1
CAE6: A9 20      lda   #$20
CAE8: B0 DA      bcs   $CAC4
CAEA: A5 72      lda   $72
CAEC: C5 F2      cmp   $F2
CAEE: A9 21      lda   #$21
CAF0: 90 D2      bcc   $CAC4
CAF2: A5 71      lda   $71
CAF4: C9 3E      cmp   #$3E
CAF6: A9 01      lda   #$01
CAF8: 90 CD      bcc   $CAC7
CAFA: A5 71      lda   $71
CAFC: C9 B4      cmp   #$B4
CAFE: 90 10      bcc   $CB10
CB00: A5 E7      lda   $E7
CB02: F0 07      beq   $CB0B
CB04: 1A        .byte $1A
CB05: F0 04      beq   $CB0B
CB07: 85 E7      sta   $E7
CB09: 80 08      bra   $CB13
CB0B: A9 02      lda   #$02
CB0D: 4C A4 CB   jmp   $CBA4
CB10: 3C 03 E7   ldm   #$03,$E7
CB13: A5 70      lda   $70
CB15: C9 07      cmp   #$07
CB17: B0 02      bcs   $CB1B
CB19: 0F C4      seb0  $C4
CB1B: C9 7B      cmp   #$7B
CB1D: A9 11      lda   #$11
CB1F: 90 03      bcc   $CB24
CB21: 4C A4 CB   jmp   $CBA4
CB24: A9 70      lda   #$70
CB26: 07 95 72   bbs0  $95,$CB9B
CB29: A5 70      lda   $70
CB2B: C9 03      cmp   #$03
CB2D: B0 05      bcs   $CB34
CB2F: 3C 10 73   ldm   #$10,$73
CB32: 80 7E      bra   $CBB2
CB34: C7 6C 07   bbs6  $6C,$CB3E
CB37: 20 DA CB   jsr   $CBDA
CB3A: 90 2D      bcc   $CB69
CB3C: 80 66      bra   $CBA4
CB3E: A5 A6      lda   $A6
CB40: C9 05      cmp   #$05
CB42: 90 01      bcc   $CB45
CB44: 60         rts   
CB45: A6 71      ldx   $71
CB47: E0 68      cpx   #$68
CB49: B0 04      bcs   $CB4F
CB4B: A9 03      lda   #$03
CB4D: 80 55      bra   $CBA4
CB4F: A5 F4      lda   $F4
CB51: D0 16      bne   $CB69
CB53: 17 04 13   bbc0  $04,$CB69
CB56: A5 6E      lda   $6E
CB58: C9 5A      cmp   #$5A
CB5A: B0 0D      bcs   $CB69
CB5C: A5 70      lda   $70
CB5E: C9 0A      cmp   #$0A
CB60: 90 07      bcc   $CB69
CB62: 1F 04      clb0  $04
CB64: 2F 04      seb1  $04
CB66: 3C 04 A6   ldm   #$04,$A6
CB69: AD 02 01   lda   $0102
CB6C: C9 FF      cmp   #$FF
CB6E: F0 26      beq   $CB96
CB70: A5 70      lda   $70
CB72: C9 06      cmp   #$06
CB74: 90 06      bcc   $CB7C
CB76: A9 09      lda   #$09
CB78: 8D 02 01   sta   $0102
CB7B: 60         rts   
CB7C: AD 02 01   lda   $0102
CB7F: F0 05      beq   $CB86
CB81: 1A        .byte $1A
CB82: 8D 02 01   sta   $0102
CB85: 60         rts   
CB86: A5 71      lda   $71
CB88: C9 A9      cmp   #$A9
CB8A: 90 EA      bcc   $CB76
CB8C: A9 FF      lda   #$FF
CB8E: 8D 02 01   sta   $0102
CB91: A9 28      lda   #$28
CB93: 85 98      sta   $98
CB95: 60         rts   
CB96: A5 98      lda   $98
CB98: F0 18      beq   $CBB2
CB9A: 60         rts   
CB9B: 85 73      sta   $73
CB9D: 20 98 CC   jsr   $CC98
CBA0: 20 5E CC   jsr   $CC5E
CBA3: 60         rts   
CBA4: AF 6C      seb5  $6C
CBA6: 85 73      sta   $73
CBA8: 20 98 CC   jsr   $CC98
CBAB: 20 5E CC   jsr   $CC5E
CBAE: 20 67 CE   jsr   $CE67
CBB1: 60         rts   
CBB2: A2 04      ldx   #$04
CBB4: A5 71      lda   $71
CBB6: C9 A2      cmp   #$A2
CBB8: 90 1C      bcc   $CBD6
CBBA: A5 A6      lda   $A6
CBBC: D0 DF      bne   $CB9D
CBBE: A5 EC      lda   $EC
CBC0: C9 05      cmp   #$05
CBC2: B0 D9      bcs   $CB9D
CBC4: 20 5E CC   jsr   $CC5E
CBC7: 20 81 CC   jsr   $CC81
CBCA: 90 09      bcc   $CBD5
CBCC: C9 32      cmp   #$32
CBCE: A2 40      ldx   #$40
CBD0: 90 D2      bcc   $CBA4
CBD2: 3C 48 73   ldm   #$48,$73
CBD5: 60         rts   
CBD6: 8A         txa   
CBD7: 4C A4 CB   jmp   $CBA4
CBDA: A5 A6      lda   $A6
CBDC: D0 4D      bne   $CC2B
CBDE: A2 03      ldx   #$03
CBE0: A5 71      lda   $71
CBE2: C9 68      cmp   #$68
CBE4: 90 47      bcc   $CC2D
CBE6: A5 98      lda   $98
CBE8: D0 41      bne   $CC2B
CBEA: AD 02 01   lda   $0102
CBED: C9 FF      cmp   #$FF
CBEF: F0 3A      beq   $CC2B
CBF1: C6 E8      dec   $E8
CBF3: F0 2C      beq   $CC21
CBF5: 3C 0A 98   ldm   #$0A,$98
CBF8: 9F 95      clb4  $95
CBFA: 3C D2 9C   ldm   #$D2,$9C
CBFD: A5 72      lda   $72
CBFF: C5 EF      cmp   $EF
CC01: B0 28      bcs   $CC2B
CC03: A5 6E      lda   $6E
CC05: C9 5A      cmp   #$5A
CC07: B0 22      bcs   $CC2B
CC09: A5 70      lda   $70
CC0B: C9 0A      cmp   #$0A
CC0D: 90 1C      bcc   $CC2B
CC0F: E7 C1 19   bbs7  $C1,$CC2B
CC12: A5 EA      lda   $EA
CC14: D0 15      bne   $CC2B
CC16: CF 6C      seb6  $6C
CC18: 3C 07 A6   ldm   #$07,$A6
CC1B: A5 F3      lda   $F3
CC1D: 85 F4      sta   $F4
CC1F: 80 0A      bra   $CC2B
CC21: A9 70      lda   #$70
CC23: 85 73      sta   $73
CC25: 20 98 CC   jsr   $CC98
CC28: 20 5E CC   jsr   $CC5E
CC2B: 18         clc   
CC2C: 60         rts   
CC2D: 8A         txa   
CC2E: 38         sec   
CC2F: 60         rts   
CC30: 4C A4 CB   jmp   $CBA4
CC33: 60         rts   
CC34: 07 04 04   bbs0  $04,$CC3B
CC37: 0F 04      seb0  $04
CC39: 80 0E      bra   $CC49
CC3B: A5 A6      lda   $A6
CC3D: C9 04      cmp   #$04
CC3F: 90 08      bcc   $CC49
CC41: A5 70      lda   $70
CC43: C9 04      cmp   #$04
CC45: B0 02      bcs   $CC49
CC47: 1F 04      clb0  $04
CC49: 60         rts   
CC4A: 60         rts   
CC4B: 07 04 0F   bbs0  $04,$CC5D
CC4E: 27 04 04   bbs1  $04,$CC55
CC51: 2F 04      seb1  $04
CC53: 80 08      bra   $CC5D
CC55: A5 70      lda   $70
CC57: C9 04      cmp   #$04
CC59: B0 02      bcs   $CC5D
CC5B: 3F 04      clb1  $04
CC5D: 60         rts   
CC5E: E7 6C 09   bbs7  $6C,$CC6A
CC61: 27 04 06   bbs1  $04,$CC6A
CC64: 07 04 03   bbs0  $04,$CC6A
CC67: 18         clc   
CC68: 80 01      bra   $CC6B
CC6A: 38         sec   
CC6B: 08         php   
CC6C: FF 6C      clb7  $6C
CC6E: CF 0A      seb6  $0A
CC70: 3F 04      clb1  $04
CC72: 1F 04      clb0  $04
CC74: 3C 00 9C   ldm   #$00,$9C
CC77: 3C 00 98   ldm   #$00,$98
CC7A: 1F 95      clb0  $95
CC7C: 9F 95      clb4  $95
CC7E: 28         plp   
CC7F: EA         nop   
CC80: 60         rts   
CC81: 37 C0 02   bbc1  $C0,$CC86
CC84: 18         clc   
CC85: 60         rts   
CC86: A5 6E      lda   $6E
CC88: 85 6F      sta   $6F
CC8A: C9 4B      cmp   #$4B
CC8C: B0 02      bcs   $CC90
CC8E: 38         sec   
CC8F: 60         rts   
CC90: 3C 64 6E   ldm   #$64,$6E
CC93: 20 01 C3   jsr   $C301
CC96: 18         clc   
CC97: 60         rts   
CC98: A5 6E      lda   $6E
CC9A: C9 64      cmp   #$64
CC9C: F0 05      beq   $CCA3
CC9E: 90 03      bcc   $CCA3
CCA0: 20 81 CC   jsr   $CC81
CCA3: 18         clc   
CCA4: 60         rts   
CCA5: 20 52 D0   jsr   $D052
CCA8: D0 14      bne   $CCBE
CCAA: 20 75 D0   jsr   $D075
CCAD: F0 4B      beq   $CCFA
CCAF: 05 6C      ora   $6C
CCB1: 85 6C      sta   $6C
CCB3: 3C FF 6E   ldm   #$FF,$6E
CCB6: 3C FF 6F   ldm   #$FF,$6F
CCB9: FF 08      clb7  $08
CCBB: 4C FA CC   jmp   $CCFA
CCBE: 20 75 D0   jsr   $D075
CCC1: F0 22      beq   $CCE5
CCC3: A5 6E      lda   $6E
CCC5: C9 FF      cmp   #$FF
CCC7: F0 02      beq   $CCCB
CCC9: 18         clc   
CCCA: 60         rts   
CCCB: 20 D7 CF   jsr   $CFD7
CCCE: FB         clb7  A
CCCF: 85 6F      sta   $6F
CCD1: C9 FF      cmp   #$FF
CCD3: F0 04      beq   $CCD9
CCD5: 85 6E      sta   $6E
CCD7: 80 07      bra   $CCE0
CCD9: C5 6E      cmp   $6E
CCDB: D0 06      bne   $CCE3
CCDD: 3C 34 6E   ldm   #$34,$6E
CCE0: 20 01 C3   jsr   $C301
CCE3: 18         clc   
CCE4: 60         rts   
CCE5: A5 6C      lda   $6C
CCE7: 29 F0      and   #$F0
CCE9: 85 6C      sta   $6C
CCEB: 20 4A CE   jsr   $CE4A
CCEE: 3C 00 6E   ldm   #$00,$6E
CCF1: 3C 00 6F   ldm   #$00,$6F
CCF4: 3C 00 5B   ldm   #$00,$5B
CCF7: 3C 00 5C   ldm   #$00,$5C
CCFA: 38         sec   
CCFB: 60         rts   
CCFC: 3C 00 68   ldm   #$00,$68
CCFF: 3C 00 69   ldm   #$00,$69
CD02: 60         rts   
CD03: 3C 00 62   ldm   #$00,$62
CD06: 3C 00 63   ldm   #$00,$63
CD09: 3C 00 64   ldm   #$00,$64
CD0C: 60         rts   
CD0D: 3C 00 65   ldm   #$00,$65
CD10: 3C 00 66   ldm   #$00,$66
CD13: 3C 00 67   ldm   #$00,$67
CD16: 60         rts   
CD17: 0A         asl   A
CD18: 0A         asl   A
CD19: 0A         asl   A
CD1A: 48         pha   
CD1B: 48         pha   
CD1C: AA         tax   
CD1D: BD 47 CD   lda   $CD47,X
CD20: 85 F5      sta   $F5
CD22: BD 48 CD   lda   $CD48,X
CD25: 85 F6      sta   $F6
CD27: 78         sei   
CD28: 20 F9 E6   jsr   $E6F9
CD2B: 68         pla   
CD2C: AA         tax   
CD2D: BD 49 CD   lda   $CD49,X
CD30: 85 F5      sta   $F5
CD32: BD 4A CD   lda   $CD4A,X
CD35: 85 F6      sta   $F6
CD37: 02        .byte $02
CD38: F5 68      sbc   $68,X
CD3A: AA         tax   
CD3B: BD 4B CD   lda   $CD4B,X
CD3E: 85 F5      sta   $F5
CD40: BD 4C CD   lda   $CD4C,X
CD43: 85 F6      sta   $F6
CD45: B2        .byte $B2
CD46: F5 66      sbc   $66,X
CD48: E7 43 E8   bbs7  $43,$CD33
CD4B: 29 C1      and   #$C1
CD4D: 00         brk   
CD4E: 00         brk   
CD4F: 87 E7 77   bbs4  $E7,$CDC9
CD52: E8         inx   
CD53: 29 C1      and   #$C1
CD55: 00         brk   
CD56: 00         brk   
CD57: B4 E7      ldy   $E7,X
CD59: B0 E8      bcs   $CD43
CD5B: 29 C1      and   #$C1
CD5D: 00         brk   
CD5E: 00         brk   
CD5F: 87 E7 77   bbs4  $E7,$CDD9
CD62: E8         inx   
CD63: 29 C1      and   #$C1
CD65: 00         brk   
CD66: 00         brk   
CD67: B4 E7      ldy   $E7,X
CD69: A8         tay   
CD6A: E8         inx   
CD6B: 29 C1      and   #$C1
CD6D: 00         brk   
CD6E: 00         brk   
CD6F: 66 E7      ror   $E7
CD71: 43        .byte $43
CD72: E8         inx   
CD73: 29 C1      and   #$C1
CD75: 00         brk   
CD76: 00         brk   
CD77: E7 50 09   bbs7  $50,$CD83
CD7A: C7 50 12   bbs6  $50,$CD8F
CD7D: A7 50 1B   bbs5  $50,$CD9B
CD80: 42         stp   
CD81: 80 FD      bra   $CD80
CD83: A9 00      lda   #$00
CD85: 07 0E 1C   bbs0  $0E,$CDA4
CD88: A9 01      lda   #$01
CD8A: 37 0A 17   bbc1  $0A,$CDA4
CD8D: 80 17      bra   $CDA6
CD8F: A9 03      lda   #$03
CD91: 37 0A 10   bbc1  $0A,$CDA4
CD94: A9 02      lda   #$02
CD96: 17 0E 0B   bbc0  $0E,$CDA4
CD99: 80 0B      bra   $CDA6
CD9B: A9 04      lda   #$04
CD9D: 27 0A 04   bbs1  $0A,$CDA4
CDA0: A9 05      lda   #$05
CDA2: 80 02      bra   $CDA6
CDA4: 38         sec   
CDA5: 60         rts   
CDA6: 18         clc   
CDA7: 60         rts   
CDA8: 07 82 30   bbs0  $82,$CDDB
CDAB: A5 8F      lda   $8F
CDAD: D0 2C      bne   $CDDB
CDAF: 07 08 03   bbs0  $08,$CDB5
CDB2: 37 0E 15   bbc1  $0E,$CDCA
CDB5: 20 9A D0   jsr   $D09A
CDB8: 8A         txa   
CDB9: F0 0F      beq   $CDCA
CDBB: 07 6D 1D   bbs0  $6D,$CDDB
CDBE: 20 95 CE   jsr   $CE95
CDC1: 0F 6D      seb0  $6D
CDC3: 20 4A CE   jsr   $CE4A
CDC6: A9 00      lda   #$00
CDC8: 38         sec   
CDC9: 60         rts   
CDCA: 17 6D 0E   bbc0  $6D,$CDDB
CDCD: 20 95 CE   jsr   $CE95
CDD0: 1F 6D      clb0  $6D
CDD2: FF 08      clb7  $08
CDD4: 20 4A CE   jsr   $CE4A
CDD7: A9 01      lda   #$01
CDD9: 38         sec   
CDDA: 60         rts   
CDDB: 18         clc   
CDDC: 60         rts   
CDDD: E7 CC 68   bbs7  $CC,$CE48
CDE0: 37 08 25   bbc1  $08,$CE08
CDE3: F7 D3 62   bbc7  $D3,$CE48
CDE6: 08         php   
CDE7: 78         sei   
CDE8: FF D3      clb7  $D3
CDEA: 1F D3      clb0  $D3
CDEC: 9F 02      clb4  $02
CDEE: 3C 00 00   ldm   #$00,$00
CDF1: 3C 00 01   ldm   #$00,$01
CDF4: 3C 00 D3   ldm   #$00,$D3
CDF7: 3C 00 D8   ldm   #$00,$D8
CDFA: EF 02      seb7  $02
CDFC: 3F 3E      clb1  $3E
CDFE: 7F 02      clb3  $02
CE00: 3F 02      clb1  $02
CE02: 28         plp   
CE03: EA         nop   
CE04: A9 00      lda   #$00
CE06: 38         sec   
CE07: 60         rts   
CE08: F7 50 3D   bbc7  $50,$CE48
CE0B: 37 0A 3A   bbc1  $0A,$CE48
CE0E: 07 0E 37   bbs0  $0E,$CE48
CE11: E7 D3 34   bbs7  $D3,$CE48
CE14: 08         php   
CE15: 78         sei   
CE16: 3F 3C      clb1  $3C
CE18: 2F 3E      seb1  $3E
CE1A: 6F 02      seb3  $02
CE1C: 2F 02      seb1  $02
CE1E: FF 02      clb7  $02
CE20: 8F 02      seb4  $02
CE22: 3C 00 00   ldm   #$00,$00
CE25: 3C FF 01   ldm   #$FF,$01
CE28: 3C 00 CE   ldm   #$00,$CE
CE2B: 3C 00 CF   ldm   #$00,$CF
CE2E: 3C 00 D0   ldm   #$00,$D0
CE31: 3C C1 D3   ldm   #$C1,$D3
CE34: 3C 80 D5   ldm   #$80,$D5
CE37: 3C 00 D8   ldm   #$00,$D8
CE3A: 3C 00 D9   ldm   #$00,$D9
CE3D: 7F 95      clb3  $95
CE3F: 3C 00 99   ldm   #$00,$99
CE42: 28         plp   
CE43: EA         nop   
CE44: A9 01      lda   #$01
CE46: 38         sec   
CE47: 60         rts   
CE48: 18         clc   
CE49: 60         rts   
CE4A: A5 73      lda   $73
CE4C: 8D 00 01   sta   $0100
CE4F: A9 00      lda   #$00
CE51: 85 73      sta   $73
CE53: B7 6C 10   bbc5  $6C,$CE66
CE56: BF 6C      clb5  $6C
CE58: 08         php   
CE59: 78         sei   
CE5A: 3C 00 88   ldm   #$00,$88
CE5D: 3C 00 8C   ldm   #$00,$8C
CE60: DF 82      clb6  $82
CE62: BF 82      clb5  $82
CE64: 28         plp   
CE65: EA         nop   
CE66: 60         rts   
CE67: 08         php   
CE68: 78         sei   
CE69: 3C 00 87   ldm   #$00,$87
CE6C: 3C 02 89   ldm   #$02,$89
CE6F: 3C 02 8A   ldm   #$02,$8A
CE72: 3C 01 8B   ldm   #$01,$8B
CE75: 3C 02 8D   ldm   #$02,$8D
CE78: 3C 02 8E   ldm   #$02,$8E
CE7B: CF 82      seb6  $82
CE7D: AF 82      seb5  $82
CE7F: 28         plp   
CE80: EA         nop   
CE81: 60         rts   
CE82: E7 6C 0F   bbs7  $6C,$CE94
CE85: 08         php   
CE86: 78         sei   
CE87: 3C 00 8B   ldm   #$00,$8B
CE8A: 3C 02 8D   ldm   #$02,$8D
CE8D: 3C 02 8E   ldm   #$02,$8E
CE90: AF 82      seb5  $82
CE92: 28         plp   
CE93: EA         nop   
CE94: 60         rts   
CE95: F7 50 0C   bbc7  $50,$CEA4
CE98: 08         php   
CE99: 78         sei   
CE9A: 3C C5 90   ldm   #$C5,$90
CE9D: 3C CE 91   ldm   #$CE,$91
CEA0: 0F 82      seb0  $82
CEA2: 28         plp   
CEA3: EA         nop   
CEA4: 60         rts   
CEA5: F7 50 0C   bbc7  $50,$CEB4
CEA8: 08         php   
CEA9: 78         sei   
CEAA: 3C D0 90   ldm   #$D0,$90
CEAD: 3C CE 91   ldm   #$CE,$91
CEB0: 0F 82      seb0  $82
CEB2: 28         plp   
CEB3: EA         nop   
CEB4: 60         rts   
CEB5: F7 50 0C   bbc7  $50,$CEC4
CEB8: 08         php   
CEB9: 78         sei   
CEBA: 3C DE 90   ldm   #$DE,$90
CEBD: 3C CE 91   ldm   #$CE,$91
CEC0: 0F 82      seb0  $82
CEC2: 28         plp   
CEC3: EA         nop   
CEC4: 60         rts   
CEC5: 00         brk   
CEC6: 00         brk   
CEC7: 01 15      ora   ($15,X)
CEC9: 00         brk   
CECA: 05 1A      ora   $1A
CECC: 00         brk   
CECD: 05 FF      ora   $FF
CECF: FF 00      clb7  $00
CED1: 00         brk   
CED2: 01 1E      ora   ($1E,X)
CED4: 00         brk   
CED5: 05 00      ora   $00
CED7: 00         brk   
CED8: 05 1E      ora   $1E
CEDA: 00         brk   
CEDB: 05 FF      ora   $FF
CEDD: FF 00      clb7  $00
CEDF: 00         brk   
CEE0: 01 1E      ora   ($1E,X)
CEE2: 00         brk   
CEE3: 14        .byte $14
CEE4: 7A        .byte $7A
CEE5: 00         brk   
CEE6: 14        .byte $14
CEE7: 1E 00 14   asl   $1400,X
CEEA: 7A        .byte $7A
CEEB: 00         brk   
CEEC: 14        .byte $14
CEED: 1E 00 14   asl   $1400,X
CEF0: 7A        .byte $7A
CEF1: 00         brk   
CEF2: 14        .byte $14
CEF3: 00         brk   
CEF4: 00         brk   
CEF5: 0A         asl   A
CEF6: 1E 00 14   asl   $1400,X
CEF9: 7A        .byte $7A
CEFA: 00         brk   
CEFB: 14        .byte $14
CEFC: 1E 00 14   asl   $1400,X
CEFF: 7A        .byte $7A
CF00: 00         brk   
CF01: 14        .byte $14
CF02: 1E 00 14   asl   $1400,X
CF05: 7A        .byte $7A
CF06: 00         brk   
CF07: 14        .byte $14
CF08: FF FF      clb7  $FF
CF0A: 3C 00 74   ldm   #$00,$74
CF0D: 3C 00 7A   ldm   #$00,$7A
CF10: 3C 00 7B   ldm   #$00,$7B
CF13: 3C FF 75   ldm   #$FF,$75
CF16: 3C FF 7C   ldm   #$FF,$7C
CF19: 3C FF 7D   ldm   #$FF,$7D
CF1C: 60         rts   
CF1D: 3C 00 76   ldm   #$00,$76
CF20: 3C 00 77   ldm   #$00,$77
CF23: 3C FF 78   ldm   #$FF,$78
CF26: 3C FF 79   ldm   #$FF,$79
CF29: 60         rts   
CF2A: 78         sei   
CF2B: 00         brk   
CF2C: 00         brk   
CF2D: 83        .byte $83
CF2E: 01 00      ora   ($00,X)
CF30: 8C 05 03   sty   $0305
CF33: 8E 0A 04   stx   $040A
CF36: 90 14      bcc   $CF4C
CF38: 07 92 1E   bbs0  $92,$CF59
CF3B: 07 94 28   bbs0  $94,$CF66
CF3E: 07 95 32   bbs0  $95,$CF73
CF41: 07 97 3C   bbs0  $97,$CF80
CF44: 07 99 46   bbs0  $99,$CF8D
CF47: 07 9C 50   bbs0  $9C,$CF9A
CF4A: 07 9F 5A   bbs0  $9F,$CFA7
CF4D: 07 A2 64   bbs0  $A2,$CFB4
CF50: 07 FF 64   bbs0  $FF,$CFB7
CF53: 00         brk   
CF54: 6C 00 00   jmp   ($0000)
CF57: 70 01      bvs   $CF5A
CF59: 00         brk   
CF5A: 77 05 03   bbc3  $05,$CF60
CF5D: 7E 0A 04   ror   $040A,X
CF60: 88         dey   
CF61: 14        .byte $14
CF62: 07 8F 1E   bbs0  $8F,$CF83
CF65: 07 95 28   bbs0  $95,$CF90
CF68: 07 97 32   bbs0  $97,$CF9D
CF6B: 07 99 3C   bbs0  $99,$CFAA
CF6E: 07 9B 46   bbs0  $9B,$CFB7
CF71: 07 9D 50   bbs0  $9D,$CFC4
CF74: 07 A0 5A   bbs0  $A0,$CFD1
CF77: 07 A2 64   bbs0  $A2,$CFDE
CF7A: 07 FF 64   bbs0  $FF,$CFE1
CF7D: 00         brk   
CF7E: 74        .byte $74
CF7F: 00         brk   
CF80: 00         brk   
CF81: 7D 01 00   adc   $0001,X
CF84: 81 05      sta   ($05,X)
CF86: 03        .byte $03
CF87: 8A         txa   
CF88: 0A         asl   A
CF89: 04        .byte $04
CF8A: 96 14      stx   $14,Y
CF8C: 07 9F 1E   bbs0  $9F,$CFAD
CF8F: 07 A9 28   bbs0  $A9,$CFBA
CF92: 07 B3 32   bbs0  $B3,$CFC7
CF95: 07 BD 3C   bbs0  $BD,$CFD4
CF98: 07 C7 46   bbs0  $C7,$CFE1
CF9B: 07 D1 50   bbs0  $D1,$CFEE
CF9E: 07 DB 5A   bbs0  $DB,$CFFB
CFA1: 07 DB 64   bbs0  $DB,$D008
CFA4: 07 FF 64   bbs0  $FF,$D00B
CFA7: 00         brk   
CFA8: 74        .byte $74
CFA9: 00         brk   
CFAA: 00         brk   
CFAB: 83        .byte $83
CFAC: 01 00      ora   ($00,X)
CFAE: 87 05 03   bbs4  $05,$CFB4
CFB1: 90 0A      bcc   $CFBD
CFB3: 04        .byte $04
CFB4: 9A         txs   
CFB5: 14        .byte $14
CFB6: 07 A4 1E   bbs0  $A4,$CFD7
CFB9: 07 AE 28   bbs0  $AE,$CFE4
CFBC: 07 B7 32   bbs0  $B7,$CFF1
CFBF: 07 C1 3C   bbs0  $C1,$CFFE
CFC2: 07 CB 46   bbs0  $CB,$D00B
CFC5: 07 D5 50   bbs0  $D5,$D018
CFC8: 07 DF 5A   bbs0  $DF,$D025
CFCB: 07 DF 64   bbs0  $DF,$D032
CFCE: 07 FF 64   bbs0  $FF,$D035
CFD1: 00         brk   
CFD2: 34        .byte $34
CFD3: 00         brk   
CFD4: 22        .byte $22
CFD5: 47 00 20   bbs2  $00,$CFF8
CFD8: 52        .byte $52
CFD9: D0 20      bne   $CFFB
CFDB: 19 D0 A0   ora   $A0D0,Y
CFDE: 00         brk   
CFDF: 3C 07 F9   ldm   #$07,$F9
CFE2: 17 6D 14   bbc0  $6D,$CFF9
CFE5: A2 00      ldx   #$00
CFE7: A5 6B      lda   $6B
CFE9: 62 6A      mul   $6A,X
CFEB: 68         pla   
CFEC: C9 1C      cmp   #$1C
CFEE: 90 02      bcc   $CFF2
CFF0: A9 1B      lda   #$1B
CFF2: AA         tax   
CFF3: BD 7D C5   lda   $C57D,X
CFF6: 3A        .byte $3A
CFF7: 85 F9      sta   $F9
CFF9: B1 F5      lda   ($F5),Y
CFFB: C9 FF      cmp   #$FF
CFFD: F0 0C      beq   $D00B
CFFF: 18         clc   
D000: E9 F9      sbc   #$F9
D002: C5 6A      cmp   $6A
D004: B0 05      bcs   $D00B
D006: C8         iny   
D007: C8         iny   
D008: C8         iny   
D009: 80 EE      bra   $CFF9
D00B: C8         iny   
D00C: B1 F5      lda   ($F5),Y
D00E: C8         iny   
D00F: 38         sec   
D010: F1 F5      sbc   ($F5),Y
D012: 60         rts   
D013: A9 FF      lda   #$FF
D015: 60         rts   
D016: A9 FF      lda   #$FF
D018: 60         rts   
D019: C9 09      cmp   #$09
D01B: F0 2C      beq   $D049
D01D: C9 0A      cmp   #$0A
D01F: F0 28      beq   $D049
D021: C9 08      cmp   #$08
D023: F0 0C      beq   $D031
D025: C9 05      cmp   #$05
D027: D0 08      bne   $D031
D029: A5 C8      lda   $C8
D02B: C9 01      cmp   #$01
D02D: F0 0A      beq   $D039
D02F: 80 10      bra   $D041
D031: 3C 2A F5   ldm   #$2A,$F5
D034: 3C CF F6   ldm   #$CF,$F6
D037: 80 18      bra   $D051
D039: 3C A8 F5   ldm   #$A8,$F5
D03C: 3C CF F6   ldm   #$CF,$F6
D03F: 80 10      bra   $D051
D041: 3C 7E F5   ldm   #$7E,$F5
D044: 3C CF F6   ldm   #$CF,$F6
D047: 80 08      bra   $D051
D049: 3C 54 F5   ldm   #$54,$F5
D04C: 3C CF F6   ldm   #$CF,$F6
D04F: 80 00      bra   $D051
D051: 60         rts   
D052: A5 6C      lda   $6C
D054: 29 0F      and   #$0F
D056: 60         rts   
D057: AD 08 01   lda   $0108
D05A: 29 0F      and   #$0F
D05C: 60         rts   
D05D: AD 09 01   lda   $0109
D060: 29 0F      and   #$0F
D062: 60         rts   
D063: 20 52 D0   jsr   $D052
D066: 85 F7      sta   $F7
D068: 20 57 D0   jsr   $D057
D06B: 05 F7      ora   $F7
D06D: 85 F7      sta   $F7
D06F: 20 5D D0   jsr   $D05D
D072: 05 F7      ora   $F7
D074: 60         rts   
D075: A5 71      lda   $71
D077: C9 2A      cmp   #$2A
D079: 90 04      bcc   $D07F
D07B: 20 C3 D0   jsr   $D0C3
D07E: 60         rts   
D07F: A9 00      lda   #$00
D081: 60         rts   
D082: 17 08 FA   bbc0  $08,$D07F
D085: AD 0B 01   lda   $010B
D088: C9 2A      cmp   #$2A
D08A: 90 F3      bcc   $D07F
D08C: A6 C8      ldx   $C8
D08E: BD 93 D0   lda   $D093,X
D091: 80 1A      bra   $D0AD
D093: 01 02      ora   ($02,X)
D095: 02        .byte $02
D096: 04        .byte $04
D097: 05 06      ora   $06
D099: 07 A2 FF   bbs0  $A2,$D09B
D09C: AD 0A 01   lda   $010A
D09F: C9 2A      cmp   #$2A
D0A1: 90 DC      bcc   $D07F
D0A3: A9 00      lda   #$00
D0A5: D7 08 01   bbc6  $08,$D0A9
D0A8: 2B         seb1  A
D0A9: 97 06 01   bbc4  $06,$D0AD
D0AC: 0B         seb0  A
D0AD: AA         tax   
D0AE: BD BB D0   lda   $D0BB,X
D0B1: F0 07      beq   $D0BA
D0B3: C9 FF      cmp   #$FF
D0B5: D0 03      bne   $D0BA
D0B7: 20 C3 D0   jsr   $D0C3
D0BA: 60         rts   
D0BB: 00         brk   
D0BC: FF 05      clb7  $05
D0BE: 00         brk   
D0BF: 09 08      ora   #$08
D0C1: 09 08      ora   #$08
D0C3: A5 C7      lda   $C7
D0C5: C9 73      cmp   #$73
D0C7: F0 07      beq   $D0D0
D0C9: C9 70      cmp   #$70
D0CB: F0 06      beq   $D0D3
D0CD: A9 08      lda   #$08
D0CF: 60         rts   
D0D0: A9 09      lda   #$09
D0D2: 60         rts   
D0D3: A9 08      lda   #$08
D0D5: 60         rts   
D0D6: 4F 0A      seb2  $0A
D0D8: 6F 0A      seb3  $0A
D0DA: 60         rts   
D0DB: 57 C0 03   bbc2  $C0,$D0E1
D0DE: 17 6D 04   bbc0  $6D,$D0E5
D0E1: 5F 0A      clb2  $0A
D0E3: 7F 0A      clb3  $0A
D0E5: 60         rts   
D0E6: A0 00      ldy   #$00
D0E8: 20 52 D0   jsr   $D052
D0EB: D0 0B      bne   $D0F8
D0ED: 20 57 D0   jsr   $D057
D0F0: D0 14      bne   $D106
D0F2: 20 5D D0   jsr   $D05D
D0F5: D0 1E      bne   $D115
D0F7: 60         rts   
D0F8: A5 6E      lda   $6E
D0FA: AE 06 01   ldx   $0106
D0FD: E0 FF      cpx   #$FF
D0FF: F0 08      beq   $D109
D101: CD 06 01   cmp   $0106
D104: B0 03      bcs   $D109
D106: AD 06 01   lda   $0106
D109: AE 07 01   ldx   $0107
D10C: E0 FF      cpx   #$FF
D10E: F0 08      beq   $D118
D110: CD 07 01   cmp   $0107
D113: B0 03      bcs   $D118
D115: AD 07 01   lda   $0107
D118: AA         tax   
D119: A2 FF      ldx   #$FF
D11B: 60         rts   
D11C: 67 3F 10   bbs3  $3F,$D12F
D11F: 77 3D 0D   bbc3  $3D,$D12F
D122: AD 1A 01   lda   $011A
D125: C9 FF      cmp   #$FF
D127: F0 06      beq   $D12F
D129: 3A        .byte $3A
D12A: 8D 1A 01   sta   $011A
D12D: 7F 3D      clb3  $3D
D12F: 60         rts   
D130: E7 50 0B   bbs7  $50,$D13E
D133: 77 39 09   bbc3  $39,$D13F
D136: 17 6D 05   bbc0  $6D,$D13E
D139: A7 50 03   bbs5  $50,$D13F
D13C: 58         cli   
D13D: C2         wit   
D13E: 60         rts   
D13F: 20 E6 D0   jsr   $D0E6
D142: C9 FF      cmp   #$FF
D144: F0 F6      beq   $D13C
D146: A5 C0      lda   $C0
D148: D0 F2      bne   $D13C
D14A: A5 C1      lda   $C1
D14C: D0 EE      bne   $D13C
D14E: 27 BF EB   bbs1  $BF,$D13C
D151: AD 1A 01   lda   $011A
D154: C9 FF      cmp   #$FF
D156: D0 E4      bne   $D13C
D158: A5 C6      lda   $C6
D15A: C9 03      cmp   #$03
D15C: D0 DE      bne   $D13C
D15E: 78         sei   
D15F: 20 BB D1   jsr   $D1BB
D162: 3C 00 3E   ldm   #$00,$3E
D165: 3C 00 3F   ldm   #$00,$3F
D168: 3C 00 3C   ldm   #$00,$3C
D16B: 3C 00 3D   ldm   #$00,$3D
D16E: 6F 3F      seb3  $3F
D170: 8F 3F      seb4  $3F
D172: 58         cli   
D173: EA         nop   
D174: 42         stp   
D175: EA         nop   
D176: 60         rts   
D177: 48         pha   
D178: 8A         txa   
D179: 48         pha   
D17A: 98         tya   
D17B: 48         pha   
D17C: 7F 3F      clb3  $3F
D17E: 20 11 DA   jsr   $DA11
D181: 3C 04 A2   ldm   #$04,$A2
D184: EF 95      seb7  $95
D186: CF 3F      seb6  $3F
D188: AF 3E      seb5  $3E
D18A: 68         pla   
D18B: A8         tay   
D18C: 68         pla   
D18D: AA         tax   
D18E: 68         pla   
D18F: 40         rti   
D190: 48         pha   
D191: 8A         txa   
D192: 48         pha   
D193: 98         tya   
D194: 48         pha   
D195: 3C 00 3C   ldm   #$00,$3C
D198: 3C 00 3D   ldm   #$00,$3D
D19B: CF 3F      seb6  $3F
D19D: 7F 3F      clb3  $3F
D19F: 9F 3F      clb4  $3F
D1A1: A2 BE      ldx   #$BE
D1A3: 9A         txs   
D1A4: A9 04      lda   #$04
D1A6: 4C 17 CD   jmp   $CD17
D1A9: 68         pla   
D1AA: A8         tay   
D1AB: 68         pla   
D1AC: AA         tax   
D1AD: 68         pla   
D1AE: 40         rti   
D1AF: D7 50 08   bbc6  $50,$D1BA
D1B2: 57 08 05   bbc2  $08,$D1BA
D1B5: 37 0E 02   bbc1  $0E,$D1BA
D1B8: EF 08      seb7  $08
D1BA: 40         rti   
D1BB: A5 39      lda   $39
D1BD: 29 E7      and   #$E7
D1BF: 85 39      sta   $39
D1C1: 18         clc   
D1C2: 60         rts   
D1C3: A5 39      lda   $39
D1C5: 29 EF      and   #$EF
D1C7: 09 08      ora   #$08
D1C9: 85 39      sta   $39
D1CB: 38         sec   
D1CC: 60         rts   
D1CD: 97 BF 01   bbc4  $BF,$D1D1
D1D0: 60         rts   
D1D1: 37 0A 03   bbc1  $0A,$D1D7
D1D4: E7 50 09   bbs7  $50,$D1E0
D1D7: 9F 44      clb4  $44
D1D9: BF 44      clb5  $44
D1DB: DF 44      clb6  $44
D1DD: 4C 06 D2   jmp   $D206
D1E0: 77 BF 08   bbc3  $BF,$D1EB
D1E3: 20 E2 D4   jsr   $D4E2
D1E6: 90 03      bcc   $D1EB
D1E8: 4C 06 D2   jmp   $D206
D1EB: F7 06 04   bbc7  $06,$D1F2
D1EE: 9F 44      clb4  $44
D1F0: 80 02      bra   $D1F4
D1F2: 8F 44      seb4  $44
D1F4: D7 06 04   bbc6  $06,$D1FB
D1F7: BF 44      clb5  $44
D1F9: 80 02      bra   $D1FD
D1FB: AF 44      seb5  $44
D1FD: B7 06 04   bbc5  $06,$D204
D200: DF 44      clb6  $44
D202: 80 02      bra   $D206
D204: CF 44      seb6  $44
D206: A5 CD      lda   $CD
D208: C9 01      cmp   #$01
D20A: D0 0B      bne   $D217
D20C: 77 BF 08   bbc3  $BF,$D217
D20F: F7 50 05   bbc7  $50,$D217
D212: 07 44 0E   bbs0  $44,$D223
D215: 80 10      bra   $D227
D217: E7 6C 0F   bbs7  $6C,$D229
D21A: A7 6C 0C   bbs5  $6C,$D229
D21D: E7 50 07   bbs7  $50,$D227
D220: C7 50 04   bbs6  $50,$D227
D223: 1F 44      clb0  $44
D225: 80 02      bra   $D229
D227: 0F 44      seb0  $44
D229: B7 6C 0F   bbc5  $6C,$D23B
D22C: 27 44 06   bbs1  $44,$D235
D22F: 2F 44      seb1  $44
D231: 1F 44      clb0  $44
D233: 80 21      bra   $D256
D235: 3F 44      clb1  $44
D237: 0F 44      seb0  $44
D239: 80 1B      bra   $D256
D23B: E7 6C 04   bbs7  $6C,$D242
D23E: 3F 44      clb1  $44
D240: 80 14      bra   $D256
D242: 0F 44      seb0  $44
D244: C7 6C 03   bbs6  $6C,$D24A
D247: 27 44 0A   bbs1  $44,$D254
D24A: 17 C4 03   bbc0  $C4,$D250
D24D: E7 C4 04   bbs7  $C4,$D254
D250: 2F 44      seb1  $44
D252: 80 02      bra   $D256
D254: 3F 44      clb1  $44
D256: 20 97 D4   jsr   $D497
D259: C9 01      cmp   #$01
D25B: D0 12      bne   $D26F
D25D: 20 93 D2   jsr   $D293
D260: A5 CD      lda   $CD
D262: C9 02      cmp   #$02
D264: D0 08      bne   $D26E
D266: 77 BF 05   bbc3  $BF,$D26E
D269: F7 50 02   bbc7  $50,$D26E
D26C: 6F 41      seb3  $41
D26E: 60         rts   
D26F: C9 02      cmp   #$02
D271: D0 04      bne   $D277
D273: 20 F7 D2   jsr   $D2F7
D276: 60         rts   
D277: C9 03      cmp   #$03
D279: D0 04      bne   $D27F
D27B: 20 3F D3   jsr   $D33F
D27E: 60         rts   
D27F: C9 86      cmp   #$86
D281: D0 04      bne   $D287
D283: 20 BE D3   jsr   $D3BE
D286: 60         rts   
D287: C9 05      cmp   #$05
D289: D0 04      bne   $D28F
D28B: 20 FF D3   jsr   $D3FF
D28E: 60         rts   
D28F: 20 76 D5   jsr   $D576
D292: 60         rts   
D293: A7 BF 04   bbs5  $BF,$D29A
D296: 20 76 D5   jsr   $D576
D299: 60         rts   
D29A: A5 9D      lda   $9D
D29C: A2 02      ldx   #$02
D29E: C9 14      cmp   #$14
D2A0: B0 0A      bcs   $D2AC
D2A2: A2 01      ldx   #$01
D2A4: C9 0A      cmp   #$0A
D2A6: B0 04      bcs   $D2AC
D2A8: A9 00      lda   #$00
D2AA: 80 04      bra   $D2B0
D2AC: 8A         txa   
D2AD: 20 41 D4   jsr   $D441
D2B0: 85 40      sta   $40
D2B2: A5 9D      lda   $9D
D2B4: AA         tax   
D2B5: C9 0A      cmp   #$0A
D2B7: 90 0A      bcc   $D2C3
D2B9: E9 0A      sbc   #$0A
D2BB: AA         tax   
D2BC: C9 0A      cmp   #$0A
D2BE: 90 03      bcc   $D2C3
D2C0: E9 0A      sbc   #$0A
D2C2: AA         tax   
D2C3: 8A         txa   
D2C4: 20 41 D4   jsr   $D441
D2C7: 67 41 06   bbs3  $41,$D2D0
D2CA: 85 41      sta   $41
D2CC: 6F 41      seb3  $41
D2CE: 80 02      bra   $D2D2
D2D0: 85 41      sta   $41
D2D2: A5 9E      lda   $9E
D2D4: A2 00      ldx   #$00
D2D6: C9 0A      cmp   #$0A
D2D8: 90 05      bcc   $D2DF
D2DA: E9 0A      sbc   #$0A
D2DC: E8         inx   
D2DD: 80 F7      bra   $D2D6
D2DF: 8A         txa   
D2E0: 20 41 D4   jsr   $D441
D2E3: 85 42      sta   $42
D2E5: A5 9E      lda   $9E
D2E7: AA         tax   
D2E8: C9 0A      cmp   #$0A
D2EA: 90 04      bcc   $D2F0
D2EC: E9 0A      sbc   #$0A
D2EE: 80 F7      bra   $D2E7
D2F0: 8A         txa   
D2F1: 20 41 D4   jsr   $D441
D2F4: 85 43      sta   $43
D2F6: 60         rts   
D2F7: 20 E6 D0   jsr   $D0E6
D2FA: F0 06      beq   $D302
D2FC: C7 50 0E   bbs6  $50,$D30D
D2FF: 07 6D 0B   bbs0  $6D,$D30D
D302: 07 6D 04   bbs0  $6D,$D309
D305: 20 81 D5   jsr   $D581
D308: 60         rts   
D309: 20 76 D5   jsr   $D576
D30C: 60         rts   
D30D: C9 FF      cmp   #$FF
D30F: F0 2D      beq   $D33E
D311: F7 6C 08   bbc7  $6C,$D31C
D314: A5 6E      lda   $6E
D316: C9 64      cmp   #$64
D318: 90 02      bcc   $D31C
D31A: A9 64      lda   #$64
D31C: AA         tax   
D31D: BD AD D5   lda   $D5AD,X
D320: F7 6C 18   bbc7  $6C,$D33B
D323: C9 5F      cmp   #$5F
D325: 90 14      bcc   $D33B
D327: A9 5F      lda   #$5F
D329: 17 C4 0F   bbc0  $C4,$D33B
D32C: A9 63      lda   #$63
D32E: C7 C4 0A   bbs6  $C4,$D33B
D331: A9 64      lda   #$64
D333: E7 C4 05   bbs7  $C4,$D33B
D336: A7 C4 02   bbs5  $C4,$D33B
D339: A9 5F      lda   #$5F
D33B: 20 6E D3   jsr   $D36E
D33E: 60         rts   
D33F: A5 6E      lda   $6E
D341: C7 C0 1E   bbs6  $C0,$D362
D344: AD 06 01   lda   $0106
D347: A7 C0 18   bbs5  $C0,$D362
D34A: AD 07 01   lda   $0107
D34D: 87 C0 12   bbs4  $C0,$D362
D350: 20 E6 D0   jsr   $D0E6
D353: D0 0D      bne   $D362
D355: 07 6D 05   bbs0  $6D,$D35D
D358: 20 81 D5   jsr   $D581
D35B: 80 0C      bra   $D369
D35D: 20 76 D5   jsr   $D576
D360: 80 07      bra   $D369
D362: C9 FF      cmp   #$FF
D364: F0 07      beq   $D36D
D366: 20 6E D3   jsr   $D36E
D369: A5 C0      lda   $C0
D36B: 85 40      sta   $40
D36D: 60         rts   
D36E: 48         pha   
D36F: C9 64      cmp   #$64
D371: 90 11      bcc   $D384
D373: C9 C8      cmp   #$C8
D375: 90 04      bcc   $D37B
D377: A9 02      lda   #$02
D379: 80 02      bra   $D37D
D37B: A9 01      lda   #$01
D37D: 20 41 D4   jsr   $D441
D380: 85 41      sta   $41
D382: 80 04      bra   $D388
D384: A9 00      lda   #$00
D386: 85 41      sta   $41
D388: 68         pla   
D389: A0 00      ldy   #$00
D38B: C9 0A      cmp   #$0A
D38D: 90 05      bcc   $D394
D38F: E9 0A      sbc   #$0A
D391: C8         iny   
D392: 80 F7      bra   $D38B
D394: 48         pha   
D395: 98         tya   
D396: C9 14      cmp   #$14
D398: B0 0A      bcs   $D3A4
D39A: C9 0A      cmp   #$0A
D39C: B0 0A      bcs   $D3A8
D39E: C9 00      cmp   #$00
D3A0: D0 0A      bne   $D3AC
D3A2: 80 0B      bra   $D3AF
D3A4: E9 14      sbc   #$14
D3A6: 80 04      bra   $D3AC
D3A8: E9 0A      sbc   #$0A
D3AA: 80 00      bra   $D3AC
D3AC: 20 41 D4   jsr   $D441
D3AF: 85 42      sta   $42
D3B1: 68         pla   
D3B2: 20 41 D4   jsr   $D441
D3B5: 85 43      sta   $43
D3B7: 6F 43      seb3  $43
D3B9: A9 00      lda   #$00
D3BB: 85 40      sta   $40
D3BD: 60         rts   
D3BE: A5 71      lda   $71
D3C0: 4A         lsr   A
D3C1: 4A         lsr   A
D3C2: 4A         lsr   A
D3C3: 4A         lsr   A
D3C4: C9 0A      cmp   #$0A
D3C6: 90 02      bcc   $D3CA
D3C8: 69 36      adc   #$36
D3CA: 20 41 D4   jsr   $D441
D3CD: 85 40      sta   $40
D3CF: A5 71      lda   $71
D3D1: 29 0F      and   #$0F
D3D3: C9 0A      cmp   #$0A
D3D5: 90 02      bcc   $D3D9
D3D7: 69 36      adc   #$36
D3D9: 20 41 D4   jsr   $D441
D3DC: 85 41      sta   $41
D3DE: A5 70      lda   $70
D3E0: 4A         lsr   A
D3E1: 4A         lsr   A
D3E2: 4A         lsr   A
D3E3: 4A         lsr   A
D3E4: C9 0A      cmp   #$0A
D3E6: 90 02      bcc   $D3EA
D3E8: 69 36      adc   #$36
D3EA: 20 41 D4   jsr   $D441
D3ED: 85 42      sta   $42
D3EF: A5 70      lda   $70
D3F1: 29 0F      and   #$0F
D3F3: C9 0A      cmp   #$0A
D3F5: 90 02      bcc   $D3F9
D3F7: 69 36      adc   #$36
D3F9: 20 41 D4   jsr   $D441
D3FC: 85 43      sta   $43
D3FE: 60         rts   
D3FF: A5 72      lda   $72
D401: 4A         lsr   A
D402: 4A         lsr   A
D403: 4A         lsr   A
D404: 4A         lsr   A
D405: C9 0A      cmp   #$0A
D407: 90 02      bcc   $D40B
D409: 69 36      adc   #$36
D40B: 20 41 D4   jsr   $D441
D40E: 85 40      sta   $40
D410: A5 72      lda   $72
D412: 29 0F      and   #$0F
D414: C9 0A      cmp   #$0A
D416: 90 02      bcc   $D41A
D418: 69 36      adc   #$36
D41A: 20 41 D4   jsr   $D441
D41D: 85 41      sta   $41
D41F: A9 00      lda   #$00
D421: 85 42      sta   $42
D423: A5 6C      lda   $6C
D425: 29 0F      and   #$0F
D427: A8         tay   
D428: B9 31 D4   lda   $D431,Y
D42B: 20 41 D4   jsr   $D441
D42E: 85 43      sta   $43
D430: 60         rts   
D431: 20 31 32   jsr   $3231
D434: 33        .byte $33
D435: 34        .byte $34
D436: 35 36      and   $36,X
D438: 37 38 39   bbc1  $38,$D474
D43B: 41 42      eor   ($42,X)
D43D: 43        .byte $43
D43E: 44        .byte $44
D43F: 45 46      eor   $46
D441: C9 0A      cmp   #$0A
D443: B0 04      bcs   $D449
D445: 69 30      adc   #$30
D447: 80 06      bra   $D44F
D449: C9 60      cmp   #$60
D44B: 90 02      bcc   $D44F
D44D: E9 20      sbc   #$20
D44F: 38         sec   
D450: E9 20      sbc   #$20
D452: A8         tay   
D453: B9 57 D4   lda   $D457,Y
D456: 60         rts   
D457: 00         brk   
D458: 00         brk   
D459: 00         brk   
D45A: 00         brk   
D45B: 00         brk   
D45C: 00         brk   
D45D: 00         brk   
D45E: 00         brk   
D45F: F0 95      beq   $D3F6
D461: 00         brk   
D462: 00         brk   
D463: 00         brk   
D464: 02        .byte $02
D465: 00         brk   
D466: 00         brk   
D467: F5 60      sbc   $60,X
D469: B6 F2      ldx   $F2,Y
D46B: 63        .byte $63
D46C: D3        .byte $D3
D46D: D7 71 F7   bbc6  $71,$D467
D470: F3        .byte $F3
D471: 00         brk   
D472: 00         brk   
D473: 00         brk   
D474: 12         clt   
D475: 00         brk   
D476: 00         brk   
D477: 00         brk   
D478: 77 C7 95   bbc3  $C7,$D410
D47B: E6 97      inc   $97
D47D: 17 D5 67   bbc0  $D5,$D4E7
D480: 40         rti   
D481: E4 00      cpx   $00
D483: 85 75      sta   $75
D485: 00         brk   
D486: 00         brk   
D487: 00         brk   
D488: 00         brk   
D489: 35 00      and   $00,X
D48B: 00         brk   
D48C: 00         brk   
D48D: 00         brk   
D48E: 00         brk   
D48F: 00         brk   
D490: 00         brk   
D491: 00         brk   
D492: 95 00      sta   $00,X
D494: F0 10      beq   $D4A6
D496: 80 A2      bra   $D43A
D498: 04        .byte $04
D499: 77 C0 0E   bbc3  $C0,$D4AA
D49C: A5 9F      lda   $9F
D49E: 4A         lsr   A
D49F: B0 3F      bcs   $D4E0
D4A1: A2 03      ldx   #$03
D4A3: 4A         lsr   A
D4A4: B0 3A      bcs   $D4E0
D4A6: A2 05      ldx   #$05
D4A8: 80 36      bra   $D4E0
D4AA: A2 03      ldx   #$03
D4AC: E7 C0 31   bbs7  $C0,$D4E0
D4AF: A5 C6      lda   $C6
D4B1: C9 00      cmp   #$00
D4B3: D0 03      bne   $D4B8
D4B5: C7 50 04   bbs6  $50,$D4BC
D4B8: C9 04      cmp   #$04
D4BA: D0 1A      bne   $D4D6
D4BC: A5 9F      lda   $9F
D4BE: F0 12      beq   $D4D2
D4C0: A5 C3      lda   $C3
D4C2: D0 02      bne   $D4C6
D4C4: A9 05      lda   #$05
D4C6: A2 00      ldx   #$00
D4C8: E2 9F      div   $9F,X
D4CA: 4A         lsr   A
D4CB: 68         pla   
D4CC: 90 04      bcc   $D4D2
D4CE: A9 02      lda   #$02
D4D0: 80 0F      bra   $D4E1
D4D2: A9 01      lda   #$01
D4D4: 80 0B      bra   $D4E1
D4D6: AA         tax   
D4D7: D0 07      bne   $D4E0
D4D9: A2 02      ldx   #$02
D4DB: B7 50 02   bbc5  $50,$D4E0
D4DE: A2 01      ldx   #$01
D4E0: 8A         txa   
D4E1: 60         rts   
D4E2: A5 CD      lda   $CD
D4E4: C9 03      cmp   #$03
D4E6: D0 0D      bne   $D4F5
D4E8: 97 44 05   bbc4  $44,$D4F0
D4EB: 20 5A D5   jsr   $D55A
D4EE: 80 61      bra   $D551
D4F0: 20 61 D5   jsr   $D561
D4F3: 80 5C      bra   $D551
D4F5: C9 04      cmp   #$04
D4F7: D0 0D      bne   $D506
D4F9: B7 44 05   bbc5  $44,$D501
D4FC: 20 5A D5   jsr   $D55A
D4FF: 80 50      bra   $D551
D501: 20 68 D5   jsr   $D568
D504: 80 4B      bra   $D551
D506: C9 05      cmp   #$05
D508: D0 0D      bne   $D517
D50A: D7 44 05   bbc6  $44,$D512
D50D: 20 5A D5   jsr   $D55A
D510: 80 3F      bra   $D551
D512: 20 6F D5   jsr   $D56F
D515: 80 3A      bra   $D551
D517: C9 06      cmp   #$06
D519: D0 0D      bne   $D528
D51B: 97 44 05   bbc4  $44,$D523
D51E: 20 5A D5   jsr   $D55A
D521: 80 2E      bra   $D551
D523: 20 53 D5   jsr   $D553
D526: 80 29      bra   $D551
D528: C9 07      cmp   #$07
D52A: D0 17      bne   $D543
D52C: 87 44 05   bbs4  $44,$D534
D52F: A7 44 07   bbs5  $44,$D539
D532: 80 0A      bra   $D53E
D534: 20 68 D5   jsr   $D568
D537: 80 18      bra   $D551
D539: 20 6F D5   jsr   $D56F
D53C: 80 13      bra   $D551
D53E: 20 61 D5   jsr   $D561
D541: 80 0E      bra   $D551
D543: C9 08      cmp   #$08
D545: D0 08      bne   $D54F
D547: C7 44 EA   bbs6  $44,$D534
D54A: A7 44 F1   bbs5  $44,$D53E
D54D: 80 EA      bra   $D539
D54F: 18         clc   
D550: 60         rts   
D551: 38         sec   
D552: 60         rts   
D553: 8F 44      seb4  $44
D555: AF 44      seb5  $44
D557: CF 44      seb6  $44
D559: 60         rts   
D55A: 9F 44      clb4  $44
D55C: BF 44      clb5  $44
D55E: DF 44      clb6  $44
D560: 60         rts   
D561: 8F 44      seb4  $44
D563: BF 44      clb5  $44
D565: DF 44      clb6  $44
D567: 60         rts   
D568: 9F 44      clb4  $44
D56A: AF 44      seb5  $44
D56C: DF 44      clb6  $44
D56E: 60         rts   
D56F: 9F 44      clb4  $44
D571: BF 44      clb5  $44
D573: CF 44      seb6  $44
D575: 60         rts   
D576: A9 00      lda   #$00
D578: 85 40      sta   $40
D57A: 85 41      sta   $41
D57C: 85 42      sta   $42
D57E: 85 43      sta   $43
D580: 60         rts   
D581: A2 00      ldx   #$00
D583: BD 91 D5   lda   $D591,X
D586: F0 08      beq   $D590
D588: 20 41 D4   jsr   $D441
D58B: 95 40      sta   $40,X
D58D: E8         inx   
D58E: 80 F3      bra   $D583
D590: 60         rts   
D591: 20 20 41   jsr   $4120
D594: 43        .byte $43
D595: 00         brk   
D596: 3F 44      clb1  $44
D598: A2 00      ldx   #$00
D59A: BD A8 D5   lda   $D5A8,X
D59D: F0 08      beq   $D5A7
D59F: 20 41 D4   jsr   $D441
D5A2: 95 40      sta   $40,X
D5A4: E8         inx   
D5A5: 80 F3      bra   $D59A
D5A7: 60         rts   
D5A8: 31 38      and   ($38),Y
D5AA: 72        .byte $72
D5AB: 37 00 00   bbc1  $00,$D5AE
D5AE: 05 05      ora   $05
D5B0: 05 05      ora   $05
D5B2: 05 0A      ora   $0A
D5B4: 0A         asl   A
D5B5: 0A         asl   A
D5B6: 0A         asl   A
D5B7: 0A         asl   A
D5B8: 14        .byte $14
D5B9: 14        .byte $14
D5BA: 14        .byte $14
D5BB: 14        .byte $14
D5BC: 14        .byte $14
D5BD: 14        .byte $14
D5BE: 14        .byte $14
D5BF: 14        .byte $14
D5C0: 14        .byte $14
D5C1: 14        .byte $14
D5C2: 1E 1E 1E   asl   $1E1E,X
D5C5: 1E 1E 1E   asl   $1E1E,X
D5C8: 1E 1E 1E   asl   $1E1E,X
D5CB: 1E 1E 28   asl   $281E,X
D5CE: 28         plp   
D5CF: 28         plp   
D5D0: 28         plp   
D5D1: 28         plp   
D5D2: 28         plp   
D5D3: 28         plp   
D5D4: 28         plp   
D5D5: 28         plp   
D5D6: 28         plp   
D5D7: 28         plp   
D5D8: 32         set   
D5D9: 32         set   
D5DA: 32         set   
D5DB: 32         set   
D5DC: 32         set   
D5DD: 32         set   
D5DE: 32         set   
D5DF: 32         set   
D5E0: 32         set   
D5E1: 32         set   
D5E2: 3C 3C 3C   ldm   #$3C,$3C
D5E5: 3C 3C 3C   ldm   #$3C,$3C
D5E8: 3C 3C 3C   ldm   #$3C,$3C
D5EB: 3C 46 46   ldm   #$46,$46
D5EE: 46 46      lsr   $46
D5F0: 46 46      lsr   $46
D5F2: 46 46      lsr   $46
D5F4: 46 46      lsr   $46
D5F6: 50 50      bvc   $D648
D5F8: 50 50      bvc   $D64A
D5FA: 50 50      bvc   $D64C
D5FC: 50 50      bvc   $D64E
D5FE: 50 50      bvc   $D650
D600: 5A        .byte $5A
D601: 5A        .byte $5A
D602: 5A        .byte $5A
D603: 5A        .byte $5A
D604: 5A        .byte $5A
D605: 5A        .byte $5A
D606: 5A        .byte $5A
D607: 5A        .byte $5A
D608: 5A        .byte $5A
D609: 5A        .byte $5A
D60A: 64 64      tst   $64
D60C: 64 64      tst   $64
D60E: 64 64      tst   $64
D610: 64 64      tst   $64
D612: 48         pha   
D613: 8A         txa   
D614: 48         pha   
D615: 98         tya   
D616: 48         pha   
D617: A5 F7      lda   $F7
D619: 48         pha   
D61A: A5 F8      lda   $F8
D61C: 48         pha   
D61D: A5 F9      lda   $F9
D61F: 48         pha   
D620: A5 FA      lda   $FA
D622: 48         pha   
D623: A5 81      lda   $81
D625: F0 0F      beq   $D636
D627: A7 81 1E   bbs5  $81,$D648
D62A: C7 81 21   bbs6  $81,$D64E
D62D: 20 68 D6   jsr   $D668
D630: A5 81      lda   $81
D632: D0 02      bne   $D636
D634: 9F 34      clb4  $34
D636: 68         pla   
D637: 85 FA      sta   $FA
D639: 68         pla   
D63A: 85 F9      sta   $F9
D63C: 68         pla   
D63D: 85 F8      sta   $F8
D63F: 68         pla   
D640: 85 F7      sta   $F7
D642: 68         pla   
D643: A8         tay   
D644: 68         pla   
D645: AA         tax   
D646: 68         pla   
D647: 40         rti   
D648: 20 77 D8   jsr   $D877
D64B: 4C 30 D6   jmp   $D630
D64E: 20 97 D8   jsr   $D897
D651: C7 81 11   bbs6  $81,$D665
D654: A7 80 0B   bbs5  $80,$D662
D657: 87 80 08   bbs4  $80,$D662
D65A: 17 80 08   bbc0  $80,$D665
D65D: 20 54 D7   jsr   $D754
D660: 80 03      bra   $D665
D662: 20 4E D7   jsr   $D74E
D665: 4C 30 D6   jmp   $D630
D668: E7 81 12   bbs7  $81,$D67D
D66B: 97 81 03   bbc4  $81,$D671
D66E: 4C 24 D7   jmp   $D724
D671: 07 81 36   bbs0  $81,$D6AA
D674: 27 81 4E   bbs1  $81,$D6C5
D677: 47 81 26   bbs2  $81,$D6A0
D67A: 4C FB D6   jmp   $D6FB
D67D: A5 35      lda   $35
D67F: FF 81      clb7  $81
D681: AD 01 01   lda   $0101
D684: F0 07      beq   $D68D
D686: 1A        .byte $1A
D687: 8D 01 01   sta   $0101
D68A: 4C 77 D7   jmp   $D777
D68D: 20 BB D7   jsr   $D7BB
D690: 90 0D      bcc   $D69F
D692: 20 7F D7   jsr   $D77F
D695: 90 08      bcc   $D69F
D697: 20 91 D7   jsr   $D791
D69A: 90 03      bcc   $D69F
D69C: 20 A3 D7   jsr   $D7A3
D69F: 60         rts   
D6A0: 5F 81      clb2  $81
D6A2: A5 35      lda   $35
D6A4: 85 72      sta   $72
D6A6: 20 AC D7   jsr   $D7AC
D6A9: 60         rts   
D6AA: 1F 81      clb0  $81
D6AC: A0 65      ldy   #$65
D6AE: A5 35      lda   $35
D6B0: 85 6B      sta   $6B
D6B2: 48         pha   
D6B3: 20 51 E6   jsr   $E651
D6B6: 68         pla   
D6B7: 20 04 D8   jsr   $D804
D6BA: A0 5F      ldy   #$5F
D6BC: 20 1D E6   jsr   $E61D
D6BF: 20 91 D7   jsr   $D791
D6C2: B0 14      bcs   $D6D8
D6C4: 60         rts   
D6C5: 3F 81      clb1  $81
D6C7: A0 62      ldy   #$62
D6C9: A5 35      lda   $35
D6CB: 48         pha   
D6CC: 20 51 E6   jsr   $E651
D6CF: 68         pla   
D6D0: 20 30 D8   jsr   $D830
D6D3: A0 5D      ldy   #$5D
D6D5: 20 1D E6   jsr   $E61D
D6D8: D7 80 06   bbc6  $80,$D6E1
D6DB: AF 80      seb5  $80
D6DD: 20 49 D8   jsr   $D849
D6E0: 60         rts   
D6E1: BF 80      clb5  $80
D6E3: A0 5F      ldy   #$5F
D6E5: 20 11 E6   jsr   $E611
D6E8: D0 0B      bne   $D6F5
D6EA: A0 5D      ldy   #$5D
D6EC: 20 11 E6   jsr   $E611
D6EF: D0 04      bne   $D6F5
D6F1: 20 A3 D7   jsr   $D7A3
D6F4: 60         rts   
D6F5: 20 7F D7   jsr   $D77F
D6F8: B0 C5      bcs   $D6BF
D6FA: 60         rts   
D6FB: 7F 81      clb3  $81
D6FD: A5 35      lda   $35
D6FF: 85 6A      sta   $6A
D701: 85 71      sta   $71
D703: 20 D4 D7   jsr   $D7D4
D706: A5 71      lda   $71
D708: A0 68      ldy   #$68
D70A: 20 69 E6   jsr   $E669
D70D: C6 61      dec   $61
D70F: D7 80 06   bbc6  $80,$D718
D712: 8F 80      seb4  $80
D714: 20 49 D8   jsr   $D849
D717: 60         rts   
D718: 9F 80      clb4  $80
D71A: 20 AC D7   jsr   $D7AC
D71D: B0 01      bcs   $D720
D71F: 60         rts   
D720: 20 DB D0   jsr   $D0DB
D723: 60         rts   
D724: 9F 81      clb4  $81
D726: A5 34      lda   $34
D728: 29 07      and   #$07
D72A: C9 04      cmp   #$04
D72C: F0 09      beq   $D737
D72E: A5 35      lda   $35
D730: 8D 0A 01   sta   $010A
D733: 20 C4 D7   jsr   $D7C4
D736: 60         rts   
D737: A5 35      lda   $35
D739: 8D 0B 01   sta   $010B
D73C: 20 7F D7   jsr   $D77F
D73F: 90 08      bcc   $D749
D741: 20 91 D7   jsr   $D791
D744: 90 03      bcc   $D749
D746: 20 A3 D7   jsr   $D7A3
D749: 60         rts   
D74A: A5 81      lda   $81
D74C: D0 09      bne   $D757
D74E: A7 80 90   bbs5  $80,$D6E1
D751: 87 80 C4   bbs4  $80,$D718
D754: 07 80 01   bbs0  $80,$D758
D757: 60         rts   
D758: 1F 80      clb0  $80
D75A: 3C 00 62   ldm   #$00,$62
D75D: 3C 00 63   ldm   #$00,$63
D760: 3C 00 64   ldm   #$00,$64
D763: 3C 00 65   ldm   #$00,$65
D766: 3C 00 66   ldm   #$00,$66
D769: 3C 00 67   ldm   #$00,$67
D76C: 3C 00 68   ldm   #$00,$68
D76F: 3C 00 69   ldm   #$00,$69
D772: A9 08      lda   #$08
D774: 8D 01 01   sta   $0101
D777: EF 81      seb7  $81
D779: A9 02      lda   #$02
D77B: 20 CD D7   jsr   $D7CD
D77E: 60         rts   
D77F: A0 5F      ldy   #$5F
D781: 20 11 E6   jsr   $E611
D784: D0 02      bne   $D788
D786: 38         sec   
D787: 60         rts   
D788: 0F 81      seb0  $81
D78A: A9 00      lda   #$00
D78C: 20 CD D7   jsr   $D7CD
D78F: 18         clc   
D790: 60         rts   
D791: A0 5D      ldy   #$5D
D793: 20 11 E6   jsr   $E611
D796: D0 02      bne   $D79A
D798: 38         sec   
D799: 60         rts   
D79A: 2F 81      seb1  $81
D79C: A9 01      lda   #$01
D79E: 20 CD D7   jsr   $D7CD
D7A1: 18         clc   
D7A2: 60         rts   
D7A3: 4F 81      seb2  $81
D7A5: A9 02      lda   #$02
D7A7: 20 CD D7   jsr   $D7CD
D7AA: 18         clc   
D7AB: 60         rts   
D7AC: A5 61      lda   $61
D7AE: D0 02      bne   $D7B2
D7B0: 38         sec   
D7B1: 60         rts   
D7B2: 6F 81      seb3  $81
D7B4: A9 03      lda   #$03
D7B6: 20 CD D7   jsr   $D7CD
D7B9: 18         clc   
D7BA: 60         rts   
D7BB: 8F 81      seb4  $81
D7BD: A9 07      lda   #$07
D7BF: 20 CD D7   jsr   $D7CD
D7C2: 18         clc   
D7C3: 60         rts   
D7C4: 8F 81      seb4  $81
D7C6: A9 04      lda   #$04
D7C8: 20 CD D7   jsr   $D7CD
D7CB: 18         clc   
D7CC: 60         rts   
D7CD: 09 10      ora   #$10
D7CF: 85 34      sta   $34
D7D1: DF 3D      clb6  $3D
D7D3: 60         rts   
D7D4: E7 6C 01   bbs7  $6C,$D7D8
D7D7: 60         rts   
D7D8: C5 7B      cmp   $7B
D7DA: F0 02      beq   $D7DE
D7DC: 90 10      bcc   $D7EE
D7DE: C5 7A      cmp   $7A
D7E0: F0 09      beq   $D7EB
D7E2: 90 07      bcc   $D7EB
D7E4: A6 7A      ldx   $7A
D7E6: 86 7B      stx   $7B
D7E8: 85 7A      sta   $7A
D7EA: 60         rts   
D7EB: 85 7B      sta   $7B
D7ED: 60         rts   
D7EE: C5 7D      cmp   $7D
D7F0: F0 02      beq   $D7F4
D7F2: B0 0F      bcs   $D803
D7F4: C5 7C      cmp   $7C
D7F6: F0 09      beq   $D801
D7F8: B0 07      bcs   $D801
D7FA: A6 7C      ldx   $7C
D7FC: 86 7D      stx   $7D
D7FE: 85 7C      sta   $7C
D800: 60         rts   
D801: 85 7D      sta   $7D
D803: 60         rts   
D804: C5 77      cmp   $77
D806: F0 02      beq   $D80A
D808: 90 10      bcc   $D81A
D80A: C5 76      cmp   $76
D80C: F0 09      beq   $D817
D80E: 90 07      bcc   $D817
D810: A6 76      ldx   $76
D812: 86 77      stx   $77
D814: 85 76      sta   $76
D816: 60         rts   
D817: 85 77      sta   $77
D819: 60         rts   
D81A: C5 79      cmp   $79
D81C: F0 02      beq   $D820
D81E: B0 0F      bcs   $D82F
D820: C5 78      cmp   $78
D822: F0 09      beq   $D82D
D824: B0 07      bcs   $D82D
D826: A6 78      ldx   $78
D828: 86 79      stx   $79
D82A: 85 78      sta   $78
D82C: 60         rts   
D82D: 85 79      sta   $79
D82F: 60         rts   
D830: C5 74      cmp   $74
D832: 90 03      bcc   $D837
D834: 85 74      sta   $74
D836: 60         rts   
D837: C5 75      cmp   $75
D839: B0 02      bcs   $D83D
D83B: 85 75      sta   $75
D83D: 60         rts   
D83E: C7 D3 03   bbs6  $D3,$D844
D841: DF 80      clb6  $80
D843: 60         rts   
D844: A5 81      lda   $81
D846: F0 01      beq   $D849
D848: 60         rts   
D849: 3C 08 DA   ldm   #$08,$DA
D84C: DF D3      clb6  $D3
D84E: 4F 02      seb2  $02
D850: 7F 02      clb3  $02
D852: 4F D3      seb2  $D3
D854: AF D3      seb5  $D3
D856: DF 80      clb6  $80
D858: AF 81      seb5  $81
D85A: 6F D3      seb3  $D3
D85C: A9 06      lda   #$06
D85E: 20 CD D7   jsr   $D7CD
D861: 60         rts   
D862: 3C 08 DA   ldm   #$08,$DA
D865: 0F 02      seb0  $02
D867: 3F 02      clb1  $02
D869: 2F D3      seb1  $D3
D86B: 8F D3      seb4  $D3
D86D: CF 81      seb6  $81
D86F: 6F D3      seb3  $D3
D871: A9 05      lda   #$05
D873: 20 CD D7   jsr   $D7CD
D876: 60         rts   
D877: 77 D3 0B   bbc3  $D3,$D885
D87A: A5 35      lda   $35
D87C: C6 DA      dec   $DA
D87E: D0 02      bne   $D882
D880: 7F D3      clb3  $D3
D882: 4C 5C D8   jmp   $D85C
D885: 6F 02      seb3  $02
D887: 5F 02      clb2  $02
D889: 5F D3      clb2  $D3
D88B: BF D3      clb5  $D3
D88D: BF 81      clb5  $81
D88F: A5 35      lda   $35
D891: 85 D0      sta   $D0
D893: 20 62 D8   jsr   $D862
D896: 60         rts   
D897: 77 D3 0B   bbc3  $D3,$D8A5
D89A: A5 35      lda   $35
D89C: C6 DA      dec   $DA
D89E: D0 02      bne   $D8A2
D8A0: 7F D3      clb3  $D3
D8A2: 4C 71 D8   jmp   $D871
D8A5: CF D3      seb6  $D3
D8A7: 2F 02      seb1  $02
D8A9: 1F 02      clb0  $02
D8AB: 3F D3      clb1  $D3
D8AD: 9F D3      clb4  $D3
D8AF: DF 81      clb6  $81
D8B1: A5 35      lda   $35
D8B3: C9 05      cmp   #$05
D8B5: B0 02      bcs   $D8B9
D8B7: A9 FF      lda   #$FF
D8B9: C9 E4      cmp   #$E4
D8BB: 90 02      bcc   $D8BF
D8BD: A9 FF      lda   #$FF
D8BF: 85 CF      sta   $CF
D8C1: 44        .byte $44
D8C2: CF A5      seb6  $A5
D8C4: D0 C9      bne   $D88F
D8C6: E4 90      cpx   $90
D8C8: 02        .byte $02
D8C9: A9 00      lda   #$00
D8CB: C9 05      cmp   #$05
D8CD: B0 02      bcs   $D8D1
D8CF: A9 00      lda   #$00
D8D1: 85 CE      sta   $CE
D8D3: 60         rts   
D8D4: 48         pha   
D8D5: 8A         txa   
D8D6: 48         pha   
D8D7: 98         tya   
D8D8: 48         pha   
D8D9: A5 F7      lda   $F7
D8DB: 48         pha   
D8DC: A5 F8      lda   $F8
D8DE: 48         pha   
D8DF: A5 F9      lda   $F9
D8E1: 48         pha   
D8E2: A5 FA      lda   $FA
D8E4: 48         pha   
D8E5: 20 78 D9   jsr   $D978
D8E8: 20 E1 DA   jsr   $DAE1
D8EB: 20 71 D9   jsr   $D971
D8EE: F7 80 05   bbc7  $80,$D8F6
D8F1: 20 D6 D0   jsr   $D0D6
D8F4: 8F 34      seb4  $34
D8F6: F7 50 10   bbc7  $50,$D909
D8F9: F7 D3 04   bbc7  $D3,$D900
D8FC: 8F 34      seb4  $34
D8FE: CF 80      seb6  $80
D900: C6 A1      dec   $A1
D902: A5 A1      lda   $A1
D904: D0 49      bne   $D94F
D906: 3C 0A A1   ldm   #$0A,$A1
D909: 20 B5 D9   jsr   $D9B5
D90C: 20 2F DB   jsr   $DB2F
D90F: 20 C0 D9   jsr   $D9C0
D912: 20 CB D9   jsr   $D9CB
D915: A5 A2      lda   $A2
D917: 1A        .byte $1A
D918: 85 A2      sta   $A2
D91A: F0 0D      beq   $D929
D91C: C9 02      cmp   #$02
D91E: F0 2F      beq   $D94F
D920: A5 A4      lda   $A4
D922: D0 2B      bne   $D94F
D924: 20 CD D1   jsr   $D1CD
D927: 80 26      bra   $D94F
D929: 3C 04 A2   ldm   #$04,$A2
D92C: EF 95      seb7  $95
D92E: 20 E8 D9   jsr   $D9E8
D931: 20 F1 D9   jsr   $D9F1
D934: 20 FC D9   jsr   $D9FC
D937: 20 07 DA   jsr   $DA07
D93A: 20 11 DA   jsr   $DA11
D93D: C6 A3      dec   $A3
D93F: A5 A3      lda   $A3
D941: D0 0C      bne   $D94F
D943: 3C 3C A3   ldm   #$3C,$A3
D946: 20 BC DA   jsr   $DABC
D949: 20 C5 DA   jsr   $DAC5
D94C: 20 D0 DA   jsr   $DAD0
D94F: D7 80 03   bbc6  $80,$D955
D952: 20 94 DB   jsr   $DB94
D955: F7 80 07   bbc7  $80,$D95F
D958: FF 80      clb7  $80
D95A: 0F 80      seb0  $80
D95C: 20 4A D7   jsr   $D74A
D95F: 68         pla   
D960: 85 FA      sta   $FA
D962: 68         pla   
D963: 85 F9      sta   $F9
D965: 68         pla   
D966: 85 F8      sta   $F8
D968: 68         pla   
D969: 85 F7      sta   $F7
D96B: 68         pla   
D96C: A8         tay   
D96D: 68         pla   
D96E: AA         tax   
D96F: 68         pla   
D970: 40         rti   
D971: A5 A9      lda   $A9
D973: F0 02      beq   $D977
D975: C6 A9      dec   $A9
D977: 60         rts   
D978: F7 50 24   bbc7  $50,$D99F
D97B: C7 19 0B   bbs6  $19,$D989
D97E: A7 19 08   bbs5  $19,$D989
D981: 87 19 05   bbs4  $19,$D989
D984: 67 19 02   bbs3  $19,$D989
D987: 80 16      bra   $D99F
D989: FF 1A      clb7  $1A
D98B: 9F 1A      clb4  $1A
D98D: BF 1A      clb5  $1A
D98F: DF 19      clb6  $19
D991: BF 19      clb5  $19
D993: 9F 19      clb4  $19
D995: 7F 19      clb3  $19
D997: EF 1A      seb7  $1A
D999: 8F 1A      seb4  $1A
D99B: AF 1A      seb5  $1A
D99D: 80 00      bra   $D99F
D99F: AD 3B 01   lda   $013B
D9A2: D0 19      bne   $D9BD
D9A4: AD 3C 01   lda   $013C
D9A7: D0 14      bne   $D9BD
D9A9: BA         tsx   
D9AA: E0 3B      cpx   #$3B
D9AC: B0 02      bcs   $D9B0
D9AE: 80 0D      bra   $D9BD
D9B0: A5 A0      lda   $A0
D9B2: D0 09      bne   $D9BD
D9B4: 60         rts   
D9B5: C7 C1 04   bbs6  $C1,$D9BC
D9B8: C6 E9      dec   $E9
D9BA: F0 01      beq   $D9BD
D9BC: 60         rts   
D9BD: 4C B1 E6   jmp   $E6B1
D9C0: C6 96      dec   $96
D9C2: F0 01      beq   $D9C5
D9C4: 60         rts   
D9C5: 3C 08 96   ldm   #$08,$96
D9C8: CF 95      seb6  $95
D9CA: 60         rts   
D9CB: A5 9B      lda   $9B
D9CD: F0 06      beq   $D9D5
D9CF: C6 9B      dec   $9B
D9D1: D0 02      bne   $D9D5
D9D3: 2F 95      seb1  $95
D9D5: A5 A7      lda   $A7
D9D7: F0 02      beq   $D9DB
D9D9: C6 A7      dec   $A7
D9DB: A5 A8      lda   $A8
D9DD: F0 02      beq   $D9E1
D9DF: C6 A8      dec   $A8
D9E1: A5 A4      lda   $A4
D9E3: F0 02      beq   $D9E7
D9E5: C6 A4      dec   $A4
D9E7: 60         rts   
D9E8: A5 A6      lda   $A6
D9EA: F0 04      beq   $D9F0
D9EC: C6 A6      dec   $A6
D9EE: D0 00      bne   $D9F0
D9F0: 60         rts   
D9F1: A5 99      lda   $99
D9F3: F0 06      beq   $D9FB
D9F5: C6 99      dec   $99
D9F7: D0 02      bne   $D9FB
D9F9: 6F 95      seb3  $95
D9FB: 60         rts   
D9FC: A5 9A      lda   $9A
D9FE: F0 06      beq   $DA06
DA00: C6 9A      dec   $9A
DA02: D0 02      bne   $DA06
DA04: 4F 95      seb2  $95
DA06: 60         rts   
DA07: C6 97      dec   $97
DA09: D0 05      bne   $DA10
DA0B: AF 95      seb5  $95
DA0D: 3C 3C 97   ldm   #$3C,$97
DA10: 60         rts   
DA11: E6 9F      inc   $9F
DA13: A5 9F      lda   $9F
DA15: C9 3C      cmp   #$3C
DA17: D0 33      bne   $DA4C
DA19: 3C 00 9F   ldm   #$00,$9F
DA1C: E6 9E      inc   $9E
DA1E: A5 9E      lda   $9E
DA20: C9 3C      cmp   #$3C
DA22: D0 28      bne   $DA4C
DA24: 3C 00 9E   ldm   #$00,$9E
DA27: E6 9D      inc   $9D
DA29: A5 9D      lda   $9D
DA2B: C9 18      cmp   #$18
DA2D: D0 1D      bne   $DA4C
DA2F: 3C 00 9D   ldm   #$00,$9D
DA32: 08         php   
DA33: A5 E6      lda   $E6
DA35: F0 13      beq   $DA4A
DA37: C6 E6      dec   $E6
DA39: D0 0F      bne   $DA4A
DA3B: A5 73      lda   $73
DA3D: C9 10      cmp   #$10
DA3F: F0 06      beq   $DA47
DA41: C9 20      cmp   #$20
DA43: B0 02      bcs   $DA47
DA45: 80 03      bra   $DA4A
DA47: 20 4A CE   jsr   $CE4A
DA4A: 28         plp   
DA4B: EA         nop   
DA4C: 37 BF 6C   bbc1  $BF,$DABB
DA4F: B7 BF 69   bbc5  $BF,$DABB
DA52: 07 BF 41   bbs0  $BF,$DA96
DA55: A5 9F      lda   $9F
DA57: D0 62      bne   $DABB
DA59: AD 19 01   lda   $0119
DA5C: 18         clc   
DA5D: E9 00      sbc   #$00
DA5F: B0 02      bcs   $DA63
DA61: A9 3B      lda   #$3B
DA63: 8D 19 01   sta   $0119
DA66: B0 53      bcs   $DABB
DA68: AD 18 01   lda   $0118
DA6B: 18         clc   
DA6C: E9 00      sbc   #$00
DA6E: B0 02      bcs   $DA72
DA70: A9 17      lda   #$17
DA72: 8D 18 01   sta   $0118
DA75: B0 44      bcs   $DABB
DA77: AD 16 01   lda   $0116
DA7A: D0 05      bne   $DA81
DA7C: AE 17 01   ldx   $0117
DA7F: F0 11      beq   $DA92
DA81: 18         clc   
DA82: E9 00      sbc   #$00
DA84: 8D 16 01   sta   $0116
DA87: AD 17 01   lda   $0117
DA8A: E9 00      sbc   #$00
DA8C: AD 17 01   lda   $0117
DA8F: 4C BB DA   jmp   $DABB
DA92: 3F BF      clb1  $BF
DA94: 80 17      bra   $DAAD
DA96: AD 18 01   lda   $0118
DA99: C5 9D      cmp   $9D
DA9B: D0 1E      bne   $DABB
DA9D: AD 19 01   lda   $0119
DAA0: C5 9E      cmp   $9E
DAA2: D0 17      bne   $DABB
DAA4: A5 9F      lda   $9F
DAA6: D0 13      bne   $DABB
DAA8: 07 BF 02   bbs0  $BF,$DAAD
DAAB: 3F BF      clb1  $BF
DAAD: A7 50 07   bbs5  $50,$DAB7
DAB0: FF 0A      clb7  $0A
DAB2: EA         nop   
DAB3: EF 0A      seb7  $0A
DAB5: 80 04      bra   $DABB
DAB7: AF 0A      seb5  $0A
DAB9: BF 0A      clb5  $0A
DABB: 60         rts   
DABC: A5 A5      lda   $A5
DABE: F0 04      beq   $DAC4
DAC0: C6 A5      dec   $A5
DAC2: D0 00      bne   $DAC4
DAC4: 60         rts   
DAC5: A5 9C      lda   $9C
DAC7: F0 06      beq   $DACF
DAC9: C6 9C      dec   $9C
DACB: D0 02      bne   $DACF
DACD: 0F 95      seb0  $95
DACF: 60         rts   
DAD0: A5 98      lda   $98
DAD2: F0 06      beq   $DADA
DAD4: C6 98      dec   $98
DAD6: D0 02      bne   $DADA
DAD8: 8F 95      seb4  $95
DADA: A5 F4      lda   $F4
DADC: F0 02      beq   $DAE0
DADE: C6 F4      dec   $F4
DAE0: 60         rts   
DAE1: 17 82 04   bbc0  $82,$DAE8
DAE4: 1F 82      clb0  $82
DAE6: 80 08      bra   $DAF0
DAE8: A5 8F      lda   $8F
DAEA: F0 42      beq   $DB2E
DAEC: C6 8F      dec   $8F
DAEE: D0 3E      bne   $DB2E
DAF0: A0 00      ldy   #$00
DAF2: B1 90      lda   ($90),Y
DAF4: 85 20      sta   $20
DAF6: C8         iny   
DAF7: D1 90      cmp   ($90),Y
DAF9: D0 08      bne   $DB03
DAFB: C9 FF      cmp   #$FF
DAFD: F0 11      beq   $DB10
DAFF: C9 00      cmp   #$00
DB01: F0 14      beq   $DB17
DB03: B1 90      lda   ($90),Y
DB05: 85 21      sta   $21
DB07: C8         iny   
DB08: B1 90      lda   ($90),Y
DB0A: 85 8F      sta   $8F
DB0C: FF 27      clb7  $27
DB0E: 80 11      bra   $DB21
DB10: 3C EE 21   ldm   #$EE,$21
DB13: EF 27      seb7  $27
DB15: 80 17      bra   $DB2E
DB17: 3C EE 21   ldm   #$EE,$21
DB1A: C8         iny   
DB1B: B1 90      lda   ($90),Y
DB1D: 85 8F      sta   $8F
DB1F: EF 27      seb7  $27
DB21: C8         iny   
DB22: 98         tya   
DB23: 18         clc   
DB24: 65 90      adc   $90
DB26: 85 90      sta   $90
DB28: A9 00      lda   #$00
DB2A: 65 91      adc   $91
DB2C: 85 91      sta   $91
DB2E: 60         rts   
DB2F: D7 BF 01   bbc6  $BF,$DB33
DB32: 60         rts   
DB33: F7 82 04   bbc7  $82,$DB3A
DB36: FF 82      clb7  $82
DB38: 80 08      bra   $DB42
DB3A: A5 84      lda   $84
DB3C: F0 15      beq   $DB53
DB3E: C6 84      dec   $84
DB40: D0 11      bne   $DB53
DB42: CF 0A      seb6  $0A
DB44: A6 83      ldx   $83
DB46: F0 02      beq   $DB4A
DB48: DF 0A      clb6  $0A
DB4A: B5 85      lda   $85,X
DB4C: 85 84      sta   $84
DB4E: 8A         txa   
DB4F: 49 01      eor   #$01
DB51: 85 83      sta   $83
DB53: D7 82 04   bbc6  $82,$DB5A
DB56: DF 82      clb6  $82
DB58: 80 08      bra   $DB62
DB5A: A5 88      lda   $88
DB5C: F0 15      beq   $DB73
DB5E: C6 88      dec   $88
DB60: D0 11      bne   $DB73
DB62: AF 04      seb5  $04
DB64: A6 87      ldx   $87
DB66: F0 02      beq   $DB6A
DB68: BF 04      clb5  $04
DB6A: B5 89      lda   $89,X
DB6C: 85 88      sta   $88
DB6E: 8A         txa   
DB6F: 49 01      eor   #$01
DB71: 85 87      sta   $87
DB73: B7 82 04   bbc5  $82,$DB7A
DB76: BF 82      clb5  $82
DB78: 80 08      bra   $DB82
DB7A: A5 8C      lda   $8C
DB7C: F0 15      beq   $DB93
DB7E: C6 8C      dec   $8C
DB80: D0 11      bne   $DB93
DB82: 8F 04      seb4  $04
DB84: A6 8B      ldx   $8B
DB86: F0 02      beq   $DB8A
DB88: 9F 04      clb4  $04
DB8A: B5 8D      lda   $8D,X
DB8C: 85 8C      sta   $8C
DB8E: 8A         txa   
DB8F: 49 01      eor   #$01
DB91: 85 8B      sta   $8B
DB93: 60         rts   
DB94: E7 CC 06   bbs7  $CC,$DB9D
DB97: F7 D3 03   bbc7  $D3,$DB9D
DB9A: 37 08 01   bbc1  $08,$DB9E
DB9D: 60         rts   
DB9E: 20 3E D8   jsr   $D83E
DBA1: A5 D8      lda   $D8
DBA3: D0 04      bne   $DBA9
DBA5: A5 D9      lda   $D9
DBA7: F0 03      beq   $DBAC
DBA9: 77 95 F1   bbc3  $95,$DB9D
DBAC: 27 C2 09   bbs1  $C2,$DBB8
DBAF: 20 0D DC   jsr   $DC0D
DBB2: A5 CE      lda   $CE
DBB4: B0 20      bcs   $DBD6
DBB6: 80 10      bra   $DBC8
DBB8: A5 CF      lda   $CF
DBBA: F0 0C      beq   $DBC8
DBBC: C9 FF      cmp   #$FF
DBBE: F0 08      beq   $DBC8
DBC0: A5 CE      lda   $CE
DBC2: F0 04      beq   $DBC8
DBC4: C9 FF      cmp   #$FF
DBC6: D0 0E      bne   $DBD6
DBC8: 17 D5 D2   bbc0  $D5,$DB9D
DBCB: 17 C2 04   bbc0  $C2,$DBD2
DBCE: C6 D4      dec   $D4
DBD0: D0 CB      bne   $DB9D
DBD2: 1F D5      clb0  $D5
DBD4: 80 24      bra   $DBFA
DBD6: 3C 00 D5   ldm   #$00,$D5
DBD9: 0A         asl   A
DBDA: 26 D5      rol   $D5
DBDC: 4A         lsr   A
DBDD: 85 D6      sta   $D6
DBDF: A5 CF      lda   $CF
DBE1: 0A         asl   A
DBE2: 26 D5      rol   $D5
DBE4: 4A         lsr   A
DBE5: 85 D7      sta   $D7
DBE7: 26 D5      rol   $D5
DBE9: 26 D5      rol   $D5
DBEB: 26 D5      rol   $D5
DBED: EF D5      seb7  $D5
DBEF: 0F D5      seb0  $D5
DBF1: 3C 04 D4   ldm   #$04,$D4
DBF4: 3C 00 CE   ldm   #$00,$CE
DBF7: 3C 00 CF   ldm   #$00,$CF
DBFA: 3F 3C      clb1  $3C
DBFC: 2F 3E      seb1  $3E
DBFE: 3C 03 D0   ldm   #$03,$D0
DC01: 3C 00 D9   ldm   #$00,$D9
DC04: 3C 04 99   ldm   #$04,$99
DC07: 7F 95      clb3  $95
DC09: 20 6F DC   jsr   $DC6F
DC0C: 60         rts   
DC0D: A5 CF      lda   $CF
DC0F: F0 48      beq   $DC59
DC11: C9 FF      cmp   #$FF
DC13: F0 44      beq   $DC59
DC15: A5 CE      lda   $CE
DC17: F0 40      beq   $DC59
DC19: C9 FF      cmp   #$FF
DC1B: F0 3C      beq   $DC59
DC1D: A5 D1      lda   $D1
DC1F: F0 2E      beq   $DC4F
DC21: 38         sec   
DC22: E5 CE      sbc   $CE
DC24: F0 0C      beq   $DC32
DC26: 90 06      bcc   $DC2E
DC28: C9 1E      cmp   #$1E
DC2A: B0 23      bcs   $DC4F
DC2C: 80 04      bra   $DC32
DC2E: C9 E1      cmp   #$E1
DC30: 90 1D      bcc   $DC4F
DC32: A5 D2      lda   $D2
DC34: 38         sec   
DC35: E5 CF      sbc   $CF
DC37: F0 0C      beq   $DC45
DC39: 90 06      bcc   $DC41
DC3B: C9 28      cmp   #$28
DC3D: B0 10      bcs   $DC4F
DC3F: 80 04      bra   $DC45
DC41: C9 D7      cmp   #$D7
DC43: 90 0A      bcc   $DC4F
DC45: A5 CF      lda   $CF
DC47: 85 D2      sta   $D2
DC49: A5 CE      lda   $CE
DC4B: 85 D1      sta   $D1
DC4D: 38         sec   
DC4E: 60         rts   
DC4F: A5 CF      lda   $CF
DC51: 85 D2      sta   $D2
DC53: A5 CE      lda   $CE
DC55: 85 D1      sta   $D1
DC57: 18         clc   
DC58: 60         rts   
DC59: A9 00      lda   #$00
DC5B: 85 D1      sta   $D1
DC5D: 85 D2      sta   $D2
DC5F: 18         clc   
DC60: 60         rts   
DC61: 48         pha   
DC62: 8A         txa   
DC63: 48         pha   
DC64: 98         tya   
DC65: 48         pha   
DC66: 20 6F DC   jsr   $DC6F
DC69: 68         pla   
DC6A: A8         tay   
DC6B: 68         pla   
DC6C: AA         tax   
DC6D: 68         pla   
DC6E: 40         rti   
DC6F: A5 D8      lda   $D8
DC71: F0 0F      beq   $DC82
DC73: C6 D8      dec   $D8
DC75: A6 D9      ldx   $D9
DC77: B5 D5      lda   $D5,X
DC79: 85 00      sta   $00
DC7B: BF 02      clb5  $02
DC7D: AF 02      seb5  $02
DC7F: E6 D9      inc   $D9
DC81: 60         rts   
DC82: 3C 00 00   ldm   #$00,$00
DC85: 3C 00 D9   ldm   #$00,$D9
DC88: 60         rts   
DC89: 4C 01 F7   jmp   $F701
DC8C: E1 58      sbc   ($58,X)
DC8E: 01 D2      ora   ($D2,X)
DC90: DD 53 01   cmp   $0153,X
DC93: C9 DD      cmp   #$DD
DC95: 42         stp   
DC96: 02        .byte $02
DC97: DB         clb6  A
DC98: DD 54 07   cmp   $0754,X
DC9B: 29 DE      and   #$DE
DC9D: 57 08 9A   bbc2  $08,$DC3A
DCA0: DE 44 04   dec   $0444,X
DCA3: 5F DF      clb2  $DF
DCA5: 47 02 92   bbs2  $02,$DC3A
DCA8: DF 4D      clb6  $4D
DCAA: 02        .byte $02
DCAB: A7 DF 45   bbs5  $DF,$DCF3
DCAE: 04        .byte $04
DCAF: CE DF 46   dec   $46DF
DCB2: 05 21      ora   $21
DCB4: E0 4B      cpx   #$4B
DCB6: 01 54      ora   ($54,X)
DCB8: E0 5A      cpx   #$5A
DCBA: 04        .byte $04
DCBB: 24 E1      bit   $E1
DCBD: 52        .byte $52
DCBE: 07 A9 E1   bbs0  $A9,$DCA2
DCC1: 43        .byte $43
DCC2: 08         php   
DCC3: AF E0      seb5  $E0
DCC5: A0 00      ldy   #$00
DCC7: A5 AB      lda   $AB
DCC9: 1A        .byte $1A
DCCA: 1A        .byte $1A
DCCB: 85 F9      sta   $F9
DCCD: B1 CA      lda   ($CA),Y
DCCF: 99 AD 00   sta   $00AD,Y
DCD2: C8         iny   
DCD3: C6 F9      dec   $F9
DCD5: D0 F6      bne   $DCCD
DCD7: 5F BF      clb2  $BF
DCD9: 60         rts   
DCDA: 57 BF 08   bbc2  $BF,$DCE5
DCDD: 08         php   
DCDE: 78         sei   
DCDF: 20 C5 DC   jsr   $DCC5
DCE2: 4C 3D DD   jmp   $DD3D
DCE5: 60         rts   
DCE6: E7 50 12   bbs7  $50,$DCFB
DCE9: C7 50 0A   bbs6  $50,$DCF6
DCEC: A7 50 02   bbs5  $50,$DCF1
DCEF: 80 F4      bra   $DCE5
DCF1: 27 C1 07   bbs1  $C1,$DCFB
DCF4: 80 EF      bra   $DCE5
DCF6: 07 C1 02   bbs0  $C1,$DCFB
DCF9: 80 EA      bra   $DCE5
DCFB: E7 BF DC   bbs7  $BF,$DCDA
DCFE: 08         php   
DCFF: 78         sei   
DD00: A5 6C      lda   $6C
DD02: 85 AD      sta   $AD
DD04: AD 08 01   lda   $0108
DD07: 85 B4      sta   $B4
DD09: AD 09 01   lda   $0109
DD0C: 85 B7      sta   $B7
DD0E: A5 6D      lda   $6D
DD10: 85 AE      sta   $AE
DD12: 20 E6 D0   jsr   $D0E6
DD15: 85 AF      sta   $AF
DD17: A5 6E      lda   $6E
DD19: 85 B3      sta   $B3
DD1B: AD 06 01   lda   $0106
DD1E: 85 B5      sta   $B5
DD20: AD 07 01   lda   $0107
DD23: 85 B8      sta   $B8
DD25: A5 70      lda   $70
DD27: 85 B0      sta   $B0
DD29: A5 71      lda   $71
DD2B: 85 B1      sta   $B1
DD2D: AD 0A 01   lda   $010A
DD30: 85 B6      sta   $B6
DD32: AD 0B 01   lda   $010B
DD35: 85 B9      sta   $B9
DD37: A5 72      lda   $72
DD39: 85 B2      sta   $B2
DD3B: EF AE      seb7  $AE
DD3D: A2 00      ldx   #$00
DD3F: A5 AB      lda   $AB
DD41: 3A        .byte $3A
DD42: 85 F9      sta   $F9
DD44: A9 00      lda   #$00
DD46: 18         clc   
DD47: 75 AA      adc   $AA,X
DD49: E8         inx   
DD4A: C6 F9      dec   $F9
DD4C: D0 F8      bne   $DD46
DD4E: 85 BA      sta   $BA
DD50: A5 AB      lda   $AB
DD52: 3A        .byte $3A
DD53: 3A        .byte $3A
DD54: 85 BB      sta   $BB
DD56: 3C 00 BC   ldm   #$00,$BC
DD59: 7F 3C      clb3  $3C
DD5B: 6F 3E      seb3  $3E
DD5D: 20 B8 E2   jsr   $E2B8
DD60: 28         plp   
DD61: EA         nop   
DD62: 60         rts   
DD63: 57 95 03   bbc2  $95,$DD69
DD66: 20 C1 DD   jsr   $DDC1
DD69: A2 00      ldx   #$00
DD6B: 20 83 E2   jsr   $E283
DD6E: F0 03      beq   $DD73
DD70: 20 74 DD   jsr   $DD74
DD73: 60         rts   
DD74: A2 00      ldx   #$00
DD76: C9 20      cmp   #$20
DD78: 90 43      bcc   $DDBD
DD7A: C9 80      cmp   #$80
DD7C: B0 3F      bcs   $DDBD
DD7E: 85 F7      sta   $F7
DD80: 3C 0F F9   ldm   #$0F,$F9
DD83: BD 89 DC   lda   $DC89,X
DD86: C5 F7      cmp   $F7
DD88: F0 0A      beq   $DD94
DD8A: E8         inx   
DD8B: E8         inx   
DD8C: E8         inx   
DD8D: E8         inx   
DD8E: C6 F9      dec   $F9
DD90: D0 F1      bne   $DD83
DD92: 80 29      bra   $DDBD
DD94: BD 8A DC   lda   $DC8A,X
DD97: 85 FA      sta   $FA
DD99: 20 97 E2   jsr   $E297
DD9C: C5 FA      cmp   $FA
DD9E: 90 20      bcc   $DDC0
DDA0: BD 8B DC   lda   $DC8B,X
DDA3: 85 F5      sta   $F5
DDA5: BD 8C DC   lda   $DC8C,X
DDA8: 85 F6      sta   $F6
DDAA: C6 FA      dec   $FA
DDAC: A6 FA      ldx   $FA
DDAE: F0 0B      beq   $DDBB
DDB0: 20 83 E2   jsr   $E283
DDB3: C9 20      cmp   #$20
DDB5: 90 06      bcc   $DDBD
DDB7: C9 80      cmp   #$80
DDB9: B0 02      bcs   $DDBD
DDBB: B2        .byte $B2
DDBC: F5 20      sbc   $20,X
DDBE: 71 E2      adc   ($E2),Y
DDC0: 60         rts   
DDC1: 3C 00 9A   ldm   #$00,$9A
DDC4: 5F 95      clb2  $95
DDC6: 9F BF      clb4  $BF
DDC8: 60         rts   
DDC9: 20 71 E2   jsr   $E271
DDCC: FF BF      clb7  $BF
DDCE: 20 C1 DD   jsr   $DDC1
DDD1: 60         rts   
DDD2: 20 71 E2   jsr   $E271
DDD5: EF BF      seb7  $BF
DDD7: 20 C1 DD   jsr   $DDC1
DDDA: 60         rts   
DDDB: 20 52 D0   jsr   $D052
DDDE: 85 F7      sta   $F7
DDE0: 20 71 E2   jsr   $E271
DDE3: 20 71 E2   jsr   $E271
DDE6: C9 73      cmp   #$73
DDE8: F0 04      beq   $DDEE
DDEA: C9 70      cmp   #$70
DDEC: D0 1C      bne   $DE0A
DDEE: 85 C7      sta   $C7
DDF0: 20 75 D0   jsr   $D075
DDF3: 85 F8      sta   $F8
DDF5: F0 2E      beq   $DE25
DDF7: A5 6C      lda   $6C
DDF9: 29 F0      and   #$F0
DDFB: 05 F8      ora   $F8
DDFD: 85 6C      sta   $6C
DDFF: 29 0F      and   #$0F
DE01: C5 F7      cmp   $F7
DE03: F0 20      beq   $DE25
DE05: 3C FF 6E   ldm   #$FF,$6E
DE08: 80 1B      bra   $DE25
DE0A: C9 30      cmp   #$30
DE0C: 90 1A      bcc   $DE28
DE0E: C9 37      cmp   #$37
DE10: B0 16      bcs   $DE28
DE12: 38         sec   
DE13: E9 30      sbc   #$30
DE15: C5 C8      cmp   $C8
DE17: F0 0C      beq   $DE25
DE19: 85 C8      sta   $C8
DE1B: A9 00      lda   #$00
DE1D: 8D 09 01   sta   $0109
DE20: 8D 07 01   sta   $0107
DE23: F0 00      beq   $DE25
DE25: 20 C1 DD   jsr   $DDC1
DE28: 60         rts   
DE29: 20 71 E2   jsr   $E271
DE2C: BF BF      clb5  $BF
DE2E: 3C 00 9F   ldm   #$00,$9F
DE31: 3C 0A F7   ldm   #$0A,$F7
DE34: 20 71 E2   jsr   $E271
DE37: 20 41 E2   jsr   $E241
DE3A: B0 5D      bcs   $DE99
DE3C: A2 00      ldx   #$00
DE3E: 62 F7      mul   $F7,X
DE40: 85 9D      sta   $9D
DE42: 68         pla   
DE43: 20 71 E2   jsr   $E271
DE46: 20 41 E2   jsr   $E241
DE49: B0 4E      bcs   $DE99
DE4B: 18         clc   
DE4C: 65 9D      adc   $9D
DE4E: C9 18      cmp   #$18
DE50: B0 47      bcs   $DE99
DE52: 85 9D      sta   $9D
DE54: 20 71 E2   jsr   $E271
DE57: 20 41 E2   jsr   $E241
DE5A: B0 3D      bcs   $DE99
DE5C: A2 00      ldx   #$00
DE5E: 62 F7      mul   $F7,X
DE60: 85 9E      sta   $9E
DE62: 68         pla   
DE63: 20 71 E2   jsr   $E271
DE66: 20 41 E2   jsr   $E241
DE69: B0 2E      bcs   $DE99
DE6B: 18         clc   
DE6C: 65 9E      adc   $9E
DE6E: C9 3C      cmp   #$3C
DE70: B0 27      bcs   $DE99
DE72: 85 9E      sta   $9E
DE74: 20 71 E2   jsr   $E271
DE77: 20 41 E2   jsr   $E241
DE7A: B0 1D      bcs   $DE99
DE7C: A2 00      ldx   #$00
DE7E: 62 F7      mul   $F7,X
DE80: 85 F8      sta   $F8
DE82: 68         pla   
DE83: 20 71 E2   jsr   $E271
DE86: 20 41 E2   jsr   $E241
DE89: B0 0E      bcs   $DE99
DE8B: 18         clc   
DE8C: 65 F8      adc   $F8
DE8E: C9 3C      cmp   #$3C
DE90: B0 07      bcs   $DE99
DE92: 85 9F      sta   $9F
DE94: AF BF      seb5  $BF
DE96: 20 C1 DD   jsr   $DDC1
DE99: 60         rts   
DE9A: 20 71 E2   jsr   $E271
DE9D: 3F BF      clb1  $BF
DE9F: 1F BF      clb0  $BF
DEA1: A9 00      lda   #$00
DEA3: 8D 16 01   sta   $0116
DEA6: 8D 17 01   sta   $0117
DEA9: 8D 18 01   sta   $0118
DEAC: 8D 19 01   sta   $0119
DEAF: 85 F9      sta   $F9
DEB1: 85 FA      sta   $FA
DEB3: 3C 64 F7   ldm   #$64,$F7
DEB6: 20 71 E2   jsr   $E271
DEB9: 20 55 E2   jsr   $E255
DEBC: 90 03      bcc   $DEC1
DEBE: 4C 5E DF   jmp   $DF5E
DEC1: 85 F7      sta   $F7
DEC3: C9 00      cmp   #$00
DEC5: F0 11      beq   $DED8
DEC7: A9 10      lda   #$10
DEC9: A0 F9      ldy   #$F9
DECB: 20 69 E6   jsr   $E669
DECE: A5 FA      lda   $FA
DED0: 69 05      adc   #$05
DED2: 85 FA      sta   $FA
DED4: C6 F7      dec   $F7
DED6: D0 EF      bne   $DEC7
DED8: 3C 24 F7   ldm   #$24,$F7
DEDB: 20 71 E2   jsr   $E271
DEDE: 20 55 E2   jsr   $E255
DEE1: B0 7B      bcs   $DF5E
DEE3: A2 00      ldx   #$00
DEE5: 62 F7      mul   $F7,X
DEE7: A0 F9      ldy   #$F9
DEE9: 20 69 E6   jsr   $E669
DEEC: 68         pla   
DEED: 65 FA      adc   $FA
DEEF: 85 FA      sta   $FA
DEF1: 20 71 E2   jsr   $E271
DEF4: 20 55 E2   jsr   $E255
DEF7: B0 65      bcs   $DF5E
DEF9: A0 F9      ldy   #$F9
DEFB: 20 69 E6   jsr   $E669
DEFE: A5 FA      lda   $FA
DF00: 8D 17 01   sta   $0117
DF03: A5 F9      lda   $F9
DF05: 8D 16 01   sta   $0116
DF08: C9 3F      cmp   #$3F
DF0A: D0 08      bne   $DF14
DF0C: A5 FA      lda   $FA
DF0E: C9 B6      cmp   #$B6
DF10: D0 02      bne   $DF14
DF12: 0F BF      seb0  $BF
DF14: 3C 0A F7   ldm   #$0A,$F7
DF17: 20 71 E2   jsr   $E271
DF1A: 20 41 E2   jsr   $E241
DF1D: B0 3F      bcs   $DF5E
DF1F: A2 00      ldx   #$00
DF21: 62 F7      mul   $F7,X
DF23: 85 F9      sta   $F9
DF25: 68         pla   
DF26: 20 71 E2   jsr   $E271
DF29: 20 41 E2   jsr   $E241
DF2C: B0 30      bcs   $DF5E
DF2E: 18         clc   
DF2F: 65 F9      adc   $F9
DF31: C9 18      cmp   #$18
DF33: B0 29      bcs   $DF5E
DF35: 8D 18 01   sta   $0118
DF38: 20 71 E2   jsr   $E271
DF3B: 20 41 E2   jsr   $E241
DF3E: B0 1E      bcs   $DF5E
DF40: A2 00      ldx   #$00
DF42: 62 F7      mul   $F7,X
DF44: 85 F9      sta   $F9
DF46: 68         pla   
DF47: 20 71 E2   jsr   $E271
DF4A: 20 41 E2   jsr   $E241
DF4D: B0 0F      bcs   $DF5E
DF4F: 18         clc   
DF50: 65 F9      adc   $F9
DF52: C9 3C      cmp   #$3C
DF54: B0 08      bcs   $DF5E
DF56: 8D 19 01   sta   $0119
DF59: 2F BF      seb1  $BF
DF5B: 20 C1 DD   jsr   $DDC1
DF5E: 60         rts   
DF5F: 20 71 E2   jsr   $E271
DF62: 3C 0A F7   ldm   #$0A,$F7
DF65: 20 71 E2   jsr   $E271
DF68: 20 39 E2   jsr   $E239
DF6B: B0 24      bcs   $DF91
DF6D: 85 CB      sta   $CB
DF6F: 20 71 E2   jsr   $E271
DF72: 20 39 E2   jsr   $E239
DF75: B0 1A      bcs   $DF91
DF77: 0A         asl   A
DF78: 0A         asl   A
DF79: 0A         asl   A
DF7A: 0A         asl   A
DF7B: 85 CA      sta   $CA
DF7D: 20 71 E2   jsr   $E271
DF80: 20 39 E2   jsr   $E239
DF83: B0 0C      bcs   $DF91
DF85: 05 CA      ora   $CA
DF87: 85 CA      sta   $CA
DF89: F7 BF 02   bbc7  $BF,$DF8E
DF8C: 4F BF      seb2  $BF
DF8E: 20 C1 DD   jsr   $DDC1
DF91: 60         rts   
DF92: 20 71 E2   jsr   $E271
DF95: 20 71 E2   jsr   $E271
DF98: 20 41 E2   jsr   $E241
DF9B: B0 09      bcs   $DFA6
DF9D: C9 05      cmp   #$05
DF9F: B0 05      bcs   $DFA6
DFA1: 85 C6      sta   $C6
DFA3: 20 C1 DD   jsr   $DDC1
DFA6: 60         rts   
DFA7: 20 71 E2   jsr   $E271
DFAA: 20 71 E2   jsr   $E271
DFAD: 20 41 E2   jsr   $E241
DFB0: B0 1B      bcs   $DFCD
DFB2: C9 00      cmp   #$00
DFB4: F0 0E      beq   $DFC4
DFB6: C9 09      cmp   #$09
DFB8: B0 0A      bcs   $DFC4
DFBA: 08         php   
DFBB: 78         sei   
DFBC: 6F BF      seb3  $BF
DFBE: 85 CD      sta   $CD
DFC0: 28         plp   
DFC1: EA         nop   
DFC2: 80 06      bra   $DFCA
DFC4: 7F BF      clb3  $BF
DFC6: A9 00      lda   #$00
DFC8: 85 CD      sta   $CD
DFCA: 20 C1 DD   jsr   $DDC1
DFCD: 60         rts   
DFCE: 3C 0A 9A   ldm   #$0A,$9A
DFD1: 5F 95      clb2  $95
DFD3: 8F BF      seb4  $BF
DFD5: 20 71 E2   jsr   $E271
DFD8: 20 71 E2   jsr   $E271
DFDB: 4A         lsr   A
DFDC: B0 04      bcs   $DFE2
DFDE: 9F 44      clb4  $44
DFE0: 80 02      bra   $DFE4
DFE2: 8F 44      seb4  $44
DFE4: 4A         lsr   A
DFE5: B0 04      bcs   $DFEB
DFE7: BF 44      clb5  $44
DFE9: 80 02      bra   $DFED
DFEB: AF 44      seb5  $44
DFED: 4A         lsr   A
DFEE: B0 04      bcs   $DFF4
DFF0: DF 44      clb6  $44
DFF2: 80 02      bra   $DFF6
DFF4: CF 44      seb6  $44
DFF6: 20 71 E2   jsr   $E271
DFF9: 4A         lsr   A
DFFA: B0 04      bcs   $E000
DFFC: 1F 44      clb0  $44
DFFE: 80 02      bra   $E002
E000: 0F 44      seb0  $44
E002: 4A         lsr   A
E003: B0 04      bcs   $E009
E005: 3F 44      clb1  $44
E007: 80 02      bra   $E00B
E009: 2F 44      seb1  $44
E00B: 20 71 E2   jsr   $E271
E00E: 4A         lsr   A
E00F: B0 04      bcs   $E015
E011: 7F 43      clb3  $43
E013: 80 02      bra   $E017
E015: 6F 43      seb3  $43
E017: 4A         lsr   A
E018: B0 04      bcs   $E01E
E01A: 7F 41      clb3  $41
E01C: 80 02      bra   $E020
E01E: 6F 41      seb3  $41
E020: 60         rts   
E021: 3C 0A 9A   ldm   #$0A,$9A
E024: 5F 95      clb2  $95
E026: 8F BF      seb4  $BF
E028: 20 71 E2   jsr   $E271
E02B: 20 71 E2   jsr   $E271
E02E: 20 41 D4   jsr   $D441
E031: 85 40      sta   $40
E033: 20 71 E2   jsr   $E271
E036: 20 41 D4   jsr   $D441
E039: 77 41 01   bbc3  $41,$E03D
E03C: 6B         seb3  A
E03D: 85 41      sta   $41
E03F: 20 71 E2   jsr   $E271
E042: 20 41 D4   jsr   $D441
E045: 85 42      sta   $42
E047: 20 71 E2   jsr   $E271
E04A: 20 41 D4   jsr   $D441
E04D: 77 43 01   bbc3  $43,$E051
E050: 6B         seb3  A
E051: 85 43      sta   $43
E053: 60         rts   
E054: 20 71 E2   jsr   $E271
E057: EF CC      seb7  $CC
E059: A5 99      lda   $99
E05B: F0 08      beq   $E065
E05D: A5 D8      lda   $D8
E05F: D0 F8      bne   $E059
E061: A5 D9      lda   $D9
E063: D0 F4      bne   $E059
E065: 08         php   
E066: 78         sei   
E067: 3F 3C      clb1  $3C
E069: 2F 3E      seb1  $3E
E06B: 8F 02      seb4  $02
E06D: 3C 00 00   ldm   #$00,$00
E070: 3C FF 01   ldm   #$FF,$01
E073: 3C 55 D5   ldm   #$55,$D5
E076: 3C AA D6   ldm   #$AA,$D6
E079: 3C FF D7   ldm   #$FF,$D7
E07C: 3C 03 D8   ldm   #$03,$D8
E07F: 3C 00 D9   ldm   #$00,$D9
E082: 3C 03 99   ldm   #$03,$99
E085: 7F 95      clb3  $95
E087: 20 6F DC   jsr   $DC6F
E08A: 58         cli   
E08B: 67 95 08   bbs3  $95,$E096
E08E: A5 D8      lda   $D8
E090: D0 F9      bne   $E08B
E092: A5 D9      lda   $D9
E094: D0 F5      bne   $E08B
E096: 78         sei   
E097: 9F 02      clb4  $02
E099: 3C 00 00   ldm   #$00,$00
E09C: 3C 00 01   ldm   #$00,$01
E09F: 3C 00 D3   ldm   #$00,$D3
E0A2: 3C 00 D8   ldm   #$00,$D8
E0A5: 3F 3E      clb1  $3E
E0A7: 28         plp   
E0A8: EA         nop   
E0A9: FF CC      clb7  $CC
E0AB: 20 C1 DD   jsr   $DDC1
E0AE: 60         rts   
E0AF: 20 71 E2   jsr   $E271
E0B2: 20 71 E2   jsr   $E271
E0B5: C9 61      cmp   #$61
E0B7: F0 06      beq   $E0BF
E0B9: C9 62      cmp   #$62
E0BB: F0 27      beq   $E0E4
E0BD: 80 64      bra   $E123
E0BF: 20 90 E1   jsr   $E190
E0C2: B0 12      bcs   $E0D6
E0C4: 85 ED      sta   $ED
E0C6: 20 90 E1   jsr   $E190
E0C9: B0 0B      bcs   $E0D6
E0CB: 85 EE      sta   $EE
E0CD: 20 90 E1   jsr   $E190
E0D0: B0 04      bcs   $E0D6
E0D2: 85 EF      sta   $EF
E0D4: 80 4A      bra   $E120
E0D6: A9 B6      lda   #$B6
E0D8: 85 ED      sta   $ED
E0DA: A9 9F      lda   #$9F
E0DC: 85 EE      sta   $EE
E0DE: A9 A3      lda   #$A3
E0E0: 85 EF      sta   $EF
E0E2: 80 3C      bra   $E120
E0E4: 20 90 E1   jsr   $E190
E0E7: B0 12      bcs   $E0FB
E0E9: 85 F0      sta   $F0
E0EB: 20 90 E1   jsr   $E190
E0EE: B0 0B      bcs   $E0FB
E0F0: 85 F1      sta   $F1
E0F2: 20 90 E1   jsr   $E190
E0F5: B0 04      bcs   $E0FB
E0F7: 85 F2      sta   $F2
E0F9: 80 25      bra   $E120
E0FB: A9 53      lda   #$53
E0FD: 85 F0      sta   $F0
E0FF: A9 BA      lda   #$BA
E101: 85 F1      sta   $F1
E103: A9 42      lda   #$42
E105: 85 F2      sta   $F2
E107: 80 17      bra   $E120
E109: 20 90 E1   jsr   $E190
E10C: B0 0C      bcs   $E11A
E10E: C9 02      cmp   #$02
E110: 90 08      bcc   $E11A
E112: C9 1F      cmp   #$1F
E114: B0 04      bcs   $E11A
E116: 85 F3      sta   $F3
E118: 80 06      bra   $E120
E11A: A9 02      lda   #$02
E11C: 85 F3      sta   $F3
E11E: 80 00      bra   $E120
E120: 20 C1 DD   jsr   $DDC1
E123: 60         rts   
E124: 20 71 E2   jsr   $E271
E127: 20 71 E2   jsr   $E271
E12A: C9 74      cmp   #$74
E12C: F0 DB      beq   $E109
E12E: C9 6D      cmp   #$6D
E130: F0 16      beq   $E148
E132: C9 6E      cmp   #$6E
E134: F0 1B      beq   $E151
E136: C9 61      cmp   #$61
E138: F0 20      beq   $E15A
E13A: C9 62      cmp   #$62
E13C: F0 25      beq   $E163
E13E: C9 63      cmp   #$63
E140: F0 2C      beq   $E16E
E142: C9 64      cmp   #$64
E144: F0 33      beq   $E179
E146: 80 47      bra   $E18F
E148: 20 90 E1   jsr   $E190
E14B: B0 42      bcs   $E18F
E14D: 85 C0      sta   $C0
E14F: 80 3B      bra   $E18C
E151: 20 90 E1   jsr   $E190
E154: B0 39      bcs   $E18F
E156: 85 C1      sta   $C1
E158: 80 32      bra   $E18C
E15A: 20 90 E1   jsr   $E190
E15D: B0 30      bcs   $E18F
E15F: 85 C2      sta   $C2
E161: 80 29      bra   $E18C
E163: 20 90 E1   jsr   $E190
E166: B0 27      bcs   $E18F
E168: 29 03      and   #$03
E16A: 85 C3      sta   $C3
E16C: 80 1E      bra   $E18C
E16E: 20 90 E1   jsr   $E190
E171: B0 1C      bcs   $E18F
E173: 29 FE      and   #$FE
E175: 85 C4      sta   $C4
E177: 80 13      bra   $E18C
E179: 20 90 E1   jsr   $E190
E17C: B0 11      bcs   $E18F
E17E: C9 00      cmp   #$00
E180: F0 06      beq   $E188
E182: C9 F8      cmp   #$F8
E184: B0 02      bcs   $E188
E186: F0 04      beq   $E18C
E188: 85 C5      sta   $C5
E18A: 80 00      bra   $E18C
E18C: 20 C1 DD   jsr   $DDC1
E18F: 60         rts   
E190: 20 71 E2   jsr   $E271
E193: 20 39 E2   jsr   $E239
E196: B0 10      bcs   $E1A8
E198: 0A         asl   A
E199: 0A         asl   A
E19A: 0A         asl   A
E19B: 0A         asl   A
E19C: 85 F7      sta   $F7
E19E: 20 71 E2   jsr   $E271
E1A1: 20 39 E2   jsr   $E239
E1A4: B0 02      bcs   $E1A8
E1A6: 05 F7      ora   $F7
E1A8: 60         rts   
E1A9: 20 71 E2   jsr   $E271
E1AC: 20 71 E2   jsr   $E271
E1AF: C9 73      cmp   #$73
E1B1: D0 43      bne   $E1F6
E1B3: 20 71 E2   jsr   $E271
E1B6: 20 39 E2   jsr   $E239
E1B9: B0 3B      bcs   $E1F6
E1BB: 85 F8      sta   $F8
E1BD: 20 71 E2   jsr   $E271
E1C0: 20 39 E2   jsr   $E239
E1C3: B0 31      bcs   $E1F6
E1C5: 0A         asl   A
E1C6: 0A         asl   A
E1C7: 0A         asl   A
E1C8: 0A         asl   A
E1C9: 85 F7      sta   $F7
E1CB: 20 71 E2   jsr   $E271
E1CE: 20 39 E2   jsr   $E239
E1D1: B0 23      bcs   $E1F6
E1D3: 05 F7      ora   $F7
E1D5: 85 F7      sta   $F7
E1D7: 20 71 E2   jsr   $E271
E1DA: 20 39 E2   jsr   $E239
E1DD: B0 17      bcs   $E1F6
E1DF: 0A         asl   A
E1E0: 0A         asl   A
E1E1: 0A         asl   A
E1E2: 0A         asl   A
E1E3: 85 F9      sta   $F9
E1E5: 20 71 E2   jsr   $E271
E1E8: 20 39 E2   jsr   $E239
E1EB: B0 09      bcs   $E1F6
E1ED: 05 F9      ora   $F9
E1EF: A0 00      ldy   #$00
E1F1: 91 F7      sta   ($F7),Y
E1F3: 20 C1 DD   jsr   $DDC1
E1F6: 60         rts   
E1F7: 20 71 E2   jsr   $E271
E1FA: CF BF      seb6  $BF
E1FC: 3C 00 C9   ldm   #$00,$C9
E1FF: 60         rts   
E200: EA         nop   
E201: F7 95 FC   bbc7  $95,$E200
E204: A2 00      ldx   #$00
E206: FF 95      clb7  $95
E208: BD 31 E2   lda   $E231,X
E20B: C9 FF      cmp   #$FF
E20D: F0 1F      beq   $E22E
E20F: 03        .byte $03
E210: 04        .byte $04
E211: AF 04      seb5  $04
E213: 80 02      bra   $E217
E215: BF 04      clb5  $04
E217: 23        .byte $23
E218: 04        .byte $04
E219: 8F 04      seb4  $04
E21B: 80 02      bra   $E21F
E21D: 9F 04      clb4  $04
E21F: 43        .byte $43
E220: 04        .byte $04
E221: CF 0A      seb6  $0A
E223: 80 02      bra   $E227
E225: DF 0A      clb6  $0A
E227: E8         inx   
E228: EA         nop   
E229: F7 95 FC   bbc7  $95,$E228
E22C: 80 D8      bra   $E206
E22E: DF BF      clb6  $BF
E230: 64 00      tst   $00
E232: 01 03      ora   ($03,X)
E234: 02        .byte $02
E235: 00         brk   
E236: 02        .byte $02
E237: 00         brk   
E238: FF C9      clb7  $C9
E23A: 67 B0 16   bbs3  $B0,$E253
E23D: C9 61      cmp   #$61
E23F: B0 0D      bcs   $E24E
E241: C9 30      cmp   #$30
E243: 90 0E      bcc   $E253
E245: C9 3A      cmp   #$3A
E247: B0 0A      bcs   $E253
E249: 38         sec   
E24A: E9 30      sbc   #$30
E24C: 18         clc   
E24D: 60         rts   
E24E: 38         sec   
E24F: E9 57      sbc   #$57
E251: 18         clc   
E252: 60         rts   
E253: 38         sec   
E254: 60         rts   
E255: C9 7B      cmp   #$7B
E257: B0 16      bcs   $E26F
E259: C9 61      cmp   #$61
E25B: B0 0D      bcs   $E26A
E25D: C9 30      cmp   #$30
E25F: 90 0E      bcc   $E26F
E261: C9 3A      cmp   #$3A
E263: B0 0A      bcs   $E26F
E265: 38         sec   
E266: E9 30      sbc   #$30
E268: 18         clc   
E269: 60         rts   
E26A: 38         sec   
E26B: E9 57      sbc   #$57
E26D: 18         clc   
E26E: 60         rts   
E26F: 38         sec   
E270: 60         rts   
E271: A4 BE      ldy   $BE
E273: C4 BD      cpy   $BD
E275: F0 0B      beq   $E282
E277: 08         php   
E278: 78         sei   
E279: B9 1B 01   lda   $011B,Y
E27C: E6 BE      inc   $BE
E27E: BF BE      clb5  $BE
E280: 28         plp   
E281: EA         nop   
E282: 60         rts   
E283: A4 BE      ldy   $BE
E285: C4 BD      cpy   $BD
E287: F0 0D      beq   $E296
E289: 08         php   
E28A: 8A         txa   
E28B: 18         clc   
E28C: 65 BE      adc   $BE
E28E: 29 1F      and   #$1F
E290: A8         tay   
E291: B9 1B 01   lda   $011B,Y
E294: 28         plp   
E295: EA         nop   
E296: 60         rts   
E297: A4 BD      ldy   $BD
E299: 98         tya   
E29A: C4 BE      cpy   $BE
E29C: F0 0B      beq   $E2A9
E29E: 08         php   
E29F: 78         sei   
E2A0: B0 02      bcs   $E2A4
E2A2: 69 20      adc   #$20
E2A4: 38         sec   
E2A5: E5 BE      sbc   $BE
E2A7: 28         plp   
E2A8: EA         nop   
E2A9: 60         rts   
E2AA: 48         pha   
E2AB: 8A         txa   
E2AC: 48         pha   
E2AD: 98         tya   
E2AE: 48         pha   
E2AF: 20 B8 E2   jsr   $E2B8
E2B2: 68         pla   
E2B3: A8         tay   
E2B4: 68         pla   
E2B5: AA         tax   
E2B6: 68         pla   
E2B7: 40         rti   
E2B8: A9 00      lda   #$00
E2BA: C5 BB      cmp   $BB
E2BC: F0 0C      beq   $E2CA
E2BE: A6 BC      ldx   $BC
E2C0: B5 AA      lda   $AA,X
E2C2: 85 18      sta   $18
E2C4: E6 BC      inc   $BC
E2C6: C6 BB      dec   $BB
E2C8: D0 04      bne   $E2CE
E2CA: 7F 3E      clb3  $3E
E2CC: 7F 3C      clb3  $3C
E2CE: 60         rts   
E2CF: 48         pha   
E2D0: 8A         txa   
E2D1: 48         pha   
E2D2: 98         tya   
E2D3: 48         pha   
E2D4: A6 BD      ldx   $BD
E2D6: A5 18      lda   $18
E2D8: 9D 1B 01   sta   $011B,X
E2DB: 8A         txa   
E2DC: 3A        .byte $3A
E2DD: 29 1F      and   #$1F
E2DF: C5 BE      cmp   $BE
E2E1: F0 02      beq   $E2E5
E2E3: 85 BD      sta   $BD
E2E5: 68         pla   
E2E6: A8         tay   
E2E7: 68         pla   
E2E8: AA         tax   
E2E9: 68         pla   
E2EA: 40         rti   
E2EB: 48         pha   
E2EC: 8A         txa   
E2ED: 48         pha   
E2EE: 98         tya   
E2EF: 48         pha   
E2F0: 07 08 0E   bbs0  $08,$E301
E2F3: 3C 08 DC   ldm   #$08,$DC
E2F6: 7F 3F      clb3  $3F
E2F8: 3C 53 25   ldm   #$53,$25
E2FB: EA         nop   
E2FC: EA         nop   
E2FD: DF 3C      clb6  $3C
E2FF: CF 3E      seb6  $3E
E301: 68         pla   
E302: A8         tay   
E303: 68         pla   
E304: AA         tax   
E305: 68         pla   
E306: 40         rti   
E307: 48         pha   
E308: 8A         txa   
E309: 48         pha   
E30A: 98         tya   
E30B: 48         pha   
E30C: C6 DC      dec   $DC
E30E: D0 10      bne   $E320
E310: 7F 3D      clb3  $3D
E312: 6F 3F      seb3  $3F
E314: DF 3C      clb6  $3C
E316: DF 3E      clb6  $3E
E318: A5 DE      lda   $DE
E31A: 85 DD      sta   $DD
E31C: 0F DB      seb0  $DB
E31E: 80 0A      bra   $E32A
E320: 3C 3F 25   ldm   #$3F,$25
E323: 38         sec   
E324: 07 08 01   bbs0  $08,$E328
E327: 18         clc   
E328: 66 DE      ror   $DE
E32A: 68         pla   
E32B: A8         tay   
E32C: 68         pla   
E32D: AA         tax   
E32E: 68         pla   
E32F: 40         rti   
E330: 20 5F E3   jsr   $E35F
E333: 08         php   
E334: 78         sei   
E335: 86 E2      stx   $E2
E337: 84 E3      sty   $E3
E339: 3C 00 E1   ldm   #$00,$E1
E33C: FF 3C      clb7  $3C
E33E: EF 3E      seb7  $3E
E340: 28         plp   
E341: EA         nop   
E342: 60         rts   
E343: 48         pha   
E344: 20 5F E3   jsr   $E35F
E347: 68         pla   
E348: 08         php   
E349: 78         sei   
E34A: 85 E4      sta   $E4
E34C: 3C 24 E5   ldm   #$24,$E5
E34F: 3C E4 E2   ldm   #$E4,$E2
E352: 3C 00 E3   ldm   #$00,$E3
E355: 3C 00 E1   ldm   #$00,$E1
E358: FF 3C      clb7  $3C
E35A: EF 3E      seb7  $3E
E35C: 28         plp   
E35D: EA         nop   
E35E: 60         rts   
E35F: EA         nop   
E360: E7 3E FC   bbs7  $3E,$E35F
E363: A5 E1      lda   $E1
E365: 60         rts   
E366: 48         pha   
E367: 8A         txa   
E368: 48         pha   
E369: 98         tya   
E36A: 48         pha   
E36B: A5 DF      lda   $DF
E36D: D0 17      bne   $E386
E36F: A4 E1      ldy   $E1
E371: B1 E2      lda   ($E2),Y
E373: E6 E1      inc   $E1
E375: C9 24      cmp   #$24
E377: D0 04      bne   $E37D
E379: FF 3E      clb7  $3E
E37B: 80 1B      bra   $E398
E37D: 85 E0      sta   $E0
E37F: DF 08      clb6  $08
E381: 3C 09 DF   ldm   #$09,$DF
E384: 80 12      bra   $E398
E386: C6 DF      dec   $DF
E388: D0 04      bne   $E38E
E38A: CF 08      seb6  $08
E38C: 80 0A      bra   $E398
E38E: 66 E0      ror   $E0
E390: B0 04      bcs   $E396
E392: DF 08      clb6  $08
E394: 80 02      bra   $E398
E396: CF 08      seb6  $08
E398: 68         pla   
E399: A8         tay   
E39A: 68         pla   
E39B: AA         tax   
E39C: 68         pla   
E39D: 40         rti   
E39E: A9 00      lda   #$00
E3A0: 85 F8      sta   $F8
E3A2: 85 F7      sta   $F7
E3A4: AD 14 01   lda   $0114
E3A7: 8D 15 01   sta   $0115
E3AA: A0 F7      ldy   #$F7
E3AC: 20 69 E6   jsr   $E669
E3AF: AD 13 01   lda   $0113
E3B2: 8D 14 01   sta   $0114
E3B5: A0 F7      ldy   #$F7
E3B7: 20 69 E6   jsr   $E669
E3BA: AD 12 01   lda   $0112
E3BD: 8D 13 01   sta   $0113
E3C0: A0 F7      ldy   #$F7
E3C2: 20 69 E6   jsr   $E669
E3C5: A5 72      lda   $72
E3C7: 8D 12 01   sta   $0112
E3CA: A0 F7      ldy   #$F7
E3CC: 20 69 E6   jsr   $E669
E3CF: 46 F8      lsr   $F8
E3D1: 66 F7      ror   $F7
E3D3: 46 F8      lsr   $F8
E3D5: 66 F7      ror   $F7
E3D7: A5 F7      lda   $F7
E3D9: 8D 11 01   sta   $0111
E3DC: 20 19 E4   jsr   $E419
E3DF: 8D 10 01   sta   $0110
E3E2: 60         rts   
E3E3: B7 95 19   bbc5  $95,$E3FF
E3E6: A5 6C      lda   $6C
E3E8: 29 0F      and   #$0F
E3EA: F0 13      beq   $E3FF
E3EC: BF 95      clb5  $95
E3EE: A5 93      lda   $93
E3F0: 85 92      sta   $92
E3F2: A5 94      lda   $94
E3F4: 85 93      sta   $93
E3F6: A5 72      lda   $72
E3F8: 85 94      sta   $94
E3FA: 38         sec   
E3FB: E5 92      sbc   $92
E3FD: 38         sec   
E3FE: 60         rts   
E3FF: 18         clc   
E400: 60         rts   
E401: 20 52 D0   jsr   $D052
E404: F0 10      beq   $E416
E406: A5 92      lda   $92
E408: 20 19 E4   jsr   $E419
E40B: 85 FA      sta   $FA
E40D: A5 94      lda   $94
E40F: 20 19 E4   jsr   $E419
E412: 38         sec   
E413: E5 F9      sbc   $F9
E415: 60         rts   
E416: A9 00      lda   #$00
E418: 60         rts   
E419: 18         clc   
E41A: 69 00      adc   #$00
E41C: AA         tax   
E41D: BD 21 E4   lda   $E421,X
E420: 60         rts   
E421: FF FF      clb7  $FF
E423: FF FF      clb7  $FF
E425: FF FF      clb7  $FF
E427: FF FF      clb7  $FF
E429: FF FF      clb7  $FF
E42B: FF FF      clb7  $FF
E42D: FF FF      clb7  $FF
E42F: FF FF      clb7  $FF
E431: FF FF      clb7  $FF
E433: FF FF      clb7  $FF
E435: FF FF      clb7  $FF
E437: FF FF      clb7  $FF
E439: FF FF      clb7  $FF
E43B: FF FF      clb7  $FF
E43D: FF FF      clb7  $FF
E43F: FF FF      clb7  $FF
E441: FF FF      clb7  $FF
E443: FF FF      clb7  $FF
E445: FF FF      clb7  $FF
E447: FF FF      clb7  $FF
E449: FF FF      clb7  $FF
E44B: FF FF      clb7  $FF
E44D: FF FF      clb7  $FF
E44F: FF FF      clb7  $FF
E451: FF FF      clb7  $FF
E453: FF 41      clb7  $41
E455: 40         rti   
E456: 40         rti   
E457: 3F 3E      clb1  $3E
E459: 3E 3D 3C   rol   $3C3D,X
E45C: 3C 3B 3B   ldm   #$3B,$3B
E45F: 3A        .byte $3A
E460: 39 39 38   and   $3839,Y
E463: 37 37 36   bbc1  $37,$E49C
E466: 35 35      and   $35,X
E468: 34        .byte $34
E469: 34        .byte $34
E46A: 33        .byte $33
E46B: 33        .byte $33
E46C: 32         set   
E46D: 32         set   
E46E: 31 31      and   ($31),Y
E470: 30 30      bmi   $E4A2
E472: 2F 2F      seb1  $2F
E474: 2E 2E 2D   rol   $2D2E
E477: 2D 2C 2C   and   $2C2C
E47A: 2B         seb1  A
E47B: 2B         seb1  A
E47C: 2A         rol   A
E47D: 2A         rol   A
E47E: 29 29      and   #$29
E480: 28         plp   
E481: 28         plp   
E482: 27 27 26   bbs1  $27,$E4AB
E485: 26 25      rol   $25
E487: 25 24      and   $24
E489: 24 23      bit   $23
E48B: 23        .byte $23
E48C: 22        .byte $22
E48D: 22        .byte $22
E48E: 21 21      and   ($21,X)
E490: 20 20 1F   jsr   $1F20
E493: 1F 1E      clb0  $1E
E495: 1E 1E 1D   asl   $1D1E,X
E498: 1D 1C 1C   ora   $1C1C,X
E49B: 1B         clb0  A
E49C: 1B         clb0  A
E49D: 1A        .byte $1A
E49E: 1A        .byte $1A
E49F: 1A        .byte $1A
E4A0: 19 19 19   ora   $1919,Y
E4A3: 18         clc   
E4A4: 18         clc   
E4A5: 18         clc   
E4A6: 17 17 16   bbc0  $17,$E4BF
E4A9: 16 15      asl   $15,X
E4AB: 15 14      ora   $14,X
E4AD: 14        .byte $14
E4AE: 14        .byte $14
E4AF: 13        .byte $13
E4B0: 13        .byte $13
E4B1: 12         clt   
E4B2: 12         clt   
E4B3: 12         clt   
E4B4: 11 11      ora   ($11),Y
E4B6: 10 10      bpl   $E4C8
E4B8: 0F 0F      seb0  $0F
E4BA: 0E 0E 0E   asl   $0E0E
E4BD: 0D 0D 0C   ora   $0C0D
E4C0: 0C        .byte $0C
E4C1: 0C        .byte $0C
E4C2: 0B         seb0  A
E4C3: 0B         seb0  A
E4C4: 0A         asl   A
E4C5: 0A         asl   A
E4C6: 0A         asl   A
E4C7: 09 09      ora   #$09
E4C9: 09 08      ora   #$08
E4CB: 08         php   
E4CC: 07 07 07   bbs0  $07,$E4D6
E4CF: 06 06      asl   $06
E4D1: 05 05      ora   $05
E4D3: 04        .byte $04
E4D4: 04        .byte $04
E4D5: 03        .byte $03
E4D6: 03        .byte $03
E4D7: 02        .byte $02
E4D8: 02        .byte $02
E4D9: 01 01      ora   ($01,X)
E4DB: 00         brk   
E4DC: 00         brk   
E4DD: 00         brk   
E4DE: 00         brk   
E4DF: 00         brk   
E4E0: 00         brk   
E4E1: 00         brk   
E4E2: 00         brk   
E4E3: 00         brk   
E4E4: 00         brk   
E4E5: 00         brk   
E4E6: 00         brk   
E4E7: 00         brk   
E4E8: 00         brk   
E4E9: 00         brk   
E4EA: 00         brk   
E4EB: 00         brk   
E4EC: 00         brk   
E4ED: 00         brk   
E4EE: 00         brk   
E4EF: 00         brk   
E4F0: 00         brk   
E4F1: 00         brk   
E4F2: 00         brk   
E4F3: 00         brk   
E4F4: 00         brk   
E4F5: 00         brk   
E4F6: 00         brk   
E4F7: 00         brk   
E4F8: 00         brk   
E4F9: 00         brk   
E4FA: 00         brk   
E4FB: 00         brk   
E4FC: 00         brk   
E4FD: 00         brk   
E4FE: 00         brk   
E4FF: 00         brk   
E500: 60         rts   
E501: 00         brk   
E502: 00         brk   
E503: 00         brk   
E504: 00         brk   
E505: 00         brk   
E506: 00         brk   
E507: 00         brk   
E508: 00         brk   
E509: 00         brk   
E50A: 00         brk   
E50B: 00         brk   
E50C: 00         brk   
E50D: 00         brk   
E50E: 00         brk   
E50F: 00         brk   
E510: 00         brk   
E511: 00         brk   
E512: 00         brk   
E513: 00         brk   
E514: 00         brk   
E515: 00         brk   
E516: 00         brk   
E517: 00         brk   
E518: 00         brk   
E519: 00         brk   
E51A: 00         brk   
E51B: 00         brk   
E51C: 00         brk   
E51D: 00         brk   
E51E: 00         brk   
E51F: 00         brk   
E520: 00         brk   
E521: 87 C2 12   bbs4  $C2,$E536
E524: A5 72      lda   $72
E526: C9 D2      cmp   #$D2
E528: B0 0C      bcs   $E536
E52A: 20 19 E4   jsr   $E419
E52D: C9 FF      cmp   #$FF
E52F: F0 0D      beq   $E53E
E531: AA         tax   
E532: BD 39 E5   lda   $E539,X
E535: 60         rts   
E536: A9 00      lda   #$00
E538: 60         rts   
E539: FC        .byte $FC
E53A: FC        .byte $FC
E53B: FC        .byte $FC
E53C: FC        .byte $FC
E53D: FC        .byte $FC
E53E: FD FD FD   sbc   $FDFD,X
E541: FD FD FE   sbc   $FEFD,X
E544: FE FE FE   inc   $FEFE,X
E547: FE FF FF   inc   $FFFF,X
E54A: FF FF      clb7  $FF
E54C: FF 00      clb7  $00
E54E: 00         brk   
E54F: 00         brk   
E550: 00         brk   
E551: 00         brk   
E552: 00         brk   
E553: 00         brk   
E554: 00         brk   
E555: 00         brk   
E556: 00         brk   
E557: 00         brk   
E558: 00         brk   
E559: 00         brk   
E55A: 00         brk   
E55B: 00         brk   
E55C: 00         brk   
E55D: 00         brk   
E55E: 01 01      ora   ($01,X)
E560: 01 01      ora   ($01,X)
E562: 01 01      ora   ($01,X)
E564: 01 01      ora   ($01,X)
E566: 01 01      ora   ($01,X)
E568: 01 01      ora   ($01,X)
E56A: 01 01      ora   ($01,X)
E56C: 01 01      ora   ($01,X)
E56E: 01 01      ora   ($01,X)
E570: 01 01      ora   ($01,X)
E572: 01 01      ora   ($01,X)
E574: 01 01      ora   ($01,X)
E576: 01 01      ora   ($01,X)
E578: 01 01      ora   ($01,X)
E57A: 01 01      ora   ($01,X)
E57C: 01 01      ora   ($01,X)
E57E: 01 01      ora   ($01,X)
E580: 01 01      ora   ($01,X)
E582: 01 00      ora   ($00,X)
E584: 00         brk   
E585: 00         brk   
E586: 00         brk   
E587: 00         brk   
E588: 00         brk   
E589: 20 21 E5   jsr   $E521
E58C: F0 3F      beq   $E5CD
E58E: 30 16      bmi   $E5A6
E590: 85 FC      sta   $FC
E592: A5 70      lda   $70
E594: 4A         lsr   A
E595: 4A         lsr   A
E596: AA         tax   
E597: BD D0 E5   lda   $E5D0,X
E59A: F0 2E      beq   $E5CA
E59C: 85 FB      sta   $FB
E59E: A5 FC      lda   $FC
E5A0: 4A         lsr   A
E5A1: C6 FB      dec   $FB
E5A3: D0 FB      bne   $E5A0
E5A5: 60         rts   
E5A6: 85 FC      sta   $FC
E5A8: A5 70      lda   $70
E5AA: 4A         lsr   A
E5AB: 4A         lsr   A
E5AC: AA         tax   
E5AD: BD D0 E5   lda   $E5D0,X
E5B0: F0 18      beq   $E5CA
E5B2: 85 FB      sta   $FB
E5B4: 44        .byte $44
E5B5: FC        .byte $FC
E5B6: A5 FC      lda   $FC
E5B8: 3A        .byte $3A
E5B9: 4A         lsr   A
E5BA: C6 FB      dec   $FB
E5BC: D0 FB      bne   $E5B9
E5BE: C9 00      cmp   #$00
E5C0: F0 0B      beq   $E5CD
E5C2: 1A        .byte $1A
E5C3: 85 FC      sta   $FC
E5C5: 44        .byte $44
E5C6: FC        .byte $FC
E5C7: A5 FC      lda   $FC
E5C9: 60         rts   
E5CA: A5 FC      lda   $FC
E5CC: 60         rts   
E5CD: A9 00      lda   #$00
E5CF: 60         rts   
E5D0: 03        .byte $03
E5D1: 02        .byte $02
E5D2: 01 01      ora   ($01,X)
E5D4: 01 00      ora   ($00,X)
E5D6: 00         brk   
E5D7: 00         brk   
E5D8: 00         brk   
E5D9: 00         brk   
E5DA: 00         brk   
E5DB: 00         brk   
E5DC: 00         brk   
E5DD: 00         brk   
E5DE: 00         brk   
E5DF: 00         brk   
E5E0: 00         brk   
E5E1: 00         brk   
E5E2: 00         brk   
E5E3: 00         brk   
E5E4: 00         brk   
E5E5: 00         brk   
E5E6: 00         brk   
E5E7: 00         brk   
E5E8: 00         brk   
E5E9: 00         brk   
E5EA: 00         brk   
E5EB: 00         brk   
E5EC: 00         brk   
E5ED: 00         brk   
E5EE: 00         brk   
E5EF: 00         brk   
E5F0: 00         brk   
E5F1: 00         brk   
E5F2: 00         brk   
E5F3: 00         brk   
E5F4: 00         brk   
E5F5: 00         brk   
E5F6: 00         brk   
E5F7: 00         brk   
E5F8: 00         brk   
E5F9: 00         brk   
E5FA: 00         brk   
E5FB: 00         brk   
E5FC: 00         brk   
E5FD: 00         brk   
E5FE: 00         brk   
E5FF: 00         brk   
E600: 00         brk   
E601: 00         brk   
E602: 00         brk   
E603: 00         brk   
E604: 00         brk   
E605: 00         brk   
E606: 00         brk   
E607: 00         brk   
E608: 00         brk   
E609: 00         brk   
E60A: 00         brk   
E60B: 00         brk   
E60C: 00         brk   
E60D: 00         brk   
E60E: 00         brk   
E60F: 00         brk   
E610: 00         brk   
E611: B9 00 00   lda   $0000,Y
E614: D0 06      bne   $E61C
E616: B9 01 00   lda   $0001,Y
E619: D0 01      bne   $E61C
E61B: 60         rts   
E61C: 60         rts   
E61D: 48         pha   
E61E: B9 00 00   lda   $0000,Y
E621: 38         sec   
E622: E9 01      sbc   #$01
E624: 99 00 00   sta   $0000,Y
E627: B9 01 00   lda   $0001,Y
E62A: E9 00      sbc   #$00
E62C: 99 01 00   sta   $0001,Y
E62F: 68         pla   
E630: 61 18      adc   ($18,X)
E632: 79 00 00   adc   $0000,Y
E635: 99 00 00   sta   $0000,Y
E638: A9 00      lda   #$00
E63A: 79 01 00   adc   $0001,Y
E63D: 99 01 00   sta   $0001,Y
E640: A9 00      lda   #$00
E642: 79 02 00   adc   $0002,Y
E645: 99 02 00   sta   $0002,Y
E648: A9 00      lda   #$00
E64A: 79 03 00   adc   $0003,Y
E64D: 99 03 00   sta   $0003,Y
E650: 60         rts   
E651: 18         clc   
E652: 79 00 00   adc   $0000,Y
E655: 99 00 00   sta   $0000,Y
E658: A9 00      lda   #$00
E65A: 79 01 00   adc   $0001,Y
E65D: 99 01 00   sta   $0001,Y
E660: A9 00      lda   #$00
E662: 79 02 00   adc   $0002,Y
E665: 99 02 00   sta   $0002,Y
E668: 60         rts   
E669: 18         clc   
E66A: 79 00 00   adc   $0000,Y
E66D: 99 00 00   sta   $0000,Y
E670: A9 00      lda   #$00
E672: 79 01 00   adc   $0001,Y
E675: 99 01 00   sta   $0001,Y
E678: 60         rts   
E679: 85 F7      sta   $F7
E67B: 38         sec   
E67C: B9 00 00   lda   $0000,Y
E67F: E5 F7      sbc   $F7
E681: 99 00 00   sta   $0000,Y
E684: B9 01 00   lda   $0001,Y
E687: E9 00      sbc   #$00
E689: 99 01 00   sta   $0001,Y
E68C: B9 02 00   lda   $0002,Y
E68F: E9 00      sbc   #$00
E691: 99 02 00   sta   $0002,Y
E694: B9 03 00   lda   $0003,Y
E697: E9 00      sbc   #$00
E699: 99 03 00   sta   $0003,Y
E69C: 60         rts   
E69D: 85 F7      sta   $F7
E69F: 38         sec   
E6A0: B9 00 00   lda   $0000,Y
E6A3: E5 F7      sbc   $F7
E6A5: 99 00 00   sta   $0000,Y
E6A8: B9 01 00   lda   $0001,Y
E6AB: E9 00      sbc   #$00
E6AD: 99 01 00   sta   $0001,Y
E6B0: 60         rts   
E6B1: 78         sei   
E6B2: D8         cld   
E6B3: 12         clt   
E6B4: B8         clv   
E6B5: 4C CC E6   jmp   $E6CC
E6B8: 20 E9 E7   jsr   $E7E9
E6BB: A0 55      ldy   #$55
E6BD: A9 00      lda   #$00
E6BF: 20 77 CD   jsr   $CD77
E6C2: 90 03      bcc   $E6C7
E6C4: 4C 17 CD   jmp   $CD17
E6C7: A9 01      lda   #$01
E6C9: 4C 17 CD   jmp   $CD17
E6CC: A2 00      ldx   #$00
E6CE: BC 1D E7   ldy   $E71D,X
E6D1: C0 40      cpy   #$40
E6D3: F0 0A      beq   $E6DF
E6D5: E8         inx   
E6D6: BD 1D E7   lda   $E71D,X
E6D9: 99 00 00   sta   $0000,Y
E6DC: E8         inx   
E6DD: 80 EF      bra   $E6CE
E6DF: A9 00      lda   #$00
E6E1: A2 40      ldx   #$40
E6E3: 95 00      sta   $00,X
E6E5: E8         inx   
E6E6: E0 00      cpx   #$00
E6E8: D0 F9      bne   $E6E3
E6EA: AA         tax   
E6EB: 9D 00 01   sta   $0100,X
E6EE: E8         inx   
E6EF: E0 C0      cpx   #$C0
E6F1: D0 F8      bne   $E6EB
E6F3: A2 BE      ldx   #$BE
E6F5: 9A         txs   
E6F6: 4C B8 E6   jmp   $E6B8
E6F9: A0 00      ldy   #$00
E6FB: B1 F5      lda   ($F5),Y
E6FD: F0 0C      beq   $E70B
E6FF: C9 40      cmp   #$40
E701: F0 19      beq   $E71C
E703: C8         iny   
E704: B1 F5      lda   ($F5),Y
E706: AA         tax   
E707: B5 00      lda   $00,X
E709: 80 06      bra   $E711
E70B: C8         iny   
E70C: B1 F5      lda   ($F5),Y
E70E: AA         tax   
E70F: A9 00      lda   #$00
E711: C8         iny   
E712: 31 F5      and   ($F5),Y
E714: C8         iny   
E715: 11 F5      ora   ($F5),Y
E717: 95 00      sta   $00,X
E719: C8         iny   
E71A: 80 DF      bra   $E6FB
E71C: 60         rts   
E71D: 00         brk   
E71E: 00         brk   
E71F: 01 00      ora   ($00,X)
E721: 02        .byte $02
E722: A0 03      ldy   #$03
E724: FF 04      clb7  $04
E726: BC 05 FF   ldy   $FF05,X
E729: 08         php   
E72A: 40         rti   
E72B: 09 A4      ora   #$A4
E72D: 0A         asl   A
E72E: C0 0B      cpy   #$0B
E730: FC        .byte $FC
E731: 0C        .byte $0C
E732: 00         brk   
E733: 0D 00 0E   ora   $0E00
E736: 00         brk   
E737: 0F 00      seb0  $00
E739: 16 01      asl   $01,X
E73B: 17 00 1A   bbc0  $00,$E758
E73E: 01 1B      ora   ($1B,X)
E740: 00         brk   
E741: 1C        .byte $1C
E742: 1F 27      clb0  $27
E744: D0 28      bne   $E76E
E746: 00         brk   
E747: 22        .byte $22
E748: FF 23      clb7  $23
E74A: 95 29      sta   $29,X
E74C: 18         clc   
E74D: 25 7F      and   $7F
E74F: 26 7F      rol   $7F
E751: 2A         rol   A
E752: 00         brk   
E753: 34        .byte $34
E754: 08         php   
E755: 38         sec   
E756: 00         brk   
E757: 39 83 3A   and   $3A83,Y
E75A: 09 3B      ora   #$3B
E75C: 0C        .byte $0C
E75D: 3E 20 3F   rol   $3F20,X
E760: 40         rti   
E761: 3C 00 3D   ldm   #$00,$3D
E764: 00         brk   
E765: 40         rti   
E766: 01 3E      ora   ($3E,X)
E768: 2C 00 01   bit   $0100
E76B: 3F C0      clb1  $C0
E76D: 00         brk   
E76E: 00         brk   
E76F: 01 00      ora   ($00,X)
E771: 00         brk   
E772: 01 02      ora   ($02,X)
E774: 00         brk   
E775: A0 01      ldy   #$01
E777: 27 FF 80   bbs1  $FF,$E6FA
E77A: 00         brk   
E77B: 22        .byte $22
E77C: FF FF      clb7  $FF
E77E: 00         brk   
E77F: 23        .byte $23
E780: 95 95      sta   $95,X
E782: 01 3B      ora   ($3B,X)
E784: 4F 4C      seb2  $4C
E786: 40         rti   
E787: 01 3E      ora   ($3E,X)
E789: 20 00 01   jsr   $0100
E78C: 3F C0      clb1  $C0
E78E: 00         brk   
E78F: 01 1A      ora   ($1A,X)
E791: 4B         seb2  A
E792: 00         brk   
E793: 00         brk   
E794: 01 00      ora   ($00,X)
E796: 00         brk   
E797: 01 02      ora   ($02,X)
E799: 00         brk   
E79A: 80 01      bra   $E79D
E79C: 04        .byte $04
E79D: F3        .byte $F3
E79E: 00         brk   
E79F: 01 08      ora   ($08,X)
E7A1: C0 00      cpy   #$00
E7A3: 01 27      ora   ($27,X)
E7A5: FF 80      clb7  $80
E7A7: 00         brk   
E7A8: 22        .byte $22
E7A9: FF FF      clb7  $FF
E7AB: 00         brk   
E7AC: 23        .byte $23
E7AD: 95 95      sta   $95,X
E7AF: 01 3B      ora   ($3B,X)
E7B1: 4F 4C      seb2  $4C
E7B3: 40         rti   
E7B4: 00         brk   
E7B5: 01 00      ora   ($00,X)
E7B7: 00         brk   
E7B8: 01 02      ora   ($02,X)
E7BA: 00         brk   
E7BB: A0 00      ldy   #$00
E7BD: 1A        .byte $1A
E7BE: 01 01      ora   ($01,X)
E7C0: 00         brk   
E7C1: 1C        .byte $1C
E7C2: 1F 1F      clb0  $1F
E7C4: 00         brk   
E7C5: 1B         clb0  A
E7C6: 00         brk   
E7C7: 00         brk   
E7C8: 00         brk   
E7C9: 19 05 05   ora   $0505,Y
E7CC: 00         brk   
E7CD: 1A        .byte $1A
E7CE: B1 B1      lda   ($B1),Y
E7D0: 01 27      ora   ($27,X)
E7D2: FF 80      clb7  $80
E7D4: 00         brk   
E7D5: 22        .byte $22
E7D6: FF FF      clb7  $FF
E7D8: 00         brk   
E7D9: 23        .byte $23
E7DA: 0E 0E 01   asl   $010E
E7DD: 3B         clb1  A
E7DE: 0F 0C      seb0  $0C
E7E0: 01 3E      ora   ($3E,X)
E7E2: FF 24      clb7  $24
E7E4: 01 3F      ora   ($3F,X)
E7E6: C0 00      cpy   #$00
E7E8: 40         rti   
E7E9: A2 00      ldx   #$00
E7EB: BC 30 E8   ldy   $E830,X
E7EE: C0 00      cpy   #$00
E7F0: F0 0A      beq   $E7FC
E7F2: E8         inx   
E7F3: BD 30 E8   lda   $E830,X
E7F6: 99 00 00   sta   $0000,Y
E7F9: E8         inx   
E7FA: 80 EF      bra   $E7EB
E7FC: 20 9A D0   jsr   $D09A
E7FF: 8A         txa   
E800: F0 08      beq   $E80A
E802: 07 08 03   bbs0  $08,$E808
E805: 37 0E 02   bbc1  $0E,$E80A
E808: 0F 6D      seb0  $6D
E80A: 20 0A CF   jsr   $CF0A
E80D: 20 1D CF   jsr   $CF1D
E810: 3C FE C5   ldm   #$FE,$C5
E813: A9 B6      lda   #$B6
E815: 85 ED      sta   $ED
E817: A9 9F      lda   #$9F
E819: 85 EE      sta   $EE
E81B: A9 A3      lda   #$A3
E81D: 85 EF      sta   $EF
E81F: A9 53      lda   #$53
E821: 85 F0      sta   $F0
E823: A9 BA      lda   #$BA
E825: 85 F1      sta   $F1
E827: A9 42      lda   #$42
E829: 85 F2      sta   $F2
E82B: A9 02      lda   #$02
E82D: 85 F3      sta   $F3
E82F: 60         rts   
E830: 50 20      bvc   $E852
E832: 96 28      stx   $28,Y
E834: A1 0A      lda   ($0A,X)
E836: A2 04      ldx   #$04
E838: A3        .byte $A3
E839: 3C AA FF   ldm   #$AA,$FF
E83C: AB         seb5  A
E83D: 0F AC      seb0  $AC
E83F: 38         sec   
E840: 6D 30 00   adc   $0030
E843: 3C 40 50   ldm   #$40,$50
E846: 1F 82      clb0  $82
E848: 3C 00 8F   ldm   #$00,$8F
E84B: FF D3      clb7  $D3
E84D: DF 80      clb6  $80
E84F: FF 80      clb7  $80
E851: 1F 80      clb0  $80
E853: BF 80      clb5  $80
E855: 9F 80      clb4  $80
E857: 3C 00 81   ldm   #$00,$81
E85A: 07 C1 04   bbs0  $C1,$E861
E85D: 7F 3C      clb3  $3C
E85F: 5F 3C      clb2  $3C
E861: 3F 3C      clb1  $3C
E863: 20 0A CF   jsr   $CF0A
E866: 20 1D CF   jsr   $CF1D
E869: DF BF      clb6  $BF
E86B: 9F BF      clb4  $BF
E86D: 7F BF      clb3  $BF
E86F: A9 00      lda   #$00
E871: 85 CD      sta   $CD
E873: 20 C3 D1   jsr   $D1C3
E876: 60         rts   
E877: 3C 20 50   ldm   #$20,$50
E87A: 1F 82      clb0  $82
E87C: 3C 00 8F   ldm   #$00,$8F
E87F: FF DF      clb7  $DF
E881: DF 80      clb6  $80
E883: FF 80      clb7  $80
E885: 1F 80      clb0  $80
E887: BF 80      clb5  $80
E889: 9F 80      clb4  $80
E88B: 3C 00 81   ldm   #$00,$81
E88E: 7F 3C      clb3  $3C
E890: 5F 3C      clb2  $3C
E892: 3F 3C      clb1  $3C
E894: 20 0A CF   jsr   $CF0A
E897: 20 1D CF   jsr   $CF1D
E89A: DF BF      clb6  $BF
E89C: 9F BF      clb4  $BF
E89E: 7F BF      clb3  $BF
E8A0: A9 00      lda   #$00
E8A2: 85 CD      sta   $CD
E8A4: 20 C3 D1   jsr   $D1C3
E8A7: 60         rts   
E8A8: FF BF      clb7  $BF
E8AA: 3C 08 A4   ldm   #$08,$A4
E8AD: 20 96 D5   jsr   $D596
E8B0: 3C 80 50   ldm   #$80,$50
E8B3: 3C 00 8F   ldm   #$00,$8F
E8B6: DF 95      clb6  $95
E8B8: 3C 03 96   ldm   #$03,$96
E8BB: 3C 00 BB   ldm   #$00,$BB
E8BE: 3C 00 BD   ldm   #$00,$BD
E8C1: 3C 00 BE   ldm   #$00,$BE
E8C4: 7F BF      clb3  $BF
E8C6: A9 00      lda   #$00
E8C8: 85 CD      sta   $CD
E8CA: DF 80      clb6  $80
E8CC: 3C 00 CE   ldm   #$00,$CE
E8CF: 3C 00 CF   ldm   #$00,$CF
E8D2: 3C 00 D0   ldm   #$00,$D0
E8D5: 3C 40 D3   ldm   #$40,$D3
E8D8: 3C 80 D5   ldm   #$80,$D5
E8DB: 3C 00 D6   ldm   #$00,$D6
E8DE: 3C 00 D7   ldm   #$00,$D7
E8E1: 3C 00 D8   ldm   #$00,$D8
E8E4: 3C 00 D9   ldm   #$00,$D9
E8E7: FF 80      clb7  $80
E8E9: 1F 80      clb0  $80
E8EB: BF 80      clb5  $80
E8ED: 9F 80      clb4  $80
E8EF: 3C 00 81   ldm   #$00,$81
E8F2: 7F 3C      clb3  $3C
E8F4: 5F 3C      clb2  $3C
E8F6: 3F 3C      clb1  $3C
E8F8: 20 C3 D1   jsr   $D1C3
E8FB: 60         rts   
E8FC: 40         rti   
E8FD: 60         rts   
E8FE: FF FF      clb7  $FF
E900: FF FF      clb7  $FF
E902: FF FF      clb7  $FF
E904: FF FF      clb7  $FF
E906: FF FF      clb7  $FF
E908: FF FF      clb7  $FF
E90A: FF FF      clb7  $FF
E90C: FF FF      clb7  $FF
E90E: FF FF      clb7  $FF
E910: FF FF      clb7  $FF
E912: FF FF      clb7  $FF
E914: FF FF      clb7  $FF
E916: FF FF      clb7  $FF
E918: FF FF      clb7  $FF
E91A: FF FF      clb7  $FF
E91C: FF FF      clb7  $FF
E91E: FF FF      clb7  $FF
E920: FF FF      clb7  $FF
E922: FF FF      clb7  $FF
E924: FF FF      clb7  $FF
E926: FF FF      clb7  $FF
E928: FF FF      clb7  $FF
E92A: FF FF      clb7  $FF
E92C: FF FF      clb7  $FF
E92E: FF FF      clb7  $FF
E930: FF FF      clb7  $FF
E932: FF FF      clb7  $FF
E934: FF FF      clb7  $FF
E936: FF FF      clb7  $FF
E938: FF FF      clb7  $FF
E93A: FF FF      clb7  $FF
E93C: FF FF      clb7  $FF
E93E: FF FF      clb7  $FF
E940: FF FF      clb7  $FF
E942: FF FF      clb7  $FF
E944: FF FF      clb7  $FF
E946: FF FF      clb7  $FF
E948: FF FF      clb7  $FF
E94A: FF FF      clb7  $FF
E94C: FF FF      clb7  $FF
E94E: FF FF      clb7  $FF
E950: FF FF      clb7  $FF
E952: FF FF      clb7  $FF
E954: FF FF      clb7  $FF
E956: FF FF      clb7  $FF
E958: FF FF      clb7  $FF
E95A: FF FF      clb7  $FF
E95C: FF FF      clb7  $FF
E95E: FF FF      clb7  $FF
E960: FF FF      clb7  $FF
E962: FF FF      clb7  $FF
E964: FF FF      clb7  $FF
E966: FF FF      clb7  $FF
E968: FF FF      clb7  $FF
E96A: FF FF      clb7  $FF
E96C: FF FF      clb7  $FF
E96E: FF FF      clb7  $FF
E970: FF FF      clb7  $FF
E972: FF FF      clb7  $FF
E974: FF FF      clb7  $FF
E976: FF FF      clb7  $FF
E978: FF FF      clb7  $FF
E97A: FF FF      clb7  $FF
E97C: FF FF      clb7  $FF
E97E: FF FF      clb7  $FF
E980: FF FF      clb7  $FF
E982: FF FF      clb7  $FF
E984: FF FF      clb7  $FF
E986: FF FF      clb7  $FF
E988: FF FF      clb7  $FF
E98A: FF FF      clb7  $FF
E98C: FF FF      clb7  $FF
E98E: FF FF      clb7  $FF
E990: FF FF      clb7  $FF
E992: FF FF      clb7  $FF
E994: FF FF      clb7  $FF
E996: FF FF      clb7  $FF
E998: FF FF      clb7  $FF
E99A: FF FF      clb7  $FF
E99C: FF FF      clb7  $FF
E99E: FF FF      clb7  $FF
E9A0: FF FF      clb7  $FF
E9A2: FF FF      clb7  $FF
E9A4: FF FF      clb7  $FF
E9A6: FF FF      clb7  $FF
E9A8: FF FF      clb7  $FF
E9AA: FF FF      clb7  $FF
E9AC: FF FF      clb7  $FF
E9AE: FF FF      clb7  $FF
E9B0: FF FF      clb7  $FF
E9B2: FF FF      clb7  $FF
E9B4: FF FF      clb7  $FF
E9B6: FF FF      clb7  $FF
E9B8: FF FF      clb7  $FF
E9BA: FF FF      clb7  $FF
E9BC: FF FF      clb7  $FF
E9BE: FF FF      clb7  $FF
E9C0: FF FF      clb7  $FF
E9C2: FF FF      clb7  $FF
E9C4: FF FF      clb7  $FF
E9C6: FF FF      clb7  $FF
E9C8: FF FF      clb7  $FF
E9CA: FF FF      clb7  $FF
E9CC: FF FF      clb7  $FF
E9CE: FF FF      clb7  $FF
E9D0: FF FF      clb7  $FF
E9D2: FF FF      clb7  $FF
E9D4: FF FF      clb7  $FF
E9D6: FF FF      clb7  $FF
E9D8: FF FF      clb7  $FF
E9DA: FF FF      clb7  $FF
E9DC: FF FF      clb7  $FF
E9DE: FF FF      clb7  $FF
E9E0: FF FF      clb7  $FF
E9E2: FF FF      clb7  $FF
E9E4: FF FF      clb7  $FF
E9E6: FF FF      clb7  $FF
E9E8: FF FF      clb7  $FF
E9EA: FF FF      clb7  $FF
E9EC: FF FF      clb7  $FF
E9EE: FF FF      clb7  $FF
E9F0: FF FF      clb7  $FF
E9F2: FF FF      clb7  $FF
E9F4: FF FF      clb7  $FF
E9F6: FF FF      clb7  $FF
E9F8: FF FF      clb7  $FF
E9FA: FF FF      clb7  $FF
E9FC: FF FF      clb7  $FF
E9FE: FF FF      clb7  $FF
EA00: FF FF      clb7  $FF
EA02: FF FF      clb7  $FF
EA04: FF FF      clb7  $FF
EA06: FF FF      clb7  $FF
EA08: FF FF      clb7  $FF
EA0A: FF FF      clb7  $FF
EA0C: FF FF      clb7  $FF
EA0E: FF FF      clb7  $FF
EA10: FF FF      clb7  $FF
EA12: FF FF      clb7  $FF
EA14: FF FF      clb7  $FF
EA16: FF FF      clb7  $FF
EA18: FF FF      clb7  $FF
EA1A: FF FF      clb7  $FF
EA1C: FF FF      clb7  $FF
EA1E: FF FF      clb7  $FF
EA20: FF FF      clb7  $FF
EA22: FF FF      clb7  $FF
EA24: FF FF      clb7  $FF
EA26: FF FF      clb7  $FF
EA28: FF FF      clb7  $FF
EA2A: FF FF      clb7  $FF
EA2C: FF FF      clb7  $FF
EA2E: FF FF      clb7  $FF
EA30: FF FF      clb7  $FF
EA32: FF FF      clb7  $FF
EA34: FF FF      clb7  $FF
EA36: FF FF      clb7  $FF
EA38: FF FF      clb7  $FF
EA3A: FF FF      clb7  $FF
EA3C: FF FF      clb7  $FF
EA3E: FF FF      clb7  $FF
EA40: FF FF      clb7  $FF
EA42: FF FF      clb7  $FF
EA44: FF FF      clb7  $FF
EA46: FF FF      clb7  $FF
EA48: FF FF      clb7  $FF
EA4A: FF FF      clb7  $FF
EA4C: FF FF      clb7  $FF
EA4E: FF FF      clb7  $FF
EA50: FF FF      clb7  $FF
EA52: FF FF      clb7  $FF
EA54: FF FF      clb7  $FF
EA56: FF FF      clb7  $FF
EA58: FF FF      clb7  $FF
EA5A: FF FF      clb7  $FF
EA5C: FF FF      clb7  $FF
EA5E: FF FF      clb7  $FF
EA60: FF FF      clb7  $FF
EA62: FF FF      clb7  $FF
EA64: FF FF      clb7  $FF
EA66: FF FF      clb7  $FF
EA68: FF FF      clb7  $FF
EA6A: FF FF      clb7  $FF
EA6C: FF FF      clb7  $FF
EA6E: FF FF      clb7  $FF
EA70: FF FF      clb7  $FF
EA72: FF FF      clb7  $FF
EA74: FF FF      clb7  $FF
EA76: FF FF      clb7  $FF
EA78: FF FF      clb7  $FF
EA7A: FF FF      clb7  $FF
EA7C: FF FF      clb7  $FF
EA7E: FF FF      clb7  $FF
EA80: FF FF      clb7  $FF
EA82: FF FF      clb7  $FF
EA84: FF FF      clb7  $FF
EA86: FF FF      clb7  $FF
EA88: FF FF      clb7  $FF
EA8A: FF FF      clb7  $FF
EA8C: FF FF      clb7  $FF
EA8E: FF FF      clb7  $FF
EA90: FF FF      clb7  $FF
EA92: FF FF      clb7  $FF
EA94: FF FF      clb7  $FF
EA96: FF FF      clb7  $FF
EA98: FF FF      clb7  $FF
EA9A: FF FF      clb7  $FF
EA9C: FF FF      clb7  $FF
EA9E: FF FF      clb7  $FF
EAA0: FF FF      clb7  $FF
EAA2: FF FF      clb7  $FF
EAA4: FF FF      clb7  $FF
EAA6: FF FF      clb7  $FF
EAA8: FF FF      clb7  $FF
EAAA: FF FF      clb7  $FF
EAAC: FF FF      clb7  $FF
EAAE: FF FF      clb7  $FF
EAB0: FF FF      clb7  $FF
EAB2: FF FF      clb7  $FF
EAB4: FF FF      clb7  $FF
EAB6: FF FF      clb7  $FF
EAB8: FF FF      clb7  $FF
EABA: FF FF      clb7  $FF
EABC: FF FF      clb7  $FF
EABE: FF FF      clb7  $FF
EAC0: FF FF      clb7  $FF
EAC2: FF FF      clb7  $FF
EAC4: FF FF      clb7  $FF
EAC6: FF FF      clb7  $FF
EAC8: FF FF      clb7  $FF
EACA: FF FF      clb7  $FF
EACC: FF FF      clb7  $FF
EACE: FF FF      clb7  $FF
EAD0: FF FF      clb7  $FF
EAD2: FF FF      clb7  $FF
EAD4: FF FF      clb7  $FF
EAD6: FF FF      clb7  $FF
EAD8: FF FF      clb7  $FF
EADA: FF FF      clb7  $FF
EADC: FF FF      clb7  $FF
EADE: FF FF      clb7  $FF
EAE0: FF FF      clb7  $FF
EAE2: FF FF      clb7  $FF
EAE4: FF FF      clb7  $FF
EAE6: FF FF      clb7  $FF
EAE8: FF FF      clb7  $FF
EAEA: FF FF      clb7  $FF
EAEC: FF FF      clb7  $FF
EAEE: FF FF      clb7  $FF
EAF0: FF FF      clb7  $FF
EAF2: FF FF      clb7  $FF
EAF4: FF FF      clb7  $FF
EAF6: FF FF      clb7  $FF
EAF8: FF FF      clb7  $FF
EAFA: FF FF      clb7  $FF
EAFC: FF FF      clb7  $FF
EAFE: FF FF      clb7  $FF
EB00: FF FF      clb7  $FF
EB02: FF FF      clb7  $FF
EB04: FF FF      clb7  $FF
EB06: FF FF      clb7  $FF
EB08: FF FF      clb7  $FF
EB0A: FF FF      clb7  $FF
EB0C: FF FF      clb7  $FF
EB0E: FF FF      clb7  $FF
EB10: FF FF      clb7  $FF
EB12: FF FF      clb7  $FF
EB14: FF FF      clb7  $FF
EB16: FF FF      clb7  $FF
EB18: FF FF      clb7  $FF
EB1A: FF FF      clb7  $FF
EB1C: FF FF      clb7  $FF
EB1E: FF FF      clb7  $FF
EB20: FF FF      clb7  $FF
EB22: FF FF      clb7  $FF
EB24: FF FF      clb7  $FF
EB26: FF FF      clb7  $FF
EB28: FF FF      clb7  $FF
EB2A: FF FF      clb7  $FF
EB2C: FF FF      clb7  $FF
EB2E: FF FF      clb7  $FF
EB30: FF FF      clb7  $FF
EB32: FF FF      clb7  $FF
EB34: FF FF      clb7  $FF
EB36: FF FF      clb7  $FF
EB38: FF FF      clb7  $FF
EB3A: FF FF      clb7  $FF
EB3C: FF FF      clb7  $FF
EB3E: FF FF      clb7  $FF
EB40: FF FF      clb7  $FF
EB42: FF FF      clb7  $FF
EB44: FF FF      clb7  $FF
EB46: FF FF      clb7  $FF
EB48: FF FF      clb7  $FF
EB4A: FF FF      clb7  $FF
EB4C: FF FF      clb7  $FF
EB4E: FF FF      clb7  $FF
EB50: FF FF      clb7  $FF
EB52: FF FF      clb7  $FF
EB54: FF FF      clb7  $FF
EB56: FF FF      clb7  $FF
EB58: FF FF      clb7  $FF
EB5A: FF FF      clb7  $FF
EB5C: FF FF      clb7  $FF
EB5E: FF FF      clb7  $FF
EB60: FF FF      clb7  $FF
EB62: FF FF      clb7  $FF
EB64: FF FF      clb7  $FF
EB66: FF FF      clb7  $FF
EB68: FF FF      clb7  $FF
EB6A: FF FF      clb7  $FF
EB6C: FF FF      clb7  $FF
EB6E: FF FF      clb7  $FF
EB70: FF FF      clb7  $FF
EB72: FF FF      clb7  $FF
EB74: FF FF      clb7  $FF
EB76: FF FF      clb7  $FF
EB78: FF FF      clb7  $FF
EB7A: FF FF      clb7  $FF
EB7C: FF FF      clb7  $FF
EB7E: FF FF      clb7  $FF
EB80: FF FF      clb7  $FF
EB82: FF FF      clb7  $FF
EB84: FF FF      clb7  $FF
EB86: FF FF      clb7  $FF
EB88: FF FF      clb7  $FF
EB8A: FF FF      clb7  $FF
EB8C: FF FF      clb7  $FF
EB8E: FF FF      clb7  $FF
EB90: FF FF      clb7  $FF
EB92: FF FF      clb7  $FF
EB94: FF FF      clb7  $FF
EB96: FF FF      clb7  $FF
EB98: FF FF      clb7  $FF
EB9A: FF FF      clb7  $FF
EB9C: FF FF      clb7  $FF
EB9E: FF FF      clb7  $FF
EBA0: FF FF      clb7  $FF
EBA2: FF FF      clb7  $FF
EBA4: FF FF      clb7  $FF
EBA6: FF FF      clb7  $FF
EBA8: FF FF      clb7  $FF
EBAA: FF FF      clb7  $FF
EBAC: FF FF      clb7  $FF
EBAE: FF FF      clb7  $FF
EBB0: FF FF      clb7  $FF
EBB2: FF FF      clb7  $FF
EBB4: FF FF      clb7  $FF
EBB6: FF FF      clb7  $FF
EBB8: FF FF      clb7  $FF
EBBA: FF FF      clb7  $FF
EBBC: FF FF      clb7  $FF
EBBE: FF FF      clb7  $FF
EBC0: FF FF      clb7  $FF
EBC2: FF FF      clb7  $FF
EBC4: FF FF      clb7  $FF
EBC6: FF FF      clb7  $FF
EBC8: FF FF      clb7  $FF
EBCA: FF FF      clb7  $FF
EBCC: FF FF      clb7  $FF
EBCE: FF FF      clb7  $FF
EBD0: FF FF      clb7  $FF
EBD2: FF FF      clb7  $FF
EBD4: FF FF      clb7  $FF
EBD6: FF FF      clb7  $FF
EBD8: FF FF      clb7  $FF
EBDA: FF FF      clb7  $FF
EBDC: FF FF      clb7  $FF
EBDE: FF FF      clb7  $FF
EBE0: FF FF      clb7  $FF
EBE2: FF FF      clb7  $FF
EBE4: FF FF      clb7  $FF
EBE6: FF FF      clb7  $FF
EBE8: FF FF      clb7  $FF
EBEA: FF FF      clb7  $FF
EBEC: FF FF      clb7  $FF
EBEE: FF FF      clb7  $FF
EBF0: FF FF      clb7  $FF
EBF2: FF FF      clb7  $FF
EBF4: FF FF      clb7  $FF
EBF6: FF FF      clb7  $FF
EBF8: FF FF      clb7  $FF
EBFA: FF FF      clb7  $FF
EBFC: FF FF      clb7  $FF
EBFE: FF FF      clb7  $FF
EC00: FF FF      clb7  $FF
EC02: FF FF      clb7  $FF
EC04: FF FF      clb7  $FF
EC06: FF FF      clb7  $FF
EC08: FF FF      clb7  $FF
EC0A: FF FF      clb7  $FF
EC0C: FF FF      clb7  $FF
EC0E: FF FF      clb7  $FF
EC10: FF FF      clb7  $FF
EC12: FF FF      clb7  $FF
EC14: FF FF      clb7  $FF
EC16: FF FF      clb7  $FF
EC18: FF FF      clb7  $FF
EC1A: FF FF      clb7  $FF
EC1C: FF FF      clb7  $FF
EC1E: FF FF      clb7  $FF
EC20: FF FF      clb7  $FF
EC22: FF FF      clb7  $FF
EC24: FF FF      clb7  $FF
EC26: FF FF      clb7  $FF
EC28: FF FF      clb7  $FF
EC2A: FF FF      clb7  $FF
EC2C: FF FF      clb7  $FF
EC2E: FF FF      clb7  $FF
EC30: FF FF      clb7  $FF
EC32: FF FF      clb7  $FF
EC34: FF FF      clb7  $FF
EC36: FF FF      clb7  $FF
EC38: FF FF      clb7  $FF
EC3A: FF FF      clb7  $FF
EC3C: FF FF      clb7  $FF
EC3E: FF FF      clb7  $FF
EC40: FF FF      clb7  $FF
EC42: FF FF      clb7  $FF
EC44: FF FF      clb7  $FF
EC46: FF FF      clb7  $FF
EC48: FF FF      clb7  $FF
EC4A: FF FF      clb7  $FF
EC4C: FF FF      clb7  $FF
EC4E: FF FF      clb7  $FF
EC50: FF FF      clb7  $FF
EC52: FF FF      clb7  $FF
EC54: FF FF      clb7  $FF
EC56: FF FF      clb7  $FF
EC58: FF FF      clb7  $FF
EC5A: FF FF      clb7  $FF
EC5C: FF FF      clb7  $FF
EC5E: FF FF      clb7  $FF
EC60: FF FF      clb7  $FF
EC62: FF FF      clb7  $FF
EC64: FF FF      clb7  $FF
EC66: FF FF      clb7  $FF
EC68: FF FF      clb7  $FF
EC6A: FF FF      clb7  $FF
EC6C: FF FF      clb7  $FF
EC6E: FF FF      clb7  $FF
EC70: FF FF      clb7  $FF
EC72: FF FF      clb7  $FF
EC74: FF FF      clb7  $FF
EC76: FF FF      clb7  $FF
EC78: FF FF      clb7  $FF
EC7A: FF FF      clb7  $FF
EC7C: FF FF      clb7  $FF
EC7E: FF FF      clb7  $FF
EC80: FF FF      clb7  $FF
EC82: FF FF      clb7  $FF
EC84: FF FF      clb7  $FF
EC86: FF FF      clb7  $FF
EC88: FF FF      clb7  $FF
EC8A: FF FF      clb7  $FF
EC8C: FF FF      clb7  $FF
EC8E: FF FF      clb7  $FF
EC90: FF FF      clb7  $FF
EC92: FF FF      clb7  $FF
EC94: FF FF      clb7  $FF
EC96: FF FF      clb7  $FF
EC98: FF FF      clb7  $FF
EC9A: FF FF      clb7  $FF
EC9C: FF FF      clb7  $FF
EC9E: FF FF      clb7  $FF
ECA0: FF FF      clb7  $FF
ECA2: FF FF      clb7  $FF
ECA4: FF FF      clb7  $FF
ECA6: FF FF      clb7  $FF
ECA8: FF FF      clb7  $FF
ECAA: FF FF      clb7  $FF
ECAC: FF FF      clb7  $FF
ECAE: FF FF      clb7  $FF
ECB0: FF FF      clb7  $FF
ECB2: FF FF      clb7  $FF
ECB4: FF FF      clb7  $FF
ECB6: FF FF      clb7  $FF
ECB8: FF FF      clb7  $FF
ECBA: FF FF      clb7  $FF
ECBC: FF FF      clb7  $FF
ECBE: FF FF      clb7  $FF
ECC0: FF FF      clb7  $FF
ECC2: FF FF      clb7  $FF
ECC4: FF FF      clb7  $FF
ECC6: FF FF      clb7  $FF
ECC8: FF FF      clb7  $FF
ECCA: FF FF      clb7  $FF
ECCC: FF FF      clb7  $FF
ECCE: FF FF      clb7  $FF
ECD0: FF FF      clb7  $FF
ECD2: FF FF      clb7  $FF
ECD4: FF FF      clb7  $FF
ECD6: FF FF      clb7  $FF
ECD8: FF FF      clb7  $FF
ECDA: FF FF      clb7  $FF
ECDC: FF FF      clb7  $FF
ECDE: FF FF      clb7  $FF
ECE0: FF FF      clb7  $FF
ECE2: FF FF      clb7  $FF
ECE4: FF FF      clb7  $FF
ECE6: FF FF      clb7  $FF
ECE8: FF FF      clb7  $FF
ECEA: FF FF      clb7  $FF
ECEC: FF FF      clb7  $FF
ECEE: FF FF      clb7  $FF
ECF0: FF FF      clb7  $FF
ECF2: FF FF      clb7  $FF
ECF4: FF FF      clb7  $FF
ECF6: FF FF      clb7  $FF
ECF8: FF FF      clb7  $FF
ECFA: FF FF      clb7  $FF
ECFC: FF FF      clb7  $FF
ECFE: FF FF      clb7  $FF
ED00: FF FF      clb7  $FF
ED02: FF FF      clb7  $FF
ED04: FF FF      clb7  $FF
ED06: FF FF      clb7  $FF
ED08: FF FF      clb7  $FF
ED0A: FF FF      clb7  $FF
ED0C: FF FF      clb7  $FF
ED0E: FF FF      clb7  $FF
ED10: FF FF      clb7  $FF
ED12: FF FF      clb7  $FF
ED14: FF FF      clb7  $FF
ED16: FF FF      clb7  $FF
ED18: FF FF      clb7  $FF
ED1A: FF FF      clb7  $FF
ED1C: FF FF      clb7  $FF
ED1E: FF FF      clb7  $FF
ED20: FF FF      clb7  $FF
ED22: FF FF      clb7  $FF
ED24: FF FF      clb7  $FF
ED26: FF FF      clb7  $FF
ED28: FF FF      clb7  $FF
ED2A: FF FF      clb7  $FF
ED2C: FF FF      clb7  $FF
ED2E: FF FF      clb7  $FF
ED30: FF FF      clb7  $FF
ED32: FF FF      clb7  $FF
ED34: FF FF      clb7  $FF
ED36: FF FF      clb7  $FF
ED38: FF FF      clb7  $FF
ED3A: FF FF      clb7  $FF
ED3C: FF FF      clb7  $FF
ED3E: FF FF      clb7  $FF
ED40: FF FF      clb7  $FF
ED42: FF FF      clb7  $FF
ED44: FF FF      clb7  $FF
ED46: FF FF      clb7  $FF
ED48: FF FF      clb7  $FF
ED4A: FF FF      clb7  $FF
ED4C: FF FF      clb7  $FF
ED4E: FF FF      clb7  $FF
ED50: FF FF      clb7  $FF
ED52: FF FF      clb7  $FF
ED54: FF FF      clb7  $FF
ED56: FF FF      clb7  $FF
ED58: FF FF      clb7  $FF
ED5A: FF FF      clb7  $FF
ED5C: FF FF      clb7  $FF
ED5E: FF FF      clb7  $FF
ED60: FF FF      clb7  $FF
ED62: FF FF      clb7  $FF
ED64: FF FF      clb7  $FF
ED66: FF FF      clb7  $FF
ED68: FF FF      clb7  $FF
ED6A: FF FF      clb7  $FF
ED6C: FF FF      clb7  $FF
ED6E: FF FF      clb7  $FF
ED70: FF FF      clb7  $FF
ED72: FF FF      clb7  $FF
ED74: FF FF      clb7  $FF
ED76: FF FF      clb7  $FF
ED78: FF FF      clb7  $FF
ED7A: FF FF      clb7  $FF
ED7C: FF FF      clb7  $FF
ED7E: FF FF      clb7  $FF
ED80: FF FF      clb7  $FF
ED82: FF FF      clb7  $FF
ED84: FF FF      clb7  $FF
ED86: FF FF      clb7  $FF
ED88: FF FF      clb7  $FF
ED8A: FF FF      clb7  $FF
ED8C: FF FF      clb7  $FF
ED8E: FF FF      clb7  $FF
ED90: FF FF      clb7  $FF
ED92: FF FF      clb7  $FF
ED94: FF FF      clb7  $FF
ED96: FF FF      clb7  $FF
ED98: FF FF      clb7  $FF
ED9A: FF FF      clb7  $FF
ED9C: FF FF      clb7  $FF
ED9E: FF FF      clb7  $FF
EDA0: FF FF      clb7  $FF
EDA2: FF FF      clb7  $FF
EDA4: FF FF      clb7  $FF
EDA6: FF FF      clb7  $FF
EDA8: FF FF      clb7  $FF
EDAA: FF FF      clb7  $FF
EDAC: FF FF      clb7  $FF
EDAE: FF FF      clb7  $FF
EDB0: FF FF      clb7  $FF
EDB2: FF FF      clb7  $FF
EDB4: FF FF      clb7  $FF
EDB6: FF FF      clb7  $FF
EDB8: FF FF      clb7  $FF
EDBA: FF FF      clb7  $FF
EDBC: FF FF      clb7  $FF
EDBE: FF FF      clb7  $FF
EDC0: FF FF      clb7  $FF
EDC2: FF FF      clb7  $FF
EDC4: FF FF      clb7  $FF
EDC6: FF FF      clb7  $FF
EDC8: FF FF      clb7  $FF
EDCA: FF FF      clb7  $FF
EDCC: FF FF      clb7  $FF
EDCE: FF FF      clb7  $FF
EDD0: FF FF      clb7  $FF
EDD2: FF FF      clb7  $FF
EDD4: FF FF      clb7  $FF
EDD6: FF FF      clb7  $FF
EDD8: FF FF      clb7  $FF
EDDA: FF FF      clb7  $FF
EDDC: FF FF      clb7  $FF
EDDE: FF FF      clb7  $FF
EDE0: FF FF      clb7  $FF
EDE2: FF FF      clb7  $FF
EDE4: FF FF      clb7  $FF
EDE6: FF FF      clb7  $FF
EDE8: FF FF      clb7  $FF
EDEA: FF FF      clb7  $FF
EDEC: FF FF      clb7  $FF
EDEE: FF FF      clb7  $FF
EDF0: FF FF      clb7  $FF
EDF2: FF FF      clb7  $FF
EDF4: FF FF      clb7  $FF
EDF6: FF FF      clb7  $FF
EDF8: FF FF      clb7  $FF
EDFA: FF FF      clb7  $FF
EDFC: FF FF      clb7  $FF
EDFE: FF FF      clb7  $FF
EE00: FF FF      clb7  $FF
EE02: FF FF      clb7  $FF
EE04: FF FF      clb7  $FF
EE06: FF FF      clb7  $FF
EE08: FF FF      clb7  $FF
EE0A: FF FF      clb7  $FF
EE0C: FF FF      clb7  $FF
EE0E: FF FF      clb7  $FF
EE10: FF FF      clb7  $FF
EE12: FF FF      clb7  $FF
EE14: FF FF      clb7  $FF
EE16: FF FF      clb7  $FF
EE18: FF FF      clb7  $FF
EE1A: FF FF      clb7  $FF
EE1C: FF FF      clb7  $FF
EE1E: FF FF      clb7  $FF
EE20: FF FF      clb7  $FF
EE22: FF FF      clb7  $FF
EE24: FF FF      clb7  $FF
EE26: FF FF      clb7  $FF
EE28: FF FF      clb7  $FF
EE2A: FF FF      clb7  $FF
EE2C: FF FF      clb7  $FF
EE2E: FF FF      clb7  $FF
EE30: FF FF      clb7  $FF
EE32: FF FF      clb7  $FF
EE34: FF FF      clb7  $FF
EE36: FF FF      clb7  $FF
EE38: FF FF      clb7  $FF
EE3A: FF FF      clb7  $FF
EE3C: FF FF      clb7  $FF
EE3E: FF FF      clb7  $FF
EE40: FF FF      clb7  $FF
EE42: FF FF      clb7  $FF
EE44: FF FF      clb7  $FF
EE46: FF FF      clb7  $FF
EE48: FF FF      clb7  $FF
EE4A: FF FF      clb7  $FF
EE4C: FF FF      clb7  $FF
EE4E: FF FF      clb7  $FF
EE50: FF FF      clb7  $FF
EE52: FF FF      clb7  $FF
EE54: FF FF      clb7  $FF
EE56: FF FF      clb7  $FF
EE58: FF FF      clb7  $FF
EE5A: FF FF      clb7  $FF
EE5C: FF FF      clb7  $FF
EE5E: FF FF      clb7  $FF
EE60: FF FF      clb7  $FF
EE62: FF FF      clb7  $FF
EE64: FF FF      clb7  $FF
EE66: FF FF      clb7  $FF
EE68: FF FF      clb7  $FF
EE6A: FF FF      clb7  $FF
EE6C: FF FF      clb7  $FF
EE6E: FF FF      clb7  $FF
EE70: FF FF      clb7  $FF
EE72: FF FF      clb7  $FF
EE74: FF FF      clb7  $FF
EE76: FF FF      clb7  $FF
EE78: FF FF      clb7  $FF
EE7A: FF FF      clb7  $FF
EE7C: FF FF      clb7  $FF
EE7E: FF FF      clb7  $FF
EE80: FF FF      clb7  $FF
EE82: FF FF      clb7  $FF
EE84: FF FF      clb7  $FF
EE86: FF FF      clb7  $FF
EE88: FF FF      clb7  $FF
EE8A: FF FF      clb7  $FF
EE8C: FF FF      clb7  $FF
EE8E: FF FF      clb7  $FF
EE90: FF FF      clb7  $FF
EE92: FF FF      clb7  $FF
EE94: FF FF      clb7  $FF
EE96: FF FF      clb7  $FF
EE98: FF FF      clb7  $FF
EE9A: FF FF      clb7  $FF
EE9C: FF FF      clb7  $FF
EE9E: FF FF      clb7  $FF
EEA0: FF FF      clb7  $FF
EEA2: FF FF      clb7  $FF
EEA4: FF FF      clb7  $FF
EEA6: FF FF      clb7  $FF
EEA8: FF FF      clb7  $FF
EEAA: FF FF      clb7  $FF
EEAC: FF FF      clb7  $FF
EEAE: FF FF      clb7  $FF
EEB0: FF FF      clb7  $FF
EEB2: FF FF      clb7  $FF
EEB4: FF FF      clb7  $FF
EEB6: FF FF      clb7  $FF
EEB8: FF FF      clb7  $FF
EEBA: FF FF      clb7  $FF
EEBC: FF FF      clb7  $FF
EEBE: FF FF      clb7  $FF
EEC0: FF FF      clb7  $FF
EEC2: FF FF      clb7  $FF
EEC4: FF FF      clb7  $FF
EEC6: FF FF      clb7  $FF
EEC8: FF FF      clb7  $FF
EECA: FF FF      clb7  $FF
EECC: FF FF      clb7  $FF
EECE: FF FF      clb7  $FF
EED0: FF FF      clb7  $FF
EED2: FF FF      clb7  $FF
EED4: FF FF      clb7  $FF
EED6: FF FF      clb7  $FF
EED8: FF FF      clb7  $FF
EEDA: FF FF      clb7  $FF
EEDC: FF FF      clb7  $FF
EEDE: FF FF      clb7  $FF
EEE0: FF FF      clb7  $FF
EEE2: FF FF      clb7  $FF
EEE4: FF FF      clb7  $FF
EEE6: FF FF      clb7  $FF
EEE8: FF FF      clb7  $FF
EEEA: FF FF      clb7  $FF
EEEC: FF FF      clb7  $FF
EEEE: FF FF      clb7  $FF
EEF0: FF FF      clb7  $FF
EEF2: FF FF      clb7  $FF
EEF4: FF FF      clb7  $FF
EEF6: FF FF      clb7  $FF
EEF8: FF FF      clb7  $FF
EEFA: FF FF      clb7  $FF
EEFC: FF FF      clb7  $FF
EEFE: FF FF      clb7  $FF
EF00: FF FF      clb7  $FF
EF02: FF FF      clb7  $FF
EF04: FF FF      clb7  $FF
EF06: FF FF      clb7  $FF
EF08: FF FF      clb7  $FF
EF0A: FF FF      clb7  $FF
EF0C: FF FF      clb7  $FF
EF0E: FF FF      clb7  $FF
EF10: FF FF      clb7  $FF
EF12: FF FF      clb7  $FF
EF14: FF FF      clb7  $FF
EF16: FF FF      clb7  $FF
EF18: FF FF      clb7  $FF
EF1A: FF FF      clb7  $FF
EF1C: FF FF      clb7  $FF
EF1E: FF FF      clb7  $FF
EF20: FF FF      clb7  $FF
EF22: FF FF      clb7  $FF
EF24: FF FF      clb7  $FF
EF26: FF FF      clb7  $FF
EF28: FF FF      clb7  $FF
EF2A: FF FF      clb7  $FF
EF2C: FF FF      clb7  $FF
EF2E: FF FF      clb7  $FF
EF30: FF FF      clb7  $FF
EF32: FF FF      clb7  $FF
EF34: FF FF      clb7  $FF
EF36: FF FF      clb7  $FF
EF38: FF FF      clb7  $FF
EF3A: FF FF      clb7  $FF
EF3C: FF FF      clb7  $FF
EF3E: FF FF      clb7  $FF
EF40: FF FF      clb7  $FF
EF42: FF FF      clb7  $FF
EF44: FF FF      clb7  $FF
EF46: FF FF      clb7  $FF
EF48: FF FF      clb7  $FF
EF4A: FF FF      clb7  $FF
EF4C: FF FF      clb7  $FF
EF4E: FF FF      clb7  $FF
EF50: FF FF      clb7  $FF
EF52: FF FF      clb7  $FF
EF54: FF FF      clb7  $FF
EF56: FF FF      clb7  $FF
EF58: FF FF      clb7  $FF
EF5A: FF FF      clb7  $FF
EF5C: FF FF      clb7  $FF
EF5E: FF FF      clb7  $FF
EF60: FF FF      clb7  $FF
EF62: FF FF      clb7  $FF
EF64: FF FF      clb7  $FF
EF66: FF FF      clb7  $FF
EF68: FF FF      clb7  $FF
EF6A: FF FF      clb7  $FF
EF6C: FF FF      clb7  $FF
EF6E: FF FF      clb7  $FF
EF70: FF FF      clb7  $FF
EF72: FF FF      clb7  $FF
EF74: FF FF      clb7  $FF
EF76: FF FF      clb7  $FF
EF78: FF FF      clb7  $FF
EF7A: FF FF      clb7  $FF
EF7C: FF FF      clb7  $FF
EF7E: FF FF      clb7  $FF
EF80: FF FF      clb7  $FF
EF82: FF FF      clb7  $FF
EF84: FF FF      clb7  $FF
EF86: FF FF      clb7  $FF
EF88: FF FF      clb7  $FF
EF8A: FF FF      clb7  $FF
EF8C: FF FF      clb7  $FF
EF8E: FF FF      clb7  $FF
EF90: FF FF      clb7  $FF
EF92: FF FF      clb7  $FF
EF94: FF FF      clb7  $FF
EF96: FF FF      clb7  $FF
EF98: FF FF      clb7  $FF
EF9A: FF FF      clb7  $FF
EF9C: FF FF      clb7  $FF
EF9E: FF FF      clb7  $FF
EFA0: FF FF      clb7  $FF
EFA2: FF FF      clb7  $FF
EFA4: FF FF      clb7  $FF
EFA6: FF FF      clb7  $FF
EFA8: FF FF      clb7  $FF
EFAA: FF FF      clb7  $FF
EFAC: FF FF      clb7  $FF
EFAE: FF FF      clb7  $FF
EFB0: FF FF      clb7  $FF
EFB2: FF FF      clb7  $FF
EFB4: FF FF      clb7  $FF
EFB6: FF FF      clb7  $FF
EFB8: FF FF      clb7  $FF
EFBA: FF FF      clb7  $FF
EFBC: FF FF      clb7  $FF
EFBE: FF FF      clb7  $FF
EFC0: FF FF      clb7  $FF
EFC2: FF FF      clb7  $FF
EFC4: FF FF      clb7  $FF
EFC6: FF FF      clb7  $FF
EFC8: FF FF      clb7  $FF
EFCA: FF FF      clb7  $FF
EFCC: FF FF      clb7  $FF
EFCE: FF FF      clb7  $FF
EFD0: FF FF      clb7  $FF
EFD2: FF FF      clb7  $FF
EFD4: FF FF      clb7  $FF
EFD6: FF FF      clb7  $FF
EFD8: FF FF      clb7  $FF
EFDA: FF FF      clb7  $FF
EFDC: FF FF      clb7  $FF
EFDE: FF FF      clb7  $FF
EFE0: FF FF      clb7  $FF
EFE2: FF FF      clb7  $FF
EFE4: FF FF      clb7  $FF
EFE6: FF FF      clb7  $FF
EFE8: FF FF      clb7  $FF
EFEA: FF FF      clb7  $FF
EFEC: FF FF      clb7  $FF
EFEE: FF FF      clb7  $FF
EFF0: FF FF      clb7  $FF
EFF2: FF FF      clb7  $FF
EFF4: FF FF      clb7  $FF
EFF6: FF FF      clb7  $FF
EFF8: FF FF      clb7  $FF
EFFA: FF FF      clb7  $FF
EFFC: FF FF      clb7  $FF
EFFE: FF FF      clb7  $FF
F000: FF FF      clb7  $FF
F002: FF FF      clb7  $FF
F004: FF FF      clb7  $FF
F006: FF FF      clb7  $FF
F008: FF FF      clb7  $FF
F00A: FF FF      clb7  $FF
F00C: FF FF      clb7  $FF
F00E: FF FF      clb7  $FF
F010: FF FF      clb7  $FF
F012: FF FF      clb7  $FF
F014: FF FF      clb7  $FF
F016: FF FF      clb7  $FF
F018: FF FF      clb7  $FF
F01A: FF FF      clb7  $FF
F01C: FF FF      clb7  $FF
F01E: FF FF      clb7  $FF
F020: FF FF      clb7  $FF
F022: FF FF      clb7  $FF
F024: FF FF      clb7  $FF
F026: FF FF      clb7  $FF
F028: FF FF      clb7  $FF
F02A: FF FF      clb7  $FF
F02C: FF FF      clb7  $FF
F02E: FF FF      clb7  $FF
F030: FF FF      clb7  $FF
F032: FF FF      clb7  $FF
F034: FF FF      clb7  $FF
F036: FF FF      clb7  $FF
F038: FF FF      clb7  $FF
F03A: FF FF      clb7  $FF
F03C: FF FF      clb7  $FF
F03E: FF FF      clb7  $FF
F040: FF FF      clb7  $FF
F042: FF FF      clb7  $FF
F044: FF FF      clb7  $FF
F046: FF FF      clb7  $FF
F048: FF FF      clb7  $FF
F04A: FF FF      clb7  $FF
F04C: FF FF      clb7  $FF
F04E: FF FF      clb7  $FF
F050: FF FF      clb7  $FF
F052: FF FF      clb7  $FF
F054: FF FF      clb7  $FF
F056: FF FF      clb7  $FF
F058: FF FF      clb7  $FF
F05A: FF FF      clb7  $FF
F05C: FF FF      clb7  $FF
F05E: FF FF      clb7  $FF
F060: FF FF      clb7  $FF
F062: FF FF      clb7  $FF
F064: FF FF      clb7  $FF
F066: FF FF      clb7  $FF
F068: FF FF      clb7  $FF
F06A: FF FF      clb7  $FF
F06C: FF FF      clb7  $FF
F06E: FF FF      clb7  $FF
F070: FF FF      clb7  $FF
F072: FF FF      clb7  $FF
F074: FF FF      clb7  $FF
F076: FF FF      clb7  $FF
F078: FF FF      clb7  $FF
F07A: FF FF      clb7  $FF
F07C: FF FF      clb7  $FF
F07E: FF FF      clb7  $FF
F080: FF FF      clb7  $FF
F082: FF FF      clb7  $FF
F084: FF FF      clb7  $FF
F086: FF FF      clb7  $FF
F088: FF FF      clb7  $FF
F08A: FF FF      clb7  $FF
F08C: FF FF      clb7  $FF
F08E: FF FF      clb7  $FF
F090: FF FF      clb7  $FF
F092: FF FF      clb7  $FF
F094: FF FF      clb7  $FF
F096: FF FF      clb7  $FF
F098: FF FF      clb7  $FF
F09A: FF FF      clb7  $FF
F09C: FF FF      clb7  $FF
F09E: FF FF      clb7  $FF
F0A0: FF FF      clb7  $FF
F0A2: FF FF      clb7  $FF
F0A4: FF FF      clb7  $FF
F0A6: FF FF      clb7  $FF
F0A8: FF FF      clb7  $FF
F0AA: FF FF      clb7  $FF
F0AC: FF FF      clb7  $FF
F0AE: FF FF      clb7  $FF
F0B0: FF FF      clb7  $FF
F0B2: FF FF      clb7  $FF
F0B4: FF FF      clb7  $FF
F0B6: FF FF      clb7  $FF
F0B8: FF FF      clb7  $FF
F0BA: FF FF      clb7  $FF
F0BC: FF FF      clb7  $FF
F0BE: FF FF      clb7  $FF
F0C0: FF FF      clb7  $FF
F0C2: FF FF      clb7  $FF
F0C4: FF FF      clb7  $FF
F0C6: FF FF      clb7  $FF
F0C8: FF FF      clb7  $FF
F0CA: FF FF      clb7  $FF
F0CC: FF FF      clb7  $FF
F0CE: FF FF      clb7  $FF
F0D0: FF FF      clb7  $FF
F0D2: FF FF      clb7  $FF
F0D4: FF FF      clb7  $FF
F0D6: FF FF      clb7  $FF
F0D8: FF FF      clb7  $FF
F0DA: FF FF      clb7  $FF
F0DC: FF FF      clb7  $FF
F0DE: FF FF      clb7  $FF
F0E0: FF FF      clb7  $FF
F0E2: FF FF      clb7  $FF
F0E4: FF FF      clb7  $FF
F0E6: FF FF      clb7  $FF
F0E8: FF FF      clb7  $FF
F0EA: FF FF      clb7  $FF
F0EC: FF FF      clb7  $FF
F0EE: FF FF      clb7  $FF
F0F0: FF FF      clb7  $FF
F0F2: FF FF      clb7  $FF
F0F4: FF FF      clb7  $FF
F0F6: FF FF      clb7  $FF
F0F8: FF FF      clb7  $FF
F0FA: FF FF      clb7  $FF
F0FC: FF FF      clb7  $FF
F0FE: FF FF      clb7  $FF
F100: FF FF      clb7  $FF
F102: FF FF      clb7  $FF
F104: FF FF      clb7  $FF
F106: FF FF      clb7  $FF
F108: FF FF      clb7  $FF
F10A: FF FF      clb7  $FF
F10C: FF FF      clb7  $FF
F10E: FF FF      clb7  $FF
F110: FF FF      clb7  $FF
F112: FF FF      clb7  $FF
F114: FF FF      clb7  $FF
F116: FF FF      clb7  $FF
F118: FF FF      clb7  $FF
F11A: FF FF      clb7  $FF
F11C: FF FF      clb7  $FF
F11E: FF FF      clb7  $FF
F120: FF FF      clb7  $FF
F122: FF FF      clb7  $FF
F124: FF FF      clb7  $FF
F126: FF FF      clb7  $FF
F128: FF FF      clb7  $FF
F12A: FF FF      clb7  $FF
F12C: FF FF      clb7  $FF
F12E: FF FF      clb7  $FF
F130: FF FF      clb7  $FF
F132: FF FF      clb7  $FF
F134: FF FF      clb7  $FF
F136: FF FF      clb7  $FF
F138: FF FF      clb7  $FF
F13A: FF FF      clb7  $FF
F13C: FF FF      clb7  $FF
F13E: FF FF      clb7  $FF
F140: FF FF      clb7  $FF
F142: FF FF      clb7  $FF
F144: FF FF      clb7  $FF
F146: FF FF      clb7  $FF
F148: FF FF      clb7  $FF
F14A: FF FF      clb7  $FF
F14C: FF FF      clb7  $FF
F14E: FF FF      clb7  $FF
F150: FF FF      clb7  $FF
F152: FF FF      clb7  $FF
F154: FF FF      clb7  $FF
F156: FF FF      clb7  $FF
F158: FF FF      clb7  $FF
F15A: FF FF      clb7  $FF
F15C: FF FF      clb7  $FF
F15E: FF FF      clb7  $FF
F160: FF FF      clb7  $FF
F162: FF FF      clb7  $FF
F164: FF FF      clb7  $FF
F166: FF FF      clb7  $FF
F168: FF FF      clb7  $FF
F16A: FF FF      clb7  $FF
F16C: FF FF      clb7  $FF
F16E: FF FF      clb7  $FF
F170: FF FF      clb7  $FF
F172: FF FF      clb7  $FF
F174: FF FF      clb7  $FF
F176: FF FF      clb7  $FF
F178: FF FF      clb7  $FF
F17A: FF FF      clb7  $FF
F17C: FF FF      clb7  $FF
F17E: FF FF      clb7  $FF
F180: FF FF      clb7  $FF
F182: FF FF      clb7  $FF
F184: FF FF      clb7  $FF
F186: FF FF      clb7  $FF
F188: FF FF      clb7  $FF
F18A: FF FF      clb7  $FF
F18C: FF FF      clb7  $FF
F18E: FF FF      clb7  $FF
F190: FF FF      clb7  $FF
F192: FF FF      clb7  $FF
F194: FF FF      clb7  $FF
F196: FF FF      clb7  $FF
F198: FF FF      clb7  $FF
F19A: FF FF      clb7  $FF
F19C: FF FF      clb7  $FF
F19E: FF FF      clb7  $FF
F1A0: FF FF      clb7  $FF
F1A2: FF FF      clb7  $FF
F1A4: FF FF      clb7  $FF
F1A6: FF FF      clb7  $FF
F1A8: FF FF      clb7  $FF
F1AA: FF FF      clb7  $FF
F1AC: FF FF      clb7  $FF
F1AE: FF FF      clb7  $FF
F1B0: FF FF      clb7  $FF
F1B2: FF FF      clb7  $FF
F1B4: FF FF      clb7  $FF
F1B6: FF FF      clb7  $FF
F1B8: FF FF      clb7  $FF
F1BA: FF FF      clb7  $FF
F1BC: FF FF      clb7  $FF
F1BE: FF FF      clb7  $FF
F1C0: FF FF      clb7  $FF
F1C2: FF FF      clb7  $FF
F1C4: FF FF      clb7  $FF
F1C6: FF FF      clb7  $FF
F1C8: FF FF      clb7  $FF
F1CA: FF FF      clb7  $FF
F1CC: FF FF      clb7  $FF
F1CE: FF FF      clb7  $FF
F1D0: FF FF      clb7  $FF
F1D2: FF FF      clb7  $FF
F1D4: FF FF      clb7  $FF
F1D6: FF FF      clb7  $FF
F1D8: FF FF      clb7  $FF
F1DA: FF FF      clb7  $FF
F1DC: FF FF      clb7  $FF
F1DE: FF FF      clb7  $FF
F1E0: FF FF      clb7  $FF
F1E2: FF FF      clb7  $FF
F1E4: FF FF      clb7  $FF
F1E6: FF FF      clb7  $FF
F1E8: FF FF      clb7  $FF
F1EA: FF FF      clb7  $FF
F1EC: FF FF      clb7  $FF
F1EE: FF FF      clb7  $FF
F1F0: FF FF      clb7  $FF
F1F2: FF FF      clb7  $FF
F1F4: FF FF      clb7  $FF
F1F6: FF FF      clb7  $FF
F1F8: FF FF      clb7  $FF
F1FA: FF FF      clb7  $FF
F1FC: FF FF      clb7  $FF
F1FE: FF FF      clb7  $FF
F200: FF FF      clb7  $FF
F202: FF FF      clb7  $FF
F204: FF FF      clb7  $FF
F206: FF FF      clb7  $FF
F208: FF FF      clb7  $FF
F20A: FF FF      clb7  $FF
F20C: FF FF      clb7  $FF
F20E: FF FF      clb7  $FF
F210: FF FF      clb7  $FF
F212: FF FF      clb7  $FF
F214: FF FF      clb7  $FF
F216: FF FF      clb7  $FF
F218: FF FF      clb7  $FF
F21A: FF FF      clb7  $FF
F21C: FF FF      clb7  $FF
F21E: FF FF      clb7  $FF
F220: FF FF      clb7  $FF
F222: FF FF      clb7  $FF
F224: FF FF      clb7  $FF
F226: FF FF      clb7  $FF
F228: FF FF      clb7  $FF
F22A: FF FF      clb7  $FF
F22C: FF FF      clb7  $FF
F22E: FF FF      clb7  $FF
F230: FF FF      clb7  $FF
F232: FF FF      clb7  $FF
F234: FF FF      clb7  $FF
F236: FF FF      clb7  $FF
F238: FF FF      clb7  $FF
F23A: FF FF      clb7  $FF
F23C: FF FF      clb7  $FF
F23E: FF FF      clb7  $FF
F240: FF FF      clb7  $FF
F242: FF FF      clb7  $FF
F244: FF FF      clb7  $FF
F246: FF FF      clb7  $FF
F248: FF FF      clb7  $FF
F24A: FF FF      clb7  $FF
F24C: FF FF      clb7  $FF
F24E: FF FF      clb7  $FF
F250: FF FF      clb7  $FF
F252: FF FF      clb7  $FF
F254: FF FF      clb7  $FF
F256: FF FF      clb7  $FF
F258: FF FF      clb7  $FF
F25A: FF FF      clb7  $FF
F25C: FF FF      clb7  $FF
F25E: FF FF      clb7  $FF
F260: FF FF      clb7  $FF
F262: FF FF      clb7  $FF
F264: FF FF      clb7  $FF
F266: FF FF      clb7  $FF
F268: FF FF      clb7  $FF
F26A: FF FF      clb7  $FF
F26C: FF FF      clb7  $FF
F26E: FF FF      clb7  $FF
F270: FF FF      clb7  $FF
F272: FF FF      clb7  $FF
F274: FF FF      clb7  $FF
F276: FF FF      clb7  $FF
F278: FF FF      clb7  $FF
F27A: FF FF      clb7  $FF
F27C: FF FF      clb7  $FF
F27E: FF FF      clb7  $FF
F280: FF FF      clb7  $FF
F282: FF FF      clb7  $FF
F284: FF FF      clb7  $FF
F286: FF FF      clb7  $FF
F288: FF FF      clb7  $FF
F28A: FF FF      clb7  $FF
F28C: FF FF      clb7  $FF
F28E: FF FF      clb7  $FF
F290: FF FF      clb7  $FF
F292: FF FF      clb7  $FF
F294: FF FF      clb7  $FF
F296: FF FF      clb7  $FF
F298: FF FF      clb7  $FF
F29A: FF FF      clb7  $FF
F29C: FF FF      clb7  $FF
F29E: FF FF      clb7  $FF
F2A0: FF FF      clb7  $FF
F2A2: FF FF      clb7  $FF
F2A4: FF FF      clb7  $FF
F2A6: FF FF      clb7  $FF
F2A8: FF FF      clb7  $FF
F2AA: FF FF      clb7  $FF
F2AC: FF FF      clb7  $FF
F2AE: FF FF      clb7  $FF
F2B0: FF FF      clb7  $FF
F2B2: FF FF      clb7  $FF
F2B4: FF FF      clb7  $FF
F2B6: FF FF      clb7  $FF
F2B8: FF FF      clb7  $FF
F2BA: FF FF      clb7  $FF
F2BC: FF FF      clb7  $FF
F2BE: FF FF      clb7  $FF
F2C0: FF FF      clb7  $FF
F2C2: FF FF      clb7  $FF
F2C4: FF FF      clb7  $FF
F2C6: FF FF      clb7  $FF
F2C8: FF FF      clb7  $FF
F2CA: FF FF      clb7  $FF
F2CC: FF FF      clb7  $FF
F2CE: FF FF      clb7  $FF
F2D0: FF FF      clb7  $FF
F2D2: FF FF      clb7  $FF
F2D4: FF FF      clb7  $FF
F2D6: FF FF      clb7  $FF
F2D8: FF FF      clb7  $FF
F2DA: FF FF      clb7  $FF
F2DC: FF FF      clb7  $FF
F2DE: FF FF      clb7  $FF
F2E0: FF FF      clb7  $FF
F2E2: FF FF      clb7  $FF
F2E4: FF FF      clb7  $FF
F2E6: FF FF      clb7  $FF
F2E8: FF FF      clb7  $FF
F2EA: FF FF      clb7  $FF
F2EC: FF FF      clb7  $FF
F2EE: FF FF      clb7  $FF
F2F0: FF FF      clb7  $FF
F2F2: FF FF      clb7  $FF
F2F4: FF FF      clb7  $FF
F2F6: FF FF      clb7  $FF
F2F8: FF FF      clb7  $FF
F2FA: FF FF      clb7  $FF
F2FC: FF FF      clb7  $FF
F2FE: FF FF      clb7  $FF
F300: FF FF      clb7  $FF
F302: FF FF      clb7  $FF
F304: FF FF      clb7  $FF
F306: FF FF      clb7  $FF
F308: FF FF      clb7  $FF
F30A: FF FF      clb7  $FF
F30C: FF FF      clb7  $FF
F30E: FF FF      clb7  $FF
F310: FF FF      clb7  $FF
F312: FF FF      clb7  $FF
F314: FF FF      clb7  $FF
F316: FF FF      clb7  $FF
F318: FF FF      clb7  $FF
F31A: FF FF      clb7  $FF
F31C: FF FF      clb7  $FF
F31E: FF FF      clb7  $FF
F320: FF FF      clb7  $FF
F322: FF FF      clb7  $FF
F324: FF FF      clb7  $FF
F326: FF FF      clb7  $FF
F328: FF FF      clb7  $FF
F32A: FF FF      clb7  $FF
F32C: FF FF      clb7  $FF
F32E: FF FF      clb7  $FF
F330: FF FF      clb7  $FF
F332: FF FF      clb7  $FF
F334: FF FF      clb7  $FF
F336: FF FF      clb7  $FF
F338: FF FF      clb7  $FF
F33A: FF FF      clb7  $FF
F33C: FF FF      clb7  $FF
F33E: FF FF      clb7  $FF
F340: FF FF      clb7  $FF
F342: FF FF      clb7  $FF
F344: FF FF      clb7  $FF
F346: FF FF      clb7  $FF
F348: FF FF      clb7  $FF
F34A: FF FF      clb7  $FF
F34C: FF FF      clb7  $FF
F34E: FF FF      clb7  $FF
F350: FF FF      clb7  $FF
F352: FF FF      clb7  $FF
F354: FF FF      clb7  $FF
F356: FF FF      clb7  $FF
F358: FF FF      clb7  $FF
F35A: FF FF      clb7  $FF
F35C: FF FF      clb7  $FF
F35E: FF FF      clb7  $FF
F360: FF FF      clb7  $FF
F362: FF FF      clb7  $FF
F364: FF FF      clb7  $FF
F366: FF FF      clb7  $FF
F368: FF FF      clb7  $FF
F36A: FF FF      clb7  $FF
F36C: FF FF      clb7  $FF
F36E: FF FF      clb7  $FF
F370: FF FF      clb7  $FF
F372: FF FF      clb7  $FF
F374: FF FF      clb7  $FF
F376: FF FF      clb7  $FF
F378: FF FF      clb7  $FF
F37A: FF FF      clb7  $FF
F37C: FF FF      clb7  $FF
F37E: FF FF      clb7  $FF
F380: FF FF      clb7  $FF
F382: FF FF      clb7  $FF
F384: FF FF      clb7  $FF
F386: FF FF      clb7  $FF
F388: FF FF      clb7  $FF
F38A: FF FF      clb7  $FF
F38C: FF FF      clb7  $FF
F38E: FF FF      clb7  $FF
F390: FF FF      clb7  $FF
F392: FF FF      clb7  $FF
F394: FF FF      clb7  $FF
F396: FF FF      clb7  $FF
F398: FF FF      clb7  $FF
F39A: FF FF      clb7  $FF
F39C: FF FF      clb7  $FF
F39E: FF FF      clb7  $FF
F3A0: FF FF      clb7  $FF
F3A2: FF FF      clb7  $FF
F3A4: FF FF      clb7  $FF
F3A6: FF FF      clb7  $FF
F3A8: FF FF      clb7  $FF
F3AA: FF FF      clb7  $FF
F3AC: FF FF      clb7  $FF
F3AE: FF FF      clb7  $FF
F3B0: FF FF      clb7  $FF
F3B2: FF FF      clb7  $FF
F3B4: FF FF      clb7  $FF
F3B6: FF FF      clb7  $FF
F3B8: FF FF      clb7  $FF
F3BA: FF FF      clb7  $FF
F3BC: FF FF      clb7  $FF
F3BE: FF FF      clb7  $FF
F3C0: FF FF      clb7  $FF
F3C2: FF FF      clb7  $FF
F3C4: FF FF      clb7  $FF
F3C6: FF FF      clb7  $FF
F3C8: FF FF      clb7  $FF
F3CA: FF FF      clb7  $FF
F3CC: FF FF      clb7  $FF
F3CE: FF FF      clb7  $FF
F3D0: FF FF      clb7  $FF
F3D2: FF FF      clb7  $FF
F3D4: FF FF      clb7  $FF
F3D6: FF FF      clb7  $FF
F3D8: FF FF      clb7  $FF
F3DA: FF FF      clb7  $FF
F3DC: FF FF      clb7  $FF
F3DE: FF FF      clb7  $FF
F3E0: FF FF      clb7  $FF
F3E2: FF FF      clb7  $FF
F3E4: FF FF      clb7  $FF
F3E6: FF FF      clb7  $FF
F3E8: FF FF      clb7  $FF
F3EA: FF FF      clb7  $FF
F3EC: FF FF      clb7  $FF
F3EE: FF FF      clb7  $FF
F3F0: FF FF      clb7  $FF
F3F2: FF FF      clb7  $FF
F3F4: FF FF      clb7  $FF
F3F6: FF FF      clb7  $FF
F3F8: FF FF      clb7  $FF
F3FA: FF FF      clb7  $FF
F3FC: FF FF      clb7  $FF
F3FE: FF FF      clb7  $FF
F400: FF FF      clb7  $FF
F402: FF FF      clb7  $FF
F404: FF FF      clb7  $FF
F406: FF FF      clb7  $FF
F408: FF FF      clb7  $FF
F40A: FF FF      clb7  $FF
F40C: FF FF      clb7  $FF
F40E: FF FF      clb7  $FF
F410: FF FF      clb7  $FF
F412: FF FF      clb7  $FF
F414: FF FF      clb7  $FF
F416: FF FF      clb7  $FF
F418: FF FF      clb7  $FF
F41A: FF FF      clb7  $FF
F41C: FF FF      clb7  $FF
F41E: FF FF      clb7  $FF
F420: FF FF      clb7  $FF
F422: FF FF      clb7  $FF
F424: FF FF      clb7  $FF
F426: FF FF      clb7  $FF
F428: FF FF      clb7  $FF
F42A: FF FF      clb7  $FF
F42C: FF FF      clb7  $FF
F42E: FF FF      clb7  $FF
F430: FF FF      clb7  $FF
F432: FF FF      clb7  $FF
F434: FF FF      clb7  $FF
F436: FF FF      clb7  $FF
F438: FF FF      clb7  $FF
F43A: FF FF      clb7  $FF
F43C: FF FF      clb7  $FF
F43E: FF FF      clb7  $FF
F440: FF FF      clb7  $FF
F442: FF FF      clb7  $FF
F444: FF FF      clb7  $FF
F446: FF FF      clb7  $FF
F448: FF FF      clb7  $FF
F44A: FF FF      clb7  $FF
F44C: FF FF      clb7  $FF
F44E: FF FF      clb7  $FF
F450: FF FF      clb7  $FF
F452: FF FF      clb7  $FF
F454: FF FF      clb7  $FF
F456: FF FF      clb7  $FF
F458: FF FF      clb7  $FF
F45A: FF FF      clb7  $FF
F45C: FF FF      clb7  $FF
F45E: FF FF      clb7  $FF
F460: FF FF      clb7  $FF
F462: FF FF      clb7  $FF
F464: FF FF      clb7  $FF
F466: FF FF      clb7  $FF
F468: FF FF      clb7  $FF
F46A: FF FF      clb7  $FF
F46C: FF FF      clb7  $FF
F46E: FF FF      clb7  $FF
F470: FF FF      clb7  $FF
F472: FF FF      clb7  $FF
F474: FF FF      clb7  $FF
F476: FF FF      clb7  $FF
F478: FF FF      clb7  $FF
F47A: FF FF      clb7  $FF
F47C: FF FF      clb7  $FF
F47E: FF FF      clb7  $FF
F480: FF FF      clb7  $FF
F482: FF FF      clb7  $FF
F484: FF FF      clb7  $FF
F486: FF FF      clb7  $FF
F488: FF FF      clb7  $FF
F48A: FF FF      clb7  $FF
F48C: FF FF      clb7  $FF
F48E: FF FF      clb7  $FF
F490: FF FF      clb7  $FF
F492: FF FF      clb7  $FF
F494: FF FF      clb7  $FF
F496: FF FF      clb7  $FF
F498: FF FF      clb7  $FF
F49A: FF FF      clb7  $FF
F49C: FF FF      clb7  $FF
F49E: FF FF      clb7  $FF
F4A0: FF FF      clb7  $FF
F4A2: FF FF      clb7  $FF
F4A4: FF FF      clb7  $FF
F4A6: FF FF      clb7  $FF
F4A8: FF FF      clb7  $FF
F4AA: FF FF      clb7  $FF
F4AC: FF FF      clb7  $FF
F4AE: FF FF      clb7  $FF
F4B0: FF FF      clb7  $FF
F4B2: FF FF      clb7  $FF
F4B4: FF FF      clb7  $FF
F4B6: FF FF      clb7  $FF
F4B8: FF FF      clb7  $FF
F4BA: FF FF      clb7  $FF
F4BC: FF FF      clb7  $FF
F4BE: FF FF      clb7  $FF
F4C0: FF FF      clb7  $FF
F4C2: FF FF      clb7  $FF
F4C4: FF FF      clb7  $FF
F4C6: FF FF      clb7  $FF
F4C8: FF FF      clb7  $FF
F4CA: FF FF      clb7  $FF
F4CC: FF FF      clb7  $FF
F4CE: FF FF      clb7  $FF
F4D0: FF FF      clb7  $FF
F4D2: FF FF      clb7  $FF
F4D4: FF FF      clb7  $FF
F4D6: FF FF      clb7  $FF
F4D8: FF FF      clb7  $FF
F4DA: FF FF      clb7  $FF
F4DC: FF FF      clb7  $FF
F4DE: FF FF      clb7  $FF
F4E0: FF FF      clb7  $FF
F4E2: FF FF      clb7  $FF
F4E4: FF FF      clb7  $FF
F4E6: FF FF      clb7  $FF
F4E8: FF FF      clb7  $FF
F4EA: FF FF      clb7  $FF
F4EC: FF FF      clb7  $FF
F4EE: FF FF      clb7  $FF
F4F0: FF FF      clb7  $FF
F4F2: FF FF      clb7  $FF
F4F4: FF FF      clb7  $FF
F4F6: FF FF      clb7  $FF
F4F8: FF FF      clb7  $FF
F4FA: FF FF      clb7  $FF
F4FC: FF FF      clb7  $FF
F4FE: FF FF      clb7  $FF
F500: FF FF      clb7  $FF
F502: FF FF      clb7  $FF
F504: FF FF      clb7  $FF
F506: FF FF      clb7  $FF
F508: FF FF      clb7  $FF
F50A: FF FF      clb7  $FF
F50C: FF FF      clb7  $FF
F50E: FF FF      clb7  $FF
F510: FF FF      clb7  $FF
F512: FF FF      clb7  $FF
F514: FF FF      clb7  $FF
F516: FF FF      clb7  $FF
F518: FF FF      clb7  $FF
F51A: FF FF      clb7  $FF
F51C: FF FF      clb7  $FF
F51E: FF FF      clb7  $FF
F520: FF FF      clb7  $FF
F522: FF FF      clb7  $FF
F524: FF FF      clb7  $FF
F526: FF FF      clb7  $FF
F528: FF FF      clb7  $FF
F52A: FF FF      clb7  $FF
F52C: FF FF      clb7  $FF
F52E: FF FF      clb7  $FF
F530: FF FF      clb7  $FF
F532: FF FF      clb7  $FF
F534: FF FF      clb7  $FF
F536: FF FF      clb7  $FF
F538: FF FF      clb7  $FF
F53A: FF FF      clb7  $FF
F53C: FF FF      clb7  $FF
F53E: FF FF      clb7  $FF
F540: FF FF      clb7  $FF
F542: FF FF      clb7  $FF
F544: FF FF      clb7  $FF
F546: FF FF      clb7  $FF
F548: FF FF      clb7  $FF
F54A: FF FF      clb7  $FF
F54C: FF FF      clb7  $FF
F54E: FF FF      clb7  $FF
F550: FF FF      clb7  $FF
F552: FF FF      clb7  $FF
F554: FF FF      clb7  $FF
F556: FF FF      clb7  $FF
F558: FF FF      clb7  $FF
F55A: FF FF      clb7  $FF
F55C: FF FF      clb7  $FF
F55E: FF FF      clb7  $FF
F560: FF FF      clb7  $FF
F562: FF FF      clb7  $FF
F564: FF FF      clb7  $FF
F566: FF FF      clb7  $FF
F568: FF FF      clb7  $FF
F56A: FF FF      clb7  $FF
F56C: FF FF      clb7  $FF
F56E: FF FF      clb7  $FF
F570: FF FF      clb7  $FF
F572: FF FF      clb7  $FF
F574: FF FF      clb7  $FF
F576: FF FF      clb7  $FF
F578: FF FF      clb7  $FF
F57A: FF FF      clb7  $FF
F57C: FF FF      clb7  $FF
F57E: FF FF      clb7  $FF
F580: FF FF      clb7  $FF
F582: FF FF      clb7  $FF
F584: FF FF      clb7  $FF
F586: FF FF      clb7  $FF
F588: FF FF      clb7  $FF
F58A: FF FF      clb7  $FF
F58C: FF FF      clb7  $FF
F58E: FF FF      clb7  $FF
F590: FF FF      clb7  $FF
F592: FF FF      clb7  $FF
F594: FF FF      clb7  $FF
F596: FF FF      clb7  $FF
F598: FF FF      clb7  $FF
F59A: FF FF      clb7  $FF
F59C: FF FF      clb7  $FF
F59E: FF FF      clb7  $FF
F5A0: FF FF      clb7  $FF
F5A2: FF FF      clb7  $FF
F5A4: FF FF      clb7  $FF
F5A6: FF FF      clb7  $FF
F5A8: FF FF      clb7  $FF
F5AA: FF FF      clb7  $FF
F5AC: FF FF      clb7  $FF
F5AE: FF FF      clb7  $FF
F5B0: FF FF      clb7  $FF
F5B2: FF FF      clb7  $FF
F5B4: FF FF      clb7  $FF
F5B6: FF FF      clb7  $FF
F5B8: FF FF      clb7  $FF
F5BA: FF FF      clb7  $FF
F5BC: FF FF      clb7  $FF
F5BE: FF FF      clb7  $FF
F5C0: FF FF      clb7  $FF
F5C2: FF FF      clb7  $FF
F5C4: FF FF      clb7  $FF
F5C6: FF FF      clb7  $FF
F5C8: FF FF      clb7  $FF
F5CA: FF FF      clb7  $FF
F5CC: FF FF      clb7  $FF
F5CE: FF FF      clb7  $FF
F5D0: FF FF      clb7  $FF
F5D2: FF FF      clb7  $FF
F5D4: FF FF      clb7  $FF
F5D6: FF FF      clb7  $FF
F5D8: FF FF      clb7  $FF
F5DA: FF FF      clb7  $FF
F5DC: FF FF      clb7  $FF
F5DE: FF FF      clb7  $FF
F5E0: FF FF      clb7  $FF
F5E2: FF FF      clb7  $FF
F5E4: FF FF      clb7  $FF
F5E6: FF FF      clb7  $FF
F5E8: FF FF      clb7  $FF
F5EA: FF FF      clb7  $FF
F5EC: FF FF      clb7  $FF
F5EE: FF FF      clb7  $FF
F5F0: FF FF      clb7  $FF
F5F2: FF FF      clb7  $FF
F5F4: FF FF      clb7  $FF
F5F6: FF FF      clb7  $FF
F5F8: FF FF      clb7  $FF
F5FA: FF FF      clb7  $FF
F5FC: FF FF      clb7  $FF
F5FE: FF FF      clb7  $FF
F600: FF FF      clb7  $FF
F602: FF FF      clb7  $FF
F604: FF FF      clb7  $FF
F606: FF FF      clb7  $FF
F608: FF FF      clb7  $FF
F60A: FF FF      clb7  $FF
F60C: FF FF      clb7  $FF
F60E: FF FF      clb7  $FF
F610: FF FF      clb7  $FF
F612: FF FF      clb7  $FF
F614: FF FF      clb7  $FF
F616: FF FF      clb7  $FF
F618: FF FF      clb7  $FF
F61A: FF FF      clb7  $FF
F61C: FF FF      clb7  $FF
F61E: FF FF      clb7  $FF
F620: FF FF      clb7  $FF
F622: FF FF      clb7  $FF
F624: FF FF      clb7  $FF
F626: FF FF      clb7  $FF
F628: FF FF      clb7  $FF
F62A: FF FF      clb7  $FF
F62C: FF FF      clb7  $FF
F62E: FF FF      clb7  $FF
F630: FF FF      clb7  $FF
F632: FF FF      clb7  $FF
F634: FF FF      clb7  $FF
F636: FF FF      clb7  $FF
F638: FF FF      clb7  $FF
F63A: FF FF      clb7  $FF
F63C: FF FF      clb7  $FF
F63E: FF FF      clb7  $FF
F640: FF FF      clb7  $FF
F642: FF FF      clb7  $FF
F644: FF FF      clb7  $FF
F646: FF FF      clb7  $FF
F648: FF FF      clb7  $FF
F64A: FF FF      clb7  $FF
F64C: FF FF      clb7  $FF
F64E: FF FF      clb7  $FF
F650: FF FF      clb7  $FF
F652: FF FF      clb7  $FF
F654: FF FF      clb7  $FF
F656: FF FF      clb7  $FF
F658: FF FF      clb7  $FF
F65A: FF FF      clb7  $FF
F65C: FF FF      clb7  $FF
F65E: FF FF      clb7  $FF
F660: FF FF      clb7  $FF
F662: FF FF      clb7  $FF
F664: FF FF      clb7  $FF
F666: FF FF      clb7  $FF
F668: FF FF      clb7  $FF
F66A: FF FF      clb7  $FF
F66C: FF FF      clb7  $FF
F66E: FF FF      clb7  $FF
F670: FF FF      clb7  $FF
F672: FF FF      clb7  $FF
F674: FF FF      clb7  $FF
F676: FF FF      clb7  $FF
F678: FF FF      clb7  $FF
F67A: FF FF      clb7  $FF
F67C: FF FF      clb7  $FF
F67E: FF FF      clb7  $FF
F680: FF FF      clb7  $FF
F682: FF FF      clb7  $FF
F684: FF FF      clb7  $FF
F686: FF FF      clb7  $FF
F688: FF FF      clb7  $FF
F68A: FF FF      clb7  $FF
F68C: FF FF      clb7  $FF
F68E: FF FF      clb7  $FF
F690: FF FF      clb7  $FF
F692: FF FF      clb7  $FF
F694: FF FF      clb7  $FF
F696: FF FF      clb7  $FF
F698: FF FF      clb7  $FF
F69A: FF FF      clb7  $FF
F69C: FF FF      clb7  $FF
F69E: FF FF      clb7  $FF
F6A0: FF FF      clb7  $FF
F6A2: FF FF      clb7  $FF
F6A4: FF FF      clb7  $FF
F6A6: FF FF      clb7  $FF
F6A8: FF FF      clb7  $FF
F6AA: FF FF      clb7  $FF
F6AC: FF FF      clb7  $FF
F6AE: FF FF      clb7  $FF
F6B0: FF FF      clb7  $FF
F6B2: FF FF      clb7  $FF
F6B4: FF FF      clb7  $FF
F6B6: FF FF      clb7  $FF
F6B8: FF FF      clb7  $FF
F6BA: FF FF      clb7  $FF
F6BC: FF FF      clb7  $FF
F6BE: FF FF      clb7  $FF
F6C0: FF FF      clb7  $FF
F6C2: FF FF      clb7  $FF
F6C4: FF FF      clb7  $FF
F6C6: FF FF      clb7  $FF
F6C8: FF FF      clb7  $FF
F6CA: FF FF      clb7  $FF
F6CC: FF FF      clb7  $FF
F6CE: FF FF      clb7  $FF
F6D0: FF FF      clb7  $FF
F6D2: FF FF      clb7  $FF
F6D4: FF FF      clb7  $FF
F6D6: FF FF      clb7  $FF
F6D8: FF FF      clb7  $FF
F6DA: FF FF      clb7  $FF
F6DC: FF FF      clb7  $FF
F6DE: FF FF      clb7  $FF
F6E0: FF FF      clb7  $FF
F6E2: FF FF      clb7  $FF
F6E4: FF FF      clb7  $FF
F6E6: FF FF      clb7  $FF
F6E8: FF FF      clb7  $FF
F6EA: FF FF      clb7  $FF
F6EC: FF FF      clb7  $FF
F6EE: FF FF      clb7  $FF
F6F0: FF FF      clb7  $FF
F6F2: FF FF      clb7  $FF
F6F4: FF FF      clb7  $FF
F6F6: FF FF      clb7  $FF
F6F8: FF FF      clb7  $FF
F6FA: FF FF      clb7  $FF
F6FC: FF FF      clb7  $FF
F6FE: FF FF      clb7  $FF
F700: FF FF      clb7  $FF
F702: FF FF      clb7  $FF
F704: FF FF      clb7  $FF
F706: FF FF      clb7  $FF
F708: FF FF      clb7  $FF
F70A: FF FF      clb7  $FF
F70C: FF FF      clb7  $FF
F70E: FF FF      clb7  $FF
F710: FF FF      clb7  $FF
F712: FF FF      clb7  $FF
F714: FF FF      clb7  $FF
F716: FF FF      clb7  $FF
F718: FF FF      clb7  $FF
F71A: FF FF      clb7  $FF
F71C: FF FF      clb7  $FF
F71E: FF FF      clb7  $FF
F720: FF FF      clb7  $FF
F722: FF FF      clb7  $FF
F724: FF FF      clb7  $FF
F726: FF FF      clb7  $FF
F728: FF FF      clb7  $FF
F72A: FF FF      clb7  $FF
F72C: FF FF      clb7  $FF
F72E: FF FF      clb7  $FF
F730: FF FF      clb7  $FF
F732: FF FF      clb7  $FF
F734: FF FF      clb7  $FF
F736: FF FF      clb7  $FF
F738: FF FF      clb7  $FF
F73A: FF FF      clb7  $FF
F73C: FF FF      clb7  $FF
F73E: FF FF      clb7  $FF
F740: FF FF      clb7  $FF
F742: FF FF      clb7  $FF
F744: FF FF      clb7  $FF
F746: FF FF      clb7  $FF
F748: FF FF      clb7  $FF
F74A: FF FF      clb7  $FF
F74C: FF FF      clb7  $FF
F74E: FF FF      clb7  $FF
F750: FF FF      clb7  $FF
F752: FF FF      clb7  $FF
F754: FF FF      clb7  $FF
F756: FF FF      clb7  $FF
F758: FF FF      clb7  $FF
F75A: FF FF      clb7  $FF
F75C: FF FF      clb7  $FF
F75E: FF FF      clb7  $FF
F760: FF FF      clb7  $FF
F762: FF FF      clb7  $FF
F764: FF FF      clb7  $FF
F766: FF FF      clb7  $FF
F768: FF FF      clb7  $FF
F76A: FF FF      clb7  $FF
F76C: FF FF      clb7  $FF
F76E: FF FF      clb7  $FF
F770: FF FF      clb7  $FF
F772: FF FF      clb7  $FF
F774: FF FF      clb7  $FF
F776: FF FF      clb7  $FF
F778: FF FF      clb7  $FF
F77A: FF FF      clb7  $FF
F77C: FF FF      clb7  $FF
F77E: FF FF      clb7  $FF
F780: FF FF      clb7  $FF
F782: FF FF      clb7  $FF
F784: FF FF      clb7  $FF
F786: FF FF      clb7  $FF
F788: FF FF      clb7  $FF
F78A: FF FF      clb7  $FF
F78C: FF FF      clb7  $FF
F78E: FF FF      clb7  $FF
F790: FF FF      clb7  $FF
F792: FF FF      clb7  $FF
F794: FF FF      clb7  $FF
F796: FF FF      clb7  $FF
F798: FF FF      clb7  $FF
F79A: FF FF      clb7  $FF
F79C: FF FF      clb7  $FF
F79E: FF FF      clb7  $FF
F7A0: FF FF      clb7  $FF
F7A2: FF FF      clb7  $FF
F7A4: FF FF      clb7  $FF
F7A6: FF FF      clb7  $FF
F7A8: FF FF      clb7  $FF
F7AA: FF FF      clb7  $FF
F7AC: FF FF      clb7  $FF
F7AE: FF FF      clb7  $FF
F7B0: FF FF      clb7  $FF
F7B2: FF FF      clb7  $FF
F7B4: FF FF      clb7  $FF
F7B6: FF FF      clb7  $FF
F7B8: FF FF      clb7  $FF
F7BA: FF FF      clb7  $FF
F7BC: FF FF      clb7  $FF
F7BE: FF FF      clb7  $FF
F7C0: FF FF      clb7  $FF
F7C2: FF FF      clb7  $FF
F7C4: FF FF      clb7  $FF
F7C6: FF FF      clb7  $FF
F7C8: FF FF      clb7  $FF
F7CA: FF FF      clb7  $FF
F7CC: FF FF      clb7  $FF
F7CE: FF FF      clb7  $FF
F7D0: FF FF      clb7  $FF
F7D2: FF FF      clb7  $FF
F7D4: FF FF      clb7  $FF
F7D6: FF FF      clb7  $FF
F7D8: FF FF      clb7  $FF
F7DA: FF FF      clb7  $FF
F7DC: FF FF      clb7  $FF
F7DE: FF FF      clb7  $FF
F7E0: FF FF      clb7  $FF
F7E2: FF FF      clb7  $FF
F7E4: FF FF      clb7  $FF
F7E6: FF FF      clb7  $FF
F7E8: FF FF      clb7  $FF
F7EA: FF FF      clb7  $FF
F7EC: FF FF      clb7  $FF
F7EE: FF FF      clb7  $FF
F7F0: FF FF      clb7  $FF
F7F2: FF FF      clb7  $FF
F7F4: FF FF      clb7  $FF
F7F6: FF FF      clb7  $FF
F7F8: FF FF      clb7  $FF
F7FA: FF FF      clb7  $FF
F7FC: FF FF      clb7  $FF
F7FE: FF FF      clb7  $FF
F800: FF FF      clb7  $FF
F802: FF FF      clb7  $FF
F804: FF FF      clb7  $FF
F806: FF FF      clb7  $FF
F808: FF FF      clb7  $FF
F80A: FF FF      clb7  $FF
F80C: FF FF      clb7  $FF
F80E: FF FF      clb7  $FF
F810: FF FF      clb7  $FF
F812: FF FF      clb7  $FF
F814: FF FF      clb7  $FF
F816: FF FF      clb7  $FF
F818: FF FF      clb7  $FF
F81A: FF FF      clb7  $FF
F81C: FF FF      clb7  $FF
F81E: FF FF      clb7  $FF
F820: FF FF      clb7  $FF
F822: FF FF      clb7  $FF
F824: FF FF      clb7  $FF
F826: FF FF      clb7  $FF
F828: FF FF      clb7  $FF
F82A: FF FF      clb7  $FF
F82C: FF FF      clb7  $FF
F82E: FF FF      clb7  $FF
F830: FF FF      clb7  $FF
F832: FF FF      clb7  $FF
F834: FF FF      clb7  $FF
F836: FF FF      clb7  $FF
F838: FF FF      clb7  $FF
F83A: FF FF      clb7  $FF
F83C: FF FF      clb7  $FF
F83E: FF FF      clb7  $FF
F840: FF FF      clb7  $FF
F842: FF FF      clb7  $FF
F844: FF FF      clb7  $FF
F846: FF FF      clb7  $FF
F848: FF FF      clb7  $FF
F84A: FF FF      clb7  $FF
F84C: FF FF      clb7  $FF
F84E: FF FF      clb7  $FF
F850: FF FF      clb7  $FF
F852: FF FF      clb7  $FF
F854: FF FF      clb7  $FF
F856: FF FF      clb7  $FF
F858: FF FF      clb7  $FF
F85A: FF FF      clb7  $FF
F85C: FF FF      clb7  $FF
F85E: FF FF      clb7  $FF
F860: FF FF      clb7  $FF
F862: FF FF      clb7  $FF
F864: FF FF      clb7  $FF
F866: FF FF      clb7  $FF
F868: FF FF      clb7  $FF
F86A: FF FF      clb7  $FF
F86C: FF FF      clb7  $FF
F86E: FF FF      clb7  $FF
F870: FF FF      clb7  $FF
F872: FF FF      clb7  $FF
F874: FF FF      clb7  $FF
F876: FF FF      clb7  $FF
F878: FF FF      clb7  $FF
F87A: FF FF      clb7  $FF
F87C: FF FF      clb7  $FF
F87E: FF FF      clb7  $FF
F880: FF FF      clb7  $FF
F882: FF FF      clb7  $FF
F884: FF FF      clb7  $FF
F886: FF FF      clb7  $FF
F888: FF FF      clb7  $FF
F88A: FF FF      clb7  $FF
F88C: FF FF      clb7  $FF
F88E: FF FF      clb7  $FF
F890: FF FF      clb7  $FF
F892: FF FF      clb7  $FF
F894: FF FF      clb7  $FF
F896: FF FF      clb7  $FF
F898: FF FF      clb7  $FF
F89A: FF FF      clb7  $FF
F89C: FF FF      clb7  $FF
F89E: FF FF      clb7  $FF
F8A0: FF FF      clb7  $FF
F8A2: FF FF      clb7  $FF
F8A4: FF FF      clb7  $FF
F8A6: FF FF      clb7  $FF
F8A8: FF FF      clb7  $FF
F8AA: FF FF      clb7  $FF
F8AC: FF FF      clb7  $FF
F8AE: FF FF      clb7  $FF
F8B0: FF FF      clb7  $FF
F8B2: FF FF      clb7  $FF
F8B4: FF FF      clb7  $FF
F8B6: FF FF      clb7  $FF
F8B8: FF FF      clb7  $FF
F8BA: FF FF      clb7  $FF
F8BC: FF FF      clb7  $FF
F8BE: FF FF      clb7  $FF
F8C0: FF FF      clb7  $FF
F8C2: FF FF      clb7  $FF
F8C4: FF FF      clb7  $FF
F8C6: FF FF      clb7  $FF
F8C8: FF FF      clb7  $FF
F8CA: FF FF      clb7  $FF
F8CC: FF FF      clb7  $FF
F8CE: FF FF      clb7  $FF
F8D0: FF FF      clb7  $FF
F8D2: FF FF      clb7  $FF
F8D4: FF FF      clb7  $FF
F8D6: FF FF      clb7  $FF
F8D8: FF FF      clb7  $FF
F8DA: FF FF      clb7  $FF
F8DC: FF FF      clb7  $FF
F8DE: FF FF      clb7  $FF
F8E0: FF FF      clb7  $FF
F8E2: FF FF      clb7  $FF
F8E4: FF FF      clb7  $FF
F8E6: FF FF      clb7  $FF
F8E8: FF FF      clb7  $FF
F8EA: FF FF      clb7  $FF
F8EC: FF FF      clb7  $FF
F8EE: FF FF      clb7  $FF
F8F0: FF FF      clb7  $FF
F8F2: FF FF      clb7  $FF
F8F4: FF FF      clb7  $FF
F8F6: FF FF      clb7  $FF
F8F8: FF FF      clb7  $FF
F8FA: FF FF      clb7  $FF
F8FC: FF FF      clb7  $FF
F8FE: FF FF      clb7  $FF
F900: FF FF      clb7  $FF
F902: FF FF      clb7  $FF
F904: FF FF      clb7  $FF
F906: FF FF      clb7  $FF
F908: FF FF      clb7  $FF
F90A: FF FF      clb7  $FF
F90C: FF FF      clb7  $FF
F90E: FF FF      clb7  $FF
F910: FF FF      clb7  $FF
F912: FF FF      clb7  $FF
F914: FF FF      clb7  $FF
F916: FF FF      clb7  $FF
F918: FF FF      clb7  $FF
F91A: FF FF      clb7  $FF
F91C: FF FF      clb7  $FF
F91E: FF FF      clb7  $FF
F920: FF FF      clb7  $FF
F922: FF FF      clb7  $FF
F924: FF FF      clb7  $FF
F926: FF FF      clb7  $FF
F928: FF FF      clb7  $FF
F92A: FF FF      clb7  $FF
F92C: FF FF      clb7  $FF
F92E: FF FF      clb7  $FF
F930: FF FF      clb7  $FF
F932: FF FF      clb7  $FF
F934: FF FF      clb7  $FF
F936: FF FF      clb7  $FF
F938: FF FF      clb7  $FF
F93A: FF FF      clb7  $FF
F93C: FF FF      clb7  $FF
F93E: FF FF      clb7  $FF
F940: FF FF      clb7  $FF
F942: FF FF      clb7  $FF
F944: FF FF      clb7  $FF
F946: FF FF      clb7  $FF
F948: FF FF      clb7  $FF
F94A: FF FF      clb7  $FF
F94C: FF FF      clb7  $FF
F94E: FF FF      clb7  $FF
F950: FF FF      clb7  $FF
F952: FF FF      clb7  $FF
F954: FF FF      clb7  $FF
F956: FF FF      clb7  $FF
F958: FF FF      clb7  $FF
F95A: FF FF      clb7  $FF
F95C: FF FF      clb7  $FF
F95E: FF FF      clb7  $FF
F960: FF FF      clb7  $FF
F962: FF FF      clb7  $FF
F964: FF FF      clb7  $FF
F966: FF FF      clb7  $FF
F968: FF FF      clb7  $FF
F96A: FF FF      clb7  $FF
F96C: FF FF      clb7  $FF
F96E: FF FF      clb7  $FF
F970: FF FF      clb7  $FF
F972: FF FF      clb7  $FF
F974: FF FF      clb7  $FF
F976: FF FF      clb7  $FF
F978: FF FF      clb7  $FF
F97A: FF FF      clb7  $FF
F97C: FF FF      clb7  $FF
F97E: FF FF      clb7  $FF
F980: FF FF      clb7  $FF
F982: FF FF      clb7  $FF
F984: FF FF      clb7  $FF
F986: FF FF      clb7  $FF
F988: FF FF      clb7  $FF
F98A: FF FF      clb7  $FF
F98C: FF FF      clb7  $FF
F98E: FF FF      clb7  $FF
F990: FF FF      clb7  $FF
F992: FF FF      clb7  $FF
F994: FF FF      clb7  $FF
F996: FF FF      clb7  $FF
F998: FF FF      clb7  $FF
F99A: FF FF      clb7  $FF
F99C: FF FF      clb7  $FF
F99E: FF FF      clb7  $FF
F9A0: FF FF      clb7  $FF
F9A2: FF FF      clb7  $FF
F9A4: FF FF      clb7  $FF
F9A6: FF FF      clb7  $FF
F9A8: FF FF      clb7  $FF
F9AA: FF FF      clb7  $FF
F9AC: FF FF      clb7  $FF
F9AE: FF FF      clb7  $FF
F9B0: FF FF      clb7  $FF
F9B2: FF FF      clb7  $FF
F9B4: FF FF      clb7  $FF
F9B6: FF FF      clb7  $FF
F9B8: FF FF      clb7  $FF
F9BA: FF FF      clb7  $FF
F9BC: FF FF      clb7  $FF
F9BE: FF FF      clb7  $FF
F9C0: FF FF      clb7  $FF
F9C2: FF FF      clb7  $FF
F9C4: FF FF      clb7  $FF
F9C6: FF FF      clb7  $FF
F9C8: FF FF      clb7  $FF
F9CA: FF FF      clb7  $FF
F9CC: FF FF      clb7  $FF
F9CE: FF FF      clb7  $FF
F9D0: FF FF      clb7  $FF
F9D2: FF FF      clb7  $FF
F9D4: FF FF      clb7  $FF
F9D6: FF FF      clb7  $FF
F9D8: FF FF      clb7  $FF
F9DA: FF FF      clb7  $FF
F9DC: FF FF      clb7  $FF
F9DE: FF FF      clb7  $FF
F9E0: FF FF      clb7  $FF
F9E2: FF FF      clb7  $FF
F9E4: FF FF      clb7  $FF
F9E6: FF FF      clb7  $FF
F9E8: FF FF      clb7  $FF
F9EA: FF FF      clb7  $FF
F9EC: FF FF      clb7  $FF
F9EE: FF FF      clb7  $FF
F9F0: FF FF      clb7  $FF
F9F2: FF FF      clb7  $FF
F9F4: FF FF      clb7  $FF
F9F6: FF FF      clb7  $FF
F9F8: FF FF      clb7  $FF
F9FA: FF FF      clb7  $FF
F9FC: FF FF      clb7  $FF
F9FE: FF FF      clb7  $FF
FA00: FF FF      clb7  $FF
FA02: FF FF      clb7  $FF
FA04: FF FF      clb7  $FF
FA06: FF FF      clb7  $FF
FA08: FF FF      clb7  $FF
FA0A: FF FF      clb7  $FF
FA0C: FF FF      clb7  $FF
FA0E: FF FF      clb7  $FF
FA10: FF FF      clb7  $FF
FA12: FF FF      clb7  $FF
FA14: FF FF      clb7  $FF
FA16: FF FF      clb7  $FF
FA18: FF FF      clb7  $FF
FA1A: FF FF      clb7  $FF
FA1C: FF FF      clb7  $FF
FA1E: FF FF      clb7  $FF
FA20: FF FF      clb7  $FF
FA22: FF FF      clb7  $FF
FA24: FF FF      clb7  $FF
FA26: FF FF      clb7  $FF
FA28: FF FF      clb7  $FF
FA2A: FF FF      clb7  $FF
FA2C: FF FF      clb7  $FF
FA2E: FF FF      clb7  $FF
FA30: FF FF      clb7  $FF
FA32: FF FF      clb7  $FF
FA34: FF FF      clb7  $FF
FA36: FF FF      clb7  $FF
FA38: FF FF      clb7  $FF
FA3A: FF FF      clb7  $FF
FA3C: FF FF      clb7  $FF
FA3E: FF FF      clb7  $FF
FA40: FF FF      clb7  $FF
FA42: FF FF      clb7  $FF
FA44: FF FF      clb7  $FF
FA46: FF FF      clb7  $FF
FA48: FF FF      clb7  $FF
FA4A: FF FF      clb7  $FF
FA4C: FF FF      clb7  $FF
FA4E: FF FF      clb7  $FF
FA50: FF FF      clb7  $FF
FA52: FF FF      clb7  $FF
FA54: FF FF      clb7  $FF
FA56: FF FF      clb7  $FF
FA58: FF FF      clb7  $FF
FA5A: FF FF      clb7  $FF
FA5C: FF FF      clb7  $FF
FA5E: FF FF      clb7  $FF
FA60: FF FF      clb7  $FF
FA62: FF FF      clb7  $FF
FA64: FF FF      clb7  $FF
FA66: FF FF      clb7  $FF
FA68: FF FF      clb7  $FF
FA6A: FF FF      clb7  $FF
FA6C: FF FF      clb7  $FF
FA6E: FF FF      clb7  $FF
FA70: FF FF      clb7  $FF
FA72: FF FF      clb7  $FF
FA74: FF FF      clb7  $FF
FA76: FF FF      clb7  $FF
FA78: FF FF      clb7  $FF
FA7A: FF FF      clb7  $FF
FA7C: FF FF      clb7  $FF
FA7E: FF FF      clb7  $FF
FA80: FF FF      clb7  $FF
FA82: FF FF      clb7  $FF
FA84: FF FF      clb7  $FF
FA86: FF FF      clb7  $FF
FA88: FF FF      clb7  $FF
FA8A: FF FF      clb7  $FF
FA8C: FF FF      clb7  $FF
FA8E: FF FF      clb7  $FF
FA90: FF FF      clb7  $FF
FA92: FF FF      clb7  $FF
FA94: FF FF      clb7  $FF
FA96: FF FF      clb7  $FF
FA98: FF FF      clb7  $FF
FA9A: FF FF      clb7  $FF
FA9C: FF FF      clb7  $FF
FA9E: FF FF      clb7  $FF
FAA0: FF FF      clb7  $FF
FAA2: FF FF      clb7  $FF
FAA4: FF FF      clb7  $FF
FAA6: FF FF      clb7  $FF
FAA8: FF FF      clb7  $FF
FAAA: FF FF      clb7  $FF
FAAC: FF FF      clb7  $FF
FAAE: FF FF      clb7  $FF
FAB0: FF FF      clb7  $FF
FAB2: FF FF      clb7  $FF
FAB4: FF FF      clb7  $FF
FAB6: FF FF      clb7  $FF
FAB8: FF FF      clb7  $FF
FABA: FF FF      clb7  $FF
FABC: FF FF      clb7  $FF
FABE: FF FF      clb7  $FF
FAC0: FF FF      clb7  $FF
FAC2: FF FF      clb7  $FF
FAC4: FF FF      clb7  $FF
FAC6: FF FF      clb7  $FF
FAC8: FF FF      clb7  $FF
FACA: FF FF      clb7  $FF
FACC: FF FF      clb7  $FF
FACE: FF FF      clb7  $FF
FAD0: FF FF      clb7  $FF
FAD2: FF FF      clb7  $FF
FAD4: FF FF      clb7  $FF
FAD6: FF FF      clb7  $FF
FAD8: FF FF      clb7  $FF
FADA: FF FF      clb7  $FF
FADC: FF FF      clb7  $FF
FADE: FF FF      clb7  $FF
FAE0: FF FF      clb7  $FF
FAE2: FF FF      clb7  $FF
FAE4: FF FF      clb7  $FF
FAE6: FF FF      clb7  $FF
FAE8: FF FF      clb7  $FF
FAEA: FF FF      clb7  $FF
FAEC: FF FF      clb7  $FF
FAEE: FF FF      clb7  $FF
FAF0: FF FF      clb7  $FF
FAF2: FF FF      clb7  $FF
FAF4: FF FF      clb7  $FF
FAF6: FF FF      clb7  $FF
FAF8: FF FF      clb7  $FF
FAFA: FF FF      clb7  $FF
FAFC: FF FF      clb7  $FF
FAFE: FF FF      clb7  $FF
FB00: FF FF      clb7  $FF
FB02: FF FF      clb7  $FF
FB04: FF FF      clb7  $FF
FB06: FF FF      clb7  $FF
FB08: FF FF      clb7  $FF
FB0A: FF FF      clb7  $FF
FB0C: FF FF      clb7  $FF
FB0E: FF FF      clb7  $FF
FB10: FF FF      clb7  $FF
FB12: FF FF      clb7  $FF
FB14: FF FF      clb7  $FF
FB16: FF FF      clb7  $FF
FB18: FF FF      clb7  $FF
FB1A: FF FF      clb7  $FF
FB1C: FF FF      clb7  $FF
FB1E: FF FF      clb7  $FF
FB20: FF FF      clb7  $FF
FB22: FF FF      clb7  $FF
FB24: FF FF      clb7  $FF
FB26: FF FF      clb7  $FF
FB28: FF FF      clb7  $FF
FB2A: FF FF      clb7  $FF
FB2C: FF FF      clb7  $FF
FB2E: FF FF      clb7  $FF
FB30: FF FF      clb7  $FF
FB32: FF FF      clb7  $FF
FB34: FF FF      clb7  $FF
FB36: FF FF      clb7  $FF
FB38: FF FF      clb7  $FF
FB3A: FF FF      clb7  $FF
FB3C: FF FF      clb7  $FF
FB3E: FF FF      clb7  $FF
FB40: FF FF      clb7  $FF
FB42: FF FF      clb7  $FF
FB44: FF FF      clb7  $FF
FB46: FF FF      clb7  $FF
FB48: FF FF      clb7  $FF
FB4A: FF FF      clb7  $FF
FB4C: FF FF      clb7  $FF
FB4E: FF FF      clb7  $FF
FB50: FF FF      clb7  $FF
FB52: FF FF      clb7  $FF
FB54: FF FF      clb7  $FF
FB56: FF FF      clb7  $FF
FB58: FF FF      clb7  $FF
FB5A: FF FF      clb7  $FF
FB5C: FF FF      clb7  $FF
FB5E: FF FF      clb7  $FF
FB60: FF FF      clb7  $FF
FB62: FF FF      clb7  $FF
FB64: FF FF      clb7  $FF
FB66: FF FF      clb7  $FF
FB68: FF FF      clb7  $FF
FB6A: FF FF      clb7  $FF
FB6C: FF FF      clb7  $FF
FB6E: FF FF      clb7  $FF
FB70: FF FF      clb7  $FF
FB72: FF FF      clb7  $FF
FB74: FF FF      clb7  $FF
FB76: FF FF      clb7  $FF
FB78: FF FF      clb7  $FF
FB7A: FF FF      clb7  $FF
FB7C: FF FF      clb7  $FF
FB7E: FF FF      clb7  $FF
FB80: FF FF      clb7  $FF
FB82: FF FF      clb7  $FF
FB84: FF FF      clb7  $FF
FB86: FF FF      clb7  $FF
FB88: FF FF      clb7  $FF
FB8A: FF FF      clb7  $FF
FB8C: FF FF      clb7  $FF
FB8E: FF FF      clb7  $FF
FB90: FF FF      clb7  $FF
FB92: FF FF      clb7  $FF
FB94: FF FF      clb7  $FF
FB96: FF FF      clb7  $FF
FB98: FF FF      clb7  $FF
FB9A: FF FF      clb7  $FF
FB9C: FF FF      clb7  $FF
FB9E: FF FF      clb7  $FF
FBA0: FF FF      clb7  $FF
FBA2: FF FF      clb7  $FF
FBA4: FF FF      clb7  $FF
FBA6: FF FF      clb7  $FF
FBA8: FF FF      clb7  $FF
FBAA: FF FF      clb7  $FF
FBAC: FF FF      clb7  $FF
FBAE: FF FF      clb7  $FF
FBB0: FF FF      clb7  $FF
FBB2: FF FF      clb7  $FF
FBB4: FF FF      clb7  $FF
FBB6: FF FF      clb7  $FF
FBB8: FF FF      clb7  $FF
FBBA: FF FF      clb7  $FF
FBBC: FF FF      clb7  $FF
FBBE: FF FF      clb7  $FF
FBC0: FF FF      clb7  $FF
FBC2: FF FF      clb7  $FF
FBC4: FF FF      clb7  $FF
FBC6: FF FF      clb7  $FF
FBC8: FF FF      clb7  $FF
FBCA: FF FF      clb7  $FF
FBCC: FF FF      clb7  $FF
FBCE: FF FF      clb7  $FF
FBD0: FF FF      clb7  $FF
FBD2: FF FF      clb7  $FF
FBD4: FF FF      clb7  $FF
FBD6: FF FF      clb7  $FF
FBD8: FF FF      clb7  $FF
FBDA: FF FF      clb7  $FF
FBDC: FF FF      clb7  $FF
FBDE: FF FF      clb7  $FF
FBE0: FF FF      clb7  $FF
FBE2: FF FF      clb7  $FF
FBE4: FF FF      clb7  $FF
FBE6: FF FF      clb7  $FF
FBE8: FF FF      clb7  $FF
FBEA: FF FF      clb7  $FF
FBEC: FF FF      clb7  $FF
FBEE: FF FF      clb7  $FF
FBF0: FF FF      clb7  $FF
FBF2: FF FF      clb7  $FF
FBF4: FF FF      clb7  $FF
FBF6: FF FF      clb7  $FF
FBF8: FF FF      clb7  $FF
FBFA: FF FF      clb7  $FF
FBFC: FF FF      clb7  $FF
FBFE: FF FF      clb7  $FF
FC00: FF FF      clb7  $FF
FC02: FF FF      clb7  $FF
FC04: FF FF      clb7  $FF
FC06: FF FF      clb7  $FF
FC08: FF FF      clb7  $FF
FC0A: FF FF      clb7  $FF
FC0C: FF FF      clb7  $FF
FC0E: FF FF      clb7  $FF
FC10: FF FF      clb7  $FF
FC12: FF FF      clb7  $FF
FC14: FF FF      clb7  $FF
FC16: FF FF      clb7  $FF
FC18: FF FF      clb7  $FF
FC1A: FF FF      clb7  $FF
FC1C: FF FF      clb7  $FF
FC1E: FF FF      clb7  $FF
FC20: FF FF      clb7  $FF
FC22: FF FF      clb7  $FF
FC24: FF FF      clb7  $FF
FC26: FF FF      clb7  $FF
FC28: FF FF      clb7  $FF
FC2A: FF FF      clb7  $FF
FC2C: FF FF      clb7  $FF
FC2E: FF FF      clb7  $FF
FC30: FF FF      clb7  $FF
FC32: FF FF      clb7  $FF
FC34: FF FF      clb7  $FF
FC36: FF FF      clb7  $FF
FC38: FF FF      clb7  $FF
FC3A: FF FF      clb7  $FF
FC3C: FF FF      clb7  $FF
FC3E: FF FF      clb7  $FF
FC40: FF FF      clb7  $FF
FC42: FF FF      clb7  $FF
FC44: FF FF      clb7  $FF
FC46: FF FF      clb7  $FF
FC48: FF FF      clb7  $FF
FC4A: FF FF      clb7  $FF
FC4C: FF FF      clb7  $FF
FC4E: FF FF      clb7  $FF
FC50: FF FF      clb7  $FF
FC52: FF FF      clb7  $FF
FC54: FF FF      clb7  $FF
FC56: FF FF      clb7  $FF
FC58: FF FF      clb7  $FF
FC5A: FF FF      clb7  $FF
FC5C: FF FF      clb7  $FF
FC5E: FF FF      clb7  $FF
FC60: FF FF      clb7  $FF
FC62: FF FF      clb7  $FF
FC64: FF FF      clb7  $FF
FC66: FF FF      clb7  $FF
FC68: FF FF      clb7  $FF
FC6A: FF FF      clb7  $FF
FC6C: FF FF      clb7  $FF
FC6E: FF FF      clb7  $FF
FC70: FF FF      clb7  $FF
FC72: FF FF      clb7  $FF
FC74: FF FF      clb7  $FF
FC76: FF FF      clb7  $FF
FC78: FF FF      clb7  $FF
FC7A: FF FF      clb7  $FF
FC7C: FF FF      clb7  $FF
FC7E: FF FF      clb7  $FF
FC80: FF FF      clb7  $FF
FC82: FF FF      clb7  $FF
FC84: FF FF      clb7  $FF
FC86: FF FF      clb7  $FF
FC88: FF FF      clb7  $FF
FC8A: FF FF      clb7  $FF
FC8C: FF FF      clb7  $FF
FC8E: FF FF      clb7  $FF
FC90: FF FF      clb7  $FF
FC92: FF FF      clb7  $FF
FC94: FF FF      clb7  $FF
FC96: FF FF      clb7  $FF
FC98: FF FF      clb7  $FF
FC9A: FF FF      clb7  $FF
FC9C: FF FF      clb7  $FF
FC9E: FF FF      clb7  $FF
FCA0: FF FF      clb7  $FF
FCA2: FF FF      clb7  $FF
FCA4: FF FF      clb7  $FF
FCA6: FF FF      clb7  $FF
FCA8: FF FF      clb7  $FF
FCAA: FF FF      clb7  $FF
FCAC: FF FF      clb7  $FF
FCAE: FF FF      clb7  $FF
FCB0: FF FF      clb7  $FF
FCB2: FF FF      clb7  $FF
FCB4: FF FF      clb7  $FF
FCB6: FF FF      clb7  $FF
FCB8: FF FF      clb7  $FF
FCBA: FF FF      clb7  $FF
FCBC: FF FF      clb7  $FF
FCBE: FF FF      clb7  $FF
FCC0: FF FF      clb7  $FF
FCC2: FF FF      clb7  $FF
FCC4: FF FF      clb7  $FF
FCC6: FF FF      clb7  $FF
FCC8: FF FF      clb7  $FF
FCCA: FF FF      clb7  $FF
FCCC: FF FF      clb7  $FF
FCCE: FF FF      clb7  $FF
FCD0: FF FF      clb7  $FF
FCD2: FF FF      clb7  $FF
FCD4: FF FF      clb7  $FF
FCD6: FF FF      clb7  $FF
FCD8: FF FF      clb7  $FF
FCDA: FF FF      clb7  $FF
FCDC: FF FF      clb7  $FF
FCDE: FF FF      clb7  $FF
FCE0: FF FF      clb7  $FF
FCE2: FF FF      clb7  $FF
FCE4: FF FF      clb7  $FF
FCE6: FF FF      clb7  $FF
FCE8: FF FF      clb7  $FF
FCEA: FF FF      clb7  $FF
FCEC: FF FF      clb7  $FF
FCEE: FF FF      clb7  $FF
FCF0: FF FF      clb7  $FF
FCF2: FF FF      clb7  $FF
FCF4: FF FF      clb7  $FF
FCF6: FF FF      clb7  $FF
FCF8: FF FF      clb7  $FF
FCFA: FF FF      clb7  $FF
FCFC: FF FF      clb7  $FF
FCFE: FF FF      clb7  $FF
FD00: FF FF      clb7  $FF
FD02: FF FF      clb7  $FF
FD04: FF FF      clb7  $FF
FD06: FF FF      clb7  $FF
FD08: FF FF      clb7  $FF
FD0A: FF FF      clb7  $FF
FD0C: FF FF      clb7  $FF
FD0E: FF FF      clb7  $FF
FD10: FF FF      clb7  $FF
FD12: FF FF      clb7  $FF
FD14: FF FF      clb7  $FF
FD16: FF FF      clb7  $FF
FD18: FF FF      clb7  $FF
FD1A: FF FF      clb7  $FF
FD1C: FF FF      clb7  $FF
FD1E: FF FF      clb7  $FF
FD20: FF FF      clb7  $FF
FD22: FF FF      clb7  $FF
FD24: FF FF      clb7  $FF
FD26: FF FF      clb7  $FF
FD28: FF FF      clb7  $FF
FD2A: FF FF      clb7  $FF
FD2C: FF FF      clb7  $FF
FD2E: FF FF      clb7  $FF
FD30: FF FF      clb7  $FF
FD32: FF FF      clb7  $FF
FD34: FF FF      clb7  $FF
FD36: FF FF      clb7  $FF
FD38: FF FF      clb7  $FF
FD3A: FF FF      clb7  $FF
FD3C: FF FF      clb7  $FF
FD3E: FF FF      clb7  $FF
FD40: FF FF      clb7  $FF
FD42: FF FF      clb7  $FF
FD44: FF FF      clb7  $FF
FD46: FF FF      clb7  $FF
FD48: FF FF      clb7  $FF
FD4A: FF FF      clb7  $FF
FD4C: FF FF      clb7  $FF
FD4E: FF FF      clb7  $FF
FD50: FF FF      clb7  $FF
FD52: FF FF      clb7  $FF
FD54: FF FF      clb7  $FF
FD56: FF FF      clb7  $FF
FD58: FF FF      clb7  $FF
FD5A: FF FF      clb7  $FF
FD5C: FF FF      clb7  $FF
FD5E: FF FF      clb7  $FF
FD60: FF FF      clb7  $FF
FD62: FF FF      clb7  $FF
FD64: FF FF      clb7  $FF
FD66: FF FF      clb7  $FF
FD68: FF FF      clb7  $FF
FD6A: FF FF      clb7  $FF
FD6C: FF FF      clb7  $FF
FD6E: FF FF      clb7  $FF
FD70: FF FF      clb7  $FF
FD72: FF FF      clb7  $FF
FD74: FF FF      clb7  $FF
FD76: FF FF      clb7  $FF
FD78: FF FF      clb7  $FF
FD7A: FF FF      clb7  $FF
FD7C: FF FF      clb7  $FF
FD7E: FF FF      clb7  $FF
FD80: FF FF      clb7  $FF
FD82: FF FF      clb7  $FF
FD84: FF FF      clb7  $FF
FD86: FF FF      clb7  $FF
FD88: FF FF      clb7  $FF
FD8A: FF FF      clb7  $FF
FD8C: FF FF      clb7  $FF
FD8E: FF FF      clb7  $FF
FD90: FF FF      clb7  $FF
FD92: FF FF      clb7  $FF
FD94: FF FF      clb7  $FF
FD96: FF FF      clb7  $FF
FD98: FF FF      clb7  $FF
FD9A: FF FF      clb7  $FF
FD9C: FF FF      clb7  $FF
FD9E: FF FF      clb7  $FF
FDA0: FF FF      clb7  $FF
FDA2: FF FF      clb7  $FF
FDA4: FF FF      clb7  $FF
FDA6: FF FF      clb7  $FF
FDA8: FF FF      clb7  $FF
FDAA: FF FF      clb7  $FF
FDAC: FF FF      clb7  $FF
FDAE: FF FF      clb7  $FF
FDB0: FF FF      clb7  $FF
FDB2: FF FF      clb7  $FF
FDB4: FF FF      clb7  $FF
FDB6: FF FF      clb7  $FF
FDB8: FF FF      clb7  $FF
FDBA: FF FF      clb7  $FF
FDBC: FF FF      clb7  $FF
FDBE: FF FF      clb7  $FF
FDC0: FF FF      clb7  $FF
FDC2: FF FF      clb7  $FF
FDC4: FF FF      clb7  $FF
FDC6: FF FF      clb7  $FF
FDC8: FF FF      clb7  $FF
FDCA: FF FF      clb7  $FF
FDCC: FF FF      clb7  $FF
FDCE: FF FF      clb7  $FF
FDD0: FF FF      clb7  $FF
FDD2: FF FF      clb7  $FF
FDD4: FF FF      clb7  $FF
FDD6: FF FF      clb7  $FF
FDD8: FF FF      clb7  $FF
FDDA: FF FF      clb7  $FF
FDDC: FF FF      clb7  $FF
FDDE: FF FF      clb7  $FF
FDE0: FF FF      clb7  $FF
FDE2: FF FF      clb7  $FF
FDE4: FF FF      clb7  $FF
FDE6: FF FF      clb7  $FF
FDE8: FF FF      clb7  $FF
FDEA: FF FF      clb7  $FF
FDEC: FF FF      clb7  $FF
FDEE: FF FF      clb7  $FF
FDF0: FF FF      clb7  $FF
FDF2: FF FF      clb7  $FF
FDF4: FF FF      clb7  $FF
FDF6: FF FF      clb7  $FF
FDF8: FF FF      clb7  $FF
FDFA: FF FF      clb7  $FF
FDFC: FF FF      clb7  $FF
FDFE: FF FF      clb7  $FF
FE00: FF FF      clb7  $FF
FE02: FF FF      clb7  $FF
FE04: FF FF      clb7  $FF
FE06: FF FF      clb7  $FF
FE08: FF FF      clb7  $FF
FE0A: FF FF      clb7  $FF
FE0C: FF FF      clb7  $FF
FE0E: FF FF      clb7  $FF
FE10: FF FF      clb7  $FF
FE12: FF FF      clb7  $FF
FE14: FF FF      clb7  $FF
FE16: FF FF      clb7  $FF
FE18: FF FF      clb7  $FF
FE1A: FF FF      clb7  $FF
FE1C: FF FF      clb7  $FF
FE1E: FF FF      clb7  $FF
FE20: FF FF      clb7  $FF
FE22: FF FF      clb7  $FF
FE24: FF FF      clb7  $FF
FE26: FF FF      clb7  $FF
FE28: FF FF      clb7  $FF
FE2A: FF FF      clb7  $FF
FE2C: FF FF      clb7  $FF
FE2E: FF FF      clb7  $FF
FE30: FF FF      clb7  $FF
FE32: FF FF      clb7  $FF
FE34: FF FF      clb7  $FF
FE36: FF FF      clb7  $FF
FE38: FF FF      clb7  $FF
FE3A: FF FF      clb7  $FF
FE3C: FF FF      clb7  $FF
FE3E: FF FF      clb7  $FF
FE40: FF FF      clb7  $FF
FE42: FF FF      clb7  $FF
FE44: FF FF      clb7  $FF
FE46: FF FF      clb7  $FF
FE48: FF FF      clb7  $FF
FE4A: FF FF      clb7  $FF
FE4C: FF FF      clb7  $FF
FE4E: FF FF      clb7  $FF
FE50: FF FF      clb7  $FF
FE52: FF FF      clb7  $FF
FE54: FF FF      clb7  $FF
FE56: FF FF      clb7  $FF
FE58: FF FF      clb7  $FF
FE5A: FF FF      clb7  $FF
FE5C: FF FF      clb7  $FF
FE5E: FF FF      clb7  $FF
FE60: FF FF      clb7  $FF
FE62: FF FF      clb7  $FF
FE64: FF FF      clb7  $FF
FE66: FF FF      clb7  $FF
FE68: FF FF      clb7  $FF
FE6A: FF FF      clb7  $FF
FE6C: FF FF      clb7  $FF
FE6E: FF FF      clb7  $FF
FE70: FF FF      clb7  $FF
FE72: FF FF      clb7  $FF
FE74: FF FF      clb7  $FF
FE76: FF FF      clb7  $FF
FE78: FF FF      clb7  $FF
FE7A: FF FF      clb7  $FF
FE7C: FF FF      clb7  $FF
FE7E: FF FF      clb7  $FF
FE80: FF FF      clb7  $FF
FE82: FF FF      clb7  $FF
FE84: FF FF      clb7  $FF
FE86: FF FF      clb7  $FF
FE88: FF FF      clb7  $FF
FE8A: FF FF      clb7  $FF
FE8C: FF FF      clb7  $FF
FE8E: FF FF      clb7  $FF
FE90: FF FF      clb7  $FF
FE92: FF FF      clb7  $FF
FE94: FF FF      clb7  $FF
FE96: FF FF      clb7  $FF
FE98: FF FF      clb7  $FF
FE9A: FF FF      clb7  $FF
FE9C: FF FF      clb7  $FF
FE9E: FF FF      clb7  $FF
FEA0: FF FF      clb7  $FF
FEA2: FF FF      clb7  $FF
FEA4: FF FF      clb7  $FF
FEA6: FF FF      clb7  $FF
FEA8: FF FF      clb7  $FF
FEAA: FF FF      clb7  $FF
FEAC: FF FF      clb7  $FF
FEAE: FF FF      clb7  $FF
FEB0: FF FF      clb7  $FF
FEB2: FF FF      clb7  $FF
FEB4: FF FF      clb7  $FF
FEB6: FF FF      clb7  $FF
FEB8: FF FF      clb7  $FF
FEBA: FF FF      clb7  $FF
FEBC: FF FF      clb7  $FF
FEBE: FF FF      clb7  $FF
FEC0: FF FF      clb7  $FF
FEC2: FF FF      clb7  $FF
FEC4: FF FF      clb7  $FF
FEC6: FF FF      clb7  $FF
FEC8: FF FF      clb7  $FF
FECA: FF FF      clb7  $FF
FECC: FF FF      clb7  $FF
FECE: FF FF      clb7  $FF
FED0: FF FF      clb7  $FF
FED2: FF FF      clb7  $FF
FED4: FF FF      clb7  $FF
FED6: FF FF      clb7  $FF
FED8: FF FF      clb7  $FF
FEDA: FF FF      clb7  $FF
FEDC: FF FF      clb7  $FF
FEDE: FF FF      clb7  $FF
FEE0: FF FF      clb7  $FF
FEE2: FF FF      clb7  $FF
FEE4: FF FF      clb7  $FF
FEE6: FF FF      clb7  $FF
FEE8: FF FF      clb7  $FF
FEEA: FF FF      clb7  $FF
FEEC: FF FF      clb7  $FF
FEEE: FF FF      clb7  $FF
FEF0: FF FF      clb7  $FF
FEF2: FF FF      clb7  $FF
FEF4: FF FF      clb7  $FF
FEF6: FF FF      clb7  $FF
FEF8: FF FF      clb7  $FF
FEFA: FF FF      clb7  $FF
FEFC: FF FF      clb7  $FF
FEFE: FF FF      clb7  $FF
FF00: FF FF      clb7  $FF
FF02: FF FF      clb7  $FF
FF04: FF FF      clb7  $FF
FF06: FF FF      clb7  $FF
FF08: FF FF      clb7  $FF
FF0A: FF FF      clb7  $FF
FF0C: FF FF      clb7  $FF
FF0E: FF FF      clb7  $FF
FF10: FF FF      clb7  $FF
FF12: FF FF      clb7  $FF
FF14: FF FF      clb7  $FF
FF16: FF FF      clb7  $FF
FF18: FF FF      clb7  $FF
FF1A: FF FF      clb7  $FF
FF1C: FF FF      clb7  $FF
FF1E: FF FF      clb7  $FF
FF20: FF FF      clb7  $FF
FF22: FF FF      clb7  $FF
FF24: FF FF      clb7  $FF
FF26: FF FF      clb7  $FF
FF28: FF FF      clb7  $FF
FF2A: FF FF      clb7  $FF
FF2C: FF FF      clb7  $FF
FF2E: FF FF      clb7  $FF
FF30: FF FF      clb7  $FF
FF32: FF FF      clb7  $FF
FF34: FF FF      clb7  $FF
FF36: FF FF      clb7  $FF
FF38: FF FF      clb7  $FF
FF3A: FF FF      clb7  $FF
FF3C: FF FF      clb7  $FF
FF3E: FF FF      clb7  $FF
FF40: FF FF      clb7  $FF
FF42: FF FF      clb7  $FF
FF44: FF FF      clb7  $FF
FF46: FF FF      clb7  $FF
FF48: FF FF      clb7  $FF
FF4A: FF FF      clb7  $FF
FF4C: FF FF      clb7  $FF
FF4E: FF FF      clb7  $FF
FF50: FF FF      clb7  $FF
FF52: FF FF      clb7  $FF
FF54: FF FF      clb7  $FF
FF56: FF FF      clb7  $FF
FF58: FF FF      clb7  $FF
FF5A: FF FF      clb7  $FF
FF5C: FF FF      clb7  $FF
FF5E: FF FF      clb7  $FF
FF60: FF FF      clb7  $FF
FF62: FF FF      clb7  $FF
FF64: FF FF      clb7  $FF
FF66: FF FF      clb7  $FF
FF68: FF FF      clb7  $FF
FF6A: FF FF      clb7  $FF
FF6C: FF FF      clb7  $FF
FF6E: FF FF      clb7  $FF
FF70: FF FF      clb7  $FF
FF72: FF FF      clb7  $FF
FF74: FF FF      clb7  $FF
FF76: FF FF      clb7  $FF
FF78: FF FF      clb7  $FF
FF7A: FF FF      clb7  $FF
FF7C: FF FF      clb7  $FF
FF7E: FF FF      clb7  $FF
FF80: FF FF      clb7  $FF
FF82: FF FF      clb7  $FF
FF84: FF FF      clb7  $FF
FF86: FF FF      clb7  $FF
FF88: FF FF      clb7  $FF
FF8A: FF FF      clb7  $FF
FF8C: FF FF      clb7  $FF
FF8E: FF FF      clb7  $FF
FF90: FF FF      clb7  $FF
FF92: FF FF      clb7  $FF
FF94: FF FF      clb7  $FF
FF96: FF FF      clb7  $FF
FF98: FF FF      clb7  $FF
FF9A: FF FF      clb7  $FF
FF9C: FF FF      clb7  $FF
FF9E: FF FF      clb7  $FF
FFA0: FF FF      clb7  $FF
FFA2: FF FF      clb7  $FF
FFA4: FF FF      clb7  $FF
FFA6: FF FF      clb7  $FF
FFA8: FF FF      clb7  $FF
FFAA: FF FF      clb7  $FF
FFAC: FF FF      clb7  $FF
FFAE: FF FF      clb7  $FF
FFB0: FF FF      clb7  $FF
FFB2: FF FF      clb7  $FF
FFB4: FF FF      clb7  $FF
FFB6: FF FF      clb7  $FF
FFB8: FF FF      clb7  $FF
FFBA: FF FF      clb7  $FF
FFBC: FF FF      clb7  $FF
FFBE: FF FF      clb7  $FF
FFC0: FF FF      clb7  $FF
FFC2: FF FF      clb7  $FF
FFC4: FF FF      clb7  $FF
FFC6: FF FF      clb7  $FF
FFC8: FF FF      clb7  $FF
FFCA: FF FF      clb7  $FF
FFCC: FF FF      clb7  $FF
FFCE: FF FF      clb7  $FF
FFD0: FF FF      clb7  $FF
FFD2: FF FF      clb7  $FF
FFD4: FF FF      clb7  $FF
FFD6: FF FF      clb7  $FF
FFD8: FF FF      clb7  $FF
FFDA: FF FF      clb7  $FF
FFDC: FC        .byte $FC
FFDD: E8         inx   
FFDE: 12         clt   
FFDF: D6 FC      dec   $FC,X
FFE1: E8         inx   
FFE2: 90 D1      bcc   $FFB5
FFE4: 77 D1 FC   bbc3  $D1,$FFE3
FFE7: E8         inx   
FFE8: FC        .byte $FC
FFE9: E8         inx   
FFEA: FC        .byte $FC
FFEB: E8         inx   
FFEC: 07 E3 66   bbs0  $E3,$0055
FFEF: E3        .byte $E3
FFF0: D4        .byte $D4
FFF1: D8         cld   
FFF2: FC        .byte $FC
FFF3: E8         inx   
FFF4: AA         tax   
FFF5: E2 CF      div   $CF,X
FFF7: E2 61      div   $61,X
FFF9: DC        .byte $DC
FFFA: AF D1      seb5  $D1
FFFC: B1 E6      lda   ($E6),Y
