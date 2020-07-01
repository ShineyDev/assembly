; ---------------------------------------------------------------------
; intentionalpain.asm
;
; This is an x86-64 assembly program for having a bad time.
;
; nasm -f elf64 -o _random.o _random.asm
; nasm -f elf64 -o _write.o _write.asm
; nasm -f elf64 -o intentionalpain.o intentionalpain.asm
; ld -o intentionalpain intentionalpain.o _random.o _write.o
; ./intentionalpain
; ---------------------------------------------------------------------

    global  _start
    extern  random
    extern  write

section .text

_start:
    call    random
    mov     r8, rax
    and     r8, 1b                     ; get the first bit

    test    r8, r8                     ; zf = ~bool(r8)
    jnz     _start_good                ; if zf == 1: jmp _start_good
_start_bad:
    mov     rdi, 2                     ; write to stderr just to be a nuisance
    mov     rsi, bad_msg               ; put the location of what we're writing into a register
    mov     rdx, bad_msg_l             ; now tell syscall how many bits we're writing
    call    write

    hlt                                ; we are not a kernel -> fast SIGSEGV :)
_start_good:
    mov     rdi, 1                     ; write to stdout
    mov     rsi, good_msg              ; put the location of what we're writing into a register
    mov     rdx, good_msg_l            ; now tell syscall how many bits we're writing
    call    write

    mov     rax, 60                    ; exit(
    mov     rdi, 0                     ;   0,
    syscall                            ; )

section .data

bad_msg:    db      "Uh-oh!", 10
bad_msg_l:  equ     $-bad_msg
good_msg:   db      "Have a nice day!", 10
good_msg_l: equ     $-good_msg
