CODE SEGMENT
ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    number DW 0Fh       ; 16-bit hexadecimal number to be squared
DATA ENDS

EXTRA SEGMENT
    result DW ?          ; Storage for the low 16 bits of the result
    resultHigh DW ?      ; Storage for the high 16 bits of the result
EXTRA ENDS

START:
    MOV AX, DATA         ; Load DATA segment into AX
    MOV DS, AX           ; Set DS to point to DATA segment

    MOV AX, number       ; Load the value of 'number' into AX
    MOV BX, AX           ; Copy the value of 'number' to BX
    MUL BX               ; Multiply AX by BX (AX = number * number)
    
    ; Store the result
    MOV result, AX       ; Store the low 16 bits of the result in 'result'
    MOV resultHigh, DX   ; Store the high 16 bits of the result in 'resultHigh'

    INT 03H              ; Interrupt to terminate the program (for debugging)

CODE ENDS
END START
