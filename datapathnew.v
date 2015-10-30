module datapath(clk, loadPC, reset, msel, mwrite, mdata, PC, loadIR, IRout, sximm5, sximm8, writenum, write, readnum, datapath_out, vsel, asel, bsel, shiftinput, loada, loadb, loadc, loads, ALUop, status) ;

	input [15:0] sximm5, sximm8 ;
	input [2:0] writenum, readnum ;
	input clk, reset, write, mwrite, asel, bsel, msel, loada, loadb, loadc, loads, loadPC, loadIR;	//some inputs to register, vsel/asel/bsel are selects for Mux
	input [3:0] vsel ;
	input [1:0] ALUop, shiftinput ;
	output[15:0] datapath_out ;
	output[2:0] status ;
	output[15:0] IRout, mdata;					// connected to instruction decoder
	output [7:0] PC;

	wire [15:0] AtoMux, BtoShifter, ShiftertoMux ; 		//From vDFFE A to Mux, B to shifter, shifter to Mux
	wire [15:0] data_in, data_out;				//input and output from regfile
	wire [15:0] ALUtoC, Ain, Bin, Cin ;    			//Ain, Bin matches with Ain, Bin on the diagram.
	wire [2:0] ALUtostatus ;				
	wire [15:0] ainput, binput, mdata;
	//wire [15:0] PCvselin ;

	assign ainput = 16'b0 ;
	assign binput = sximm5 ;
	
	//assign PCvselin = {8'b0, PC_out} ;

	`define ABCvDFFE 16
	`define statusvDFFE 3
	`define Mux16b 16
	`define Mux8b 8

	//instantiations
	PC PCounter(.clk(clk), .loadPC(loadPC), .reset(reset), .PC(PC), .msel(msel), .mwrite(mwrite), .mdata(mdata), .Bin(Bin), .Cin(Cin), .loadIR(loadIR), .IRout(IRout));
	register regfile(data_in, writenum, write, readnum, clk, data_out);
	ALU ALUgate(.ALUop(ALUop), .Ain(Ain), .Bin(Bin), .result(ALUtoC), .status(ALUtostatus));
	shifter shiftgate(.Bin(BtoShifter), .shift(shiftinput), .Bout(ShiftertoMux));

	//Mux
	Mux2s1 #(`Mux16b)aselmux(.a1(ainput), .a0(AtoMux), .s(asel), .b(Ain)) ;
	Mux2s1 #(`Mux16b)bselmux(.a1(binput), .a0(ShiftertoMux), .s(bsel), .b(Bin)) ;
	//Mux4s4 #(`Mux16b)vselmux(.a3(mdata), .a2(sximm8), .a1(PCvselin), .a0(Cin), .s(vsel), .b(data_in)) ;


	//vDFFE for ABC, status, and PC
	vDFFE #(`ABCvDFFE)A(.clk(clk), .load(loada), .in(data_out), .out(AtoMux));
	vDFFE #(`ABCvDFFE)B(.clk(clk), .load(loadb), .in(data_out), .out(BtoShifter));
	vDFFE #(`ABCvDFFE)C(.clk(clk), .load(loadc), .in(ALUtoC), .out(datapath_out));
	vDFFE #(`statusvDFFE)stat(.clk(clk), .load(loads), .in(ALUtostatus), .out(status));
	

	assign Cin = datapath_out ;


endmodule 