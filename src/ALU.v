module ALU (
    input wire [2:0] S,        // 3-bit Operation selector or Opcode
    input wire [3:0] A, B,     // 4-bit Operands A and B
    output reg [3:0] F,        // 4-bit Result Output
    output wire Z,             // Zero Flag
    output reg C               // Carry Flag
);

    reg [4:0] sum;             // 5-bit temporary result for Addition and Substraction
    assign Z = (F == 4'b0000); // Zero Flag asserted When F is zero

    always @(*) begin          
        C = 0;
        F = 4'b0;
        sum = 5'b0;

        case (S)
            3'b000: F = 4'b0000;
            3'b001: begin
                sum = A + B;      // Addition
                F = sum[3:0];     // Output Result in 4-bit
                C = sum[4];       // Carry Flag ( 1 means carry occured)
            end
            3'b010: begin
                sum = {1'b0, A} - {1'b0, B};      // Subtraction
                F = sum[3:0];                     // Output Result in 4-bit
                C = ~sum[4];                      // Carry Flag = Borrow Flag (0 menas borrow occured)
            end
            3'b011: F = A | B;                    // OR
            3'b100: F = A & B;                    // AND
            3'b101: F = A ^ B;                    // XOR
            3'b110: begin
                F = A << 1;                       // Left Shift
                C = A[3];                         // Carry Flag = the shifted out bit
            end
            3'b111: begin
                F = A >> 1;                       // Right Shift
                C = A[0];                         // Carry Flag  = the shifted out bit
            end
            default: begin 
                F = 4'b1111;
                C = 0;
            end
        endcase

    end

endmodule
