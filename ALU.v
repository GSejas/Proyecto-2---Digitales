`timescale 1ns / 1ps


module ALU(OPCODE,A,B,P);

	input [1:0] OPCODE;
	input signed [17:0] A,B;
	output reg [17:0] P;
	
	always@(*)
		case(OPCODE)
				2'b00: P=A+B;
				2'b01: P=A-B;
				2'b10: P=A*B;
				2'b11: P=A+B;
		endcase
	


endmodule
