# **4-Bit ALU with 3-Bit Opcode**

> This project implements a 4-bit Arithmetic Logic Unit (ALU) with a 3-bit opcode, performing multiple operations:
```
- Clear
- Addition
- Subtraction
- OR
- AND
- XOR
- Left Shift
- Right Shift
- Default (set all bits to 1)
```
---

### **This project also includes:**
```
- Verilog source and testbench
- Makefile for simulation (Icarus Verilog + GTKWave)
- Yosys synthesis script and netlist
- Waveform and RTL schematic images
```
---

### **Simulation Output:**
```
Opcode : 000 (Clear)

  A = 0000 : B = 0000 : F_bin = 0000 : F = 0 : C = 0 : Z = 1

Opcode : 001 (Addition_1 (9 + 7))

  A = 1001 : B = 0111 : F_bin = 0000 : F = 0 : C = 1 : Z = 1

Opcode : 001 (Addition_2 (3 + 5))

  A = 0011 : B = 0101 : F_bin = 1000 : F = 8 : C = 0 : Z = 0

Opcode : 001 (Addition_3 (0 + 0))

  A = 0000 : B = 0000 : F_bin = 0000 : F = 0 : C = 0 : Z = 1

Opcode : 010 (Subtraction_1 (10 - 5))

  A = 1010 : B = 0101 : F_bin = 0101 : F = 5 : C = 1 : Z = 0

Opcode : 010 (Subtraction_2 (7 - 7))

  A = 0111 : B = 0111 : F_bin = 0000 : F = 0 : C = 1 : Z = 1

Opcode : 010 (Subtraction_3 (0 - 1))

  A = 0000 : B = 0001 : F_bin = 1111 : F = 15 : C = 0 : Z = 0

Opcode : 010 (Subtraction_4 (2 - 4))

  A = 0010 : B = 0100 : F_bin = 1110 : F = 14 : C = 0 : Z = 0

Opcode : 011 (OR (1010 | 0101))

  A = 1010 : B = 0101 : F_bin = 1111 : F = 15 : C = 0 : Z = 0

Opcode : 100 (AND (1010 & 1100))

  A = 1010 : B = 1100 : F_bin = 1000 : F = 8 : C = 0 : Z = 0

Opcode : 101 (XOR (1111 ^ 1010))

  A = 1111 : B = 1010 : F_bin = 0101 : F = 5 : C = 0 : Z = 0

Opcode : 110 (Left Shift_1 (0000 << 1))

  A = 0000 : B = 0000 : F_bin = 0000 : F = 0 : C = 0 : Z = 1

Opcode : 110 (Left Shift_2 (1111 << 1))

  A = 1111 : B = 0000 : F_bin = 1110 : F = 14 : C = 1 : Z = 0

Opcode : 110 (Left Shift_3 (1000 << 1))

  A = 1000 : B = 0000 : F_bin = 0000 : F = 0 : C = 1 : Z = 1

Opcode : 111 (Right Shift_1 (0000 >> 1))

  A = 0000 : B = 0000 : F_bin = 0000 : F = 0 : C = 0 : Z = 1

Opcode : 111 (Right Shift_2 (1111 >> 1))

  A = 1111 : B = 0000 : F_bin = 0111 : F = 7 : C = 1 : Z = 0

Opcode : 111 (Right Shift_3 (0001 >> 1))

  A = 0001 : B = 0000 : F_bin = 0000 : F = 0 : C = 1 : Z = 1
```
---

#### This ALU supports 8 operations based on a 3-bit opcode. For each operation, the outputs are:

* F: 4-bit binary result / decimal equivalent
* C (Carry Flag):
  * For addition: indicates carry-out
  * For subtraction: logic-inverted borrow (1 = no borrow, 0 = borrow)
  * For shifts: holds the bit shifted out
* Z (Zero Flag): 1 if result is zero, else 0
```
1. Opcode 000 — Clear

- Sets output F to 0 regardless of A or B
- Carry is 0 (no operation)
- Zero flag Z is always 1

2. Opcode 001 — Addition

- Computes F = A + B
- Result is 4-bit; carry-out goes to C
- Z = 1 if result is 0

Test Cases:

- 9 + 7 = 16 → F = 0000, C = 1, Z = 1
- 3 + 5 = 8 → F = 1000, C = 0, Z = 0
- 0 + 0 = 0 → F = 0000, C = 0, Z = 1

3. Opcode 010 — Subtraction

- Computes F = A - B using 2’s complement logic
- C = 1 (no borrow)
- C = 0 (borrow occurred)
- Z = 1 if result is 0

Test Cases:

- 10 - 5 = 5 → F = 0101, C = 1, Z = 0
- 7 - 7 = 0 → F = 0000, C = 1, Z = 1
- 0 - 1 = -1 → F = 1111, C = 0, Z = 0
- 2 - 4 = -2 → F = 1110, C = 0, Z = 0

4. Opcode 011 — OR

- Performs bitwise OR: F = A | B
- Carry C = 0
- Z = 1 if result is 0

Test Case:

- 1010 | 0101 = 1111 → F = 15, C = 0, Z = 0

5. Opcode 100 — AND

- Performs bitwise AND: F = A & B
- Carry C = 0
- Z = 1 if result is 0

Test Case:

- 1010 & 1100 = 1000 → F = 8, C = 0, Z = 0

6. Opcode 101 — XOR

- Performs bitwise XOR: F = A ^ B
- C = 0
- Z = 1 if result is 0

Test Case:

- 1111 ^ 1010 = 0101 → F = 5, C = 0, Z = 0

7. Opcode 110 — Left Shift

- Computes F = A << 1
- Carry C = MSB of A
- Z = 1 if result is 0

Test Cases:

- 0000 << 1 = 0000 → F = 0, C = 0, Z = 1
- 1111 << 1 = 1110 → F = 14, C = 1, Z = 0
- 1000 << 1 = 0000 → F = 0, C = 1, Z = 1

8. Opcode 111 — Right Shift

- Computes F = A >> 1
- Carry C = LSB of A
- Z = 1 if result is 0

Test Cases:

- 0000 >> 1 = 0000 → F = 0, C = 0, Z = 1
- 1111 >> 1 = 0111 → F = 7, C = 1, Z = 0
- 0001 >> 1 = 0000 → F = 0, C = 1, Z = 1
```
---

### Images:
1. Image of waveform:
   
   <img width="1619" height="280" alt="ALU_wave" src="https://github.com/user-attachments/assets/d8315b20-1fc4-4aef-b214-6738a313b182" />
   
2. Image of synthesis:
   
   <img width="4908" height="3562" alt="ALU_synth" src="https://github.com/user-attachments/assets/c1a08256-fc0a-4a99-b645-c8e99bca8b4e" />

---

### Requirements:
```
- WSL (Windows Subsystem for Linux) — recommended on windows
- Icarus Verilog (iverilog) — for compiling and simulating Verilog files
- GTKWave — for waveform visualization (.vcd files)
- Yosys — for Verilog synthesis and netlist generation
- Git (optional, for version control)
```
---

### **File Descriptions:**
```
- src/ALU.v — ALU Verilog source code
- src/ALU_tb.v — Testbench for ALU simulation
- sim/ALU_sim — Compiled simulation executable
- sim/ALU_wave.vcd — Waveform output file
- yosys/synth.ys — Yosys synthesis script
- yosys/ALU_netlist.v — Synthesized netlist output
- img/ALU_synth.png — RTL schematic from Yosys synthesis
- img/ALU_wave.png — Sample waveform screenshot
```

### **Instructions:**
* Using WSL
- Open the WSL terminal and navigate to the project directory inside the Linux filesystem or a mounted Windows drive (e.g., /mnt/f/ALU).

_**Run simulation and waveform viewing:**_
```
make
```
- GTKWave will launch automatically and show the waveform output.

_**To clean simulation files:**_
```
make clean
```

_**Synthesis with Yosys**_
- Inside WSL, go to the synthesis folder:
```
cd yosys
```

_**Run the synthesis script:**_
```
yosys synth.ys
```
- The netlist ALU_netlist.v will be generated in the yosys folder.
