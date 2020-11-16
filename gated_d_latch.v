module d_latch(d, clock, q);
    input d, clock;
    output reg q;
    always@(*)
        begin
            if (clock == 1)
                q <= d;
        end
endmodule
