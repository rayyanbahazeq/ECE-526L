`timescale 1ns / 1ps
import ethernet_header_pkg::*;

module eth_header_gen
  #(
    parameter [47:0] SOURCE_MAC = 48'he86a64e7e830,
    parameter [47:0] DEST_MAC = 48'he86a64e7e829,
    parameter [15:0] PACKET_PAYLOAD_BYTES = 128

    )
   (

     output ethernet_header output_header

    );


   ethernet_header header;

  
   endian_switch #( .BYTE_SIZE(8), .INPUT_BYTES(6) ) endian_switch_src_mac ( .in(SOURCE_MAC), .out_array(header.mac_source) );
   endian_switch #( .BYTE_SIZE(8), .INPUT_BYTES(6) ) endian_switch_dest_mac ( .in(DEST_MAC), .out_array(header.mac_destination) );
   endian_switch #( .BYTE_SIZE(8), .INPUT_BYTES(2) ) endian_switch_ipv4_length ( .in(PACKET_PAYLOAD_BYTES), .out_array(header.eth_type_length));

   assign output_header = header;

endmodule
