-- VHDL 8 bit processor project
-- zero blanker
-- James Hicks Oct 18 2023

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zero_blanker is
  port (input : in std_logic_vector(7 downto 0);
        output : out std_logic_vector(7 downto 0));
end zero_blanker;

architecture my_arch of zero_blanker is

begin

  output <= "11111111" when input = "10000001" else
            input;

end my_arch;
