library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity debouncer is
  port ( sw        : in  std_logic;
         rst       : in  std_logic;
         clk       : in  std_logic;
         db        : out std_logic );
end debouncer;

architecture my_arch of debouncer is

  type state_type is ( zero, one,
                       w1_0, w1_1,
                       w0_0, w0_1 );
  signal r_pres, r_next : state_type;
  signal tick           : std_logic;

begin

  tick_generator : entity work.ten_ms(my_arch)
    generic map (max   => 3,
                 width => 2)
    port map ( clk => clk,
               rst => rst,
               en  => '1',
               tick => tick);

  process(clk, rst)
  begin
    if(rst = '1') then
      r_pres <= zero;
    elsif(rising_edge(clk)) then
      r_pres <= r_next;
    end if;
  end process;

  process(r_pres, sw, tick)
  begin
  -- DEFAULTS
    r_next <= r_pres;
    db     <= '0';

    case r_pres is

      when zero =>
        if(sw = '1') then
          r_next <= w1_0;
        else
          r_next <= zero;
        end if;

      when w1_0 =>
        if(sw = '1' and tick = '1') then
          r_next <= w1_1;
        else
          r_next <= zero;
        end if;

      when w1_1 =>
        if(sw = '1' and tick = '1') then
          r_next <= one;
        else
          r_next <= zero;
        end if;

      when one  =>
        if(sw = '0') then
          r_next <= w0_0;
        else
          r_next <= one;
        end if;
        db <= '1';

      when w0_0 =>
        if(sw = '0' and tick = '1') then
          r_next <= w0_1;
        else
          r_next <= one;
        end if;
        db <= '1';

      when w0_1 =>
        if(sw = '0' and tick = '1') then
          r_next <= zero;
        else
          r_next <= one;
        end if;
        db <= '1';

    end case;
  end process;

end my_arch;
