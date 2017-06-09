----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Mon Jun 05 13:12:28 2017
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: sha256_controller_tb.vhd
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

entity sha256_controller_tb is
end sha256_controller_tb;

architecture behavioral of sha256_controller_tb is

    constant clk_PERIOD : time := 100 ns; -- 10MHZ

    signal clk : std_logic := '0';
    signal RST_N : std_logic := '0';

    -- Inputs
    signal read_data : std_logic_vector(31 downto 0);
    signal data_ready : std_logic;
    signal di_req_i : std_logic;

    -- Outputs
    signal read_addr : std_logic_vector(3 downto 0);
    signal ce_o : std_logic;
    signal di_o : std_logic_vector(31 downto 0);
    signal bytes_o : std_logic_vector(1 downto 0);
    signal start_o : std_logic;
    signal end_o : std_logic;
    signal di_wr_o : std_logic;


    component sha256_controller
        -- ports
        port( 
            -- Inputs
            read_data : in std_logic_vector(31 downto 0);
            data_ready : in std_logic;
            clk : in std_logic;
            RST_N : in std_logic;
            di_req_i : in std_logic;

            -- Outputs
            read_addr : out std_logic_vector(3 downto 0);
            ce_o : out std_logic;
            di_o : out std_logic_vector(31 downto 0);
            bytes_o : out std_logic_vector(1 downto 0);
            start_o : out std_logic;
            end_o : out std_logic;
            di_wr_o : out std_logic

            -- Inouts

        );
    end component;

begin

    -- Clock Driver
    clk <= not clk after (clk_PERIOD / 2.0 );

    -- Instantiate Unit Under Test:  sha256_controller
    sha256_controller_0 : sha256_controller
        -- port map
        port map( 
            -- Inputs
            read_data => read_data,
            data_ready => data_ready,
            clk => clk,
            RST_N => RST_N,
            di_req_i => di_req_i,

            -- Outputs
            read_addr => read_addr,
            ce_o =>  ce_o,
            di_o => di_o,
            bytes_o => bytes_o,
            start_o =>  start_o,
            end_o =>  end_o,
            di_wr_o =>  di_wr_o

        );

-- Stimulus process
    stim_proc: process
    begin
        -- reset for 4 clock periods
        RST_N <= '0';
        data_ready <= '0';
        read_data <= X"00000000";
        di_req_i <= '0';

        wait for (4*clk_PERIOD); -- wait_data state

        RST_N <= '1';

        -- change to init_block
        data_ready <= '1';
        
        -- we already have a word received for pos 0 (this won't be used for now but it's nice to test what happens)
        read_data <= X"01010101";

        wait for clk_PERIOD; -- init_block state

        wait for clk_PERIOD; -- process_word 0
        read_data <= X"01010101";
        di_req_i <= '1';

        wait for clk_PERIOD; -- process_word 1
        read_data <= X"02020202";
        di_req_i <= '1';

        wait for clk_PERIOD; -- process_word 2
        read_data <= X"03030303";
        di_req_i <= '1';

        wait for clk_PERIOD; -- process_word 3
        read_data <= X"03030303";
        di_req_i <= '1';

        wait for clk_PERIOD; -- process_word 4
        read_data <= X"04040404";
        di_req_i <= '1';

        wait for clk_PERIOD; -- process_word 5
        read_data <= X"05050505";
        di_req_i <= '0';

        wait for clk_PERIOD; -- wait_process
        read_data <= X"06060606";
        di_req_i <= '0';

        wait for clk_PERIOD; -- wait_process
        read_data <= X"06060606";
        di_req_i <= '1';

        wait for clk_PERIOD; -- process_word 6
        read_data <= X"06060606";

        wait for clk_PERIOD; -- process_word 7
        read_data <= X"07070707";

        wait for clk_PERIOD; -- process_word 8
        read_data <= X"08080808";

        wait for clk_PERIOD; -- process_word 9
        read_data <= X"09090909";

        wait for clk_PERIOD; -- process_word 10
        read_data <= X"0A0A0A0A";

        wait for clk_PERIOD; -- process_word 11
        read_data <= X"0B0B0B0B";

        wait for clk_PERIOD; -- process_word 12
        read_data <= X"0C0C0C0C";

        wait for clk_PERIOD; -- process_word 13
        read_data <= X"0D0D0D0D";

        wait for clk_PERIOD; -- process_word 14
        read_data <= X"0E0E0E0E";

        wait for clk_PERIOD; -- process_word 15
        read_data <= X"0F0F0F0F";

        wait for clk_PERIOD; -- process_word 15
        read_data <= X"10101010";

        wait for clk_PERIOD; -- end_block
        di_req_i <= '0';

        wait;
    end process;

end behavioral;

