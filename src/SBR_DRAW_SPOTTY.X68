*-----------------------------------------------------------
* Title      : SBR_DRAW_SPOTTY
* Description: 	Output to the screen - spotty
* Subroutines: (in this order:)

*	DRAW_SPOTTY				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------

;	Pass in fish x:					D1
;	Pass fish Y:					D2
; 	Pass fish direction facing:		D3

DRAW_SPOTTY:    ; first size fish
 
    MOVE.L  D1,          POS_X    			; Set variable for x position of player or enemy
    MOVE.L  D2,          POS_Y    			; Set variable for x position of player or enemy 
	MOVE.L  D3,          FISH_DIRECTION_X    ; Set variable for enemy facing   (-1 or 1)
    
    MOVEM.L D0-D7/A0-A4, -(A7)   ; Push everything to the stack
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #24,               D7       ; Set D7 to the Sprite width
    
    ;CHECK DIRECTION TRAVELLNIG IN
    TST.L FISH_DIRECTION_X
    BLT DRAW_SPOTTY_LEFT ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_SPOTTY_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_SPOTTY_LEFT:
   ; MOVE.L #0, IS_FLIPPED
    
* Square fin upper -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_MID,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_MID,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
;    TRAP    #15                     ; Trap (Perform action)     
 
* Square tail A ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #31,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
   
* Line tail lower ------------------------------- 
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)       
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
* Line tail upper ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height      
 
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Line lower fin 2 ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Line fin upper ------------------------------- 
; Set X, Y, Width and Height
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-03,        D4       ; Height  
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)         
 
* Square body main -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_RED,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_RED,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
* Square body belly -------------------------------  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
* Square body mid -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
        
* Square mouth Base -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-03,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square mouth mid -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-05,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
        
* Square mouth tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Square Dark Spots Left top -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_DARK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_DARK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #01,        D4       ; Height  

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square Dark Spots Left -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #03,        D4       ; Height  

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square Dark Spots Top Right -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #19,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Circle Dark Spots A -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #09,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #88,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        

* Square Dark Spots B -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          
    
* Line lower fin 1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_MID,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_MID,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)       
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)         
    
* Circle eye white -------------------------------
    ; Set Pixel Colors
    MOVE.L  #WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #03,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #88,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

    MOVEM.L (A7)+, D0-D7/A0-A4
    RTS                             ; Return to subroutine    

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_SPOTTY_FLIP:

  ;  MOVE.L #1, IS_FLIPPED

* Square fin upper -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_MID,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_MID,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
;    TRAP    #15                     ; Trap (Perform action)     
 
* Square tail A ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #31,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
   
* Line tail lower ------------------------------- 
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)       
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #32,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height 
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
* Line tail upper ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height      
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Line lower fin 2 ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height 
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Line fin upper ------------------------------- 
; Set X, Y, Width and Height
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-03,        D4       ; Height  
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)         
 
* Square body main -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_RED,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_RED,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
* Square body belly -------------------------------  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
* Square body mid -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
        
* Square mouth Base -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-03,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square mouth mid -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-05,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
        
* Square mouth tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Square Dark Spots Left top -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_DARK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_DARK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #01,        D4       ; Height  
        
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square Dark Spots Left -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #03,        D4       ; Height  
        
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square Dark Spots Top Right -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #19,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Circle Dark Spots A -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #09,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #88,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        

* Square Dark Spots B -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          
    
* Line lower fin 1 ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #SPOTTY_MID,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SPOTTY_MID,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)       
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height 
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)         
    
* Circle eye white -------------------------------
    ; Set Pixel Colors
    MOVE.L  #WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #03,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height   
         
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #88,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

    MOVEM.L (A7)+,      D0-D7/A0-A4
    RTS                             ; Return to subroutine    

*------------------------
; HEX CODES
*------------------------

SPOTTY_DARK	equ	$00221361
SPOTTY_RED	equ	$001F24CC
SPOTTY_MID	equ	$0018228F

*~Font name~Courier New~

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
