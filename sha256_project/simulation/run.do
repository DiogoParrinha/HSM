quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "E:/LiberoProjects/sha256_project"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v11.7///Designer//lib//modelsim//precompiled/vhdl/SmartFusion2"
vmap COREAHBLITE_LIB "../component/Actel/DirectCore/CoreAHBLite/5.2.100/mti/user_vhdl/COREAHBLITE_LIB"
vcom -work COREAHBLITE_LIB -force_refresh
vlog -work COREAHBLITE_LIB -force_refresh
if {[file exists COREAHBLSRAM_LIB/_info]} {
   echo "INFO: Simulation library COREAHBLSRAM_LIB already exists"
} else {
   file delete -force COREAHBLSRAM_LIB 
   vlib COREAHBLSRAM_LIB
}
vmap COREAHBLSRAM_LIB "COREAHBLSRAM_LIB"

vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/mux_9_1.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/reg_1x32.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/reg9_1x32/reg9_1x32.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/zero_concat.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_control.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_hash_core.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_Ki_rom.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_Kt_rom.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_msg_sch.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_padding.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_regs.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/gv_sha256.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/limiter_1cycle.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/sha256_controller.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/reg_2x32.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SHA256_BLOCK/SHA256_BLOCK.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/SHA256_Module/SHA256_Module.vhd"
vcom -2008 -explicit  -work COREAHBLITE_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAHBLite/5.2.100/rtl/vhdl/core/components.vhd"
vcom -2008 -explicit  -work COREAHBLITE_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAHBLite/5.2.100/rtl/vhdl/core/coreahblite_addrdec.vhd"
vcom -2008 -explicit  -work COREAHBLITE_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAHBLite/5.2.100/rtl/vhdl/core/coreahblite_pkg.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/stimulus/sha256_module_tb_softwarelike.vhd"

vsim -L SmartFusion2 -L presynth -L COREAHBLITE_LIB -L COREAHBLSRAM_LIB  -t 1fs presynth.SHA256_Module_tb_swlike
add wave /SHA256_Module_tb_swlike/*
run 1000ns
