*-----------------------------------------------------------
* Section       : Enemy Counts
* Description   : How many of each fish type to spawn
*-----------------------------------------------------------
NUM_SARDINE     EQU     5
NUM_CLOWNFISH   EQU     5
NUM_SPOTTY      EQU     5
NUM_CRAB        EQU     5
NUM_ANGELFISH   EQU     5
NUM_SHARK       EQU     1
NUM_ENEMIES     EQU     26

;fish type IDs
TYPE_SMALL      EQU     0           ;sardine
TYPE_MEDIUM     EQU     1           ;clownfish
TYPE_LARGE      EQU     2           ;spotty
TYPE_CRAB       EQU     3           ;crab
TYPE_ANGEL      EQU     4           ;angelfish
TYPE_SHARK      EQU     5           ;shark

;property offsets for each type
PROP_W          EQU     0
PROP_H          EQU     4
PROP_SPD        EQU     8
PROP_YMIN       EQU     12
PROP_YMAX       EQU     16
PROP_SIZE       EQU     20

;the next three enemies are - small, medium, large
;original names, did not have it in me, to rename them
;the easy68k editor does not have function for rewriting multiple names uf
;i'll do it in different editor if i have time

;so => SMALL = SARDINE, MEDIUM = CLOWNFISH, LARGE = SPOTTY
;small fish properties (sardine)
SMALL_W         EQU     8
SMALL_H         EQU     6
SMALL_SPD       EQU     2
SMALL_CLR       EQU     $00FFFFFF

;medium fish properties (clownfish)
MEDIUM_W        EQU     16
MEDIUM_H        EQU     10
MEDIUM_SPD      EQU     2
MEDIUM_CLR      EQU     $00008000

;large fish properties (spotty)
LARGE_W         EQU     28
LARGE_H         EQU     16
LARGE_SPD       EQU     1
LARGE_CLR       EQU     $000000FF

;crab properties
CRAB_W          EQU     36
CRAB_H          EQU     22
CRAB_SPD        EQU     2
CRAB_CLR        EQU     $000080FF       ;orang

;angelfish properties
ANGEL_W         EQU     48
ANGEL_H         EQU     30
ANGEL_SPD       EQU     1
ANGEL_CLR       EQU     $00FFFF00       ;cyan

;shark properties
SHARK_W         EQU     64
SHARK_H         EQU     36
SHARK_SPD       EQU     1
SHARK_CLR       EQU     $00505050       ;dark grey

SARDINE_YMIN    EQU     80          
SARDINE_YMAX    EQU     250         
CLOWN_YMIN      EQU     150         
CLOWN_YMAX      EQU     380         
SPOTTY_YMIN     EQU     300         
SPOTTY_YMAX     EQU     550         
CRAB_YMIN       EQU     660         
CRAB_YMAX       EQU     740         
ANGEL_YMIN      EQU     350         
ANGEL_YMAX      EQU     620         
SHARK_YMIN      EQU     250         
SHARK_YMAX      EQU     500         

;points per fish type
SMALL_PTS       EQU     10
MEDIUM_PTS      EQU     25
LARGE_PTS       EQU     50
CRAB_PTS        EQU     75
ANGEL_PTS       EQU     100
SHARK_PTS       EQU     200

;min spawn window
MIN_SPAWN_WINDOW   EQU 80

;growth thresholds in score points
GROW_THRESH_1   EQU     100
GROW_THRESH_2   EQU     300
GROW_THRESH_3   EQU     600
GROW_THRESH_4   EQU     1000        
GROW_THRESH_5   EQU     1500

;player sizes per growth stage, MOVE TO PLAYER
PLYR_W_SM       EQU     8
PLYR_H_SM       EQU     8
PLYR_W_MD       EQU     18
PLYR_H_MD       EQU     12
PLYR_W_LG       EQU     30
PLYR_H_LG       EQU     20
PLYR_W_XL       EQU     40
PLYR_H_XL       EQU     26
PLYR_W_XXL      EQU     52
PLYR_H_XXL      EQU     34
PLYR_W_MAX      EQU     68
PLYR_H_MAX      EQU     40


*-----------------------------------------------------------
* Section       : Fish Property Lookup Table
* Description   : 20 bytes per type: W, H, Speed, Y_MIN, Y_MAX
*         Access: base + (type * 20) + offset
*-----------------------------------------------------------
FISH_PROPS:
    ;type 0 - sardine, offset 0
    DC.L    SMALL_W
    DC.L    SMALL_H
    DC.L    SMALL_SPD
    DC.L    SARDINE_YMIN
    DC.L    SARDINE_YMAX
    ;type 1 - clownfish, offset 20
    DC.L    MEDIUM_W
    DC.L    MEDIUM_H
    DC.L    MEDIUM_SPD
    DC.L    CLOWN_YMIN
    DC.L    CLOWN_YMAX
    ;type 2 - spotty, offset 40
    DC.L    LARGE_W
    DC.L    LARGE_H
    DC.L    LARGE_SPD
    DC.L    SPOTTY_YMIN
    DC.L    SPOTTY_YMAX
    ;type 3 - crab, offset 60
    DC.L    CRAB_W
    DC.L    CRAB_H
    DC.L    CRAB_SPD
    DC.L    CRAB_YMIN
    DC.L    CRAB_YMAX
    ;type 4 - angelfish, offset 80
    DC.L    ANGEL_W
    DC.L    ANGEL_H
    DC.L    ANGEL_SPD
    DC.L    ANGEL_YMIN
    DC.L    ANGEL_YMAX
    ;type 5 - shark, offset 100
    DC.L    SHARK_W
    DC.L    SHARK_H
    DC.L    SHARK_SPD
    DC.L    SHARK_YMIN
    DC.L    SHARK_YMAX


*-----------------------------------------------------------
* Subroutine    : GET_PROPS
* Description   : access properties of types
*-----------------------------------------------------------
GET_PROPS:
    MULU    #PROP_SIZE, D5          ;type * 20
    LEA     FISH_PROPS, A3
    ADDA.L  D5, A3
    RTS


*-----------------------------------------------------------
* Subroutine    : INIT_ALL_ENEMIES
* Description:    self explanatory
*-----------------------------------------------------------
INIT_ALL_ENEMIES:
    ;initialise player growth state
    MOVE.L  #0, PLAYER_SIZE
    MOVE.L  #PLYR_W_SM, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_SM, PLYR_H_CURRENT

    LEA     ENEMY_TABLE_X, A0
    LEA     ENEMY_TABLE_Y, A1
    LEA     ENEMY_TABLE_TYPE, A2
    LEA     ENEMY_TABLE_DIR, A4

    ;sardine fish (type 0)
    MOVE.L  #NUM_SARDINE-1, D7
    MOVE.L  #TYPE_SMALL, D6
INIT_SMALL_LOOP:
    BSR     INIT_ONE_ENEMY
    DBRA    D7, INIT_SMALL_LOOP

    ;clownfish (type 1)
    MOVE.L  #NUM_CLOWNFISH-1, D7
    MOVE.L  #TYPE_MEDIUM, D6
INIT_MEDIUM_LOOP:
    BSR     INIT_ONE_ENEMY
    DBRA    D7, INIT_MEDIUM_LOOP

    ;spotty fish (type 2)
    MOVE.L  #NUM_SPOTTY-1, D7
    MOVE.L  #TYPE_LARGE, D6
INIT_LARGE_LOOP:
    BSR     INIT_ONE_ENEMY
    DBRA    D7, INIT_LARGE_LOOP

    ;crab (type 3)
    MOVE.L  #NUM_CRAB-1, D7
    MOVE.L  #TYPE_CRAB, D6
INIT_CRAB_LOOP:
    BSR     INIT_ONE_ENEMY
    DBRA    D7, INIT_CRAB_LOOP

    ;angelfish (type 4)
    MOVE.L  #NUM_ANGELFISH-1, D7
    MOVE.L  #TYPE_ANGEL, D6
INIT_ANGEL_LOOP:
    BSR     INIT_ONE_ENEMY
    DBRA    D7, INIT_ANGEL_LOOP

    ;shark (type 5)
    MOVE.L  #NUM_SHARK-1, D7
    MOVE.L  #TYPE_SHARK, D6
INIT_SHARK_LOOP:
    BSR     INIT_ONE_ENEMY
    DBRA    D7, INIT_SHARK_LOOP

    RTS


*-----------------------------------------------------------
* Subroutine    : INIT_ONE_ENEMY
* Description   : name self explanatory
*-----------------------------------------------------------
INIT_ONE_ENEMY:
    ;random direction: generate 0 or 1
    MOVE.L  #0, D0
    MOVE.L  #1, D1
    MOVEM.L D6-D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D6-D7/A0-A2/A4
    
    ;convert 0/1 to -1/+1
    ADD.L   D3, D3                  ;0 -> 0, 1 -> 2
    SUB.L   #1, D3                  ;0 -> -1, 2 -> 1
    MOVE.L  D3, D5                  ;save direction
    MOVE.L  D5, (A4)+               ;store direction

    ;spawn X based on direction
    CMP.L   #1, D5
    BEQ     INIT_SPAWN_LEFT         ;moving right -> spawn off left

    ;moving left -> spawn off right side
    CLR.L   D0
    MOVE.W  SCREEN_W, D0
    MOVE.L  D0, D1
    ADD.L   #400, D1
    MOVEM.L D5-D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D5-D7/A0-A2/A4
    MOVE.L  D3, (A0)+
    BRA     INIT_SPAWN_Y

INIT_SPAWN_LEFT:
    ;moving right -> spawn off left side
    MOVE.L  #0, D0
    MOVE.L  #300, D1
    MOVEM.L D5-D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D5-D7/A0-A2/A4
    NEG.L   D3                      ;make negative (off left edge)
    MOVE.L  D3, (A0)+

INIT_SPAWN_Y:
    ;look up Y range for this fish type
    MOVE.L  D6, D5
    BSR     GET_PROPS

    ;random Y within type's range
    MOVE.L  PROP_YMIN(A3), D0
    MOVE.L  PROP_YMAX(A3), D1
    MOVEM.L D5-D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D5-D7/A0-A2/A4
    MOVE.L  D3, (A1)+

    ;store type
    MOVE.L  D6, (A2)+
    RTS

*-----------------------------------------------------------
* Subroutine    : MOVE_ALL_ENEMIES
* Description   : :)
*-----------------------------------------------------------
MOVE_ALL_ENEMIES:
    LEA     ENEMY_TABLE_X, A0
    LEA     ENEMY_TABLE_Y, A1
    LEA     ENEMY_TABLE_TYPE, A2
    LEA     ENEMY_TABLE_DIR, A4

    MOVE.L  #NUM_ENEMIES-1, D7

MOVE_ENEMY_LOOP:
    ;look up speed from type
    MOVE.L  (A2), D5
    BSR     GET_PROPS              ;props in A3

    ;X += speed * direction
    MOVE.L  PROP_SPD(A3), D1       ;speed
    MOVE.L  (A4), D2               ;direction (-1 or 1)
    MULS    D2, D1                 ;signed: negative=left, positive=right
    MOVE.L  (A0), D3               ;current X
    ADD.L   D1, D3                 ;apply movement

    ;check what edge should be checked
    MOVE.L  (A4), D2
    CMP.L   #-1, D2
    BEQ     CHECK_LEFT_EDGE

    ;check right edge
    CLR.L   D4
    MOVE.W  SCREEN_W, D4
    ADD.L   PROP_W(A3), D4
    CMP.L   D4, D3
    BGE     RESET_RIGHT_MOVER
    MOVE.L  D3, (A0)
    BRA     NEXT_ENEMY

CHECK_LEFT_EDGE:
    MOVE.L  PROP_W(A3), D4
    NEG.L   D4
    CMP.L   D4, D3
    BLE     RESET_LEFT_MOVER
    MOVE.L  D3, (A0)
    BRA     NEXT_ENEMY

RESET_LEFT_MOVER:
RESET_RIGHT_MOVER:
    ;save A3 so we keep type props cause of random calls
    MOVEM.L A3, -(SP)

    ;rerandomize direction on respawn
    MOVE.L  #0, D0
    MOVE.L  #1, D1
    MOVEM.L D7/A0-A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D7/A0-A4
    ADD.L   D3, D3
    SUB.L   #1, D3
    MOVE.L  D3, (A4)

    CMP.L   #1, D3
    BEQ     RESPAWN_OFF_LEFT

    ;new direction is left, spawn off right side
    CLR.L   D0
    MOVE.W  SCREEN_W, D0
    MOVE.L  D0, D1
    ADD.L   #300, D1
    MOVEM.L D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D7/A0-A2/A4
    MOVE.L  D3, (A0)
    BRA     RESET_ENEMY_Y

RESPAWN_OFF_LEFT:
    ;new direction is right, spawn off left side
    MOVE.L  #0, D0
    MOVE.L  #50, D1
    MOVEM.L D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D7/A0-A2/A4
    NEG.L   D3
    MOVE.L  D3, (A0)

RESET_ENEMY_Y:
    ;restore A3 so we can read type Y range
    MOVEM.L (SP)+, A3

    ;min Y = max(type Y_MIN, water level) so fish stays underwater
    MOVE.L  PROP_YMIN(A3), D0
    CMP.L   WTR_CURRENT_Y, D0
    BGE     .RESET_YMIN_OK          ; type min already below water
    MOVE.L  WTR_CURRENT_Y, D0       ; clamp to water level

;checking if small fish can respawn at the tide
;there must be at lesast 80px windows because otherwise
;they would all spanw in a line
.RESET_YMIN_OK:
    MOVE.L  PROP_YMAX(A3), D1       ; max Y from type range
    ;check if range is wide enough for good spread
    MOVE.L  D1, D2
    SUB.L   D0, D2                  ; range = max - min
    CMP.L   #MIN_SPAWN_WINDOW, D2                 ; need at least 80px of Y range
    BGE     .RESET_Y_OK             ; range is wide enough, spawn
    
    ;water is below this type's Y range, retry next frame
    ;stagger X by loop counter so they don't all enter together
    MOVE.L  PROP_W(A3), D0
    NEG.L   D0
    SUB.L   #1, D0
    MOVE.L  D7, D1
    MULU    #120, D1                ; 120px gap per fish
    SUB.L   D1, D0
    MOVE.L  D0, (A0)               ; X = -(width+1+offset)
    MOVE.L  #-1, (A4)              ; force direction left so wrap fires
    BRA     NEXT_ENEMY
.RESET_Y_OK:
    MOVEM.L D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D7/A0-A2/A4
    MOVE.L  D3, (A1)

NEXT_ENEMY:
    ;if tide rose above a fish, push it down to the water line
    MOVE.L  (A1), D3
    CMP.L   WTR_CURRENT_Y, D3
    BGE     .ENEMY_IN_WATER         ; already below water, fine
    MOVE.L  WTR_CURRENT_Y, (A1)     ; move it to water level
.ENEMY_IN_WATER:

    ADDA.L  #4, A0
    ADDA.L  #4, A1
    ADDA.L  #4, A2
    ADDA.L  #4, A4
    DBRA    D7, MOVE_ENEMY_LOOP

    JSR     FISH_EAT_FISH

    RTS

*-----------------------------------------------------------
* Subroutine    : DRAW_ALL_ENEMIES
* Description   : draw enemies
*-----------------------------------------------------------
DRAW_ALL_ENEMIES:
    LEA     ENEMY_TABLE_X, A0
    LEA     ENEMY_TABLE_Y, A1
    LEA     ENEMY_TABLE_TYPE, A2
    LEA     ENEMY_TABLE_DIR, A4


    MOVE.L  #NUM_ENEMIES-1, D7

DRAW_ENEMY_LOOP:
    ;lookup props
    MOVE.L  (A2), D5
    BSR     GET_PROPS

    ;visibility check using width
    MOVE.L  (A0), D1                ; x
    MOVE.L  PROP_W(A3), D6          ; width

    MOVE.L  D6, D2
    NEG.L   D2                      ; -width
    CMP.L   D2, D1
    BLT     SKIP_DRAW_ENEMY         ; if x < -width

    CLR.L   D3
    MOVE.W  SCREEN_W, D3
    ADD.L   D6, D3                  ; screen_w + width
    CMP.L   D3, D1
    BGT     SKIP_DRAW_ENEMY         ; if x > screen_w + width

    MOVE.L  (A0), D1                ; D1 = enemyX
    MOVE.L  (A1), D2                ; D2 = enemyY

    MOVE.L  (A2), D5
    CMP.L   #TYPE_SMALL, D5
    BEQ     DO_DRAW_SMALL
    CMP.L   #TYPE_MEDIUM, D5
    BEQ     DO_DRAW_MEDIUM
    CMP.L   #TYPE_LARGE, D5
    BEQ     DO_DRAW_LARGE
    CMP.L   #TYPE_CRAB, D5
    BEQ     DO_DRAW_CRAB
    CMP.L   #TYPE_ANGEL, D5
    BEQ     DO_DRAW_ANGEL
    CMP.L   #TYPE_SHARK, D5
    BEQ     DO_DRAW_SHARK
    BRA     DONE_ENEMY_DRAW         ; safety fallthrough

DO_DRAW_SMALL:
    MOVE.L  (A4), D3
    MOVEM.L D7/A0-A4, -(SP)
    JSR     DRAW_SARDINE
    MOVEM.L (SP)+, D7/A0-A4
    BRA     DONE_ENEMY_DRAW

DO_DRAW_MEDIUM:
    MOVE.L  (A4), D3
    MOVEM.L D7/A0-A4, -(SP)
    JSR     DRAW_CLOWNFISH
    MOVEM.L (SP)+, D7/A0-A4
    BRA     DONE_ENEMY_DRAW

DO_DRAW_LARGE:
    MOVEM.L D7/A0-A4, -(SP)
    BSR     DRAW_ENEMY_FISH_LARGE
    MOVEM.L (SP)+, D7/A0-A4
    BRA     DONE_ENEMY_DRAW

DO_DRAW_CRAB:
    MOVEM.L D7/A0-A4, -(SP)
    BSR     DRAW_ENEMY_CRAB
    MOVEM.L (SP)+, D7/A0-A4
    BRA     DONE_ENEMY_DRAW

DO_DRAW_ANGEL:
    MOVEM.L D7/A0-A4, -(SP)
    BSR     DRAW_ENEMY_ANGELFISH
    MOVEM.L (SP)+, D7/A0-A4
    BRA     DONE_ENEMY_DRAW

DO_DRAW_SHARK:
    MOVE.L  (A4), D3
    MOVEM.L D7/A0-A4, -(SP)
    BSR     DRAW_SHARK
    MOVEM.L (SP)+, D7/A0-A4

DONE_ENEMY_DRAW:
SKIP_DRAW_ENEMY:
    ADDA.L  #4, A0
    ADDA.L  #4, A1
    ADDA.L  #4, A2
    ADDA.L  #4, A4
    DBRA    D7, DRAW_ENEMY_LOOP

    RTS


*-----------------------------------------------------------
* Enemy Fish Drawing Routines
* Input: D1 = baseX (enemy X), D2 = baseY (enemy Y)
*-----------------------------------------------------------

;large fish 28x16 body (SPOTTY)
DRAW_ENEMY_FISH_LARGE:
    MOVE.L  D1, D5
    MOVE.L  D2, D6

    ;set colour
    MOVE.L  #LARGE_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #LARGE_CLR, D1
    MOVE.B  #81, D0
    TRAP    #15

    ; body
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    ADD.L   #28, D3
    MOVE.L  D6, D4
    ADD.L   #16, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; mouth
    MOVE.L  D5, D1
    SUB.L   #6, D1
    MOVE.L  D6, D2
    ADD.L   #5, D2
    MOVE.L  D5, D3
    MOVE.L  D6, D4
    ADD.L   #11, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; top fin
    MOVE.L  D5, D1
    ADD.L   #10, D1
    MOVE.L  D6, D2
    SUB.L   #3, D2
    MOVE.L  D5, D3
    ADD.L   #20, D3
    MOVE.L  D6, D4
    ADD.L   #2, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; bottom fin
    MOVE.L  D5, D1
    ADD.L   #10, D1
    MOVE.L  D6, D2
    ADD.L   #15, D2
    MOVE.L  D5, D3
    ADD.L   #20, D3
    MOVE.L  D6, D4
    ADD.L   #20, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; tail base
    MOVE.L  D5, D1
    ADD.L   #28, D1
    MOVE.L  D6, D2
    ADD.L   #6, D2
    MOVE.L  D5, D3
    ADD.L   #36, D3
    MOVE.L  D6, D4
    ADD.L   #10, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; tail fork lines
    MOVE.L  #4, D1
    MOVE.B  #93, D0
    TRAP    #15

    ; upper line
    MOVE.L  D5, D1
    ADD.L   #34, D1
    MOVE.L  D6, D2
    ADD.L   #8, D2
    MOVE.L  D5, D3
    ADD.L   #46, D3
    MOVE.L  D6, D4
    ADD.L   #3, D4
    MOVE.B  #84, D0
    TRAP    #15

    ; lower line
    MOVE.L  D5, D1
    ADD.L   #34, D1
    MOVE.L  D6, D2
    ADD.L   #8, D2
    MOVE.L  D5, D3
    ADD.L   #46, D3
    MOVE.L  D6, D4
    ADD.L   #13, D4
    MOVE.B  #84, D0
    TRAP    #15

    ; reset pen width 1
    MOVE.L  #1, D1
    MOVE.B  #93, D0
    TRAP    #15

    ; eye
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15

    MOVE.L  D5, D1
    ADD.L   #6, D1
    MOVE.L  D6, D2
    ADD.L   #6, D2
    MOVE.L  D5, D3
    ADD.L   #9, D3
    MOVE.L  D6, D4
    ADD.L   #9, D4
    MOVE.B  #87, D0
    TRAP    #15

    RTS


DRAW_ENEMY_CRAB:
    MOVE.L  D1, D5          ; baseX
    MOVE.L  D2, D6          ; baseY

    ;set colour - orange
    MOVE.L  #CRAB_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #CRAB_CLR, D1
    MOVE.B  #81, D0
    TRAP    #15

    ; main body
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    ADD.L   #36, D3
    MOVE.L  D6, D4
    ADD.L   #22, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; left claw
    MOVE.L  D5, D1
    SUB.L   #10, D1
    MOVE.L  D6, D2
    ADD.L   #2, D2
    MOVE.L  D5, D3
    ADD.L   #2, D3
    MOVE.L  D6, D4
    ADD.L   #10, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; right claw
    MOVE.L  D5, D1
    ADD.L   #34, D1
    MOVE.L  D6, D2
    ADD.L   #2, D2
    MOVE.L  D5, D3
    ADD.L   #46, D3
    MOVE.L  D6, D4
    ADD.L   #10, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; legs left side
    MOVE.L  D5, D1
    ADD.L   #4, D1
    MOVE.L  D6, D2
    ADD.L   #22, D2
    MOVE.L  D5, D3
    ADD.L   #8, D3
    MOVE.L  D6, D4
    ADD.L   #28, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; legs left midde
    MOVE.L  D5, D1
    ADD.L   #12, D1
    MOVE.L  D6, D2
    ADD.L   #22, D2
    MOVE.L  D5, D3
    ADD.L   #16, D3
    MOVE.L  D6, D4
    ADD.L   #28, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; legs right middle
    MOVE.L  D5, D1
    ADD.L   #20, D1
    MOVE.L  D6, D2
    ADD.L   #22, D2
    MOVE.L  D5, D3
    ADD.L   #24, D3
    MOVE.L  D6, D4
    ADD.L   #28, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; legs right side
    MOVE.L  D5, D1
    ADD.L   #28, D1
    MOVE.L  D6, D2
    ADD.L   #22, D2
    MOVE.L  D5, D3
    ADD.L   #32, D3
    MOVE.L  D6, D4
    ADD.L   #28, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; left eye
    MOVE.L  #$00000000, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15

    MOVE.L  D5, D1
    ADD.L   #8, D1
    MOVE.L  D6, D2
    SUB.L   #4, D2
    MOVE.L  D5, D3
    ADD.L   #12, D3
    MOVE.L  D6, D4
    ADD.L   #2, D4
    MOVE.B  #87, D0
    TRAP    #15

    ;right eye
    MOVE.L  D5, D1
    ADD.L   #24, D1
    MOVE.L  D6, D2
    SUB.L   #4, D2
    MOVE.L  D5, D3
    ADD.L   #28, D3
    MOVE.L  D6, D4
    ADD.L   #2, D4
    MOVE.B  #87, D0
    TRAP    #15

    RTS

DRAW_ENEMY_ANGELFISH:
    MOVE.L  D1, D5          ; baseX
    MOVE.L  D2, D6          ; baseY

    ;set colour - cyan
    MOVE.L  #ANGEL_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #ANGEL_CLR, D1
    MOVE.B  #81, D0
    TRAP    #15

    ; main body
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    ADD.L   #48, D3
    MOVE.L  D6, D4
    ADD.L   #30, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; mouth
    MOVE.L  D5, D1
    SUB.L   #8, D1
    MOVE.L  D6, D2
    ADD.L   #10, D2
    MOVE.L  D5, D3
    MOVE.L  D6, D4
    ADD.L   #20, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; tall fin
    MOVE.L  D5, D1
    ADD.L   #14, D1
    MOVE.L  D6, D2
    SUB.L   #10, D2
    MOVE.L  D5, D3
    ADD.L   #30, D3
    MOVE.L  D6, D4
    ADD.L   #2, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; bottom fin
    MOVE.L  D5, D1
    ADD.L   #14, D1
    MOVE.L  D6, D2
    ADD.L   #28, D2
    MOVE.L  D5, D3
    ADD.L   #30, D3
    MOVE.L  D6, D4
    ADD.L   #38, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; tail:
    MOVE.L  D5, D1
    ADD.L   #48, D1
    MOVE.L  D6, D2
    ADD.L   #8, D2
    MOVE.L  D5, D3
    ADD.L   #60, D3
    MOVE.L  D6, D4
    ADD.L   #22, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; stripe 1
    MOVE.L  #$00808000, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00808000, D1
    MOVE.B  #81, D0
    TRAP    #15

    MOVE.L  D5, D1
    ADD.L   #10, D1
    MOVE.L  D6, D2
    ADD.L   #2, D2
    MOVE.L  D5, D3
    ADD.L   #14, D3
    MOVE.L  D6, D4
    ADD.L   #28, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; stripe 2
    MOVE.L  D5, D1
    ADD.L   #30, D1
    MOVE.L  D6, D2
    ADD.L   #2, D2
    MOVE.L  D5, D3
    ADD.L   #34, D3
    MOVE.L  D6, D4
    ADD.L   #28, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; eye
    MOVE.L  #$00000000, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15

    MOVE.L  D5, D1
    ADD.L   #4, D1
    MOVE.L  D6, D2
    ADD.L   #12, D2
    MOVE.L  D5, D3
    ADD.L   #8, D3
    MOVE.L  D6, D4
    ADD.L   #16, D4
    MOVE.B  #87, D0
    TRAP    #15

    RTS

*-----------------------------------------------------------
* Subroutine    : CHECK_ALL_COLLISIONS
* Description   : checking colls
*-----------------------------------------------------------
CHECK_ALL_COLLISIONS:
    LEA     ENEMY_TABLE_X, A0
    LEA     ENEMY_TABLE_Y, A1
    LEA     ENEMY_TABLE_TYPE, A2

    MOVE.L  #NUM_ENEMIES-1, D7
    MOVE.L  #0, COLLISION_FLAG

CHECK_COLL_LOOP:
    ;get this enemy's width and height via type
    MOVE.L  (A2), D5
    BSR     GET_PROPS

    ;PLAYER_X < ENEMY_X + ENEMY_W ?
    MOVE.L  PLAYER_X, D1
    MOVE.L  (A0), D2
    ADD.L   PROP_W(A3), D2
    CMP.L   D2, D1
    BGE     NO_COLL_THIS

    ;PLAYER_X + PLAYER_W > ENEMY_X ?
    MOVE.L  PLAYER_X, D1
    ADD.L   PLYR_W_CURRENT, D1
    MOVE.L  (A0), D2
    CMP.L   D2, D1
    BLE     NO_COLL_THIS

    ;PLAYER_Y < ENEMY_Y + ENEMY_H ?
    MOVE.L  PLAYER_Y, D1
    MOVE.L  (A1), D2
    ADD.L   PROP_H(A3), D2
    CMP.L   D2, D1
    BGE     NO_COLL_THIS

    ;PLAYER_Y + PLAYER_H > ENEMY_Y ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    MOVE.L  (A1), D2
    CMP.L   D2, D1
    BLE     NO_COLL_THIS

;collision detected
    MOVE.L  (A2), D5
    CMP.L   PLAYER_SIZE, D5
    BGT     PLAYER_DIED

    ;player eats this fish
    MOVE.L  #1, COLLISION_FLAG
    MOVE.L  #-200, (A0)
    
    ;force direction left so it hits wrap and gets new random Y
    LEA     ENEMY_TABLE_DIR, A5
    MOVE.L  #NUM_ENEMIES-1, D4
    SUB.L   D7, D4                  ;D4 = index of this enemy
    ASL.L   #2, D4                  ;* 4 bytes per entry
    MOVE.L  #-1, 0(A5,D4.L)         ;force direction = left

    ;award points
    CMP.L   #TYPE_SMALL, D5
    BEQ     ADD_SM_PTS
    CMP.L   #TYPE_MEDIUM, D5
    BEQ     ADD_MD_PTS
    CMP.L   #TYPE_LARGE, D5
    BEQ     ADD_LG_PTS
    CMP.L   #TYPE_CRAB, D5
    BEQ     ADD_CR_PTS
    CMP.L   #TYPE_ANGEL, D5
    BEQ     ADD_AN_PTS
    ADD.L   #SHARK_PTS, PLAYER_SCORE
    BRA     WIN_START
    ;BRA     ATE_FISH

ADD_SM_PTS:
    ADD.L   #SMALL_PTS, PLAYER_SCORE
    BRA     ATE_FISH
ADD_MD_PTS:
    ADD.L   #MEDIUM_PTS, PLAYER_SCORE
    MOVEM.L D7/A0-A2, -(SP)
    JSR     TRIGGER_ACH_NEMO        ;first clownfish eaten = achievement
    MOVEM.L (SP)+, D7/A0-A2
    BRA     ATE_FISH
ADD_LG_PTS:
    ADD.L   #LARGE_PTS, PLAYER_SCORE
    BRA     ATE_FISH
ADD_CR_PTS:
    ADD.L   #CRAB_PTS, PLAYER_SCORE
    BRA     ATE_FISH
ADD_AN_PTS:
    ADD.L   #ANGEL_PTS, PLAYER_SCORE

ATE_FISH:
    JSR     PLAY_EAT
    MOVEM.L D7/A0-A2, -(SP)
    BSR     SPAWN_PELICAN           ;pelican can has chance to spawn in case player eats fish
    BSR     CHECK_GROWTH
    MOVEM.L (SP)+, D7/A0-A2

NO_COLL_THIS:
    ADDA.L  #4, A0
    ADDA.L  #4, A1
    ADDA.L  #4, A2
    DBRA    D7, CHECK_COLL_LOOP

    CMP.L   #0, COLLISION_FLAG
    BNE     COLL_CHECK_DONE

COLL_CHECK_DONE:
    RTS

*-----------------------------------------------------------
* Subroutine    : CHECK_GROWTH
* Description   : Grow player if score high enough
*-----------------------------------------------------------
CHECK_GROWTH:
    MOVE.L  PLAYER_SCORE, D0

    ;check from highest threshold down
    CMP.L   #GROW_THRESH_5, D0
    BGE     TRY_GROW_5
    CMP.L   #GROW_THRESH_4, D0
    BGE     TRY_GROW_4
    CMP.L   #GROW_THRESH_3, D0
    BGE     TRY_GROW_3
    CMP.L   #GROW_THRESH_2, D0
    BGE     TRY_GROW_2
    CMP.L   #GROW_THRESH_1, D0
    BGE     TRY_GROW_1
    RTS

TRY_GROW_1:
    CMP.L   #1, PLAYER_SIZE
    BGE     GROWTH_DONE
    MOVE.L  #1, PLAYER_SIZE
    JSR     PLAY_GROW
    MOVE.L  #PLYR_W_MD, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_MD, PLYR_H_CURRENT
    RTS

TRY_GROW_2:
    CMP.L   #2, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #2, PLAYER_SIZE
    MOVE.L  #PLYR_W_LG, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_LG, PLYR_H_CURRENT
    RTS

TRY_GROW_3:
    CMP.L   #3, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #3, PLAYER_SIZE
    MOVE.L  #PLYR_W_XL, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_XL, PLYR_H_CURRENT
    RTS

TRY_GROW_4:
    CMP.L   #4, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #4, PLAYER_SIZE
    MOVE.L  #PLYR_W_XXL, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_XXL, PLYR_H_CURRENT
    RTS

TRY_GROW_5:
    CMP.L   #5, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #5, PLAYER_SIZE
    MOVE.L  #PLYR_W_MAX, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_MAX, PLYR_H_CURRENT
GROWTH_DONE:
    RTS


*-----------------------------------------------------------
* Subroutine    : PLAYER_DIED
* Description   : end
*-----------------------------------------------------------
PLAYER_DIED:
    ;MOVE.L  #0, PLAYER_SCORE
    JSR     PLAY_DEATH
    BRA     END_START     
    SIMHALT

ENEMY_TABLE_X       DS.L    NUM_ENEMIES
ENEMY_TABLE_Y       DS.L    NUM_ENEMIES
ENEMY_TABLE_TYPE    DS.L    NUM_ENEMIES
ENEMY_TABLE_DIR     DS.L    NUM_ENEMIES     ;-1 = left, 1 = right

COLLISION_FLAG      DS.L    1
PLAYER_SIZE         DS.L    1               ;0-5 matching fish types

    include "SBR_FISH_EAT_FISH.X68"
    include "SBR_DRAW_SARDINE.X68"
    include "SBR_DRAW_CLOWNFISH.X68"
    include "SBR_DRAW_SHARK.X68"





*~Font name~Courier New~
*~Font size~10~







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
