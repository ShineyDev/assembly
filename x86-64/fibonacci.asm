; ---------------------------------------------------------------------
; fibonacci.asm
;
; This is an x86-64 assembly program that writes the Fibonacci
; sequence up to 1000, separated by spaces, to stdout.
;
; nasm -f elf64 -o write.o write.asm
; nasm -f elf64 -o fibonacci.o fibonacci.asm
; ld -o fibonacci fibonacci.o write.o
; ./fibonacci
; ---------------------------------------------------------------------

    global  _start
    extern  write
    extern  write_int

section .text

_start:
    mov     r10, 0                     ; a = 0
    mov     r11, 1                     ; b = 1
_start_fib_loop:
    mov     rdi, 1
    mov     rsi, r10
    call    write_int

    mov     rdi, 1
    mov     rsi, sp
    mov     rdx, 1
    call    write

    mov     r12, r10                   ; c = a
    add     r12, r11                   ; c += b
    mov     r10, r11                   ; a = b
    mov     r11, r12                   ; b = c

    cmp     r10, 1000
    jle     _start_fib_loop

    mov     rdi, 1
    mov     rsi, lf
    mov     rdx, 1
    call    write

    mov     rax, 60                    ; exit(
    mov     rdi, 0                     ;   0,
    syscall                            ; )

section .data

lf:         db      0x0A
sp:         db      0x20
