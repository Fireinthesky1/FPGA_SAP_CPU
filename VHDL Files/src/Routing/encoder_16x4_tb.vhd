-- VHDL 8 bit processor project
--16 x 4 encoder test bench
-- James Hicks Oct 15 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder_16x4_tb is
end encoder_16x4_tb;

architecture tb of encoder_16x4_tb is

  signal r : std_logic_vector(15 downto 0);
  signal e : std_logic_vector(3 downto 0);
  signal v : std_logic;

begin

  DUT : entity work.encoder_16x4(my_arch)
    port map (
      r => r,
      e => e,
      v => v
      );

  process begin
    for I in 0 to 65535 loop
      r <= std_logic_vector(to_unsigned(I,16));
      wait for 1 ns;
    end loop;

    assert false report "end of test";
    wait;

  end process;
end tb;

