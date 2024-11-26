section .data
    sensorValue db 3         ; Simulated sensor value
    motorStatus db 0         ; Motor status (0 = off, 1 = on)
    alarmStatus db 0         ; Alarm status (0 = off, 1 = on)

section .text
    global _start

_start:
    mov al, [sensorValue]    ; Load sensor value

    cmp al, 5
    jg high_level            ; If sensorValue > 5, go to high level

    cmp al, 3
    jge moderate_level       ; If sensorValue >= 3, moderate level

low_level:
    ; Turn on motor, no alarm
    mov byte [motorStatus], 1
    mov byte [alarmStatus], 0
    jmp done

moderate_level:
    ; Turn off motor, no alarm
    mov byte [motorStatus], 0
    mov byte [alarmStatus], 0
    jmp done

high_level:
    ; Turn on alarm
    mov byte [motorStatus], 0
    mov byte [alarmStatus], 1

done:
    ; Exit or continue program
    mov eax, 1               ; sys_exit
    xor ebx, ebx
    int 0x80
