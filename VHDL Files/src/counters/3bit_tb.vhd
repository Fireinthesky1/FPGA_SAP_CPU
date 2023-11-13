-- VHDL 8 bit processor project
-- 3 bit counter test bench
-- James Hicks November 11 2023

--NOTE::input must be stable for 3 max ticks to increment

library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture tb_arch of tb is

  signal clk, btn, rst : std_logic := '0';
  signal cnt           : std_logic_vector(2 downto 0);
  constant clk_period  : time := 10 ns;

begin

  threebitcounter : entity work.threebitcounter(two_seg)
    port map( clk => clk,
              btn => btn,
              rst => rst,
              cnt => cnt
            );

  clk_process : process
  begin
    loop
      wait for clk_period / 2;
      clk <= not clk;
    end loop;
  end process;

  btn_process : process
  begin
    btn <= '1';
    wait for 1550 ns;  -- Simulate button press for 100 ns
    btn <= '0';
    wait for 1550 ns;  -- Simulate button release for 100 ns
  end process;

  rst_process : process
  begin
    rst <= '1';
    wait until rising_edge(clk);
    rst <= '0';
    wait;
  end process;

  termination_process : process
  begin
    wait for 500000 ns;
    assert false report "end of test" severity failure;
  end process;

end tb_arch;
