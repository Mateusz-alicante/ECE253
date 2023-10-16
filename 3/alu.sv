
module alu(
    input logic [3:0] a, b,
    input logic [1:0] f;
    output logic [7:0] ALUout,
)
    logic [4:0] sum_out
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


module top(LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3);
    input logic [9:0] SW;
    input logic [1:0] KEY;
    output logic [9:0] LEDR;
    output logic [6:0] HEX0, HEX1, HEX2, HEX3;

    logic [7:0] out;

    hex_decoder uh1(SW[7:4], HEX0);
    hex_decoder uh2(SW[3:0], HEX1);
    hex_decoder uh2(out[3:0], HEX2);
    hex_decoder uh2(out[7:4], HEX3);

    assign LEDR[7:0] = out;

    alu ualu(SW[7:4], SW[3:0], KEY[1:0], out)
endmodule




// Prev modules
module full_adder(input logic a, b, c_in, output logic s, c_out)
    logic y;
    assign y a^b;
    assign s y^c_in;

    always_comb
    c_out = y ? c_in : b;

endmodule


module part1(input logic [3:0] a, b, input logic c_in,
output logic [3:0] s, c_out);
    logic c1, c2, c3;

    full_adder u1(a[0],b[0],c_in,    s[0],c1);
    full_adder u2(a[1],b[1],c1,      s[1],c2);
    full_adder u3(a[2],b[2],c2,      s[2],c3);
    full_adder u4(a[3],b[3],c3,      s[3],c_out);

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