`timescale 1ns/10ps

module r0 (
    input wire [31:0] D,
    input wire clk,
    input wire clr,
    input wire enable,
    input wire BAout,
    output wire [31:0] Q
);

    wire [31:0] qTemp;
    
    register zero_instance (
        .d(D),
        .clk(clk),
        .clr(clr),
        .enable(enable),
        .q(qTemp)
    );
		
assign Q = {32{!BAout}} & qTemp;

endmodule
