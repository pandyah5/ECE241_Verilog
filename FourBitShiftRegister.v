module four_bit_shift_register(w, clock, q);
    input w, clock;
    output reg[3:0] q;
    always@(posedge clock)
        begin
            q[0] <= w;    // Non-blocking statements make this type of assignment possible
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2];
        end
endmodule
