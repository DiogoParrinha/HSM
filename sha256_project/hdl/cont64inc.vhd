---------------------------------------------------------------------------------------------------
--
-- Title       : cont64Inc
-- Design      : SHA
-- Author      : Ricardo Chaves
-- Company     : TUDELFT/IST
-- File        : cont64Inc.vhd
-- Generated   : Fri Dec  9 12:13:30 2005
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity cont64Inc is
	 port(
		 reset : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 inc : in STD_LOGIC;
		 last : out STD_LOGIC;
		 last3: out STD_LOGIC;
		 Q : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end cont64Inc;

architecture cont64Inc of cont64Inc is

signal COUNT_INT: STD_LOGIC_VECTOR(5 downto 0);
signal lst, lst3: STD_LOGIC;

begin

cont: process (CLK, RESET, inc) 	
		begin 
			if clk'event and clk='1' then 				   
				if inc = '1' then 
					last3 <= lst3;  -- 1 when cont equal for 61 to 63;
					last <= lst;    -- 1 when cont equal to 63;
				else   
					last3 <= '0';  -- 1 when cont equal for 61 to 63;
					last <= '0';    -- 1 when cont equal to 63;
				end if;
				if COUNT_INT(5 downto 2) = "1111" then
					if COUNT_INT(1 downto 0) = "11" then
						lst3 <= '0';
					else											
						lst3 <= '1';
					end if;
				
					if COUNT_INT(1 downto 0) = "01" then
						lst <= '1';
					else											
						lst <= '0';
					end if;						
				else 
					lst3 <= '0';
					lst <= '0';
				end if;			 
				
				if (reset = '1') then 
					COUNT_INT <= (others => '0'); 
				elsif inc = '1' then  
					COUNT_INT <= COUNT_INT + 1; 
				end if;
			end if;
		end process;
		Q <= (others => '1') when inc = '0' else COUNT_INT ;		 
		
		
end cont64Inc;