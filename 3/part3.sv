module part3(A, B, Function, ALUout);
    parameter N = 4;
    input logic [N-1:0] A, B;
    input logic [1:0] Function;
    output logic [( 2 * N )-1:0] ALUout;

    always_comb
    case (f)
        2'b00: ALUout = A + B;
        2'b01: if ((|A) | (|B)) ALUout = 1;
        2'b10: if ((&A) & (&B)) ALUout = 1;
        2'b11: ALUout = {A, B};
    default : ALUout = 0;
    endcase

endmodule
