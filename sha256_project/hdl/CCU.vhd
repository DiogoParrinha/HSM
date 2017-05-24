---------------------------------------------------------------------------------------------------
--
-- Title       : CCU
-- Design      : SHA
-- Author      : admin
-- Company     : CE/EWI/TUDELFT
--
---------------------------------------------------------------------------------------------------
--
-- File        : CCU.vhd
-- Generated   : Tue Dec 13 16:27:04 2005
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
--use work.functions.all;	
use work.SHAComponents.all;

entity CCU is
   Port (
		RST : IN std_logic;
		clk : IN std_logic;
		CCU_clk : IN std_logic;
		start_op : IN std_logic;
		MIR : IN std_logic_vector(63 downto 0);
		XREG_RD_DBUS : IN std_logic_vector(31 downto 0);
		read_data : IN std_logic_vector(63 downto 0);          
		end_op : OUT std_logic;
		status : OUT std_logic_vector(1 downto 0);
		XREG_addr : OUT std_logic_vector(9 downto 0);
		XREG_WR_DBus : OUT std_logic_vector(31 downto 0);
		XREG_write : OUT std_logic;
		data_addr : OUT std_logic_vector(31 downto 0);
		brw : OUT std_logic_vector(7 downto 0);
		write_data : OUT std_logic_vector(63 downto 0)
	  );
	  	attribute secure_config : string;
		attribute secure_config of ccu : entity is "PROTECT";
		attribute secure_netlist : string;
		attribute secure_netlist of ccu : entity is "PROHIBIT";
end ccu;



architecture CCU of CCU is	 

type word_vector is array (natural range <>) of std_logic_vector(31 downto 0);

--signal : word_vector(15 downto 0);
signal WiReg : std_logic_vector(63 downto 0);
signal MemAdd, Wi : std_logic_vector(31 downto 0);
signal IV : std_logic_vector(64-1 downto 0);
signal OutHash: std_logic_vector(256-1 downto 0);
signal HashPart : std_logic_vector(1 downto 0);
signal IV_vector, OutHash_vector: word_vector(7 downto 0);

signal WriteIVHashL,WriteIVHashH, ReadHashH, MoreData, CoreReset, WriteIVHash, LoadWiR, StartCore, Reset, LoadWi: std_logic;
signal endWi, writeWi, writeIV, writeHash, load, resetSHA, finish, WriteMem: std_logic;

		


begin
	
XREG_write <= '0';

Reset <= RST ;
	
ContU : controlunit
	port map(
		clk => clk,
		Start => start_op,
		finish => finish,
		Reset => Reset,
		XRegData => XREG_RD_DBUS,
		CoreReset => CoreReset,
		writeWi => writeWi,
		endWi => endWi,
		WriteIVHashL => WriteIVHashL,
		WriteIVHashH => WriteIVHashH,
		ReadHashH => ReadHashH,
		HashPart => HashPart,
		StartCore => StartCore,
		MoreData => MoreData,
		LoadWi => LoadWi,
		stop => end_op,  
		WriteMem => WriteMem,
		MemAdd => MemAdd,			
		XRegAdd => XREG_addr
	);	

--XREG_addr	<= temp(9 downto 0);
-- temp(31 downto 10) <= (others => '0');

SHA1C : sha2_core
	port map(
		start  => StartCore,
		MoreData => MoreData,
		Reset  => CoreReset,
		clk    => clk,
		IV     => IV,
		WriteIVHashL => WriteIVHashL,
		WriteIVHashH => WriteIVHashH,
		ReadHashH => ReadHashH,
		LoadWi => LoadWiR,
		Wi     => Wi,
		finish => finish,
		OutHash=> OutHash
	);					   
	

data_addr  <= MemAdd;
	
--write_data <= OutHash_vector(0) &  OutHash_vector(1) when HashPart= "00" else 
--			  OutHash_vector(2) &  OutHash_vector(3) when HashPart= "01" else 	
--			  OutHash_vector(4) &  OutHash_vector(5) when HashPart= "10" else 	
--			  OutHash_vector(6) &  OutHash_vector(5);   -- when HashPart= "11" else 

write_data <= OutHash_vector(0) &  OutHash_vector(4) when HashPart= "00" else 
			  OutHash_vector(2) &  OutHash_vector(6) when HashPart= "01" else 	
			  OutHash_vector(1) &  OutHash_vector(5) when HashPart= "10" else 	
			  OutHash_vector(3) &  OutHash_vector(7);   -- when HashPart= "11" else 
				  
				  
				  
brw <= (others => WriteMem);			  
				  
				  
-- Wi <= WiReg(63 downto 32) when endWi = '0' else WiReg(31 downto 0); 		              

--IV <= WI_V(0) & WI_V(1) & WI_V(2) & WI_V(3) & WI_V(4);
	
--IV <= IV_vector(0) & IV_vector(1) & IV_vector(2) & IV_vector(3) & IV_vector(4);
--
--OutHash_vector(4) <=  WI_V(0);
--OutHash_vector(3) <=  WI_V(1);
--OutHash_vector(2) <=  WI_V(2);
--OutHash_vector(1) <=  WI_V(3);
--OutHash_vector(0) <=  WI_V(4);


OutHash_vector(7) <= OutHash(31 downto 0);
OutHash_vector(6) <= OutHash(32*1+31 downto 32*1);
OutHash_vector(5) <= OutHash(32*2+31 downto 32*2);
OutHash_vector(4) <= OutHash(32*3+31 downto 32*3);
OutHash_vector(3) <= OutHash(32*4+31 downto 32*4);
OutHash_vector(2) <= OutHash(32*5+31 downto 32*5);
OutHash_vector(1) <= OutHash(32*6+31 downto 32*6);
OutHash_vector(0) <= OutHash(32*7+31 downto 32*7);






	
DataEx: process(clk)
variable t,l : integer;
begin					 
	
   if ((clk'event )and (clk = '1')) then 
	   IV(31 downto 0) <= read_data(63 downto 32);
       IV(63 downto 32) <= read_data(31 downto 0);
		--------------   
--	   	if (writeIV='1' and HashPart="00") then
--	   		IV_vector(0) <= read_data(63 downto 32);
--			IV_vector(1) <= read_data(31 downto 0);
--	   	end if;					   							  
--		if (writeIV='1' and HashPart="01") then
--	   		IV_vector(2) <= read_data(63 downto 32);
--			IV_vector(3) <= read_data(31 downto 0);
--	   	end if;					   							  		   
--		if (writeIV='1' and HashPart="10") then
--	   		IV_vector(4) <= read_data(63 downto 32);
--			IV_vector(5) <= read_data(31 downto 0);
--	   	end if;					   							  		   
--		if (writeIV='1' and HashPart="11") then
--	   		IV_vector(6) <= read_data(63 downto 32);
--			IV_vector(7) <= read_data(31 downto 0);
--	   	end if;					   							  		   
		----------				  
		if endWi = '0' then 
   			Wi <= WiReg(63 downto 32);
		else 
			Wi <=  WiReg(31 downto 0);
		end if;
		LoadWiR <= LoadWi;
		----------
	   	if (writeWi='1') then
			WiReg <= read_data;
		end if;
		----------
--
--		temp <= LoadWiR;
--		if WriteMem = '0' then
--		WI_V(0) <= OutWi ;
--		WI_V(1) <= WI_V(0);
--		WI_V(2) <= WI_V(1);
--		WI_V(3) <= WI_V(2);
--		WI_V(4) <= WI_V(3);
--		end if;
--

	 
   end if;
end process DataEx;	
	
	

end CCU;
