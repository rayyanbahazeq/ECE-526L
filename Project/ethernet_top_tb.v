`timescale 1ns / 1ps

module ethernet_top_tb();

    localparam CLK_PERIOD = 5; 
    localparam RST_COUNT = 10; 

    logic clk = 0;
    logic rst_n;

    
    always begin
        clk = #(CLK_PERIOD/2) ~clk;
    end

   
    initial begin
        rst_n = 0;
        #(RST_COUNT*CLK_PERIOD);
        @(posedge clk);
        rst_n = 1;
    end

   
    logic ETH_MDC;
    wire  ETH_MDIO;
    logic ETH_RSTN;
    wire  ETH_CRSDV;
    logic ETH_RXERR;
    wire  [1:0] ETH_RXD;
    logic ETH_TXEN;
    logic [1:0] ETH_TXD;
    logic ETH_REFCLK;
    logic ETH_INTN;

  
    ethernet_top ethernet_top_i(
        .CLK(clk),
        .RST_N(rst_n),
        .ETH_MDC(ETH_MDC),
        .ETH_MDIO(ETH_MDIO),
        .ETH_RSTN(ETH_RSTN),
        .ETH_CRSDV(ETH_CRSDV),
        .ETH_RXERR(ETH_RXERR),
        .ETH_RXD(ETH_RXD),
        .ETH_TXEN(ETH_TXEN),
        .ETH_TXD(ETH_TXD),
        .ETH_REFCLK(ETH_REFCLK),
        .ETH_INTN(ETH_INTN)
    );

   
    always @(posedge clk) begin
        if (ETH_TXEN) begin
            $display("At time %t, Packet transmitted with data: %0h", $time, ETH_TXD);
        end
    end

  
    initial begin
        #100; ETH_INTN = 1;
        #100; ETH_INTN = 0;
    end

  
    initial begin
        #200; ETH_RXERR = 1;
        #100; ETH_RXERR = 0;
    end

    
    initial begin
        #500; CLK_PERIOD = 10;
        #500; CLK_PERIOD = 5;  
    end

    
    initial begin
        #300; s_axis_tdata = 16'h1234; 
        #300; s_axis_tdata = 16'h5678; 
    end

  
    initial begin
        #400; ETH_INTN = 1;
        #200; ETH_INTN = 0;
        #300; ETH_INTN = 1;
        #100; ETH_INTN = 0;
    end

   
    always @(posedge clk) begin
        $display("At time %t, ETH_INTN: %b, ETH_RXERR: %b", $time, ETH_INTN, ETH_RXERR);
    end

endmodule

