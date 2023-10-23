module part2(Clock, Reset_b, Data, Function, ALUout);
    input logic [3:0] Data;
    input logic [2:0] Function;
    input logic Clock, Reset_b;
    output logic [7:0] ALUout;

    always_ff @(posedge Clock, posedge Reset_b) // Run on clock edge and reset (active high reset)
            if (Reset_b) ALUout <= 0; // If reset is high, store the value 0 in the register
            else begin
                case (Function)
                    2'b00: ALUout <= Data + ALUout; // When F = 0, do addition
                    2'b01: ALUout <= Data * ALUout; // When F = 1, do multiplication
                    2'b10: ALUout <= ALUout << Data; // When F = 2, do left shift
                    2'b11: ALUout <= ALUout; 
                    default: ALUout <= ALUout; //same as case 3
                    // When no cases are met, (includes 3 and default), keep the current value at the register.
                endcase
            end
endmodule

// Modules to use on board
module top(LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3);
    input logic [9:0] SW;
    input logic [1:0] KEY;
    output logic [9:0] LEDR;
    output logic [6:0] HEX0, HEX1, HEX2, HEX3;

    logic [7:0] ALUout;

    hex_decoder uh1 (SW[3:0], HEX0);

    hex_decoder uh2 (ALUout[3:0], HEX1);
    hex_decoder uh3 (ALUout[7:4], HEX2);
    

    part2 u1 (KEY[0], KEY[1], SW[3:0], SW[9:8], ALUout);

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
