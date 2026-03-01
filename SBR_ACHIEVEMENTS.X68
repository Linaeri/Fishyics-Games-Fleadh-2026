*-----------------------------------------------------------
* Title      : SBR_ACHIEVEMENTS
* Description: Achievement popup system
*              Shows a banner in the top-right corner when
*              the player triggers an achievement.
*              Each achievement fires only once per game.
*
* Achievements:
*   ID 0 - "Sorry Nemo!"       - eat a clownfish for the first time
*   ID 1 - "Beak-fast Served!" - interact with pelican (eat or eaten)
*-----------------------------------------------------------

;achievement display settings
ACH_DISPLAY_TIME    EQU     3000        ;how long the banner stays (ms)
ACH_BOX_W           EQU     180         ;banner width
ACH_BOX_H           EQU     52          ;banner height
ACH_BOX_MARGIN      EQU     12          ;margin from screen edge
ACH_ICON_SIZE       EQU     28          ;icon square size

;colours
ACH_BG_CLR          EQU     $00402010   ;dark semi-transparent brown (BGR)
ACH_BORDER_CLR      EQU     $0000CCFF   ;gold border (BGR)  
ACH_TITLE_CLR       EQU     $0000CCFF   ;gold title text
ACH_TEXT_CLR        EQU     $00FFFFFF   ;white body text

;icon colours
ACH_ICON_NEMO_BODY  EQU     $000060F0   ;orange (BGR for Easy68k)
ACH_ICON_NEMO_STRIPE EQU   $00FFFFFF   ;white stripe


*-----------------------------------------------------------
* Subroutine    : INIT_ACHIEVEMENTS
* Description   : Reset all achievement flags and timer
*-----------------------------------------------------------
INIT_ACHIEVEMENTS:
    MOVE.L  #0, ACH_UNLOCKED_0     ;nemo not yet earned
    MOVE.L  #0, ACH_UNLOCKED_1     ;pelican not yet earned
    MOVE.L  #0, ACH_SHOWING        ;nothing on screen
    MOVE.L  #0, ACH_TIMER          ;timer clear
    MOVE.L  #0, ACH_CURRENT_ID     ;no current achievement
    RTS


*-----------------------------------------------------------
* Subroutine    : TRIGGER_ACH_NEMO
* Description   : Called when player eats a clownfish.
*                 Only fires the first time.
*-----------------------------------------------------------
TRIGGER_ACH_NEMO:
    ;already earned? skip
    CMP.L   #1, ACH_UNLOCKED_0
    BEQ     .TA_NEMO_DONE

    ;mark earned
    MOVE.L  #1, ACH_UNLOCKED_0

    ;start showing the popup
    MOVE.L  #0, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING

    ;play the achievement jingle
    JSR     PLAY_ACH_SND

.TA_NEMO_DONE:
    RTS


*-----------------------------------------------------------
* Subroutine    : TRIGGER_ACH_PELICAN
* Description   : Called when player collides with pelican
*                 (either eating it or being eaten).
*                 Only fires the first time.
*-----------------------------------------------------------
TRIGGER_ACH_PELICAN:
    ;already earned? skip
    CMP.L   #1, ACH_UNLOCKED_1
    BEQ     .TA_PEL_DONE

    ;mark earned
    MOVE.L  #1, ACH_UNLOCKED_1

    ;start showing (only if nothing currently showing, or override)
    MOVE.L  #1, ACH_CURRENT_ID
    MOVE.L  #ACH_DISPLAY_TIME, ACH_TIMER
    MOVE.L  #1, ACH_SHOWING

    ;play achievement sound effect
    JSR     PLAY_ACH_SND

.TA_PEL_DONE:
    RTS


*-----------------------------------------------------------
* Subroutine    : UPDATE_ACHIEVEMENT
* Description   : Count down the display timer each frame.
*                 Called from the main game loop.
*-----------------------------------------------------------
UPDATE_ACHIEVEMENT:
    CMP.L   #1, ACH_SHOWING
    BNE     .UA_DONE

    ;subtract delta time
    MOVE.L  DELTA_TIME, D0
    SUB.L   D0, ACH_TIMER

    ;timer expired?
    CMP.L   #0, ACH_TIMER
    BGT     .UA_DONE

    ;hide the banner
    MOVE.L  #0, ACH_SHOWING
    MOVE.L  #0, ACH_TIMER

.UA_DONE:
    RTS


*-----------------------------------------------------------
* Subroutine    : DRAW_ACHIEVEMENT
* Description   : Draw the achievement banner in the top-right
*                 corner if one is currently showing.
*                 Layout:
*                 +--[ICON]--ACHIEVEMENT!---------+
*                 |          caption text          |
*                 +-------------------------------+
*-----------------------------------------------------------
DRAW_ACHIEVEMENT:
    CMP.L   #1, ACH_SHOWING
    BNE     .DA_DONE

    ;--- calculate box position ---
    ;X = SCREEN_W - BOX_W - MARGIN
    CLR.L   D5
    MOVE.W  SCREEN_W, D5
    SUB.L   #ACH_BOX_W, D5
    SUB.L   #ACH_BOX_MARGIN, D5
    MOVE.L  D5, ACH_DRAW_X          ;top-left X of box

    MOVE.L  #ACH_BOX_MARGIN, ACH_DRAW_Y  ;top-left Y

    ;--- draw background box ---
    MOVE.L  #ACH_BG_CLR, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #ACH_BG_CLR, D1
    MOVE.B  #81, D0
    TRAP    #15

    MOVE.L  ACH_DRAW_X, D1
    MOVE.L  ACH_DRAW_Y, D2
    MOVE.L  D1, D3
    ADD.L   #ACH_BOX_W, D3
    MOVE.L  D2, D4
    ADD.L   #ACH_BOX_H, D4
    MOVE.B  #87, D0                 ;filled rectangle
    TRAP    #15

    ;--- draw border ---
    MOVE.L  #ACH_BORDER_CLR, D1
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

    ;--- draw icon based on current achievement ---
    MOVE.L  ACH_CURRENT_ID, D0
    CMP.L   #0, D0
    BEQ     .DA_ICON_NEMO
    CMP.L   #1, D0
    BEQ     .DA_ICON_PELICAN
    BRA     .DA_AFTER_ICON

;--- NEMO ICON: draw the real clownfish sprite as the icon ---
.DA_ICON_NEMO:
    ; the clownfish sprite goes from about X-4 to X+20 and Y-2 to Y+11
    ; so its roughly 24x13 px, fits inside the 28x28 icon area no problem
    ; we position the origin so the fish sits centered in the box
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #10, D1             ; X pos so the mouth starts near icon left edge
    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #22, D2             ; Y pos roughly centered vertically in the banner
    MOVE.L  #-1, D3             ; face left (looks nicer for the popup)
    JSR     DRAW_CLOWNFISH      ; reuse the actual clownfish drawing routine

    BRA     .DA_AFTER_ICON

;--- PELICAN ICON: no pelican sprite yet, skip for now ---
; TODO: draw a pelican icon here once we have proper art for it
;       for now the banner will just show the text with no icon
.DA_ICON_PELICAN:

.DA_AFTER_ICON:

    ;--- draw title text "ACHIEVEMENT!" ---
    ; cursor position uses col/row grid (high byte = col, low byte = row)
    ; each char is about 8px wide, 16px tall in Courier New 10pt

    ; work out what column the text should start at
    ; we offsett 42px past the icon so text doesnt overlap the fish/bird
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

    ;--- draw caption text one line below ---
    MOVE.L  ACH_DRAW_X, D1
    ADD.L   #42, D1
    DIVU    #8, D1                  ; same column as title
    AND.L   #$FFFF, D1
    LSL.W   #8, D1

    MOVE.L  ACH_DRAW_Y, D2
    ADD.L   #24, D2                 ; one row lower than title
    DIVU    #16, D2
    AND.L   #$FFFF, D2
    OR.W    D2, D1
    MOVE.B  #TC_CURSR_P, D0
    TRAP    #15

    ; pick which caption string to show based on the achievement id
    MOVE.L  ACH_CURRENT_ID, D0
    CMP.L   #0, D0
    BEQ     .DA_CAP_NEMO
    CMP.L   #1, D0
    BEQ     .DA_CAP_PELICAN
    BRA     .DA_DONE

.DA_CAP_NEMO:
    LEA     ACH_NEMO_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15
    BRA     .DA_DONE

.DA_CAP_PELICAN:
    LEA     ACH_PELICAN_MSG, A1
    MOVE.B  #13, D0
    TRAP    #15

.DA_DONE:
    RTS


*-----------------------------------------------------------
* Subroutine    : PLAY_ACH_SND
* Description   : Play the achievement unlock jingle
*-----------------------------------------------------------
PLAY_ACH_SND:
    MOVE    #ACH_SND_IDX, D1        ; achievement sound index
    MOVE    #72,        D0          ; play sound
    TRAP    #15
    RTS

*-----------------------------------------------------------
* Subroutine    : ACH_SND_LOAD
* Description   : Load the achievement wav file into memory
*-----------------------------------------------------------
ACH_SND_LOAD:
    LEA     ACH_WAV,    A1          ; achievement wav path
    MOVE    #ACH_SND_IDX, D1        ; assign sound index
    MOVE    #71,        D0          ; load into memory
    TRAP    #15
    RTS

*-----------------------------------------------------------
* Section       : Achievement Data
*-----------------------------------------------------------
;flags: 1 = earned, 0 = not yet
ACH_UNLOCKED_0  DS.L    1           ;nemo achievement
ACH_UNLOCKED_1  DS.L    1           ;pelican achievement

;display state
ACH_SHOWING     DS.L    1           ;1 = banner visible
ACH_TIMER       DS.L    1           ;ms remaining
ACH_CURRENT_ID  DS.L    1           ;which achievement is showing

;temp draw coords
ACH_DRAW_X      DS.L    1
ACH_DRAW_Y      DS.L    1

;messages
ACH_TITLE_MSG   DC.B    'ACHIEVEMENT!', 0
ACH_NEMO_MSG    DC.B    'Sorry Nemo!', 0
ACH_PELICAN_MSG DC.B    'Beak-fast Served!', 0

;sound
ACH_SND_IDX EQU         03          ; achievement jingle sound index
ACH_WAV     DC.B        'achieve.wav',0  ; achievement sound file

    DS.W    0                       ;alignment padding


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
