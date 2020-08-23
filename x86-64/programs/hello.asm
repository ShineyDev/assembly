; ---------------------------------------------------------------------
; /x86-64/programs/hello.asm
;
; An x86-64 assembly which writes "Hello, World!\n" to STDOUT.
;
; This was my first native assembly program. I like it.
; ---------------------------------------------------------------------

    global  _start


section .text

_start:
    mov     rax, 1              ; write(
    mov     rdi, 1              ;   stdout,
    mov     rsi, msg            ;   message,
    mov     rdx, msg_l          ;   len(message),
    syscall                     ; )

    mov     rax, 60             ; exit(
    xor     rdi, rdi            ;   0,
    syscall                     ; )


section .data

msg:        db      "Hello, World!", 0x0A
msg_l:      equ     $-msg
