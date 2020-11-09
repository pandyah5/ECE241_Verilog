
module one_bit_register(d, enable, clock, resetn, q); // Active low reset and Synchronous
    input d, enable, clock, resetn;
    output reg q;
    always@(posedge clock)
        begin
            if (resetn == 0)
                q <= 0;
            else if (enable == 1)
                q <= d;
        end
endmodule

module eight_bit_register(d, enable, clock, resetp, q); // Active high reset and Asynchronous
    input enable, clock, resetp;
    input[7:0] d;
    output reg[7:0] q;
    always@(posedge clock, posedge resetp)
        begin
            if (resetp == 1)
                q <= 8'b00000000;
            else if (enable == 1)
                q <= d;
        end
endmodule
