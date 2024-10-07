CODE SEGMENT
ASSUME CS: CODE, DS: DATA, ES: EXTRA

DATA SEGMENT
    OPR1 DW 5169H        
    OPR2 DW 1000H        
DATA ENDS

EXTRA SEGMENT
    SUM DW ?             
EXTRA ENDS

START:
    MOV AX, DATA         
    MOV DS, AX           ; Register Addresing
    MOV AX, OPR1         ; Direct addressing 
    ADD AX, OPR2         ; Direct addressing 
    MOV SUM, AX          ; Direct addressing mode
    INT 03H              

CODE ENDS
END START
