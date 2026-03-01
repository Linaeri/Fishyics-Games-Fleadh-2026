*-----------------------------------------------------------
* Title      : SBR_PLYR_MOVEMENT	
* Description: Does all player movement for this cycle
* Subroutines: (in this order:)


* 	Setting Swim Direction	; WASD sets D3/D4 to -1, 0 or 1
*	PLAYER_MOVEMENT			; uses D3/D4 to accelerate, applies drag when idle, caps speed
*	CLAMP_PLAYER			; pushes player back if they go past screen edges
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutines    : Setting player swim directions (x and y heading)
* Description   : Set and clear subroutines
*-----------------------------------------------------------
SET_SWIM_UP:
    MOVE.L  #-1, PLYR_DIRECTION_Y   ; set swim direction to UP
    RTS

SET_SWIM_DOWN:
	MOVE.L  #1, PLYR_DIRECTION_Y   ; set swim direction to DOWN
    RTS

SET_SWIM_LEFT:
    MOVE.L  #-1, PLYR_DIRECTION_X   ; set swim direction to  LEFT
    RTS

SET_SWIM_RIGHT:
	MOVE.L  #1, PLYR_DIRECTION_X   ; set swim direction to RIGHT
    RTS

CLEAR_SWIM_VERTICAL:
	MOVE.L  #0, PLYR_DIRECTION_Y   ; set no vertical swim direction
    RTS

CLEAR_SWIM_HORIZONTAL:
	MOVE.L  #0, PLYR_DIRECTION_X   ; set no horizontal swim direction
    RTS


*-----------------------------------------------------------
* Subroutine    : Player movement
* Description   : Reads PLYR_DIRECTION_X/Y (set by WASD), accelerates
*				  velocity in that direction each frame. Applies drag when
*				  no key held. Limits max speed, and uses a lower cap when
*				  moving diagonally so you dont go faster than straight.
*-----------------------------------------------------------
PLAYER_MOVEMENT:

	; check if we're moving on both axes at once
	MOVE.L  PLYR_DIRECTION_X, D3
	MOVE.L  PLYR_DIRECTION_Y, D4

	; dont let the player swim up if theyre out of the water
	TST.L   PLYR_IN_WATER_NOW
	BNE     PM_IN_WATER				; underwater, let them swim any direction
	TST.L   D4
	BGE     PM_IN_WATER				; going down or not moving, thats fine
	; trying to swim up while in air, block that
	CLR.L   D4
	CLR.L   PLYR_DIRECTION_Y		; clear so draw doesnt show swim-up

PM_IN_WATER:

	; start with normal max speed
	MOVE.L  #PLYR_MAX_SPEED, D5

	TST.L   D3
	BEQ     PM_MAX_SET				; not moving on X
	TST.L   D4
	BEQ     PM_MAX_SET				; not moving on Y
	; moving diagonally, use lower max
	MOVE.L  #PLYR_MAX_SPEED_DIAG, D5

PM_MAX_SET:

	; --- X movement ---
	TST.L   D3
	BEQ     PM_DRAG_X				; no X input, slow down

	; if we switched direction, reset velocity so the turn feels instant
	MOVE.L  PLYR_VELOCITY_X, D0
	MULS    D3, D0					; multiply input dir by current vel - negative means they flipped
	BGE     PM_ACCEL_X				; still going same way (or was stopped), skip reset
	CLR.L   PLYR_VELOCITY_X			; was going the other way, zero out before accelerating
PM_ACCEL_X:
	; add PLYR_ACCEL in whichever direction D3 says
	MOVE.L  #PLYR_ACCEL, D1
	MULS    D3, D1
	ADD.L   D1, PLYR_VELOCITY_X

	; clamp X velocity to +/- max speed
	MOVE.L  PLYR_VELOCITY_X, D0
	CMP.L   D5, D0
	BLE     PM_CLAMP_X_LO
	MOVE.L  D5, PLYR_VELOCITY_X
	BRA     PM_DONE_X
PM_CLAMP_X_LO:
	MOVE.L  D5, D1
	NEG.L   D1
	CMP.L   D1, D0
	BGE     PM_DONE_X
	MOVE.L  D1, PLYR_VELOCITY_X
	BRA     PM_DONE_X

PM_DRAG_X:
	; not pressing left/right, slow down
	MOVE.L  PLYR_VELOCITY_X, D0
	TST.L   D0
	BEQ     PM_DONE_X				; already stopped

	; use different drag depending on air vs water
	TST.L   PLYR_IN_WATER_NOW
	BNE     PM_DRAG_X_WTR
	MOVE.L  #PLYR_AIR_DRAG, D1		; in air
	BRA     PM_DRAG_X_APPLY
PM_DRAG_X_WTR:
	MOVE.L  #PLYR_WTR_DRAG, D1		; in water
PM_DRAG_X_APPLY:
	TST.L   D1
	BEQ     PM_DONE_X				; no drag, skip

	TST.L   D0
	BMI     PM_DRAG_X_NEG

	; moving right, subtract drag
	SUB.L   D1, D0
	BLE     PM_ZERO_X				; went past zero, just stop
	MOVE.L  D0, PLYR_VELOCITY_X
	BRA     PM_DONE_X

PM_DRAG_X_NEG:
	; moving left, add drag
	ADD.L   D1, D0
	BGE     PM_ZERO_X
	MOVE.L  D0, PLYR_VELOCITY_X
	BRA     PM_DONE_X

PM_ZERO_X:
	CLR.L   PLYR_VELOCITY_X

PM_DONE_X:

	; --- Y movement ---
	TST.L   D4
	BEQ     PM_DRAG_Y				; no Y input, slow down

	; same direction-flip check as X
	MOVE.L  PLYR_VELOCITY_Y, D0
	MULS    D4, D0
	BGE     PM_ACCEL_Y
	CLR.L   PLYR_VELOCITY_Y
PM_ACCEL_Y:
	; add PLYR_ACCEL in whichever direction D4 says
	MOVE.L  #PLYR_ACCEL, D1
	MULS    D4, D1
	ADD.L   D1, PLYR_VELOCITY_Y

	; clamp Y velocity to +/- max speed
	MOVE.L  PLYR_VELOCITY_Y, D0
	CMP.L   D5, D0
	BLE     PM_CLAMP_Y_LO
	MOVE.L  D5, PLYR_VELOCITY_Y
	BRA     PM_DONE_Y
PM_CLAMP_Y_LO:
	MOVE.L  D5, D1
	NEG.L   D1
	CMP.L   D1, D0
	BGE     PM_DONE_Y
	MOVE.L  D1, PLYR_VELOCITY_Y
	BRA     PM_DONE_Y

PM_DRAG_Y:
	; not pressing up/down, slow down
	MOVE.L  PLYR_VELOCITY_Y, D0
	TST.L   D0
	BEQ     PM_DONE_Y

	; different drag for air vs water
	TST.L   PLYR_IN_WATER_NOW
	BNE     PM_DRAG_Y_WTR
	MOVE.L  #PLYR_AIR_DRAG, D1
	BRA     PM_DRAG_Y_APPLY
PM_DRAG_Y_WTR:
	MOVE.L  #PLYR_WTR_DRAG, D1
PM_DRAG_Y_APPLY:
	TST.L   D1
	BEQ     PM_DONE_Y				; no drag, skip

	TST.L   D0
	BMI     PM_DRAG_Y_NEG

	SUB.L   D1, D0
	BLE     PM_ZERO_Y
	MOVE.L  D0, PLYR_VELOCITY_Y
	BRA     PM_DONE_Y

PM_DRAG_Y_NEG:
	ADD.L   D1, D0
	BGE     PM_ZERO_Y
	MOVE.L  D0, PLYR_VELOCITY_Y
	BRA     PM_DONE_Y

PM_ZERO_Y:
	CLR.L   PLYR_VELOCITY_Y

PM_DONE_Y:
	RTS


*-----------------------------------------------------------
* Subroutine    : Clamp Player
* Description   : If the player moved past a screen edge this frame,
*				  snap them back to the edge and kill their velocity
*-----------------------------------------------------------
CLAMP_PLAYER:
    ;MOVEM.L D0-D3,-(A7)
* Clamp X --------------------------------------------------
	MOVE.L  PLAYER_X, D1
	CLR.L 	D3
	MOVE.L	#SCREEN_PADDING_X, D3

	; Left edge
	CMP.L   D3, D1
	BGE     CHECK_X_RIGHT
	MOVE.L  D3, PLAYER_X
	CLR.L   PLYR_VELOCITY_X
	BRA     CLAMP_RESYNC_X

	* Right Edge
CHECK_X_RIGHT: 
	MOVE.L  #0, D2
	MOVE.W  SCREEN_W, D2
	SUB.L   #PLYR_W_INIT, D2
	SUB.L	#SCREEN_PADDING_X, D2

	CMP.L   D2, D1
	BLE     CLAMP_Y
	MOVE.L  D2, PLAYER_X
	CLR.L   PLYR_VELOCITY_X

CLAMP_RESYNC_X:
	; position was forced, so rebuild PLYR_X_SUB from it (SUB = position << 8)
	MOVE.L  PLAYER_X, D0
	ASL.L   #8, D0
	MOVE.L  D0, PLYR_X_SUB

* Clamp Y --------------------------------------------------
CLAMP_Y:
    MOVE.L  PLAYER_Y, D1

	; Top edge
    CMP.L   #SCREEN_PADDING_Y, D1
    BGE     CHECK_Y_BOTTOM
    MOVE.L  #SCREEN_PADDING_Y, PLAYER_Y
	CLR.L   PLYR_VELOCITY_Y
	BRA     CLAMP_RESYNC_Y

	* Bottom edge
CHECK_Y_BOTTOM:
    MOVE.W  SCREEN_H, D2
    SUB.L   #PLYR_H_INIT, D2
	SUB.L	#SCREEN_PADDING_Y, D2
    CMP.L   D2, D1
    BLE     DONE_CLAMP
    MOVE.L  D2, PLAYER_Y
	CLR.L   PLYR_VELOCITY_Y

CLAMP_RESYNC_Y:
	; position was forced, so rebuild PLYR_Y_SUB from it
	MOVE.L  PLAYER_Y, D0
	ASL.L   #8, D0
	MOVE.L  D0, PLYR_Y_SUB

DONE_CLAMP:	  
    ;MOVEM.L (A7)+,D0-D3  
	RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
