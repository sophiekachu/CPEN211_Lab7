module shifter_tb ;
	reg [15:0] Bin ;
	reg [1:0] shift ;
	wire[15:0] Bout ;

	shifter Shiftingdigits(Bin, shift, Bout) ;

	initial begin
		Bin = 16'b1111000011001111 ;  //Initial Bin to be shifted
		
		#10 ;
		shift = 2'b00 ;
		#10 ;
		$display("Bin = %b, shift = %b, Bout = %b, expected Bout = %b", Bin, shift, Bout, 16'b1111000011001111) ;
		Bin = 16'b1111000011001111 ;
		shift = 2'b01 ;
		#10 ;
		$display("Bin = %b, shift = %b, Bout = %b, expected Bout = %b", Bin, shift, Bout, 16'b1110000110011110) ;
		Bin = 16'b1111000011001111 ;
		shift = 2'b10 ;
		#10 ;
		$display("Bin = %b, shift = %b, Bout = %b, expected Bout = %b", Bin, shift, Bout, 16'b0111100001100111) ;
		Bin = 16'b1111000011001111 ;
		shift = 2'b11 ;
		#10 ;
		$display("Bin = %b, shift = %b, Bout = %b, expected Bout = %b", Bin, shift, Bout, 16'b1111100001100111) ;
		Bin = 16'b0110011001011111 ;
		shift = 2'b11 ;
		#10 ;
		$display("Bin = %b, shift = %b, Bout = %b, expected Bout = %b", Bin, shift, Bout, 16'b0011001100101111) ;
		$stop ;
	end
endmodule 					
						