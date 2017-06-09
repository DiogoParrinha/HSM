-- ********************************************************************/
-- Actel Corporation Proprietary and Confidential
--  Copyright 2011 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:  SRAM block, 4 byte wide, 64 to 2304 deep (in steps
--               of 64 for Word accesses), 64 to 4608 deep (in steps
--               of 64 for Half-Word accesses) and 64 to 4608 deep (in 
--               steps of 128 for Byte accesses) used to construct 
--               the memory.
--
-- Revision Information:
-- Date     Description
--
-- SVN Revision Information:
-- SVN $Revision: 4805 $
-- SVN $Date: 2008-11-27 17:48:48 +0530 (Thu, 27 Nov 2008) $
--
-- Resolved SARs
-- SAR      Date     Who   Description
--
-- Notes:
--
-- ********************************************************************/
library ieee;
library smartfusion2;
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;

ENTITY CertificationSystem_sb_COREAHBLSRAM_0_0_usram_128to9216x8 IS
   GENERIC (
      -- ---------------------------------------------------------------------
      -- Parameters
      -- ---------------------------------------------------------------------
      -- DEPTH can range from
      -- 128 to 9216bytes  , in steps of 128bytes
      DEPTH   :  integer := 128;
	  SYNC_RESET                     :  integer := 0);    
   PORT (
      -- ---------------------------------------------------------------------
-- Port declarations
-- ---------------------------------------------------------------------
-- AhbFabric interface
-- Inputs

      writeData               : IN std_logic_vector(7 DOWNTO 0);   
      -- Output

      readData                : OUT std_logic_vector(7 DOWNTO 0);   
-- Inputs

      wen                     : IN std_logic;   
      ren                     : IN std_logic;   
      writeAddr               : IN std_logic_vector(15 DOWNTO 0);   
      readAddr                : IN std_logic_vector(15 DOWNTO 0);   
      clk                     : IN std_logic;   
      resetn                  : IN std_logic;   
      u_BUSY_all              : OUT std_logic);   
END ENTITY CertificationSystem_sb_COREAHBLSRAM_0_0_usram_128to9216x8;

ARCHITECTURE translated OF CertificationSystem_sb_COREAHBLSRAM_0_0_usram_128to9216x8 IS

   COMPONENT RAM64x18 
      PORT (
         A_DOUT               : OUT std_logic_vector(17 DOWNTO 0); 
         B_DOUT               : OUT std_logic_vector(17 DOWNTO 0); 
         A_ADDR_CLK                : IN std_logic;
         B_ADDR_CLK                : IN std_logic; 
         A_ADDR_EN              : IN std_logic;
         B_ADDR_EN              : IN std_logic;
         A_ADDR_LAT              : IN std_logic;
         B_ADDR_LAT              : IN std_logic;
         A_ADDR_ARST_N                : IN std_logic; 
         B_ADDR_ARST_N                 : IN std_logic;
         A_ADDR_SRST_N                : IN std_logic; 
         B_ADDR_SRST_N                 : IN std_logic;
         A_DOUT_CLK                : IN std_logic;
         B_DOUT_CLK                : IN std_logic;
         A_DOUT_EN                : IN std_logic;
         B_DOUT_EN                : IN std_logic;
         A_DOUT_LAT                : IN std_logic;
         B_DOUT_LAT                : IN std_logic;
        A_DOUT_ARST_N                : IN std_logic;
         B_DOUT_ARST_N                : IN std_logic;
         A_DOUT_SRST_N                : IN std_logic;
         B_DOUT_SRST_N                : IN std_logic;
         A_ADDR              : IN std_logic_vector(9 DOWNTO 0);
         B_ADDR              : IN std_logic_vector(9 DOWNTO 0);
         A_WIDTH              : IN std_logic_vector(2 DOWNTO 0);
         B_WIDTH              : IN std_logic_vector(2 DOWNTO 0);
         A_BLK              : IN std_logic_vector(1 DOWNTO 0);
         B_BLK              : IN std_logic_vector(1 DOWNTO 0);
         A_EN                : IN std_logic;
         B_EN                : IN std_logic;
         C_CLK                : IN std_logic; 
         C_BLK              : IN std_logic_vector(1 DOWNTO 0);
         C_DIN              : IN std_logic_vector(17 DOWNTO 0);
        C_EN                : IN std_logic;
        C_ADDR              : IN std_logic_vector(9 DOWNTO 0);
         C_WEN              : IN std_logic;
         C_WIDTH              : IN std_logic_vector(2 DOWNTO 0);    
        BUSY                : OUT std_logic;
         SII_LOCK                : IN std_logic);
  END COMPONENT;   

   -- ---------------------------------------------------------------------
   -- Constant declarations
   -- ---------------------------------------------------------------------
   --CONSTANT  AHB_DWIDTH       :  integer := 8;  

   -- ---------------------------------------------------------------------
   -- Signal declarations
   -- ---------------------------------------------------------------------
   SIGNAL ckRdAddr                 :  std_logic_vector(13 DOWNTO 6);
   SIGNAL wen_a0                   :  std_logic;   
   SIGNAL wen_a1                   :  std_logic;   
   SIGNAL wen_a2                   :  std_logic;   
   SIGNAL wen_a3                   :  std_logic;   
   SIGNAL wen_a4                   :  std_logic;   
   SIGNAL wen_a5                   :  std_logic;   
   SIGNAL wen_a6                   :  std_logic;   
   SIGNAL wen_a7                   :  std_logic;   
   SIGNAL wen_a8                   :  std_logic;   
   SIGNAL wen_a9                   :  std_logic;   
   SIGNAL wen_a10                   :  std_logic;   
   SIGNAL wen_a11                   :  std_logic;   
   SIGNAL wen_a12                   :  std_logic;   
   SIGNAL wen_a13                   :  std_logic;   
   SIGNAL wen_a14                   :  std_logic;   
   SIGNAL wen_a15                   :  std_logic;   
   SIGNAL wen_a16                   :  std_logic;      
   SIGNAL wen_a17                   :  std_logic; 
   
   SIGNAL sram_writeData               :  std_logic_vector(17 DOWNTO 0);   

   SIGNAL readData0                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData1                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData2                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData3                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData4                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData5                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData6                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData7                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData8                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData9                :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData10               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData11               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData12               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData13               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData14               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData15               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL readData16               :  std_logic_vector(17 DOWNTO 0);     
   SIGNAL readData17               :  std_logic_vector(17 DOWNTO 0);   
  
   SIGNAL ablk                     :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL bblk                     :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL cblk                     :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL u_BUSY_16                :  std_logic;      SIGNAL u_BUSY_17                :  std_logic;   
   SIGNAL u_BUSY_15                :  std_logic;   
   SIGNAL u_BUSY_14                :  std_logic;   
   SIGNAL u_BUSY_13                :  std_logic;   
   SIGNAL u_BUSY_12                :  std_logic;   
   SIGNAL u_BUSY_11                :  std_logic;   
   SIGNAL u_BUSY_10                :  std_logic;   
   SIGNAL u_BUSY_9                 :  std_logic;   
   SIGNAL u_BUSY_8                 :  std_logic;   
   SIGNAL u_BUSY_7                 :  std_logic;   
   SIGNAL u_BUSY_6                 :  std_logic;   
   SIGNAL u_BUSY_5                 :  std_logic;   
   SIGNAL u_BUSY_4                 :  std_logic;   
   SIGNAL u_BUSY_3                 :  std_logic;   
   SIGNAL u_BUSY_2                 :  std_logic;   
   SIGNAL u_BUSY_1                 :  std_logic;   
   SIGNAL u_BUSY_0                 :  std_logic;   
   SIGNAL readData_xhdl1           :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL u_9K_BUSY_all_xhdl2      :  std_logic;   
   SIGNAL aresetn                  :  std_logic;
   SIGNAL sresetn                  :  std_logic;
   SIGNAL sram_readAddr            :  std_logic_vector (9 DOWNTO 0);
   SIGNAL sram_writeAddr           :  std_logic_vector (9 DOWNTO 0);
BEGIN
   sram_writeAddr <= writeAddr(6 DOWNTO 0) & "000";
   sram_readAddr <= readAddr(6 DOWNTO 0) & "000";
   readData     <= readData_xhdl1;
   u_BUSY_all    <= u_9K_BUSY_all_xhdl2;
   aresetn <= '1' WHEN (SYNC_RESET=1) ELSE resetn;
   sresetn <= resetn WHEN (SYNC_RESET=1) ELSE '1';
   sram_writeData <= "0000000000" & writeData(7 DOWNTO 0);

   ------------------------------------------------------------------------
   -- Main body of code
   ------------------------------------------------------------------------
   
   PROCESS (clk, aresetn)
   BEGIN
      IF (NOT aresetn = '1') THEN
         ckRdAddr(13 DOWNTO 6) <= "00000000";    
      ELSIF (clk'EVENT AND clk = '1') THEN
         IF (NOT sresetn = '1') THEN
            ckRdAddr(13 DOWNTO 6) <= "00000000"; 
	     ELSE
            ckRdAddr(13 DOWNTO 6) <= readAddr(13 DOWNTO 6);    
         END IF;  
      END IF;
   END PROCESS;

   ------------------------------------------------------------------------------------------
   -- Assign values to various signals based on DEPTH and RAM64x16_WIDTH settings.
   -- WHEN OTHERS is to build the (byte wide) memory from RAM blocks which are configured to
   -- be tall and narrow.
   ------------------------------------------------------------------------------------------
   
   PROCESS (writeData, wen_a0, wen_a1, wen_a2, wen_a3, wen_a4, ren, 
   wen_a5, ckRdAddr, readAddr, readData10, 
   readData11, readData12, readData13, readData14, readData15, wen, 
   readData16, readData17, readData0, readData1, 
   readData2, readData3, readData4, readData5, readData6, readData7, readData8, 
   readData9, writeAddr)
      VARIABLE ablk_xhdl435  : std_logic_vector(1 DOWNTO 0); 
      VARIABLE bblk_xhdl436  : std_logic_vector(1 DOWNTO 0);
      VARIABLE cblk_xhdl436  : std_logic_vector(1 DOWNTO 0);
      VARIABLE readData_xhdl1_xhdl437_w8  : std_logic_vector(7
      DOWNTO 0);
      
      VARIABLE wen_a0_xhdl75  : std_logic;
      VARIABLE wen_a1_xhdl76  : std_logic;
      VARIABLE wen_a2_xhdl77  : std_logic;
      VARIABLE wen_a3_xhdl78  : std_logic;
      VARIABLE wen_a4_xhdl79  : std_logic;
      VARIABLE wen_a5_xhdl80  : std_logic;
      VARIABLE wen_a6_xhdl81  : std_logic;
      VARIABLE wen_a7_xhdl82  : std_logic;
      VARIABLE wen_a8_xhdl83  : std_logic;
      VARIABLE wen_a9_xhdl84  : std_logic;
      VARIABLE wen_a10_xhdl85  : std_logic;
      VARIABLE wen_a11_xhdl86  : std_logic;
      VARIABLE wen_a12_xhdl87  : std_logic;
      VARIABLE wen_a13_xhdl88  : std_logic;
      VARIABLE wen_a14_xhdl89  : std_logic;
      VARIABLE wen_a15_xhdl90  : std_logic;
      VARIABLE wen_a16_xhdl91  : std_logic;      
	  VARIABLE wen_a17_xhdl92  : std_logic;
	  
      VARIABLE xhdl438  : std_logic_vector(5 DOWNTO 0);
      VARIABLE xhdl439  : std_logic_vector(2 DOWNTO 0);
   BEGIN

      wen_a0_xhdl75 := '0';    
      wen_a1_xhdl76 := '0';    
      wen_a2_xhdl77 := '0';    
      wen_a3_xhdl78 := '0';    
      wen_a4_xhdl79 := '0';    
      wen_a5_xhdl80 := '0';    
      wen_a6_xhdl81 := '0';    
      wen_a7_xhdl82 := '0';    
      wen_a8_xhdl83 := '0';    
      wen_a9_xhdl84 := '0';    
      wen_a10_xhdl85 := '0';    
      wen_a11_xhdl86 := '0';    
      wen_a12_xhdl87 := '0';    
      wen_a13_xhdl88 := '0';    
      wen_a14_xhdl89 := '0';    
      wen_a15_xhdl90 := '0';    
      wen_a16_xhdl91 := '0';          
	  wen_a17_xhdl92 := '0';    

      --ablk_xhdl435 := "11";    
      --bblk_xhdl436 := "11";   
      ablk_xhdl435 := ren & ren;    
      bblk_xhdl436 := ren & ren;   
      cblk_xhdl436 := wen & wen;   
				  
        CASE DEPTH IS
            WHEN 32 | 64 | 96 | 128 =>
                  wen_a0_xhdl75 := wen;
                  readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
            WHEN 160 | 192 | 224 | 256 =>
                CASE writeAddr(7) IS
				    WHEN '0' => wen_a0_xhdl75 := wen;
				    WHEN '1' => wen_a1_xhdl76 := wen;
				    WHEN OTHERS => 
					            wen_a1_xhdl76 := '0';
								wen_a0_xhdl75 := '0';
				END CASE;
				
                CASE ckRdAddr(7) IS
				  WHEN '0' => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				  WHEN '1' => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
				
            WHEN 288 | 320 | 352 | 384 =>
                CASE writeAddr(8 DOWNTO 7) IS
				    WHEN "00" => wen_a0_xhdl75 := wen;
				    WHEN "01" => wen_a1_xhdl76 := wen;
				    WHEN "10" => wen_a2_xhdl77 := wen;
                    WHEN OTHERS =>
                              wen_a2_xhdl77 := '0';
                              wen_a1_xhdl76 := '0';
                              wen_a0_xhdl75 := '0';
				END CASE;
				
                CASE ckRdAddr(8 DOWNTO 7) IS
				    WHEN "00" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "01" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "10" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
				
            WHEN 416 | 448 | 480 | 512 => 

                CASE writeAddr(8 DOWNTO 7) IS
				    WHEN "00" => wen_a0_xhdl75 := wen;
				    WHEN "01" => wen_a1_xhdl76 := wen;
				    WHEN "10" => wen_a2_xhdl77 := wen;
                    WHEN "11" => wen_a3_xhdl78 := wen;
				    WHEN OTHERS => 
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
				END CASE;
				
                CASE ckRdAddr(8 DOWNTO 7) IS
				    WHEN "00" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "01" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "10" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "11" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;

            WHEN 544 | 576 | 608 | 640 =>
				
                CASE writeAddr(9 DOWNTO 7) IS
				    WHEN "000" => wen_a0_xhdl75 := wen;
				    WHEN "001" => wen_a1_xhdl76 := wen;
				    WHEN "010" => wen_a2_xhdl77 := wen;
                    WHEN "011" => wen_a3_xhdl78 := wen;
                    WHEN "100" => wen_a4_xhdl79 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
				END CASE;
				
                CASE ckRdAddr(9 DOWNTO 7) IS
				    WHEN "000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;

            WHEN 672 | 704 | 736 | 768 =>
                CASE writeAddr(9 DOWNTO 7) IS
				    WHEN "000" => wen_a0_xhdl75 := wen;
				    WHEN "001" => wen_a1_xhdl76 := wen;
				    WHEN "010" => wen_a2_xhdl77 := wen;
                    WHEN "011" => wen_a3_xhdl78 := wen;
                    WHEN "100" => wen_a4_xhdl79 := wen;
                    WHEN "101" => wen_a5_xhdl80 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
				END CASE;
				
                CASE ckRdAddr(9 DOWNTO 7) IS
				    WHEN "000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
				
            WHEN 800 | 832 | 864 | 896 =>
                CASE writeAddr(9 DOWNTO 7) IS
				    WHEN "000" => wen_a0_xhdl75 := wen;
				    WHEN "001" => wen_a1_xhdl76 := wen;
				    WHEN "010" => wen_a2_xhdl77 := wen;
                    WHEN "011" => wen_a3_xhdl78 := wen;
                    WHEN "100" => wen_a4_xhdl79 := wen;
                    WHEN "101" => wen_a5_xhdl80 := wen;
                    WHEN "110" => wen_a6_xhdl81 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
				END CASE;
				
                CASE ckRdAddr(9 DOWNTO 7) IS
				    WHEN "000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
             


            WHEN 928 | 960 | 992 | 1024 =>
 
                CASE writeAddr(9 DOWNTO 7) IS
				    WHEN "000" => wen_a0_xhdl75 := wen;
				    WHEN "001" => wen_a1_xhdl76 := wen;
				    WHEN "010" => wen_a2_xhdl77 := wen;
                    WHEN "011" => wen_a3_xhdl78 := wen;
                    WHEN "100" => wen_a4_xhdl79 := wen;
                    WHEN "101" => wen_a5_xhdl80 := wen;
                    WHEN "110" => wen_a6_xhdl81 := wen;
                    WHEN "111" => wen_a7_xhdl82 := wen;
				    WHEN OTHERS => 
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
								wen_a7_xhdl82 := '0';
				END CASE;
				
                CASE ckRdAddr(9 DOWNTO 7) IS
				    WHEN "000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
             

            WHEN 1056 | 1088 | 1120 | 1152 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
				
            WHEN 1184 | 1216 | 1248 | 1280 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN "1001" => wen_a9_xhdl84 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "1001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
                   
            WHEN 1312 | 1344 | 1376 | 1408 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN "1001" => wen_a9_xhdl84 := wen;
                    WHEN "1010" => wen_a10_xhdl85 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "1001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "1010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
                   
            WHEN 1440 | 1472 | 1504 | 1536 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN "1001" => wen_a9_xhdl84 := wen;
                    WHEN "1010" => wen_a10_xhdl85 := wen;
                    WHEN "1011" => wen_a11_xhdl86 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
					            wen_a11_xhdl86 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "1001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "1010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN "1011" => readData_xhdl1_xhdl437_w8 := readData11(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
                   
            WHEN 1568 | 1600 | 1632 | 1664 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN "1001" => wen_a9_xhdl84 := wen;
                    WHEN "1010" => wen_a10_xhdl85 := wen;
                    WHEN "1011" => wen_a11_xhdl86 := wen;
                    WHEN "1100" => wen_a12_xhdl87 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
					            wen_a11_xhdl86 := '0';
					            wen_a12_xhdl87 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "1001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "1010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN "1011" => readData_xhdl1_xhdl437_w8 := readData11(7 DOWNTO 0);
                    WHEN "1100" => readData_xhdl1_xhdl437_w8 := readData12(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
                   
            WHEN 1696 | 1728 | 1760 | 1792 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN "1001" => wen_a9_xhdl84 := wen;
                    WHEN "1010" => wen_a10_xhdl85 := wen;
                    WHEN "1011" => wen_a11_xhdl86 := wen;
                    WHEN "1100" => wen_a12_xhdl87 := wen;
                    WHEN "1101" => wen_a13_xhdl88 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
					            wen_a11_xhdl86 := '0';
					            wen_a12_xhdl87 := '0';
					            wen_a13_xhdl88 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "1001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "1010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN "1011" => readData_xhdl1_xhdl437_w8 := readData11(7 DOWNTO 0);
                    WHEN "1100" => readData_xhdl1_xhdl437_w8 := readData12(7 DOWNTO 0);
                    WHEN "1101" => readData_xhdl1_xhdl437_w8 := readData13(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
                   
            WHEN 1824 | 1856 | 1888 | 1920 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN "1001" => wen_a9_xhdl84 := wen;
                    WHEN "1010" => wen_a10_xhdl85 := wen;
                    WHEN "1011" => wen_a11_xhdl86 := wen;
                    WHEN "1100" => wen_a12_xhdl87 := wen;
                    WHEN "1101" => wen_a13_xhdl88 := wen;
                    WHEN "1110" => wen_a14_xhdl89 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
					            wen_a11_xhdl86 := '0';
					            wen_a12_xhdl87 := '0';
					            wen_a13_xhdl88 := '0';
					            wen_a14_xhdl89 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "1001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "1010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN "1011" => readData_xhdl1_xhdl437_w8 := readData11(7 DOWNTO 0);
                    WHEN "1100" => readData_xhdl1_xhdl437_w8 := readData12(7 DOWNTO 0);
                    WHEN "1101" => readData_xhdl1_xhdl437_w8 := readData13(7 DOWNTO 0);
                    WHEN "1110" => readData_xhdl1_xhdl437_w8 := readData14(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;

                   
            WHEN 1952 | 1984 | 2016 | 2048 =>
			
                CASE writeAddr(10 DOWNTO 7) IS
				    WHEN "0000" => wen_a0_xhdl75 := wen;
				    WHEN "0001" => wen_a1_xhdl76 := wen;
				    WHEN "0010" => wen_a2_xhdl77 := wen;
                    WHEN "0011" => wen_a3_xhdl78 := wen;
                    WHEN "0100" => wen_a4_xhdl79 := wen;
                    WHEN "0101" => wen_a5_xhdl80 := wen;
                    WHEN "0110" => wen_a6_xhdl81 := wen;
                    WHEN "0111" => wen_a7_xhdl82 := wen;
                    WHEN "1000" => wen_a8_xhdl83 := wen;
                    WHEN "1001" => wen_a9_xhdl84 := wen;
                    WHEN "1010" => wen_a10_xhdl85 := wen;
                    WHEN "1011" => wen_a11_xhdl86 := wen;
                    WHEN "1100" => wen_a12_xhdl87 := wen;
                    WHEN "1101" => wen_a13_xhdl88 := wen;
                    WHEN "1110" => wen_a14_xhdl89 := wen;
                    WHEN "1111" => wen_a15_xhdl90 := wen;
				    WHEN OTHERS => 
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
					            wen_a11_xhdl86 := '0';
					            wen_a12_xhdl87 := '0';
					            wen_a13_xhdl88 := '0';
					            wen_a14_xhdl89 := '0';
								wen_a15_xhdl90 := '0';
				END CASE;
				
                CASE ckRdAddr(10 DOWNTO 7) IS
				    WHEN "0000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "0001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "0010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "0011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "0100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "0101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "0110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "0111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "1000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "1001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "1010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN "1011" => readData_xhdl1_xhdl437_w8 := readData11(7 DOWNTO 0);
                    WHEN "1100" => readData_xhdl1_xhdl437_w8 := readData12(7 DOWNTO 0);
                    WHEN "1101" => readData_xhdl1_xhdl437_w8 := readData13(7 DOWNTO 0);
                    WHEN "1110" => readData_xhdl1_xhdl437_w8 := readData14(7 DOWNTO 0);
                    WHEN "1111" => readData_xhdl1_xhdl437_w8 := readData15(7 DOWNTO 0);
                   WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
             
 
            WHEN 2080 | 2112 | 2144 | 2176 =>
			
                CASE writeAddr(11 DOWNTO 7) IS
				    WHEN "00000" => wen_a0_xhdl75 := wen;
				    WHEN "00001" => wen_a1_xhdl76 := wen;
				    WHEN "00010" => wen_a2_xhdl77 := wen;
                    WHEN "00011" => wen_a3_xhdl78 := wen;
                    WHEN "00100" => wen_a4_xhdl79 := wen;
                    WHEN "00101" => wen_a5_xhdl80 := wen;
                    WHEN "00110" => wen_a6_xhdl81 := wen;
                    WHEN "00111" => wen_a7_xhdl82 := wen;
                    WHEN "01000" => wen_a8_xhdl83 := wen;
                    WHEN "01001" => wen_a9_xhdl84 := wen;
                    WHEN "01010" => wen_a10_xhdl85 := wen;
                    WHEN "01011" => wen_a11_xhdl86 := wen;
                    WHEN "01100" => wen_a12_xhdl87 := wen;
                    WHEN "01101" => wen_a13_xhdl88 := wen;
                    WHEN "01110" => wen_a14_xhdl89 := wen;
                    WHEN "01111" => wen_a15_xhdl90 := wen;
                    WHEN "10000" => wen_a16_xhdl91 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
					            wen_a11_xhdl86 := '0';
					            wen_a12_xhdl87 := '0';
					            wen_a13_xhdl88 := '0';
					            wen_a14_xhdl89 := '0';
					            wen_a15_xhdl90 := '0';
					            wen_a16_xhdl91 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(11 DOWNTO 7) IS
				    WHEN "00000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "00001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "00010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "00011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "00100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "00101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "00110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "00111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "01000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "01001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "01010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN "01011" => readData_xhdl1_xhdl437_w8 := readData11(7 DOWNTO 0);
                    WHEN "01100" => readData_xhdl1_xhdl437_w8 := readData12(7 DOWNTO 0);
                    WHEN "01101" => readData_xhdl1_xhdl437_w8 := readData13(7 DOWNTO 0);
                    WHEN "01110" => readData_xhdl1_xhdl437_w8 := readData14(7 DOWNTO 0);
                    WHEN "01111" => readData_xhdl1_xhdl437_w8 := readData15(7 DOWNTO 0);
                    WHEN "10000" => readData_xhdl1_xhdl437_w8 := readData16(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;

                   
            WHEN 2208 | 2240 | 2272 | 2304 =>
			
                CASE writeAddr(11 DOWNTO 7) IS
				    WHEN "00000" => wen_a0_xhdl75 := wen;
				    WHEN "00001" => wen_a1_xhdl76 := wen;
				    WHEN "00010" => wen_a2_xhdl77 := wen;
                    WHEN "00011" => wen_a3_xhdl78 := wen;
                    WHEN "00100" => wen_a4_xhdl79 := wen;
                    WHEN "00101" => wen_a5_xhdl80 := wen;
                    WHEN "00110" => wen_a6_xhdl81 := wen;
                    WHEN "00111" => wen_a7_xhdl82 := wen;
                    WHEN "01000" => wen_a8_xhdl83 := wen;
                    WHEN "01001" => wen_a9_xhdl84 := wen;
                    WHEN "01010" => wen_a10_xhdl85 := wen;
                    WHEN "01011" => wen_a11_xhdl86 := wen;
                    WHEN "01100" => wen_a12_xhdl87 := wen;
                    WHEN "01101" => wen_a13_xhdl88 := wen;
                    WHEN "01110" => wen_a14_xhdl89 := wen;
                    WHEN "01111" => wen_a15_xhdl90 := wen;
                    WHEN "10000" => wen_a16_xhdl91 := wen;
                    WHEN "10001" => wen_a17_xhdl92 := wen;
                    WHEN OTHERS  =>
					            wen_a0_xhdl75 := '0';
					            wen_a1_xhdl76 := '0';
					            wen_a2_xhdl77 := '0';
					            wen_a3_xhdl78 := '0';
					            wen_a4_xhdl79 := '0';
					            wen_a5_xhdl80 := '0';
					            wen_a6_xhdl81 := '0';
					            wen_a7_xhdl82 := '0';
					            wen_a8_xhdl83 := '0';
					            wen_a9_xhdl84 := '0';
					            wen_a10_xhdl85 := '0';
					            wen_a11_xhdl86 := '0';
					            wen_a12_xhdl87 := '0';
					            wen_a13_xhdl88 := '0';
					            wen_a14_xhdl89 := '0';
					            wen_a15_xhdl90 := '0';
					            wen_a16_xhdl91 := '0';
					            wen_a17_xhdl92 := '0';
                              
				END CASE;
				
                CASE ckRdAddr(11 DOWNTO 7) IS
				    WHEN "00000" => readData_xhdl1_xhdl437_w8 := readData0(7 DOWNTO 0);
				    WHEN "00001" => readData_xhdl1_xhdl437_w8 := readData1(7 DOWNTO 0);
				    WHEN "00010" => readData_xhdl1_xhdl437_w8 := readData2(7 DOWNTO 0);
                    WHEN "00011" => readData_xhdl1_xhdl437_w8 := readData3(7 DOWNTO 0);
                    WHEN "00100" => readData_xhdl1_xhdl437_w8 := readData4(7 DOWNTO 0);
                    WHEN "00101" => readData_xhdl1_xhdl437_w8 := readData5(7 DOWNTO 0);
                    WHEN "00110" => readData_xhdl1_xhdl437_w8 := readData6(7 DOWNTO 0);
                    WHEN "00111" => readData_xhdl1_xhdl437_w8 := readData7(7 DOWNTO 0);
                    WHEN "01000" => readData_xhdl1_xhdl437_w8 := readData8(7 DOWNTO 0);
                    WHEN "01001" => readData_xhdl1_xhdl437_w8 := readData9(7 DOWNTO 0);
                    WHEN "01010" => readData_xhdl1_xhdl437_w8 := readData10(7 DOWNTO 0);
                    WHEN "01011" => readData_xhdl1_xhdl437_w8 := readData11(7 DOWNTO 0);
                    WHEN "01100" => readData_xhdl1_xhdl437_w8 := readData12(7 DOWNTO 0);
                    WHEN "01101" => readData_xhdl1_xhdl437_w8 := readData13(7 DOWNTO 0);
                    WHEN "01110" => readData_xhdl1_xhdl437_w8 := readData14(7 DOWNTO 0);
                    WHEN "01111" => readData_xhdl1_xhdl437_w8 := readData15(7 DOWNTO 0);
                    WHEN "10000" => readData_xhdl1_xhdl437_w8 := readData16(7 DOWNTO 0);
                    WHEN "10001" => readData_xhdl1_xhdl437_w8 := readData17(7 DOWNTO 0);
                    WHEN OTHERS => readData_xhdl1_xhdl437_w8 := "00000000";
				END CASE;
			WHEN OTHERS => NULL;
		END CASE;
--      END IF;
      -- if (ahbsram_size == WHEN "000)
      
      wen_a0 <= wen_a0_xhdl75;
      wen_a1 <= wen_a1_xhdl76;
      wen_a2 <= wen_a2_xhdl77;
      wen_a3 <= wen_a3_xhdl78;
      wen_a4 <= wen_a4_xhdl79;
      wen_a5 <= wen_a5_xhdl80;
      wen_a6 <= wen_a6_xhdl81;
      wen_a7 <= wen_a7_xhdl82;
      wen_a8 <= wen_a8_xhdl83;
      wen_a9 <= wen_a9_xhdl84;
      wen_a10 <= wen_a10_xhdl85;
      wen_a11 <= wen_a11_xhdl86;
      wen_a12 <= wen_a12_xhdl87;
      wen_a13 <= wen_a13_xhdl88;
      wen_a14 <= wen_a14_xhdl89;
      wen_a15 <= wen_a15_xhdl90;
      wen_a16 <= wen_a16_xhdl91;      
	  wen_a17 <= wen_a17_xhdl92;
      
      --ablk <= ablk_xhdl435;
      --bblk <= bblk_xhdl436;
      --cblk <= cblk_xhdl436;
      ablk <= ren & ren;
      bblk <= ren & ren;
      cblk <= wen & wen;

      readData_xhdl1 <= readData_xhdl1_xhdl437_w8;

   END PROCESS;
   
   -- always @ (*)

   ------------------------------------------------------------------------------------------
   -- RAM64x18 blocks
   ------------------------------------------------------------------------------------------
   
   block_17 : RAM64x18  
      PORT MAP (
         A_DOUT => readData17,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a17,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_17);   
      
   block_16 : RAM64x18  
      PORT MAP (
         A_DOUT => readData16,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a16,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_16);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_15 : RAM64x18  
      PORT MAP (
         A_DOUT => readData15,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a15,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_15);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_14 : RAM64x18  
      PORT MAP (
         A_DOUT => readData14,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a14,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_14);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_13 : RAM64x18  
      PORT MAP (
         A_DOUT => readData13,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a13,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_13);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_12 : RAM64x18  
      PORT MAP (
         A_DOUT => readData12,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a12,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_12);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_11 : RAM64x18  
      PORT MAP (
         A_DOUT => readData11,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a11,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_11);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_10 : RAM64x18  
      PORT MAP (
         A_DOUT => readData10,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a10,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_10);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_9 : RAM64x18  
      PORT MAP (
         A_DOUT => readData9,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a9,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_9);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_8 : RAM64x18  
      PORT MAP (
         A_DOUT => readData8,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a8,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_8);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_7 : RAM64x18  
      PORT MAP (
         A_DOUT => readData7,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a7,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_7);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_6 : RAM64x18  
      PORT MAP (
         A_DOUT => readData6,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a6,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_6);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_5 : RAM64x18  
      PORT MAP (
         A_DOUT => readData5,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a5,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_5);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_4 : RAM64x18  
      PORT MAP (
         A_DOUT => readData4,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a4,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_4);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_3 : RAM64x18  
      PORT MAP (
         A_DOUT => readData3,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a3,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_3);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_2 : RAM64x18  
      PORT MAP (
         A_DOUT => readData2,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a2,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_2);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_1 : RAM64x18  
      PORT MAP (
         A_DOUT => readData1,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a1,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_1);   
   
   
   --                    .A_BLK("11),                 .B_BLK("11),
   block_0 : RAM64x18  
      PORT MAP (
         A_DOUT => readData0,
         B_DOUT => open,
         A_ADDR_CLK => '1',
         B_ADDR_CLK => '1',
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => aresetn,
         B_ADDR_ARST_N => aresetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => clk,
         B_DOUT_CLK => clk,
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '0',
         B_DOUT_LAT => '0',
         A_DOUT_ARST_N => aresetn,
         B_DOUT_ARST_N => aresetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => sram_readAddr,
         B_ADDR => sram_readAddr,
         A_WIDTH => "011",
         B_WIDTH => "011",
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => sram_writeAddr,
         C_DIN => sram_writeData,
         C_WEN => wen_a0,
         C_BLK => cblk,
         C_WIDTH => "011",
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_0);   
   
   u_9K_BUSY_all_xhdl2 <= u_BUSY_0 OR u_BUSY_1 OR u_BUSY_2 OR u_BUSY_3 OR 
   u_BUSY_4 OR u_BUSY_5 OR u_BUSY_6 OR u_BUSY_7 OR u_BUSY_8 OR u_BUSY_9 
   OR u_BUSY_10 OR u_BUSY_11 OR u_BUSY_12 OR u_BUSY_13 OR u_BUSY_14 OR 
   u_BUSY_15 OR u_BUSY_16 OR u_BUSY_17 ;

END ARCHITECTURE translated;
