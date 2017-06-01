-- ********************************************************************/
-- Actel Corporation Proprietary and Confidential
--  Copyright 2011 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:  SRAM block, 1 byte wide, 2048 to 141312 deep 
--              (in steps of 2048), used to construct the memory.
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

ENTITY sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 IS
   GENERIC (
      -- ---------------------------------------------------------------------
      -- Parameters
      -- ---------------------------------------------------------------------
      -- DEPTH can range from 2048 to 141312, in steps of 2048
      DEPTH                          :  integer := 2048);    
   PORT (
      -- ---------------------------------------------------------------------
-- Port declarations
-- ---------------------------------------------------------------------
-- AhbFabric interface
-- Inputs

      writeData               : IN std_logic_vector(7 DOWNTO 0);   
      -- Output

      readData                : OUT std_logic_vector(7 DOWNTO 0);   
      -- AhbSramIf interface
-- Inputs

      wen                     : IN std_logic;   
      ren                     : IN std_logic;   
      writeAddr               : IN std_logic_vector(15 DOWNTO 0);   
      readAddr                : IN std_logic_vector(15 DOWNTO 0);   
      clk                     : IN std_logic;   
      resetn                  : IN std_logic;   
      l_BUSY_all       : OUT std_logic);   
END ENTITY sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8;

ARCHITECTURE translated OF sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 IS
   COMPONENT RAM1K18 
      PORT (
         A_DOUT               : OUT std_logic_vector(17 DOWNTO 0); 
         B_DOUT               : OUT std_logic_vector(17 DOWNTO 0); 
         A_CLK                : IN std_logic;
         B_CLK                : IN std_logic; 
         A_ARST_N                : IN std_logic; 
         B_ARST_N                 : IN std_logic;
         A_BLK              : IN std_logic_vector(2 DOWNTO 0);
         B_BLK              : IN std_logic_vector(2 DOWNTO 0);
         A_DIN              : IN std_logic_vector(17 DOWNTO 0);
         B_DIN              : IN std_logic_vector(17 DOWNTO 0);
         A_ADDR              : IN std_logic_vector(13 DOWNTO 0);
         B_ADDR              : IN std_logic_vector(13 DOWNTO 0);
         A_WEN              : IN std_logic_vector(1 DOWNTO 0);
         B_WEN              : IN std_logic_vector(1 DOWNTO 0);
         A_DOUT_CLK                : IN std_logic;
         B_DOUT_CLK                : IN std_logic;
         A_DOUT_EN                : IN std_logic;
         B_DOUT_EN                : IN std_logic;
         A_DOUT_ARST_N                : IN std_logic;
         B_DOUT_ARST_N                : IN std_logic;
         A_DOUT_SRST_N                : IN std_logic;
         B_DOUT_SRST_N                : IN std_logic;
         A_DOUT_LAT                : IN std_logic;
         B_DOUT_LAT                : IN std_logic;
         A_WIDTH              : IN std_logic_vector(2 DOWNTO 0);
         B_WIDTH              : IN std_logic_vector(2 DOWNTO 0);
         A_WMODE                : IN std_logic;
         B_WMODE                : IN std_logic;
         A_EN                : IN std_logic;
         B_EN                : IN std_logic;
         BUSY                : OUT std_logic;
         SII_LOCK                : IN std_logic);
  END COMPONENT;    


   -- ---------------------------------------------------------------------
   -- Constant declarations
   -- ---------------------------------------------------------------------
   -- ---------------------------------------------------------------------
   -- Signal declarations
   -- ---------------------------------------------------------------------
   SIGNAL ckRdAddr                 :  std_logic_vector(15 DOWNTO 9);   
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
   SIGNAL width16                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL width17                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL wen_a0                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a1                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a2                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a3                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a4                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a5                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a6                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a7                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a8                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a9                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a10                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a11                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a12                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a13                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a14                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a15                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a16                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_a17                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b0                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b1                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b2                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b3                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b4                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b5                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b6                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b7                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b8                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b9                   :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b10                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b11                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b12                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b13                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b14                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b15                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b16                  :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL wen_b17                  :  std_logic_vector(1 DOWNTO 0);   
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
   SIGNAL writeData16              :  std_logic_vector(17 DOWNTO 0);   
   SIGNAL writeData17              :  std_logic_vector(17 DOWNTO 0);   
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
   SIGNAL writeAddr0               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr1               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr2               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr3               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr4               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr5               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr6               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr7               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr8               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr9               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr10              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr11              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr12              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr13              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr14              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr15              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr16              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL writeAddr17              :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr0                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr1                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr2                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr3                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr4                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr5                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr6                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr7                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr8                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr9                :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr10               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr11               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr12               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr13               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr14               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr15               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr16               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL readAddr17               :  std_logic_vector(13 DOWNTO 0);   
   SIGNAL lsram_2k_BUSY_17         :  std_logic;   
   SIGNAL lsram_2k_BUSY_16         :  std_logic;   
   SIGNAL lsram_2k_BUSY_15         :  std_logic;   
   SIGNAL lsram_2k_BUSY_14         :  std_logic;   
   SIGNAL lsram_2k_BUSY_13         :  std_logic;   
   SIGNAL lsram_2k_BUSY_12         :  std_logic;   
   SIGNAL lsram_2k_BUSY_11         :  std_logic;   
   SIGNAL lsram_2k_BUSY_10         :  std_logic;   
   SIGNAL lsram_2k_BUSY_9          :  std_logic;   
   SIGNAL lsram_2k_BUSY_8          :  std_logic;   
   SIGNAL lsram_2k_BUSY_7          :  std_logic;   
   SIGNAL lsram_2k_BUSY_6          :  std_logic;   
   SIGNAL lsram_2k_BUSY_5          :  std_logic;   
   SIGNAL lsram_2k_BUSY_4          :  std_logic;   
   SIGNAL lsram_2k_BUSY_3          :  std_logic;   
   SIGNAL lsram_2k_BUSY_2          :  std_logic;   
   SIGNAL lsram_2k_BUSY_1          :  std_logic;   
   SIGNAL lsram_2k_BUSY_0          :  std_logic;   
   SIGNAL readData_xhdl1           :  std_logic_vector(7 DOWNTO 0);   
   SIGNAL lsram_2k_BUSY_all_xhdl2  :  std_logic;   

BEGIN
   readData <= readData_xhdl1;
   l_BUSY_all <= lsram_2k_BUSY_all_xhdl2;

   ------------------------------------------------------------------------
   -- Main body of code
   ------------------------------------------------------------------------
   
   PROCESS (clk, resetn)
   BEGIN
      IF (NOT resetn = '1') THEN
         ckRdAddr(15 DOWNTO 9) <= "0000000";    
      ELSIF (clk'EVENT AND clk = '1') THEN
         ckRdAddr(15 DOWNTO 9) <= readAddr(15 DOWNTO 9);    
      END IF;
   END PROCESS;

   ------------------------------------------------------------------------------------------
   -- Assign values to various signals based on DEPTH and RAM4K9_WIDTH settings.
   -- Default is to build the (byte wide) memory from RAM blocks which are configured to
   -- be tall and narrow.
   ------------------------------------------------------------------------------------------
   
   PROCESS (clk, writeData, resetn, ckRdAddr, readAddr, 
   readData10, readData11, readData12, readData13, readData14, readData15, wen, readData16, readData17, 
   readData0, readData1, readData2, readData3, readData4, 
   readData5, readData6, readData7, readData8, 
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
      VARIABLE width16_xhdl19  : std_logic_vector(2 DOWNTO 0);
      VARIABLE width17_xhdl20  : std_logic_vector(2 DOWNTO 0);
      VARIABLE wen_a0_xhdl72  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a1_xhdl73  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a2_xhdl74  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a3_xhdl75  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a4_xhdl76  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a5_xhdl77  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a6_xhdl78  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a7_xhdl79  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a8_xhdl80  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a9_xhdl81  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a10_xhdl82  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a11_xhdl83  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a12_xhdl84  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a13_xhdl85  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a14_xhdl86  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a15_xhdl87  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a16_xhdl88  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_a17_xhdl89  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b0_xhdl141  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b1_xhdl142  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b2_xhdl143  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b3_xhdl144  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b4_xhdl145  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b5_xhdl146  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b6_xhdl147  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b7_xhdl148  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b8_xhdl149  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b9_xhdl150  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b10_xhdl151  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b11_xhdl152  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b12_xhdl153  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b13_xhdl154  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b14_xhdl155  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b15_xhdl156  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b16_xhdl157  : std_logic_vector(1 DOWNTO 0);
      VARIABLE wen_b17_xhdl158  : std_logic_vector(1 DOWNTO 0);
      VARIABLE writeData0_xhdl210  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData1_xhdl211  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData2_xhdl212  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData3_xhdl213  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData4_xhdl214  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData5_xhdl215  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData6_xhdl216  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData7_xhdl217  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData8_xhdl218  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData9_xhdl219  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData10_xhdl220  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData11_xhdl221  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData12_xhdl222  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData13_xhdl223  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData14_xhdl224  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData15_xhdl225  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData16_xhdl226  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeData17_xhdl227  : std_logic_vector(17 DOWNTO 0);
      VARIABLE writeAddr0_xhdl279  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr1_xhdl280  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr2_xhdl281  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr3_xhdl282  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr4_xhdl283  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr5_xhdl284  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr6_xhdl285  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr7_xhdl286  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr8_xhdl287  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr9_xhdl288  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr10_xhdl289  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr11_xhdl290  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr12_xhdl291  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr13_xhdl292  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr14_xhdl293  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr15_xhdl294  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr16_xhdl295  : std_logic_vector(13 DOWNTO 0);
      VARIABLE writeAddr17_xhdl296  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr0_xhdl348  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr1_xhdl349  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr2_xhdl350  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr3_xhdl351  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr4_xhdl352  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr5_xhdl353  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr6_xhdl354  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr7_xhdl355  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr8_xhdl356  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr9_xhdl357  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr10_xhdl358  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr11_xhdl359  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr12_xhdl360  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr13_xhdl361  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr14_xhdl362  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr15_xhdl363  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr16_xhdl364  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readAddr17_xhdl365  : std_logic_vector(13 DOWNTO 0);
      VARIABLE readData_xhdl1_xhdl417  : std_logic_vector(7 DOWNTO 0);
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
      width16_xhdl19 := "000";    
      width17_xhdl20 := "000";    
      wen_a0_xhdl72 := "00";    
      wen_a1_xhdl73 := "00";    
      wen_a2_xhdl74 := "00";    
      wen_a3_xhdl75 := "00";    
      wen_a4_xhdl76 := "00";    
      wen_a5_xhdl77 := "00";    
      wen_a6_xhdl78 := "00";    
      wen_a7_xhdl79 := "00";    
      wen_a8_xhdl80 := "00";    
      wen_a9_xhdl81 := "00";    
      wen_a10_xhdl82 := "00";    
      wen_a11_xhdl83 := "00";    
      wen_a12_xhdl84 := "00";    
      wen_a13_xhdl85 := "00";    
      wen_a14_xhdl86 := "00";    
      wen_a15_xhdl87 := "00";    
      wen_a16_xhdl88 := "00";    
      wen_a17_xhdl89 := "00";    
      wen_b0_xhdl141 := "00";    
      wen_b1_xhdl142 := "00";    
      wen_b2_xhdl143 := "00";    
      wen_b3_xhdl144 := "00";    
      wen_b4_xhdl145 := "00";    
      wen_b5_xhdl146 := "00";    
      wen_b6_xhdl147 := "00";    
      wen_b7_xhdl148 := "00";    
      wen_b8_xhdl149 := "00";    
      wen_b9_xhdl150 := "00";    
      wen_b10_xhdl151 := "00";    
      wen_b11_xhdl152 := "00";    
      wen_b12_xhdl153 := "00";    
      wen_b13_xhdl154 := "00";    
      wen_b14_xhdl155 := "00";    
      wen_b15_xhdl156 := "00";    
      wen_b16_xhdl157 := "00";    
      wen_b17_xhdl158 := "00";    
      writeData0_xhdl210 := "000000000000000000";    
      writeData1_xhdl211 := "000000000000000000";    
      writeData2_xhdl212 := "000000000000000000";    
      writeData3_xhdl213 := "000000000000000000";    
      writeData4_xhdl214 := "000000000000000000";    
      writeData5_xhdl215 := "000000000000000000";    
      writeData6_xhdl216 := "000000000000000000";    
      writeData7_xhdl217 := "000000000000000000";    
      writeData8_xhdl218 := "000000000000000000";    
      writeData9_xhdl219 := "000000000000000000";    
      writeData10_xhdl220 := "000000000000000000";    
      writeData11_xhdl221 := "000000000000000000";    
      writeData12_xhdl222 := "000000000000000000";    
      writeData13_xhdl223 := "000000000000000000";    
      writeData14_xhdl224 := "000000000000000000";    
      writeData15_xhdl225 := "000000000000000000";    
      writeData16_xhdl226 := "000000000000000000";    
      writeData17_xhdl227 := "000000000000000000";    
      writeAddr0_xhdl279 := "00000000000000";    
      writeAddr1_xhdl280 := "00000000000000";    
      writeAddr2_xhdl281 := "00000000000000";    
      writeAddr3_xhdl282 := "00000000000000";    
      writeAddr4_xhdl283 := "00000000000000";    
      writeAddr5_xhdl284 := "00000000000000";    
      writeAddr6_xhdl285 := "00000000000000";    
      writeAddr7_xhdl286 := "00000000000000";    
      writeAddr8_xhdl287 := "00000000000000";    
      writeAddr9_xhdl288 := "00000000000000";    
      writeAddr10_xhdl289 := "00000000000000";    
      writeAddr11_xhdl290 := "00000000000000";    
      writeAddr12_xhdl291 := "00000000000000";    
      writeAddr13_xhdl292 := "00000000000000";    
      writeAddr14_xhdl293 := "00000000000000";    
      writeAddr15_xhdl294 := "00000000000000";    
      writeAddr16_xhdl295 := "00000000000000";    
      writeAddr17_xhdl296 := "00000000000000";    
      readAddr0_xhdl348 := "00000000000000";    
      readAddr1_xhdl349 := "00000000000000";    
      readAddr2_xhdl350 := "00000000000000";    
      readAddr3_xhdl351 := "00000000000000";    
      readAddr4_xhdl352 := "00000000000000";    
      readAddr5_xhdl353 := "00000000000000";    
      readAddr6_xhdl354 := "00000000000000";    
      readAddr7_xhdl355 := "00000000000000";    
      readAddr8_xhdl356 := "00000000000000";    
      readAddr9_xhdl357 := "00000000000000";    
      readAddr10_xhdl358 := "00000000000000";    
      readAddr11_xhdl359 := "00000000000000";    
      readAddr12_xhdl360 := "00000000000000";    
      readAddr13_xhdl361 := "00000000000000";    
      readAddr14_xhdl362 := "00000000000000";    
      readAddr15_xhdl363 := "00000000000000";    
      readAddr16_xhdl364 := "00000000000000";    
      readAddr17_xhdl365 := "00000000000000";    
      readData_xhdl1_xhdl417 := (OTHERS => '0');    
      CASE DEPTH IS
         WHEN 512 | 1024 | 1536 | 2048 =>
                  width1_xhdl4 := "011";    
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  wen_a1_xhdl73 := '0' & wen;    
                  readData_xhdl1_xhdl417 := readData1(7 DOWNTO 0);    
         WHEN 2560 |3072 |3584 |4096 =>
                  width1_xhdl4 := "011";    
                  width0_xhdl3 := "011";    
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr0_xhdl279 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr0_xhdl348 := readAddr(10 DOWNTO 0) & "000";    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData0_xhdl210 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  CASE writeAddr(13 DOWNTO 10) IS
                     WHEN "0000" |
                          "0001" =>
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN "0010" |
                          "0011" =>
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN OTHERS  =>
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:12])
                  
                  CASE ckRdAddr(13 DOWNTO 10) IS
                     WHEN "0000" |
                          "0001" =>
                              readData_xhdl1_xhdl417 := readData0(7 
                              DOWNTO 0);    
                     WHEN "0010" |
                          "0011" =>
                              readData_xhdl1_xhdl417 := readData1(7 
                              DOWNTO 0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (ckRdAddr[13:12])               
                  
                  
         WHEN 4608 | 5120 | 5632 | 6144 =>
                  width2_xhdl5 := "011";    
                  width1_xhdl4 := "011";    
                  width0_xhdl3 := "011";    
                  writeAddr2_xhdl281 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr0_xhdl279 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr2_xhdl350 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr0_xhdl348 := readAddr(10 DOWNTO 0) & "000";    
                  writeData2_xhdl212 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData0_xhdl210 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  CASE writeAddr(13 DOWNTO 10) IS
                     WHEN "0000" |
                          "0001" =>
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN "0010" |
                          "0011" =>
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0100" |
                          "0101" =>
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN OTHERS  =>
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:12])
                  
                  CASE ckRdAddr(13 DOWNTO 10) IS
                     WHEN "0000" |
                          "0001" =>
                              readData_xhdl1_xhdl417 := readData0(7 
                              DOWNTO 0);    
                     WHEN "0010" |
                          "0011" =>
                              readData_xhdl1_xhdl417 := readData1(7 
                              DOWNTO 0);    
                     WHEN "0100" |
                          "0101" =>
                              readData_xhdl1_xhdl417 := readData2(7 
                              DOWNTO 0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:12])
                  
                  
         WHEN 6656 | 7168 | 7680 | 8192 =>
                  width3_xhdl6 := "011";    
                  width2_xhdl5 := "011";    
                  width1_xhdl4 := "011";    
                  width0_xhdl3 := "011";    
                  writeAddr3_xhdl282 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr2_xhdl281 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr0_xhdl279 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr3_xhdl351 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr2_xhdl350 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr0_xhdl348 := readAddr(10 DOWNTO 0) & "000";    
                  writeData3_xhdl213 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData2_xhdl212 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData0_xhdl210 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  CASE writeAddr(13 DOWNTO 10) IS
                     WHEN "0110" |
                          "0111" =>
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0100" |
                          "0101" =>
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0010" |
                          "0011" =>
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0000" |
                          "0001" =>
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:12])
                  
                  CASE ckRdAddr(13 DOWNTO 10) IS
                     WHEN "0110" |
                          "0111" =>
                              readData_xhdl1_xhdl417 := readData3(7 
                              DOWNTO 0);    
                     WHEN "0100" |
                          "0101" =>
                              readData_xhdl1_xhdl417 := readData2(7 
                              DOWNTO 0);    
                     WHEN "0010" |
                          "0011" =>
                              readData_xhdl1_xhdl417 := readData1(7 
                              DOWNTO 0);    
                     WHEN "0000" |
                          "0001" =>
                              readData_xhdl1_xhdl417 := readData0(7 
                              DOWNTO 0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:12])
                  
                  
         WHEN 8704 | 9216 | 9728 | 10240 =>
                  width4_xhdl7 := "011";    
                  width3_xhdl6 := "011";    
                  width2_xhdl5 := "011";    
                  width1_xhdl4 := "011";    
                  width0_xhdl3 := "011";    
                  writeAddr4_xhdl283 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr3_xhdl282 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr2_xhdl281 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr0_xhdl279 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr4_xhdl352 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr3_xhdl351 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr2_xhdl350 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr0_xhdl348 := readAddr(10 DOWNTO 0) & "000";    
                  writeData4_xhdl214 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData3_xhdl213 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData2_xhdl212 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData0_xhdl210 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  CASE writeAddr(13 DOWNTO 10) IS
                     WHEN "1000" |
                          "1001" =>
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0110" |
                          "0111" =>
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0100" |
                          "0101" =>
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0010" |
                          "0011" =>
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0000" |
                          "0001" =>
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  CASE ckRdAddr(13 DOWNTO 10) IS
                     WHEN "1000" |
                          "1001" =>
                              readData_xhdl1_xhdl417 := readData4(7 
                              DOWNTO 0);    
                     WHEN "0110" |
                          "0111" =>
                              readData_xhdl1_xhdl417 := readData3(7 
                              DOWNTO 0);    
                     WHEN "0100" |
                          "0101" =>
                              readData_xhdl1_xhdl417 := readData2(7 
                              DOWNTO 0);    
                     WHEN "0010" |
                          "0011" =>
                              readData_xhdl1_xhdl417 := readData1(7 
                              DOWNTO 0);    
                     WHEN "0000" |
                          "0001" =>
                              readData_xhdl1_xhdl417 := readData0(7 
                              DOWNTO 0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  
         WHEN 10752 | 11264 | 11776  | 12288 =>
                  width5_xhdl8 := "011";    
                  width4_xhdl7 := "011";    
                  width3_xhdl6 := "011";    
                  width2_xhdl5 := "011";    
                  width1_xhdl4 := "011";    
                  width0_xhdl3 := "011";    
                  writeAddr5_xhdl284 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr4_xhdl283 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr3_xhdl282 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr2_xhdl281 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr0_xhdl279 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr5_xhdl353 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr4_xhdl352 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr3_xhdl351 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr2_xhdl350 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr0_xhdl348 := readAddr(10 DOWNTO 0) & "000";    
                  writeData5_xhdl215 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData4_xhdl214 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData3_xhdl213 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData2_xhdl212 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData0_xhdl210 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  CASE writeAddr(13 DOWNTO 10) IS
                     WHEN "1010" |
                          "1011" =>
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "1000" |
                          "1001" =>
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0110" |
                          "0111" =>
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0100" |
                          "0101" =>
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0010" |
                          "0011" =>
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0000" |
                          "0001" =>
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  CASE ckRdAddr(13 DOWNTO 10) IS
                     WHEN "1010" |
                          "1011" =>
                              readData_xhdl1_xhdl417 := readData5(7 
                              DOWNTO 0);    
                     WHEN "1000" |
                          "1001" =>
                              readData_xhdl1_xhdl417 := readData4(7 
                              DOWNTO 0);    
                     WHEN "0110" |
                          "0111" =>
                              readData_xhdl1_xhdl417 := readData3(7 
                              DOWNTO 0);    
                     WHEN "0100" |
                          "0101" =>
                              readData_xhdl1_xhdl417 := readData2(7 
                              DOWNTO 0);    
                     WHEN "0010" |
                          "0011" =>
                              readData_xhdl1_xhdl417 := readData1(7 
                              DOWNTO 0);    
                     WHEN "0000" |
                          "0001" =>
                              readData_xhdl1_xhdl417 := readData0(7 
                              DOWNTO 0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  
         WHEN  12800 | 13312  | 13824  | 14336 =>
                  width6_xhdl9 := "011";    
                  width5_xhdl8 := "011";    
                  width4_xhdl7 := "011";    
                  width3_xhdl6 := "011";    
                  width2_xhdl5 := "011";    
                  width1_xhdl4 := "011";    
                  width0_xhdl3 := "011";    
                  writeAddr6_xhdl285 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr5_xhdl284 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr4_xhdl283 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr3_xhdl282 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr2_xhdl281 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr0_xhdl279 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr6_xhdl354 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr5_xhdl353 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr4_xhdl352 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr3_xhdl351 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr2_xhdl350 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr0_xhdl348 := readAddr(10 DOWNTO 0) & "000";    
                  writeData6_xhdl216 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData5_xhdl215 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData4_xhdl214 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData3_xhdl213 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData2_xhdl212 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData0_xhdl210 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  CASE writeAddr(13 DOWNTO 10) IS
                     WHEN "1100" |
                          "1101" =>
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "1010" |
                          "1011" =>
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "1000" |
                          "1001" =>
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0110" |
                          "0111" =>
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0100" |
                          "0101" =>
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0010" |
                          "0011" =>
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0000" |
                          "0001" =>
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  CASE ckRdAddr(13 DOWNTO 10) IS
                     WHEN "1100" |
                          "1101" =>
                              readData_xhdl1_xhdl417 := readData6(7 
                              DOWNTO 0);    
                     WHEN "1010" |
                          "1011" =>
                              readData_xhdl1_xhdl417 := readData5(7 
                              DOWNTO 0);    
                     WHEN "1000" |
                          "1001" =>
                              readData_xhdl1_xhdl417 := readData4(7 
                              DOWNTO 0);    
                     WHEN "0110" |
                          "0111" =>
                              readData_xhdl1_xhdl417 := readData3(7 
                              DOWNTO 0);    
                     WHEN "0100" |
                          "0101" =>
                              readData_xhdl1_xhdl417 := readData2(7 
                              DOWNTO 0);    
                     WHEN "0010" |
                          "0011" =>
                              readData_xhdl1_xhdl417 := readData1(7 
                              DOWNTO 0);    
                     WHEN "0000" |
                          "0001" =>
                              readData_xhdl1_xhdl417 := readData0(7 
                              DOWNTO 0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  
         WHEN 14848  | 15360 | 15872 | 16384 =>
                  width7_xhdl10 := "011";    
                  width6_xhdl9 := "011";    
                  width5_xhdl8 := "011";    
                  width4_xhdl7 := "011";    
                  width3_xhdl6 := "011";    
                  width2_xhdl5 := "011";    
                  width1_xhdl4 := "011";    
                  width0_xhdl3 := "011";    
                  writeAddr7_xhdl286 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr6_xhdl285 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr5_xhdl284 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr4_xhdl283 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr3_xhdl282 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr2_xhdl281 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr1_xhdl280 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr0_xhdl279 := writeAddr(10 DOWNTO 0) & "000";  
                  readAddr7_xhdl355 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr6_xhdl354 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr5_xhdl353 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr4_xhdl352 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr3_xhdl351 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr2_xhdl350 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr1_xhdl349 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr0_xhdl348 := readAddr(10 DOWNTO 0) & "000";    
                  writeData7_xhdl217 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData6_xhdl216 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData5_xhdl215 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData4_xhdl214 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData3_xhdl213 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData2_xhdl212 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData1_xhdl211 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData0_xhdl210 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  CASE writeAddr(13 DOWNTO 10) IS
                     WHEN "1110" |
                          "1111" =>
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "1100" |
                          "1101" =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "1010" |
                          "1011" =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "1000" |
                          "1001" =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0110" |
                          "0111" =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0100" |
                          "0101" =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0010" |
                          "0011" =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "0000" |
                          "0001" =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  CASE ckRdAddr(13 DOWNTO 10) IS
                     WHEN "1110" |
                          "1111" =>
                              readData_xhdl1_xhdl417 := readData7(7 
                              DOWNTO 0);    
                     WHEN "1100" |
                          "1101" =>
                              readData_xhdl1_xhdl417 := readData6(7 
                              DOWNTO 0);    
                     WHEN "1010" |
                          "1011" =>
                              readData_xhdl1_xhdl417 := readData5(7 
                              DOWNTO 0);    
                     WHEN "1000" |
                          "1001" =>
                              readData_xhdl1_xhdl417 := readData4(7 
                              DOWNTO 0);    
                     WHEN "0110" |
                          "0111" =>
                              readData_xhdl1_xhdl417 := readData3(7 
                              DOWNTO 0);    
                     WHEN "0100" |
                          "0101" =>
                              readData_xhdl1_xhdl417 := readData2(7 
                              DOWNTO 0);    
                     WHEN "0010" |
                          "0011" =>
                              readData_xhdl1_xhdl417 := readData1(7 
                              DOWNTO 0);    
                     WHEN "0000" |
                          "0001" =>
                              readData_xhdl1_xhdl417 := readData0(7 
                              DOWNTO 0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  
         WHEN 16896 | 17408 | 17920 | 18432 =>
                  width8_xhdl11 := "011";    
                  width7_xhdl10 := "000";    
                  width6_xhdl9 := "000";    
                  width5_xhdl8 := "000";    
                  width4_xhdl7 := "000";    
                  width3_xhdl6 := "000";    
                  width2_xhdl5 := "000";    
                  width1_xhdl4 := "000";    
                  width0_xhdl3 := "000";    
                  writeAddr8_xhdl287 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr8_xhdl356 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData8_xhdl218 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
                     WHEN "10000" |
                          "10001" =>
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
                     WHEN "10000" |
                          "10001" =>
                              readData_xhdl1_xhdl417 := readData8(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  
         WHEN 18944 | 19456 | 19968 | 20480 =>
                  width9_xhdl12 := "011";    
                  width8_xhdl11 := "011";    
                  width7_xhdl10 := "000";    
                  width6_xhdl9 := "000";    
                  width5_xhdl8 := "000";    
                  width4_xhdl7 := "000";    
                  width3_xhdl6 := "000";    
                  width2_xhdl5 := "000";    
                  width1_xhdl4 := "000";    
                  width0_xhdl3 := "000";    
                  writeAddr9_xhdl288 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr8_xhdl287 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr9_xhdl357 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr8_xhdl356 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData9_xhdl219 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData8_xhdl218 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
                     WHEN "10010" |
                          "10011" =>
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10000" |
                          "10001" =>
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
                     WHEN "10010" |
                          "10011" =>
                              readData_xhdl1_xhdl417 := readData9(7 
                              DOWNTO 0);    
                     WHEN "10000" |
                          "10001" =>
                              readData_xhdl1_xhdl417 := readData8(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[13:10])
                  
                  
         WHEN 20992 | 21504 | 22016 | 22528 =>
                  width10_xhdl13 := "011";    
                  width9_xhdl12 := "011";    
                  width8_xhdl11 := "011";    
                  width7_xhdl10 := "000";    
                  width6_xhdl9 := "000";    
                  width5_xhdl8 := "000";    
                  width4_xhdl7 := "000";    
                  width3_xhdl6 := "000";    
                  width2_xhdl5 := "000";    
                  width1_xhdl4 := "000";    
                  width0_xhdl3 := "000";    
                  writeAddr10_xhdl289 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr9_xhdl288 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr8_xhdl287 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr10_xhdl358 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr9_xhdl357 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr8_xhdl356 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData10_xhdl220 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData9_xhdl219 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData8_xhdl218 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
                     WHEN "10100" |
                          "10101" =>
                              wen_a10_xhdl82 := '0' & wen;    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10010" |
                          "10011" =>
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10000" |
                          "10001" =>
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
                     WHEN "10100" |
                          "10101" =>
                              readData_xhdl1_xhdl417 := readData10(7 
                              DOWNTO 0);    
                     WHEN "10010" |
                          "10011" =>
                              readData_xhdl1_xhdl417 := readData9(7 
                              DOWNTO 0);    
                     WHEN "10000" |
                          "10001" =>
                              readData_xhdl1_xhdl417 := readData8(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  
         WHEN 23040 | 23552 | 24064 | 24576 =>
                  width11_xhdl14 := "011";    
                  width10_xhdl13 := "011";    
                  width9_xhdl12 := "011";    
                  width8_xhdl11 := "011";    
                  width7_xhdl10 := "000";    
                  width6_xhdl9 := "000";    
                  width5_xhdl8 := "000";    
                  width4_xhdl7 := "000";    
                  width3_xhdl6 := "000";    
                  width2_xhdl5 := "000";    
                  width1_xhdl4 := "000";    
                  width0_xhdl3 := "000";    
                  writeAddr11_xhdl290 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr10_xhdl289 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr9_xhdl288 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr8_xhdl287 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr11_xhdl359 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr10_xhdl358 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr9_xhdl357 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr8_xhdl356 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData11_xhdl221 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData10_xhdl220 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData9_xhdl219 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData8_xhdl218 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
                     WHEN "10110" |
                          "10111" =>
                              wen_a11_xhdl83 := '0' & wen;    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10100" |
                          "10101" =>
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & wen;    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10010" |
                          "10011" =>
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10000" |
                          "10001" =>
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
                     WHEN "10110" |
                          "10111" =>
                              readData_xhdl1_xhdl417 := readData11(7 
                              DOWNTO 0);    
                     WHEN "10100" |
                          "10101" =>
                              readData_xhdl1_xhdl417 := readData10(7 
                              DOWNTO 0);    
                     WHEN "10010" |
                          "10011" =>
                              readData_xhdl1_xhdl417 := readData9(7 
                              DOWNTO 0);    
                     WHEN "10000" |
                          "10001" =>
                              readData_xhdl1_xhdl417 := readData8(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  
         WHEN 25088 | 25600 | 26112 | 26624 =>
                  width12_xhdl15 := "011";    
                  width11_xhdl14 := "011";    
                  width10_xhdl13 := "011";    
                  width9_xhdl12 := "011";    
                  width8_xhdl11 := "011";    
                  width7_xhdl10 := "000";    
                  width6_xhdl9 := "000";    
                  width5_xhdl8 := "000";    
                  width4_xhdl7 := "000";    
                  width3_xhdl6 := "000";    
                  width2_xhdl5 := "000";    
                  width1_xhdl4 := "000";    
                  width0_xhdl3 := "000";    
                  writeAddr12_xhdl291 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr11_xhdl290 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr10_xhdl289 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr9_xhdl288 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr8_xhdl287 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr12_xhdl360 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr11_xhdl359 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr10_xhdl358 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr9_xhdl357 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr8_xhdl356 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData12_xhdl222 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData11_xhdl221 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData10_xhdl220 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData9_xhdl219 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData8_xhdl218 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
                     WHEN "11000" |
                          "11001" =>
                              wen_a12_xhdl84 := '0' & wen;    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10110" |
                          "10111" =>
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & wen;    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10100" |
                          "10101" =>
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & wen;    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10010" |
                          "10011" =>
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10000" |
                          "10001" =>
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
                     WHEN "11000" |
                          "11001" =>
                              readData_xhdl1_xhdl417 := readData12(7 
                              DOWNTO 0);    
                     WHEN "10110" |
                          "10111" =>
                              readData_xhdl1_xhdl417 := readData11(7 
                              DOWNTO 0);    
                     WHEN "10100" |
                          "10101" =>
                              readData_xhdl1_xhdl417 := readData10(7 
                              DOWNTO 0);    
                     WHEN "10010" |
                          "10011" =>
                              readData_xhdl1_xhdl417 := readData9(7 
                              DOWNTO 0);    
                     WHEN "10000" |
                          "10001" =>
                              readData_xhdl1_xhdl417 := readData8(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  
         WHEN 27136 | 27648 | 28160 | 28672 =>
                  width13_xhdl16 := "011";    
                  width12_xhdl15 := "011";    
                  width11_xhdl14 := "011";    
                  width10_xhdl13 := "011";    
                  width9_xhdl12 := "011";    
                  width8_xhdl11 := "011";    
                  width7_xhdl10 := "000";    
                  width6_xhdl9 := "000";    
                  width5_xhdl8 := "000";    
                  width4_xhdl7 := "000";    
                  width3_xhdl6 := "000";    
                  width2_xhdl5 := "000";    
                  width1_xhdl4 := "000";    
                  width0_xhdl3 := "000";    
                  writeAddr13_xhdl292 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr12_xhdl291 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr11_xhdl290 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr10_xhdl289 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr9_xhdl288 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr8_xhdl287 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr13_xhdl361 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr12_xhdl360 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr11_xhdl359 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr10_xhdl358 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr9_xhdl357 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr8_xhdl356 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData13_xhdl223 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData12_xhdl222 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData11_xhdl221 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData10_xhdl220 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData9_xhdl219 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData8_xhdl218 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
                     WHEN "11010" |
                          "11011" =>
                              wen_a13_xhdl85 := '0' & wen;    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "11000" |
                          "11001" =>
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & wen;    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10110" |
                          "10111" =>
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & wen;    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10100" |
                          "10101" =>
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & wen;    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10010" |
                          "10011" =>
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10000" |
                          "10001" =>
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
                     WHEN "11010" |
                          "11011" =>
                              readData_xhdl1_xhdl417 := readData13(7 
                              DOWNTO 0);    
                     WHEN "11000" |
                          "11001" =>
                              readData_xhdl1_xhdl417 := readData12(7 
                              DOWNTO 0);    
                     WHEN "10110" |
                          "10111" =>
                              readData_xhdl1_xhdl417 := readData11(7 
                              DOWNTO 0);    
                     WHEN "10100" |
                          "10101" =>
                              readData_xhdl1_xhdl417 := readData10(7 
                              DOWNTO 0);    
                     WHEN "10010" |
                          "10011" =>
                              readData_xhdl1_xhdl417 := readData9(7 
                              DOWNTO 0);    
                     WHEN "10000" |
                          "10001" =>
                              readData_xhdl1_xhdl417 := readData8(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  
         WHEN 29184 | 29696 | 30208 | 30720 =>
                  width14_xhdl17 := "011";    
                  width13_xhdl16 := "011";    
                  width12_xhdl15 := "011";    
                  width11_xhdl14 := "011";    
                  width10_xhdl13 := "011";    
                  width9_xhdl12 := "011";    
                  width8_xhdl11 := "011";    
                  width7_xhdl10 := "000";    
                  width6_xhdl9 := "000";    
                  width5_xhdl8 := "000";    
                  width4_xhdl7 := "000";    
                  width3_xhdl6 := "000";    
                  width2_xhdl5 := "000";    
                  width1_xhdl4 := "000";    
                  width0_xhdl3 := "000";    
                  writeAddr14_xhdl293 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr13_xhdl292 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr12_xhdl291 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr11_xhdl290 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr10_xhdl289 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr9_xhdl288 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr8_xhdl287 := writeAddr(10 DOWNTO 0) & "000";  
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr14_xhdl362 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr13_xhdl361 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr12_xhdl360 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr11_xhdl359 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr10_xhdl358 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr9_xhdl357 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr8_xhdl356 := readAddr(10 DOWNTO 0) & "000";    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData14_xhdl224 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData13_xhdl223 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData12_xhdl222 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData11_xhdl221 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData10_xhdl220 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData9_xhdl219 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData8_xhdl218 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
                     WHEN "11100" |
                          "11101" =>
                              wen_a14_xhdl86 := '0' & wen;    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "11010" |
                          "11011" =>
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & wen;    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "11000" |
                          "11001" =>
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & wen;    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10110" |
                          "10111" =>
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & wen;    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10100" |
                          "10101" =>
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & wen;    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10010" |
                          "10011" =>
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     WHEN "10000" |
                          "10001" =>
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
                     WHEN "11100" |
                          "11101" =>
                              readData_xhdl1_xhdl417 := readData14(7 
                              DOWNTO 0);    
                     WHEN "11010" |
                          "11011" =>
                              readData_xhdl1_xhdl417 := readData13(7 
                              DOWNTO 0);    
                     WHEN "11000" |
                          "11001" =>
                              readData_xhdl1_xhdl417 := readData12(7 
                              DOWNTO 0);    
                     WHEN "10110" |
                          "10111" =>
                              readData_xhdl1_xhdl417 := readData11(7 
                              DOWNTO 0);    
                     WHEN "10100" |
                          "10101" =>
                              readData_xhdl1_xhdl417 := readData10(7 
                              DOWNTO 0);    
                     WHEN "10010" |
                          "10011" =>
                              readData_xhdl1_xhdl417 := readData9(7 
                              DOWNTO 0);    
                     WHEN "10000" |
                          "10001" =>
                              readData_xhdl1_xhdl417 := readData8(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  
         WHEN 31232 | 31744 | 32256 | 32768 =>
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
                  writeAddr15_xhdl294 := writeAddr(13 DOWNTO 0);    
                  writeAddr14_xhdl293 := writeAddr(13 DOWNTO 0);    
                  writeAddr13_xhdl292 := writeAddr(13 DOWNTO 0);    
                  writeAddr12_xhdl291 := writeAddr(13 DOWNTO 0);    
                  writeAddr11_xhdl290 := writeAddr(13 DOWNTO 0);    
                  writeAddr10_xhdl289 := writeAddr(13 DOWNTO 0);    
                  writeAddr9_xhdl288 := writeAddr(13 DOWNTO 0);    
                  writeAddr8_xhdl287 := writeAddr(13 DOWNTO 0);    
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr15_xhdl363 := readAddr(13 DOWNTO 0);    
                  readAddr14_xhdl362 := readAddr(13 DOWNTO 0);    
                  readAddr13_xhdl361 := readAddr(13 DOWNTO 0);    
                  readAddr12_xhdl360 := readAddr(13 DOWNTO 0);    
                  readAddr11_xhdl359 := readAddr(13 DOWNTO 0);    
                  readAddr10_xhdl358 := readAddr(13 DOWNTO 0);    
                  readAddr9_xhdl357 := readAddr(13 DOWNTO 0);    
                  readAddr8_xhdl356 := readAddr(13 DOWNTO 0);    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData15_xhdl225 := "00000000000000000" & 
                  writeData(7);    
                  writeData14_xhdl224 := "00000000000000000" & 
                  writeData(6);    
                  writeData13_xhdl223 := "00000000000000000" & 
                  writeData(5);    
                  writeData12_xhdl222 := "00000000000000000" & 
                  writeData(4);    
                  writeData11_xhdl221 := "00000000000000000" & 
                  writeData(3);    
                  writeData10_xhdl220 := "00000000000000000" & 
                  writeData(2);    
                  writeData9_xhdl219 := "00000000000000000" & 
                  writeData(1);    
                  writeData8_xhdl218 := "00000000000000000" & 
                  writeData(0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(14 DOWNTO 10) IS
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
                              wen_a15_xhdl87 := '0' & wen;    
                              wen_a14_xhdl86 := '0' & wen;    
                              wen_a13_xhdl85 := '0' & wen;    
                              wen_a12_xhdl84 := '0' & wen;    
                              wen_a11_xhdl83 := '0' & wen;    
                              wen_a10_xhdl82 := '0' & wen;    
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a15_xhdl87 := '0' & '0';    
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a15_xhdl87 := '0' & '0';    
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  CASE ckRdAddr(14 DOWNTO 10) IS
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
                              readData_xhdl1_xhdl417 := readData15(0) & 
                              readData14(0) & readData13(0) & 
                              readData12(0) & readData11(0) & 
                              readData10(0) & readData9(0) & readData8(0)
                              ;    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                                                                
         WHEN 33280 | 33792 | 34304 | 34816 =>
                  width16_xhdl19 := "011";    
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
                  writeAddr16_xhdl295 := writeAddr(10 DOWNTO 0) & "000"; 
                  writeAddr15_xhdl294 := writeAddr(13 DOWNTO 0);    
                  writeAddr14_xhdl293 := writeAddr(13 DOWNTO 0);    
                  writeAddr13_xhdl292 := writeAddr(13 DOWNTO 0);    
                  writeAddr12_xhdl291 := writeAddr(13 DOWNTO 0);    
                  writeAddr11_xhdl290 := writeAddr(13 DOWNTO 0);    
                  writeAddr10_xhdl289 := writeAddr(13 DOWNTO 0);    
                  writeAddr9_xhdl288 := writeAddr(13 DOWNTO 0);    
                  writeAddr8_xhdl287 := writeAddr(13 DOWNTO 0);    
                  writeAddr7_xhdl286 := writeAddr(13 DOWNTO 0);    
                  writeAddr6_xhdl285 := writeAddr(13 DOWNTO 0);    
                  writeAddr5_xhdl284 := writeAddr(13 DOWNTO 0);    
                  writeAddr4_xhdl283 := writeAddr(13 DOWNTO 0);    
                  writeAddr3_xhdl282 := writeAddr(13 DOWNTO 0);    
                  writeAddr2_xhdl281 := writeAddr(13 DOWNTO 0);    
                  writeAddr1_xhdl280 := writeAddr(13 DOWNTO 0);    
                  writeAddr0_xhdl279 := writeAddr(13 DOWNTO 0);    
                  readAddr16_xhdl364 := readAddr(10 DOWNTO 0) & "000";   
                  readAddr15_xhdl363 := readAddr(13 DOWNTO 0);    
                  readAddr14_xhdl362 := readAddr(13 DOWNTO 0);    
                  readAddr13_xhdl361 := readAddr(13 DOWNTO 0);    
                  readAddr12_xhdl360 := readAddr(13 DOWNTO 0);    
                  readAddr11_xhdl359 := readAddr(13 DOWNTO 0);    
                  readAddr10_xhdl358 := readAddr(13 DOWNTO 0);    
                  readAddr9_xhdl357 := readAddr(13 DOWNTO 0);    
                  readAddr8_xhdl356 := readAddr(13 DOWNTO 0);    
                  readAddr7_xhdl355 := readAddr(13 DOWNTO 0);    
                  readAddr6_xhdl354 := readAddr(13 DOWNTO 0);    
                  readAddr5_xhdl353 := readAddr(13 DOWNTO 0);    
                  readAddr4_xhdl352 := readAddr(13 DOWNTO 0);    
                  readAddr3_xhdl351 := readAddr(13 DOWNTO 0);    
                  readAddr2_xhdl350 := readAddr(13 DOWNTO 0);    
                  readAddr1_xhdl349 := readAddr(13 DOWNTO 0);    
                  readAddr0_xhdl348 := readAddr(13 DOWNTO 0);    
                  writeData16_xhdl226 := "0000000000" & writeData(7 
                  DOWNTO 0);    
                  writeData15_xhdl225 := "00000000000000000" & 
                  writeData(7);    
                  writeData14_xhdl224 := "00000000000000000" & 
                  writeData(6);    
                  writeData13_xhdl223 := "00000000000000000" & 
                  writeData(5);    
                  writeData12_xhdl222 := "00000000000000000" & 
                  writeData(4);    
                  writeData11_xhdl221 := "00000000000000000" & 
                  writeData(3);    
                  writeData10_xhdl220 := "00000000000000000" & 
                  writeData(2);    
                  writeData9_xhdl219 := "00000000000000000" & 
                  writeData(1);    
                  writeData8_xhdl218 := "00000000000000000" & 
                  writeData(0);    
                  writeData7_xhdl217 := "00000000000000000" & 
                  writeData(7);    
                  writeData6_xhdl216 := "00000000000000000" & 
                  writeData(6);    
                  writeData5_xhdl215 := "00000000000000000" & 
                  writeData(5);    
                  writeData4_xhdl214 := "00000000000000000" & 
                  writeData(4);    
                  writeData3_xhdl213 := "00000000000000000" & 
                  writeData(3);    
                  writeData2_xhdl212 := "00000000000000000" & 
                  writeData(2);    
                  writeData1_xhdl211 := "00000000000000000" & 
                  writeData(1);    
                  writeData0_xhdl210 := "00000000000000000" & 
                  writeData(0);    
                  CASE writeAddr(15 DOWNTO 10) IS
                     WHEN "100000" |
                          "100001" =>
                              wen_a16_xhdl88 := '0' & wen;    
                              wen_a15_xhdl87 := '0' & '0';    
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a16_xhdl88 := '0' & '0';    
                              wen_a15_xhdl87 := '0' & wen;    
                              wen_a14_xhdl86 := '0' & wen;    
                              wen_a13_xhdl85 := '0' & wen;    
                              wen_a12_xhdl84 := '0' & wen;    
                              wen_a11_xhdl83 := '0' & wen;    
                              wen_a10_xhdl82 := '0' & wen;    
                              wen_a9_xhdl81 := '0' & wen;    
                              wen_a8_xhdl80 := '0' & wen;    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
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
                              wen_a16_xhdl88 := '0' & '0';    
                              wen_a15_xhdl87 := '0' & '0';    
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & wen;    
                              wen_a6_xhdl78 := '0' & wen;    
                              wen_a5_xhdl77 := '0' & wen;    
                              wen_a4_xhdl76 := '0' & wen;    
                              wen_a3_xhdl75 := '0' & wen;    
                              wen_a2_xhdl74 := '0' & wen;    
                              wen_a1_xhdl73 := '0' & wen;    
                              wen_a0_xhdl72 := '0' & wen;    
                     WHEN OTHERS  =>
                              wen_a16_xhdl88 := '0' & '0';    
                              wen_a15_xhdl87 := '0' & '0';    
                              wen_a14_xhdl86 := '0' & '0';    
                              wen_a13_xhdl85 := '0' & '0';    
                              wen_a12_xhdl84 := '0' & '0';    
                              wen_a11_xhdl83 := '0' & '0';    
                              wen_a10_xhdl82 := '0' & '0';    
                              wen_a9_xhdl81 := '0' & '0';    
                              wen_a8_xhdl80 := '0' & '0';    
                              wen_a7_xhdl79 := '0' & '0';    
                              wen_a6_xhdl78 := '0' & '0';    
                              wen_a5_xhdl77 := '0' & '0';    
                              wen_a4_xhdl76 := '0' & '0';    
                              wen_a3_xhdl75 := '0' & '0';    
                              wen_a2_xhdl74 := '0' & '0';    
                              wen_a1_xhdl73 := '0' & '0';    
                              wen_a0_xhdl72 := '0' & '0';    
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
                  CASE ckRdAddr(15 DOWNTO 10) IS
                     WHEN "100000" |
                          "100001" =>
                              readData_xhdl1_xhdl417 := readData16(7 
                              DOWNTO 0);    
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
                              readData_xhdl1_xhdl417 := readData15(0) & 
                              readData14(0) & readData13(0) & 
                              readData12(0) & readData11(0) & 
                              readData10(0) & readData9(0) & readData8(0)
                              ;    
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
                              readData_xhdl1_xhdl417 := readData7(0) & 
                              readData6(0) & readData5(0) & readData4(0) 
                              & readData3(0) & readData2(0) & 
                              readData1(0) & readData0(0);    
                     WHEN OTHERS  =>
                              readData_xhdl1_xhdl417 := (OTHERS => '0'); 
                     
                  END CASE;
                  -- case (writeAddr[14:10])
                  
         WHEN OTHERS =>
                  NULL;
         

      END CASE;
      
      
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
      width16 <= width16_xhdl19;
      width17 <= width17_xhdl20;
      wen_a0 <= wen_a0_xhdl72;
      wen_a1 <= wen_a1_xhdl73;
      wen_a2 <= wen_a2_xhdl74;
      wen_a3 <= wen_a3_xhdl75;
      wen_a4 <= wen_a4_xhdl76;
      wen_a5 <= wen_a5_xhdl77;
      wen_a6 <= wen_a6_xhdl78;
      wen_a7 <= wen_a7_xhdl79;
      wen_a8 <= wen_a8_xhdl80;
      wen_a9 <= wen_a9_xhdl81;
      wen_a10 <= wen_a10_xhdl82;
      wen_a11 <= wen_a11_xhdl83;
      wen_a12 <= wen_a12_xhdl84;
      wen_a13 <= wen_a13_xhdl85;
      wen_a14 <= wen_a14_xhdl86;
      wen_a15 <= wen_a15_xhdl87;
      wen_a16 <= wen_a16_xhdl88;
      wen_a17 <= wen_a17_xhdl89;
      wen_b0 <= wen_b0_xhdl141;
      wen_b1 <= wen_b1_xhdl142;
      wen_b2 <= wen_b2_xhdl143;
      wen_b3 <= wen_b3_xhdl144;
      wen_b4 <= wen_b4_xhdl145;
      wen_b5 <= wen_b5_xhdl146;
      wen_b6 <= wen_b6_xhdl147;
      wen_b7 <= wen_b7_xhdl148;
      wen_b8 <= wen_b8_xhdl149;
      wen_b9 <= wen_b9_xhdl150;
      wen_b10 <= wen_b10_xhdl151;
      wen_b11 <= wen_b11_xhdl152;
      wen_b12 <= wen_b12_xhdl153;
      wen_b13 <= wen_b13_xhdl154;
      wen_b14 <= wen_b14_xhdl155;
      wen_b15 <= wen_b15_xhdl156;
      wen_b16 <= wen_b16_xhdl157;
      wen_b17 <= wen_b17_xhdl158;
      writeData0 <= writeData0_xhdl210;
      writeData1 <= writeData1_xhdl211;
      writeData2 <= writeData2_xhdl212;
      writeData3 <= writeData3_xhdl213;
      writeData4 <= writeData4_xhdl214;
      writeData5 <= writeData5_xhdl215;
      writeData6 <= writeData6_xhdl216;
      writeData7 <= writeData7_xhdl217;
      writeData8 <= writeData8_xhdl218;
      writeData9 <= writeData9_xhdl219;
      writeData10 <= writeData10_xhdl220;
      writeData11 <= writeData11_xhdl221;
      writeData12 <= writeData12_xhdl222;
      writeData13 <= writeData13_xhdl223;
      writeData14 <= writeData14_xhdl224;
      writeData15 <= writeData15_xhdl225;
      writeData16 <= writeData16_xhdl226;
      writeData17 <= writeData17_xhdl227;
      writeAddr0 <= writeAddr0_xhdl279;
      writeAddr1 <= writeAddr1_xhdl280;
      writeAddr2 <= writeAddr2_xhdl281;
      writeAddr3 <= writeAddr3_xhdl282;
      writeAddr4 <= writeAddr4_xhdl283;
      writeAddr5 <= writeAddr5_xhdl284;
      writeAddr6 <= writeAddr6_xhdl285;
      writeAddr7 <= writeAddr7_xhdl286;
      writeAddr8 <= writeAddr8_xhdl287;
      writeAddr9 <= writeAddr9_xhdl288;
      writeAddr10 <= writeAddr10_xhdl289;
      writeAddr11 <= writeAddr11_xhdl290;
      writeAddr12 <= writeAddr12_xhdl291;
      writeAddr13 <= writeAddr13_xhdl292;
      writeAddr14 <= writeAddr14_xhdl293;
      writeAddr15 <= writeAddr15_xhdl294;
      writeAddr16 <= writeAddr16_xhdl295;
      writeAddr17 <= writeAddr17_xhdl296;
      readAddr0 <= readAddr0_xhdl348;
      readAddr1 <= readAddr1_xhdl349;
      readAddr2 <= readAddr2_xhdl350;
      readAddr3 <= readAddr3_xhdl351;
      readAddr4 <= readAddr4_xhdl352;
      readAddr5 <= readAddr5_xhdl353;
      readAddr6 <= readAddr6_xhdl354;
      readAddr7 <= readAddr7_xhdl355;
      readAddr8 <= readAddr8_xhdl356;
      readAddr9 <= readAddr9_xhdl357;
      readAddr10 <= readAddr10_xhdl358;
      readAddr11 <= readAddr11_xhdl359;
      readAddr12 <= readAddr12_xhdl360;
      readAddr13 <= readAddr13_xhdl361;
      readAddr14 <= readAddr14_xhdl362;
      readAddr15 <= readAddr15_xhdl363;
      readAddr16 <= readAddr16_xhdl364;
      readAddr17 <= readAddr17_xhdl365;
      readData_xhdl1 <= readData_xhdl1_xhdl417;
   END PROCESS;
   
   -- always @ (*)
   ------------------------------------------------------------------------------------------
   -- RAM1K18 blocks
   ------------------------------------------------------------------------------------------
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block17 : RAM1K18 
      PORT MAP (
         A_DOUT => readData17,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData17,
         B_DIN => writeData17,
         A_ADDR => writeAddr17,
         B_ADDR => writeAddr17,
         A_WEN => wen_a17,
         B_WEN => wen_b17,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width17,
         B_WIDTH => width17,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_17,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block16 : RAM1K18 
      PORT MAP (
         A_DOUT => readData16,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData16,
         B_DIN => writeData16,
         A_ADDR => writeAddr16,
         B_ADDR => writeAddr16,
         A_WEN => wen_a16,
         B_WEN => wen_b16,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width16,
         B_WIDTH => width16,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_16,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block15 : RAM1K18 
      PORT MAP (
         A_DOUT => readData15,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData15,
         B_DIN => writeData15,
         A_ADDR => writeAddr15,
         B_ADDR => writeAddr15,
         A_WEN => wen_a15,
         B_WEN => wen_b15,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width15,
         B_WIDTH => width15,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_15,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block14 : RAM1K18 
      PORT MAP (
         A_DOUT => readData14,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData14,
         B_DIN => writeData14,
         A_ADDR => writeAddr14,
         B_ADDR => writeAddr14,
         A_WEN => wen_a14,
         B_WEN => wen_b14,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width14,
         B_WIDTH => width14,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_14,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block13 : RAM1K18 
      PORT MAP (
         A_DOUT => readData13,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData13,
         B_DIN => writeData13,
         A_ADDR => writeAddr13,
         B_ADDR => writeAddr13,
         A_WEN => wen_a13,
         B_WEN => wen_b13,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width13,
         B_WIDTH => width13,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_13,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block12 : RAM1K18 
      PORT MAP (
         A_DOUT => readData12,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData12,
         B_DIN => writeData12,
         A_ADDR => writeAddr12,
         B_ADDR => writeAddr12,
         A_WEN => wen_a12,
         B_WEN => wen_b12,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width12,
         B_WIDTH => width12,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_12,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block11 : RAM1K18 
      PORT MAP (
         A_DOUT => readData11,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData11,
         B_DIN => writeData11,
         A_ADDR => writeAddr11,
         B_ADDR => writeAddr11,
         A_WEN => wen_a11,
         B_WEN => wen_b11,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width11,
         B_WIDTH => width11,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_11,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block10 : RAM1K18 
      PORT MAP (
         A_DOUT => readData10,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData10,
         B_DIN => writeData10,
         A_ADDR => writeAddr10,
         B_ADDR => writeAddr10,
         A_WEN => wen_a10,
         B_WEN => wen_b10,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width10,
         B_WIDTH => width10,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_10,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block9 : RAM1K18 
      PORT MAP (
         A_DOUT => readData9,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData9,
         B_DIN => writeData9,
         A_ADDR => writeAddr9,
         B_ADDR => writeAddr9,
         A_WEN => wen_a9,
         B_WEN => wen_b9,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width9,
         B_WIDTH => width9,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_9,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block8 : RAM1K18 
      PORT MAP (
         A_DOUT => readData8,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData8,
         B_DIN => writeData8,
         A_ADDR => writeAddr8,
         B_ADDR => writeAddr8,
         A_WEN => wen_a8,
         B_WEN => wen_b8,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width8,
         B_WIDTH => width8,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_8,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block7 : RAM1K18 
      PORT MAP (
         A_DOUT => readData7,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData7,
         B_DIN => writeData7,
         A_ADDR => writeAddr7,
         B_ADDR => writeAddr7,
         A_WEN => wen_a7,
         B_WEN => wen_b7,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width7,
         B_WIDTH => width7,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_7,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block6 : RAM1K18 
      PORT MAP (
         A_DOUT => readData6,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData6,
         B_DIN => writeData6,
         A_ADDR => writeAddr6,
         B_ADDR => writeAddr6,
         A_WEN => wen_a6,
         B_WEN => wen_b6,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width6,
         B_WIDTH => width6,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_6,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block5 : RAM1K18 
      PORT MAP (
         A_DOUT => readData5,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData5,
         B_DIN => writeData5,
         A_ADDR => writeAddr5,
         B_ADDR => writeAddr5,
         A_WEN => wen_a5,
         B_WEN => wen_b5,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width5,
         B_WIDTH => width5,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_5,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block4 : RAM1K18 
      PORT MAP (
         A_DOUT => readData4,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData4,
         B_DIN => writeData4,
         A_ADDR => writeAddr4,
         B_ADDR => writeAddr4,
         A_WEN => wen_a4,
         B_WEN => wen_b4,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width4,
         B_WIDTH => width4,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_4,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block3 : RAM1K18 
      PORT MAP (
         A_DOUT => readData3,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData3,
         B_DIN => writeData3,
         A_ADDR => writeAddr3,
         B_ADDR => writeAddr3,
         A_WEN => wen_a3,
         B_WEN => wen_b3,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width3,
         B_WIDTH => width3,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_3,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block2 : RAM1K18 
      PORT MAP (
         A_DOUT => readData2,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData2,
         B_DIN => writeData2,
         A_ADDR => writeAddr2,
         B_ADDR => writeAddr2,
         A_WEN => wen_a2,
         B_WEN => wen_b2,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width2,
         B_WIDTH => width2,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_2,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block1 : RAM1K18 
      PORT MAP (
         A_DOUT => readData1,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData1,
         B_DIN => writeData1,
         A_ADDR => writeAddr1,
         B_ADDR => writeAddr1,
         A_WEN => wen_a1,
         B_WEN => wen_b1,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width1,
         B_WIDTH => width1,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_1,
         SII_LOCK => '0');   
   
   -- <<X-HDL>> Can't find translated component 'RAM1K18'. Port & generic names and types may not match. No template will be included
   block0 : RAM1K18 
      PORT MAP (
         A_DOUT => readData0,
         B_DOUT => open,
         A_CLK => clk,
         B_CLK => clk,
         A_ARST_N => resetn,
         B_ARST_N => resetn,
         A_BLK => "111",
         B_BLK => "111",
         A_DIN => writeData0,
         B_DIN => writeData0,
         A_ADDR => writeAddr0,
         B_ADDR => writeAddr0,
         A_WEN => wen_a0,
         B_WEN => wen_b0,
         A_DOUT_CLK => '1',
         B_DOUT_CLK => '1',
         A_DOUT_EN => '1',
         B_DOUT_EN => '1',
         A_DOUT_ARST_N => '1',
         B_DOUT_ARST_N => '1',
         A_DOUT_SRST_N => '1',
         B_DOUT_SRST_N => '1',
         A_DOUT_LAT => '1',
         B_DOUT_LAT => '1',
         A_WIDTH => width0,
         B_WIDTH => width0,
         A_WMODE => '0',
         B_WMODE => '0',
         A_EN => '1',
         B_EN => '1',
         BUSY => lsram_2k_BUSY_0,
         SII_LOCK => '0');   
   
   lsram_2k_BUSY_all_xhdl2 <= lsram_2k_BUSY_0 OR lsram_2k_BUSY_1 OR 
   lsram_2k_BUSY_2 OR lsram_2k_BUSY_3 OR lsram_2k_BUSY_4 OR 
   lsram_2k_BUSY_5 OR lsram_2k_BUSY_6 OR lsram_2k_BUSY_7 OR 
   lsram_2k_BUSY_8 OR lsram_2k_BUSY_9 OR lsram_2k_BUSY_10 OR 
   lsram_2k_BUSY_11 OR lsram_2k_BUSY_12 OR lsram_2k_BUSY_13 OR 
   lsram_2k_BUSY_14 OR lsram_2k_BUSY_15 OR lsram_2k_BUSY_16 OR 
   lsram_2k_BUSY_17 ;

END ARCHITECTURE translated;
