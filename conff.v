module conff(
    input wire [1:0] condition_bits,
    input wire [31:0] Bus_Data,     
    input wire CONin,               
    input wire Clock, Clear,         
    output reg CON_Out               
);

    reg [3:0] R;

    always @(*) begin
        case (condition_bits)
            2'b00: R = 4'b0001; 
            2'b01: R = 4'b0010; 
            2'b10: R = 4'b0100; 
            2'b11: R = 4'b1000; 
            default: R = 4'b0000;
        endcase
    end

    always @(*) begin
        if (Clear)
            CON_Out <= 0;
        else if (CONin) begin
            if ((R[0] && (Bus_Data == 32'b0)) ||  
                (R[1] && (Bus_Data != 32'b0)) ||
                (R[2] && (Bus_Data[31] == 1'b0)) || 
                (R[3] && (Bus_Data[31] == 1'b1))) 
                CON_Out <= 1;
            else
                CON_Out <= 0;
        end
    end

endmodule

