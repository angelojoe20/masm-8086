CODE SEGMENT
ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    number DB 05h          ; 8-bit hexadecimal number to compute factorial
DATA ENDS

EXTRA SEGMENT
    result DW ?            ; Storage for the result
EXTRA ENDS

START:
    MOV AX, DATA           ; Load DATA segment into AX
    MOV DS, AX             ; Set DS to point to DATA segment

    MOV AL, number         ; Load the value of 'number' into AL
    MOV CL, AL             ; Set CL as the counter for the loop
    MOV AX, 1              ; Initialize AX to 1 for factorial calculation

FACTORIAL_LOOP:
    MUL CL                 ; Multiply AX by CL
    DEC CL                 ; Decrement CL
    JNZ FACTORIAL_LOOP     ; Repeat until CL is zero

    MOV result, AX         ; Store the final result in 'result'

    INT 03H                ; Interrupt to terminate the program (for debugging)

CODE ENDS
END START