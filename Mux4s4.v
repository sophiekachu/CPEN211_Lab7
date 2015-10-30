module Mux4s4(a3, a2, a1, a0, s, b) ;
	parameter n = 16 ;
	input [n-1:0] a3, a2, a1, a0 ; 	//inputs with 16 bits corresponding to 16 bit busses
	input [3:0] s ;  				
	output[n-1:0] b ;
	reg   [n-1:0] b ;
	
	always @(*) begin
		case(s)
			4'b0001: b = a0 ;
			4'b0010: b = a1 ;
			4'b0100: b = a2 ;
			4'b1000: b = a3 ;
			default: b = {n{1'bx}} ;
		endcase
	end
endmodule 