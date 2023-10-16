//part 1

module part1(input logic [3:0] a, b, input logic c_in,
             output logic [3:0] s, output logic c_out);
    logic c1, c2, c3;

    full_adder u1(a[0],b[0],c_in,    s[0],c1);
    full_adder u2(a[1],b[1],c1,      s[1],c2);
    full_adder u3(a[2],b[2],c2,      s[2],c3);
    full_adder u4(a[3],b[3],c3,      s[3],c_out);

endmodule

module full_adder(input logic a, b, c_in, output logic s, c_out);
    logic y;
    assign y = a^b;
    assign s = y^c_in;
    always_comb
    assign c_out = y ? c_in : b; 
        

endmodule


//module part1(input logic [3:0] a, b, input logic c_in,
//output logic [3:0] s, c_out);
    //logic c1, c2, c3;

   // full_adder u1(a[0],b[0],c_in,    s[0],c1);
    //full_adder u2(a[1],b[1],c1,      s[1],c2);
    //full_adder u3(a[2],b[2],c2,      s[2],c3);
    //full_adder u4(a[3],b[3],c3,      s[3],c_out);

//endmodule


module top(LEDR, SW);
    input logic [9:0] SW;
    output logic [9:0] LEDR;

    part1 ut1(
        .a(SW[3:0]),
        .b(SW[7:4]),
        .c_in(SW[8]),
        .s(LEDR[3:0]),
        .c_out(LEDR[4])
    );
endmodule
