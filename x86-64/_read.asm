; ---------------------------------------------------------------------
; _read.asm
;
; This is an x86-64 assembly extension for reading from streams.
;
; nasm -f elf64 -o _read.o _read.asm
; ---------------------------------------------------------------------

    global  read

section .text

; parameters:
;   rdi: stream descriptor
;   rsi: buffer
;   rdx: len(buffer)
;
; returns:
;   rax: len(buffer)
read:
    push    rcx                        ; syscall sets rcx=rip
    push    r11                        ; syscall sets r11=rflags

    xor     rax, rax
    syscall

    lea     r8, [rsi]
    xor     r9, r9
read_lf_loop:
    cmp     [r8], byte 0x0A
    je      read_skip_flush

    inc     r8
    inc     r9

    cmp     r9, rdx
    jne     read_lf_loop

    push    rax

    lea     rsi, [buffer]
    mov     rdx, 1
read_flush:
    xor     rax, rax
    syscall

    cmp     [rsi], byte 0x0A
    jne     read_flush

    pop     rax

    jmp     read_skip_skip_flush

read_skip_flush:
    dec     rax

read_skip_skip_flush:
    pop     r11
    pop     rcx

    ret

section .bss

buffer:     resb    1
