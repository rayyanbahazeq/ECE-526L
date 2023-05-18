`timescale 1ns/1ps
module endian_switch
    #(
    parameter BYTE_SIZE = 8,
    parameter INPUT_BYTES = 4
    )
    (
    input [INPUT_BYTES*BYTE_SIZE-1:0] in,
    
   
    output [INPUT_BYTES*BYTE_SIZE-1:0] out,
    output [INPUT_BYTES-1:0][BYTE_SIZE-1:0] out_array
    
    );


  
   localparam NUM_BYTES = INPUT_BYTES;

  
   genvar             i;
   generate
      for (i = 1;i<=NUM_BYTES;i++) begin : endian_switch_for 
     
         assign out[i*BYTE_SIZE-1 -: BYTE_SIZE] = in[(NUM_BYTES-i+1)*BYTE_SIZE-1 -: BYTE_SIZE];
         
         
         assign out_array[i-1] = in[(NUM_BYTES-i+1)*BYTE_SIZE-1 -: BYTE_SIZE];
      end
   endgenerate




endmodule
