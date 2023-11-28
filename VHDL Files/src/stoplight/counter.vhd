library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity counter is
  port (clr        : in  std_logic;
        en         : in  std_logic;
        clk        : in  std_logic;
        state      : in  std_logic_vector(1 downto 0);
        tick_four  : out std_logic;
        tick_ten   : out std_logic;
        cnt        : out std_logic_vector(3 downto 0));
end counter;

architecture my_arch of counter is

  signal tick_sec : std_logic;
  signal count_four, count_ten : std_logic_vector(3 downto 0);

begin

  one_sec_counter : entity work.ctrstg(my_arch)
    generic map(max   => 100000000,
                width => 27)
    port map (clr  => clr,
              en   => en,
              clk  => clk,
              tick => tick_sec,
              cnt  => open );

  four_sec_counter : entity work.ctrstg(my_arch)
    generic map(max   => 4,
                width => 4)
    port map (clr  => clr,
              en   => tick_sec,
              clk  => clk,
              tick => tick_four,
              cnt  => count_four );

  ten_sec_counter : entity work.ctrstg(my_arch)
    generic map(max   => 10,
                width => 4)
    port map (clr  => clr,
              en   => tick_sec,
              clk  => clk,
              tick => tick_ten,
              cnt  => count_ten);

  with state select cnt <=
    count_four when "01",
    count_four when "11",
    count_ten  when others;

end my_arch;
