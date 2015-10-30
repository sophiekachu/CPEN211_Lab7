module ALU_tb;

	reg[1:0] ALUop;
	reg[15:0] Ain, Bin;
	wire[15:0] result;
	wire status;

	ALU ALU1(ALUop, Ain, Bin, result, status);

	initial begin
		
		ALUop = 2'b0;
		Ain = 21; // 0000000000010101
		Bin = 5; // 0000000000000101
		$display("Input 1: %b, Input 2: %b\n", Ain, Bin);
		#100;
		$display("Actual: %b, Status: %b", result, status);
		#100;

		repeat(3) begin
			ALUop = ALUop + 1'b1;
			#100;
			$display("Actual: %b, Status: %b", result, status);
			#100;
		end

		#100
		ALUop = 2'b0;
		Ain = 0;
		Bin = 0;
		$display("\nInput 1: %b, Input 2: %b", Ain, Bin);
		#100;
		$display("Actual: %b, status: %b\n", result, status);

		#100;
		$display("Expected 1: 0000000000011010\nExpected 2: 0000000000010000\nExpected 3: 0000000000000101\nExpected 4: 1111111111111010\nExpected 5: 0000000000000000, Expected Status 5: 1\n");

		$stop;
	end

endmodule

