--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg1_highonly.vhd
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

-- stays 1 after it has been set to 1; can only go back to 0 with reset

library IEEE;

use IEEE.std_logic_1164.all;

entity reg1_highonly is
port (
    CLK : IN std_logic;
    RST_N : IN std_logic;
	data_in : IN  std_logic;
    wen : IN std_logic;
    data_out : OUT std_logic
);
end reg1_highonly;
architecture architecture_reg1_highonly of reg1_highonly is
    
    signal data : std_logic;

begin

data_out <= data;

process(CLK, RST_N)
begin
    if rising_edge(CLK) then
        if RST_N='0' then
            data <= '0';
        else
            if(wen='1' and data_in='1') then
                data <= '1';
            end if;
        end if;
    end if;
end process;

end architecture_reg1_highonly;
