`timescale 1ns / 1ps

module cont4bits(clk,rst,ena,cuenta);
input clk,rst,ena;
output reg [3:0]cuenta;
always @(posedge clk) 
	if(rst)
		cuenta=4'b0;
	else if(ena)
		cuenta=cuenta+1'b1;
	else
		cuenta=cuenta;
endmodule
