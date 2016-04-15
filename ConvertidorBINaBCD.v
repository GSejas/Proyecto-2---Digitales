`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Alejandro Mora\Stiven Sanchez\Jorge Sequeira
// 
// Create Date:    01:53:12 01/05/2014 
// Design Name: 
// Module Name:    ConvertidorBINaBCD
// Project Name: 	 Control Servo	
// Target Devices: 
// Tool versions: 
// Description: Convierte la cuenta del up/down de binario a bcd para mostrarlo en los displays
//////////////////////////////////////////////////////////////////////////////////
module ConvertidorBINaBCD(BIN,CENTENAS,DECENAS,UNIDADES);
	input [8:0] BIN;
	output reg [3:0] CENTENAS,DECENAS,UNIDADES;
	
	//variable de control del algoritmo
	integer n;
	//Algoritmo
	always@(BIN)
		begin
			//Inicializar todo a cero
			CENTENAS=4'd0;
			DECENAS=4'd0;
			UNIDADES=4'd0;
			
			for(n=8; n>=0; n=n-1)
				begin
					//Si alguna columna es mayor a 5 se le suma 3
					if(CENTENAS>=5)
						CENTENAS=CENTENAS+3;
					if(DECENAS>=5)
						DECENAS=DECENAS+3;
					if(UNIDADES>=5)
						UNIDADES=UNIDADES+3;
					//Corrimientos para ir formando los nibbles
					CENTENAS=CENTENAS<<1;
					CENTENAS[0]=DECENAS[3];
					DECENAS=DECENAS<<1;
					DECENAS[0]=UNIDADES[3];
					UNIDADES=UNIDADES<<1;
					UNIDADES[0]=BIN[n];
				end
		end

endmodule
