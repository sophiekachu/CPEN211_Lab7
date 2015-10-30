module Mux2s1(a1, a0, s, b) ;
	parameter n ;
	input [n-1:0] a1, a0 ; 	//inputs with 16 bits corresponding to 16 bit busses
	input s ;  				
	output[n-1:0] b ;
	reg   [n-1:0] b ;
	
	always @(*) begin
		case(s)
			1'b0: b = a0 ;
			1'b1: b = a1 ;
			default: b = {n{1'bx}} ;
		endcase
	end
endmodule 