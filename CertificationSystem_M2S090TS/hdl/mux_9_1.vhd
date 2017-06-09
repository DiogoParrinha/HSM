--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: mux_9_1.vhd
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

library IEEE;

use IEEE.std_logic_1164.all;

entity mux_9_1 is
port (
	sel : IN  std_logic_vector(3 downto 0);

    d0 : IN  std_logic_vector(31 downto 0);
    d1 : IN  std_logic_vector(31 downto 0);
    d2 : IN  std_logic_vector(31 downto 0);
    d3 : IN  std_logic_vector(31 downto 0);
    d4 : IN  std_logic_vector(31 downto 0);
    d5 : IN  std_logic_vector(31 downto 0);
    d6 : IN  std_logic_vector(31 downto 0);
    d7 : IN  std_logic_vector(31 downto 0);
    d8 : IN  std_logic_vector(31 downto 0);

    data_out : OUT std_logic_vector(31 downto 0)
);
end mux_9_1;
architecture architecture_mux_9_1 of mux_9_1 is

begin

   data_out <=
        d0 when (sel = "0000") else
        d1 when (sel = "0001") else
        d2 when (sel = "0010") else
        d3 when (sel = "0011") else
        d4 when (sel = "0100") else
        d5 when (sel = "0101") else
        d6 when (sel = "0110") else
        d7 when (sel = "0111") else
        d8 when (sel = "1000") else
        (others => 'X');

end architecture_mux_9_1;
