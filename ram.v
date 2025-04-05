// ELEC 374 RAM
module RAM (

	input Read, Write, Clock,
	input [8:0] Address,
	input [31:0] BusMuxOutC,
	output reg[31:0] Mdatain

);
	
	reg [31:0] memory [0:511];	
	
	initial begin
        memory[0]  = 32'h09800065;
        memory[1]  = 32'h09980003;
        memory[2]  = 32'h01000054;
        memory[3]  = 32'h09100001;
        memory[4]  = 32'h0017FFFA;
        memory[5]  = 32'h08800003;
        memory[6]  = 32'h09800057;
        memory[7]  = 32'h99980003;
        memory[8]  = 32'h09980003;
        memory[9]  = 32'h021FFFFA;
        memory[10] = 32'hD0000000;
        memory[11] = 32'h9A100002;
        memory[12] = 32'h0B180007;
        memory[13] = 32'h0AB7FFFC;
        memory[14] = 32'h19988000;
        memory[15] = 32'h62200002;
        memory[16] = 32'h8A200000;
        memory[17] = 32'h92200000;
        memory[18] = 32'h6A20000F;
        memory[19] = 32'h39008000;
        memory[20] = 32'h72100007;
        memory[21] = 32'h51208000;
        memory[22] = 32'h49988000;
        memory[23] = 32'h11800092;
        memory[24] = 32'h41808000;
        memory[25] = 32'h32880000;
        memory[26] = 32'h29180000;
        memory[27] = 32'h12900054;
        memory[28] = 32'h201A8000;
        memory[29] = 32'h59188000;
        memory[30] = 32'h0A800008;
        memory[31] = 32'h0B000017;
        memory[32] = 32'h83280000;
        memory[33] = 32'hCA000000;
        memory[34] = 32'hC3800000;
        memory[35] = 32'h7B280000;
        memory[36] = 32'h0D280001;
        memory[37] = 32'h0DB7FFFD;
        memory[38] = 32'h0E380001;
        memory[39] = 32'h0EA00004;
        memory[40] = 32'hA6000000;
        memory[41] = 32'hD8000000;
        memory[84] = 32'h00000097;       
        memory[146] = 32'h00000046;
		  memory[185] = 32'h1FD60000;
		  memory[186] = 32'h275E8000;
		  memory[187] = 32'h27FF0000;
		  memory[188] = 32'hAC000000;
		  
    end
	
	always @ (Clock) begin
	
		if (Write) begin
			memory[Address] <= BusMuxOutC;
		end
		
		else if (Read) begin
			Mdatain <= memory[Address];
		end
	end
	
endmodule