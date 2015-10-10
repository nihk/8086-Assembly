; This prints the inverted case of any letter. Won't
; print anything if it's not a letter, though.
; 0x41 - 0x5A upper case letters
; 0x61 - 0x7A lower case letters
; 0x20 separates the inverted case of a letter

org 100h

mov AL, 'N'           ; 0x41
push 0xB800
pop DS

cmp AL, 0x41          ; Compare it to the lowest possible hex
                      ; value for an uppercase character, 0x41
             
jl notLetter          ; < 'A'? it's not a letter

cmp AL, 0x5A          ; Compare to the max possible hex value
                      ; for an uppercase character, 0x5A
             
jg potentialLowerCase ; > 'Z'? possible lower case

add AL, 0x20          ; Else it is in fact uppercase, add 0x20
jmp printIt

potentialLowerCase:
  cmp AL, 0x61
  jl notLetter        ; < 'a'? it's not a letter
  cmp AL, 0x7A
  jg notLetter        ; > 'z'? it's not a letter
  
  sub AL, 0x20        ; Else it is in fact lower, minus 0x20
  jmp printIt     

                      

printIt:
  mov DS:[BX], AL     ; Print to console

notLetter:            ; Jump here when not in the possible            
  ret                 ; range for character letters
  