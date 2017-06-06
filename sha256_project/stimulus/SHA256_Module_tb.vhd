--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SHA256_Module_tb.vhd
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

entity SHA256_Module_tb is
end SHA256_Module_tb;

architecture behavioral of SHA256_Module_tb is

    constant clk_period : time := 50 ns; -- 20MHZ

    signal clk : std_logic := '0';
    signal RST_N : std_logic := '0';

    signal data_wen : std_logic;
    signal last_block : std_logic;
    signal data_in : std_logic_vector(31 downto 0);
    signal waddr_in : std_logic_vector(3 downto 0);
    signal result_addr : std_logic_vector(3 downto 0);
    signal result_ren : std_logic;
    signal first_block : std_logic;
    signal data_ready : std_logic;

            -- Outputs
    signal di_req_o : std_logic;
    signal data_out : std_logic_vector(31 downto 0);

    component SHA256_Module
        -- ports
        port( 
            -- Inputs
            CLK : in std_logic;
            RST_N : in std_logic;
            data_wen : in std_logic;
            last_block : in std_logic;
            data_in : in std_logic_vector(31 downto 0);
            waddr_in : in std_logic_vector(3 downto 0);
            result_addr : in std_logic_vector(3 downto 0);
            result_ren : in std_logic;
            first_block : in std_logic;
            data_ready : in std_logic;

            -- Outputs
            di_req_o : out std_logic;
            data_out : out std_logic_vector(31 downto 0)

            -- Inouts

        );
    end component;

begin

    -- Clock Driver
    clk <= not clk after (clk_period / 2.0 );

    -- Instantiate Unit Under Test:  SHA256_Module
    SHA256_Module_0 : SHA256_Module
        -- port map
        port map( 
            -- Inputs
            CLK => clk,
            RST_N => RST_N,
            data_wen => data_wen,
            last_block => last_block,
            data_in => data_in,
            waddr_in => waddr_in,
            result_addr => result_addr,
            result_ren => result_ren,
            first_block => first_block,
            data_ready => data_ready,

            -- Outputs
            di_req_o =>  di_req_o,
            data_out => data_out

        );


-- Stimulus process
    stim_proc: process
    begin
 
        -- result
        result_ren <= '0';
        result_addr <= (others => '0');

        -- input data
        waddr_in <= (others => '0');
        data_in <= (others => '0');
        data_wen <= '0';

        -- GPIO pins
        last_block <= '0';
        first_block <= '0';
        data_ready <= '0';

        RST_N <= '0';

        wait for (4*clk_period);

        RST_N <= '1';

        -- Write 16 x 32bit

        data_ready <= '0';
        data_wen <= '1';

        waddr_in <= "0000";
        data_in <= X"00000001";
        wait for clk_period;

        first_block <= '0';

        waddr_in <= "0001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "0010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "0011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "0100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "0101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "0110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "0111";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1000";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "1111";
        data_in <= X"00000000";
        wait for clk_period;

        data_wen <= '0';

        -- Set first_block to 1
        -- Set last_block to 1
        -- Set data_ready to 1
        first_block <= '1';
        last_block <= '1';
        data_ready <= '1';
        
        -- Keep reading addr 8 until we have the 'valid' bit = 1

        result_addr <= "1000";
        result_ren <= '1';

        wait;
    end process;

end behavioral;


