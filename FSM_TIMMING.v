`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Manuel Alejandro Mora Orozco
// 
// Create Date:    01:53:12 01/05/2014 
// Design Name: 
// Module Name:    FSM_TIMMING
// Project Name: 	 Control Servo	
// Target Devices: 
// Tool versions: 
// Description: Maquina que controla los tiempos que deben cumplir las señales para el control del LCD
//////////////////////////////////////////////////////////////////////////////////
module FSM_TIMMING(CLK,RST,INITM,BYTE,SF_ENDTIM,TM);
	input CLK,RST,INITM;
	input [7:0] BYTE;
	output wire [4:0] SF_ENDTIM;
	output reg TM;
	
	//Registros de Estado
	reg [2:0] PRE, FUT;
	parameter T0=3'b000,T1=3'b001,T2=3'b010,T3=3'b011,T4=3'b100,T5=3'b101,T6=3'b110,T7=3'b111;
	
	//Señales de Control de la maquina
	reg[1:0] dosciclos,dosciclossig;//Contador de 2 ciclos de clk
	reg [3:0] doceciclos,doceciclossig;//Contador de 12 ciclos de clk
	reg [5:0] unuseg,unusegsig;//Contador para verificar que pase 1us
	reg [10:0] cuarentaus,cuarentaussig;//verifica 40 us
	reg SFEN;
	wire [3:0] MSBNIBBLE,LSBNIBBLE;
	assign MSBNIBBLE=BYTE[7:4];//NIBBLE superior
	assign LSBNIBBLE=BYTE[3:0];//NIBBLE inferior
	
	//Circuitos del sistema
	wire YDECO;
	wire [3:0] SF_D;
	reg [2:0] EST;//estado actual de la maquina
	MUX2x14bits MUX1A(MSBNIBBLE,LSBNIBBLE,YDECO,SF_D);//Multiplexamos los nibbles, el superior se envía en los estados 1y 2, el inferior en los 4 y 5
	DECO_ESTADO DECO1(EST,YDECO);//Deco para controlar el multiplexor anterior en funcion del estado actual
	
	//REGISTRO DE TRANSICION DE ESTADOS
	always @(posedge CLK or posedge RST)
	if(RST)
		begin
			PRE=0;               
			dosciclos=0;                      
			doceciclos=0;                      
			unuseg=0;
			cuarentaus=0;
		end
	else
		begin
			PRE=FUT;
			dosciclos=dosciclossig;                      
			doceciclos=doceciclossig;                      
			unuseg=unusegsig;
			cuarentaus=cuarentaussig;
		end
		
	//RED DE ESTADO FUTURO Y ASIGNACION DE SALIDAS
	always @*//always @* detecta todas las señales sensibles así se ahorra poner todas en la lista de sensitividad
	//Aca se establecen los valores por defecto, es decir que cuando no cambian en un estado tomaran los valores de esta lista
	begin
		FUT = PRE;
		dosciclossig = dosciclos;
		doceciclossig = doceciclos;
		unusegsig = unuseg;
		cuarentaussig =cuarentaus;
		SFEN =1'b0;
		TM = 1'b0;
		EST=PRE;
		//aca termina la lista de valores por defecto, esto evita estar metiendo todas las variables en cada case
		case (PRE)
			T0:
				if(INITM)
					begin
						dosciclossig=2'h2;//Se carga 2 en dosciclossig
						FUT=T1;
					end
			
			T1:
				begin
					dosciclossig=dosciclos-1;//Comienza la cuenta
					SFEN =1'b0;//SF_ENDTIM={1'b0,MSBNIBBLE};//EN del LCD en 0 durante 2 ciclos de reloj y se MSBNIBBLE en el nibble de direccion del LCD
					if(dosciclos==0)
						begin
							doceciclossig=4'd12;//Se carga un 12 en doceciclossig
							FUT=T2;
						end
				end
			T2:
				begin
					doceciclossig=doceciclos-1;//Comienza la cuenta
					SFEN =1'b1;//SF_ENDTIM={1'b1,MSBNIBBLE};//EN del LCD en 1 durante 12 ciclos de reloj y se MSBNIBBLE en el nibble de direccion del LCD
					if(doceciclos==0)
						begin
							unusegsig=6'd50;//Se carga un 50 en unusegsig
							FUT=T3;
						end
				end
			T3:
				begin
					unusegsig=unuseg-1;//Comienza la cuenta 1us
					if(unuseg==0)
						begin
							dosciclossig=2'h2;//Se carga 2 en dosciclossig
							FUT=T4;
						end
				end
			 T4:
				begin
					dosciclossig=dosciclos-1;//Comienza la cuenta
					SFEN =1'b0;//SF_ENDTIM={1'b0,LSBNIBBLE};//EN del LCD en 0 durante 2 ciclos de reloj y se LSBNIBBLE en el nibble de direccion del LCD
					if(dosciclos==0)
						begin
							doceciclossig=4'd12;//Se carga un 12 en doceciclossig
							FUT=T5;
						end
				end
			T5:
				begin
					doceciclossig=doceciclos-1;//Comienza la cuenta
					SFEN =1'b1;//SF_ENDTIM={1'b1,LSBNIBBLE};//EN del LCD en 1 durante 12 ciclos de reloj y se LSBNIBBLE en el nibble de direccion del LCD
					if(doceciclos==0)
						begin
							cuarentaussig=11'h7d0;//Se carga un 2000 en cuarentaussig
							FUT=T6;
						end
				end
			T6:
				begin
					cuarentaussig=cuarentaus-1;//Comienza la cuenta 40us
					if(cuarentaus==0)
						FUT=T7;
				end
			T7:
				begin
					TM = 1'b1;//Indica que se ha completado el proceso timming
					FUT=T0;
				end
			
		endcase
	end
	assign SF_ENDTIM={SFEN,SF_D};

endmodule
