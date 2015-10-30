//FSM Controller
module Controller(clk, rst, opcode, op, nsel, loadPC, loadIR, mwrite, msel, CombIns); 
	parameter k = 3;

	input clk, rst;
	output loadPC, loadIR;
	output [2:0] nsel; 
	output [10:0] CombIns; //vsel[10:7], asel[6], bsel[5], write[4], loada[3], loadb[2], loadc[1], loads[0]

	wire [2:0] opcode;
	wire [1:0] op, ALU;
	wire [2:0] present_state;
	reg [2:0] nsel, next_state;
	
	assign loadPC = rst ? {k{1'b0}} : loadIR;

	always @(posedge clk) begin 
		case({opcode, op})
			{}: nsel = 3'b001;
			{3'b101, 2'b00}: nsel = 3'b010;
			{3'b110, 2'b10}: nsel = 3'b100;
			{3'b110, 2'b00}: nsel = 3'b010;
			default: nsel = {k{1'bx}}
		endcase
	end

endmodule
