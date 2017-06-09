--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SHA256_Module_tb_swlike.vhd
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

entity SHA256_Module_tb_swlike is
end SHA256_Module_tb_swlike;

architecture behavioral of SHA256_Module_tb_swlike is

    constant clk_period : time := 50 ns; -- 20MHZ

    signal clk : std_logic := '0';
    signal RST_N : std_logic := '0';

    signal data_wen : std_logic;
    signal data_in : std_logic_vector(31 downto 0);
    signal waddr_in : std_logic_vector(4 downto 0);
    signal result_addr : std_logic_vector(3 downto 0);
    signal result_ren : std_logic;
    signal data_ready : std_logic;
    signal waiting_data : std_logic;

    -- Outputs
    signal di_req_o : std_logic;
    signal data_out : std_logic_vector(31 downto 0);
    signal data_available : std_logic;
    signal data_out_ready : std_logic;
    signal error_o : std_logic;
    signal do_valid_o : std_logic;
    component SHA256_Module
        -- ports
        port( 
            -- Inputs
            CLK : in std_logic;
            RST_N : in std_logic;
            data_wen : in std_logic;
            data_in : in std_logic_vector(31 downto 0);
            waddr_in : in std_logic_vector(4 downto 0);
            result_addr : in std_logic_vector(3 downto 0);
            result_ren : in std_logic;
            data_ready : in std_logic;

            -- Outputs
            di_req_o : out std_logic;
            data_out : out std_logic_vector(31 downto 0);
            data_available : out std_logic;
            data_out_ready : out std_logic;
            error_o : out std_logic;
            do_valid_o : out std_logic;
            waiting_data : out std_logic

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
            data_in => data_in,
            waddr_in => waddr_in,
            result_addr => result_addr,
            result_ren => result_ren,
            data_ready => data_ready,

            -- Outputs
            di_req_o =>  di_req_o,
            data_out => data_out,
            do_valid_o => do_valid_o,
            error_o => error_o,
            data_available => data_available,
            data_out_ready => data_out_ready,
            waiting_data => waiting_data

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
        data_ready <= '0';

        -- reset
        RST_N <= '0';

        wait for (4*clk_period);

        RST_N <= '1';

        wait for clk_period;

        -- Set data_ready to 1 (GPIO PIN)
        data_ready <= '1';
        
        -- wait some cycles
        wait for (10*clk_period);

        -- Keep reading addr 8 until we have the 'valid' bit = 1

        result_addr <= "1000";
        result_ren <= '1';

        wait for (100*clk_period);

        -- Read the first 8 registers

        result_ren <= '1';
        result_addr <= "0000";
        wait for clk_period;
        result_addr <= "0001";
        wait for clk_period;
        result_addr <= "0010";
        wait for clk_period;
        result_addr <= "0011";
        wait for clk_period;
        result_addr <= "0100";
        wait for clk_period;
        result_addr <= "0101";
        wait for clk_period;
        result_addr <= "0110";
        wait for clk_period;
        result_addr <= "0111";
        wait for clk_period;

        wait for (10*clk_period);

        ---------------------------------------------------------
        --------------------------------------------------------- TEST WITH 1 BLOCK
        ---------------------------------------------------------
--
        ---- result
        --result_ren <= '0';
        --result_addr <= (others => '0');
--
        ---- input data
        --waddr_in <= (others => '0');
        --data_in <= (others => '0');
        --data_wen <= '0';
        --data_ready <= '0';
--
        --RST_N <= '0';
--
        --wait for clk_period;
--
        --RST_N <= '1';
--
        --wait for clk_period;
--
        ------------- FIRST BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set last_block to 1
        ---- Set last word to F
        --waddr_in <= "10000";
        --data_in <= X"F0000003";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        ---- Keep reading addr 8 until we have the 'valid' bit = 1
--
        --result_addr <= "1000";
        --result_ren <= '1';
--
        --if do_valid_o = '0' then
            --wait until do_valid_o = '1';
        --end if;
--
        --data_ready <= '0';
--
        --wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)
--
        ---- Read the first 8 registers
--
        --result_ren <= '1';
        --result_addr <= "0000";
        --wait for clk_period;
        --result_addr <= "0001";
        --wait for clk_period;
        --result_addr <= "0010";
        --wait for clk_period;
        --result_addr <= "0011";
        --wait for clk_period;
        --result_addr <= "0100";
        --wait for clk_period;
        --result_addr <= "0101";
        --wait for clk_period;
        --result_addr <= "0110";
        --wait for clk_period;
        --result_addr <= "0111";
        --wait for clk_period;
--
        --wait for (100*clk_period);
--
        ---------------------------------------------------------
        --------------------------------------------------------- TEST WITH 1 INCOMPLETE BLOCK
        ---------------------------------------------------------
--
        ---- result
        --result_ren <= '0';
        --result_addr <= (others => '0');
--
        ---- input data
        --waddr_in <= (others => '0');
        --data_in <= (others => '0');
        --data_wen <= '0';
        --data_ready <= '0';
--
        --RST_N <= '0';
--
        --wait for clk_period;
--
        --RST_N <= '1';
--
        --wait for clk_period;
--
        ------------- FIRST BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000003";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000004";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000005";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000006";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000007";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000008";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set last_block to 1
        ---- Set position of last word (most significant 4bits: 0 to F)
        --waddr_in <= "10000";
        --data_in <= X"70000003";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        ---- Keep reading addr 8 until we have the 'valid' bit = 1
--
        --result_addr <= "1000";
        --result_ren <= '1';
--
        --if do_valid_o = '0' then
            --wait until do_valid_o = '1';
        --end if;
--
        --data_ready <= '0';
--
        --wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)
--
        ---- Read the first 8 registers
--
        --result_ren <= '1';
        --result_addr <= "0000";
        --wait for clk_period;
        --result_addr <= "0001";
        --wait for clk_period;
        --result_addr <= "0010";
        --wait for clk_period;
        --result_addr <= "0011";
        --wait for clk_period;
        --result_addr <= "0100";
        --wait for clk_period;
        --result_addr <= "0101";
        --wait for clk_period;
        --result_addr <= "0110";
        --wait for clk_period;
        --result_addr <= "0111";
        --wait for clk_period;
--
        --wait for (100*clk_period);
--
        ---------------------------------------------------------
        --------------------------------------------------------- TEST AGAIN WITH 2 BLOCKS
        ---------------------------------------------------------
--
        ------------- FIRST BLOCK
--
        ---- result
        --result_ren <= '0';
        --result_addr <= (others => '0');
--
        ---- input data
        --waddr_in <= (others => '0');
        --data_in <= (others => '0');
        --data_wen <= '0';
        --data_ready <= '0';
--
        --RST_N <= '0';
--
        --wait for clk_period;
--
        --RST_N <= '1';
--
        --wait for clk_period;
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set first_block to 1
        ---- Set last word to F
        --waddr_in <= "10000";
        --data_in <= X"F0000001";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        --wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down
--
        --if waiting_data = '0' then
            --wait until waiting_data = '1';
        --end if;
--
        --data_ready <= '0';
--
        ------------- SECOND BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set last_block to 1
        ---- Set last word to F
        --waddr_in <= "10000";
        --data_in <= X"F0000002";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        ---- Keep reading addr 8 until we have the 'valid' bit = 1
--
        --result_addr <= "1000";
        --result_ren <= '1';
--
        --if do_valid_o = '0' then
            --wait until do_valid_o = '1';
        --end if;
--
        --data_ready <= '0';
--
        --wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)
--
        ---- Read the first 8 registers
--
        --result_ren <= '1';
        --result_addr <= "0000";
        --wait for clk_period;
        --result_addr <= "0001";
        --wait for clk_period;
        --result_addr <= "0010";
        --wait for clk_period;
        --result_addr <= "0011";
        --wait for clk_period;
        --result_addr <= "0100";
        --wait for clk_period;
        --result_addr <= "0101";
        --wait for clk_period;
        --result_addr <= "0110";
        --wait for clk_period;
        --result_addr <= "0111";
        --wait for clk_period;
--
        --wait for (100*clk_period);
--
        ---------------------------------------------------------
        --------------------------------------------------------- TEST AGAIN WITH 2 INCOMPLETE BLOCKS
        ---------------------------------------------------------
--
        ------------- FIRST BLOCK
--
        ---- result
        --result_ren <= '0';
        --result_addr <= (others => '0');
--
        ---- input data
        --waddr_in <= (others => '0');
        --data_in <= (others => '0');
        --data_wen <= '0';
        --data_ready <= '0';
--
        --RST_N <= '0';
--
        --wait for clk_period;
--
        --RST_N <= '1';
--
        --wait for clk_period;
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000003";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000004";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000005";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000006";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000007";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000008";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000009";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"0000000A";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"0000000B";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"0000000C";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"0000000D";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"0000000E";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"0000000F";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        ---- Set first_block to 1
        ---- Set last word to F
        --waddr_in <= "10000";
        --data_in <= X"F0000001";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        --wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down
--
        --if waiting_data = '0' then
            --wait until waiting_data = '1';
        --end if;
--
        --data_ready <= '0';
--
        ------------- SECOND BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000003";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000004";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set last_block to 1
        ---- Set last valid word to 3 (4th position)
        --waddr_in <= "10000";
        --data_in <= X"30000002";
        --wait for clk_period;
--
        --waddr_in <= "10001";
        --data_in <= X"00000000"; -- all included words are valid
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        ---- Keep reading addr 8 until we have the 'valid' bit = 1
--
        --result_addr <= "1000";
        --result_ren <= '1';
--
        --if do_valid_o = '0' then
            --wait until do_valid_o = '1';
        --end if;
--
        --data_ready <= '0';
--
        --wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)
--
        ---- Read the first 8 registers
--
        --result_ren <= '1';
        --result_addr <= "0000";
        --wait for clk_period;
        --result_addr <= "0001";
        --wait for clk_period;
        --result_addr <= "0010";
        --wait for clk_period;
        --result_addr <= "0011";
        --wait for clk_period;
        --result_addr <= "0100";
        --wait for clk_period;
        --result_addr <= "0101";
        --wait for clk_period;
        --result_addr <= "0110";
        --wait for clk_period;
        --result_addr <= "0111";
        --wait for clk_period;
--
        --wait for (100*clk_period);


        -----------------------------------------------------------
        ----------------------------------------------------------- TEST AGAIN WITH 3 BLOCKS
        -----------------------------------------------------------
--
        ------------- FIRST BLOCK
--
        ---- result
        --result_ren <= '0';
        --result_addr <= (others => '0');
--
        ---- input data
        --waddr_in <= (others => '0');
        --data_in <= (others => '0');
        --data_wen <= '0';
        --data_ready <= '0';
--
        --RST_N <= '0';
--
        --wait for clk_period;
--
        --RST_N <= '1';
--
        --wait for clk_period;
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set first_block to 1
        ---- Set last word to position F
        --waddr_in <= "10000";
        --data_in <= X"F0000001";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        --wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down
--
        --if waiting_data = '0' then
            --wait until waiting_data = '1';
        --end if;
--
        --data_ready <= '0';
--
        ------------- SECOND BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set last word to position F
        --waddr_in <= "10000";
        --data_in <= X"F0000000"; -- second block, no first or last
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
        --
        --wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down
--
        --if waiting_data = '0' then
            --wait until waiting_data = '1';
        --end if;
--
        --data_ready <= '0';
--
        ------------- THIRD BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000003";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set last_block to 1
        ---- Set last word to position F
        --waddr_in <= "10000";
        --data_in <= X"F0000002";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        ---- Keep reading addr 8 until we have the 'valid' bit = 1
--
        --result_addr <= "1000";
        --result_ren <= '1';
--
        --if do_valid_o = '0' then
            --wait until do_valid_o = '1';
        --end if;
--
        --data_ready <= '0';
--
        --wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)
--
        ---- Read the first 8 registers
--
        --result_ren <= '1';
        --result_addr <= "0000";
        --wait for clk_period;
        --result_addr <= "0001";
        --wait for clk_period;
        --result_addr <= "0010";
        --wait for clk_period;
        --result_addr <= "0011";
        --wait for clk_period;
        --result_addr <= "0100";
        --wait for clk_period;
        --result_addr <= "0101";
        --wait for clk_period;
        --result_addr <= "0110";
        --wait for clk_period;
        --result_addr <= "0111";
        --wait for clk_period;
--
       -----------------------------------------------------------
        ----------------------------------------------------------- TEST AGAIN WITH 3 BLOCKS
        -----------------------------------------------------------
--
        ------------- FIRST BLOCK
--
        ---- result
        --result_ren <= '0';
        --result_addr <= (others => '0');
--
        ---- input data
        --waddr_in <= (others => '0');
        --data_in <= (others => '0');
        --data_wen <= '0';
        --data_ready <= '0';
--
        --RST_N <= '0';
--
        --wait for clk_period;
--
        --RST_N <= '1';
--
        --wait for clk_period;
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000003";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000004";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000005";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000006";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000007";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000008";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000009";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"0000000A";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"0000000B";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"0000000C";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"0000000D";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"0000000E";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"0000000F";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        ---- Set first_block to 1
        ---- Set last word to position F
        --waddr_in <= "10000";
        --data_in <= X"F0000001";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        --wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down
--
        --if waiting_data = '0' then
            --wait until waiting_data = '1';
        --end if;
--
        --data_ready <= '0';
--
        ------------- SECOND BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000003";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000004";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000005";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000006";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000007";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000008";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000009";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"0000000A";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"0000000B";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"0000000C";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"0000000D";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"0000000E";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"0000000F";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        ---- Set last word to position F
        --waddr_in <= "10000";
        --data_in <= X"F0000000"; -- second block, no first or last
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
        --
        --wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down
--
        --if waiting_data = '0' then
            --wait until waiting_data = '1';
        --end if;
--
        --data_ready <= '0';
--
        ------------- THIRD BLOCK
--
        ---- Write 16 x 32bit
--
        --data_wen <= '1'; -- AHB write enable ON
--
        --waddr_in <= "00000";
        --data_in <= X"00000001";
        --wait for clk_period;
--
        --waddr_in <= "00001";
        --data_in <= X"00000002";
        --wait for clk_period;
--
        --waddr_in <= "00010";
        --data_in <= X"00000003";
        --wait for clk_period;
--
        --waddr_in <= "00011";
        --data_in <= X"00000004";
        --wait for clk_period;
--
        --waddr_in <= "00100";
        --data_in <= X"00000005";
        --wait for clk_period;
--
        --waddr_in <= "00101";
        --data_in <= X"00000006";
        --wait for clk_period;
--
        --waddr_in <= "00110";
        --data_in <= X"00000007";
        --wait for clk_period;
--
        --waddr_in <= "00111";
        --data_in <= X"00000008";
        --wait for clk_period;
--
        --waddr_in <= "01000";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01001";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01010";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01011";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01100";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01101";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01110";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        --waddr_in <= "01111";
        --data_in <= X"00000000";
        --wait for clk_period;
--
        ---- Set last_block to 1
        ---- Set last word to position 7 (8th word)
        --waddr_in <= "10000";
        --data_in <= X"70000002";
        --wait for clk_period;
--
        --data_wen <= '0'; -- AHB write enable OFF
--
        ---- wait until data_available = '1'
        --if data_available = '0' then
            --wait until data_available = '1';
        --end if;
--
        ---- Set data_ready to 1 (GPIO PIN)
        --data_ready <= '1';
--
        ---- Keep reading addr 8 until we have the 'valid' bit = 1
--
        --result_addr <= "1000";
        --result_ren <= '1';
--
        --if do_valid_o = '0' then
            --wait until do_valid_o = '1';
        --end if;
--
        --data_ready <= '0';
--
        --wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)
--
        ---- Read the first 8 registers
--
        --result_ren <= '1';
        --result_addr <= "0000";
        --wait for clk_period;
        --result_addr <= "0001";
        --wait for clk_period;
        --result_addr <= "0010";
        --wait for clk_period;
        --result_addr <= "0011";
        --wait for clk_period;
        --result_addr <= "0100";
        --wait for clk_period;
        --result_addr <= "0101";
        --wait for clk_period;
        --result_addr <= "0110";
        --wait for clk_period;
        --result_addr <= "0111";
        --wait for clk_period;

        -------------------------------------------------------
        ------------------------------------------------------- TEST WITH 1 INCOMPLETE BLOCK WITH INCOMPLETE WORD
        -------------------------------------------------------

        -- result
        result_ren <= '0';
        result_addr <= (others => '0');

        -- input data
        waddr_in <= (others => '0');
        data_in <= (others => '0');
        data_wen <= '0';
        data_ready <= '0';

        RST_N <= '0';

        wait for clk_period;

        RST_N <= '1';

        wait for clk_period;

        ----------- FIRST BLOCK

        -- Write 16 x 32bit

        data_wen <= '1'; -- AHB write enable ON

        waddr_in <= "00000";
        data_in <= X"00000001";
        wait for clk_period;

        waddr_in <= "00001";
        data_in <= X"00000002";
        wait for clk_period;

        waddr_in <= "00010";
        data_in <= X"00000003";
        wait for clk_period;

        waddr_in <= "00011";
        data_in <= X"00000004";
        wait for clk_period;

        waddr_in <= "00100";
        data_in <= X"00000005";
        wait for clk_period;

        waddr_in <= "00101";
        data_in <= X"00000006";
        wait for clk_period;

        waddr_in <= "00110";
        data_in <= X"00000007";
        wait for clk_period;

        waddr_in <= "00111";
        data_in <= X"00080000";
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

        -- Set last_block to 1
        -- Set position of last word (most significant 4bits: 0 to F)
        -- last word only has 2 valid bytes (10'b in bytes 15-14)
        waddr_in <= "10000";
        data_in <= X"70200003";
        wait for clk_period;

        data_wen <= '0'; -- AHB write enable OFF

        -- wait until data_available = '1'
        if data_available = '0' then
            wait until data_available = '1';
        end if;

        -- Set data_ready to 1 (GPIO PIN)
        data_ready <= '1';

        -- Keep reading addr 8 until we have the 'valid' bit = 1

        result_addr <= "1000";
        result_ren <= '1';

        if do_valid_o = '0' then
            wait until do_valid_o = '1';
        end if;

        data_ready <= '0';

        wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)

        -- Read the first 8 registers

        result_ren <= '1';
        result_addr <= "0000";
        wait for clk_period;
        result_addr <= "0001";
        wait for clk_period;
        result_addr <= "0010";
        wait for clk_period;
        result_addr <= "0011";
        wait for clk_period;
        result_addr <= "0100";
        wait for clk_period;
        result_addr <= "0101";
        wait for clk_period;
        result_addr <= "0110";
        wait for clk_period;
        result_addr <= "0111";
        wait for clk_period;

        wait for (100*clk_period);

        -------------------------------------------------------
        ------------------------------------------------------- TEST AGAIN WITH 2 INCOMPLETE BLOCKS WITH INCOMPLETE WORD
        -------------------------------------------------------

        ----------- FIRST BLOCK

        -- result
        result_ren <= '0';
        result_addr <= (others => '0');

        -- input data
        waddr_in <= (others => '0');
        data_in <= (others => '0');
        data_wen <= '0';
        data_ready <= '0';

        RST_N <= '0';

        wait for clk_period;

        RST_N <= '1';

        wait for clk_period;

        -- Write 16 x 32bit

        data_wen <= '1'; -- AHB write enable ON

        waddr_in <= "00000";
        data_in <= X"00000001";
        wait for clk_period;

        waddr_in <= "00001";
        data_in <= X"00000002";
        wait for clk_period;

        waddr_in <= "00010";
        data_in <= X"00000003";
        wait for clk_period;

        waddr_in <= "00011";
        data_in <= X"00000004";
        wait for clk_period;

        waddr_in <= "00100";
        data_in <= X"00000005";
        wait for clk_period;

        waddr_in <= "00101";
        data_in <= X"00000006";
        wait for clk_period;

        waddr_in <= "00110";
        data_in <= X"00000007";
        wait for clk_period;

        waddr_in <= "00111";
        data_in <= X"00000008";
        wait for clk_period;

        waddr_in <= "01000";
        data_in <= X"00000009";
        wait for clk_period;

        waddr_in <= "01001";
        data_in <= X"0000000A";
        wait for clk_period;

        waddr_in <= "01010";
        data_in <= X"0000000B";
        wait for clk_period;

        waddr_in <= "01011";
        data_in <= X"0000000C";
        wait for clk_period;

        waddr_in <= "01100";
        data_in <= X"0000000D";
        wait for clk_period;

        waddr_in <= "01101";
        data_in <= X"0000000E";
        wait for clk_period;

        waddr_in <= "01110";
        data_in <= X"0000000F";
        wait for clk_period;

        waddr_in <= "01111";
        data_in <= X"00000001";
        wait for clk_period;

        -- Set first_block to 1
        -- Set last word to F
        waddr_in <= "10000";
        data_in <= X"F0000001";
        wait for clk_period;

        data_wen <= '0'; -- AHB write enable OFF

        -- wait until data_available = '1'
        if data_available = '0' then
            wait until data_available = '1';
        end if;

        -- Set data_ready to 1 (GPIO PIN)
        data_ready <= '1';

        wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down

        if waiting_data = '0' then
            wait until waiting_data = '1';
        end if;

        data_ready <= '0';

        ----------- SECOND BLOCK

        -- Write 16 x 32bit

        data_wen <= '1'; -- AHB write enable ON

        waddr_in <= "00000";
        data_in <= X"00000002";
        wait for clk_period;

        waddr_in <= "00001";
        data_in <= X"00000002";
        wait for clk_period;

        waddr_in <= "00010";
        data_in <= X"00000003";
        wait for clk_period;

        waddr_in <= "00011";
        data_in <= X"00000004";
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

        -- Set last_block to 1
        -- Set last valid word to 3 (4th position)
        waddr_in <= "10000";
        data_in <= X"20300002";
        wait for clk_period;

        data_wen <= '0'; -- AHB write enable OFF

        -- wait until data_available = '1'
        if data_available = '0' then
            wait until data_available = '1';
        end if;

        -- Set data_ready to 1 (GPIO PIN)
        data_ready <= '1';

        -- Keep reading addr 8 until we have the 'valid' bit = 1

        result_addr <= "1000";
        result_ren <= '1';

        if do_valid_o = '0' then
            wait until do_valid_o = '1';
        end if;

        data_ready <= '0';

        wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)

        -- Read the first 8 registers

        result_ren <= '1';
        result_addr <= "0000";
        wait for clk_period;
        result_addr <= "0001";
        wait for clk_period;
        result_addr <= "0010";
        wait for clk_period;
        result_addr <= "0011";
        wait for clk_period;
        result_addr <= "0100";
        wait for clk_period;
        result_addr <= "0101";
        wait for clk_period;
        result_addr <= "0110";
        wait for clk_period;
        result_addr <= "0111";
        wait for clk_period;

        wait for (100*clk_period);

        -------------------------------------------------------
        ------------------------------------------------------- TEST AGAIN WITH 2 INCOMPLETE BLOCKS WITH INCOMPLETE WORD (4B only)
        -------------------------------------------------------

        ----------- FIRST BLOCK

        -- result
        result_ren <= '0';
        result_addr <= (others => '0');

        -- input data
        waddr_in <= (others => '0');
        data_in <= (others => '0');
        data_wen <= '0';
        data_ready <= '0';

        RST_N <= '0';

        wait for clk_period;

        RST_N <= '1';

        wait for clk_period;

        -- Write 16 x 32bit

        data_wen <= '1'; -- AHB write enable ON

        waddr_in <= "00000";
        data_in <= X"FCFD4E71";
        wait for clk_period;

        waddr_in <= "00001";
        data_in <= X"41D5B510";
        wait for clk_period;

        waddr_in <= "00010";
        data_in <= X"9CAF49CB";
        wait for clk_period;

        waddr_in <= "00011";
        data_in <= X"C71770DA";
        wait for clk_period;

        waddr_in <= "00100";
        data_in <= X"C84F8BEA";
        wait for clk_period;

        waddr_in <= "00101";
        data_in <= X"FE2D49AE";
        wait for clk_period;

        waddr_in <= "00110";
        data_in <= X"CF53DF1E";
        wait for clk_period;

        waddr_in <= "00111";
        data_in <= X"A016E0AB";
        wait for clk_period;

        waddr_in <= "01000";
        data_in <= X"CC0A6CE7";
        wait for clk_period;

        waddr_in <= "01001";
        data_in <= X"490279D3";
        wait for clk_period;

        waddr_in <= "01010";
        data_in <= X"7389D821";
        wait for clk_period;

        waddr_in <= "01011";
        data_in <= X"0A8BFE76";
        wait for clk_period;

        waddr_in <= "01100";
        data_in <= X"256AD2DD";
        wait for clk_period;

        waddr_in <= "01101";
        data_in <= X"4ADAE0FA";
        wait for clk_period;

        waddr_in <= "01110";
        data_in <= X"037A4506";
        wait for clk_period;

        waddr_in <= "01111";
        data_in <= X"0F371F49";
        wait for clk_period;

        -- Set first_block to 1
        -- Set last word to F
        waddr_in <= "10000";
        data_in <= X"F0000001";
        wait for clk_period;

        data_wen <= '0'; -- AHB write enable OFF

        -- wait until data_available = '1'
        if data_available = '0' then
            wait until data_available = '1';
        end if;

        -- Set data_ready to 1 (GPIO PIN)
        data_ready <= '1';

        wait for (5*clk_period); -- IMPORTANT to wait at least 5 cycles so that req_i can go down

        if waiting_data = '0' then
            wait until waiting_data = '1';
        end if;

        data_ready <= '0';

        ----------- SECOND BLOCK

        -- Write 16 x 32bit

        data_wen <= '1'; -- AHB write enable ON

        waddr_in <= "00000";
        data_in <= X"311E2059";
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

        -- Set last_block to 1
        -- Set last valid word to 0 (1st position)
        waddr_in <= "10000";
        data_in <= X"00000002"; 
        wait for clk_period;

        data_wen <= '0'; -- AHB write enable OFF

        -- wait until data_available = '1'
        if data_available = '0' then
            wait until data_available = '1';
        end if;

        -- Set data_ready to 1 (GPIO PIN)
        data_ready <= '1';

        -- Keep reading addr 8 until we have the 'valid' bit = 1

        result_addr <= "1000";
        result_ren <= '1';

        if do_valid_o = '0' then
            wait until do_valid_o = '1';
        end if;

        data_ready <= '0';

        wait for clk_period; -- IMPORTANT TO WAIT 1 cycle (so that the last register bank has all the proper data)

        -- Read the first 8 registers

        result_ren <= '1';
        result_addr <= "0000";
        wait for clk_period;
        result_addr <= "0001";
        wait for clk_period;
        result_addr <= "0010";
        wait for clk_period;
        result_addr <= "0011";
        wait for clk_period;
        result_addr <= "0100";
        wait for clk_period;
        result_addr <= "0101";
        wait for clk_period;
        result_addr <= "0110";
        wait for clk_period;
        result_addr <= "0111";
        wait for clk_period;

        wait for (100*clk_period);

        wait;
    end process;

end behavioral;


