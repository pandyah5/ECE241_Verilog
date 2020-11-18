`timescale 1ns / 1ps
`default_nettype none

// DE1_SoC board needs the below main module

endmodule //
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
	top v1(SW, LEDR);

endmodule

// Top Module

module top(SW, LEDR);
	input [9:0] SW;
	output [9:0] LEDR;

	_7to1_mux u1 (SW[6:0], SW[9:7], LEDR[0]);

endmodule

// Mux module

module _7to1_mux(inp, signal, out);
    input[6:0] inp;
    input[2:0] signal;

    output reg out;
    always@(*)
        case(signal)
            3'b000 : out = inp[0];
            3'b001 : out = inp[1];
            3'b010 : out = inp[2];
            3'b011 : out = inp[3];
            3'b100 : out = inp[4];
            3'b101 : out = inp[5];
            3'b110 : out = inp[6];
            default : out = 1'b0;
        endcase
endmodule
