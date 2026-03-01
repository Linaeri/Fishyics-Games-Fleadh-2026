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
    DS.W    0           ;fix alignment issue
DRAW_SKELETON:    ; Size = 1
 
    MOVE.L  PLAYER_X,          POS_X    ; Set variable for x position of player or enemy
    MOVE.L  PLAYER_Y,          POS_Y    ; Set variable for x position of player or enemy    
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #27,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK LAST STATE
    TST.L IS_FLIPPED
    BEQ  WAS_LEFT_S    ; 
    BGT WAS_FLIP_S    ; WAS flipped

    
WAS_LEFT_S:

    TST.L PLYR_DIRECTION_X
    BLE DRAW_PLYR_LEFT_S ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_PLYR_FLIP_S  ; STAY FLIPPED IF PLAYER NOT MOVING  

    RTS  

WAS_FLIP_S:
    TST.L PLYR_DIRECTION_X  ; Direction will be -1, 0 or 1 (left, not moving, right)
    BGE DRAW_PLYR_FLIP_S 
    BLT  DRAW_PLYR_LEFT_S   ; draw flipped
    
    RTS


*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_LEFT_S:
    MOVE.L #0, IS_FLIPPED
    
    ; Set Pixel Colors
    MOVE.L  #SKELETON_LIGHT,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SKELETON_LIGHT,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* WHITE PARTS ------------------------------
* Square Spine  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Base --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #25,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Upper 1 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #4,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Upper 2 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #3,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Lower 1 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #15,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Upper 2 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #15,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 1 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #6,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #8,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 2 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 3 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #2,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 4 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #4,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 1 Bottom   --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #6,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #8,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 2 Bottom  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 3 Bottom  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 4 Bottom --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head 1 (rightmost)  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #3,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head 2 --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head 3 --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-6,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #11,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head detail top --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #4,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #2,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head detail bottom  --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #4,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action




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
    ADD.L   #-2,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #1,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #7,        D4       ; Height
    
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action)
    RTS                             ; Return to subroutine


	RTS

*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Right (Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_FLIP_S:

    MOVE.L #1, IS_FLIPPED

 ; Set Pixel Colors
    MOVE.L  #SKELETON_LIGHT,  D1          ; Set Pen color
    MOVE.B  #80,                D0          ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SKELETON_LIGHT,  D1          ; Set Fill color
    MOVE.B  #81,                D0          ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
  ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action) 

	; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* WHITE PARTS ------------------------------
* Square Spine  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #22,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #9,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Base --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #22,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #25,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Upper 1 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #4,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Upper 2 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #1,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #3,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Lower 1 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #24,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #11,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #27,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #15,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Tail Upper 2 --------------------------------

; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #27,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #13,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #29,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #15,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 1 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #6,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #8,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 2 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #0,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 3 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #2,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 4 Top  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #7,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #4,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 1 Bottom   --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #6,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #8,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 2 Bottom  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #10,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #12,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 3 Bottom  --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #14,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #16,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Spine 4 Bottom --------------------------------
 
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #18,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #9,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #20,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #12,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #84,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head 1 (rightmost)  --------------------------------

	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #0,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #3,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head 2 --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #2,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #0,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #14,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head 3 --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #-4,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #5,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #-6,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #11,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head detail top --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #0,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #4,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #2,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action

* Square Head detail bottom  --------------------------------
	; Set X, Y, Width and Height
    MOVE.L  POS_X,   D1       ; X
    ADD.L   #3,        D1       ; Width
    MOVE.L  PLAYER_Y,   D2       ; Y
    ADD.L   #14,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #4,        D3       ; Width
    MOVE.L  PLAYER_Y,   D4 
    ADD.L   #16,        D4       ; Height
           
    ; FLIP IT
    JSR FLIP_X
  
    ; Draw Player
    MOVE.B  #87,        D0          ; Draw Player
    TRAP    #15                     ; Trap (Perform action




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
    ADD.L   #-2,        D1       ; Width
    MOVE.L  POS_Y,   D2       ; Y
    ADD.L   #4,        D2       ; Height
    MOVE.L  POS_X,   D3  
    ADD.L   #1,        D3       ; Width
    MOVE.L  POS_Y,   D4 
    ADD.L   #7,        D4       ; Height
           
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

SKELETON_LIGHT	    	equ	$00F5E9EC
SKELETON_PURPLE	    	equ	$009C898E
SKELETON_DARK	    	equ	$00665F60











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
