`timescale 1ns/1ps

module testbench;
    reg clk;
    reg wr_en;
    reg rd_en;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire empty;
    wire almost_empty;
    wire full;
    wire almost_full;
    wire valid;
    wire underflow;
    wire overflow;
    wire [31:0] count;

    fifo #(8, 32, 2) U1 (
        .clk(clk),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .rst_n(1'b1),
        .data_out(data_out),
        .empty(empty),
        .almost_empty(almost_empty),
        .full(full),
        .almost_full(almost_full),
        .valid(valid),
        .underflow(underflow),
        .overflow(overflow),
        .count(count)
    );

    initial begin
        $vcdpluson;
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("At time %t, data_in = %d, data_out = %d, valid = %b, empty = %b, almost_empty = %b, full = %b, almost_full = %b, underflow = %b, overflow = %b, count = %d",
            $time, data_in, data_out, valid, empty, almost_empty, full, almost_full, underflow, overflow, count);
    end

    initial begin
        wr_en = 0; rd_en = 0; data_in = 0;
        #10;
    end

    initial begin
       
        for (int i = 0; i < 32; i = i + 1) begin
            #10;
            wr_en = 1;
            data_in = i;
        end
        #10 wr_en = 0;
    end

    initial begin
       
        #350;
        rd_en = 1;
        for (int i = 0; i < 32; i = i + 1) begin
            #10;
            if (data_out !== i) $display("Mismatch at location %0d, Expected: %0d, Got: %0d", i, i, data_out);
        end
        #10 rd_en = 0;
    end

    initial begin
    
        #720;
        wr_en = 1;
        data_in = 33;
        rd_en = 1;
        #10;
        if (data_out !== 0) $display("Mismatch on simultaneous read/write. Expected: 0, Got: %0d", data_out);
        wr_en = 0;
        rd_en = 0;
        #10 $finish;
    end

    initial begin
        
        #380;
        if (!empty || full || almost_empty || almost_full || valid || underflow || overflow) $display("Flag test mismatch. At least one flag is not behaving as expected.");
        wr_en = 1; 
        data_in = 34;
        #10 wr_en = 0;

   
        #10;
        rd_en = 1;
        #10 rd_en = 0;

    
        #10 wr_en = 1;
        data_in = 35;
        #10 wr_en = 0;

    
        #10 rd_en = 1;
        #10 rd_en = 0;

  
        #10 wr_en = 1;
        data_in = 36;
        #10 wr_en = 0;
        #10 rd_en = 1;

   
        #10;
        if (count !== 31) $display("Mismatch in count. Expected: 31, Got: %d", count);
        if (!valid) $display("Valid signal not asserted.");

        rd_en = 0;
        #10 $finish;
   end
endmodule
