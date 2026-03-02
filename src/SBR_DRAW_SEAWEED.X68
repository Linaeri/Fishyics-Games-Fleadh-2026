*-----------------------------------------------------------
* Title      : SBR_DRAW_SEAWEED
* Description: 	Output to the screen - text and image
* Subroutines: (in this order:)

*	DRAW_SEAWEED

*  Data:	Colour HEX codes as named constants
*-----------------------------------------------------------

*-----------------------------------------------------------
* Subroutine    : Draw Seaweed
* Description   : Draw top layer seaweed
*-----------------------------------------------------------
DRAW_SEAWEED:

***---------------- SEAWEED PATCH A ----------------***    
    MOVE.L   #720,         SEAWEED_X      ; Set Seaweed X location
    MOVE.L   #718,         SEAWEED_Y      ; Set Seaweed Y position

* Draw Seaweed MID D bottom --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SEAWEED_MID,            D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)    
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #30,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #25,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #25,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)  

* Draw Seaweed MID G bottom --------------------------------  
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #-12,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #-07,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #20,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)         

* Draw Seaweed mid D top --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #25,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #25,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #30,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #36,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)    
    
* Draw Seaweed mid G top --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #-07,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #20,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #-12,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #31,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)       
               
* Draw Seaweed MID E bottom --------------------------------
    ; Set Pen Width
    MOVE.L  #08,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #10,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #15,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #45,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)                      

* Draw Seaweed MID E top --------------------------------
    ; Set Pen Width
    MOVE.L  #06,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #15,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #45,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #10,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #80,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)              
    
     ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)             
    
     ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)    

***---------------- SEAWEED PATCH B ----------------***
    MOVE.L   #160,         SEAWEED_X      ; Set Seaweed X location
    MOVE.L   #738,         SEAWEED_Y      ; Set Seaweed Y position
    
* Draw Seaweed Patch B --------------------------------

* Draw Seaweed MID D bottom --------------------------------
    ; Set Pixel Colors
    MOVE.L  #SEAWEED_MID,            D1       ; Set Pen color
    MOVE.B  #80,                   D0       ; Task for Pen Color
    TRAP    #15                             ; Trap (Perform action)    
    ; Set Pen Width
    MOVE.L  #04,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #30,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #25,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #25,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)  
    
* Draw Seaweed MID H --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #05,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #00,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #48,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)      

* Draw Seaweed MID G bottom --------------------------------  
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #-17,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #-12,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #20,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)         

* Draw Seaweed mid D top --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #25,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #25,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #30,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #36,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)    
    
* Draw Seaweed mid G top --------------------------------
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #-12,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #20,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #-17,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #31,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)       
               
* Draw Seaweed MID E bottom --------------------------------
    ; Set Pen Width
    MOVE.L  #07,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #10,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #00,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #15,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #45,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)                      

* Draw Seaweed MID E top --------------------------------
    ; Set Pen Width
    MOVE.L  #05,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)
    ; Set X, Y, Width and Height
    MOVE.L  SEAWEED_X,      D1       ; X origin
    ADD.L   #15,            D1       ; X Offset
    MOVE.L  SEAWEED_Y,      D2       ; Y origin
    SUB.L   #45,            D2       ; Y Offset
    MOVE.L  SEAWEED_X,      D3       ; X Origin
    ADD.L   #24,            D3       ; Width
    MOVE.L  SEAWEED_Y,      D4       ; Y origin
    SUB.L   #68,            D4       ; Height
    
    ; Draw Seaweed
    MOVE.B  #84,          D0         ; Draw Line
    TRAP    #15                      ; Trap (Perform action)              
    
     ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)             
    
     ; ReSet Pen Width
    MOVE.L  #01,    D1          ; Set pen pixel width
    MOVE.B  #93,    D0          ; Task for Pen Color
    TRAP    #15                 ; Trap (Perform action)    

	RTS







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
