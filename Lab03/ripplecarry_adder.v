module fulladder(a, b, cin, cout, s);
	input a;
	input b;
	input cin;
	output cout;
	output s;
	
	assign s = cin ^ (a ^ b);
	assign cout = ((a ^ b) & cin) | (~(a ^ b) & b);
endmodule


module ripplecarry(SW, LEDR);
	input [8:0] SW;
	output [9:0] LEDR;
	
	wire w0, w1, w2;
	
	fulladder fa0(
		.a(SW[4]),
		.b(SW[0]),
		.cin(0),
		.cout(w0),
		.s(LEDR[0])
	);
	
	fulladder fa1(
		.a(SW[5]),
		.b(SW[1]),
		.cin(w0),
		.cout(w1),
		.s(LEDR[1])
	);
	
	fulladder fa2(
		.a(SW[6]),
		.b(SW[2]),
		.cin(w1),
		.cout(w2),
		.s(LEDR[2])
	);
	
	fulladder fa3(
		.a(SW[7]),
		.b(SW[3]),
		.cin(w2),
		.cout(LEDR[9]),
		.s(LEDR[3])
	);
endmodule