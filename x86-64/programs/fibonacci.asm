; ---------------------------------------------------------------------
; /x86-64/programs/fibonacci.asm
;
; An x86-64 assembly which writes the Fibonacci sequence, up to 1000,
; to STDOUT.
;
; Requires:
;   write
; ---------------------------------------------------------------------

    global  _start
    extern  write
    extern  write_integer


section .text

_start:
    xor     r12, r12                   ; a = 0
    mov     r13, 1                     ; b = 1
_start_fib_loop:
    mov     rdi, 1
    mov     rsi, r12
    call    write_integer

    mov     rdi, 1
    mov     rsi, sp_
    mov     rdx, 1
    call    write

    mov     r14, r12                   ; c = a
    add     r14, r13                   ; c += b
    mov     r12, r13                   ; a = b
    mov     r13, r14                   ; b = c

    cmp     r12, 1000
    jle     _start_fib_loop

    mov     rdi, 1
    mov     rsi, lf_
    mov     rdx, 1
    call    write

    mov     rax, 60
    xor     rdi, rdi
    syscall


section .data

lf_:        db      0x0A
sp_:        db      0x20
