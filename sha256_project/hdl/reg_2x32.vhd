--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg_2x32.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S060T> <Package::484 FBGA>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity reg_2x32 is
port (
    data_in : in std_logic_vector(31 downto 0);
    clk: in std_logic;
    rst : in std_logic;
    wen :  in std_logic;
    ren :  in std_logic;
    waddr : in std_logic;
    raddr : in std_logic;
    data_out : OUT std_logic_vector(31 downto 0)  -- example
    --<other_ports>;
);
end reg_2x32;
architecture architecture_reg_2x32 of reg_2x32 is
	signal temp : std_logic_vector(2*32-1 downto 0) ; -- example

begin

process(clk)
begin
    if rising_edge(clk) then
        if(rst='1') then
            temp <= (others => '0');
        else
            if(wen='1') then
                if waddr='0' then
                    temp(31 downto 0) <= data_in;
                else
                    temp(63 downto 32) <= data_in;
                end if;
            elsif(ren='1') then
                if raddr='0' then
                    data_out <= temp(31 downto 0);
                else
                    data_out <= temp(63 downto 32);
                end if;
            else
                data_out <= (others => '0');
            end if;
        end if;
    end if;
end process;
   -- architecture body
end architecture_reg_2x32;
