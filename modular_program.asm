section .data
    result resb 1  ; Store factorial result here

section .text
    global _start

_start:
    mov eax, 5             ; Input number for factorial (e.g., 5)
    call factorial         ; Call factorial subroutine
    ; Result is now in eax

exit:
    mov eax, 1             ; sys_exit
    xor ebx, ebx
    int 0x80

factorial:
    push ebp               ; Save base pointer
    mov ebp, esp           ; New stack frame
    push eax               ; Push number for factorial

    mov ecx, 1             ; Initialize result in ecx
factorial_loop:
    cmp eax, 1             ; Compare eax with 1
    je end_factorial       ; If eax == 1, end recursion
    mul ecx                ; Multiply result by eax
    dec eax                ; Decrement eax
    jmp factorial_loop     ; Repeat

end_factorial:
    pop eax                ; Restore eax
    mov [result], ecx      ; Move result to memory
    pop ebp                ; Restore previous stack frame
    ret                    ; Return to main program
