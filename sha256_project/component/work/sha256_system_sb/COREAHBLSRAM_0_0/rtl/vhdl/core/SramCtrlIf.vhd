-- ********************************************************************/
-- Actel Corporation Proprietary and Confidential
--  Copyright 2011 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:  SramCtrlIf
--               Provides AHB interface to embedded Large SRAM.
--
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


ENTITY sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf IS
   GENERIC (
      --//////////////////////////////////////////////////////////////////////////////
      -- Parameter Declarations
      --//////////////////////////////////////////////////////////////////////////////
      SEL_SRAM_TYPE                  :  integer := 1;    
      LSRAM_NUM_LOCATIONS_DWIDTH32   :  integer := 512;    
      USRAM_NUM_LOCATIONS_DWIDTH32   :  integer := 128;    
      AHB_DWIDTH                     :  integer := 32);    
   PORT (
      --//////////////////////////////////////////////////////////////////////////////
-- I/O Declarations
--//////////////////////////////////////////////////////////////////////////////
-- Inputs

      HCLK                    : IN std_logic;   
      HRESETN                 : IN std_logic;   
      ahbsram_req             : IN std_logic;   
      ahbsram_write           : IN std_logic;   
      ahbsram_wdata           : IN std_logic_vector(AHB_DWIDTH - 1 
      DOWNTO 0);   
      ahbsram_size            : IN std_logic_vector(2 DOWNTO 0);   
      ahbsram_addr            : IN std_logic_vector(19 DOWNTO 0);   
      -- Outputs

      sramahb_ack             : OUT std_logic;   
      sramahb_rdata           : OUT std_logic_vector(AHB_DWIDTH - 1 
      DOWNTO 0);   
      BUSY                    : OUT std_logic);   
END ENTITY sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf;

ARCHITECTURE translated OF sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf IS


   -- State Machine parameters
   CONSTANT  S_IDLE                :  std_logic_vector(1 DOWNTO 0) := 
   "00";    
   CONSTANT  S_WR                  :  std_logic_vector(1 DOWNTO 0) := 
   "01";    
   CONSTANT  S_RD                  :  std_logic_vector(1 DOWNTO 0) := 
   "10";    

COMPONENT sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8 
     GENERIC (
      -- ---------------------------------------------------------------------
      -- Parameters
      -- ---------------------------------------------------------------------
      -- DEPTH can range from
      -- 128 to 2304bytes  , in steps of 128bytes for WORD
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
      -- AhbSramIf interface
-- Inputs

      wen                     : IN std_logic;   
      ren                     : IN std_logic;
      writeAddr               : IN std_logic_vector(15 DOWNTO 0);   
      readAddr                : IN std_logic_vector(15 DOWNTO 0);   
      clk                     : IN std_logic;   
      resetn                  : IN std_logic;   
      u_BUSY_all              : OUT std_logic);   
END COMPONENT;

COMPONENT sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8
   GENERIC (
      -- ---------------------------------------------------------------------
      -- Parameters
      -- ---------------------------------------------------------------------
      -- DEPTH can range from 512 to 8192, in steps of 512
       DEPTH  :  integer := 512); 
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
      l_BUSY_all              : OUT std_logic);   
END COMPONENT;


   --//////////////////////////////////////////////////////////////////////////////
   -- Register Declarations
   --//////////////////////////////////////////////////////////////////////////////
   SIGNAL sramcurr_state           :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL sramnext_state           :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL sram_wen                 :  std_logic;   
   SIGNAL sram_ren                 :  std_logic;   
   SIGNAL sramahb_ack_int          :  std_logic;   
   SIGNAL sram_ren_d               :  std_logic;   
   SIGNAL sram_done                :  std_logic;   
   SIGNAL ahbsram_wdata_upd        :  std_logic_vector(31 DOWNTO 0);   
   SIGNAL u_ahbsram_wdata_upd      :  std_logic_vector(31 DOWNTO 0);   
    
   SIGNAL sram_wen_mem             :  std_logic_vector(3 DOWNTO 0);

   --//////////////////////////////////////////////////////////////////////////////
   -- Wire Declarations
   --//////////////////////////////////////////////////////////////////////////////
--   SIGNAL ram_rdata                :  std_logic_vector(AHB_DWIDTH - 1 
--   DOWNTO 0);   
   SIGNAL ram_rdata_lsram_xhdl1    :  std_logic_vector(AHB_DWIDTH - 1 
   DOWNTO 0);   
    SIGNAL ram_rdata_usram_xhdl1   :  std_logic_vector(AHB_DWIDTH - 1 
   DOWNTO 0);   
   SIGNAL u_BUSY_all               :  std_logic;
   SIGNAL u_BUSY_all_0             :  std_logic;   
   SIGNAL u_BUSY_all_1             :  std_logic;   
   SIGNAL u_BUSY_all_2             :  std_logic;   
   SIGNAL u_BUSY_all_3             :  std_logic;   
   SIGNAL l_BUSY_all               :  std_logic;   
   SIGNAL l_BUSY_all_0             :  std_logic;   
   SIGNAL l_BUSY_all_1             :  std_logic;   
   SIGNAL l_BUSY_all_2             :  std_logic;   
   SIGNAL l_BUSY_all_3             :  std_logic; 
   SIGNAL temp_xhdl16              :  std_logic;
   SIGNAL u_BUSY_all_int           :  std_logic;   
   SIGNAL l_BUSY_all_int           :  std_logic;  
   SIGNAL sramahb_ack_xhdl1        :  std_logic;   
   SIGNAL sramahb_rdata_xhdl2      :  std_logic_vector(AHB_DWIDTH - 1 DOWNTO 0);   
   SIGNAL BUSY_xhdl3               :  std_logic;   

BEGIN
   --//////////////////////////////////////////////////////////////////////////////
   -- Main body of code
   --//////////////////////////////////////////////////////////////////////////////
	
   sramahb_ack <= sramahb_ack_xhdl1;
   sramahb_rdata <= sramahb_rdata_xhdl2;
   BUSY <= BUSY_xhdl3;

   -- SRAM Control State Machine
   -- Current State generation   
   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         sramcurr_state <= S_IDLE;    
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         sramcurr_state <= sramnext_state;    
      END IF;
   END PROCESS;

   -- Next State and output decoder logic   
   PROCESS (sramcurr_state, ahbsram_req, 
   sramnext_state, sram_done, ahbsram_write )
      VARIABLE sramahb_ack_int_xhdl4  : std_logic;
      VARIABLE sram_wen_xhdl5  : std_logic;
      VARIABLE sram_ren_xhdl6  : std_logic;
      VARIABLE sramnext_state_xhdl7  : std_logic_vector(1 DOWNTO 0);
   BEGIN
      sramahb_ack_int_xhdl4 := '0';    
      sram_wen_xhdl5 := '0';    
      sram_ren_xhdl6 := '0';    
      sramnext_state_xhdl7 := sramcurr_state;    
      CASE sramcurr_state IS
         WHEN S_IDLE =>
                  IF (ahbsram_req = '1') THEN
                     IF (ahbsram_write = '1') THEN
                        sramnext_state_xhdl7 := S_WR;    
                        sram_wen_xhdl5 := '1';    
                     ELSE
                        sram_ren_xhdl6 := '1';    
                        sramnext_state_xhdl7 := S_RD;    
                     END IF;
                  END IF;
         WHEN S_WR =>
                  IF (sram_done = '1') THEN
                     sramnext_state_xhdl7 := S_IDLE;    
                     sramahb_ack_int_xhdl4 := '1';    
                  END IF;
         WHEN S_RD =>
                  IF (sram_done = '1') THEN
                     sramnext_state_xhdl7 := S_IDLE;    
                     sramahb_ack_int_xhdl4 := '1';    
                  END IF;
         WHEN OTHERS  =>
                  sramnext_state_xhdl7 := S_IDLE;    
         
      END CASE;    -- case (sramcurr_state)      
      
      sramahb_ack_int <= sramahb_ack_int_xhdl4;
      sram_wen        <= sram_wen_xhdl5;
      sram_ren        <= sram_ren_xhdl6;
      sramnext_state  <= sramnext_state_xhdl7;
   END PROCESS;



   S0: IF (SEL_SRAM_TYPE = 0) GENERATE
       ahbsram_wdata_upd <= ahbsram_wdata;

-- LSRAM Instance
      byte_0 : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 
         GENERIC MAP (
            DEPTH => LSRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => ahbsram_wdata_upd(7 downto 0),
            readData     => ram_rdata_lsram_xhdl1(7 downto 0),
            wen          => sram_wen_mem(0),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            l_BUSY_all   => l_BUSY_all_0);   
 
      byte_1 : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 
         GENERIC MAP (
            DEPTH => LSRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => ahbsram_wdata_upd(15 downto 8),
            readData     => ram_rdata_lsram_xhdl1(15 downto 8),
            wen          => sram_wen_mem(1),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            l_BUSY_all   => l_BUSY_all_1); 

      byte_2 : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 
         GENERIC MAP (
            DEPTH => LSRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => ahbsram_wdata_upd(23 downto 16),
            readData     => ram_rdata_lsram_xhdl1(23 downto 16),
            wen          => sram_wen_mem(2),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            l_BUSY_all   => l_BUSY_all_2); 

      byte_3 : sha256_system_sb_COREAHBLSRAM_0_0_lsram_2048to139264x8 
         GENERIC MAP (
            DEPTH => LSRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => ahbsram_wdata_upd(31 downto 24),
            readData     => ram_rdata_lsram_xhdl1(31 downto 24),
            wen          => sram_wen_mem(3),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            l_BUSY_all   => l_BUSY_all_3); 


   END GENERATE S0;
   
   S1: IF (SEL_SRAM_TYPE /= 0) GENERATE
       u_ahbsram_wdata_upd <= ahbsram_wdata;

-- uSRAM Instance
      byte_0 : sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8 
         GENERIC MAP (
            USRAM_NUM_LOCATIONS_DWIDTH32 => USRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => u_ahbsram_wdata_upd(7 downto 0),
            readData     => ram_rdata_usram_xhdl1(7 downto 0),
            wen          => sram_wen_mem(0),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            u_BUSY_all   => u_BUSY_all_0);   

      byte_1 : sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8 
         GENERIC MAP (
            USRAM_NUM_LOCATIONS_DWIDTH32 => USRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => u_ahbsram_wdata_upd(15 downto 8),
            readData     => ram_rdata_usram_xhdl1(15 downto 8),
            wen          => sram_wen_mem(1),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            u_BUSY_all   => u_BUSY_all_1); 

      byte_2 : sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8 
         GENERIC MAP (
            USRAM_NUM_LOCATIONS_DWIDTH32 => USRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => u_ahbsram_wdata_upd(23 downto 16),
            readData     => ram_rdata_usram_xhdl1(23 downto 16),
            wen          => sram_wen_mem(2),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            u_BUSY_all   => u_BUSY_all_2); 

      byte_3 : sha256_system_sb_COREAHBLSRAM_0_0_usram_128to9216x8 
         GENERIC MAP (
            USRAM_NUM_LOCATIONS_DWIDTH32 => USRAM_NUM_LOCATIONS_DWIDTH32)
         PORT MAP (
            writeData    => u_ahbsram_wdata_upd(31 downto 24),
            readData     => ram_rdata_usram_xhdl1(31 downto 24),
            wen          => sram_wen_mem(3),
            ren          => sram_ren,
            writeAddr    => ahbsram_addr(17 downto 2),
            readAddr     => ahbsram_addr(17 downto 2),
            clk          => HCLK,
            resetn       => HRESETN,
            u_BUSY_all   => u_BUSY_all_3); 

 END GENERATE S1;
 u_BUSY_all_int  <= u_BUSY_all_0 OR u_BUSY_all_1 OR u_BUSY_all_2 OR u_BUSY_all_3;
 l_BUSY_all_int  <= l_BUSY_all_0 OR l_BUSY_all_1 OR l_BUSY_all_2 OR l_BUSY_all_3;

 temp_xhdl16 <= u_BUSY_all_int WHEN SEL_SRAM_TYPE /= 0 ELSE l_BUSY_all_int;
 BUSY_xhdl3  <= temp_xhdl16 ;

   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         sramahb_rdata_xhdl2 <= (OTHERS => '0');    
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         IF (sram_ren_d = '1') THEN
   	   IF (SEL_SRAM_TYPE = 0) THEN
              sramahb_rdata_xhdl2 <= ram_rdata_lsram_xhdl1;
           ELSE    
              sramahb_rdata_xhdl2 <= ram_rdata_usram_xhdl1;
           END IF;
         ELSE
            sramahb_rdata_xhdl2   <= sramahb_rdata_xhdl2;    
         END IF;
      END IF;
   END PROCESS;

   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         sram_ren_d <= '0';    
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         sram_ren_d <= sram_ren;    
      END IF;
   END PROCESS;

   -- Generate the SRAM done when the SRAM wren/rden is done   
   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         sram_done <= '0';    
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         IF ((sram_wen OR sram_ren) = '1') THEN
            sram_done <= '1';    
         ELSE
            sram_done <= '0';    
         END IF;
      END IF;
   END PROCESS;

   -- Generate the SRAM ack    
   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         sramahb_ack_xhdl1 <= '0';    
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         sramahb_ack_xhdl1 <= sramahb_ack_int;    
      END IF;
   END PROCESS;

   -- Generate the SRAM write enable
   PROCESS (ahbsram_size, ahbsram_addr, sram_wen)
   BEGIN
      sram_wen_mem <= "0000";
      IF(ahbsram_size = "010") THEN
        sram_wen_mem(0) <= sram_wen;
        sram_wen_mem(1) <= sram_wen;
        sram_wen_mem(2) <= sram_wen;
        sram_wen_mem(3) <= sram_wen;
      ELSIF (ahbsram_size = "001") THEN
        IF(ahbsram_addr(1) = '0') THEN
            sram_wen_mem(0) <= sram_wen;
            sram_wen_mem(1) <= sram_wen;
            sram_wen_mem(2) <= '0';
            sram_wen_mem(3) <= '0';
        ELSE 
            sram_wen_mem(0) <= '0';
            sram_wen_mem(1) <= '0';
            sram_wen_mem(2) <= sram_wen;
            sram_wen_mem(3) <= sram_wen;
        END IF;
      ELSE
          IF(ahbsram_addr(1 downto 0) = "00") THEN
            sram_wen_mem(0) <= sram_wen;
            sram_wen_mem(1) <= '0';
            sram_wen_mem(2) <= '0';
            sram_wen_mem(3) <= '0';
          ELSIF(ahbsram_addr(1 downto 0) = "01") THEN
            sram_wen_mem(0) <= '0';
            sram_wen_mem(1) <= sram_wen;
            sram_wen_mem(2) <= '0';
            sram_wen_mem(3) <= '0';
          ELSIF(ahbsram_addr(1 downto 0) = "10") THEN
            sram_wen_mem(0) <= '0';
            sram_wen_mem(1) <= '0';
            sram_wen_mem(2) <= sram_wen;
            sram_wen_mem(3) <= '0';
          ELSE 
            sram_wen_mem(0) <= '0';
            sram_wen_mem(1) <= '0';
            sram_wen_mem(2) <= '0';
            sram_wen_mem(3) <= sram_wen;
          END IF;
        END IF;
   END PROCESS;
END ARCHITECTURE translated;
