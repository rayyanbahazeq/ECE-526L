/**************************************************************************
 * ***
 * ***
 * *** ECE 526 L Experiment #2 ***                                         ***
 * *** Experiment #2     ***                ***
 * *** ***********************************************************************
 * *** Filename: lab3_2.v Created by Abdul Rahman Bahazeq, Feb 26 2023            ***
 * *** ---   Initial Release  ---
 * ***
 *
 * ***************************************************************************/
`timescale 1ns/1ns

`define TIME_DELAY_1    3
`define TIME_DELAY_2    4
`define TIME_DELAY_3    5
`define FAN_OUT_1       0.5
`define FAN_OUT_2       0.8
`define FAN_OUT_3       1.0
`define PRIMARY_OUT     2.0


module SR_Latch2 (Q, Qnot, s0, s1, r0, r1);
    output Q, Qnot;

    input s0, s1, r0, r1;

    nand #(`TIME_DELAY_3 + `PRIMARY_OUT) NAND1(Q, s0, s1, Qnot);
    nand #(`TIME_DELAY_3 + `PRIMARY_OUT) NAND2(Qnot, r0, r1, Q);

endmodule

