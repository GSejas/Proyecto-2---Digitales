`timescale 1ns / 1ps

module DecoPrioridad(Sel, Salid);
	 input [3:0]Sel;
	 output reg [7:0] Salid;
	 
   always @(*)
      case (Sel)
         4'b0011: Salid = 8'b00000001; 
         4'b0100: Salid = 8'b00000010; 
         4'b0101: Salid = 8'b00000100;  //5
         4'b0110: Salid = 8'b00001000;  //6
         4'b0111: Salid = 8'b00010000;  //7
         4'b1000: Salid = 8'b00100000;  //8
         4'b1001: Salid = 8'b01000000;  //9
         4'b1010: Salid = 8'b10000000;  //10

			default: Salid = 8'b0;
      endcase
endmodule
