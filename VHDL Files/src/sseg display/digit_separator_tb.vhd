-- VHDL 8 bit processor project
-- digit separator test bench
-- James Hicks Oct 18 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity digit_separator_tb is
end digit_separator_tb;

architecture tb of digit_separator_tb is

  signal input, msb, lsb : std_logic_vector(3 downto 0);

begin

  DUT : entity work.digit_separator(my_arch)
    port map (input => input,
              msb => msb,
              lsb => lsb);

  process
  begin

    for I in 0 to 15 loop
      input <= std_logic_vector(to_unsigned(I, 4));
      wait for 1 ns;
    end loop;

  assert false report "end of simulation";
  wait;

  end process;

end tb;
