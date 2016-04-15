`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:15:15 05/21/2014
// Design Name:   ModuloGeneral
// Module Name:   C:/Users/Alejandro/Desktop/Proyecto1.4/Proyecto1.4/proyecto1.2/proyecto1/bla.v
// Project Name:  Proyecto1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ModuloGeneral
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module bla;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] referencia;
	reg MISO;

	// Outputs
	wire MOSI;
	wire SPI_CLK;
	wire CS_AMP;
	wire ADC_Conv;
	wire PWM;
	wire SPI_SS_B;
	wire DAC_CS;
	wire FPGA_INIT_B;
	wire AMP_Shunt;

	// Instantiate the Unit Under Test (UUT)
	ModuloGeneral uut (
		.clk(clk), 
		.rst(rst), 
		.referencia(referencia), 
		.MOSI(MOSI), 
		.MISO(MISO), 
		.SPI_CLK(SPI_CLK), 
		.CS_AMP(CS_AMP), 
		.ADC_Conv(ADC_Conv), 
		.PWM(PWM), 
		.SPI_SS_B(SPI_SS_B), 
		.DAC_CS(DAC_CS), 
		.FPGA_INIT_B(FPGA_INIT_B), 
		.AMP_Shunt(AMP_Shunt)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		referencia = 0;
		MISO = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

