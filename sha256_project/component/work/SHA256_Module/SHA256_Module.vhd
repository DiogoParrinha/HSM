----------------------------------------------------------------------
-- Created by SmartDesign Wed Jun 07 21:29:49 2017
-- Version: v11.7 SP1 11.7.1.14
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- SHA256_Module entity declaration
----------------------------------------------------------------------
entity SHA256_Module is
    -- Port list
    port(
        -- Inputs
        CLK                       : in  std_logic;
        RST_N                     : in  std_logic;
        data_in                   : in  std_logic_vector(31 downto 0);
        data_ready                : in  std_logic;
        data_wen                  : in  std_logic;
        result_addr               : in  std_logic_vector(3 downto 0);
        result_ren                : in  std_logic;
        waddr_in                  : in  std_logic_vector(4 downto 0);
        -- Outputs
        data_available            : out std_logic;
        data_available_lastbank_0 : out std_logic;
        data_available_lastbank_8 : out std_logic;
        data_out                  : out std_logic_vector(31 downto 0);
        data_out_ready            : out std_logic;
        di_req_o                  : out std_logic;
        do_valid_o                : out std_logic;
        error_o                   : out std_logic;
        state_out                 : out std_logic_vector(2 downto 0);
        waiting_data              : out std_logic
        );
end SHA256_Module;
----------------------------------------------------------------------
-- SHA256_Module architecture body
----------------------------------------------------------------------
architecture RTL of SHA256_Module is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- AND2
component AND2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- reg1_highonly
component reg1_highonly
    -- Port list
    port(
        -- Inputs
        CLK      : in  std_logic;
        RST_N    : in  std_logic;
        data_in  : in  std_logic;
        wen      : in  std_logic;
        -- Outputs
        data_out : out std_logic
        );
end component;
-- reg9_1x32
component reg9_1x32
    -- Port list
    port(
        -- Inputs
        CLK                       : in  std_logic;
        RST_N                     : in  std_logic;
        data_in_0                 : in  std_logic_vector(31 downto 0);
        data_in_1                 : in  std_logic_vector(31 downto 0);
        data_in_2                 : in  std_logic_vector(31 downto 0);
        data_in_3                 : in  std_logic_vector(31 downto 0);
        data_in_4                 : in  std_logic_vector(31 downto 0);
        data_in_5                 : in  std_logic_vector(31 downto 0);
        data_in_6                 : in  std_logic_vector(31 downto 0);
        data_in_7                 : in  std_logic_vector(31 downto 0);
        data_in_8                 : in  std_logic_vector(31 downto 0);
        ren                       : in  std_logic;
        sel                       : in  std_logic_vector(3 downto 0);
        wen                       : in  std_logic;
        -- Outputs
        data_available_lastbank_0 : out std_logic;
        data_available_lastbank_8 : out std_logic;
        data_out                  : out std_logic_vector(31 downto 0)
        );
end component;
-- SHA256_BLOCK
component SHA256_BLOCK
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        RST_N          : in  std_logic;
        data_in        : in  std_logic_vector(31 downto 0);
        ren            : in  std_logic;
        waddr_in       : in  std_logic_vector(4 downto 0);
        wen            : in  std_logic;
        -- Outputs
        H0_o           : out std_logic_vector(31 downto 0);
        H1_o           : out std_logic_vector(31 downto 0);
        H2_o           : out std_logic_vector(31 downto 0);
        H3_o           : out std_logic_vector(31 downto 0);
        H4_o           : out std_logic_vector(31 downto 0);
        H5_o           : out std_logic_vector(31 downto 0);
        H6_o           : out std_logic_vector(31 downto 0);
        H7_o           : out std_logic_vector(31 downto 0);
        data_available : out std_logic;
        data_out_ready : out std_logic;
        di_req_o       : out std_logic;
        do_valid_o     : out std_logic;
        error_o        : out std_logic;
        first_block    : out std_logic;
        last_block     : out std_logic;
        reg0_out       : out std_logic_vector(31 downto 0);
        reg10_out      : out std_logic_vector(31 downto 0);
        reg11_out      : out std_logic_vector(31 downto 0);
        reg12_out      : out std_logic_vector(31 downto 0);
        reg13_out      : out std_logic_vector(31 downto 0);
        reg14_out      : out std_logic_vector(31 downto 0);
        reg15_out      : out std_logic_vector(31 downto 0);
        reg16_out      : out std_logic_vector(31 downto 0);
        reg1_out       : out std_logic_vector(31 downto 0);
        reg2_out       : out std_logic_vector(31 downto 0);
        reg3_out       : out std_logic_vector(31 downto 0);
        reg4_out       : out std_logic_vector(31 downto 0);
        reg5_out       : out std_logic_vector(31 downto 0);
        reg6_out       : out std_logic_vector(31 downto 0);
        reg7_out       : out std_logic_vector(31 downto 0);
        reg8_out       : out std_logic_vector(31 downto 0);
        reg9_out       : out std_logic_vector(31 downto 0);
        start_o        : out std_logic;
        state_out      : out std_logic_vector(2 downto 0);
        waiting_data   : out std_logic
        );
end component;
-- zero_concat
component zero_concat
    -- Port list
    port(
        -- Inputs
        s1      : in  std_logic;
        s2      : in  std_logic;
        s3      : in  std_logic;
        -- Outputs
        s_32bit : out std_logic_vector(31 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal data_available_net_0            : std_logic;
signal data_available_lastbank_0_net_0 : std_logic;
signal data_available_lastbank_8_net_0 : std_logic;
signal data_available_lastbank_8_0     : std_logic;
signal data_out_net_0                  : std_logic_vector(31 downto 0);
signal data_out_ready_net_0            : std_logic;
signal di_req_o_net_0                  : std_logic;
signal do_valid_o_0                    : std_logic;
signal error_o_net_0                   : std_logic;
signal SHA256_BLOCK_0_do_valid_o       : std_logic;
signal SHA256_BLOCK_0_H0_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H1_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H2_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H3_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H4_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H5_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H6_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H7_o             : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_start_o          : std_logic;
signal start_wen                       : std_logic;
signal state_out_net_0                 : std_logic_vector(2 downto 0);
signal waiting_data_net_0              : std_logic;
signal zero_concat_0_s_32bit           : std_logic_vector(31 downto 0);
signal di_req_o_net_1                  : std_logic;
signal data_out_ready_net_1            : std_logic;
signal do_valid_o_0_net_0              : std_logic;
signal error_o_net_1                   : std_logic;
signal data_available_net_1            : std_logic;
signal data_out_net_1                  : std_logic_vector(31 downto 0);
signal data_available_lastbank_8_net_1 : std_logic;
signal data_available_lastbank_0_net_1 : std_logic;
signal state_out_net_1                 : std_logic_vector(2 downto 0);
signal waiting_data_net_1              : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                         : std_logic;

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 di_req_o_net_1                  <= di_req_o_net_0;
 di_req_o                        <= di_req_o_net_1;
 data_out_ready_net_1            <= data_out_ready_net_0;
 data_out_ready                  <= data_out_ready_net_1;
 do_valid_o_0_net_0              <= do_valid_o_0;
 do_valid_o                      <= do_valid_o_0_net_0;
 error_o_net_1                   <= error_o_net_0;
 error_o                         <= error_o_net_1;
 data_available_net_1            <= data_available_net_0;
 data_available                  <= data_available_net_1;
 data_out_net_1                  <= data_out_net_0;
 data_out(31 downto 0)           <= data_out_net_1;
 data_available_lastbank_8_net_1 <= data_available_lastbank_8_net_0;
 data_available_lastbank_8       <= data_available_lastbank_8_net_1;
 data_available_lastbank_0_net_1 <= data_available_lastbank_0_net_0;
 data_available_lastbank_0       <= data_available_lastbank_0_net_1;
 state_out_net_1                 <= state_out_net_0;
 state_out(2 downto 0)           <= state_out_net_1;
 waiting_data_net_1              <= waiting_data_net_0;
 waiting_data                    <= waiting_data_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- AND2_0
AND2_0 : AND2
    port map( 
        -- Inputs
        A => start_wen,
        B => SHA256_BLOCK_0_do_valid_o,
        -- Outputs
        Y => do_valid_o_0 
        );
-- reg1_highonly_0
reg1_highonly_0 : reg1_highonly
    port map( 
        -- Inputs
        CLK      => CLK,
        RST_N    => RST_N,
        data_in  => SHA256_BLOCK_0_start_o,
        wen      => VCC_net,
        -- Outputs
        data_out => start_wen 
        );
-- reg9_1x32_0
reg9_1x32_0 : reg9_1x32
    port map( 
        -- Inputs
        CLK                       => CLK,
        RST_N                     => data_out_ready_net_0,
        wen                       => start_wen,
        ren                       => result_ren,
        data_in_2                 => SHA256_BLOCK_0_H2_o,
        data_in_8                 => zero_concat_0_s_32bit,
        data_in_1                 => SHA256_BLOCK_0_H1_o,
        data_in_5                 => SHA256_BLOCK_0_H5_o,
        data_in_0                 => SHA256_BLOCK_0_H0_o,
        data_in_3                 => SHA256_BLOCK_0_H3_o,
        data_in_4                 => SHA256_BLOCK_0_H4_o,
        data_in_6                 => SHA256_BLOCK_0_H6_o,
        data_in_7                 => SHA256_BLOCK_0_H7_o,
        sel                       => result_addr,
        -- Outputs
        data_out                  => data_out_net_0,
        data_available_lastbank_8 => data_available_lastbank_8_0,
        data_available_lastbank_0 => OPEN 
        );
-- SHA256_BLOCK_0
SHA256_BLOCK_0 : SHA256_BLOCK
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        wen            => data_wen,
        ren            => data_ready,
        data_in        => data_in,
        waddr_in       => waddr_in,
        -- Outputs
        do_valid_o     => SHA256_BLOCK_0_do_valid_o,
        error_o        => error_o_net_0,
        di_req_o       => di_req_o_net_0,
        data_out_ready => data_out_ready_net_0,
        data_available => data_available_net_0,
        H0_o           => SHA256_BLOCK_0_H0_o,
        H1_o           => SHA256_BLOCK_0_H1_o,
        H2_o           => SHA256_BLOCK_0_H2_o,
        H3_o           => SHA256_BLOCK_0_H3_o,
        H4_o           => SHA256_BLOCK_0_H4_o,
        H5_o           => SHA256_BLOCK_0_H5_o,
        H6_o           => SHA256_BLOCK_0_H6_o,
        H7_o           => SHA256_BLOCK_0_H7_o,
        state_out      => state_out_net_0,
        reg10_out      => OPEN,
        reg9_out       => OPEN,
        reg15_out      => OPEN,
        reg7_out       => OPEN,
        reg2_out       => OPEN,
        reg12_out      => OPEN,
        reg16_out      => OPEN,
        reg4_out       => OPEN,
        reg11_out      => OPEN,
        reg8_out       => OPEN,
        reg1_out       => OPEN,
        reg3_out       => OPEN,
        reg6_out       => OPEN,
        reg14_out      => OPEN,
        reg0_out       => OPEN,
        reg5_out       => OPEN,
        reg13_out      => OPEN,
        first_block    => data_available_lastbank_0_net_0,
        last_block     => data_available_lastbank_8_net_0,
        start_o        => SHA256_BLOCK_0_start_o,
        waiting_data   => waiting_data_net_0 
        );
-- zero_concat_0
zero_concat_0 : zero_concat
    port map( 
        -- Inputs
        s1      => do_valid_o_0,
        s2      => di_req_o_net_0,
        s3      => error_o_net_0,
        -- Outputs
        s_32bit => zero_concat_0_s_32bit 
        );

end RTL;
