section .bss
    result resq 1          ; Reserve 8 bytes for factorial result
    output resb 20         ; Buffer for the output string (large enough for numbers)

section .text
    global _start

_start:
    mov rdi, 5             ; Input number for factorial (example: 5)
    call factorial         ; Call the factorial subroutine
    
    ; Convert result in rax to string
    mov rdi, rax           ; Move the result into rdi for conversion
    lea rsi, [output + 19] ; Point to the end of the output buffer
    mov byte [rsi], 0xA    ; Append newline at the end of the string
    dec rsi

convert_to_string:
    mov rdx, 0
    mov rcx, 10            ; Base 10
    div rcx                ; rax / 10, remainder in rdx
    add dl, '0'            ; Convert digit to ASCII
    mov [rsi], dl          ; Store ASCII digit in buffer
    dec rsi
    test rax, rax          ; Check if quotient is 0
    jnz convert_to_string  ; Continue if not zero
    
    inc rsi                ; Adjust pointer to the start of the string

    ; Print the result
    mov rax, 1             ; syscall: write
    mov rdi, 1             ; file descriptor: stdout
    mov rdx, output + 20   ; Length of the string to print
    sub rdx, rsi
    syscall

    ; Exit the program
    mov rax, 60            ; syscall: exit
    xor rdi, rdi           ; status 0
    syscall

factorial:
    push rbp               ; Save base pointer
    mov rbp, rsp           ; New stack frame
    push rbx               ; Save rbx (used in loop)

    mov rax, 1             ; Initialize result to 1
    cmp rdi, 1             ; Compare input number with 1
    jle end_factorial      ; If rdi <= 1, return 1

factorial_loop:
    imul rax, rdi          ; Multiply result (rax) by current number (rdi)
    dec rdi                ; Decrement the input number
    cmp rdi, 1             ; Check if rdi == 1
    jg factorial_loop      ; Continue loop if rdi > 1

end_factorial:
    pop rbx                ; Restore rbx
    pop rbp                ; Restore previous stack frame
    ret                    ; Return to main program
