LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux32_2regv IS
	port (
	MA: IN std_logic_VECTOR(31 downto 0);
	MB: IN std_logic_VECTOR(31 downto 0);
	S: IN std_logic_VECTOR(0 downto 0);
	Q: OUT std_logic_VECTOR(31 downto 0);
	CLK: IN std_logic;
	SCLR: IN std_logic);
END mux32_2regv;

ARCHITECTURE mux32_2regv OF mux32_2regv IS

BEGIN

MuxReg : process (clk)
begin
		if CLK'event and CLK='1' then
			if SCLR = '1' then
				Q <= (others => '0');	-- resets WiCont counter
			elsif S(0) = '1' then
				Q <= MB;
			else 
				Q <= MA;
		end if;			
	end if;
end process MuxReg;


--
--ME1 : mux32_2reg
--		port map (
--			MA => MA,
--			MB => MB,
--			S  => S, 
--			Q  => Q, 
--			CLK  => Clk,
--			SCLR => SCLR);	
--


END mux32_2regv;