*-----------------------------------------------------------
* Title      : SBR_DRAW_ANGELFISH
* Description: 	Output to the screen - angelfish
* Subroutines: (in this order:)

*	DRAW_ANGELFISH				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------

;	Pass in fish x:					D1
;	Pass fish Y:					D2
; 	Pass fish direction facing:		D3

DRAW_ANGELFISH:    ; first size fish
 
    MOVE.L  D1,          POS_X    			; Set variable for x position of player or enemy
    MOVE.L  D2,          POS_Y    			; Set variable for x position of player or enemy 
	MOVE.L  D3,          FISH_DIRECTION_X    ; Set variable for enemy facing   (-1 or 1)
    
    MOVEM.L D0-D7/A0-A4, -(A7)   ; Push everything to the stack
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #45,               D7       ; Set D7 to the Sprite width
    
    ;CHECK DIRECTION TRAVELLNIG IN
    TST.L FISH_DIRECTION_X
    BLT DRAW_ANGELFISH_LEFT ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_ANGELFISH_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_ANGELFISH_LEFT:
   ; MOVE.L #0, IS_FLIPPED
    
* Collision -------------------------------
    ; Set Pixel Colors
    MOVE.L  #LIME,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #LIME,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Line Fin Orange Upper A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)          
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     

* Line Fin Orange Upper B -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #19,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-10,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

* Line Fin Orange Lower A ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #28,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #31,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
    
* Line Fin Orange Lower A ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #30,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Line Fin Tail Up -------------------------------    
    ; Set Pen Width
    MOVE.L  #06,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)          
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #03,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Line Fin Tail Down -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #30,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Line Fin Tail Mid -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)                

* Line Fin Light Lower A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
       
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #27,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Line Fin Light Lower B ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #09,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #27,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Line Fin Light Upper ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #28,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)         
    
* Line Fin Light Lower ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #30,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)         
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action
     
 
* Square Body A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #05,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Square Mouth Base -------------------------------   
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        
      
* Square Mouth Tip A -------------------------------   
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          
          
* Square Mouth Tip B -------------------------------   
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    

* Square Body Light B  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          

* Square Body Light C  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #19,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        
      
* Square Body Light D  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)         

* Square Body Light Tail  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)                  
       
* Square Body Dark A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_BLUE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_BLUE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square Body Dark B -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
 
 * Line Fin Dark Upper A ------------------------------- 
    ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
 
 * Line Fin Dark Upper B ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-11,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     

 * Line Fin Dark Lower A ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #31,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
   
 * Line Fin Dark Lower B ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #30,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action
    
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
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

    MOVEM.L (A7)+, D0-D7/A0-A4
    RTS                             ; Return to subroutine   

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_ANGELFISH_FLIP:

  ;  MOVE.L #1, IS_FLIPPED

* Line Fin Orange Upper A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)          
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     

* Line Fin Orange Upper B -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #19,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-10,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

* Line Fin Orange Lower A ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #28,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #31,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
    
* Line Fin Orange Lower A ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #30,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Line Fin Tail Up -------------------------------    
    ; Set Pen Width
    MOVE.L  #06,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)          
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #36,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #03,        D4       ; Height 
                 
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Line Fin Tail Down -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #30,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #35,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Line Fin Tail Mid -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #33,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height 
                 
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)                

* Line Fin Light Lower A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
       
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #27,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Line Fin Light Lower B ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #09,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #27,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Line Fin Light Upper ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #28,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height 
                 
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)         
    
* Line Fin Light Lower ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #30,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)         
    
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action
     
 
* Square Body A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_WHITE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #05,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Square Mouth Base -------------------------------   
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        
      
* Square Mouth Tip A -------------------------------   
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          
          
* Square Mouth Tip B -------------------------------   
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    

* Square Body Light B  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          

* Square Body Light C  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #19,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        
      
* Square Body Light D  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #23,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #24,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)         

* Square Body Light Tail  -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)                  
       
* Square Body Dark A ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #ANGELFISH_BLUE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #ANGELFISH_BLUE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square Body Dark B -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
 
 * Line Fin Dark Upper A ------------------------------- 
    ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
 
 * Line Fin Dark Upper B ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-11,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     

 * Line Fin Dark Lower A ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #20,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #31,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
   
 * Line Fin Dark Lower B ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #30,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      

    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action
    
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
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
    MOVEM.L (A7)+,      D0-D7/A0-A4
    RTS                             ; Return to subroutine    

*------------------------
; HEX CODES
*------------------------

ANGELFISH_ORANGE	EQU	$00689DD9
ANGELFISH_WHITE		EQU	$00DED5BF
ANGELFISH_BLUE		EQU	$004D2E2B

*~Font name~Courier New~








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
