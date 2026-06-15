; IBM PC110 system BIOS (39H4551) — F000 segment, recursive-descent disassembly
; file 0x30000-0x3FFFF -> phys F0000-FFFFF; reset entry F000:E05B
; reachable instructions: 4919 ; call-target functions: 169


;----- sub_3315 -----
F000:3315  52             push   dx                      
F000:3316  50             push   ax                      
F000:3317  b00e           mov    al, 0xe                 
F000:3319  e8faa8         call   0xffffdc16              
F000:331C  a8c0           test   al, 0xc0                
F000:331E  58             pop    ax                      
F000:331F  5a             pop    dx                      
F000:3320  c3             ret                            

;----- sub_34D6 -----
F000:34D6  60             pushaw                         
F000:34D7  b013           mov    al, 0x13                
F000:34D9  e83aa7         call   0xffffdc16              
F000:34DC  a801           test   al, 1                   
F000:34DE  7446           je     0x3526                  
F000:34E0  6657           push   edi                     
F000:34E2  6656           push   esi                     
F000:34E4  8bec           mov    bp, sp                  
F000:34E6  83ec08         sub    sp, 8                   
F000:34E9  8bdc           mov    bx, sp                  
F000:34EB  53             push   bx                      
F000:34EC  b90700         mov    cx, 7                   
F000:34EF  b4b8           mov    ah, 0xb8                
F000:34F1  8ac4           mov    al, ah                  
F000:34F3  e820a7         call   0xffffdc16              
F000:34F6  247f           and    al, 0x7f                
F000:34F8  7408           je     0x3502                  
F000:34FA  368807         mov    byte ptr ss:[bx], al    
F000:34FD  fec4           inc    ah                      
F000:34FF  43             inc    bx                      
F000:3500  e2ef           loop   0x34f1                  
F000:3502  36c6071c       mov    byte ptr ss:[bx], 0x1c  
F000:3506  36c6470100     mov    byte ptr ss:[bx + 1], 0  ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:350B  5b             pop    bx                      
F000:350C  36668b37       mov    esi, dword ptr ss:[bx]  
F000:3510  36668b7f04     mov    edi, dword ptr ss:[bx + 4]
F000:3515  b88053         mov    ax, 0x5380              
F000:3518  bb018a         mov    bx, 0x8a01              
F000:351B  b506           mov    ch, 6                   
F000:351D  e8dca7         call   0xffffdcfc              
F000:3520  8be5           mov    sp, bp                  
F000:3522  665e           pop    esi                     
F000:3524  665f           pop    edi                     
F000:3526  61             popaw                          
F000:3527  c3             ret                            

;----- sub_3579 -----
F000:3579  53             push   bx                      
F000:357A  50             push   ax                      
F000:357B  e869a7         call   0xffffdce7              
F000:357E  b001           mov    al, 1                   
F000:3580  e877a6         call   0xffffdbfa              
F000:3583  2403           and    al, 3                   
F000:3585  8ad8           mov    bl, al                  
F000:3587  2aff           sub    bh, bh                  
F000:3589  d1e3           shl    bx, 1                   
F000:358B  2e8b9f9835     mov    bx, word ptr cs:[bx + 0x3598]
F000:3590  e860a7         call   0xffffdcf3              
F000:3593  58             pop    ax                      
F000:3594  5a             pop    dx                      
F000:3595  87da           xchg   dx, bx                  
F000:3597  c3             ret                            
F000:35BC  fa             cli                            
F000:35BD  fc             cld                            
F000:35BE  66c1e010       shl    eax, 0x10               
F000:35C2  8cc8           mov    ax, cs                  
F000:35C4  8ed0           mov    ss, ax                  
F000:35C6  8ed8           mov    ds, ax                  
F000:35C8  babc03         mov    dx, 0x3bc               
F000:35CB  b0c1           mov    al, 0xc1                
F000:35CD  ee             out    dx, al                  
F000:35CE  0f20c3         mov    ebx, cr0                
F000:35D1  6681cb00000060 or     ebx, 0x60000000          ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:35D8  0f22c3         mov    cr0, ebx                
F000:35DB  0f08           invd                           
F000:35DD  eb1b           jmp    0x35fa                  
F000:35FA  bc0036         mov    sp, 0x3600              
F000:35FD  e96fa5         jmp    0xffffdb6f              
F000:40E6  fa             cli                            
F000:40E7  fc             cld                            
F000:40E8  8be8           mov    bp, ax                  
F000:40EA  66c1e510       shl    ebp, 0x10               
F000:40EE  8d06f540       lea    ax, [0x40f5]            
F000:40F2  e9c7f4         jmp    0x35bc                  

;----- sub_449B -----
F000:449B  52             push   dx                      
F000:449C  50             push   ax                      
F000:449D  e875ee         call   0x3315                  
F000:44A0  0f850c00       jne    0x44b0                  
F000:44A4  b020           mov    al, 0x20                
F000:44A6  e86d97         call   0xffffdc16              
F000:44A9  a808           test   al, 8                   
F000:44AB  0f840100       je     0x44b0                  
F000:44AF  f9             stc                            
F000:44B0  58             pop    ax                      
F000:44B1  5a             pop    dx                      
F000:44B2  c3             ret                            

;----- sub_44B3 -----
F000:44B3  51             push   cx                      
F000:44B4  e8e4ff         call   0x449b                  
F000:44B7  0f830d00       jae    0x44c8                  
F000:44BB  b582           mov    ch, 0x82                
F000:44BD  e85498         call   0xffffdd14              
F000:44C0  f6c101         test   cl, 1                   
F000:44C3  0f840100       je     0x44c8                  
F000:44C7  f9             stc                            
F000:44C8  59             pop    cx                      
F000:44C9  c3             ret                            
F000:44CA  fa             cli                            
F000:44CB  668bd8         mov    ebx, eax                
F000:44CE  e464           in     al, 0x64                 ; KBC cmd/sts
F000:44D0  a804           test   al, 4                   
F000:44D2  7546           jne    0x451a                  
F000:44D4  660bdb         or     ebx, ebx                
F000:44D7  eb0d           jmp    0x44e6                  
F000:44D9  32c0           xor    al, al                  
F000:44DB  ba9101         mov    dx, 0x191               
F000:44DE  ee             out    dx, al                  
F000:44DF  4a             dec    dx                      
F000:44E0  b0dd           mov    al, 0xdd                
F000:44E2  ee             out    dx, al                  
F000:44E3  f4             hlt                            
F000:44E6  b88dd5         mov    ax, 0xd58d              
F000:44E9  e670           out    0x70, al                 ; RTC index
F000:44EB  9e             sahf                           
F000:44EC  7327           jae    0x4515                  
F000:44EE  7525           jne    0x4515                  
F000:44F0  7b23           jnp    0x4515                  
F000:44F2  7921           jns    0x4515                  
F000:44F4  9f             lahf                           
F000:44F5  b105           mov    cl, 5                   
F000:44F7  d2ec           shr    ah, cl                  
F000:44F9  731a           jae    0x4515                  
F000:44FB  b040           mov    al, 0x40                
F000:44FD  d0e0           shl    al, 1                   
F000:44FF  7114           jno    0x4515                  
F000:4501  32e4           xor    ah, ah                  
F000:4503  9e             sahf                           
F000:4504  760f           jbe    0x4515                  
F000:4506  780d           js     0x4515                  
F000:4508  7a0b           jp     0x4515                  
F000:450A  9f             lahf                           
F000:450B  d2ec           shr    ah, cl                  
F000:450D  7206           jb     0x4515                  
F000:450F  d0e4           shl    ah, 1                   
F000:4511  7002           jo     0x4515                  
F000:4513  7402           je     0x4517                  
F000:4515  ebc2           jmp    0x44d9                  
F000:4517  e90300         jmp    0x451d                  
F000:451A  e91f01         jmp    0x463c                  
F000:451D  66b85500aaff   mov    eax, 0xffaa0055         
F000:4523  f9             stc                            
F000:4524  7205           jb     0x452b                  
F000:4526  663bcf         cmp    ecx, edi                
F000:4529  7559           jne    0x4584                  
F000:452B  668bc8         mov    ecx, eax                
F000:452E  7205           jb     0x4535                  
F000:4530  663bd7         cmp    edx, edi                
F000:4533  754f           jne    0x4584                  
F000:4535  668bd0         mov    edx, eax                
F000:4538  7205           jb     0x453f                  
F000:453A  663bdf         cmp    ebx, edi                
F000:453D  7545           jne    0x4584                  
F000:453F  668bd8         mov    ebx, eax                
F000:4542  7205           jb     0x4549                  
F000:4544  663be7         cmp    esp, edi                
F000:4547  753b           jne    0x4584                  
F000:4549  668be0         mov    esp, eax                
F000:454C  7205           jb     0x4553                  
F000:454E  663bef         cmp    ebp, edi                
F000:4551  7531           jne    0x4584                  
F000:4553  668be8         mov    ebp, eax                
F000:4556  7205           jb     0x455d                  
F000:4558  663bf7         cmp    esi, edi                
F000:455B  7527           jne    0x4584                  
F000:455D  668bf0         mov    esi, eax                
F000:4560  7206           jb     0x4568                  
F000:4562  8cde           mov    si, ds                  
F000:4564  3bf7           cmp    si, di                  
F000:4566  751c           jne    0x4584                  
F000:4568  8ed8           mov    ds, ax                  
F000:456A  7206           jb     0x4572                  
F000:456C  8cc6           mov    si, es                  
F000:456E  3bf7           cmp    si, di                  
F000:4570  7512           jne    0x4584                  
F000:4572  8ec0           mov    es, ax                  
F000:4574  7206           jb     0x457c                  
F000:4576  8ce6           mov    si, fs                  
F000:4578  3bf7           cmp    si, di                  
F000:457A  7508           jne    0x4584                  
F000:457C  8ee0           mov    fs, ax                  
F000:457E  7208           jb     0x4588                  
F000:4580  8cee           mov    si, gs                  
F000:4582  3bf7           cmp    si, di                  
F000:4584  0f859200       jne    0x461a                  
F000:4588  8ee8           mov    gs, ax                  
F000:458A  7206           jb     0x4592                  
F000:458C  8cd6           mov    si, ss                  
F000:458E  3bf7           cmp    si, di                  
F000:4590  75f2           jne    0x4584                  
F000:4592  8ed0           mov    ss, ax                  
F000:4594  668bf0         mov    esi, eax                
F000:4597  7208           jb     0x45a1                  
F000:4599  66d1c7         rol    edi, 1                  
F000:459C  663bf8         cmp    edi, eax                
F000:459F  7579           jne    0x461a                  
F000:45A1  668bf8         mov    edi, eax                
F000:45A4  66d1c7         rol    edi, 1                  
F000:45A7  663bf0         cmp    esi, eax                
F000:45AA  756e           jne    0x461a                  
F000:45AC  668bf7         mov    esi, edi                
F000:45AF  663be8         cmp    ebp, eax                
F000:45B2  7566           jne    0x461a                  
F000:45B4  668bef         mov    ebp, edi                
F000:45B7  663be0         cmp    esp, eax                
F000:45BA  755e           jne    0x461a                  
F000:45BC  668be7         mov    esp, edi                
F000:45BF  663bd8         cmp    ebx, eax                
F000:45C2  7556           jne    0x461a                  
F000:45C4  668bdf         mov    ebx, edi                
F000:45C7  663bd0         cmp    edx, eax                
F000:45CA  754e           jne    0x461a                  
F000:45CC  668bd7         mov    edx, edi                
F000:45CF  663bc8         cmp    ecx, eax                
F000:45D2  7546           jne    0x461a                  
F000:45D4  8cd1           mov    cx, ss                  
F000:45D6  3bc8           cmp    cx, ax                  
F000:45D8  7540           jne    0x461a                  
F000:45DA  8ed7           mov    ss, di                  
F000:45DC  8ce9           mov    cx, gs                  
F000:45DE  3bc8           cmp    cx, ax                  
F000:45E0  7538           jne    0x461a                  
F000:45E2  8eef           mov    gs, di                  
F000:45E4  8ce1           mov    cx, fs                  
F000:45E6  3bc8           cmp    cx, ax                  
F000:45E8  7530           jne    0x461a                  
F000:45EA  8ee7           mov    fs, di                  
F000:45EC  8cc1           mov    cx, es                  
F000:45EE  3bc8           cmp    cx, ax                  
F000:45F0  7528           jne    0x461a                  
F000:45F2  8ec7           mov    es, di                  
F000:45F4  8cd9           mov    cx, ds                  
F000:45F6  3bc8           cmp    cx, ax                  
F000:45F8  7520           jne    0x461a                  
F000:45FA  8edf           mov    ds, di                  
F000:45FC  668bcf         mov    ecx, edi                
F000:45FF  66d1c0         rol    eax, 1                  
F000:4602  663bc7         cmp    eax, edi                
F000:4605  7513           jne    0x461a                  
F000:4607  668bf8         mov    edi, eax                
F000:460A  66c1c710       rol    edi, 0x10               
F000:460E  33f8           xor    di, ax                  
F000:4610  83ffff         cmp    di, -1                  
F000:4613  7408           je     0x461d                  
F000:4615  660bc0         or     eax, eax                
F000:4618  741f           je     0x4639                  
F000:461A  f4             hlt                            
F000:461D  668bf8         mov    edi, eax                
F000:4620  66d1c0         rol    eax, 1                  
F000:4623  663d5500aaff   cmp    eax, 0xffaa0055         
F000:4629  f8             clc                            
F000:462A  7403           je     0x462f                  
F000:462C  e9f5fe         jmp    0x4524                  
F000:462F  f9             stc                            
F000:4630  66b800000000   mov    eax, 0                   ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:4636  e9ebfe         jmp    0x4524                  
F000:4639  e90c00         jmp    0x4648                  
F000:463C  0f20c0         mov    eax, cr0                
F000:463F  6625ffffff9f   and    eax, 0x9fffffff         
F000:4645  0f22c0         mov    cr0, eax                
F000:4648  b84000         mov    ax, 0x40                
F000:464B  8ed8           mov    ds, ax                  
F000:464D  e464           in     al, 0x64                 ; KBC cmd/sts
F000:464F  a804           test   al, 4                   
F000:4651  7503           jne    0x4656                  
F000:4653  eb7c           jmp    0x46d1                  
F000:4656  b08f           mov    al, 0x8f                
F000:4658  e670           out    0x70, al                 ; RTC index
F000:465A  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:465C  e471           in     al, 0x71                 ; RTC data
F000:465E  3c0b           cmp    al, 0xb                 
F000:4660  86c4           xchg   ah, al                  
F000:4662  7427           je     0x468b                  
F000:4664  80fc09         cmp    ah, 9                   
F000:4667  7422           je     0x468b                  
F000:4669  80fc0a         cmp    ah, 0xa                 
F000:466C  741d           je     0x468b                  
F000:466E  80fc0e         cmp    ah, 0xe                 
F000:4671  7418           je     0x468b                  
F000:4673  bb0000         mov    bx, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:4676  8ed3           mov    ss, bx                  
F000:4678  bc0004         mov    sp, 0x400               
F000:467B  368b1efe03     mov    bx, word ptr ss:[0x3fe] 
F000:4680  e8fe21         call   0x6881                  
F000:4683  e80222         call   0x6888                  
F000:4686  36891efe03     mov    word ptr ss:[0x3fe], bx 
F000:468B  b08f           mov    al, 0x8f                
F000:468D  e670           out    0x70, al                 ; RTC index
F000:468F  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:4691  2ac0           sub    al, al                  
F000:4693  e671           out    0x71, al                 ; RTC data
F000:4695  86e0           xchg   al, ah                  
F000:4697  3c0f           cmp    al, 0xf                 
F000:4699  90             nop                            
F000:469A  90             nop                            
F000:469B  7334           jae    0x46d1                  
F000:469D  bea946         mov    si, 0x46a9              
F000:46A0  03f0           add    si, ax                  
F000:46A2  03f0           add    si, ax                  
F000:46A4  2e8b1c         mov    bx, word ptr cs:[si]    
F000:46A7  ffe3           jmp    bx                      
F000:46D1  8d06d846       lea    ax, [0x46d8]            
F000:46D5  e90efa         jmp    0x40e6                  

;----- sub_53A4 -----
F000:53A4  e87601         call   0x551d                   ; "VPQR3"
F000:53A7  f7c5ff3f       test   bp, 0x3fff              
F000:53AB  7510           jne    0x53bd                  
F000:53AD  56             push   si                      
F000:53AE  81e6ff3f       and    si, 0x3fff              
F000:53B2  0bee           or     bp, si                  
F000:53B4  5e             pop    si                      
F000:53B5  e8c919         call   0x6d81                  
F000:53B8  7203           jb     0x53bd                  
F000:53BA  e8fb19         call   0x6db8                   ; "VPSQ3"
F000:53BD  e80100         call   0x53c1                  
F000:53C0  c3             ret                            

;----- sub_53C1 -----
F000:53C1  2e8a04         mov    al, byte ptr cs:[si]    
F000:53C4  46             inc    si                      
F000:53C5  50             push   ax                      
F000:53C6  e86300         call   0x542c                  
F000:53C9  58             pop    ax                      
F000:53CA  3c0a           cmp    al, 0xa                 
F000:53CC  75f3           jne    0x53c1                  
F000:53CE  c3             ret                            

;----- sub_53CF -----
F000:53CF  9c             pushf                          
F000:53D0  fa             cli                            
F000:53D1  0af6           or     dh, dh                  
F000:53D3  7412           je     0x53e7                  
F000:53D5  b370           mov    bl, 0x70                
F000:53D7  b90005         mov    cx, 0x500               
F000:53DA  e85b96         call   0xffffea38              
F000:53DD  b933c2         mov    cx, 0xc233              
F000:53E0  e89d96         call   0xffffea80              
F000:53E3  fece           dec    dh                      
F000:53E5  75ee           jne    0x53d5                  
F000:53E7  b312           mov    bl, 0x12                
F000:53E9  b9b804         mov    cx, 0x4b8               
F000:53EC  e84996         call   0xffffea38              
F000:53EF  80fa01         cmp    dl, 1                   
F000:53F2  7412           je     0x5406                  
F000:53F4  b97881         mov    cx, 0x8178              
F000:53F7  e88696         call   0xffffea80              
F000:53FA  feca           dec    dl                      
F000:53FC  75e9           jne    0x53e7                  
F000:53FE  b97881         mov    cx, 0x8178              
F000:5401  e87c96         call   0xffffea80              
F000:5404  9d             popf                           
F000:5405  c3             ret                            
F000:5406  9d             popf                           
F000:5407  c3             ret                            

;----- sub_542C -----
F000:542C  b40e           mov    ah, 0xe                 
F000:542E  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:5430  cd10           int    0x10                     ; BIOS service
F000:5432  c3             ret                            

;----- sub_551D -----
F000:551D  56             push   si                      
F000:551E  50             push   ax                      
F000:551F  51             push   cx                      
F000:5520  52             push   dx                      
F000:5521  33c9           xor    cx, cx                  
F000:5523  2e8a04         mov    al, byte ptr cs:[si]    
F000:5526  46             inc    si                      
F000:5527  2c30           sub    al, 0x30                
F000:5529  3c09           cmp    al, 9                   
F000:552B  77f6           ja     0x5523                  
F000:552D  50             push   ax                      
F000:552E  41             inc    cx                      
F000:552F  2e8a04         mov    al, byte ptr cs:[si]    
F000:5532  46             inc    si                      
F000:5533  2c30           sub    al, 0x30                
F000:5535  3c09           cmp    al, 9                   
F000:5537  76f4           jbe    0x552d                  
F000:5539  b60a           mov    dh, 0xa                 
F000:553B  5b             pop    bx                      
F000:553C  58             pop    ax                      
F000:553D  f6e6           mul    dh                      
F000:553F  02d8           add    bl, al                  
F000:5541  83e902         sub    cx, 2                   
F000:5544  32ff           xor    bh, bh                  
F000:5546  b201           mov    dl, 1                   
F000:5548  58             pop    ax                      
F000:5549  f6e2           mul    dl                      
F000:554B  02f8           add    bh, al                  
F000:554D  8ac2           mov    al, dl                  
F000:554F  f6e6           mul    dh                      
F000:5551  8ad0           mov    dl, al                  
F000:5553  e2f3           loop   0x5548                  
F000:5555  5a             pop    dx                      
F000:5556  59             pop    cx                      
F000:5557  58             pop    ax                      
F000:5558  5e             pop    si                      
F000:5559  b80121         mov    ax, 0x2101              
F000:555C  cd15           int    0x15                     ; BIOS service
F000:555E  c3             ret                            

;----- sub_55AD -----
F000:55AD  9c             pushf                          
F000:55AE  52             push   dx                      
F000:55AF  ba9001         mov    dx, 0x190               
F000:55B2  ee             out    dx, al                  
F000:55B3  e8c3df         call   0x3579                  
F000:55B6  ee             out    dx, al                  
F000:55B7  e680           out    0x80, al                 ; POST/DMApage
F000:55B9  5a             pop    dx                      
F000:55BA  e8c417         call   0x6d81                  
F000:55BD  7209           jb     0x55c8                  
F000:55BF  50             push   ax                      
F000:55C0  8ae0           mov    ah, al                  
F000:55C2  b0b8           mov    al, 0xb8                
F000:55C4  e8ff93         call   0xffffe9c6              
F000:55C7  58             pop    ax                      
F000:55C8  9d             popf                           
F000:55C9  c3             ret                            

;----- sub_55CA -----
F000:55CA  56             push   si                      
F000:55CB  53             push   bx                      
F000:55CC  83ec06         sub    sp, 6                   
F000:55CF  8bf4           mov    si, sp                  
F000:55D1  16             push   ss                      
F000:55D2  1f             pop    ds                      
F000:55D3  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:55D5  b401           mov    ah, 1                   
F000:55D7  b520           mov    ch, 0x20                
F000:55D9  cd10           int    0x10                     ; BIOS service
F000:55DB  b307           mov    bl, 7                   
F000:55DD  b500           mov    ch, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:55DF  8bf9           mov    di, cx                  
F000:55E1  d1e7           shl    di, 1                   
F000:55E3  268a6600       mov    ah, byte ptr es:[bp]    
F000:55E7  02f4           add    dh, ah                  
F000:55E9  8834           mov    byte ptr [si], dh       
F000:55EB  45             inc    bp                      
F000:55EC  268a4600       mov    al, byte ptr es:[bp]    
F000:55F0  02d0           add    dl, al                  
F000:55F2  885401         mov    byte ptr [si + 1], dl   
F000:55F5  45             inc    bp                      
F000:55F6  268a4600       mov    al, byte ptr es:[bp]    
F000:55FA  02c2           add    al, dl                  
F000:55FC  884403         mov    byte ptr [si + 3], al   
F000:55FF  45             inc    bp                      
F000:5600  268a6600       mov    ah, byte ptr es:[bp]    
F000:5604  02e6           add    ah, dh                  
F000:5606  886402         mov    byte ptr [si + 2], ah   
F000:5609  c6440400       mov    byte ptr [si + 4], 0     ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:560D  c6440500       mov    byte ptr [si + 5], 0     ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:5611  45             inc    bp                      
F000:5612  b90100         mov    cx, 1                   
F000:5615  3a5403         cmp    dl, byte ptr [si + 3]   
F000:5618  7c1a           jl     0x5634                  
F000:561A  8a5401         mov    dl, byte ptr [si + 1]   
F000:561D  fec6           inc    dh                      
F000:561F  3a7402         cmp    dh, byte ptr [si + 2]   
F000:5622  7c03           jl     0x5627                  
F000:5624  e9f600         jmp    0x571d                  
F000:5627  fe4c04         dec    byte ptr [si + 4]       
F000:562A  807c0400       cmp    byte ptr [si + 4], 0     ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:562E  7e04           jle    0x5634                  
F000:5630  8bef           mov    bp, di                  
F000:5632  ebdd           jmp    0x5611                  
F000:5634  268a4600       mov    al, byte ptr es:[bp]    
F000:5638  3c07           cmp    al, 7                   
F000:563A  7212           jb     0x564e                  
F000:563C  b402           mov    ah, 2                   
F000:563E  cd10           int    0x10                     ; BIOS service
F000:5640  b307           mov    bl, 7                   
F000:5642  268a4600       mov    al, byte ptr es:[bp]    
F000:5646  b409           mov    ah, 9                   
F000:5648  cd10           int    0x10                     ; BIOS service
F000:564A  fec2           inc    dl                      
F000:564C  ebc3           jmp    0x5611                  
F000:564E  3c01           cmp    al, 1                   
F000:5650  7413           je     0x5665                  
F000:5652  3c02           cmp    al, 2                   
F000:5654  742f           je     0x5685                  
F000:5656  3c03           cmp    al, 3                   
F000:5658  7433           je     0x568d                  
F000:565A  3c04           cmp    al, 4                   
F000:565C  7447           je     0x56a5                  
F000:565E  3c05           cmp    al, 5                   
F000:5660  7450           je     0x56b2                  
F000:5662  e98f00         jmp    0x56f4                  
F000:5665  45             inc    bp                      
F000:5666  268a4e00       mov    cl, byte ptr es:[bp]    
F000:566A  45             inc    bp                      
F000:566B  268a4600       mov    al, byte ptr es:[bp]    
F000:566F  3c05           cmp    al, 5                   
F000:5671  7212           jb     0x5685                  
F000:5673  b402           mov    ah, 2                   
F000:5675  cd10           int    0x10                     ; BIOS service
F000:5677  268a4600       mov    al, byte ptr es:[bp]    
F000:567B  b409           mov    ah, 9                   
F000:567D  cd10           int    0x10                     ; BIOS service
F000:567F  02d1           add    dl, cl                  
F000:5681  b307           mov    bl, 7                   
F000:5683  eb8c           jmp    0x5611                  
F000:5685  45             inc    bp                      
F000:5686  268a5e00       mov    bl, byte ptr es:[bp]    
F000:568A  45             inc    bp                      
F000:568B  ebe6           jmp    0x5673                  
F000:568D  fec6           inc    dh                      
F000:568F  8a5401         mov    dl, byte ptr [si + 1]   
F000:5692  fe4c04         dec    byte ptr [si + 4]       
F000:5695  807c0400       cmp    byte ptr [si + 4], 0     ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:5699  7c02           jl     0x569d                  
F000:569B  8bef           mov    bp, di                  
F000:569D  3a7402         cmp    dh, byte ptr [si + 2]   
F000:56A0  7d7b           jge    0x571d                  
F000:56A2  e96cff         jmp    0x5611                  
F000:56A5  45             inc    bp                      
F000:56A6  268a4600       mov    al, byte ptr es:[bp]    
F000:56AA  884404         mov    byte ptr [si + 4], al   
F000:56AD  8bfd           mov    di, bp                  
F000:56AF  e95fff         jmp    0x5611                  
F000:56B2  45             inc    bp                      
F000:56B3  268a4600       mov    al, byte ptr es:[bp]    
F000:56B7  884405         mov    byte ptr [si + 5], al   
F000:56BA  45             inc    bp                      
F000:56BB  268a4e00       mov    cl, byte ptr es:[bp]    
F000:56BF  45             inc    bp                      
F000:56C0  8bfd           mov    di, bp                  
F000:56C2  51             push   cx                      
F000:56C3  268a4600       mov    al, byte ptr es:[bp]    
F000:56C7  3c02           cmp    al, 2                   
F000:56C9  7706           ja     0x56d1                  
F000:56CB  45             inc    bp                      
F000:56CC  268a5e00       mov    bl, byte ptr es:[bp]    
F000:56D0  45             inc    bp                      
F000:56D1  b402           mov    ah, 2                   
F000:56D3  cd10           int    0x10                     ; BIOS service
F000:56D5  51             push   cx                      
F000:56D6  b90100         mov    cx, 1                   
F000:56D9  b80013         mov    ax, 0x1300              
F000:56DC  cd10           int    0x10                     ; BIOS service
F000:56DE  59             pop    cx                      
F000:56DF  fec2           inc    dl                      
F000:56E1  b307           mov    bl, 7                   
F000:56E3  45             inc    bp                      
F000:56E4  e2dd           loop   0x56c3                  
F000:56E6  59             pop    cx                      
F000:56E7  fe4c05         dec    byte ptr [si + 5]       
F000:56EA  7404           je     0x56f0                  
F000:56EC  8bef           mov    bp, di                  
F000:56EE  ebd2           jmp    0x56c2                  
F000:56F0  4d             dec    bp                      
F000:56F1  e91dff         jmp    0x5611                  
F000:56F4  45             inc    bp                      
F000:56F5  268a4600       mov    al, byte ptr es:[bp]    
F000:56F9  884405         mov    byte ptr [si + 5], al   
F000:56FC  45             inc    bp                      
F000:56FD  268a4e00       mov    cl, byte ptr es:[bp]    
F000:5701  45             inc    bp                      
F000:5702  268a5e00       mov    bl, byte ptr es:[bp]    
F000:5706  45             inc    bp                      
F000:5707  8bfd           mov    di, bp                  
F000:5709  8bef           mov    bp, di                  
F000:570B  b80013         mov    ax, 0x1300              
F000:570E  cd10           int    0x10                     ; BIOS service
F000:5710  02d1           add    dl, cl                  
F000:5712  fe4c05         dec    byte ptr [si + 5]       
F000:5715  75f2           jne    0x5709                  
F000:5717  03e9           add    bp, cx                  
F000:5719  4d             dec    bp                      
F000:571A  e9f4fe         jmp    0x5611                  
F000:571D  83c406         add    sp, 6                   
F000:5720  5b             pop    bx                      
F000:5721  5e             pop    si                      
F000:5722  c3             ret                            

;----- sub_5723 -----
F000:5723  80fb90         cmp    bl, 0x90                
F000:5726  7405           je     0x572d                  
F000:5728  80fb10         cmp    bl, 0x10                
F000:572B  7512           jne    0x573f                  
F000:572D  2bd2           sub    dx, dx                  
F000:572F  8ac3           mov    al, bl                  
F000:5731  e85c92         call   0xffffe990              
F000:5734  2ae4           sub    ah, ah                  
F000:5736  03d0           add    dx, ax                  
F000:5738  fec3           inc    bl                      
F000:573A  3adf           cmp    bl, bh                  
F000:573C  75f1           jne    0x572f                  
F000:573E  c3             ret                            
F000:573F  baffff         mov    dx, 0xffff              
F000:5742  32e4           xor    ah, ah                  
F000:5744  b104           mov    cl, 4                   
F000:5746  8ac3           mov    al, bl                  
F000:5748  e84592         call   0xffffe990              
F000:574B  e80700         call   0x5755                  
F000:574E  fec3           inc    bl                      
F000:5750  3adf           cmp    bl, bh                  
F000:5752  75f2           jne    0x5746                  
F000:5754  c3             ret                            

;----- sub_5755 -----
F000:5755  32f0           xor    dh, al                  
F000:5757  8ac6           mov    al, dh                  
F000:5759  c1c004         rol    ax, 4                   
F000:575C  33d0           xor    dx, ax                  
F000:575E  d1c0           rol    ax, 1                   
F000:5760  86f2           xchg   dl, dh                  
F000:5762  33d0           xor    dx, ax                  
F000:5764  c1c804         ror    ax, 4                   
F000:5767  24e0           and    al, 0xe0                
F000:5769  33d0           xor    dx, ax                  
F000:576B  d1c8           ror    ax, 1                   
F000:576D  32f0           xor    dh, al                  
F000:576F  c3             ret                            

;----- sub_5D7C -----
F000:5D7C  52             push   dx                      
F000:5D7D  e81100         call   0x5d91                  
F000:5D80  eb06           jmp    0x5d88                  
F000:5D88  b02f           mov    al, 0x2f                
F000:5D8A  8ae2           mov    ah, dl                  
F000:5D8C  e8378c         call   0xffffe9c6              
F000:5D8F  5a             pop    dx                      
F000:5D90  c3             ret                            

;----- sub_5D91 -----
F000:5D91  b310           mov    bl, 0x10                
F000:5D93  b72e           mov    bh, 0x2e                
F000:5D95  e88bf9         call   0x5723                  
F000:5D98  b02e           mov    al, 0x2e                
F000:5D9A  8ae6           mov    ah, dh                  
F000:5D9C  e8278c         call   0xffffe9c6              
F000:5D9F  c3             ret                            

;----- sub_654C -----
F000:654C  e82900         call   0x6578                  
F000:654F  b060           mov    al, 0x60                
F000:6551  e664           out    0x64, al                 ; KBC cmd/sts
F000:6553  e82200         call   0x6578                  
F000:6556  b0a7           mov    al, 0xa7                
F000:6558  e660           out    0x60, al                 ; KBC data
F000:655A  e81b00         call   0x6578                  
F000:655D  b060           mov    al, 0x60                
F000:655F  e664           out    0x64, al                 ; KBC cmd/sts
F000:6561  e81400         call   0x6578                  
F000:6564  b0ad           mov    al, 0xad                
F000:6566  e660           out    0x60, al                 ; KBC data
F000:6568  c3             ret                            

;----- sub_6569 -----
F000:6569  e80c00         call   0x6578                  
F000:656C  b060           mov    al, 0x60                
F000:656E  e664           out    0x64, al                 ; KBC cmd/sts
F000:6570  e80500         call   0x6578                  
F000:6573  b065           mov    al, 0x65                
F000:6575  e660           out    0x60, al                 ; KBC data
F000:6577  c3             ret                            

;----- sub_6578 -----
F000:6578  e464           in     al, 0x64                 ; KBC cmd/sts
F000:657A  a802           test   al, 2                   
F000:657C  75fa           jne    0x6578                  
F000:657E  c3             ret                            

;----- sub_6662 -----
F000:6662  1e             push   ds                      
F000:6663  e89983         call   0xffffe9ff              
F000:6666  c6066b0000     mov    byte ptr [0x6b], 0       ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:666B  be1e00         mov    si, 0x1e                
F000:666E  89361a00       mov    word ptr [0x1a], si     
F000:6672  89361c00       mov    word ptr [0x1c], si     
F000:6676  89368000       mov    word ptr [0x80], si     
F000:667A  83c620         add    si, 0x20                
F000:667D  89368200       mov    word ptr [0x82], si     
F000:6681  1f             pop    ds                      
F000:6682  c3             ret                            

;----- sub_6881 -----
F000:6881  2ac0           sub    al, al                  
F000:6883  e6f1           out    0xf1, al                 ; chipset/MCU
F000:6885  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:6887  c3             ret                            

;----- sub_6888 -----
F000:6888  b011           mov    al, 0x11                
F000:688A  e620           out    0x20, al                 ; PIC1
F000:688C  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:688E  b008           mov    al, 8                   
F000:6890  e621           out    0x21, al                 ; PIC1mask
F000:6892  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:6894  b004           mov    al, 4                   
F000:6896  e621           out    0x21, al                 ; PIC1mask
F000:6898  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:689A  b001           mov    al, 1                   
F000:689C  e621           out    0x21, al                 ; PIC1mask
F000:689E  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:68A0  b0ff           mov    al, 0xff                
F000:68A2  e621           out    0x21, al                 ; PIC1mask
F000:68A4  b011           mov    al, 0x11                
F000:68A6  e6a0           out    0xa0, al                 ; PIC2
F000:68A8  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:68AA  b070           mov    al, 0x70                
F000:68AC  e6a1           out    0xa1, al                 ; PIC2mask
F000:68AE  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:68B0  b002           mov    al, 2                   
F000:68B2  e6a1           out    0xa1, al                 ; PIC2mask
F000:68B4  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:68B6  b001           mov    al, 1                   
F000:68B8  e6a1           out    0xa1, al                 ; PIC2mask
F000:68BA  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:68BC  b0ff           mov    al, 0xff                
F000:68BE  e6a1           out    0xa1, al                 ; PIC2mask
F000:68C0  c3             ret                            

;----- sub_6A76 -----
F000:6A76  1e             push   ds                      
F000:6A77  56             push   si                      
F000:6A78  51             push   cx                      
F000:6A79  0e             push   cs                      
F000:6A7A  1f             pop    ds                      
F000:6A7B  bef469         mov    si, 0x69f4              
F000:6A7E  b90200         mov    cx, 2                   
F000:6A81  e85200         call   0x6ad6                  
F000:6A84  beec69         mov    si, 0x69ec              
F000:6A87  b90400         mov    cx, 4                   
F000:6A8A  e84900         call   0x6ad6                  
F000:6A8D  bef869         mov    si, 0x69f8              
F000:6A90  b90900         mov    cx, 9                   
F000:6A93  e84000         call   0x6ad6                  
F000:6A96  be0a6a         mov    si, 0x6a0a              
F000:6A99  b91e00         mov    cx, 0x1e                
F000:6A9C  e83700         call   0x6ad6                  
F000:6A9F  59             pop    cx                      
F000:6AA0  5e             pop    si                      
F000:6AA1  1f             pop    ds                      
F000:6AA2  c3             ret                            

;----- sub_6AD6 -----
F000:6AD6  50             push   ax                      
F000:6AD7  53             push   bx                      
F000:6AD8  57             push   di                      
F000:6AD9  fc             cld                            
F000:6ADA  8ad8           mov    bl, al                  
F000:6ADC  8ac4           mov    al, ah                  
F000:6ADE  2ae4           sub    ah, ah                  
F000:6AE0  8bf8           mov    di, ax                  
F000:6AE2  51             push   cx                      
F000:6AE3  56             push   si                      
F000:6AE4  ad             lodsw  ax, word ptr [si]       
F000:6AE5  03c7           add    ax, di                  
F000:6AE7  86e0           xchg   al, ah                  
F000:6AE9  e8c709         call   0x74b3                  
F000:6AEC  e2f6           loop   0x6ae4                  
F000:6AEE  fecb           dec    bl                      
F000:6AF0  7407           je     0x6af9                   ; "^Y_[X"
F000:6AF2  5e             pop    si                      
F000:6AF3  59             pop    cx                      
F000:6AF4  83c740         add    di, 0x40                
F000:6AF7  ebe9           jmp    0x6ae2                  
F000:6AF9  5e             pop    si                      
F000:6AFA  59             pop    cx                      
F000:6AFB  5f             pop    di                      
F000:6AFC  5b             pop    bx                      
F000:6AFD  58             pop    ax                      
F000:6AFE  c3             ret                            

;----- sub_6D52 -----
F000:6D52  9c             pushf                          
F000:6D53  50             push   ax                      
F000:6D54  53             push   bx                      
F000:6D55  b08e           mov    al, 0x8e                
F000:6D57  e8367c         call   0xe990                  
F000:6D5A  a8c2           test   al, 0xc2                
F000:6D5C  751f           jne    0x6d7d                  
F000:6D5E  b093           mov    al, 0x93                
F000:6D60  e82d7c         call   0xe990                  
F000:6D63  24bf           and    al, 0xbf                
F000:6D65  8ae0           mov    ah, al                  
F000:6D67  b093           mov    al, 0x93                
F000:6D69  e85a7c         call   0xe9c6                  
F000:6D6C  b096           mov    al, 0x96                
F000:6D6E  e81f7c         call   0xe990                  
F000:6D71  243f           and    al, 0x3f                
F000:6D73  8ae0           mov    ah, al                  
F000:6D75  b096           mov    al, 0x96                
F000:6D77  e84c7c         call   0xe9c6                  
F000:6D7A  e8ffef         call   0x5d7c                  
F000:6D7D  5b             pop    bx                      
F000:6D7E  58             pop    ax                      
F000:6D7F  9d             popf                           
F000:6D80  c3             ret                            

;----- sub_6D81 -----
F000:6D81  50             push   ax                      
F000:6D82  b08e           mov    al, 0x8e                
F000:6D84  e8097c         call   0xe990                  
F000:6D87  a8c2           test   al, 0xc2                
F000:6D89  752a           jne    0x6db5                  
F000:6D8B  e87601         call   0x6f04                  
F000:6D8E  7525           jne    0x6db5                  
F000:6D90  b093           mov    al, 0x93                
F000:6D92  e8fb7b         call   0xe990                  
F000:6D95  a840           test   al, 0x40                
F000:6D97  741c           je     0x6db5                  
F000:6D99  a820           test   al, 0x20                
F000:6D9B  7415           je     0x6db2                  
F000:6D9D  b094           mov    al, 0x94                
F000:6D9F  e8ee7b         call   0xe990                  
F000:6DA2  a801           test   al, 1                   
F000:6DA4  750c           jne    0x6db2                  
F000:6DA6  b0bf           mov    al, 0xbf                
F000:6DA8  e8e57b         call   0xe990                  
F000:6DAB  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:6DAD  7503           jne    0x6db2                  
F000:6DAF  58             pop    ax                      
F000:6DB0  f8             clc                            
F000:6DB1  c3             ret                            
F000:6DB2  e89dff         call   0x6d52                  
F000:6DB5  58             pop    ax                      
F000:6DB6  f9             stc                            
F000:6DB7  c3             ret                            

;----- sub_6DB8 -----
F000:6DB8  56             push   si                      
F000:6DB9  50             push   ax                      
F000:6DBA  53             push   bx                      
F000:6DBB  51             push   cx                      
F000:6DBC  33db           xor    bx, bx                  
F000:6DBE  33c9           xor    cx, cx                  
F000:6DC0  b10a           mov    cl, 0xa                 
F000:6DC2  2e8a04         mov    al, byte ptr cs:[si]    
F000:6DC5  46             inc    si                      
F000:6DC6  3c0d           cmp    al, 0xd                 
F000:6DC8  7424           je     0x6dee                   ; "Y[X^"
F000:6DCA  2c30           sub    al, 0x30                
F000:6DCC  3c09           cmp    al, 9                   
F000:6DCE  7604           jbe    0x6dd4                  
F000:6DD0  e2f0           loop   0x6dc2                  
F000:6DD2  eb1a           jmp    0x6dee                   ; "Y[X^"
F000:6DD4  b104           mov    cl, 4                   
F000:6DD6  d3e3           shl    bx, cl                  
F000:6DD8  240f           and    al, 0xf                 
F000:6DDA  0ad8           or     bl, al                  
F000:6DDC  50             push   ax                      
F000:6DDD  8ae3           mov    ah, bl                  
F000:6DDF  b0ba           mov    al, 0xba                
F000:6DE1  e8e27b         call   0xe9c6                  
F000:6DE4  8ae7           mov    ah, bh                  
F000:6DE6  b0bb           mov    al, 0xbb                
F000:6DE8  e8db7b         call   0xe9c6                  
F000:6DEB  58             pop    ax                      
F000:6DEC  ebd4           jmp    0x6dc2                  
F000:6DEE  59             pop    cx                      
F000:6DEF  5b             pop    bx                      
F000:6DF0  58             pop    ax                      
F000:6DF1  5e             pop    si                      
F000:6DF2  fa             cli                            
F000:6DF3  f4             hlt                            

;----- sub_6F04 -----
F000:6F04  b08e           mov    al, 0x8e                
F000:6F06  e8877a         call   0xe990                  
F000:6F09  a8c2           test   al, 0xc2                
F000:6F0B  7509           jne    0x6f16                  
F000:6F0D  b096           mov    al, 0x96                
F000:6F0F  e87e7a         call   0xe990                  
F000:6F12  24c0           and    al, 0xc0                
F000:6F14  3cc0           cmp    al, 0xc0                
F000:6F16  c3             ret                            

;----- sub_7174 -----
F000:7174  50             push   ax                      
F000:7175  51             push   cx                      
F000:7176  06             push   es                      
F000:7177  57             push   di                      
F000:7178  1e             push   ds                      
F000:7179  07             pop    es                      
F000:717A  b96800         mov    cx, 0x68                
F000:717D  33ff           xor    di, di                  
F000:717F  83e902         sub    cx, 2                   
F000:7182  83c704         add    di, 4                   
F000:7185  33c0           xor    ax, ax                  
F000:7187  f3ab           rep stosw word ptr es:[di], ax    
F000:7189  89162300       mov    word ptr [0x23], dx     
F000:718D  c7062500ffff   mov    word ptr [0x25], 0xffff 
F000:7193  5f             pop    di                      
F000:7194  07             pop    es                      
F000:7195  59             pop    cx                      
F000:7196  58             pop    ax                      
F000:7197  c3             ret                            

;----- sub_7198 -----
F000:7198  51             push   cx                      
F000:7199  33c9           xor    cx, cx                  
F000:719B  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:719D  e80003         call   0x74a0                  
F000:71A0  e8ed02         call   0x7490                  
F000:71A3  d0d8           rcr    al, 1                   
F000:71A5  0aed           or     ch, ch                  
F000:71A7  d0d0           rcl    al, 1                   
F000:71A9  7208           jb     0x71b3                  
F000:71AB  750a           jne    0x71b7                  
F000:71AD  8ae9           mov    ch, cl                  
F000:71AF  fec5           inc    ch                      
F000:71B1  eb04           jmp    0x71b7                  
F000:71B3  0f850a00       jne    0x71c1                  
F000:71B7  80c440         add    ah, 0x40                
F000:71BA  fec1           inc    cl                      
F000:71BC  80f904         cmp    cl, 4                   
F000:71BF  72dc           jb     0x719d                  
F000:71C1  2bc0           sub    ax, ax                  
F000:71C3  0aed           or     ch, ch                  
F000:71C5  f9             stc                            
F000:71C6  0f840900       je     0x71d3                  
F000:71CA  fecd           dec    ch                      
F000:71CC  2acd           sub    cl, ch                  
F000:71CE  c0e506         shl    ch, 6                   
F000:71D1  8bc1           mov    ax, cx                  
F000:71D3  59             pop    cx                      
F000:71D4  c3             ret                            

;----- sub_7419 -----
F000:7419  06             push   es                      
F000:741A  1e             push   ds                      
F000:741B  50             push   ax                      
F000:741C  52             push   dx                      
F000:741D  e8a829         call   0x9dc8                  
F000:7420  7260           jb     0x7482                  
F000:7422  06             push   es                      
F000:7423  1f             pop    ds                      
F000:7424  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7426  7437           je     0x745f                  
F000:7428  3c01           cmp    al, 1                   
F000:742A  7510           jne    0x743c                  
F000:742C  803e270004     cmp    byte ptr [0x27], 4      
F000:7431  743b           je     0x746e                  
F000:7433  803e270010     cmp    byte ptr [0x27], 0x10   
F000:7438  7434           je     0x746e                  
F000:743A  eb46           jmp    0x7482                  
F000:743C  803e990080     cmp    byte ptr [0x99], 0x80   
F000:7441  0f830a00       jae    0x744f                  
F000:7445  e8c06a         call   0xdf08                  
F000:7448  0f831300       jae    0x745f                  
F000:744C  eb34           jmp    0x7482                  
F000:744F  52             push   dx                      
F000:7450  50             push   ax                      
F000:7451  8b162300       mov    dx, word ptr [0x23]     
F000:7455  a12500         mov    ax, word ptr [0x25]     
F000:7458  e8866a         call   0xdee1                   ; "`@t!*"
F000:745B  58             pop    ax                      
F000:745C  5a             pop    dx                      
F000:745D  eb23           jmp    0x7482                  
F000:745F  e851d0         call   0x44b3                  
F000:7462  721e           jb     0x7482                  
F000:7464  803e990080     cmp    byte ptr [0x99], 0x80   
F000:7469  7203           jb     0x746e                  
F000:746B  e86b20         call   0x94d9                  
F000:746E  8b162300       mov    dx, word ptr [0x23]     
F000:7472  e823fd         call   0x7198                  
F000:7475  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7477  7403           je     0x747c                  
F000:7479  e8faf5         call   0x6a76                  
F000:747C  bae003         mov    dx, 0x3e0               
F000:747F  e8f2fc         call   0x7174                  
F000:7482  5a             pop    dx                      
F000:7483  58             pop    ax                      
F000:7484  1f             pop    ds                      
F000:7485  07             pop    es                      
F000:7486  c3             ret                            

;----- sub_7490 -----
F000:7490  3c83           cmp    al, 0x83                
F000:7492  0f840600       je     0x749c                  
F000:7496  3c84           cmp    al, 0x84                
F000:7498  0f850200       jne    0x749e                  
F000:749C  f8             clc                            
F000:749D  c3             ret                            
F000:749E  f9             stc                            
F000:749F  c3             ret                            

;----- sub_74A0 -----
F000:74A0  8ac4           mov    al, ah                  
F000:74A2  ee             out    dx, al                  
F000:74A3  eb00           jmp    0x74a5                  
F000:74A5  eb00           jmp    0x74a7                  
F000:74A7  eb00           jmp    0x74a9                  
F000:74A9  42             inc    dx                      
F000:74AA  ec             in     al, dx                  
F000:74AB  eb00           jmp    0x74ad                  
F000:74AD  eb00           jmp    0x74af                  
F000:74AF  eb00           jmp    0x74b1                  
F000:74B1  4a             dec    dx                      
F000:74B2  c3             ret                            

;----- sub_74B3 -----
F000:74B3  86e0           xchg   al, ah                  
F000:74B5  ee             out    dx, al                  
F000:74B6  eb00           jmp    0x74b8                  
F000:74B8  eb00           jmp    0x74ba                  
F000:74BA  eb00           jmp    0x74bc                  
F000:74BC  42             inc    dx                      
F000:74BD  86e0           xchg   al, ah                  
F000:74BF  ee             out    dx, al                  
F000:74C0  eb00           jmp    0x74c2                  
F000:74C2  eb00           jmp    0x74c4                  
F000:74C4  eb00           jmp    0x74c6                  
F000:74C6  4a             dec    dx                      
F000:74C7  c3             ret                            
F000:7DE4  b06f           mov    al, 0x6f                
F000:7DE6  e8c4d7         call   0x55ad                  
F000:7DE9  e8f602         call   0x80e2                  
F000:7DEC  e8226c         call   0xea11                  
F000:7DEF  26a0be00       mov    al, byte ptr es:[0xbe]  
F000:7DF3  50             push   ax                      
F000:7DF4  83ec0b         sub    sp, 0xb                 
F000:7DF7  8bec           mov    bp, sp                  
F000:7DF9  b90b00         mov    cx, 0xb                 
F000:7DFC  33f6           xor    si, si                  
F000:7DFE  c60200         mov    byte ptr [bp + si], 0    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7E01  46             inc    si                      
F000:7E02  e2fa           loop   0x7dfe                  
F000:7E04  e80e03         call   0x8115                  
F000:7E07  80ff01         cmp    bh, 1                   
F000:7E0A  0f845b01       je     0x7f69                  
F000:7E0E  0aff           or     bh, bh                  
F000:7E10  0f85ec00       jne    0x7f00                  
F000:7E14  e81a03         call   0x8131                  
F000:7E17  80ff01         cmp    bh, 1                   
F000:7E1A  0f844b01       je     0x7f69                  
F000:7E1E  0aff           or     bh, bh                  
F000:7E20  0f85dc00       jne    0x7f00                  
F000:7E24  e8d86b         call   0xe9ff                  
F000:7E27  16             push   ss                      
F000:7E28  07             pop    es                      
F000:7E29  8bfd           mov    di, bp                  
F000:7E2B  e8400a         call   0x886e                  
F000:7E2E  26c745087f7f   mov    word ptr es:[di + 8], 0x7f7f
F000:7E34  26803d7f       cmp    byte ptr es:[di], 0x7f  
F000:7E38  7517           jne    0x7e51                  
F000:7E3A  26c7050080     mov    word ptr es:[di], 0x8000
F000:7E3F  26c745028000   mov    word ptr es:[di + 2], 0x80
F000:7E45  26c745047e00   mov    word ptr es:[di + 4], 0x7e
F000:7E4B  26c745067f7f   mov    word ptr es:[di + 6], 0x7f7f
F000:7E51  33ff           xor    di, di                  
F000:7E53  8b13           mov    dx, word ptr [bp + di]  
F000:7E55  83c702         add    di, 2                   
F000:7E58  80fa7f         cmp    dl, 0x7f                
F000:7E5B  0f85b500       jne    0x7f14                  
F000:7E5F  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:7E61  a810           test   al, 0x10                
F000:7E63  7560           jne    0x7ec5                  
F000:7E65  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:7E67  a840           test   al, 0x40                
F000:7E69  755a           jne    0x7ec5                  
F000:7E6B  e8ee12         call   0x915c                  
F000:7E6E  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:7E70  0c40           or     al, 0x40                
F000:7E72  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:7E74  8cc8           mov    ax, cs                  
F000:7E76  8ed8           mov    ds, ax                  
F000:7E78  8ec0           mov    es, ax                  
F000:7E7A  1e             push   ds                      
F000:7E7B  e8816b         call   0xe9ff                  
F000:7E7E  8a1e9000       mov    bl, byte ptr [0x90]     
F000:7E82  80fb00         cmp    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7E85  1f             pop    ds                      
F000:7E86  743d           je     0x7ec5                  
F000:7E88  ba0814         mov    dx, 0x1408              
F000:7E8B  bdebe4         mov    bp, 0xe4eb              
F000:7E8E  e839d7         call   0x55ca                  
F000:7E91  ba1400         mov    dx, 0x14                
F000:7E94  bdabe5         mov    bp, 0xe5ab              
F000:7E97  e830d7         call   0x55ca                  
F000:7E9A  ba1a09         mov    dx, 0x91a               
F000:7E9D  bd14e6         mov    bp, 0xe614              
F000:7EA0  e827d7         call   0x55ca                  
F000:7EA3  b708           mov    bh, 8                   
F000:7EA5  e8ca05         call   0x8472                  
F000:7EA8  7315           jae    0x7ebf                  
F000:7EAA  b707           mov    bh, 7                   
F000:7EAC  e8c305         call   0x8472                  
F000:7EAF  730e           jae    0x7ebf                  
F000:7EB1  b705           mov    bh, 5                   
F000:7EB3  e8bc05         call   0x8472                  
F000:7EB6  7307           jae    0x7ebf                  
F000:7EB8  b703           mov    bh, 3                   
F000:7EBA  e8b505         call   0x8472                  
F000:7EBD  72e4           jb     0x7ea3                  
F000:7EBF  e89a12         call   0x915c                  
F000:7EC2  e91fff         jmp    0x7de4                  
F000:7EC5  b072           mov    al, 0x72                
F000:7EC7  e8e3d6         call   0x55ad                  
F000:7ECA  83fa7e         cmp    dx, 0x7e                
F000:7ECD  7538           jne    0x7f07                  
F000:7ECF  e8aa04         call   0x837c                  
F000:7ED2  0f847dff       je     0x7e53                  
F000:7ED6  b07b           mov    al, 0x7b                
F000:7ED8  e8b56a         call   0xe990                  
F000:7EDB  32e4           xor    ah, ah                  
F000:7EDD  a880           test   al, 0x80                
F000:7EDF  7402           je     0x7ee3                  
F000:7EE1  fec4           inc    ah                      
F000:7EE3  50             push   ax                      
F000:7EE4  52             push   dx                      
F000:7EE5  e8080a         call   0x88f0                  
F000:7EE8  5a             pop    dx                      
F000:7EE9  3c02           cmp    al, 2                   
F000:7EEB  58             pop    ax                      
F000:7EEC  7512           jne    0x7f00                  
F000:7EEE  1e             push   ds                      
F000:7EEF  e83c6b         call   0xea2e                  
F000:7EF2  1f             pop    ds                      
F000:7EF3  740b           je     0x7f00                  
F000:7EF5  c6460a01       mov    byte ptr [bp + 0xa], 1  
F000:7EF9  80fc00         cmp    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7EFC  0f8414ff       je     0x7e14                  
F000:7F00  b073           mov    al, 0x73                
F000:7F02  e8a8d6         call   0x55ad                  
F000:7F05  cd18           int    0x18                     ; BIOS service
F000:7F07  becde4         mov    si, 0xe4cd               ; "I9990305"
F000:7F0A  1e             push   ds                      
F000:7F0B  0e             push   cs                      
F000:7F0C  1f             pop    ds                      
F000:7F0D  e8b1d4         call   0x53c1                  
F000:7F10  1f             pop    ds                      
F000:7F11  fb             sti                            
F000:7F12  ebfe           jmp    0x7f12                  
F000:7F14  57             push   di                      
F000:7F15  e8b704         call   0x83cf                  
F000:7F18  5f             pop    di                      
F000:7F19  7306           jae    0x7f21                  
F000:7F1B  e83e12         call   0x915c                  
F000:7F1E  e9c3fe         jmp    0x7de4                  
F000:7F21  83fa7e         cmp    dx, 0x7e                
F000:7F24  749f           je     0x7ec5                  
F000:7F26  83fa7d         cmp    dx, 0x7d                
F000:7F29  7507           jne    0x7f32                  
F000:7F2B  e8ee15         call   0x951c                  
F000:7F2E  0f8221ff       jb     0x7e53                  
F000:7F32  1e             push   ds                      
F000:7F33  06             push   es                      
F000:7F34  e89802         call   0x81cf                  
F000:7F37  07             pop    es                      
F000:7F38  1f             pop    ds                      
F000:7F39  732e           jae    0x7f69                  
F000:7F3B  3c05           cmp    al, 5                   
F000:7F3D  7327           jae    0x7f66                  
F000:7F3F  50             push   ax                      
F000:7F40  b00a           mov    al, 0xa                 
F000:7F42  e8e7d4         call   0x542c                  
F000:7F45  58             pop    ax                      
F000:7F46  2ae4           sub    ah, ah                  
F000:7F48  d1e0           shl    ax, 1                   
F000:7F4A  8bf0           mov    si, ax                  
F000:7F4C  2e8bb4da7d     mov    si, word ptr cs:[si + 0x7dda]
F000:7F51  55             push   bp                      
F000:7F52  1e             push   ds                      
F000:7F53  0e             push   cs                      
F000:7F54  1f             pop    ds                      
F000:7F55  e869d4         call   0x53c1                  
F000:7F58  b90300         mov    cx, 3                   
F000:7F5B  51             push   cx                      
F000:7F5C  33c9           xor    cx, cx                  
F000:7F5E  e81f6b         call   0xea80                  
F000:7F61  59             pop    cx                      
F000:7F62  e2f7           loop   0x7f5b                  
F000:7F64  1f             pop    ds                      
F000:7F65  5d             pop    bp                      
F000:7F66  e9eafe         jmp    0x7e53                  
F000:7F69  e84d60         call   0xdfb9                  
F000:7F6C  8ed8           mov    ds, ax                  
F000:7F6E  8ec0           mov    es, ax                  
F000:7F70  f6c680         test   dh, 0x80                
F000:7F73  7406           je     0x7f7b                  
F000:7F75  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:7F77  0c80           or     al, 0x80                
F000:7F79  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:7F7B  e8816a         call   0xe9ff                  
F000:7F7E  b00e           mov    al, 0xe                 
F000:7F80  e80d6a         call   0xe990                  
F000:7F83  a8e2           test   al, 0xe2                
F000:7F85  0f840c00       je     0x7f95                  
F000:7F89  e8a56a         call   0xea31                  
F000:7F8C  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7F8E  0f84dd00       je     0x806f                  
F000:7F92  e9fa00         jmp    0x808f                  
F000:7F95  80fa80         cmp    dl, 0x80                
F000:7F98  735e           jae    0x7ff8                  
F000:7F9A  f6c620         test   dh, 0x20                
F000:7F9D  7575           jne    0x8014                  
F000:7F9F  e82b4b         call   0xcacd                  
F000:7FA2  32d2           xor    dl, dl                  
F000:7FA4  1e             push   ds                      
F000:7FA5  680000         push   0                        ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7FA8  1f             pop    ds                      
F000:7FA9  803e0a7c79     cmp    byte ptr [0x7c0a], 0x79 
F000:7FAE  1f             pop    ds                      
F000:7FAF  7505           jne    0x7fb6                  
F000:7FB1  b401           mov    ah, 1                   
F000:7FB3  e9b900         jmp    0x806f                  
F000:7FB6  33f6           xor    si, si                  
F000:7FB8  b90500         mov    cx, 5                   
F000:7FBB  8a02           mov    al, byte ptr [bp + si]  
F000:7FBD  3c80           cmp    al, 0x80                
F000:7FBF  7317           jae    0x7fd8                  
F000:7FC1  3c7d           cmp    al, 0x7d                
F000:7FC3  7509           jne    0x7fce                  
F000:7FC5  52             push   dx                      
F000:7FC6  e85315         call   0x951c                  
F000:7FC9  8ac2           mov    al, dl                  
F000:7FCB  5a             pop    dx                      
F000:7FCC  730a           jae    0x7fd8                  
F000:7FCE  83c602         add    si, 2                   
F000:7FD1  e2e8           loop   0x7fbb                  
F000:7FD3  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:7FD5  e99700         jmp    0x806f                  
F000:7FD8  06             push   es                      
F000:7FD9  e8356a         call   0xea11                  
F000:7FDC  1e             push   ds                      
F000:7FDD  e81f6a         call   0xe9ff                  
F000:7FE0  8a267500       mov    ah, byte ptr [0x75]     
F000:7FE4  1f             pop    ds                      
F000:7FE5  8ad8           mov    bl, al                  
F000:7FE7  80eb80         sub    bl, 0x80                
F000:7FEA  3ae3           cmp    ah, bl                  
F000:7FEC  7703           ja     0x7ff1                  
F000:7FEE  07             pop    es                      
F000:7FEF  ebdd           jmp    0x7fce                  
F000:7FF1  26a2ec00       mov    byte ptr es:[0xec], al  
F000:7FF5  07             pop    es                      
F000:7FF6  eb44           jmp    0x803c                  
F000:7FF8  06             push   es                      
F000:7FF9  e8156a         call   0xea11                  
F000:7FFC  b053           mov    al, 0x53                
F000:7FFE  26ff06be00     inc    word ptr es:[0xbe]      
F000:8003  07             pop    es                      
F000:8004  0f848700       je     0x808f                  
F000:8008  06             push   es                      
F000:8009  e8056a         call   0xea11                  
F000:800C  268816ec00     mov    byte ptr es:[0xec], dl  
F000:8011  07             pop    es                      
F000:8012  b280           mov    dl, 0x80                
F000:8014  33f6           xor    si, si                  
F000:8016  b90500         mov    cx, 5                   
F000:8019  8b02           mov    ax, word ptr [bp + si]  
F000:801B  3d7f7f         cmp    ax, 0x7f7f              
F000:801E  740e           je     0x802e                  
F000:8020  f6c420         test   ah, 0x20                
F000:8023  7504           jne    0x8029                  
F000:8025  3c7d           cmp    al, 0x7d                
F000:8027  720c           jb     0x8035                  
F000:8029  83c602         add    si, 2                   
F000:802C  e2eb           loop   0x8019                  
F000:802E  f6c620         test   dh, 0x20                
F000:8031  7583           jne    0x7fb6                  
F000:8033  eb07           jmp    0x803c                  
F000:8035  52             push   dx                      
F000:8036  8ad0           mov    dl, al                  
F000:8038  e8924a         call   0xcacd                  
F000:803B  5a             pop    dx                      
F000:803C  1e             push   ds                      
F000:803D  06             push   es                      
F000:803E  e8d069         call   0xea11                  
F000:8041  b080           mov    al, 0x80                
F000:8043  263a06ec00     cmp    al, byte ptr es:[0xec]  
F000:8048  7421           je     0x806b                  
F000:804A  680000         push   0                        ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:804D  1f             pop    ds                      
F000:804E  668b1e4c00     mov    ebx, dword ptr [0x4c]   
F000:8053  8cc8           mov    ax, cs                  
F000:8055  66c1e010       shl    eax, 0x10               
F000:8059  b8feba         mov    ax, 0xbafe              
F000:805C  663bc3         cmp    eax, ebx                
F000:805F  740a           je     0x806b                  
F000:8061  2666891ee800   mov    dword ptr es:[0xe8], ebx
F000:8067  66a34c00       mov    dword ptr [0x4c], eax   
F000:806B  07             pop    es                      
F000:806C  1f             pop    ds                      
F000:806D  32e4           xor    ah, ah                  
F000:806F  52             push   dx                      
F000:8070  e87d08         call   0x88f0                  
F000:8073  5a             pop    dx                      
F000:8074  3c02           cmp    al, 2                   
F000:8076  7517           jne    0x808f                  
F000:8078  e8b369         call   0xea2e                  
F000:807B  7412           je     0x808f                  
F000:807D  e8eb02         call   0x836b                  
F000:8080  720d           jb     0x808f                  
F000:8082  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:8084  2480           and    al, 0x80                
F000:8086  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:8088  c6460a01       mov    byte ptr [bp + 0xa], 1  
F000:808C  e985fd         jmp    0x7e14                  
F000:808F  06             push   es                      
F000:8090  e87e69         call   0xea11                  
F000:8093  2689162201     mov    word ptr es:[0x122], dx 
F000:8098  07             pop    es                      
F000:8099  83c40b         add    sp, 0xb                 
F000:809C  80fa80         cmp    dl, 0x80                
F000:809F  7328           jae    0x80c9                  
F000:80A1  52             push   dx                      
F000:80A2  b416           mov    ah, 0x16                
F000:80A4  b200           mov    dl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:80A6  cd13           int    0x13                     ; BIOS service
F000:80A8  5a             pop    dx                      
F000:80A9  0f820500       jb     0x80b2                  
F000:80AD  e8c901         call   0x8279                  
F000:80B0  7316           jae    0x80c8                  
F000:80B2  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:80B4  242f           and    al, 0x2f                
F000:80B6  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:80B8  bc0004         mov    sp, 0x400               
F000:80BB  e84969         call   0xea07                  
F000:80BE  36a0f803       mov    al, byte ptr ss:[0x3f8] 
F000:80C2  a2be00         mov    byte ptr [0xbe], al     
F000:80C5  e91cfd         jmp    0x7de4                  
F000:80C8  59             pop    cx                      
F000:80C9  f6c620         test   dh, 0x20                
F000:80CC  740a           je     0x80d8                  
F000:80CE  06             push   es                      
F000:80CF  e83f69         call   0xea11                  
F000:80D2  268b162401     mov    dx, word ptr es:[0x124] 
F000:80D7  07             pop    es                      
F000:80D8  b002           mov    al, 2                   
F000:80DA  e83cf3         call   0x7419                  
F000:80DD  ea007c0000     ljmp   0:0x7c00                 ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"

;----- sub_80E2 -----
F000:80E2  b200           mov    dl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:80E4  e8e649         call   0xcacd                  
F000:80E7  e82769         call   0xea11                  
F000:80EA  26c606ec0080   mov    byte ptr es:[0xec], 0x80
F000:80F0  fb             sti                            
F000:80F1  fc             cld                            
F000:80F2  b80000         mov    ax, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:80F5  8ed8           mov    ds, ax                  
F000:80F7  8ec0           mov    es, ax                  
F000:80F9  c7067800c7ef   mov    word ptr [0x78], 0xefc7 
F000:80FF  8c0e7a00       mov    word ptr [0x7a], cs     
F000:8103  b8ffff         mov    ax, 0xffff              
F000:8106  b90001         mov    cx, 0x100               
F000:8109  bf007c         mov    di, 0x7c00              
F000:810C  f3ab           rep stosw word ptr es:[di], ax    
F000:810E  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:8110  247f           and    al, 0x7f                
F000:8112  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:8114  c3             ret                            

;----- sub_8115 -----
F000:8115  06             push   es                      
F000:8116  e8f868         call   0xea11                  
F000:8119  e8e801         call   0x8304                  
F000:811C  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:811E  730f           jae    0x812f                  
F000:8120  b401           mov    ah, 1                   
F000:8122  52             push   dx                      
F000:8123  e8ca07         call   0x88f0                  
F000:8126  5a             pop    dx                      
F000:8127  2aff           sub    bh, bh                  
F000:8129  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:812B  7402           je     0x812f                  
F000:812D  b701           mov    bh, 1                   
F000:812F  07             pop    es                      
F000:8130  c3             ret                            

;----- sub_8131 -----
F000:8131  32ff           xor    bh, bh                  
F000:8133  e8c968         call   0xe9ff                  
F000:8136  813e7200dcfe   cmp    word ptr [0x72], 0xfedc 
F000:813C  745a           je     0x8198                  
F000:813E  b0fb           mov    al, 0xfb                
F000:8140  e84d68         call   0xe990                  
F000:8143  a808           test   al, 8                   
F000:8145  7514           jne    0x815b                  
F000:8147  b80021         mov    ax, 0x2100              
F000:814A  cd15           int    0x15                     ; BIOS service
F000:814C  0bdb           or     bx, bx                  
F000:814E  750b           jne    0x815b                  
F000:8150  e8fe5d         call   0xdf51                  
F000:8153  0f820400       jb     0x815b                  
F000:8157  33db           xor    bx, bx                  
F000:8159  eb3d           jmp    0x8198                  
F000:815B  807e0a01       cmp    byte ptr [bp + 0xa], 1  
F000:815F  741b           je     0x817c                  
F000:8161  b401           mov    ah, 1                   
F000:8163  e88a07         call   0x88f0                  
F000:8166  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8168  7512           jne    0x817c                  
F000:816A  26803ec50001   cmp    byte ptr es:[0xc5], 1   
F000:8170  740a           je     0x817c                  
F000:8172  26c606be0000   mov    byte ptr es:[0xbe], 0    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8178  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:817A  eb1c           jmp    0x8198                  
F000:817C  b000           mov    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:817E  e898f2         call   0x7419                  
F000:8181  e8ca4c         call   0xce4e                  
F000:8184  e8d65b         call   0xdd5d                  
F000:8187  e8654c         call   0xcdef                  
F000:818A  b00a           mov    al, 0xa                 
F000:818C  e89dd2         call   0x542c                  
F000:818F  beb9e4         mov    si, 0xe4b9               ; "I9990303"
F000:8192  e82cd2         call   0x53c1                  
F000:8195  e80100         call   0x8199                  
F000:8198  c3             ret                            

;----- sub_8199 -----
F000:8199  e88f02         call   0x842b                  
F000:819C  b90200         mov    cx, 2                   
F000:819F  e86201         call   0x8304                  
F000:81A2  721d           jb     0x81c1                  
F000:81A4  49             dec    cx                      
F000:81A5  7514           jne    0x81bb                  
F000:81A7  e8d201         call   0x837c                  
F000:81AA  74f3           je     0x819f                  
F000:81AC  807e0a01       cmp    byte ptr [bp + 0xa], 1  
F000:81B0  7405           je     0x81b7                  
F000:81B2  b401           mov    ah, 1                   
F000:81B4  e83907         call   0x88f0                  
F000:81B7  b702           mov    bh, 2                   
F000:81B9  eb13           jmp    0x81ce                  
F000:81BB  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:81BD  cd16           int    0x16                     ; BIOS service
F000:81BF  ebde           jmp    0x819f                  
F000:81C1  807e0a01       cmp    byte ptr [bp + 0xa], 1  
F000:81C5  7405           je     0x81cc                  
F000:81C7  b401           mov    ah, 1                   
F000:81C9  e82407         call   0x88f0                  
F000:81CC  b701           mov    bh, 1                   
F000:81CE  c3             ret                            

;----- sub_81CF -----
F000:81CF  80fa80         cmp    dl, 0x80                
F000:81D2  720f           jb     0x81e3                  
F000:81D4  e82868         call   0xe9ff                  
F000:81D7  8ac2           mov    al, dl                  
F000:81D9  247f           and    al, 0x7f                
F000:81DB  3a067500       cmp    al, byte ptr [0x75]     
F000:81DF  0f839200       jae    0x8275                  
F000:81E3  fb             sti                            
F000:81E4  b070           mov    al, 0x70                
F000:81E6  e8c4d3         call   0x55ad                  
F000:81E9  52             push   dx                      
F000:81EA  b90100         mov    cx, 1                   
F000:81ED  32f6           xor    dh, dh                  
F000:81EF  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:81F1  50             push   ax                      
F000:81F2  b80102         mov    ax, 0x201               
F000:81F5  e8bf00         call   0x82b7                  
F000:81F8  58             pop    ax                      
F000:81F9  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:81FB  5a             pop    dx                      
F000:81FC  0f837900       jae    0x8279                  
F000:8200  80fa80         cmp    dl, 0x80                
F000:8203  7307           jae    0x820c                  
F000:8205  57             push   di                      
F000:8206  e8aa48         call   0xcab3                  
F000:8209  5f             pop    di                      
F000:820A  755d           jne    0x8269                  
F000:820C  680000         push   0                        ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:820F  07             pop    es                      
F000:8210  49             dec    cx                      
F000:8211  33c0           xor    ax, ax                  
F000:8213  57             push   di                      
F000:8214  bf007c         mov    di, 0x7c00              
F000:8217  260205         add    al, byte ptr es:[di]    
F000:821A  47             inc    di                      
F000:821B  81ff087c       cmp    di, 0x7c08              
F000:821F  72f6           jb     0x8217                  
F000:8221  5f             pop    di                      
F000:8222  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8224  7502           jne    0x8228                  
F000:8226  eb1a           jmp    0x8242                  
F000:8228  52             push   dx                      
F000:8229  06             push   es                      
F000:822A  e8e467         call   0xea11                  
F000:822D  268b162401     mov    dx, word ptr es:[0x124] 
F000:8232  b80380         mov    ax, 0x8003              
F000:8235  cd4b           int    0x4b                     ; BIOS service
F000:8237  26c70624010000 mov    word ptr es:[0x124], 0   ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:823E  07             pop    es                      
F000:823F  5a             pop    dx                      
F000:8240  eb27           jmp    0x8269                  
F000:8242  268a2e037c     mov    ch, byte ptr es:[0x7c03]
F000:8247  268a0e047c     mov    cl, byte ptr es:[0x7c04]
F000:824C  80fa80         cmp    dl, 0x80                
F000:824F  7203           jb     0x8254                  
F000:8251  c0e906         shr    cl, 6                   
F000:8254  52             push   dx                      
F000:8255  268a36057c     mov    dh, byte ptr es:[0x7c05]
F000:825A  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:825C  50             push   ax                      
F000:825D  b80102         mov    ax, 0x201               
F000:8260  e85400         call   0x82b7                  
F000:8263  58             pop    ax                      
F000:8264  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:8266  5a             pop    dx                      
F000:8267  7310           jae    0x8279                  
F000:8269  b000           mov    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:826B  80fa80         cmp    dl, 0x80                
F000:826E  7307           jae    0x8277                  
F000:8270  f6c680         test   dh, 0x80                
F000:8273  7402           je     0x8277                  
F000:8275  b005           mov    al, 5                   
F000:8277  f9             stc                            
F000:8278  c3             ret                            

;----- sub_8279 -----
F000:8279  26803e007c06   cmp    byte ptr es:[0x7c00], 6 
F000:827F  7224           jb     0x82a5                  
F000:8281  be007c         mov    si, 0x7c00              
F000:8284  b90800         mov    cx, 8                   
F000:8287  26a1007c       mov    ax, word ptr es:[0x7c00]
F000:828B  83c602         add    si, 2                   
F000:828E  263b04         cmp    ax, word ptr es:[si]    
F000:8291  e1f8           loope  0x828b                  
F000:8293  7410           je     0x82a5                  
F000:8295  80fa80         cmp    dl, 0x80                
F000:8298  7209           jb     0x82a3                  
F000:829A  26813efe7d55aa cmp    word ptr es:[0x7dfe], 0xaa55
F000:82A1  7502           jne    0x82a5                  
F000:82A3  f8             clc                            
F000:82A4  c3             ret                            
F000:82A5  b001           mov    al, 1                   
F000:82A7  80fa80         cmp    dl, 0x80                
F000:82AA  7309           jae    0x82b5                  
F000:82AC  b004           mov    al, 4                   
F000:82AE  f6c620         test   dh, 0x20                
F000:82B1  7502           jne    0x82b5                  
F000:82B3  b003           mov    al, 3                   
F000:82B5  f9             stc                            
F000:82B6  c3             ret                            

;----- sub_82B7 -----
F000:82B7  680000         push   0                        ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:82BA  07             pop    es                      
F000:82BB  bb007c         mov    bx, 0x7c00              
F000:82BE  55             push   bp                      
F000:82BF  bd0400         mov    bp, 4                   
F000:82C2  50             push   ax                      
F000:82C3  66c1e010       shl    eax, 0x10               
F000:82C7  58             pop    ax                      
F000:82C8  80fa80         cmp    dl, 0x80                
F000:82CB  0f830a00       jae    0x82d9                  
F000:82CF  e8605c         call   0xdf32                  
F000:82D2  0f820300       jb     0x82d9                  
F000:82D6  eb26           jmp    0x82fe                  
F000:82D9  cd13           int    0x13                     ; BIOS service
F000:82DB  7324           jae    0x8301                  
F000:82DD  50             push   ax                      
F000:82DE  b071           mov    al, 0x71                
F000:82E0  e8cad2         call   0x55ad                  
F000:82E3  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:82E5  cd13           int    0x13                     ; BIOS service
F000:82E7  58             pop    ax                      
F000:82E8  7214           jb     0x82fe                  
F000:82EA  80fc80         cmp    ah, 0x80                
F000:82ED  740f           je     0x82fe                  
F000:82EF  4d             dec    bp                      
F000:82F0  740c           je     0x82fe                  
F000:82F2  66c1e810       shr    eax, 0x10               
F000:82F6  50             push   ax                      
F000:82F7  66c1e010       shl    eax, 0x10               
F000:82FB  58             pop    ax                      
F000:82FC  ebdb           jmp    0x82d9                  
F000:82FE  5d             pop    bp                      
F000:82FF  f9             stc                            
F000:8300  c3             ret                            
F000:8301  5d             pop    bp                      
F000:8302  f8             clc                            
F000:8303  c3             ret                            

;----- sub_8304 -----
F000:8304  1e             push   ds                      
F000:8305  06             push   es                      
F000:8306  51             push   cx                      
F000:8307  e8f566         call   0xe9ff                  
F000:830A  e80467         call   0xea11                  
F000:830D  8a1e9000       mov    bl, byte ptr [0x90]     
F000:8311  80fb00         cmp    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8314  7443           je     0x8359                  
F000:8316  ba0080         mov    dx, 0x8000              
F000:8319  e84100         call   0x835d                  
F000:831C  723b           jb     0x8359                  
F000:831E  268a26e700     mov    ah, byte ptr es:[0xe7]  
F000:8323  f6c401         test   ah, 1                   
F000:8326  7404           je     0x832c                  
F000:8328  b702           mov    bh, 2                   
F000:832A  eb02           jmp    0x832e                  
F000:832C  b701           mov    bh, 1                   
F000:832E  d0ec           shr    ah, 1                   
F000:8330  be0100         mov    si, 1                   
F000:8333  b90300         mov    cx, 3                   
F000:8336  8a9c9000       mov    bl, byte ptr [si + 0x90]
F000:833A  0adb           or     bl, bl                  
F000:833C  741b           je     0x8359                  
F000:833E  d0ec           shr    ah, 1                   
F000:8340  7204           jb     0x8346                  
F000:8342  b301           mov    bl, 1                   
F000:8344  eb02           jmp    0x8348                  
F000:8346  b302           mov    bl, 2                   
F000:8348  3adf           cmp    bl, bh                  
F000:834A  7506           jne    0x8352                  
F000:834C  46             inc    si                      
F000:834D  e2e7           loop   0x8336                  
F000:834F  f8             clc                            
F000:8350  eb07           jmp    0x8359                  
F000:8352  8bd6           mov    dx, si                  
F000:8354  b680           mov    dh, 0x80                
F000:8356  e80400         call   0x835d                  
F000:8359  59             pop    cx                      
F000:835A  07             pop    es                      
F000:835B  1f             pop    ds                      
F000:835C  c3             ret                            

;----- sub_835D -----
F000:835D  e85347         call   0xcab3                  
F000:8360  7518           jne    0x837a                  
F000:8362  1e             push   ds                      
F000:8363  06             push   es                      
F000:8364  e868fe         call   0x81cf                  
F000:8367  07             pop    es                      
F000:8368  1f             pop    ds                      
F000:8369  720f           jb     0x837a                  

;----- sub_836B -----
F000:836B  1e             push   ds                      
F000:836C  680000         push   0                        ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:836F  1f             pop    ds                      
F000:8370  803e0a7c79     cmp    byte ptr [0x7c0a], 0x79 
F000:8375  1f             pop    ds                      
F000:8376  7502           jne    0x837a                  
F000:8378  f9             stc                            
F000:8379  c3             ret                            
F000:837A  f8             clc                            
F000:837B  c3             ret                            

;----- sub_837C -----
F000:837C  06             push   es                      
F000:837D  53             push   bx                      
F000:837E  680000         push   0                        ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8381  07             pop    es                      
F000:8382  8ccb           mov    bx, cs                  
F000:8384  66c1e310       shl    ebx, 0x10               
F000:8388  bb077f         mov    bx, 0x7f07              
F000:838B  26663b1e6000   cmp    ebx, dword ptr es:[0x60]
F000:8391  5b             pop    bx                      
F000:8392  07             pop    es                      
F000:8393  c3             ret                            

;----- sub_83CF -----
F000:83CF  50             push   ax                      
F000:83D0  53             push   bx                      
F000:83D1  52             push   dx                      
F000:83D2  1e             push   ds                      
F000:83D3  06             push   es                      
F000:83D4  33c0           xor    ax, ax                  
F000:83D6  8ed8           mov    ds, ax                  
F000:83D8  803e0a7c79     cmp    byte ptr [0x7c0a], 0x79 
F000:83DD  7446           je     0x8425                  
F000:83DF  e81d66         call   0xe9ff                  
F000:83E2  f606120001     test   byte ptr [0x12], 1      
F000:83E7  753c           jne    0x8425                  
F000:83E9  803e720064     cmp    byte ptr [0x72], 0x64   
F000:83EE  7435           je     0x8425                  
F000:83F0  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:83F2  a850           test   al, 0x50                
F000:83F4  752f           jne    0x8425                  
F000:83F6  b80021         mov    ax, 0x2100              
F000:83F9  cd15           int    0x15                     ; BIOS service
F000:83FB  0bdb           or     bx, bx                  
F000:83FD  7426           je     0x8425                  
F000:83FF  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:8401  0c10           or     al, 0x10                
F000:8403  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:8405  a09000         mov    al, byte ptr [0x90]     
F000:8408  243f           and    al, 0x3f                
F000:840A  7419           je     0x8425                  
F000:840C  e48b           in     al, 0x8b                 ; VL82C420 cfg
F000:840E  0c10           or     al, 0x10                
F000:8410  e68b           out    0x8b, al                 ; VL82C420 cfg
F000:8412  e81600         call   0x842b                  
F000:8415  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8417  cd16           int    0x16                     ; BIOS service
F000:8419  80fc3b         cmp    ah, 0x3b                
F000:841C  75f7           jne    0x8415                  
F000:841E  ba0100         mov    dx, 1                   
F000:8421  e8abcf         call   0x53cf                  
F000:8424  f9             stc                            
F000:8425  07             pop    es                      
F000:8426  1f             pop    ds                      
F000:8427  5a             pop    dx                      
F000:8428  5b             pop    bx                      
F000:8429  58             pop    ax                      
F000:842A  c3             ret                            

;----- sub_842B -----
F000:842B  60             pushaw                         
F000:842C  1e             push   ds                      
F000:842D  06             push   es                      
F000:842E  0e             push   cs                      
F000:842F  1f             pop    ds                      
F000:8430  0e             push   cs                      
F000:8431  07             pop    es                      
F000:8432  b402           mov    ah, 2                   
F000:8434  33d2           xor    dx, dx                  
F000:8436  cd10           int    0x10                     ; BIOS service
F000:8438  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:843A  b90b00         mov    cx, 0xb                 
F000:843D  b8200a         mov    ax, 0xa20               
F000:8440  cd10           int    0x10                     ; BIOS service
F000:8442  bd9884         mov    bp, 0x8498              
F000:8445  b411           mov    ah, 0x11                
F000:8447  b010           mov    al, 0x10                
F000:8449  b93100         mov    cx, 0x31                
F000:844C  bac000         mov    dx, 0xc0                
F000:844F  b300           mov    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8451  b710           mov    bh, 0x10                
F000:8453  cd10           int    0x10                     ; BIOS service
F000:8455  b80311         mov    ax, 0x1103              
F000:8458  b300           mov    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:845A  cd10           int    0x10                     ; BIOS service
F000:845C  ba0801         mov    dx, 0x108               
F000:845F  bda887         mov    bp, 0x87a8              
F000:8462  e865d1         call   0x55ca                  
F000:8465  ba0000         mov    dx, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8468  bdb887         mov    bp, 0x87b8              
F000:846B  e85cd1         call   0x55ca                  
F000:846E  07             pop    es                      
F000:846F  1f             pop    ds                      
F000:8470  61             popaw                          
F000:8471  c3             ret                            

;----- sub_8472 -----
F000:8472  8af7           mov    dh, bh                  
F000:8474  b226           mov    dl, 0x26                
F000:8476  b326           mov    bl, 0x26                
F000:8478  bdcde6         mov    bp, 0xe6cd              
F000:847B  e84cd1         call   0x55ca                  
F000:847E  b90035         mov    cx, 0x3500              
F000:8481  e8fc65         call   0xea80                  
F000:8484  e8d003         call   0x8857                  
F000:8487  730e           jae    0x8497                  
F000:8489  b80006         mov    ax, 0x600               
F000:848C  8bcb           mov    cx, bx                  
F000:848E  8bd3           mov    dx, bx                  
F000:8490  b707           mov    bh, 7                   
F000:8492  cd10           int    0x10                     ; BIOS service
F000:8494  e8c003         call   0x8857                  
F000:8497  c3             ret                            

;----- sub_8857 -----
F000:8857  b401           mov    ah, 1                   
F000:8859  cd16           int    0x16                     ; BIOS service
F000:885B  f9             stc                            
F000:885C  740f           je     0x886d                  
F000:885E  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8860  cd16           int    0x16                     ; BIOS service
F000:8862  80fc3b         cmp    ah, 0x3b                
F000:8865  7506           jne    0x886d                  
F000:8867  ba0100         mov    dx, 1                   
F000:886A  e862cb         call   0x53cf                  
F000:886D  c3             ret                            

;----- sub_886E -----
F000:886E  60             pushaw                         
F000:886F  26c7057f00     mov    word ptr es:[di], 0x7f  
F000:8874  b08e           mov    al, 0x8e                
F000:8876  e81761         call   0xe990                  
F000:8879  a8c0           test   al, 0xc0                
F000:887B  0f852200       jne    0x88a1                  
F000:887F  b09d           mov    al, 0x9d                
F000:8881  e80c61         call   0xe990                  
F000:8884  c0c804         ror    al, 4                   
F000:8887  8ad8           mov    bl, al                  
F000:8889  b09e           mov    al, 0x9e                
F000:888B  e80261         call   0xe990                  
F000:888E  c0c804         ror    al, 4                   
F000:8891  8af8           mov    bh, al                  
F000:8893  b90400         mov    cx, 4                   
F000:8896  8ac3           mov    al, bl                  
F000:8898  e80800         call   0x88a3                  
F000:889B  ab             stosw  word ptr es:[di], ax    
F000:889C  c1eb04         shr    bx, 4                   
F000:889F  e2f5           loop   0x8896                  
F000:88A1  61             popaw                          
F000:88A2  c3             ret                            

;----- sub_88A3 -----
F000:88A3  53             push   bx                      
F000:88A4  8ad8           mov    bl, al                  
F000:88A6  80e30f         and    bl, 0xf                 
F000:88A9  b80080         mov    ax, 0x8000              
F000:88AC  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:88AE  3adf           cmp    bl, bh                  
F000:88B0  0f822f00       jb     0x88e3                  
F000:88B4  80fb02         cmp    bl, 2                   
F000:88B7  0f822d00       jb     0x88e8                  
F000:88BB  b87d00         mov    ax, 0x7d                
F000:88BE  b705           mov    bh, 5                   
F000:88C0  3adf           cmp    bl, bh                  
F000:88C2  0f842200       je     0x88e8                  
F000:88C6  b87e00         mov    ax, 0x7e                
F000:88C9  b706           mov    bh, 6                   
F000:88CB  3adf           cmp    bl, bh                  
F000:88CD  0f841700       je     0x88e8                  
F000:88D1  b88000         mov    ax, 0x80                
F000:88D4  b708           mov    bh, 8                   
F000:88D6  3adf           cmp    bl, bh                  
F000:88D8  0f820700       jb     0x88e3                  
F000:88DC  80fb0c         cmp    bl, 0xc                 
F000:88DF  0f820500       jb     0x88e8                  
F000:88E3  b87f00         mov    ax, 0x7f                
F000:88E6  2bdb           sub    bx, bx                  
F000:88E8  2adf           sub    bl, bh                  
F000:88EA  2aff           sub    bh, bh                  
F000:88EC  03c3           add    ax, bx                  
F000:88EE  5b             pop    bx                      
F000:88EF  c3             ret                            

;----- sub_88F0 -----
F000:88F0  1e             push   ds                      
F000:88F1  06             push   es                      
F000:88F2  0e             push   cs                      
F000:88F3  07             pop    es                      
F000:88F4  e84c08         call   0x9143                  
F000:88F7  886436         mov    byte ptr [si + 0x36], ah
F000:88FA  e81908         call   0x9116                  
F000:88FD  e8fc07         call   0x90fc                  
F000:8900  7403           je     0x8905                  
F000:8902  eb21           jmp    0x8925                  
F000:8905  e83c01         call   0x8a44                  
F000:8908  b093           mov    al, 0x93                
F000:890A  e86001         call   0x8a6d                  
F000:890D  7502           jne    0x8911                  
F000:890F  eb14           jmp    0x8925                  
F000:8911  1e             push   ds                      
F000:8912  e84708         call   0x915c                  
F000:8915  1f             pop    ds                      
F000:8916  e80103         call   0x8c1a                   ; "PSQR"
F000:8919  e85700         call   0x8973                  
F000:891C  b9ffff         mov    cx, 0xffff              
F000:891F  e85e61         call   0xea80                  
F000:8922  e89101         call   0x8ab6                  
F000:8925  e8a207         call   0x90ca                  
F000:8928  e81800         call   0x8943                  
F000:892B  1e             push   ds                      
F000:892C  e82d08         call   0x915c                  
F000:892F  1f             pop    ds                      
F000:8930  8a4435         mov    al, byte ptr [si + 0x35]
F000:8933  e8ef07         call   0x9125                  
F000:8936  83c46f         add    sp, 0x6f                
F000:8939  07             pop    es                      
F000:893A  1f             pop    ds                      
F000:893B  50             push   ax                      
F000:893C  b00f           mov    al, 0xf                 
F000:893E  e84f60         call   0xe990                  
F000:8941  58             pop    ax                      
F000:8942  c3             ret                            

;----- sub_8943 -----
F000:8943  807c3601       cmp    byte ptr [si + 0x36], 1 
F000:8947  7507           jne    0x8950                  
F000:8949  c6443501       mov    byte ptr [si + 0x35], 1 
F000:894D  eb23           jmp    0x8972                  
F000:8950  e82001         call   0x8a73                  
F000:8953  740e           je     0x8963                  
F000:8955  1e             push   ds                      
F000:8956  e8d560         call   0xea2e                  
F000:8959  1f             pop    ds                      
F000:895A  7407           je     0x8963                  
F000:895C  c6443502       mov    byte ptr [si + 0x35], 2 
F000:8960  eb10           jmp    0x8972                  
F000:8963  b093           mov    al, 0x93                
F000:8965  e80501         call   0x8a6d                  
F000:8968  0f840300       je     0x896f                  
F000:896C  e8bb01         call   0x8b2a                  
F000:896F  e8bf01         call   0x8b31                  
F000:8972  c3             ret                            

;----- sub_8973 -----
F000:8973  e8cc01         call   0x8b42                  
F000:8976  e80201         call   0x8a7b                  
F000:8979  807c2901       cmp    byte ptr [si + 0x29], 1 
F000:897D  0f84aa00       je     0x8a2b                  
F000:8981  807c2a00       cmp    byte ptr [si + 0x2a], 0  ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8985  0f84a200       je     0x8a2b                  
F000:8989  e8e700         call   0x8a73                  
F000:898C  750e           jne    0x899c                  
F000:898E  06             push   es                      
F000:898F  e87f60         call   0xea11                  
F000:8992  b054           mov    al, 0x54                
F000:8994  263a06be00     cmp    al, byte ptr es:[0xbe]  
F000:8999  07             pop    es                      
F000:899A  7500           jne    0x899c                  
F000:899C  0fb64c2f       movzx  cx, byte ptr [si + 0x2f]
F000:89A0  bb0000         mov    bx, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:89A3  bd1000         mov    bp, 0x10                
F000:89A6  e8aa06         call   0x9053                  
F000:89A9  0f837e00       jae    0x8a2b                  
F000:89AD  8a442f         mov    al, byte ptr [si + 0x2f]
F000:89B0  e8af06         call   0x9062                   ; "8D*w"
F000:89B3  7206           jb     0x89bb                  
F000:89B5  e8f406         call   0x90ac                  
F000:89B8  e98800         jmp    0x8a43                  
F000:89BB  33db           xor    bx, bx                  
F000:89BD  8ad8           mov    bl, al                  
F000:89BF  80c310         add    bl, 0x10                
F000:89C2  8a00           mov    al, byte ptr [bx + si]  
F000:89C4  3c39           cmp    al, 0x39                
F000:89C6  7402           je     0x89ca                  
F000:89C8  eb61           jmp    0x8a2b                  
F000:89CA  8a4428         mov    al, byte ptr [si + 0x28]
F000:89CD  3c10           cmp    al, 0x10                
F000:89CF  775a           ja     0x8a2b                  
F000:89D1  43             inc    bx                      
F000:89D2  32c9           xor    cl, cl                  
F000:89D4  884c2b         mov    byte ptr [si + 0x2b], cl
F000:89D7  884c2d         mov    byte ptr [si + 0x2d], cl
F000:89DA  8a00           mov    al, byte ptr [bx + si]  
F000:89DC  fec1           inc    cl                      
F000:89DE  80f907         cmp    cl, 7                   
F000:89E1  7e04           jle    0x89e7                  
F000:89E3  3c39           cmp    al, 0x39                
F000:89E5  7544           jne    0x8a2b                  
F000:89E7  0ac0           or     al, al                  
F000:89E9  740a           je     0x89f5                  
F000:89EB  3c39           cmp    al, 0x39                
F000:89ED  7414           je     0x8a03                  
F000:89EF  00442b         add    byte ptr [si + 0x2b], al
F000:89F2  43             inc    bx                      
F000:89F3  ebe2           jmp    0x89d7                  
F000:89F5  fec9           dec    cl                      
F000:89F7  7532           jne    0x8a2b                  
F000:89F9  e82701         call   0x8b23                  
F000:89FC  804c3101       or     byte ptr [si + 0x31], 1 
F000:8A00  eb41           jmp    0x8a43                  
F000:8A03  53             push   bx                      
F000:8A04  2ad9           sub    bl, cl                  
F000:8A06  8beb           mov    bp, bx                  
F000:8A08  5b             pop    bx                      
F000:8A09  32c0           xor    al, al                  
F000:8A0B  88442c         mov    byte ptr [si + 0x2c], al
F000:8A0E  fec9           dec    cl                      
F000:8A10  45             inc    bp                      
F000:8A11  43             inc    bx                      
F000:8A12  8a00           mov    al, byte ptr [bx + si]  
F000:8A14  0ac0           or     al, al                  
F000:8A16  7413           je     0x8a2b                  
F000:8A18  8a22           mov    ah, byte ptr [bp + si]  
F000:8A1A  3ac4           cmp    al, ah                  
F000:8A1C  750d           jne    0x8a2b                  
F000:8A1E  00442c         add    byte ptr [si + 0x2c], al
F000:8A21  e2ed           loop   0x8a10                  
F000:8A23  8a642b         mov    ah, byte ptr [si + 0x2b]
F000:8A26  38642c         cmp    byte ptr [si + 0x2c], ah
F000:8A29  740a           je     0x8a35                  
F000:8A2B  c6442900       mov    byte ptr [si + 0x29], 0  ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8A2F  e83a06         call   0x906c                  
F000:8A32  e941ff         jmp    0x8976                  
F000:8A35  43             inc    bx                      
F000:8A36  8a00           mov    al, byte ptr [bx + si]  
F000:8A38  0ac0           or     al, al                  
F000:8A3A  75ef           jne    0x8a2b                  
F000:8A3C  e8ba00         call   0x8af9                  
F000:8A3F  804c3102       or     byte ptr [si + 0x31], 2 
F000:8A43  c3             ret                            

;----- sub_8A44 -----
F000:8A44  e89805         call   0x8fdf                  
F000:8A47  7223           jb     0x8a6c                  
F000:8A49  7513           jne    0x8a5e                  
F000:8A4B  e8e105         call   0x902f                  
F000:8A4E  56             push   si                      
F000:8A4F  be97e3         mov    si, 0xe397               ; " 184"
F000:8A52  e84fc9         call   0x53a4                  
F000:8A55  b9ffff         mov    cx, 0xffff              
F000:8A58  e82560         call   0xea80                  
F000:8A5B  5e             pop    si                      
F000:8A5C  eb0e           jmp    0x8a6c                  
F000:8A5E  b093           mov    al, 0x93                
F000:8A60  e82d5f         call   0xe990                  
F000:8A63  0c01           or     al, 1                   
F000:8A65  86e0           xchg   al, ah                  
F000:8A67  b093           mov    al, 0x93                
F000:8A69  e85a5f         call   0xe9c6                  
F000:8A6C  c3             ret                            

;----- sub_8A6D -----
F000:8A6D  e8205f         call   0xe990                  
F000:8A70  a801           test   al, 1                   
F000:8A72  c3             ret                            

;----- sub_8A73 -----
F000:8A73  b80021         mov    ax, 0x2100              
F000:8A76  cd15           int    0x15                     ; BIOS service
F000:8A78  0bdb           or     bx, bx                  
F000:8A7A  c3             ret                            

;----- sub_8A7B -----
F000:8A7B  c6442a00       mov    byte ptr [si + 0x2a], 0  ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8A7F  e81607         call   0x9198                  
F000:8A82  e86201         call   0x8be7                  
F000:8A85  c6442800       mov    byte ptr [si + 0x28], 0  ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8A89  bb1000         mov    bx, 0x10                
F000:8A8C  8a4c2f         mov    cl, byte ptr [si + 0x2f]
F000:8A8F  e88b05         call   0x901d                  
F000:8A92  80fc1c         cmp    ah, 0x1c                
F000:8A95  7419           je     0x8ab0                  
F000:8A97  fe442a         inc    byte ptr [si + 0x2a]    
F000:8A9A  807c2a17       cmp    byte ptr [si + 0x2a], 0x17
F000:8A9E  77ef           ja     0x8a8f                  
F000:8AA0  e82801         call   0x8bcb                  
F000:8AA3  8820           mov    byte ptr [bx + si], ah  
F000:8AA5  43             inc    bx                      
F000:8AA6  384c2a         cmp    byte ptr [si + 0x2a], cl
F000:8AA9  76e4           jbe    0x8a8f                  
F000:8AAB  fe4428         inc    byte ptr [si + 0x28]    
F000:8AAE  ebdf           jmp    0x8a8f                  
F000:8AB0  9c             pushf                          
F000:8AB1  e8e806         call   0x919c                  
F000:8AB4  9d             popf                           
F000:8AB5  c3             ret                            

;----- sub_8AB6 -----
F000:8AB6  e8ae06         call   0x9167                  
F000:8AB9  0f833b00       jae    0x8af8                  
F000:8ABD  e816aa         call   0x34d6                  
F000:8AC0  e889da         call   0x654c                  
F000:8AC3  b4b8           mov    ah, 0xb8                
F000:8AC5  b90700         mov    cx, 7                   
F000:8AC8  e8adda         call   0x6578                  
F000:8ACB  b0a5           mov    al, 0xa5                
F000:8ACD  e664           out    0x64, al                 ; KBC cmd/sts
F000:8ACF  e8a6da         call   0x6578                  
F000:8AD2  8ac4           mov    al, ah                  
F000:8AD4  e8b95e         call   0xe990                  
F000:8AD7  247f           and    al, 0x7f                
F000:8AD9  0ac0           or     al, al                  
F000:8ADB  0f840600       je     0x8ae5                  
F000:8ADF  e660           out    0x60, al                 ; KBC data
F000:8AE1  fec4           inc    ah                      
F000:8AE3  e2ea           loop   0x8acf                  
F000:8AE5  e890da         call   0x6578                  
F000:8AE8  b01c           mov    al, 0x1c                
F000:8AEA  e660           out    0x60, al                 ; KBC data
F000:8AEC  e889da         call   0x6578                  
F000:8AEF  32c0           xor    al, al                  
F000:8AF1  e660           out    0x60, al                 ; KBC data
F000:8AF3  e873da         call   0x6569                  
F000:8AF6  e460           in     al, 0x60                 ; KBC data
F000:8AF8  c3             ret                            

;----- sub_8AF9 -----
F000:8AF9  e84805         call   0x9044                  
F000:8AFC  33db           xor    bx, bx                  
F000:8AFE  8a5c2f         mov    bl, byte ptr [si + 0x2f]
F000:8B01  80c311         add    bl, 0x11                
F000:8B04  8a4c2d         mov    cl, byte ptr [si + 0x2d]
F000:8B07  b2b8           mov    dl, 0xb8                
F000:8B09  8ac2           mov    al, dl                  
F000:8B0B  8a20           mov    ah, byte ptr [bx + si]  
F000:8B0D  e8b65e         call   0xe9c6                  
F000:8B10  fec2           inc    dl                      
F000:8B12  43             inc    bx                      
F000:8B13  e2f4           loop   0x8b09                  
F000:8B15  8a542b         mov    dl, byte ptr [si + 0x2b]
F000:8B18  b0bf           mov    al, 0xbf                
F000:8B1A  8ae2           mov    ah, dl                  
F000:8B1C  e8a75e         call   0xe9c6                  
F000:8B1F  e82d00         call   0x8b4f                  
F000:8B22  c3             ret                            

;----- sub_8B23 -----
F000:8B23  e80905         call   0x902f                  
F000:8B26  e84100         call   0x8b6a                  
F000:8B29  c3             ret                            

;----- sub_8B2A -----
F000:8B2A  e492           in     al, 0x92                 ; PS2 sysctrl(A20)
F000:8B2C  0c08           or     al, 8                   
F000:8B2E  e692           out    0x92, al                 ; PS2 sysctrl(A20)
F000:8B30  c3             ret                            

;----- sub_8B31 -----
F000:8B31  e82254         call   0xdf56                  
F000:8B34  0f830100       jae    0x8b39                  
F000:8B38  c3             ret                            
F000:8B39  e498           in     al, 0x98                 ; chipset
F000:8B3B  0c03           or     al, 3                   
F000:8B3D  e698           out    0x98, al                 ; chipset
F000:8B3F  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:8B41  c3             ret                            

;----- sub_8B42 -----
F000:8B42  50             push   ax                      
F000:8B43  52             push   dx                      
F000:8B44  ba0400         mov    dx, 4                   
F000:8B47  b0c0           mov    al, 0xc0                
F000:8B49  e83001         call   0x8c7c                   ; "PSQR"
F000:8B4C  5a             pop    dx                      
F000:8B4D  58             pop    ax                      
F000:8B4E  c3             ret                            

;----- sub_8B4F -----
F000:8B4F  50             push   ax                      
F000:8B50  52             push   dx                      
F000:8B51  e88901         call   0x8cdd                  
F000:8B54  e86e01         call   0x8cc5                  
F000:8B57  ba0900         mov    dx, 9                   
F000:8B5A  b0d0           mov    al, 0xd0                
F000:8B5C  e81d01         call   0x8c7c                   ; "PSQR"
F000:8B5F  ba0e00         mov    dx, 0xe                 
F000:8B62  b0c0           mov    al, 0xc0                
F000:8B64  e81501         call   0x8c7c                   ; "PSQR"
F000:8B67  5a             pop    dx                      
F000:8B68  58             pop    ax                      
F000:8B69  c3             ret                            

;----- sub_8B6A -----
F000:8B6A  50             push   ax                      
F000:8B6B  52             push   dx                      
F000:8B6C  e86e01         call   0x8cdd                  
F000:8B6F  e85301         call   0x8cc5                  
F000:8B72  ba0900         mov    dx, 9                   
F000:8B75  b0d0           mov    al, 0xd0                
F000:8B77  e80201         call   0x8c7c                   ; "PSQR"
F000:8B7A  ba0e00         mov    dx, 0xe                 
F000:8B7D  b0c8           mov    al, 0xc8                
F000:8B7F  e8fa00         call   0x8c7c                   ; "PSQR"
F000:8B82  5a             pop    dx                      
F000:8B83  58             pop    ax                      
F000:8B84  c3             ret                            

;----- sub_8BAA -----
F000:8BAA  51             push   cx                      
F000:8BAB  0fb64c2e       movzx  cx, byte ptr [si + 0x2e]
F000:8BAF  e80101         call   0x8cb3                  
F000:8BB2  e82801         call   0x8cdd                  
F000:8BB5  59             pop    cx                      
F000:8BB6  c3             ret                            

;----- sub_8BB7 -----
F000:8BB7  e82301         call   0x8cdd                  
F000:8BBA  c3             ret                            

;----- sub_8BBB -----
F000:8BBB  50             push   ax                      
F000:8BBC  52             push   dx                      
F000:8BBD  e81d01         call   0x8cdd                  
F000:8BC0  ba0e00         mov    dx, 0xe                 
F000:8BC3  b0d0           mov    al, 0xd0                
F000:8BC5  e8b400         call   0x8c7c                   ; "PSQR"
F000:8BC8  5a             pop    dx                      
F000:8BC9  58             pop    ax                      
F000:8BCA  c3             ret                            

;----- sub_8BCB -----
F000:8BCB  50             push   ax                      
F000:8BCC  52             push   dx                      
F000:8BCD  ba0900         mov    dx, 9                   
F000:8BD0  0fb6442a       movzx  ax, byte ptr [si + 0x2a]
F000:8BD4  48             dec    ax                      
F000:8BD5  03d0           add    dx, ax                  
F000:8BD7  e8ce00         call   0x8ca8                  
F000:8BDA  b0e1           mov    al, 0xe1                
F000:8BDC  e81601         call   0x8cf5                  
F000:8BDF  42             inc    dx                      
F000:8BE0  e8c500         call   0x8ca8                  
F000:8BE3  42             inc    dx                      
F000:8BE4  5a             pop    dx                      
F000:8BE5  58             pop    ax                      
F000:8BE6  c3             ret                            

;----- sub_8BE7 -----
F000:8BE7  52             push   dx                      
F000:8BE8  ba0900         mov    dx, 9                   
F000:8BEB  e8ba00         call   0x8ca8                  
F000:8BEE  5a             pop    dx                      
F000:8BEF  c3             ret                            

;----- sub_8BF0 -----
F000:8BF0  50             push   ax                      
F000:8BF1  52             push   dx                      
F000:8BF2  e8e800         call   0x8cdd                  
F000:8BF5  e8cd00         call   0x8cc5                  
F000:8BF8  ba0a00         mov    dx, 0xa                 
F000:8BFB  b0d8           mov    al, 0xd8                
F000:8BFD  e87c00         call   0x8c7c                   ; "PSQR"
F000:8C00  ba0b02         mov    dx, 0x20b               
F000:8C03  e8a200         call   0x8ca8                  
F000:8C06  b0e3           mov    al, 0xe3                
F000:8C08  e8ea00         call   0x8cf5                  
F000:8C0B  ba0c02         mov    dx, 0x20c               
F000:8C0E  e89700         call   0x8ca8                  
F000:8C11  b0e4           mov    al, 0xe4                
F000:8C13  e8df00         call   0x8cf5                  
F000:8C16  5a             pop    dx                      
F000:8C17  58             pop    ax                      
F000:8C18  c3             ret                            

;----- sub_8C1A -----
F000:8C1A  50             push   ax                      
F000:8C1B  53             push   bx                      
F000:8C1C  51             push   cx                      
F000:8C1D  52             push   dx                      
F000:8C1E  0e             push   cs                      
F000:8C1F  07             pop    es                      
F000:8C20  bd078d         mov    bp, 0x8d07              
F000:8C23  b710           mov    bh, 0x10                
F000:8C25  b300           mov    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8C27  b91000         mov    cx, 0x10                
F000:8C2A  b80011         mov    ax, 0x1100              
F000:8C2D  bac000         mov    dx, 0xc0                
F000:8C30  cd10           int    0x10                     ; BIOS service
F000:8C32  0e             push   cs                      
F000:8C33  07             pop    es                      
F000:8C34  bd078e         mov    bp, 0x8e07              
F000:8C37  b710           mov    bh, 0x10                
F000:8C39  b300           mov    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8C3B  b91000         mov    cx, 0x10                
F000:8C3E  b80011         mov    ax, 0x1100              
F000:8C41  bad000         mov    dx, 0xd0                
F000:8C44  cd10           int    0x10                     ; BIOS service
F000:8C46  0e             push   cs                      
F000:8C47  07             pop    es                      
F000:8C48  bd878f         mov    bp, 0x8f87              
F000:8C4B  b710           mov    bh, 0x10                
F000:8C4D  b300           mov    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8C4F  b90500         mov    cx, 5                   
F000:8C52  b80011         mov    ax, 0x1100              
F000:8C55  bae000         mov    dx, 0xe0                
F000:8C58  cd10           int    0x10                     ; BIOS service
F000:8C5A  5a             pop    dx                      
F000:8C5B  59             pop    cx                      
F000:8C5C  5b             pop    bx                      
F000:8C5D  58             pop    ax                      
F000:8C5E  c3             ret                            

;----- sub_8C5F -----
F000:8C5F  50             push   ax                      
F000:8C60  53             push   bx                      
F000:8C61  51             push   cx                      
F000:8C62  52             push   dx                      
F000:8C63  0e             push   cs                      
F000:8C64  07             pop    es                      
F000:8C65  bd078f         mov    bp, 0x8f07              
F000:8C68  b710           mov    bh, 0x10                
F000:8C6A  b300           mov    bl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8C6C  b90800         mov    cx, 8                   
F000:8C6F  b80011         mov    ax, 0x1100              
F000:8C72  bad000         mov    dx, 0xd0                
F000:8C75  cd10           int    0x10                     ; BIOS service
F000:8C77  5a             pop    dx                      
F000:8C78  59             pop    cx                      
F000:8C79  5b             pop    bx                      
F000:8C7A  58             pop    ax                      
F000:8C7B  c3             ret                            

;----- sub_8C7C -----
F000:8C7C  50             push   ax                      
F000:8C7D  53             push   bx                      
F000:8C7E  51             push   cx                      
F000:8C7F  52             push   dx                      
F000:8C80  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8C82  33c9           xor    cx, cx                  
F000:8C84  50             push   ax                      
F000:8C85  e82000         call   0x8ca8                  
F000:8C88  e86a00         call   0x8cf5                  
F000:8C8B  58             pop    ax                      
F000:8C8C  42             inc    dx                      
F000:8C8D  fec0           inc    al                      
F000:8C8F  fec1           inc    cl                      
F000:8C91  fec5           inc    ch                      
F000:8C93  80f904         cmp    cl, 4                   
F000:8C96  75ec           jne    0x8c84                  
F000:8C98  b100           mov    cl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8C9A  5a             pop    dx                      
F000:8C9B  52             push   dx                      
F000:8C9C  fec6           inc    dh                      
F000:8C9E  80fd08         cmp    ch, 8                   
F000:8CA1  75e1           jne    0x8c84                  
F000:8CA3  5a             pop    dx                      
F000:8CA4  59             pop    cx                      
F000:8CA5  5b             pop    bx                      
F000:8CA6  58             pop    ax                      
F000:8CA7  c3             ret                            

;----- sub_8CA8 -----
F000:8CA8  50             push   ax                      
F000:8CA9  53             push   bx                      
F000:8CAA  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8CAC  b402           mov    ah, 2                   
F000:8CAE  cd10           int    0x10                     ; BIOS service
F000:8CB0  5b             pop    bx                      
F000:8CB1  58             pop    ax                      
F000:8CB2  c3             ret                            

;----- sub_8CB3 -----
F000:8CB3  50             push   ax                      
F000:8CB4  52             push   dx                      
F000:8CB5  ba0801         mov    dx, 0x108               
F000:8CB8  03d1           add    dx, cx                  
F000:8CBA  e8ebff         call   0x8ca8                  
F000:8CBD  b0e0           mov    al, 0xe0                
F000:8CBF  e83300         call   0x8cf5                  
F000:8CC2  5a             pop    dx                      
F000:8CC3  58             pop    ax                      
F000:8CC4  c3             ret                            

;----- sub_8CC5 -----
F000:8CC5  50             push   ax                      
F000:8CC6  51             push   cx                      
F000:8CC7  52             push   dx                      
F000:8CC8  b90300         mov    cx, 3                   
F000:8CCB  ba0801         mov    dx, 0x108               
F000:8CCE  e8d7ff         call   0x8ca8                  
F000:8CD1  b0e2           mov    al, 0xe2                
F000:8CD3  e81f00         call   0x8cf5                  
F000:8CD6  42             inc    dx                      
F000:8CD7  e2f5           loop   0x8cce                  
F000:8CD9  5a             pop    dx                      
F000:8CDA  59             pop    cx                      
F000:8CDB  58             pop    ax                      
F000:8CDC  c3             ret                            

;----- sub_8CDD -----
F000:8CDD  50             push   ax                      
F000:8CDE  51             push   cx                      
F000:8CDF  52             push   dx                      
F000:8CE0  b91800         mov    cx, 0x18                
F000:8CE3  ba0900         mov    dx, 9                   
F000:8CE6  e8bfff         call   0x8ca8                  
F000:8CE9  b0e2           mov    al, 0xe2                
F000:8CEB  e80700         call   0x8cf5                  
F000:8CEE  42             inc    dx                      
F000:8CEF  e2f5           loop   0x8ce6                  
F000:8CF1  5a             pop    dx                      
F000:8CF2  59             pop    cx                      
F000:8CF3  58             pop    ax                      
F000:8CF4  c3             ret                            

;----- sub_8CF5 -----
F000:8CF5  50             push   ax                      
F000:8CF6  53             push   bx                      
F000:8CF7  51             push   cx                      
F000:8CF8  b409           mov    ah, 9                   
F000:8CFA  b700           mov    bh, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8CFC  b307           mov    bl, 7                   
F000:8CFE  b90100         mov    cx, 1                   
F000:8D01  cd10           int    0x10                     ; BIOS service
F000:8D03  59             pop    cx                      
F000:8D04  5b             pop    bx                      
F000:8D05  58             pop    ax                      
F000:8D06  c3             ret                            

;----- sub_8FD7 -----
F000:8FD7  b08e           mov    al, 0x8e                
F000:8FD9  e8b459         call   0xe990                  
F000:8FDC  a8c0           test   al, 0xc0                
F000:8FDE  c3             ret                            

;----- sub_8FDF -----
F000:8FDF  b90700         mov    cx, 7                   
F000:8FE2  b4b8           mov    ah, 0xb8                
F000:8FE4  bb0000         mov    bx, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:8FE7  33d2           xor    dx, dx                  
F000:8FE9  88542f         mov    byte ptr [si + 0x2f], dl
F000:8FEC  8ac4           mov    al, ah                  
F000:8FEE  e89f59         call   0xe990                  
F000:8FF1  247f           and    al, 0x7f                
F000:8FF3  0ac0           or     al, al                  
F000:8FF5  740c           je     0x9003                  
F000:8FF7  8800           mov    byte ptr [bx + si], al  
F000:8FF9  02d0           add    dl, al                  
F000:8FFB  43             inc    bx                      
F000:8FFC  fec4           inc    ah                      
F000:8FFE  fe442f         inc    byte ptr [si + 0x2f]    
F000:9001  e2e9           loop   0x8fec                  
F000:9003  8a442f         mov    al, byte ptr [si + 0x2f]
F000:9006  0ac0           or     al, al                  
F000:9008  7411           je     0x901b                  
F000:900A  b0bf           mov    al, 0xbf                
F000:900C  e88159         call   0xe990                  
F000:900F  3ac2           cmp    al, dl                  
F000:9011  7404           je     0x9017                  
F000:9013  2ac9           sub    cl, cl                  
F000:9015  eb05           jmp    0x901c                  
F000:9017  0c01           or     al, 1                   
F000:9019  eb01           jmp    0x901c                  
F000:901B  f9             stc                            
F000:901C  c3             ret                            

;----- sub_901D -----
F000:901D  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:901F  fb             sti                            
F000:9020  cd16           int    0x16                     ; BIOS service
F000:9022  fa             cli                            
F000:9023  e86b00         call   0x9091                  
F000:9026  7306           jae    0x902e                  
F000:9028  c6442901       mov    byte ptr [si + 0x29], 1 
F000:902C  ebef           jmp    0x901d                  
F000:902E  c3             ret                            

;----- sub_902F -----
F000:902F  b093           mov    al, 0x93                
F000:9031  e85c59         call   0xe990                  
F000:9034  24fc           and    al, 0xfc                
F000:9036  8ae0           mov    ah, al                  
F000:9038  b093           mov    al, 0x93                
F000:903A  e88959         call   0xe9c6                  
F000:903D  e8c600         call   0x9106                  
F000:9040  e80100         call   0x9044                  
F000:9043  c3             ret                            

;----- sub_9044 -----
F000:9044  b90800         mov    cx, 8                   
F000:9047  b0b8           mov    al, 0xb8                
F000:9049  32e4           xor    ah, ah                  
F000:904B  e87859         call   0xe9c6                  
F000:904E  fec0           inc    al                      
F000:9050  e2f9           loop   0x904b                  
F000:9052  c3             ret                            

;----- sub_9053 -----
F000:9053  8a00           mov    al, byte ptr [bx + si]  
F000:9055  3a02           cmp    al, byte ptr [bp + si]  
F000:9057  7507           jne    0x9060                  
F000:9059  43             inc    bx                      
F000:905A  45             inc    bp                      
F000:905B  e2f6           loop   0x9053                  
F000:905D  f9             stc                            
F000:905E  eb01           jmp    0x9061                  
F000:9060  f8             clc                            
F000:9061  c3             ret                            

;----- sub_9062 -----
F000:9062  38442a         cmp    byte ptr [si + 0x2a], al
F000:9065  7703           ja     0x906a                  
F000:9067  f8             clc                            
F000:9068  eb01           jmp    0x906b                  
F000:906A  f9             stc                            
F000:906B  c3             ret                            

;----- sub_906C -----
F000:906C  e83bfb         call   0x8baa                  
F000:906F  bb1000         mov    bx, 0x10                
F000:9072  b91800         mov    cx, 0x18                
F000:9075  32c0           xor    al, al                  
F000:9077  8800           mov    byte ptr [bx + si], al  
F000:9079  43             inc    bx                      
F000:907A  e2fb           loop   0x9077                  
F000:907C  807c2e02       cmp    byte ptr [si + 0x2e], 2 
F000:9080  7508           jne    0x908a                  
F000:9082  e8dafb         call   0x8c5f                   ; "PSQR"
F000:9085  e833fb         call   0x8bbb                  
F000:9088  fa             cli                            
F000:9089  f4             hlt                            
F000:908A  fe442e         inc    byte ptr [si + 0x2e]    
F000:908D  e827fb         call   0x8bb7                  
F000:9090  c3             ret                            

;----- sub_9091 -----
F000:9091  60             pushaw                         
F000:9092  80fc01         cmp    ah, 1                   
F000:9095  0f840600       je     0x909f                  
F000:9099  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:909B  0f850a00       jne    0x90a9                  
F000:909F  ba0100         mov    dx, 1                   
F000:90A2  e82ac3         call   0x53cf                  
F000:90A5  f9             stc                            
F000:90A6  eb02           jmp    0x90aa                  
F000:90A9  f8             clc                            
F000:90AA  61             popaw                          
F000:90AB  c3             ret                            

;----- sub_90AC -----
F000:90AC  e81b00         call   0x90ca                  
F000:90AF  e83efb         call   0x8bf0                  
F000:90B2  c3             ret                            

;----- sub_90CA -----
F000:90CA  50             push   ax                      
F000:90CB  b07b           mov    al, 0x7b                
F000:90CD  e8c058         call   0xe990                  
F000:90D0  0c02           or     al, 2                   
F000:90D2  8ae0           mov    ah, al                  
F000:90D4  b07b           mov    al, 0x7b                
F000:90D6  e8ed58         call   0xe9c6                  
F000:90D9  58             pop    ax                      
F000:90DA  c3             ret                            

;----- sub_90FC -----
F000:90FC  50             push   ax                      
F000:90FD  b07b           mov    al, 0x7b                
F000:90FF  e88e58         call   0xe990                  
F000:9102  a802           test   al, 2                   
F000:9104  58             pop    ax                      
F000:9105  c3             ret                            

;----- sub_9106 -----
F000:9106  53             push   bx                      
F000:9107  bb7c5d         mov    bx, 0x5d7c              
F000:910A  e8cafe         call   0x8fd7                  
F000:910D  7403           je     0x9112                  
F000:910F  bb825d         mov    bx, 0x5d82              
F000:9112  ffd3           call   bx                      
F000:9114  5b             pop    bx                      
F000:9115  c3             ret                            

;----- sub_9116 -----
F000:9116  b0fb           mov    al, 0xfb                
F000:9118  e87558         call   0xe990                  
F000:911B  24f6           and    al, 0xf6                
F000:911D  8ae0           mov    ah, al                  
F000:911F  b0fb           mov    al, 0xfb                
F000:9121  e8a258         call   0xe9c6                  
F000:9124  c3             ret                            

;----- sub_9125 -----
F000:9125  e82800         call   0x9150                  
F000:9128  fa             cli                            
F000:9129  e8d358         call   0xe9ff                  
F000:912C  56             push   si                      
F000:912D  be1e00         mov    si, 0x1e                
F000:9130  c7040000       mov    word ptr [si], 0         ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:9134  83c602         add    si, 2                   
F000:9137  81fe3e00       cmp    si, 0x3e                
F000:913B  75f3           jne    0x9130                  
F000:913D  e822d5         call   0x6662                  
F000:9140  5e             pop    si                      
F000:9141  fb             sti                            
F000:9142  c3             ret                            

;----- sub_9143 -----
F000:9143  5b             pop    bx                      
F000:9144  83ec6f         sub    sp, 0x6f                
F000:9147  8bf4           mov    si, sp                  
F000:9149  16             push   ss                      
F000:914A  1f             pop    ds                      
F000:914B  53             push   bx                      
F000:914C  e80100         call   0x9150                  
F000:914F  c3             ret                            

;----- sub_9150 -----
F000:9150  b96f00         mov    cx, 0x6f                
F000:9153  33db           xor    bx, bx                  
F000:9155  c60000         mov    byte ptr [bx + si], 0    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:9158  43             inc    bx                      
F000:9159  e2fa           loop   0x9155                  
F000:915B  c3             ret                            

;----- sub_915C -----
F000:915C  e8a058         call   0xe9ff                  
F000:915F  2ae4           sub    ah, ah                  
F000:9161  a04900         mov    al, byte ptr [0x49]     
F000:9164  cd10           int    0x10                     ; BIOS service
F000:9166  c3             ret                            

;----- sub_9167 -----
F000:9167  60             pushaw                         
F000:9168  b90700         mov    cx, 7                   
F000:916B  b4b8           mov    ah, 0xb8                
F000:916D  2ad2           sub    dl, dl                  
F000:916F  8ac4           mov    al, ah                  
F000:9171  e81c58         call   0xe990                  
F000:9174  247f           and    al, 0x7f                
F000:9176  0ac0           or     al, al                  
F000:9178  0f840600       je     0x9182                  
F000:917C  02d0           add    dl, al                  
F000:917E  fec4           inc    ah                      
F000:9180  e2ed           loop   0x916f                  
F000:9182  80fcb8         cmp    ah, 0xb8                
F000:9185  0f840d00       je     0x9196                  
F000:9189  b0bf           mov    al, 0xbf                
F000:918B  e80258         call   0xe990                  
F000:918E  3ac2           cmp    al, dl                  
F000:9190  f8             clc                            
F000:9191  0f850100       jne    0x9196                  
F000:9195  f9             stc                            
F000:9196  61             popaw                          
F000:9197  c3             ret                            

;----- sub_9198 -----
F000:9198  f8             clc                            
F000:9199  eb02           jmp    0x919d                  

;----- sub_919C -----
F000:919C  f9             stc                            
F000:919D  60             pushaw                         
F000:919E  1e             push   ds                      
F000:919F  9f             lahf                           
F000:91A0  e85c58         call   0xe9ff                  
F000:91A3  8b166300       mov    dx, word ptr [0x63]     
F000:91A7  b00a           mov    al, 0xa                 
F000:91A9  ee             out    dx, al                  
F000:91AA  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:91AC  42             inc    dx                      
F000:91AD  ec             in     al, dx                  
F000:91AE  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:91B0  24df           and    al, 0xdf                
F000:91B2  9e             sahf                           
F000:91B3  0f830200       jae    0x91b9                  
F000:91B7  0c20           or     al, 0x20                
F000:91B9  ee             out    dx, al                  
F000:91BA  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:91BC  1f             pop    ds                      
F000:91BD  61             popaw                          
F000:91BE  c3             ret                            

;----- sub_94D9 -----
F000:94D9  6650           push   eax                     
F000:94DB  52             push   dx                      
F000:94DC  06             push   es                      
F000:94DD  1e             push   ds                      
F000:94DE  57             push   di                      
F000:94DF  9c             pushf                          
F000:94E0  fa             cli                            
F000:94E1  e8e408         call   0x9dc8                  
F000:94E4  0f821f00       jb     0x9507                  
F000:94E8  06             push   es                      
F000:94E9  1f             pop    ds                      
F000:94EA  803e990080     cmp    byte ptr [0x99], 0x80   
F000:94EF  7216           jb     0x9507                  
F000:94F1  33c0           xor    ax, ax                  
F000:94F3  8ec0           mov    es, ax                  
F000:94F5  bf4c00         mov    di, 0x4c                
F000:94F8  66a19300       mov    eax, dword ptr [0x93]   
F000:94FC  26668905       mov    dword ptr es:[di], eax  
F000:9500  e8fd07         call   0x9d00                  
F000:9503  fe0e7500       dec    byte ptr [0x75]         
F000:9507  9d             popf                           
F000:9508  5f             pop    di                      
F000:9509  1f             pop    ds                      
F000:950A  07             pop    es                      
F000:950B  5a             pop    dx                      
F000:950C  6658           pop    eax                     
F000:950E  c3             ret                            

;----- sub_951C -----
F000:951C  06             push   es                      
F000:951D  e8a808         call   0x9dc8                  
F000:9520  268a169900     mov    dl, byte ptr es:[0x99]  
F000:9525  80fa80         cmp    dl, 0x80                
F000:9528  07             pop    es                      
F000:9529  c3             ret                            

;----- sub_9D00 -----
F000:9D00  e9fc4c         jmp    0xe9ff                  

;----- sub_9DC8 -----
F000:9DC8  50             push   ax                      
F000:9DC9  51             push   cx                      
F000:9DCA  57             push   di                      
F000:9DCB  9c             pushf                          
F000:9DCC  fa             cli                            
F000:9DCD  1e             push   ds                      
F000:9DCE  e82fff         call   0x9d00                  
F000:9DD1  a10e00         mov    ax, word ptr [0xe]      
F000:9DD4  8ec0           mov    es, ax                  
F000:9DD6  1f             pop    ds                      
F000:9DD7  33ff           xor    di, di                  
F000:9DD9  33c9           xor    cx, cx                  
F000:9DDB  268a2d         mov    ch, byte ptr es:[di]    
F000:9DDE  c1e102         shl    cx, 2                   
F000:9DE1  bf8001         mov    di, 0x180               
F000:9DE4  3bf9           cmp    di, cx                  
F000:9DE6  7320           jae    0x9e08                  
F000:9DE8  26833d00       cmp    word ptr es:[di], 0      ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:9DEC  741a           je     0x9e08                  
F000:9DEE  26817d02daef   cmp    word ptr es:[di + 2], 0xefda
F000:9DF4  7405           je     0x9dfb                  
F000:9DF6  268b3d         mov    di, word ptr es:[di]    
F000:9DF9  ebe9           jmp    0x9de4                  
F000:9DFB  c1ef04         shr    di, 4                   
F000:9DFE  8cc0           mov    ax, es                  
F000:9E00  03c7           add    ax, di                  
F000:9E02  8ec0           mov    es, ax                  
F000:9E04  9d             popf                           
F000:9E05  f8             clc                            
F000:9E06  eb02           jmp    0x9e0a                  
F000:9E08  9d             popf                           
F000:9E09  f9             stc                            
F000:9E0A  5f             pop    di                      
F000:9E0B  59             pop    cx                      
F000:9E0C  58             pop    ax                      
F000:9E0D  c3             ret                            
F000:9E0E  fb             sti                            
F000:9E0F  80fc0c         cmp    ah, 0xc                 
F000:9E12  90             nop                            
F000:9E13  f5             cmc                            
F000:9E14  7217           jb     0x9e2d                  
F000:9E16  1e             push   ds                      
F000:9E17  e8e54b         call   0xe9ff                  
F000:9E1A  56             push   si                      
F000:9E1B  c1e808         shr    ax, 8                   
F000:9E1E  03c0           add    ax, ax                  
F000:9E20  8bf0           mov    si, ax                  
F000:9E22  fa             cli                            
F000:9E23  2eff94309e     call   word ptr cs:[si - 0x61d0]
F000:9E28  fb             sti                            
F000:9E29  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:9E2B  5e             pop    si                      
F000:9E2C  1f             pop    ds                      
F000:9E2D  ca0200         retf   2                       
F000:A14E  fb             sti                            
F000:A14F  1e             push   ds                      
F000:A150  52             push   dx                      
F000:A151  56             push   si                      
F000:A152  57             push   di                      
F000:A153  51             push   cx                      
F000:A154  53             push   bx                      
F000:A155  83fa04         cmp    dx, 4                   
F000:A158  7321           jae    0xa17b                   ; "[Y_^Z"
F000:A15A  80fc06         cmp    ah, 6                   
F000:A15D  731c           jae    0xa17b                   ; "[Y_^Z"
F000:A15F  8bf2           mov    si, dx                  
F000:A161  8bfa           mov    di, dx                  
F000:A163  e89948         call   0xe9ff                  
F000:A166  d1e6           shl    si, 1                   
F000:A168  8b940000       mov    dx, word ptr [si]       
F000:A16C  0bd2           or     dx, dx                  
F000:A16E  740b           je     0xa17b                   ; "[Y_^Z"
F000:A170  8adc           mov    bl, ah                  
F000:A172  32ff           xor    bh, bh                  
F000:A174  d1e3           shl    bx, 1                   
F000:A176  2effa742a1     jmp    word ptr cs:[bx - 0x5ebe]
F000:A17B  5b             pop    bx                      
F000:A17C  59             pop    cx                      
F000:A17D  5f             pop    di                      
F000:A17E  5e             pop    si                      
F000:A17F  5a             pop    dx                      
F000:A180  1f             pop    ds                      
F000:A181  cf             iret                           
F000:AD9B  80fca2         cmp    ah, 0xa2                
F000:AD9E  7503           jne    0xada3                  
F000:ADA0  80ec10         sub    ah, 0x10                
F000:ADA3  80ec12         sub    ah, 0x12                
F000:ADA6  eb20           jmp    0xadc8                   ; "Y]Y["
F000:ADA8  fb             sti                            
F000:ADA9  56             push   si                      
F000:ADAA  1e             push   ds                      
F000:ADAB  53             push   bx                      
F000:ADAC  51             push   cx                      
F000:ADAD  55             push   bp                      
F000:ADAE  6a00           push   0                        ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:ADB0  8bec           mov    bp, sp                  
F000:ADB2  e84a3c         call   0xe9ff                  
F000:ADB5  80fc22         cmp    ah, 0x22                
F000:ADB8  77e1           ja     0xad9b                  
F000:ADBA  8bf0           mov    si, ax                  
F000:ADBC  81e600ff       and    si, 0xff00              
F000:ADC0  c1ee07         shr    si, 7                   
F000:ADC3  2effa455ad     jmp    word ptr cs:[si - 0x52ab]
F000:ADC8  59             pop    cx                      
F000:ADC9  5d             pop    bp                      
F000:ADCA  59             pop    cx                      
F000:ADCB  5b             pop    bx                      
F000:ADCC  1f             pop    ds                      
F000:ADCD  5e             pop    si                      
F000:ADCE  cf             iret                           

;----- sub_AF81 -----
F000:AF81  43             inc    bx                      
F000:AF82  43             inc    bx                      
F000:AF83  3b1e8200       cmp    bx, word ptr [0x82]     
F000:AF87  7504           jne    0xaf8d                  
F000:AF89  8b1e8000       mov    bx, word ptr [0x80]     
F000:AF8D  c3             ret                            
F000:AF8E  55             push   bp                      
F000:AF8F  50             push   ax                      
F000:AF90  53             push   bx                      
F000:AF91  51             push   cx                      
F000:AF92  52             push   dx                      
F000:AF93  56             push   si                      
F000:AF94  57             push   di                      
F000:AF95  1e             push   ds                      
F000:AF96  06             push   es                      
F000:AF97  680080         push   0x8000                  
F000:AF9A  8bec           mov    bp, sp                  
F000:AF9C  fc             cld                            
F000:AF9D  e85f3a         call   0xe9ff                  
F000:AFA0  b0ad           mov    al, 0xad                
F000:AFA2  e84405         call   0xb4e9                  
F000:AFA5  e460           in     al, 0x60                 ; KBC data
F000:AFA7  fb             sti                            
F000:AFA8  e8d705         call   0xb582                  
F000:AFAB  3caa           cmp    al, 0xaa                
F000:AFAD  7556           jne    0xb005                  
F000:AFAF  f606960002     test   byte ptr [0x96], 2      
F000:AFB4  754f           jne    0xb005                  
F000:AFB6  f606170002     test   byte ptr [0x17], 2      
F000:AFBB  7548           jne    0xb005                  
F000:AFBD  eb46           jmp    0xb005                  
F000:B005  b44f           mov    ah, 0x4f                
F000:B007  f9             stc                            
F000:B008  cd15           int    0x15                     ; BIOS service
F000:B00A  7203           jb     0xb00f                  
F000:B00C  e90c02         jmp    0xb21b                  
F000:B00F  fb             sti                            
F000:B010  3cfe           cmp    al, 0xfe                
F000:B012  740d           je     0xb021                  
F000:B014  3cfa           cmp    al, 0xfa                
F000:B016  7512           jne    0xb02a                  
F000:B018  fa             cli                            
F000:B019  800e970010     or     byte ptr [0x97], 0x10   
F000:B01E  e9fa01         jmp    0xb21b                  
F000:B021  fa             cli                            
F000:B022  800e970020     or     byte ptr [0x97], 0x20   
F000:B027  e9f101         jmp    0xb21b                  
F000:B02A  50             push   ax                      
F000:B02B  e84605         call   0xb574                  
F000:B02E  8a1e9700       mov    bl, byte ptr [0x97]     
F000:B032  32d8           xor    bl, al                  
F000:B034  80e307         and    bl, 7                   
F000:B037  7403           je     0xb03c                  
F000:B039  e8f704         call   0xb533                  
F000:B03C  58             pop    ax                      
F000:B03D  8ae0           mov    ah, al                  
F000:B03F  3cff           cmp    al, 0xff                
F000:B041  7503           jne    0xb046                  
F000:B043  e99404         jmp    0xb4da                  
F000:B046  0e             push   cs                      
F000:B047  07             pop    es                      
F000:B048  8a3e9600       mov    bh, byte ptr [0x96]     
F000:B04C  f6c7c0         test   bh, 0xc0                
F000:B04F  7444           je     0xb095                  
F000:B051  7910           jns    0xb063                  
F000:B053  3cab           cmp    al, 0xab                
F000:B055  7505           jne    0xb05c                  
F000:B057  800e960040     or     byte ptr [0x96], 0x40   
F000:B05C  802696007f     and    byte ptr [0x96], 0x7f   
F000:B061  eb2f           jmp    0xb092                  
F000:B063  80269600bf     and    byte ptr [0x96], 0xbf   
F000:B068  3c54           cmp    al, 0x54                
F000:B06A  7421           je     0xb08d                  
F000:B06C  3c41           cmp    al, 0x41                
F000:B06E  7410           je     0xb080                  
F000:B070  3c86           cmp    al, 0x86                
F000:B072  740c           je     0xb080                  
F000:B074  3c91           cmp    al, 0x91                
F000:B076  7415           je     0xb08d                  
F000:B078  3c90           cmp    al, 0x90                
F000:B07A  7404           je     0xb080                  
F000:B07C  3c92           cmp    al, 0x92                
F000:B07E  7512           jne    0xb092                  
F000:B080  f6c720         test   bh, 0x20                
F000:B083  7408           je     0xb08d                  
F000:B085  800e170020     or     byte ptr [0x17], 0x20   
F000:B08A  e8a604         call   0xb533                  
F000:B08D  800e960010     or     byte ptr [0x96], 0x10   
F000:B092  e98601         jmp    0xb21b                  
F000:B095  3ce0           cmp    al, 0xe0                
F000:B097  7507           jne    0xb0a0                  
F000:B099  800e960012     or     byte ptr [0x96], 0x12   
F000:B09E  eb09           jmp    0xb0a9                  
F000:B0A0  3ce1           cmp    al, 0xe1                
F000:B0A2  7508           jne    0xb0ac                  
F000:B0A4  800e960011     or     byte ptr [0x96], 0x11   
F000:B0A9  e97401         jmp    0xb220                  
F000:B0AC  247f           and    al, 0x7f                
F000:B0AE  f6c702         test   bh, 2                   
F000:B0B1  740c           je     0xb0bf                  
F000:B0B3  b90200         mov    cx, 2                   
F000:B0B6  bfd1ab         mov    di, 0xabd1              
F000:B0B9  f2ae           repne scasb al, byte ptr es:[di]    
F000:B0BB  7562           jne    0xb11f                  
F000:B0BD  eb48           jmp    0xb107                  
F000:B0BF  f6c701         test   bh, 1                   
F000:B0C2  741d           je     0xb0e1                   ; "<Tu:"
F000:B0C4  b90400         mov    cx, 4                   
F000:B0C7  bfcfab         mov    di, 0xabcf              
F000:B0CA  f2ae           repne scasb al, byte ptr es:[di]    
F000:B0CC  74db           je     0xb0a9                  
F000:B0CE  3c45           cmp    al, 0x45                
F000:B0D0  7535           jne    0xb107                  
F000:B0D2  f6c480         test   ah, 0x80                
F000:B0D5  7530           jne    0xb107                  
F000:B0D7  f606180008     test   byte ptr [0x18], 8      
F000:B0DC  7529           jne    0xb107                  
F000:B0DE  e9a402         jmp    0xb385                  
F000:B0E1  3c54           cmp    al, 0x54                
F000:B0E3  753a           jne    0xb11f                  
F000:B0E5  f6c480         test   ah, 0x80                
F000:B0E8  fa             cli                            
F000:B0E9  751f           jne    0xb10a                  
F000:B0EB  f606180004     test   byte ptr [0x18], 4      
F000:B0F0  7515           jne    0xb107                  
F000:B0F2  800e180004     or     byte ptr [0x18], 4      
F000:B0F7  e89e04         call   0xb598                  
F000:B0FA  b0ae           mov    al, 0xae                
F000:B0FC  e8ea03         call   0xb4e9                  
F000:B0FF  b80085         mov    ax, 0x8500              
F000:B102  cd15           int    0x15                     ; BIOS service
F000:B104  e92201         jmp    0xb229                  
F000:B107  e91101         jmp    0xb21b                  
F000:B10A  80261800fb     and    byte ptr [0x18], 0xfb   
F000:B10F  e88604         call   0xb598                  
F000:B112  b0ae           mov    al, 0xae                
F000:B114  e8d203         call   0xb4e9                  
F000:B117  b80185         mov    ax, 0x8501              
F000:B11A  cd15           int    0x15                     ; BIOS service
F000:B11C  e90a01         jmp    0xb229                  
F000:B11F  8a1e1700       mov    bl, byte ptr [0x17]     
F000:B123  bfcbab         mov    di, 0xabcb              
F000:B126  b90800         mov    cx, 8                   
F000:B129  f2ae           repne scasb al, byte ptr es:[di]    
F000:B12B  8ac4           mov    al, ah                  
F000:B12D  7403           je     0xb132                  
F000:B12F  e9d500         jmp    0xb207                  
F000:B132  81efccab       sub    di, 0xabcc              
F000:B136  2e8aa5d3ab     mov    ah, byte ptr cs:[di - 0x542d]
F000:B13B  b102           mov    cl, 2                   
F000:B13D  a880           test   al, 0x80                
F000:B13F  7402           je     0xb143                  
F000:B141  eb74           jmp    0xb1b7                  
F000:B143  80fc10         cmp    ah, 0x10                
F000:B146  7321           jae    0xb169                  
F000:B148  08261700       or     byte ptr [0x17], ah     
F000:B14C  f6c40c         test   ah, 0xc                 
F000:B14F  7503           jne    0xb154                  
F000:B151  e9c700         jmp    0xb21b                  
F000:B154  f6c702         test   bh, 2                   
F000:B157  7407           je     0xb160                  
F000:B159  08269600       or     byte ptr [0x96], ah     
F000:B15D  e9bb00         jmp    0xb21b                  
F000:B160  d2ec           shr    ah, cl                  
F000:B162  08261800       or     byte ptr [0x18], ah     
F000:B166  e9b200         jmp    0xb21b                  
F000:B169  f6c304         test   bl, 4                   
F000:B16C  7403           je     0xb171                   ; "<Ru "
F000:B16E  e99600         jmp    0xb207                  
F000:B171  3c52           cmp    al, 0x52                
F000:B173  7520           jne    0xb195                  
F000:B175  f6c308         test   bl, 8                   
F000:B178  7403           je     0xb17d                  
F000:B17A  e98a00         jmp    0xb207                  
F000:B17D  f6c702         test   bh, 2                   
F000:B180  7513           jne    0xb195                  
F000:B182  f6c320         test   bl, 0x20                
F000:B185  7509           jne    0xb190                  
F000:B187  f6c303         test   bl, 3                   
F000:B18A  7409           je     0xb195                  
F000:B18C  8ae0           mov    ah, al                  
F000:B18E  eb77           jmp    0xb207                  
F000:B190  f6c303         test   bl, 3                   
F000:B193  74f7           je     0xb18c                  
F000:B195  84261800       test   byte ptr [0x18], ah     
F000:B199  7402           je     0xb19d                  
F000:B19B  eb7e           jmp    0xb21b                  
F000:B19D  08261800       or     byte ptr [0x18], ah     
F000:B1A1  30261700       xor    byte ptr [0x17], ah     
F000:B1A5  f6c470         test   ah, 0x70                
F000:B1A8  7405           je     0xb1af                  
F000:B1AA  50             push   ax                      
F000:B1AB  e88503         call   0xb533                  
F000:B1AE  58             pop    ax                      
F000:B1AF  3c52           cmp    al, 0x52                
F000:B1B1  7568           jne    0xb21b                  
F000:B1B3  8ae0           mov    ah, al                  
F000:B1B5  eb7e           jmp    0xb235                  
F000:B1B7  80fc10         cmp    ah, 0x10                
F000:B1BA  f6d4           not    ah                      
F000:B1BC  7343           jae    0xb201                  
F000:B1BE  20261700       and    byte ptr [0x17], ah     
F000:B1C2  80fcfb         cmp    ah, 0xfb                
F000:B1C5  7726           ja     0xb1ed                  
F000:B1C7  f6c702         test   bh, 2                   
F000:B1CA  7406           je     0xb1d2                  
F000:B1CC  20269600       and    byte ptr [0x96], ah     
F000:B1D0  eb06           jmp    0xb1d8                  
F000:B1D2  d2fc           sar    ah, cl                  
F000:B1D4  20261800       and    byte ptr [0x18], ah     
F000:B1D8  8ae0           mov    ah, al                  
F000:B1DA  a09600         mov    al, byte ptr [0x96]     
F000:B1DD  d2e8           shr    al, cl                  
F000:B1DF  0a061800       or     al, byte ptr [0x18]     
F000:B1E3  d2e0           shl    al, cl                  
F000:B1E5  240c           and    al, 0xc                 
F000:B1E7  08061700       or     byte ptr [0x17], al     
F000:B1EB  8ac4           mov    al, ah                  
F000:B1ED  3cb8           cmp    al, 0xb8                
F000:B1EF  752a           jne    0xb21b                  
F000:B1F1  a01900         mov    al, byte ptr [0x19]     
F000:B1F4  b400           mov    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:B1F6  88261900       mov    byte ptr [0x19], ah     
F000:B1FA  3c00           cmp    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:B1FC  741d           je     0xb21b                  
F000:B1FE  e9ac02         jmp    0xb4ad                  
F000:B201  20261800       and    byte ptr [0x18], ah     
F000:B205  eb14           jmp    0xb21b                  
F000:B207  3c80           cmp    al, 0x80                
F000:B209  7310           jae    0xb21b                  
F000:B20B  f606180008     test   byte ptr [0x18], 8      
F000:B210  7423           je     0xb235                  
F000:B212  3c45           cmp    al, 0x45                
F000:B214  7405           je     0xb21b                  
F000:B216  80261800f7     and    byte ptr [0x18], 0xf7   
F000:B21B  80269600fc     and    byte ptr [0x96], 0xfc   
F000:B220  fa             cli                            
F000:B221  e87403         call   0xb598                  
F000:B224  b0ae           mov    al, 0xae                
F000:B226  e8c002         call   0xb4e9                  
F000:B229  fa             cli                            
F000:B22A  58             pop    ax                      
F000:B22B  07             pop    es                      
F000:B22C  1f             pop    ds                      
F000:B22D  5f             pop    di                      
F000:B22E  5e             pop    si                      
F000:B22F  5a             pop    dx                      
F000:B230  59             pop    cx                      
F000:B231  5b             pop    bx                      
F000:B232  58             pop    ax                      
F000:B233  5d             pop    bp                      
F000:B234  cf             iret                           
F000:B235  3c7e           cmp    al, 0x7e                
F000:B237  77e2           ja     0xb21b                  
F000:B239  f6c308         test   bl, 8                   
F000:B23C  740c           je     0xb24a                  
F000:B23E  f6c710         test   bh, 0x10                
F000:B241  740a           je     0xb24d                  
F000:B243  f606180004     test   byte ptr [0x18], 4      
F000:B248  7403           je     0xb24d                  
F000:B24A  e90001         jmp    0xb34d                  
F000:B24D  f6c304         test   bl, 4                   
F000:B250  740f           je     0xb261                  
F000:B252  3c53           cmp    al, 0x53                
F000:B254  750b           jne    0xb261                  
F000:B256  c70672003412   mov    word ptr [0x72], 0x1234 
F000:B25C  ea0000ffff     ljmp   0xffff:0                 ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:B261  eb50           jmp    0xb2b3                  
F000:B2B3  3c39           cmp    al, 0x39                
F000:B2B5  7505           jne    0xb2bc                  
F000:B2B7  b020           mov    al, 0x20                
F000:B2B9  e9e501         jmp    0xb4a1                  
F000:B2BC  3c0f           cmp    al, 0xf                 
F000:B2BE  7506           jne    0xb2c6                   ; "<Jtx<Ntt"
F000:B2C0  b800a5         mov    ax, 0xa500              
F000:B2C3  e9db01         jmp    0xb4a1                  
F000:B2C6  3c4a           cmp    al, 0x4a                
F000:B2C8  7478           je     0xb342                  
F000:B2CA  3c4e           cmp    al, 0x4e                
F000:B2CC  7474           je     0xb342                  
F000:B2CE  bf63b2         mov    di, 0xb263              
F000:B2D1  b90a00         mov    cx, 0xa                 
F000:B2D4  f2ae           repne scasb al, byte ptr es:[di]    
F000:B2D6  7518           jne    0xb2f0                  
F000:B2D8  f6c702         test   bh, 2                   
F000:B2DB  756a           jne    0xb347                  
F000:B2DD  81ef64b2       sub    di, 0xb264              
F000:B2E1  a01900         mov    al, byte ptr [0x19]     
F000:B2E4  b40a           mov    ah, 0xa                 
F000:B2E6  f6e4           mul    ah                      
F000:B2E8  03c7           add    ax, di                  
F000:B2EA  a21900         mov    byte ptr [0x19], al     
F000:B2ED  e92bff         jmp    0xb21b                  
F000:B2F0  c606190000     mov    byte ptr [0x19], 0       ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:B2F5  b91a00         mov    cx, 0x1a                
F000:B2F8  f2ae           repne scasb al, byte ptr es:[di]    
F000:B2FA  7441           je     0xb33d                  
F000:B2FC  3c02           cmp    al, 2                   
F000:B2FE  7242           jb     0xb342                  
F000:B300  3c0d           cmp    al, 0xd                 
F000:B302  7705           ja     0xb309                  
F000:B304  80c476         add    ah, 0x76                
F000:B307  eb34           jmp    0xb33d                  
F000:B309  3c57           cmp    al, 0x57                
F000:B30B  7208           jb     0xb315                  
F000:B30D  2c52           sub    al, 0x52                
F000:B30F  bb87b2         mov    bx, 0xb287              
F000:B312  e97b01         jmp    0xb490                  
F000:B315  f6c702         test   bh, 2                   
F000:B318  7418           je     0xb332                  
F000:B31A  3c1c           cmp    al, 0x1c                
F000:B31C  7506           jne    0xb324                  
F000:B31E  b800a6         mov    ax, 0xa600              
F000:B321  e97d01         jmp    0xb4a1                  
F000:B324  3c53           cmp    al, 0x53                
F000:B326  741f           je     0xb347                  
F000:B328  3c35           cmp    al, 0x35                
F000:B32A  75c1           jne    0xb2ed                  
F000:B32C  b800a4         mov    ax, 0xa400              
F000:B32F  e96f01         jmp    0xb4a1                  
F000:B332  3c3b           cmp    al, 0x3b                
F000:B334  720c           jb     0xb342                  
F000:B336  3c44           cmp    al, 0x44                
F000:B338  77b3           ja     0xb2ed                  
F000:B33A  80c42d         add    ah, 0x2d                
F000:B33D  b000           mov    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:B33F  e95f01         jmp    0xb4a1                  
F000:B342  b0f0           mov    al, 0xf0                
F000:B344  e95a01         jmp    0xb4a1                  
F000:B347  0450           add    al, 0x50                
F000:B349  8ae0           mov    ah, al                  
F000:B34B  ebf0           jmp    0xb33d                  
F000:B34D  f6c304         test   bl, 4                   
F000:B350  7503           jne    0xb355                   ; "<Fu#"
F000:B352  e98d00         jmp    0xb3e2                   ; "<7u&"
F000:B355  3c46           cmp    al, 0x46                
F000:B357  7523           jne    0xb37c                  
F000:B359  f6c710         test   bh, 0x10                
F000:B35C  7405           je     0xb363                  
F000:B35E  f6c702         test   bh, 2                   
F000:B361  7419           je     0xb37c                  
F000:B363  8b1e1a00       mov    bx, word ptr [0x1a]     
F000:B367  891e1c00       mov    word ptr [0x1c], bx     
F000:B36B  c606710080     mov    byte ptr [0x71], 0x80   
F000:B370  b0ae           mov    al, 0xae                
F000:B372  e87401         call   0xb4e9                  
F000:B375  cd1b           int    0x1b                     ; BIOS service
F000:B377  2bc0           sub    ax, ax                  
F000:B379  e92501         jmp    0xb4a1                  
F000:B37C  f6c710         test   bh, 0x10                
F000:B37F  752d           jne    0xb3ae                  
F000:B381  3c45           cmp    al, 0x45                
F000:B383  7529           jne    0xb3ae                  
F000:B385  800e180008     or     byte ptr [0x18], 8      
F000:B38A  b0ae           mov    al, 0xae                
F000:B38C  e85a01         call   0xb4e9                  
F000:B38F  e80602         call   0xb598                  
F000:B392  b96400         mov    cx, 0x64                
F000:B395  f606180008     test   byte ptr [0x18], 8      
F000:B39A  740a           je     0xb3a6                  
F000:B39C  e464           in     al, 0x64                 ; KBC cmd/sts
F000:B39E  2421           and    al, 0x21                
F000:B3A0  3c21           cmp    al, 0x21                
F000:B3A2  e1f1           loope  0xb395                  
F000:B3A4  75ec           jne    0xb392                  
F000:B3A6  80261800f7     and    byte ptr [0x18], 0xf7   
F000:B3AB  e97bfe         jmp    0xb229                  
F000:B3AE  3c37           cmp    al, 0x37                
F000:B3B0  7510           jne    0xb3c2                  
F000:B3B2  f6c710         test   bh, 0x10                
F000:B3B5  7405           je     0xb3bc                  
F000:B3B7  f6c702         test   bh, 2                   
F000:B3BA  7420           je     0xb3dc                  
F000:B3BC  b80072         mov    ax, 0x7200              
F000:B3BF  e9df00         jmp    0xb4a1                  
F000:B3C2  3c0f           cmp    al, 0xf                 
F000:B3C4  7416           je     0xb3dc                  
F000:B3C6  3c35           cmp    al, 0x35                
F000:B3C8  750b           jne    0xb3d5                  
F000:B3CA  f6c702         test   bh, 2                   
F000:B3CD  7406           je     0xb3d5                  
F000:B3CF  b80095         mov    ax, 0x9500              
F000:B3D2  e9cc00         jmp    0xb4a1                  
F000:B3D5  bbdbab         mov    bx, 0xabdb              
F000:B3D8  3c3b           cmp    al, 0x3b                
F000:B3DA  725e           jb     0xb43a                  
F000:B3DC  bbdbab         mov    bx, 0xabdb              
F000:B3DF  e9ae00         jmp    0xb490                  
F000:B3E2  3c37           cmp    al, 0x37                
F000:B3E4  7526           jne    0xb40c                   ; "<:w,<5u"
F000:B3E6  f6c710         test   bh, 0x10                
F000:B3E9  7407           je     0xb3f2                  
F000:B3EB  f6c702         test   bh, 2                   
F000:B3EE  7507           jne    0xb3f7                  
F000:B3F0  eb3b           jmp    0xb42d                  
F000:B3F2  f6c303         test   bl, 3                   
F000:B3F5  7436           je     0xb42d                  
F000:B3F7  fa             cli                            
F000:B3F8  80269600fc     and    byte ptr [0x96], 0xfc   
F000:B3FD  e89801         call   0xb598                  
F000:B400  b0ae           mov    al, 0xae                
F000:B402  e8e400         call   0xb4e9                  
F000:B405  55             push   bp                      
F000:B406  cd05           int    5                        ; BIOS service
F000:B408  5d             pop    bp                      
F000:B409  e91dfe         jmp    0xb229                  
F000:B40C  3c3a           cmp    al, 0x3a                
F000:B40E  772c           ja     0xb43c                  
F000:B410  3c35           cmp    al, 0x35                
F000:B412  7505           jne    0xb419                  
F000:B414  f6c702         test   bh, 2                   
F000:B417  7514           jne    0xb42d                  
F000:B419  b91a00         mov    cx, 0x1a                
F000:B41C  bf6db2         mov    di, 0xb26d              
F000:B41F  f2ae           repne scasb al, byte ptr es:[di]    
F000:B421  7505           jne    0xb428                  
F000:B423  f6c340         test   bl, 0x40                
F000:B426  750a           jne    0xb432                  
F000:B428  f6c303         test   bl, 3                   
F000:B42B  750a           jne    0xb437                  
F000:B42D  bb59ac         mov    bx, 0xac59              
F000:B430  eb4f           jmp    0xb481                  
F000:B432  f6c303         test   bl, 3                   
F000:B435  75f6           jne    0xb42d                  
F000:B437  bbd7ac         mov    bx, 0xacd7              
F000:B43A  eb45           jmp    0xb481                  
F000:B43C  3c44           cmp    al, 0x44                
F000:B43E  7702           ja     0xb442                  
F000:B440  eb35           jmp    0xb477                  
F000:B442  3c53           cmp    al, 0x53                
F000:B444  772b           ja     0xb471                  
F000:B446  3c4a           cmp    al, 0x4a                
F000:B448  74ed           je     0xb437                  
F000:B44A  3c4e           cmp    al, 0x4e                
F000:B44C  74e9           je     0xb437                  
F000:B44E  f6c702         test   bh, 2                   
F000:B451  750a           jne    0xb45d                  
F000:B453  f6c320         test   bl, 0x20                
F000:B456  7512           jne    0xb46a                  
F000:B458  f6c303         test   bl, 3                   
F000:B45B  7512           jne    0xb46f                  
F000:B45D  3c4c           cmp    al, 0x4c                
F000:B45F  7504           jne    0xb465                  
F000:B461  b0f0           mov    al, 0xf0                
F000:B463  eb3c           jmp    0xb4a1                  
F000:B465  bb59ac         mov    bx, 0xac59              
F000:B468  eb26           jmp    0xb490                  
F000:B46A  f6c303         test   bl, 3                   
F000:B46D  75ee           jne    0xb45d                  
F000:B46F  ebc6           jmp    0xb437                  
F000:B471  3c56           cmp    al, 0x56                
F000:B473  7502           jne    0xb477                  
F000:B475  ebb1           jmp    0xb428                  
F000:B477  f6c303         test   bl, 3                   
F000:B47A  74e1           je     0xb45d                  
F000:B47C  bbd7ac         mov    bx, 0xacd7              
F000:B47F  eb0f           jmp    0xb490                  
F000:B481  fec8           dec    al                      
F000:B483  2ed7           xlatb                          
F000:B485  f606960002     test   byte ptr [0x96], 2      
F000:B48A  7415           je     0xb4a1                  
F000:B48C  b4e0           mov    ah, 0xe0                
F000:B48E  eb11           jmp    0xb4a1                  
F000:B490  fec8           dec    al                      
F000:B492  2ed7           xlatb                          
F000:B494  8ae0           mov    ah, al                  
F000:B496  b000           mov    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:B498  f606960002     test   byte ptr [0x96], 2      
F000:B49D  7402           je     0xb4a1                  
F000:B49F  b0e0           mov    al, 0xe0                
F000:B4A1  3cff           cmp    al, 0xff                
F000:B4A3  7405           je     0xb4aa                  
F000:B4A5  80fcff         cmp    ah, 0xff                
F000:B4A8  7503           jne    0xb4ad                  
F000:B4AA  e96efd         jmp    0xb21b                  
F000:B4AD  80fce0         cmp    ah, 0xe0                
F000:B4B0  7407           je     0xb4b9                  
F000:B4B2  80fca6         cmp    ah, 0xa6                
F000:B4B5  7602           jbe    0xb4b9                  
F000:B4B7  b0f8           mov    al, 0xf8                
F000:B4B9  fa             cli                            
F000:B4BA  8b1e1c00       mov    bx, word ptr [0x1c]     
F000:B4BE  8bf3           mov    si, bx                  
F000:B4C0  e8befa         call   0xaf81                  
F000:B4C3  3b1e1a00       cmp    bx, word ptr [0x1a]     
F000:B4C7  7411           je     0xb4da                  
F000:B4C9  8904           mov    word ptr [si], ax       
F000:B4CB  891e1c00       mov    word ptr [0x1c], bx     
F000:B4CF  e8c600         call   0xb598                  
F000:B4D2  b80291         mov    ax, 0x9102              
F000:B4D5  cd15           int    0x15                     ; BIOS service
F000:B4D7  e941fd         jmp    0xb21b                  
F000:B4DA  e8bb00         call   0xb598                  
F000:B4DD  fb             sti                            
F000:B4DE  b9a602         mov    cx, 0x2a6               
F000:B4E1  b304           mov    bl, 4                   
F000:B4E3  e85235         call   0xea38                  
F000:B4E6  e937fd         jmp    0xb220                  

;----- sub_B4E9 -----
F000:B4E9  9c             pushf                          
F000:B4EA  fa             cli                            
F000:B4EB  e89400         call   0xb582                  
F000:B4EE  e664           out    0x64, al                 ; KBC cmd/sts
F000:B4F0  9d             popf                           
F000:B4F1  c3             ret                            

;----- sub_B4F2 -----
F000:B4F2  50             push   ax                      
F000:B4F3  53             push   bx                      
F000:B4F4  51             push   cx                      
F000:B4F5  8af8           mov    bh, al                  
F000:B4F7  b306           mov    bl, 6                   
F000:B4F9  fa             cli                            
F000:B4FA  802697004f     and    byte ptr [0x97], 0x4f   
F000:B4FF  e88000         call   0xb582                  
F000:B502  8ac7           mov    al, bh                  
F000:B504  e660           out    0x60, al                 ; KBC data
F000:B506  fb             sti                            
F000:B507  b9c103         mov    cx, 0x3c1               
F000:B50A  f606970030     test   byte ptr [0x97], 0x30   
F000:B50F  7517           jne    0xb528                  
F000:B511  e461           in     al, 0x61                 ; PortB/spkr
F000:B513  2410           and    al, 0x10                
F000:B515  3ac4           cmp    al, ah                  
F000:B517  74f1           je     0xb50a                  
F000:B519  8ae0           mov    ah, al                  
F000:B51B  e2ed           loop   0xb50a                  
F000:B51D  fecb           dec    bl                      
F000:B51F  75d8           jne    0xb4f9                  
F000:B521  800e970080     or     byte ptr [0x97], 0x80   
F000:B526  eb07           jmp    0xb52f                  
F000:B528  f606970010     test   byte ptr [0x97], 0x10   
F000:B52D  74ee           je     0xb51d                  
F000:B52F  59             pop    cx                      
F000:B530  5b             pop    bx                      
F000:B531  58             pop    ax                      
F000:B532  c3             ret                            

;----- sub_B533 -----
F000:B533  fa             cli                            
F000:B534  f606970040     test   byte ptr [0x97], 0x40   
F000:B539  7537           jne    0xb572                  
F000:B53B  800e970040     or     byte ptr [0x97], 0x40   
F000:B540  e85500         call   0xb598                  
F000:B543  b0ed           mov    al, 0xed                
F000:B545  e8aaff         call   0xb4f2                  
F000:B548  fa             cli                            
F000:B549  e82800         call   0xb574                  
F000:B54C  80269700f8     and    byte ptr [0x97], 0xf8   
F000:B551  08069700       or     byte ptr [0x97], al     
F000:B555  f606970080     test   byte ptr [0x97], 0x80   
F000:B55A  750b           jne    0xb567                  
F000:B55C  e893ff         call   0xb4f2                  
F000:B55F  fa             cli                            
F000:B560  f606970080     test   byte ptr [0x97], 0x80   
F000:B565  7406           je     0xb56d                  
F000:B567  b0f4           mov    al, 0xf4                
F000:B569  e886ff         call   0xb4f2                  
F000:B56C  fa             cli                            
F000:B56D  802697003f     and    byte ptr [0x97], 0x3f   
F000:B572  fb             sti                            
F000:B573  c3             ret                            

;----- sub_B574 -----
F000:B574  51             push   cx                      
F000:B575  a01700         mov    al, byte ptr [0x17]     
F000:B578  2470           and    al, 0x70                
F000:B57A  b104           mov    cl, 4                   
F000:B57C  d2c0           rol    al, cl                  
F000:B57E  2407           and    al, 7                   
F000:B580  59             pop    cx                      
F000:B581  c3             ret                            

;----- sub_B582 -----
F000:B582  50             push   ax                      
F000:B583  b9c103         mov    cx, 0x3c1               
F000:B586  e461           in     al, 0x61                 ; PortB/spkr
F000:B588  2410           and    al, 0x10                
F000:B58A  3ac4           cmp    al, ah                  
F000:B58C  74f8           je     0xb586                  
F000:B58E  8ae0           mov    ah, al                  
F000:B590  e464           in     al, 0x64                 ; KBC cmd/sts
F000:B592  a802           test   al, 2                   
F000:B594  e0f0           loopne 0xb586                  
F000:B596  58             pop    ax                      
F000:B597  c3             ret                            

;----- sub_B598 -----
F000:B598  f746000080     test   word ptr [bp], 0x8000   
F000:B59D  740b           je     0xb5aa                  
F000:B59F  50             push   ax                      
F000:B5A0  b020           mov    al, 0x20                
F000:B5A2  e620           out    0x20, al                 ; PIC1
F000:B5A4  816600ff7f     and    word ptr [bp], 0x7fff   
F000:B5A9  58             pop    ax                      
F000:B5AA  c3             ret                            
F000:BA48  fb             sti                            
F000:BA49  1e             push   ds                      
F000:BA4A  e8b22f         call   0xe9ff                  
F000:BA4D  a11300         mov    ax, word ptr [0x13]     
F000:BA50  1f             pop    ds                      
F000:BA51  cf             iret                           
F000:BB78  fb             sti                            
F000:BB79  55             push   bp                      
F000:BB7A  57             push   di                      
F000:BB7B  52             push   dx                      
F000:BB7C  53             push   bx                      
F000:BB7D  51             push   cx                      
F000:BB7E  8bec           mov    bp, sp                  
F000:BB80  1e             push   ds                      
F000:BB81  56             push   si                      
F000:BB82  e87a2e         call   0xe9ff                  
F000:BB85  80fc21         cmp    ah, 0x21                
F000:BB88  90             nop                            
F000:BB89  7202           jb     0xbb8d                  
F000:BB8B  b414           mov    ah, 0x14                
F000:BB8D  80fc01         cmp    ah, 1                   
F000:BB90  7620           jbe    0xbbb2                  
F000:BB92  80fc08         cmp    ah, 8                   
F000:BB95  741b           je     0xbbb2                  
F000:BB97  80fa01         cmp    dl, 1                   
F000:BB9A  7602           jbe    0xbb9e                  
F000:BB9C  b414           mov    ah, 0x14                
F000:BB9E  80fc15         cmp    ah, 0x15                
F000:BBA1  740f           je     0xbbb2                  
F000:BBA3  57             push   di                      
F000:BBA4  52             push   dx                      
F000:BBA5  32f6           xor    dh, dh                  
F000:BBA7  8bfa           mov    di, dx                  
F000:BBA9  5a             pop    dx                      
F000:BBAA  e8290e         call   0xc9d6                  
F000:BBAD  5f             pop    di                      
F000:BBAE  7302           jae    0xbbb2                  
F000:BBB0  b414           mov    ah, 0x14                
F000:BBB2  8acc           mov    cl, ah                  
F000:BBB4  32ed           xor    ch, ch                  
F000:BBB6  d0e1           shl    cl, 1                   
F000:BBB8  bbe4bb         mov    bx, 0xbbe4              
F000:BBBB  03d9           add    bx, cx                  
F000:BBBD  8ae6           mov    ah, dh                  
F000:BBBF  32f6           xor    dh, dh                  
F000:BBC1  8bf0           mov    si, ax                  
F000:BBC3  8bfa           mov    di, dx                  
F000:BBC5  8a264100       mov    ah, byte ptr [0x41]     
F000:BBC9  c606410000     mov    byte ptr [0x41], 0       ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:BBCE  2eff17         call   word ptr cs:[bx]        
F000:BBD1  5e             pop    si                      
F000:BBD2  1f             pop    ds                      
F000:BBD3  59             pop    cx                      
F000:BBD4  5b             pop    bx                      
F000:BBD5  5a             pop    dx                      
F000:BBD6  5f             pop    di                      
F000:BBD7  5d             pop    bp                      
F000:BBD8  55             push   bp                      
F000:BBD9  8bec           mov    bp, sp                  
F000:BBDB  50             push   ax                      
F000:BBDC  9c             pushf                          
F000:BBDD  58             pop    ax                      
F000:BBDE  894606         mov    word ptr [bp + 6], ax   
F000:BBE1  58             pop    ax                      
F000:BBE2  5d             pop    bp                      
F000:BBE3  cf             iret                           

;----- sub_BC96 -----
F000:BC96  e86904         call   0xc102                  
F000:BC99  fa             cli                            
F000:BC9A  b008           mov    al, 8                   
F000:BC9C  baf503         mov    dx, 0x3f5               
F000:BC9F  ee             out    dx, al                  
F000:BCA0  b703           mov    bh, 3                   
F000:BCA2  b90300         mov    cx, 3                   
F000:BCA5  e8d82d         call   0xea80                  
F000:BCA8  fecf           dec    bh                      
F000:BCAA  7403           je     0xbcaf                  
F000:BCAC  ec             in     al, dx                  
F000:BCAD  ebf3           jmp    0xbca2                  
F000:BCAF  b066           mov    al, 0x66                
F000:BCB1  e620           out    0x20, al                 ; PIC1
F000:BCB3  baf203         mov    dx, 0x3f2               
F000:BCB6  a03f00         mov    al, byte ptr [0x3f]     
F000:BCB9  243f           and    al, 0x3f                
F000:BCBB  c0c004         rol    al, 4                   
F000:BCBE  0c08           or     al, 8                   
F000:BCC0  ee             out    dx, al                  
F000:BCC1  c6063e0000     mov    byte ptr [0x3e], 0       ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:BCC6  50             push   ax                      
F000:BCC7  51             push   cx                      
F000:BCC8  b90400         mov    cx, 4                   
F000:BCCB  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:BCCD  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:BCCF  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:BCD1  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:BCD3  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:BCD5  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:BCD7  e2f2           loop   0xbccb                  
F000:BCD9  59             pop    cx                      
F000:BCDA  58             pop    ax                      
F000:BCDB  0c04           or     al, 4                   
F000:BCDD  ee             out    dx, al                  
F000:BCDE  fb             sti                            
F000:BCDF  e85c0c         call   0xc93e                  
F000:BCE2  7240           jb     0xbd24                  
F000:BCE4  b9c000         mov    cx, 0xc0                
F000:BCE7  3a0e4200       cmp    cl, byte ptr [0x42]     
F000:BCEB  7531           jne    0xbd1e                  
F000:BCED  fec1           inc    cl                      
F000:BCEF  80f9c3         cmp    cl, 0xc3                
F000:BCF2  7713           ja     0xbd07                  
F000:BCF4  51             push   cx                      
F000:BCF5  b81dbd         mov    ax, 0xbd1d              
F000:BCF8  50             push   ax                      
F000:BCF9  b408           mov    ah, 8                   
F000:BCFB  e8450b         call   0xc843                  
F000:BCFE  58             pop    ax                      
F000:BCFF  e87b0c         call   0xc97d                  
F000:BD02  59             pop    cx                      
F000:BD03  721f           jb     0xbd24                  
F000:BD05  ebe0           jmp    0xbce7                  
F000:BD07  b200           mov    dl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:BD09  e86d0a         call   0xc779                  
F000:BD0C  80e430         and    ah, 0x30                
F000:BD0F  80268b00cf     and    byte ptr [0x8b], 0xcf   
F000:BD14  08268b00       or     byte ptr [0x8b], ah     
F000:BD18  e8b403         call   0xc0cf                  
F000:BD1B  eb07           jmp    0xbd24                  
F000:BD1E  c606410020     mov    byte ptr [0x41], 0x20   
F000:BD23  f9             stc                            
F000:BD24  e8fd03         call   0xc124                  
F000:BD27  e88e09         call   0xc6b8                  
F000:BD2A  8bde           mov    bx, si                  
F000:BD2C  8ac3           mov    al, bl                  
F000:BD2E  c3             ret                            

;----- sub_C0CF -----
F000:C0CF  b8e9c0         mov    ax, 0xc0e9              
F000:C0D2  50             push   ax                      
F000:C0D3  b403           mov    ah, 3                   
F000:C0D5  e86b07         call   0xc843                  
F000:C0D8  2ad2           sub    dl, dl                  
F000:C0DA  e89c06         call   0xc779                  
F000:C0DD  e86307         call   0xc843                  
F000:C0E0  b201           mov    dl, 1                   
F000:C0E2  e89406         call   0xc779                  
F000:C0E5  e85b07         call   0xc843                  
F000:C0E8  58             pop    ax                      
F000:C0E9  c3             ret                            

;----- sub_C102 -----
F000:C102  83ff01         cmp    di, 1                   
F000:C105  771c           ja     0xc123                  
F000:C107  f68590003f     test   byte ptr [di + 0x90], 0x3f
F000:C10C  7415           je     0xc123                  
F000:C10E  8bcf           mov    cx, di                  
F000:C110  c0e102         shl    cl, 2                   
F000:C113  a08f00         mov    al, byte ptr [0x8f]     
F000:C116  d2c8           ror    al, cl                  
F000:C118  240f           and    al, 0xf                 
F000:C11A  80a59000f8     and    byte ptr [di + 0x90], 0xf8
F000:C11F  08859000       or     byte ptr [di + 0x90], al
F000:C123  c3             ret                            

;----- sub_C124 -----
F000:C124  83ff01         cmp    di, 1                   
F000:C127  7603           jbe    0xc12c                  
F000:C129  eb79           jmp    0xc1a4                  
F000:C12C  f68590003f     test   byte ptr [di + 0x90], 0x3f
F000:C131  7471           je     0xc1a4                  
F000:C133  8bcf           mov    cx, di                  
F000:C135  c0e102         shl    cl, 2                   
F000:C138  b402           mov    ah, 2                   
F000:C13A  d2cc           ror    ah, cl                  
F000:C13C  84268f00       test   byte ptr [0x8f], ah     
F000:C140  7516           jne    0xc158                  
F000:C142  b40f           mov    ah, 0xf                 
F000:C144  d2cc           ror    ah, cl                  
F000:C146  f6d4           not    ah                      
F000:C148  20268f00       and    byte ptr [0x8f], ah     
F000:C14C  8a859000       mov    al, byte ptr [di + 0x90]
F000:C150  240f           and    al, 0xf                 
F000:C152  d2c8           ror    al, cl                  
F000:C154  08068f00       or     byte ptr [0x8f], al     
F000:C158  8aa59000       mov    ah, byte ptr [di + 0x90]
F000:C15C  8afc           mov    bh, ah                  
F000:C15E  80e4c0         and    ah, 0xc0                
F000:C161  80fcc0         cmp    ah, 0xc0                
F000:C164  7415           je     0xc17b                  
F000:C166  80fc00         cmp    ah, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:C169  7410           je     0xc17b                  
F000:C16B  b001           mov    al, 1                   
F000:C16D  80fc40         cmp    ah, 0x40                
F000:C170  7516           jne    0xc188                  
F000:C172  f6c720         test   bh, 0x20                
F000:C175  751d           jne    0xc194                  
F000:C177  b007           mov    al, 7                   
F000:C179  eb20           jmp    0xc19b                  
F000:C17B  e8de05         call   0xc75c                  
F000:C17E  72f7           jb     0xc177                  
F000:C180  3c02           cmp    al, 2                   
F000:C182  75f3           jne    0xc177                  
F000:C184  b002           mov    al, 2                   
F000:C186  eb0c           jmp    0xc194                  
F000:C188  b000           mov    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:C18A  80fc80         cmp    ah, 0x80                
F000:C18D  75e8           jne    0xc177                  
F000:C18F  f6c701         test   bh, 1                   
F000:C192  75e3           jne    0xc177                  
F000:C194  f6c710         test   bh, 0x10                
F000:C197  7402           je     0xc19b                  
F000:C199  0403           add    al, 3                   
F000:C19B  80a59000f8     and    byte ptr [di + 0x90], 0xf8
F000:C1A0  08859000       or     byte ptr [di + 0x90], al
F000:C1A4  c3             ret                            

;----- sub_C476 -----
F000:C476  e85305         call   0xc9cc                  
F000:C479  743f           je     0xc4ba                  
F000:C47B  80a59000ef     and    byte ptr [di + 0x90], 0xef
F000:C480  57             push   di                      
F000:C481  e85205         call   0xc9d6                  
F000:C484  8bcf           mov    cx, di                  
F000:C486  5f             pop    di                      
F000:C487  b001           mov    al, 1                   
F000:C489  d2e0           shl    al, cl                  
F000:C48B  f6d0           not    al                      
F000:C48D  fa             cli                            
F000:C48E  20063f00       and    byte ptr [0x3f], al     
F000:C492  fb             sti                            
F000:C493  e8f802         call   0xc78e                  
F000:C496  e88bfc         call   0xc124                  
F000:C499  e8faf7         call   0xbc96                  
F000:C49C  e863fc         call   0xc102                  
F000:C49F  b501           mov    ch, 1                   
F000:C4A1  e8c303         call   0xc867                  
F000:C4A4  32ed           xor    ch, ch                  
F000:C4A6  e8be03         call   0xc867                  
F000:C4A9  c606410006     mov    byte ptr [0x41], 6      
F000:C4AE  e81b05         call   0xc9cc                  
F000:C4B1  7405           je     0xc4b8                  
F000:C4B3  c606410080     mov    byte ptr [0x41], 0x80   
F000:C4B8  f9             stc                            
F000:C4B9  c3             ret                            
F000:C4BA  f8             clc                            
F000:C4BB  c3             ret                            

;----- sub_C6B8 -----
F000:C6B8  b202           mov    dl, 2                   
F000:C6BA  50             push   ax                      
F000:C6BB  e8bb00         call   0xc779                  
F000:C6BE  88264000       mov    byte ptr [0x40], ah     
F000:C6C2  58             pop    ax                      
F000:C6C3  8a264100       mov    ah, byte ptr [0x41]     
F000:C6C7  0ae4           or     ah, ah                  
F000:C6C9  7402           je     0xc6cd                  
F000:C6CB  32c0           xor    al, al                  
F000:C6CD  80fc01         cmp    ah, 1                   
F000:C6D0  f5             cmc                            
F000:C6D1  c3             ret                            

;----- sub_C75C -----
F000:C75C  57             push   di                      
F000:C75D  b00e           mov    al, 0xe                 
F000:C75F  e82e22         call   0xe990                  
F000:C762  a8e0           test   al, 0xe0                
F000:C764  f9             stc                            
F000:C765  7510           jne    0xc777                  
F000:C767  b010           mov    al, 0x10                
F000:C769  e82422         call   0xe990                  
F000:C76C  eb00           jmp    0xc76e                  
F000:C76E  0bff           or     di, di                  
F000:C770  7503           jne    0xc775                  
F000:C772  c0c804         ror    al, 4                   
F000:C775  240f           and    al, 0xf                 
F000:C777  5f             pop    di                      
F000:C778  c3             ret                            

;----- sub_C779 -----
F000:C779  1e             push   ds                      
F000:C77A  56             push   si                      
F000:C77B  2bc0           sub    ax, ax                  
F000:C77D  8ed8           mov    ds, ax                  
F000:C77F  87d3           xchg   bx, dx                  
F000:C781  2aff           sub    bh, bh                  
F000:C783  c5367800       lds    si, ptr [0x78]          
F000:C787  8a20           mov    ah, byte ptr [bx + si]  
F000:C789  87d3           xchg   bx, dx                  
F000:C78B  5e             pop    si                      
F000:C78C  1f             pop    ds                      
F000:C78D  c3             ret                            

;----- sub_C78E -----
F000:C78E  53             push   bx                      
F000:C78F  e84700         call   0xc7d9                  
F000:C792  7243           jb     0xc7d7                  
F000:C794  e88df9         call   0xc124                  
F000:C797  b8fd90         mov    ax, 0x90fd              
F000:C79A  cd15           int    0x15                     ; BIOS service
F000:C79C  9c             pushf                          
F000:C79D  e862f9         call   0xc102                  
F000:C7A0  9d             popf                           
F000:C7A1  7305           jae    0xc7a8                  
F000:C7A3  e83300         call   0xc7d9                  
F000:C7A6  722f           jb     0xc7d7                  
F000:C7A8  b20a           mov    dl, 0xa                 
F000:C7AA  e8ccff         call   0xc779                  
F000:C7AD  8ac4           mov    al, ah                  
F000:C7AF  32e4           xor    ah, ah                  
F000:C7B1  3c04           cmp    al, 4                   
F000:C7B3  7302           jae    0xc7b7                  
F000:C7B5  b004           mov    al, 4                   
F000:C7B7  50             push   ax                      
F000:C7B8  ba24f4         mov    dx, 0xf424              
F000:C7BB  f7e2           mul    dx                      
F000:C7BD  8bca           mov    cx, dx                  
F000:C7BF  8bd0           mov    dx, ax                  
F000:C7C1  f8             clc                            
F000:C7C2  d1d2           rcl    dx, 1                   
F000:C7C4  d1d1           rcl    cx, 1                   
F000:C7C6  b486           mov    ah, 0x86                
F000:C7C8  cd15           int    0x15                     ; BIOS service
F000:C7CA  58             pop    ax                      
F000:C7CB  730a           jae    0xc7d7                  
F000:C7CD  b95e20         mov    cx, 0x205e              
F000:C7D0  e8ad22         call   0xea80                  
F000:C7D3  fec8           dec    al                      
F000:C7D5  75f6           jne    0xc7cd                  
F000:C7D7  5b             pop    bx                      
F000:C7D8  c3             ret                            

;----- sub_C7D9 -----
F000:C7D9  fa             cli                            
F000:C7DA  c6064000ff     mov    byte ptr [0x40], 0xff   
F000:C7DF  57             push   di                      
F000:C7E0  e8f301         call   0xc9d6                  
F000:C7E3  8bcf           mov    cx, di                  
F000:C7E5  5f             pop    di                      
F000:C7E6  b010           mov    al, 0x10                
F000:C7E8  d2e0           shl    al, cl                  
F000:C7EA  0ac1           or     al, cl                  
F000:C7EC  8ae0           mov    ah, al                  
F000:C7EE  c0c404         rol    ah, 4                   
F000:C7F1  80263f00cf     and    byte ptr [0x3f], 0xcf   
F000:C7F6  08263f00       or     byte ptr [0x3f], ah     
F000:C7FA  baf203         mov    dx, 0x3f2               
F000:C7FD  ec             in     al, dx                  
F000:C7FE  c0e804         shr    al, 4                   
F000:C801  84e0           test   al, ah                  
F000:C803  f9             stc                            
F000:C804  7501           jne    0xc807                  
F000:C806  f8             clc                            
F000:C807  9c             pushf                          
F000:C808  a03f00         mov    al, byte ptr [0x3f]     
F000:C80B  c0c004         rol    al, 4                   
F000:C80E  0c0c           or     al, 0xc                 
F000:C810  baf203         mov    dx, 0x3f2               
F000:C813  ee             out    dx, al                  
F000:C814  9d             popf                           
F000:C815  fb             sti                            
F000:C816  c3             ret                            

;----- sub_C817 -----
F000:C817  b209           mov    dl, 9                   
F000:C819  e85dff         call   0xc779                  
F000:C81C  80fc0f         cmp    ah, 0xf                 
F000:C81F  7302           jae    0xc823                  
F000:C821  b40f           mov    ah, 0xf                 
F000:C823  8ac4           mov    al, ah                  
F000:C825  32e4           xor    ah, ah                  
F000:C827  50             push   ax                      
F000:C828  bae803         mov    dx, 0x3e8               
F000:C82B  f7e2           mul    dx                      
F000:C82D  8bca           mov    cx, dx                  
F000:C82F  8bd0           mov    dx, ax                  
F000:C831  b486           mov    ah, 0x86                
F000:C833  cd15           int    0x15                     ; BIOS service
F000:C835  58             pop    ax                      
F000:C836  730a           jae    0xc842                  
F000:C838  b94200         mov    cx, 0x42                
F000:C83B  e84222         call   0xea80                  
F000:C83E  fec8           dec    al                      
F000:C840  75f6           jne    0xc838                  
F000:C842  c3             ret                            

;----- sub_C843 -----
F000:C843  53             push   bx                      
F000:C844  baf403         mov    dx, 0x3f4               
F000:C847  b303           mov    bl, 3                   
F000:C849  33c9           xor    cx, cx                  
F000:C84B  ec             in     al, dx                  
F000:C84C  24c0           and    al, 0xc0                
F000:C84E  3c80           cmp    al, 0x80                
F000:C850  740f           je     0xc861                  
F000:C852  e2f7           loop   0xc84b                  
F000:C854  fecb           dec    bl                      
F000:C856  75f3           jne    0xc84b                  
F000:C858  800e410080     or     byte ptr [0x41], 0x80   
F000:C85D  5b             pop    bx                      
F000:C85E  58             pop    ax                      
F000:C85F  f9             stc                            
F000:C860  c3             ret                            
F000:C861  8ac4           mov    al, ah                  
F000:C863  42             inc    dx                      
F000:C864  ee             out    dx, al                  
F000:C865  5b             pop    bx                      
F000:C866  c3             ret                            

;----- sub_C867 -----
F000:C867  8bdf           mov    bx, di                  
F000:C869  b001           mov    al, 1                   
F000:C86B  86cb           xchg   bl, cl                  
F000:C86D  d2c0           rol    al, cl                  
F000:C86F  86cb           xchg   bl, cl                  
F000:C871  84063e00       test   byte ptr [0x3e], al     
F000:C875  7540           jne    0xc8b7                  
F000:C877  08063e00       or     byte ptr [0x3e], al     
F000:C87B  80bd94000a     cmp    byte ptr [di + 0x94], 0xa
F000:C880  7313           jae    0xc895                  
F000:C882  51             push   cx                      
F000:C883  83ff01         cmp    di, 1                   
F000:C886  7704           ja     0xc88c                  
F000:C888  8aad9400       mov    ch, byte ptr [di + 0x94]
F000:C88C  80c505         add    ch, 5                   
F000:C88F  e83d00         call   0xc8cf                  
F000:C892  59             pop    cx                      
F000:C893  7239           jb     0xc8ce                  
F000:C895  e87300         call   0xc90b                  
F000:C898  730a           jae    0xc8a4                  
F000:C89A  c606410000     mov    byte ptr [0x41], 0       ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:C89F  e86900         call   0xc90b                  
F000:C8A2  722a           jb     0xc8ce                  
F000:C8A4  83ff01         cmp    di, 1                   
F000:C8A7  7705           ja     0xc8ae                  
F000:C8A9  c685940000     mov    byte ptr [di + 0x94], 0  ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:C8AE  51             push   cx                      
F000:C8AF  e865ff         call   0xc817                  
F000:C8B2  59             pop    cx                      
F000:C8B3  0aed           or     ch, ch                  
F000:C8B5  7417           je     0xc8ce                  
F000:C8B7  f685900020     test   byte ptr [di + 0x90], 0x20
F000:C8BC  7402           je     0xc8c0                  
F000:C8BE  d0e5           shl    ch, 1                   
F000:C8C0  83ff01         cmp    di, 1                   
F000:C8C3  7706           ja     0xc8cb                  
F000:C8C5  3aad9400       cmp    ch, byte ptr [di + 0x94]
F000:C8C9  7403           je     0xc8ce                  
F000:C8CB  e80100         call   0xc8cf                  
F000:C8CE  c3             ret                            

;----- sub_C8CF -----
F000:C8CF  51             push   cx                      
F000:C8D0  b809c9         mov    ax, 0xc909              
F000:C8D3  50             push   ax                      
F000:C8D4  83ff01         cmp    di, 1                   
F000:C8D7  7704           ja     0xc8dd                  
F000:C8D9  88ad9400       mov    byte ptr [di + 0x94], ch
F000:C8DD  b40f           mov    ah, 0xf                 
F000:C8DF  e861ff         call   0xc843                  
F000:C8E2  57             push   di                      
F000:C8E3  e8f000         call   0xc9d6                  
F000:C8E6  8bdf           mov    bx, di                  
F000:C8E8  5f             pop    di                      
F000:C8E9  8ae3           mov    ah, bl                  
F000:C8EB  e855ff         call   0xc843                  
F000:C8EE  58             pop    ax                      
F000:C8EF  59             pop    cx                      
F000:C8F0  50             push   ax                      
F000:C8F1  83ff01         cmp    di, 1                   
F000:C8F4  7706           ja     0xc8fc                  
F000:C8F6  8aa59400       mov    ah, byte ptr [di + 0x94]
F000:C8FA  eb02           jmp    0xc8fe                  
F000:C8FC  8ae5           mov    ah, ch                  
F000:C8FE  e842ff         call   0xc843                  
F000:C901  e82300         call   0xc927                  
F000:C904  9c             pushf                          
F000:C905  e80fff         call   0xc817                  
F000:C908  9d             popf                           
F000:C909  58             pop    ax                      
F000:C90A  c3             ret                            

;----- sub_C90B -----
F000:C90B  51             push   cx                      
F000:C90C  b825c9         mov    ax, 0xc925              
F000:C90F  50             push   ax                      
F000:C910  b407           mov    ah, 7                   
F000:C912  e82eff         call   0xc843                  
F000:C915  57             push   di                      
F000:C916  e8bd00         call   0xc9d6                  
F000:C919  8bdf           mov    bx, di                  
F000:C91B  5f             pop    di                      
F000:C91C  8ae3           mov    ah, bl                  
F000:C91E  e822ff         call   0xc843                  
F000:C921  e80300         call   0xc927                  
F000:C924  58             pop    ax                      
F000:C925  59             pop    cx                      
F000:C926  c3             ret                            

;----- sub_C927 -----
F000:C927  e81400         call   0xc93e                  
F000:C92A  720a           jb     0xc936                  
F000:C92C  a04200         mov    al, byte ptr [0x42]     
F000:C92F  2460           and    al, 0x60                
F000:C931  3c60           cmp    al, 0x60                
F000:C933  7402           je     0xc937                  
F000:C935  f8             clc                            
F000:C936  c3             ret                            
F000:C937  800e410040     or     byte ptr [0x41], 0x40   
F000:C93C  f9             stc                            
F000:C93D  c3             ret                            

;----- sub_C93E -----
F000:C93E  fb             sti                            
F000:C93F  f8             clc                            
F000:C940  e8e1f7         call   0xc124                  
F000:C943  b80190         mov    ax, 0x9001              
F000:C946  cd15           int    0x15                     ; BIOS service
F000:C948  9c             pushf                          
F000:C949  e8b6f7         call   0xc102                  
F000:C94C  9d             popf                           
F000:C94D  721b           jb     0xc96a                  
F000:C94F  b302           mov    bl, 2                   
F000:C951  33c9           xor    cx, cx                  
F000:C953  f6063e0080     test   byte ptr [0x3e], 0x80   
F000:C958  7517           jne    0xc971                  
F000:C95A  e461           in     al, 0x61                 ; PortB/spkr
F000:C95C  2410           and    al, 0x10                
F000:C95E  3ac4           cmp    al, ah                  
F000:C960  74f1           je     0xc953                  
F000:C962  8ae0           mov    ah, al                  
F000:C964  e2ed           loop   0xc953                  
F000:C966  fecb           dec    bl                      
F000:C968  75e9           jne    0xc953                  
F000:C96A  800e410080     or     byte ptr [0x41], 0x80   
F000:C96F  f9             stc                            
F000:C970  c3             ret                            
F000:C971  80263e007f     and    byte ptr [0x3e], 0x7f   
F000:C976  803e410001     cmp    byte ptr [0x41], 1      
F000:C97B  f5             cmc                            
F000:C97C  c3             ret                            

;----- sub_C97D -----
F000:C97D  57             push   di                      
F000:C97E  bf4200         mov    di, 0x42                
F000:C981  b307           mov    bl, 7                   
F000:C983  baf403         mov    dx, 0x3f4               
F000:C986  b703           mov    bh, 3                   
F000:C988  33c9           xor    cx, cx                  
F000:C98A  ec             in     al, dx                  
F000:C98B  24c0           and    al, 0xc0                
F000:C98D  3cc0           cmp    al, 0xc0                
F000:C98F  740e           je     0xc99f                  
F000:C991  e2f7           loop   0xc98a                  
F000:C993  fecf           dec    bh                      
F000:C995  75f3           jne    0xc98a                  
F000:C997  800e410080     or     byte ptr [0x41], 0x80   
F000:C99C  f9             stc                            
F000:C99D  eb1b           jmp    0xc9ba                  
F000:C99F  42             inc    dx                      
F000:C9A0  ec             in     al, dx                  
F000:C9A1  8805           mov    byte ptr [di], al       
F000:C9A3  47             inc    di                      
F000:C9A4  b90300         mov    cx, 3                   
F000:C9A7  e8d620         call   0xea80                  
F000:C9AA  4a             dec    dx                      
F000:C9AB  ec             in     al, dx                  
F000:C9AC  a810           test   al, 0x10                
F000:C9AE  740a           je     0xc9ba                  
F000:C9B0  fecb           dec    bl                      
F000:C9B2  75d2           jne    0xc986                  
F000:C9B4  800e410020     or     byte ptr [0x41], 0x20   
F000:C9B9  f9             stc                            
F000:C9BA  5f             pop    di                      
F000:C9BB  9c             pushf                          
F000:C9BC  fa             cli                            
F000:C9BD  f6063e0080     test   byte ptr [0x3e], 0x80   
F000:C9C2  7406           je     0xc9ca                  
F000:C9C4  b020           mov    al, 0x20                
F000:C9C6  e620           out    0x20, al                 ; PIC1
F000:C9C8  eb00           jmp    0xc9ca                  
F000:C9CA  9d             popf                           
F000:C9CB  c3             ret                            

;----- sub_C9CC -----
F000:C9CC  e8bffd         call   0xc78e                  
F000:C9CF  baf703         mov    dx, 0x3f7               
F000:C9D2  ec             in     al, dx                  
F000:C9D3  a880           test   al, 0x80                
F000:C9D5  c3             ret                            

;----- sub_C9D6 -----
F000:C9D6  53             push   bx                      
F000:C9D7  51             push   cx                      
F000:C9D8  52             push   dx                      
F000:C9D9  1e             push   ds                      
F000:C9DA  33d2           xor    dx, dx                  
F000:C9DC  33db           xor    bx, bx                  
F000:C9DE  8b0e0e00       mov    cx, word ptr [0xe]      
F000:C9E2  8ed9           mov    ds, cx                  
F000:C9E4  8a0ee700       mov    cl, byte ptr [0xe7]     
F000:C9E8  1f             pop    ds                      
F000:C9E9  80e1e0         and    cl, 0xe0                
F000:C9EC  3bfa           cmp    di, dx                  
F000:C9EE  740e           je     0xc9fe                  
F000:C9F0  80f900         cmp    cl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:C9F3  7408           je     0xc9fd                  
F000:C9F5  43             inc    bx                      
F000:C9F6  d0e1           shl    cl, 1                   
F000:C9F8  73f2           jae    0xc9ec                  
F000:C9FA  42             inc    dx                      
F000:C9FB  ebef           jmp    0xc9ec                  
F000:C9FD  f9             stc                            
F000:C9FE  8bfb           mov    di, bx                  
F000:CA00  5a             pop    dx                      
F000:CA01  59             pop    cx                      
F000:CA02  5b             pop    bx                      
F000:CA03  c3             ret                            

;----- sub_CAB3 -----
F000:CAB3  52             push   dx                      
F000:CAB4  c606410000     mov    byte ptr [0x41], 0       ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:CAB9  32f6           xor    dh, dh                  
F000:CABB  8bfa           mov    di, dx                  
F000:CABD  e842f6         call   0xc102                  
F000:CAC0  e8b3f9         call   0xc476                  
F000:CAC3  e85ef6         call   0xc124                  
F000:CAC6  f606410080     test   byte ptr [0x41], 0x80   
F000:CACB  5a             pop    dx                      
F000:CACC  c3             ret                            

;----- sub_CACD -----
F000:CACD  1e             push   ds                      
F000:CACE  e82e1f         call   0xe9ff                  
F000:CAD1  f606120080     test   byte ptr [0x12], 0x80   
F000:CAD6  1f             pop    ds                      
F000:CAD7  7401           je     0xcada                  
F000:CAD9  c3             ret                            
F000:CADA  1e             push   ds                      
F000:CADB  52             push   dx                      
F000:CADC  e8201f         call   0xe9ff                  
F000:CADF  a10e00         mov    ax, word ptr [0xe]      
F000:CAE2  8ed8           mov    ds, ax                  
F000:CAE4  a0ed00         mov    al, byte ptr [0xed]     
F000:CAE7  32e4           xor    ah, ah                  
F000:CAE9  8bf8           mov    di, ax                  
F000:CAEB  e8111f         call   0xe9ff                  
F000:CAEE  83ff00         cmp    di, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:CAF1  7508           jne    0xcafb                  
F000:CAF3  32f6           xor    dh, dh                  
F000:CAF5  3bfa           cmp    di, dx                  
F000:CAF7  7454           je     0xcb4d                  
F000:CAF9  eb0a           jmp    0xcb05                  
F000:CAFB  52             push   dx                      
F000:CAFC  e88e00         call   0xcb8d                  
F000:CAFF  e8d300         call   0xcbd5                  
F000:CB02  5a             pop    dx                      
F000:CB03  eb48           jmp    0xcb4d                  
F000:CB05  52             push   dx                      
F000:CB06  32f6           xor    dh, dh                  
F000:CB08  8bfa           mov    di, dx                  
F000:CB0A  e88000         call   0xcb8d                  
F000:CB0D  e8c500         call   0xcbd5                  
F000:CB10  26a10e00       mov    ax, word ptr es:[0xe]   
F000:CB14  8ed8           mov    ds, ax                  
F000:CB16  a0e700         mov    al, byte ptr [0xe7]     
F000:CB19  8ac8           mov    cl, al                  
F000:CB1B  8ad8           mov    bl, al                  
F000:CB1D  2401           and    al, 1                   
F000:CB1F  80fa00         cmp    dl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:CB22  7424           je     0xcb48                  
F000:CB24  e82900         call   0xcb50                  
F000:CB27  a2e700         mov    byte ptr [0xe7], al     
F000:CB2A  e8ba02         call   0xcde7                  
F000:CB2D  a01c01         mov    al, byte ptr [0x11c]    
F000:CB30  c0c802         ror    al, 2                   
F000:CB33  8ac8           mov    cl, al                  
F000:CB35  8ad8           mov    bl, al                  
F000:CB37  2401           and    al, 1                   
F000:CB39  e81400         call   0xcb50                  
F000:CB3C  80261c0103     and    byte ptr [0x11c], 3     
F000:CB41  c0c002         rol    al, 2                   
F000:CB44  08061c01       or     byte ptr [0x11c], al    
F000:CB48  5a             pop    dx                      
F000:CB49  8816ed00       mov    byte ptr [0xed], dl     
F000:CB4D  5a             pop    dx                      
F000:CB4E  1f             pop    ds                      
F000:CB4F  c3             ret                            

;----- sub_CB50 -----
F000:CB50  80fa01         cmp    dl, 1                   
F000:CB53  7510           jne    0xcb65                  
F000:CB55  80e302         and    bl, 2                   
F000:CB58  d0cb           ror    bl, 1                   
F000:CB5A  d0c0           rol    al, 1                   
F000:CB5C  80e1fc         and    cl, 0xfc                
F000:CB5F  0ac3           or     al, bl                  
F000:CB61  0ac1           or     al, cl                  
F000:CB63  eb27           jmp    0xcb8c                  
F000:CB65  80fa02         cmp    dl, 2                   
F000:CB68  7512           jne    0xcb7c                  
F000:CB6A  80e304         and    bl, 4                   
F000:CB6D  c0cb02         ror    bl, 2                   
F000:CB70  c0c002         rol    al, 2                   
F000:CB73  80e1fa         and    cl, 0xfa                
F000:CB76  0ac3           or     al, bl                  
F000:CB78  0ac1           or     al, cl                  
F000:CB7A  eb10           jmp    0xcb8c                  
F000:CB7C  80e308         and    bl, 8                   
F000:CB7F  c0cb03         ror    bl, 3                   
F000:CB82  c0c003         rol    al, 3                   
F000:CB85  80e1f6         and    cl, 0xf6                
F000:CB88  0ac3           or     al, bl                  
F000:CB8A  0ac1           or     al, cl                  
F000:CB8C  c3             ret                            

;----- sub_CB8D -----
F000:CB8D  52             push   dx                      
F000:CB8E  8a859000       mov    al, byte ptr [di + 0x90]
F000:CB92  8a1e9000       mov    bl, byte ptr [0x90]     
F000:CB96  889d9000       mov    byte ptr [di + 0x90], bl
F000:CB9A  a29000         mov    byte ptr [0x90], al     
F000:CB9D  8a859400       mov    al, byte ptr [di + 0x94]
F000:CBA1  8a1e9400       mov    bl, byte ptr [0x94]     
F000:CBA5  889d9400       mov    byte ptr [di + 0x94], bl
F000:CBA9  a29400         mov    byte ptr [0x94], al     
F000:CBAC  a08f00         mov    al, byte ptr [0x8f]     
F000:CBAF  c0c004         rol    al, 4                   
F000:CBB2  a28f00         mov    byte ptr [0x8f], al     
F000:CBB5  b800ca         mov    ax, 0xca00              
F000:CBB8  bb1000         mov    bx, 0x10                
F000:CBBB  cd15           int    0x15                     ; BIOS service
F000:CBBD  b500           mov    ch, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:CBBF  c1e104         shl    cx, 4                   
F000:CBC2  0acd           or     cl, ch                  
F000:CBC4  b801ca         mov    ax, 0xca01              
F000:CBC7  bb1000         mov    bx, 0x10                
F000:CBCA  cd15           int    0x15                     ; BIOS service
F000:CBCC  7205           jb     0xcbd3                  
F000:CBCE  e8ab91         call   0x5d7c                  
F000:CBD1  eb00           jmp    0xcbd3                  
F000:CBD3  5a             pop    dx                      
F000:CBD4  c3             ret                            

;----- sub_CBD5 -----
F000:CBD5  52             push   dx                      
F000:CBD6  32f6           xor    dh, dh                  
F000:CBD8  57             push   di                      
F000:CBD9  8bfa           mov    di, dx                  
F000:CBDB  e8f8fd         call   0xc9d6                  
F000:CBDE  8bdf           mov    bx, di                  
F000:CBE0  5f             pop    di                      
F000:CBE1  c0e302         shl    bl, 2                   
F000:CBE4  baf303         mov    dx, 0x3f3               
F000:CBE7  ec             in     al, dx                  
F000:CBE8  eb00           jmp    0xcbea                  
F000:CBEA  24f3           and    al, 0xf3                
F000:CBEC  0ac3           or     al, bl                  
F000:CBEE  ee             out    dx, al                  
F000:CBEF  5a             pop    dx                      
F000:CBF0  c3             ret                            

;----- sub_CDE7 -----
F000:CDE7  e8151c         call   0xe9ff                  
F000:CDEA  8e1e0e00       mov    ds, word ptr [0xe]      
F000:CDEE  c3             ret                            

;----- sub_CDEF -----
F000:CDEF  f606120080     test   byte ptr [0x12], 0x80   
F000:CDF4  7557           jne    0xce4d                  
F000:CDF6  f60690003f     test   byte ptr [0x90], 0x3f   
F000:CDFB  7550           jne    0xce4d                  
F000:CDFD  1e             push   ds                      
F000:CDFE  e8e6ff         call   0xcde7                  
F000:CE01  a0e700         mov    al, byte ptr [0xe7]     
F000:CE04  a880           test   al, 0x80                
F000:CE06  1f             pop    ds                      
F000:CE07  7520           jne    0xce29                  
F000:CE09  800e8f0010     or     byte ptr [0x8f], 0x10   
F000:CE0E  c606910000     mov    byte ptr [0x91], 0       ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:CE13  800e910001     or     byte ptr [0x91], 1      
F000:CE18  1e             push   ds                      
F000:CE19  e8cbff         call   0xcde7                  
F000:CE1C  b080           mov    al, 0x80                
F000:CE1E  0806e700       or     byte ptr [0xe7], al     
F000:CE22  b008           mov    al, 8                   
F000:CE24  08061c01       or     byte ptr [0x11c], al    
F000:CE28  1f             pop    ds                      
F000:CE29  b201           mov    dl, 1                   
F000:CE2B  e89ffc         call   0xcacd                  
F000:CE2E  1e             push   ds                      
F000:CE2F  e8b5ff         call   0xcde7                  
F000:CE32  b000           mov    al, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:CE34  a2ed00         mov    byte ptr [0xed], al     
F000:CE37  b07f           mov    al, 0x7f                
F000:CE39  2006e700       and    byte ptr [0xe7], al     
F000:CE3D  1f             pop    ds                      
F000:CE3E  800e120080     or     byte ptr [0x12], 0x80   
F000:CE43  a01000         mov    al, byte ptr [0x10]     
F000:CE46  243e           and    al, 0x3e                
F000:CE48  0c01           or     al, 1                   
F000:CE4A  a21000         mov    byte ptr [0x10], al     
F000:CE4D  c3             ret                            

;----- sub_CE4E -----
F000:CE4E  1e             push   ds                      
F000:CE4F  e8ad1b         call   0xe9ff                  
F000:CE52  f606120080     test   byte ptr [0x12], 0x80   
F000:CE57  7456           je     0xceaf                  
F000:CE59  a01000         mov    al, byte ptr [0x10]     
F000:CE5C  243e           and    al, 0x3e                
F000:CE5E  0440           add    al, 0x40                
F000:CE60  a21000         mov    byte ptr [0x10], al     
F000:CE63  1e             push   ds                      
F000:CE64  e880ff         call   0xcde7                  
F000:CE67  b080           mov    al, 0x80                
F000:CE69  0806e700       or     byte ptr [0xe7], al     
F000:CE6D  1f             pop    ds                      
F000:CE6E  b201           mov    dl, 1                   
F000:CE70  bf0100         mov    di, 1                   
F000:CE73  e817fd         call   0xcb8d                  
F000:CE76  1e             push   ds                      
F000:CE77  e86dff         call   0xcde7                  
F000:CE7A  a0e700         mov    al, byte ptr [0xe7]     
F000:CE7D  8ac8           mov    cl, al                  
F000:CE7F  8ad8           mov    bl, al                  
F000:CE81  2401           and    al, 1                   
F000:CE83  e8cafc         call   0xcb50                  
F000:CE86  a2e700         mov    byte ptr [0xe7], al     
F000:CE89  a01c01         mov    al, byte ptr [0x11c]    
F000:CE8C  c0c802         ror    al, 2                   
F000:CE8F  8ac8           mov    cl, al                  
F000:CE91  8ad8           mov    bl, al                  
F000:CE93  2401           and    al, 1                   
F000:CE95  e8b8fc         call   0xcb50                  
F000:CE98  80261c0103     and    byte ptr [0x11c], 3     
F000:CE9D  c0c002         rol    al, 2                   
F000:CEA0  08061c01       or     byte ptr [0x11c], al    
F000:CEA4  1f             pop    ds                      
F000:CEA5  b200           mov    dl, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:CEA7  e82bfd         call   0xcbd5                  
F000:CEAA  802612007f     and    byte ptr [0x12], 0x7f   
F000:CEAF  1f             pop    ds                      
F000:CEB0  c3             ret                            
F000:DB6F  ba2200         mov    dx, 0x22                
F000:DB72  ed             in     ax, dx                  
F000:DB73  a90100         test   ax, 1                   
F000:DB76  0f851100       jne    0xdb8b                  
F000:DB7A  b80080         mov    ax, 0x8000              
F000:DB7D  e623           out    0x23, al                 ; VL82C420 cfg-data
F000:DB7F  86e0           xchg   al, ah                  
F000:DB81  eb00           jmp    0xdb83                  
F000:DB83  e622           out    0x22, al                 ; VL82C420 cfg-idx
F000:DB85  eb00           jmp    0xdb87                  
F000:DB87  e722           out    0x22, ax                 ; VL82C420 cfg-idx
F000:DB89  eb00           jmp    0xdb8b                  
F000:DB8B  c3             ret                            

;----- sub_DBFA -----
F000:DBFA  eb00           jmp    0xdbfc                  
F000:DBFC  baf003         mov    dx, 0x3f0               
F000:DBFF  ee             out    dx, al                  
F000:DC00  eb00           jmp    0xdc02                  
F000:DC02  baf103         mov    dx, 0x3f1               
F000:DC05  ec             in     al, dx                  
F000:DC06  c3             ret                            

;----- sub_DC16 -----
F000:DC16  eb00           jmp    0xdc18                  
F000:DC18  eb00           jmp    0xdc1a                  
F000:DC1A  0c80           or     al, 0x80                
F000:DC1C  ba7000         mov    dx, 0x70                
F000:DC1F  ee             out    dx, al                  
F000:DC20  eb00           jmp    0xdc22                  
F000:DC22  eb00           jmp    0xdc24                  
F000:DC24  ba7100         mov    dx, 0x71                
F000:DC27  ec             in     al, dx                  
F000:DC28  c3             ret                            

;----- sub_DC3E -----
F000:DC3E  eb00           jmp    0xdc40                  
F000:DC40  eb00           jmp    0xdc42                  
F000:DC42  247f           and    al, 0x7f                
F000:DC44  ba7400         mov    dx, 0x74                
F000:DC47  ee             out    dx, al                  
F000:DC48  eb00           jmp    0xdc4a                  
F000:DC4A  eb00           jmp    0xdc4c                  
F000:DC4C  ba7600         mov    dx, 0x76                
F000:DC4F  ec             in     al, dx                  
F000:DC50  c3             ret                            

;----- sub_DCCB -----
F000:DCCB  eb00           jmp    0xdccd                  
F000:DCCD  baea15         mov    dx, 0x15ea              
F000:DCD0  ee             out    dx, al                  
F000:DCD1  eb00           jmp    0xdcd3                  
F000:DCD3  baeb15         mov    dx, 0x15eb              
F000:DCD6  ec             in     al, dx                  
F000:DCD7  c3             ret                            

;----- sub_DCE7 -----
F000:DCE7  baf003         mov    dx, 0x3f0               
F000:DCEA  b055           mov    al, 0x55                
F000:DCEC  ee             out    dx, al                  
F000:DCED  eb00           jmp    0xdcef                  
F000:DCEF  ee             out    dx, al                  
F000:DCF0  eb00           jmp    0xdcf2                  
F000:DCF2  c3             ret                            

;----- sub_DCF3 -----
F000:DCF3  baf003         mov    dx, 0x3f0               
F000:DCF6  b0aa           mov    al, 0xaa                
F000:DCF8  ee             out    dx, al                  
F000:DCF9  eb00           jmp    0xdcfb                  
F000:DCFB  c3             ret                            

;----- sub_DCFC -----
F000:DCFC  52             push   dx                      
F000:DCFD  50             push   ax                      
F000:DCFE  9c             pushf                          
F000:DCFF  fa             cli                            
F000:DD00  b0fe           mov    al, 0xfe                
F000:DD02  e839ff         call   0xdc3e                  
F000:DD05  8ae0           mov    ah, al                  
F000:DD07  b0ff           mov    al, 0xff                
F000:DD09  e832ff         call   0xdc3e                  
F000:DD0C  8bd0           mov    dx, ax                  
F000:DD0E  9d             popf                           
F000:DD0F  58             pop    ax                      
F000:DD10  ee             out    dx, al                  
F000:DD11  90             nop                            
F000:DD12  5a             pop    dx                      
F000:DD13  c3             ret                            

;----- sub_DD14 -----
F000:DD14  53             push   bx                      
F000:DD15  50             push   ax                      
F000:DD16  b88053         mov    ax, 0x5380              
F000:DD19  bb0083         mov    bx, 0x8300              
F000:DD1C  e8ddff         call   0xdcfc                  
F000:DD1F  58             pop    ax                      
F000:DD20  5b             pop    bx                      
F000:DD21  c3             ret                            

;----- sub_DD22 -----
F000:DD22  53             push   bx                      
F000:DD23  50             push   ax                      
F000:DD24  b88053         mov    ax, 0x5380              
F000:DD27  bb0183         mov    bx, 0x8301              
F000:DD2A  e8cfff         call   0xdcfc                  
F000:DD2D  58             pop    ax                      
F000:DD2E  5b             pop    bx                      
F000:DD2F  c3             ret                            

;----- sub_DD5D -----
F000:DD5D  60             pushaw                         
F000:DD5E  1e             push   ds                      
F000:DD5F  06             push   es                      
F000:DD60  8bec           mov    bp, sp                  
F000:DD62  fc             cld                            
F000:DD63  8cc8           mov    ax, cs                  
F000:DD65  8ed8           mov    ds, ax                  
F000:DD67  8d36e6dd       lea    si, [0xdde6]            
F000:DD6B  b80030         mov    ax, 0x3000              
F000:DD6E  8ec0           mov    es, ax                  
F000:DD70  2bff           sub    di, di                  
F000:DD72  b9e400         mov    cx, 0xe4                
F000:DD75  90             nop                            
F000:DD76  f3a4           rep movsb byte ptr es:[di], byte ptr [si]
F000:DD78  9a00000030     lcall  0x3000, 0                ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:DD7D  ba0010         mov    dx, 0x1000              
F000:DD80  8eda           mov    ds, dx                  
F000:DD82  2bf6           sub    si, si                  
F000:DD84  813c55aa       cmp    word ptr [si], 0xaa55   
F000:DD88  7557           jne    0xdde1                  
F000:DD8A  8a4c02         mov    cl, byte ptr [si + 2]   
F000:DD8D  2aed           sub    ch, ch                  
F000:DD8F  0ac9           or     cl, cl                  
F000:DD91  7502           jne    0xdd95                  
F000:DD93  fec5           inc    ch                      
F000:DD95  2adb           sub    bl, bl                  
F000:DD97  51             push   cx                      
F000:DD98  8eda           mov    ds, dx                  
F000:DD9A  2bf6           sub    si, si                  
F000:DD9C  b90001         mov    cx, 0x100               
F000:DD9F  ad             lodsw  ax, word ptr [si]       
F000:DDA0  02d8           add    bl, al                  
F000:DDA2  02dc           add    bl, ah                  
F000:DDA4  e2f9           loop   0xdd9f                  
F000:DDA6  83c220         add    dx, 0x20                
F000:DDA9  59             pop    cx                      
F000:DDAA  e2eb           loop   0xdd97                  
F000:DDAC  0adb           or     bl, bl                  
F000:DDAE  7531           jne    0xdde1                  
F000:DDB0  1e             push   ds                      
F000:DDB1  b84000         mov    ax, 0x40                
F000:DDB4  8ed8           mov    ds, ax                  
F000:DDB6  8026400048     and    byte ptr [0x40], 0x48   
F000:DDBB  1f             pop    ds                      
F000:DDBC  8b4612         mov    ax, word ptr [bp + 0x12]
F000:DDBF  9a03000010     lcall  0x1000, 3               
F000:DDC4  ba0010         mov    dx, 0x1000              
F000:DDC7  2bff           sub    di, di                  
F000:DDC9  662bc0         sub    eax, eax                
F000:DDCC  8ec2           mov    es, dx                  
F000:DDCE  b90040         mov    cx, 0x4000              
F000:DDD1  f366ab         rep stosd dword ptr es:[di], eax  
F000:DDD4  81c20010       add    dx, 0x1000              
F000:DDD8  81fa0090       cmp    dx, 0x9000              
F000:DDDC  72ee           jb     0xddcc                  
F000:DDDE  f8             clc                            
F000:DDDF  eb01           jmp    0xdde2                  
F000:DDE1  f9             stc                            
F000:DDE2  07             pop    es                      
F000:DDE3  1f             pop    ds                      
F000:DDE4  61             popaw                          
F000:DDE5  c3             ret                            

;----- sub_DEE1 -----
F000:DEE1  60             pushaw                         
F000:DEE2  40             inc    ax                      
F000:DEE3  7421           je     0xdf06                  
F000:DEE5  2adb           sub    bl, bl                  
F000:DEE7  48             dec    ax                      
F000:DEE8  3d0000         cmp    ax, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:DEEB  7407           je     0xdef4                  
F000:DEED  fec3           inc    bl                      
F000:DEEF  3d4000         cmp    ax, 0x40                
F000:DEF2  7512           jne    0xdf06                  
F000:DEF4  d0e3           shl    bl, 1                   
F000:DEF6  80cb01         or     bl, 1                   
F000:DEF9  b582           mov    ch, 0x82                
F000:DEFB  e816fe         call   0xdd14                  
F000:DEFE  80e1fc         and    cl, 0xfc                
F000:DF01  0acb           or     cl, bl                  
F000:DF03  e81cfe         call   0xdd22                  
F000:DF06  61             popaw                          
F000:DF07  c3             ret                            

;----- sub_DF08 -----
F000:DF08  51             push   cx                      
F000:DF09  b582           mov    ch, 0x82                
F000:DF0B  e806fe         call   0xdd14                  
F000:DF0E  f6c104         test   cl, 4                   
F000:DF11  7401           je     0xdf14                  
F000:DF13  f9             stc                            
F000:DF14  59             pop    cx                      
F000:DF15  c3             ret                            

;----- sub_DF32 -----
F000:DF32  52             push   dx                      
F000:DF33  50             push   ax                      
F000:DF34  b001           mov    al, 1                   
F000:DF36  e892fd         call   0xdccb                  
F000:DF39  a802           test   al, 2                   
F000:DF3B  7501           jne    0xdf3e                  
F000:DF3D  f9             stc                            
F000:DF3E  58             pop    ax                      
F000:DF3F  5a             pop    dx                      
F000:DF40  c3             ret                            

;----- sub_DF51 -----
F000:DF51  53             push   bx                      
F000:DF52  b33b           mov    bl, 0x3b                
F000:DF54  eb03           jmp    0xdf59                  

;----- sub_DF56 -----
F000:DF56  53             push   bx                      
F000:DF57  b321           mov    bl, 0x21                
F000:DF59  50             push   ax                      
F000:DF5A  e82800         call   0xdf85                  
F000:DF5D  3ac3           cmp    al, bl                  
F000:DF5F  f8             clc                            
F000:DF60  7501           jne    0xdf63                  
F000:DF62  f9             stc                            
F000:DF63  58             pop    ax                      
F000:DF64  5b             pop    bx                      
F000:DF65  c3             ret                            

;----- sub_DF85 -----
F000:DF85  51             push   cx                      
F000:DF86  b583           mov    ch, 0x83                
F000:DF88  e889fd         call   0xdd14                  
F000:DF8B  8ac1           mov    al, cl                  
F000:DF8D  59             pop    cx                      
F000:DF8E  c3             ret                            

;----- sub_DFB9 -----
F000:DFB9  52             push   dx                      
F000:DFBA  bafc03         mov    dx, 0x3fc               
F000:DFBD  32c0           xor    al, al                  
F000:DFBF  ee             out    dx, al                  
F000:DFC0  bafc02         mov    dx, 0x2fc               
F000:DFC3  ee             out    dx, al                  
F000:DFC4  5a             pop    dx                      
F000:DFC5  b80000         mov    ax, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:DFC8  c3             ret                            
F000:E000  2020           and    byte ptr [bx + si], ah  
F000:E002  2020           and    byte ptr [bx + si], ah  
F000:E004  2020           and    byte ptr [bx + si], ah  
F000:E006  2020           and    byte ptr [bx + si], ah  
F000:E008  43             inc    bx                      
F000:E009  4f             dec    di                      
F000:E00A  50             push   ax                      
F000:E00B  52             push   dx                      
F000:E00C  2e204942       and    byte ptr cs:[bx + di + 0x42], cl
F000:E010  4d             dec    bp                      
F000:E011  2031           and    byte ptr [bx + di], dh  
F000:E013  3938           cmp    word ptr [bx + si], di  
F000:E015  312c           xor    word ptr [si], bp       
F000:E017  2031           and    byte ptr [bx + di], dh  
F000:E019  3939           cmp    word ptr [bx + di], di  
F000:E01B  350000         xor    ax, 0                    ; "39H4551 (C) COPYRIGHT IBM CORPORATION 19"
F000:E01E  0000           add    byte ptr [bx + si], al  
F000:E020  0000           add    byte ptr [bx + si], al  
F000:E022  0000           add    byte ptr [bx + si], al  
F000:E024  0000           add    byte ptr [bx + si], al  
F000:E026  0000           add    byte ptr [bx + si], al  
F000:E028  0000           add    byte ptr [bx + si], al  
F000:E02A  0000           add    byte ptr [bx + si], al  
F000:E02C  0000           add    byte ptr [bx + si], al  
F000:E02E  0000           add    byte ptr [bx + si], al  
F000:E030  0000           add    byte ptr [bx + si], al  
F000:E032  0000           add    byte ptr [bx + si], al  
F000:E034  0000           add    byte ptr [bx + si], al  
F000:E036  0000           add    byte ptr [bx + si], al  
F000:E038  0000           add    byte ptr [bx + si], al  
F000:E03A  0000           add    byte ptr [bx + si], al  
F000:E03C  0000           add    byte ptr [bx + si], al  
F000:E03E  0000           add    byte ptr [bx + si], al  
F000:E040  0000           add    byte ptr [bx + si], al  
F000:E042  0000           add    byte ptr [bx + si], al  
F000:E044  0000           add    byte ptr [bx + si], al  
F000:E046  0000           add    byte ptr [bx + si], al  
F000:E048  0000           add    byte ptr [bx + si], al  
F000:E04A  0000           add    byte ptr [bx + si], al  
F000:E04C  0000           add    byte ptr [bx + si], al  
F000:E04E  0000           add    byte ptr [bx + si], al  
F000:E050  0000           add    byte ptr [bx + si], al  
F000:E052  0000           add    byte ptr [bx + si], al  
F000:E054  0000           add    byte ptr [bx + si], al  
F000:E056  0000           add    byte ptr [bx + si], al  
F000:E058  0000           add    byte ptr [bx + si], al  
F000:E05A  00e9           add    cl, ch                  

;----- sub_E05B -----
F000:E05B  e96c64         jmp    0x144ca                 
F000:E05C  6c             insb   byte ptr es:[di], dx    
F000:E05D  6490           nop                            
F000:E05F  90             nop                            
F000:E060  204b42         and    byte ptr [bp + di + 0x42], cl
F000:E063  204f4b         and    byte ptr [bx + 0x4b], cl
F000:E066  2000           and    byte ptr [bx + si], al  
F000:E068  0000           add    byte ptr [bx + si], al  
F000:E06A  0000           add    byte ptr [bx + si], al  
F000:E06C  0000           add    byte ptr [bx + si], al  
F000:E06E  0000           add    byte ptr [bx + si], al  
F000:E070  0000           add    byte ptr [bx + si], al  
F000:E072  0000           add    byte ptr [bx + si], al  
F000:E074  0000           add    byte ptr [bx + si], al  
F000:E076  0000           add    byte ptr [bx + si], al  
F000:E078  0000           add    byte ptr [bx + si], al  
F000:E07A  0000           add    byte ptr [bx + si], al  
F000:E07C  0000           add    byte ptr [bx + si], al  
F000:E07E  0000           add    byte ptr [bx + si], al  
F000:E080  0000           add    byte ptr [bx + si], al  
F000:E082  0000           add    byte ptr [bx + si], al  
F000:E084  0000           add    byte ptr [bx + si], al  
F000:E086  0000           add    byte ptr [bx + si], al  
F000:E088  0000           add    byte ptr [bx + si], al  
F000:E08A  0000           add    byte ptr [bx + si], al  
F000:E08C  0000           add    byte ptr [bx + si], al  
F000:E08E  0000           add    byte ptr [bx + si], al  
F000:E090  0000           add    byte ptr [bx + si], al  
F000:E092  0000           add    byte ptr [bx + si], al  
F000:E094  0000           add    byte ptr [bx + si], al  
F000:E096  0000           add    byte ptr [bx + si], al  
F000:E098  0000           add    byte ptr [bx + si], al  
F000:E09A  0000           add    byte ptr [bx + si], al  
F000:E09C  0000           add    byte ptr [bx + si], al  
F000:E09E  0000           add    byte ptr [bx + si], al  
F000:E0A0  0000           add    byte ptr [bx + si], al  
F000:E0A2  0000           add    byte ptr [bx + si], al  
F000:E0A4  0000           add    byte ptr [bx + si], al  
F000:E0A6  0000           add    byte ptr [bx + si], al  
F000:E0A8  0000           add    byte ptr [bx + si], al  
F000:E0AA  0000           add    byte ptr [bx + si], al  
F000:E0AC  0000           add    byte ptr [bx + si], al  
F000:E0AE  0000           add    byte ptr [bx + si], al  
F000:E0B0  0000           add    byte ptr [bx + si], al  
F000:E0B2  0000           add    byte ptr [bx + si], al  
F000:E0B4  0000           add    byte ptr [bx + si], al  
F000:E0B6  0000           add    byte ptr [bx + si], al  
F000:E0B8  0000           add    byte ptr [bx + si], al  
F000:E0BA  0000           add    byte ptr [bx + si], al  
F000:E0BC  0000           add    byte ptr [bx + si], al  
F000:E0BE  0000           add    byte ptr [bx + si], al  
F000:E0C0  0000           add    byte ptr [bx + si], al  
F000:E0C2  0000           add    byte ptr [bx + si], al  
F000:E0C4  0000           add    byte ptr [bx + si], al  
F000:E0C6  0000           add    byte ptr [bx + si], al  
F000:E0C8  0000           add    byte ptr [bx + si], al  
F000:E0CA  0000           add    byte ptr [bx + si], al  
F000:E0CC  0000           add    byte ptr [bx + si], al  
F000:E0CE  0000           add    byte ptr [bx + si], al  
F000:E0D0  0000           add    byte ptr [bx + si], al  
F000:E0D2  0000           add    byte ptr [bx + si], al  
F000:E0D4  0000           add    byte ptr [bx + si], al  
F000:E0D6  0000           add    byte ptr [bx + si], al  
F000:E0D8  0000           add    byte ptr [bx + si], al  
F000:E0DA  0000           add    byte ptr [bx + si], al  
F000:E0DC  0000           add    byte ptr [bx + si], al  
F000:E0DE  0000           add    byte ptr [bx + si], al  
F000:E0E0  0000           add    byte ptr [bx + si], al  
F000:E0E2  0000           add    byte ptr [bx + si], al  
F000:E0E4  0000           add    byte ptr [bx + si], al  
F000:E0E6  0000           add    byte ptr [bx + si], al  
F000:E0E8  0000           add    byte ptr [bx + si], al  
F000:E0EA  0000           add    byte ptr [bx + si], al  
F000:E0EC  0000           add    byte ptr [bx + si], al  
F000:E0EE  0000           add    byte ptr [bx + si], al  
F000:E0F0  0000           add    byte ptr [bx + si], al  
F000:E0F2  0000           add    byte ptr [bx + si], al  
F000:E0F4  0000           add    byte ptr [bx + si], al  
F000:E0F6  0000           add    byte ptr [bx + si], al  
F000:E0F8  0000           add    byte ptr [bx + si], al  
F000:E0FA  0000           add    byte ptr [bx + si], al  
F000:E0FC  0000           add    byte ptr [bx + si], al  
F000:E0FE  0000           add    byte ptr [bx + si], al  
F000:E100  0000           add    byte ptr [bx + si], al  
F000:E102  0000           add    byte ptr [bx + si], al  
F000:E104  0000           add    byte ptr [bx + si], al  
F000:E106  0000           add    byte ptr [bx + si], al  
F000:E108  0000           add    byte ptr [bx + si], al  
F000:E10A  0000           add    byte ptr [bx + si], al  
F000:E10C  0000           add    byte ptr [bx + si], al  
F000:E10E  0000           add    byte ptr [bx + si], al  
F000:E110  0000           add    byte ptr [bx + si], al  
F000:E112  0000           add    byte ptr [bx + si], al  
F000:E114  0000           add    byte ptr [bx + si], al  
F000:E116  0000           add    byte ptr [bx + si], al  
F000:E118  0000           add    byte ptr [bx + si], al  
F000:E11A  0000           add    byte ptr [bx + si], al  
F000:E11C  0000           add    byte ptr [bx + si], al  
F000:E11E  0000           add    byte ptr [bx + si], al  
F000:E120  0000           add    byte ptr [bx + si], al  
F000:E122  0000           add    byte ptr [bx + si], al  
F000:E124  0000           add    byte ptr [bx + si], al  
F000:E126  0000           add    byte ptr [bx + si], al  
F000:E128  0000           add    byte ptr [bx + si], al  
F000:E12A  0000           add    byte ptr [bx + si], al  
F000:E12C  0000           add    byte ptr [bx + si], al  
F000:E12E  0000           add    byte ptr [bx + si], al  
F000:E130  0000           add    byte ptr [bx + si], al  
F000:E132  0000           add    byte ptr [bx + si], al  
F000:E134  0000           add    byte ptr [bx + si], al  
F000:E136  0000           add    byte ptr [bx + si], al  
F000:E138  0000           add    byte ptr [bx + si], al  
F000:E13A  0000           add    byte ptr [bx + si], al  
F000:E13C  0000           add    byte ptr [bx + si], al  
F000:E13E  0000           add    byte ptr [bx + si], al  
F000:E140  0000           add    byte ptr [bx + si], al  
F000:E142  0000           add    byte ptr [bx + si], al  
F000:E144  0000           add    byte ptr [bx + si], al  
F000:E146  0000           add    byte ptr [bx + si], al  
F000:E148  0000           add    byte ptr [bx + si], al  
F000:E14A  0000           add    byte ptr [bx + si], al  
F000:E14C  0000           add    byte ptr [bx + si], al  
F000:E14E  0000           add    byte ptr [bx + si], al  
F000:E150  0000           add    byte ptr [bx + si], al  
F000:E152  0000           add    byte ptr [bx + si], al  
F000:E154  0000           add    byte ptr [bx + si], al  
F000:E156  0000           add    byte ptr [bx + si], al  
F000:E158  0000           add    byte ptr [bx + si], al  
F000:E15A  0000           add    byte ptr [bx + si], al  
F000:E15C  0000           add    byte ptr [bx + si], al  
F000:E15E  0000           add    byte ptr [bx + si], al  
F000:E160  0000           add    byte ptr [bx + si], al  
F000:E162  0000           add    byte ptr [bx + si], al  
F000:E164  0000           add    byte ptr [bx + si], al  
F000:E166  0000           add    byte ptr [bx + si], al  
F000:E168  0000           add    byte ptr [bx + si], al  
F000:E16A  0000           add    byte ptr [bx + si], al  
F000:E16C  0000           add    byte ptr [bx + si], al  
F000:E16E  0000           add    byte ptr [bx + si], al  
F000:E170  0000           add    byte ptr [bx + si], al  
F000:E172  0000           add    byte ptr [bx + si], al  
F000:E174  0000           add    byte ptr [bx + si], al  
F000:E176  0000           add    byte ptr [bx + si], al  
F000:E178  0000           add    byte ptr [bx + si], al  
F000:E17A  0000           add    byte ptr [bx + si], al  
F000:E17C  0000           add    byte ptr [bx + si], al  
F000:E17E  0000           add    byte ptr [bx + si], al  
F000:E180  0000           add    byte ptr [bx + si], al  
F000:E182  0000           add    byte ptr [bx + si], al  
F000:E184  0000           add    byte ptr [bx + si], al  
F000:E186  0000           add    byte ptr [bx + si], al  
F000:E188  0000           add    byte ptr [bx + si], al  
F000:E18A  0000           add    byte ptr [bx + si], al  
F000:E18C  0000           add    byte ptr [bx + si], al  
F000:E18E  0000           add    byte ptr [bx + si], al  
F000:E190  0000           add    byte ptr [bx + si], al  
F000:E192  0000           add    byte ptr [bx + si], al  
F000:E194  0000           add    byte ptr [bx + si], al  
F000:E196  0000           add    byte ptr [bx + si], al  
F000:E198  0000           add    byte ptr [bx + si], al  
F000:E19A  0000           add    byte ptr [bx + si], al  
F000:E19C  0000           add    byte ptr [bx + si], al  
F000:E19E  0000           add    byte ptr [bx + si], al  
F000:E1A0  0000           add    byte ptr [bx + si], al  
F000:E1A2  0000           add    byte ptr [bx + si], al  
F000:E1A4  0000           add    byte ptr [bx + si], al  
F000:E1A6  0000           add    byte ptr [bx + si], al  
F000:E1A8  0000           add    byte ptr [bx + si], al  
F000:E1AA  0000           add    byte ptr [bx + si], al  
F000:E1AC  0000           add    byte ptr [bx + si], al  
F000:E1AE  0000           add    byte ptr [bx + si], al  
F000:E1B0  0000           add    byte ptr [bx + si], al  
F000:E1B2  0000           add    byte ptr [bx + si], al  
F000:E1B4  0000           add    byte ptr [bx + si], al  
F000:E1B6  0000           add    byte ptr [bx + si], al  
F000:E1B8  0000           add    byte ptr [bx + si], al  
F000:E1BA  0000           add    byte ptr [bx + si], al  
F000:E1BC  0000           add    byte ptr [bx + si], al  
F000:E1BE  0000           add    byte ptr [bx + si], al  
F000:E1C0  0000           add    byte ptr [bx + si], al  
F000:E1C2  0000           add    byte ptr [bx + si], al  
F000:E1C4  0000           add    byte ptr [bx + si], al  
F000:E1C6  0000           add    byte ptr [bx + si], al  
F000:E1C8  0000           add    byte ptr [bx + si], al  
F000:E1CA  0000           add    byte ptr [bx + si], al  
F000:E1CC  0000           add    byte ptr [bx + si], al  
F000:E1CE  0000           add    byte ptr [bx + si], al  
F000:E1D0  0000           add    byte ptr [bx + si], al  
F000:E1D2  0000           add    byte ptr [bx + si], al  
F000:E1D4  0000           add    byte ptr [bx + si], al  
F000:E1D6  0000           add    byte ptr [bx + si], al  
F000:E1D8  0000           add    byte ptr [bx + si], al  
F000:E1DA  0000           add    byte ptr [bx + si], al  
F000:E1DC  0000           add    byte ptr [bx + si], al  
F000:E1DE  0000           add    byte ptr [bx + si], al  
F000:E1E0  0000           add    byte ptr [bx + si], al  
F000:E1E2  0000           add    byte ptr [bx + si], al  
F000:E1E4  0000           add    byte ptr [bx + si], al  
F000:E1E6  0000           add    byte ptr [bx + si], al  
F000:E1E8  0000           add    byte ptr [bx + si], al  
F000:E1EA  0000           add    byte ptr [bx + si], al  
F000:E1EC  0000           add    byte ptr [bx + si], al  
F000:E1EE  0000           add    byte ptr [bx + si], al  
F000:E1F0  0000           add    byte ptr [bx + si], al  
F000:E1F2  0000           add    byte ptr [bx + si], al  
F000:E1F4  0000           add    byte ptr [bx + si], al  
F000:E1F6  0000           add    byte ptr [bx + si], al  
F000:E1F8  0000           add    byte ptr [bx + si], al  
F000:E1FA  0000           add    byte ptr [bx + si], al  
F000:E1FC  0000           add    byte ptr [bx + si], al  
F000:E1FE  0000           add    byte ptr [bx + si], al  
F000:E200  0000           add    byte ptr [bx + si], al  
F000:E202  0000           add    byte ptr [bx + si], al  
F000:E204  0000           add    byte ptr [bx + si], al  
F000:E206  0000           add    byte ptr [bx + si], al  
F000:E208  0000           add    byte ptr [bx + si], al  
F000:E20A  0000           add    byte ptr [bx + si], al  
F000:E20C  0000           add    byte ptr [bx + si], al  
F000:E20E  0000           add    byte ptr [bx + si], al  
F000:E210  0000           add    byte ptr [bx + si], al  
F000:E212  0000           add    byte ptr [bx + si], al  
F000:E214  0000           add    byte ptr [bx + si], al  
F000:E216  0000           add    byte ptr [bx + si], al  
F000:E218  0000           add    byte ptr [bx + si], al  
F000:E21A  0000           add    byte ptr [bx + si], al  
F000:E21C  0000           add    byte ptr [bx + si], al  
F000:E21E  0000           add    byte ptr [bx + si], al  
F000:E220  0000           add    byte ptr [bx + si], al  
F000:E222  0000           add    byte ptr [bx + si], al  
F000:E224  0000           add    byte ptr [bx + si], al  
F000:E226  0000           add    byte ptr [bx + si], al  
F000:E228  0000           add    byte ptr [bx + si], al  
F000:E22A  0000           add    byte ptr [bx + si], al  
F000:E22C  0000           add    byte ptr [bx + si], al  
F000:E22E  0000           add    byte ptr [bx + si], al  
F000:E230  0000           add    byte ptr [bx + si], al  
F000:E232  0000           add    byte ptr [bx + si], al  
F000:E234  0000           add    byte ptr [bx + si], al  
F000:E236  0000           add    byte ptr [bx + si], al  
F000:E238  0000           add    byte ptr [bx + si], al  
F000:E23A  0000           add    byte ptr [bx + si], al  
F000:E23C  0000           add    byte ptr [bx + si], al  
F000:E23E  0000           add    byte ptr [bx + si], al  
F000:E240  0000           add    byte ptr [bx + si], al  
F000:E242  0000           add    byte ptr [bx + si], al  
F000:E244  0000           add    byte ptr [bx + si], al  
F000:E246  0000           add    byte ptr [bx + si], al  
F000:E248  0000           add    byte ptr [bx + si], al  
F000:E24A  0000           add    byte ptr [bx + si], al  
F000:E24C  0000           add    byte ptr [bx + si], al  
F000:E24E  0000           add    byte ptr [bx + si], al  
F000:E250  0000           add    byte ptr [bx + si], al  
F000:E252  0000           add    byte ptr [bx + si], al  
F000:E254  0000           add    byte ptr [bx + si], al  
F000:E256  0000           add    byte ptr [bx + si], al  
F000:E258  0000           add    byte ptr [bx + si], al  
F000:E25A  0000           add    byte ptr [bx + si], al  
F000:E25C  0000           add    byte ptr [bx + si], al  
F000:E25E  0000           add    byte ptr [bx + si], al  
F000:E260  0000           add    byte ptr [bx + si], al  
F000:E262  0000           add    byte ptr [bx + si], al  
F000:E264  0000           add    byte ptr [bx + si], al  
F000:E266  0000           add    byte ptr [bx + si], al  
F000:E268  0000           add    byte ptr [bx + si], al  
F000:E26A  0000           add    byte ptr [bx + si], al  
F000:E26C  0000           add    byte ptr [bx + si], al  
F000:E26E  0000           add    byte ptr [bx + si], al  
F000:E270  0000           add    byte ptr [bx + si], al  
F000:E272  0000           add    byte ptr [bx + si], al  
F000:E274  0000           add    byte ptr [bx + si], al  
F000:E276  0000           add    byte ptr [bx + si], al  
F000:E278  0000           add    byte ptr [bx + si], al  
F000:E27A  0000           add    byte ptr [bx + si], al  
F000:E27C  0000           add    byte ptr [bx + si], al  
F000:E27E  0000           add    byte ptr [bx + si], al  
F000:E280  0000           add    byte ptr [bx + si], al  
F000:E282  0000           add    byte ptr [bx + si], al  
F000:E284  0000           add    byte ptr [bx + si], al  
F000:E286  0000           add    byte ptr [bx + si], al  
F000:E288  0000           add    byte ptr [bx + si], al  
F000:E28A  0000           add    byte ptr [bx + si], al  
F000:E28C  0000           add    byte ptr [bx + si], al  
F000:E28E  0000           add    byte ptr [bx + si], al  
F000:E290  0000           add    byte ptr [bx + si], al  
F000:E292  0000           add    byte ptr [bx + si], al  
F000:E294  0000           add    byte ptr [bx + si], al  
F000:E296  0000           add    byte ptr [bx + si], al  
F000:E298  0000           add    byte ptr [bx + si], al  
F000:E29A  0000           add    byte ptr [bx + si], al  
F000:E29C  0000           add    byte ptr [bx + si], al  
F000:E29E  0000           add    byte ptr [bx + si], al  
F000:E2A0  0000           add    byte ptr [bx + si], al  
F000:E2A2  0000           add    byte ptr [bx + si], al  
F000:E2A4  0000           add    byte ptr [bx + si], al  
F000:E2A6  0000           add    byte ptr [bx + si], al  
F000:E2A8  0000           add    byte ptr [bx + si], al  
F000:E2AA  0000           add    byte ptr [bx + si], al  
F000:E2AC  0000           add    byte ptr [bx + si], al  
F000:E2AE  0000           add    byte ptr [bx + si], al  
F000:E2B0  0000           add    byte ptr [bx + si], al  
F000:E2B2  0000           add    byte ptr [bx + si], al  
F000:E2B4  0000           add    byte ptr [bx + si], al  
F000:E2B6  0000           add    byte ptr [bx + si], al  
F000:E2B8  0000           add    byte ptr [bx + si], al  
F000:E2BA  0000           add    byte ptr [bx + si], al  
F000:E2BC  0000           add    byte ptr [bx + si], al  
F000:E2BE  0000           add    byte ptr [bx + si], al  
F000:E2C0  0000           add    byte ptr [bx + si], al  
F000:E2C2  00e9           add    cl, ch                  
F000:E2C4  25af31         and    ax, 0x31af              
F000:E2C7  3130           xor    word ptr [bx + si], si  
F000:E2C9  0d0a31         or     ax, 0x310a              
F000:E2CC  3131           xor    word ptr [bx + di], si  
F000:E2CE  0d0a3f         or     ax, 0x3f0a              
F000:E2D1  3f             aas                            
F000:E2D2  3f             aas                            
F000:E2D3  3f             aas                            
F000:E2D4  3f             aas                            
F000:E2D5  0d0a20         or     ax, 0x200a              
F000:E2D8  3130           xor    word ptr [bx + si], si  
F000:E2DA  310d           xor    word ptr [di], cx       
F000:E2DC  0a20           or     ah, byte ptr [bx + si]  
F000:E2DE  3130           xor    word ptr [bx + si], si  
F000:E2E0  320d           xor    cl, byte ptr [di]       
F000:E2E2  0a20           or     ah, byte ptr [bx + si]  
F000:E2E4  3130           xor    word ptr [bx + si], si  
F000:E2E6  330d           xor    cx, word ptr [di]       
F000:E2E8  0a20           or     ah, byte ptr [bx + si]  
F000:E2EA  3130           xor    word ptr [bx + si], si  
F000:E2EC  340d           xor    al, 0xd                 
F000:E2EE  0a20           or     ah, byte ptr [bx + si]  
F000:E2F0  3130           xor    word ptr [bx + si], si  
F000:E2F2  350d0a         xor    ax, 0xa0d               
F000:E2F5  2031           and    byte ptr [bx + di], dh  
F000:E2F7  3037           xor    byte ptr [bx], dh       
F000:E2F9  0d0a20         or     ax, 0x200a              
F000:E2FC  3130           xor    word ptr [bx + si], si  
F000:E2FE  380d           cmp    byte ptr [di], cl       
F000:E300  0a20           or     ah, byte ptr [bx + si]  
F000:E302  3130           xor    word ptr [bx + si], si  
F000:E304  390d           cmp    word ptr [di], cx       
F000:E306  0a20           or     ah, byte ptr [bx + si]  
F000:E308  3131           xor    word ptr [bx + di], si  
F000:E30A  300d           xor    byte ptr [di], cl       
F000:E30C  0a20           or     ah, byte ptr [bx + si]  
F000:E30E  3131           xor    word ptr [bx + di], si  
F000:E310  310d           xor    word ptr [di], cx       
F000:E312  0a20           or     ah, byte ptr [bx + si]  
F000:E314  3131           xor    word ptr [bx + di], si  
F000:E316  320d           xor    cl, byte ptr [di]       
F000:E318  0a20           or     ah, byte ptr [bx + si]  
F000:E31A  3131           xor    word ptr [bx + di], si  
F000:E31C  330d           xor    cx, word ptr [di]       
F000:E31E  0a20           or     ah, byte ptr [bx + si]  
F000:E320  3131           xor    word ptr [bx + di], si  
F000:E322  350d0a         xor    ax, 0xa0d               
F000:E325  2031           and    byte ptr [bx + di], dh  
F000:E327  3138           xor    word ptr [bx + si], di  
F000:E329  0d0a20         or     ax, 0x200a              
F000:E32C  3135           xor    word ptr [di], si       
F000:E32E  380d           cmp    byte ptr [di], cl       
F000:E330  0a20           or     ah, byte ptr [bx + si]  
F000:E332  3135           xor    word ptr [di], si       
F000:E334  390d           cmp    word ptr [di], cx       
F000:E336  0a20           or     ah, byte ptr [bx + si]  
F000:E338  3136310d       xor    word ptr [0xd31], si    
F000:E33C  0a20           or     ah, byte ptr [bx + si]  
F000:E33E  3136320d       xor    word ptr [0xd32], si    
F000:E342  0a20           or     ah, byte ptr [bx + si]  
F000:E344  3136330d       xor    word ptr [0xd33], si    
F000:E348  0a20           or     ah, byte ptr [bx + si]  
F000:E34A  3136340d       xor    word ptr [0xd34], si    
F000:E34E  0a20           or     ah, byte ptr [bx + si]  
F000:E350  3136350d       xor    word ptr [0xd35], si    
F000:E354  0a20           or     ah, byte ptr [bx + si]  
F000:E356  3136360d       xor    word ptr [0xd36], si    
F000:E35A  0a20           or     ah, byte ptr [bx + si]  
F000:E35C  3137           xor    word ptr [bx], si       
F000:E35E  330d           xor    cx, word ptr [di]       
F000:E360  0a20           or     ah, byte ptr [bx + si]  
F000:E362  3137           xor    word ptr [bx], si       
F000:E364  340d           xor    al, 0xd                 
F000:E366  0a20           or     ah, byte ptr [bx + si]  
F000:E368  3137           xor    word ptr [bx], si       
F000:E36A  350d0a         xor    ax, 0xa0d               
F000:E36D  2031           and    byte ptr [bx + di], dh  
F000:E36F  37             aaa                            
F000:E370  360d0a20       or     ax, 0x200a              
F000:E374  3137           xor    word ptr [bx], si       
F000:E376  37             aaa                            
F000:E377  0d0a20         or     ax, 0x200a              
F000:E37A  3137           xor    word ptr [bx], si       
F000:E37C  380d           cmp    byte ptr [di], cl       
F000:E37E  0a20           or     ah, byte ptr [bx + si]  
F000:E380  3137           xor    word ptr [bx], si       
F000:E382  390d           cmp    word ptr [di], cx       
F000:E384  0a20           or     ah, byte ptr [bx + si]  
F000:E386  3138           xor    word ptr [bx + si], di  
F000:E388  310d           xor    word ptr [di], cx       
F000:E38A  0a20           or     ah, byte ptr [bx + si]  
F000:E38C  3138           xor    word ptr [bx + si], di  
F000:E38E  320d           xor    cl, byte ptr [di]       
F000:E390  0a20           or     ah, byte ptr [bx + si]  
F000:E392  3138           xor    word ptr [bx + si], di  
F000:E394  330d           xor    cx, word ptr [di]       
F000:E396  0a20           or     ah, byte ptr [bx + si]  
F000:E398  3138           xor    word ptr [bx + si], di  
F000:E39A  340d           xor    al, 0xd                 
F000:E39C  0a20           or     ah, byte ptr [bx + si]  
F000:E39E  3138           xor    word ptr [bx + si], di  
F000:E3A0  350d0a         xor    ax, 0xa0d               
F000:E3A3  2031           and    byte ptr [bx + di], dh  
F000:E3A5  38360d0a       cmp    byte ptr [0xa0d], dh    
F000:E3A9  2031           and    byte ptr [bx + di], dh  
F000:E3AB  3837           cmp    byte ptr [bx], dh       
F000:E3AD  0d0a20         or     ax, 0x200a              
F000:E3B0  3138           xor    word ptr [bx + si], di  
F000:E3B2  380d           cmp    byte ptr [di], cl       
F000:E3B4  0a20           or     ah, byte ptr [bx + si]  
F000:E3B6  3138           xor    word ptr [bx + si], di  
F000:E3B8  390d           cmp    word ptr [di], cx       
F000:E3BA  0a20           or     ah, byte ptr [bx + si]  
F000:E3BC  3139           xor    word ptr [bx + di], di  
F000:E3BE  300d           xor    byte ptr [di], cl       
F000:E3C0  0a20           or     ah, byte ptr [bx + si]  
F000:E3C2  3139           xor    word ptr [bx + di], di  
F000:E3C4  310d           xor    word ptr [di], cx       
F000:E3C6  0a20           or     ah, byte ptr [bx + si]  
F000:E3C8  3139           xor    word ptr [bx + di], di  
F000:E3CA  350d0a         xor    ax, 0xa0d               
F000:E3CD  2031           and    byte ptr [bx + di], dh  
F000:E3CF  39360d0a       cmp    word ptr [0xa0d], si    
F000:E3D3  2031           and    byte ptr [bx + di], dh  
F000:E3D5  3937           cmp    word ptr [bx], si       
F000:E3D7  0d0a20         or     ax, 0x200a              
F000:E3DA  3230           xor    dh, byte ptr [bx + si]  
F000:E3DC  310d           xor    word ptr [di], cx       
F000:E3DE  0a20           or     ah, byte ptr [bx + si]  
F000:E3E0  3230           xor    dh, byte ptr [bx + si]  
F000:E3E2  320d           xor    cl, byte ptr [di]       
F000:E3E4  0a20           or     ah, byte ptr [bx + si]  
F000:E3E6  3230           xor    dh, byte ptr [bx + si]  
F000:E3E8  330d           xor    cx, word ptr [di]       
F000:E3EA  0a20           or     ah, byte ptr [bx + si]  
F000:E3EC  3330           xor    si, word ptr [bx + si]  
F000:E3EE  310d           xor    word ptr [di], cx       
F000:E3F0  0a20           or     ah, byte ptr [bx + si]  
F000:E3F2  3330           xor    si, word ptr [bx + si]  
F000:E3F4  330d           xor    cx, word ptr [di]       
F000:E3F6  0a20           or     ah, byte ptr [bx + si]  
F000:E3F8  3232           xor    dh, byte ptr [bp + si]  
F000:E3FA  350d0a         xor    ax, 0xa0d               
F000:E3FD  2032           and    byte ptr [bp + si], dh  
F000:E3FE  3232           xor    dh, byte ptr [bp + si]  
F000:E3FF  3231           xor    dh, byte ptr [bx + di]  
F000:E400  310d           xor    word ptr [di], cx       
F000:E401  0d0a20         or     ax, 0x200a              
F000:E402  0a20           or     ah, byte ptr [bx + si]  
F000:E404  3233           xor    dh, byte ptr [bp + di]  
F000:E406  300d           xor    byte ptr [di], cl       
F000:E408  0a20           or     ah, byte ptr [bx + si]  
F000:E40A  3330           xor    si, word ptr [bx + si]  
F000:E40C  340d           xor    al, 0xd                 
F000:E40E  0a20           or     ah, byte ptr [bx + si]  
F000:E410  3330           xor    si, word ptr [bx + si]  
F000:E412  350d0a         xor    ax, 0xa0d               
F000:E415  3234           xor    dh, byte ptr [si]       
F000:E417  3031           xor    byte ptr [bx + di], dh  
F000:E419  0d0a20         or     ax, 0x200a              
F000:E41C  3430           xor    al, 0x30                
F000:E41E  310d           xor    word ptr [di], cx       
F000:E420  0a20           or     ah, byte ptr [bx + si]  
F000:E422  363031         xor    byte ptr ss:[bx + di], dh
F000:E425  0d0a20         or     ax, 0x200a              
F000:E428  363034         xor    byte ptr ss:[si], dh    
F000:E42B  0d0a20         or     ax, 0x200a              
F000:E42E  363032         xor    byte ptr ss:[bp + si], dh
F000:E431  0d0a20         or     ax, 0x200a              
F000:E434  363033         xor    byte ptr ss:[bp + di], dh
F000:E437  0d0a31         or     ax, 0x310a              
F000:E43A  37             aaa                            
F000:E43B  3031           xor    byte ptr [bx + di], dh  
F000:E43D  0d0a31         or     ax, 0x310a              
F000:E440  37             aaa                            
F000:E441  3830           cmp    byte ptr [bx + si], dh  
F000:E443  0d0a31         or     ax, 0x310a              
F000:E446  37             aaa                            
F000:E447  3831           cmp    byte ptr [bx + di], dh  
F000:E449  0d0a31         or     ax, 0x310a              
F000:E44C  37             aaa                            
F000:E44D  3832           cmp    byte ptr [bp + si], dh  
F000:E44F  0d0a31         or     ax, 0x310a              
F000:E452  37             aaa                            
F000:E453  3930           cmp    word ptr [bx + si], si  
F000:E455  0d0a31         or     ax, 0x310a              
F000:E458  37             aaa                            
F000:E459  3931           cmp    word ptr [bx + di], si  
F000:E45B  0d0a20         or     ax, 0x200a              
F000:E45E  3131           xor    word ptr [bx + di], si  
F000:E460  340d           xor    al, 0xd                 
F000:E462  0a31           or     dh, byte ptr [bx + di]  
F000:E464  3130           xor    word ptr [bx + si], si  
F000:E466  310d           xor    word ptr [di], cx       
F000:E468  0a31           or     dh, byte ptr [bx + di]  
F000:E46A  3230           xor    dh, byte ptr [bx + si]  
F000:E46C  310d           xor    word ptr [di], cx       
F000:E46E  0a34           or     dh, byte ptr [si]       
F000:E470  3130           xor    word ptr [bx + si], si  
F000:E472  310d           xor    word ptr [di], cx       
F000:E474  0a38           or     bh, byte ptr [bx + si]  
F000:E476  3038           xor    byte ptr [bx + si], bh  
F000:E478  310d           xor    word ptr [di], cx       
F000:E47A  0a38           or     bh, byte ptr [bx + si]  
F000:E47C  3038           xor    byte ptr [bx + si], bh  
F000:E47E  320d           xor    cl, byte ptr [di]       
F000:E480  0a38           or     bh, byte ptr [bx + si]  
F000:E482  363031         xor    byte ptr ss:[bx + di], dh
F000:E485  0d0a38         or     ax, 0x380a              
F000:E488  363032         xor    byte ptr ss:[bp + si], dh
F000:E48B  0d0a38         or     ax, 0x380a              
F000:E48E  363033         xor    byte ptr ss:[bp + di], dh
F000:E491  0d0a38         or     ax, 0x380a              
F000:E494  363131         xor    word ptr ss:[bx + di], si
F000:E497  0d0a38         or     ax, 0x380a              
F000:E49A  363132         xor    word ptr ss:[bp + si], si
F000:E49D  0d0a38         or     ax, 0x380a              
F000:E4A0  363133         xor    word ptr ss:[bp + di], si
F000:E4A3  0d0a49         or     ax, 0x490a              
F000:E4A6  3939           cmp    word ptr [bx + di], di  
F000:E4A8  3930           cmp    word ptr [bx + si], si  
F000:E4AA  3330           xor    si, word ptr [bx + si]  
F000:E4AC  310d           xor    word ptr [di], cx       
F000:E4AE  0a4939         or     cl, byte ptr [bx + di + 0x39]
F000:E4B1  3939           cmp    word ptr [bx + di], di  
F000:E4B3  3033           xor    byte ptr [bp + di], dh  
F000:E4B5  3032           xor    byte ptr [bp + si], dh  
F000:E4B7  0d0a49         or     ax, 0x490a              
F000:E4BA  3939           cmp    word ptr [bx + di], di  
F000:E4BC  3930           cmp    word ptr [bx + si], si  
F000:E4BE  3330           xor    si, word ptr [bx + si]  
F000:E4C0  330d           xor    cx, word ptr [di]       
F000:E4C2  0a4939         or     cl, byte ptr [bx + di + 0x39]
F000:E4C5  3939           cmp    word ptr [bx + di], di  
F000:E4C7  3033           xor    byte ptr [bp + di], dh  
F000:E4C9  3034           xor    byte ptr [si], dh       
F000:E4CB  0d0a49         or     ax, 0x490a              
F000:E4CE  3939           cmp    word ptr [bx + di], di  
F000:E4D0  3930           cmp    word ptr [bx + si], si  
F000:E4D2  3330           xor    si, word ptr [bx + si]  
F000:E4D4  350d0a         xor    ax, 0xa0d               
F000:E4D7  49             dec    cx                      
F000:E4D8  3939           cmp    word ptr [bx + di], di  
F000:E4DA  3930           cmp    word ptr [bx + si], si  
F000:E4DC  3330           xor    si, word ptr [bx + si]  
F000:E4DE  360d0a49       or     ax, 0x490a              
F000:E4E2  3939           cmp    word ptr [bx + di], di  
F000:E4E4  3930           cmp    word ptr [bx + si], si  
F000:E4E6  3430           xor    al, 0x30                
F000:E4E8  310d           xor    word ptr [di], cx       
F000:E4EA  0a00           or     al, byte ptr [bx + si]  
F000:E4EC  003d           add    byte ptr [di], bh       
F000:E4EE  052020         add    ax, 0x2020              
F000:E4F1  02871902       add    al, byte ptr [bx + 0x219]
F000:E4F5  8719           xchg   word ptr [bx + di], bx  
F000:E4F7  0320           add    sp, word ptr [bx + si]  
F000:E4F9  2002           and    byte ptr [bp + si], al  
F000:E4FB  8719           xchg   word ptr [bx + di], bx  
F000:E4FD  02871920       add    al, byte ptr [bx + 0x2019]
F000:E501  da01           fiadd  dword ptr [bx + di]     
F000:E503  04c4           add    al, 0xc4                
F000:E505  050a05         add    ax, 0x50a               
F000:E508  c2c4c4         ret    0xc4c4                  
F000:E6F2  50             push   ax                      
F000:E6F3  b801c5         mov    ax, 0xc501              
F000:E6F6  cd15           int    0x15                     ; BIOS service
F000:E6F8  58             pop    ax                      
F000:E6F9  e9e896         jmp    0x7de4                  
F000:E739  50             push   ax                      
F000:E73A  b802c5         mov    ax, 0xc502              
F000:E73D  cd15           int    0x15                     ; BIOS service
F000:E73F  58             pop    ax                      
F000:E740  e90bba         jmp    0xa14e                  
F000:E82E  50             push   ax                      
F000:E82F  b803c5         mov    ax, 0xc503              
F000:E832  cd15           int    0x15                     ; BIOS service
F000:E834  58             pop    ax                      
F000:E835  e970c5         jmp    0xada8                  
F000:E987  e904c6         jmp    0xaf8e                   ; "UPSQRVW"

;----- sub_E990 -----
F000:E990  9c             pushf                          
F000:E991  d0c0           rol    al, 1                   
F000:E993  f9             stc                            
F000:E994  d0d8           rcr    al, 1                   
F000:E996  fa             cli                            
F000:E997  e670           out    0x70, al                 ; RTC index
F000:E999  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:E99B  e471           in     al, 0x71                 ; RTC data
F000:E99D  50             push   ax                      
F000:E99E  b01e           mov    al, 0x1e                
F000:E9A0  d0d8           rcr    al, 1                   
F000:E9A2  e670           out    0x70, al                 ; RTC index
F000:E9A4  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:E9A6  e471           in     al, 0x71                 ; RTC data
F000:E9A8  58             pop    ax                      
F000:E9A9  9d             popf                           
F000:E9AA  c3             ret                            

;----- sub_E9C6 -----
F000:E9C6  9c             pushf                          
F000:E9C7  50             push   ax                      
F000:E9C8  e80300         call   0xe9ce                  
F000:E9CB  58             pop    ax                      
F000:E9CC  9d             popf                           
F000:E9CD  c3             ret                            

;----- sub_E9CE -----
F000:E9CE  d0c0           rol    al, 1                   
F000:E9D0  f9             stc                            
F000:E9D1  d0d8           rcr    al, 1                   
F000:E9D3  fa             cli                            
F000:E9D4  e670           out    0x70, al                 ; RTC index
F000:E9D6  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:E9D8  8ac4           mov    al, ah                  
F000:E9DA  e671           out    0x71, al                 ; RTC data
F000:E9DC  b01e           mov    al, 0x1e                
F000:E9DE  d0d8           rcr    al, 1                   
F000:E9E0  e670           out    0x70, al                 ; RTC index
F000:E9E2  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:E9E4  e471           in     al, 0x71                 ; RTC data
F000:E9E6  c3             ret                            

;----- sub_E9FF -----
F000:E9FF  2e8e1e05ea     mov    ds, word ptr cs:[0xea05]
F000:EA04  c3             ret                            

;----- sub_EA07 -----
F000:EA07  2e8e1e05ea     mov    ds, word ptr cs:[0xea05]
F000:EA0C  8e1e0e00       mov    ds, word ptr [0xe]      
F000:EA10  c3             ret                            

;----- sub_EA11 -----
F000:EA11  1e             push   ds                      
F000:EA12  2e8e1e05ea     mov    ds, word ptr cs:[0xea05]
F000:EA17  8e060e00       mov    es, word ptr [0xe]      
F000:EA1B  1f             pop    ds                      
F000:EA1C  c3             ret                            
F000:EA1F  ff813e72       inc    word ptr [bx + di + 0x723e]
F000:EA23  0034           add    byte ptr [si], dh       
F000:EA25  12c3           adc    al, bl                  
F000:EA27  813e72002143   cmp    word ptr [0x72], 0x4321 
F000:EA2D  c3             ret                            

;----- sub_EA2E -----
F000:EA2E  e8ceff         call   0xe9ff                  

;----- sub_EA31 -----
F000:EA31  813e7200dcfe   cmp    word ptr [0x72], 0xfedc 
F000:EA37  c3             ret                            

;----- sub_EA38 -----
F000:EA38  9c             pushf                          
F000:EA39  fa             cli                            
F000:EA3A  b0b6           mov    al, 0xb6                
F000:EA3C  e643           out    0x43, al                 ; PITctl
F000:EA3E  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:EA40  8ac1           mov    al, cl                  
F000:EA42  e642           out    0x42, al                 ; PIT2/spkr
F000:EA44  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:EA46  8ac5           mov    al, ch                  
F000:EA48  e642           out    0x42, al                 ; PIT2/spkr
F000:EA4A  e64f           out    0x4f, al                 ; PC110 cfg latch/index
F000:EA4C  e461           in     al, 0x61                 ; PortB/spkr
F000:EA4E  8ae0           mov    ah, al                  
F000:EA50  0c03           or     al, 3                   
F000:EA52  e661           out    0x61, al                 ; PortB/spkr
F000:EA54  9d             popf                           
F000:EA55  b90b04         mov    cx, 0x40b               
F000:EA58  e82500         call   0xea80                  
F000:EA5B  fecb           dec    bl                      
F000:EA5D  75f6           jne    0xea55                  
F000:EA5F  9c             pushf                          
F000:EA60  fa             cli                            
F000:EA61  e461           in     al, 0x61                 ; PortB/spkr
F000:EA63  0cfc           or     al, 0xfc                
F000:EA65  22e0           and    ah, al                  
F000:EA67  8ac4           mov    al, ah                  
F000:EA69  24fc           and    al, 0xfc                
F000:EA6B  e661           out    0x61, al                 ; PortB/spkr
F000:EA6D  9d             popf                           
F000:EA6E  b90b04         mov    cx, 0x40b               
F000:EA71  e80c00         call   0xea80                  
F000:EA74  9c             pushf                          
F000:EA75  fa             cli                            
F000:EA76  e461           in     al, 0x61                 ; PortB/spkr
F000:EA78  2403           and    al, 3                   
F000:EA7A  0ac4           or     al, ah                  
F000:EA7C  e661           out    0x61, al                 ; PortB/spkr
F000:EA7E  9d             popf                           
F000:EA7F  c3             ret                            

;----- sub_EA80 -----
F000:EA80  50             push   ax                      
F000:EA81  e80200         call   0xea86                  
F000:EA84  58             pop    ax                      
F000:EA85  c3             ret                            

;----- sub_EA86 -----
F000:EA86  e461           in     al, 0x61                 ; PortB/spkr
F000:EA88  2410           and    al, 0x10                
F000:EA8A  3ac4           cmp    al, ah                  
F000:EA8C  74f8           je     0xea86                  
F000:EA8E  8ae0           mov    ah, al                  
F000:EA90  e2f4           loop   0xea86                  
F000:EA92  c3             ret                            
F000:EC59  50             push   ax                      
F000:EC5A  b804c5         mov    ax, 0xc504              
F000:EC5D  cd15           int    0x15                     ; BIOS service
F000:EC5F  58             pop    ax                      
F000:EC60  e915cf         jmp    0xbb78                  
F000:F065  50             push   ax                      
F000:F066  b806c5         mov    ax, 0xc506              
F000:F069  cd15           int    0x15                     ; BIOS service
F000:F06B  58             pop    ax                      
F000:F06C  cf             iret                           
F000:F841  50             push   ax                      
F000:F842  b807c5         mov    ax, 0xc507              
F000:F845  cd15           int    0x15                     ; BIOS service
F000:F847  58             pop    ax                      
F000:F848  e9fdc1         jmp    0xba48                  
F000:FE6E  50             push   ax                      
F000:FE6F  b809c5         mov    ax, 0xc509              
F000:FE72  cd15           int    0x15                     ; BIOS service
F000:FE74  58             pop    ax                      
F000:FE75  e9969f         jmp    0x9e0e                  
F000:FF53  cf             iret                           
