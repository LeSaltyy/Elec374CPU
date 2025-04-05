// AND Module for Mini SRC
// ELEC374 - Digital Systems Engineering
`timescale 1ns/10ps

module and_32(
    input wire [31:0] A,      // First operand
    input wire [31:0] B,      // Second operand
    output wire [31:0] result // Result of A OR B
);

    genvar i; 
    generate
        for (i = 0; i < 32; i = i + 1) 
		  begin : and_loop
            and gate(result[i], A[i], B[i]); 
        end
    endgenerate

endmodule