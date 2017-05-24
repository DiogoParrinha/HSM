----------------------------------------------------------------------
-- Created by SmartDesign Tue May 23 16:41:52 2017
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
        GPIO_0_OUT : out std_logic
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
-- reg_2x32
component reg_2x32
    -- Port list
    port(
        -- Inputs
        clk      : in  std_logic;
        data_in  : in  std_logic_vector(31 downto 0);
        raddr    : in  std_logic;
        ren      : in  std_logic;
        rst      : in  std_logic;
        waddr    : in  std_logic;
        wen      : in  std_logic;
        -- Outputs
        data_out : out std_logic_vector(31 downto 0)
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
        GPIO_0_OUT                : out std_logic;
        GPIO_1_M2F                : out std_logic;
        GPIO_2_M2F                : out std_logic;
        INIT_DONE                 : out std_logic;
        MSS_READY                 : out std_logic;
        POWER_ON_RESET_N          : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AHB_slave_dummy_0_lsram_raddr0to0         : std_logic_vector(0 to 0);
signal AHB_slave_dummy_0_lsram_waddr0to0         : std_logic_vector(0 to 0);
signal AHB_slave_dummy_0_mem_wdata               : std_logic_vector(31 downto 0);
signal AHB_slave_dummy_0_read_en                 : std_logic;
signal AHB_slave_dummy_0_write_en                : std_logic;
signal GPIO_0_OUT_net_0                          : std_logic;
signal reg_2x32_0_data_out                       : std_logic_vector(31 downto 0);
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
signal sha256_system_sb_0_POWER_ON_RESET_N       : std_logic;
signal GPIO_0_OUT_net_1                          : std_logic;
signal lsram_waddr_net_0                         : std_logic_vector(8 downto 0);
signal lsram_raddr_net_0                         : std_logic_vector(8 downto 0);
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
 GPIO_0_OUT_net_1 <= GPIO_0_OUT_net_0;
 GPIO_0_OUT       <= GPIO_0_OUT_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 AHB_slave_dummy_0_lsram_raddr0to0(0) <= lsram_raddr_net_0(0);
 AHB_slave_dummy_0_lsram_waddr0to0(0) <= lsram_waddr_net_0(0);
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
        HADDR       => sha256_system_sb_0_AMBA_SLAVE_0_HADDR,
        HTRANS      => sha256_system_sb_0_AMBA_SLAVE_0_HTRANS,
        HWDATA      => sha256_system_sb_0_AMBA_SLAVE_0_HWDATA,
        HWRITE      => sha256_system_sb_0_AMBA_SLAVE_0_HWRITE,
        HSEL        => sha256_system_sb_0_AMBA_SLAVE_0_HSELx,
        HREADY      => sha256_system_sb_0_AMBA_SLAVE_0_HREADY,
        mem_rdata   => reg_2x32_0_data_out,
        -- Outputs
        HRDATA      => sha256_system_sb_0_AMBA_SLAVE_0_HRDATA,
        HREADYOUT   => sha256_system_sb_0_AMBA_SLAVE_0_HREADYOUT,
        HRESP       => sha256_system_sb_0_AMBA_SLAVE_0_HRESP,
        lsram_waddr => lsram_waddr_net_0,
        lsram_raddr => lsram_raddr_net_0,
        mem_wdata   => AHB_slave_dummy_0_mem_wdata,
        write_en    => AHB_slave_dummy_0_write_en,
        read_en     => AHB_slave_dummy_0_read_en 
        );
-- reg_2x32_0
reg_2x32_0 : reg_2x32
    port map( 
        -- Inputs
        data_in  => AHB_slave_dummy_0_mem_wdata,
        clk      => sha256_system_sb_0_FIC_0_CLK,
        rst      => sha256_system_sb_0_POWER_ON_RESET_N,
        wen      => AHB_slave_dummy_0_write_en,
        ren      => AHB_slave_dummy_0_read_en,
        waddr    => AHB_slave_dummy_0_lsram_waddr0to0(0),
        raddr    => AHB_slave_dummy_0_lsram_raddr0to0(0),
        -- Outputs
        data_out => reg_2x32_0_data_out 
        );
-- sha256_system_sb_0
sha256_system_sb_0 : sha256_system_sb
    port map( 
        -- Inputs
        FAB_RESET_N                       => VCC_net,
        AMBA_SLAVE_0_HRDATA_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HRDATA,
        AMBA_SLAVE_0_HREADYOUT_S1         => sha256_system_sb_0_AMBA_SLAVE_0_HREADYOUT,
        AMBA_SLAVE_0_HRESP_S1(1 downto 0) => sha256_system_sb_0_AMBA_SLAVE_0_HRESP_0,
        DEVRST_N                          => DEVRST_N,
        -- Outputs
        POWER_ON_RESET_N                  => sha256_system_sb_0_POWER_ON_RESET_N,
        INIT_DONE                         => OPEN,
        GPIO_0_OUT                        => GPIO_0_OUT_net_0,
        AMBA_SLAVE_0_HADDR_S1             => sha256_system_sb_0_AMBA_SLAVE_0_HADDR,
        AMBA_SLAVE_0_HTRANS_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HTRANS,
        AMBA_SLAVE_0_HWRITE_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HWRITE,
        AMBA_SLAVE_0_HSIZE_S1             => sha256_system_sb_0_AMBA_SLAVE_0_HSIZE,
        AMBA_SLAVE_0_HWDATA_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HWDATA,
        AMBA_SLAVE_0_HSEL_S1              => sha256_system_sb_0_AMBA_SLAVE_0_HSELx,
        AMBA_SLAVE_0_HREADY_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HREADY,
        AMBA_SLAVE_0_HMASTLOCK_S1         => sha256_system_sb_0_AMBA_SLAVE_0_HMASTLOCK,
        AMBA_SLAVE_0_HBURST_S1            => sha256_system_sb_0_AMBA_SLAVE_0_HBURST,
        AMBA_SLAVE_0_HPROT_S1             => sha256_system_sb_0_AMBA_SLAVE_0_HPROT,
        FIC_0_CLK                         => sha256_system_sb_0_FIC_0_CLK,
        FIC_0_LOCK                        => OPEN,
        MSS_READY                         => OPEN,
        GPIO_1_M2F                        => OPEN,
        GPIO_2_M2F                        => OPEN 
        );

end RTL;
