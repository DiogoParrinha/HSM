--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: bfm_testbench.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S060> <Package::484 FBGA>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;

entity bfm_testbench is
end bfm_testbench;

architecture behavioral of bfm_testbench is

    constant SYSCLK_PERIOD : time := 10 ns; -- 100MHZ

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component sha256_system
        -- ports
        port( 
            -- Inputs
            DEVRST_N : in std_logic;

            -- Outputs
            GPIO_0_M2F : out std_logic

            -- Inouts

        );
    end component;

begin

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NSYSRESET <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NSYSRESET <= '1';
            wait;
        end if;
    end process;

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  sha256_system
    sha256_system_0 : sha256_system
        -- port map
        port map( 
            -- Inputs
            DEVRST_N => NSYSRESET,

            -- Outputs
            GPIO_0_M2F =>  open

            -- Inouts

        );

end behavioral;

