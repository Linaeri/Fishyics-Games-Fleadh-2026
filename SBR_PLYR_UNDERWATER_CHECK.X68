*-----------------------------------------------------------
* Title      : SBR_PLYR_UNDERWATER_CHECK
* Description: Checks if player is in water or in the air.
*			   Adds gravity when in air, boost when jumping out.
*
* PLYR_IN_WATER_NOW   = 1 underwater, 0 in air
* PLYR_IN_WATER_STATE = last frames value
*-----------------------------------------------------------
PLYR_UNDERWATER_CHECK:

	; save what we were last frame
	MOVE.L	PLYR_IN_WATER_NOW, PLYR_IN_WATER_STATE

	; check if player bottom is below water line
	MOVE.L	PLAYER_Y, D1
	ADD.L	PLYR_H_CURRENT, D1		; bottom of player
	CMP.L	WTR_CURRENT_Y, D1		; is it below water?
	BLE		UWC_SET_IN_AIR			; nope, above water
	; Otherwise: underwater
	MOVE.L	#1, PLYR_IN_WATER_NOW
	BRA		UWC_CHECK_TRANSITION

UWC_SET_IN_AIR:
	MOVE.L	#0, PLYR_IN_WATER_NOW

UWC_CHECK_TRANSITION:
	; what were we last frame?
	TST.L	PLYR_IN_WATER_STATE
	BEQ		UWC_WAS_IN_AIR
	BNE		UWC_WAS_UNDERWATER

*-----------------------------------------------------------
* Was in air last frame
*-----------------------------------------------------------
UWC_WAS_IN_AIR:
	TST.L	PLYR_IN_WATER_NOW
	BNE		UWC_JUST_ENTERED_WATER	; just splashed in
	; still in air, keep falling
	BRA		UWC_APPLY_GRAVITY

*-----------------------------------------------------------
* Was underwater last frame
*-----------------------------------------------------------
UWC_WAS_UNDERWATER:
	TST.L	PLYR_IN_WATER_NOW
	BNE		UWC_DONE				; still underwater, nothing to do
	; was underwater, now in air = jumped out
	BRA		UWC_JUST_LEFT_WATER

*-----------------------------------------------------------
* Jumped out of the water, give upward boost
*-----------------------------------------------------------
UWC_JUST_LEFT_WATER:
	; only boost if already moving upward
	MOVE.L	PLYR_VELOCITY_Y, D0
	TST.L	D0
	BGE		UWC_APPLY_GRAVITY		; not going up, just do gravity

	; push player up more when they leave the water
	MOVE.L	#PLYR_JUMP_BOOST, D1
	SUB.L	D1, PLYR_VELOCITY_Y


*-----------------------------------------------------------
* Gravity - pull player down when in air
*-----------------------------------------------------------
UWC_APPLY_GRAVITY:
	MOVE.L	#PLYR_AIR_GRAVITY, D1
	ADD.L	D1, PLYR_VELOCITY_Y	; pull down

	BRA		UWC_DONE

*-----------------------------------------------------------
* Just went into water, slow down so we dont dive too deep
*-----------------------------------------------------------
UWC_JUST_ENTERED_WATER:
	; cut downward speed in half when hitting the water
	MOVE.L	PLYR_VELOCITY_Y, D0
	TST.L	D0
	BLE		UWC_DONE				; going up, leave it
	ASR.L	#1, D0					; halve it
	MOVE.L	D0, PLYR_VELOCITY_Y

UWC_DONE:
	RTS


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
