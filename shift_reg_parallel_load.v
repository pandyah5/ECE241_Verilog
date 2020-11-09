module shift_reg_parallel_load(w, d, clock, loadn, resetp, q); // Synchronous and Active High
    input w, clock, loadn, resetn;
    input[3:0] d;
    output[3:0] q;

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

module shift_reg_parallel_load(w, d, clock, loadn, resetn, q); // Asynchronous and Active low
    input w, clock, loadn, resetn;
    input[3:0] d;
    output[3:0] q;

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
