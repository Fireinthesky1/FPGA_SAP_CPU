-- VHDL 8 bit processor project
-- digit separator
-- James Hicks Oct 18 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digit_separator is
  port (input : in std_logic_vector(3 downto 0);
        msb, lsb : out std_logic_vector(3 downto 0));
end digit_separator;

architecture my_arch of digit_separator is

begin

with input select msb <=
  x"1" when x"a",
  x"1" when x"b",
  x"1" when x"c",
  x"1" when x"d",
  x"1" when x"e",
  x"1" when x"f",
  x"0" when others;

with input select lsb <=
  x"0" when x"0",
  x"1" when x"1",
  x"2" when x"2",
  x"3" when x"3",
  x"4" when x"4",
  x"5" when x"5",
  x"6" when x"6",
  x"7" when x"7",
  x"8" when x"8",
  x"9" when x"9",
  x"0" when x"a",
  x"1" when x"b",
  x"2" when x"c",
  x"3" when x"d",
  x"4" when x"e",
  x"5" when x"f",
  x"0" when others; -- very bad if this happens

end my_arch;
