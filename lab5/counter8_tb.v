`timescale 1ns/100ps

module up_counter_tb;

  reg clk;
  reg rst;
  reg en;
  reg ld;
  reg [7:0] data;
  wire [7:0] count;

  up_counter uut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .ld(ld),
    .data(data),
    .count(count)
  );

    initial begin
    $vcdpluson; 
    clk = 0;
    rst = 1;
    en = 0;
    ld = 0;
    data = 8'd0;

    #200;

    rst = 0;
    #10;
    rst = 1;

    #200;

    en = 1;
    #50;
    repeat(8) begin
      #20;
    end

    ld = 1;
    data = 8'd240;
    #20;
    ld = 0;

    #200;

    en = 1;
    #150;

    en = 0;
    #10;

    ld = 1;
    data = 8'd0;
    #20;
    ld = 0;

    #200;

    en = 1;
    #150;

    en = 0;
    #10;

    ld = 1;
    data = 8'd240;
    rst = 0;
    #10;
    rst = 1;
    #20;
    ld = 0;

    #200;

    en = 1;
    #150;

    en = 0;
    #10;
 
    en = 1;
    #150;

    en = 0;
    #10;

    $finish;
  end
 
  always #5 clk = ~clk;

  always @(count)
  $display("Time %t: count = %d clk = %d rst = %d en = %d", $time, count, clk, rst, en);

endmodule

