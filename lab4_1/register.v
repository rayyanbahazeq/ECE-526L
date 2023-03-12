`timescale 1ns/100ps
`include "MUX2_1.v"
`include "dff.v"

module register(
  input ena, clk, rst,
  input [7:0] data,
  output [7:0] reg_out
);

  wire [7:0] mux_out;
  MUX2_1 MUX(
    .OUT(mux_out),
    .A(reg_out),
    .B(data),
    .SEL(ena)
  );

  dff DFF[7:0](
    .q(reg_out),
    .clock(clk),
    .data(mux_out),
    .clear(rst)
  );

endmodule


