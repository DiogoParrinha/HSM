--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: add32.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S090TS> <Package::484 FBGA>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity add32 is
port (
    A : IN  std_logic_vector(31 downto 0);
    B : IN  std_logic_vector(31 downto 0);
    S : OUT  std_logic_vector(31 downto 0)
);
end add32;
architecture architecture_add32 of add32 is
begin

   S <= A+B;

end architecture_add32;
