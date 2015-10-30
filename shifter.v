module shifter(Bin, shift, Bout) ;
	input [15:0] Bin ;
	input [1:0] shift ;
	output[15:0] Bout ;

	wire MSB ;
	reg [15:0] Bout ;
	wire[15:0]Binshifted ;
	
	assign MSB = Bin[15] ;
	assign Binshifted = Bin >> 1 ; //shifts the Bin to the right

	always @(*) begin
		case(shift)
			2'b00 : Bout = Bin ;
			2'b01 : Bout = Bin << 1 ;
			2'b10 : Bout = Bin >> 1 ;
			2'b11 : Bout = {MSB, Binshifted[14:0]} ;
		endcase 
	end
endmodule 