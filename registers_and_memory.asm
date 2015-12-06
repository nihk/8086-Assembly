
org 100h

; how registers work in conjunction with memory

push 1000h
pop DS

mov DS:BX, 5    ; puts the value 5 at 1000:0000

mov BX, 6       ; put the value 6 in the BX register, but
                ; consequently change the DS:BX address
                ; to 1000:0006

mov [BX], BX    ; puts the value 6 at address 1000:0006
                ; [BX] by default is DS:BX.
                ; Line 8 could've alternatively been e.g. ES:BX

; changing where variables point to, somewhat indirectly

push 700h
pop DS          ; "reset" DS back to original value  
  
mov AL, myvar   ; puts myvar's value of 2 in AL register
lea BX, myvar   ; loads the offset address of myvar to BX

push 701h
pop DS          ; myvar now points to address 0701:xxxx
                ; It's original value 2 is stuck in 0700:xxxx
                ; as garbage!
mov AL, myvar   ; puts 90h in AL register, myvar now points to whatever
                ; was in 701:xxxx, which in this case was 90h

ret

myvar db 2
