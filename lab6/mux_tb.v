`timescale 1ns/100ps
module testbench;


  localparam WIDTH1 = 1;
  localparam WIDTH2 = 4;
  localparam WIDTH3 = 5;
  localparam WIDTH4 = 6;
  
 
  reg [WIDTH4-1:0] A;
  reg [WIDTH4-1:0] B;
  reg SEL;
  
  
  wire [WIDTH4-1:0] OUT1;
  wire [WIDTH2-1:0] OUT2;
  wire [WIDTH3-1:0] OUT3;
  wire [WIDTH4-1:0] OUT4;
  
  
  mux #(.WIDTH(WIDTH1)) M1 (.A({A[0], B[0]}), .SEL(SEL), .OUT(OUT1[0]));
  mux #(.WIDTH(WIDTH2)) M2 (.A({A[4], A[3], A[2], A[1]}), .B({B[4], B[3], B[2], B[1]}), .SEL(SEL), .OUT(OUT2));
  mux #(.WIDTH(WIDTH3)) M3 (.A(A[6:2]), .B(B[6:2]), .SEL(SEL), .OUT(OUT3));
  mux M4 (.A(A), .B(B), .SEL(SEL), .OUT(OUT4));
  
  initial begin
    
    A = 6'b101010;
    B = 6'b011001;
    SEL = 1'b0;
    #10 SEL = 1'b1;
    #10 SEL = 1'bx;
    #10 A = 6'b101010;
    B = 6'b101010;
    #10 A = 6'b111000;
    B = 6'b000111;
    #10 $finish;
  end
  
  
  always @(A or B or SEL or OUT1 or OUT2 or OUT3 or OUT4) begin
    $display("SEL=%b A=%b B=%b OUT1=%b OUT2=%b OUT3=%b OUT4=%b", SEL, A, B, OUT1, OUT2, OUT3, OUT4);
  end
  
endmodule

