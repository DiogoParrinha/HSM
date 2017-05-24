---------------------------------------------------------------------------------------------------
--
-- Title       : SHA2
-- Design      : SHA
-- Author      : admin
-- Company     : CE/EWI/TUDELFT
--
---------------------------------------------------------------------------------------------------
--
-- File        : SHA2.vhd
-- Generated   : Thu Dec  8 11:32:08 2005
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use work.SHAComponents.all;

entity SHA2 is
	 port(
	 	 start : in STD_LOGIC;
	 	 GReset : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 MoreData : in STD_LOGIC;
		 IV : in STD_LOGIC_VECTOR(64-1 downto 0);
		 WriteIVHashL : in STD_LOGIC;
		 WriteIVHashH : in STD_LOGIC;
		 ReadHashH : in STD_LOGIC;
		 Wj : in STD_LOGIC_VECTOR(31 downto 0);
		 finish : out STD_LOGIC;
		 OutHash : out STD_LOGIC_VECTOR(256-1 downto 0)
	     );
end SHA2;


architecture SHA2 of SHA2 is


signal DM0, DM1, DM2, DM3, DM4, DM5, DM6, DM7, PRDM0, PRDM1, PRDM2, PRDM3, PRDM4, PRDM5, PRDM6, PRDM7: STD_LOGIC_VECTOR(31 downto 0);
signal A0, E0, A1, B1, C1, D1, E1, F1, G1, H1, Sp, Cp, SpR, CpR, ST1_1, CT1_1: STD_LOGIC_VECTOR(31 downto 0);	
signal AS0, AC0, ES0, EC0, SE0, CE0, Mj, Ch, ST_0, ST_1, CT_0, CT_1, SA_0, SA_1, CA_0, CA_1: STD_LOGIC_VECTOR(31 downto 0);	
signal ktR, E_1, Wi, A_1, kt, Sum1, Sum0, DM0Or0, DM4Or0: STD_LOGIC_VECTOR(31 downto 0);	

signal AddMod, enableAE1, finishingR, VarReset, VarResetB1, VarResetC1, VarResetD1, VarResetF1, VarResetE1, VarResetD, ContReset, LoadInit, AddDM0, AddDM4 : STD_LOGIC;	
signal MoreDataD, enabelDMRec, enabelDM, EnbCont64, finishing, last3 : STD_LOGIC;	 
signal selDM, selDMD, selDMP: STD_LOGIC_VECTOR(0 downto 0);	 
signal Q64, addr: STD_LOGIC_VECTOR(5 downto 0);

begin
	OutHash <= DM0 & DM1 & DM2 & DM3 & DM4 & DM5 & DM6 & DM7;	 
	--OutHash <= DM0 & DM4 when ReadHashH = '0' else DM3 & DM7;
--	Wi <= Wj ;--when MoreDataD = '0' else DM1 xor DM5;
															

		ContReset <= GReset;-- or finishing;

		enabelDM <= last3;
		addr <= Q64 when AddMod = '0' else "111110";--X"3E"; 
		AddMod <= (not MoreData) or finishing;
		selDM(0)  <= start;
		--selDMP(0) <= selDMD(0) or finishing;
		VarReset <= not MoreData;
	 	AddDM0 <= (not MoreDataD) or finishing;
	 	AddDM4 <= (not MoreDataD) or finishing;	 
	 	--StartD <= Start;
	 
	 ktR <= kt;

reg: process(clk)
begin  
	if ((clk'event )and (clk = '1')) then	
		--MoreData <= MoreDataP;		 
	---------- control signals ----------- 	

	 selDMP(0) <= start or finishing or finishingR;
	 LoadInit <= not MoreData;	
--	 WriteIVHashD <= WriteIVHash;
--	 LoadInit <= LoadInitA;
	 MoreDataD <= MoreData;
	 VarResetB1 <= VarReset;
	 VarResetC1 <= VarReset;
	 VarResetD1 <= VarReset;
	 VarResetF1 <= VarReset;
	 VarResetE1 <= VarReset;
	 VarResetD <= VarReset;
	 finish <= finishingR;
	 selDMD(0) <= start or finishingR;	
	 enabelDMRec <= finishingR;	
	 finishingR <= finishing;
	 enableAE1 <= not finishingR;
	 EnbCont64 <= MoreData and (not finishing);
	  --------------- variables -------------
	  if (WriteIVHashL = '1') or (WriteIVHashH = '1') then
		if (WriteIVHashL = '1') then
			DM0 <= IV(31 downto 0);
			DM4 <= IV(32*1+31 downto 32*1);
		end if;  
		if (WriteIVHashH = '1') then
			DM1 <= PRDM1;
			DM2 <= DM1;
			DM3 <= IV(31 downto 0);
			DM5 <= PRDM5;
			DM6 <= DM5;
			DM7 <= IV(32*1+31 downto 32*1);
		  end if;
--		if (WriteIVHashL = '1') then
--			DM0 <= X"6a09e667";
--			DM4 <= X"510e527f";			 
--		end if;  
--		if (WriteIVHashH = '1') then
--			DM1 <= X"bb67ae85";			 
--			DM2 <= X"3c6ef372";			 
--			DM3 <= X"a54ff53a";			 
--			DM5 <= X"9b05688c";			 
--			DM6 <= X"1f83d9ab";			 
--			DM7 <= X"5be0cd19";   
--		  end if;
	  else
		  if (enabelDM = '1') then --or (WriteIVHashH = '1')then	
			DM1 <= PRDM1;
			DM2 <= DM1;
			DM3 <= DM2;
			DM5 <= PRDM5;
			DM6 <= DM5;
			DM7 <= DM6;
		  end if;
		  if enabelDMRec = '1' then	
			DM0 <= A1;
			DM4 <= E1;
		  end if;
		end if;				 
--			A2 <= A1;		
--			B2 <= B1;
--			C2 <= C1;
--			D2 <= D1;
--			E2 <= E1;		
--			F2 <= F1;
--			G2 <= G1;
--			H2 <= H1;		  			
	  end if;					  
end process reg;	
			   
-------  Constant selection acording to the SHA-1 round ------	 
UUT : romkt2
	port map (
		addra => addr,
		douta => kt,
		clka => clk
	);			

------ Carry-Save adder for the partial addition of the values Wt, Kt, H = partial T1 qith initial Pseudo-reset--------
csa3p:	block
 signal z,y,x, C :STD_LOGIC_VECTOR (32-1 downto 0);
 begin								  
	z <= H1;
	y <= Wj;
	x <= ktR;

	Sp <= z xor y xor x;
	C <= (z and y)or(z and x)or(x and y);
	Cp(31 downto 1) <= C(30 downto 0);
	Cp(0) <= '0';

	SpR <= (others => '0') when LoadInit='1' else Sp;
	CpR(31 downto 1) <= (others => '0') when LoadInit='1' else Cp(31 downto 1);	
	CpR(0) <= '0';	-- '1' when LoadInit='1' else
end block csa3p;	

																					  															   											 
DM0Or0	<=  DM0 when AddDM0 = '1' else 
			(others => '0'); 

DM4Or0	<=	DM4 when AddDM4 = '1' else 
			(others => '0'); 


-------- Carry-Save adder for the partial addition of the value of T1 --------
--CSA4 : CSA4Add													  
--	 port map(
--		I1 => SpR,
--		I2 => CpR,
--		I3 => D1,
--		I4 => DM4Or0,
--		Save => ST1_1, 
--		Carry => CT1_1
--	);			 
--	
	
------ Carry-Save adder for the partial addition of the values Wt, Kt, H = partial T1 --------
csa3E:	block
 signal z,y,x, C :STD_LOGIC_VECTOR (32-1 downto 0);
 begin					   
	z <= SpR;
	y <= CpR;
	x <= DM4Or0;

	ST1_1 <= z xor y xor x;
	C <= (z and y)or(z and x)or(x and y);
	CT1_1(31 downto 1) <= C(30 downto 0);
	CT1_1(0) <= '0';
end block csa3E;		
	
	
	
AddE0 : add32
		port map (
			A => ST1_1,
			B => CT1_1,
			S => E_1
			);		
	
	
------ Carry-Save adder for the partial addition of the values Wt, Kt, H = partial T1 --------
csa3A:	block
 signal z,y,x, C :STD_LOGIC_VECTOR (32-1 downto 0);
 begin					   
	z <= SpR;
	y <= CpR;
	x <= DM0Or0;

	SA_1 <= z xor y xor x;
	C <= (z and y)or(z and x)or(x and y);
	CA_1(31 downto 1) <= C(30 downto 0);
	CA_1(0) <= '0';
end block csa3A;	 

AddA0 : add32
		port map (
			A => SA_1,
			B => CA_1,
			S => A_1
			);		
	   
			

	
-------------------------------------------	
--------------- Second level --------------
-------------------------------------------	 
reg2: process(clk)
begin  
   if ((clk'event )and (clk = '1')) then
	 SA_0 <= A_1;
--	 SA_0 <= SA_1;
--	 CA_0 <= CA_1;

	SE0 <=E_1;
--	 SE0 <= ST1_1;
--	 CE0 <= CT1_1;
--	 if (LoadInit='1') then 
--	   CE0(0) <= '1';
--	   CA_1(0) <= '1';
--	 else   
--	   CE0(0) <= '0';
--	   CA_1(0) <= '0';
--	 end if;
   end if;					  
end process reg2;

--------------------------------------------


------  Performes the logical function Mj ------ 	

Mj <=  (A1 and B1) xor (A1 and C1) xor (B1 and C1);

------  Performes the logical function Ch ------

Ch <= (E1 and F1) xor ((not E1) and G1);


------  Performes the logical function Sum_1 -----  	

Sum1 <= (E1 (6-1 downto 0)  & E1(31 downto 6) )  xor
		(E1 (11-1 downto 0) & E1(31 downto 11) ) xor
		(E1 (25-1 downto 0) & E1(31 downto 25) );
		                                            

------  Performes the logical function Sum_0 -----  	
		
Sum0 <= (A1(2-1 downto 0) & A1 (31 downto 2))   xor
		(A1(13-1 downto 0) & A1 (31 downto 13)) xor
		(A1(22-1 downto 0) & A1 (31 downto 22));

		
------------ Carry-Save adder for the final value E ----------
--CSA4E : CSA4Add													  
--	 port map(
--		I1 => SE0,
--		I2 => CE0,
--		I3 => Sum1,
--		I4 => Ch,
--		Save => ES0, 
--		Carry => EC0			
--	);		
--	


CSA4E : CSA4Add													  
	 port map(
		I1 => SE0,
		I2 => D1,
		I3 => Sum1,
		I4 => Ch,
		Save => ES0, 
		Carry => EC0			
	);		
	

--
-------- Carry-Save adder for the partial addition of the values Wt, Kt, H = partial T1 --------
--csa3E:	block
-- signal z,y,x, C :STD_LOGIC_VECTOR (32-1 downto 0);
-- begin					   
--	z <= SE0;
--	y <= Sum1;
--	x <= Ch;
--
--	ES0 <= z xor y xor x;
--	C <= (z and y)or(z and x)or(x and y);
--	EC0(31 downto 1) <= C(30 downto 0);
--	EC0(0) <= '0';
--end block csa3E;	 	
--	
--	
	
E0Add : add32
		port map (
			A => ES0,
			B => EC0,
			S => E0
			);										  	
	
	
------ Carry-Save adder for the final value A -----------
CSA6 : CSA5Add
	 port map(
--		I1 => CA_0,
		I1 => SA_0,
		I2 => Sum0,
		I3 => Sum1,
		I4 => Mj,
		I5 => Ch,
		Save => AS0, 
		Carry => AC0			
	);	

--	
--CSA6 : CSA6AddS
--	 port map(
--		I1 => CA_0,
--		I2 => SA_0,
--		I3 => Sum0,
--		I4 => Sum1,
--		I5 => Mj,
--		I6 => Ch,
--		Save => AS0, 
--		Carry => AC0			
--	);	
--	
	
A0Add : add32
		port map (
			A => AS0,
			B => AC0,
			S => A0
			);	
					  			
reg3: process(clk)
begin  
  if ((clk'event )and (clk = '1')) then
	if ( VarResetD = '1') then 
	 A1 <= (others => '0');
	 E1 <= (others => '0');
	elsif (enableAE1 = '1') then
	 A1 <= A0;
	 E1 <= E0;
	end if;
  end if;					  
end process reg3;			
			
------------------- Variable initialization ------------------

MB1 : mux32_2regv		--- Delayed
		port map (
			MA => A1,	--- Delayed
			MB => DM1,
			S => selDMD(0 downto 0),
			Q => B1,	--- Delayed
			CLK => Clk,
			SCLR => VarResetB1);	

MC1 : mux32_2regv			--- Delayed
		port map (
			MA => B1,		--- Delayed
			MB => DM2,
			S => selDMD(0 downto 0),
			Q => C1,		--- Delayed
			CLK => Clk,
			SCLR => VarResetC1);	
			
--MD1 : mux32_3regv
--		port map (
--			MA => B1,	-- = C1 not delayed
--			MB => DM3,	-- for selDM (S) = 1			  		   
--			MC => DM2,	-- for selDMD (SD)= 1
--			S => selDM,
--			SD=> selDMP,
--			Q => D1,
--			CLK => Clk,
--			SCLR => VarReset);	
--
--			
MD1 : mux32_2regv
		port map (
			MA => C1,	-- = C1 not delayed
			MB => DM3,	-- for selDM (S) = 1
			S => selDMD,
			Q => D1,
			CLK => Clk,
			SCLR => VarResetD1);				
			
			
MF1 : mux32_2regv			--- Delayed
		port map (
			MA => E1,		--- Delayed
			MB => DM5,
			S => selDMD,
			Q => F1,		--- Delayed
			CLK => Clk,
			SCLR => VarResetF1);	

MG1 : mux32_2regv			--- Delayed
		port map (
			MA => F1,		--- Delayed
			MB => DM6,
			S => selDMD,
			Q => G1,		--- Delayed
			CLK => Clk,
			SCLR => VarResetE1);	

MH1 : mux32_3regv
		port map (
			MA => F1,	  	-- = G1 not delayed
			MB => DM7,		-- for selDM (S) = 1
			MC => DM6,		-- for selDMD (SD)= 1
			S => selDM,
			SD=> selDMP,
			Q => H1,
			CLK => Clk,
			SCLR => VarReset);	
			
			
---------------- Final Digest Message addition ---------------

DM1Add : add32
		port map (
			A => A1,	-- = B0
			B => DM3,
			S => PRDM1
			);
	

DM5Add : add32
		port map (
			A => E1,  -- = F0
			B => DM7,
			S => PRDM5
			);

------------- Round counter --------------------
						   			
c20 : cont64inc
	port map(
		reset => ContReset,
		clk => clk,
		inc => EnbCont64,
		last => finishing,
		last3 => last3,
		Q => Q64
	);		
							 						 
end SHA2;
