module register #(parameter WIDTH = 32) (
    input wire clk,           // Clock signal
    input wire clr,           // Clear/reset signal
    input wire [WIDTH-1:0] d, // Input data
    input wire enable,        // Write enable
    output reg [WIDTH-1:0] q  // Output data
);

reg [31:0] qTemp;
always @(*) begin
    if (clr)
        q <= {WIDTH{1'b0}}; // Clear register to all zeros
    else if (enable)
        qTemp <= d;             // Load data into register
		
    if (enable == 0)
		 q <= qTemp;
end

endmodule