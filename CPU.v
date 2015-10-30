module CPU(reset, clk) ;
	input reset, clk ;
	wire[15:0] mdata, sximm5, sximm8, IRout ;
	wire[10:0] CombIns ;
	wire[1:0] ALUop, shift, op ;
	wire[2:0] status ;
	wire[2:0] readnum, writenum, opcode, nsel ;
	wire mwrite, msel, loadpc, loadIR ;
 
	//Controller instantiate
	Controller FSM( .reset(reset), .opcode(opcode), .op(op), .nsel(nsel), .loadIR(loadIR), .loadpc(loadpc), .msel(msel), .mwrite(mwrite), .CombIns(CombIns) ) ;
	//Datapath lab5 and PC + RAM
	Datapath combPCRAMData(.mdata(mdata), .sximm5(sximm5), .sximm8(sximm8), .mwrite(mwrite), .loadpc(loadpc), .rst(reset), .writenum(writenum), .write(CombIns[4]), .readnum(readnum), .clk(clk), .datapath_out(Cin), .vsel(CombIns[10:7]), .asel(CombIns[6]), .bsel(CombIns[5]), .msel(msel), .shiftinput(shift), .loadIR(loadir), .loada(CombIns[3]), .loadb(CombIns[2]), .loadc(CombIns[1]), .loads(CombIns[0]), .ALUop(ALUop), .status(status) ) ;
	//Instruction Decoder
	Instruction_Decoder(.IRout(IRout), .nsel(nsel), .ALUop(ALUop), .sximm5(sximm5), .sximm8(sximm8), .shift(shift), .readnum(readnum), .writenum(writenum), .opcode(opcode), .op(op) );
	
endmodule 