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
-- SHA256_BLOCK entity declaration
----------------------------------------------------------------------
entity SHA256_BLOCK is
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
-- limiter_1cycle
component limiter_1cycle
    -- Port list
    port(
        -- Inputs
        CLK         : in  std_logic;
        sig_xcycles : in  std_logic;
        -- Outputs
        sig_1cycle  : out std_logic
        );
end component;
-- reg_17x32
component reg_17x32
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        RST_N          : in  std_logic;
        data_in        : in  std_logic_vector(31 downto 0);
        raddr_in       : in  std_logic_vector(4 downto 0);
        ren            : in  std_logic;
        waddr_in       : in  std_logic_vector(4 downto 0);
        wen            : in  std_logic;
        -- Outputs
        data_available : out std_logic;
        data_out       : out std_logic_vector(31 downto 0);
        data_out_ready : out std_logic;
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
        reg9_out       : out std_logic_vector(31 downto 0)
        );
end component;
-- sha256_controller
component sha256_controller
    -- Port list
    port(
        -- Inputs
        RST_N        : in  std_logic;
        clk          : in  std_logic;
        data_ready   : in  std_logic;
        di_req_i     : in  std_logic;
        di_valid_i   : in  std_logic;
        first_block  : in  std_logic;
        last_block   : in  std_logic;
        read_data    : in  std_logic_vector(31 downto 0);
        -- Outputs
        bytes_o      : out std_logic_vector(1 downto 0);
        ce_o         : out std_logic;
        di_o         : out std_logic_vector(31 downto 0);
        di_wr_o      : out std_logic;
        end_o        : out std_logic;
        read_addr    : out std_logic_vector(4 downto 0);
        start_o      : out std_logic;
        state_out    : out std_logic_vector(2 downto 0);
        waiting_data : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal ce_o                            : std_logic;
signal data_available_net_0            : std_logic;
signal data_out                        : std_logic_vector(31 downto 0);
signal data_out_ready_net_0            : std_logic;
signal di_req_o_net_0                  : std_logic;
signal do_valid_o_net_0                : std_logic;
signal error_o_net_0                   : std_logic;
signal first_block_net_0               : std_logic;
signal H0_o_net_0                      : std_logic_vector(31 downto 0);
signal H1_o_net_0                      : std_logic_vector(31 downto 0);
signal H2_o_net_0                      : std_logic_vector(31 downto 0);
signal H3_o_net_0                      : std_logic_vector(31 downto 0);
signal H4_o_net_0                      : std_logic_vector(31 downto 0);
signal H5_o_net_0                      : std_logic_vector(31 downto 0);
signal H6_o_net_0                      : std_logic_vector(31 downto 0);
signal H7_o_net_0                      : std_logic_vector(31 downto 0);
signal last_block_net_0                : std_logic;
signal limiter_1cycle_1_sig_1cycle     : std_logic;
signal reg0_out_net_0                  : std_logic_vector(31 downto 0);
signal reg1_out_net_0                  : std_logic_vector(31 downto 0);
signal reg2_out_net_0                  : std_logic_vector(31 downto 0);
signal reg3_out_net_0                  : std_logic_vector(31 downto 0);
signal reg4_out_net_0                  : std_logic_vector(31 downto 0);
signal reg5_out_net_0                  : std_logic_vector(31 downto 0);
signal reg6_out_net_0                  : std_logic_vector(31 downto 0);
signal reg7_out_net_0                  : std_logic_vector(31 downto 0);
signal reg8_out_net_0                  : std_logic_vector(31 downto 0);
signal reg9_out_net_0                  : std_logic_vector(31 downto 0);
signal reg10_out_net_0                 : std_logic_vector(31 downto 0);
signal reg11_out_net_0                 : std_logic_vector(31 downto 0);
signal reg12_out_net_0                 : std_logic_vector(31 downto 0);
signal reg13_out_net_0                 : std_logic_vector(31 downto 0);
signal reg14_out_net_0                 : std_logic_vector(31 downto 0);
signal reg15_out_net_0                 : std_logic_vector(31 downto 0);
signal reg16_out_net_0                 : std_logic_vector(31 downto 0);
signal sha256_controller_0_bytes_o     : std_logic_vector(1 downto 0);
signal sha256_controller_0_di_o        : std_logic_vector(31 downto 0);
signal sha256_controller_0_di_wr_o     : std_logic;
signal sha256_controller_0_end_o       : std_logic;
signal sha256_controller_0_read_addr_0 : std_logic_vector(4 downto 0);
signal sig_1cycle                      : std_logic;
signal start_o_net_0                   : std_logic;
signal state_out_net_0                 : std_logic_vector(2 downto 0);
signal waiting_data_net_0              : std_logic;
signal do_valid_o_net_1                : std_logic;
signal error_o_net_1                   : std_logic;
signal di_req_o_net_1                  : std_logic;
signal data_out_ready_net_1            : std_logic;
signal data_available_net_1            : std_logic;
signal H0_o_net_1                      : std_logic_vector(31 downto 0);
signal H1_o_net_1                      : std_logic_vector(31 downto 0);
signal H2_o_net_1                      : std_logic_vector(31 downto 0);
signal H3_o_net_1                      : std_logic_vector(31 downto 0);
signal H4_o_net_1                      : std_logic_vector(31 downto 0);
signal H5_o_net_1                      : std_logic_vector(31 downto 0);
signal H6_o_net_1                      : std_logic_vector(31 downto 0);
signal H7_o_net_1                      : std_logic_vector(31 downto 0);
signal state_out_net_1                 : std_logic_vector(2 downto 0);
signal reg10_out_net_1                 : std_logic_vector(31 downto 0);
signal reg9_out_net_1                  : std_logic_vector(31 downto 0);
signal reg15_out_net_1                 : std_logic_vector(31 downto 0);
signal reg7_out_net_1                  : std_logic_vector(31 downto 0);
signal reg2_out_net_1                  : std_logic_vector(31 downto 0);
signal reg12_out_net_1                 : std_logic_vector(31 downto 0);
signal reg16_out_net_1                 : std_logic_vector(31 downto 0);
signal reg4_out_net_1                  : std_logic_vector(31 downto 0);
signal reg11_out_net_1                 : std_logic_vector(31 downto 0);
signal reg8_out_net_1                  : std_logic_vector(31 downto 0);
signal reg1_out_net_1                  : std_logic_vector(31 downto 0);
signal reg3_out_net_1                  : std_logic_vector(31 downto 0);
signal reg6_out_net_1                  : std_logic_vector(31 downto 0);
signal reg14_out_net_1                 : std_logic_vector(31 downto 0);
signal reg0_out_net_1                  : std_logic_vector(31 downto 0);
signal reg5_out_net_1                  : std_logic_vector(31 downto 0);
signal reg13_out_net_1                 : std_logic_vector(31 downto 0);
signal first_block_net_1               : std_logic;
signal last_block_net_1                : std_logic;
signal start_o_net_1                   : std_logic;
signal waiting_data_net_1              : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 do_valid_o_net_1       <= do_valid_o_net_0;
 do_valid_o             <= do_valid_o_net_1;
 error_o_net_1          <= error_o_net_0;
 error_o                <= error_o_net_1;
 di_req_o_net_1         <= di_req_o_net_0;
 di_req_o               <= di_req_o_net_1;
 data_out_ready_net_1   <= data_out_ready_net_0;
 data_out_ready         <= data_out_ready_net_1;
 data_available_net_1   <= data_available_net_0;
 data_available         <= data_available_net_1;
 H0_o_net_1             <= H0_o_net_0;
 H0_o(31 downto 0)      <= H0_o_net_1;
 H1_o_net_1             <= H1_o_net_0;
 H1_o(31 downto 0)      <= H1_o_net_1;
 H2_o_net_1             <= H2_o_net_0;
 H2_o(31 downto 0)      <= H2_o_net_1;
 H3_o_net_1             <= H3_o_net_0;
 H3_o(31 downto 0)      <= H3_o_net_1;
 H4_o_net_1             <= H4_o_net_0;
 H4_o(31 downto 0)      <= H4_o_net_1;
 H5_o_net_1             <= H5_o_net_0;
 H5_o(31 downto 0)      <= H5_o_net_1;
 H6_o_net_1             <= H6_o_net_0;
 H6_o(31 downto 0)      <= H6_o_net_1;
 H7_o_net_1             <= H7_o_net_0;
 H7_o(31 downto 0)      <= H7_o_net_1;
 state_out_net_1        <= state_out_net_0;
 state_out(2 downto 0)  <= state_out_net_1;
 reg10_out_net_1        <= reg10_out_net_0;
 reg10_out(31 downto 0) <= reg10_out_net_1;
 reg9_out_net_1         <= reg9_out_net_0;
 reg9_out(31 downto 0)  <= reg9_out_net_1;
 reg15_out_net_1        <= reg15_out_net_0;
 reg15_out(31 downto 0) <= reg15_out_net_1;
 reg7_out_net_1         <= reg7_out_net_0;
 reg7_out(31 downto 0)  <= reg7_out_net_1;
 reg2_out_net_1         <= reg2_out_net_0;
 reg2_out(31 downto 0)  <= reg2_out_net_1;
 reg12_out_net_1        <= reg12_out_net_0;
 reg12_out(31 downto 0) <= reg12_out_net_1;
 reg16_out_net_1        <= reg16_out_net_0;
 reg16_out(31 downto 0) <= reg16_out_net_1;
 reg4_out_net_1         <= reg4_out_net_0;
 reg4_out(31 downto 0)  <= reg4_out_net_1;
 reg11_out_net_1        <= reg11_out_net_0;
 reg11_out(31 downto 0) <= reg11_out_net_1;
 reg8_out_net_1         <= reg8_out_net_0;
 reg8_out(31 downto 0)  <= reg8_out_net_1;
 reg1_out_net_1         <= reg1_out_net_0;
 reg1_out(31 downto 0)  <= reg1_out_net_1;
 reg3_out_net_1         <= reg3_out_net_0;
 reg3_out(31 downto 0)  <= reg3_out_net_1;
 reg6_out_net_1         <= reg6_out_net_0;
 reg6_out(31 downto 0)  <= reg6_out_net_1;
 reg14_out_net_1        <= reg14_out_net_0;
 reg14_out(31 downto 0) <= reg14_out_net_1;
 reg0_out_net_1         <= reg0_out_net_0;
 reg0_out(31 downto 0)  <= reg0_out_net_1;
 reg5_out_net_1         <= reg5_out_net_0;
 reg5_out(31 downto 0)  <= reg5_out_net_1;
 reg13_out_net_1        <= reg13_out_net_0;
 reg13_out(31 downto 0) <= reg13_out_net_1;
 first_block_net_1      <= first_block_net_0;
 first_block            <= first_block_net_1;
 last_block_net_1       <= last_block_net_0;
 last_block             <= last_block_net_1;
 start_o_net_1          <= start_o_net_0;
 start_o                <= start_o_net_1;
 waiting_data_net_1     <= waiting_data_net_0;
 waiting_data           <= waiting_data_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- gv_sha256_0
gv_sha256_0 : gv_sha256
    port map( 
        -- Inputs
        clk_i      => CLK,
        ce_i       => ce_o,
        start_i    => start_o_net_0,
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
-- limiter_1cycle_first
limiter_1cycle_first : limiter_1cycle
    port map( 
        -- Inputs
        CLK         => CLK,
        sig_xcycles => first_block_net_0,
        -- Outputs
        sig_1cycle  => limiter_1cycle_1_sig_1cycle 
        );
-- limiter_1cycle_ready
limiter_1cycle_ready : limiter_1cycle
    port map( 
        -- Inputs
        CLK         => CLK,
        sig_xcycles => data_out_ready_net_0,
        -- Outputs
        sig_1cycle  => sig_1cycle 
        );
-- reg_17x32_0
reg_17x32_0 : reg_17x32
    port map( 
        -- Inputs
        CLK            => CLK,
        RST_N          => RST_N,
        data_in        => data_in,
        waddr_in       => waddr_in,
        raddr_in       => sha256_controller_0_read_addr_0,
        wen            => wen,
        ren            => ren,
        -- Outputs
        data_out       => data_out,
        data_out_ready => data_out_ready_net_0,
        reg0_out       => reg0_out_net_0,
        reg1_out       => reg1_out_net_0,
        reg2_out       => reg2_out_net_0,
        reg3_out       => reg3_out_net_0,
        reg4_out       => reg4_out_net_0,
        reg5_out       => reg5_out_net_0,
        reg6_out       => reg6_out_net_0,
        reg7_out       => reg7_out_net_0,
        reg8_out       => reg8_out_net_0,
        reg9_out       => reg9_out_net_0,
        reg10_out      => reg10_out_net_0,
        reg11_out      => reg11_out_net_0,
        reg12_out      => reg12_out_net_0,
        reg13_out      => reg13_out_net_0,
        reg14_out      => reg14_out_net_0,
        reg15_out      => reg15_out_net_0,
        reg16_out      => reg16_out_net_0,
        data_available => data_available_net_0,
        first_block    => first_block_net_0,
        last_block     => last_block_net_0 
        );
-- sha256_controller_0
sha256_controller_0 : sha256_controller
    port map( 
        -- Inputs
        read_data    => data_out,
        data_ready   => sig_1cycle,
        last_block   => last_block_net_0,
        first_block  => limiter_1cycle_1_sig_1cycle,
        clk          => CLK,
        RST_N        => RST_N,
        di_req_i     => di_req_o_net_0,
        di_valid_i   => do_valid_o_net_0,
        -- Outputs
        read_addr    => sha256_controller_0_read_addr_0,
        state_out    => state_out_net_0,
        waiting_data => waiting_data_net_0,
        ce_o         => ce_o,
        di_o         => sha256_controller_0_di_o,
        bytes_o      => sha256_controller_0_bytes_o,
        start_o      => start_o_net_0,
        end_o        => sha256_controller_0_end_o,
        di_wr_o      => sha256_controller_0_di_wr_o 
        );

end RTL;
