library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity counter is
  port (clr        : in  std_logic := '0';
        en         : in  std_logic := '0';
        clk        : in  std_logic := '0';
        state      : in  std_logic_vector(1 downto 0) := "00";
        tick_four  : out std_logic := '0';
        tick_ten   : out std_logic := '0';
        cnt        : out std_logic_vector(3 downto 0) := "0000");
end counter;

architecture my_arch of counter is

  signal tick_sec : std_logic := '0';
  signal count_four, count_ten : std_logic_vector(3 downto 0):=(others => '0');

begin

  one_sec_counter : entity work.ctrstg(my_arch)
    generic map(max   => 10000000,  --TODO::CHANGE TO 8 FOR TESTBENCH
                width => 27)        --TODO::CHANGE TO 4 FOR TESTBENCH
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
