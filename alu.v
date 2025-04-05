// ALU Module for Mini SRC
// ELEC374 - Digital Systems Engineering
// Department of Electrical and Computer Engineering
// Queen's University
`timescale 1ns/10ps

module alu(
    input wire [31:0] A,           // Input A (from Y register)
    input wire [31:0] B,           // Input B (from BusMuxOut)
    input wire ADD, SUB, MUL, DIV, // Operation control signals
    input wire AND, OR, NOT, NEG,  // Logical operation signals
    input wire SHR, SHRA, SHL, ROR, ROL, // Shift/rotate operation signals
    input wire IncPC,              // Increment PC control signal
    output reg [63:0] result       // Result output (64 bits)
);

    // Wires to connect to operation modules
    wire [31:0] and_result;        // AND operation result
    wire [31:0] or_result;         // OR operation result
    wire [31:0] not_result;        // NOT operation result
    wire [31:0] neg_result;        // NEG operation result
    
    wire add_carry;                // Addition carry flag
    wire [31:0] add_result;        // Addition result
    
    wire sub_carry;                // Subtraction borrow flag
    wire [31:0] sub_result;        // Subtraction result
    
    wire [63:0] mul_result;        // Multiplication result
    wire [63:0] div_result;        // Division result
    
    wire [31:0] shr_result;        // Shift right result
    wire [31:0] shra_result;       // Shift right arithmetic result
    wire [31:0] shl_result;        // Shift left result
    wire [31:0] ror_result;        // Rotate right result
    wire [31:0] rol_result;        // Rotate left result

    // Result selection based on active operation
    always @(*) begin
        if (IncPC) begin
            // Increment PC operation
            result[31:0] = B + 1;
            result[63:32] = 32'b0;
        end 
        else begin
            if (ADD) begin
                // Addition operation
                result[31:0] = add_result;
                result[63:32] = 32'b0;
            end
            else if (SUB) begin
                // Subtraction operation
                result[31:0] = sub_result;
                result[63:32] = 32'b0;
            end
            else if (AND) begin
                // AND operation
                result[31:0] = and_result;
                result[63:32] = 32'b0;
            end
            else if (OR) begin
                // OR operation
                result[31:0] = or_result;
                result[63:32] = 32'b0;
            end
            else if (NOT) begin
                // NOT operation
                result[31:0] = not_result;
                result[63:32] = 32'b0;
            end
            else if (NEG) begin
                // NEG operation
                result[31:0] = neg_result;
                result[63:32] = 32'b0;
            end
            else if (MUL) begin
                // Multiplication operation (64-bit result)
                result = mul_result;
            end
            else if (DIV) begin
                // Division operation (remainder in high, quotient in low)
                result = div_result;
            end
            else if (SHR) begin
                // Shift right operation
                result[31:0] = shr_result;
                result[63:32] = 32'b0;
            end
            else if (SHRA) begin
                // Shift right arithmetic operation
                result[31:0] = shra_result;
                result[63:32] = 32'b0;
            end
            else if (SHL) begin
                // Shift left operation
                result[31:0] = shl_result;
                result[63:32] = 32'b0;
            end
            else if (ROR) begin
                // Rotate right operation
                result[31:0] = ror_result;
                result[63:32] = 32'b0;
            end
            else if (ROL) begin
                // Rotate left operation
                result[31:0] = rol_result;
                result[63:32] = 32'b0;
            end
            else begin
                // Default to zero if no operation selected
                result = 64'b0;
            end
        end
    end

    // Instantiate operation modules
    and_32 and_op(A, B, and_result);
    or_32 or_op(A, B, or_result);
    not_32 not_op(A, not_result);
    neg_32 neg_op(A, neg_result);
    add_32 add_op(A, B, 1'b0, add_result, add_carry);
    sub_32 sub_op(A, B, 1'b0, sub_result, sub_carry);
    mul_32 mul_op(A, B, mul_result);
    div_32 div_op(A, B, div_result);
    shr_32 shr_op(A, B[4:0], shr_result);
    shra_32 shra_op(A, B[4:0], shra_result);
    shl_32 shl_op(A, B[4:0], shl_result);
    ror_32 ror_op(A, B[4:0], ror_result);
    rol_32 rol_op(A, B[4:0], rol_result);

endmodule