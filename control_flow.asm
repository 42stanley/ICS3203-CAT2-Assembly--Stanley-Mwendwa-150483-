section .data
    inputMsg db "Enter a number: ", 0
    positiveMsg db "The number is POSITIVE", 10, 0
    negativeMsg db "The number is NEGATIVE", 10, 0
    zeroMsg db "The number is ZERO", 10, 0
    format db "%d", 0        ; Format specifier for scanf

section .bss
    num resd 1               ; Reserve 4 bytes for integer input

section .text
    global main
    extern printf, scanf, exit

main:
    ; Print input message
    lea rdi, [inputMsg]      ; Load address of inputMsg into rdi
    xor eax, eax             ; Clear eax (no floating point args)
    call printf

    ; Read input number
    lea rdi, [format]        ; Format specifier ("%d")
    lea rsi, [num]           ; Address to store the input
    xor eax, eax             ; Clear eax (no floating point args)
    call scanf

    ; Load the input number into EAX for comparison
    mov eax, [num]           ; Move the integer value into EAX

    ; Compare value
    cmp eax, 0
    je is_zero               ; Jump if the number is zero
    jl is_negative           ; Jump if the number is less than zero

is_positive:
    lea rdi, [positiveMsg]
    xor eax, eax
    call printf
    jmp end_program

is_negative:
    lea rdi, [negativeMsg]
    xor eax, eax
    call printf
    jmp end_program

is_zero:
    lea rdi, [zeroMsg]
    xor eax, eax
    call printf

end_program:
    ; Exit the program
    mov eax, 60              ; sys_exit system call number (60)
    xor edi, edi             ; Exit status 0
    syscall
