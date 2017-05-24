---------------------------------------------------------------------------------------------------
--
-- Title       : CSA4Add
-- Design      : SHA
-- Author      : admin
-- Company     : CE/EWI/TUDELFT
--
---------------------------------------------------------------------------------------------------
--
-- File        : CSA4Add.vhd
-- Generated   : Thu Dec  8 11:54:46 2005
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

entity CSA4Add is
	 port(
	 	I1 : in STD_LOGIC_VECTOR(31 downto 0);
	 	I2 : in STD_LOGIC_VECTOR(31 downto 0);
	 	I3 : in STD_LOGIC_VECTOR(31 downto 0);
	 	I4 : in STD_LOGIC_VECTOR(31 downto 0);
		Save : out STD_LOGIC_VECTOR(31 downto 0);
		Carry : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end CSA4Add;

architecture CSA4Add of CSA4Add is

signal S0, S1: STD_LOGIC_VECTOR (32-1 downto 0);
signal C0, C1: STD_LOGIC_VECTOR (32 downto 0);

begin					
			  	
-- CSA module 2^n
 b1:	block
 signal z,y,x :STD_LOGIC_VECTOR (32-1 downto 0);
 begin

	z <= I1;
	y <= I2;
	x <= I3;

	S0 <= z xor y xor x;
	C0(32 downto 1) <= (z and y)or(z and x)or(x and y);
	C0(0) <= '0';
 end block b1;	
	
-- CSA module 2^n
 b2:	block
 signal z,y,x :STD_LOGIC_VECTOR (32-1 downto 0);
 begin

	z <= S0;
	y <= C0(31 downto 0);
	x <= I4;

	S1 <= z xor y xor x;
	C1(32 downto 1) <= (z and y)or(z and x)or(x and y);
	C1(0) <= '0';
 end block b2;	

 Save  <=S1;
 Carry <= C1(31 downto 0);

end CSA4Add;
