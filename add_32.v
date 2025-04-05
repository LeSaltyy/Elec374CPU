// ADD Module for Mini SRC
// ELEC374 - Digital Systems Engineering
`timescale 1ns/10ps

module add_32(
    input wire [31:0] A,      // First operand
    input wire [31:0] B,      // Second operand
    input wire Cin,           // Carry input
    output wire [31:0] result, // Result of A + B + Cin
    output wire Cout          // Carry output
);
    // Wire for the carry chain
    wire [32:0] carry;
    
    // Set the initial carry input
    assign carry[0] = Cin;
    
    // Generate the full adder for each bit
    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1) begin : full_adder_loop
            // Sum bit calculation
            assign result[i] = A[i] ^ B[i] ^ carry[i];
            // Carry out calculation
            assign carry[i+1] = (A[i] & B[i]) | (A[i] & carry[i]) | (B[i] & carry[i]);
        end
    endgenerate
    
    // Final carry output
    assign Cout = carry[32];

endmodule