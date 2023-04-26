`timescale 1ns/1ps

module var_register #(parameter WIDTH = 4) (input wire clk, input wire [WIDTH-1:0] din, output reg [WIDTH-1:0] dout);
    always @(posedge clk) begin
        dout <= din;
    end
endmodule

module var_multiplier #(parameter WIDTH = 4) (input wire [WIDTH-1:0] in1, input wire [WIDTH-1:0] in2, output wire [(2*WIDTH)-1:0] out);
    assign out = in1 * in2;
endmodule

module var_adder #(parameter WIDTH = 4) (input wire [WIDTH-1:0] in1, input wire [WIDTH-1:0] in2, output wire [WIDTH:0] out);
    assign out = in1 + in2;
endmodule
