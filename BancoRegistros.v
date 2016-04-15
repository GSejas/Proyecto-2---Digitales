`timescale 1ns / 1ps

module BancoRegistros(clk, rst,WtReg, WrDat, RtAddrs, RsAddrs, RdAddrs, REF, POT, PWM,OperaA, OperaB);

input clk, rst;
input [3:0] RtAddrs, RsAddrs, RdAddrs; //Se van a trabajar con 16 "registros"
input WtReg;
input [17:0]REF, POT, WrDat;

output [17:0] OperaA, OperaB;
output wire [17:0] PWM;

wire [17:0] wv1,wa0,wa1,wa2,wa3,wt0,wt1,wt2;
wire [7:0] Salid;

 
DecoPrioridad SelDecWrt(RdAddrs, Salid);  //Se habilita el registro a escribir
 
Reg18b v1(clk,rst,WtReg && Salid[0], WrDat, wv1); //temp1
Reg18b a0(clk,rst,WtReg && Salid[1], WrDat, wa0); //ik
Reg18b a1(clk,rst,WtReg && Salid[2], WrDat, wa1); //yk1
Reg18b a2(clk,rst,WtReg && Salid[3], WrDat, wa2); //ik1
Reg18b a3(clk,rst,WtReg && Salid[4], WrDat, wa3); //temp2
Reg18b t0(clk,rst,WtReg && Salid[5], WrDat, wt0); //dk
Reg18b t1(clk,rst,WtReg && Salid[6], WrDat, wt1); //pk
Reg18b t2(clk,rst,WtReg && Salid[7], WrDat, wt2); //pwm

assign PWM = wt2;

Mux16x1 MuxRs(RsAddrs,18'b0, REF, POT, wv1, wa0, wa1, wa2,wa3,wt0,wt1,wt2,OperaB);
Mux16x1 MuxRt(RtAddrs,18'b0, REF, POT, wv1, wa0, wa1, wa2,wa3,wt0,wt1,wt2,OperaA);

endmodule
