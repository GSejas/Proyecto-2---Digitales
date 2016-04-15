`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:36:55 05/14/2014 
// Design Name: 
// Module Name:    DECO_MAQUINAPRIN 
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
module DECO_MAQUINAPRIN(IN,OUT);
	input [4:0] IN;
	output reg [2:0] OUT;
	
	always@(IN)
		case(IN)
			5'd0: OUT=3'b011;
			5'd1: OUT=3'b011;
			5'd2: OUT=3'b011;
			5'd3: OUT=3'b011;
			5'd4: OUT=3'b011;
			5'd5: OUT=3'b011;
			5'd6: OUT=3'b011;
			5'd7: OUT=3'b011;
			5'd8: OUT=3'b011;
			5'd9: OUT=3'b011;
			5'd10: OUT=3'b011;
			5'd11: OUT=3'b011;
			5'd12: OUT=3'b011;
			5'd13: OUT=3'b011;
			5'd14: OUT=3'b011;
			5'd15: OUT=3'b011;
			5'd16: OUT=3'b100;
			5'd17: OUT=3'b101;
			5'd18: OUT=3'b110;
			5'd19: OUT=3'b011;
			default OUT=3'b011;
		endcase


endmodule
