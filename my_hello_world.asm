
org 100h
 
jmp start
          
msg db "Hello", 10, 13, "$" ; creates a newline after the word
msg2 db "World!$"  

start:
                  
mov AH, 9                   ; print string subfunction
mov DX, offset msg
int 21h    
mov DX, offset msg2
int 21h   
                         
ret




