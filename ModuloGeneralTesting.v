`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////
module ModuloGeneral(clk,rst,referencia,MOSI,MISO,SPI_CLK,CS_AMP,ADC_Conv,PWM,SPI_SS_B, DAC_CS, FPGA_INIT_B,AMP_Shunt);


	input clk,rst;
	input  MISO;
	input [7:0]referencia;



	output wire PWM;

	
output wire SPI_CLK, CS_AMP, ADC_Conv, MOSI, SPI_SS_B, DAC_CS, FPGA_INIT_B,AMP_Shunt;
	
	wire ena2;
	wire [17:0]PWMin;
	wire [17:0]CompDat;
	wire [7:0]yactual;

assign SPI_SS_B = 1'b1;
assign DAC_CS = 1'b1;
assign FPGA_INIT_B = 1'b0;
assign AMP_Shunt = 1'b0;

SPIController Yactual(clk, rst, ena2, yactual, MOSI, MISO, SPI_CLK, CS_AMP, ADC_Conv);

todoPID PID(clk,rst,{yactual[7],yactual},{referencia[7],referencia},ena2,PWMin);

sumador16bits SUM(PWMin,18'd131071,CompDat);

PWMFbase12k PWM1(clk, rst, CompDat[17:10], PWM);

endmodule
