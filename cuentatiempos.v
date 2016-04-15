`timescale 1ns / 1ps

module cuentatiempos(clk,rst1,ena1,salidaz1,salida2);
input clk,rst1,ena1;
output wire salidaz1;
output wire salida2;
reg [24:0] cuenta;
always @(posedge clk)
	if(rst1)
		cuenta=25'b0;
	else if (ena1)
		cuenta=cuenta+1'b1;
	else 
		cuenta=cuenta;
		// represeta un segundo del clock
assign salidaz1=(cuenta==25'd250000);
assign salida2=&cuenta[1:0];
endmodule
