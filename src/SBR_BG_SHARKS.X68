**-----------------------------------------------------------
* Title      : SBR_BG_SHARKS
* Description: Background decorative sardine silhouettes
*              3 dark sardine shadows swim between the water
*              layer and the fish/player drawing layers.
*              Uses the sardine drawing proportions but colored
*              as a darker version of the water color.
*              Only runs during main gameplay.
* Subroutines:
*   INIT_BG_SHARKS      ; Set up 3 background sardines
*   UPDATE_BG_SHARKS    ; Move them each frame
*   DRAW_BG_SHARKS      ; Draw all 3 silhouettes
*-----------------------------------------------------------

NUM_BG_SHARKS   EQU     5
BG_SHARK_SPD    EQU     1           ; slow background pace (1px per frame)
BG_SHARK_W      EQU     20          ; full sardine width for off-screen wrapping
BG_SHARK_CLR    EQU     $008B7E25   ; darker version of water ($00AE9E2E ~80%)

; Y range for background sharks (always underwater)
BG_SHARK_YMIN   EQU     200
BG_SHARK_YMAX   EQU     550

*-----------------------------------------------------------
* Subroutine    : INIT_BG_SHARKS
* Description   : Initialise 3 bg sharks at spread-out positions
*-----------------------------------------------------------
INIT_BG_SHARKS:
    MOVEM.L D0-D3/A0-A2, -(SP)

    LEA     BG_SHARK_X, A0
    LEA     BG_SHARK_Y, A1
    LEA     BG_SHARK_DIR, A2

    ; Shark 0: off-screen left, moving right
    MOVE.L  #-200, (A0)+
    MOVE.L  #1, (A2)+
    MOVE.L  #BG_SHARK_YMIN, D0
    MOVE.L  #BG_SHARK_YMAX, D1
    MOVEM.L A0-A2, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, A0-A2
    MOVE.L  D3, (A1)+

    ; Shark 1: mid-screen, moving left
    MOVE.L  #500, (A0)+
    MOVE.L  #-1, (A2)+
    MOVE.L  #BG_SHARK_YMIN, D0
    MOVE.L  #BG_SHARK_YMAX, D1
    MOVEM.L A0-A2, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, A0-A2
    MOVE.L  D3, (A1)+

    ; Shark 2: off-screen right, moving left
    MOVE.L  #1200, (A0)+
    MOVE.L  #-1, (A2)+
    MOVE.L  #BG_SHARK_YMIN, D0
    MOVE.L  #BG_SHARK_YMAX, D1
    MOVEM.L A0-A2, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, A0-A2
    MOVE.L  D3, (A1)+

    MOVEM.L (SP)+, D0-D3/A0-A2
    RTS

*-----------------------------------------------------------
* Subroutine    : UPDATE_BG_SHARKS
* Description   : Move bg sharks, wrap at screen edges,
*                 randomise Y on wrap, keep below water
*-----------------------------------------------------------
UPDATE_BG_SHARKS:
    MOVEM.L D0-D5/D7/A0-A2, -(SP)
    LEA     BG_SHARK_X, A0
    LEA     BG_SHARK_Y, A1
    LEA     BG_SHARK_DIR, A2
    MOVE.L  #NUM_BG_SHARKS-1, D7

.BG_MOVE_LOOP:
    ; X += direction * speed
    MOVE.L  (A2), D1            ; direction (-1 or 1)
    MOVE.L  #BG_SHARK_SPD, D2
    MULS    D1, D2              ; signed speed
    MOVE.L  (A0), D3            ; current X
    ADD.L   D2, D3              ; new X

    ; check which edge to test
    CMP.L   #-1, D1
    BEQ     .BG_CHECK_LEFT

    ; moving right -> check right edge
    CLR.L   D4
    MOVE.W  SCREEN_W, D4
    ADD.L   #50, D4
    CMP.L   D4, D3
    BGT     .BG_WRAP_TO_LEFT
    MOVE.L  D3, (A0)
    BRA     .BG_CLAMP_Y

.BG_CHECK_LEFT:
    ; moving left -> check left edge
    MOVE.L  #BG_SHARK_W, D4
    NEG.L   D4                  ; -114
    CMP.L   D4, D3
    BLT     .BG_WRAP_RIGHT
    MOVE.L  D3, (A0)
    BRA     .BG_CLAMP_Y

.BG_WRAP_TO_LEFT:
    ; spawn off left side
    MOVE.L  #BG_SHARK_W, D4
    NEG.L   D4
    MOVE.L  D4, (A0)
    BRA     .BG_NEW_Y

.BG_WRAP_RIGHT:
    ; spawn off right side
    CLR.L   D4
    MOVE.W  SCREEN_W, D4
    ADD.L   #50, D4
    MOVE.L  D4, (A0)

.BG_NEW_Y:
    ; randomise Y on wrap
    MOVE.L  #BG_SHARK_YMIN, D0
    MOVE.L  #BG_SHARK_YMAX, D1
    MOVEM.L D7/A0-A2, -(SP)
    JSR     RANDOM
    MOVEM.L (SP)+, D7/A0-A2
    MOVE.L  D3, (A1)

.BG_CLAMP_Y:
    ; keep bg sharks below the water surface
    MOVE.L  (A1), D3
    CMP.L   WTR_CURRENT_Y, D3
    BGE     .BG_Y_OK
    MOVE.L  WTR_CURRENT_Y, (A1)    ; push down to water level
.BG_Y_OK:

    ADDA.L  #4, A0
    ADDA.L  #4, A1
    ADDA.L  #4, A2
    DBRA    D7, .BG_MOVE_LOOP

    MOVEM.L (SP)+, D0-D5/D7/A0-A2
    RTS

*-----------------------------------------------------------
* Subroutine    : DRAW_BG_SHARKS
* Description   : Loop through 3 bg sharks and draw each
*-----------------------------------------------------------
DRAW_BG_SHARKS:
    MOVEM.L D1-D7/A0-A2, -(SP)
    LEA     BG_SHARK_X, A0
    LEA     BG_SHARK_Y, A1
    LEA     BG_SHARK_DIR, A2
    MOVE.L  #NUM_BG_SHARKS-1, D7

.BG_DRAW_LOOP:
    ; visibility check
    MOVE.L  (A0), D1
    MOVE.L  #BG_SHARK_W, D2
    NEG.L   D2
    CMP.L   D2, D1
    BLT     .BG_SKIP_DRAW           ; fully off left

    CLR.L   D3
    MOVE.W  SCREEN_W, D3
    ADD.L   #BG_SHARK_W, D3
    CMP.L   D3, D1
    BGT     .BG_SKIP_DRAW           ; fully off right

    ; draw this shark silhouette
    MOVE.L  (A0), D1                ; X
    MOVE.L  (A1), D2                ; Y
    MOVE.L  (A2), D3                ; direction
    MOVEM.L D7/A0-A2, -(SP)
    JSR     DRAW_BG_SHARK_SPRITE
    MOVEM.L (SP)+, D7/A0-A2

.BG_SKIP_DRAW:
    ADDA.L  #4, A0
    ADDA.L  #4, A1
    ADDA.L  #4, A2
    DBRA    D7, .BG_DRAW_LOOP

    MOVEM.L (SP)+, D1-D7/A0-A2
    RTS

*-----------------------------------------------------------
* Subroutine    : DRAW_BG_SHARK_SPRITE
* Description   : Draw one background sardine silhouette using
*                 every rectangle from SBR_DRAW_SARDINE but all
*                 painted in a single darker water color.
* Input: D1=X, D2=Y, D3=direction (-1 left, 1 right)
*-----------------------------------------------------------
DRAW_BG_SHARK_SPRITE:
    MOVE.L  D1,          POS_X
    MOVE.L  D2,          POS_Y
    MOVE.L  D3,          FISH_DIRECTION_X

    MOVEM.L D0-D7/A0-A4, -(A7)

    MOVE.L  #10,               D7       ; Sprite width for FLIP_X (sardine)

    ; Set single silhouette colour (darker water)
    MOVE.L  #BG_SHARK_CLR,     D1
    MOVE.B  #80,               D0       ; Pen colour
    TRAP    #15
    MOVE.L  #BG_SHARK_CLR,     D1
    MOVE.B  #81,               D0       ; Fill colour
    TRAP    #15

    ; Set Pen Width
    MOVE.L  #01,    D1
    MOVE.B  #93,    D0
    TRAP    #15

    ; Check direction
    TST.L   FISH_DIRECTION_X
    BLT     BG_SHARK_DRAW_LEFT
    BGT     BG_SHARK_DRAW_RIGHT

*-----------------------------------------------------------
* Left-Facing (no flip) - sardine silhouette rects
*-----------------------------------------------------------
BG_SHARK_DRAW_LEFT:

* --- Lower fin tip ---
    MOVE.L  POS_X,   D1
    ADD.L   #03,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #05,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #05,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #09,        D4
    MOVE.B  #87,        D0
    TRAP    #15

* --- Upper fin tip ---
    MOVE.L  POS_X,   D1
    ADD.L   #03,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #00,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #07,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #-02,        D4
    MOVE.B  #87,        D0
    TRAP    #15

* --- Tail ---
    MOVE.L  POS_X,   D1
    ADD.L   #11,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #00,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #15,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #06,        D4
    MOVE.B  #87,        D0
    TRAP    #15

* --- Body middle ---
    MOVE.L  POS_X,   D1
    ADD.L   #00,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #01,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #11,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #05,        D4
    MOVE.B  #87,        D0
    TRAP    #15

* --- Mouth tip ---
    MOVE.L  POS_X,   D1
    ADD.L   #-02,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #02,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #00,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #04,        D4
    MOVE.B  #87,        D0
    TRAP    #15

* --- Body top ---
    MOVE.L  POS_X,   D1
    ADD.L   #01,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #00,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #08,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #01,        D4
    MOVE.B  #87,        D0
    TRAP    #15

* --- Main body ---
    MOVE.L  POS_X,   D1
    ADD.L   #00,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #04,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #08,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #06,        D4
    MOVE.B  #87,        D0
    TRAP    #15

* --- Eye (same color, blends in) ---
    MOVE.L  POS_X,   D1
    ADD.L   #01,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #03,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #02,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #04,        D4
    MOVE.B  #87,        D0
    TRAP    #15

    MOVEM.L (A7)+, D0-D7/A0-A4
    RTS

*-----------------------------------------------------------
* Right-Facing (flipped) - sardine silhouette rects
*-----------------------------------------------------------
BG_SHARK_DRAW_RIGHT:

* --- Lower fin tip (flipped) ---
    MOVE.L  POS_X,   D1
    ADD.L   #03,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #05,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #05,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #09,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

* --- Upper fin tip (flipped) ---
    MOVE.L  POS_X,   D1
    ADD.L   #03,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #00,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #07,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #-02,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

* --- Tail (flipped) ---
    MOVE.L  POS_X,   D1
    ADD.L   #11,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #00,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #15,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #06,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

* --- Body middle (flipped) ---
    MOVE.L  POS_X,   D1
    ADD.L   #00,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #01,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #11,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #05,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

* --- Mouth tip (flipped) ---
    MOVE.L  POS_X,   D1
    ADD.L   #-02,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #02,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #00,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #04,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

* --- Body top (flipped) ---
    MOVE.L  POS_X,   D1
    ADD.L   #01,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #00,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #08,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #01,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

* --- Main body (flipped) ---
    MOVE.L  POS_X,   D1
    ADD.L   #00,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #04,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #08,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #06,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

* --- Eye (flipped, same color) ---
    MOVE.L  POS_X,   D1
    ADD.L   #01,        D1
    MOVE.L  POS_Y,   D2
    ADD.L   #03,        D2
    MOVE.L  POS_X,   D3
    ADD.L   #02,        D3
    MOVE.L  POS_Y,   D4
    ADD.L   #04,        D4
    JSR     FLIP_X
    MOVE.B  #87,        D0
    TRAP    #15

    MOVEM.L (A7)+, D0-D7/A0-A4
    RTS

*-----------------------------------------------------------
* Section       : Data
* Description   : Background sardine position tables
*-----------------------------------------------------------
BG_SHARK_X      DS.L    NUM_BG_SHARKS   ; X positions
BG_SHARK_Y      DS.L    NUM_BG_SHARKS   ; Y positions
BG_SHARK_DIR    DS.L    NUM_BG_SHARKS   ; directions (-1 or 1)




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
