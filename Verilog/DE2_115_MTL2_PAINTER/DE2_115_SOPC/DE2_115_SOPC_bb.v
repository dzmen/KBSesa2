
module DE2_115_SOPC (
	vid_clk_to_the_alt_vip_itc_0,
	vid_data_from_the_alt_vip_itc_0,
	underflow_from_the_alt_vip_itc_0,
	vid_datavalid_from_the_alt_vip_itc_0,
	vid_v_sync_from_the_alt_vip_itc_0,
	vid_h_sync_from_the_alt_vip_itc_0,
	vid_f_from_the_alt_vip_itc_0,
	vid_h_from_the_alt_vip_itc_0,
	vid_v_from_the_alt_vip_itc_0,
	altpll_0_areset_conduit_export,
	altpll_0_c1_out,
	locked_from_the_altpll_0,
	phasedone_from_the_altpll_0,
	altpll_audio_locked_conduit_export,
	altpll_audio_phasedone_conduit_export,
	audio_conduit_end_XCK,
	audio_conduit_end_ADCDAT,
	audio_conduit_end_ADCLRC,
	audio_conduit_end_DACDAT,
	audio_conduit_end_DACLRC,
	audio_conduit_end_BCLK,
	clk_50,
	reset_n,
	dclk_from_the_epcs_flash_controller,
	sce_from_the_epcs_flash_controller,
	sdo_from_the_epcs_flash_controller,
	data0_to_the_epcs_flash_controller,
	i2c_opencores_0_export_scl_pad_io,
	i2c_opencores_0_export_sda_pad_io,
	in_port_to_the_key,
	LCD_RS_from_the_lcd,
	LCD_RW_from_the_lcd,
	LCD_data_to_and_from_the_lcd,
	LCD_E_from_the_lcd,
	lcd_touch_int_external_connection_export,
	out_port_from_the_led,
	zs_addr_from_the_sdram,
	zs_ba_from_the_sdram,
	zs_cas_n_from_the_sdram,
	zs_cke_from_the_sdram,
	zs_cs_n_from_the_sdram,
	zs_dq_to_and_from_the_sdram,
	zs_dqm_from_the_sdram,
	zs_ras_n_from_the_sdram,
	zs_we_n_from_the_sdram,
	SRAM_DQ_to_and_from_the_sram,
	SRAM_ADDR_from_the_sram,
	SRAM_UB_n_from_the_sram,
	SRAM_LB_n_from_the_sram,
	SRAM_WE_n_from_the_sram,
	SRAM_CE_n_from_the_sram,
	SRAM_OE_n_from_the_sram,
	in_port_to_the_sw,
	data_to_and_from_the_cfi_flash,
	address_to_the_cfi_flash,
	write_n_to_the_cfi_flash,
	select_n_to_the_cfi_flash,
	read_n_to_the_cfi_flash,
	sd_dat_external_connection_export,
	sd_cmd_external_connection_export,
	sd_clk_external_connection_export,
	sd_wp_n_external_connection_export,
	i2c_scl_external_connection_export,
	i2c_sda_external_connection_export);	

	input		vid_clk_to_the_alt_vip_itc_0;
	output	[23:0]	vid_data_from_the_alt_vip_itc_0;
	output		underflow_from_the_alt_vip_itc_0;
	output		vid_datavalid_from_the_alt_vip_itc_0;
	output		vid_v_sync_from_the_alt_vip_itc_0;
	output		vid_h_sync_from_the_alt_vip_itc_0;
	output		vid_f_from_the_alt_vip_itc_0;
	output		vid_h_from_the_alt_vip_itc_0;
	output		vid_v_from_the_alt_vip_itc_0;
	input		altpll_0_areset_conduit_export;
	output		altpll_0_c1_out;
	output		locked_from_the_altpll_0;
	output		phasedone_from_the_altpll_0;
	output		altpll_audio_locked_conduit_export;
	output		altpll_audio_phasedone_conduit_export;
	output		audio_conduit_end_XCK;
	input		audio_conduit_end_ADCDAT;
	input		audio_conduit_end_ADCLRC;
	output		audio_conduit_end_DACDAT;
	input		audio_conduit_end_DACLRC;
	input		audio_conduit_end_BCLK;
	input		clk_50;
	input		reset_n;
	output		dclk_from_the_epcs_flash_controller;
	output		sce_from_the_epcs_flash_controller;
	output		sdo_from_the_epcs_flash_controller;
	input		data0_to_the_epcs_flash_controller;
	inout		i2c_opencores_0_export_scl_pad_io;
	inout		i2c_opencores_0_export_sda_pad_io;
	input	[3:0]	in_port_to_the_key;
	output		LCD_RS_from_the_lcd;
	output		LCD_RW_from_the_lcd;
	inout	[7:0]	LCD_data_to_and_from_the_lcd;
	output		LCD_E_from_the_lcd;
	input		lcd_touch_int_external_connection_export;
	output	[26:0]	out_port_from_the_led;
	output	[12:0]	zs_addr_from_the_sdram;
	output	[1:0]	zs_ba_from_the_sdram;
	output		zs_cas_n_from_the_sdram;
	output		zs_cke_from_the_sdram;
	output		zs_cs_n_from_the_sdram;
	inout	[31:0]	zs_dq_to_and_from_the_sdram;
	output	[3:0]	zs_dqm_from_the_sdram;
	output		zs_ras_n_from_the_sdram;
	output		zs_we_n_from_the_sdram;
	inout	[15:0]	SRAM_DQ_to_and_from_the_sram;
	output	[19:0]	SRAM_ADDR_from_the_sram;
	output		SRAM_UB_n_from_the_sram;
	output		SRAM_LB_n_from_the_sram;
	output		SRAM_WE_n_from_the_sram;
	output		SRAM_CE_n_from_the_sram;
	output		SRAM_OE_n_from_the_sram;
	input	[17:0]	in_port_to_the_sw;
	inout	[7:0]	data_to_and_from_the_cfi_flash;
	output	[22:0]	address_to_the_cfi_flash;
	output	[0:0]	write_n_to_the_cfi_flash;
	output	[0:0]	select_n_to_the_cfi_flash;
	output	[0:0]	read_n_to_the_cfi_flash;
	inout	[3:0]	sd_dat_external_connection_export;
	inout		sd_cmd_external_connection_export;
	output		sd_clk_external_connection_export;
	input		sd_wp_n_external_connection_export;
	output		i2c_scl_external_connection_export;
	inout		i2c_sda_external_connection_export;
endmodule
