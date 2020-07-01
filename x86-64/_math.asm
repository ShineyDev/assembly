; ---------------------------------------------------------------------
; _math.asm
;
; This is an x86-64 assembly extension for... math.
;
; nasm -f elf64 -o _math.o _math.asm
; ---------------------------------------------------------------------

    global  modulo

section .text

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
