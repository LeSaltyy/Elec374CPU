module encoder32to5 (
    input wire [15:0] RoutWire,  // 16-bit wire, corresponds to R0out, R1out, ..., R15out
    input wire HIout, LOout, Zhighout, Zlowout, PCout, MDRout, InPortout, Cout,
    output reg [4:0] select
);

    always @(*) begin
		  select = 5'd24;
        if (RoutWire[0])      select = 5'd0;  
        else if (RoutWire[1]) select = 5'd1;  
        else if (RoutWire[2]) select = 5'd2;  
        else if (RoutWire[3]) select = 5'd3;  
        else if (RoutWire[4]) select = 5'd4;  
        else if (RoutWire[5]) select = 5'd5;  
        else if (RoutWire[6]) select = 5'd6;  
        else if (RoutWire[7]) select = 5'd7;  
        else if (RoutWire[8]) select = 5'd8;  
        else if (RoutWire[9]) select = 5'd9;  
        else if (RoutWire[10]) select = 5'd10;  
        else if (RoutWire[11]) select = 5'd11;  
        else if (RoutWire[12]) select = 5'd12;  
        else if (RoutWire[13]) select = 5'd13;  
        else if (RoutWire[14]) select = 5'd14;  
        else if (RoutWire[15]) select = 5'd15;

        else if (HIout)      select = 5'd16;
        else if (LOout)      select = 5'd17;
        else if (Zhighout)   select = 5'd18;
        else if (Zlowout)    select = 5'd19;
        else if (PCout)      select = 5'd20;
        else if (MDRout)     select = 5'd21;
        else if (InPortout)  select = 5'd22;
        else if (Cout)       select = 5'd23;
    end

endmodule
