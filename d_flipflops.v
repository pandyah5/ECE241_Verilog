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
	top v1(SW, LEDR);

endmodule

// Top module

module top (SW, LEDR); // NOTE: Uncomment the module you wanna use :)
	input[9:0] SW;
	output[9:0] LEDR;

	// Sync modules
	pos_edge_sync_active_high u1 (SW[0], SW[9], SW[1], LEDR[0]);
//	pos_edge_sync_active_low u1 (SW[0], SW[9], SW[1], LEDR[0]);
//	neg_edge_sync_active_high u1 (SW[0], SW[9], SW[1], LEDR[0]);
//	neg_edge_sync_active_low u1 (SW[0], SW[9], SW[1], LEDR[0]);

	// Async modules
//	pos_edge_async_active_high u1 (SW[0], SW[9], SW[1], LEDR[0]);
//	pos_edge_async_active_low u1 (SW[0], SW[9], SW[1], LEDR[0]);
//	neg_edge_async_active_high u1 (SW[0], SW[9], SW[1], LEDR[0]);
//	neg_edge_async_active_low u1 (SW[0], SW[9], SW[1], LEDR[0]);

endmodule


// Sync modules

module pos_edge_sync_active_high(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(posedge clock) // edge triggered devices
        begin
            if (reset == 1)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule

module pos_edge_sync_active_low(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(posedge clock) // edge triggered devices
        begin
            if (reset == 0)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule

module neg_edge_sync_active_high(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(negedge clock) // edge triggered devices
        begin
            if (reset == 1)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule

module neg_edge_sync_active_low(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(negedge clock) // edge triggered devices
        begin
            if (reset == 0)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule

// Async modules

module pos_edge_async_active_high(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(posedge clock, posedge reset) // edge triggered devices
        begin
            if (reset == 1)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule

module pos_edge_async_active_low(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(posedge clock, negedge reset) // edge triggered devices
        begin
            if (reset == 0)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule

module neg_edge_async_active_high(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(negedge clock, posedge reset) // edge triggered devices
        begin
            if (reset == 1)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule

module neg_edge_async_active_low(d, clock, reset, q);
    input d, clock, reset;
    output reg q;
    always@(negedge clock, negedge reset) // edge triggered devices
        begin
            if (reset == 0)
                q <= 0; // Non-blocking statements
            else
                q <= d;
        end
endmodule
