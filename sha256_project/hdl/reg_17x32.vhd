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
    raddr_in : IN std_logic_vector(4 downto 0);
    wen : IN std_logic;
    ren : IN std_logic;
    data_out : OUT std_logic_vector(31 downto 0);
    data_out_ready : OUT std_logic;

    --reg0_out : OUT std_logic_vector(31 downto 0);
    --reg1_out : OUT std_logic_vector(31 downto 0);
    --reg2_out : OUT std_logic_vector(31 downto 0);
    --reg3_out : OUT std_logic_vector(31 downto 0);
    --reg4_out : OUT std_logic_vector(31 downto 0);
    --reg5_out : OUT std_logic_vector(31 downto 0);
    --reg6_out : OUT std_logic_vector(31 downto 0);
    --reg7_out : OUT std_logic_vector(31 downto 0);
    --reg8_out : OUT std_logic_vector(31 downto 0);
    --reg9_out : OUT std_logic_vector(31 downto 0);
    --reg10_out : OUT std_logic_vector(31 downto 0);
    --reg11_out : OUT std_logic_vector(31 downto 0);
    --reg12_out : OUT std_logic_vector(31 downto 0);
    --reg13_out : OUT std_logic_vector(31 downto 0);
    --reg14_out : OUT std_logic_vector(31 downto 0);
    --reg15_out : OUT std_logic_vector(31 downto 0);
    --reg16_out : OUT std_logic_vector(31 downto 0);
    --reg17_out : OUT std_logic_vector(31 downto 0);
    --reg18_out : OUT std_logic_vector(31 downto 0);

    data_available : OUT std_logic;
    first_block : OUT std_logic;
    last_block : OUT std_logic;
    valid_bytes : OUT std_logic_vector(31 downto 0);
    last_word : OUT std_logic_vector(3 downto 0)
);
end reg_17x32;
architecture architecture_reg_17x32 of reg_17x32 is
    
    signal line0 : std_logic_vector(63 downto 0); -- words 1 and 2
    signal line1 : std_logic_vector(63 downto 0); -- words 3 and 4
    signal line2 : std_logic_vector(63 downto 0); -- words 5 and 6
    signal line3 : std_logic_vector(63 downto 0); -- words 7 and 8
    signal line4 : std_logic_vector(63 downto 0); -- words 9 and 10
    signal line5 : std_logic_vector(63 downto 0); -- words 11 and 12
    signal line6 : std_logic_vector(63 downto 0); -- words 13 and 14
    signal line7 : std_logic_vector(63 downto 0); -- words 15 and 16
    signal line8 : std_logic_vector(63 downto 0); -- control bits and d_bytes (2 bits per word => 32bits)

    signal raddr_pos : std_logic_vector(4 downto 0);
    signal ren_pos : std_logic;

begin

data_out <= line8(63 downto 32) when raddr_pos="10001" and ren_pos='1' else
            line8(31 downto  0) when raddr_pos="10000" and ren_pos='1' else
            line7(63 downto 32) when raddr_pos="01111" and ren_pos='1' else
            line7(31 downto  0) when raddr_pos="01110" and ren_pos='1' else
            line6(63 downto 32) when raddr_pos="01101" and ren_pos='1' else
            line6(31 downto  0) when raddr_pos="01100" and ren_pos='1' else
            line5(63 downto 32) when raddr_pos="01011" and ren_pos='1' else
            line5(31 downto  0) when raddr_pos="01010" and ren_pos='1' else
            line4(63 downto 32) when raddr_pos="01001" and ren_pos='1' else
            line4(31 downto  0) when raddr_pos="01000" and ren_pos='1' else
            line3(63 downto 32) when raddr_pos="00111" and ren_pos='1' else
            line3(31 downto  0) when raddr_pos="00110" and ren_pos='1' else
            line2(63 downto 32) when raddr_pos="00101" and ren_pos='1' else
            line2(31 downto  0) when raddr_pos="00100" and ren_pos='1' else
            line1(63 downto 32) when raddr_pos="00011" and ren_pos='1' else
            line1(31 downto  0) when raddr_pos="00010" and ren_pos='1' else
            line0(63 downto 32) when raddr_pos="00001" and ren_pos='1' else
            line0(31 downto  0) when raddr_pos="00000" and ren_pos='1' else
            (others => '0');

first_block <= line8(0);
last_block <= line8(1);
valid_bytes <= line8(63 downto 32);
last_word <= line8(31 downto 28);

--reg0_out <= line0(31 downto  0);
--reg1_out <= line0(63 downto  32);
--reg2_out <= line1(31 downto  0);
--reg3_out <= line1(63 downto  32);
--reg4_out <= line2(31 downto  0);
--reg5_out <= line2(63 downto  32);
--reg6_out <= line3(31 downto  0);
--reg7_out <= line3(63 downto  32);
--reg8_out <= line4(31 downto  0);
--reg9_out <= line4(63 downto  32);
--reg10_out <= line5(31 downto  0);
--reg11_out <= line5(63 downto  32);
--reg12_out <= line6(31 downto  0);
--reg13_out <= line6(63 downto  32);
--reg14_out <= line7(31 downto  0);
--reg15_out <= line7(63 downto  32);
--reg16_out <= line8(31 downto  0);

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
                    data_available <= '1'; -- we wrote to the last available register so we're ready (no need for the one above because we don't use it)
                elsif (waddr_in="10000") then
                    line8(31 downto 0) <= data_in;
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
