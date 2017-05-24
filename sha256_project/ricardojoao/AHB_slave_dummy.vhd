--------------------------------------------------------------------------------
-- This is AHB-Lite slave interface for a single pipelined 16b LSRAM input FIFO,
-- and a single pipelined 16b LSRAM output FIFO.
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity AHB_slave_dummy is
generic(pipeline: integer := 0);
port (
    HCLK : in std_logic;                            -- The system driving clock
    HRESETn : in std_logic;                         -- System reset. Active Low
    HADDR : in std_logic_vector(31 downto 0);       -- 32-bit memory address

    --HBURST : in std_logic_vector(2 downto 0);       -- Burst type. HBURST=000 for single burst -- Not used!
    --HMASTLOCK : in std_logic;                       -- Tranference lockage (optional) -- Not used!

    --HSIZE : in std_logic_vector(2 downto 0);        -- Trasfer size. 8bits=000 ; 16bits=001 ; 32bits=010
                                                        -- Not used! Always accepts 32 bits.

    HTRANS : in std_logic_vector(1 downto 0);       -- Transfer type of current transfer (IDLE=00 BUSY=01 NSEQ=10 SEQ=11)
                                                        -- Only NSEQ=10 is used.

    HWDATA : in std_logic_vector(31 downto 0);      -- 32-bit Writing data bus
    HWRITE : in std_logic;                          -- Transfer direction (High-write ; Low-read)
    HRDATA : out std_logic_vector(31 downto 0);     -- 32-bit Reading data bus
    HREADYOUT : out std_logic;                       -- when High, transfer has finished
    HRESP : out std_logic;                           -- Trasnfer status response: Low-OK ; High-ERROR
    HSEL : in std_logic;                            -- Selector of the data cell. Works as an enable.
    HREADY : in std_logic;

    -- Memory Interface
    lsram_waddr : out std_logic_vector(8 downto 0);
    lsram_raddr : out std_logic_vector(8 downto 0);
    mem_rdata : in std_logic_vector(31 downto 0);
    mem_wdata: out std_logic_vector(31 downto 0);
    write_en : out std_logic;
    read_en : out std_logic

    --fifo_full : in std_logic;
    --fifo_empty : in std_logic;
    --fifo_wack : in std_logic

);
end AHB_slave_dummy;

architecture BEHAVIOUR of AHB_slave_dummy is

signal FSM : std_logic_vector(1 downto 0);  -- State Machine
signal ready : std_logic;                   -- Internal register of Slave's HREADYOUT
--signal error_r : std_logic;               -- Internal register of Slave's HRESP
signal hwrite_r : std_logic;                -- Internal register for Slave's operation

begin

-- bypasses ---------------
HREADYOUT <= ready;
HRESP <= '0';--error_r;
HRDATA <= mem_rdata;
mem_wdata <= HWDATA;
---------------------------


process(HRESETn, HCLK)
begin
    ------------------------------------------
    if HRESETn='0' then     -- system restart
        FSM<="00";
        write_en<='0';
        read_en<='0';
        ready <='1';
        lsram_waddr <= (others => '0');
        lsram_raddr <= (others => '0');
        hwrite_r<='0';
        --error_r<='0';
    ------------------------------------------
    elsif rising_edge(HCLK) then
            case FSM is
                -----------------------------------------------------------------------------------------
                when "00" =>    -- New Transmission detected; Ready for transmission ; MEM Cell selected
                    if(HTRANS(1)='1' and HREADY='1' and HSEL='1') then
                        FSM <= "01";    -- state machine update
                        hwrite_r <= HWRITE;
                        --lsram_waddr <= HADDR(10 downto 2);
                        
                        if(HWRITE='1') then
                            write_en <= '1';
                            lsram_waddr <= HADDR(10 downto 2);
                            -- ready <= '1'; -- Implied
                        else
                            lsram_raddr <= HADDR(10 downto 2);
                            read_en <= '1';
                            ready <= '0';   -- Takes 1/2 cycles;
                        end if;
                    end if;

                when "01" =>
                    if(hwrite_r='1') then
                        FSM <= "00";
                        write_en <= '0';
                    else
                        FSM <= "10";
                        read_en <= '0';
                        -- For non-pipelined memory:
                        if (pipeline=0) then
                            ready<='1';
                        end if;
                        ----------------------------
                    end if;

                when "10" =>
                        -- For Non-pipelined memory:
                        if (pipeline=0) then
                            FSM <= "00";
                        ----------------------------
                        -- For Pipelined memory:
                        else
                            FSM <= "11";
                            ready <= '1';
                        end if;
                        ----------------------------
                
                when "11" =>
                        FSM <= "00";

                when others =>
                        FSM <= "00";
            end case;
    end if;
end process;

end BEHAVIOUR;
