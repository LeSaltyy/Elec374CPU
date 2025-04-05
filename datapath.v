// Datapath Module for Mini SRC
// ELEC374 - Digital Systems Engineering
`timescale 1ns/10ps
module datapath #(parameter WIDTH = 32) (
    input wire Clock
    );
	 
	 wire Clear,Reset,Stop,Run;
	 // Control signals for registers
    wire Gra, GRAout, Grb, Grc, BAout, Rin, Rout;
    wire HIin, LOin, PCin, IRin, Yin, Zin, MARinB,MARinC, MDRin, CONin;
    
    // Control signals for bus
    wire HIoutA, LOoutA, PCoutA, MDRoutA, Zhighout,  ZhighoutA, ZLowOutA, InPortoutA, CoutA, CON_OutA, Aout;
    wire HIoutB, LOoutB, PCoutB, MDRoutB, Zlowout, ZhighoutB, ZLowOutB, InPortoutB, CoutB, CON_OutB, Bout;

	 
    // Control signals for MDR
    wire Read, Write;
    // Control signals for ALU operations
    wire ADD, SUB, MUL, DIV, AND, OR, NOT, NEG;
    wire SHR, SHRA, SHL, ROR, ROL, IncPC;
	 
	 wire [15:0] RoutwireA, RoutwireB, RinwireC;
	 
	 reg [31:0] input_port_data;
	 	 
    // Internal wires
	 wire [WIDTH-1:0] HI, LO, PC, IR, Y, MAR, MDRout_wire;
    wire [WIDTH-1:0] BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3;
    wire [WIDTH-1:0] BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7;
    wire [WIDTH-1:0] BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11;
    wire [WIDTH-1:0] BusMuxIn_R12, BusMuxIn_R13, BusMuxIn_R14, BusMuxIn_R15;
    wire [WIDTH-1:0] BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_PC;
    wire [WIDTH-1:0] BusMuxIn_MDR, BusMuxIn_InPort, C_sign_extended;
    wire [WIDTH-1:0] BusMuxIn_Zhigh, BusMuxIn_Zlow,Mdatain, BusMuxOutA, BusMuxOutB, BusMuxOutC;
    wire [2*WIDTH-1:0] ALU_result; // Output from ALU
	 
	 control_unit control(
			IR,Clock,Reset,Stop,CON_out,Run,Clear,Read,
			Write,IncPC,Gra,GRAout, Grb,Grc,Rin,Rout,HIin,LOin,
			CONin, PCin, IRin, Yin, Zin, MARinB,MARinC, MDRin,Out_Portin,HIoutA, 
			LOoutA, Zhighout, Zlowout, Aout, Bout, MDRoutB, PCoutB, CoutA, CoutB, BAout, InPortout,
			ADD, SUB, AND, OR, ROR, ROL, SHR, SHRA, SHL, DIV,
			MUL, NEG, NOT
	 );
    
    // Instantiate all registers
    // General purpose registers R0-R15
    register r1(Clock, Clear, BusMuxOutC, RinwireC[1], BusMuxIn_R1);
    register r2(Clock, Clear, BusMuxOutC, RinwireC[2], BusMuxIn_R2);
    register r3(Clock, Clear, BusMuxOutC, RinwireC[3], BusMuxIn_R3);
    register r4(Clock, Clear, BusMuxOutC, RinwireC[4], BusMuxIn_R4);
    register r5(Clock, Clear, BusMuxOutC, RinwireC[5], BusMuxIn_R5);
    register r6(Clock, Clear, BusMuxOutC, RinwireC[6], BusMuxIn_R6);
    register r7(Clock, Clear, BusMuxOutC, RinwireC[7], BusMuxIn_R7);
    register r8(Clock, Clear, BusMuxOutC, RinwireC[8], BusMuxIn_R8);
    register r9(Clock, Clear, BusMuxOutC, RinwireC[9], BusMuxIn_R9);
    register r10(Clock, Clear, BusMuxOutC, RinwireC[10], BusMuxIn_R10);
    register r11(Clock, Clear, BusMuxOutC, RinwireC[11], BusMuxIn_R11);
    register r12(Clock, Clear, BusMuxOutC, RinwireC[12], BusMuxIn_R12);
    register r13(Clock, Clear, BusMuxOutC, RinwireC[13], BusMuxIn_R13);
    register r14(Clock, Clear, BusMuxOutC, RinwireC[14], BusMuxIn_R14);
    register r15(Clock, Clear, BusMuxOutC, RinwireC[15], BusMuxIn_R15);
    
    // Special purpose registers

    r0 r0(BusMuxOutC,Clock,Clear ,RinwireC[0],BAout, BusMuxIn_R0);
    pcreg pc_reg(BusMuxOutC,Clock, Clear, IncPC, PCin, BusMuxIn_PC);
	 
	 
    register ir_reg(Clock, Clear, BusMuxOutC, IRin, IR);
    register y_reg(Clock, Clear, BusMuxOutC, Yin, Y);
    mreg mar_reg(Clock, Clear, BusMuxOutB, BusMuxOutC, MARinB, MARinC, MAR);
    register hi_reg(Clock, Clear, BusMuxOutC, HIin, BusMuxIn_HI);
    register lo_reg(Clock, Clear, BusMuxOutC, LOin, BusMuxIn_LO);
	     
    // MDR with multiplexer
    mdr mdr_unit(Clock, Clear, BusMuxOutC, Mdatain, Read, MDRin, BusMuxIn_MDR);
    assign BusMuxIn_InPort = {WIDTH{1'b0}};
    
	 se se(
	     .Gra(Gra), .GRAout(GRAout), .Grb(Grb), .Grc(Grc), .Rin(Rin),.Rout(Rout), .BAout(BAout),
	     .IRwire(IR), .CEwire(C_sign_extended),
        .RoutwireA(RoutwireA), .RoutwireB(RoutwireB), .RinwireC(RinwireC)
	 );
	 
	 RAM rammus(.BusMuxOutC(BusMuxOutC),.Address(MAR[8:0]), .Clock(Clock),
	 .Read(Read), .Write(Write), .Mdatain(Mdatain));

    // Output A bus multiplexer 
    busmux busA(
        .BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1),
        .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3),
        .BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5),
        .BusMuxIn_R6(BusMuxIn_R6), .BusMuxIn_R7(BusMuxIn_R7),
        .BusMuxIn_R8(BusMuxIn_R8), .BusMuxIn_R9(BusMuxIn_R9),
        .BusMuxIn_R10(BusMuxIn_R10), .BusMuxIn_R11(BusMuxIn_R11),
        .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13),
        .BusMuxIn_R14(BusMuxIn_R14), .BusMuxIn_R15(BusMuxIn_R15),
        .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO),
        .BusMuxIn_Zhigh(BusMuxIn_Zhigh), .BusMuxIn_Zlow(BusMuxIn_Zlow),
        .BusMuxIn_PC(32'b1), .BusMuxIn_MDR(BusMuxIn_MDR),
        .BusMuxIn_InPort(BusMuxIn_InPort), .C_sign_extended(C_sign_extended),
        
        // Control signals
        .Routwire(RoutwireA),
        .HIout(HIoutA), .LOout(LOoutA), .Zhighout(ZhighoutA), .Zlowout(ZLowOutA),
        .PCout(IncPC), .MDRout(MDRoutA), .InPortout(InPortoutA), .Cout(CoutA),
        
        // Output
        .BusMuxOut(BusMuxOutA)
    );
	 
	 // Output B bus multiplexer 
	 busmux busB(
        // Register inputs
        .BusMuxIn_R0(BusMuxIn_R0), .BusMuxIn_R1(BusMuxIn_R1),
        .BusMuxIn_R2(BusMuxIn_R2), .BusMuxIn_R3(BusMuxIn_R3),
        .BusMuxIn_R4(BusMuxIn_R4), .BusMuxIn_R5(BusMuxIn_R5),
        .BusMuxIn_R6(BusMuxIn_R6), .BusMuxIn_R7(BusMuxIn_R7),
        .BusMuxIn_R8(BusMuxIn_R8), .BusMuxIn_R9(BusMuxIn_R9),
        .BusMuxIn_R10(BusMuxIn_R10), .BusMuxIn_R11(BusMuxIn_R11),
        .BusMuxIn_R12(BusMuxIn_R12), .BusMuxIn_R13(BusMuxIn_R13),
        .BusMuxIn_R14(BusMuxIn_R14), .BusMuxIn_R15(BusMuxIn_R15),
        .BusMuxIn_HI(BusMuxIn_HI), .BusMuxIn_LO(BusMuxIn_LO),
        .BusMuxIn_Zhigh(BusMuxIn_Zhigh), .BusMuxIn_Zlow(BusMuxIn_Zlow),
        .BusMuxIn_PC(BusMuxIn_PC), .BusMuxIn_MDR(BusMuxIn_MDR),
        .BusMuxIn_InPort(BusMuxIn_InPort), .C_sign_extended(C_sign_extended),
        
        // Control signals
        .Routwire(RoutwireB),
        .HIout(HIoutB), .LOout(LOoutB), .Zhighout(ZhighoutB), .Zlowout(ZLowOutB),
        .PCout(PCoutB), .MDRout(MDRoutB), .InPortout(InPortoutB), .Cout(CoutB),
        
        // Output
        .BusMuxOut(BusMuxOutB)
    );
	 
	 // input C mini multiplexer 
	 MiniBus BusC(
		ALU_result[63:32], ALU_result[31:0], BusMuxOutA, BusMuxOutB,
		Zhighout, Zlowout, Aout, Bout,
		BusMuxOutC
	 );

	
    
    // ALU with separate operation modules
    alu alu_unit(
        .A(BusMuxOutA),                  
        .B(BusMuxOutB),          
        .ADD(ADD), .SUB(SUB), .MUL(MUL), .DIV(DIV),
        .AND(AND), .OR(OR), .NOT(NOT), .NEG(NEG),
        .SHR(SHR), .SHRA(SHRA), .SHL(SHL), .ROR(ROR), .ROL(ROL),
        .IncPC(IncPC),          
        .result(ALU_result)     
    );
    
   
    conff con_ff_instance (
        .condition_bits(IR[20:19]), 
        .Bus_Data(BusMuxOutB),       
        .CONin(CONin),            
        .CON_Out(CON_Out)           
    );

endmodule