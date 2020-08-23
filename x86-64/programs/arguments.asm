; ---------------------------------------------------------------------
; /x86-64/programs/arguments.asm
;
; An x86-64 assembly which writes argc and argv to STDOUT.
;
; Requires:
;   write
; ---------------------------------------------------------------------

    global  _start
    extern  write
    extern  write_cstring
    extern  write_integer


section .text

_start:
    mov     r12, [rsp]                 ; argc

    mov     rdi, 1
    mov     rsi, r12
    call    write_integer

    mov     rdi, 1
    mov     rsi, lf_
    mov     rdx, 1
    call    write

    xor     r13, r13
_start_argv_loop:
    inc     r13

    mov     rdi, 1
    mov     rsi, [rsp+8*r13]           ; argv[0..]
    call    write_cstring

    mov     rdi, 1
    mov     rsi, lf_
    mov     rdx, 1
    call    write

    cmp     r13, r12
    jne     _start_argv_loop

    mov     rax, 60
    mov     rdi, 0
    syscall


section .data

lf_:        db      0x0A
