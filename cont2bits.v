`timescale 1ns / 1ps

module cont2bits(clk,rst,ena,sal);
input clk,rst,ena;
reg [1:0]cuenta;output wire sal;
always @(negedge clk) 
	if(rst)
		cuenta=2'b0;
	else if(ena)
		cuenta=cuenta+1'b1;
	else
		cuenta=cuenta;		
assign sal = (cuenta == 2'b10);			
		
endmodule
