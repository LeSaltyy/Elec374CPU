// MUL Module for Mini SRC (Booth's Algorithm)
// ELEC374 - Digital Systems Engineering
`timescale 1ns/10ps

module mul_32(
    input wire [31:0] A,      // Multiplicand
    input wire [31:0] B,      // Multiplier
    output reg [63:0] result  // Product
);
    reg [64:0] partial_product;  // Includes an extra bit
    reg [31:0] multiplier;
    reg [31:0] multiplicand;
    reg [31:0] neg_multiplicand;
    integer i;

    always @(*) begin
        // Initialize values
        multiplicand = A;
        multiplier = B;
        neg_multiplicand = (~multiplicand) + 1'b1;  // 2's complement of multiplicand
        
        // Initialize partial product
        partial_product = {33'b0, multiplier, 1'b0}; // Extra 0 bit for Booth's algorithm
        
        // Booth's algorithm with bit-pair recoding
        for (i = 0; i < 32; i = i + 1) begin
            // Check bit pairs for recoding
            case(partial_product[1:0])
                2'b01: partial_product[64:33] = partial_product[64:33] + multiplicand;
                2'b10: partial_product[64:33] = partial_product[64:33] + neg_multiplicand;
                default: ; // 00 or 11 - no action needed
            endcase
            
            // Arithmetic shift right
            partial_product = {partial_product[64], partial_product[64:1]};
        end
        
        // Final result
        result = partial_product[64:1]; // Exclude the extra bit we added
    end

endmodule