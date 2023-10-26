module part2
#(parameter CLOCK_FREQUENCY = 500)(
input logic ClockIn,
input logic Reset,
input logic [1:0] Speed,
output logic [3:0] CounterValue
);

logic EnableDC;

RateDivider rd1(
    .ClockIn(ClockIn),
    .Reset(Reset),
    .Speed(Speed),
    .Enable(EnableDC)
);

DisplayCounter dc1(
    .Clock(ClockIn),
    .Reset(Reset),
    .EnableDC(EnableDC),
    .CounterValue(CounterValue)
);

endmodule

module DisplayCounter (
    input logic Clock,
    input logic Reset,
    input logic EnableDC,
    output logic [3:0] CounterValue
    );

    always_ff@(posedge Clock)
        if (Reset)
            CounterValue <= 'b0;
        else if (EnableDC)
            CounterValue <= CounterValue + 1;

endmodule

module RateDivider
#(parameter CLOCK_FREQUENCY = 10) (
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic Enable
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
            Q <= (Reset)? 'b0 : Q-1; 


    assign Enable = (Q == 'b0)?'1:'0;


endmodule