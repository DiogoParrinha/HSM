-- Version: v11.7 SP1 11.7.1.14

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity reg_2x32 is

    port( AHB_slave_dummy_0_mem_wdata             : in    std_logic_vector(31 downto 0);
          reg_2x32_0_data_out                     : out   std_logic_vector(31 downto 0);
          lsram_raddr_net_0                       : in    std_logic_vector(0 to 0);
          lsram_waddr_net_0                       : in    std_logic_vector(0 to 0);
          sha256_system_sb_0_FIC_0_CLK            : in    std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N_i_0 : in    std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N     : in    std_logic;
          AHB_slave_dummy_0_write_en              : in    std_logic;
          AHB_slave_dummy_0_read_en               : in    std_logic
        );

end reg_2x32;

architecture DEF_ARCH of reg_2x32 is 

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \data_out_70\, N_571_i, \temp[63]_net_1\, VCC_net_1, 
        \temp_0_RNIEA7C\, GND_net_1, \temp[62]_net_1\, 
        \temp[61]_net_1\, \temp[60]_net_1\, \temp[59]_net_1\, 
        \temp[58]_net_1\, \temp[57]_net_1\, \temp[56]_net_1\, 
        \temp[55]_net_1\, \temp[54]_net_1\, \temp[53]_net_1\, 
        \temp[52]_net_1\, \temp[51]_net_1\, \temp[50]_net_1\, 
        \temp[49]_net_1\, \temp[48]_net_1\, \temp[47]_net_1\, 
        \temp[46]_net_1\, \temp[45]_net_1\, \temp[44]_net_1\, 
        \temp[43]_net_1\, \temp[42]_net_1\, \temp[41]_net_1\, 
        \temp[40]_net_1\, \temp[39]_net_1\, \temp[38]_net_1\, 
        \temp[37]_net_1\, \temp[36]_net_1\, \temp[35]_net_1\, 
        \temp[34]_net_1\, \temp[33]_net_1\, \temp[32]_net_1\, 
        \temp_0\, \temp[31]_net_1\, \temp_0_27_RNIMAEH\, 
        \temp[30]_net_1\, \temp[29]_net_1\, \temp[28]_net_1\, 
        \temp[27]_net_1\, \temp[26]_net_1\, \temp[25]_net_1\, 
        \temp[24]_net_1\, \temp[23]_net_1\, \temp[22]_net_1\, 
        \temp[21]_net_1\, \temp[20]_net_1\, \temp[19]_net_1\, 
        \temp[18]_net_1\, \temp[17]_net_1\, \temp[16]_net_1\, 
        \temp[15]_net_1\, \temp[14]_net_1\, \temp[13]_net_1\, 
        \temp[12]_net_1\, \temp[11]_net_1\, \temp[10]_net_1\, 
        \temp[9]_net_1\, \temp[8]_net_1\, \temp[7]_net_1\, 
        \temp[6]_net_1\, \temp[5]_net_1\, \temp[4]_net_1\, 
        \temp[3]_net_1\, \temp[2]_net_1\, \temp[1]_net_1\, 
        \temp[0]_net_1\, temp_0_62, N_156, \data_out_or[1]_net_1\, 
        N_157, N_158, N_159, N_160, N_161, N_162, N_163, N_164, 
        N_165, N_166, N_167, N_168, N_169, N_170, N_141, N_142, 
        N_143, N_144, N_145, N_146, N_147, N_148, N_149, N_150, 
        N_151, N_152, N_153, N_154, N_155, N_139, N_140, 
        wen_or_i_0 : std_logic;

begin 


    \data_out_6_0[2]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[34]_net_1\, B => \temp[2]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_141);
    
    \data_out_6_0[7]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[39]_net_1\, B => \temp[7]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_146);
    
    \temp[44]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(12), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[44]_net_1\);
    
    \data_out_6_0[12]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[44]_net_1\, B => \temp[12]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_151);
    
    \data_out_6_0[26]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[58]_net_1\, B => \temp[26]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_165);
    
    \temp[23]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(23), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[23]_net_1\);
    
    \data_out_6_0[24]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[56]_net_1\, B => \temp[24]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_163);
    
    \data_out_6_0[29]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[61]_net_1\, B => \temp[29]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_168);
    
    \data_out[26]\ : SLE
      port map(D => N_165, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(26));
    
    \data_out[8]\ : SLE
      port map(D => N_147, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(8));
    
    temp_0_27 : CFG3
      generic map(INIT => x"32")

      port map(A => sha256_system_sb_0_POWER_ON_RESET_N, B => 
        lsram_waddr_net_0(0), C => AHB_slave_dummy_0_write_en, Y
         => temp_0_62);
    
    \data_out[31]\ : SLE
      port map(D => N_170, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(31));
    
    \temp[8]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(8), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[8]_net_1\);
    
    \temp[18]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(18), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[18]_net_1\);
    
    \data_out[12]\ : SLE
      port map(D => N_151, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(12));
    
    \temp[43]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(11), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[43]_net_1\);
    
    \temp[34]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(2), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[34]_net_1\);
    
    \temp[58]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(26), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[58]_net_1\);
    
    \data_out[5]\ : SLE
      port map(D => N_144, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(5));
    
    \data_out_6_0[21]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[53]_net_1\, B => \temp[21]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_160);
    
    \temp[19]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(19), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[19]_net_1\);
    
    \data_out_6_0[8]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[40]_net_1\, B => \temp[8]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_147);
    
    \temp[63]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(31), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[63]_net_1\);
    
    \temp[11]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(11), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[11]_net_1\);
    
    \data_out_6_0[13]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[45]_net_1\, B => \temp[13]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_152);
    
    \data_out[1]\ : SLE
      port map(D => N_140, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(1));
    
    \temp[59]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(27), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[59]_net_1\);
    
    \data_out[22]\ : SLE
      port map(D => N_161, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(22));
    
    \temp[51]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(19), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[51]_net_1\);
    
    \temp[33]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(1), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[33]_net_1\);
    
    \temp[28]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(28), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[28]_net_1\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \data_out_6_0[1]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[33]_net_1\, B => \temp[1]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_140);
    
    \data_out[10]\ : SLE
      port map(D => N_149, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(10));
    
    \temp[4]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(4), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[4]_net_1\);
    
    \temp[29]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(29), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[29]_net_1\);
    
    \data_out[19]\ : SLE
      port map(D => N_158, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(19));
    
    \temp[15]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(15), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[15]_net_1\);
    
    \temp[48]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(16), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[48]_net_1\);
    
    \temp[21]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(21), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[21]_net_1\);
    
    \temp[55]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(23), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[55]_net_1\);
    
    \data_out[18]\ : SLE
      port map(D => N_157, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(18));
    
    temp_0_RNIEA7C : CFG2
      generic map(INIT => x"E")

      port map(A => \temp_0\, B => 
        sha256_system_sb_0_POWER_ON_RESET_N, Y => 
        \temp_0_RNIEA7C\);
    
    \temp[10]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(10), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[10]_net_1\);
    
    \data_out[20]\ : SLE
      port map(D => N_159, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(20));
    
    \data_out[2]\ : SLE
      port map(D => N_141, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(2));
    
    \temp[49]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(17), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[49]_net_1\);
    
    \data_out[29]\ : SLE
      port map(D => N_168, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(29));
    
    \temp[50]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(18), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[50]_net_1\);
    
    \temp[41]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(9), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[41]_net_1\);
    
    \data_out_6_0[22]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[54]_net_1\, B => \temp[22]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_161);
    
    \data_out[28]\ : SLE
      port map(D => N_167, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(28));
    
    \temp[38]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(6), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[38]_net_1\);
    
    \data_out[14]\ : SLE
      port map(D => N_153, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(14));
    
    \temp[25]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(25), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[25]_net_1\);
    
    \temp[7]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(7), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[7]_net_1\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \temp[61]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(29), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[61]_net_1\);
    
    \temp[12]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(12), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[12]_net_1\);
    
    \temp[39]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(7), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[39]_net_1\);
    
    \temp[20]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(20), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[20]_net_1\);
    
    \data_out_6_0[6]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[38]_net_1\, B => \temp[6]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_145);
    
    \temp[52]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(20), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[52]_net_1\);
    
    \data_out_6_0[10]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[42]_net_1\, B => \temp[10]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_149);
    
    \temp[31]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(31), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[31]_net_1\);
    
    \temp[45]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(13), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[45]_net_1\);
    
    \data_out[24]\ : SLE
      port map(D => N_163, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(24));
    
    \data_out_6_0[3]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[35]_net_1\, B => \temp[3]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_142);
    
    \data_out_6_0[31]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[63]_net_1\, B => \temp[31]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_170);
    
    \data_out[30]\ : SLE
      port map(D => N_169, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(30));
    
    \temp[40]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(8), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[40]_net_1\);
    
    \data_out_6_0[23]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[55]_net_1\, B => \temp[23]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_162);
    
    \data_out_6_0[5]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[37]_net_1\, B => \temp[5]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_144);
    
    \temp[22]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(22), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[22]_net_1\);
    
    \temp[35]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(3), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[35]_net_1\);
    
    \temp[60]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(28), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[60]_net_1\);
    
    \temp[42]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(10), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[42]_net_1\);
    
    \temp[30]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(30), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[30]_net_1\);
    
    \data_out_6_0[18]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[50]_net_1\, B => \temp[18]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_157);
    
    \temp[6]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(6), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[6]_net_1\);
    
    \data_out[15]\ : SLE
      port map(D => N_154, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(15));
    
    \temp[17]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(17), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[17]_net_1\);
    
    \temp[62]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(30), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[62]_net_1\);
    
    \data_out_6_0[17]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[49]_net_1\, B => \temp[17]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_156);
    
    \data_out[3]\ : SLE
      port map(D => N_142, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(3));
    
    \temp[57]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(25), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[57]_net_1\);
    
    \data_out_6_0[15]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[47]_net_1\, B => \temp[15]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_154);
    
    \temp[32]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(0), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[32]_net_1\);
    
    \data_out[7]\ : SLE
      port map(D => N_146, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(7));
    
    wen_or_i : CFG2
      generic map(INIT => x"1")

      port map(A => AHB_slave_dummy_0_write_en, B => 
        sha256_system_sb_0_POWER_ON_RESET_N, Y => wen_or_i_0);
    
    \data_out[17]\ : SLE
      port map(D => N_156, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(17));
    
    \data_out[25]\ : SLE
      port map(D => N_164, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(25));
    
    \data_out[4]\ : SLE
      port map(D => N_143, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(4));
    
    \temp[27]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(27), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[27]_net_1\);
    
    \data_out[9]\ : SLE
      port map(D => N_148, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(9));
    
    \data_out[27]\ : SLE
      port map(D => N_166, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(27));
    
    \temp[0]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(0), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[0]_net_1\);
    
    \data_out_6_0[20]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[52]_net_1\, B => \temp[20]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_159);
    
    \temp[16]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(16), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[16]_net_1\);
    
    \data_out_6_0[9]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[41]_net_1\, B => \temp[9]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_148);
    
    \temp[47]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(15), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[47]_net_1\);
    
    \temp[56]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(24), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[56]_net_1\);
    
    \data_out_6_0[4]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[36]_net_1\, B => \temp[4]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_143);
    
    \data_out_6_0[16]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[48]_net_1\, B => \temp[16]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_155);
    
    temp_0_27_RNIMAEH : CFG2
      generic map(INIT => x"E")

      port map(A => temp_0_62, B => 
        sha256_system_sb_0_POWER_ON_RESET_N, Y => 
        \temp_0_27_RNIMAEH\);
    
    \data_out_6_0[14]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[46]_net_1\, B => \temp[14]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_153);
    
    \data_out_6_0[19]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[51]_net_1\, B => \temp[19]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_158);
    
    \temp[26]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(26), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[26]_net_1\);
    
    \temp[37]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(5), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[37]_net_1\);
    
    \temp[9]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(9), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[9]_net_1\);
    
    \data_out_6_0[11]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[43]_net_1\, B => \temp[11]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_150);
    
    \data_out_6_0[0]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[32]_net_1\, B => \temp[0]_net_1\, C => 
        lsram_raddr_net_0(0), Y => N_139);
    
    \temp[1]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(1), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[1]_net_1\);
    
    \data_out_6_0[28]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[60]_net_1\, B => \temp[28]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_167);
    
    \data_out[11]\ : SLE
      port map(D => N_150, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(11));
    
    \temp[14]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(14), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[14]_net_1\);
    
    \temp[5]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(5), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[5]_net_1\);
    
    \temp[46]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(14), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[46]_net_1\);
    
    \data_out_6_0[27]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[59]_net_1\, B => \temp[27]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_166);
    
    \temp[3]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(3), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[3]_net_1\);
    
    \data_out_or[1]\ : CFG2
      generic map(INIT => x"E")

      port map(A => \data_out_70\, B => wen_or_i_0, Y => 
        \data_out_or[1]_net_1\);
    
    data_out_70 : CFG3
      generic map(INIT => x"01")

      port map(A => AHB_slave_dummy_0_write_en, B => 
        sha256_system_sb_0_POWER_ON_RESET_N, C => 
        AHB_slave_dummy_0_read_en, Y => \data_out_70\);
    
    \temp[2]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(2), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[2]_net_1\);
    
    \temp[54]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(22), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[54]_net_1\);
    
    \data_out_6_0[25]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[57]_net_1\, B => \temp[25]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_164);
    
    \data_out[13]\ : SLE
      port map(D => N_152, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(13));
    
    N_571_i_0 : CFG1
      generic map(INIT => "01")

      port map(A => \data_out_70\, Y => N_571_i);
    
    \data_out[21]\ : SLE
      port map(D => N_160, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(21));
    
    \temp[13]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(13), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[13]_net_1\);
    
    \temp[36]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(4), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[36]_net_1\);
    
    temp_0 : CFG3
      generic map(INIT => x"C8")

      port map(A => sha256_system_sb_0_POWER_ON_RESET_N, B => 
        lsram_waddr_net_0(0), C => AHB_slave_dummy_0_write_en, Y
         => \temp_0\);
    
    \data_out[0]\ : SLE
      port map(D => N_139, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(0));
    
    \temp[53]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(21), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_RNIEA7C\, ALn
         => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[53]_net_1\);
    
    \temp[24]\ : SLE
      port map(D => AHB_slave_dummy_0_mem_wdata(24), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \temp_0_27_RNIMAEH\, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, SD => GND_net_1, 
        LAT => GND_net_1, Q => \temp[24]_net_1\);
    
    \data_out[23]\ : SLE
      port map(D => N_162, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(23));
    
    \data_out_6_0[30]\ : CFG3
      generic map(INIT => x"AC")

      port map(A => \temp[62]_net_1\, B => \temp[30]_net_1\, C
         => lsram_raddr_net_0(0), Y => N_169);
    
    \data_out[6]\ : SLE
      port map(D => N_145, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(6));
    
    \data_out[16]\ : SLE
      port map(D => N_155, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => \data_out_or[1]_net_1\, ALn => VCC_net_1, ADn => 
        VCC_net_1, SLn => N_571_i, SD => GND_net_1, LAT => 
        GND_net_1, Q => reg_2x32_0_data_out(16));
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity AHB_slave_dummy is

    port( lsram_waddr_net_0                                  : out   std_logic_vector(0 to 0);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR              : in    std_logic_vector(2 to 2);
          lsram_raddr_net_0                                  : out   std_logic_vector(0 to 0);
          masterAddrInProg                                   : in    std_logic_vector(3 downto 1);
          xhdl1222                                           : in    std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP  : in    std_logic_vector(0 to 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : in    std_logic_vector(1 to 1);
          SADDRSEL_2                                         : in    std_logic_vector(9 to 9);
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1);
          arbRegSMCurrentState_3                             : in    std_logic;
          arbRegSMCurrentState_0                             : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY             : out   std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N                : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic;
          AHB_slave_dummy_0_write_en                         : out   std_logic;
          AHB_slave_dummy_0_read_en                          : out   std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE             : in    std_logic;
          N_156                                              : in    std_logic;
          lsram_m7_a0_1_0                                    : out   std_logic;
          N_27_i                                             : in    std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                         : in    std_logic;
          defSlaveSMCurrentState                             : in    std_logic;
          N_128                                              : in    std_logic;
          hsel2_1                                            : in    std_logic;
          regHTRANS                                          : in    std_logic;
          masterRegAddrSel                                   : in    std_logic;
          N_113                                              : in    std_logic;
          hsel2                                              : in    std_logic
        );

end AHB_slave_dummy;

architecture DEF_ARCH of AHB_slave_dummy is 

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \FSM[0]_net_1\, \FSM_i_0[0]\, 
        \sha256_system_sb_0_AMBA_SLAVE_0_HREADY\, GND_net_1, 
        \un1_lsram_raddr_1_sqmuxa\, VCC_net_1, 
        \un1_lsram_waddr_0_sqmuxa_0\, \hwrite_r\, \FSM_ns[0]\, 
        \lsram_waddr_0_sqmuxa\, lsram_raddr_1_sqmuxa, 
        \FSM[1]_net_1\, \FSM_ns[1]\, lsram_m7_a0_1_0_net_1, 
        \hwrite_r_0_sqmuxa_0_a2_2\, un1_m7_1_0, un1_N_14_mux, 
        \hwrite_r_0_sqmuxa_0_a2_4_0\, 
        \hwrite_r_0_sqmuxa_0_a2_2_1\, lsram_m7_a1_0, 
        lsram_m7_a0_0, \lsram_raddr_1_sqmuxa_0_RNO_0\, 
        hwrite_r_0_sqmuxa_0_a2_3 : std_logic;

begin 

    sha256_system_sb_0_AMBA_SLAVE_0_HREADY <= 
        \sha256_system_sb_0_AMBA_SLAVE_0_HREADY\;
    lsram_m7_a0_1_0 <= lsram_m7_a0_1_0_net_1;

    un1_lsram_waddr_0_sqmuxa_0 : CFG4
      generic map(INIT => x"F088")

      port map(A => \FSM[0]_net_1\, B => \hwrite_r\, C => hsel2, 
        D => un1_N_14_mux, Y => \un1_lsram_waddr_0_sqmuxa_0\);
    
    hwrite_r_0_sqmuxa_0_a2_2 : CFG4
      generic map(INIT => x"A088")

      port map(A => \hwrite_r_0_sqmuxa_0_a2_2_1\, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), C
         => regHTRANS, D => masterRegAddrSel, Y => 
        \hwrite_r_0_sqmuxa_0_a2_2\);
    
    hwrite_r : SLE
      port map(D => sha256_system_sb_0_AMBA_SLAVE_0_HWRITE, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => \FSM_ns[0]\, ALn
         => sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \hwrite_r\);
    
    \FSM_RNIR3G7[0]\ : CFG1
      generic map(INIT => "01")

      port map(A => \FSM[0]_net_1\, Y => \FSM_i_0[0]\);
    
    \FSM_ns_0_a2[1]\ : CFG2
      generic map(INIT => x"2")

      port map(A => \FSM[0]_net_1\, B => \hwrite_r\, Y => 
        \FSM_ns[1]\);
    
    \FSM[1]\ : SLE
      port map(D => \FSM_ns[1]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \FSM[1]_net_1\);
    
    \lsram_waddr[0]\ : SLE
      port map(D => sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2), CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        \lsram_waddr_0_sqmuxa\, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => lsram_waddr_net_0(0));
    
    un1_lsram_raddr_1_sqmuxa : CFG2
      generic map(INIT => x"E")

      port map(A => lsram_raddr_1_sqmuxa, B => \FSM_ns[1]\, Y => 
        \un1_lsram_raddr_1_sqmuxa\);
    
    \lsram_m7_a0_1_0\ : CFG4
      generic map(INIT => x"0001")

      port map(A => masterAddrInProg(1), B => masterAddrInProg(2), 
        C => masterAddrInProg(3), D => N_156, Y => 
        lsram_m7_a0_1_0_net_1);
    
    lsram_raddr_1_sqmuxa_0_RNO_1 : CFG3
      generic map(INIT => x"40")

      port map(A => N_27_i, B => lsram_m7_a0_1_0_net_1, C => 
        N_113, Y => lsram_m7_a0_0);
    
    hwrite_r_0_sqmuxa_0_a2_2_1 : CFG3
      generic map(INIT => x"04")

      port map(A => \FSM[0]_net_1\, B => 
        \sha256_system_sb_0_AMBA_SLAVE_0_HREADY\, C => 
        \FSM[1]_net_1\, Y => \hwrite_r_0_sqmuxa_0_a2_2_1\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \lsram_raddr[0]\ : SLE
      port map(D => sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2), CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        lsram_raddr_1_sqmuxa, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => lsram_raddr_net_0(0));
    
    lsram_raddr_1_sqmuxa_0 : CFG4
      generic map(INIT => x"F020")

      port map(A => lsram_m7_a1_0, B => N_27_i, C => 
        hwrite_r_0_sqmuxa_0_a2_3, D => 
        \lsram_raddr_1_sqmuxa_0_RNO_0\, Y => lsram_raddr_1_sqmuxa);
    
    lsram_raddr_1_sqmuxa_0_RNO_0 : CFG3
      generic map(INIT => x"80")

      port map(A => SADDRSEL_2(9), B => lsram_m7_a0_0, C => 
        SADDRSEL_0(1), Y => \lsram_raddr_1_sqmuxa_0_RNO_0\);
    
    lsram_raddr_1_sqmuxa_0_RNO : CFG3
      generic map(INIT => x"E0")

      port map(A => arbRegSMCurrentState_3, B => 
        arbRegSMCurrentState_0, C => hsel2_1, Y => lsram_m7_a1_0);
    
    \FSM[0]\ : SLE
      port map(D => \FSM_ns[0]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \FSM[0]_net_1\);
    
    write_en : SLE
      port map(D => \FSM_i_0[0]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        \un1_lsram_waddr_0_sqmuxa_0\, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => AHB_slave_dummy_0_write_en);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    lsram_waddr_0_sqmuxa : CFG3
      generic map(INIT => x"80")

      port map(A => hsel2, B => N_27_i, C => 
        hwrite_r_0_sqmuxa_0_a2_3, Y => \lsram_waddr_0_sqmuxa\);
    
    hwrite_r_0_sqmuxa_0_a2_4_0 : CFG2
      generic map(INIT => x"2")

      port map(A => \hwrite_r_0_sqmuxa_0_a2_2\, B => N_128, Y => 
        \hwrite_r_0_sqmuxa_0_a2_4_0\);
    
    hwrite_r_0_sqmuxa_0_a2 : CFG2
      generic map(INIT => x"8")

      port map(A => hsel2, B => hwrite_r_0_sqmuxa_0_a2_3, Y => 
        \FSM_ns[0]\);
    
    un1_lsram_waddr_0_sqmuxa_0_RNO : CFG4
      generic map(INIT => x"8880")

      port map(A => \hwrite_r_0_sqmuxa_0_a2_2\, B => N_27_i, C
         => xhdl1222(1), D => un1_m7_1_0, Y => un1_N_14_mux);
    
    read_en : SLE
      port map(D => \FSM_i_0[0]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        \un1_lsram_raddr_1_sqmuxa\, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => AHB_slave_dummy_0_read_en);
    
    ready : SLE
      port map(D => \FSM[0]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        \un1_lsram_raddr_1_sqmuxa\, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => GND_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \sha256_system_sb_0_AMBA_SLAVE_0_HREADY\);
    
    hwrite_r_0_sqmuxa_0_a2_4 : CFG4
      generic map(INIT => x"CCC4")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0), B
         => \hwrite_r_0_sqmuxa_0_a2_4_0\, C => 
        defSlaveSMCurrentState, D => xhdl1222(1), Y => 
        hwrite_r_0_sqmuxa_0_a2_3);
    
    un1_lsram_waddr_0_sqmuxa_0_RNO_0 : CFG4
      generic map(INIT => x"0045")

      port map(A => AMBA_SLAVE_0_HREADY_S1_i_m, B => 
        defSlaveSMCurrentState, C => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0), D
         => N_128, Y => un1_m7_1_0);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_MSS is

    port( sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : out   std_logic_vector(1 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : in    std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : in    std_logic_vector(0 to 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : out   std_logic;
          GPIO_0_OUT                                           : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N      : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : out   std_logic;
          sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F           : out   std_logic;
          HREADY_M_iv_i_0                                      : in    std_logic;
          FIC_0_LOCK                                           : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic
        );

end sha256_system_sb_MSS;

architecture DEF_ARCH of sha256_system_sb_MSS is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component MSS_060

            generic (INIT:std_logic_vector(1437 downto 0) := "00" & x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"; 
        ACT_UBITS:std_logic_vector(55 downto 0) := x"FFFFFFFFFFFFFF"; 
        MEMORYFILE:string := ""; RTC_MAIN_XTL_FREQ:real := 0.0; 
        RTC_MAIN_XTL_MODE:string := "1"; DDR_CLK_FREQ:real := 0.0
        );

    port( CAN_RXBUS_MGPIO3A_H2F_A                 : out   std_logic;
          CAN_RXBUS_MGPIO3A_H2F_B                 : out   std_logic;
          CAN_TX_EBL_MGPIO4A_H2F_A                : out   std_logic;
          CAN_TX_EBL_MGPIO4A_H2F_B                : out   std_logic;
          CAN_TXBUS_MGPIO2A_H2F_A                 : out   std_logic;
          CAN_TXBUS_MGPIO2A_H2F_B                 : out   std_logic;
          CLK_CONFIG_APB                          : out   std_logic;
          COMMS_INT                               : out   std_logic;
          CONFIG_PRESET_N                         : out   std_logic;
          EDAC_ERROR                              : out   std_logic_vector(7 downto 0);
          F_FM0_RDATA                             : out   std_logic_vector(31 downto 0);
          F_FM0_READYOUT                          : out   std_logic;
          F_FM0_RESP                              : out   std_logic;
          F_HM0_ADDR                              : out   std_logic_vector(31 downto 0);
          F_HM0_ENABLE                            : out   std_logic;
          F_HM0_SEL                               : out   std_logic;
          F_HM0_SIZE                              : out   std_logic_vector(1 downto 0);
          F_HM0_TRANS1                            : out   std_logic;
          F_HM0_WDATA                             : out   std_logic_vector(31 downto 0);
          F_HM0_WRITE                             : out   std_logic;
          FAB_CHRGVBUS                            : out   std_logic;
          FAB_DISCHRGVBUS                         : out   std_logic;
          FAB_DMPULLDOWN                          : out   std_logic;
          FAB_DPPULLDOWN                          : out   std_logic;
          FAB_DRVVBUS                             : out   std_logic;
          FAB_IDPULLUP                            : out   std_logic;
          FAB_OPMODE                              : out   std_logic_vector(1 downto 0);
          FAB_SUSPENDM                            : out   std_logic;
          FAB_TERMSEL                             : out   std_logic;
          FAB_TXVALID                             : out   std_logic;
          FAB_VCONTROL                            : out   std_logic_vector(3 downto 0);
          FAB_VCONTROLLOADM                       : out   std_logic;
          FAB_XCVRSEL                             : out   std_logic_vector(1 downto 0);
          FAB_XDATAOUT                            : out   std_logic_vector(7 downto 0);
          FACC_GLMUX_SEL                          : out   std_logic;
          FIC32_0_MASTER                          : out   std_logic_vector(1 downto 0);
          FIC32_1_MASTER                          : out   std_logic_vector(1 downto 0);
          FPGA_RESET_N                            : out   std_logic;
          GTX_CLK                                 : out   std_logic;
          H2F_INTERRUPT                           : out   std_logic_vector(15 downto 0);
          H2F_NMI                                 : out   std_logic;
          H2FCALIB                                : out   std_logic;
          I2C0_SCL_MGPIO31B_H2F_A                 : out   std_logic;
          I2C0_SCL_MGPIO31B_H2F_B                 : out   std_logic;
          I2C0_SDA_MGPIO30B_H2F_A                 : out   std_logic;
          I2C0_SDA_MGPIO30B_H2F_B                 : out   std_logic;
          I2C1_SCL_MGPIO1A_H2F_A                  : out   std_logic;
          I2C1_SCL_MGPIO1A_H2F_B                  : out   std_logic;
          I2C1_SDA_MGPIO0A_H2F_A                  : out   std_logic;
          I2C1_SDA_MGPIO0A_H2F_B                  : out   std_logic;
          MDCF                                    : out   std_logic;
          MDOENF                                  : out   std_logic;
          MDOF                                    : out   std_logic;
          MMUART0_CTS_MGPIO19B_H2F_A              : out   std_logic;
          MMUART0_CTS_MGPIO19B_H2F_B              : out   std_logic;
          MMUART0_DCD_MGPIO22B_H2F_A              : out   std_logic;
          MMUART0_DCD_MGPIO22B_H2F_B              : out   std_logic;
          MMUART0_DSR_MGPIO20B_H2F_A              : out   std_logic;
          MMUART0_DSR_MGPIO20B_H2F_B              : out   std_logic;
          MMUART0_DTR_MGPIO18B_H2F_A              : out   std_logic;
          MMUART0_DTR_MGPIO18B_H2F_B              : out   std_logic;
          MMUART0_RI_MGPIO21B_H2F_A               : out   std_logic;
          MMUART0_RI_MGPIO21B_H2F_B               : out   std_logic;
          MMUART0_RTS_MGPIO17B_H2F_A              : out   std_logic;
          MMUART0_RTS_MGPIO17B_H2F_B              : out   std_logic;
          MMUART0_RXD_MGPIO28B_H2F_A              : out   std_logic;
          MMUART0_RXD_MGPIO28B_H2F_B              : out   std_logic;
          MMUART0_SCK_MGPIO29B_H2F_A              : out   std_logic;
          MMUART0_SCK_MGPIO29B_H2F_B              : out   std_logic;
          MMUART0_TXD_MGPIO27B_H2F_A              : out   std_logic;
          MMUART0_TXD_MGPIO27B_H2F_B              : out   std_logic;
          MMUART1_DTR_MGPIO12B_H2F_A              : out   std_logic;
          MMUART1_RTS_MGPIO11B_H2F_A              : out   std_logic;
          MMUART1_RTS_MGPIO11B_H2F_B              : out   std_logic;
          MMUART1_RXD_MGPIO26B_H2F_A              : out   std_logic;
          MMUART1_RXD_MGPIO26B_H2F_B              : out   std_logic;
          MMUART1_SCK_MGPIO25B_H2F_A              : out   std_logic;
          MMUART1_SCK_MGPIO25B_H2F_B              : out   std_logic;
          MMUART1_TXD_MGPIO24B_H2F_A              : out   std_logic;
          MMUART1_TXD_MGPIO24B_H2F_B              : out   std_logic;
          MPLL_LOCK                               : out   std_logic;
          PER2_FABRIC_PADDR                       : out   std_logic_vector(15 downto 2);
          PER2_FABRIC_PENABLE                     : out   std_logic;
          PER2_FABRIC_PSEL                        : out   std_logic;
          PER2_FABRIC_PWDATA                      : out   std_logic_vector(31 downto 0);
          PER2_FABRIC_PWRITE                      : out   std_logic;
          RTC_MATCH                               : out   std_logic;
          SLEEPDEEP                               : out   std_logic;
          SLEEPHOLDACK                            : out   std_logic;
          SLEEPING                                : out   std_logic;
          SMBALERT_NO0                            : out   std_logic;
          SMBALERT_NO1                            : out   std_logic;
          SMBSUS_NO0                              : out   std_logic;
          SMBSUS_NO1                              : out   std_logic;
          SPI0_CLK_OUT                            : out   std_logic;
          SPI0_SDI_MGPIO5A_H2F_A                  : out   std_logic;
          SPI0_SDI_MGPIO5A_H2F_B                  : out   std_logic;
          SPI0_SDO_MGPIO6A_H2F_A                  : out   std_logic;
          SPI0_SDO_MGPIO6A_H2F_B                  : out   std_logic;
          SPI0_SS0_MGPIO7A_H2F_A                  : out   std_logic;
          SPI0_SS0_MGPIO7A_H2F_B                  : out   std_logic;
          SPI0_SS1_MGPIO8A_H2F_A                  : out   std_logic;
          SPI0_SS1_MGPIO8A_H2F_B                  : out   std_logic;
          SPI0_SS2_MGPIO9A_H2F_A                  : out   std_logic;
          SPI0_SS2_MGPIO9A_H2F_B                  : out   std_logic;
          SPI0_SS3_MGPIO10A_H2F_A                 : out   std_logic;
          SPI0_SS3_MGPIO10A_H2F_B                 : out   std_logic;
          SPI0_SS4_MGPIO19A_H2F_A                 : out   std_logic;
          SPI0_SS5_MGPIO20A_H2F_A                 : out   std_logic;
          SPI0_SS6_MGPIO21A_H2F_A                 : out   std_logic;
          SPI0_SS7_MGPIO22A_H2F_A                 : out   std_logic;
          SPI1_CLK_OUT                            : out   std_logic;
          SPI1_SDI_MGPIO11A_H2F_A                 : out   std_logic;
          SPI1_SDI_MGPIO11A_H2F_B                 : out   std_logic;
          SPI1_SDO_MGPIO12A_H2F_A                 : out   std_logic;
          SPI1_SDO_MGPIO12A_H2F_B                 : out   std_logic;
          SPI1_SS0_MGPIO13A_H2F_A                 : out   std_logic;
          SPI1_SS0_MGPIO13A_H2F_B                 : out   std_logic;
          SPI1_SS1_MGPIO14A_H2F_A                 : out   std_logic;
          SPI1_SS1_MGPIO14A_H2F_B                 : out   std_logic;
          SPI1_SS2_MGPIO15A_H2F_A                 : out   std_logic;
          SPI1_SS2_MGPIO15A_H2F_B                 : out   std_logic;
          SPI1_SS3_MGPIO16A_H2F_A                 : out   std_logic;
          SPI1_SS3_MGPIO16A_H2F_B                 : out   std_logic;
          SPI1_SS4_MGPIO17A_H2F_A                 : out   std_logic;
          SPI1_SS5_MGPIO18A_H2F_A                 : out   std_logic;
          SPI1_SS6_MGPIO23A_H2F_A                 : out   std_logic;
          SPI1_SS7_MGPIO24A_H2F_A                 : out   std_logic;
          TCGF                                    : out   std_logic_vector(9 downto 0);
          TRACECLK                                : out   std_logic;
          TRACEDATA                               : out   std_logic_vector(3 downto 0);
          TX_CLK                                  : out   std_logic;
          TX_ENF                                  : out   std_logic;
          TX_ERRF                                 : out   std_logic;
          TXCTL_EN_RIF                            : out   std_logic;
          TXD_RIF                                 : out   std_logic_vector(3 downto 0);
          TXDF                                    : out   std_logic_vector(7 downto 0);
          TXEV                                    : out   std_logic;
          WDOGTIMEOUT                             : out   std_logic;
          F_ARREADY_HREADYOUT1                    : out   std_logic;
          F_AWREADY_HREADYOUT0                    : out   std_logic;
          F_BID                                   : out   std_logic_vector(3 downto 0);
          F_BRESP_HRESP0                          : out   std_logic_vector(1 downto 0);
          F_BVALID                                : out   std_logic;
          F_RDATA_HRDATA01                        : out   std_logic_vector(63 downto 0);
          F_RID                                   : out   std_logic_vector(3 downto 0);
          F_RLAST                                 : out   std_logic;
          F_RRESP_HRESP1                          : out   std_logic_vector(1 downto 0);
          F_RVALID                                : out   std_logic;
          F_WREADY                                : out   std_logic;
          MDDR_FABRIC_PRDATA                      : out   std_logic_vector(15 downto 0);
          MDDR_FABRIC_PREADY                      : out   std_logic;
          MDDR_FABRIC_PSLVERR                     : out   std_logic;
          CAN_RXBUS_F2H_SCP                       : in    std_logic := 'U';
          CAN_TX_EBL_F2H_SCP                      : in    std_logic := 'U';
          CAN_TXBUS_F2H_SCP                       : in    std_logic := 'U';
          COLF                                    : in    std_logic := 'U';
          CRSF                                    : in    std_logic := 'U';
          F2_DMAREADY                             : in    std_logic_vector(1 downto 0) := (others => 'U');
          F2H_INTERRUPT                           : in    std_logic_vector(15 downto 0) := (others => 'U');
          F2HCALIB                                : in    std_logic := 'U';
          F_DMAREADY                              : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_FM0_ADDR                              : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_FM0_ENABLE                            : in    std_logic := 'U';
          F_FM0_MASTLOCK                          : in    std_logic := 'U';
          F_FM0_READY                             : in    std_logic := 'U';
          F_FM0_SEL                               : in    std_logic := 'U';
          F_FM0_SIZE                              : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_FM0_TRANS1                            : in    std_logic := 'U';
          F_FM0_WDATA                             : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_FM0_WRITE                             : in    std_logic := 'U';
          F_HM0_RDATA                             : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_HM0_READY                             : in    std_logic := 'U';
          F_HM0_RESP                              : in    std_logic := 'U';
          FAB_AVALID                              : in    std_logic := 'U';
          FAB_HOSTDISCON                          : in    std_logic := 'U';
          FAB_IDDIG                               : in    std_logic := 'U';
          FAB_LINESTATE                           : in    std_logic_vector(1 downto 0) := (others => 'U');
          FAB_M3_RESET_N                          : in    std_logic := 'U';
          FAB_PLL_LOCK                            : in    std_logic := 'U';
          FAB_RXACTIVE                            : in    std_logic := 'U';
          FAB_RXERROR                             : in    std_logic := 'U';
          FAB_RXVALID                             : in    std_logic := 'U';
          FAB_RXVALIDH                            : in    std_logic := 'U';
          FAB_SESSEND                             : in    std_logic := 'U';
          FAB_TXREADY                             : in    std_logic := 'U';
          FAB_VBUSVALID                           : in    std_logic := 'U';
          FAB_VSTATUS                             : in    std_logic_vector(7 downto 0) := (others => 'U');
          FAB_XDATAIN                             : in    std_logic_vector(7 downto 0) := (others => 'U');
          GTX_CLKPF                               : in    std_logic := 'U';
          I2C0_BCLK                               : in    std_logic := 'U';
          I2C0_SCL_F2H_SCP                        : in    std_logic := 'U';
          I2C0_SDA_F2H_SCP                        : in    std_logic := 'U';
          I2C1_BCLK                               : in    std_logic := 'U';
          I2C1_SCL_F2H_SCP                        : in    std_logic := 'U';
          I2C1_SDA_F2H_SCP                        : in    std_logic := 'U';
          MDIF                                    : in    std_logic := 'U';
          MGPIO0A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO10A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO11A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO11B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO12A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO13A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO14A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO15A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO16A_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO17B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO18B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO19B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO1A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO20B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO21B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO22B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO24B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO25B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO26B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO27B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO28B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO29B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO2A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO30B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO31B_F2H_GPIN                       : in    std_logic := 'U';
          MGPIO3A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO4A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO5A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO6A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO7A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO8A_F2H_GPIN                        : in    std_logic := 'U';
          MGPIO9A_F2H_GPIN                        : in    std_logic := 'U';
          MMUART0_CTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_DCD_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_DSR_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_DTR_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_RI_F2H_SCP                      : in    std_logic := 'U';
          MMUART0_RTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_RXD_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_SCK_F2H_SCP                     : in    std_logic := 'U';
          MMUART0_TXD_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_CTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_DCD_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_DSR_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_RI_F2H_SCP                      : in    std_logic := 'U';
          MMUART1_RTS_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_RXD_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_SCK_F2H_SCP                     : in    std_logic := 'U';
          MMUART1_TXD_F2H_SCP                     : in    std_logic := 'U';
          PER2_FABRIC_PRDATA                      : in    std_logic_vector(31 downto 0) := (others => 'U');
          PER2_FABRIC_PREADY                      : in    std_logic := 'U';
          PER2_FABRIC_PSLVERR                     : in    std_logic := 'U';
          RCGF                                    : in    std_logic_vector(9 downto 0) := (others => 'U');
          RX_CLKPF                                : in    std_logic := 'U';
          RX_DVF                                  : in    std_logic := 'U';
          RX_ERRF                                 : in    std_logic := 'U';
          RX_EV                                   : in    std_logic := 'U';
          RXDF                                    : in    std_logic_vector(7 downto 0) := (others => 'U');
          SLEEPHOLDREQ                            : in    std_logic := 'U';
          SMBALERT_NI0                            : in    std_logic := 'U';
          SMBALERT_NI1                            : in    std_logic := 'U';
          SMBSUS_NI0                              : in    std_logic := 'U';
          SMBSUS_NI1                              : in    std_logic := 'U';
          SPI0_CLK_IN                             : in    std_logic := 'U';
          SPI0_SDI_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SDO_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS0_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS1_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS2_F2H_SCP                        : in    std_logic := 'U';
          SPI0_SS3_F2H_SCP                        : in    std_logic := 'U';
          SPI1_CLK_IN                             : in    std_logic := 'U';
          SPI1_SDI_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SDO_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS0_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS1_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS2_F2H_SCP                        : in    std_logic := 'U';
          SPI1_SS3_F2H_SCP                        : in    std_logic := 'U';
          TX_CLKPF                                : in    std_logic := 'U';
          USER_MSS_GPIO_RESET_N                   : in    std_logic := 'U';
          USER_MSS_RESET_N                        : in    std_logic := 'U';
          XCLK_FAB                                : in    std_logic := 'U';
          CLK_BASE                                : in    std_logic := 'U';
          CLK_MDDR_APB                            : in    std_logic := 'U';
          F_ARADDR_HADDR1                         : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_ARBURST_HTRANS1                       : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_ARID_HSEL1                            : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_ARLEN_HBURST1                         : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_ARLOCK_HMASTLOCK1                     : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_ARSIZE_HSIZE1                         : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_ARVALID_HWRITE1                       : in    std_logic := 'U';
          F_AWADDR_HADDR0                         : in    std_logic_vector(31 downto 0) := (others => 'U');
          F_AWBURST_HTRANS0                       : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_AWID_HSEL0                            : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_AWLEN_HBURST0                         : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_AWLOCK_HMASTLOCK0                     : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_AWSIZE_HSIZE0                         : in    std_logic_vector(1 downto 0) := (others => 'U');
          F_AWVALID_HWRITE0                       : in    std_logic := 'U';
          F_BREADY                                : in    std_logic := 'U';
          F_RMW_AXI                               : in    std_logic := 'U';
          F_RREADY                                : in    std_logic := 'U';
          F_WDATA_HWDATA01                        : in    std_logic_vector(63 downto 0) := (others => 'U');
          F_WID_HREADY01                          : in    std_logic_vector(3 downto 0) := (others => 'U');
          F_WLAST                                 : in    std_logic := 'U';
          F_WSTRB                                 : in    std_logic_vector(7 downto 0) := (others => 'U');
          F_WVALID                                : in    std_logic := 'U';
          FPGA_MDDR_ARESET_N                      : in    std_logic := 'U';
          MDDR_FABRIC_PADDR                       : in    std_logic_vector(10 downto 2) := (others => 'U');
          MDDR_FABRIC_PENABLE                     : in    std_logic := 'U';
          MDDR_FABRIC_PSEL                        : in    std_logic := 'U';
          MDDR_FABRIC_PWDATA                      : in    std_logic_vector(15 downto 0) := (others => 'U');
          MDDR_FABRIC_PWRITE                      : in    std_logic := 'U';
          PRESET_N                                : in    std_logic := 'U';
          CAN_RXBUS_USBA_DATA1_MGPIO3A_IN         : in    std_logic := 'U';
          CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN        : in    std_logic := 'U';
          CAN_TXBUS_USBA_DATA0_MGPIO2A_IN         : in    std_logic := 'U';
          DM_IN                                   : in    std_logic_vector(2 downto 0) := (others => 'U');
          DRAM_DQ_IN                              : in    std_logic_vector(17 downto 0) := (others => 'U');
          DRAM_DQS_IN                             : in    std_logic_vector(2 downto 0) := (others => 'U');
          DRAM_FIFO_WE_IN                         : in    std_logic_vector(1 downto 0) := (others => 'U');
          I2C0_SCL_USBC_DATA1_MGPIO31B_IN         : in    std_logic := 'U';
          I2C0_SDA_USBC_DATA0_MGPIO30B_IN         : in    std_logic := 'U';
          I2C1_SCL_USBA_DATA4_MGPIO1A_IN          : in    std_logic := 'U';
          I2C1_SDA_USBA_DATA3_MGPIO0A_IN          : in    std_logic := 'U';
          MGPIO0B_IN                              : in    std_logic := 'U';
          MGPIO10B_IN                             : in    std_logic := 'U';
          MGPIO1B_IN                              : in    std_logic := 'U';
          MGPIO25A_IN                             : in    std_logic := 'U';
          MGPIO26A_IN                             : in    std_logic := 'U';
          MGPIO27A_IN                             : in    std_logic := 'U';
          MGPIO28A_IN                             : in    std_logic := 'U';
          MGPIO29A_IN                             : in    std_logic := 'U';
          MGPIO2B_IN                              : in    std_logic := 'U';
          MGPIO30A_IN                             : in    std_logic := 'U';
          MGPIO31A_IN                             : in    std_logic := 'U';
          MGPIO3B_IN                              : in    std_logic := 'U';
          MGPIO4B_IN                              : in    std_logic := 'U';
          MGPIO5B_IN                              : in    std_logic := 'U';
          MGPIO6B_IN                              : in    std_logic := 'U';
          MGPIO7B_IN                              : in    std_logic := 'U';
          MGPIO8B_IN                              : in    std_logic := 'U';
          MGPIO9B_IN                              : in    std_logic := 'U';
          MMUART0_CTS_USBC_DATA7_MGPIO19B_IN      : in    std_logic := 'U';
          MMUART0_DCD_MGPIO22B_IN                 : in    std_logic := 'U';
          MMUART0_DSR_MGPIO20B_IN                 : in    std_logic := 'U';
          MMUART0_DTR_USBC_DATA6_MGPIO18B_IN      : in    std_logic := 'U';
          MMUART0_RI_MGPIO21B_IN                  : in    std_logic := 'U';
          MMUART0_RTS_USBC_DATA5_MGPIO17B_IN      : in    std_logic := 'U';
          MMUART0_RXD_USBC_STP_MGPIO28B_IN        : in    std_logic := 'U';
          MMUART0_SCK_USBC_NXT_MGPIO29B_IN        : in    std_logic := 'U';
          MMUART0_TXD_USBC_DIR_MGPIO27B_IN        : in    std_logic := 'U';
          MMUART1_CTS_MGPIO13B_IN                 : in    std_logic := 'U';
          MMUART1_DCD_MGPIO16B_IN                 : in    std_logic := 'U';
          MMUART1_DSR_MGPIO14B_IN                 : in    std_logic := 'U';
          MMUART1_DTR_MGPIO12B_IN                 : in    std_logic := 'U';
          MMUART1_RI_MGPIO15B_IN                  : in    std_logic := 'U';
          MMUART1_RTS_MGPIO11B_IN                 : in    std_logic := 'U';
          MMUART1_RXD_USBC_DATA3_MGPIO26B_IN      : in    std_logic := 'U';
          MMUART1_SCK_USBC_DATA4_MGPIO25B_IN      : in    std_logic := 'U';
          MMUART1_TXD_USBC_DATA2_MGPIO24B_IN      : in    std_logic := 'U';
          RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN     : in    std_logic := 'U';
          RGMII_MDC_RMII_MDC_IN                   : in    std_logic := 'U';
          RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN      : in    std_logic := 'U';
          RGMII_RX_CLK_IN                         : in    std_logic := 'U';
          RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN  : in    std_logic := 'U';
          RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN      : in    std_logic := 'U';
          RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN      : in    std_logic := 'U';
          RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN     : in    std_logic := 'U';
          RGMII_RXD3_USBB_DATA4_IN                : in    std_logic := 'U';
          RGMII_TX_CLK_IN                         : in    std_logic := 'U';
          RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN     : in    std_logic := 'U';
          RGMII_TXD0_RMII_TXD0_USBB_DIR_IN        : in    std_logic := 'U';
          RGMII_TXD1_RMII_TXD1_USBB_STP_IN        : in    std_logic := 'U';
          RGMII_TXD2_USBB_DATA5_IN                : in    std_logic := 'U';
          RGMII_TXD3_USBB_DATA6_IN                : in    std_logic := 'U';
          SPI0_SCK_USBA_XCLK_IN                   : in    std_logic := 'U';
          SPI0_SDI_USBA_DIR_MGPIO5A_IN            : in    std_logic := 'U';
          SPI0_SDO_USBA_STP_MGPIO6A_IN            : in    std_logic := 'U';
          SPI0_SS0_USBA_NXT_MGPIO7A_IN            : in    std_logic := 'U';
          SPI0_SS1_USBA_DATA5_MGPIO8A_IN          : in    std_logic := 'U';
          SPI0_SS2_USBA_DATA6_MGPIO9A_IN          : in    std_logic := 'U';
          SPI0_SS3_USBA_DATA7_MGPIO10A_IN         : in    std_logic := 'U';
          SPI0_SS4_MGPIO19A_IN                    : in    std_logic := 'U';
          SPI0_SS5_MGPIO20A_IN                    : in    std_logic := 'U';
          SPI0_SS6_MGPIO21A_IN                    : in    std_logic := 'U';
          SPI0_SS7_MGPIO22A_IN                    : in    std_logic := 'U';
          SPI1_SCK_IN                             : in    std_logic := 'U';
          SPI1_SDI_MGPIO11A_IN                    : in    std_logic := 'U';
          SPI1_SDO_MGPIO12A_IN                    : in    std_logic := 'U';
          SPI1_SS0_MGPIO13A_IN                    : in    std_logic := 'U';
          SPI1_SS1_MGPIO14A_IN                    : in    std_logic := 'U';
          SPI1_SS2_MGPIO15A_IN                    : in    std_logic := 'U';
          SPI1_SS3_MGPIO16A_IN                    : in    std_logic := 'U';
          SPI1_SS4_MGPIO17A_IN                    : in    std_logic := 'U';
          SPI1_SS5_MGPIO18A_IN                    : in    std_logic := 'U';
          SPI1_SS6_MGPIO23A_IN                    : in    std_logic := 'U';
          SPI1_SS7_MGPIO24A_IN                    : in    std_logic := 'U';
          USBC_XCLK_IN                            : in    std_logic := 'U';
          USBD_DATA0_IN                           : in    std_logic := 'U';
          USBD_DATA1_IN                           : in    std_logic := 'U';
          USBD_DATA2_IN                           : in    std_logic := 'U';
          USBD_DATA3_IN                           : in    std_logic := 'U';
          USBD_DATA4_IN                           : in    std_logic := 'U';
          USBD_DATA5_IN                           : in    std_logic := 'U';
          USBD_DATA6_IN                           : in    std_logic := 'U';
          USBD_DATA7_MGPIO23B_IN                  : in    std_logic := 'U';
          USBD_DIR_IN                             : in    std_logic := 'U';
          USBD_NXT_IN                             : in    std_logic := 'U';
          USBD_STP_IN                             : in    std_logic := 'U';
          USBD_XCLK_IN                            : in    std_logic := 'U';
          CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT        : out   std_logic;
          CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT       : out   std_logic;
          CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT        : out   std_logic;
          DRAM_ADDR                               : out   std_logic_vector(15 downto 0);
          DRAM_BA                                 : out   std_logic_vector(2 downto 0);
          DRAM_CASN                               : out   std_logic;
          DRAM_CKE                                : out   std_logic;
          DRAM_CLK                                : out   std_logic;
          DRAM_CSN                                : out   std_logic;
          DRAM_DM_RDQS_OUT                        : out   std_logic_vector(2 downto 0);
          DRAM_DQ_OUT                             : out   std_logic_vector(17 downto 0);
          DRAM_DQS_OUT                            : out   std_logic_vector(2 downto 0);
          DRAM_FIFO_WE_OUT                        : out   std_logic_vector(1 downto 0);
          DRAM_ODT                                : out   std_logic;
          DRAM_RASN                               : out   std_logic;
          DRAM_RSTN                               : out   std_logic;
          DRAM_WEN                                : out   std_logic;
          I2C0_SCL_USBC_DATA1_MGPIO31B_OUT        : out   std_logic;
          I2C0_SDA_USBC_DATA0_MGPIO30B_OUT        : out   std_logic;
          I2C1_SCL_USBA_DATA4_MGPIO1A_OUT         : out   std_logic;
          I2C1_SDA_USBA_DATA3_MGPIO0A_OUT         : out   std_logic;
          MGPIO0B_OUT                             : out   std_logic;
          MGPIO10B_OUT                            : out   std_logic;
          MGPIO1B_OUT                             : out   std_logic;
          MGPIO25A_OUT                            : out   std_logic;
          MGPIO26A_OUT                            : out   std_logic;
          MGPIO27A_OUT                            : out   std_logic;
          MGPIO28A_OUT                            : out   std_logic;
          MGPIO29A_OUT                            : out   std_logic;
          MGPIO2B_OUT                             : out   std_logic;
          MGPIO30A_OUT                            : out   std_logic;
          MGPIO31A_OUT                            : out   std_logic;
          MGPIO3B_OUT                             : out   std_logic;
          MGPIO4B_OUT                             : out   std_logic;
          MGPIO5B_OUT                             : out   std_logic;
          MGPIO6B_OUT                             : out   std_logic;
          MGPIO7B_OUT                             : out   std_logic;
          MGPIO8B_OUT                             : out   std_logic;
          MGPIO9B_OUT                             : out   std_logic;
          MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT     : out   std_logic;
          MMUART0_DCD_MGPIO22B_OUT                : out   std_logic;
          MMUART0_DSR_MGPIO20B_OUT                : out   std_logic;
          MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT     : out   std_logic;
          MMUART0_RI_MGPIO21B_OUT                 : out   std_logic;
          MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT     : out   std_logic;
          MMUART0_RXD_USBC_STP_MGPIO28B_OUT       : out   std_logic;
          MMUART0_SCK_USBC_NXT_MGPIO29B_OUT       : out   std_logic;
          MMUART0_TXD_USBC_DIR_MGPIO27B_OUT       : out   std_logic;
          MMUART1_CTS_MGPIO13B_OUT                : out   std_logic;
          MMUART1_DCD_MGPIO16B_OUT                : out   std_logic;
          MMUART1_DSR_MGPIO14B_OUT                : out   std_logic;
          MMUART1_DTR_MGPIO12B_OUT                : out   std_logic;
          MMUART1_RI_MGPIO15B_OUT                 : out   std_logic;
          MMUART1_RTS_MGPIO11B_OUT                : out   std_logic;
          MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT     : out   std_logic;
          MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT     : out   std_logic;
          MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT     : out   std_logic;
          RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT    : out   std_logic;
          RGMII_MDC_RMII_MDC_OUT                  : out   std_logic;
          RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT     : out   std_logic;
          RGMII_RX_CLK_OUT                        : out   std_logic;
          RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT : out   std_logic;
          RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT     : out   std_logic;
          RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT     : out   std_logic;
          RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT    : out   std_logic;
          RGMII_RXD3_USBB_DATA4_OUT               : out   std_logic;
          RGMII_TX_CLK_OUT                        : out   std_logic;
          RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT    : out   std_logic;
          RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT       : out   std_logic;
          RGMII_TXD1_RMII_TXD1_USBB_STP_OUT       : out   std_logic;
          RGMII_TXD2_USBB_DATA5_OUT               : out   std_logic;
          RGMII_TXD3_USBB_DATA6_OUT               : out   std_logic;
          SPI0_SCK_USBA_XCLK_OUT                  : out   std_logic;
          SPI0_SDI_USBA_DIR_MGPIO5A_OUT           : out   std_logic;
          SPI0_SDO_USBA_STP_MGPIO6A_OUT           : out   std_logic;
          SPI0_SS0_USBA_NXT_MGPIO7A_OUT           : out   std_logic;
          SPI0_SS1_USBA_DATA5_MGPIO8A_OUT         : out   std_logic;
          SPI0_SS2_USBA_DATA6_MGPIO9A_OUT         : out   std_logic;
          SPI0_SS3_USBA_DATA7_MGPIO10A_OUT        : out   std_logic;
          SPI0_SS4_MGPIO19A_OUT                   : out   std_logic;
          SPI0_SS5_MGPIO20A_OUT                   : out   std_logic;
          SPI0_SS6_MGPIO21A_OUT                   : out   std_logic;
          SPI0_SS7_MGPIO22A_OUT                   : out   std_logic;
          SPI1_SCK_OUT                            : out   std_logic;
          SPI1_SDI_MGPIO11A_OUT                   : out   std_logic;
          SPI1_SDO_MGPIO12A_OUT                   : out   std_logic;
          SPI1_SS0_MGPIO13A_OUT                   : out   std_logic;
          SPI1_SS1_MGPIO14A_OUT                   : out   std_logic;
          SPI1_SS2_MGPIO15A_OUT                   : out   std_logic;
          SPI1_SS3_MGPIO16A_OUT                   : out   std_logic;
          SPI1_SS4_MGPIO17A_OUT                   : out   std_logic;
          SPI1_SS5_MGPIO18A_OUT                   : out   std_logic;
          SPI1_SS6_MGPIO23A_OUT                   : out   std_logic;
          SPI1_SS7_MGPIO24A_OUT                   : out   std_logic;
          USBC_XCLK_OUT                           : out   std_logic;
          USBD_DATA0_OUT                          : out   std_logic;
          USBD_DATA1_OUT                          : out   std_logic;
          USBD_DATA2_OUT                          : out   std_logic;
          USBD_DATA3_OUT                          : out   std_logic;
          USBD_DATA4_OUT                          : out   std_logic;
          USBD_DATA5_OUT                          : out   std_logic;
          USBD_DATA6_OUT                          : out   std_logic;
          USBD_DATA7_MGPIO23B_OUT                 : out   std_logic;
          USBD_DIR_OUT                            : out   std_logic;
          USBD_NXT_OUT                            : out   std_logic;
          USBD_STP_OUT                            : out   std_logic;
          USBD_XCLK_OUT                           : out   std_logic;
          CAN_RXBUS_USBA_DATA1_MGPIO3A_OE         : out   std_logic;
          CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE        : out   std_logic;
          CAN_TXBUS_USBA_DATA0_MGPIO2A_OE         : out   std_logic;
          DM_OE                                   : out   std_logic_vector(2 downto 0);
          DRAM_DQ_OE                              : out   std_logic_vector(17 downto 0);
          DRAM_DQS_OE                             : out   std_logic_vector(2 downto 0);
          I2C0_SCL_USBC_DATA1_MGPIO31B_OE         : out   std_logic;
          I2C0_SDA_USBC_DATA0_MGPIO30B_OE         : out   std_logic;
          I2C1_SCL_USBA_DATA4_MGPIO1A_OE          : out   std_logic;
          I2C1_SDA_USBA_DATA3_MGPIO0A_OE          : out   std_logic;
          MGPIO0B_OE                              : out   std_logic;
          MGPIO10B_OE                             : out   std_logic;
          MGPIO1B_OE                              : out   std_logic;
          MGPIO25A_OE                             : out   std_logic;
          MGPIO26A_OE                             : out   std_logic;
          MGPIO27A_OE                             : out   std_logic;
          MGPIO28A_OE                             : out   std_logic;
          MGPIO29A_OE                             : out   std_logic;
          MGPIO2B_OE                              : out   std_logic;
          MGPIO30A_OE                             : out   std_logic;
          MGPIO31A_OE                             : out   std_logic;
          MGPIO3B_OE                              : out   std_logic;
          MGPIO4B_OE                              : out   std_logic;
          MGPIO5B_OE                              : out   std_logic;
          MGPIO6B_OE                              : out   std_logic;
          MGPIO7B_OE                              : out   std_logic;
          MGPIO8B_OE                              : out   std_logic;
          MGPIO9B_OE                              : out   std_logic;
          MMUART0_CTS_USBC_DATA7_MGPIO19B_OE      : out   std_logic;
          MMUART0_DCD_MGPIO22B_OE                 : out   std_logic;
          MMUART0_DSR_MGPIO20B_OE                 : out   std_logic;
          MMUART0_DTR_USBC_DATA6_MGPIO18B_OE      : out   std_logic;
          MMUART0_RI_MGPIO21B_OE                  : out   std_logic;
          MMUART0_RTS_USBC_DATA5_MGPIO17B_OE      : out   std_logic;
          MMUART0_RXD_USBC_STP_MGPIO28B_OE        : out   std_logic;
          MMUART0_SCK_USBC_NXT_MGPIO29B_OE        : out   std_logic;
          MMUART0_TXD_USBC_DIR_MGPIO27B_OE        : out   std_logic;
          MMUART1_CTS_MGPIO13B_OE                 : out   std_logic;
          MMUART1_DCD_MGPIO16B_OE                 : out   std_logic;
          MMUART1_DSR_MGPIO14B_OE                 : out   std_logic;
          MMUART1_DTR_MGPIO12B_OE                 : out   std_logic;
          MMUART1_RI_MGPIO15B_OE                  : out   std_logic;
          MMUART1_RTS_MGPIO11B_OE                 : out   std_logic;
          MMUART1_RXD_USBC_DATA3_MGPIO26B_OE      : out   std_logic;
          MMUART1_SCK_USBC_DATA4_MGPIO25B_OE      : out   std_logic;
          MMUART1_TXD_USBC_DATA2_MGPIO24B_OE      : out   std_logic;
          RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE     : out   std_logic;
          RGMII_MDC_RMII_MDC_OE                   : out   std_logic;
          RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE      : out   std_logic;
          RGMII_RX_CLK_OE                         : out   std_logic;
          RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE  : out   std_logic;
          RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE      : out   std_logic;
          RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE      : out   std_logic;
          RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE     : out   std_logic;
          RGMII_RXD3_USBB_DATA4_OE                : out   std_logic;
          RGMII_TX_CLK_OE                         : out   std_logic;
          RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE     : out   std_logic;
          RGMII_TXD0_RMII_TXD0_USBB_DIR_OE        : out   std_logic;
          RGMII_TXD1_RMII_TXD1_USBB_STP_OE        : out   std_logic;
          RGMII_TXD2_USBB_DATA5_OE                : out   std_logic;
          RGMII_TXD3_USBB_DATA6_OE                : out   std_logic;
          SPI0_SCK_USBA_XCLK_OE                   : out   std_logic;
          SPI0_SDI_USBA_DIR_MGPIO5A_OE            : out   std_logic;
          SPI0_SDO_USBA_STP_MGPIO6A_OE            : out   std_logic;
          SPI0_SS0_USBA_NXT_MGPIO7A_OE            : out   std_logic;
          SPI0_SS1_USBA_DATA5_MGPIO8A_OE          : out   std_logic;
          SPI0_SS2_USBA_DATA6_MGPIO9A_OE          : out   std_logic;
          SPI0_SS3_USBA_DATA7_MGPIO10A_OE         : out   std_logic;
          SPI0_SS4_MGPIO19A_OE                    : out   std_logic;
          SPI0_SS5_MGPIO20A_OE                    : out   std_logic;
          SPI0_SS6_MGPIO21A_OE                    : out   std_logic;
          SPI0_SS7_MGPIO22A_OE                    : out   std_logic;
          SPI1_SCK_OE                             : out   std_logic;
          SPI1_SDI_MGPIO11A_OE                    : out   std_logic;
          SPI1_SDO_MGPIO12A_OE                    : out   std_logic;
          SPI1_SS0_MGPIO13A_OE                    : out   std_logic;
          SPI1_SS1_MGPIO14A_OE                    : out   std_logic;
          SPI1_SS2_MGPIO15A_OE                    : out   std_logic;
          SPI1_SS3_MGPIO16A_OE                    : out   std_logic;
          SPI1_SS4_MGPIO17A_OE                    : out   std_logic;
          SPI1_SS5_MGPIO18A_OE                    : out   std_logic;
          SPI1_SS6_MGPIO23A_OE                    : out   std_logic;
          SPI1_SS7_MGPIO24A_OE                    : out   std_logic;
          USBC_XCLK_OE                            : out   std_logic;
          USBD_DATA0_OE                           : out   std_logic;
          USBD_DATA1_OE                           : out   std_logic;
          USBD_DATA2_OE                           : out   std_logic;
          USBD_DATA3_OE                           : out   std_logic;
          USBD_DATA4_OE                           : out   std_logic;
          USBD_DATA5_OE                           : out   std_logic;
          USBD_DATA6_OE                           : out   std_logic;
          USBD_DATA7_MGPIO23B_OE                  : out   std_logic;
          USBD_DIR_OE                             : out   std_logic;
          USBD_NXT_OE                             : out   std_logic;
          USBD_STP_OE                             : out   std_logic;
          USBD_XCLK_OE                            : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component OUTBUF
    generic (IOSTD:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

    signal MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OUT, 
        VCC_net_1, GND_net_1 : std_logic;
    signal nc228, nc203, nc265, nc216, nc194, nc151, nc23, nc175, 
        nc250, nc58, nc116, nc74, nc133, nc238, nc167, nc84, nc39, 
        nc72, nc256, nc212, nc205, nc82, nc145, nc181, nc160, 
        nc57, nc156, nc280, nc125, nc211, nc73, nc107, nc66, nc83, 
        nc9, nc252, nc171, nc54, nc286, nc307, nc135, nc41, nc100, 
        nc270, nc52, nc251, nc186, nc29, nc269, nc118, nc60, 
        nc141, nc311, nc276, nc193, nc214, nc298, nc282, nc240, 
        nc45, nc53, nc121, nc176, nc220, nc158, nc281, nc209, 
        nc246, nc162, nc11, nc272, nc131, nc254, nc267, nc96, 
        nc79, nc226, nc146, nc230, nc89, nc119, nc48, nc271, 
        nc213, nc300, nc126, nc195, nc188, nc242, nc15, nc308, 
        nc236, nc102, nc304, nc3, nc207, nc47, nc90, nc284, nc222, 
        nc159, nc136, nc241, nc253, nc178, nc306, nc215, nc59, 
        nc221, nc232, nc274, nc18, nc44, nc117, nc189, nc164, 
        nc148, nc42, nc231, nc191, nc255, nc283, nc317, nc290, 
        nc17, nc2, nc302, nc110, nc128, nc244, nc321, nc43, nc179, 
        nc157, nc36, nc224, nc296, nc273, nc61, nc104, nc138, 
        nc14, nc285, nc303, nc150, nc196, nc234, nc149, nc12, 
        nc219, nc30, nc243, nc187, nc65, nc7, nc292, nc129, nc275, 
        nc8, nc223, nc13, nc305, nc180, nc26, nc291, nc177, nc139, 
        nc310, nc259, nc245, nc233, nc163, nc318, nc268, nc112, 
        nc68, nc49, nc314, nc217, nc170, nc91, nc225, nc5, nc20, 
        nc198, nc147, nc316, nc67, nc289, nc294, nc152, nc127, 
        nc103, nc235, nc76, nc208, nc140, nc257, nc86, nc95, 
        nc120, nc165, nc279, nc137, nc64, nc19, nc312, nc70, 
        nc182, nc62, nc199, nc80, nc130, nc287, nc98, nc293, 
        nc249, nc114, nc56, nc105, nc63, nc313, nc309, nc172, 
        nc229, nc277, nc97, nc161, nc31, nc295, nc154, nc50, 
        nc260, nc239, nc142, nc320, nc315, nc247, nc94, nc197, 
        nc122, nc266, nc35, nc324, nc4, nc227, nc92, nc101, nc184, 
        nc200, nc190, nc166, nc132, nc21, nc237, nc93, nc262, 
        nc69, nc206, nc174, nc38, nc113, nc218, nc106, nc261, 
        nc25, nc1, nc322, nc299, nc37, nc202, nc144, nc153, nc46, 
        nc258, nc71, nc124, nc81, nc201, nc168, nc323, nc34, nc28, 
        nc115, nc264, nc192, nc319, nc134, nc32, nc40, nc297, 
        nc99, nc75, nc183, nc288, nc85, nc27, nc108, nc16, nc155, 
        nc51, nc301, nc33, nc204, nc173, nc278, nc169, nc78, 
        nc263, nc24, nc88, nc111, nc55, nc10, nc22, nc210, nc185, 
        nc143, nc248, nc77, nc6, nc109, nc87, nc123 : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    MSS_ADLIB_INST : MSS_060

              generic map(INIT => "00" & x"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000F00000000F000000000000000000000000000000007FFFFFFFB000001007C33C000000006092C0104003FFFFE4000000000000100000000F0F15C00000182DFFC010842108421000001FE34001FF8000000400000000020891007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
         ACT_UBITS => x"FFFFFFFFFFFFFF",
         MEMORYFILE => "ENVM_init.mem", RTC_MAIN_XTL_FREQ => 0.0,
         DDR_CLK_FREQ => 100.0)

      port map(CAN_RXBUS_MGPIO3A_H2F_A => OPEN, 
        CAN_RXBUS_MGPIO3A_H2F_B => OPEN, CAN_TX_EBL_MGPIO4A_H2F_A
         => OPEN, CAN_TX_EBL_MGPIO4A_H2F_B => OPEN, 
        CAN_TXBUS_MGPIO2A_H2F_A => OPEN, CAN_TXBUS_MGPIO2A_H2F_B
         => OPEN, CLK_CONFIG_APB => OPEN, COMMS_INT => OPEN, 
        CONFIG_PRESET_N => 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, 
        EDAC_ERROR(7) => nc228, EDAC_ERROR(6) => nc203, 
        EDAC_ERROR(5) => nc265, EDAC_ERROR(4) => nc216, 
        EDAC_ERROR(3) => nc194, EDAC_ERROR(2) => nc151, 
        EDAC_ERROR(1) => nc23, EDAC_ERROR(0) => nc175, 
        F_FM0_RDATA(31) => nc250, F_FM0_RDATA(30) => nc58, 
        F_FM0_RDATA(29) => nc116, F_FM0_RDATA(28) => nc74, 
        F_FM0_RDATA(27) => nc133, F_FM0_RDATA(26) => nc238, 
        F_FM0_RDATA(25) => nc167, F_FM0_RDATA(24) => nc84, 
        F_FM0_RDATA(23) => nc39, F_FM0_RDATA(22) => nc72, 
        F_FM0_RDATA(21) => nc256, F_FM0_RDATA(20) => nc212, 
        F_FM0_RDATA(19) => nc205, F_FM0_RDATA(18) => nc82, 
        F_FM0_RDATA(17) => nc145, F_FM0_RDATA(16) => nc181, 
        F_FM0_RDATA(15) => nc160, F_FM0_RDATA(14) => nc57, 
        F_FM0_RDATA(13) => nc156, F_FM0_RDATA(12) => nc280, 
        F_FM0_RDATA(11) => nc125, F_FM0_RDATA(10) => nc211, 
        F_FM0_RDATA(9) => nc73, F_FM0_RDATA(8) => nc107, 
        F_FM0_RDATA(7) => nc66, F_FM0_RDATA(6) => nc83, 
        F_FM0_RDATA(5) => nc9, F_FM0_RDATA(4) => nc252, 
        F_FM0_RDATA(3) => nc171, F_FM0_RDATA(2) => nc54, 
        F_FM0_RDATA(1) => nc286, F_FM0_RDATA(0) => nc307, 
        F_FM0_READYOUT => OPEN, F_FM0_RESP => OPEN, 
        F_HM0_ADDR(31) => nc135, F_HM0_ADDR(30) => nc41, 
        F_HM0_ADDR(29) => nc100, F_HM0_ADDR(28) => nc270, 
        F_HM0_ADDR(27) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27, 
        F_HM0_ADDR(26) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26, 
        F_HM0_ADDR(25) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25, 
        F_HM0_ADDR(24) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24, 
        F_HM0_ADDR(23) => nc52, F_HM0_ADDR(22) => nc251, 
        F_HM0_ADDR(21) => nc186, F_HM0_ADDR(20) => nc29, 
        F_HM0_ADDR(19) => nc269, F_HM0_ADDR(18) => nc118, 
        F_HM0_ADDR(17) => nc60, F_HM0_ADDR(16) => nc141, 
        F_HM0_ADDR(15) => nc311, F_HM0_ADDR(14) => nc276, 
        F_HM0_ADDR(13) => nc193, F_HM0_ADDR(12) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12, 
        F_HM0_ADDR(11) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11, 
        F_HM0_ADDR(10) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10, 
        F_HM0_ADDR(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9, 
        F_HM0_ADDR(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8, 
        F_HM0_ADDR(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7, 
        F_HM0_ADDR(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6, 
        F_HM0_ADDR(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5, 
        F_HM0_ADDR(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4, 
        F_HM0_ADDR(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3, 
        F_HM0_ADDR(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2, 
        F_HM0_ADDR(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1, 
        F_HM0_ADDR(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0, 
        F_HM0_ENABLE => OPEN, F_HM0_SEL => OPEN, F_HM0_SIZE(1)
         => sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1), 
        F_HM0_SIZE(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0), 
        F_HM0_TRANS1 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), 
        F_HM0_WDATA(31) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31), 
        F_HM0_WDATA(30) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30), 
        F_HM0_WDATA(29) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29), 
        F_HM0_WDATA(28) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28), 
        F_HM0_WDATA(27) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27), 
        F_HM0_WDATA(26) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26), 
        F_HM0_WDATA(25) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25), 
        F_HM0_WDATA(24) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24), 
        F_HM0_WDATA(23) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23), 
        F_HM0_WDATA(22) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22), 
        F_HM0_WDATA(21) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21), 
        F_HM0_WDATA(20) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20), 
        F_HM0_WDATA(19) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19), 
        F_HM0_WDATA(18) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18), 
        F_HM0_WDATA(17) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17), 
        F_HM0_WDATA(16) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16), 
        F_HM0_WDATA(15) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15), 
        F_HM0_WDATA(14) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14), 
        F_HM0_WDATA(13) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13), 
        F_HM0_WDATA(12) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12), 
        F_HM0_WDATA(11) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11), 
        F_HM0_WDATA(10) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10), 
        F_HM0_WDATA(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9), 
        F_HM0_WDATA(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8), 
        F_HM0_WDATA(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7), 
        F_HM0_WDATA(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6), 
        F_HM0_WDATA(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5), 
        F_HM0_WDATA(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4), 
        F_HM0_WDATA(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3), 
        F_HM0_WDATA(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2), 
        F_HM0_WDATA(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1), 
        F_HM0_WDATA(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0), 
        F_HM0_WRITE => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, 
        FAB_CHRGVBUS => OPEN, FAB_DISCHRGVBUS => OPEN, 
        FAB_DMPULLDOWN => OPEN, FAB_DPPULLDOWN => OPEN, 
        FAB_DRVVBUS => OPEN, FAB_IDPULLUP => OPEN, FAB_OPMODE(1)
         => nc214, FAB_OPMODE(0) => nc298, FAB_SUSPENDM => OPEN, 
        FAB_TERMSEL => OPEN, FAB_TXVALID => OPEN, FAB_VCONTROL(3)
         => nc282, FAB_VCONTROL(2) => nc240, FAB_VCONTROL(1) => 
        nc45, FAB_VCONTROL(0) => nc53, FAB_VCONTROLLOADM => OPEN, 
        FAB_XCVRSEL(1) => nc121, FAB_XCVRSEL(0) => nc176, 
        FAB_XDATAOUT(7) => nc220, FAB_XDATAOUT(6) => nc158, 
        FAB_XDATAOUT(5) => nc281, FAB_XDATAOUT(4) => nc209, 
        FAB_XDATAOUT(3) => nc246, FAB_XDATAOUT(2) => nc162, 
        FAB_XDATAOUT(1) => nc11, FAB_XDATAOUT(0) => nc272, 
        FACC_GLMUX_SEL => OPEN, FIC32_0_MASTER(1) => nc131, 
        FIC32_0_MASTER(0) => nc254, FIC32_1_MASTER(1) => nc267, 
        FIC32_1_MASTER(0) => nc96, FPGA_RESET_N => 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F, GTX_CLK => 
        OPEN, H2F_INTERRUPT(15) => nc79, H2F_INTERRUPT(14) => 
        nc226, H2F_INTERRUPT(13) => nc146, H2F_INTERRUPT(12) => 
        nc230, H2F_INTERRUPT(11) => nc89, H2F_INTERRUPT(10) => 
        nc119, H2F_INTERRUPT(9) => nc48, H2F_INTERRUPT(8) => 
        nc271, H2F_INTERRUPT(7) => nc213, H2F_INTERRUPT(6) => 
        nc300, H2F_INTERRUPT(5) => nc126, H2F_INTERRUPT(4) => 
        nc195, H2F_INTERRUPT(3) => nc188, H2F_INTERRUPT(2) => 
        nc242, H2F_INTERRUPT(1) => nc15, H2F_INTERRUPT(0) => 
        nc308, H2F_NMI => OPEN, H2FCALIB => OPEN, 
        I2C0_SCL_MGPIO31B_H2F_A => OPEN, I2C0_SCL_MGPIO31B_H2F_B
         => OPEN, I2C0_SDA_MGPIO30B_H2F_A => OPEN, 
        I2C0_SDA_MGPIO30B_H2F_B => OPEN, I2C1_SCL_MGPIO1A_H2F_A
         => OPEN, I2C1_SCL_MGPIO1A_H2F_B => OPEN, 
        I2C1_SDA_MGPIO0A_H2F_A => OPEN, I2C1_SDA_MGPIO0A_H2F_B
         => OPEN, MDCF => OPEN, MDOENF => OPEN, MDOF => OPEN, 
        MMUART0_CTS_MGPIO19B_H2F_A => OPEN, 
        MMUART0_CTS_MGPIO19B_H2F_B => OPEN, 
        MMUART0_DCD_MGPIO22B_H2F_A => OPEN, 
        MMUART0_DCD_MGPIO22B_H2F_B => OPEN, 
        MMUART0_DSR_MGPIO20B_H2F_A => OPEN, 
        MMUART0_DSR_MGPIO20B_H2F_B => OPEN, 
        MMUART0_DTR_MGPIO18B_H2F_A => OPEN, 
        MMUART0_DTR_MGPIO18B_H2F_B => OPEN, 
        MMUART0_RI_MGPIO21B_H2F_A => OPEN, 
        MMUART0_RI_MGPIO21B_H2F_B => OPEN, 
        MMUART0_RTS_MGPIO17B_H2F_A => OPEN, 
        MMUART0_RTS_MGPIO17B_H2F_B => OPEN, 
        MMUART0_RXD_MGPIO28B_H2F_A => OPEN, 
        MMUART0_RXD_MGPIO28B_H2F_B => OPEN, 
        MMUART0_SCK_MGPIO29B_H2F_A => OPEN, 
        MMUART0_SCK_MGPIO29B_H2F_B => OPEN, 
        MMUART0_TXD_MGPIO27B_H2F_A => OPEN, 
        MMUART0_TXD_MGPIO27B_H2F_B => OPEN, 
        MMUART1_DTR_MGPIO12B_H2F_A => OPEN, 
        MMUART1_RTS_MGPIO11B_H2F_A => OPEN, 
        MMUART1_RTS_MGPIO11B_H2F_B => OPEN, 
        MMUART1_RXD_MGPIO26B_H2F_A => OPEN, 
        MMUART1_RXD_MGPIO26B_H2F_B => OPEN, 
        MMUART1_SCK_MGPIO25B_H2F_A => OPEN, 
        MMUART1_SCK_MGPIO25B_H2F_B => OPEN, 
        MMUART1_TXD_MGPIO24B_H2F_A => OPEN, 
        MMUART1_TXD_MGPIO24B_H2F_B => OPEN, MPLL_LOCK => OPEN, 
        PER2_FABRIC_PADDR(15) => nc236, PER2_FABRIC_PADDR(14) => 
        nc102, PER2_FABRIC_PADDR(13) => nc304, 
        PER2_FABRIC_PADDR(12) => nc3, PER2_FABRIC_PADDR(11) => 
        nc207, PER2_FABRIC_PADDR(10) => nc47, 
        PER2_FABRIC_PADDR(9) => nc90, PER2_FABRIC_PADDR(8) => 
        nc284, PER2_FABRIC_PADDR(7) => nc222, 
        PER2_FABRIC_PADDR(6) => nc159, PER2_FABRIC_PADDR(5) => 
        nc136, PER2_FABRIC_PADDR(4) => nc241, 
        PER2_FABRIC_PADDR(3) => nc253, PER2_FABRIC_PADDR(2) => 
        nc178, PER2_FABRIC_PENABLE => OPEN, PER2_FABRIC_PSEL => 
        OPEN, PER2_FABRIC_PWDATA(31) => nc306, 
        PER2_FABRIC_PWDATA(30) => nc215, PER2_FABRIC_PWDATA(29)
         => nc59, PER2_FABRIC_PWDATA(28) => nc221, 
        PER2_FABRIC_PWDATA(27) => nc232, PER2_FABRIC_PWDATA(26)
         => nc274, PER2_FABRIC_PWDATA(25) => nc18, 
        PER2_FABRIC_PWDATA(24) => nc44, PER2_FABRIC_PWDATA(23)
         => nc117, PER2_FABRIC_PWDATA(22) => nc189, 
        PER2_FABRIC_PWDATA(21) => nc164, PER2_FABRIC_PWDATA(20)
         => nc148, PER2_FABRIC_PWDATA(19) => nc42, 
        PER2_FABRIC_PWDATA(18) => nc231, PER2_FABRIC_PWDATA(17)
         => nc191, PER2_FABRIC_PWDATA(16) => nc255, 
        PER2_FABRIC_PWDATA(15) => nc283, PER2_FABRIC_PWDATA(14)
         => nc317, PER2_FABRIC_PWDATA(13) => nc290, 
        PER2_FABRIC_PWDATA(12) => nc17, PER2_FABRIC_PWDATA(11)
         => nc2, PER2_FABRIC_PWDATA(10) => nc302, 
        PER2_FABRIC_PWDATA(9) => nc110, PER2_FABRIC_PWDATA(8) => 
        nc128, PER2_FABRIC_PWDATA(7) => nc244, 
        PER2_FABRIC_PWDATA(6) => nc321, PER2_FABRIC_PWDATA(5) => 
        nc43, PER2_FABRIC_PWDATA(4) => nc179, 
        PER2_FABRIC_PWDATA(3) => nc157, PER2_FABRIC_PWDATA(2) => 
        nc36, PER2_FABRIC_PWDATA(1) => nc224, 
        PER2_FABRIC_PWDATA(0) => nc296, PER2_FABRIC_PWRITE => 
        OPEN, RTC_MATCH => OPEN, SLEEPDEEP => OPEN, SLEEPHOLDACK
         => OPEN, SLEEPING => OPEN, SMBALERT_NO0 => OPEN, 
        SMBALERT_NO1 => OPEN, SMBSUS_NO0 => OPEN, SMBSUS_NO1 => 
        OPEN, SPI0_CLK_OUT => OPEN, SPI0_SDI_MGPIO5A_H2F_A => 
        OPEN, SPI0_SDI_MGPIO5A_H2F_B => OPEN, 
        SPI0_SDO_MGPIO6A_H2F_A => OPEN, SPI0_SDO_MGPIO6A_H2F_B
         => OPEN, SPI0_SS0_MGPIO7A_H2F_A => OPEN, 
        SPI0_SS0_MGPIO7A_H2F_B => OPEN, SPI0_SS1_MGPIO8A_H2F_A
         => OPEN, SPI0_SS1_MGPIO8A_H2F_B => OPEN, 
        SPI0_SS2_MGPIO9A_H2F_A => OPEN, SPI0_SS2_MGPIO9A_H2F_B
         => OPEN, SPI0_SS3_MGPIO10A_H2F_A => OPEN, 
        SPI0_SS3_MGPIO10A_H2F_B => OPEN, SPI0_SS4_MGPIO19A_H2F_A
         => OPEN, SPI0_SS5_MGPIO20A_H2F_A => OPEN, 
        SPI0_SS6_MGPIO21A_H2F_A => OPEN, SPI0_SS7_MGPIO22A_H2F_A
         => OPEN, SPI1_CLK_OUT => OPEN, SPI1_SDI_MGPIO11A_H2F_A
         => OPEN, SPI1_SDI_MGPIO11A_H2F_B => OPEN, 
        SPI1_SDO_MGPIO12A_H2F_A => OPEN, SPI1_SDO_MGPIO12A_H2F_B
         => OPEN, SPI1_SS0_MGPIO13A_H2F_A => OPEN, 
        SPI1_SS0_MGPIO13A_H2F_B => OPEN, SPI1_SS1_MGPIO14A_H2F_A
         => OPEN, SPI1_SS1_MGPIO14A_H2F_B => OPEN, 
        SPI1_SS2_MGPIO15A_H2F_A => OPEN, SPI1_SS2_MGPIO15A_H2F_B
         => OPEN, SPI1_SS3_MGPIO16A_H2F_A => OPEN, 
        SPI1_SS3_MGPIO16A_H2F_B => OPEN, SPI1_SS4_MGPIO17A_H2F_A
         => OPEN, SPI1_SS5_MGPIO18A_H2F_A => OPEN, 
        SPI1_SS6_MGPIO23A_H2F_A => OPEN, SPI1_SS7_MGPIO24A_H2F_A
         => OPEN, TCGF(9) => nc273, TCGF(8) => nc61, TCGF(7) => 
        nc104, TCGF(6) => nc138, TCGF(5) => nc14, TCGF(4) => 
        nc285, TCGF(3) => nc303, TCGF(2) => nc150, TCGF(1) => 
        nc196, TCGF(0) => nc234, TRACECLK => OPEN, TRACEDATA(3)
         => nc149, TRACEDATA(2) => nc12, TRACEDATA(1) => nc219, 
        TRACEDATA(0) => nc30, TX_CLK => OPEN, TX_ENF => OPEN, 
        TX_ERRF => OPEN, TXCTL_EN_RIF => OPEN, TXD_RIF(3) => 
        nc243, TXD_RIF(2) => nc187, TXD_RIF(1) => nc65, 
        TXD_RIF(0) => nc7, TXDF(7) => nc292, TXDF(6) => nc129, 
        TXDF(5) => nc275, TXDF(4) => nc8, TXDF(3) => nc223, 
        TXDF(2) => nc13, TXDF(1) => nc305, TXDF(0) => nc180, TXEV
         => OPEN, WDOGTIMEOUT => OPEN, F_ARREADY_HREADYOUT1 => 
        OPEN, F_AWREADY_HREADYOUT0 => OPEN, F_BID(3) => nc26, 
        F_BID(2) => nc291, F_BID(1) => nc177, F_BID(0) => nc139, 
        F_BRESP_HRESP0(1) => nc310, F_BRESP_HRESP0(0) => nc259, 
        F_BVALID => OPEN, F_RDATA_HRDATA01(63) => nc245, 
        F_RDATA_HRDATA01(62) => nc233, F_RDATA_HRDATA01(61) => 
        nc163, F_RDATA_HRDATA01(60) => nc318, 
        F_RDATA_HRDATA01(59) => nc268, F_RDATA_HRDATA01(58) => 
        nc112, F_RDATA_HRDATA01(57) => nc68, F_RDATA_HRDATA01(56)
         => nc49, F_RDATA_HRDATA01(55) => nc314, 
        F_RDATA_HRDATA01(54) => nc217, F_RDATA_HRDATA01(53) => 
        nc170, F_RDATA_HRDATA01(52) => nc91, F_RDATA_HRDATA01(51)
         => nc225, F_RDATA_HRDATA01(50) => nc5, 
        F_RDATA_HRDATA01(49) => nc20, F_RDATA_HRDATA01(48) => 
        nc198, F_RDATA_HRDATA01(47) => nc147, 
        F_RDATA_HRDATA01(46) => nc316, F_RDATA_HRDATA01(45) => 
        nc67, F_RDATA_HRDATA01(44) => nc289, F_RDATA_HRDATA01(43)
         => nc294, F_RDATA_HRDATA01(42) => nc152, 
        F_RDATA_HRDATA01(41) => nc127, F_RDATA_HRDATA01(40) => 
        nc103, F_RDATA_HRDATA01(39) => nc235, 
        F_RDATA_HRDATA01(38) => nc76, F_RDATA_HRDATA01(37) => 
        nc208, F_RDATA_HRDATA01(36) => nc140, 
        F_RDATA_HRDATA01(35) => nc257, F_RDATA_HRDATA01(34) => 
        nc86, F_RDATA_HRDATA01(33) => nc95, F_RDATA_HRDATA01(32)
         => nc120, F_RDATA_HRDATA01(31) => nc165, 
        F_RDATA_HRDATA01(30) => nc279, F_RDATA_HRDATA01(29) => 
        nc137, F_RDATA_HRDATA01(28) => nc64, F_RDATA_HRDATA01(27)
         => nc19, F_RDATA_HRDATA01(26) => nc312, 
        F_RDATA_HRDATA01(25) => nc70, F_RDATA_HRDATA01(24) => 
        nc182, F_RDATA_HRDATA01(23) => nc62, F_RDATA_HRDATA01(22)
         => nc199, F_RDATA_HRDATA01(21) => nc80, 
        F_RDATA_HRDATA01(20) => nc130, F_RDATA_HRDATA01(19) => 
        nc287, F_RDATA_HRDATA01(18) => nc98, F_RDATA_HRDATA01(17)
         => nc293, F_RDATA_HRDATA01(16) => nc249, 
        F_RDATA_HRDATA01(15) => nc114, F_RDATA_HRDATA01(14) => 
        nc56, F_RDATA_HRDATA01(13) => nc105, F_RDATA_HRDATA01(12)
         => nc63, F_RDATA_HRDATA01(11) => nc313, 
        F_RDATA_HRDATA01(10) => nc309, F_RDATA_HRDATA01(9) => 
        nc172, F_RDATA_HRDATA01(8) => nc229, F_RDATA_HRDATA01(7)
         => nc277, F_RDATA_HRDATA01(6) => nc97, 
        F_RDATA_HRDATA01(5) => nc161, F_RDATA_HRDATA01(4) => nc31, 
        F_RDATA_HRDATA01(3) => nc295, F_RDATA_HRDATA01(2) => 
        nc154, F_RDATA_HRDATA01(1) => nc50, F_RDATA_HRDATA01(0)
         => nc260, F_RID(3) => nc239, F_RID(2) => nc142, F_RID(1)
         => nc320, F_RID(0) => nc315, F_RLAST => OPEN, 
        F_RRESP_HRESP1(1) => nc247, F_RRESP_HRESP1(0) => nc94, 
        F_RVALID => OPEN, F_WREADY => OPEN, 
        MDDR_FABRIC_PRDATA(15) => nc197, MDDR_FABRIC_PRDATA(14)
         => nc122, MDDR_FABRIC_PRDATA(13) => nc266, 
        MDDR_FABRIC_PRDATA(12) => nc35, MDDR_FABRIC_PRDATA(11)
         => nc324, MDDR_FABRIC_PRDATA(10) => nc4, 
        MDDR_FABRIC_PRDATA(9) => nc227, MDDR_FABRIC_PRDATA(8) => 
        nc92, MDDR_FABRIC_PRDATA(7) => nc101, 
        MDDR_FABRIC_PRDATA(6) => nc184, MDDR_FABRIC_PRDATA(5) => 
        nc200, MDDR_FABRIC_PRDATA(4) => nc190, 
        MDDR_FABRIC_PRDATA(3) => nc166, MDDR_FABRIC_PRDATA(2) => 
        nc132, MDDR_FABRIC_PRDATA(1) => nc21, 
        MDDR_FABRIC_PRDATA(0) => nc237, MDDR_FABRIC_PREADY => 
        OPEN, MDDR_FABRIC_PSLVERR => OPEN, CAN_RXBUS_F2H_SCP => 
        VCC_net_1, CAN_TX_EBL_F2H_SCP => VCC_net_1, 
        CAN_TXBUS_F2H_SCP => VCC_net_1, COLF => VCC_net_1, CRSF
         => VCC_net_1, F2_DMAREADY(1) => VCC_net_1, 
        F2_DMAREADY(0) => VCC_net_1, F2H_INTERRUPT(15) => 
        GND_net_1, F2H_INTERRUPT(14) => GND_net_1, 
        F2H_INTERRUPT(13) => GND_net_1, F2H_INTERRUPT(12) => 
        GND_net_1, F2H_INTERRUPT(11) => GND_net_1, 
        F2H_INTERRUPT(10) => GND_net_1, F2H_INTERRUPT(9) => 
        GND_net_1, F2H_INTERRUPT(8) => GND_net_1, 
        F2H_INTERRUPT(7) => GND_net_1, F2H_INTERRUPT(6) => 
        GND_net_1, F2H_INTERRUPT(5) => GND_net_1, 
        F2H_INTERRUPT(4) => GND_net_1, F2H_INTERRUPT(3) => 
        GND_net_1, F2H_INTERRUPT(2) => GND_net_1, 
        F2H_INTERRUPT(1) => GND_net_1, F2H_INTERRUPT(0) => 
        GND_net_1, F2HCALIB => VCC_net_1, F_DMAREADY(1) => 
        VCC_net_1, F_DMAREADY(0) => VCC_net_1, F_FM0_ADDR(31) => 
        GND_net_1, F_FM0_ADDR(30) => GND_net_1, F_FM0_ADDR(29)
         => GND_net_1, F_FM0_ADDR(28) => GND_net_1, 
        F_FM0_ADDR(27) => GND_net_1, F_FM0_ADDR(26) => GND_net_1, 
        F_FM0_ADDR(25) => GND_net_1, F_FM0_ADDR(24) => GND_net_1, 
        F_FM0_ADDR(23) => GND_net_1, F_FM0_ADDR(22) => GND_net_1, 
        F_FM0_ADDR(21) => GND_net_1, F_FM0_ADDR(20) => GND_net_1, 
        F_FM0_ADDR(19) => GND_net_1, F_FM0_ADDR(18) => GND_net_1, 
        F_FM0_ADDR(17) => GND_net_1, F_FM0_ADDR(16) => GND_net_1, 
        F_FM0_ADDR(15) => GND_net_1, F_FM0_ADDR(14) => GND_net_1, 
        F_FM0_ADDR(13) => GND_net_1, F_FM0_ADDR(12) => GND_net_1, 
        F_FM0_ADDR(11) => GND_net_1, F_FM0_ADDR(10) => GND_net_1, 
        F_FM0_ADDR(9) => GND_net_1, F_FM0_ADDR(8) => GND_net_1, 
        F_FM0_ADDR(7) => GND_net_1, F_FM0_ADDR(6) => GND_net_1, 
        F_FM0_ADDR(5) => GND_net_1, F_FM0_ADDR(4) => GND_net_1, 
        F_FM0_ADDR(3) => GND_net_1, F_FM0_ADDR(2) => GND_net_1, 
        F_FM0_ADDR(1) => GND_net_1, F_FM0_ADDR(0) => GND_net_1, 
        F_FM0_ENABLE => GND_net_1, F_FM0_MASTLOCK => GND_net_1, 
        F_FM0_READY => VCC_net_1, F_FM0_SEL => GND_net_1, 
        F_FM0_SIZE(1) => GND_net_1, F_FM0_SIZE(0) => GND_net_1, 
        F_FM0_TRANS1 => GND_net_1, F_FM0_WDATA(31) => GND_net_1, 
        F_FM0_WDATA(30) => GND_net_1, F_FM0_WDATA(29) => 
        GND_net_1, F_FM0_WDATA(28) => GND_net_1, F_FM0_WDATA(27)
         => GND_net_1, F_FM0_WDATA(26) => GND_net_1, 
        F_FM0_WDATA(25) => GND_net_1, F_FM0_WDATA(24) => 
        GND_net_1, F_FM0_WDATA(23) => GND_net_1, F_FM0_WDATA(22)
         => GND_net_1, F_FM0_WDATA(21) => GND_net_1, 
        F_FM0_WDATA(20) => GND_net_1, F_FM0_WDATA(19) => 
        GND_net_1, F_FM0_WDATA(18) => GND_net_1, F_FM0_WDATA(17)
         => GND_net_1, F_FM0_WDATA(16) => GND_net_1, 
        F_FM0_WDATA(15) => GND_net_1, F_FM0_WDATA(14) => 
        GND_net_1, F_FM0_WDATA(13) => GND_net_1, F_FM0_WDATA(12)
         => GND_net_1, F_FM0_WDATA(11) => GND_net_1, 
        F_FM0_WDATA(10) => GND_net_1, F_FM0_WDATA(9) => GND_net_1, 
        F_FM0_WDATA(8) => GND_net_1, F_FM0_WDATA(7) => GND_net_1, 
        F_FM0_WDATA(6) => GND_net_1, F_FM0_WDATA(5) => GND_net_1, 
        F_FM0_WDATA(4) => GND_net_1, F_FM0_WDATA(3) => GND_net_1, 
        F_FM0_WDATA(2) => GND_net_1, F_FM0_WDATA(1) => GND_net_1, 
        F_FM0_WDATA(0) => GND_net_1, F_FM0_WRITE => GND_net_1, 
        F_HM0_RDATA(31) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31), 
        F_HM0_RDATA(30) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30), 
        F_HM0_RDATA(29) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29), 
        F_HM0_RDATA(28) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28), 
        F_HM0_RDATA(27) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27), 
        F_HM0_RDATA(26) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26), 
        F_HM0_RDATA(25) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25), 
        F_HM0_RDATA(24) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24), 
        F_HM0_RDATA(23) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23), 
        F_HM0_RDATA(22) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22), 
        F_HM0_RDATA(21) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21), 
        F_HM0_RDATA(20) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20), 
        F_HM0_RDATA(19) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19), 
        F_HM0_RDATA(18) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18), 
        F_HM0_RDATA(17) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17), 
        F_HM0_RDATA(16) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16), 
        F_HM0_RDATA(15) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15), 
        F_HM0_RDATA(14) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14), 
        F_HM0_RDATA(13) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13), 
        F_HM0_RDATA(12) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12), 
        F_HM0_RDATA(11) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11), 
        F_HM0_RDATA(10) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10), 
        F_HM0_RDATA(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9), 
        F_HM0_RDATA(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8), 
        F_HM0_RDATA(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7), 
        F_HM0_RDATA(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6), 
        F_HM0_RDATA(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5), 
        F_HM0_RDATA(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4), 
        F_HM0_RDATA(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3), 
        F_HM0_RDATA(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2), 
        F_HM0_RDATA(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1), 
        F_HM0_RDATA(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0), 
        F_HM0_READY => HREADY_M_iv_i_0, F_HM0_RESP => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0), 
        FAB_AVALID => VCC_net_1, FAB_HOSTDISCON => VCC_net_1, 
        FAB_IDDIG => VCC_net_1, FAB_LINESTATE(1) => VCC_net_1, 
        FAB_LINESTATE(0) => VCC_net_1, FAB_M3_RESET_N => 
        VCC_net_1, FAB_PLL_LOCK => FIC_0_LOCK, FAB_RXACTIVE => 
        VCC_net_1, FAB_RXERROR => VCC_net_1, FAB_RXVALID => 
        VCC_net_1, FAB_RXVALIDH => GND_net_1, FAB_SESSEND => 
        VCC_net_1, FAB_TXREADY => VCC_net_1, FAB_VBUSVALID => 
        VCC_net_1, FAB_VSTATUS(7) => VCC_net_1, FAB_VSTATUS(6)
         => VCC_net_1, FAB_VSTATUS(5) => VCC_net_1, 
        FAB_VSTATUS(4) => VCC_net_1, FAB_VSTATUS(3) => VCC_net_1, 
        FAB_VSTATUS(2) => VCC_net_1, FAB_VSTATUS(1) => VCC_net_1, 
        FAB_VSTATUS(0) => VCC_net_1, FAB_XDATAIN(7) => VCC_net_1, 
        FAB_XDATAIN(6) => VCC_net_1, FAB_XDATAIN(5) => VCC_net_1, 
        FAB_XDATAIN(4) => VCC_net_1, FAB_XDATAIN(3) => VCC_net_1, 
        FAB_XDATAIN(2) => VCC_net_1, FAB_XDATAIN(1) => VCC_net_1, 
        FAB_XDATAIN(0) => VCC_net_1, GTX_CLKPF => VCC_net_1, 
        I2C0_BCLK => VCC_net_1, I2C0_SCL_F2H_SCP => VCC_net_1, 
        I2C0_SDA_F2H_SCP => VCC_net_1, I2C1_BCLK => VCC_net_1, 
        I2C1_SCL_F2H_SCP => VCC_net_1, I2C1_SDA_F2H_SCP => 
        VCC_net_1, MDIF => VCC_net_1, MGPIO0A_F2H_GPIN => 
        VCC_net_1, MGPIO10A_F2H_GPIN => VCC_net_1, 
        MGPIO11A_F2H_GPIN => VCC_net_1, MGPIO11B_F2H_GPIN => 
        VCC_net_1, MGPIO12A_F2H_GPIN => VCC_net_1, 
        MGPIO13A_F2H_GPIN => VCC_net_1, MGPIO14A_F2H_GPIN => 
        VCC_net_1, MGPIO15A_F2H_GPIN => VCC_net_1, 
        MGPIO16A_F2H_GPIN => VCC_net_1, MGPIO17B_F2H_GPIN => 
        VCC_net_1, MGPIO18B_F2H_GPIN => VCC_net_1, 
        MGPIO19B_F2H_GPIN => VCC_net_1, MGPIO1A_F2H_GPIN => 
        VCC_net_1, MGPIO20B_F2H_GPIN => VCC_net_1, 
        MGPIO21B_F2H_GPIN => VCC_net_1, MGPIO22B_F2H_GPIN => 
        VCC_net_1, MGPIO24B_F2H_GPIN => VCC_net_1, 
        MGPIO25B_F2H_GPIN => VCC_net_1, MGPIO26B_F2H_GPIN => 
        VCC_net_1, MGPIO27B_F2H_GPIN => VCC_net_1, 
        MGPIO28B_F2H_GPIN => VCC_net_1, MGPIO29B_F2H_GPIN => 
        VCC_net_1, MGPIO2A_F2H_GPIN => VCC_net_1, 
        MGPIO30B_F2H_GPIN => VCC_net_1, MGPIO31B_F2H_GPIN => 
        VCC_net_1, MGPIO3A_F2H_GPIN => VCC_net_1, 
        MGPIO4A_F2H_GPIN => VCC_net_1, MGPIO5A_F2H_GPIN => 
        VCC_net_1, MGPIO6A_F2H_GPIN => VCC_net_1, 
        MGPIO7A_F2H_GPIN => VCC_net_1, MGPIO8A_F2H_GPIN => 
        VCC_net_1, MGPIO9A_F2H_GPIN => VCC_net_1, 
        MMUART0_CTS_F2H_SCP => VCC_net_1, MMUART0_DCD_F2H_SCP => 
        VCC_net_1, MMUART0_DSR_F2H_SCP => VCC_net_1, 
        MMUART0_DTR_F2H_SCP => VCC_net_1, MMUART0_RI_F2H_SCP => 
        VCC_net_1, MMUART0_RTS_F2H_SCP => VCC_net_1, 
        MMUART0_RXD_F2H_SCP => VCC_net_1, MMUART0_SCK_F2H_SCP => 
        VCC_net_1, MMUART0_TXD_F2H_SCP => VCC_net_1, 
        MMUART1_CTS_F2H_SCP => VCC_net_1, MMUART1_DCD_F2H_SCP => 
        VCC_net_1, MMUART1_DSR_F2H_SCP => VCC_net_1, 
        MMUART1_RI_F2H_SCP => VCC_net_1, MMUART1_RTS_F2H_SCP => 
        VCC_net_1, MMUART1_RXD_F2H_SCP => VCC_net_1, 
        MMUART1_SCK_F2H_SCP => VCC_net_1, MMUART1_TXD_F2H_SCP => 
        VCC_net_1, PER2_FABRIC_PRDATA(31) => GND_net_1, 
        PER2_FABRIC_PRDATA(30) => GND_net_1, 
        PER2_FABRIC_PRDATA(29) => GND_net_1, 
        PER2_FABRIC_PRDATA(28) => GND_net_1, 
        PER2_FABRIC_PRDATA(27) => GND_net_1, 
        PER2_FABRIC_PRDATA(26) => GND_net_1, 
        PER2_FABRIC_PRDATA(25) => GND_net_1, 
        PER2_FABRIC_PRDATA(24) => GND_net_1, 
        PER2_FABRIC_PRDATA(23) => GND_net_1, 
        PER2_FABRIC_PRDATA(22) => GND_net_1, 
        PER2_FABRIC_PRDATA(21) => GND_net_1, 
        PER2_FABRIC_PRDATA(20) => GND_net_1, 
        PER2_FABRIC_PRDATA(19) => GND_net_1, 
        PER2_FABRIC_PRDATA(18) => GND_net_1, 
        PER2_FABRIC_PRDATA(17) => GND_net_1, 
        PER2_FABRIC_PRDATA(16) => GND_net_1, 
        PER2_FABRIC_PRDATA(15) => GND_net_1, 
        PER2_FABRIC_PRDATA(14) => GND_net_1, 
        PER2_FABRIC_PRDATA(13) => GND_net_1, 
        PER2_FABRIC_PRDATA(12) => GND_net_1, 
        PER2_FABRIC_PRDATA(11) => GND_net_1, 
        PER2_FABRIC_PRDATA(10) => GND_net_1, 
        PER2_FABRIC_PRDATA(9) => GND_net_1, PER2_FABRIC_PRDATA(8)
         => GND_net_1, PER2_FABRIC_PRDATA(7) => GND_net_1, 
        PER2_FABRIC_PRDATA(6) => GND_net_1, PER2_FABRIC_PRDATA(5)
         => GND_net_1, PER2_FABRIC_PRDATA(4) => GND_net_1, 
        PER2_FABRIC_PRDATA(3) => GND_net_1, PER2_FABRIC_PRDATA(2)
         => GND_net_1, PER2_FABRIC_PRDATA(1) => GND_net_1, 
        PER2_FABRIC_PRDATA(0) => GND_net_1, PER2_FABRIC_PREADY
         => VCC_net_1, PER2_FABRIC_PSLVERR => GND_net_1, RCGF(9)
         => VCC_net_1, RCGF(8) => VCC_net_1, RCGF(7) => VCC_net_1, 
        RCGF(6) => VCC_net_1, RCGF(5) => VCC_net_1, RCGF(4) => 
        VCC_net_1, RCGF(3) => VCC_net_1, RCGF(2) => VCC_net_1, 
        RCGF(1) => VCC_net_1, RCGF(0) => VCC_net_1, RX_CLKPF => 
        VCC_net_1, RX_DVF => VCC_net_1, RX_ERRF => VCC_net_1, 
        RX_EV => VCC_net_1, RXDF(7) => VCC_net_1, RXDF(6) => 
        VCC_net_1, RXDF(5) => VCC_net_1, RXDF(4) => VCC_net_1, 
        RXDF(3) => VCC_net_1, RXDF(2) => VCC_net_1, RXDF(1) => 
        VCC_net_1, RXDF(0) => VCC_net_1, SLEEPHOLDREQ => 
        GND_net_1, SMBALERT_NI0 => VCC_net_1, SMBALERT_NI1 => 
        VCC_net_1, SMBSUS_NI0 => VCC_net_1, SMBSUS_NI1 => 
        VCC_net_1, SPI0_CLK_IN => VCC_net_1, SPI0_SDI_F2H_SCP => 
        VCC_net_1, SPI0_SDO_F2H_SCP => VCC_net_1, 
        SPI0_SS0_F2H_SCP => VCC_net_1, SPI0_SS1_F2H_SCP => 
        VCC_net_1, SPI0_SS2_F2H_SCP => VCC_net_1, 
        SPI0_SS3_F2H_SCP => VCC_net_1, SPI1_CLK_IN => VCC_net_1, 
        SPI1_SDI_F2H_SCP => VCC_net_1, SPI1_SDO_F2H_SCP => 
        VCC_net_1, SPI1_SS0_F2H_SCP => VCC_net_1, 
        SPI1_SS1_F2H_SCP => VCC_net_1, SPI1_SS2_F2H_SCP => 
        VCC_net_1, SPI1_SS3_F2H_SCP => VCC_net_1, TX_CLKPF => 
        VCC_net_1, USER_MSS_GPIO_RESET_N => VCC_net_1, 
        USER_MSS_RESET_N => VCC_net_1, XCLK_FAB => VCC_net_1, 
        CLK_BASE => sha256_system_sb_0_FIC_0_CLK, CLK_MDDR_APB
         => VCC_net_1, F_ARADDR_HADDR1(31) => VCC_net_1, 
        F_ARADDR_HADDR1(30) => VCC_net_1, F_ARADDR_HADDR1(29) => 
        VCC_net_1, F_ARADDR_HADDR1(28) => VCC_net_1, 
        F_ARADDR_HADDR1(27) => VCC_net_1, F_ARADDR_HADDR1(26) => 
        VCC_net_1, F_ARADDR_HADDR1(25) => VCC_net_1, 
        F_ARADDR_HADDR1(24) => VCC_net_1, F_ARADDR_HADDR1(23) => 
        VCC_net_1, F_ARADDR_HADDR1(22) => VCC_net_1, 
        F_ARADDR_HADDR1(21) => VCC_net_1, F_ARADDR_HADDR1(20) => 
        VCC_net_1, F_ARADDR_HADDR1(19) => VCC_net_1, 
        F_ARADDR_HADDR1(18) => VCC_net_1, F_ARADDR_HADDR1(17) => 
        VCC_net_1, F_ARADDR_HADDR1(16) => VCC_net_1, 
        F_ARADDR_HADDR1(15) => VCC_net_1, F_ARADDR_HADDR1(14) => 
        VCC_net_1, F_ARADDR_HADDR1(13) => VCC_net_1, 
        F_ARADDR_HADDR1(12) => VCC_net_1, F_ARADDR_HADDR1(11) => 
        VCC_net_1, F_ARADDR_HADDR1(10) => VCC_net_1, 
        F_ARADDR_HADDR1(9) => VCC_net_1, F_ARADDR_HADDR1(8) => 
        VCC_net_1, F_ARADDR_HADDR1(7) => VCC_net_1, 
        F_ARADDR_HADDR1(6) => VCC_net_1, F_ARADDR_HADDR1(5) => 
        VCC_net_1, F_ARADDR_HADDR1(4) => VCC_net_1, 
        F_ARADDR_HADDR1(3) => VCC_net_1, F_ARADDR_HADDR1(2) => 
        VCC_net_1, F_ARADDR_HADDR1(1) => VCC_net_1, 
        F_ARADDR_HADDR1(0) => VCC_net_1, F_ARBURST_HTRANS1(1) => 
        GND_net_1, F_ARBURST_HTRANS1(0) => GND_net_1, 
        F_ARID_HSEL1(3) => GND_net_1, F_ARID_HSEL1(2) => 
        GND_net_1, F_ARID_HSEL1(1) => GND_net_1, F_ARID_HSEL1(0)
         => GND_net_1, F_ARLEN_HBURST1(3) => GND_net_1, 
        F_ARLEN_HBURST1(2) => GND_net_1, F_ARLEN_HBURST1(1) => 
        GND_net_1, F_ARLEN_HBURST1(0) => GND_net_1, 
        F_ARLOCK_HMASTLOCK1(1) => GND_net_1, 
        F_ARLOCK_HMASTLOCK1(0) => GND_net_1, F_ARSIZE_HSIZE1(1)
         => GND_net_1, F_ARSIZE_HSIZE1(0) => GND_net_1, 
        F_ARVALID_HWRITE1 => GND_net_1, F_AWADDR_HADDR0(31) => 
        VCC_net_1, F_AWADDR_HADDR0(30) => VCC_net_1, 
        F_AWADDR_HADDR0(29) => VCC_net_1, F_AWADDR_HADDR0(28) => 
        VCC_net_1, F_AWADDR_HADDR0(27) => VCC_net_1, 
        F_AWADDR_HADDR0(26) => VCC_net_1, F_AWADDR_HADDR0(25) => 
        VCC_net_1, F_AWADDR_HADDR0(24) => VCC_net_1, 
        F_AWADDR_HADDR0(23) => VCC_net_1, F_AWADDR_HADDR0(22) => 
        VCC_net_1, F_AWADDR_HADDR0(21) => VCC_net_1, 
        F_AWADDR_HADDR0(20) => VCC_net_1, F_AWADDR_HADDR0(19) => 
        VCC_net_1, F_AWADDR_HADDR0(18) => VCC_net_1, 
        F_AWADDR_HADDR0(17) => VCC_net_1, F_AWADDR_HADDR0(16) => 
        VCC_net_1, F_AWADDR_HADDR0(15) => VCC_net_1, 
        F_AWADDR_HADDR0(14) => VCC_net_1, F_AWADDR_HADDR0(13) => 
        VCC_net_1, F_AWADDR_HADDR0(12) => VCC_net_1, 
        F_AWADDR_HADDR0(11) => VCC_net_1, F_AWADDR_HADDR0(10) => 
        VCC_net_1, F_AWADDR_HADDR0(9) => VCC_net_1, 
        F_AWADDR_HADDR0(8) => VCC_net_1, F_AWADDR_HADDR0(7) => 
        VCC_net_1, F_AWADDR_HADDR0(6) => VCC_net_1, 
        F_AWADDR_HADDR0(5) => VCC_net_1, F_AWADDR_HADDR0(4) => 
        VCC_net_1, F_AWADDR_HADDR0(3) => VCC_net_1, 
        F_AWADDR_HADDR0(2) => VCC_net_1, F_AWADDR_HADDR0(1) => 
        VCC_net_1, F_AWADDR_HADDR0(0) => VCC_net_1, 
        F_AWBURST_HTRANS0(1) => GND_net_1, F_AWBURST_HTRANS0(0)
         => GND_net_1, F_AWID_HSEL0(3) => GND_net_1, 
        F_AWID_HSEL0(2) => GND_net_1, F_AWID_HSEL0(1) => 
        GND_net_1, F_AWID_HSEL0(0) => GND_net_1, 
        F_AWLEN_HBURST0(3) => GND_net_1, F_AWLEN_HBURST0(2) => 
        GND_net_1, F_AWLEN_HBURST0(1) => GND_net_1, 
        F_AWLEN_HBURST0(0) => GND_net_1, F_AWLOCK_HMASTLOCK0(1)
         => GND_net_1, F_AWLOCK_HMASTLOCK0(0) => GND_net_1, 
        F_AWSIZE_HSIZE0(1) => GND_net_1, F_AWSIZE_HSIZE0(0) => 
        GND_net_1, F_AWVALID_HWRITE0 => GND_net_1, F_BREADY => 
        GND_net_1, F_RMW_AXI => GND_net_1, F_RREADY => GND_net_1, 
        F_WDATA_HWDATA01(63) => VCC_net_1, F_WDATA_HWDATA01(62)
         => VCC_net_1, F_WDATA_HWDATA01(61) => VCC_net_1, 
        F_WDATA_HWDATA01(60) => VCC_net_1, F_WDATA_HWDATA01(59)
         => VCC_net_1, F_WDATA_HWDATA01(58) => VCC_net_1, 
        F_WDATA_HWDATA01(57) => VCC_net_1, F_WDATA_HWDATA01(56)
         => VCC_net_1, F_WDATA_HWDATA01(55) => VCC_net_1, 
        F_WDATA_HWDATA01(54) => VCC_net_1, F_WDATA_HWDATA01(53)
         => VCC_net_1, F_WDATA_HWDATA01(52) => VCC_net_1, 
        F_WDATA_HWDATA01(51) => VCC_net_1, F_WDATA_HWDATA01(50)
         => VCC_net_1, F_WDATA_HWDATA01(49) => VCC_net_1, 
        F_WDATA_HWDATA01(48) => VCC_net_1, F_WDATA_HWDATA01(47)
         => VCC_net_1, F_WDATA_HWDATA01(46) => VCC_net_1, 
        F_WDATA_HWDATA01(45) => VCC_net_1, F_WDATA_HWDATA01(44)
         => VCC_net_1, F_WDATA_HWDATA01(43) => VCC_net_1, 
        F_WDATA_HWDATA01(42) => VCC_net_1, F_WDATA_HWDATA01(41)
         => VCC_net_1, F_WDATA_HWDATA01(40) => VCC_net_1, 
        F_WDATA_HWDATA01(39) => VCC_net_1, F_WDATA_HWDATA01(38)
         => VCC_net_1, F_WDATA_HWDATA01(37) => VCC_net_1, 
        F_WDATA_HWDATA01(36) => VCC_net_1, F_WDATA_HWDATA01(35)
         => VCC_net_1, F_WDATA_HWDATA01(34) => VCC_net_1, 
        F_WDATA_HWDATA01(33) => VCC_net_1, F_WDATA_HWDATA01(32)
         => VCC_net_1, F_WDATA_HWDATA01(31) => VCC_net_1, 
        F_WDATA_HWDATA01(30) => VCC_net_1, F_WDATA_HWDATA01(29)
         => VCC_net_1, F_WDATA_HWDATA01(28) => VCC_net_1, 
        F_WDATA_HWDATA01(27) => VCC_net_1, F_WDATA_HWDATA01(26)
         => VCC_net_1, F_WDATA_HWDATA01(25) => VCC_net_1, 
        F_WDATA_HWDATA01(24) => VCC_net_1, F_WDATA_HWDATA01(23)
         => VCC_net_1, F_WDATA_HWDATA01(22) => VCC_net_1, 
        F_WDATA_HWDATA01(21) => VCC_net_1, F_WDATA_HWDATA01(20)
         => VCC_net_1, F_WDATA_HWDATA01(19) => VCC_net_1, 
        F_WDATA_HWDATA01(18) => VCC_net_1, F_WDATA_HWDATA01(17)
         => VCC_net_1, F_WDATA_HWDATA01(16) => VCC_net_1, 
        F_WDATA_HWDATA01(15) => VCC_net_1, F_WDATA_HWDATA01(14)
         => VCC_net_1, F_WDATA_HWDATA01(13) => VCC_net_1, 
        F_WDATA_HWDATA01(12) => VCC_net_1, F_WDATA_HWDATA01(11)
         => VCC_net_1, F_WDATA_HWDATA01(10) => VCC_net_1, 
        F_WDATA_HWDATA01(9) => VCC_net_1, F_WDATA_HWDATA01(8) => 
        VCC_net_1, F_WDATA_HWDATA01(7) => VCC_net_1, 
        F_WDATA_HWDATA01(6) => VCC_net_1, F_WDATA_HWDATA01(5) => 
        VCC_net_1, F_WDATA_HWDATA01(4) => VCC_net_1, 
        F_WDATA_HWDATA01(3) => VCC_net_1, F_WDATA_HWDATA01(2) => 
        VCC_net_1, F_WDATA_HWDATA01(1) => VCC_net_1, 
        F_WDATA_HWDATA01(0) => VCC_net_1, F_WID_HREADY01(3) => 
        GND_net_1, F_WID_HREADY01(2) => GND_net_1, 
        F_WID_HREADY01(1) => GND_net_1, F_WID_HREADY01(0) => 
        GND_net_1, F_WLAST => GND_net_1, F_WSTRB(7) => GND_net_1, 
        F_WSTRB(6) => GND_net_1, F_WSTRB(5) => GND_net_1, 
        F_WSTRB(4) => GND_net_1, F_WSTRB(3) => GND_net_1, 
        F_WSTRB(2) => GND_net_1, F_WSTRB(1) => GND_net_1, 
        F_WSTRB(0) => GND_net_1, F_WVALID => GND_net_1, 
        FPGA_MDDR_ARESET_N => VCC_net_1, MDDR_FABRIC_PADDR(10)
         => VCC_net_1, MDDR_FABRIC_PADDR(9) => VCC_net_1, 
        MDDR_FABRIC_PADDR(8) => VCC_net_1, MDDR_FABRIC_PADDR(7)
         => VCC_net_1, MDDR_FABRIC_PADDR(6) => VCC_net_1, 
        MDDR_FABRIC_PADDR(5) => VCC_net_1, MDDR_FABRIC_PADDR(4)
         => VCC_net_1, MDDR_FABRIC_PADDR(3) => VCC_net_1, 
        MDDR_FABRIC_PADDR(2) => VCC_net_1, MDDR_FABRIC_PENABLE
         => VCC_net_1, MDDR_FABRIC_PSEL => VCC_net_1, 
        MDDR_FABRIC_PWDATA(15) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(14) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(13) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(12) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(11) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(10) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(9) => VCC_net_1, MDDR_FABRIC_PWDATA(8)
         => VCC_net_1, MDDR_FABRIC_PWDATA(7) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(6) => VCC_net_1, MDDR_FABRIC_PWDATA(5)
         => VCC_net_1, MDDR_FABRIC_PWDATA(4) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(3) => VCC_net_1, MDDR_FABRIC_PWDATA(2)
         => VCC_net_1, MDDR_FABRIC_PWDATA(1) => VCC_net_1, 
        MDDR_FABRIC_PWDATA(0) => VCC_net_1, MDDR_FABRIC_PWRITE
         => VCC_net_1, PRESET_N => GND_net_1, 
        CAN_RXBUS_USBA_DATA1_MGPIO3A_IN => GND_net_1, 
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN => GND_net_1, 
        CAN_TXBUS_USBA_DATA0_MGPIO2A_IN => GND_net_1, DM_IN(2)
         => GND_net_1, DM_IN(1) => GND_net_1, DM_IN(0) => 
        GND_net_1, DRAM_DQ_IN(17) => GND_net_1, DRAM_DQ_IN(16)
         => GND_net_1, DRAM_DQ_IN(15) => GND_net_1, 
        DRAM_DQ_IN(14) => GND_net_1, DRAM_DQ_IN(13) => GND_net_1, 
        DRAM_DQ_IN(12) => GND_net_1, DRAM_DQ_IN(11) => GND_net_1, 
        DRAM_DQ_IN(10) => GND_net_1, DRAM_DQ_IN(9) => GND_net_1, 
        DRAM_DQ_IN(8) => GND_net_1, DRAM_DQ_IN(7) => GND_net_1, 
        DRAM_DQ_IN(6) => GND_net_1, DRAM_DQ_IN(5) => GND_net_1, 
        DRAM_DQ_IN(4) => GND_net_1, DRAM_DQ_IN(3) => GND_net_1, 
        DRAM_DQ_IN(2) => GND_net_1, DRAM_DQ_IN(1) => GND_net_1, 
        DRAM_DQ_IN(0) => GND_net_1, DRAM_DQS_IN(2) => GND_net_1, 
        DRAM_DQS_IN(1) => GND_net_1, DRAM_DQS_IN(0) => GND_net_1, 
        DRAM_FIFO_WE_IN(1) => GND_net_1, DRAM_FIFO_WE_IN(0) => 
        GND_net_1, I2C0_SCL_USBC_DATA1_MGPIO31B_IN => GND_net_1, 
        I2C0_SDA_USBC_DATA0_MGPIO30B_IN => GND_net_1, 
        I2C1_SCL_USBA_DATA4_MGPIO1A_IN => GND_net_1, 
        I2C1_SDA_USBA_DATA3_MGPIO0A_IN => GND_net_1, MGPIO0B_IN
         => GND_net_1, MGPIO10B_IN => GND_net_1, MGPIO1B_IN => 
        GND_net_1, MGPIO25A_IN => GND_net_1, MGPIO26A_IN => 
        GND_net_1, MGPIO27A_IN => GND_net_1, MGPIO28A_IN => 
        GND_net_1, MGPIO29A_IN => GND_net_1, MGPIO2B_IN => 
        GND_net_1, MGPIO30A_IN => GND_net_1, MGPIO31A_IN => 
        GND_net_1, MGPIO3B_IN => GND_net_1, MGPIO4B_IN => 
        GND_net_1, MGPIO5B_IN => GND_net_1, MGPIO6B_IN => 
        GND_net_1, MGPIO7B_IN => GND_net_1, MGPIO8B_IN => 
        GND_net_1, MGPIO9B_IN => GND_net_1, 
        MMUART0_CTS_USBC_DATA7_MGPIO19B_IN => GND_net_1, 
        MMUART0_DCD_MGPIO22B_IN => GND_net_1, 
        MMUART0_DSR_MGPIO20B_IN => GND_net_1, 
        MMUART0_DTR_USBC_DATA6_MGPIO18B_IN => GND_net_1, 
        MMUART0_RI_MGPIO21B_IN => GND_net_1, 
        MMUART0_RTS_USBC_DATA5_MGPIO17B_IN => GND_net_1, 
        MMUART0_RXD_USBC_STP_MGPIO28B_IN => GND_net_1, 
        MMUART0_SCK_USBC_NXT_MGPIO29B_IN => GND_net_1, 
        MMUART0_TXD_USBC_DIR_MGPIO27B_IN => GND_net_1, 
        MMUART1_CTS_MGPIO13B_IN => GND_net_1, 
        MMUART1_DCD_MGPIO16B_IN => GND_net_1, 
        MMUART1_DSR_MGPIO14B_IN => GND_net_1, 
        MMUART1_DTR_MGPIO12B_IN => GND_net_1, 
        MMUART1_RI_MGPIO15B_IN => GND_net_1, 
        MMUART1_RTS_MGPIO11B_IN => GND_net_1, 
        MMUART1_RXD_USBC_DATA3_MGPIO26B_IN => GND_net_1, 
        MMUART1_SCK_USBC_DATA4_MGPIO25B_IN => GND_net_1, 
        MMUART1_TXD_USBC_DATA2_MGPIO24B_IN => GND_net_1, 
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN => GND_net_1, 
        RGMII_MDC_RMII_MDC_IN => GND_net_1, 
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN => GND_net_1, 
        RGMII_RX_CLK_IN => GND_net_1, 
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN => GND_net_1, 
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN => GND_net_1, 
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN => GND_net_1, 
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN => GND_net_1, 
        RGMII_RXD3_USBB_DATA4_IN => GND_net_1, RGMII_TX_CLK_IN
         => GND_net_1, RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN => 
        GND_net_1, RGMII_TXD0_RMII_TXD0_USBB_DIR_IN => GND_net_1, 
        RGMII_TXD1_RMII_TXD1_USBB_STP_IN => GND_net_1, 
        RGMII_TXD2_USBB_DATA5_IN => GND_net_1, 
        RGMII_TXD3_USBB_DATA6_IN => GND_net_1, 
        SPI0_SCK_USBA_XCLK_IN => GND_net_1, 
        SPI0_SDI_USBA_DIR_MGPIO5A_IN => GND_net_1, 
        SPI0_SDO_USBA_STP_MGPIO6A_IN => GND_net_1, 
        SPI0_SS0_USBA_NXT_MGPIO7A_IN => GND_net_1, 
        SPI0_SS1_USBA_DATA5_MGPIO8A_IN => GND_net_1, 
        SPI0_SS2_USBA_DATA6_MGPIO9A_IN => GND_net_1, 
        SPI0_SS3_USBA_DATA7_MGPIO10A_IN => GND_net_1, 
        SPI0_SS4_MGPIO19A_IN => GND_net_1, SPI0_SS5_MGPIO20A_IN
         => GND_net_1, SPI0_SS6_MGPIO21A_IN => GND_net_1, 
        SPI0_SS7_MGPIO22A_IN => GND_net_1, SPI1_SCK_IN => 
        GND_net_1, SPI1_SDI_MGPIO11A_IN => GND_net_1, 
        SPI1_SDO_MGPIO12A_IN => GND_net_1, SPI1_SS0_MGPIO13A_IN
         => GND_net_1, SPI1_SS1_MGPIO14A_IN => GND_net_1, 
        SPI1_SS2_MGPIO15A_IN => GND_net_1, SPI1_SS3_MGPIO16A_IN
         => GND_net_1, SPI1_SS4_MGPIO17A_IN => GND_net_1, 
        SPI1_SS5_MGPIO18A_IN => GND_net_1, SPI1_SS6_MGPIO23A_IN
         => GND_net_1, SPI1_SS7_MGPIO24A_IN => GND_net_1, 
        USBC_XCLK_IN => GND_net_1, USBD_DATA0_IN => GND_net_1, 
        USBD_DATA1_IN => GND_net_1, USBD_DATA2_IN => GND_net_1, 
        USBD_DATA3_IN => GND_net_1, USBD_DATA4_IN => GND_net_1, 
        USBD_DATA5_IN => GND_net_1, USBD_DATA6_IN => GND_net_1, 
        USBD_DATA7_MGPIO23B_IN => GND_net_1, USBD_DIR_IN => 
        GND_net_1, USBD_NXT_IN => GND_net_1, USBD_STP_IN => 
        GND_net_1, USBD_XCLK_IN => GND_net_1, 
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT => OPEN, 
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT => OPEN, 
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT => OPEN, DRAM_ADDR(15)
         => nc93, DRAM_ADDR(14) => nc262, DRAM_ADDR(13) => nc69, 
        DRAM_ADDR(12) => nc206, DRAM_ADDR(11) => nc174, 
        DRAM_ADDR(10) => nc38, DRAM_ADDR(9) => nc113, 
        DRAM_ADDR(8) => nc218, DRAM_ADDR(7) => nc106, 
        DRAM_ADDR(6) => nc261, DRAM_ADDR(5) => nc25, DRAM_ADDR(4)
         => nc1, DRAM_ADDR(3) => nc322, DRAM_ADDR(2) => nc299, 
        DRAM_ADDR(1) => nc37, DRAM_ADDR(0) => nc202, DRAM_BA(2)
         => nc144, DRAM_BA(1) => nc153, DRAM_BA(0) => nc46, 
        DRAM_CASN => OPEN, DRAM_CKE => OPEN, DRAM_CLK => OPEN, 
        DRAM_CSN => OPEN, DRAM_DM_RDQS_OUT(2) => nc258, 
        DRAM_DM_RDQS_OUT(1) => nc71, DRAM_DM_RDQS_OUT(0) => nc124, 
        DRAM_DQ_OUT(17) => nc81, DRAM_DQ_OUT(16) => nc201, 
        DRAM_DQ_OUT(15) => nc168, DRAM_DQ_OUT(14) => nc323, 
        DRAM_DQ_OUT(13) => nc34, DRAM_DQ_OUT(12) => nc28, 
        DRAM_DQ_OUT(11) => nc115, DRAM_DQ_OUT(10) => nc264, 
        DRAM_DQ_OUT(9) => nc192, DRAM_DQ_OUT(8) => nc319, 
        DRAM_DQ_OUT(7) => nc134, DRAM_DQ_OUT(6) => nc32, 
        DRAM_DQ_OUT(5) => nc40, DRAM_DQ_OUT(4) => nc297, 
        DRAM_DQ_OUT(3) => nc99, DRAM_DQ_OUT(2) => nc75, 
        DRAM_DQ_OUT(1) => nc183, DRAM_DQ_OUT(0) => nc288, 
        DRAM_DQS_OUT(2) => nc85, DRAM_DQS_OUT(1) => nc27, 
        DRAM_DQS_OUT(0) => nc108, DRAM_FIFO_WE_OUT(1) => nc16, 
        DRAM_FIFO_WE_OUT(0) => nc155, DRAM_ODT => OPEN, DRAM_RASN
         => OPEN, DRAM_RSTN => OPEN, DRAM_WEN => OPEN, 
        I2C0_SCL_USBC_DATA1_MGPIO31B_OUT => OPEN, 
        I2C0_SDA_USBC_DATA0_MGPIO30B_OUT => OPEN, 
        I2C1_SCL_USBA_DATA4_MGPIO1A_OUT => OPEN, 
        I2C1_SDA_USBA_DATA3_MGPIO0A_OUT => 
        MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OUT, 
        MGPIO0B_OUT => OPEN, MGPIO10B_OUT => OPEN, MGPIO1B_OUT
         => OPEN, MGPIO25A_OUT => OPEN, MGPIO26A_OUT => OPEN, 
        MGPIO27A_OUT => OPEN, MGPIO28A_OUT => OPEN, MGPIO29A_OUT
         => OPEN, MGPIO2B_OUT => OPEN, MGPIO30A_OUT => OPEN, 
        MGPIO31A_OUT => OPEN, MGPIO3B_OUT => OPEN, MGPIO4B_OUT
         => OPEN, MGPIO5B_OUT => OPEN, MGPIO6B_OUT => OPEN, 
        MGPIO7B_OUT => OPEN, MGPIO8B_OUT => OPEN, MGPIO9B_OUT => 
        OPEN, MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT => OPEN, 
        MMUART0_DCD_MGPIO22B_OUT => OPEN, 
        MMUART0_DSR_MGPIO20B_OUT => OPEN, 
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT => OPEN, 
        MMUART0_RI_MGPIO21B_OUT => OPEN, 
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT => OPEN, 
        MMUART0_RXD_USBC_STP_MGPIO28B_OUT => OPEN, 
        MMUART0_SCK_USBC_NXT_MGPIO29B_OUT => OPEN, 
        MMUART0_TXD_USBC_DIR_MGPIO27B_OUT => OPEN, 
        MMUART1_CTS_MGPIO13B_OUT => OPEN, 
        MMUART1_DCD_MGPIO16B_OUT => OPEN, 
        MMUART1_DSR_MGPIO14B_OUT => OPEN, 
        MMUART1_DTR_MGPIO12B_OUT => OPEN, MMUART1_RI_MGPIO15B_OUT
         => OPEN, MMUART1_RTS_MGPIO11B_OUT => OPEN, 
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT => OPEN, 
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT => OPEN, 
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT => OPEN, 
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT => OPEN, 
        RGMII_MDC_RMII_MDC_OUT => OPEN, 
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT => OPEN, 
        RGMII_RX_CLK_OUT => OPEN, 
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT => OPEN, 
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT => OPEN, 
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT => OPEN, 
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT => OPEN, 
        RGMII_RXD3_USBB_DATA4_OUT => OPEN, RGMII_TX_CLK_OUT => 
        OPEN, RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT => OPEN, 
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT => OPEN, 
        RGMII_TXD1_RMII_TXD1_USBB_STP_OUT => OPEN, 
        RGMII_TXD2_USBB_DATA5_OUT => OPEN, 
        RGMII_TXD3_USBB_DATA6_OUT => OPEN, SPI0_SCK_USBA_XCLK_OUT
         => OPEN, SPI0_SDI_USBA_DIR_MGPIO5A_OUT => OPEN, 
        SPI0_SDO_USBA_STP_MGPIO6A_OUT => OPEN, 
        SPI0_SS0_USBA_NXT_MGPIO7A_OUT => OPEN, 
        SPI0_SS1_USBA_DATA5_MGPIO8A_OUT => OPEN, 
        SPI0_SS2_USBA_DATA6_MGPIO9A_OUT => OPEN, 
        SPI0_SS3_USBA_DATA7_MGPIO10A_OUT => OPEN, 
        SPI0_SS4_MGPIO19A_OUT => OPEN, SPI0_SS5_MGPIO20A_OUT => 
        OPEN, SPI0_SS6_MGPIO21A_OUT => OPEN, 
        SPI0_SS7_MGPIO22A_OUT => OPEN, SPI1_SCK_OUT => OPEN, 
        SPI1_SDI_MGPIO11A_OUT => OPEN, SPI1_SDO_MGPIO12A_OUT => 
        OPEN, SPI1_SS0_MGPIO13A_OUT => OPEN, 
        SPI1_SS1_MGPIO14A_OUT => OPEN, SPI1_SS2_MGPIO15A_OUT => 
        OPEN, SPI1_SS3_MGPIO16A_OUT => OPEN, 
        SPI1_SS4_MGPIO17A_OUT => OPEN, SPI1_SS5_MGPIO18A_OUT => 
        OPEN, SPI1_SS6_MGPIO23A_OUT => OPEN, 
        SPI1_SS7_MGPIO24A_OUT => OPEN, USBC_XCLK_OUT => OPEN, 
        USBD_DATA0_OUT => OPEN, USBD_DATA1_OUT => OPEN, 
        USBD_DATA2_OUT => OPEN, USBD_DATA3_OUT => OPEN, 
        USBD_DATA4_OUT => OPEN, USBD_DATA5_OUT => OPEN, 
        USBD_DATA6_OUT => OPEN, USBD_DATA7_MGPIO23B_OUT => OPEN, 
        USBD_DIR_OUT => OPEN, USBD_NXT_OUT => OPEN, USBD_STP_OUT
         => OPEN, USBD_XCLK_OUT => OPEN, 
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OE => OPEN, 
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE => OPEN, 
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OE => OPEN, DM_OE(2) => nc51, 
        DM_OE(1) => nc301, DM_OE(0) => nc33, DRAM_DQ_OE(17) => 
        nc204, DRAM_DQ_OE(16) => nc173, DRAM_DQ_OE(15) => nc278, 
        DRAM_DQ_OE(14) => nc169, DRAM_DQ_OE(13) => nc78, 
        DRAM_DQ_OE(12) => nc263, DRAM_DQ_OE(11) => nc24, 
        DRAM_DQ_OE(10) => nc88, DRAM_DQ_OE(9) => nc111, 
        DRAM_DQ_OE(8) => nc55, DRAM_DQ_OE(7) => nc10, 
        DRAM_DQ_OE(6) => nc22, DRAM_DQ_OE(5) => nc210, 
        DRAM_DQ_OE(4) => nc185, DRAM_DQ_OE(3) => nc143, 
        DRAM_DQ_OE(2) => nc248, DRAM_DQ_OE(1) => nc77, 
        DRAM_DQ_OE(0) => nc6, DRAM_DQS_OE(2) => nc109, 
        DRAM_DQS_OE(1) => nc87, DRAM_DQS_OE(0) => nc123, 
        I2C0_SCL_USBC_DATA1_MGPIO31B_OE => OPEN, 
        I2C0_SDA_USBC_DATA0_MGPIO30B_OE => OPEN, 
        I2C1_SCL_USBA_DATA4_MGPIO1A_OE => OPEN, 
        I2C1_SDA_USBA_DATA3_MGPIO0A_OE => OPEN, MGPIO0B_OE => 
        OPEN, MGPIO10B_OE => OPEN, MGPIO1B_OE => OPEN, 
        MGPIO25A_OE => OPEN, MGPIO26A_OE => OPEN, MGPIO27A_OE => 
        OPEN, MGPIO28A_OE => OPEN, MGPIO29A_OE => OPEN, 
        MGPIO2B_OE => OPEN, MGPIO30A_OE => OPEN, MGPIO31A_OE => 
        OPEN, MGPIO3B_OE => OPEN, MGPIO4B_OE => OPEN, MGPIO5B_OE
         => OPEN, MGPIO6B_OE => OPEN, MGPIO7B_OE => OPEN, 
        MGPIO8B_OE => OPEN, MGPIO9B_OE => OPEN, 
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OE => OPEN, 
        MMUART0_DCD_MGPIO22B_OE => OPEN, MMUART0_DSR_MGPIO20B_OE
         => OPEN, MMUART0_DTR_USBC_DATA6_MGPIO18B_OE => OPEN, 
        MMUART0_RI_MGPIO21B_OE => OPEN, 
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OE => OPEN, 
        MMUART0_RXD_USBC_STP_MGPIO28B_OE => OPEN, 
        MMUART0_SCK_USBC_NXT_MGPIO29B_OE => OPEN, 
        MMUART0_TXD_USBC_DIR_MGPIO27B_OE => OPEN, 
        MMUART1_CTS_MGPIO13B_OE => OPEN, MMUART1_DCD_MGPIO16B_OE
         => OPEN, MMUART1_DSR_MGPIO14B_OE => OPEN, 
        MMUART1_DTR_MGPIO12B_OE => OPEN, MMUART1_RI_MGPIO15B_OE
         => OPEN, MMUART1_RTS_MGPIO11B_OE => OPEN, 
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OE => OPEN, 
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OE => OPEN, 
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OE => OPEN, 
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE => OPEN, 
        RGMII_MDC_RMII_MDC_OE => OPEN, 
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE => OPEN, 
        RGMII_RX_CLK_OE => OPEN, 
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE => OPEN, 
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE => OPEN, 
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE => OPEN, 
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE => OPEN, 
        RGMII_RXD3_USBB_DATA4_OE => OPEN, RGMII_TX_CLK_OE => OPEN, 
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE => OPEN, 
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OE => OPEN, 
        RGMII_TXD1_RMII_TXD1_USBB_STP_OE => OPEN, 
        RGMII_TXD2_USBB_DATA5_OE => OPEN, 
        RGMII_TXD3_USBB_DATA6_OE => OPEN, SPI0_SCK_USBA_XCLK_OE
         => OPEN, SPI0_SDI_USBA_DIR_MGPIO5A_OE => OPEN, 
        SPI0_SDO_USBA_STP_MGPIO6A_OE => OPEN, 
        SPI0_SS0_USBA_NXT_MGPIO7A_OE => OPEN, 
        SPI0_SS1_USBA_DATA5_MGPIO8A_OE => OPEN, 
        SPI0_SS2_USBA_DATA6_MGPIO9A_OE => OPEN, 
        SPI0_SS3_USBA_DATA7_MGPIO10A_OE => OPEN, 
        SPI0_SS4_MGPIO19A_OE => OPEN, SPI0_SS5_MGPIO20A_OE => 
        OPEN, SPI0_SS6_MGPIO21A_OE => OPEN, SPI0_SS7_MGPIO22A_OE
         => OPEN, SPI1_SCK_OE => OPEN, SPI1_SDI_MGPIO11A_OE => 
        OPEN, SPI1_SDO_MGPIO12A_OE => OPEN, SPI1_SS0_MGPIO13A_OE
         => OPEN, SPI1_SS1_MGPIO14A_OE => OPEN, 
        SPI1_SS2_MGPIO15A_OE => OPEN, SPI1_SS3_MGPIO16A_OE => 
        OPEN, SPI1_SS4_MGPIO17A_OE => OPEN, SPI1_SS5_MGPIO18A_OE
         => OPEN, SPI1_SS6_MGPIO23A_OE => OPEN, 
        SPI1_SS7_MGPIO24A_OE => OPEN, USBC_XCLK_OE => OPEN, 
        USBD_DATA0_OE => OPEN, USBD_DATA1_OE => OPEN, 
        USBD_DATA2_OE => OPEN, USBD_DATA3_OE => OPEN, 
        USBD_DATA4_OE => OPEN, USBD_DATA5_OE => OPEN, 
        USBD_DATA6_OE => OPEN, USBD_DATA7_MGPIO23B_OE => OPEN, 
        USBD_DIR_OE => OPEN, USBD_NXT_OE => OPEN, USBD_STP_OE => 
        OPEN, USBD_XCLK_OE => OPEN);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    GPIO_GPIO_0_OUT_PAD : OUTBUF
      port map(D => 
        MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OUT, PAD => 
        GPIO_0_OUT);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_FABOSC_0_OSC is

    port( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : out   std_logic
        );

end sha256_system_sb_FABOSC_0_OSC;

architecture DEF_ARCH of sha256_system_sb_FABOSC_0_OSC is 

  component RCOSC_25_50MHZ
    generic (FREQUENCY:real := 50.0);

    port( CLKOUT : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal GND_net_1, VCC_net_1 : std_logic;

begin 


    I_RCOSC_25_50MHZ : RCOSC_25_50MHZ
      generic map(FREQUENCY => 50.0)

      port map(CLKOUT => 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity CoreResetP is

    port( MSS_READY                                       : out   std_logic;
          sha256_system_sb_0_FIC_0_CLK                    : in    std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N             : in    std_logic;
          sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F      : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N : in    std_logic
        );

end CoreResetP;

architecture DEF_ARCH of CoreResetP is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \MSS_HPMS_READY_int\, \mss_ready_select\, VCC_net_1, 
        \POWER_ON_RESET_N_clk_base\, 
        \un6_fic_2_apb_m_preset_n_clk_base\, GND_net_1, 
        \mss_ready_state\, \RESET_N_M2F_clk_base\, 
        \POWER_ON_RESET_N_q1\, \RESET_N_M2F_q1\, 
        \FIC_2_APB_M_PRESET_N_q1\, 
        \FIC_2_APB_M_PRESET_N_clk_base\, \MSS_HPMS_READY_int_3\
         : std_logic;

begin 


    RESET_N_M2F_clk_base : SLE
      port map(D => \RESET_N_M2F_q1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \RESET_N_M2F_clk_base\);
    
    POWER_ON_RESET_N_clk_base : SLE
      port map(D => \POWER_ON_RESET_N_q1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \POWER_ON_RESET_N_clk_base\);
    
    mss_ready_select : SLE
      port map(D => VCC_net_1, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        \un6_fic_2_apb_m_preset_n_clk_base\, ALn => 
        \POWER_ON_RESET_N_clk_base\, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \mss_ready_select\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    mss_ready_state : SLE
      port map(D => VCC_net_1, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        \RESET_N_M2F_clk_base\, ALn => 
        \POWER_ON_RESET_N_clk_base\, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \mss_ready_state\);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    un6_fic_2_apb_m_preset_n_clk_base : CFG2
      generic map(INIT => x"8")

      port map(A => \FIC_2_APB_M_PRESET_N_clk_base\, B => 
        \mss_ready_state\, Y => 
        \un6_fic_2_apb_m_preset_n_clk_base\);
    
    RESET_N_M2F_q1 : SLE
      port map(D => VCC_net_1, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \RESET_N_M2F_q1\);
    
    FIC_2_APB_M_PRESET_N_clk_base : SLE
      port map(D => \FIC_2_APB_M_PRESET_N_q1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \FIC_2_APB_M_PRESET_N_clk_base\);
    
    POWER_ON_RESET_N_q1 : SLE
      port map(D => VCC_net_1, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_0_POWER_ON_RESET_N, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \POWER_ON_RESET_N_q1\);
    
    MSS_HPMS_READY_int_RNIFQTF : CLKINT
      port map(A => \MSS_HPMS_READY_int\, Y => MSS_READY);
    
    FIC_2_APB_M_PRESET_N_q1 : SLE
      port map(D => VCC_net_1, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => \FIC_2_APB_M_PRESET_N_q1\);
    
    MSS_HPMS_READY_int_3 : CFG3
      generic map(INIT => x"E0")

      port map(A => \RESET_N_M2F_clk_base\, B => 
        \mss_ready_select\, C => \FIC_2_APB_M_PRESET_N_clk_base\, 
        Y => \MSS_HPMS_READY_int_3\);
    
    MSS_HPMS_READY_int : SLE
      port map(D => \MSS_HPMS_READY_int_3\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        \POWER_ON_RESET_N_clk_base\, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \MSS_HPMS_READY_int\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAHBLITE_SLAVEARBITER is

    port( masterAddrInProg                                  : out   std_logic_vector(3 downto 1);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2           : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                     : out   std_logic_vector(12 to 12);
          xhdl1221                                          : in    std_logic_vector(0 to 0);
          arbRegSMCurrentState_ns_i_a2_0_RNIEVNF            : out   std_logic_vector(0 to 0);
          regHADDR                                          : in    std_logic_vector(26 downto 25);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR : in    std_logic_vector(26 downto 25);
          SADDRSEL_0                                        : in    std_logic_vector(1 to 1);
          M0GATEDHSIZE                                      : in    std_logic_vector(1 downto 0);
          CoreAHBLite_0_AHBmslave0_HSIZE                    : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_14                           : out   std_logic;
          arbRegSMCurrentState_11                           : out   std_logic;
          MSS_READY                                         : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                      : in    std_logic;
          masterRegAddrSel                                  : in    std_logic;
          HWRITE_0_i_o2_2_1                                 : out   std_logic;
          N_99                                              : in    std_logic;
          N_129_i_0                                         : out   std_logic;
          N_112                                             : in    std_logic;
          N_113                                             : in    std_logic;
          g0_1                                              : out   std_logic;
          N_101                                             : out   std_logic
        );

end COREAHBLITE_SLAVEARBITER;

architecture DEF_ARCH of COREAHBLITE_SLAVEARBITER is 

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \arbRegSMCurrentState[1]_net_1\, VCC_net_1, N_126_i_0, 
        GND_net_1, \masterAddrInProg[3]\, N_128_i_0, 
        \arbRegSMCurrentState_14\, N_104_i_0, 
        \arbRegSMCurrentState[14]_net_1\, N_106_i_0, 
        \arbRegSMCurrentState[13]_net_1\, N_108_i_0, 
        \arbRegSMCurrentState_11\, N_110_i_0, 
        \arbRegSMCurrentState[10]_net_1\, 
        \arbRegSMCurrentState_ns[5]_net_1\, 
        \arbRegSMCurrentState[9]_net_1\, N_114_i_0, 
        \masterAddrInProg[1]\, N_116_i_0, 
        \arbRegSMCurrentState[6]_net_1\, 
        \arbRegSMCurrentState_ns[9]_net_1\, 
        \arbRegSMCurrentState[5]_net_1\, N_120_i_0, 
        \masterAddrInProg[2]\, N_122_i_0, 
        \arbRegSMCurrentState[2]_net_1\, 
        \arbRegSMCurrentState_ns[13]_net_1\, 
        N_152_i_i_a2_d_0_a0_2_0, \HWRITE_0_i_o2_2_1\, 
        \arbRegSMCurrentState_RNIGOV71[12]_net_1\, N_106_i_1, 
        N_157, N_156, HWRITE_0_i_o2, \g0_1\ : std_logic;

begin 

    masterAddrInProg(3) <= \masterAddrInProg[3]\;
    masterAddrInProg(2) <= \masterAddrInProg[2]\;
    masterAddrInProg(1) <= \masterAddrInProg[1]\;
    arbRegSMCurrentState_RNIGOV71(12) <= 
        \arbRegSMCurrentState_RNIGOV71[12]_net_1\;
    arbRegSMCurrentState_14 <= \arbRegSMCurrentState_14\;
    arbRegSMCurrentState_11 <= \arbRegSMCurrentState_11\;
    HWRITE_0_i_o2_2_1 <= \HWRITE_0_i_o2_2_1\;
    g0_1 <= \g0_1\;

    \arbRegSMCurrentState_RNO[1]\ : CFG2
      generic map(INIT => x"4")

      port map(A => N_99, B => \masterAddrInProg[3]\, Y => 
        N_126_i_0);
    
    \arbRegSMCurrentState_ns[13]\ : CFG3
      generic map(INIT => x"AE")

      port map(A => \arbRegSMCurrentState[1]_net_1\, B => 
        \arbRegSMCurrentState[2]_net_1\, C => xhdl1221(0), Y => 
        \arbRegSMCurrentState_ns[13]_net_1\);
    
    \arbRegSMCurrentState[12]\ : SLE
      port map(D => N_110_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState_11\);
    
    \arbRegSMCurrentState_ns[9]\ : CFG3
      generic map(INIT => x"AE")

      port map(A => \arbRegSMCurrentState[5]_net_1\, B => 
        \arbRegSMCurrentState[6]_net_1\, C => xhdl1221(0), Y => 
        \arbRegSMCurrentState_ns[9]_net_1\);
    
    \arbRegSMCurrentState[8]\ : SLE
      port map(D => N_116_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \masterAddrInProg[1]\);
    
    \arbRegSMCurrentState[10]\ : SLE
      port map(D => \arbRegSMCurrentState_ns[5]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[10]_net_1\);
    
    \arbRegSMCurrentState_RNITOM54[12]\ : CFG4
      generic map(INIT => x"A888")

      port map(A => M0GATEDHSIZE(0), B => 
        \arbRegSMCurrentState_RNIGOV71[12]_net_1\, C => \g0_1\, D
         => SADDRSEL_0(1), Y => CoreAHBLite_0_AHBmslave0_HSIZE(0));
    
    \arbRegSMCurrentState_ns_i_a2_0_RNIKTJG2[0]\ : CFG3
      generic map(INIT => x"02")

      port map(A => N_152_i_i_a2_d_0_a0_2_0, B => N_112, C => 
        N_113, Y => \g0_1\);
    
    \arbRegSMCurrentState_RNO_0[14]\ : CFG4
      generic map(INIT => x"04A5")

      port map(A => \arbRegSMCurrentState[14]_net_1\, B => N_157, 
        C => N_99, D => xhdl1221(0), Y => N_106_i_1);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \arbRegSMCurrentState_RNO[0]\ : CFG2
      generic map(INIT => x"8")

      port map(A => N_99, B => \masterAddrInProg[3]\, Y => 
        N_128_i_0);
    
    \arbRegSMCurrentState[0]\ : SLE
      port map(D => N_128_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \masterAddrInProg[3]\);
    
    \arbRegSMCurrentState_RNO[12]\ : CFG2
      generic map(INIT => x"8")

      port map(A => N_99, B => \arbRegSMCurrentState_11\, Y => 
        N_110_i_0);
    
    \arbRegSMCurrentState_RNO[15]\ : CFG4
      generic map(INIT => x"B0A0")

      port map(A => \arbRegSMCurrentState_14\, B => N_156, C => 
        N_99, D => xhdl1221(0), Y => N_104_i_0);
    
    \arbRegSMCurrentState_RNO[8]\ : CFG2
      generic map(INIT => x"8")

      port map(A => N_99, B => \masterAddrInProg[1]\, Y => 
        N_116_i_0);
    
    \arbRegSMCurrentState[14]\ : SLE
      port map(D => N_106_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[14]_net_1\);
    
    \arbRegSMCurrentState[6]\ : SLE
      port map(D => \arbRegSMCurrentState_ns[9]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[6]_net_1\);
    
    \arbRegSMCurrentState_ns_i_a2_0_RNI9H9G[0]\ : CFG4
      generic map(INIT => x"FFF4")

      port map(A => N_156, B => xhdl1221(0), C => 
        \arbRegSMCurrentState_14\, D => \arbRegSMCurrentState_11\, 
        Y => N_129_i_0);
    
    \arbRegSMCurrentState[1]\ : SLE
      port map(D => N_126_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[1]_net_1\);
    
    \arbRegSMCurrentState_RNIUPM54[12]\ : CFG4
      generic map(INIT => x"A888")

      port map(A => M0GATEDHSIZE(1), B => 
        \arbRegSMCurrentState_RNIGOV71[12]_net_1\, C => \g0_1\, D
         => SADDRSEL_0(1), Y => CoreAHBLite_0_AHBmslave0_HSIZE(1));
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \arbRegSMCurrentState_RNO[4]\ : CFG2
      generic map(INIT => x"8")

      port map(A => N_99, B => \masterAddrInProg[2]\, Y => 
        N_122_i_0);
    
    \arbRegSMCurrentState_RNO[13]\ : CFG2
      generic map(INIT => x"4")

      port map(A => N_99, B => \arbRegSMCurrentState_11\, Y => 
        N_108_i_0);
    
    \arbRegSMCurrentState_RNO[14]\ : CFG4
      generic map(INIT => x"FDF9")

      port map(A => N_99, B => N_106_i_1, C => 
        \arbRegSMCurrentState[13]_net_1\, D => 
        \arbRegSMCurrentState_14\, Y => N_106_i_0);
    
    \arbRegSMCurrentState[9]\ : SLE
      port map(D => N_114_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[9]_net_1\);
    
    \arbRegSMCurrentState[4]\ : SLE
      port map(D => N_122_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \masterAddrInProg[2]\);
    
    \arbRegSMCurrentState_RNID15V3[12]\ : CFG3
      generic map(INIT => x"13")

      port map(A => \g0_1\, B => 
        \arbRegSMCurrentState_RNIGOV71[12]_net_1\, C => 
        SADDRSEL_0(1), Y => N_101);
    
    \arbRegSMCurrentState_ns_i_a2_0[0]\ : CFG4
      generic map(INIT => x"0001")

      port map(A => \arbRegSMCurrentState[14]_net_1\, B => 
        \arbRegSMCurrentState[10]_net_1\, C => 
        \arbRegSMCurrentState[6]_net_1\, D => 
        \arbRegSMCurrentState[2]_net_1\, Y => N_156);
    
    \arbRegSMCurrentState[13]\ : SLE
      port map(D => N_108_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[13]_net_1\);
    
    \arbRegSMCurrentState_ns_i_a2_1[1]\ : CFG3
      generic map(INIT => x"01")

      port map(A => \arbRegSMCurrentState[10]_net_1\, B => 
        \arbRegSMCurrentState[6]_net_1\, C => 
        \arbRegSMCurrentState[2]_net_1\, Y => N_157);
    
    \arbRegSMCurrentState[2]\ : SLE
      port map(D => \arbRegSMCurrentState_ns[13]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => GND_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[2]_net_1\);
    
    \arbRegSMCurrentState_ns_i_a2_0_RNIEVNF[0]\ : CFG4
      generic map(INIT => x"3331")

      port map(A => N_156, B => N_99, C => 
        \arbRegSMCurrentState_14\, D => \arbRegSMCurrentState_11\, 
        Y => arbRegSMCurrentState_ns_i_a2_0_RNIEVNF(0));
    
    \arbRegSMCurrentState_RNIGOV71[12]\ : CFG3
      generic map(INIT => x"0E")

      port map(A => \arbRegSMCurrentState_14\, B => 
        \arbRegSMCurrentState_11\, C => \HWRITE_0_i_o2_2_1\, Y
         => \arbRegSMCurrentState_RNIGOV71[12]_net_1\);
    
    \arbRegSMCurrentState[5]\ : SLE
      port map(D => N_120_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[5]_net_1\);
    
    \arbRegSMCurrentState[15]\ : SLE
      port map(D => N_104_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState_14\);
    
    \arbRegSMCurrentState_ns_i_a2_0_RNITP6S2[0]\ : CFG4
      generic map(INIT => x"4700")

      port map(A => regHADDR(26), B => masterRegAddrSel, C => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(26), D
         => N_152_i_i_a2_d_0_a0_2_0, Y => 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0));
    
    \arbRegSMCurrentState_ns_i_a2_0_RNIQQN22[0]\ : CFG4
      generic map(INIT => x"0027")

      port map(A => masterRegAddrSel, B => regHADDR(25), C => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(25), D
         => HWRITE_0_i_o2, Y => N_152_i_i_a2_d_0_a0_2_0);
    
    \arbRegSMCurrentState_RNI92H41[0]\ : CFG3
      generic map(INIT => x"FE")

      port map(A => \masterAddrInProg[3]\, B => 
        \masterAddrInProg[2]\, C => \masterAddrInProg[1]\, Y => 
        \HWRITE_0_i_o2_2_1\);
    
    \arbRegSMCurrentState_ns[5]\ : CFG3
      generic map(INIT => x"AE")

      port map(A => \arbRegSMCurrentState[9]_net_1\, B => 
        \arbRegSMCurrentState[10]_net_1\, C => xhdl1221(0), Y => 
        \arbRegSMCurrentState_ns[5]_net_1\);
    
    \arbRegSMCurrentState_RNO[5]\ : CFG2
      generic map(INIT => x"4")

      port map(A => N_99, B => \masterAddrInProg[2]\, Y => 
        N_120_i_0);
    
    \arbRegSMCurrentState_RNO[9]\ : CFG2
      generic map(INIT => x"4")

      port map(A => N_99, B => \masterAddrInProg[1]\, Y => 
        N_114_i_0);
    
    \arbRegSMCurrentState_ns_i_a2_0_RNIOS891[0]\ : CFG4
      generic map(INIT => x"FF10")

      port map(A => \arbRegSMCurrentState_14\, B => 
        \arbRegSMCurrentState_11\, C => N_156, D => 
        \HWRITE_0_i_o2_2_1\, Y => HWRITE_0_i_o2);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAHBLITE_SLAVESTAGE_2 is

    port( ahbcurr_state                                      : in    std_logic_vector(1 downto 0);
          xhdl1232_i_m                                       : out   std_logic_vector(0 to 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA : in    std_logic_vector(31 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA                    : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2            : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                      : out   std_logic_vector(12 to 12);
          xhdl1221                                           : in    std_logic_vector(0 to 0);
          arbRegSMCurrentState_ns_i_a2_0_RNIEVNF             : out   std_logic_vector(0 to 0);
          regHADDR                                           : in    std_logic_vector(26 downto 25);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR  : in    std_logic_vector(26 downto 25);
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1);
          M0GATEDHSIZE                                       : in    std_logic_vector(1 downto 0);
          CoreAHBLite_0_AHBmslave0_HSIZE                     : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_3                             : out   std_logic;
          arbRegSMCurrentState_0                             : out   std_logic;
          MSS_READY                                          : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic;
          N_99_i_0                                           : in    std_logic;
          hready_m_xhdl340                                   : in    std_logic;
          masterRegAddrSel                                   : in    std_logic;
          HWRITE_0_i_o2_2_1                                  : out   std_logic;
          N_99                                               : in    std_logic;
          N_112                                              : in    std_logic;
          N_113                                              : in    std_logic;
          g0_1                                               : out   std_logic;
          N_101                                              : out   std_logic
        );

end COREAHBLITE_SLAVESTAGE_2;

architecture DEF_ARCH of COREAHBLITE_SLAVESTAGE_2 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component COREAHBLITE_SLAVEARBITER
    port( masterAddrInProg                                  : out   std_logic_vector(3 downto 1);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2           : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                     : out   std_logic_vector(12 to 12);
          xhdl1221                                          : in    std_logic_vector(0 to 0) := (others => 'U');
          arbRegSMCurrentState_ns_i_a2_0_RNIEVNF            : out   std_logic_vector(0 to 0);
          regHADDR                                          : in    std_logic_vector(26 downto 25) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR : in    std_logic_vector(26 downto 25) := (others => 'U');
          SADDRSEL_0                                        : in    std_logic_vector(1 to 1) := (others => 'U');
          M0GATEDHSIZE                                      : in    std_logic_vector(1 downto 0) := (others => 'U');
          CoreAHBLite_0_AHBmslave0_HSIZE                    : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_14                           : out   std_logic;
          arbRegSMCurrentState_11                           : out   std_logic;
          MSS_READY                                         : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                      : in    std_logic := 'U';
          masterRegAddrSel                                  : in    std_logic := 'U';
          HWRITE_0_i_o2_2_1                                 : out   std_logic;
          N_99                                              : in    std_logic := 'U';
          N_129_i_0                                         : out   std_logic;
          N_112                                             : in    std_logic := 'U';
          N_113                                             : in    std_logic := 'U';
          g0_1                                              : out   std_logic;
          N_101                                             : out   std_logic
        );
  end component;

    signal \masterDataInProg[0]_net_1\, VCC_net_1, N_129_i_0, 
        GND_net_1, \masterDataInProg[1]_net_1\, 
        \masterAddrInProg[1]\, \masterDataInProg[2]_net_1\, 
        \masterAddrInProg[2]\, \masterDataInProg[3]_net_1\, 
        \masterAddrInProg[3]\, \hwdata10\ : std_logic;

    for all : COREAHBLITE_SLAVEARBITER
	Use entity work.COREAHBLITE_SLAVEARBITER(DEF_ARCH);
begin 


    \masterDataInProg[3]\ : SLE
      port map(D => \masterAddrInProg[3]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_99_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \masterDataInProg[3]_net_1\);
    
    hwdata10_RNI2UPH_18 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(20));
    
    hwdata10_RNI2UPH_20 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(24));
    
    \masterDataInProg_RNIDVV51[0]\ : CFG4
      generic map(INIT => x"CC8C")

      port map(A => ahbcurr_state(1), B => hready_m_xhdl340, C
         => \masterDataInProg[0]_net_1\, D => ahbcurr_state(0), Y
         => xhdl1232_i_m(0));
    
    hwdata10_RNI2UPH_11 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(29));
    
    hwdata10_RNI2UPH_22 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(14));
    
    hwdata10_RNI2UPH_23 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(19));
    
    hwdata10_RNI2UPH_0 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(6));
    
    hwdata10_RNI2UPH_10 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(30));
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \masterDataInProg[2]\ : SLE
      port map(D => \masterAddrInProg[2]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_99_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \masterDataInProg[2]_net_1\);
    
    hwdata10_RNI2UPH_26 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(12));
    
    hwdata10_RNI2UPH_12 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(23));
    
    hwdata10_RNI2UPH_3 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(9));
    
    hwdata10_RNI2UPH_13 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(28));
    
    hwdata10_RNI2UPH_5 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(8));
    
    hwdata10_RNI2UPH_25 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(18));
    
    hwdata10_RNI2UPH_24 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(13));
    
    hwdata10_RNI2UPH_16 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(21));
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \masterDataInProg[1]\ : SLE
      port map(D => \masterAddrInProg[1]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_99_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \masterDataInProg[1]_net_1\);
    
    \masterDataInProg[0]\ : SLE
      port map(D => N_129_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_99_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \masterDataInProg[0]_net_1\);
    
    hwdata10_RNI2UPH_2 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(4));
    
    hwdata10_RNI2UPH_29 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(16));
    
    hwdata10_RNI2UPH_15 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(27));
    
    hwdata10_RNI2UPH_14 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(22));
    
    hwdata10_RNI2UPH_8 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(0));
    
    hwdata10_RNI2UPH_7 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(1));
    
    hwdata10_RNI2UPH_1 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(5));
    
    hwdata10_RNI2UPH_27 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(17));
    
    hwdata10_RNI2UPH_19 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(25));
    
    slave_arbiter : COREAHBLITE_SLAVEARBITER
      port map(masterAddrInProg(3) => \masterAddrInProg[3]\, 
        masterAddrInProg(2) => \masterAddrInProg[2]\, 
        masterAddrInProg(1) => \masterAddrInProg[1]\, 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0) => 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0), 
        arbRegSMCurrentState_RNIGOV71(12) => 
        arbRegSMCurrentState_RNIGOV71(12), xhdl1221(0) => 
        xhdl1221(0), arbRegSMCurrentState_ns_i_a2_0_RNIEVNF(0)
         => arbRegSMCurrentState_ns_i_a2_0_RNIEVNF(0), 
        regHADDR(26) => regHADDR(26), regHADDR(25) => 
        regHADDR(25), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(26) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(26), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(25) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(25), 
        SADDRSEL_0(1) => SADDRSEL_0(1), M0GATEDHSIZE(1) => 
        M0GATEDHSIZE(1), M0GATEDHSIZE(0) => M0GATEDHSIZE(0), 
        CoreAHBLite_0_AHBmslave0_HSIZE(1) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(1), 
        CoreAHBLite_0_AHBmslave0_HSIZE(0) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(0), 
        arbRegSMCurrentState_14 => arbRegSMCurrentState_3, 
        arbRegSMCurrentState_11 => arbRegSMCurrentState_0, 
        MSS_READY => MSS_READY, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, masterRegAddrSel => 
        masterRegAddrSel, HWRITE_0_i_o2_2_1 => HWRITE_0_i_o2_2_1, 
        N_99 => N_99, N_129_i_0 => N_129_i_0, N_112 => N_112, 
        N_113 => N_113, g0_1 => g0_1, N_101 => N_101);
    
    hwdata10 : CFG4
      generic map(INIT => x"0100")

      port map(A => \masterDataInProg[3]_net_1\, B => 
        \masterDataInProg[2]_net_1\, C => 
        \masterDataInProg[1]_net_1\, D => 
        \masterDataInProg[0]_net_1\, Y => \hwdata10\);
    
    hwdata10_RNI2UPH_17 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(26));
    
    hwdata10_RNI2UPH_4 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(3));
    
    hwdata10_RNI2UPH_28 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(11));
    
    hwdata10_RNI2UPH_30 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(10));
    
    hwdata10_RNI2UPH_21 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(15));
    
    hwdata10_RNI2UPH_6 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(2));
    
    hwdata10_RNI2UPH_9 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(31));
    
    hwdata10_RNI2UPH : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7), B
         => \hwdata10\, Y => CoreAHBLite_0_AHBmslave0_HWDATA(7));
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAHBLITE_DEFAULTSLAVESM_0 is

    port( defSlaveSMCurrentState       : out   std_logic;
          MSS_READY                    : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK : in    std_logic;
          N_68                         : in    std_logic
        );

end COREAHBLITE_DEFAULTSLAVESM_0;

architecture DEF_ARCH of COREAHBLITE_DEFAULTSLAVESM_0 is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

    signal defSlaveSMCurrentState_net_1, VCC_net_1, 
        \defSlaveSMNextState\, GND_net_1 : std_logic;

begin 

    defSlaveSMCurrentState <= defSlaveSMCurrentState_net_1;

    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    defSlaveSMNextState : CFG2
      generic map(INIT => x"1")

      port map(A => N_68, B => defSlaveSMCurrentState_net_1, Y
         => \defSlaveSMNextState\);
    
    \defSlaveSMCurrentState\ : SLE
      port map(D => \defSlaveSMNextState\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        defSlaveSMCurrentState_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAHBLITE_MASTERSTAGE_2_1_0_3_0 is

    port( sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : in    std_logic_vector(1 downto 0);
          xhdl1221                                             : out   std_logic_vector(1 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : in    std_logic_vector(1 to 1);
          SADDRSEL_0                                           : out   std_logic_vector(1 to 1);
          arbRegSMCurrentState_ns_i_a2_0_RNIEVNF               : in    std_logic_vector(0 to 0);
          M0GATEDHSIZE                                         : out   std_logic_vector(1 downto 0);
          SADDRSEL_2                                           : out   std_logic_vector(9 to 9);
          CoreAHBLite_0_AHBmslave0_HRDATA                      : in    std_logic_vector(31 downto 0);
          reg_2x32_0_data_out                                  : in    std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : out   std_logic_vector(0 to 0);
          xhdl1238_i_m_1                                       : in    std_logic_vector(0 to 0);
          xhdl1232_i_m                                         : in    std_logic_vector(0 to 0);
          regHADDR_25                                          : out   std_logic;
          regHADDR_26                                          : out   std_logic;
          regHADDR_2                                           : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : in    std_logic;
          regHSIZE_1                                           : out   std_logic;
          xhdl1222_1                                           : out   std_logic;
          M0GATEDHADDR_8                                       : out   std_logic;
          M0GATEDHADDR_4                                       : out   std_logic;
          M0GATEDHADDR_3                                       : out   std_logic;
          M0GATEDHADDR_2                                       : out   std_logic;
          M0GATEDHADDR_1                                       : out   std_logic;
          M0GATEDHADDR_6                                       : out   std_logic;
          M0GATEDHADDR_5                                       : out   std_logic;
          M0GATEDHADDR_7                                       : out   std_logic;
          M0GATEDHADDR_0                                       : out   std_logic;
          arbRegSMCurrentState_3                               : in    std_logic;
          arbRegSMCurrentState_0                               : in    std_logic;
          MSS_READY                                            : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : in    std_logic;
          regHTRANS                                            : out   std_logic;
          masterRegAddrSel                                     : out   std_logic;
          N_112                                                : out   std_logic;
          N_113                                                : out   std_logic;
          hready_m_xhdl341_1                                   : out   std_logic;
          N_121                                                : out   std_logic;
          N_27_i                                               : out   std_logic;
          N_124                                                : out   std_logic;
          N_122                                                : out   std_logic;
          N_123                                                : out   std_logic;
          N_99                                                 : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY               : in    std_logic;
          N_156                                                : in    std_logic;
          N_68                                                 : out   std_logic;
          N_128                                                : out   std_logic;
          hready_m_xhdl340                                     : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                           : out   std_logic;
          defSlaveSMCurrentState                               : out   std_logic;
          N_102                                                : out   std_logic;
          HREADY_M_iv_i_0                                      : out   std_logic
        );

end COREAHBLITE_MASTERSTAGE_2_1_0_3_0;

architecture DEF_ARCH of COREAHBLITE_MASTERSTAGE_2_1_0_3_0 is 

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component COREAHBLITE_DEFAULTSLAVESM_0
    port( defSlaveSMCurrentState       : out   std_logic;
          MSS_READY                    : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK : in    std_logic := 'U';
          N_68                         : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \regHADDR[24]_net_1\, VCC_net_1, 
        masterAddrClockEnable, GND_net_1, \regHADDR_25\, 
        \regHADDR_26\, \regHADDR[27]_net_1\, \regHADDR_2\, 
        \regHADDR[3]_net_1\, \regHADDR[4]_net_1\, 
        \regHADDR[5]_net_1\, \regHADDR[6]_net_1\, 
        \regHADDR[7]_net_1\, \regHADDR[8]_net_1\, 
        \regHADDR[9]_net_1\, \regHADDR[10]_net_1\, 
        \regHADDR[11]_net_1\, \regHADDR[12]_net_1\, 
        \SDATASELInt[11]_net_1\, \SADDRSEL[11]\, N_32_i_0, 
        \SDATASELInt[12]_net_1\, \SADDRSEL[12]\, 
        \SDATASELInt[13]_net_1\, \SADDRSEL[13]\, 
        \SDATASELInt[14]_net_1\, \SADDRSEL[14]\, 
        \SDATASELInt[15]_net_1\, \SADDRSEL[15]\, 
        \regHADDR[0]_net_1\, \regHADDR[1]_net_1\, 
        \regHSIZE[0]_net_1\, \regHSIZE_1\, \xhdl1222[0]\, 
        \xhdl1221[0]\, \xhdl1222_1\, \xhdl1221[1]\, 
        \SDATASELInt[2]_net_1\, \SADDRSEL[2]\, 
        \SDATASELInt[3]_net_1\, \SADDRSEL[3]\, 
        \SDATASELInt[4]_net_1\, \SADDRSEL[4]_net_1\, 
        \SDATASELInt[5]_net_1\, \SADDRSEL[5]_net_1\, 
        \SDATASELInt[6]_net_1\, \SADDRSEL[6]\, 
        \SDATASELInt[7]_net_1\, \SADDRSEL[7]\, 
        \SDATASELInt[8]_net_1\, \SADDRSEL[8]_net_1\, 
        \SDATASELInt[9]_net_1\, \SADDRSEL[9]_net_1\, 
        \SDATASELInt[10]_net_1\, \SADDRSEL[10]\, \regHWRITE\, 
        regHTRANS_net_1, masterRegAddrSel_net_1, d_N_9_i_0, 
        \SADDRSEL_0_1[0]_net_1\, \SADDRSEL_0[1]\, 
        \masterAddrClockEnable_m7_ns_1\, \M0GATEDHADDR[25]\, 
        \N_112\, \masterAddrClockEnable_m7_ns\, d_N_7_mux, 
        \N_113\, \HREADY_M_iv\, d_m8_0_0, \DEFSLAVEDATASEL_7\, 
        N_37_i, \hready_m_xhdl341_1\, N_64, N_111, 
        \un1_hready_m_xhdl340_2_i_a3_2_0\, 
        \un1_hready_m_xhdl340_2_i_a3_1_0\, 
        un1_hready_m_xhdl340_2_i_a3_0, 
        \un1_hready_m_xhdl340_2_i_a3_0_0\, 
        \un1_hready_m_xhdl340_2_i_a3_5_0\, 
        \HRDATA_1_a3_1[12]_net_1\, N_60, N_666, 
        hready_m_xhdl349_11, \SADDRSEL_3_0[8]_net_1\, 
        \SADDRSEL_1[13]\, \SADDRSEL_2[9]\, N_144, 
        \un1_hready_m_xhdl340_2_i_a3_4_0\, 
        PREVDATASLAVEREADY_iv_i_i_a2_1, \N_68\, N_661, \N_128\, 
        hready_m_xhdl341, N_72, N_70, N_69, \hready_m_xhdl340\, 
        N_48, un1_SDATASELInt_1, \AMBA_SLAVE_0_HREADY_S1_i_m\, 
        \un1_hready_m_xhdl340_2_i_0_2\, 
        \un1_hready_m_xhdl340_2_i_0_1\, 
        \un1_hready_m_xhdl340_2_i_0_3\, d_N_4, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, 
        \defSlaveSMCurrentState\ : std_logic;

    for all : COREAHBLITE_DEFAULTSLAVESM_0
	Use entity work.COREAHBLITE_DEFAULTSLAVESM_0(DEF_ARCH);
begin 

    xhdl1221(1) <= \xhdl1221[1]\;
    xhdl1221(0) <= \xhdl1221[0]\;
    SADDRSEL_0(1) <= \SADDRSEL_0[1]\;
    SADDRSEL_2(9) <= \SADDRSEL_2[9]\;
    sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) <= 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\;
    regHADDR_25 <= \regHADDR_25\;
    regHADDR_26 <= \regHADDR_26\;
    regHADDR_2 <= \regHADDR_2\;
    regHSIZE_1 <= \regHSIZE_1\;
    xhdl1222_1 <= \xhdl1222_1\;
    regHTRANS <= regHTRANS_net_1;
    masterRegAddrSel <= masterRegAddrSel_net_1;
    N_112 <= \N_112\;
    N_113 <= \N_113\;
    hready_m_xhdl341_1 <= \hready_m_xhdl341_1\;
    N_68 <= \N_68\;
    N_128 <= \N_128\;
    hready_m_xhdl340 <= \hready_m_xhdl340\;
    AMBA_SLAVE_0_HREADY_S1_i_m <= \AMBA_SLAVE_0_HREADY_S1_i_m\;
    defSlaveSMCurrentState <= \defSlaveSMCurrentState\;

    un1_hready_m_xhdl340_2_i_a2_9 : CFG2
      generic map(INIT => x"1")

      port map(A => \xhdl1222_1\, B => \xhdl1222[0]\, Y => N_64);
    
    \PREGATEDHADDR[3]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3, C
         => \regHADDR[3]_net_1\, Y => M0GATEDHADDR_1);
    
    \SADDRSEL_0_a3_0[10]\ : CFG4
      generic map(INIT => x"C088")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), B
         => \M0GATEDHADDR[25]\, C => regHTRANS_net_1, D => 
        masterRegAddrSel_net_1, Y => N_144);
    
    \HRDATA[26]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(26), D => 
        reg_2x32_0_data_out(26), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26));
    
    \GATEDHSIZE[1]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1), C
         => \regHSIZE_1\, Y => M0GATEDHSIZE(1));
    
    \PREGATEDHADDR_i_m3[11]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11, C
         => \regHADDR[11]_net_1\, Y => N_122);
    
    \SDATASELInt[7]\ : SLE
      port map(D => \SADDRSEL[7]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[7]_net_1\);
    
    un1_hready_m_xhdl340_2_i_0_1 : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \un1_hready_m_xhdl340_2_i_a3_0_0\, B => 
        un1_hready_m_xhdl340_2_i_a3_0, C => N_69, D => N_72, Y
         => \un1_hready_m_xhdl340_2_i_0_1\);
    
    \regHADDR[27]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[27]_net_1\);
    
    \HRDATA[11]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(11), D => 
        reg_2x32_0_data_out(11), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11));
    
    \PREGATEDHADDR_i_m3[1]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1, C
         => \regHADDR[1]_net_1\, Y => N_123);
    
    masterRegAddrSel_RNO : CFG3
      generic map(INIT => x"45")

      port map(A => d_m8_0_0, B => masterRegAddrSel_net_1, C => 
        \HREADY_M_iv\, Y => d_N_9_i_0);
    
    masterAddrClockEnable_m7_ns_1 : CFG3
      generic map(INIT => x"53")

      port map(A => d_N_7_mux, B => 
        arbRegSMCurrentState_ns_i_a2_0_RNIEVNF(0), C => \N_113\, 
        Y => \masterAddrClockEnable_m7_ns_1\);
    
    \SADDRSEL_0_a2[6]\ : CFG4
      generic map(INIT => x"0400")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[6]\);
    
    \SDATASELInt[13]\ : SLE
      port map(D => \SADDRSEL[13]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[13]_net_1\);
    
    \regHSIZE[0]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0), CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHSIZE[0]_net_1\);
    
    default_slave_sm : COREAHBLITE_DEFAULTSLAVESM_0
      port map(defSlaveSMCurrentState => \defSlaveSMCurrentState\, 
        MSS_READY => MSS_READY, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, N_68 => \N_68\);
    
    \HRDATA[22]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(22), D => 
        reg_2x32_0_data_out(22), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22));
    
    un1_hready_m_xhdl340_2_i_a3_2_0 : CFG4
      generic map(INIT => x"0110")

      port map(A => \SDATASELInt[9]_net_1\, B => 
        \SDATASELInt[8]_net_1\, C => \SDATASELInt[7]_net_1\, D
         => \SDATASELInt[6]_net_1\, Y => 
        \un1_hready_m_xhdl340_2_i_a3_2_0\);
    
    \HRDATA[13]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(13), D => 
        reg_2x32_0_data_out(13), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13));
    
    \PREGATEDHADDR[7]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7, C
         => \regHADDR[7]_net_1\, Y => M0GATEDHADDR_5);
    
    \PREGATEDHADDR_i_m3[26]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26, C
         => \regHADDR_26\, Y => \N_112\);
    
    \SDATASELInt[0]\ : SLE
      port map(D => \xhdl1221[0]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \xhdl1222[0]\);
    
    \regHADDR[2]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR_2\);
    
    un1_hready_m_xhdl340_2_i_0_RNI89IM : CFG3
      generic map(INIT => x"AE")

      port map(A => \AMBA_SLAVE_0_HREADY_S1_i_m\, B => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, C
         => \defSlaveSMCurrentState\, Y => N_102);
    
    hready_m_xhdl340_1_0_0_a2_1 : CFG4
      generic map(INIT => x"0001")

      port map(A => \SDATASELInt[9]_net_1\, B => 
        \SDATASELInt[8]_net_1\, C => \SDATASELInt[7]_net_1\, D
         => \SDATASELInt[6]_net_1\, Y => N_666);
    
    \SADDRSEL_0_a2[7]\ : CFG4
      generic map(INIT => x"4000")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[7]\);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \SDATASELInt[9]\ : SLE
      port map(D => \SADDRSEL[9]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[9]_net_1\);
    
    \PREGATEDHADDR[25]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25, C
         => \regHADDR_25\, Y => \M0GATEDHADDR[25]\);
    
    \HRDATA[20]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(20), D => 
        reg_2x32_0_data_out(20), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20));
    
    \HRDATA[29]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(29), D => 
        reg_2x32_0_data_out(29), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29));
    
    \HRDATA[16]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(16), D => 
        reg_2x32_0_data_out(16), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16));
    
    un1_hready_m_xhdl340_2_i_x2_1 : CFG2
      generic map(INIT => x"6")

      port map(A => \SDATASELInt[8]_net_1\, B => 
        \SDATASELInt[9]_net_1\, Y => N_37_i);
    
    un1_hready_m_xhdl340_2_i_0_RNISLF33 : CFG4
      generic map(INIT => x"0045")

      port map(A => \AMBA_SLAVE_0_HREADY_S1_i_m\, B => 
        \defSlaveSMCurrentState\, C => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, D
         => \N_128\, Y => N_32_i_0);
    
    \SADDRSEL_0_a2[10]\ : CFG4
      generic map(INIT => x"0200")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[10]\);
    
    \HRDATA[5]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(5), D => 
        reg_2x32_0_data_out(5), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5));
    
    DEFSLAVEDATASEL_7 : CFG2
      generic map(INIT => x"E")

      port map(A => \SDATASELInt[14]_net_1\, B => 
        \SDATASELInt[15]_net_1\, Y => \DEFSLAVEDATASEL_7\);
    
    \SADDRSEL[9]\ : CFG4
      generic map(INIT => x"1000")

      port map(A => \N_112\, B => \M0GATEDHADDR[25]\, C => 
        \SADDRSEL_3_0[8]_net_1\, D => \N_113\, Y => 
        \SADDRSEL[9]_net_1\);
    
    \regHADDR[9]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[9]_net_1\);
    
    hready_m_xhdl340_1_0_0_a2_0 : CFG4
      generic map(INIT => x"0001")

      port map(A => \SDATASELInt[5]_net_1\, B => 
        \SDATASELInt[4]_net_1\, C => \SDATASELInt[3]_net_1\, D
         => \SDATASELInt[2]_net_1\, Y => N_60);
    
    \regHADDR[0]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[0]_net_1\);
    
    \SDATASELInt[6]\ : SLE
      port map(D => \SADDRSEL[6]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[6]_net_1\);
    
    \SADDRSEL_2_0_a3[8]\ : CFG4
      generic map(INIT => x"0311")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26, B
         => \M0GATEDHADDR[25]\, C => \regHADDR_26\, D => 
        masterRegAddrSel_net_1, Y => \SADDRSEL_2[9]\);
    
    un1_hready_m_xhdl340_2_i_0 : CFG3
      generic map(INIT => x"FE")

      port map(A => \un1_hready_m_xhdl340_2_i_0_1\, B => 
        \un1_hready_m_xhdl340_2_i_0_3\, C => 
        \un1_hready_m_xhdl340_2_i_0_2\, Y => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\);
    
    \HRDATA[31]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(31), D => 
        reg_2x32_0_data_out(31), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31));
    
    masterAddrClockEnable_m7_ns : CFG4
      generic map(INIT => x"0008")

      port map(A => \SADDRSEL_0[1]\, B => 
        \masterAddrClockEnable_m7_ns_1\, C => \M0GATEDHADDR[25]\, 
        D => \N_112\, Y => \masterAddrClockEnable_m7_ns\);
    
    \regHADDR[5]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[5]_net_1\);
    
    un1_SDATASELInt_1_0 : CFG3
      generic map(INIT => x"60")

      port map(A => \xhdl1222[0]\, B => \xhdl1222_1\, C => \N_68\, 
        Y => un1_SDATASELInt_1);
    
    hready_m_xhdl340_0_a2_0_a2_RNI4FBF : CFG3
      generic map(INIT => x"20")

      port map(A => \N_68\, B => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, C => 
        \hready_m_xhdl341_1\, Y => \AMBA_SLAVE_0_HREADY_S1_i_m\);
    
    un1_hready_m_xhdl340_2_i_a2_8 : CFG4
      generic map(INIT => x"2000")

      port map(A => N_64, B => \DEFSLAVEDATASEL_7\, C => 
        hready_m_xhdl349_11, D => N_666, Y => N_72);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    un1_hready_m_xhdl340_2_i_a3_4_0 : CFG3
      generic map(INIT => x"48")

      port map(A => \SDATASELInt[14]_net_1\, B => 
        hready_m_xhdl349_11, C => \SDATASELInt[15]_net_1\, Y => 
        \un1_hready_m_xhdl340_2_i_a3_4_0\);
    
    GATEDHWRITE : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, C => 
        \regHWRITE\, Y => N_27_i);
    
    \SADDRSEL_0_a2[13]\ : CFG4
      generic map(INIT => x"8000")

      port map(A => \N_113\, B => \SADDRSEL_1[13]\, C => N_111, D
         => \N_112\, Y => \SADDRSEL[13]\);
    
    \HRDATA[10]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(10), D => 
        reg_2x32_0_data_out(10), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10));
    
    \HRDATA[19]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(19), D => 
        reg_2x32_0_data_out(19), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19));
    
    regHWRITE : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHWRITE\);
    
    \regHADDR[4]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[4]_net_1\);
    
    \SADDRSEL_0_a2[3]\ : CFG4
      generic map(INIT => x"1000")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[3]\);
    
    \HRDATA[9]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(9), D => 
        reg_2x32_0_data_out(9), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9));
    
    \GATEDHSIZE[0]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0), C
         => \regHSIZE[0]_net_1\, Y => M0GATEDHSIZE(0));
    
    \SADDRSEL_0_a2_1[12]\ : CFG4
      generic map(INIT => x"3022")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), B
         => \M0GATEDHADDR[25]\, C => regHTRANS_net_1, D => 
        masterRegAddrSel_net_1, Y => \SADDRSEL_1[13]\);
    
    masterRegAddrSel_RNO_1 : CFG4
      generic map(INIT => x"D0C0")

      port map(A => arbRegSMCurrentState_ns_i_a2_0_RNIEVNF(0), B
         => \N_113\, C => \SADDRSEL_0[1]\, D => \SADDRSEL_2[9]\, 
        Y => d_N_4);
    
    \SADDRSEL_0_a2[14]\ : CFG4
      generic map(INIT => x"0800")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[14]\);
    
    hready_m_xhdl340_11_0_a2 : CFG4
      generic map(INIT => x"0001")

      port map(A => \SDATASELInt[13]_net_1\, B => 
        \SDATASELInt[12]_net_1\, C => \SDATASELInt[11]_net_1\, D
         => \SDATASELInt[10]_net_1\, Y => hready_m_xhdl349_11);
    
    \SADDRSEL[8]\ : CFG4
      generic map(INIT => x"0010")

      port map(A => \N_112\, B => \M0GATEDHADDR[25]\, C => 
        \SADDRSEL_3_0[8]_net_1\, D => \N_113\, Y => 
        \SADDRSEL[8]_net_1\);
    
    \PREGATEDHADDR[9]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9, C
         => \regHADDR[9]_net_1\, Y => M0GATEDHADDR_7);
    
    \SADDRSEL_0_a2[15]\ : CFG4
      generic map(INIT => x"8000")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[15]\);
    
    \regHADDR[8]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[8]_net_1\);
    
    \SDATASELInt[11]\ : SLE
      port map(D => \SADDRSEL[11]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[11]_net_1\);
    
    \SADDRSEL_0[0]\ : CFG4
      generic map(INIT => x"88D8")

      port map(A => masterRegAddrSel_net_1, B => 
        \SADDRSEL_0_1[0]_net_1\, C => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), D
         => sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27, 
        Y => \SADDRSEL_0[1]\);
    
    \SDATASELInt[10]\ : SLE
      port map(D => \SADDRSEL[10]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[10]_net_1\);
    
    \HRDATA[7]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(7), D => 
        reg_2x32_0_data_out(7), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7));
    
    \SDATASELInt[3]\ : SLE
      port map(D => \SADDRSEL[3]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[3]_net_1\);
    
    hready_m_xhdl340_0_a2_0_a3 : CFG3
      generic map(INIT => x"20")

      port map(A => \xhdl1222[0]\, B => \xhdl1222_1\, C => \N_68\, 
        Y => \hready_m_xhdl340\);
    
    \SDATASELInt[5]\ : SLE
      port map(D => \SADDRSEL[5]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[5]_net_1\);
    
    \regHADDR[24]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[24]_net_1\);
    
    \SADDRSEL[0]\ : CFG3
      generic map(INIT => x"20")

      port map(A => \SADDRSEL_2[9]\, B => \N_113\, C => 
        \SADDRSEL_0[1]\, Y => \xhdl1221[0]\);
    
    \HRDATA[6]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(6), D => 
        reg_2x32_0_data_out(6), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6));
    
    hready_m_xhdl340_11_0_a2_RNIKCTC2 : CFG4
      generic map(INIT => x"8000")

      port map(A => N_666, B => N_60, C => hready_m_xhdl349_11, D
         => PREVDATASLAVEREADY_iv_i_i_a2_1, Y => \N_128\);
    
    un1_hready_m_xhdl340_2_i_a2_6 : CFG4
      generic map(INIT => x"2000")

      port map(A => N_64, B => \DEFSLAVEDATASEL_7\, C => N_60, D
         => N_666, Y => N_69);
    
    \PREGATEDHADDR[10]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10, C
         => \regHADDR[10]_net_1\, Y => M0GATEDHADDR_8);
    
    \HRDATA[30]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(30), D => 
        reg_2x32_0_data_out(30), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30));
    
    \HRDATA[27]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(27), D => 
        reg_2x32_0_data_out(27), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27));
    
    un1_hready_m_xhdl340_2_i_a3_0_1 : CFG4
      generic map(INIT => x"0006")

      port map(A => \SDATASELInt[13]_net_1\, B => 
        \SDATASELInt[12]_net_1\, C => \SDATASELInt[11]_net_1\, D
         => \SDATASELInt[10]_net_1\, Y => 
        un1_hready_m_xhdl340_2_i_a3_0);
    
    \SADDRSEL[5]\ : CFG4
      generic map(INIT => x"2000")

      port map(A => \N_112\, B => \M0GATEDHADDR[25]\, C => 
        \SADDRSEL_0[1]\, D => \N_113\, Y => \SADDRSEL[5]_net_1\);
    
    \SADDRSEL_0_a2[2]\ : CFG4
      generic map(INIT => x"0100")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[2]\);
    
    hready_m_xhdl340_0_a2_0_a2 : CFG4
      generic map(INIT => x"0800")

      port map(A => N_60, B => hready_m_xhdl349_11, C => 
        \DEFSLAVEDATASEL_7\, D => N_666, Y => \N_68\);
    
    un1_hready_m_xhdl340_2_i_a2_7 : CFG4
      generic map(INIT => x"0800")

      port map(A => N_60, B => hready_m_xhdl349_11, C => 
        \DEFSLAVEDATASEL_7\, D => N_64, Y => N_70);
    
    \SDATASELInt[15]\ : SLE
      port map(D => \SADDRSEL[15]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[15]_net_1\);
    
    un1_SDATASELInt_1_0_a3_1 : CFG2
      generic map(INIT => x"2")

      port map(A => \xhdl1222_1\, B => \xhdl1222[0]\, Y => 
        \hready_m_xhdl341_1\);
    
    \PREGATEDHADDR[2]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2, C
         => \regHADDR_2\, Y => M0GATEDHADDR_0);
    
    d_m3_0_a2 : CFG4
      generic map(INIT => x"AAA2")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        N_156, C => arbRegSMCurrentState_3, D => 
        arbRegSMCurrentState_0, Y => d_N_7_mux);
    
    un1_hready_m_xhdl340_2_i_a3_5_0 : CFG4
      generic map(INIT => x"0110")

      port map(A => \SDATASELInt[13]_net_1\, B => 
        \SDATASELInt[12]_net_1\, C => \SDATASELInt[11]_net_1\, D
         => \SDATASELInt[10]_net_1\, Y => 
        \un1_hready_m_xhdl340_2_i_a3_5_0\);
    
    un1_hready_m_xhdl340_2_i_a3_3 : CFG4
      generic map(INIT => x"1000")

      port map(A => \SDATASELInt[6]_net_1\, B => 
        \SDATASELInt[7]_net_1\, C => N_70, D => N_37_i, Y => N_48);
    
    \regHADDR[6]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[6]_net_1\);
    
    \SADDRSEL_0_1[0]\ : CFG2
      generic map(INIT => x"2")

      port map(A => regHTRANS_net_1, B => \regHADDR[27]_net_1\, Y
         => \SADDRSEL_0_1[0]_net_1\);
    
    \masterRegAddrSel\ : SLE
      port map(D => d_N_9_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => masterRegAddrSel_net_1);
    
    \PREGATEDHADDR[6]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6, C
         => \regHADDR[6]_net_1\, Y => M0GATEDHADDR_4);
    
    \HRDATA[0]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(0), D => 
        reg_2x32_0_data_out(0), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0));
    
    \PREGATEDHADDR[4]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4, C
         => \regHADDR[4]_net_1\, Y => M0GATEDHADDR_2);
    
    \HRDATA[28]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(28), D => 
        reg_2x32_0_data_out(28), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28));
    
    \HRDATA_1_a3_1[12]\ : CFG3
      generic map(INIT => x"20")

      port map(A => reg_2x32_0_data_out(12), B => \xhdl1222[0]\, 
        C => \xhdl1222_1\, Y => \HRDATA_1_a3_1[12]_net_1\);
    
    \HRDATA[25]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(25), D => 
        reg_2x32_0_data_out(25), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25));
    
    masterAddrClockEnable_0 : CFG3
      generic map(INIT => x"02")

      port map(A => \masterAddrClockEnable_m7_ns\, B => 
        masterRegAddrSel_net_1, C => \HREADY_M_iv\, Y => 
        masterAddrClockEnable);
    
    \HRDATA[4]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(4), D => 
        reg_2x32_0_data_out(4), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4));
    
    \regHADDR[10]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[10]_net_1\);
    
    \PREGATEDHADDR_i_m3[12]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12, C
         => \regHADDR[12]_net_1\, Y => N_121);
    
    HREADY_M_iv : CFG4
      generic map(INIT => x"FDFC")

      port map(A => \defSlaveSMCurrentState\, B => 
        xhdl1238_i_m_1(0), C => xhdl1232_i_m(0), D => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, Y
         => \HREADY_M_iv\);
    
    \HRDATA[24]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(24), D => 
        reg_2x32_0_data_out(24), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24));
    
    \SADDRSEL_3_0[8]\ : CFG4
      generic map(INIT => x"B800")

      port map(A => regHTRANS_net_1, B => masterRegAddrSel_net_1, 
        C => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), D
         => N_111, Y => \SADDRSEL_3_0[8]_net_1\);
    
    \HRDATA[17]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(17), D => 
        reg_2x32_0_data_out(17), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17));
    
    un1_hready_m_xhdl340_2_i_0_RNI21352 : CFG4
      generic map(INIT => x"0203")

      port map(A => \defSlaveSMCurrentState\, B => 
        xhdl1238_i_m_1(0), C => xhdl1232_i_m(0), D => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, Y
         => HREADY_M_iv_i_0);
    
    \SADDRSEL[1]\ : CFG3
      generic map(INIT => x"80")

      port map(A => \SADDRSEL_2[9]\, B => \N_113\, C => 
        \SADDRSEL_0[1]\, Y => \xhdl1221[1]\);
    
    \SDATASELInt[1]\ : SLE
      port map(D => \xhdl1221[1]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \xhdl1222_1\);
    
    \regHADDR[25]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR_25\);
    
    un1_hready_m_xhdl340_2_i_a3_1_0 : CFG4
      generic map(INIT => x"0006")

      port map(A => \SDATASELInt[5]_net_1\, B => 
        \SDATASELInt[4]_net_1\, C => \SDATASELInt[3]_net_1\, D
         => \SDATASELInt[2]_net_1\, Y => 
        \un1_hready_m_xhdl340_2_i_a3_1_0\);
    
    \PREGATEDHADDR_i_m3[0]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0, C
         => \regHADDR[0]_net_1\, Y => N_124);
    
    \HRDATA[2]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(2), D => 
        reg_2x32_0_data_out(2), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2));
    
    \SADDRSEL_0_a2[11]\ : CFG4
      generic map(INIT => x"2000")

      port map(A => N_111, B => \N_112\, C => \N_113\, D => N_144, 
        Y => \SADDRSEL[11]\);
    
    \regHADDR[11]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[11]_net_1\);
    
    \HRDATA_1[12]\ : CFG4
      generic map(INIT => x"EAC0")

      port map(A => CoreAHBLite_0_AHBmslave0_HRDATA(12), B => 
        \HRDATA_1_a3_1[12]_net_1\, C => \N_68\, D => 
        \hready_m_xhdl340\, Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12));
    
    \regHADDR[7]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[7]_net_1\);
    
    \SDATASELInt[14]\ : SLE
      port map(D => \SADDRSEL[14]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[14]_net_1\);
    
    \regHADDR[3]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[3]_net_1\);
    
    \regHTRANS\ : SLE
      port map(D => VCC_net_1, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => masterAddrClockEnable, 
        ALn => MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => regHTRANS_net_1);
    
    \HRDATA[8]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(8), D => 
        reg_2x32_0_data_out(8), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8));
    
    \SDATASELInt[12]\ : SLE
      port map(D => \SADDRSEL[12]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[12]_net_1\);
    
    \regHADDR[1]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[1]_net_1\);
    
    \regHADDR[26]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR_26\);
    
    \HRDATA[21]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(21), D => 
        reg_2x32_0_data_out(21), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21));
    
    un1_SDATASELInt_1_0_a3 : CFG2
      generic map(INIT => x"8")

      port map(A => \N_68\, B => \hready_m_xhdl341_1\, Y => 
        hready_m_xhdl341);
    
    \SADDRSEL_0_a2[12]\ : CFG4
      generic map(INIT => x"4000")

      port map(A => \N_113\, B => \SADDRSEL_1[13]\, C => N_111, D
         => \N_112\, Y => \SADDRSEL[12]\);
    
    un1_hready_m_xhdl340_2_i_a3_0_0 : CFG4
      generic map(INIT => x"0110")

      port map(A => \SDATASELInt[5]_net_1\, B => 
        \SDATASELInt[4]_net_1\, C => \SDATASELInt[3]_net_1\, D
         => \SDATASELInt[2]_net_1\, Y => 
        \un1_hready_m_xhdl340_2_i_a3_0_0\);
    
    \PREGATEDHADDR_i_m3[27]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27, C
         => \regHADDR[27]_net_1\, Y => N_111);
    
    DEFSLAVEDATASEL_7_RNI6G8B1 : CFG4
      generic map(INIT => x"0040")

      port map(A => \DEFSLAVEDATASEL_7\, B => N_99, C => 
        \xhdl1222[0]\, D => \xhdl1222_1\, Y => 
        PREVDATASLAVEREADY_iv_i_i_a2_1);
    
    \PREGATEDHADDR[5]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5, C
         => \regHADDR[5]_net_1\, Y => M0GATEDHADDR_3);
    
    un1_hready_m_xhdl340_2_i_0_3 : CFG4
      generic map(INIT => x"FFF8")

      port map(A => N_69, B => \un1_hready_m_xhdl340_2_i_a3_5_0\, 
        C => N_48, D => N_661, Y => 
        \un1_hready_m_xhdl340_2_i_0_3\);
    
    \PREGATEDHADDR[8]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8, C
         => \regHADDR[8]_net_1\, Y => M0GATEDHADDR_6);
    
    \HRDATA[18]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(18), D => 
        reg_2x32_0_data_out(18), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18));
    
    \HRDATA[1]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(1), D => 
        reg_2x32_0_data_out(1), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1));
    
    \regHADDR[12]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12, CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHADDR[12]_net_1\);
    
    \HRDATA[3]\ : CFG4
      generic map(INIT => x"EA40")

      port map(A => hready_m_xhdl341, B => \hready_m_xhdl340\, C
         => CoreAHBLite_0_AHBmslave0_HRDATA(3), D => 
        reg_2x32_0_data_out(3), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3));
    
    \SDATASELInt[8]\ : SLE
      port map(D => \SADDRSEL[8]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[8]_net_1\);
    
    \HRDATA[15]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(15), D => 
        reg_2x32_0_data_out(15), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15));
    
    \SDATASELInt[2]\ : SLE
      port map(D => \SADDRSEL[2]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[2]_net_1\);
    
    \PREGATEDHADDR_i_1_m3[24]\ : CFG3
      generic map(INIT => x"E4")

      port map(A => masterRegAddrSel_net_1, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24, C
         => \regHADDR[24]_net_1\, Y => \N_113\);
    
    masterRegAddrSel_RNO_0 : CFG4
      generic map(INIT => x"8CFF")

      port map(A => d_N_7_mux, B => \N_113\, C => \SADDRSEL_2[9]\, 
        D => d_N_4, Y => d_m8_0_0);
    
    \regHSIZE[1]\ : SLE
      port map(D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1), CLK
         => sha256_system_sb_0_FIC_0_CLK, EN => 
        masterAddrClockEnable, ALn => MSS_READY, ADn => VCC_net_1, 
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \regHSIZE_1\);
    
    un1_hready_m_xhdl340_2_i_0_2 : CFG4
      generic map(INIT => x"EAC0")

      port map(A => \un1_hready_m_xhdl340_2_i_a3_1_0\, B => 
        \un1_hready_m_xhdl340_2_i_a3_2_0\, C => N_70, D => N_72, 
        Y => \un1_hready_m_xhdl340_2_i_0_2\);
    
    \SDATASELInt[4]\ : SLE
      port map(D => \SADDRSEL[4]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_32_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \SDATASELInt[4]_net_1\);
    
    \SADDRSEL[4]\ : CFG4
      generic map(INIT => x"0020")

      port map(A => \N_112\, B => \M0GATEDHADDR[25]\, C => 
        \SADDRSEL_0[1]\, D => \N_113\, Y => \SADDRSEL[4]_net_1\);
    
    \HRDATA[14]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(14), D => 
        reg_2x32_0_data_out(14), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14));
    
    \HRDATA[23]\ : CFG4
      generic map(INIT => x"C840")

      port map(A => \hready_m_xhdl341_1\, B => un1_SDATASELInt_1, 
        C => CoreAHBLite_0_AHBmslave0_HRDATA(23), D => 
        reg_2x32_0_data_out(23), Y => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23));
    
    un1_hready_m_xhdl340_2_i_a3_4 : CFG4
      generic map(INIT => x"8000")

      port map(A => N_666, B => N_64, C => 
        \un1_hready_m_xhdl340_2_i_a3_4_0\, D => N_60, Y => N_661);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAHBLITE_SLAVEARBITER_0 is

    port( masterAddrInProg                       : out   std_logic_vector(3 downto 1);
          xhdl1221                               : in    std_logic_vector(1 to 1);
          arbRegSMCurrentState_14                : out   std_logic;
          arbRegSMCurrentState_11                : out   std_logic;
          MSS_READY                              : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK           : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY : in    std_logic;
          N_156                                  : out   std_logic;
          N_152_i_0                              : out   std_logic
        );

end COREAHBLITE_SLAVEARBITER_0;

architecture DEF_ARCH of COREAHBLITE_SLAVEARBITER_0 is 

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \arbRegSMCurrentState[1]_net_1\, VCC_net_1, N_126_i_0, 
        GND_net_1, \masterAddrInProg[3]\, N_128_i_0, 
        \arbRegSMCurrentState_14\, N_104_i_0, 
        \arbRegSMCurrentState[14]_net_1\, N_106_i_0, 
        \arbRegSMCurrentState[13]_net_1\, N_108_i_0, 
        \arbRegSMCurrentState_11\, N_110_i_0, 
        \arbRegSMCurrentState[10]_net_1\, 
        \arbRegSMCurrentState_ns[5]_net_1\, 
        \arbRegSMCurrentState[9]_net_1\, N_114_i_0, 
        \masterAddrInProg[1]\, N_116_i_0, 
        \arbRegSMCurrentState[6]_net_1\, 
        \arbRegSMCurrentState_ns[9]_net_1\, 
        \arbRegSMCurrentState[5]_net_1\, N_120_i_0, 
        \masterAddrInProg[2]\, N_122_i_0, 
        \arbRegSMCurrentState[2]_net_1\, 
        \arbRegSMCurrentState_ns[13]_net_1\, N_106_i_1, N_157, 
        \N_156\ : std_logic;

begin 

    masterAddrInProg(3) <= \masterAddrInProg[3]\;
    masterAddrInProg(2) <= \masterAddrInProg[2]\;
    masterAddrInProg(1) <= \masterAddrInProg[1]\;
    arbRegSMCurrentState_14 <= \arbRegSMCurrentState_14\;
    arbRegSMCurrentState_11 <= \arbRegSMCurrentState_11\;
    N_156 <= \N_156\;

    \arbRegSMCurrentState_RNO[9]\ : CFG2
      generic map(INIT => x"8")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \masterAddrInProg[1]\, Y => N_114_i_0);
    
    \arbRegSMCurrentState_ns[5]\ : CFG3
      generic map(INIT => x"AE")

      port map(A => \arbRegSMCurrentState[9]_net_1\, B => 
        \arbRegSMCurrentState[10]_net_1\, C => xhdl1221(1), Y => 
        \arbRegSMCurrentState_ns[5]_net_1\);
    
    \arbRegSMCurrentState[10]\ : SLE
      port map(D => \arbRegSMCurrentState_ns[5]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[10]_net_1\);
    
    \arbRegSMCurrentState[14]\ : SLE
      port map(D => N_106_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[14]_net_1\);
    
    \arbRegSMCurrentState_RNO[5]\ : CFG2
      generic map(INIT => x"8")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \masterAddrInProg[2]\, Y => N_120_i_0);
    
    \arbRegSMCurrentState_RNO_0[14]\ : CFG4
      generic map(INIT => x"4066")

      port map(A => \arbRegSMCurrentState[14]_net_1\, B => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, C => N_157, D => 
        xhdl1221(1), Y => N_106_i_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \arbRegSMCurrentState_RNO[13]\ : CFG2
      generic map(INIT => x"8")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \arbRegSMCurrentState_11\, Y => N_108_i_0);
    
    \arbRegSMCurrentState_ns_i_a2_1[1]\ : CFG3
      generic map(INIT => x"01")

      port map(A => \arbRegSMCurrentState[10]_net_1\, B => 
        \arbRegSMCurrentState[6]_net_1\, C => 
        \arbRegSMCurrentState[2]_net_1\, Y => N_157);
    
    \arbRegSMCurrentState[0]\ : SLE
      port map(D => N_128_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \masterAddrInProg[3]\);
    
    \arbRegSMCurrentState_RNO[0]\ : CFG2
      generic map(INIT => x"4")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \masterAddrInProg[3]\, Y => N_128_i_0);
    
    \arbRegSMCurrentState[9]\ : SLE
      port map(D => N_114_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[9]_net_1\);
    
    \arbRegSMCurrentState_RNO[12]\ : CFG2
      generic map(INIT => x"4")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \arbRegSMCurrentState_11\, Y => N_110_i_0);
    
    \arbRegSMCurrentState[15]\ : SLE
      port map(D => N_104_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState_14\);
    
    \arbRegSMCurrentState_RNO[14]\ : CFG4
      generic map(INIT => x"FEF6")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        N_106_i_1, C => \arbRegSMCurrentState[13]_net_1\, D => 
        \arbRegSMCurrentState_14\, Y => N_106_i_0);
    
    \arbRegSMCurrentState_RNO[8]\ : CFG2
      generic map(INIT => x"4")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \masterAddrInProg[1]\, Y => N_116_i_0);
    
    \arbRegSMCurrentState_RNO[4]\ : CFG2
      generic map(INIT => x"4")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \masterAddrInProg[2]\, Y => N_122_i_0);
    
    \arbRegSMCurrentState_RNO[15]\ : CFG4
      generic map(INIT => x"2322")

      port map(A => \arbRegSMCurrentState_14\, B => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, C => \N_156\, D
         => xhdl1221(1), Y => N_104_i_0);
    
    \arbRegSMCurrentState_ns_i_a2_0_RNIDGV71[0]\ : CFG4
      generic map(INIT => x"FFF4")

      port map(A => \N_156\, B => xhdl1221(1), C => 
        \arbRegSMCurrentState_14\, D => \arbRegSMCurrentState_11\, 
        Y => N_152_i_0);
    
    \arbRegSMCurrentState[5]\ : SLE
      port map(D => N_120_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[5]_net_1\);
    
    \arbRegSMCurrentState[4]\ : SLE
      port map(D => N_122_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \masterAddrInProg[2]\);
    
    \arbRegSMCurrentState_ns_i_a2_0[0]\ : CFG4
      generic map(INIT => x"0001")

      port map(A => \arbRegSMCurrentState[14]_net_1\, B => 
        \arbRegSMCurrentState[10]_net_1\, C => 
        \arbRegSMCurrentState[6]_net_1\, D => 
        \arbRegSMCurrentState[2]_net_1\, Y => \N_156\);
    
    \arbRegSMCurrentState[6]\ : SLE
      port map(D => \arbRegSMCurrentState_ns[9]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[6]_net_1\);
    
    \arbRegSMCurrentState[12]\ : SLE
      port map(D => N_110_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState_11\);
    
    \arbRegSMCurrentState[1]\ : SLE
      port map(D => N_126_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[1]_net_1\);
    
    \arbRegSMCurrentState_RNO[1]\ : CFG2
      generic map(INIT => x"8")

      port map(A => sha256_system_sb_0_AMBA_SLAVE_0_HREADY, B => 
        \masterAddrInProg[3]\, Y => N_126_i_0);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \arbRegSMCurrentState_ns[13]\ : CFG3
      generic map(INIT => x"AE")

      port map(A => \arbRegSMCurrentState[1]_net_1\, B => 
        \arbRegSMCurrentState[2]_net_1\, C => xhdl1221(1), Y => 
        \arbRegSMCurrentState_ns[13]_net_1\);
    
    \arbRegSMCurrentState[2]\ : SLE
      port map(D => \arbRegSMCurrentState_ns[13]_net_1\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => GND_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[2]_net_1\);
    
    \arbRegSMCurrentState[8]\ : SLE
      port map(D => N_116_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \masterAddrInProg[1]\);
    
    \arbRegSMCurrentState_ns[9]\ : CFG3
      generic map(INIT => x"AE")

      port map(A => \arbRegSMCurrentState[5]_net_1\, B => 
        \arbRegSMCurrentState[6]_net_1\, C => xhdl1221(1), Y => 
        \arbRegSMCurrentState_ns[9]_net_1\);
    
    \arbRegSMCurrentState[13]\ : SLE
      port map(D => N_108_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \arbRegSMCurrentState[13]_net_1\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAHBLITE_SLAVESTAGE_1 is

    port( masterAddrInProg                                   : out   std_logic_vector(3 downto 1);
          regHADDR                                           : in    std_logic_vector(2 to 2);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR  : in    std_logic_vector(2 to 2);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR              : out   std_logic_vector(2 to 2);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA : in    std_logic_vector(31 downto 0);
          AHB_slave_dummy_0_mem_wdata                        : out   std_logic_vector(31 downto 0);
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1);
          SADDRSEL_2                                         : in    std_logic_vector(9 to 9);
          xhdl1238_i_m_1                                     : out   std_logic_vector(0 to 0);
          xhdl1221                                           : in    std_logic_vector(1 to 1);
          arbRegSMCurrentState_3                             : out   std_logic;
          arbRegSMCurrentState_0                             : out   std_logic;
          MSS_READY                                          : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY             : in    std_logic;
          masterRegAddrSel                                   : in    std_logic;
          hsel2                                              : out   std_logic;
          hsel2_1                                            : out   std_logic;
          lsram_m7_a0_1_0                                    : in    std_logic;
          N_113                                              : in    std_logic;
          hready_m_xhdl341_1                                 : in    std_logic;
          N_68                                               : in    std_logic;
          N_27_i                                             : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE             : out   std_logic;
          N_156                                              : out   std_logic
        );

end COREAHBLITE_SLAVESTAGE_1;

architecture DEF_ARCH of COREAHBLITE_SLAVESTAGE_1 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component COREAHBLITE_SLAVEARBITER_0
    port( masterAddrInProg                       : out   std_logic_vector(3 downto 1);
          xhdl1221                               : in    std_logic_vector(1 to 1) := (others => 'U');
          arbRegSMCurrentState_14                : out   std_logic;
          arbRegSMCurrentState_11                : out   std_logic;
          MSS_READY                              : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK           : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY : in    std_logic := 'U';
          N_156                                  : out   std_logic;
          N_152_i_0                              : out   std_logic
        );
  end component;

    signal \masterDataInProg[0]_net_1\, VCC_net_1, N_152_i_0, 
        GND_net_1, \masterDataInProg[1]_net_1\, 
        \masterAddrInProg[1]\, \masterDataInProg[2]_net_1\, 
        \masterAddrInProg[2]\, \masterDataInProg[3]_net_1\, 
        \masterAddrInProg[3]\, \hsel2\, hsel2_1_net_1, \hwdata10\, 
        \hsel2_a0\, \arbRegSMCurrentState_3\, 
        \arbRegSMCurrentState_0\ : std_logic;

    for all : COREAHBLITE_SLAVEARBITER_0
	Use entity work.COREAHBLITE_SLAVEARBITER_0(DEF_ARCH);
begin 

    masterAddrInProg(3) <= \masterAddrInProg[3]\;
    masterAddrInProg(2) <= \masterAddrInProg[2]\;
    masterAddrInProg(1) <= \masterAddrInProg[1]\;
    arbRegSMCurrentState_3 <= \arbRegSMCurrentState_3\;
    arbRegSMCurrentState_0 <= \arbRegSMCurrentState_0\;
    hsel2 <= \hsel2\;
    hsel2_1 <= hsel2_1_net_1;

    \masterDataInProg[3]\ : SLE
      port map(D => \masterAddrInProg[3]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \masterDataInProg[3]_net_1\);
    
    hwdata10_RNI37UM_14 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(26));
    
    hwdata10_RNI37UM_15 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(25));
    
    hwdata10_RNI37UM_23 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(17));
    
    hwdata10_RNI37UM_0 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(8));
    
    hwdata10_RNI37UM_28 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(12));
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    hwdata10_RNI37UM_8 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(0));
    
    hwdata10_RNI37UM_5 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(3));
    
    hwdata10_RNI37UM_1 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(7));
    
    \masterDataInProg[2]\ : SLE
      port map(D => \masterAddrInProg[2]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \masterDataInProg[2]_net_1\);
    
    hwdata10_RNI37UM_17 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(23));
    
    hwdata10_RNI37UM_21 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(19));
    
    hwdata10_RNI37UM_26 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(14));
    
    hwdata10_RNI37UM_20 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(20));
    
    hwdata10_RNI37UM_13 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(27));
    
    \hsel2_1\ : CFG3
      generic map(INIT => x"01")

      port map(A => \masterAddrInProg[3]\, B => 
        \masterAddrInProg[2]\, C => \masterAddrInProg[1]\, Y => 
        hsel2_1_net_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \masterDataInProg[1]\ : SLE
      port map(D => \masterAddrInProg[1]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \masterDataInProg[1]_net_1\);
    
    \masterDataInProg[0]\ : SLE
      port map(D => N_152_i_0, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, ALn => MSS_READY, 
        ADn => VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT
         => GND_net_1, Q => \masterDataInProg[0]_net_1\);
    
    hwdata10_RNI37UM_3 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(5));
    
    hwdata10_RNI37UM_22 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(18));
    
    hwdata10_RNI37UM_29 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(11));
    
    hwdata10_RNI37UM_18 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(22));
    
    hsel2_a0 : CFG4
      generic map(INIT => x"8000")

      port map(A => SADDRSEL_0(1), B => SADDRSEL_2(9), C => 
        lsram_m7_a0_1_0, D => N_113, Y => \hsel2_a0\);
    
    hwdata10_RNI37UM_7 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(1));
    
    hwdata10_RNI37UM_11 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(29));
    
    hwdata10_RNI37UM_4 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(4));
    
    hwdata10_RNI37UM_24 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(16));
    
    hwdata10_RNI37UM_16 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(24));
    
    hwdata10_RNI37UM_25 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(15));
    
    hwdata10_RNI37UM_10 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(30));
    
    hwdata10_RNI37UM_6 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(2));
    
    hwdata10_RNI37UM : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(9));
    
    slave_arbiter : COREAHBLITE_SLAVEARBITER_0
      port map(masterAddrInProg(3) => \masterAddrInProg[3]\, 
        masterAddrInProg(2) => \masterAddrInProg[2]\, 
        masterAddrInProg(1) => \masterAddrInProg[1]\, xhdl1221(1)
         => xhdl1221(1), arbRegSMCurrentState_14 => 
        \arbRegSMCurrentState_3\, arbRegSMCurrentState_11 => 
        \arbRegSMCurrentState_0\, MSS_READY => MSS_READY, 
        sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, N_156 => N_156, 
        N_152_i_0 => N_152_i_0);
    
    \masterDataInProg_RNIH7SN[0]\ : CFG4
      generic map(INIT => x"7000")

      port map(A => \masterDataInProg[0]_net_1\, B => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, C => 
        hready_m_xhdl341_1, D => N_68, Y => xhdl1238_i_m_1(0));
    
    hwdata10 : CFG4
      generic map(INIT => x"0100")

      port map(A => \masterDataInProg[3]_net_1\, B => 
        \masterDataInProg[2]_net_1\, C => 
        \masterDataInProg[1]_net_1\, D => 
        \masterDataInProg[0]_net_1\, Y => \hwdata10\);
    
    hwdata10_RNI37UM_12 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(28));
    
    hsel2_2 : CFG4
      generic map(INIT => x"FFE0")

      port map(A => \arbRegSMCurrentState_3\, B => 
        \arbRegSMCurrentState_0\, C => hsel2_1_net_1, D => 
        \hsel2_a0\, Y => \hsel2\);
    
    hwdata10_RNI37UM_9 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(31));
    
    hwdata10_RNI37UM_19 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(21));
    
    hsel2_2_RNIN29F : CFG2
      generic map(INIT => x"8")

      port map(A => \hsel2\, B => N_27_i, Y => 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE);
    
    hwdata10_RNI37UM_2 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(6));
    
    hwdata10_RNI37UM_30 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(10));
    
    hsel2_2_RNIC7TU : CFG4
      generic map(INIT => x"D080")

      port map(A => masterRegAddrSel, B => regHADDR(2), C => 
        \hsel2\, D => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(2), Y
         => sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2));
    
    hwdata10_RNI37UM_27 : CFG2
      generic map(INIT => x"8")

      port map(A => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13), B
         => \hwdata10\, Y => AHB_slave_dummy_0_mem_wdata(13));
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity COREAHBLITE_MATRIX4X16 is

    port( regHSIZE                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : in    std_logic_vector(1 downto 0);
          xhdl1222                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : in    std_logic_vector(1 to 1);
          SADDRSEL_0                                           : out   std_logic_vector(1 to 1);
          M0GATEDHSIZE                                         : out   std_logic_vector(1 downto 0);
          M0GATEDHADDR                                         : out   std_logic_vector(10 downto 2);
          SADDRSEL_2                                           : out   std_logic_vector(9 to 9);
          CoreAHBLite_0_AHBmslave0_HRDATA                      : in    std_logic_vector(31 downto 0);
          reg_2x32_0_data_out                                  : in    std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : out   std_logic_vector(0 to 0);
          ahbcurr_state                                        : in    std_logic_vector(1 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA   : in    std_logic_vector(31 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA                      : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2              : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                        : out   std_logic_vector(12 to 12);
          CoreAHBLite_0_AHBmslave0_HSIZE                       : out   std_logic_vector(1 downto 0);
          masterAddrInProg                                     : out   std_logic_vector(3 downto 1);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR                : out   std_logic_vector(2 to 2);
          AHB_slave_dummy_0_mem_wdata                          : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : in    std_logic;
          arbRegSMCurrentState_3                               : out   std_logic;
          arbRegSMCurrentState_0_d0                            : out   std_logic;
          arbRegSMCurrentState_0_3                             : out   std_logic;
          arbRegSMCurrentState_0_0                             : out   std_logic;
          MSS_READY                                            : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : in    std_logic;
          regHTRANS                                            : out   std_logic;
          masterRegAddrSel                                     : out   std_logic;
          N_113                                                : out   std_logic;
          N_121                                                : out   std_logic;
          N_27_i                                               : out   std_logic;
          N_124                                                : out   std_logic;
          N_122                                                : out   std_logic;
          N_123                                                : out   std_logic;
          N_99                                                 : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY               : in    std_logic;
          N_156                                                : out   std_logic;
          N_128                                                : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                           : out   std_logic;
          defSlaveSMCurrentState                               : out   std_logic;
          N_102                                                : out   std_logic;
          HREADY_M_iv_i_0                                      : out   std_logic;
          N_99_i_0                                             : in    std_logic;
          HWRITE_0_i_o2_2_1                                    : out   std_logic;
          g0_1                                                 : out   std_logic;
          N_101                                                : out   std_logic;
          hsel2                                                : out   std_logic;
          hsel2_1                                              : out   std_logic;
          lsram_m7_a0_1_0                                      : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE               : out   std_logic
        );

end COREAHBLITE_MATRIX4X16;

architecture DEF_ARCH of COREAHBLITE_MATRIX4X16 is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component COREAHBLITE_SLAVESTAGE_2
    port( ahbcurr_state                                      : in    std_logic_vector(1 downto 0) := (others => 'U');
          xhdl1232_i_m                                       : out   std_logic_vector(0 to 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA : in    std_logic_vector(31 downto 0) := (others => 'U');
          CoreAHBLite_0_AHBmslave0_HWDATA                    : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2            : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                      : out   std_logic_vector(12 to 12);
          xhdl1221                                           : in    std_logic_vector(0 to 0) := (others => 'U');
          arbRegSMCurrentState_ns_i_a2_0_RNIEVNF             : out   std_logic_vector(0 to 0);
          regHADDR                                           : in    std_logic_vector(26 downto 25) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR  : in    std_logic_vector(26 downto 25) := (others => 'U');
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1) := (others => 'U');
          M0GATEDHSIZE                                       : in    std_logic_vector(1 downto 0) := (others => 'U');
          CoreAHBLite_0_AHBmslave0_HSIZE                     : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_3                             : out   std_logic;
          arbRegSMCurrentState_0                             : out   std_logic;
          MSS_READY                                          : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic := 'U';
          N_99_i_0                                           : in    std_logic := 'U';
          hready_m_xhdl340                                   : in    std_logic := 'U';
          masterRegAddrSel                                   : in    std_logic := 'U';
          HWRITE_0_i_o2_2_1                                  : out   std_logic;
          N_99                                               : in    std_logic := 'U';
          N_112                                              : in    std_logic := 'U';
          N_113                                              : in    std_logic := 'U';
          g0_1                                               : out   std_logic;
          N_101                                              : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component COREAHBLITE_MASTERSTAGE_2_1_0_3_0
    port( sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : in    std_logic_vector(1 downto 0) := (others => 'U');
          xhdl1221                                             : out   std_logic_vector(1 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : in    std_logic_vector(1 to 1) := (others => 'U');
          SADDRSEL_0                                           : out   std_logic_vector(1 to 1);
          arbRegSMCurrentState_ns_i_a2_0_RNIEVNF               : in    std_logic_vector(0 to 0) := (others => 'U');
          M0GATEDHSIZE                                         : out   std_logic_vector(1 downto 0);
          SADDRSEL_2                                           : out   std_logic_vector(9 to 9);
          CoreAHBLite_0_AHBmslave0_HRDATA                      : in    std_logic_vector(31 downto 0) := (others => 'U');
          reg_2x32_0_data_out                                  : in    std_logic_vector(31 downto 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : out   std_logic_vector(0 to 0);
          xhdl1238_i_m_1                                       : in    std_logic_vector(0 to 0) := (others => 'U');
          xhdl1232_i_m                                         : in    std_logic_vector(0 to 0) := (others => 'U');
          regHADDR_25                                          : out   std_logic;
          regHADDR_26                                          : out   std_logic;
          regHADDR_2                                           : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : in    std_logic := 'U';
          regHSIZE_1                                           : out   std_logic;
          xhdl1222_1                                           : out   std_logic;
          M0GATEDHADDR_8                                       : out   std_logic;
          M0GATEDHADDR_4                                       : out   std_logic;
          M0GATEDHADDR_3                                       : out   std_logic;
          M0GATEDHADDR_2                                       : out   std_logic;
          M0GATEDHADDR_1                                       : out   std_logic;
          M0GATEDHADDR_6                                       : out   std_logic;
          M0GATEDHADDR_5                                       : out   std_logic;
          M0GATEDHADDR_7                                       : out   std_logic;
          M0GATEDHADDR_0                                       : out   std_logic;
          arbRegSMCurrentState_3                               : in    std_logic := 'U';
          arbRegSMCurrentState_0                               : in    std_logic := 'U';
          MSS_READY                                            : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : in    std_logic := 'U';
          regHTRANS                                            : out   std_logic;
          masterRegAddrSel                                     : out   std_logic;
          N_112                                                : out   std_logic;
          N_113                                                : out   std_logic;
          hready_m_xhdl341_1                                   : out   std_logic;
          N_121                                                : out   std_logic;
          N_27_i                                               : out   std_logic;
          N_124                                                : out   std_logic;
          N_122                                                : out   std_logic;
          N_123                                                : out   std_logic;
          N_99                                                 : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY               : in    std_logic := 'U';
          N_156                                                : in    std_logic := 'U';
          N_68                                                 : out   std_logic;
          N_128                                                : out   std_logic;
          hready_m_xhdl340                                     : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                           : out   std_logic;
          defSlaveSMCurrentState                               : out   std_logic;
          N_102                                                : out   std_logic;
          HREADY_M_iv_i_0                                      : out   std_logic
        );
  end component;

  component COREAHBLITE_SLAVESTAGE_1
    port( masterAddrInProg                                   : out   std_logic_vector(3 downto 1);
          regHADDR                                           : in    std_logic_vector(2 to 2) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR  : in    std_logic_vector(2 to 2) := (others => 'U');
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR              : out   std_logic_vector(2 to 2);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA : in    std_logic_vector(31 downto 0) := (others => 'U');
          AHB_slave_dummy_0_mem_wdata                        : out   std_logic_vector(31 downto 0);
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1) := (others => 'U');
          SADDRSEL_2                                         : in    std_logic_vector(9 to 9) := (others => 'U');
          xhdl1238_i_m_1                                     : out   std_logic_vector(0 to 0);
          xhdl1221                                           : in    std_logic_vector(1 to 1) := (others => 'U');
          arbRegSMCurrentState_3                             : out   std_logic;
          arbRegSMCurrentState_0                             : out   std_logic;
          MSS_READY                                          : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY             : in    std_logic := 'U';
          masterRegAddrSel                                   : in    std_logic := 'U';
          hsel2                                              : out   std_logic;
          hsel2_1                                            : out   std_logic;
          lsram_m7_a0_1_0                                    : in    std_logic := 'U';
          N_113                                              : in    std_logic := 'U';
          hready_m_xhdl341_1                                 : in    std_logic := 'U';
          N_68                                               : in    std_logic := 'U';
          N_27_i                                             : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE             : out   std_logic;
          N_156                                              : out   std_logic
        );
  end component;

    signal \regHADDR[25]\, \regHADDR[26]\, \regHADDR[2]\, 
        \xhdl1221[0]\, \xhdl1221[1]\, \SADDRSEL_0[1]\, 
        \arbRegSMCurrentState_ns_i_a2_0_RNIEVNF[0]\, 
        \M0GATEDHSIZE[0]\, \M0GATEDHSIZE[1]\, \SADDRSEL_2[9]\, 
        \arbRegSMCurrentState_3\, \arbRegSMCurrentState_0_d0\, 
        \xhdl1238_i_m_1[0]\, \xhdl1232_i_m[0]\, 
        \masterRegAddrSel\, N_112, \N_113\, hready_m_xhdl341_1, 
        \N_27_i\, \N_156\, N_68, hready_m_xhdl340, GND_net_1, 
        VCC_net_1 : std_logic;

    for all : COREAHBLITE_SLAVESTAGE_2
	Use entity work.COREAHBLITE_SLAVESTAGE_2(DEF_ARCH);
    for all : COREAHBLITE_MASTERSTAGE_2_1_0_3_0
	Use entity work.COREAHBLITE_MASTERSTAGE_2_1_0_3_0(DEF_ARCH);
    for all : COREAHBLITE_SLAVESTAGE_1
	Use entity work.COREAHBLITE_SLAVESTAGE_1(DEF_ARCH);
begin 

    SADDRSEL_0(1) <= \SADDRSEL_0[1]\;
    M0GATEDHSIZE(1) <= \M0GATEDHSIZE[1]\;
    M0GATEDHSIZE(0) <= \M0GATEDHSIZE[0]\;
    SADDRSEL_2(9) <= \SADDRSEL_2[9]\;
    arbRegSMCurrentState_3 <= \arbRegSMCurrentState_3\;
    arbRegSMCurrentState_0_d0 <= \arbRegSMCurrentState_0_d0\;
    masterRegAddrSel <= \masterRegAddrSel\;
    N_113 <= \N_113\;
    N_27_i <= \N_27_i\;
    N_156 <= \N_156\;

    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    slavestage_0 : COREAHBLITE_SLAVESTAGE_2
      port map(ahbcurr_state(1) => ahbcurr_state(1), 
        ahbcurr_state(0) => ahbcurr_state(0), xhdl1232_i_m(0) => 
        \xhdl1232_i_m[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0), 
        CoreAHBLite_0_AHBmslave0_HWDATA(31) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(31), 
        CoreAHBLite_0_AHBmslave0_HWDATA(30) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(30), 
        CoreAHBLite_0_AHBmslave0_HWDATA(29) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(29), 
        CoreAHBLite_0_AHBmslave0_HWDATA(28) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(28), 
        CoreAHBLite_0_AHBmslave0_HWDATA(27) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(27), 
        CoreAHBLite_0_AHBmslave0_HWDATA(26) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(26), 
        CoreAHBLite_0_AHBmslave0_HWDATA(25) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(25), 
        CoreAHBLite_0_AHBmslave0_HWDATA(24) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(24), 
        CoreAHBLite_0_AHBmslave0_HWDATA(23) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(23), 
        CoreAHBLite_0_AHBmslave0_HWDATA(22) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(22), 
        CoreAHBLite_0_AHBmslave0_HWDATA(21) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(21), 
        CoreAHBLite_0_AHBmslave0_HWDATA(20) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(20), 
        CoreAHBLite_0_AHBmslave0_HWDATA(19) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(19), 
        CoreAHBLite_0_AHBmslave0_HWDATA(18) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(18), 
        CoreAHBLite_0_AHBmslave0_HWDATA(17) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(17), 
        CoreAHBLite_0_AHBmslave0_HWDATA(16) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(16), 
        CoreAHBLite_0_AHBmslave0_HWDATA(15) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(15), 
        CoreAHBLite_0_AHBmslave0_HWDATA(14) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(14), 
        CoreAHBLite_0_AHBmslave0_HWDATA(13) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(13), 
        CoreAHBLite_0_AHBmslave0_HWDATA(12) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(12), 
        CoreAHBLite_0_AHBmslave0_HWDATA(11) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(11), 
        CoreAHBLite_0_AHBmslave0_HWDATA(10) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(10), 
        CoreAHBLite_0_AHBmslave0_HWDATA(9) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(9), 
        CoreAHBLite_0_AHBmslave0_HWDATA(8) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(8), 
        CoreAHBLite_0_AHBmslave0_HWDATA(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(7), 
        CoreAHBLite_0_AHBmslave0_HWDATA(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(6), 
        CoreAHBLite_0_AHBmslave0_HWDATA(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(5), 
        CoreAHBLite_0_AHBmslave0_HWDATA(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(4), 
        CoreAHBLite_0_AHBmslave0_HWDATA(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(3), 
        CoreAHBLite_0_AHBmslave0_HWDATA(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(2), 
        CoreAHBLite_0_AHBmslave0_HWDATA(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(1), 
        CoreAHBLite_0_AHBmslave0_HWDATA(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(0), 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0) => 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0), 
        arbRegSMCurrentState_RNIGOV71(12) => 
        arbRegSMCurrentState_RNIGOV71(12), xhdl1221(0) => 
        \xhdl1221[0]\, arbRegSMCurrentState_ns_i_a2_0_RNIEVNF(0)
         => \arbRegSMCurrentState_ns_i_a2_0_RNIEVNF[0]\, 
        regHADDR(26) => \regHADDR[26]\, regHADDR(25) => 
        \regHADDR[25]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(26) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(25) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25, 
        SADDRSEL_0(1) => \SADDRSEL_0[1]\, M0GATEDHSIZE(1) => 
        \M0GATEDHSIZE[1]\, M0GATEDHSIZE(0) => \M0GATEDHSIZE[0]\, 
        CoreAHBLite_0_AHBmslave0_HSIZE(1) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(1), 
        CoreAHBLite_0_AHBmslave0_HSIZE(0) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(0), arbRegSMCurrentState_3
         => arbRegSMCurrentState_0_3, arbRegSMCurrentState_0 => 
        arbRegSMCurrentState_0_0, MSS_READY => MSS_READY, 
        sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, N_99_i_0 => N_99_i_0, 
        hready_m_xhdl340 => hready_m_xhdl340, masterRegAddrSel
         => \masterRegAddrSel\, HWRITE_0_i_o2_2_1 => 
        HWRITE_0_i_o2_2_1, N_99 => N_99, N_112 => N_112, N_113
         => \N_113\, g0_1 => g0_1, N_101 => N_101);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    masterstage_0 : COREAHBLITE_MASTERSTAGE_2_1_0_3_0
      port map(
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0), 
        xhdl1221(1) => \xhdl1221[1]\, xhdl1221(0) => 
        \xhdl1221[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), 
        SADDRSEL_0(1) => \SADDRSEL_0[1]\, 
        arbRegSMCurrentState_ns_i_a2_0_RNIEVNF(0) => 
        \arbRegSMCurrentState_ns_i_a2_0_RNIEVNF[0]\, 
        M0GATEDHSIZE(1) => \M0GATEDHSIZE[1]\, M0GATEDHSIZE(0) => 
        \M0GATEDHSIZE[0]\, SADDRSEL_2(9) => \SADDRSEL_2[9]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(31) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(31), 
        CoreAHBLite_0_AHBmslave0_HRDATA(30) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(30), 
        CoreAHBLite_0_AHBmslave0_HRDATA(29) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(29), 
        CoreAHBLite_0_AHBmslave0_HRDATA(28) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(28), 
        CoreAHBLite_0_AHBmslave0_HRDATA(27) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(27), 
        CoreAHBLite_0_AHBmslave0_HRDATA(26) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(26), 
        CoreAHBLite_0_AHBmslave0_HRDATA(25) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(25), 
        CoreAHBLite_0_AHBmslave0_HRDATA(24) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(24), 
        CoreAHBLite_0_AHBmslave0_HRDATA(23) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(23), 
        CoreAHBLite_0_AHBmslave0_HRDATA(22) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(22), 
        CoreAHBLite_0_AHBmslave0_HRDATA(21) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(21), 
        CoreAHBLite_0_AHBmslave0_HRDATA(20) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(20), 
        CoreAHBLite_0_AHBmslave0_HRDATA(19) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(19), 
        CoreAHBLite_0_AHBmslave0_HRDATA(18) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(18), 
        CoreAHBLite_0_AHBmslave0_HRDATA(17) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(17), 
        CoreAHBLite_0_AHBmslave0_HRDATA(16) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(16), 
        CoreAHBLite_0_AHBmslave0_HRDATA(15) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(15), 
        CoreAHBLite_0_AHBmslave0_HRDATA(14) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(14), 
        CoreAHBLite_0_AHBmslave0_HRDATA(13) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(13), 
        CoreAHBLite_0_AHBmslave0_HRDATA(12) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(12), 
        CoreAHBLite_0_AHBmslave0_HRDATA(11) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(11), 
        CoreAHBLite_0_AHBmslave0_HRDATA(10) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(10), 
        CoreAHBLite_0_AHBmslave0_HRDATA(9) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(9), 
        CoreAHBLite_0_AHBmslave0_HRDATA(8) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(8), 
        CoreAHBLite_0_AHBmslave0_HRDATA(7) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(7), 
        CoreAHBLite_0_AHBmslave0_HRDATA(6) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(6), 
        CoreAHBLite_0_AHBmslave0_HRDATA(5) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(5), 
        CoreAHBLite_0_AHBmslave0_HRDATA(4) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(4), 
        CoreAHBLite_0_AHBmslave0_HRDATA(3) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(3), 
        CoreAHBLite_0_AHBmslave0_HRDATA(2) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(2), 
        CoreAHBLite_0_AHBmslave0_HRDATA(1) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(1), 
        CoreAHBLite_0_AHBmslave0_HRDATA(0) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(0), 
        reg_2x32_0_data_out(31) => reg_2x32_0_data_out(31), 
        reg_2x32_0_data_out(30) => reg_2x32_0_data_out(30), 
        reg_2x32_0_data_out(29) => reg_2x32_0_data_out(29), 
        reg_2x32_0_data_out(28) => reg_2x32_0_data_out(28), 
        reg_2x32_0_data_out(27) => reg_2x32_0_data_out(27), 
        reg_2x32_0_data_out(26) => reg_2x32_0_data_out(26), 
        reg_2x32_0_data_out(25) => reg_2x32_0_data_out(25), 
        reg_2x32_0_data_out(24) => reg_2x32_0_data_out(24), 
        reg_2x32_0_data_out(23) => reg_2x32_0_data_out(23), 
        reg_2x32_0_data_out(22) => reg_2x32_0_data_out(22), 
        reg_2x32_0_data_out(21) => reg_2x32_0_data_out(21), 
        reg_2x32_0_data_out(20) => reg_2x32_0_data_out(20), 
        reg_2x32_0_data_out(19) => reg_2x32_0_data_out(19), 
        reg_2x32_0_data_out(18) => reg_2x32_0_data_out(18), 
        reg_2x32_0_data_out(17) => reg_2x32_0_data_out(17), 
        reg_2x32_0_data_out(16) => reg_2x32_0_data_out(16), 
        reg_2x32_0_data_out(15) => reg_2x32_0_data_out(15), 
        reg_2x32_0_data_out(14) => reg_2x32_0_data_out(14), 
        reg_2x32_0_data_out(13) => reg_2x32_0_data_out(13), 
        reg_2x32_0_data_out(12) => reg_2x32_0_data_out(12), 
        reg_2x32_0_data_out(11) => reg_2x32_0_data_out(11), 
        reg_2x32_0_data_out(10) => reg_2x32_0_data_out(10), 
        reg_2x32_0_data_out(9) => reg_2x32_0_data_out(9), 
        reg_2x32_0_data_out(8) => reg_2x32_0_data_out(8), 
        reg_2x32_0_data_out(7) => reg_2x32_0_data_out(7), 
        reg_2x32_0_data_out(6) => reg_2x32_0_data_out(6), 
        reg_2x32_0_data_out(5) => reg_2x32_0_data_out(5), 
        reg_2x32_0_data_out(4) => reg_2x32_0_data_out(4), 
        reg_2x32_0_data_out(3) => reg_2x32_0_data_out(3), 
        reg_2x32_0_data_out(2) => reg_2x32_0_data_out(2), 
        reg_2x32_0_data_out(1) => reg_2x32_0_data_out(1), 
        reg_2x32_0_data_out(0) => reg_2x32_0_data_out(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0), 
        xhdl1238_i_m_1(0) => \xhdl1238_i_m_1[0]\, xhdl1232_i_m(0)
         => \xhdl1232_i_m[0]\, regHADDR_25 => \regHADDR[25]\, 
        regHADDR_26 => \regHADDR[26]\, regHADDR_2 => 
        \regHADDR[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1, 
        regHSIZE_1 => regHSIZE(1), xhdl1222_1 => xhdl1222(1), 
        M0GATEDHADDR_8 => M0GATEDHADDR(10), M0GATEDHADDR_4 => 
        M0GATEDHADDR(6), M0GATEDHADDR_3 => M0GATEDHADDR(5), 
        M0GATEDHADDR_2 => M0GATEDHADDR(4), M0GATEDHADDR_1 => 
        M0GATEDHADDR(3), M0GATEDHADDR_6 => M0GATEDHADDR(8), 
        M0GATEDHADDR_5 => M0GATEDHADDR(7), M0GATEDHADDR_7 => 
        M0GATEDHADDR(9), M0GATEDHADDR_0 => M0GATEDHADDR(2), 
        arbRegSMCurrentState_3 => \arbRegSMCurrentState_3\, 
        arbRegSMCurrentState_0 => \arbRegSMCurrentState_0_d0\, 
        MSS_READY => MSS_READY, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, 
        regHTRANS => regHTRANS, masterRegAddrSel => 
        \masterRegAddrSel\, N_112 => N_112, N_113 => \N_113\, 
        hready_m_xhdl341_1 => hready_m_xhdl341_1, N_121 => N_121, 
        N_27_i => \N_27_i\, N_124 => N_124, N_122 => N_122, N_123
         => N_123, N_99 => N_99, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, N_156 => \N_156\, 
        N_68 => N_68, N_128 => N_128, hready_m_xhdl340 => 
        hready_m_xhdl340, AMBA_SLAVE_0_HREADY_S1_i_m => 
        AMBA_SLAVE_0_HREADY_S1_i_m, defSlaveSMCurrentState => 
        defSlaveSMCurrentState, N_102 => N_102, HREADY_M_iv_i_0
         => HREADY_M_iv_i_0);
    
    slavestage_1 : COREAHBLITE_SLAVESTAGE_1
      port map(masterAddrInProg(3) => masterAddrInProg(3), 
        masterAddrInProg(2) => masterAddrInProg(2), 
        masterAddrInProg(1) => masterAddrInProg(1), regHADDR(2)
         => \regHADDR[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2, 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2) => 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0), 
        AHB_slave_dummy_0_mem_wdata(31) => 
        AHB_slave_dummy_0_mem_wdata(31), 
        AHB_slave_dummy_0_mem_wdata(30) => 
        AHB_slave_dummy_0_mem_wdata(30), 
        AHB_slave_dummy_0_mem_wdata(29) => 
        AHB_slave_dummy_0_mem_wdata(29), 
        AHB_slave_dummy_0_mem_wdata(28) => 
        AHB_slave_dummy_0_mem_wdata(28), 
        AHB_slave_dummy_0_mem_wdata(27) => 
        AHB_slave_dummy_0_mem_wdata(27), 
        AHB_slave_dummy_0_mem_wdata(26) => 
        AHB_slave_dummy_0_mem_wdata(26), 
        AHB_slave_dummy_0_mem_wdata(25) => 
        AHB_slave_dummy_0_mem_wdata(25), 
        AHB_slave_dummy_0_mem_wdata(24) => 
        AHB_slave_dummy_0_mem_wdata(24), 
        AHB_slave_dummy_0_mem_wdata(23) => 
        AHB_slave_dummy_0_mem_wdata(23), 
        AHB_slave_dummy_0_mem_wdata(22) => 
        AHB_slave_dummy_0_mem_wdata(22), 
        AHB_slave_dummy_0_mem_wdata(21) => 
        AHB_slave_dummy_0_mem_wdata(21), 
        AHB_slave_dummy_0_mem_wdata(20) => 
        AHB_slave_dummy_0_mem_wdata(20), 
        AHB_slave_dummy_0_mem_wdata(19) => 
        AHB_slave_dummy_0_mem_wdata(19), 
        AHB_slave_dummy_0_mem_wdata(18) => 
        AHB_slave_dummy_0_mem_wdata(18), 
        AHB_slave_dummy_0_mem_wdata(17) => 
        AHB_slave_dummy_0_mem_wdata(17), 
        AHB_slave_dummy_0_mem_wdata(16) => 
        AHB_slave_dummy_0_mem_wdata(16), 
        AHB_slave_dummy_0_mem_wdata(15) => 
        AHB_slave_dummy_0_mem_wdata(15), 
        AHB_slave_dummy_0_mem_wdata(14) => 
        AHB_slave_dummy_0_mem_wdata(14), 
        AHB_slave_dummy_0_mem_wdata(13) => 
        AHB_slave_dummy_0_mem_wdata(13), 
        AHB_slave_dummy_0_mem_wdata(12) => 
        AHB_slave_dummy_0_mem_wdata(12), 
        AHB_slave_dummy_0_mem_wdata(11) => 
        AHB_slave_dummy_0_mem_wdata(11), 
        AHB_slave_dummy_0_mem_wdata(10) => 
        AHB_slave_dummy_0_mem_wdata(10), 
        AHB_slave_dummy_0_mem_wdata(9) => 
        AHB_slave_dummy_0_mem_wdata(9), 
        AHB_slave_dummy_0_mem_wdata(8) => 
        AHB_slave_dummy_0_mem_wdata(8), 
        AHB_slave_dummy_0_mem_wdata(7) => 
        AHB_slave_dummy_0_mem_wdata(7), 
        AHB_slave_dummy_0_mem_wdata(6) => 
        AHB_slave_dummy_0_mem_wdata(6), 
        AHB_slave_dummy_0_mem_wdata(5) => 
        AHB_slave_dummy_0_mem_wdata(5), 
        AHB_slave_dummy_0_mem_wdata(4) => 
        AHB_slave_dummy_0_mem_wdata(4), 
        AHB_slave_dummy_0_mem_wdata(3) => 
        AHB_slave_dummy_0_mem_wdata(3), 
        AHB_slave_dummy_0_mem_wdata(2) => 
        AHB_slave_dummy_0_mem_wdata(2), 
        AHB_slave_dummy_0_mem_wdata(1) => 
        AHB_slave_dummy_0_mem_wdata(1), 
        AHB_slave_dummy_0_mem_wdata(0) => 
        AHB_slave_dummy_0_mem_wdata(0), SADDRSEL_0(1) => 
        \SADDRSEL_0[1]\, SADDRSEL_2(9) => \SADDRSEL_2[9]\, 
        xhdl1238_i_m_1(0) => \xhdl1238_i_m_1[0]\, xhdl1221(1) => 
        \xhdl1221[1]\, arbRegSMCurrentState_3 => 
        \arbRegSMCurrentState_3\, arbRegSMCurrentState_0 => 
        \arbRegSMCurrentState_0_d0\, MSS_READY => MSS_READY, 
        sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, masterRegAddrSel
         => \masterRegAddrSel\, hsel2 => hsel2, hsel2_1 => 
        hsel2_1, lsram_m7_a0_1_0 => lsram_m7_a0_1_0, N_113 => 
        \N_113\, hready_m_xhdl341_1 => hready_m_xhdl341_1, N_68
         => N_68, N_27_i => \N_27_i\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE => 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE, N_156 => \N_156\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity CoreAHBLite is

    port( regHSIZE                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : in    std_logic_vector(1 downto 0);
          xhdl1222                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : in    std_logic_vector(1 to 1);
          SADDRSEL_0                                           : out   std_logic_vector(1 to 1);
          M0GATEDHSIZE                                         : out   std_logic_vector(1 downto 0);
          M0GATEDHADDR                                         : out   std_logic_vector(10 downto 2);
          SADDRSEL_2                                           : out   std_logic_vector(9 to 9);
          CoreAHBLite_0_AHBmslave0_HRDATA                      : in    std_logic_vector(31 downto 0);
          reg_2x32_0_data_out                                  : in    std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : out   std_logic_vector(0 to 0);
          ahbcurr_state                                        : in    std_logic_vector(1 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA   : in    std_logic_vector(31 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA                      : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2              : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                        : out   std_logic_vector(12 to 12);
          CoreAHBLite_0_AHBmslave0_HSIZE                       : out   std_logic_vector(1 downto 0);
          masterAddrInProg                                     : out   std_logic_vector(3 downto 1);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR                : out   std_logic_vector(2 to 2);
          AHB_slave_dummy_0_mem_wdata                          : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : in    std_logic;
          arbRegSMCurrentState_3                               : out   std_logic;
          arbRegSMCurrentState_0_d0                            : out   std_logic;
          arbRegSMCurrentState_0_3                             : out   std_logic;
          arbRegSMCurrentState_0_0                             : out   std_logic;
          MSS_READY                                            : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : in    std_logic;
          regHTRANS                                            : out   std_logic;
          masterRegAddrSel                                     : out   std_logic;
          N_113                                                : out   std_logic;
          N_121                                                : out   std_logic;
          N_27_i                                               : out   std_logic;
          N_124                                                : out   std_logic;
          N_122                                                : out   std_logic;
          N_123                                                : out   std_logic;
          N_99                                                 : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY               : in    std_logic;
          N_156                                                : out   std_logic;
          N_128                                                : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                           : out   std_logic;
          defSlaveSMCurrentState                               : out   std_logic;
          N_102                                                : out   std_logic;
          HREADY_M_iv_i_0                                      : out   std_logic;
          N_99_i_0                                             : in    std_logic;
          HWRITE_0_i_o2_2_1                                    : out   std_logic;
          g0_1                                                 : out   std_logic;
          N_101                                                : out   std_logic;
          hsel2                                                : out   std_logic;
          hsel2_1                                              : out   std_logic;
          lsram_m7_a0_1_0                                      : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE               : out   std_logic
        );

end CoreAHBLite;

architecture DEF_ARCH of CoreAHBLite is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component COREAHBLITE_MATRIX4X16
    port( regHSIZE                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : in    std_logic_vector(1 downto 0) := (others => 'U');
          xhdl1222                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : in    std_logic_vector(1 to 1) := (others => 'U');
          SADDRSEL_0                                           : out   std_logic_vector(1 to 1);
          M0GATEDHSIZE                                         : out   std_logic_vector(1 downto 0);
          M0GATEDHADDR                                         : out   std_logic_vector(10 downto 2);
          SADDRSEL_2                                           : out   std_logic_vector(9 to 9);
          CoreAHBLite_0_AHBmslave0_HRDATA                      : in    std_logic_vector(31 downto 0) := (others => 'U');
          reg_2x32_0_data_out                                  : in    std_logic_vector(31 downto 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : out   std_logic_vector(0 to 0);
          ahbcurr_state                                        : in    std_logic_vector(1 downto 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA   : in    std_logic_vector(31 downto 0) := (others => 'U');
          CoreAHBLite_0_AHBmslave0_HWDATA                      : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2              : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                        : out   std_logic_vector(12 to 12);
          CoreAHBLite_0_AHBmslave0_HSIZE                       : out   std_logic_vector(1 downto 0);
          masterAddrInProg                                     : out   std_logic_vector(3 downto 1);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR                : out   std_logic_vector(2 to 2);
          AHB_slave_dummy_0_mem_wdata                          : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : in    std_logic := 'U';
          arbRegSMCurrentState_3                               : out   std_logic;
          arbRegSMCurrentState_0_d0                            : out   std_logic;
          arbRegSMCurrentState_0_3                             : out   std_logic;
          arbRegSMCurrentState_0_0                             : out   std_logic;
          MSS_READY                                            : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : in    std_logic := 'U';
          regHTRANS                                            : out   std_logic;
          masterRegAddrSel                                     : out   std_logic;
          N_113                                                : out   std_logic;
          N_121                                                : out   std_logic;
          N_27_i                                               : out   std_logic;
          N_124                                                : out   std_logic;
          N_122                                                : out   std_logic;
          N_123                                                : out   std_logic;
          N_99                                                 : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY               : in    std_logic := 'U';
          N_156                                                : out   std_logic;
          N_128                                                : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                           : out   std_logic;
          defSlaveSMCurrentState                               : out   std_logic;
          N_102                                                : out   std_logic;
          HREADY_M_iv_i_0                                      : out   std_logic;
          N_99_i_0                                             : in    std_logic := 'U';
          HWRITE_0_i_o2_2_1                                    : out   std_logic;
          g0_1                                                 : out   std_logic;
          N_101                                                : out   std_logic;
          hsel2                                                : out   std_logic;
          hsel2_1                                              : out   std_logic;
          lsram_m7_a0_1_0                                      : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE               : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal GND_net_1, VCC_net_1 : std_logic;

    for all : COREAHBLITE_MATRIX4X16
	Use entity work.COREAHBLITE_MATRIX4X16(DEF_ARCH);
begin 


    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    matrix4x16 : COREAHBLITE_MATRIX4X16
      port map(regHSIZE(1) => regHSIZE(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0), 
        xhdl1222(1) => xhdl1222(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), 
        SADDRSEL_0(1) => SADDRSEL_0(1), M0GATEDHSIZE(1) => 
        M0GATEDHSIZE(1), M0GATEDHSIZE(0) => M0GATEDHSIZE(0), 
        M0GATEDHADDR(10) => M0GATEDHADDR(10), M0GATEDHADDR(9) => 
        M0GATEDHADDR(9), M0GATEDHADDR(8) => M0GATEDHADDR(8), 
        M0GATEDHADDR(7) => M0GATEDHADDR(7), M0GATEDHADDR(6) => 
        M0GATEDHADDR(6), M0GATEDHADDR(5) => M0GATEDHADDR(5), 
        M0GATEDHADDR(4) => M0GATEDHADDR(4), M0GATEDHADDR(3) => 
        M0GATEDHADDR(3), M0GATEDHADDR(2) => M0GATEDHADDR(2), 
        SADDRSEL_2(9) => SADDRSEL_2(9), 
        CoreAHBLite_0_AHBmslave0_HRDATA(31) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(31), 
        CoreAHBLite_0_AHBmslave0_HRDATA(30) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(30), 
        CoreAHBLite_0_AHBmslave0_HRDATA(29) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(29), 
        CoreAHBLite_0_AHBmslave0_HRDATA(28) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(28), 
        CoreAHBLite_0_AHBmslave0_HRDATA(27) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(27), 
        CoreAHBLite_0_AHBmslave0_HRDATA(26) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(26), 
        CoreAHBLite_0_AHBmslave0_HRDATA(25) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(25), 
        CoreAHBLite_0_AHBmslave0_HRDATA(24) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(24), 
        CoreAHBLite_0_AHBmslave0_HRDATA(23) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(23), 
        CoreAHBLite_0_AHBmslave0_HRDATA(22) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(22), 
        CoreAHBLite_0_AHBmslave0_HRDATA(21) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(21), 
        CoreAHBLite_0_AHBmslave0_HRDATA(20) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(20), 
        CoreAHBLite_0_AHBmslave0_HRDATA(19) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(19), 
        CoreAHBLite_0_AHBmslave0_HRDATA(18) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(18), 
        CoreAHBLite_0_AHBmslave0_HRDATA(17) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(17), 
        CoreAHBLite_0_AHBmslave0_HRDATA(16) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(16), 
        CoreAHBLite_0_AHBmslave0_HRDATA(15) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(15), 
        CoreAHBLite_0_AHBmslave0_HRDATA(14) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(14), 
        CoreAHBLite_0_AHBmslave0_HRDATA(13) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(13), 
        CoreAHBLite_0_AHBmslave0_HRDATA(12) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(12), 
        CoreAHBLite_0_AHBmslave0_HRDATA(11) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(11), 
        CoreAHBLite_0_AHBmslave0_HRDATA(10) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(10), 
        CoreAHBLite_0_AHBmslave0_HRDATA(9) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(9), 
        CoreAHBLite_0_AHBmslave0_HRDATA(8) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(8), 
        CoreAHBLite_0_AHBmslave0_HRDATA(7) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(7), 
        CoreAHBLite_0_AHBmslave0_HRDATA(6) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(6), 
        CoreAHBLite_0_AHBmslave0_HRDATA(5) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(5), 
        CoreAHBLite_0_AHBmslave0_HRDATA(4) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(4), 
        CoreAHBLite_0_AHBmslave0_HRDATA(3) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(3), 
        CoreAHBLite_0_AHBmslave0_HRDATA(2) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(2), 
        CoreAHBLite_0_AHBmslave0_HRDATA(1) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(1), 
        CoreAHBLite_0_AHBmslave0_HRDATA(0) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(0), 
        reg_2x32_0_data_out(31) => reg_2x32_0_data_out(31), 
        reg_2x32_0_data_out(30) => reg_2x32_0_data_out(30), 
        reg_2x32_0_data_out(29) => reg_2x32_0_data_out(29), 
        reg_2x32_0_data_out(28) => reg_2x32_0_data_out(28), 
        reg_2x32_0_data_out(27) => reg_2x32_0_data_out(27), 
        reg_2x32_0_data_out(26) => reg_2x32_0_data_out(26), 
        reg_2x32_0_data_out(25) => reg_2x32_0_data_out(25), 
        reg_2x32_0_data_out(24) => reg_2x32_0_data_out(24), 
        reg_2x32_0_data_out(23) => reg_2x32_0_data_out(23), 
        reg_2x32_0_data_out(22) => reg_2x32_0_data_out(22), 
        reg_2x32_0_data_out(21) => reg_2x32_0_data_out(21), 
        reg_2x32_0_data_out(20) => reg_2x32_0_data_out(20), 
        reg_2x32_0_data_out(19) => reg_2x32_0_data_out(19), 
        reg_2x32_0_data_out(18) => reg_2x32_0_data_out(18), 
        reg_2x32_0_data_out(17) => reg_2x32_0_data_out(17), 
        reg_2x32_0_data_out(16) => reg_2x32_0_data_out(16), 
        reg_2x32_0_data_out(15) => reg_2x32_0_data_out(15), 
        reg_2x32_0_data_out(14) => reg_2x32_0_data_out(14), 
        reg_2x32_0_data_out(13) => reg_2x32_0_data_out(13), 
        reg_2x32_0_data_out(12) => reg_2x32_0_data_out(12), 
        reg_2x32_0_data_out(11) => reg_2x32_0_data_out(11), 
        reg_2x32_0_data_out(10) => reg_2x32_0_data_out(10), 
        reg_2x32_0_data_out(9) => reg_2x32_0_data_out(9), 
        reg_2x32_0_data_out(8) => reg_2x32_0_data_out(8), 
        reg_2x32_0_data_out(7) => reg_2x32_0_data_out(7), 
        reg_2x32_0_data_out(6) => reg_2x32_0_data_out(6), 
        reg_2x32_0_data_out(5) => reg_2x32_0_data_out(5), 
        reg_2x32_0_data_out(4) => reg_2x32_0_data_out(4), 
        reg_2x32_0_data_out(3) => reg_2x32_0_data_out(3), 
        reg_2x32_0_data_out(2) => reg_2x32_0_data_out(2), 
        reg_2x32_0_data_out(1) => reg_2x32_0_data_out(1), 
        reg_2x32_0_data_out(0) => reg_2x32_0_data_out(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0), 
        ahbcurr_state(1) => ahbcurr_state(1), ahbcurr_state(0)
         => ahbcurr_state(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10)
         => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0), 
        CoreAHBLite_0_AHBmslave0_HWDATA(31) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(31), 
        CoreAHBLite_0_AHBmslave0_HWDATA(30) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(30), 
        CoreAHBLite_0_AHBmslave0_HWDATA(29) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(29), 
        CoreAHBLite_0_AHBmslave0_HWDATA(28) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(28), 
        CoreAHBLite_0_AHBmslave0_HWDATA(27) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(27), 
        CoreAHBLite_0_AHBmslave0_HWDATA(26) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(26), 
        CoreAHBLite_0_AHBmslave0_HWDATA(25) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(25), 
        CoreAHBLite_0_AHBmslave0_HWDATA(24) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(24), 
        CoreAHBLite_0_AHBmslave0_HWDATA(23) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(23), 
        CoreAHBLite_0_AHBmslave0_HWDATA(22) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(22), 
        CoreAHBLite_0_AHBmslave0_HWDATA(21) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(21), 
        CoreAHBLite_0_AHBmslave0_HWDATA(20) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(20), 
        CoreAHBLite_0_AHBmslave0_HWDATA(19) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(19), 
        CoreAHBLite_0_AHBmslave0_HWDATA(18) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(18), 
        CoreAHBLite_0_AHBmslave0_HWDATA(17) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(17), 
        CoreAHBLite_0_AHBmslave0_HWDATA(16) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(16), 
        CoreAHBLite_0_AHBmslave0_HWDATA(15) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(15), 
        CoreAHBLite_0_AHBmslave0_HWDATA(14) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(14), 
        CoreAHBLite_0_AHBmslave0_HWDATA(13) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(13), 
        CoreAHBLite_0_AHBmslave0_HWDATA(12) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(12), 
        CoreAHBLite_0_AHBmslave0_HWDATA(11) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(11), 
        CoreAHBLite_0_AHBmslave0_HWDATA(10) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(10), 
        CoreAHBLite_0_AHBmslave0_HWDATA(9) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(9), 
        CoreAHBLite_0_AHBmslave0_HWDATA(8) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(8), 
        CoreAHBLite_0_AHBmslave0_HWDATA(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(7), 
        CoreAHBLite_0_AHBmslave0_HWDATA(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(6), 
        CoreAHBLite_0_AHBmslave0_HWDATA(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(5), 
        CoreAHBLite_0_AHBmslave0_HWDATA(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(4), 
        CoreAHBLite_0_AHBmslave0_HWDATA(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(3), 
        CoreAHBLite_0_AHBmslave0_HWDATA(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(2), 
        CoreAHBLite_0_AHBmslave0_HWDATA(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(1), 
        CoreAHBLite_0_AHBmslave0_HWDATA(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(0), 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0) => 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0), 
        arbRegSMCurrentState_RNIGOV71(12) => 
        arbRegSMCurrentState_RNIGOV71(12), 
        CoreAHBLite_0_AHBmslave0_HSIZE(1) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(1), 
        CoreAHBLite_0_AHBmslave0_HSIZE(0) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(0), masterAddrInProg(3)
         => masterAddrInProg(3), masterAddrInProg(2) => 
        masterAddrInProg(2), masterAddrInProg(1) => 
        masterAddrInProg(1), 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2) => 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2), 
        AHB_slave_dummy_0_mem_wdata(31) => 
        AHB_slave_dummy_0_mem_wdata(31), 
        AHB_slave_dummy_0_mem_wdata(30) => 
        AHB_slave_dummy_0_mem_wdata(30), 
        AHB_slave_dummy_0_mem_wdata(29) => 
        AHB_slave_dummy_0_mem_wdata(29), 
        AHB_slave_dummy_0_mem_wdata(28) => 
        AHB_slave_dummy_0_mem_wdata(28), 
        AHB_slave_dummy_0_mem_wdata(27) => 
        AHB_slave_dummy_0_mem_wdata(27), 
        AHB_slave_dummy_0_mem_wdata(26) => 
        AHB_slave_dummy_0_mem_wdata(26), 
        AHB_slave_dummy_0_mem_wdata(25) => 
        AHB_slave_dummy_0_mem_wdata(25), 
        AHB_slave_dummy_0_mem_wdata(24) => 
        AHB_slave_dummy_0_mem_wdata(24), 
        AHB_slave_dummy_0_mem_wdata(23) => 
        AHB_slave_dummy_0_mem_wdata(23), 
        AHB_slave_dummy_0_mem_wdata(22) => 
        AHB_slave_dummy_0_mem_wdata(22), 
        AHB_slave_dummy_0_mem_wdata(21) => 
        AHB_slave_dummy_0_mem_wdata(21), 
        AHB_slave_dummy_0_mem_wdata(20) => 
        AHB_slave_dummy_0_mem_wdata(20), 
        AHB_slave_dummy_0_mem_wdata(19) => 
        AHB_slave_dummy_0_mem_wdata(19), 
        AHB_slave_dummy_0_mem_wdata(18) => 
        AHB_slave_dummy_0_mem_wdata(18), 
        AHB_slave_dummy_0_mem_wdata(17) => 
        AHB_slave_dummy_0_mem_wdata(17), 
        AHB_slave_dummy_0_mem_wdata(16) => 
        AHB_slave_dummy_0_mem_wdata(16), 
        AHB_slave_dummy_0_mem_wdata(15) => 
        AHB_slave_dummy_0_mem_wdata(15), 
        AHB_slave_dummy_0_mem_wdata(14) => 
        AHB_slave_dummy_0_mem_wdata(14), 
        AHB_slave_dummy_0_mem_wdata(13) => 
        AHB_slave_dummy_0_mem_wdata(13), 
        AHB_slave_dummy_0_mem_wdata(12) => 
        AHB_slave_dummy_0_mem_wdata(12), 
        AHB_slave_dummy_0_mem_wdata(11) => 
        AHB_slave_dummy_0_mem_wdata(11), 
        AHB_slave_dummy_0_mem_wdata(10) => 
        AHB_slave_dummy_0_mem_wdata(10), 
        AHB_slave_dummy_0_mem_wdata(9) => 
        AHB_slave_dummy_0_mem_wdata(9), 
        AHB_slave_dummy_0_mem_wdata(8) => 
        AHB_slave_dummy_0_mem_wdata(8), 
        AHB_slave_dummy_0_mem_wdata(7) => 
        AHB_slave_dummy_0_mem_wdata(7), 
        AHB_slave_dummy_0_mem_wdata(6) => 
        AHB_slave_dummy_0_mem_wdata(6), 
        AHB_slave_dummy_0_mem_wdata(5) => 
        AHB_slave_dummy_0_mem_wdata(5), 
        AHB_slave_dummy_0_mem_wdata(4) => 
        AHB_slave_dummy_0_mem_wdata(4), 
        AHB_slave_dummy_0_mem_wdata(3) => 
        AHB_slave_dummy_0_mem_wdata(3), 
        AHB_slave_dummy_0_mem_wdata(2) => 
        AHB_slave_dummy_0_mem_wdata(2), 
        AHB_slave_dummy_0_mem_wdata(1) => 
        AHB_slave_dummy_0_mem_wdata(1), 
        AHB_slave_dummy_0_mem_wdata(0) => 
        AHB_slave_dummy_0_mem_wdata(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1 => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1, 
        arbRegSMCurrentState_3 => arbRegSMCurrentState_3, 
        arbRegSMCurrentState_0_d0 => arbRegSMCurrentState_0_d0, 
        arbRegSMCurrentState_0_3 => arbRegSMCurrentState_0_3, 
        arbRegSMCurrentState_0_0 => arbRegSMCurrentState_0_0, 
        MSS_READY => MSS_READY, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, 
        regHTRANS => regHTRANS, masterRegAddrSel => 
        masterRegAddrSel, N_113 => N_113, N_121 => N_121, N_27_i
         => N_27_i, N_124 => N_124, N_122 => N_122, N_123 => 
        N_123, N_99 => N_99, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, N_156 => N_156, 
        N_128 => N_128, AMBA_SLAVE_0_HREADY_S1_i_m => 
        AMBA_SLAVE_0_HREADY_S1_i_m, defSlaveSMCurrentState => 
        defSlaveSMCurrentState, N_102 => N_102, HREADY_M_iv_i_0
         => HREADY_M_iv_i_0, N_99_i_0 => N_99_i_0, 
        HWRITE_0_i_o2_2_1 => HWRITE_0_i_o2_2_1, g0_1 => g0_1, 
        N_101 => N_101, hsel2 => hsel2, hsel2_1 => hsel2_1, 
        lsram_m7_a0_1_0 => lsram_m7_a0_1_0, 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE => 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_CCC_0_FCCC is

    port( sha256_system_sb_0_FIC_0_CLK                       : out   std_logic;
          FIC_0_LOCK                                         : out   std_logic;
          FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : in    std_logic
        );

end sha256_system_sb_CCC_0_FCCC;

architecture DEF_ARCH of sha256_system_sb_CCC_0_FCCC is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CCC

            generic (INIT:std_logic_vector(209 downto 0) := "00" & x"0000000000000000000000000000000000000000000000000000"; 
        VCOFREQUENCY:real := 0.0);

    port( Y0              : out   std_logic;
          Y1              : out   std_logic;
          Y2              : out   std_logic;
          Y3              : out   std_logic;
          PRDATA          : out   std_logic_vector(7 downto 0);
          LOCK            : out   std_logic;
          BUSY            : out   std_logic;
          CLK0            : in    std_logic := 'U';
          CLK1            : in    std_logic := 'U';
          CLK2            : in    std_logic := 'U';
          CLK3            : in    std_logic := 'U';
          NGMUX0_SEL      : in    std_logic := 'U';
          NGMUX1_SEL      : in    std_logic := 'U';
          NGMUX2_SEL      : in    std_logic := 'U';
          NGMUX3_SEL      : in    std_logic := 'U';
          NGMUX0_HOLD_N   : in    std_logic := 'U';
          NGMUX1_HOLD_N   : in    std_logic := 'U';
          NGMUX2_HOLD_N   : in    std_logic := 'U';
          NGMUX3_HOLD_N   : in    std_logic := 'U';
          NGMUX0_ARST_N   : in    std_logic := 'U';
          NGMUX1_ARST_N   : in    std_logic := 'U';
          NGMUX2_ARST_N   : in    std_logic := 'U';
          NGMUX3_ARST_N   : in    std_logic := 'U';
          PLL_BYPASS_N    : in    std_logic := 'U';
          PLL_ARST_N      : in    std_logic := 'U';
          PLL_POWERDOWN_N : in    std_logic := 'U';
          GPD0_ARST_N     : in    std_logic := 'U';
          GPD1_ARST_N     : in    std_logic := 'U';
          GPD2_ARST_N     : in    std_logic := 'U';
          GPD3_ARST_N     : in    std_logic := 'U';
          PRESET_N        : in    std_logic := 'U';
          PCLK            : in    std_logic := 'U';
          PSEL            : in    std_logic := 'U';
          PENABLE         : in    std_logic := 'U';
          PWRITE          : in    std_logic := 'U';
          PADDR           : in    std_logic_vector(7 downto 2) := (others => 'U');
          PWDATA          : in    std_logic_vector(7 downto 0) := (others => 'U');
          CLK0_PAD        : in    std_logic := 'U';
          CLK1_PAD        : in    std_logic := 'U';
          CLK2_PAD        : in    std_logic := 'U';
          CLK3_PAD        : in    std_logic := 'U';
          GL0             : out   std_logic;
          GL1             : out   std_logic;
          GL2             : out   std_logic;
          GL3             : out   std_logic;
          RCOSC_25_50MHZ  : in    std_logic := 'U';
          RCOSC_1MHZ      : in    std_logic := 'U';
          XTLOSC          : in    std_logic := 'U'
        );
  end component;

    signal GL0_net, VCC_net_1, GND_net_1 : std_logic;
    signal nc8, nc7, nc6, nc2, nc5, nc4, nc3, nc1 : std_logic;

begin 


    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    GL0_INST : CLKINT
      port map(A => GL0_net, Y => sha256_system_sb_0_FIC_0_CLK);
    
    CCC_INST : CCC

              generic map(INIT => "00" & x"000007FB8000044D74000318C6318C1F18C61EC0404040400301",
         VCOFREQUENCY => 800.0)

      port map(Y0 => OPEN, Y1 => OPEN, Y2 => OPEN, Y3 => OPEN, 
        PRDATA(7) => nc8, PRDATA(6) => nc7, PRDATA(5) => nc6, 
        PRDATA(4) => nc2, PRDATA(3) => nc5, PRDATA(2) => nc4, 
        PRDATA(1) => nc3, PRDATA(0) => nc1, LOCK => FIC_0_LOCK, 
        BUSY => OPEN, CLK0 => VCC_net_1, CLK1 => VCC_net_1, CLK2
         => VCC_net_1, CLK3 => VCC_net_1, NGMUX0_SEL => GND_net_1, 
        NGMUX1_SEL => GND_net_1, NGMUX2_SEL => GND_net_1, 
        NGMUX3_SEL => GND_net_1, NGMUX0_HOLD_N => VCC_net_1, 
        NGMUX1_HOLD_N => VCC_net_1, NGMUX2_HOLD_N => VCC_net_1, 
        NGMUX3_HOLD_N => VCC_net_1, NGMUX0_ARST_N => VCC_net_1, 
        NGMUX1_ARST_N => VCC_net_1, NGMUX2_ARST_N => VCC_net_1, 
        NGMUX3_ARST_N => VCC_net_1, PLL_BYPASS_N => VCC_net_1, 
        PLL_ARST_N => VCC_net_1, PLL_POWERDOWN_N => VCC_net_1, 
        GPD0_ARST_N => VCC_net_1, GPD1_ARST_N => VCC_net_1, 
        GPD2_ARST_N => VCC_net_1, GPD3_ARST_N => VCC_net_1, 
        PRESET_N => GND_net_1, PCLK => VCC_net_1, PSEL => 
        VCC_net_1, PENABLE => VCC_net_1, PWRITE => VCC_net_1, 
        PADDR(7) => VCC_net_1, PADDR(6) => VCC_net_1, PADDR(5)
         => VCC_net_1, PADDR(4) => VCC_net_1, PADDR(3) => 
        VCC_net_1, PADDR(2) => VCC_net_1, PWDATA(7) => VCC_net_1, 
        PWDATA(6) => VCC_net_1, PWDATA(5) => VCC_net_1, PWDATA(4)
         => VCC_net_1, PWDATA(3) => VCC_net_1, PWDATA(2) => 
        VCC_net_1, PWDATA(1) => VCC_net_1, PWDATA(0) => VCC_net_1, 
        CLK0_PAD => GND_net_1, CLK1_PAD => GND_net_1, CLK2_PAD
         => GND_net_1, CLK3_PAD => GND_net_1, GL0 => GL0_net, GL1
         => OPEN, GL2 => OPEN, GL3 => OPEN, RCOSC_25_50MHZ => 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC, 
        RCOSC_1MHZ => GND_net_1, XTLOSC => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity AHBLSramIf is

    port( CoreAHBLite_0_AHBmslave0_HSIZE                     : in    std_logic_vector(1 downto 0);
          M0GATEDHADDR                                       : in    std_logic_vector(10 downto 2);
          ahbsram_addr                                       : out   std_logic_vector(12 downto 0);
          ahbcurr_state                                      : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2            : in    std_logic_vector(0 to 0);
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1);
          ahbsram_size_a0                                    : out   std_logic_vector(1 to 1);
          ahbsram_size                                       : out   std_logic_vector(0 to 0);
          ahbsram_size_0_0                                   : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE  : in    std_logic_vector(1 to 1);
          regHSIZE                                           : in    std_logic_vector(1 to 1);
          M0GATEDHSIZE                                       : in    std_logic_vector(1 downto 0);
          arbRegSMCurrentState_RNIGOV71                      : in    std_logic_vector(12 to 12);
          ahbsram_size_a1                                    : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : in    std_logic_vector(1 to 1);
          HSIZE_d_1                                          : out   std_logic;
          arbRegSMCurrentState_3                             : in    std_logic;
          arbRegSMCurrentState_0                             : in    std_logic;
          MSS_READY                                          : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic;
          N_121                                              : in    std_logic;
          N_124                                              : in    std_logic;
          N_123                                              : in    std_logic;
          N_122                                              : in    std_logic;
          HWRITE_d                                           : out   std_logic;
          N_27_i                                             : in    std_logic;
          ahbsram_req_d1                                     : out   std_logic;
          N_99                                               : out   std_logic;
          N_113                                              : in    std_logic;
          sramahb_ack                                        : in    std_logic;
          N_44                                               : out   std_logic;
          g0_1                                               : in    std_logic;
          HWRITE_0_i_o2_2_1                                  : in    std_logic;
          ahbsram_write                                      : out   std_logic;
          N_99_i_0                                           : out   std_logic;
          masterRegAddrSel                                   : in    std_logic;
          regHTRANS                                          : in    std_logic;
          N_102                                              : in    std_logic;
          N_101                                              : in    std_logic
        );

end AHBLSramIf;

architecture DEF_ARCH of AHBLSramIf is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal VCC_net_1, N_57_i_0, GND_net_1, \HSIZE_d[0]_net_1\, 
        \HSIZE_d_1\, HWRITE_d_net_1, ahbsram_req_d1_net_1, \N_99\, 
        \ahbcurr_state[0]_net_1\, N_59_i_0, 
        \ahbcurr_state[1]_net_1\, N_61_i_0, 
        \ahbsram_size_a0_0[1]_net_1\, \N_44\, ahbsram_N_5_mux, 
        \HSIZE_d_RNI75451[0]_net_1\, \g1_0_0\, N_109, N_110, 
        \validahbcmd_i_o2_0_0\, N_105 : std_logic;

begin 

    ahbcurr_state(1) <= \ahbcurr_state[1]_net_1\;
    ahbcurr_state(0) <= \ahbcurr_state[0]_net_1\;
    HSIZE_d_1 <= \HSIZE_d_1\;
    HWRITE_d <= HWRITE_d_net_1;
    ahbsram_req_d1 <= ahbsram_req_d1_net_1;
    N_99 <= \N_99\;
    N_44 <= \N_44\;

    \HWRITE_d\ : SLE
      port map(D => N_27_i, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => N_57_i_0, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        HWRITE_d_net_1);
    
    \HADDR_d[1]\ : SLE
      port map(D => N_123, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => N_57_i_0, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        ahbsram_addr(1));
    
    \ahbsram_size_a0[1]\ : CFG4
      generic map(INIT => x"4000")

      port map(A => N_113, B => \ahbsram_size_a0_0[1]_net_1\, C
         => arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0), D => 
        SADDRSEL_0(1), Y => ahbsram_size_a0(1));
    
    \HSIZE_d[1]\ : SLE
      port map(D => CoreAHBLite_0_AHBmslave0_HSIZE(1), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \HSIZE_d_1\);
    
    g1_0_0 : CFG3
      generic map(INIT => x"0E")

      port map(A => arbRegSMCurrentState_3, B => 
        arbRegSMCurrentState_0, C => HWRITE_0_i_o2_2_1, Y => 
        \g1_0_0\);
    
    \ahbcurr_state_RNI18T82[0]\ : CFG3
      generic map(INIT => x"40")

      port map(A => arbRegSMCurrentState_RNIGOV71(12), B => 
        M0GATEDHSIZE(0), C => \N_44\, Y => ahbsram_N_5_mux);
    
    \ahbcurr_state_RNIFCRM[0]\ : CFG2
      generic map(INIT => x"1")

      port map(A => \ahbcurr_state[0]_net_1\, B => 
        \ahbcurr_state[1]_net_1\, Y => N_99_i_0);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \ahbcurr_state[0]\ : SLE
      port map(D => N_59_i_0, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \ahbcurr_state[0]_net_1\);
    
    \HSIZE_d_RNI75451[0]\ : CFG3
      generic map(INIT => x"1D")

      port map(A => \HSIZE_d[0]_net_1\, B => \N_44\, C => 
        M0GATEDHSIZE(0), Y => \HSIZE_d_RNI75451[0]_net_1\);
    
    \ahbsram_req_d1\ : SLE
      port map(D => \N_99\, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        ahbsram_req_d1_net_1);
    
    \HADDR_d[9]\ : SLE
      port map(D => M0GATEDHADDR(9), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(9));
    
    \HSIZE_d_RNIPV3D2[1]\ : CFG4
      generic map(INIT => x"E222")

      port map(A => \HSIZE_d_1\, B => \N_44\, C => \g1_0_0\, D
         => M0GATEDHSIZE(1), Y => ahbsram_size_0_0(1));
    
    \HADDR_d[8]\ : SLE
      port map(D => M0GATEDHADDR(8), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(8));
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \ahbcurr_state[1]\ : SLE
      port map(D => N_61_i_0, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \ahbcurr_state[1]_net_1\);
    
    \HADDR_d[12]\ : SLE
      port map(D => N_121, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => N_57_i_0, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        ahbsram_addr(12));
    
    \ahbsram_size_a1[1]\ : CFG3
      generic map(INIT => x"80")

      port map(A => arbRegSMCurrentState_RNIGOV71(12), B => 
        M0GATEDHSIZE(1), C => \N_44\, Y => ahbsram_size_a1(1));
    
    validahbcmd_i_o2_0 : CFG4
      generic map(INIT => x"ABBB")

      port map(A => \validahbcmd_i_o2_0_0\, B => 
        arbRegSMCurrentState_RNIGOV71(12), C => g0_1, D => 
        SADDRSEL_0(1), Y => N_105);
    
    \HADDR_d[3]\ : SLE
      port map(D => M0GATEDHADDR(3), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(3));
    
    \HADDR_d[10]\ : SLE
      port map(D => M0GATEDHADDR(10), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(10));
    
    \ahbcurr_state_ns_1_0_.m5_i_m3\ : CFG3
      generic map(INIT => x"72")

      port map(A => \ahbcurr_state[0]_net_1\, B => sramahb_ack, C
         => N_27_i, Y => N_109);
    
    \ahbcurr_state_RNI1OBQ[0]\ : CFG3
      generic map(INIT => x"CD")

      port map(A => \ahbcurr_state[0]_net_1\, B => sramahb_ack, C
         => \ahbcurr_state[1]_net_1\, Y => \N_44\);
    
    \HSIZE_d[0]\ : SLE
      port map(D => CoreAHBLite_0_AHBmslave0_HSIZE(0), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \HSIZE_d[0]_net_1\);
    
    validahbcmd_i_o2 : CFG2
      generic map(INIT => x"E")

      port map(A => \ahbcurr_state[0]_net_1\, B => 
        \ahbcurr_state[1]_net_1\, Y => \N_99\);
    
    \ahbcurr_state_ns_1_0_.N_59_i\ : CFG4
      generic map(INIT => x"4050")

      port map(A => \ahbcurr_state[1]_net_1\, B => 
        \ahbcurr_state[0]_net_1\, C => N_109, D => N_105, Y => 
        N_59_i_0);
    
    \ahbcurr_state_ns_1_0_.N_61_i\ : CFG4
      generic map(INIT => x"2030")

      port map(A => \ahbcurr_state[1]_net_1\, B => 
        \ahbcurr_state[0]_net_1\, C => N_110, D => N_105, Y => 
        N_61_i_0);
    
    \HADDR_d[7]\ : SLE
      port map(D => M0GATEDHADDR(7), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(7));
    
    \HADDR_d[6]\ : SLE
      port map(D => M0GATEDHADDR(6), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(6));
    
    \ahbcurr_state_ns_1_0_.m8_i_m3\ : CFG3
      generic map(INIT => x"27")

      port map(A => \ahbcurr_state[1]_net_1\, B => sramahb_ack, C
         => N_27_i, Y => N_110);
    
    validahbcmd_i_o2_0_0_RNI9CFP4 : CFG3
      generic map(INIT => x"01")

      port map(A => \validahbcmd_i_o2_0_0\, B => N_101, C => 
        \N_99\, Y => N_57_i_0);
    
    HWRITE_d_RNIGTAK : CFG4
      generic map(INIT => x"0200")

      port map(A => HWRITE_d_net_1, B => ahbsram_req_d1_net_1, C
         => sramahb_ack, D => \N_99\, Y => ahbsram_write);
    
    \HADDR_d[2]\ : SLE
      port map(D => M0GATEDHADDR(2), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(2));
    
    \HADDR_d[4]\ : SLE
      port map(D => M0GATEDHADDR(4), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(4));
    
    \HADDR_d[5]\ : SLE
      port map(D => M0GATEDHADDR(5), CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => N_57_i_0, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => ahbsram_addr(5));
    
    \ahbsram_size_a0_0[1]\ : CFG4
      generic map(INIT => x"A088")

      port map(A => \N_44\, B => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1), C
         => regHSIZE(1), D => masterRegAddrSel, Y => 
        \ahbsram_size_a0_0[1]_net_1\);
    
    \HSIZE_d_RNI5M656[0]\ : CFG4
      generic map(INIT => x"80D5")

      port map(A => ahbsram_N_5_mux, B => SADDRSEL_0(1), C => 
        g0_1, D => \HSIZE_d_RNI75451[0]_net_1\, Y => 
        ahbsram_size(0));
    
    \HADDR_d[0]\ : SLE
      port map(D => N_124, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => N_57_i_0, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        ahbsram_addr(0));
    
    \HADDR_d[11]\ : SLE
      port map(D => N_122, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => N_57_i_0, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        ahbsram_addr(11));
    
    validahbcmd_i_o2_0_0 : CFG4
      generic map(INIT => x"FF27")

      port map(A => masterRegAddrSel, B => regHTRANS, C => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), D
         => N_102, Y => \validahbcmd_i_o2_0_0\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_1 is

    port( sramcurr_state                  : in    std_logic_vector(1 downto 0);
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(23 downto 16);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(23 downto 16);
          ahbsram_addr                    : in    std_logic_vector(12 downto 0);
          ahbsram_req_d1                  : in    std_logic;
          HWRITE_d                        : in    std_logic;
          sramahb_ack                     : in    std_logic;
          N_99                            : in    std_logic;
          g0_5                            : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic;
          MSS_READY                       : in    std_logic
        );

end sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_1;

architecture DEF_ARCH of 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_1 is 

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component RAM1K18
    generic (MEMORYFILE:string := "");

    port( A_DOUT        : out   std_logic_vector(17 downto 0);
          B_DOUT        : out   std_logic_vector(17 downto 0);
          BUSY          : out   std_logic;
          A_CLK         : in    std_logic := 'U';
          A_DOUT_CLK    : in    std_logic := 'U';
          A_ARST_N      : in    std_logic := 'U';
          A_DOUT_EN     : in    std_logic := 'U';
          A_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DOUT_CLK    : in    std_logic := 'U';
          B_ARST_N      : in    std_logic := 'U';
          B_DOUT_EN     : in    std_logic := 'U';
          B_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_EN          : in    std_logic := 'U';
          A_DOUT_LAT    : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic := 'U';
          B_EN          : in    std_logic := 'U';
          B_DOUT_LAT    : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic := 'U';
          SII_LOCK      : in    std_logic := 'U'
        );
  end component;

    signal g0_3_0, g0_4_1, \sram_wen_mem[2]\, VCC_net_1, 
        GND_net_1 : std_logic;
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc25, nc20, nc27, 
        nc9, nc22, nc28, nc14, nc5, nc21, nc15, nc3, nc10, nc7, 
        nc17, nc4, nc12, nc2, nc23, nc18, nc26, nc6, nc11
         : std_logic;

begin 


    block1_RNO_0 : CFG3
      generic map(INIT => x"08")

      port map(A => g0_3_0, B => N_99, C => sramcurr_state(0), Y
         => g0_4_1);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    block1_RNO_1 : CFG4
      generic map(INIT => x"0004")

      port map(A => ahbsram_req_d1, B => HWRITE_d, C => 
        sramcurr_state(1), D => sramahb_ack, Y => g0_3_0);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    block1_RNO : CFG4
      generic map(INIT => x"40F0")

      port map(A => ahbsram_addr(0), B => ahbsram_addr(1), C => 
        g0_4_1, D => g0_5, Y => \sram_wen_mem[2]\);
    
    block1 : RAM1K18
      port map(A_DOUT(17) => nc24, A_DOUT(16) => nc1, A_DOUT(15)
         => nc8, A_DOUT(14) => nc13, A_DOUT(13) => nc16, 
        A_DOUT(12) => nc19, A_DOUT(11) => nc25, A_DOUT(10) => 
        nc20, A_DOUT(9) => nc27, A_DOUT(8) => nc9, A_DOUT(7) => 
        ram_rdata_lsram_xhdl1(23), A_DOUT(6) => 
        ram_rdata_lsram_xhdl1(22), A_DOUT(5) => 
        ram_rdata_lsram_xhdl1(21), A_DOUT(4) => 
        ram_rdata_lsram_xhdl1(20), A_DOUT(3) => 
        ram_rdata_lsram_xhdl1(19), A_DOUT(2) => 
        ram_rdata_lsram_xhdl1(18), A_DOUT(1) => 
        ram_rdata_lsram_xhdl1(17), A_DOUT(0) => 
        ram_rdata_lsram_xhdl1(16), B_DOUT(17) => nc22, B_DOUT(16)
         => nc28, B_DOUT(15) => nc14, B_DOUT(14) => nc5, 
        B_DOUT(13) => nc21, B_DOUT(12) => nc15, B_DOUT(11) => nc3, 
        B_DOUT(10) => nc10, B_DOUT(9) => nc7, B_DOUT(8) => nc17, 
        B_DOUT(7) => nc4, B_DOUT(6) => nc12, B_DOUT(5) => nc2, 
        B_DOUT(4) => nc23, B_DOUT(3) => nc18, B_DOUT(2) => nc26, 
        B_DOUT(1) => nc6, B_DOUT(0) => nc11, BUSY => OPEN, A_CLK
         => sha256_system_sb_0_FIC_0_CLK, A_DOUT_CLK => VCC_net_1, 
        A_ARST_N => MSS_READY, A_DOUT_EN => VCC_net_1, A_BLK(2)
         => VCC_net_1, A_BLK(1) => VCC_net_1, A_BLK(0) => 
        VCC_net_1, A_DOUT_ARST_N => VCC_net_1, A_DOUT_SRST_N => 
        VCC_net_1, A_DIN(17) => GND_net_1, A_DIN(16) => GND_net_1, 
        A_DIN(15) => GND_net_1, A_DIN(14) => GND_net_1, A_DIN(13)
         => GND_net_1, A_DIN(12) => GND_net_1, A_DIN(11) => 
        GND_net_1, A_DIN(10) => GND_net_1, A_DIN(9) => GND_net_1, 
        A_DIN(8) => GND_net_1, A_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(23), A_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(22), A_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(21), A_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(20), A_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(19), A_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(18), A_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(17), A_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(16), A_ADDR(13) => 
        ahbsram_addr(12), A_ADDR(12) => ahbsram_addr(11), 
        A_ADDR(11) => ahbsram_addr(10), A_ADDR(10) => 
        ahbsram_addr(9), A_ADDR(9) => ahbsram_addr(8), A_ADDR(8)
         => ahbsram_addr(7), A_ADDR(7) => ahbsram_addr(6), 
        A_ADDR(6) => ahbsram_addr(5), A_ADDR(5) => 
        ahbsram_addr(4), A_ADDR(4) => ahbsram_addr(3), A_ADDR(3)
         => ahbsram_addr(2), A_ADDR(2) => GND_net_1, A_ADDR(1)
         => GND_net_1, A_ADDR(0) => GND_net_1, A_WEN(1) => 
        GND_net_1, A_WEN(0) => \sram_wen_mem[2]\, B_CLK => 
        sha256_system_sb_0_FIC_0_CLK, B_DOUT_CLK => VCC_net_1, 
        B_ARST_N => MSS_READY, B_DOUT_EN => VCC_net_1, B_BLK(2)
         => VCC_net_1, B_BLK(1) => VCC_net_1, B_BLK(0) => 
        VCC_net_1, B_DOUT_ARST_N => VCC_net_1, B_DOUT_SRST_N => 
        VCC_net_1, B_DIN(17) => GND_net_1, B_DIN(16) => GND_net_1, 
        B_DIN(15) => GND_net_1, B_DIN(14) => GND_net_1, B_DIN(13)
         => GND_net_1, B_DIN(12) => GND_net_1, B_DIN(11) => 
        GND_net_1, B_DIN(10) => GND_net_1, B_DIN(9) => GND_net_1, 
        B_DIN(8) => GND_net_1, B_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(23), B_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(22), B_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(21), B_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(20), B_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(19), B_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(18), B_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(17), B_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(16), B_ADDR(13) => 
        ahbsram_addr(12), B_ADDR(12) => ahbsram_addr(11), 
        B_ADDR(11) => ahbsram_addr(10), B_ADDR(10) => 
        ahbsram_addr(9), B_ADDR(9) => ahbsram_addr(8), B_ADDR(8)
         => ahbsram_addr(7), B_ADDR(7) => ahbsram_addr(6), 
        B_ADDR(6) => ahbsram_addr(5), B_ADDR(5) => 
        ahbsram_addr(4), B_ADDR(4) => ahbsram_addr(3), B_ADDR(3)
         => ahbsram_addr(2), B_ADDR(2) => GND_net_1, B_ADDR(1)
         => GND_net_1, B_ADDR(0) => GND_net_1, B_WEN(1) => 
        GND_net_1, B_WEN(0) => GND_net_1, A_EN => VCC_net_1, 
        A_DOUT_LAT => VCC_net_1, A_WIDTH(2) => GND_net_1, 
        A_WIDTH(1) => VCC_net_1, A_WIDTH(0) => VCC_net_1, A_WMODE
         => GND_net_1, B_EN => VCC_net_1, B_DOUT_LAT => VCC_net_1, 
        B_WIDTH(2) => GND_net_1, B_WIDTH(1) => VCC_net_1, 
        B_WIDTH(0) => VCC_net_1, B_WMODE => GND_net_1, SII_LOCK
         => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_2 is

    port( sramcurr_state                  : in    std_logic_vector(1 downto 0);
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(31 downto 24);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(31 downto 24);
          ahbsram_addr                    : in    std_logic_vector(12 downto 0);
          HWRITE_d                        : in    std_logic;
          sramahb_ack                     : in    std_logic;
          ahbsram_req_d1                  : in    std_logic;
          N_99                            : in    std_logic;
          g0_5                            : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic;
          MSS_READY                       : in    std_logic
        );

end sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_2;

architecture DEF_ARCH of 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_2 is 

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component RAM1K18
    generic (MEMORYFILE:string := "");

    port( A_DOUT        : out   std_logic_vector(17 downto 0);
          B_DOUT        : out   std_logic_vector(17 downto 0);
          BUSY          : out   std_logic;
          A_CLK         : in    std_logic := 'U';
          A_DOUT_CLK    : in    std_logic := 'U';
          A_ARST_N      : in    std_logic := 'U';
          A_DOUT_EN     : in    std_logic := 'U';
          A_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DOUT_CLK    : in    std_logic := 'U';
          B_ARST_N      : in    std_logic := 'U';
          B_DOUT_EN     : in    std_logic := 'U';
          B_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_EN          : in    std_logic := 'U';
          A_DOUT_LAT    : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic := 'U';
          B_EN          : in    std_logic := 'U';
          B_DOUT_LAT    : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic := 'U';
          SII_LOCK      : in    std_logic := 'U'
        );
  end component;

    signal g0_4, g0_6, \sram_wen_mem[3]\, VCC_net_1, GND_net_1
         : std_logic;
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc25, nc20, nc27, 
        nc9, nc22, nc28, nc14, nc5, nc21, nc15, nc3, nc10, nc7, 
        nc17, nc4, nc12, nc2, nc23, nc18, nc26, nc6, nc11
         : std_logic;

begin 


    block1_RNO_0 : CFG3
      generic map(INIT => x"40")

      port map(A => ahbsram_req_d1, B => g0_4, C => N_99, Y => 
        g0_6);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    block1_RNO_1 : CFG4
      generic map(INIT => x"0010")

      port map(A => sramcurr_state(1), B => sramcurr_state(0), C
         => HWRITE_d, D => sramahb_ack, Y => g0_4);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    block1_RNO : CFG4
      generic map(INIT => x"80F0")

      port map(A => ahbsram_addr(0), B => ahbsram_addr(1), C => 
        g0_6, D => g0_5, Y => \sram_wen_mem[3]\);
    
    block1 : RAM1K18
      port map(A_DOUT(17) => nc24, A_DOUT(16) => nc1, A_DOUT(15)
         => nc8, A_DOUT(14) => nc13, A_DOUT(13) => nc16, 
        A_DOUT(12) => nc19, A_DOUT(11) => nc25, A_DOUT(10) => 
        nc20, A_DOUT(9) => nc27, A_DOUT(8) => nc9, A_DOUT(7) => 
        ram_rdata_lsram_xhdl1(31), A_DOUT(6) => 
        ram_rdata_lsram_xhdl1(30), A_DOUT(5) => 
        ram_rdata_lsram_xhdl1(29), A_DOUT(4) => 
        ram_rdata_lsram_xhdl1(28), A_DOUT(3) => 
        ram_rdata_lsram_xhdl1(27), A_DOUT(2) => 
        ram_rdata_lsram_xhdl1(26), A_DOUT(1) => 
        ram_rdata_lsram_xhdl1(25), A_DOUT(0) => 
        ram_rdata_lsram_xhdl1(24), B_DOUT(17) => nc22, B_DOUT(16)
         => nc28, B_DOUT(15) => nc14, B_DOUT(14) => nc5, 
        B_DOUT(13) => nc21, B_DOUT(12) => nc15, B_DOUT(11) => nc3, 
        B_DOUT(10) => nc10, B_DOUT(9) => nc7, B_DOUT(8) => nc17, 
        B_DOUT(7) => nc4, B_DOUT(6) => nc12, B_DOUT(5) => nc2, 
        B_DOUT(4) => nc23, B_DOUT(3) => nc18, B_DOUT(2) => nc26, 
        B_DOUT(1) => nc6, B_DOUT(0) => nc11, BUSY => OPEN, A_CLK
         => sha256_system_sb_0_FIC_0_CLK, A_DOUT_CLK => VCC_net_1, 
        A_ARST_N => MSS_READY, A_DOUT_EN => VCC_net_1, A_BLK(2)
         => VCC_net_1, A_BLK(1) => VCC_net_1, A_BLK(0) => 
        VCC_net_1, A_DOUT_ARST_N => VCC_net_1, A_DOUT_SRST_N => 
        VCC_net_1, A_DIN(17) => GND_net_1, A_DIN(16) => GND_net_1, 
        A_DIN(15) => GND_net_1, A_DIN(14) => GND_net_1, A_DIN(13)
         => GND_net_1, A_DIN(12) => GND_net_1, A_DIN(11) => 
        GND_net_1, A_DIN(10) => GND_net_1, A_DIN(9) => GND_net_1, 
        A_DIN(8) => GND_net_1, A_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(31), A_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(30), A_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(29), A_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(28), A_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(27), A_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(26), A_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(25), A_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(24), A_ADDR(13) => 
        ahbsram_addr(12), A_ADDR(12) => ahbsram_addr(11), 
        A_ADDR(11) => ahbsram_addr(10), A_ADDR(10) => 
        ahbsram_addr(9), A_ADDR(9) => ahbsram_addr(8), A_ADDR(8)
         => ahbsram_addr(7), A_ADDR(7) => ahbsram_addr(6), 
        A_ADDR(6) => ahbsram_addr(5), A_ADDR(5) => 
        ahbsram_addr(4), A_ADDR(4) => ahbsram_addr(3), A_ADDR(3)
         => ahbsram_addr(2), A_ADDR(2) => GND_net_1, A_ADDR(1)
         => GND_net_1, A_ADDR(0) => GND_net_1, A_WEN(1) => 
        GND_net_1, A_WEN(0) => \sram_wen_mem[3]\, B_CLK => 
        sha256_system_sb_0_FIC_0_CLK, B_DOUT_CLK => VCC_net_1, 
        B_ARST_N => MSS_READY, B_DOUT_EN => VCC_net_1, B_BLK(2)
         => VCC_net_1, B_BLK(1) => VCC_net_1, B_BLK(0) => 
        VCC_net_1, B_DOUT_ARST_N => VCC_net_1, B_DOUT_SRST_N => 
        VCC_net_1, B_DIN(17) => GND_net_1, B_DIN(16) => GND_net_1, 
        B_DIN(15) => GND_net_1, B_DIN(14) => GND_net_1, B_DIN(13)
         => GND_net_1, B_DIN(12) => GND_net_1, B_DIN(11) => 
        GND_net_1, B_DIN(10) => GND_net_1, B_DIN(9) => GND_net_1, 
        B_DIN(8) => GND_net_1, B_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(31), B_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(30), B_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(29), B_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(28), B_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(27), B_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(26), B_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(25), B_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(24), B_ADDR(13) => 
        ahbsram_addr(12), B_ADDR(12) => ahbsram_addr(11), 
        B_ADDR(11) => ahbsram_addr(10), B_ADDR(10) => 
        ahbsram_addr(9), B_ADDR(9) => ahbsram_addr(8), B_ADDR(8)
         => ahbsram_addr(7), B_ADDR(7) => ahbsram_addr(6), 
        B_ADDR(6) => ahbsram_addr(5), B_ADDR(5) => 
        ahbsram_addr(4), B_ADDR(4) => ahbsram_addr(3), B_ADDR(3)
         => ahbsram_addr(2), B_ADDR(2) => GND_net_1, B_ADDR(1)
         => GND_net_1, B_ADDR(0) => GND_net_1, B_WEN(1) => 
        GND_net_1, B_WEN(0) => GND_net_1, A_EN => VCC_net_1, 
        A_DOUT_LAT => VCC_net_1, A_WIDTH(2) => GND_net_1, 
        A_WIDTH(1) => VCC_net_1, A_WIDTH(0) => VCC_net_1, A_WMODE
         => GND_net_1, B_EN => VCC_net_1, B_DOUT_LAT => VCC_net_1, 
        B_WIDTH(2) => GND_net_1, B_WIDTH(1) => VCC_net_1, 
        B_WIDTH(0) => VCC_net_1, B_WMODE => GND_net_1, SII_LOCK
         => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 is

    port( sramcurr_state                  : in    std_logic_vector(1 downto 0);
          sram_wen_mem_ns_1               : in    std_logic_vector(0 to 0);
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(7 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(7 downto 0);
          ahbsram_addr                    : in    std_logic_vector(12 downto 2);
          N_99                            : in    std_logic;
          sramahb_ack                     : in    std_logic;
          ahbsram_req_d1                  : in    std_logic;
          HWRITE_d                        : in    std_logic;
          g0_1                            : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic;
          MSS_READY                       : in    std_logic
        );

end sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8;

architecture DEF_ARCH of 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 is 

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component RAM1K18
    generic (MEMORYFILE:string := "");

    port( A_DOUT        : out   std_logic_vector(17 downto 0);
          B_DOUT        : out   std_logic_vector(17 downto 0);
          BUSY          : out   std_logic;
          A_CLK         : in    std_logic := 'U';
          A_DOUT_CLK    : in    std_logic := 'U';
          A_ARST_N      : in    std_logic := 'U';
          A_DOUT_EN     : in    std_logic := 'U';
          A_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DOUT_CLK    : in    std_logic := 'U';
          B_ARST_N      : in    std_logic := 'U';
          B_DOUT_EN     : in    std_logic := 'U';
          B_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_EN          : in    std_logic := 'U';
          A_DOUT_LAT    : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic := 'U';
          B_EN          : in    std_logic := 'U';
          B_DOUT_LAT    : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic := 'U';
          SII_LOCK      : in    std_logic := 'U'
        );
  end component;

    signal g2_1_2, g2_1_3, \sram_wen_mem[0]\, VCC_net_1, 
        GND_net_1 : std_logic;
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc25, nc20, nc27, 
        nc9, nc22, nc28, nc14, nc5, nc21, nc15, nc3, nc10, nc7, 
        nc17, nc4, nc12, nc2, nc23, nc18, nc26, nc6, nc11
         : std_logic;

begin 


    block1_RNO_0 : CFG4
      generic map(INIT => x"0004")

      port map(A => ahbsram_req_d1, B => HWRITE_d, C => 
        sramcurr_state(0), D => sramcurr_state(1), Y => g2_1_3);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    block1_RNO_1 : CFG2
      generic map(INIT => x"2")

      port map(A => N_99, B => sramahb_ack, Y => g2_1_2);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    block1_RNO : CFG4
      generic map(INIT => x"D111")

      port map(A => sram_wen_mem_ns_1(0), B => g0_1, C => g2_1_3, 
        D => g2_1_2, Y => \sram_wen_mem[0]\);
    
    block1 : RAM1K18
      port map(A_DOUT(17) => nc24, A_DOUT(16) => nc1, A_DOUT(15)
         => nc8, A_DOUT(14) => nc13, A_DOUT(13) => nc16, 
        A_DOUT(12) => nc19, A_DOUT(11) => nc25, A_DOUT(10) => 
        nc20, A_DOUT(9) => nc27, A_DOUT(8) => nc9, A_DOUT(7) => 
        ram_rdata_lsram_xhdl1(7), A_DOUT(6) => 
        ram_rdata_lsram_xhdl1(6), A_DOUT(5) => 
        ram_rdata_lsram_xhdl1(5), A_DOUT(4) => 
        ram_rdata_lsram_xhdl1(4), A_DOUT(3) => 
        ram_rdata_lsram_xhdl1(3), A_DOUT(2) => 
        ram_rdata_lsram_xhdl1(2), A_DOUT(1) => 
        ram_rdata_lsram_xhdl1(1), A_DOUT(0) => 
        ram_rdata_lsram_xhdl1(0), B_DOUT(17) => nc22, B_DOUT(16)
         => nc28, B_DOUT(15) => nc14, B_DOUT(14) => nc5, 
        B_DOUT(13) => nc21, B_DOUT(12) => nc15, B_DOUT(11) => nc3, 
        B_DOUT(10) => nc10, B_DOUT(9) => nc7, B_DOUT(8) => nc17, 
        B_DOUT(7) => nc4, B_DOUT(6) => nc12, B_DOUT(5) => nc2, 
        B_DOUT(4) => nc23, B_DOUT(3) => nc18, B_DOUT(2) => nc26, 
        B_DOUT(1) => nc6, B_DOUT(0) => nc11, BUSY => OPEN, A_CLK
         => sha256_system_sb_0_FIC_0_CLK, A_DOUT_CLK => VCC_net_1, 
        A_ARST_N => MSS_READY, A_DOUT_EN => VCC_net_1, A_BLK(2)
         => VCC_net_1, A_BLK(1) => VCC_net_1, A_BLK(0) => 
        VCC_net_1, A_DOUT_ARST_N => VCC_net_1, A_DOUT_SRST_N => 
        VCC_net_1, A_DIN(17) => GND_net_1, A_DIN(16) => GND_net_1, 
        A_DIN(15) => GND_net_1, A_DIN(14) => GND_net_1, A_DIN(13)
         => GND_net_1, A_DIN(12) => GND_net_1, A_DIN(11) => 
        GND_net_1, A_DIN(10) => GND_net_1, A_DIN(9) => GND_net_1, 
        A_DIN(8) => GND_net_1, A_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(7), A_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(6), A_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(5), A_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(4), A_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(3), A_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(2), A_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(1), A_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(0), A_ADDR(13) => 
        ahbsram_addr(12), A_ADDR(12) => ahbsram_addr(11), 
        A_ADDR(11) => ahbsram_addr(10), A_ADDR(10) => 
        ahbsram_addr(9), A_ADDR(9) => ahbsram_addr(8), A_ADDR(8)
         => ahbsram_addr(7), A_ADDR(7) => ahbsram_addr(6), 
        A_ADDR(6) => ahbsram_addr(5), A_ADDR(5) => 
        ahbsram_addr(4), A_ADDR(4) => ahbsram_addr(3), A_ADDR(3)
         => ahbsram_addr(2), A_ADDR(2) => GND_net_1, A_ADDR(1)
         => GND_net_1, A_ADDR(0) => GND_net_1, A_WEN(1) => 
        GND_net_1, A_WEN(0) => \sram_wen_mem[0]\, B_CLK => 
        sha256_system_sb_0_FIC_0_CLK, B_DOUT_CLK => VCC_net_1, 
        B_ARST_N => MSS_READY, B_DOUT_EN => VCC_net_1, B_BLK(2)
         => VCC_net_1, B_BLK(1) => VCC_net_1, B_BLK(0) => 
        VCC_net_1, B_DOUT_ARST_N => VCC_net_1, B_DOUT_SRST_N => 
        VCC_net_1, B_DIN(17) => GND_net_1, B_DIN(16) => GND_net_1, 
        B_DIN(15) => GND_net_1, B_DIN(14) => GND_net_1, B_DIN(13)
         => GND_net_1, B_DIN(12) => GND_net_1, B_DIN(11) => 
        GND_net_1, B_DIN(10) => GND_net_1, B_DIN(9) => GND_net_1, 
        B_DIN(8) => GND_net_1, B_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(7), B_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(6), B_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(5), B_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(4), B_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(3), B_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(2), B_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(1), B_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(0), B_ADDR(13) => 
        ahbsram_addr(12), B_ADDR(12) => ahbsram_addr(11), 
        B_ADDR(11) => ahbsram_addr(10), B_ADDR(10) => 
        ahbsram_addr(9), B_ADDR(9) => ahbsram_addr(8), B_ADDR(8)
         => ahbsram_addr(7), B_ADDR(7) => ahbsram_addr(6), 
        B_ADDR(6) => ahbsram_addr(5), B_ADDR(5) => 
        ahbsram_addr(4), B_ADDR(4) => ahbsram_addr(3), B_ADDR(3)
         => ahbsram_addr(2), B_ADDR(2) => GND_net_1, B_ADDR(1)
         => GND_net_1, B_ADDR(0) => GND_net_1, B_WEN(1) => 
        GND_net_1, B_WEN(0) => GND_net_1, A_EN => VCC_net_1, 
        A_DOUT_LAT => VCC_net_1, A_WIDTH(2) => GND_net_1, 
        A_WIDTH(1) => VCC_net_1, A_WIDTH(0) => VCC_net_1, A_WMODE
         => GND_net_1, B_EN => VCC_net_1, B_DOUT_LAT => VCC_net_1, 
        B_WIDTH(2) => GND_net_1, B_WIDTH(1) => VCC_net_1, 
        B_WIDTH(0) => VCC_net_1, B_WMODE => GND_net_1, SII_LOCK
         => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_0 is

    port( sramcurr_state                  : in    std_logic_vector(1 downto 0);
          sram_wen_mem_ns_1               : in    std_logic_vector(1 to 1);
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(15 downto 8);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(15 downto 8);
          ahbsram_addr                    : in    std_logic_vector(12 downto 2);
          N_99                            : in    std_logic;
          ahbsram_req_d1                  : in    std_logic;
          HWRITE_d                        : in    std_logic;
          sramahb_ack                     : in    std_logic;
          g0_1                            : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic;
          MSS_READY                       : in    std_logic
        );

end sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_0;

architecture DEF_ARCH of 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_0 is 

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component RAM1K18
    generic (MEMORYFILE:string := "");

    port( A_DOUT        : out   std_logic_vector(17 downto 0);
          B_DOUT        : out   std_logic_vector(17 downto 0);
          BUSY          : out   std_logic;
          A_CLK         : in    std_logic := 'U';
          A_DOUT_CLK    : in    std_logic := 'U';
          A_ARST_N      : in    std_logic := 'U';
          A_DOUT_EN     : in    std_logic := 'U';
          A_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DOUT_CLK    : in    std_logic := 'U';
          B_ARST_N      : in    std_logic := 'U';
          B_DOUT_EN     : in    std_logic := 'U';
          B_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_EN          : in    std_logic := 'U';
          A_DOUT_LAT    : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic := 'U';
          B_EN          : in    std_logic := 'U';
          B_DOUT_LAT    : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic := 'U';
          SII_LOCK      : in    std_logic := 'U'
        );
  end component;

    signal g2_5, g2_4, \sram_wen_mem[1]\, VCC_net_1, GND_net_1
         : std_logic;
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc25, nc20, nc27, 
        nc9, nc22, nc28, nc14, nc5, nc21, nc15, nc3, nc10, nc7, 
        nc17, nc4, nc12, nc2, nc23, nc18, nc26, nc6, nc11
         : std_logic;

begin 


    block1_RNO_0 : CFG4
      generic map(INIT => x"0010")

      port map(A => sramcurr_state(1), B => sramcurr_state(0), C
         => HWRITE_d, D => sramahb_ack, Y => g2_4);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    block1_RNO_1 : CFG2
      generic map(INIT => x"2")

      port map(A => N_99, B => ahbsram_req_d1, Y => g2_5);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    block1_RNO : CFG4
      generic map(INIT => x"D111")

      port map(A => sram_wen_mem_ns_1(1), B => g0_1, C => g2_4, D
         => g2_5, Y => \sram_wen_mem[1]\);
    
    block1 : RAM1K18
      port map(A_DOUT(17) => nc24, A_DOUT(16) => nc1, A_DOUT(15)
         => nc8, A_DOUT(14) => nc13, A_DOUT(13) => nc16, 
        A_DOUT(12) => nc19, A_DOUT(11) => nc25, A_DOUT(10) => 
        nc20, A_DOUT(9) => nc27, A_DOUT(8) => nc9, A_DOUT(7) => 
        ram_rdata_lsram_xhdl1(15), A_DOUT(6) => 
        ram_rdata_lsram_xhdl1(14), A_DOUT(5) => 
        ram_rdata_lsram_xhdl1(13), A_DOUT(4) => 
        ram_rdata_lsram_xhdl1(12), A_DOUT(3) => 
        ram_rdata_lsram_xhdl1(11), A_DOUT(2) => 
        ram_rdata_lsram_xhdl1(10), A_DOUT(1) => 
        ram_rdata_lsram_xhdl1(9), A_DOUT(0) => 
        ram_rdata_lsram_xhdl1(8), B_DOUT(17) => nc22, B_DOUT(16)
         => nc28, B_DOUT(15) => nc14, B_DOUT(14) => nc5, 
        B_DOUT(13) => nc21, B_DOUT(12) => nc15, B_DOUT(11) => nc3, 
        B_DOUT(10) => nc10, B_DOUT(9) => nc7, B_DOUT(8) => nc17, 
        B_DOUT(7) => nc4, B_DOUT(6) => nc12, B_DOUT(5) => nc2, 
        B_DOUT(4) => nc23, B_DOUT(3) => nc18, B_DOUT(2) => nc26, 
        B_DOUT(1) => nc6, B_DOUT(0) => nc11, BUSY => OPEN, A_CLK
         => sha256_system_sb_0_FIC_0_CLK, A_DOUT_CLK => VCC_net_1, 
        A_ARST_N => MSS_READY, A_DOUT_EN => VCC_net_1, A_BLK(2)
         => VCC_net_1, A_BLK(1) => VCC_net_1, A_BLK(0) => 
        VCC_net_1, A_DOUT_ARST_N => VCC_net_1, A_DOUT_SRST_N => 
        VCC_net_1, A_DIN(17) => GND_net_1, A_DIN(16) => GND_net_1, 
        A_DIN(15) => GND_net_1, A_DIN(14) => GND_net_1, A_DIN(13)
         => GND_net_1, A_DIN(12) => GND_net_1, A_DIN(11) => 
        GND_net_1, A_DIN(10) => GND_net_1, A_DIN(9) => GND_net_1, 
        A_DIN(8) => GND_net_1, A_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(15), A_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(14), A_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(13), A_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(12), A_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(11), A_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(10), A_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(9), A_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(8), A_ADDR(13) => 
        ahbsram_addr(12), A_ADDR(12) => ahbsram_addr(11), 
        A_ADDR(11) => ahbsram_addr(10), A_ADDR(10) => 
        ahbsram_addr(9), A_ADDR(9) => ahbsram_addr(8), A_ADDR(8)
         => ahbsram_addr(7), A_ADDR(7) => ahbsram_addr(6), 
        A_ADDR(6) => ahbsram_addr(5), A_ADDR(5) => 
        ahbsram_addr(4), A_ADDR(4) => ahbsram_addr(3), A_ADDR(3)
         => ahbsram_addr(2), A_ADDR(2) => GND_net_1, A_ADDR(1)
         => GND_net_1, A_ADDR(0) => GND_net_1, A_WEN(1) => 
        GND_net_1, A_WEN(0) => \sram_wen_mem[1]\, B_CLK => 
        sha256_system_sb_0_FIC_0_CLK, B_DOUT_CLK => VCC_net_1, 
        B_ARST_N => MSS_READY, B_DOUT_EN => VCC_net_1, B_BLK(2)
         => VCC_net_1, B_BLK(1) => VCC_net_1, B_BLK(0) => 
        VCC_net_1, B_DOUT_ARST_N => VCC_net_1, B_DOUT_SRST_N => 
        VCC_net_1, B_DIN(17) => GND_net_1, B_DIN(16) => GND_net_1, 
        B_DIN(15) => GND_net_1, B_DIN(14) => GND_net_1, B_DIN(13)
         => GND_net_1, B_DIN(12) => GND_net_1, B_DIN(11) => 
        GND_net_1, B_DIN(10) => GND_net_1, B_DIN(9) => GND_net_1, 
        B_DIN(8) => GND_net_1, B_DIN(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(15), B_DIN(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(14), B_DIN(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(13), B_DIN(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(12), B_DIN(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(11), B_DIN(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(10), B_DIN(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(9), B_DIN(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(8), B_ADDR(13) => 
        ahbsram_addr(12), B_ADDR(12) => ahbsram_addr(11), 
        B_ADDR(11) => ahbsram_addr(10), B_ADDR(10) => 
        ahbsram_addr(9), B_ADDR(9) => ahbsram_addr(8), B_ADDR(8)
         => ahbsram_addr(7), B_ADDR(7) => ahbsram_addr(6), 
        B_ADDR(6) => ahbsram_addr(5), B_ADDR(5) => 
        ahbsram_addr(4), B_ADDR(4) => ahbsram_addr(3), B_ADDR(3)
         => ahbsram_addr(2), B_ADDR(2) => GND_net_1, B_ADDR(1)
         => GND_net_1, B_ADDR(0) => GND_net_1, B_WEN(1) => 
        GND_net_1, B_WEN(0) => GND_net_1, A_EN => VCC_net_1, 
        A_DOUT_LAT => VCC_net_1, A_WIDTH(2) => GND_net_1, 
        A_WIDTH(1) => VCC_net_1, A_WIDTH(0) => VCC_net_1, A_WMODE
         => GND_net_1, B_EN => VCC_net_1, B_DOUT_LAT => VCC_net_1, 
        B_WIDTH(2) => GND_net_1, B_WIDTH(1) => VCC_net_1, 
        B_WIDTH(0) => VCC_net_1, B_WMODE => GND_net_1, SII_LOCK
         => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf is

    port( CoreAHBLite_0_AHBmslave0_HRDATA : out   std_logic_vector(31 downto 0);
          ahbsram_size_a0                 : in    std_logic_vector(1 to 1);
          ahbsram_size                    : in    std_logic_vector(0 to 0);
          ahbsram_size_0_0                : in    std_logic_vector(1 to 1);
          HSIZE_d                         : in    std_logic_vector(1 to 1);
          ahbsram_size_a1                 : in    std_logic_vector(1 to 1);
          ahbsram_addr                    : in    std_logic_vector(12 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(31 downto 0);
          MSS_READY                       : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic;
          sramahb_ack                     : out   std_logic;
          ahbsram_req_d1                  : in    std_logic;
          HWRITE_d                        : in    std_logic;
          N_99                            : in    std_logic;
          ahbsram_write                   : in    std_logic;
          N_44                            : in    std_logic
        );

end sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf;

architecture DEF_ARCH of 
        sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_1
    port( sramcurr_state                  : in    std_logic_vector(1 downto 0) := (others => 'U');
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(23 downto 16);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(23 downto 16) := (others => 'U');
          ahbsram_addr                    : in    std_logic_vector(12 downto 0) := (others => 'U');
          ahbsram_req_d1                  : in    std_logic := 'U';
          HWRITE_d                        : in    std_logic := 'U';
          sramahb_ack                     : in    std_logic := 'U';
          N_99                            : in    std_logic := 'U';
          g0_5                            : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic := 'U';
          MSS_READY                       : in    std_logic := 'U'
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_2
    port( sramcurr_state                  : in    std_logic_vector(1 downto 0) := (others => 'U');
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(31 downto 24);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(31 downto 24) := (others => 'U');
          ahbsram_addr                    : in    std_logic_vector(12 downto 0) := (others => 'U');
          HWRITE_d                        : in    std_logic := 'U';
          sramahb_ack                     : in    std_logic := 'U';
          ahbsram_req_d1                  : in    std_logic := 'U';
          N_99                            : in    std_logic := 'U';
          g0_5                            : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic := 'U';
          MSS_READY                       : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8
    port( sramcurr_state                  : in    std_logic_vector(1 downto 0) := (others => 'U');
          sram_wen_mem_ns_1               : in    std_logic_vector(0 to 0) := (others => 'U');
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(7 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(7 downto 0) := (others => 'U');
          ahbsram_addr                    : in    std_logic_vector(12 downto 2) := (others => 'U');
          N_99                            : in    std_logic := 'U';
          sramahb_ack                     : in    std_logic := 'U';
          ahbsram_req_d1                  : in    std_logic := 'U';
          HWRITE_d                        : in    std_logic := 'U';
          g0_1                            : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic := 'U';
          MSS_READY                       : in    std_logic := 'U'
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_0
    port( sramcurr_state                  : in    std_logic_vector(1 downto 0) := (others => 'U');
          sram_wen_mem_ns_1               : in    std_logic_vector(1 to 1) := (others => 'U');
          ram_rdata_lsram_xhdl1           : out   std_logic_vector(15 downto 8);
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(15 downto 8) := (others => 'U');
          ahbsram_addr                    : in    std_logic_vector(12 downto 2) := (others => 'U');
          N_99                            : in    std_logic := 'U';
          ahbsram_req_d1                  : in    std_logic := 'U';
          HWRITE_d                        : in    std_logic := 'U';
          sramahb_ack                     : in    std_logic := 'U';
          g0_1                            : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic := 'U';
          MSS_READY                       : in    std_logic := 'U'
        );
  end component;

    signal VCC_net_1, \ram_rdata_lsram_xhdl1[22]\, \sram_ren_d\, 
        GND_net_1, \ram_rdata_lsram_xhdl1[23]\, 
        \ram_rdata_lsram_xhdl1[24]\, \ram_rdata_lsram_xhdl1[25]\, 
        \ram_rdata_lsram_xhdl1[26]\, \ram_rdata_lsram_xhdl1[27]\, 
        \ram_rdata_lsram_xhdl1[28]\, \ram_rdata_lsram_xhdl1[29]\, 
        \ram_rdata_lsram_xhdl1[30]\, \ram_rdata_lsram_xhdl1[31]\, 
        \ram_rdata_lsram_xhdl1[7]\, \ram_rdata_lsram_xhdl1[8]\, 
        \ram_rdata_lsram_xhdl1[9]\, \ram_rdata_lsram_xhdl1[10]\, 
        \ram_rdata_lsram_xhdl1[11]\, \ram_rdata_lsram_xhdl1[12]\, 
        \ram_rdata_lsram_xhdl1[13]\, \ram_rdata_lsram_xhdl1[14]\, 
        \ram_rdata_lsram_xhdl1[15]\, \ram_rdata_lsram_xhdl1[16]\, 
        \ram_rdata_lsram_xhdl1[17]\, \ram_rdata_lsram_xhdl1[18]\, 
        \ram_rdata_lsram_xhdl1[19]\, \ram_rdata_lsram_xhdl1[20]\, 
        \ram_rdata_lsram_xhdl1[21]\, \ram_rdata_lsram_xhdl1[0]\, 
        \ram_rdata_lsram_xhdl1[1]\, \ram_rdata_lsram_xhdl1[2]\, 
        \ram_rdata_lsram_xhdl1[3]\, \ram_rdata_lsram_xhdl1[4]\, 
        \ram_rdata_lsram_xhdl1[5]\, \ram_rdata_lsram_xhdl1[6]\, 
        \sram_done\, sram_ren_xhdl6_0_sqmuxa, \sramahb_ack\, 
        N_45_i_0, sram_ren_xhdl6_1_sqmuxa, 
        \sramcurr_state[0]_net_1\, \sramcurr_state_ns[0]\, 
        \sramcurr_state[1]_net_1\, \sramcurr_state_ns[1]\, g0_1, 
        \sram_m1_0_a2_0_1\, \g0_5\, g0_1_3, \sram_wen_mem_m4[0]\, 
        sram_m1_e_1, \sram_wen_mem_ns_1[0]_net_1\, sram_m1_e_0_0, 
        \sram_wen_mem_ns_1[1]_net_1\, N_6 : std_logic;

    for all : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_1
	Use entity work.
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_1(DEF_ARCH);
    for all : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_2
	Use entity work.
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_2(DEF_ARCH);
    for all : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8
	Use entity work.
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8(DEF_ARCH);
    for all : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_0
	Use entity work.
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_0(DEF_ARCH);
begin 

    sramahb_ack <= \sramahb_ack\;

    \sramahb_rdata_xhdl2[25]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[25]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(25));
    
    \sramahb_rdata_xhdl2[16]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[16]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(16));
    
    \sram_wen_mem_ns_1_RNO_0[0]\ : CFG3
      generic map(INIT => x"08")

      port map(A => g0_1_3, B => N_99, C => 
        \sramcurr_state[0]_net_1\, Y => \sram_wen_mem_m4[0]\);
    
    \sramahb_rdata_xhdl2[24]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[24]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(24));
    
    \sramahb_rdata_xhdl2[8]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[8]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(8));
    
    \sramahb_rdata_xhdl2[13]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[13]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(13));
    
    sramahb_ack_xhdl1_RNO : CFG3
      generic map(INIT => x"C8")

      port map(A => \sramcurr_state[0]_net_1\, B => \sram_done\, 
        C => \sramcurr_state[1]_net_1\, Y => N_45_i_0);
    
    \sramahb_rdata_xhdl2[9]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[9]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(9));
    
    \S0.byte_2\ : 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_1
      port map(sramcurr_state(1) => \sramcurr_state[1]_net_1\, 
        sramcurr_state(0) => \sramcurr_state[0]_net_1\, 
        ram_rdata_lsram_xhdl1(23) => \ram_rdata_lsram_xhdl1[23]\, 
        ram_rdata_lsram_xhdl1(22) => \ram_rdata_lsram_xhdl1[22]\, 
        ram_rdata_lsram_xhdl1(21) => \ram_rdata_lsram_xhdl1[21]\, 
        ram_rdata_lsram_xhdl1(20) => \ram_rdata_lsram_xhdl1[20]\, 
        ram_rdata_lsram_xhdl1(19) => \ram_rdata_lsram_xhdl1[19]\, 
        ram_rdata_lsram_xhdl1(18) => \ram_rdata_lsram_xhdl1[18]\, 
        ram_rdata_lsram_xhdl1(17) => \ram_rdata_lsram_xhdl1[17]\, 
        ram_rdata_lsram_xhdl1(16) => \ram_rdata_lsram_xhdl1[16]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(23) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(23), 
        CoreAHBLite_0_AHBmslave0_HWDATA(22) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(22), 
        CoreAHBLite_0_AHBmslave0_HWDATA(21) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(21), 
        CoreAHBLite_0_AHBmslave0_HWDATA(20) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(20), 
        CoreAHBLite_0_AHBmslave0_HWDATA(19) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(19), 
        CoreAHBLite_0_AHBmslave0_HWDATA(18) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(18), 
        CoreAHBLite_0_AHBmslave0_HWDATA(17) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(17), 
        CoreAHBLite_0_AHBmslave0_HWDATA(16) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(16), ahbsram_addr(12) => 
        ahbsram_addr(12), ahbsram_addr(11) => ahbsram_addr(11), 
        ahbsram_addr(10) => ahbsram_addr(10), ahbsram_addr(9) => 
        ahbsram_addr(9), ahbsram_addr(8) => ahbsram_addr(8), 
        ahbsram_addr(7) => ahbsram_addr(7), ahbsram_addr(6) => 
        ahbsram_addr(6), ahbsram_addr(5) => ahbsram_addr(5), 
        ahbsram_addr(4) => ahbsram_addr(4), ahbsram_addr(3) => 
        ahbsram_addr(3), ahbsram_addr(2) => ahbsram_addr(2), 
        ahbsram_addr(1) => ahbsram_addr(1), ahbsram_addr(0) => 
        ahbsram_addr(0), ahbsram_req_d1 => ahbsram_req_d1, 
        HWRITE_d => HWRITE_d, sramahb_ack => \sramahb_ack\, N_99
         => N_99, g0_5 => \g0_5\, sha256_system_sb_0_FIC_0_CLK
         => sha256_system_sb_0_FIC_0_CLK, MSS_READY => MSS_READY);
    
    \sramahb_rdata_xhdl2[2]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[2]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(2));
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \S0.byte_3\ : 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_2
      port map(sramcurr_state(1) => \sramcurr_state[1]_net_1\, 
        sramcurr_state(0) => \sramcurr_state[0]_net_1\, 
        ram_rdata_lsram_xhdl1(31) => \ram_rdata_lsram_xhdl1[31]\, 
        ram_rdata_lsram_xhdl1(30) => \ram_rdata_lsram_xhdl1[30]\, 
        ram_rdata_lsram_xhdl1(29) => \ram_rdata_lsram_xhdl1[29]\, 
        ram_rdata_lsram_xhdl1(28) => \ram_rdata_lsram_xhdl1[28]\, 
        ram_rdata_lsram_xhdl1(27) => \ram_rdata_lsram_xhdl1[27]\, 
        ram_rdata_lsram_xhdl1(26) => \ram_rdata_lsram_xhdl1[26]\, 
        ram_rdata_lsram_xhdl1(25) => \ram_rdata_lsram_xhdl1[25]\, 
        ram_rdata_lsram_xhdl1(24) => \ram_rdata_lsram_xhdl1[24]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(31) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(31), 
        CoreAHBLite_0_AHBmslave0_HWDATA(30) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(30), 
        CoreAHBLite_0_AHBmslave0_HWDATA(29) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(29), 
        CoreAHBLite_0_AHBmslave0_HWDATA(28) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(28), 
        CoreAHBLite_0_AHBmslave0_HWDATA(27) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(27), 
        CoreAHBLite_0_AHBmslave0_HWDATA(26) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(26), 
        CoreAHBLite_0_AHBmslave0_HWDATA(25) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(25), 
        CoreAHBLite_0_AHBmslave0_HWDATA(24) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(24), ahbsram_addr(12) => 
        ahbsram_addr(12), ahbsram_addr(11) => ahbsram_addr(11), 
        ahbsram_addr(10) => ahbsram_addr(10), ahbsram_addr(9) => 
        ahbsram_addr(9), ahbsram_addr(8) => ahbsram_addr(8), 
        ahbsram_addr(7) => ahbsram_addr(7), ahbsram_addr(6) => 
        ahbsram_addr(6), ahbsram_addr(5) => ahbsram_addr(5), 
        ahbsram_addr(4) => ahbsram_addr(4), ahbsram_addr(3) => 
        ahbsram_addr(3), ahbsram_addr(2) => ahbsram_addr(2), 
        ahbsram_addr(1) => ahbsram_addr(1), ahbsram_addr(0) => 
        ahbsram_addr(0), HWRITE_d => HWRITE_d, sramahb_ack => 
        \sramahb_ack\, ahbsram_req_d1 => ahbsram_req_d1, N_99 => 
        N_99, g0_5 => \g0_5\, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, MSS_READY => MSS_READY);
    
    \sramahb_rdata_xhdl2[22]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[22]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(22));
    
    \sramahb_rdata_xhdl2[5]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[5]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(5));
    
    \sramahb_rdata_xhdl2[19]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[19]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(19));
    
    \sramahb_rdata_xhdl2[4]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[4]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(4));
    
    \sramahb_rdata_xhdl2[21]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[21]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(21));
    
    \sramahb_rdata_xhdl2[18]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[18]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(18));
    
    \sramahb_rdata_xhdl2[20]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[20]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(20));
    
    \sramahb_rdata_xhdl2[15]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[15]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(15));
    
    \sramcurr_state[0]\ : SLE
      port map(D => \sramcurr_state_ns[0]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \sramcurr_state[0]_net_1\);
    
    \sramahb_rdata_xhdl2[14]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[14]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(14));
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    sram_done : SLE
      port map(D => sram_ren_xhdl6_0_sqmuxa, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \sram_done\);
    
    g0_3 : CFG4
      generic map(INIT => x"3326")

      port map(A => ahbsram_size_a0(1), B => ahbsram_size(0), C
         => ahbsram_addr(1), D => ahbsram_size_0_0(1), Y => g0_1);
    
    sram_m1_0_a2_0_1 : CFG4
      generic map(INIT => x"0A02")

      port map(A => ahbsram_addr(1), B => HSIZE_d(1), C => 
        ahbsram_size_a1(1), D => N_44, Y => \sram_m1_0_a2_0_1\);
    
    \sramahb_rdata_xhdl2[0]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[0]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(0));
    
    \sramahb_rdata_xhdl2[27]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[27]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(27));
    
    \S0.byte_0\ : 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8
      port map(sramcurr_state(1) => \sramcurr_state[1]_net_1\, 
        sramcurr_state(0) => \sramcurr_state[0]_net_1\, 
        sram_wen_mem_ns_1(0) => \sram_wen_mem_ns_1[0]_net_1\, 
        ram_rdata_lsram_xhdl1(7) => \ram_rdata_lsram_xhdl1[7]\, 
        ram_rdata_lsram_xhdl1(6) => \ram_rdata_lsram_xhdl1[6]\, 
        ram_rdata_lsram_xhdl1(5) => \ram_rdata_lsram_xhdl1[5]\, 
        ram_rdata_lsram_xhdl1(4) => \ram_rdata_lsram_xhdl1[4]\, 
        ram_rdata_lsram_xhdl1(3) => \ram_rdata_lsram_xhdl1[3]\, 
        ram_rdata_lsram_xhdl1(2) => \ram_rdata_lsram_xhdl1[2]\, 
        ram_rdata_lsram_xhdl1(1) => \ram_rdata_lsram_xhdl1[1]\, 
        ram_rdata_lsram_xhdl1(0) => \ram_rdata_lsram_xhdl1[0]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(7), 
        CoreAHBLite_0_AHBmslave0_HWDATA(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(6), 
        CoreAHBLite_0_AHBmslave0_HWDATA(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(5), 
        CoreAHBLite_0_AHBmslave0_HWDATA(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(4), 
        CoreAHBLite_0_AHBmslave0_HWDATA(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(3), 
        CoreAHBLite_0_AHBmslave0_HWDATA(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(2), 
        CoreAHBLite_0_AHBmslave0_HWDATA(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(1), 
        CoreAHBLite_0_AHBmslave0_HWDATA(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(0), ahbsram_addr(12) => 
        ahbsram_addr(12), ahbsram_addr(11) => ahbsram_addr(11), 
        ahbsram_addr(10) => ahbsram_addr(10), ahbsram_addr(9) => 
        ahbsram_addr(9), ahbsram_addr(8) => ahbsram_addr(8), 
        ahbsram_addr(7) => ahbsram_addr(7), ahbsram_addr(6) => 
        ahbsram_addr(6), ahbsram_addr(5) => ahbsram_addr(5), 
        ahbsram_addr(4) => ahbsram_addr(4), ahbsram_addr(3) => 
        ahbsram_addr(3), ahbsram_addr(2) => ahbsram_addr(2), N_99
         => N_99, sramahb_ack => \sramahb_ack\, ahbsram_req_d1
         => ahbsram_req_d1, HWRITE_d => HWRITE_d, g0_1 => g0_1, 
        sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, MSS_READY => MSS_READY);
    
    \sramahb_rdata_xhdl2[26]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[26]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(26));
    
    \sramahb_rdata_xhdl2[12]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[12]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(12));
    
    \sramahb_rdata_xhdl2[31]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[31]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(31));
    
    \sramahb_rdata_xhdl2[23]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[23]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(23));
    
    \sramahb_rdata_xhdl2[30]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[30]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(30));
    
    sram_ren_d : SLE
      port map(D => sram_ren_xhdl6_1_sqmuxa, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \sram_ren_d\);
    
    \sramahb_rdata_xhdl2[11]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[11]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(11));
    
    \sramcurr_state_ns_1_0_.m4\ : CFG4
      generic map(INIT => x"1310")

      port map(A => \sram_done\, B => \sramcurr_state[1]_net_1\, 
        C => \sramcurr_state[0]_net_1\, D => ahbsram_write, Y => 
        \sramcurr_state_ns[0]\);
    
    \sram_wen_mem_ns_1_RNO[1]\ : CFG4
      generic map(INIT => x"0080")

      port map(A => sram_ren_xhdl6_0_sqmuxa, B => ahbsram_write, 
        C => ahbsram_addr(0), D => ahbsram_addr(1), Y => 
        sram_m1_e_0_0);
    
    \sramcurr_state_ns_1_0_.m8\ : CFG4
      generic map(INIT => x"0704")

      port map(A => \sram_done\, B => \sramcurr_state[1]_net_1\, 
        C => \sramcurr_state[0]_net_1\, D => N_6, Y => 
        \sramcurr_state_ns[1]\);
    
    \sramahb_rdata_xhdl2[10]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[10]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(10));
    
    \sramcurr_state[1]\ : SLE
      port map(D => \sramcurr_state_ns[1]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => VCC_net_1, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        \sramcurr_state[1]_net_1\);
    
    \sramcurr_state_ns_1_0_.m5\ : CFG3
      generic map(INIT => x"10")

      port map(A => ahbsram_write, B => ahbsram_req_d1, C => N_99, 
        Y => N_6);
    
    \sramahb_rdata_xhdl2[6]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[6]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(6));
    
    sram_ren_xhdl6_1_sqmuxa_0_a2 : CFG2
      generic map(INIT => x"4")

      port map(A => ahbsram_write, B => sram_ren_xhdl6_0_sqmuxa, 
        Y => sram_ren_xhdl6_1_sqmuxa);
    
    \sram_wen_mem_ns_1[0]\ : CFG4
      generic map(INIT => x"3F2F")

      port map(A => ahbsram_size_a0(1), B => ahbsram_size(0), C
         => sram_m1_e_1, D => ahbsram_size_0_0(1), Y => 
        \sram_wen_mem_ns_1[0]_net_1\);
    
    \sramahb_rdata_xhdl2[7]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[7]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(7));
    
    \sramahb_rdata_xhdl2[1]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[1]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(1));
    
    \sramahb_rdata_xhdl2[29]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[29]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(29));
    
    \S0.byte_1\ : 
        sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8_0
      port map(sramcurr_state(1) => \sramcurr_state[1]_net_1\, 
        sramcurr_state(0) => \sramcurr_state[0]_net_1\, 
        sram_wen_mem_ns_1(1) => \sram_wen_mem_ns_1[1]_net_1\, 
        ram_rdata_lsram_xhdl1(15) => \ram_rdata_lsram_xhdl1[15]\, 
        ram_rdata_lsram_xhdl1(14) => \ram_rdata_lsram_xhdl1[14]\, 
        ram_rdata_lsram_xhdl1(13) => \ram_rdata_lsram_xhdl1[13]\, 
        ram_rdata_lsram_xhdl1(12) => \ram_rdata_lsram_xhdl1[12]\, 
        ram_rdata_lsram_xhdl1(11) => \ram_rdata_lsram_xhdl1[11]\, 
        ram_rdata_lsram_xhdl1(10) => \ram_rdata_lsram_xhdl1[10]\, 
        ram_rdata_lsram_xhdl1(9) => \ram_rdata_lsram_xhdl1[9]\, 
        ram_rdata_lsram_xhdl1(8) => \ram_rdata_lsram_xhdl1[8]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(15) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(15), 
        CoreAHBLite_0_AHBmslave0_HWDATA(14) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(14), 
        CoreAHBLite_0_AHBmslave0_HWDATA(13) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(13), 
        CoreAHBLite_0_AHBmslave0_HWDATA(12) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(12), 
        CoreAHBLite_0_AHBmslave0_HWDATA(11) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(11), 
        CoreAHBLite_0_AHBmslave0_HWDATA(10) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(10), 
        CoreAHBLite_0_AHBmslave0_HWDATA(9) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(9), 
        CoreAHBLite_0_AHBmslave0_HWDATA(8) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(8), ahbsram_addr(12) => 
        ahbsram_addr(12), ahbsram_addr(11) => ahbsram_addr(11), 
        ahbsram_addr(10) => ahbsram_addr(10), ahbsram_addr(9) => 
        ahbsram_addr(9), ahbsram_addr(8) => ahbsram_addr(8), 
        ahbsram_addr(7) => ahbsram_addr(7), ahbsram_addr(6) => 
        ahbsram_addr(6), ahbsram_addr(5) => ahbsram_addr(5), 
        ahbsram_addr(4) => ahbsram_addr(4), ahbsram_addr(3) => 
        ahbsram_addr(3), ahbsram_addr(2) => ahbsram_addr(2), N_99
         => N_99, ahbsram_req_d1 => ahbsram_req_d1, HWRITE_d => 
        HWRITE_d, sramahb_ack => \sramahb_ack\, g0_1 => g0_1, 
        sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, MSS_READY => MSS_READY);
    
    \sram_wen_mem_ns_1_RNO_1[0]\ : CFG4
      generic map(INIT => x"0004")

      port map(A => ahbsram_req_d1, B => HWRITE_d, C => 
        \sramcurr_state[1]_net_1\, D => \sramahb_ack\, Y => 
        g0_1_3);
    
    \sram_wen_mem_ns_1[1]\ : CFG3
      generic map(INIT => x"2F")

      port map(A => ahbsram_size_0_0(1), B => ahbsram_size(0), C
         => sram_m1_e_0_0, Y => \sram_wen_mem_ns_1[1]_net_1\);
    
    \sram_wen_mem_ns_1_RNO[0]\ : CFG3
      generic map(INIT => x"04")

      port map(A => ahbsram_addr(1), B => \sram_wen_mem_m4[0]\, C
         => ahbsram_addr(0), Y => sram_m1_e_1);
    
    \sramahb_rdata_xhdl2[28]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[28]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(28));
    
    \sramahb_rdata_xhdl2[17]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[17]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(17));
    
    \sramahb_rdata_xhdl2[3]\ : SLE
      port map(D => \ram_rdata_lsram_xhdl1[3]\, CLK => 
        sha256_system_sb_0_FIC_0_CLK, EN => \sram_ren_d\, ALn => 
        MSS_READY, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => 
        CoreAHBLite_0_AHBmslave0_HRDATA(3));
    
    \sramcurr_state_RNIRU5H[0]\ : CFG4
      generic map(INIT => x"0100")

      port map(A => ahbsram_req_d1, B => 
        \sramcurr_state[1]_net_1\, C => \sramcurr_state[0]_net_1\, 
        D => N_99, Y => sram_ren_xhdl6_0_sqmuxa);
    
    sramahb_ack_xhdl1 : SLE
      port map(D => N_45_i_0, CLK => sha256_system_sb_0_FIC_0_CLK, 
        EN => VCC_net_1, ALn => MSS_READY, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \sramahb_ack\);
    
    g0_5 : CFG4
      generic map(INIT => x"89CD")

      port map(A => ahbsram_size_a0(1), B => ahbsram_size(0), C
         => ahbsram_size_0_0(1), D => \sram_m1_0_a2_0_1\, Y => 
        \g0_5\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM is

    port( CoreAHBLite_0_AHBmslave0_HSIZE                     : in    std_logic_vector(1 downto 0);
          M0GATEDHADDR                                       : in    std_logic_vector(10 downto 2);
          ahbcurr_state                                      : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2            : in    std_logic_vector(0 to 0);
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE  : in    std_logic_vector(1 to 1);
          regHSIZE                                           : in    std_logic_vector(1 to 1);
          M0GATEDHSIZE                                       : in    std_logic_vector(1 downto 0);
          arbRegSMCurrentState_RNIGOV71                      : in    std_logic_vector(12 to 12);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : in    std_logic_vector(1 to 1);
          CoreAHBLite_0_AHBmslave0_HRDATA                    : out   std_logic_vector(31 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA                    : in    std_logic_vector(31 downto 0);
          arbRegSMCurrentState_3                             : in    std_logic;
          arbRegSMCurrentState_0                             : in    std_logic;
          MSS_READY                                          : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic;
          N_121                                              : in    std_logic;
          N_124                                              : in    std_logic;
          N_123                                              : in    std_logic;
          N_122                                              : in    std_logic;
          N_27_i                                             : in    std_logic;
          N_99                                               : out   std_logic;
          N_113                                              : in    std_logic;
          g0_1                                               : in    std_logic;
          HWRITE_0_i_o2_2_1                                  : in    std_logic;
          N_99_i_0                                           : out   std_logic;
          masterRegAddrSel                                   : in    std_logic;
          regHTRANS                                          : in    std_logic;
          N_102                                              : in    std_logic;
          N_101                                              : in    std_logic
        );

end sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM;

architecture DEF_ARCH of 
        sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component AHBLSramIf
    port( CoreAHBLite_0_AHBmslave0_HSIZE                     : in    std_logic_vector(1 downto 0) := (others => 'U');
          M0GATEDHADDR                                       : in    std_logic_vector(10 downto 2) := (others => 'U');
          ahbsram_addr                                       : out   std_logic_vector(12 downto 0);
          ahbcurr_state                                      : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2            : in    std_logic_vector(0 to 0) := (others => 'U');
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1) := (others => 'U');
          ahbsram_size_a0                                    : out   std_logic_vector(1 to 1);
          ahbsram_size                                       : out   std_logic_vector(0 to 0);
          ahbsram_size_0_0                                   : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE  : in    std_logic_vector(1 to 1) := (others => 'U');
          regHSIZE                                           : in    std_logic_vector(1 to 1) := (others => 'U');
          M0GATEDHSIZE                                       : in    std_logic_vector(1 downto 0) := (others => 'U');
          arbRegSMCurrentState_RNIGOV71                      : in    std_logic_vector(12 to 12) := (others => 'U');
          ahbsram_size_a1                                    : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : in    std_logic_vector(1 to 1) := (others => 'U');
          HSIZE_d_1                                          : out   std_logic;
          arbRegSMCurrentState_3                             : in    std_logic := 'U';
          arbRegSMCurrentState_0                             : in    std_logic := 'U';
          MSS_READY                                          : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic := 'U';
          N_121                                              : in    std_logic := 'U';
          N_124                                              : in    std_logic := 'U';
          N_123                                              : in    std_logic := 'U';
          N_122                                              : in    std_logic := 'U';
          HWRITE_d                                           : out   std_logic;
          N_27_i                                             : in    std_logic := 'U';
          ahbsram_req_d1                                     : out   std_logic;
          N_99                                               : out   std_logic;
          N_113                                              : in    std_logic := 'U';
          sramahb_ack                                        : in    std_logic := 'U';
          N_44                                               : out   std_logic;
          g0_1                                               : in    std_logic := 'U';
          HWRITE_0_i_o2_2_1                                  : in    std_logic := 'U';
          ahbsram_write                                      : out   std_logic;
          N_99_i_0                                           : out   std_logic;
          masterRegAddrSel                                   : in    std_logic := 'U';
          regHTRANS                                          : in    std_logic := 'U';
          N_102                                              : in    std_logic := 'U';
          N_101                                              : in    std_logic := 'U'
        );
  end component;

  component sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf
    port( CoreAHBLite_0_AHBmslave0_HRDATA : out   std_logic_vector(31 downto 0);
          ahbsram_size_a0                 : in    std_logic_vector(1 to 1) := (others => 'U');
          ahbsram_size                    : in    std_logic_vector(0 to 0) := (others => 'U');
          ahbsram_size_0_0                : in    std_logic_vector(1 to 1) := (others => 'U');
          HSIZE_d                         : in    std_logic_vector(1 to 1) := (others => 'U');
          ahbsram_size_a1                 : in    std_logic_vector(1 to 1) := (others => 'U');
          ahbsram_addr                    : in    std_logic_vector(12 downto 0) := (others => 'U');
          CoreAHBLite_0_AHBmslave0_HWDATA : in    std_logic_vector(31 downto 0) := (others => 'U');
          MSS_READY                       : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK    : in    std_logic := 'U';
          sramahb_ack                     : out   std_logic;
          ahbsram_req_d1                  : in    std_logic := 'U';
          HWRITE_d                        : in    std_logic := 'U';
          N_99                            : in    std_logic := 'U';
          ahbsram_write                   : in    std_logic := 'U';
          N_44                            : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \HSIZE_d[1]\, \ahbsram_addr[0]\, \ahbsram_addr[1]\, 
        \ahbsram_addr[2]\, \ahbsram_addr[3]\, \ahbsram_addr[4]\, 
        \ahbsram_addr[5]\, \ahbsram_addr[6]\, \ahbsram_addr[7]\, 
        \ahbsram_addr[8]\, \ahbsram_addr[9]\, \ahbsram_addr[10]\, 
        \ahbsram_addr[11]\, \ahbsram_addr[12]\, 
        \ahbsram_size_a0[1]\, \ahbsram_size[0]\, 
        \ahbsram_size_0_0[1]\, \ahbsram_size_a1[1]\, HWRITE_d, 
        ahbsram_req_d1, \N_99\, sramahb_ack, N_44, ahbsram_write, 
        GND_net_1, VCC_net_1 : std_logic;

    for all : AHBLSramIf
	Use entity work.AHBLSramIf(DEF_ARCH);
    for all : sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf
	Use entity work.
        sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf(DEF_ARCH);
begin 

    N_99 <= \N_99\;

    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    U_AHBLSramIf : AHBLSramIf
      port map(CoreAHBLite_0_AHBmslave0_HSIZE(1) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(1), 
        CoreAHBLite_0_AHBmslave0_HSIZE(0) => 
        CoreAHBLite_0_AHBmslave0_HSIZE(0), M0GATEDHADDR(10) => 
        M0GATEDHADDR(10), M0GATEDHADDR(9) => M0GATEDHADDR(9), 
        M0GATEDHADDR(8) => M0GATEDHADDR(8), M0GATEDHADDR(7) => 
        M0GATEDHADDR(7), M0GATEDHADDR(6) => M0GATEDHADDR(6), 
        M0GATEDHADDR(5) => M0GATEDHADDR(5), M0GATEDHADDR(4) => 
        M0GATEDHADDR(4), M0GATEDHADDR(3) => M0GATEDHADDR(3), 
        M0GATEDHADDR(2) => M0GATEDHADDR(2), ahbsram_addr(12) => 
        \ahbsram_addr[12]\, ahbsram_addr(11) => 
        \ahbsram_addr[11]\, ahbsram_addr(10) => 
        \ahbsram_addr[10]\, ahbsram_addr(9) => \ahbsram_addr[9]\, 
        ahbsram_addr(8) => \ahbsram_addr[8]\, ahbsram_addr(7) => 
        \ahbsram_addr[7]\, ahbsram_addr(6) => \ahbsram_addr[6]\, 
        ahbsram_addr(5) => \ahbsram_addr[5]\, ahbsram_addr(4) => 
        \ahbsram_addr[4]\, ahbsram_addr(3) => \ahbsram_addr[3]\, 
        ahbsram_addr(2) => \ahbsram_addr[2]\, ahbsram_addr(1) => 
        \ahbsram_addr[1]\, ahbsram_addr(0) => \ahbsram_addr[0]\, 
        ahbcurr_state(1) => ahbcurr_state(1), ahbcurr_state(0)
         => ahbcurr_state(0), 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0) => 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0), SADDRSEL_0(1)
         => SADDRSEL_0(1), ahbsram_size_a0(1) => 
        \ahbsram_size_a0[1]\, ahbsram_size(0) => 
        \ahbsram_size[0]\, ahbsram_size_0_0(1) => 
        \ahbsram_size_0_0[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1), 
        regHSIZE(1) => regHSIZE(1), M0GATEDHSIZE(1) => 
        M0GATEDHSIZE(1), M0GATEDHSIZE(0) => M0GATEDHSIZE(0), 
        arbRegSMCurrentState_RNIGOV71(12) => 
        arbRegSMCurrentState_RNIGOV71(12), ahbsram_size_a1(1) => 
        \ahbsram_size_a1[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), 
        HSIZE_d_1 => \HSIZE_d[1]\, arbRegSMCurrentState_3 => 
        arbRegSMCurrentState_3, arbRegSMCurrentState_0 => 
        arbRegSMCurrentState_0, MSS_READY => MSS_READY, 
        sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, N_121 => N_121, N_124 => 
        N_124, N_123 => N_123, N_122 => N_122, HWRITE_d => 
        HWRITE_d, N_27_i => N_27_i, ahbsram_req_d1 => 
        ahbsram_req_d1, N_99 => \N_99\, N_113 => N_113, 
        sramahb_ack => sramahb_ack, N_44 => N_44, g0_1 => g0_1, 
        HWRITE_0_i_o2_2_1 => HWRITE_0_i_o2_2_1, ahbsram_write => 
        ahbsram_write, N_99_i_0 => N_99_i_0, masterRegAddrSel => 
        masterRegAddrSel, regHTRANS => regHTRANS, N_102 => N_102, 
        N_101 => N_101);
    
    U_SramCtrlIf : sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf
      port map(CoreAHBLite_0_AHBmslave0_HRDATA(31) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(31), 
        CoreAHBLite_0_AHBmslave0_HRDATA(30) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(30), 
        CoreAHBLite_0_AHBmslave0_HRDATA(29) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(29), 
        CoreAHBLite_0_AHBmslave0_HRDATA(28) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(28), 
        CoreAHBLite_0_AHBmslave0_HRDATA(27) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(27), 
        CoreAHBLite_0_AHBmslave0_HRDATA(26) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(26), 
        CoreAHBLite_0_AHBmslave0_HRDATA(25) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(25), 
        CoreAHBLite_0_AHBmslave0_HRDATA(24) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(24), 
        CoreAHBLite_0_AHBmslave0_HRDATA(23) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(23), 
        CoreAHBLite_0_AHBmslave0_HRDATA(22) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(22), 
        CoreAHBLite_0_AHBmslave0_HRDATA(21) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(21), 
        CoreAHBLite_0_AHBmslave0_HRDATA(20) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(20), 
        CoreAHBLite_0_AHBmslave0_HRDATA(19) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(19), 
        CoreAHBLite_0_AHBmslave0_HRDATA(18) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(18), 
        CoreAHBLite_0_AHBmslave0_HRDATA(17) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(17), 
        CoreAHBLite_0_AHBmslave0_HRDATA(16) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(16), 
        CoreAHBLite_0_AHBmslave0_HRDATA(15) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(15), 
        CoreAHBLite_0_AHBmslave0_HRDATA(14) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(14), 
        CoreAHBLite_0_AHBmslave0_HRDATA(13) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(13), 
        CoreAHBLite_0_AHBmslave0_HRDATA(12) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(12), 
        CoreAHBLite_0_AHBmslave0_HRDATA(11) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(11), 
        CoreAHBLite_0_AHBmslave0_HRDATA(10) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(10), 
        CoreAHBLite_0_AHBmslave0_HRDATA(9) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(9), 
        CoreAHBLite_0_AHBmslave0_HRDATA(8) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(8), 
        CoreAHBLite_0_AHBmslave0_HRDATA(7) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(7), 
        CoreAHBLite_0_AHBmslave0_HRDATA(6) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(6), 
        CoreAHBLite_0_AHBmslave0_HRDATA(5) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(5), 
        CoreAHBLite_0_AHBmslave0_HRDATA(4) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(4), 
        CoreAHBLite_0_AHBmslave0_HRDATA(3) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(3), 
        CoreAHBLite_0_AHBmslave0_HRDATA(2) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(2), 
        CoreAHBLite_0_AHBmslave0_HRDATA(1) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(1), 
        CoreAHBLite_0_AHBmslave0_HRDATA(0) => 
        CoreAHBLite_0_AHBmslave0_HRDATA(0), ahbsram_size_a0(1)
         => \ahbsram_size_a0[1]\, ahbsram_size(0) => 
        \ahbsram_size[0]\, ahbsram_size_0_0(1) => 
        \ahbsram_size_0_0[1]\, HSIZE_d(1) => \HSIZE_d[1]\, 
        ahbsram_size_a1(1) => \ahbsram_size_a1[1]\, 
        ahbsram_addr(12) => \ahbsram_addr[12]\, ahbsram_addr(11)
         => \ahbsram_addr[11]\, ahbsram_addr(10) => 
        \ahbsram_addr[10]\, ahbsram_addr(9) => \ahbsram_addr[9]\, 
        ahbsram_addr(8) => \ahbsram_addr[8]\, ahbsram_addr(7) => 
        \ahbsram_addr[7]\, ahbsram_addr(6) => \ahbsram_addr[6]\, 
        ahbsram_addr(5) => \ahbsram_addr[5]\, ahbsram_addr(4) => 
        \ahbsram_addr[4]\, ahbsram_addr(3) => \ahbsram_addr[3]\, 
        ahbsram_addr(2) => \ahbsram_addr[2]\, ahbsram_addr(1) => 
        \ahbsram_addr[1]\, ahbsram_addr(0) => \ahbsram_addr[0]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(31) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(31), 
        CoreAHBLite_0_AHBmslave0_HWDATA(30) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(30), 
        CoreAHBLite_0_AHBmslave0_HWDATA(29) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(29), 
        CoreAHBLite_0_AHBmslave0_HWDATA(28) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(28), 
        CoreAHBLite_0_AHBmslave0_HWDATA(27) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(27), 
        CoreAHBLite_0_AHBmslave0_HWDATA(26) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(26), 
        CoreAHBLite_0_AHBmslave0_HWDATA(25) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(25), 
        CoreAHBLite_0_AHBmslave0_HWDATA(24) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(24), 
        CoreAHBLite_0_AHBmslave0_HWDATA(23) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(23), 
        CoreAHBLite_0_AHBmslave0_HWDATA(22) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(22), 
        CoreAHBLite_0_AHBmslave0_HWDATA(21) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(21), 
        CoreAHBLite_0_AHBmslave0_HWDATA(20) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(20), 
        CoreAHBLite_0_AHBmslave0_HWDATA(19) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(19), 
        CoreAHBLite_0_AHBmslave0_HWDATA(18) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(18), 
        CoreAHBLite_0_AHBmslave0_HWDATA(17) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(17), 
        CoreAHBLite_0_AHBmslave0_HWDATA(16) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(16), 
        CoreAHBLite_0_AHBmslave0_HWDATA(15) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(15), 
        CoreAHBLite_0_AHBmslave0_HWDATA(14) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(14), 
        CoreAHBLite_0_AHBmslave0_HWDATA(13) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(13), 
        CoreAHBLite_0_AHBmslave0_HWDATA(12) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(12), 
        CoreAHBLite_0_AHBmslave0_HWDATA(11) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(11), 
        CoreAHBLite_0_AHBmslave0_HWDATA(10) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(10), 
        CoreAHBLite_0_AHBmslave0_HWDATA(9) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(9), 
        CoreAHBLite_0_AHBmslave0_HWDATA(8) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(8), 
        CoreAHBLite_0_AHBmslave0_HWDATA(7) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(7), 
        CoreAHBLite_0_AHBmslave0_HWDATA(6) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(6), 
        CoreAHBLite_0_AHBmslave0_HWDATA(5) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(5), 
        CoreAHBLite_0_AHBmslave0_HWDATA(4) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(4), 
        CoreAHBLite_0_AHBmslave0_HWDATA(3) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(3), 
        CoreAHBLite_0_AHBmslave0_HWDATA(2) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(2), 
        CoreAHBLite_0_AHBmslave0_HWDATA(1) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(1), 
        CoreAHBLite_0_AHBmslave0_HWDATA(0) => 
        CoreAHBLite_0_AHBmslave0_HWDATA(0), MSS_READY => 
        MSS_READY, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, sramahb_ack => sramahb_ack, 
        ahbsram_req_d1 => ahbsram_req_d1, HWRITE_d => HWRITE_d, 
        N_99 => \N_99\, ahbsram_write => ahbsram_write, N_44 => 
        N_44);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system_sb is

    port( xhdl1222                                           : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : inout std_logic_vector(1 to 1) := (others => 'Z');
          SADDRSEL_0                                         : out   std_logic_vector(1 to 1);
          SADDRSEL_2                                         : out   std_logic_vector(9 to 9);
          reg_2x32_0_data_out                                : in    std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP  : out   std_logic_vector(0 to 0);
          masterAddrInProg                                   : out   std_logic_vector(3 downto 1);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR              : out   std_logic_vector(2 to 2);
          AHB_slave_dummy_0_mem_wdata                        : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_3                             : out   std_logic;
          arbRegSMCurrentState_0                             : out   std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N                : out   std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N_i_0            : out   std_logic;
          DEVRST_N                                           : in    std_logic;
          sha256_system_sb_0_FIC_0_CLK                       : out   std_logic;
          regHTRANS                                          : out   std_logic;
          masterRegAddrSel                                   : out   std_logic;
          N_113                                              : out   std_logic;
          N_27_i                                             : out   std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY             : in    std_logic;
          N_156                                              : out   std_logic;
          N_128                                              : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                         : out   std_logic;
          defSlaveSMCurrentState                             : out   std_logic;
          hsel2                                              : out   std_logic;
          hsel2_1                                            : out   std_logic;
          lsram_m7_a0_1_0                                    : in    std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE             : out   std_logic;
          GPIO_0_OUT                                         : out   std_logic
        );

end sha256_system_sb;

architecture DEF_ARCH of sha256_system_sb is 

  component sha256_system_sb_MSS
    port( sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : out   std_logic_vector(1 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : in    std_logic_vector(31 downto 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : in    std_logic_vector(0 to 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : out   std_logic;
          GPIO_0_OUT                                           : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N      : out   std_logic;
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : out   std_logic;
          sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F           : out   std_logic;
          HREADY_M_iv_i_0                                      : in    std_logic := 'U';
          FIC_0_LOCK                                           : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic := 'U'
        );
  end component;

  component sha256_system_sb_FABOSC_0_OSC
    port( FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : out   std_logic
        );
  end component;

  component CoreResetP
    port( MSS_READY                                       : out   std_logic;
          sha256_system_sb_0_FIC_0_CLK                    : in    std_logic := 'U';
          sha256_system_sb_0_POWER_ON_RESET_N             : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F      : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N : in    std_logic := 'U'
        );
  end component;

  component CoreAHBLite
    port( regHSIZE                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE    : in    std_logic_vector(1 downto 0) := (others => 'U');
          xhdl1222                                             : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS   : in    std_logic_vector(1 to 1) := (others => 'U');
          SADDRSEL_0                                           : out   std_logic_vector(1 to 1);
          M0GATEDHSIZE                                         : out   std_logic_vector(1 downto 0);
          M0GATEDHADDR                                         : out   std_logic_vector(10 downto 2);
          SADDRSEL_2                                           : out   std_logic_vector(9 to 9);
          CoreAHBLite_0_AHBmslave0_HRDATA                      : in    std_logic_vector(31 downto 0) := (others => 'U');
          reg_2x32_0_data_out                                  : in    std_logic_vector(31 downto 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA   : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP    : out   std_logic_vector(0 to 0);
          ahbcurr_state                                        : in    std_logic_vector(1 downto 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA   : in    std_logic_vector(31 downto 0) := (others => 'U');
          CoreAHBLite_0_AHBmslave0_HWDATA                      : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2              : out   std_logic_vector(0 to 0);
          arbRegSMCurrentState_RNIGOV71                        : out   std_logic_vector(12 to 12);
          CoreAHBLite_0_AHBmslave0_HSIZE                       : out   std_logic_vector(1 downto 0);
          masterAddrInProg                                     : out   std_logic_vector(3 downto 1);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR                : out   std_logic_vector(2 to 2);
          AHB_slave_dummy_0_mem_wdata                          : out   std_logic_vector(31 downto 0);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0  : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1  : in    std_logic := 'U';
          arbRegSMCurrentState_3                               : out   std_logic;
          arbRegSMCurrentState_0_d0                            : out   std_logic;
          arbRegSMCurrentState_0_3                             : out   std_logic;
          arbRegSMCurrentState_0_0                             : out   std_logic;
          MSS_READY                                            : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                         : in    std_logic := 'U';
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE   : in    std_logic := 'U';
          regHTRANS                                            : out   std_logic;
          masterRegAddrSel                                     : out   std_logic;
          N_113                                                : out   std_logic;
          N_121                                                : out   std_logic;
          N_27_i                                               : out   std_logic;
          N_124                                                : out   std_logic;
          N_122                                                : out   std_logic;
          N_123                                                : out   std_logic;
          N_99                                                 : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY               : in    std_logic := 'U';
          N_156                                                : out   std_logic;
          N_128                                                : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                           : out   std_logic;
          defSlaveSMCurrentState                               : out   std_logic;
          N_102                                                : out   std_logic;
          HREADY_M_iv_i_0                                      : out   std_logic;
          N_99_i_0                                             : in    std_logic := 'U';
          HWRITE_0_i_o2_2_1                                    : out   std_logic;
          g0_1                                                 : out   std_logic;
          N_101                                                : out   std_logic;
          hsel2                                                : out   std_logic;
          hsel2_1                                              : out   std_logic;
          lsram_m7_a0_1_0                                      : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE               : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component sha256_system_sb_CCC_0_FCCC
    port( sha256_system_sb_0_FIC_0_CLK                       : out   std_logic;
          FIC_0_LOCK                                         : out   std_logic;
          FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component SYSRESET
    port( POWER_ON_RESET_N : out   std_logic;
          DEVRST_N         : in    std_logic := 'U'
        );
  end component;

  component sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM
    port( CoreAHBLite_0_AHBmslave0_HSIZE                     : in    std_logic_vector(1 downto 0) := (others => 'U');
          M0GATEDHADDR                                       : in    std_logic_vector(10 downto 2) := (others => 'U');
          ahbcurr_state                                      : out   std_logic_vector(1 downto 0);
          arbRegSMCurrentState_ns_i_a2_0_RNITP6S2            : in    std_logic_vector(0 to 0) := (others => 'U');
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE  : in    std_logic_vector(1 to 1) := (others => 'U');
          regHSIZE                                           : in    std_logic_vector(1 to 1) := (others => 'U');
          M0GATEDHSIZE                                       : in    std_logic_vector(1 downto 0) := (others => 'U');
          arbRegSMCurrentState_RNIGOV71                      : in    std_logic_vector(12 to 12) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : in    std_logic_vector(1 to 1) := (others => 'U');
          CoreAHBLite_0_AHBmslave0_HRDATA                    : out   std_logic_vector(31 downto 0);
          CoreAHBLite_0_AHBmslave0_HWDATA                    : in    std_logic_vector(31 downto 0) := (others => 'U');
          arbRegSMCurrentState_3                             : in    std_logic := 'U';
          arbRegSMCurrentState_0                             : in    std_logic := 'U';
          MSS_READY                                          : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic := 'U';
          N_121                                              : in    std_logic := 'U';
          N_124                                              : in    std_logic := 'U';
          N_123                                              : in    std_logic := 'U';
          N_122                                              : in    std_logic := 'U';
          N_27_i                                             : in    std_logic := 'U';
          N_99                                               : out   std_logic;
          N_113                                              : in    std_logic := 'U';
          g0_1                                               : in    std_logic := 'U';
          HWRITE_0_i_o2_2_1                                  : in    std_logic := 'U';
          N_99_i_0                                           : out   std_logic;
          masterRegAddrSel                                   : in    std_logic := 'U';
          regHTRANS                                          : in    std_logic := 'U';
          N_102                                              : in    std_logic := 'U';
          N_101                                              : in    std_logic := 'U'
        );
  end component;

    signal \sha256_system_sb_0_POWER_ON_RESET_N\, 
        \sha256_system_sb_0_FIC_0_CLK\, FIC_0_LOCK, 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[24]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[25]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[26]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[27]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[2]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[3]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[4]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[5]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[6]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[7]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[8]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[9]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[10]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[11]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[12]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[0]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[1]\, 
        \regHSIZE[1]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE[0]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE[1]\, 
        \SADDRSEL_0[1]\, \M0GATEDHSIZE[0]\, \M0GATEDHSIZE[1]\, 
        \M0GATEDHADDR[2]\, \M0GATEDHADDR[3]\, \M0GATEDHADDR[4]\, 
        \M0GATEDHADDR[5]\, \M0GATEDHADDR[6]\, \M0GATEDHADDR[7]\, 
        \M0GATEDHADDR[8]\, \M0GATEDHADDR[9]\, \M0GATEDHADDR[10]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[0]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[1]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[2]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[3]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[4]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[5]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[6]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[7]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[8]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[9]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[10]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[11]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[12]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[13]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[14]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[15]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[16]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[17]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[18]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[19]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[20]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[21]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[22]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[23]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[24]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[25]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[26]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[27]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[28]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[29]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[30]\, 
        \CoreAHBLite_0_AHBmslave0_HRDATA[31]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[0]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[1]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[2]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[3]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[4]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[5]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[6]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[7]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[8]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[9]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[10]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[11]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[12]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[13]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[14]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[15]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[16]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[17]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[18]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[19]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[20]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[21]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[22]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[23]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[24]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[25]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[26]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[27]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[28]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[29]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[30]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[31]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, 
        \ahbcurr_state[0]\, \ahbcurr_state[1]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[0]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[1]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[2]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[3]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[4]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[5]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[6]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[7]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[8]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[9]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[10]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[11]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[12]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[13]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[14]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[15]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[16]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[17]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[18]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[19]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[20]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[21]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[22]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[23]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[24]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[25]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[26]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[27]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[28]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[29]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[30]\, 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[31]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[0]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[1]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[2]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[3]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[4]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[5]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[6]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[7]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[8]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[9]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[10]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[11]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[12]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[13]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[14]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[15]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[16]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[17]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[18]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[19]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[20]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[21]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[22]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[23]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[24]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[25]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[26]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[27]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[28]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[29]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[30]\, 
        \CoreAHBLite_0_AHBmslave0_HWDATA[31]\, 
        \arbRegSMCurrentState_0[15]\, 
        \arbRegSMCurrentState_0[12]\, 
        \arbRegSMCurrentState_ns_i_a2_0_RNITP6S2[0]\, 
        \arbRegSMCurrentState_RNIGOV71[12]\, 
        \CoreAHBLite_0_AHBmslave0_HSIZE[0]\, 
        \CoreAHBLite_0_AHBmslave0_HSIZE[1]\, MSS_READY, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, 
        \regHTRANS\, \masterRegAddrSel\, \N_113\, N_121, \N_27_i\, 
        N_124, N_122, N_123, N_99, N_102, HREADY_M_iv_i_0, 
        N_99_i_0, HWRITE_0_i_o2_2_1, g0_1, N_101, 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F, 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, 
        GND_net_1, VCC_net_1 : std_logic;

    for all : sha256_system_sb_MSS
	Use entity work.sha256_system_sb_MSS(DEF_ARCH);
    for all : sha256_system_sb_FABOSC_0_OSC
	Use entity work.sha256_system_sb_FABOSC_0_OSC(DEF_ARCH);
    for all : CoreResetP
	Use entity work.CoreResetP(DEF_ARCH);
    for all : CoreAHBLite
	Use entity work.CoreAHBLite(DEF_ARCH);
    for all : sha256_system_sb_CCC_0_FCCC
	Use entity work.sha256_system_sb_CCC_0_FCCC(DEF_ARCH);
    for all : sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM
	Use entity work.
        sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM(DEF_ARCH);
begin 

    SADDRSEL_0(1) <= \SADDRSEL_0[1]\;
    sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) <= 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\;
    sha256_system_sb_0_POWER_ON_RESET_N <= 
        \sha256_system_sb_0_POWER_ON_RESET_N\;
    sha256_system_sb_0_FIC_0_CLK <= 
        \sha256_system_sb_0_FIC_0_CLK\;
    regHTRANS <= \regHTRANS\;
    masterRegAddrSel <= \masterRegAddrSel\;
    N_113 <= \N_113\;
    N_27_i <= \N_27_i\;

    sha256_system_sb_MSS_0 : sha256_system_sb_MSS
      port map(
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[31]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[30]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[29]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[28]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[27]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[26]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[25]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[24]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[23]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[22]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[21]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[20]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[19]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[18]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[17]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[16]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[15]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[14]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[13]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[12]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[11]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[10]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[9]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[8]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[7]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[6]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[5]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[4]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[3]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[31]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[30]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[29]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[28]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[27]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[26]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[25]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[24]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[23]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[22]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[21]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[20]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[19]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[18]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[17]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[16]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[15]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[14]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[13]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[12]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[11]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[10]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[9]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[8]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[7]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[6]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[5]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[4]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[3]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[3]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[4]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[5]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[6]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[7]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[8]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[9]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[10]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[11]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[12]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[24]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[25]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[26]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[27]\, 
        GPIO_0_OUT => GPIO_0_OUT, 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N => 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F => 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F, 
        HREADY_M_iv_i_0 => HREADY_M_iv_i_0, FIC_0_LOCK => 
        FIC_0_LOCK, sha256_system_sb_0_FIC_0_CLK => 
        \sha256_system_sb_0_FIC_0_CLK\);
    
    FABOSC_0 : sha256_system_sb_FABOSC_0_OSC
      port map(FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC
         => FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC);
    
    CORERESETP_0 : CoreResetP
      port map(MSS_READY => MSS_READY, 
        sha256_system_sb_0_FIC_0_CLK => 
        \sha256_system_sb_0_FIC_0_CLK\, 
        sha256_system_sb_0_POWER_ON_RESET_N => 
        \sha256_system_sb_0_POWER_ON_RESET_N\, 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F => 
        sha256_system_sb_MSS_TMP_0_MSS_RESET_N_M2F, 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N => 
        sha256_system_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N);
    
    CoreAHBLite_0 : CoreAHBLite
      port map(regHSIZE(1) => \regHSIZE[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE[0]\, 
        xhdl1222(1) => xhdl1222(1), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), 
        SADDRSEL_0(1) => \SADDRSEL_0[1]\, M0GATEDHSIZE(1) => 
        \M0GATEDHSIZE[1]\, M0GATEDHSIZE(0) => \M0GATEDHSIZE[0]\, 
        M0GATEDHADDR(10) => \M0GATEDHADDR[10]\, M0GATEDHADDR(9)
         => \M0GATEDHADDR[9]\, M0GATEDHADDR(8) => 
        \M0GATEDHADDR[8]\, M0GATEDHADDR(7) => \M0GATEDHADDR[7]\, 
        M0GATEDHADDR(6) => \M0GATEDHADDR[6]\, M0GATEDHADDR(5) => 
        \M0GATEDHADDR[5]\, M0GATEDHADDR(4) => \M0GATEDHADDR[4]\, 
        M0GATEDHADDR(3) => \M0GATEDHADDR[3]\, M0GATEDHADDR(2) => 
        \M0GATEDHADDR[2]\, SADDRSEL_2(9) => SADDRSEL_2(9), 
        CoreAHBLite_0_AHBmslave0_HRDATA(31) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[31]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(30) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[30]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(29) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[29]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(28) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[28]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(27) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[27]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(26) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[26]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(25) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[25]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(24) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[24]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(23) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[23]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(22) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[22]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(21) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[21]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(20) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[20]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(19) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[19]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(18) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[18]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(17) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[17]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(16) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[16]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(15) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[15]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(14) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[14]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(13) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[13]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(12) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[12]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(11) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[11]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(10) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[10]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(9) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[9]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(8) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[8]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(7) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[7]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(6) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[6]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(5) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[5]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(4) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[4]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(3) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[3]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(2) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[2]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(1) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[1]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(0) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[0]\, 
        reg_2x32_0_data_out(31) => reg_2x32_0_data_out(31), 
        reg_2x32_0_data_out(30) => reg_2x32_0_data_out(30), 
        reg_2x32_0_data_out(29) => reg_2x32_0_data_out(29), 
        reg_2x32_0_data_out(28) => reg_2x32_0_data_out(28), 
        reg_2x32_0_data_out(27) => reg_2x32_0_data_out(27), 
        reg_2x32_0_data_out(26) => reg_2x32_0_data_out(26), 
        reg_2x32_0_data_out(25) => reg_2x32_0_data_out(25), 
        reg_2x32_0_data_out(24) => reg_2x32_0_data_out(24), 
        reg_2x32_0_data_out(23) => reg_2x32_0_data_out(23), 
        reg_2x32_0_data_out(22) => reg_2x32_0_data_out(22), 
        reg_2x32_0_data_out(21) => reg_2x32_0_data_out(21), 
        reg_2x32_0_data_out(20) => reg_2x32_0_data_out(20), 
        reg_2x32_0_data_out(19) => reg_2x32_0_data_out(19), 
        reg_2x32_0_data_out(18) => reg_2x32_0_data_out(18), 
        reg_2x32_0_data_out(17) => reg_2x32_0_data_out(17), 
        reg_2x32_0_data_out(16) => reg_2x32_0_data_out(16), 
        reg_2x32_0_data_out(15) => reg_2x32_0_data_out(15), 
        reg_2x32_0_data_out(14) => reg_2x32_0_data_out(14), 
        reg_2x32_0_data_out(13) => reg_2x32_0_data_out(13), 
        reg_2x32_0_data_out(12) => reg_2x32_0_data_out(12), 
        reg_2x32_0_data_out(11) => reg_2x32_0_data_out(11), 
        reg_2x32_0_data_out(10) => reg_2x32_0_data_out(10), 
        reg_2x32_0_data_out(9) => reg_2x32_0_data_out(9), 
        reg_2x32_0_data_out(8) => reg_2x32_0_data_out(8), 
        reg_2x32_0_data_out(7) => reg_2x32_0_data_out(7), 
        reg_2x32_0_data_out(6) => reg_2x32_0_data_out(6), 
        reg_2x32_0_data_out(5) => reg_2x32_0_data_out(5), 
        reg_2x32_0_data_out(4) => reg_2x32_0_data_out(4), 
        reg_2x32_0_data_out(3) => reg_2x32_0_data_out(3), 
        reg_2x32_0_data_out(2) => reg_2x32_0_data_out(2), 
        reg_2x32_0_data_out(1) => reg_2x32_0_data_out(1), 
        reg_2x32_0_data_out(0) => reg_2x32_0_data_out(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(31)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[31]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(30)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[30]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(29)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[29]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(28)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[28]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(27)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[27]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(26)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[26]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(25)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[25]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(24)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[24]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(23)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[23]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(22)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[22]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(21)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[21]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(20)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[20]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(19)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[19]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(18)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[18]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(17)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[17]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(16)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[16]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(15)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[15]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(14)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[14]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(13)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[13]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(12)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[12]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(11)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[11]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(10)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[10]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(9) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[9]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(8) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[8]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(7) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[7]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(6) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[6]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(5) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[5]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(4) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[4]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(3) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[3]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(2) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(1) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRDATA[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, 
        ahbcurr_state(1) => \ahbcurr_state[1]\, ahbcurr_state(0)
         => \ahbcurr_state[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(31)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[31]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(30)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[30]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(29)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[29]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(28)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[28]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(27)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[27]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(26)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[26]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(25)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[25]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(24)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[24]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(23)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[23]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(22)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[22]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(21)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[21]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(20)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[20]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(19)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[19]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(18)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[18]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(17)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[17]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(16)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[16]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(15)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[15]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(14)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[14]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(13)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[13]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(12)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[12]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(11)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[11]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(10)
         => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[10]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(9) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[9]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(8) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[8]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(7) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[7]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(6) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[6]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(5) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[5]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(4) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[4]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(3) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[3]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(2) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(1) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA(0) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWDATA[0]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(31) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[31]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(30) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[30]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(29) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[29]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(28) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[28]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(27) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[27]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(26) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[26]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(25) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[25]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(24) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[24]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(23) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[23]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(22) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[22]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(21) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[21]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(20) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[20]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(19) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[19]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(18) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[18]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(17) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[17]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(16) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[16]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(15) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[15]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(14) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[14]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(13) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[13]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(12) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[12]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(11) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[11]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(10) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[10]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(9) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[9]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(8) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[8]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(7) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[7]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(6) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[6]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(5) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[5]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(4) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[4]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(3) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[3]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(2) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[2]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(1) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[1]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(0) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[0]\, 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0) => 
        \arbRegSMCurrentState_ns_i_a2_0_RNITP6S2[0]\, 
        arbRegSMCurrentState_RNIGOV71(12) => 
        \arbRegSMCurrentState_RNIGOV71[12]\, 
        CoreAHBLite_0_AHBmslave0_HSIZE(1) => 
        \CoreAHBLite_0_AHBmslave0_HSIZE[1]\, 
        CoreAHBLite_0_AHBmslave0_HSIZE(0) => 
        \CoreAHBLite_0_AHBmslave0_HSIZE[0]\, masterAddrInProg(3)
         => masterAddrInProg(3), masterAddrInProg(2) => 
        masterAddrInProg(2), masterAddrInProg(1) => 
        masterAddrInProg(1), 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2) => 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2), 
        AHB_slave_dummy_0_mem_wdata(31) => 
        AHB_slave_dummy_0_mem_wdata(31), 
        AHB_slave_dummy_0_mem_wdata(30) => 
        AHB_slave_dummy_0_mem_wdata(30), 
        AHB_slave_dummy_0_mem_wdata(29) => 
        AHB_slave_dummy_0_mem_wdata(29), 
        AHB_slave_dummy_0_mem_wdata(28) => 
        AHB_slave_dummy_0_mem_wdata(28), 
        AHB_slave_dummy_0_mem_wdata(27) => 
        AHB_slave_dummy_0_mem_wdata(27), 
        AHB_slave_dummy_0_mem_wdata(26) => 
        AHB_slave_dummy_0_mem_wdata(26), 
        AHB_slave_dummy_0_mem_wdata(25) => 
        AHB_slave_dummy_0_mem_wdata(25), 
        AHB_slave_dummy_0_mem_wdata(24) => 
        AHB_slave_dummy_0_mem_wdata(24), 
        AHB_slave_dummy_0_mem_wdata(23) => 
        AHB_slave_dummy_0_mem_wdata(23), 
        AHB_slave_dummy_0_mem_wdata(22) => 
        AHB_slave_dummy_0_mem_wdata(22), 
        AHB_slave_dummy_0_mem_wdata(21) => 
        AHB_slave_dummy_0_mem_wdata(21), 
        AHB_slave_dummy_0_mem_wdata(20) => 
        AHB_slave_dummy_0_mem_wdata(20), 
        AHB_slave_dummy_0_mem_wdata(19) => 
        AHB_slave_dummy_0_mem_wdata(19), 
        AHB_slave_dummy_0_mem_wdata(18) => 
        AHB_slave_dummy_0_mem_wdata(18), 
        AHB_slave_dummy_0_mem_wdata(17) => 
        AHB_slave_dummy_0_mem_wdata(17), 
        AHB_slave_dummy_0_mem_wdata(16) => 
        AHB_slave_dummy_0_mem_wdata(16), 
        AHB_slave_dummy_0_mem_wdata(15) => 
        AHB_slave_dummy_0_mem_wdata(15), 
        AHB_slave_dummy_0_mem_wdata(14) => 
        AHB_slave_dummy_0_mem_wdata(14), 
        AHB_slave_dummy_0_mem_wdata(13) => 
        AHB_slave_dummy_0_mem_wdata(13), 
        AHB_slave_dummy_0_mem_wdata(12) => 
        AHB_slave_dummy_0_mem_wdata(12), 
        AHB_slave_dummy_0_mem_wdata(11) => 
        AHB_slave_dummy_0_mem_wdata(11), 
        AHB_slave_dummy_0_mem_wdata(10) => 
        AHB_slave_dummy_0_mem_wdata(10), 
        AHB_slave_dummy_0_mem_wdata(9) => 
        AHB_slave_dummy_0_mem_wdata(9), 
        AHB_slave_dummy_0_mem_wdata(8) => 
        AHB_slave_dummy_0_mem_wdata(8), 
        AHB_slave_dummy_0_mem_wdata(7) => 
        AHB_slave_dummy_0_mem_wdata(7), 
        AHB_slave_dummy_0_mem_wdata(6) => 
        AHB_slave_dummy_0_mem_wdata(6), 
        AHB_slave_dummy_0_mem_wdata(5) => 
        AHB_slave_dummy_0_mem_wdata(5), 
        AHB_slave_dummy_0_mem_wdata(4) => 
        AHB_slave_dummy_0_mem_wdata(4), 
        AHB_slave_dummy_0_mem_wdata(3) => 
        AHB_slave_dummy_0_mem_wdata(3), 
        AHB_slave_dummy_0_mem_wdata(2) => 
        AHB_slave_dummy_0_mem_wdata(2), 
        AHB_slave_dummy_0_mem_wdata(1) => 
        AHB_slave_dummy_0_mem_wdata(1), 
        AHB_slave_dummy_0_mem_wdata(0) => 
        AHB_slave_dummy_0_mem_wdata(0), 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_24 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[24]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_25 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[25]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_26 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[26]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_27 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[27]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_2 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[2]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_3 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[3]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_4 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[4]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_5 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[5]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_6 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[6]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_7 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[7]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_8 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[8]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_9 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[9]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_10 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[10]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_11 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[11]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_12 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[12]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_0 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR_1 => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HADDR[1]\, 
        arbRegSMCurrentState_3 => arbRegSMCurrentState_3, 
        arbRegSMCurrentState_0_d0 => arbRegSMCurrentState_0, 
        arbRegSMCurrentState_0_3 => \arbRegSMCurrentState_0[15]\, 
        arbRegSMCurrentState_0_0 => \arbRegSMCurrentState_0[12]\, 
        MSS_READY => MSS_READY, sha256_system_sb_0_FIC_0_CLK => 
        \sha256_system_sb_0_FIC_0_CLK\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HWRITE, 
        regHTRANS => \regHTRANS\, masterRegAddrSel => 
        \masterRegAddrSel\, N_113 => \N_113\, N_121 => N_121, 
        N_27_i => \N_27_i\, N_124 => N_124, N_122 => N_122, N_123
         => N_123, N_99 => N_99, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, N_156 => N_156, 
        N_128 => N_128, AMBA_SLAVE_0_HREADY_S1_i_m => 
        AMBA_SLAVE_0_HREADY_S1_i_m, defSlaveSMCurrentState => 
        defSlaveSMCurrentState, N_102 => N_102, HREADY_M_iv_i_0
         => HREADY_M_iv_i_0, N_99_i_0 => N_99_i_0, 
        HWRITE_0_i_o2_2_1 => HWRITE_0_i_o2_2_1, g0_1 => g0_1, 
        N_101 => N_101, hsel2 => hsel2, hsel2_1 => hsel2_1, 
        lsram_m7_a0_1_0 => lsram_m7_a0_1_0, 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE => 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    SYSRESET_POR_RNI03O8 : CFG1
      generic map(INIT => "01")

      port map(A => \sha256_system_sb_0_POWER_ON_RESET_N\, Y => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0);
    
    CCC_0 : sha256_system_sb_CCC_0_FCCC
      port map(sha256_system_sb_0_FIC_0_CLK => 
        \sha256_system_sb_0_FIC_0_CLK\, FIC_0_LOCK => FIC_0_LOCK, 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC => 
        FABOSC_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    SYSRESET_POR : SYSRESET
      port map(POWER_ON_RESET_N => 
        \sha256_system_sb_0_POWER_ON_RESET_N\, DEVRST_N => 
        DEVRST_N);
    
    COREAHBLSRAM_0_0 : 
        sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM
      port map(CoreAHBLite_0_AHBmslave0_HSIZE(1) => 
        \CoreAHBLite_0_AHBmslave0_HSIZE[1]\, 
        CoreAHBLite_0_AHBmslave0_HSIZE(0) => 
        \CoreAHBLite_0_AHBmslave0_HSIZE[0]\, M0GATEDHADDR(10) => 
        \M0GATEDHADDR[10]\, M0GATEDHADDR(9) => \M0GATEDHADDR[9]\, 
        M0GATEDHADDR(8) => \M0GATEDHADDR[8]\, M0GATEDHADDR(7) => 
        \M0GATEDHADDR[7]\, M0GATEDHADDR(6) => \M0GATEDHADDR[6]\, 
        M0GATEDHADDR(5) => \M0GATEDHADDR[5]\, M0GATEDHADDR(4) => 
        \M0GATEDHADDR[4]\, M0GATEDHADDR(3) => \M0GATEDHADDR[3]\, 
        M0GATEDHADDR(2) => \M0GATEDHADDR[2]\, ahbcurr_state(1)
         => \ahbcurr_state[1]\, ahbcurr_state(0) => 
        \ahbcurr_state[0]\, 
        arbRegSMCurrentState_ns_i_a2_0_RNITP6S2(0) => 
        \arbRegSMCurrentState_ns_i_a2_0_RNITP6S2[0]\, 
        SADDRSEL_0(1) => \SADDRSEL_0[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE(1) => 
        \sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HSIZE[1]\, 
        regHSIZE(1) => \regHSIZE[1]\, M0GATEDHSIZE(1) => 
        \M0GATEDHSIZE[1]\, M0GATEDHSIZE(0) => \M0GATEDHSIZE[0]\, 
        arbRegSMCurrentState_RNIGOV71(12) => 
        \arbRegSMCurrentState_RNIGOV71[12]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1), 
        CoreAHBLite_0_AHBmslave0_HRDATA(31) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[31]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(30) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[30]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(29) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[29]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(28) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[28]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(27) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[27]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(26) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[26]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(25) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[25]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(24) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[24]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(23) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[23]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(22) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[22]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(21) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[21]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(20) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[20]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(19) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[19]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(18) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[18]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(17) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[17]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(16) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[16]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(15) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[15]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(14) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[14]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(13) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[13]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(12) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[12]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(11) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[11]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(10) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[10]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(9) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[9]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(8) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[8]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(7) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[7]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(6) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[6]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(5) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[5]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(4) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[4]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(3) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[3]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(2) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[2]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(1) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[1]\, 
        CoreAHBLite_0_AHBmslave0_HRDATA(0) => 
        \CoreAHBLite_0_AHBmslave0_HRDATA[0]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(31) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[31]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(30) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[30]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(29) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[29]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(28) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[28]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(27) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[27]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(26) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[26]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(25) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[25]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(24) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[24]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(23) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[23]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(22) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[22]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(21) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[21]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(20) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[20]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(19) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[19]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(18) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[18]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(17) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[17]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(16) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[16]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(15) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[15]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(14) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[14]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(13) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[13]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(12) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[12]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(11) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[11]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(10) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[10]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(9) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[9]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(8) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[8]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(7) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[7]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(6) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[6]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(5) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[5]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(4) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[4]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(3) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[3]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(2) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[2]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(1) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[1]\, 
        CoreAHBLite_0_AHBmslave0_HWDATA(0) => 
        \CoreAHBLite_0_AHBmslave0_HWDATA[0]\, 
        arbRegSMCurrentState_3 => \arbRegSMCurrentState_0[15]\, 
        arbRegSMCurrentState_0 => \arbRegSMCurrentState_0[12]\, 
        MSS_READY => MSS_READY, sha256_system_sb_0_FIC_0_CLK => 
        \sha256_system_sb_0_FIC_0_CLK\, N_121 => N_121, N_124 => 
        N_124, N_123 => N_123, N_122 => N_122, N_27_i => \N_27_i\, 
        N_99 => N_99, N_113 => \N_113\, g0_1 => g0_1, 
        HWRITE_0_i_o2_2_1 => HWRITE_0_i_o2_2_1, N_99_i_0 => 
        N_99_i_0, masterRegAddrSel => \masterRegAddrSel\, 
        regHTRANS => \regHTRANS\, N_102 => N_102, N_101 => N_101);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity sha256_system is

    port( DEVRST_N   : in    std_logic;
          GPIO_0_OUT : out   std_logic
        );

end sha256_system;

architecture DEF_ARCH of sha256_system is 

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component reg_2x32
    port( AHB_slave_dummy_0_mem_wdata             : in    std_logic_vector(31 downto 0) := (others => 'U');
          reg_2x32_0_data_out                     : out   std_logic_vector(31 downto 0);
          lsram_raddr_net_0                       : in    std_logic_vector(0 to 0) := (others => 'U');
          lsram_waddr_net_0                       : in    std_logic_vector(0 to 0) := (others => 'U');
          sha256_system_sb_0_FIC_0_CLK            : in    std_logic := 'U';
          sha256_system_sb_0_POWER_ON_RESET_N_i_0 : in    std_logic := 'U';
          sha256_system_sb_0_POWER_ON_RESET_N     : in    std_logic := 'U';
          AHB_slave_dummy_0_write_en              : in    std_logic := 'U';
          AHB_slave_dummy_0_read_en               : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component AHB_slave_dummy
    port( lsram_waddr_net_0                                  : out   std_logic_vector(0 to 0);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR              : in    std_logic_vector(2 to 2) := (others => 'U');
          lsram_raddr_net_0                                  : out   std_logic_vector(0 to 0);
          masterAddrInProg                                   : in    std_logic_vector(3 downto 1) := (others => 'U');
          xhdl1222                                           : in    std_logic_vector(1 to 1) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP  : in    std_logic_vector(0 to 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : in    std_logic_vector(1 to 1) := (others => 'U');
          SADDRSEL_2                                         : in    std_logic_vector(9 to 9) := (others => 'U');
          SADDRSEL_0                                         : in    std_logic_vector(1 to 1) := (others => 'U');
          arbRegSMCurrentState_3                             : in    std_logic := 'U';
          arbRegSMCurrentState_0                             : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY             : out   std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N                : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                       : in    std_logic := 'U';
          AHB_slave_dummy_0_write_en                         : out   std_logic;
          AHB_slave_dummy_0_read_en                          : out   std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE             : in    std_logic := 'U';
          N_156                                              : in    std_logic := 'U';
          lsram_m7_a0_1_0                                    : out   std_logic;
          N_27_i                                             : in    std_logic := 'U';
          AMBA_SLAVE_0_HREADY_S1_i_m                         : in    std_logic := 'U';
          defSlaveSMCurrentState                             : in    std_logic := 'U';
          N_128                                              : in    std_logic := 'U';
          hsel2_1                                            : in    std_logic := 'U';
          regHTRANS                                          : in    std_logic := 'U';
          masterRegAddrSel                                   : in    std_logic := 'U';
          N_113                                              : in    std_logic := 'U';
          hsel2                                              : in    std_logic := 'U'
        );
  end component;

  component sha256_system_sb
    port( xhdl1222                                           : out   std_logic_vector(1 to 1);
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS : inout   std_logic_vector(1 to 1);
          SADDRSEL_0                                         : out   std_logic_vector(1 to 1);
          SADDRSEL_2                                         : out   std_logic_vector(9 to 9);
          reg_2x32_0_data_out                                : in    std_logic_vector(31 downto 0) := (others => 'U');
          sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP  : out   std_logic_vector(0 to 0);
          masterAddrInProg                                   : out   std_logic_vector(3 downto 1);
          sha256_system_sb_0_AMBA_SLAVE_0_HADDR              : out   std_logic_vector(2 to 2);
          AHB_slave_dummy_0_mem_wdata                        : out   std_logic_vector(31 downto 0);
          arbRegSMCurrentState_3                             : out   std_logic;
          arbRegSMCurrentState_0                             : out   std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N                : out   std_logic;
          sha256_system_sb_0_POWER_ON_RESET_N_i_0            : out   std_logic;
          DEVRST_N                                           : in    std_logic := 'U';
          sha256_system_sb_0_FIC_0_CLK                       : out   std_logic;
          regHTRANS                                          : out   std_logic;
          masterRegAddrSel                                   : out   std_logic;
          N_113                                              : out   std_logic;
          N_27_i                                             : out   std_logic;
          sha256_system_sb_0_AMBA_SLAVE_0_HREADY             : in    std_logic := 'U';
          N_156                                              : out   std_logic;
          N_128                                              : out   std_logic;
          AMBA_SLAVE_0_HREADY_S1_i_m                         : out   std_logic;
          defSlaveSMCurrentState                             : out   std_logic;
          hsel2                                              : out   std_logic;
          hsel2_1                                            : out   std_logic;
          lsram_m7_a0_1_0                                    : in    std_logic := 'U';
          sha256_system_sb_0_AMBA_SLAVE_0_HWRITE             : out   std_logic;
          GPIO_0_OUT                                         : out   std_logic
        );
  end component;

    signal sha256_system_sb_0_FIC_0_CLK, 
        sha256_system_sb_0_POWER_ON_RESET_N, 
        \AHB_slave_dummy_0_mem_wdata[0]\, 
        \AHB_slave_dummy_0_mem_wdata[1]\, 
        \AHB_slave_dummy_0_mem_wdata[2]\, 
        \AHB_slave_dummy_0_mem_wdata[3]\, 
        \AHB_slave_dummy_0_mem_wdata[4]\, 
        \AHB_slave_dummy_0_mem_wdata[5]\, 
        \AHB_slave_dummy_0_mem_wdata[6]\, 
        \AHB_slave_dummy_0_mem_wdata[7]\, 
        \AHB_slave_dummy_0_mem_wdata[8]\, 
        \AHB_slave_dummy_0_mem_wdata[9]\, 
        \AHB_slave_dummy_0_mem_wdata[10]\, 
        \AHB_slave_dummy_0_mem_wdata[11]\, 
        \AHB_slave_dummy_0_mem_wdata[12]\, 
        \AHB_slave_dummy_0_mem_wdata[13]\, 
        \AHB_slave_dummy_0_mem_wdata[14]\, 
        \AHB_slave_dummy_0_mem_wdata[15]\, 
        \AHB_slave_dummy_0_mem_wdata[16]\, 
        \AHB_slave_dummy_0_mem_wdata[17]\, 
        \AHB_slave_dummy_0_mem_wdata[18]\, 
        \AHB_slave_dummy_0_mem_wdata[19]\, 
        \AHB_slave_dummy_0_mem_wdata[20]\, 
        \AHB_slave_dummy_0_mem_wdata[21]\, 
        \AHB_slave_dummy_0_mem_wdata[22]\, 
        \AHB_slave_dummy_0_mem_wdata[23]\, 
        \AHB_slave_dummy_0_mem_wdata[24]\, 
        \AHB_slave_dummy_0_mem_wdata[25]\, 
        \AHB_slave_dummy_0_mem_wdata[26]\, 
        \AHB_slave_dummy_0_mem_wdata[27]\, 
        \AHB_slave_dummy_0_mem_wdata[28]\, 
        \AHB_slave_dummy_0_mem_wdata[29]\, 
        \AHB_slave_dummy_0_mem_wdata[30]\, 
        \AHB_slave_dummy_0_mem_wdata[31]\, 
        \reg_2x32_0_data_out[0]\, \reg_2x32_0_data_out[1]\, 
        \reg_2x32_0_data_out[2]\, \reg_2x32_0_data_out[3]\, 
        \reg_2x32_0_data_out[4]\, \reg_2x32_0_data_out[5]\, 
        \reg_2x32_0_data_out[6]\, \reg_2x32_0_data_out[7]\, 
        \reg_2x32_0_data_out[8]\, \reg_2x32_0_data_out[9]\, 
        \reg_2x32_0_data_out[10]\, \reg_2x32_0_data_out[11]\, 
        \reg_2x32_0_data_out[12]\, \reg_2x32_0_data_out[13]\, 
        \reg_2x32_0_data_out[14]\, \reg_2x32_0_data_out[15]\, 
        \reg_2x32_0_data_out[16]\, \reg_2x32_0_data_out[17]\, 
        \reg_2x32_0_data_out[18]\, \reg_2x32_0_data_out[19]\, 
        \reg_2x32_0_data_out[20]\, \reg_2x32_0_data_out[21]\, 
        \reg_2x32_0_data_out[22]\, \reg_2x32_0_data_out[23]\, 
        \reg_2x32_0_data_out[24]\, \reg_2x32_0_data_out[25]\, 
        \reg_2x32_0_data_out[26]\, \reg_2x32_0_data_out[27]\, 
        \reg_2x32_0_data_out[28]\, \reg_2x32_0_data_out[29]\, 
        \reg_2x32_0_data_out[30]\, \reg_2x32_0_data_out[31]\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, 
        \lsram_waddr_net_0[0]\, \lsram_raddr_net_0[0]\, 
        AHB_slave_dummy_0_write_en, AHB_slave_dummy_0_read_en, 
        GND_net_1, VCC_net_1, 
        \sha256_system_sb_0.sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS[1]\, 
        \sha256_system_sb_0.sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.xhdl1222[1]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[1]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[2]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[3]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.masterRegAddrSel\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.regHTRANS\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.default_slave_sm.defSlaveSMCurrentState\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.arbRegSMCurrentState[15]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.arbRegSMCurrentState[12]\, 
        \sha256_system_sb_0.N_27_i\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE, 
        \sha256_system_sb_0_AMBA_SLAVE_0_HADDR[2]\, 
        \sha256_system_sb_0.N_113\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.hsel2\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.N_156\, 
        \sha256_system_sb_0.AMBA_SLAVE_0_HREADY_S1_i_m\, 
        \sha256_system_sb_0.N_128\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.SADDRSEL_2[9]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.SADDRSEL_0[1]\, 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.hsel2_1\, 
        \AHB_slave_dummy_0.lsram_m7_a0_1_0\, 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0 : std_logic;

    for all : reg_2x32
	Use entity work.reg_2x32(DEF_ARCH);
    for all : AHB_slave_dummy
	Use entity work.AHB_slave_dummy(DEF_ARCH);
    for all : sha256_system_sb
	Use entity work.sha256_system_sb(DEF_ARCH);
begin 


    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    reg_2x32_0 : reg_2x32
      port map(AHB_slave_dummy_0_mem_wdata(31) => 
        \AHB_slave_dummy_0_mem_wdata[31]\, 
        AHB_slave_dummy_0_mem_wdata(30) => 
        \AHB_slave_dummy_0_mem_wdata[30]\, 
        AHB_slave_dummy_0_mem_wdata(29) => 
        \AHB_slave_dummy_0_mem_wdata[29]\, 
        AHB_slave_dummy_0_mem_wdata(28) => 
        \AHB_slave_dummy_0_mem_wdata[28]\, 
        AHB_slave_dummy_0_mem_wdata(27) => 
        \AHB_slave_dummy_0_mem_wdata[27]\, 
        AHB_slave_dummy_0_mem_wdata(26) => 
        \AHB_slave_dummy_0_mem_wdata[26]\, 
        AHB_slave_dummy_0_mem_wdata(25) => 
        \AHB_slave_dummy_0_mem_wdata[25]\, 
        AHB_slave_dummy_0_mem_wdata(24) => 
        \AHB_slave_dummy_0_mem_wdata[24]\, 
        AHB_slave_dummy_0_mem_wdata(23) => 
        \AHB_slave_dummy_0_mem_wdata[23]\, 
        AHB_slave_dummy_0_mem_wdata(22) => 
        \AHB_slave_dummy_0_mem_wdata[22]\, 
        AHB_slave_dummy_0_mem_wdata(21) => 
        \AHB_slave_dummy_0_mem_wdata[21]\, 
        AHB_slave_dummy_0_mem_wdata(20) => 
        \AHB_slave_dummy_0_mem_wdata[20]\, 
        AHB_slave_dummy_0_mem_wdata(19) => 
        \AHB_slave_dummy_0_mem_wdata[19]\, 
        AHB_slave_dummy_0_mem_wdata(18) => 
        \AHB_slave_dummy_0_mem_wdata[18]\, 
        AHB_slave_dummy_0_mem_wdata(17) => 
        \AHB_slave_dummy_0_mem_wdata[17]\, 
        AHB_slave_dummy_0_mem_wdata(16) => 
        \AHB_slave_dummy_0_mem_wdata[16]\, 
        AHB_slave_dummy_0_mem_wdata(15) => 
        \AHB_slave_dummy_0_mem_wdata[15]\, 
        AHB_slave_dummy_0_mem_wdata(14) => 
        \AHB_slave_dummy_0_mem_wdata[14]\, 
        AHB_slave_dummy_0_mem_wdata(13) => 
        \AHB_slave_dummy_0_mem_wdata[13]\, 
        AHB_slave_dummy_0_mem_wdata(12) => 
        \AHB_slave_dummy_0_mem_wdata[12]\, 
        AHB_slave_dummy_0_mem_wdata(11) => 
        \AHB_slave_dummy_0_mem_wdata[11]\, 
        AHB_slave_dummy_0_mem_wdata(10) => 
        \AHB_slave_dummy_0_mem_wdata[10]\, 
        AHB_slave_dummy_0_mem_wdata(9) => 
        \AHB_slave_dummy_0_mem_wdata[9]\, 
        AHB_slave_dummy_0_mem_wdata(8) => 
        \AHB_slave_dummy_0_mem_wdata[8]\, 
        AHB_slave_dummy_0_mem_wdata(7) => 
        \AHB_slave_dummy_0_mem_wdata[7]\, 
        AHB_slave_dummy_0_mem_wdata(6) => 
        \AHB_slave_dummy_0_mem_wdata[6]\, 
        AHB_slave_dummy_0_mem_wdata(5) => 
        \AHB_slave_dummy_0_mem_wdata[5]\, 
        AHB_slave_dummy_0_mem_wdata(4) => 
        \AHB_slave_dummy_0_mem_wdata[4]\, 
        AHB_slave_dummy_0_mem_wdata(3) => 
        \AHB_slave_dummy_0_mem_wdata[3]\, 
        AHB_slave_dummy_0_mem_wdata(2) => 
        \AHB_slave_dummy_0_mem_wdata[2]\, 
        AHB_slave_dummy_0_mem_wdata(1) => 
        \AHB_slave_dummy_0_mem_wdata[1]\, 
        AHB_slave_dummy_0_mem_wdata(0) => 
        \AHB_slave_dummy_0_mem_wdata[0]\, reg_2x32_0_data_out(31)
         => \reg_2x32_0_data_out[31]\, reg_2x32_0_data_out(30)
         => \reg_2x32_0_data_out[30]\, reg_2x32_0_data_out(29)
         => \reg_2x32_0_data_out[29]\, reg_2x32_0_data_out(28)
         => \reg_2x32_0_data_out[28]\, reg_2x32_0_data_out(27)
         => \reg_2x32_0_data_out[27]\, reg_2x32_0_data_out(26)
         => \reg_2x32_0_data_out[26]\, reg_2x32_0_data_out(25)
         => \reg_2x32_0_data_out[25]\, reg_2x32_0_data_out(24)
         => \reg_2x32_0_data_out[24]\, reg_2x32_0_data_out(23)
         => \reg_2x32_0_data_out[23]\, reg_2x32_0_data_out(22)
         => \reg_2x32_0_data_out[22]\, reg_2x32_0_data_out(21)
         => \reg_2x32_0_data_out[21]\, reg_2x32_0_data_out(20)
         => \reg_2x32_0_data_out[20]\, reg_2x32_0_data_out(19)
         => \reg_2x32_0_data_out[19]\, reg_2x32_0_data_out(18)
         => \reg_2x32_0_data_out[18]\, reg_2x32_0_data_out(17)
         => \reg_2x32_0_data_out[17]\, reg_2x32_0_data_out(16)
         => \reg_2x32_0_data_out[16]\, reg_2x32_0_data_out(15)
         => \reg_2x32_0_data_out[15]\, reg_2x32_0_data_out(14)
         => \reg_2x32_0_data_out[14]\, reg_2x32_0_data_out(13)
         => \reg_2x32_0_data_out[13]\, reg_2x32_0_data_out(12)
         => \reg_2x32_0_data_out[12]\, reg_2x32_0_data_out(11)
         => \reg_2x32_0_data_out[11]\, reg_2x32_0_data_out(10)
         => \reg_2x32_0_data_out[10]\, reg_2x32_0_data_out(9) => 
        \reg_2x32_0_data_out[9]\, reg_2x32_0_data_out(8) => 
        \reg_2x32_0_data_out[8]\, reg_2x32_0_data_out(7) => 
        \reg_2x32_0_data_out[7]\, reg_2x32_0_data_out(6) => 
        \reg_2x32_0_data_out[6]\, reg_2x32_0_data_out(5) => 
        \reg_2x32_0_data_out[5]\, reg_2x32_0_data_out(4) => 
        \reg_2x32_0_data_out[4]\, reg_2x32_0_data_out(3) => 
        \reg_2x32_0_data_out[3]\, reg_2x32_0_data_out(2) => 
        \reg_2x32_0_data_out[2]\, reg_2x32_0_data_out(1) => 
        \reg_2x32_0_data_out[1]\, reg_2x32_0_data_out(0) => 
        \reg_2x32_0_data_out[0]\, lsram_raddr_net_0(0) => 
        \lsram_raddr_net_0[0]\, lsram_waddr_net_0(0) => 
        \lsram_waddr_net_0[0]\, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0 => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, 
        sha256_system_sb_0_POWER_ON_RESET_N => 
        sha256_system_sb_0_POWER_ON_RESET_N, 
        AHB_slave_dummy_0_write_en => AHB_slave_dummy_0_write_en, 
        AHB_slave_dummy_0_read_en => AHB_slave_dummy_0_read_en);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    AHB_slave_dummy_0 : AHB_slave_dummy
      port map(lsram_waddr_net_0(0) => \lsram_waddr_net_0[0]\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2) => 
        \sha256_system_sb_0_AMBA_SLAVE_0_HADDR[2]\, 
        lsram_raddr_net_0(0) => \lsram_raddr_net_0[0]\, 
        masterAddrInProg(3) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[3]\, 
        masterAddrInProg(2) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[2]\, 
        masterAddrInProg(1) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[1]\, 
        xhdl1222(1) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.xhdl1222[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) => 
        \sha256_system_sb_0.sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        \sha256_system_sb_0.sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS[1]\, 
        SADDRSEL_2(9) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.SADDRSEL_2[9]\, 
        SADDRSEL_0(1) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.SADDRSEL_0[1]\, 
        arbRegSMCurrentState_3 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.arbRegSMCurrentState[15]\, 
        arbRegSMCurrentState_0 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.arbRegSMCurrentState[12]\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, 
        sha256_system_sb_0_POWER_ON_RESET_N => 
        sha256_system_sb_0_POWER_ON_RESET_N, 
        sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, AHB_slave_dummy_0_write_en
         => AHB_slave_dummy_0_write_en, AHB_slave_dummy_0_read_en
         => AHB_slave_dummy_0_read_en, 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE => 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE, N_156 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.N_156\, 
        lsram_m7_a0_1_0 => \AHB_slave_dummy_0.lsram_m7_a0_1_0\, 
        N_27_i => \sha256_system_sb_0.N_27_i\, 
        AMBA_SLAVE_0_HREADY_S1_i_m => 
        \sha256_system_sb_0.AMBA_SLAVE_0_HREADY_S1_i_m\, 
        defSlaveSMCurrentState => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.default_slave_sm.defSlaveSMCurrentState\, 
        N_128 => \sha256_system_sb_0.N_128\, hsel2_1 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.hsel2_1\, 
        regHTRANS => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.regHTRANS\, 
        masterRegAddrSel => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.masterRegAddrSel\, 
        N_113 => \sha256_system_sb_0.N_113\, hsel2 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.hsel2\);
    
    sha256_system_sb_0 : sha256_system_sb
      port map(xhdl1222(1) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.xhdl1222[1]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS(1) => 
        \sha256_system_sb_0.sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HTRANS[1]\, 
        SADDRSEL_0(1) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.SADDRSEL_0[1]\, 
        SADDRSEL_2(9) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.SADDRSEL_2[9]\, 
        reg_2x32_0_data_out(31) => \reg_2x32_0_data_out[31]\, 
        reg_2x32_0_data_out(30) => \reg_2x32_0_data_out[30]\, 
        reg_2x32_0_data_out(29) => \reg_2x32_0_data_out[29]\, 
        reg_2x32_0_data_out(28) => \reg_2x32_0_data_out[28]\, 
        reg_2x32_0_data_out(27) => \reg_2x32_0_data_out[27]\, 
        reg_2x32_0_data_out(26) => \reg_2x32_0_data_out[26]\, 
        reg_2x32_0_data_out(25) => \reg_2x32_0_data_out[25]\, 
        reg_2x32_0_data_out(24) => \reg_2x32_0_data_out[24]\, 
        reg_2x32_0_data_out(23) => \reg_2x32_0_data_out[23]\, 
        reg_2x32_0_data_out(22) => \reg_2x32_0_data_out[22]\, 
        reg_2x32_0_data_out(21) => \reg_2x32_0_data_out[21]\, 
        reg_2x32_0_data_out(20) => \reg_2x32_0_data_out[20]\, 
        reg_2x32_0_data_out(19) => \reg_2x32_0_data_out[19]\, 
        reg_2x32_0_data_out(18) => \reg_2x32_0_data_out[18]\, 
        reg_2x32_0_data_out(17) => \reg_2x32_0_data_out[17]\, 
        reg_2x32_0_data_out(16) => \reg_2x32_0_data_out[16]\, 
        reg_2x32_0_data_out(15) => \reg_2x32_0_data_out[15]\, 
        reg_2x32_0_data_out(14) => \reg_2x32_0_data_out[14]\, 
        reg_2x32_0_data_out(13) => \reg_2x32_0_data_out[13]\, 
        reg_2x32_0_data_out(12) => \reg_2x32_0_data_out[12]\, 
        reg_2x32_0_data_out(11) => \reg_2x32_0_data_out[11]\, 
        reg_2x32_0_data_out(10) => \reg_2x32_0_data_out[10]\, 
        reg_2x32_0_data_out(9) => \reg_2x32_0_data_out[9]\, 
        reg_2x32_0_data_out(8) => \reg_2x32_0_data_out[8]\, 
        reg_2x32_0_data_out(7) => \reg_2x32_0_data_out[7]\, 
        reg_2x32_0_data_out(6) => \reg_2x32_0_data_out[6]\, 
        reg_2x32_0_data_out(5) => \reg_2x32_0_data_out[5]\, 
        reg_2x32_0_data_out(4) => \reg_2x32_0_data_out[4]\, 
        reg_2x32_0_data_out(3) => \reg_2x32_0_data_out[3]\, 
        reg_2x32_0_data_out(2) => \reg_2x32_0_data_out[2]\, 
        reg_2x32_0_data_out(1) => \reg_2x32_0_data_out[1]\, 
        reg_2x32_0_data_out(0) => \reg_2x32_0_data_out[0]\, 
        sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP(0) => 
        \sha256_system_sb_0.sha256_system_sb_MSS_TMP_0_FIC_0_AHB_MASTER_HRESP[0]\, 
        masterAddrInProg(3) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[3]\, 
        masterAddrInProg(2) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[2]\, 
        masterAddrInProg(1) => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.masterAddrInProg[1]\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HADDR(2) => 
        \sha256_system_sb_0_AMBA_SLAVE_0_HADDR[2]\, 
        AHB_slave_dummy_0_mem_wdata(31) => 
        \AHB_slave_dummy_0_mem_wdata[31]\, 
        AHB_slave_dummy_0_mem_wdata(30) => 
        \AHB_slave_dummy_0_mem_wdata[30]\, 
        AHB_slave_dummy_0_mem_wdata(29) => 
        \AHB_slave_dummy_0_mem_wdata[29]\, 
        AHB_slave_dummy_0_mem_wdata(28) => 
        \AHB_slave_dummy_0_mem_wdata[28]\, 
        AHB_slave_dummy_0_mem_wdata(27) => 
        \AHB_slave_dummy_0_mem_wdata[27]\, 
        AHB_slave_dummy_0_mem_wdata(26) => 
        \AHB_slave_dummy_0_mem_wdata[26]\, 
        AHB_slave_dummy_0_mem_wdata(25) => 
        \AHB_slave_dummy_0_mem_wdata[25]\, 
        AHB_slave_dummy_0_mem_wdata(24) => 
        \AHB_slave_dummy_0_mem_wdata[24]\, 
        AHB_slave_dummy_0_mem_wdata(23) => 
        \AHB_slave_dummy_0_mem_wdata[23]\, 
        AHB_slave_dummy_0_mem_wdata(22) => 
        \AHB_slave_dummy_0_mem_wdata[22]\, 
        AHB_slave_dummy_0_mem_wdata(21) => 
        \AHB_slave_dummy_0_mem_wdata[21]\, 
        AHB_slave_dummy_0_mem_wdata(20) => 
        \AHB_slave_dummy_0_mem_wdata[20]\, 
        AHB_slave_dummy_0_mem_wdata(19) => 
        \AHB_slave_dummy_0_mem_wdata[19]\, 
        AHB_slave_dummy_0_mem_wdata(18) => 
        \AHB_slave_dummy_0_mem_wdata[18]\, 
        AHB_slave_dummy_0_mem_wdata(17) => 
        \AHB_slave_dummy_0_mem_wdata[17]\, 
        AHB_slave_dummy_0_mem_wdata(16) => 
        \AHB_slave_dummy_0_mem_wdata[16]\, 
        AHB_slave_dummy_0_mem_wdata(15) => 
        \AHB_slave_dummy_0_mem_wdata[15]\, 
        AHB_slave_dummy_0_mem_wdata(14) => 
        \AHB_slave_dummy_0_mem_wdata[14]\, 
        AHB_slave_dummy_0_mem_wdata(13) => 
        \AHB_slave_dummy_0_mem_wdata[13]\, 
        AHB_slave_dummy_0_mem_wdata(12) => 
        \AHB_slave_dummy_0_mem_wdata[12]\, 
        AHB_slave_dummy_0_mem_wdata(11) => 
        \AHB_slave_dummy_0_mem_wdata[11]\, 
        AHB_slave_dummy_0_mem_wdata(10) => 
        \AHB_slave_dummy_0_mem_wdata[10]\, 
        AHB_slave_dummy_0_mem_wdata(9) => 
        \AHB_slave_dummy_0_mem_wdata[9]\, 
        AHB_slave_dummy_0_mem_wdata(8) => 
        \AHB_slave_dummy_0_mem_wdata[8]\, 
        AHB_slave_dummy_0_mem_wdata(7) => 
        \AHB_slave_dummy_0_mem_wdata[7]\, 
        AHB_slave_dummy_0_mem_wdata(6) => 
        \AHB_slave_dummy_0_mem_wdata[6]\, 
        AHB_slave_dummy_0_mem_wdata(5) => 
        \AHB_slave_dummy_0_mem_wdata[5]\, 
        AHB_slave_dummy_0_mem_wdata(4) => 
        \AHB_slave_dummy_0_mem_wdata[4]\, 
        AHB_slave_dummy_0_mem_wdata(3) => 
        \AHB_slave_dummy_0_mem_wdata[3]\, 
        AHB_slave_dummy_0_mem_wdata(2) => 
        \AHB_slave_dummy_0_mem_wdata[2]\, 
        AHB_slave_dummy_0_mem_wdata(1) => 
        \AHB_slave_dummy_0_mem_wdata[1]\, 
        AHB_slave_dummy_0_mem_wdata(0) => 
        \AHB_slave_dummy_0_mem_wdata[0]\, arbRegSMCurrentState_3
         => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.arbRegSMCurrentState[15]\, 
        arbRegSMCurrentState_0 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.arbRegSMCurrentState[12]\, 
        sha256_system_sb_0_POWER_ON_RESET_N => 
        sha256_system_sb_0_POWER_ON_RESET_N, 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0 => 
        sha256_system_sb_0_POWER_ON_RESET_N_i_0, DEVRST_N => 
        DEVRST_N, sha256_system_sb_0_FIC_0_CLK => 
        sha256_system_sb_0_FIC_0_CLK, regHTRANS => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.regHTRANS\, 
        masterRegAddrSel => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.masterRegAddrSel\, 
        N_113 => \sha256_system_sb_0.N_113\, N_27_i => 
        \sha256_system_sb_0.N_27_i\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY => 
        sha256_system_sb_0_AMBA_SLAVE_0_HREADY, N_156 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.slave_arbiter.N_156\, 
        N_128 => \sha256_system_sb_0.N_128\, 
        AMBA_SLAVE_0_HREADY_S1_i_m => 
        \sha256_system_sb_0.AMBA_SLAVE_0_HREADY_S1_i_m\, 
        defSlaveSMCurrentState => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.masterstage_0.default_slave_sm.defSlaveSMCurrentState\, 
        hsel2 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.hsel2\, 
        hsel2_1 => 
        \sha256_system_sb_0.CoreAHBLite_0.matrix4x16.slavestage_1.hsel2_1\, 
        lsram_m7_a0_1_0 => \AHB_slave_dummy_0.lsram_m7_a0_1_0\, 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE => 
        sha256_system_sb_0_AMBA_SLAVE_0_HWRITE, GPIO_0_OUT => 
        GPIO_0_OUT);
    

end DEF_ARCH; 
