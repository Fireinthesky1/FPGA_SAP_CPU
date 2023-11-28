library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
  port(clk       : in  std_logic;
       rst       : in  std_logic;
       car       : in  std_logic;
       tick_ten  : in  std_logic;
       tick_four : in  std_logic;
       count_en  : out std_logic;
       count_clr : out std_logic;
       state     : out std_logic_vector (1 downto 0);
       main      : out std_logic_vector(2 downto 0);
       side      : out std_logic_vector(2 downto 0));
end control;

architecture my_arch of control is
  type state_type is (mg_sr, my_sr, mr_sg, mr_sy);
  signal r_pres, r_next : state_type;
begin

-- register stuff
  process(clk, rst)
  begin
    if(rst = '1') then
      r_pres <= mg_sr;
    elsif(rising_edge(clk)) then
      r_pres <= r_next;
    end if;
  end process;

  -- state machine
  process(r_pres, car, tick_ten, tick_four)
  begin
    -- DEFAULTS
    count_en  <= '1';
    count_clr <= '0';
    r_next <= r_pres; --??

    case r_pres is

      when mg_sr =>
        main <= "001";
        side <= "100";
        state <= "00";
        if(tick_ten = '1') then
          if(car = '1') then
            count_clr <= '1';
            r_next <= my_sr;
          else
            count_en <= '0';
          end if;
        end if;

      when my_sr =>
        main <= "010";
        side <= "001";
        state <= "01";
        if(tick_four = '1') then
          count_clr <= '1';
          r_next <= mr_sg;
        end if;

      when mr_sg =>
        main <= "100";
        side <= "001";
        state <= "10";
        if(car = '1') then
          if(tick_ten = '1') then
            count_clr <= '1';
            r_next <= mr_sy;
          end if;
        else
          count_clr <= '1';
          r_next <= mr_sy;
        end if;

      when mr_sy =>
        main <= "100";
        side <= "010";
        state <= "11";
        if(tick_four = '1') then
          count_clr <= '1';
          r_next <= mg_sr;
        end if;

    end case;
  end process;

end my_arch;
