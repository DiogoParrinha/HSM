--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: zero_concat.vhd
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

entity zero_concat is
port (
	s1 : IN  std_logic;
    s2 : IN  std_logic;
    s3 : IN  std_logic;

    s_32bit : OUT std_logic_vector(31 downto 0) 
);
end zero_concat;
architecture architecture_zero_concat of zero_concat is

begin

   s_32bit <= "00000000000000000000000000000" & s1 & s2 & s3;

end architecture_zero_concat;
