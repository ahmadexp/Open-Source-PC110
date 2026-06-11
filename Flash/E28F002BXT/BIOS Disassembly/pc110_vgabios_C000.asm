; Chips & Technologies 65535 VGA BIOS (PC110), option ROM @ file 0x20000 -> C000:0
; entry C000:0003 ; reachable insns: 5144 ; subs: 135


;----- sub_0003 -----
C000:0003  eb3f         jmp    0x44                  
C000:0044  e94f32       jmp    0x3296                

;----- sub_0B0C -----
C000:0B0C  52           push   dx                    
C000:0B0D  50           push   ax                    
C000:0B0E  bad603       mov    dx, 0x3d6             
C000:0B11  ec           in     al, dx                
C000:0B12  50           push   ax                    
C000:0B13  b051         mov    al, 0x51              
C000:0B15  e82714       call   0x1f3f                
C000:0B18  f6c404       test   ah, 4                 
C000:0B1B  58           pop    ax                    
C000:0B1C  bad603       mov    dx, 0x3d6             
C000:0B1F  ee           out    dx, al                
C000:0B20  58           pop    ax                    
C000:0B21  5a           pop    dx                    
C000:0B22  c3           ret                          

;----- sub_0B23 -----
C000:0B23  50           push   ax                    
C000:0B24  52           push   dx                    
C000:0B25  eb07         jmp    0xb2e                 
C000:0B2E  b80100       mov    ax, 1                 
C000:0B31  2ef606b40120 test   byte ptr cs:[0x1b4], 0x20
C000:0B37  7411         je     0xb4a                 
C000:0B39  b006         mov    al, 6                 
C000:0B3B  bad603       mov    dx, 0x3d6             
C000:0B3E  e87c52       call   0x5dbd                
C000:0B41  d0e8         shr    al, 1                 
C000:0B43  a801         test   al, 1                 
C000:0B45  7503         jne    0xb4a                 
C000:0B47  b80101       mov    ax, 0x101             
C000:0B4A  250101       and    ax, 0x101             
C000:0B4D  3ae0         cmp    ah, al                
C000:0B4F  5a           pop    dx                    
C000:0B50  58           pop    ax                    
C000:0B51  c3           ret                          

;----- sub_0B52 -----
C000:0B52  e80100       call   0xb56                 
C000:0B55  c3           ret                          

;----- sub_0B56 -----
C000:0B56  80268904f9   and    byte ptr [0x489], 0xf9
C000:0B5B  33ff         xor    di, di                
C000:0B5D  e8e613       call   0x1f46                
C000:0B60  80e4f3       and    ah, 0xf3              
C000:0B63  2ef606b20104 test   byte ptr cs:[0x1b2], 4
C000:0B69  7405         je     0xb70                 
C000:0B6B  800e890408   or     byte ptr [0x489], 8   
C000:0B70  eb00         jmp    0xb72                 
C000:0B72  b0ff         mov    al, 0xff              
C000:0B74  bac603       mov    dx, 0x3c6             
C000:0B77  ee           out    dx, al                
C000:0B78  ba5500       mov    dx, 0x55              
C000:0B7B  52           push   dx                    
C000:0B7C  b000         mov    al, 0                 
C000:0B7E  bac603       mov    dx, 0x3c6             
C000:0B81  ee           out    dx, al                
C000:0B82  5a           pop    dx                    
C000:0B83  83fa55       cmp    dx, 0x55              
C000:0B86  740c         je     0xb94                 
C000:0B88  80fa00       cmp    dl, 0                 
C000:0B8B  7415         je     0xba2                 
C000:0B8D  80fa01       cmp    dl, 1                 
C000:0B90  744c         je     0xbde                 
C000:0B92  eb31         jmp    0xbc5                 
C000:0B94  32db         xor    bl, bl                
C000:0B96  2ea0ce01     mov    al, byte ptr cs:[0x1ce]
C000:0B9A  24c0         and    al, 0xc0              
C000:0B9C  3cc0         cmp    al, 0xc0              
C000:0B9E  7402         je     0xba2                 
C000:0BA0  eb1b         jmp    0xbbd                 
C000:0BA2  e86613       call   0x1f0b                
C000:0BA5  eb48         jmp    0xbef                 
C000:0BBD  2ef606b40120 test   byte ptr cs:[0x1b4], 0x20
C000:0BC3  7419         je     0xbde                 
C000:0BC5  8ad3         mov    dl, bl                
C000:0BC7  0ad2         or     dl, dl                
C000:0BC9  b120         mov    cl, 0x20              
C000:0BCB  b302         mov    bl, 2                 
C000:0BCD  750a         jne    0xbd9                 
C000:0BCF  2ea0ce01     mov    al, byte ptr cs:[0x1ce]
C000:0BD3  a840         test   al, 0x40              
C000:0BD5  750b         jne    0xbe2                 
C000:0BD7  eb05         jmp    0xbde                 
C000:0BD9  f6c220       test   dl, 0x20              
C000:0BDC  7504         jne    0xbe2                 
C000:0BDE  b110         mov    cl, 0x10              
C000:0BE0  b301         mov    bl, 1                 
C000:0BE2  e82613       call   0x1f0b                
C000:0BE5  8ac1         mov    al, cl                
C000:0BE7  e8ec22       call   0x2ed6                
C000:0BEA  57           push   di                    
C000:0BEB  e80a00       call   0xbf8                 
C000:0BEE  5f           pop    di                    
C000:0BEF  0bff         or     di, di                
C000:0BF1  c3           ret                          

;----- sub_0BF8 -----
C000:0BF8  53           push   bx                    
C000:0BF9  b703         mov    bh, 3                 
C000:0BFB  e8fb08       call   0x14f9                
C000:0BFE  8add         mov    bl, ch                
C000:0C00  e8c309       call   0x15c6                
C000:0C03  b702         mov    bh, 2                 
C000:0C05  e8f108       call   0x14f9                
C000:0C08  8ad9         mov    bl, cl                
C000:0C0A  e8b909       call   0x15c6                
C000:0C0D  5b           pop    bx                    
C000:0C0E  c3           ret                          

;----- sub_0DBA -----
C000:0DBA  bace03       mov    dx, 0x3ce             
C000:0DBD  ec           in     al, dx                
C000:0DBE  50           push   ax                    
C000:0DBF  b006         mov    al, 6                 
C000:0DC1  ee           out    dx, al                
C000:0DC2  ed           in     ax, dx                
C000:0DC3  f6c401       test   ah, 1                 
C000:0DC6  58           pop    ax                    
C000:0DC7  ee           out    dx, al                
C000:0DC8  c3           ret                          

;----- sub_0DC9 -----
C000:0DC9  50           push   ax                    
C000:0DCA  51           push   cx                    
C000:0DCB  52           push   dx                    
C000:0DCC  b06c         mov    al, 0x6c              
C000:0DCE  e86e11       call   0x1f3f                
C000:0DD1  8acc         mov    cl, ah                
C000:0DD3  b004         mov    al, 4                 
C000:0DD5  e86711       call   0x1f3f                
C000:0DD8  80e4df       and    ah, 0xdf              
C000:0DDB  f6c102       test   cl, 2                 
C000:0DDE  7501         jne    0xde1                 
C000:0DE0  ef           out    dx, ax                
C000:0DE1  5a           pop    dx                    
C000:0DE2  59           pop    cx                    
C000:0DE3  58           pop    ax                    
C000:0DE4  c3           ret                          

;----- sub_0FC5 -----
C000:0FC5  e8ce1e       call   0x2e96                
C000:0FC8  0c10         or     al, 0x10              
C000:0FCA  e8da1e       call   0x2ea7                
C000:0FCD  e88b01       call   0x115b                
C000:0FD0  b85e5f       mov    ax, 0x5f5e            
C000:0FD3  b300         mov    bl, 0                 
C000:0FD5  cd10         int    0x10                   ; service
C000:0FD7  c3           ret                          

;----- sub_10FF -----
C000:10FF  50           push   ax                    
C000:1100  2ea10d02     mov    ax, word ptr cs:[0x20d]
C000:1104  32ff         xor    bh, bh                
C000:1106  3de001       cmp    ax, 0x1e0             
C000:1109  7609         jbe    0x1114                
C000:110B  b701         mov    bh, 1                 
C000:110D  3d0003       cmp    ax, 0x300             
C000:1110  7602         jbe    0x1114                
C000:1112  b703         mov    bh, 3                 
C000:1114  58           pop    ax                    
C000:1115  c3           ret                          

;----- sub_115B -----
C000:115B  b057         mov    al, 0x57              
C000:115D  e8df0d       call   0x1f3f                
C000:1160  80cc22       or     ah, 0x22              
C000:1163  ef           out    dx, ax                
C000:1164  b401         mov    ah, 1                 
C000:1166  e896ff       call   0x10ff                
C000:1169  f6c701       test   bh, 1                 
C000:116C  750f         jne    0x117d                
C000:116E  b404         mov    ah, 4                 
C000:1170  50           push   ax                    
C000:1171  b059         mov    al, 0x59              
C000:1173  e8514c       call   0x5dc7                
C000:1176  80cc80       or     ah, 0x80              
C000:1179  e8514c       call   0x5dcd                
C000:117C  58           pop    ax                    
C000:117D  b05a         mov    al, 0x5a              
C000:117F  ef           out    dx, ax                
C000:1180  c3           ret                          

;----- sub_1221 -----
C000:1221  50           push   ax                    
C000:1222  53           push   bx                    
C000:1223  51           push   cx                    
C000:1224  52           push   dx                    
C000:1225  57           push   di                    
C000:1226  e8590c       call   0x1e82                
C000:1229  33d2         xor    dx, dx                
C000:122B  3c13         cmp    al, 0x13              
C000:122D  7623         jbe    0x1252                
C000:122F  e8c304       call   0x16f5                
C000:1232  e8850c       call   0x1eba                
C000:1235  2e8a951c0a   mov    dl, byte ptr cs:[di + 0xa1c]
C000:123A  2e8a9d1b0a   mov    bl, byte ptr cs:[di + 0xa1b]
C000:123F  80e207       and    dl, 7                 
C000:1242  f6c304       test   bl, 4                 
C000:1245  7403         je     0x124a                
C000:1247  80ce04       or     dh, 4                 
C000:124A  f6c380       test   bl, 0x80              
C000:124D  7403         je     0x1252                
C000:124F  80ce01       or     dh, 1                 
C000:1252  e83c0c       call   0x1e91                
C000:1255  e81303       call   0x156b                
C000:1258  52           push   dx                    
C000:1259  e8f500       call   0x1351                
C000:125C  53           push   bx                    
C000:125D  e8acf8       call   0xb0c                 
C000:1260  7420         je     0x1282                
C000:1262  e8e10c       call   0x1f46                
C000:1265  f6c420       test   ah, 0x20              
C000:1268  7418         je     0x1282                
C000:126A  e88c02       call   0x14f9                
C000:126D  b502         mov    ch, 2                 
C000:126F  f6c304       test   bl, 4                 
C000:1272  7402         je     0x1276                
C000:1274  b109         mov    cl, 9                 
C000:1276  8bd9         mov    bx, cx                
C000:1278  80fb09       cmp    bl, 9                 
C000:127B  7502         jne    0x127f                
C000:127D  b328         mov    bl, 0x28              
C000:127F  e84403       call   0x15c6                
C000:1282  5b           pop    bx                    
C000:1283  5a           pop    dx                    
C000:1284  8bc2         mov    ax, dx                
C000:1286  8b166304     mov    dx, word ptr [0x463]  
C000:128A  83c206       add    dx, 6                 
C000:128D  ee           out    dx, al                
C000:128E  b00b         mov    al, 0xb               
C000:1290  bad603       mov    dx, 0x3d6             
C000:1293  ef           out    dx, ax                
C000:1294  b004         mov    al, 4                 
C000:1296  e8294b       call   0x5dc2                
C000:1299  80e4fb       and    ah, 0xfb              
C000:129C  f6c308       test   bl, 8                 
C000:129F  7403         je     0x12a4                
C000:12A1  80cc04       or     ah, 4                 
C000:12A4  32ff         xor    bh, bh                
C000:12A6  80e4f7       and    ah, 0xf7              
C000:12A9  f6c304       test   bl, 4                 
C000:12AC  7417         je     0x12c5                
C000:12AE  2ef606b40180 test   byte ptr cs:[0x1b4], 0x80
C000:12B4  7504         jne    0x12ba                
C000:12B6  b708         mov    bh, 8                 
C000:12B8  eb09         jmp    0x12c3                
C000:12BA  803e490413   cmp    byte ptr [0x449], 0x13
C000:12BF  7602         jbe    0x12c3                
C000:12C1  b708         mov    bh, 8                 
C000:12C3  0ae7         or     ah, bh                
C000:12C5  ef           out    dx, ax                
C000:12C6  e85201       call   0x141b                
C000:12C9  e87901       call   0x1445                
C000:12CC  e80902       call   0x14d8                
C000:12CF  e8af00       call   0x1381                
C000:12D2  8a0e4904     mov    cl, byte ptr [0x449]  
C000:12D6  e826fe       call   0x10ff                
C000:12D9  80ff00       cmp    bh, 0                 
C000:12DC  7514         jne    0x12f2                 ; "_ZY[X"
C000:12DE  bad603       mov    dx, 0x3d6             
C000:12E1  b402         mov    ah, 2                 
C000:12E3  80f90f       cmp    cl, 0xf               
C000:12E6  7407         je     0x12ef                
C000:12E8  80f910       cmp    cl, 0x10              
C000:12EB  7402         je     0x12ef                
C000:12ED  b404         mov    ah, 4                 
C000:12EF  b05a         mov    al, 0x5a              
C000:12F1  ef           out    dx, ax                
C000:12F2  5f           pop    di                    
C000:12F3  5a           pop    dx                    
C000:12F4  59           pop    cx                    
C000:12F5  5b           pop    bx                    
C000:12F6  58           pop    ax                    
C000:12F7  c3           ret                          

;----- sub_12F8 -----
C000:12F8  e83c01       call   0x1437                
C000:12FB  80e470       and    ah, 0x70              
C000:12FE  80fc20       cmp    ah, 0x20              
C000:1301  7527         jne    0x132a                
C000:1303  bace03       mov    dx, 0x3ce             
C000:1306  b80540       mov    ax, 0x4005            
C000:1309  ef           out    dx, ax                
C000:130A  8b166304     mov    dx, word ptr [0x463]  
C000:130E  b013         mov    al, 0x13              
C000:1310  ee           out    dx, al                
C000:1311  ed           in     ax, dx                
C000:1312  d0ec         shr    ah, 1                 
C000:1314  ef           out    dx, ax                
C000:1315  b80cff       mov    ax, 0xff0c            
C000:1318  ef           out    dx, ax                
C000:1319  b80dff       mov    ax, 0xff0d            
C000:131C  ef           out    dx, ax                
C000:131D  83c206       add    dx, 6                 
C000:1320  ec           in     al, dx                
C000:1321  bac003       mov    dx, 0x3c0             
C000:1324  b013         mov    al, 0x13              
C000:1326  ee           out    dx, al                
C000:1327  b007         mov    al, 7                 
C000:1329  ee           out    dx, al                
C000:132A  c3           ret                          

;----- sub_1347 -----
C000:1347  b057         mov    al, 0x57              
C000:1349  e8f30b       call   0x1f3f                
C000:134C  80e4fb       and    ah, 0xfb              
C000:134F  ef           out    dx, ax                
C000:1350  c3           ret                          

;----- sub_1351 -----
C000:1351  8a0e4904     mov    cl, byte ptr [0x449]  
C000:1355  80f960       cmp    cl, 0x60              
C000:1358  7226         jb     0x1380                
C000:135A  80f961       cmp    cl, 0x61              
C000:135D  7721         ja     0x1380                
C000:135F  8b166304     mov    dx, word ptr [0x463]  
C000:1363  b011         mov    al, 0x11              
C000:1365  e85a4a       call   0x5dc2                
C000:1368  80e47f       and    ah, 0x7f              
C000:136B  ef           out    dx, ax                
C000:136C  b8017f       mov    ax, 0x7f01            
C000:136F  e89af7       call   0xb0c                 
C000:1372  7502         jne    0x1376                
C000:1374  b483         mov    ah, 0x83              
C000:1376  ef           out    dx, ax                
C000:1377  b011         mov    al, 0x11              
C000:1379  e8464a       call   0x5dc2                
C000:137C  80cc80       or     ah, 0x80              
C000:137F  ef           out    dx, ax                
C000:1380  c3           ret                          

;----- sub_1381 -----
C000:1381  e81000       call   0x1394                
C000:1384  e885f7       call   0xb0c                 
C000:1387  740a         je     0x1393                
C000:1389  e80a1b       call   0x2e96                
C000:138C  a880         test   al, 0x80              
C000:138E  7503         jne    0x1393                
C000:1390  e865f8       call   0xbf8                 
C000:1393  c3           ret                          

;----- sub_1394 -----
C000:1394  e8a000       call   0x1437                
C000:1397  8afc         mov    bh, ah                
C000:1399  b006         mov    al, 6                 
C000:139B  e8a10b       call   0x1f3f                
C000:139E  80e4f3       and    ah, 0xf3              
C000:13A1  80cc04       or     ah, 4                 
C000:13A4  80ff40       cmp    bh, 0x40              
C000:13A7  7416         je     0x13bf                
C000:13A9  80cc0c       or     ah, 0xc               
C000:13AC  80ff41       cmp    bh, 0x41              
C000:13AF  740e         je     0x13bf                
C000:13B1  80e4f3       and    ah, 0xf3              
C000:13B4  80cc08       or     ah, 8                 
C000:13B7  80ff50       cmp    bh, 0x50              
C000:13BA  7403         je     0x13bf                
C000:13BC  80e4f3       and    ah, 0xf3              
C000:13BF  ef           out    dx, ax                
C000:13C0  80e40c       and    ah, 0xc               
C000:13C3  b300         mov    bl, 0                 
C000:13C5  80fc00       cmp    ah, 0                 
C000:13C8  741e         je     0x13e8                
C000:13CA  b310         mov    bl, 0x10              
C000:13CC  53           push   bx                    
C000:13CD  b01c         mov    al, 0x1c              
C000:13CF  e86d0b       call   0x1f3f                
C000:13D2  8adc         mov    bl, ah                
C000:13D4  fec3         inc    bl                    
C000:13D6  d0e4         shl    ah, 1                 
C000:13D8  fec4         inc    ah                    
C000:13DA  80ff50       cmp    bh, 0x50              
C000:13DD  7502         jne    0x13e1                
C000:13DF  02e3         add    ah, bl                
C000:13E1  e828f7       call   0xb0c                 
C000:13E4  7401         je     0x13e7                
C000:13E6  ef           out    dx, ax                
C000:13E7  5b           pop    bx                    
C000:13E8  b002         mov    al, 2                 
C000:13EA  ee           out    dx, al                
C000:13EB  ed           in     ax, dx                
C000:13EC  80e4fb       and    ah, 0xfb              
C000:13EF  80fb10       cmp    bl, 0x10              
C000:13F2  7503         jne    0x13f7                
C000:13F4  80cc04       or     ah, 4                 
C000:13F7  ef           out    dx, ax                
C000:13F8  b00f         mov    al, 0xf               
C000:13FA  ee           out    dx, al                
C000:13FB  ed           in     ax, dx                
C000:13FC  80e4ef       and    ah, 0xef              
C000:13FF  0ae3         or     ah, bl                
C000:1401  ef           out    dx, ax                
C000:1402  b81700       mov    ax, 0x17              
C000:1405  80ff50       cmp    bh, 0x50              
C000:1408  7502         jne    0x140c                
C000:140A  b401         mov    ah, 1                 
C000:140C  ef           out    dx, ax                
C000:140D  c3           ret                          

;----- sub_141B -----
C000:141B  e81900       call   0x1437                
C000:141E  8afc         mov    bh, ah                
C000:1420  b00b         mov    al, 0xb               
C000:1422  e81a0b       call   0x1f3f                
C000:1425  80e4ef       and    ah, 0xef              
C000:1428  80ff20       cmp    bh, 0x20              
C000:142B  7208         jb     0x1435                
C000:142D  80ff5f       cmp    bh, 0x5f              
C000:1430  7703         ja     0x1435                
C000:1432  80cc10       or     ah, 0x10              
C000:1435  ef           out    dx, ax                
C000:1436  c3           ret                          

;----- sub_1437 -----
C000:1437  1e           push   ds                    
C000:1438  33c0         xor    ax, ax                
C000:143A  8ed8         mov    ds, ax                
C000:143C  8a264904     mov    ah, byte ptr [0x449]  
C000:1440  80e47f       and    ah, 0x7f              
C000:1443  1f           pop    ds                    
C000:1444  c3           ret                          

;----- sub_1445 -----
C000:1445  2ef606c90120 test   byte ptr cs:[0x1c9], 0x20
C000:144B  7502         jne    0x144f                
C000:144D  eb42         jmp    0x1491                
C000:144F  e8baf6       call   0xb0c                 
C000:1452  743d         je     0x1491                
C000:1454  e8b11a       call   0x2f08                
C000:1457  2e8b4406     mov    ax, word ptr cs:[si + 6]
C000:145B  ef           out    dx, ax                
C000:145C  e8c4f6       call   0xb23                 
C000:145F  7530         jne    0x1491                
C000:1461  b90400       mov    cx, 4                 
C000:1464  e8db1a       call   0x2f42                
C000:1467  e82800       call   0x1492                
C000:146A  8af8         mov    bh, al                
C000:146C  bad603       mov    dx, 0x3d6             
C000:146F  b01b         mov    al, 0x1b              
C000:1471  e85349       call   0x5dc7                
C000:1474  b302         mov    bl, 2                 
C000:1476  80ec02       sub    ah, 2                 
C000:1479  80ff01       cmp    bh, 1                 
C000:147C  740a         je     0x1488                
C000:147E  80c404       add    ah, 4                 
C000:1481  80ff02       cmp    bh, 2                 
C000:1484  750b         jne    0x1491                
C000:1486  b301         mov    bl, 1                 
C000:1488  ef           out    dx, ax                
C000:1489  b019         mov    al, 0x19              
C000:148B  e83949       call   0x5dc7                
C000:148E  2ae3         sub    ah, bl                
C000:1490  ef           out    dx, ax                
C000:1491  c3           ret                          

;----- sub_1492 -----
C000:1492  b028         mov    al, 0x28              
C000:1494  e83049       call   0x5dc7                
C000:1497  b002         mov    al, 2                 
C000:1499  f6c410       test   ah, 0x10              
C000:149C  7539         jne    0x14d7                
C000:149E  e896ff       call   0x1437                
C000:14A1  b004         mov    al, 4                 
C000:14A3  80fc6a       cmp    ah, 0x6a              
C000:14A6  732f         jae    0x14d7                
C000:14A8  b001         mov    al, 1                 
C000:14AA  80fc0d       cmp    ah, 0xd               
C000:14AD  7428         je     0x14d7                
C000:14AF  b001         mov    al, 1                 
C000:14B1  80fc04       cmp    ah, 4                 
C000:14B4  7421         je     0x14d7                
C000:14B6  80fc05       cmp    ah, 5                 
C000:14B9  741c         je     0x14d7                
C000:14BB  80fc01       cmp    ah, 1                 
C000:14BE  7617         jbe    0x14d7                
C000:14C0  b004         mov    al, 4                 
C000:14C2  80fc06       cmp    ah, 6                 
C000:14C5  7410         je     0x14d7                
C000:14C7  b000         mov    al, 0                 
C000:14C9  80fc0e       cmp    ah, 0xe                ; "VIDEO "
C000:14CC  7209         jb     0x14d7                
C000:14CE  b000         mov    al, 0                 
C000:14D0  80fc13       cmp    ah, 0x13              
C000:14D3  7702         ja     0x14d7                
C000:14D5  b004         mov    al, 4                 
C000:14D7  c3           ret                          

;----- sub_14D8 -----
C000:14D8  2ef606c90110 test   byte ptr cs:[0x1c9], 0x10
C000:14DE  7418         je     0x14f8                
C000:14E0  e8afff       call   0x1492                
C000:14E3  b451         mov    ah, 0x51              
C000:14E5  3c01         cmp    al, 1                 
C000:14E7  7509         jne    0x14f2                
C000:14E9  b455         mov    ah, 0x55              
C000:14EB  e835f6       call   0xb23                 
C000:14EE  7502         jne    0x14f2                
C000:14F0  b453         mov    ah, 0x53              
C000:14F2  bad603       mov    dx, 0x3d6             
C000:14F5  b02d         mov    al, 0x2d              
C000:14F7  ef           out    dx, ax                
C000:14F8  c3           ret                          

;----- sub_14F9 -----
C000:14F9  56           push   si                    
C000:14FA  50           push   ax                    
C000:14FB  53           push   bx                    
C000:14FC  e838ff       call   0x1437                
C000:14FF  8bd8         mov    bx, ax                
C000:1501  8acc         mov    cl, ah                
C000:1503  bebd01       mov    si, 0x1bd             
C000:1506  2e8a0c       mov    cl, byte ptr cs:[si]  
C000:1509  2e8a6c01     mov    ch, byte ptr cs:[si + 1]
C000:150D  e813f6       call   0xb23                 
C000:1510  7508         jne    0x151a                
C000:1512  2e8a4c02     mov    cl, byte ptr cs:[si + 2]
C000:1516  2e8a6c03     mov    ch, byte ptr cs:[si + 3]
C000:151A  e8290a       call   0x1f46                
C000:151D  f6c410       test   ah, 0x10              
C000:1520  742f         je     0x1551                
C000:1522  2e8a4c04     mov    cl, byte ptr cs:[si + 4]
C000:1526  2e8a6c06     mov    ch, byte ptr cs:[si + 6]
C000:152A  80ff50       cmp    bh, 0x50              
C000:152D  7508         jne    0x1537                
C000:152F  2e8a4c07     mov    cl, byte ptr cs:[si + 7]
C000:1533  2e8a6c09     mov    ch, byte ptr cs:[si + 9]
C000:1537  e8e9f5       call   0xb23                 
C000:153A  7515         jne    0x1551                
C000:153C  2e8a4c05     mov    cl, byte ptr cs:[si + 5]
C000:1540  2e8a6c06     mov    ch, byte ptr cs:[si + 6]
C000:1544  80ff50       cmp    bh, 0x50              
C000:1547  7508         jne    0x1551                
C000:1549  2e8a4c08     mov    cl, byte ptr cs:[si + 8]
C000:154D  2e8a6c09     mov    ch, byte ptr cs:[si + 9]
C000:1551  eb00         jmp    0x1553                
C000:1553  e85e19       call   0x2eb4                
C000:1556  750f         jne    0x1567                
C000:1558  2e8a2e4f02   mov    ch, byte ptr cs:[0x24f]
C000:155D  e8c3f5       call   0xb23                 
C000:1560  7405         je     0x1567                
C000:1562  2e8a0e4e02   mov    cl, byte ptr cs:[0x24e]
C000:1567  5b           pop    bx                    
C000:1568  58           pop    ax                    
C000:1569  5e           pop    si                    
C000:156A  c3           ret                          

;----- sub_156B -----
C000:156B  e89ef5       call   0xb0c                 
C000:156E  7555         jne    0x15c5                
C000:1570  53           push   bx                    
C000:1571  52           push   dx                    
C000:1572  50           push   ax                    
C000:1573  50           push   ax                    
C000:1574  51           push   cx                    
C000:1575  8ac8         mov    cl, al                
C000:1577  59           pop    cx                    
C000:1578  58           pop    ax                    
C000:1579  2e8a1eb701   mov    bl, byte ptr cs:[0x1b7]
C000:157E  3c13         cmp    al, 0x13              
C000:1580  760f         jbe    0x1591                
C000:1582  2e8a1eb901   mov    bl, byte ptr cs:[0x1b9]
C000:1587  e83719       call   0x2ec1                
C000:158A  7405         je     0x1591                
C000:158C  2e8a1eb801   mov    bl, byte ptr cs:[0x1b8]
C000:1591  3c50         cmp    al, 0x50              
C000:1593  7505         jne    0x159a                
C000:1595  2e8a1eca01   mov    bl, byte ptr cs:[0x1ca]
C000:159A  e81719       call   0x2eb4                
C000:159D  7505         jne    0x15a4                
C000:159F  2e8a1e4f02   mov    bl, byte ptr cs:[0x24f]
C000:15A4  b703         mov    bh, 3                 
C000:15A6  ba0000       mov    dx, 0                 
C000:15A9  e81a00       call   0x15c6                
C000:15AC  58           pop    ax                    
C000:15AD  3c13         cmp    al, 0x13              
C000:15AF  7612         jbe    0x15c3                
C000:15B1  e84101       call   0x16f5                
C000:15B4  750d         jne    0x15c3                
C000:15B6  ba0000       mov    dx, 0                 
C000:15B9  2e8a9d1c0a   mov    bl, byte ptr cs:[di + 0xa1c]
C000:15BE  b702         mov    bh, 2                 
C000:15C0  e80300       call   0x15c6                
C000:15C3  5a           pop    dx                    
C000:15C4  5b           pop    bx                    
C000:15C5  c3           ret                          

;----- sub_15C6 -----
C000:15C6  50           push   ax                    
C000:15C7  e8cc18       call   0x2e96                
C000:15CA  a840         test   al, 0x40              
C000:15CC  58           pop    ax                    
C000:15CD  754f         jne    0x161e                
C000:15CF  50           push   ax                    
C000:15D0  53           push   bx                    
C000:15D1  51           push   cx                    
C000:15D2  57           push   di                    
C000:15D3  56           push   si                    
C000:15D4  8bf3         mov    si, bx                
C000:15D6  b103         mov    cl, 3                 
C000:15D8  80fb18       cmp    bl, 0x18              
C000:15DB  7302         jae    0x15df                
C000:15DD  b105         mov    cl, 5                 
C000:15DF  51           push   cx                    
C000:15E0  bf6b16       mov    di, 0x166b            
C000:15E3  8bcb         mov    cx, bx                
C000:15E5  32ed         xor    ch, ch                
C000:15E7  83e90c       sub    cx, 0xc               
C000:15EA  03f9         add    di, cx                
C000:15EC  2e8a1d       mov    bl, byte ptr cs:[di]  
C000:15EF  bfb016       mov    di, 0x16b0            
C000:15F2  03f9         add    di, cx                
C000:15F4  2e8a3d       mov    bh, byte ptr cs:[di]  
C000:15F7  59           pop    cx                    
C000:15F8  e82400       call   0x161f                
C000:15FB  5e           pop    si                    
C000:15FC  5f           pop    di                    
C000:15FD  59           pop    cx                    
C000:15FE  5b           pop    bx                    
C000:15FF  b004         mov    al, 4                 
C000:1601  e83b09       call   0x1f3f                
C000:1604  80e4df       and    ah, 0xdf              
C000:1607  50           push   ax                    
C000:1608  e8aff7       call   0xdba                 
C000:160B  bad603       mov    dx, 0x3d6             
C000:160E  58           pop    ax                    
C000:160F  7408         je     0x1619                
C000:1611  80fb41       cmp    bl, 0x41              
C000:1614  7703         ja     0x1619                
C000:1616  80cc20       or     ah, 0x20              
C000:1619  ef           out    dx, ax                
C000:161A  e8acf7       call   0xdc9                 
C000:161D  58           pop    ax                    
C000:161E  c3           ret                          

;----- sub_161F -----
C000:161F  bad603       mov    dx, 0x3d6             
C000:1622  8bc6         mov    ax, si                
C000:1624  8aec         mov    ch, ah                
C000:1626  b033         mov    al, 0x33              
C000:1628  ee           out    dx, al                
C000:1629  ed           in     ax, dx                
C000:162A  80e4df       and    ah, 0xdf              
C000:162D  80fd03       cmp    ch, 3                 
C000:1630  7503         jne    0x1635                
C000:1632  80cc20       or     ah, 0x20              
C000:1635  ef           out    dx, ax                
C000:1636  b030         mov    al, 0x30              
C000:1638  8ae1         mov    ah, cl                
C000:163A  ef           out    dx, ax                
C000:163B  fec0         inc    al                    
C000:163D  80eb02       sub    bl, 2                 
C000:1640  8ae3         mov    ah, bl                
C000:1642  ef           out    dx, ax                
C000:1643  fec0         inc    al                    
C000:1645  80ef02       sub    bh, 2                 
C000:1648  8ae7         mov    ah, bh                
C000:164A  ef           out    dx, ax                
C000:164B  b91900       mov    cx, 0x19              
C000:164E  32c0         xor    al, al                
C000:1650  e8a147       call   0x5df4                
C000:1653  e8b6f4       call   0xb0c                 
C000:1656  7412         je     0x166a                
C000:1658  8bde         mov    bx, si                
C000:165A  b702         mov    bh, 2                 
C000:165C  750c         jne    0x166a                
C000:165E  b054         mov    al, 0x54              
C000:1660  e8dc08       call   0x1f3f                
C000:1663  80e4f3       and    ah, 0xf3              
C000:1666  80cc08       or     ah, 8                 
C000:1669  ef           out    dx, ax                
C000:166A  c3           ret                          

;----- sub_16F5 -----
C000:16F5  fc           cld                          
C000:16F6  06           push   es                    
C000:16F7  51           push   cx                    
C000:16F8  0ac0         or     al, al                
C000:16FA  7420         je     0x171c                
C000:16FC  8ccf         mov    di, cs                
C000:16FE  8ec7         mov    es, di                
C000:1700  32ed         xor    ch, ch                
C000:1702  bf150a       mov    di, 0xa15              ; " "0jxy"
C000:1705  2e8a0e140a   mov    cl, byte ptr cs:[0xa14]
C000:170A  f2ae         repne scasb al, byte ptr es:[di]  
C000:170C  750b         jne    0x1719                
C000:170E  81ef160a     sub    di, 0xa16             
C000:1712  d1e7         shl    di, 1                 
C000:1714  d1e7         shl    di, 1                 
C000:1716  e8a907       call   0x1ec2                
C000:1719  59           pop    cx                    
C000:171A  07           pop    es                    
C000:171B  c3           ret                          
C000:171C  80c9ff       or     cl, 0xff              
C000:171F  ebf8         jmp    0x1719                

;----- sub_1721 -----
C000:1721  57           push   di                    
C000:1722  e8d0ff       call   0x16f5                
C000:1725  7505         jne    0x172c                
C000:1727  2e8a851b0a   mov    al, byte ptr cs:[di + 0xa1b]
C000:172C  5f           pop    di                    
C000:172D  c3           ret                          

;----- sub_172E -----
C000:172E  57           push   di                    
C000:172F  e8c3ff       call   0x16f5                
C000:1732  2e8bb51d0a   mov    si, word ptr cs:[di + 0xa1d]
C000:1737  5f           pop    di                    
C000:1738  c3           ret                          

;----- sub_1770 -----
C000:1770  50           push   ax                    
C000:1771  53           push   bx                    
C000:1772  52           push   dx                    
C000:1773  8ad8         mov    bl, al                
C000:1775  bad603       mov    dx, 0x3d6             
C000:1778  b010         mov    al, 0x10              
C000:177A  e83146       call   0x5dae                
C000:177D  886602       mov    byte ptr [bp + 2], ah 
C000:1780  e82b46       call   0x5dae                
C000:1783  886603       mov    byte ptr [bp + 3], ah 
C000:1786  b00b         mov    al, 0xb               
C000:1788  e83746       call   0x5dc2                
C000:178B  886601       mov    byte ptr [bp + 1], ah 
C000:178E  80e4fd       and    ah, 0xfd              
C000:1791  f6c304       test   bl, 4                 
C000:1794  7403         je     0x1799                
C000:1796  80cc04       or     ah, 4                 
C000:1799  ef           out    dx, ax                
C000:179A  5a           pop    dx                    
C000:179B  5b           pop    bx                    
C000:179C  9d           popf                         
C000:179D  c3           ret                          

;----- sub_179E -----
C000:179E  50           push   ax                    
C000:179F  52           push   dx                    
C000:17A0  bad603       mov    dx, 0x3d6             
C000:17A3  b00b         mov    al, 0xb               
C000:17A5  8a6601       mov    ah, byte ptr [bp + 1] 
C000:17A8  ef           out    dx, ax                
C000:17A9  b010         mov    al, 0x10              
C000:17AB  8a6602       mov    ah, byte ptr [bp + 2] 
C000:17AE  ef           out    dx, ax                
C000:17AF  b011         mov    al, 0x11              
C000:17B1  8a6603       mov    ah, byte ptr [bp + 3] 
C000:17B4  ef           out    dx, ax                
C000:17B5  5a           pop    dx                    
C000:17B6  58           pop    ax                    
C000:17B7  c3           ret                          
C000:1822  9c           pushf                        
C000:1823  58           pop    ax                    
C000:1824  8bd8         mov    bx, ax                
C000:1826  83ec04       sub    sp, 4                 
C000:1829  8bec         mov    bp, sp                
C000:182B  e842ff       call   0x1770                
C000:182E  83ec08       sub    sp, 8                 
C000:1831  8bc1         mov    ax, cx                
C000:1833  2bd1         sub    dx, cx                
C000:1835  fec6         inc    dh                    
C000:1837  fec2         inc    dl                    
C000:1839  b90010       mov    cx, 0x1000            
C000:183C  53           push   bx                    
C000:183D  9d           popf                         
C000:183E  7b03         jnp    0x1843                
C000:1840  b90304       mov    cx, 0x403             
C000:1843  884ef9       mov    byte ptr [bp - 7], cl 
C000:1846  886ef8       mov    byte ptr [bp - 8], ch 
C000:1849  32ed         xor    ch, ch                
C000:184B  e85304       call   0x1ca1                
C000:184E  b800a8       mov    ax, 0xa800            
C000:1851  8ec0         mov    es, ax                
C000:1853  8bfe         mov    di, si                
C000:1855  52           push   dx                    
C000:1856  53           push   bx                    
C000:1857  8b1e4a04     mov    bx, word ptr [0x44a]  
C000:185B  8a4604       mov    al, byte ptr [bp + 4] 
C000:185E  f6e3         mul    bl                    
C000:1860  f7268504     mul    word ptr [0x485]      
C000:1864  e30c         jcxz   0x1872                
C000:1866  d1e0         shl    ax, 1                 
C000:1868  d0d2         rcl    dl, 1                 
C000:186A  d1e0         shl    ax, 1                 
C000:186C  d0d2         rcl    dl, 1                 
C000:186E  d1e0         shl    ax, 1                 
C000:1870  d0d2         rcl    dl, 1                 
C000:1872  807e0507     cmp    byte ptr [bp + 5], 7  
C000:1876  7509         jne    0x1881                
C000:1878  2bf0         sub    si, ax                
C000:187A  80d200       adc    dl, 0                 
C000:187D  f6da         neg    dl                    
C000:187F  eb05         jmp    0x1886                
C000:1881  03f0         add    si, ax                
C000:1883  80d200       adc    dl, 0                 
C000:1886  0ac9         or     cl, cl                
C000:1888  7504         jne    0x188e                
C000:188A  d0e2         shl    dl, 1                 
C000:188C  d0e2         shl    dl, 1                 
C000:188E  d0e2         shl    dl, 1                 
C000:1890  d0e2         shl    dl, 1                 
C000:1892  d0e2         shl    dl, 1                 
C000:1894  d0e2         shl    dl, 1                 
C000:1896  58           pop    ax                    
C000:1897  8ae0         mov    ah, al                
C000:1899  02c2         add    al, dl                
C000:189B  8bd6         mov    dx, si                
C000:189D  d1c2         rol    dx, 1                 
C000:189F  d1c2         rol    dx, 1                 
C000:18A1  d1c2         rol    dx, 1                 
C000:18A3  d1c2         rol    dx, 1                 
C000:18A5  80e20f       and    dl, 0xf               
C000:18A8  0ac9         or     cl, cl                
C000:18AA  7504         jne    0x18b0                
C000:18AC  d0e2         shl    dl, 1                 
C000:18AE  d0e2         shl    dl, 1                 
C000:18B0  02c2         add    al, dl                
C000:18B2  81e6ff0f     and    si, 0xfff             
C000:18B6  5a           pop    dx                    
C000:18B7  2ada         sub    bl, dl                
C000:18B9  80df00       sbb    bh, 0                 
C000:18BC  d3e3         shl    bx, cl                
C000:18BE  52           push   dx                    
C000:18BF  8aee         mov    ch, dh                
C000:18C1  32f6         xor    dh, dh                
C000:18C3  d3e2         shl    dx, cl                
C000:18C5  895efe       mov    word ptr [bp - 2], bx 
C000:18C8  8956fc       mov    word ptr [bp - 4], dx 
C000:18CB  8bd8         mov    bx, ax                
C000:18CD  58           pop    ax                    
C000:18CE  807e0400     cmp    byte ptr [bp + 4], 0  
C000:18D2  7405         je     0x18d9                
C000:18D4  2a6e04       sub    ch, byte ptr [bp + 4] 
C000:18D7  7706         ja     0x18df                
C000:18D9  886604       mov    byte ptr [bp + 4], ah 
C000:18DC  e90201       jmp    0x19e1                
C000:18DF  8ac5         mov    al, ch                
C000:18E1  f6268504     mul    byte ptr [0x485]      
C000:18E5  8946fa       mov    word ptr [bp - 6], ax 
C000:18E8  ba0b07       mov    dx, 0x70b             
C000:18EB  807ef900     cmp    byte ptr [bp - 7], 0  
C000:18EF  7512         jne    0x1903                
C000:18F1  b80501       mov    ax, 0x105             
C000:18F4  52           push   dx                    
C000:18F5  bace03       mov    dx, 0x3ce             
C000:18F8  ef           out    dx, ax                
C000:18F9  b8020f       mov    ax, 0xf02             
C000:18FC  bac403       mov    dx, 0x3c4             
C000:18FF  ef           out    dx, ax                
C000:1900  5a           pop    dx                    
C000:1901  b603         mov    dh, 3                 
C000:1903  8bc2         mov    ax, dx                
C000:1905  bad603       mov    dx, 0x3d6             
C000:1908  ef           out    dx, ax                
C000:1909  e87804       call   0x1d84                
C000:190C  a08504       mov    al, byte ptr [0x485]  
C000:190F  8ae0         mov    ah, al                
C000:1911  ba00a0       mov    dx, 0xa000            
C000:1914  8eda         mov    ds, dx                
C000:1916  807e0507     cmp    byte ptr [bp + 5], 7  
C000:191A  7511         jne    0x192d                
C000:191C  32e4         xor    ah, ah                
C000:191E  0146fa       add    word ptr [bp - 6], ax 
C000:1921  fd           std                          
C000:1922  807ef900     cmp    byte ptr [bp - 7], 0  
C000:1926  7473         je     0x199b                
C000:1928  ff46fe       inc    word ptr [bp - 2]     
C000:192B  eb6e         jmp    0x199b                
C000:192D  8b4efc       mov    cx, word ptr [bp - 4] 
C000:1930  807ef900     cmp    byte ptr [bp - 7], 0  
C000:1934  7406         je     0x193c                
C000:1936  d1e9         shr    cx, 1                 
C000:1938  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:193A  d1d1         rcl    cx, 1                 
C000:193C  f3a4         rep movsb byte ptr es:[di], byte ptr [si]
C000:193E  0376fe       add    si, word ptr [bp - 2] 
C000:1941  037efe       add    di, word ptr [bp - 2] 
C000:1944  fecc         dec    ah                    
C000:1946  75e5         jne    0x192d                
C000:1948  ba0040       mov    dx, 0x4000            
C000:194B  85f2         test   dx, si                
C000:194D  7405         je     0x1954                
C000:194F  2bf2         sub    si, dx                
C000:1951  025ef8       add    bl, byte ptr [bp - 8] 
C000:1954  85fa         test   dx, di                
C000:1956  7405         je     0x195d                
C000:1958  2bfa         sub    di, dx                
C000:195A  027ef8       add    bh, byte ptr [bp - 8] 
C000:195D  2946fa       sub    word ptr [bp - 6], ax 
C000:1960  7662         jbe    0x19c4                
C000:1962  8ae0         mov    ah, al                
C000:1964  e81d04       call   0x1d84                
C000:1967  ebc4         jmp    0x192d                
C000:1969  807ef900     cmp    byte ptr [bp - 7], 0  
C000:196D  741d         je     0x198c                
C000:196F  4e           dec    si                    
C000:1970  4f           dec    di                    
C000:1971  8b4efc       mov    cx, word ptr [bp - 4] 
C000:1974  d1e9         shr    cx, 1                 
C000:1976  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:1978  d1d1         rcl    cx, 1                 
C000:197A  46           inc    si                    
C000:197B  47           inc    di                    
C000:197C  f3a4         rep movsb byte ptr es:[di], byte ptr [si]
C000:197E  2b76fe       sub    si, word ptr [bp - 2] 
C000:1981  2b7efe       sub    di, word ptr [bp - 2] 
C000:1984  fecc         dec    ah                    
C000:1986  75e9         jne    0x1971                
C000:1988  46           inc    si                    
C000:1989  47           inc    di                    
C000:198A  eb0f         jmp    0x199b                
C000:198C  8b4efc       mov    cx, word ptr [bp - 4] 
C000:198F  f3a4         rep movsb byte ptr es:[di], byte ptr [si]
C000:1991  2b76fe       sub    si, word ptr [bp - 2] 
C000:1994  2b7efe       sub    di, word ptr [bp - 2] 
C000:1997  fecc         dec    ah                    
C000:1999  75f1         jne    0x198c                
C000:199B  ba0040       mov    dx, 0x4000            
C000:199E  85f2         test   dx, si                
C000:19A0  7509         jne    0x19ab                
C000:19A2  0adb         or     bl, bl                
C000:19A4  7405         je     0x19ab                
C000:19A6  03f2         add    si, dx                
C000:19A8  2a5ef8       sub    bl, byte ptr [bp - 8] 
C000:19AB  85fa         test   dx, di                
C000:19AD  7509         jne    0x19b8                
C000:19AF  0aff         or     bh, bh                
C000:19B1  7405         je     0x19b8                
C000:19B3  03fa         add    di, dx                
C000:19B5  2a7ef8       sub    bh, byte ptr [bp - 8] 
C000:19B8  2946fa       sub    word ptr [bp - 6], ax 
C000:19BB  7607         jbe    0x19c4                
C000:19BD  8ae0         mov    ah, al                
C000:19BF  e8c203       call   0x1d84                
C000:19C2  eba5         jmp    0x1969                
C000:19C4  2e8e1e9032   mov    ds, word ptr cs:[0x3290]
C000:19C9  807ef900     cmp    byte ptr [bp - 7], 0  
C000:19CD  740b         je     0x19da                
C000:19CF  807e0507     cmp    byte ptr [bp + 5], 7  
C000:19D3  752d         jne    0x1a02                
C000:19D5  ff4efe       dec    word ptr [bp - 2]     
C000:19D8  eb28         jmp    0x1a02                
C000:19DA  b80500       mov    ax, 5                 
C000:19DD  bace03       mov    dx, 0x3ce             
C000:19E0  ef           out    dx, ax                
C000:19E1  ba0b07       mov    dx, 0x70b             
C000:19E4  807ef900     cmp    byte ptr [bp - 7], 0  
C000:19E8  7518         jne    0x1a02                
C000:19EA  b8020f       mov    ax, 0xf02             
C000:19ED  52           push   dx                    
C000:19EE  bac403       mov    dx, 0x3c4             
C000:19F1  ef           out    dx, ax                
C000:19F2  bace03       mov    dx, 0x3ce             
C000:19F5  8a6607       mov    ah, byte ptr [bp + 7] 
C000:19F8  32c0         xor    al, al                
C000:19FA  ef           out    dx, ax                
C000:19FB  b8010f       mov    ax, 0xf01             
C000:19FE  ef           out    dx, ax                
C000:19FF  5a           pop    dx                    
C000:1A00  b603         mov    dh, 3                 
C000:1A02  8bc2         mov    ax, dx                
C000:1A04  bad603       mov    dx, 0x3d6             
C000:1A07  ef           out    dx, ax                
C000:1A08  8a4604       mov    al, byte ptr [bp + 4] 
C000:1A0B  8a168504     mov    dl, byte ptr [0x485]  
C000:1A0F  f6e2         mul    dl                    
C000:1A11  8946fa       mov    word ptr [bp - 6], ax 
C000:1A14  8af2         mov    dh, dl                
C000:1A16  8a4607       mov    al, byte ptr [bp + 7] 
C000:1A19  8ae0         mov    ah, al                
C000:1A1B  e86603       call   0x1d84                
C000:1A1E  807e0507     cmp    byte ptr [bp + 5], 7  
C000:1A22  750b         jne    0x1a2f                
C000:1A24  32f6         xor    dh, dh                
C000:1A26  0156fa       add    word ptr [bp - 6], dx 
C000:1A29  ff46fe       inc    word ptr [bp - 2]     
C000:1A2C  fd           std                          
C000:1A2D  eb3f         jmp    0x1a6e                
C000:1A2F  8b4efc       mov    cx, word ptr [bp - 4] 
C000:1A32  d1e9         shr    cx, 1                 
C000:1A34  f3ab         rep stosw word ptr es:[di], ax  
C000:1A36  d1d1         rcl    cx, 1                 
C000:1A38  f3aa         rep stosb byte ptr es:[di], al  
C000:1A3A  037efe       add    di, word ptr [bp - 2] 
C000:1A3D  fece         dec    dh                    
C000:1A3F  75ee         jne    0x1a2f                
C000:1A41  be0040       mov    si, 0x4000            
C000:1A44  85fe         test   si, di                
C000:1A46  7405         je     0x1a4d                
C000:1A48  2bfe         sub    di, si                
C000:1A4A  027ef8       add    bh, byte ptr [bp - 8] 
C000:1A4D  2956fa       sub    word ptr [bp - 6], dx 
C000:1A50  7638         jbe    0x1a8a                
C000:1A52  8af2         mov    dh, dl                
C000:1A54  e82d03       call   0x1d84                
C000:1A57  ebd6         jmp    0x1a2f                
C000:1A59  4f           dec    di                    
C000:1A5A  8b4efc       mov    cx, word ptr [bp - 4] 
C000:1A5D  d1e9         shr    cx, 1                 
C000:1A5F  f3ab         rep stosw word ptr es:[di], ax  
C000:1A61  d1d1         rcl    cx, 1                 
C000:1A63  47           inc    di                    
C000:1A64  f3aa         rep stosb byte ptr es:[di], al  
C000:1A66  2b7efe       sub    di, word ptr [bp - 2] 
C000:1A69  fece         dec    dh                    
C000:1A6B  75ed         jne    0x1a5a                
C000:1A6D  47           inc    di                    
C000:1A6E  be0040       mov    si, 0x4000            
C000:1A71  85fe         test   si, di                
C000:1A73  7509         jne    0x1a7e                
C000:1A75  0aff         or     bh, bh                
C000:1A77  7405         je     0x1a7e                
C000:1A79  03fe         add    di, si                
C000:1A7B  2a7ef8       sub    bh, byte ptr [bp - 8] 
C000:1A7E  2956fa       sub    word ptr [bp - 6], dx 
C000:1A81  7607         jbe    0x1a8a                
C000:1A83  8af2         mov    dh, dl                
C000:1A85  e8fc02       call   0x1d84                
C000:1A88  ebcf         jmp    0x1a59                
C000:1A8A  807ef900     cmp    byte ptr [bp - 7], 0  
C000:1A8E  7507         jne    0x1a97                
C000:1A90  bace03       mov    dx, 0x3ce             
C000:1A93  b80100       mov    ax, 1                 
C000:1A96  ef           out    dx, ax                
C000:1A97  83c408       add    sp, 8                 
C000:1A9A  e801fd       call   0x179e                
C000:1A9D  83c408       add    sp, 8                 
C000:1AA0  c3           ret                          
C000:1AA1  e8ae03       call   0x1e52                
C000:1AA4  735b         jae    0x1b01                
C000:1AA6  7556         jne    0x1afe                
C000:1AA8  56           push   si                    
C000:1AA9  53           push   bx                    
C000:1AAA  51           push   cx                    
C000:1AAB  52           push   dx                    
C000:1AAC  55           push   bp                    
C000:1AAD  9c           pushf                        
C000:1AAE  58           pop    ax                    
C000:1AAF  83ec04       sub    sp, 4                 
C000:1AB2  8bec         mov    bp, sp                
C000:1AB4  e8b9fc       call   0x1770                
C000:1AB7  7a39         jp     0x1af2                
C000:1AB9  8bd9         mov    bx, cx                
C000:1ABB  e87f02       call   0x1d3d                
C000:1ABE  8bf3         mov    si, bx                
C000:1AC0  80e107       and    cl, 7                 
C000:1AC3  b380         mov    bl, 0x80              
C000:1AC5  d2eb         shr    bl, cl                
C000:1AC7  b800a0       mov    ax, 0xa000            
C000:1ACA  8ed8         mov    ds, ax                
C000:1ACC  bace03       mov    dx, 0x3ce             
C000:1ACF  32c9         xor    cl, cl                
C000:1AD1  b80403       mov    ax, 0x304             
C000:1AD4  ef           out    dx, ax                
C000:1AD5  8a2c         mov    ch, byte ptr [si]     
C000:1AD7  22eb         and    ch, bl                
C000:1AD9  f6dd         neg    ch                    
C000:1ADB  d1c1         rol    cx, 1                 
C000:1ADD  fecc         dec    ah                    
C000:1ADF  79f3         jns    0x1ad4                
C000:1AE1  8ac1         mov    al, cl                
C000:1AE3  e8b8fc       call   0x179e                
C000:1AE6  83c404       add    sp, 4                 
C000:1AE9  5d           pop    bp                    
C000:1AEA  b40d         mov    ah, 0xd               
C000:1AEC  5a           pop    dx                    
C000:1AED  59           pop    cx                    
C000:1AEE  5b           pop    bx                    
C000:1AEF  5e           pop    si                    
C000:1AF0  1f           pop    ds                    
C000:1AF1  cf           iret                         
C000:1AF2  e81602       call   0x1d0b                
C000:1AF5  b800a0       mov    ax, 0xa000            
C000:1AF8  8ed8         mov    ds, ax                
C000:1AFA  8a07         mov    al, byte ptr [bx]     
C000:1AFC  ebe5         jmp    0x1ae3                
C000:1AFE  e9d932       jmp    0x4dda                 ; "VSQR"
C000:1B01  b40d         mov    ah, 0xd               
C000:1B03  1f           pop    ds                    
C000:1B04  cf           iret                         
C000:1B05  e84a03       call   0x1e52                
C000:1B08  7364         jae    0x1b6e                
C000:1B0A  755f         jne    0x1b6b                
C000:1B0C  53           push   bx                    
C000:1B0D  51           push   cx                    
C000:1B0E  52           push   dx                    
C000:1B0F  55           push   bp                    
C000:1B10  8bd8         mov    bx, ax                
C000:1B12  9c           pushf                        
C000:1B13  58           pop    ax                    
C000:1B14  83ec04       sub    sp, 4                 
C000:1B17  8bec         mov    bp, sp                
C000:1B19  e854fc       call   0x1770                
C000:1B1C  8bc3         mov    ax, bx                
C000:1B1E  b700         mov    bh, 0                 
C000:1B20  7a50         jp     0x1b72                
C000:1B22  8bd9         mov    bx, cx                
C000:1B24  8ae8         mov    ch, al                
C000:1B26  e81402       call   0x1d3d                
C000:1B29  bace03       mov    dx, 0x3ce             
C000:1B2C  33c0         xor    ax, ax                
C000:1B2E  ef           out    dx, ax                
C000:1B2F  b8010f       mov    ax, 0xf01             
C000:1B32  ef           out    dx, ax                
C000:1B33  80e107       and    cl, 7                 
C000:1B36  b80880       mov    ax, 0x8008            
C000:1B39  d2ec         shr    ah, cl                
C000:1B3B  ef           out    dx, ax                
C000:1B3C  b800a0       mov    ax, 0xa000            
C000:1B3F  8ed8         mov    ds, ax                
C000:1B41  0aed         or     ch, ch                
C000:1B43  7815         js     0x1b5a                
C000:1B45  0807         or     byte ptr [bx], al     
C000:1B47  8ae5         mov    ah, ch                
C000:1B49  ef           out    dx, ax                
C000:1B4A  0807         or     byte ptr [bx], al     
C000:1B4C  b808ff       mov    ax, 0xff08            
C000:1B4F  ef           out    dx, ax                
C000:1B50  33c0         xor    ax, ax                
C000:1B52  ef           out    dx, ax                
C000:1B53  fec0         inc    al                    
C000:1B55  ef           out    dx, ax                
C000:1B56  8ac5         mov    al, ch                
C000:1B58  eb24         jmp    0x1b7e                
C000:1B5A  b80318       mov    ax, 0x1803            
C000:1B5D  ef           out    dx, ax                
C000:1B5E  8ae5         mov    ah, ch                
C000:1B60  32c0         xor    al, al                
C000:1B62  ef           out    dx, ax                
C000:1B63  0807         or     byte ptr [bx], al     
C000:1B65  b80300       mov    ax, 3                 
C000:1B68  ef           out    dx, ax                
C000:1B69  ebe1         jmp    0x1b4c                
C000:1B6B  e9a031       jmp    0x4d0e                
C000:1B6E  b40c         mov    ah, 0xc               
C000:1B70  1f           pop    ds                    
C000:1B71  cf           iret                         
C000:1B72  50           push   ax                    
C000:1B73  e89501       call   0x1d0b                
C000:1B76  b800a0       mov    ax, 0xa000            
C000:1B79  8ed8         mov    ds, ax                
C000:1B7B  58           pop    ax                    
C000:1B7C  8807         mov    byte ptr [bx], al     
C000:1B7E  e81dfc       call   0x179e                
C000:1B81  83c404       add    sp, 4                 
C000:1B84  5d           pop    bp                    
C000:1B85  b40c         mov    ah, 0xc               
C000:1B87  5a           pop    dx                    
C000:1B88  59           pop    cx                    
C000:1B89  5b           pop    bx                    
C000:1B8A  1f           pop    ds                    
C000:1B8B  cf           iret                         
C000:1B8C  e8c302       call   0x1e52                
C000:1B8F  7212         jb     0x1ba3                
C000:1B91  b403         mov    ah, 3                 
C000:1B93  e9c42d       jmp    0x495a                
C000:1BA0  e9db2e       jmp    0x4a7e                
C000:1BA3  75fb         jne    0x1ba0                
C000:1BA5  55           push   bp                    
C000:1BA6  8af8         mov    bh, al                
C000:1BA8  9c           pushf                        
C000:1BA9  58           pop    ax                    
C000:1BAA  83ec04       sub    sp, 4                 
C000:1BAD  8bec         mov    bp, sp                
C000:1BAF  e8befb       call   0x1770                
C000:1BB2  8ac7         mov    al, bh                
C000:1BB4  b700         mov    bh, 0                 
C000:1BB6  7a26         jp     0x1bde                
C000:1BB8  32e4         xor    ah, ah                
C000:1BBA  80ccba       or     ah, 0xba              
C000:1BBD  bed41b       mov    si, 0x1bd4            
C000:1BC0  56           push   si                    
C000:1BC1  50           push   ax                    
C000:1BC2  8be9         mov    bp, cx                
C000:1BC4  8ad3         mov    dl, bl                
C000:1BC6  33c9         xor    cx, cx                
C000:1BC8  e82b01       call   0x1cf6                
C000:1BCB  e8a901       call   0x1d77                
C000:1BCE  8bfe         mov    di, si                
C000:1BD0  5e           pop    si                    
C000:1BD1  e9dd2e       jmp    0x4ab1                
C000:1BDE  83ec04       sub    sp, 4                 
C000:1BE1  8bec         mov    bp, sp                
C000:1BE3  894e00       mov    word ptr [bp], cx     
C000:1BE6  51           push   cx                    
C000:1BE7  52           push   dx                    
C000:1BE8  56           push   si                    
C000:1BE9  57           push   di                    
C000:1BEA  1e           push   ds                    
C000:1BEB  50           push   ax                    
C000:1BEC  b800a0       mov    ax, 0xa000            
C000:1BEF  8ec0         mov    es, ax                
C000:1BF1  b90300       mov    cx, 3                 
C000:1BF4  a15004       mov    ax, word ptr [0x450]  
C000:1BF7  53           push   bx                    
C000:1BF8  e8a600       call   0x1ca1                
C000:1BFB  e87901       call   0x1d77                
C000:1BFE  8bfe         mov    di, si                
C000:1C00  5b           pop    bx                    
C000:1C01  a14a04       mov    ax, word ptr [0x44a]  
C000:1C04  48           dec    ax                    
C000:1C05  d3e0         shl    ax, cl                
C000:1C07  894602       mov    word ptr [bp + 2], ax 
C000:1C0A  a18504       mov    ax, word ptr [0x485]  
C000:1C0D  8bd0         mov    dx, ax                
C000:1C0F  59           pop    cx                    
C000:1C10  f6e1         mul    cl                    
C000:1C12  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:1C17  c5360c01     lds    si, ptr [0x10c]       
C000:1C1B  03f0         add    si, ax                
C000:1C1D  56           push   si                    
C000:1C1E  57           push   di                    
C000:1C1F  52           push   dx                    
C000:1C20  b90800       mov    cx, 8                 
C000:1C23  8a24         mov    ah, byte ptr [si]     
C000:1C25  46           inc    si                    
C000:1C26  d0d4         rcl    ah, 1                 
C000:1C28  8ac3         mov    al, bl                
C000:1C2A  7202         jb     0x1c2e                
C000:1C2C  8ac7         mov    al, bh                
C000:1C2E  aa           stosb  byte ptr es:[di], al  
C000:1C2F  e2f5         loop   0x1c26                
C000:1C31  037e02       add    di, word ptr [bp + 2] 
C000:1C34  4a           dec    dx                    
C000:1C35  75e9         jne    0x1c20                
C000:1C37  5a           pop    dx                    
C000:1C38  5f           pop    di                    
C000:1C39  5e           pop    si                    
C000:1C3A  83c708       add    di, 8                 
C000:1C3D  ff4e00       dec    word ptr [bp]         
C000:1C40  75db         jne    0x1c1d                
C000:1C42  1f           pop    ds                    
C000:1C43  5f           pop    di                    
C000:1C44  5e           pop    si                    
C000:1C45  5a           pop    dx                    
C000:1C46  59           pop    cx                    
C000:1C47  b40d         mov    ah, 0xd               
C000:1C49  83c404       add    sp, 4                 
C000:1C4C  8bec         mov    bp, sp                
C000:1C4E  e84dfb       call   0x179e                
C000:1C51  83c404       add    sp, 4                 
C000:1C54  5d           pop    bp                    
C000:1C55  c3           ret                          
C000:1C56  e8f901       call   0x1e52                
C000:1C59  7208         jb     0x1c63                
C000:1C5B  b403         mov    ah, 3                 
C000:1C5D  e9e629       jmp    0x4646                
C000:1C60  e9df29       jmp    0x4642                
C000:1C63  75fb         jne    0x1c60                
C000:1C65  55           push   bp                    
C000:1C66  9c           pushf                        
C000:1C67  58           pop    ax                    
C000:1C68  83ec04       sub    sp, 4                 
C000:1C6B  8bec         mov    bp, sp                
C000:1C6D  e800fb       call   0x1770                
C000:1C70  be971c       mov    si, 0x1c97            
C000:1C73  56           push   si                    
C000:1C74  7a0b         jp     0x1c81                
C000:1C76  33c9         xor    cx, cx                
C000:1C78  e87b00       call   0x1cf6                
C000:1C7B  e8f900       call   0x1d77                
C000:1C7E  e9eb2a       jmp    0x476c                
C000:1C81  b800a0       mov    ax, 0xa000            
C000:1C84  8ec0         mov    es, ax                
C000:1C86  a15004       mov    ax, word ptr [0x450]  
C000:1C89  b90300       mov    cx, 3                 
C000:1C8C  e81200       call   0x1ca1                
C000:1C8F  e8e500       call   0x1d77                
C000:1C92  8bfe         mov    di, si                
C000:1C94  e94f2b       jmp    0x47e6                

;----- sub_1CA1 -----
C000:1CA1  50           push   ax                    
C000:1CA2  52           push   dx                    
C000:1CA3  8bf0         mov    si, ax                
C000:1CA5  81e6ff00     and    si, 0xff              
C000:1CA9  8ac4         mov    al, ah                
C000:1CAB  f6264a04     mul    byte ptr [0x44a]      
C000:1CAF  f7268504     mul    word ptr [0x485]      
C000:1CB3  03f0         add    si, ax                
C000:1CB5  80d200       adc    dl, 0                 
C000:1CB8  e315         jcxz   0x1ccf                
C000:1CBA  d1e6         shl    si, 1                 
C000:1CBC  d0d2         rcl    dl, 1                 
C000:1CBE  d1e6         shl    si, 1                 
C000:1CC0  d0d2         rcl    dl, 1                 
C000:1CC2  d1e6         shl    si, 1                 
C000:1CC4  d0d2         rcl    dl, 1                 
C000:1CC6  80f904       cmp    cl, 4                 
C000:1CC9  7504         jne    0x1ccf                
C000:1CCB  d1e6         shl    si, 1                 
C000:1CCD  d0d2         rcl    dl, 1                 
C000:1CCF  d0e2         shl    dl, 1                 
C000:1CD1  d0e2         shl    dl, 1                 
C000:1CD3  d0e2         shl    dl, 1                 
C000:1CD5  d0e2         shl    dl, 1                 
C000:1CD7  8bc6         mov    ax, si                
C000:1CD9  d1c0         rol    ax, 1                 
C000:1CDB  d1c0         rol    ax, 1                 
C000:1CDD  d1c0         rol    ax, 1                 
C000:1CDF  d1c0         rol    ax, 1                 
C000:1CE1  240f         and    al, 0xf               
C000:1CE3  02d0         add    dl, al                
C000:1CE5  81e6ff0f     and    si, 0xfff             
C000:1CE9  0ac9         or     cl, cl                
C000:1CEB  7504         jne    0x1cf1                
C000:1CED  d0e2         shl    dl, 1                 
C000:1CEF  d0e2         shl    dl, 1                 
C000:1CF1  8ada         mov    bl, dl                
C000:1CF3  5a           pop    dx                    
C000:1CF4  58           pop    ax                    
C000:1CF5  c3           ret                          

;----- sub_1CF6 -----
C000:1CF6  b800a0       mov    ax, 0xa000            
C000:1CF9  8ec0         mov    es, ax                
C000:1CFB  8ac7         mov    al, bh                
C000:1CFD  32e4         xor    ah, ah                
C000:1CFF  d1e0         shl    ax, 1                 
C000:1D01  8bf0         mov    si, ax                
C000:1D03  8b845004     mov    ax, word ptr [si + 0x450]
C000:1D07  e897ff       call   0x1ca1                
C000:1D0A  c3           ret                          

;----- sub_1D0B -----
C000:1D0B  a14a04       mov    ax, word ptr [0x44a]  
C000:1D0E  d1e0         shl    ax, 1                 
C000:1D10  d1e0         shl    ax, 1                 
C000:1D12  d1e0         shl    ax, 1                 
C000:1D14  f7e2         mul    dx                    
C000:1D16  03c1         add    ax, cx                
C000:1D18  83d200       adc    dx, 0                 
C000:1D1B  d0e2         shl    dl, 1                 
C000:1D1D  d0e2         shl    dl, 1                 
C000:1D1F  d0e2         shl    dl, 1                 
C000:1D21  d0e2         shl    dl, 1                 
C000:1D23  8bd8         mov    bx, ax                
C000:1D25  d1c0         rol    ax, 1                 
C000:1D27  d1c0         rol    ax, 1                 
C000:1D29  d1c0         rol    ax, 1                 
C000:1D2B  d1c0         rol    ax, 1                 
C000:1D2D  240f         and    al, 0xf               
C000:1D2F  02d0         add    dl, al                
C000:1D31  81e3ff0f     and    bx, 0xfff             
C000:1D35  86da         xchg   dl, bl                
C000:1D37  e83d00       call   0x1d77                
C000:1D3A  86da         xchg   dl, bl                
C000:1D3C  c3           ret                          

;----- sub_1D3D -----
C000:1D3D  d1eb         shr    bx, 1                 
C000:1D3F  d1eb         shr    bx, 1                 
C000:1D41  d1eb         shr    bx, 1                 
C000:1D43  8bc2         mov    ax, dx                
C000:1D45  8b164a04     mov    dx, word ptr [0x44a]  
C000:1D49  f7e2         mul    dx                    
C000:1D4B  03d8         add    bx, ax                
C000:1D4D  80d200       adc    dl, 0                 
C000:1D50  8bc3         mov    ax, bx                
C000:1D52  d1e3         shl    bx, 1                 
C000:1D54  d0d2         rcl    dl, 1                 
C000:1D56  d1e3         shl    bx, 1                 
C000:1D58  d0d2         rcl    dl, 1                 
C000:1D5A  d1e3         shl    bx, 1                 
C000:1D5C  d0d2         rcl    dl, 1                 
C000:1D5E  d1e3         shl    bx, 1                 
C000:1D60  d0d2         rcl    dl, 1                 
C000:1D62  d1e3         shl    bx, 1                 
C000:1D64  d0d2         rcl    dl, 1                 
C000:1D66  d1e3         shl    bx, 1                 
C000:1D68  d0d2         rcl    dl, 1                 
C000:1D6A  25ff03       and    ax, 0x3ff             
C000:1D6D  8bd8         mov    bx, ax                
C000:1D6F  86da         xchg   dl, bl                
C000:1D71  e80300       call   0x1d77                
C000:1D74  86da         xchg   dl, bl                
C000:1D76  c3           ret                          

;----- sub_1D77 -----
C000:1D77  50           push   ax                    
C000:1D78  52           push   dx                    
C000:1D79  bad603       mov    dx, 0x3d6             
C000:1D7C  8ae3         mov    ah, bl                
C000:1D7E  b010         mov    al, 0x10              
C000:1D80  ef           out    dx, ax                
C000:1D81  5a           pop    dx                    
C000:1D82  58           pop    ax                    
C000:1D83  c3           ret                          

;----- sub_1D84 -----
C000:1D84  50           push   ax                    
C000:1D85  52           push   dx                    
C000:1D86  bad603       mov    dx, 0x3d6             
C000:1D89  b010         mov    al, 0x10              
C000:1D8B  8ae3         mov    ah, bl                
C000:1D8D  ef           out    dx, ax                
C000:1D8E  eb00         jmp    0x1d90                
C000:1D90  b011         mov    al, 0x11              
C000:1D92  8ae7         mov    ah, bh                
C000:1D94  ef           out    dx, ax                
C000:1D95  5a           pop    dx                    
C000:1D96  58           pop    ax                    
C000:1D97  c3           ret                          
C000:1D98  50           push   ax                    
C000:1D99  52           push   dx                    
C000:1D9A  b00b         mov    al, 0xb               
C000:1D9C  e8a001       call   0x1f3f                
C000:1D9F  8bc8         mov    cx, ax                
C000:1DA1  80e4ef       and    ah, 0xef              
C000:1DA4  ef           out    dx, ax                
C000:1DA5  5a           pop    dx                    
C000:1DA6  58           pop    ax                    
C000:1DA7  51           push   cx                    
C000:1DA8  55           push   bp                    
C000:1DA9  83ec04       sub    sp, 4                 
C000:1DAC  8bec         mov    bp, sp                
C000:1DAE  e8bff9       call   0x1770                
C000:1DB1  33c9         xor    cx, cx                
C000:1DB3  b240         mov    dl, 0x40              
C000:1DB5  f6c304       test   bl, 4                 
C000:1DB8  740c         je     0x1dc6                
C000:1DBA  b103         mov    cl, 3                 
C000:1DBC  e80211       call   0x2ec1                
C000:1DBF  7503         jne    0x1dc4                
C000:1DC1  b90400       mov    cx, 4                 
C000:1DC4  b210         mov    dl, 0x10              
C000:1DC6  8a268404     mov    ah, byte ptr [0x484]  
C000:1DCA  803e490430   cmp    byte ptr [0x449], 0x30
C000:1DCF  7309         jae    0x1dda                
C000:1DD1  803e490420   cmp    byte ptr [0x449], 0x20
C000:1DD6  7202         jb     0x1dda                
C000:1DD8  d0ec         shr    ah, 1                 
C000:1DDA  803e490450   cmp    byte ptr [0x449], 0x50
C000:1DDF  7502         jne    0x1de3                
C000:1DE1  b42c         mov    ah, 0x2c              
C000:1DE3  80c401       add    ah, 1                 
C000:1DE6  32c0         xor    al, al                
C000:1DE8  e8b6fe       call   0x1ca1                
C000:1DEB  803e49047c   cmp    byte ptr [0x449], 0x7c
C000:1DF0  7407         je     0x1df9                
C000:1DF2  803e490432   cmp    byte ptr [0x449], 0x32
C000:1DF7  7504         jne    0x1dfd                
C000:1DF9  81c60019     add    si, 0x1900            
C000:1DFD  56           push   si                    
C000:1DFE  8afb         mov    bh, bl                
C000:1E00  32db         xor    bl, bl                
C000:1E02  b800a0       mov    ax, 0xa000            
C000:1E05  8ec0         mov    es, ax                
C000:1E07  33c0         xor    ax, ax                
C000:1E09  8bf8         mov    di, ax                
C000:1E0B  e869ff       call   0x1d77                
C000:1E0E  3afa         cmp    bh, dl                
C000:1E10  720b         jb     0x1e1d                
C000:1E12  b90080       mov    cx, 0x8000            
C000:1E15  f3ab         rep stosw word ptr es:[di], ax  
C000:1E17  02da         add    bl, dl                
C000:1E19  2afa         sub    bh, dl                
C000:1E1B  ebee         jmp    0x1e0b                
C000:1E1D  59           pop    cx                    
C000:1E1E  d0cf         ror    bh, 1                 
C000:1E20  d0cf         ror    bh, 1                 
C000:1E22  d0cf         ror    bh, 1                 
C000:1E24  d0cf         ror    bh, 1                 
C000:1E26  80fa10       cmp    dl, 0x10              
C000:1E29  7404         je     0x1e2f                
C000:1E2B  d0cf         ror    bh, 1                 
C000:1E2D  d0cf         ror    bh, 1                 
C000:1E2F  32db         xor    bl, bl                
C000:1E31  03cb         add    cx, bx                
C000:1E33  e308         jcxz   0x1e3d                
C000:1E35  d1d9         rcr    cx, 1                 
C000:1E37  f3ab         rep stosw word ptr es:[di], ax  
C000:1E39  d1d1         rcl    cx, 1                 
C000:1E3B  f3aa         rep stosb byte ptr es:[di], al  
C000:1E3D  32c0         xor    al, al                
C000:1E3F  884602       mov    byte ptr [bp + 2], al 
C000:1E42  884603       mov    byte ptr [bp + 3], al 
C000:1E45  e856f9       call   0x179e                
C000:1E48  83c404       add    sp, 4                 
C000:1E4B  5d           pop    bp                    
C000:1E4C  58           pop    ax                    
C000:1E4D  bad603       mov    dx, 0x3d6             
C000:1E50  ef           out    dx, ax                
C000:1E51  c3           ret                          

;----- sub_1E52 -----
C000:1E52  53           push   bx                    
C000:1E53  9c           pushf                        
C000:1E54  5b           pop    bx                    
C000:1E55  32db         xor    bl, bl                
C000:1E57  80fc13       cmp    ah, 0x13              
C000:1E5A  7622         jbe    0x1e7e                
C000:1E5C  80fc5f       cmp    ah, 0x5f              
C000:1E5F  7705         ja     0x1e66                
C000:1E61  80cb45       or     bl, 0x45              
C000:1E64  eb18         jmp    0x1e7e                
C000:1E66  80fc65       cmp    ah, 0x65              
C000:1E69  7613         jbe    0x1e7e                
C000:1E6B  80cb01       or     bl, 1                 
C000:1E6E  80fc71       cmp    ah, 0x71              
C000:1E71  720b         jb     0x1e7e                
C000:1E73  80cb40       or     bl, 0x40              
C000:1E76  80fc78       cmp    ah, 0x78              
C000:1E79  7203         jb     0x1e7e                
C000:1E7B  80cb04       or     bl, 4                 
C000:1E7E  53           push   bx                    
C000:1E7F  9d           popf                         
C000:1E80  5b           pop    bx                    
C000:1E81  c3           ret                          

;----- sub_1E82 -----
C000:1E82  50           push   ax                    
C000:1E83  b501         mov    ch, 1                 
C000:1E85  b028         mov    al, 0x28              
C000:1E87  e8b500       call   0x1f3f                
C000:1E8A  80e4df       and    ah, 0xdf              
C000:1E8D  8afc         mov    bh, ah                
C000:1E8F  58           pop    ax                    
C000:1E90  c3           ret                          

;----- sub_1E91 -----
C000:1E91  50           push   ax                    
C000:1E92  52           push   dx                    
C000:1E93  bad603       mov    dx, 0x3d6             
C000:1E96  80e7ef       and    bh, 0xef              
C000:1E99  3c30         cmp    al, 0x30              
C000:1E9B  720b         jb     0x1ea8                
C000:1E9D  3c60         cmp    al, 0x60              
C000:1E9F  7204         jb     0x1ea5                
C000:1EA1  3c77         cmp    al, 0x77              
C000:1EA3  7603         jbe    0x1ea8                
C000:1EA5  80cf10       or     bh, 0x10              
C000:1EA8  b028         mov    al, 0x28              
C000:1EAA  8ae7         mov    ah, bh                
C000:1EAC  ef           out    dx, ax                
C000:1EAD  e85cec       call   0xb0c                 
C000:1EB0  7505         jne    0x1eb7                
C000:1EB2  b019         mov    al, 0x19              
C000:1EB4  8ae5         mov    ah, ch                
C000:1EB6  ef           out    dx, ax                
C000:1EB7  5a           pop    dx                    
C000:1EB8  58           pop    ax                    
C000:1EB9  c3           ret                          

;----- sub_1EBA -----
C000:1EBA  7305         jae    0x1ec1                
C000:1EBC  b54c         mov    ch, 0x4c              
C000:1EBE  80cf20       or     bh, 0x20              
C000:1EC1  c3           ret                          

;----- sub_1EC2 -----
C000:1EC2  50           push   ax                    
C000:1EC3  52           push   dx                    
C000:1EC4  e80f00       call   0x1ed6                
C000:1EC7  7404         je     0x1ecd                
C000:1EC9  32e4         xor    ah, ah                
C000:1ECB  eb06         jmp    0x1ed3                
C000:1ECD  83c704       add    di, 4                 
C000:1ED0  32e4         xor    ah, ah                
C000:1ED2  f9           stc                          
C000:1ED3  5a           pop    dx                    
C000:1ED4  58           pop    ax                    
C000:1ED5  c3           ret                          

;----- sub_1ED6 -----
C000:1ED6  50           push   ax                    
C000:1ED7  e86c00       call   0x1f46                
C000:1EDA  8ac4         mov    al, ah                
C000:1EDC  d0e8         shr    al, 1                 
C000:1EDE  a820         test   al, 0x20              
C000:1EE0  58           pop    ax                    
C000:1EE1  7507         jne    0x1eea                
C000:1EE3  247f         and    al, 0x7f              
C000:1EE5  e80c00       call   0x1ef4                
C000:1EE8  7403         je     0x1eed                
C000:1EEA  f8           clc                          
C000:1EEB  eb06         jmp    0x1ef3                
C000:1EED  e81cec       call   0xb0c                 
C000:1EF0  75f8         jne    0x1eea                
C000:1EF2  f9           stc                          
C000:1EF3  c3           ret                          

;----- sub_1EF4 -----
C000:1EF4  3c24         cmp    al, 0x24              
C000:1EF6  7412         je     0x1f0a                
C000:1EF8  3c34         cmp    al, 0x34              
C000:1EFA  740e         je     0x1f0a                
C000:1EFC  3c72         cmp    al, 0x72              
C000:1EFE  740a         je     0x1f0a                
C000:1F00  3c75         cmp    al, 0x75              
C000:1F02  7406         je     0x1f0a                
C000:1F04  3c74         cmp    al, 0x74              
C000:1F06  7402         je     0x1f0a                
C000:1F08  3c7e         cmp    al, 0x7e              
C000:1F0A  c3           ret                          

;----- sub_1F0B -----
C000:1F0B  51           push   cx                    
C000:1F0C  53           push   bx                    
C000:1F0D  32c9         xor    cl, cl                
C000:1F0F  0adb         or     bl, bl                
C000:1F11  7409         je     0x1f1c                
C000:1F13  b106         mov    cl, 6                 
C000:1F15  f6c301       test   bl, 1                 
C000:1F18  7502         jne    0x1f1c                
C000:1F1A  b104         mov    cl, 4                 
C000:1F1C  8ad9         mov    bl, cl                
C000:1F1E  b006         mov    al, 6                 
C000:1F20  e81c00       call   0x1f3f                
C000:1F23  80e4fd       and    ah, 0xfd              
C000:1F26  80e102       and    cl, 2                 
C000:1F29  0ae1         or     ah, cl                
C000:1F2B  ef           out    dx, ax                
C000:1F2C  8acb         mov    cl, bl                
C000:1F2E  b051         mov    al, 0x51              
C000:1F30  e88f3e       call   0x5dc2                
C000:1F33  80e4fb       and    ah, 0xfb              
C000:1F36  80e104       and    cl, 4                 
C000:1F39  0ae1         or     ah, cl                
C000:1F3B  ef           out    dx, ax                
C000:1F3C  5b           pop    bx                    
C000:1F3D  59           pop    cx                    
C000:1F3E  c3           ret                          

;----- sub_1F3F -----
C000:1F3F  bad603       mov    dx, 0x3d6             
C000:1F42  e87d3e       call   0x5dc2                
C000:1F45  c3           ret                          

;----- sub_1F46 -----
C000:1F46  bad603       mov    dx, 0x3d6             
C000:1F49  b00f         mov    al, 0xf               
C000:1F4B  e8743e       call   0x5dc2                
C000:1F4E  c3           ret                          

;----- sub_1FBF -----
C000:1FBF  80fc4f       cmp    ah, 0x4f              
C000:1FC2  7403         je     0x1fc7                
C000:1FC4  e9d600       jmp    0x209d                
C000:1FC7  e9a800       jmp    0x2072                
C000:2072  3d104f       cmp    ax, 0x4f10            
C000:2075  7516         jne    0x208d                
C000:2077  32e4         xor    ah, ah                
C000:2079  80fb02       cmp    bl, 2                 
C000:207C  7602         jbe    0x2080                
C000:207E  b303         mov    bl, 3                 
C000:2080  8ac3         mov    al, bl                
C000:2082  8bf0         mov    si, ax                
C000:2084  d1e6         shl    si, 1                 
C000:2086  2eff94dc1f   call   word ptr cs:[si + 0x1fdc]
C000:208B  eb0f         jmp    0x209c                
C000:208D  3c08         cmp    al, 8                 
C000:208F  770b         ja     0x209c                
C000:2091  32e4         xor    ah, ah                
C000:2093  8bf0         mov    si, ax                
C000:2095  d1e6         shl    si, 1                 
C000:2097  2eff94ca1f   call   word ptr cs:[si + 0x1fca]
C000:209C  c3           ret                          
C000:209D  80fc5f       cmp    ah, 0x5f              
C000:20A0  7554         jne    0x20f6                
C000:20A2  3c10         cmp    al, 0x10              
C000:20A4  7502         jne    0x20a8                
C000:20A6  b003         mov    al, 3                 
C000:20A8  3c05         cmp    al, 5                 
C000:20AA  7614         jbe    0x20c0                
C000:20AC  2c50         sub    al, 0x50              
C000:20AE  7246         jb     0x20f6                
C000:20B0  3c10         cmp    al, 0x10              
C000:20B2  720a         jb     0x20be                
C000:20B4  2c50         sub    al, 0x50              
C000:20B6  723e         jb     0x20f6                
C000:20B8  3c03         cmp    al, 3                 
C000:20BA  733a         jae    0x20f6                
C000:20BC  0410         add    al, 0x10              
C000:20BE  0405         add    al, 5                 
C000:20C0  32e4         xor    ah, ah                
C000:20C2  8bf0         mov    si, ax                
C000:20C4  d1e6         shl    si, 1                 
C000:20C6  83fe2a       cmp    si, 0x2a              
C000:20C9  7206         jb     0x20d1                
C000:20CB  2eff948f1f   call   word ptr cs:[si + 0x1f8f]
C000:20D0  c3           ret                          
C000:20D1  ff364904     push   word ptr [0x449]      
C000:20D5  1e           push   ds                    
C000:20D6  52           push   dx                    
C000:20D7  b02b         mov    al, 0x2b              
C000:20D9  e863fe       call   0x1f3f                
C000:20DC  88264904     mov    byte ptr [0x449], ah  
C000:20E0  bac403       mov    dx, 0x3c4             
C000:20E3  ec           in     al, dx                
C000:20E4  5a           pop    dx                    
C000:20E5  50           push   ax                    
C000:20E6  2eff948f1f   call   word ptr cs:[si + 0x1f8f]
C000:20EB  58           pop    ax                    
C000:20EC  1f           pop    ds                    
C000:20ED  bac403       mov    dx, 0x3c4             
C000:20F0  ee           out    dx, al                
C000:20F1  58           pop    ax                    
C000:20F2  a24904       mov    byte ptr [0x449], al  
C000:20F5  c3           ret                          
C000:20F6  0cff         or     al, 0xff              
C000:20F8  c3           ret                          

;----- sub_2AB2 -----
C000:2AB2  9c           pushf                        
C000:2AB3  fa           cli                          
C000:2AB4  56           push   si                    
C000:2AB5  d1e6         shl    si, 1                 
C000:2AB7  b08e         mov    al, 0x8e              
C000:2AB9  e670         out    0x70, al              
C000:2ABB  eb00         jmp    0x2abd                
C000:2ABD  eb00         jmp    0x2abf                
C000:2ABF  eb00         jmp    0x2ac1                
C000:2AC1  eb00         jmp    0x2ac3                
C000:2AC3  eb00         jmp    0x2ac5                
C000:2AC5  e471         in     al, 0x71              
C000:2AC7  a8c0         test   al, 0xc0              
C000:2AC9  2e8a84f32a   mov    al, byte ptr cs:[si + 0x2af3]
C000:2ACE  751f         jne    0x2aef                
C000:2AD0  eb00         jmp    0x2ad2                
C000:2AD2  eb00         jmp    0x2ad4                
C000:2AD4  eb00         jmp    0x2ad6                
C000:2AD6  eb00         jmp    0x2ad8                
C000:2AD8  eb00         jmp    0x2ada                
C000:2ADA  2e8a84f22a   mov    al, byte ptr cs:[si + 0x2af2]
C000:2ADF  0c80         or     al, 0x80              
C000:2AE1  e670         out    0x70, al              
C000:2AE3  eb00         jmp    0x2ae5                
C000:2AE5  eb00         jmp    0x2ae7                
C000:2AE7  eb00         jmp    0x2ae9                
C000:2AE9  eb00         jmp    0x2aeb                
C000:2AEB  eb00         jmp    0x2aed                
C000:2AED  e471         in     al, 0x71              
C000:2AEF  5e           pop    si                    
C000:2AF0  9d           popf                         
C000:2AF1  c3           ret                          

;----- sub_2AF4 -----
C000:2AF4  55           push   bp                    
C000:2AF5  50           push   ax                    
C000:2AF6  53           push   bx                    
C000:2AF7  52           push   dx                    
C000:2AF8  56           push   si                    
C000:2AF9  be0000       mov    si, 0                 
C000:2AFC  e8b3ff       call   0x2ab2                
C000:2AFF  a808         test   al, 8                 
C000:2B01  b001         mov    al, 1                 
C000:2B03  7402         je     0x2b07                
C000:2B05  b000         mov    al, 0                 
C000:2B07  b412         mov    ah, 0x12              
C000:2B09  b38f         mov    bl, 0x8f              
C000:2B0B  e8c500       call   0x2bd3                
C000:2B0E  be0000       mov    si, 0                 
C000:2B11  e89eff       call   0x2ab2                
C000:2B14  2406         and    al, 6                 
C000:2B16  3c02         cmp    al, 2                 
C000:2B18  b401         mov    ah, 1                 
C000:2B1A  7502         jne    0x2b1e                
C000:2B1C  eb16         jmp    0x2b34                
C000:2B1E  e8b800       call   0x2bd9                
C000:2B21  3c18         cmp    al, 0x18              
C000:2B23  740f         je     0x2b34                
C000:2B25  b80012       mov    ax, 0x1200            
C000:2B28  b3a1         mov    bl, 0xa1              
C000:2B2A  e81007       call   0x323d                
C000:2B2D  b401         mov    ah, 1                 
C000:2B2F  80fa02       cmp    dl, 2                 
C000:2B32  7507         jne    0x2b3b                
C000:2B34  e8d5df       call   0xb0c                 
C000:2B37  7511         jne    0x2b4a                 ; "^Z[X]"
C000:2B39  b400         mov    ah, 0                 
C000:2B3B  8ac4         mov    al, ah                
C000:2B3D  b412         mov    ah, 0x12              
C000:2B3F  b392         mov    bl, 0x92              
C000:2B41  e88f00       call   0x2bd3                
C000:2B44  b9050d       mov    cx, 0xd05             
C000:2B47  e8b400       call   0x2bfe                
C000:2B4A  5e           pop    si                    
C000:2B4B  5a           pop    dx                    
C000:2B4C  5b           pop    bx                    
C000:2B4D  58           pop    ax                    
C000:2B4E  5d           pop    bp                    
C000:2B4F  c3           ret                          

;----- sub_2BD3 -----
C000:2BD3  9c           pushf                        
C000:2BD4  0e           push   cs                    
C000:2BD5  e8890c       call   0x3861                
C000:2BD8  c3           ret                          

;----- sub_2BD9 -----
C000:2BD9  baea35       mov    dx, 0x35ea            
C000:2BDC  b004         mov    al, 4                 
C000:2BDE  ee           out    dx, al                
C000:2BDF  42           inc    dx                    
C000:2BE0  ec           in     al, dx                
C000:2BE1  2418         and    al, 0x18              
C000:2BE3  c3           ret                          

;----- sub_2BFE -----
C000:2BFE  50           push   ax                    
C000:2BFF  51           push   cx                    
C000:2C00  e461         in     al, 0x61              
C000:2C02  8ae0         mov    ah, al                
C000:2C04  80e410       and    ah, 0x10              
C000:2C07  e461         in     al, 0x61              
C000:2C09  2410         and    al, 0x10              
C000:2C0B  3ac4         cmp    al, ah                
C000:2C0D  74f8         je     0x2c07                
C000:2C0F  8ae0         mov    ah, al                
C000:2C11  e2f4         loop   0x2c07                
C000:2C13  59           pop    cx                    
C000:2C14  58           pop    ax                    
C000:2C15  c3           ret                          

;----- sub_2DC2 -----
C000:2DC2  bb1002       mov    bx, 0x210             
C000:2DC5  2e8b37       mov    si, word ptr cs:[bx]  
C000:2DC8  2e8b4f04     mov    cx, word ptr cs:[bx + 4]
C000:2DCC  e87301       call   0x2f42                
C000:2DCF  b93200       mov    cx, 0x32              
C000:2DD2  32c0         xor    al, al                
C000:2DD4  e81d30       call   0x5df4                
C000:2DD7  bb1602       mov    bx, 0x216             
C000:2DDA  2e8b37       mov    si, word ptr cs:[bx]  
C000:2DDD  2e8b4f04     mov    cx, word ptr cs:[bx + 4]
C000:2DE1  e85e01       call   0x2f42                
C000:2DE4  bb3402       mov    bx, 0x234             
C000:2DE7  2e8b37       mov    si, word ptr cs:[bx]  
C000:2DEA  2e8b4f04     mov    cx, word ptr cs:[bx + 4]
C000:2DEE  e85101       call   0x2f42                
C000:2DF1  2e8a0eba01   mov    cl, byte ptr cs:[0x1ba]
C000:2DF6  e89d00       call   0x2e96                
C000:2DF9  24fc         and    al, 0xfc              
C000:2DFB  0ac1         or     al, cl                
C000:2DFD  e8a700       call   0x2ea7                
C000:2E00  e85200       call   0x2e55                
C000:2E03  b000         mov    al, 0                 
C000:2E05  e8ce00       call   0x2ed6                
C000:2E08  bad603       mov    dx, 0x3d6             
C000:2E0B  2e8a26cb01   mov    ah, byte ptr cs:[0x1cb]
C000:2E10  b103         mov    cl, 3                 
C000:2E12  d2e4         shl    ah, cl                
C000:2E14  80e47f       and    ah, 0x7f              
C000:2E17  2e803eb60100 cmp    byte ptr cs:[0x1b6], 0
C000:2E1D  7403         je     0x2e22                
C000:2E1F  80cc80       or     ah, 0x80              
C000:2E22  2e803ecb0110 cmp    byte ptr cs:[0x1cb], 0x10
C000:2E28  7203         jb     0x2e2d                
C000:2E2A  80cc80       or     ah, 0x80              
C000:2E2D  b008         mov    al, 8                 
C000:2E2F  e89b2f       call   0x5dcd                
C000:2E32  b180         mov    cl, 0x80              
C000:2E34  e80ff1       call   0x1f46                
C000:2E37  f6c480       test   ah, 0x80              
C000:2E3A  7502         jne    0x2e3e                
C000:2E3C  b100         mov    cl, 0                 
C000:2E3E  b059         mov    al, 0x59              
C000:2E40  e8fcf0       call   0x1f3f                
C000:2E43  80e47f       and    ah, 0x7f              
C000:2E46  0ae1         or     ah, cl                
C000:2E48  ef           out    dx, ax                
C000:2E49  b93200       mov    cx, 0x32              
C000:2E4C  32c0         xor    al, al                
C000:2E4E  e8a32f       call   0x5df4                
C000:2E51  c3           ret                          

;----- sub_2E55 -----
C000:2E55  52           push   dx                    
C000:2E56  b06c         mov    al, 0x6c              
C000:2E58  e8e4f0       call   0x1f3f                
C000:2E5B  8bd8         mov    bx, ax                
C000:2E5D  80e702       and    bh, 2                 
C000:2E60  53           push   bx                    
C000:2E61  b00f         mov    al, 0xf               
C000:2E63  e8612f       call   0x5dc7                
C000:2E66  80e403       and    ah, 3                 
C000:2E69  8bd8         mov    bx, ax                
C000:2E6B  53           push   bx                    
C000:2E6C  bb2202       mov    bx, 0x222             
C000:2E6F  2e8b37       mov    si, word ptr cs:[bx]  
C000:2E72  2e8b4f02     mov    cx, word ptr cs:[bx + 2]
C000:2E76  e8c900       call   0x2f42                
C000:2E79  5b           pop    bx                    
C000:2E7A  8ac3         mov    al, bl                
C000:2E7C  e8c0f0       call   0x1f3f                
C000:2E7F  80e4fc       and    ah, 0xfc              
C000:2E82  80cc02       or     ah, 2                 
C000:2E85  0ae7         or     ah, bh                
C000:2E87  ef           out    dx, ax                
C000:2E88  5b           pop    bx                    
C000:2E89  b06c         mov    al, 0x6c              
C000:2E8B  e8b1f0       call   0x1f3f                
C000:2E8E  80e4fd       and    ah, 0xfd              
C000:2E91  0ae7         or     ah, bh                
C000:2E93  ef           out    dx, ax                
C000:2E94  5a           pop    dx                    
C000:2E95  c3           ret                          

;----- sub_2E96 -----
C000:2E96  52           push   dx                    
C000:2E97  b044         mov    al, 0x44              
C000:2E99  e8a3f0       call   0x1f3f                
C000:2E9C  86e0         xchg   al, ah                
C000:2E9E  8ad0         mov    dl, al                
C000:2EA0  80e203       and    dl, 3                 
C000:2EA3  0ad2         or     dl, dl                
C000:2EA5  5a           pop    dx                    
C000:2EA6  c3           ret                          

;----- sub_2EA7 -----
C000:2EA7  50           push   ax                    
C000:2EA8  52           push   dx                    
C000:2EA9  bad603       mov    dx, 0x3d6             
C000:2EAC  8ae0         mov    ah, al                
C000:2EAE  b044         mov    al, 0x44              
C000:2EB0  ef           out    dx, ax                
C000:2EB1  5a           pop    dx                    
C000:2EB2  58           pop    ax                    
C000:2EB3  c3           ret                          

;----- sub_2EB4 -----
C000:2EB4  50           push   ax                    
C000:2EB5  52           push   dx                    
C000:2EB6  b06c         mov    al, 0x6c              
C000:2EB8  e884f0       call   0x1f3f                
C000:2EBB  f6c402       test   ah, 2                 
C000:2EBE  5a           pop    dx                    
C000:2EBF  58           pop    ax                    
C000:2EC0  c3           ret                          

;----- sub_2EC1 -----
C000:2EC1  50           push   ax                    
C000:2EC2  e872e5       call   0x1437                
C000:2EC5  80fc40       cmp    ah, 0x40              
C000:2EC8  740a         je     0x2ed4                
C000:2ECA  80fc41       cmp    ah, 0x41              
C000:2ECD  7405         je     0x2ed4                
C000:2ECF  80fc50       cmp    ah, 0x50              
C000:2ED2  7400         je     0x2ed4                
C000:2ED4  58           pop    ax                    
C000:2ED5  c3           ret                          

;----- sub_2ED6 -----
C000:2ED6  53           push   bx                    
C000:2ED7  e80200       call   0x2edc                
C000:2EDA  5b           pop    bx                    
C000:2EDB  c3           ret                          

;----- sub_2EDC -----
C000:2EDC  bb1c02       mov    bx, 0x21c             
C000:2EDF  a807         test   al, 7                 
C000:2EE1  7509         jne    0x2eec                
C000:2EE3  3c00         cmp    al, 0                 
C000:2EE5  740b         je     0x2ef2                
C000:2EE7  bb2802       mov    bx, 0x228             
C000:2EEA  eb06         jmp    0x2ef2                
C000:2EEC  b106         mov    cl, 6                 
C000:2EEE  f6e1         mul    cl                    
C000:2EF0  03d8         add    bx, ax                
C000:2EF2  2e8b37       mov    si, word ptr cs:[bx]  
C000:2EF5  2e8b4f04     mov    cx, word ptr cs:[bx + 4]
C000:2EF9  e84600       call   0x2f42                
C000:2EFC  e80ddc       call   0xb0c                 
C000:2EFF  7406         je     0x2f07                
C000:2F01  e80400       call   0x2f08                
C000:2F04  e83b00       call   0x2f42                
C000:2F07  c3           ret                          

;----- sub_2F08 -----
C000:2F08  e88bff       call   0x2e96                
C000:2F0B  7422         je     0x2f2f                
C000:2F0D  250300       and    ax, 3                 
C000:2F10  48           dec    ax                    
C000:2F11  bb4c02       mov    bx, 0x24c             
C000:2F14  2e8b17       mov    dx, word ptr cs:[bx]  
C000:2F17  f7e2         mul    dx                    
C000:2F19  bb4602       mov    bx, 0x246             
C000:2F1C  e804dc       call   0xb23                 
C000:2F1F  7403         je     0x2f24                
C000:2F21  bb4002       mov    bx, 0x240             
C000:2F24  2e8b37       mov    si, word ptr cs:[bx]  
C000:2F27  2e8b4f04     mov    cx, word ptr cs:[bx + 4]
C000:2F2B  03f0         add    si, ax                
C000:2F2D  eb12         jmp    0x2f41                
C000:2F2F  bb2e02       mov    bx, 0x22e             
C000:2F32  e8eedb       call   0xb23                 
C000:2F35  7403         je     0x2f3a                
C000:2F37  bb3402       mov    bx, 0x234             
C000:2F3A  2e8b37       mov    si, word ptr cs:[bx]  
C000:2F3D  2e8b4f04     mov    cx, word ptr cs:[bx + 4]
C000:2F41  c3           ret                          

;----- sub_2F42 -----
C000:2F42  52           push   dx                    
C000:2F43  e89530       call   0x5fdb                
C000:2F46  bad603       mov    dx, 0x3d6             
C000:2F49  e305         jcxz   0x2f50                
C000:2F4B  2ead         lodsw  ax, word ptr cs:[si]  
C000:2F4D  ef           out    dx, ax                
C000:2F4E  e2fb         loop   0x2f4b                
C000:2F50  e89030       call   0x5fe3                
C000:2F53  5a           pop    dx                    
C000:2F54  c3           ret                          

;----- sub_2F55 -----
C000:2F55  50           push   ax                    
C000:2F56  2ea0d001     mov    al, byte ptr cs:[0x1d0]
C000:2F5A  a880         test   al, 0x80              
C000:2F5C  741e         je     0x2f7c                
C000:2F5E  247f         and    al, 0x7f              
C000:2F60  8af8         mov    bh, al                
C000:2F62  8a1e4904     mov    bl, byte ptr [0x449]  
C000:2F66  53           push   bx                    
C000:2F67  32e4         xor    ah, ah                
C000:2F69  cd10         int    0x10                   ; service
C000:2F6B  8a1e4904     mov    bl, byte ptr [0x449]  
C000:2F6F  58           pop    ax                    
C000:2F70  3ac3         cmp    al, bl                
C000:2F72  7408         je     0x2f7c                
C000:2F74  3ae3         cmp    ah, bl                
C000:2F76  7404         je     0x2f7c                
C000:2F78  32e4         xor    ah, ah                
C000:2F7A  cd10         int    0x10                   ; service
C000:2F7C  58           pop    ax                    
C000:2F7D  c3           ret                          

;----- sub_2F8F -----
C000:2F8F  55           push   bp                    
C000:2F90  83ec04       sub    sp, 4                 
C000:2F93  8bec         mov    bp, sp                
C000:2F95  e8bc00       call   0x3054                
C000:2F98  bace03       mov    dx, 0x3ce             
C000:2F9B  b802ff       mov    ax, 0xff02            
C000:2F9E  ef           out    dx, ax                
C000:2F9F  bad603       mov    dx, 0x3d6             
C000:2FA2  b80b01       mov    ax, 0x10b             
C000:2FA5  ef           out    dx, ax                
C000:2FA6  b004         mov    al, 4                 
C000:2FA8  e8172e       call   0x5dc2                
C000:2FAB  80e4fc       and    ah, 0xfc              
C000:2FAE  80cc01       or     ah, 1                 
C000:2FB1  50           push   ax                    
C000:2FB2  ef           out    dx, ax                
C000:2FB3  bb4040       mov    bx, 0x4040            
C000:2FB6  e87a00       call   0x3033                
C000:2FB9  58           pop    ax                    
C000:2FBA  7405         je     0x2fc1                
C000:2FBC  bb0001       mov    bx, 0x100             
C000:2FBF  eb43         jmp    0x3004                
C000:2FC1  b004         mov    al, 4                 
C000:2FC3  e8fc2d       call   0x5dc2                
C000:2FC6  80e4fc       and    ah, 0xfc              
C000:2FC9  ef           out    dx, ax                
C000:2FCA  bb8000       mov    bx, 0x80              
C000:2FCD  e86300       call   0x3033                
C000:2FD0  750c         jne    0x2fde                
C000:2FD2  33db         xor    bx, bx                
C000:2FD4  e8b306       call   0x368a                
C000:2FD7  7528         jne    0x3001                
C000:2FD9  bb0001       mov    bx, 0x100             
C000:2FDC  eb26         jmp    0x3004                
C000:2FDE  b340         mov    bl, 0x40              
C000:2FE0  e8b900       call   0x309c                
C000:2FE3  e8a406       call   0x368a                
C000:2FE6  75f1         jne    0x2fd9                
C000:2FE8  b380         mov    bl, 0x80              
C000:2FEA  e8af00       call   0x309c                
C000:2FED  e89a06       call   0x368a                
C000:2FF0  75e7         jne    0x2fd9                
C000:2FF2  b3c0         mov    bl, 0xc0              
C000:2FF4  e8a500       call   0x309c                
C000:2FF7  e89006       call   0x368a                
C000:2FFA  75dd         jne    0x2fd9                
C000:2FFC  bb0000       mov    bx, 0                 
C000:2FFF  eb03         jmp    0x3004                
C000:3001  bbff00       mov    bx, 0xff              
C000:3004  b004         mov    al, 4                 
C000:3006  e836ef       call   0x1f3f                
C000:3009  80e4fc       and    ah, 0xfc              
C000:300C  0ae7         or     ah, bh                
C000:300E  ef           out    dx, ax                
C000:300F  e834ef       call   0x1f46                
C000:3012  80e4fc       and    ah, 0xfc              
C000:3015  80ff00       cmp    bh, 0                 
C000:3018  7502         jne    0x301c                
C000:301A  b702         mov    bh, 2                 
C000:301C  0ae7         or     ah, bh                
C000:301E  ef           out    dx, ax                
C000:301F  8ad3         mov    dl, bl                
C000:3021  32c0         xor    al, al                
C000:3023  884602       mov    byte ptr [bp + 2], al 
C000:3026  884603       mov    byte ptr [bp + 3], al 
C000:3029  e85600       call   0x3082                
C000:302C  83c404       add    sp, 4                 
C000:302F  5d           pop    bp                    
C000:3030  0ad2         or     dl, dl                
C000:3032  c3           ret                          

;----- sub_3033 -----
C000:3033  e86600       call   0x309c                
C000:3036  b91000       mov    cx, 0x10              
C000:3039  33ff         xor    di, di                
C000:303B  8ac1         mov    al, cl                
C000:303D  aa           stosb  byte ptr es:[di], al  
C000:303E  e2fb         loop   0x303b                
C000:3040  3afb         cmp    bh, bl                
C000:3042  7405         je     0x3049                
C000:3044  8adf         mov    bl, bh                
C000:3046  e85300       call   0x309c                
C000:3049  33ff         xor    di, di                
C000:304B  b91000       mov    cx, 0x10              
C000:304E  8ac1         mov    al, cl                
C000:3050  ae           scasb  al, byte ptr es:[di]  
C000:3051  e1fb         loope  0x304e                
C000:3053  c3           ret                          

;----- sub_3054 -----
C000:3054  50           push   ax                    
C000:3055  53           push   bx                    
C000:3056  52           push   dx                    
C000:3057  8ad8         mov    bl, al                
C000:3059  bad603       mov    dx, 0x3d6             
C000:305C  b010         mov    al, 0x10              
C000:305E  e84d2d       call   0x5dae                
C000:3061  886602       mov    byte ptr [bp + 2], ah 
C000:3064  e8472d       call   0x5dae                
C000:3067  886603       mov    byte ptr [bp + 3], ah 
C000:306A  b00b         mov    al, 0xb               
C000:306C  e8532d       call   0x5dc2                
C000:306F  886601       mov    byte ptr [bp + 1], ah 
C000:3072  80e4fd       and    ah, 0xfd              
C000:3075  f6c304       test   bl, 4                 
C000:3078  7403         je     0x307d                
C000:307A  80cc04       or     ah, 4                 
C000:307D  ef           out    dx, ax                
C000:307E  5a           pop    dx                    
C000:307F  5b           pop    bx                    
C000:3080  9d           popf                         
C000:3081  c3           ret                          

;----- sub_3082 -----
C000:3082  50           push   ax                    
C000:3083  52           push   dx                    
C000:3084  bad603       mov    dx, 0x3d6             
C000:3087  b00b         mov    al, 0xb               
C000:3089  8a6601       mov    ah, byte ptr [bp + 1] 
C000:308C  ef           out    dx, ax                
C000:308D  b010         mov    al, 0x10              
C000:308F  8a6602       mov    ah, byte ptr [bp + 2] 
C000:3092  ef           out    dx, ax                
C000:3093  b011         mov    al, 0x11              
C000:3095  8a6603       mov    ah, byte ptr [bp + 3] 
C000:3098  ef           out    dx, ax                
C000:3099  5a           pop    dx                    
C000:309A  58           pop    ax                    
C000:309B  c3           ret                          

;----- sub_309C -----
C000:309C  50           push   ax                    
C000:309D  52           push   dx                    
C000:309E  bad603       mov    dx, 0x3d6             
C000:30A1  8ae3         mov    ah, bl                
C000:30A3  b010         mov    al, 0x10              
C000:30A5  ef           out    dx, ax                
C000:30A6  5a           pop    dx                    
C000:30A7  58           pop    ax                    
C000:30A8  c3           ret                          

;----- sub_30BB -----
C000:30BB  50           push   ax                    
C000:30BC  53           push   bx                    
C000:30BD  51           push   cx                    
C000:30BE  1e           push   ds                    
C000:30BF  e8432f       call   0x6005                
C000:30C2  33c0         xor    ax, ax                
C000:30C4  8ed8         mov    ds, ax                
C000:30C6  b202         mov    dl, 2                 
C000:30C8  b412         mov    ah, 0x12              
C000:30CA  b91212       mov    cx, 0x1212            
C000:30CD  e8bb00       call   0x318b                 ; "PQVRW"
C000:30D0  742e         je     0x3100                
C000:30D2  b414         mov    ah, 0x14              
C000:30D4  b91414       mov    cx, 0x1414            
C000:30D7  e8b100       call   0x318b                 ; "PQVRW"
C000:30DA  7502         jne    0x30de                
C000:30DC  eb6a         jmp    0x3148                
C000:30DE  b43f         mov    ah, 0x3f              
C000:30E0  e8a800       call   0x318b                 ; "PQVRW"
C000:30E3  7563         jne    0x3148                
C000:30E5  86e5         xchg   ch, ah                
C000:30E7  e8a100       call   0x318b                 ; "PQVRW"
C000:30EA  755c         jne    0x3148                
C000:30EC  86e9         xchg   cl, ch                
C000:30EE  e89a00       call   0x318b                 ; "PQVRW"
C000:30F1  7555         jne    0x3148                
C000:30F3  8ae9         mov    ch, cl                
C000:30F5  8ae5         mov    ah, ch                
C000:30F7  e89100       call   0x318b                 ; "PQVRW"
C000:30FA  754c         jne    0x3148                
C000:30FC  b200         mov    dl, 0                 
C000:30FE  eb2f         jmp    0x312f                
C000:3100  b404         mov    ah, 4                 
C000:3102  b90412       mov    cx, 0x1204            
C000:3105  e88300       call   0x318b                 ; "PQVRW"
C000:3108  7442         je     0x314c                
C000:310A  b41e         mov    ah, 0x1e               ; "IBM VGA Compatible BIOS. 4"
C000:310C  e87c00       call   0x318b                 ; "PQVRW"
C000:310F  7537         jne    0x3148                
C000:3111  8ae1         mov    ah, cl                
C000:3113  b52d         mov    ch, 0x2d              
C000:3115  e87300       call   0x318b                 ; "PQVRW"
C000:3118  752e         jne    0x3148                
C000:311A  b91516       mov    cx, 0x1615            
C000:311D  e86b00       call   0x318b                 ; "PQVRW"
C000:3120  7526         jne    0x3148                
C000:3122  32e4         xor    ah, ah                
C000:3124  33c9         xor    cx, cx                
C000:3126  e86200       call   0x318b                 ; "PQVRW"
C000:3129  741d         je     0x3148                
C000:312B  3ac0         cmp    al, al                
C000:312D  b201         mov    dl, 1                 
C000:312F  52           push   dx                    
C000:3130  b000         mov    al, 0                 
C000:3132  bac803       mov    dx, 0x3c8             
C000:3135  ee           out    dx, al                
C000:3136  e83d00       call   0x3176                
C000:3139  b007         mov    al, 7                 
C000:313B  bac803       mov    dx, 0x3c8             
C000:313E  ee           out    dx, al                
C000:313F  e83400       call   0x3176                
C000:3142  5a           pop    dx                    
C000:3143  1f           pop    ds                    
C000:3144  59           pop    cx                    
C000:3145  5b           pop    bx                    
C000:3146  58           pop    ax                    
C000:3147  c3           ret                          
C000:3148  0cff         or     al, 0xff              
C000:314A  ebe3         jmp    0x312f                
C000:314C  b90404       mov    cx, 0x404             
C000:314F  b404         mov    ah, 4                 
C000:3151  e83700       call   0x318b                 ; "PQVRW"
C000:3154  74f2         je     0x3148                
C000:3156  b410         mov    ah, 0x10              
C000:3158  e83000       call   0x318b                 ; "PQVRW"
C000:315B  75eb         jne    0x3148                
C000:315D  86e5         xchg   ch, ah                
C000:315F  e82900       call   0x318b                 ; "PQVRW"
C000:3162  75e4         jne    0x3148                
C000:3164  86e9         xchg   cl, ch                
C000:3166  e82200       call   0x318b                 ; "PQVRW"
C000:3169  75dd         jne    0x3148                
C000:316B  b410         mov    ah, 0x10              
C000:316D  8aec         mov    ch, ah                
C000:316F  e81900       call   0x318b                 ; "PQVRW"
C000:3172  7500         jne    0x3174                
C000:3174  ebb9         jmp    0x312f                

;----- sub_3176 -----
C000:3176  bac903       mov    dx, 0x3c9             
C000:3179  e300         jcxz   0x317b                
C000:317B  b000         mov    al, 0                 
C000:317D  ee           out    dx, al                
C000:317E  e300         jcxz   0x3180                
C000:3180  b000         mov    al, 0                 
C000:3182  ee           out    dx, al                
C000:3183  e300         jcxz   0x3185                
C000:3185  b000         mov    al, 0                 
C000:3187  ee           out    dx, al                
C000:3188  e300         jcxz   0x318a                
C000:318A  c3           ret                          

;----- sub_318B -----
C000:318B  50           push   ax                    
C000:318C  51           push   cx                    
C000:318D  56           push   si                    
C000:318E  52           push   dx                    
C000:318F  57           push   di                    
C000:3190  8adc         mov    bl, ah                
C000:3192  8ae1         mov    ah, cl                
C000:3194  8afd         mov    bh, ch                
C000:3196  bac803       mov    dx, 0x3c8             
C000:3199  ec           in     al, dx                
C000:319A  50           push   ax                    
C000:319B  32c0         xor    al, al                
C000:319D  ee           out    dx, al                
C000:319E  33c9         xor    cx, cx                
C000:31A0  9c           pushf                        
C000:31A1  fa           cli                          
C000:31A2  8b166304     mov    dx, word ptr [0x463]  
C000:31A6  83c206       add    dx, 6                 
C000:31A9  8bf2         mov    si, dx                
C000:31AB  ec           in     al, dx                
C000:31AC  a808         test   al, 8                 
C000:31AE  e0fb         loopne 0x31ab                
C000:31B0  33c9         xor    cx, cx                
C000:31B2  ec           in     al, dx                
C000:31B3  a808         test   al, 8                 
C000:31B5  e1fb         loope  0x31b2                
C000:31B7  8ac3         mov    al, bl                
C000:31B9  bac903       mov    dx, 0x3c9             
C000:31BC  ee           out    dx, al                
C000:31BD  eb00         jmp    0x31bf                
C000:31BF  8ac7         mov    al, bh                
C000:31C1  ee           out    dx, al                
C000:31C2  eb00         jmp    0x31c4                
C000:31C4  8ac4         mov    al, ah                
C000:31C6  ee           out    dx, al                
C000:31C7  eb00         jmp    0x31c9                
C000:31C9  bac003       mov    dx, 0x3c0             
C000:31CC  b011         mov    al, 0x11              
C000:31CE  ee           out    dx, al                
C000:31CF  42           inc    dx                    
C000:31D0  eb00         jmp    0x31d2                
C000:31D2  ec           in     al, dx                
C000:31D3  8bf8         mov    di, ax                
C000:31D5  4a           dec    dx                    
C000:31D6  eb00         jmp    0x31d8                
C000:31D8  b000         mov    al, 0                 
C000:31DA  ee           out    dx, al                
C000:31DB  33c9         xor    cx, cx                
C000:31DD  8bd6         mov    dx, si                
C000:31DF  b401         mov    ah, 1                 
C000:31E1  ec           in     al, dx                
C000:31E2  84c4         test   ah, al                
C000:31E4  e0fb         loopne 0x31e1                
C000:31E6  b90800       mov    cx, 8                 
C000:31E9  eb00         jmp    0x31eb                
C000:31EB  eb00         jmp    0x31ed                
C000:31ED  e2fa         loop   0x31e9                
C000:31EF  bac203       mov    dx, 0x3c2             
C000:31F2  ec           in     al, dx                
C000:31F3  8af8         mov    bh, al                
C000:31F5  bac803       mov    dx, 0x3c8             
C000:31F8  32c0         xor    al, al                
C000:31FA  ee           out    dx, al                
C000:31FB  42           inc    dx                    
C000:31FC  ee           out    dx, al                
C000:31FD  eb00         jmp    0x31ff                
C000:31FF  ee           out    dx, al                
C000:3200  eb00         jmp    0x3202                
C000:3202  ee           out    dx, al                
C000:3203  9d           popf                         
C000:3204  58           pop    ax                    
C000:3205  4a           dec    dx                    
C000:3206  ee           out    dx, al                
C000:3207  f6c710       test   bh, 0x10              
C000:320A  8bd6         mov    dx, si                
C000:320C  ec           in     al, dx                
C000:320D  eb00         jmp    0x320f                
C000:320F  bac003       mov    dx, 0x3c0             
C000:3212  b011         mov    al, 0x11              
C000:3214  ee           out    dx, al                
C000:3215  eb00         jmp    0x3217                
C000:3217  8bc7         mov    ax, di                
C000:3219  ee           out    dx, al                
C000:321A  5f           pop    di                    
C000:321B  5a           pop    dx                    
C000:321C  5e           pop    si                    
C000:321D  59           pop    cx                    
C000:321E  58           pop    ax                    
C000:321F  c3           ret                          

;----- sub_323D -----
C000:323D  e87bfe       call   0x30bb                
C000:3240  52           push   dx                    
C000:3241  e8d72d       call   0x601b                
C000:3244  5a           pop    dx                    
C000:3245  c3           ret                          
C000:3296  fa           cli                          
C000:3297  50           push   ax                    
C000:3298  53           push   bx                    
C000:3299  51           push   cx                    
C000:329A  52           push   dx                    
C000:329B  56           push   si                    
C000:329C  57           push   di                    
C000:329D  55           push   bp                    
C000:329E  06           push   es                    
C000:329F  1e           push   ds                    
C000:32A0  83ec02       sub    sp, 2                 
C000:32A3  fc           cld                          
C000:32A4  2e8e1e9032   mov    ds, word ptr cs:[0x3290]
C000:32A9  8bec         mov    bp, sp                
C000:32AB  bad603       mov    dx, 0x3d6             
C000:32AE  b86f00       mov    ax, 0x6f              
C000:32B1  ef           out    dx, ax                
C000:32B2  e84b02       call   0x3500                
C000:32B5  b000         mov    al, 0                 
C000:32B7  bac603       mov    dx, 0x3c6             
C000:32BA  ee           out    dx, al                
C000:32BB  b8345f       mov    ax, 0x5f34            
C000:32BE  bf7464       mov    di, 0x6474            
C000:32C1  ba7474       mov    dx, 0x7474            
C000:32C4  2ef606b20140 test   byte ptr cs:[0x1b2], 0x40
C000:32CA  7436         je     0x3302                
C000:32CC  813e72043412 cmp    word ptr [0x472], 0x1234
C000:32D2  752e         jne    0x3302                
C000:32D4  bacc03       mov    dx, 0x3cc             
C000:32D7  ec           in     al, dx                
C000:32D8  a801         test   al, 1                 
C000:32DA  bad403       mov    dx, 0x3d4             
C000:32DD  7503         jne    0x32e2                
C000:32DF  bab403       mov    dx, 0x3b4             
C000:32E2  b018         mov    al, 0x18              
C000:32E4  e8d62a       call   0x5dbd                
C000:32E7  8ae0         mov    ah, al                
C000:32E9  240f         and    al, 0xf               
C000:32EB  b104         mov    cl, 4                 
C000:32ED  d2ec         shr    ah, cl                
C000:32EF  f6d4         not    ah                    
C000:32F1  80e40f       and    ah, 0xf               
C000:32F4  3ae0         cmp    ah, al                
C000:32F6  750a         jne    0x3302                
C000:32F8  b105         mov    cl, 5                 
C000:32FA  d2e4         shl    ah, cl                
C000:32FC  32c0         xor    al, al                
C000:32FE  09067204     or     word ptr [0x472], ax  
C000:3302  e8bdfa       call   0x2dc2                
C000:3305  b044         mov    al, 0x44              
C000:3307  e835ec       call   0x1f3f                
C000:330A  80cc40       or     ah, 0x40              
C000:330D  ef           out    dx, ax                
C000:330E  bac203       mov    dx, 0x3c2             
C000:3311  b023         mov    al, 0x23              
C000:3313  ee           out    dx, al                
C000:3314  c606490400   mov    byte ptr [0x449], 0   
C000:3319  c606870460   mov    byte ptr [0x487], 0x60
C000:331E  c606890400   mov    byte ptr [0x489], 0   
C000:3323  e80a02       call   0x3530                
C000:3326  bad403       mov    dx, 0x3d4             
C000:3329  89166304     mov    word ptr [0x463], dx  
C000:332D  80261004cf   and    byte ptr [0x410], 0xcf
C000:3332  800e100420   or     byte ptr [0x410], 0x20
C000:3337  800e890401   or     byte ptr [0x489], 1   
C000:333C  b803f9       mov    ax, 0xf903            
C000:333F  88268804     mov    byte ptr [0x488], ah  
C000:3343  32e4         xor    ah, ah                
C000:3345  e891f8       call   0x2bd9                
C000:3348  3c18         cmp    al, 0x18              
C000:334A  7405         je     0x3351                
C000:334C  cd10         int    0x10                   ; service
C000:334E  e8d202       call   0x3623                
C000:3351  800e890410   or     byte ptr [0x489], 0x10
C000:3356  f606890401   test   byte ptr [0x489], 1   
C000:335B  752f         jne    0x338c                
C000:335D  a11004       mov    ax, word ptr [0x410]  
C000:3360  50           push   ax                    
C000:3361  b303         mov    bl, 3                 
C000:3363  b80730       mov    ax, 0x3007            
C000:3366  f606870402   test   byte ptr [0x487], 2   
C000:336B  7405         je     0x3372                
C000:336D  b80320       mov    ax, 0x2003            
C000:3370  b307         mov    bl, 7                 
C000:3372  80261004cf   and    byte ptr [0x410], 0xcf
C000:3377  08261004     or     byte ptr [0x410], ah  
C000:337B  32e4         xor    ah, ah                
C000:337D  cd42         int    0x42                   ; service
C000:337F  58           pop    ax                    
C000:3380  a31004       mov    word ptr [0x410], ax  
C000:3383  8ac3         mov    al, bl                
C000:3385  32e4         xor    ah, ah                
C000:3387  cd10         int    0x10                   ; service
C000:3389  e89702       call   0x3623                
C000:338C  e8ac02       call   0x363b                
C000:338F  08068804     or     byte ptr [0x488], al  
C000:3393  e843f8       call   0x2bd9                
C000:3396  3c18         cmp    al, 0x18              
C000:3398  744e         je     0x33e8                
C000:339A  e83e2c       call   0x5fdb                
C000:339D  bac603       mov    dx, 0x3c6             
C000:33A0  b0ff         mov    al, 0xff              
C000:33A2  ee           out    dx, al                
C000:33A3  bbffff       mov    bx, 0xffff            
C000:33A6  bac803       mov    dx, 0x3c8             
C000:33A9  8ac7         mov    al, bh                
C000:33AB  ee           out    dx, al                
C000:33AC  42           inc    dx                    
C000:33AD  b90300       mov    cx, 3                 
C000:33B0  8ac3         mov    al, bl                
C000:33B2  ee           out    dx, al                
C000:33B3  e2fd         loop   0x33b2                
C000:33B5  4a           dec    dx                    
C000:33B6  80ef01       sub    bh, 1                 
C000:33B9  73ee         jae    0x33a9                
C000:33BB  4a           dec    dx                    
C000:33BC  8ac7         mov    al, bh                
C000:33BE  ee           out    dx, al                
C000:33BF  83c202       add    dx, 2                 
C000:33C2  b90300       mov    cx, 3                 
C000:33C5  8ae3         mov    ah, bl                
C000:33C7  80e43f       and    ah, 0x3f              
C000:33CA  ec           in     al, dx                
C000:33CB  243f         and    al, 0x3f              
C000:33CD  3ac4         cmp    al, ah                
C000:33CF  e1f9         loope  0x33ca                
C000:33D1  7510         jne    0x33e3                
C000:33D3  83ea02       sub    dx, 2                 
C000:33D6  80ef01       sub    bh, 1                 
C000:33D9  73e1         jae    0x33bc                
C000:33DB  42           inc    dx                    
C000:33DC  80eb55       sub    bl, 0x55              
C000:33DF  73c8         jae    0x33a9                
C000:33E1  eb05         jmp    0x33e8                
C000:33E3  b003         mov    al, 3                 
C000:33E5  e85602       call   0x363e                 ; "PSQRP"
C000:33E8  e8eef7       call   0x2bd9                
C000:33EB  3c18         cmp    al, 0x18              
C000:33ED  7506         jne    0x33f5                
C000:33EF  e860d7       call   0xb52                 
C000:33F2  eb40         jmp    0x3434                
C000:33F5  b8070b       mov    ax, 0xb07             
C000:33F8  f606870402   test   byte ptr [0x487], 2   
C000:33FD  7503         jne    0x3402                
C000:33FF  b803f9       mov    ax, 0xf903            
C000:3402  88268804     mov    byte ptr [0x488], ah  
C000:3406  32e4         xor    ah, ah                
C000:3408  e80a07       call   0x3b15                
C000:340B  bac603       mov    dx, 0x3c6             
C000:340E  32c0         xor    al, al                
C000:3410  ee           out    dx, al                
C000:3411  a28a04       mov    byte ptr [0x48a], al  
C000:3414  e83bd7       call   0xb52                 
C000:3417  9c           pushf                        
C000:3418  bac603       mov    dx, 0x3c6             
C000:341B  b0ff         mov    al, 0xff              
C000:341D  ee           out    dx, al                
C000:341E  b80700       mov    ax, 7                 
C000:3421  f606870402   test   byte ptr [0x487], 2   
C000:3426  7502         jne    0x342a                
C000:3428  b003         mov    al, 3                 
C000:342A  cd10         int    0x10                   ; service
C000:342C  9d           popf                         
C000:342D  7405         je     0x3434                
C000:342F  b004         mov    al, 4                 
C000:3431  e80a02       call   0x363e                 ; "PSQRP"
C000:3434  e8a2f7       call   0x2bd9                
C000:3437  3c18         cmp    al, 0x18              
C000:3439  7502         jne    0x343d                
C000:343B  eb74         jmp    0x34b1                
C000:343D  b00e         mov    al, 0xe                ; "VIDEO "
C000:343F  f606870402   test   byte ptr [0x487], 2   
C000:3444  7402         je     0x3448                
C000:3446  b00f         mov    al, 0xf               
C000:3448  e88e00       call   0x34d9                
C000:344B  e81902       call   0x3667                
C000:344E  7514         jne    0x3464                
C000:3450  be0080       mov    si, 0x8000            
C000:3453  e83402       call   0x368a                
C000:3456  750c         jne    0x3464                
C000:3458  be0010       mov    si, 0x1000            
C000:345B  e831fb       call   0x2f8f                
C000:345E  7504         jne    0x3464                
C000:3460  32d2         xor    dl, dl                
C000:3462  eb02         jmp    0x3466                
C000:3464  b203         mov    dl, 3                 
C000:3466  52           push   dx                    
C000:3467  b003         mov    al, 3                 
C000:3469  f606870402   test   byte ptr [0x487], 2   
C000:346E  7402         je     0x3472                
C000:3470  b007         mov    al, 7                 
C000:3472  e8282a       call   0x5e9d                 ; "PSQ<"
C000:3475  e85e2a       call   0x5ed6                
C000:3478  5a           pop    dx                    
C000:3479  bac403       mov    dx, 0x3c4             
C000:347C  b80000       mov    ax, 0                 
C000:347F  ef           out    dx, ax                
C000:3480  e300         jcxz   0x3482                
C000:3482  e300         jcxz   0x3484                
C000:3484  b80003       mov    ax, 0x300             
C000:3487  ef           out    dx, ax                
C000:3488  bad403       mov    dx, 0x3d4             
C000:348B  f606870402   test   byte ptr [0x487], 2   
C000:3490  7403         je     0x3495                
C000:3492  bab403       mov    dx, 0x3b4             
C000:3495  eb1a         jmp    0x34b1                
C000:34B1  e84f02       call   0x3703                
C000:34B4  e8dff9       call   0x2e96                
C000:34B7  a810         test   al, 0x10              
C000:34B9  7403         je     0x34be                
C000:34BB  e807db       call   0xfc5                 
C000:34BE  b044         mov    al, 0x44              
C000:34C0  e87cea       call   0x1f3f                
C000:34C3  80e4bf       and    ah, 0xbf              
C000:34C6  ef           out    dx, ax                
C000:34C7  e82af6       call   0x2af4                 ; "UPSRV"
C000:34CA  8be5         mov    sp, bp                
C000:34CC  83c402       add    sp, 2                 
C000:34CF  1f           pop    ds                    
C000:34D0  07           pop    es                    
C000:34D1  5d           pop    bp                    
C000:34D2  5f           pop    di                    
C000:34D3  5e           pop    si                    
C000:34D4  5a           pop    dx                    
C000:34D5  59           pop    cx                    
C000:34D6  5b           pop    bx                    
C000:34D7  58           pop    ax                    
C000:34D8  cb           retf                         

;----- sub_34D9 -----
C000:34D9  e8c129       call   0x5e9d                 ; "PSQ<"
C000:34DC  e8f729       call   0x5ed6                
C000:34DF  b800a0       mov    ax, 0xa000            
C000:34E2  8ec0         mov    es, ax                
C000:34E4  b80508       mov    ax, 0x805             
C000:34E7  bace03       mov    dx, 0x3ce             
C000:34EA  ef           out    dx, ax                
C000:34EB  b8020f       mov    ax, 0xf02             
C000:34EE  ef           out    dx, ax                
C000:34EF  b8020f       mov    ax, 0xf02             
C000:34F2  bac403       mov    dx, 0x3c4             
C000:34F5  ef           out    dx, ax                
C000:34F6  be0010       mov    si, 0x1000            
C000:34F9  b000         mov    al, 0                 
C000:34FB  bac603       mov    dx, 0x3c6             
C000:34FE  ee           out    dx, al                
C000:34FF  c3           ret                          

;----- sub_3500 -----
C000:3500  b070         mov    al, 0x70              
C000:3502  e83aea       call   0x1f3f                
C000:3505  80fc80       cmp    ah, 0x80              
C000:3508  7425         je     0x352f                
C000:350A  9c           pushf                        
C000:350B  fa           cli                          
C000:350C  bbe846       mov    bx, 0x46e8            
C000:350F  8bd3         mov    dx, bx                
C000:3511  b81600       mov    ax, 0x16              
C000:3514  ef           out    dx, ax                
C000:3515  ba0201       mov    dx, 0x102             
C000:3518  b80100       mov    ax, 1                 
C000:351B  ef           out    dx, ax                
C000:351C  b80e00       mov    ax, 0xe                ; "VIDEO "
C000:351F  8bd3         mov    dx, bx                
C000:3521  ef           out    dx, ax                
C000:3522  bac303       mov    dx, 0x3c3             
C000:3525  b001         mov    al, 1                 
C000:3527  ee           out    dx, al                
C000:3528  33c0         xor    ax, ax                
C000:352A  bae84a       mov    dx, 0x4ae8            
C000:352D  ef           out    dx, ax                
C000:352E  9d           popf                         
C000:352F  c3           ret                          

;----- sub_3530 -----
C000:3530  fa           cli                          
C000:3531  2e8e069232   mov    es, word ptr cs:[0x3292]
C000:3536  bb00f0       mov    bx, 0xf000            
C000:3539  bf4000       mov    di, 0x40              
C000:353C  268b05       mov    ax, word ptr es:[di]  
C000:353F  268b5d02     mov    bx, word ptr es:[di + 2]
C000:3543  bf0801       mov    di, 0x108             
C000:3546  268905       mov    word ptr es:[di], ax  
C000:3549  26895d02     mov    word ptr es:[di + 2], bx
C000:354D  8ccb         mov    bx, cs                
C000:354F  bfb401       mov    di, 0x1b4             
C000:3552  b86038       mov    ax, 0x3860            
C000:3555  e83600       call   0x358e                
C000:3558  bf4000       mov    di, 0x40              
C000:355B  b86038       mov    ax, 0x3860            
C000:355E  e82d00       call   0x358e                
C000:3561  fa           cli                          
C000:3562  2e8e069032   mov    es, word ptr cs:[0x3290]
C000:3567  c706a804d301 mov    word ptr [0x4a8], 0x1d3
C000:356D  8c0eaa04     mov    word ptr [0x4aa], cs  
C000:3571  2e8e069232   mov    es, word ptr cs:[0x3292]
C000:3576  bf7c00       mov    di, 0x7c              
C000:3579  b89879       mov    ax, 0x7998            
C000:357C  e80f00       call   0x358e                
C000:357F  bf0c01       mov    di, 0x10c             
C000:3582  b89875       mov    ax, 0x7598            
C000:3585  e80600       call   0x358e                
C000:3588  bf7400       mov    di, 0x74              
C000:358B  b84f1f       mov    ax, 0x1f4f            

;----- sub_358E -----
C000:358E  ab           stosw  word ptr es:[di], ax  
C000:358F  8bc3         mov    ax, bx                
C000:3591  ab           stosw  word ptr es:[di], ax  
C000:3592  c3           ret                          

;----- sub_3623 -----
C000:3623  e8b427       call   0x5dda                
C000:3626  52           push   dx                    
C000:3627  bad803       mov    dx, 0x3d8             
C000:362A  32c0         xor    al, al                
C000:362C  f606870402   test   byte ptr [0x487], 2   
C000:3631  7505         jne    0x3638                
C000:3633  bab803       mov    dx, 0x3b8             
C000:3636  fec0         inc    al                    
C000:3638  ee           out    dx, al                
C000:3639  5a           pop    dx                    
C000:363A  c3           ret                          

;----- sub_363B -----
C000:363B  b000         mov    al, 0                 
C000:363D  c3           ret                          

;----- sub_363E -----
C000:363E  50           push   ax                    
C000:363F  53           push   bx                    
C000:3640  51           push   cx                    
C000:3641  52           push   dx                    
C000:3642  50           push   ax                    
C000:3643  b9cc06       mov    cx, 0x6cc             
C000:3646  b003         mov    al, 3                 
C000:3648  e8a927       call   0x5df4                
C000:364B  58           pop    ax                    
C000:364C  50           push   ax                    
C000:364D  b92c01       mov    cx, 0x12c             
C000:3650  b000         mov    al, 0                 
C000:3652  e89f27       call   0x5df4                
C000:3655  b94402       mov    cx, 0x244             
C000:3658  b002         mov    al, 2                 
C000:365A  e89727       call   0x5df4                
C000:365D  58           pop    ax                    
C000:365E  fec8         dec    al                    
C000:3660  75ea         jne    0x364c                
C000:3662  5a           pop    dx                    
C000:3663  59           pop    cx                    
C000:3664  5b           pop    bx                    
C000:3665  58           pop    ax                    
C000:3666  c3           ret                          

;----- sub_3667 -----
C000:3667  33ff         xor    di, di                
C000:3669  bace03       mov    dx, 0x3ce             
C000:366C  bbff00       mov    bx, 0xff              
C000:366F  26881d       mov    byte ptr es:[di], bl  
C000:3672  b002         mov    al, 2                 
C000:3674  8ae7         mov    ah, bh                
C000:3676  ef           out    dx, ax                
C000:3677  263a3d       cmp    bh, byte ptr es:[di]  
C000:367A  750b         jne    0x3687                
C000:367C  b002         mov    al, 2                 
C000:367E  8ae3         mov    ah, bl                
C000:3680  ef           out    dx, ax                
C000:3681  263a1d       cmp    bl, byte ptr es:[di]  
C000:3684  7501         jne    0x3687                
C000:3686  c3           ret                          
C000:3687  0adb         or     bl, bl                
C000:3689  c3           ret                          

;----- sub_368A -----
C000:368A  52           push   dx                    
C000:368B  32db         xor    bl, bl                
C000:368D  2ef606b40108 test   byte ptr cs:[0x1b4], 8
C000:3693  7502         jne    0x3697                
C000:3695  fecb         dec    bl                    
C000:3697  e83ff5       call   0x2bd9                
C000:369A  3c18         cmp    al, 0x18              
C000:369C  7428         je     0x36c6                
C000:369E  b002         mov    al, 2                 
C000:36A0  8ae3         mov    ah, bl                
C000:36A2  bace03       mov    dx, 0x3ce             
C000:36A5  ef           out    dx, ax                
C000:36A6  33ff         xor    di, di                
C000:36A8  8ac3         mov    al, bl                
C000:36AA  8bce         mov    cx, si                
C000:36AC  f3aa         rep stosb byte ptr es:[di], al  
C000:36AE  8bce         mov    cx, si                
C000:36B0  f3aa         rep stosb byte ptr es:[di], al  
C000:36B2  33ff         xor    di, di                
C000:36B4  8bce         mov    cx, si                
C000:36B6  b0ff         mov    al, 0xff              
C000:36B8  f3ae         repe scasb al, byte ptr es:[di]  
C000:36BA  750c         jne    0x36c8                
C000:36BC  8bce         mov    cx, si                
C000:36BE  f3ae         repe scasb al, byte ptr es:[di]  
C000:36C0  7506         jne    0x36c8                
C000:36C2  fec3         inc    bl                    
C000:36C4  74d1         je     0x3697                
C000:36C6  3ac0         cmp    al, al                
C000:36C8  5a           pop    dx                    
C000:36C9  c3           ret                          

;----- sub_3703 -----
C000:3703  f606890401   test   byte ptr [0x489], 1   
C000:3708  7528         jne    0x3732                
C000:370A  a11004       mov    ax, word ptr [0x410]  
C000:370D  50           push   ax                    
C000:370E  b303         mov    bl, 3                 
C000:3710  b80730       mov    ax, 0x3007            
C000:3713  f606870402   test   byte ptr [0x487], 2   
C000:3718  7405         je     0x371f                
C000:371A  b80320       mov    ax, 0x2003            
C000:371D  b307         mov    bl, 7                 
C000:371F  80261004cf   and    byte ptr [0x410], 0xcf
C000:3724  08261004     or     byte ptr [0x410], ah  
C000:3728  32e4         xor    ah, ah                
C000:372A  cd42         int    0x42                   ; service
C000:372C  58           pop    ax                    
C000:372D  a31004       mov    word ptr [0x410], ax  
C000:3730  eb1a         jmp    0x374c                
C000:3732  f606890404   test   byte ptr [0x489], 4   
C000:3737  750e         jne    0x3747                
C000:3739  f606870408   test   byte ptr [0x487], 8   
C000:373E  7507         jne    0x3747                
C000:3740  80268704fd   and    byte ptr [0x487], 0xfd
C000:3745  eb05         jmp    0x374c                
C000:3747  800e870402   or     byte ptr [0x487], 2   
C000:374C  e88500       call   0x37d4                
C000:374F  b80920       mov    ax, 0x2009            
C000:3752  b303         mov    bl, 3                 
C000:3754  f606870402   test   byte ptr [0x487], 2   
C000:3759  7405         je     0x3760                
C000:375B  b80b30       mov    ax, 0x300b            
C000:375E  b307         mov    bl, 7                 
C000:3760  80268804f0   and    byte ptr [0x488], 0xf0
C000:3765  08068804     or     byte ptr [0x488], al  
C000:3769  80261004cf   and    byte ptr [0x410], 0xcf
C000:376E  08261004     or     byte ptr [0x410], ah  
C000:3772  a08704       mov    al, byte ptr [0x487]  
C000:3775  2408         and    al, 8                 
C000:3777  80268704f7   and    byte ptr [0x487], 0xf7
C000:377C  8a268904     mov    ah, byte ptr [0x489]  
C000:3780  80e401       and    ah, 1                 
C000:3783  80268904fe   and    byte ptr [0x489], 0xfe
C000:3788  50           push   ax                    
C000:3789  32e4         xor    ah, ah                
C000:378B  8ac3         mov    al, bl                
C000:378D  cd10         int    0x10                   ; service
C000:378F  58           pop    ax                    
C000:3790  08268904     or     byte ptr [0x489], ah  
C000:3794  e8bef7       call   0x2f55                
C000:3797  f6c401       test   ah, 1                 
C000:379A  7533         jne    0x37cf                
C000:379C  a808         test   al, 8                 
C000:379E  742f         je     0x37cf                
C000:37A0  50           push   ax                    
C000:37A1  b80330       mov    ax, 0x3003            
C000:37A4  b307         mov    bl, 7                 
C000:37A6  f606870402   test   byte ptr [0x487], 2   
C000:37AB  7405         je     0x37b2                
C000:37AD  b80520       mov    ax, 0x2005            
C000:37B0  b303         mov    bl, 3                 
C000:37B2  80268804f0   and    byte ptr [0x488], 0xf0
C000:37B7  08068804     or     byte ptr [0x488], al  
C000:37BB  80261004cf   and    byte ptr [0x410], 0xcf
C000:37C0  08261004     or     byte ptr [0x410], ah  
C000:37C4  58           pop    ax                    
C000:37C5  08068704     or     byte ptr [0x487], al  
C000:37C9  32e4         xor    ah, ah                
C000:37CB  8ac3         mov    al, bl                
C000:37CD  cd10         int    0x10                   ; service
C000:37CF  c3           ret                          

;----- sub_37D4 -----
C000:37D4  a08704       mov    al, byte ptr [0x487]  
C000:37D7  2402         and    al, 2                 
C000:37D9  8a268904     mov    ah, byte ptr [0x489]  
C000:37DD  80e401       and    ah, 1                 
C000:37E0  0ac4         or     al, ah                
C000:37E2  32e4         xor    ah, ah                
C000:37E4  8bd8         mov    bx, ax                
C000:37E6  2e8a87d037   mov    al, byte ptr cs:[bx + 0x37d0]
C000:37EB  a28a04       mov    byte ptr [0x48a], al  
C000:37EE  3c0e         cmp    al, 0xe                ; "VIDEO "
C000:37F0  7525         jne    0x3817                
C000:37F2  1e           push   ds                    
C000:37F3  b800c6       mov    ax, 0xc600            
C000:37F6  8ed8         mov    ds, ax                
C000:37F8  8a26d403     mov    ah, byte ptr [0x3d4]  
C000:37FC  c606d40328   mov    byte ptr [0x3d4], 0x28
C000:3801  eb00         jmp    0x3803                
C000:3803  bad403       mov    dx, 0x3d4             
C000:3806  ec           in     al, dx                
C000:3807  eb00         jmp    0x3809                
C000:3809  8826d403     mov    byte ptr [0x3d4], ah  
C000:380D  1f           pop    ds                    
C000:380E  3c28         cmp    al, 0x28              
C000:3810  7505         jne    0x3817                
C000:3812  c6068a040f   mov    byte ptr [0x48a], 0xf 
C000:3817  c3           ret                          

;----- sub_3861 -----
C000:3861  fc           cld                          
C000:3862  80fc0e       cmp    ah, 0xe                ; "VIDEO "
C000:3865  7439         je     0x38a0                
C000:3867  80fc0c       cmp    ah, 0xc               
C000:386A  7438         je     0x38a4                
C000:386C  80fc0d       cmp    ah, 0xd               
C000:386F  7437         je     0x38a8                
C000:3871  50           push   ax                    
C000:3872  53           push   bx                    
C000:3873  51           push   cx                    
C000:3874  52           push   dx                    
C000:3875  56           push   si                    
C000:3876  57           push   di                    
C000:3877  55           push   bp                    
C000:3878  06           push   es                    
C000:3879  1e           push   ds                    
C000:387A  8bec         mov    bp, sp                
C000:387C  2e8e1e9032   mov    ds, word ptr cs:[0x3290]
C000:3881  8bf0         mov    si, ax                
C000:3883  8ac4         mov    al, ah                
C000:3885  32e4         xor    ah, ah                
C000:3887  3c1f         cmp    al, 0x1f              
C000:3889  7320         jae    0x38ab                
C000:388B  d1e0         shl    ax, 1                 
C000:388D  96           xchg   si, ax                
C000:388E  2eff942038   call   word ptr cs:[si + 0x3820]
C000:3893  1f           pop    ds                    
C000:3894  07           pop    es                    
C000:3895  5d           pop    bp                    
C000:3896  5f           pop    di                    
C000:3897  5e           pop    si                    
C000:3898  5a           pop    dx                    
C000:3899  59           pop    cx                    
C000:389A  5b           pop    bx                    
C000:389B  58           pop    ax                    
C000:389C  cf           iret                         
C000:38A0  e9e715       jmp    0x4e8a                 ; "PSQRVWU"
C000:38A4  e95314       jmp    0x4cfa                
C000:38A8  e91b15       jmp    0x4dc6                
C000:38AB  8bc6         mov    ax, si                
C000:38AD  e80fe7       call   0x1fbf                
C000:38B0  837e104f     cmp    word ptr [bp + 0x10], 0x4f
C000:38B4  74dd         je     0x3893                
C000:38B6  817e104f01   cmp    word ptr [bp + 0x10], 0x14f
C000:38BB  74d6         je     0x3893                
C000:38BD  837e105f     cmp    word ptr [bp + 0x10], 0x5f
C000:38C1  7209         jb     0x38cc                
C000:38C3  817e105f01   cmp    word ptr [bp + 0x10], 0x15f
C000:38C8  7702         ja     0x38cc                
C000:38CA  ebc7         jmp    0x3893                
C000:38CC  8b4610       mov    ax, word ptr [bp + 0x10]
C000:38CF  8e5e00       mov    ds, word ptr [bp]     
C000:38D2  55           push   bp                    
C000:38D3  8b6e04       mov    bp, word ptr [bp + 4] 
C000:38D6  cd42         int    0x42                   ; service
C000:38D8  5d           pop    bp                    
C000:38D9  894610       mov    word ptr [bp + 0x10], ax
C000:38DC  ebb5         jmp    0x3893                

;----- sub_3B15 -----
C000:3B15  a24904       mov    byte ptr [0x449], al  
C000:3B18  e80502       call   0x3d20                
C000:3B1B  80268704f3   and    byte ptr [0x487], 0xf3
C000:3B20  e8a502       call   0x3dc8                
C000:3B23  e8b023       call   0x5ed6                
C000:3B26  a04904       mov    al, byte ptr [0x449]  
C000:3B29  e8f5d6       call   0x1221                 ; "PSQRW"
C000:3B2C  e8ec24       call   0x601b                
C000:3B2F  8b166304     mov    dx, word ptr [0x463]  
C000:3B33  a04904       mov    al, byte ptr [0x449]  
C000:3B36  3c04         cmp    al, 4                 
C000:3B38  720f         jb     0x3b49                
C000:3B3A  3c07         cmp    al, 7                 
C000:3B3C  740b         je     0x3b49                
C000:3B3E  3c13         cmp    al, 0x13              
C000:3B40  760c         jbe    0x3b4e                
C000:3B42  8ae0         mov    ah, al                
C000:3B44  e80be3       call   0x1e52                
C000:3B47  7205         jb     0x3b4e                
C000:3B49  e84300       call   0x3b8f                
C000:3B4C  eb14         jmp    0x3b62                
C000:3B4E  c70660040000 mov    word ptr [0x460], 0   
C000:3B54  b80700       mov    ax, 7                 
C000:3B57  bb0c00       mov    bx, 0xc               
C000:3B5A  e88802       call   0x3de5                
C000:3B5D  7503         jne    0x3b62                
C000:3B5F  e84803       call   0x3eaa                
C000:3B62  f606870480   test   byte ptr [0x487], 0x80
C000:3B67  750a         jne    0x3b73                
C000:3B69  a14c04       mov    ax, word ptr [0x44c]  
C000:3B6C  0bc0         or     ax, ax                
C000:3B6E  7403         je     0x3b73                
C000:3B70  e8f503       call   0x3f68                
C000:3B73  e85b03       call   0x3ed1                
C000:3B76  e85b22       call   0x5dd4                
C000:3B79  e86724       call   0x5fe3                
C000:3B7C  b311         mov    bl, 0x11              
C000:3B7E  e8a915       call   0x512a                
C000:3B81  887e10       mov    byte ptr [bp + 0x10], bh
C000:3B84  b055         mov    al, 0x55              
C000:3B86  e8b6e3       call   0x1f3f                
C000:3B89  e880cf       call   0xb0c                 
C000:3B8C  7400         je     0x3b8e                
C000:3B8E  c3           ret                          

;----- sub_3B8F -----
C000:3B8F  b80b00       mov    ax, 0xb               
C000:3B92  bb0800       mov    bx, 8                 
C000:3B95  e84d02       call   0x3de5                
C000:3B98  7505         jne    0x3b9f                
C000:3B9A  e86902       call   0x3e06                
C000:3B9D  eb03         jmp    0x3ba2                
C000:3B9F  e8df02       call   0x3e81                
C000:3BA2  bb1000       mov    bx, 0x10              
C000:3BA5  e81504       call   0x3fbd                
C000:3BA8  7415         je     0x3bbf                
C000:3BAA  26c45f06     les    bx, ptr es:[bx + 6]   
C000:3BAE  8cc0         mov    ax, es                
C000:3BB0  0bc3         or     ax, bx                
C000:3BB2  740b         je     0x3bbf                
C000:3BB4  b80700       mov    ax, 7                 
C000:3BB7  e83302       call   0x3ded                
C000:3BBA  7503         jne    0x3bbf                
C000:3BBC  e87602       call   0x3e35                
C000:3BBF  c3           ret                          

;----- sub_3D20 -----
C000:3D20  2e8e069232   mov    es, word ptr cs:[0x3292]
C000:3D25  bf0c01       mov    di, 0x10c             
C000:3D28  3c13         cmp    al, 0x13              
C000:3D2A  761c         jbe    0x3d48                
C000:3D2C  e8f2d9       call   0x1721                
C000:3D2F  7517         jne    0x3d48                
C000:3D31  bb9875       mov    bx, 0x7598            
C000:3D34  a801         test   al, 1                 
C000:3D36  752e         jne    0x3d66                
C000:3D38  2470         and    al, 0x70              
C000:3D3A  742a         je     0x3d66                
C000:3D3C  bb987d       mov    bx, 0x7d98            
C000:3D3F  3c20         cmp    al, 0x20              
C000:3D41  7623         jbe    0x3d66                
C000:3D43  bb7464       mov    bx, 0x6474            
C000:3D46  eb1e         jmp    0x3d66                
C000:3D48  bb9875       mov    bx, 0x7598            
C000:3D4B  3c13         cmp    al, 0x13              
C000:3D4D  7417         je     0x3d66                
C000:3D4F  3c08         cmp    al, 8                 
C000:3D51  7213         jb     0x3d66                
C000:3D53  bb7464       mov    bx, 0x6474            
C000:3D56  740e         je     0x3d66                
C000:3D58  3c11         cmp    al, 0x11              
C000:3D5A  730a         jae    0x3d66                
C000:3D5C  bb987d       mov    bx, 0x7d98            
C000:3D5F  3c0f         cmp    al, 0xf               
C000:3D61  7303         jae    0x3d66                
C000:3D63  bb9875       mov    bx, 0x7598            
C000:3D66  8bc3         mov    ax, bx                
C000:3D68  9c           pushf                        
C000:3D69  fa           cli                          
C000:3D6A  ab           stosw  word ptr es:[di], ax  
C000:3D6B  8cc8         mov    ax, cs                
C000:3D6D  ab           stosw  word ptr es:[di], ax  
C000:3D6E  9d           popf                         
C000:3D6F  8cd8         mov    ax, ds                
C000:3D71  8ec0         mov    es, ax                
C000:3D73  bf5004       mov    di, 0x450             
C000:3D76  b90800       mov    cx, 8                 
C000:3D79  33c0         xor    ax, ax                
C000:3D7B  f3ab         rep stosw word ptr es:[di], ax  
C000:3D7D  a26204       mov    byte ptr [0x462], al  
C000:3D80  a34e04       mov    word ptr [0x44e], ax  
C000:3D83  a04904       mov    al, byte ptr [0x449]  
C000:3D86  3c07         cmp    al, 7                 
C000:3D88  7718         ja     0x3da2                
C000:3D8A  32e4         xor    ah, ah                
C000:3D8C  8bf8         mov    di, ax                
C000:3D8E  b03f         mov    al, 0x3f              
C000:3D90  83ff06       cmp    di, 6                 
C000:3D93  7402         je     0x3d97                
C000:3D95  b030         mov    al, 0x30              
C000:3D97  a26604       mov    byte ptr [0x466], al  
C000:3D9A  2e8a85c539   mov    al, byte ptr cs:[di + 0x39c5]
C000:3D9F  a26504       mov    byte ptr [0x465], al  
C000:3DA2  e8f520       call   0x5e9a                
C000:3DA5  56           push   si                    
C000:3DA6  26ac         lodsb  al, byte ptr es:[si]  
C000:3DA8  32e4         xor    ah, ah                
C000:3DAA  a34a04       mov    word ptr [0x44a], ax  
C000:3DAD  26ac         lodsb  al, byte ptr es:[si]  
C000:3DAF  a28404       mov    byte ptr [0x484], al  
C000:3DB2  26ac         lodsb  al, byte ptr es:[si]  
C000:3DB4  a38504       mov    word ptr [0x485], ax  
C000:3DB7  26ad         lodsw  ax, word ptr es:[si]  
C000:3DB9  a34c04       mov    word ptr [0x44c], ax  
C000:3DBC  83c60f       add    si, 0xf               
C000:3DBF  26ad         lodsw  ax, word ptr es:[si]  
C000:3DC1  86c4         xchg   ah, al                
C000:3DC3  a36004       mov    word ptr [0x460], ax  
C000:3DC6  5e           pop    si                    
C000:3DC7  c3           ret                          

;----- sub_3DC8 -----
C000:3DC8  1e           push   ds                    
C000:3DC9  06           push   es                    
C000:3DCA  56           push   si                    
C000:3DCB  06           push   es                    
C000:3DCC  bb0400       mov    bx, 4                 
C000:3DCF  e8eb01       call   0x3fbd                
C000:3DD2  1f           pop    ds                    
C000:3DD3  740c         je     0x3de1                
C000:3DD5  83c623       add    si, 0x23              
C000:3DD8  8bfb         mov    di, bx                
C000:3DDA  b90800       mov    cx, 8                 
C000:3DDD  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:3DDF  46           inc    si                    
C000:3DE0  a4           movsb  byte ptr es:[di], byte ptr [si]
C000:3DE1  5e           pop    si                    
C000:3DE2  07           pop    es                    
C000:3DE3  1f           pop    ds                    
C000:3DE4  c3           ret                          

;----- sub_3DE5 -----
C000:3DE5  e8d501       call   0x3fbd                
C000:3DE8  7503         jne    0x3ded                
C000:3DEA  0cff         or     al, 0xff              
C000:3DEC  c3           ret                          

;----- sub_3DED -----
C000:3DED  53           push   bx                    
C000:3DEE  03d8         add    bx, ax                
C000:3DF0  a04904       mov    al, byte ptr [0x449]  
C000:3DF3  268a27       mov    ah, byte ptr es:[bx]  
C000:3DF6  43           inc    bx                    
C000:3DF7  80fcff       cmp    ah, 0xff              
C000:3DFA  7406         je     0x3e02                
C000:3DFC  3ac4         cmp    al, ah                
C000:3DFE  75f3         jne    0x3df3                
C000:3E00  5b           pop    bx                    
C000:3E01  c3           ret                          
C000:3E02  0cff         or     al, 0xff              
C000:3E04  5b           pop    bx                    
C000:3E05  c3           ret                          

;----- sub_3E06 -----
C000:3E06  268a470a     mov    al, byte ptr es:[bx + 0xa]
C000:3E0A  50           push   ax                    
C000:3E0B  268b4f02     mov    cx, word ptr es:[bx + 2]
C000:3E0F  268b5704     mov    dx, word ptr es:[bx + 4]
C000:3E13  268b7706     mov    si, word ptr es:[bx + 6]
C000:3E17  268b4708     mov    ax, word ptr es:[bx + 8]
C000:3E1B  268b1f       mov    bx, word ptr es:[bx]  
C000:3E1E  86df         xchg   bh, bl                
C000:3E20  80e33f       and    bl, 0x3f              
C000:3E23  8ec0         mov    es, ax                
C000:3E25  b010         mov    al, 0x10              
C000:3E27  e8ef13       call   0x5219                
C000:3E2A  58           pop    ax                    
C000:3E2B  fec0         inc    al                    
C000:3E2D  7405         je     0x3e34                
C000:3E2F  48           dec    ax                    
C000:3E30  48           dec    ax                    
C000:3E31  a28404       mov    byte ptr [0x484], al  
C000:3E34  c3           ret                          

;----- sub_3E35 -----
C000:3E35  268a07       mov    al, byte ptr es:[bx]  
C000:3E38  32e4         xor    ah, ah                
C000:3E3A  3b068504     cmp    ax, word ptr [0x485]  
C000:3E3E  7540         jne    0x3e80                
C000:3E40  b90001       mov    cx, 0x100             
C000:3E43  33d2         xor    dx, dx                
C000:3E45  268b7703     mov    si, word ptr es:[bx + 3]
C000:3E49  268b4705     mov    ax, word ptr es:[bx + 5]
C000:3E4D  268b1f       mov    bx, word ptr es:[bx]  
C000:3E50  86df         xchg   bh, bl                
C000:3E52  80e33f       and    bl, 0x3f              
C000:3E55  8ec0         mov    es, ax                
C000:3E57  32c0         xor    al, al                
C000:3E59  53           push   bx                    
C000:3E5A  e8bc13       call   0x5219                
C000:3E5D  bac403       mov    dx, 0x3c4             
C000:3E60  b003         mov    al, 3                 
C000:3E62  e8491f       call   0x5dae                
C000:3E65  80e413       and    ah, 0x13              
C000:3E68  5b           pop    bx                    
C000:3E69  8afb         mov    bh, bl                
C000:3E6B  80e303       and    bl, 3                 
C000:3E6E  b102         mov    cl, 2                 
C000:3E70  d2e3         shl    bl, cl                
C000:3E72  80e704       and    bh, 4                 
C000:3E75  fec1         inc    cl                    
C000:3E77  d2e7         shl    bh, cl                
C000:3E79  0ae3         or     ah, bl                
C000:3E7B  0ae7         or     ah, bh                
C000:3E7D  b003         mov    al, 3                 
C000:3E7F  ef           out    dx, ax                
C000:3E80  c3           ret                          

;----- sub_3E81 -----
C000:3E81  32db         xor    bl, bl                
C000:3E83  b001         mov    al, 1                 
C000:3E85  833e85040e   cmp    word ptr [0x485], 0xe  ; "VIDEO "
C000:3E8A  7410         je     0x3e9c                
C000:3E8C  b002         mov    al, 2                 
C000:3E8E  833e850408   cmp    word ptr [0x485], 8   
C000:3E93  7411         je     0x3ea6                
C000:3E95  b004         mov    al, 4                 
C000:3E97  80cb40       or     bl, 0x40              
C000:3E9A  eb0a         jmp    0x3ea6                
C000:3E9C  803e490407   cmp    byte ptr [0x449], 7   
C000:3EA1  7503         jne    0x3ea6                
C000:3EA3  80cb80       or     bl, 0x80              
C000:3EA6  e87013       call   0x5219                
C000:3EA9  c3           ret                          

;----- sub_3EAA -----
C000:3EAA  268a07       mov    al, byte ptr es:[bx]  
C000:3EAD  fec8         dec    al                    
C000:3EAF  a28404       mov    byte ptr [0x484], al  
C000:3EB2  268b4701     mov    ax, word ptr es:[bx + 1]
C000:3EB6  a38504       mov    word ptr [0x485], ax  
C000:3EB9  268b4703     mov    ax, word ptr es:[bx + 3]
C000:3EBD  268b5f05     mov    bx, word ptr es:[bx + 5]
C000:3EC1  2e8e069232   mov    es, word ptr cs:[0x3292]
C000:3EC6  bf0c01       mov    di, 0x10c             
C000:3EC9  9c           pushf                        
C000:3ECA  fa           cli                          
C000:3ECB  ab           stosw  word ptr es:[di], ax  
C000:3ECC  8bc3         mov    ax, bx                
C000:3ECE  ab           stosw  word ptr es:[di], ax  
C000:3ECF  9d           popf                         
C000:3ED0  c3           ret                          

;----- sub_3ED1 -----
C000:3ED1  bb1000       mov    bx, 0x10              
C000:3ED4  e8e600       call   0x3fbd                
C000:3ED7  7412         je     0x3eeb                
C000:3ED9  26c45f0a     les    bx, ptr es:[bx + 0xa] 
C000:3EDD  8cc0         mov    ax, es                
C000:3EDF  0bc3         or     ax, bx                
C000:3EE1  7408         je     0x3eeb                
C000:3EE3  b81400       mov    ax, 0x14              
C000:3EE6  e804ff       call   0x3ded                
C000:3EE9  7401         je     0x3eec                
C000:3EEB  c3           ret                          
C000:3EEC  f606890408   test   byte ptr [0x489], 8   
C000:3EF1  7559         jne    0x3f4c                
C000:3EF3  8b166304     mov    dx, word ptr [0x463]  
C000:3EF7  83c206       add    dx, 6                 
C000:3EFA  ec           in     al, dx                
C000:3EFB  1e           push   ds                    
C000:3EFC  53           push   bx                    
C000:3EFD  268b470e     mov    ax, word ptr es:[bx + 0xe]
C000:3F01  8ae0         mov    ah, al                
C000:3F03  26c57710     lds    si, ptr es:[bx + 0x10]
C000:3F07  268b5f0c     mov    bx, word ptr es:[bx + 0xc]
C000:3F0B  0bdb         or     bx, bx                
C000:3F0D  7414         je     0x3f23                
C000:3F0F  bac803       mov    dx, 0x3c8             
C000:3F12  8ac4         mov    al, ah                
C000:3F14  ee           out    dx, al                
C000:3F15  42           inc    dx                    
C000:3F16  b90300       mov    cx, 3                 
C000:3F19  ac           lodsb  al, byte ptr [si]     
C000:3F1A  ee           out    dx, al                
C000:3F1B  e2fc         loop   0x3f19                
C000:3F1D  fec4         inc    ah                    
C000:3F1F  4a           dec    dx                    
C000:3F20  4b           dec    bx                    
C000:3F21  75ef         jne    0x3f12                
C000:3F23  5b           pop    bx                    
C000:3F24  268b4706     mov    ax, word ptr es:[bx + 6]
C000:3F28  8ae0         mov    ah, al                
C000:3F2A  26c57708     lds    si, ptr es:[bx + 8]   
C000:3F2E  268b4f04     mov    cx, word ptr es:[bx + 4]
C000:3F32  e317         jcxz   0x3f4b                
C000:3F34  bac003       mov    dx, 0x3c0             
C000:3F37  8ac4         mov    al, ah                
C000:3F39  ee           out    dx, al                
C000:3F3A  eb00         jmp    0x3f3c                
C000:3F3C  ac           lodsb  al, byte ptr [si]     
C000:3F3D  ee           out    dx, al                
C000:3F3E  fec4         inc    ah                    
C000:3F40  e2f5         loop   0x3f37                
C000:3F42  fec4         inc    ah                    
C000:3F44  8ac4         mov    al, ah                
C000:3F46  ee           out    dx, al                
C000:3F47  eb00         jmp    0x3f49                
C000:3F49  ac           lodsb  al, byte ptr [si]     
C000:3F4A  ee           out    dx, al                
C000:3F4B  1f           pop    ds                    
C000:3F4C  268a07       mov    al, byte ptr es:[bx]  
C000:3F4F  0ac0         or     al, al                
C000:3F51  7414         je     0x3f67                
C000:3F53  a880         test   al, 0x80              
C000:3F55  b01f         mov    al, 0x1f              
C000:3F57  7505         jne    0x3f5e                
C000:3F59  a18504       mov    ax, word ptr [0x485]  
C000:3F5C  fec8         dec    al                    
C000:3F5E  8b166304     mov    dx, word ptr [0x463]  
C000:3F62  8ae0         mov    ah, al                
C000:3F64  b014         mov    al, 0x14              
C000:3F66  ef           out    dx, ax                
C000:3F67  c3           ret                          

;----- sub_3F68 -----
C000:3F68  b90040       mov    cx, 0x4000            
C000:3F6B  8a1e4904     mov    bl, byte ptr [0x449]  
C000:3F6F  80fb13       cmp    bl, 0x13              
C000:3F72  7624         jbe    0x3f98                
C000:3F74  8ac3         mov    al, bl                
C000:3F76  e8a8d7       call   0x1721                
C000:3F79  751d         jne    0x3f98                
C000:3F7B  8ad8         mov    bl, al                
C000:3F7D  b7b8         mov    bh, 0xb8              
C000:3F7F  b82007       mov    ax, 0x720             
C000:3F82  f6c302       test   bl, 2                 
C000:3F85  7502         jne    0x3f89                
C000:3F87  b7b0         mov    bh, 0xb0              
C000:3F89  f6c301       test   bl, 1                 
C000:3F8C  7526         jne    0x3fb4                
C000:3F8E  33c0         xor    ax, ax                
C000:3F90  f6c380       test   bl, 0x80              
C000:3F93  741b         je     0x3fb0                
C000:3F95  e900de       jmp    0x1d98                
C000:3F98  b7b0         mov    bh, 0xb0              
C000:3F9A  b82007       mov    ax, 0x720             
C000:3F9D  80fb07       cmp    bl, 7                 
C000:3FA0  7412         je     0x3fb4                
C000:3FA2  b7b8         mov    bh, 0xb8              
C000:3FA4  80fb03       cmp    bl, 3                 
C000:3FA7  760b         jbe    0x3fb4                
C000:3FA9  33c0         xor    ax, ax                
C000:3FAB  80fb06       cmp    bl, 6                 
C000:3FAE  7604         jbe    0x3fb4                
C000:3FB0  b7a0         mov    bh, 0xa0              
C000:3FB2  b580         mov    ch, 0x80              
C000:3FB4  32db         xor    bl, bl                
C000:3FB6  8ec3         mov    es, bx                
C000:3FB8  33ff         xor    di, di                
C000:3FBA  f3ab         rep stosw word ptr es:[di], ax  
C000:3FBC  c3           ret                          

;----- sub_3FBD -----
C000:3FBD  57           push   di                    
C000:3FBE  c43ea804     les    di, ptr [0x4a8]       
C000:3FC2  26c419       les    bx, ptr es:[bx + di]  
C000:3FC5  8cc7         mov    di, es                
C000:3FC7  0bfb         or     di, bx                
C000:3FC9  5f           pop    di                    
C000:3FCA  c3           ret                          

;----- sub_407C -----
C000:407C  8ac7         mov    al, bh                
C000:407E  86df         xchg   bh, bl                
C000:4080  32ff         xor    bh, bh                
C000:4082  d1e3         shl    bx, 1                 
C000:4084  89975004     mov    word ptr [bx + 0x450], dx
C000:4088  38066204     cmp    byte ptr [0x462], al  
C000:408C  7520         jne    0x40ae                
C000:408E  a04a04       mov    al, byte ptr [0x44a]  
C000:4091  f6e6         mul    dh                    
C000:4093  02c2         add    al, dl                
C000:4095  80d400       adc    ah, 0                 
C000:4098  8b1e4e04     mov    bx, word ptr [0x44e]  
C000:409C  d1eb         shr    bx, 1                 
C000:409E  03d8         add    bx, ax                
C000:40A0  b00e         mov    al, 0xe                ; "VIDEO "
C000:40A2  8b166304     mov    dx, word ptr [0x463]  
C000:40A6  8ae7         mov    ah, bh                
C000:40A8  ef           out    dx, ax                
C000:40A9  8ae3         mov    ah, bl                
C000:40AB  fec0         inc    al                    
C000:40AD  ef           out    dx, ax                
C000:40AE  c3           ret                          

;----- sub_4122 -----
C000:4122  83ec04       sub    sp, 4                 
C000:4125  8bec         mov    bp, sp                
C000:4127  894600       mov    word ptr [bp], ax     
C000:412A  895e02       mov    word ptr [bp + 2], bx 
C000:412D  8bc1         mov    ax, cx                
C000:412F  803e490413   cmp    byte ptr [0x449], 0x13
C000:4134  740c         je     0x4142                
C000:4136  772b         ja     0x4163                
C000:4138  803e490407   cmp    byte ptr [0x449], 7   
C000:413D  766d         jbe    0x41ac                
C000:413F  e9f002       jmp    0x4432                
C000:4142  8bf2         mov    si, dx                
C000:4144  8bf8         mov    di, ax                
C000:4146  81e7ff00     and    di, 0xff              
C000:414A  8ac4         mov    al, ah                
C000:414C  f6264a04     mul    byte ptr [0x44a]      
C000:4150  f7268504     mul    word ptr [0x485]      
C000:4154  03f8         add    di, ax                
C000:4156  d1e7         shl    di, 1                 
C000:4158  d1e7         shl    di, 1                 
C000:415A  d1e7         shl    di, 1                 
C000:415C  8bd6         mov    dx, si                
C000:415E  8bc1         mov    ax, cx                
C000:4160  e90504       jmp    0x4568                
C000:4163  8a264904     mov    ah, byte ptr [0x449]  
C000:4167  e8e8dc       call   0x1e52                
C000:416A  8bc1         mov    ax, cx                
C000:416C  733e         jae    0x41ac                
C000:416E  75cf         jne    0x413f                
C000:4170  e9afd6       jmp    0x1822                
C000:41AC  8bf0         mov    si, ax                
C000:41AE  a01004       mov    al, byte ptr [0x410]  
C000:41B1  2430         and    al, 0x30              
C000:41B3  3c30         cmp    al, 0x30              
C000:41B5  b800b0       mov    ax, 0xb000            
C000:41B8  7402         je     0x41bc                
C000:41BA  b4b8         mov    ah, 0xb8              
C000:41BC  8ec0         mov    es, ax                
C000:41BE  8bc6         mov    ax, si                
C000:41C0  2ad0         sub    dl, al                
C000:41C2  2af4         sub    dh, ah                
C000:41C4  8a4600       mov    al, byte ptr [bp]     
C000:41C7  fec2         inc    dl                    
C000:41C9  fec6         inc    dh                    
C000:41CB  8ae6         mov    ah, dh                
C000:41CD  0ac0         or     al, al                
C000:41CF  7404         je     0x41d5                
C000:41D1  2ae0         sub    ah, al                
C000:41D3  7704         ja     0x41d9                
C000:41D5  8ac6         mov    al, dh                
C000:41D7  32e4         xor    ah, ah                
C000:41D9  50           push   ax                    
C000:41DA  8a264904     mov    ah, byte ptr [0x449]  
C000:41DE  80fc03       cmp    ah, 3                 
C000:41E1  760f         jbe    0x41f2                
C000:41E3  80fc07       cmp    ah, 7                 
C000:41E6  740a         je     0x41f2                
C000:41E8  80fc13       cmp    ah, 0x13              
C000:41EB  7705         ja     0x41f2                
C000:41ED  e9c600       jmp    0x42b6                
C000:41F2  8ad8         mov    bl, al                
C000:41F4  8ac5         mov    al, ch                
C000:41F6  f6264a04     mul    byte ptr [0x44a]      
C000:41FA  02c1         add    al, cl                
C000:41FC  80d400       adc    ah, 0                 
C000:41FF  8b3e4e04     mov    di, word ptr [0x44e]  
C000:4203  d1ef         shr    di, 1                 
C000:4205  03f8         add    di, ax                
C000:4207  8ac3         mov    al, bl                
C000:4209  d1e7         shl    di, 1                 
C000:420B  8bf7         mov    si, di                
C000:420D  8b1e4a04     mov    bx, word ptr [0x44a]  
C000:4211  f6e3         mul    bl                    
C000:4213  50           push   ax                    
C000:4214  d1e0         shl    ax, 1                 
C000:4216  d1e3         shl    bx, 1                 
C000:4218  807e0106     cmp    byte ptr [bp + 1], 6  
C000:421C  7404         je     0x4222                
C000:421E  f7d8         neg    ax                    
C000:4220  f7db         neg    bx                    
C000:4222  8aca         mov    cl, dl                
C000:4224  32ed         xor    ch, ch                
C000:4226  03f0         add    si, ax                
C000:4228  a04904       mov    al, byte ptr [0x449]  
C000:422B  3c02         cmp    al, 2                 
C000:422D  721c         jb     0x424b                
C000:422F  3c03         cmp    al, 3                 
C000:4231  7718         ja     0x424b                
C000:4233  f606870404   test   byte ptr [0x487], 4   
C000:4238  7411         je     0x424b                
C000:423A  bada03       mov    dx, 0x3da             
C000:423D  ec           in     al, dx                
C000:423E  a808         test   al, 8                 
C000:4240  74fb         je     0x423d                
C000:4242  83ea02       sub    dx, 2                 
C000:4245  a06504       mov    al, byte ptr [0x465]  
C000:4248  24f7         and    al, 0xf7              
C000:424A  ee           out    dx, al                
C000:424B  8cc0         mov    ax, es                
C000:424D  8ed8         mov    ds, ax                
C000:424F  58           pop    ax                    
C000:4250  5a           pop    dx                    
C000:4251  3b0e4a04     cmp    cx, word ptr [0x44a]  
C000:4255  7515         jne    0x426c                
C000:4257  8bd8         mov    bx, ax                
C000:4259  8ac1         mov    al, cl                
C000:425B  f6e6         mul    dh                    
C000:425D  8bc8         mov    cx, ax                
C000:425F  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:4261  8bcb         mov    cx, bx                
C000:4263  b020         mov    al, 0x20              
C000:4265  8a6603       mov    ah, byte ptr [bp + 3] 
C000:4268  f3ab         rep stosw word ptr es:[di], ax  
C000:426A  eb27         jmp    0x4293                
C000:426C  0af6         or     dh, dh                
C000:426E  7412         je     0x4282                
C000:4270  51           push   cx                    
C000:4271  56           push   si                    
C000:4272  8bc7         mov    ax, di                
C000:4274  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:4276  8bf8         mov    di, ax                
C000:4278  5e           pop    si                    
C000:4279  59           pop    cx                    
C000:427A  03f3         add    si, bx                
C000:427C  03fb         add    di, bx                
C000:427E  fece         dec    dh                    
C000:4280  75ee         jne    0x4270                
C000:4282  b020         mov    al, 0x20              
C000:4284  8a6603       mov    ah, byte ptr [bp + 3] 
C000:4287  51           push   cx                    
C000:4288  57           push   di                    
C000:4289  f3ab         rep stosw word ptr es:[di], ax  
C000:428B  5f           pop    di                    
C000:428C  59           pop    cx                    
C000:428D  03fb         add    di, bx                
C000:428F  feca         dec    dl                    
C000:4291  75f4         jne    0x4287                
C000:4293  2e8e1e9032   mov    ds, word ptr cs:[0x3290]
C000:4298  a04904       mov    al, byte ptr [0x449]  
C000:429B  3c02         cmp    al, 2                 
C000:429D  7212         jb     0x42b1                
C000:429F  3c03         cmp    al, 3                 
C000:42A1  770e         ja     0x42b1                
C000:42A3  f606870404   test   byte ptr [0x487], 4   
C000:42A8  7407         je     0x42b1                
C000:42AA  bad803       mov    dx, 0x3d8             
C000:42AD  a06504       mov    al, byte ptr [0x465]  
C000:42B0  ee           out    dx, al                
C000:42B1  83c404       add    sp, 4                 
C000:42B4  c3           ret                          
C000:42B6  80fc06       cmp    ah, 6                 
C000:42B9  7404         je     0x42bf                
C000:42BB  d0e1         shl    cl, 1                 
C000:42BD  d0e2         shl    dl, 1                 
C000:42BF  8bf2         mov    si, dx                
C000:42C1  8ad8         mov    bl, al                
C000:42C3  8ac5         mov    al, ch                
C000:42C5  32e4         xor    ah, ah                
C000:42C7  bf4001       mov    di, 0x140             
C000:42CA  f7e7         mul    di                    
C000:42CC  02c1         add    al, cl                
C000:42CE  80d400       adc    ah, 0                 
C000:42D1  8b3e4e04     mov    di, word ptr [0x44e]  
C000:42D5  03f8         add    di, ax                
C000:42D7  8ac3         mov    al, bl                
C000:42D9  32e4         xor    ah, ah                
C000:42DB  ba4001       mov    dx, 0x140             
C000:42DE  f7e2         mul    dx                    
C000:42E0  8bd6         mov    dx, si                
C000:42E2  50           push   ax                    
C000:42E3  bb5000       mov    bx, 0x50              
C000:42E6  2ada         sub    bl, dl                
C000:42E8  80df00       sbb    bh, 0                 
C000:42EB  8a6e03       mov    ch, byte ptr [bp + 3] 
C000:42EE  807e0107     cmp    byte ptr [bp + 1], 7  
C000:42F2  bd0020       mov    bp, 0x2000            
C000:42F5  7473         je     0x436a                
C000:42F7  8aca         mov    cl, dl                
C000:42F9  8bf7         mov    si, di                
C000:42FB  03f0         add    si, ax                
C000:42FD  58           pop    ax                    
C000:42FE  5a           pop    dx                    
C000:42FF  51           push   cx                    
C000:4300  32ed         xor    ch, ch                
C000:4302  8cc0         mov    ax, es                
C000:4304  8ed8         mov    ds, ax                
C000:4306  0af6         or     dh, dh                
C000:4308  7430         je     0x433a                
C000:430A  d0e6         shl    dh, 1                 
C000:430C  d0e6         shl    dh, 1                 
C000:430E  8bc1         mov    ax, cx                
C000:4310  8bc8         mov    cx, ax                
C000:4312  d1e9         shr    cx, 1                 
C000:4314  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:4316  d1d1         rcl    cx, 1                 
C000:4318  f3a4         rep movsb byte ptr es:[di], byte ptr [si]
C000:431A  2bf8         sub    di, ax                
C000:431C  2bf0         sub    si, ax                
C000:431E  03f5         add    si, bp                
C000:4320  03fd         add    di, bp                
C000:4322  8bc8         mov    cx, ax                
C000:4324  d1e9         shr    cx, 1                 
C000:4326  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:4328  d1d1         rcl    cx, 1                 
C000:432A  f3a4         rep movsb byte ptr es:[di], byte ptr [si]
C000:432C  2bf5         sub    si, bp                
C000:432E  2bfd         sub    di, bp                
C000:4330  03f3         add    si, bx                
C000:4332  03fb         add    di, bx                
C000:4334  fece         dec    dh                    
C000:4336  75d8         jne    0x4310                
C000:4338  8bc8         mov    cx, ax                
C000:433A  58           pop    ax                    
C000:433B  8ac4         mov    al, ah                
C000:433D  d0e2         shl    dl, 1                 
C000:433F  d0e2         shl    dl, 1                 
C000:4341  8bf1         mov    si, cx                
C000:4343  8bce         mov    cx, si                
C000:4345  d1e9         shr    cx, 1                 
C000:4347  f3ab         rep stosw word ptr es:[di], ax  
C000:4349  d1d1         rcl    cx, 1                 
C000:434B  f3aa         rep stosb byte ptr es:[di], al  
C000:434D  2bfe         sub    di, si                
C000:434F  03fd         add    di, bp                
C000:4351  8bce         mov    cx, si                
C000:4353  d1e9         shr    cx, 1                 
C000:4355  f3ab         rep stosw word ptr es:[di], ax  
C000:4357  d1d1         rcl    cx, 1                 
C000:4359  f3aa         rep stosb byte ptr es:[di], al  
C000:435B  2bfd         sub    di, bp                
C000:435D  03fb         add    di, bx                
C000:435F  feca         dec    dl                    
C000:4361  75e0         jne    0x4343                
C000:4363  83c404       add    sp, 4                 
C000:4366  c3           ret                          
C000:436A  f7d8         neg    ax                    
C000:436C  f7db         neg    bx                    
C000:436E  f7dd         neg    bp                    
C000:4370  81c7f020     add    di, 0x20f0            
C000:4374  803e490406   cmp    byte ptr [0x449], 6   
C000:4379  7401         je     0x437c                
C000:437B  47           inc    di                    
C000:437C  8aca         mov    cl, dl                
C000:437E  8bf7         mov    si, di                
C000:4380  03f0         add    si, ax                
C000:4382  58           pop    ax                    
C000:4383  5a           pop    dx                    
C000:4384  51           push   cx                    
C000:4385  32ed         xor    ch, ch                
C000:4387  8cc0         mov    ax, es                
C000:4389  8ed8         mov    ds, ax                
C000:438B  0af6         or     dh, dh                
C000:438D  743a         je     0x43c9                
C000:438F  d0e6         shl    dh, 1                 
C000:4391  d0e6         shl    dh, 1                 
C000:4393  8bc1         mov    ax, cx                
C000:4395  8bc8         mov    cx, ax                
C000:4397  d1e9         shr    cx, 1                 
C000:4399  7301         jae    0x439c                
C000:439B  a4           movsb  byte ptr es:[di], byte ptr [si]
C000:439C  e306         jcxz   0x43a4                
C000:439E  4e           dec    si                    
C000:439F  4f           dec    di                    
C000:43A0  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:43A2  46           inc    si                    
C000:43A3  47           inc    di                    
C000:43A4  03f0         add    si, ax                
C000:43A6  03f8         add    di, ax                
C000:43A8  03f5         add    si, bp                
C000:43AA  03fd         add    di, bp                
C000:43AC  8bc8         mov    cx, ax                
C000:43AE  d1e9         shr    cx, 1                 
C000:43B0  7301         jae    0x43b3                
C000:43B2  a4           movsb  byte ptr es:[di], byte ptr [si]
C000:43B3  e306         jcxz   0x43bb                
C000:43B5  4e           dec    si                    
C000:43B6  4f           dec    di                    
C000:43B7  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:43B9  46           inc    si                    
C000:43BA  47           inc    di                    
C000:43BB  2bf5         sub    si, bp                
C000:43BD  2bfd         sub    di, bp                
C000:43BF  03f3         add    si, bx                
C000:43C1  03fb         add    di, bx                
C000:43C3  fece         dec    dh                    
C000:43C5  75ce         jne    0x4395                
C000:43C7  8bc8         mov    cx, ax                
C000:43C9  58           pop    ax                    
C000:43CA  8ac4         mov    al, ah                
C000:43CC  d0e2         shl    dl, 1                 
C000:43CE  d0e2         shl    dl, 1                 
C000:43D0  8bf1         mov    si, cx                
C000:43D2  8bce         mov    cx, si                
C000:43D4  d1e9         shr    cx, 1                 
C000:43D6  7301         jae    0x43d9                
C000:43D8  aa           stosb  byte ptr es:[di], al  
C000:43D9  e304         jcxz   0x43df                
C000:43DB  4f           dec    di                    
C000:43DC  f3ab         rep stosw word ptr es:[di], ax  
C000:43DE  47           inc    di                    
C000:43DF  03fe         add    di, si                
C000:43E1  03fd         add    di, bp                
C000:43E3  8bce         mov    cx, si                
C000:43E5  d1e9         shr    cx, 1                 
C000:43E7  7301         jae    0x43ea                
C000:43E9  aa           stosb  byte ptr es:[di], al  
C000:43EA  e304         jcxz   0x43f0                
C000:43EC  4f           dec    di                    
C000:43ED  f3ab         rep stosw word ptr es:[di], ax  
C000:43EF  47           inc    di                    
C000:43F0  2bfd         sub    di, bp                
C000:43F2  03fb         add    di, bx                
C000:43F4  feca         dec    dl                    
C000:43F6  75da         jne    0x43d2                
C000:43F8  83c404       add    sp, 4                 
C000:43FB  c3           ret                          
C000:4432  8bf2         mov    si, dx                
C000:4434  8bf8         mov    di, ax                
C000:4436  81e7ff00     and    di, 0xff              
C000:443A  8ac4         mov    al, ah                
C000:443C  f6264a04     mul    byte ptr [0x44a]      
C000:4440  f7268504     mul    word ptr [0x485]      
C000:4444  03f8         add    di, ax                
C000:4446  32e4         xor    ah, ah                
C000:4448  a06204       mov    al, byte ptr [0x462]  
C000:444B  f7264c04     mul    word ptr [0x44c]      
C000:444F  03f8         add    di, ax                
C000:4451  8bd6         mov    dx, si                
C000:4453  2bd1         sub    dx, cx                
C000:4455  fec6         inc    dh                    
C000:4457  fec2         inc    dl                    
C000:4459  8a4600       mov    al, byte ptr [bp]     
C000:445C  8ae6         mov    ah, dh                
C000:445E  0ac0         or     al, al                
C000:4460  7404         je     0x4466                
C000:4462  2ae0         sub    ah, al                
C000:4464  7704         ja     0x446a                
C000:4466  8ac6         mov    al, dh                
C000:4468  32e4         xor    ah, ah                
C000:446A  8bc8         mov    cx, ax                
C000:446C  8bf2         mov    si, dx                
C000:446E  b80501       mov    ax, 0x105             
C000:4471  bace03       mov    dx, 0x3ce             
C000:4474  ef           out    dx, ax                
C000:4475  b8020f       mov    ax, 0xf02             
C000:4478  bac403       mov    dx, 0x3c4             
C000:447B  ef           out    dx, ax                
C000:447C  8bc1         mov    ax, cx                
C000:447E  50           push   ax                    
C000:447F  8b1e4a04     mov    bx, word ptr [0x44a]  
C000:4483  f6e3         mul    bl                    
C000:4485  f7268504     mul    word ptr [0x485]      
C000:4489  8bc8         mov    cx, ax                
C000:448B  8bd6         mov    dx, si                
C000:448D  2ada         sub    bl, dl                
C000:448F  80df00       sbb    bh, 0                 
C000:4492  807e0107     cmp    byte ptr [bp + 1], 7  
C000:4496  7504         jne    0x449c                
C000:4498  f7d8         neg    ax                    
C000:449A  f7db         neg    bx                    
C000:449C  8bf7         mov    si, di                
C000:449E  03f0         add    si, ax                
C000:44A0  8bc1         mov    ax, cx                
C000:44A2  8aca         mov    cl, dl                
C000:44A4  32ed         xor    ch, ch                
C000:44A6  5a           pop    dx                    
C000:44A7  3b0e4a04     cmp    cx, word ptr [0x44a]  
C000:44AB  7533         jne    0x44e0                
C000:44AD  8bd8         mov    bx, ax                
C000:44AF  8ac1         mov    al, cl                
C000:44B1  f6e6         mul    dh                    
C000:44B3  f7268504     mul    word ptr [0x485]      
C000:44B7  8bc8         mov    cx, ax                
C000:44B9  b800a0       mov    ax, 0xa000            
C000:44BC  8ec0         mov    es, ax                
C000:44BE  8ed8         mov    ds, ax                
C000:44C0  f3a4         rep movsb byte ptr es:[di], byte ptr [si]
C000:44C2  8bcb         mov    cx, bx                
C000:44C4  bace03       mov    dx, 0x3ce             
C000:44C7  b80500       mov    ax, 5                 
C000:44CA  ef           out    dx, ax                
C000:44CB  8a6603       mov    ah, byte ptr [bp + 3] 
C000:44CE  32c0         xor    al, al                
C000:44D0  ef           out    dx, ax                
C000:44D1  fec0         inc    al                    
C000:44D3  ef           out    dx, ax                
C000:44D4  33c0         xor    ax, ax                
C000:44D6  f3aa         rep stosb byte ptr es:[di], al  
C000:44D8  ef           out    dx, ax                
C000:44D9  fec0         inc    al                    
C000:44DB  ef           out    dx, ax                
C000:44DC  83c404       add    sp, 4                 
C000:44DF  c3           ret                          
C000:44E0  a08504       mov    al, byte ptr [0x485]  
C000:44E3  f6e6         mul    dh                    
C000:44E5  52           push   dx                    
C000:44E6  8bd0         mov    dx, ax                
C000:44E8  b800a0       mov    ax, 0xa000            
C000:44EB  8ed8         mov    ds, ax                
C000:44ED  8ec0         mov    es, ax                
C000:44EF  0bd2         or     dx, dx                
C000:44F1  740d         je     0x4500                
C000:44F3  8bc1         mov    ax, cx                
C000:44F5  f3a4         rep movsb byte ptr es:[di], byte ptr [si]
C000:44F7  8bc8         mov    cx, ax                
C000:44F9  03f3         add    si, bx                
C000:44FB  03fb         add    di, bx                
C000:44FD  4a           dec    dx                    
C000:44FE  75f3         jne    0x44f3                
C000:4500  2e8e1e9032   mov    ds, word ptr cs:[0x3290]
C000:4505  5e           pop    si                    
C000:4506  bace03       mov    dx, 0x3ce             
C000:4509  b80500       mov    ax, 5                 
C000:450C  ef           out    dx, ax                
C000:450D  8a6603       mov    ah, byte ptr [bp + 3] 
C000:4510  32c0         xor    al, al                
C000:4512  ef           out    dx, ax                
C000:4513  fec0         inc    al                    
C000:4515  ef           out    dx, ax                
C000:4516  8bd6         mov    dx, si                
C000:4518  a08504       mov    al, byte ptr [0x485]  
C000:451B  f6e2         mul    dl                    
C000:451D  8bd0         mov    dx, ax                
C000:451F  33c0         xor    ax, ax                
C000:4521  8bf1         mov    si, cx                
C000:4523  f3aa         rep stosb byte ptr es:[di], al  
C000:4525  03fb         add    di, bx                
C000:4527  8bce         mov    cx, si                
C000:4529  4a           dec    dx                    
C000:452A  75f5         jne    0x4521                
C000:452C  bace03       mov    dx, 0x3ce             
C000:452F  ef           out    dx, ax                
C000:4530  fec0         inc    al                    
C000:4532  ef           out    dx, ax                
C000:4533  83c404       add    sp, 4                 
C000:4536  c3           ret                          
C000:4568  2bd1         sub    dx, cx                
C000:456A  fec6         inc    dh                    
C000:456C  fec2         inc    dl                    
C000:456E  8a4600       mov    al, byte ptr [bp]     
C000:4571  8ae6         mov    ah, dh                
C000:4573  0ac0         or     al, al                
C000:4575  7404         je     0x457b                
C000:4577  2ae0         sub    ah, al                
C000:4579  7704         ja     0x457f                
C000:457B  8ac6         mov    al, dh                
C000:457D  32e4         xor    ah, ah                
C000:457F  50           push   ax                    
C000:4580  8bf2         mov    si, dx                
C000:4582  8b1e4a04     mov    bx, word ptr [0x44a]  
C000:4586  f6e3         mul    bl                    
C000:4588  f7268504     mul    word ptr [0x485]      
C000:458C  8bd6         mov    dx, si                
C000:458E  d1e0         shl    ax, 1                 
C000:4590  d1e0         shl    ax, 1                 
C000:4592  50           push   ax                    
C000:4593  d1e0         shl    ax, 1                 
C000:4595  2ada         sub    bl, dl                
C000:4597  80df00       sbb    bh, 0                 
C000:459A  807e0107     cmp    byte ptr [bp + 1], 7  
C000:459E  7504         jne    0x45a4                
C000:45A0  f7d8         neg    ax                    
C000:45A2  f7db         neg    bx                    
C000:45A4  8aca         mov    cl, dl                
C000:45A6  b500         mov    ch, 0                 
C000:45A8  8bf7         mov    si, di                
C000:45AA  03f0         add    si, ax                
C000:45AC  58           pop    ax                    
C000:45AD  5a           pop    dx                    
C000:45AE  3b0e4a04     cmp    cx, word ptr [0x44a]  
C000:45B2  7526         jne    0x45da                
C000:45B4  8bd8         mov    bx, ax                
C000:45B6  8ac1         mov    al, cl                
C000:45B8  f6e6         mul    dh                    
C000:45BA  f7268504     mul    word ptr [0x485]      
C000:45BE  8bc8         mov    cx, ax                
C000:45C0  d1e1         shl    cx, 1                 
C000:45C2  d1e1         shl    cx, 1                 
C000:45C4  b800a0       mov    ax, 0xa000            
C000:45C7  8ec0         mov    es, ax                
C000:45C9  8ed8         mov    ds, ax                
C000:45CB  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:45CD  8bcb         mov    cx, bx                
C000:45CF  8a4603       mov    al, byte ptr [bp + 3] 
C000:45D2  8ae0         mov    ah, al                
C000:45D4  f3ab         rep stosw word ptr es:[di], ax  
C000:45D6  83c404       add    sp, 4                 
C000:45D9  c3           ret                          
C000:45DA  d1e3         shl    bx, 1                 
C000:45DC  d1e3         shl    bx, 1                 
C000:45DE  d1e3         shl    bx, 1                 
C000:45E0  d1e1         shl    cx, 1                 
C000:45E2  d1e1         shl    cx, 1                 
C000:45E4  a08504       mov    al, byte ptr [0x485]  
C000:45E7  f6e6         mul    dh                    
C000:45E9  52           push   dx                    
C000:45EA  8bd0         mov    dx, ax                
C000:45EC  b800a0       mov    ax, 0xa000            
C000:45EF  8ed8         mov    ds, ax                
C000:45F1  8ec0         mov    es, ax                
C000:45F3  0bd2         or     dx, dx                
C000:45F5  740d         je     0x4604                
C000:45F7  8bc1         mov    ax, cx                
C000:45F9  f3a5         rep movsw word ptr es:[di], word ptr [si]
C000:45FB  8bc8         mov    cx, ax                
C000:45FD  03f3         add    si, bx                
C000:45FF  03fb         add    di, bx                
C000:4601  4a           dec    dx                    
C000:4602  75f3         jne    0x45f7                
C000:4604  5a           pop    dx                    
C000:4605  2e8e1e9032   mov    ds, word ptr cs:[0x3290]
C000:460A  a08504       mov    al, byte ptr [0x485]  
C000:460D  f6e2         mul    dl                    
C000:460F  8bd0         mov    dx, ax                
C000:4611  8a4603       mov    al, byte ptr [bp + 3] 
C000:4614  8ae0         mov    ah, al                
C000:4616  8bf1         mov    si, cx                
C000:4618  f3ab         rep stosw word ptr es:[di], ax  
C000:461A  03fb         add    di, bx                
C000:461C  8bce         mov    cx, si                
C000:461E  4a           dec    dx                    
C000:461F  75f5         jne    0x4616                
C000:4621  83c404       add    sp, 4                 
C000:4624  c3           ret                          

;----- sub_462E -----
C000:462E  8a264904     mov    ah, byte ptr [0x449]  
C000:4632  80fc07       cmp    ah, 7                 
C000:4635  760f         jbe    0x4646                
C000:4637  80fc13       cmp    ah, 0x13              
C000:463A  742f         je     0x466b                
C000:463C  7204         jb     0x4642                
C000:463E  e915d6       jmp    0x1c56                
C000:4642  e9fa00       jmp    0x473f                
C000:4646  8bd0         mov    dx, ax                
C000:4648  a11004       mov    ax, word ptr [0x410]  
C000:464B  2430         and    al, 0x30              
C000:464D  3c30         cmp    al, 0x30              
C000:464F  b800b0       mov    ax, 0xb000            
C000:4652  7402         je     0x4656                
C000:4654  b4b8         mov    ah, 0xb8              
C000:4656  8ec0         mov    es, ax                
C000:4658  8bc2         mov    ax, dx                
C000:465A  80fc02       cmp    ah, 2                 
C000:465D  720f         jb     0x466e                
C000:465F  80fc04       cmp    ah, 4                 
C000:4662  7228         jb     0x468c                
C000:4664  80fc07       cmp    ah, 7                 
C000:4667  7405         je     0x466e                
C000:4669  eb47         jmp    0x46b2                
C000:466B  e95801       jmp    0x47c6                
C000:466E  0aff         or     bh, bh                
C000:4670  7513         jne    0x4685                
C000:4672  8b1e5004     mov    bx, word ptr [0x450]  
C000:4676  a04a04       mov    al, byte ptr [0x44a]  
C000:4679  f6e7         mul    bh                    
C000:467B  32ff         xor    bh, bh                
C000:467D  03d8         add    bx, ax                
C000:467F  d1e3         shl    bx, 1                 
C000:4681  268b07       mov    ax, word ptr es:[bx]  
C000:4684  c3           ret                          
C000:4685  e8fd01       call   0x4885                
C000:4688  268b05       mov    ax, word ptr es:[di]  
C000:468B  c3           ret                          
C000:468C  f606870404   test   byte ptr [0x487], 4   
C000:4691  74db         je     0x466e                
C000:4693  e8ef01       call   0x4885                
C000:4696  8b166304     mov    dx, word ptr [0x463]  
C000:469A  83c206       add    dx, 6                 
C000:469D  8cc0         mov    ax, es                
C000:469F  8ed8         mov    ds, ax                
C000:46A1  8bf7         mov    si, di                
C000:46A3  ec           in     al, dx                
C000:46A4  2401         and    al, 1                 
C000:46A6  75fb         jne    0x46a3                
C000:46A8  9c           pushf                        
C000:46A9  fa           cli                          
C000:46AA  ec           in     al, dx                
C000:46AB  2401         and    al, 1                 
C000:46AD  74fb         je     0x46aa                
C000:46AF  ad           lodsw  ax, word ptr [si]     
C000:46B0  9d           popf                         
C000:46B1  c3           ret                          
C000:46B2  a05104       mov    al, byte ptr [0x451]  
C000:46B5  f6264a04     mul    byte ptr [0x44a]      
C000:46B9  8bf8         mov    di, ax                
C000:46BB  d1e7         shl    di, 1                 
C000:46BD  d1e7         shl    di, 1                 
C000:46BF  a05004       mov    al, byte ptr [0x450]  
C000:46C2  32e4         xor    ah, ah                
C000:46C4  03f8         add    di, ax                
C000:46C6  8a264904     mov    ah, byte ptr [0x449]  
C000:46CA  80fc06       cmp    ah, 6                 
C000:46CD  7402         je     0x46d1                
C000:46CF  d1e7         shl    di, 1                 
C000:46D1  81c7f020     add    di, 0x20f0            
C000:46D5  80fc06       cmp    ah, 6                 
C000:46D8  8bf7         mov    si, di                
C000:46DA  8cc0         mov    ax, es                
C000:46DC  8ed8         mov    ds, ax                
C000:46DE  b90400       mov    cx, 4                 
C000:46E1  7415         je     0x46f8                
C000:46E3  e86201       call   0x4848                
C000:46E6  8afb         mov    bh, bl                
C000:46E8  81ee0220     sub    si, 0x2002            
C000:46EC  e85901       call   0x4848                
C000:46EF  81c6ae1f     add    si, 0x1fae            
C000:46F3  53           push   bx                    
C000:46F4  e2ed         loop   0x46e3                
C000:46F6  eb0f         jmp    0x4707                
C000:46F8  ac           lodsb  al, byte ptr [si]     
C000:46F9  8ae0         mov    ah, al                
C000:46FB  81ee0120     sub    si, 0x2001            
C000:46FF  ac           lodsb  al, byte ptr [si]     
C000:4700  81c6af1f     add    si, 0x1faf            
C000:4704  50           push   ax                    
C000:4705  e2f1         loop   0x46f8                
C000:4707  8bf4         mov    si, sp                
C000:4709  8cd0         mov    ax, ss                
C000:470B  8ed8         mov    ds, ax                
C000:470D  8cc8         mov    ax, cs                
C000:470F  8ec0         mov    es, ax                
C000:4711  bf9875       mov    di, 0x7598            
C000:4714  ba8000       mov    dx, 0x80              
C000:4717  e84301       call   0x485d                
C000:471A  751a         jne    0x4736                
C000:471C  2e8e069232   mov    es, word ptr cs:[0x3292]
C000:4721  26c43e7c00   les    di, ptr es:[0x7c]     
C000:4726  8cc0         mov    ax, es                
C000:4728  0bc7         or     ax, di                
C000:472A  740a         je     0x4736                
C000:472C  ba8000       mov    dx, 0x80              
C000:472F  e82b01       call   0x485d                
C000:4732  7402         je     0x4736                
C000:4734  0480         add    al, 0x80              
C000:4736  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:473B  83c408       add    sp, 8                 
C000:473E  c3           ret                          
C000:473F  b800a0       mov    ax, 0xa000            
C000:4742  8ec0         mov    es, ax                
C000:4744  8ac7         mov    al, bh                
C000:4746  32e4         xor    ah, ah                
C000:4748  d1e0         shl    ax, 1                 
C000:474A  8bf0         mov    si, ax                
C000:474C  8b845004     mov    ax, word ptr [si + 0x450]
C000:4750  8bf0         mov    si, ax                
C000:4752  81e6ff00     and    si, 0xff              
C000:4756  8ac4         mov    al, ah                
C000:4758  f6264a04     mul    byte ptr [0x44a]      
C000:475C  f7268504     mul    word ptr [0x485]      
C000:4760  03f0         add    si, ax                
C000:4762  32e4         xor    ah, ah                
C000:4764  8ac7         mov    al, bh                
C000:4766  f7264c04     mul    word ptr [0x44c]      
C000:476A  03f0         add    si, ax                
C000:476C  a08504       mov    al, byte ptr [0x485]  
C000:476F  fec8         dec    al                    
C000:4771  f6264a04     mul    byte ptr [0x44a]      
C000:4775  03f0         add    si, ax                
C000:4777  b80508       mov    ax, 0x805             
C000:477A  bace03       mov    dx, 0x3ce             
C000:477D  ef           out    dx, ax                
C000:477E  8b0e8504     mov    cx, word ptr [0x485]  
C000:4782  8b1e4a04     mov    bx, word ptr [0x44a]  
C000:4786  43           inc    bx                    
C000:4787  26ac         lodsb  al, byte ptr es:[si]  
C000:4789  8ae0         mov    ah, al                
C000:478B  f6d4         not    ah                    
C000:478D  50           push   ax                    
C000:478E  44           inc    sp                    
C000:478F  2bf3         sub    si, bx                
C000:4791  e2f4         loop   0x4787                
C000:4793  b80500       mov    ax, 5                 
C000:4796  ef           out    dx, ax                
C000:4797  8bf4         mov    si, sp                
C000:4799  32c0         xor    al, al                
C000:479B  2e8e069232   mov    es, word ptr cs:[0x3292]
C000:47A0  26c41e0c01   les    bx, ptr es:[0x10c]    
C000:47A5  8bd6         mov    dx, si                
C000:47A7  9c           pushf                        
C000:47A8  fa           cli                          
C000:47A9  8bfb         mov    di, bx                
C000:47AB  8b0e8504     mov    cx, word ptr [0x485]  
C000:47AF  f336a6       repe cmpsb byte ptr ss:[si], byte ptr es:[di]
C000:47B2  740a         je     0x47be                
C000:47B4  031e8504     add    bx, word ptr [0x485]  
C000:47B8  8bf2         mov    si, dx                
C000:47BA  fec0         inc    al                    
C000:47BC  75eb         jne    0x47a9                
C000:47BE  9d           popf                         
C000:47BF  b405         mov    ah, 5                 
C000:47C1  03268504     add    sp, word ptr [0x485]  
C000:47C5  c3           ret                          
C000:47C6  b800a0       mov    ax, 0xa000            
C000:47C9  8ec0         mov    es, ax                
C000:47CB  a15004       mov    ax, word ptr [0x450]  
C000:47CE  8bf8         mov    di, ax                
C000:47D0  81e7ff00     and    di, 0xff              
C000:47D4  8ac4         mov    al, ah                
C000:47D6  f6264a04     mul    byte ptr [0x44a]      
C000:47DA  f7268504     mul    word ptr [0x485]      
C000:47DE  03f8         add    di, ax                
C000:47E0  d1e7         shl    di, 1                 
C000:47E2  d1e7         shl    di, 1                 
C000:47E4  d1e7         shl    di, 1                 
C000:47E6  a08504       mov    al, byte ptr [0x485]  
C000:47E9  fec8         dec    al                    
C000:47EB  f6264a04     mul    byte ptr [0x44a]      
C000:47EF  b103         mov    cl, 3                 
C000:47F1  d3e0         shl    ax, cl                
C000:47F3  8bf7         mov    si, di                
C000:47F5  03f0         add    si, ax                
C000:47F7  8b164a04     mov    dx, word ptr [0x44a]  
C000:47FB  d3e2         shl    dx, cl                
C000:47FD  83c208       add    dx, 8                 
C000:4800  8b0e8504     mov    cx, word ptr [0x485]  
C000:4804  b308         mov    bl, 8                 
C000:4806  32e4         xor    ah, ah                
C000:4808  26ac         lodsb  al, byte ptr es:[si]  
C000:480A  3c01         cmp    al, 1                 
C000:480C  f5           cmc                          
C000:480D  d0d4         rcl    ah, 1                 
C000:480F  fecb         dec    bl                    
C000:4811  75f5         jne    0x4808                
C000:4813  50           push   ax                    
C000:4814  44           inc    sp                    
C000:4815  2bf2         sub    si, dx                
C000:4817  e2eb         loop   0x4804                
C000:4819  8bf4         mov    si, sp                
C000:481B  32c0         xor    al, al                
C000:481D  2e8e069232   mov    es, word ptr cs:[0x3292]
C000:4822  26c41e0c01   les    bx, ptr es:[0x10c]    
C000:4827  8bd6         mov    dx, si                
C000:4829  9c           pushf                        
C000:482A  fa           cli                          
C000:482B  8bfb         mov    di, bx                
C000:482D  8b0e8504     mov    cx, word ptr [0x485]  
C000:4831  f336a6       repe cmpsb byte ptr ss:[si], byte ptr es:[di]
C000:4834  740a         je     0x4840                
C000:4836  031e8504     add    bx, word ptr [0x485]  
C000:483A  8bf2         mov    si, dx                
C000:483C  fec0         inc    al                    
C000:483E  75eb         jne    0x482b                
C000:4840  9d           popf                         
C000:4841  32e4         xor    ah, ah                
C000:4843  03268504     add    sp, word ptr [0x485]  
C000:4847  c3           ret                          

;----- sub_4848 -----
C000:4848  b208         mov    dl, 8                 
C000:484A  32db         xor    bl, bl                
C000:484C  ad           lodsw  ax, word ptr [si]     
C000:484D  86c4         xchg   ah, al                
C000:484F  d1e0         shl    ax, 1                 
C000:4851  7901         jns    0x4854                
C000:4853  f9           stc                          
C000:4854  d0d3         rcl    bl, 1                 
C000:4856  d1e0         shl    ax, 1                 
C000:4858  feca         dec    dl                    
C000:485A  75f3         jne    0x484f                
C000:485C  c3           ret                          

;----- sub_485D -----
C000:485D  8bdf         mov    bx, di                
C000:485F  55           push   bp                    
C000:4860  8bc6         mov    ax, si                
C000:4862  8bef         mov    bp, di                
C000:4864  b90400       mov    cx, 4                 
C000:4867  f3a7         repe cmpsw word ptr [si], word ptr es:[di]
C000:4869  8bfd         mov    di, bp                
C000:486B  740c         je     0x4879                
C000:486D  83c708       add    di, 8                 
C000:4870  8bf0         mov    si, ax                
C000:4872  4a           dec    dx                    
C000:4873  75eb         jne    0x4860                
C000:4875  5d           pop    bp                    
C000:4876  33c0         xor    ax, ax                
C000:4878  c3           ret                          
C000:4879  2bfb         sub    di, bx                
C000:487B  b103         mov    cl, 3                 
C000:487D  d3ef         shr    di, cl                
C000:487F  8bc7         mov    ax, di                
C000:4881  0ac9         or     cl, cl                
C000:4883  5d           pop    bp                    
C000:4884  c3           ret                          

;----- sub_4885 -----
C000:4885  8ae3         mov    ah, bl                
C000:4887  8bf8         mov    di, ax                
C000:4889  8adf         mov    bl, bh                
C000:488B  32ff         xor    bh, bh                
C000:488D  a14c04       mov    ax, word ptr [0x44c]  
C000:4890  d1e8         shr    ax, 1                 
C000:4892  f7e3         mul    bx                    
C000:4894  8bd0         mov    dx, ax                
C000:4896  d1e3         shl    bx, 1                 
C000:4898  8b9f5004     mov    bx, word ptr [bx + 0x450]
C000:489C  a04a04       mov    al, byte ptr [0x44a]  
C000:489F  f6e7         mul    bh                    
C000:48A1  03c2         add    ax, dx                
C000:48A3  32ff         xor    bh, bh                
C000:48A5  03c3         add    ax, bx                
C000:48A7  d1e0         shl    ax, 1                 
C000:48A9  97           xchg   di, ax                
C000:48AA  c3           ret                          
C000:48D2  e95402       jmp    0x4b29                

;----- sub_4942 -----
C000:4942  8a264904     mov    ah, byte ptr [0x449]  
C000:4946  80fc07       cmp    ah, 7                 
C000:4949  760f         jbe    0x495a                
C000:494B  80fc13       cmp    ah, 0x13              
C000:494E  7482         je     0x48d2                
C000:4950  7203         jb     0x4955                
C000:4952  e937d2       jmp    0x1b8c                
C000:4955  e92601       jmp    0x4a7e                
C000:495A  8a161004     mov    dl, byte ptr [0x410]  
C000:495E  80e230       and    dl, 0x30              
C000:4961  80fa30       cmp    dl, 0x30              
C000:4964  ba00b0       mov    dx, 0xb000            
C000:4967  7402         je     0x496b                
C000:4969  b6b8         mov    dh, 0xb8              
C000:496B  8ec2         mov    es, dx                
C000:496D  80fc07       cmp    ah, 7                 
C000:4970  7411         je     0x4983                
C000:4972  80fc03       cmp    ah, 3                 
C000:4975  774f         ja     0x49c6                
C000:4977  80fc02       cmp    ah, 2                 
C000:497A  7207         jb     0x4983                
C000:497C  f606870404   test   byte ptr [0x487], 4   
C000:4981  7523         jne    0x49a6                
C000:4983  0aff         or     bh, bh                
C000:4985  7517         jne    0x499e                
C000:4987  8bf8         mov    di, ax                
C000:4989  8b1e5004     mov    bx, word ptr [0x450]  
C000:498D  a04a04       mov    al, byte ptr [0x44a]  
C000:4990  f6e7         mul    bh                    
C000:4992  32ff         xor    bh, bh                
C000:4994  03c3         add    ax, bx                
C000:4996  d1e0         shl    ax, 1                 
C000:4998  97           xchg   di, ax                
C000:4999  aa           stosb  byte ptr es:[di], al  
C000:499A  47           inc    di                    
C000:499B  e2fc         loop   0x4999                
C000:499D  c3           ret                          
C000:499E  e8e4fe       call   0x4885                
C000:49A1  aa           stosb  byte ptr es:[di], al  
C000:49A2  47           inc    di                    
C000:49A3  e2fc         loop   0x49a1                
C000:49A5  c3           ret                          
C000:49A6  e8dcfe       call   0x4885                
C000:49A9  8b166304     mov    dx, word ptr [0x463]  
C000:49AD  83c206       add    dx, 6                 
C000:49B0  8ae0         mov    ah, al                
C000:49B2  ec           in     al, dx                
C000:49B3  a801         test   al, 1                 
C000:49B5  75fb         jne    0x49b2                
C000:49B7  9c           pushf                        
C000:49B8  fa           cli                          
C000:49B9  ec           in     al, dx                
C000:49BA  a801         test   al, 1                 
C000:49BC  74fb         je     0x49b9                
C000:49BE  8ac4         mov    al, ah                
C000:49C0  aa           stosb  byte ptr es:[di], al  
C000:49C1  9d           popf                         
C000:49C2  47           inc    di                    
C000:49C3  e2ed         loop   0x49b2                
C000:49C5  c3           ret                          
C000:49C6  8bd0         mov    dx, ax                
C000:49C8  a05104       mov    al, byte ptr [0x451]  
C000:49CB  f6264a04     mul    byte ptr [0x44a]      
C000:49CF  8bf8         mov    di, ax                
C000:49D1  d1e7         shl    di, 1                 
C000:49D3  d1e7         shl    di, 1                 
C000:49D5  a05004       mov    al, byte ptr [0x450]  
C000:49D8  32e4         xor    ah, ah                
C000:49DA  03f8         add    di, ax                
C000:49DC  80fe06       cmp    dh, 6                 
C000:49DF  7402         je     0x49e3                
C000:49E1  d1e7         shl    di, 1                 
C000:49E3  8ac2         mov    al, dl                
C000:49E5  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:49EA  0ac0         or     al, al                
C000:49EC  7908         jns    0x49f6                
C000:49EE  247f         and    al, 0x7f              
C000:49F0  c5367c00     lds    si, ptr [0x7c]        
C000:49F4  eb04         jmp    0x49fa                
C000:49F6  c5360c01     lds    si, ptr [0x10c]       
C000:49FA  32e4         xor    ah, ah                
C000:49FC  d1e0         shl    ax, 1                 
C000:49FE  d1e0         shl    ax, 1                 
C000:4A00  d1e0         shl    ax, 1                 
C000:4A02  03f0         add    si, ax                
C000:4A04  80fe06       cmp    dh, 6                 
C000:4A07  7548         jne    0x4a51                
C000:4A09  b204         mov    dl, 4                 
C000:4A0B  0adb         or     bl, bl                
C000:4A0D  7820         js     0x4a2f                
C000:4A0F  ad           lodsw  ax, word ptr [si]     
C000:4A10  aa           stosb  byte ptr es:[di], al  
C000:4A11  81c7ff1f     add    di, 0x1fff            
C000:4A15  8ac4         mov    al, ah                
C000:4A17  aa           stosb  byte ptr es:[di], al  
C000:4A18  81efb11f     sub    di, 0x1fb1            
C000:4A1C  feca         dec    dl                    
C000:4A1E  75ef         jne    0x4a0f                
C000:4A20  81ef3f01     sub    di, 0x13f             
C000:4A24  83ee08       sub    si, 8                 
C000:4A27  e2e0         loop   0x4a09                
C000:4A29  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4A2E  c3           ret                          
C000:4A2F  ad           lodsw  ax, word ptr [si]     
C000:4A30  263005       xor    byte ptr es:[di], al  
C000:4A33  81c70020     add    di, 0x2000            
C000:4A37  263025       xor    byte ptr es:[di], ah  
C000:4A3A  81efb01f     sub    di, 0x1fb0            
C000:4A3E  feca         dec    dl                    
C000:4A40  75ed         jne    0x4a2f                
C000:4A42  81ef3f01     sub    di, 0x13f             
C000:4A46  83ee08       sub    si, 8                 
C000:4A49  e2be         loop   0x4a09                
C000:4A4B  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4A50  c3           ret                          
C000:4A51  55           push   bp                    
C000:4A52  8afb         mov    bh, bl                
C000:4A54  80e703       and    bh, 3                 
C000:4A57  8be9         mov    bp, cx                
C000:4A59  b604         mov    dh, 4                 
C000:4A5B  e82701       call   0x4b85                
C000:4A5E  81c7fe1f     add    di, 0x1ffe            
C000:4A62  e82001       call   0x4b85                
C000:4A65  81efb21f     sub    di, 0x1fb2            
C000:4A69  fece         dec    dh                    
C000:4A6B  75ee         jne    0x4a5b                
C000:4A6D  81ef3e01     sub    di, 0x13e             
C000:4A71  83ee08       sub    si, 8                 
C000:4A74  4d           dec    bp                    
C000:4A75  75e2         jne    0x4a59                
C000:4A77  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4A7C  5d           pop    bp                    
C000:4A7D  c3           ret                          
C000:4A7E  55           push   bp                    
C000:4A7F  8bf0         mov    si, ax                
C000:4A81  8be9         mov    bp, cx                
C000:4A83  b800a0       mov    ax, 0xa000            
C000:4A86  8ec0         mov    es, ax                
C000:4A88  8ac7         mov    al, bh                
C000:4A8A  32e4         xor    ah, ah                
C000:4A8C  d1e0         shl    ax, 1                 
C000:4A8E  8bf8         mov    di, ax                
C000:4A90  8b855004     mov    ax, word ptr [di + 0x450]
C000:4A94  8bf8         mov    di, ax                
C000:4A96  81e7ff00     and    di, 0xff              
C000:4A9A  a04a04       mov    al, byte ptr [0x44a]  
C000:4A9D  f6e4         mul    ah                    
C000:4A9F  f7268504     mul    word ptr [0x485]      
C000:4AA3  03f8         add    di, ax                
C000:4AA5  32e4         xor    ah, ah                
C000:4AA7  8ac7         mov    al, bh                
C000:4AA9  f7264c04     mul    word ptr [0x44c]      
C000:4AAD  03f8         add    di, ax                
C000:4AAF  8ad3         mov    dl, bl                
C000:4AB1  8b0e8504     mov    cx, word ptr [0x485]  
C000:4AB5  8b1e4a04     mov    bx, word ptr [0x44a]  
C000:4AB9  4b           dec    bx                    
C000:4ABA  8bc6         mov    ax, si                
C000:4ABC  f6268504     mul    byte ptr [0x485]      
C000:4AC0  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4AC5  c5360c01     lds    si, ptr [0x10c]       
C000:4AC9  03f0         add    si, ax                
C000:4ACB  8ae2         mov    ah, dl                
C000:4ACD  32c0         xor    al, al                
C000:4ACF  bace03       mov    dx, 0x3ce             
C000:4AD2  ef           out    dx, ax                
C000:4AD3  fec0         inc    al                    
C000:4AD5  f6d4         not    ah                    
C000:4AD7  ef           out    dx, ax                
C000:4AD8  f6c480       test   ah, 0x80              
C000:4ADB  742b         je     0x4b08                
C000:4ADD  bac403       mov    dx, 0x3c4             
C000:4AE0  b8020f       mov    ax, 0xf02             
C000:4AE3  ef           out    dx, ax                
C000:4AE4  56           push   si                    
C000:4AE5  57           push   di                    
C000:4AE6  8bd1         mov    dx, cx                
C000:4AE8  a4           movsb  byte ptr es:[di], byte ptr [si]
C000:4AE9  03fb         add    di, bx                
C000:4AEB  e2fb         loop   0x4ae8                
C000:4AED  8bca         mov    cx, dx                
C000:4AEF  5f           pop    di                    
C000:4AF0  5e           pop    si                    
C000:4AF1  47           inc    di                    
C000:4AF2  4d           dec    bp                    
C000:4AF3  75ef         jne    0x4ae4                
C000:4AF5  b80300       mov    ax, 3                 
C000:4AF8  bace03       mov    dx, 0x3ce             
C000:4AFB  ef           out    dx, ax                
C000:4AFC  33c0         xor    ax, ax                
C000:4AFE  ef           out    dx, ax                
C000:4AFF  40           inc    ax                    
C000:4B00  ef           out    dx, ax                
C000:4B01  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4B06  5d           pop    bp                    
C000:4B07  c3           ret                          
C000:4B08  b80318       mov    ax, 0x1803            
C000:4B0B  ef           out    dx, ax                
C000:4B0C  bac403       mov    dx, 0x3c4             
C000:4B0F  b8020f       mov    ax, 0xf02             
C000:4B12  ef           out    dx, ax                
C000:4B13  56           push   si                    
C000:4B14  57           push   di                    
C000:4B15  8bd1         mov    dx, cx                
C000:4B17  268a05       mov    al, byte ptr es:[di]  
C000:4B1A  a4           movsb  byte ptr es:[di], byte ptr [si]
C000:4B1B  03fb         add    di, bx                
C000:4B1D  e2f8         loop   0x4b17                
C000:4B1F  8bca         mov    cx, dx                
C000:4B21  5f           pop    di                    
C000:4B22  5e           pop    si                    
C000:4B23  47           inc    di                    
C000:4B24  4d           dec    bp                    
C000:4B25  75ec         jne    0x4b13                
C000:4B27  ebcc         jmp    0x4af5                
C000:4B29  55           push   bp                    
C000:4B2A  8be9         mov    bp, cx                
C000:4B2C  8bc8         mov    cx, ax                
C000:4B2E  b800a0       mov    ax, 0xa000            
C000:4B31  8ec0         mov    es, ax                
C000:4B33  a15004       mov    ax, word ptr [0x450]  
C000:4B36  8bf8         mov    di, ax                
C000:4B38  81e7ff00     and    di, 0xff              
C000:4B3C  a04a04       mov    al, byte ptr [0x44a]  
C000:4B3F  f6e4         mul    ah                    
C000:4B41  f7268504     mul    word ptr [0x485]      
C000:4B45  03f8         add    di, ax                
C000:4B47  d1e7         shl    di, 1                 
C000:4B49  d1e7         shl    di, 1                 
C000:4B4B  d1e7         shl    di, 1                 
C000:4B4D  a18504       mov    ax, word ptr [0x485]  
C000:4B50  8bd0         mov    dx, ax                
C000:4B52  f6e1         mul    cl                    
C000:4B54  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4B59  c5360c01     lds    si, ptr [0x10c]       
C000:4B5D  03f0         add    si, ax                
C000:4B5F  57           push   di                    
C000:4B60  52           push   dx                    
C000:4B61  b90800       mov    cx, 8                 
C000:4B64  8a24         mov    ah, byte ptr [si]     
C000:4B66  46           inc    si                    
C000:4B67  d0d4         rcl    ah, 1                 
C000:4B69  8ac3         mov    al, bl                
C000:4B6B  7202         jb     0x4b6f                
C000:4B6D  8ac7         mov    al, bh                
C000:4B6F  aa           stosb  byte ptr es:[di], al  
C000:4B70  e2f5         loop   0x4b67                
C000:4B72  81c73801     add    di, 0x138             
C000:4B76  4a           dec    dx                    
C000:4B77  75e8         jne    0x4b61                
C000:4B79  5a           pop    dx                    
C000:4B7A  5f           pop    di                    
C000:4B7B  2bf2         sub    si, dx                
C000:4B7D  83c708       add    di, 8                 
C000:4B80  4d           dec    bp                    
C000:4B81  75dc         jne    0x4b5f                
C000:4B83  5d           pop    bp                    
C000:4B84  c3           ret                          

;----- sub_4B85 -----
C000:4B85  b208         mov    dl, 8                 
C000:4B87  33c9         xor    cx, cx                
C000:4B89  ac           lodsb  al, byte ptr [si]     
C000:4B8A  d0d8         rcr    al, 1                 
C000:4B8C  7302         jae    0x4b90                
C000:4B8E  0acf         or     cl, bh                
C000:4B90  d1c9         ror    cx, 1                 
C000:4B92  d1c9         ror    cx, 1                 
C000:4B94  feca         dec    dl                    
C000:4B96  75f2         jne    0x4b8a                
C000:4B98  8bc1         mov    ax, cx                
C000:4B9A  86c4         xchg   ah, al                
C000:4B9C  0adb         or     bl, bl                
C000:4B9E  7802         js     0x4ba2                
C000:4BA0  ab           stosw  word ptr es:[di], ax  
C000:4BA1  c3           ret                          
C000:4BA2  263105       xor    word ptr es:[di], ax  
C000:4BA5  83c702       add    di, 2                 
C000:4BA8  c3           ret                          
C000:4C9A  771c         ja     0x4cb8                
C000:4C9C  06           push   es                    
C000:4C9D  57           push   di                    
C000:4C9E  50           push   ax                    
C000:4C9F  52           push   dx                    
C000:4CA0  8bf8         mov    di, ax                
C000:4CA2  2e8e069432   mov    es, word ptr cs:[0x3294]
C000:4CA7  b84001       mov    ax, 0x140             
C000:4CAA  f7e2         mul    dx                    
C000:4CAC  03c1         add    ax, cx                
C000:4CAE  97           xchg   di, ax                
C000:4CAF  aa           stosb  byte ptr es:[di], al  
C000:4CB0  5a           pop    dx                    
C000:4CB1  58           pop    ax                    
C000:4CB2  5f           pop    di                    
C000:4CB3  07           pop    es                    
C000:4CB4  1f           pop    ds                    
C000:4CB5  b40c         mov    ah, 0xc               
C000:4CB7  cf           iret                         
C000:4CB8  e94ace       jmp    0x1b05                
C000:4CBE  80fc04       cmp    ah, 4                 
C000:4CC1  722f         jb     0x4cf2                
C000:4CC3  80fc07       cmp    ah, 7                 
C000:4CC6  742a         je     0x4cf2                
C000:4CC8  80fc08       cmp    ah, 8                 
C000:4CCB  7341         jae    0x4d0e                
C000:4CCD  06           push   es                    
C000:4CCE  57           push   di                    
C000:4CCF  53           push   bx                    
C000:4CD0  51           push   cx                    
C000:4CD1  52           push   dx                    
C000:4CD2  8bd8         mov    bx, ax                
C000:4CD4  e85301       call   0x4e2a                
C000:4CD7  8ac4         mov    al, ah                
C000:4CD9  d2c8         ror    al, cl                
C000:4CDB  f6d0         not    al                    
C000:4CDD  22c3         and    al, bl                
C000:4CDF  d2e0         shl    al, cl                
C000:4CE1  0adb         or     bl, bl                
C000:4CE3  780f         js     0x4cf4                
C000:4CE5  262225       and    ah, byte ptr es:[di]  
C000:4CE8  0ac4         or     al, ah                
C000:4CEA  aa           stosb  byte ptr es:[di], al  
C000:4CEB  8bc3         mov    ax, bx                
C000:4CED  5a           pop    dx                    
C000:4CEE  59           pop    cx                    
C000:4CEF  5b           pop    bx                    
C000:4CF0  5f           pop    di                    
C000:4CF1  07           pop    es                    
C000:4CF2  1f           pop    ds                    
C000:4CF3  cf           iret                         
C000:4CF4  263005       xor    byte ptr es:[di], al  
C000:4CF7  ebf2         jmp    0x4ceb                
C000:4CFA  1e           push   ds                    
C000:4CFB  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4D00  8a264904     mov    ah, byte ptr [0x449]  
C000:4D04  80fc0d       cmp    ah, 0xd               
C000:4D07  72b5         jb     0x4cbe                
C000:4D09  80fc13       cmp    ah, 0x13              
C000:4D0C  738c         jae    0x4c9a                
C000:4D0E  53           push   bx                    
C000:4D0F  51           push   cx                    
C000:4D10  52           push   dx                    
C000:4D11  87d9         xchg   cx, bx                
C000:4D13  8acb         mov    cl, bl                
C000:4D15  d1eb         shr    bx, 1                 
C000:4D17  d1eb         shr    bx, 1                 
C000:4D19  d1eb         shr    bx, 1                 
C000:4D1B  0aed         or     ch, ch                
C000:4D1D  753f         jne    0x4d5e                
C000:4D1F  8ae8         mov    ch, al                
C000:4D21  a14a04       mov    ax, word ptr [0x44a]  
C000:4D24  f7e2         mul    dx                    
C000:4D26  03d8         add    bx, ax                
C000:4D28  bace03       mov    dx, 0x3ce             
C000:4D2B  33c0         xor    ax, ax                
C000:4D2D  ef           out    dx, ax                
C000:4D2E  b8010f       mov    ax, 0xf01             
C000:4D31  ef           out    dx, ax                
C000:4D32  80e107       and    cl, 7                 
C000:4D35  b80880       mov    ax, 0x8008            
C000:4D38  d2ec         shr    ah, cl                
C000:4D3A  ef           out    dx, ax                
C000:4D3B  b800a0       mov    ax, 0xa000            
C000:4D3E  8ed8         mov    ds, ax                
C000:4D40  0aed         or     ch, ch                
C000:4D42  7826         js     0x4d6a                
C000:4D44  0807         or     byte ptr [bx], al     
C000:4D46  8ae5         mov    ah, ch                
C000:4D48  ef           out    dx, ax                
C000:4D49  0807         or     byte ptr [bx], al     
C000:4D4B  b808ff       mov    ax, 0xff08            
C000:4D4E  ef           out    dx, ax                
C000:4D4F  33c0         xor    ax, ax                
C000:4D51  ef           out    dx, ax                
C000:4D52  fec0         inc    al                    
C000:4D54  ef           out    dx, ax                
C000:4D55  8ac5         mov    al, ch                
C000:4D57  b40c         mov    ah, 0xc               
C000:4D59  5a           pop    dx                    
C000:4D5A  59           pop    cx                    
C000:4D5B  5b           pop    bx                    
C000:4D5C  1f           pop    ds                    
C000:4D5D  cf           iret                         
C000:4D5E  031e4c04     add    bx, word ptr [0x44c]  
C000:4D62  fecd         dec    ch                    
C000:4D64  75f8         jne    0x4d5e                
C000:4D66  ebb7         jmp    0x4d1f                
C000:4D6A  b80318       mov    ax, 0x1803            
C000:4D6D  ef           out    dx, ax                
C000:4D6E  8ae5         mov    ah, ch                
C000:4D70  32c0         xor    al, al                
C000:4D72  ef           out    dx, ax                
C000:4D73  0807         or     byte ptr [bx], al     
C000:4D75  b80300       mov    ax, 3                 
C000:4D78  ef           out    dx, ax                
C000:4D79  ebd0         jmp    0x4d4b                
C000:4D7E  7718         ja     0x4d98                
C000:4D80  52           push   dx                    
C000:4D81  57           push   di                    
C000:4D82  2e8e1e9432   mov    ds, word ptr cs:[0x3294]
C000:4D87  b84001       mov    ax, 0x140             
C000:4D8A  f7e2         mul    dx                    
C000:4D8C  03c1         add    ax, cx                
C000:4D8E  8bf8         mov    di, ax                
C000:4D90  8a05         mov    al, byte ptr [di]     
C000:4D92  b40d         mov    ah, 0xd               
C000:4D94  5f           pop    di                    
C000:4D95  5a           pop    dx                    
C000:4D96  1f           pop    ds                    
C000:4D97  cf           iret                         
C000:4D98  e906cd       jmp    0x1aa1                
C000:4D9E  80fc04       cmp    ah, 4                 
C000:4DA1  7220         jb     0x4dc3                
C000:4DA3  80fc07       cmp    ah, 7                 
C000:4DA6  741b         je     0x4dc3                
C000:4DA8  80fc08       cmp    ah, 8                 
C000:4DAB  732d         jae    0x4dda                 ; "VSQR"
C000:4DAD  06           push   es                    
C000:4DAE  57           push   di                    
C000:4DAF  51           push   cx                    
C000:4DB0  52           push   dx                    
C000:4DB1  e87600       call   0x4e2a                
C000:4DB4  f6d4         not    ah                    
C000:4DB6  262225       and    ah, byte ptr es:[di]  
C000:4DB9  d2ec         shr    ah, cl                
C000:4DBB  8ac4         mov    al, ah                
C000:4DBD  b40d         mov    ah, 0xd               
C000:4DBF  5a           pop    dx                    
C000:4DC0  59           pop    cx                    
C000:4DC1  5f           pop    di                    
C000:4DC2  07           pop    es                    
C000:4DC3  1f           pop    ds                    
C000:4DC4  cf           iret                         
C000:4DC6  1e           push   ds                    
C000:4DC7  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4DCC  8a264904     mov    ah, byte ptr [0x449]  
C000:4DD0  80fc0d       cmp    ah, 0xd               
C000:4DD3  72c9         jb     0x4d9e                
C000:4DD5  80fc13       cmp    ah, 0x13              
C000:4DD8  73a4         jae    0x4d7e                
C000:4DDA  56           push   si                    
C000:4DDB  53           push   bx                    
C000:4DDC  51           push   cx                    
C000:4DDD  52           push   dx                    
C000:4DDE  8bf1         mov    si, cx                
C000:4DE0  d1ee         shr    si, 1                 
C000:4DE2  d1ee         shr    si, 1                 
C000:4DE4  d1ee         shr    si, 1                 
C000:4DE6  0aff         or     bh, bh                
C000:4DE8  7534         jne    0x4e1e                
C000:4DEA  a14a04       mov    ax, word ptr [0x44a]  
C000:4DED  f7e2         mul    dx                    
C000:4DEF  03f0         add    si, ax                
C000:4DF1  80e107       and    cl, 7                 
C000:4DF4  b380         mov    bl, 0x80              
C000:4DF6  d2eb         shr    bl, cl                
C000:4DF8  2e8e1e9432   mov    ds, word ptr cs:[0x3294]
C000:4DFD  bace03       mov    dx, 0x3ce             
C000:4E00  32c9         xor    cl, cl                
C000:4E02  b80403       mov    ax, 0x304             
C000:4E05  ef           out    dx, ax                
C000:4E06  8a2c         mov    ch, byte ptr [si]     
C000:4E08  22eb         and    ch, bl                
C000:4E0A  f6dd         neg    ch                    
C000:4E0C  d1c1         rol    cx, 1                 
C000:4E0E  fecc         dec    ah                    
C000:4E10  79f3         jns    0x4e05                
C000:4E12  8ac1         mov    al, cl                
C000:4E14  b40d         mov    ah, 0xd               
C000:4E16  5a           pop    dx                    
C000:4E17  59           pop    cx                    
C000:4E18  5b           pop    bx                    
C000:4E19  5e           pop    si                    
C000:4E1A  1f           pop    ds                    
C000:4E1B  cf           iret                         
C000:4E1E  03364c04     add    si, word ptr [0x44c]  
C000:4E22  fecf         dec    bh                    
C000:4E24  75f8         jne    0x4e1e                
C000:4E26  ebc2         jmp    0x4dea                

;----- sub_4E2A -----
C000:4E2A  b800b8       mov    ax, 0xb800            
C000:4E2D  8ec0         mov    es, ax                
C000:4E2F  b028         mov    al, 0x28              
C000:4E31  f6e2         mul    dl                    
C000:4E33  a808         test   al, 8                 
C000:4E35  7403         je     0x4e3a                
C000:4E37  05d81f       add    ax, 0x1fd8            
C000:4E3A  8bf8         mov    di, ax                
C000:4E3C  8ac1         mov    al, cl                
C000:4E3E  f6d0         not    al                    
C000:4E40  803e490406   cmp    byte ptr [0x449], 6   
C000:4E45  7208         jb     0x4e4f                
C000:4E47  d1e9         shr    cx, 1                 
C000:4E49  b4fe         mov    ah, 0xfe              
C000:4E4B  2407         and    al, 7                 
C000:4E4D  eb06         jmp    0x4e55                
C000:4E4F  b4fc         mov    ah, 0xfc              
C000:4E51  d0e0         shl    al, 1                 
C000:4E53  2406         and    al, 6                 
C000:4E55  d1e9         shr    cx, 1                 
C000:4E57  d1e9         shr    cx, 1                 
C000:4E59  03f9         add    di, cx                
C000:4E5B  8ac8         mov    cl, al                
C000:4E5D  d2c4         rol    ah, cl                
C000:4E5F  c3           ret                          
C000:4E62  7412         je     0x4e76                
C000:4E64  3c0a         cmp    al, 0xa               
C000:4E66  745b         je     0x4ec3                
C000:4E68  3c08         cmp    al, 8                 
C000:4E6A  7412         je     0x4e7e                
C000:4E6C  3c07         cmp    al, 7                 
C000:4E6E  753c         jne    0x4eac                
C000:4E70  e8d200       call   0x4f45                 ; "PSQR"
C000:4E73  e9bb00       jmp    0x4f31                
C000:4E76  32d2         xor    dl, dl                
C000:4E78  e98d00       jmp    0x4f08                
C000:4E7E  feca         dec    dl                    
C000:4E80  7903         jns    0x4e85                
C000:4E82  e9ac00       jmp    0x4f31                
C000:4E85  e98000       jmp    0x4f08                
C000:4E8A  50           push   ax                    
C000:4E8B  53           push   bx                    
C000:4E8C  51           push   cx                    
C000:4E8D  52           push   dx                    
C000:4E8E  56           push   si                    
C000:4E8F  57           push   di                    
C000:4E90  55           push   bp                    
C000:4E91  06           push   es                    
C000:4E92  1e           push   ds                    
C000:4E93  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4E98  8a0e6204     mov    cl, byte ptr [0x462]  
C000:4E9C  32ed         xor    ch, ch                
C000:4E9E  8bf9         mov    di, cx                
C000:4EA0  d1e7         shl    di, 1                 
C000:4EA2  8af9         mov    bh, cl                
C000:4EA4  8b955004     mov    dx, word ptr [di + 0x450]
C000:4EA8  3c0d         cmp    al, 0xd               
C000:4EAA  76b6         jbe    0x4e62                
C000:4EAC  52           push   dx                    
C000:4EAD  b90100       mov    cx, 1                 
C000:4EB0  e88ffa       call   0x4942                
C000:4EB3  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4EB8  5a           pop    dx                    
C000:4EB9  fec2         inc    dl                    
C000:4EBB  3a164a04     cmp    dl, byte ptr [0x44a]  
C000:4EBF  7547         jne    0x4f08                
C000:4EC1  32d2         xor    dl, dl                
C000:4EC3  fec6         inc    dh                    
C000:4EC5  3a368404     cmp    dh, byte ptr [0x484]  
C000:4EC9  763d         jbe    0x4f08                
C000:4ECB  fece         dec    dh                    
C000:4ECD  52           push   dx                    
C000:4ECE  e85df7       call   0x462e                
C000:4ED1  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4ED6  8afc         mov    bh, ah                
C000:4ED8  a04904       mov    al, byte ptr [0x449]  
C000:4EDB  3c04         cmp    al, 4                 
C000:4EDD  7211         jb     0x4ef0                
C000:4EDF  3c07         cmp    al, 7                 
C000:4EE1  740d         je     0x4ef0                
C000:4EE3  3c13         cmp    al, 0x13              
C000:4EE5  7607         jbe    0x4eee                
C000:4EE7  8ae0         mov    ah, al                
C000:4EE9  e866cf       call   0x1e52                
C000:4EEC  7302         jae    0x4ef0                
C000:4EEE  32ff         xor    bh, bh                
C000:4EF0  8a164a04     mov    dl, byte ptr [0x44a]  
C000:4EF4  feca         dec    dl                    
C000:4EF6  8a368404     mov    dh, byte ptr [0x484]  
C000:4EFA  33c9         xor    cx, cx                
C000:4EFC  b80106       mov    ax, 0x601             
C000:4EFF  e820f2       call   0x4122                
C000:4F02  2e8e1e9232   mov    ds, word ptr cs:[0x3292]
C000:4F07  5a           pop    dx                    
C000:4F08  a06204       mov    al, byte ptr [0x462]  
C000:4F0B  0ac0         or     al, al                
C000:4F0D  752f         jne    0x4f3e                
C000:4F0F  89165004     mov    word ptr [0x450], dx  
C000:4F13  38066204     cmp    byte ptr [0x462], al  
C000:4F17  7518         jne    0x4f31                
C000:4F19  a04a04       mov    al, byte ptr [0x44a]  
C000:4F1C  f6e6         mul    dh                    
C000:4F1E  02c2         add    al, dl                
C000:4F20  80d400       adc    ah, 0                 
C000:4F23  8ad8         mov    bl, al                
C000:4F25  b00e         mov    al, 0xe                ; "VIDEO "
C000:4F27  8b166304     mov    dx, word ptr [0x463]  
C000:4F2B  ef           out    dx, ax                
C000:4F2C  8ae3         mov    ah, bl                
C000:4F2E  fec0         inc    al                    
C000:4F30  ef           out    dx, ax                
C000:4F31  1f           pop    ds                    
C000:4F32  07           pop    es                    
C000:4F33  5d           pop    bp                    
C000:4F34  5f           pop    di                    
C000:4F35  5e           pop    si                    
C000:4F36  5a           pop    dx                    
C000:4F37  59           pop    cx                    
C000:4F38  5b           pop    bx                    
C000:4F39  58           pop    ax                    
C000:4F3A  cf           iret                         
C000:4F3E  8af8         mov    bh, al                
C000:4F40  e839f1       call   0x407c                
C000:4F43  ebec         jmp    0x4f31                

;----- sub_4F45 -----
C000:4F45  50           push   ax                    
C000:4F46  53           push   bx                    
C000:4F47  51           push   cx                    
C000:4F48  52           push   dx                    
C000:4F49  b002         mov    al, 2                 
C000:4F4B  b90003       mov    cx, 0x300             
C000:4F4E  e8a30e       call   0x5df4                
C000:4F51  b000         mov    al, 0                 
C000:4F53  b92000       mov    cx, 0x20              
C000:4F56  e89b0e       call   0x5df4                
C000:4F59  5a           pop    dx                    
C000:4F5A  59           pop    cx                    
C000:4F5B  5b           pop    bx                    
C000:4F5C  58           pop    ax                    
C000:4F5D  c3           ret                          

;----- sub_512A -----
C000:512A  52           push   dx                    
C000:512B  bacc03       mov    dx, 0x3cc             
C000:512E  ec           in     al, dx                
C000:512F  bad403       mov    dx, 0x3d4             
C000:5132  a801         test   al, 1                 
C000:5134  7503         jne    0x5139                
C000:5136  bab403       mov    dx, 0x3b4             
C000:5139  80c206       add    dl, 6                 
C000:513C  52           push   dx                    
C000:513D  ec           in     al, dx                
C000:513E  2408         and    al, 8                 
C000:5140  74fb         je     0x513d                
C000:5142  52           push   dx                    
C000:5143  bac003       mov    dx, 0x3c0             
C000:5146  8ac3         mov    al, bl                
C000:5148  9c           pushf                        
C000:5149  fa           cli                          
C000:514A  ee           out    dx, al                
C000:514B  eb00         jmp    0x514d                
C000:514D  42           inc    dx                    
C000:514E  ec           in     al, dx                
C000:514F  9d           popf                         
C000:5150  5a           pop    dx                    
C000:5151  8af8         mov    bh, al                
C000:5153  9c           pushf                        
C000:5154  fa           cli                          
C000:5155  ec           in     al, dx                
C000:5156  bac003       mov    dx, 0x3c0             
C000:5159  b020         mov    al, 0x20              
C000:515B  ee           out    dx, al                
C000:515C  9d           popf                         
C000:515D  5a           pop    dx                    
C000:515E  ec           in     al, dx                
C000:515F  5a           pop    dx                    
C000:5160  c3           ret                          

;----- sub_518C -----
C000:518C  f606890406   test   byte ptr [0x489], 6   
C000:5191  7444         je     0x51d7                
C000:5193  53           push   bx                    
C000:5194  52           push   dx                    
C000:5195  25003f       and    ax, 0x3f00            
C000:5198  86c4         xchg   ah, al                
C000:519A  2ef7268651   mul    word ptr cs:[0x5186]  
C000:519F  52           push   dx                    
C000:51A0  50           push   ax                    
C000:51A1  8ac5         mov    al, ch                
C000:51A3  243f         and    al, 0x3f              
C000:51A5  32e4         xor    ah, ah                
C000:51A7  2ef7268851   mul    word ptr cs:[0x5188]  
C000:51AC  52           push   dx                    
C000:51AD  50           push   ax                    
C000:51AE  8ac1         mov    al, cl                
C000:51B0  243f         and    al, 0x3f              
C000:51B2  32e4         xor    ah, ah                
C000:51B4  2ef7268a51   mul    word ptr cs:[0x518a]  
C000:51B9  5b           pop    bx                    
C000:51BA  03c3         add    ax, bx                
C000:51BC  5b           pop    bx                    
C000:51BD  13d3         adc    dx, bx                
C000:51BF  5b           pop    bx                    
C000:51C0  03c3         add    ax, bx                
C000:51C2  5b           pop    bx                    
C000:51C3  13d3         adc    dx, bx                
C000:51C5  03c0         add    ax, ax                
C000:51C7  13d2         adc    dx, dx                
C000:51C9  050080       add    ax, 0x8000            
C000:51CC  83d200       adc    dx, 0                 
C000:51CF  8ae2         mov    ah, dl                
C000:51D1  8aca         mov    cl, dl                
C000:51D3  8aea         mov    ch, dl                
C000:51D5  5a           pop    dx                    
C000:51D6  5b           pop    bx                    
C000:51D7  c3           ret                          

;----- sub_5219 -----
C000:5219  8ae0         mov    ah, al                
C000:521B  240f         and    al, 0xf               
C000:521D  80e430       and    ah, 0x30              
C000:5220  d0ec         shr    ah, 1                 
C000:5222  0ac4         or     al, ah                
C000:5224  3c19         cmp    al, 0x19              
C000:5226  730b         jae    0x5233                
C000:5228  32e4         xor    ah, ah                
C000:522A  8bf8         mov    di, ax                
C000:522C  d1e7         shl    di, 1                 
C000:522E  2effa5d851   jmp    word ptr cs:[di + 0x51d8]
C000:5233  c3           ret                          

;----- sub_5DAE -----
C000:5DAE  ee           out    dx, al                
C000:5DAF  42           inc    dx                    
C000:5DB0  fec0         inc    al                    
C000:5DB2  8ae0         mov    ah, al                
C000:5DB4  e300         jcxz   0x5db6                
C000:5DB6  e300         jcxz   0x5db8                
C000:5DB8  ec           in     al, dx                
C000:5DB9  4a           dec    dx                    
C000:5DBA  86c4         xchg   ah, al                
C000:5DBC  c3           ret                          

;----- sub_5DBD -----
C000:5DBD  ee           out    dx, al                
C000:5DBE  42           inc    dx                    
C000:5DBF  ec           in     al, dx                
C000:5DC0  c3           ret                          

;----- sub_5DC2 -----
C000:5DC2  ee           out    dx, al                
C000:5DC3  eb00         jmp    0x5dc5                
C000:5DC5  ed           in     ax, dx                
C000:5DC6  c3           ret                          

;----- sub_5DC7 -----
C000:5DC7  52           push   dx                    
C000:5DC8  e874c1       call   0x1f3f                
C000:5DCB  5a           pop    dx                    
C000:5DCC  c3           ret                          

;----- sub_5DCD -----
C000:5DCD  52           push   dx                    
C000:5DCE  bad603       mov    dx, 0x3d6             
C000:5DD1  ef           out    dx, ax                
C000:5DD2  5a           pop    dx                    
C000:5DD3  c3           ret                          

;----- sub_5DD4 -----
C000:5DD4  b020         mov    al, 0x20              
C000:5DD6  e80700       call   0x5de0                
C000:5DD9  c3           ret                          

;----- sub_5DDA -----
C000:5DDA  32c0         xor    al, al                
C000:5DDC  e80100       call   0x5de0                
C000:5DDF  c3           ret                          

;----- sub_5DE0 -----
C000:5DE0  52           push   dx                    
C000:5DE1  8b166304     mov    dx, word ptr [0x463]  
C000:5DE5  50           push   ax                    
C000:5DE6  80c206       add    dl, 6                 
C000:5DE9  ec           in     al, dx                
C000:5DEA  58           pop    ax                    
C000:5DEB  52           push   dx                    
C000:5DEC  bac003       mov    dx, 0x3c0             
C000:5DEF  ee           out    dx, al                
C000:5DF0  5a           pop    dx                    
C000:5DF1  ec           in     al, dx                
C000:5DF2  5a           pop    dx                    
C000:5DF3  c3           ret                          

;----- sub_5DF4 -----
C000:5DF4  8ad8         mov    bl, al                
C000:5DF6  e461         in     al, 0x61              
C000:5DF8  eb00         jmp    0x5dfa                
C000:5DFA  8af8         mov    bh, al                
C000:5DFC  24fc         and    al, 0xfc              
C000:5DFE  0ac3         or     al, bl                
C000:5E00  0c01         or     al, 1                 
C000:5E02  e661         out    0x61, al              
C000:5E04  eb00         jmp    0x5e06                
C000:5E06  b0b6         mov    al, 0xb6              
C000:5E08  e643         out    0x43, al              
C000:5E0A  eb00         jmp    0x5e0c                
C000:5E0C  b050         mov    al, 0x50              
C000:5E0E  e642         out    0x42, al              
C000:5E10  eb00         jmp    0x5e12                
C000:5E12  b005         mov    al, 5                 
C000:5E14  e642         out    0x42, al              
C000:5E16  baffff       mov    dx, 0xffff            
C000:5E19  b080         mov    al, 0x80              
C000:5E1B  e643         out    0x43, al              
C000:5E1D  eb00         jmp    0x5e1f                
C000:5E1F  e442         in     al, 0x42              
C000:5E21  eb00         jmp    0x5e23                
C000:5E23  8ae0         mov    ah, al                
C000:5E25  e442         in     al, 0x42              
C000:5E27  86c4         xchg   ah, al                
C000:5E29  3bc2         cmp    ax, dx                
C000:5E2B  8bd0         mov    dx, ax                
C000:5E2D  72ea         jb     0x5e19                
C000:5E2F  e2e8         loop   0x5e19                
C000:5E31  e461         in     al, 0x61              
C000:5E33  eb00         jmp    0x5e35                
C000:5E35  22c7         and    al, bh                
C000:5E37  e661         out    0x61, al              
C000:5E39  c3           ret                          

;----- sub_5E76 -----
C000:5E76  b90200       mov    cx, 2                 
C000:5E79  f606890410   test   byte ptr [0x489], 0x10
C000:5E7E  7519         jne    0x5e99                
C000:5E80  fec9         dec    cl                    
C000:5E82  8a268804     mov    ah, byte ptr [0x488]  
C000:5E86  80e40f       and    ah, 0xf               
C000:5E89  80fc03       cmp    ah, 3                 
C000:5E8C  740b         je     0x5e99                
C000:5E8E  80fc09       cmp    ah, 9                 
C000:5E91  7406         je     0x5e99                
C000:5E93  3c07         cmp    al, 7                 
C000:5E95  7402         je     0x5e99                
C000:5E97  fec9         dec    cl                    
C000:5E99  c3           ret                          

;----- sub_5E9A -----
C000:5E9A  a04904       mov    al, byte ptr [0x449]  

;----- sub_5E9D -----
C000:5E9D  50           push   ax                    
C000:5E9E  53           push   bx                    
C000:5E9F  51           push   cx                    
C000:5EA0  3c13         cmp    al, 0x13              
C000:5EA2  760b         jbe    0x5eaf                
C000:5EA4  e887b8       call   0x172e                
C000:5EA7  7506         jne    0x5eaf                
C000:5EA9  8cc8         mov    ax, cs                
C000:5EAB  8ec0         mov    es, ax                
C000:5EAD  eb21         jmp    0x5ed0                
C000:5EAF  e8c4ff       call   0x5e76                
C000:5EB2  be3a5e       mov    si, 0x5e3a            
C000:5EB5  e305         jcxz   0x5ebc                
C000:5EB7  83c614       add    si, 0x14              
C000:5EBA  e2fb         loop   0x5eb7                
C000:5EBC  8ad8         mov    bl, al                
C000:5EBE  32ff         xor    bh, bh                
C000:5EC0  2e8a00       mov    al, byte ptr cs:[bx + si]
C000:5EC3  b440         mov    ah, 0x40              
C000:5EC5  f6e4         mul    ah                    
C000:5EC7  8bf0         mov    si, ax                
C000:5EC9  33db         xor    bx, bx                
C000:5ECB  e8efe0       call   0x3fbd                
C000:5ECE  03f3         add    si, bx                
C000:5ED0  59           pop    cx                    
C000:5ED1  5b           pop    bx                    
C000:5ED2  58           pop    ax                    
C000:5ED3  c3           ret                          

;----- sub_5ED6 -----
C000:5ED6  51           push   cx                    
C000:5ED7  52           push   dx                    
C000:5ED8  e80001       call   0x5fdb                
C000:5EDB  e80c00       call   0x5eea                
C000:5EDE  e866b4       call   0x1347                
C000:5EE1  e814b4       call   0x12f8                
C000:5EE4  e8fc00       call   0x5fe3                
C000:5EE7  5a           pop    dx                    
C000:5EE8  59           pop    cx                    
C000:5EE9  c3           ret                          

;----- sub_5EEA -----
C000:5EEA  51           push   cx                    
C000:5EEB  52           push   dx                    
C000:5EEC  b91900       mov    cx, 0x19              
C000:5EEF  b80000       mov    ax, 0                 
C000:5EF2  51           push   cx                    
C000:5EF3  50           push   ax                    
C000:5EF4  b90500       mov    cx, 5                 
C000:5EF7  03f1         add    si, cx                
C000:5EF9  b80001       mov    ax, 0x100             
C000:5EFC  bac403       mov    dx, 0x3c4             
C000:5EFF  9c           pushf                        
C000:5F00  fa           cli                          
C000:5F01  ef           out    dx, ax                
C000:5F02  fec0         inc    al                    
C000:5F04  268a24       mov    ah, byte ptr es:[si]  
C000:5F07  46           inc    si                    
C000:5F08  e2f7         loop   0x5f01                
C000:5F0A  8ac4         mov    al, ah                
C000:5F0C  bac203       mov    dx, 0x3c2             
C000:5F0F  ee           out    dx, al                
C000:5F10  bab403       mov    dx, 0x3b4             
C000:5F13  a801         test   al, 1                 
C000:5F15  7403         je     0x5f1a                
C000:5F17  bad403       mov    dx, 0x3d4             
C000:5F1A  89166304     mov    word ptr [0x463], dx  
C000:5F1E  b80003       mov    ax, 0x300             
C000:5F21  bac403       mov    dx, 0x3c4             
C000:5F24  ef           out    dx, ax                
C000:5F25  9d           popf                         
C000:5F26  8b166304     mov    dx, word ptr [0x463]  
C000:5F2A  b81100       mov    ax, 0x11              
C000:5F2D  ef           out    dx, ax                
C000:5F2E  58           pop    ax                    
C000:5F2F  59           pop    cx                    
C000:5F30  03f0         add    si, ax                
C000:5F32  268a24       mov    ah, byte ptr es:[si]  
C000:5F35  46           inc    si                    
C000:5F36  ef           out    dx, ax                
C000:5F37  fec0         inc    al                    
C000:5F39  e2f7         loop   0x5f32                
C000:5F3B  83c206       add    dx, 6                 
C000:5F3E  ec           in     al, dx                
C000:5F3F  52           push   dx                    
C000:5F40  32e4         xor    ah, ah                
C000:5F42  b91000       mov    cx, 0x10              
C000:5F45  bac003       mov    dx, 0x3c0             
C000:5F48  f606890408   test   byte ptr [0x489], 8   
C000:5F4D  750a         jne    0x5f59                
C000:5F4F  8ac4         mov    al, ah                
C000:5F51  ee           out    dx, al                
C000:5F52  fec4         inc    ah                    
C000:5F54  26ac         lodsb  al, byte ptr es:[si]  
C000:5F56  ee           out    dx, al                
C000:5F57  e2f6         loop   0x5f4f                
C000:5F59  02e1         add    ah, cl                
C000:5F5B  03f1         add    si, cx                
C000:5F5D  b90500       mov    cx, 5                 
C000:5F60  80fc11       cmp    ah, 0x11              
C000:5F63  7509         jne    0x5f6e                
C000:5F65  46           inc    si                    
C000:5F66  f606890408   test   byte ptr [0x489], 8   
C000:5F6B  7510         jne    0x5f7d                
C000:5F6D  4e           dec    si                    
C000:5F6E  8ac4         mov    al, ah                
C000:5F70  ee           out    dx, al                
C000:5F71  eb00         jmp    0x5f73                
C000:5F73  32c0         xor    al, al                
C000:5F75  80fc14       cmp    ah, 0x14              
C000:5F78  7402         je     0x5f7c                
C000:5F7A  26ac         lodsb  al, byte ptr es:[si]  
C000:5F7C  ee           out    dx, al                
C000:5F7D  fec4         inc    ah                    
C000:5F7F  e2df         loop   0x5f60                
C000:5F81  5a           pop    dx                    
C000:5F82  ec           in     al, dx                
C000:5F83  32c0         xor    al, al                
C000:5F85  bacc03       mov    dx, 0x3cc             
C000:5F88  ee           out    dx, al                
C000:5F89  fec0         inc    al                    
C000:5F8B  baca03       mov    dx, 0x3ca             
C000:5F8E  ee           out    dx, al                
C000:5F8F  32c0         xor    al, al                
C000:5F91  b90900       mov    cx, 9                 
C000:5F94  bace03       mov    dx, 0x3ce             
C000:5F97  268a24       mov    ah, byte ptr es:[si]  
C000:5F9A  46           inc    si                    
C000:5F9B  ef           out    dx, ax                
C000:5F9C  fec0         inc    al                    
C000:5F9E  e2f7         loop   0x5f97                
C000:5FA0  5a           pop    dx                    
C000:5FA1  59           pop    cx                    
C000:5FA2  c3           ret                          

;----- sub_5FC0 -----
C000:5FC0  9c           pushf                        
C000:5FC1  fa           cli                          
C000:5FC2  bac803       mov    dx, 0x3c8             
C000:5FC5  8ac3         mov    al, bl                
C000:5FC7  ee           out    dx, al                
C000:5FC8  eb00         jmp    0x5fca                
C000:5FCA  42           inc    dx                    
C000:5FCB  8ac4         mov    al, ah                
C000:5FCD  ee           out    dx, al                
C000:5FCE  eb00         jmp    0x5fd0                
C000:5FD0  8ac5         mov    al, ch                
C000:5FD2  ee           out    dx, al                
C000:5FD3  eb00         jmp    0x5fd5                
C000:5FD5  8ac1         mov    al, cl                
C000:5FD7  ee           out    dx, al                
C000:5FD8  43           inc    bx                    
C000:5FD9  9d           popf                         
C000:5FDA  c3           ret                          

;----- sub_5FDB -----
C000:5FDB  51           push   cx                    
C000:5FDC  b120         mov    cl, 0x20              
C000:5FDE  e80a00       call   0x5feb                
C000:5FE1  59           pop    cx                    
C000:5FE2  c3           ret                          

;----- sub_5FE3 -----
C000:5FE3  51           push   cx                    
C000:5FE4  b100         mov    cl, 0                 
C000:5FE6  e80200       call   0x5feb                
C000:5FE9  59           pop    cx                    
C000:5FEA  c3           ret                          

;----- sub_5FEB -----
C000:5FEB  50           push   ax                    
C000:5FEC  52           push   dx                    
C000:5FED  bac403       mov    dx, 0x3c4             
C000:5FF0  9c           pushf                        
C000:5FF1  fa           cli                          
C000:5FF2  ec           in     al, dx                
C000:5FF3  50           push   ax                    
C000:5FF4  b001         mov    al, 1                 
C000:5FF6  e8c9fd       call   0x5dc2                
C000:5FF9  80e4df       and    ah, 0xdf              
C000:5FFC  0ae1         or     ah, cl                
C000:5FFE  ef           out    dx, ax                
C000:5FFF  58           pop    ax                    
C000:6000  ee           out    dx, al                
C000:6001  9d           popf                         
C000:6002  5a           pop    dx                    
C000:6003  58           pop    ax                    
C000:6004  c3           ret                          

;----- sub_6005 -----
C000:6005  e8d3ff       call   0x5fdb                
C000:6008  be0001       mov    si, 0x100             
C000:600B  33db         xor    bx, bx                
C000:600D  32e4         xor    ah, ah                
C000:600F  33c9         xor    cx, cx                
C000:6011  e8acff       call   0x5fc0                
C000:6014  4e           dec    si                    
C000:6015  75fa         jne    0x6011                
C000:6017  e8c9ff       call   0x5fe3                
C000:601A  c3           ret                          

;----- sub_601B -----
C000:601B  f606890408   test   byte ptr [0x489], 8   
C000:6020  7401         je     0x6023                
C000:6022  c3           ret                          
C000:6023  bac603       mov    dx, 0x3c6             
C000:6026  ec           in     al, dx                
C000:6027  fec0         inc    al                    
C000:6029  7403         je     0x602e                
C000:602B  b0ff         mov    al, 0xff              
C000:602D  ee           out    dx, al                
C000:602E  bf4000       mov    di, 0x40              
C000:6031  33db         xor    bx, bx                
C000:6033  a04904       mov    al, byte ptr [0x449]  
C000:6036  3c07         cmp    al, 7                 
C000:6038  7478         je     0x60b2                
C000:603A  3c0f         cmp    al, 0xf               
C000:603C  7474         je     0x60b2                
C000:603E  3c13         cmp    al, 0x13              
C000:6040  7219         jb     0x605b                
C000:6042  7503         jne    0x6047                
C000:6044  e9af00       jmp    0x60f6                
C000:6047  8ae0         mov    ah, al                
C000:6049  e8d5b6       call   0x1721                
C000:604C  86e0         xchg   al, ah                
C000:604E  f6c402       test   ah, 2                 
C000:6051  745f         je     0x60b2                
C000:6053  f6c404       test   ah, 4                 
C000:6056  742d         je     0x6085                
C000:6058  e99b00       jmp    0x60f6                
C000:605B  3c04         cmp    al, 4                 
C000:605D  720e         jb     0x606d                
C000:605F  3c06         cmp    al, 6                 
C000:6061  762b         jbe    0x608e                
C000:6063  3c08         cmp    al, 8                 
C000:6065  741e         je     0x6085                
C000:6067  3c0e         cmp    al, 0xe                ; "VIDEO "
C000:6069  7623         jbe    0x608e                
C000:606B  eb18         jmp    0x6085                
C000:606D  f606890410   test   byte ptr [0x489], 0x10
C000:6072  7511         jne    0x6085                
C000:6074  8a268804     mov    ah, byte ptr [0x488]  
C000:6078  80e40f       and    ah, 0xf               
C000:607B  80fc03       cmp    ah, 3                 
C000:607E  7405         je     0x6085                
C000:6080  80fc09       cmp    ah, 9                 
C000:6083  7509         jne    0x608e                
C000:6085  f606890406   test   byte ptr [0x489], 6   
C000:608A  7541         jne    0x60cd                
C000:608C  eb5a         jmp    0x60e8                
C000:608E  f606890406   test   byte ptr [0x489], 6   
C000:6093  7443         je     0x60d8                
C000:6095  b707         mov    bh, 7                 
C000:6097  8bd3         mov    dx, bx                
C000:6099  beb463       mov    si, 0x63b4            
C000:609C  e80101       call   0x61a0                
C000:609F  f6c208       test   dl, 8                 
C000:60A2  75f8         jne    0x609c                
C000:60A4  83c608       add    si, 8                 
C000:60A7  f6c210       test   dl, 0x10              
C000:60AA  75f0         jne    0x609c                
C000:60AC  80fa20       cmp    dl, 0x20              
C000:60AF  74e8         je     0x6099                
C000:60B1  c3           ret                          
C000:60B2  b700         mov    bh, 0                 
C000:60B4  8bd3         mov    dx, bx                
C000:60B6  be2864       mov    si, 0x6428            
C000:60B9  e8e400       call   0x61a0                
C000:60BC  f6c207       test   dl, 7                 
C000:60BF  75f8         jne    0x60b9                
C000:60C1  80fa20       cmp    dl, 0x20              
C000:60C4  74f0         je     0x60b6                
C000:60C6  46           inc    si                    
C000:60C7  80fa40       cmp    dl, 0x40              
C000:60CA  75ed         jne    0x60b9                
C000:60CC  c3           ret                          
C000:60CD  b73f         mov    bh, 0x3f              
C000:60CF  8bd3         mov    dx, bx                
C000:60D1  bee863       mov    si, 0x63e8            
C000:60D4  e8c900       call   0x61a0                
C000:60D7  c3           ret                          
C000:60D8  b788         mov    bh, 0x88              
C000:60DA  8bd3         mov    dx, bx                
C000:60DC  bfaf63       mov    di, 0x63af            
C000:60DF  bea063       mov    si, 0x63a0            
C000:60E2  e87000       call   0x6155                
C000:60E5  74f5         je     0x60dc                
C000:60E7  c3           ret                          
C000:60E8  8bd3         mov    dx, bx                
C000:60EA  bfe363       mov    di, 0x63e3            
C000:60ED  bec463       mov    si, 0x63c4            
C000:60F0  e86200       call   0x6155                
C000:60F3  74f8         je     0x60ed                
C000:60F5  c3           ret                          
C000:60F6  f606890406   test   byte ptr [0x489], 6   
C000:60FB  7514         jne    0x6111                
C000:60FD  bfaf63       mov    di, 0x63af            
C000:6100  bea063       mov    si, 0x63a0            
C000:6103  8bd3         mov    dx, bx                
C000:6105  e86d00       call   0x6175                
C000:6108  03f2         add    si, dx                
C000:610A  f6c208       test   dl, 8                 
C000:610D  75f6         jne    0x6105                
C000:610F  eb0a         jmp    0x611b                
C000:6111  b70f         mov    bh, 0xf               
C000:6113  8bd3         mov    dx, bx                
C000:6115  beb463       mov    si, 0x63b4            
C000:6118  e88500       call   0x61a0                
C000:611B  b61f         mov    dh, 0x1f              
C000:611D  8bda         mov    bx, dx                
C000:611F  be2064       mov    si, 0x6420            
C000:6122  e87b00       call   0x61a0                
C000:6125  bf0900       mov    di, 9                 
C000:6128  bb2000       mov    bx, 0x20              
C000:612B  be4064       mov    si, 0x6440            
C000:612E  ba1004       mov    dx, 0x410             
C000:6131  57           push   di                    
C000:6132  bf921b       mov    di, 0x1b92            
C000:6135  e87d00       call   0x61b5                
C000:6138  52           push   dx                    
C000:6139  f606890406   test   byte ptr [0x489], 6   
C000:613E  7403         je     0x6143                
C000:6140  e849f0       call   0x518c                
C000:6143  e87afe       call   0x5fc0                
C000:6146  5a           pop    dx                    
C000:6147  81fa1004     cmp    dx, 0x410             
C000:614B  75e8         jne    0x6135                
C000:614D  83c605       add    si, 5                 
C000:6150  5f           pop    di                    
C000:6151  4f           dec    di                    
C000:6152  75dd         jne    0x6131                
C000:6154  c3           ret                          

;----- sub_6155 -----
C000:6155  e81d00       call   0x6175                
C000:6158  f6c218       test   dl, 0x18              
C000:615B  7414         je     0x6171                
C000:615D  f6c680       test   dh, 0x80              
C000:6160  7408         je     0x616a                
C000:6162  84d6         test   dh, dl                
C000:6164  7406         je     0x616c                
C000:6166  4f           dec    di                    
C000:6167  4f           dec    di                    
C000:6168  ebeb         jmp    0x6155                
C000:616A  4f           dec    di                    
C000:616B  4f           dec    di                    
C000:616C  83c608       add    si, 8                 
C000:616F  ebe4         jmp    0x6155                
C000:6171  80fa20       cmp    dl, 0x20              
C000:6174  c3           ret                          

;----- sub_6175 -----
C000:6175  47           inc    di                    
C000:6176  2e8a25       mov    ah, byte ptr cs:[di]  
C000:6179  d0e3         shl    bl, 1                 
C000:617B  32ff         xor    bh, bh                
C000:617D  2e8b08       mov    cx, word ptr cs:[bx + si]
C000:6180  f6c540       test   ch, 0x40              
C000:6183  7409         je     0x618e                
C000:6185  f6c204       test   dl, 4                 
C000:6188  7404         je     0x618e                
C000:618A  2e8a6d01     mov    ch, byte ptr cs:[di + 1]
C000:618E  8bda         mov    bx, dx                
C000:6190  e82dfe       call   0x5fc0                
C000:6193  8bd3         mov    dx, bx                
C000:6195  80e303       and    bl, 3                 
C000:6198  75df         jne    0x6179                
C000:619A  f6c204       test   dl, 4                 
C000:619D  75d6         jne    0x6175                
C000:619F  c3           ret                          

;----- sub_61A0 -----
C000:61A0  32ff         xor    bh, bh                
C000:61A2  2e8a20       mov    ah, byte ptr cs:[bx + si]
C000:61A5  8bda         mov    bx, dx                
C000:61A7  8acc         mov    cl, ah                
C000:61A9  8ae9         mov    ch, cl                
C000:61AB  e812fe       call   0x5fc0                
C000:61AE  8bd3         mov    dx, bx                
C000:61B0  22df         and    bl, bh                
C000:61B2  75ec         jne    0x61a0                
C000:61B4  c3           ret                          

;----- sub_61B5 -----
C000:61B5  53           push   bx                    
C000:61B6  8bcf         mov    cx, di                
C000:61B8  fecb         dec    bl                    
C000:61BA  f6c303       test   bl, 3                 
C000:61BD  7506         jne    0x61c5                
C000:61BF  d0c9         ror    cl, 1                 
C000:61C1  d0c5         rol    ch, 1                 
C000:61C3  8bf9         mov    di, cx                
C000:61C5  22e9         and    ch, cl                
C000:61C7  b80100       mov    ax, 1                 
C000:61CA  80e106       and    cl, 6                 
C000:61CD  d0e1         shl    cl, 1                 
C000:61CF  d3e0         shl    ax, cl                
C000:61D1  80e507       and    ch, 7                 
C000:61D4  7404         je     0x61da                
C000:61D6  2bd0         sub    dx, ax                
C000:61D8  eb02         jmp    0x61dc                
C000:61DA  03d0         add    dx, ax                
C000:61DC  8ada         mov    bl, dl                
C000:61DE  80e307       and    bl, 7                 
C000:61E1  2e8a20       mov    ah, byte ptr cs:[bx + si]
C000:61E4  8ada         mov    bl, dl                
C000:61E6  83e370       and    bx, 0x70              
C000:61E9  b104         mov    cl, 4                 
C000:61EB  d2eb         shr    bl, cl                
C000:61ED  2e8a28       mov    ch, byte ptr cs:[bx + si]
C000:61F0  8bda         mov    bx, dx                
C000:61F2  81e30007     and    bx, 0x700             
C000:61F6  d0e1         shl    cl, 1                 
C000:61F8  d3eb         shr    bx, cl                
C000:61FA  2e8a08       mov    cl, byte ptr cs:[bx + si]
C000:61FD  5b           pop    bx                    
C000:61FE  c3           ret                          
