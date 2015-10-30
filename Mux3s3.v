module Mux3s3(a2, a1, a0, s, b) ;
	parameter n = 16 ;
	input [n-1:0] a2, a1, a0 ; 	//inputs with 16 bits corresponding to 16 bit busses
	input [2:0] s ;  				
	output[n-1:0] b ;
	reg   [n-1:0] b ;
	
	always @(*) begin
		case(s)
			3'b001: b = a0 ;
			3'b010: b = a1 ;
			3'b100: b = a2 ;
			default: b = {n{1'bx}} ;
		endcase
	end
endmodule 