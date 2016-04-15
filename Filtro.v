`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:04:57 06/03/2014 
// Design Name: 
// Module Name:    Filtro 
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
module Filtro(CLK,ROTA,ROTB,ROTAF,ROTBF);
	input CLK,ROTA,ROTB;
	output reg ROTAF,ROTBF;
	
	wire [1:0] ROTIN;
	assign ROTIN={!ROTA,!ROTB};
	
	always @(posedge CLK)
		case(ROTIN)
			2'b00: 
				begin 
					ROTAF=0; 
					ROTBF=ROTBF;  
				end
			2'b01: 
				begin 
					ROTAF=ROTAF; 
					ROTBF=0;  
				end
			2'b10: 
				begin 
					ROTAF=ROTAF; 
					ROTBF=1; 
				end
			2'b11: 
				begin 
					ROTAF=1; 
					ROTBF=ROTBF;  
				end
		endcase

endmodule
