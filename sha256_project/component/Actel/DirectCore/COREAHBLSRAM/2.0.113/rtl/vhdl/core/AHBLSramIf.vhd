-- ********************************************************************/
-- Actel Corporation Proprietary and Confidential
--  Copyright 2011 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:  AHBLSramIf
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


ENTITY AHBLSramIf IS
   GENERIC (
      --//////////////////////////////////////////////////////////////////////////////
      -- Parameter Declarations
      --//////////////////////////////////////////////////////////////////////////////
      AHB_DWIDTH                     :  integer := 32;    
      AHB_AWIDTH                     :  integer := 32;    
      RESP_OKAY                      :  std_logic_vector(1 DOWNTO 0) := 
      "00";    
      RESP_ERROR                     :  std_logic_vector(1 DOWNTO 0) := 
      "01";    
      -- AHB HTRANS definition
      TRN_IDLE                       :  std_logic_vector(1 DOWNTO 0) := 
      "00";    
      TRN_BUSY                       :  std_logic_vector(1 DOWNTO 0) := 
      "01";    
      TRN_SEQ                        :  std_logic_vector(1 DOWNTO 0) := 
      "11";    
      TRN_NONSEQ                     :  std_logic_vector(1 DOWNTO 0) := 
      "10");    
   PORT (
      --//////////////////////////////////////////////////////////////////////////////
-- I/O Declarations
--//////////////////////////////////////////////////////////////////////////////
-- Inputs

      HCLK                    : IN std_logic;   
      HRESETN                 : IN std_logic;   
      HSEL                    : IN std_logic;   
      HTRANS                  : IN std_logic_vector(1 DOWNTO 0);   
      HBURST                  : IN std_logic_vector(2 DOWNTO 0);   
      HWRITE                  : IN std_logic;   
      HSIZE                   : IN std_logic_vector(2 DOWNTO 0);   
      HADDR                   : IN std_logic_vector(19 DOWNTO 0);   
      HWDATA                  : IN std_logic_vector(AHB_DWIDTH - 1 
      DOWNTO 0);   
      HREADYIN                : IN std_logic;   
      sramahb_ack             : IN std_logic;   
      sramahb_rdata           : IN std_logic_vector(AHB_DWIDTH - 1 
      DOWNTO 0);   
      HRESP                   : OUT std_logic_vector(1 DOWNTO 0);   
      -- Outputs

      HREADYOUT               : OUT std_logic;   
      HRDATA                  : OUT std_logic_vector(AHB_DWIDTH - 1 
      DOWNTO 0);   
      ahbsram_req             : OUT std_logic;   
      ahbsram_write           : OUT std_logic;   
      ahbsram_wdata           : OUT std_logic_vector(AHB_AWIDTH - 1 
      DOWNTO 0);   
      ahbsram_size            : OUT std_logic_vector(2 DOWNTO 0);   
      ahbsram_addr            : OUT std_logic_vector(19 DOWNTO 0);   
      BUSY                    : IN std_logic);   
END ENTITY AHBLSramIf;

ARCHITECTURE translated OF AHBLSramIf IS


   -- State Machine parameters
   CONSTANT  IDLE                  :  std_logic_vector(1 DOWNTO 0) := 
   "00";    
   CONSTANT  AHB_WR                :  std_logic_vector(1 DOWNTO 0) := 
   "01";    
   CONSTANT  AHB_RD                :  std_logic_vector(1 DOWNTO 0) := 
   "10";    
   --//////////////////////////////////////////////////////////////////////////////
   -- Register Declarations
   --//////////////////////////////////////////////////////////////////////////////
   SIGNAL HTRANS_d                 :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL HBURST_d                 :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL HSIZE_d                  :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL HADDR_d                  :  std_logic_vector(19 DOWNTO 0);   
   SIGNAL HWDATA_d                 :  std_logic_vector(AHB_DWIDTH - 1 
   DOWNTO 0);   
   SIGNAL HWRITE_d                 :  std_logic;   
   SIGNAL HSEL_d                   :  std_logic;   
   SIGNAL HREADYIN_d               :  std_logic;   
   SIGNAL ahbcurr_state            :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL ahbnext_state            :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL latchahbcmd              :  std_logic;   
   SIGNAL ahbsram_req_int          :  std_logic;   
   SIGNAL ahbsram_req_d1           :  std_logic;   
   SIGNAL HWDATA_cal               :  std_logic_vector(AHB_DWIDTH - 1 
   DOWNTO 0);   
   --//////////////////////////////////////////////////////////////////////////////
   -- Wire Declarations
   --//////////////////////////////////////////////////////////////////////////////
   SIGNAL validahbcmd              :  std_logic;   

   -- Generation of signals required for SRAM
   SIGNAL temp_xhdl13              :  std_logic;   
   SIGNAL temp_xhdl14              :  std_logic_vector(AHB_DWIDTH - 1 DOWNTO 0);
   SIGNAL temp_xhdl15              :  std_logic_vector(19 DOWNTO 0);   
   SIGNAL temp_xhdl16              :  std_logic_vector(2 DOWNTO 0); 
   SIGNAL HREADYOUT_xhdl1          :  std_logic;   
   SIGNAL HRESP_xhdl2              :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL HRDATA_xhdl3             :  std_logic_vector(AHB_DWIDTH - 1 
   DOWNTO 0);   
   SIGNAL ahbsram_req_xhdl4        :  std_logic;   
   SIGNAL ahbsram_write_xhdl5      :  std_logic;   
   SIGNAL ahbsram_wdata_xhdl6      :  std_logic_vector(AHB_AWIDTH - 1 
   DOWNTO 0);   
   SIGNAL ahbsram_size_xhdl7       :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL ahbsram_addr_xhdl8       :  std_logic_vector(19 DOWNTO 0);
   FUNCTION to_stdlogic (
      val      : IN boolean) RETURN std_logic IS
   BEGIN
      IF (val) THEN
         RETURN('1');
      ELSE
         RETURN('0');
      END IF;
   END to_stdlogic;
   
   FUNCTION conv_std_logic (
      val      : IN boolean) RETURN std_logic IS
   BEGIN
      RETURN(to_stdlogic(val));
   END conv_std_logic;

BEGIN
   --//////////////////////////////////////////////////////////////////////////////
   -- Main body of code
   --//////////////////////////////////////////////////////////////////////////////
	
   HREADYOUT     <= HREADYOUT_xhdl1;
   HRESP         <= HRESP_xhdl2;
   HRDATA        <= HRDATA_xhdl3;
   ahbsram_req   <= ahbsram_req_xhdl4;
   ahbsram_write <= ahbsram_write_xhdl5;
   ahbsram_wdata <= ahbsram_wdata_xhdl6;
   ahbsram_size  <= ahbsram_size_xhdl7;
   ahbsram_addr  <= ahbsram_addr_xhdl8;

   -- Changes to be done when BUSY signal from RAM is used to block UII transactions indicating that SII needs to access the RAMs   
   --   assign HREADYOUT = !ahbsram_req_int & !BUSY;
   
   -- Generation of valid AHB Command which triggers the AHB Slave State Machine
   validahbcmd <= (HREADYIN AND HSEL) AND CONV_STD_LOGIC(HTRANS = TRN_NONSEQ) ;

   -- Generation of HRESP
   HRESP_xhdl2 <= RESP_OKAY ;

   PROCESS (HWDATA)
      VARIABLE HWDATA_cal_xhdl9  : std_logic_vector(AHB_DWIDTH - 1 DOWNTO 0);
   BEGIN
      HWDATA_cal_xhdl9 := HWDATA;    
      HWDATA_cal <= HWDATA_cal_xhdl9;
   END PROCESS;

   -- Latch all the AHB signals 
   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         HADDR_d <= (OTHERS => '0');    
         HWDATA_d <= (OTHERS => '0');    
         HTRANS_d <= "00";    
         HSIZE_d <= "000";    
         HBURST_d <= "000";    
         HWRITE_d <= '0';    
         HSEL_d <= '0';    
         HREADYIN_d <= '0';    
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         IF (latchahbcmd = '1') THEN
            HADDR_d    <= HADDR;    
            HTRANS_d   <= HTRANS;    
            HSIZE_d    <= HSIZE;    
            HBURST_d   <= HBURST;    
            HWRITE_d   <= HWRITE;    
            HWDATA_d   <= HWDATA_cal;    
            HSEL_d     <= HSEL;    
            HREADYIN_d <= HREADYIN;    
         END IF;
      END IF;
   END PROCESS;

   -- Current State generation   
   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         ahbcurr_state <= IDLE;    
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         ahbcurr_state <= ahbnext_state;    
      END IF;
   END PROCESS;

   -- Next State and output decoder logic   
   PROCESS (HWRITE, sramahb_ack, validahbcmd, ahbnext_state, ahbcurr_state, 
   latchahbcmd)
      VARIABLE latchahbcmd_xhdl10  : std_logic;
      VARIABLE ahbsram_req_int_xhdl11  : std_logic;
      VARIABLE ahbnext_state_xhdl12  : std_logic_vector(1 DOWNTO 0);
   BEGIN
      latchahbcmd_xhdl10 := '0';    
      ahbsram_req_int_xhdl11 := '0';    
      ahbnext_state_xhdl12 := ahbcurr_state;    
      CASE ahbcurr_state IS
         WHEN IDLE =>
                  IF (validahbcmd = '1') THEN
                     latchahbcmd_xhdl10 := '1';    
                     IF (HWRITE = '1') THEN
                        ahbnext_state_xhdl12 := AHB_WR;    
                     ELSE
                        ahbnext_state_xhdl12 := AHB_RD;    
                     END IF;
                  END IF;
         WHEN AHB_WR =>
                  latchahbcmd_xhdl10 := '0';    
                  ahbsram_req_int_xhdl11 := '1';    
                  IF (sramahb_ack = '1') THEN
                     ahbnext_state_xhdl12 := IDLE;    
                  END IF;
         WHEN AHB_RD =>
                  latchahbcmd_xhdl10 := '0';    
                  ahbsram_req_int_xhdl11 := '1';    
                  IF (sramahb_ack = '1') THEN
                     ahbnext_state_xhdl12 := IDLE;    
                  END IF;
         WHEN OTHERS  =>
                  ahbnext_state_xhdl12 := IDLE;    
         
      END CASE;   -- case (ahbcurr_state)      
      
      latchahbcmd     <= latchahbcmd_xhdl10;
      ahbsram_req_int <= ahbsram_req_int_xhdl11;
      ahbnext_state   <= ahbnext_state_xhdl12;
   END PROCESS;

   --Generation of HREADYOUT
   HREADYOUT_xhdl1 <= NOT ahbsram_req_int ;
   temp_xhdl13     <= HWRITE_d WHEN (ahbsram_req_xhdl4 AND NOT sramahb_ack) = '1' ELSE '0';
   ahbsram_write_xhdl5 <= temp_xhdl13 ;

   temp_xhdl14         <= HWDATA;
   ahbsram_wdata_xhdl6 <= temp_xhdl14 ;

   temp_xhdl15 <= HADDR_d WHEN (ahbsram_req_int AND NOT sramahb_ack) = '1' ELSE HADDR_d;
   ahbsram_addr_xhdl8 <= temp_xhdl15 ;

   temp_xhdl16 <= HSIZE_d WHEN (ahbsram_req_int AND NOT sramahb_ack) = '1' ELSE HSIZE;
   ahbsram_size_xhdl7 <= temp_xhdl16 ;
   
   PROCESS (HCLK, HRESETN)
   BEGIN
      IF (HRESETN = '0') THEN
         ahbsram_req_d1 <= '0'; 
      ELSIF (HCLK'EVENT AND HCLK = '1') THEN
         ahbsram_req_d1 <= ahbsram_req_int;    
      END IF;
   END PROCESS;

   -- Generate the request to the SRAM contol logic when there is AHB read or write request
   ahbsram_req_xhdl4 <= (ahbsram_req_int AND NOT ahbsram_req_d1) AND CONV_STD_LOGIC(HBURST_d = "000") ;

   -- HRDATA generation      
   PROCESS (sramahb_rdata, HREADYIN, HREADYOUT_xhdl1 )
      VARIABLE HRDATA_xhdl3_xhdl17  : std_logic_vector(AHB_DWIDTH - 1 DOWNTO 0);
   BEGIN
      IF ((HREADYOUT_xhdl1 AND HREADYIN) = '1') THEN
         HRDATA_xhdl3_xhdl17 := sramahb_rdata;     
      ELSE
         HRDATA_xhdl3_xhdl17 := sramahb_rdata;    
      END IF;
      HRDATA_xhdl3 <= HRDATA_xhdl3_xhdl17;
   END PROCESS;

END ARCHITECTURE translated;
