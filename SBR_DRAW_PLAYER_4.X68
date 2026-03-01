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
DRAW_PLAYER_4:    ; Size = 1
 
    MOVE.L  PLAYER_X,          POS_X    ; Set variable for x position of player or enemy
    MOVE.L  PLAYER_Y,          POS_Y    ; Set variable for x position of player or enemy    
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #14,               D7       ; Set D7 to the Sprite width(21)
    
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
    
* Collision Box Visualisation    --------------------------------------------
    ; Set Pixel Colors
;    MOVE.L  #RED,               D1          ; Set pen color
;    MOVE.B  #80,                D0          ; Task for Background Color
;    TRAP    #15                             ; Trap (Perform action)
;    MOVE.L  #RED,               D1          ; Set Fill color
;    MOVE.B  #81,                D0          ; Task for Fill Color
;    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
;    MOVE.L  POS_X,       D1      ; X
;    MOVE.L  PLAYER_Y,       D2      ; Y
;    MOVE.L  POS_X,       D3
;    ADD.L   #14,   D3      ; Width
;    MOVE.L  PLAYER_Y,       D4 
;    ADD.L   #10,   D4      ; Height
    
    ; Draw Player
;    MOVE.B  #87,        D0          ; Draw Player
;    TRAP    #15                     ; Trap (Perform action)

* Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #2,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #6,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-3,        D4       ; Height

	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	
	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Square Bottom fin  --------------------------------

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #6,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail fin  --------------------------------

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Nose  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #5,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body Base --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #5,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body Base Extra --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #8,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #10,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square top banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #10,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #2,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square bottom banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_YELLOW,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_YELLOW,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #8,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Circle eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #03,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    RTS                             ; Return to subroutine


	RTS

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_FLIP_4:

    MOVE.L #1, IS_FLIPPED
* Collision Box Visualisation    --------------------------------------------
    ; Set Pixel Colors
;    MOVE.L  #RED,               D1          ; Set pen color
;    MOVE.B  #80,                D0          ; Task for Background Color
;    TRAP    #15                             ; Trap (Perform action)
;    MOVE.L  #RED,               D1          ; Set Fill color
;    MOVE.B  #81,                D0          ; Task for Fill Color
;    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
;    MOVE.L  POS_X,       D1      ; X
;    MOVE.L  PLAYER_Y,       D2      ; Y
;    MOVE.L  POS_X,       D3
;    ADD.L   #14,   D3      ; Width
;    MOVE.L  PLAYER_Y,       D4 
;    ADD.L   #10,   D4      ; Height
    
    ; Draw Player
;    MOVE.B  #87,        D0          ; Draw Player
;    TRAP    #15                     ; Trap (Perform action)

   * Line Upper fin  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_FIN,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_FIN,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #2,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #6,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #-3,        D4       ; Height
	        
    ; FLIP IT
    JSR FLIP_X
    
	  ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Square Bottom fin  --------------------------------

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #6,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height
	        
    ; FLIP IT
    JSR FLIP_X
        
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail fin  --------------------------------

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #-3,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height
	        
    ; FLIP IT
    JSR FLIP_X
        
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Nose  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #5,        D4       ; Height
 	        
    ; FLIP IT
    JSR FLIP_X
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body Base --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #5,        D4       ; Height
	        
    ; FLIP IT
    JSR FLIP_X
        
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Body Base Extra --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #8,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #10,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height

      ; FLIP IT
    JSR FLIP_X
      
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action
	        

* Square top banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #10,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #2,        D4       ; Height
	        
    ; FLIP IT
    JSR FLIP_X
        
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square bottom banner  --------------------------------
    ; Set Pixel Colors
    MOVE.L  #PLAYER_0_YELLOW,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PLAYER_0_YELLOW,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #8,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #7,        D4       ; Height
    	        
    ; FLIP IT
    JSR FLIP_X
   
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action
 
* Circle eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #03,        D4       ; Height

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

PLAYER_4_ORANGE	    	equ	$000B99DB
PLAYER_4_GOLD			equ	$0023C7E8
PLAYER_4_YELLOW	    	equ	$0091D3D4
PLAYER_4_FIN   			equ	$00C0E3E0











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
