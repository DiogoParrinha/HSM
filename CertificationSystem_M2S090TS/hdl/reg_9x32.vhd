--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg_9x32.vhd
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

entity reg_9x32 is
port (
    CLK : IN std_logic;
    RST_N : IN std_logic;
	data_in : IN  std_logic_vector(31 downto 0);
    waddr_in : IN std_logic_vector(3 downto 0);
    raddr_in : IN std_logic_vector(3 downto 0);
    wen : IN std_logic;
    ren : IN std_logic;
    data_out : OUT std_logic_vector(31 downto 0)
);
end reg_9x32;
architecture architecture_reg_9x32 of reg_9x32 is
    
    signal line0 : std_logic_vector(63 downto 0);
    signal line1 : std_logic_vector(63 downto 0);
    signal line2 : std_logic_vector(63 downto 0);
    signal line3 : std_logic_vector(63 downto 0);
    signal line4 : std_logic_vector(63 downto 0);

    signal raddr_pos : std_logic_vector(3 downto 0);
    signal ren_pos : std_logic;

begin

data_out <= line4(63 downto 32) when raddr_pos="1001" and ren_pos='1' else
            line4(31 downto  0) when raddr_pos="1000" and ren_pos='1' else
            line3(63 downto 32) when raddr_pos="0111" and ren_pos='1' else
            line3(31 downto  0) when raddr_pos="0110" and ren_pos='1' else
            line2(63 downto 32) when raddr_pos="0101" and ren_pos='1' else
            line2(31 downto  0) when raddr_pos="0100" and ren_pos='1' else
            line1(63 downto 32) when raddr_pos="0011" and ren_pos='1' else
            line1(31 downto  0) when raddr_pos="0010" and ren_pos='1' else
            line0(63 downto 32) when raddr_pos="0001" and ren_pos='1' else
            line0(31 downto  0) when raddr_pos="0000" and ren_pos='1' else
            (others => '0');

process(CLK)
begin
    if rising_edge(CLK) then
        if RST_N='0' then
            line0 <= (others => '0');
            line1 <= (others => '0');
            line2 <= (others => '0');
            line3 <= (others => '0');
            line4 <= (others => '0');
            ren_pos <= '0';
            raddr_pos <= (others => '0');
        else
            ren_pos <= ren;
            if(ren='1') then 
                raddr_pos <= raddr_in;
            elsif(wen='1') then
                if (waddr_in="1001") then
                    line4(63 downto 32) <= data_in;
                elsif (waddr_in="1000") then
                    line4(31 downto 0) <= data_in;
                elsif (waddr_in="0111") then
                    line3(63 downto 32) <= data_in;
                elsif (waddr_in="0110") then
                    line3(31 downto 0) <= data_in;
                elsif (waddr_in="0101") then
                    line2(63 downto 32) <= data_in;
                elsif (waddr_in="0100") then
                    line2(31 downto 0) <= data_in;
                elsif (waddr_in="0011") then
                    line1(63 downto 32) <= data_in;
                elsif (waddr_in="0010") then
                    line1(31 downto 0) <= data_in;
                elsif (waddr_in="0001") then
                    line0(63 downto 32) <= data_in;
                elsif (waddr_in="0000") then
                    line0(31 downto 0) <= data_in;
                else
                    line0 <= (others => '0');
                    line1 <= (others => '0');
                    line2 <= (others => '0');
                    line3 <= (others => '0');
                    line4 <= (others => '0');
                end if;
            end if;
        end if;
    end if;
end process;

end architecture_reg_9x32;
