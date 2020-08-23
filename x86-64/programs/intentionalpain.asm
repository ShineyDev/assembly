; ---------------------------------------------------------------------
; /x86-64/programs/intentionalpain.asm
;
; An x86-64 assembly which randomly selects between a write to STDOUT
; or a SIGSEGV.
;
; @kaylynn234
;
; Requires:
;   random
;   write
; ---------------------------------------------------------------------

    global  _start
    extern  random
    extern  write


section .text

_start:
    call    random
    mov     r12, rax
    and     r12, 0b1                   ; use the first bit -> 50%
    jnz     _start_good

_start_bad:
    mov     rdi, 2                     ; write to STDERR just to be a nuisance
    mov     rsi, bad_msg
    mov     rdx, bad_msg_l
    call    write

    hlt                                ; we are not a kernel -> fast SIGSEGV :)

_start_good:
    mov     rdi, 1
    mov     rsi, good_msg
    mov     rdx, good_msg_l
    call    write

    mov     rax, 60
    xor     rdi, rdi
    syscall


section .data

bad_msg:    db      "Uh-oh!", 0x0A
bad_msg_l:  equ     $-bad_msg
good_msg:   db      "Have a nice day!", 0x0A
good_msg_l: equ     $-good_msg
