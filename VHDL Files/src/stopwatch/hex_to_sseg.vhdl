-- VHDL 8 bit processor project
-- hex to sseg
-- James Hicks Oct 18 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex_to_sseg is
    Port ( hex  :  in STD_LOGIC_VECTOR (3 downto 0);
           dp   :  in STD_LOGIC;
           sseg : out STD_LOGIC_VECTOR (7 downto 0));
end hex_to_sseg;

architecture Behavioral of hex_to_sseg is

begin
    
    sseg(7) <= dp;  -- decimal point is in MSB of sseg
    with hex select -- a in sseg(6), b in sseg(5), ..., g in sseg(0)
        sseg(6 downto 0) <= 
            "0000001" when x"0",
            "1001111" when x"1",
            "0010010" when x"2",
            "0000110" when x"3",
            "1001100" when x"4",
            "0100100" when x"5",
            "0100000" when x"6",
            "0001111" when x"7",
            "0000000" when x"8",
            "0000100" when x"9",
            "0001000" when x"A",
            "1100000" when x"B",
            "0110001" when x"C",
            "1000010" when x"D",
            "0110000" when x"E",
            "0111000" when others; -- x"F"
    
end Behavioral;
