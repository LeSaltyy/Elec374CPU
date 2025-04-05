// SHRA Module for Mini SRC (Shift Right Arithmetic)
// ELEC374 - Digital Systems Engineering
`timescale 1ns/10ps

module shra_32(
    input wire [31:0] B,      // Value to shift
    input wire [4:0] shamt,   // Shift amount (0-31)
    output reg [31:0] result  // Shifted result
);
    integer i;
    
    always @(*) begin
        // Initialize with input value
        result = B;
        
        // Perform arithmetic shift right by maintaining sign bit
        for (i = 0; i < shamt; i = i + 1) begin
            result = {result[31], result[31:1]};
        end
    end

endmodule