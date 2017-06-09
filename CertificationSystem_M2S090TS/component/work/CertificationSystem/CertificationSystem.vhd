----------------------------------------------------------------------
-- Created by SmartDesign Fri Jun 09 13:27:20 2017
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
-- CertificationSystem entity declaration
----------------------------------------------------------------------
entity CertificationSystem is
    -- Port list
    port(
        -- Inputs
        DEVRST_N     : in    std_logic;
        MMUART_1_RXD : in    std_logic;
        SPI_0_DI     : in    std_logic;
        -- Outputs
        GPIO_0_M2F   : out   std_logic;
        MMUART_1_TXD : out   std_logic;
        SPI_0_DO     : out   std_logic;
        -- Inouts
        SPI_0_CLK    : inout std_logic;
        SPI_0_SS0    : inout std_logic
        );
end CertificationSystem;
----------------------------------------------------------------------
-- CertificationSystem architecture body
----------------------------------------------------------------------
architecture RTL of CertificationSystem is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AHB_slave_dummy
-- using entity instantiation for component AHB_slave_dummy
-- CertificationSystem_sb
component CertificationSystem_sb
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in    std_logic;
        FAB_RESET_N      : in    std_logic;
        GPIO_2_F2M       : in    std_logic;
        GPIO_3_F2M       : in    std_logic;
        GPIO_4_F2M       : in    std_logic;
        GPIO_5_F2M       : in    std_logic;
        GPIO_6_F2M       : in    std_logic;
        GPIO_7_F2M       : in    std_logic;
        GPIO_8_F2M       : in    std_logic;
        HRDATA_S5        : in    std_logic_vector(31 downto 0);
        HREADYOUT_S5     : in    std_logic;
        HRESP_S5         : in    std_logic_vector(1 downto 0);
        MMUART_1_RXD     : in    std_logic;
        SPI_0_DI         : in    std_logic;
        -- Outputs
        FAB_CCC_GL0      : out   std_logic;
        FAB_CCC_LOCK     : out   std_logic;
        GPIO_0_M2F       : out   std_logic;
        GPIO_1_M2F       : out   std_logic;
        GPIO_9_M2F       : out   std_logic;
        HADDR_S5         : out   std_logic_vector(31 downto 0);
        HBURST_S5        : out   std_logic_vector(2 downto 0);
        HMASTLOCK_S5     : out   std_logic;
        HPROT_S5         : out   std_logic_vector(3 downto 0);
        HREADY_S5        : out   std_logic;
        HSEL_S5          : out   std_logic;
        HSIZE_S5         : out   std_logic_vector(2 downto 0);
        HTRANS_S5        : out   std_logic_vector(1 downto 0);
        HWDATA_S5        : out   std_logic_vector(31 downto 0);
        HWRITE_S5        : out   std_logic;
        INIT_DONE        : out   std_logic;
        MMUART_1_TXD     : out   std_logic;
        MSS_READY        : out   std_logic;
        POWER_ON_RESET_N : out   std_logic;
        SPI_0_DO         : out   std_logic;
        -- Inouts
        SPI_0_CLK        : inout std_logic;
        SPI_0_SS0        : inout std_logic
        );
end component;
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
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AHB_slave_dummy_0_lsram_raddr0to0             : std_logic_vector(0 to 0);
signal AHB_slave_dummy_0_lsram_raddr1to1             : std_logic_vector(1 to 1);
signal AHB_slave_dummy_0_lsram_raddr2to2             : std_logic_vector(2 to 2);
signal AHB_slave_dummy_0_lsram_raddr3to3             : std_logic_vector(3 to 3);
signal AHB_slave_dummy_0_lsram_waddr0to0             : std_logic_vector(0 to 0);
signal AHB_slave_dummy_0_lsram_waddr1to1             : std_logic_vector(1 to 1);
signal AHB_slave_dummy_0_lsram_waddr2to2             : std_logic_vector(2 to 2);
signal AHB_slave_dummy_0_lsram_waddr3to3             : std_logic_vector(3 to 3);
signal AHB_slave_dummy_0_lsram_waddr4to4             : std_logic_vector(4 to 4);
signal AHB_slave_dummy_0_mem_wdata                   : std_logic_vector(31 downto 0);
signal AHB_slave_dummy_0_read_en                     : std_logic;
signal AHB_slave_dummy_0_write_en                    : std_logic;
signal CertificationSystem_sb_0_AHBmslave5_HADDR     : std_logic_vector(31 downto 0);
signal CertificationSystem_sb_0_AHBmslave5_HBURST    : std_logic_vector(2 downto 0);
signal CertificationSystem_sb_0_AHBmslave5_HMASTLOCK : std_logic;
signal CertificationSystem_sb_0_AHBmslave5_HPROT     : std_logic_vector(3 downto 0);
signal CertificationSystem_sb_0_AHBmslave5_HRDATA    : std_logic_vector(31 downto 0);
signal CertificationSystem_sb_0_AHBmslave5_HREADY    : std_logic;
signal CertificationSystem_sb_0_AHBmslave5_HREADYOUT : std_logic;
signal CertificationSystem_sb_0_AHBmslave5_HSELx     : std_logic;
signal CertificationSystem_sb_0_AHBmslave5_HSIZE     : std_logic_vector(2 downto 0);
signal CertificationSystem_sb_0_AHBmslave5_HTRANS    : std_logic_vector(1 downto 0);
signal CertificationSystem_sb_0_AHBmslave5_HWDATA    : std_logic_vector(31 downto 0);
signal CertificationSystem_sb_0_AHBmslave5_HWRITE    : std_logic;
signal CertificationSystem_sb_0_FAB_CCC_GL0          : std_logic;
signal CertificationSystem_sb_0_GPIO_1_M2F           : std_logic;
signal CertificationSystem_sb_0_GPIO_9_M2F           : std_logic;
signal CertificationSystem_sb_0_POWER_ON_RESET_N     : std_logic;
signal GPIO_0_M2F_net_0                              : std_logic;
signal MMUART_1_TXD_1                                : std_logic;
signal SHA256_Module_0_data_available                : std_logic;
signal SHA256_Module_0_data_available_lastbank_8     : std_logic;
signal SHA256_Module_0_data_out                      : std_logic_vector(31 downto 0);
signal SHA256_Module_0_di_req_o                      : std_logic;
signal SHA256_Module_0_do_valid_o                    : std_logic;
signal SHA256_Module_0_error_o                       : std_logic;
signal SHA256_Module_0_waiting_data                  : std_logic;
signal SPI_0_DO_net_0                                : std_logic;
signal SPI_0_DO_net_1                                : std_logic;
signal GPIO_0_M2F_net_1                              : std_logic;
signal MMUART_1_TXD_1_net_0                          : std_logic;
signal lsram_waddr_net_0                             : std_logic_vector(8 downto 0);
signal lsram_raddr_net_0                             : std_logic_vector(8 downto 0);
signal result_addr_net_0                             : std_logic_vector(3 downto 0);
signal waddr_in_net_0                                : std_logic_vector(4 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                       : std_logic;
signal GND_net                                       : std_logic;
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal CertificationSystem_sb_0_AHBmslave5_HRESP     : std_logic;
signal CertificationSystem_sb_0_AHBmslave5_HRESP_0_1to1: std_logic_vector(1 to 1);
signal CertificationSystem_sb_0_AHBmslave5_HRESP_0_0to0: std_logic_vector(0 to 0);
signal CertificationSystem_sb_0_AHBmslave5_HRESP_0   : std_logic_vector(1 downto 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
 GND_net <= '0';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_0_DO_net_1       <= SPI_0_DO_net_0;
 SPI_0_DO             <= SPI_0_DO_net_1;
 GPIO_0_M2F_net_1     <= GPIO_0_M2F_net_0;
 GPIO_0_M2F           <= GPIO_0_M2F_net_1;
 MMUART_1_TXD_1_net_0 <= MMUART_1_TXD_1;
 MMUART_1_TXD         <= MMUART_1_TXD_1_net_0;
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
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 result_addr_net_0 <= ( AHB_slave_dummy_0_lsram_raddr3to3(3) & AHB_slave_dummy_0_lsram_raddr2to2(2) & AHB_slave_dummy_0_lsram_raddr1to1(1) & AHB_slave_dummy_0_lsram_raddr0to0(0) );
 waddr_in_net_0    <= ( AHB_slave_dummy_0_lsram_waddr4to4(4) & AHB_slave_dummy_0_lsram_waddr3to3(3) & AHB_slave_dummy_0_lsram_waddr2to2(2) & AHB_slave_dummy_0_lsram_waddr1to1(1) & AHB_slave_dummy_0_lsram_waddr0to0(0) );
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 CertificationSystem_sb_0_AHBmslave5_HRESP_0_1to1(1) <= '0';
 CertificationSystem_sb_0_AHBmslave5_HRESP_0_0to0(0) <= CertificationSystem_sb_0_AHBmslave5_HRESP;
 CertificationSystem_sb_0_AHBmslave5_HRESP_0 <= ( CertificationSystem_sb_0_AHBmslave5_HRESP_0_1to1(1) & CertificationSystem_sb_0_AHBmslave5_HRESP_0_0to0(0) );

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
        HCLK        => CertificationSystem_sb_0_FAB_CCC_GL0,
        HRESETn     => CertificationSystem_sb_0_POWER_ON_RESET_N,
        HADDR       => CertificationSystem_sb_0_AHBmslave5_HADDR,
        HTRANS      => CertificationSystem_sb_0_AHBmslave5_HTRANS,
        HWDATA      => CertificationSystem_sb_0_AHBmslave5_HWDATA,
        HWRITE      => CertificationSystem_sb_0_AHBmslave5_HWRITE,
        HSEL        => CertificationSystem_sb_0_AHBmslave5_HSELx,
        HREADY      => CertificationSystem_sb_0_AHBmslave5_HREADY,
        mem_rdata   => SHA256_Module_0_data_out,
        -- Outputs
        HRDATA      => CertificationSystem_sb_0_AHBmslave5_HRDATA,
        HREADYOUT   => CertificationSystem_sb_0_AHBmslave5_HREADYOUT,
        HRESP       => CertificationSystem_sb_0_AHBmslave5_HRESP,
        lsram_waddr => lsram_waddr_net_0,
        lsram_raddr => lsram_raddr_net_0,
        mem_wdata   => AHB_slave_dummy_0_mem_wdata,
        write_en    => AHB_slave_dummy_0_write_en,
        read_en     => AHB_slave_dummy_0_read_en 
        );
-- CertificationSystem_sb_0
CertificationSystem_sb_0 : CertificationSystem_sb
    port map( 
        -- Inputs
        SPI_0_DI             => SPI_0_DI,
        MMUART_1_RXD         => MMUART_1_RXD,
        FAB_RESET_N          => VCC_net,
        DEVRST_N             => DEVRST_N,
        GPIO_2_F2M           => SHA256_Module_0_waiting_data,
        GPIO_3_F2M           => SHA256_Module_0_data_available_lastbank_8,
        GPIO_4_F2M           => SHA256_Module_0_di_req_o,
        GPIO_5_F2M           => GND_net,
        GPIO_6_F2M           => SHA256_Module_0_do_valid_o,
        GPIO_7_F2M           => SHA256_Module_0_data_available,
        GPIO_8_F2M           => SHA256_Module_0_error_o,
        HRDATA_S5            => CertificationSystem_sb_0_AHBmslave5_HRDATA,
        HREADYOUT_S5         => CertificationSystem_sb_0_AHBmslave5_HREADYOUT,
        HRESP_S5(1 downto 0) => CertificationSystem_sb_0_AHBmslave5_HRESP_0,
        -- Outputs
        SPI_0_DO             => SPI_0_DO_net_0,
        MMUART_1_TXD         => MMUART_1_TXD_1,
        POWER_ON_RESET_N     => CertificationSystem_sb_0_POWER_ON_RESET_N,
        INIT_DONE            => OPEN,
        FAB_CCC_GL0          => CertificationSystem_sb_0_FAB_CCC_GL0,
        FAB_CCC_LOCK         => OPEN,
        MSS_READY            => OPEN,
        GPIO_0_M2F           => GPIO_0_M2F_net_0,
        GPIO_1_M2F           => CertificationSystem_sb_0_GPIO_1_M2F,
        GPIO_9_M2F           => CertificationSystem_sb_0_GPIO_9_M2F,
        HADDR_S5             => CertificationSystem_sb_0_AHBmslave5_HADDR,
        HTRANS_S5            => CertificationSystem_sb_0_AHBmslave5_HTRANS,
        HWRITE_S5            => CertificationSystem_sb_0_AHBmslave5_HWRITE,
        HSIZE_S5             => CertificationSystem_sb_0_AHBmslave5_HSIZE,
        HWDATA_S5            => CertificationSystem_sb_0_AHBmslave5_HWDATA,
        HSEL_S5              => CertificationSystem_sb_0_AHBmslave5_HSELx,
        HREADY_S5            => CertificationSystem_sb_0_AHBmslave5_HREADY,
        HMASTLOCK_S5         => CertificationSystem_sb_0_AHBmslave5_HMASTLOCK,
        HBURST_S5            => CertificationSystem_sb_0_AHBmslave5_HBURST,
        HPROT_S5             => CertificationSystem_sb_0_AHBmslave5_HPROT,
        -- Inouts
        SPI_0_CLK            => SPI_0_CLK,
        SPI_0_SS0            => SPI_0_SS0 
        );
-- SHA256_Module_0
SHA256_Module_0 : SHA256_Module
    port map( 
        -- Inputs
        CLK                       => CertificationSystem_sb_0_FAB_CCC_GL0,
        RST_N                     => CertificationSystem_sb_0_GPIO_9_M2F,
        data_in                   => AHB_slave_dummy_0_mem_wdata,
        data_ready                => CertificationSystem_sb_0_GPIO_1_M2F,
        data_wen                  => AHB_slave_dummy_0_write_en,
        result_addr               => result_addr_net_0,
        result_ren                => AHB_slave_dummy_0_read_en,
        waddr_in                  => waddr_in_net_0,
        -- Outputs
        data_available            => SHA256_Module_0_data_available,
        data_available_lastbank_0 => OPEN,
        data_available_lastbank_8 => SHA256_Module_0_data_available_lastbank_8,
        data_out                  => SHA256_Module_0_data_out,
        data_out_ready            => OPEN,
        di_req_o                  => SHA256_Module_0_di_req_o,
        do_valid_o                => SHA256_Module_0_do_valid_o,
        error_o                   => SHA256_Module_0_error_o,
        state_out                 => OPEN,
        waiting_data              => SHA256_Module_0_waiting_data 
        );

end RTL;
