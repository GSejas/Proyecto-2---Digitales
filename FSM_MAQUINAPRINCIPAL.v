`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 	Manuel Alejandro Mora Orozco
// 
// Create Date:    01:53:12 01/05/2014 
// Design Name: 
// Module Name:    FSM_MAQUINAPRINCIPAL
// Project Name: 	 Control Servo	
// Target Devices: 
// Tool versions: 
// Description: Maquina que controla el manejo del LCD
//////////////////////////////////////////////////////////////////////////////////
module FSM_MAQUINAPRINCIPAL(CLK,RST,INILISTA,TM,BYTESAL,INITM,LCD_RS,INI,CEN,DEC,UNI);
	input CLK,RST,INILISTA,TM;
	input [3:0] CEN,DEC,UNI;
	output wire [7:0] BYTESAL;
	output reg INITM,LCD_RS,INI;
	
	
	// Registros de Estado
	reg [4:0] PRE,FUT;
	parameter T0=5'd0,T1=5'd1,T2=5'd2,T3=5'd3,T4=5'd4,T5=5'd5,T6=5'd6,T7=5'd7,T8=5'd8,T9=5'd9,T10=5'd10,T11=5'd11,T12=5'd12,T13=5'd13,T14=5'd14,T15=5'd15,T16=5'd16,T17=5'd17,T18=5'd18,T19=5'd19;
	
	//Señales de Control de la maquina
	reg [16:0] dosms,dosmssig;//Contador para verificar que pasen 1.64 ms
	reg [4:0] EST;//EST es una variable que representa el estado actual de la maquina
	reg [7:0] BYTE;//variable interna que depende del comando o caracter que se desee imprimir al lcd
	
	//Circuitos del sistema
	wire [3:0] YMUX2;
	wire [2:0] YDECO;
	assign MILL=4'b0000;
	wire [7:0] BYTE2;
	assign BYTE2={4'b0011,YMUX2};//BYTE 2 es un 3cte y el BCD correspondiente a las centenas o unidades o decenas, ya que para el lcd el nibble superior de los numeros del 0 al 9 es siempre 3, y el inferior es igual al BCD del numero
	MUX2x18bits MUXMP1(BYTE,BYTE2,YDECO[2],BYTESAL);//Multiplexa el byte que se le envia al circuito FSM TIMMING, para los estados 1 al 15 y el 19 se envía el byte llamado BYTE que es establecido por la maquina, para los estados 16,17 y 18 se envía el byte que representa un 3 cte y ya sea centenas, decenas o unidades para imprimir en el LCD la referenciua
	MUX4x1de4bits MUXMP2(CEN,DEC,UNI,MILL,YDECO[1:0],YMUX2);//Multiplexa Centenas, decenas y unidades (Millares está de relleno) para ser enviado a la maquina TIMMING
	DECO_MAQUINAPRIN DECOMP1(EST,YDECO);//Dependiendo del estado de esta maquina controla los dos multiplexores anteriores
	
	
	//REGISTRO DE TRANSICION DE ESTADOS
	always @(posedge CLK or posedge RST)
	if(RST)
		begin
			PRE=0;               
			dosms=0;                      
		end
	else
		begin
			PRE=FUT;
			dosms=dosmssig;                      
		end
	
	//RED DE ESTADO FUTURO Y ASIGNACION DE SALIDAS
	always @*//always @* detecta todas las señales sensibles así se ahorra poner todas en la lista de sensitividad
	//Aca se establecen los valores por defecto, es decir que cuando no cambian en un estado tomaran los valores de esta lista
	begin
		FUT = PRE;
		dosmssig = dosms;
		BYTE=8'b00000000;
		INITM = 1'b0;
		LCD_RS = 1'b0;
		INI = 1'b0;
		EST=PRE;
		//aca termina la lista de valores por defecto, esto evita estar metiendo todas las variables en cada case
		case (PRE)
			T0:
				begin
					INI=1'b1;//Señal para comenzar la inicialización
					if(INILISTA)//Solo pasará de estado cuando termine la inicialización
						FUT=T1;
				end
			T1:
				begin
					INITM=1'b1;//Se inicializa la maquina de timming
					LCD_RS = 1'b0;//LCD_RS en 0 indica un comando
					BYTE=8'h28;//Comando FUNCTION SET del LCD
					if(TM)
						FUT=T2;
				end
			T2:
				begin
					INITM=1'b1;
					LCD_RS = 1'b0;//Comando
					BYTE=8'h08;//Comando OFF DISPLAY
					if(TM)
						FUT=T3;
				end
			T3:
				begin
					INITM=1'b1;
					LCD_RS = 1'b0;
					BYTE=8'h06;//COMANDO SET DISPLAY
					if(TM)
						FUT=T4;
				end
			 T4:
				begin
					INITM=1'b1;
					LCD_RS = 1'b0;
					BYTE=8'h01;//COMANDO CLEAR DISPLAY
					if(TM)
						begin
							dosmssig=17'h14050;//Se carga 82000 en dosmssig
							FUT=T5;
						end
				end
			T5:
				begin
					dosmssig=dosms-1;//Comienza cuenta
					if(dosms==0)
						FUT=T6;
				end
			T6:
				begin
					INITM=1'b1;
					LCD_RS = 1'b0;
					BYTE=8'h0c;//COMANDO ON DISPLAY
					if(TM)
						FUT=T7;
				end
			T7:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h20;//Espacio en blanco
					if(TM)
						FUT=T8;
				end
			T8:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h20;//Espacio en blanco
					if(TM)
						FUT=T9;
				end
			T9:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h20;//Espacio en blanco
					if(TM)
						FUT=T10;
				end
			T10:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h20;//Espacio en blanco
					if(TM)
						FUT=T11;
				end
			T11:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h20;//Espacio en blanco
					if(TM)
						FUT=T12;
				end
			T12:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h52;//LETRA R
					if(TM)
						FUT=T13;
				end
			T13:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h45;//LETRA E
					if(TM)
						FUT=T14;
				end
			T14:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h46;//LETRA F
					if(TM)
						FUT=T15;
				end
			T15:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h3A;//SIGNO :
					if(TM)
						FUT=T16;
				end
			T16:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h30;//El numero que tenga las centenas en ese momento, el que está acá y en los dos siguientes estados es relleno
					if(TM)
						FUT=T17;
				end
			T17:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h31;//El numero que tenga las decenas en ese momento
					if(TM)
						FUT=T18;
				end
			T18:
				begin
					INITM=1'b1;
					LCD_RS = 1'b1;//Indica que se escribirá en el lcd
					BYTE=8'h32;//El numero que tenga las unidades en ese momento
					if(TM)
						FUT=T19;
				end
			T19:
				begin
					INITM=1'b1;
					LCD_RS = 1'b0;//Indica que se escribirá en el lcd
					BYTE=8'h02;//Comando CURSOR HOME
					if(TM)
						FUT=T7;//El refrescamiento se repite eternamente
				end
		endcase
	end
endmodule
