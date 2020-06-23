; ---------------------------------------------------------------------
;
; An x86-64 assembly *something* for having a bad time
;
; nasm -f elf64 -o intentionalpain.o intentionalpain.asm
;
; ---------------------------------------------------------------------

%define stdout 1
%define stderr 2

%define newline 10

section .data                                       ; riveting declarations

    error_message db "Uh-oh!", newline              ; error_message = b"Uh-oh!\n"
    error_message_length equ $-error_message        ; thank u nasm, error_message_length = len(error_message)

    success_message db "Have a nice day!", newline
    success_message_length equ $-success_message

section .text

global _start
_start:
    rdseed  r8                                      ; r8 = random.seed()
    mov     r9, r8
    and     r9, 01                                  ; r9 = r8[0] - only get the first bit

    mov     rax, 1                                  ; tell linux to get ready to write something
    cmp     r9, 0                                   ; cmp = bool(r9)

    jz      _bad_day                                ; if cmp == 0: _bad_day()
    jmp     _good_day                               ; else: _good_day()

_bad_day:
    mov     rdi, stderr                             ; write to stderr just to be a nuisance
    mov     rsi, error_message                      ; put the location of what we're writing into a register
    mov     rdx, error_message_length               ; now tell linux how many bytes we're writing
    syscall                                         ; actually do it lol

    jmp _purgatory                                  ; to the abyss we go

_good_day:
    mov     rdi, stdout                             ; write to stdout
    mov     rsi, success_message                    ; put the location of what we're writing into a register
    mov     rdx, success_message_length             ; now tell linux how many bytes we're writing
    syscall

    mov     rax, 60                                 ; syscall for exit
    xor     rdi, rdi
    syscall                                         ; because we're nice, exit without segfaulting

_purgatory:
    mov     rax, 1                                  ; mmm segfault
