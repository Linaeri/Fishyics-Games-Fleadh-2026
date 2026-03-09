*-----------------------------------------------------------
* Title      : SBR_INPUT
* Desription: Handle keyboard input
* Subroutines: (in this order:)

*	INPUT				; checks for last pressed key
*	PROCESS_INPUT		; compares last pressed key, used to exit the program with Esc
*	WASD_CHECK_INPUT	; checks the state of multiple keys pressed at once, for example is W AND D are held
*   Any other keys, repeat WASD code here
*-----------------------------------------------------------


*-----------------------------------------------------------
* Subroutine    : Input
* Description   : Process Keyboard Input
*-----------------------------------------------------------
INPUT:
    MOVEM.L D0-D2, -(SP)
    ; Process Input
	CLR.L   D2
    CLR.L   D1                      ; Clear Data Register
    MOVE.B  #TC_KEYCODE,D0          ; Listen for Keys
    TRAP    #15                     ; Trap (Perform action)
    MOVE.B  D1,         D2          ; Move last key D1 to D2
    CMP.B   #00,        D2          ; Key is pressed
    BEQ     PROCESS_INPUT           ; Process Key
    TRAP    #15                     ; Trap for Last Key
    ; Check if key still pressed
    CMP.B   #$FF,       D1          ; Is it still pressed
    BEQ     PROCESS_INPUT           ; Process Last Key
    MOVEM.L (SP)+, D0-D2
    RTS                             ; Return to subroutine

*-----------------------------------------------------------
* Subroutine    : Process Input
* Description   : Branch based on keys pressed
* single-key check goes here if needed
*		If you need multiple keys pressed at once, use another WASD input check block
*-----------------------------------------------------------
PROCESS_INPUT:
    MOVE.L  D2,         CURRENT_KEY ; Put Current Key in Memory
    CMP.L   #ESCAPE,    CURRENT_KEY ; Is Current Key Escape
    BEQ     EXIT                    ; Exit if Escape
  
    MOVE.L  D2,         CURRENT_KEY ; Put Current Key in Memory
    CMP.L   #76,    CURRENT_KEY ; Is Current Key Escape
    BEQ     STARTx            ; Exit if Escape
    BNE     CONTINUE_IN
    
STARTx:
    JMP    START
  
CONTINUE_IN:
    MOVEM.L (SP)+, D0-D2
    RTS                             ; Return to subroutine
    
*-----------------------------------------------------------
* Subroutine    : WASD check input
* Description   : See Easy68k help manual for reference - checks the state of 4 specified keys 
*-----------------------------------------------------------
WASD_CHECK_INPUT:
     MOVEM.L D0-D1, -(SP)

    ; Assume no movement this frame - clear x and y directions
     MOVE.L  #0, PLYR_DIRECTION_X
     MOVE.L  #0, PLYR_DIRECTION_Y

	 MOVE.B #19,D0     

     MOVE.L #'W'<<24+'S'<<16+'A'<<8+'D',D1 ; check for keypress (w,s,a,d)

     TRAP   #15

	* Vertical Check ------------------------------------------------
	* Up
     BTST.L #24,D1     ; test for 'w'
     IF <NE> THEN      ; if 'w'
		JSR     SET_SWIM_UP             		; if up key pressed, go up 	
     ENDI

	 * Down
     BTST.L #16,D1     ; test for 's'
     IF <NE> THEN      ; if 's'
			BTST.L #24,D1     ; test for 'w' again
	 		IF <NE> THEN 
			    JSR		CLEAR_SWIM_VERTICAL    	; If both up and down key are pressed, dont move
			ELSE
				JSR	   SET_SWIM_DOWN 			; otherwise you can swim down

			ENDI
     ENDI

	* Horizontal Check ------------------------------------------------
	* Left
     BTST.L #8,D1     ; test for 'a'
     IF <NE> THEN      ; if 'a'
	    
			 JSR     SET_SWIM_LEFT  			; if left key pressed, go left
     ENDI

	 * Right
     BTST.L #0,D1     ; test for 'd'
     IF <NE> THEN      ; if 's'
	    	BTST.L #8,D1     ; test for 'a' again
	 		IF <NE> THEN 
			    JSR		CLEAR_SWIM_HORIZONTAL  	; If both left and right key are pressed, dont move
			ELSE
				JSR     SET_SWIM_RIGHT			; otherwise you can swim right
			ENDI
	 ENDI

	
	MOVEM.L (SP)+, D0-D1
	RTS

*----------------------------------------------------
	include "SBR_PLYR_MOVEMENT.X68"	; for calling the Set Swim direction subroutines





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
