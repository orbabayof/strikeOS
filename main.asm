[org 0x7c00]


mov bx, str0
call scanm

mov bx, str1
call print 
mov bx, buffer
call println



end:
  jmp $

%include "io.asm"

str0:
  db "enter input: ", 0

str1:
  db "you gave me: ", 0


times 510-($-$$) db 0
dw 0xaa55
