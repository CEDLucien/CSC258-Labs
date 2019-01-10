	module aluregister(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW; // SW[3:0] = A; SW[9] = reset_n; SW[7:5] = function_input
	input [0:0] KEY; // KEY[0] = clk
	output [7:0] LEDR; // LEDR = ALUout; B = LEDR[3:0] = ALUout[3:0]
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; // HEX0 = A; HEX[1:3] = 0; {HEX4, HEX5} = ALUout[7:0]
	
	reg [7:0] ALUout;
	wire w1, w2;
	wire [9:0] w3;
	wire [7:0] wout;
	
	registor r0(
		.d(ALUout[7:0]),
		.clk(KEY[0]),
		.reset_n(SW[9]),
		.q(wout[7:0])
	);
	
	function5 a(
		.a(SW[3:0]),
		.c(w1)
	);
	
	function5 b(
		.a(wout[3:0]),
		.c(w2)
	);
	
	ripplecarry r(
		.SW({SW[3:0], wout[3:0]}),
		.LEDR(w3)
	);
	
	always @(*)
	begin
		case(SW[7:5])
			3'b000: ALUout = {SW[3:0], wout[3:0]};
			3'b001: ALUout = {3'b000, w3[9], w3[3:0]};
			3'b010: ALUout = SW[3:0] + wout[3:0];
			3'b011: ALUout = {SW[3:0] | wout[3:0], SW[3:0] ^ wout[3:0]};
			3'b100: ALUout = {7'b0000000, SW[3] | SW[2] | SW[1] | SW[0] | wout[3] | wout[2] | wout[1] | wout[0]};
			3'b101: ALUout = wout[3:0] << SW[3:0];
			3'b110: ALUout = wout[3:0] >> SW[3:0];
			3'b111: ALUout = SW[3:0] * wout[3:0];
			default: ALUout = 8'b00000000;
		endcase
	end
	
	assign LEDR[7:0] = wout[7:0];
	
	sevensegment hex0(
		.SW(SW[3:0]),
		.HEX(HEX0[6:0])
	);
	sevensegment hex1(
		.SW(4'b0000),
		.HEX(HEX1[6:0])
	);
	sevensegment hex2(
		.SW(4'b0000),
		.HEX(HEX2[6:0])
	);
	sevensegment hex3(
		.SW(4'b0000),
		.HEX(HEX3[6:0])
	);
	sevensegment hex4(
		.SW(LEDR[7:4]),
		.HEX(HEX4[6:0])
	);
	sevensegment hex5(
		.SW(LEDR[3:0]),
		.HEX(HEX5[6:0])
	);
endmodule