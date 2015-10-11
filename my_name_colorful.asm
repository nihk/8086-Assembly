org 100h	     

mov AX, 0xB800  	 ; set AX = 0xB800 (segment of video memory)
mov DS, AX      	 ; copy value of AX to Data Segment or DS register

mov CL, 'N'     	 ; set ASCII letter
mov CH, 11011011b	 ; set initial foreground/background colours
call printNextLetter

mov CL, 'i' 
call printNextLetter

mov CL, 'c' 
call printNextLetter

mov CL, 'k' 
call printNextLetter

ret                  ; Return to OS
                
printNextLetter PROC
  cmp BX, 0x0000
  je initializeBX    ; BX isn't centered yet, make that so

  add BX, 0x2        ; next letter display position
  ror CH, 0x1        ; rotate to get "random" colour combinations  
  
  back: 
    mov DS:BX, CX    ; display letter on console
    ret              ; Return to caller         
  
initializeBX:
  mov BX, 0x0048     ; more or less center of console
  jmp back