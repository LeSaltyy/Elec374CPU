module pcreg #(parameter INIT = 32'h0)(
    input wire [31:0] D,
    input wire clk,
    input    wire clr,
    input wire increment,
    input wire enable,
    output wire [31:0] Q
    );

    reg [31:0] qTemp;
	 
	 initial begin 
	 qTemp = 32'd0;
	 end
	 
    always @ (clk) 
        begin
				if (enable) begin
					 qTemp <= D;
				end
        end
    assign Q = qTemp;
endmodule