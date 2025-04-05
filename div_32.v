module div_32(
	input wire [31:0] A, M,
	output reg [63:0] Q
);
	reg [31:0] temp;
	integer count;
	always @ (A or M) begin
		Q = {32'b0, A};
		for (count = 0; count < 32; count = count + 1) begin
			Q = Q << 1;
			temp = Q[63:32];
			Q[63:32] = Q[63:32] - M;	
			if (Q[63] == 1) begin
				Q[0] = 0;
				Q[63:32] = temp;
			end else begin
				Q[0] = 1;
			end
		end
end
endmodule