-- VHDL 8 bit processor project
-- T Flip Flop
-- James Hicks November 11 2023

library ieee;
use ieee.std_logic_1164.all;

entity t_ff is
    Port ( t   : in STD_LOGIC;
           en  : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           q   : out STD_LOGIC);
end t_ff;

-- two segment architecture
architecture two_seg_arch of t_ff is

signal q_pres, q_next : std_logic;

begin

  t_ff_process: process( clk, rst ) -- en is not in list
  begin
      if (rst = '1') then
          q_pres <= '0';
      elsif (clk'event and clk='1') then
        if(en = '1') then
          q_pres <= q_next;
        end if;
      end if;
  end process;

  -- next state logic
  q_next <= (t xor q_pres) when en='1' else
            (q_pres and (not en));

 -- output logic
  q <= q_pres;

end two_seg_arch;
