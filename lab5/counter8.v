`timescale 1ns/100ps 

module up_counter 
  (  
    input clk,
    input rst,
    input en,
    input ld,
    input [7:0] data,
    output reg [7:0] count
  );
  
  always @(posedge clk) begin
    if (!rst) begin
      count <= 8'b0;
    end else if (en == 1) begin
      if (ld == 1) begin
        count <= data;
      end else begin
        count <= count + 1;
      end
    end
  end
  
endmodule
