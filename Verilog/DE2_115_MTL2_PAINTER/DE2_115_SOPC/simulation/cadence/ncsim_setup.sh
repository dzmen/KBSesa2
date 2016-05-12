
# (C) 2001-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 15.1 193 win32 2016.05.11.15:15:38

# ----------------------------------------
# ncsim - auto-generated simulation script

# ----------------------------------------
# This script can be used to simulate the following IP:
#     DE2_115_SOPC
# To create a top-level simulation script which compiles other
# IP, and manages other system issues, copy the following template
# and adapt it to your needs:
# 
# # Start of template
# # If the copied and modified template file is "ncsim.sh", run it as:
# #   ./ncsim.sh
# #
# # Do the file copy, dev_com and com steps
# source ncsim_setup.sh \
# SKIP_ELAB=1 \
# SKIP_SIM=1
# 
# # Compile the top level module
# ncvlog -sv "$QSYS_SIMDIR/../top.sv"
# 
# # Do the elaboration and sim steps
# # Override the top-level name
# # Override the user-defined sim options, so the simulation
# # runs forever (until $finish()).
# source ncsim_setup.sh \
# SKIP_FILE_COPY=1 \
# SKIP_DEV_COM=1 \
# SKIP_COM=1 \
# TOP_LEVEL_NAME=top \
# USER_DEFINED_SIM_OPTIONS=""
# # End of template
# ----------------------------------------
# If DE2_115_SOPC is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------
# ACDS 15.1 193 win32 2016.05.11.15:15:38
# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="DE2_115_SOPC"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="C:/altera_lite/15.1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/error_adapter_0/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/router/
mkdir -p ./libraries/avalon_st_adapter_010/
mkdir -p ./libraries/avalon_st_adapter_002/
mkdir -p ./libraries/avalon_st_adapter/
mkdir -p ./libraries/crosser/
mkdir -p ./libraries/sram_avalon_slave_rsp_width_adapter/
mkdir -p ./libraries/rsp_mux_002/
mkdir -p ./libraries/rsp_mux_001/
mkdir -p ./libraries/rsp_demux_004/
mkdir -p ./libraries/cmd_mux_001/
mkdir -p ./libraries/cmd_demux_002/
mkdir -p ./libraries/cmd_demux_001/
mkdir -p ./libraries/sdram_s1_burst_adapter/
mkdir -p ./libraries/cpu_data_master_limiter/
mkdir -p ./libraries/router_013/
mkdir -p ./libraries/router_008/
mkdir -p ./libraries/router_005/
mkdir -p ./libraries/router_004/
mkdir -p ./libraries/router_003/
mkdir -p ./libraries/router_002/
mkdir -p ./libraries/sdram_s1_agent_rsp_fifo/
mkdir -p ./libraries/sdram_s1_agent/
mkdir -p ./libraries/alt_vip_vfr_0_avalon_master_agent/
mkdir -p ./libraries/alt_vip_vfr_0_avalon_master_translator/
mkdir -p ./libraries/arbiter/
mkdir -p ./libraries/pin_sharer/
mkdir -p ./libraries/cpu/
mkdir -p ./libraries/tda/
mkdir -p ./libraries/slave_translator/
mkdir -p ./libraries/tdt/
mkdir -p ./libraries/rst_controller/
mkdir -p ./libraries/irq_synchronizer/
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/mm_interconnect_1/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/tri_state_bridge_flash_pinSharer_0/
mkdir -p ./libraries/tri_state_bridge_flash_bridge_0/
mkdir -p ./libraries/timer/
mkdir -p ./libraries/sysid/
mkdir -p ./libraries/sw/
mkdir -p ./libraries/sram/
mkdir -p ./libraries/sdram/
mkdir -p ./libraries/led/
mkdir -p ./libraries/lcd_touch_int/
mkdir -p ./libraries/lcd/
mkdir -p ./libraries/key/
mkdir -p ./libraries/jtag_uart/
mkdir -p ./libraries/i2c_opencores_0/
mkdir -p ./libraries/epcs_flash_controller/
mkdir -p ./libraries/clock_crossing_io/
mkdir -p ./libraries/cfi_flash/
mkdir -p ./libraries/altpll_0/
mkdir -p ./libraries/alt_vip_vfr_0/
mkdir -p ./libraries/alt_vip_itc_0/
mkdir -p ./libraries/altera_ver/
mkdir -p ./libraries/lpm_ver/
mkdir -p ./libraries/sgate_ver/
mkdir -p ./libraries/altera_mf_ver/
mkdir -p ./libraries/altera_lnsim_ver/
mkdir -p ./libraries/cycloneive_ver/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_bht_ram.dat ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_bht_ram.hex ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_bht_ram.mif ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_dc_tag_ram.dat ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_dc_tag_ram.hex ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_dc_tag_ram.mif ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ic_tag_ram.dat ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ic_tag_ram.hex ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ic_tag_ram.mif ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ociram_default_contents.dat ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ociram_default_contents.hex ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ociram_default_contents.mif ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_a.dat ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_a.hex ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_a.mif ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_b.dat ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_b.hex ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_b.mif ./
  cp -f $QSYS_SIMDIR/submodules/DE2_115_SOPC_epcs_flash_controller_boot_rom.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v" -work altera_ver      
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"          -work lpm_ver         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"             -work sgate_ver       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"         -work altera_mf_ver   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"     -work altera_lnsim_ver
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.v"  -work cycloneive_ver  
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_010_error_adapter_0.sv" -work error_adapter_0                        -cdslib ./cds_libs/error_adapter_0.cds.lib                       
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_002_error_adapter_0.sv" -work error_adapter_0                        -cdslib ./cds_libs/error_adapter_0.cds.lib                       
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"     -work error_adapter_0                        -cdslib ./cds_libs/error_adapter_0.cds.lib                       
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux                                -cdslib ./cds_libs/rsp_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_rsp_mux.sv"                               -work rsp_mux                                -cdslib ./cds_libs/rsp_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_rsp_demux.sv"                             -work rsp_demux                              -cdslib ./cds_libs/rsp_demux.cds.lib                             
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux                                -cdslib ./cds_libs/cmd_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_cmd_mux.sv"                               -work cmd_mux                                -cdslib ./cds_libs/cmd_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_cmd_demux.sv"                             -work cmd_demux                              -cdslib ./cds_libs/cmd_demux.cds.lib                             
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_router_001.sv"                            -work router_001                             -cdslib ./cds_libs/router_001.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_router.sv"                                -work router                                 -cdslib ./cds_libs/router.cds.lib                                
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_010.v"                  -work avalon_st_adapter_010                  -cdslib ./cds_libs/avalon_st_adapter_010.cds.lib                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_002.v"                  -work avalon_st_adapter_002                  -cdslib ./cds_libs/avalon_st_adapter_002.cds.lib                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter.v"                      -work avalon_st_adapter                      -cdslib ./cds_libs/avalon_st_adapter.cds.lib                     
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_handshake_clock_crosser.v"                              -work crosser                                -cdslib ./cds_libs/crosser.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                        -work crosser                                -cdslib ./cds_libs/crosser.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work crosser                                -cdslib ./cds_libs/crosser.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                         -work crosser                                -cdslib ./cds_libs/crosser.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                          -work sram_avalon_slave_rsp_width_adapter    -cdslib ./cds_libs/sram_avalon_slave_rsp_width_adapter.cds.lib   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work sram_avalon_slave_rsp_width_adapter    -cdslib ./cds_libs/sram_avalon_slave_rsp_width_adapter.cds.lib   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -work sram_avalon_slave_rsp_width_adapter    -cdslib ./cds_libs/sram_avalon_slave_rsp_width_adapter.cds.lib   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux_002                            -cdslib ./cds_libs/rsp_mux_002.cds.lib                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_mux_002.sv"                           -work rsp_mux_002                            -cdslib ./cds_libs/rsp_mux_002.cds.lib                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux_001                            -cdslib ./cds_libs/rsp_mux_001.cds.lib                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_mux_001.sv"                           -work rsp_mux_001                            -cdslib ./cds_libs/rsp_mux_001.cds.lib                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux                                -cdslib ./cds_libs/rsp_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_mux.sv"                               -work rsp_mux                                -cdslib ./cds_libs/rsp_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_demux_004.sv"                         -work rsp_demux_004                          -cdslib ./cds_libs/rsp_demux_004.cds.lib                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_demux.sv"                             -work rsp_demux                              -cdslib ./cds_libs/rsp_demux.cds.lib                             
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux_001                            -cdslib ./cds_libs/cmd_mux_001.cds.lib                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_mux_001.sv"                           -work cmd_mux_001                            -cdslib ./cds_libs/cmd_mux_001.cds.lib                           
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux                                -cdslib ./cds_libs/cmd_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_mux.sv"                               -work cmd_mux                                -cdslib ./cds_libs/cmd_mux.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_demux_002.sv"                         -work cmd_demux_002                          -cdslib ./cds_libs/cmd_demux_002.cds.lib                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_demux_001.sv"                         -work cmd_demux_001                          -cdslib ./cds_libs/cmd_demux_001.cds.lib                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_demux.sv"                             -work cmd_demux                              -cdslib ./cds_libs/cmd_demux.cds.lib                             
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                          -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                   -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                     -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                      -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                          -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                          -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                       -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                      -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work sdram_s1_burst_adapter                 -cdslib ./cds_libs/sdram_s1_burst_adapter.cds.lib                
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                        -work cpu_data_master_limiter                -cdslib ./cds_libs/cpu_data_master_limiter.cds.lib               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                         -work cpu_data_master_limiter                -cdslib ./cds_libs/cpu_data_master_limiter.cds.lib               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -work cpu_data_master_limiter                -cdslib ./cds_libs/cpu_data_master_limiter.cds.lib               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work cpu_data_master_limiter                -cdslib ./cds_libs/cpu_data_master_limiter.cds.lib               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_013.sv"                            -work router_013                             -cdslib ./cds_libs/router_013.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_008.sv"                            -work router_008                             -cdslib ./cds_libs/router_008.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_005.sv"                            -work router_005                             -cdslib ./cds_libs/router_005.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_004.sv"                            -work router_004                             -cdslib ./cds_libs/router_004.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_003.sv"                            -work router_003                             -cdslib ./cds_libs/router_003.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_002.sv"                            -work router_002                             -cdslib ./cds_libs/router_002.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_001.sv"                            -work router_001                             -cdslib ./cds_libs/router_001.cds.lib                            
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router.sv"                                -work router                                 -cdslib ./cds_libs/router.cds.lib                                
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -work sdram_s1_agent_rsp_fifo                -cdslib ./cds_libs/sdram_s1_agent_rsp_fifo.cds.lib               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                            -work sdram_s1_agent                         -cdslib ./cds_libs/sdram_s1_agent.cds.lib                        
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -work sdram_s1_agent                         -cdslib ./cds_libs/sdram_s1_agent.cds.lib                        
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                           -work alt_vip_vfr_0_avalon_master_agent      -cdslib ./cds_libs/alt_vip_vfr_0_avalon_master_agent.cds.lib     
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                      -work alt_vip_vfr_0_avalon_master_translator -cdslib ./cds_libs/alt_vip_vfr_0_avalon_master_translator.cds.lib
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_std_arbitrator_core.sv"                                    -work arbiter                                -cdslib ./cds_libs/arbiter.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_pinSharer_0_arbiter.sv"              -work arbiter                                -cdslib ./cds_libs/arbiter.cds.lib                               
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_pinSharer_0_pin_sharer.sv"           -work pin_sharer                             -cdslib ./cds_libs/pin_sharer.cds.lib                            
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu.vo"                                                 -work cpu                                    -cdslib ./cds_libs/cpu.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_debug_slave_sysclk.v"                               -work cpu                                    -cdslib ./cds_libs/cpu.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_debug_slave_tck.v"                                  -work cpu                                    -cdslib ./cds_libs/cpu.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_debug_slave_wrapper.v"                              -work cpu                                    -cdslib ./cds_libs/cpu.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_mult_cell.v"                                        -work cpu                                    -cdslib ./cds_libs/cpu.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_test_bench.v"                                       -work cpu                                    -cdslib ./cds_libs/cpu.cds.lib                                   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_tristate_controller_aggregator.sv"                                -work tda                                    -cdslib ./cds_libs/tda.cds.lib                                   
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                       -work slave_translator                       -cdslib ./cds_libs/slave_translator.cds.lib                      
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_tristate_controller_translator.sv"                                -work tdt                                    -cdslib ./cds_libs/tdt.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                               -work rst_controller                         -cdslib ./cds_libs/rst_controller.cds.lib                        
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                             -work rst_controller                         -cdslib ./cds_libs/rst_controller.cds.lib                        
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_irq_clock_crosser.sv"                                             -work irq_synchronizer                       -cdslib ./cds_libs/irq_synchronizer.cds.lib                      
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_irq_mapper.sv"                                              -work irq_mapper                             -cdslib ./cds_libs/irq_mapper.cds.lib                            
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1.v"                                        -work mm_interconnect_1                      -cdslib ./cds_libs/mm_interconnect_1.cds.lib                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0.v"                                        -work mm_interconnect_0                      -cdslib ./cds_libs/mm_interconnect_0.cds.lib                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_pinSharer_0.v"                       -work tri_state_bridge_flash_pinSharer_0     -cdslib ./cds_libs/tri_state_bridge_flash_pinSharer_0.cds.lib    
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_bridge_0.sv"                         -work tri_state_bridge_flash_bridge_0        -cdslib ./cds_libs/tri_state_bridge_flash_bridge_0.cds.lib       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_timer.v"                                                    -work timer                                  -cdslib ./cds_libs/timer.cds.lib                                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_sysid.vo"                                                   -work sysid                                  -cdslib ./cds_libs/sysid.cds.lib                                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_sw.v"                                                       -work sw                                     -cdslib ./cds_libs/sw.cds.lib                                    
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/TERASIC_SRAM.v"                                                          -work sram                                   -cdslib ./cds_libs/sram.cds.lib                                  
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_sdram.v"                                                    -work sdram                                  -cdslib ./cds_libs/sdram.cds.lib                                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_led.v"                                                      -work led                                    -cdslib ./cds_libs/led.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_lcd_touch_int.v"                                            -work lcd_touch_int                          -cdslib ./cds_libs/lcd_touch_int.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_lcd.v"                                                      -work lcd                                    -cdslib ./cds_libs/lcd.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_key.v"                                                      -work key                                    -cdslib ./cds_libs/key.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_jtag_uart.v"                                                -work jtag_uart                              -cdslib ./cds_libs/jtag_uart.cds.lib                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/i2c_opencores.v"                                                         -work i2c_opencores_0                        -cdslib ./cds_libs/i2c_opencores_0.cds.lib                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/i2c_master_top.v"                                                        -work i2c_opencores_0                        -cdslib ./cds_libs/i2c_opencores_0.cds.lib                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/i2c_master_defines.v"                                                    -work i2c_opencores_0                        -cdslib ./cds_libs/i2c_opencores_0.cds.lib                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/i2c_master_byte_ctrl.v"                                                  -work i2c_opencores_0                        -cdslib ./cds_libs/i2c_opencores_0.cds.lib                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/i2c_master_bit_ctrl.v"                                                   -work i2c_opencores_0                        -cdslib ./cds_libs/i2c_opencores_0.cds.lib                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/timescale.v"                                                             -work i2c_opencores_0                        -cdslib ./cds_libs/i2c_opencores_0.cds.lib                       
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_epcs_flash_controller.v"                                    -work epcs_flash_controller                  -cdslib ./cds_libs/epcs_flash_controller.cds.lib                 
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu.v"                                                      -work cpu                                    -cdslib ./cds_libs/cpu.cds.lib                                   
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_mm_clock_crossing_bridge.v"                                -work clock_crossing_io                      -cdslib ./cds_libs/clock_crossing_io.cds.lib                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_avalon_dc_fifo.v"                                                 -work clock_crossing_io                      -cdslib ./cds_libs/clock_crossing_io.cds.lib                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_dcfifo_synchronizer_bundle.v"                                     -work clock_crossing_io                      -cdslib ./cds_libs/clock_crossing_io.cds.lib                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                         -work clock_crossing_io                      -cdslib ./cds_libs/clock_crossing_io.cds.lib                     
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cfi_flash.v"                                                -work cfi_flash                              -cdslib ./cds_libs/cfi_flash.cds.lib                             
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_altpll_0.vo"                                                -work altpll_0                               -cdslib ./cds_libs/altpll_0.cds.lib                              
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/DE2_115_SOPC_alt_vip_vfr_0.vo"                                           -work alt_vip_vfr_0                          -cdslib ./cds_libs/alt_vip_vfr_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid.sv"                                                 -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_sync_compare.v"                                     -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_calculate_mode.v"                                   -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_control.v"                                          -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog -sv $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_mode_banks.sv"                                      -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_statemachine.v"                                     -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_fifo.v"                                             -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_generic_count.v"                                    -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_to_binary.v"                                        -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync.v"                                             -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_trigger_sync.v"                                     -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync_generation.v"                                  -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_frame_counter.v"                                    -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sample_counter.v"                                   -work alt_vip_itc_0                          -cdslib ./cds_libs/alt_vip_itc_0.cds.lib                         
  ncvlog $USER_DEFINED_COMPILE_OPTIONS     "$QSYS_SIMDIR/DE2_115_SOPC.v"                                                                                                                                                                                   
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  ncelab -access +w+r+c -namemap_mixgen $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi
