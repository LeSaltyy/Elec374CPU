`timescale 1ns/10ps
module control_tb;
    parameter WIDTH = 32;
	 reg Clock;
	 datapath #(WIDTH) uut(.Clock(Clock));

    initial begin

        Clock = 0;
        forever #10 Clock = ~Clock;
    end
endmodule