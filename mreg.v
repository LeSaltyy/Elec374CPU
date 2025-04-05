module mreg #(parameter WIDTH = 32) (
    input wire clk,           // Clock signal
    input wire clr,           // Clear/reset signal
    input wire [WIDTH-1:0] MuxB, MuxC,// Input data
    input wire enable1, enable2,     // Write enable
    output reg [WIDTH-1:0] q  // Output data
);

always @(*) begin
    if (clr)
        q <= {WIDTH{1'b0}}; // Clear register to all zeros
    else if (enable1)
        q <= MuxB;             // Load data into register
	 else if (enable2)
		  q <= MuxC;
end

endmodule