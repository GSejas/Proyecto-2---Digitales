`timescale 1ns / 1ps

module PIDgeneral(clk,rst,etapa2,etapa3,etapa4,yactual,referencia,ki,kd,kp,PWMin);
input clk,rst,etapa2,etapa3,etapa4;
input[8:0] yactual,referencia,ki,kd,kp;
output wire [17:0]PWMin;
/////////////////////////////////////////////////////////////
//registro9bits yes(clk,rst,etapa1,yactual,yact);// se encarga de guardar la y de entradad una vez que esta llega al moduloPID
//registro9bits referencias(clk,rst,etapa1,referencia,ref);// se encarga de guardar la referencia
///////////////////////////////////////////////////////////
wire [17:0]Isal,propo,dato,Pids;
/////////////////////////////////////
P proporcional(clk,rst,etapa2,kp,yactual,propo);// se encarga de hacer el proporcional
I integral(clk,rst,etapa4,etapa2,yactual,referencia,ki,Isal);//se encarga de hacer el integral
restador16bits restPI(Isal,propo,dato);// se encarga de restar los dos valores anteriores 
registro16bits guardaresta(clk,rst,etapa3,dato,Pids);// se encarga de guardar el resultado de esta resta
//////////////////////////////////////////////////////////
wire [17:0]Dsal,restatodo,fin;
///////////////////////////////////
D derivada(clk,rst,etapa4,etapa3,kd,yactual,Dsal);// se encarga de hacer la derivada del modulo
restador16bits restPID(Pids,Dsal,restatodo);//se encarga de restar el resultado de esta manera iK-Kpyk-kd
registro16bits guardatodo(clk,rst,etapa4,restatodo,fin);//guarda el resultado final para que este sea transmitido al PWm
//////////////////////////////////////////////////////////
assign PWMin=fin;
////////////////////////////////////////////////////////

endmodule
