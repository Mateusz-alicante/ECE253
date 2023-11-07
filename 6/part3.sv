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


endmodule


module control(
    input logic clk,
    input logic reset,
    input logic go,

    output logic ld_a, ld_b, ld_r,
    output logic ld_alu_out,
    output logic alu_select_a, alu_select_b,
    output logic alu_op,
    output logic result_valid
    );

    typedef enum logic [2:0]  { S_LOAD_RST    = 'd0,
                                S_LOAD        = 'd1,
                                S_LOAD_WAIT   = 'd2,
                                // TODO: Add states to load other inputs here. 
                                S_CYCLE_0       = 'd5,
                                S_CYCLE_1       = 'd6,
                                S_CYCLE_2       = 'd6
                                S_CYCLE_3       = 'd6} statetype;
                                
    statetype current_state, next_state;                            

    // Next state logic aka our state table
    always_comb begin
        case (current_state)
            S_LOAD_RST: next_state = go ? S_LOAD_WAIT : S_LOAD_RST; // Loop in current state until value is input
            S_LOAD: next_state = go ? S_LOAD_WAIT : S_LOAD; // Loop in current state until value is input
            S_LOAD_WAIT: next_state = go ? S_LOAD_WAIT : S_CYCLE_0; 

            // TODO: Add states for other inputs here.
            
            S_CYCLE_0: next_state = S_CYCLE_1;
            S_CYCLE_1: next_state = S_CYCLE_2;
            S_CYCLE_2: next_state = S_CYCLE_3;
            // TODO: Add new states for the required operation. 
            S_CYCLE_3: next_state = S_LOAD_A; // we will be done our two operations, start over after
            default:   next_state = S_LOAD_A_RST;
        endcase
    end // state_table

    // output logic logic aka all of our datapath control signals
    always_comb begin
        // By default make all our signals 0
        shift_Dividend = 1'b0;
        ld_r = 1'b0;
        alu_select_a = 1'b0;
        alu_select_b = 1'b0;
        alu_op       = 1'b0;
        result_valid = 1'b0;

        case (current_state)
            S_LOAD_A_RST: begin
                ld_a = 1'b1;
                end
            S_LOAD_A: begin
                ld_a = 1'b1;
                result_valid = 1'b1;
                end
            S_LOAD_B: begin
                ld_b = 1'b1;
                end
            S_CYCLE_0: begin // Do A <- A * A
                ld_alu_out = 1'b1; 
                ld_a = 1'b1; // store result back into A
                alu_select_a = 1'b0; // Select register A
                alu_select_b = 1'b0; // Also select register A
                alu_op = 1'b1; // Do multiply operation
            end
            S_CYCLE_1: begin
                ld_r = 1'b1; // store result in result register
                alu_select_a = 1'b0; // Select register A
                alu_select_b = 1'b1; // Select register B
                alu_op = 1'b0; // Do Add operation
            end
        // We don't need a default case since we already made sure all of our outputs were assigned a value at the start of the always block.
        endcase
    end // enable_signals

    // current_state logicisters
    always_ff@(posedge clk) begin
        if(reset)
            current_state <= S_LOAD_A_RST;
        else
            current_state <= next_state;
    end // state_FFS
endmodule


module datapath(
    input logic clk,
    input logic reset,
    input logic [3:0] Divisor_in, Divident_in,
    input logic [3:0] reg_A;
    output logic [3:0] Quotient,
    output logic [3:0] Remainder,
    // TODO: Add additional signals from control path here. 
    input logic ld_r,
    );

    // input logic logicisters
    logic [3:0] Divisor, Divident;

    // output logic of the alu
    logic [7:0] alu_out;
    // alu input logic muxes
    logic [3:0] alu_Divisor, alu_Divident;

    // registers a and b with associated logic
    always_ff @(posedge clk) begin
        if(reset) begin
            Divisor <= 4'b0;
            Divident <= 4'b0;
        end
        else begin
            if(ld) begin
                Divisor <= Divisor_in;
                Divident <= Divident_in;
            end
        end
    end

    // output logic result logicister
    always@(posedge clk) begin
        if(reset) begin
            Quotient <= 4'b0;
            Remainder <= 4'b0;
        end
        else
            if(ld_r) begin
                Quotient <= Divident;
                Remainder <= reg_A;
            end
    end

    // The ALU
    always_comb begin : ALU
        case (alu_op)
            0: alu_out = alu_a + alu_b; //performs addition
            1: alu_out = alu_a * alu_b; //performs multiplication
            default: alu_out = 8'b0;
        endcase
    end

endmodule


