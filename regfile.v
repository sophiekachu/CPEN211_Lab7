module register(data_in, writenum, write, readnum, clk, data_out) ;
	input write, clk ;
	input [15:0] data_in ;
	input [2:0] writenum, readnum ;
	output[15:0] data_out ;

	wire[15:0] data_out ;
	wire[7:0] ANDED_results ;	//results for each AND that is connnected to the load enable for vDFFE
	wire[7:0] decoder_results1 ;	//for the wire between 3:8 decoder and ANDs when writing numbers
	wire[15:0] R0, R1, R2, R3, R4, R5, R6, R7; 		//the registers, two dimensional code. R[0],R[1],R[2]... R[7] all have 16 bits. 
	wire[7:0] outRead ;  		//reading number result from the reading decoder
	
	`define Rwidth 16
	
	//decoders
	Decoder dec38w(.a(writenum), .b(decoder_results1)) ; 
	Decoder dec38r(.a(readnum), .b(outRead)) ;   
	
	//multiplexer and out to output
	Mux8s8 multiplexer(.a0(R0), .a1(R1), .a2(R2), .a3(R3), .a4(R4), .a5(R5), .a6(R6), .a7(R7), .s(outRead), .b(data_out)) ;

	//vDFFE writeReg(clk, load, in, out);
	vDFFE #(`Rwidth)Reg0(.clk(clk), .load(ANDED_results[0]), .in(data_in), .out(R0) ) ;
	vDFFE #(`Rwidth)Reg1(.clk(clk), .load(ANDED_results[1]), .in(data_in), .out(R1) ) ;
	vDFFE #(`Rwidth)Reg2(.clk(clk), .load(ANDED_results[2]), .in(data_in), .out(R2) ) ;
	vDFFE #(`Rwidth)Reg3(.clk(clk), .load(ANDED_results[3]), .in(data_in), .out(R3) ) ;
	vDFFE #(`Rwidth)Reg4(.clk(clk), .load(ANDED_results[4]), .in(data_in), .out(R4) ) ;
	vDFFE #(`Rwidth)Reg5(.clk(clk), .load(ANDED_results[5]), .in(data_in), .out(R5) ) ;
	vDFFE #(`Rwidth)Reg6(.clk(clk), .load(ANDED_results[6]), .in(data_in), .out(R6) ) ;
	vDFFE #(`Rwidth)Reg7(.clk(clk), .load(ANDED_results[7]), .in(data_in), .out(R7) ) ;

	assign ANDED_results[0] = write & decoder_results1[0] ;
	assign ANDED_results[1] = write & decoder_results1[1] ;
	assign ANDED_results[2] = write & decoder_results1[2] ;
	assign ANDED_results[3] = write & decoder_results1[3] ;
	assign ANDED_results[4] = write & decoder_results1[4] ;
	assign ANDED_results[5] = write & decoder_results1[5] ;
	assign ANDED_results[6] = write & decoder_results1[6] ;
	assign ANDED_results[7] = write & decoder_results1[7] ;
 
endmodule

// a - binary input 	(n bits wide)
// b - one hot output	(m bits wide)
module Decoder(a, b) ;
	parameter n = 3 ;
	parameter m = 8 ;

	input  [n-1:0] a ;
	output [m-1:0] b ;

	wire [m-1:0] b = 1<<a;
endmodule 