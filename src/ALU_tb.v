`timescale 1ns / 1ps

module ALU_tb();

    reg [2:0] S;
    reg [3:0] A, B;
    wire [3:0] F;
    wire Z, C;

    task alu;
        input [2:0] op;
        input [3:0] a, b;
        input [32*8:1] string;
        begin
            S = op; A = a; B = b; #10;
            $display("\nOpcode : %b (%0s)\n", op, string);
            $display("  A = %4b : B = %4b : F_bin = %4b : F = %0d : C = %b : Z = %b \n", a, b, F, F, C, Z);
        end
    endtask

    initial begin
        $dumpfile("ALU_wave.vcd");  // Output file for waveform
        $dumpvars(0, ALU_tb);       // Dumps all signals in this testbench

        // Clear
        alu(3'b000, 4'b0000, 4'b0000, "Clear");

        // Addition
        alu(3'b001, 4'b1001, 4'b0111, "Addition_1 (9 + 7)");  // Addition test with carry bit
        alu(3'b001, 4'b0011, 4'b0101, "Addition_2 (3 + 5)");  // Normal addition within 4-bit
        alu(3'b001, 4'b0000, 4'b0000, "Addition_3 (0 + 0)");  // 0 + 0 = 0 ; zero flag

        // Subtraction
        alu(3'b010, 4'b1010, 4'b0101, "Subtraction_1 (10 - 5)"); // Normal Addition within 4-bit
        alu(3'b010, 4'b0111, 4'b0111, "Subtraction_2 (7 - 7)");  // 7 - 7 = 0 ; zero flag 
        alu(3'b010, 4'b0000, 4'b0001, "Subtraction_3 (0 - 1)");  // Tests borrow Flag and negative result handling
        alu(3'b010, 4'b0010, 4'b0100, "Subtraction_4 (2 - 4)");  // Tests borrow flag and negative result handling

        // OR 
        alu(3'b011, 4'b1010, 4'b0101, "OR (1010 | 0101)");

        // AND
        alu(3'b100, 4'b1010, 4'b1100, "AND (1010 & 1100)");

        // XOR
        alu(3'b101, 4'b1111, 4'b1010, "XOR (1111 ^ 1010)");

        // Left Shift
        alu(3'b110, 4'b0000, 4'b0000, "Left Shift_1 (0000 << 1)");  // Left shift all zero
        alu(3'b110, 4'b1111, 4'b0000, "Left Shift_2 (1111 << 1)");  // Left shift all one
        alu(3'b110, 4'b1000, 4'b0000, "Left Shift_3 (1000 << 1)");  // Left shift MSB bit

        // Right Shift
        alu(3'b111, 4'b0000, 4'b0000, "Right Shift_1 (0000 >> 1)");  // Right shift all zero
        alu(3'b111, 4'b1111, 4'b0000, "Right Shift_2 (1111 >> 1)");  // Right shift all one
        alu(3'b111, 4'b0001, 4'b0000, "Right Shift_3 (0001 >> 1)");  // Right shift LSB bit

        #10
        $finish;
    end


    // Instances
    ALU ALU_ins (
        .S(S),
        .A(A),
        .B(B),
        .F(F),
        .Z(Z),
        .C(C)
    );

endmodule
