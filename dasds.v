`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:55:54 06/11/2014
// Design Name:   Proyecto2_NOREFPOT_ROM
// Module Name:   C:/Users/Alejandro/Desktop/Version 4 Proyecto 2/proyecto1/SIMU_MICRO_ROM.v
// Project Name:  Proyecto1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Proyecto2_NOREFPOT_ROM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SIMU_MICRO_ROM;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire TxD;
	wire TxD_busy;
	wire ena2;

	// Instantiate the Unit Under Test (UUT)
	Proyecto2_NOREFPOT_ROM uut (
		.clk(clk), 
		.rst(rst), 
		.TxD(TxD), 
		.TxD_busy(TxD_busy), 
		.ena2(ena2)
	);


	initial forever #10 clk = !clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
//		force uut.CLK_12M = 1;
//		force uut.CLK_50M = 1;
//		#30;
//		release uut.CLK_12M;
//		release uut.CLK_50M;
		#100 rst = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

