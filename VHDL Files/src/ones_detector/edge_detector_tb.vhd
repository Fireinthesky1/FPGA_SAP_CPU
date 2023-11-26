library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ed_tb is
end ed_tb;

architecture tb of ed_tb is
  signal test_sw      : std_logic := '0';
  signal test_clk     : std_logic := '0';
  signal test_rst     : std_logic := '0';
  signal test_tick    : std_logic := '0';
  signal test_db      : std_logic := '0';
  constant clk_period : time      := 10 ns;
begin

  debouncer : entity work.debouncer(my_arch)
    port map ( sw  => test_sw,
               rst => test_rst,
               db  => test_db,
               clk => test_clk );

  DUT : entity work.ed(my_arch)
    port map ( clk   => test_clk,
               rst   => test_rst,
               input => test_db,
               tick  => test_tick );

  clk_process : process
  begin
    wait for clk_period / 2;
    test_clk <= not test_clk;
  end process;

  sw_process : process
  begin
    for i in 0 to 20 loop
      wait for 1 ns;
      test_sw <= not test_sw;
    end loop;
    wait for 100 ns;
  end process;

  rst_process : process
  begin
    wait;
  end process;

  termination : process
  begin
    wait for 1000000 ns;
    assert false report "end of test" severity failure;
  end process;


end tb;

