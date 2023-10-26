module part3
#(parameter CLOCK_FREQUENCY=500)(
input logic ClockIn,
input logic Reset,
input logic Start,
input logic [2:0] Letter,
output logic DotDashOut,
output logic NewBitOut
);

    logic [11:0] seq;
    logic halfASecond, started;

    RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) rd(
        .ClockIn(ClockIn),
        .Reset(Reset),
        .Speed(2'b10),
        .Enable(halfASecond)
        .Start(Start)
    );

    always_ff@(posedge halfASecond)
        begin
            seq <= seq << 1;
            DotDashOut <= seq[1];
        end

    always_ff @(posedge ClockIn)
        if (Reset)
            begin
                seq <= 12'b0;
                started <= 0;
            end
        else if (Start)
            begin
                started <= 1;
                case(Letter)
                    3'b000: seq <= 12'b101110000000;
                    3'b001: seq <= 12'b111010101000;
                    3'b010: seq <= 12'b111010111010;
                    3'b011: seq <= 12'b111010100000;
                    3'b100: seq <= 12'b100000000000;
                    3'b101: seq <= 12'b101011101000;
                    3'b110: seq <= 12'b111011101000;
                    3'b111: seq <= 12'b101010100000;
                endcase;
            end




endmodule

module RateDivider
#(parameter CLOCK_FREQUENCY = 10) (
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic Enable,
    input logic Start
);

    logic n_cycles;

    logic [$clog2(CLOCK_FREQUENCY):0] Q;

    always_ff @(posedge ClockIn, posedge Reset) 
        if ( Q == 'b0)
                case (Speed)
                    2'b00: Q <= 1;
                    2'b01: Q <= CLOCK_FREQUENCY - 1;
                    2'b10: Q <= CLOCK_FREQUENCY / 2 - 1;
                    2'b11: Q <= CLOCK_FREQUENCY / 4 - 1;
                endcase
        else
            Q <= (Reset && ~Start)? 'b0 : Q-1; 


    assign Enable = (Q == 'b0)?'1:'0;


endmodule