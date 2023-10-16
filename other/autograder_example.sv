//Tester
//TESTCASES=3
`timescale 1 ns/10 ps
module part3_tb;
    //input
    reg [3:0] c;
    //output
    wire [6:0] display;
    //golden
    reg [6:0] display_golden;
    hex_decoder DUT (.c(c), .display(display));
    initial begin
        c = 0;
        display_golden = 7'b1000000;
        #1;
        if(display == display_golden)
            $display("input data = %d, your output = %b, expected output = %b PASSED", c, display, display_golden);
        else
            $display("input data = %d, your output = %b, expected output = %b FAILED", c, display, display_golden);
        c = 1;
        display_golden = 7'b1111001;
        #1;
        if(display == display_golden)
            $display("input data = %d, your output = %b, expected output = %b PASSED", c, display, display_golden);
        else
            $display("input data = %d, your output = %b, expected output = %b FAILED", c, display, display_golden);
        c = 2;
        display_golden = 7'b0100100;
        #1;
        if(display == display_golden)
            $display("input data = %d, your output = %b, expected output = %b PASSED", c, display, display_golden);
        else
            $display("input data = %d, your output = %b, expected output = %b FAILED", c, display, display_golden);
    end
endmodule

                                             [ File 'part3_tb.sv' is unwritable ]
^G Help        ^O Write Out   ^W Where Is    ^K Cut         ^T Execute     ^C Location    M-U Undo       M-A Set Mark
^X Exit        ^R Read File   ^\ Replace     ^U Paste       ^J Justify     ^_ Go To Line  M-E Redo       M-6 Copy
