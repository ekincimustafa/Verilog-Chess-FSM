module machine_d(
    input wire x,
    input wire CLK,
    input wire RESET,
    output wire F,
    output wire [2:0] S
);
    // Your code goes here. DO NOT change anything that is already given!

    wire Q2, Q1, Q0;  // Current State 
    wire D2, D1, D0;  // Next State 
    
    assign S = {Q2, Q1, Q0};

    // Flip Flop Connections
    dff ff2 ( 
        .D(D2), 
        .CLK(CLK), 
        .RESET(RESET), 
        .Q(Q2) );

    dff ff1 ( 
        .D(D1), 
        .CLK(CLK), 
        .RESET(RESET), 
        .Q(Q1) );

    dff ff0 ( 
        .D(D0), 
        .CLK(CLK), 
        .RESET(RESET), 
        .Q(Q0) );
    
    // And gates results    
    wire d2_1, d2_2, d2_3;
    wire d1_1, d1_2, d1_3;
    wire d0_1, d0_2;
        
    // Inverter 
    wire not_x, not_Q2, not_Q1, not_Q0;

    not (not_x, x);
    not (not_Q2, Q2);
    not (not_Q1, Q1);
    not (not_Q0, Q0);

    // D2 = Q2.Q1'.Q0' + Q1'.Q0.x + Q2'.Q1.Q0.x' 

    and d2_1_g (d2_1, Q2, not_Q1, not_Q0);      
    and d2_2_g (d2_2, not_Q1, Q0, x);      
    and d2_3_g (d2_3, not_Q2, Q1, Q0, not_x);           
    or  d2_f (D2, d2_1, d2_2, d2_3);   
    
    // D1 = Q2'.Q0'.x + Q2'.Q1.Q0 + Q2.Q1'.Q0'.x'

    and d1_1_g (d1_1, not_Q2, not_Q0, x);     
    and d1_2_g (d1_2, not_Q2, Q1, Q0);                
    and d1_3_g (d1_3, Q2, not_Q1, not_Q0, not_x); 
    or  d1_f (D1, d1_1, d1_2, d1_3);    

    // D0 = Q2'.Q0' + Q1'.Q0'.x

    and d0_1_g (d0_1, not_Q2, not_Q0);         
    and d0_2_g (d0_2, not_Q1, not_Q0, x); 
    or  d0_f (D0, d0_1, d0_2);          

    // F = Q2.Q1.Q0'

    and out_f (F, Q2, Q1, not_Q0);

endmodule