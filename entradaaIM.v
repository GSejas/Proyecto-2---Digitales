`timescale 1ns / 1ps

module entradaaIM(clk,rst,ena1,ena2,Rdadress);// es la parte que esta antes de la IM timer y contador
input clk,rst,ena1,ena2;
output wire [3:0]Rdadress;
///////////////////////////////////
wire rstcont,ena;
timer5ms timer(clk,rst,rstcont);// 
cont4bits contador(clk,rstcont,ena,Rdadress);//la entrada que activa al mismo biene desde el control general y el control de entrada
assign ena=ena1&ena2;//and de ambos valores
endmodule
