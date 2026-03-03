RESTART_DOT_X_L     EQU     494
RESTART_DOT_X_R     EQU     514
RESTART_DOT_Y_H     EQU     350
RESTART_DOT_Y_L     EQU     370

DOTS_Y_H            EQU     467
DOTS_Y_L            EQU     484

QUIT_DOT_X_L        EQU     663
QUIT_DOT_X_R        EQU     710

ACHWALL_DOT_X_L     EQU     315
ACHWALL_DOT_X_R     EQU     360

DO_DO_UP_AND_DOWN   EQU 1
DONT_DO_UP_AND_DOWN EQU 0

    DS.W    0           ;fix alignment issue
    
END_START:
    JSR     STOP_OCARINA
    JSR     STOP_BACKGROUND     ;stop background music
    JSR     LOOP_OCARINA
    ;in case player is in the air, so they do not start following
    MOVE.L  #0, PLYR_VELOCITY_Y
    MOVE.L  #0, PLYR_VELOCITY_X
    MOVE.L	#IN_WTR_TRUE,	PLYR_IN_WATER_NOW
    
    ;reseting position
    MOVE.L  #PLAYER_X_INIT, PLAYER_X
    MOVE.L  #PLAYER_X_INIT, D1
    ASL.L   #8, D1
    MOVE.L  D1, PLYR_X_SUB

    MOVE.L  #PLAYER_Y_INIT, PLAYER_Y
    MOVE.L  #PLAYER_Y_INIT, D1
    ASL.L   #8, D1
    MOVE.L  D1, PLYR_Y_SUB

    MOVE.L  PLAYER_Y, UP_AND_DOWN_START_Y
    MOVE.B  #DO_DO_UP_AND_DOWN, DO_UP_AND_DOWN  ; enable bobbing on end screen
    CLR.W   UP_AND_DOWN_TICK                     ; reset tick counter
END_LOOP:
    ; Enable back buffer
    MOVE.B  #94,        D0
    TRAP    #15

    ; Clear the screen
    MOVE.B  #TC_CURSR_P,D0
    MOVE.W  #$FF00,     D1
    TRAP    #15
    
    ;MOVEM.L D0-D2, -(SP)
   ; MOVE.L  D2,            CURRENT_KEY ; Put Current Key in Memory
    ;CMP.L   #SPACEBAR,     CURRENT_KEY ; Is Current Key Escape
    ;BEQ     STARTx  
    ;BNE     END_CONTINUE
    
;STARTx:
    ;MOVEM.L (SP)+, D0-D2
    ;JSR     START

END_CONTINUE:
    ;MOVEM.L (SP)+, D0-D2
    JSR     END_SCREEN
    JSR     RESTARTING_POINT
    JSR     QUITTING_POINT
    JSR     ACHWALL_POINT
    JSR     UPDATE_DELTA_TIME
    JSR     INPUT                   ; Check Keyboard Input
	JSR     WASD_CHECK_INPUT		; now check WASD keys
    JSR     PLAYER_MOVEMENT			; Accel from input, drag, clamp speed (8.8)
    JSR		CLAMP_PLAYER			; limit player to stay within the screen edges
	;JSR     DRAW_PLYR_DATA          ; Draw Draw Score, HUD, Player X and Y
	JSR     UPDATE
	JSR     UP_AND_DOWN
	JSR     DRAW_SKELETON
	JSR     CHECK_COLL_RESTART
	JSR     CHECK_COLL_QUIT
	MOVE.L  #0, ACH_WALL_FROM
	JSR     CHECK_COLL_ACHWALL
	JSR     UPDATE_ACHIEVEMENT
	JSR     DRAW_ACHIEVEMENT
	
	; Swap buffer to show everything
    MOVE.B  #94,        D0
    TRAP    #15
    
    ; Small CPU relief delay        
    MOVE.L  #1,D1
    MOVE.B  #23,D0
    TRAP    #15

    BRA     END_LOOP		

UP_AND_DOWN:
    ; check if movement is enabled
    CMP.B   #DO_DO_UP_AND_DOWN, DO_UP_AND_DOWN
    BNE     UP_AND_DOWN_EXIT

    ; if the player started moving, disable bobbing
    MOVE.L  PLYR_DIRECTION_X, D0
    OR.L    PLYR_DIRECTION_Y, D0
    BEQ     MOVE_UP_AND_DOWN        ; no input yet, keep bobbing
    ; player pressed a movement key - disable bobbing permanently
    MOVE.B  #DONT_DO_UP_AND_DOWN, DO_UP_AND_DOWN
    BRA     UP_AND_DOWN_EXIT

MOVE_UP_AND_DOWN:
    ; slow down: only move every N frames
    MOVE.W  UP_AND_DOWN_TICK, D0
    ADDQ.W  #1, D0
    MOVE.W  D0, UP_AND_DOWN_TICK
    CMP.W   UP_AND_DOWN_SPEED, D0    ; wait this many frames before moving
    BLT     UP_AND_DOWN_EXIT         ; not time to move yet
    CLR.W   UP_AND_DOWN_TICK         ; reset tick counter

    ; save registers to stack
    MOVEM.L D0-D4, -(SP)

    ; clear registers to prevent junk data
    CLR.L   D0
    CLR.L   D1
    CLR.L   D2
    CLR.L   D3
    CLR.L   D4

    MOVE.L  PLAYER_Y, D0              ; get current position
    MOVE.W  UP_AND_DOWN_DISTANCE, D1  ; get allowed range (word->long, already CLR'd)
    MOVE.L  UP_AND_DOWN_START_Y, D2   ; get starting point (long)
    MOVE.B  UP_AND_DOWN_DIRECTION, D3 ; get current dir (-1 or 1)

    ; calculate current offset from start
    MOVE.L  D0, D4                   ; copy player y to d4
    SUB.L   D2, D4                   ; d4 = current_y - start_y

    ; check lower bound (if offset < 0)
    TST.L   D4
    BMI     UP_AND_DOWN_REVERSE_DIR

    ; check upper bound (if offset > distance)
    CMP.L   D1, D4
    BGT     UP_AND_DOWN_REVERSE_DIR

    BRA     MOVE_UP_AND_DOWN_CONTINUE

UP_AND_DOWN_REVERSE_DIR:
    NEG.B   D3                       ; flip direction bit
    MOVE.B  D3, UP_AND_DOWN_DIRECTION ; save the new direction

MOVE_UP_AND_DOWN_CONTINUE:
    ; sign extend direction byte to long
    EXT.W   D3
    EXT.L   D3
    ADD.L   D3, D0                   ; apply movement to y

UP_AND_DOWN_END:
    ; store the modified player y
    MOVE.L  D0, PLAYER_Y

    ; also update PLYR_Y_SUB so UPDATE doesn't overwrite us next frame
    MOVE.L  D0, D4
    ASL.L   #8, D4              ; convert pixel Y to 8.8 fixed-point
    MOVE.L  D4, PLYR_Y_SUB

    ; recover registers from stack
    MOVEM.L (SP)+, D0-D4

UP_AND_DOWN_EXIT:
    RTS

CHECK_COLL_RESTART:
    ;PLAYER_X < RESTART_DOT_X_R ?
    MOVE.L  PLAYER_X, D1
    CMP.L   #RESTART_DOT_X_R, D1
    BGE     NO_RESTART

    ;PLAYER_X + PLAYER_W > RESTART_DOT_X_L ?
    MOVE.L  PLAYER_X, D1
    ADD.L   PLYR_W_CURRENT, D1
    CMP.L   #RESTART_DOT_X_L, D1
    BLE     NO_RESTART

    ;PLAYER_Y < RESTART_DOT_Y_L ?
    MOVE.L  PLAYER_Y, D1
    CMP.L   #RESTART_DOT_Y_L, D1
    BGE     NO_RESTART

    ;PLAYER_Y + PLAYER_H > RESTART_DOT_Y_H ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    CMP.L   #RESTART_DOT_Y_H, D1
    BLE     NO_RESTART
    
    JSR     STOP_OCARINA
    JSR     INITIALISE
    JMP     GAME
    
NO_RESTART:
    RTS
    
CHECK_COLL_QUIT:
    ;PLAYER_X < QUIT_DOT_X_R ?
    MOVE.L  PLAYER_X, D1
    CMP.L   #QUIT_DOT_X_R, D1
    BGE     NO_QUIT

    ;PLAYER_X + PLAYER_W > QUIT_DOT_X_L ?
    MOVE.L  PLAYER_X, D1
    ADD.L   PLYR_W_CURRENT, D1
    CMP.L   #QUIT_DOT_X_L, D1
    BLE     NO_QUIT

    ;PLAYER_Y < DOTS_Y_L ?
    MOVE.L  PLAYER_Y, D1
    CMP.L   #DOTS_Y_L, D1
    BGE     NO_QUIT

    ;PLAYER_Y + PLAYER_H > DOTS_Y_H ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    CMP.L   #DOTS_Y_H, D1
    BLE     NO_QUIT
    
    JSR     STOP_OCARINA
    
    SIMHALT
    
NO_QUIT:
    RTS

CHECK_COLL_ACHWALL:
    ;PLAYER_X < ACHWALL_DOT_X_R ?
    MOVE.L  PLAYER_X, D1
    CMP.L   #ACHWALL_DOT_X_R, D1
    BGE     NO_ACHWALL

    ;PLAYER_X + PLAYER_W > ACHWALL_DOT_X_L ?
    MOVE.L  PLAYER_X, D1
    ADD.L   PLYR_W_CURRENT, D1
    CMP.L   #ACHWALL_DOT_X_L, D1
    BLE     NO_ACHWALL

    ;PLAYER_Y < DOTS_Y_L ?
    MOVE.L  PLAYER_Y, D1
    CMP.L   #DOTS_Y_L, D1
    BGE     NO_ACHWALL

    ;PLAYER_Y + PLAYER_H > DOTS_Y_H ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    CMP.L   #DOTS_Y_H, D1
    BLE     NO_ACHWALL

    JMP     ACH_WALL_START

NO_ACHWALL:
    RTS

END_SCREEN:
    ; set text background to black
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    ; set text color to white
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B05, D1
    TRAP    #15
    
    LEA     gameover1, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B06, D1
    TRAP    #15
    
    LEA     gameover2, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B07, D1
    TRAP    #15
    
    LEA     gameover3, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B08, D1
    TRAP    #15
    
    LEA     gameover4, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B09, D1
    TRAP    #15
    
    LEA     gameover5, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B0A, D1
    TRAP    #15
    
    LEA     gameover6, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B0B, D1
    TRAP    #15
    
    
    LEA     gameover7, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B0C, D1
    TRAP    #15
    
    LEA     gameover8, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$1B0D, D1
    TRAP    #15
    
    LEA     gameover9, A1
    MOVE    #13,    D0
    TRAP    #15
  
                        
    RTS
    
RESTARTING_POINT:
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00AE9E2E, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #2, D1
    MOVE.B  #93, D0
    TRAP    #15
    MOVE.L  #469, D1
    MOVE.L  #325, D2
    MOVE.L  #539, D3
    MOVE.L  #395, D4
    MOVE.B  #88, D0
    TRAP    #15

    MOVE.L  #$00000000, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #467, D1
    MOVE.L  #323, D2
    MOVE.L  #541, D3
    MOVE.L  #337, D4
    MOVE.B  #87, D0
    TRAP    #15

    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #469, D1
    MOVE.L  #355, D2
    MOVE.L  #478, D3
    MOVE.L  #333, D4
    MOVE.B  #84, D0
    TRAP    #15
    MOVE.L  #539, D1
    MOVE.L  #355, D2
    MOVE.L  #530, D3
    MOVE.L  #333, D4
    MOVE.B  #84, D0
    TRAP    #15

    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #478, D1
    MOVE.L  #325, D2
    MOVE.L  #530, D3
    MOVE.L  #337, D4
    MOVE.B  #88, D0
    TRAP    #15

    MOVE.L  #1, D1
    MOVE.B  #93, D0
    TRAP    #15

    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361B, D1
    TRAP    #15
    LEA     restartpoint5, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361C, D1
    TRAP    #15
    LEA     restartpoint6, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361D, D1
    TRAP    #15
    LEA     restartpoint7, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361E, D1
    TRAP    #15
    LEA     restartpoint8, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361F, D1
    TRAP    #15
    LEA     restartpoint9, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3620, D1
    TRAP    #15
    LEA     restartpoint10, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3621, D1
    TRAP    #15
    LEA     restartpoint11, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3622, D1
    TRAP    #15
    LEA     restartpoint12, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3623, D1
    TRAP    #15
    LEA     restartpoint13, A1
    MOVE    #13, D0
    TRAP    #15

    RTS

QUITTING_POINT:
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00AE9E2E, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #2, D1
    MOVE.B  #93, D0
    TRAP    #15
    MOVE.L  #652, D1
    MOVE.L  #440, D2
    MOVE.L  #722, D3
    MOVE.L  #510, D4
    MOVE.B  #88, D0
    TRAP    #15

    MOVE.L  #$00000000, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #650, D1
    MOVE.L  #438, D2
    MOVE.L  #724, D3
    MOVE.L  #452, D4
    MOVE.B  #87, D0
    TRAP    #15

    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #652, D1
    MOVE.L  #470, D2
    MOVE.L  #661, D3
    MOVE.L  #448, D4
    MOVE.B  #84, D0
    TRAP    #15
    MOVE.L  #722, D1
    MOVE.L  #470, D2
    MOVE.L  #713, D3
    MOVE.L  #448, D4
    MOVE.B  #84, D0
    TRAP    #15

    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #661, D1
    MOVE.L  #440, D2
    MOVE.L  #713, D3
    MOVE.L  #452, D4
    MOVE.B  #88, D0
    TRAP    #15

    MOVE.L  #1, D1
    MOVE.B  #93, D0
    TRAP    #15

    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D22, D1
    TRAP    #15
    LEA     quitpoint5, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D23, D1
    TRAP    #15
    LEA     quitpoint6, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D24, D1
    TRAP    #15
    LEA     quitpoint7, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D25, D1
    TRAP    #15
    LEA     quitpoint8, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D26, D1
    TRAP    #15
    LEA     quitpoint9, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D27, D1
    TRAP    #15
    LEA     quitpoint10, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D28, D1
    TRAP    #15
    LEA     quitpoint11, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D29, D1
    TRAP    #15
    LEA     quitpoint12, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D2A, D1
    TRAP    #15
    LEA     quitpoint13, A1
    MOVE    #13, D0
    TRAP    #15

    RTS

ACHWALL_POINT:
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00AE9E2E, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #2, D1
    MOVE.B  #93, D0
    TRAP    #15
    MOVE.L  #303, D1
    MOVE.L  #440, D2
    MOVE.L  #373, D3
    MOVE.L  #510, D4
    MOVE.B  #88, D0
    TRAP    #15

    MOVE.L  #$00000000, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #301, D1
    MOVE.L  #438, D2
    MOVE.L  #375, D3
    MOVE.L  #452, D4
    MOVE.B  #87, D0
    TRAP    #15

    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #303, D1
    MOVE.L  #470, D2
    MOVE.L  #312, D3
    MOVE.L  #448, D4
    MOVE.B  #84, D0
    TRAP    #15
    MOVE.L  #373, D1
    MOVE.L  #470, D2
    MOVE.L  #364, D3
    MOVE.L  #448, D4
    MOVE.B  #84, D0
    TRAP    #15

    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #312, D1
    MOVE.L  #440, D2
    MOVE.L  #364, D3
    MOVE.L  #452, D4
    MOVE.B  #88, D0
    TRAP    #15

    MOVE.L  #1, D1
    MOVE.B  #93, D0
    TRAP    #15

    MOVE.L  #$00000000, D1
    MOVE.B  #81, D0
    TRAP    #15
    MOVE.L  #$00FFFFFF, D1
    MOVE.B  #80, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2122, D1
    TRAP    #15
    LEA     achwallpt5, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2123, D1
    TRAP    #15
    LEA     achwallpt6, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2124, D1
    TRAP    #15
    LEA     achwallpt7, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2125, D1
    TRAP    #15
    LEA     achwallpt8, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2126, D1
    TRAP    #15
    LEA     achwallpt9, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2127, D1
    TRAP    #15
    LEA     achwallpt10, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2128, D1
    TRAP    #15
    LEA     achwallpt11, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2129, D1
    TRAP    #15
    LEA     achwallpt12, A1
    MOVE    #13, D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$212A, D1
    TRAP    #15
    LEA     achwallpt13, A1
    MOVE    #13, D0
    TRAP    #15

    RTS

gameover1 dc.b '                          ( )                                            ',0
gameover2 dc.b '   __/\__            ( )                   /\____                        ',0
gameover3 dc.b '  / ____/ |\___    ___  ___    ____       / __  _\ _   __ |\____    ___/\',0
gameover4 dc.b ' / / __  / __ `/  / __ `__ \  / _  /     / / / /  | | / / \  _  /  / _  /',0
gameover5 dc.b '/ /_/ / / /_/ /  / / / / / / /  __/     / /_/ /   | |/ /  / __ /  / / \/ ',0
gameover6 dc.b '\____/  \__,_/  / / /_/ / /  \____>     \____/    |_  /   \____> /_/     ',0
gameover7 dc.b '                \/      \/                          \/             ( )   ',0
gameover8 dc.b '                                                                      ( )',0
gameover9 dc.b '                                                                ( )      ',0


restartpoint5 dc.b  '        /\        ',0
restartpoint6 dc.b  '       //\\       ',0
restartpoint7 dc.b  '      //  \\      ',0
restartpoint8 dc.b  '        ||        ',0
restartpoint9 dc.b  '        ||        ',0
restartpoint10 dc.b '        ||        ',0          
restartpoint11 dc.b '                   ',0
restartpoint12 dc.b ' -================-',0
restartpoint13 dc.b '      RESTART      ',0

quitpoint5 dc.b  '        /\        ',0
quitpoint6 dc.b  '       //\\       ',0
quitpoint7 dc.b  '      //  \\      ',0
quitpoint8 dc.b  '        ||        ',0
quitpoint9 dc.b  '        ||        ',0
quitpoint10 dc.b '        ||        ',0          
quitpoint11 dc.b '                   ',0
quitpoint12 dc.b ' -================-',0
quitpoint13 dc.b '       QUIT        ',0

achwallpt5  dc.b  '        /\        ',0
achwallpt6  dc.b  '       //\\       ',0
achwallpt7  dc.b  '      //  \\      ',0
achwallpt8  dc.b  '        ||        ',0
achwallpt9  dc.b  '        ||        ',0
achwallpt10 dc.b  '        ||        ',0
achwallpt11 dc.b  '                   ',0
achwallpt12 dc.b  ' -================-',0
achwallpt13 dc.b  '     TROPHIES     ',0


; up and down definitions
UP_AND_DOWN_DIRECTION:  DC.B 1          ; 1 for down, -1 for up (vector)
DO_UP_AND_DOWN:         DC.B 1          ; 1 to enable, 0 to disable
UP_AND_DOWN_START_Y:    DC.L 0        ; starting y position
UP_AND_DOWN_DISTANCE:   DC.W 5          ; max pixels to move from start
UP_AND_DOWN_TICK:       DC.W 0          ; frame counter for slowing movement
UP_AND_DOWN_SPEED:      DC.W 6          ; move 1 pixel every N frames (higher = slower)








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
