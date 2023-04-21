`timescale 1ns/1ps

module register_file_tb(data_io);

    
    localparam DATA_WIDTH = 8;
    localparam ADDR_WIDTH = 5;

   
    reg output_enable;
    reg chip_select;
    reg write_strobe;
    reg [ADDR_WIDTH-1:0] address;
    inout [DATA_WIDTH-1:0] data_io;
    reg [DATA_WIDTH-1:0] data_reg;
    reg [31:0] i;

    
    register_file #(DATA_WIDTH, ADDR_WIDTH) register_file_inst(
        .output_enable(output_enable),
        .chip_select(chip_select),
        .write_strobe(write_strobe),
        .address(address),
        .data(data_io)
    );
    reg passed;
    reg [511:0] monitor_string;    
    assign data_io = data_reg;

    
    initial begin
        
        $vcdplusmemon;
        $vcdpluson;
        
        passed = 1;

       
        output_enable = 1'b0;
        chip_select = 1'b1;
	write_strobe = 1'b0;
	address = 0;
        data_reg = 'bz;

        
        i = 0;
        while (i < 32) begin
            
            #10 chip_select = 1'b0;
            #10 write_strobe = 1'b0;
            #10 address = i;
            #10 data_reg = i;
            #10 write_strobe = 1'b1;
            #10 chip_select = 1'b1;

            i=i+1;
        end

        
        #10 chip_select = 1'b0;
        #10 data_reg = 'bz;
        i=0;
        while (i < 32) begin
           
            #10 output_enable = 1'b1;
            #10 address = i;
            #10;
            if (data_io !== i) begin
                $display("Test B: FAILED, expected: %0d, got: %0d", i, data_io);
                passed = 0;
            end

            i=i+1;
        end
        if (data_io !== 31) begin
            $display("Test B: FAILED, expected: %0d, got: %0d", i, data_io);
            passed = 0;
        end else if (passed) begin
            $display("Test A: PASSED\nTest B: PASSED");
        end
        #10 chip_select = 1'b1;


      
        #10 chip_select = 1'b0; 
        #10 chip_select = 1'b1; 
        #10 address = 3;
        #10;

        if (data_io == 3) begin
            $display("Test C: FAILED, expected: 'bz, got: %0d", data_io);
            passed = 0;
        end else begin
            $display("Test C: PASSED");
        end

       
        #10 chip_select = 1'b1;
        #10 output_enable = 1'b0;
        #10;

        if (data_io != 'bz) begin
            $display("Test D: FAILED, expected: 'bz, got: %0d", data_io);
            passed = 0;
        end else begin
            $display("Test D: PASSED");
        end

        
        if (passed)
            $display("Test E: PASSED");

        
        i=0;
        while (i < DATA_WIDTH) begin
           
            #10 chip_select = 1'b0;
            #10 output_enable = 1'b0;
            #10 write_strobe = 1'b0;
            #10 address = i;
            #10 data_reg = 1 << i;
            #10 write_strobe = 1'b1;

            
            #10 data_reg = 'bz;
            #10 output_enable = 1'b1;
            #10;
            if (data_io !== (1 << i)) begin
                $display("Test F: FAILED at address %0d, expected: %0b, got: %0b", i, (1 << i), data_io);
                passed = 0;
            end 

            i=i+1;
        end
        if (passed)
            $display("Test F: PASSED");


        
        #10 $finish;
    end

endmodule            
