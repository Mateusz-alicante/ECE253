module part2
#(parameter CLOCK_FREQUENCY = 500)(
input logic ClockIn,
input logic Reset,
input logic [1:0] Speed,
output logic [3:0] CounterValue
);



endmodule

module RateDivider
#(parameter CLOCK_FREQUENCY = 500) (
    input logic ClockIn,
    input logic Reset,
    input logic [1:0] Speed,
    output logic Enable
);

    logic [$clog(CLOCK_FREQUENCY) << 2:0] Q;



    always_ff @(posedge ClockIn, posedge Reset) 
        begin
            Q <= (Reset)? 'b0 : Q+1; 
        end

    always_comb
        if (Q == 'b0)
            RateDividerCount <= CLOCK_FREQUENCY / Speed - 1;

    assign Enable = (RateDividerCount == 'b0)?'1:'0;


endmodule