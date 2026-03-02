*-----------------------------------------------------------
* Title      : SBR_SPLASH
* Description: blue splash particles for when the fish goes
*              in and out of the water. they burst upward and
*              fall back down. looks pretty cool tbh
*              set SPL_SPAWN_X / SPL_SPAWN_Y before calling
*-----------------------------------------------------------

SPL_MAX         EQU     20      ;how many particles we can have at once
SPL_PER_EVENT   EQU     10      ;how many spawn per splash
SPL_LIFETIME    EQU     30      ;how long they last (frames)


; clear all the particle slots
INIT_SPLASH:
    LEA     SPL_TBL_ACT, A0
    MOVE.L  #SPL_MAX-1, D7
IS_CLR:
    MOVE.L  #0, (A0)+
    DBRA    D7, IS_CLR
    RTS


; spawn a bunch of particles at SPL_SPAWN_X/Y
; call this when the player hits the water surface
SPAWN_SPLASH:
    MOVEM.L D0-D7/A0-A6, -(SP)

    LEA     SPL_TBL_ACT, A0
    LEA     SPL_TBL_X, A1
    LEA     SPL_TBL_Y, A2
    LEA     SPL_TBL_VX, A3
    LEA     SPL_TBL_VY, A4
    LEA     SPL_TBL_LF, A5

    MOVE.L  #SPL_PER_EVENT, D6      ;how many we still need to spawn
    MOVE.L  #0, D7                  ;current slot

SS_FIND:
    CMP.L   #SPL_MAX, D7
    BGE     SS_EXIT
    CMP.L   #0, D6
    BLE     SS_EXIT

    MOVE.L  D7, D0
    ASL.L   #2, D0
    TST.L   0(A0,D0.L)             ;slot already taken?
    BNE     SS_NEXT

    ;found a free slot, set it up
    MOVE.L  #1, 0(A0,D0.L)

    ;put it at the spawn point
    MOVE.L  SPL_SPAWN_X, D1
    MOVE.L  D1, 0(A1,D0.L)
    MOVE.L  SPL_SPAWN_Y, D1
    MOVE.L  D1, 0(A2,D0.L)

    ;random X velocity between -5 and +5 (sideways spread)
    MOVEM.L D0/D6-D7/A0-A5, -(SP)
    MOVE.L  #0, D0
    MOVE.L  #10, D1
    JSR     RANDOM
    MOVEM.L (SP)+, D0/D6-D7/A0-A5
    SUB.L   #5, D3                  ;shift range from 0-10 to -5 to +5
    MOVE.L  D3, 0(A3,D0.L)

    ;random Y velocity between -7 and -2 (shoots upward)
    MOVEM.L D0/D6-D7/A0-A5, -(SP)
    MOVE.L  #0, D0
    MOVE.L  #5, D1
    JSR     RANDOM
    MOVEM.L (SP)+, D0/D6-D7/A0-A5
    SUB.L   #7, D3                  ;shift so its always negative (upward)
    MOVE.L  D3, 0(A4,D0.L)

    MOVE.L  #SPL_LIFETIME, 0(A5,D0.L)

    SUB.L   #1, D6

SS_NEXT:
    ADD.L   #1, D7
    BRA     SS_FIND

SS_EXIT:
    MOVEM.L (SP)+, D0-D7/A0-A6
    RTS


; move all the particles, apply gravity, kill old ones
UPDATE_SPLASH:
    MOVEM.L D0-D5/A0-A5, -(SP)

    LEA     SPL_TBL_ACT, A0
    LEA     SPL_TBL_X, A1
    LEA     SPL_TBL_Y, A2
    LEA     SPL_TBL_VX, A3
    LEA     SPL_TBL_VY, A4
    LEA     SPL_TBL_LF, A5

    MOVE.L  #SPL_MAX-1, D5

US_LOOP:
    MOVE.L  D5, D0
    ASL.L   #2, D0

    TST.L   0(A0,D0.L)
    BEQ     US_NXT

    ;decrement lifetime
    SUB.L   #1, 0(A5,D0.L)
    TST.L   0(A5,D0.L)
    BGT     US_ALIVE

    ;expired -> deactivate
    MOVE.L  #0, 0(A0,D0.L)
    BRA     US_NXT

US_ALIVE:
    ;move by velocity
    MOVE.L  0(A3,D0.L), D1
    ADD.L   D1, 0(A1,D0.L)

    MOVE.L  0(A4,D0.L), D1
    ADD.L   D1, 0(A2,D0.L)

    ;add gravity every 3 frames so they arc nicely
    MOVE.L  0(A5,D0.L), D1
    DIVU    #3, D1
    SWAP    D1
    AND.L   #$FFFF, D1
    TST.L   D1
    BNE     US_NXT
    ADD.L   #1, 0(A4,D0.L)

US_NXT:
    DBRA    D5, US_LOOP

    MOVEM.L (SP)+, D0-D5/A0-A5
    RTS


; draw each active particle as a small blue dot
; colour fades from cyan to dark blue over time
; and size goes from 3px down to 1px
DRAW_SPLASH:
    MOVEM.L D0-D7/A0-A5, -(SP)

    LEA     SPL_TBL_ACT, A0
    LEA     SPL_TBL_X, A1
    LEA     SPL_TBL_Y, A2
    LEA     SPL_TBL_LF, A5

    MOVE.L  #SPL_MAX-1, D7

DS_LOOP:
    MOVE.L  D7, D0
    ASL.L   #2, D0

    TST.L   0(A0,D0.L)
    BEQ     DS_NXT

    ;pick a shade of blue depending on how old the particle is
    MOVE.L  0(A5,D0.L), D1
    CMP.L   #24, D1
    BGE     DS_C1
    CMP.L   #18, D1
    BGE     DS_C2
    CMP.L   #12, D1
    BGE     DS_C3
    CMP.L   #6, D1
    BGE     DS_C4
    BRA     DS_C5

DS_C1:
    MOVE.L  #$00BBFFFF, D1          ;bright cyan
    BRA     DS_SCLR
DS_C2:
    MOVE.L  #$0088DDFF, D1          ;light blue
    BRA     DS_SCLR
DS_C3:
    MOVE.L  #$004499DD, D1          ;mid blue
    BRA     DS_SCLR
DS_C4:
    MOVE.L  #$002266AA, D1          ;darker
    BRA     DS_SCLR
DS_C5:
    MOVE.L  #$00114488, D1          ;nearly gone

DS_SCLR:
    MOVE.B  #80, D0
    TRAP    #15

    ;reload slot offset
    MOVE.L  D7, D0
    ASL.L   #2, D0

    MOVE.L  0(A1,D0.L), D5         ;X
    MOVE.L  0(A2,D0.L), D6         ;Y

    ;--- pick dot size based on lifetime ---
    ;starts big, shrinks as it fades
    MOVE.L  0(A5,D0.L), D0

    CMP.L   #20, D0
    BGE     DS_SZ3
    CMP.L   #10, D0
    BGE     DS_SZ2
    BRA     DS_SZ1

DS_SZ3:
    ;3px dot (small filled rect)
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    ADD.L   #2, D3
    MOVE.L  D6, D4
    ADD.L   #2, D4
    BRA     DS_DRAW

DS_SZ2:
    ;2px dot
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    ADD.L   #1, D3
    MOVE.L  D6, D4
    ADD.L   #1, D4
    BRA     DS_DRAW

DS_SZ1:
    ;1px dot
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    MOVE.L  D6, D4

DS_DRAW:
    MOVE.B  #84, D0                 ;draw it
    TRAP    #15

DS_NXT:
    DBRA    D7, DS_LOOP

    MOVEM.L (SP)+, D0-D7/A0-A5
    RTS


; particle data tables
SPL_TBL_X       DS.L    SPL_MAX
SPL_TBL_Y       DS.L    SPL_MAX
SPL_TBL_VX      DS.L    SPL_MAX     ;x speed
SPL_TBL_VY      DS.L    SPL_MAX     ;y speed (negative = up)
SPL_TBL_LF      DS.L    SPL_MAX     ;frames left alive
SPL_TBL_ACT     DS.L    SPL_MAX     ;1 = alive, 0 = dead

;set these before calling SPAWN_SPLASH
SPL_SPAWN_X     DS.L    1
SPL_SPAWN_Y     DS.L    1


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
