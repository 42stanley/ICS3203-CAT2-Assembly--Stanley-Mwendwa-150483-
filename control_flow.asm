section .data
    inputMsg db "Enter a number: ", 0
    positiveMsg db "The number is POSITIVE", 10, 0
    negativeMsg db "The number is NEGATIVE", 10, 0
    zeroMsg db "The number is ZERO", 10, 0

section .bss
    num resb 5  ; Buffer for user input

section .text
    global main
    extern printf, scanf, exit

main:
    ; Print input message
    push inputMsg
    call printf
    add esp, 4

    ; Read input number
    push num
    push format
    call scanf
    add esp, 8

    ; Convert input string to number (for simplicity)
    mov eax, [num]

    ; Compare value
    cmp eax, 0
    je is_zero
    jl is_negative

is_positive:
    push positiveMsg
    call printf
    jmp end_program

is_negative:
    push negativeMsg
    call printf
    jmp end_program

is_zero:
    push zeroMsg
    call printf

end_program:
    ; Exit the program
    push 0
    call exit
