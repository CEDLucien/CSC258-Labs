module mux2to1(x, y, s, m);
	input x; //selected when s is 0
   input y; //selected when s is 1
   input s; //select signal
   output m; //output
	
	assign m = (s & y) | (~s & x);
endmodule

module mux4to1(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;
	
	wire connector0; // connects mux0 to mux2
	wire connector1; // connects mux1 to mux2
	
	mux2to1 mux0(
		.x(SW[0]), // u
		.y(SW[1]), // v
		.s(SW[9]), // s0
		.m(connector0)
	);
	
	mux2to1 mux1(
		.x(SW[2]), // w
		.y(SW[3]), // x
		.s(SW[9]), // s0
		.m(connector1)
	);
	
	mux2to1 mux2(
		.x(connector0), // connected to output of mux0
		.y(connector1), // connected to output of mux1
		.s(SW[8]), // s1	
		.m(LEDR[0])
	);
endmodule