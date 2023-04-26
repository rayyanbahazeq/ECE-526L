`timescale 1ns/1ps
module top_level #(parameter WIDTH = 4) (input wire clk, input wire [WIDTH-1:0] data_in, input wire [WIDTH-1:0] c1, input wire [WIDTH-1:0] c2, input wire [WIDTH-1:0] c3, input wire [WIDTH-1:0] c4, output wire [2*WIDTH+1:0] final_sum);
    wire [2*WIDTH:0] prod_sum1, prod_sum2;
    wire [WIDTH-1:0] reg_2;
    
    level_two #(.WIDTH(WIDTH)) level_two_inst1 (.clk(clk), .data_in(data_in), .c1(c1), .c2(c2), .reg2_out(reg_2), .prod_sum(prod_sum1));
    level_two #(.WIDTH(WIDTH)) level_two_inst2 (.clk(clk), .data_in(reg_2), .c1(c3), .c2(c4), .reg2_out(), .prod_sum(prod_sum2));
    
    var_adder #(.WIDTH(2*WIDTH+1)) final_adder (.in1(prod_sum1), .in2(prod_sum2), .out(final_sum));
endmodule
