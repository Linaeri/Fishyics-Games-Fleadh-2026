*-----------------------------------------------------------
* Title      : SBR_DRAW_CLOWNFISH
* Description: 	Output to the screen - clownfish
* Subroutines: (in this order:)

*	DRAW_CLOWNFISH				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------

;	Pass in fish x:					D1
;	Pass fish Y:					D2
; 	Pass fish direction facing:		D3

DRAW_CLOWNFISH:    ; first size fish
 
    MOVE.L  D1,          POS_X    			; Set variable for x position of player or enemy
    MOVE.L  D2,          POS_Y    			; Set variable for x position of player or enemy 
	MOVE.L  D3,          FISH_DIRECTION_X    ; Set variable for enemy facing   (-1 or 1)
    
    MOVEM.L D0-D7/A0-A4, -(A7)   ; Push everything to the stack
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #12,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK DIRECTION TRAVELLNIG IN
    TST.L FISH_DIRECTION_X
    BLT DRAW_CLOWNFISH_LEFT ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_CLOWNFISH_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_CLOWNFISH_LEFT:
   ; MOVE.L #0, IS_FLIPPED

* Square upper fin 1 black -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,     D1          ; Set Fill color
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
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height   

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square upper fin 2 black -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-01,        D4       ; Height
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square upper fin 1 orange -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_RED,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_RED,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-01,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Line upper fin 2 orange -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #09,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square black tail -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square black tail -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
      
* Square tail orange -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_RED,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_RED,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Square body middle -----------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_ORANGE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_ORANGE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Square mouth tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-01,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    

* Square white middle -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square white middle -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
 * Line lower fin black 1 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
      
 * Line lower fin black 1 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line lower fin orange 1 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_RED,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_RED,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
        
* Line white face upper -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #02,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #03,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  

    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
   ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)    
    
* Square white face lower -------------------------------    
     ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  
 
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square white tail base -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
    MOVEM.L (A7)+, D0-D7/A0-A4
    RTS                             ; Return to subroutine    

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_CLOWNFISH_FLIP:

  ;  MOVE.L #1, IS_FLIPPED

* Square upper fin 1 black -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,     D1          ; Set Fill color
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
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-02,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X    

    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square upper fin 2 black -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #13,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-01,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    
* Square upper fin 1 orange -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_RED,     D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_RED,     D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #06,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-01,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Line upper fin 2 orange -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #09,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square black tail -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
* Square black tail -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
      
* Square tail orange -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_RED,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_RED,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #15,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #02,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Square body middle -----------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_ORANGE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_ORANGE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-02,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  
    
    ; FLIP IT
    JSR FLIP_X  
           
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Square mouth tip -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-01,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height  
    
    ; FLIP IT
    JSR FLIP_X  
            
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
    

* Square white middle -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
           
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square white middle -------------------------------    
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
           
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
    
 * Line lower fin black 1 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #04,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #08,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
      
 * Line lower fin black 1 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_BLACK,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Line lower fin orange 1 -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_RED,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_RED,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height
    
    ; FLIP IT
    JSR FLIP_X  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
        
* Line white face upper -------------------------------
    ; Set Pixel Colors
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #CLOWNFISH_WHITE,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #02,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #03,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  
    
    ; FLIP IT
    JSR FLIP_X  
           
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
   ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)    
    
* Square white face lower -------------------------------    
     ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #02,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  
    
    ; FLIP IT
    JSR FLIP_X  
           
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square white tail base -------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #13,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #14,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
    
    ; FLIP IT
    JSR FLIP_X  
           
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)

* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #BLACK,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #BLACK,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height
    
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

CLOWNFISH_WHITE	    equ	$00FCFCF2
CLOWNFISH_ORANGE	equ	$00158AED
CLOWNFISH_RED	    equ	$001269E3
CLOWNFISH_BLACK     equ	$00212838

*~Font name~Courier New~
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
