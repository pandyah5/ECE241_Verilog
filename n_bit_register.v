module parameter_register(d, clock, resetn, q, load, pl, enable);
    Parameter n = 8; // Parameterization
    input load, clock, resetn, enable;
    input [n:1] d, pl;
    output [n:1] q;

    always@(posedge clock, negedge resetn) // Edge sensitive and asynchronous
        begin
            if (resetn == 0)
                q <= 0;            // Non - blocking statements
            else if (load == 1)
                q <= pl;
            else if (enable == 1)
                q <= d;
        end
endmodule
