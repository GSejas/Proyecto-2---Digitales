`timescale 1ns / 1ps

module FSMentrada(clk,rst,listo,opcode,ejecu,activreg,actwr,rstcont,actcont2);
input clk,rst,listo,opcode;
output reg ejecu,actwr,rstcont,actcont2,activreg;
 
reg [1:0] pres,futu;
// se utilizan parametros par  llamar los estados
	parameter 
	t0=2'b00,
	t1=2'b01,
	t2=2'b10,
	t3=2'b11;
// se toma en cuenta el rst
always @(negedge clk)
	if (rst)
		pres=0;
	else if(opcode)
		pres=3;
	else
		pres=futu;
// se toma en cuenta ya sea que haya un cambio en el estado o haya cambiado una variable	
always @(pres or listo  or opcode )
case(pres)
	t0: futu=t1;//directamente
	t1: if(listo)//pregunta si ya se pasaron los 4 paquetes 
			futu=t2;
		 else
			futu=t1;
	t2: if(opcode)//pregunta si se llego al ultimo paquete
			futu=t3;//
		else 
			futu=t1;// si no se devuelve a esperar otros 4 paquetes 
	t3: futu=t3;//se queda en este estado por siempre hasta que 

endcase

always @(pres)
	case(pres)
		t0:begin 
			rstcont=1;//resetea el contador externo
			activreg=0;//activa los registros
			actwr=0;//activa la escritura a IM
			actcont2=0;//activa el ena del contador interno
			ejecu=0;end//realiza la ejecucion del control
		t1:begin 
			rstcont=0;
			activreg=1;
			actwr=0;
			actcont2=0;
			ejecu=0;end
		t2:begin 
			rstcont=1;
			activreg=0;
			actwr=1;
			actcont2=1;
			ejecu=0;end
		t3:begin 
			rstcont=0;
			activreg=0;
			actwr=0;
			actcont2=0;
			ejecu=1;end
	endcase
endmodule
