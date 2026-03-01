START_DOT_X_L   EQU     485
START_DOT_X_R   EQU     510  
START_DOT_Y_L   EQU     336
START_DOT_Y_H   EQU     317

TITLE_START:
    JSR     LOOP_TITLE_MUSIC
TITLE_LOOP:
    ; Enable back buffer
    MOVE.B  #94,        D0
    TRAP    #15

    ; Clear the screen
    MOVE.B  #TC_CURSR_P,D0
    MOVE.W  #$FF00,     D1
    TRAP    #15
       
    BSR     TITLE_SCREEN
    BSR     STARTING_POINT
    BSR     UPDATE_DELTA_TIME
    JSR     INPUT                   ; Check Keyboard Input
	JSR     WASD_CHECK_INPUT		; now check WASD keys
    JSR		PLAYER_MOVEMENT			; Accel from input, drag, clamp speed (8.8)
    JSR		CLAMP_PLAYER			; limit player to stay within the screen edges
    ;JSR     DRAW_PLYR_DATA          ; Draw Draw Score, HUD, Player X and Y
	BSR     UPDATE
	BSR     DRAW_PLAYER
	
	; Swap buffer to show everything
    MOVE.B  #94,        D0
    TRAP    #15
    
    ; Small CPU relief delay        
    MOVE.L  #1,D1
    MOVE.B  #23,D0
    TRAP    #15		
	
    ;MOVE.L  CURRENT_KEY,D1
    ;CMP.B   #SPACEBAR,  D1
    ;B;NE     TITLE_LOOP
    
CHECK_COLL_START:
    ;PLAYER_X < START_DOT_X_R ?
    MOVE.L  PLAYER_X, D1
    CMP.L   #START_DOT_X_R, D1
    BGE     TITLE_LOOP

    ;PLAYER_X + PLAYER_W > START_DOT_X_L ?
    MOVE.L  PLAYER_X, D1
    ADD.L   PLYR_W_CURRENT, D1
    CMP.L   #START_DOT_X_L, D1
    BLE     TITLE_LOOP

    ;PLAYER_Y < START_DOT_Y_L ?
    MOVE.L  PLAYER_Y, D1
    CMP.L   #START_DOT_Y_L, D1
    BGE     TITLE_LOOP

    ;PLAYER_Y + PLAYER_H > START_DOT_Y_H ?
    MOVE.L  PLAYER_Y, D1
    ADD.L   PLYR_H_CURRENT, D1
    CMP.L   #START_DOT_Y_H, D1
    BLE     TITLE_LOOP
    
    JSR     STOP_TITLE_MUSIC 
    RTS
    
    

TITLE_SCREEN:

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2405, D1
    TRAP    #15
    
    LEA     title1, A1
    MOVE    #13,    D0
    TRAP    #15
    
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2406, D1
    TRAP    #15
    
    LEA     title2, A1
    MOVE    #13,    D0
    TRAP    #15
    
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2407, D1
    TRAP    #15
    
    LEA     title3, A1
    MOVE    #13,    D0
    TRAP    #15
                  
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2408, D1
    TRAP    #15
    
    LEA     title4, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$2409, D1
    TRAP    #15
    
    LEA     title5, A1
    MOVE    #13,    D0
    TRAP    #15
    
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$240A, D1
    TRAP    #15
    
    LEA     title6, A1
    MOVE    #13,    D0
    TRAP    #15
    
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$240B, D1
    TRAP    #15
    
    LEA     title7, A1
    MOVE    #13,    D0
    TRAP    #15
    
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$240C, D1
    TRAP    #15
    
    LEA     title8, A1
    MOVE    #13,    D0
    TRAP    #15
    
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$240D, D1
    TRAP    #15
    
    LEA     title9, A1
    MOVE    #13,    D0
    TRAP    #15
                        
    RTS
    
STARTING_POINT:
    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3614, D1
    TRAP    #15
    
    LEA     startpoint1, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3615, D1
    TRAP    #15
    
    LEA     startpoint2, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3616, D1
    TRAP    #15
    
    LEA     startpoint3, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3617, D1
    TRAP    #15
    
    LEA     startpoint4, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3618, D1
    TRAP    #15
    
    LEA     startpoint5, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3619, D1
    TRAP    #15
    
    LEA     startpoint6, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361A, D1
    TRAP    #15
    
    LEA     startpoint7, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361B, D1
    TRAP    #15
    
    LEA     startpoint8, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361C, D1
    TRAP    #15
    
    LEA     startpoint9, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361D, D1
    TRAP    #15
    
    LEA     startpoint10, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361E, D1
    TRAP    #15
    
    LEA     startpoint11, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$361F, D1
    TRAP    #15
    
    LEA     startpoint12, A1
    MOVE    #13,    D0
    TRAP    #15

    MOVE.B  #TC_CURSR_P, D0
    MOVE.W  #$3620, D1
    TRAP    #15
    
    LEA     startpoint13, A1
    MOVE    #13,    D0
    TRAP    #15    
    
    RTS

title1 dc.b  '                                           ( )       ',0
title2 dc.b  '    /\____    ( )      /\              ( )           ',0  
title3 dc.b  '   / ___ / ( ) ___/\  / /_   /\  /\  ( ) ____   ___/\',0    
title4 dc.b  '  / /_    / / / ___/ / __ \ / / / / / / / ___/ / ___/',0    
title5 dc.b  ' / __/   / / (__  ) / / / // /_/ / / / / /_   (__  )',0     
title6 dc.b  '/_/     /_/ /____/ /_/ /_/ \__  / / /  \_  / <____/',0      
title7 dc.b  '                          <____/  \/     \/        ( )',0
title8 dc.b  '                                                 ( )',0
title9 dc.b  '                                                      ( )',0


startpoint1 dc.b  '      ______      ',0
startpoint2 dc.b  '     |      |     ',0
startpoint3 dc.b  '     |______|     ',0
startpoint4 dc.b  '                  ',0
startpoint5 dc.b  '        /\        ',0
startpoint6 dc.b  '       //\\       ',0
startpoint7 dc.b  '      //  \\      ',0
startpoint8 dc.b  '        ||        ',0
startpoint9 dc.b  '        ||        ',0
startpoint10 dc.b '        ||        ',0          
startpoint11 dc.b '                  ',0
startpoint12 dc.b '-================-',0
startpoint13 dc.b 'SWIM HERE TO START',0












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
