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
	top u1(SW, LEDR);

endmodule

// Top level module

module top(SW, LEDR);
    input [9:0] SW;
    output [9:0] LEDR;

    seq110_detector v1 (SW[9], SW[8], SW[0], LEDR[0]);

endmodule

module seq110_detector(clock, resetp, w, z); // Finite state machine for detecting 110 sequence
    parameter [1:0] a = 2'b00, b = 2'b01, c = 2'b10, d = 2'b11;
    input clock, resetp, w;
    reg [1:0] y, Y;
    output z;

    // Initial combinational block
    always@(posedge clock)
    case (y)
        a: if (!w) Y = a;
           else Y = b;
        b: if (!w) Y = a;
           else Y = c;
        c: if (!w) Y = d;
           else Y = c;
        d: if (!w) Y = a;
           else Y = b;
        default: Y = a; // Default is reset state
    endcase

    // State Flip Flop implementing active high reset
    always@(posedge clock)
    begin
        if (resetp == 1)
            y <= a;
        else
            y <= Y;
    end

    // Output combinational logic block
    assign z = (y == d);

endmodule
