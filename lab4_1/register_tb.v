`define MONITOR_STR_2 "%d: ena = %b, clk = %b, rst = %b, data = %b, out = %b"

module register_tb();

  reg ENA, CLK, RST;
  reg [7:0] DATA;
  wire [8:0] OUT;

  register reg1(
    .ena (ENA),
    .clk (CLK),
    .rst (RST),
    .data (DATA),
    .reg_out (OUT)
  );
 
  always #50 CLK = ~CLK;
  initial begin
    $monitor(`MONITOR_STR_2, $time, ENA, CLK, RST, DATA, OUT);

    $vcdpluson;
    $display("\t***Starting testbench for register***");
    #100 DATA = 0; RST = 0;
    #100 RST = 1;
    #100 DATA = 1; ENA = 1;
    #100 $monitor("Test 1: %d", OUT === DATA);
    #200 $display("Test 1 passed!");
    #200 DATA = 255;
    #300 $monitor("Test 2: %d", OUT === DATA);
    #400 $display("Test 2 passed!");
    #400 RST = 0;
    #500 $monitor("Test 3: %d", OUT === 8'b0);
    #600 $display("Test 3 passed!");
    #600 $finish;
  end
endmodule
