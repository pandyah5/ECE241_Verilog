`timescale 1ns / 1ps
`default_nettype none

// DE1_SoC board needs the below main module

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

	d_flipflop_enable u1 (SW[0], SW[9], SW[8], SW[1], LEDR[0]);

endmodule

// D Flip Flop with enable

module d_flipflop_enable(d, clock, enable, resetn, q);
    input d, clock, resetn, enable;
    output reg q;

    always@(negedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else if (enable == 1)
                q <= d;
        end
endmodule
