; This program takes a user's String input
; and reverses each individual word but 
; preserves word order. The output skips
; any characters from the input that are
; not numbers, letters, or spaces. It also 
; prints any letter characters in its 
; respective inverse case.
;
; Sample Input:  aBc 1@3 De45 $F
; Sample Output: CbA 31 54Ed f

include emu8086.inc

org 0x100

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Prompt the user to enter a String ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

call PTHIS
db "Input:  ", 0       ; 0 is the String terminator for PTHIS

push 0x1000            ; DS by default is set to 0x700, but at 
pop DS                 ; DS:DI this is memory address 0x07000.
                       ; The addresses 0x07000 and 0x07001 already
                       ; have 0xCD and 0x20 written to it and these
                       ; should not be overritten by GET_STRING.
                       ; Therefore, set DS to a different value
                       ; in order to write to vacant memory         
                            
mov DX, 0x10           ; 0x10 String buffer limit means a 0xF
                       ; input character limit                                    
call GET_STRING

PUTC 0xD               ; Print carriage return character
PUTC 0xA               ; Print new line character
call PTHIS
db "Output: ", 0        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Process the user's String input ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

findSpace:
    cmp [DI], 0x20
    je prepareReversal ; Space character hex code found
    cmp [DI], 0x0
    je lastWord        ; Null terminator character found
    inc DI
    jmp findSpace      ; Space or null wasn't found yet. Inevitably
                       ; one or the other will be found (i.e. this 
                       ; won't loop infinitely)
    
prepareReversal:
    mov AX, DI         ; Store index where the word ended (a space or null)
    dec DI             ; Move pointer to the left of the word ender
    call reverseWord   
    mov DI, AX         ; Go back to space at end of word
    printSpace:
        PUTC [DI]      ; Print that space
        inc DI         ; Move pointer to the right of the space
        cmp [DI], 0x20
        je printSpace  ; If its another space, keep printing
    
    jmp findSpace      ; Word was printed, jump back to find next word
    
lastWord:
    dec DI             ; Move the pointer one left past the end.
    cmp [DI], 0x20     ; If the penultimate character were a                        
    je stop            ; space, program's done.
    call reverseWord   ; Else reverse the last word
    jmp stop           ; Program's done
    
stop:
    ret        

   
reverseWord PROC
    myLoop:
        call inspectChar
        dec DI
        cmp [DI], 0x0  ; Beginning of word found; done printing                        
        je stop        ; the first word                      
        cmp [DI], 0x20 ; Else:
        je stop        ; Space found; done printing the word
        jmp myLoop           
    ret
reverseWord ENDP

inspectChar PROC
    mov BL, [DI]       ; Use BL to preserve DI's char values
    cmp BL, 0x30 
    jl stop            ; Not valid character 
    
    cmp BL, 0x39 
    jle call printIt   ; Character was a number 
    
    cmp BL, 0x41
    jl stop            ; Not valid character
    
    cmp BL, 0x5A
    jle call makeLower ; Character was upper case
                                        
    cmp BL, 0x61
    jl stop            ; Not valid character
    
    cmp BL, 0x7A    
    jle call makeUpper ; Character was lower case
                       
    ret
inspectChar ENDP

printIt PROC
    PUTC BL
    ret
printIt ENDP

makeUpper PROC
    sub BL, 0x20
    call printIt
    ret
makeUpper ENDP
  
makeLower PROC
    add BL, 0x20
    call printIt
    ret
makeLower ENDP    

DEFINE_PTHIS
DEFINE_GET_STRING

end