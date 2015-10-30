module ALU(ALUop, Ain, Bin, result, status) ;

	input [1:0] ALUop ;
	input [15:0] Ain, Bin ;
	output[15:0] result ;
	output [2:0] status ;

	reg [15:0] result ;
	reg [2:0] status ;
	reg ALUaddsub ;

	wire MSB ;
	wire ovf ;
	
	assign MSB = result[15] ; 
	//operation of results
	always @(*) begin
		case(ALUop)
			2'b00: result = Ain + Bin ;
			2'b01: result = Ain - Bin ;
			2'b10: result = Ain & Bin ;
			2'b11: result = ~Bin ;
		endcase 
	end

	always @(*) begin
		if(ALUop[1] == 0)
			ALUaddsub = ALUop[0] ? 1'b1 : 1'b0 ;
		else
			ALUaddsub = 1'bx ;
	end

	Overflow #(16)testingOver(.a(Ain) , .b(Bin), .sub(ALUaddsub), .ovf(ovf) ) ;

	//determines status
	always @(*) begin
		if(result == 0)
			status = {1'b1, MSB, ovf} ;
		else 
			status = {1'b0, MSB, ovf} ;
	end

endmodule 