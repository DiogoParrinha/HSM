----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Thu Jun 01 20:49:10 2017
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: zero_concat_tb.vhd
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

entity zero_concat_tb is
end zero_concat_tb;

architecture behavioral of zero_concat_tb is

    constant SYSCLK_PERIOD : time := 100 ns; -- 10MHZ

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    signal s1 : std_logic := '0';
    signal s2 : std_logic := '0';
    signal s3 : std_logic := '0';
    signal s_32bit : std_logic_vector(31 downto 0);

    component zero_concat
        -- ports
        port( 
            -- Inputs
            s1 : in std_logic;
            s2 : in std_logic;
            s3 : in std_logic;

            -- Outputs
            s_32bit : out std_logic_vector(31 downto 0)

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

    -- Instantiate Unit Under Test:  zero_concat
    zero_concat_0 : zero_concat
        -- port map
        port map( 
            -- Inputs
            s1 => s1,
            s2 => s2,
            s3 => s3,

            -- Outputs
            s_32bit => s_32bit

        );

     -- Stimulus process
        stim_proc: process
        begin

        wait for ( 10 *SYSCLK_PERIOD);

        s1 <= '1';
        s2 <= '0';
        s3 <= '1';

        wait for ( SYSCLK_PERIOD);
        wait;
    end process;

end behavioral;

