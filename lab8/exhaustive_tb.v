`timescale 1ns/1ps

module tb_top_level_exhaustive();

//`define FORCE_ERROR

parameter WIDTH = 4;
reg clk;
reg [WIDTH-1:0] data_in, c1, c2, c3, c4;
wire [2*WIDTH+1:0] final_sum;


top_level #(
    .WIDTH(WIDTH)
) top_level_inst (
    .clk(clk),
    .data_in(data_in),
    .c1(c1),
    .c2(c2),
    .c3(c3),
    .c4(c4),
    .final_sum(final_sum)
);


always
    #5 clk = ~clk;


reg [WIDTH-1:0] data_in_reg1, data_in_reg2;
reg [2*WIDTH+1:0] non_hierarchical_sum;
reg [4:0] i, j, k, l, m;

always @(posedge clk) begin
    data_in_reg1 <= data_in;
    data_in_reg2 <= data_in_reg1;
end

always @(posedge clk) begin
    non_hierarchical_sum <= (data_in * c1 + data_in_reg1 * c2) + (data_in_reg2 * c3 + data_in * c4);
end


`ifdef FORCE_ERROR;
initial begin
    $display("Forcing error at simulation time 1920");
    #31457000 $monitoron;
    #280 force top_level_inst.final_sum = 1'b1;
    #280 $monitoroff;
    #1940 release top_level_inst.final_sum;

end
`endif

initial begin
    $vcdpluson;
    clk = 0;
    data_in = 0;
    c1 = 0;
    c2 = 0;
    c3 = 0;
    c4 = 0;

    $monitor("At time %t: data_in=%d c1=%d c2=%d c3=%d c4=%d final_sum=%d non_hierarchical_sum=%d", $time, data_in, c1, c2, c3, c4, final_sum, non_hierarchical_sum);

    for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
            for (k = 0; k < 16; k = k + 1) begin
                for (l = 0; l < 16; l = l + 1) begin
                    for (m = 0; m < 16; m = m + 1) begin
                        data_in = i;
                        c1 = j;
                        c2 = k;
                        c3 = l;
                        c4 = m;

                        #40;
                        if (final_sum !== non_hierarchical_sum) begin
                            $display("Error at time %t: data_in=%d c1=%d c2=%d c3=%d c4=%d final_sum=%d expected_sum=%d", $time, data_in, c1, c2, c3, c4, final_sum, non_hierarchical_sum);
                            $finish;
                        end
                        if (i == 15 && c1 == 15 && c2 == 15 && c3 == 15 && c4 == 15) begin
                            $display("All test vectors passed!");
                            $finish;
                        end
                        if ((i == 0 && j == 0 && k == 0 && l == 0) || (i == 15 && j == 15 && k == 15 && l == 15)) begin
                            $monitoron;
                        end else if (i == 0 && j == 0 && k == 0 && l == 1 && m == 0) begin
                            $monitoroff;
                        end
                    end
                end
            end
        end
    end
end
endmodule
