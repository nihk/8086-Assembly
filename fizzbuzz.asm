
org 100h

mov DX, 3030h    ; DX used for printing the number as ASCII
mov AH, 0Eh
mov CL, 0        

setAL:
mov BL, 0
inc CL           
cmp CL, 101d     ; CL used as the "counter" 1 to 100
je stop
mov AL, CL
inc DL
cmp DL, 3Ah
je modifyDX

modFifteen:
cmp AL, 15d
je printFizz
jl modBridgeI
sub AL, 15d
jmp modFifteen

modThree:
cmp AL, 3d
je printFizz
jl modBridgeII
sub AL, 3d
jmp modThree

modFive:
cmp AL, 5d
je printBuzz
jl printNumber
sub AL, 5d
jmp modFive

printFizz:
mov BL, AL        ; save current AL value 
mov AL, 'F'
int 10h
mov AL, 'i'
int 10h
mov AL, 'z'
int 10h
int 10h       
cmp BL, 15d       ; check to see if it's % 15
je printBuzz
jmp printSpace

printBuzz:
mov AL, 'B'
int 10h
mov AL, 'u'
int 10h
mov AL, 'z'
int 10h
int 10h
jmp printSpace

printNumber:
mov AL, DH
int 10h
mov AL, DL
int 10h
jmp printSpace

printSpace:
mov AL, 20h
int 10h
jmp setAL

modifyDX:
inc DH
mov DL, 30h
jmp modFifteen
 
modBridgeI:
mov AL, CL
jmp modThree 
 
modBridgeII:        
mov AL, CL
jmp modFive

stop:
ret
