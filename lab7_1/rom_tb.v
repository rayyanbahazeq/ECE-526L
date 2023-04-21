`timescale 1ns / 1ps

module tb_rom ();
    parameter Width = 8;
    parameter Depth = 5;
    reg oe_reg;
    reg cs_n_reg;
    reg [Depth-1:0] addr_reg;
    wire [Width-1:0] data_wire;
    reg [7:0] exp_values [5'h0:5'h1F];
    reg [Width - 1:0] temp_data_reg;
    integer i;

   
    rom #(.Width(Width), .Depth(Depth)) rom_inst (
        .oe(oe_reg),
        .cs_n(cs_n_reg),
        .addr(addr_reg),
        .data(data_wire)
    );

    initial begin
        $dumpfile("test.vcd");
        $dumpvars(0, tb_rom);
        $vcdpluson;
     
        $readmemh("rom_data.hex", rom_inst.memory);

        test_memory_initialization();

        test_unspecified_locations();

        scramble_and_write_bytes();

        test_memory_scrambling();

        print_memory_contents();

      
        $finish;
    end

    task test_memory_initialization;
        begin
            
            exp_values[5'h04] = 8'h58;
            exp_values[5'h05] = 8'hED;
            exp_values[5'h06] = 8'hB7;
            exp_values[5'h07] = 8'h34;
            exp_values[5'h08] = 8'hC9;
            exp_values[5'h09] = 8'h8F;
            exp_values[5'h0A] = 8'hA0;
            exp_values[5'h0B] = 8'h9B;
            exp_values[5'h0C] = 8'h65;
            exp_values[5'h0D] = 8'h11;
            exp_values[5'h0E] = 8'h03;
            exp_values[5'h0F] = 8'h4C;
            exp_values[5'h10] = 8'hDA;
            exp_values[5'h11] = 8'h7E;
            exp_values[5'h12] = 8'hF2;
            exp_values[5'h13] = 8'h26;
            exp_values[5'h14] = 8'h86;
            exp_values[5'h15] = 8'h95;
            exp_values[5'h16] = 8'hFD;
            exp_values[5'h17] = 8'hB1;
            exp_values[5'h1C] = 8'h12;
            exp_values[5'h1D] = 8'hAF;
            exp_values[5'h1E] = 8'h33;

            for (i = 0; i < 32; i = i + 1) begin
                oe_reg = 1'b1;
                cs_n_reg = 1'b0;
                addr_reg = i;
                #10;

                if (data_wire !== exp_values[i]) begin
                    $display("Memory Initialization Test: FAILED at address %0h, expected: %0h, got: %0h", i, exp_values[i], data_wire);
                end else begin
                    $display("Memory Initialization Test: PASSED at address %0h, expected: %0h, got: %0h", i, exp_values[i], data_wire);
                end
            end
        end
    endtask

    task test_unspecified_locations; 
        begin 
            for (i=24; i<28; i=i+1) begin 
                addr_reg=i; 
                oe_reg=1'b1; 
                cs_n_reg=1'b0; 
                #10; 
                if (data_wire !== 8'hFF) begin 
                    $display("Unspecified Locations Test: FAILED at address %0h, expected: X, got: %0h", i, data_wire); 
                end else begin 
                    $display("Unspecified Locations Test: PASSED at address %0h, expected: X, got: X", i); 
                end
            end
        end
    endtask

    task scramble_and_write_bytes;
        begin
            for (i = 0; i < 8; i = i + 1) begin
                addr_reg = 5'h10 + i;
                oe_reg = 1'b1;
                cs_n_reg = 1'b0;
                #10;
                temp_data_reg = {data_wire[0], data_wire[7], data_wire[1], data_wire[6], data_wire[2], data_wire[5], data_wire[3], data_wire[4]};
                oe_reg = 1'b0;
                #10;
               
                exp_values[addr_reg] = temp_data_reg;
                rom_inst.memory[addr_reg] = temp_data_reg;
            end
        end
    endtask

    task test_memory_scrambling;
        begin 

            exp_values[5'h10] = 8'h73;

            for (i = 0; i < 8; i = i + 1) begin
                addr_reg = 5'h10 + i;
                oe_reg = 1'b1;
                cs_n_reg = 1'b0;
                #10;

                if (data_wire !== exp_values[addr_reg]) begin
                    $display("Memory Scrambling Test: FAILED at address %0h, expected: %0h, got: %0h", 5'h10 + i, exp_values[addr_reg], data_wire);
                end else begin
                    $display("Memory Scrambling Test: PASSED at address %0h, expected: %0h, got: %0h", 5'h10 + i, exp_values[addr_reg], data_wire);
                end
            end
        end
    endtask

    task print_memory_contents;
        begin
            for (i = 0; i < 32; i = i + 1) begin
                addr_reg = i;
                oe_reg = 1'b1;
                cs_n_reg = 1'b0;
                #10;

                $display("Memory Contents at address %0h: %0h", i, data_wire);
            end
        end
    endtask

endmodule
          
