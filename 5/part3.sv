module part3
#(parameter CLOCK_FREQUENCY=500)(
input logic ClockIn,
input logic Reset,
input logic Start,
input logic [2:0] Letter,
output logic DotDashOut,
output logic NewBitOut
);

    logic [12:0] seq;
    logic [3:0] counter; // This keeps track of how many times to output new bit out.
    logic [($clog2(CLOCK_FREQUENCY / 2)):0] Q; // remove this later

    RateDivider #(.CLOCK_FREQUENCY(CLOCK_FREQUENCY)) rd(
        .ClockIn(ClockIn),
        .Reset(Reset),
        .Enable(NewBitOut),
        .Start(Start),
        .Q(Q),
        .Counter(counter)
    );

    assign DotDashOut = seq[12];

    always_ff@(posedge NewBitOut)
        begin
            if (counter != 0)
            begin
                seq <= seq << 1;
                counter <= counter - 1;
            end
            
        end


    always_ff @(posedge Start)
        begin
            counter <= 13;
            case(Letter)
                3'b000: seq <= 13'b0101110000000;
                3'b001: seq <= 13'b0111010101000;
                3'b010: seq <= 13'b0111010111010;
                3'b011: seq <= 13'b0111010100000;
                3'b100: seq <= 13'b0100000000000;
                3'b101: seq <= 13'b0101011101000;
                3'b110: seq <= 13'b0111011101000;
                3'b111: seq <= 13'b0101010100000;
            endcase;
        end

    always_ff @(posedge Reset)
        begin
            seq <= 13'b0000000000000;
            counter <= 0;
        end




endmodule

module RateDivider
#(parameter CLOCK_FREQUENCY = 10) (
    input logic ClockIn,
    input logic Reset,
    output logic Enable,
    input logic Start,
    input logic [3:0] Counter,
    output logic [($clog2(CLOCK_FREQUENCY / 2)):0] Q
);

    logic n_cycles;

    //logic [$clog2(CLOCK_FREQUENCY / 2):0] Q;

    always_ff @(posedge ClockIn, posedge Reset) 
        if (Reset)
            Q <= CLOCK_FREQUENCY / 2;
        else if ( Q == 'b0)
                Q <= CLOCK_FREQUENCY / 2 - 1;
        else
            Q <= Q-1; 

    always_ff @(posedge Start)
        if (Start)
            Q <= CLOCK_FREQUENCY / 2;

    assign Enable = (Q == 'b0 && ~Start && ~Reset && Counter && ~(Counter == 1 && Q == 1))?'1:'0;


endmodule