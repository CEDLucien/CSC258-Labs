module counter (SW, KEY, HEX0, HEX1);

  input[1:0] KEY;
  input[1:0] SW;
  output[6:0] HEX0;
  output[6:0] HEX1;
  wire[7:0] Q;

  counters u0(
    .enable(SW[1]),
    .clk(KEY[0]),
    .clear_b(SW[0]),
    .q(Q[7:0])

  );

  sevensegment S1 (
    .SW(Q[3:0]),
    .HEX(HEX0)
  );

  sevensegment S2 (
    .SW(Q[7:4]),
    .HEX(HEX1)
  );

endmodule




module counters (enable, clk, clear_b, q);

  input enable, clk, clear_b;
  output wire[7:0] q;

  tff_async T0 (
    .t(enable),
    .clk(clk),
    .reset(clear_b),
    .q(q[0])
  );

  tff_async T1 (
    .t(enable && (& q[0])),
    .clk(clk),
    .reset(clear_b),
    .q(q[1])
  );

  tff_async T2 (
    .t(enable && (& q[1:0])),
    .clk(clk),
    .reset(clear_b),
    .q(q[2])
  );

  tff_async T3 (
    .t(enable && (& q[2:0])),
    .clk(clk),
    .reset(clear_b),
    .q(q[3])
  );

  tff_async T4 (
    .t(enable && (& q[3:0])),
    .clk(clk),
    .reset(clear_b),
    .q(q[4])
  );

  tff_async T5 (
    .t(enable && (& q[4:0])),
    .clk(clk),
    .reset(clear_b),
    .q(q[5])
  );

  tff_async T6 (
    .t(enable && (& q[5:0])),
    .clk(clk),
    .reset(clear_b),
    .q(q[6])
  );

  tff_async T7 (
    .t(enable && (& q[6:0])),
    .clk(clk),
    .reset(clear_b),
    .q(q[7])
  );

endmodule



module tff_async (t, clk, reset, q);

input t, clk, reset;
output reg q;

always @(posedge clk, negedge reset)
begin
  if(~reset)
    q <= 1'b0;
 else
    q <= q ^ t;
end

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