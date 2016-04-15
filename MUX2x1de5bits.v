`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Manuel Alejandro Mora Orozco
// 
// Create Date:    01:53:12 03/03/2014 
// Design Name: 
// Module Name:    MUX4x1de4bits
// Project Name: 	 Control Servo	
// Target Devices: 
// Tool versions: 
// Description: MUX 2x1 de 5bits
//////////////////////////////////////////////////////////////////////////////////
module MUX2x1de5bits(A0,A1,SEL,OUT);
	input [4:0] A0,A1;
	input SEL;
	output reg [4:0] OUT;
	
	always @(A0 or A1 or SEL)
		case (SEL)
			1'b0: OUT=A0;
			1'b1: OUT=A1;
		endcase
	
endmodule
