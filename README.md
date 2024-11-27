# ICS3203-CAT2-Assembly--Stanley-Mwendwa-150483-
This is a repository that contains CAT2 for Assembly Language Programming

# **README.md**

## **1. Purpose of the Program**

### **Control Flow and Conditional Logic**

The **Control Flow** program accepts an integer input from the user and performs a simple control flow operation to determine whether the input number is positive, negative, or zero. It uses the `printf` and `scanf` functions to interact with the user and handle input/output.

The program includes:
- Prompting the user for input.
- Checking the input using conditional statements (`if` and `else`).
- Printing messages based on whether the number is positive, negative, or zero.
- Exiting the program once the message is printed.

### **Modular Program for Factorial Calculation**

The purpose of the `modular_program.asm` is to compute the factorial of a given number. The program is designed with modularity in mind, where the factorial calculation is separated into its own subroutine. This ensures better readability and code reuse. The subroutine demonstrates the usage of the stack to preserve registers and modular programming concepts. The final result of the factorial calculation is stored in the `rax` register.

### **Data Monitoring and Control Program**

The `data_monitoring.asm` simulates a control program that reads a sensor value, performs conditional actions based on the sensor's reading, and manipulates system states like a motor and alarm. This program is a basic simulation for monitoring a water level sensor and performing corresponding actions:
1. **Motor control**: Turns the motor on or off based on the water level.
2. **Alarm triggering**: Activates an alarm when the water level exceeds a predefined threshold.
   
The program manipulates memory locations (simulated ports) to reflect the status of the motor and alarm.

---

## **2. Instructions for Running and Compiling the Code**

### **Control Flow and Conditional Logic**

**Steps to Compile and Run:**
1. **Assemble the program**: Use the NASM assembler to convert the `.asm` file into an object file.
   ```bash
   nasm -f elf64 control_flow.asm -o control_flow.o
    ```

2. **Link the Object File**: Use the linker to create an executable.
    ```bash
    gcc -m64 -no-pie control_flow.o -o control_flow -lc -dynamic-linker /lib64/ld-linux-x86-64.so.2
    ```

3. **Run the Program**:
    ```bash
    ./control_flow
    ```
**Expected Outcome**: The Control Flow program interacts with the user, prompting them to input a number. Based on the user's input, the program should output if a number is positive, negative or zero.

---

### **Modular Program for Factorial Calculation**

**Steps to Compile and Run:**
1. **Assemble the Program**: Use the NASM assembler to convert the `.asm` file into an object file.
    ```bash
    nasm -f elf64 -g modular_program.asm -o modular_program.o
    ```

2. **Link the Object File**: Use the linker to create an executable.
    ```bash
    ld -o modular_program modular_program.o
    ```

3. **Run the Program**:
    ```bash
    ./modular_program
    ```

**Expected Outcome**: The program computes the factorial of a given input number (e.g., `5`), and the result is stored in the `rax` register.

---

### **Data Monitoring and Control Program**

**Steps to Compile and Run:**
1. **Assemble the Program**: Convert the `.asm` file to an object file using NASM.
    ```bash
    nasm -f elf64 -g data_monitoring.asm -o data_monitoring.o
    ```

2. **Link the Object File**: Link the object file to create an executable.
    ```bash
    ld -o data_monitoring data_monitoring.o
    ```

3. **Run the Program**:
    ```bash
    ./data_monitoring
    ```

**Expected Outcome**: The program simulates a control system that reads a sensor value and modifies the motor and alarm status based on predefined thresholds for water levels.

---

## **3. Insights and Challenges Encountered**

### **Control Flow and Conditional Logic**
**Insights:**
- The program demonstrates basic control flow mechanisms like cmp and conditional jumps (je, jl).
- It utilizes system calls for basic I/O operations (using printf and scanf).

**Challenges:**
- Linking issues with external libraries such as printf and scanf required proper setup of the linker and dynamic linking.
- Ensuring the correct memory handling and proper calls to external functions (printf and scanf) was challenging, especially with handling exit operations.

---

### **Modular Program for Factorial Calculation**

**Insights:**
- The use of modular programming with subroutines is effective in isolating the factorial calculation logic from the main program.
- The stack is utilized to preserve registers and manage function calls, which is a fundamental concept in low-level assembly programming.
  
**Challenges:**
- **Register Preservation**: Ensuring that the registers used in the factorial subroutine are preserved across function calls was an important aspect of the task. This required pushing and popping the registers using the stack.
- **Correct Exit Handling**: Ensuring the program exits properly without leaving residual values in registers was essential to avoid unexpected behavior.
  
---

### **Data Monitoring and Control Program**

**Insights:**
- The program simulates a control system by reading a sensor value and taking actions such as turning a motor on or off and triggering an alarm based on certain thresholds.
- The use of memory locations (simulated ports) allows for easy simulation of hardware control actions in assembly language.

**Challenges:**
- **Conditional Logic**: Implementing conditional checks based on the sensor's reading required careful handling of the program flow (using `cmp` and `jle`, `jg`, etc.).
- **Simulating Hardware Control**: While the motor and alarm are simulated using memory locations, the challenge was representing the hardware state changes (motor and alarm control) through the manipulation of memory values.
- **Program Termination**: Ensuring the program terminates properly, especially when using system calls like `sys_exit`, was critical for clean execution.

---

## **4. Conclusion**

Both programs were designed to demonstrate core assembly language concepts:
- **Modularity**: The factorial program highlighted the use of subroutines and stack management.
- **Control Simulation**: The data monitoring program simulated sensor-based control systems, manipulating memory locations as a substitute for hardware I/O ports.

These programs provide hands-on experience with low-level programming concepts like register management, stack handling, and direct memory manipulation.
