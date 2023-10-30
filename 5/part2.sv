module part2
#(parameter CLOCK_FREQUENCY = 500)(
input logic ClockIn,
input logic Reset,
input logic [1:0] Speed,
output logic [3:0] CounterValue
);

logic EnableDC;

RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) rd1(
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

    logic [$clog2(CLOCK_FREQUENCY * 4) + 1:0] Q;

    always_ff @(posedge ClockIn, posedge Reset) 
        if (Reset)
            case (Speed) // Here we set the counter to +1, to ensure that we wait the correct number of cases when reset is just disabled.
                    2'b00: Q <= 0; // Full speed
                    2'b01: Q <= CLOCK_FREQUENCY; // Once every second
                    2'b10: Q <= CLOCK_FREQUENCY * 2; // Once every 2 seconds (0.5 Hz)
                    2'b11: Q <= CLOCK_FREQUENCY * 4;// Once every 4 seconds (0.25 HZ)
                endcase
        else if ( Q == 'b0)
                case (Speed)
                    2'b00: Q <= 0; // Full speed
                    2'b01: Q <= CLOCK_FREQUENCY - 1; // Once every second
                    2'b10: Q <= CLOCK_FREQUENCY * 2 - 1; // Once every 2 seconds (0.5 Hz)
                    2'b11: Q <= CLOCK_FREQUENCY * 4 - 1;// Once every 4 seconds (0.25 HZ)
                endcase
        else
            Q <= Q-1; 


    assign Enable = (Q == 'b0 && ~Reset)?'1:'0;


endmodule