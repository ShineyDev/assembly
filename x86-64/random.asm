; ---------------------------------------------------------------------
; /x86-64/random.asm
;
; An x86-64 assembly for reading hardware-generated random values.
; ---------------------------------------------------------------------

; [1] "The RDRAND and RDSEED instructions return with CF set to
;     indicate that valid data was returned. It is recommended that
;     software using the RDRAND or RDSEED instructions to get random
;     numbers retry a limited number of times while CF is unset and
;     complete when valid data is returned. This will deal with
;     transitory underflows. A retry limit should be employed to
;     prevent a hard failure in the RBG (expected to be extremely rare)
;     leading to a busy loop in software."


    global  random
    global  random_seed


section .text

; Executes the RDRAND instruction to generate a random number.
;
; "The RDRAND instruction returns a random number that is supplied by a
; cryptographically secure, deterministic random bit generator (DRBG).
; The DRBG is designed to meet the NIST SP 800-90A standard. The DRBG
; is re-seeded frequently from an on-chip non-deterministic entropy
; source to guarantee data returned by RDRAND is statistically uniform,
; non-periodic and non-deterministic."
;
; Returns
;   rax: A hardware-generated random number.
random:
    rdrand  rax
    jnc     random                     ; [1]

    ret

; Executes the RDSEED instruction to generate a random number.
;
; "The RDSEED instruction returns a random number that is supplied by a
; cryptographically secure, enhanced non-deterministic random bit
; generator (NRBG). The NRBG is designed to meet the NIST SP 800-90B
; and NIST SP 800-90C standards."
;
; Returns
;   rax: A hardware-generated random number.
random_seed:
    rdseed  rax
    jnc     random_seed                ; [1]

    ret
