--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg_9_1x32.vhd
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

entity reg_9_1x32 is
end reg_9_1x32;

architecture behavioral of reg_9_1x32 is

    constant SYSCLK_PERIOD : time := 50 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    signal wen : std_logic;
    signal ren : std_logic;
    signal data_in_2 : std_logic_vector(31 downto 0);
    signal data_in_8 : std_logic_vector(31 downto 0);
    signal data_in_1 : std_logic_vector(31 downto 0);
    signal data_in_5 : std_logic_vector(31 downto 0);
    signal data_in_0 : std_logic_vector(31 downto 0);
    signal data_in_3 : std_logic_vector(31 downto 0);
    signal data_in_4 : std_logic_vector(31 downto 0);
    signal data_in_6 : std_logic_vector(31 downto 0);
    signal data_in_7 : std_logic_vector(31 downto 0);
    signal sel : std_logic_vector(3 downto 0);
    signal data_out : std_logic_vector(31 downto 0);

    component reg9_1x32
        -- ports
        port( 
            -- Inputs
            CLK : in std_logic;
            RST_N : in std_logic;
            wen : in std_logic;
            ren : in std_logic;
            data_in_2 : in std_logic_vector(31 downto 0);
            data_in_8 : in std_logic_vector(31 downto 0);
            data_in_1 : in std_logic_vector(31 downto 0);
            data_in_5 : in std_logic_vector(31 downto 0);
            data_in_0 : in std_logic_vector(31 downto 0);
            data_in_3 : in std_logic_vector(31 downto 0);
            data_in_4 : in std_logic_vector(31 downto 0);
            data_in_6 : in std_logic_vector(31 downto 0);
            data_in_7 : in std_logic_vector(31 downto 0);
            sel : in std_logic_vector(3 downto 0);

            -- Outputs
            data_out : out std_logic_vector(31 downto 0)

            -- Inouts

        );
    end component;

begin

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  reg9_1x32
    reg9_1x32_0 : reg9_1x32
        -- port map
        port map( 
            -- Inputs
            CLK => SYSCLK,
            RST_N => NSYSRESET,
            wen => wen,
            ren => ren,
            data_in_2 => data_in_2,
            data_in_8 => data_in_8,
            data_in_1 => data_in_1,
            data_in_5 => data_in_5,
            data_in_0 => data_in_0,
            data_in_3 => data_in_3,
            data_in_4 => data_in_4,
            data_in_6 => data_in_6,
            data_in_7 => data_in_7,
            sel => sel,

            -- Outputs
            data_out => data_out

            -- Inouts

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

        -- Read from the 9 registers to confirm all zeros

        sel <= "0000";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0001";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0010";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0011";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0100";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0101";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0110";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0111";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "1000";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        -- Write to each of the 16 registers
        ren <= '0';
        wen <= '1';

        data_in_0 <= X"01010101";
        data_in_1 <= X"02020202";
        data_in_2 <= X"03030303";
        data_in_3 <= X"04040404";
        data_in_4 <= X"05050505";
        data_in_5 <= X"06060606";
        data_in_6 <= X"07070707";
        data_in_7 <= X"08080808";
        data_in_8 <= X"09090909";
        wait for SYSCLK_PERIOD;

        -- Read back to confirm written values
        wen <= '0';
        ren <= '1';

        sel <= "0000";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0001";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0010";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0011";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0100";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0101";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0110";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "0111";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        sel <= "1000";
        ren <= '1';
        wait for SYSCLK_PERIOD;

        wait;
    end process;

end behavioral;

