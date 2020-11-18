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

	shift_reg_parallel_load u1 (SW[4], SW[3:0], SW[9], SW[8], SW[7], LEDR[3:0]);
//  shift_reg_parallel_load_1 u1 (SW[4], SW[3:0], SW[9], SW[8], SW[7], LEDR[3:0]);
//  You can try the above too - just uncomment the one you wanna try

endmodule

// Register - n bit

module shift_reg_parallel_load(w, d, clock, loadn, resetp, q); // Synchronous and Active High
    input w, clock, loadn, resetp;
    input[3:0] d;
    output reg [3:0] q;

    always@(posedge clock)
        begin
            if (resetp == 1)
                q <= 0;
            else if (loadn == 1)
                q <= d;
            else
                begin
                    q[0] <= w;
                    q[1] <= q[0];
                    q[2] <= q[1];
                    q[3] <= q[2];
                end
        end
endmodule

module shift_reg_parallel_load_1(w, d, clock, loadn, resetn, q); // Asynchronous and Active low
    input w, clock, loadn, resetn;
    input[3:0] d;
    output reg [3:0] q;

    always@(posedge clock, negedge resetn)
        begin
            if (resetn == 0)
                q <= 0;
            else if (loadn == 1)
                q <= d;
            else
                begin
                    q[0] <= w;
                    q[1] <= q[0];
                    q[2] <= q[1];
                    q[3] <= q[2];
                end
        end
endmodule
