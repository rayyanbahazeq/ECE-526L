`timescale 1ns/1ps
module rom
    #(parameter Width = 8,
    parameter Depth = 5)(
    input oe,
    input cs_n,
    input [Depth-1:0] addr,
    output reg [Width-1:0] data
);

reg [Width-1:0] memory [0:2**Depth-1];


always @(*) begin
    case ({cs_n, oe})
        2'b01: data <= memory[addr];
        default: data <= 'bz;
    endcase
end

endmodule
