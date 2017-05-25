-- ***********************************************************************/
-- Microsemi Corporation Proprietary and Confidential
-- Copyright 2014 Microsemi Corporation.  All rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
-- ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
-- IN ADVANCE IN WRITING.
--
-- Description:	CoreSMIP
--              Temporary description for TAMPER macro.
--              (Black box for synthesis, simple model for simulation.)
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

entity TAMPER is
        generic (
            ZEROIZE_CONFIG              : string := "";
            POWERUP_DIGEST_ERROR_CONFIG : string := "";
            CLK_ERROR_CONFIG            : integer := 0
        );
        port (
            -- Outputs
            JTAG_ACTIVE             : out std_logic;
            LOCK_TAMPER_DETECT      : out std_logic;
            MESH_SHORT_ERROR        : out std_logic;
            CLK_ERROR               : out std_logic;
            DETECT_CATEGORY         : out std_logic_vector(3 downto 0);
            DETECT_ATTEMPT          : out std_logic;
            DETECT_FAIL             : out std_logic;
            DIGEST_ERROR            : out std_logic;
            POWERUP_DIGEST_ERROR    : out std_logic;
            SC_ROM_DIGEST_ERROR     : out std_logic;
            TAMPER_CHANGE_STROBE    : out std_logic;
            -- Inputs
            LOCKDOWN_ALL_N          : in  std_logic;
            DISABLE_ALL_IOS_N       : in  std_logic;
            RESET_N                 : in  std_logic;
            ZEROIZE_N               : in  std_logic
        );
end TAMPER;

architecture def_arch of TAMPER is
    attribute syn_black_box : boolean;
    attribute syn_black_box of def_arch : architecture is true;
begin

end def_arch;
