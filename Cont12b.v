`timescale 1ns / 1ps

module Conta12b(rst, clk, cuenta);

parameter LARGO = 8;
input rst, clk, ena;
output reg [LARGO - 1:0]cuenta;

always @(negedge clk, posedge rst)
	if(rst)
		cuenta = 0;
	else
		cuenta = cuenta + 1;

	
	
endmodule
