`timescale 1ns/1ps
module fifo #(parameter WIDTH = 8, DEPTH = 32, ALMOST = 2)
(
    input wire clk,
    input wire rst_n,
    input wire wr_en,
    input wire rd_en,
    input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out,
    output wire empty,
    output wire almost_empty,
    output wire full,
    output wire almost_full,
    output reg valid,
    output reg overflow,
    output reg underflow,
    output reg [31:0] count
);

    reg [WIDTH-1:0] memory [0:DEPTH-1];
    reg [$clog2(DEPTH)-1:0] wr_ptr = 0;
    reg [$clog2(DEPTH)-1:0] rd_ptr = 0;
    reg [WIDTH-1:0] data_out_reg = 0;
    wire [$clog2(DEPTH)-1:0] next_wr_ptr = wr_ptr + 1;
    wire [$clog2(DEPTH)-1:0] next_rd_ptr = rd_ptr + 1;
    wire wr_overflow = (wr_en && full);
    wire rd_underflow = (rd_en && empty);
   
    assign empty = (wr_ptr == rd_ptr);
    assign almost_empty = (count <= ALMOST) ? 1 : empty;
    assign full = (next_wr_ptr == rd_ptr);
    assign almost_full = ((DEPTH - count) <= ALMOST) ? 1 : full;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            overflow <= 0;
            underflow <= 0;
            valid <= 0;
            data_out_reg <= 0;
        end else begin
            if (wr_en && !wr_overflow) begin
                memory[wr_ptr] <= data_in;
                wr_ptr <= next_wr_ptr;
            end
            if (rd_en && !rd_underflow) begin
                data_out_reg <= memory[rd_ptr];
                rd_ptr <= next_rd_ptr;
            end
            overflow <= wr_overflow;
            underflow <= rd_underflow;
            valid <= rd_en && !rd_underflow;
        end
    end
    assign data_out = data_out_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 0;
        end else if (wr_en && !full && rd_en && !empty) begin
        end else if (wr_en && !full) begin
            count <= count + 1;
        end else if (rd_en && !empty) begin
            count <= count - 1;
        end
    end
endmodule


