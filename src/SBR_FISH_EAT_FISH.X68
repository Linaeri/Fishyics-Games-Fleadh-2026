*-----------------------------------------------------------
* Subroutine    : FISH_EAT_FISH
* Description   : Bigger fish eats smaller on coll
*-----------------------------------------------------------
FISH_EAT_FISH:
    MOVEM.L D0-D6/A0-A3, -(SP)
    MOVE.L  #0, FEF_I           ;outer index

;outer loop
FEF_OUTER:
    MOVE.L  FEF_I, D0
    CMP.L   #NUM_ENEMIES, D0
    BGE     FEF_DONE

    ASL.L   #2, D0
    LEA     ENEMY_TABLE_X, A0
    MOVE.L  (A0,D0.L), D1       ;A0 table, D0 offset
    CMP.L   #-100, D1
    BLE     FEF_NEXT_OUTER

    MOVE.L  FEF_I, D0
    ADD.L   #1, D0
    MOVE.L  D0, FEF_J

;inner loop
FEF_INNER:
    MOVE.L  FEF_J, D0           ;inner index
    CMP.L   #NUM_ENEMIES, D0
    BGE     FEF_NEXT_OUTER

    ASL.L   #2, D0
    LEA     ENEMY_TABLE_X, A0
    MOVE.L  (A0,D0.L), D1
    CMP.L   #-100, D1
    BLE     FEF_NEXT_INNER

    ;get i offset and data
    MOVE.L  FEF_I, D0
    ASL.L   #2, D0
    LEA     ENEMY_TABLE_X, A0
    LEA     ENEMY_TABLE_Y, A1
    LEA     ENEMY_TABLE_TYPE, A2
    MOVE.L  (A0,D0.L), D1          ;Xi
    MOVE.L  (A1,D0.L), D2          ;Yi
    MOVE.L  (A2,D0.L), D3          ;type_i

    ;get i width/height
    MOVE.L  D3, D5
    MOVEM.L D0-D3, -(SP)
    BSR     GET_PROPS
    MOVEM.L (SP)+, D0-D3
    MOVE.L  PROP_W(A3), FISH_TEMP_WI
    MOVE.L  PROP_H(A3), FISH_TEMP_HI

    ;get j offset and data
    MOVE.L  FEF_J, D0
    ASL.L   #2, D0
    MOVE.L  (A0,D0.L), D4          ;Xj
    MOVE.L  (A1,D0.L), D5          ;Yj
    MOVE.L  (A2,D0.L), D6          ;type_j

    ;get j width/height
    MOVEM.L D0-D6, -(SP)
    MOVE.L  D6, D5
    BSR     GET_PROPS
    MOVEM.L (SP)+, D0-D6
    MOVE.L  PROP_W(A3), FISH_TEMP_WJ
    MOVE.L  PROP_H(A3), FISH_TEMP_HJ

    ;same type? skip
    CMP.L   D3, D6
    BEQ     FEF_NEXT_INNER

    ;AABB: Xi < Xj + Wj?
    MOVE.L  D4, D0
    ADD.L   FISH_TEMP_WJ, D0
    CMP.L   D0, D1
    BGE     FEF_NEXT_INNER

    ;Xi + Wi > Xj?
    MOVE.L  D1, D0
    ADD.L   FISH_TEMP_WI, D0
    CMP.L   D4, D0
    BLE     FEF_NEXT_INNER

    ;Yi < Yj + Hj?
    MOVE.L  D5, D0
    ADD.L   FISH_TEMP_HJ, D0
    CMP.L   D0, D2
    BGE     FEF_NEXT_INNER

    ;Yi + Hi > Yj?
    MOVE.L  D2, D0
    ADD.L   FISH_TEMP_HI, D0
    CMP.L   D5, D0
    BLE     FEF_NEXT_INNER

    ;overlap, smaller type gets eaten
    LEA     ENEMY_TABLE_X, A0
    CMP.L   D6, D3
    BLT     FEF_EAT_I              ;type_i < type_j, i is smaller
    
    ;else j is smaller
    MOVE.L  FEF_J, D0
    ASL.L   #2, D0
    MOVE.L  #-200, (A0,D0.L)
    LEA     ENEMY_TABLE_DIR, A1
    MOVE.L  #-1, (A1,D0.L)         ;force left so it resets next frame
    ;spawn bone crumbs at j's position
    MOVE.L  D4, LFTOVR_SPAWN_X
    MOVE.L  D5, LFTOVR_SPAWN_Y
    MOVEM.L D0-D6/A0-A2, -(SP)
    JSR     SPAWN_LEFTOVERS
    MOVEM.L (SP)+, D0-D6/A0-A2
    BRA     FEF_NEXT_INNER

FEF_EAT_I:
    MOVE.L  FEF_I, D0
    ASL.L   #2, D0
    MOVE.L  #-200, (A0,D0.L)
    LEA     ENEMY_TABLE_DIR, A1
    MOVE.L  #-1, (A1,D0.L)         ;force left so it resets next frame
    ;spawn bone crumbs at i's position
    MOVE.L  D1, LFTOVR_SPAWN_X
    MOVE.L  D2, LFTOVR_SPAWN_Y
    MOVEM.L D0-D6/A0-A2, -(SP)
    JSR     SPAWN_LEFTOVERS
    MOVEM.L (SP)+, D0-D6/A0-A2
    BRA     FEF_NEXT_OUTER

FEF_NEXT_INNER:
    ADD.L   #1, FEF_J
    BRA     FEF_INNER

FEF_NEXT_OUTER:
    ADD.L   #1, FEF_I
    BRA     FEF_OUTER

FEF_DONE:
    MOVEM.L (SP)+, D0-D6/A0-A3
    RTS

FEF_I              DS.L    1
FEF_J              DS.L    1
FISH_TEMP_WI       DS.L    1
FISH_TEMP_HI       DS.L    1
FISH_TEMP_WJ       DS.L    1
FISH_TEMP_HJ       DS.L    1


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
