library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity stoplight_tb is
end stoplight_tb;

architecture tb of stoplight_tb is

  --COUNTER SIGNALS
  signal clk, t_4, t_10 : std_logic := '0';
  signal state : std_logic_vector(1 downto 0) := "00";
  signal cnt  : std_logic_vector(3 downto 0) := "0000";

  --CONTROL SIGNALS
  signal rst, car, count_en, count_clr : std_logic := '0';
  signal main, side : std_logic_vector( 2 downto 0 );

  constant clk_period : time := 10 ns;

begin

  counter : entity work.counter(my_arch)
    port map(clr       => count_clr,
             en        => count_en,
             clk       => clk,
             state     => state,
             tick_four => t_4,
             tick_ten  => t_10,
             cnt       => cnt);

  control : entity work.control(my_arch)
    port map(clk       => clk,
             rst       => rst,
             car       => car,
             tick_ten  => t_10,
             tick_four => t_4,
             count_en  => count_en,
             count_clr => count_clr,
             state     => state,
             main      => main,
             side      => side );

  clk_process : process
  begin
    wait for clk_period / 2;
    clk <= not clk;
  end process;

  rst_process : process
  begin
    rst <= '0';
    wait;
  end process;

  car_process : process
  begin
    wait for clk_period * 100;
    car <= not car;
  end process;

  termination : process
  begin
    wait for clk_period * 10000;
    assert false report "end of test" severity failure;
  end process;
end tb;
