module part1 ( input logic [2:0] MuxSelect , input logic [6:0]
    MuxIn , output logic Out );

    always_comb 
        begin
            case (MuxSelect)
                3'b000: Out = MuxIn[0];
                3'b001: Out = MuxIn[1];
                3'b010: Out = MuxIn[2];
                3'b011: Out = MuxIn[3];
                3'b100: Out = MuxIn[4];
                3'b101: Out = MuxIn[5];
                3'b110: Out = MuxIn[6];
                3'b111: Out = 1b'0;
            default: Out = 0;
            endcase
        end

endmodule

module top(LEDR, SW);
    input logic [9:0] SW;
    output logic [9:0] LEDR;

    part1 u1(
        .MuxSelect(SW[2:0]),
        .MuxIn(SW[9:0]),
        .Out(LEDR[0])
    )
endmodule
