onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sha256_module_tb_swlike/clk
add wave -noupdate /sha256_module_tb_swlike/RST_N
add wave -noupdate /sha256_module_tb_swlike/data_wen
add wave -noupdate /sha256_module_tb_swlike/data_in
add wave -noupdate /sha256_module_tb_swlike/waddr_in
add wave -noupdate /sha256_module_tb_swlike/result_addr
add wave -noupdate /sha256_module_tb_swlike/result_ren
add wave -noupdate /sha256_module_tb_swlike/data_ready
add wave -noupdate /sha256_module_tb_swlike/di_req_o
add wave -noupdate /sha256_module_tb_swlike/data_out
add wave -noupdate /sha256_module_tb_swlike/data_available
add wave -noupdate /sha256_module_tb_swlike/data_out_ready
add wave -noupdate /sha256_module_tb_swlike/error_o
add wave -noupdate /sha256_module_tb_swlike/do_valid_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/CLK
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/RST_N
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/data_in
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/ren
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/waddr_in
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/wen
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H0_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H1_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H2_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H3_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H4_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H5_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H6_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/H7_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/data_available
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/data_out_ready
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/di_req_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/do_valid_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/error_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/first_block
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/last_block
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg0_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg10_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg11_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg12_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg13_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg14_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg15_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg16_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg1_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg2_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg3_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg4_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg5_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg6_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg7_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg8_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/reg9_out
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/start_o
add wave -noupdate -group block /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/state_out
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/read_addr
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/read_data
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/data_ready
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/last_block
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/first_block
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/state_out
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/clk
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/RST_N
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/ce_o
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/di_o
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/bytes_o
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/start_o
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/end_o
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/di_req_i
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/di_wr_o
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/di_valid_i
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/counter
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/state
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/sel_di
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/start_counting
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/extra_add
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/restart
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/new_block
add wave -noupdate -group controller /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/sha256_controller_0/blocks_counter
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/clk_i
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/ce_i
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/di_i
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/bytes_i
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/start_i
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/end_i
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/di_req_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/di_wr_i
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/error_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/do_valid_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H0_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H1_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H2_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H3_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H4_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H5_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H6_o
add wave -noupdate -expand -group sha256 /sha256_module_tb_swlike/SHA256_Module_0/SHA256_BLOCK_0/gv_sha256_0/H7_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7675000000 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 520
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {6166394779 fs} {15511892409 fs}
