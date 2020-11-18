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
	async_counter_top u1(SW[8], SW[9], SW[7], LEDR[2:0]);

endmodule

module async_counter_top(enable, clock, resetp, q);
	 input enable, clock, resetp;
	 output [2:0] q;
    wire [2:0] c ;

    t_flipflop v1 (enable, resetp, clock, c[0]);
    t_flipflop v2 (enable, resetp, ~c[0], c[1]);
    t_flipflop v3 (enable, resetp, ~c[1], c[2]);

    assign q = c;
endmodule

module t_flipflop(t, resetp, clock, q);
    input clock, t, resetp;
    output reg q;

    always@(posedge clock, posedge resetp)
        begin
            if (resetp)
                q <= 0;
            else if (t == 1)
                q <= ~q;
        end

endmodule
