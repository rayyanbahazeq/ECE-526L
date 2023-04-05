`timescale 1ns/1ns

module testbench;

  parameter SIZE1 = 1;
  parameter SIZE2 = 4;
  parameter SIZE3 = 5;
  parameter SIZE4 = 6;

  reg [SIZE1-1:0] a1, b1;
  reg sel1;
  wire [SIZE1-1:0] out1;

  reg [SIZE2-1:0] a2, b2;
  reg sel2;
  wire [SIZE2-1:0] out2;

  reg [SIZE3-1:0] a3, b3;
  reg sel3;
  wire [SIZE3-1:0] out3;

  reg [SIZE4-1:0] a4, b4;
  reg sel4;
  wire [SIZE4-1:0] out4;

  mux #(.SIZE(SIZE1)) mux1(.A(a1), .B(b1), .SEL(sel1), .OUT(out1));
  mux #(.SIZE(SIZE2)) mux2(.A(a2), .B(b2), .SEL(sel2), .OUT(out2));
  mux #(.SIZE(SIZE3)) mux3(.A(a3), .B(b3), .SEL(sel3), .OUT(out3));
  mux #(.SIZE(SIZE4)) mux4(.A(a4), .B(b4), .SEL(sel4), .OUT(out4));

  initial begin
    $vcdpluson;
    $monitor("Time: %d, mux1: %b, mux2: %b, mux3: %b, mux4: %b", $time, out1, out2, out3, out4);

    // test 1: size1 
    $display("Test 1:");
    $display("a1=%b, b1=%b, sel1=%b, out1=%b", a1, b1, sel1, out1);
    a1 = 1'b0;
    b1 = 1'b1;
    sel1 = 1'b0;
    #10;
    if(out1 != 1'b0) $error("Test 1 Failed");
    sel1 = 1'b1;
    #10;
    if(out1 != 1'b1) $error("Test 1 Failed");
    a1 = 1'b1;
    sel1 = 1'b0;
    #10;
    if(out1 != 1'b1) $error("Test 1 Failed");
    a1 = 1'b0;
    b1 = 1'b0;
    sel1 = 1'bx;
    #10;
    if(out1 != 1'bx) $error("Test 1 Failed");

    // test 2: size2
    $display("Test 2:");
    $display("a2=%b, b2=%b, sel2=%b, out2=%b", a2, b2, sel2, out2);
    a2 = 2'b01;
    b2 = 2'b11;
    sel2 = 1'b0;
    #10;
    if(out2 != 2'b01) $error("Test 2 Failed");
    sel2 = 1'b1;
    #10;
    if(out2 != 2'b11) $error("Test 2 Failed");
    a2 = 2'b11;
    sel2 = 1'b0;
    #10;
    if(out2 != 2'b11) $error("Test 2 Failed");
    a2 = 2'b01;
    b2 = 2'b00;
    sel2 = 1'bx;
    #10;
    if(out2 != 2'bx) $error("Test 2 Failed");

    // test 3: size3
    $display("Test 3:");
    $display("a3=%b, b3=%b, sel3=%b, out3=%b", a3, b3, sel3, out3); 
    a3 = 3'b001;
    b3 = 3'b111;
    sel3 = 1'b0;
    #10;
    if(out3 != 3'b001) $error("Test 3 Failed");
    sel3 = 1'b1;
    #10;
    if(out3 != 3'b111) $error("Test 3 Failed");
    a3 = 3'b111;
    sel3 = 1'b0;
    #10; 
    if(out3 != 3'b111) $error("Test 3 Failed");
    a3 = 3'b001;
    b3 = 3'b000;
    sel3 = 1'bx;
    #10;
    if(out3 != 3'bx) $error("Test 3 Failed");

    // test 4: size4
    $display("Test 4:");
    $display("a4=%b, b4=%b, sel4=%b, out4=%b", a4, b4, sel4, out4);
    a4 = 4'b0001;
    b4 = 4'b1111;
    sel4 = 1'b0;
    #10;
    if(out4 != 4'b0001) $error("Test 4 Failed");
    sel4 = 1'b1;
    #10;
    if(out4 != 4'b1111) $error("Test 4 Failed");
    a4 = 4'b1111;
    sel4 = 1'b0;
    #10;
    if(out4 != 4'b1111) $error("Test 4 Failed");
    a4 = 4'b0001;
    b4 = 4'b0000;
    sel4 = 1'bx;
    #10;
    if(out4 != 4'bx) $error("Test 4 Failed");

  $display("All tests passed!");
  $finish;
  end 
endmodule
