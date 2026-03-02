*-----------------------------------------------------------
* Title      : SBR_DRAW_PLAYER_ 2
* Description: 	Output to the screen - player at size 2
* Subroutines: (in this order:)

*	DRAW_PLAYER_2				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------
DRAW_PLAYER_2:    ; Size = 1
 
    MOVE.L  PLAYER_X,          POS_X    ; Set variable for x position of player or enemy
    MOVE.L  PLAYER_Y,          POS_Y    ; Set variable for x position of player or enemy    
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #43,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK LAST STATE
    TST.L IS_FLIPPED
    BEQ  WAS_LEFT_2    ; 
    BGT WAS_FLIP_2    ; WAS flipped

    
WAS_LEFT_2:

    TST.L PLYR_DIRECTION_X
    BLE DRAW_PLYR_LEFT_2 ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_PLYR_FLIP_2  ; STAY FLIPPED IF PLAYER NOT MOVING  

    RTS  

WAS_FLIP_2:
    TST.L PLYR_DIRECTION_X  ; Direction will be -1, 0 or 1 (left, not moving, right)
    BGE DRAW_PLYR_FLIP_2 
    BLT  DRAW_PLYR_LEFT_2   ; draw flipped
    
    RTS


*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_LEFT_2:
    MOVE.L #0, IS_FLIPPED
    
* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #6,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-7,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Upper Fin Main --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Upper Fin Fill --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Square Tail fin Outer --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #35,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #40,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Line Tail upper  --------------------------------

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #40,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-8,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
* Line Tail Lower  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #8,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #40,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #15,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Square Tail fin  --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #31,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #8,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body 1 top --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body 2 middle --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #10,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body 3 bottom --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square top banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #3,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square bottom banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_YELLOW,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_YELLOW,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Square Lower Fin Main --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Line Lower fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #7,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #17,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Top fin 1 (vertical)  --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-8,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Bottom fin 1 (vertical)  --------------------------------

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #18,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #BLACK,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #2,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    RTS                             ; Return to subroutine


	RTS

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_FLIP_2:

    MOVE.L #1, IS_FLIPPED
* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #6,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
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


* Square Upper Fin Main --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Upper Fin Fill --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Square Tail fin Outer --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #35,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #40,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Line Tail upper  --------------------------------

  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #40,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-8,        D4       ; Height
         	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
* Line Tail Lower  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #34,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #8,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #40,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #15,        D4       ; Height
         	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	

	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Square Tail fin  --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #31,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #8,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body 1 top --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #6,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body 2 middle --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #6,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #10,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body 3 bottom --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square top banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #3,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square bottom banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_YELLOW,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_YELLOW,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action


* Square Lower Fin Main --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #9,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Line Lower fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #7,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #17,        D4       ; Height
         	        
    ; FLIP IT
    JSR FLIP_X
  
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)


* Square Top fin 1 (vertical)  --------------------------------

    ; Set Pixel Colors
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_2_RED,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-8,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Bottom fin 1 (vertical)  --------------------------------

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #18,        D4       ; Height
             	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    JSR     SET_PEN_COLOR
    MOVE.L  #BLACK,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

       ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #2,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height
         	        
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    RTS                             ; Return to subroutine


	RTS


*------------------------
; HEX CODES
*------------------------

PLAYER_2_RED	    	equ	$00095BB3
PLAYER_2_ORANGE	    	equ	$000A80CF
PLAYER_2_GOLD			equ	$0022ABE5
PLAYER_2_YELLOW	    	equ	$0084DEF5
PLAYER_2_FIN   			equ	$00C4EDF5















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
