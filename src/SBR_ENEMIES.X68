;how many of each fish to spawn
NUM_SARDINE     EQU     10
NUM_CLOWNFISH   EQU     6
NUM_SPOTTY      EQU     5
NUM_CRAB        EQU     3
NUM_ANGELFISH   EQU     3
NUM_SHARK       EQU     1
NUM_ENEMIES     EQU     28

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
SMALL_W         EQU     10
SMALL_H         EQU     6
SMALL_SPD       EQU     2
SMALL_CLR       EQU     $00FFFFFF

;medium fish properties (clownfish)
MEDIUM_W        EQU     12
MEDIUM_H        EQU     9
MEDIUM_SPD      EQU     2
MEDIUM_CLR      EQU     $00008000

;large fish properties (spotty)
LARGE_W         EQU     24
LARGE_H         EQU     13
LARGE_SPD       EQU     1
LARGE_CLR       EQU     $000000FF

;crab properties
CRAB_W          EQU     24
CRAB_H          EQU     32
CRAB_SPD        EQU     1
CRAB_CLR        EQU     $000080FF       ;orang

;angelfish properties
ANGEL_W         EQU     45
ANGEL_H         EQU     28
ANGEL_SPD       EQU     2
ANGEL_CLR       EQU     $00FFFF00       ;cyan

;shark properties
SHARK_W         EQU     70
SHARK_H         EQU     20
SHARK_SPD       EQU     3
SHARK_CLR       EQU     $00505050       ;dark grey

SARDINE_YMIN    EQU     80          
SARDINE_YMAX    EQU     420         
CLOWN_YMIN      EQU     150         
CLOWN_YMAX      EQU     430         
SPOTTY_YMIN     EQU     300         
SPOTTY_YMAX     EQU     620         
CRAB_YMIN       EQU     620         
CRAB_YMAX       EQU     700         
ANGEL_YMIN      EQU     350         
ANGEL_YMAX      EQU     620         
SHARK_YMIN      EQU     250         
SHARK_YMAX      EQU     410         

;points per fish type
SMALL_PTS       EQU     10
MEDIUM_PTS      EQU     25
LARGE_PTS       EQU     50
CRAB_PTS        EQU     75
ANGEL_PTS       EQU     100
SHARK_PTS       EQU     200

;min spawn window
MIN_SPAWN_WINDOW   EQU 80

;how close a fish needs to be before it reacts to the player (px)
REACT_DIST          EQU     65

;growth thresholds in score points
GROW_THRESH_1   EQU     30    ; 10 fishes was too much so
GROW_THRESH_2   EQU     125   ; 300 points was reachable by me just before the tide was starting to move so it was change to be more dynamic
GROW_THRESH_3   EQU     550  ; at this point you have 3 times of fish to eat and dodge the bigger fishes so this part will be engaging and can be a bit longer
GROW_THRESH_4   EQU     1000  ; a bit crabs      
GROW_THRESH_5   EQU     1500 
GROW_THRESH_6   EQU     2500 ;====================

;player sizes per growth stage, MOVE TO PLAYER
PLYR_W_SM       EQU     12
PLYR_H_SM       EQU     7
PLYR_W_MD       EQU     16
PLYR_H_MD       EQU     10
PLYR_W_LG       EQU     31
PLYR_H_LG       EQU     13
PLYR_W_XL       EQU     33
PLYR_H_XL       EQU     15
PLYR_W_XXL      EQU     38
PLYR_H_XXL      EQU     17
PLYR_W_MAX      EQU     45
PLYR_H_MAX      EQU     20
PLYR_W_SIKE     EQU     70		; your amazing artist/designer increased the scope again :)
PLYR_H_SIKE     EQU     22

;max range of spawning X outside of the screen, so there are no groups of fish
MAX_SPAWN_X     EQU     500

;lookup table for fish properties
;20 bytes per type: W, H, Speed, Y_MIN, Y_MAX
;access: base + (type * 20) + offset
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


;get properties for fish type in D5
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
    ADD.L   #MAX_SPAWN_X, D1
    MOVEM.L D5-D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D5-D7/A0-A2/A4
    MOVE.L  D3, (A0)+
    BRA     INIT_SPAWN_Y

INIT_SPAWN_LEFT:
    ;moving right -> spawn off left side
    MOVE.L  #0, D0
    MOVE.L  #MAX_SPAWN_X, D1
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
    MOVEM.L D1-D7/A0-A5, -(SP)
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
    BRA     APPLY_FISH_AI

CHECK_LEFT_EDGE:
    MOVE.L  PROP_W(A3), D4
    NEG.L   D4
    CMP.L   D4, D3
    BLE     RESET_LEFT_MOVER
    MOVE.L  D3, (A0)
    BRA     APPLY_FISH_AI

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
    ADD.L   #MAX_SPAWN_X, D1
    MOVEM.L D7/A0-A2/A4, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D7/A0-A2/A4
    MOVE.L  D3, (A0)
    BRA     RESET_ENEMY_Y

RESPAWN_OFF_LEFT:
    ;new direction is right, spawn off left side
    MOVE.L  #0, D0
    MOVE.L  #MAX_SPAWN_X, D1
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

*-----------------------------------------------------------
* AI: bigger fish chase, smaller fish flee, only when close
*-----------------------------------------------------------
APPLY_FISH_AI:
    ;check X distance to player
    MOVE.L  (A0), D1
    SUB.L   PLAYER_X, D1
    TST.L   D1
    BPL     .AI_DX_POS
    NEG.L   D1
.AI_DX_POS:
    CMP.L   #REACT_DIST, D1
    BGE     NEXT_ENEMY              ;too far horizontally, ignore

    ;check Y distance to player
    MOVE.L  (A1), D1
    SUB.L   PLAYER_Y, D1
    TST.L   D1
    BPL     .AI_DY_POS
    NEG.L   D1
.AI_DY_POS:
    CMP.L   #REACT_DIST, D1
    BGE     NEXT_ENEMY              ;too far vertically, ignore

    ;close enough - decide chase or flee
    MOVE.L  (A2), D1                ;fish type = size tier
    CMP.L   PLAYER_SIZE, D1
    BGT     .AI_CHASE               ;fish is bigger, hunt the player
    BRA     .AI_FLEE                ;fish is smaller or equal, run away

    ;--- CHASE: move toward the player ---
.AI_CHASE:
    ;nudge Y toward the player (1px/frame, subtle)
    MOVE.L  (A1), D1
    CMP.L   PLAYER_Y, D1
    BEQ     .AI_CHASE_X
    BGT     .AI_CHASE_UP
    ADD.L   #1, (A1)                ;fish above player, drift down
    BRA     .AI_CHASE_X
.AI_CHASE_UP:
    SUB.L   #1, (A1)                ;fish below player, drift up
.AI_CHASE_X:
    ;turn to face the player horizontally
    MOVE.L  (A0), D1
    CMP.L   PLAYER_X, D1
    BEQ     .AI_CHASE_DONE
    BGT     .AI_CHASE_LEFT          ;fish is right of player, face left
    MOVE.L  #1, (A4)                ;fish is left of player, face right
    BRA     .AI_CHASE_DONE
.AI_CHASE_LEFT:
    MOVE.L  #-1, (A4)               ;turn left toward player
.AI_CHASE_DONE:
    BRA     NEXT_ENEMY

    ;--- FLEE: move away from the player ---
.AI_FLEE:
    ;nudge Y away from the player (1px/frame)
    MOVE.L  (A1), D1
    CMP.L   PLAYER_Y, D1
    BEQ     .AI_FLEE_X
    BGT     .AI_FLEE_DOWN
    SUB.L   #1, (A1)                ;fish above player, swim further up
    BRA     .AI_FLEE_X
.AI_FLEE_DOWN:
    ADD.L   #1, (A1)                ;fish below player, swim further down
.AI_FLEE_X:
    ;turn away from the player horizontally
    MOVE.L  (A0), D1
    CMP.L   PLAYER_X, D1
    BEQ     .AI_FLEE_DONE
    BGT     .AI_FLEE_RIGHT          ;fish is right of player, flee right
    MOVE.L  #-1, (A4)               ;fish is left of player, flee left
    BRA     .AI_FLEE_DONE
.AI_FLEE_RIGHT:
    MOVE.L  #1, (A4)                ;turn right away from player
.AI_FLEE_DONE:
    BRA     NEXT_ENEMY

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

    MOVEM.L (SP)+, D1-D7/A0-A5
    RTS

*-----------------------------------------------------------
* Subroutine    : DRAW_ALL_ENEMIES
* Description   : draw enemies
*-----------------------------------------------------------
DRAW_ALL_ENEMIES:
    MOVEM.L D1-D7/A0-A4, -(SP)
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
    MOVE.L  (A4), D3
    MOVEM.L D7/A0-A4, -(SP)
    JSR     DRAW_SPOTTY
    MOVEM.L (SP)+, D7/A0-A4
    BRA     DONE_ENEMY_DRAW

DO_DRAW_CRAB:
    MOVE.L  (A4), D3
    MOVEM.L D7/A0-A4, -(SP)
    JSR     DRAW_CRAB
    MOVEM.L (SP)+, D7/A0-A4
    BRA     DONE_ENEMY_DRAW

DO_DRAW_ANGEL:
	MOVE.L  (A4), D3
    MOVEM.L D7/A0-A4, -(SP)
    JSR     DRAW_ANGELFISH
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

    MOVEM.L (SP)+, D1-D7/A0-A4
    RTS


*-----------------------------------------------------------
* Enemy Fish Drawing Routines
* Input: D1 = baseX (enemy X), D2 = baseY (enemy Y)
*-----------------------------------------------------------



*-----------------------------------------------------------
* Subroutine    : CHECK_ALL_COLLISIONS
* Description   : checking colls
*-----------------------------------------------------------
CHECK_ALL_COLLISIONS:
    MOVEM.L D1-D7/A0-A5, -(SP)
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
    BLE     .PLAYER_EATS
    ;fish is bigger -> player dies. Restore stack before jumping.
    MOVEM.L (SP)+, D1-D7/A0-A5
    JMP     PLAYER_DIED
.PLAYER_EATS:

    ;player eats this fish
    MOVE.L  #1, COLLISION_FLAG
    ;remember where this fish was (for the crumbs)
    MOVE.L  (A0), LFTOVR_SPAWN_X
    MOVE.L  (A1), LFTOVR_SPAWN_Y
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
    MOVEM.L D7/A0-A2, -(SP)
    JSR     TRIGGER_ACH_SHARK       ;first shark eaten = achievement
    MOVEM.L (SP)+, D7/A0-A2
    JSR     STOP_TIDE_SOUND             ;in case player dies during tide moving
    ;restore outer frame before jumping to win screen
    MOVEM.L (SP)+, D1-D7/A0-A5
    JMP     WIN_START
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
    MOVEM.L D7/A0-A2, -(SP)
    JSR     TRIGGER_ACH_CRAB        ;first crab eaten = achievement
    MOVEM.L (SP)+, D7/A0-A2
    BRA     ATE_FISH
ADD_AN_PTS:
    ADD.L   #ANGEL_PTS, PLAYER_SCORE

ATE_FISH:
    JSR     PLAY_EAT
    
    MOVE.L  #FLASH_BLINKS, FLASH_COUNT
    MOVE.L  #FLASH_DURATION, FLASH_TIMER
    MOVE.L  #1, FLASH_STATE
    
    ;--- track total fish eaten ---
    ADD.L   #1, ACH_FISH_COUNT
    MOVEM.L D7/A0-A2, -(SP)
    JSR     TRIGGER_ACH_FIRST_FISH  ;first fish of any kind
    JSR     TRIGGER_ACH_100FISH     ;100 fishes milestone
    JSR     SPAWN_LEFTOVERS         ;spit out some food crumbs
    JSR     SPAWN_PELICAN           ;chance for the pelican to show up
    JSR     CHECK_GROWTH
    MOVEM.L (SP)+, D7/A0-A2

NO_COLL_THIS:
    ADDA.L  #4, A0
    ADDA.L  #4, A1
    ADDA.L  #4, A2
    DBRA    D7, CHECK_COLL_LOOP

    CMP.L   #0, COLLISION_FLAG
    BNE     COLL_CHECK_DONE

COLL_CHECK_DONE:
    MOVEM.L (SP)+, D1-D7/A0-A5
    RTS

;grow player when they hit score thresholds
CHECK_GROWTH:
    MOVEM.L D0, -(SP)
    MOVE.L  PLAYER_SCORE, D0

    ;check from highest threshold down
    CMP.L   #GROW_THRESH_6, D0
    BGE     TRY_GROW_6
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
    BRA     GROWTH_DONE

TRY_GROW_1:
    CMP.L   #1, PLAYER_SIZE
    BGE     GROWTH_DONE
    MOVE.L  #1, PLAYER_SIZE
    JSR     PLAY_GROW
    MOVE.L  #PLYR_W_MD, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_MD, PLYR_H_CURRENT
    BRA     GROWTH_DONE

TRY_GROW_2:
    CMP.L   #2, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #2, PLAYER_SIZE
    MOVE.L  #PLYR_W_LG, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_LG, PLYR_H_CURRENT
    BRA     GROWTH_DONE

TRY_GROW_3:
    CMP.L   #3, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #3, PLAYER_SIZE
    MOVE.L  #PLYR_W_XL, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_XL, PLYR_H_CURRENT
    BRA     GROWTH_DONE

TRY_GROW_4:
    CMP.L   #4, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #4, PLAYER_SIZE
    MOVE.L  #PLYR_W_XXL, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_XXL, PLYR_H_CURRENT
    BRA     GROWTH_DONE

TRY_GROW_5:
    CMP.L   #5, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #5, PLAYER_SIZE
    MOVE.L  #PLYR_W_MAX, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_MAX, PLYR_H_CURRENT

TRY_GROW_6:
    CMP.L   #6, PLAYER_SIZE
    BGE     GROWTH_DONE
    JSR     PLAY_GROW
    MOVE.L  #6, PLAYER_SIZE
    MOVE.L  #PLYR_W_SIKE, PLYR_W_CURRENT
    MOVE.L  #PLYR_H_SIKE, PLYR_H_CURRENT

GROWTH_DONE:
    MOVEM.L (SP)+, D0
    RTS


*-----------------------------------------------------------
* Subroutine    : PLAYER_DIED
* Description   : end
*-----------------------------------------------------------
PLAYER_DIED:
    ;MOVE.L  #0, PLAYER_SCORE
    JSR     PLAY_DEATH
    JSR     STOP_TIDE_SOUND             ;in case player dies during tide moving
    JMP     END_START     
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
    include "SBR_DRAW_CRAB.X68"
    include "SBR_DRAW_SPOTTY.X68"
   	include "SBR_DRAW_ANGELFISH.X68"




*~Font name~Courier New~
*~Font size~10~
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
