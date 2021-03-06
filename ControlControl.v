`timescale 1ns / 1ps


module ControlControl(OP_CODE,FUNCT,HAB,CONTROL);
//CONTROL[0]=>CE_MEM,
//CONTROL[2:1]=>ALU_OPCODE,
//CONTROL[3]=>SEL_OPERAB
//,CONTROL[4]=>REG_WR,
//CONTROL[5]=>SEL_DEST
	
	input [5:0] OP_CODE,FUNCT;
	input HAB;
	output reg [5:0] CONTROL;
	
   always @(HAB,OP_CODE,FUNCT)
      casex ({HAB,OP_CODE,FUNCT})
         13'b1000000100000: CONTROL=6'b010001;//ADD
         13'b1000000100010: CONTROL=6'b010011;//SUB
         13'b1000000011000: CONTROL=6'b010101;//MULT
         13'b1000000000000: CONTROL=6'b000110;//NOP
         13'b1001000xxxxxx: CONTROL=6'b111001;//ADDI
         13'b1011100000010: CONTROL=6'b010101;//MUL
         default CONTROL=6'b000000;
      endcase
		
endmodule
