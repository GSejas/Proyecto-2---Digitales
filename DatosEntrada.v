`timescale 1ns / 1ps

module RAM32bits(clk, DatIn, DatOut, WrtAddrs,RdAddrs,WrtEna);

	
   parameter RAM_WIDTH = 32;
   parameter RAM_ADDR_BITS = 4;

	output [31:0]DatOut;
	
	
   input [RAM_ADDR_BITS-1:0] RdAddrs, WrtAddrs;
	input clk,WrtEna;
	input [RAM_WIDTH-1:0] DatIn;

//   (* RAM_STYLE="{AUTO | DISTRIBUTED | PIPE_DISTRIBUTED}" *)
   reg [RAM_WIDTH-1:0] AcquireData [(2**RAM_ADDR_BITS)-1:0];



   always @(posedge clk)
      if (WrtEna)
         AcquireData[WrtAddrs] <= DatIn;

   assign DatOut = AcquireData[RdAddrs];   
					
endmodule
