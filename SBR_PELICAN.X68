;weird bug in this file, it was telling me some of the labels
;had too long names and gave me errors
;hadt to shorten them
;i don't get why, other files have even longer label names

PELICAN_W           EQU     50      
PELICAN_H           EQU     25      
PELICAN_SPD         EQU     3
PELICAN_SAFE_SZ     EQU     4       ;player size needed to survive
PELICAN_PTS         EQU     150

PELICAN_Y_OFFSET    EQU 40          ; pixels above current tide Y


*-----------------------------------------------------------
* Subroutine    : INIT_PELICAN
* Description   : set up the bird
*-----------------------------------------------------------
INIT_PELICAN:
    MOVE.L  #0, PELICAN_ACTIVE
    MOVE.L  #-200, PELICAN_X       ;off screen
    MOVE.L  #0, PELICAN_Y
    MOVE.L  #1, PELICAN_DIR        ;default right
    RTS


*-----------------------------------------------------------
* Subroutine    : SPAWN_PELICAN
* Description   : spawn if player eats a fish
*-----------------------------------------------------------
SPAWN_PELICAN:
    ;only spawn if not already active
    CMP.L   #1, PELICAN_ACTIVE
    BEQ     .SP_DONE

    ;set active
    MOVE.L  #1, PELICAN_ACTIVE

    ;random direction: 0 or 1
    MOVE.L  #0, D0
    MOVE.L  #1, D1
    MOVEM.L D7/A0-A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D7/A0-A4

    ;convert 0/1 to -1/+1
    ADD.L   D3, D3                  ;0->0, 1->2
    SUB.L   #1, D3                  ;0->-1, 2->1
    MOVE.L  D3, PELICAN_DIR

    ;spawn X based on direction
    CMP.L   #1, D3
    BEQ     .SP_LEFT

    ;moving left -> spawn off right side
    CLR.L   D0
    MOVE.W  SCREEN_W, D0
    ADD.L   #50, D0
    MOVE.L  D0, PELICAN_X
    BRA     .SP_SETY

.SP_LEFT:
    ;moving right -> spawn off left side
    MOVE.L  #-80, PELICAN_X

.SP_SETY:
    ;fly just above the current waterline
    MOVE.L  WTR_CURRENT_Y, D0
    SUB.L   #PELICAN_Y_OFFSET, D0
    SUB.L   #PELICAN_H, D0         ;keep above watter
    
    ;check top of the screen
    CMP.L   #10, D0
    BGE     .SP_YOK
    MOVE.L  #10, D0
.SP_YOK:
    MOVE.L  D0, PELICAN_Y

.SP_DONE:
    RTS


*-----------------------------------------------------------
* Subroutine    : UPDATE_PELICAN
* Description   : move pelican
*-----------------------------------------------------------
UPDATE_PELICAN:
    ;skip if not active
    CMP.L   #1, PELICAN_ACTIVE
    BNE     .UP_DONE

    ;move X by speed * direction
    MOVE.L  PELICAN_DIR, D1
    MULS    #PELICAN_SPD, D1
    ADD.L   D1, PELICAN_X

    ;keep above water
    MOVE.L  WTR_CURRENT_Y, D0
    SUB.L   #PELICAN_Y_OFFSET, D0
    SUB.L   #PELICAN_H, D0

    ;move pelican toward target Y smoothly
    MOVE.L  PELICAN_Y, D1
    CMP.L   D0, D1
    BEQ     .UY_CLMP                ;already at target
    BGT     .PEL_UP                 ;pelican below target, fly up

    ;pelican above target, drift down
    ADD.L   #2, D1                  ;drift down at 2px/frame
    CMP.L   D0, D1
    BLE     .UY_STR
    MOVE.L  D0, D1                  ;don't overshoot
    BRA     .UY_STR

.PEL_UP:
    ;tide rising, fly up faster than tide
    SUB.L   #3, D1                  ;fly up at 3px/frame
    CMP.L   D0, D1
    BGE     .UY_STR
    MOVE.L  D0, D1                  ;don't overshoot

;update y store
.UY_STR:
    ;clamp to top of screen
    CMP.L   #10, D1
    BGE     .UY_CLMP
    MOVE.L  #10, D1
    
;update y clamp
.UY_CLMP:
    MOVE.L  D1, PELICAN_Y

    ;check if pelican has left the screen
    MOVE.L  PELICAN_DIR, D1
    CMP.L   #1, D1
    BEQ     .CHK_RT

    ;moving left, check if past left edge
    MOVE.L  PELICAN_X, D0
    CMP.L   #-100, D0
    BGT     .UP_DONE               ;still on screen
    MOVE.L  #0, PELICAN_ACTIVE     ;deactivate
    BRA     .UP_DONE

;check right
.CHK_RT:
    ;moving right, check if past right edge
    MOVE.L  PELICAN_X, D0
    CLR.L   D1
    MOVE.W  SCREEN_W, D1
    ADD.L   #100, D1
    CMP.L   D1, D0
    BLT     .UP_DONE               ;still on screen
    MOVE.L  #0, PELICAN_ACTIVE     ;deactivate

.UP_DONE:
    RTS


*-----------------------------------------------------------
* Subroutine    : CHECK_PELICAN_COLLISION
* Description   : check colls
*-----------------------------------------------------------
CHECK_PELICAN_COLLISION:
    ;skip if not active
    CMP.L   #1, PELICAN_ACTIVE
    BNE     .PEL_CD

    ;PLAYER_X < PELICAN_X + PELICAN_W ?
    MOVE.L  PLAYER_X, D1
    MOVE.L  PELICAN_X, D2
    ADD.L   #PELICAN_W, D2
    CMP.L   D2, D1
    BGE     .PEL_CD

    ;PLAYER_X + PLAYER_W > PELICAN_X ?
    MOVE.L  PLAYER_X, D1
    ADD.L   PLYR_W_CURRENT, D1
    MOVE.L  PELICAN_X, D2
    CMP.L   D2, D1
    BLE     .PEL_CD

    ;PLAYER_Y < PELICAN_Y + PELICAN_H ?
    MOVE.L  PLAYER_Y, D1
    MOVE.L  PELICAN_Y, D2
    ADD.L   #PELICAN_H, D2
    CMP.L   D2, D1
    BGE     .PEL_CD

    ;PLAYER_Y + PLAYER_H > PELICAN_Y ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    MOVE.L  PELICAN_Y, D2
    CMP.L   D2, D1
    BLE     .PEL_CD

    ;check who eats who
    MOVE.L  PLAYER_SIZE, D0
    CMP.L   #PELICAN_SAFE_SZ, D0
    BGE     .PEL_EAT

    ;too small, pelican eats the player
    MOVEM.L D0-D3/A0-A2, -(SP)
    JSR     TRIGGER_ACH_PELICAN     ;pelican achievement
    MOVEM.L (SP)+, D0-D3/A0-A2
    JMP     PLAYER_DIED

.PEL_EAT:
    ;player eats the pelican
    ADD.L   #PELICAN_PTS, PLAYER_SCORE
    MOVE.L  #0, PELICAN_ACTIVE
    MOVEM.L D7/A0-A2, -(SP)
    JSR     TRIGGER_ACH_PELICAN     ;pelican achievement
    BSR     CHECK_GROWTH
    MOVEM.L (SP)+, D7/A0-A2

.PEL_CD:
    RTS

;draw pelican placeholder
DRAW_PELICAN:
    CMP.L   #1, PELICAN_ACTIVE
    BNE     .DR_DONE

    MOVE.L  #$00446688, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00446688, D1
    MOVE.B  #81, D0
    TRAP    #15

    MOVE.L  PELICAN_X, D1
    MOVE.L  PELICAN_Y, D2
    MOVE.L  D1, D3
    ADD.L   #PELICAN_W, D3
    MOVE.L  D2, D4
    ADD.L   #PELICAN_H, D4
    MOVE.B  #87, D0
    TRAP    #15

.DR_DONE:
    RTS


PELICAN_X       DS.L    1
PELICAN_Y       DS.L    1
PELICAN_DIR     DS.L    1           ;-1 = left, 1 = right
PELICAN_ACTIVE  DS.L    1           ;1 = flying, 0 = inactive



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
