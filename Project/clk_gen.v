`timescale 1ns/1ps
module clk_gen(
    input wire clk_in,
    input wire reset,
    output wire clk_out1,
    output wire clk_out2,
    output wire locked
);

    reg locked_reg = 0;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            locked_reg <= 0;
        end else begin
            locked_reg <= 1;
        end
    end

    assign locked = locked_reg;
    assign clk_out1 = clk_in;
    assign clk_out2 = clk_in;
endmodule

