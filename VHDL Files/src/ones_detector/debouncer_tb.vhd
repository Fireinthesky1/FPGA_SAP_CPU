library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture my_arch of tb is
  signal   test_sw    : std_logic := '1';
  signal   test_rst   : std_logic := '0';
  signal   test_clk   : std_logic := '0';
  signal   test_db    : std_logic := '0';
  constant clk_period : time := 10 ns;
begin

  DUT : entity work.debouncer(my_arch)
    port map ( sw  => test_sw,
               rst => test_rst,
               clk => test_clk,
               db  => test_db );

  sw_process : process
  begin
    for i in 0 to 21 loop
      wait for 1 ns;
      test_sw <= not test_sw;
    end loop;
    wait for 20 ms;
  end process;

  rst_process : process
  begin
    wait;
  end process;

  clk_process : process
  begin
    wait for clk_period / 2;
    test_clk <= not test_clk;
  end process;

  kill_process : process
  begin
    wait for 100000 ns;
    assert false report "end of test" severity failure;
  end process;

end my_arch;
