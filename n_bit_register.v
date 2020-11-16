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

	n_bit_register #2 u1 (SW[1:0], SW[9], SW[8], SW[7], LEDR[1:0]);
	// You can try out the others too by changing the parameter above :)
    // Don't forget to change the size of inputs if you change the parameter 'n'

endmodule

// Register - n bit

module n_bit_register(d, clock, resetn, enable, q);
    parameter n = 4; // Default value
    input [n-1:0] d;
    input clock, resetn, enable;
    output reg [n-1:0] q;

    always@(posedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else if (enable == 1)
                q <= d;
        end
endmodule
