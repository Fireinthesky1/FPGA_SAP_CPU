-- VHDL 8 bit processor project
-- digit separator
-- James Hicks Oct 18 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digit_separator is
  port (input : in std_logic_vector(4 downto 0);
        msb, lsb : out std_logic_vector(3 downto 0));
end digit_separator;

architecture my_arch of digit_separator is

begin

with input select msb <=
  x"1" when "01010", -- 10
  x"1" when "01011", -- 11
  x"1" when "01100", -- 12
  x"1" when "01101", -- 13
  x"1" when "01110", -- 14
  x"1" when "01111", -- 15
  x"1" when "10000", -- 16
  x"1" when "10001", -- 17
  x"1" when "10010", -- 18
  x"1" when "10011", -- 19
  x"2" when "10100", -- 20
  x"2" when "10101", -- 21
  x"2" when "10110", -- 22
  x"2" when "10111", -- 23
  x"2" when "11000", -- 24
  x"2" when "11001", -- 25
  x"2" when "11010", -- 26
  x"2" when "11011", -- 27
  x"2" when "11100", -- 28
  x"2" when "11101", -- 29
  x"3" when "11110", -- 30
  x"0" when others;


with input select lsb <=
  x"0" when "00000", -- 0
  x"1" when "00001", -- 1
  x"2" when "00010", -- 2
  x"3" when "00011", -- 3
  x"4" when "00100", -- 4
  x"5" when "00101", -- 5
  x"6" when "00110", -- 6
  x"7" when "00111", -- 7
  x"8" when "01000", -- 8
  x"9" when "01001", -- 9
  x"0" when "01010", -- 10
  x"1" when "01011", -- 11
  x"2" when "01100", -- 12
  x"3" when "01101", -- 13
  x"4" when "01110", -- 14
  x"5" when "01111", -- 15
  x"6" when "10000", -- 16
  x"7" when "10001", -- 17
  x"8" when "10010", -- 18
  x"9" when "10011", -- 19
  x"0" when "10100", -- 20
  x"1" when "10101", -- 21
  x"2" when "10110", -- 22
  x"3" when "10111", -- 23
  x"4" when "11000", -- 24
  x"5" when "11001", -- 25
  x"6" when "11010", -- 26
  x"7" when "11011", -- 27
  x"8" when "11100", -- 28
  x"9" when "11101", -- 29
  x"0" when "11110", -- 30
  x"0" when others;  -- very bad if we end up here

end my_arch;
