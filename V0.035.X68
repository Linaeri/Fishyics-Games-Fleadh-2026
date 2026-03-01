*-----------------------------------------------------------
* Title      : Game Starter Kit
* Written by : Philip Bourke
* Date       : 05/02/2025
* Description: Project Starter Kit
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
    JSR SET_SEED
	BSR INITIALISE
	JSR TITLE_START
    BSR GAME
    SIMHALT

*-----------------------------------------------------------
* Section       : Trap Codes
* Description   : Trap Codes used throughout StarterKit
*-----------------------------------------------------------
* Trap CODES
TC_SCREEN   EQU         33          ; Screen size information trap code
TC_S_SIZE   EQU         00          ; Places 0 in D1.L to retrieve Screen width and height in D1.L
                                    ; First 16 bit Word is screen Width and Second 16 bits is screen Height
TC_KEYCODE  EQU         19          ; Check for pressed keys
TC_DBL_BUF  EQU         92          ; Double Buffer Screen Trap Code
TC_CURSR_P  EQU         11          ; Trap code cursor position

TC_EXIT     EQU         09          ; Exit Trapcode

*-----------------------------------------------------------
* Section       : Player Sizes
* Description   : Size states of player
*-----------------------------------------------------------
;starting size
PLYR_W_INIT 	EQU         08          ; Players initial Width
PLYR_H_INIT		EQU         08          ; Players initial Height

PLAYER_X_INIT   EQU         497
PLAYER_Y_INIT   EQU         192


*-----------------------------------------------------------
* Section       : Charater Setup
* Description   : Size of Player and Enemy and properties
* of these characters e.g Starting Positions and Sizes
*-----------------------------------------------------------

PLYR_DFLT_V EQU         00          ; Default Player Velocity

* Player physics values 
PLYR_ACCEL          EQU  $0013    ; how fast player speeds up
PLYR_MAX_SPEED      EQU  $0160    ; top speed on one axis
PLYR_MAX_SPEED_DIAG EQU  $00F8    ; top speed when going diagonal
PLYR_WTR_DRAG       EQU  $0003    ; how much water slows you down
PLYR_AIR_DRAG       EQU  $0000    ; barely any air resistance
PLYR_AIR_GRAVITY    EQU  $0008    ; how fast you fall in air
PLYR_JUMP_BOOST     EQU  $0050    ; upward push when jumping out of water

RUN_INDEX   EQU         00          ; Player Run Sound Index  
JMP_INDEX   EQU         01          ; Player Jump Sound Index  
OPPS_INDEX  EQU         02          ; Player Opps Sound Index


ENMY_W_INIT EQU         08          ; Enemy initial Width
ENMY_H_INIT EQU         08          ; Enemy initial Height

ENEMY_SPEED EQU 		2			
	
SCREEN_PADDING_X EQU		20		; How many pixels at the edge of the LEFT/RIGHT screen the player cant go on
SCREEN_PADDING_Y EQU		15		; How many pixels at the edge of the TOP/BOTTOM screen the player cant go on

*-----------------------------------------------------------
* Section       : Water & player water interaction
* Description   : Water level Y values
*-----------------------------------------------------------
WTR_TIDE_HIGH	EQU		100			; Y value when water is at its highest
WTR_TIDE_LOW	EQU		400			; Y value when water is at its lowest

WTR_LOW_TIDE_DELAY	EQU		4000		; How many miliseconds before tides goes down
WTR_HIGH_TIDE_DELAY	EQU		5000		; How many miliseconds before tide goes up
WTR_TIDE_SPEED	EQU		    $0040		; how fast the tide moves

TIDE_STOP       EQU 0 
TIDE_DOWN       EQU 1
TIDE_UP         EQU 2
IS_MOVING_FALSE EQU 0 
IS_MOVING_TRUE  EQU 1

WTR_PUSH_FORCE EQU  2     ; downward force per update when player above water

PLYR_LEAP_VELOCITY	EQU	-20 	; leaving water velocity
PLYR_INIT_GRAVITY	EQU	01		; how much gravity for when player leaves water

IN_WTR_TRUE		EQU		01		; player is in water true
IN_WTR_FALSE	EQU		00		; player is in water false

*-----------------------------------------------------------
* Section       : Game Stats    
* Description   : Points
*-----------------------------------------------------------
POINTS      EQU         01          ; Points added

*-----------------------------------------------------------
* Section       : Keyboard Keys
* Description   : Spacebar and Escape or two functioning keys
* Spacebar to JUMP and Escape to Exit Game
*-----------------------------------------------------------
SPACEBAR    EQU         $20         ; Spacebar ASCII Keycode
ESCAPE      EQU         $1B         ; Escape ASCII Keycode
W           EQU         $57         ; W
A           EQU         $41         ; W  
S           EQU         $53         ; S
D           EQU         $44         ; W

*----------------------------------------------------------- 
* Subroutine    : Initialise
* Description   : Initialise game data into memory such as 
* sounds and screen size
*-----------------------------------------------------------
INITIALISE:
	
	; Set Screen Resolution to 1024x768 px
	 MOVE.B #33,D0
     MOVE.L #1024*$10000+768,D1        Set screen to 1024 x 768
	 TRAP   #15

	; Change between fullscreen/windowed mode
	MOVE.B #33,D0
	; MOVE.L #2, D1		; Set to fullscreen mode
 	 MOVE.L #1, D1		; Set to Windowed mode
     TRAP   #15


    ; Initialise Sounds
    ;BSR     RUN_LOAD                ; dont have run.wav
    ;BSR     JUMP_LOAD               ; dont have jump.wav
    ;BSR     OPPS_LOAD               ; dont have opps.wav
    BSR     ACH_SND_LOAD            ; Load Achievement Sound into Memory

    ; Screen Size
    MOVE.B  #TC_SCREEN, D0          ; access screen information
    MOVE.L  #TC_S_SIZE, D1          ; placing 0 in D1 triggers loading screen size information
    TRAP    #15                     ; interpret D0 and D1 for screen size
    MOVE.W  D1,         SCREEN_H    ; place screen height in memory location
    SWAP    D1                      ; Swap top and bottom word to retrive screen size
    MOVE.W  D1,         SCREEN_W    ; place screen width in memory location

*

    ; Place the Player at the center of the screen - X axis
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    ;MOVE.W  SCREEN_W,   D1          ; Place Screen width in D1
    ;DIVU    #02,        D1          ; divide by 2 for center on X Axis
    MOVE.L  #PLAYER_X_INIT,         PLAYER_X    ; set starting X
    MOVE.L  #PLAYER_X_INIT,         D1
    ASL.L   #8, D1					; same value but shifted up for the fractional position
    MOVE.L  D1,         PLYR_X_SUB

	; Place the Player near high tide
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    ;MOVE.W  #150,   D1          ; Place Screen width in D1
 ;   DIVU    #02,        D1          ; divide by 2 for center on Y Axis
    MOVE.L  #PLAYER_Y_INIT,         PLAYER_Y    ; set starting Y
    MOVE.L  #PLAYER_Y_INIT,         D1
    ASL.L   #8, D1					; fractional version
    MOVE.L  D1,         PLYR_Y_SUB


*	Y centering - old centering code
 ;   CLR.L   D1
 ;   MOVE.W  SCREEN_H,   D1
 ;   DIVU    #02,        D1
 ;   MOVE.L  D1,         PLAYER_Y
 ;   ASL.L   #8, D1
;    MOVE.L  D1,         PLYR_Y_SUB


    ; Initialise Player Score
    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    MOVE.L  #00,        D1          ; Init Score
    MOVE.L  D1,         PLAYER_SCORE

	 ; Initialise Player Water Velocity Y
    ;MOVE.L  #0, PLYR_WTR_VELOCITY_Y

	 ; Initialise Player Water Gravity
    ;MOVE.L  #1, PLYR_WTR_GRAVITY
    ; Initialise Player Velocity Y
    ;CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    ;MOVE.B  #PLYR_DFLT_V,D1         ; Init Player Velocity
    ;MOVE.L  D1,         PLYR_VELOCITY_Y

    ; Initialise Player Velocity X
    ;CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
    ;OVE.B  #PLYR_DFLT_V,D1         ; Init Player Velocity
    ;MOVE.L  D1,         PLYR_VELOCITY_X
    ; Initialise Player Velocities to 0
    MOVE.L  #0, PLYR_VELOCITY_X
    MOVE.L  #0, PLYR_VELOCITY_Y

   
    ; Initialise Player direction Y              
    MOVE.L  #0, PLYR_DIRECTION_Y         ; Init Player direction y

 	; Initialise Player direction X             
    MOVE.L  #0, PLYR_DIRECTION_X         ; Init Player direction x
	MOVE.L  #0, IS_FLIPPED  ; Start player facing the left

    ; Initial Position for Enemy
    JSR     INIT_ALL_ENEMIES
    
    ;init pelican enemy
    JSR     INIT_PELICAN

    ;init achievements
    JSR     INIT_ACHIEVEMENTS

    ; Enable the screen back buffer(see easy 68k help)
	MOVE.B  #TC_DBL_BUF,D0          ; 92 Enables Double Buffer
    MOVE.B  #17,        D1          ; Combine Tasks
	TRAP	#15                     ; Trap (Perform action)

    ; Clear the screen (see easy 68k help)
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
	MOVE.W  #$FF00,     D1          ; Fill Screen Clear
	TRAP	#15                     ; Trap (Perform action)

	* DeltaTime---------------------
	; Get initial system time          
    MOVE.B  #8, D0                  ; Get elapsed milliseconds
    TRAP    #15
    MOVE.L  D1, LAST_TIME           

	* Water tide ---------------------
	* Initialise water tide
 	MOVE.L  #WTR_TIDE_HIGH, WTR_CURRENT_Y	; set water Y to highest point
	MOVE.L	#WTR_TIDE_HIGH, D0
	ASL.L	#8, D0								; fractional version of the same Y
	MOVE.L	D0, WTR_Y_SUB
    MOVE.L  #0, WTR_CURRENT_TIDE_TIME	
    MOVE.L  #TIDE_UP, WTR_TIDE_DIRECTION  ; start tide moving down
    MOVE.L  #IS_MOVING_FALSE, IS_TIDE_MOVING ; tide starts moving immediately

    JSR     INIT_MOONS
    
	; put player as underwater
	MOVE.L	#IN_WTR_TRUE,	PLYR_IN_WATER_NOW	; start player as underwater: 1 = underwater, 0 = above water

    RTS

*-----------------------------------------------------------
* Subroutine    : UPDATE_DELTA_TIME
* Description   : Calculates time passed since last frame
*-----------------------------------------------------------
UPDATE_DELTA_TIME:
    MOVE.B  #8, D0          ; Get elapsed milliseconds
    TRAP    #15
    MOVE.L  D1, CURRENT_TIME

    MOVE.L  CURRENT_TIME, D2
    SUB.L   LAST_TIME, D2  ; Subtract current time from last time to get elapsed milliseconds since
    
   * Prevent spikes when game paused etc
	CMP.L  #50, D2		; if more than or equal to 50 ms pass since last cycle
	BLE     STORE_DELTA	; skip clamping
	MOVE.L  #50, D2		; if current delta time > 50, clamp it to 50 (prevent spikes)

STORE_DELTA:				

    MOVE.L  D2, DELTA_TIME
    MOVE.L  CURRENT_TIME, LAST_TIME	; put current time into last for next cycle

    RTS

*-----------------------------------------------------------
* Subroutine    : UPDATE_TIDE
* Description   : Calculates change in the water Y level 
*-----------------------------------------------------------
UPDATE_TIDE:
    ;is tide currently moving?
    MOVE.L  IS_TIDE_MOVING, D0
    CMP.L   #IS_MOVING_TRUE, D0
    BEQ     TIDE_IS_MOVING          ; yes -> go move the water

*tide not moving, run timer
TIDE_IS_WAITING:
    ; Add deltaTime to the tide wait timer
    MOVE.L  DELTA_TIME, D1
    ADD.L   D1, WTR_CURRENT_TIDE_TIME

    ; Which end are we waiting at?
    ;   Y >= WTR_TIDE_LOW  -> at bottom, compare HIGH_TIDE_DELAY, next dir = UP
    ;   Y <  WTR_TIDE_LOW  -> at top,    compare LOW_TIDE_DELAY,  next dir = DOWN
    MOVE.L  WTR_CURRENT_Y, D1
    CMP.L   #WTR_TIDE_LOW, D1
    BGE     TIDE_WAIT_AT_LOW

    ;waiting at HIGH (top of screen) ---
    MOVE.L  WTR_CURRENT_TIDE_TIME, D1
    CMP.L   #WTR_LOW_TIDE_DELAY, D1
    BLT     TIDE_DONE               ; delay not elapsed yet
    ; Timer done, start moving DOWN
    MOVE.L  #TIDE_DOWN, WTR_TIDE_DIRECTION
    MOVE.L  #IS_MOVING_TRUE, IS_TIDE_MOVING
    MOVE.L  #0, WTR_CURRENT_TIDE_TIME
    BRA     TIDE_DONE

TIDE_WAIT_AT_LOW:
    ; waiting at LOW (bottom of screen) ---
    MOVE.L  WTR_CURRENT_TIDE_TIME, D1
    CMP.L   #WTR_HIGH_TIDE_DELAY, D1
    BLT     TIDE_DONE               ; delay not elapsed yet
    ; timer done start moving UP
    MOVE.L  #TIDE_UP, WTR_TIDE_DIRECTION
    MOVE.L  #IS_MOVING_TRUE, IS_TIDE_MOVING
    MOVE.L  #0, WTR_CURRENT_TIDE_TIME
    BRA     TIDE_DONE

;tide is moving
TIDE_IS_MOVING:
    ; Check direction: DOWN or UP
    MOVE.L  WTR_TIDE_DIRECTION, D0
    CMP.L   #TIDE_DOWN, D0
    BEQ     TIDE_GOING_DOWN
    ; otherwise must be TIDE_UP

* Moving UP (Y decreases toward WTR_TIDE_HIGH)
TIDE_GOING_UP:
    MOVE.L  #WTR_TIDE_SPEED, D1
    MOVE.L  DELTA_TIME, D2
    MULS    D2, D1					; speed * time gives us how far to move this frame
    SUB.L   D1, WTR_Y_SUB			; subtract because up = lower Y
    MOVE.L  WTR_Y_SUB, D1
    ASR.L   #8, D1					; drop the fractional part to get the actual pixel row
    MOVE.L  D1, WTR_CURRENT_Y

    CMP.L   #WTR_TIDE_HIGH, D1
    BGT     TIDE_DONE				; not at the top yet
    ; clamp to high limit and stop
    MOVE.L  #WTR_TIDE_HIGH, WTR_CURRENT_Y
    MOVE.L  #WTR_TIDE_HIGH, D0
    ASL.L   #8, D0					; rebuild fractional Y from the clamped value
    MOVE.L  D0, WTR_Y_SUB
    MOVE.L  #IS_MOVING_FALSE, IS_TIDE_MOVING
    MOVE.L  #0, WTR_CURRENT_TIDE_TIME
    BRA     TIDE_DONE

* Moving DOWN (Y increases toward WTR_TIDE_LOW)
TIDE_GOING_DOWN:
    MOVE.L  #WTR_TIDE_SPEED, D1
    MOVE.L  DELTA_TIME, D2
    MULS    D2, D1					; speed * time
    ADD.L   D1, WTR_Y_SUB			; add because down = higher Y
    MOVE.L  WTR_Y_SUB, D1
    ASR.L   #8, D1					; get pixel row from fractional
    MOVE.L  D1, WTR_CURRENT_Y

    CMP.L   #WTR_TIDE_LOW, D1
    BLT     TIDE_DONE				; not at the bottom yet
    ; clamp to low limit and stop
    MOVE.L  #WTR_TIDE_LOW, WTR_CURRENT_Y
    MOVE.L  #WTR_TIDE_LOW, D0
    ASL.L   #8, D0					; rebuild fractional Y
    MOVE.L  D0, WTR_Y_SUB
    MOVE.L  #IS_MOVING_FALSE, IS_TIDE_MOVING
    MOVE.L  #0, WTR_CURRENT_TIDE_TIME

TIDE_DONE:
    RTS
    
*-----------------------------------------------------------    
* Subroutine    : Game
* Description   : Game including main GameLoop. GameLoop is like
* a while loop in that it runs forever until interupted
* (Input, Update, Draw). The Enemies Run at Player Jump to Avoid
*-----------------------------------------------------------
GAME:
    ;BSR     PLAY_RUN                ; no run.wav file
GAMELOOP:
    ; Main Gameloop
	BSR 	UPDATE_DELTA_TIME		; Update game time
	BSR		UPDATE_TIDE				; Calculate change in the water Y level 
	BSR     UPDATE_MOONS
    JSR     INPUT                   ; Check Keyboard Input
	JSR		WASD_CHECK_INPUT		; now check WASD keys
	
    ;JSR		PLAYER_MOVEMENT			; Sets player X and Y movement for this cycle
    ;BSR     UPDATE                  ; Update positions and points
	;jSR		PLYR_UNDERWATER_CHECK	; if player is above water apply gravity 
	JSR		PLAYER_MOVEMENT				; handle player speed from input
	JSR		PLYR_UNDERWATER_CHECK	; gravity and jump boost
    BSR     UPDATE                  ; move player based on velocity

	JSR		CLAMP_PLAYER			; limit player to stay within the screen edges
    JSR     MOVE_ALL_ENEMIES        ; Move all 15 fish
    JSR     CHECK_ALL_COLLISIONS    ; Collision check all 15 fish
    
    ;pelican stuff
    JSR     UPDATE_PELICAN
    JSR     CHECK_PELICAN_COLLISION

    ;achievements
    JSR     UPDATE_ACHIEVEMENT
    
    BSR     DRAW                    ; Draw the Scene

	; Small CPU relief delay        
    MOVE.L  #1,D1
    MOVE.B  #23,D0
    TRAP    #15						;

    BRA     GAMELOOP                ; Loop back to GameLoop

*-----------------------------------------------------------
* Subroutine    : Draw
* Description   : Draw Screen
*-----------------------------------------------------------
DRAW: 
    ; Enable back buffer
    MOVE.B  #94,        D0
    TRAP    #15

    ; Clear the screen
    ;MOVE.B	#TC_CURSR_P,D0          ; Set Cursor Position
	;MOVE.W	#$FF00,     D1          ; Clear contents
	;TRAP    #15                     ; Trap (Perform action)

	JSR		DRAW_BACKGROUND			; draw sky
	JSR     DRAW_MOONS
	JSR     DRAW_PELICAN
	JSR		DRAW_WATER				; draw water tide
    JSR     DRAW_PLYR_DATA          ; Draw Draw Score, HUD, Player X and Y
    JSR     DRAW_PLAYER             ; Draw Player
    JSR     DRAW_ALL_ENEMIES              ; Draw Enemy
	JSR     DRAW_SAND               ; Draw Sand
    JSR     DRAW_ACHIEVEMENT        ; Draw achievement popup
    RTS                             ; Return to subroutine

*----------------------------------------------------------- 
* Subroutine    : Update
* Description   : Main update loop update Player and Enemies
*-----------------------------------------------------------
UPDATE:
;    ; Update the Players Positon based on Velocity and Gravity
;    CLR.L   D1                      ; Clear contents of D1 (XOR is faster)
;    MOVE.L  PLYR_VELOCITY, D1       ; Fetch Player Velocity
;    MOVE.L  PLYR_GRAVITY, D2        ; Fetch Player Gravity
;    ADD.L   D2,         D1          ; Add Gravity to Velocity
;    MOVE.L  D1,         PLYR_VELOCITY ; Update Player Velocity
;    ADD.L   PLAYER_Y,   D1          ; Add Velocity to Player
;    MOVE.L  D1,         PLAYER_Y    ; Update Players Y Position 


   	; Update the Player's Positon based on Velocity and Gravity and DeltaTime


	; Position += Velocity * deltaTime -> X VELOCITY
	;CLR.L   D1                      ; Clear contents of D1
	;MOVE.L  PLYR_VELOCITY_X, D1		; Fetch Player Velocity X
	;MOVE.L  DELTA_TIME, D2			; Fetch deltaTime
	;MULS    D2, D1					; Multiply Signed velocity * deltaTime
	;ADD.L   D1, PLAYER_X ; 			; Store it as new player x
	;MOVE.L  #0, PLYR_VELOCITY_X		; Reset player x velocity to 0

	; Position += Velocity * deltaTime -> Y VELOCITY
	;CLR.L   D1                      ; Clear contents of D1
	;MOVE.L  PLYR_VELOCITY_Y, D1		; Fetch Player Velocity Y
	;MOVE.L  DELTA_TIME, D2
	;MULS    D2, D1	
	;ADD.L   D1, PLAYER_Y ; 
	;MOVE.L  #0, PLYR_VELOCITY_Y
	
	; Move player based on velocity * deltaTime, using the fractional 
	; position so movement can be slower than 1 pixel per frame

	; X position
	MOVE.L  PLYR_VELOCITY_X, D1
	MOVE.L  DELTA_TIME, D2
	MULS    D2, D1					; velocity * time = distance this frame
	ADD.L   D1, PLYR_X_SUB			; accumulate into fractional X
	MOVE.L  PLYR_X_SUB, D1
	ASR.L   #8, D1					; drop fractional bits to get pixel X
	MOVE.L  D1, PLAYER_X


	; Y position
	MOVE.L  PLYR_VELOCITY_Y, D1
	MOVE.L  DELTA_TIME, D2
	MULS    D2, D1
	ADD.L   D1, PLYR_Y_SUB
	MOVE.L  PLYR_Y_SUB, D1
	ASR.L   #8, D1					; pixel Y
	MOVE.L  D1, PLAYER_Y

    RTS                             ; Return to subroutine  


*-----------------------------------------------------------
* Subroutines   : Sound Load and Play
* Description   : Sound stubs - wav files not available
*                 Only achievement sound is loaded (in SBR_ACHIEVEMENTS)
*-----------------------------------------------------------
; these do nothing since we dont have the wav files
; but labels are kept so any BSR/JSR calls still work
RUN_LOAD:
PLAY_RUN:
JUMP_LOAD:
PLAY_JUMP:
OPPS_LOAD:
PLAY_OPPS:
    RTS





*-----------------------------------------------------------
* Subroutine    : Collision Check
* Description   : Axis-Aligned Bounding Box Collision Detection
* Algorithm checks for overlap on the 4 sides of the Player and 
* Enemy rectangles
* PLAYER_X <= ENEMY_X + ENEMY_W &&
* PLAYER_X + PLAYER_W >= ENEMY_X &&
* PLAYER_Y <= ENEMY_Y + ENEMY_H &&
* PLAYER_H + PLAYER_Y >= ENEMY_Y
*-----------------------------------------------------------
COLLISION:
    BSR     PLAY_OPPS               ; Play Opps Wav
    MOVE.L  #00, PLAYER_SCORE       ; Reset Player Score
    RTS                             ; Return to subroutine

*-----------------------------------------------------------
* Subroutine    : EXIT
* Description   : Exit message and End Game
*-----------------------------------------------------------
EXIT:
    ; Show if Exiting is Running
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
    MOVE.W  #$4004,     D1          ; Col 40, Row 1
    TRAP    #15                     ; Trap (Perform action)
    LEA     EXIT_MSG,   A1          ; Exit
    MOVE    #13,        D0          ; No Line feed
    TRAP    #15                     ; Trap (Perform action)
    MOVE.B  #TC_EXIT,   D0          ; Exit Code
    TRAP    #15                     ; Trap (Perform action)



    SIMHALT



*----------------------------------------------------------- 
* Section       : Delta Time
* Description 	: For slowing down runtime, make it consistent.
*-----------------------------------------------------------
LAST_TIME       DS.L    1		; milliseconds elapsed lsat cycle
CURRENT_TIME    DS.L    1		; milliseconds passed since last cycle
DELTA_TIME      DS.L    1		; multiply any velocity with this to make movement over time consistent.

*-----------------------------------------------------------
* Section       : Messages
* Description   : Messages to Print on Console, names should be
* self documenting
*-----------------------------------------------------------
SCORE_MSG       DC.B    'Score: ', 0        ; Score Message
KEYCODE_MSG     DC.B    'KeyCode : ', 0     ; Keycode Message
JUMP_MSG        DC.B    'Jump....', 0       ; Jump Message

IDLE_MSG        DC.B    'Idle....', 0       ; Idle Message
UPDATE_MSG      DC.B    'Update....', 0     ; Update Message
DRAW_MSG        DC.B    'Draw....', 0       ; Draw Message

X_MSG           DC.B    'X:', 0             ; X Position Message
Y_MSG           DC.B    'Y:', 0             ; Y Position Message
V_MSG           DC.B    'V:', 0             ; Velocity Position Message
G_MSG           DC.B    'G:', 0             ; Gravity Position Message
GND_MSG         DC.B    'GND:', 0           ; On Ground Position Message

EXIT_MSG        DC.B    'Exiting....', 0    ; Exit Message


*-----------------------------------------------------------
* Section       : Screen Size
* Description   : Screen Width and Height
*-----------------------------------------------------------
SCREEN_W        DS.W    01  ; Reserve Space for Screen Width
SCREEN_H        DS.W    01  ; Reserve Space for Screen Height

*-----------------------------------------------------------
* Section       : Tide Water level
* Description   : Current height of water, time elapsed
*-----------------------------------------------------------

WTR_CURRENT_Y			DS.L	01	; Reserve space for water height
WTR_Y_SUB				DS.L	01	; Fractional water Y, same idea as PLYR_X_SUB/PLYR_Y_SUB
WTR_LAST_TIDE_TIME		DS.L	01	; Elapsed Miliseconds when the last tide stopped moving
WTR_CURRENT_TIDE_TIME	DS.L	01	; Incrementing miliseconds counter since last tide.

WTR_TIDE_DIRECTION		DS.L	01 	; -1 if tide is rising, 0 stationary, 1 lowering
IS_TIDE_MOVING			DS.L	01	; 0 = not moving (waiting), 1 = tide is moving

;PLYR_WTR_GRAVITY		DS.L	01	; reserve space for the gravity out of water
;PLYR_WTR_VELOCITY_Y		DS.L	01	; The up/downards velocity while out of water
;PLYR_IN_WATER_NOW		DS.L	01	; 1 if player is underwayer, 0 if player above water
;PLYR_IN_WATER_STATE		DS.L	01  ; 1 = underwater, 0 = above. Saved state from last cycle
PLYR_IN_WATER_NOW		DS.L	01	; 1 if underwater, 0 if in air
PLYR_IN_WATER_STATE		DS.L	01  ; last frames water state


*-----------------------------------------------------------
* Section       : Keyboard Input
* Description   : Used for storing Keypresses
*-----------------------------------------------------------
CURRENT_KEY     DS.L    01  ; Reserve Space for Current Key Pressed

*-----------------------------------------------------------
* Section       : Character Positions
* Description   : Player and Enemy Position Memory Locations
*-----------------------------------------------------------
;PLAYER_X        DS.L    01  ; Reserve Space for Player X Position
;PLAYER_Y        DS.L    01  ; Reserve Space for Player Y Position
PLAYER_X        DS.L    01  ; Player X position
PLAYER_Y        DS.L    01  ; Player Y position

PLYR_X_SUB      DS.L    01  ; Fractional X pos (pixel = this >> 8)
PLYR_Y_SUB      DS.L    01  ; Fractional Y pos (pixel = this >> 8)

PLYR_VELOCITY_X   DS.L    01  ; Player X velocity
PLYR_VELOCITY_Y   DS.L    01  ; Player Y velocity

PLAYER_SCORE    DS.L    01  ; Reserve Space for Player Score

;PLYR_VELOCITY_X   DS.L    01  ; Reserve Space for Player Velocity
;PLYR_VELOCITY_Y   DS.L    01  ; Reserve Space for Player Velocity
PLYR_GRAVITY    DS.L    01  ; Reserve Space for Player Gravity
PLYR_ON_GND     DS.L    01  ; Reserve Space for Player on Ground
    
PLYR_DIRECTION_Y DS.L   01   Reserve Space for player direction y
PLYR_DIRECTION_X DS.L   01   Reserve Space for player direction x

;ENEMY_X         DS.L    01  ; Reserve Space for Enemy X Position
;ENEMY_Y         DS.L    01  ; Reserve Space for Enemy Y Position

PLYR_W_CURRENT	DS.L	01	; Player width for collision. Changes when player grows
PLYR_H_CURRENT	DS.L	01	; Player height for collision. Changes when player grows

*-----------------------------------------------------------
* Section       : Sounds
* Description   : Sound files, which are then loaded and given
* an address in memory, they take a longtime to process and play
* so keep the files small. Used https://voicemaker.in/ to 
* generate and Audacity to convert MP3 to WAV
*-----------------------------------------------------------
;wav files commented out, dont have them
;JUMP_WAV        DC.B    'jump.wav',0
;RUN_WAV         DC.B    'run.wav',0
;OPPS_WAV        DC.B    'opps.wav',0


*-----------------------------------------------------------
* Section       : Other files
* Description   : Must add include for each file you want to call a subroutine from with JSR
*-----------------------------------------------------------

	include "SBR_DRAW.X68"		; For drawing text and images onto the screen during gameplay
	include "SBR_INPUT.X68"		; Handles keyboard input and calls subroutines for any keys pressed 
    include "SBR_PLYR_UNDERWATER_CHECK.X68" ; Handles player above/below water
    include "SBR_RANDOM.X68"    ;XXX
    include "SBR_ENEMIES.X68"
	include	"SBR_DRAW_PLAYER.x68"	; draws player sprite
	include "SBR_MOONS.X68"
	include "SBR_PELICAN.X68"
	include "SBR_TITLE_SCREEN.X68"
	include "SBR_END_SCREEN.X68"
	include "SBR_DRAW_SKELETON.X68"
	include "SBR_ACHIEVEMENTS.X68"

    END    START        ; last line of source


	














































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
