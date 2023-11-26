library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity three_ones is
  port( sw  : in  std_logic;
        clk : in  std_logic;
        rst : in  std_logic;
        y   : out std_logic );
end three_ones;

architecture my_arch of three_ones is

  type   state_type is (zero, one, two, three);
  signal r_pres, r_next : state_type := zero;
  signal db, tick : std_logic;

begin

  debouncer : entity work.debouncer(my_arch)
    port map ( sw  => sw,
               rst => rst,
               clk => clk,
               db  => db);

  edge_detector : entity work.ed(my_arch)
    port map ( clk   => clk,
               rst   => rst,
               input => db,
               tick  => tick);

  process(clk, rst)
  begin
    if(rst  = '1') then
      r_pres <= zero;
    elsif(rising_edge(clk)) then
      r_pres <= r_next;
    end if;
  end process;

  process (tick, r_pres)
  begin

    --DEFAULTS
    r_next <= zero;
    y <= '0';

    case r_pres is
      when zero =>
        if(tick = '1') then
          r_next <= one;
        end if;

      when one =>
        if(tick = '1') then
          r_next <= two;
        end if;

      when two =>
        if(tick = '1') then
          r_next <= three;
        end if;

      when three =>
        if(tick = '1') then
          r_next <= r_pres;
        end if;
        y <= '1';

    end case;
  end process;

end my_arch;
