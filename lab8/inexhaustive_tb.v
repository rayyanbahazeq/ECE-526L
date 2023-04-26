`timescale 1ns/1ps

module tb_top_level_inexhaustive();

parameter WIDTH = 4;
reg clk;
reg [WIDTH-1:0] data_in, c1, c2, c3, c4;
wire [2*WIDTH+1:0] final_sum;


top_level #(
    .WIDTH(WIDTH)
) top_level_inst (
    .clk(clk),
    .data_in(data_in),
    .c1(c1),
    .c2(c2),
    .c3(c3),
    .c4(c4),
    .final_sum(final_sum)
);


always
    #5 clk = ~clk;

initial begin
    $vcdpluson;
    clk = 0;
    data_in = 0;
    c1 = 0;
    c2 = 0;
    c3 = 0;
    c4 = 0;

    #10

$monitor("At time %t: data_in=%d c1=%d c2=%d c3=%d c4=%d final_sum=%d", $time, data_in, c1, c2, c3, c4, final_sum);


    #10 data_in = 4'b0000; c1 = 4'b0000; c2 = 4'b0000; c3 = 4'b0000; c4 = 4'b0000;

    #40 data_in = 4'b1111; c1 = 4'b1111; c2 = 4'b1111; c3 = 4'b1111; c4 = 4'b1111;

    #40 data_in = 4'b1010; c1 = 4'b1100; c2 = 4'b0110; c3 = 4'b1001; c4 = 4'b0110;
    
    #10 $finish;
end

endmodule
