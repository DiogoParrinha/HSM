library IEEE;	   
use IEEE.STD_LOGIC_1164.ALL;
use work.SHAComponents.all;


entity wordGen is
    Port ( 
		clk : in std_logic;
--		reset : in std_logic;
        first16 : in std_logic;
        InWi : in std_logic_vector(31 downto 0);
        OutWi : out std_logic_vector(31 downto 0)
	);
end wordGen;

architecture MemBased of wordGen is


signal index, index_2 : std_logic_VECTOR(3 downto 0);
signal index_5 : std_logic_VECTOR(2 downto 0);
signal XorWiTmp1, XorWiR, Wi, XorWi, Wi_2, Wi_16, Wi_7, Wi_15, GW0, GW1, Sw, Cw, SwR, CwR,PXorWi, PXorWiR: std_logic_VECTOR(31 downto 0);
signal one : std_logic;

begin	   							   
	
------------------------- global to all architectures ------------	
	
Wi <= InWi when first16 = '1' else 
	XorWiR; --  XorWi(31-1 downto 0) & XorWi(31 downto 31-0);  -- ROTL1(XorWi)
	
	OutWi <= wi;	
	
---------------------------------- Only Registers (begin) -----------------------------------	
	
OutWi <= wi;

REgBlock : block
 type word_vector is array (natural range <>) of std_logic_vector(31 downto 0);
 signal regArray : word_vector(15 downto 0);
 
begin 										
	 
ar : process (CLK, Wi) 	
	begin 
		if clk'event and clk='1' then 
				XorWiR <= XorWi;
				regArray(0) <= Wi;
				PXorWiR <= PXorWi;	 
				SwR <= Sw;
				CwR <= Cw;
			for i in 1 to 12 loop
				regArray(i) <= regArray(i-1);
			end loop;						 						  			
		end if;
end process;		
	 
--Wi_8  <= regArray(8-1);
--Wi_3  <= regArray(3-1);
--Wi_14 <= regArray(14-1);
--Wi_16 <= regArray(16-1);

Wi_2  <= regArray(2-2);	 

  
GW1 <= (Wi_2(17-1 downto 0) & Wi_2 (31 downto 17)) xor
	   (Wi_2(19-1 downto 0) & Wi_2 (31 downto 19)) xor
	   ("0000000000" & Wi_2(31 downto 10) );
	
--XorWi <= PXorWiR xor GW1;

--Add3W : Add32_3
--	 port map(
--		A => SwR,
--		B => CwR,
--		C => GW1,
--		Res => XorWi
--	);		 	
--
--
--

AddW : add32
		port map (
			A => PXorWiR,
			B => GW1,
			S => XorWi
			);		
	   
----------------------------------		  
Wi_7  <= regArray(7-3);


GW0 <= (Wi_15(7-1 downto 0) & Wi_15 (31 downto 7))   xor
	   (Wi_15(18-1 downto 0) & Wi_15 (31 downto 18)) xor
	   ("000" & Wi_15(31 downto 3));
	   
	   		------2 ---------------
--csa3A:	block
-- signal z,y,x, C :STD_LOGIC_VECTOR (32-1 downto 0);
-- begin					   
--
--	z <= Wi_16;
--	y <= Wi_7;
--	x <= GW0;
--
--	Sw <= z xor y xor x;
--	C <= (z and y)or(z and x)or(x and y);
--	Cw(31 downto 1) <= C(30 downto 0);
--	Cw(0) <= '0';
--end block csa3A;	
--
--
--AddIW : add32
--		port map (
--			A => Sw,
--			B => Cw,
--			S => PXorWi
--			);	

			
			------3 ---------------
			
Wi_15 <= regArray(15-4);
Wi_16 <= regArray(16-4);
			
			
AddI1 : add32
		port map (
			A => Wi_16,
			B => GW0,
			S => Sw
			);	

AddI2 : add32
		port map (
			A => SwR,
			B => Wi_7,
			S => PXorWi
			);		
--	   	 		
----------------------------------------------------------	   
--CSA4W : CSA4Add													  
--	 port map(
--		I1 => Wi_16,
--		I2 => Wi_7,
--		I3 => GW0,
--		I4 => GW1,
--		Save => Sw, 
--		Carry => Cw
--	);	
--	
--
--AddW : add32
--		port map (
--			A => Sw,
--			B => Cw,
--			S => XorWi
--			);		
	   
	   

	   
	   
end block;







end MemBased;