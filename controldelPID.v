`timescale 1ns / 1ps

module controldelPID(clk,rst,tiempo,seg,ena1,ena2,ki,kd,kp,rst1,etapa2,etapa3,etapa4);
input clk,tiempo,rst,seg;
output reg ena1,ena2,rst1,etapa2,etapa3,etapa4;
output reg [8:0] ki,kp,kd;
reg [2:0] pres,futu;
// se utilizan parametros par  llamar los estados
	parameter 
	t0=3'b000,
	t1=3'b001,
	t2=3'b010,
	t3=3'b011,
	t4=3'b100,
	t5=3'b101,
	t6=3'b110,
	t7=3'b111;
// se toma en cuenta el caso de rst
always @(posedge clk or posedge rst)
	if (rst)
		pres=0;
	else
		pres=futu;
// se toma en cuenta ya sea que haya un cambio en el estado o haya cambiado una variable	
always @(pres or tiempo or seg)
	case(pres)
	t0: futu=t1;
	t1: if(seg)
			futu=t2;
		 else
			futu=t1;
	t2: if(seg)
			futu=t3;
		 else
			futu=t2;
	t3: if(seg)
			futu=t4;
		 else
			futu=t3;
	t4: if(seg)
			futu=t5;
		 else
			futu=t4;
	t5:futu=t6;
	t6: futu=t7;
	t7: if(tiempo)
			futu=t0;
		 else
			futu=t7;
	
	endcase
// se asignan las salidas respectivas a cada uno de los estados
always @(pres)
	case(pres)
		t0:begin 
			ena1=0;
			ena2=0;
			rst1=1;
			ki=9'd504;
			kp=9'd493;
			kd=9'd436;
			etapa2=0;
			etapa3=0;
			etapa4=0;end
		t1:begin 
			ena1=1;
			ena2=0;
			rst1=0;
			ki=9'd7;
			kp=9'd18;
			kd=9'd150;
			etapa2=0;
			etapa3=0;
			etapa4=0;end
		t2:begin 
			ena1=1;
			ena2=0;
			rst1=0;
			ki=9'd7;
			kp=9'd18;
			kd=9'd150;
			etapa2=1;
			etapa3=0;
			etapa4=0;end
		t3:begin 
			ena1=1;
			ena2=0;
			rst1=0;
			ki=9'd7;
			kp=9'd18;
			kd=9'd150;
			etapa2=0;
			etapa3=1;
			etapa4=0;end
		t4:begin 
			ena1=1;
			ena2=0;
			rst1=0;
			ki=9'd7;
			kp=9'd18;
			kd=9'd150;
			etapa2=0;
			etapa3=0;
			etapa4=1;end
		t5:begin 
			ena1=1;
			ena2=0;
			rst1=0;
			ki=9'd7;
			kp=9'd18;
			kd=9'd150;
			etapa2=0;
			etapa3=0;
			etapa4=0;end
		t6:begin 
			ena1=1;
			ena2=0;
			rst1=0;
			ki=9'd7;
			kp=9'd18;
			kd=9'd150;
			etapa2=0;
			etapa3=0;
			etapa4=0;end
		t7:begin 
			ena1=1;
			ena2=1;
			rst1=0;
			ki=9'd7;
			kp=9'd18;
			kd=9'd150;
			etapa2=0;
			etapa3=0;
			etapa4=0;end
	endcase
endmodule
