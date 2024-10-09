.model small
.stack 100h
.data
arr db 8, 9, 6, 5  ; Array to be sorted
n   db 4           ; Size of the array

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Build heap
    mov cl, n
    shr cl, 1                   ; Start from the first non-leaf node
    dec cl
    call heapify_all

    ; Perform heap sort
    mov cl, n
    dec cl
sort_loop:
    mov al, arr[0]              ; Swap first and last element
    mov bx, cx
    mov ah, arr[bx]
    mov arr[0], ah
    mov arr[bx], al

    push cx                     ; Save current length of the array
    mov bx, 0                   ; Start heapify from the root
    call max_heapify            ; Restore heap property
    pop cx
    loop sort_loop

    ; Program end
    mov ah, 4Ch                 ; DOS terminate
    int 21h

main endp

; Heapify all nodes
heapify_all proc
    mov bx, cl
heapify_loop:
    push cx
    call max_heapify
    pop cx
    dec bx
    jns heapify_loop
    ret
heapify_all endp

; Restore max heap property
max_heapify proc
    mov si, bx                  ; Current node index
    mov cl, n                   ; Restore size of the array (for bounds checking)
    shl si, 1                   ; Calculate left child index (2*i + 1)
    add si, 1

    cmp si, cx
    jge heapify_done            ; If left child index is out of bounds

    mov al, arr[si]             ; Load left child
    mov ah, arr[bx]             ; Load parent
    cmp ah, al
    jge check_right_child       ; If parent >= left child, no need to swap

    ; Left child is greater than parent, swap them
    mov arr[si], ah
    mov arr[bx], al
    mov bx, si                  ; Continue heapifying

    jmp max_heapify

check_right_child:
    inc si                      ; Right child index (2*i + 2)
    cmp si, cx
    jge heapify_done            ; If right child index is out of bounds

    mov al, arr[si]             ; Load right child
    mov ah, arr[bx]             ; Load parent again (it might have changed)
    cmp ah, al
    jge heapify_done            ; If parent >= right child, no need to swap

    ; Right child is greater than parent, swap them
    mov arr[si], ah
    mov arr[bx], al
    mov bx, si                  ; Continue heapifying

    jmp max_heapify

heapify_done:
    ret
max_heapify endp

end main