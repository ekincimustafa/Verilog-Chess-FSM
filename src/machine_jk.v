module machine_jk(
    input wire x,
    input wire CLK,
    input wire RESET,
    output wire F,
    output wire [2:0] S
);
    // Your code goes here.  DO NOT change anything that is already given! Otherwise, you will not be able to pass the tests!

    wire Q2, Q1, Q0;

    // J and K wires for each flip flop
    wire J2, K2, J1, K1, J0, K0;
    
    assign S = {Q2, Q1, Q0};

    jkff ff2 (
        .J(J2), 
        .K(K2), 
        .CLK(CLK), 
        .RESET(RESET), 
        .Q(Q2)
    );

    jkff ff1 (
        .J(J1), 
        .K(K1), 
        .CLK(CLK), 
        .RESET(RESET), 
        .Q(Q1)
    );

    jkff ff0 (
        .J(J0), 
        .K(K0), 
        .CLK(CLK), 
        .RESET(RESET), 
        .Q(Q0)
    );

    // Inverters
    wire not_x, not_Q2, not_Q1, not_Q0;
    not (not_x, x);
    not (not_Q2, Q2);
    not (not_Q1, Q1);
    not (not_Q0, Q0);

    // J2 = Q1'.Q0.x + Q1.Q0.x'
    // K2 = Q1 + Q0
    wire j2_1, j2_2;
    and (j2_1, not_Q1, Q0, x);
    and (j2_2, Q1, Q0, not_x);
    or  (J2, j2_1, j2_2);
    or  (K2, Q1, Q0);

    // J1 = Q2'.Q0'.x + Q2.Q0'.x'
    // K1 = Q2 + Q0'
    wire j1_1, j1_2;
    and (j1_1, not_Q2, not_Q0, x);
    and (j1_2, Q2, not_Q0, not_x);
    or  (J1, j1_1, j1_2);
    or  (K1, Q2, not_Q0);

    // J0 = Q2' + Q1'.x
    // K0 = 1
    wire j0_1;
    and (j0_1, not_Q1, x);
    or  (J0, not_Q2, j0_1);

    assign K0 = 1'b1; // Constant High

    // F = Q2.Q1.Q0'
    and (F, Q2, Q1, not_Q0);
    
endmodule