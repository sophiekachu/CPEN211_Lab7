module PC(clk, loadPC, reset, msel, mwrite, Bin, Cin, loadIR, PC, mdata, IRout);
	
	input clk, reset, loadPC, msel, mwrite, loadIR;
	input [15:0] Bin, Cin;
	output [15:0] IRout, mdata;
	output [7:0] PC;

	wire [7:0] PC_out, PCmux_out, resetmux_out, RAM_input;
	wire [7:0] if_reset = 8'b0;
	wire [7:0] C_input = Cin[7:0];

	assign PC = PC_out + 1'b1; //add 1

	//Mux
	Mux2s1 #(8)PCmux(.a1(PC), .a0(PC_out), .s(loadPC), .b(PCmux_out));
	Mux2s1 #(8)resetmux(.a1(if_reset), .a0(PCmux_out), .s(reset), .b(resetmux_out));

	//Counter
	vDFF PCounter(.clk(clk), .in(resetmux_out), .out(PC_out));

	Mux2s1 #(8)mselmux(.a1(C_input), .a0(PC_out), .s(msel), .b(RAM_input));

	//instantiates RAM
	RAM ram(.clk(clk), .readAddress(RAM_input), .writeAddress(RAM_input), .write(mwrite), .data_in(Bin), .data_out(mdata));

	//IR
	vDFFE #(16)IR(.clk(clk), .load(loadIR), .in(mdata), .out(IRout));

endmodule
