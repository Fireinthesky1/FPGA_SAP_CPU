library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture tb of tb is

  signal clr, en, clk, tick : std_logic := '0';
  signal cnt : std_logic_vector (9 downto 0);
  constant clk_period : time := 10 ns;

begin

  DUT : entity work.ctrstg(my_arch)
    generic map ( max  => 200,
                  width => 10 )
    port map ( clr  => clr,
               en   => en,
               clk  => clk,
               tick => tick,
               cnt  => cnt );

  clk_process : process
  begin
    loop
      wait for clk_period / 2;
      clk <= not clk;
    end loop;
  end process;

  en_process : process
  begin
    wait for clk_period;
    en <= '1';
    wait;
  end process;

  clr_process : process
  begin
    clr <= '1';
    wait for clk_period;
    clr <= '0';
    wait;
  end process;

  termination : process
  begin
    wait for 100000 ns;
    assert false report "Test Complete" severity failure;
  end process;

end tb;
