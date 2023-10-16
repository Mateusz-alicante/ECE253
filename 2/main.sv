`timescale 1ns / 1ns // `timescale time_unit/time_precision

//SW[2:0] data inputs
//SW[9] select signals

//LEDR[0] output display

module mux(LEDR, SW);
    input logic [9:0] SW;
    output logic [9:0] LEDR;

    mux2to1 u0(
        .x(SW[0]),
        .y(SW[1]),
        .s(SW[9]),
        .m(LEDR[0])
        );
endmodule


// Inverters
module v7404 (input logic pin1, pin3, pin5, pin9, pin11, pin13,
output logic pin2, pin4, pin6, pin8, pin10, pin12);

    assign pin2 = ~pin1;
    assign pin4 = ~pin3;
    assign pin6 = ~pin5;
    assign pin8 = ~pin9;
    assign pin10 = ~pin11;
    assign pin12 = ~pin13;

endmodule

// AND gates
module v7408 (input logic pin1, pin3, pin5, pin9, pin11, pin13,
output logic pin2, pin4, pin6, pin8, pin10, pin12);

    assign pin3 = pin1 & pin2;
    assign pin6 = pin4 & pin5;
    assign pin11 = pin12 & pin13;
    assign pin8 = pin9 & pin10;

endmodule

// OR gates
module v7432 (input logic pin1, pin3, pin5, pin9, pin11, pin13,
output logic pin2, pin4, pin6, pin8, pin10, pin12);

    assign pin3 = pin1 | pin2;
    assign pin6 = pin4 | pin5;
    assign pin11 = pin12 | pin13;
    assign pin8 = pin9 | pin10;

endmodule


module mux2to1 (input logic x,y,s, output logic m);

    logic not_s;
    logic w1, w2;

    // Invert s
    v7404 u0(
        .pin1(s),
        .pin2(not_s)
        );

    // AND gates
    v7408 u1(
        .pin1(s),
        .pin2(y),
        .pin3(w1),

        .pin4(not_s),
        .pin5(x),
        .pin6(w2)
    );

    v7432 u2(
        .pin1(w1),
        .pin2(w2),
        .pin3(m)
    );


endmodule