section .data
    array db 1, 2, 3, 4, 5    ; Define an array of 5 integers

section .text
    global _start

_start:
    ; Pointers to the start and end of the array
    mov esi, array            ; Start pointer (index 0)
    mov edi, array + 4        ; End pointer (index 4)

reverse_loop:
    cmp esi, edi              ; Compare start and end pointers
    jge end_loop              ; Exit loop if pointers have crossed

    ; Swap values between `esi` and `edi`
    mov al, [esi]             ; Load start value into `al`
    mov bl, [edi]             ; Load end value into `bl`
    mov [esi], bl             ; Write `bl` to start
    mov [edi], al             ; Write `al` to end

    ; Move pointers towards the center
    add esi, 1                ; Increment start pointer
    sub edi, 1                ; Decrement end pointer
    jmp reverse_loop          ; Repeat loop

end_loop:
    ; Continue program (e.g., print array or exit)
    ; Syscall or further code can go here
