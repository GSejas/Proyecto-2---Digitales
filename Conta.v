`timescale 1ns / 1ps
`timescale 1ns / 1ps

module Conta(rst, clk, cuenta);

parameter LARGO = 12;
input rst, clk;
output reg [LARGO - 1:0]cuenta;

always @(negedge clk, posedge rst)
	if(rst)
		cuenta = 0;
	else
		cuenta = cuenta + 1;

	
	
endmodule
