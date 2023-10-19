-- VHDL 8 bit processor project
-- 4 bit comparitor
-- James Hicks Oct 18 2023

-- takes in two 4 bit numbers
-- outputs the larger as large
-- outputs the smaller as small

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_comparitor is
  port(num1, num2 : in std_logic_vector(3 downto 0);
       small, large : out std_logic_vector(3 downto 0));
end four_bit_comparitor;

architecture my_arch of four_bit_comparitor is
begin

process(num1, num2)
begin
  if num1 > num2 then
    large <= num1;
    small <= num2;
  else
    large <= num2;
    small <= num1;
  end if;
end process;

end my_arch;
