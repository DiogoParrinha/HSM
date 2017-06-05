----------------------------------------------------------------------
-- Created by SmartDesign Mon Jun 05 17:48:20 2017
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
-- SHA256_BLOCK entity declaration
----------------------------------------------------------------------
entity SHA256_BLOCK is
    -- Port list
    port(
        -- Inputs
        CLK        : in  std_logic;
        RST_N      : in  std_logic;
        data_in    : in  std_logic_vector(31 downto 0);
        last_block : in  std_logic;
        ren        : in  std_logic;
        waddr_in   : in  std_logic_vector(3 downto 0);
        wen        : in  std_logic;
        -- Outputs
        H0_o       : out std_logic_vector(31 downto 0);
        H1_o       : out std_logic_vector(31 downto 0);
        H2_o       : out std_logic_vector(31 downto 0);
        H3_o       : out std_logic_vector(31 downto 0);
        H4_o       : out std_logic_vector(31 downto 0);
        H5_o       : out std_logic_vector(31 downto 0);
        H6_o       : out std_logic_vector(31 downto 0);
        H7_o       : out std_logic_vector(31 downto 0);
        di_req_o   : out std_logic;
        do_valid_o : out std_logic;
        error_o    : out std_logic
        );
end SHA256_BLOCK;
----------------------------------------------------------------------
-- SHA256_BLOCK architecture body
----------------------------------------------------------------------
architecture RTL of SHA256_BLOCK is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- gv_sha256
component gv_sha256
    -- Port list
    port(
        -- Inputs
        bytes_i    : in  std_logic_vector(1 downto 0);
        ce_i       : in  std_logic;
        clk_i      : in  std_logic;
        di_i       : in  std_logic_vector(31 downto 0);
        di_wr_i    : in  std_logic;
        end_i      : in  std_logic;
        start_i    : in  std_logic;
        -- Outputs
        H0_o       : out std_logic_vector(31 downto 0);
        H1_o       : out std_logic_vector(31 downto 0);
        H2_o       : out std_logic_vector(31 downto 0);
        H3_o       : out std_logic_vector(31 downto 0);
        H4_o       : out std_logic_vector(31 downto 0);
        H5_o       : out std_logic_vector(31 downto 0);
        H6_o       : out std_logic_vector(31 downto 0);
        H7_o       : out std_logic_vector(31 downto 0);
        di_req_o   : out std_logic;
        do_valid_o : out std_logic;
        error_o    : out std_logic
        );
end component;
-- reg_16x32
component reg_16x32
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        RST_N          : in  std_logic;
        data_in        : in  std_logic_vector(31 downto 0);
        raddr_in       : in  std_logic_vector(3 downto 0);
        ren            : in  std_logic;
        waddr_in       : in  std_logic_vector(3 downto 0);
        wen            : in  std_logic;
        -- Outputs
        data_out       : out std_logic_vector(31 downto 0);
        data_out_ready : out std_logic
        );
end component;
-- sha256_controller
component sha256_controller
    -- Port list
    port(
        -- Inputs
        RST_N      : in  std_logic;
        clk        : in  std_logic;
        data_ready : in  std_logic;
        di_req_i   : in  std_logic;
        di_valid_i : in  std_logic;
        last_block : in  std_logic;
        read_data  : in  std_logic_vector(31 downto 0);
        -- Outputs
        bytes_o    : out std_logic_vector(1 downto 0);
        ce_o       : out std_logic;
        di_o       : out std_logic_vector(31 downto 0);
        di_wr_o    : out std_logic;
        end_o      : out std_logic;
        read_addr  : out std_logic_vector(3 downto 0);
        start_o    : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal di_req_o_net_0                : std_logic;
signal do_valid_o_net_0              : std_logic;
signal error_o_net_0                 : std_logic;
signal H0_o_net_0                    : std_logic_vector(31 downto 0);
signal H1_o_net_0                    : std_logic_vector(31 downto 0);
signal H2_o_net_0                    : std_logic_vector(31 downto 0);
signal H3_o_net_0                    : std_logic_vector(31 downto 0);
signal H4_o_net_0                    : std_logic_vector(31 downto 0);
signal H5_o_net_0                    : std_logic_vector(31 downto 0);
signal H6_o_net_0                    : std_logic_vector(31 downto 0);
signal H7_o_net_0                    : std_logic_vector(31 downto 0);
signal reg_16x32_0_data_out          : std_logic_vector(31 downto 0);
signal reg_16x32_0_data_out_ready    : std_logic;
signal sha256_controller_0_bytes_o   : std_logic_vector(1 downto 0);
signal sha256_controller_0_ce_o      : std_logic;
signal sha256_controller_0_di_o      : std_logic_vector(31 downto 0);
signal sha256_controller_0_di_wr_o   : std_logic;
signal sha256_controller_0_end_o     : std_logic;
signal sha256_controller_0_read_addr : std_logic_vector(3 downto 0);
signal sha256_controller_0_start_o   : std_logic;
signal do_valid_o_net_1              : std_logic;
signal error_o_net_1                 : std_logic;
signal di_req_o_net_1                : std_logic;
signal H0_o_net_1                    : std_logic_vector(31 downto 0);
signal H1_o_net_1                    : std_logic_vector(31 downto 0);
signal H2_o_net_1                    : std_logic_vector(31 downto 0);
signal H3_o_net_1                    : std_logic_vector(31 downto 0);
signal H4_o_net_1                    : std_logic_vector(31 downto 0);
signal H5_o_net_1                    : std_logic_vector(31 downto 0);
signal H6_o_net_1                    : std_logic_vector(31 downto 0);
signal H7_o_net_1                    : std_logic_vector(31 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 do_valid_o_net_1  <= do_valid_o_net_0;
 do_valid_o        <= do_valid_o_net_1;
 error_o_net_1     <= error_o_net_0;
 error_o           <= error_o_net_1;
 di_req_o_net_1    <= di_req_o_net_0;
 di_req_o          <= di_req_o_net_1;
 H0_o_net_1        <= H0_o_net_0;
 H0_o(31 downto 0) <= H0_o_net_1;
 H1_o_net_1        <= H1_o_net_0;
 H1_o(31 downto 0) <= H1_o_net_1;
 H2_o_net_1        <= H2_o_net_0;
 H2_o(31 downto 0) <= H2_o_net_1;
 H3_o_net_1        <= H3_o_net_0;
 H3_o(31 downto 0) <= H3_o_net_1;
 H4_o_net_1        <= H4_o_net_0;
 H4_o(31 downto 0) <= H4_o_net_1;
 H5_o_net_1        <= H5_o_net_0;
 H5_o(31 downto 0) <= H5_o_net_1;
 H6_o_net_1        <= H6_o_net_0;
 H6_o(31 downto 0) <= H6_o_net_1;
 H7_o_net_1        <= H7_o_net_0;
 H7_o(31 downto 0) <= H7_o_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- gv_sha256_0
gv_sha256_0 : gv_sha256
    port map( 
        -- Inputs
        clk_i      => CLK,
        ce_i       => sha256_controller_0_ce_o,
        start_i    => sha256_controller_0_start_o,
        end_i      => sha256_controller_0_end_o,
        di_wr_i    => sha256_controller_0_di_wr_o,
        di_i       => sha256_controller_0_di_o,
        bytes_i    => sha256_controller_0_bytes_o,
        -- Outputs
        di_req_o   => di_req_o_net_0,
        error_o    => error_o_net_0,
        do_valid_o => do_valid_o_net_0,
        H0_o       => H0_o_net_0,
        H1_o       => H1_o_net_0,
        H2_o       => H2_o_net_0,
        H3_o       => H3_o_net_0,
        H4_o       => H4_o_net_0,
        H5_o       => H5_o_net_0,
        H6_o       => H6_o_net_0,
        H7_o       => H7_o_net_0 
        );
-- reg_16x32_0
reg_16x32_0 : reg_16x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        wen            => wen,
        ren            => ren,
        data_in        => data_in,
        waddr_in       => waddr_in,
        raddr_in       => sha256_controller_0_read_addr,
        -- Outputs
        data_out_ready => reg_16x32_0_data_out_ready,
        data_out       => reg_16x32_0_data_out 
        );
-- sha256_controller_0
sha256_controller_0 : sha256_controller
    port map( 
        -- Inputs
        read_data  => reg_16x32_0_data_out,
        data_ready => reg_16x32_0_data_out_ready,
        last_block => last_block,
        clk        => CLK,
        RST_N      => RST_N,
        di_req_i   => di_req_o_net_0,
        di_valid_i => do_valid_o_net_0,
        -- Outputs
        read_addr  => sha256_controller_0_read_addr,
        ce_o       => sha256_controller_0_ce_o,
        di_o       => sha256_controller_0_di_o,
        bytes_o    => sha256_controller_0_bytes_o,
        start_o    => sha256_controller_0_start_o,
        end_o      => sha256_controller_0_end_o,
        di_wr_o    => sha256_controller_0_di_wr_o 
        );

end RTL;
