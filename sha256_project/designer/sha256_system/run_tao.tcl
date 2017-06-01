set_family {SmartFusion2}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\components.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite_addrdec.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite_defaultslavesm.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite_masterstage.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite_matrix4x16.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite_pkg.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite_slavearbiter.vhd}
read_vhdl -mode vhdl_2008 -lib COREAHBLITE_LIB {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreAHBLite\5.2.100\rtl\vhdl\core\coreahblite_slavestage.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vhdl\core\coreresetp.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vhdl\core\coreresetp_pcie_hotreset.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\component\work\sha256_system\sha256_system.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\component\work\sha256_system_sb\CCC_0\sha256_system_sb_CCC_0_FCCC.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\component\work\sha256_system_sb\FABOSC_0\sha256_system_sb_FABOSC_0_OSC.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\component\work\sha256_system_sb\sha256_system_sb.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\component\work\sha256_system_sb_MSS\sha256_system_sb_MSS.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\hdl\AHB_slave_dummy.vhd}
read_vhdl -mode vhdl_2008 {E:\LiberoProjects\sha256_project\hdl\reg_2x32.vhd}
set_top_level {sha256_system}
map_netlist
check_constraints {E:\LiberoProjects\sha256_project\constraint\synthesis_sdc_errors.log}
write_fdc {E:\LiberoProjects\sha256_project\designer\sha256_system\synthesis.fdc}
