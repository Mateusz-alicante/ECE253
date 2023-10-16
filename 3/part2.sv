//part 2

  module part2(
    input logic [3:0] a, b,
    input logic [1:0] Function;
    output logic [7:0] ALUout,
  );
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

