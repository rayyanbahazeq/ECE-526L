`timescale 1ns/100ps

module aasd_reset (
    input           rst,   
    input           clk,    
    output          aasd_rst  
);
    reg q;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            aasd_rst <= 1'b1;   
        end else begin
            q <= rst;
            aasd_rst <= q;    
        end
    end

endmodule

