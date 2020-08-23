; ---------------------------------------------------------------------
; /x86-64/write.asm
;
; An x86-64 assembly for writing to streams.
; ---------------------------------------------------------------------

    global  write
    global  write_cstring
    global  write_integer


section .text

; Writes a string buffer to a stream.
; 
; Parameters
;   rdi: The descriptor of the stream to write to.
;   rsi: The memory address of the buffer to read from.
;   rdx: The number of bytes to read.
;
; Returns
;   rax: The number of bytes written.
write:
    mov     rax, 1
    syscall

    ret

; Writes a C-string buffer to a stream.
;
; Parameters
;   rdi: The descriptor of the stream to write to.
;   rsi: The memory address of the buffer to read from.
;
; Returns
;   rax: The number of bytes written.
write_cstring:
    lea     r8, [rsi]
write_cstring_null_loop:
    inc     r8
    cmp     [r8], byte 0x00
    jne     write_cstring_null_loop

    mov     rdx, r8                    ; r8 points to the null-terminator
    sub     rdx, rsi                   ; so r8-start is the length
    call    write

    ret

; Writes an integer buffer to a stream.
;
; Parameters
;   rdi: The descriptor of the stream to write to.
;   rsi: The memory address of the buffer to read from.
;
; Returns
;   rax: The number of bytes written.
write_integer:
    xor     r8, r8                     ; length counter

    mov     rax, rsi                   ; dividend
    mov     rcx, 10                    ; divisor
write_integer_div_loop:
    inc     r8

    xor     rdx, rdx                   ; remainder
    div     rcx                        ; rax, rdx = divmod(rax, rcx)
    push    rdx

    test    rax, rax
    jnz     write_integer_div_loop

    lea     r9, [buffer]
    mov     rcx, r8                    ; loop counter
write_integer_build_loop:
    pop     rax
    add     rax, 0x30                  ; ascii conversion
    mov     [r9], rax
    inc     r9

    loop    write_integer_build_loop

    mov     rsi, buffer
    mov     rdx, r8
    call    write

    ret


section .bss

buffer:     resb    8
