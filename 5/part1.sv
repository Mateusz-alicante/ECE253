<<<<<<< HEAD
module part1 (
    input logic Clock,
    input logic Enable,
    input logic Reset,
    output logic [7:0] CounterValue
);

    logic [6:0] i;

    // Assign Intermediate Values
    assign i[0] = Enable & CounterValue[0];
    assign i[1] = i[0] & CounterValue[1];
    assign i[2] = i[1] & CounterValue[2];
    assign i[3] = i[2] & CounterValue[3];
    assign i[4] = i[3] & CounterValue[4];
    assign i[5] = i[4] & CounterValue[5];
    assign i[6] = i[5] & CounterValue[6];

    // Instantiate T Flip Flops
    T_flip_flop u0(
        .clk(Clock),
        .T(Enable),
        .reset(Reset),
        .Q(CounterValue[0])
    );

    T_flip_flop u1(
        .clk(Clock),
        .T(i[0]),
        .reset(Reset),
        .Q(CounterValue[1])
    );

    T_flip_flop u2(
        .clk(Clock),
        .T(i[1]),
        .reset(Reset),
        .Q(CounterValue[2])
    );

    T_flip_flop u3(
        .clk(Clock),
        .T(i[2]),
        .reset(Reset),
        .Q(CounterValue[3])
    );

    T_flip_flop u4(
        .clk(Clock),
        .T(i[3]),
        .reset(Reset),
        .Q(CounterValue[4])
    );

    T_flip_flop u5(
        .clk(Clock),
        .T(i[4]),
        .reset(Reset),
        .Q(CounterValue[5])
    );

    T_flip_flop u6(
        .clk(Clock),
        .T(i[5]),
        .reset(Reset),
        .Q(CounterValue[6])
    );

    T_flip_flop u7(
        .clk(Clock),
        .T(i[6]),
        .reset(Reset),
        .Q(CounterValue[7])
    );


endmodule



module T_flip_flop(
    input logic clk,
    input logic T,
    input logic reset,
    output logic Q
);

    D_flip_flop u1 (
        .clk(clk),
        .reset_b(reset),
        .d(T^Q),
        .q(Q)
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
=======

>>>>>>> b82542797f5bbc56b351f1bfebda7532199a3b52
