library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ed is
  port (clk    : in  std_logic;
        rst    : in  std_logic;
        input  : in  std_logic;
        tick   : out std_logic );
end ed;

architecture my_arch of ed is
  type state_type is (zero, pos_edge, one);
  signal r_pres, r_next : state_type;
begin

  process(clk, rst)
  begin
    if(rst = '1') then
      r_pres <= zero;
    elsif (rising_edge(clk)) then
      r_pres <= r_next;
    end if;
  end process;

  process(input, r_pres)
  begin
    --DEFAULTS
    r_next <= r_pres;
    tick <= '0';
    case r_pres is
      when zero =>
        if(input = '1') then
          r_next <= pos_edge;
        end if;

      when pos_edge =>
        tick <= '1';
        r_next <= one;

      when one =>
        if(input = '0') then
          r_next <= zero;
        end if;

    end case;
  end process;

end my_arch;
