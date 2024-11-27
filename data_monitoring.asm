section .data
    sensorValue db 3         ; Simulated sensor value (e.g., water level sensor)
    motorStatus db 0         ; Motor status (0 = off, 1 = on)
    alarmStatus db 0         ; Alarm status (0 = off, 1 = on)

section .text
    global _start

_start:
    ; Read the simulated sensor value
    mov al, [sensorValue]    ; Load sensor value into al register

    ; Compare the sensor value to determine action
    cmp al, 5                ; Compare sensor value with 5
    jg high_level            ; If sensor value > 5, go to high level (high water level)

    cmp al, 3                ; Compare sensor value with 3
    jge moderate_level       ; If sensor value >= 3, go to moderate level (medium water level)

low_level:
    ; Low water level: Turn motor on, no alarm
    mov byte [motorStatus], 1    ; Set motorStatus to 1 (motor on)
    mov byte [alarmStatus], 0    ; Set alarmStatus to 0 (alarm off)
    jmp done

moderate_level:
    ; Moderate water level: Turn motor off, no alarm
    mov byte [motorStatus], 0    ; Set motorStatus to 0 (motor off)
    mov byte [alarmStatus], 0    ; Set alarmStatus to 0 (alarm off)
    jmp done

high_level:
    ; High water level: Turn motor off, trigger alarm
    mov byte [motorStatus], 0    ; Set motorStatus to 0 (motor off)
    mov byte [alarmStatus], 1    ; Set alarmStatus to 1 (alarm on)

done:
    ; Exit the program
    mov rax, 60            ; syscall: exit
    xor rdi, rdi           ; status 0
    syscall
