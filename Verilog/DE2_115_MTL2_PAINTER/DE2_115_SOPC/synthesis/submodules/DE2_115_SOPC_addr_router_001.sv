// (C) 2001-2013 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/12.1sp1/ip/merlin/altera_merlin_router/altera_merlin_router.sv.terp#1 $
// $Revision: #1 $
// $Date: 2012/10/10 $
// $Author: swbranch $

// -------------------------------------------------------
// Merlin Router
//
// Asserts the appropriate one-hot encoded channel based on 
// either (a) the address or (b) the dest id. The DECODER_TYPE
// parameter controls this behaviour. 0 means address decoder,
// 1 means dest id decoder.
//
// In the case of (a), it also sets the destination id.
// -------------------------------------------------------

`timescale 1 ns / 1 ns

module DE2_115_SOPC_addr_router_001_default_decode
  #(
     parameter DEFAULT_CHANNEL = 7,
               DEFAULT_DESTID = 7 
   )
  (output [106 - 103 : 0] default_destination_id,
   output [13-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[106 - 103 : 0];
  generate begin : default_decode
    if (DEFAULT_CHANNEL == -1)
      assign default_src_channel = '0;
    else
      assign default_src_channel = 13'b1 << DEFAULT_CHANNEL;
  end
  endgenerate

endmodule


module DE2_115_SOPC_addr_router_001
(
    // -------------------
    // Clock & Reset
    // -------------------
    input clk,
    input reset,

    // -------------------
    // Command Sink (Input)
    // -------------------
    input                       sink_valid,
    input  [117-1 : 0]    sink_data,
    input                       sink_startofpacket,
    input                       sink_endofpacket,
    output                      sink_ready,

    // -------------------
    // Command Source (Output)
    // -------------------
    output                          src_valid,
    output reg [117-1    : 0] src_data,
    output reg [13-1 : 0] src_channel,
    output                          src_startofpacket,
    output                          src_endofpacket,
    input                           src_ready
);

    // -------------------------------------------------------
    // Local parameters and variables
    // -------------------------------------------------------
    localparam PKT_ADDR_H = 67;
    localparam PKT_ADDR_L = 36;
    localparam PKT_DEST_ID_H = 106;
    localparam PKT_DEST_ID_L = 103;
    localparam ST_DATA_W = 117;
    localparam ST_CHANNEL_W = 13;
    localparam DECODER_TYPE = 0;

    localparam PKT_TRANS_WRITE = 70;
    localparam PKT_TRANS_READ  = 71;

    localparam PKT_ADDR_W = PKT_ADDR_H-PKT_ADDR_L + 1;
    localparam PKT_DEST_ID_W = PKT_DEST_ID_H-PKT_DEST_ID_L + 1;




    // -------------------------------------------------------
    // Figure out the number of bits to mask off for each slave span
    // during address decoding
    // -------------------------------------------------------
    localparam PAD0 = log2ceil(64'h800 - 64'h0);
    localparam PAD1 = log2ceil(64'h1800 - 64'h1000);
    localparam PAD2 = log2ceil(64'h1880 - 64'h1800);
    localparam PAD3 = log2ceil(64'h18a0 - 64'h1880);
    localparam PAD4 = log2ceil(64'h18c0 - 64'h18a0);
    localparam PAD5 = log2ceil(64'h18d0 - 64'h18c0);
    localparam PAD6 = log2ceil(64'h18e0 - 64'h18d0);
    localparam PAD7 = log2ceil(64'h18f0 - 64'h18e0);
    localparam PAD8 = log2ceil(64'h18f8 - 64'h18f0);
    localparam PAD9 = log2ceil(64'h600000 - 64'h400000);
    localparam PAD10 = log2ceil(64'h1000100 - 64'h1000000);
    localparam PAD11 = log2ceil(64'h2800000 - 64'h2000000);
    localparam PAD12 = log2ceil(64'h10000000 - 64'h8000000);
    // -------------------------------------------------------
    // Work out which address bits are significant based on the
    // address range of the slaves. If the required width is too
    // large or too small, we use the address field width instead.
    // -------------------------------------------------------
    localparam ADDR_RANGE = 64'h10000000;
    localparam RANGE_ADDR_WIDTH = log2ceil(ADDR_RANGE);
    localparam OPTIMIZED_ADDR_H = (RANGE_ADDR_WIDTH > PKT_ADDR_W) ||
                                  (RANGE_ADDR_WIDTH == 0) ?
                                        PKT_ADDR_H :
                                        PKT_ADDR_L + RANGE_ADDR_WIDTH - 1;
    localparam RG = RANGE_ADDR_WIDTH-1;

      wire [PKT_ADDR_W-1 : 0] address = sink_data[OPTIMIZED_ADDR_H : PKT_ADDR_L];

    // -------------------------------------------------------
    // Pass almost everything through, untouched
    // -------------------------------------------------------
    assign sink_ready        = src_ready;
    assign src_valid         = sink_valid;
    assign src_startofpacket = sink_startofpacket;
    assign src_endofpacket   = sink_endofpacket;

    wire [PKT_DEST_ID_W-1:0] default_destid;
    wire [13-1 : 0] default_src_channel;




    DE2_115_SOPC_addr_router_001_default_decode the_default_decode(
      .default_destination_id (default_destid),
      .default_src_channel (default_src_channel)
    );

    always @* begin
        src_data    = sink_data;
        src_channel = default_src_channel;

        src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = default_destid;
        // --------------------------------------------------
        // Address Decoder
        // Sets the channel and destination ID based on the address
        // --------------------------------------------------

        // ( 0x0 .. 0x800 )
        if ( {address[RG:PAD0],{PAD0{1'b0}}} == 28'h0 ) begin
            src_channel = 13'b0000000000100;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 2;
        end

        // ( 0x1000 .. 0x1800 )
        if ( {address[RG:PAD1],{PAD1{1'b0}}} == 28'h1000 ) begin
            src_channel = 13'b0000000000001;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 0;
        end

        // ( 0x1800 .. 0x1880 )
        if ( {address[RG:PAD2],{PAD2{1'b0}}} == 28'h1800 ) begin
            src_channel = 13'b0000001000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 6;
        end

        // ( 0x1880 .. 0x18a0 )
        if ( {address[RG:PAD3],{PAD3{1'b0}}} == 28'h1880 ) begin
            src_channel = 13'b1000000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 12;
        end

        // ( 0x18a0 .. 0x18c0 )
        if ( {address[RG:PAD4],{PAD4{1'b0}}} == 28'h18a0 ) begin
            src_channel = 13'b0010000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 10;
        end

        // ( 0x18c0 .. 0x18d0 )
        if ( {address[RG:PAD5],{PAD5{1'b0}}} == 28'h18c0 ) begin
            src_channel = 13'b0100000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 11;
        end

        // ( 0x18d0 .. 0x18e0 )
        if ( {address[RG:PAD6],{PAD6{1'b0}}} == 28'h18d0 ) begin
            src_channel = 13'b0001000000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 9;
        end

        // ( 0x18e0 .. 0x18f0 )
        if ( {address[RG:PAD7],{PAD7{1'b0}}} == 28'h18e0 ) begin
            src_channel = 13'b0000000100000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 5;
        end

        // ( 0x18f0 .. 0x18f8 )
        if ( {address[RG:PAD8],{PAD8{1'b0}}} == 28'h18f0 ) begin
            src_channel = 13'b0000000010000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 4;
        end

        // ( 0x400000 .. 0x600000 )
        if ( {address[RG:PAD9],{PAD9{1'b0}}} == 28'h400000 ) begin
            src_channel = 13'b0000000000010;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 1;
        end

        // ( 0x1000000 .. 0x1000100 )
        if ( {address[RG:PAD10],{PAD10{1'b0}}} == 28'h1000000 ) begin
            src_channel = 13'b0000100000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 8;
        end

        // ( 0x2000000 .. 0x2800000 )
        if ( {address[RG:PAD11],{PAD11{1'b0}}} == 28'h2000000 ) begin
            src_channel = 13'b0000000001000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 3;
        end

        // ( 0x8000000 .. 0x10000000 )
        if ( {address[RG:PAD12],{PAD12{1'b0}}} == 28'h8000000 ) begin
            src_channel = 13'b0000010000000;
            src_data[PKT_DEST_ID_H:PKT_DEST_ID_L] = 7;
        end

end


    // --------------------------------------------------
    // Ceil(log2()) function
    // --------------------------------------------------
    function integer log2ceil;
        input reg[65:0] val;
        reg [65:0] i;

        begin
            i = 1;
            log2ceil = 0;

            while (i < val) begin
                log2ceil = log2ceil + 1;
                i = i << 1;
            end
        end
    endfunction

endmodule


