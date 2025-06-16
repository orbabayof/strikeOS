[org 0x7c00]

; mov al, 1 
; mov cl, 2
; mov bx, 0x7e00
; call get_sectors 
;
; mov ah, 0x0e
; mov al, [0x7e00]
; int 0x10

CODE_SEG equ code_desc - gdt_start
DATA_SEG equ data_desc - gdt_start

cli 
lgdt [gdt]
mov eax, cr0
or eax, 1
mov cr0, eax

jmp CODE_SEG:protected_mode_start

jmp $

; "global destriptor table" :)
gdt_start: 
  null_desc:
    dd 0 
    dd 0 ; empty destriptor in the start of every gdt

  code_desc:
    ; first 2 bytes of the limit, will be set to max
    dw 0xffff
    ; first 3 bytes of the base, the base will be set to 0
    dw 0 ; 2 bytes 
    db 0 ; 1 byte
    
    ; used = 1 
    ; privilage = 00 (heighest)
    ; code or data = 1 (code)

    ; type flags
    ; code = 1 
    ; can be run from lower privilage = 0 
    ; readable = 1 
    ; acceced = 0

    db 0b10011010

    ; limit *= 0x1000 = 1 
    ; 32 bit = 1 
    ; not used = 00
    ; last 4 bits of the limit
    db 0b11001111

    ; last byte of the base
    db 0

  data_desc:
    ;the same applies for data desc 

    ;2b of limit... and so on 
    dw 0xffff
    ;base start
    dw 0 
    db 0

    ; used = 1 
    ; privilage = 00 
    ; data = 1 

    ;type flags
    ;code = 0 
    ;expand down segment = 0 
    ;writable = 1
    ;accecced = 0

    db 0b10010010

    ;other flags + 4bits of limit
    db 0b11001111
    ;last byte of base
    db 0
gdt_end:

gdt:
  dw gdt_end - gdt_start - 1 ;size
  dd gdt_start ;start


[bits 32]
protected_mode_start:
  mov al, 'A'
  mov ah, 0x0f
  mov [0xb8000], ax 

end:
  jmp $

times 510-($-$$) db 0
dw 0xaa55

