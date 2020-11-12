`timescale 1ns / 1ps
`default_nettype none

module main	(
	input wire CLOCK_50,            //On Board 50 MHz
	input wire [9:0] SW,            // On board Switches
	input wire [3:0] KEY,           // On board push buttons
	output wire [6:0] HEX0,         // HEX displays
	output wire [6:0] HEX1,         
	output wire [6:0] HEX2,         
	output wire [6:0] HEX3,         
	output wire [6:0] HEX4,         
	output wire [6:0] HEX5,         
	output wire [9:0] LEDR,         // LEDs
	output wire [7:0] x,            // VGA pixel coordinates
	output wire [6:0] y,
	output wire [2:0] colour,       // VGA pixel colour (0-7)
	output wire plot,               // Pixel drawn when this is pulsed
	output wire vga_resetn      	// VGA resets to black when this is pulsed (NOT CURRENTLY AVAILABLE)
);   
	part2 i1(SW, LEDR);
	
endmodule

//Write code in here!
module part2(SW, LEDR);

	input [9:0] SW;
	output[9:0] LEDR;
	
	three_bit_adder u0 (SW[7:4], SW[3:0], SW[8], LEDR[3:0], LEDR[9]);
	
endmodule

module full_adder (a, b, c_p, s, c_n);
	input a, b, c_p;
	output s, c_n;
	
	assign s = a^b^c_p;
	assign c_n = (a&b)|(a&c_p)|(b&c_p);
	
endmodule

module three_bit_adder(A, B, cin, S, cout);
	input[3:0] A, B;
	input cin;
	output[3:0] S;
	output cout;
	
	wire d1, d2, d3;
	
	full_adder(A[0], B[0], cin, S[0], d1);
	full_adder(A[1], B[1], d1, S[1], d2);
	full_adder(A[2], B[2], d2, S[2], d3);
	full_adder(A[3], B[3], d3, S[3], cout);

endmodule

module Top(SW, LEDR);

	input[9:0] SW;
	output[9:0] LEDR;
	
	part1 u1(.Input(SW[6:0]), .MuxSelect(SW[9:7]), .Out(LEDR[0]));
	
endmodule

module part1 (Input, MuxSelect, Out);
	input[6:0] Input;
	input[2:0] MuxSelect;
	output reg Out;
	
	always@(*)
	begin
		case(MuxSelect[2:0])
			3'b000: Out = Input[0];
			3'b001: Out = Input[1];
			3'b010: Out = Input[2];
			3'b011: Out = Input[3];
			3'b100: Out = Input[4];
 			3'b101: Out = Input[5];
			3'b110: Out = Input[6];
			default: Out = 1'b0;
		endcase
	end

endmodule
			
	
	

