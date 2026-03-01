RESTART_DOT_X_L     EQU     315
RESTART_DOT_X_R     EQU     360

DOTS_Y_H            EQU     467
DOTS_Y_L            EQU     484

QUIT_DOT_X_L        EQU     663
QUIT_DOT_X_R        EQU     710

    DS.W    0           ;fix alignment issue
    
END_START:
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
    
END_LOOP:
    ; Enable back buffer
    MOVE.B  #94,        D0
    TRAP    #15

    ; Clear the screen
    MOVE.B  #TC_CURSR_P,D0
    MOVE.W  #$FF00,     D1
    TRAP    #15
    
    BSR     END_SCREEN
    BSR     RESTARTING_POINT
    BSR     QUITTING_POINT
    BSR     UPDATE_DELTA_TIME
    JSR     INPUT                   ; Check Keyboard Input
	JSR     WASD_CHECK_INPUT		; now check WASD keys
    JSR     PLAYER_MOVEMENT			; Accel from input, drag, clamp speed (8.8)
    JSR		CLAMP_PLAYER			; limit player to stay within the screen edges
	;JSR     DRAW_PLYR_DATA          ; Draw Draw Score, HUD, Player X and Y
	BSR     UPDATE
	BSR     DRAW_SKELETON
	BSR     CHECK_COLL_RESTART
	BSR     CHECK_COLL_QUIT
	
	; Swap buffer to show everything
    MOVE.B  #94,        D0
    TRAP    #15
    
    ; Small CPU relief delay        
    MOVE.L  #1,D1
    MOVE.B  #23,D0
    TRAP    #15

    BRA     END_LOOP		
    
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

    ;PLAYER_Y < DOTS_Y_L ?
    MOVE.L  PLAYER_Y, D1
    CMP.L   #DOTS_Y_L, D1
    BGE     NO_RESTART

    ;PLAYER_Y + PLAYER_H > DOTS_Y_H ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    CMP.L   #DOTS_Y_H, D1
    BLE     NO_RESTART
    
    JSR     STOP_OCARINA
    
    JMP     START
    
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

END_SCREEN:
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
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$211E, D1
    TRAP    #15
    LEA     restartpoint1, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$211F, D1
    TRAP    #15
    LEA     restartpoint2, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2120, D1
    TRAP    #15
    LEA     restartpoint3, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2121, D1
    TRAP    #15
    LEA     restartpoint4, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2122, D1
    TRAP    #15
    LEA     restartpoint5, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2123, D1
    TRAP    #15
    LEA     restartpoint6, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2124, D1
    TRAP    #15
    LEA     restartpoint7, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2125, D1
    TRAP    #15
    LEA     restartpoint8, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2126, D1
    TRAP    #15
    LEA     restartpoint9, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2127, D1
    TRAP    #15
    LEA     restartpoint10, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2128, D1
    TRAP    #15
    LEA     restartpoint11, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2129, D1
    TRAP    #15
    LEA     restartpoint12, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$212A, D1
    TRAP    #15
    LEA     restartpoint13, A1
    MOVE    #13,    D0
    TRAP    #15

    RTS

QUITTING_POINT:
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D1E, D1
    TRAP    #15
    LEA     quitpoint1, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D1F, D1
    TRAP    #15
    LEA     quitpoint2, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D20, D1
    TRAP    #15
    LEA     quitpoint3, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D21, D1
    TRAP    #15
    LEA     quitpoint4, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D22, D1
    TRAP    #15
    LEA     quitpoint5, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D23, D1
    TRAP    #15
    LEA     quitpoint6, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D24, D1
    TRAP    #15
    LEA     quitpoint7, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D25, D1
    TRAP    #15
    LEA     quitpoint8, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D26, D1
    TRAP    #15
    LEA     quitpoint9, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D27, D1
    TRAP    #15
    LEA     quitpoint10, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D28, D1
    TRAP    #15
    LEA     quitpoint11, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D29, D1
    TRAP    #15
    LEA     quitpoint12, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$4D2A, D1
    TRAP    #15
    LEA     quitpoint13, A1
    MOVE    #13,    D0
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


restartpoint1 dc.b  '       ______      ',0
restartpoint2 dc.b  '      |      |     ',0
restartpoint3 dc.b  '      |______|     ',0
restartpoint4 dc.b  '                   ',0
restartpoint5 dc.b  '         /\        ',0
restartpoint6 dc.b  '        //\\       ',0
restartpoint7 dc.b  '       //  \\      ',0
restartpoint8 dc.b  '         ||        ',0
restartpoint9 dc.b  '         ||        ',0
restartpoint10 dc.b '         ||        ',0          
restartpoint11 dc.b '                   ',0
restartpoint12 dc.b ' -================-',0
restartpoint13 dc.b 'SWIM HERE TO RESTART',0

quitpoint1 dc.b  '       ______      ',0
quitpoint2 dc.b  '      |      |     ',0
quitpoint3 dc.b  '      |______|     ',0
quitpoint4 dc.b  '                   ',0
quitpoint5 dc.b  '         /\        ',0
quitpoint6 dc.b  '        //\\       ',0
quitpoint7 dc.b  '       //  \\      ',0
quitpoint8 dc.b  '         ||        ',0
quitpoint9 dc.b  '         ||        ',0
quitpoint10 dc.b '         ||        ',0          
quitpoint11 dc.b '                   ',0
quitpoint12 dc.b ' -================-',0
quitpoint13 dc.b ' SWIM HERE TO QUIT ',0













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
