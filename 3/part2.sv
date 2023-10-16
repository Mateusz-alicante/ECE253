
module alu(
    input logic [3:0] a, b,
    input logic [1:0] f,
    output logic [7:0] ALUout
);
    logic [4:0] sum_out;
    part1 u_sum(a,b,1'b0,sum_out[3:0],sum_out[4]);

    always_comb
    case (f)
        2'b00: ALUout = sum_out;
        2'b01: if ((|a) | (|b)) ALUout = 8'b00000001;
        2'b10: if ((&a) & (&b)) ALUout = 8'b00000001;
        2'b11: ALUout = {a, b};
    default : ALUout = 8'b00000000;
    endcase


endmodule


// Prev modules
module full_adder(input logic a, b, c_in, output logic s, c_out)
    logic y;
    assign y = a^b;
    assign s = y^c_in;

    assign c_out = y ? c_in : b;

endmodule


module part1(input logic [3:0] a, b, input logic c_in,
output logic [3:0] s, c_out);
    logic c1, c2, c3, c_final;

    assign c_out = {c_final, c3, c2, c1};

    full_adder u1(a[0],b[0],c_in,    s[0],c1);
    full_adder u2(a[1],b[1],c1,      s[1],c2);
    full_adder u3(a[2],b[2],c2,      s[2],c3);
    full_adder u4(a[3],b[3],c3,      s[3],c_final);


endmodule
