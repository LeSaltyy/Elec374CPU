// Control Unit

`timescale 1ns/10ps

module control_unit(
	input wire [31:0] IR,
	input wire Clock, Reset, Stop,
	input wire CONout,
	
	output reg Run, Clear, Read, Write, IncPC,
	output reg Gra, GRAout, Grb, Grc, Rin, Rout,
	output reg HIin, LOin, CONin, PCin, IRin, Yin, Zin, MARinB, MARinC, MDRin, Out_Portin , 
	output reg HIout, LOout, Zhighout, Zlowout,Aout, Bout, MDRout, PCout, CoutA, CoutB, BAout, InPort,
	
	output reg ADD, SUB, AND, OR, ROR, ROL, SHR, SHRA, SHL, DIV, MUL, NEG, NOT


);


parameter reset_state = 7'b0000000;
parameter fetch0 = 7'b0000001;
parameter fetch1 = 7'b0000010;
parameter fetch2 = 7'b0000011;
parameter ld3 = 7'b0000100;
parameter ld4 = 7'b0000101;
parameter ldi3 = 7'b0001001;
parameter st3 = 7'b0001100;
parameter st4 = 7'b0001101;
parameter add3 = 7'b0010001;
parameter sub3 = 7'b0010100;
parameter and3 = 7'b0010111;
parameter or3 = 7'b0011010;
parameter ror3 = 7'b0011101;
parameter rol3 = 7'b0100000;
parameter shr3 = 7'b0100011;
parameter shra3 = 7'b0100110;
parameter shl3 = 7'b0101001;
parameter addi3 = 7'b0101100;
parameter andi3 = 7'b0101111;
parameter ori3 = 7'b0110010;
parameter div3 = 7'b0110101;
parameter div4 = 7'b0110110;
parameter mul3 = 7'b0111001;
parameter mul4 = 7'b0111010;
parameter neg3 = 7'b0111101;
parameter neg4 = 7'b0111110;
parameter not3 = 7'b0111111;
parameter not4 = 7'b1000000;
parameter br3 = 7'b1000001;
parameter br4 = 7'b1000010;
parameter jal3 = 7'b1000101;
parameter jal4 = 7'b1000110;
parameter jr3 = 7'b1000111;
parameter in3 = 7'b1001000;
parameter out3 = 7'b1001001;
parameter mflo3 = 7'b1001010;
parameter mfhi3 = 7'b1001011;
parameter nop3 = 7'b1001100;
parameter halt3 = 7'b1000101;
reg [6:0] present_state = reset_state;
always @(posedge Clock, posedge Reset)
	begin
		if (Reset == 1'b1)present_state = reset_state;
		else case(present_state)
			reset_state:	present_state=fetch0;
			fetch0:			present_state=fetch1;
			fetch1:		   begin
									case(IR[31:27])
										5'b00000:	present_state=ld3;
										5'b00001:	present_state=ldi3;
										5'b00010:	present_state=st3;
										5'b00011:	present_state=add3;
										5'b00100:	present_state=sub3;
										5'b00101:	present_state=and3;
										5'b00110:	present_state=or3;
										5'b00111:	present_state=ror3;
										5'b01000:	present_state=rol3;
										5'b01001:	present_state=shr3;
										5'b01010:	present_state=shra3;
										5'b01011:	present_state=shl3;
										5'b01100:	present_state=addi3;
										5'b01101:	present_state=andi3;
										5'b01110:	present_state=ori3;
										5'b01111:	present_state=div3;
										5'b10000:	present_state=mul3;
										5'b10001:	present_state=neg3;
										5'b10010:	present_state=not3;
										5'b10011:	present_state=br3;
										5'b10100:	present_state=jal3;
										5'b10101:	present_state=jr3;
										5'b10110:	present_state=in3;
										5'b10111:	present_state=out3;
										5'b11000:	present_state=mflo3;
										5'b11001:	present_state=mfhi3;
										5'b11010:	present_state=nop3;
										5'b11011:	present_state=halt3;
									endcase
								end
			ld3:				present_state=ld4;
			ld4:				present_state=fetch0;
			ldi3:				present_state=fetch0;
			st3:				present_state=st4;
			st4:				present_state=fetch0;
			add3:				present_state=fetch0;
			sub3:				present_state=fetch0;			
			and3:				present_state=fetch0;
			or3:				present_state=fetch0;
			ror3:				present_state=fetch0;
			rol3:				present_state=fetch0;
			shr3:				present_state=fetch0;
			shra3:			present_state=fetch0;
			shl3:				present_state=fetch0;
			addi3:			present_state=fetch0;
			andi3:			present_state=fetch0;
			ori3:				present_state=fetch0;										
			div3:				present_state=div4;
			div4:				present_state=fetch0;
			mul3:				present_state=mul4;
			mul4:				present_state=fetch0;
			neg3:				present_state=neg4;
			neg4:				present_state=fetch0;
			not3:				present_state=fetch0;	
			br3:				present_state=br4;
			br4:				present_state=fetch0;	
			jal3:				present_state=jal4;
			jal4:				present_state=fetch0;
			jr3:				present_state=fetch0;
			in3:				present_state=fetch0;
			out3:				present_state=fetch0;
			mflo3:			present_state=fetch0;
			mfhi3:			present_state=fetch0;
			nop3:				present_state=fetch0;
			halt3:			present_state=halt3;
		endcase
	end
			
always @(present_state)
	begin
		case(present_state)
			reset_state: begin
								Run<=1;
								{Clear, Read, Write, IncPC}<=0;
								{Gra, Grb, Grc, Rin, Rout}<=0;
								{HIin, LOin, CONin, PCin, IRin,Yin, MARinB,MARinC, MDRin, Out_Portin}<=0;
								{HIout, LOout, Zhighout, Zlowout, MDRout, PCout, CoutB, Bout, Aout, BAout, InPort}<=0;
								{ADD, SUB, AND, OR, ROR, ROL, SHR, SHRA, SHL, DIV, MUL, NEG, NOT}<=0;
							 end
			fetch0: begin
								{Clear, Read, Write, IncPC}<=0;
								{Gra, Grb, Grc, Rin, Rout}<=0;
								{HIin, LOin, CONin, PCin, IRin, Yin, MARinB,MARinC, MDRin, Out_Portin }<=0;
								{HIout, LOout, Zhighout, Zlowout, MDRout, PCout, CoutB, Bout, Aout, BAout, InPort}<=0;
								{ADD, SUB, AND, OR, ROR, ROL, SHR, SHRA, SHL, DIV, MUL, NEG, NOT}<=0;
								PCout<=1; MARinB<=1; IncPC<=1; PCin<=1; ADD<= 1; Read<=1; MDRin<=1;   
								#15 PCout<=0; MARinB<=0; IncPC<=0; PCin<=0;ADD<= 0; Read<=0; MDRin<=0;
						end			
			fetch1: begin
						MDRout<=1; IRin<=1; Bout<=1;
						#15 MDRout<=0; IRin<=0; Bout<=0;
						end
			ld3:	begin
						Grb<=1; BAout<=1; CoutB<=1; ADD<=1;  Zlowout<=1; MARinC<=1; Read<=1; MDRin<=1;
						#15 Grb<=0; BAout<=0; CoutB<=0; ADD<=0;  Zlowout<=0; MARinC<=0; Read<=0; MDRin<=0;
					end
			ld4:	begin
						MDRout<=1; Gra<=1; Rin<=1; ADD<=1; Zlowout<=1;
						#15 MDRout<=0; Gra<=0; Rin<=0; ADD<=0; Zlowout<=1;
					end
			ldi3:	begin
						Grb<=1; BAout<=1; CoutB<=1; ADD<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; BAout<=0; CoutB<=0; ADD<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			st3:	begin
						Grb<=1; BAout<=1;  CoutB<=1; ADD<=1;  Zlowout<=1; MARinC<=1;
						#15 Grb<=0; BAout<=0;  CoutB<=0; ADD<=0;  Zlowout<=0; MARinC<=0;
					end
			st4:	begin
						GRAout <= 1; Write <= 1; Rout <= 1; Aout<=1;
				      #15 GRAout <= 0; Write <= 0; Rout <= 0; Aout<=0; 
					end
			add3:	begin
						Grb<=1; Rout<=1; Grc<=1; Rout<=1; ADD<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0; Grc<=0; ADD<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end			
			sub3:	begin
						Grb<=1; Rout<=1; Grc<=1; Rout<=1; SUB<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0; Grc<=0; Rout<=0; SUB<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			and3:	begin
						Grb<=1; Rout<=1;  Grc<=1; Rout<=1; AND<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Grc<=0; Rout<=0; AND<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			or3:	begin
						Grb<=1; Rout<=1;  Grc<=1; Rout<=1; OR<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Grc<=0; Rout<=0; OR<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			ror3:	begin
						Grb<=1; Rout<=1;  Grc<=1; Rout<=1; ROR<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Grc<=0; Rout<=0; ROR<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			rol3:	begin
						Grb<=1; Rout<=1;  Grc<=1; Rout<=1; ROL<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Grc<=0; Rout<=0; ROL<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			shr3:	begin
						Grb<=1; Rout<=1;  Grc<=1; Rout<=1; SHR<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Zlowout<=0; Gra<=0; Rin<=0; Grc<=0; Rout<=0; SHR<=0; 
					end
			shra3:	
			      begin
						Grb<=1; Rout<=1;  Grc<=1; Rout<=1; SHRA<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Grc<=0; Rout<=0; SHRA<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end			
			shl3:	begin
						Grb<=1; Rout<=1;  Grc<=1; Rout<=1; SHL<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Grc<=0; Rout<=0; SHL<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			addi3:	begin
						Grb<=1; Rout<=1;  CoutB<=1; ADD<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  CoutB<=0; ADD<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			andi3:	begin
						Grb<=1; Rout<=1;  CoutB<=1; AND<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  Zlowout<=0; Gra<=0; Rin<=0; CoutB<=0; AND<=0; 
					end
			ori3:	begin
						Grb<=1; Rout<=1;  CoutB<=1; OR<=1;  Zlowout<=1; Gra<=1; Rin<=1;
						#15 Grb<=0; Rout<=0;  CoutB<=0; OR<=0;  Zlowout<=0; Gra<=0; Rin<=0;
					end
			div3:	begin
						GRAout<=1; Rout<=1; Grb<=1; Rout<=1; DIV<=1; Zlowout<=1; LOin<=1;
						#15 Zlowout<=0; LOin<=0;
					end
			div4:	begin
						Zhighout<=1; HIin<=1;
						#15 GRAout<=0; Rout<=0; Grb<=0; Rout<=0; Zhighout<=0; HIin<=0; DIV<=0;
					end	
			mul3:	begin
						GRAout<=1; Rout<=1; Grb<=1; Rout<=1; MUL<=1; Zlowout<=1; LOin<=1;
						#15 Rout<=0; Zlowout<=0; LOin<=0; 
					end
			mul4:	begin
						Zhighout<=1; HIin<=1;  
						#15 GRAout<=0; Grb<=0; Rout<=0; MUL<=0; HIin<=0; Zhighout<=0;
					end
			neg3:	begin
						Grb<=1; Rout<=1; NEG<=1;  Gra<=1; Rin<=1; Zlowout<=1;
						#15 Grb<=0; Rout<=0; NEG<=0;  Gra<=0; Rin<=0; Zlowout<=0;
					end
			not3:	begin
						Grb<=1; Rout<=1; NOT<=1;  Gra<=1; Rin<=1; Zlowout<=1;
						#15 Grb<=0; Rout<=0; NEG<=0;  Gra<=0; Rin<=0; Zlowout<=0;
					end
			br3:	begin
						Gra<=1; Rout<=1; CONin<=1;
						#15 Gra<=0; Rout<=0; CONin<=0;
					end
			br4:	begin
						PCout<=1;  CoutA<=1; ADD<=1;  Zlowout<=1; PCin<=datapath.CON_Out;
						#15 PCout<=0;  CoutA<=0; ADD<=0;  Zlowout<=0; PCin<=0;
					end
			jr3:	begin
						GRAout<=1; Aout<=1; PCin<=1;
						#15 GRAout<=0; Aout<=0; PCin<=0;
					end
			
			jal3:	begin
						datapath.r8.qTemp = datapath.pc_reg.Q;
					end
			jal4:	begin
						GRAout<=1; PCin<=1; Aout<=1;
						#15 GRAout<=0; PCin<=0; Aout<=0;
					end
			
			
			in3:	begin
						Gra<=1; InPort<=1; Rin<=1;
						#15 Gra<=0; InPort<=0; Rin<=0;
					end
			out3:	begin
						GRAout<=1; Out_Portin <=1; Aout<=1;
						#15 GRAout<=0; Out_Portin <=0; Aout<=0;
					end			
			mflo3:	begin
						Gra<=1; Aout<=1; LOout<=1; Rin<=1;
						#15 Gra<=0; Aout<=0; LOout<=0; Rin<=0;
					end
			mfhi3:	begin
						Gra<=1; Aout<=1; HIout<=1; Rin<=1;
						#15 Gra<=0; Aout<=0; HIout<=0; Rin<=0;
					end
					
			nop3:	begin

					end		
			halt3:	begin
						Run<=0;
					end
		endcase
	end
endmodule		