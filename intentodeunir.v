`timescale 1ns / 1ps

module intentodeunir(clk,rst,RxD,tododato,actwr,wradress,ejecu,RxD_idle);


///////////////////////

input clk,rst,RxD;
////////////////////////////

output wire[31:0]tododato;// dato en 32 bits
output wire actwr,ejecu, RxD_idle;// activa la entrada a IM y la segunda activa el control general
output wire[3:0]wradress;// la que tiene que escribir en IM

//////////////////////////////////////////////////////////////
wire[7:0]RxD_data;
wire RxD_data_ready;//
wire RxD_endofpacket, sal;//

//////////////////////////////////////////////////////////
async_receiver uart(clk,RxD,RxD_data_ready,RxD_data,RxD_idle,RxD_endofpacket);//manda rxddata es los datos de entrada 8 bits,

cont2bits Putada(clk,rst,RxD_endofpacket,sal);
// luego dataready me dice que ya se paso el dato y que biene el siguiente,por ultimo rxd idle me dicae que ya termino todo el proceso, lo estoy usando como el opcode del nop
todoentrada entrada(clk,rst,sal,RxD_data_ready,RxD_data,tododato,actwr,wradress,ejecu);// tododato son los 32 bits de salida
//presenta unos errores con una vara del uart rarisima" ASSERTION_ERROR expects 0 arguments"
endmodule

