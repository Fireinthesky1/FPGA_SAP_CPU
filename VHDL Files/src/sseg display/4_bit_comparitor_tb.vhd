-- VHDL 8 bit processpr project
-- 4 bit comparitor test bench
-- James Hicks Oct 18 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_comparitor_tb is
end four_bit_comparitor_tb;

architecture tb of four_bit_comparitor_tb is

  signal num1, num2, small, large : std_logic_vector(3 downto 0);

begin

  DUT : entity work.four_bit_comparitor(my_arch)
    port map (num1 => num1,
              num2 => num2,
              small => small,
              large => large);
  process
  begin

    for I in 0 to 15 loop
      num1 <= std_logic_vector(to_unsigned(I, 4));
      num2 <= std_logic_vector(to_unsigned(15-I, 4));
      wait for 1 ns;
    end loop;

  assert false report "end of simulation";
  wait;

  end process;

end tb;
