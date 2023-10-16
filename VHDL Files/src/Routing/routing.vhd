-- VHDL 8 bit processor project
-- 4 x 2 encoder
-- James Hicks Oct 15 2023

library ieee;
use ieee.std_logic_1164.all;

entity encoder_4x2 is
  port(r : in std_logic_vector(3 downto 0);
       e : out std_logic_vector(1 downto 0);
       v : out std_logic);
end encoder_4x2;

architecture cond_arch of encoder_4x2 is
begin

  v <= '0' when r = "0000" else
       '1';

  e <= "11" when r(3) = '1' else
       "10" when r(2) = '1' else
       "01" when r(1) = '1' else
       "00";

end cond_arch;

architecture sel_arch of encoder_4x2 is
begin

  v <= '1' when r /= "0000" else
       '0';

  with r select (e) <=
    "11" when "1000" | "1001" | "1010" | "1011" |
              "1100" | "1101" | "1110" | "1111",
    "10" when "0100" | "0101" | "0110" | "0111",
    "01" when "0010" | "0011",
    "00" when others;

end sel_arch;

architecture if_arch of encoder_4x2 is
begin

  process(r)
  begin
    if r(3) = '1' then
      e <= "11";
      v <= '1';
    elsif r(2) = '1' then
      e <= "10";
      v <= '1';
    elsif r(1) = '1' then
      e <= "01";
      v <= '1';
    elsif r(0) = '1' then
      e <= "00";
      v <= '1';
    else
      e <= "00";
      v <= '0';
    end if;
  end process;

end if_arch;

architecture case_arch of encoder_4x2 is
begin

  process(r)
  begin
    case r is
      when "1000" | "1001" | "1010" | "1011" |
           "1100" | "1101" | "1110" | "1111" =>
        e <= "11";
        v <= '1';
      when  "0100" | "0101" | "0110" | "0111" =>
        e <= "10";
        v <= '1';
      when "0010" | "0011" =>
        e <= "01";
        v <= '1';
      when "0001" =>
        e <= "00";
        v <= '1';
      when others =>
        e <= "00";
        v <= '0';
      end case;
  end process;
end case_arch;
