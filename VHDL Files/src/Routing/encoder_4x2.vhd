-- VHDL 8 bit processor project
-- 4 x 2 encoder test bench
-- James Hicks Oct 15 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder_4x2_tb is
end encoder_4x2_tb;

architecture tb of encoder_4x2_tb is

  signal r : std_logic_vector(3 downto 0);
  signal e : std_logic_vector(1 downto 0);
  signal v : std_logic;

begin

--  DUT_COND : entity work.encoder_4x2(cond_arch)
--    port map (
--      r => r,
--      e => e,
--      v => v
--      );

 -- DUT_SEL : entity work.encoder_4x2(sel_arch)
 --   port map (
 --     r => r,
 --     e => e,
 --     v => v
 --     );

  -- DUT_IF : entity work.encoder_4x2(if_arch)
  --   port map (
  --     r => r,
  --     e => e,
  --     v => v
  --     );

 DUT_CASE : entity work.encoder_4x2(case_arch)
   port map (
     r => r,
     e => e,
     v => v
     );

  process begin
    for I in 0 to 15 loop
      r <= std_logic_vector(to_unsigned(I,4));
      wait for 1 ns;
    end loop;

    assert false report "end of test";
    wait;

  end process;
end tb;