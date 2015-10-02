org 100h

;Evaluate 0x44 + 0x20      
mov AL, 0x44
mov BL, 0x20
add AL, BL  

;Evaluate (unsigned) 1011b - 0111b 
mov AL, 1011b
mov BL, 0111b
sub AL, BL

;Evaluate 20 / 3
mov AX, 20d
mov BL, 3d
div BL             ; 20/3 = 6r2
                   ; 6 is put in AL, 2 in AH
   
       
;Evaluate 0xFFFF * 0xFFFF       
mov AX, 0xFFFF
mov BX, 0xFFFF
mul BX             ; AX can't hold the whole number so
                   ; DX takes the first two overflow bytes.  
                   ; answer = FF FE 00 01
  
;Write to memory
mov AL, 0xCF
mov BX, 0x200     
mov [BX], 0x30    ; mov 30h to the BX memory (view --> memory in emu)
                  ; (0700:0200) will update from 00 to 30
mul [BX]          ; 30h * 0xCF, answer in AX register


ret