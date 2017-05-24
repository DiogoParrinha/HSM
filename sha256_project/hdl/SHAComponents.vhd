library IEEE;
use IEEE.std_logic_1164.all;


package SHAComponents is
	

component sub5_8
	port (
	A: IN std_logic_VECTOR(2 downto 0);
	S: OUT std_logic_VECTOR(2 downto 0));
end component;

component sub2_16
	port (
	A: IN std_logic_VECTOR(3 downto 0);
	S: OUT std_logic_VECTOR(3 downto 0));
end component;

component mem32_8
	port (
	addra: IN std_logic_VECTOR(2 downto 0);
	addrb: IN std_logic_VECTOR(2 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(31 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	wea: IN std_logic);
end component;

component mem32_16
	port (
	addra: IN std_logic_VECTOR(3 downto 0);
	addrb: IN std_logic_VECTOR(3 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(31 downto 0);
	douta: OUT std_logic_VECTOR(31 downto 0);
	doutb: OUT std_logic_VECTOR(31 downto 0);
	wea: IN std_logic);
end component;

component cont3
	port(
		Q : out std_logic_vector(1 downto 0);
		CE : in std_logic;
		CLK : in std_logic;
		Q_THRESH0 : out std_logic;
		SCLR : in std_logic);
end component;

component cont16
	port (
	Q: OUT std_logic_VECTOR(3 downto 0);
	CLK: IN std_logic;
	SCLR: IN std_logic);
end component;

component cont19
	port(
		Q : out std_logic_vector(4 downto 0);
		CE : in std_logic;
		CLK : in std_logic;
		Q_THRESH0 : out std_logic;
		SCLR : in std_logic);
end component;		

component cont64Inc 
	 port(
		 reset : in STD_LOGIC;
		 clk : in STD_LOGIC;
		 inc : in STD_LOGIC;
		 last : out STD_LOGIC;
		 last3: out STD_LOGIC;
		 Q : out STD_LOGIC_VECTOR(5 downto 0)
	     );
end	component;


component add32
	port(
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		S : out std_logic_vector(31 downto 0));
end component;


component add32reg
	port(
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		Q : out std_logic_vector(31 downto 0);
		CE : in std_logic;
		CLK : in std_logic);
end component;

component mux32_2reg
	port(
		MA : in std_logic_vector(31 downto 0);
		MB : in std_logic_vector(31 downto 0);
		Q : out std_logic_vector(31 downto 0);
		S : in std_logic_vector(0 to 0);
		CLK : in std_logic;
		SCLR : in std_logic);
end component;

component mux32_2
	port(
		MA : in std_logic_vector(31 downto 0);
		MB : in std_logic_vector(31 downto 0);
		O : out std_logic_vector(31 downto 0);
		S : in std_logic_vector(0 to 0));
end component;

component mux32_2regv
	port(
		MA : in std_logic_vector(31 downto 0);
		MB : in std_logic_vector(31 downto 0);
		S : in std_logic_vector(0 downto 0);
		Q : out std_logic_vector(31 downto 0);
		CLK : in std_logic;
		SCLR : in std_logic);
end component;

component mux32_3regv
	port(
		MA : in std_logic_vector(31 downto 0);
		MB : in std_logic_vector(31 downto 0);
		MC : in std_logic_vector(31 downto 0);
		S  : in std_logic_vector(0 downto 0);
		SD : in std_logic_vector(0 downto 0);
		Q  : out std_logic_vector(31 downto 0);
		CLK : in std_logic;
		SCLR : in std_logic);
end component;

component cont3inc
	port(
		reset : in std_logic;
		clk : in std_logic;
		inc : in std_logic;
		last : out std_logic;
		Q : out std_logic_vector(1 downto 0));
end component;

component cont19inc
	port(
		reset : in std_logic;
		clk : in std_logic;
		inc : in std_logic;
		last : out std_logic;
		Q : out std_logic_vector(4 downto 0));
end component;

component add32v
	port(
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		S : out std_logic_vector(31 downto 0));
end component;

component Add32_3
	 port(
		 A : in STD_LOGIC_VECTOR(31 downto 0);
		 B : in STD_LOGIC_VECTOR(31 downto 0);
		 C : in STD_LOGIC_VECTOR(31 downto 0);
		 Res : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end component;

component mux32_2v
	port(
		MA : in std_logic_vector(31 downto 0);
		MB : in std_logic_vector(31 downto 0);
		S : in std_logic_vector(0 downto 0);
		O : out std_logic_vector(31 downto 0));
end component;

component romkt
	port (
	addr: IN std_logic_VECTOR(5 downto 0);
	clk: IN std_logic;
	dout: OUT std_logic_VECTOR(31 downto 0));
END component;

component romkt2
	port (
	addra: IN std_logic_VECTOR(5 downto 0);
	clka: IN std_logic;
	douta: OUT std_logic_VECTOR(31 downto 0));
END component;

component SHA1Func
	port(									  
		 sel : in STD_LOGIC_VECTOR(1 downto 0);
		 x : in STD_LOGIC_VECTOR(31 downto 0);
		 y : in STD_LOGIC_VECTOR(31 downto 0);
		 z : in STD_LOGIC_VECTOR(31 downto 0);
		 f : out STD_LOGIC_VECTOR(31 downto 0)
	     );
end component;

component wordGen
    Port ( 
		clk : in std_logic;
--		reset : in std_logic;
        first16 : in std_logic;
        InWi : in std_logic_vector(31 downto 0);
        OutWi : out std_logic_vector(31 downto 0)
	);
end component;

component csa4add
	port(
		I1 : in std_logic_vector(31 downto 0);
		I2 : in std_logic_vector(31 downto 0);
		I3 : in std_logic_vector(31 downto 0);
		I4 : in std_logic_vector(31 downto 0);
		Save : out std_logic_vector(31 downto 0);
		Carry : out std_logic_vector(31 downto 0));
end component;

component csa5add
	port(
		I1 : in std_logic_vector(31 downto 0);
		I2 : in std_logic_vector(31 downto 0);
		I3 : in std_logic_vector(31 downto 0);
		I4 : in std_logic_vector(31 downto 0);
		I5 : in std_logic_vector(31 downto 0);
		Save : out std_logic_vector(31 downto 0);
		Carry : out std_logic_vector(31 downto 0));
end component;

component csa6addS
	port(
		I1 : in std_logic_vector(31 downto 0);
		I2 : in std_logic_vector(31 downto 0);
		I3 : in std_logic_vector(31 downto 0);
		I4 : in std_logic_vector(31 downto 0);
		I5 : in std_logic_vector(31 downto 0);
		I6 : in std_logic_vector(31 downto 0);		
		Save : out std_logic_vector(31 downto 0);
		Carry : out std_logic_vector(31 downto 0));
end component;

component sha1
	port(
		start : in std_logic;
		GReset : in std_logic;
		clk : in std_logic;
		IV : in std_logic_vector((160-1) downto 0);
		WriteIVHash : in STD_LOGIC;
		Wi : in std_logic_vector(31 downto 0);
		finish : out std_logic;
		OutHash : out std_logic_vector((160-1) downto 0));
end component;	


component SHA2
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
end	component;

component sha1_core
	port(
		start : in std_logic;
		Reset : in std_logic;
		clk : in std_logic;
		IV : in std_logic_vector((160-1) downto 0);
		WriteIVHash : in STD_LOGIC;
		LoadWi : in std_logic;
		Wi : in std_logic_vector(31 downto 0);
		finish : out std_logic;
		OutHash : out std_logic_vector((160-1) downto 0));
end component;

component SHA2_core
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
end	component;	 

component controlunit
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
end component;


	
end SHAComponents;		





package body SHAComponents is
							 					  	
end SHAComponents;		
	