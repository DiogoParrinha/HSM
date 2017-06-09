----------------------------------------------------------------------
-- Created by SmartDesign Fri Feb 24 19:09:36 2017
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
-- CertificationSystem_sb
component CertificationSystem_sb
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in    std_logic;
        FAB_RESET_N      : in    std_logic;
        MMUART_1_RXD     : in    std_logic;
        SPI_0_DI         : in    std_logic;
        -- Outputs
        FAB_CCC_GL0      : out   std_logic;
        FAB_CCC_LOCK     : out   std_logic;
        GPIO_0_M2F       : out   std_logic;
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
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal GPIO_0_M2F_net_0     : std_logic;
signal MMUART_1_TXD_0       : std_logic;
signal SPI_0_DO_net_0       : std_logic;
signal SPI_0_DO_net_1       : std_logic;
signal GPIO_0_M2F_net_1     : std_logic;
signal MMUART_1_TXD_0_net_0 : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net              : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_0_DO_net_1       <= SPI_0_DO_net_0;
 SPI_0_DO             <= SPI_0_DO_net_1;
 GPIO_0_M2F_net_1     <= GPIO_0_M2F_net_0;
 GPIO_0_M2F           <= GPIO_0_M2F_net_1;
 MMUART_1_TXD_0_net_0 <= MMUART_1_TXD_0;
 MMUART_1_TXD         <= MMUART_1_TXD_0_net_0;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CertificationSystem_sb_0
CertificationSystem_sb_0 : CertificationSystem_sb
    port map( 
        -- Inputs
        SPI_0_DI         => SPI_0_DI,
        MMUART_1_RXD     => MMUART_1_RXD,
        FAB_RESET_N      => VCC_net,
        DEVRST_N         => DEVRST_N,
        -- Outputs
        SPI_0_DO         => SPI_0_DO_net_0,
        MMUART_1_TXD     => MMUART_1_TXD_0,
        POWER_ON_RESET_N => OPEN,
        INIT_DONE        => OPEN,
        FAB_CCC_GL0      => OPEN,
        FAB_CCC_LOCK     => OPEN,
        MSS_READY        => OPEN,
        GPIO_0_M2F       => GPIO_0_M2F_net_0,
        -- Inouts
        SPI_0_CLK        => SPI_0_CLK,
        SPI_0_SS0        => SPI_0_SS0 
        );

end RTL;
