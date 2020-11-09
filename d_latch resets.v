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
