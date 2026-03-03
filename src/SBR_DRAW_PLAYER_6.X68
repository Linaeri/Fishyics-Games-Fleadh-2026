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
DRAW_PLAYER_6:    ; Size = 1
 
    MOVE.L  PLAYER_X,          POS_X    ; Set variable for x position of player or enemy
    MOVE.L  PLAYER_Y,          POS_Y    ; Set variable for x position of player or enemy    
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #72,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK LAST STATE
    TST.L IS_FLIPPED
    BEQ  WAS_LEFT_6    ; 
    BGT WAS_FLIP_6    ; WAS flipped

    
WAS_LEFT_6:

    TST.L PLYR_DIRECTION_X
    BLE DRAW_PLYR_LEFT_6 ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_PLYR_FLIP_6  ; STAY FLIPPED IF PLAYER NOT MOVING  

    RTS  

WAS_FLIP_6:
    TST.L PLYR_DIRECTION_X  ; Direction will be -1, 0 or 1 (left, not moving, right)
    BGE DRAW_PLYR_FLIP_6 
    BLT  DRAW_PLYR_LEFT_6   ; draw flipped
    
    RTS


*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_LEFT_6:
    MOVE.L #0, IS_FLIPPED

* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-14,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 




* Line Upper Fin end  --------------------------------
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #26,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
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
    ADD.L   #59,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #64,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Outer --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #64,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Outer --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #54,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #60,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Line Upper Tail Base   --------------------------------

 	; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #52,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #68,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-12,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Upper Tail End  --------------------------------


	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #68,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #60,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #1,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail Base   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #52,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #68,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #68,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #52,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #11,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)



	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Line Top Trim V CYAN   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #30,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

  ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 


* Line Top Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

  ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

* Square Top Fin Fill A -------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Fin Fill B -------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #21,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Body A topmost -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #52,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body B  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body Fill nose  -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #6,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Line Body smooth back  --------------------------------

 ; Set Pixel Colors
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  	; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Nose  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-6,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner A -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_YELLOW,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_YELLOW,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner B -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Banner A -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #54,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Banner B -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-6,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #54,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Top Banner C -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-6,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #013,        D4       ; Height
    
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
    ADD.L   #3,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Left Fin Up ------------------------------- x

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Fin Down -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #28,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 1 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #22,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #28,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin Patch -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height
    
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
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #26,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Right Fin  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #21,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #28,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)   


; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

* Square Left Fin Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #28,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #27,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #28,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin Trim V   -------------------------------- x

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #35,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #31,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #33,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #30,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #31,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)




***************************************************************
* CYAN PARTS
***************************************************************

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

* Square Left Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #29,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #28,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #29,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim V   -------------------------------- x

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #37,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #32,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #31,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #32,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #67,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 


	
	
* Square Tail Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #67,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #68,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Square Tail Trim V CYAN adjust  --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #68,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)



*************************************************************


* Square Gill A1  --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Gill A2  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height


* Square Gill B1  --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Gill B2  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height

	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

	RTS

    
*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_FLIP_6:
    MOVE.L #1, IS_FLIPPED


* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-14,        D4       ; Height
                 	        
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
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 




* Line Upper Fin end  --------------------------------
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #26,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
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
    ADD.L   #59,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #64,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Outer --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #64,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Outer --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #54,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #60,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
                     	        
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
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #52,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #68,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-12,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Upper Tail End  --------------------------------


	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #68,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #60,        D3       ; Width
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
    ADD.L   #52,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #68,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Lower Tail End  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #68,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #52,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #11,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)



	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Line Top Trim V CYAN   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #30,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
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


* Line Top Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
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

* Square Top Fin Fill A -------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Fin Fill B -------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #21,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Body A topmost -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #52,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body B  -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Body Fill nose  -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #6,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Line Body smooth back  --------------------------------

 ; Set Pixel Colors
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

  	; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height
                 	        
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
    MOVE.L  #PLAYER_5_ORANGE,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_ORANGE,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-6,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner A -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_YELLOW,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_YELLOW,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
      ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Bottom Banner B -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #4,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Banner A -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #54,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Top Banner B -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-6,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #54,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Top Banner C -------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_RED,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_RED,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-6,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #013,        D4       ; Height
                     	        
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
    ADD.L   #3,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


* Square Left Fin Up ------------------------------- x

    ; Set Pixel Colors
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Fin Down -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #28,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 1 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #22,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin 2 -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #28,        D4       ; Height
                     	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin Patch -------------------------------

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height
                     	        
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
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #26,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

* Line Right Fin  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #21,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #34,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #28,        D4       ; Height
                 	        
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
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

* Square Left Fin Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #28,        D4       ; Height
                 	        
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
    ADD.L   #27,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #28,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Fin Trim V   -------------------------------- x

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #35,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #31,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #33,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #30,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #31,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)




***************************************************************
* CYAN PARTS
***************************************************************

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

* Square Left Trim V   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #29,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Left Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #28,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #29,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim V   -------------------------------- x

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #37,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #32,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Right Trim H   --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #31,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #32,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Tail Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #67,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 


	
	
* Square Tail Trim V   --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #67,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #68,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #21,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Square Tail Trim V CYAN adjust  --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_CYAN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #68,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #22,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)



*************************************************************


* Square Gill A1  --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Gill A2  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height


* Square Gill B1  --------------------------------

; Set Pixel Colors
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_5_TRIM,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square Gill B2  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height
                 	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)


	RTS

*------------------------
; HEX CODES
*------------------------

PLAYER_6_FIN	    	equ	$0032418C
PLAYER_6_RED    		equ	$000031A7
PLAYER_6_ORANGE			equ	$000954DE
PLAYER_6_YELLOW	    	equ	$001B8AF5
PLAYER_6_TRIM  			equ	$0068A6ED
PLAYER_6_CYAN 			equ	$00eff227













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
