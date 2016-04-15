`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:04:26 06/10/2014 
// Design Name: 
// Module Name:    DCM_12MHz 
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
module DCM_12MHz(CLKFPGA,RST,CLK_50M,CLK_12M);
	input CLKFPGA,RST;
	output CLK_50M,CLK_12M;
	
	// Instantiate the module
	DCS instance_name (
    .CLKIN_IN(CLKFPGA), 
    .RST_IN(RST), 
    .CLKDV_OUT(CLK_12M), 
    .CLK0_OUT(CLK_50M)
    );


endmodule
