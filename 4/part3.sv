module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
    input logic clock, reset, ParallelLoadn, RotateRight, ASRight;
    input logic [3:0] Data_IN;
    output logic [3:0] Q;

    D_flip_flop u1(
        .clk(clock),
        .reset_b(reset),
        .d(ParallelLoadn ? (
                RotateRight ? 
                    (ASRight ? (Q[0]) : (Q[1]))
                    : (Q[3])) 
            : Data_IN[0]),
        .q(Q[0])
    );

    D_flip_flop u2(
        .clk(clock),
        .reset_b(reset),
        .d(ParallelLoadn ? (
                RotateRight ? 
                    Q[2]
                    : (Q[0])) 
            : Data_IN[1]),
        .q(Q[1])
    );

    D_flip_flop u3(
        .clk(clock),
        .reset_b(reset),
        .d(ParallelLoadn ? (
                RotateRight ? 
                    Q[3]
                    : (Q[1])) 
            : Data_IN[2]),
        .q(Q[2])
    );

    D_flip_flop u4(
        .clk(clock),
        .reset_b(reset),
        .d(ParallelLoadn ? (
                RotateRight ? 
                    Q[0]
                    : (Q[2])) 
            : Data_IN[3]),
        .q(Q[3])
    );

endmodule

module D_flip_flop (
    input logic clk ,
    input logic reset_b ,
    input logic d ,
    output logic q
) ;

    always_ff @ ( posedge clk )
    if ( reset_b ) q <= 1'b0;
    else q <= d;


endmodule