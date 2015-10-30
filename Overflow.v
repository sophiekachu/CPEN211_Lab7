module Overflow(a, b, sub, ovf) ;
	parameter n = 8 ;
	input [n-1:0] a, b ;
	input sub ;           // subtract if sub=1, otherwise add
//	output [n-1:0] s ; change this to a wire because we dont care about the output number
	wire [n-1:0] s ;
	output ovf ;          // 1 if overflow
	wire c1, c2 ;         // carry out of last two bits
	wire ovf = c1 ^ c2 ;  // overflow if signs don't match

  // add non sign bits
	Adder1 #(n-1) ai(a[n-2:0],b[n-2:0]^{n-1{sub}},sub,c1,s[n-2:0]) ;
  // add sign bits
	Adder1 #(1)   as(a[n-1],b[n-1]^sub,c1,c2,s[n-1]) ;
endmodule

module Adder1(a,b,cin,cout,s) ;
	parameter n = 8 ;
	input [n-1:0] a, b ;
	input cin ;
	output [n-1:0] s ;
	output cout ;
	wire [n-1:0] s;
	wire cout ;

	assign {cout, s} = a + b + cin ;
endmodule 

