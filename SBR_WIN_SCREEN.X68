    DS.W    0           ;fix alignment issue
    
WIN_START:
    JSR     LOOP_TITLE_MUSIC
    MOVE.L  #0, PLYR_VELOCITY_Y
    MOVE.L  #0, PLYR_VELOCITY_X
    MOVE.L  #PLAYER_X_INIT,         PLAYER_X
    MOVE.L  #PLAYER_Y_INIT,         PLAYER_Y
    MOVE.L	#IN_WTR_TRUE,	PLYR_IN_WATER_NOW
WIN_LOOP:
    ; Enable back buffer
    MOVE.B  #94,        D0
    TRAP    #15

    ; Clear the screen
    MOVE.B  #TC_CURSR_P,D0
    MOVE.W  #$FF00,     D1
    TRAP    #15
    
    BSR     WIN_SCREEN
    BSR     RESTARTING_POINT
    BSR     QUITTING_POINT
    BSR     UPDATE_DELTA_TIME
    JSR     INPUT                   ; Check Keyboard Input
	JSR     WASD_CHECK_INPUT		; now check WASD keys
    JSR     PLAYER_MOVEMENT			; Accel from input, drag, clamp speed (8.8)
	JSR     CLAMP_PLAYER
	;JSR     DRAW_PLYR_DATA          ; Draw Draw Score, HUD, Player X and Y
	BSR     UPDATE
	BSR     DRAW_PLAYER
	BSR     CHECK_COLL_RESTART
	BSR     CHECK_COLL_QUIT
	
	; Swap buffer to show everything
    MOVE.B  #94,        D0
    TRAP    #15
    
    ; Small CPU relief delay        
    MOVE.L  #1,D1
    MOVE.B  #23,D0
    TRAP    #15

    BRA     WIN_LOOP		

WIN_SCREEN:
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3205, D1
    TRAP    #15
    LEA     win1, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3206, D1
    TRAP    #15
    LEA     win2, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3207, D1
    TRAP    #15
    LEA     win3, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3208, D1
    TRAP    #15
    LEA     win4, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3209, D1
    TRAP    #15
    LEA     win5, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$320A, D1
    TRAP    #15
    LEA     win6, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$320B, D1
    TRAP    #15
    LEA     win7, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$320C, D1
    TRAP    #15
    LEA     win8, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$320D, D1
    TRAP    #15
    LEA     win9, A1
    MOVE    #13,    D0
    TRAP    #15
    
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2E0F, D1
    TRAP    #15
    LEA     win10, A1
    MOVE    #13,    D0
    TRAP    #15

    RTS    
    

win1 dc.b '               /\               ',0
win2 dc.b '              /  \              ',0
win3 dc.b ' _       /\  /    \  _   /\     ',0
win4 dc.b '| |     / / /_  __/ / | / /     ',0
win5 dc.b '| | /| / /   / /   /  |/ /      ',0
win6 dc.b '| |/ |/ /  _/ /   / /|  /       ',0
win7 dc.b '|  /|  /  /___/  / / |_/        ',0
win8 dc.b ' \/ | /          \/      ( )    ',0
win9 dc.b '    |/                       ( )',0

win10 dc.b 'You are the biggest fish in the sea!',0









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
