// ============================================================================
// Copyright (c) 2014 by Terasic Technologies Inc.
// ============================================================================
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// ============================================================================
//           
//  Terasic Technologies Inc
//  9F., No.176, Sec.2, Gongdao 5th Rd, East Dist, Hsinchu City, 30070. Taiwan
//
//
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	Painter
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| vic chang         :| 08/17/11  :| Initial Revision
// --------------------------------------------------------------------

// Choose  DE2-115 version for USB interface 
`define V10    
//`define V20

module Painter(

	//////////// CLOCK //////////
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,

	//////////// Sma //////////
	SMA_CLKIN,
	SMA_CLKOUT,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	KEY,

	//////////// EX_IO //////////
	EX_IO,

	//////////// SW //////////
	SW,

	//////////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7,

	//////////// LCD //////////
	LCD_BLON,
	LCD_DATA,
	LCD_EN,
	LCD_ON,
	LCD_RS,
	LCD_RW,

	//////////// RS232 //////////
	UART_CTS,
	UART_RTS,
	UART_RXD,
	UART_TXD,

	//////////// PS2 for Keyboard and Mouse //////////
	PS2_CLK,
	PS2_CLK2,
	PS2_DAT,
	PS2_DAT2,

	//////////// SDCARD //////////
	SD_CLK,
	SD_CMD,
	SD_DAT,
	SD_WP_N,

	//////////// VGA //////////
	VGA_B,
	VGA_BLANK_N,
	VGA_CLK,
	VGA_G,
	VGA_HS,
	VGA_R,
	VGA_SYNC_N,
	VGA_VS,

	//////////// Audio //////////
	AUD_ADCDAT,
	AUD_ADCLRCK,
	AUD_BCLK,
	AUD_DACDAT,
	AUD_DACLRCK,
	AUD_XCK,

	//////////// I2C for EEPROM //////////
	EEP_I2C_SCLK,
	EEP_I2C_SDAT,

	//////////// I2C for Audio Tv-Decoder  //////////
	I2C_SCLK,
	I2C_SDAT,

	//////////// Ethernet 0 //////////
	ENET0_GTX_CLK,
	ENET0_INT_N,
	ENET0_LINK100,
	ENET0_MDC,
	ENET0_MDIO,
	ENET0_RST_N,
	ENET0_RX_CLK,
	ENET0_RX_COL,
	ENET0_RX_CRS,
	ENET0_RX_DATA,
	ENET0_RX_DV,
	ENET0_RX_ER,
	ENET0_TX_CLK,
	ENET0_TX_DATA,
	ENET0_TX_EN,
	ENET0_TX_ER,
	ENETCLK_25,

	//////////// Ethernet 1 //////////
	ENET1_GTX_CLK,
	ENET1_INT_N,
	ENET1_LINK100,
	ENET1_MDC,
	ENET1_MDIO,
	ENET1_RST_N,
	ENET1_RX_CLK,
	ENET1_RX_COL,
	ENET1_RX_CRS,
	ENET1_RX_DATA,
	ENET1_RX_DV,
	ENET1_RX_ER,
	ENET1_TX_CLK,
	ENET1_TX_DATA,
	ENET1_TX_EN,
	ENET1_TX_ER,

	//////////// TV Decoder //////////
	TD_CLK27,
	TD_DATA,
	TD_HS,
	TD_RESET_N,
	TD_VS,

     //////// USB 2.0 OTG //////////
`ifdef V10
     OTG_ADDR,
     OTG_CS_N,
     OTG_DACK_N,
     OTG_DATA,
     OTG_DREQ,
     OTG_FSPEED,
     OTG_INT,
     OTG_LSPEED,
     OTG_RD_N,
     OTG_RST_N,
     OTG_WE_N,
`endif    

`ifdef V20
   OTG_DATA,
   OTG_ADDR,
   OTG_CS_N,
   OTG_WR_N,
   OTG_RD_N,
   OTG_INT0,
   OTG_RST_N,    
`endif    

	//////////// IR Receiver //////////
	IRDA_RXD,
	
	//////////// SDRAM //////////
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_DQM,
	DRAM_RAS_N,
	DRAM_WE_N,

	//////////// SRAM //////////
	SRAM_ADDR,
	SRAM_CE_N,
	SRAM_DQ,
	SRAM_LB_N,
	SRAM_OE_N,
	SRAM_UB_N,
	SRAM_WE_N,

	//////////// Flash //////////
	FL_ADDR,
	FL_CE_N,
	FL_DQ,
	FL_OE_N,
	FL_RST_N,
	FL_RY,
	FL_WE_N,
	FL_WP_N,

	//HMSC, HSMC connect to MTLC
	//MTL
	LCD_B,
	LCD_DCLK,
	LCD_G,
	LCD_HSD,
	TOUCH_I2C_SCL,
	TOUCH_I2C_SDA,
	TOUCH_INT_n,
	LCD_R,
	LCD_VSD,
	
//	LCD_DITH,
//	LCD_MODE,
//	LCD_POWER_CTL,
//	LCD_UPDN,
//	LCD_RSTB,
//	LCD_DE,
//	LCD_SHLR,
//	LCD_DIM,
	
	//D5M
//	CAMERA_LVAL,
//	CAMERA_PIXCLK,
//	CAMERA_RESET_n,
//	CAMERA_SCLK,
//	CAMERA_SDATA,
//	CAMERA_STROBE,
//	CAMERA_TRIGGER,
//	CAMERA_XCLKIN,
//	CAMERA_D,
//	CAMERA_FVAL,
//	//LIGHT SENSOR
//	LSENSOR_ADDR_SEL,
//	LSENSOR_SCL,
//	LSENSOR_SDA,
//	LSENSOR_INT,
//	//G_Sensor
//	GSENSOR_CS_n,
//	GSENSOR_INT1,
//	GSENSOR_INT2,
//	GSENSOR_ALT_ADDR,
//	GSENSOR_SDA_SDI_SDIO,
//	GSENSOR_SCL_SCLK,
	
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;
input 		          		CLOCK2_50;
input 		          		CLOCK3_50;

//////////// Sma //////////
input 		          		SMA_CLKIN;
output		          		SMA_CLKOUT;

//////////// LED //////////
output		     [8:0]		LEDG;
output		    [17:0]		LEDR;

//////////// KEY //////////
input 		     [3:0]		KEY;

//////////// EX_IO //////////
inout 		     [6:0]		EX_IO;

//////////// SW //////////
input 		    [17:0]		SW;

//////////// SEG7 //////////
output		     [6:0]		HEX0;
output		     [6:0]		HEX1;
output		     [6:0]		HEX2;
output		     [6:0]		HEX3;
output		     [6:0]		HEX4;
output		     [6:0]		HEX5;
output		     [6:0]		HEX6;
output		     [6:0]		HEX7;

//////////// LCD //////////
output		          		LCD_BLON;
inout 		     [7:0]		LCD_DATA;
output		          		LCD_EN;
output		          		LCD_ON;
output		          		LCD_RS;
output		          		LCD_RW;

//////////// RS232 //////////
output		          		UART_CTS;
input 		          		UART_RTS;
input 		          		UART_RXD;
output		          		UART_TXD;

//////////// PS2 for Keyboard and Mouse //////////
inout 		          		PS2_CLK;
inout 		          		PS2_CLK2;
inout 		          		PS2_DAT;
inout 		          		PS2_DAT2;

//////////// SDCARD //////////
output		          		SD_CLK;
inout 		          		SD_CMD;
inout 		     [3:0]		SD_DAT;
input 		          		SD_WP_N;

//////////// VGA //////////
output		     [7:0]		VGA_B;
output		          		VGA_BLANK_N;
output		          		VGA_CLK;
output		     [7:0]		VGA_G;
output		          		VGA_HS;
output		     [7:0]		VGA_R;
output		          		VGA_SYNC_N;
output		          		VGA_VS;

//////////// Audio //////////
input 		          		AUD_ADCDAT;
inout 		          		AUD_ADCLRCK;
inout 		          		AUD_BCLK;
output		          		AUD_DACDAT;
inout 		          		AUD_DACLRCK;
output		          		AUD_XCK;

//////////// I2C for EEPROM //////////
output		          		EEP_I2C_SCLK;
inout 		          		EEP_I2C_SDAT;

//////////// I2C for Audio Tv-Decoder  //////////
output		          		I2C_SCLK;
inout 		          		I2C_SDAT;

//////////// Ethernet 0 //////////
output		          		ENET0_GTX_CLK;
input 		          		ENET0_INT_N;
input 		          		ENET0_LINK100;
output		          		ENET0_MDC;
inout 		          		ENET0_MDIO;
output		          		ENET0_RST_N;
input 		          		ENET0_RX_CLK;
input 		          		ENET0_RX_COL;
input 		          		ENET0_RX_CRS;
input 		     [3:0]		ENET0_RX_DATA;
input 		          		ENET0_RX_DV;
input 		          		ENET0_RX_ER;
input 		          		ENET0_TX_CLK;
output		     [3:0]		ENET0_TX_DATA;
output		          		ENET0_TX_EN;
output		          		ENET0_TX_ER;
input 		          		ENETCLK_25;

//////////// Ethernet 1 //////////
output		          		ENET1_GTX_CLK;
input 		          		ENET1_INT_N;
input 		          		ENET1_LINK100;
output		          		ENET1_MDC;
inout 		          		ENET1_MDIO;
output		          		ENET1_RST_N;
input 		          		ENET1_RX_CLK;
input 		          		ENET1_RX_COL;
input 		          		ENET1_RX_CRS;
input 		     [3:0]		ENET1_RX_DATA;
input 		          		ENET1_RX_DV;
input 		          		ENET1_RX_ER;
input 		          		ENET1_TX_CLK;
output		     [3:0]		ENET1_TX_DATA;
output		          		ENET1_TX_EN;
output		          		ENET1_TX_ER;

//////////// TV Decoder //////////
input 		          		TD_CLK27;
input 		     [7:0]		TD_DATA;
input 		          		TD_HS;
output		          		TD_RESET_N;
input 		          		TD_VS;

//////////// USB 2.0 OTG //////////
`ifdef V10
output         [1:0]          OTG_ADDR;
output                            OTG_CS_N;
output         [1:0]          OTG_DACK_N;
inout             [15:0]          OTG_DATA;
input              [1:0]          OTG_DREQ;
inout                              OTG_FSPEED;
input              [1:0]          OTG_INT;
inout                              OTG_LSPEED;
output                            OTG_RD_N;
output                            OTG_RST_N;
output                            OTG_WE_N;
`endif
`ifdef V20
inout            [15:0]    OTG_DATA;
output           [1:0]     OTG_ADDR;
output                     OTG_CS_N;
output                     OTG_WR_N;
output                     OTG_RD_N;
input                      OTG_INT0;
output                     OTG_RST_N;
`endif



//////////// IR Receiver //////////
input 		          		IRDA_RXD;

//////////// SDRAM //////////
output		    [12:0]		DRAM_ADDR;
output		     [1:0]		DRAM_BA;
output		          		DRAM_CAS_N;
output		          		DRAM_CKE;
output		          		DRAM_CLK;
output		          		DRAM_CS_N;
inout 		    [31:0]		DRAM_DQ;
output		     [3:0]		DRAM_DQM;
output		          		DRAM_RAS_N;
output		          		DRAM_WE_N;

//////////// SRAM //////////
output		    [19:0]		SRAM_ADDR;
output		          		SRAM_CE_N;
inout 		    [15:0]		SRAM_DQ;
output		          		SRAM_LB_N;
output		          		SRAM_OE_N;
output		          		SRAM_UB_N;
output		          		SRAM_WE_N;

//////////// Flash //////////
output		    [22:0]		FL_ADDR;
output		          		FL_CE_N;
inout 		     [7:0]		FL_DQ;
output		          		FL_OE_N;
output		          		FL_RST_N;
input 		          		FL_RY;
output		          		FL_WE_N;
output		          		FL_WP_N;

//////////// GPIO, GPIO connect to MTL2 //////////
//MTL2
output		     [7:0]		LCD_B;
output		          		LCD_DCLK;
output		     [7:0]		LCD_G;
output		          		LCD_HSD;
output		     [7:0]		LCD_R;
output		          		LCD_VSD;
output                   	TOUCH_I2C_SCL;
inout                   	TOUCH_I2C_SDA;
input                   	TOUCH_INT_n;

wire reset_n;
wire video_hs;
wire video_vs;
wire video_clk;
wire [7:0]	video_r;
wire [7:0]	video_g;
wire [7:0]	video_b;


vga_pll vga_pll_inst(
	.areset(1'b0),
	.inclk0(CLOCK2_50),
	.c0(video_clk),
	.c1(touch_sample_clk),
	.locked(reset_n));
	
reg counter[20];




DE2_115_SOPC DE2_115_SOPC_inst(
                  // 1) global signals:
                   .altpll_io(),
                   .altpll_0_c1_out(DRAM_CLK),
                   .altpll_sys(),
                   .clk_50(CLOCK_50),
                   .reset_n(1'b1),
						 
                  // the_led
                   .out_port_from_the_led({LEDR,LEDG}),
                  // the_sw
                   .in_port_to_the_sw(SW),
						 
                  // the_key
                  .in_port_to_the_key(KEY),

                  // the_alt_vip_itc_0
                   .underflow_from_the_alt_vip_itc_0(),
                   .vid_clk_to_the_alt_vip_itc_0(video_clk),
                   .vid_data_from_the_alt_vip_itc_0({video_r, video_g, video_b}),
                   .vid_datavalid_from_the_alt_vip_itc_0(),
                   .vid_f_from_the_alt_vip_itc_0(),
                   .vid_h_from_the_alt_vip_itc_0(),
                   .vid_h_sync_from_the_alt_vip_itc_0(video_hs),
                   .vid_v_from_the_alt_vip_itc_0(),
                   .vid_v_sync_from_the_alt_vip_itc_0(video_vs),
						 

                  // the_altpll_0
                   .locked_from_the_altpll_0(),
                   .phasedone_from_the_altpll_0(),

                  // the_lcd
                   .LCD_E_from_the_lcd(LCD_EN),
                   .LCD_RS_from_the_lcd(LCD_RS),
                   .LCD_RW_from_the_lcd(LCD_RW),
                   .LCD_data_to_and_from_the_lcd(LCD_DATA),
						 

                  // the_sdram
                   .zs_addr_from_the_sdram(DRAM_ADDR),
                   .zs_ba_from_the_sdram(DRAM_BA),
                   .zs_cas_n_from_the_sdram(DRAM_CAS_N),
                   .zs_cke_from_the_sdram(DRAM_CKE),
                   .zs_cs_n_from_the_sdram(DRAM_CS_N),
                   .zs_dq_to_and_from_the_sdram(DRAM_DQ),
                   .zs_dqm_from_the_sdram(DRAM_DQM),
                   .zs_ras_n_from_the_sdram(DRAM_RAS_N),
                   .zs_we_n_from_the_sdram(DRAM_WE_N),
						 
                  // the_sram
                   .SRAM_ADDR_from_the_sram(SRAM_ADDR),
                   .SRAM_CE_n_from_the_sram(SRAM_CE_N),
                   .SRAM_DQ_to_and_from_the_sram(SRAM_DQ),
                   .SRAM_LB_n_from_the_sram(SRAM_LB_N),
                   .SRAM_OE_n_from_the_sram(SRAM_OE_N),
                   .SRAM_UB_n_from_the_sram(SRAM_UB_N),
                   .SRAM_WE_n_from_the_sram(SRAM_WE_N),	
						 
						 
                  // the_tri_state_bridge_flash_avalon_slave
                   .address_to_the_cfi_flash(FL_ADDR),
                   .read_n_to_the_cfi_flash(FL_OE_N),
                   .select_n_to_the_cfi_flash(FL_CE_N),
                   .data_to_and_from_the_cfi_flash(FL_DQ),
                   .write_n_to_the_cfi_flash(FL_WE_N),	
				   
					///////// CUSTOM CODE /////////
					
				   // the_audio	                                                              
					.audio_conduit_end_ADCDAT(AUD_ADCDAT),
                    .audio_conduit_end_ADCLRC(AUD_ADCLRCK),					 
					.audio_conduit_end_DACDAT(AUD_DACDAT),                                                         
					.audio_conduit_end_DACLRC(AUD_DACLRCK),                                                         
					.audio_conduit_end_BCLK(AUD_BCLK),
					.audio_conduit_end_XCK(AUD_XCK),
				   
				   // sdcard	
					.sd_cmd_external_connection_export(SD_CMD), 
					.sd_clk_external_connection_export(SD_CLK),                                                           
					.sd_dat_external_connection_export(SD_DAT), 
					.sd_wp_n_external_connection_export(SD_WP_N),		
                  	
					// the_i2c_scl
					.i2c_scl_external_connection_export(I2C_SCLK),
						 
					// the_i2c_sda
					.i2c_sda_external_connection_export(I2C_SDAT),

					// the_key
					//.key_external_connection_export(KEY),
					
					.lcd_touch_int_external_connection_export (TOUCH_INT_n ), 			//   lcd_touch_int_external_connection.export
				    .i2c_opencores_0_export_scl_pad_io        ( TOUCH_I2C_SCL),        //              i2c_opencores_0_export.scl_pad_io
					.i2c_opencores_0_export_sda_pad_io        ( TOUCH_I2C_SDA)         //                       
 
);
// vga
assign {VGA_R, VGA_G, VGA_B} = {video_r, video_g, video_b};
assign VGA_BLANK_N = 1'b1;
assign VGA_SYNC_N = 1'b0;
assign VGA_HS = ~video_hs;
assign VGA_VS = ~video_vs;
assign VGA_CLK = video_clk;

// lcd
assign LCD_BLON = 1'b1;
assign LCD_ON = 1'b1;

// MTL - display
assign {LCD_R,LCD_G,LCD_B} = {video_r, video_g, video_b};
assign LCD_DCLK = video_clk;
assign LCD_HSD = ~video_hs;
assign LCD_VSD = ~video_vs;


// Flash Config
assign	FL_RST_N = reset_n;
assign	FL_WP_N = 1'b1;



endmodule
