`timescale 1ns / 1ps

module P(clk,rst,etapa2,kp,yact,propo);
input clk,rst,etapa2;
input signed [8:0]yact,kp;
output wire [17:0]propo;
wire [17:0]salida,guardado;
multiplicador multipique(kp,yact,salida);
registro16bits guarde(clk,rst,etapa2,salida,guardado);
assign propo=guardado; 
endmodule
