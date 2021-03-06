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

	register_4_bit u1 (SW[3:0], SW[9], SW[8], SW[7], LEDR[3:0]);
	// You can try out the others too by changing the line above :)

endmodule

// Registers

module register_1_bit(d, enable, clock, resetn, q); // Active low reset and Synchronous
    input d, enable, clock, resetn;
    output reg q;
    always@(posedge clock)
        begin
            if (!resetn)
                q <= 0;
            else if (enable == 1)
                q <= d;
        end
endmodule

module register_4_bit (d, clock, resetn, enable, q); // Synchronous - Active low
    input[3:0] d;
    input clock, enable, resetn;
    output reg [3:0] q;

    always@(posedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else if (enable == 1)
                q <= d;
        end
endmodule

module register_8_bit(d, enable, clock, resetp, q); // Active high reset and Asynchronous
    input enable, clock, resetp;
    input[7:0] d;
    output reg[7:0] q;
    always@(posedge clock, posedge resetp)
        begin
            if (resetp == 1)
                q <= 8'b00000000; // Binary 8 bit
            else if (enable)
                q <= d;
        end
endmodule
