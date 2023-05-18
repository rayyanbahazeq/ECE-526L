`timescale 1ns / 1ps



module rst_gen(
    input clk_in,
    input rst_in,
    output rst_out

    );
    
    logic [2:0] rst_q;
    
    
   
    always_ff@(posedge clk_in) begin
       rst_q[0] <= rst_in;
       rst_q[2:1] <= rst_q[1:0];
       
    end
    
    
    assign rst_out = (rst_q == 0) ? 0 : 1;
    
    
endmodule
