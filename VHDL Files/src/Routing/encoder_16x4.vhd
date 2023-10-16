-- VHDL 8 bit processor project
-- 16 x 4 encoder
-- James Hicks Oct 15 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder_16x4 is
  port(r : in std_logic_vector (15 downto 0);
       e : out std_logic_vector (3 downto 0);
       v : out std_logic);
end encoder_16x4;

architecture my_arch of encoder_16x4 is

  signal d_3, d_2, d_1, d_0, v_d : std_logic_vector(1 downto 0);
  signal o_3, o_2, o_1, o_0, v_not_d : std_logic_vector(3 downto 0);
  signal twelve, eight, four : unsigned(3 downto 0);

begin

  dec_3 : entity work.encoder_4x2(cond_arch)
   port map (
     r => r (15 downto 12),
     e => d_3,
     v => v_not_d(3)
     );

  dec_2 : entity work.encoder_4x2(sel_arch)
   port map (
     r => r (11 downto 8),
     e => d_2,
     v => v_not_d(2)
     );

  dec_1 : entity work.encoder_4x2(if_arch)
   port map (
     r => r (7 downto 4),
     e => d_1,
     v => v_not_d(1)
     );

  dec_0 : entity work.encoder_4x2(case_arch)
   port map (
     r => r (3 downto 0),
     e => d_0,
     v => v_not_d(0)
     );

  valid_decoder : entity work.encoder_4x2(sel_arch)
    port map(
      r => v_not_d,
      e => v_d,
      v => v
      );

  twelve <= "1100";
  eight <= "1000";
  four <= "0100";

  with v_d select e <=
    std_logic_vector(twelve + unsigned(d_3)) when "11",
    std_logic_vector(eight + unsigned(d_2)) when "10",
    std_logic_vector(four + unsigned(d_1)) when "01",
    std_logic_vector("00" & d_0) when "00",
    "0000" when others;
end my_arch;
