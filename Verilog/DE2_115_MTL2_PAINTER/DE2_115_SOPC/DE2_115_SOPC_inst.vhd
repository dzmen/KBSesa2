	component DE2_115_SOPC is
		port (
			vid_clk_to_the_alt_vip_itc_0             : in    std_logic                     := 'X';             -- vid_clk
			vid_data_from_the_alt_vip_itc_0          : out   std_logic_vector(23 downto 0);                    -- vid_data
			underflow_from_the_alt_vip_itc_0         : out   std_logic;                                        -- underflow
			vid_datavalid_from_the_alt_vip_itc_0     : out   std_logic;                                        -- vid_datavalid
			vid_v_sync_from_the_alt_vip_itc_0        : out   std_logic;                                        -- vid_v_sync
			vid_h_sync_from_the_alt_vip_itc_0        : out   std_logic;                                        -- vid_h_sync
			vid_f_from_the_alt_vip_itc_0             : out   std_logic;                                        -- vid_f
			vid_h_from_the_alt_vip_itc_0             : out   std_logic;                                        -- vid_h
			vid_v_from_the_alt_vip_itc_0             : out   std_logic;                                        -- vid_v
			altpll_0_areset_conduit_export           : in    std_logic                     := 'X';             -- export
			altpll_0_c1_out                          : out   std_logic;                                        -- clk
			locked_from_the_altpll_0                 : out   std_logic;                                        -- export
			phasedone_from_the_altpll_0              : out   std_logic;                                        -- export
			altpll_audio_locked_conduit_export       : out   std_logic;                                        -- export
			altpll_audio_phasedone_conduit_export    : out   std_logic;                                        -- export
			audio_conduit_end_XCK                    : out   std_logic;                                        -- XCK
			audio_conduit_end_ADCDAT                 : in    std_logic                     := 'X';             -- ADCDAT
			audio_conduit_end_ADCLRC                 : in    std_logic                     := 'X';             -- ADCLRC
			audio_conduit_end_DACDAT                 : out   std_logic;                                        -- DACDAT
			audio_conduit_end_DACLRC                 : in    std_logic                     := 'X';             -- DACLRC
			audio_conduit_end_BCLK                   : in    std_logic                     := 'X';             -- BCLK
			clk_50                                   : in    std_logic                     := 'X';             -- clk
			reset_n                                  : in    std_logic                     := 'X';             -- reset_n
			dclk_from_the_epcs_flash_controller      : out   std_logic;                                        -- dclk
			sce_from_the_epcs_flash_controller       : out   std_logic;                                        -- sce
			sdo_from_the_epcs_flash_controller       : out   std_logic;                                        -- sdo
			data0_to_the_epcs_flash_controller       : in    std_logic                     := 'X';             -- data0
			i2c_opencores_0_export_scl_pad_io        : inout std_logic                     := 'X';             -- scl_pad_io
			i2c_opencores_0_export_sda_pad_io        : inout std_logic                     := 'X';             -- sda_pad_io
			in_port_to_the_key                       : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			LCD_RS_from_the_lcd                      : out   std_logic;                                        -- RS
			LCD_RW_from_the_lcd                      : out   std_logic;                                        -- RW
			LCD_data_to_and_from_the_lcd             : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- data
			LCD_E_from_the_lcd                       : out   std_logic;                                        -- E
			lcd_touch_int_external_connection_export : in    std_logic                     := 'X';             -- export
			out_port_from_the_led                    : out   std_logic_vector(26 downto 0);                    -- export
			zs_addr_from_the_sdram                   : out   std_logic_vector(12 downto 0);                    -- addr
			zs_ba_from_the_sdram                     : out   std_logic_vector(1 downto 0);                     -- ba
			zs_cas_n_from_the_sdram                  : out   std_logic;                                        -- cas_n
			zs_cke_from_the_sdram                    : out   std_logic;                                        -- cke
			zs_cs_n_from_the_sdram                   : out   std_logic;                                        -- cs_n
			zs_dq_to_and_from_the_sdram              : inout std_logic_vector(31 downto 0) := (others => 'X'); -- dq
			zs_dqm_from_the_sdram                    : out   std_logic_vector(3 downto 0);                     -- dqm
			zs_ras_n_from_the_sdram                  : out   std_logic;                                        -- ras_n
			zs_we_n_from_the_sdram                   : out   std_logic;                                        -- we_n
			SRAM_DQ_to_and_from_the_sram             : inout std_logic_vector(15 downto 0) := (others => 'X'); -- DQ
			SRAM_ADDR_from_the_sram                  : out   std_logic_vector(19 downto 0);                    -- ADDR
			SRAM_UB_n_from_the_sram                  : out   std_logic;                                        -- UB_n
			SRAM_LB_n_from_the_sram                  : out   std_logic;                                        -- LB_n
			SRAM_WE_n_from_the_sram                  : out   std_logic;                                        -- WE_n
			SRAM_CE_n_from_the_sram                  : out   std_logic;                                        -- CE_n
			SRAM_OE_n_from_the_sram                  : out   std_logic;                                        -- OE_n
			in_port_to_the_sw                        : in    std_logic_vector(17 downto 0) := (others => 'X'); -- export
			data_to_and_from_the_cfi_flash           : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- data_to_and_from_the_cfi_flash
			address_to_the_cfi_flash                 : out   std_logic_vector(22 downto 0);                    -- address_to_the_cfi_flash
			write_n_to_the_cfi_flash                 : out   std_logic_vector(0 downto 0);                     -- write_n_to_the_cfi_flash
			select_n_to_the_cfi_flash                : out   std_logic_vector(0 downto 0);                     -- select_n_to_the_cfi_flash
			read_n_to_the_cfi_flash                  : out   std_logic_vector(0 downto 0);                     -- read_n_to_the_cfi_flash
			sd_dat_external_connection_export        : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			sd_cmd_external_connection_export        : inout std_logic                     := 'X';             -- export
			sd_clk_external_connection_export        : out   std_logic;                                        -- export
			sd_wp_n_external_connection_export       : in    std_logic                     := 'X';             -- export
			i2c_scl_external_connection_export       : out   std_logic;                                        -- export
			i2c_sda_external_connection_export       : inout std_logic                     := 'X'              -- export
		);
	end component DE2_115_SOPC;

	u0 : component DE2_115_SOPC
		port map (
			vid_clk_to_the_alt_vip_itc_0             => CONNECTED_TO_vid_clk_to_the_alt_vip_itc_0,             --         alt_vip_itc_0_clocked_video.vid_clk
			vid_data_from_the_alt_vip_itc_0          => CONNECTED_TO_vid_data_from_the_alt_vip_itc_0,          --                                    .vid_data
			underflow_from_the_alt_vip_itc_0         => CONNECTED_TO_underflow_from_the_alt_vip_itc_0,         --                                    .underflow
			vid_datavalid_from_the_alt_vip_itc_0     => CONNECTED_TO_vid_datavalid_from_the_alt_vip_itc_0,     --                                    .vid_datavalid
			vid_v_sync_from_the_alt_vip_itc_0        => CONNECTED_TO_vid_v_sync_from_the_alt_vip_itc_0,        --                                    .vid_v_sync
			vid_h_sync_from_the_alt_vip_itc_0        => CONNECTED_TO_vid_h_sync_from_the_alt_vip_itc_0,        --                                    .vid_h_sync
			vid_f_from_the_alt_vip_itc_0             => CONNECTED_TO_vid_f_from_the_alt_vip_itc_0,             --                                    .vid_f
			vid_h_from_the_alt_vip_itc_0             => CONNECTED_TO_vid_h_from_the_alt_vip_itc_0,             --                                    .vid_h
			vid_v_from_the_alt_vip_itc_0             => CONNECTED_TO_vid_v_from_the_alt_vip_itc_0,             --                                    .vid_v
			altpll_0_areset_conduit_export           => CONNECTED_TO_altpll_0_areset_conduit_export,           --             altpll_0_areset_conduit.export
			altpll_0_c1_out                          => CONNECTED_TO_altpll_0_c1_out,                          --                         altpll_0_c1.clk
			locked_from_the_altpll_0                 => CONNECTED_TO_locked_from_the_altpll_0,                 --             altpll_0_locked_conduit.export
			phasedone_from_the_altpll_0              => CONNECTED_TO_phasedone_from_the_altpll_0,              --          altpll_0_phasedone_conduit.export
			altpll_audio_locked_conduit_export       => CONNECTED_TO_altpll_audio_locked_conduit_export,       --         altpll_audio_locked_conduit.export
			altpll_audio_phasedone_conduit_export    => CONNECTED_TO_altpll_audio_phasedone_conduit_export,    --      altpll_audio_phasedone_conduit.export
			audio_conduit_end_XCK                    => CONNECTED_TO_audio_conduit_end_XCK,                    --                   audio_conduit_end.XCK
			audio_conduit_end_ADCDAT                 => CONNECTED_TO_audio_conduit_end_ADCDAT,                 --                                    .ADCDAT
			audio_conduit_end_ADCLRC                 => CONNECTED_TO_audio_conduit_end_ADCLRC,                 --                                    .ADCLRC
			audio_conduit_end_DACDAT                 => CONNECTED_TO_audio_conduit_end_DACDAT,                 --                                    .DACDAT
			audio_conduit_end_DACLRC                 => CONNECTED_TO_audio_conduit_end_DACLRC,                 --                                    .DACLRC
			audio_conduit_end_BCLK                   => CONNECTED_TO_audio_conduit_end_BCLK,                   --                                    .BCLK
			clk_50                                   => CONNECTED_TO_clk_50,                                   --                       clk_50_clk_in.clk
			reset_n                                  => CONNECTED_TO_reset_n,                                  --                 clk_50_clk_in_reset.reset_n
			dclk_from_the_epcs_flash_controller      => CONNECTED_TO_dclk_from_the_epcs_flash_controller,      --      epcs_flash_controller_external.dclk
			sce_from_the_epcs_flash_controller       => CONNECTED_TO_sce_from_the_epcs_flash_controller,       --                                    .sce
			sdo_from_the_epcs_flash_controller       => CONNECTED_TO_sdo_from_the_epcs_flash_controller,       --                                    .sdo
			data0_to_the_epcs_flash_controller       => CONNECTED_TO_data0_to_the_epcs_flash_controller,       --                                    .data0
			i2c_opencores_0_export_scl_pad_io        => CONNECTED_TO_i2c_opencores_0_export_scl_pad_io,        --              i2c_opencores_0_export.scl_pad_io
			i2c_opencores_0_export_sda_pad_io        => CONNECTED_TO_i2c_opencores_0_export_sda_pad_io,        --                                    .sda_pad_io
			in_port_to_the_key                       => CONNECTED_TO_in_port_to_the_key,                       --             key_external_connection.export
			LCD_RS_from_the_lcd                      => CONNECTED_TO_LCD_RS_from_the_lcd,                      --                        lcd_external.RS
			LCD_RW_from_the_lcd                      => CONNECTED_TO_LCD_RW_from_the_lcd,                      --                                    .RW
			LCD_data_to_and_from_the_lcd             => CONNECTED_TO_LCD_data_to_and_from_the_lcd,             --                                    .data
			LCD_E_from_the_lcd                       => CONNECTED_TO_LCD_E_from_the_lcd,                       --                                    .E
			lcd_touch_int_external_connection_export => CONNECTED_TO_lcd_touch_int_external_connection_export, --   lcd_touch_int_external_connection.export
			out_port_from_the_led                    => CONNECTED_TO_out_port_from_the_led,                    --             led_external_connection.export
			zs_addr_from_the_sdram                   => CONNECTED_TO_zs_addr_from_the_sdram,                   --                          sdram_wire.addr
			zs_ba_from_the_sdram                     => CONNECTED_TO_zs_ba_from_the_sdram,                     --                                    .ba
			zs_cas_n_from_the_sdram                  => CONNECTED_TO_zs_cas_n_from_the_sdram,                  --                                    .cas_n
			zs_cke_from_the_sdram                    => CONNECTED_TO_zs_cke_from_the_sdram,                    --                                    .cke
			zs_cs_n_from_the_sdram                   => CONNECTED_TO_zs_cs_n_from_the_sdram,                   --                                    .cs_n
			zs_dq_to_and_from_the_sdram              => CONNECTED_TO_zs_dq_to_and_from_the_sdram,              --                                    .dq
			zs_dqm_from_the_sdram                    => CONNECTED_TO_zs_dqm_from_the_sdram,                    --                                    .dqm
			zs_ras_n_from_the_sdram                  => CONNECTED_TO_zs_ras_n_from_the_sdram,                  --                                    .ras_n
			zs_we_n_from_the_sdram                   => CONNECTED_TO_zs_we_n_from_the_sdram,                   --                                    .we_n
			SRAM_DQ_to_and_from_the_sram             => CONNECTED_TO_SRAM_DQ_to_and_from_the_sram,             --                    sram_conduit_end.DQ
			SRAM_ADDR_from_the_sram                  => CONNECTED_TO_SRAM_ADDR_from_the_sram,                  --                                    .ADDR
			SRAM_UB_n_from_the_sram                  => CONNECTED_TO_SRAM_UB_n_from_the_sram,                  --                                    .UB_n
			SRAM_LB_n_from_the_sram                  => CONNECTED_TO_SRAM_LB_n_from_the_sram,                  --                                    .LB_n
			SRAM_WE_n_from_the_sram                  => CONNECTED_TO_SRAM_WE_n_from_the_sram,                  --                                    .WE_n
			SRAM_CE_n_from_the_sram                  => CONNECTED_TO_SRAM_CE_n_from_the_sram,                  --                                    .CE_n
			SRAM_OE_n_from_the_sram                  => CONNECTED_TO_SRAM_OE_n_from_the_sram,                  --                                    .OE_n
			in_port_to_the_sw                        => CONNECTED_TO_in_port_to_the_sw,                        --              sw_external_connection.export
			data_to_and_from_the_cfi_flash           => CONNECTED_TO_data_to_and_from_the_cfi_flash,           -- tri_state_bridge_flash_bridge_0_out.data_to_and_from_the_cfi_flash
			address_to_the_cfi_flash                 => CONNECTED_TO_address_to_the_cfi_flash,                 --                                    .address_to_the_cfi_flash
			write_n_to_the_cfi_flash                 => CONNECTED_TO_write_n_to_the_cfi_flash,                 --                                    .write_n_to_the_cfi_flash
			select_n_to_the_cfi_flash                => CONNECTED_TO_select_n_to_the_cfi_flash,                --                                    .select_n_to_the_cfi_flash
			read_n_to_the_cfi_flash                  => CONNECTED_TO_read_n_to_the_cfi_flash,                  --                                    .read_n_to_the_cfi_flash
			sd_dat_external_connection_export        => CONNECTED_TO_sd_dat_external_connection_export,        --          sd_dat_external_connection.export
			sd_cmd_external_connection_export        => CONNECTED_TO_sd_cmd_external_connection_export,        --          sd_cmd_external_connection.export
			sd_clk_external_connection_export        => CONNECTED_TO_sd_clk_external_connection_export,        --          sd_clk_external_connection.export
			sd_wp_n_external_connection_export       => CONNECTED_TO_sd_wp_n_external_connection_export,       --         sd_wp_n_external_connection.export
			i2c_scl_external_connection_export       => CONNECTED_TO_i2c_scl_external_connection_export,       --         i2c_scl_external_connection.export
			i2c_sda_external_connection_export       => CONNECTED_TO_i2c_sda_external_connection_export        --         i2c_sda_external_connection.export
		);

