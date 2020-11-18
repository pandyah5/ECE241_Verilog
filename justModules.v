// 7 to 1 mux

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

// D-Latch

module d_latch(d, clock, q);
    input d, clock;
    output reg q;

    always@(*)
        if (clock == 1)
            q <= d;
endmodule

// DFF - posedge

module d_flipflop(d, clock, q, resetn);
    input d, clock, resetn;
    output reg q;

    always@(posedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else
                q <= d;
        end
endmodule

// DFF - negedge

module d_flipflop(d, clock, resetn, q);
    input d, clock, resetn;
    output reg q;

    always@(negedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else
                q <= d;
        end
endmodule

// Register - 4 bit

module register_4_bit (d, clock, resetn, q);
    // Posedge clock - Synchronous - Active low
    input[3:0] d;
    input clock, resetn;
    output reg [3:0] q;

    always@(posedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else
                q <= d;
        end
endmodule

// Register - n bit

module n_bit_register(d, clock, resetn, enable, q);
    parameter n = 4; // Default value
    input [n-1:0] d;
    input clock, resetn, enable;
    output reg [n-1:0] q;

    always(posedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else if (enable == 1)
                q <= d;
        end
endmodule

// Shift Register

module shift_register_3_bit (w, clock, resetn, load, pl, q);
    input clock, w, load, resetn;
    input[2:0] pl;
    output reg [2:0] q;

    always@(posedge clock)
    begin
        if (!resetn)
            q <= 0;
        else if (load == 0)
            q <= pl;
        else
            begin
                q[0] <= w;           // Very important - USE NON-BLOCKING STATEMENTS
                q[1] <= q[0];        // Very important - USE NON-BLOCKING STATEMENTS
                q[2] <= q[1];        // Very important - USE NON-BLOCKING STATEMENTS
            end
    end
endmodule

// T - flipflop

module t_flipflop(t, resetn, clock, q);
    input clock, t, resetn;
    output reg q;

    always@(posedge clock)
        begin
            if (!resetn)
                q <= 0;
            else if (t == 1)
                q <= ~q;
        end
endmodule

// Counter - 4 bit

module counter_4_bit (clock, enable, resetp, q);
    input clock, enable, resetp;
    output reg [3:0] q;

    always@(posedge clock)
        begin
            if (resetp == 0)
                q <= 0;
            else if (enable == 1)
                q <= q + 1;
        end
endmodule

// Updown counter - Parameterized

module param_counter(clock, enable ,updown, resetn, q);
    parameter n = 3;
    input clock, enable, updown, resetn;
    output reg [n-1:0] q;

    always@(posedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else if (enable == 1)
                q <= q + (updown?1:-1);
        end
endmodule

// Async counter

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
