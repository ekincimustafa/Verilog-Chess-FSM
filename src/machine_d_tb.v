`timescale 1ns / 1ps

module machine_d_tb;

    reg x;
    reg CLK;
    reg RESET;
    wire F;
    wire [2:0] S;

    machine_d UUT (
        .x(x), 
        .CLK(CLK), 
        .RESET(RESET), 
        .F(F), 
        .S(S)
    );

    
    initial begin
        $dumpfile("machine_d_tb.vcd");
        $dumpvars(0, machine_d_tb);
    end

    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        x = 0;
        RESET = 1; 
        #100; 
        RESET = 0; 

        x = 0; #20; // 120ns
        x = 0; #20; // 140ns
        x = 0; #20; // 160ns

        x = 1; #20; // 180ns
        x = 1; #20; // 200ns

        x = 0; #20; // 220ns
        x = 0; #20; // 240ns
        x = 0; #20; // 260ns

        x = 1; #20; // 280ns 
        x = 0; #20; // 300ns 

        x = 0; #20; // 320ns
        x = 1; #10;
        x = 1; #20; // 340ns

        x = 1; #20; // 360ns
        x = 1; #10; // 380ns

        x = 0; #20; // 400ns
        x = 0; #20; // 420ns
        #80
        #20;
        $finish;
    end

endmodule