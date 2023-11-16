// Original
module part3(
input logic Clock,
input logic Reset,
input logic Go,
input logic [3:0] Divisor,
input logic [3:0] Dividend,
output logic [3:0] Quotient,
output logic [3:0] Remainder,
output logic ResultValid
);

    logic divide, ld, ld_r;

    control C0(
        .clk(Clock),
        .reset(Reset),
        .ld_r(ld_r),

        .go(Go),
        .divide(divide),
        .ld(ld),
        .result_valid(ResultValid)
    );

    datapath D0(
        .clk(Clock),
        .reset(Reset),
        .go(Go),

        .Divisor_in(Divisor),
        .Dividend_in(Dividend),
        .Quotient(Quotient),
        .Remainder(Remainder),
        .ld_r(ld_r),
        .ld(ld),
        .divide(divide)
    );


endmodule


module control(
    input logic clk,
    input logic reset,
    input logic go,

    output logic divide,
    output logic ld,
    output logic result_valid,
    output logic ld_r
    );

    typedef enum logic [3:0]  { S_LOAD_RST    = 'd0,
                                S_LOAD        = 'd1,
                                // TODO: Add states to load other inputs here. 
                                S_CYCLE_0       = 'd2,
                                S_CYCLE_1       = 'd3,
                                S_CYCLE_2       = 'd4,
                                S_CYCLE_3       = 'd5} statetype;
                                
    statetype current_state, next_state;                            

    // Next state logic aka our state table
    always_comb begin
        case (current_state)
            S_LOAD_RST: next_state = go ? S_CYCLE_0 : S_LOAD_RST; // Loop in current state until value is input
            S_LOAD: next_state = go ? S_CYCLE_0 : S_LOAD; // Loop in current state until value is input

            // TODO: Add states for other inputs here.
            
            S_CYCLE_0: next_state = S_CYCLE_1;
            S_CYCLE_1: next_state = S_CYCLE_2;
            S_CYCLE_2: next_state = S_CYCLE_3;
            // TODO: Add new states for the required operation. 
            S_CYCLE_3: next_state = S_LOAD; // we will be done our two operations, start over after
            default:   next_state = S_LOAD_RST;
        endcase
        $display("Current State: %0d", current_state);
        $display("Next State: %0d ================", next_state);
    end // state_table

    // output logic logic aka all of our datapath control signals
    always_comb begin
        // By default make all our signals 0
        divide = 1'b0;
        ld_r = 1'b0;
        result_valid = 1'b0;
        ld = 0'b0;

        case (current_state)
            S_LOAD_RST: begin
                ld = 1'b1;
                end
            S_LOAD: begin
                ld = 1'b1;
                result_valid = 1'b1;
                end
            S_CYCLE_0: begin 
              divide = 1'b1;
            end
            S_CYCLE_1: begin
              divide = 1'b1;
            end
            S_CYCLE_2: begin
               divide = 1'b1;
            end
            S_CYCLE_3: begin
               divide = 1'b1;
               ld_r = 1'b1;
            end
        // We don't need a default case since we already made sure all of our outputs were assigned a value at the start of the always block.
        endcase

        
    end // enable_signals

    // current_state logicisters
    always_ff@(posedge clk) begin
        if(reset)
            current_state <= S_LOAD_RST;
        else
            current_state <= next_state;
    end // state_FFS
endmodule


module datapath(
    input logic clk,
    input logic reset,
    input logic go,
    input logic [3:0] Divisor_in, Dividend_in,
    output logic [3:0] Quotient,
    output logic [3:0] Remainder,
    // TODO: Add additional signals from control path here. 
    input logic ld_r,
    input logic ld,
    input logic divide
    );

    // input logic logicisters
    logic [3:0] Dividend;
    logic [4:0] reg_A, Divisor;


    // registers a and b with associated logic
    always @(posedge clk) begin
        if(reset) begin
            Divisor <= 4'b0;
            Dividend <= 4'b0;
        end
        else begin
            if(ld) begin
                Divisor <= Divisor_in;
                Dividend <= Dividend_in;
                reg_A <= 4'b0;
            end
        end
    end

    // output logic result logicister
    always@(posedge clk) begin
        $display("divide: %0d", divide);
        if(reset) begin
            Quotient <= 4'b0;
            Remainder <= 4'b0;
        end
        else
            if (divide) begin

                reg_A = reg_A << 1;
                reg_A[0] = Dividend[3];
                Dividend = Dividend << 1;
                reg_A = reg_A - Divisor;
                if (reg_A[3] == 1'b1) begin
                    Dividend[0] = 1'b0;
                    reg_A = reg_A + Divisor;
                end
                else begin
                    Dividend[0] = 1'b1;
                end
            end

            if(ld_r) begin
                Quotient = Dividend;
                Remainder = reg_A;
            end

    end


endmodule


