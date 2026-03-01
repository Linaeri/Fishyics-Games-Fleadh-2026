MOON_SPEED          EQU     1
MOON_PURPLE_BASE    EQU     20      ;radius
MOON_PINK_BASE      EQU     12      ;radius
MOON_PINK_OFF_X     EQU     35      ;pink X offset from purple centre
MOON_PINK_OFF_Y     EQU     -10     ;pink Y offset (higher in sky)
MOON_PURPLE_Y       EQU     45      ;purple centre Y in sky
MOON_GROW_MAX       EQU     20
MOON_GROW_MIN       EQU     0
MOON_GROW_RATE      EQU     20      ;frames between each +1/-1 step

MOON_PURPLE_CLR     EQU     $00800040
MOON_PINK_CLR       EQU     $009060FF

*-----------------------------------------------------------
* Subroutine : INIT_MOONS
* Description: place the moons
*-----------------------------------------------------------
INIT_MOONS:
    MOVE.L  #-30, MOON_X
    MOVE.L  #MOON_GROW_MAX,   MOON_GROW     ;starting at high tide => max size
    MOVE.L  #0,   MOON_GROW_TIMER           ;set timer
    RTS

*-----------------------------------------------------------
* Subroutine : UPDATE_MOONS
* Description: grow + move
*-----------------------------------------------------------
UPDATE_MOONS:

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
    RTS

*-----------------------------------------------------------
* Subroutine : DRAW_MOONS
* Description: draw 
*-----------------------------------------------------------
DRAW_MOONS:
;purple moon
    ;set pen + fill colour
    MOVE.L  #MOON_PURPLE_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #MOON_PURPLE_CLR, D1
    MOVE.B  #81, D0
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

    RTS

MOON_X              DS.L    1       ;purple moon centre X
MOON_GROW           DS.L    1       ;current extra radius (0..4)
MOON_GROW_TIMER     DS.L    1       ;frame counter for grwing




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
