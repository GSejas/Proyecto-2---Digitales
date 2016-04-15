`timescale 1ns / 1ps

module I(clk,rst,etapa5,etapa2,yact,ref,ki,Isal);
input clk,rst,etapa5,etapa2;
input [8:0]yact,ref,ki;
output wire[17:0] Isal;
wire [8:0]dif;
wire [17:0]kiek,iant,salida,guardado;
//////////////////////////////////////////////////////////////////////////////
restador8bits restador(ref,yact,dif);
multiplicador multip(ki,dif,kiek);
//////////////////////////////////////////////////////////////////////////////
sumador16bits suma(iant,kiek,salida);
registro16bits ianterior(clk,rst,etapa5,guardado,iant);
//////////////////////////////////////////////////////////////////////////////
registro16bits sigue(clk,rst,etapa2,salida,guardado);
assign Isal=guardado;
endmodule
