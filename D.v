`timescale 1ns / 1ps

module D(clk,rst,etapa5,etapa3,kd,yact,Dsal);
input clk,rst,etapa5,etapa3;
input [8:0]kd,yact;
output wire [17:0]Dsal;
wire [8:0]yant,ysub;
wire [17:0]kdysub,guardado;
//////////////////////////////////////////////////////////////
registro16bits salidapd(clk,rst,etapa3,kdysub,guardado);
restador8bits ymenos(yact,yant,ysub);
////////////////////////////////////////////////////////////////
multiplicador multi(kd,ysub,kdysub);
registro8bits anterior(clk,rst,etapa5,yact,yant);
assign Dsal=guardado;
endmodule
