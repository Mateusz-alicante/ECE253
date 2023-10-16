module alu(a, b, Function, ALUout)
    parameter N = 4;
    input logic [N-1:0] a, b;
    input logic [1:0] Function;
    output logic [( 2 * N )-1:0] ALUout;

    always_comb
    case (f)
        2'b00: ALUout = a + b;
        2'b01: if ((|a) | (|b)) ALUout = 1;
        2'b10: if ((&a) & (&b)) ALUout = 1;
        2'b11: ALUout = {a, b};
    default : ALUout = 0;
    endcase

endmodule
