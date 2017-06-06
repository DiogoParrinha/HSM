--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: limiter_1cycle.vhd
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

entity limiter_1cycle is
port (
    CLK : IN std_logic;
    sig_xcycles : in std_logic;
    sig_1cycle : out std_logic
);
end limiter_1cycle;
architecture architecture_limiter_1cycle of limiter_1cycle is
    
    signal prev_sig : std_logic := '0';

begin

sig_1cycle <= '1' when sig_xcycles='1' and prev_sig='0' else
                     '0';

process(CLK)
begin
    if rising_edge(CLK) then
        prev_sig <= sig_xcycles;
    end if;
end process;

end architecture_limiter_1cycle;