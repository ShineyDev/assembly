; ---------------------------------------------------------------------
; fizzbuzz.asm
;
; This is an x86-64 assembly program that writes FizzBuzz 1-100,
; separated by spaces, to stdout.
;
; I'm bored.
;
; nasm -f elf64 -o _write.o _write.asm
; nasm -f elf64 -o fizzbuzz.o fizzbuzz.asm
; ld -o fizzbuzz fizzbuzz.o _write.o
; ./fizzbuzz
; ---------------------------------------------------------------------

    global  _start
    extern  write
    extern  write_int

section .text

_start:
    mov     r12, 1
_start_write_loop:
    mov     rdi, r12
    mov     rsi, 15
    call    modulo
    cmp     rax, 0                     ; if r12 % 15 == 0:
    je      _start_write_loop_15       ; jmp _start_write_loop_15

    mov     rdi, r12
    mov     rsi, 3
    call    modulo
    cmp     rax, 0                     ; if r12 % 3 == 0:
    je      _start_write_loop_3        ; jmp _start_write_loop_3

    mov     rdi, r12
    mov     rsi, 5
    call    modulo
    cmp     rax, 0                     ; if r12 % 5 == 0:
    je      _start_write_loop_5        ; jmp _start_write_loop_5

    mov     rdi, 1
    mov     rsi, r12
    call    write_int
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
    mov     rdx, 8                     ; let's save eight bytes* of memory :)
    call    write

_start_write_loop_sep:
    mov     rdi, 1
    mov     rsi, spc
    mov     rdx, 1
    call    write

    inc     r12

    cmp     r12, 101
    jne     _start_write_loop

    mov     rdi, 1
    mov     rsi, lf
    mov     rdx, 1
    call    write

    mov     rax, 60                    ; exit(
    mov     rdi, 0                     ;   0,
    syscall                            ; )

; parameters:
;   rdi: dividend
;   rsi: divisor
;
; returns:
;   rax: modulo
modulo:
    xor     rdx, rdx
    mov     rax, rdi
    mov     rcx, rsi
    div     rcx

    mov     rax, rdx

    ret

section .data

fizz:       db      "fizz"
buzz:       db      "buzz"

spc         db      0x20
lf:         db      0x0A
