ASSUME CS:CODE, DS:DATA

DATA SEGMENT
    LIST DW 0014h, 0233h, 0027h, 0357h  ; Our input list
    COUNT EQU 4                         ; Number of elements
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
    PUSH CX              ; Save CX
    PUSH DX              ; Save DX

    MOV DX, BX           ; DX = BX (root index)
    MOV DI, DX           ; DI = root index
    SHL DI, 1            ; DI = DI * 2 (root offset)
    ADD DI, SI           ; DI = base + root offset
    MOV AX, [DI]         ; Load root into AX

    ; Calculate left child index
    MOV BX, DX           ; BX = root index
    SHL BX, 1            ; BX = BX * 2 (left child offset)
    ADD BX, SI           ; BX = base + left child offset
    CMP BX, OFFSET LIST + (COUNT * 2)  ; Check if left child is within bounds
    JAE NO_LEFT_CHILD    ; If out of bounds, skip left child processing

    MOV CX, [BX]         ; Load left child into CX
    CMP AX, CX           ; Compare root with left child
    JAE CHECK_RIGHT      ; If root >= left child, check right child

    XCHG AX, CX          ; Swap root and left child
    MOV [DI], CX         ; Update root with swapped value
    MOV DX, BX           ; Update root to left child
    JMP HEAPIFY          ; Recursively heapify affected subtree

CHECK_RIGHT:
    ADD BX, 2            ; Calculate right child offset
    CMP BX, OFFSET LIST + (COUNT * 2)  ; Check if right child is within bounds
    JAE NO_RIGHT_CHILD   ; If out of bounds, skip right child processing

    MOV CX, [BX]         ; Load right child into CX
    CMP AX, CX           ; Compare root with right child
    JAE NO_RIGHT_CHILD   ; If root >= right child, we're done

    XCHG AX, CX          ; Swap root and right child
    MOV [DI], CX         ; Update root with swapped value
    MOV DX, BX           ; Update root to right child
    JMP HEAPIFY          ; Recursively heapify affected subtree

NO_LEFT_CHILD:
NO_RIGHT_CHILD:
    MOV [DI], AX         ; Update root with final value
    POP DX               ; Restore DX
    POP CX               ; Restore CX
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

    PUSH CX               ; Save current heap size
    MOV BX, 0             ; Start heapify from the root
    CALL HEAPIFY          ; Restore heap property
    POP CX                ; Restore heap size

    ; Debug: Print list after each iteration
    CALL PRINT_LIST

    CMP CX, 1             ; Check if heap size is greater than 1
    JG HEAP_SORT_LOOP     ; Repeat until heap size is 1
    RET
HEAP_SORT ENDP

CODE ENDS
END START