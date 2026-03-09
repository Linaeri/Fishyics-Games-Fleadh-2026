MOON_SPEED          EQU     1
MOON_PURPLE_BASE    EQU     20      ;radius
MOON_PINK_BASE      EQU     12
MOON_PINK_OFF_X     EQU     35      ;pink offset from purple
MOON_PINK_OFF_Y     EQU     -10     ;higher up
MOON_PURPLE_Y       EQU     45      ;how high in the sky
MOON_GROW_MAX       EQU     20
MOON_GROW_MIN       EQU     0
MOON_GROW_RATE      EQU     20      ;how often to grow/shrink

MOON_PURPLE_CLR     EQU     $00A08888       ;same colour as the sky so it blends in
MOON_PINK_CLR       EQU     $00F8F7F7

;set starting positions
INIT_MOONS:
    MOVE.L  #-20, MOON_X
    MOVE.L  #MOON_GROW_MAX,   MOON_GROW     ;starting at high tide => max size
    MOVE.L  #0,   MOON_GROW_TIMER           ;set timer
    RTS

;move moons across screen, grow/shrink with tide
UPDATE_MOONS:
    MOVEM.L D0-D2, -(SP)

    MOVE.L  MOON_X, D0
    ADD.L   #MOON_SPEED, D0


    MOVE.L  D0, D1
    MOVE.L  #MOON_PURPLE_BASE, D2
    ADD.L   MOON_GROW, D2       ;D2 = current purple radius
    SUB.L   D2, D1              ;D1 = purple left edge

    CLR.L   D2
    MOVE.W  SCREEN_W, D2
    CMP.L   D2, D1
    BLE     .NO_WRAP

    MOVE.L  #-1, D0
    SUB.L   #MOON_PINK_OFF_X, D0
    SUB.L   #MOON_PINK_BASE, D0
    SUB.L   MOON_GROW, D0

.NO_WRAP:
    MOVE.L  D0, MOON_X

;grow / shrink with the tide
    MOVE.L  IS_TIDE_MOVING, D0
    CMP.L   #IS_MOVING_TRUE, D0
    BNE     .UPDATE_DONE            ;tide paused, same size

    ;frame counter
    MOVE.L  MOON_GROW_TIMER, D0
    ADD.L   #1, D0
    CMP.L   #MOON_GROW_RATE, D0
    BLT     .SAVE_TIMER             ; not time yet

    ;counter fired -> reset it and adjust size
    CLR.L   D0

    MOVE.L  WTR_TIDE_DIRECTION, D1
    CMP.L   #TIDE_UP, D1
    BEQ     .DO_GROW

;shrink (tide going down)
    MOVE.L  MOON_GROW, D1
    CMP.L   #MOON_GROW_MIN, D1      
    BLE     .SAVE_TIMER              ;already at min
    SUB.L   #1, D1
    MOVE.L  D1, MOON_GROW
    BRA     .SAVE_TIMER

;grow (tide going up)
.DO_GROW:
    MOVE.L  MOON_GROW, D1
    CMP.L   #MOON_GROW_MAX, D1
    BGE     .SAVE_TIMER             ;already at max
    ADD.L   #1, D1
    MOVE.L  D1, MOON_GROW

.SAVE_TIMER:
    MOVE.L  D0, MOON_GROW_TIMER

.UPDATE_DONE:
    MOVEM.L (SP)+, D0-D2
    RTS

;draw both moons
DRAW_MOONS:
    MOVEM.L D0-D7, -(SP)

;pink moon
    ;set pen + fill colour
    MOVE.L  #MOON_PINK_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #MOON_PINK_CLR, D1
    MOVE.B  #81, D0
    TRAP    #15

    ;D5 = pink radius
    MOVE.L  #MOON_PINK_BASE, D5
    ADD.L   MOON_GROW, D5

    ;pink centre
    MOVE.L  MOON_X, D6
    ADD.L   #MOON_PINK_OFF_X, D6    ;centre X
    MOVE.L  #MOON_PURPLE_Y, D7
    ADD.L   #MOON_PINK_OFF_Y, D7    ;centre Y

    ;bounding box
    MOVE.L  D6, D1
    SUB.L   D5, D1                  ;left X
    MOVE.L  D7, D2
    SUB.L   D5, D2                  ;upper Y
    MOVE.L  D6, D3
    ADD.L   D5, D3                  ;right X
    MOVE.L  D7, D4
    ADD.L   D5, D4                  ;lower Y

    MOVE.B  #88, D0
    TRAP    #15

;purple moon
    ;set pen + fill colour
    MOVE.L  #MOON_PURPLE_CLR, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #MOON_PURPLE_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15

    ;D5 = purple radius
    MOVE.L  #MOON_PURPLE_BASE, D5
    ADD.L   MOON_GROW, D5

    ;bounding box
    MOVE.L  MOON_X, D1
    SUB.L   D5, D1                  ;left X
    MOVE.L  #MOON_PURPLE_Y, D2
    SUB.L   D5, D2                  ;upper Y
    MOVE.L  MOON_X, D3
    ADD.L   D5, D3                  ;right X
    MOVE.L  #MOON_PURPLE_Y, D4
    ADD.L   D5, D4                  ;lower Y

    MOVE.B  #88, D0
    TRAP    #15

    MOVEM.L (SP)+, D0-D7
    RTS

;check if player is touching the big moon (AABB on the bounding box)
CHECK_MOON_COLLISION:
    MOVEM.L D0-D4, -(SP)

    ;already earned? dont bother checking
    CMP.L   #1, ACH_UNLOCKED_8
    BEQ     .CMC_DN

    ;get moon bounding box
    MOVE.L  #MOON_PURPLE_BASE, D0
    ADD.L   MOON_GROW, D0           ;D0 = radius

    ;moon left = MOON_X - radius
    MOVE.L  MOON_X, D1
    SUB.L   D0, D1                  ;D1 = moon left
    ;moon right = MOON_X + radius
    MOVE.L  MOON_X, D2
    ADD.L   D0, D2                  ;D2 = moon right
    ;moon top = MOON_PURPLE_Y - radius
    MOVE.L  #MOON_PURPLE_Y, D3
    SUB.L   D0, D3                  ;D3 = moon top
    ;moon bottom = MOON_PURPLE_Y + radius
    MOVE.L  #MOON_PURPLE_Y, D4
    ADD.L   D0, D4                  ;D4 = moon bottom

    ;player right < moon left?
    MOVE.L  PLAYER_X, D0
    ADD.L   PLYR_W_CURRENT, D0
    CMP.L   D1, D0
    BLE     .CMC_DN

    ;player left > moon right?
    MOVE.L  PLAYER_X, D0
    CMP.L   D2, D0
    BGE     .CMC_DN

    ;player bottom < moon top?
    MOVE.L  PLAYER_Y, D0
    ADD.L   PLYR_H_CURRENT, D0
    CMP.L   D3, D0
    BLE     .CMC_DN

    ;player top > moon bottom?
    MOVE.L  PLAYER_Y, D0
    CMP.L   D4, D0
    BGE     .CMC_DN

    ;touching the moon!
    JSR     TRIGGER_ACH_MOON

.CMC_DN:
    MOVEM.L (SP)+, D0-D4
    RTS

MOON_X              DS.L    1       ;purple centre X
MOON_GROW           DS.L    1       ;extra radius right now
MOON_GROW_TIMER     DS.L    1       ;frame counter for growing





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
