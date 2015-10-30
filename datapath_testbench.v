module datapath_tb ;

	reg [15:0] sximm5, sximm8;
	reg [2:0] writenum, readnum;
	reg mwrite, write, clk, reset, msel, asel, bsel, loada, loadb, loadc, loads, loadIR, loadPC ;
	reg [3:0] vsel;
	reg [1:0] ALUop, shiftinput;
	
	wire [15:0] datapath_out, mdata;
	wire [7:0] PC;
	wire [2:0] status;
	wire [15:0] IRout;
	
	datapath dataDUT(clk, loadPC, reset, msel, mwrite, mdata, PC, loadIR, IRout, sximm5, sximm8, writenum, write, readnum, datapath_out, vsel, asel, bsel, shiftinput, loada, loadb, loadc, loads, ALUop, status);

	initial begin
		clk = 0 ; #10 ;
		forever begin
			clk = 1 ; #10 ;
			clk = 0 ; #10 ;
		end
	end

	initial begin 
		asel = 1'b0 ;   	// initialize useful inputs or constant inputs
		bsel = 1'b0 ;
		vsel = 1'b0 ;
		write = 1'b1 ;
		ALUop = 2'b00 ;
		loada = 1'b0 ;
		loadb = 1'b0 ;
		loadc = 1'b0 ;
		loadPC = 1'b0 ;
		loadIR = 1'b0 ;
		shiftinput = 2'b00 ;
		mwrite = 1'b0 ;
		reset = 1'b1 ;
		#15 ;
		reset = 1'b0 ;
		#20
		loadIR = 1'b1 ;
		#20
		loadIR = 1'b0 ;
		loadPC = 1'b1 ;
		#20
		loadPC = 1'b0 ;
		#20
		loadIR = 1'b1 ;
		#20
		loadIR = 1'b0 ;
		loadPC = 1'b1 ;
		#20
		loadPC = 1'b0 ;
		#20
		mwrite = 1'b1 ;
		#15
		mwrite = 1'b0 ;

		
		//LOADING B with the value 7
//		writenum = 3'b000 ;  //Writing number to R0
//		datapath_in = 7 ;    //Setting the number in R0 to be 7 in decimal
//		#30 ;
//		vsel = 1'b1 ;
//		#30 ;
//		vsel = 1'b0 ;
//		readnum = 3'b000 ; 
//		loadb = 1'b1 ;	     //loading number of R0 to vDFFE A
//		#30 ;
//		loadb = 1'b0 ;
//		#30 ;

		//LOADING A with the value 2
//		writenum = 3'b001 ;    //Writing number to R1
//		datapath_in = 2 ;
//		#30 ;
//		vsel = 1'b1 ;
//		#30 ;
//		vsel = 1'b0 ;
//		readnum = 3'b001 ;
//		loada = 1'b1 ;
//		#30 ;
//		loada = 1'b0 ;
//		#30 ;

		//SHIFTING B value of 7 with shifter to 14
//		shiftinput = 2'b01 ;
//		bsel = 1'b0 ;
//		asel = 1'b0 ;
//		#30 ;
//		ALUop = 2'b00 ;		//Adding opperation in ALU
//		#30 ;
//		loadc = 1'b1 ;
//		loads = 1'b1 ;
//		#30 ;

//		$display("the datapath_out = %d \n the expected datapath_out = %d, status = %d",datapath_out, 16, status) ;
//		#30 ;
//		loadc = 1'b0 ;
		$stop ;
	end
endmodule 