----------------------------------------------------------------------
-- Created by SmartDesign Thu Jun 01 22:25:56 2017
-- Version: v11.7 SP1 11.7.1.14
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- sha256_system entity declaration
----------------------------------------------------------------------
entity sha256_system is
    -- Port list
    port(
        -- Inputs
        DEVRST_N   : in  std_logic;
        -- Outputs
        GPIO_0_M2F : out std_logic
        );
end sha256_system;
----------------------------------------------------------------------
-- sha256_system architecture body
----------------------------------------------------------------------
architecture RTL of sha256_system is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AHB_slave_dummy
-- using entity instantiation for component AHB_slave_dummy
-- gv_sha256
component gv_sha256
    -- Port list
    port(
        -- Inputs
        bytes_i    : in  std_logic_vector(1 downto 0);
        ce_i       : in  std_logic;
        clk_i      : in  std_logic;
        di_i       : in  std_logic_vector(31 downto 0);
        di_wr_i    : in  std_logic;
        end_i      : in  std_logic;
        start_i    : in  std_logic;
        -- Outputs
        H0_o       : out std_logic_vector(31 downto 0);
        H1_o       : out std_logic_vector(31 downto 0);
        H2_o       : out std_logic_vector(31 downto 0);
        H3_o       : out std_logic_vector(31 downto 0);
        H4_o       : out std_logic_vector(31 downto 0);
        H5_o       : out std_logic_vector(31 downto 0);
        H6_o       : out std_logic_vector(31 downto 0);
        H7_o       : out std_logic_vector(31 downto 0);
        di_req_o   : out std_logic;
        do_valid_o : out std_logic;
        error_o    : out std_logic
        );
end component;
-- reg9_1x32
component reg9_1x32
    -- Port list
    port(
        -- Inputs
        CLK       : in  std_logic;
        RST_N     : in  std_logic;
        data_in_0 : in  std_logic_vector(31 downto 0);
        data_in_1 : in  std_logic_vector(31 downto 0);
        data_in_2 : in  std_logic_vector(31 downto 0);
        data_in_3 : in  std_logic_vector(31 downto 0);
        data_in_4 : in  std_logic_vector(31 downto 0);
        data_in_5 : in  std_logic_vector(31 downto 0);
        data_in_6 : in  std_logic_vector(31 downto 0);
        data_in_7 : in  std_logic_vector(31 downto 0);
        data_in_8 : in  std_logic_vector(31 downto 0);
        ren       : in  std_logic;
        sel       : in  std_logic_vector(3 downto 0);
        wen       : in  std_logic;
        -- Outputs
        data_out  : out std_logic_vector(31 downto 0)
        );
end component;
-- reg_16x32
component reg_16x32
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        RST_N          : in  std_logic;
        data_in        : in  std_logic_vector(31 downto 0);
        raddr_in       : in  std_logic_vector(3 downto 0);
        ren            : in  std_logic;
        waddr_in       : in  std_logic_vector(3 downto 0);
        wen            : in  std_logic;
        -- Outputs
        data_out       : out std_logic_vector(31 downto 0);
        data_out_ready : out std_logic
        );
end component;
-- sha256_controller
component sha256_controller
    -- Port list
    port(
        -- Inputs
        data_received : in  std_logic;
        read_data     : in  std_logic_vector(31 downto 0);
        -- Outputs
        bytes_i       : out std_logic_vector(1 downto 0);
        ce_i          : out std_logic;
        di_i          : out std_logic_vector(31 downto 0);
        di_req_o      : out std_logic;
        di_wr_i       : out std_logic;
        end_i         : out std_logic;
        read_addr     : out std_logic_vector(3 downto 0);
        start_i       : out std_logic;
        wait_data     : out std_logic
        );
end component;
-- sha256_system_sb
component sha256_system_sb
    -- Port list
    port(
        -- Inputs
        AMBA_SLAVE_0_HRDATA_S0    : in  std_logic_vector(31 downto 0);
        AMBA_SLAVE_0_HREADYOUT_S0 : in  std_logic;
        AMBA_SLAVE_0_HRESP_S0     : in  std_logic_vector(1 downto 0);
        DEVRST_N                  : in  std_logic;
        FAB_RESET_N               : in  std_logic;
        GPIO_2_F2M                : in  std_logic;
        -- Outputs
        AMBA_SLAVE_0_HADDR_S0     : out std_logic_vector(31 downto 0);
        AMBA_SLAVE_0_HBURST_S0    : out std_logic_vector(2 downto 0);
        AMBA_SLAVE_0_HMASTLOCK_S0 : out std_logic;
        AMBA_SLAVE_0_HPROT_S0     : out std_logic_vector(3 downto 0);
        AMBA_SLAVE_0_HREADY_S0    : out std_logic;
        AMBA_SLAVE_0_HSEL_S0      : out std_logic;
        AMBA_SLAVE_0_HSIZE_S0     : out std_logic_vector(2 downto 0);
        AMBA_SLAVE_0_HTRANS_S0    : out std_logic_vector(1 downto 0);
        AMBA_SLAVE_0_HWDATA_S0    : out std_logic_vector(31 downto 0);
        AMBA_SLAVE_0_HWRITE_S0    : out std_logic;
        FIC_0_CLK                 : out std_logic;
        FIC_0_LOCK                : out std_logic;
        GPIO_0_M2F                : out std_logic;
        GPIO_1_M2F                : out std_logic;
        INIT_DONE                 : out std_logic;
        MSS_READY                 : out std_logic;
        POWER_ON_RESET_N          : out std_logic
        );
end component;
-- zero_concat
component zero_concat
    -- Port list
    port(
        -- Inputs
        s1      : in  std_logic;
        s2      : in  std_logic;
        s3      : in  std_logic;
        -- Outputs
        s_32bit : out std_logic_vector(31 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AHB_slave_dummy_0_lsram_raddr0to0         : std_logic_vector(0 to 0);
signal AHB_slave_dummy_0_lsram_raddr1to1         : std_logic_vector(1 to 1);
signal AHB_slave_dummy_0_lsram_raddr2to2         : std_logic_vector(2 to 2);
signal AHB_slave_dummy_0_lsram_raddr3to3         : std_logic_vector(3 to 3);
signal AHB_slave_dummy_0_lsram_waddr0to0         : std_logic_vector(0 to 0);
signal AHB_slave_dummy_0_lsram_waddr1to1         : std_logic_vector(1 to 1);
signal AHB_slave_dummy_0_lsram_waddr2to2         : std_logic_vector(2 to 2);
signal AHB_slave_dummy_0_lsram_waddr3to3         : std_logic_vector(3 to 3);
signal AHB_slave_dummy_0_mem_wdata               : std_logic_vector(31 downto 0);
signal AHB_slave_dummy_0_read_en                 : std_logic;
signal AHB_slave_dummy_0_write_en                : std_logic;
signal GPIO_0_M2F_net_0                          : std_logic;
signal gv_sha256_0_di_req_o                      : std_logic;
signal gv_sha256_0_do_valid_o                    : std_logic;
signal gv_sha256_0_error_o                       : std_logic;
signal gv_sha256_0_H0_o                          : std_logic_vector(31 downto 0);
signal gv_sha256_0_H1_o                          : std_logic_vector(31 downto 0);
signal gv_sha256_0_H2_o                          : std_logic_vector(31 downto 0);
signal gv_sha256_0_H3_o                          : std_logic_vector(31 downto 0);
signal gv_sha256_0_H4_o                          : std_logic_vector(31 downto 0);
signal gv_sha256_0_H5_o                          : std_logic_vector(31 downto 0);
signal gv_sha256_0_H6_o                          : std_logic_vector(31 downto 0);
signal gv_sha256_0_H7_o                          : std_logic_vector(31 downto 0);
signal reg9_1x32_0_data_out                      : std_logic_vector(31 downto 0);
signal reg_2x32_0_data_out                       : std_logic_vector(31 downto 0);
signal reg_16x32_0_data_out_ready                : std_logic;
signal sha256_controller_0_bytes_i               : std_logic_vector(1 downto 0);
signal sha256_controller_0_ce_i                  : std_logic;
signal sha256_controller_0_di_i                  : std_logic_vector(31 downto 0);
signal sha256_controller_0_di_req_o              : std_logic;
signal sha256_controller_0_di_wr_i               : std_logic;
signal sha256_controller_0_end_i                 : std_logic;
signal sha256_controller_0_read_addr_0           : std_logic_vector(3 downto 0);
signal sha256_controller_0_start_i               : std_logic;
signal sha256_controller_0_wait_data             : std_logic;
signal sha256_system_sb_0_AMBA_SLAVE_0_HADDR     : std_logic_vector(31 downto 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HBURST    : std_logic_vector(2 downto 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HMASTLOCK : std_logic;
signal sha256_system_sb_0_AMBA_SLAVE_0_HPROT     : std_logic_vector(3 downto 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HRDATA    : std_logic_vector(31 downto 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HREADY    : std_logic;
signal sha256_system_sb_0_AMBA_SLAVE_0_HREADYOUT : std_logic;
signal sha256_system_sb_0_AMBA_SLAVE_0_HSELx     : std_logic;
signal sha256_system_sb_0_AMBA_SLAVE_0_HSIZE     : std_logic_vector(2 downto 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HTRANS    : std_logic_vector(1 downto 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HWDATA    : std_logic_vector(31 downto 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HWRITE    : std_logic;
signal sha256_system_sb_0_FIC_0_CLK              : std_logic;
signal sha256_system_sb_0_GPIO_1_M2F             : std_logic;
signal sha256_system_sb_0_POWER_ON_RESET_N       : std_logic;
signal zero_concat_0_s_32bit                     : std_logic_vector(31 downto 0);
signal GPIO_0_M2F_net_1                          : std_logic;
signal lsram_waddr_slice_0                       : std_logic_vector(4 to 4);
signal lsram_waddr_slice_1                       : std_logic_vector(5 to 5);
signal lsram_waddr_slice_2                       : std_logic_vector(6 to 6);
signal lsram_waddr_slice_3                       : std_logic_vector(7 to 7);
signal lsram_raddr_slice_0                       : std_logic_vector(4 to 4);
signal lsram_raddr_slice_1                       : std_logic_vector(5 to 5);
signal lsram_raddr_slice_2                       : std_logic_vector(6 to 6);
signal lsram_raddr_slice_3                       : std_logic_vector(7 to 7);
signal lsram_waddr_net_0                         : std_logic_vector(8 downto 0);
signal lsram_raddr_net_0                         : std_logic_vector(8 downto 0);
signal sel_net_0                                 : std_logic_vector(3 downto 0);
signal waddr_in_net_0                            : std_logic_vector(3 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                   : std_logic;
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal sha256_system_sb_0_AMBA_SLAVE_0_HRESP     : std_logic;
signal sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0_1to1: std_logic_vector(1 to 1);
signal sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0_0to0: std_logic_vector(0 to 0);
signal sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0   : std_logic_vector(1 downto 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 GPIO_0_M2F_net_1 <= GPIO_0_M2F_net_0;
 GPIO_0_M2F       <= GPIO_0_M2F_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 AHB_slave_dummy_0_lsram_raddr0to0(0) <= lsram_raddr_net_0(0);
 AHB_slave_dummy_0_lsram_raddr1to1(1) <= lsram_raddr_net_0(1);
 AHB_slave_dummy_0_lsram_raddr2to2(2) <= lsram_raddr_net_0(2);
 AHB_slave_dummy_0_lsram_raddr3to3(3) <= lsram_raddr_net_0(3);
 AHB_slave_dummy_0_lsram_waddr0to0(0) <= lsram_waddr_net_0(0);
 AHB_slave_dummy_0_lsram_waddr1to1(1) <= lsram_waddr_net_0(1);
 AHB_slave_dummy_0_lsram_waddr2to2(2) <= lsram_waddr_net_0(2);
 AHB_slave_dummy_0_lsram_waddr3to3(3) <= lsram_waddr_net_0(3);
 lsram_waddr_slice_0(4)               <= lsram_waddr_net_0(4);
 lsram_waddr_slice_1(5)               <= lsram_waddr_net_0(5);
 lsram_waddr_slice_2(6)               <= lsram_waddr_net_0(6);
 lsram_waddr_slice_3(7)               <= lsram_waddr_net_0(7);
 lsram_raddr_slice_0(4)               <= lsram_raddr_net_0(4);
 lsram_raddr_slice_1(5)               <= lsram_raddr_net_0(5);
 lsram_raddr_slice_2(6)               <= lsram_raddr_net_0(6);
 lsram_raddr_slice_3(7)               <= lsram_raddr_net_0(7);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 sel_net_0      <= ( AHB_slave_dummy_0_lsram_raddr3to3(3) & AHB_slave_dummy_0_lsram_raddr2to2(2) & AHB_slave_dummy_0_lsram_raddr1to1(1) & AHB_slave_dummy_0_lsram_raddr0to0(0) );
 waddr_in_net_0 <= ( AHB_slave_dummy_0_lsram_waddr3to3(3) & AHB_slave_dummy_0_lsram_waddr2to2(2) & AHB_slave_dummy_0_lsram_waddr1to1(1) & AHB_slave_dummy_0_lsram_waddr0to0(0) );
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0_1to1(1) <= '0';
 sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0_0to0(0) <= sha256_system_sb_0_AMBA_SLAVE_0_HRESP;
 sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0 <= ( sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0_1to1(1) & sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0_0to0(0) );

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AHB_slave_dummy_0
AHB_slave_dummy_0 : entity work.AHB_slave_dummy
    generic map( 
        pipeline => ( 0 )
        )
    port map( 
        -- Inputs
        HCLK        => sha256_system_sb_0_FIC_0_CLK,
        HRESETn     => sha256_system_sb_0_POWER_ON_RESET_N,
        HWRITE      => sha256_system_sb_0_AMBA_SLAVE_0_HWRITE,
        HSEL        => sha256_system_sb_0_AMBA_SLAVE_0_HSELx,
        HREADY      => sha256_system_sb_0_AMBA_SLAVE_0_HREADY,
        HADDR       => sha256_system_sb_0_AMBA_SLAVE_0_HADDR,
        HTRANS      => sha256_system_sb_0_AMBA_SLAVE_0_HTRANS,
        HWDATA      => sha256_system_sb_0_AMBA_SLAVE_0_HWDATA,
        mem_rdata   => reg9_1x32_0_data_out,
        -- Outputs
        HREADYOUT   => sha256_system_sb_0_AMBA_SLAVE_0_HREADYOUT,
        HRESP       => sha256_system_sb_0_AMBA_SLAVE_0_HRESP,
        write_en    => AHB_slave_dummy_0_write_en,
        read_en     => AHB_slave_dummy_0_read_en,
        HRDATA      => sha256_system_sb_0_AMBA_SLAVE_0_HRDATA,
        lsram_waddr => lsram_waddr_net_0,
        lsram_raddr => lsram_raddr_net_0,
        mem_wdata   => AHB_slave_dummy_0_mem_wdata 
        );
-- gv_sha256_0
gv_sha256_0 : gv_sha256
    port map( 
        -- Inputs
        clk_i      => sha256_system_sb_0_FIC_0_CLK,
        ce_i       => sha256_controller_0_ce_i,
        start_i    => sha256_controller_0_start_i,
        end_i      => sha256_controller_0_end_i,
        di_wr_i    => sha256_controller_0_di_wr_i,
        di_i       => sha256_controller_0_di_i,
        bytes_i    => sha256_controller_0_bytes_i,
        -- Outputs
        di_req_o   => gv_sha256_0_di_req_o,
        error_o    => gv_sha256_0_error_o,
        do_valid_o => gv_sha256_0_do_valid_o,
        H0_o       => gv_sha256_0_H0_o,
        H1_o       => gv_sha256_0_H1_o,
        H2_o       => gv_sha256_0_H2_o,
        H3_o       => gv_sha256_0_H3_o,
        H4_o       => gv_sha256_0_H4_o,
        H5_o       => gv_sha256_0_H5_o,
        H6_o       => gv_sha256_0_H6_o,
        H7_o       => gv_sha256_0_H7_o 
        );
-- reg9_1x32_0
reg9_1x32_0 : reg9_1x32
    port map( 
        -- Inputs
        CLK       => sha256_system_sb_0_FIC_0_CLK,
        RST_N     => sha256_system_sb_0_POWER_ON_RESET_N,
        wen       => gv_sha256_0_do_valid_o,
        ren       => AHB_slave_dummy_0_read_en,
        data_in_2 => gv_sha256_0_H2_o,
        data_in_8 => zero_concat_0_s_32bit,
        data_in_1 => gv_sha256_0_H1_o,
        data_in_5 => gv_sha256_0_H5_o,
        data_in_0 => gv_sha256_0_H0_o,
        data_in_3 => gv_sha256_0_H3_o,
        data_in_4 => gv_sha256_0_H4_o,
        data_in_6 => gv_sha256_0_H6_o,
        data_in_7 => gv_sha256_0_H7_o,
        sel       => sel_net_0,
        -- Outputs
        data_out  => reg9_1x32_0_data_out 
        );
-- reg_16x32_0
reg_16x32_0 : reg_16x32
    port map( 
        -- Inputs
        CLK            => sha256_system_sb_0_FIC_0_CLK,
        RST_N          => sha256_system_sb_0_POWER_ON_RESET_N,
        data_in        => AHB_slave_dummy_0_mem_wdata,
        waddr_in       => waddr_in_net_0,
        raddr_in       => sha256_controller_0_read_addr_0,
        wen            => AHB_slave_dummy_0_write_en,
        ren            => sha256_system_sb_0_GPIO_1_M2F,
        -- Outputs
        data_out       => reg_2x32_0_data_out,
        data_out_ready => reg_16x32_0_data_out_ready 
        );
-- sha256_controller_0
sha256_controller_0 : sha256_controller
    port map( 
        -- Inputs
        read_data     => reg_2x32_0_data_out,
        data_received => reg_16x32_0_data_out_ready,
        -- Outputs
        read_addr     => sha256_controller_0_read_addr_0,
        wait_data     => sha256_controller_0_wait_data,
        ce_i          => sha256_controller_0_ce_i,
        di_i          => sha256_controller_0_di_i,
        bytes_i       => sha256_controller_0_bytes_i,
        start_i       => sha256_controller_0_start_i,
        end_i         => sha256_controller_0_end_i,
        di_req_o      => sha256_controller_0_di_req_o,
        di_wr_i       => sha256_controller_0_di_wr_i 
        );
-- sha256_system_sb_0
sha256_system_sb_0 : sha256_system_sb
    port map( 
        -- Inputs
        FAB_RESET_N                       => VCC_net,
        AMBA_SLAVE_0_HRDATA_S0            => sha256_system_sb_0_AMBA_SLAVE_0_HRDATA,
        AMBA_SLAVE_0_HREADYOUT_S0         => sha256_system_sb_0_AMBA_SLAVE_0_HREADYOUT,
        AMBA_SLAVE_0_HRESP_S0(1 downto 0) => sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0,
        DEVRST_N                          => DEVRST_N,
        GPIO_2_F2M                        => sha256_controller_0_di_req_o,
        -- Outputs
        POWER_ON_RESET_N                  => sha256_system_sb_0_POWER_ON_RESET_N,
        INIT_DONE                         => OPEN,
        AMBA_SLAVE_0_HADDR_S0             => sha256_system_sb_0_AMBA_SLAVE_0_HADDR,
        AMBA_SLAVE_0_HTRANS_S0            => sha256_system_sb_0_AMBA_SLAVE_0_HTRANS,
        AMBA_SLAVE_0_HWRITE_S0            => sha256_system_sb_0_AMBA_SLAVE_0_HWRITE,
        AMBA_SLAVE_0_HSIZE_S0             => sha256_system_sb_0_AMBA_SLAVE_0_HSIZE,
        AMBA_SLAVE_0_HWDATA_S0            => sha256_system_sb_0_AMBA_SLAVE_0_HWDATA,
        AMBA_SLAVE_0_HSEL_S0              => sha256_system_sb_0_AMBA_SLAVE_0_HSELx,
        AMBA_SLAVE_0_HREADY_S0            => sha256_system_sb_0_AMBA_SLAVE_0_HREADY,
        AMBA_SLAVE_0_HMASTLOCK_S0         => sha256_system_sb_0_AMBA_SLAVE_0_HMASTLOCK,
        AMBA_SLAVE_0_HBURST_S0            => sha256_system_sb_0_AMBA_SLAVE_0_HBURST,
        AMBA_SLAVE_0_HPROT_S0             => sha256_system_sb_0_AMBA_SLAVE_0_HPROT,
        FIC_0_CLK                         => sha256_system_sb_0_FIC_0_CLK,
        FIC_0_LOCK                        => OPEN,
        MSS_READY                         => OPEN,
        GPIO_0_M2F                        => GPIO_0_M2F_net_0,
        GPIO_1_M2F                        => sha256_system_sb_0_GPIO_1_M2F 
        );
-- zero_concat_0
zero_concat_0 : zero_concat
    port map( 
        -- Inputs
        s1      => gv_sha256_0_do_valid_o,
        s2      => gv_sha256_0_di_req_o,
        s3      => gv_sha256_0_error_o,
        -- Outputs
        s_32bit => zero_concat_0_s_32bit 
        );

end RTL;
