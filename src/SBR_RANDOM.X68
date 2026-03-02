MULTIPLIER  EQU 49381
INCREMENT   EQU 8643

Set_seed:
    MOVE.B  #8, D0
    TRAP    #15
    MOVE.L  D1, seed
    RTS

Random:
    ;MOVEM.L D0-D2/D4,-(A7)
    MOVE.L  seed, D3
    MOVE.L  D3, D4

    MULU    #MULTIPLIER, D3 ;low16
    SWAP    D4              ;change low word for high word
    MULU    #MULTIPLIER, D4 ;high16
    SWAP    D4              ;shift by 16
    ADD.L   D4, D3          ;combine halves
    ADD.L   #INCREMENT, D3  ;add constant
    MOVE.L  D3, seed        ;save new seed

    AND.L   #$7FFFFFFF, D3  ;clear sign bit
    SWAP    D3              ;use upper 16 bits, should have better spread
    AND.L   #$0000FFFF, D3  ;clean up the higher bits

    ;get the range into D2
    MOVE.L  D1, D2      
    SUB.L   D0, D2
    ADD.L   #1, D2

    DIVU    D2, D3          ;divide D3 by range
    SWAP    D3              ;get remainder in the low word
    AND.L   #$0000FFFF, D3  ;clear the quotient in the high word

    ADD.L   D0, D3
    
    ;MOVEM.L (A7)+,D0-D2/D4
    
    RTS

seed:   DC.L  $1234567


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
