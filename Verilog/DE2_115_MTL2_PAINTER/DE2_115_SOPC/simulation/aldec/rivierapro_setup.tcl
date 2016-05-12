
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

# ACDS 15.1 193 win32 2016.05.11.15:15:39
# ----------------------------------------
# Auto-generated simulation script rivierapro_setup.tcl
# ----------------------------------------
# This script can be used to simulate the following IP:
#     DE2_115_SOPC
# To create a top-level simulation script which compiles other
# IP, and manages other system issues, copy the following template
# and adapt it to your needs:
# 
# # Start of template
# # If the copied and modified template file is "aldec.do", run it as:
# #   vsim -c -do aldec.do
# #
# # Source the generated sim script
# source rivierapro_setup.tcl
# # Compile eda/sim_lib contents first
# dev_com
# # Override the top-level name (so that elab is useful)
# set TOP_LEVEL_NAME top
# # Compile the standalone IP.
# com
# # Compile the user top-level
# vlog -sv2k5 ../../top.sv
# # Elaborate the design.
# elab
# # Run the simulation
# run
# # Report success to the shell
# exit -code 0
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

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "DE2_115_SOPC"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/altera_lite/15.1/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_bht_ram.dat ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_bht_ram.hex ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_bht_ram.mif ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_dc_tag_ram.dat ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_dc_tag_ram.hex ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_dc_tag_ram.mif ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ic_tag_ram.dat ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ic_tag_ram.hex ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ic_tag_ram.mif ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ociram_default_contents.dat ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ociram_default_contents.hex ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_ociram_default_contents.mif ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_a.dat ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_a.hex ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_a.mif ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_b.dat ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_b.hex ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_rf_ram_b.mif ./
  file copy -force $QSYS_SIMDIR/submodules/DE2_115_SOPC_epcs_flash_controller_boot_rom.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                  ./libraries/altera_ver      
vmap       altera_ver       ./libraries/altera_ver      
ensure_lib                  ./libraries/lpm_ver         
vmap       lpm_ver          ./libraries/lpm_ver         
ensure_lib                  ./libraries/sgate_ver       
vmap       sgate_ver        ./libraries/sgate_ver       
ensure_lib                  ./libraries/altera_mf_ver   
vmap       altera_mf_ver    ./libraries/altera_mf_ver   
ensure_lib                  ./libraries/altera_lnsim_ver
vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver
ensure_lib                  ./libraries/cycloneive_ver  
vmap       cycloneive_ver   ./libraries/cycloneive_ver  
ensure_lib                                        ./libraries/error_adapter_0                       
vmap       error_adapter_0                        ./libraries/error_adapter_0                       
ensure_lib                                        ./libraries/rsp_mux                               
vmap       rsp_mux                                ./libraries/rsp_mux                               
ensure_lib                                        ./libraries/rsp_demux                             
vmap       rsp_demux                              ./libraries/rsp_demux                             
ensure_lib                                        ./libraries/cmd_mux                               
vmap       cmd_mux                                ./libraries/cmd_mux                               
ensure_lib                                        ./libraries/cmd_demux                             
vmap       cmd_demux                              ./libraries/cmd_demux                             
ensure_lib                                        ./libraries/router_001                            
vmap       router_001                             ./libraries/router_001                            
ensure_lib                                        ./libraries/router                                
vmap       router                                 ./libraries/router                                
ensure_lib                                        ./libraries/avalon_st_adapter_010                 
vmap       avalon_st_adapter_010                  ./libraries/avalon_st_adapter_010                 
ensure_lib                                        ./libraries/avalon_st_adapter_002                 
vmap       avalon_st_adapter_002                  ./libraries/avalon_st_adapter_002                 
ensure_lib                                        ./libraries/avalon_st_adapter                     
vmap       avalon_st_adapter                      ./libraries/avalon_st_adapter                     
ensure_lib                                        ./libraries/crosser                               
vmap       crosser                                ./libraries/crosser                               
ensure_lib                                        ./libraries/sram_avalon_slave_rsp_width_adapter   
vmap       sram_avalon_slave_rsp_width_adapter    ./libraries/sram_avalon_slave_rsp_width_adapter   
ensure_lib                                        ./libraries/rsp_mux_002                           
vmap       rsp_mux_002                            ./libraries/rsp_mux_002                           
ensure_lib                                        ./libraries/rsp_mux_001                           
vmap       rsp_mux_001                            ./libraries/rsp_mux_001                           
ensure_lib                                        ./libraries/rsp_demux_004                         
vmap       rsp_demux_004                          ./libraries/rsp_demux_004                         
ensure_lib                                        ./libraries/cmd_mux_001                           
vmap       cmd_mux_001                            ./libraries/cmd_mux_001                           
ensure_lib                                        ./libraries/cmd_demux_002                         
vmap       cmd_demux_002                          ./libraries/cmd_demux_002                         
ensure_lib                                        ./libraries/cmd_demux_001                         
vmap       cmd_demux_001                          ./libraries/cmd_demux_001                         
ensure_lib                                        ./libraries/sdram_s1_burst_adapter                
vmap       sdram_s1_burst_adapter                 ./libraries/sdram_s1_burst_adapter                
ensure_lib                                        ./libraries/cpu_data_master_limiter               
vmap       cpu_data_master_limiter                ./libraries/cpu_data_master_limiter               
ensure_lib                                        ./libraries/router_013                            
vmap       router_013                             ./libraries/router_013                            
ensure_lib                                        ./libraries/router_008                            
vmap       router_008                             ./libraries/router_008                            
ensure_lib                                        ./libraries/router_005                            
vmap       router_005                             ./libraries/router_005                            
ensure_lib                                        ./libraries/router_004                            
vmap       router_004                             ./libraries/router_004                            
ensure_lib                                        ./libraries/router_003                            
vmap       router_003                             ./libraries/router_003                            
ensure_lib                                        ./libraries/router_002                            
vmap       router_002                             ./libraries/router_002                            
ensure_lib                                        ./libraries/sdram_s1_agent_rsp_fifo               
vmap       sdram_s1_agent_rsp_fifo                ./libraries/sdram_s1_agent_rsp_fifo               
ensure_lib                                        ./libraries/sdram_s1_agent                        
vmap       sdram_s1_agent                         ./libraries/sdram_s1_agent                        
ensure_lib                                        ./libraries/alt_vip_vfr_0_avalon_master_agent     
vmap       alt_vip_vfr_0_avalon_master_agent      ./libraries/alt_vip_vfr_0_avalon_master_agent     
ensure_lib                                        ./libraries/alt_vip_vfr_0_avalon_master_translator
vmap       alt_vip_vfr_0_avalon_master_translator ./libraries/alt_vip_vfr_0_avalon_master_translator
ensure_lib                                        ./libraries/arbiter                               
vmap       arbiter                                ./libraries/arbiter                               
ensure_lib                                        ./libraries/pin_sharer                            
vmap       pin_sharer                             ./libraries/pin_sharer                            
ensure_lib                                        ./libraries/cpu                                   
vmap       cpu                                    ./libraries/cpu                                   
ensure_lib                                        ./libraries/tda                                   
vmap       tda                                    ./libraries/tda                                   
ensure_lib                                        ./libraries/slave_translator                      
vmap       slave_translator                       ./libraries/slave_translator                      
ensure_lib                                        ./libraries/tdt                                   
vmap       tdt                                    ./libraries/tdt                                   
ensure_lib                                        ./libraries/rst_controller                        
vmap       rst_controller                         ./libraries/rst_controller                        
ensure_lib                                        ./libraries/irq_synchronizer                      
vmap       irq_synchronizer                       ./libraries/irq_synchronizer                      
ensure_lib                                        ./libraries/irq_mapper                            
vmap       irq_mapper                             ./libraries/irq_mapper                            
ensure_lib                                        ./libraries/mm_interconnect_1                     
vmap       mm_interconnect_1                      ./libraries/mm_interconnect_1                     
ensure_lib                                        ./libraries/mm_interconnect_0                     
vmap       mm_interconnect_0                      ./libraries/mm_interconnect_0                     
ensure_lib                                        ./libraries/tri_state_bridge_flash_pinSharer_0    
vmap       tri_state_bridge_flash_pinSharer_0     ./libraries/tri_state_bridge_flash_pinSharer_0    
ensure_lib                                        ./libraries/tri_state_bridge_flash_bridge_0       
vmap       tri_state_bridge_flash_bridge_0        ./libraries/tri_state_bridge_flash_bridge_0       
ensure_lib                                        ./libraries/timer                                 
vmap       timer                                  ./libraries/timer                                 
ensure_lib                                        ./libraries/sysid                                 
vmap       sysid                                  ./libraries/sysid                                 
ensure_lib                                        ./libraries/sw                                    
vmap       sw                                     ./libraries/sw                                    
ensure_lib                                        ./libraries/sram                                  
vmap       sram                                   ./libraries/sram                                  
ensure_lib                                        ./libraries/sdram                                 
vmap       sdram                                  ./libraries/sdram                                 
ensure_lib                                        ./libraries/led                                   
vmap       led                                    ./libraries/led                                   
ensure_lib                                        ./libraries/lcd_touch_int                         
vmap       lcd_touch_int                          ./libraries/lcd_touch_int                         
ensure_lib                                        ./libraries/lcd                                   
vmap       lcd                                    ./libraries/lcd                                   
ensure_lib                                        ./libraries/key                                   
vmap       key                                    ./libraries/key                                   
ensure_lib                                        ./libraries/jtag_uart                             
vmap       jtag_uart                              ./libraries/jtag_uart                             
ensure_lib                                        ./libraries/i2c_opencores_0                       
vmap       i2c_opencores_0                        ./libraries/i2c_opencores_0                       
ensure_lib                                        ./libraries/epcs_flash_controller                 
vmap       epcs_flash_controller                  ./libraries/epcs_flash_controller                 
ensure_lib                                        ./libraries/clock_crossing_io                     
vmap       clock_crossing_io                      ./libraries/clock_crossing_io                     
ensure_lib                                        ./libraries/cfi_flash                             
vmap       cfi_flash                              ./libraries/cfi_flash                             
ensure_lib                                        ./libraries/altpll_0                              
vmap       altpll_0                               ./libraries/altpll_0                              
ensure_lib                                        ./libraries/alt_vip_vfr_0                         
vmap       alt_vip_vfr_0                          ./libraries/alt_vip_vfr_0                         
ensure_lib                                        ./libraries/alt_vip_itc_0                         
vmap       alt_vip_itc_0                          ./libraries/alt_vip_itc_0                         

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  eval vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v" -work altera_ver      
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"          -work lpm_ver         
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"             -work sgate_ver       
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"         -work altera_mf_ver   
  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"     -work altera_lnsim_ver
  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.v"  -work cycloneive_ver  
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_010_error_adapter_0.sv" -work error_adapter_0                       
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_002_error_adapter_0.sv" -work error_adapter_0                       
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"     -work error_adapter_0                       
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_rsp_mux.sv"                               -work rsp_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_rsp_demux.sv"                             -work rsp_demux                             
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_cmd_mux.sv"                               -work cmd_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_cmd_demux.sv"                             -work cmd_demux                             
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_router_001.sv"                            -work router_001                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1_router.sv"                                -work router                                
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_010.v"                  -work avalon_st_adapter_010                 
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter_002.v"                  -work avalon_st_adapter_002                 
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_avalon_st_adapter.v"                      -work avalon_st_adapter                     
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_handshake_clock_crosser.v"                              -work crosser                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_clock_crosser.v"                                        -work crosser                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work crosser                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                         -work crosser                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_width_adapter.sv"                                          -work sram_avalon_slave_rsp_width_adapter   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work sram_avalon_slave_rsp_width_adapter   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -work sram_avalon_slave_rsp_width_adapter   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux_002                           
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_mux_002.sv"                           -work rsp_mux_002                           
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux_001                           
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_mux_001.sv"                           -work rsp_mux_001                           
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work rsp_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_mux.sv"                               -work rsp_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_demux_004.sv"                         -work rsp_demux_004                         
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_rsp_demux.sv"                             -work rsp_demux                             
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux_001                           
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_mux_001.sv"                           -work cmd_mux_001                           
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_arbitrator.sv"                                             -work cmd_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_mux.sv"                               -work cmd_mux                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_demux_002.sv"                         -work cmd_demux_002                         
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_demux_001.sv"                         -work cmd_demux_001                         
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_cmd_demux.sv"                             -work cmd_demux                             
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter.sv"                                          -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_uncmpr.sv"                                   -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_13_1.sv"                                     -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_adapter_new.sv"                                      -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_incr_burst_converter.sv"                                          -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_wrap_burst_converter.sv"                                          -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_default_burst_converter.sv"                                       -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_address_alignment.sv"                                      -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_stage.sv"                                      -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work sdram_s1_burst_adapter                
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_traffic_limiter.sv"                                        -work cpu_data_master_limiter               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_reorder_memory.sv"                                         -work cpu_data_master_limiter               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -work cpu_data_master_limiter               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_st_pipeline_base.v"                                        -work cpu_data_master_limiter               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_013.sv"                            -work router_013                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_008.sv"                            -work router_008                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_005.sv"                            -work router_005                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_004.sv"                            -work router_004                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_003.sv"                            -work router_003                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_002.sv"                            -work router_002                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router_001.sv"                            -work router_001                            
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0_router.sv"                                -work router                                
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_sc_fifo.v"                                                 -work sdram_s1_agent_rsp_fifo               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_slave_agent.sv"                                            -work sdram_s1_agent                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_burst_uncompressor.sv"                                     -work sdram_s1_agent                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_master_agent.sv"                                           -work alt_vip_vfr_0_avalon_master_agent     
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_master_translator.sv"                                      -work alt_vip_vfr_0_avalon_master_translator
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_std_arbitrator_core.sv"                                    -work arbiter                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_pinSharer_0_arbiter.sv"              -work arbiter                               
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_pinSharer_0_pin_sharer.sv"           -work pin_sharer                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu.vo"                                                 -work cpu                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_debug_slave_sysclk.v"                               -work cpu                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_debug_slave_tck.v"                                  -work cpu                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_debug_slave_wrapper.v"                              -work cpu                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_mult_cell.v"                                        -work cpu                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu_cpu_test_bench.v"                                       -work cpu                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_tristate_controller_aggregator.sv"                                -work tda                                   
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_merlin_slave_translator.sv"                                       -work slave_translator                      
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_tristate_controller_translator.sv"                                -work tdt                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                               -work rst_controller                        
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                             -work rst_controller                        
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_irq_clock_crosser.sv"                                             -work irq_synchronizer                      
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_irq_mapper.sv"                                              -work irq_mapper                            
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_1.v"                                        -work mm_interconnect_1                     
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_mm_interconnect_0.v"                                        -work mm_interconnect_0                     
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_pinSharer_0.v"                       -work tri_state_bridge_flash_pinSharer_0    
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/DE2_115_SOPC_tri_state_bridge_flash_bridge_0.sv"                         -work tri_state_bridge_flash_bridge_0       
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_timer.v"                                                    -work timer                                 
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_sysid.vo"                                                   -work sysid                                 
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_sw.v"                                                       -work sw                                    
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/TERASIC_SRAM.v"                                                          -work sram                                  
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_sdram.v"                                                    -work sdram                                 
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_led.v"                                                      -work led                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_lcd_touch_int.v"                                            -work lcd_touch_int                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_lcd.v"                                                      -work lcd                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_key.v"                                                      -work key                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_jtag_uart.v"                                                -work jtag_uart                             
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/i2c_opencores.v"                                                         -work i2c_opencores_0                       
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/i2c_master_top.v"                                                        -work i2c_opencores_0                       
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/i2c_master_defines.v"                                                    -work i2c_opencores_0                       
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/i2c_master_byte_ctrl.v"                                                  -work i2c_opencores_0                       
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/i2c_master_bit_ctrl.v"                                                   -work i2c_opencores_0                       
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/timescale.v"                                                             -work i2c_opencores_0                       
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_epcs_flash_controller.v"                                    -work epcs_flash_controller                 
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cpu.v"                                                      -work cpu                                   
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_mm_clock_crossing_bridge.v"                                -work clock_crossing_io                     
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_avalon_dc_fifo.v"                                                 -work clock_crossing_io                     
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_dcfifo_synchronizer_bundle.v"                                     -work clock_crossing_io                     
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_std_synchronizer_nocut.v"                                         -work clock_crossing_io                     
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_cfi_flash.v"                                                -work cfi_flash                             
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_altpll_0.vo"                                                -work altpll_0                              
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/DE2_115_SOPC_alt_vip_vfr_0.vo"                                           -work alt_vip_vfr_0                         
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid.sv"                                                 -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_sync_compare.v"                                     -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_calculate_mode.v"                                   -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_control.v"                                          -work alt_vip_itc_0                         
  eval  vlog  $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_mode_banks.sv"                                      -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_IS2Vid_statemachine.v"                                     -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_fifo.v"                                             -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_generic_count.v"                                    -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_to_binary.v"                                        -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync.v"                                             -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_trigger_sync.v"                                     -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sync_generation.v"                                  -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_frame_counter.v"                                    -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/alt_vipitc131_common_sample_counter.v"                                   -work alt_vip_itc_0                         
  eval  vlog -v2k5 $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/DE2_115_SOPC.v"                                                                                                                 
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L error_adapter_0 -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L router_001 -L router -L avalon_st_adapter_010 -L avalon_st_adapter_002 -L avalon_st_adapter -L crosser -L sram_avalon_slave_rsp_width_adapter -L rsp_mux_002 -L rsp_mux_001 -L rsp_demux_004 -L cmd_mux_001 -L cmd_demux_002 -L cmd_demux_001 -L sdram_s1_burst_adapter -L cpu_data_master_limiter -L router_013 -L router_008 -L router_005 -L router_004 -L router_003 -L router_002 -L sdram_s1_agent_rsp_fifo -L sdram_s1_agent -L alt_vip_vfr_0_avalon_master_agent -L alt_vip_vfr_0_avalon_master_translator -L arbiter -L pin_sharer -L cpu -L tda -L slave_translator -L tdt -L rst_controller -L irq_synchronizer -L irq_mapper -L mm_interconnect_1 -L mm_interconnect_0 -L tri_state_bridge_flash_pinSharer_0 -L tri_state_bridge_flash_bridge_0 -L timer -L sysid -L sw -L sram -L sdram -L led -L lcd_touch_int -L lcd -L key -L jtag_uart -L i2c_opencores_0 -L epcs_flash_controller -L clock_crossing_io -L cfi_flash -L altpll_0 -L alt_vip_vfr_0 -L alt_vip_itc_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L error_adapter_0 -L rsp_mux -L rsp_demux -L cmd_mux -L cmd_demux -L router_001 -L router -L avalon_st_adapter_010 -L avalon_st_adapter_002 -L avalon_st_adapter -L crosser -L sram_avalon_slave_rsp_width_adapter -L rsp_mux_002 -L rsp_mux_001 -L rsp_demux_004 -L cmd_mux_001 -L cmd_demux_002 -L cmd_demux_001 -L sdram_s1_burst_adapter -L cpu_data_master_limiter -L router_013 -L router_008 -L router_005 -L router_004 -L router_003 -L router_002 -L sdram_s1_agent_rsp_fifo -L sdram_s1_agent -L alt_vip_vfr_0_avalon_master_agent -L alt_vip_vfr_0_avalon_master_translator -L arbiter -L pin_sharer -L cpu -L tda -L slave_translator -L tdt -L rst_controller -L irq_synchronizer -L irq_mapper -L mm_interconnect_1 -L mm_interconnect_0 -L tri_state_bridge_flash_pinSharer_0 -L tri_state_bridge_flash_bridge_0 -L timer -L sysid -L sw -L sram -L sdram -L led -L lcd_touch_int -L lcd -L key -L jtag_uart -L i2c_opencores_0 -L epcs_flash_controller -L clock_crossing_io -L cfi_flash -L altpll_0 -L alt_vip_vfr_0 -L alt_vip_itc_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo "                                 For most designs, this should be overridden"
  echo "                                 to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS  -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS     -- User-defined elaboration options, added to elab/elab_debug aliases."
}
file_copy
h
