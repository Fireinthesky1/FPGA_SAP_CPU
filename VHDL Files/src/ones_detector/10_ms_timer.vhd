library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ten_ms is
  generic (max   :     integer   := 1000000;
           width :     integer   := 20);
  port    (clk   : in  std_logic := '0';
           rst   : in  std_logic := '0';
           en    : in  std_logic := '0';
           tick  : out std_logic := '0');
end ten_ms;

architecture my_arch of ten_ms is
  signal r_next, r_pres : unsigned (width-1 downto 0) := (others => '0');
begin

  process (clk, rst)
  begin
    if(rst = '1') then
      r_pres <= (others => '0');
    elsif(rising_edge(clk)) then
      r_pres <= r_next;
    end if ;
  end process;

  --NEXT STATE LOGIC
  r_next <= (others => '0')when(((r_pres = max)and(en = '1')) or rst = '1') else
            r_pres + 1      when en ='1' else
            r_pres;

  tick <= '1' when r_pres = max else '0';

end my_arch;
