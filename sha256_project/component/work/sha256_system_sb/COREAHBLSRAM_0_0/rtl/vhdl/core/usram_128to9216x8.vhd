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
use     ieee.std_logic_1164.all;
use     ieee.std_logic_arith.all;
use     ieee.std_logic_unsigned.all;
use     ieee.std_logic_misc.all;

ENTITY sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8 IS
   GENERIC (
      -- ---------------------------------------------------------------------
      -- Parameters
      -- ---------------------------------------------------------------------
      -- DEPTH can range from
      -- 128 to 9216bytes  , in steps of 128bytes
      USRAM_NUM_LOCATIONS_DWIDTH32   :  integer := 128);    
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
END ENTITY sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8;

ARCHITECTURE translated OF sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8 IS

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
   SIGNAL width0                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width1                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width2                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width3                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width4                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width5                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width6                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width7                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width8                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width9                   :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width10                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width11                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width12                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width13                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width14                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width15                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width16                  :  std_logic_vector(2 DOWNTO 0);      SIGNAL width17                  :  std_logic_vector(2 DOWNTO 0);   
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
   SIGNAL wen_a10                  :  std_logic;   
   SIGNAL wen_a11                  :  std_logic;   
   SIGNAL wen_a12                  :  std_logic;   
   SIGNAL wen_a13                  :  std_logic;   
   SIGNAL wen_a14                  :  std_logic;   
   SIGNAL wen_a15                  :  std_logic;   
   SIGNAL wen_a16                  :  std_logic;      SIGNAL wen_a17                  :  std_logic;   
   SIGNAL wen_b0                   :  std_logic;   
   SIGNAL wen_b1                   :  std_logic;   
   SIGNAL wen_b2                   :  std_logic;   
   SIGNAL wen_b3                   :  std_logic;   
   SIGNAL wen_b4                   :  std_logic;   
   SIGNAL wen_b5                   :  std_logic;   
   SIGNAL wen_b6                   :  std_logic;   
   SIGNAL wen_b7                   :  std_logic;   
   SIGNAL wen_b8                   :  std_logic;   
   SIGNAL wen_b9                   :  std_logic;   
   SIGNAL wen_b10                  :  std_logic;   
   SIGNAL wen_b11                  :  std_logic;   
   SIGNAL wen_b12                  :  std_logic;   
   SIGNAL wen_b13                  :  std_logic;   
   SIGNAL wen_b14                  :  std_logic;   
   SIGNAL wen_b15                  :  std_logic;   
   SIGNAL wen_b16                  :  std_logic;      SIGNAL wen_b17                  :  std_logic;   
   SIGNAL writeData0               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData1               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData2               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData3               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData4               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData5               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData6               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData7               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData8               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData9               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData10              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData11              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData12              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData13              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData14              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData15              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData16              :  std_logic_vector(17 DOWNTO 0);      SIGNAL writeData17              :  std_logic_vector(17 DOWNTO 0);   
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
   SIGNAL readData16               :  std_logic_vector(17 DOWNTO 0);      SIGNAL readData17               :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeAddr0               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr1               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr2               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr3               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr4               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr5               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr6               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr7               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr8               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr9               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr10              :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr11              :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr12              :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr13              :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr14              :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr15              :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL writeAddr16              :  std_logic_vector(9 DOWNTO 0);      SIGNAL writeAddr17              :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr0                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr1                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr2                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr3                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr4                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr5                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr6                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr7                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr8                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr9                :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr10               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr11               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr12               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr13               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr14               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr15               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL readAddr16               :  std_logic_vector(9 DOWNTO 0);      SIGNAL readAddr17               :  std_logic_vector(9 DOWNTO 0);   
   SIGNAL ablk                     :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL bblk                     :  std_logic_vector(1 DOWNTO 0);   
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
   SIGNAL u_9K_BUSY_all_xhdl2         :  std_logic;   

BEGIN
   readData      <= readData_xhdl1;
   u_BUSY_all    <= u_9K_BUSY_all_xhdl2;

   ------------------------------------------------------------------------
   -- Main body of code
   ------------------------------------------------------------------------
   
   PROCESS (clk, resetn)
   BEGIN
      IF (NOT resetn = '1') THEN
         ckRdAddr(13 DOWNTO 6) <= "00000000";    
      ELSIF (clk'EVENT AND clk = '1') THEN
         ckRdAddr(13 DOWNTO 6) <= readAddr(13 DOWNTO 6);    
      END IF;
   END PROCESS;

   ------------------------------------------------------------------------------------------
   -- Assign values to various signals based on DEPTH and RAM64x16_WIDTH settings.
   -- Default is to build the (byte wide) memory from RAM blocks which are configured to
   -- be tall and narrow.
   ------------------------------------------------------------------------------------------
   
   PROCESS (writeData, wen_a0, wen_a1, wen_a2, wen_a3, wen_a4, 
   wen_a5, ckRdAddr, readAddr, readData10, 
   readData11, readData12, readData13, readData14, readData15, wen, 
   readData16, readData17, readData0, readData1, 
   readData2, readData3, readData4, readData5, readData6, readData7, readData8, 
   readData9, writeAddr)
      VARIABLE width0_xhdl3  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width1_xhdl4  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width2_xhdl5  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width3_xhdl6  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width4_xhdl7  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width5_xhdl8  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width6_xhdl9  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width7_xhdl10  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width8_xhdl11  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width9_xhdl12  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width10_xhdl13  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width11_xhdl14  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width12_xhdl15  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width13_xhdl16  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width14_xhdl17  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width15_xhdl18  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width16_xhdl19  : std_logic_vector(2 DOWNTO 0);      VARIABLE width17_xhdl20  : std_logic_vector(2 DOWNTO 0);
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
      VARIABLE wen_a16_xhdl91  : std_logic;      VARIABLE wen_a17_xhdl92  : std_logic;
      VARIABLE wen_b0_xhdl147  : std_logic;
      VARIABLE wen_b1_xhdl148  : std_logic;
      VARIABLE wen_b2_xhdl149  : std_logic;
      VARIABLE wen_b3_xhdl150  : std_logic;
      VARIABLE wen_b4_xhdl151  : std_logic;
      VARIABLE wen_b5_xhdl152  : std_logic;
      VARIABLE wen_b6_xhdl153  : std_logic;
      VARIABLE wen_b7_xhdl154  : std_logic;
      VARIABLE wen_b8_xhdl155  : std_logic;
      VARIABLE wen_b9_xhdl156  : std_logic;
      VARIABLE wen_b10_xhdl157  : std_logic;
      VARIABLE wen_b11_xhdl158  : std_logic;
      VARIABLE wen_b12_xhdl159  : std_logic;
      VARIABLE wen_b13_xhdl160  : std_logic;
      VARIABLE wen_b14_xhdl161  : std_logic;
      VARIABLE wen_b15_xhdl162  : std_logic;
      VARIABLE wen_b16_xhdl163  : std_logic;
      VARIABLE writeData0_xhdl219  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData1_xhdl220  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData2_xhdl221  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData3_xhdl222  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData4_xhdl223  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData5_xhdl224  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData6_xhdl225  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData7_xhdl226  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData8_xhdl227  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData9_xhdl228  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData10_xhdl229  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData11_xhdl230  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData12_xhdl231  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData13_xhdl232  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData14_xhdl233  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData15_xhdl234  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData16_xhdl235  : std_logic_vector(17 DOWNTO 0);      VARIABLE writeData17_xhdl236  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeAddr0_xhdl291  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr1_xhdl292  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr2_xhdl293  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr3_xhdl294  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr4_xhdl295  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr5_xhdl296  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr6_xhdl297  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr7_xhdl298  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr8_xhdl299  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr9_xhdl300  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr10_xhdl301  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr11_xhdl302  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr12_xhdl303  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr13_xhdl304  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr14_xhdl305  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr15_xhdl306  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr16_xhdl307  : std_logic_vector(9 DOWNTO 0);
      VARIABLE writeAddr17_xhdl308  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr0_xhdl363  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr1_xhdl364  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr2_xhdl365  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr3_xhdl366  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr4_xhdl367  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr5_xhdl368  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr6_xhdl369  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr7_xhdl370  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr8_xhdl371  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr9_xhdl372  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr10_xhdl373  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr11_xhdl374  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr12_xhdl375  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr13_xhdl376  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr14_xhdl377  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr15_xhdl378  : std_logic_vector(9 DOWNTO 0);
      VARIABLE readAddr16_xhdl379  : std_logic_vector(9 DOWNTO 0);      VARIABLE readAddr17_xhdl380  : std_logic_vector(9 DOWNTO 0);
      VARIABLE ablk_xhdl435  : std_logic_vector(1 DOWNTO 0);
      VARIABLE bblk_xhdl436  : std_logic_vector(1 DOWNTO 0);
      VARIABLE readData_xhdl1_xhdl437_w8  : std_logic_vector(7
      DOWNTO 0);
      
      VARIABLE xhdl438  : std_logic_vector(5 DOWNTO 0);
      VARIABLE xhdl439  : std_logic_vector(2 DOWNTO 0);
   BEGIN
      width0_xhdl3 := "000";    
      width1_xhdl4 := "000";    
      width2_xhdl5 := "000";    
      width3_xhdl6 := "000";    
      width4_xhdl7 := "000";    
      width5_xhdl8 := "000";    
      width6_xhdl9 := "000";    
      width7_xhdl10 := "000";    
      width8_xhdl11 := "000";    
      width9_xhdl12 := "000";    
      width10_xhdl13 := "000";    
      width11_xhdl14 := "000";    
      width12_xhdl15 := "000";    
      width13_xhdl16 := "000";    
      width14_xhdl17 := "000";    
      width15_xhdl18 := "000";    
      width16_xhdl19 := "000";          width17_xhdl20 := "000"; 
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
      wen_a16_xhdl91 := '0';          wen_a17_xhdl92 := '0';    
      wen_b0_xhdl147 := '0';    
      wen_b1_xhdl148 := '0';    
      wen_b2_xhdl149 := '0';    
      wen_b3_xhdl150 := '0';    
      wen_b4_xhdl151 := '0';    
      wen_b5_xhdl152 := '0';    
      wen_b6_xhdl153 := '0';    
      wen_b7_xhdl154 := '0';    
      wen_b8_xhdl155 := '0';    
      wen_b9_xhdl156 := '0';    
      wen_b10_xhdl157 := '0';    
      wen_b11_xhdl158 := '0';    
      wen_b12_xhdl159 := '0';    
      wen_b13_xhdl160 := '0';    
      wen_b14_xhdl161 := '0';    
      wen_b15_xhdl162 := '0';    
      wen_b16_xhdl163 := '0';    
      writeData0_xhdl219 := "000000000000000000";    
      writeData1_xhdl220 := "000000000000000000";    
      writeData2_xhdl221 := "000000000000000000";    
      writeData3_xhdl222 := "000000000000000000";    
      writeData4_xhdl223 := "000000000000000000";    
      writeData5_xhdl224 := "000000000000000000";    
      writeData6_xhdl225 := "000000000000000000";    
      writeData7_xhdl226 := "000000000000000000";    
      writeData8_xhdl227 := "000000000000000000";    
      writeData9_xhdl228 := "000000000000000000";    
      writeData10_xhdl229 := "000000000000000000";    
      writeData11_xhdl230 := "000000000000000000";    
      writeData12_xhdl231 := "000000000000000000";    
      writeData13_xhdl232 := "000000000000000000";    
      writeData14_xhdl233 := "000000000000000000";    
      writeData15_xhdl234 := "000000000000000000";    
      writeData16_xhdl235 := "000000000000000000";          writeData17_xhdl236 := "000000000000000000";    
      writeAddr0_xhdl291 := "0000000000";    
      writeAddr1_xhdl292 := "0000000000";    
      writeAddr2_xhdl293 := "0000000000";    
      writeAddr3_xhdl294 := "0000000000";    
      writeAddr4_xhdl295 := "0000000000";    
      writeAddr5_xhdl296 := "0000000000";    
      writeAddr6_xhdl297 := "0000000000";    
      writeAddr7_xhdl298 := "0000000000";    
      writeAddr8_xhdl299 := "0000000000";    
      writeAddr9_xhdl300 := "0000000000";    
      writeAddr10_xhdl301 := "0000000000";    
      writeAddr11_xhdl302 := "0000000000";    
      writeAddr12_xhdl303 := "0000000000";    
      writeAddr13_xhdl304 := "0000000000";    
      writeAddr14_xhdl305 := "0000000000";    
      writeAddr15_xhdl306 := "0000000000";    
      writeAddr16_xhdl307 := "0000000000";          writeAddr17_xhdl308 := "0000000000";    
      readAddr0_xhdl363 := "0000000000";    
      readAddr1_xhdl364 := "0000000000";    
      readAddr2_xhdl365 := "0000000000";    
      readAddr3_xhdl366 := "0000000000";    
      readAddr4_xhdl367 := "0000000000";    
      readAddr5_xhdl368 := "0000000000";    
      readAddr6_xhdl369 := "0000000000";    
      readAddr7_xhdl370 := "0000000000";    
      readAddr8_xhdl371 := "0000000000";    
      readAddr9_xhdl372 := "0000000000";    
      readAddr10_xhdl373 := "0000000000";    
      readAddr11_xhdl374 := "0000000000";    
      readAddr12_xhdl375 := "0000000000";    
      readAddr13_xhdl376 := "0000000000";    
      readAddr14_xhdl377 := "0000000000";    
      readAddr15_xhdl378 := "0000000000";    
      readAddr16_xhdl379 := "0000000000";          readAddr17_xhdl380 := "0000000000";    
      ablk_xhdl435 := "00";    
      bblk_xhdl436 := "00";

--               IF (AHB_DWIDTH = 8) THEN
                  
                  ablk_xhdl435 := "11";    
                  bblk_xhdl436 := "11";    
                  CASE USRAM_NUM_LOCATIONS_DWIDTH32 IS
                     WHEN 128 =>
                              -- RAM 1 to RAM 4 for 64x32 configuration
                              
                              width1_xhdl4 := "011";    
                              writeAddr1_xhdl292 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr1_xhdl364 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData1_xhdl220 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              wen_a1_xhdl76 := wen;    
                              readData_xhdl1_xhdl437_w8 :=                                
                              readData1(7 DOWNTO 0);    
                     WHEN 256 =>
                              width2_xhdl5 := "010";    
                              width1_xhdl4 := "010";    
                              writeAddr2_xhdl293 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              readAddr2_xhdl365 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              writeData2_xhdl221 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              wen_a2_xhdl77 := wen;    
                              wen_a1_xhdl76 := wen;    
                              readData_xhdl1_xhdl437_w8 :=                                
                              readData2(3 DOWNTO 0) & readData1(3 DOWNTO 
                              0);    
                     WHEN 384 =>
                              width3_xhdl6 := "010";    
                              width2_xhdl5 := "010";    
                              width1_xhdl4 := "011";    
                              writeAddr3_xhdl294 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr2_xhdl293 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr1_xhdl292 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr3_xhdl366 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr2_xhdl365 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr1_xhdl364 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData3_xhdl222 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData2_xhdl221 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              writeData1_xhdl220 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(8 DOWNTO 6) IS
                                 WHEN "000" |
                                      "001" |
                                      "010" |
                                      "011" =>
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := '0';    
                                 WHEN "100" |
                                      "101" =>
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(8 DOWNTO 6) IS
                                 WHEN "000" |
                                      "001" |
                                      "010" |
                                      "011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData3(3 
                                          DOWNTO 0) & readData2(3 DOWNTO 
                                          0);    
                                 WHEN "100" |
                                      "101" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData1(7 
                                          DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 512 =>
                              width4_xhdl7 := "001";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "001";    
                              width1_xhdl4 := "001";    
                              writeAddr4_xhdl295 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr1_xhdl292 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              readAddr4_xhdl367 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr1_xhdl364 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              writeData4_xhdl223 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData2_xhdl221 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData1_xhdl220 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              wen_a4_xhdl79 := wen;    
                              wen_a3_xhdl78 := wen;    
                              wen_a2_xhdl77 := wen;    
                              wen_a1_xhdl76 := wen;    
                              readData_xhdl1_xhdl437_w8 := 
                              readData4(1 DOWNTO 0) & readData3(1 DOWNTO 
                              0) & readData2(1 DOWNTO 0) & readData1(1 
                              DOWNTO 0);    
                     WHEN 640 =>
                              --512x2   
                              
                              width4_xhdl7 := "001";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "001";    
                              width1_xhdl4 := "001";    
                              width0_xhdl3 := "011";    
                              writeAddr4_xhdl295 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr1_xhdl292 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr0_xhdl291 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr4_xhdl367 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr1_xhdl364 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr0_xhdl363 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData4_xhdl223 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData2_xhdl221 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData1_xhdl220 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              writeData0_xhdl219 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(9 DOWNTO 6) IS
                                 WHEN "0000" |
                                      "0001" |
                                      "0010" |
                                      "0011" |
                                      "0100" |
                                      "0101" |
                                      "0110" |
                                      "0111" =>
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "1000" |
                                      "1001" =>
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(9 DOWNTO 6) IS
                                 WHEN "0000" |
                                      "0001" |
                                      "0010" |
                                      "0011" |
                                      "0100" |
                                      "0101" |
                                      "0110" |
                                      "0111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData4(1 DOWNTO 0) & readData3(1 DOWNTO 
                                          0) & readData2(1 DOWNTO 0) & 
                                          readData1(1 DOWNTO 0);    
                                 WHEN "1000" |
                                      "1001" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData0(7 DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 768 =>
                              --512x2   
                              
                              width5_xhdl8 := "001";    
                              width4_xhdl7 := "001";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "001";    
                              width1_xhdl4 := "010";    
                              width0_xhdl3 := "010";    
                              writeAddr5_xhdl296 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr4_xhdl295 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr0_xhdl291 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              readAddr5_xhdl368 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr4_xhdl367 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr0_xhdl363 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              writeData5_xhdl224 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData4_xhdl223 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData2_xhdl221 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData0_xhdl219 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              CASE writeAddr(9 DOWNTO 6) IS
                                 WHEN "0000" |
                                      "0001" |
                                      "0010" |
                                      "0011" |
                                      "0100" |
                                      "0101" |
                                      "0110" |
                                      "0111" =>
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "1000" |
                                      "1001" |
                                      "1010" |
                                      "1011" =>
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(9 DOWNTO 6) IS
                                 WHEN "0000" |
                                      "0001" |
                                      "0010" |
                                      "0011" |
                                      "0100" |
                                      "0101" |
                                      "0110" |
                                      "0111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData5(1 DOWNTO 0) & readData4(1 DOWNTO 
                                          0) & readData3(1 DOWNTO 0) & 
                                          readData2(1 DOWNTO 0);    
                                 WHEN "1000" |
                                      "1001" |
                                      "1010" |
                                      "1011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData1(3 DOWNTO 0) & readData0(3 DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 896 =>
                              --512x2
                              
                              width6_xhdl9 := "001";    
                              width5_xhdl8 := "001";    
                              width4_xhdl7 := "001";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "010";    
                              width1_xhdl4 := "010";    
                              width0_xhdl3 := "011";    
                              writeAddr6_xhdl297 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr5_xhdl296 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr4_xhdl295 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr0_xhdl291 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr6_xhdl369 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr5_xhdl368 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr4_xhdl367 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr0_xhdl363 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData6_xhdl225 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData5_xhdl224 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData4_xhdl223 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              writeData2_xhdl221 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              writeData0_xhdl219 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(9 DOWNTO 6) IS
                                 WHEN "0000" |
                                      "0001" |
                                      "0010" |
                                      "0011" |
                                      "0100" |
                                      "0101" |
                                      "0110" |
                                      "0111" =>
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "1000" |
                                      "1001" |
                                      "1010" |
                                      "1011" =>
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "1100" |
                                      "1101" =>
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(9 DOWNTO 6) IS
                                 WHEN "0000" |
                                      "0001" |
                                      "0010" |
                                      "0011" |
                                      "0100" |
                                      "0101" |
                                      "0110" |
                                      "0111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData6(1 DOWNTO 0) & readData5(1 DOWNTO 0) & readData4(1 DOWNTO 0) & 
                                          readData3(1 DOWNTO 0);    
                                 WHEN "1000" |
                                      "1001" |
                                      "1010" |
                                      "1011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData2(3 DOWNTO 0) & readData1(3 DOWNTO 0);    
                                 WHEN "1100" |
                                      "1101" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData0(7 DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 1024 =>
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "000";    
                              width2_xhdl5 := "000";    
                              width1_xhdl4 := "000";    
                              width0_xhdl3 := "000";    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr2_xhdl293 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr1_xhdl292 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr0_xhdl291 := writeAddr(9 DOWNTO 0)
                              ;    
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(9 DOWNTO 0); 
                              readAddr2_xhdl365 := readAddr(9 DOWNTO 0); 
                              readAddr1_xhdl364 := readAddr(9 DOWNTO 0); 
                              readAddr0_xhdl363 := readAddr(9 DOWNTO 0); 
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(7);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(6);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(5);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(4);    
                              writeData3_xhdl222 := "00000000000000000" 
                              & writeData(3);    
                              writeData2_xhdl221 := "00000000000000000" 
                              & writeData(2);    
                              writeData1_xhdl220 := "00000000000000000" 
                              & writeData(1);    
                              writeData0_xhdl219 := "00000000000000000" 
                              & writeData(0);    
                              wen_a7_xhdl82 := wen;    
                              wen_a6_xhdl81 := wen;    
                              wen_a5_xhdl80 := wen;    
                              wen_a4_xhdl79 := wen;    
                              wen_a3_xhdl78 := wen;    
                              wen_a2_xhdl77 := wen;    
                              wen_a1_xhdl76 := wen;    
                              wen_a0_xhdl75 := wen;    
                              readData_xhdl1_xhdl437_w8 :=                                
                              readData7(0) & readData6(0) & readData5(0) 
                              & readData4(0) & readData3(0) & 
                              readData2(0) & readData1(0) & readData0(0)
                              ;    
                     WHEN 1152 =>
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "000";    
                              width2_xhdl5 := "000";    
                              width1_xhdl4 := "000";    
                              width0_xhdl3 := "011";    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr2_xhdl293 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr1_xhdl292 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr0_xhdl291 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(9 DOWNTO 0); 
                              readAddr2_xhdl365 := readAddr(9 DOWNTO 0); 
                              readAddr1_xhdl364 := readAddr(9 DOWNTO 0); 
                              readAddr0_xhdl363 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(7);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(6);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(5);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(4);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(3);    
                              writeData3_xhdl222 := "00000000000000000" 
                              & writeData(2);    
                              writeData2_xhdl221 := "00000000000000000" 
                              & writeData(1);    
                              writeData1_xhdl220 := "00000000000000000" 
                              & writeData(0);    
                              writeData0_xhdl219 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" =>
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData8(0) & 
                                          readData7(0) & readData6(0) & 
                                          readData5(0) & readData4(0) & 
                                          readData3(0) & readData2(0) & 
                                          readData1(0);    
                                 WHEN "10000" |
                                      "10001" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData0(7 
                                          DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 1280 =>
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "000";    
                              width2_xhdl5 := "000";    
                              width1_xhdl4 := "010";    
                              width0_xhdl3 := "010";    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr2_xhdl293 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr0_xhdl291 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(9 DOWNTO 0); 
                              readAddr2_xhdl365 := readAddr(9 DOWNTO 0); 
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr0_xhdl363 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(7);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(6);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(5);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(4);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(3);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(2);    
                              writeData3_xhdl222 := "00000000000000000" 
                              & writeData(1);    
                              writeData2_xhdl221 := "00000000000000000" 
                              & writeData(0);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData0_xhdl219 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" =>
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData9(0) & 
                                          readData8(0) & readData7(0) & 
                                          readData6(0) & readData5(0) & 
                                          readData4(0) & readData3(0) & 
                                          readData2(0);    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData1(3 
                                          DOWNTO 0) & readData0(3 DOWNTO 
                                          0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 1408 =>
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "000";    
                              width2_xhdl5 := "010";    
                              width1_xhdl4 := "010";    
                              width0_xhdl3 := "011";    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr2_xhdl293 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr0_xhdl291 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(9 DOWNTO 0); 
                              readAddr2_xhdl365 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr0_xhdl363 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(7);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(6);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(5);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(4);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(3);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(2);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(1);    
                              writeData3_xhdl222 := "00000000000000000" 
                              & writeData(0);    
                              writeData2_xhdl221 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              writeData0_xhdl219 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" =>
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10100" |
                                      "10101" =>
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData10(0) & 
                                          readData9(0) & readData8(0) & 
                                          readData7(0) & readData6(0) & 
                                          readData5(0) & readData4(0) & 
                                          readData3(0);    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData2(3 
                                          DOWNTO 0) & readData1(3 DOWNTO 
                                          0);    
                                 WHEN "10100" |
                                      "10101" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData0(7 
                                          DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 1536 =>
                              width11_xhdl14 := "000";    
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "001";    
                              width1_xhdl4 := "001";    
                              width0_xhdl3 := "001";    
                              writeAddr11_xhdl302 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr1_xhdl292 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr0_xhdl291 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              readAddr11_xhdl374 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr1_xhdl364 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr0_xhdl363 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              writeData11_xhdl230 := "00000000000000000" 
                              & writeData(7);    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(6);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(5);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(4);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(3);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(2);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(1);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(0);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData2_xhdl221 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData1_xhdl220 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData0_xhdl219 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a11_xhdl86 := wen;    
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData11(0) & 
                                          readData10(0) & readData9(0) & 
                                          readData8(0) & readData7(0) & 
                                          readData6(0) & readData5(0) & 
                                          readData4(0);    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData3(1 
                                          DOWNTO 0) & readData2(1 DOWNTO 
                                          0) & readData1(1 DOWNTO 0) & 
                                          readData0(1 DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 1664 =>
                              width12_xhdl15 := "000";    
                              width11_xhdl14 := "000";    
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "001";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "001";    
                              width1_xhdl4 := "001";    
                              width0_xhdl3 := "011";    
                              writeAddr12_xhdl303 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr11_xhdl302 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr1_xhdl292 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr0_xhdl291 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr12_xhdl375 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr11_xhdl374 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr1_xhdl364 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr0_xhdl363 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData12_xhdl231 := "00000000000000000" 
                              & writeData(7);    
                              writeData11_xhdl230 := "00000000000000000" 
                              & writeData(6);    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(5);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(4);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(3);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(2);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(1);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(0);    
                              writeData4_xhdl223 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData2_xhdl221 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData1_xhdl220 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              writeData0_xhdl219 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a12_xhdl87 := wen;    
                                          wen_a11_xhdl86 := wen;    
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "11000" |
                                      "11001" =>
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData12(0) & 
                                          readData11(0) & readData10(0) 
                                          & readData9(0) & readData8(0) 
                                          & readData7(0) & readData6(0) 
                                          & readData5(0);    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData4(1 
                                          DOWNTO 0) & readData3(1 DOWNTO 
                                          0) & readData2(1 DOWNTO 0) & 
                                          readData1(1 DOWNTO 0);    
                                 WHEN "11000" |
                                      "11001" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData0(7 
                                          DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 1792 =>
                              width13_xhdl16 := "000";    
                              width12_xhdl15 := "000";    
                              width11_xhdl14 := "000";    
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "001";    
                              width4_xhdl7 := "001";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "001";    
                              width1_xhdl4 := "010";    
                              width0_xhdl3 := "010";    
                              writeAddr13_xhdl304 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr12_xhdl303 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr11_xhdl302 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr4_xhdl295 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr0_xhdl291 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              readAddr13_xhdl376 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr12_xhdl375 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr11_xhdl374 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr4_xhdl367 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr0_xhdl363 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              writeData13_xhdl232 := "00000000000000000" 
                              & writeData(7);    
                              writeData12_xhdl231 := "00000000000000000" 
                              & writeData(6);    
                              writeData11_xhdl230 := "00000000000000000" 
                              & writeData(5);    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(4);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(3);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(2);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(1);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(0);    
                              writeData5_xhdl224 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData4_xhdl223 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData2_xhdl221 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData0_xhdl219 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a13_xhdl88 := wen;    
                                          wen_a12_xhdl87 := wen;    
                                          wen_a11_xhdl86 := wen;    
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "11000" |
                                      "11001" |
                                      "11010" |
                                      "11011" =>
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData13(0) & 
                                          readData12(0) & readData11(0) 
                                          & readData10(0) & readData9(0) 
                                          & readData8(0) & readData7(0) 
                                          & readData6(0);    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData5(1 
                                          DOWNTO 0) & readData4(1 DOWNTO 
                                          0) & readData3(1 DOWNTO 0) & 
                                          readData2(1 DOWNTO 0);    
                                 WHEN "11000" |
                                      "11001" |
                                      "11010" |
                                      "11011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData1(3 
                                          DOWNTO 0) & readData0(3 DOWNTO 
                                          0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 1920 =>
                              width14_xhdl17 := "000";    
                              width13_xhdl16 := "000";    
                              width12_xhdl15 := "000";    
                              width11_xhdl14 := "000";    
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "001";    
                              width5_xhdl8 := "001";    
                              width4_xhdl7 := "001";    
                              width3_xhdl6 := "001";    
                              width2_xhdl5 := "010";    
                              width1_xhdl4 := "010";    
                              width0_xhdl3 := "011";    
                              writeAddr14_xhdl305 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr13_xhdl304 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr12_xhdl303 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr11_xhdl302 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr5_xhdl296 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr4_xhdl295 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr3_xhdl294 := writeAddr(8 DOWNTO 0)
                              & '0';    
                              writeAddr2_xhdl293 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr0_xhdl291 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr14_xhdl377 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr13_xhdl376 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr12_xhdl375 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr11_xhdl374 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr5_xhdl368 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr4_xhdl367 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr3_xhdl366 := readAddr(8 DOWNTO 0) 
                              & '0';    
                              readAddr2_xhdl365 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr0_xhdl363 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData14_xhdl233 := "00000000000000000" 
                              & writeData(7);    
                              writeData13_xhdl232 := "00000000000000000" 
                              & writeData(6);    
                              writeData12_xhdl231 := "00000000000000000" 
                              & writeData(5);    
                              writeData11_xhdl230 := "00000000000000000" 
                              & writeData(4);    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(3);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(2);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(1);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(0);    
                              writeData6_xhdl225 := "0000000000000000" & 
                              writeData(7 DOWNTO 6);    
                              writeData5_xhdl224 := "0000000000000000" & 
                              writeData(5 DOWNTO 4);    
                              writeData4_xhdl223 := "0000000000000000" & 
                              writeData(3 DOWNTO 2);    
                              writeData3_xhdl222 := "0000000000000000" & 
                              writeData(1 DOWNTO 0);    
                              writeData2_xhdl221 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              writeData0_xhdl219 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a14_xhdl89 := wen;    
                                          wen_a13_xhdl88 := wen;    
                                          wen_a12_xhdl87 := wen;    
                                          wen_a11_xhdl86 := wen;    
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "11000" |
                                      "11001" |
                                      "11010" |
                                      "11011" =>
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "11100" |
                                      "11101" =>
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData14(0) & 
                                          readData13(0) & readData12(0) 
                                          & readData11(0) & readData10(0)
                                          & readData9(0) & readData8(0) 
                                          & readData7(0);    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData6(1 
                                          DOWNTO 0) & readData5(1 DOWNTO 
                                          0) & readData4(1 DOWNTO 0) & 
                                          readData3(1 DOWNTO 0);    
                                 WHEN "11000" |
                                      "11001" |
                                      "11010" |
                                      "11011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData2(3 
                                          DOWNTO 0) & readData1(3 DOWNTO 
                                          0);    
                                 WHEN "11100" |
                                      "11101" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData0(7 
                                          DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 2048 =>
                              width15_xhdl18 := "000";    
                              width14_xhdl17 := "000";    
                              width13_xhdl16 := "000";    
                              width12_xhdl15 := "000";    
                              width11_xhdl14 := "000";    
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "000";    
                              width2_xhdl5 := "000";    
                              width1_xhdl4 := "000";    
                              width0_xhdl3 := "000";    
                              writeAddr15_xhdl306 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr14_xhdl305 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr13_xhdl304 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr12_xhdl303 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr11_xhdl302 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr2_xhdl293 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr1_xhdl292 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr0_xhdl291 := writeAddr(9 DOWNTO 0)
                              ;    
                              readAddr15_xhdl378 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr14_xhdl377 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr13_xhdl376 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr12_xhdl375 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr11_xhdl374 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(9 DOWNTO 0); 
                              readAddr2_xhdl365 := readAddr(9 DOWNTO 0); 
                              readAddr1_xhdl364 := readAddr(9 DOWNTO 0); 
                              readAddr0_xhdl363 := readAddr(9 DOWNTO 0); 
                              writeData15_xhdl234 := "00000000000000000" 
                              & writeData(7);    
                              writeData14_xhdl233 := "00000000000000000" 
                              & writeData(6);    
                              writeData13_xhdl232 := "00000000000000000" 
                              & writeData(5);    
                              writeData12_xhdl231 := "00000000000000000" 
                              & writeData(4);    
                              writeData11_xhdl230 := "00000000000000000" 
                              & writeData(3);    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(2);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(1);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(0);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(7);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(6);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(5);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(4);    
                              writeData3_xhdl222 := "00000000000000000" 
                              & writeData(3);    
                              writeData2_xhdl221 := "00000000000000000" 
                              & writeData(2);    
                              writeData1_xhdl220 := "00000000000000000" 
                              & writeData(1);    
                              writeData0_xhdl219 := "00000000000000000" 
                              & writeData(0);    
                              CASE writeAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          wen_a15_xhdl90 := wen;    
                                          wen_a14_xhdl89 := wen;    
                                          wen_a13_xhdl88 := wen;    
                                          wen_a12_xhdl87 := wen;    
                                          wen_a11_xhdl86 := wen;    
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" |
                                      "11000" |
                                      "11001" |
                                      "11010" |
                                      "11011" |
                                      "11100" |
                                      "11101" |
                                      "11110" |
                                      "11111" =>
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(10 DOWNTO 6) IS
                                 WHEN "00000" |
                                      "00001" |
                                      "00010" |
                                      "00011" |
                                      "00100" |
                                      "00101" |
                                      "00110" |
                                      "00111" |
                                      "01000" |
                                      "01001" |
                                      "01010" |
                                      "01011" |
                                      "01100" |
                                      "01101" |
                                      "01110" |
                                      "01111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData15(0) & 
                                          readData14(0) & readData13(0) 
                                          & readData12(0) & readData11(0)
                                          & readData10(0) & readData9(0) 
                                          & readData8(0);    
                                 WHEN "10000" |
                                      "10001" |
                                      "10010" |
                                      "10011" |
                                      "10100" |
                                      "10101" |
                                      "10110" |
                                      "10111" |
                                      "11000" |
                                      "11001" |
                                      "11010" |
                                      "11011" |
                                      "11100" |
                                      "11101" |
                                      "11110" |
                                      "11111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData7(0) & 
                                          readData6(0) & readData5(0) & 
                                          readData4(0) & readData3(0) & 
                                          readData2(0) & readData1(0) & 
                                          readData0(0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 2176 =>
                              width16_xhdl19 := "000";    
                              width15_xhdl18 := "000";    
                              width14_xhdl17 := "000";    
                              width13_xhdl16 := "000";    
                              width12_xhdl15 := "000";    
                              width11_xhdl14 := "000";    
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "000";    
                              width2_xhdl5 := "000";    
                              width1_xhdl4 := "000";    
                              width0_xhdl3 := "011";    
                              writeAddr16_xhdl307 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr15_xhdl306 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr14_xhdl305 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr13_xhdl304 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr12_xhdl303 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr11_xhdl302 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr2_xhdl293 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr1_xhdl292 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr0_xhdl291 := writeAddr(6 DOWNTO 0)
                              & "000";    
                              readAddr16_xhdl379 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr15_xhdl378 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr14_xhdl377 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr13_xhdl376 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr12_xhdl375 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr11_xhdl374 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(9 DOWNTO 0); 
                              readAddr2_xhdl365 := readAddr(9 DOWNTO 0); 
                              readAddr1_xhdl364 := readAddr(9 DOWNTO 0); 
                              readAddr0_xhdl363 := readAddr(6 DOWNTO 0) 
                              & "000";    
                              writeData16_xhdl235 := "00000000000000000" 
                              & writeData(7);    
                              writeData15_xhdl234 := "00000000000000000" 
                              & writeData(6);    
                              writeData14_xhdl233 := "00000000000000000" 
                              & writeData(5);    
                              writeData13_xhdl232 := "00000000000000000" 
                              & writeData(4);    
                              writeData12_xhdl231 := "00000000000000000" 
                              & writeData(3);    
                              writeData11_xhdl230 := "00000000000000000" 
                              & writeData(2);    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(1);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(0);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(7);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(6);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(5);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(4);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(3);    
                              writeData3_xhdl222 := "00000000000000000" 
                              & writeData(2);    
                              writeData2_xhdl221 := "00000000000000000" 
                              & writeData(1);    
                              writeData1_xhdl220 := "00000000000000000" 
                              & writeData(0);    
                              writeData0_xhdl219 := "0000000000" & 
                              writeData(7 DOWNTO 0);    
                              CASE writeAddr(11 DOWNTO 6) IS
                                 WHEN "000000" |
                                      "000001" |
                                      "000010" |
                                      "000011" |
                                      "000100" |
                                      "000101" |
                                      "000110" |
                                      "000111" |
                                      "001000" |
                                      "001001" |
                                      "001010" |
                                      "001011" |
                                      "001100" |
                                      "001101" |
                                      "001110" |
                                      "001111" =>
                                          wen_a16_xhdl91 := wen;    
                                          wen_a15_xhdl90 := wen;    
                                          wen_a14_xhdl89 := wen;    
                                          wen_a13_xhdl88 := wen;    
                                          wen_a12_xhdl87 := wen;    
                                          wen_a11_xhdl86 := wen;    
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "010000" |
                                      "010001" |
                                      "010010" |
                                      "010011" |
                                      "010100" |
                                      "010101" |
                                      "010110" |
                                      "010111" |
                                      "011000" |
                                      "011001" |
                                      "011010" |
                                      "011011" |
                                      "011100" |
                                      "011101" |
                                      "011110" |
                                      "011111" =>
                                          wen_a16_xhdl91 := '0';    
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "100000" |
                                      "100001" =>
                                          wen_a16_xhdl91 := '0';    
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a16_xhdl91 := '0';    
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(11 DOWNTO 6) IS
                                 WHEN "000000" |
                                      "000001" |
                                      "000010" |
                                      "000011" |
                                      "000100" |
                                      "000101" |
                                      "000110" |
                                      "000111" |
                                      "001000" |
                                      "001001" |
                                      "001010" |
                                      "001011" |
                                      "001100" |
                                      "001101" |
                                      "001110" |
                                      "001111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData16(0) & 
                                          readData15(0) & readData14(0) 
                                          & readData13(0) & readData12(0)
                                          & readData11(0) & readData10(0)
                                          & readData9(0);    
                                 WHEN "010000" |
                                      "010001" |
                                      "010010" |
                                      "010011" |
                                      "010100" |
                                      "010101" |
                                      "010110" |
                                      "010111" |
                                      "011000" |
                                      "011001" |
                                      "011010" |
                                      "011011" |
                                      "011100" |
                                      "011101" |
                                      "011110" |
                                      "011111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData8(0) & 
                                          readData7(0) & readData6(0) & 
                                          readData5(0) & readData4(0) & 
                                          readData3(0) & readData2(0) & 
                                          readData1(0);    
                                 WHEN "100000" |
                                      "100001" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData0(7 
                                          DOWNTO 0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;
                     WHEN 2304 =>
                              width17_xhdl20 := "000";    
                              width16_xhdl19 := "000";    
                              width15_xhdl18 := "000";    
                              width14_xhdl17 := "000";    
                              width13_xhdl16 := "000";    
                              width12_xhdl15 := "000";    
                              width11_xhdl14 := "000";    
                              width10_xhdl13 := "000";    
                              width9_xhdl12 := "000";    
                              width8_xhdl11 := "000";    
                              width7_xhdl10 := "000";    
                              width6_xhdl9 := "000";    
                              width5_xhdl8 := "000";    
                              width4_xhdl7 := "000";    
                              width3_xhdl6 := "000";    
                              width2_xhdl5 := "000";    
                              width1_xhdl4 := "010";    
                              width0_xhdl3 := "010";    
                              writeAddr17_xhdl308 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr16_xhdl307 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr15_xhdl306 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr14_xhdl305 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr13_xhdl304 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr12_xhdl303 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr11_xhdl302 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr10_xhdl301 := writeAddr(9 DOWNTO 
                              0);    
                              writeAddr9_xhdl300 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr8_xhdl299 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr7_xhdl298 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr6_xhdl297 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr5_xhdl296 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr4_xhdl295 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr3_xhdl294 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr2_xhdl293 := writeAddr(9 DOWNTO 0)
                              ;    
                              writeAddr1_xhdl292 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              writeAddr0_xhdl291 := writeAddr(7 DOWNTO 0)
                              & "00";    
                              readAddr17_xhdl380 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr16_xhdl379 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr15_xhdl378 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr14_xhdl377 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr13_xhdl376 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr12_xhdl375 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr11_xhdl374 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr10_xhdl373 := readAddr(9 DOWNTO 0)
                              ;    
                              readAddr9_xhdl372 := readAddr(9 DOWNTO 0); 
                              readAddr8_xhdl371 := readAddr(9 DOWNTO 0); 
                              readAddr7_xhdl370 := readAddr(9 DOWNTO 0); 
                              readAddr6_xhdl369 := readAddr(9 DOWNTO 0); 
                              readAddr5_xhdl368 := readAddr(9 DOWNTO 0); 
                              readAddr4_xhdl367 := readAddr(9 DOWNTO 0); 
                              readAddr3_xhdl366 := readAddr(9 DOWNTO 0); 
                              readAddr2_xhdl365 := readAddr(9 DOWNTO 0); 
                              readAddr1_xhdl364 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              readAddr0_xhdl363 := readAddr(7 DOWNTO 0) 
                              & "00";    
                              writeData17_xhdl236 := "00000000000000000" 
                              & writeData(7);    
                              writeData16_xhdl235 := "00000000000000000" 
                              & writeData(6);    
                              writeData15_xhdl234 := "00000000000000000" 
                              & writeData(5);    
                              writeData14_xhdl233 := "00000000000000000" 
                              & writeData(4);    
                              writeData13_xhdl232 := "00000000000000000" 
                              & writeData(3);    
                              writeData12_xhdl231 := "00000000000000000" 
                              & writeData(2);    
                              writeData11_xhdl230 := "00000000000000000" 
                              & writeData(1);    
                              writeData10_xhdl229 := "00000000000000000" 
                              & writeData(0);    
                              writeData9_xhdl228 := "00000000000000000" 
                              & writeData(7);    
                              writeData8_xhdl227 := "00000000000000000" 
                              & writeData(6);    
                              writeData7_xhdl226 := "00000000000000000" 
                              & writeData(5);    
                              writeData6_xhdl225 := "00000000000000000" 
                              & writeData(4);    
                              writeData5_xhdl224 := "00000000000000000" 
                              & writeData(3);    
                              writeData4_xhdl223 := "00000000000000000" 
                              & writeData(2);    
                              writeData3_xhdl222 := "00000000000000000" 
                              & writeData(1);    
                              writeData2_xhdl221 := "00000000000000000" 
                              & writeData(0);    
                              writeData1_xhdl220 := "00000000000000" & 
                              writeData(7 DOWNTO 4);    
                              writeData0_xhdl219 := "00000000000000" & 
                              writeData(3 DOWNTO 0);    
                              CASE writeAddr(11 DOWNTO 6) IS
                                 WHEN "000000" |
                                      "000001" |
                                      "000010" |
                                      "000011" |
                                      "000100" |
                                      "000101" |
                                      "000110" |
                                      "000111" |
                                      "001000" |
                                      "001001" |
                                      "001010" |
                                      "001011" |
                                      "001100" |
                                      "001101" |
                                      "001110" |
                                      "001111" =>
                                          wen_a17_xhdl92 := wen;    
                                          wen_a16_xhdl91 := wen;    
                                          wen_a15_xhdl90 := wen;    
                                          wen_a14_xhdl89 := wen;    
                                          wen_a13_xhdl88 := wen;    
                                          wen_a12_xhdl87 := wen;    
                                          wen_a11_xhdl86 := wen;    
                                          wen_a10_xhdl85 := wen;    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "010000" |
                                      "010001" |
                                      "010010" |
                                      "010011" |
                                      "010100" |
                                      "010101" |
                                      "010110" |
                                      "010111" |
                                      "011000" |
                                      "011001" |
                                      "011010" |
                                      "011011" |
                                      "011100" |
                                      "011101" |
                                      "011110" |
                                      "011111" =>
                                          wen_a17_xhdl92 := '0';    
                                          wen_a16_xhdl91 := '0';    
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := wen;    
                                          wen_a8_xhdl83 := wen;    
                                          wen_a7_xhdl82 := wen;    
                                          wen_a6_xhdl81 := wen;    
                                          wen_a5_xhdl80 := wen;    
                                          wen_a4_xhdl79 := wen;    
                                          wen_a3_xhdl78 := wen;    
                                          wen_a2_xhdl77 := wen;    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 WHEN "100000" |
                                      "100001" |
                                      "100010" |
                                      "100011" =>
                                          wen_a17_xhdl92 := '0';    
                                          wen_a16_xhdl91 := '0';    
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := wen;    
                                          wen_a0_xhdl75 := wen;    
                                 WHEN OTHERS  =>
                                          wen_a17_xhdl92 := '0';    
                                          wen_a16_xhdl91 := '0';    
                                          wen_a15_xhdl90 := '0';    
                                          wen_a14_xhdl89 := '0';    
                                          wen_a13_xhdl88 := '0';    
                                          wen_a12_xhdl87 := '0';    
                                          wen_a11_xhdl86 := '0';    
                                          wen_a10_xhdl85 := '0';    
                                          wen_a9_xhdl84 := '0';    
                                          wen_a8_xhdl83 := '0';    
                                          wen_a7_xhdl82 := '0';    
                                          wen_a6_xhdl81 := '0';    
                                          wen_a5_xhdl80 := '0';    
                                          wen_a4_xhdl79 := '0';    
                                          wen_a3_xhdl78 := '0';    
                                          wen_a2_xhdl77 := '0';    
                                          wen_a1_xhdl76 := '0';    
                                          wen_a0_xhdl75 := '0';    
                                 
                              END CASE;
                              CASE ckRdAddr(11 DOWNTO 6) IS
                                 WHEN "000000" |
                                      "000001" |
                                      "000010" |
                                      "000011" |
                                      "000100" |
                                      "000101" |
                                      "000110" |
                                      "000111" |
                                      "001000" |
                                      "001001" |
                                      "001010" |
                                      "001011" |
                                      "001100" |
                                      "001101" |
                                      "001110" |
                                      "001111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData17(0) & 
                                          readData16(0) & readData15(0) 
                                          & readData14(0) & readData13(0)
                                          & readData12(0) & readData11(0)
                                          & readData10(0);    
                                 WHEN "010000" |
                                      "010001" |
                                      "010010" |
                                      "010011" |
                                      "010100" |
                                      "010101" |
                                      "010110" |
                                      "010111" |
                                      "011000" |
                                      "011001" |
                                      "011010" |
                                      "011011" |
                                      "011100" |
                                      "011101" |
                                      "011110" |
                                      "011111" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData9(0) & 
                                          readData8(0) & readData7(0) & 
                                          readData6(0) & readData5(0) & 
                                          readData4(0) & readData3(0) & 
                                          readData2(0);    
                                 WHEN "100000" |
                                      "100001" |
                                      "100010" |
                                      "100011" =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          readData1(3 
                                          DOWNTO 0) & readData0(3 DOWNTO 
                                          0);    
                                 WHEN OTHERS  =>
                                          readData_xhdl1_xhdl437_w8 := 
                                          (OTHERS => '0');    
                                 
                              END CASE;

                     WHEN OTHERS =>
                              NULL;
                     
        	     END CASE;
--      END IF;
      -- if (ahbsram_size == 3'b000)
      
      width0 <= width0_xhdl3;
      width1 <= width1_xhdl4;
      width2 <= width2_xhdl5;
      width3 <= width3_xhdl6;
      width4 <= width4_xhdl7;
      width5 <= width5_xhdl8;
      width6 <= width6_xhdl9;
      width7 <= width7_xhdl10;
      width8 <= width8_xhdl11;
      width9 <= width9_xhdl12;
      width10 <= width10_xhdl13;
      width11 <= width11_xhdl14;
      width12 <= width12_xhdl15;
      width13 <= width13_xhdl16;
      width14 <= width14_xhdl17;
      width15 <= width15_xhdl18;
      width16 <= width16_xhdl19;      width17 <= width17_xhdl20;
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
      wen_a16 <= wen_a16_xhdl91;      wen_a17 <= wen_a17_xhdl92;
      wen_b0 <= wen_b0_xhdl147;
      wen_b1 <= wen_b1_xhdl148;
      wen_b2 <= wen_b2_xhdl149;
      wen_b3 <= wen_b3_xhdl150;
      wen_b4 <= wen_b4_xhdl151;
      wen_b5 <= wen_b5_xhdl152;
      wen_b6 <= wen_b6_xhdl153;
      wen_b7 <= wen_b7_xhdl154;
      wen_b8 <= wen_b8_xhdl155;
      wen_b9 <= wen_b9_xhdl156;
      wen_b10 <= wen_b10_xhdl157;
      wen_b11 <= wen_b11_xhdl158;
      wen_b12 <= wen_b12_xhdl159;
      wen_b13 <= wen_b13_xhdl160;
      wen_b14 <= wen_b14_xhdl161;
      wen_b15 <= wen_b15_xhdl162;
      wen_b16 <= wen_b16_xhdl163;
      writeData0 <= writeData0_xhdl219;
      writeData1 <= writeData1_xhdl220;
      writeData2 <= writeData2_xhdl221;
      writeData3 <= writeData3_xhdl222;
      writeData4 <= writeData4_xhdl223;
      writeData5 <= writeData5_xhdl224;
      writeData6 <= writeData6_xhdl225;
      writeData7 <= writeData7_xhdl226;
      writeData8 <= writeData8_xhdl227;
      writeData9 <= writeData9_xhdl228;
      writeData10 <= writeData10_xhdl229;
      writeData11 <= writeData11_xhdl230;
      writeData12 <= writeData12_xhdl231;
      writeData13 <= writeData13_xhdl232;
      writeData14 <= writeData14_xhdl233;
      writeData15 <= writeData15_xhdl234;
      writeData16 <= writeData16_xhdl235;      writeData17 <= writeData17_xhdl236;
      writeAddr0 <= writeAddr0_xhdl291;
      writeAddr1 <= writeAddr1_xhdl292;
      writeAddr2 <= writeAddr2_xhdl293;
      writeAddr3 <= writeAddr3_xhdl294;
      writeAddr4 <= writeAddr4_xhdl295;
      writeAddr5 <= writeAddr5_xhdl296;
      writeAddr6 <= writeAddr6_xhdl297;
      writeAddr7 <= writeAddr7_xhdl298;
      writeAddr8 <= writeAddr8_xhdl299;
      writeAddr9 <= writeAddr9_xhdl300;
      writeAddr10 <= writeAddr10_xhdl301;
      writeAddr11 <= writeAddr11_xhdl302;
      writeAddr12 <= writeAddr12_xhdl303;
      writeAddr13 <= writeAddr13_xhdl304;
      writeAddr14 <= writeAddr14_xhdl305;
      writeAddr15 <= writeAddr15_xhdl306;
      writeAddr16 <= writeAddr16_xhdl307;      writeAddr17 <= writeAddr17_xhdl308;
      readAddr0 <= readAddr0_xhdl363;
      readAddr1 <= readAddr1_xhdl364;
      readAddr2 <= readAddr2_xhdl365;
      readAddr3 <= readAddr3_xhdl366;
      readAddr4 <= readAddr4_xhdl367;
      readAddr5 <= readAddr5_xhdl368;
      readAddr6 <= readAddr6_xhdl369;
      readAddr7 <= readAddr7_xhdl370;
      readAddr8 <= readAddr8_xhdl371;
      readAddr9 <= readAddr9_xhdl372;
      readAddr10 <= readAddr10_xhdl373;
      readAddr11 <= readAddr11_xhdl374;
      readAddr12 <= readAddr12_xhdl375;
      readAddr13 <= readAddr13_xhdl376;
      readAddr14 <= readAddr14_xhdl377;
      readAddr15 <= readAddr15_xhdl378;
      readAddr16 <= readAddr16_xhdl379;      readAddr17 <= readAddr17_xhdl380;
      ablk <= ablk_xhdl435;
      bblk <= bblk_xhdl436;

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
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr17,
         B_ADDR => readAddr17,
         A_WIDTH => width17,
         B_WIDTH => width17,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr17,
         C_DIN => writeData17,
         C_WEN => wen_a17,
         C_BLK => "11",
         C_WIDTH => width17,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_17);   
      
   block_16 : RAM64x18 
      PORT MAP (
         A_DOUT => readData16,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr16,
         B_ADDR => readAddr16,
         A_WIDTH => width16,
         B_WIDTH => width16,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr16,
         C_DIN => writeData16,
         C_WEN => wen_a16,
         C_BLK => "11",
         C_WIDTH => width16,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_16);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_15 : RAM64x18 
      PORT MAP (
         A_DOUT => readData15,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr15,
         B_ADDR => readAddr15,
         A_WIDTH => width15,
         B_WIDTH => width15,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr15,
         C_DIN => writeData15,
         C_WEN => wen_a15,
         C_BLK => "11",
         C_WIDTH => width15,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_15);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_14 : RAM64x18 
      PORT MAP (
         A_DOUT => readData14,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr14,
         B_ADDR => readAddr14,
         A_WIDTH => width14,
         B_WIDTH => width14,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr14,
         C_DIN => writeData14,
         C_WEN => wen_a14,
         C_BLK => "11",
         C_WIDTH => width14,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_14);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_13 : RAM64x18 
      PORT MAP (
         A_DOUT => readData13,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr13,
         B_ADDR => readAddr13,
         A_WIDTH => width13,
         B_WIDTH => width13,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr13,
         C_DIN => writeData13,
         C_WEN => wen_a13,
         C_BLK => "11",
         C_WIDTH => width13,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_13);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_12 : RAM64x18 
      PORT MAP (
         A_DOUT => readData12,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr12,
         B_ADDR => readAddr12,
         A_WIDTH => width12,
         B_WIDTH => width12,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr12,
         C_DIN => writeData12,
         C_WEN => wen_a12,
         C_BLK => "11",
         C_WIDTH => width12,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_12);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_11 : RAM64x18 
      PORT MAP (
         A_DOUT => readData11,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr11,
         B_ADDR => readAddr11,
         A_WIDTH => width11,
         B_WIDTH => width11,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr11,
         C_DIN => writeData11,
         C_WEN => wen_a11,
         C_BLK => "11",
         C_WIDTH => width11,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_11);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_10 : RAM64x18 
      PORT MAP (
         A_DOUT => readData10,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr10,
         B_ADDR => readAddr10,
         A_WIDTH => width10,
         B_WIDTH => width10,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr10,
         C_DIN => writeData10,
         C_WEN => wen_a10,
         C_BLK => "11",
         C_WIDTH => width10,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_10);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_9 : RAM64x18 
      PORT MAP (
         A_DOUT => readData9,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr9,
         B_ADDR => readAddr9,
         A_WIDTH => width9,
         B_WIDTH => width9,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr9,
         C_DIN => writeData9,
         C_WEN => wen_a9,
         C_BLK => "11",
         C_WIDTH => width9,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_9);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_8 : RAM64x18 
      PORT MAP (
         A_DOUT => readData8,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr8,
         B_ADDR => readAddr8,
         A_WIDTH => width8,
         B_WIDTH => width8,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr8,
         C_DIN => writeData8,
         C_WEN => wen_a8,
         C_BLK => "11",
         C_WIDTH => width8,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_8);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_7 : RAM64x18 
      PORT MAP (
         A_DOUT => readData7,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr7,
         B_ADDR => readAddr7,
         A_WIDTH => width7,
         B_WIDTH => width7,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr7,
         C_DIN => writeData7,
         C_WEN => wen_a7,
         C_BLK => "11",
         C_WIDTH => width7,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_7);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_6 : RAM64x18 
      PORT MAP (
         A_DOUT => readData6,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr6,
         B_ADDR => readAddr6,
         A_WIDTH => width6,
         B_WIDTH => width6,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr6,
         C_DIN => writeData6,
         C_WEN => wen_a6,
         C_BLK => "11",
         C_WIDTH => width6,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_6);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_5 : RAM64x18 
      PORT MAP (
         A_DOUT => readData5,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr5,
         B_ADDR => readAddr5,
         A_WIDTH => width5,
         B_WIDTH => width5,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr5,
         C_DIN => writeData5,
         C_WEN => wen_a5,
         C_BLK => "11",
         C_WIDTH => width5,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_5);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_4 : RAM64x18 
      PORT MAP (
         A_DOUT => readData4,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr4,
         B_ADDR => readAddr4,
         A_WIDTH => width4,
         B_WIDTH => width4,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr4,
         C_DIN => writeData4,
         C_WEN => wen_a4,
         C_BLK => "11",
         C_WIDTH => width4,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_4);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_3 : RAM64x18 
      PORT MAP (
         A_DOUT => readData3,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr3,
         B_ADDR => readAddr3,
         A_WIDTH => width3,
         B_WIDTH => width3,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr3,
         C_DIN => writeData3,
         C_WEN => wen_a3,
         C_BLK => "11",
         C_WIDTH => width3,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_3);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_2 : RAM64x18 
      PORT MAP (
         A_DOUT => readData2,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr2,
         B_ADDR => readAddr2,
         A_WIDTH => width2,
         B_WIDTH => width2,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr2,
         C_DIN => writeData2,
         C_WEN => wen_a2,
         C_BLK => "11",
         C_WIDTH => width2,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_2);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_1 : RAM64x18 
      PORT MAP (
         A_DOUT => readData1,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr1,
         B_ADDR => readAddr1,
         A_WIDTH => width1,
         B_WIDTH => width1,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr1,
         C_DIN => writeData1,
         C_WEN => wen_a1,
         C_BLK => "11",
         C_WIDTH => width1,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_1);   
   
   
   --                    .A_BLK(2'b11),                 .B_BLK(2'b11),
   block_0 : RAM64x18 
      PORT MAP (
         A_DOUT => readData0,
         B_DOUT => open,
         A_ADDR_CLK => clk,
         B_ADDR_CLK => clk,
         A_ADDR_EN => '1',
         B_ADDR_EN => '1',
         A_ADDR_LAT => '1',
         B_ADDR_LAT => '1',
         A_ADDR_ARST_N => resetn,
         B_ADDR_ARST_N => resetn,
         A_ADDR_SRST_N => '1',
         B_ADDR_SRST_N => '1',
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_DOUT_ARST_N => resetn,
         B_DOUT_ARST_N => resetn,
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_ADDR => readAddr0,
         B_ADDR => readAddr0,
         A_WIDTH => width0,
         B_WIDTH => width0,
         A_BLK => ablk,
         B_BLK => bblk,
         A_EN => '1',
         B_EN => '1',
         C_CLK => clk,
         C_ADDR => writeAddr0,
         C_DIN => writeData0,
         C_WEN => wen_a0,
         C_BLK => "11",
         C_WIDTH => width0,
         C_EN => '1',
         SII_LOCK => '0',
         BUSY => u_BUSY_0);   
   
   u_9K_BUSY_all_xhdl2 <= u_BUSY_0 OR u_BUSY_1 OR u_BUSY_2 OR u_BUSY_3 OR 
   u_BUSY_4 OR u_BUSY_5 OR u_BUSY_6 OR u_BUSY_7 OR u_BUSY_8 OR u_BUSY_9 
   OR u_BUSY_10 OR u_BUSY_11 OR u_BUSY_12 OR u_BUSY_13 OR u_BUSY_14 OR 
   u_BUSY_15 OR u_BUSY_16 OR u_BUSY_17 ;

END ARCHITECTURE translated;
