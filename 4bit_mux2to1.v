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
	fourBit_mux2to1 u0(.X(SW[3:0]), .Y(SW[7:4]), .Z(LEDR[3:0]), .S(SW[9]));

endmodule

	//Write code in here!

	module mux2to1(a, b, Y, S);
		// Declaring inputs and outputs
		input a, b;
		input S;
		output Y;

		// assign Y = S?b:a;
		assign Y = (~S & a)|(S & b);

	endmodule

	module fourBit_mux2to1 (X, Y, S, Z);
		input[3:0] X, Y;
		input S;
		output[3:0] Z;

		mux2to1 u1(.a(X[0]), .b(Y[0]), .Y(Z[0]), .S(S));
		mux2to1 u2(.a(X[1]), .b(Y[1]), .Y(Z[1]), .S(S));
		mux2to1 u3(.a(X[2]), .b(Y[2]), .Y(Z[2]), .S(S));
		mux2to1 u4(.a(X[3]), .b(Y[3]), .Y(Z[3]), .S(S));

	endmodule
