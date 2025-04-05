module MiniBus(
	 input wire [31:0] BusMuxIn_Zhigh,
    input wire [31:0] BusMuxIn_Zlow,
    input wire [31:0] BusMuxIn_A,
    input wire [31:0] BusMuxIn_B,
	 
	 input wire Zhighout, Zlowout, Aout, Bout,
	 
	 output reg [31:0] BusMuxOut
);

reg[3:0] select;

always @* begin
	 select = {Zhighout, Zlowout, Aout, Bout};
    case (select)
        4'b1000: BusMuxOut = BusMuxIn_Zhigh;
        4'b0100: BusMuxOut = BusMuxIn_Zlow;
        4'b0010: BusMuxOut = BusMuxIn_A;
        4'b0001: BusMuxOut = BusMuxIn_B;
        default: BusMuxOut = BusMuxIn_Zlow;
    endcase
end

endmodule