`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Mux16x1(Sel,Dat0, Dat1, Dat2, Dat3, Dat4, Dat5, Dat6,Dat7,Dat8,Dat9,Dat10,DatSal);
	 input [17:0] Dat0, Dat1, Dat2, Dat3, Dat4, Dat5, Dat6,Dat7,Dat8,Dat9,Dat10;
	 input [3:0]Sel;
	 output reg [17:0] DatSal;
   always @(Sel,Dat0, Dat1, Dat2, Dat3, Dat4, Dat5, Dat6,Dat7,Dat8,Dat9,Dat10)
      case (Sel)
         4'b0000: DatSal = Dat0;
         4'b0001: DatSal = Dat1;
         4'b0010: DatSal = Dat2;
         4'b0011: DatSal = Dat3;
         4'b0100: DatSal = Dat4;
         4'b0101: DatSal = Dat5;
         4'b0110: DatSal = Dat6;
         4'b0111: DatSal = Dat7;
         4'b1000: DatSal = Dat8;
         4'b1001: DatSal = Dat9;
         4'b1010: DatSal = Dat10;
			default: DatSal = 18'b0;
      endcase
endmodule
