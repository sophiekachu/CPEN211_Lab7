//Instruction Decoder
module Instruction_Decoder(IRout, nsel, ALUop, sximm5, sximm8, shift, readnum, writenum, opcode, op);

	input [15:0] IRout;
	input [2:0] nsel; 
	output [15:0] sximm5, sximm8;
	output [1:0] shift, op, ALUop;
	output [2:0] readnum, writenum, opcode;

	wire [2:0] Rd, Rn, Rm, mux_out ;
	wire [4:0] imm5;
	wire [7:0] imm8;
	wire [2:0] opcode;
	wire [1:0] op;
	reg [15:0] sximm8;
	reg [15:0] sximm5;
	
	Mux3s3 nselmux(.a2(Rn), .a1(Rd), .a0(Rm), .s(nsel), .out(mux_out) ) ;

	assign readnum = mux_out;
	assign writenum = mux_out;

	assign opcode = IRout[15:13] ;
	assign op = IRout[12:11] ;
	assign ALUop = IRout[12:11] ;
	assign Rm = IRout[2:0] ;
	assign Rd = IRout[7:5] ;
	assign Rn = IRout[10:8] ;
	assign shift = IRout[4:3] ;
	assign imm8 = IRout[7:0] ;
	assign imm5 = IRout[4:0] ;

	wire MSB8 = IRout[7] ;
	wire MSB5 = IRout[4] ;

	//checks whether value is positive or negative
	always @(*) begin
		if(MSB8 == 1'b0)
			sximm8 = {8'b0, IRout[7:0]} ;  
		else
			sximm8 = {8'b1, IRout[7:0]} ;
	end

	always @(*) begin
		if( MSB5 == 1'b0 )
			sximm5 = {11'b0, IRout[4:0] } ;
		else
			sximm5 = {11'b1, IRout[4:0] } ;
	end
endmodule 