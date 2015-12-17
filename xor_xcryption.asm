; Prints out the "cipher" string encrypted
; then its decrypted (original) form on a new line

org 100h

mov AH, 0Eh
lea BX, cipher

call xcrypt                     ; encrypt
   
mov AL, 0Ah                     ; \n
int 10h
mov AL, 0Dh                     ; \r
int 10h

lea BX, cipher                  ; reload start of variable's address

call xcrypt                     ; decrypt

ret
                                ; arbitrary key value
key equ 37
cipher db "abcd123", 0

xcrypt proc
    xcryptLoop:
        xor [BX], key
        mov AL, [BX]
        int 10h
        inc BX
        cmp [BX], 0
        jne loop xcryptLoop
    ret
xcrypt endp

end
