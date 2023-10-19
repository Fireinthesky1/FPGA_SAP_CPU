-- VHDL 8 bit processor project
-- zero blanker test bench
-- James Hicks Oct 18 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zero_blanker_tb is
end zero_blanker_tb;

architecture tb of zero_blanker_tb is

  signal input, output : std_logic_vector(7 downto 0);

begin

  DUT : entity work.zero_blanker(my_arch)
    port map(input => input,
             output => output);

process
begin
  for I in 0 to 255 loop
    input <= std_logic_vector(to_unsigned(I, 8));
    wait for 1 ns;
  end loop;
  assert false report "end of simulation";
  wait;
end process;

end tb;
