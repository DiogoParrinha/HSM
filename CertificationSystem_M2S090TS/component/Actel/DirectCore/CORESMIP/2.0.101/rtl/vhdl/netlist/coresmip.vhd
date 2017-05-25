-- ***********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	CoreSMIP
--              Zeroizes device on request or on tamper detection.
--
--
-- SVN Revision Information:
-- SVN $Revision: 22803 $
-- SVN $Date: 2014-05-30 23:38:57 +0100 (Fri, 30 May 2014) $
--
-- Notes:
--
-- ***********************************************************************/

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity CORESMIP is
    generic(
        -- Possible settings for ZEROIZATION_LEVEL parameter are:
        --   3 - No zeroization occurs
        --   2 - Part erased and left "like new", can be reprogrammed
        --   1 - Part erased, can be recovered
        --   0 - Part erased
        ZEROIZATION_LEVEL : integer := 3
    );
    port( CLK                  : in    std_logic;
          RESET_N              : in    std_logic;
          ERASE_P              : in    std_logic;
          ERASE_N              : in    std_logic;
          RESET_WATCHDOG_P     : in    std_logic;
          RESET_WATCHDOG_N     : in    std_logic;
          HEARTBEAT            : out   std_logic;
          JTAG_ACTIVE          : out   std_logic;
          LOCK_TAMPER_DETECT   : out   std_logic;
          MESH_SHORT_ERROR     : out   std_logic;
          DIGEST_ERROR         : out   std_logic;
          POWERUP_DIGEST_ERROR : out   std_logic;
          SC_ROM_DIGEST_ERROR  : out   std_logic;
          PASSCODE_ERROR       : out   std_logic;
          MASTER_ALARM         : out   std_logic
        );

end CORESMIP;

architecture DEF_ARCH of CORESMIP is

    -----------------------------------------------------------------------
    -- Functions
    -----------------------------------------------------------------------
    function set_zeroize_config (x : in integer) return string is
        constant zero_disabled          : string := "UNCHANGED";
        constant zero_like_new          : string := "LIKE_NEW";
        constant zero_recoverable       : string := "RECOVERABLE";
        constant zero_non_recoverable   : string := "NON_RECOVERABLE";
    begin
        if x = 3 then
            return zero_disabled;
        elsif x = 2 then
            return zero_like_new;
        elsif x = 1 then
            return zero_recoverable;
        else
            return zero_non_recoverable;
        end if;
    end function set_zeroize_config;

    -----------------------------------------------------------------------
    -- Constants
    -----------------------------------------------------------------------
    constant ZEROIZE_CONFIG : string
        := set_zeroize_config (ZEROIZATION_LEVEL);


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

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component TAMPER
    generic (ZEROIZE_CONFIG:string := "";
        POWERUP_DIGEST_ERROR_CONFIG:string := "";
        CLK_ERROR_CONFIG:integer := 0);

    port( JTAG_ACTIVE          : out   std_logic;
          LOCK_TAMPER_DETECT   : out   std_logic;
          MESH_SHORT_ERROR     : out   std_logic;
          CLK_ERROR            : out   std_logic;
          DETECT_CATEGORY      : out   std_logic_vector(3 downto 0);
          DETECT_ATTEMPT       : out   std_logic;
          DETECT_FAIL          : out   std_logic;
          DIGEST_ERROR         : out   std_logic;
          POWERUP_DIGEST_ERROR : out   std_logic;
          SC_ROM_DIGEST_ERROR  : out   std_logic;
          TAMPER_CHANGE_STROBE : out   std_logic;
          LOCKDOWN_ALL_N       : in    std_logic := 'U';
          DISABLE_ALL_IOS_N    : in    std_logic := 'U';
          RESET_N              : in    std_logic := 'U';
          ZEROIZE_N            : in    std_logic := 'U'
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

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \HEARTBEAT\, \JTAG_ACTIVE\, \LOCK_TAMPER_DETECT\,
        \MESH_SHORT_ERROR\, \DIGEST_ERROR\,
        \POWERUP_DIGEST_ERROR\, \SC_ROM_DIGEST_ERROR\,
        \PASSCODE_ERROR\, \DETECT_CATEGORY[0]\,
        \DETECT_CATEGORY[1]\, \DETECT_CATEGORY[2]\,
        \DETECT_CATEGORY[3]\, DETECT_FAIL, VCC_net_1, \ZEROIZE_N\,
        \DETECT_CATEGORY_q2[0]_net_1\,
        \DETECT_CATEGORY_q2[1]_net_1\,
        \DETECT_CATEGORY_q2[2]_net_1\, \wdog_count[0]_net_1\,
        \wdog_count[1]_net_1\, \wdog_count[2]_net_1\,
        \wdog_count[3]_net_1\, \wdog_count[4]_net_1\,
        \wdog_count[5]_net_1\, \wdog_count[6]_net_1\,
        \wdog_count[7]_net_1\, \wdog_count[8]_net_1\,
        \wdog_count[9]_net_1\, \ERASE_N_q2\, \RESET_N_q2\,
        \HEARTBEAT_COUNT[0]_net_1\, \RESET_WATCHDOG_P_q4\,
        \RESET_WATCHDOG_N_q2\, \MASTER_ALARM\, GND_net_1,
        \RESET_N_q1\, \MASTER_ALARM_q2\, \MASTER_ALARM_q1\,
        \DETECT_FAIL_q1\, \DETECT_CATEGORY_q1[0]_net_1\,
        \DETECT_CATEGORY_q1[1]_net_1\,
        \DETECT_CATEGORY_q1[2]_net_1\,
        \DETECT_CATEGORY_q1[3]_net_1\, \RESET_WATCHDOG_N_q1\,
        \RESET_WATCHDOG_P_q1\, \ERASE_P_q1\, \ERASE_N_q1\,
        \RESET_WATCHDOG_N_q4\, \RESET_WATCHDOG_N_q3\,
        \RESET_WATCHDOG_P_q2\, \RESET_WATCHDOG_P_q3\,
        \DETECT_FAIL_q2\, \DETECT_CATEGORY_q2[3]_net_1\,
        \ERASE_P_q2\, \wdog_timeout\, \un11_master_alarm_d1\,
        \un1_heartbeat_count\, \HEARTBEAT_COUNT_3[0]_net_1\,
        \wdog_count_1_sqmuxa\, \un1_wdog_count_1[1]\,
        \un1_wdog_count_1[2]\, \un1_wdog_count_1[3]\,
        \un1_wdog_count_1[4]\, \un1_wdog_count_1[5]\,
        \un1_wdog_count_1[6]\, \un1_wdog_count_1[7]\,
        \un1_wdog_count_1[8]\, \un1_wdog_count_1[9]\,
        \HEARTBEAT_COUNT_3[3]_net_1\,
        \HEARTBEAT_COUNT_3[5]_net_1\,
        \HEARTBEAT_COUNT_3[6]_net_1\,
        \HEARTBEAT_COUNT_3[7]_net_1\,
        \HEARTBEAT_COUNT_3[8]_net_1\,
        \HEARTBEAT_COUNT_3[9]_net_1\, \wdog_count_5[0]\,
        \wdog_count_5[1]\, \wdog_count_5[2]\, \wdog_count_5[3]\,
        \wdog_count_5[4]\, \wdog_count_5[5]\, \wdog_count_5[6]\,
        \wdog_count_5[7]\, \wdog_count_5[8]\, \wdog_count_5[9]\,
        N_43, N_47, \un10_enable_wdog\, \un6_enable_wdog\,
        \un1_RESET_WATCHDOG_P_q2[0]_net_1\, N_79, N_80, N_81,
        N_82, N_83, N_84, N_85, N_86, N_87,
        \HEARTBEAT_COUNT[1]_net_1\, \un5_heartbeat_count_1_cry_1\,
        \HEARTBEAT_COUNT[2]_net_1\, \un5_heartbeat_count_1_cry_2\,
        \HEARTBEAT_COUNT[3]_net_1\, \un5_heartbeat_count_1_cry_3\,
        \HEARTBEAT_COUNT[4]_net_1\, \un5_heartbeat_count_1_cry_4\,
        \HEARTBEAT_COUNT[5]_net_1\, \un5_heartbeat_count_1_cry_5\,
        \HEARTBEAT_COUNT[6]_net_1\, \un5_heartbeat_count_1_cry_6\,
        \HEARTBEAT_COUNT[7]_net_1\, \un5_heartbeat_count_1_cry_7\,
        \HEARTBEAT_COUNT[8]_net_1\, \un5_heartbeat_count_1_cry_8\,
        \HEARTBEAT_COUNT[9]_net_1\, \un1_wdog_count_1_cry_0\,
        \un1_wdog_count_1_cry_1\, \un1_wdog_count_1_cry_2\,
        \un1_wdog_count_1_cry_3\, \un1_wdog_count_1_cry_4\,
        \un1_wdog_count_1_cry_5\, \un1_wdog_count_1_cry_6\,
        \un1_wdog_count_1_cry_7\, \un1_wdog_count_1_cry_8\,
        \un11_master_alarm_d1_3\, \un6_detect_category_q2_1\,
        \un10_enable_wdog_5\, \un10_enable_wdog_6\,
        \un1_heartbeat_count_4\, \un1_heartbeat_count_5\,
        HEARTBEAT_int_i_0, \enable_wdog_fast\, N_161, N_185,
        N_186 : std_logic;

attribute syn_noclockbuf : boolean;
attribute syn_noclockbuf of \RESET_N_q2\ : signal is true;

begin

    \RESET_N_q2\ <= N_186;

    HEARTBEAT <= \HEARTBEAT\;
    JTAG_ACTIVE <= \JTAG_ACTIVE\;
    LOCK_TAMPER_DETECT <= \LOCK_TAMPER_DETECT\;
    MESH_SHORT_ERROR <= \MESH_SHORT_ERROR\;
    DIGEST_ERROR <= \DIGEST_ERROR\;
    POWERUP_DIGEST_ERROR <= \POWERUP_DIGEST_ERROR\;
    SC_ROM_DIGEST_ERROR <= \SC_ROM_DIGEST_ERROR\;
    PASSCODE_ERROR <= \PASSCODE_ERROR\;
    MASTER_ALARM <= \MASTER_ALARM\;

    \wdog_count[7]\ : SLE
      port map(D => \wdog_count_5[7]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => GND_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[7]_net_1\);

    un11_master_alarm_d1_3 : CFG4
      generic map(INIT => x"FFFE")

      port map(A => \MESH_SHORT_ERROR\, B => \LOCK_TAMPER_DETECT\,
        C => \JTAG_ACTIVE\, D => \DIGEST_ERROR\, Y =>
        \un11_master_alarm_d1_3\);

    RESET_WATCHDOG_N_q3 : SLE
      port map(D => \RESET_WATCHDOG_N_q2\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_N_q3\);

    RESET_WATCHDOG_N_q1 : SLE
      port map(D => RESET_WATCHDOG_N, CLK => CLK, EN => VCC_net_1,
        ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1,
        SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_N_q1\);

    RESET_WATCHDOG_N_q4 : SLE
      port map(D => \RESET_WATCHDOG_N_q3\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_N_q4\);

    \HEARTBEAT_COUNT_3[9]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \un1_heartbeat_count\, B => N_87, Y =>
        \HEARTBEAT_COUNT_3[9]_net_1\);

    RESET_WATCHDOG_N_q2 : SLE
      port map(D => \RESET_WATCHDOG_N_q1\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_N_q2\);

    \DETECT_CATEGORY_q2[3]\ : SLE
      port map(D => \DETECT_CATEGORY_q1[3]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q2[3]_net_1\);

    \DETECT_CATEGORY_q1[3]\ : SLE
      port map(D => \DETECT_CATEGORY[3]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q1[3]_net_1\);

    PASSCODE_ERROR_int : SLE
      port map(D => VCC_net_1, CLK => CLK, EN => N_47, ALn =>
        \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q => \PASSCODE_ERROR\);

    un1_heartbeat_count : CFG4
      generic map(INIT => x"4000")

      port map(A => \HEARTBEAT_COUNT[1]_net_1\, B =>
        \HEARTBEAT_COUNT[9]_net_1\, C => \un1_heartbeat_count_5\,
        D => \un1_heartbeat_count_4\, Y => \un1_heartbeat_count\);

    \HEARTBEAT_COUNT_3[3]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \un1_heartbeat_count\, B => N_81, Y =>
        \HEARTBEAT_COUNT_3[3]_net_1\);

    \wdog_count_RNO[0]\ : CFG4
      generic map(INIT => x"444C")

      port map(A => \MASTER_ALARM\, B => N_185, C =>
        \un6_enable_wdog\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[0]\);

    un1_wdog_count_1_s_9 : ARI1
      generic map(INIT => x"46600")

      port map(A => VCC_net_1, B => \MASTER_ALARM\, C =>
        \wdog_count[9]_net_1\, D => GND_net_1, FCI =>
        \un1_wdog_count_1_cry_8\, S => \un1_wdog_count_1[9]\, Y
         => OPEN, FCO => OPEN);

    MASTER_ALARM_q2 : SLE
      port map(D => \MASTER_ALARM_q1\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \MASTER_ALARM_q2\);

    un5_heartbeat_count_1_cry_3 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[3]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_2\, S => N_81, Y => OPEN, FCO
         => \un5_heartbeat_count_1_cry_3\);

    un10_enable_wdog : CFG4
      generic map(INIT => x"1000")

      port map(A => \wdog_count[8]_net_1\, B =>
        \wdog_count[0]_net_1\, C => \un10_enable_wdog_6\, D =>
        \un10_enable_wdog_5\, Y => \un10_enable_wdog\);

    \HEARTBEAT_COUNT[1]\ : SLE
      port map(D => N_79, CLK => CLK, EN => VCC_net_1, ALn =>
        \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[1]_net_1\);

    \DETECT_CATEGORY_q2[2]\ : SLE
      port map(D => \DETECT_CATEGORY_q1[2]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q2[2]_net_1\);

    \wdog_count[5]\ : SLE
      port map(D => \wdog_count_5[5]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => GND_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[5]_net_1\);

    tmpr : TAMPER
      generic map(ZEROIZE_CONFIG => ZEROIZE_CONFIG,
         POWERUP_DIGEST_ERROR_CONFIG => "FABRIC_ENVM_0",
         CLK_ERROR_CONFIG => 15)

      port map(JTAG_ACTIVE => \JTAG_ACTIVE\, LOCK_TAMPER_DETECT
         => \LOCK_TAMPER_DETECT\, MESH_SHORT_ERROR =>
        \MESH_SHORT_ERROR\, CLK_ERROR => OPEN, DETECT_CATEGORY(3)
         => \DETECT_CATEGORY[3]\, DETECT_CATEGORY(2) =>
        \DETECT_CATEGORY[2]\, DETECT_CATEGORY(1) =>
        \DETECT_CATEGORY[1]\, DETECT_CATEGORY(0) =>
        \DETECT_CATEGORY[0]\, DETECT_ATTEMPT => OPEN, DETECT_FAIL
         => DETECT_FAIL, DIGEST_ERROR => \DIGEST_ERROR\,
        POWERUP_DIGEST_ERROR => \POWERUP_DIGEST_ERROR\,
        SC_ROM_DIGEST_ERROR => \SC_ROM_DIGEST_ERROR\,
        TAMPER_CHANGE_STROBE => OPEN, LOCKDOWN_ALL_N => VCC_net_1,
        DISABLE_ALL_IOS_N => VCC_net_1, RESET_N => VCC_net_1,
        ZEROIZE_N => \ZEROIZE_N\);

    \wdog_count[3]\ : SLE
      port map(D => \wdog_count_5[3]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => GND_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[3]_net_1\);

    \wdog_count[8]\ : SLE
      port map(D => \wdog_count_5[8]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => GND_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[8]_net_1\);

    \wdog_count_RNO[2]\ : CFG4
      generic map(INIT => x"444C")

      port map(A => \MASTER_ALARM\, B => \un1_wdog_count_1[2]\, C
         => \un6_enable_wdog\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[2]\);

    \HEARTBEAT_COUNT[0]\ : SLE
      port map(D => \HEARTBEAT_COUNT_3[0]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[0]_net_1\);

    \VCC\ : VCC
      port map(Y => VCC_net_1);

    un5_heartbeat_count_1_cry_4 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[4]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_3\, S => N_82, Y => OPEN, FCO
         => \un5_heartbeat_count_1_cry_4\);

    \HEARTBEAT_COUNT[9]\ : SLE
      port map(D => \HEARTBEAT_COUNT_3[9]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[9]_net_1\);

    un5_heartbeat_count_1_cry_5 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[5]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_4\, S => N_83, Y => OPEN, FCO
         => \un5_heartbeat_count_1_cry_5\);

    RESET_N_q2 : SLE
      port map(D => \RESET_N_q1\, CLK => CLK, EN => VCC_net_1,
        ALn => RESET_N, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => N_186);

    un10_enable_wdog_6 : CFG4
      generic map(INIT => x"0001")

      port map(A => \wdog_count[4]_net_1\, B =>
        \wdog_count[3]_net_1\, C => \wdog_count[2]_net_1\, D =>
        \wdog_count[1]_net_1\, Y => \un10_enable_wdog_6\);

    MASTER_ALARM_q1 : SLE
      port map(D => \un11_master_alarm_d1\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \MASTER_ALARM_q1\);

    un1_wdog_count_1_cry_1 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \enable_wdog_fast\, B =>
        \wdog_count[1]_net_1\, C => GND_net_1, D => GND_net_1,
        FCI => \un1_wdog_count_1_cry_0\, S =>
        \un1_wdog_count_1[1]\, Y => OPEN, FCO =>
        \un1_wdog_count_1_cry_1\);

    ZEROIZE_N : SLE
      port map(D => GND_net_1, CLK => CLK, EN => N_43, ALn =>
        \RESET_N_q2\, ADn => GND_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q => \ZEROIZE_N\);

    wdog_count_1_sqmuxa : CFG3
      generic map(INIT => x"20")

      port map(A => \MASTER_ALARM\, B => \un6_enable_wdog\, C =>
        \un10_enable_wdog\, Y => \wdog_count_1_sqmuxa\);

    un5_heartbeat_count_1_cry_6 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[6]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_5\, S => N_84, Y => OPEN, FCO
         => \un5_heartbeat_count_1_cry_6\);

    un11_master_alarm_d1 : CFG4
      generic map(INIT => x"FFFE")

      port map(A => \PASSCODE_ERROR\, B => \SC_ROM_DIGEST_ERROR\,
        C => \POWERUP_DIGEST_ERROR\, D =>
        \un11_master_alarm_d1_3\, Y => \un11_master_alarm_d1\);

    \DETECT_CATEGORY_q2[0]\ : SLE
      port map(D => \DETECT_CATEGORY_q1[0]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q2[0]_net_1\);

    \wdog_count_5_iv[3]\ : CFG4
      generic map(INIT => x"E4EC")

      port map(A => \MASTER_ALARM\, B => \un1_wdog_count_1[3]\, C
         => \un6_enable_wdog\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[3]\);

    un8_erase_p_q2 : CFG3
      generic map(INIT => x"EF")

      port map(A => \wdog_timeout\, B => \ERASE_P_q2\, C =>
        \ERASE_N_q2\, Y => N_43);

    \HEARTBEAT_COUNT[8]\ : SLE
      port map(D => \HEARTBEAT_COUNT_3[8]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[8]_net_1\);

    un5_heartbeat_count_1_cry_7 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[7]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_6\, S => N_85, Y => OPEN, FCO
         => \un5_heartbeat_count_1_cry_7\);

    un5_heartbeat_count_1_cry_1 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[1]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => N_161, S => N_79, Y
         => OPEN, FCO => \un5_heartbeat_count_1_cry_1\);

    \HEARTBEAT_COUNT_3[0]\ : CFG2
      generic map(INIT => x"1")

      port map(A => \un1_heartbeat_count\, B =>
        \HEARTBEAT_COUNT[0]_net_1\, Y =>
        \HEARTBEAT_COUNT_3[0]_net_1\);

    \wdog_count[4]\ : SLE
      port map(D => \wdog_count_5[4]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[4]_net_1\);

    wdog_timeout : SLE
      port map(D => VCC_net_1, CLK => CLK, EN =>
        \wdog_count_1_sqmuxa\, ALn => \RESET_N_q2\, ADn =>
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT =>
        GND_net_1, Q => \wdog_timeout\);

    un1_wdog_count_1_cry_7 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \MASTER_ALARM\, B => \wdog_count[7]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un1_wdog_count_1_cry_6\, S => \un1_wdog_count_1[7]\, Y
         => OPEN, FCO => \un1_wdog_count_1_cry_7\);

    \DETECT_CATEGORY_q1[1]\ : SLE
      port map(D => \DETECT_CATEGORY[1]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q1[1]_net_1\);

    \DETECT_CATEGORY_q1[2]\ : SLE
      port map(D => \DETECT_CATEGORY[2]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q1[2]_net_1\);

    un1_heartbeat_count_5 : CFG4
      generic map(INIT => x"8000")

      port map(A => \HEARTBEAT_COUNT[8]_net_1\, B =>
        \HEARTBEAT_COUNT[7]_net_1\, C =>
        \HEARTBEAT_COUNT[6]_net_1\, D =>
        \HEARTBEAT_COUNT[5]_net_1\, Y => \un1_heartbeat_count_5\);

    un1_wdog_count_1_cry_3 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \enable_wdog_fast\, B =>
        \wdog_count[3]_net_1\, C => GND_net_1, D => GND_net_1,
        FCI => \un1_wdog_count_1_cry_2\, S =>
        \un1_wdog_count_1[3]\, Y => OPEN, FCO =>
        \un1_wdog_count_1_cry_3\);

    un1_wdog_count_1_cry_4 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \enable_wdog_fast\, B =>
        \wdog_count[4]_net_1\, C => GND_net_1, D => GND_net_1,
        FCI => \un1_wdog_count_1_cry_3\, S =>
        \un1_wdog_count_1[4]\, Y => OPEN, FCO =>
        \un1_wdog_count_1_cry_4\);

    \GND\ : GND
      port map(Y => GND_net_1);

    \wdog_count[6]\ : SLE
      port map(D => \wdog_count_5[6]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => GND_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[6]_net_1\);

    DETECT_FAIL_q1 : SLE
      port map(D => DETECT_FAIL, CLK => CLK, EN => VCC_net_1, ALn
         => \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1, SD
         => GND_net_1, LAT => GND_net_1, Q => \DETECT_FAIL_q1\);

    \wdog_count_RNO[4]\ : CFG4
      generic map(INIT => x"444C")

      port map(A => \MASTER_ALARM\, B => \un1_wdog_count_1[4]\, C
         => \un6_enable_wdog\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[4]\);

    ERASE_N_q2 : SLE
      port map(D => \ERASE_N_q1\, CLK => CLK, EN => VCC_net_1,
        ALn => \RESET_N_q2\, ADn => GND_net_1, SLn => VCC_net_1,
        SD => GND_net_1, LAT => GND_net_1, Q => \ERASE_N_q2\);

    un10_enable_wdog_5 : CFG4
      generic map(INIT => x"0001")

      port map(A => \wdog_count[9]_net_1\, B =>
        \wdog_count[7]_net_1\, C => \wdog_count[6]_net_1\, D =>
        \wdog_count[5]_net_1\, Y => \un10_enable_wdog_5\);

    un6_enable_wdog : CFG4
      generic map(INIT => x"44C0")

      port map(A => \RESET_WATCHDOG_N_q2\, B =>
        \un1_RESET_WATCHDOG_P_q2[0]_net_1\, C =>
        \RESET_WATCHDOG_N_q4\, D => \RESET_WATCHDOG_N_q3\, Y =>
        \un6_enable_wdog\);

    \wdog_count_5_iv[6]\ : CFG4
      generic map(INIT => x"D8F8")

      port map(A => \MASTER_ALARM\, B => \un6_enable_wdog\, C =>
        \un1_wdog_count_1[6]\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[6]\);

    \un1_RESET_WATCHDOG_P_q2[0]\ : CFG3
      generic map(INIT => x"74")

      port map(A => \RESET_WATCHDOG_P_q4\, B =>
        \RESET_WATCHDOG_P_q3\, C => \RESET_WATCHDOG_P_q2\, Y =>
        \un1_RESET_WATCHDOG_P_q2[0]_net_1\);

    \DETECT_CATEGORY_q2[1]\ : SLE
      port map(D => \DETECT_CATEGORY_q1[1]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q2[1]_net_1\);

    un5_heartbeat_count_1_cry_2 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[2]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_1\, S => N_80, Y => OPEN, FCO
         => \un5_heartbeat_count_1_cry_2\);

    \HEARTBEAT_COUNT[3]\ : SLE
      port map(D => \HEARTBEAT_COUNT_3[3]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[3]_net_1\);

    \wdog_count_RNO[1]\ : CFG4
      generic map(INIT => x"444C")

      port map(A => \MASTER_ALARM\, B => \un1_wdog_count_1[1]\, C
         => \un6_enable_wdog\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[1]\);

    un5_heartbeat_count_1_cry_8 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[8]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_7\, S => N_86, Y => OPEN, FCO
         => \un5_heartbeat_count_1_cry_8\);

    RESET_N_q1 : SLE
      port map(D => VCC_net_1, CLK => CLK, EN => VCC_net_1, ALn
         => RESET_N, ADn => VCC_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q => \RESET_N_q1\);

    \HEARTBEAT_COUNT[6]\ : SLE
      port map(D => \HEARTBEAT_COUNT_3[6]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[6]_net_1\);

    \HEARTBEAT_COUNT_3[5]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \un1_heartbeat_count\, B => N_83, Y =>
        \HEARTBEAT_COUNT_3[5]_net_1\);

    un1_wdog_count_1_cry_0 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \enable_wdog_fast\, B =>
        \wdog_count[0]_net_1\, C => GND_net_1, D => GND_net_1,
        FCI => GND_net_1, S => OPEN, Y => N_185, FCO =>
        \un1_wdog_count_1_cry_0\);

    \HEARTBEAT_COUNT[7]\ : SLE
      port map(D => \HEARTBEAT_COUNT_3[7]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[7]_net_1\);

    \HEARTBEAT_COUNT_3[8]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \un1_heartbeat_count\, B => N_86, Y =>
        \HEARTBEAT_COUNT_3[8]_net_1\);

    ERASE_P_q2 : SLE
      port map(D => \ERASE_P_q1\, CLK => CLK, EN => VCC_net_1,
        ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1,
        SD => GND_net_1, LAT => GND_net_1, Q => \ERASE_P_q2\);

    ERASE_N_q1 : SLE
      port map(D => ERASE_N, CLK => CLK, EN => VCC_net_1, ALn =>
        \RESET_N_q2\, ADn => GND_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q => \ERASE_N_q1\);

    un6_detect_category_q2 : CFG4
      generic map(INIT => x"0040")

      port map(A => \DETECT_CATEGORY_q2[1]_net_1\, B =>
        \un6_detect_category_q2_1\, C =>
        \DETECT_CATEGORY_q2[3]_net_1\, D =>
        \DETECT_CATEGORY_q2[2]_net_1\, Y => N_47);

    un1_wdog_count_1_cry_5 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \MASTER_ALARM\, B => \wdog_count[5]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un1_wdog_count_1_cry_4\, S => \un1_wdog_count_1[5]\, Y
         => OPEN, FCO => \un1_wdog_count_1_cry_5\);

    RESET_WATCHDOG_P_q3 : SLE
      port map(D => \RESET_WATCHDOG_P_q2\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_P_q3\);

    enable_wdog : SLE
      port map(D => VCC_net_1, CLK => CLK, EN =>
        \MASTER_ALARM_q2\, ALn => \RESET_N_q2\, ADn => VCC_net_1,
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \MASTER_ALARM\);

    RESET_WATCHDOG_P_q1 : SLE
      port map(D => RESET_WATCHDOG_P, CLK => CLK, EN => VCC_net_1,
        ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1,
        SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_P_q1\);

    un6_detect_category_q2_1 : CFG2
      generic map(INIT => x"4")

      port map(A => \DETECT_CATEGORY_q2[0]_net_1\, B =>
        \DETECT_FAIL_q2\, Y => \un6_detect_category_q2_1\);

    un1_wdog_count_1_cry_2 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \enable_wdog_fast\, B =>
        \wdog_count[2]_net_1\, C => GND_net_1, D => GND_net_1,
        FCI => \un1_wdog_count_1_cry_1\, S =>
        \un1_wdog_count_1[2]\, Y => OPEN, FCO =>
        \un1_wdog_count_1_cry_2\);

    RESET_WATCHDOG_P_q4 : SLE
      port map(D => \RESET_WATCHDOG_P_q3\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_P_q4\);

    \HEARTBEAT_COUNT[2]\ : SLE
      port map(D => N_80, CLK => CLK, EN => VCC_net_1, ALn =>
        \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[2]_net_1\);

    RESET_WATCHDOG_P_q2 : SLE
      port map(D => \RESET_WATCHDOG_P_q1\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \RESET_WATCHDOG_P_q2\);

    HEARTBEAT_int_RNO : CFG1
      generic map(INIT => "01")

      port map(A => \HEARTBEAT\, Y => HEARTBEAT_int_i_0);

    enable_wdog_fast : SLE
      port map(D => VCC_net_1, CLK => CLK, EN =>
        \MASTER_ALARM_q2\, ALn => \RESET_N_q2\, ADn => VCC_net_1,
        SLn => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q
         => \enable_wdog_fast\);

    \HEARTBEAT_COUNT[5]\ : SLE
      port map(D => \HEARTBEAT_COUNT_3[5]_net_1\, CLK => CLK, EN
         => VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[5]_net_1\);

    un1_wdog_count_1_cry_6 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \MASTER_ALARM\, B => \wdog_count[6]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un1_wdog_count_1_cry_5\, S => \un1_wdog_count_1[6]\, Y
         => OPEN, FCO => \un1_wdog_count_1_cry_6\);

    DETECT_FAIL_q2 : SLE
      port map(D => \DETECT_FAIL_q1\, CLK => CLK, EN => VCC_net_1,
        ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1,
        SD => GND_net_1, LAT => GND_net_1, Q => \DETECT_FAIL_q2\);

    \DETECT_CATEGORY_q1[0]\ : SLE
      port map(D => \DETECT_CATEGORY[0]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \DETECT_CATEGORY_q1[0]_net_1\);

    \wdog_count[2]\ : SLE
      port map(D => \wdog_count_5[2]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[2]_net_1\);

    \wdog_count_5_iv[7]\ : CFG4
      generic map(INIT => x"D8F8")

      port map(A => \MASTER_ALARM\, B => \un6_enable_wdog\, C =>
        \un1_wdog_count_1[7]\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[7]\);

    \wdog_count_5_iv[8]\ : CFG4
      generic map(INIT => x"D8F8")

      port map(A => \MASTER_ALARM\, B => \un6_enable_wdog\, C =>
        \un1_wdog_count_1[8]\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[8]\);

    \wdog_count[0]\ : SLE
      port map(D => \wdog_count_5[0]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[0]_net_1\);

    un1_heartbeat_count_4 : CFG3
      generic map(INIT => x"04")

      port map(A => \HEARTBEAT_COUNT[4]_net_1\, B =>
        \HEARTBEAT_COUNT[3]_net_1\, C =>
        \HEARTBEAT_COUNT[2]_net_1\, Y => \un1_heartbeat_count_4\);

    \HEARTBEAT_COUNT_3[6]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \un1_heartbeat_count\, B => N_84, Y =>
        \HEARTBEAT_COUNT_3[6]_net_1\);

    \wdog_count_5_iv[9]\ : CFG4
      generic map(INIT => x"D8F8")

      port map(A => \MASTER_ALARM\, B => \un6_enable_wdog\, C =>
        \un1_wdog_count_1[9]\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[9]\);

    un5_heartbeat_count_1_s_1_12 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[0]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI => VCC_net_1, S =>
        OPEN, Y => OPEN, FCO => N_161);

    HEARTBEAT_int : SLE
      port map(D => HEARTBEAT_int_i_0, CLK => CLK, EN =>
        \un1_heartbeat_count\, ALn => \RESET_N_q2\, ADn =>
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT =>
        GND_net_1, Q => \HEARTBEAT\);

    ERASE_P_q1 : SLE
      port map(D => ERASE_P, CLK => CLK, EN => VCC_net_1, ALn =>
        \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q => \ERASE_P_q1\);

    un5_heartbeat_count_1_s_9 : ARI1
      generic map(INIT => x"4AA00")

      port map(A => VCC_net_1, B => \HEARTBEAT_COUNT[9]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un5_heartbeat_count_1_cry_8\, S => N_87, Y => OPEN, FCO
         => OPEN);

    \HEARTBEAT_COUNT_3[7]\ : CFG2
      generic map(INIT => x"4")

      port map(A => \un1_heartbeat_count\, B => N_85, Y =>
        \HEARTBEAT_COUNT_3[7]_net_1\);

    \HEARTBEAT_COUNT[4]\ : SLE
      port map(D => N_82, CLK => CLK, EN => VCC_net_1, ALn =>
        \RESET_N_q2\, ADn => VCC_net_1, SLn => VCC_net_1, SD =>
        GND_net_1, LAT => GND_net_1, Q =>
        \HEARTBEAT_COUNT[4]_net_1\);

    \wdog_count[9]\ : SLE
      port map(D => \wdog_count_5[9]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => GND_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[9]_net_1\);

    \wdog_count_5_iv[5]\ : CFG4
      generic map(INIT => x"D8F8")

      port map(A => \MASTER_ALARM\, B => \un6_enable_wdog\, C =>
        \un1_wdog_count_1[5]\, D => \un10_enable_wdog\, Y =>
        \wdog_count_5[5]\);

    \wdog_count[1]\ : SLE
      port map(D => \wdog_count_5[1]\, CLK => CLK, EN =>
        VCC_net_1, ALn => \RESET_N_q2\, ADn => VCC_net_1, SLn =>
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q =>
        \wdog_count[1]_net_1\);

    un1_wdog_count_1_cry_8 : ARI1
      generic map(INIT => x"555AA")

      port map(A => \MASTER_ALARM\, B => \wdog_count[8]_net_1\, C
         => GND_net_1, D => GND_net_1, FCI =>
        \un1_wdog_count_1_cry_7\, S => \un1_wdog_count_1[8]\, Y
         => OPEN, FCO => \un1_wdog_count_1_cry_8\);


end DEF_ARCH;
