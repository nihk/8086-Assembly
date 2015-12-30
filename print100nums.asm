
org 100h

mov DX, 3031h
mov CX, 100d    ; total counter           

printNumbers:
mov AH, 0Eh
mov AL, DH
int 10h   
mov AL, DL
int 10h
mov AL, 20h     ; space
int 10h
inc DL
cmp DL, 3Ah
je modifyDX
loop printNumbers

modifyDX:
cmp DH, 39h
je stop
inc DH
mov DL, 30h
jmp printNumbers

stop:           ; 99d is reached, so print one last 100d
mov AL, 31h
int 10h
mov AL, 30h
int 10h
int 10h

ret




