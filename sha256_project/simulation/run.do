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

vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/reg_2x32.vhd"
vcom -2008 -explicit  -work COREAHBLITE_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAHBLite/5.2.100/rtl/vhdl/core/components.vhd"
vcom -2008 -explicit  -work COREAHBLITE_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAHBLite/5.2.100/rtl/vhdl/core/coreahblite_addrdec.vhd"
vcom -2008 -explicit  -work COREAHBLITE_LIB "${PROJECT_DIR}/component/Actel/DirectCore/CoreAHBLite/5.2.100/rtl/vhdl/core/coreahblite_pkg.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/stimulus/reg_16x32_tb.vhd"

vsim -L SmartFusion2 -L presynth -L COREAHBLITE_LIB -L COREAHBLSRAM_LIB  -t 1fs presynth.reg_16x32_tb
add wave /reg_16x32_tb/*
run 1000ns
