---------------------------------------------------------------------------------------------------
--
-- Title       : ControlUnit
-- Design      : SHA
-- Author      : admin
-- Company     : CE/EWI/TUDELFT
--
---------------------------------------------------------------------------------------------------
--
-- File        : ControlUnit.vhd
-- Generated   : Wed Dec 14 13:12:01 2005
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
use IEEE.numeric_std.all;	   

entity ControlUnit is
	 port(
		clk     : in STD_LOGIC;
		Start   : in STD_LOGIC;
		finish  : in STD_LOGIC;
		Reset   : in STD_LOGIC;
		XRegData: in std_logic_vector(31 downto 0);
		CoreReset: out STD_LOGIC;
		writeWi	: out STD_LOGIC;
		endWi	: out STD_LOGIC;
		HashPart:out std_logic_vector(1 downto 0);		
		WriteIV : out STD_LOGIC; 
		LoadWi  : out STD_LOGIC;
		StartCore: out STD_LOGIC;
		MoreData : out STD_LOGIC;
		stop    : out STD_LOGIC;
		WriteMem: out STD_LOGIC;
		MemAdd  : out std_logic_vector(31 downto 0);
		WriteIVHashL : out std_logic;
		WriteIVHashH : out std_logic;
		ReadHashH  : out std_logic;
		XRegAdd	: out std_logic_vector(9 downto 0)		
		 );
end ControlUnit;


architecture ControlUnit of ControlUnit is

type state_type is (WaitStart, RAddi, RAddf, readIV01, readIV23, readIV45, readIV67, Delay, readWi, readWiM1, MoreBlocks, WaitBlockF, WaitLastBlock, WriteDelay, DelayWrite1, DelayWrite2, WriteHAsh01, WriteHAsh23, WriteHAsh45, WriteHAsh67);--define an enumeration for states 
signal cur_state, next_state: state_type; --Cur_tate is the current state	 
signal WiCont : std_logic_vector(3 downto 0); -- counts from 0 top 7 + CarryOut 
constant XR_DataBegin_Add : STD_LOGIC_Vector := "0000000001";
constant XR_DataFinal_Add : STD_LOGIC_Vector := "0000000010";
constant XR_DataHash_Add  : STD_LOGIC_Vector := "0000000000"; 

signal RAddR, RAddE : std_logic_vector(31 downto 0);
signal MoreDataD, StartCoreD, ResetCont, WiRead16, cont16: std_logic;
signal LoadWiPR, LoadAddressF, ReadMem, LoadAddressI,AddAddress, LastBlock, ReadXReg : std_logic;		 	

  
begin
	
MemAdd <= RAddR;
LoadWi <= LoadWiPR; 

RegV : process (clk) 
begin
	if CLK'event and CLK='1' then	
		StartCore <= StartCoreD;
		MoreData <= MoreDataD;
	end if;
end process RegV;

	
-----------------------------------------------------------------------------	
-----------------------------------------------------------------------------
--	         State machine that controls the reading of the data  		   --
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------	

state_logic:process (cur_state, Start, LastBlock, finish, WiRead16)

  begin
   case cur_state is

-- Waits for the Start signal to begin
	when WaitStart =>
	   if Start= '1' then
		next_state <= readIV01;
	   else
		next_state <= WaitStart;
	   end if;				  
	when readIV01 =>   
		next_state <= readIV23;
	when readIV23 =>   
		next_state <= readIV45;
	when readIV45 =>   
		next_state <= readIV67;
	when readIV67 => 
		next_state <= RAddi;
	when RAddi =>		
		next_state <= RAddf;
	when RAddf =>	   
		next_state <= Delay;
	when Delay =>	   
		next_state <= readWi;
	when readWi =>		
		next_state <= readWiM1; 
	when readWiM1 =>
	   if WiRead16 = '1' then
		next_state <= MoreBlocks;
	   else
		next_state <= readWi;
	   end if;
	when MoreBlocks => 
	   if LastBlock = '1' then
		next_state <= WaitLastBlock;
	   else		
		next_state <= WaitBlockF;
	   end if;	  	
	when WaitBlockF =>  
	   if finish = '1' then
		next_state <= readWi;
	   else		
		next_state <= WaitBlockF;
	   end if;	  	   
	when WaitLastBlock =>
	   if finish = '1' then
		next_state <= WriteDelay;
	   else		
		next_state <= WaitLastBlock;
	   end if;			  
	when WriteDelay =>
		next_state <= DelayWrite1;
	when DelayWrite1 =>
		next_state <= DelayWrite2;
	when DelayWrite2 =>
		next_state <= WriteHAsh01;
	when WriteHAsh01 =>
		next_state <= WriteHAsh23;
	when WriteHAsh23 =>
		next_state <= WriteHAsh45;
	when WriteHAsh45 =>
		next_state <= WriteHAsh67;
	when WriteHAsh67 => 
		next_state <= WaitStart;	
	
   end case;
end process state_logic;	



-----------------------------------------------------------------------------	
-----------------------------------------------------------------------------
--	 		        State machine's signal generation   				   --
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------  

OUTPUT_LOGIC: process (cur_state, LastBlock, finish )
 begin					   
   ResetCont<= '0';
   cont16  	<= '0';	
   CoreReset <= '0';	
   XRegAdd 	<= XR_DataHash_Add;
   loadWiPR  	<= '0'; 
   ReadMem  <= '0';
   ReadXReg	<= '0';
   LoadAddressI <= '0';	
   AddAddress	<= '0';
   LoadAddressF <= '0';
   HashPart  <= "00";
   WriteIV   <= '0';
   WriteWi   <= '0'; 
   endWi	 <= '-'; 
   stop 	 <= '0';
   writeMem  <= '0';
   StartCoreD <= '0';

   MoreDataD  <= '0';

   WriteIVHashL <= '0';	
   WriteIVHashH <= '0';	
   ReadHashH <= '0';
   
  case cur_state is	 	
	when WaitStart =>
		CoreReset <= '1';	
		ResetCont    <= '1';
		XRegAdd 	 <= XR_DataHash_Add;	-- Hash and IV Data begin Address (160 bits in memory) in XReg
		ReadXReg 	 <= '1';			   	
	when readIV01 =>   
		LoadAddressI <= '1';		-- Loads address of IV0 and IV1
		XRegAdd 	 <= XR_DataHash_Add;	 			   	
	when readIV23 =>   
		AddAddress <= '1';			-- Adds address for IV2 and IV3 addressing
		XRegAdd 	 <= XR_DataHash_Add;	 	
		ReadMem    <= '1';			-- Reads from Mem IV0 and IV1
	when readIV45 =>   
		AddAddress <= '1';			-- Adds address for IV2 and IV3 addressing
		XRegAdd 	 <= XR_DataHash_Add;	 	
		ReadMem    <= '1';			-- Reads from Mem IV0 and IV1		
	when readIV67 =>    
		XRegAdd 	<=  XR_DataBegin_Add;-- Data Begin Address in XReg 
		ReadXReg 	<= '1';
		ReadMem 	<= '1';			-- Reads from Mem IV2 and IV3 
		HashPart	<= "00";
		WriteIV  	<= '1';			-- Writes to Int. Reg. the IV0 and IV1 read from memory
		AddAddress 	<= '1';			-- Adds address for IV4 addressing
		WriteIVHashL <= '1';	
	when RAddi =>		
		LoadAddressI <= '1';			-- Loads address of the 1st data of the 1st block W0(0)
		XRegAdd 	<= XR_DataFinal_Add;-- Data Final Address in XReg (data in memory in block of 512 bits)
		ReadXReg 	<= '1';
		HashPart	<= "01";
		WriteIV 	<= '1';			-- Writes to Int. Reg. the IV2 and IV3 read from memory
		ReadMem 	<= '1'; 		-- Reads from Mem IV4
		WriteIVHashH <= '1';	
	when RAddf =>	   
		LoadAddressF <= '1';		-- Loads address of the last data form the last block	
		AddAddress   <= '1';		-- Adds memory pointer to point to the next data wi+2
		ReadMem      <= '1';		-- Reads Wi and Wi+1 from Mem 
		HashPart	<= "10";
		WriteIV 	 <= '1';		-- Writes to Int. Reg. the IV4 read from memory
	    WriteIVHashH <= '1';	
	when Delay =>
		WriteWi <= '1';	   			-- writes the Wi and Wi+1 values to Int. Reg.
		StartCoreD <= '1';
	    WriteIVHashH <= '1';	
   		MoreDataD  <= '1';
-------- begining loop ------------
	when readWi =>			
		ReadMem <= not LastBlock;	-- Reads Wi+2 and Wi+3 execp if already read the last block
		loadWiPR  <= '1';				-- Tells the SHA-1 core to load one of the 16x32 block
		endWi   <= '0';				-- selects Wi (not Wi+1)
		cont16  <= '1';				-- conts the number of (Wi, Wi+1) sent to the SHA-1 core
		MoreDataD  <= '1';
	when readWiM1 =>
		loadWiPR  <= '1';				-- Tells the SHA-1 core to load one of the 16x32 block
		endWi   <= '1';				-- selects Wi+1 (not Wi)
		WriteWi <= '1';				-- writes the Wi and Wi+1 values to Int. Reg.		 
		AddAddress <= '1';			-- Adds memory pointer to point to the next two data words wi+2
		MoreDataD  <= '1';
	when MoreBlocks => 
		ReadMem <= finish;			-- Reads Wi and Wi+1 from data when the previous one is concluded  		
		MoreDataD  <= '1';
	when WaitBlockF => 
		ReadMem 	<= finish;		-- Reads Wi and Wi+1 in a new block exists
		ResetCont 	<= '1';			-- Resets the counter 
		MoreDataD  <= '1';
	when WaitLastBlock => 			-- The State machine (must) stays in this state for at least 2 cicles
		XRegAdd 	 <= XR_DataHash_Add;-- Hash and IV Data begin Address (160 bits in memory)		 
		ReadXReg 	 <= '1';
		LoadAddressI <= '1';		-- Loads the Hash Memory address from the XReg to save the result			   	 
		MoreDataD  <= '1';
	when WriteDelay =>
		MoreDataD  <= '1'; 
	when DelayWrite1 =>
		MoreDataD  <= '1'; 
	when DelayWrite2 =>
		MoreDataD  <= '1'; 
	when WriteHAsh01 =>
		AddAddress	<= '1';
		HashPart	<= "00";
		writeMem 	<= '1';			-- Writes IV01 to memory
	when WriteHAsh23 =>
		AddAddress	<= '1';			-- Writes IV23 to memory
		HashPart	<= "01";
		writeMem 	<= '1';									
	when WriteHAsh45 =>
		AddAddress	<= '1';			-- Writes IV23 to memory
		HashPart	<= "10";
		writeMem 	<= '1';
	when WriteHAsh67 => 
		HashPart	<= "11";
		writeMem 	<= '1';			-- Writes IV4 to memory
		stop 		<= '1';
	
  end case;          	  
 
end process OUTPUT_LOGIC;			
  
----------------------------------------------------------------
----------------------------------------------------------------
--    State shifter acording to the determined next state	  --
----------------------------------------------------------------
----------------------------------------------------------------
 
state_register:process (clk, reset)
  begin
   if reset = '1' then					-- When reset goes high, goto s0
	 cur_state <= WaitStart;
   elsif CLK'event and CLK='1' then		-- On a rising edge, store new state
	 cur_state <= next_state;
   end if;
end process state_register;

-------------------------------------------------------
-------------------------------------------------------
--		 				Counters 					 --
-------------------------------------------------------
-------------------------------------------------------  

Counter16 : process (clk)  			--		j counter
begin
	if CLK'event and CLK='1' then	
		if ResetCont = '1' then
			WiCont <= (others => '0');	-- resets WiCont counter
		elsif cont16 = '1'then
			WiCont <= std_logic_vector( unsigned (WiCont) + 1 ); -- inc WiCont
		end if;			
	end if;
end process Counter16;

WiRead16 <= WiCont(3); 


-------------------------------------------------------
-------------------------------------------------------
--			Address Counter and comparator			 --
-------------------------------------------------------
-------------------------------------------------------  


ReadAddrR : process (clk)		--	Read Address counter
begin
	if CLK'event and CLK='1' then	
		if LoadAddressI = '1' then		
			 RAddR <= XRegData; 	-- Loads the counter with the value from XReg
		elsif AddAddress = '1' then
			 RAddR <= std_logic_vector( unsigned (RAddR) + (64/8) ); -- inc Address by 64/8 byte positions
		end if;
		
		if LoadAddressF = '1' then		
			RAddE <= XRegData; 	-- Loads the counter with the value from XReg
		end if;
	end if;	
end process ReadAddrR;

LastBlock <= '0' when RAddR <= RAddE else '1';

	
end ControlUnit;
