`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:22:30 05/13/2014 
// Design Name: 
// Module Name:    MUX2x14bits 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX2x14bits(A0,A1,SEL,OUT);
	input [3:0] A0,A1;
	input SEL;
	output reg [3:0] OUT;
	
	always @(A0 or A1 or SEL)
		case (SEL)
			1'b0: OUT=A0;
			1'b1: OUT=A1;
		endcase


endmodule
