`timescale 1ns / 1ps



module ethernet_tb(

    );
    
    
   
   localparam CLK_PERIOD = 5; 
   localparam RST_COUNT = 10; 
   
   logic clk = 0;
   logic rst;
   
   always begin
      clk   = #(CLK_PERIOD/2) ~clk;
   end
   
   
   initial begin
      rst = 1;
      #(RST_COUNT*CLK_PERIOD);
      @(posedge clk);
      rst = 0;
   end


 ethernet_top ethernet_top_i(
    .CLK(clk),
    .RST_N(~rst)
    );
    
endmodule
