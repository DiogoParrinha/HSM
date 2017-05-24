--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: romkt2.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::SmartFusion2> <Die::M2S090TS> <Package::484 FBGA>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity romkt2 is
port (
    addra   : IN    std_logic_vector(5 downto 0);
    clka    : IN    std_logic;
    douta   : OUT   std_logic_vector(31 downto 0)
);
end romkt2;

architecture architecture_romkt2 of romkt2 is

    type mem is array (2**6-1 downto 0) of std_logic_vector(31 downto 0);
    constant sha_kt_rom : mem := (
        0 => X"b5c0fbcf",
        1 => X"e9b5dba5",
        2 => X"3956c25b",
        3 => X"59f111f1",
        4 => X"923f82a4",
        5 => X"ab1c5ed5",
        6 => X"d807aa98",
        7 => X"12835b01",
        8 => X"243185be",
        9 => X"550c7dc3",
        10 => X"72be5d74",
        11 => X"80deb1fe",
        12 => X"9bdc06a7",
        13 => X"c19bf174",
        14 => X"e49b69c1",
        15 => X"efbe4786",
        16 => X"0fc19dc6",
        17 => X"240ca1cc",
        18 => X"2de92c6f",
        19 => X"4a7484aa",
        20 => X"5cb0a9dc",
        21 => X"76f988da",
        22 => X"983e5152",
        23 => X"a831c66d",
        24 => X"b00327c8",
        25 => X"bf597fc7",
        26 => X"c6e00bf3",
        27 => X"d5a79147",
        28 => X"06ca6351",
        29 => X"14292967",
        30 => X"27b70a85",
        31 => X"2e1b2138",
        32 => X"4d2c6dfc",
        33 => X"53380d13",
        34 => X"650a7354",
        35 => X"766a0abb",
        36 => X"81c2c92e",
        37 => X"92722c85",
        38 => X"a2bfe8a1",
        39 => X"a81a664b",
        40 => X"c24b8b70",
        41 => X"c76c51a3",
        42 => X"d192e819",
        43 => X"d6990624",
        44 => X"f40e3585",
        45 => X"106aa070",
        46 => X"19a4c116",
        47 => X"1e376c08",
        48 => X"2748774c",
        49 => X"34b0bcb5",
        50 => X"391c0cb3",
        51 => X"4ed8aa4a",
        52 => X"5b9cca4f",
        53 => X"682e6ff3",
        54 => X"748f82ee",
        55 => X"78a5636f",
        56 => X"84c87814",
        57 => X"8cc70208",
        58 => X"90befffa",
        59 => X"a4506ceb",
        60 => X"bef9a3f7",
        61 => X"c67178f2",
        62 => X"428a2f98",
        63 => X"71374491");

begin

    process(clka)
    begin
        douta <= sha_kt_rom(to_integer(unsigned(addra)));
    end process;

end architecture_romkt2;
