CODE SEGMENT
ASSUME CS:CODE, DS:DATA, ES:EXTRA, SS:STACK  ; Declare SS to use STACK

DATA SEGMENT
    OPR1 DW 5169H        ; First operand
    OPR2 DW 1000H        ; Second operand
DATA ENDS

EXTRA SEGMENT
    RES DW 2 DUP(0)      ; Reserve space for result (2 words)
EXTRA ENDS

STACK SEGMENT
    DW 128 DUP(0)        ; Reserve space for the stack (128 words)
STACK ENDS

START:
    MOV AX, DATA         ; Initialize the data segment
    MOV DS, AX           
    MOV AX, EXTRA        ; Initialize the extra segment
    MOV ES, AX           

    MOV AX, STACK        ; Initialize the stack segment
    MOV SS, AX           ; Set stack segment register
    MOV SP, 128          ; Set the stack pointer to the top of the stack

    MOV SI, OFFSET OPR1  ; Indexed addressing mode - Load address of OPR1 into SI
    MOV AX, [SI]         ; Indexed addressing mode - Load OPR1 into AX
    MOV BX, OPR2         ; Direct addressing mode - Load OPR2 into BX
    MUL BX               ; Multiply AX by BX, result stored in AX and DX
    MOV RES, AX          ; Store lower word of result in RES
    MOV RES+2, DX        ; Store upper word of result in RES+2

    INT 03H              ; Interrupt to stop the program
CODE ENDS
END START
