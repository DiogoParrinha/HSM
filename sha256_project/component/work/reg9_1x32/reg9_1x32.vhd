----------------------------------------------------------------------
-- Created by SmartDesign Tue Jun 06 23:16:19 2017
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
-- reg9_1x32 entity declaration
----------------------------------------------------------------------
entity reg9_1x32 is
    -- Port list
    port(
        -- Inputs
        CLK                       : in  std_logic;
        RST_N                     : in  std_logic;
        data_in_0                 : in  std_logic_vector(31 downto 0);
        data_in_1                 : in  std_logic_vector(31 downto 0);
        data_in_2                 : in  std_logic_vector(31 downto 0);
        data_in_3                 : in  std_logic_vector(31 downto 0);
        data_in_4                 : in  std_logic_vector(31 downto 0);
        data_in_5                 : in  std_logic_vector(31 downto 0);
        data_in_6                 : in  std_logic_vector(31 downto 0);
        data_in_7                 : in  std_logic_vector(31 downto 0);
        data_in_8                 : in  std_logic_vector(31 downto 0);
        ren                       : in  std_logic;
        sel                       : in  std_logic_vector(3 downto 0);
        wen                       : in  std_logic;
        -- Outputs
        data_available_lastbank_0 : out std_logic;
        data_available_lastbank_8 : out std_logic;
        data_out                  : out std_logic_vector(31 downto 0)
        );
end reg9_1x32;
----------------------------------------------------------------------
-- reg9_1x32 architecture body
----------------------------------------------------------------------
architecture RTL of reg9_1x32 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- mux_9_1
component mux_9_1
    -- Port list
    port(
        -- Inputs
        d0       : in  std_logic_vector(31 downto 0);
        d1       : in  std_logic_vector(31 downto 0);
        d2       : in  std_logic_vector(31 downto 0);
        d3       : in  std_logic_vector(31 downto 0);
        d4       : in  std_logic_vector(31 downto 0);
        d5       : in  std_logic_vector(31 downto 0);
        d6       : in  std_logic_vector(31 downto 0);
        d7       : in  std_logic_vector(31 downto 0);
        d8       : in  std_logic_vector(31 downto 0);
        sel      : in  std_logic_vector(3 downto 0);
        -- Outputs
        data_out : out std_logic_vector(31 downto 0)
        );
end component;
-- reg_1x32
component reg_1x32
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        RST_N          : in  std_logic;
        data_in        : in  std_logic_vector(31 downto 0);
        ren            : in  std_logic;
        wen            : in  std_logic;
        -- Outputs
        data_available : out std_logic;
        data_out       : out std_logic_vector(31 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal data_available_lastbank_0_net_0 : std_logic;
signal data_available_lastbank_8_net_0 : std_logic;
signal data_out_net_0                  : std_logic_vector(31 downto 0);
signal data_out_0                      : std_logic_vector(31 downto 0);
signal data_out_1                      : std_logic_vector(31 downto 0);
signal data_out_2                      : std_logic_vector(31 downto 0);
signal data_out_3                      : std_logic_vector(31 downto 0);
signal data_out_4                      : std_logic_vector(31 downto 0);
signal data_out_5                      : std_logic_vector(31 downto 0);
signal data_out_6                      : std_logic_vector(31 downto 0);
signal data_out_7                      : std_logic_vector(31 downto 0);
signal data_out_8                      : std_logic_vector(31 downto 0);
signal data_out_net_1                  : std_logic_vector(31 downto 0);
signal data_available_lastbank_8_net_1 : std_logic;
signal data_available_lastbank_0_net_1 : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 data_out_net_1                  <= data_out_net_0;
 data_out(31 downto 0)           <= data_out_net_1;
 data_available_lastbank_8_net_1 <= data_available_lastbank_8_net_0;
 data_available_lastbank_8       <= data_available_lastbank_8_net_1;
 data_available_lastbank_0_net_1 <= data_available_lastbank_0_net_0;
 data_available_lastbank_0       <= data_available_lastbank_0_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- mux_9_1_0
mux_9_1_0 : mux_9_1
    port map( 
        -- Inputs
        sel      => sel,
        d0       => data_out_0,
        d1       => data_out_1,
        d2       => data_out_2,
        d3       => data_out_3,
        d4       => data_out_4,
        d5       => data_out_5,
        d6       => data_out_6,
        d7       => data_out_7,
        d8       => data_out_8,
        -- Outputs
        data_out => data_out_net_0 
        );
-- reg_1x32_0
reg_1x32_0 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_0,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_0,
        data_available => data_available_lastbank_0_net_0 
        );
-- reg_1x32_1
reg_1x32_1 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_1,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_1,
        data_available => OPEN 
        );
-- reg_1x32_2
reg_1x32_2 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_2,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_2,
        data_available => OPEN 
        );
-- reg_1x32_3
reg_1x32_3 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_3,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_3,
        data_available => OPEN 
        );
-- reg_1x32_4
reg_1x32_4 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_4,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_4,
        data_available => OPEN 
        );
-- reg_1x32_5
reg_1x32_5 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_5,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_5,
        data_available => OPEN 
        );
-- reg_1x32_6
reg_1x32_6 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_6,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_6,
        data_available => OPEN 
        );
-- reg_1x32_7
reg_1x32_7 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_7,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_7,
        data_available => OPEN 
        );
-- reg_1x32_8
reg_1x32_8 : reg_1x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in_8,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out_8,
        data_available => data_available_lastbank_8_net_0 
        );

end RTL;
