; ---------------------------------------------------------------------
; fibonacci.asm
;
; This is an x86-64 assembly program that writes the Fibonacci
; sequence up to 1000, separated by spaces, to stdout.
;
; nasm -f elf64 -o _write.o _write.asm
; nasm -f elf64 -o fibonacci.o fibonacci.asm
; ld -o fibonacci fibonacci.o _write.o
; ./fibonacci
; ---------------------------------------------------------------------

    global  _start
    extern  write
    extern  write_int

section .text

_start:
    xor     r12, r12                   ; a = 0
    mov     r13, 1                     ; b = 1
_start_fib_loop:
    mov     rdi, 1
    mov     rsi, r12
    call    write_int

    mov     rdi, 1
    mov     rsi, spc
    mov     rdx, 1
    call    write

    mov     r14, r12                   ; c = a
    add     r14, r13                   ; c += b
    mov     r12, r13                   ; a = b
    mov     r13, r14                   ; b = c

    cmp     r12, 1000
    jle     _start_fib_loop

    mov     rdi, 1
    mov     rsi, lf
    mov     rdx, 1
    call    write

    mov     rax, 60                    ; exit(
    xor     rdi, rdi                   ;   0,
    syscall                            ; )

section .data

lf:         db      0x0A
spc:        db      0x20
