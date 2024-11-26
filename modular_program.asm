section .bss
    result resq 1          ; Reserve 8 bytes for factorial result (since 64-bit)

section .text
    global _start

_start:
    mov rdi, 5             ; Input number for factorial (e.g., 5)
    call factorial         ; Call factorial subroutine
    ; Result is in rax

    ; Exit the program
    mov rax, 60            ; syscall: exit
    xor rdi, rdi           ; status 0
    syscall

factorial:
    push rbp               ; Save base pointer
    mov rbp, rsp           ; New stack frame

    mov rax, 1             ; Initialize result to 1
    cmp rdi, 1             ; Compare input number with 1
    jle end_factorial      ; If rdi <= 1, return 1

factorial_loop:
    imul rax, rdi          ; Multiply result (rax) by current number (rdi)
    dec rdi                ; Decrement the input number
    cmp rdi, 1             ; Check if rdi == 1
    jg factorial_loop      ; Continue loop if rdi > 1

end_factorial:
    pop rbp                ; Restore previous stack frame
    ret                    ; Return to main program
