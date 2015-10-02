
org 100h
      
;mov AL, 44h
;mov CL, 20h
;add AL, CL
;mov BX, 0xAB
;mov [BX], AL
;mov [0x98], AL
;mov [0x20E], 37         

;mov AL, 11111111b ; 255
;mov BL, 00001001b ; 9
;mul BL            ; 255 * 9 = 2295 or 08F7h in AX
;
;mov AX, 0xFFFF
;mov BX, 0xFFFF
;mul BX            ; AX can't hold the whole number so
;                  ; DX takes the overflow high byte  
;                  ; 8A4500
;mov CH, 0x44       

mov AL, 0xCF
mov BX, 0x200     
mov [BX], 30h     ; mov 30h to the BX memory (view --> memory in emu)
                  ; (0700:0200) will update from 00 to 30
mul [BX]          ; 30h * CF, answer in AX register

;Evaluate 20 / 3
mov AX, 20
mov BL, 3
div BL             ; 20/3 = 6r2
                   ; 6 is put in AL, 2 in AH

;Evaluate 420 * 300
mov AX, 420
mov BX, 300
mul BX

ret
