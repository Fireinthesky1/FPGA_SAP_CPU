-- VHDL 8 bit processor project
-- 3 bit counter test bench
-- James Hicks November 11 2023

library ieee;
use ieee.std_logic_1164.all;

entity tb is
end tb;

architecture tb_arch of tb is

  signal clk, btn, rst : std_logic := '0';
  signal cnt           : std_logic_vector(2 downto 0);
  constant clk_period  : time := 10 ns;

begin

  threebitcounter : entity work.threebitcounter(my_arch)
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
    wait for 10000 ns;
    btn <= not btn;
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
    wait for 200000 ns;
    assert false report "end of test" severity failure;
  end process;

end tb_arch;
