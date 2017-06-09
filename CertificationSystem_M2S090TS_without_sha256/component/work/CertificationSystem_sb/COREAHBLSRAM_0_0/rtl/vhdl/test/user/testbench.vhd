----------------------------------------------------------------------------------------------
--
-- VHDL file generated by X-HDL - Revision 3.2.52  Mar. 28, 2005 
-- Wed Aug 29 17:53:47 2012
--
--      Input file         : C:/Documents and Settings/korpatim/Desktop/tb.v
--      Design name        : testbench
--      Author             : 
--      Company            : 
--
--      Description        : 
--
--
----------------------------------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;
use work.xhdl_std_logic.all;
use work.xhdl_misc.all;
use work.coreparameters.all;

ENTITY testbench IS
END testbench;

ARCHITECTURE translated OF testbench IS

    COMPONENT CertificationSystem_sb_COREAHBLSRAM_0_0_COREAHBLSRAM
        GENERIC(
                SEL_SRAM_TYPE                  : INTEGER := 1; 
                LSRAM_NUM_LOCATIONS_DWIDTH32   : INTEGER := 512; 
                AHB_AWIDTH                     : INTEGER := 20; 
                USRAM_NUM_LOCATIONS_DWIDTH32   : INTEGER := 128;
                AHB_DWIDTH                     : INTEGER := 32; 
                FAMILY                         : INTEGER := 19 
               );
        PORT(
          HCLK        :  IN std_logic;
          HRESETN       :  IN std_logic;
          HSEL          :  IN std_logic;
          HWRITE        :  IN std_logic;
          HADDR         :  IN std_logic_vector(AHB_AWIDTH - 1 DOWNTO 0);
          HWDATA        :  IN std_logic_vector(AHB_DWIDTH - 1 DOWNTO 0);
          HRDATA        :  OUT std_logic_vector(AHB_DWIDTH - 1 DOWNTO 0);
          HSIZE         :  IN std_logic_vector(2 DOWNTO 0);
          HTRANS        :  IN std_logic_vector(1 DOWNTO 0);
          HBURST        :  IN std_logic_vector(2 DOWNTO 0);
          HRESP         :  OUT std_logic_vector(1 DOWNTO 0);
          HREADYIN      :  IN std_logic;
          HREADYOUT     :  OUT std_logic
            );           
    END COMPONENT;       
   
   CONSTANT xhdl_timescale         : time := 1 ns;
   --CONSTANT  DEPTH                 : integer := 139264;    
   CONSTANT  DEPTH                 : integer := 4000;
   CONSTANT  AHB_CLK_PERIOD        :  integer := 5;    
   CONSTANT  INTERM_VAL_LSRAM        :  integer := 512; 
   CONSTANT  INTERM_VAL_USRAM        :  integer := 32; 
   CONSTANT  IDLE                  :  std_logic_vector(1 DOWNTO 0) := "00";    
   CONSTANT  BUSY                  :  std_logic_vector(1 DOWNTO 0) := "01";    
   CONSTANT  NONSEQ                :  std_logic_vector(1 DOWNTO 0) := "10";    
   CONSTANT  SEQ                   :  std_logic_vector(1 DOWNTO 0) := "11";    
   CONSTANT  SINGLE                :  std_logic_vector(2 DOWNTO 0) := "000";    
   CONSTANT  INCR                  :  std_logic_vector(2 DOWNTO 0) := "001";    
   CONSTANT  WRAP4                 :  std_logic_vector(2 DOWNTO 0) := "010";    
   CONSTANT  INCR4                 :  std_logic_vector(2 DOWNTO 0) := "011";    
   CONSTANT  WRAP8                 :  std_logic_vector(2 DOWNTO 0) := "100";    
   CONSTANT  INCR8                 :  std_logic_vector(2 DOWNTO 0) := "101";    
   CONSTANT  WRAP16                :  std_logic_vector(2 DOWNTO 0) := "110";    
   CONSTANT  INCR16                :  std_logic_vector(2 DOWNTO 0) := "111";    
   CONSTANT  BYTE                  :  std_logic_vector(1 DOWNTO 0) := "00";    
   CONSTANT  HALFWORD              :  std_logic_vector(1 DOWNTO 0) := "01";    
   CONSTANT  WORD                  :  std_logic_vector(1 DOWNTO 0) := "10";    
   CONSTANT  DOUBLEWORD            :  std_logic_vector(1 DOWNTO 0) := "11";    
   CONSTANT  OKAY                  :  std_logic_vector(1 DOWNTO 0) := "00";    
   CONSTANT  ERROR                 :  std_logic_vector(1 DOWNTO 0) := "01";    
   CONSTANT  RETRY                 :  std_logic_vector(1 DOWNTO 0) := "10";    
   CONSTANT  SPLIT                 :  std_logic_vector(1 DOWNTO 0) := "11";    
   CONSTANT  AHB_WRITE_TYPE                 :  std_logic := '1';    
   CONSTANT  AHB_READ_TYPE                  :  std_logic := '0';    
   CONSTANT  HIGH                  :  std_logic := '1';    
   CONSTANT  LOW                   :  std_logic := '0';    
   SIGNAL  DEPTH32               :  integer;    
   SIGNAL  DEPTH08               :  integer;     
   SIGNAL  DEPTH16               :  integer;     
   SIGNAL start_waddr              :  std_logic_vector((AHB_AWIDTH - 1) DOWNTO 0);   
   SIGNAL HCLK                     :  std_logic;   
  SIGNAL HSEL                     :  std_logic;   
  SIGNAL HWRITE                   :  std_logic;   
  SIGNAL HTRANS                   :  std_logic_vector(1 DOWNTO 0);   
  SIGNAL HSIZE                    :  std_logic_vector(2 DOWNTO 0);   
  SIGNAL HBURST                   :  std_logic_vector(2 DOWNTO 0);   
  SIGNAL HREADYIN                 :  std_logic;   
  SIGNAL HADDR                    :  std_logic_vector((AHB_AWIDTH - 1) DOWNTO 0);   
  SIGNAL HWDATA                   :  std_logic_vector((AHB_DWIDTH - 1) DOWNTO 0);   
  SIGNAL write_hwdata             :  std_logic_vector((AHB_DWIDTH - 1) DOWNTO 0);   
  SIGNAL HREADYOUT                :  std_logic;   
  SIGNAL HRESP                    :  std_logic_vector(1 DOWNTO 0);   
  SIGNAL HRDATA                   :  std_logic_vector((AHB_DWIDTH - 1) DOWNTO 0);   
  SIGNAL nreset                   :  std_logic;   
  SIGNAL read_data                :  std_logic_vector((AHB_DWIDTH - 1) DOWNTO 0);   
  SIGNAL haddr_w                  :  std_logic_vector((AHB_AWIDTH - 1) DOWNTO 0);   
  SIGNAL start_raddr              :  std_logic_vector((AHB_AWIDTH - 1) DOWNTO 0);   
  SIGNAL haddr_incr               :  std_logic_vector(3 DOWNTO 0);   
  SIGNAL hburst_value             :  std_logic_vector(4 DOWNTO 0);   
  SIGNAL wrap_enable              :  std_logic;   
  SIGNAL set_wrap_addr            :  std_logic_vector(7 DOWNTO 0);   
  SIGNAL write_resp               :  std_logic_vector(1 DOWNTO 0);   
  SIGNAL adr_0                    :  integer;   
  SIGNAL adr_00                   :  integer;   
  SIGNAL ii                       :  integer;   
  SIGNAL error_count_0            :  integer;   
  SIGNAL adr_1                    :  integer;   
  SIGNAL adr_11                   :  integer;   
  SIGNAL rr                       :  integer;   
  SIGNAL error_count_1            :  integer;   
  SIGNAL error_count              :  integer;   
  SIGNAL pound_str                :  std_logic_vector(8 * 79 DOWNTO 1);   
  SIGNAL test_str                 :  std_logic_vector(8 * 79 DOWNTO 1);   
  SIGNAL i                        :  integer;   
  SIGNAL r                        :  integer;   
  SIGNAL int                      :  integer;   
  SIGNAL burst                    :  std_logic_vector(2 DOWNTO 0);   
  SIGNAL size                     :  std_logic_vector(1 DOWNTO 0);   
  SIGNAL trans_no                 :  std_logic_vector(3 DOWNTO 0);   
  SIGNAL j                        :  integer;   
  SIGNAL iter                     :  integer;   
  SIGNAL haddr_set                :  std_logic_vector(31 DOWNTO 0);   
  SIGNAL hraddr_set               :  std_logic_vector(31 DOWNTO 0);   
  SIGNAL HRESETN                  :  std_logic;  
  SIGNAL END_OF_SIMULATIONS       :  BOOLEAN;

   TYPE xhdl_3 IS ARRAY (DEPTH - 1 DOWNTO 0) OF std_logic_vector((AHB_DWIDTH - 1) DOWNTO 0);
   TYPE xhdl_4 IS ARRAY (DEPTH - 1 DOWNTO 0) OF std_logic_vector((AHB_AWIDTH - 1) DOWNTO 0);
   
   SIGNAL writeaddr               :  xhdl_4;
   SIGNAL readaddr                :  xhdl_4;
   SIGNAL writedata               :  xhdl_3;
   SIGNAL readdata                :  xhdl_3;

BEGIN

   PROCESS IS
     
   PROCEDURE set_wraddr_incr_value (
       SIGNAL haddr_incr              : OUT std_logic_vector(3 DOWNTO 0);
       SIGNAL hsize                   : IN std_logic_vector(1 DOWNTO 0))IS
   BEGIN
      CASE hsize IS
         WHEN "00" =>
                  haddr_incr <= "0001";    
         WHEN "01" =>
                  haddr_incr <= "0010";    
         WHEN "10" =>
                  haddr_incr <= "0100";    
         WHEN "11" =>
                  haddr_incr <= "1000";    
         WHEN OTHERS =>
                  NULL;
      END CASE;
   END set_wraddr_incr_value;

   PROCEDURE ahb_read (
      SIGNAL HCLK                    : IN std_logic;
      SIGNAL hburst_xhdl2            : IN std_logic_vector(2 DOWNTO 0);   
      SIGNAL hsize_xhdl5             : IN std_logic_vector(1 DOWNTO 0);   
      SIGNAL iter_xhdl7              : IN integer;
      SIGNAL readaddr                : OUT xhdl_4;
      SIGNAL  readdata               : OUT xhdl_3)IS
   
      VARIABLE i_xhdl8                :  integer;   
      VARIABLE cnt_xhdl9              :  integer;   
      
   BEGIN
      
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
      
      HSEL <= HIGH;    
      HTRANS <= NONSEQ;    
      HADDR <= start_raddr;    
      HBURST <= hburst_xhdl2;    
      HWRITE <= AHB_READ_TYPE;    
      HSIZE <= "0" & hsize_xhdl5;    
      
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
      WAIT UNTIL HREADYOUT = '1';
      set_wraddr_incr_value(haddr_incr, hsize_xhdl5);   
      cnt_xhdl9 := 0;
      WHILE (cnt_xhdl9 < iter_xhdl7 - 1) LOOP
         readaddr(cnt_xhdl9) <= HADDR;    
         HSEL <= HIGH;    
         HTRANS <= NONSEQ;    
         HADDR <= HADDR + haddr_incr;    
         HBURST <= hburst_xhdl2;    
         HWRITE <= AHB_READ_TYPE;    
         HSIZE <= "0" & hsize_xhdl5;    
         
         set_wraddr_incr_value(haddr_incr, hsize_xhdl5);   
         readdata(cnt_xhdl9) <= HRDATA;    
         WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
         
         WAIT UNTIL HREADYOUT = '1';
         cnt_xhdl9 := cnt_xhdl9 + 1;
      END LOOP;
      
      HSEL <= LOW;    
      HTRANS <= IDLE;    
      HBURST <= "000";    
      HWRITE <= '0';    
      HSIZE <= "000";    
      
      readaddr(cnt_xhdl9) <= HADDR;    
      readdata(cnt_xhdl9) <= HRDATA;    
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
      
   END ahb_read;

   PROCEDURE ahb_write (
     SIGNAL HCLK        : IN std_logic;
     SIGNAL write_burst : IN std_logic_vector(2 DOWNTO 0);
     SIGNAL write_size  : IN std_logic_vector(1 DOWNTO 0);
     SIGNAL write_iter      : IN INTEGER;
     SIGNAL writeaddr       : OUT xhdl_4;
     SIGNAL writedata       : OUT xhdl_3)IS

     VARIABLE write_count :  INTEGER;

   BEGIN 
      
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
 
      WRITE("IAM IN TO AHB_WRITE");

      HSEL <= HIGH;    
      HTRANS <= NONSEQ;    
      HADDR <= start_waddr;    
      HBURST <= write_burst;    
      HWRITE <= AHB_WRITE_TYPE;    
      HSIZE <= "0" & write_size;
      HWDATA <= (OTHERS => '0');
         
      WAIT UNTIL HREADYOUT = '1';
      
      set_wraddr_incr_value(haddr_incr, write_size);
      write_count := 0;
      
      WHILE (write_count < write_iter - 1) LOOP
         WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
         HWDATA <= (std_logic_vector(to_unsigned(write_count+1, AHB_DWIDTH)));
        -- WAIT UNTIL HREADYOUT = '1';

         writeaddr(write_count) <= HADDR;

      
         HTRANS <= NONSEQ;    
         HADDR <= HADDR + haddr_incr;
         set_wraddr_incr_value(haddr_incr, write_size);
         
         WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
         WAIT UNTIL HREADYOUT = '1';
         
         writedata(write_count) <= HWDATA;
         write_count := write_count + 1;
      END LOOP;
         
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
      HWDATA <= (std_logic_vector(to_unsigned(write_count, AHB_DWIDTH)));

      writeaddr(write_count) <= HADDR;
      
      WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
      writedata(write_count) <= HWDATA;

      HSEL <= LOW;    
      HTRANS <= IDLE;    
      HBURST <= SINGLE;    
      HWRITE <= AHB_WRITE_TYPE; 
  END ahb_write;
  
   PROCEDURE ahb_compare (
       SIGNAL size                    : IN std_logic_vector(1 DOWNTO 0);   
       SIGNAL DEPTH                   : IN integer;
       SIGNAL writeaddr               : IN xhdl_4;
       SIGNAL readaddr                : IN xhdl_4;
       SIGNAL writedata               : IN xhdl_3;
       SIGNAL readdata                : IN xhdl_3)IS
   
      VARIABLE i                      :  integer;   
      VARIABLE counter                :  integer;   
     
   BEGIN
      
      WRITE("IAM IN TO AHB_COMPARE");
      counter := 0;    
      i := 0;
      WHILE (i < DEPTH) LOOP
         CASE size IS
            WHEN "10" =>
                     IF (writeaddr(i) = readaddr(i)) THEN
                        IF (writedata(i) = readdata(i)) THEN
                           WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)));   
                           WRITE("TEST CASE PASSED");   
                           counter := counter + 1;    
                           IF (counter = DEPTH) THEN
                              WRITE("************** AHB_DWIDTH = 32 ****************");
                              WRITE("****** WR_SIZE = 2 and RD_SIZE = 2*********");
                              WRITE("TOTAL TESTCASE PASSED");   
                              counter := 0;    
                           END IF;
                        ELSE
                           WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)));   
                            WRITE("----DATA MISMACHED-----");
                        END IF;
                     ELSE
                        WRITE("---- ADDRESS MISMATCHED----- ");
                        WRITE("TEST CASE FAILED");   
                     END IF;
            WHEN "01" =>
                     CASE writeaddr(i)(1 DOWNTO 0) IS
                        WHEN "00" =>
                                 IF (writeaddr(i) = readaddr(i)) THEN
                                    IF (writedata(i)(15 DOWNTO 0) = readdata(i)(15 DOWNTO 0)) THEN
                                     WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)));   
                                       WRITE("TEST CASE PASSED");   
                                       counter := counter + 1;    
                                       IF (counter = DEPTH) THEN
                                          WRITE("************** AHB_DWIDTH = 16 ****************");
                                          WRITE("****** WR_SIZE = 1 and RD_SIZE = 1*********");
                                          WRITE("TOTAL TESTCASE PASSED");   
                                          counter := 0;    
                                       END IF;
                                    ELSE
                                    WRITE("----DATA MISMACHED-----");
                                    END IF;
                                 ELSE
                                    WRITE("TEST CASE FAILED");   
                                 END IF;
                        WHEN "10" =>
                                 IF (writeaddr(i) = readaddr(i)) THEN
                                    IF (writedata(i)(31 DOWNTO 16) = readdata(i)(31 DOWNTO 16)) THEN
                                     WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)));   
                                       WRITE("TEST CASE PASSED");   
                                       counter := counter + 1;    
                                       IF (counter = DEPTH) THEN
                                          WRITE("************** AHB_DWIDTH = 16 ****************");
                                          WRITE("****** WR_SIZE = 1 and RD_SIZE = 1*********");
                                          WRITE("TOTAL TESTCASE PASSED");   
                                          counter := 0;    
                                       END IF;
                                    ELSE
                                      WRITE("----DATA MISMACHED-----");
                                    END IF;
                                 ELSE
                                    WRITE("TEST CASE FAILED");   
                                 END IF;
                        WHEN OTHERS =>
                                 WRITE("IAM IN TO HALFWORD----");
                                       WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)));   
                                 NULL;
                        
                     END CASE;
            WHEN "00" =>
                     CASE writeaddr(i)(1 DOWNTO 0) IS
                        WHEN "00" =>
                                 IF (writeaddr(i) = readaddr(i)) THEN
                                    IF (writedata(i)(7 DOWNTO 0) = readdata(i)(7 DOWNTO 0)) THEN
                                       WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)(7 DOWNTO 0)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)(7 DOWNTO 0)));   
                                       WRITE("TEST CASE PASSED");   
                                       counter := counter + 1;    
                                       IF (counter = DEPTH) THEN
                                          WRITE("************** AHB_DWIDTH = 08 ****************");
                                          WRITE("****** WR_SIZE = 0 and RD_SIZE = 0*********");
                                          WRITE("TOTAL TESTCASE PASSED");
                                          END_OF_SIMULATIONS <= TRUE;
                                          counter := 0;    
                                       END IF;
                                    ELSE
                                      WRITE("----DATA MISMACHED-----");
                                    END IF;
                                 ELSE
                                    WRITE("TEST CASE FAILED");   
                                 END IF;
                        WHEN "01" =>
                                 IF (writeaddr(i) = readaddr(i)) THEN
                                    IF (writedata(i)(15 DOWNTO 8) = readdata(i)(15 DOWNTO 8)) THEN
                                       WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)(15 DOWNTO 8)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)(15 DOWNTO 8)));   
                                       WRITE("TEST CASE PASSED");   
                                       counter := counter + 1;    
                                       IF (counter = DEPTH) THEN
                                          WRITE("************** AHB_DWIDTH = 08 ****************");
                                          WRITE("****** WR_SIZE = 0 and RD_SIZE = 0*********");
                                          WRITE("TOTAL TESTCASE PASSED");   
                                           END_OF_SIMULATIONS <= TRUE;
                                          counter := 0;    
                                       END IF;
                                    ELSE
                                      WRITE("----DATA MISMACHED-----");
                                    END IF;
                                 ELSE
                                    WRITE("TEST CASE FAILED");   
                                 END IF;
                        WHEN "10" =>
                                 IF (writeaddr(i) = readaddr(i)) THEN
                                    IF (writedata(i)(23 DOWNTO 16) = readdata(i)(23 DOWNTO 16)) THEN
                                       WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)(23 DOWNTO 16)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)(23 DOWNTO 16)));   
                                       WRITE("TEST CASE PASSED");   
                                       counter := counter + 1;    
                                       IF (counter = DEPTH) THEN
                                          WRITE("************** AHB_DWIDTH = 08 ****************");
                                          WRITE("****** WR_SIZE = 0 and RD_SIZE = 0*********");
                                          WRITE("TOTAL TESTCASE PASSED");   
                                          END_OF_SIMULATIONS <= TRUE;
                                          counter := 0;    
                                       END IF;
                                    ELSE
                                      WRITE("----DATA MISMACHED-----");
                                    END IF;
                                 ELSE
                                    WRITE("TEST CASE FAILED");   
                                 END IF;
                        WHEN "11" =>
                                 IF (writeaddr(i) = readaddr(i)) THEN
                                    IF (writedata(i)(31 DOWNTO 24) = readdata(i)(31 DOWNTO 24)) THEN
                                       WRITE(" WRITE ADDRESS = " & to_hexstring(writeaddr(i)) & ", WRITE_DATA = " & to_hexstring(writedata(i)(31 DOWNTO 24)) & ", READ_ADDRESS = " & to_hexstring(readaddr(i)) & ", READ_DATA =" & to_hexstring(readdata(i)(31 DOWNTO 24)));   
                                       WRITE("TEST CASE PASSED");   
                                       counter := counter + 1;    
                                       IF (counter = DEPTH) THEN
                                          WRITE("************** AHB_DWIDTH = 08 ****************");
                                          WRITE("****** WR_SIZE = 0 and RD_SIZE = 0*********");
                                          WRITE("TOTAL TESTCASE PASSED"); 
                                          END_OF_SIMULATIONS <= TRUE;
                                          counter := 0;    
                                       END IF;
                                    ELSE
                                         WRITE("----DATA MISMACHED-----");
                                    END IF;
                                 ELSE
                                    WRITE("TEST CASE FAILED");   
                                 END IF;
                        WHEN OTHERS =>
                                 NULL;
                        
                     END CASE;
            WHEN OTHERS =>
                     NULL;
            
         END CASE;
         i := i + 1;
      END LOOP;
   END ahb_compare;

  PROCEDURE dut_reset IS
    BEGIN
      nreset <= '1' AFTER 2 * xhdl_timescale;    
   END dut_reset;

      VARIABLE xhdl_initial : BOOLEAN := TRUE;
   BEGIN
       IF (xhdl_initial) THEN
         dut_reset;   
         iter <= 3;

         IF(SEL_SRAM_TYPE = 1) THEN
            -- DEPTH32 <= USRAM_NUM_LOCATIONS_DWIDTH32/4;
             --DEPTH16 <= USRAM_NUM_LOCATIONS_DWIDTH32/2;
             --DEPTH08 <= USRAM_NUM_LOCATIONS_DWIDTH32/1;
             DEPTH32 <= INTERM_VAL_USRAM;
             DEPTH16 <= INTERM_VAL_USRAM*2;
             DEPTH08 <= INTERM_VAL_USRAM*4;
         ELSE
             --DEPTH32 <= LSRAM_NUM_LOCATIONS_DWIDTH32/4;
             --DEPTH16 <= LSRAM_NUM_LOCATIONS_DWIDTH32/2;
             --DEPTH08 <= LSRAM_NUM_LOCATIONS_DWIDTH32/1;
             DEPTH32 <= INTERM_VAL_LSRAM;
             DEPTH16 <= INTERM_VAL_LSRAM*2;
             DEPTH08 <= INTERM_VAL_LSRAM*4;
         END IF;

         WAIT FOR 100 * xhdl_timescale;
         WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
         
         -- FIRST TRANSACTIONS
         WRITE("FIRST TRANSACTIONS");
         burst <= SINGLE;    
         size <= WORD;    
         ahb_write(HCLK, burst, size,  DEPTH32, writeaddr, writedata );   
         
         ahb_read(HCLK,burst, size, DEPTH32, readaddr, readdata );   
         
         ahb_compare(size, DEPTH32, writeaddr, readaddr, writedata, readdata);   
        
         WAIT FOR 100 * xhdl_timescale;
         WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
        
         WRITE("SECOND TRANSACTIONS");
         -- SECOND TRANSACTIONS
         burst <= SINGLE;    
         size <= HALFWORD;    
         
         ahb_write(HCLK, burst, size, DEPTH16, writeaddr, writedata);   
         
         ahb_read(HCLK,burst, size, DEPTH16, readaddr, readdata );   
         
         ahb_compare(size, DEPTH16, writeaddr, readaddr, writedata, readdata);

         WAIT FOR 100 * xhdl_timescale;
         WAIT UNTIL (HCLK'EVENT AND HCLK = '1');
         
         WRITE("THIRD TRANSACTIONS");
         -- THIRD TRANSACTIONS
         burst <= SINGLE;    
         size <= BYTE;    
         
         ahb_write(HCLK, burst, size, DEPTH08, writeaddr, writedata);   
         
         ahb_read(HCLK, burst, size, DEPTH08, readaddr, readdata );   
         
         ahb_compare(size, DEPTH08, writeaddr, readaddr, writedata, readdata);   
         xhdl_initial := FALSE;
      ELSE
         WAIT;
      END IF;

   END PROCESS;
   HRESETN <= nreset ;

   PROCESS
   BEGIN
      HCLK <= '0';
      WAIT FOR AHB_CLK_PERIOD * 1 ns;
      HCLK <= '1';    
      WAIT FOR AHB_CLK_PERIOD * 1 ns;
      IF(END_OF_SIMULATIONS) THEN
           WAIT;
      END IF;
   END PROCESS;

   PROCESS
      VARIABLE xhdl_initial : BOOLEAN := TRUE;

   BEGIN
      
      IF (xhdl_initial) THEN
         start_waddr <= (OTHERS => '0');    
         start_raddr <= (OTHERS => '0');    
         xhdl_initial := FALSE;
      ELSE
         WAIT;
      END IF;

   END PROCESS;


   HREADYIN <= HREADYOUT ;

   COREAHBLSRAM_0 : CertificationSystem_sb_COREAHBLSRAM_0_0_COREAHBLSRAM 
      GENERIC MAP (
         SEL_SRAM_TYPE => SEL_SRAM_TYPE,
         LSRAM_NUM_LOCATIONS_DWIDTH32 => (LSRAM_NUM_LOCATIONS_DWIDTH32),
         AHB_AWIDTH => AHB_AWIDTH,
         USRAM_NUM_LOCATIONS_DWIDTH32 => (USRAM_NUM_LOCATIONS_DWIDTH32),
         AHB_DWIDTH => AHB_DWIDTH,
         FAMILY => FAMILY)
      PORT MAP (
         HCLK => HCLK,
         HRESETN => HRESETN,
         HSEL => HSEL,
         HWRITE => HWRITE,
         HADDR => HADDR,
         HWDATA => HWDATA,
         HRDATA => HRDATA,
         HSIZE => HSIZE,
         HTRANS => HTRANS,
         HBURST => HBURST,
         HRESP => HRESP,
         HREADYIN => HREADYIN,
         HREADYOUT => HREADYOUT);   
   

END translated;
