----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Thu Jun 01 19:34:40 2017
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg_16x32_tb.vhd
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

entity reg_16x32_tb is
end reg_16x32_tb;

architecture behavioral of reg_16x32_tb is

    constant SYSCLK_PERIOD : time := 50 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    signal data_in : std_logic_vector(31 downto 0) := (others => '0');
    signal waddr_in : std_logic_vector(3 downto 0) := (others => '0');
    signal raddr_in : std_logic_vector(3 downto 0) := (others => '0');
    signal wen : std_logic := '0';
    signal ren : std_logic := '0';
    signal data_out : std_logic_vector(31 downto 0) := (others => '0');


    component reg_16x32
        -- ports
        port( 
            -- Inputs
            CLK : in std_logic;
            RST_N : in std_logic;
            data_in : in std_logic_vector(31 downto 0);
            waddr_in : in std_logic_vector(3 downto 0);
            raddr_in : in std_logic_vector(3 downto 0);
            wen : in std_logic;
            ren : in std_logic;

            -- Outputs
            data_out : out std_logic_vector(31 downto 0)

            -- Inouts

        );
    end component;

begin

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  reg_16x32
    reg_16x32_0 : reg_16x32
        -- port map
        port map( 
            -- Inputs
            CLK => SYSCLK,
            RST_N => NSYSRESET,
            data_in => data_in,
            waddr_in => waddr_in,
            raddr_in => raddr_in,
            wen => wen,
            ren => ren,

            -- Outputs
            data_out => data_out
        );

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 4 clocks ns.      
        ren <= '0';
        wen <= '0';
        NSYSRESET <= '0';

        wait for (4*SYSCLK_PERIOD);

        NSYSRESET <= '1';

        -- Read from the 16 registers to confirm all zeros

        raddr_in <= "0000";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "0001";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "0010";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "0011";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "0100";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "0101";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "0110";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "0111";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1000";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1001";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1010";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1011";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1100";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1101";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1110";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        raddr_in <= "1111";
        ren <= '1';
        wait for SYSCLK_PERIOD;


        -- Write to each of the 16 registers
        ren <= '0';
        wen <= '1';

        waddr_in <= "0000";
        data_in <= X"01010101";
        wait for SYSCLK_PERIOD;

        waddr_in <= "0001";
        data_in <= X"02020202";
        wait for SYSCLK_PERIOD;

        waddr_in <= "0010";
        data_in <= X"03030303";
        wait for SYSCLK_PERIOD;

        waddr_in <= "0011";
        data_in <= X"04040404";
        wait for SYSCLK_PERIOD;

        waddr_in <= "0100";
        data_in <= X"05050505";
        wait for SYSCLK_PERIOD;

        waddr_in <= "0101";
        data_in <= X"06060606";
        wait for SYSCLK_PERIOD;

        waddr_in <= "0110";
        data_in <= X"07070707";
        wait for SYSCLK_PERIOD;

        waddr_in <= "0111";
        data_in <= X"08080808";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1000";
        data_in <= X"09090909";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1001";
        data_in <= X"0A0A0A0A";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1010";
        data_in <= X"0B0B0B0B";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1011";
        data_in <= X"0C0C0C0C";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1100";
        data_in <= X"0D0D0D0D";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1101";
        data_in <= X"0E0E0E0E";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1110";
        data_in <= X"0F0F0F0F";
        wait for SYSCLK_PERIOD;

        waddr_in <= "1111";
        data_in <= X"10101010";
        wait for SYSCLK_PERIOD;

        -- Read back to confirm written values
        wen <= '0';
        ren <= '1';

        raddr_in <= "0000";
        wait for SYSCLK_PERIOD;

        raddr_in <= "0001";
        wait for SYSCLK_PERIOD;

        raddr_in <= "0010";
        wait for SYSCLK_PERIOD;

        raddr_in <= "0011";
        wait for SYSCLK_PERIOD;

        raddr_in <= "0100";
        wait for SYSCLK_PERIOD;

        raddr_in <= "0101";
        wait for SYSCLK_PERIOD;

        raddr_in <= "0110";
        wait for SYSCLK_PERIOD;

        raddr_in <= "0111";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1000";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1001";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1010";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1011";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1100";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1101";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1110";
        wait for SYSCLK_PERIOD;

        raddr_in <= "1111";
        wait for SYSCLK_PERIOD;

        wait;
    end process;

end behavioral;

