`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:24:45 05/13/2014 
// Design Name: 
// Module Name:    DECO_ESTADO 
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
module DECO_ESTADO(IN,OUT);
	input[2:0] IN;
	output reg OUT;
	
	always@(IN)
		case(IN)
				3'd0: OUT=1'b0;
				3'd1: OUT=1'b0;
				3'd2: OUT=1'b0;
				3'd3: OUT=1'b1;
				3'd4: OUT=1'b1;
				3'd5: OUT=1'b1;
				default OUT=1'b1;
		endcase


endmodule
