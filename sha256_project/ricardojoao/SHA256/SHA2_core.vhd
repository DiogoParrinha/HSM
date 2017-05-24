---------------------------------------------------------------------------------------------------
--
-- Title       : SHA2_core
-- Design      : SHA
-- Author      : admin
-- Company     : CE/EWI/TUDELFT
--
---------------------------------------------------------------------------------------------------
--
-- File        : SHA2_core.vhd
-- Generated   : Tue Dec 13 11:58:22 2005
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

entity SHA2_core is
	 port(
	 	 start  : in STD_LOGIC;		 	 
		 MoreData : in STD_LOGIC;
	 	 Reset  : in STD_LOGIC;
		 clk    : in STD_LOGIC;
		 IV 	: in STD_LOGIC_VECTOR(64-1 downto 0);
 		 WriteIVHashL : in STD_LOGIC;
		 WriteIVHashH : in STD_LOGIC;	
 		 ReadHashH : in STD_LOGIC;
		 LoadWi : in STD_LOGIC;
		 Wi 	: in STD_LOGIC_VECTOR(31 downto 0);
		 finish : out STD_LOGIC;
		 OutHash: out STD_LOGIC_VECTOR(256-1 downto 0)
	     );
end SHA2_core;


architecture SHA2_core of SHA2_core is	 

signal OutWi: STD_LOGIC_VECTOR(31 downto 0);

begin


	
SHA2P : sha2
	port map(
		clk    => clk,
		GReset => Reset,
		start  => start, 
		MoreData =>MoreData,
		IV     => IV,
		WriteIVHashL => WriteIVHashL,
		WriteIVHashH => WriteIVHashH,
		ReadHashH => ReadHashH,
		Wj     => OutWi,
		finish => finish,
		OutHash=> OutHash
	);

	
Label1 : wordgen
	port map(
		clk    => clk,
--		reset  => reset,
		first16=> LoadWi,
		InWi   => Wi,
		OutWi  => OutWi
	);
	
	
	
	
	
end SHA2_core;
