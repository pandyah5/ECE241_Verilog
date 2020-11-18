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
	full_adder(SW[0], SW[1], SW[2], LEDR[0], LEDR[1]);
	
endmodule 

	//Write code in here!
	
	module full_adder (a, b, c_p, s, c_n);
		input a, b, c_p;
		output s, c_n;
		
		assign s = a^b^c_p;
		assign c_n = (a&b)|(a&c_p)|(b&c_p);
		
	endmodule
	

