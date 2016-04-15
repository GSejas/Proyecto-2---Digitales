`timescale 1ns / 1ps

module contador6bits(clk,rst,ena,cuenta);//cuenta el numero de instruccion que esta ingresando a la memoria IM
input clk,rst,ena;// ena biene dela maquina de estados 
output wire [3:0]cuenta;
reg [3:0]temp;
always @(posedge clk)
	if(rst)
		temp=3'b0;
	else if(ena)
		temp=temp+1'b1;
	else 
		temp=temp;
assign cuenta=temp;//numero que ingresa a la IM

endmodule
