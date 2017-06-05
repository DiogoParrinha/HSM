----------------------------------------------------------------------
-- Created by SmartDesign Mon Jun 05 18:42:44 2017
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
-- limiter_1cycle
component limiter_1cycle
    -- Port list
    port(
        -- Inputs
        CLK         : in  std_logic;
        sig_xcycles : in  std_logic;
        -- Outputs
        sig_1cycle  : out std_logic
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
-- SHA256_BLOCK
component SHA256_BLOCK
    -- Port list
    port(
        -- Inputs
        CLK         : in  std_logic;
        RST_N       : in  std_logic;
        data_in     : in  std_logic_vector(31 downto 0);
        first_block : in  std_logic;
        last_block  : in  std_logic;
        ren         : in  std_logic;
        waddr_in    : in  std_logic_vector(3 downto 0);
        wen         : in  std_logic;
        -- Outputs
        H0_o        : out std_logic_vector(31 downto 0);
        H1_o        : out std_logic_vector(31 downto 0);
        H2_o        : out std_logic_vector(31 downto 0);
        H3_o        : out std_logic_vector(31 downto 0);
        H4_o        : out std_logic_vector(31 downto 0);
        H5_o        : out std_logic_vector(31 downto 0);
        H6_o        : out std_logic_vector(31 downto 0);
        H7_o        : out std_logic_vector(31 downto 0);
        di_req_o    : out std_logic;
        do_valid_o  : out std_logic;
        error_o     : out std_logic
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
        GPIO_4_F2M                : in  std_logic;
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
        GPIO_2_M2F                : out std_logic;
        GPIO_3_M2F                : out std_logic;
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
signal limiter_1cycle_1_sig_1cycle               : std_logic;
signal limiter_1cycle_first_block_sig_1cycle     : std_logic;
signal reg9_1x32_0_data_out                      : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_di_req_o                   : std_logic;
signal SHA256_BLOCK_0_do_valid_o                 : std_logic;
signal SHA256_BLOCK_0_error_o                    : std_logic;
signal SHA256_BLOCK_0_H0_o                       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H1_o                       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H2_o                       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H3_o                       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H4_o                       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H5_o                       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H6_o                       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H7_o                       : std_logic_vector(31 downto 0);
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
signal sha256_system_sb_0_GPIO_2_M2F             : std_logic;
signal sha256_system_sb_0_GPIO_3_M2F             : std_logic;
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
-- limiter_1cycle_first_block
limiter_1cycle_first_block : limiter_1cycle
    port map( 
        -- Inputs
        CLK         => sha256_system_sb_0_FIC_0_CLK,
        sig_xcycles => sha256_system_sb_0_GPIO_3_M2F,
        -- Outputs
        sig_1cycle  => limiter_1cycle_first_block_sig_1cycle 
        );
-- limiter_1cycle_ren
limiter_1cycle_ren : limiter_1cycle
    port map( 
        -- Inputs
        CLK         => sha256_system_sb_0_FIC_0_CLK,
        sig_xcycles => sha256_system_sb_0_GPIO_1_M2F,
        -- Outputs
        sig_1cycle  => limiter_1cycle_1_sig_1cycle 
        );
-- reg9_1x32_0
reg9_1x32_0 : reg9_1x32
    port map( 
        -- Inputs
        CLK       => sha256_system_sb_0_FIC_0_CLK,
        RST_N     => sha256_system_sb_0_POWER_ON_RESET_N,
        wen       => SHA256_BLOCK_0_do_valid_o,
        ren       => AHB_slave_dummy_0_read_en,
        data_in_2 => SHA256_BLOCK_0_H2_o,
        data_in_8 => zero_concat_0_s_32bit,
        data_in_1 => SHA256_BLOCK_0_H1_o,
        data_in_5 => SHA256_BLOCK_0_H5_o,
        data_in_0 => SHA256_BLOCK_0_H0_o,
        data_in_3 => SHA256_BLOCK_0_H3_o,
        data_in_4 => SHA256_BLOCK_0_H4_o,
        data_in_6 => SHA256_BLOCK_0_H6_o,
        data_in_7 => SHA256_BLOCK_0_H7_o,
        sel       => sel_net_0,
        -- Outputs
        data_out  => reg9_1x32_0_data_out 
        );
-- SHA256_BLOCK_0
SHA256_BLOCK_0 : SHA256_BLOCK
    port map( 
        -- Inputs
        CLK         => sha256_system_sb_0_FIC_0_CLK,
        RST_N       => sha256_system_sb_0_POWER_ON_RESET_N,
        wen         => AHB_slave_dummy_0_write_en,
        ren         => limiter_1cycle_1_sig_1cycle,
        data_in     => AHB_slave_dummy_0_mem_wdata,
        waddr_in    => waddr_in_net_0,
        last_block  => sha256_system_sb_0_GPIO_2_M2F,
        first_block => limiter_1cycle_first_block_sig_1cycle,
        -- Outputs
        do_valid_o  => SHA256_BLOCK_0_do_valid_o,
        error_o     => SHA256_BLOCK_0_error_o,
        di_req_o    => SHA256_BLOCK_0_di_req_o,
        H0_o        => SHA256_BLOCK_0_H0_o,
        H1_o        => SHA256_BLOCK_0_H1_o,
        H2_o        => SHA256_BLOCK_0_H2_o,
        H3_o        => SHA256_BLOCK_0_H3_o,
        H4_o        => SHA256_BLOCK_0_H4_o,
        H5_o        => SHA256_BLOCK_0_H5_o,
        H6_o        => SHA256_BLOCK_0_H6_o,
        H7_o        => SHA256_BLOCK_0_H7_o 
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
        GPIO_4_F2M                        => SHA256_BLOCK_0_di_req_o,
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
        GPIO_1_M2F                        => sha256_system_sb_0_GPIO_1_M2F,
        GPIO_2_M2F                        => sha256_system_sb_0_GPIO_2_M2F,
        GPIO_3_M2F                        => sha256_system_sb_0_GPIO_3_M2F 
        );
-- zero_concat_0
zero_concat_0 : zero_concat
    port map( 
        -- Inputs
        s1      => SHA256_BLOCK_0_do_valid_o,
        s2      => SHA256_BLOCK_0_di_req_o,
        s3      => SHA256_BLOCK_0_error_o,
        -- Outputs
        s_32bit => zero_concat_0_s_32bit 
        );

end RTL;
