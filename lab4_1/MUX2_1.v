`timescale 1 ns / 1 ns
module MUX2_1(OUT, A, B, SEL);
 // Port declarations
 output OUT;
 input A, B, SEL;
 //Internal variable declarations
 wire Al, B1, SEL_N;
 //The netlist
 not (SEL_N, SEL);
 and (A1, A, SEL_N);
 and (B1, B, SEL);
 or (OUT, A1, B1);
endmodule

