; ---------------------------------------------------------------------
; _random.asm
;
; This is an x86-64 assembly extension for reading hardware-generated
; random values.
;
; nasm -f elf64 -o _random.o _random.asm
; ---------------------------------------------------------------------

    global  random
    global  random_seed

section .text

; returns:
;   rax: random number
random:
    rdrand  rax
    jnc     random

    ret

; returns:
;   rax: random seed
random_seed:
    rdseed  rax
    jnc     random_seed

    ret
