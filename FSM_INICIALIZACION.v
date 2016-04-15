`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Alejandro Mora\Stiven Sanchez\Jorge Sequeira
// 
// Create Date:    01:53:12 01/05/2014 
// Design Name: 
// Module Name:    FSM_INICIALIZACION
// Project Name: 	 Control Servo	
// Target Devices: 
// Tool versions: 
// Description: FSM encargada de inicializar el display LCD
//////////////////////////////////////////////////////////////////////////////////
module FSM_INICIALIZACION(CLK,RST,INI,SF_ENDINI,INILISTO);
	input CLK,RST,INI;
	output reg [4:0] SF_ENDINI;
	output reg INILISTO;
	
	//Registros de Estado
	reg [3:0] PRE,FUT;
	parameter T0=4'b0000,T1=4'b0001,T2=4'b0010,T3=4'b0011,T4=4'b0100,T5=4'b0101,T6=4'b0110,T7=4'b0111,T8=4'b1000,T9=4'b1001,T10=4'b1010;
	
	//Señales de Control de la maquina
	reg [19:0] quincems,quincemssig;//Contador para verificar que pasen 15 ms
	reg [3:0] doce_ciclos,doce_ciclossig;//Contador para verificar que se cumplan 12 ciclos de reloj
	reg [18:0] cuatroms,cuatromssig;//Contador para verificar que pasen 4.1 ms
	reg [12:0] cienus,cienussig;//Contador para verificar 100us
	reg [10:0] cuarentaus,cuarentaussig;//verifica 40 us
	
	//REGISTRO DE TRANSICION DE ESTADOS
	always @(posedge CLK or posedge RST)
	if(RST)
		begin
			PRE=0;               
			quincems=0;                      
			doce_ciclos=0;                      
			cuatroms=0;
			cienus=0;
			cuarentaus=0;
		end
	else
		begin
			PRE=FUT;
			quincems=quincemssig;                      
			doce_ciclos=doce_ciclossig;                      
			cuatroms=cuatromssig;
			cienus=cienussig;
			cuarentaus=cuarentaussig;
		end
		
	//RED DE ESTADO FUTURO Y ASIGNACION DE SALIDAS
	always @*//always @* detecta todas las señales sensibles así se ahorra poner todas en la lista de sensitividad
	//Aca se establecen los valores por defecto, es decir que cuando no cambian en un estado tomaran los valores de esta lista
	begin
		FUT = PRE;
		quincemssig = quincems;
		doce_ciclossig = doce_ciclos;
		cuatromssig = cuatroms;
		cienussig= cienus;
		cuarentaussig =cuarentaus;
		SF_ENDINI =5'b00000;
		INILISTO = 1'b0;
		//aca termina la lista de valores por defecto, esto evita estar metiendo todas las variables en cada case
		case (PRE)
			T0:
				if(INI)
					begin
						quincemssig=20'hb71b0;//Se carga 750000 en quincemssig
						FUT=T1;
					end
			T1:
				begin
					quincemssig=quincems-1;//Comienza la cuenta
					if(quincems==0)
						begin
							doce_ciclossig=4'd12;//Se carga 12 en doce_ciclossig
							FUT=T2;
						end
				end
			T2:
				begin
					doce_ciclossig=doce_ciclos-1;//Comienza la cuenta
					SF_ENDINI=5'b10011;//EN del LCD en 1 durante 12 ciclos de reloj y se carga un 0x3 en el nibble de direccion del LCD
					if(doce_ciclos==0)
						begin
							cuatromssig=19'h320c8;//Se carga un 205000 en cuatromssig
							FUT=T3;
						end
				end
			T3:
				begin
					cuatromssig=cuatroms-1;//Comienza la cuenta de 4.1ms
					SF_ENDINI=5'b00011;//EN del LCD en 0 durante 205000 ciclos de reloj y se carga un 0x3 en el nibble de direccion del LCD
					if(cuatroms==0)
						begin
							doce_ciclossig=4'd12;//Se carga 12 en doce_ciclossig
							FUT=T4;
						end
				end
			T4:
				begin
					doce_ciclossig=doce_ciclos-1;//Comienza la cuenta 12 ciclos
					SF_ENDINI=5'b10011;//EN del LCD en 1 durante 12 ciclos de reloj y se carga un 0x3 en el nibble de direccion del LCD
					if(doce_ciclos==0)
						begin
							cienussig=13'h1388;//Se carga un 5000 en cienussig
							FUT=T5;
						end
				end
			T5:
				begin
					cienussig=cienus-1;//Comienza la cuenta de 100us
					SF_ENDINI=5'b00011;//EN del LCD en 0 durante 5000 ciclos de reloj y se carga un 0x3 en el nibble de direccion del LCD
					if(cienus==0)
						begin
							doce_ciclossig=4'd12;//Se carga 12 en doce_ciclossig
							FUT=T6;
						end
				end
			T6:
				begin
					doce_ciclossig=doce_ciclos-1;//Comienza la cuenta 12 ciclos
					SF_ENDINI=5'b10011;//EN del LCD en 1 durante 12 ciclos de reloj y se carga un 0x3 en el nibble de direccion del LCD
					if(doce_ciclos==0)
						begin
							cuatromssig=19'h320c8;//Se carga un 2000 en cuarentaussig
							FUT=T7;
						end
				end
			T7:
				begin
					cuatromssig=cuatroms-1;//Comienza la cuenta de 40us
					SF_ENDINI=5'b00011;//EN del LCD en 0 durante 2000 ciclos de reloj y se carga un 0x3 en el nibble de direccion del LCD
					if(cuatroms==0)
						begin
							doce_ciclossig=4'd12;//Se carga 12 en doce_ciclossig
							FUT=T8;
						end
				end
			T8:
				begin
					doce_ciclossig=doce_ciclos-1;//Comienza la cuenta 12 ciclos
					SF_ENDINI=5'b10010;//EN del LCD en 1 durante 12 ciclos de reloj y se carga un 0x2 en el nibble de direccion del LCD
					if(doce_ciclos==0)
						begin
							cuarentaussig=11'h7d0;//Se carga un 2000 en cuarentaussig
							FUT=T9;
						end
				end
			T9:
				begin
					cuarentaussig=cuarentaus-1;//Comienza la cuenta de 40us
					SF_ENDINI=5'b00010;//EN del LCD en 0 durante 2000 ciclos de reloj y se carga un 0x2 en el nibble de direccion del LCD
					if(cuarentaus==0)
						FUT=T10;			
				end
			T10:
				INILISTO = 1'b1;//Bandera que indica que la inicialización acabó
				
		endcase
	end
	


endmodule
