module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
    input logic clock, reset, ParallelLoadn, RotateRight, ASRight;
    input logic [3:0] Data_IN;
    output logic [3:0] Q;

    D_flip_flop u1(
        .clk(clock),
        .reset_b(reset),
        .d(ParallelLoadn ? (
                RotateRight ? 
                    (Q[1])
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
                    ASRight ? (Q[3]) : (Q[0])
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


// Modules to use on board
module top(LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3);
    input logic [9:0] SW;
    input logic [1:0] KEY;
    output logic [9:0] LEDR;
    output logic [6:0] HEX0, HEX1, HEX2, HEX3;


    hex_decoder uh1 (SW[3:0], HEX0);

    hex_decoder uh2 (LEDR[3:0], HEX3);
    

    part3 u1 (KEY[0], KEY[1], SW[3:0], SW[9], SW[8], SW[7], LEDR[3:0]);

endmodule

module hex_decoder(input logic [3:0] c, output logic [6:0] display);

    // (c[0] & c[1] & c[2] & c[3] ) |

    assign display[0] = 
        (~c[3] & ~c[2] & ~c[1] & c[0]) | 
        (~c[3] & c[2] & ~c[1] & ~c[0] ) | 
        (c[3] & ~c[2] & c[1] & c[0] ) | 
        (c[3] & c[2] & ~c[1] & c[0] );

    assign display[1] = 
        (~c[3] & c[2] & ~c[1] & c[0]) | 
        (~c[3] & c[2] & c[1] & ~c[0] ) | 
        (c[3] & ~c[2] & c[1] & c[0] ) | 
        (c[3] & c[2] & ~c[1] & ~c[0] ) |
        (c[3] & c[2] & c[1] & ~c[0] ) |
        (c[3] & c[2] & c[1] & c[0] );

    assign display[2] =
        (~c[3] & ~c[2] & c[1] & ~c[0]) | 
        (c[3] & c[2] & ~c[1] & ~c[0] ) | 
        (c[3] & c[2] & c[1] & ~c[0] ) | 
        (c[3] & c[2] & c[1] & c[0] );

    assign display[3] =
        (~c[3] & ~c[2] & ~c[1] & c[0]) | 
        (~c[3] & c[2] & ~c[1] & ~c[0] ) | 
        (~c[3] & c[2] & c[1] & c[0] ) | 
        (c[3] & ~c[2] & ~c[1] & c[0] ) |
        (c[3] & ~c[2] & c[1] & ~c[0] ) |
        (c[3] & c[2] & c[1] & c[0] );

    assign display[4] = 
        (~c[3] & ~c[2] & ~c[1] & c[0]) | 
        (~c[3] & ~c[2] & c[1] & c[0]) | 
        (~c[3] & c[2] & ~c[1] & ~c[0] ) | 
        (~c[3] & c[2] & ~c[1] & c[0] ) | 
        (~c[3] & c[2] & c[1] & c[0] ) | 
        (c[3] & ~c[2] & ~c[1] & c[0] );

    assign display[5] = 
        (~c[3] & ~c[2] & ~c[1] & c[0]) | 
        (~c[3] & ~c[2] & c[1] & ~c[0]) | 
        (~c[3] & ~c[2] & c[1] & c[0]) | 
        (~c[3] & c[2] & c[1] & c[0]) | 
        (c[3] & ~c[2] & ~c[1] & c[0]);

    assign display[6] = 
        (~c[3] & ~c[2] & ~c[1] & ~c[0]) | 
        (~c[3] & ~c[2] & ~c[1] & c[0]) | 
        (~c[3] & c[2] & c[1] & c[0]) | 
        (c[3] & c[2] & ~c[1] & ~c[0]);



endmodule