stack_set_up:
  mov ax, 0
  mov es, ax
  mov ds, ax
  mov bp, 0x8000
  mov sp, bp
  ret 

; al needs to hold the number of sectors
; bx needs to be the address of the start of the sectors
; cl needs to be the first sector number 
get_sectors:

  pusha

  push ax

  mov ax, 0 
  mov es, ax

  pop ax
  push ax

  mov ah, 2
  mov ch, 0 
  mov dh, 0 
  int 0x13

  pop cx
  call get_sectors_report_error

  popa
  ret

; cx holds the expected al
get_sectors_report_error:
  
  pusha
  
  jc cf_error
  jmp after_cf_check

  cf_error:

    mov bx, cf_error_msg
    call println

after_cf_check:

  cmp al, cl
  je get_sectors_report_error_end

  mov bx, sect_err_msg
  call println

get_sectors_report_error_end:

  popa
  ret

cf_error_msg:
  db "get_sectors: carry flag error", 0

sect_err_msg:
  db "sectors dont match", 0


