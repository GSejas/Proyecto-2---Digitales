`timescale 1ns / 1ps

module MUX32bits(select,dato1,dato2,salida);//mux de salida despues de la alu
input select;
input [31:0]dato1,dato2;
output wire [31:0]salida;

assign salida=(select)? dato1:dato2;

endmodule
