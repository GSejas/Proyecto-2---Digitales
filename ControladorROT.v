`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:00:38 06/03/2014 
// Design Name: 
// Module Name:    ControladorROT 
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
module ControladorROT(CLK,ROTA,ROTB,ROTC,ENTER,UP,DOWN);
	input CLK,ROTA,ROTB,ROTC;
	output wire ENTER,UP,DOWN;
	
	
	wire ROTAFS,ROTBFS,Flanco,MOV,IZQ;
	
	Filtro FILTRO1(CLK,ROTA,ROTB,ROTAFS,ROTBFS);
	DetectorFlanco DET1(CLK,ROTAFS,Flanco);
	Direccion DIR1(CLK,Flanco,ROTBFS,MOV,IZQ);
	assign UP=(MOV&!IZQ);
	assign DOWN=(MOV&IZQ);
	assign ENTER=ROTC;


endmodule
