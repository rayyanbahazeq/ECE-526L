`timescale 1ns/100ps
`define TIME_DELAY_1    3
`define TIME_DELAY_2    4
`define TIME_DELAY_3    5
`define FAN_OUT_1       0.5
`define FAN_OUT_2       0.8
`define FAN_OUT_3       1.0
`define PRIMARY_OUT     2.0

module SR_Latch2 (
    output Q,
    output Qnot,
    input s0,
    input s1,
    input r0,
    input r1
);

    parameter INPUT_DELAY_1 = `TIME_DELAY_3;
    parameter INPUT_DELAY_2 = `TIME_DELAY_3;
    parameter OUTPUT_DELAY_1 = `PRIMARY_OUT;
    parameter OUTPUT_DELAY_2 = `PRIMARY_OUT;

    nand #(INPUT_DELAY_1 + OUTPUT_DELAY_1) NAND1 (Q, s0, s1, Qnot);
    nand #(INPUT_DELAY_2 + OUTPUT_DELAY_2) NAND2 (Qnot, r0, r1, Q);

endmodule 
