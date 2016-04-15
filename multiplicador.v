`timescale 1ns / 1ps

module multiplicador(constante,multiplicador,salida);
input signed [8:0]constante,multiplicador;
output wire[17:0]salida;
assign salida=constante*multiplicador;
endmodule
