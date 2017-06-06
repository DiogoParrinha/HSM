--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg_17x32.vhd
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

entity reg_17x32 is
port (
    CLK : IN std_logic;
    RST_N : IN std_logic;
	data_in : IN  std_logic_vector(31 downto 0);
    waddr_in : IN std_logic_vector(4 downto 0);
    raddr_in : IN std_logic_vector(3 downto 0);
    wen : IN std_logic;
    ren : IN std_logic;
    data_out : OUT std_logic_vector(31 downto 0);
    data_out_ready : OUT std_logic;
    data_available : OUT std_logic;
    first_block : OUT std_logic;
    last_block : OUT std_logic
);
end reg_17x32;
architecture architecture_reg_17x32 of reg_17x32 is
    
    signal line0 : std_logic_vector(63 downto 0);
    signal line1 : std_logic_vector(63 downto 0);
    signal line2 : std_logic_vector(63 downto 0);
    signal line3 : std_logic_vector(63 downto 0);
    signal line4 : std_logic_vector(63 downto 0);
    signal line5 : std_logic_vector(63 downto 0);
    signal line6 : std_logic_vector(63 downto 0);
    signal line7 : std_logic_vector(63 downto 0);
    signal line8 : std_logic_vector(63 downto 0);

    signal raddr_pos : std_logic_vector(3 downto 0);
    signal ren_pos : std_logic;

begin

data_out <= line7(63 downto 32) when raddr_pos="1111" and ren_pos='1' else
            line7(31 downto  0) when raddr_pos="1110" and ren_pos='1' else
            line6(63 downto 32) when raddr_pos="1101" and ren_pos='1' else
            line6(31 downto  0) when raddr_pos="1100" and ren_pos='1' else
            line5(63 downto 32) when raddr_pos="1011" and ren_pos='1' else
            line5(31 downto  0) when raddr_pos="1010" and ren_pos='1' else
            line4(63 downto 32) when raddr_pos="1001" and ren_pos='1' else
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

first_block <= line8(0);
last_block <= line8(1);

process(CLK)
begin
    if rising_edge(CLK) then
        if RST_N='0' then
            line0 <= (others => '0');
            line1 <= (others => '0');
            line2 <= (others => '0');
            line3 <= (others => '0');
            line4 <= (others => '0');
            line5 <= (others => '0');
            line6 <= (others => '0');
            line7 <= (others => '0');
            line8 <= (others => '0');

            ren_pos <= '0';
            raddr_pos <= (others => '0');
            data_out_ready <= '0';
            data_available <= '0';
        else
            ren_pos <= ren;
            if(ren='1') then 
                raddr_pos <= raddr_in;
                data_out_ready <= '1';
            elsif(wen='1') then
                data_out_ready <= '0';
                if (waddr_in="10001") then
                    line8(63 downto 32) <= data_in;
                elsif (waddr_in="10000") then
                    line8(31 downto 0) <= data_in;
                    data_available <= '1'; -- we wrote to the last available register so we're ready (no need for the one above because we don't use it)
                elsif (waddr_in="01111") then
                    line7(63 downto 32) <= data_in;
                elsif (waddr_in="01110") then
                    line7(31 downto 0) <= data_in;
                elsif (waddr_in="01101") then
                    line6(63 downto 32) <= data_in;
                elsif (waddr_in="01100") then
                    line6(31 downto 0) <= data_in;
                elsif (waddr_in="01011") then
                    line5(63 downto 32) <= data_in;
                elsif (waddr_in="01010") then
                    line5(31 downto 0) <= data_in;
                elsif (waddr_in="01001") then
                    line4(63 downto 32) <= data_in;
                elsif (waddr_in="01000") then
                    line4(31 downto 0) <= data_in;
                elsif (waddr_in="00111") then
                    line3(63 downto 32) <= data_in;
                elsif (waddr_in="00110") then
                    line3(31 downto 0) <= data_in;
                elsif (waddr_in="00101") then
                    line2(63 downto 32) <= data_in;
                elsif (waddr_in="00100") then
                    line2(31 downto 0) <= data_in;
                elsif (waddr_in="00011") then
                    line1(63 downto 32) <= data_in;
                elsif (waddr_in="00010") then
                    line1(31 downto 0) <= data_in;
                elsif (waddr_in="00001") then
                    line0(63 downto 32) <= data_in;
                elsif (waddr_in="00000") then
                    line0(31 downto 0) <= data_in;
                end if;
            end if;
        end if;
    end if;
end process;

end architecture_reg_17x32;
