--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg_1x32.vhd
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

entity reg_1x32 is
port (
    CLK : IN std_logic;
    RST_N : IN std_logic;
	data_in : IN  std_logic_vector(31 downto 0);
    wen : IN std_logic;
    ren : IN std_logic;
    data_out : OUT std_logic_vector(31 downto 0)
);
end reg_1x32;
architecture architecture_reg_1x32 of reg_1x32 is
    
    signal line : std_logic_vector(31 downto 0);

    signal ren_pos : std_logic;

begin

data_out <= line(31 downto 0) when ren_pos='1' else
            (others => '0');

process(CLK, RST_N)
begin
    if rising_edge(CLK) then
        if RST_N='0' then
            line <= (others => '0');
            ren_pos <= '0';
        else
            ren_pos <= ren;
            if(wen='1') then
                line(31 downto 0) <= data_in;
            end if;
        end if;
    end if;
end process;

end architecture_reg_1x32;
