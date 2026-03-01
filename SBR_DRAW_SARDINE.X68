*-----------------------------------------------------------
* Title      : SBR_DRAW_SARDINE
* Description: 	Output to the screen - sardine
* Subroutines: (in this order:)

*	DRAW_SARDINE				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------

;	Pass in fish x:					D1
;	Pass fish Y:					D2
; 	Pass fish direction facing:		D3

DRAW_SARDINE:    ; first size fish
 
    MOVE.L  D1,          POS_X    			; Set variable for x position of player or enemy
    MOVE.L  D2,          POS_Y    			; Set variable for x position of player or enemy 
	MOVE.L  D3,          FISH_DIRECTION_X   ; Set variable for enemy facing   (-1 or 1)
	
	MOVEM.L D0-D7/A0-A4, -(A7)
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #10,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK DIRECTION TRAVELLNIG IN
    TST.L FISH_DIRECTION_X
    BLT DRAW_SARDINE_LEFT ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_SARDINE_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_SARDINE_LEFT:
   ; MOVE.L #0, IS_FLIPPED   

* Square lower fin tip --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_FINS,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_FINS,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)    
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #05,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square upper fin tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
  
* Square tail -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square body middle -----------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_GREY,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_GREY,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    

* Square mouth tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height
        
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square body top -----------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_DARK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_DARK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,      D1       ; X
    ADD.L   #01,        D1       ; Width
    MOVE.L  POS_Y,      D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,      D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,      D4 
    ADD.L   #01,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

* Square main body -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

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
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	MOVEM.L (A7)+,      D0-D7/A0-A4 ; Stack thingy
    RTS                             ; Return to subroutine

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_SARDINE_FLIP:

  ;  MOVE.L #1, IS_FLIPPED

* Square lower fin tip --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_FINS,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_FINS,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)    
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #05,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
  
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square upper fin tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height
  
    ; FLIP IT
    JSR FLIP_X  
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
  
* Square tail -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height
  
    ; FLIP IT
    JSR FLIP_X  
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square body middle -----------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_GREY,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_GREY,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #11,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  
  
    ; FLIP IT
    JSR FLIP_X  
         
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    

* Square mouth tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height  
  
    ; FLIP IT
    JSR FLIP_X  
          
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square body top -----------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_DARK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_DARK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
      
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,      D1       ; X
    ADD.L   #01,        D1       ; Width
    MOVE.L  POS_Y,      D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,      D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,      D4 
    ADD.L   #01,        D4       ; Height  
  
    ; FLIP IT
    JSR FLIP_X     
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

* Square main body -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SARDINE_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SARDINE_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height  
  
    ; FLIP IT
    JSR FLIP_X  
         
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

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
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height
  
    ; FLIP IT
    JSR FLIP_X  
      
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
	MOVEM.L (A7)+,      D0-D7/A0-A4 ; Stack thingy
    RTS                             ; Return to subroutine

*------------------------
; HEX CODES
*------------------------

SARDINE_WHITE	equ	$00E2DBBD
SARDINE_DARK	equ	$007A5E42
SARDINE_GREY	equ	$00D3BE96
SARDINE_FINS    equ	$00377EC5

*~Font name~Courier New~




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
