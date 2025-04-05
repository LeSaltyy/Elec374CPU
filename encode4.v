module encode4(
    input wire [3:0] select, 
    output reg [15:0] R
);

always @(*) begin
    R = 16'b0;  
    case (select)
        4'd0:  R[0]  = 1;
        4'd1:  R[1]  = 1;
        4'd2:  R[2]  = 1;
        4'd3:  R[3]  = 1;
        4'd4:  R[4]  = 1;
        4'd5:  R[5]  = 1;
        4'd6:  R[6]  = 1;
        4'd7:  R[7]  = 1;
        4'd8:  R[8]  = 1;
        4'd9:  R[9]  = 1;
        4'd10: R[10] = 1;
        4'd11: R[11] = 1;
        4'd12: R[12] = 1;
        4'd13: R[13] = 1;
        4'd14: R[14] = 1;
        4'd15: R[15] = 1;
        default: R = 16'b0; 
    endcase
end

endmodule