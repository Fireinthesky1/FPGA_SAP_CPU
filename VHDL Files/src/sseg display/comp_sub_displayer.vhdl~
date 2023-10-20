-- VHDL 8 bit processor project
-- comparitor/subtractor displayer
-- James Hicks Oct 18 2023

-- We want to take in two 4 bit unsigned numbers
-- display the largest in the left most two ssegs
-- display the smaller in the next to ssegs
-- display the difference in the rightmost ssegs
-- Blank leading zeros
-- Add an extra input button,
  -- when this button is pushed instead of subtracting
  -- we add

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comp_sub_display is
  num1, num2 : in std_logic_vector (3 downto 0);
  a_s : in std_logic;
  large, small, sum_diff : out std_logic_vector (7 downto 0);
end comp_sub_display;

architecture my_arch of comp_sub_display is

  signal large_int, small_int : std_logic_vector(3 downto 0);
  signal sum_diff_int : std_logic_vector(3 downto 0);
  signal msb_l_int, lsb_l_int : std_logic_vector(3 downto 0);
  signal msb_s_int, lsb_s_int : std_logic_vector(3 downto 0);
  signal msb_sd_int, lsb_sd_int : std_logic_vector(3 downto 0);
  signal unblanked_large_msb : std_logic_vector(7 downto 0);
  signal unblanked_small_msb : std_logic_vector(7 downto 0);
  signal unblanked_sumdiff_msb : std_logic_vector(7 downto 0);

begin

  -- comparitor
  comp : entity work.four_bit_comparitor(my_arch)
    port map (num1 => num1,
              num2 => num2,
              large => large_int,
              small => small_int);

  -- adder subtractor
  with a_s select sum_diff_int <=
    std_logic_vector(unsigned(large_int) + unsigned(small_int)) when '0',
    std_logic_vector(unsigned(large_int) - unsigned(small_int)) when others;

  --series of digit separators
  large_separator : entity work.digit_separator(my_arch)
    port map (input => large_int,
              msb => msb_l_int,
              lsb => lsb_l_int);

  small_separator : entity work.digit_separator(my_arch)
    port map (input => small_int,
              msb => msb_s_int,
              lsb => lsb_s_int);

  sum_diff_separator : entity work.digit_separator(my_arch)
    port map (input => sum_diff_int,
              msb => msb_sd_int,
              lsb => lsb_sd_int);

  msb_large : entity work.hex_to_sseg(Behavioral)
    port map (hex => msb_l_int,
              dp => '1',
              sseg => unblanked_large_msb);

  lsb_large : entity work.hex_to_sseg(Behavioral)
    port map (hex => lsb_l_int,
              dp => '1',
              sseg =>); -- <- come back an assign

  msb_small : entity work.hex_to_sseg(Behavioral)
    port map (hex => msb_s_int,
              dp => '1',
              sseg => unblanked_small_msb);

  lsb_small : entity work.hex_to_sseg(Behavioral)
    port map (hex => lsb_s_int,
              dp => '1',
              sseg =>); -- <- come back and assign

  msb_sum_diff : entity work.hex_to_sseg(Behavioral)
    port map (hex => msb_sd_int,
              dp => '1',
              sseg => unblanked_sumdiff_msb);

  lsb_sum_diff : entity work.hex_to_sseg(Behavioral)
    port map (hex => lsb_sd_int,
              dp => '1',
              sseg =>); -- <- come back and assign

  -- zero blankers
  large_zero_blanker : entity work.zero_blanker(my_arch)
    port map (input => unblanked_large_msb,
              output =>); --<- come back and assign


  small_zero_blanker : entity work.zero_blanker(my_arch)
    port map (input => unblanked_small_msb,
              output =>); --<- come back and assign


  sumdiff_zero_blanker : entity work.zero_blanker(my_arch)
    port map (input => unblanked_sumdiff_msb,
              output =>); --<- come back and assign

end my_arch;
