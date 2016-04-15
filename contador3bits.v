`timescale 1ns / 1ps

module contador3bits(clk,rst,ena,cuenta1,listo);//
input clk,rst,ena;
output wire[1:0]cuenta1; 
output wire listo;
reg [2:0]cuenta;
always @(posedge clk)
	if(rst)
		cuenta=2'b0;
	else if(ena)
		cuenta=cuenta+1'b1;
	else 
		cuenta=cuenta;
		
assign listo=cuenta[2];//muestra cuando se completaron los paquetes
assign cuenta1=cuenta[1:0];//extrae la cuenta para que seleccione el registro
endmodule
