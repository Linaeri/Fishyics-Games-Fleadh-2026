*-----------------------------------------------------------
* Title      : SBR_ACHIEVEMENTS
* Description: achievement popup system, shows a banner when 
*              you do something cool. each one only triggers once
*
* Achievement list:
*   0 - "Sorry Nemo!"                  eat a clownfish
*   1 - "Beak-fast Served!"            run into the pelican
*   2 - "First Catch!"                 eat your first fish ever
*   3 - "Poor Crusty"                  eat a crab
*   4 - "Air Force"                    eat a pelican
*   5 - "Is there no one else?"        eat a shark
*   6 - "Born to swim, live to fly!"   1 minute in the air total
*   7 - "Oh my, Whale!"                eat 100 fish
*   8 - "Touch The Moon"               touch the moon
*   9 - "Over Easy!"                   jump over the pelican
*-----------------------------------------------------------

;achievement display stuff
ACH_DISPLAY_TIME    EQU     3000        ;ms the banner stays on screen
ACH_BOX_W           EQU     260         ;banner width
ACH_BOX_H           EQU     52          ;banner height
ACH_BOX_MARGIN      EQU     12          ;gap from screen edge
ACH_ICON_SIZE       EQU     28          ;icon area

;colours - BGR format because easy68k is weird like that
ACH_BG_CLR          EQU     $00402010   ;dark brown bg
ACH_BORDER_CLR      EQU     $0000CCFF   ;gold
ACH_TITLE_CLR       EQU     $0000CCFF   ;gold
ACH_TEXT_CLR        EQU     $00FFFFFF   ;white

;icon colours
ACH_ICON_NEMO_BODY  EQU     $000060F0   ;orange
ACH_ICON_NEMO_STRIPE EQU   $00FFFFFF   ;white stripe

;locked achievement colours (greyed out)
ACH_LOCKED_BG       EQU     $00404040
ACH_LOCKED_BORDER   EQU     $00808080

;trophy wall layout - 3 columns of boxes
ACH_WALL_GRID_X0    EQU     22
ACH_WALL_GRID_X1    EQU     302
ACH_WALL_GRID_X2    EQU     582
ACH_WALL_GRID_Y0    EQU     100
ACH_WALL_GRID_Y1    EQU     170
ACH_WALL_GRID_Y2    EQU     240
ACH_WALL_GRID_Y3    EQU     310

;the exit button hitbox on the trophy wall
WALL_EXIT_X_L       EQU     460
WALL_EXIT_X_R       EQU     565
WALL_EXIT_Y_T       EQU     430
WALL_EXIT_Y_B       EQU     450

PLAYER_Y_WALL_INIT  EQU     300


*-----------------------------------------------------------
* Subroutine    : INIT_ACHIEVEMENTS
* Description   : clear everything and load saves
*-----------------------------------------------------------
INIT_ACHIEVEMENTS:
    MOVE.L  #0, ACH_UNLOCKED_0     ;nemo not yet earned
    MOVE.L  #0, ACH_UNLOCKED_1     ;pelican not yet earned
    MOVE.L  #0, ACH_UNLOCKED_2     ;first fish not yet earned
    MOVE.L  #0, ACH_UNLOCKED_3     ;crab not yet earned
    MOVE.L  #0, ACH_UNLOCKED_4     ;air force not yet earned
    MOVE.L  #0, ACH_UNLOCKED_5     ;shark not yet earned
    MOVE.L  #0, ACH_UNLOCKED_6     ;1 min air not yet earned
    MOVE.L  #0, ACH_UNLOCKED_7     ;100 fishes not yet earned
    MOVE.L  #0, ACH_UNLOCKED_8     ;touch the moon not yet earned
    MOVE.L  #0, ACH_UNLOCKED_9     ;pelican jump not yet earned
    MOVE.L  #0, ACH_SHOWING        ;nothing on screen
    MOVE.L  #0, ACH_TIMER          ;timer clear
    MOVE.L  #0, ACH_CURRENT_ID     ;no current achievement
    MOVE.L  #0, ACH_DRAW_LOCKED    ;normal colours by default
    MOVE.L  #0, ACH_WALL_FROM     ;go back to gameover screen by default
    MOVE.L  #0, ACH_FISH_COUNT     ;total fishes eaten this run
    MOVE.L  #0, ACH_AIR_TIME       ;total ms spent in the air
    BSR     LOAD_ACHIEVEMENTS       ;load saved flags (overwrites zeros)
    RTS


; ---- TRIGGER ROUTINES ----
; each one checks if already earned, if not it marks it,
; shows the popup, plays the sound and saves to file.
; they all work the same way just with different IDs

;ate a clownfish
TRIGGER_ACH_NEMO:
    MOVEM.L D0-D1, -(SP)
    ;already earned? skip
    CMP.L   #1, ACH_UNLOCKED_0
    BEQ     TA_N_DN

    ;mark earned
    MOVE.L  #1, ACH_UNLOCKED_0

    ;start showing the popup
    MOVE.L  #0, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING

    ;play the achievement jingle
    JSR     PLAY_ACH_SND

    ;save to file
    BSR     SAVE_ACHIEVEMENTS

TA_N_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;ran into the pelican (either we ate it or it ate us)
TRIGGER_ACH_PELICAN:
    MOVEM.L D0-D1, -(SP)
    ;already earned? skip
    CMP.L   #1, ACH_UNLOCKED_1
    BEQ     TA_P_DN

    ;mark earned
    MOVE.L  #1, ACH_UNLOCKED_1

    ;show popup
    MOVE.L  #1, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING

    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS

TA_P_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;ate any fish for the first time
TRIGGER_ACH_FIRST_FISH:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_2
    BEQ     TAFF_DN
    MOVE.L  #1, ACH_UNLOCKED_2
    MOVE.L  #2, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TAFF_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;ate a crab
TRIGGER_ACH_CRAB:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_3
    BEQ     TACRB_DN
    MOVE.L  #1, ACH_UNLOCKED_3
    MOVE.L  #3, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TACRB_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;ate a pelican specifically
TRIGGER_ACH_AIRFORCE:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_4
    BEQ     TAAF_DN
    MOVE.L  #1, ACH_UNLOCKED_4
    MOVE.L  #4, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TAAF_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;ate a shark (hardest one to get since you need to be max size)
TRIGGER_ACH_SHARK:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_5
    BEQ     TASHK_DN
    MOVE.L  #1, ACH_UNLOCKED_5
    MOVE.L  #5, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TASHK_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;spent 60 seconds total in the air (cumulative)
TRIGGER_ACH_AIRTIME:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_6
    BEQ     TAAT_DN
    MOVE.L  #1, ACH_UNLOCKED_6
    MOVE.L  #6, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TAAT_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;ate 100 fish total, checked after every eat
TRIGGER_ACH_100FISH:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_7
    BEQ     TA100_DN
    CMP.L   #100, ACH_FISH_COUNT
    BLT     TA100_DN
    MOVE.L  #1, ACH_UNLOCKED_7
    MOVE.L  #7, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TA100_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;touched the moon
TRIGGER_ACH_MOON:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_8
    BEQ     TAMN_DN
    MOVE.L  #1, ACH_UNLOCKED_8
    MOVE.L  #8, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TAMN_DN:
    MOVEM.L (SP)+, D0-D1
    RTS

;jumped over the pelican while it was flying past
TRIGGER_ACH_PELJMP:
    MOVEM.L D0-D1, -(SP)
    CMP.L   #1, ACH_UNLOCKED_9
    BEQ     TAPJ_DN
    MOVE.L  #1, ACH_UNLOCKED_9
    MOVE.L  #9, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING
    JSR     PLAY_ACH_SND
    BSR     SAVE_ACHIEVEMENTS
TAPJ_DN:
    MOVEM.L (SP)+, D0-D1
    RTS


;tracks how long the player has been in the air total
;once they hit 60 seconds it triggers the airtime achievement
UPDATE_AIR_TIME:
    MOVEM.L D0, -(SP)
    ;already earned? skip all work
    CMP.L   #1, ACH_UNLOCKED_6
    BEQ     UAT_DN
    ;only count when player is in the air
    TST.L   PLYR_IN_WATER_NOW
    BNE     UAT_DN                  ;underwater, skip
    ;add delta time to air accumulator
    MOVE.L  DELTA_TIME, D0
    ADD.L   D0, ACH_AIR_TIME
    ;check if 60 seconds (60000 ms) reached
    CMP.L   #60000, ACH_AIR_TIME
    BLT     UAT_DN
    JSR     TRIGGER_ACH_AIRTIME
UAT_DN:
    MOVEM.L (SP)+, D0
    RTS


;counts down the popup timer, hides the banner when it runs out
UPDATE_ACHIEVEMENT:
    MOVEM.L D0, -(SP)
    CMP.L   #1, ACH_SHOWING
    BNE     UA_DN

    ;subtract delta time
    MOVE.L  DELTA_TIME, D0
    SUB.L   D0, ACH_TIMER

    ;timer expired?
    CMP.L   #0, ACH_TIMER
    BGT     UA_DN

    ;hide the banner
    MOVE.L  #0, ACH_SHOWING
    MOVE.L  #0, ACH_TIMER

UA_DN:
    MOVEM.L (SP)+, D0
    RTS


;draw the achievement popup if one is showing
DRAW_ACHIEVEMENT:
    MOVEM.L D0-D7/A1, -(SP)
    CMP.L   #1, ACH_SHOWING
    BNE     DA_SKP

    ;--- draw in top-right corner ---
    CLR.L   D1
    MOVE.W  SCREEN_W, D1
    SUB.L   #ACH_BOX_W, D1
    SUB.L   #ACH_BOX_MARGIN, D1
    MOVE.L  D1, ACH_DRAW_X
    MOVE.L  #ACH_BOX_MARGIN, ACH_DRAW_Y

    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER

DA_SKP:
    MOVEM.L (SP)+, D0-D7/A1
    RTS


;draws one banner box at ACH_DRAW_X/Y
;used for both the in-game popup and the trophy wall
DRAW_ACH_BANNER:
    ;grey if locked, gold if earned
    TST.L   ACH_DRAW_LOCKED
    BNE     DAB_GRY
    MOVE.L  #ACH_BG_CLR, ACH_CUR_BG
    MOVE.L  #ACH_BORDER_CLR, ACH_CUR_BORDER
    BRA     DAB_SET
DAB_GRY:
    MOVE.L  #ACH_LOCKED_BG, ACH_CUR_BG
    MOVE.L  #ACH_LOCKED_BORDER, ACH_CUR_BORDER
DAB_SET:
    ;draw the box background
    MOVE.L  ACH_CUR_BG, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  ACH_CUR_BG, D1
    MOVE.B  #81, D0
    TRAP    #15

    MOVE.L  ACH_DRAW_X, D1
    MOVE.L  ACH_DRAW_Y, D2
    MOVE.L  D1, D3
    ADD.L   #ACH_BOX_W, D3
    MOVE.L  D2, D4
    ADD.L   #ACH_BOX_H, D4
    MOVE.B  #87, D0                 ;filled rect
    TRAP    #15

    ;border
    MOVE.L  ACH_CUR_BORDER, D1
    MOVE.B  #80, D0
    TRAP    #15

    ;set pen width 2
    MOVE.L  #2, D1
    MOVE.B  #93, D0
    TRAP    #15

    ;top line
    MOVE.L  ACH_DRAW_X, D1
    MOVE.L  ACH_DRAW_Y, D2
    MOVE.L  D1, D3
    ADD.L   #ACH_BOX_W, D3
    MOVE.L  D2, D4
    MOVE.B  #84, D0
    TRAP    #15

    ;bottom line
    MOVE.L  ACH_DRAW_X, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #ACH_BOX_H, D2
    MOVE.L  D1, D3
    ADD.L   #ACH_BOX_W, D3
    MOVE.L  D2, D4
    MOVE.B  #84, D0
    TRAP    #15

    ;left line
    MOVE.L  ACH_DRAW_X, D1
    MOVE.L  ACH_DRAW_Y, D2
    MOVE.L  D1, D3
    MOVE.L  D2, D4
    ADD.L   #ACH_BOX_H, D4
    MOVE.B  #84, D0
    TRAP    #15

    ;right line
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #ACH_BOX_W, D1
    MOVE.L  ACH_DRAW_Y, D2
    MOVE.L  D1, D3
    MOVE.L  D2, D4
    ADD.L   #ACH_BOX_H, D4
    MOVE.B  #84, D0
    TRAP    #15

    ;reset pen width
    MOVE.L  #1, D1
    MOVE.B  #93, D0
    TRAP    #15

    ;no icon for locked ones
    TST.L   ACH_DRAW_LOCKED
    BNE     DA_AFIC

    ;draw the right icon for this achievement
    MOVE.L  ACH_CURRENT_ID, D0
    CMP.L   #0, D0
    BEQ     DA_I_NM
    CMP.L   #1, D0
    BEQ     DA_I_PL
    CMP.L   #2, D0
    BEQ     DA_I_FF
    CMP.L   #3, D0
    BEQ     DA_I_CR
    CMP.L   #4, D0
    BEQ     DA_I_AF
    CMP.L   #5, D0
    BEQ     DA_I_SK
    CMP.L   #6, D0
    BEQ     DA_I_AT
    CMP.L   #7, D0
    BEQ     DA_I_HF
    CMP.L   #8, D0
    BEQ     DA_I_MN
    CMP.L   #9, D0
    BEQ     DA_I_PJ
    BRA     DA_AFIC

;--- NEMO ICON: clownfish from the game facing left ---
DA_I_NM:
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #10, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #22, D2
    MOVE.L  #-1, D3
    JSR     DRAW_CLOWNFISH
    BRA     DA_AFIC

;--- PELICAN ICON: small rectangle in pelican colour ---
;    used for pelican encounter, air force, 1min air, and jump over
DA_I_PL:
DA_I_AF:
DA_I_AT:
DA_I_PJ:
    MOVE.L  #$00446688, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00446688, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #5, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #20, D2
    MOVE.L  D1, D3
    ADD.L   #30, D3
    MOVE.L  D2, D4
    ADD.L   #15, D4
    MOVE.B  #87, D0
    TRAP    #15
    BRA     DA_AFIC

;--- FIRST FISH ICON: sardine facing left ---
DA_I_FF:
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #10, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #24, D2
    MOVE.L  #-1, D3
    JSR     DRAW_SARDINE
    BRA     DA_AFIC

;--- CRAB ICON: crab facing left ---
DA_I_CR:
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #5, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #20, D2
    MOVE.L  #-1, D3
    JSR     DRAW_CRAB
    BRA     DA_AFIC

;--- SHARK ICON: shark facing left ---
DA_I_SK:
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #2, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #18, D2
    MOVE.L  #-1, D3
    JSR     DRAW_SHARK
    BRA     DA_AFIC

;--- 100 FISH ICON: 3 sardines stacked bottom to top ---
DA_I_HF:
    ;bottom sardine
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #10, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #34, D2
    MOVE.L  #-1, D3
    JSR     DRAW_SARDINE
    ;middle sardine
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #10, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #24, D2
    MOVE.L  #-1, D3
    JSR     DRAW_SARDINE
    ;top sardine
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #10, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #14, D2
    MOVE.L  #-1, D3
    JSR     DRAW_SARDINE
    BRA     DA_AFIC

;--- MOON ICON: small circle in moon purple ---
DA_I_MN:
    MOVE.L  #MOON_PURPLE_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #MOON_PURPLE_CLR, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #4, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #16, D2
    MOVE.L  D1, D3
    ADD.L   #20, D3
    MOVE.L  D2, D4
    ADD.L   #20, D4
    MOVE.B  #88, D0
    TRAP    #15
    BRA     DA_AFIC

DA_AFIC:
    ;reset colors for text so background matches the banner
    MOVE.L  ACH_CUR_BG, D1
    MOVE.B  #81, D0              ; fill = banner background
    TRAP    #15
    MOVE.L  #ACH_TITLE_CLR, D1
    MOVE.B  #80, D0              ; pen = gold
    TRAP    #15
    
    ;locked ones just show ???? instead
    TST.L   ACH_DRAW_LOCKED
    BNE     DA_LKTX
    ;draw "ACHIEVEMENT!" title
    ; each char is ~8px wide so divide X by 8 to get column

    ; offset past the icon so text doesnt overlap
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #42, D1
    DIVU    #8, D1                  ; pixel X -> column
    AND.L   #$FFFF, D1             ; keep quotient only
    LSL.W   #8, D1                 ; shift column into high byte

    ; row is just pixel Y / char height
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #8, D2                  ; nudge down a bit from top
    DIVU    #16, D2                 ; pixel Y -> row
    AND.L   #$FFFF, D2
    OR.W    D2, D1                  ; combine col | row
    MOVE.B  #TC_CURSR_P, D0
    TRAP    #15

    LEA     ACH_TITLE_MSG, A1
    MOVE.B  #13, D0                 ; print string, no line feed
    TRAP    #15

    ;caption text one line below
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #42, D1
    DIVU    #8, D1                  ; same column
    AND.L   #$FFFF, D1
    LSL.W   #8, D1

    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #24, D2                 ; one row lower than title
    DIVU    #16, D2
    AND.L   #$FFFF, D2
    OR.W    D2, D1
    MOVE.B  #TC_CURSR_P, D0
    TRAP    #15

    ; pick which caption to show
    MOVE.L  ACH_CURRENT_ID, D0
    CMP.L   #0, D0
    BEQ     DA_C_NM
    CMP.L   #1, D0
    BEQ     DA_C_PL
    CMP.L   #2, D0
    BEQ     DA_C_FF
    CMP.L   #3, D0
    BEQ     DA_C_CRB
    CMP.L   #4, D0
    BEQ     DA_C_AF
    CMP.L   #5, D0
    BEQ     DA_C_SHK
    CMP.L   #6, D0
    BEQ     DA_C_AT
    CMP.L   #7, D0
    BEQ     DA_C_100
    CMP.L   #8, D0
    BEQ     DA_C_MN
    CMP.L   #9, D0
    BEQ     DA_C_PJ
    BRA     DA_DN

DA_C_NM:
    LEA     ACH_NEMO_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_PL:
    LEA     ACH_PELICAN_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_FF:
    LEA     ACH_FIRSTFISH_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_CRB:
    LEA     ACH_CRAB_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_AF:
    LEA     ACH_AIRFORCE_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_SHK:
    LEA     ACH_SHARK_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_AT:
    LEA     ACH_AIRTIME_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_100:
    LEA     ACH_100FISH_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_MN:
    LEA     ACH_MOON_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_C_PJ:
    LEA     ACH_PELJMP_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     DA_DN

DA_LKTX:
    ;set colors for locked text
    MOVE.L  ACH_CUR_BG, D1
    MOVE.B  #81, D0              ; fill = grey background
    TRAP    #15
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0              ; pen = white
    TRAP    #15

    ;title line - just says LOCKED
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #42, D1
    DIVU    #8, D1
    AND.L   #$FFFF, D1
    LSL.W   #8, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #8, D2
    DIVU    #16, D2
    AND.L   #$FFFF, D2
    OR.W    D2, D1
    MOVE.B  #TC_CURSR_P, D0
    TRAP    #15
    LEA     ACH_LOCKED_TITLE, A1
    MOVE.B  #13, D0
    TRAP    #15

    ;caption - question marks so they know something goes here
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #42, D1
    DIVU    #8, D1
    AND.L   #$FFFF, D1
    LSL.W   #8, D1
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #24, D2
    DIVU    #16, D2
    AND.L   #$FFFF, D2
    OR.W    D2, D1
    MOVE.B  #TC_CURSR_P, D0
    TRAP    #15
    LEA     ACH_LOCKED_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15

DA_DN:
    RTS


;show earned achievements on the end/win screen
DRAW_END_ACHIEVEMENTS:
    MOVEM.L D0/D5, -(SP)
    ;check if any achievement is earned
    MOVE.L  ACH_UNLOCKED_0, D0
    OR.L    ACH_UNLOCKED_1, D0
    OR.L    ACH_UNLOCKED_2, D0
    OR.L    ACH_UNLOCKED_3, D0
    OR.L    ACH_UNLOCKED_4, D0
    OR.L    ACH_UNLOCKED_5, D0
    OR.L    ACH_UNLOCKED_6, D0
    OR.L    ACH_UNLOCKED_7, D0
    OR.L    ACH_UNLOCKED_8, D0
    OR.L    ACH_UNLOCKED_9, D0
    TST.L   D0
    BEQ     DEA_DN

    MOVE.L  #240, ACH_END_Y

    ;--- ID 0: Nemo ---
    CMP.L   #1, ACH_UNLOCKED_0
    BNE     DEA_SK0
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #0, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK0:

    ;--- ID 1: Pelican ---
    CMP.L   #1, ACH_UNLOCKED_1
    BNE     DEA_SK1
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #1, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK1:

    ;--- ID 2: First Fish ---
    CMP.L   #1, ACH_UNLOCKED_2
    BNE     DEA_SK_2
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #2, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_2:

    ;--- ID 3: Crab ---
    CMP.L   #1, ACH_UNLOCKED_3
    BNE     DEA_SK_3
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #3, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_3:

    ;--- ID 4: Air Force ---
    CMP.L   #1, ACH_UNLOCKED_4
    BNE     DEA_SK_4
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #4, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_4:

    ;--- ID 5: Shark ---
    CMP.L   #1, ACH_UNLOCKED_5
    BNE     DEA_SK_5
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #5, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_5:

    ;--- ID 6: Air Time ---
    CMP.L   #1, ACH_UNLOCKED_6
    BNE     DEA_SK_6
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #6, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_6:

    ;--- ID 7: 100 Fish ---
    CMP.L   #1, ACH_UNLOCKED_7
    BNE     DEA_SK_7
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #7, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_7:

    ;--- ID 8: Moon ---
    CMP.L   #1, ACH_UNLOCKED_8
    BNE     DEA_SK_8
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #8, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_8:

    ;--- ID 9: Pelican Jump ---
    CMP.L   #1, ACH_UNLOCKED_9
    BNE     DEA_SK_9
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    LSR.L   #1, D5
    MOVE.L  D5, ACH_DRAW_X
    MOVE.L  ACH_END_Y, D5
    MOVE.L  D5, ACH_DRAW_Y
    MOVE.L  #9, ACH_CURRENT_ID
    MOVE.L  #0, ACH_DRAW_LOCKED
    BSR     DRAW_ACH_BANNER
    ADD.L   #62, ACH_END_Y
DEA_SK_9:

DEA_DN:
    MOVEM.L (SP)+, D0/D5
    RTS


;write flags to ach.dat so they persist between runs
SAVE_ACHIEVEMENTS:
    MOVEM.L D0-D2/D5/A1, -(SP)

    MOVE.B  #50, D0
    TRAP    #15

    LEA     ACH_SAVE_FILE, A1
    MOVE.B  #52, D0
    TRAP    #15
    MOVE.L  D1, D5

    LEA     ACH_UNLOCKED_0, A1
    MOVE.L  D5, D1
    MOVE.L  #40, D2               ;10 flags * 4 bytes = 40
    MOVE.B  #54, D0
    TRAP    #15

    MOVE.L  D5, D1
    MOVE.B  #56, D0
    TRAP    #15

    MOVEM.L (SP)+, D0-D2/D5/A1
    RTS


;load flags from ach.dat, if file doesnt exist they just stay 0
LOAD_ACHIEVEMENTS:
    MOVEM.L D0-D2/D5/A1, -(SP)

    MOVE.B  #50, D0
    TRAP    #15

    LEA     ACH_SAVE_FILE, A1
    MOVE.L  #0, D1
    MOVE.B  #59, D0
    TRAP    #15
    TST.W   D0
    BNE     LA_NOFL

    LEA     ACH_SAVE_FILE, A1
    MOVE.B  #51, D0
    TRAP    #15
    MOVE.L  D1, D5

    LEA     ACH_UNLOCKED_0, A1
    MOVE.L  D5, D1
    MOVE.L  #40, D2               ;10 flags * 4 bytes = 40
    MOVE.B  #53, D0
    TRAP    #15

    MOVE.L  D5, D1
    MOVE.B  #56, D0
    TRAP    #15

LA_NOFL:
    MOVEM.L (SP)+, D0-D2/D5/A1
    RTS


;play the achievement sound effect
PLAY_ACH_SND:
    MOVEM.L D0-D1, -(SP)
    MOVE    #ACH_SND_IDX, D1        ; achievement sound index
    MOVE    #72,        D0          ; play sound
    TRAP    #15
    MOVEM.L (SP)+, D0-D1
    RTS

;load the wav into memory at startup
ACH_SND_LOAD:
    LEA     ACH_WAV,    A1          ; achievement wav path
    MOVE    #ACH_SND_IDX, D1        ; assign sound index
    MOVE    #71,        D0          ; load into memory
    TRAP    #15
    RTS



; ---- TROPHY WALL ----
; you can swim around and see all your achievements
; locked ones show as grey with ???? text
    DS.W    0

ACH_WALL_START:
    ;put the player somewhere sensible
    MOVE.L  #0, PLYR_VELOCITY_Y
    MOVE.L  #0, PLYR_VELOCITY_X
    MOVE.L  #IN_WTR_TRUE, PLYR_IN_WATER_NOW

    MOVE.L  #PLAYER_X_INIT, PLAYER_X
    MOVE.L  #PLAYER_X_INIT, D1
    ASL.L   #8, D1
    MOVE.L  D1, PLYR_X_SUB

    MOVE.L  #PLAYER_Y_WALL_INIT, PLAYER_Y
    MOVE.L  #PLAYER_Y_WALL_INIT, D1
    ASL.L   #8, D1
    MOVE.L  D1, PLYR_Y_SUB

ACH_WALL_LOOP:
    ;back buffer
    MOVE.B  #94, D0
    TRAP    #15

    ;wipe the screen
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$FF00, D1
    TRAP    #15

    JSR     DRAW_ACH_WALL
    JSR     WALL_EXIT_SIGN
    JSR     UPDATE_DELTA_TIME
    JSR     INPUT
    JSR     WASD_CHECK_INPUT
    JSR     PLAYER_MOVEMENT
    JSR     CLAMP_PLAYER
    JSR     UPDATE

    ;skeleton if you died, fish if you won
    TST.L   ACH_WALL_FROM
    BNE     AWL_DFS
    JSR     DRAW_SKELETON
    BRA     AWL_AFP
AWL_DFS:
    JSR     DRAW_PLAYER
AWL_AFP:

    JSR     CHECK_COLL_WALL_EXIT

    ;swap buffer
    MOVE.B  #94, D0
    TRAP    #15

    ;CPU relief
    MOVE.L  #1, D1
    MOVE.B  #23, D0
    TRAP    #15

    BRA     ACH_WALL_LOOP


;draw the 3x3 grid of achievement banners
DRAW_ACH_WALL:
    ;header text
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3802, D1              ;roughly centered at the top
    TRAP    #15
    LEA     ACH_WALL_TITLE, A1
    MOVE.B  #13, D0
    TRAP    #15

    ;--- ROW 0 ---
    ;ID 0 - nemo (left)
    MOVE.L  #ACH_WALL_GRID_X0, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y0, ACH_DRAW_Y
    MOVE.L  #0, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_0
    BNE     AW0_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW0_DRW
AW0_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW0_DRW:
    BSR     DRAW_ACH_BANNER

    ;ID 1 - pelican (middle)
    MOVE.L  #ACH_WALL_GRID_X1, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y0, ACH_DRAW_Y
    MOVE.L  #1, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_1
    BNE     AW1_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW1_DRW
AW1_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW1_DRW:
    BSR     DRAW_ACH_BANNER

    ;ID 2 - first fish (right)
    MOVE.L  #ACH_WALL_GRID_X2, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y0, ACH_DRAW_Y
    MOVE.L  #2, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_2
    BNE     AW_2_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_2_DRW
AW_2_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_2_DRW:
    BSR     DRAW_ACH_BANNER

    ;--- ROW 1 ---
    ;ID 3 - crab (left)
    MOVE.L  #ACH_WALL_GRID_X0, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y1, ACH_DRAW_Y
    MOVE.L  #3, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_3
    BNE     AW_3_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_3_DRW
AW_3_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_3_DRW:
    BSR     DRAW_ACH_BANNER

    ;ID 4 - air force (middle)
    MOVE.L  #ACH_WALL_GRID_X1, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y1, ACH_DRAW_Y
    MOVE.L  #4, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_4
    BNE     AW_4_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_4_DRW
AW_4_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_4_DRW:
    BSR     DRAW_ACH_BANNER

    ;ID 5 - shark (right)
    MOVE.L  #ACH_WALL_GRID_X2, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y1, ACH_DRAW_Y
    MOVE.L  #5, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_5
    BNE     AW_5_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_5_DRW
AW_5_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_5_DRW:
    BSR     DRAW_ACH_BANNER

    ;--- ROW 2 ---
    ;ID 6 - air time (left)
    MOVE.L  #ACH_WALL_GRID_X0, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y2, ACH_DRAW_Y
    MOVE.L  #6, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_6
    BNE     AW_6_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_6_DRW
AW_6_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_6_DRW:
    BSR     DRAW_ACH_BANNER

    ;ID 7 - 100 fish (middle)
    MOVE.L  #ACH_WALL_GRID_X1, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y2, ACH_DRAW_Y
    MOVE.L  #7, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_7
    BNE     AW_7_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_7_DRW
AW_7_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_7_DRW:
    BSR     DRAW_ACH_BANNER

    ;ID 8 - moon (right)
    MOVE.L  #ACH_WALL_GRID_X2, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y2, ACH_DRAW_Y
    MOVE.L  #8, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_8
    BNE     AW_8_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_8_DRW
AW_8_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_8_DRW:
    BSR     DRAW_ACH_BANNER

    ;--- ROW 3 ---
    ;ID 9 - pelican jump (left)
    MOVE.L  #ACH_WALL_GRID_X0, ACH_DRAW_X
    MOVE.L  #ACH_WALL_GRID_Y3, ACH_DRAW_Y
    MOVE.L  #9, ACH_CURRENT_ID
    TST.L   ACH_UNLOCKED_9
    BNE     AW_9_UNL
    MOVE.L  #1, ACH_DRAW_LOCKED
    BRA     AW_9_DRW
AW_9_UNL:
    MOVE.L  #0, ACH_DRAW_LOCKED
AW_9_DRW:
    BSR     DRAW_ACH_BANNER

    RTS


;"swim here to go back" text at the bottom
WALL_EXIT_SIGN:
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361B, D1              ;col 54, row 27
    TRAP    #15
    LEA     WALL_EXIT_LINE1, A1
    MOVE.B  #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361C, D1              ;col 54, row 28
    TRAP    #15
    LEA     WALL_EXIT_LINE2, A1
    MOVE.B  #13, D0
    TRAP    #15

    RTS


;collision check for the exit zone on the trophy wall
CHECK_COLL_WALL_EXIT:
    ;PLAYER_X < WALL_EXIT_X_R ?
    MOVE.L  PLAYER_X, D1
    CMP.L   #WALL_EXIT_X_R, D1
    BGE     NO_WALL_EXIT

    ;PLAYER_X + PLAYER_W > WALL_EXIT_X_L ?
    MOVE.L  PLAYER_X, D1
    ADD.L   PLYR_W_CURRENT, D1
    CMP.L   #WALL_EXIT_X_L, D1
    BLE     NO_WALL_EXIT

    ;PLAYER_Y < WALL_EXIT_Y_B ?
    MOVE.L  PLAYER_Y, D1
    CMP.L   #WALL_EXIT_Y_B, D1
    BGE     NO_WALL_EXIT

    ;PLAYER_Y + PLAYER_H > WALL_EXIT_Y_T ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    CMP.L   #WALL_EXIT_Y_T, D1
    BLE     NO_WALL_EXIT

    ;go back to wherever they came from
    TST.L   ACH_WALL_FROM
    BNE     WALL_RET_WIN
    JMP     END_START

WALL_RET_WIN:
    JMP     WIN_START

NO_WALL_EXIT:
    RTS


; ---- DATA ----
;flags: 1 = earned, 0 = not yet  (these have to stay next to each other for save/load)
ACH_UNLOCKED_0  DS.L    1           ;nemo achievement
ACH_UNLOCKED_1  DS.L    1           ;pelican achievement
ACH_UNLOCKED_2  DS.L    1           ;first fish achievement
ACH_UNLOCKED_3  DS.L    1           ;crab achievement
ACH_UNLOCKED_4  DS.L    1           ;air force achievement
ACH_UNLOCKED_5  DS.L    1           ;shark achievement
ACH_UNLOCKED_6  DS.L    1           ;1 minute in air achievement
ACH_UNLOCKED_7  DS.L    1           ;100 fishes achievement
ACH_UNLOCKED_8  DS.L    1           ;touch the moon achievement
ACH_UNLOCKED_9  DS.L    1           ;jump over pelican achievement

;tracking counters (not saved to file)
ACH_FISH_COUNT  DS.L    1           ;total fishes eaten this run
ACH_AIR_TIME    DS.L    1           ;total ms spent in the air

;display state
ACH_SHOWING     DS.L    1           ;1 = banner visible
ACH_TIMER       DS.L    1           ;ms remaining
ACH_CURRENT_ID  DS.L    1           ;which achievement is showing

;temp draw coords
ACH_DRAW_X      DS.L    1
ACH_DRAW_Y      DS.L    1
ACH_END_Y       DS.L    1           ;Y for end screen stacking
ACH_DRAW_LOCKED DS.L    1           ;1 = greyed out, 0 = normal
ACH_CUR_BG      DS.L    1           ;bg colour being used right now
ACH_CUR_BORDER  DS.L    1           ;border colour being used right now
ACH_WALL_FROM   DS.L    1           ;0 = came from gameover, 1 = from win

;messages
ACH_TITLE_MSG   DC.B    'ACHIEVEMENT!', 0
ACH_NEMO_MSG    DC.B    'Sorry Nemo!', 0
ACH_PELICAN_MSG DC.B    'Beak-fast Served!', 0
ACH_FIRSTFISH_MSG DC.B  'First Catch!', 0
ACH_CRAB_MSG    DC.B    'Poor Crusty', 0
ACH_AIRFORCE_MSG DC.B   'Air Force', 0
ACH_SHARK_MSG   DC.B    'Is there no one else?', 0
ACH_AIRTIME_MSG DC.B    'Born to swim, live to fly!', 0
ACH_100FISH_MSG DC.B    'Oh my, Whale!', 0
ACH_MOON_MSG    DC.B    'Touch The Moon', 0
ACH_PELJMP_MSG  DC.B    'Over Easy!', 0

;text for achievements you havent earned yet
ACH_LOCKED_TITLE DC.B   'LOCKED', 0
ACH_LOCKED_MSG  DC.B    '????', 0

;trophy wall text
ACH_WALL_TITLE  DC.B    'ACHIEVEMENT WALL', 0
WALL_EXIT_LINE1 DC.B    ' -================-', 0
WALL_EXIT_LINE2 DC.B    'SWIM HERE TO GO BACK', 0

;save file
ACH_SAVE_FILE   DC.B    'ach.dat',0

;sound
ACH_SND_IDX EQU         03          ; achievement jingle sound index
ACH_WAV     DC.B        'achieve.wav',0  ; achievement sound file

    DS.W    0                       ;alignment padding




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
