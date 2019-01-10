module alureg(LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input[7:0] SW;
	input[2:0] KEY;
	output[7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	wire[7:0] Case0, Case1, Case2, Case3, Case4, Case5;

	reg[7:0] AluOut;

	concat u0 (
		.A(SW[7:4]),
		.B(SW[3:0]),
		.Result(Case0[7:0])
	);

	ripplecarry u1 (
		.A(SW[7:4]),
		.B(SW[3:0]),
		.Sum(Case1[7:0])
	);

	verilogsum u2 (
		.A(SW[7:4]),
		.B(SW[3:0]),
		.Sum(Case2[7:0])
	);

	xoror u3 (
		.A(SW[7:4]),
		.B(SW[3:0]),
		.Result(Case3[7:0])
	);

	existsone u4 (
		.A(SW[7:4]),
		.B(SW[3:0]),
		.Result(Case4[7:0])
	);
	
	evenhigh u5 (
		.A(SW[7:0]),
		.Result(Case5[7:0])
	);
	
	always @(*)
	begin
		case(KEY[2:0])
			3'b000: AluOut = Case0; // case 0
			3'b001: AluOut = Case1; // case 1
			3'b010: AluOut = Case2; // case 2
			3'b011: AluOut = Case3; // case 3
			3'b100: AluOut = Case4; // case 4
			3'b101: AluOut = Case5; //case 5
			default: AluOut = 8'b00000000; //default case		
		endcase
	end

	assign LEDR = AluOut;

	sevensegment hex0 (
		.SW(SW[3:0]),
		.HEX(HEX0[6:0])
	);

	sevensegment hex2 (
		.SW(SW[7:4]),
		.HEX(HEX2[6:0])
	);

	sevensegment hex4 (
		.SW(AluOut[3:0]),
		.HEX(HEX4[6:0])
	);

	sevensegment hex5 (
		.SW(AluOut[7:4]),
		.HEX(HEX5[6:0])
	);

	assign HEX1[6:0] = 7'b0000000;
	assign HEX3[6:0] = 7'b0000000;

endmodule

//case 0
module concat(A, B, Result);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Result;
	
	assign Result[7:0] = {A, B};

endmodule

//case 1
module ripplecarry(A, B, Sum);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Sum;
	wire final;
	
	wire w1;
	wire w2;
	wire w3;
	
	full_adder u0 (
		.cin(1'b0)
		.sum(Sum[0]),
		.cout(w1),
		.a(A[0]),
		.b(B[0]),
	);

	full_adder u1 (
		.cin(w1)
		.sum(Sum[1]),
		.cout(w2),
		.a(A[1]),
		.b(B[1]),
	);

	full_adder u2 (
		.cin(w2)
		.sum(Sum[2]),
		.cout(w3),
		.a(A[2]),
		.b(B[2]),
	);

	full_adder u3 (
		.cin(w3)
		.sum(Sum[3]),
		.cout(final),
		.a(A[3]),
		.b(B[3]),
	);

	assign Sum[7:4] = 4'b0000;
	
endmodule


module full_adder(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a^b^cin;
	assign cout = (a&b)|(cin&(a^b));
endmodule


//case 2
module verilogsum(A, B, Sum);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Sum;
	
	assign Sum[3:0] = A + B;
	assign Sum[7:4] = 4'b0000;
endmodule

//case 3
module xoror(A, B, Result);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Result;

	assign Result[3:0] = A^B;
	assign Result[7:4] = A|B;
endmodule


//case 4
module existsone(A, B, Result);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Result;
	
	assign Result[0] = | {A, B};
	assign Result[7:1] = 7'b0000000;

endmodule

//case 5
module evenhigh(A, Result, ones);
	input[7:0] A;
	output[7:0] Result; 
	output reg[7:0] ones;
	 
	assign Result[7:1] = 7'b0000000;

	integer i;

	always@(*) //counts number of 1s in A and B
	begin
		ones = 0;  
		for(i=0;i<8;i=i+1)  
			ones = ones + A[i]; 	
	end
	
	assign Result[0] = ~(ones % 2);


endmodule




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
