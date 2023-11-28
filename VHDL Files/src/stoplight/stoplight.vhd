library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity stoplight is
  port (car  : in  std_logic;
        rst  : in  std_logic;
        clk  : in  std_logic;
        main : out std_logic_vector(2 downto 0);
        side : out std_logic_vector(2 downto 0);
        cnt  : out std_logic_vector(3 downto 0));
end stoplight;

architecture my_arch of stoplight is
  signal tick_ten, tick_four : std_logic;
  signal count_en, count_clr : std_logic;
  signal state : std_logic_vector(1 downto 0);
begin

  counter : entity work.counter(my_arch)
    port map (clr       => count_clr,
              en        => count_en,
              clk       => clk,
              tick_four => tick_four,
              tick_ten  => tick_ten,
              cnt       => cnt,
              state     => state);

  control : entity work.control(my_arch)
    port map (clk       => clk,
              rst       => rst,
              car       => car,
              tick_ten  => tick_ten,
              tick_four => tick_four,
              count_en  => count_en,
              count_clr => count_clr,
              main      => main,
              side      => side,
              state     => state);

end my_arch;
