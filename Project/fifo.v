`timescale 1ns/1ps
module fifo(
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [7:0] data_in, 
    output reg [7:0] data_out,
    output reg empty,
    output reg full
);

    localparam DEPTH = 128; 
    localparam ADDR_WIDTH = 7;  

    reg [7:0] buffer [0:DEPTH-1]; 
    reg [ADDR_WIDTH:0] wr_ptr, rd_ptr;  

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            empty <= 1;
            full <= 0;
        end else begin
            if (wr_en && !full) begin
                buffer[wr_ptr] <= data_in;
                wr_ptr <= wr_ptr + 1;
            end
            if (rd_en && !empty) begin
                data_out <= buffer[rd_ptr];
                rd_ptr <= rd_ptr + 1;
            end
            empty <= (wr_ptr == rd_ptr);
            full <= (wr_ptr == rd_ptr - 1) || (wr_ptr == DEPTH-1 && rd_ptr == 0);
        end
    end
endmodule

