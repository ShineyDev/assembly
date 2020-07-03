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
    mov     r12, rax
    and     r12, 0b1                   ; get the first bit
    jnz     _start_good                ; if zf: jmp _start_good

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
    xor     rdi, rdi                   ;   0,
    syscall                            ; )

section .data

bad_msg:    db      "Uh-oh!", 0x0A
bad_msg_l:  equ     $-bad_msg
good_msg:   db      "Have a nice day!", 0x0A
good_msg_l: equ     $-good_msg
