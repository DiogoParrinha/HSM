--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SHA256_BLOCK_tb.vhd
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

entity SHA256_BLOCK_tb is
end SHA256_BLOCK_tb;

architecture behavioral of SHA256_BLOCK_tb is

    constant clk_period : time := 50 ns; -- 20MHZ

    signal clk : std_logic := '0';
    signal RST_N : std_logic := '0';

    signal wen : std_logic;
    signal ren : std_logic;
    signal data_in : std_logic_vector(31 downto 0);
    signal waddr_in : std_logic_vector(4 downto 0);

            -- Outputs
    signal do_valid_o : std_logic;
    signal di_req_o : std_logic;
    signal error_o : std_logic;
    signal H0_o : std_logic_vector(31 downto 0);
    signal H1_o : std_logic_vector(31 downto 0);
    signal H2_o : std_logic_vector(31 downto 0);
    signal H3_o : std_logic_vector(31 downto 0);
    signal H4_o : std_logic_vector(31 downto 0);
    signal H5_o : std_logic_vector(31 downto 0);
    signal H6_o : std_logic_vector(31 downto 0);
    signal H7_o : std_logic_vector(31 downto 0);

    component SHA256_BLOCK
        -- ports
        port(
            -- Inputs
            wen : in std_logic;
            ren : in std_logic;
            clk : in std_logic;
            RST_N : in std_logic;
            data_in : in std_logic_vector(31 downto 0);
            waddr_in : in std_logic_vector(4 downto 0);

            -- Outputs
            do_valid_o : out std_logic;
            di_req_o : out std_logic;
            error_o : out std_logic;
            H0_o : out std_logic_vector(31 downto 0);
            H1_o : out std_logic_vector(31 downto 0);
            H2_o : out std_logic_vector(31 downto 0);
            H3_o : out std_logic_vector(31 downto 0);
            H4_o : out std_logic_vector(31 downto 0);
            H5_o : out std_logic_vector(31 downto 0);
            H6_o : out std_logic_vector(31 downto 0);
            H7_o : out std_logic_vector(31 downto 0)

        );
    end component;

begin
    
    -- Clock Driver
    clk <= not clk after (clk_period / 2.0 );

    -- Instantiate Unit Under Test:  SHA256_BLOCK
    SHA256_BLOCK_0 : SHA256_BLOCK
        -- port map
        port map( 
            -- Inputs
            wen => wen,
            ren => ren,
            clk => clk,
            RST_N => RST_N,
            data_in => data_in,
            waddr_in => waddr_in,

            -- Outputs
            do_valid_o => do_valid_o,
            di_req_o => di_req_o,
            error_o => error_o,
            H0_o =>  H0_o,
            H1_o =>  H1_o,
            H2_o =>  H2_o,
            H3_o =>  H3_o,
            H4_o =>  H4_o,
            H5_o =>  H5_o,
            H6_o =>  H6_o,
            H7_o =>  H7_o
        );

-- Stimulus process
    stim_proc: process
    begin

        -- hold reset state for 4 clocks ns.      
        ren <= '0';
        wen <= '0';
        RST_N <= '0';

        wait for (4*clk_period);

        RST_N <= '1';

        -- Write to each of the 16 registers
        ren <= '0';
        wen <= '1';

        waddr_in <= "00000";
        data_in <= X"00000001";
        wait for clk_period;

        waddr_in <= "00001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00111";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01000";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01111";
        data_in <= X"00000000";
        wait for clk_period;

        -- last register contains the active bit for first block
        waddr_in <= "10000";
        data_in <= X"00000001";
        wait for clk_period;

        wen <= '0';

        -- Active read for the registers bank
        ren <= '1';
        wait for clk_period;

        wait for clk_period; -- init_block state
        if di_req_o = '0' then
            wait until di_req_o = '1';
        end if;

        wait for (16*clk_period);

        ren <= '0';

        wait for (65*clk_period);

        -- Write to each of the 16 registers
        wen <= '1';

        waddr_in <= "00000";
        data_in <= X"00000002";
        wait for clk_period;

        waddr_in <= "00001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00111";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01000";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01111";
        data_in <= X"00000000";
        wait for clk_period;

        -- last register contains the active bit for last block
        waddr_in <= "10000";
        data_in <= X"00000002";
        wait for clk_period;

        wait for clk_period;
        wen <= '0';

        -- Active read for the registers bank
        ren <= '1';
        wait for clk_period;
        
        wait for clk_period; -- init_block state
        if di_req_o = '0' then
            wait until di_req_o = '1';
        end if;

        wait for (16*clk_period);

        ren <= '0';

        wait for (65*clk_period);

        if do_valid_o = '0' then
            wait until do_valid_o = '1';
        end if;

        --------- NEW TEST

        -- Write to each of the 16 registers
        ren <= '0';
        wen <= '1';

        waddr_in <= "00000";
        data_in <= X"00000002";
        wait for clk_period;

        waddr_in <= "00001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "00111";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01000";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01001";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01010";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01011";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01100";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01101";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01110";
        data_in <= X"00000000";
        wait for clk_period;

        waddr_in <= "01111";
        data_in <= X"00000000";
        wait for clk_period;

        -- last register contains the active bit for first and last block
        waddr_in <= "10000";
        data_in <= X"00000003";
        wait for clk_period;

        wen <= '0';

        -- Active read for the registers bank
        ren <= '1';
        wait for clk_period;
        
        wait for clk_period; -- init_block state
        if di_req_o = '0' then
            wait until di_req_o = '1';
        end if;

        wait for (16*clk_period);

        ren <= '0';

        wait for (65*clk_period);

        wait;
    end process;

end behavioral;

