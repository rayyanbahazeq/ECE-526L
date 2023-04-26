`timescale 1ns/1ps
module level_two #(parameter WIDTH = 4) (input wire clk, input wire [WIDTH-1:0] data_in, input wire [WIDTH-1:0] c1, input wire [WIDTH-1:0] c2, output wire [WIDTH-1:0] reg2_out, output wire [(2*WIDTH):0] prod_sum);
    wire [WIDTH-1:0] reg1_out;
    wire [(2*WIDTH)-1:0] mult1_out, mult2_out;
    
    var_register #(.WIDTH(WIDTH)) register1 (.clk(clk), .din(data_in), .dout(reg1_out));
    var_register #(.WIDTH(WIDTH)) register2 (.clk(clk), .din(reg1_out), .dout(reg2_out));
    
    var_multiplier #(.WIDTH(WIDTH)) multiplier1 (.in1(c1), .in2(reg1_out), .out(mult1_out));
    var_multiplier #(.WIDTH(WIDTH)) multiplier2 (.in1(c2), .in2(reg2_out), .out(mult2_out));
    
    var_adder #(.WIDTH(2*WIDTH)) adder (.in1(mult1_out), .in2(mult2_out), .out(prod_sum));
endmodule
