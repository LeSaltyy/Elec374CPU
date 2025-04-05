module mdr #(parameter WIDTH = 32) (
    input wire clk,                 // Clock signal
    input wire clr,                 // Clear/reset signal
    input wire [WIDTH-1:0] BusMuxOut, // From bus
    input wire [WIDTH-1:0] Mdatain,   // From memory
    input wire Read,                // Read control signal
    input wire MDRin,               // Write enable
    output wire [WIDTH-1:0] MDRout   // Output data
);

    reg [WIDTH-1:0] MDMux_out;
    
    always @(*) begin
        if (Read)
            MDMux_out = Mdatain;   
        else
            MDMux_out = BusMuxOut; 
    end
    
    register #(WIDTH) mdr_reg(.clk(clk), .clr(clr),.d(MDMux_out),.enable(MDRin),.q(MDRout));

endmodule