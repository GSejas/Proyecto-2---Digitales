`timescale 1ns / 1ps

module ModuloGeneralProyecto2NORef(clk,rst,referencia,MOSI,MISO,SPI_CLK,CS_AMP,PWMin,ADC_Conv,RxD);


	input clk,rst,RxD;
	input  MISO;
	input [7:0]referencia;

	
output wire SPI_CLK, CS_AMP, ADC_Conv, MOSI;
	
	output [17:0]PWMin;
	wire [7:0]yactual;
	wire [17:0]REF;
	wire [17:0]POT;
	wire CLK_50M, CLK_12M;
	wire ena2;
	assign REF= {{11{referencia[7]}},referencia[7:1]};

	assign POT = {{10{yactual[7]}},yactual};

DCM_12MHz CLKs(clk,rst,CLK_50M,CLK_12M);

SPIController Yactual(CLK_50M, rst, ena2, yactual, MOSI, MISO, SPI_CLK, CS_AMP, ADC_Conv);

Microcontrolador Micro(CLK_12M,rst, REF , POT ,PWMin, RxD,ena2);



endmodule
