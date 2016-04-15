`timescale 1ns / 1ps


module Conta2b(rst, clk, ena, cuenta);

parameter LARGO = 2;
input rst, clk, ena;
output reg [LARGO - 1:0]cuenta;

always @(negedge clk, posedge rst)
	if(rst)
		cuenta = 0;
	else if (ena)
		cuenta = cuenta + 1;
	else
		cuenta = cuenta;
	
	
endmodule
