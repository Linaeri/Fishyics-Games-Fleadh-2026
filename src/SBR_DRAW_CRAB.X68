*-----------------------------------------------------------
* Title      : SBR_DRAW_CRAB
* Description: 	Output to the screen - crab
* Subroutines: (in this order:)

*	DRAW_CRAB				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------

;	Pass in fish x:					D1
;	Pass fish Y:					D2
; 	Pass fish direction facing:		D3

DRAW_CRAB:    ; first size fish
 
    MOVE.L  D1,          POS_X    			; Set variable for x position of player or enemy
    MOVE.L  D2,          POS_Y    			; Set variable for x position of player or enemy 
	MOVE.L  D3,          FISH_DIRECTION_X    ; Set variable for enemy facing   (-1 or 1)
    
    MOVEM.L D0-D7/A0-A4, -(A7)   ; Push everything to the stack
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #24,               D7       ; Set D7 to the Sprite width
    
    ;CHECK DIRECTION TRAVELLNIG IN
    TST.L FISH_DIRECTION_X
    BLT DRAW_CRAB_LEFT ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_CRAB_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_CRAB_LEFT:
   ; MOVE.L #0, IS_FLIPPED
    
* Line arm orange left ------------------------------- 
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)  
    ; Set Pixel Colors
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Line arm orange right -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Line leg behind left ------------------------------- 
    ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)  
    ; Set Pixel Colors
    MOVE.L  #CRAB_LEGDARK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_LEGDARK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     

* Line leg behind right -------------------------------     
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)           
        
* Line leg front left -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CRAB_LEG,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_LEG,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Line leg front right ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
       
    ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)    

* Square legs  -------------------------------     
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #25,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #25,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #27,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
 
* Square belly upper ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BELLY,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BELLY,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #24,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square belly lower ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BELLY,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BELLY,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #25,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #27,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
        
    
* Square shell orange left ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #10,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
  
* Square shell orange right ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
    
* Square shell orange upper ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Square shell dark upper ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
  
* Square shell red left ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_RED,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_RED,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Square shell red right ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Square shell red upper ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Square arm red left -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #01,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm red right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #28,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm dark outer left -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CRAB_DARK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_DARK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm dark outer right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm dark inner left -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm dark inner right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm tip outer left ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action) 
  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm tip outer right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm tip inner left -------------------------------    
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
    
* Square arm tip inner right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
    
* Square arm final tip left ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm final tip right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
    
* square eye black left -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* square eye black right -------------------------------  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    

    MOVEM.L (A7)+, D0-D7/A0-A4
    RTS                             ; Return to subroutine    

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_CRAB_FLIP:

  ;  MOVE.L #1, IS_FLIPPED
    
* Line arm orange left ------------------------------- 
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)  
    ; Set Pixel Colors
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Line arm orange right -------------------------------    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Line leg behind left ------------------------------- 
    ; Set Pen Width
    MOVE.L  #03,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)  
    ; Set Pixel Colors
    MOVE.L  #CRAB_LEGDARK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_LEGDARK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     

* Line leg behind right -------------------------------     
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)           
        
* Line leg front left -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CRAB_LEG,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_LEG,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #33,        D4       ; Height 
             
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Line leg front right ------------------------------- 
; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
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
    TRAP    #15                 ; Trap (Perform action)    

* Square legs  -------------------------------     
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #25,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #25,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #27,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
 
* Square belly upper ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BELLY,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BELLY,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #24,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  

* Square belly lower ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BELLY,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BELLY,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #25,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #27,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
    
* Square shell orange left ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_ORANGE,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #10,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
  
* Square shell orange right ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #17,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
    
* Square shell orange upper ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #06,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #15,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Square shell dark upper ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
  
* Square shell red left ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_RED,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_RED,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Square shell red right ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #21,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Square shell red upper ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 

* Square arm red left -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #01,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm red right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #28,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #17,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm dark outer left -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CRAB_DARK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_DARK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm dark outer right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm dark inner left -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm dark inner right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm tip outer left ------------------------------- 
    ; Set Pixel Colors
    MOVE.L  #CRAB_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CRAB_BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action) 
  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm tip outer right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
* Square arm tip inner left -------------------------------    
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
    
* Square arm tip inner right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #23,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #04,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
    
* Square arm final tip left ------------------------------- 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square arm final tip right -------------------------------    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #26,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
    
* square eye black left -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
          
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* square eye black right -------------------------------  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
 
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

CRAB_DARK	    equ	$00010356
CRAB_RED	    equ	$000B41BF
CRAB_BLACK      equ $0006207D
CRAB_ORANGE	    equ	$002B64EB
CRAB_LEG	    equ	$003F8DE0
CRAB_LEGDARK	equ	$003475BA
CRAB_BELLY	    equ	$0056A0F0

*~Font name~Courier New~



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
