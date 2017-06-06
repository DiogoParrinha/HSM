----------------------------------------------------------------------
-- Created by SmartDesign Mon Jun 05 23:09:01 2017
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
        CLK         : in  std_logic;
        RST_N       : in  std_logic;
        data_in     : in  std_logic_vector(31 downto 0);
        data_ready  : in  std_logic;
        data_wen    : in  std_logic;
        first_block : in  std_logic;
        last_block  : in  std_logic;
        result_addr : in  std_logic_vector(3 downto 0);
        result_ren  : in  std_logic;
        waddr_in    : in  std_logic_vector(3 downto 0);
        -- Outputs
        data_out    : out std_logic_vector(31 downto 0);
        di_req_o    : out std_logic
        );
end SHA256_Module;
----------------------------------------------------------------------
-- SHA256_Module architecture body
----------------------------------------------------------------------
architecture RTL of SHA256_Module is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- reg9_1x32
component reg9_1x32
    -- Port list
    port(
        -- Inputs
        CLK       : in  std_logic;
        RST_N     : in  std_logic;
        data_in_0 : in  std_logic_vector(31 downto 0);
        data_in_1 : in  std_logic_vector(31 downto 0);
        data_in_2 : in  std_logic_vector(31 downto 0);
        data_in_3 : in  std_logic_vector(31 downto 0);
        data_in_4 : in  std_logic_vector(31 downto 0);
        data_in_5 : in  std_logic_vector(31 downto 0);
        data_in_6 : in  std_logic_vector(31 downto 0);
        data_in_7 : in  std_logic_vector(31 downto 0);
        data_in_8 : in  std_logic_vector(31 downto 0);
        ren       : in  std_logic;
        sel       : in  std_logic_vector(3 downto 0);
        wen       : in  std_logic;
        -- Outputs
        data_out  : out std_logic_vector(31 downto 0)
        );
end component;
-- SHA256_BLOCK
component SHA256_BLOCK
    -- Port list
    port(
        -- Inputs
        CLK         : in  std_logic;
        RST_N       : in  std_logic;
        data_in     : in  std_logic_vector(31 downto 0);
        first_block : in  std_logic;
        last_block  : in  std_logic;
        ren         : in  std_logic;
        waddr_in    : in  std_logic_vector(3 downto 0);
        wen         : in  std_logic;
        -- Outputs
        H0_o        : out std_logic_vector(31 downto 0);
        H1_o        : out std_logic_vector(31 downto 0);
        H2_o        : out std_logic_vector(31 downto 0);
        H3_o        : out std_logic_vector(31 downto 0);
        H4_o        : out std_logic_vector(31 downto 0);
        H5_o        : out std_logic_vector(31 downto 0);
        H6_o        : out std_logic_vector(31 downto 0);
        H7_o        : out std_logic_vector(31 downto 0);
        di_req_o    : out std_logic;
        do_valid_o  : out std_logic;
        error_o     : out std_logic
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
signal data_out_net_0            : std_logic_vector(31 downto 0);
signal di_req_o_net_0            : std_logic;
signal SHA256_BLOCK_0_do_valid_o : std_logic;
signal SHA256_BLOCK_0_error_o    : std_logic;
signal SHA256_BLOCK_0_H0_o       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H1_o       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H2_o       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H3_o       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H4_o       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H5_o       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H6_o       : std_logic_vector(31 downto 0);
signal SHA256_BLOCK_0_H7_o       : std_logic_vector(31 downto 0);
signal zero_concat_0_s_32bit     : std_logic_vector(31 downto 0);
signal di_req_o_net_1            : std_logic;
signal data_out_net_1            : std_logic_vector(31 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 di_req_o_net_1        <= di_req_o_net_0;
 di_req_o              <= di_req_o_net_1;
 data_out_net_1        <= data_out_net_0;
 data_out(31 downto 0) <= data_out_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- reg9_1x32_0
reg9_1x32_0 : reg9_1x32
    port map( 
        -- Inputs
        CLK       => CLK,
        RST_N     => RST_N,
        wen       => SHA256_BLOCK_0_do_valid_o,
        ren       => result_ren,
        data_in_2 => SHA256_BLOCK_0_H2_o,
        data_in_8 => zero_concat_0_s_32bit,
        data_in_1 => SHA256_BLOCK_0_H1_o,
        data_in_5 => SHA256_BLOCK_0_H5_o,
        data_in_0 => SHA256_BLOCK_0_H0_o,
        data_in_3 => SHA256_BLOCK_0_H3_o,
        data_in_4 => SHA256_BLOCK_0_H4_o,
        data_in_6 => SHA256_BLOCK_0_H6_o,
        data_in_7 => SHA256_BLOCK_0_H7_o,
        sel       => result_addr,
        -- Outputs
        data_out  => data_out_net_0 
        );
-- SHA256_BLOCK_0
SHA256_BLOCK_0 : SHA256_BLOCK
    port map( 
        -- Inputs
        CLK         => CLK,
        RST_N       => RST_N,
        wen         => data_wen,
        ren         => data_ready,
        last_block  => last_block,
        first_block => first_block,
        data_in     => data_in,
        waddr_in    => waddr_in,
        -- Outputs
        do_valid_o  => SHA256_BLOCK_0_do_valid_o,
        error_o     => SHA256_BLOCK_0_error_o,
        di_req_o    => di_req_o_net_0,
        H0_o        => SHA256_BLOCK_0_H0_o,
        H1_o        => SHA256_BLOCK_0_H1_o,
        H2_o        => SHA256_BLOCK_0_H2_o,
        H3_o        => SHA256_BLOCK_0_H3_o,
        H4_o        => SHA256_BLOCK_0_H4_o,
        H5_o        => SHA256_BLOCK_0_H5_o,
        H6_o        => SHA256_BLOCK_0_H6_o,
        H7_o        => SHA256_BLOCK_0_H7_o 
        );
-- zero_concat_0
zero_concat_0 : zero_concat
    port map( 
        -- Inputs
        s1      => SHA256_BLOCK_0_do_valid_o,
        s2      => di_req_o_net_0,
        s3      => SHA256_BLOCK_0_error_o,
        -- Outputs
        s_32bit => zero_concat_0_s_32bit 
        );

end RTL;
