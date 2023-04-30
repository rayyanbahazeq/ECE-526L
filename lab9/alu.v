`timescale 1ns/100ps

module alu #(
    parameter WIDTH = 8) (
    input CLK, EN, OE,
    input [3:0] OPCODE,
    input [WIDTH-1:0] A, B,
    output reg [WIDTH-1:0] ALU_OUT,
    output reg CF, OF, SF, ZF
);

   
    localparam ADD_OP  = 4'b0010;
    localparam SUB_OP  = 4'b0011;
    localparam AND_OP  = 4'b0100;
    localparam OR_OP   = 4'b0101;
    localparam XOR_OP  = 4'b0110;
    localparam NOTA_OP = 4'b0111;
    
`ifdef SIGNED_OPERANDS
    reg signed [WIDTH-1:0] result;
    reg signed [WIDTH:0] ext_result;
`else
    reg [WIDTH-1:0] result;
    reg [WIDTH:0] ext_result;
`endif

    always @(posedge CLK) begin
        if (EN) begin
            case (OPCODE)
                ADD_OP: begin
`ifdef SIGNED_OPERANDS
                    ext_result = $signed({1'b0, A}) + $signed({1'b0, B});
`else
                    ext_result = {1'b0, A} + {1'b0, B};
`endif
                    result = ext_result[WIDTH-1:0];
                    CF = ext_result[WIDTH];
                    OF = (A[WIDTH-1] == B[WIDTH-1]) && (A[WIDTH-1] != result[WIDTH-1]);
                end
                
                SUB_OP: begin
`ifdef SIGNED_OPERANDS
                    ext_result = $signed({1'b0, A}) - $signed({1'b0, B});
`else
                    ext_result = {1'b0, A} - {1'b0, B};
`endif
                    result = ext_result[WIDTH-1:0];
                    CF = (A < B) ? 1 : 0;
                    OF = (A[WIDTH-1] != B[WIDTH-1]) && (A[WIDTH-1] != result[WIDTH-1]);
                end
                
                AND_OP: result = A & B;
                OR_OP: result = A | B;
                XOR_OP: result = A ^ B;
                NOTA_OP: result = ~A;
                default: ; 
            endcase
            
            SF = result[WIDTH-1];
            ZF = (result == 0) ? 1 : 0;
        end
    end
    
    always @(posedge CLK) begin
        if (OE) begin
            ALU_OUT = result;
        end
        else begin
            ALU_OUT = {WIDTH{1'bz}};
        end
    end

endmodule

