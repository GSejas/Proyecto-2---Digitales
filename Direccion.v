`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:27:06 06/03/2014 
// Design Name: 
// Module Name:    Direccion 
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
module Direccion(CLK,POSROTAF,ROTBF,EV,IZ);
	input CLK,ROTBF,POSROTAF;
	output reg EV,IZ;
	

	
	always@(posedge CLK)
		begin
			if(POSROTAF)
				begin
					EV=1;
					IZ=ROTBF;
				end
			else
				begin
					EV=0;
					IZ=IZ;
				end
		end
	
endmodule
