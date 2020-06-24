; ---------------------------------------------------------------------
; _write.asm
;
; This is an x86-64 assembly extension for writing to streams.
;
; nasm -f elf64 -o _write.o _write.asm
; ---------------------------------------------------------------------

    global  write
    global  write_int

section .text

; parameters:
;   rdi: stream descriptor
;   rsi: buffer
;   rdx: len(buffer)
;
; returns:
;   rax: len(buffer)
write:
    push    rcx                        ; syscall sets rcx=rip
    push    r11                        ; syscall sets r11=rflags

    mov     rax, 1
    syscall

    pop     r11
    pop     rcx

    ret

; parameters:
;   rdi: stream descriptor
;   rsi: int
;
; returns:
;   rax: len(buffer)
write_int:
    xor     r8, r8                     ; length counter

    mov     rax, rsi                   ; dividend
    mov     rcx, 10                    ; divisor
write_int_div_loop:
    inc     r8

    xor     rdx, rdx                   ; remainder
    div     rcx                        ; rax, rdx = divmod(rax, rcx)
    push    rdx

    test    rax, rax
    jnz     write_int_div_loop
    
    lea     r9, [buffer]
    mov     rcx, r8                    ; loop counter
write_int_build_loop:
    pop     rax
    add     rax, 0x30                  ; ascii conversion
    mov     [r9], rax
    inc     r9

    loop    write_int_build_loop

    mov     rsi, buffer
    mov     rdx, r8
    call    write

    ret

section .bss

buffer:     resb    1
