;*=$033C
.org $033c

; Branch on even numbers
;
; Originally was using exclusive or to flip bit one and then ANDing that
; result with 1 to determine if the value in question was even. Example:
; ODD:
;       3 (0011) EOR 1 (0001) = 2 (0010)
;       2 (0010) AND 1 (0001) = 0 (0000)
; EVEN:
;       6 (0110) EOR 1 (0001) = 7 (0111)
;       7 (0111) AND 1 (0001) = 1 (0001)
;
; So it was just a matter of branching when the result of AND did not set
; the Z status flag:
;       EOR #%00000001
;       AND #%00000001
;       BNE EVEN:
;
; I quickly realized that the EOR was unnecessary and simply ANDing with 1
; was all that was required. Remove the EOR and flip the logic for branching
; to BEQ and you're branching on even numbers.
;
; X register will be $05 when program is complete

START:
        LDA #$00        ; Set accumulator to $00
        LDX #$00        ; Set X register to $00

LOOP:
        ADC #$01        ; Add 1 to accumulator
        TAY             ; AND places result in accumulator, copy A to X
        AND #%00000001  ; A && $01 will be 0 if A is even
        BEQ EVEN        ; If Z flag is set, branch
CONTINUE:
        TYA             ; Restore previous value of A
        CMP #10         ; Loop ten times (using integer value here)
        BEQ END         ; If comparison is 0 (Z status flag set) jump to END:
        JMP LOOP        ; Still going - jump to LOOP:


        
EVEN:
        INX             ; No output at the moment, just increment X
        JMP CONTINUE    ; Done - jump to CONTINUE:
                        ; Branch instructions do not push return address to
                        ; to the stack - could manually manipulate the stack
                        ; pointer and then RTS?

END:
        BRK             ; All done