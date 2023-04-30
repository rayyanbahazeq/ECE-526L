`timescale 1ns/100ps
module tb_alu;
 //`define SIGNED_OPERANDS

    reg clk;
    reg en;
    reg oe;
    reg [3:0] opcode;
    reg [7:0] a, b;
    wire [7:0] alu_out;
    wire cf, of, sf, zf;

    
    alu uut (
        .CLK(clk), .EN(en), .OE(oe), .OPCODE(opcode),
        .A(a), .B(b),
        .ALU_OUT(alu_out), .CF(cf), .OF(of), .SF(sf), .ZF(zf)
    );

    
    function [31:0] opcode_name;
        input [3:0] opcode;
        begin
            case (opcode)
                4'b0010: opcode_name = "ADD    ";
                4'b0011: opcode_name = "SUB    ";
                4'b0100: opcode_name = "AND    ";
                4'b0101: opcode_name = "OR     ";
                4'b0110: opcode_name = "XOR    ";
                4'b0111: opcode_name = "NOT_A  ";
                default: opcode_name = "UNKNOWN";
            endcase
        end
    endfunction

   
    always begin
        #5 clk = ~clk;
    end


   
    initial begin

        $vcdpluson;       
        $monitor("opcode: %b, a: %d, b: %d, ALU_OUT: %d, CF: %b, OF: %b, SF: %b, ZF: %b", opcode, a, b, alu_out, cf, of, sf, zf);

       
        clk = 0;
        en = 1;
        oe = 1;
        opcode = 4'b0000;
        a = 8'b0000_0000;
        b = 8'b0000_0000;

       
        #5;
        opcode = 4'b0010;
        a = 8'b0101_0101;
        b = 8'b0011_1100;
        en = 1;
        oe = 1;
        #10;
        opcode = 4'b0011;
        a = 8'b1001_0011;
        b = 8'b0101_1010;
        en = 1;
        oe = 1;
        #10;
        opcode = 4'b0100;
        a = 8'b1100_1100;
        b = 8'b1010_1010;
        en = 1;
        oe = 1;
        #10;
        opcode = 4'b0101;
        a = 8'b1111_0000;
        b = 8'b0000_1111;
        en = 1;
        oe = 1;
        #10;
        opcode = 4'b0110;
        a = 8'b1010_1010;
        b = 8'b0101_0101;
        en = 1;
        oe = 1;
        #10;
        opcode = 4'b0111;
        a = 8'b1111_0000;
        b = 8'b0000_0000;
        en = 1;
        oe = 1;
        #10;

        opcode = 4'b0110;
        a = 8'b1100_1010;
        b = 8'b0101_1010;
        #10;


        opcode = 4'b0111;
        a = 8'b1010_0101;
        b = 8'b0000_0000;
        #10;


        opcode = 4'b0010;
        a = 8'b0111_1111;
        b = 8'b0000_0001;
        #10;
        opcode = 4'b0010;
        a = 8'b1000_0000;
        b = 8'b1000_0000;
        #10;


        opcode = 4'b0011;
        a = 8'b0000_0000;
        b = 8'b0000_0001;
        #10;
        opcode = 4'b0011;
        a = 8'b0111_1111;
        b = 8'b1000_0000;
        #10; 
  
        opcode = 4'b0010; a = 8'b1111_1111; b = 8'b0000_0001; #10;
        opcode = 4'b0011; a = 8'b0000_0000; b = 8'b0000_0001; #10;
        opcode = 4'b0011; a = 8'b0111_1111; b = 8'b1000_0000; #10;
        opcode = 4'b0010; a = 8'b1000_0000; b = 8'b1000_0000; #10;
        opcode = 4'b0100; a = 8'b1010_1010; b = 8'b0101_0101; #10;
        opcode = 4'b0101; a = 8'b1100_1100; b = 8'b0011_0011; #10;
        opcode = 4'b0110; a = 8'b1111_0000; b = 8'b0000_1111; #10;
        opcode = 4'b0111; a = 8'b1000_0001; b = 8'b0000_0000; #10;
      
       #10;
       $finish;
     end
endmodule


