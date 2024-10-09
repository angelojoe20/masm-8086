ASSUME CS:CODE, DS:DATA, ES:EXTRA
DATA SEGMENT
    STRING DB 'RADAR$'
    STRLEN EQU ($-STRING-1) ; Length of the string excluding the '$'
    PALINDROME_MSG DB 'STRING IS A PALINDROME$', 0DH, 0AH, '$'
    NOT_PALINDROME_MSG DB 'STRING IS NOT A PALINDROME$', 0DH, 0AH, '$'
DATA ENDS

EXTRA SEGMENT
    TEMP DB 0
EXTRA ENDS

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX
    MOV AX, EXTRA
    MOV ES, AX
    MOV SI, OFFSET STRING
    MOV DI, OFFSET STRING
    ADD DI, STRLEN-1 ; Point DI to the last character of the string
    MOV CX, STRLEN/2 ; Compare half the length of the string
    CLD

CHECK_LOOP:
    MOV AL, DS:[SI]
    MOV BL, DS:[DI]
    CMP AL, BL
    JNE NOT_PALINDROME
    INC SI
    DEC DI
    LOOP CHECK_LOOP

    ; If all characters match, the string is a palindrome
    MOV DX, OFFSET PALINDROME_MSG
    JMP DISPLAY_MSG

NOT_PALINDROME:
    ; If any character does not match, the string is not a palindrome
    MOV DX, OFFSET NOT_PALINDROME_MSG

DISPLAY_MSG:
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH
    INT 21H

CODE ENDS
END START