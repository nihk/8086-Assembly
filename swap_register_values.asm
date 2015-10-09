
org 100h

mov AL, 0x5
mov BL, 0x10

push AX      ; push AX to stack (must be full word)
             ; AX retains its hex value despite push
push BX

pop AX       ; pop top of stack to AX, overriding current
             ; AX value
pop BX

ret




