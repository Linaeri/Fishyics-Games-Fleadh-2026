*-----------------------------------------------------------
* Title      : SBR_DRAW
* Description: 	Output to the screen - text and image
* Subroutines: (in this order:)

*	DRAW_WATER				; draw water tide
*   DRAW_BACKGROUND			; Placeholder for backgound (underwater) assets
*   DRAW_PLYR_DATA          ; Draw Draw Score, HUD, Player X and Y
*   DRAW_PLAYER             ; Draw Player
*   DRAW_ENEMY              ; Draw Enemy PLACEHOLDER - replace with fish array draws

*  Data:	Colour HEX codes as named constants
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Water
* Description   : Draw water level as a box
*-----------------------------------------------------------
DRAW_WATER:
    MOVEM.L D0-D6/A0, -(SP)
    ; high tide background
    MOVE.L  #$00AE9E2E, D1      ; Use base gradient color or HIGHTIDE
    BSR     SET_COLORS
    MOVE.L  #0, D1              ; X
    MOVE.L  WTR_CURRENT_Y, D2   ; Y
    MOVE.L  #SCREEN_W, D3       ; Width
    MOVE.L  #SCREEN_H, D4       ; Height
    MOVE.B  #87, D0             ; Draw Rectangle
    TRAP    #15

    ; low tide background
    MOVE.L  #$00957C21, D1      ; Use base gradient color or LOWTIDE
    BSR     SET_COLORS
    MOVE.L  #0, D1
    MOVE.L  #350, D2
    ADD.L   WTR_CURRENT_Y, D2
    MOVE.L  #SCREEN_W, D3
    MOVE.L  #SCREEN_H, D4
    MOVE.B  #87, D0
    TRAP    #15

    ; shallows gradient
    LEA     SHALLOW_TABLE, A0   ; Point to the list of colors
    MOVE.W  #6, D5              ; 7 colors (count starts at 0 for DBRA)
    MOVE.W  #56, D6             ; Initial Height Offset (8 * 7)
SHALLOW_LOOP:
    MOVE.L  (A0)+, D1           ; Load color and move to next in table
    BSR     SET_COLORS
    MOVE.L  #0, D1              ; X
    MOVE.L  WTR_CURRENT_Y, D2   ; Y
    MOVE.L  #SCREEN_W, D3       ; Width
    MOVE.L  WTR_CURRENT_Y, D4   ; Start at Y
    ADD.L   D6, D4              ; Add current height step
    MOVE.B  #87, D0             ; Draw
    TRAP    #15
    SUB.W   #8, D6              ; Shrink height for the next (inner) layer
    DBRA    D5, SHALLOW_LOOP

    ; tide gradient
    LEA     TIDE_TABLE, A0      ; Point to Tide colors
    MOVE.W  #8, D5              ; 9 colors
    MOVE.W  #72, D6             ; Initial Height Offset (8 * 9)
TIDE_LOOP:
    MOVE.L  (A0)+, D1
    BSR     SET_COLORS
    MOVE.L  #0, D1              ; X
    MOVE.L  #350, D2
    ADD.L   WTR_CURRENT_Y, D2   ; Base Y for Low Tide
    MOVE.L  #SCREEN_W, D3
    MOVE.L  D2, D4              ; Base Y for Height calculation
    ADD.L   D6, D4              ; Add offset
    MOVE.B  #87, D0
    TRAP    #15
    SUB.W   #8, D6
    DBRA    D5, TIDE_LOOP

    ; waterline
    MOVE.L  #WATERLINE, D1
    MOVE.B  #80, D0
    TRAP    #15
    MOVE.L  #02, D1             ; Set pen width 2
    MOVE.B  #93, D0
    TRAP    #15
    MOVE.L  #0, D1              ; X1
    MOVE.L  WTR_CURRENT_Y, D2   ; Y1
    MOVE.L  #SCREEN_W, D3       ; X2
    MOVE.L  WTR_CURRENT_Y, D4   ; Y2
    MOVE.B  #84, D0             ; Draw Line
    TRAP    #15

    ; Reset Pen Width for other routines
    MOVE.L  #01, D1
    MOVE.B  #93, D0
    TRAP    #15
    MOVEM.L (SP)+, D0-D6/A0
    RTS

; sets both pen and fill to the colour in D1
SET_COLORS:
    MOVE.B  #80, D0             ; Set Pen
    TRAP    #15
    MOVE.B  #81, D0             ; Set Fill
    TRAP    #15
    RTS

; colour tables for gradient layers
    ; bottom to top order
SHALLOW_TABLE:
    DC.L $00AE9E2E, $00B2A130, $00B7A733, $00BDAF36, $00C2B539, $00C6B93B, $00C8BC3C

TIDE_TABLE:
    DC.L $00957C21, $00988020, $009B851E, $009F8A1B, $00A38F18, $00A7941D, $00AA9825, $00AD9B2A, $00AD9C2D

*-----------------------------------------------------------
* Subroutine    : Draw Background
* Description   : Draw background elements behind water level
*-----------------------------------------------------------
DRAW_BACKGROUND:
    MOVEM.L D0-D4, -(SP)
* Draw Sky --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SKY,       D1          ; Set Background color
    MOVE.B  #81,        D0          ; Task for Background Color
    TRAP    #15                     ; Trap (Perform action)
	
    ; Set X, Y, Width and Height
    MOVE.L   #0,   D1          	     ; X
    MOVE.L   #0,   D2                ; Y  
    MOVE.L   #0,          D3         ; Clear the value
    MOVE.L   #SCREEN_W,   D3         ; Width
    MOVE.L   #0,          D4         ; Clear the value
    MOVE.L   #SCREEN_H,   D4         ; Height
    
    ; Draw Sky
    MOVE.B  #87,        D0          ; Draw Sky
    TRAP    #15                     ; Trap (Perform action)	
    
    MOVEM.L (SP)+, D0-D4
    RTS

*-----------------------------------------------------------
* Subroutine    : Draw Sand Floor
* Description   : Draw Sand using layered rectangles and ellipses
*-----------------------------------------------------------    
DRAW_SAND:
    MOVEM.L D0-D4, -(SP)

SEAWEED_MID          equ     $00448F0E
SEAWEED_DARK         equ     $0039710F

    MOVE.L   #50,         SAND_Y         ; Set how high sand should be from bottom of the screen

***---------------- SEAWEED PATCH A ----------------***
    MOVE.L   #720,         SEAWEED_X      ; Set Seaweed X location
    MOVE.L   #718,         SEAWEED_Y      ; Set Seaweed Y position

* Draw Seaweed Patch A --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SEAWEED_DARK,      D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SEAWEED_DARK,      D1          ; Set background color
    MOVE.B  #81,                D0          ; Task for Background Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #06,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Draw Seaweed A bottom --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SEAWEED_DARK,      D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for pen Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #10,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #00,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #08,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #30,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed A2 bottom --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SEAWEED_DARK,      D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for pen Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #10,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #19,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #13,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #50,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed B bottom --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #40,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #36,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #20,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed A top --------------------------------
    ; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #08,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #30,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #00,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #70,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed A2 top --------------------------------
    ; Set Pen Width
    MOVE.L  #06,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #13,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #50,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #21,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #85,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed B top --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #36,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #20,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #29,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #48,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed C  --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #-10,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #-15,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #45,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

***---------------- SEAWEED PATCH B ----------------***
    MOVE.L   #160,         SEAWEED_X      ; Set Seaweed X location
    MOVE.L   #738,         SEAWEED_Y      ; Set Seaweed Y position

* Draw Seaweed Patch B --------------------------------

* Draw Seaweed A bottom --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SEAWEED_DARK,      D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for pen Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #08,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #-10,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #00,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #30,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed A2 bottom --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SEAWEED_DARK,      D1          ; Set pen color
    MOVE.B  #80,                D0          ; Task for pen Color
    TRAP    #15                             ; Trap (Perform action)
    ; Set Pen Width
    MOVE.L  #10,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #19,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #13,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #50,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed B bottom --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #40,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #36,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #20,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed A top --------------------------------
    ; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #00,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #30,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #-04,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #70,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed A2 top --------------------------------
    ; Set Pen Width
    MOVE.L  #06,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #13,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #50,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #21,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #85,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed B top --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #34,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #20,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #34,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #52,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

* Draw Seaweed C  --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #40,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #45,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #45,            D4       ; Height
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)

     ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)

* Draw Sand Base --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SAND_MAIN,            D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SAND_MAIN,            D1       ; Set Fill color
    MOVE.B  #81,                   D0       ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
	
    ; Set X, Y, Width and Height
    MOVE.L   #0,          D1         ; Clear the value
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    SAND_Y,      D2        ; Subtract sand height
    MOVE.L   #0,          D3         ; Clear the value
    MOVE.W   SCREEN_W,    D3         ; Width
    MOVE.L   #768,        D4         ; Clear the value
    MOVE.W   SCREEN_H,    D4         ; Height
    
    ; Draw Sand
    MOVE.B  #87,          D0         ; Draw Sand
    TRAP    #15                      ; Trap (Perform action)

* Draw Sand Wave --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SAND_MAIN,            D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #SAND_MAIN,            D1       ; Set Fill color
    MOVE.B  #81,                   D0       ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
	
    ; Set X, Y, Width and Height
    MOVE.L   #-50,        D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    SAND_Y,      D2         ; Subtract sand height
    SUB.L    #15,         D2         ; Subtract relative to sand height
    MOVE.L   #150,        D3         ; Width
    MOVE.W   SCREEN_H,    D4         ; Y
    SUB.L    SAND_Y,      D4         ; Subtract sand height 
    ADD.L    #50,         D4         ; Add wave height  
    
    ; Draw Sand
    MOVE.B  #88,          D0         ; Draw Sand
    TRAP    #15                      ; Trap (Perform action)

* Draw Sand Wave --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L   #130,        D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    SAND_Y,      D2         ; Subtract sand height
    SUB.L    #10,         D2         ; Subtract relative to sand height
    MOVE.L   #395,        D3         ; Width
    MOVE.W   SCREEN_H,    D4         ; Y
    SUB.L    SAND_Y,      D4         ; Subtract sand height 
    ADD.L    #50,         D4         ; Add wave height
    
    ; Draw Sand
    MOVE.B  #88,          D0         ; Draw Sand
    TRAP    #15                      ; Trap (Perform action)

* Draw Sand Wave --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L   #350,        D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    SAND_Y,      D2         ; Subtract sand height
    SUB.L    #07,         D2         ; Subtract relative to sand height
    MOVE.L   #480,        D3         ; Width
    MOVE.W   SCREEN_H,    D4         ; Y
    SUB.L    SAND_Y,      D4         ; Subtract sand height 
    ADD.L    #50,         D4         ; Add wave height
    
    ; Draw Sand
    MOVE.B  #88,          D0         ; Draw Sand
    TRAP    #15                      ; Trap (Perform action)	

* Draw Sand Wave --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L   #440,        D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    SAND_Y,      D2         ; Subtract sand height    
    SUB.L    #10,         D2         ; Subtract relative to sand height
    MOVE.L   #680,        D3         ; Width
    MOVE.W   SCREEN_H,    D4         ; Y
    SUB.L    SAND_Y,      D4         ; Subtract sand height 
    ADD.L    #50,         D4         ; Add wave height
    
    ; Draw Sand
    MOVE.B  #88,          D0         ; Draw Sand
    TRAP    #15                      ; Trap (Perform action)	
    
* Draw Sand Wave --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L   #630,        D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    SAND_Y,      D2         ; Subtract sand height    
    SUB.L    #08,         D2         ; Subtract relative to sand height
    MOVE.L   #830,        D3         ; Width
    MOVE.W   SCREEN_H,    D4         ; Y
    SUB.L    SAND_Y,      D4         ; Subtract sand height 
    ADD.L    #50,         D4         ; Add wave height
    
    ; Draw Sand
    MOVE.B  #88,          D0         ; Draw Sand
    TRAP    #15                      ; Trap (Perform action)	    
    
* Draw Sand Wave --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L   #790,        D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    SAND_Y,      D2         ; Subtract sand height    
    SUB.L    #14,         D2         ; Subtract relative to sand height
    MOVE.L   #1200,       D3         ; Width
    MOVE.W   SCREEN_H,    D4         ; Y
    SUB.L    SAND_Y,      D4         ; Subtract sand height 
    ADD.L    #50,         D4         ; Add wave height  
    
    ; Draw Sand
    MOVE.B  #88,          D0         ; Draw Sand
    TRAP    #15                      ; Trap (Perform action)	    

* Draw Sand (Floor) Gradient -------------------
* ---------- Draw Sand Gradient Section ----------- *
   ; Set Pixel Colors
    MOVE.L  #GRAD_SAND_1,          D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #GRAD_SAND_1,          D1       ; Set Fill color
    MOVE.B  #81,                   D0       ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L   #0,          D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    #24,         D2         ; Subtract gradient height
    MOVE.W   SCREEN_W,    D3         ; Width
    MOVE.L   #0,          D4         ; Y
    MOVE.W   SCREEN_H,    D4         ; Y
    
    ; Draw section
    MOVE.B  #87,        D0          ; Draw Gradient Section
    TRAP    #15                     ; Trap (Perform action)
    
 * ---------- Draw Sand Gradient Section ----------- *
   ; Set Pixel Colors
    MOVE.L  #GRAD_SAND_2,          D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #GRAD_SAND_2,          D1       ; Set Fill color
    MOVE.B  #81,                   D0       ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L   #0,          D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    #18,         D2         ; Subtract gradient height
    MOVE.W   SCREEN_W,    D3         ; Width
    MOVE.W   SCREEN_H,    D4         ; Y
    
    ; Draw section
    MOVE.B  #87,        D0          ; Draw Gradient Section
    TRAP    #15                     ; Trap (Perform action)   
        
 * ---------- Draw Sand Gradient Section ----------- *
   ; Set Pixel Colors
    MOVE.L  #GRAD_SAND_3,          D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #GRAD_SAND_3,          D1       ; Set Fill color
    MOVE.B  #81,                   D0       ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L   #0,          D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    #12,         D2         ; Subtract gradient height
    MOVE.W   SCREEN_W,    D3         ; Width
    MOVE.L   #0,          D4         ; Y
    MOVE.W   SCREEN_H,    D4         ; Y
    
    ; Draw section
    MOVE.B  #87,        D0          ; Draw Gradient Section
    TRAP    #15                     ; Trap (Perform action)  
    
 * ---------- Draw Sand Gradient Section ----------- *
   ; Set Pixel Colors
    MOVE.L  #GRAD_SAND_4,          D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)
    MOVE.L  #GRAD_SAND_4,          D1       ; Set Fill color
    MOVE.B  #81,                   D0       ; Task for Fill Color
    TRAP    #15                             ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L   #0,          D1         ; X
    MOVE.W   SCREEN_H,    D2         ; Y
    SUB.L    #06,         D2         ; Subtract gradient height
    MOVE.W   SCREEN_W,    D3         ; Width
    MOVE.L   #0,          D4         ; Y
    MOVE.W   SCREEN_H,    D4         ; Y
    
    ; Draw section
    MOVE.B  #87,        D0          ; Draw Gradient Section
    TRAP    #15                     ; Trap (Perform action)    
    
    MOVEM.L (SP)+, D0-D4
    RTS    

*-----------------------------------------------------------
* Subroutine    : Draw Player Data
* Description   : Draw Player X, Y, Velocity, Gravity and OnGround - MOSTLY DEBUG
*-----------------------------------------------------------

DRAW_PLYR_DATA:
    MOVEM.L D0-D1/A1, -(SP)
    CLR.L   D1
    
    ; Player X Message
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
    MOVE.W  #$0202,     D1          ; Col 02, Row 02
    TRAP    #15                     ; Trap (Perform action)
    LEA     X_MSG,      A1          ; X Message
    MOVE    #13,        D0          ; No Line feed
    TRAP    #15                     ; Trap (Perform action)
    
    ; Player X
    MOVE.B  #TC_CURSR_P, D0          ; Set Cursor Position
    MOVE.W  #$0502,     D1          ; Col 05, Row 02
    TRAP    #15                     ; Trap (Perform action)
    MOVE.B  #03,        D0          ; Display number at D1.L
    MOVE.L  PLAYER_X,   D1          ; Move X to D1.L
    TRAP    #15                     ; Trap (Perform action)
    
    ; Player Y Message
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
    MOVE.W  #$1002,     D1          ; Col 10, Row 02
    TRAP    #15                     ; Trap (Perform action)
    LEA     Y_MSG,      A1          ; Y Message
    MOVE    #13,        D0          ; No Line feed
    TRAP    #15                     ; Trap (Perform action)
    
    ; Player Y
    MOVE.B  #TC_CURSR_P,D0          ; Set Cursor Position
    MOVE.W  #$1202,     D1          ; Col 12, Row 02
    TRAP    #15                     ; Trap (Perform action)
    MOVE.B  #03,        D0          ; Display number at D1.L
    MOVE.L  PLAYER_Y,   D1          ; Move X to D1.L
    TRAP    #15                     ; Trap (Perform action) 

    
    ; Score label at top center
    MOVE.B  #TC_CURSR_P,D0
    MOVE.W  #$3C00,     D1          ; Col 60, Row 00
    TRAP    #15
    LEA     SCORE_MSG,  A1
    MOVE    #13,        D0          ; No Line feed
    TRAP    #15

    ; Score number right after
    MOVE.B  #TC_CURSR_P,D0
    MOVE.W  #$4300,     D1          ; Col 67, Row 00
    TRAP    #15
    MOVE.B  #03,        D0          ; Display number at D1.L
    MOVE.L  PLAYER_SCORE,D1
    TRAP    #15

    ;; --- rest of debug HUD (X/Y/velocity/etc) disabled for now ---
    ;; Player X Message
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0202,     D1
    ;TRAP    #15
    ;LEA     X_MSG,      A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Player X
    ;MOVE.B  #TC_CURSR_P, D0
    ;MOVE.W  #$0502,     D1
    ;TRAP    #15
    ;MOVE.B  #03,        D0
    ;MOVE.L  PLAYER_X,   D1
    ;TRAP    #15
    ;; Player Y Message
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$1002,     D1
    ;TRAP    #15
    ;LEA     Y_MSG,      A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Player Y
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$1202,     D1
    ;TRAP    #15
    ;MOVE.B  #03,        D0
    ;MOVE.L  PLAYER_Y,   D1
    ;TRAP    #15
    ;; Player Velocity Message
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0203,     D1
    ;TRAP    #15
    ;LEA     V_MSG,      A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Player Velocity
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0503,     D1
    ;TRAP    #15
    ;MOVE.B  #03,        D0
    ;MOVE.L  PLYR_VELOCITY_Y ,D1
    ;TRAP    #15
    ;; Player Gravity Message
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$1003,     D1
    ;TRAP    #15
    ;LEA     G_MSG,      A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Player Gravity
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$1203,     D1
    ;TRAP    #15
    ;MOVE.B  #03,        D0
    ;MOVE.L  PLYR_GRAVITY,D1
    ;TRAP    #15
    ;; Player On Ground Message
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0204,     D1
    ;TRAP    #15
    ;LEA     GND_MSG,    A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Player On Ground
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0604,     D1
    ;TRAP    #15
    ;MOVE.B  #03,        D0
    ;MOVE.L  PLYR_ON_GND,D1
    ;TRAP    #15
    ;; Show Keys Pressed
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$2001,     D1
    ;TRAP    #15
    ;LEA     KEYCODE_MSG, A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Show KeyCode
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$3001,     D1
    ;TRAP    #15
    ;MOVE.L  CURRENT_KEY,D1
    ;MOVE.B  #03,        D0
    ;TRAP    #15
    ;; Show if Update is Running
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0205,     D1
    ;TRAP    #15
    ;LEA     UPDATE_MSG, A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Show if Draw is Running
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0206,     D1
    ;TRAP    #15
    ;LEA     DRAW_MSG,   A1
    ;MOVE    #13,        D0
    ;TRAP    #15
    ;; Show if Idle is Running
    ;MOVE.B  #TC_CURSR_P,D0
    ;MOVE.W  #$0207,     D1
    ;TRAP    #15
    ;LEA     IDLE_MSG,   A1
    ;MOVE    #13,        D0
    ;TRAP    #15

    MOVEM.L (SP)+, D0-D1/A1
    RTS  

*-----------------------------------------------------------
* Subroutine    : Flip_X
* Description   : Flip D1 & D3 horizontally around POS_X
*-----------------------------------------------------------
FLIP_X:

; D7 = sprite width

    ; Flip D1
    SUB.L   POS_X, D1
    NEG.L   D1
    ADD.L   D7, D1
    ADD.L   POS_X, D1

    ; Flip D3
    SUB.L   POS_X, D3
    NEG.L   D3
    ADD.L   D7, D3
    ADD.L   POS_X, D3    
    
    RTS

*-----------------------------------------------------------
* Subroutine    : Draw Enemy
* Description   : Draw Enemy Square
*-----------------------------------------------------------
DRAW_ENEMY:
    ; Set Pixel Colors
    ;MOVE.L  #RED,       D1          ; Set Background color
    ;MOVE.B  #80,        D0          ; Task for Background Color
    ;TRAP    #15                     ; Trap (Perform action
    ;MOVE.L  #PURPLE,     	D1          ; Set Fill color
    ;MOVE.B  #81,        D0          ; Task for Fill Color
    ;TRAP    #15                     ; Trap (Perform action))

    ; Set X, Y, Width and Height
    ;MOVE.L  ENEMY_X,    D1          ; X
    ;MOVE.L  ENEMY_Y,    D2          ; Y
    ;MOVE.L  ENEMY_X,    D3
    ;ADD.L   #ENMY_W_INIT,   D3      ; Width
    ;MOVE.L  ENEMY_Y,    D4 
    ;ADD.L   #ENMY_H_INIT,   D4      ; Height
    
    ; Draw Enemy    
    ;MOVE.B  #87,        D0          ; Draw Enemy
    ;TRAP    #15                     ; Trap (Perform action)
    RTS                             ; Return to subroutine

*-----------------------------------------------------------
* Section       : Variables
* Description   : Define Variables
*-----------------------------------------------------------
POS_X   DS.L    01      ; Stores fish instance X and used to draw
POS_Y   DS.L    01      ; Stores fish instance Y and used to draw
FISH_DIRECTION_X    DS.L    01

SAND_Y  DS.L    01      ; How high to draw sand from the bottom of the screen

SEAWEED_X DS.L		01
SEAWEED_Y DS.L		01

*-----------------------------------------------------------
* Section       : Graphic Colors
* Description   : Screen Pixel Color
*-----------------------------------------------------------
WHITE           EQU     $00FFFFFF
RED             EQU     $000000FF
BLACK 			equ	 	$00000000 
MAROON 			equ 	$00000080 
GREEN 			equ 	$00008000 
OLIVE 			equ 	$00008080 
NAVY 			equ 	$00800000 
PURPLE 			equ 	$00800080 
TEAL 			equ 	$00808000 
GRAY 			equ 	$00808080 
LIME 			equ 	$0000FF00 
YELLOW 			equ 	$0000FFFF 
BLUE 			equ 	$00FF0000 
FUCHSIA 		equ 	$00FF00FF 
AQUA 			equ 	$00FFFF00 
LTGRAY 			equ	 	$00C0C0C0 

SKY             equ     $00F5E297
HIGHTIDE        equ     $00AD9C2D 
LOWTIDE         equ     $00937A21
WATERLINE       equ     $00F7F5EB

SAND_MAIN       equ     $00A7B7BD

GRAD_SAND_1      equ     $00A5B5BB
GRAD_SAND_2      equ     $009DADB3
GRAD_SAND_3      equ     $0090A0A7
GRAD_SAND_4      equ     $0081929B
GRAD_SAND_5      equ     $0070838D

GRAD_TIDE_1      equ     $00AD9C2D 
GRAD_TIDE_2      equ     $00AD9B2A 
GRAD_TIDE_3      equ     $00AA9825 
GRAD_TIDE_4      equ     $00A7941D 
GRAD_TIDE_5      equ     $00A38F18 
GRAD_TIDE_6      equ     $009F8A1B
GRAD_TIDE_7      equ     $009B851E
GRAD_TIDE_8      equ     $00988020
GRAD_TIDE_9      equ     $00957C21

GRAD_SHALLOWS_1      equ     $00C8BC3C
GRAD_SHALLOWS_2      equ     $00C6B93B
GRAD_SHALLOWS_3      equ     $00C2B539
GRAD_SHALLOWS_4      equ     $00BDAF36
GRAD_SHALLOWS_5      equ     $00B7A733
GRAD_SHALLOWS_6      equ     $00B2A130
GRAD_SHALLOWS_7      equ     $00AE9E2E

PLAYER_DARKGOLD      equ     $00029EE8
PLAYER_LIGHTGOLD     equ     $0009BAFD 
PLAYER_ORANGE        equ     $000561EE
PLAYER_BLUE          equ     $00C26624










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
