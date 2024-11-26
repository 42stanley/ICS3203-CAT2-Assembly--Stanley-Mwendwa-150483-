section .data
    inputMsg db "Enter a number: ", 0
    positiveMsg db "The number is POSITIVE", 10, 0
    negativeMsg db "The number is NEGATIVE", 10, 0
    zeroMsg db "The number is ZERO", 10, 0
    format db "%d", 0       ; Define the format specifier for scanf

section .bss
    num resd 1              ; Reserve 4 bytes (1 integer) for user input

section .text
    global main
    extern printf, scanf, exit

main:
    ; Print input message
    push inputMsg
    call printf
    add esp, 4

    ; Read input number
    push num                ; Address of the variable to store the input
    push format             ; Format specifier ("%d")
    call scanf
    add esp, 8

    ; Load the input number into EAX for comparison
    mov eax, [num]          ; Move the integer value into EAX

    ; Compare value
    cmp eax, 0
    je is_zero              ; Jump if the number is zero
    jl is_negative          ; Jump if the number is less than zero

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
