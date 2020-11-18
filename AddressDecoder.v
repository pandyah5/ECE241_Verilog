// Truth Table

// A | B | C || S | T | U | V | W | X | Y | Z
// 0   0   0 || 1   0   0   0   0   0   0   0
// 0   0   1 || 0   1   0   0   0   0   0   0
// 0   1   0 || 0   0   1   0   0   0   0   0
// 0   1   1 || 0   0   0   1   0   0   0   0
// 1   0   0 || 0   0   0   0   1   0   0   0
// 1   0   1 || 0   0   0   0   0   1   0   0
// 1   1   0 || 0   0   0   0   0   0   1   0
// 1   1   1 || 0   0   0   0   0   0   0   1

// This is an address decoder for a memory matrix with eight (2^3) rows
// The outputs are in One-Hot encoded format as that's how a address decoder works

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

module top(SW, LEDR);
    input [9:0] SW;
    output [9:0] LEDR;

    address_decoder v1 (SW[2:0], LEDR[7:0]);

endmodule

module address_decoder (inp, row);
    input [2:0] inp;
    output reg [7:0] row;

    always@(*)
        begin
            row = 8'b00000000;
            case (inp)
                3'b000 : row[0] = 1;
                3'b001 : row[1] = 1;
                3'b010 : row[2] = 1;
                3'b011 : row[3] = 1;
                3'b100 : row[4] = 1;
                3'b101 : row[5] = 1;
                3'b110 : row[6] = 1;
                3'b111 : row[7] = 1;
                default row = 8'b0;
            endcase
        end
endmodule
