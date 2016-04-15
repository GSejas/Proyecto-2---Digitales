`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Alejandro Mora\Stiven Sanchez\Jorge Sequeira
// 
// Create Date:    01:53:12 01/05/2014 
// Design Name: 
// Module Name:    ContadorUpDown8bits
// Project Name: 	 Control Servo	
// Target Devices: 
// Tool versions: 
// Description: Contador up/down de 8 bits para introducir el angulo deseado (REFERENCIA), no hay mucho que explicar mas que las banderas
//////////////////////////////////////////////////////////////////////////////////
module ContadorUpDown8bits(CLK,RST,ENA,UP,DOWN,CUENTA,BANDERAENADOWN,BANDERAENAUP);
	input CLK,RST,ENA,UP,DOWN;
	output wire BANDERAENADOWN,BANDERAENAUP;
	output reg [8:0] CUENTA;
	
	always@(posedge CLK or posedge RST)
		if(RST)
			CUENTA=9'd180;
		else
			if(ENA&UP)
				CUENTA=CUENTA+5;
			else if(ENA&DOWN)
				CUENTA=CUENTA-5;
			else
				CUENTA=CUENTA;
		
			assign BANDERAENADOWN=(~(CUENTA<=9'd20));//Bandera de limite inferior, el mismo es 20 ya que no se recomienda usar angulos cercanos a 0 en el servo
			assign BANDERAENAUP=(~(CUENTA>=9'd340));//Bandera de limite superior, el mismo es 340 ya que no se recomienda usar angulos cercanos a 360 en el servo

endmodule
