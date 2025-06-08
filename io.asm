;bx holdes the string input
print:
  pusha

  mov ah, 0x0e

print_loop_start:
mov al, [bx]
  cmp al, 0
  je print_loop_end
  int 0x10
  inc bx
  jmp print_loop_start


print_loop_end:

  popa
  ret
  
;bx holdes the string input
println:
  pusha 

  call print 
  mov bx, nl
  call print

  popa 
  ret


scan:

  pusha
  mov ah, 0 
  mov bx, buffer

scan_loop:
  int 0x16
  
  mov ah, 0x0e
  int 0x10
  mov ah, 0

  ; 0x0d == enter 
  cmp al, 0x0d
  je scan_loop_end
  mov [bx], al
  inc bx
  jmp scan_loop


scan_loop_end:

  inc bx
  mov [bx], ax

  mov bx, nl
  call print

  popa 
  ret

;bx holdes the string input
;can take no more than 20 chars
scanm:
  call print 
  call scan 

  ret

buffer:
  times 20 db 0

nl:
  db 0x0a, 0x0d, 0
