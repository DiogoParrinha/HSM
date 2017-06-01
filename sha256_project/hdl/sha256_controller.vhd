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

entity sha256_controller is
port (
    read_addr : OUT std_logic_vector(3 downto 0);  -- selects the register to read from
    read_data : IN std_logic_vector(31 downto 0); -- the output at the selected register

    -- SHA-256 Core inputs
    ce_i : out std_logic := 'U';                                     -- core clock enable
    -- input data
    di_i : out std_logic_vector (31 downto 0) := (others => 'U');    -- big endian input message words
    bytes_i : out std_logic_vector (1 downto 0) := (others => 'U');  -- valid bytes in input word
    -- start/end commands
    start_i : out std_logic := 'U';                                  -- reset the engine and start a new hash
    end_i : out std_logic := 'U';                                    -- marks end of last block data input
    -- handshake
    di_wr_i : out std_logic := 'U'                                  -- high for di_i valid, low for hold
);
end sha256_controller;
architecture architecture_sha256_controller of sha256_controller is
   -- signal, component etc. declarations
	signal signal_name1 : std_logic; -- example
	signal signal_name2 : std_logic_vector(1 downto 0) ; -- example

begin

   -- architecture body
end architecture_sha256_controller;
