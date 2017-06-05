--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: sha256_controller.vhd
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


--Notes:
--* the sha256 core needs 65 cycles per 512-bit block
--* The hash operation starts with a 'begin' sync pulse (start_i) which causes the RESET of the processor
--* The processor comes out of RESET only after 'begin' is released. 
--* The DATA_INPUT state is signalled by the data request signal 'di_req' going HIGH
--* The processor reads 16 words from the 'di_i' port at every rising edge of the clock.
--* At the end of the 512-bit block input, the 'di_req' signal goes LOW (output of the core)

library IEEE;

use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sha256_controller is
port (
    read_addr : OUT std_logic_vector(3 downto 0);  -- selects the register to read from
    read_data : IN std_logic_vector(31 downto 0); -- the output at the selected register

    data_ready : IN std_logic;
    last_block : IN std_logic;
    first_block : IN std_logic;

    --wait_data : OUT std_logic;
    clk : in std_logic := 'U';                                       -- system clock
    RST_N : IN std_logic;

    -- SHA-256 Core inputs
    ce_o : out std_logic := 'U';                                     -- core clock enable
    -- input data
    di_o : out std_logic_vector (31 downto 0) := (others => 'U');    -- big endian input message words
    bytes_o : out std_logic_vector (1 downto 0) := (others => 'U');  -- valid bytes in input word
    -- start/end commands
    start_o : out std_logic := 'U';                                  -- reset the engine and start a new hash
    end_o : out std_logic := 'U';                                    -- marks end of last block data input
    -- handshake
    di_req_i : in std_logic;                                         -- requests data input for next word
    di_wr_o : out std_logic := 'U';                                   -- high for di_i valid, low for hold
    di_valid_i : in std_logic                                       -- requests data input for next word
);
end sha256_controller;
architecture architecture_sha256_controller of sha256_controller is

    TYPE STATE_TYPE IS (wait_data, init_block, process_word, process_wait, end_block, wait_finish);

	signal counter : std_logic_vector(3 downto 0);
    signal state : STATE_TYPE;
    signal sel_di : std_logic;
    signal start_counting : std_logic;
    signal extra_add : std_logic := '0';
    signal restart : std_logic := '0';
    signal new_block : std_logic := '0';
    signal blocks_counter : std_logic_vector(31 downto 0);
begin

    PROCESS (clk, RST_N)
    BEGIN
        IF RST_N = '0' THEN
            state <= wait_data;
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE state IS
                WHEN wait_data=>
                    IF data_ready = '1' THEN
                        state <= init_block;
                    ELSE
                        state <= wait_data;
                    END IF;
                WHEN init_block=>
                    state <= process_wait;
                WHEN process_word=>
                    IF counter = "1111" THEN
                        state <= end_block;
                    ELSIF di_req_i = '0' THEN
                        state <= process_wait;
                    ELSE
                        state <= process_word;
                    END IF;
                WHEN process_wait=>
                    IF di_req_i = '1' THEN
                        state <= process_word;
                    ELSE
                        state <= process_wait;
                    END IF;
                WHEN end_block=>
                    state <= wait_finish;
                WHEN wait_finish=>
                    IF (di_req_i = '1' or di_valid_i = '1') THEN
                        state <= wait_data;
                    ELSE
                        state <= wait_finish;
                    END IF;
            END CASE;
        END IF;
    END PROCESS;

    PROCESS (state, last_block, di_req_i, blocks_counter)
    BEGIN
        CASE state IS
            WHEN wait_data =>
                ce_o <= '0';
                start_o <= '0';
                end_o <= '0';
                di_wr_o <= '0';
                bytes_o <= "00";
                sel_di <= '0';
                start_counting <= '0';
                extra_add <= '0';
                restart <= '1';
                new_block <= '0';
            WHEN init_block =>
                ce_o <= '1';
                if(blocks_counter = 0) then
                    start_o <= '1';
                end if;
                end_o <= '0';
                di_wr_o <= '0';
                sel_di <= '1';
                bytes_o <= "00";
                start_counting <= '0';
                extra_add <= '0';
                new_block <= '1';
                restart <= '0';
            WHEN process_word =>
                ce_o <= '1';
                start_o <= '0';
                end_o <= '0';
                di_wr_o <= '1';
                bytes_o <= "00";
                sel_di <= '1';
                start_counting <= '1';
                extra_add <= '0';
                new_block <= '0';
            WHEN process_wait =>
                di_wr_o <= '0';
                sel_di <= '0';
                start_o <= '0';
                start_counting <= '0';
                if(di_req_i = '1' and counter = 0) then
                    extra_add <= '1';
                end if;
                new_block <= '0';
            WHEN end_block =>
                if(last_block = '1') then
                    end_o <= '1';
                end if;
                start_counting <= '1';
                extra_add <= '0';
                new_block <= '0';
            WHEN wait_finish =>
                di_wr_o <= '0';
                end_o <= '0';
                sel_di <= '0';  
                start_counting <= '0';
                extra_add <= '0';
                new_block <= '0';
        END CASE;
    END PROCESS;

    process(clk, RST_N, first_block, new_block)
        begin
        if RST_N = '0' or first_block = '1' then
            blocks_counter <= (others => '0');
        elsif (clk='1' and clk'event) then
            if(new_block = '1') then
                blocks_counter <= blocks_counter + 1;
            end if;
        end if;
    end process;

    process(clk, RST_N, start_counting, extra_add, restart)
        begin
        if RST_N = '0' or restart = '1' then
            counter <= (others => '0');
        elsif (clk='1' and clk'event) then
            if(counter = "1111") then
                counter <= "0000";
            elsif(start_counting = '1') then
                counter <= counter + 1;
            else
                counter <= counter + extra_add;
            end if;
        end if;
    end process;

    -- read address
    read_addr <= counter;

    -- output word
    di_o <=
        X"00000000" when (sel_di = '0') else
        read_data when (sel_di = '1') else
        (others => 'X');

   -- architecture body
end architecture_sha256_controller;