`timescale 1ns / 1ps

module MicrodePruebas(clk, rst, REF, POT, PWM, InstruccionIn_IR, WrtAddrs, WTReady, WrtEna, PC, InstruccionOut_IR, OperaA, OperaBBancos,OperaBALU, WrDat);

//Entradas
input clk, rst;
input   [17:0]REF, POT;
input [31:0]InstruccionIn_IR;
input [3:0]WrtAddrs;
input WrtEna;
input  WTReady;
output  [17:0]PWM;
output [3:0]PC;
output [31:0]InstruccionOut_IR;
output [17:0]WrDat;
output [17:0]OperaA, OperaBBancos,OperaBALU;


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


//Decodificacion de la Instruccion

wire RST_PC;

//Ejecucion

wire [17:0]ExtSign;

//CONTROL
wire [5:0]CONTROL;
wire CE_MEM,SEL_OPERAB,REG_WR,SEL_DEST;
wire [1:0]LU_OPCODE;
//Escritura de Programa

wire [3:0]AddDestino;

RAM32bits InstructionRegister(clk, InstruccionIn_IR, InstruccionOut_IR, WrtAddrs,PC,WrtEna);

assign opcode = InstruccionOut_IR[31:26];
assign AddrsRs = InstruccionOut_IR[24:21];
assign AddrsRt = InstruccionOut_IR[19:16];
assign AddrsRd = InstruccionOut_IR[14:11];
assign Shamt = InstruccionOut_IR[10:6];
assign funct = InstruccionOut_IR[5:0];
assign Inmediate = InstruccionOut_IR[20:0];


BancoRegistros BankReg(clk, rst,REG_WR, WrDat,AddrsRs ,AddrsRt, AddDestino, REF, POT, PWM,OperaA, OperaBBancos);
Conta4b PC1(RST_PC, clk, WTReady&&CE_MEM, PC);
assign AddDestino = SEL_DEST ? AddrsRt : AddrsRd;


ALU  AALU(LU_OPCODE,OperaA,OperaBALU,WrDat);
//Bloque Extension de Signo
assign ExtSign = {2*{Inmediate[15]}, Inmediate};
assign  OperaBALU = SEL_OPERAB  ? ExtSign : OperaBBancos; 


assign CE_MEM=CONTROL[0];
assign LU_OPCODE=CONTROL[2:1];
assign SEL_OPERAB=CONTROL[3];
assign REG_WR=CONTROL[4];
assign SEL_DEST=CONTROL[5];
//

ControlControl CCPU(opcode,funct,WTReady,CONTROL);

Timer5ms Time(clk,rst,1'b1,RST_PC);

endmodule
