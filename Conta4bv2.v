`timescale 1ns / 1ps


module Conta4b(rst, clk, ena, cuenta);

//Contador normal de largo variable, en este caso, 3 bits

parameter LARGO = 4;
input rst, clk, ena;
output reg [LARGO - 1:0]cuenta;

always @(posedge clk)
	if(rst)
		cuenta = 0;
	else if (ena)
		cuenta = cuenta + 1;
	else
		cuenta = cuenta;
	
	
endmodule
