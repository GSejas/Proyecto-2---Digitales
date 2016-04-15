`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:28 06/03/2014 
// Design Name: 
// Module Name:    DetectorFlanco 
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
module DetectorFlanco(CLK,IN,Flancopos);
	input CLK,IN;
	output wire Flancopos;
	
	reg retraso;
	
	always@(posedge CLK)
		retraso = IN;
	
	assign Flancopos=(IN&(!retraso));
		



endmodule
