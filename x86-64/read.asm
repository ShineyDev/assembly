; ---------------------------------------------------------------------
; /x86-64/read.asm
;
; An x86-64 assembly for reading from streams.
; ---------------------------------------------------------------------

    global  read


section .text

; Reads a line of input from STDIN.
;
; Parameters
;   rsi: The memory address of the buffer to read to.
;   rdx: The number of bytes to read.
;
; Returns
;   rax: The number of bytes read.
input:
    xor     rax, rax
    syscall

    lea     r8, [rsi]
    xor     r9, r9
input_lf_loop:
    cmp     [r8], byte 0x0A
    je      input_skip_flush

    inc     r8
    inc     r9

    cmp     r9, rdx
    jne     input_lf_loop

    push    rax

    lea     rsi, [buffer]
    mov     rdx, 1
input_flush:
    xor     rax, rax
    syscall

    cmp     [rsi], byte 0x0A
    jne     input_flush

    pop     rax

    jmp     input_end

input_skip_flush:
    dec     rax

input_end:
    ret


section .bss

buffer:     resb    8
