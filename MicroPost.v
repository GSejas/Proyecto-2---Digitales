`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:31 06/11/2014 
// Design Name: 
// Module Name:    MicroPost 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MicroPost(clk, rst, REF, POT, PWM, Ena_ADC,wv1,wa0,wa1,wa2,wa3,wt0,wt1,wt2);

//Entradas
input clk, rst;
input   [17:0]REF, POT;
output  [17:0]PWM;
output Ena_ADC;

output wire [17:0] wv1,wa0,wa1,wa2,wa3,wt0,wt1,wt2;

//Salidas


//Formato de la Instruccion
wire [3:0]AddrsRt;
wire [3:0]AddrsRs;
wire [3:0]AddrsRd;
wire [15:0]Inmediate;
wire [4:0]Shamt;
wire [5:0]funct;
wire [5:0]opcode;


//Fetch
wire [31:0]InstruccionOut_IR;
wire [3:0]PC;


//Decodificacion de la Instruccion
wire [17:0]WrDat;
wire RST_PC;

//Ejecucion
wire [17:0]OperaA, OperaBBancos,OperaBALU;
wire [17:0]ExtSign;

//CONTROL
wire [5:0]CONTROL;
wire CE_MEM,SEL_OPERAB,REG_WR,SEL_DEST;

//Escritura de Programa

wire [3:0]AddDestino;
wire [1:0]LU_OPCODE;

RAMReplacement_ROM InstructionRegister(PC,InstruccionOut_IR);

assign Ena_ADC = !CE_MEM;


assign opcode = InstruccionOut_IR[31:26];
assign AddrsRs = InstruccionOut_IR[24:21];
assign AddrsRt = InstruccionOut_IR[19:16];
assign AddrsRd = InstruccionOut_IR[14:11];
assign Shamt = InstruccionOut_IR[10:6];
assign funct = InstruccionOut_IR[5:0];
assign Inmediate = InstruccionOut_IR[20:0];


BancoPost BankReg(clk, rst,REG_WR, WrDat, AddrsRs, AddrsRt, AddDestino, REF, POT, PWM,OperaA, OperaBBancos, wv1,wa0,wa1,wa2,wa3,wt0,wt1,wt2);

Conta4b PC1(RST_PC, clk, (1'b1)&&CE_MEM, PC);
assign AddDestino = SEL_DEST ? AddrsRt : AddrsRd;


ALU  AALU(LU_OPCODE,OperaA,OperaBALU,WrDat);
//Bloque Extension de Signo
assign ExtSign = {{2{Inmediate[15]}}, Inmediate};
assign  OperaBALU = SEL_OPERAB  ? ExtSign : OperaBBancos; 


assign CE_MEM=CONTROL[0];
assign LU_OPCODE=CONTROL[2:1];
assign SEL_OPERAB=CONTROL[3];
assign REG_WR=CONTROL[4];
assign SEL_DEST=CONTROL[5];
//

CONTROLCPU CCPU(opcode,funct,1'b1,CONTROL);

Timer5ms Time(clk,rst,1'b1,RST_PC);

endmodule
