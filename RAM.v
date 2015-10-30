module RAM(clk, readAddress, writeAddress, write, data_in, data_out);
	parameter dataWidth = 16;
	parameter addressWidth = 8;
	parameter file = "data.txt";

	input clk, write;
	input [addressWidth-1:0] writeAddress, readAddress;
	input [dataWidth-1:0] data_in;
	output [dataWidth-1:0] data_out;

	reg [dataWidth-1:0] data_out;
	reg [dataWidth-1:0] mem [2**addressWidth-1:0];

	initial $readmemb(file, mem);

	always @(posedge clk) begin
		if(write)
			mem[writeAddress] <= data_in;
		data_out <= mem[readAddress];
	end

endmodule
