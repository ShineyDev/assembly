; ---------------------------------------------------------------------
; hello_cstring.asm
;
; This is an x86-64 assembly program that writes "Hello, World!\n"
; to stdout.
;
; This exists solely as a test for my write_cstring implementation.
;
; nasm -f elf64 -o _write.o _write.asm
; nasm -f elf64 -o hello_cstring.o hello_cstring.asm
; ld -o hello_cstring hello_cstring.o _write.o
; ./hello_cstring
; ---------------------------------------------------------------------

    global  _start
    extern  write_cstring

section .text

_start:
    mov     rdi, 1
    mov     rsi, msg
    call    write_cstring

    mov     rax, 60             ; exit(
    mov     rdi, 0              ;   0,
    syscall                     ; )

section .data

msg:        db      "Hello, World!", 0x0A, 0x00
