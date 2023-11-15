-- VHDL 8 bit processor project
-- 3 bit counter test bench
-- James Hicks November 11 2023

library ieee;
use ieee.std_logic_1164.all;

entity tb_alt is
end tb_alt;

architecture tb_arch of tb_alt is

  signal clk, btn, rst : std_logic := '0';
  signal cnt           : std_logic_vector(2 downto 0);
  constant clk_period  : time := 10 ns;

begin

  threebitcounter_alt : entity work.threebitcounter_alt
    port map( clk => clk,
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
