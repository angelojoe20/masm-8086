ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    LIST DW 0014h, 0233h, 0027h, 0357h, 0010h   ; Our input list
    COUNT EQU 5                                ; Number of elements
DATA ENDS

CODE SEGMENT
START:
    MOV AX, DATA         ; Initialize data segment
    MOV DS, AX

    MOV SI, OFFSET LIST  ; SI points to start of LIST
    MOV CX, COUNT        ; CX holds the number of elements

    ; Step 1: Build the max heap
    CALL HEAPIFY_ALL

    ; Step 2: Perform heap sort
    CALL HEAP_SORT

    ; Program ends
    INT 03H

; Function to build a max heap
HEAPIFY_ALL PROC
    MOV BX, COUNT        ; BX = COUNT
    DEC BX               ; Start heapify from the last parent node
HEAPIFY_LOOP:
    PUSH BX              ; Save current BX
    CALL HEAPIFY         ; Call heapify for node BX
    POP BX               ; Restore BX
    DEC BX               ; Move to the previous parent node
    JNS HEAPIFY_LOOP     ; Repeat until BX reaches 0
    RET
HEAPIFY_ALL ENDP

; Function to heapify a subtree rooted at BX
HEAPIFY PROC
    MOV DX, BX           ; DX holds the current root index
    MOV SI, OFFSET LIST  ; SI points to LIST

    ; Calculate left child index (2*BX)
    MOV DI, BX           ; Copy BX (current root index) to DI
    SHL DI, 1            ; DI = BX * 2 (left child index)
    ADD DI, SI           ; DI now holds the address of the left child

    ; Check if left child index is out of bounds
    MOV AX, COUNT
    SHL AX, 1            ; AX = COUNT * 2 (size of list in bytes)
    ADD AX, SI           ; Calculate upper bound address (end of the list)
    CMP DI, AX           ; Compare left child address with the upper bound
    JAE NO_LEFT_CHILD    ; If out of bounds, skip left child processing

    MOV AX, [DI]         ; Load left child into AX
    MOV DI, DX           ; Use DI to hold the root index
    SHL DI, 1            ; Multiply DX by 2 to calculate root address
    ADD DI, SI           ; Calculate address of the root
    CMP AX, [DI]         ; Compare left child with root
    JBE CHECK_RIGHT      ; If root >= left child, skip to right

    XCHG AX, [DI]        ; Swap root and left child
    MOV [DI], AX         ; Update root with swapped value
    MOV DX, BX           ; Update root to left child
    JMP HEAPIFY          ; Recursively heapify affected subtree

CHECK_RIGHT:
    INC BX               ; Calculate right child index
    SHL BX, 1            ; BX = BX * 2 (right child index)
    ADD BX, SI           ; Calculate address of the right child
    CMP BX, AX           ; Check if right child is within bounds
    JAE NO_RIGHT_CHILD   ; If out of bounds, skip right child processing

    MOV DI, BX           ; Use DI for right child index
    MOV AX, [DI]         ; Load right child into AX
    MOV DI, DX           ; Recalculate root index
    SHL DI, 1            ; Multiply DX by 2 to calculate root address
    ADD DI, SI           ; Calculate address of the root
    CMP AX, [DI]         ; Compare right child with root
    JBE NO_RIGHT_CHILD   ; If root >= right child, we're done

    XCHG AX, [DI]        ; Swap root and right child
    MOV [DI], AX         ; Update root with swapped value
    MOV DX, BX           ; Update root to right child
    JMP HEAPIFY          ; Recursively heapify affected subtree

NO_LEFT_CHILD:
NO_RIGHT_CHILD:
    RET
HEAPIFY ENDP

; Function to perform heap sort
HEAP_SORT PROC
    MOV CX, COUNT         ; CX holds the current size of the heap
HEAP_SORT_LOOP:
    DEC CX                ; Decrease the size of the heap
    MOV DI, CX
    SHL DI, 1             ; Calculate the last element's address
    ADD DI, SI            ; Add to base address

    MOV AX, [SI]          ; Swap the root (max) with the last element
    XCHG AX, [DI]         ; Swap root and last element
    MOV [SI], AX          ; Store the swapped root at the start

    CALL HEAPIFY_ALL      ; Heapify the reduced heap
    JNZ HEAP_SORT_LOOP    ; Continue until only one element remains
    RET
HEAP_SORT ENDP

CODE ENDS
END START
