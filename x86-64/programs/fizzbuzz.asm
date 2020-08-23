; ---------------------------------------------------------------------
; /x86-64/programs/fizzbuzz.asm
;
; An x86-64 assembly which writes FizzBuzz, up too 100, to STDOUT.
;
; Requires:
;   math
;   write
; ---------------------------------------------------------------------

    global  _start
    extern  modulo
    extern  write
    extern  write_integer


section .text

_start:
    mov     r12, 1
_start_write_loop:
    mov     rdi, r12
    mov     rsi, 15
    call    modulo
    test    rax, rax                   ; r12 % 15 == 0
    jz      _start_write_loop_15

    mov     rdi, r12
    mov     rsi, 5
    call    modulo
    test    rax, rax                   ; r12 % 5 == 0
    jz      _start_write_loop_5

    mov     rdi, r12
    mov     rsi, 3
    call    modulo
    test    rax, rax                   ; r12 % 3 == 0
    jz      _start_write_loop_3

    mov     rdi, 1
    mov     rsi, r12
    call    write_integer
    jmp     _start_write_loop_sep

_start_write_loop_3:
    mov     rdi, 1
    mov     rsi, fizz
    mov     rdx, 4
    call    write
    jmp     _start_write_loop_sep

_start_write_loop_5:
    mov     rdi, 1
    mov     rsi, buzz
    mov     rdx, 4
    call    write
    jmp     _start_write_loop_sep

_start_write_loop_15:
    mov     rdi, 1
    mov     rsi, fizz
    mov     rdx, 8
    call    write

_start_write_loop_sep:
    mov     rdi, 1
    mov     rsi, sp_
    mov     rdx, 1
    call    write

    inc     r12

    cmp     r12, 101
    jne     _start_write_loop

    mov     rdi, 1
    mov     rsi, lf_
    mov     rdx, 1
    call    write

    mov     rax, 60
    xor     rdi, rdi
    syscall


section .data

fizz:       db      "fizz"
buzz:       db      "buzz"

sp_:        db      0x20
lf_:        db      0x0A
