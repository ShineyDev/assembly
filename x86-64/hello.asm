; ---------------------------------------------------------------------
; hello.asm
;
; This is an x86-64 assembly program that writes "Hello, World!\n"
; to stdout.
;
; This was my first native assembly program. I like it.
;
; nasm -f elf64 -o hello.o hello.asm
; ld -o hello hello.o
; ./hello
; ---------------------------------------------------------------------

    global  _start

section .text

_start:
    mov     rax, 1              ; write(
    mov     rdi, 1              ;   stdout,
    mov     rsi, message        ;   message,
    mov     rdx, message_len    ;   len(message),
    syscall                     ; )

    mov     rax, 60             ; exit(
    mov     rdi, 0              ;   0,
    syscall                     ; )

section .data

message:        db      "Hello, World!", 10
message_len:    equ     $-message
