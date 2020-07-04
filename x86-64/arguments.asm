; ---------------------------------------------------------------------
; arguments.asm
;
; This is an x86-64 assembly program that writes argc and argv[0..] to
; stdout.
;
; nasm -f elf64 -o _write.o _write.asm
; nasm -f elf64 -o arguments.o arguments.asm
; ld -o arguments arguments.o _write.o
; ./arguments oranges
; ---------------------------------------------------------------------

    global  _start
    extern  write
    extern  write_cstring
    extern  write_int

section .text

_start:
    mov     r12, [rsp]                 ; argc

    mov     rdi, 1
    mov     rsi, r12
    call    write_int

    mov     rdi, 1
    mov     rsi, lf
    mov     rdx, 1
    call    write

    xor     r13, r13
_start_argv_loop:
    inc     r13

    mov     rdi, 1
    mov     rsi, [rsp+8*r13]           ; argv[0..]
    call    write_cstring

    mov     rdi, 1
    mov     rsi, lf
    mov     rdx, 1
    call    write

    cmp     r13, r12
    jne     _start_argv_loop

    mov     rax, 60
    mov     rdi, 0
    syscall

section .data

lf:         db      0x0A
