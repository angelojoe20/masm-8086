CODE SEGMENT
ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    a DW 05h       
    x DW 04h       
    b DW 02h       
DATA ENDS

EXTRA SEGMENT
    result DW ?
    sum DW ?
EXTRA ENDS

START:
    MOV AX, DATA         ; Load DATA segment into AX
    MOV DS, AX           ; Set DS to point to DATA segment

    MOV AX, a            ; Load value of 'a' into AX

    MOV BX, x            ; Load value of 'x' into BX
    MUL BX
    MOV result, AX   
    MOV CX, b            ; Load value of 'b' into CX
    ADD AX, CX           ; Add CX (b) to AX
    MOV SUM, AX          ; Store the final result in SUM

    INT 03H              

CODE ENDS
END START
