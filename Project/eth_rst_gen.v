`timescale 1ns / 1ps
module eth_rst_gen(
    input clk,
    input rst,
    output eth_clk_out,
    output eth_rst_out,
    output ETH_REFCLK,
    output ETH_RSTN
    );

    logic locked;
    logic eth_rst;
    logic eth_clk;

    clk_gen gen_50M
    (
        .clk_in(clk),
        .reset(rst),
        .clk_out1(eth_clk),
        .clk_out2(ETH_REFCLK),
        .locked(locked)
    );

`ifdef VCS_SIMULATOR
    localparam WAIT_CYCLES_50M = 20;
`else
    localparam WAIT_CYCLES_50M = 2000000; 
`endif

    logic [31:0] wait_counter_50M;

    always_ff@(posedge eth_clk) begin
        if (rst) begin
            eth_rst <= 1;
            wait_counter_50M <= 0;
        end
        else begin
            if (locked) begin
                if (wait_counter_50M < WAIT_CYCLES_50M-1) begin
                    eth_rst <= 1;
                    wait_counter_50M <= wait_counter_50M + 1;
                end
                else begin
                    eth_rst <= 0;
                end
            end
            else begin
                eth_rst <= 1;
                wait_counter_50M <= 0;
            end
        end
    end

    assign ETH_RSTN = ~eth_rst;
    assign eth_clk_out = eth_clk;
    assign eth_rst_out = eth_rst;

endmodule

