CODE SEGMENT
ASSUME CS: CODE, DS: DATA, ES: EXTRA

DATA SEGMENT
    OPR1 DW 5169H        
    OPR2 DW 1000H        
DATA ENDS

EXTRA SEGMENT
    RES DW 2 DUP(0)      
EXTRA ENDS

START:
    MOV AX, DATA         ; REGISTER ADDRESING MODE
    MOV DS, AX           
    MOV AX, EXTRA
    MOV ES, AX           ; REGISTER ADDRESING MODE
    MOV SI, OFFSET OPR1  
    MOV AX, [SI]         ; INDEXED ADDRESING MODE
    MOV BX, OPR2         ; DIRECT ADDRESSING MODE
    MUL BX               ; REGISTER ADDRESSING MODE
    MOV RES, AX          ; DIRECT ADDRESSING MODE
    MOV RES+2, DX        ; DIRECT ADDRESSING MODE
    INT 03H              

CODE ENDS
END START
