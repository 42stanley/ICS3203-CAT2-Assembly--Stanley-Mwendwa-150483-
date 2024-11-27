section .data
    array db 1, 2, 3, 4, 5            ; Array of 5 integers
    msg db "Reversed array: ", 10      ; Message to print (newline at end)
    length equ 5                       ; Length of the array

section .text
    global _start

_start:
    ; Print message
    mov rax, 1                         ; syscall number for sys_write
    mov rdi, 1                         ; File descriptor (stdout)
    lea rsi, [msg]                     ; Address of the message
    mov rdx, 17                        ; Length of the message (including newline)
    syscall

    ; Reverse array pointers setup
    lea rsi, [array]                   ; rsi points to the start of the array
    lea rdi, [array + length - 1]      ; rdi points to the end of the array

reverse_loop:
    cmp rsi, rdi                       ; Compare start and end pointers
    jge print_array                    ; If they meet or cross, finish reversing

    ; Swap values between rsi and rdi
    mov al, [rsi]                      ; Load value at rsi into al
    mov bl, [rdi]                      ; Load value at rdi into bl
    mov [rsi], bl                      ; Store bl at rsi
    mov [rdi], al                      ; Store al at rdi

    ; Move pointers towards the center
    inc rsi                            ; Move start pointer forward
    dec rdi                            ; Move end pointer backward
    jmp reverse_loop                   ; Repeat loop

print_array:
    lea rsi, [array]                   ; Reset pointer to the start of the array
    mov rcx, length                    ; Set loop counter to array length

print_loop:
    movzx rax, byte [rsi]              ; Load current byte as unsigned integer
    add rax, '0'                       ; Convert the number to its ASCII representation

    ; Print the character
    mov rdi, 1                         ; File descriptor: stdout
    mov rsi, rsp                       ; Address to store character temporarily
    mov [rsp], al                      ; Store character in memory
    mov rdx, 1                         ; Number of bytes to write
    syscall

    ; Print a space between numbers (except the last one)
    dec rcx                            ; Decrement counter
    jz exit_program                    ; If last element, exit

    ; Print a space
    mov rax, 1                         ; sys_write
    mov rdi, 1                         ; stdout
    mov rsi, space                     ; Address of the space character
    mov rdx, 1                         ; Length: 1 byte
    syscall

    ; Move to the next array element
    inc rsi                            ; Next element
    jmp print_loop                     ; Repeat loop

exit_program:
    mov rax, 60                        ; syscall number for exit
    xor rdi, rdi                       ; exit code 0
    syscall

section .data
    space db ' '                       ; Space character for output
