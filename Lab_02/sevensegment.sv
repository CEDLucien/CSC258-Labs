module sevensegment(HEX, SW);
    input [3:0] SW;
    output [6:0] HEX;

   segmentA u0(
        .a(SW[0]),
        .b(SW[1]),
        .c(SW[2]),
		  .d(SW[3]),	
        .A(HEX[0])
        );
	segmentB u1(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.B(HEX[1])
		);
	segmentC u2(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.C(HEX[2])
		);
	segmentD u3(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.D(HEX[3])
		);
   segmentE u4(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.E(HEX[4])
		);
	segmentF u5(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.F(HEX[5])
		);
	segmentG u6(
		.a(SW[0]),
		.b(SW[1]),
		.c(SW[2]),
		.d(SW[3]),
		.G(HEX[6])
		);
endmodule

module segmentA(A, a, b, c, d);
	input a;
	input b; 
	input c; 
	input d;
	output A;

	
	assign A = ~((~a & c) |( ~a & b & d) | (a & ~c & ~d )|( a & ~b & ~c )|( ~b & ~d) |( b & c) );

endmodule
	
module segmentB(B, a, b, c, d);
	
	input a;
	input b; 
	input c; 
	input d;
	output B;
	
	assign B = ~((~(a | b) | ~(a | c | d) | (~a & c & d) | ~(b | d) | (a & ~b & c)));
	

endmodule	
	
module segmentC(C, a, b, c, d);
	
	input a;
	input b; 
	input c; 
	input d;
	output C;

	assign C = ~((a & ~b) | (~a & b) | (~c & d) | ~(a | c) | (~a & d));
endmodule
	
module segmentD(D, a, b, c, d);
	
	input a;
	input b; 
	input c; 
	input d;
	output D;
	
	assign D = ~((a & ~c) | (~b & c & d) | ~(a|b|d) | (b & c & ~d));
	
endmodule

	
module segmentE(E, a, b, c, d);
	
	input a;
	input b; 
	input c; 
	input d;
	output E;
	
	assign E = ~(~(a|d) | (a & c) | (a & b) | (c & ~d));
	
endmodule
	
	

module segmentF(F, a, b, c, d);
	
	input a;
	input b; 
	input c; 
	input d;
	output F;
	
	assign F = ~(~(c | d) | (a & ~b) | (~a & b & ~c) | (b & c & ~d) | (a & c));
	
endmodule
	
	
	
module segmentG(G, a, b, c, d);
	
	input a;
	input b; 
	input c; 
	input d;
	output G;
	
	assign G = ~((~a & ~b & c) | (~a & b & ~c) | (~b & c & ~d) | (a & ~b & ~c) | (a & d));
	
endmodule
	
	
	