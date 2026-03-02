;little dots that shoot out when a fish gets eaten
;set LFTOVR_SPAWN_X/Y before calling SPAWN_LEFTOVERS

LFTOVR_MAX          EQU     24      ;pool size
LFTOVR_PER_EAT      EQU     6       ;particles per eat event
LFTOVR_LIFETIME     EQU     24      ;how long they last

;clear all the slots
INIT_LEFTOVERS:
    LEA     LFTOVR_TBL_ACTIVE, A0
    MOVE.L  #LFTOVR_MAX-1, D7
.IL_CLR:
    MOVE.L  #0, (A0)+
    DBRA    D7, .IL_CLR
    RTS

;shoot out particles from the eat point
SPAWN_LEFTOVERS:
    MOVEM.L D0-D7/A0-A6, -(SP)

    LEA     LFTOVR_TBL_ACTIVE, A0
    LEA     LFTOVR_TBL_X, A1
    LEA     LFTOVR_TBL_Y, A2
    LEA     LFTOVR_TBL_VX, A3
    LEA     LFTOVR_TBL_VY, A4
    LEA     LFTOVR_TBL_LIFE, A5

    MOVE.L  #LFTOVR_PER_EAT, D6    ;how many left to spawn
    MOVE.L  #0, D7                 ;slot index

.SL_FIND:
    CMP.L   #LFTOVR_MAX, D7
    BGE     .SL_EXIT
    CMP.L   #0, D6
    BLE     .SL_EXIT

    MOVE.L  D7, D0
    ASL.L   #2, D0
    TST.L   0(A0,D0.L)
    BNE     .SL_NEXT

    ;activate slot
    MOVE.L  #1, 0(A0,D0.L)

    ;position = spawn point
    MOVE.L  LFTOVR_SPAWN_X, D1
    MOVE.L  D1, 0(A1,D0.L)
    MOVE.L  LFTOVR_SPAWN_Y, D1
    MOVE.L  D1, 0(A2,D0.L)

    ;random VX: -1 to +1
    MOVEM.L D0/D6-D7/A0-A5, -(SP)
    MOVE.L  #0, D0
    MOVE.L  #2, D1
    JSR     RANDOM
    MOVEM.L (SP)+, D0/D6-D7/A0-A5
    SUB.L   #1, D3
    MOVE.L  D3, 0(A3,D0.L)

    ;random VY: -2 to 0 (gentle upward drift)
    MOVEM.L D0/D6-D7/A0-A5, -(SP)
    MOVE.L  #0, D0
    MOVE.L  #2, D1
    JSR     RANDOM
    MOVEM.L (SP)+, D0/D6-D7/A0-A5
    SUB.L   #2, D3
    MOVE.L  D3, 0(A4,D0.L)

    ;set lifetime
    MOVE.L  #LFTOVR_LIFETIME, 0(A5,D0.L)

    SUB.L   #1, D6

.SL_NEXT:
    ADD.L   #1, D7
    BRA     .SL_FIND

.SL_EXIT:
    MOVEM.L (SP)+, D0-D7/A0-A6
    RTS

;move particles, apply gravity, kill when lifetime runs out
UPDATE_LEFTOVERS:
    MOVEM.L D0-D5/A0-A5, -(SP)

    LEA     LFTOVR_TBL_ACTIVE, A0
    LEA     LFTOVR_TBL_X, A1
    LEA     LFTOVR_TBL_Y, A2
    LEA     LFTOVR_TBL_VX, A3
    LEA     LFTOVR_TBL_VY, A4
    LEA     LFTOVR_TBL_LIFE, A5

    MOVE.L  #LFTOVR_MAX-1, D5

.UL_LOOP:
    MOVE.L  D5, D0
    ASL.L   #2, D0

    TST.L   0(A0,D0.L)
    BEQ     .UL_NXT

    ;decrement lifetime
    SUB.L   #1, 0(A5,D0.L)
    TST.L   0(A5,D0.L)
    BGT     .UL_ALIVE

    ;lifetime expired, deactivate
    MOVE.L  #0, 0(A0,D0.L)
    BRA     .UL_NXT

.UL_ALIVE:
    ;apply VX to X
    MOVE.L  0(A3,D0.L), D1
    ADD.L   D1, 0(A1,D0.L)

    ;apply VY to Y
    MOVE.L  0(A4,D0.L), D1
    ADD.L   D1, 0(A2,D0.L)

.UL_NXT:
    DBRA    D5, .UL_LOOP

    MOVEM.L (SP)+, D0-D5/A0-A5
    RTS

;draw the dots, they fade from white to grey and shrink over time
DRAW_LEFTOVERS:
    MOVEM.L D0-D7/A0-A5, -(SP)

    LEA     LFTOVR_TBL_ACTIVE, A0
    LEA     LFTOVR_TBL_X, A1
    LEA     LFTOVR_TBL_Y, A2
    LEA     LFTOVR_TBL_LIFE, A5

    MOVE.L  #LFTOVR_MAX-1, D7

.DL_LOOP:
    MOVE.L  D7, D0
    ASL.L   #2, D0

    TST.L   0(A0,D0.L)
    BEQ     .DL_NXT

    ;colour based on how much lifetime is left
    MOVE.L  0(A5,D0.L), D1
    CMP.L   #18, D1
    BGE     .DL_C1
    CMP.L   #12, D1
    BGE     .DL_C2
    CMP.L   #6, D1
    BGE     .DL_C3
    BRA     .DL_C4

.DL_C1:
    MOVE.L  #$00FFFFFF, D1          ;bright white
    BRA     .DL_SETCLR
.DL_C2:
    MOVE.L  #$00C0C0C0, D1          ;light grey
    BRA     .DL_SETCLR
.DL_C3:
    MOVE.L  #$00808080, D1          ;medium grey
    BRA     .DL_SETCLR
.DL_C4:
    MOVE.L  #$00505050, D1          ;dim grey

.DL_SETCLR:
    MOVE.B  #80, D0                 ;set pen color
    TRAP    #15

    ;reload slot offset (D0 was used by trap)
    MOVE.L  D7, D0
    ASL.L   #2, D0

    MOVE.L  0(A1,D0.L), D5         ;X
    MOVE.L  0(A2,D0.L), D6         ;Y

    ;size based on lifetime
    ;early=3px  mid=2px  late=1px
    MOVE.L  0(A5,D0.L), D0

    CMP.L   #16, D0
    BGE     .DL_SZ3
    CMP.L   #8, D0
    BGE     .DL_SZ2
    BRA     .DL_SZ1

.DL_SZ3:
    ;3px horizontal line
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    ADD.L   #2, D3
    MOVE.L  D6, D4
    BRA     .DL_DRAW

.DL_SZ2:
    ;2px horizontal line
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    ADD.L   #1, D3
    MOVE.L  D6, D4
    BRA     .DL_DRAW

.DL_SZ1:
    ;1px dot (line from point to same point)
    MOVE.L  D5, D1
    MOVE.L  D6, D2
    MOVE.L  D5, D3
    MOVE.L  D6, D4

.DL_DRAW:
    MOVE.B  #84, D0                 ;draw line
    TRAP    #15

.DL_NXT:
    DBRA    D7, .DL_LOOP

    MOVEM.L (SP)+, D0-D7/A0-A5
    RTS


; ---- DATA ----
LFTOVR_TBL_X       DS.L    LFTOVR_MAX
LFTOVR_TBL_Y       DS.L    LFTOVR_MAX
LFTOVR_TBL_VX      DS.L    LFTOVR_MAX      ;horizontal scatter
LFTOVR_TBL_VY      DS.L    LFTOVR_MAX      ;vertical (negative = up)
LFTOVR_TBL_LIFE    DS.L    LFTOVR_MAX      ;remaining frames of life
LFTOVR_TBL_ACTIVE  DS.L    LFTOVR_MAX

;caller sets these before calling SPAWN_LEFTOVERS
LFTOVR_SPAWN_X     DS.L    1
LFTOVR_SPAWN_Y     DS.L    1


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
