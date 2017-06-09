--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: mux2_1.vhd
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

entity mux2_1 is
port (
	d0 : IN  std_logic;
	d1 : IN  std_logic;
	sel : IN  std_logic;
    dout : OUT std_logic 
);
end mux2_1;
architecture architecture_mux2_1 of mux2_1 is

begin

   dout <= d0 when (sel = '0') else
        d1 when (sel = '1') else
        '0';

   -- architecture body
end architecture_mux2_1;
