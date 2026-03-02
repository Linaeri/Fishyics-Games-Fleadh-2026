*-----------------------------------------------------------
* Title      : SBR_DRAW_PELICAN
* Description: 	Output to the screen - pelican
* Subroutines: (in this order:)

*	DRAW_PELICAN				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------

;	Pass in fish x:					D1
;	Pass fish Y:					D2
; 	Pass fish direction facing:		D3

DRAW_PELICAN:    ; first size fish
    CMP.L   #1, PELICAN_ACTIVE
    BNE     DRAW_DONE
    
    MOVE.L  PELICAN_X,          POS_X    			; Set variable for x position of player or enemy
    MOVE.L  PELICAN_Y,          POS_Y    			; Set variable for x position of player or enemy 
	MOVE.L  PELICAN_DIR,        FISH_DIRECTION_X    ; Set variable for enemy facing   (-1 or 1)
    
    MOVEM.L D0-D7/A0-A4, -(A7)   ; Push everything to the stack
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #24,               D7       ; Set D7 to the Sprite width
    
    ;CHECK DIRECTION TRAVELLNIG IN
    TST.L FISH_DIRECTION_X
    BLT DRAW_PELICAN_LEFT ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_PELICAN_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PELICAN_LEFT:
   ; MOVE.L #0, IS_FLIPPED

* Square Wing Dark A1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
 
* Square Wing Dark A2 -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
   
* Square Wing Dark A3 -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Line  Wing Dark A4 -------------------------------
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-17,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Line Leg ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #22,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)   
 
* Square Beak A1 -------------------------------     
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
* Square Beak A2 ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-11,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
* Square Beak A3 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)           

* Square Body A1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_WHITE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          

* Square Body A2 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

* Square Tail A1 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square Tail A2 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square Wing A1 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-08,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       

* Square Wing A2 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-04,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square Body Shadow A1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_GREY,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_GREY,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square Body Shadow A1 -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)             
    
* Square Beak Upper ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_BEAK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_BEAK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
    
* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

    MOVEM.L (A7)+, D0-D7/A0-A4
    RTS                             ; Return to subroutine    

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PELICAN_FLIP:

  ;  MOVE.L #1, IS_FLIPPED

* Square Wing Dark A1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
 
* Square Wing Dark A2 -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
   
* Square Wing Dark A3 -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Line  Wing Dark A4 -------------------------------
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #12,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-17,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Line Leg ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #22,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)   
 
* Square Beak A1 -------------------------------     
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
 
* Square Beak A2 ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-11,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
* Square Beak A3 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)           

* Square Body A1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_WHITE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          

* Square Body A2 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

* Square Tail A1 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square Tail A2 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #30,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square Wing A1 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-08,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       

* Square Wing A2 -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #17,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-04,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square Body Shadow A1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_GREY,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_GREY,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square Body Shadow A1 -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)             
    
* Square Beak Upper ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #PELICAN_BEAK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #PELICAN_BEAK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #06,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
   
    MOVEM.L (A7)+,      D0-D7/A0-A4
    RTS                             ; Return to subroutine 

DRAW_DONE:
    RTS   

*------------------------
; HEX CODES
*------------------------
PELICAN_WHITE		equ	$00E3F4FF
PELICAN_BLACK		equ	$00474442
PELICAN_ORANGE		equ	$003DADF2
PELICAN_BEAK		equ	$0031C7F5
PELICAN_GREY		equ	$00CCD6DB

*~Font name~Courier New~






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
