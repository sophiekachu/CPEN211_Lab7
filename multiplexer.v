//Multiplexer with binary select 
module Mux8s8(a7, a6, a5, a4, a3, a2, a1, a0, s, b) ;
	parameter k = 16 ;
	input [k-1:0] a7, a6, a5, a4, a3, a2, a1, a0 ; 	//inputs with 16 bits corresponding to 16 bit busses
	input [7:0]   s ;  				//one-hot select for 8 bits from Decoder
	output[k-1:0] b ;
	reg   [k-1:0] b ;
	
	always @(*) begin
		case(s)
			8'b00000001: b = a0 ;
			8'b00000010: b = a1 ;
			8'b00000100: b = a2 ;
			8'b00001000: b = a3 ;
			8'b00010000: b = a4 ;
			8'b00100000: b = a5 ;
			8'b01000000: b = a6 ;
			8'b10000000: b = a7 ;
			default: b = 1'bx ;
		endcase
	end
endmodule 