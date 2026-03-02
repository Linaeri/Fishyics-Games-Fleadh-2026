*-----------------------------------------------------------
* Title      : SBR_DRAW_PLAYER_ 1
* Description: 	Output to the screen - player at size 2
* Subroutines: (in this order:)

*	DRAW_PLAYER_1				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------
DRAW_PLAYER_3:    ; Size = 1
 
    MOVE.L  PLAYER_X,          POS_X    ; Set variable for x position of player or enemy
    MOVE.L  PLAYER_Y,          POS_Y    ; Set variable for x position of player or enemy    
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #45,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK LAST STATE
    TST.L IS_FLIPPED
    BEQ  WAS_LEFT_3    ; 
    BGT WAS_FLIP_3    ; WAS flipped

    
WAS_LEFT_3:

    TST.L PLYR_DIRECTION_X
    BLE DRAW_PLYR_LEFT_3 ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_PLYR_FLIP_3  ; STAY FLIPPED IF PLAYER NOT MOVING  

    RTS  

WAS_FLIP_3:
    TST.L PLYR_DIRECTION_X  ; Direction will be -1, 0 or 1 (left, not moving, right)
    BGE DRAW_PLYR_FLIP_3 
    BLT  DRAW_PLYR_LEFT_3   ; draw flipped
    
    RTS


*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_LEFT_3:
    MOVE.L #0, IS_FLIPPED
    
* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
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
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-7,        D4       ; Height

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
    ADD.L   #-3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
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
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #8,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Line Upper Tail Base   --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #42,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-7,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Upper Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #42,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #1,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail Base   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #42,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #42,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Square Top Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #034,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_YELLOW,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_YELLOW,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 1 topmost -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #7,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 2  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 3  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Nose  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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

* Square Top Banner 2 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square eye -------------------------------============================
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #BLACK,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #7,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 1 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
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
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #25,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Top Trim H   --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-8,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-5,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #21,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #26,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #20,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #21,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #38,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail trimline up   --------------------------------
	; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #43,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-8,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #1,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line tail trimline down  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #43,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #5,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


	RTS

*---------------------------------------------------------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*--------------------------------------------------------------------------------------------------------
DRAW_PLYR_FLIP_3:

    MOVE.L #1, IS_FLIPPED

* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
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
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-7,        D4       ; Height
             	        
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
    ADD.L   #-3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
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
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #8,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Line Upper Tail Base   --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #42,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-7,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Upper Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #42,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
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
    ADD.L   #32,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #42,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #42,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
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

* Square Top Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #034,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_YELLOW,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_YELLOW,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 1 topmost -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #7,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 2  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body 3  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Nose  -------------------------------

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
    MOVE.L  #PLAYER_3_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square eye -------------------------------============================
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #BLACK,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #7,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
                 	        
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
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 1 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
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
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #25,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Top Trim H   --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_3_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_3_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-8,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-4,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #21,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #26,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #20,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #21,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #38,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail trimline up   --------------------------------
	; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #43,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-8,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
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
    ADD.L   #43,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #5,        D4       ; Height
             	        
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

PLAYER_3_FIN	    	equ	$0032418C
PLAYER_3_RED    		equ	$003D4FA8
PLAYER_3_ORANGE			equ	$005696E3
PLAYER_3_YELLOW	    	equ	$0097D2F7
PLAYER_3_TRIM  			equ	$00BCDBE0


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
