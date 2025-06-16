[org 0x7c00]

mov al, 1 
mov cl, 2
mov bx, 0x7e00
call get_sectors 

mov ah, 0x0e
mov al, [0x7e00]
int 0x10

end:
  jmp $

%include "io.asm"
%include "disk.asm"

str0:
  db "enter input: ", 0

str1:
  db "you gave me: ", 0

zero:
  db 0


times 510-($-$$) db 0
dw 0xaa55

data:
  times 512 db 'a'
