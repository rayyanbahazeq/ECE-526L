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
    #100 DATA = 0; RST = 0;
    #100 RST = 1;
    #100 DATA = 1; ENA = 1;
    #100 if (DATA === OUT[7:0])
      $display("Test 1 passed!");
    else $display("Test 1 failed!");
    #100 DATA = 255;
    #100 if (DATA === OUT[7:0])
      $display("Test 2 passed!");
    else $display("Test 2 failed!");
    #100 RST = 0;
    #100 if (8'b0 === OUT[7:0])
      $display("Test 3 passed!");
    else $display("Test 3 failed!");
    $finish;
  end
endmodule
