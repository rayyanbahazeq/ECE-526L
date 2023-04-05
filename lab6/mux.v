`timescale 1ns/1ps

module mux #(
  parameter WIDTH = 1
) (
  input [WIDTH-1:0] A,
  input [WIDTH-1:0] B,
  input SEL,
  output [WIDTH-1:0] OUT
);

  reg [WIDTH-1:0] MUX_OUT;
  integer i;

  always @(*) begin
    case (SEL)
      1'b0: MUX_OUT = A;
      1'b1: MUX_OUT = B;
      default: begin
        MUX_OUT = {WIDTH{1'bx}};
        for (i = 0; i < WIDTH; i=i+1) begin
          if (A[i] == B[i])
            MUX_OUT[i] = A[i];
        end
      end
    endcase
  end

  assign OUT = MUX_OUT;

endmodule
