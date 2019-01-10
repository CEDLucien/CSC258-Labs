module sevensegment(HEX, SW);
    input [3:0] SW;
    output [6:0] HEX;
	 
	 segments u0(
			.a(SW[0]),
			.b(SW[1]),
			.c(SW[2]),
			.d(SW[3]),	
			.A(HEX[0]),
			.B(HEX[1]),
			.C(HEX[2]),
			.D(HEX[3]),
			.E(HEX[4]),
			.F(HEX[5]),
			.G(HEX[6])
			);
			
endmodule

module segments(A, B, C, D, E, F, G, a, b, c, d);
	input a, b, c, d;
	output A, B, C, D, E, F, G;
	
	assign A = ~((~a & c) |( ~a & b & d) | (a & ~c & ~d )|( a & ~b & ~c )|( ~b & ~d) |( b & c) );
	
	assign B = ~((~(a | b) | ~(a | c | d) | (~a & c & d) | ~(b | d) | (a & ~b & c)));
	
	assign C = ~((a & ~b) | (~a & b) | (~c & d) | ~(a | c) | (~a & d));
	
	assign D = ~((a & ~c) | (~b & c & d) | ~(a|b|d) | (b & c & ~d));
	
	assign E = ~(~(a|d) | (a & c) | (a & b) | (c & ~d));
	
	assign F = ~(~(c | d) | (a & ~b) | (~a & b & ~c) | (b & c & ~d) | (a & c));
	
	assign G = ~((~a	 & ~b & c) | (~a & b & ~c) | (~b & c & ~d) | (a & ~b & ~c) | (a & d));

	
endmodule
	