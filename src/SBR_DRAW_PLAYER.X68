*-----------------------------------------------------------
* Title      : SBR_DRAW_PLAYER
* Description: 	Output to the screen - text and image
* Subroutines: (in this order:)

*	DRAW_PLAYER				; Draw Player sprite

*  Data:	Colour HEX codes as named constants
*-----------------------------------------------------------
; FLIP STATE
IS_FLIPPED  DS.L    01  ; SAVES CURRENT FACING

*-----------------------------------------------------------
* Subroutine    : Draw Player
* Description   : Draw Player by layering Rectangles, Elipsis and Lines
*-----------------------------------------------------------
DRAW_PLAYER:
;	BRA	DRAW_SKELETON			;============================ debug, draw player 1
;	BRA	DRAW_3			;============================ debug, draw player 1

    ;check player size stage
	; Stage 0
    CMP.L   #0, PLAYER_SIZE
    BEQ     DRAW_PLYR_ORIGINAL

	; Stage 1
 	CMP.L   #1, PLAYER_SIZE
    BEQ     DRAW_1
	
	; Stage 2
 	CMP.L   #2, PLAYER_SIZE
    BEQ     DRAW_2

	; Stage 3
 	CMP.L   #3, PLAYER_SIZE
    BEQ     DRAW_3

	; Stage 4
 	CMP.L   #4, PLAYER_SIZE
    BEQ     DRAW_4

	; Stage 5
 	CMP.L   #5, PLAYER_SIZE
    BEQ     DRAW_5

	; Stage 6
 	CMP.L   #6, PLAYER_SIZE
    BEQ     DRAW_6


    BRA     DRAW_PLYR_SIMPLE

DRAW_1:
	JSR	DRAW_PLAYER_1
	RTS

DRAW_2:
	JSR	DRAW_PLAYER_2
	RTS

DRAW_3:
	JSR	DRAW_PLAYER_3
	RTS

DRAW_4:
	JSR	DRAW_PLAYER_4
	RTS

DRAW_5:
	JSR	DRAW_PLAYER_5
	RTS

DRAW_6:
	JSR	DRAW_PLAYER_6
	RTS

DRAW_PLYR_ORIGINAL:
    MOVE.L  PLAYER_X,          POS_X    ; Set variable for x position of player or enemy
    MOVE.L  PLAYER_Y,          POS_Y    ; Set variable for x position of player or enemy    
    
    MOVE.L  PLYR_W_INIT,       D5 
    MOVE.L  #14,               D7       ; Set D7 to the Sprite width(21)
    
    ;CHECK LAST STATE
    TST.L IS_FLIPPED
    BEQ  WAS_LEFT    ; 
    BGT WAS_FLIP    ; WAS flipped

    
WAS_LEFT:

    TST.L PLYR_DIRECTION_X
    BLE DRAW_PLYR_LEFT ; DRAW LEFT IF MOVING LEFT 
    BGT DRAW_PLYR_FLIP  ; STAY FLIPPED IF PLAYER NOT MOVING  

    RTS  

WAS_FLIP:
    TST.L PLYR_DIRECTION_X  ; Direction will be -1, 0 or 1 (left, not moving, right)
    BGE DRAW_PLYR_FLIP 
    BLT  DRAW_PLYR_LEFT   ; draw flipped
    
    RTS


*-----------------------------------------------------------
* Subroutine    : Draw Player Facing Left (Not Flipped)
* Description   : Flip the Player Draw
*-----------------------------------------------------------
DRAW_PLYR_LEFT:
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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_YELLOW,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    JSR     SET_PEN_COLOR
    MOVE.L  #BLACK,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
DRAW_PLYR_FLIP:

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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_FIN,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR
    
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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_GOLD,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_ORANGE,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_0_YELLOW,  D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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
    JSR     SET_PEN_COLOR
    MOVE.L  #BLACK,               D1          ; Set Fill color
    JSR     SET_FILL_COLOR

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

*-----------------------------------------------------------
* Subroutine    : Draw Player Simple Rectangle
* Description   : Temporary simple draw based on PLAYER_SIZE
*-----------------------------------------------------------
DRAW_PLYR_SIMPLE:
    MOVE.L  PLAYER_X,          POS_X
    MOVE.L  PLAYER_Y,          POS_Y

    ;body colour
    MOVE.L  #PLAYER_LIGHTGOLD, D1
    JSR     SET_PEN_COLOR
    MOVE.L  #PLAYER_LIGHTGOLD, D1
    JSR     SET_FILL_COLOR

    ;body rectangle using current size
    MOVE.L  PLAYER_X, D1
    MOVE.L  PLAYER_Y, D2
    MOVE.L  PLAYER_X, D3
    ADD.L   PLYR_W_CURRENT, D3
    MOVE.L  PLAYER_Y, D4
    ADD.L   PLYR_H_CURRENT, D4
    MOVE.B  #87, D0
    TRAP    #15

    ;eye
    MOVE.L  #BLACK, D1
    JSR     SET_PEN_COLOR
    MOVE.L  #BLACK, D1
    JSR     SET_FILL_COLOR

    MOVE.L  PLAYER_X, D1
    ADD.L   #1, D1
    MOVE.L  PLAYER_Y, D2
    ADD.L   #2, D2
    MOVE.L  PLAYER_X, D3
    ADD.L   #3, D3
    MOVE.L  PLAYER_Y, D4
    ADD.L   #4, D4
    MOVE.B  #87, D0
    TRAP    #15

    RTS

; flash effect data
FLASH_TIMER     DS.L    1
FLASH_STATE     DS.L    1       ; 1 = white, 0 = normal
FLASH_COUNT     DS.L    1
FLASH_DURATION  EQU     10
FLASH_BLINKS    EQU     4

; call these instead of trap 80/81 in player draw routines
SET_PEN_COLOR:
    TST.L   FLASH_STATE
    BEQ     .SPC_OK
    MOVE.L  #$00FFFFFF, D1      ; override to white
.SPC_OK:
    MOVE.B  #80, D0
    TRAP    #15
    RTS

SET_FILL_COLOR:
    TST.L   FLASH_STATE
    BEQ     .SFC_OK
    MOVE.L  #$00FFFFFF, D1      ; override to white
.SFC_OK:
    MOVE.B  #81, D0
    TRAP    #15
    RTS
    
UPDATE_FLASH:
    TST.L   FLASH_COUNT
    BEQ     .UF_DN
    MOVE.L  DELTA_TIME, D0
    SUB.L   D0, FLASH_TIMER
    TST.L   FLASH_TIMER
    BGT     .UF_DN
    TST.L   FLASH_STATE
    BEQ     .UF_ON
    MOVE.L  #0, FLASH_STATE
    BRA     .UF_NEXT
.UF_ON:
    MOVE.L  #1, FLASH_STATE
.UF_NEXT:
    MOVE.L  #FLASH_DURATION, FLASH_TIMER
    SUB.L   #1, FLASH_COUNT
    TST.L   FLASH_COUNT
    BNE     .UF_DN
    MOVE.L  #0, FLASH_STATE     ; force back to normal when done
.UF_DN:
    RTS

*------------------------
; HEX CODES
*------------------------

PLAYER_0_ORANGE	    	equ	$000B99DB
PLAYER_0_GOLD			equ	$0023C7E8
PLAYER_0_YELLOW	    	equ	$0091D3D4
PLAYER_0_FIN   			equ	$00C0E3E0


*----------------------------------
	include "SBR_DRAW_PLAYER_1.X68"		; player sprite 1
	include "SBR_DRAW_PLAYER_2.X68"		; player sprite 2
	include "SBR_DRAW_PLAYER_3.X68"		; player sprite 3
	include "SBR_DRAW_PLAYER_4.X68"		; player sprite 4
	include "SBR_DRAW_PLAYER_5.X68"		; player sprite 5
	include "SBR_DRAW_PLAYER_6.X68"		; player sprite 6













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
