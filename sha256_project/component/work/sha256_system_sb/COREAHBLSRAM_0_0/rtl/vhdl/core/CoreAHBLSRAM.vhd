-- ********************************************************************/
-- Actel Corporation Proprietary and Confidential
--  Copyright 2011 Actel Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:  CoreAHBLSRAM
--               The Core IP provides AHB interface to embedded Large SRAM.
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


ENTITY sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM IS
   GENERIC (
      --//////////////////////////////////////////////////////////////////////////////
      -- Parameter Declarations
      --//////////////////////////////////////////////////////////////////////////////
      FAMILY                         :  integer := 19;    
      AHB_DWIDTH                     :  integer := 32;    
      AHB_AWIDTH                     :  integer := 32;    
      LSRAM_NUM_LOCATIONS_DWIDTH32   :  integer := 512;    
      USRAM_NUM_LOCATIONS_DWIDTH32   :  integer := 128;    
      SEL_SRAM_TYPE                  :  integer := 1);    
   PORT (
      --//////////////////////////////////////////////////////////////////////////////
-- I/O Declarations
--//////////////////////////////////////////////////////////////////////////////
-- Inputs

      HCLK                    : IN std_logic;   
      HRESETN                 : IN std_logic;   
      HSEL                    : IN std_logic;   
      HREADYIN                : IN std_logic;   
      HSIZE                   : IN std_logic_vector(2 DOWNTO 0);   
      HTRANS                  : IN std_logic_vector(1 DOWNTO 0);   
      HBURST                  : IN std_logic_vector(2 DOWNTO 0);   
      HADDR                   : IN std_logic_vector(AHB_AWIDTH - 1 
      DOWNTO 0);   
      HWRITE                  : IN std_logic;   
      HWDATA                  : IN std_logic_vector(AHB_DWIDTH - 1 
      DOWNTO 0);   
      HREADYOUT               : OUT std_logic;   
      -- Outputs

      HRDATA                  : OUT std_logic_vector(AHB_DWIDTH - 1 
      DOWNTO 0);   
      HRESP                   : OUT std_logic_vector(1 DOWNTO 0));   
END ENTITY sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM;

ARCHITECTURE translated OF sha256_system_sb_COREAHBLSRAM_0_0_COREAHBLSRAM IS

COMPONENT AHBLSramIf 
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
END COMPONENT;

COMPONENT sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf  
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
END COMPONENT;

   --//////////////////////////////////////////////////////////////////////////////
   -- Register Declarations
   --//////////////////////////////////////////////////////////////////////////////
   SIGNAL HADDR_cal                :  std_logic_vector(19 DOWNTO 0);   
   --//////////////////////////////////////////////////////////////////////////////
   -- Wire Declarations
   --//////////////////////////////////////////////////////////////////////////////
   SIGNAL ahbsram_size             :  std_logic_vector(2 DOWNTO 0);   
   SIGNAL ahbsram_addr             :  std_logic_vector(19 DOWNTO 0);   
   SIGNAL ahbsram_wdata            :  std_logic_vector(31 DOWNTO 0);   
   SIGNAL ahbsram_write            :  std_logic;   
   SIGNAL sramahb_rdata            :  std_logic_vector(31 DOWNTO 0);   
   SIGNAL HRDATA_xhdl1             :  std_logic_vector(AHB_DWIDTH - 1 
   DOWNTO 0);   
   SIGNAL HRESP_xhdl2              :  std_logic_vector(1 DOWNTO 0);   
   SIGNAL HREADYOUT_xhdl3          :  std_logic;   
   SIGNAL BUSY                     :  std_logic;   
   SIGNAL ahbsram_req              :  std_logic;   
   SIGNAL sramahb_ack              :  std_logic;   

BEGIN
   --//////////////////////////////////////////////////////////////////////////////
   -- Code starts here
   --//////////////////////////////////////////////////////////////////////////////
	
   HRDATA    <= HRDATA_xhdl1;
   HRESP     <= HRESP_xhdl2;
   HREADYOUT <= HREADYOUT_xhdl3;
   HADDR_cal <= HADDR(19 downto 0); 

   --//////////////////////////////////////////////////////////////////////////////
   -- Instantiations
   --//////////////////////////////////////////////////////////////////////////////
   -- AHBL Interface
   U_AHBLSramIf : AHBLSramIf 
      PORT MAP (
         HCLK          => HCLK,
         HRESETN       => HRESETN,
         HSEL          => HSEL,
         HTRANS        => HTRANS,
         HBURST        => HBURST,
         HWRITE        => HWRITE,
         HWDATA        => HWDATA,
         HSIZE         => HSIZE,
         HADDR         => HADDR_cal,
         HREADYIN      => HREADYIN,
         sramahb_ack   => sramahb_ack,
         sramahb_rdata => sramahb_rdata,
         HREADYOUT     => HREADYOUT_xhdl3,
         HRESP         => HRESP_xhdl2,
         ahbsram_req   => ahbsram_req,
         ahbsram_write => ahbsram_write,
         ahbsram_wdata => ahbsram_wdata,
         ahbsram_size  => ahbsram_size,
         ahbsram_addr  => ahbsram_addr,
         HRDATA        => HRDATA_xhdl1,
         BUSY          => BUSY);   
   
   
   -- SRAM Control Interface
   U_SramCtrlIf : sha256_system_sb_COREAHBLSRAM_0_0_SramCtrlIf 
      GENERIC MAP (
         SEL_SRAM_TYPE => SEL_SRAM_TYPE,
         LSRAM_NUM_LOCATIONS_DWIDTH32 => LSRAM_NUM_LOCATIONS_DWIDTH32,
         USRAM_NUM_LOCATIONS_DWIDTH32 => USRAM_NUM_LOCATIONS_DWIDTH32)
      PORT MAP (
         HCLK          => HCLK,
         HRESETN       => HRESETN,
         ahbsram_req   => ahbsram_req,
         ahbsram_write => ahbsram_write,
         ahbsram_wdata => ahbsram_wdata,
         ahbsram_size  => ahbsram_size,
         ahbsram_addr  => ahbsram_addr,
         sramahb_ack   => sramahb_ack,
         sramahb_rdata => sramahb_rdata,
         BUSY          => BUSY);   
   

END ARCHITECTURE translated;
