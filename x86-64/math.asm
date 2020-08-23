; ---------------------------------------------------------------------
; /x86-64/math.asm
;
; An x86-64 assembly for... math.
; ---------------------------------------------------------------------

    global  modulo


section .text

; Yields the remainder of the division ``rdi / rsi``.
;
; Parameters
;   rdi: The dividend.
;   rsi: The divisor.
;
; Returns
;   rax: The modulo of the parameters.
modulo:
    xor     rdx, rdx
    mov     rax, rdi
    mov     rcx, rsi
    div     rcx

    mov     rax, rdx

    ret
