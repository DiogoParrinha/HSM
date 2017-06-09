----------------------------------------------------------------------
-- Created by SmartDesign Fri Jun 09 02:35:23 2017
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
-- SHA256_Module
component SHA256_Module
    -- Port list
    port(
        -- Inputs
        CLK                       : in  std_logic;
        RST_N                     : in  std_logic;
        data_in                   : in  std_logic_vector(31 downto 0);
        data_ready                : in  std_logic;
        data_wen                  : in  std_logic;
        result_addr               : in  std_logic_vector(3 downto 0);
        result_ren                : in  std_logic;
        waddr_in                  : in  std_logic_vector(4 downto 0);
        -- Outputs
        data_available            : out std_logic;
        data_available_lastbank_0 : out std_logic;
        data_available_lastbank_8 : out std_logic;
        data_out                  : out std_logic_vector(31 downto 0);
        data_out_ready            : out std_logic;
        di_req_o                  : out std_logic;
        do_valid_o                : out std_logic;
        error_o                   : out std_logic;
        state_out                 : out std_logic_vector(2 downto 0);
        waiting_data              : out std_logic
        );
end component;
-- sha256_system_sb
component sha256_system_sb
    -- Port list
    port(
        -- Inputs
        AMBA_SLAVE_0_HRDATA_S1    : in  std_logic_vector(31 downto 0);
        AMBA_SLAVE_0_HREADYOUT_S1 : in  std_logic;
        AMBA_SLAVE_0_HRESP_S1     : in  std_logic_vector(1 downto 0);
        DEVRST_N                  : in  std_logic;
        FAB_RESET_N               : in  std_logic;
        GPIO_2_F2M                : in  std_logic;
        GPIO_3_F2M                : in  std_logic;
        GPIO_4_F2M                : in  std_logic;
        GPIO_5_F2M                : in  std_logic;
        GPIO_6_F2M                : in  std_logic;
        GPIO_7_F2M                : in  std_logic;
        GPIO_8_F2M                : in  std_logic;
        -- Outputs
        AMBA_SLAVE_0_HADDR_S1     : out std_logic_vector(31 downto 0);
        AMBA_SLAVE_0_HBURST_S1    : out std_logic_vector(2 downto 0);
        AMBA_SLAVE_0_HMASTLOCK_S1 : out std_logic;
        AMBA_SLAVE_0_HPROT_S1     : out std_logic_vector(3 downto 0);
        AMBA_SLAVE_0_HREADY_S1    : out std_logic;
        AMBA_SLAVE_0_HSEL_S1      : out std_logic;
        AMBA_SLAVE_0_HSIZE_S1     : out std_logic_vector(2 downto 0);
        AMBA_SLAVE_0_HTRANS_S1    : out std_logic_vector(1 downto 0);
        AMBA_SLAVE_0_HWDATA_S1    : out std_logic_vector(31 downto 0);
        AMBA_SLAVE_0_HWRITE_S1    : out std_logic;
        FIC_0_CLK                 : out std_logic;
        FIC_0_LOCK                : out std_logic;
        GPIO_0_M2F                : out std_logic;
        GPIO_1_M2F                : out std_logic;
        GPIO_9_M2F                : out std_logic;
        INIT_DONE                 : out std_logic;
        MSS_READY                 : out std_logic;
        POWER_ON_RESET_N          : out std_logic
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
signal AHB_slave_dummy_0_lsram_waddr4to4         : std_logic_vector(4 to 4);
signal AHB_slave_dummy_0_mem_wdata               : std_logic_vector(31 downto 0);
signal AHB_slave_dummy_0_read_en                 : std_logic;
signal AHB_slave_dummy_0_write_en                : std_logic;
signal GPIO_0_M2F_net_0                          : std_logic;
signal SHA256_Module_0_data_available            : std_logic;
signal SHA256_Module_0_data_available_lastbank_8 : std_logic;
signal SHA256_Module_0_data_out                  : std_logic_vector(31 downto 0);
signal SHA256_Module_0_di_req_o                  : std_logic;
signal SHA256_Module_0_do_valid_o                : std_logic;
signal SHA256_Module_0_error_o                   : std_logic;
signal SHA256_Module_0_waiting_data              : std_logic;
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
signal sha256_system_sb_0_GPIO_9_M2F             : std_logic;
signal sha256_system_sb_0_POWER_ON_RESET_N       : std_logic;
signal GPIO_0_M2F_net_1                          : std_logic;
signal lsram_raddr_slice_0                       : std_logic_vector(4 to 4);
signal state_out_slice_0                         : std_logic_vector(0 to 0);
signal state_out_slice_1                         : std_logic_vector(1 to 1);
signal state_out_slice_2                         : std_logic_vector(2 to 2);
signal lsram_waddr_net_0                         : std_logic_vector(8 downto 0);
signal lsram_raddr_net_0                         : std_logic_vector(8 downto 0);
signal result_addr_net_0                         : std_logic_vector(3 downto 0);
signal waddr_in_net_0                            : std_logic_vector(4 downto 0);
signal state_out_net_0                           : std_logic_vector(2 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                   : std_logic;
signal GND_net                                   : std_logic;
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
 GND_net <= '0';
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
 AHB_slave_dummy_0_lsram_waddr4to4(4) <= lsram_waddr_net_0(4);
 lsram_raddr_slice_0(4)               <= lsram_raddr_net_0(4);
 state_out_slice_0(0)                 <= state_out_net_0(0);
 state_out_slice_1(1)                 <= state_out_net_0(1);
 state_out_slice_2(2)                 <= state_out_net_0(2);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 result_addr_net_0 <= ( AHB_slave_dummy_0_lsram_raddr3to3(3) & AHB_slave_dummy_0_lsram_raddr2to2(2) & AHB_slave_dummy_0_lsram_raddr1to1(1) & AHB_slave_dummy_0_lsram_raddr0to0(0) );
 waddr_in_net_0    <= ( AHB_slave_dummy_0_lsram_waddr4to4(4) & AHB_slave_dummy_0_lsram_waddr3to3(3) & AHB_slave_dummy_0_lsram_waddr2to2(2) & AHB_slave_dummy_0_lsram_waddr1to1(1) & AHB_slave_dummy_0_lsram_waddr0to0(0) );
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
        mem_rdata   => SHA256_Module_0_data_out,
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
-- SHA256_Module_0
SHA256_Module_0 : SHA256_Module
    port map( 
        -- Inputs
        CLK                       => sha256_system_sb_0_FIC_0_CLK,
        RST_N                     => sha256_system_sb_0_GPIO_9_M2F,
        data_wen                  => AHB_slave_dummy_0_write_en,
        result_ren                => AHB_slave_dummy_0_read_en,
        data_ready                => sha256_system_sb_0_GPIO_1_M2F,
        data_in                   => AHB_slave_dummy_0_mem_wdata,
        result_addr               => result_addr_net_0,
        waddr_in                  => waddr_in_net_0,
        -- Outputs
        di_req_o                  => SHA256_Module_0_di_req_o,
        data_out_ready            => OPEN,
        do_valid_o                => SHA256_Module_0_do_valid_o,
        error_o                   => SHA256_Module_0_error_o,
        data_available            => SHA256_Module_0_data_available,
        data_available_lastbank_8 => SHA256_Module_0_data_available_lastbank_8,
        data_available_lastbank_0 => OPEN,
        waiting_data              => SHA256_Module_0_waiting_data,
        data_out                  => SHA256_Module_0_data_out,
        state_out                 => state_out_net_0 
        );
-- sha256_system_sb_0
sha256_system_sb_0 : sha256_system_sb
    port map( 
        -- Inputs
        FAB_RESET_N                       => VCC_net,
        AMBA_SLAVE_0_HREADYOUT_S1         => sha256_system_sb_0_AMBA_SLAVE_0_HREADYOUT,
        DEVRST_N                          => DEVRST_N,
        GPIO_2_F2M                        => SHA256_Module_0_waiting_data,
        GPIO_3_F2M                        => SHA256_Module_0_data_available_lastbank_8,
        GPIO_4_F2M                        => SHA256_Module_0_di_req_o,
        GPIO_5_F2M                        => GND_net,
        GPIO_6_F2M                        => SHA256_Module_0_do_valid_o,
        GPIO_7_F2M                        => SHA256_Module_0_data_available,
        GPIO_8_F2M                        => SHA256_Module_0_error_o,
        AMBA_SLAVE_0_HRDATA_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HRDATA,
        AMBA_SLAVE_0_HRESP_S1(1 downto 0) => sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0,
        -- Outputs
        POWER_ON_RESET_N                  => sha256_system_sb_0_POWER_ON_RESET_N,
        INIT_DONE                         => OPEN,
        AMBA_SLAVE_0_HWRITE_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HWRITE,
        AMBA_SLAVE_0_HSEL_S1              => sha256_system_sb_0_AMBA_SLAVE_0_HSELx,
        AMBA_SLAVE_0_HREADY_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HREADY,
        AMBA_SLAVE_0_HMASTLOCK_S1         => sha256_system_sb_0_AMBA_SLAVE_0_HMASTLOCK,
        FIC_0_CLK                         => sha256_system_sb_0_FIC_0_CLK,
        FIC_0_LOCK                        => OPEN,
        MSS_READY                         => OPEN,
        GPIO_0_M2F                        => GPIO_0_M2F_net_0,
        GPIO_1_M2F                        => sha256_system_sb_0_GPIO_1_M2F,
        GPIO_9_M2F                        => sha256_system_sb_0_GPIO_9_M2F,
        AMBA_SLAVE_0_HADDR_S1             => sha256_system_sb_0_AMBA_SLAVE_0_HADDR,
        AMBA_SLAVE_0_HTRANS_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HTRANS,
        AMBA_SLAVE_0_HSIZE_S1             => sha256_system_sb_0_AMBA_SLAVE_0_HSIZE,
        AMBA_SLAVE_0_HWDATA_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HWDATA,
        AMBA_SLAVE_0_HBURST_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HBURST,
        AMBA_SLAVE_0_HPROT_S1             => sha256_system_sb_0_AMBA_SLAVE_0_HPROT 
        );

end RTL;
