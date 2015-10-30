module reg_testbench ;
	reg write, clk ;
	reg  [15:0] data_in ;
	reg  [2:0] writenum, readnum ;
	wire [15:0] data_out ;

	register dut(data_in, writenum, write, readnum, clk, data_out) ;

	initial begin
		clk = 0 ; #10 ;
		repeat(15) begin
			clk = 1 ; #10 ;
			clk = 0 ; #10 ;
		end
	end

	initial begin
		write = 1 ;
		writenum = 3'b100 ; 
		data_in = 24 ; 
		#20 ;
		writenum = 3'b001 ;
		#20 ;
		readnum = 3'b100 ;
		#20 ;
		$display("readnum = %b, data_out = %b, expected data_out = %b", readnum, data_out, 15'd24) ;
		#20 ;
		readnum = 3'b010 ;
		#20 ;
		$display("readnum = %b, data_out = %b, expected data_out = %b", readnum, data_out, 15'bx) ;
		readnum = 3'b001 ;
		#20 ;
		$display("readnum = %b, data_out = %b, expected data_out = %b", readnum, data_out, 15'd24) ;
		writenum = 3'b101 ;
		data_in = 500 ;
		#20 ;
		write = 0 ;
		data_in = 3 ;
		#20 ;
		readnum = 3'b101 ;
		#20 ;
		$display("readnum = %b, data_out = %b, expected data_out = %b", readnum, data_out, 15'd500) ;
		#20 ;
		write = 1 ;
		#20 ;
		$display("readnum = %b, data_out = %b, expected data_out = %b", readnum, data_out, 15'd3) ;		
		$stop ;
	end
		
endmodule
