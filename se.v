`timescale 1ns/10ps
module se(
    input wire Gra, GRAout, Grb, Grc, Rin, Rout, BAout,
    input wire [31:0] IRwire,
	 output reg [31:0] CEwire,
    output reg [15:0] RoutwireA, RoutwireB, RinwireC
);

	wire [15:0] RA,RB,RC;
	
	encode4 RAencode(IRwire[26:23],RA);
	encode4 RBencode(IRwire[22:19],RB);
	encode4 RCencode(IRwire[18:15],RC);

	always @(*) begin
		 CEwire = {{13{IRwire[18]}},IRwire[18:0]};
		 
		 RoutwireA = 16'b0;
		 RoutwireB = 16'b0;
		 RinwireC = 16'b0;
		 
		 if (Rout | BAout)
			  if(Grb)
					RoutwireA = RB;
			  if(Grc)
					RoutwireB = RC;
		 if (Rin)
			  RinwireC = RA;	
		 else if (GRAout) begin
			  RoutwireA = RA;
			  if (Grb)
				   RoutwireB = RB;
		 end
	end
endmodule