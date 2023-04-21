`timescale 1ns/1ps
module register_file  #(parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 5)(
    input output_enable,
    input chip_select,
    input write_strobe,
    input [ADDR_WIDTH-1:0] address,
    inout [DATA_WIDTH-1:0] data
);

localparam MEM_SIZE = 2** ADDR_WIDTH;
reg [DATA_WIDTH-1:0] memory [0:MEM_SIZE-1];
reg [DATA_WIDTH-1:0] data_reg;
integer i;


initial begin
    for (i = 0; i <  2**ADDR_WIDTH;i =  i + 1) begin
        memory[i] = 0;
    end
end


always @ (posedge write_strobe) begin
    if (!chip_select && !output_enable) begin
        memory[address] <= data;
    end
end

wire read_enable;
assign read_enable = (!chip_select && output_enable);


always @ (*) begin
    for (i = 0; i < DATA_WIDTH;i =  i + 1) begin
        if (read_enable) begin
            data_reg[i] <= memory[address][i];
        end else begin
            data_reg[i] <= 1'bz;
        end
    end
end

assign data = data_reg;

endmodule
