*-----------------------------------------------------------
* Title      : SBR_DRAW_PLAYER_ 4
* Description: 	Output to the screen - player at size 2
* Subroutines: (in this order:)

*	DRAW_PLAYER_1				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------
DRAW_PLAYER_4:    ; Size = 1
 
    MOVE.L  PLAYER_X,          POS_X    ; Set variable for x position of player or enemy
    MOVE.L  PLAYER_Y,          POS_Y    ; Set variable for x position of player or enemy    
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #42,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK LAST STATE
    TST.L IS_FLIPPED
    BEQ  WAS_LEFT_4    ; 
    BGT WAS_FLIP_4    ; WAS flipped

    
WAS_LEFT_4:

    TST.L PLYR_DIRECTION_X
    BLE DRAW_PLYR_LEFT_4 ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_PLYR_FLIP_4  ; STAY FLIPPED IF PLAYER NOT MOVING  

    RTS  

WAS_FLIP_4:
    TST.L PLYR_DIRECTION_X  ; Direction will be -1, 0 or 1 (left, not moving, right)
    BGE DRAW_PLYR_FLIP_4 
    BLT  DRAW_PLYR_LEFT_4   ; draw flipped
    
    RTS


*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_LEFT_4:
    MOVE.L #0, IS_FLIPPED
    
* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-9,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Line Upper Fin end  --------------------------------
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Upper Fin Base 1--------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Upper Fin Base 2 --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Upper Fin Base 3 --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Middle --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #38,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Outer --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #44,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Line Upper Tail Base   --------------------------------

 	; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perf

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #47,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-9,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Upper Tail End  --------------------------------


	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #47,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #1,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail Base   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #47,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #47,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Line Top Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action) 

  ; Set Pen Width
    MOVE.L  #02,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #21,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

  ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

* Square Top Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_RED,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_RED,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #038,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_YELLOW,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_YELLOW,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #8,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 1 topmost -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_ORANGE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_ORANGE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #7,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 2  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_ORANGE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_ORANGE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 3  -------------------------------
  ; Set Pixel Colors
    MOVE.L  #PLAYER_4_YELLOW,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_YELLOW,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line Body smooth back  --------------------------------

  	; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #8,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Nose  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_ORANGE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_ORANGE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line Top Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action) 

  ; Set Pen Width
    MOVE.L  #02,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #21,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
           	        
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

  ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

* Square Top Banner 2 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_RED,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_RED,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square eye -------------------------------============================
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #1,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Left Fin 1 -------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #24,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 1 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #24,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin Patch -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)



* Line Left Fin   --------------------------------
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #8,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Right Fin  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #24,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)   


; Set Pixel Colors
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action) 

* Square Left Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #24,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #23,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #24,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #31,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #27,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #31,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #27,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #43,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line  Tail trimline up   --------------------------------
	; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #49,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #1,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line tail trimline down  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #49,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


	RTS


*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_FLIP_4:

    MOVE.L #1, IS_FLIPPED

	* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-9,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Line Upper Fin end  --------------------------------
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Upper Fin Base 1--------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Upper Fin Base 2 --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Upper Fin Base 3 --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Middle --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #38,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Outer --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #44,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Line Upper Tail Base   --------------------------------

 	; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perf

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #47,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-9,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Upper Tail End  --------------------------------


	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #47,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #1,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail Base   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #47,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #47,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Line Top Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action) 

  ; Set Pen Width
    MOVE.L  #02,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #21,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

  ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 


* Square Top Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_RED,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_RED,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #038,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_YELLOW,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_YELLOW,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #8,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 1 topmost -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_ORANGE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_ORANGE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #7,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 2  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_ORANGE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_ORANGE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 3  -------------------------------
  ; Set Pixel Colors
    MOVE.L  #PLAYER_4_YELLOW,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_YELLOW,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line Body smooth back  --------------------------------

  	; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #8,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Nose  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_ORANGE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_ORANGE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Banner 2 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_RED,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_RED,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square eye -------------------------------============================
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #1,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Left Fin 1 -------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #24,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 1 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #24,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin Patch -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height
               	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)



* Line Left Fin   --------------------------------
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #8,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Right Fin  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #24,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)   



; Set Pixel Colors
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_4_TRIM,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action) 

  ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

* Square Left Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #24,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #23,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #24,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #31,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #27,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #31,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #27,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #43,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line  Tail trimline up   --------------------------------
	; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #49,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #1,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line tail trimline down  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #49,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height
           	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


	RTS


*------------------------
; HEX CODES
*------------------------

PLAYER_4_FIN	    	equ	$0032418C
PLAYER_4_RED    		equ	$000031a7
PLAYER_4_ORANGE			equ	$000a58e0
PLAYER_4_YELLOW	    	equ	$001b8af5
PLAYER_4_TRIM  			equ	$0012a5f5
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
