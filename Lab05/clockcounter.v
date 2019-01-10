module clockcounter (CLOCK_50, SW, KEY, HEX0);

    input CLOCK_50;
    input [1:0] SW;
    input [1:0] KEY;
    input [6:0] HEX0;
    wire [31:0] ratedivider_out;
    wire [3:0] displaycounter_out;
    wire displaycounter_enable;
    reg [31:0] period;

    assign displaycounter_enable = (ratedivider_out == 0) ? 1 : 0;

    always @ (SW)
    begin
        case(SW[1:0])
            2'b00: period <= 1;
            2'b01: period <= 50000000;
            2'b10: period <= 100000000;
            2'b11: period <= 200000000;
            default: period <= 0;
        endcase
    end

    ratedivider u0 (
        .clock(CLOCK_50),
        .reset_n(KEY[0]),
        .period(period),
        .q(ratedivider_out)
    );

    displaycounter u1 (
        .clock(CLOCK_50),
        .reset_n(KEY[0]),
        .enable(displaycounter_enable),
        .q(displaycounter_out)
    );

    sevensegment u2 (
        .SW(displaycounter_out),
        .HEX(HEX0)
    );

endmodule


module ratedivider (clock, period, reset_n, q);

    input clock;
    input reset_n;
    input [31:0] period;
    output reg [31:0] q;

    always @(posedge clock)
    begin
        if (reset_n == 1'b0)
            q <= period - 1;
        else
            begin
                if (q == 0)
                    q <= period - 1;
                else
                    q <= q - 1'b1;
        end
    end

endmodule


module displaycounter (clock, reset_n, enable, q);

    input clock;
    input reset_n;
    input enable;
    output reg [3:0] q;

    always @(posedge clock)
    begin
        if (reset_n == 1'b0)
            q <= 0;
        else if (enable == 1'b1)
            begin
                if (q == 4'b1111)
                    q <= 0;
                else
                    q <= q + 1'b1;
            end
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
