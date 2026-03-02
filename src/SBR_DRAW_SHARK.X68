*-----------------------------------------------------------
* Title      : SBR_DRAW_SHARK
* Description: 	Output to the screen - shark
* Subroutines: (in this order:)

*	DRAW_SHARK				; Draw Player sprite
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------

;	Pass in fish x:					D1
;	Pass fish Y:					D2
; 	Pass fish direction facing:		D3

DRAW_SHARK:    ; first size fish
 
    MOVE.L  D1,          POS_X    			; Set variable for x position of player or enemy
    MOVE.L  D2,          POS_Y    			; Set variable for x position of player or enemy 
	MOVE.L  D3,          FISH_DIRECTION_X    ; Set variable for enemy facing   (-1 or 1)
    
    MOVEM.L D0-D7/A0-A4, -(A7)   ; Push everything to the stack
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #70,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK DIRECTION TRAVELLNIG IN
    TST.L FISH_DIRECTION_X
    BLT DRAW_SHARK_LEFT  ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_SHARK_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_SHARK_LEFT:
   ; MOVE.L #0, IS_FLIPPED
        
* Square tail section -----------------------            
*----- Square tail light base ---------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_FINS,    D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_FINS,    D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #94,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #98,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square tail light upper A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #97,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #101,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        
*----- Square tail light upper B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #101,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #103,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-01,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square tail lower ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #98,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #100,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
          
*----- Square tail dark A ---------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_FINSDARK,    D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_FINSDARK,    D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)2

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #87,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #92,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
*----- Square tail dark B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #90,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #93,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          
*----- Square tail dark C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #90,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #95,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Square body GREY section ----------------------- 
*----- Square body grey, nose tip --------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_GREY,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_GREY,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
*----- Square body grey, nose base --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, mouth upper --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square body grey, mouth lower --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, body A --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #50,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
*----- Square body grey, body B --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #50,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #66,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, body C --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #66,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body grey, tail A --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #74,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, tail B --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #78,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, tail C --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #84,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body grey, tail tip --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #89,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Square body BLACK section -----------------------    
*----- Square body black, nose tip --------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_BLACK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_BLACK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
*----- Square body black, nose mid --------*  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, nose base --------*  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, eye ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
*----- Square body black, above gills ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square body black, gills A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, gills B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, gills C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
*----- Square body black, arm A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #37,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, arm B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
*----- Square body black, arm C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
*----- Square body black, arm D ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #31,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #23,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #41,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #26,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square body black, arm F ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #45,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #29,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, arm E ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #42,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #29,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #51,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #30,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, mid A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #37,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #61,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, mid B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #61,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #69,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, mid C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #69,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #78,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, mid D ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #89,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square black, upper fin A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #56,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height      
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
*----- Square black, upper fin B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #45,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
*----- Square black, upper fin C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #43,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-03,        D4       ; Height  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
*----- Square black, upper fin D ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-06,        D4       ; Height  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
*----- Square black, upper fin E ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #35,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
*----- Square black, upper fin F ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #39,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #48,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-11,        D4       ; Height  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square black, upper fin G ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #43,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #50,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-13,        D4       ; Height  
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SHARK_EYE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_EYE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
    MOVEM.L (A7)+,      D0-D7/A0-A4 ; PLACE BEFORE LAST FLIP RTS
    RTS                             ; Return to subroutine    

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_SHARK_FLIP:

  ;  MOVE.L #1, IS_FLIPPED
      
* Square tail section -----------------------            
*----- Square tail light base ---------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_FINS,    D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_FINS,    D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #94,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-05,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #98,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square tail light upper A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #97,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #101,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #05,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)        
*----- Square tail light upper B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #101,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #103,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-01,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square tail lower ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #98,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #12,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #100,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
          
*----- Square tail dark A ---------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_FINSDARK,    D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_FINSDARK,    D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)2

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #87,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #92,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
*----- Square tail dark B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #90,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #93,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)          
*----- Square tail dark C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #90,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #95,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
    
* Square body GREY section ----------------------- 
*----- Square body grey, nose tip --------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_GREY,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_GREY,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
             
    ; FLIP IT
    JSR FLIP_X
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
*----- Square body grey, nose base --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, mouth upper --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #10,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square body grey, mouth lower --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #00,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #18,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #09,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, body A --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #50,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #21,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
*----- Square body grey, body B --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #50,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #66,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #20,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, body C --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #66,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #70,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #18,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body grey, tail A --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #74,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #16,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, tail B --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #78,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #14,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body grey, tail C --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #84,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
             
    ; FLIP IT
    JSR FLIP_X
       
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body grey, tail tip --------* 
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #89,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
    
* Square body BLACK section -----------------------    
*----- Square body black, nose tip --------*
    ; Set Pixel Colors
    MOVE.L  #SHARK_BLACK,      D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_BLACK,      D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-11,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #08,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
*----- Square body black, nose mid --------*  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-08,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #08,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, nose base --------*  
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-05,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #04,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #00,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, eye ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-01,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #07,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #11,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
*----- Square body black, above gills ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #19,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square body black, gills A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #07,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, gills B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #15,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, gills C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #17,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #18,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
*----- Square body black, arm A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #20,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #37,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #15,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, arm B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #25,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #16,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #38,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #19,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
*----- Square body black, arm C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #28,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #19,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #39,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #23,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)     
*----- Square body black, arm D ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #31,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #23,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #41,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #26,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)    
*----- Square body black, arm F ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #36,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #26,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #45,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #29,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, arm E ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #42,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #29,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #51,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #30,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, mid A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #37,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #61,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #13,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)  
*----- Square body black, mid B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #61,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #00,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #69,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #12,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, mid C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #69,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #02,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #78,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #10,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square body black, mid D ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #70,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #89,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #07,        D4       ; Height  
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square black, upper fin A ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #16,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-01,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #56,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height      
               
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
*----- Square black, upper fin B ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-03,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #45,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #00,        D4       ; Height  
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
*----- Square black, upper fin C ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #29,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-06,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #43,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-03,        D4       ; Height  
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)      
*----- Square black, upper fin D ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #32,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-09,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #44,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-06,        D4       ; Height  
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action) 
*----- Square black, upper fin E ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #35,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #46,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-09,        D4       ; Height  
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)       
*----- Square black, upper fin F ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #39,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #48,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-11,        D4       ; Height  
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   
*----- Square black, upper fin G ---------*
    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #43,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #-14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #50,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #-13,        D4       ; Height  
            
    ; FLIP IT
    JSR FLIP_X
     
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)   

* Square eye -------------------------------
    ; Set Pixel Colors
    MOVE.L  #SHARK_EYE,       D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SHARK_EYE,               D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)

    ; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #03,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #07,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #04,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #09,        D4       ; Height
        
    ; FLIP IT
    JSR FLIP_X
         
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    
    MOVEM.L (A7)+,      D0-D7/A0-A4 ; PLACE BEFORE LAST FLIP RTS
    RTS                             ; Return to subroutine    

*------------------------
; HEX CODES
*------------------------

SHARK_GREY	        equ	$00473A39
SHARK_BLACK	        equ	$00211A1A
SHARK_FINS          equ	$00133A9D
SHARK_FINSMID       equ	$001D3899
SHARK_FINSDARK	    equ	$001E2B57
SHARK_EYE	        equ	$000000AD

*~Font name~Courier New~




















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
