ASSUME CS:CODE, DS:DATA
DATA SEGMENT
    LIST DW 0125H, 0144H, 3001H, 0003H, 0002H  ; Array of 16-bit numbers
    COUNT EQU 05H                               ; Number of elements
DATA ENDS

CODE SEGMENT
START:
    MOV AX, DATA        ; Initialize data segment
    MOV DS, AX

    MOV DX, COUNT-1     ; Set DX to the number of elements - 1
BACK:
    MOV CX, DX          ; CX is the inner loop counter
    MOV SI, OFFSET LIST ; SI points to the start of the array
AGAIN:
    MOV AX, [SI]        ; Load first number into AX
    CMP AX, [SI+2]      ; Compare with next number
    JAE GO              ; If AX >= [SI+2], skip swapping
    XCHG AX, [SI+2]     ; Swap the two numbers if necessary
    XCHG AX, [SI]       ; Put the swapped number back into memory
GO:
    INC SI              ; Move to the next pair of elements
    INC SI
    LOOP AGAIN          ; Repeat for all elements in the current pass

    DEC DX              ; Decrement DX (outer loop counter)
    JNZ BACK            ; If DX != 0, repeat outer loop

    INT 03H             ; Breakpoint interrupt to stop execution
CODE ENDS
END START
