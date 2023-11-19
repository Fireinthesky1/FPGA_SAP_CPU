library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sw_tb is
end sw_tb;

architecture tb of sw_tb is
  signal clk, en, clr, fast : std_logic := '0';
  signal sseg, anode        : std_logic_vector(7 downto 0) := (others => '0');
  constant clk_period : time := 10 ns;
begin

  DUT : entity work.stopwatch(my_arch)
    port map ( clk   => clk,
               en    => en,
               clr   => clr,
               fast  => fast,
               sseg  => sseg,
               anode => anode );

  clk_process : process
  begin
    wait for clk_period / 2;
    clk <= not clk;
  end process;

  en_process : process
  begin
    en <= '1';
    wait;
  end process;

  clr_process : process
  begin
    clr <= '1';
    wait for clk_period * 2;
    clr <= '0';
    wait;
  end process;

  fast_process : process
  begin
    wait for clk_period * 5000;
    fast <= '1';
    wait;
  end process;

  termination_process : process
  begin
    wait for clk_period * 100000;
    assert false report "Test Complete" severity failure;
  end process;

end tb;
